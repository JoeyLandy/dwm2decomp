; ROM bank $05: battle AI: per-skill scoring routines (AIScore_*) and their conditions
; The annotated listing of this bank is build/listing/bank05.asm.

SECTION "Bank 05", ROMX[$4000], BANK[$05]
    db $05

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
GetBattleATK_Bank05::
    ld hl, wBattleATK
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0064)
GetBattleDEF_Bank05::
    ld hl, wBattleDEF
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
GetBattleMaxHP_Bank05::
    ld hl, wBattleMaxHP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
GetBattleMaxMP_Bank05::
    ld hl, wBattleMaxMP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0064)
GetBattleHP_Bank05::
    ld hl, wBattleHP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
GetBattleMP_Bank05::
    ld hl, wBattleMP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0064)
GetBattleAGL_Bank05::
    ld hl, wBattleAGL
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 5 banks)
ReadSlotAIModeIndexed_Bank05_4024::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

ReadSlotAIModeIndexed_Bank05_4024_Skip::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank05::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank05::
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
TargetOnLocalSide_Bank05::
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

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
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

; cost = wRecordBufferData (byte 0 of the skill record): C = $FF (can pay) when the cost is 0, when
; the cost is $FF and the actor's MP (wBattleMP word) is non-zero, or when MP >= cost; C = 0
; otherwise. Agrees with CheckSkillMPCost that equal MP and cost is enough (E-0063)
ActorCanPayMPCost_Bank05::
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

; C = 0 when bit 6 of wRecordBufferData + $5 (skill record buffer) is set and the actor's status
; byte 1 (wBattleStatus1) bit 0 is set, else $FF (compare refusal code 3 of CheckSkillMPCost)
; (E-0071)
SkillPassesStatus1Bit0Check::
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
    ld c, $ff
    ret

; C = $00 when bit 4 of wRecordBufferData + $5 and bit 7 of the actor's status byte 0 are both set,
; else $FF (E-0122)
PassUnlessWCFF3Bit4AndActorStatusBit7::
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
    ld c, $ff
    ret

; C = $00 when bit 5 of wRecordBufferData + $5 and bit 6 of the actor's status byte 0 are both set,
; else $FF (E-0122)
PassUnlessWCFF3Bit5AndActorStatusBit6::
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
    ld c, $ff
    ret

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

; meant to return C = $FF when one of the actor's three opposite slots is present with non-zero MP
; and 0 otherwise, but it addresses the MP word at wBattleMP + 16 * slot (swap a) instead of 2 *
; slot, so for foes in slots 4-6 it reads 64-96 bytes past the array (a likely bug; executed, test
; FoeMPCheckOffset) (E-0099)
AnyFoeHasMPReadsWrongOffset::
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

AIScore_TakeMagic_Conditions_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus)
; bit 6 clear (AnySlotLacksStatusMask), else 0 (E-0071)
AnyFoeLacksStatus0Bit6::
    ld hl, wBattleStatus
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

; C = 1 when wSlotAIMode[actor] (the AI mode) is below 2; otherwise C = $FF when one of the actor's
; three opposite slots is present with status byte 1 (wBattleStatus1) bit 0 clear and a skill whose
; record part has bit 6 set (SlotHasSkillWithFlagD, D = $40), else 0; wRecordBuffer kept (E-0099)
AnyActiveFoeHasSkillFlag40::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

; C = 1 when the AI mode is below 2; otherwise C = $FF when one of the actor's three opposite slots
; is present with a skill whose record part has bit 4 set (SlotHasSkillWithFlagD, D = $10), else 0;
; wRecordBuffer kept (E-0099)
AnyFoeHasSkillFlag10::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

AIScore_DanceShut_Conditions_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

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

AIScore_SquallHit_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

AIScore_FireAir_Sub02_AnySlotLacksStatusMask::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus2
    ld e, $40
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 4 clear
; (AnySlotLacksStatusMask), else 0 (E-0114)
AnyFoeLacksStatus0Bit4::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotLacksStatusMask
    ret

AIScore_PoisonAir_Conditions_AnySlotLacksStatusMask::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus
    ld e, $02
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus)
; & $03 clear (AnySlotLacksStatusMask), else 0 (E-0099)
AnyFoeLacksStatus0Bits01::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotLacksStatusMask
    ret

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

AIScore_AquaWall_Conditions_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) & $03 clear (AnySlotLacksStatusMask), else 0 (E-0094)
AnyFoeLacksStatus5Bits01::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus5
    ld e, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) bit 0 clear and status byte 1 (wBattleStatus1) bit 1 clear, else 0 (E-0094)
AnyFoeLacksStatus5Bit0And1Bit1::
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

; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) bit 1 clear and status byte 1 (wBattleStatus1) bit 1 clear, else 0 (E-0094)
AnyFoeLacksStatus5Bit1And1Bit1::
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

; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) & $03 clear and status byte 1 (wBattleStatus1) bit 1 clear, else 0 (E-0100)
AnyFoeLacksStatus5Bits01And1Bit1::
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

; C = $FF when one of the actor's three opposite slots is present with status byte 1
; (wBattleStatus1) bit 0 clear, else 0 (E-0099)
AnyFoeLacksStatus1Bit0::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $01
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 1
; (wBattleStatus1) bit 7 clear, else 0 (E-0099)
AnyFoeLacksStatus1Bit7::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $80
    call AnySlotLacksStatusMask
    ret

AIScore_DanceShut_Conditions_AnySlotLacksStatusMask::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

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

AIScore_LegSweep_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

; C = 1 when the AI mode is below 2; in mode 3 with wRecordBufferData + $1 set, $00 when a foe has
; status 1 mask $22; otherwise $FF (E-0125)
AIGateFoeStatus1Mask22::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
    jr c, .done3
    call TestWCFEF
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

AIScore_FireAir_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
    jr c, .done3
    call TestWCFEF
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

; C = 0 when the actor's status byte 4 (wBattleStatus4) & $03 is set, else C = $FF (the correct form
; of the test ActorStatus4CheckReadsAddress gets wrong) (E-0094)
ActorLacksStatus4Bits01::
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

; C = 0 when the actor's status byte 1 (wBattleStatus1) bit 2 is set, else C = $FF (E-0094)
ActorLacksStatus1Bit2::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

; C = 0 when the actor's status byte 1 (wBattleStatus1) bit 3 is set, else C = $FF (E-0094)
ActorLacksStatus1Bit3::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 3, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

AIScore_TakeMagic_Conditions_AddAx9ToHL::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 0, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

AIScore_TailWind_Conditions_AddAx9ToHL::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 6, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

; C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2
; (wBattleStatus2) bit 6 clear, else 0 (E-0099)
AnyAllyLacksStatus2Bit6::
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld e, $40
    ld hl, wBattleStatus2
    call AnySlotLacksStatusMask
    ret

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
    bit 6, [hl]
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

AIScore_Antidote_Conditions_AnySlotHasStatusMask::
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotHasStatusMask
    ret

