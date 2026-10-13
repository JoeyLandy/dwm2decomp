; ROM bank $3B: battle helpers; meta-sprites
; The annotated listing of this bank is build/listing/bank3b.asm.

SECTION "Bank 3B", ROMX[$4000], BANK[$3B]
    db $3b

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base HP: for slot numbers whose low
; two bits are 3 (slots 3 and 7) the monster id from wSpecialSlotMonsters is loaded with
; LoadMonsterRecord and the monster record's HP word (wRecordBufferData + $8) is returned; otherwise
; the word at offset $1D of the slot's 78-byte battler record (wBattlerRecords,
; BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
GetBaseHP::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_MAX_HP
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $8]
    ld c, a
    ld a, [wRecordBufferData + $9]
    ld b, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base MP: for slot numbers whose low
; two bits are 3 (slots 3 and 7) the monster id from wSpecialSlotMonsters is loaded with
; LoadMonsterRecord and the monster record's MP word (wRecordBufferData + $A) is returned; otherwise
; the word at offset $21 of the slot's 78-byte battler record (wBattlerRecords,
; BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
GetBaseMP::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_MAX_MP
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $a]
    ld c, a
    ld a, [wRecordBufferData + $b]
    ld b, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base ATK: for slot numbers whose low
; two bits are 3 (slots 3 and 7) the monster id from wSpecialSlotMonsters is loaded with
; LoadMonsterRecord and the monster record's ATK word (wRecordBufferData + $C) is returned;
; otherwise the word at offset $23 of the slot's 78-byte battler record (wBattlerRecords,
; BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
GetBaseATK::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_ATK
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $c]
    ld c, a
    ld a, [wRecordBufferData + $d]
    ld b, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base DEF: for slot numbers whose low
; two bits are 3 (slots 3 and 7) the monster id from wSpecialSlotMonsters is loaded with
; LoadMonsterRecord and the monster record's DEF word (wRecordBufferData + $E) is returned;
; otherwise the word at offset $25 of the slot's 78-byte battler record (wBattlerRecords,
; BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
GetBaseDEF::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_DEF
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $e]
    ld c, a
    ld a, [wRecordBufferData + $f]
    ld b, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base AGL: for slot numbers whose low
; two bits are 3 (slots 3 and 7) the monster id from wSpecialSlotMonsters is loaded with
; LoadMonsterRecord and the monster record's AGL word (wRecordBufferData + $10) is returned;
; otherwise the word at offset $27 of the slot's 78-byte battler record (wBattlerRecords,
; BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
GetBaseAGL::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_AGL
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $10]
    ld c, a
    ld a, [wRecordBufferData + $11]
    ld b, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base INT: for slot numbers whose low
; two bits are 3 (slots 3 and 7) the monster id from wSpecialSlotMonsters is loaded with
; LoadMonsterRecord and the monster record's INT word (wScreenAttrBuffer) is returned; otherwise the
; word at offset $29 of the slot's 78-byte battler record (wBattlerRecords,
; BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
GetBaseINT::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_INT
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wScreenAttrBuffer]
    ld c, a
    ld a, [wRecordBufferData + $13]
    ld b, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; slot C: the byte at battler record field $17, or for slot 3/7 byte wRecordBufferData + $7 of its
; monster record; stored in wBattleStatResultLo (E-0124)
SlotField17OrMonsterCFF5::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_LEVEL
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $7]
    ld c, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $2D, or for slot 3/7 byte wRecordBufferData + $14 of its
; monster record; stored in wBattleStatResultLo (E-0124)
SlotField2DOrMonsterD002::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_PERSONALITY
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $14]
    ld c, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $30, or for slot 3/7 byte wRecordBufferData + $16 of its
; monster record; stored in wBattleStatResultLo (E-0124)
SlotField30OrMonsterD004::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_PERSONALITY + 3
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $16]
    ld c, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $2E, or for slot 3/7 byte wRecordBufferData + $15 of its
; monster record; stored in wBattleStatResultLo (E-0124)
SlotField2EOrMonsterD003::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_PERSONALITY + 1
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $15]
    ld c, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $2F, or for slot 3/7 byte wRecordBufferData + $17 of its
; monster record; stored in wBattleStatResultLo (E-0124)
SlotField2FOrMonsterD005::
    ld a, c
    and $03
    cp $03
    jr z, .skip
    ld a, c
    ld e, BATTLER_PERSONALITY + 2
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr .set_battle_stat_result_lo

.skip:
    ld a, c
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
    ld a, [wRecordBufferData + $17]
    ld c, a

.set_battle_stat_result_lo:
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C (not 3/7): C = (species byte wSpeciesRecord + $2 << 4) | wSpeciesRecord + $3 for its
; species (field $0A); 0 for slot 3/7 (E-0124)
SlotSpeciesNibblesD00AD00B::
    ld a, c
    and $03
    cp $03
    jr z, .done
    ld a, c
    ld e, BATTLER_SPECIES
    call BattlerRecordFieldAddress
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_UNTRIPPABLE]
    swap a
    ld c, a
    ld a, [wSpeciesRecord + SPECIES_METAL]
    or c
    ld c, a
    jr .return

.done:
    ld c, $00

.return:
    ret

; the same 10 bytes as ReadBattleWordFromArray (ReadBattleWordFromArray)
ReadBattleWordFromArray_Bank3B::
    add a
    add_a_to_hl
    deref_hl
    ret

; C = [HL], B = [HL + 1]; HL ends on the high byte (E-0077)
LoadBCFromHL::
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ret

; by wBattleResolveStep: an item action ('0 can't eat while paralyzed!', 'The W shattered!', 'But
; nothing happened!', LoadItemRecord, DispatchActionEffectTable_Bank3B)
RunBattleActions_UseItem::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleActions_UseItem_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleActions_UseItem_ShowActionBattleText
    dw RunBattleActions_UseItem_TargetOnLocalSide_Bank3B
    dw RunBattleActions_UseItem_ShowHeroIsAHunk
    dw RunBattleActions_UseItem_DispatchActionEffectTable_Bank3BAndStep
    dw RunBattleActions_UseItem_WriteResolveMsgFlagsAndSlotsOccupiedFlagEtc
    dw RunBattleActions_UseItem_ShowBattleText
    dw RunBattleActions_UseItem_Return
    dw RunBattleActions_UseItem_AddDoubleAToHL_Bank3B
    dw RunBattleActions_UseItem_ToRunBattleSubStep2_6764
    dw RunBattleActions_UseItem_WriteBattleTargetAndBattleResolveStepEtc
    dw RunBattleActions_UseItem_LoadItemRecord
    dw RunBattleActions_UseItem_SetMultiHitCount
    dw RunBattleActions_UseItem_ShowButNothingHappened

RunBattleActions_UseItem_CarryUnlessBattleSlotOutSlotEmpty::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wMultiHitCount], a
    xor a
    ld [wSlotsOccupiedFlag], a
    ld a, [wBattleFlag92]
    cp $10
    jr z, .check_link_role
    cp $20
    jr z, .check_link_role2
    and $07
    ld [wBattleTarget], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_flag93
    ld a, [wBattleFlag93]
    cp $0c
    jr z, .read_battle_flag93
    jr .set_battle_action_id

.check_link_role:
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_all_three_slots_from_c_occupied
    ld c, $04
    jr .call_all_three_slots_from_c_occupied

.check_link_role2:
    ld c, $04
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_all_three_slots_from_c_occupied
    ld c, $00

.call_all_three_slots_from_c_occupied:
    call AllThreeSlotsFromCOccupied
    ld a, c
    ld [wBattleTarget], a

.read_battle_flag93:
    ld a, [wBattleFlag93]
    ld [wBattleActionId], a
    ret

.set_battle_action_id:
    ld [wBattleActionId], a
    farcall ShowActionBattleText
    ld a, $0d
    ld [wBattleResolveStep], a
    ret

; returns carry only when slots C, C + 1 and C + 2 are all occupied
; (CarryUnlessBattleSlotOutSlotEmpty) (E-0122)
AllThreeSlotsFromCOccupied::
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    inc c
    dec b
    jr nz, .loop
    ret

RunBattleActions_UseItem_ShowActionBattleText::
    ld hl, wBattleResolveStep
    inc [hl]
    farcall ShowActionBattleText
    ret

RunBattleActions_UseItem_TargetOnLocalSide_Bank3B::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActionId]
    cp SKILL_HEALUS
    jr c, .set_effect_flags_to_08
    cp SKILL_VIVIFY
    jr nc, .set_effect_flags_to_08
    call TargetOnLocalSide_Bank3B
    jr c, .set_effect_flags_to_08
    ld a, [wBattleKind]
    cp $03
    jr z, .call_call774_c_with_battle_foe_count
    ld a, [wBattleTarget]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    and $03
    ld hl, wFoeJoinClass1
    add_a_to_hl
    ld a, [hl]
    cp $07
    jr z, .call_call774_c_with_battle_foe_count
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, .call_call774_c_with_battle_foe_count2
    and $8c
    jr nz, .call_call774_c_with_battle_foe_count3
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and $c0
    jr nz, .call_call774_c_with_battle_foe_count4
    ld a, c
    call CheckSlotStatusBlock
    jr c, .call_call774_c_with_battle_foe_count5

.next:
    inc c
    dec b
    jr nz, .loop

.set_effect_flags_to_08:
    ld a, $08
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

.call_call774_c_with_battle_foe_count:
    call Call774CWithBattleFoeCount
    ld d, $7e
    farcall ShowBattleTextCategory0
    ld a, $0b
    ld [wBattleResolveStep], a
    ret

.call_call774_c_with_battle_foe_count2:
    call Call774CWithBattleFoeCount
    ld d, $e6 ; battle text '0 can't eat while paralyzed!'
    farcall ShowBattleText
    ld a, $0b
    ld [wBattleResolveStep], a
    ret

.call_call774_c_with_battle_foe_count3:
    call Call774CWithBattleFoeCount
    ld d, $7b
    farcall ShowBattleTextCategory0
    ld a, $0b
    ld [wBattleResolveStep], a
    ret

.call_call774_c_with_battle_foe_count4:
    call Call774CWithBattleFoeCount
    ld d, $7d
    farcall ShowBattleTextCategory0
    ld a, $0b
    ld [wBattleResolveStep], a
    ret

.call_call774_c_with_battle_foe_count5:
    call Call774CWithBattleFoeCount
    ld d, $7c
    farcall ShowBattleTextCategory0
    ld a, $0b
    ld [wBattleResolveStep], a
    ret

; hTemp0 = wBattleFoeCount, then far-calls Call774CWithBattleFoeCount_WriteBattleStatResultLo
; (E-0122)
Call774CWithBattleFoeCount::
    ld a, [wBattleFoeCount]
    ldh [hTemp0], a
    farcall Call774CWithBattleFoeCount_WriteBattleStatResultLo
    ret

RunBattleActions_UseItem_ShowHeroIsAHunk::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    ret z
    ld d, $66 ; battle text '0 is a hunk of iron!'
    farcall ShowBattleText
    call SetResolveStep0A
    ret

RunBattleActions_UseItem_DispatchActionEffectTable_Bank3BAndStep::
    ld hl, wBattleResolveStep
    inc [hl]
    call DispatchActionEffectTable_Bank3B
    ret

RunBattleActions_UseItem_WriteResolveMsgFlagsAndSlotsOccupiedFlagEtc::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    ld b, a
    bit 5, a
    jr z, .check_resolve_msg_flags
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, h
    or l
    jr z, .set_resolve_msg_flags
    set 4, b
    jr .set_resolve_msg_flags2

.set_resolve_msg_flags:
    res 4, b

.set_resolve_msg_flags2:
    ld a, b
    ld [wResolveMsgFlags], a

.check_resolve_msg_flags:
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret z
    ld a, $01
    ld [wSlotsOccupiedFlag], a
    ld a, $04
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $01
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ld a, [wBattleActionId]
    cp SKILL_BLAZE
    ret c
    cp SKILL_FIREBOLT
    jr c, .check_battle_target
    cp SKILL_INFERMORE
    jr z, .check_battle_target
    jr c, .check_battle_target2
    cp SKILL_INFERMOST
    jr z, .check_battle_target2
    cp SKILL_CURSEOFF
    ret c
    cp SKILL_DEFENSE
    jr c, .read_battle_damage_lo
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    jr c, .read_battle_damage_lo
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l
    jr .call_add_hl_to_battle_meter_capped_at1800

.check_battle_target2:
    ld hl, $0064
    ld a, [wBattleTarget]
    cp $04
    jr nc, .call_add_hl_to_battle_meter_capped_at1800
    ld hl, $0005
    jr .call_subtract_hl_from_battle_meter_floored

.read_battle_damage_lo:
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l

.call_subtract_hl_from_battle_meter_floored:
    call SubtractHLFromBattleMeterFloored
    ret

.call_add_hl_to_battle_meter_capped_at1800:
    call AddHLToBattleMeterCappedAt1800
    ret

RunBattleActions_UseItem_ShowBattleText::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .read_resolve_msg_target
    ld a, [wResolveMsgActor]
    ld [wTemp0], a
    jr .read_temp0

.read_resolve_msg_target:
    ld a, [wResolveMsgTarget]
    ld [wTemp0], a

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    call SetResolveStep0AUnlessResolveMsgFlagsBit4
    ret

; returns when wResolveMsgFlags bit 4 is set, otherwise SetResolveStep0A (E-0116)
SetResolveStep0AUnlessResolveMsgFlagsBit4::
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret nz
    call SetResolveStep0A
    ret

RunBattleActions_UseItem_Return::
    ret

RunBattleActions_UseItem_AddDoubleAToHL_Bank3B::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgArg]
    and $c0
    cp $00
    jr z, .return
    cp $40
    jr z, .read_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    jr c, .skip
    ld a, d
    ld [hld], a
    ld [hl], e
    or e
    jr nz, .read_battle_target
    inc hl

.skip:
    xor a
    ld [hld], a
    ld [hl], a
    ld hl, wBattleResolveStep
    dec [hl]
    xor a
    ld [wBattleSubStep2], a

.read_battle_target:
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank3B
    ld a, [wBattleTarget]
    call SetBit1OfLevelUpGainsIndexed_Bank3B
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3B
    ret

.return:
    ret

RunBattleActions_UseItem_ToRunBattleSubStep2_6764::
    farcall RunBattleSubStep2_6764
    ret

RunBattleActions_UseItem_WriteBattleTargetAndBattleResolveStepEtc::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleFlag93]
    cp $1f
    jr z, .check_multi_hit_count
    cp $1d
    jr z, .check_battle_target
    ld a, [wBattleFlag92]
    cp $10
    jr z, .call_run_once4650_then4673
    cp $20
    ret nz
    ld a, [wBattleFlag93]
    cp $1e
    jr nz, .call_run_once4650_then4673
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    ret c
    jr .call_run_once4650_then4673

.check_multi_hit_count:
    ld a, [wMultiHitCount]
    bit 7, a
    call z, GroupTargetsBySpeciesToSpeciesGroups
    ld a, [wBattleTarget]
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    or a
    jr z, .call_show_battle_text_category0
    ld d, $2b
    farcall ShowBattleTextCategory0
    jr .skip

.call_show_battle_text_category0:
    ld d, $2a
    farcall ShowBattleTextCategory0

.skip:
    ld hl, wMultiHitCount
    dec [hl]
    ld a, [hl]
    cp $80
    ret z
    ld a, $04
    ld [wBattleResolveStep], a
    ld a, [hl]
    and $7f
    dec a
    ld hl, wSpeciesGroups
    add_a_to_hl
    ld a, [hl]
    and $7f
    ld [wBattleTarget], a
    ret

.call_run_once4650_then4673:
    call RunOnce4650Then4673
    ret z
    ld a, c
    ld [wBattleTarget], a
    ld a, $03
    ld [wBattleResolveStep], a
    ret

; runs RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty once (marked by bit 7 of
; wMultiHitCount), then
; RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty_Sub02_BackMultiHitCount each time; returns
; wMultiHitCount & $7F (E-0122)
RunOnce4650Then4673::
    ld a, [wMultiHitCount]
    bit 7, a
    jr nz, .call_run_once4650_then4673_carry_unless
    call RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty
    ld a, [wMultiHitCount]
    or $80
    ld [wMultiHitCount], a

.call_run_once4650_then4673_carry_unless:
    call RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty_Sub02_BackMultiHitCount
    ld a, [wMultiHitCount]
    and $7f
    ret

RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty::
    ld b, $04
    ld a, [wBattleTarget]
    and $04
    ld c, a

.loop:
    ld a, [wBattleTarget]
    cp c
    jr z, .skip
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    jr z, .next
    jr .next

.skip:
    ld hl, wMultiHitCount
    inc [hl]

.next:
    inc c
    dec b
    ld a, b
    or a
    jr nz, .loop
    ret

RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty_Sub02_BackMultiHitCount::
    ld a, [wBattleTarget]
    inc a
    ld c, a
    ld hl, wMultiHitCount
    dec [hl]
    ld a, [hl]
    and $7f
    ret z

.check_record_buffer_data:
    ld a, [wRecordBufferData + $4]
    cp $80
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, c
    and $03
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, [wBattleTarget]
    and $04
    xor $04
    ld c, a

.call_carry_unless_battle_slot_out_slot_empty:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    jr z, .next

.next:
    inc c
    jr .check_record_buffer_data

RunBattleActions_UseItem_LoadItemRecord::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgArg]
    bit 0, a
    jr nz, .read_battle_flag93
    ld a, [wSlotsOccupiedFlag]
    or a
    ret z

.read_battle_flag93:
    ld a, [wBattleFlag93]
    ld [wItemId], a
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuOption]
    and $03
    add b
    ld [wInventorySlot], a
    farcall LoadItemRecord
    farcall ConsumeSelectedItemByChance
    ld a, [wItemId]
    cp $ff
    ret nz
    ld a, [wItemRecord + $3]
    cp $64
    jr nz, .call_show_battle_text
    ld a, [wBattleFlag93]
    cp $1e
    jr z, .call_show_battle_text
    ret

.call_show_battle_text:
    ld d, $87 ; battle text 'The W shattered!'
    farcall ShowBattleText
    ret

RunBattleActions_UseItem_SetMultiHitCount::
    xor a
    ld [wMultiHitCount], a
    ld a, $07
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

RunBattleActions_UseItem_ShowButNothingHappened::
    ld d, $cc ; battle text 'But nothing happened!'
    farcall ShowBattleText
    ld a, $0c
    ld [wBattleResolveStep], a
    ret

; wBattleResolveStep = $0A (the damage-message step, ResolveStepDamageMessage) (E-0116)
SetResolveStep0A::
    ld a, $0a
    ld [wBattleResolveStep], a
    ret

; lists the target side's species and groups the targets that share the target's species into
; wSpeciesGroups-wSpeciesGroups + $2 (bit 7 marks a group) (E-0131)
GroupTargetsBySpeciesToSpeciesGroups::
    ld a, $ff
    ld hl, wSpeciesGroups
    ld bc, $0003
    call FillBytes
    farcall ListSideMonsterIdsToTemp0
    ld a, d
    cp $03
    jr z, .read_battle_target
    cp $02
    jp z, .read_battle_target2
    ld a, [wBattleTarget]
    ld [wSpeciesGroups], a
    jp .skip3