AIScore_NumbOff_Conditions_AnySlotHasStatusMask::
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $cc
    call AnySlotHasStatusMask
    ret

AIScore_DeChaos_Conditions_AnySlotHasStatusMask::
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotHasStatusMask
    ret

AIScore_CurseOff_Conditions_AnySlotHasStatusMask::
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $20
    call AnySlotHasStatusMask
    ret

; walks the actor's own three slots through their 7-byte wSlotResistances + $4 entries: C = $FF when
; a present slot's entry & $3C is not $3C, else 0 (E-0094)
AnyAllyWDA76Bits2To5NotAllSet::
    ld a, [wBattleActor]
    and $04

AnyAllyWDA76Bits2To5NotAllSet_Skip::
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

AIScore_SuckAir_Conditions_ReadBattleActor::
    ld a, [wBattleActor]
    and $04
    xor $04
    jp AnyAllyWDA76Bits2To5NotAllSet_Skip

AIScore_SlimeBlow_Conditions_ToFoeOfFamilyEPresent::
    ld e, $00
    call FoeOfFamilyEPresent
    ret

AIScore_DrakSlash_Conditions_ToFoeOfFamilyEPresent::
    ld e, $01
    call FoeOfFamilyEPresent
    ret

AIScore_BeastCut_Conditions_ToFoeOfFamilyEPresent::
    ld e, $02
    call FoeOfFamilyEPresent
    ret

AIScore_BirdBlow_Conditions_ToFoeOfFamilyEPresent::
    ld e, $03
    call FoeOfFamilyEPresent
    ret

AIScore_BugBlow_Conditions_ToFoeOfFamilyEPresent::
    ld e, $05
    call FoeOfFamilyEPresent
    ret

AIScore_Shears_Conditions_ToFoeOfFamilyEPresent::
    ld e, $04
    call FoeOfFamilyEPresent
    ret

AIScore_DevilCut_Conditions_ToFoeOfFamilyEPresent::
    ld e, $06
    call FoeOfFamilyEPresent
    ret

AIScore_ZombieCut_Conditions_ToFoeOfFamilyEPresent::
    ld e, $07
    call FoeOfFamilyEPresent
    ret

AIScore_CleanCut_Conditions_ToFoeOfFamilyEPresent::
    ld e, $08
    call FoeOfFamilyEPresent
    ret

AIScore_AquaCut_Conditions_ToFoeOfFamilyEPresent::
    ld e, $09
    call FoeOfFamilyEPresent
    ret

AIScore_MetalCut_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

AIScore_UltraDown_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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
    bit 1, [hl]
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

; C = $FF when one of the actor's three opposite slots is present with status byte 1 bit 1 clear,
; status byte 5 & $03 clear and the low 2 bits of its wSlotResistances + $1 entry not 3, else 0
; (E-0099)
AnyFoeOpenToWDA73Field0::
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
    bit 1, [hl]
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

AIScore_StopSpell_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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
    bit 0, [hl]
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

; C = $FF when one of the actor's three opposite slots is present with non-zero MP
; (GetBattleMP_Bank05) and bits 3-2 of its wSlotResistances + $2 entry not both set, else 0 (E-0100)
AnyFoeWithMPOpenToWDA74Field1::
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

AIScore_Sap_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

AIScore_Slow_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

; C = $FF when one of the actor's three opposite slots is present with status byte 0 & $03 clear and
; the low 2 bits of its wSlotResistances + $4 entry not 3, else 0 (E-0099)
AnyFoeOpenToWDA76Field0::
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

; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 6 clear and
; bits 7-6 of its wSlotResistances + $5 entry not both set, else 0 (E-0099)
AnyFoeOpenToWDA77Field3::
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

AIScore_Curse_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

AIScore_DanceShut_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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
    bit 6, [hl]
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

; C = $FF when an occupied foe without status bit 7 has a skill with flag $10 and bits 6-7 of its
; wSlotResistances + $6 field below 3, else $00 (wRecordBuffer preserved) (E-0125)
AnyFoeWithSkillFlag10VulnerableWDA78::
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
    bit 7, [hl]
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

; C = $FF when an ally slot is marked out (wBattleSlotOut = 1) or an occupied ally has HP below a
; quarter of its max, else $00 (E-0125)
AnyAllyOutOrHPBelowQuarter::
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

AIScore_TatsuCall_Conditions_ReadBattleActor::
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

; C = $FF when one of the actor's side's three wBattleSlotOut bytes is 1, else 0 (E-0099)
AnyOwnSideSlotOutIs1::
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

; C = $FF when the fastest occupied foe's AGL exceeds 31 percent of the actor's AGL, else $00
; (E-0127)
FastestFoeAGLAbove31PercentOfActor::
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

; C = $FF when an occupied ally slot has HP at most three quarters of its max, else $00 (E-0124)
AnyAllyHPAtMostThreeQuarters::
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

; C = $FF when an occupied ally slot has MP at most three quarters of its max, else $00 (E-0124)
AnyAllyMPAtMostThreeQuarters::
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

AIScore_Upper_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
    ld a, [wBattleActor]
    and $04
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
    ld c, $ff
    ret

AIScore_Speed_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
    ld a, [wBattleActor]
    and $04
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
    ld c, $ff
    ret

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

; C = $FF in link battles or when every occupied foe's species is already flagged (TestSpeciesFlag),
; else $00 (E-0125)
NoUnflaggedFoeSpeciesOrLink::
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

; C = 1 when the AI mode (wSlotAIMode[actor]) is below 3; otherwise C = 0 when one of the actor's
; three opposite slots is present with status byte 7 (wBattleStatus7) bit 2 set, else $FF (E-0099)
CheckFoeStatus7Bit2::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = $FF when one of the actor's own three slots is present (the actor included) with status byte 1
; (wBattleStatus1) & $0C clear and status byte 4 & $03 clear, else 0 (E-0099)
AnyAllyLacksStatus1Bits23And4Bits01::
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

AIScore_MagicWall_Conditions_AnySlotLacksStatusMask::
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld e, $40
    ld hl, wBattleStatus8
    call AnySlotLacksStatusMask
    ret

AIScore_SideStep_Conditions_AddAx9ToHL::
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

AIScore_Surge_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

AIScore_DeMagic_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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

; C = 0 when wBattleKind is 4 or 5, else C = $FF (E-0094)
CheckBattleKindNot4Or5::
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

AIScore_SealPray_ReadQueuedActionId::
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

; C = $00 when an occupied foe's wAIDamageEstimates word is at least
; FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc for it, else $FF
; (E-0125)
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
    call FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc
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

FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc::
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

; HL = HL * A / 100 (24-bit intermediate: Multiply8By16 then Divide24ByA), A = the remainder
; (E-0114)
MultiplyHLByAPercent::
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ret

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

; C = 1 when the actor's AI mode is below 2; otherwise $FF when the allies' average AGL is at least
; the foes', else $00 (E-0124)
AllyAverageAGLAtLeastFoes::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = 1 when the AI mode is below 2; otherwise $FF when the foes' average DEF is at most twice the
; allies' average ATK, else $00 (E-0129)
PassIfFoeAverageDEFAtMostTwiceAllyATK::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = 1 when the AI mode is below 2; otherwise $FF when the lowest DEF among occupied foes is below
; twice the actor's ATK, else $00 (E-0128)
PassIfTwiceATKAboveLowestFoeDEF::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_Sub02::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
    jr c, .done3
    call AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty
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

; C = 1 when the AI mode is below 2; otherwise $FF when the able foes' average ATK is at most twice
; the allies' average DEF, else $00 (E-0129)
PassIfFoeAverageATKAtMostTwiceAllyDEF::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    call SlotStatus0Bit1OrStatus4Bits01
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

; C = $00 when the actor's HP is exactly 1 (CompareSlotHPWith1), else $FF (E-0122)
ActorHPIsNotOne::
    ld a, [wBattleActor]
    call CompareSlotHPWith1
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

; C = $FF when fewer than two occupied ally slots have exactly 1 HP, else $00 (E-0124)
FewerThanTwoAlliesAtHP1::
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

; C = 0 when the actor's status byte 4 (wBattleStatus4) & $30 is set, else C = $FF (E-0100)
ActorLacksStatus4Bits45::
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

; C = 1 when the AI mode is below 2; otherwise $00 when an occupied foe without status bit 7 knows
; skill $42, $43, $46 or $47, else $FF (E-0127)
FailIfFoeKnowsSkills42To47::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 7, [hl]
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

AIScore_Transform_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = 0
SetCToZero::
    ld c, $00
    ret

; C = 1 when the AI mode is below 2; otherwise $00 when a foe knowing skill $3D has 2 * MP + 2 *
; wBattleLevel at least the actor's HP, else $FF (E-0128)
FailIfFoeSkill3DThreatensActorHP::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = $FF when FailIfFoeAIDamageEstimatesAtLeastEstimate returns C = 0, else $00 (E-0122)
InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate::
    call FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

; C = $FF when 4 x the actor's MP is below 3 x its max MP (MP under three quarters of max), else 0
; (E-0100)
ActorMPBelowThreeQuarters::
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

AIScore_MagicBack_Conditions_AddAx9ToHL::
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

; link battles only: C = $00 when rule bits 7 and 6 of wLinkRules + $1 are set and the side's
; wLinkRuleWork57 flag (or wLinkRules + $2 bit 6) allows it; otherwise $FF (E-0124)
LinkRuleCheckWD044Bit6::
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
    ld hl, wLinkRuleWork57
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

; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 5 are set, and either
; wLinkRules + $2 bit 5 is clear or bit 5 is set in the actor side's byte wLinkRuleWork57[actor /
; 4]; otherwise C = $FF (E-0091)
CheckWD044RuleBit5::
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
    ld hl, wLinkRuleWork57
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

; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 4 are set, and either
; wLinkRules + $2 bit 4 is clear or bit 4 is set in the actor side's byte wLinkRuleWork57[actor /
; 4]; otherwise C = $FF (E-0091)
CheckWD044RuleBit4::
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
    ld hl, wLinkRuleWork57
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

; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 3 are set, and either
; wLinkRules + $2 bit 3 is clear or bit 3 is set in the actor side's byte wLinkRuleWork57[actor /
; 4]; otherwise C = $FF (E-0091)
CheckWD044RuleBit3::
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
    ld hl, wLinkRuleWork57
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

; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 2 are set, and either
; wLinkRules + $2 bit 2 is clear or bit 2 is set in the actor side's byte wLinkRuleWork57[actor /
; 4]; otherwise C = $FF (E-0091)
CheckWD044RuleBit2::
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
    ld hl, wLinkRuleWork57
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

; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 1 are set, and either
; wLinkRules + $2 bit 1 is clear or bit 1 is set in the actor side's byte wLinkRuleWork57[actor /
; 4]; otherwise C = $FF (E-0091)
CheckWD044RuleBit1::
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
    ld hl, wLinkRuleWork57
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

AIScore_MegaMagic_ReadLinkModeAndBattleActor::
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
    ld hl, wLinkRuleWork57
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

; C = $FF when another ally slot is occupied or the actor's own slot is empty; otherwise
; FewerThanTwoFoesPresent (E-0124)
AllySlotsCheckThenFewerThanTwoFoes::
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

; C = 1 when the AI mode is below 2; otherwise $00 when some occupied foe has CountSkillsInList6D1A
; non-zero, else $FF (E-0124)
AIModeAtLeast2AndFoeLacks6D1A::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

; C = 1 when wSlotAIMode[actor] (the AI mode) is below 3; otherwise C = 0 when one of the actor's
; three opposite slots is present with status byte 6 (wBattleStatus6) bit 3 set, else C = $FF
; (E-0092)
CheckFoeStatus6Bit3::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

AIScore_Sacrifice_GetBattleMaxHP_Bank05::
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

; compares twice the occupied foes' average ATK with the allies' average DEF; returns $00 or $FF in
; C (E-0130)
CompareFoeAverageATKWithAllyDEF::
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

; C = 1 when the AI mode is below 3; with exactly one other occupied ally that has at most 20 MP,
; checks its skills ($A0, $1E/$1F) and status; returns $00 or $FF (E-0129)
AIGateLoneAllyMPAndSkills::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 0, [hl]
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

; C = 1 when the AI mode is below 3; otherwise $00 when another able ally knows a skill $16-$1A but
; has less MP than its cost (HealSkillMPCosts), else $FF (E-0128)
FailIfAllyLacksMPForHealSkill::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 6, [hl]
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

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another slot of the actor's side
; can act, has status byte 1 bit 6 clear and knows a skill CountSkillsInList6D1A counts, else $FF
; (E-0175)
FailIfAbleAllyKnowsSkillList6D1A:: ; configured code entry (E-0175); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 6, [hl]
    jr nz, .loop2
    call CountSkillsInList6D1A
    jr z, .loop2
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's
; side knows skill $4D, $3D, $3E, $3F, $66, $67 ... and has less MP than its cost in
; AllySkillMPCosts_5AF8, else $FF (the pattern of FailIfAllyLacksMPForHealSkill) (E-0175)
FailIfAllyLacksMPForSkillList5AF8::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    ld hl, AllySkillMPCosts_5AF8
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

; FailIfAllyLacksMPForSkillList5AF8 compares an ally's MP (GetBattleMP_Bank05) with the byte at
; $5AF8 + E for the skill it found (E = position in its skill list $4D, $3D, $3E, $3F, $66, $67); 6
; bytes, then code (E-0228, C1)
; record: MP cost
AllySkillMPCosts_5AF8::
    db $0f ; id 0
    db $01 ; id 1
    db $1e ; id 2
    db $19 ; id 3
    db $14 ; id 4
    db $14 ; id 5

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's
; side has status byte 1 bit 7 clear and knows skill $42, $43, $46 or $47, else $FF; no traced
; caller (E-0228)
FailIfAbleAllyKnowsSkill42To47:: ; configured code entry (E-0228); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 7, [hl]
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

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's
; side has status byte 1 bit 6 set and knows skill $78-$7D or $92, else $FF; no traced caller
; (E-0228)
FailIfAbleAllyWithStatus6KnowsSkill78To92::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 6, [hl]
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