.read_battle_target:
    ld a, [wBattleTarget]
    ld c, a
    ld a, c
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    inc c
    ld a, c
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    cp e
    jr nz, .next
    ld a, [hl]
    cp d
    jr nz, .next
    inc c
    ld a, c
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    cp e
    jr nz, .check_battle_target
    ld a, [hl]
    cp d
    jr nz, .check_battle_target
    ld a, c
    or $80
    ld [wSpeciesGroups], a
    jp .skip3

.check_battle_target:
    ld a, [wBattleTarget]
    or $80
    ld [wSpeciesGroups + $1], a
    ld a, c
    ld d, a
    ld [wSpeciesGroups], a
    jp .skip4

.next:
    inc c
    ld a, c
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    cp e
    jr nz, .skip
    ld a, [hl]
    cp d
    jr nz, .skip
    ld a, [wBattleTarget]
    or $80
    ld [wSpeciesGroups + $1], a
    dec c
    ld a, c
    ld d, a
    ld [wSpeciesGroups], a
    jr .skip4

.skip:
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec c
    ld a, c
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    cp e
    jr nz, .set_species_groups2
    ld a, [hl]
    cp d
    jr nz, .set_species_groups2
    ld a, [wBattleTarget]
    ld [wSpeciesGroups + $1], a
    ld a, c
    ld d, a
    or $80
    ld [wSpeciesGroups], a
    jr .skip4

.read_battle_target2:
    ld a, [wBattleTarget]
    ld c, a
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    inc c
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    ld d, c
    dec c
    ld e, c
    jr .skip2

.next2:
    inc c
    ld e, c
    inc c
    ld d, c
    jr .skip2

.next3:
    dec c
    ld e, c
    inc c
    inc c
    ld d, c

.skip2:
    ld a, e
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, d
    add a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hli]
    cp c
    jr nz, .set_species_groups
    ld a, [hl]
    cp b
    jr nz, .set_species_groups
    ld a, e
    or $80
    ld [wSpeciesGroups], a

.skip3:
    ld a, $01
    jr .set_multi_hit_count

.set_species_groups:
    ld a, e
    ld [wSpeciesGroups + $1], a
    ld a, d
    ld [wSpeciesGroups], a

.skip4:
    ld a, $02
    jr .set_multi_hit_count

.set_species_groups2:
    dec c
    ld a, c
    ld [wSpeciesGroups + $2], a
    inc c
    ld a, c
    ld [wSpeciesGroups + $1], a
    inc c
    ld a, c
    ld [wSpeciesGroups], a
    ld a, $03

.set_multi_hit_count:
    or $80
    ld [wMultiHitCount], a
    ret

; sets the damage word to the target's max HP for action $03, a random 30-40 for actions $01 and
; $38, else a random 60-70; adds it to the target's HP capped at max HP (the damage word becomes the
; amount actually added when capped) (E-0236)
RestoreTargetHPByActionAmount::
    ld a, [wBattleActionId]
    cp SKILL_BLAZEMOST
    jr z, .read_battle_target
    cp SKILL_BLAZE
    jr z, .call_set_damage_random_in_range
    cp SKILL_BARRIER
    jr z, .call_set_damage_random_in_range
    ld hl, $003c
    ld bc, $0046
    call SetDamageRandomInRange
    jr .read_battle_target2

.call_set_damage_random_in_range:
    ld hl, $001e
    ld bc, $0028
    call SetDamageRandomInRange
    jr .read_battle_target2

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.read_battle_target2:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    push hl
    deref_hl
    ld a, l
    add e
    ld c, a
    ld a, h
    adc d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxHP_Bank3B
    call CompareHLToBC
    jr nc, .restore
    call SetDamageDEMinusBCPlusHL
    ld b, h
    ld c, l

.restore:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

RestoreTargetMPIfLow_SetDamageRandomInRange::
    ld a, [wBattleActionId]
    cp SKILL_FIREBANE
    jr z, .read_battle_target
    ld hl, $0014
    ld bc, $001e
    call SetDamageRandomInRange
    jr .read_battle_target2

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.read_battle_target2:
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank3B
    push hl
    deref_hl
    ld a, l
    add e
    ld c, a
    ld a, h
    adc d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxMP_Bank3B
    call CompareHLToBC
    jr nc, .restore
    call SetDamageDEMinusBCPlusHL
    ld b, h
    ld c, l

.restore:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

; damage word = DE - (BC - HL) (E-0118)
SetDamageDEMinusBCPlusHL::
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    ld a, e
    sub c
    ld [wBattleDamageLo], a
    ld a, d
    sbc b
    ld [wBattleDamageHi], a
    ret

; the target's wBattleWordArray3F word -=
; SubtractActionAmountFromTargetBattleWordArray3F_Data[action - $19], floored at 0 (E-0124)
SubtractActionAmountFromTargetBattleWordArray3F::
    ld a, [wBattleTarget]
    ld hl, wBattleWordArray3F
    call AddDoubleAToHL_Bank3B
    push hl
    deref_hl
    push hl
    ld a, [wBattleActionId]
    sub $19
    add a
    ld hl, SubtractActionAmountFromTargetBattleWordArray3F_Data
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    pop hl
    ld a, l
    sub c
    ld c, a
    ld a, h
    sbc b
    ld b, a
    jr nc, .restore
    ld bc, $0000

.restore:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

SubtractActionAmountFromTargetBattleWordArray3F_Data::
    db $05, $00, $0a, $00, $14, $00, $64, $00, $05, $00

; adds the word AddActionAmountToBattleMeter_Data[action - $19] to wBattleMeter, capped at 1800
; (E-0122)
AddActionAmountToBattleMeter::
    ld a, [wBattleActionId]
    sub $19
    add a
    ld hl, AddActionAmountToBattleMeter_Data
    add_a_to_hl
    deref_hl
    call AddHLToBattleMeterCappedAt1800
    ret

AddActionAmountToBattleMeter_Data::
    db $0a, $00, $1e, $00, $64, $00, $e7, $03, $05, $00

; wBattleMeter += HL, capped at $0708 (1800) (E-0122)
AddHLToBattleMeterCappedAt1800::
    ld a, [wBattleMeter]
    ld c, a
    ld a, [wBattleMeter + $1]
    ld b, a
    add hl, bc
    ld bc, $0708
    call CompareHLToBC
    jr c, .set_battle_meter
    ld hl, $0708

.set_battle_meter:
    ld a, l
    ld [wBattleMeter], a
    ld a, h
    ld [wBattleMeter + $1], a
    ret

; wBattleMeter -= HL, floored at 0 (E-0124)
SubtractHLFromBattleMeterFloored::
    ld a, [wBattleMeter]
    ld c, a
    ld a, [wBattleMeter + $1]
    ld b, a
    ld a, h
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    add hl, bc
    bit 7, h
    jr z, .set_battle_meter
    ld hl, $0000

.set_battle_meter:
    ld a, l
    ld [wBattleMeter], a
    ld a, h
    ld [wBattleMeter + $1], a
    ret

; actions $24 onward: damage = random in the range from
; RollTableDamageScaledByResistance_Data[action - $24], then scaled by the target's resistance level
; for that element (85 percent at level 1, less above) (E-0129)
RollTableDamageScaledByResistance::
    ld a, [wBattleActionId]
    sub $24
    add a
    add a
    ld de, RollTableDamageScaledByResistance_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    call SetDamageRandomInRange
    ld a, [wBattleActionId]
    cp SKILL_CURSEOFF
    jr nz, .cp_25
    call TargetSlotResistancesByte1_Bank3B
    rlca
    rlca
    and $03
    jr .skip2

.cp_25:
    cp $25
    jr nz, .cp_26
    call TargetSlotResistancesByte1_Bank3B
    swap a
    and $03
    jr .skip2

.cp_26:
    cp $26
    jr nz, .call_target_slot_resistances_byte0_bank3_b
    call TargetSlotResistancesByte1_Bank3B
    rrca
    rrca
    and $03
    jr .skip2

.call_target_slot_resistances_byte0_bank3_b:
    call TargetSlotResistancesByte0_Bank3B
    swap a
    and $03

.skip2:
    and a
    ret z
    cp $01
    jr nz, .cp_02
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

.cp_02:
    cp $02
    jr nz, .clear_battle_damage_lo
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

.clear_battle_damage_lo:
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ret

RollTableDamageScaledByResistance_Data::
    db $08, $00, $18, $00, $23, $00, $32, $00, $78, $00, $8c, $00, $b4, $00, $c8, $00

InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B::
    call HLToBattleStatus8EntryOfBattleTarget_Bank3B
    call TargetSlotResistances2Byte
    and $03
    call RollChanceByHLBits6And7_Bank3B
    ret

; wBattleDamageLo/wBattleDamageHi = RandomInRange(HL, BC) (E-0116)
SetDamageRandomInRange::
    call RandomInRange
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ret

; HL = wBattleStatus8 + 9 * [wBattleTarget] (AddAx9ToHL); A = [wBattleTarget] (the same 10 bytes
; appear in 2 banks)
HLToBattleStatus8EntryOfBattleTarget_Bank3B::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ret

; A = byte 0 of the target's 7-byte wSlotResistances record (E-0126)
TargetSlotResistancesByte0_Bank3B::
    ld de, wSlotResistances
    jr GetTargetSlotResistancesByte3_Bank3B_ReadBattleTarget

; A = byte 1 of the target's 7-byte wSlotResistances record (E-0126)
TargetSlotResistancesByte1_Bank3B::
    ld de, wSlotResistances + $1
    jr GetTargetSlotResistancesByte3_Bank3B_ReadBattleTarget

; A = byte 2 of the target's 7-byte wSlotResistances record (wSlotResistances + $2 + 7 * target)
; (E-0124) (E-0340: the address in its name read as its RAM name; was TargetWDA74Byte)
TargetSlotResistances2Byte::
    ld de, wSlotResistances + $2
    jr GetTargetSlotResistancesByte3_Bank3B_ReadBattleTarget

GetTargetSlotResistancesByte3_Bank3B::
    ld de, wSlotResistances + $3
    jr GetTargetSlotResistancesByte3_Bank3B_ReadBattleTarget
    db $11, $76, $da, $18, $08, $11, $77, $da, $18, $03, $11, $78, $da

GetTargetSlotResistancesByte3_Bank3B_ReadBattleTarget::
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

; bit 6 of [HL]: RollChanceByHLBits6And7_Bank3B_ReadRandomLo; else bit 7:
; RollChanceByLevel_100_100_75_0_Bank3B; else RollChanceForLevelA_Bank3B (E-0122)
RollChanceByHLBits6And7_Bank3B::
    bit 6, [hl]
    jr z, .skip
    call RollChanceByHLBits6And7_Bank3B_ReadRandomLo
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_roll_chance_for_level_a_bank3_b
    call RollChanceByLevel_100_100_75_0_Bank3B
    jr .return

.call_roll_chance_for_level_a_bank3_b:
    call RollChanceForLevelA_Bank3B

.return:
    ret

; level A: 0 returns carry; 1 and 2 take two chance rolls; 3 returns no carry (E-0122)
RollChanceForLevelA_Bank3B::
    and a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom

.cp_02:
    cp $02
    jr nz, .done
    jp RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom3

.done:
    scf
    ccf
    ret

; the same instruction sequence as RollChanceByLevel_100_100_75_0 (bank $36) apart from label
; operands, which refer to this bank's own routines and tables; the twin's note describes the shape
; (E-0107)
RollChanceByLevel_100_100_75_0_Bank3B::
    cp $02
    jr nc, .skip
    ret

.skip:
    jr nz, .done
    jp RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom2

.done:
    scf
    ccf
    ret

RollChanceByHLBits6And7_Bank3B_ReadRandomLo::
    and a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom2

.cp_02:
    cp $02
    jr nz, .done
    jp RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom4

.done:
    scf
    ccf
    ret

RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $d8
    ret

RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom2::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $bf
    ret

RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom3::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $7f
    ret

RollChanceByHLBits6And7_Bank3B_ReadRandomLo_CallAdvanceRandom4::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $66
    ret

; AdvanceRandom, then compares wRandomLo with $3F: carry (success) about one time in four (E-0116)
RollChance3FOf256::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $3f
    ret

; jumps to the routine whose address is at $4B11 + 2 * wBattleActionId (JumpToWordAtHL), the
; bank-$3B counterpart of DispatchActionEffectTable (E-0116)
DispatchActionEffectTable_Bank3B::
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld hl, $4b11
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; DispatchActionEffectTable_Bank3B jumps (JumpToWordAtHL) to the word at $4B11 + 2 *
; wBattleActionId; 64 words up to the first target at $4B91, a lone ret (E-0239, C1)
; record: effect routine for this wBattleActionId
ActionIdEffectTable_3B::
    dw ActionIdEffectNone_3B_4B91 ; id 0
    dw RestoreTargetHPIfHurt ; id 1
    dw RestoreTargetHPIfHurt ; id 2
    dw RestoreTargetHPIfHurt ; id 3
    dw RestoreTargetMPIfLow ; id 4
    dw RestoreTargetMPIfLow ; id 5
    dw CureTargetStatus0Bits01 ; id 6
    dw CureTargetStatus0Bit6 ; id 7
    dw CureTargetStatus0Bit5 ; id 8
    dw CureTargetStatus0Bits237 ; id 9
    dw CureTargetStatus0Bit4 ; id 10
    dw RestoreTargetHPIfHurt ; id 11
    dw ApplyTargetMaxHPIfPresent ; id 12
    dw ActionIdEffectNone_3B_4C94 ; id 13
    dw ActionIdEffectNone_3B_4C94 ; id 14
    dw ActionIdEffectNone_3B_4C94 ; id 15
    dw ActionIdEffectNone_3B_4C94 ; id 16
    dw ActionIdEffectNone_3B_4C94 ; id 17
    dw ActionIdEffectNone_3B_4C94 ; id 18
    dw ActionIdEffectNone_3B_4C94 ; id 19
    dw ActionIdEffectNone_3B_4C94 ; id 20
    dw ActionIdEffectNone_3B_4C94 ; id 21
    dw ActionIdEffectNone_3B_4C94 ; id 22
    dw ActionIdEffectNone_3B_4C94 ; id 23
    dw ActionIdEffectNone_3B_4C94 ; id 24
    dw ApplyTargetBattleWordArray3FReduction ; id 25
    dw ApplyTargetBattleWordArray3FReduction ; id 26
    dw ApplyTargetBattleWordArray3FReduction ; id 27
    dw ApplyTargetBattleWordArray3FReduction ; id 28
    dw InflictStatus0Bit0WithBattleWordArray3FReduction ; id 29
    dw SetBattleEndFlagAndMessage98 ; id 30
    dw JumpToEffectFailurePath4F15 ; id 31
    dw ActionIdEffectNone_3B_4C94 ; id 32
    dw ActionIdEffectNone_3B_4C94 ; id 33
    dw InflictTargetStatus0Bit0 ; id 34
    dw InflictTargetStatus0Bit2 ; id 35
    dw RollTableDamageWithMessage35 ; id 36
    dw RollTableDamageWithMessage35 ; id 37
    dw RollTableDamageWithMessage35 ; id 38
    dw RollTableDamageWithMessage35 ; id 39
    dw ActionIdEffectNone_3B_4C94 ; id 40
    dw ActionIdEffectNone_3B_4C94 ; id 41
    dw ActionIdEffectNone_3B_4C94 ; id 42
    dw ActionIdEffectNone_3B_4C94 ; id 43
    dw ActionIdEffectNone_3B_4C94 ; id 44
    dw ActionIdEffectNone_3B_4C94 ; id 45
    dw ActionIdEffectNone_3B_4C94 ; id 46
    dw ActionIdEffectNone_3B_4C94 ; id 47
    dw ActionIdEffectNone_3B_4C94 ; id 48
    dw ActionIdEffectNone_3B_4C94 ; id 49
    dw ActionIdEffectNone_3B_4C94 ; id 50
    dw ActionIdEffectNone_3B_4C94 ; id 51
    dw ActionIdEffectNone_3B_4C94 ; id 52
    dw ActionIdEffectNone_3B_4C94 ; id 53
    dw ActionIdEffectNone_3B_4C94 ; id 54
    dw RaiseWord3FAndRestoreHP ; id 55
    dw RaiseWord3FAndRestoreHP ; id 56
    dw ActionIdEffectNone_3B_4C94 ; id 57
    dw ActionIdEffectNone_3B_4C94 ; id 58
    dw ActionIdEffectNone_3B_4C94 ; id 59
    dw ActionIdEffectNone_3B_4C94 ; id 60
    dw ActionIdEffectNone_3B_4C94 ; id 61
    dw ActionIdEffectNone_3B_4C94 ; id 62
    dw ActionIdEffectNone_3B_4C94 ; id 63

; a lone ret: entry 0 of ActionIdEffectTable_3B (E-0239)
ActionIdEffectNone_3B_4B91::
    ret

; if the target's HP is below its max, runs RestoreTargetHPByActionAmount and shows message $37;
; otherwise the no-effect path (E-0124)
RestoreTargetHPIfHurt::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank3B
    deref_hl
    call CompareHLToBC
    jr z, .skip
    call RestoreTargetHPByActionAmount
    ld l, $37
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; if the target's MP is below its max, runs RestoreTargetMPIfLow_SetDamageRandomInRange and shows
; message $C3; otherwise the no-effect path (E-0124)
RestoreTargetMPIfLow::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank3B
    deref_hl
    call CompareHLToBC
    jr z, .skip
    call RestoreTargetMPIfLow_SetDamageRandomInRange
    ld l, $c3
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; clears status byte 0 bits 0-1 of the target when set (message $4E); otherwise takes the no-effect
; path (E-0122)
CureTargetStatus0Bits01::
    call ClearDamageAndReadTargetStatus0
    and $03
    jr z, .skip
    ld a, [hl]
    and $fc
    ld [hl], a
    ld l, $4e
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; clears status byte 0 bit 6 of the target when set (message $4F, wSlotMarks[target] = 3); otherwise
; takes the no-effect path (E-0122)
CureTargetStatus0Bit6::
    call ClearDamageAndReadTargetStatus0
    and $40
    jr z, .skip
    ld a, [hl]
    and $bf
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $4f
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; clears status byte 0 bit 5 of the target when set (message $51); otherwise takes the no-effect
; path (E-0122)
CureTargetStatus0Bit5::
    call ClearDamageAndReadTargetStatus0
    and $20
    jr z, .skip
    ld a, [hl]
    and $df
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; clears status byte 0 bits 2, 3 and 7 of the target when set (message $82, wSlotMarks[target] = 3);
; otherwise takes the no-effect path (E-0122)
CureTargetStatus0Bits237::
    call ClearDamageAndReadTargetStatus0
    and $8c
    jr z, .skip
    ld a, [hl]
    and $73
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $82
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; clears status byte 0 bit 4 of the target when set (message $83, wSlotMarks[target] = 3); otherwise
; takes the no-effect path (E-0122)
CureTargetStatus0Bit4::
    call ClearDamageAndReadTargetStatus0
    and $10
    jr z, .skip
    ld a, [hl]
    and $ef
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

; if the target slot is occupied, far-calls ApplyTargetMaxHPAmount; otherwise one of two failure
; paths (E-0122)
ApplyTargetMaxHPIfPresent::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    jr z, .skip2
    farcall ApplyTargetMaxHPAmount
    ret

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

.skip2:
    jp ClearDamageAndReadTargetStatus0_SetBattleResolveStepTo0A

; a lone ret: the entry of ActionIdEffectTable_3B for 12 action ids (E-0239)
ActionIdEffectNone_3B_4C94::
    ret

; for local targets adds the action amount to wBattleMeter; for others checks status, block and
; resistance and subtracts the amount from the target's wBattleWordArray3F; then stores message $95
; or $FD (E-0127)
ApplyTargetBattleWordArray3FReduction::
    call TargetOnLocalSide_Bank3B
    jr c, .read_battle_target
    call AddActionAmountToBattleMeter
    jr .check_battle_target

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, .skip2
    and $8c
    jr nz, .call_show_battle_text_category0
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and $c0
    jr nz, .call_show_battle_text_category02
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jr c, .call_show_battle_text_category03
    call SubtractActionAmountFromTargetBattleWordArray3F

.check_battle_target:
    ld a, [wBattleTarget]
    cp $03
    jr c, .skip
    farcall ListSideMonsterIdsToTemp0
    ld a, b
    cp $01
    jr z, .skip
    ld l, $fd
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    ld l, $95
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip2:
    ld h, $e6
    ld bc, $0080
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgTarget

.call_show_battle_text_category0:
    ld d, $7b
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags

.call_show_battle_text_category02:
    ld d, $7d
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags

.call_show_battle_text_category03:
    ld d, $7c
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags

; reduces the target's wBattleWordArray3F (or adds to wBattleMeter for local targets); when status
; bits 0-1 are clear and the chance roll passes, sets status bit 0 (message $75) (E-0129)
InflictStatus0Bit0WithBattleWordArray3FReduction::
    call TargetOnLocalSide_Bank3B
    jr c, .read_battle_target
    ld a, [wMultiHitCount]
    or a
    jr nz, .read_battle_target2
    call AddActionAmountToBattleMeter
    jr .read_battle_target2

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jp nz, .skip
    and $8c
    jp nz, .call_show_battle_text_category0
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and $c0
    jp nz, .call_show_battle_text_category02
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jp c, .call_show_battle_text_category03
    call SubtractActionAmountFromTargetBattleWordArray3F

.read_battle_target2:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $03
    jr nz, .call_set_resolve_msg_target_b5_and_resolve
    push hl
    farcall RollVsPoisonGasResistance
    pop hl
    ld a, e
    or a
    jr nz, .call_set_resolve_msg_target_b5_and_resolve
    set 0, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3B
    ld l, $75
    ld bc, $0090
    call ClearDamageAndStoreResolveMsgFlags_Bank3B
    ld a, [wMultiHitCount]
    or a
    ret nz
    ld a, [wBattleTarget]
    cp $03
    jr c, .call_show_battle_text
    farcall ListSideMonsterIdsToTemp0
    ld a, b
    cp $01
    jr z, .call_show_battle_text
    ld d, $fe ; battle text 'Monsters ate the meat fearfully! Monsters'
    farcall ShowBattleText
    ret

.call_show_battle_text:
    ld d, $96 ; battle text '0 ate the meat fearfully! 0'
    farcall ShowBattleText
    ret

.call_set_resolve_msg_target_b5_and_resolve:
    call SetResolveMsgTargetB5AndResolveMsgFlagsTo0180
    ld a, [wMultiHitCount]
    or a
    ret nz
    ld a, [wBattleTarget]
    cp $03
    jr c, .call_show_battle_text2
    farcall ListSideMonsterIdsToTemp0
    ld a, b
    cp $01
    jr z, .call_show_battle_text2
    ld d, $fe ; battle text 'Monsters ate the meat fearfully! Monsters'
    farcall ShowBattleText
    ret

.call_show_battle_text2:
    ld d, $96 ; battle text '0 ate the meat fearfully! 0'
    farcall ShowBattleText
    ret

.skip:
    ld h, $e6
    ld bc, $0080
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgTarget

.call_show_battle_text_category0:
    ld d, $7b
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags

.call_show_battle_text_category02:
    ld d, $7d
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags

.call_show_battle_text_category03:
    ld d, $7c
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags

; wBattleEndFlag = 1 and stores message $98 (ClearDamageAndStoreResolveMsgFlags_Bank3B) (E-0122)
SetBattleEndFlagAndMessage98::
    ld a, $01
    ld [wBattleEndFlag], a
    ld l, $98
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B
    db $c9

; effect table entry that goes straight to the failure path
; ClearDamageAndReadTargetStatus0_SetBattleResolveStepTo0A (E-0126)
JumpToEffectFailurePath4F15::
    jp ClearDamageAndReadTargetStatus0_SetBattleResolveStepTo0A

; unless already set, rolls the chance
; (InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B) and sets bit 0 of the
; target's wBattleStatus1 status (message $3B); otherwise one of two failure paths (E-0124)
InflictTargetStatus0Bit0::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr nz, .skip
    call InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B
    jr nc, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_SPELLS_SEALED, [hl]
    ld l, $3b
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndReadTargetStatus0_SetBattleResolveStepTo0A

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip2

; sets bit 2 of the target's status byte 0 (message $43); if already set takes the failure path
; (E-0122)
InflictTargetStatus0Bit2::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, .skip
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

.skip:
    jp ClearDamageAndReadTargetStatus0_SetBattleResolveStepTo0A

; calls RollTableDamageScaledByResistance, then stores resolve message $35 (wResolveMsgActor/Target
; = $35/$B5, flags $A8, arg $80); entry of ActionIdEffectTable_3B (E-0239; E-0236 had found no
; caller)
RollTableDamageWithMessage35:: ; configured code entry (E-0236); C0
    call RollTableDamageScaledByResistance
    jp RaiseWord3FAndRestoreHP_Skip

; adds 30 to the target's wBattleWordArray3F word capped at 999, then if its HP is below max runs
; RestoreTargetHPByActionAmount and shows message $37, otherwise takes the no-effect path; entry of
; ActionIdEffectTable_3B (E-0239; E-0236 had found no caller)
RaiseWord3FAndRestoreHP::
    ld a, [wBattleTarget]
    ld hl, wBattleWordArray3F
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    add $1e
    ld c, a
    ld a, [hl]
    adc $00
    ld b, a
    ld a, b
    sub $03
    ld a, c
    sbc $e7
    jr c, .skip
    ld bc, $03e7

.skip:
    ld [hl], b
    dec hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank3B
    deref_hl
    call CompareHLToBC
    jr z, .skip2
    call RestoreTargetHPByActionAmount
    ld l, $37
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_SetResolveMsgActor

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip

RaiseWord3FAndRestoreHP_Skip::
    ld hl, $b535
    ld bc, $80a8
    jr UnreferencedStoreResolveMessage35D0_SetResolveMsgActor

; HL = $D035, BC = $88A8, then falls into the resolve-message store at $4EBE; skipped by the jr
; before it and no caller found (E-0236)
UnreferencedStoreResolveMessage35D0:: ; configured code entry (E-0236); C0
    ld hl, $d035
    ld bc, $88a8

UnreferencedStoreResolveMessage35D0_SetResolveMsgActor::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, h
    ld [wResolveMsgTarget], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (the same instructions as the bank-$36 copy) (E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank3B::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

ClearDamageAndStoreResolveMsgFlags_Bank3B_SetResolveMsgActor::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip::
    ld h, $cc
    ld bc, $0080
    jr SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgTarget

ClearDamageAndStoreResolveMsgFlags_Bank3B_Skip2::
    ld h, $b5
    ld bc, $0080
    jr SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgTarget

; wResolveMsgTarget = $B5 and the word wResolveMsgFlags = $0180 (E-0122) (E-0340: the address in its
; name read as its RAM name; was SetWDAC3B5AndResolveMsgFlagsTo0180)
SetResolveMsgTargetB5AndResolveMsgFlagsTo0180::
    ld h, $b5
    ld bc, $0180

SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgTarget::
    ld a, h
    ld [wResolveMsgTarget], a

SetResolveMsgTargetB5AndResolveMsgFlagsTo0180_SetResolveMsgFlags::
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; clears wBattleDamageLo/wBattleDamageHi, then A = status byte 0 of wBattleTarget (wBattleStatus + 9
; * target), HL pointing at it (E-0078)
ClearDamageAndReadTargetStatus0::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    ret

ClearDamageAndReadTargetStatus0_SetBattleResolveStepTo0A::
    ld a, $0a
    ld [wBattleResolveStep], a
    ret
    db $21, $ff, $d8, $18, $28, $21, $0f, $d9, $18, $23

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
GetBattleMaxHP_Bank3B::
    ld hl, wBattleMaxHP
    jr GetBattleMP_Bank3B_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
GetBattleMaxMP_Bank3B::
    ld hl, wBattleMaxMP
    jr GetBattleMP_Bank3B_Skip

GetBattleHP_Bank3B::
    ld hl, wBattleHP
    jr GetBattleMP_Bank3B_Skip

GetBattleMP_Bank3B::
    ld hl, wBattleMP
    jr GetBattleMP_Bank3B_Skip
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

GetBattleMP_Bank3B_Skip::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank3B::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank3B::
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
TargetOnLocalSide_Bank3B::
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

ClearBattleStatusBitsWithMaskD_Bank3B::
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank3B_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

ClearBattleStatusBitsWithMaskD_Bank3B_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank3B::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank3B::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank3B::
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
PersonalityIndexOfSlot_Bank3B::
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
CheckSlotStatusBlockWide_Bank3B::
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
SlotHasStatus3Or4Bits_Bank3B::
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

; sets the sprite origin X = wEffectSpriteX, Y = $68, tile offset = wEffectTileOffset, attribute XOR
; = wEffectSpriteAttrXor, then builds OAM from the local sprite table (E-0121)
DrawEffectSpriteAtEffectSpriteX_Bank3B::
    ld hl, hSpriteOriginX
    ld a, [wEffectSpriteX]
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $68
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, [wEffectTileOffset]
    ld [hli], a
    ld a, [wEffectSpriteAttrXor]
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld [hli], a
    ld de, MetaSprites3B_507CTable
    call BuildOamFromSpriteTable_Bank3B
    ret

; the caller of BuildOamFromSpriteTable_Bank3B passes DE = $MetaSprites3B_507CTable; the builder
; takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as
; the frame; 51 words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites3B_507CTable::
    dw MetaSprites3B_507CSet00 ; id 0
    dw MetaSprites3B_507CSet00 ; id 1
    dw MetaSprites3B_507CSet00 ; id 2
    dw MetaSprites3B_507CSet00 ; id 3
    dw MetaSprites3B_507CSet00 ; id 4
    dw MetaSprites3B_507CSet00 ; id 5
    dw MetaSprites3B_507CSet00 ; id 6
    dw MetaSprites3B_507CSet00 ; id 7
    dw MetaSprites3B_507CSet00 ; id 8
    dw MetaSprites3B_507CSet00 ; id 9
    dw MetaSprites3B_507CSet00 ; id 10
    dw MetaSprites3B_507CSet00 ; id 11
    dw MetaSprites3B_507CSet00 ; id 12
    dw MetaSprites3B_507CSet00 ; id 13
    dw MetaSprites3B_507CSet00 ; id 14
    dw MetaSprites3B_507CSet00 ; id 15
    dw MetaSprites3B_507CSet00 ; id 16
    dw MetaSprites3B_507CSet00 ; id 17
    dw MetaSprites3B_507CSet00 ; id 18
    dw MetaSprites3B_507CSet00 ; id 19
    dw MetaSprites3B_507CSet00 ; id 20
    dw MetaSprites3B_507CSet00 ; id 21
    dw MetaSprites3B_507CSet00 ; id 22
    dw MetaSprites3B_507CSet00 ; id 23
    dw MetaSprites3B_507CSet00 ; id 24
    dw MetaSprites3B_507CSet00 ; id 25
    dw MetaSprites3B_507CSet00 ; id 26
    dw MetaSprites3B_507CSet00 ; id 27
    dw MetaSprites3B_507CSet00 ; id 28
    dw MetaSprites3B_507CSet00 ; id 29
    dw MetaSprites3B_507CSet00 ; id 30
    dw MetaSprites3B_507CSet00 ; id 31
    dw MetaSprites3B_507CSet00 ; id 32
    dw MetaSprites3B_507CSet00 ; id 33
    dw MetaSprites3B_507CSet00 ; id 34
    dw MetaSprites3B_507CSet00 ; id 35
    dw MetaSprites3B_507CSet00 ; id 36
    dw MetaSprites3B_507CSet00 ; id 37
    dw MetaSprites3B_507CSet00 ; id 38
    dw MetaSprites3B_507CSet00 ; id 39
    dw MetaSprites3B_507CSet00 ; id 40
    dw MetaSprites3B_507CSet00 ; id 41
    dw MetaSprites3B_507CSet00 ; id 42
    dw MetaSprites3B_507CSet00 ; id 43
    dw MetaSprites3B_507CSet00 ; id 44
    dw MetaSprites3B_507CSet00 ; id 45
    dw MetaSprites3B_507CSet2E ; id 46
    dw MetaSprites3B_507CSet2F ; id 47
    dw MetaSprites3B_507CSet30 ; id 48
    dw MetaSprites3B_507CSet31 ; id 49
    dw MetaSprites3B_507CSet32 ; id 50

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM
; entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8,
; tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28
; (40 entries) (the same 81 bytes appear in 5 banks)
BuildOamFromSpriteTable_Bank3B::
    ldh a, [hOamNextEntry]
    cp $28
    jr nc, .return
    ldh a, [hSpriteSetIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh a, [hOamNextEntry]
    sla a
    sla a
    ld l, a
    ld h, $c0

.loop:
    ld a, [de]
    inc de
    cp $80
    jr z, .return
    ld b, a
    ldh a, [hSpriteOriginY]
    add b
    add $10
    ld [hli], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteOriginX]
    add b
    add $08
    ld [hli], a
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [de]
    inc de
    add b
    ld [hli], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteAttrXor]
    xor b
    ld [hli], a
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr c, .loop

.return:
    ret

; meta-sprite set 0 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites3B_507CSet00::
    dw MetaSprites3B_507CSet00Frame0 ; entry 0
    dw MetaSprites3B_507CSet00Frame1 ; entry 1
    dw MetaSprites3B_507CSet00Frame2 ; entry 2
    dw MetaSprites3B_507CSet00Frame3 ; entry 3
    dw MetaSprites3B_507CSet00Frame4 ; entry 4
    dw MetaSprites3B_507CSet00Frame5 ; entry 5
    dw MetaSprites3B_507CSet00Frame6 ; entry 6
    dw MetaSprites3B_507CSet00Frame7 ; entry 7
    dw MetaSprites3B_507CSet00Frame8 ; entry 8
    dw MetaSprites3B_507CSet00Frame9 ; entry 9
    dw MetaSprites3B_507CSet00Frame10 ; entry 10
    dw MetaSprites3B_507CSet00Frame11 ; entry 11
    dw MetaSprites3B_507CSet00Frame12 ; entry 12
    dw MetaSprites3B_507CSet00Frame12 ; entry 13
    dw MetaSprites3B_507CSet00Frame12 ; entry 14
    dw MetaSprites3B_507CSet00Frame12 ; entry 15
    dw MetaSprites3B_507CSet00Frame12 ; entry 16
    dw MetaSprites3B_507CSet00Frame12 ; entry 17
    dw MetaSprites3B_507CSet00Frame12 ; entry 18
    dw MetaSprites3B_507CSet00Frame12 ; entry 19
    dw MetaSprites3B_507CSet00Frame12 ; entry 20
    dw MetaSprites3B_507CSet00Frame12 ; entry 21
    dw MetaSprites3B_507CSet00Frame12 ; entry 22
    dw MetaSprites3B_507CSet00Frame12 ; entry 23
    dw MetaSprites3B_507CSet00Frame12 ; entry 24
    dw MetaSprites3B_507CSet00Frame12 ; entry 25
    dw MetaSprites3B_507CSet00Frame12 ; entry 26
    dw MetaSprites3B_507CSet00Frame12 ; entry 27
    dw MetaSprites3B_507CSet00Frame12 ; entry 28
    dw MetaSprites3B_507CSet00Frame12 ; entry 29
    dw MetaSprites3B_507CSet00Frame12 ; entry 30
    dw MetaSprites3B_507CSet00Frame12 ; entry 31

; frame 0 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame0::
    db $f8, $f8, $00, $00 ; entry 0
    db $f8, $ff, $00, $20 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame1::
    db $f8, $f0, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f8, $00, $03, $20 ; entry 2
    db $f8, $07, $02, $20 ; entry 3
    db $f0, $ff, $01, $20 ; entry 4
    db $f0, $f8, $01, $00 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame2::
    db $f8, $f0, $05, $00 ; entry 0
    db $f8, $f8, $06, $00 ; entry 1
    db $f8, $07, $05, $20 ; entry 2
    db $f8, $ff, $06, $20 ; entry 3
    db $f0, $f8, $04, $00 ; entry 4
    db $f0, $ff, $04, $20 ; entry 5
    db $80 ; end

; frame 3 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f0, $f8, $07, $00 ; entry 1
    db $f8, $ff, $08, $20 ; entry 2
    db $f0, $ff, $07, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame4::
    db $f8, $fc, $0a, $00 ; entry 0
    db $f0, $fc, $09, $00 ; entry 1
    db $80 ; end

; frame 5 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame5::
    db $f8, $fc, $0b, $00 ; entry 0
    db $f0, $fc, $0a, $00 ; entry 1
    db $e8, $fc, $09, $00 ; entry 2
    db $80 ; end

; frame 6 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame6::
    db $e8, $fc, $0d, $00 ; entry 0
    db $f0, $fc, $0e, $00 ; entry 1
    db $f8, $fc, $0c, $00 ; entry 2
    db $80 ; end

; frame 7 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame7::
    db $e8, $f8, $11, $00 ; entry 0
    db $e8, $00, $12, $00 ; entry 1
    db $e0, $f8, $0f, $00 ; entry 2
    db $e0, $00, $10, $00 ; entry 3
    db $f0, $fc, $0c, $00 ; entry 4
    db $80 ; end

; frame 8 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame8::
    db $e4, $f4, $16, $00 ; entry 0
    db $e4, $fc, $17, $00 ; entry 1
    db $e4, $04, $18, $00 ; entry 2
    db $dc, $f4, $13, $00 ; entry 3
    db $dc, $fc, $14, $00 ; entry 4
    db $dc, $04, $15, $00 ; entry 5
    db $ec, $f8, $19, $00 ; entry 6
    db $ec, $00, $1a, $00 ; entry 7
    db $80 ; end

; frame 9 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame9::
    db $d8, $f0, $1b, $00 ; entry 0
    db $d8, $f8, $1c, $00 ; entry 1
    db $d8, $00, $1d, $00 ; entry 2
    db $e0, $f0, $1e, $00 ; entry 3
    db $e0, $f8, $1f, $00 ; entry 4
    db $e0, $00, $1f, $20 ; entry 5
    db $e8, $f8, $1f, $40 ; entry 6
    db $e8, $00, $1f, $60 ; entry 7
    db $e0, $08, $20, $00 ; entry 8
    db $e8, $08, $1e, $60 ; entry 9
    db $f0, $f0, $22, $00 ; entry 10
    db $f0, $f8, $23, $00 ; entry 11
    db $f0, $00, $24, $00 ; entry 12
    db $f0, $08, $25, $00 ; entry 13
    db $e8, $f0, $21, $00 ; entry 14
    db $80 ; end