AIScore_BeDragon_GetBattleMaxHP_Bank05::
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

; C = $FF when the actor knows skill $83 or no occupied ally has an active status effect, else $00
; (E-0125)
PassIfSkill83OrNoAllyHasStatus::
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

; C = $00 when an occupied foe's HP is at most four fifths of its wAIDamageEstimates word, else $FF
; (E-0125)
FailIfFoeHPAtMostFourFifthsAIDamageEstimates::
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

AIScore_MegaMagic_ReadLinkMode::
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

; C = $FF when the side's wSide0Flag/wSide1Flag flag is 1 or another ally slot is empty, else $00
; (E-0124)
PassIfSide0FlagOrAllySlotEmpty::
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

; C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2
; (wBattleStatus2) bit 2 clear (AnySlotLacksStatusMask), else 0 (E-0100)
AnyAllyLacksStatus2Bit2::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $04
    call AnySlotLacksStatusMask
    ret

; the same test as AnyAllyLacksStatus2Bit2: C = $FF when one of the actor's own three slots (the
; actor included) is present with status byte 2 bit 2 clear. It computes the side with `and a, $04`
; twice where the opposite-side predicates use `and a, $04 / xor a, $04`, so it probably meant the
; foes (a possible slip; not executed) (E-0100)
AnyAllyLacksStatus2Bit2_5D31::
    ld a, [wBattleActor]
    and $04
    and $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $04
    call AnySlotLacksStatusMask
    ret

; C = 1 when the AI mode is below 3; otherwise $00 when an occupied foe has HP at least 1.5 times
; the actor's, else $FF (E-0125)
FailIfFoeHPAtLeast150PercentOfActor::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = $00 when wLinkMode is 0 and bit 3 of hPlayerStateFlags is set, else $FF (E-0122)
FailIfLinkModeZeroAndPlayerStateFlagsBit3::
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

; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 7 clear and
; bits 7-6 of its wSlotResistances + $2 entry not both set, else 0 (E-0100)
AnyFoeOpenToWDA74Field3::
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
    bit 7, [hl]
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

; C = $FF when an occupied foe has a zero wBattleStatus3 byte and bits 2-3 of its wSlotResistances +
; $5 field below 3, else $00 (E-0124)
AnyFoeVulnerableByWDA77Bits23::
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

AIScore_EerieLite_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
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
    bit 7, [hl]
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

; C = $FF when wBattleTurn is non-zero, else $00 (E-0122)
PassIfBattleTurnNonZero::
    ld a, [wBattleTurn]
    and a
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

; C = the result for foes with status byte 4 & $0C clear; when that is non-zero, C = the result for
; foes with status byte 3 & $C0 clear (both through AnySlotLacksStatusMask) (E-0120)
AnyFoeLacksStatus4Bits23ThenStatus3Bits67::
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

; C = $FF when an occupied foe lacks status bit 4 and has bits 6-7 of its wSlotResistances + $3
; field below 3, else $00 (E-0124)
AnyFoeVulnerableByWDA75Bits67::
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
    bit 4, [hl]
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

AIScore_EvilSlash_CarryUnlessBattleSlotOutSlotEmpty::
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

AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    call WDA77EntryHasBits2And3_Bank05_5F2A
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

; C = index: Z set when bits 2 and 3 are both set in the byte at wSlotResistances + $5 + 7 * C
; (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2
; banks)
WDA77EntryHasBits2And3_Bank05_5F2A::
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

; C = 1 when the AI mode is below 4; with wAIFlag set, $00 when another ally that can act knows
; skill $63 or $64 with enough MP; otherwise $FF (E-0127)
FailIfAllyCanUseSkill63Or64::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    bit 2, [hl]
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

AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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
    call WDA77EntryHasBits2And3_Bank05
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

; C = index: Z set when bits 2 and 3 are both set in the byte at wSlotResistances + $5 + 7 * C
; (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2
; banks)
WDA77EntryHasBits2And3_Bank05::
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

; C = 1 when the AI mode is below 4; otherwise $00 when an occupied foe has HP at most half and a
; foe with personality Lo >= $C0 can cast a heal (SlotCHasCastableHealSkill), else $FF (E-0128)
FailIfFoeHurtAndHealerCanCast::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = slot: NZ when its status byte 1 bit 0 is set; otherwise the result of testing bit 3 of its
; side flag (wSideFlags0 for slots 0-3, wSideFlags1 for 4-7) (E-0117)
TestSlotStatus1Bit0OrSideFlagBit3::
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    ret nz
    ld a, c
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 3, [hl]
    ret

; C = slot: Z clear when bit 6 of its status byte 1 (wBattleStatus1) is set; HL points at the byte
; (E-0114)
TestSlotStatus1Bit6::
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    ret

SlotCHasCastableHealSkill_Data::
    db $02, $05, $07, $12, $24, $01, $0c, $1c

; C = 1 when the AI mode is below 4; otherwise $00 when an occupied foe without status 1 mask $2A
; has bits 4-5 of its wSlotResistances + $2 byte clear, else $FF (E-0125)
AIGateFoeWDA74Bits45::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = 1 when wSlotAIMode[actor] (the AI mode) is below 3; otherwise C = 0 when wAIFlag is non-zero,
; $FF when it is zero (E-0092)
CheckAIFlagSetModeGated::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

AIScore_AquaWall_Conditions_AddAx9ToHL::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, .done
    ld c, $ff
    ret

.done:
    ld c, $00
    ret

; C = 1 when the actor's AI mode is below 2; otherwise takes the highest ATK of the three opposing
; slots without a status block, subtracts half the actor's DEF (at least 1) and subtracts that from
; the actor's HP, but both outcomes return C = $FF; no caller found (E-0237)
UnreferencedEstimateStrongestFoeHit:: ; configured code entry (E-0237); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
    jr c, UnreferencedReturnC0_05_6223_Done
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld de, $ffff

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

; ld c, $00 / ret after UnreferencedEstimateStrongestFoeHit's ret; nothing reaches it (E-0237)
UnreferencedReturnC0_05_6223:: ; configured code entry (E-0237); C0
    ld c, $00
    ret

UnreferencedReturnC0_05_6223_Done::
    ld c, $01
    ret

AIScore_Curse_Conditions_AnySlotLacksStatusMask::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus
    ld e, $20
    ld b, $03
    call AnySlotLacksStatusMask
    ret

AIScore_SuckAir_Conditions_SlotHasSkillWithFlagD::
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

; C = $FF when an occupied ally's HP is below AnyAllyHPBelow6298_GetBattleMaxHP_Bank05 for it, else
; $00 (E-0125)
AnyAllyHPBelow6298::
    ld a, [wBattleActor]
    and $04
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
    ld c, $ff
    ret