; frame 10 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame10::
    db $de, $ee, $2c, $00 ; entry 0
    db $de, $f6, $2d, $00 ; entry 1
    db $d6, $ee, $2a, $00 ; entry 2
    db $d6, $f6, $2b, $00 ; entry 3
    db $de, $02, $28, $00 ; entry 4
    db $de, $0a, $29, $00 ; entry 5
    db $d6, $02, $26, $00 ; entry 6
    db $d6, $0a, $27, $00 ; entry 7
    db $ea, $0a, $2c, $60 ; entry 8
    db $ea, $02, $2d, $60 ; entry 9
    db $f2, $0a, $2a, $60 ; entry 10
    db $f2, $02, $2b, $60 ; entry 11
    db $ea, $f6, $28, $60 ; entry 12
    db $ea, $ee, $29, $60 ; entry 13
    db $f2, $f6, $26, $60 ; entry 14
    db $f2, $ee, $27, $60 ; entry 15
    db $80 ; end

; frame 11 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
MetaSprites3B_507CSet00Frame11::
    db $da, $06, $2f, $00 ; entry 0
    db $d2, $06, $2e, $00 ; entry 1
    db $d6, $12, $2f, $00 ; entry 2
    db $da, $f2, $2e, $20 ; entry 3
    db $d2, $f2, $2f, $20 ; entry 4
    db $d7, $ea, $2e, $20 ; entry 5
    db $ee, $f2, $2f, $60 ; entry 6
    db $f6, $f2, $2e, $60 ; entry 7
    db $f2, $e6, $2f, $60 ; entry 8
    db $ee, $06, $2e, $40 ; entry 9
    db $f6, $06, $2f, $40 ; entry 10
    db $f1, $0e, $2e, $40 ; entry 11
    db $80 ; end

; frame 12 of MetaSprites3B_507CSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame12::
    db $80 ; end

; meta-sprite set 46 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites3B_507CSet2E::
    dw MetaSprites3B_507CSet2EFrame0 ; entry 0
    dw MetaSprites3B_507CSet2EFrame1 ; entry 1
    dw MetaSprites3B_507CSet2EFrame2 ; entry 2
    dw MetaSprites3B_507CSet2EFrame3 ; entry 3
    dw MetaSprites3B_507CSet2EFrame4 ; entry 4
    dw MetaSprites3B_507CSet2EFrame5 ; entry 5
    dw MetaSprites3B_507CSet2EFrame6 ; entry 6
    dw MetaSprites3B_507CSet2EFrame7 ; entry 7
    dw MetaSprites3B_507CSet2EFrame8 ; entry 8
    dw MetaSprites3B_507CSet2EFrame9 ; entry 9
    dw MetaSprites3B_507CSet2EFrame10 ; entry 10
    dw MetaSprites3B_507CSet2EFrame11 ; entry 11
    dw MetaSprites3B_507CSet2EFrame12 ; entry 12
    dw MetaSprites3B_507CSet2EFrame13 ; entry 13
    dw MetaSprites3B_507CSet2EFrame14 ; entry 14
    dw MetaSprites3B_507CSet2EFrame15 ; entry 15
    dw MetaSprites3B_507CSet2EFrame16 ; entry 16
    dw MetaSprites3B_507CSet2EFrame17 ; entry 17
    dw MetaSprites3B_507CSet2EFrame18 ; entry 18
    dw MetaSprites3B_507CSet2EFrame19 ; entry 19
    dw MetaSprites3B_507CSet2EFrame20 ; entry 20
    dw MetaSprites3B_507CSet2EFrame21 ; entry 21
    dw MetaSprites3B_507CSet2EFrame22 ; entry 22
    dw MetaSprites3B_507CSet2EFrame23 ; entry 23
    dw MetaSprites3B_507CSet2EFrame24 ; entry 24
    dw MetaSprites3B_507CSet2EFrame25 ; entry 25
    dw MetaSprites3B_507CSet2EFrame26 ; entry 26
    dw MetaSprites3B_507CSet2EFrame27 ; entry 27
    dw MetaSprites3B_507CSet2EFrame28 ; entry 28
    dw MetaSprites3B_507CSet2EFrame28 ; entry 29
    dw MetaSprites3B_507CSet2EFrame28 ; entry 30
    dw MetaSprites3B_507CSet2EFrame28 ; entry 31

; frame 0 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame0::
    db $f8, $b0, $14, $00 ; entry 0
    db $e0, $b8, $00, $00 ; entry 1
    db $e0, $c0, $01, $00 ; entry 2
    db $e0, $c8, $02, $00 ; entry 3
    db $f0, $d8, $10, $00 ; entry 4
    db $f8, $c8, $15, $00 ; entry 5
    db $f8, $c0, $14, $00 ; entry 6
    db $e8, $b0, $04, $00 ; entry 7
    db $e8, $b8, $05, $00 ; entry 8
    db $e8, $c0, $06, $00 ; entry 9
    db $e8, $c8, $07, $00 ; entry 10
    db $e8, $d0, $08, $00 ; entry 11
    db $f0, $b0, $0b, $00 ; entry 12
    db $f0, $b8, $0c, $00 ; entry 13
    db $f0, $c0, $0d, $00 ; entry 14
    db $f0, $c8, $0e, $00 ; entry 15
    db $f0, $d0, $0f, $00 ; entry 16
    db $f8, $b8, $13, $00 ; entry 17
    db $80 ; end

; frame 1 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame1::
    db $f0, $c0, $14, $00 ; entry 0
    db $d8, $c8, $00, $00 ; entry 1
    db $d8, $d0, $01, $00 ; entry 2
    db $d8, $d8, $02, $00 ; entry 3
    db $e8, $e8, $10, $00 ; entry 4
    db $f0, $d8, $15, $00 ; entry 5
    db $f0, $d0, $14, $00 ; entry 6
    db $e0, $b8, $03, $00 ; entry 7
    db $e0, $c0, $04, $00 ; entry 8
    db $e0, $c8, $05, $00 ; entry 9
    db $e0, $d0, $06, $00 ; entry 10
    db $e0, $d8, $07, $00 ; entry 11
    db $e0, $e0, $08, $00 ; entry 12
    db $f0, $b0, $11, $00 ; entry 13
    db $f0, $b8, $12, $00 ; entry 14
    db $e8, $b0, $09, $00 ; entry 15
    db $e8, $b8, $0a, $00 ; entry 16
    db $e8, $c0, $0b, $00 ; entry 17
    db $e8, $c8, $0c, $00 ; entry 18
    db $e8, $d0, $0d, $00 ; entry 19
    db $e8, $d8, $0e, $00 ; entry 20
    db $e8, $e0, $0f, $00 ; entry 21
    db $f0, $c8, $13, $00 ; entry 22
    db $f8, $b0, $17, $00 ; entry 23
    db $f8, $c8, $19, $00 ; entry 24
    db $f8, $b8, $18, $00 ; entry 25
    db $f8, $c0, $18, $00 ; entry 26
    db $f8, $d0, $18, $00 ; entry 27
    db $80 ; end

; frame 2 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame2::
    db $e8, $c8, $14, $00 ; entry 0
    db $d0, $d0, $00, $00 ; entry 1
    db $d0, $d8, $01, $00 ; entry 2
    db $d0, $e0, $02, $00 ; entry 3
    db $e0, $f0, $10, $00 ; entry 4
    db $e8, $e0, $15, $00 ; entry 5
    db $e8, $d8, $14, $00 ; entry 6
    db $d8, $c0, $03, $00 ; entry 7
    db $d8, $c8, $04, $00 ; entry 8
    db $d8, $d0, $05, $00 ; entry 9
    db $d8, $d8, $06, $00 ; entry 10
    db $d8, $e0, $07, $00 ; entry 11
    db $d8, $e8, $08, $00 ; entry 12
    db $e8, $b8, $11, $00 ; entry 13
    db $e8, $c0, $12, $00 ; entry 14
    db $f8, $e0, $15, $40 ; entry 15
    db $e0, $b8, $09, $00 ; entry 16
    db $e0, $c0, $0a, $00 ; entry 17
    db $e0, $c8, $0b, $00 ; entry 18
    db $e0, $d0, $0c, $00 ; entry 19
    db $e0, $d8, $0d, $00 ; entry 20
    db $e0, $e0, $0e, $00 ; entry 21
    db $e0, $e8, $0f, $00 ; entry 22
    db $e8, $d0, $13, $00 ; entry 23
    db $f8, $c0, $1c, $00 ; entry 24
    db $f8, $d8, $1d, $00 ; entry 25
    db $f0, $b8, $17, $00 ; entry 26
    db $f0, $d0, $19, $00 ; entry 27
    db $f0, $c0, $18, $00 ; entry 28
    db $f0, $b0, $16, $00 ; entry 29
    db $f8, $b0, $1a, $00 ; entry 30
    db $f0, $c8, $18, $00 ; entry 31
    db $f0, $d8, $18, $00 ; entry 32
    db $f8, $d0, $1c, $00 ; entry 33
    db $f8, $c8, $18, $00 ; entry 34
    db $f8, $b8, $1b, $00 ; entry 35
    db $80 ; end

; frame 3 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame3::
    db $e8, $d0, $14, $00 ; entry 0
    db $d0, $d8, $00, $00 ; entry 1
    db $d0, $e0, $01, $00 ; entry 2
    db $d0, $e8, $02, $00 ; entry 3
    db $e0, $f8, $10, $00 ; entry 4
    db $e8, $e8, $15, $00 ; entry 5
    db $e8, $e0, $14, $00 ; entry 6
    db $d8, $c8, $03, $00 ; entry 7
    db $d8, $d0, $04, $00 ; entry 8
    db $d8, $d8, $05, $00 ; entry 9
    db $d8, $e0, $06, $00 ; entry 10
    db $d8, $e8, $07, $00 ; entry 11
    db $d8, $f0, $08, $00 ; entry 12
    db $e8, $c0, $11, $00 ; entry 13
    db $e8, $c8, $12, $00 ; entry 14
    db $f8, $e8, $15, $40 ; entry 15
    db $e0, $c0, $09, $00 ; entry 16
    db $e0, $c8, $0a, $00 ; entry 17
    db $e0, $d0, $0b, $00 ; entry 18
    db $e0, $d8, $0c, $00 ; entry 19
    db $e0, $e0, $0d, $00 ; entry 20
    db $e0, $e8, $0e, $00 ; entry 21
    db $e0, $f0, $0f, $00 ; entry 22
    db $e8, $d8, $13, $00 ; entry 23
    db $f8, $c0, $1b, $00 ; entry 24
    db $f8, $c8, $1c, $00 ; entry 25
    db $f8, $e0, $1d, $00 ; entry 26
    db $f0, $c0, $17, $00 ; entry 27
    db $f0, $d8, $19, $00 ; entry 28
    db $f0, $c8, $18, $00 ; entry 29
    db $f0, $b8, $16, $00 ; entry 30
    db $f8, $b0, $16, $00 ; entry 31
    db $f8, $b8, $1a, $00 ; entry 32
    db $f0, $d0, $18, $00 ; entry 33
    db $f0, $e0, $18, $00 ; entry 34
    db $f8, $d8, $1c, $00 ; entry 35
    db $f8, $d0, $18, $00 ; entry 36
    db $80 ; end

; frame 4 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame4::
    db $e8, $e0, $14, $00 ; entry 0
    db $d0, $e8, $00, $00 ; entry 1
    db $d0, $f0, $01, $00 ; entry 2
    db $d0, $f8, $02, $00 ; entry 3
    db $e0, $08, $10, $00 ; entry 4
    db $e8, $f8, $15, $00 ; entry 5
    db $e8, $f0, $14, $00 ; entry 6
    db $d8, $d8, $03, $00 ; entry 7
    db $d8, $e0, $04, $00 ; entry 8
    db $d8, $e8, $05, $00 ; entry 9
    db $d8, $f0, $06, $00 ; entry 10
    db $d8, $f8, $07, $00 ; entry 11
    db $d8, $00, $08, $00 ; entry 12
    db $e8, $d0, $11, $00 ; entry 13
    db $e8, $d8, $12, $00 ; entry 14
    db $f8, $f8, $15, $40 ; entry 15
    db $e0, $d0, $09, $00 ; entry 16
    db $e0, $d8, $0a, $00 ; entry 17
    db $e0, $e0, $0b, $00 ; entry 18
    db $e0, $e8, $0c, $00 ; entry 19
    db $e0, $f0, $0d, $00 ; entry 20
    db $e0, $f8, $0e, $00 ; entry 21
    db $e0, $00, $0f, $00 ; entry 22
    db $e8, $e8, $13, $00 ; entry 23
    db $f8, $d0, $1b, $00 ; entry 24
    db $f8, $d8, $1c, $00 ; entry 25
    db $f8, $f0, $1d, $00 ; entry 26
    db $f0, $d0, $17, $00 ; entry 27
    db $f0, $e8, $19, $00 ; entry 28
    db $f0, $c8, $16, $00 ; entry 29
    db $f8, $c8, $1a, $00 ; entry 30
    db $f0, $e0, $18, $00 ; entry 31
    db $f0, $f0, $18, $00 ; entry 32
    db $f8, $e8, $1c, $00 ; entry 33
    db $f8, $b0, $20, $00 ; entry 34
    db $f8, $b8, $21, $00 ; entry 35
    db $f8, $c0, $1f, $00 ; entry 36
    db $f0, $d8, $19, $00 ; entry 37
    db $f8, $e0, $14, $40 ; entry 38
    db $80 ; end

; frame 5 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame5::
    db $f0, $e8, $14, $00 ; entry 0
    db $d8, $f0, $00, $00 ; entry 1
    db $d8, $f8, $01, $00 ; entry 2
    db $d8, $00, $02, $00 ; entry 3
    db $e8, $10, $10, $00 ; entry 4
    db $f0, $00, $15, $00 ; entry 5
    db $f0, $f8, $14, $00 ; entry 6
    db $e0, $e0, $03, $00 ; entry 7
    db $e0, $e8, $04, $00 ; entry 8
    db $e0, $f0, $05, $00 ; entry 9
    db $e0, $f8, $06, $00 ; entry 10
    db $e0, $00, $07, $00 ; entry 11
    db $e0, $08, $08, $00 ; entry 12
    db $f0, $e0, $12, $00 ; entry 13
    db $e8, $d8, $09, $00 ; entry 14
    db $e8, $e0, $0a, $00 ; entry 15
    db $e8, $e8, $0b, $00 ; entry 16
    db $e8, $f0, $0c, $00 ; entry 17
    db $e8, $f8, $0d, $00 ; entry 18
    db $e8, $00, $0e, $00 ; entry 19
    db $e8, $08, $0f, $00 ; entry 20
    db $f0, $f0, $13, $00 ; entry 21
    db $f8, $c0, $20, $00 ; entry 22
    db $f8, $c8, $21, $00 ; entry 23
    db $f8, $f8, $1d, $00 ; entry 24
    db $f8, $f0, $1c, $00 ; entry 25
    db $f8, $b0, $20, $20 ; entry 26
    db $f8, $00, $15, $40 ; entry 27
    db $f8, $e0, $12, $40 ; entry 28
    db $f8, $d8, $0e, $00 ; entry 29
    db $f8, $e8, $14, $40 ; entry 30
    db $f8, $d0, $23, $20 ; entry 31
    db $f0, $d8, $11, $00 ; entry 32
    db $f0, $d4, $16, $00 ; entry 33
    db $80 ; end

; frame 6 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame6::
    db $f8, $f8, $14, $00 ; entry 0
    db $e8, $f0, $03, $00 ; entry 1
    db $e8, $f8, $04, $00 ; entry 2
    db $e8, $00, $05, $00 ; entry 3
    db $f0, $00, $0c, $00 ; entry 4
    db $f0, $f8, $0c, $00 ; entry 5
    db $e8, $20, $27, $00 ; entry 6
    db $f8, $18, $2a, $00 ; entry 7
    db $e0, $18, $27, $00 ; entry 8
    db $e8, $18, $29, $00 ; entry 9
    db $f0, $18, $07, $00 ; entry 10
    db $f0, $08, $06, $00 ; entry 11
    db $f0, $10, $07, $00 ; entry 12
    db $f8, $00, $0b, $00 ; entry 13
    db $f8, $08, $0c, $00 ; entry 14
    db $f8, $10, $0e, $00 ; entry 15
    db $e8, $10, $28, $00 ; entry 16
    db $e8, $08, $07, $00 ; entry 17
    db $e0, $08, $27, $00 ; entry 18
    db $f0, $e8, $21, $00 ; entry 19
    db $f0, $f0, $22, $00 ; entry 20
    db $f0, $e0, $20, $00 ; entry 21
    db $f8, $d8, $22, $00 ; entry 22
    db $f8, $e8, $25, $00 ; entry 23
    db $f8, $e0, $24, $00 ; entry 24
    db $f0, $20, $29, $00 ; entry 25
    db $f8, $20, $2b, $00 ; entry 26
    db $f8, $f0, $2c, $00 ; entry 27
    db $80 ; end

; frame 7 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame7::
    db $e8, $18, $00, $00 ; entry 0
    db $e8, $20, $01, $00 ; entry 1
    db $e8, $28, $02, $00 ; entry 2
    db $f0, $08, $03, $00 ; entry 3
    db $f0, $10, $04, $00 ; entry 4
    db $f0, $18, $05, $00 ; entry 5
    db $f8, $18, $0c, $00 ; entry 6
    db $f0, $20, $0e, $00 ; entry 7
    db $f0, $28, $0f, $00 ; entry 8
    db $f8, $20, $06, $00 ; entry 9
    db $f8, $28, $07, $00 ; entry 10
    db $f8, $10, $0c, $00 ; entry 11
    db $f8, $f0, $20, $00 ; entry 12
    db $f8, $f8, $21, $00 ; entry 13
    db $f8, $00, $22, $00 ; entry 14
    db $f8, $08, $24, $00 ; entry 15
    db $f0, $30, $10, $00 ; entry 16
    db $f8, $30, $10, $00 ; entry 17
    db $80 ; end

; frame 8 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame8::
    db $e8, $40, $27, $00 ; entry 0
    db $f8, $38, $2a, $00 ; entry 1
    db $f8, $40, $2b, $00 ; entry 2
    db $f0, $38, $28, $00 ; entry 3
    db $f0, $40, $29, $00 ; entry 4
    db $f0, $28, $00, $00 ; entry 5
    db $f0, $30, $04, $00 ; entry 6
    db $f8, $28, $0c, $00 ; entry 7
    db $f8, $30, $0d, $00 ; entry 8
    db $f8, $10, $20, $00 ; entry 9
    db $f8, $18, $21, $00 ; entry 10
    db $f8, $20, $22, $00 ; entry 11
    db $f8, $08, $20, $20 ; entry 12
    db $f8, $00, $21, $20 ; entry 13
    db $80 ; end

; frame 9 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame9::
    db $f8, $00, $23, $20 ; entry 0
    db $f0, $08, $20, $00 ; entry 1
    db $f0, $10, $21, $00 ; entry 2
    db $f0, $28, $21, $20 ; entry 3
    db $f0, $20, $22, $20 ; entry 4
    db $f0, $18, $23, $20 ; entry 5
    db $f8, $28, $25, $20 ; entry 6
    db $f8, $20, $26, $20 ; entry 7
    db $f8, $08, $24, $00 ; entry 8
    db $f8, $10, $25, $00 ; entry 9
    db $f8, $18, $2c, $00 ; entry 10
    db $f0, $30, $20, $20 ; entry 11
    db $f8, $30, $24, $20 ; entry 12
    db $f8, $38, $23, $00 ; entry 13
    db $f8, $48, $20, $20 ; entry 14
    db $f8, $40, $21, $20 ; entry 15
    db $80 ; end