AnyAllyHPBelow6298_GetBattleMaxHP_Bank05::
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

AIScore_MPass_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
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

; the same instruction sequence as HPBandOfSlotTemp0 (bank $05) apart from label operands, which
; refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
HPBandOfSlotTemp0_6312::
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

AIScore_MegaMagic_ReadSlotAIModeIndexed_Bank05::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = $FF when an occupied foe without status bit 7 has a skill matching flag D = $10
; (SlotCSkillFlagMatchD), else $00 (wRecordBuffer preserved) (E-0125)
AnyFoeHasSkillWithFlagD::
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
    ld c, $ff
    ret

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

; C = $00 when the side's wSide0Flag/wSide1Flag flag is 1 or no other ally slot is occupied, else
; $FF (E-0125)
AllyCheckSide0FlagAndOtherSlots::
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

AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05::
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

; C = 1 when the AI mode is below 2; otherwise $00 when an occupied foe's resistance field for skill
; wRecordBufferData + $1 is 3; $FF when wRecordBufferData + $1 is 0 or none is (E-0127)
FailIfAnyFoeFullyResistant::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
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

; C = 1 when the AI mode is below 3 or the actor knows a heal-all skill; otherwise $00 when two or
; more allies have HP below half, else $FF (E-0127)
FailIfTwoAlliesBelowHalfHP::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
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

AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
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

; C = 1 when the AI mode is below 4 or the actor knows a heal skill; otherwise compares the stat
; sums of the empty and occupied ally slots and returns $00 or $FF (E-0129)
AIGateCompareAllyStatAverages::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
    cp $04
    jp c, .done3
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld b, $08
    call SkillListHasAnyOf16To1A7C9FA1
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

; walks B skill numbers at every other byte from HL + 1: Z as soon as one is $16-$1A, $7C, $9F or
; $A1; otherwise A = 1 and Z clear (E-0120)
SkillListHasAnyOf16To1A7C9FA1::
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
    jr nz, SkillListHasAnyOf16To1A7C9FA1
    ld a, $01
    or a
    ret

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

AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty::
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

AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_4024::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
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

AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_4024::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
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

AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_4024::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
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
    call ReadSlotAIModeIndexed_Bank05_4024
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

AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty::
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

; C = 0 when the actor's status byte 2 (wBattleStatus2) bit 1 or byte 4 & $03 is set, else C = $FF
; (E-0072)
ActorLacksStatus2Bit1And4Bits01::
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

; C = 1 for the player side outside link battles; otherwise like PassIfFoesAverageResistanceAtLeast2
; (E-0128)
ResistanceAverageGateForAISide::
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

; C = 1 in link battles, for the player side, or when the AI mode is below 3; otherwise like
; PassIfFoesAverageResistanceAtLeast2 (E-0128)
ResistanceAverageGateForFoeAIMode3::
    ld a, [wLinkMode]
    cp $01
    jr z, .done3
    ld a, [wBattleActor]
    cp $04
    jr c, .done3
    call ReadSlotAIModeIndexed_Bank05
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

; wAISkillScore = wAISkillScore + $1 = 0 and wAISkillScore2 = wAISkillScore2 + $1 = $FF
ResetAISkillScore::
    xor a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld a, $ff
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    ret

; the word wAISkillScore/wAISkillScore + $1 += BC (E-0094)
AddBCToAISkillScore::
    ld a, [wAISkillScore]
    add c
    ld [wAISkillScore], a
    ld a, [wAISkillScore + $1]
    adc b
    ld [wAISkillScore + $1], a
    ret

; the word wAISkillScore2/wAISkillScore2 + $1 += BC (E-0094)
AddBCToAISkillScore2::
    ld a, [wAISkillScore2]
    add c
    ld [wAISkillScore2], a
    ld a, [wAISkillScore2 + $1]
    adc b
    ld [wAISkillScore2 + $1], a
    ret

; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 5 banks)
ReadSlotAIModeIndexed_Bank05::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

AIScore_Upper_Conditions_Sub01_GetBattleDEF_Bank05::
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

AIScore_Speed_Conditions_Sub01_GetBattleAGL_Bank05::
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

; C = slot: compares its HP with 3/4 of its max HP (CompareHLToBC): carry when below; BC kept
; (E-0120)
CompareHPWithThreeQuartersMax::
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

; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot):
; compares 2 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/2 of max, Z when
; exactly 1/2; BC kept (E-0094)
CompareHPWithHalfMax::
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

; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot):
; compares 4 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/4 of max, Z when
; exactly 1/4; BC kept (E-0094)
CompareHPWithQuarterMax::
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

; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot):
; compares 10 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/10 of max, Z when
; exactly 1/10; BC kept (E-0094)
CompareHPWithTenthMax::
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

; A = how many of slot C's skills have record byte 1 = 0 (flags from A) (E-0125)
CountSkillsWithZeroRecordByte1::
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

; A = battle slot: A = the family (byte 0 of the species record) of the monster id in
; wBattleMonsterId[slot] (LoadSpeciesFamily); BC kept (E-0069)
GetSlotSpeciesFamily::
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

AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty::
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

; slot C: returns NZ when bit 1 of status byte 0 is set, otherwise A = status byte 4 & 3 with flags
; from it (E-0122)
SlotStatus0Bit1OrStatus4Bits01::
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
    and $03

.return:
    ret

; A = how many of slot A's eight skills are $03, $06, $09, $0C, $0F, $12, $13 or $14 (Z set when
; none); BC kept (E-0175)
CountSkillsInList6D1A::
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

; A = how many of slot A's skills are $03, $06, $09, $0C, $0F, $12-$15 or $3D-$3F (E-0125)
CountSkillsInList6D54::
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

; A = how many of slot A's skills are $16-$24, $7B-$7C, $81 or $9F-$A0 (E-0125)
CountSkillsInRanges6D9E::
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

; A = how many of slot A's eight skills are $16-$1A or $1E-$20 (E-0124)
CountSkills16To1AOr1ETo20::
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

; D = the number of set status bits and fields in slot C's 9-byte wBattleStatus1 record (checks 16
; flags across bytes 0, 1, 4, 5 and 7) (E-0121)
CountActiveStatusEffectsOfSlotC::
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

; D += 1 (E-0072)
IncrementD::
    inc d
    ret

; D = how many of slot A's skills were read, E = how many have bit 6 set in record byte 5 (E-0125)
CountSkillsWithFlag6::
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

; A = how many of slot C's skills are $01-$15 or $2E-$34 except $31 (flags set from A) (E-0124)
CountSkillsBelow16Or2ETo34Except31::
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

; A = battle slot: counts the skills numbered $40-$47 among the slot's 8 skills (every other byte of
; wBattleSkills + 16 * slot): A = the count, Z set when there are none; BC kept (E-0094)
CountSlotSkills40To47::
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

; A = how many of slot A's skills are $01-$15, $40-$67, $6A-$70, $8B-$93 or $AA (E-0125)
CountSkillsInRanges6F21::
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