; frame 10 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame10::
    db $f8, $08, $20, $00 ; entry 0
    db $f8, $10, $21, $00 ; entry 1
    db $f8, $18, $23, $20 ; entry 2
    db $f0, $20, $20, $00 ; entry 3
    db $f0, $28, $21, $00 ; entry 4
    db $f0, $40, $21, $20 ; entry 5
    db $f0, $38, $22, $20 ; entry 6
    db $f0, $30, $23, $20 ; entry 7
    db $f0, $48, $20, $20 ; entry 8
    db $f8, $48, $24, $20 ; entry 9
    db $f8, $40, $25, $20 ; entry 10
    db $f8, $20, $24, $00 ; entry 11
    db $f8, $28, $25, $00 ; entry 12
    db $f8, $30, $26, $00 ; entry 13
    db $f8, $00, $20, $20 ; entry 14
    db $f8, $38, $2c, $00 ; entry 15
    db $80 ; end

; frame 11 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame11::
    db $f8, $20, $20, $00 ; entry 0
    db $f8, $28, $21, $00 ; entry 1
    db $f8, $30, $23, $20 ; entry 2
    db $f0, $38, $20, $00 ; entry 3
    db $f0, $40, $21, $00 ; entry 4
    db $f0, $48, $23, $20 ; entry 5
    db $f8, $38, $24, $00 ; entry 6
    db $f8, $40, $25, $00 ; entry 7
    db $f8, $48, $26, $00 ; entry 8
    db $f8, $18, $20, $20 ; entry 9
    db $f8, $10, $21, $20 ; entry 10
    db $f8, $08, $23, $00 ; entry 11
    db $f8, $00, $22, $00 ; entry 12
    db $80 ; end

; frame 12 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame12::
    db $f8, $08, $20, $00 ; entry 0
    db $f8, $10, $21, $00 ; entry 1
    db $f8, $38, $20, $00 ; entry 2
    db $f8, $40, $21, $00 ; entry 3
    db $f8, $48, $23, $20 ; entry 4
    db $f8, $00, $20, $20 ; entry 5
    db $f8, $30, $20, $20 ; entry 6
    db $f8, $28, $21, $20 ; entry 7
    db $f8, $20, $23, $00 ; entry 8
    db $f8, $18, $22, $00 ; entry 9
    db $80 ; end

; frame 13 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame13::
    db $f8, $20, $20, $00 ; entry 0
    db $f8, $28, $21, $00 ; entry 1
    db $f8, $18, $20, $20 ; entry 2
    db $f8, $10, $21, $20 ; entry 3
    db $f8, $48, $20, $20 ; entry 4
    db $f8, $40, $21, $20 ; entry 5
    db $f8, $38, $23, $00 ; entry 6
    db $f8, $30, $22, $00 ; entry 7
    db $f8, $08, $23, $00 ; entry 8
    db $f8, $00, $25, $00 ; entry 9
    db $80 ; end

; frame 14 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame14::
    db $f0, $28, $20, $00 ; entry 0
    db $f0, $30, $21, $00 ; entry 1
    db $f0, $38, $23, $20 ; entry 2
    db $f8, $28, $24, $00 ; entry 3
    db $f8, $30, $25, $00 ; entry 4
    db $f8, $10, $20, $00 ; entry 5
    db $f8, $18, $21, $00 ; entry 6
    db $f8, $20, $23, $20 ; entry 7
    db $f8, $08, $20, $20 ; entry 8
    db $f8, $00, $21, $20 ; entry 9
    db $f0, $48, $21, $20 ; entry 10
    db $f0, $40, $22, $20 ; entry 11
    db $f8, $48, $25, $20 ; entry 12
    db $f8, $40, $26, $20 ; entry 13
    db $f8, $38, $2c, $00 ; entry 14
    db $80 ; end

; frame 15 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame15::
    db $f8, $f8, $21, $00 ; entry 0
    db $f8, $00, $22, $00 ; entry 1
    db $f8, $20, $20, $20 ; entry 2
    db $f8, $18, $21, $20 ; entry 3
    db $f8, $10, $23, $00 ; entry 4
    db $f8, $30, $20, $00 ; entry 5
    db $f8, $38, $21, $00 ; entry 6
    db $f8, $40, $23, $20 ; entry 7
    db $f8, $48, $22, $20 ; entry 8
    db $f8, $08, $2c, $20 ; entry 9
    db $80 ; end

; frame 16 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame16::
    db $f8, $00, $20, $20 ; entry 0
    db $f8, $f8, $21, $20 ; entry 1
    db $f8, $f0, $22, $20 ; entry 2
    db $f8, $d0, $20, $00 ; entry 3
    db $f8, $d8, $21, $00 ; entry 4
    db $f8, $e0, $23, $20 ; entry 5
    db $f8, $30, $20, $00 ; entry 6
    db $f8, $38, $20, $20 ; entry 7
    db $f8, $e8, $2c, $40 ; entry 8
    db $80 ; end

; frame 17 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame17::
    db $f8, $40, $20, $00 ; entry 0
    db $f8, $48, $20, $20 ; entry 1
    db $f8, $00, $20, $00 ; entry 2
    db $f8, $08, $20, $20 ; entry 3
    db $f8, $d8, $20, $00 ; entry 4
    db $f8, $e0, $20, $20 ; entry 5
    db $f8, $c8, $20, $00 ; entry 6
    db $f8, $d0, $20, $20 ; entry 7
    db $80 ; end

; frame 18 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame18::
    db $f8, $d0, $21, $00 ; entry 0
    db $f8, $c8, $21, $20 ; entry 1
    db $f8, $c0, $22, $20 ; entry 2
    db $f0, $b8, $20, $20 ; entry 3
    db $f0, $b0, $21, $20 ; entry 4
    db $f8, $b8, $24, $20 ; entry 5
    db $f8, $b0, $25, $20 ; entry 6
    db $f0, $25, $27, $20 ; entry 7
    db $f8, $25, $29, $20 ; entry 8
    db $f8, $2d, $08, $00 ; entry 9
    db $80 ; end

; frame 19 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame19::
    db $f8, $e8, $20, $20 ; entry 0
    db $f8, $e0, $21, $20 ; entry 1
    db $f8, $d8, $22, $20 ; entry 2
    db $f0, $d0, $20, $20 ; entry 3
    db $f0, $c8, $21, $20 ; entry 4
    db $f0, $b0, $21, $00 ; entry 5
    db $f0, $b8, $22, $00 ; entry 6
    db $f0, $c0, $23, $00 ; entry 7
    db $f8, $b0, $24, $00 ; entry 8
    db $f8, $b8, $25, $00 ; entry 9
    db $f8, $c8, $26, $00 ; entry 10
    db $f8, $d0, $24, $00 ; entry 11
    db $f8, $34, $29, $20 ; entry 12
    db $f0, $34, $27, $20 ; entry 13
    db $f8, $3c, $08, $00 ; entry 14
    db $f8, $c0, $2c, $00 ; entry 15
    db $80 ; end

; frame 20 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame20::
    db $f8, $c0, $22, $00 ; entry 0
    db $f0, $c8, $20, $00 ; entry 1
    db $f0, $d0, $21, $00 ; entry 2
    db $f0, $e8, $21, $20 ; entry 3
    db $f0, $e0, $22, $20 ; entry 4
    db $f0, $d8, $23, $20 ; entry 5
    db $f8, $e8, $24, $20 ; entry 6
    db $f8, $e0, $25, $20 ; entry 7
    db $f8, $d0, $26, $20 ; entry 8
    db $f8, $c8, $24, $20 ; entry 9
    db $f0, $f0, $20, $20 ; entry 10
    db $f8, $f8, $22, $20 ; entry 11
    db $f8, $f0, $24, $00 ; entry 12
    db $f8, $d8, $2c, $00 ; entry 13
    db $f8, $b0, $20, $00 ; entry 14
    db $f8, $b8, $21, $00 ; entry 15
    db $80 ; end

; frame 21 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame21::
    db $f8, $c0, $20, $00 ; entry 0
    db $f8, $c8, $21, $00 ; entry 1
    db $f8, $b8, $20, $20 ; entry 2
    db $f8, $b0, $21, $20 ; entry 3
    db $f8, $f0, $20, $00 ; entry 4
    db $f8, $f8, $21, $00 ; entry 5
    db $f8, $e0, $21, $20 ; entry 6
    db $f8, $d8, $22, $20 ; entry 7
    db $f8, $d0, $23, $20 ; entry 8
    db $f8, $e8, $20, $20 ; entry 9
    db $80 ; end

; frame 22 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame22::
    db $f8, $d8, $20, $00 ; entry 0
    db $f8, $e0, $21, $00 ; entry 1
    db $f8, $d0, $20, $20 ; entry 2
    db $f8, $c8, $21, $20 ; entry 3
    db $f8, $f8, $21, $20 ; entry 4
    db $f8, $f0, $23, $00 ; entry 5
    db $f8, $e8, $22, $00 ; entry 6
    db $f8, $c0, $23, $00 ; entry 7
    db $f8, $b0, $24, $00 ; entry 8
    db $f8, $b8, $25, $00 ; entry 9
    db $f0, $b0, $21, $20 ; entry 10
    db $f0, $b8, $20, $20 ; entry 11
    db $80 ; end

; frame 23 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame23::
    db $f8, $f0, $20, $00 ; entry 0
    db $f8, $f8, $21, $00 ; entry 1
    db $f8, $e8, $20, $20 ; entry 2
    db $f8, $e0, $21, $20 ; entry 3
    db $f8, $d8, $23, $00 ; entry 4
    db $f8, $c8, $24, $00 ; entry 5
    db $f8, $d0, $25, $00 ; entry 6
    db $f0, $c0, $21, $20 ; entry 7
    db $f0, $b8, $22, $20 ; entry 8
    db $f0, $c8, $20, $20 ; entry 9
    db $f8, $c0, $25, $20 ; entry 10
    db $f8, $b8, $26, $20 ; entry 11
    db $f0, $b0, $18, $00 ; entry 12
    db $f8, $b0, $2c, $00 ; entry 13
    db $80 ; end

; frame 24 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame24::
    db $f8, $f8, $21, $20 ; entry 0
    db $f8, $f0, $23, $00 ; entry 1
    db $f8, $e0, $24, $00 ; entry 2
    db $f8, $e8, $25, $00 ; entry 3
    db $f0, $d8, $21, $20 ; entry 4
    db $f0, $d0, $22, $20 ; entry 5
    db $f0, $e0, $20, $20 ; entry 6
    db $f8, $d8, $25, $20 ; entry 7
    db $f8, $d0, $26, $20 ; entry 8
    db $f0, $c8, $18, $00 ; entry 9
    db $f0, $b0, $20, $00 ; entry 10
    db $f0, $b8, $21, $00 ; entry 11
    db $f0, $c0, $23, $20 ; entry 12
    db $f8, $b0, $24, $00 ; entry 13
    db $f8, $b8, $25, $00 ; entry 14
    db $f8, $c0, $26, $00 ; entry 15
    db $f8, $c8, $2c, $00 ; entry 16
    db $80 ; end

; frame 25 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame25::
    db $f8, $f8, $24, $00 ; entry 0
    db $f0, $f0, $21, $20 ; entry 1
    db $f0, $e8, $22, $20 ; entry 2
    db $f0, $f8, $20, $20 ; entry 3
    db $f8, $f0, $25, $20 ; entry 4
    db $f0, $c8, $20, $00 ; entry 5
    db $f0, $d0, $21, $00 ; entry 6
    db $f0, $d8, $23, $20 ; entry 7
    db $f8, $c8, $24, $00 ; entry 8
    db $f8, $d0, $25, $00 ; entry 9
    db $f8, $d8, $26, $00 ; entry 10
    db $f8, $b0, $20, $00 ; entry 11
    db $f8, $b8, $21, $00 ; entry 12
    db $f8, $c0, $23, $20 ; entry 13
    db $f8, $e8, $2c, $00 ; entry 14
    db $f8, $e0, $2c, $60 ; entry 15
    db $f0, $e0, $2c, $00 ; entry 16
    db $80 ; end

; frame 26 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame26::
    db $f8, $d8, $20, $00 ; entry 0
    db $f8, $e0, $21, $00 ; entry 1
    db $f8, $d0, $20, $20 ; entry 2
    db $f8, $c8, $21, $20 ; entry 3
    db $f8, $e8, $22, $00 ; entry 4
    db $f8, $c0, $23, $00 ; entry 5
    db $f8, $b0, $24, $00 ; entry 6
    db $f8, $b8, $25, $00 ; entry 7
    db $f0, $b0, $20, $20 ; entry 8
    db $f8, $f8, $23, $00 ; entry 9
    db $f8, $f0, $26, $00 ; entry 10
    db $80 ; end

; frame 27 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame27::
    db $f8, $f0, $20, $00 ; entry 0
    db $f8, $e8, $20, $20 ; entry 1
    db $f8, $e0, $21, $20 ; entry 2
    db $f8, $d8, $23, $00 ; entry 3
    db $f8, $c8, $24, $00 ; entry 4
    db $f8, $d0, $25, $00 ; entry 5
    db $f0, $c8, $20, $20 ; entry 6
    db $f0, $b0, $23, $20 ; entry 7
    db $f0, $c0, $21, $20 ; entry 8
    db $f0, $b8, $22, $20 ; entry 9
    db $f8, $c0, $25, $20 ; entry 10
    db $f8, $b0, $2c, $20 ; entry 11
    db $f8, $b8, $26, $00 ; entry 12
    db $80 ; end

; frame 28 of MetaSprites3B_507CSet2E; ends with $80 (E-0147)
MetaSprites3B_507CSet2EFrame28::
    db $80 ; end

; meta-sprite set 47 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites3B_507CSet2F::
    dw MetaSprites3B_507CSet2FFrame0 ; entry 0
    dw MetaSprites3B_507CSet2FFrame1 ; entry 1
    dw MetaSprites3B_507CSet2FFrame2 ; entry 2
    dw MetaSprites3B_507CSet2FFrame3 ; entry 3
    dw MetaSprites3B_507CSet2FFrame4 ; entry 4
    dw MetaSprites3B_507CSet2FFrame5 ; entry 5
    dw MetaSprites3B_507CSet2FFrame6 ; entry 6
    dw MetaSprites3B_507CSet2FFrame7 ; entry 7
    dw MetaSprites3B_507CSet2FFrame8 ; entry 8
    dw MetaSprites3B_507CSet2FFrame9 ; entry 9
    dw MetaSprites3B_507CSet2FFrame10 ; entry 10
    dw MetaSprites3B_507CSet2FFrame11 ; entry 11
    dw MetaSprites3B_507CSet2FFrame12 ; entry 12
    dw MetaSprites3B_507CSet2FFrame13 ; entry 13
    dw MetaSprites3B_507CSet2FFrame14 ; entry 14
    dw MetaSprites3B_507CSet2FFrame15 ; entry 15
    dw MetaSprites3B_507CSet2FFrame16 ; entry 16
    dw MetaSprites3B_507CSet2FFrame17 ; entry 17
    dw MetaSprites3B_507CSet2FFrame18 ; entry 18
    dw MetaSprites3B_507CSet2FFrame18 ; entry 19
    dw MetaSprites3B_507CSet2FFrame18 ; entry 20
    dw MetaSprites3B_507CSet2FFrame18 ; entry 21
    dw MetaSprites3B_507CSet2FFrame18 ; entry 22
    dw MetaSprites3B_507CSet2FFrame18 ; entry 23
    dw MetaSprites3B_507CSet2FFrame18 ; entry 24
    dw MetaSprites3B_507CSet2FFrame18 ; entry 25
    dw MetaSprites3B_507CSet2FFrame18 ; entry 26
    dw MetaSprites3B_507CSet2FFrame18 ; entry 27
    dw MetaSprites3B_507CSet2FFrame18 ; entry 28
    dw MetaSprites3B_507CSet2FFrame18 ; entry 29
    dw MetaSprites3B_507CSet2FFrame18 ; entry 30
    dw MetaSprites3B_507CSet2FFrame18 ; entry 31

; frame 0 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame0::
    db $d8, $03, $20, $00 ; entry 0
    db $d8, $0b, $21, $00 ; entry 1
    db $d0, $03, $22, $00 ; entry 2
    db $d0, $0b, $23, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame1::
    db $dc, $00, $20, $00 ; entry 0
    db $dc, $08, $21, $00 ; entry 1
    db $e4, $f8, $20, $60 ; entry 2
    db $e4, $f0, $21, $60 ; entry 3
    db $d4, $00, $22, $00 ; entry 4
    db $d4, $08, $23, $00 ; entry 5
    db $ec, $f8, $22, $60 ; entry 6
    db $ec, $f0, $23, $60 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame2::
    db $f8, $f0, $24, $00 ; entry 0
    db $e8, $f4, $27, $00 ; entry 1
    db $e8, $fc, $28, $00 ; entry 2
    db $f0, $f0, $25, $00 ; entry 3
    db $f0, $f8, $26, $00 ; entry 4
    db $d8, $03, $2b, $00 ; entry 5
    db $e0, $f8, $29, $00 ; entry 6
    db $e0, $00, $2a, $00 ; entry 7
    db $d0, $08, $2b, $00 ; entry 8
    db $80 ; end

; frame 3 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame3::
    db $f8, $eb, $27, $00 ; entry 0
    db $f8, $f3, $28, $00 ; entry 1
    db $e8, $fa, $2b, $00 ; entry 2
    db $f0, $ef, $29, $00 ; entry 3
    db $f0, $f7, $2a, $00 ; entry 4
    db $e0, $fe, $2c, $00 ; entry 5
    db $d0, $08, $2c, $00 ; entry 6
    db $d8, $03, $2c, $00 ; entry 7
    db $80 ; end

; frame 4 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame4::
    db $f0, $f4, $2d, $00 ; entry 0
    db $f8, $ef, $2d, $00 ; entry 1
    db $e8, $f9, $2c, $00 ; entry 2
    db $dc, $01, $2c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame5::
    db $f0, $f4, $2d, $00 ; entry 0
    db $e8, $f9, $2d, $00 ; entry 1
    db $e0, $fe, $2d, $00 ; entry 2
    db $f8, $ef, $2b, $00 ; entry 3
    db $80 ; end

; frame 6 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame6::
    db $f8, $ef, $2d, $00 ; entry 0
    db $f0, $f4, $2d, $00 ; entry 1
    db $e8, $f9, $2d, $00 ; entry 2
    db $80 ; end

; frame 7 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame7::
    db $f8, $f8, $00, $00 ; entry 0
    db $f8, $00, $01, $00 ; entry 1
    db $80 ; end

; frame 8 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame8::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $03, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 9 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame9::
    db $e8, $f8, $02, $00 ; entry 0
    db $e8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $f8, $f8, $06, $00 ; entry 4
    db $f8, $00, $07, $00 ; entry 5
    db $f8, $f0, $00, $00 ; entry 6
    db $f8, $08, $01, $00 ; entry 7
    db $80 ; end