AnyFoeNotFullyResistant_Data::
    db $00, $02, $00, $01, $00, $00, $01, $03, $01, $02, $01, $01, $01, $00, $02, $03
    db $02, $02, $02, $01, $02, $00, $03, $03, $03, $02, $03, $01, $03, $00, $04, $03
    db $04, $02, $04, $01, $04, $00, $05, $03, $05, $02, $05, $01, $05, $00, $06, $03
    db $06, $02, $06, $01, $00, $03

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

; A = first slot, B = slot count, HL = a status field (wBattleStatus + n), E = mask: C = $FF when
; some present slot in the range has (HL + 9 * slot) & E non-zero, else C = 0 (the opposite test to
; AnySlotLacksStatusMask) (E-0100)
AnySlotHasStatusMask::
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

; E = family: C = 0 when one of the actor's three opposite slots is present and its species family
; (GetSlotSpeciesFamily) equals E; otherwise C = $FF (E-0092)
FoeOfFamilyEPresent::
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

; C = slot: compares its MP with 3/4 of its max MP: carry when below; BC kept (E-0120)
CompareMPWithThreeQuartersMax::
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

; A = wRecordBufferData + $1, Z set when it is zero (E-0114)
TestWCFEF::
    ld a, [wRecordBufferData + $1]
    or a
    ret

; reads the 2-bit field selected by AnyFoeNotFullyResistant_Data[A - 1] from the actor's
; wSlotResistances record into A, with NZ (E-0124)
ReadActorResistanceFieldForSkillA::
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

; scans the slot's eight wBattleSkills entries: 0 when one is $16-$1A, $7C or $A1
AIScore_Kamikaze_CheckSkills::
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

; usable when the MP, status-1, side-flag and repeat checks pass, a foe lacks status 2 mask $22,
; status 5 bits 6-7 and status 2 bit 3, and AnyFoeNotFullyResistant passes; otherwise resets
; wAISkillScore (E-0125)
AIFireSkillUsable::
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

; the conditions of AIScore_Beat: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check,
; SkillPassesSideFlagBit3Check in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_Beat_Conditions::
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

AIScore_Sacrifice_ActorCanPayMPCost_Bank05::
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
    call AIGateFoeStatus1Mask22
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

; usable when the actor can pay the MP cost and the status-1, side-flag, repeat and
; AnyAllyHPBelow6298 checks pass; otherwise resets wAISkillScore (E-0124)
AIHealUsable::
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
    call AnyAllyHPBelow6298
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

AIScore_MPass_ActorLacksStatus4Bits67::
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
    call AIScore_MPass_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Vivify: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyOwnSideSlotOutIs1 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Vivify_Conditions::
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

; the conditions of AIScore_Farewell: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyOwnSideSlotOutIs1 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Farewell_Conditions::
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

; the conditions of AIScore_Antidote: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_Antidote_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Antidote_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_Antidote_Conditions_AnySlotHasStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DeChaos: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_DeChaos_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DeChaos_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_DeChaos_Conditions_AnySlotHasStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_NumbOff: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_NumbOff_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_NumbOff_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_NumbOff_Conditions_AnySlotHasStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_CurseOff: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_CurseOff_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_CurseOff_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_CurseOff_Conditions_AnySlotHasStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_Upper: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeNotBlocked, AIScore_Upper_Sub01_Sub01 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Upper_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Upper_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Sap: calls AIUsableAndFoeLacksStatus2And5, AIScore_Sap_Sub01_Sub01 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Sap_Conditions::
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AIScore_Sap_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

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

; the conditions of AIScore_Speed: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeNotBlocked, AIScore_Speed_Sub01_Sub01 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Speed_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Speed_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Slow: calls AIUsableAndFoeLacksStatus2And5, AnyFoeNotBlocked,
; AIScore_Slow_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Slow_Conditions::
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Slow_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

AIScore_TwinHits_CheckSkillUsableStatusElseResetAISkillScore::
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

; the conditions of AIScore_Surround: calls AIUsableAndFoeLacksStatus2And5,
; AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Surround_Conditions::
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
    call AnyFoeOpenToWDA73Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Sleep: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0MaskCC,