; frame 10 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame10::
    db $d8, $f0, $08, $00 ; entry 0
    db $d8, $f8, $09, $00 ; entry 1
    db $d8, $08, $08, $20 ; entry 2
    db $d8, $00, $09, $20 ; entry 3
    db $e0, $f0, $0a, $00 ; entry 4
    db $e0, $f8, $0b, $00 ; entry 5
    db $e0, $08, $0a, $20 ; entry 6
    db $e0, $00, $0b, $20 ; entry 7
    db $e8, $f0, $0c, $00 ; entry 8
    db $e8, $f8, $0d, $00 ; entry 9
    db $e8, $08, $0c, $20 ; entry 10
    db $e8, $00, $0d, $20 ; entry 11
    db $f0, $f8, $0e, $00 ; entry 12
    db $f0, $00, $0f, $00 ; entry 13
    db $f8, $f8, $10, $00 ; entry 14
    db $f8, $00, $11, $00 ; entry 15
    db $f0, $f0, $02, $00 ; entry 16
    db $f0, $08, $03, $00 ; entry 17
    db $f8, $08, $05, $00 ; entry 18
    db $f8, $f0, $04, $00 ; entry 19
    db $80 ; end

; frame 11 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame11::
    db $e0, $f0, $12, $00 ; entry 0
    db $e0, $f8, $13, $00 ; entry 1
    db $e0, $08, $12, $20 ; entry 2
    db $e0, $00, $13, $20 ; entry 3
    db $e8, $f0, $0e, $40 ; entry 4
    db $e8, $08, $0f, $40 ; entry 5
    db $f0, $f0, $0e, $00 ; entry 6
    db $f0, $08, $0f, $00 ; entry 7
    db $f8, $f0, $10, $00 ; entry 8
    db $f8, $08, $11, $00 ; entry 9
    db $e8, $f8, $14, $00 ; entry 10
    db $e8, $00, $15, $00 ; entry 11
    db $f0, $f8, $16, $00 ; entry 12
    db $f0, $00, $17, $00 ; entry 13
    db $d0, $f0, $18, $00 ; entry 14
    db $d0, $f8, $19, $00 ; entry 15
    db $d0, $08, $18, $20 ; entry 16
    db $d0, $00, $19, $20 ; entry 17
    db $d8, $f0, $1a, $00 ; entry 18
    db $d8, $f8, $1b, $00 ; entry 19
    db $d8, $08, $1a, $20 ; entry 20
    db $d8, $00, $1b, $20 ; entry 21
    db $f8, $f8, $16, $00 ; entry 22
    db $f8, $00, $17, $00 ; entry 23
    db $80 ; end

; frame 12 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame12::
    db $d0, $00, $04, $20 ; entry 0
    db $d0, $f8, $05, $20 ; entry 1
    db $e8, $f8, $1c, $40 ; entry 2
    db $e8, $00, $1c, $60 ; entry 3
    db $f8, $f8, $1c, $00 ; entry 4
    db $f8, $00, $1c, $20 ; entry 5
    db $e0, $f0, $1a, $00 ; entry 6
    db $e0, $f8, $1b, $00 ; entry 7
    db $e0, $08, $1a, $20 ; entry 8
    db $e0, $00, $1b, $20 ; entry 9
    db $f0, $f0, $1e, $00 ; entry 10
    db $f0, $f8, $1f, $00 ; entry 11
    db $f0, $08, $1e, $20 ; entry 12
    db $f0, $00, $1f, $20 ; entry 13
    db $d8, $08, $18, $20 ; entry 14
    db $d8, $00, $19, $20 ; entry 15
    db $d8, $f0, $18, $00 ; entry 16
    db $d8, $f8, $19, $00 ; entry 17
    db $80 ; end

; frame 13 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame13::
    db $f0, $08, $18, $20 ; entry 0
    db $f0, $00, $19, $20 ; entry 1
    db $f0, $f0, $18, $00 ; entry 2
    db $f0, $f8, $19, $00 ; entry 3
    db $e0, $f8, $1c, $00 ; entry 4
    db $e0, $00, $1c, $20 ; entry 5
    db $e8, $f8, $1d, $20 ; entry 6
    db $e8, $00, $1d, $00 ; entry 7
    db $d0, $f8, $1d, $60 ; entry 8
    db $d0, $00, $1d, $40 ; entry 9
    db $d8, $f0, $1e, $00 ; entry 10
    db $d8, $f8, $1f, $00 ; entry 11
    db $d8, $08, $1e, $20 ; entry 12
    db $d8, $00, $1f, $20 ; entry 13
    db $f8, $f0, $1a, $00 ; entry 14
    db $f8, $f8, $1b, $00 ; entry 15
    db $f8, $08, $1a, $20 ; entry 16
    db $f8, $00, $1b, $20 ; entry 17
    db $80 ; end

; frame 14 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame14::
    db $e0, $08, $18, $20 ; entry 0
    db $e0, $00, $19, $20 ; entry 1
    db $e0, $f0, $18, $00 ; entry 2
    db $e0, $f8, $19, $00 ; entry 3
    db $f0, $f8, $1c, $00 ; entry 4
    db $d8, $00, $1d, $40 ; entry 5
    db $f0, $00, $1c, $20 ; entry 6
    db $d8, $f8, $1d, $60 ; entry 7
    db $d0, $f0, $1e, $00 ; entry 8
    db $d0, $f8, $1f, $00 ; entry 9
    db $d0, $08, $1e, $20 ; entry 10
    db $d0, $00, $1f, $20 ; entry 11
    db $f8, $f0, $1e, $00 ; entry 12
    db $f8, $f8, $1f, $00 ; entry 13
    db $f8, $08, $1e, $20 ; entry 14
    db $f8, $00, $1f, $20 ; entry 15
    db $e8, $f0, $1a, $00 ; entry 16
    db $e8, $f8, $1b, $00 ; entry 17
    db $e8, $08, $1a, $20 ; entry 18
    db $e8, $00, $1b, $20 ; entry 19
    db $80 ; end

; frame 15 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame15::
    db $e8, $f8, $1c, $00 ; entry 0
    db $e8, $00, $1c, $20 ; entry 1
    db $d0, $08, $18, $20 ; entry 2
    db $d0, $00, $19, $20 ; entry 3
    db $d0, $f0, $18, $00 ; entry 4
    db $d0, $f8, $19, $00 ; entry 5
    db $f8, $f8, $1d, $20 ; entry 6
    db $f8, $00, $1d, $00 ; entry 7
    db $f0, $f0, $1e, $00 ; entry 8
    db $f0, $f8, $1f, $00 ; entry 9
    db $f0, $08, $1e, $20 ; entry 10
    db $f0, $00, $1f, $20 ; entry 11
    db $e0, $f0, $1e, $00 ; entry 12
    db $e0, $f8, $1f, $00 ; entry 13
    db $e0, $08, $1e, $20 ; entry 14
    db $e0, $00, $1f, $20 ; entry 15
    db $d8, $f0, $1a, $00 ; entry 16
    db $d8, $f8, $1b, $00 ; entry 17
    db $d8, $08, $1a, $20 ; entry 18
    db $d8, $00, $1b, $20 ; entry 19
    db $80 ; end

; frame 16 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame16::
    db $d0, $04, $2e, $20 ; entry 0
    db $f8, $04, $2e, $20 ; entry 1
    db $f0, $04, $2e, $20 ; entry 2
    db $e8, $04, $2e, $20 ; entry 3
    db $e0, $04, $2e, $20 ; entry 4
    db $d8, $04, $2e, $20 ; entry 5
    db $d0, $f4, $2e, $00 ; entry 6
    db $d8, $f4, $2e, $00 ; entry 7
    db $e0, $f4, $2e, $00 ; entry 8
    db $e8, $f4, $2e, $00 ; entry 9
    db $f0, $f4, $2e, $00 ; entry 10
    db $f8, $f4, $2e, $00 ; entry 11
    db $d0, $fc, $2f, $00 ; entry 12
    db $d8, $fc, $2f, $00 ; entry 13
    db $e0, $fc, $2f, $00 ; entry 14
    db $e8, $fc, $2f, $00 ; entry 15
    db $f0, $fc, $2f, $00 ; entry 16
    db $f8, $fc, $2f, $00 ; entry 17
    db $80 ; end

; frame 17 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame17::
    db $d0, $f4, $2e, $20 ; entry 0
    db $f8, $f4, $2e, $20 ; entry 1
    db $f0, $f4, $2e, $20 ; entry 2
    db $e8, $f4, $2e, $20 ; entry 3
    db $e0, $f4, $2e, $20 ; entry 4
    db $d8, $f4, $2e, $20 ; entry 5
    db $d0, $04, $2e, $00 ; entry 6
    db $d8, $04, $2e, $00 ; entry 7
    db $e0, $04, $2e, $00 ; entry 8
    db $e8, $04, $2e, $00 ; entry 9
    db $f0, $04, $2e, $00 ; entry 10
    db $f8, $04, $2e, $00 ; entry 11
    db $d0, $fc, $2f, $20 ; entry 12
    db $d8, $fc, $2f, $20 ; entry 13
    db $e0, $fc, $2f, $20 ; entry 14
    db $e8, $fc, $2f, $20 ; entry 15
    db $f0, $fc, $2f, $20 ; entry 16
    db $f8, $fc, $2f, $20 ; entry 17
    db $80 ; end

; frame 18 of MetaSprites3B_507CSet2F; ends with $80 (E-0147)
MetaSprites3B_507CSet2FFrame18::
    db $80 ; end

; meta-sprite set 48 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites3B_507CSet30::
    dw MetaSprites3B_507CSet30Frame0 ; entry 0
    dw MetaSprites3B_507CSet30Frame1 ; entry 1
    dw MetaSprites3B_507CSet30Frame2 ; entry 2
    dw MetaSprites3B_507CSet30Frame3 ; entry 3
    dw MetaSprites3B_507CSet30Frame4 ; entry 4
    dw MetaSprites3B_507CSet30Frame5 ; entry 5
    dw MetaSprites3B_507CSet30Frame6 ; entry 6
    dw MetaSprites3B_507CSet30Frame7 ; entry 7
    dw MetaSprites3B_507CSet30Frame8 ; entry 8
    dw MetaSprites3B_507CSet30Frame9 ; entry 9
    dw MetaSprites3B_507CSet30Frame10 ; entry 10
    dw MetaSprites3B_507CSet30Frame11 ; entry 11
    dw MetaSprites3B_507CSet30Frame11 ; entry 12
    dw MetaSprites3B_507CSet30Frame11 ; entry 13
    dw MetaSprites3B_507CSet30Frame11 ; entry 14
    dw MetaSprites3B_507CSet30Frame11 ; entry 15
    dw MetaSprites3B_507CSet30Frame11 ; entry 16
    dw MetaSprites3B_507CSet30Frame11 ; entry 17
    dw MetaSprites3B_507CSet30Frame11 ; entry 18
    dw MetaSprites3B_507CSet30Frame11 ; entry 19
    dw MetaSprites3B_507CSet30Frame11 ; entry 20
    dw MetaSprites3B_507CSet30Frame11 ; entry 21
    dw MetaSprites3B_507CSet30Frame11 ; entry 22
    dw MetaSprites3B_507CSet30Frame11 ; entry 23
    dw MetaSprites3B_507CSet30Frame11 ; entry 24
    dw MetaSprites3B_507CSet30Frame11 ; entry 25
    dw MetaSprites3B_507CSet30Frame11 ; entry 26
    dw MetaSprites3B_507CSet30Frame11 ; entry 27
    dw MetaSprites3B_507CSet30Frame11 ; entry 28
    dw MetaSprites3B_507CSet30Frame11 ; entry 29
    dw MetaSprites3B_507CSet30Frame11 ; entry 30
    dw MetaSprites3B_507CSet30Frame11 ; entry 31

; frame 0 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame0::
    db $f8, $f8, $00, $00 ; entry 0
    db $f8, $00, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $03, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame2::
    db $f0, $00, $02, $20 ; entry 0
    db $f0, $f8, $03, $20 ; entry 1
    db $f8, $00, $04, $20 ; entry 2
    db $f8, $f8, $05, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame3::
    db $e8, $f8, $02, $00 ; entry 0
    db $e8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $f8, $f8, $06, $00 ; entry 4
    db $f8, $00, $07, $00 ; entry 5
    db $f8, $f0, $00, $00 ; entry 6
    db $f8, $08, $01, $00 ; entry 7
    db $80 ; end

; frame 4 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame4::
    db $d8, $f0, $08, $00 ; entry 0
    db $d8, $f8, $09, $00 ; entry 1
    db $d8, $08, $08, $20 ; entry 2
    db $d8, $00, $09, $20 ; entry 3
    db $e0, $f0, $0a, $00 ; entry 4
    db $e0, $f8, $0b, $00 ; entry 5
    db $e0, $08, $0a, $20 ; entry 6
    db $e0, $00, $0b, $20 ; entry 7
    db $e8, $f0, $0c, $00 ; entry 8
    db $e8, $f8, $0d, $00 ; entry 9
    db $e8, $08, $0c, $20 ; entry 10
    db $e8, $00, $0d, $20 ; entry 11
    db $f0, $f8, $0e, $00 ; entry 12
    db $f0, $00, $0f, $00 ; entry 13
    db $f8, $f8, $10, $00 ; entry 14
    db $f8, $00, $11, $00 ; entry 15
    db $f0, $f0, $02, $00 ; entry 16
    db $f0, $08, $03, $00 ; entry 17
    db $f8, $08, $05, $00 ; entry 18
    db $f8, $f0, $04, $00 ; entry 19
    db $80 ; end

; frame 5 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame5::
    db $d0, $f0, $18, $00 ; entry 0
    db $d0, $08, $18, $20 ; entry 1
    db $d0, $f8, $1a, $00 ; entry 2
    db $d0, $00, $1b, $00 ; entry 3
    db $d8, $f0, $28, $00 ; entry 4
    db $d8, $f8, $29, $00 ; entry 5
    db $d8, $08, $28, $20 ; entry 6
    db $d8, $00, $2b, $00 ; entry 7
    db $e0, $f0, $12, $00 ; entry 8
    db $e0, $f8, $13, $00 ; entry 9
    db $e0, $08, $12, $20 ; entry 10
    db $e0, $00, $13, $20 ; entry 11
    db $e8, $f0, $0e, $40 ; entry 12
    db $e8, $08, $0f, $40 ; entry 13
    db $f0, $f0, $0e, $00 ; entry 14
    db $f0, $08, $0f, $00 ; entry 15
    db $f8, $f0, $10, $00 ; entry 16
    db $f8, $08, $11, $00 ; entry 17
    db $e8, $f8, $14, $00 ; entry 18
    db $e8, $00, $15, $00 ; entry 19
    db $f0, $f8, $16, $00 ; entry 20
    db $f0, $00, $17, $00 ; entry 21
    db $f8, $f8, $20, $00 ; entry 22
    db $f8, $00, $21, $00 ; entry 23
    db $80 ; end

; frame 6 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame6::
    db $d0, $00, $04, $20 ; entry 0
    db $d0, $f8, $05, $20 ; entry 1
    db $d8, $e8, $18, $00 ; entry 2
    db $d8, $f0, $19, $00 ; entry 3
    db $d8, $f8, $1a, $00 ; entry 4
    db $d8, $00, $1b, $00 ; entry 5
    db $e0, $e8, $28, $00 ; entry 6
    db $e0, $f0, $29, $00 ; entry 7
    db $e0, $f8, $2a, $00 ; entry 8
    db $e0, $00, $2b, $00 ; entry 9
    db $d8, $10, $18, $20 ; entry 10
    db $d8, $08, $19, $20 ; entry 11
    db $e0, $10, $28, $20 ; entry 12
    db $e0, $08, $29, $20 ; entry 13
    db $e8, $f0, $1c, $00 ; entry 14
    db $e8, $f8, $1d, $00 ; entry 15
    db $e8, $08, $1c, $20 ; entry 16
    db $e8, $00, $1d, $20 ; entry 17
    db $f8, $f0, $1c, $00 ; entry 18
    db $f8, $f8, $1d, $00 ; entry 19
    db $f8, $08, $1c, $20 ; entry 20
    db $f8, $00, $1d, $20 ; entry 21
    db $f0, $e8, $22, $00 ; entry 22
    db $f0, $f0, $23, $00 ; entry 23
    db $f0, $f8, $24, $00 ; entry 24
    db $f0, $10, $22, $20 ; entry 25
    db $f0, $08, $23, $20 ; entry 26
    db $f0, $00, $24, $20 ; entry 27
    db $80 ; end

; frame 7 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame7::
    db $f8, $e8, $28, $00 ; entry 0
    db $f8, $10, $28, $20 ; entry 1
    db $f8, $08, $29, $20 ; entry 2
    db $f8, $f8, $2a, $00 ; entry 3
    db $f8, $00, $2b, $00 ; entry 4
    db $f8, $f0, $29, $00 ; entry 5
    db $f0, $10, $18, $20 ; entry 6
    db $f0, $08, $19, $20 ; entry 7
    db $f0, $f8, $1a, $00 ; entry 8
    db $f0, $00, $1b, $00 ; entry 9
    db $f0, $e8, $18, $00 ; entry 10
    db $f0, $f0, $19, $00 ; entry 11
    db $e8, $f0, $1e, $00 ; entry 12
    db $e8, $f8, $1f, $00 ; entry 13
    db $e8, $08, $1e, $20 ; entry 14
    db $e8, $00, $1f, $20 ; entry 15
    db $e0, $f0, $1c, $00 ; entry 16
    db $e0, $f8, $1d, $00 ; entry 17
    db $e0, $08, $1c, $20 ; entry 18
    db $e0, $00, $1d, $20 ; entry 19
    db $d8, $e8, $22, $00 ; entry 20
    db $d8, $f0, $23, $00 ; entry 21
    db $d8, $f8, $24, $00 ; entry 22
    db $d8, $10, $22, $20 ; entry 23
    db $d8, $08, $23, $20 ; entry 24
    db $d8, $00, $24, $20 ; entry 25
    db $d0, $f0, $1e, $00 ; entry 26
    db $d0, $f8, $1f, $00 ; entry 27
    db $d0, $08, $1e, $20 ; entry 28
    db $d0, $00, $1f, $20 ; entry 29
    db $80 ; end

; frame 8 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame8::
    db $e8, $e8, $28, $00 ; entry 0
    db $e8, $10, $28, $20 ; entry 1
    db $e8, $08, $29, $20 ; entry 2
    db $e8, $f8, $2a, $00 ; entry 3
    db $e8, $00, $2b, $00 ; entry 4
    db $e8, $f0, $29, $00 ; entry 5
    db $e0, $10, $18, $20 ; entry 6
    db $e0, $08, $19, $20 ; entry 7
    db $e0, $f8, $1a, $00 ; entry 8
    db $e0, $00, $1b, $00 ; entry 9
    db $e0, $e8, $18, $00 ; entry 10
    db $e0, $f0, $19, $00 ; entry 11
    db $f0, $f0, $1e, $00 ; entry 12
    db $f0, $f8, $1f, $00 ; entry 13
    db $f0, $08, $1e, $20 ; entry 14
    db $f0, $00, $1f, $20 ; entry 15
    db $f8, $e8, $22, $00 ; entry 16
    db $f8, $f0, $23, $00 ; entry 17
    db $f8, $f8, $24, $00 ; entry 18
    db $f8, $10, $22, $20 ; entry 19
    db $f8, $08, $23, $20 ; entry 20
    db $f8, $00, $24, $20 ; entry 21
    db $d8, $f0, $1e, $00 ; entry 22
    db $d8, $f8, $1f, $00 ; entry 23
    db $d8, $08, $1e, $20 ; entry 24
    db $d8, $00, $1f, $20 ; entry 25
    db $d0, $e8, $22, $00 ; entry 26
    db $d0, $f0, $23, $00 ; entry 27
    db $d0, $f8, $24, $00 ; entry 28
    db $d0, $10, $22, $20 ; entry 29
    db $d0, $08, $23, $20 ; entry 30
    db $d0, $00, $24, $20 ; entry 31
    db $80 ; end

; frame 9 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame9::
    db $f0, $e8, $22, $00 ; entry 0
    db $f0, $f0, $23, $00 ; entry 1
    db $f0, $f8, $24, $00 ; entry 2
    db $f0, $10, $22, $20 ; entry 3
    db $f0, $08, $23, $20 ; entry 4
    db $f0, $00, $24, $20 ; entry 5
    db $f8, $f0, $1e, $00 ; entry 6
    db $f8, $f8, $1f, $00 ; entry 7
    db $f8, $08, $1e, $20 ; entry 8
    db $f8, $00, $1f, $20 ; entry 9
    db $e0, $e8, $22, $00 ; entry 10
    db $e0, $f0, $23, $00 ; entry 11
    db $e0, $f8, $24, $00 ; entry 12
    db $e0, $10, $22, $20 ; entry 13
    db $e0, $08, $23, $20 ; entry 14
    db $e0, $00, $24, $20 ; entry 15
    db $e8, $f0, $1c, $00 ; entry 16
    db $e8, $f8, $1d, $00 ; entry 17
    db $e8, $08, $1c, $20 ; entry 18
    db $e8, $00, $1d, $20 ; entry 19
    db $d8, $e8, $28, $00 ; entry 20
    db $d8, $10, $28, $20 ; entry 21
    db $d8, $08, $29, $20 ; entry 22
    db $d8, $f8, $2a, $00 ; entry 23
    db $d8, $00, $2b, $00 ; entry 24
    db $d8, $f0, $29, $00 ; entry 25
    db $d0, $10, $18, $20 ; entry 26
    db $d0, $08, $19, $20 ; entry 27
    db $d0, $f8, $1a, $00 ; entry 28
    db $d0, $00, $1b, $00 ; entry 29
    db $d0, $e8, $18, $00 ; entry 30
    db $d0, $f0, $19, $00 ; entry 31
    db $80 ; end

; frame 10 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame10::
    db $d0, $f0, $25, $00 ; entry 0
    db $d0, $f8, $26, $00 ; entry 1
    db $d8, $f0, $27, $00 ; entry 2
    db $d8, $f8, $2c, $00 ; entry 3
    db $d0, $00, $25, $00 ; entry 4
    db $d0, $08, $26, $00 ; entry 5
    db $d8, $00, $27, $00 ; entry 6
    db $d8, $08, $2c, $00 ; entry 7
    db $e0, $f0, $25, $00 ; entry 8
    db $e0, $f8, $26, $00 ; entry 9
    db $e8, $f0, $27, $00 ; entry 10
    db $e8, $f8, $2c, $00 ; entry 11
    db $e0, $00, $25, $00 ; entry 12
    db $e0, $08, $26, $00 ; entry 13
    db $e8, $00, $27, $00 ; entry 14
    db $e8, $08, $2c, $00 ; entry 15
    db $f0, $00, $25, $00 ; entry 16
    db $f0, $08, $26, $00 ; entry 17
    db $f8, $00, $27, $00 ; entry 18
    db $f8, $08, $2c, $00 ; entry 19
    db $f0, $f0, $25, $00 ; entry 20
    db $f0, $f8, $26, $00 ; entry 21
    db $f8, $f0, $27, $00 ; entry 22
    db $f8, $f8, $2c, $00 ; entry 23
    db $80 ; end

; frame 11 of MetaSprites3B_507CSet30; ends with $80 (E-0147)
MetaSprites3B_507CSet30Frame11::
    db $80 ; end

; meta-sprite set 49 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites3B_507CSet31::
    dw MetaSprites3B_507CSet31Frame0 ; entry 0
    dw MetaSprites3B_507CSet31Frame1 ; entry 1
    dw MetaSprites3B_507CSet31Frame2 ; entry 2
    dw MetaSprites3B_507CSet31Frame3 ; entry 3
    dw MetaSprites3B_507CSet31Frame4 ; entry 4
    dw MetaSprites3B_507CSet31Frame5 ; entry 5
    dw MetaSprites3B_507CSet31Frame6 ; entry 6
    dw MetaSprites3B_507CSet31Frame7 ; entry 7
    dw MetaSprites3B_507CSet31Frame8 ; entry 8
    dw MetaSprites3B_507CSet31Frame9 ; entry 9
    dw MetaSprites3B_507CSet31Frame10 ; entry 10
    dw MetaSprites3B_507CSet31Frame11 ; entry 11
    dw MetaSprites3B_507CSet31Frame12 ; entry 12
    dw MetaSprites3B_507CSet31Frame13 ; entry 13
    dw MetaSprites3B_507CSet31Frame14 ; entry 14
    dw MetaSprites3B_507CSet31Frame15 ; entry 15
    dw MetaSprites3B_507CSet31Frame16 ; entry 16
    dw MetaSprites3B_507CSet31Frame16 ; entry 17
    dw MetaSprites3B_507CSet31Frame16 ; entry 18
    dw MetaSprites3B_507CSet31Frame16 ; entry 19
    dw MetaSprites3B_507CSet31Frame16 ; entry 20
    dw MetaSprites3B_507CSet31Frame16 ; entry 21
    dw MetaSprites3B_507CSet31Frame16 ; entry 22
    dw MetaSprites3B_507CSet31Frame16 ; entry 23
    dw MetaSprites3B_507CSet31Frame16 ; entry 24
    dw MetaSprites3B_507CSet31Frame16 ; entry 25
    dw MetaSprites3B_507CSet31Frame16 ; entry 26
    dw MetaSprites3B_507CSet31Frame16 ; entry 27
    dw MetaSprites3B_507CSet31Frame16 ; entry 28
    dw MetaSprites3B_507CSet31Frame16 ; entry 29
    dw MetaSprites3B_507CSet31Frame16 ; entry 30
    dw MetaSprites3B_507CSet31Frame16 ; entry 31

; frame 0 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame0::
    db $d8, $10, $00, $00 ; entry 0
    db $d0, $10, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame1::
    db $d8, $08, $00, $20 ; entry 0
    db $e0, $10, $00, $00 ; entry 1
    db $d0, $08, $01, $20 ; entry 2
    db $d8, $10, $01, $00 ; entry 3
    db $d0, $10, $02, $00 ; entry 4
    db $80 ; end

; frame 2 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame2::
    db $d8, $00, $00, $00 ; entry 0
    db $e0, $08, $00, $20 ; entry 1
    db $e8, $10, $00, $00 ; entry 2
    db $d0, $00, $01, $00 ; entry 3
    db $d8, $08, $01, $20 ; entry 4
    db $e0, $10, $01, $00 ; entry 5
    db $d0, $08, $02, $20 ; entry 6
    db $d8, $10, $02, $00 ; entry 7
    db $d0, $10, $03, $00 ; entry 8
    db $80 ; end

; frame 3 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame3::
    db $d8, $f8, $00, $20 ; entry 0
    db $e0, $00, $00, $00 ; entry 1
    db $e8, $08, $00, $20 ; entry 2
    db $f0, $10, $00, $00 ; entry 3
    db $d0, $f8, $01, $20 ; entry 4
    db $d8, $00, $01, $00 ; entry 5
    db $e0, $08, $01, $20 ; entry 6
    db $e8, $10, $01, $00 ; entry 7
    db $d0, $00, $02, $00 ; entry 8
    db $d8, $08, $02, $20 ; entry 9
    db $e0, $10, $02, $00 ; entry 10
    db $d0, $08, $03, $20 ; entry 11
    db $d8, $10, $03, $00 ; entry 12
    db $d0, $10, $04, $00 ; entry 13
    db $80 ; end

; frame 4 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame4::
    db $f8, $10, $00, $00 ; entry 0
    db $e8, $00, $00, $00 ; entry 1
    db $e8, $08, $01, $20 ; entry 2
    db $e8, $10, $02, $00 ; entry 3
    db $e0, $f8, $00, $20 ; entry 4
    db $e0, $00, $01, $00 ; entry 5
    db $e0, $08, $02, $20 ; entry 6
    db $e0, $10, $03, $00 ; entry 7
    db $d8, $f0, $00, $00 ; entry 8
    db $d8, $f8, $01, $20 ; entry 9
    db $d8, $00, $02, $00 ; entry 10
    db $d8, $08, $03, $20 ; entry 11
    db $d8, $10, $04, $00 ; entry 12
    db $d0, $f0, $01, $00 ; entry 13
    db $d0, $f8, $02, $20 ; entry 14
    db $d0, $00, $03, $00 ; entry 15
    db $d0, $08, $04, $20 ; entry 16
    db $f0, $08, $00, $20 ; entry 17
    db $f0, $10, $01, $00 ; entry 18
    db $d0, $10, $05, $00 ; entry 19
    db $80 ; end

; frame 5 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame5::
    db $f8, $08, $00, $20 ; entry 0
    db $f8, $10, $01, $00 ; entry 1
    db $f0, $00, $00, $00 ; entry 2
    db $f0, $08, $01, $20 ; entry 3
    db $f0, $10, $02, $00 ; entry 4
    db $e8, $f8, $00, $20 ; entry 5
    db $e8, $00, $01, $00 ; entry 6
    db $e8, $08, $02, $20 ; entry 7
    db $e8, $10, $03, $00 ; entry 8
    db $e0, $f0, $00, $00 ; entry 9
    db $e0, $f8, $01, $20 ; entry 10
    db $e0, $00, $02, $00 ; entry 11
    db $e0, $08, $03, $20 ; entry 12
    db $e0, $10, $04, $00 ; entry 13
    db $d8, $e8, $00, $20 ; entry 14
    db $d8, $f0, $01, $00 ; entry 15
    db $d8, $f8, $02, $20 ; entry 16
    db $d8, $00, $03, $00 ; entry 17
    db $d8, $08, $04, $00 ; entry 18
    db $d0, $e8, $01, $20 ; entry 19
    db $d0, $f0, $02, $00 ; entry 20
    db $d0, $f8, $03, $20 ; entry 21
    db $d0, $00, $04, $00 ; entry 22
    db $d0, $08, $05, $00 ; entry 23
    db $d0, $10, $06, $00 ; entry 24
    db $d8, $10, $08, $00 ; entry 25
    db $80 ; end

; frame 6 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame6::
    db $f8, $00, $00, $20 ; entry 0
    db $f8, $08, $01, $00 ; entry 1
    db $f8, $10, $02, $20 ; entry 2
    db $f0, $f8, $00, $00 ; entry 3
    db $f0, $00, $01, $20 ; entry 4
    db $f0, $08, $02, $00 ; entry 5
    db $f0, $10, $03, $20 ; entry 6
    db $e8, $f0, $00, $20 ; entry 7
    db $e8, $f8, $01, $00 ; entry 8
    db $e8, $00, $02, $20 ; entry 9
    db $e8, $08, $03, $00 ; entry 10
    db $e8, $10, $04, $00 ; entry 11
    db $e0, $e8, $00, $00 ; entry 12
    db $e0, $f0, $01, $20 ; entry 13
    db $e0, $f8, $02, $00 ; entry 14
    db $e0, $00, $03, $20 ; entry 15
    db $e0, $08, $04, $00 ; entry 16
    db $d8, $e8, $01, $00 ; entry 17
    db $d8, $f0, $02, $20 ; entry 18
    db $d8, $f8, $03, $00 ; entry 19
    db $d8, $00, $04, $00 ; entry 20
    db $d0, $e8, $02, $00 ; entry 21
    db $d0, $f0, $03, $20 ; entry 22
    db $d0, $f8, $04, $00 ; entry 23
    db $d8, $08, $08, $00 ; entry 24
    db $d8, $10, $07, $00 ; entry 25
    db $d0, $00, $05, $00 ; entry 26
    db $d0, $08, $06, $00 ; entry 27
    db $d0, $10, $05, $00 ; entry 28
    db $e0, $10, $05, $00 ; entry 29
    db $80 ; end

; frame 7 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame7::
    db $f8, $f8, $00, $20 ; entry 0
    db $f8, $00, $01, $00 ; entry 1
    db $f8, $08, $02, $20 ; entry 2
    db $f8, $10, $03, $00 ; entry 3
    db $f0, $f0, $00, $00 ; entry 4
    db $f0, $f8, $01, $20 ; entry 5
    db $f0, $00, $02, $00 ; entry 6
    db $f0, $08, $03, $20 ; entry 7
    db $f0, $10, $04, $00 ; entry 8
    db $e8, $e8, $00, $20 ; entry 9
    db $e8, $f0, $01, $00 ; entry 10
    db $e8, $f8, $02, $20 ; entry 11
    db $e8, $00, $03, $00 ; entry 12
    db $e8, $08, $04, $00 ; entry 13
    db $e0, $e8, $01, $20 ; entry 14
    db $e0, $f0, $02, $00 ; entry 15
    db $e0, $f8, $03, $20 ; entry 16
    db $e0, $00, $04, $00 ; entry 17
    db $d8, $e8, $02, $20 ; entry 18
    db $d8, $f0, $03, $00 ; entry 19
    db $d8, $f8, $04, $00 ; entry 20
    db $d0, $e8, $03, $20 ; entry 21
    db $d0, $f0, $04, $00 ; entry 22
    db $d0, $f8, $05, $00 ; entry 23
    db $d0, $00, $06, $00 ; entry 24
    db $d0, $08, $05, $00 ; entry 25
    db $d0, $10, $06, $00 ; entry 26
    db $d8, $00, $08, $00 ; entry 27
    db $d8, $08, $07, $00 ; entry 28
    db $d8, $10, $08, $00 ; entry 29
    db $e0, $08, $05, $00 ; entry 30
    db $e0, $10, $06, $00 ; entry 31
    db $e8, $10, $08, $00 ; entry 32
    db $80 ; end

; frame 8 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame8::
    db $f8, $f0, $00, $20 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $08, $03, $00 ; entry 3
    db $f8, $10, $04, $00 ; entry 4
    db $f0, $e8, $00, $00 ; entry 5
    db $f0, $f0, $01, $20 ; entry 6
    db $f0, $f8, $02, $00 ; entry 7
    db $f0, $00, $03, $20 ; entry 8
    db $f0, $08, $04, $00 ; entry 9
    db $e8, $e8, $01, $00 ; entry 10
    db $e8, $f0, $02, $20 ; entry 11
    db $e8, $f8, $03, $00 ; entry 12
    db $e8, $00, $04, $00 ; entry 13
    db $e0, $e8, $02, $00 ; entry 14
    db $e0, $f0, $03, $20 ; entry 15
    db $e0, $f8, $04, $00 ; entry 16
    db $d8, $e8, $03, $00 ; entry 17
    db $d8, $f0, $04, $00 ; entry 18
    db $d0, $e8, $04, $00 ; entry 19
    db $d0, $f0, $05, $00 ; entry 20
    db $d0, $f8, $06, $00 ; entry 21
    db $d0, $00, $05, $00 ; entry 22
    db $d0, $08, $06, $00 ; entry 23
    db $d0, $10, $05, $00 ; entry 24
    db $d8, $f8, $08, $00 ; entry 25
    db $d8, $00, $07, $00 ; entry 26
    db $d8, $08, $08, $00 ; entry 27
    db $d8, $10, $07, $00 ; entry 28
    db $e0, $00, $05, $00 ; entry 29
    db $e0, $08, $06, $00 ; entry 30
    db $e0, $10, $05, $00 ; entry 31
    db $f0, $10, $05, $00 ; entry 32
    db $e8, $08, $08, $00 ; entry 33
    db $e8, $10, $07, $00 ; entry 34
    db $80 ; end

; frame 9 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame9::
    db $f8, $e8, $00, $20 ; entry 0
    db $f8, $f0, $01, $00 ; entry 1
    db $f8, $f8, $02, $20 ; entry 2
    db $f0, $e8, $01, $20 ; entry 3
    db $f0, $f0, $02, $00 ; entry 4
    db $e8, $e8, $02, $20 ; entry 5
    db $f8, $00, $03, $00 ; entry 6
    db $f8, $08, $04, $00 ; entry 7
    db $f0, $f8, $03, $20 ; entry 8
    db $f0, $00, $04, $00 ; entry 9
    db $e8, $f0, $03, $00 ; entry 10
    db $e8, $f8, $04, $00 ; entry 11
    db $e0, $e8, $03, $20 ; entry 12
    db $e0, $f0, $04, $00 ; entry 13
    db $d8, $e8, $04, $00 ; entry 14
    db $d0, $e8, $05, $00 ; entry 15
    db $d0, $f0, $06, $00 ; entry 16
    db $d0, $f8, $05, $00 ; entry 17
    db $d0, $00, $06, $00 ; entry 18
    db $d0, $08, $05, $00 ; entry 19
    db $d0, $10, $06, $00 ; entry 20
    db $d8, $f0, $08, $00 ; entry 21
    db $d8, $f8, $07, $00 ; entry 22
    db $d8, $00, $08, $00 ; entry 23
    db $d8, $08, $07, $00 ; entry 24
    db $d8, $10, $08, $00 ; entry 25
    db $e0, $f8, $05, $00 ; entry 26
    db $e0, $00, $06, $00 ; entry 27
    db $e0, $08, $05, $00 ; entry 28
    db $e0, $10, $06, $00 ; entry 29
    db $e8, $00, $08, $00 ; entry 30
    db $e8, $08, $07, $00 ; entry 31
    db $e8, $10, $08, $00 ; entry 32
    db $f8, $10, $08, $00 ; entry 33
    db $f0, $08, $05, $00 ; entry 34
    db $f0, $10, $06, $00 ; entry 35
    db $80 ; end

; frame 10 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame10::
    db $d8, $e8, $08, $00 ; entry 0
    db $f8, $e8, $01, $00 ; entry 1
    db $f8, $f0, $02, $20 ; entry 2
    db $f0, $e8, $02, $00 ; entry 3
    db $f8, $f8, $03, $00 ; entry 4
    db $f0, $f0, $03, $20 ; entry 5
    db $e8, $e8, $03, $00 ; entry 6
    db $e0, $e8, $04, $00 ; entry 7
    db $e8, $f0, $04, $00 ; entry 8
    db $f0, $f8, $04, $00 ; entry 9
    db $f8, $00, $04, $00 ; entry 10
    db $d0, $e8, $06, $00 ; entry 11
    db $d0, $f0, $05, $00 ; entry 12
    db $d0, $f8, $06, $00 ; entry 13
    db $d0, $00, $05, $00 ; entry 14
    db $d0, $08, $06, $00 ; entry 15
    db $d0, $10, $05, $00 ; entry 16
    db $d8, $f0, $07, $00 ; entry 17
    db $d8, $f8, $08, $00 ; entry 18
    db $d8, $00, $07, $00 ; entry 19
    db $d8, $08, $08, $00 ; entry 20
    db $d8, $10, $07, $00 ; entry 21
    db $e0, $f0, $05, $00 ; entry 22
    db $e0, $f8, $06, $00 ; entry 23
    db $e0, $00, $05, $00 ; entry 24
    db $e0, $08, $06, $00 ; entry 25
    db $e0, $10, $05, $00 ; entry 26
    db $e8, $f8, $08, $00 ; entry 27
    db $e8, $00, $07, $00 ; entry 28
    db $e8, $08, $08, $00 ; entry 29
    db $e8, $10, $07, $00 ; entry 30
    db $f0, $00, $05, $00 ; entry 31
    db $f0, $08, $06, $00 ; entry 32
    db $f0, $10, $05, $00 ; entry 33
    db $f8, $08, $08, $00 ; entry 34
    db $f8, $10, $07, $00 ; entry 35
    db $80 ; end