; AnyFoeOpenToWDA74Field3 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Sleep_Conditions::
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA74Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_TakeMagic: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_TakeMagic_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_TakeMagic_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_TakeMagic_Conditions_ReadSlotAIModeIndexed_Bank05
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
    call AIScore_TakeMagic_Conditions_AddAx9ToHL
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_RobMagic: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeHasMPReadsWrongOffset, AnyFoeWithMPOpenToWDA74Field1 in turn and tests C after each (zero:
; stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_RobMagic_Conditions::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeWithMPOpenToWDA74Field1
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

; the conditions of AIScore_StopSpell: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0Bit6,
; AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_StopSpell_Conditions::
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
    call AIScore_StopSpell_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when AIUsableAndFoeLacksStatus2And5, a foe lacks status 0 bit 6, AnyFoeNotFullyResistant, a
; foe lacks status 0 bit 4 and AnyFoeVulnerableByWDA75Bits67 pass; otherwise resets wAISkillScore
; (E-0124)
AIPanicAllUsable::
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
    call AnyFoeVulnerableByWDA75Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the skill is usable and the foe, block, actor-status, lone-foe HP, wAIFlag and ally
; checks pass; otherwise resets wAISkillScore (E-0125)
AIIronizeUsable::
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

; the conditions of AIScore_MagicBack: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_MagicBack_Conditions::
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
    call AIScore_MagicBack_Conditions_AddAx9ToHL
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckWD044RuleBit5
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Barrier: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyFoeHasSkillFlag10 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Barrier_Conditions::
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

; the conditions of AIScore_MagicWall: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_MagicWall_Conditions::
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
    call AIScore_MagicWall_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when the skill is usable and the actor lacks status 4 bits 6-7; otherwise resets
; wAISkillScore (E-0122)
AIUsableAndActorLacksStatus4Bits67::
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

AIScore_MegaMagic_AIAttackSkillUsable_74D1::
    call AIAttackSkillUsable_74D1
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

; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7
; and status 2 bit 3, and AnyFoeNotFullyResistant passes; otherwise resets wAISkillScore (E-0124)
AIAttackSkillUsable_74D1::
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

AIScore_FireAir_AIAttackSkillUsable_74D1::
    call AIAttackSkillUsable_74D1
    ld a, c
    and a
    ret z
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_FireAir_Sub02_AnySlotLacksStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when AIAttackSkillUsable_74D1 passes and a foe lacks the status 3 and 4 bits;
; otherwise resets wAISkillScore (E-0122)
AIFunc74D1AndFoeLacksStatus3And4::
    call AIAttackSkillUsable_74D1
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

; the conditions of AIScore_SlimeBlow: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_SlimeBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SlimeBlow_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_SlimeBlow_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DrakSlash: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_DrakSlash_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DrakSlash_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_DrakSlash_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_BeastCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_BeastCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_BeastCut_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BeastCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_BirdBlow: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_BirdBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_BirdBlow_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BirdBlow_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_BugBlow: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_BugBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_BugBlow_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BugBlow_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_Shears: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_Shears_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Shears_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_Shears_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DevilCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_DevilCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DevilCut_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_DevilCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_ZombieCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_ZombieCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_ZombieCut_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_ZombieCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_CleanCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_CleanCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_CleanCut_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_CleanCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_AquaCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_AquaCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_AquaCut_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_AquaCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_MetalCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_MetalCut_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_MetalCut_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_MetalCut_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

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

; the conditions of AIScore_PoisonHit: calls CheckSkillUsableElseResetAISkillScore,
; AnyFoeLacksStatus0Bits01, AnyFoeOpenToWDA76Field0 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PoisonHit_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bits01
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA76Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_Paralyze: calls AIParalyzeUsable, AnyFoeOpenToWDA77Field3 in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_Paralyze_Conditions::
    call AIParalyzeUsable
    ld a, c
    and a
    ret z
    call AnyFoeOpenToWDA77Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_NapAttack: calls AIParalyzeUsable, AnyFoeOpenToWDA74Field3 in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_NapAttack_Conditions::
    call AIParalyzeUsable
    ld a, c
    and a
    ret z
    call AnyFoeOpenToWDA74Field3
    ld a, c
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

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

; the conditions of AIScore_SquallHit: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_SquallHit_Sub01_Sub01, FastestFoeAGLAbove31PercentOfActor in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SquallHit_Conditions::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_SquallHit_Conditions_CarryUnlessBattleSlotOutSlotEmpty
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

AIScore_BiAttack_CheckSkillUsableElseResetAISkillScore::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_RainSlash: calls CheckSkillUsableElseResetAISkillScore,
; AtLeastTwoFoesPresent in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_RainSlash_Conditions::
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

; the conditions of AIScore_MultiCut: calls AIAttackSkillUsable_770A, AnyFoeNotFullyResistant in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_MultiCut_Conditions::
    call AIAttackSkillUsable_770A
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

; usable when the actor can pay the MP cost, the repeat check passes and a foe lacks status 5 bits
; 6-7 and status 2 bit 3; otherwise resets wAISkillScore (E-0124)
AIAttackSkillUsable_770A::
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

; the conditions of AIScore_ChargeUp: calls ActorLacksStatus4Bits67,
; CheckLoneFoeHPNotBelowAIDamageEstimates, ActorLacksStatus1Bits23And4Bits01 in turn and tests C
; after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_ChargeUp_Conditions::
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

; the conditions of AIScore_PsycheUp: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus2Bit3 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_PsycheUp_Conditions::
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

; the conditions of AIScore_HighJump: calls AIAttackSkillUsable_770A, ActorLacksStatus4Bits67,
; ResetAISkillScore in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_HighJump_Conditions::
    call AIAttackSkillUsable_770A
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_TwinSlash: calls AIAttackSkillUsable_779F, AnyFoeHasDEFAtLeast2,
; AllOtherAlliesHaveStatus0Bit6 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_TwinSlash_Conditions::
    call AIAttackSkillUsable_779F
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

; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7
; and the status 3/4 bits, and the actor lacks status 4 bits 6-7; otherwise resets wAISkillScore
; (E-0124)
AIAttackSkillUsable_779F::
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

; usable only when AIAttackSkillUsable_779F and AnyFoeNotFullyResistant pass and the actor's HP is
; not 1; otherwise resets wAISkillScore (E-0122)
AIFunc779FAnd43F2AndActorHPNotOne::
    call AIAttackSkillUsable_779F
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

AIScore_Kamikaze_AIFunc779FAnd43F2AndActorHPNotOne::
    call AIFunc779FAnd43F2AndActorHPNotOne
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

; the conditions of AIScore_SleepAir: calls AIFunc770AAndPassUnlessWCFF3Bit4,
; AnyFoeLacksStatus0MaskCC, AnyFoeOpenToWDA74Field3 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SleepAir_Conditions::
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA74Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when AIAttackSkillUsable_770A and PassUnlessWCFF3Bit4AndActorStatusBit7 pass;
; otherwise resets wAISkillScore (E-0122)
AIFunc770AAndPassUnlessWCFF3Bit4::
    call AIAttackSkillUsable_770A
    ld a, c
    and a
    ret z
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PalsyAir: calls AIFunc770AAndPassUnlessWCFF3Bit4,
; AnyFoeLacksStatus0Bit6, AnyFoeOpenToWDA77Field3 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PalsyAir_Conditions::
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA77Field3
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

; the conditions of AIScore_PoisonGas: calls AIFunc770AAndPassUnlessWCFF3Bit4,
; AnyFoeLacksStatus0Bits01, AnyFoeOpenToWDA76Field0 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PoisonGas_Conditions::
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bits01
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA76Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PoisonAir: calls AIFunc770AAndPassUnlessWCFF3Bit4,
; AIScore_PoisonAir_Sub01_AnySlotLacksStatusMask, AnyFoeOpenToWDA76Field0 in turn and tests C after
; each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PoisonAir_Conditions::
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a
    ret z
    call AIScore_PoisonAir_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA76Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Curse: calls ActorCanPayMPCost_Bank05,
; PassUnlessWCFF3Bit4AndActorStatusBit7, SkillPassesRepeatCheck in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Curse_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit4AndActorStatusBit7
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
    call AIScore_Curse_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Curse_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_OddDance: calls AIDanceUsable, AnyFoeHasMPReadsWrongOffset,
; AnyFoeWithMPOpenToWDA74Field1 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_OddDance_Conditions::
    call AIDanceUsable
    ld a, c
    and a
    ret z
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeWithMPOpenToWDA74Field1
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

; the conditions of AIScore_PaniDance: calls AIDanceUsable, AnyFoeNotFullyResistant,
; AnyFoeLacksStatus0Bit4 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_PaniDance_Conditions::
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

; usable when the actor can pay the MP cost, PassUnlessWCFF3Bit5AndActorStatusBit6 and the repeat
; check pass and a foe lacks status 5 bits 6-7; otherwise resets wAISkillScore (E-0124)
AIDanceUsable::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
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

; the conditions of AIScore_KODance: calls AIDanceUsable, AnyFoeNotFullyResistant in turn and tests
; C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_KODance_Conditions::
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

; the conditions of AIScore_LureDance: calls AIDanceUsable, AnyFoeLacksStatus3And4Bits,
; AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_LureDance_Conditions::
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
    call AnyFoeVulnerableByWDA77Bits23
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

; the conditions of AIScore_LifeDance: calls ActorCanPayMPCost_Bank05,
; PassUnlessWCFF3Bit5AndActorStatusBit6, SkillPassesRepeatCheck in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_LifeDance_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
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

; the conditions of AIScore_Hustle: calls ActorCanPayMPCost_Bank05,
; PassUnlessWCFF3Bit5AndActorStatusBit6, SkillPassesRepeatCheck in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Hustle_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow6298
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SideStep: calls ActorCanPayMPCost_Bank05,
; PassUnlessWCFF3Bit5AndActorStatusBit6, SkillPassesRepeatCheck in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SideStep_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
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
    call AIScore_SideStep_Conditions_AddAx9ToHL
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SandStorm: calls CheckSkillUsableElseResetAISkillScore,
; AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SandStorm_Conditions::
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
    call AnyFoeOpenToWDA73Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Radiant: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus5Bits01And1Bit1 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_Radiant_Conditions::
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
    call AnyFoeOpenToWDA73Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_EerieLite: calls ActorCanPayMPCost_Bank05, AnyFoeNotFullyResistant,
; AIScore_EerieLite_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_EerieLite_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_EerieLite_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Surge: calls ActorCanPayMPCost_Bank05, AIScore_Surge_Sub01_Sub01 in turn
; and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_Surge_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Surge_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_UltraDown: calls ActorCanPayMPCost_Bank05, AIScore_UltraDown_Sub01_Sub01
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_UltraDown_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_UltraDown_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DeMagic: calls ActorCanPayMPCost_Bank05, AIScore_DeMagic_Sub01_Sub01 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_DeMagic_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_DeMagic_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_ThickFog: calls ActorCanPayMPCost_Bank05, SkillPassesSideFlagBit3Check,
; AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_ThickFog_Conditions::
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

; the conditions of AIScore_TatsuCall: calls ActorCanPayMPCost_Bank05, AIScore_TatsuCall_Sub01_Sub01
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_TatsuCall_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_TatsuCall_Conditions_ReadBattleActor
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SuckAir: calls PassUnlessWCFF3Bit4AndActorStatusBit7,
; ActorLacksStatus4Bits67, AIScore_SuckAir_Sub01_Sub01 in turn and tests C after each (zero: stop;
; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SuckAir_Conditions::
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_SuckAir_Conditions_ReadBattleActor
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits45
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_SuckAir_Conditions_SlotHasSkillWithFlagD
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Focus: calls ActorLacksStatus4Bits67, ResetAISkillScore in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_Focus_Conditions::
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the MP and repeat checks pass, a foe lacks status 5 bits 6-7 and the 3/4 bits, has
; clear status 3, is vulnerable by wSlotResistances + $5 bits 2-3, and
; AllyCheckSide0FlagAndOtherSlots passes; otherwise resets wAISkillScore (E-0125)
AILickSkillUsable_7AD8::
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
    call AnyFoeVulnerableByWDA77Bits23
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

; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7
; and the status 3/4 bits, a foe has clear status 3, and AnyFoeVulnerableByWDA77Bits23 passes;
; otherwise resets wAISkillScore (E-0124)
AIStatusLickUsable::
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
    call AnyFoeVulnerableByWDA77Bits23
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LegSweep: calls AILickSkillUsable_7AD8, AIScore_LegSweep_Sub01_Sub01 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_LegSweep_Conditions::
    call AILickSkillUsable_7AD8
    ld a, c
    and a
    ret z
    call AIScore_LegSweep_Conditions_CarryUnlessBattleSlotOutSlotEmpty
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

; the conditions of AIScore_Geyser: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus3And4Bits in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_Geyser_Conditions::
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

; the conditions of AIScore_DanceShut: calls ActorCanPayMPCost_Bank05,
; PassUnlessWCFF3Bit5AndActorStatusBit6, AnyFoeLacksStatus5Bits67 in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DanceShut_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
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
    call AIScore_DanceShut_Conditions_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .call_ai_score_dance_shut_conditions_any_slot
    and a
    jr z, .call_reset_ai_skill_score

.call_ai_score_dance_shut_conditions_any_slot:
    call AIScore_DanceShut_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_DanceShut_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_MouthShut: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_MouthShut_Conditions::
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

; the conditions of AIScore_StrongD: calls AllyCheckSide0FlagAndOtherSlots, AIBuffSkillUsable_7C24
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_StrongD_Conditions::
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jp z, ResetAISkillScore

; the conditions of AIScore_Dodge_Sub01: calls AIBuffSkillUsable_7C24,
; CheckLoneFoeHPNotBelowAIDamageEstimates, CheckAIFlagSetModeGated in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Dodge_Sub01_Conditions::
    call AIBuffSkillUsable_7C24
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

; the conditions of AIScore_Dodge: calls AIScore_Dodge_Sub01_Sub01, AnyFoeLacksStatus5Bits01And1Bit1
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Dodge_Conditions::
    call AIScore_Dodge_Sub01_Conditions
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

; usable when the actor can pay the MP cost, the repeat check passes and a foe lacks status 5 bits
; 6-7 and status 0 bit 6; otherwise resets wAISkillScore (E-0124)
AIBuffSkillUsable_7C24::
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

; AIBuffSkillUsable_7C24, a foe not blocked, the gated wAIFlag check and PassIfBattleTurnNonZero;
; otherwise resets wAISkillScore (E-0124)
AIGuardSkillUsable_7C45::
    call AIBuffSkillUsable_7C24
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

; the conditions of AIScore_Cover: calls AIGuardSkillUsable_7C45, AllyCheckSide0FlagAndOtherSlots,
; ActorHPIsNotOne in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_Cover_Conditions::
    call AIGuardSkillUsable_7C45
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

; the conditions of AIScore_TailWind: calls AIBuffSkillUsable_7C24, AnyFoeNotBlocked,
; AIScore_TailWind_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_TailWind_Conditions::
    call AIBuffSkillUsable_7C24
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_TailWind_Conditions_AddAx9ToHL
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

; the conditions of AIScore_StormWind: calls AIBuffSkillUsable_7C24, AnyFoeNotBlocked,
; AnyAllyLacksStatus2Bit6 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_StormWind_Conditions::
    call AIBuffSkillUsable_7C24
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

; the conditions of AIScore_AquaWall: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus0Bit6,
; AIScore_AquaWall_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_AquaWall_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_AquaWall_Conditions_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .call_ai_score_aqua_wall_conditions_add_ax9_to
    and a
    jr z, .call_reset_ai_skill_score

.call_ai_score_aqua_wall_conditions_add_ax9_to:
    call AIScore_AquaWall_Conditions_AddAx9ToHL
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

AIScore_SealPray_ActorCanPayMPCost_Bank05::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SuckAll: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus3And4Bits in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_SuckAll_Conditions::
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

; the conditions of AIScore_Imitate: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Imitate_Conditions::
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

; the conditions of AIScore_Meditate: calls ActorCanPayMPCost_Bank05, AIScore_Meditate_Sub01_Sub01
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Meditate_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LifeSong: calls ActorCanPayMPCost_Bank05, AnyOwnSideSlotOutIs1,
; CheckSide0FlagNot1 in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_LifeSong_Conditions::
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

; the conditions of AIScore_LoveRain: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyAllyHPBelow6298 in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_LoveRain_Conditions::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow6298
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; C = 0 (SetCToZero) and resets wAISkillScore: the skill is never chosen by the AI (E-0122)
AINeverUsableResetAISkillScore::
    call SetCToZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Guard: calls AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus0MaskCC,
; AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_Guard_Conditions::
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