; frame 11 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame11::
    db $f8, $e8, $02, $20 ; entry 0
    db $f8, $f0, $03, $00 ; entry 1
    db $f0, $e8, $03, $20 ; entry 2
    db $e8, $e8, $04, $00 ; entry 3
    db $f0, $f0, $04, $00 ; entry 4
    db $f8, $f8, $04, $00 ; entry 5
    db $d0, $e8, $05, $00 ; entry 6
    db $d0, $f0, $06, $00 ; entry 7
    db $d0, $f8, $05, $00 ; entry 8
    db $d0, $00, $06, $00 ; entry 9
    db $d0, $08, $05, $00 ; entry 10
    db $d8, $e8, $07, $00 ; entry 11
    db $d8, $f0, $08, $00 ; entry 12
    db $d8, $f8, $07, $00 ; entry 13
    db $d8, $00, $08, $00 ; entry 14
    db $d8, $08, $07, $00 ; entry 15
    db $e0, $e8, $05, $00 ; entry 16
    db $e0, $f0, $06, $00 ; entry 17
    db $e0, $f8, $05, $00 ; entry 18
    db $e0, $00, $06, $00 ; entry 19
    db $e0, $08, $05, $00 ; entry 20
    db $e8, $f0, $08, $00 ; entry 21
    db $e8, $f8, $07, $00 ; entry 22
    db $e8, $00, $08, $00 ; entry 23
    db $e8, $08, $07, $00 ; entry 24
    db $f0, $f8, $05, $00 ; entry 25
    db $f0, $00, $06, $00 ; entry 26
    db $f0, $08, $05, $00 ; entry 27
    db $f8, $00, $08, $00 ; entry 28
    db $f8, $08, $07, $00 ; entry 29
    db $d0, $10, $06, $00 ; entry 30
    db $d8, $10, $08, $00 ; entry 31
    db $e0, $10, $06, $00 ; entry 32
    db $e8, $10, $08, $00 ; entry 33
    db $f0, $10, $06, $00 ; entry 34
    db $f8, $10, $08, $00 ; entry 35
    db $80 ; end

; frame 12 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame12::
    db $f8, $e8, $03, $00 ; entry 0
    db $f0, $e8, $04, $00 ; entry 1
    db $f8, $f0, $04, $00 ; entry 2
    db $d0, $e8, $06, $00 ; entry 3
    db $d0, $f0, $05, $00 ; entry 4
    db $d0, $f8, $06, $00 ; entry 5
    db $d0, $00, $05, $00 ; entry 6
    db $d8, $e8, $08, $00 ; entry 7
    db $d8, $f0, $07, $00 ; entry 8
    db $d8, $f8, $08, $00 ; entry 9
    db $d8, $00, $07, $00 ; entry 10
    db $e0, $e8, $06, $00 ; entry 11
    db $e0, $f0, $05, $00 ; entry 12
    db $e0, $f8, $06, $00 ; entry 13
    db $e0, $00, $05, $00 ; entry 14
    db $e8, $e8, $08, $00 ; entry 15
    db $e8, $f0, $07, $00 ; entry 16
    db $e8, $f8, $08, $00 ; entry 17
    db $e8, $00, $07, $00 ; entry 18
    db $f0, $f0, $05, $00 ; entry 19
    db $f0, $f8, $06, $00 ; entry 20
    db $f0, $00, $05, $00 ; entry 21
    db $f8, $f8, $08, $00 ; entry 22
    db $f8, $00, $07, $00 ; entry 23
    db $d0, $08, $06, $00 ; entry 24
    db $d8, $08, $08, $00 ; entry 25
    db $e0, $08, $06, $00 ; entry 26
    db $e8, $08, $08, $00 ; entry 27
    db $f0, $08, $06, $00 ; entry 28
    db $f8, $08, $08, $00 ; entry 29
    db $d0, $10, $05, $00 ; entry 30
    db $d8, $10, $07, $00 ; entry 31
    db $e0, $10, $05, $00 ; entry 32
    db $e8, $10, $07, $00 ; entry 33
    db $f0, $10, $05, $00 ; entry 34
    db $f8, $10, $07, $00 ; entry 35
    db $80 ; end

; frame 13 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame13::
    db $f8, $e8, $04, $00 ; entry 0
    db $d0, $e8, $05, $00 ; entry 1
    db $d0, $f0, $06, $00 ; entry 2
    db $d0, $f8, $05, $00 ; entry 3
    db $d8, $e8, $07, $00 ; entry 4
    db $d8, $f0, $08, $00 ; entry 5
    db $d8, $f8, $07, $00 ; entry 6
    db $e0, $e8, $05, $00 ; entry 7
    db $e0, $f0, $06, $00 ; entry 8
    db $e0, $f8, $05, $00 ; entry 9
    db $e8, $e8, $07, $00 ; entry 10
    db $e8, $f0, $08, $00 ; entry 11
    db $e8, $f8, $07, $00 ; entry 12
    db $f0, $e8, $05, $00 ; entry 13
    db $f0, $f0, $06, $00 ; entry 14
    db $f0, $f8, $05, $00 ; entry 15
    db $f8, $f0, $08, $00 ; entry 16
    db $f8, $f8, $07, $00 ; entry 17
    db $d0, $00, $06, $00 ; entry 18
    db $d8, $00, $08, $00 ; entry 19
    db $e0, $00, $06, $00 ; entry 20
    db $e8, $00, $08, $00 ; entry 21
    db $f0, $00, $06, $00 ; entry 22
    db $f8, $00, $08, $00 ; entry 23
    db $d0, $08, $05, $00 ; entry 24
    db $d8, $08, $07, $00 ; entry 25
    db $e0, $08, $05, $00 ; entry 26
    db $e8, $08, $07, $00 ; entry 27
    db $f0, $08, $05, $00 ; entry 28
    db $f8, $08, $07, $00 ; entry 29
    db $d0, $10, $06, $00 ; entry 30
    db $d8, $10, $08, $00 ; entry 31
    db $e0, $10, $06, $00 ; entry 32
    db $e8, $10, $08, $00 ; entry 33
    db $f0, $10, $06, $00 ; entry 34
    db $f8, $10, $08, $00 ; entry 35
    db $80 ; end

; frame 14 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame14::
    db $d0, $e8, $06, $00 ; entry 0
    db $d0, $f0, $05, $00 ; entry 1
    db $d8, $e8, $08, $00 ; entry 2
    db $d8, $f0, $07, $00 ; entry 3
    db $e0, $e8, $06, $00 ; entry 4
    db $e0, $f0, $05, $00 ; entry 5
    db $e8, $e8, $08, $00 ; entry 6
    db $e8, $f0, $07, $00 ; entry 7
    db $f0, $e8, $06, $00 ; entry 8
    db $f0, $f0, $05, $00 ; entry 9
    db $f8, $e8, $08, $00 ; entry 10
    db $f8, $f0, $07, $00 ; entry 11
    db $d0, $f8, $06, $00 ; entry 12
    db $d8, $f8, $08, $00 ; entry 13
    db $e0, $f8, $06, $00 ; entry 14
    db $e8, $f8, $08, $00 ; entry 15
    db $f0, $f8, $06, $00 ; entry 16
    db $f8, $f8, $08, $00 ; entry 17
    db $d0, $00, $05, $00 ; entry 18
    db $d8, $00, $07, $00 ; entry 19
    db $e0, $00, $05, $00 ; entry 20
    db $e8, $00, $07, $00 ; entry 21
    db $f0, $00, $05, $00 ; entry 22
    db $f8, $00, $07, $00 ; entry 23
    db $d0, $08, $06, $00 ; entry 24
    db $d8, $08, $08, $00 ; entry 25
    db $e0, $08, $06, $00 ; entry 26
    db $e8, $08, $08, $00 ; entry 27
    db $f0, $08, $06, $00 ; entry 28
    db $f8, $08, $08, $00 ; entry 29
    db $d0, $10, $05, $00 ; entry 30
    db $d8, $10, $07, $00 ; entry 31
    db $e0, $10, $05, $00 ; entry 32
    db $e8, $10, $07, $00 ; entry 33
    db $f0, $10, $05, $00 ; entry 34
    db $f8, $10, $07, $00 ; entry 35
    db $80 ; end

; frame 15 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
MetaSprites3B_507CSet31Frame15::
    db $f8, $e8, $09, $00 ; entry 0
    db $f0, $e8, $09, $00 ; entry 1
    db $e8, $e8, $09, $00 ; entry 2
    db $e0, $e8, $09, $00 ; entry 3
    db $d8, $e8, $09, $00 ; entry 4
    db $d0, $e8, $09, $00 ; entry 5
    db $d0, $f0, $09, $00 ; entry 6
    db $d8, $f0, $09, $00 ; entry 7
    db $e0, $f0, $09, $00 ; entry 8
    db $e8, $f0, $09, $00 ; entry 9
    db $f0, $f0, $09, $00 ; entry 10
    db $f8, $f0, $09, $00 ; entry 11
    db $f8, $f8, $09, $00 ; entry 12
    db $f0, $f8, $09, $00 ; entry 13
    db $e8, $f8, $09, $00 ; entry 14
    db $e0, $f8, $09, $00 ; entry 15
    db $d8, $f8, $09, $00 ; entry 16
    db $d0, $f8, $09, $00 ; entry 17
    db $f8, $00, $09, $00 ; entry 18
    db $f0, $00, $09, $00 ; entry 19
    db $e8, $00, $09, $00 ; entry 20
    db $e0, $00, $09, $00 ; entry 21
    db $d8, $00, $09, $00 ; entry 22
    db $d0, $00, $09, $00 ; entry 23
    db $d0, $08, $09, $00 ; entry 24
    db $d8, $08, $09, $00 ; entry 25
    db $e0, $08, $09, $00 ; entry 26
    db $e8, $08, $09, $00 ; entry 27
    db $f0, $08, $09, $00 ; entry 28
    db $f8, $08, $09, $00 ; entry 29
    db $f8, $10, $09, $00 ; entry 30
    db $f0, $10, $09, $00 ; entry 31
    db $e8, $10, $09, $00 ; entry 32
    db $e0, $10, $09, $00 ; entry 33
    db $d8, $10, $09, $00 ; entry 34
    db $d0, $10, $09, $00 ; entry 35
    db $80 ; end

; frame 16 of MetaSprites3B_507CSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame16::
    db $80 ; end

; meta-sprite set 50 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites3B_507CSet32::
    dw MetaSprites3B_507CSet32Frame0 ; entry 0
    dw MetaSprites3B_507CSet32Frame1 ; entry 1
    dw MetaSprites3B_507CSet32Frame2 ; entry 2
    dw MetaSprites3B_507CSet32Frame3 ; entry 3
    dw MetaSprites3B_507CSet32Frame4 ; entry 4
    dw MetaSprites3B_507CSet32Frame5 ; entry 5
    dw MetaSprites3B_507CSet32Frame6 ; entry 6
    dw MetaSprites3B_507CSet32Frame7 ; entry 7
    dw MetaSprites3B_507CSet32Frame8 ; entry 8
    dw MetaSprites3B_507CSet32Frame8 ; entry 9
    dw MetaSprites3B_507CSet32Frame8 ; entry 10
    dw MetaSprites3B_507CSet32Frame8 ; entry 11
    dw MetaSprites3B_507CSet32Frame8 ; entry 12
    dw MetaSprites3B_507CSet32Frame8 ; entry 13
    dw MetaSprites3B_507CSet32Frame8 ; entry 14
    dw MetaSprites3B_507CSet32Frame8 ; entry 15
    dw MetaSprites3B_507CSet32Frame8 ; entry 16
    dw MetaSprites3B_507CSet32Frame8 ; entry 17
    dw MetaSprites3B_507CSet32Frame8 ; entry 18
    dw MetaSprites3B_507CSet32Frame8 ; entry 19
    dw MetaSprites3B_507CSet32Frame8 ; entry 20
    dw MetaSprites3B_507CSet32Frame8 ; entry 21
    dw MetaSprites3B_507CSet32Frame8 ; entry 22
    dw MetaSprites3B_507CSet32Frame8 ; entry 23
    dw MetaSprites3B_507CSet32Frame8 ; entry 24
    dw MetaSprites3B_507CSet32Frame8 ; entry 25
    dw MetaSprites3B_507CSet32Frame8 ; entry 26
    dw MetaSprites3B_507CSet32Frame8 ; entry 27
    dw MetaSprites3B_507CSet32Frame8 ; entry 28
    dw MetaSprites3B_507CSet32Frame8 ; entry 29
    dw MetaSprites3B_507CSet32Frame8 ; entry 30
    dw MetaSprites3B_507CSet32Frame8 ; entry 31

; frame 0 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame0::
    db $d0, $28, $00, $00 ; entry 0
    db $d0, $e0, $00, $00 ; entry 1
    db $d0, $c0, $01, $00 ; entry 2
    db $d8, $d0, $00, $00 ; entry 3
    db $e0, $f6, $01, $00 ; entry 4
    db $d8, $18, $01, $00 ; entry 5
    db $e0, $30, $02, $00 ; entry 6
    db $d0, $fe, $02, $00 ; entry 7
    db $80 ; end

; frame 1 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame1::
    db $f0, $28, $00, $00 ; entry 0
    db $f0, $e0, $00, $00 ; entry 1
    db $f0, $c0, $01, $00 ; entry 2
    db $f8, $18, $01, $00 ; entry 3
    db $f0, $fe, $02, $00 ; entry 4
    db $e8, $f2, $02, $00 ; entry 5
    db $d8, $1f, $00, $20 ; entry 6
    db $f8, $40, $01, $00 ; entry 7
    db $e0, $b8, $01, $00 ; entry 8
    db $e8, $30, $00, $00 ; entry 9
    db $e0, $18, $02, $20 ; entry 10
    db $d8, $fa, $00, $20 ; entry 11
    db $e0, $d8, $01, $20 ; entry 12
    db $d8, $e5, $02, $20 ; entry 13
    db $d8, $c0, $00, $20 ; entry 14
    db $e0, $40, $01, $20 ; entry 15
    db $d8, $30, $01, $20 ; entry 16
    db $e8, $d0, $00, $00 ; entry 17
    db $80 ; end

; frame 2 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame2::
    db $e8, $c0, $01, $00 ; entry 0
    db $f0, $f2, $02, $00 ; entry 1
    db $e0, $1f, $00, $20 ; entry 2
    db $d0, $00, $00, $20 ; entry 3
    db $d0, $e2, $02, $20 ; entry 4
    db $d0, $3a, $01, $20 ; entry 5
    db $d0, $2a, $01, $20 ; entry 6
    db $f8, $b8, $01, $00 ; entry 7
    db $e8, $d8, $01, $20 ; entry 8
    db $f8, $e4, $00, $00 ; entry 9
    db $e0, $f8, $02, $00 ; entry 10
    db $f8, $00, $00, $00 ; entry 11
    db $e8, $10, $02, $20 ; entry 12
    db $f8, $2b, $00, $00 ; entry 13
    db $e8, $40, $01, $00 ; entry 14
    db $e0, $2e, $00, $00 ; entry 15
    db $d8, $0f, $01, $00 ; entry 16
    db $f8, $d0, $01, $00 ; entry 17
    db $d0, $d0, $00, $00 ; entry 18
    db $d0, $b8, $02, $00 ; entry 19
    db $80 ; end

; frame 3 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame3::
    db $e8, $d9, $00, $00 ; entry 0
    db $d8, $f8, $00, $00 ; entry 1
    db $d8, $be, $01, $00 ; entry 2
    db $f0, $20, $01, $00 ; entry 3
    db $e8, $00, $02, $20 ; entry 4
    db $f0, $e8, $02, $00 ; entry 5
    db $f0, $b8, $01, $20 ; entry 6
    db $d8, $28, $00, $20 ; entry 7
    db $d8, $40, $02, $20 ; entry 8
    db $d0, $0c, $00, $20 ; entry 9
    db $d0, $20, $01, $20 ; entry 10
    db $d0, $c5, $03, $00 ; entry 11
    db $e8, $ca, $03, $00 ; entry 12
    db $d0, $f0, $03, $00 ; entry 13
    db $f8, $06, $03, $00 ; entry 14
    db $d8, $16, $03, $00 ; entry 15
    db $d0, $38, $03, $00 ; entry 16
    db $f0, $38, $03, $00 ; entry 17
    db $e0, $e9, $03, $00 ; entry 18
    db $d8, $ce, $03, $00 ; entry 19
    db $80 ; end

; frame 4 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame4::
    db $f0, $18, $00, $20 ; entry 0
    db $f8, $e0, $01, $20 ; entry 1
    db $f8, $b8, $01, $20 ; entry 2
    db $e0, $40, $01, $20 ; entry 3
    db $e8, $c8, $00, $20 ; entry 4
    db $e0, $e0, $02, $00 ; entry 5
    db $e2, $20, $01, $00 ; entry 6
    db $d8, $13, $02, $00 ; entry 7
    db $f2, $d0, $04, $00 ; entry 8
    db $e2, $b8, $04, $00 ; entry 9
    db $f8, $38, $04, $00 ; entry 10
    db $de, $d1, $04, $00 ; entry 11
    db $d8, $f2, $04, $00 ; entry 12
    db $e8, $e6, $04, $00 ; entry 13
    db $f8, $06, $04, $00 ; entry 14
    db $e0, $18, $04, $00 ; entry 15
    db $dc, $38, $04, $00 ; entry 16
    db $80 ; end

; frame 5 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame5::
    db $f0, $06, $02, $20 ; entry 0
    db $d0, $16, $02, $00 ; entry 1
    db $d0, $ce, $01, $00 ; entry 2
    db $f8, $40, $01, $20 ; entry 3
    db $e8, $e8, $02, $00 ; entry 4
    db $e0, $ca, $00, $20 ; entry 5
    db $d0, $40, $02, $20 ; entry 6
    db $d0, $be, $05, $00 ; entry 7
    db $e8, $b8, $05, $00 ; entry 8
    db $e0, $d9, $05, $00 ; entry 9
    db $d8, $e9, $05, $00 ; entry 10
    db $e0, $00, $05, $00 ; entry 11
    db $d0, $28, $05, $00 ; entry 12
    db $e0, $20, $05, $00 ; entry 13
    db $e8, $38, $05, $00 ; entry 14
    db $f8, $28, $05, $00 ; entry 15
    db $f8, $f8, $05, $00 ; entry 16
    db $f8, $cd, $05, $00 ; entry 17
    db $80 ; end

; frame 6 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame6::
    db $f0, $38, $05, $20 ; entry 0
    db $ec, $e8, $05, $20 ; entry 1
    db $e4, $be, $05, $20 ; entry 2
    db $e8, $d9, $03, $00 ; entry 3
    db $ea, $00, $03, $00 ; entry 4
    db $e0, $28, $05, $20 ; entry 5
    db $eb, $20, $03, $00 ; entry 6
    db $80 ; end

; frame 7 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame7::
    db $ed, $2a, $03, $00 ; entry 0
    db $f8, $3c, $03, $00 ; entry 1
    db $f1, $ba, $03, $00 ; entry 2
    db $f8, $20, $03, $00 ; entry 3
    db $f8, $e6, $03, $00 ; entry 4
    db $80 ; end

; frame 8 of MetaSprites3B_507CSet32; ends with $80 (E-0147)
MetaSprites3B_507CSet32Frame8::
    db $80 ; end
    ds $14f2, $00
