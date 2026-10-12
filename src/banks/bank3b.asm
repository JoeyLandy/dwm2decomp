SECTION "Bank 3B", ROMX[$4000], BANK[$3B]
    db $3B

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base HP: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's HP word (wCFF6) is returned; otherwise the word at offset $1D of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 3 call sites from 3 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo, ActionEffect_Transform_Sub01_GetBaseHP)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId
; points at: wSpecialSlotMonsters
GetBaseHP::
Func_03B_4001:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4013
    ld a, c
    ld e, $1D
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr Jump_03B_403C

Jump_03B_4013::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
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

Jump_03B_403C::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base MP: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's MP word (wCFF8) is returned; otherwise the word at offset $21 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 3 call sites from 3 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo, ActionEffect_Transform_Sub01_GetBaseMP)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId
; points at: wSpecialSlotMonsters
GetBaseMP::
Func_03B_4045:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4057
    ld a, c
    ld e, $21
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr Jump_03B_4080

Jump_03B_4057::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $A]
    ld c, a
    ld a, [wRecordBufferData + $B]
    ld b, a

Jump_03B_4080::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base ATK: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's ATK word (wCFFA) is returned; otherwise the word at offset $23 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 3 call sites from 3 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo, GetBaseATKOfSlotA)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId
; points at: wSpecialSlotMonsters
GetBaseATK::
Func_03B_4089:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_409B
    ld a, c
    ld e, $23
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr Jump_03B_40C4

Jump_03B_409B::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $C]
    ld c, a
    ld a, [wRecordBufferData + $D]
    ld b, a

Jump_03B_40C4::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base DEF: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's DEF word (wCFFC) is returned; otherwise the word at offset $25 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 7 call sites from 7 routines (e.g. AIScore_Upper_Conditions_Sub01_GetBattleDEF_Bank05, ResetTargetAGLAndDEFToBase, RecomputeTargetMaxHPAndMP, ActionEffect_Surge_SetTargetSlotMarksTo3, ...)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId
; points at: wSpecialSlotMonsters
GetBaseDEF::
Func_03B_40CD:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_40DF
    ld a, c
    ld e, $25
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr Jump_03B_4108

Jump_03B_40DF::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $E]
    ld c, a
    ld a, [wRecordBufferData + $F]
    ld b, a

Jump_03B_4108::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base AGL: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's AGL word (wCFFE) is returned; otherwise the word at offset $27 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 7 call sites from 7 routines (e.g. AIScore_Speed_Conditions_Sub01_GetBattleAGL_Bank05, ResetTargetAGLAndDEFToBase, RecomputeTargetMaxHPAndMP, ActionEffect_Surge_SetTargetSlotMarksTo3, ...)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId
; points at: wSpecialSlotMonsters
GetBaseAGL::
Func_03B_4111:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4123
    ld a, c
    ld e, $27
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr Jump_03B_414C

Jump_03B_4123::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
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

Jump_03B_414C::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base INT: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's INT word (wD000) is returned; otherwise the word at offset $29 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wScreenAttrBuffer, wRecordBufferData
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId
; points at: wSpecialSlotMonsters
GetBaseINT::
Func_03B_4155:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4167
    ld a, c
    ld e, $29
    call BattlerRecordFieldAddress
    call LoadBCFromHL
    jr Jump_03B_4190

Jump_03B_4167::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
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

Jump_03B_4190::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; slot C: the byte at battler record field $17, or for slot 3/7 byte wCFF5 of its monster record; stored in wBattleStatResultLo (E-0124)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wMonsterId
; points at: wSpecialSlotMonsters
SlotField17OrMonsterCFF5::
Func_03B_4199:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_41A9
    ld a, c
    ld e, $17
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr Jump_03B_41CE

Jump_03B_41A9::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $7]
    ld c, a

Jump_03B_41CE::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $2D, or for slot 3/7 byte wD002 of its monster record; stored in wBattleStatResultLo (E-0124)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wMonsterId
; points at: wSpecialSlotMonsters
SlotField2DOrMonsterD002::
Func_03B_41D3:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_41E3
    ld a, c
    ld e, $2D
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr Jump_03B_4208

Jump_03B_41E3::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $14]
    ld c, a

Jump_03B_4208::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $30, or for slot 3/7 byte wD004 of its monster record; stored in wBattleStatResultLo (E-0124)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wMonsterId
; points at: wSpecialSlotMonsters
SlotField30OrMonsterD004::
Func_03B_420D:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_421D
    ld a, c
    ld e, $30
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr Jump_03B_4242

Jump_03B_421D::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $16]
    ld c, a

Jump_03B_4242::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $2E, or for slot 3/7 byte wD003 of its monster record; stored in wBattleStatResultLo (E-0124)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wMonsterId
; points at: wSpecialSlotMonsters
SlotField2EOrMonsterD003::
Func_03B_4247:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4257
    ld a, c
    ld e, $2E
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr Jump_03B_427C

Jump_03B_4257::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $15]
    ld c, a

Jump_03B_427C::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C: the byte at battler record field $2F, or for slot 3/7 byte wD005 of its monster record; stored in wBattleStatResultLo (E-0124)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wRecordBufferData
; writes: wBattleStatResultLo, wMonsterId
; points at: wSpecialSlotMonsters
SlotField2FOrMonsterD005::
Func_03B_4281:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4291
    ld a, c
    ld e, $2F
    call BattlerRecordFieldAddress
    ld c, [hl]
    jr Jump_03B_42B6

Jump_03B_4291::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $17]
    ld c, a

Jump_03B_42B6::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; slot C (not 3/7): C = (species byte wD00A << 4) | wD00B for its species (field $0A); 0 for slot 3/7 (E-0124)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
SlotSpeciesNibblesD00AD00B::
Func_03B_42BB:: ; address name
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_42E3
    ld a, c
    ld e, $0A
    call BattlerRecordFieldAddress
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $2]
    swap a
    ld c, a
    ld a, [wSpeciesRecord + $3]
    or a, c
    ld c, a
    jr Jump_03B_42E5

Jump_03B_42E3::
    ld c, $00

Jump_03B_42E5::
    ret

; the same 10 bytes as ReadBattleWordFromArray (36:7E5B)
; no direct call (reached through a table, a jump or a vector)
ReadBattleWordFromArray_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_42E6:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; C = [HL], B = [HL + 1]; HL ends on the high byte (E-0077)
; 6 call sites from 6 routines (e.g. GetBaseHP, GetBaseMP, GetBaseATK, GetBaseDEF, ...)
LoadBCFromHL::
Func_03B_42F0:: ; address name
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

; only called from RunBattleActions_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08)
; reads: wBattleResolveStep
RunBattleActions_Case08_Sub01::
Func_03B_42F4:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleActions_Case08_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleActions_Case08_Sub01_ShowActionBattleText
    dw RunBattleActions_Case08_Sub01_TargetOnLocalSide_Bank3B
    dw RunBattleActions_Case08_Sub01_ShowHeroIsAHunk
    dw RunBattleActions_Case08_Sub01_DispatchActionEffectTable_Bank3BAndStep
    dw RunBattleActions_Case08_Sub01_Case05
    dw RunBattleActions_Case08_Sub01_ShowBattleText
    dw RunBattleActions_Case08_Sub01_Return
    dw RunBattleActions_Case08_Sub01_AddDoubleAToHL_Bank3B
    dw RunBattleActions_Case08_Sub01_ToRunBattleSubStep2_6764
    dw RunBattleActions_Case08_Sub01_Case0A
    dw RunBattleActions_Case08_Sub01_LoadItemRecord
    dw RunBattleActions_Case08_Sub01_Case0C
    dw RunBattleActions_Case08_Sub01_ShowButNothingHappened

; entry 0 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleFlag92, wBattleFlag93, wLinkRole
; writes: wDefeatFlagsBA, wSlotsOccupiedFlag, wBattleTarget, wBattleActionId, wBattleResolveStep
; points at: wBattleResolveStep
RunBattleActions_Case08_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
Jump_03B_4314:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wDefeatFlagsBA], a
    xor a, a
    ld [wSlotsOccupiedFlag], a
    ld a, [wBattleFlag92]
    cp a, $10
    jr z, Jump_03B_433E
    cp a, $20
    jr z, Jump_03B_434B
    and a, $07
    ld [wBattleTarget], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, Jump_03B_435D
    ld a, [wBattleFlag93]
    cp a, $0C
    jr z, Jump_03B_435D
    jr Jump_03B_4364

Jump_03B_433E::
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_03B_4356
    ld c, $04
    jr Jump_03B_4356

Jump_03B_434B::
    ld c, $04
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_03B_4356
    ld c, $00

Jump_03B_4356::
    call AllThreeSlotsFromCOccupied
    ld a, c
    ld [wBattleTarget], a

Jump_03B_435D::
    ld a, [wBattleFlag93]
    ld [wBattleActionId], a
    ret

Jump_03B_4364::
    ld [wBattleActionId], a
    farcall ShowActionBattleText
    ld a, $0D
    ld [wBattleResolveStep], a
    ret

; returns carry only when slots C, C + 1 and C + 2 are all occupied (CarryUnlessBattleSlotOutSlotEmpty) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_CarryUnlessBattleSlotOutSlotEmpty)
AllThreeSlotsFromCOccupied::
Func_03B_4373:: ; address name
    ld b, $03

Jump_03B_4375::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    inc c
    dec b
    jr nz, Jump_03B_4375
    ret

; entry 1 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleActions_Case08_Sub01_ShowActionBattleText::
Jump_03B_437F:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    farcall ShowActionBattleText
    ret

; entry 2 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleKind, wBattleTarget
; writes: wEffectFlags, wBattleResolveStep
; points at: wBattleResolveStep, wBattleInitA1, wBattleStatus
RunBattleActions_Case08_Sub01_TargetOnLocalSide_Bank3B::
Jump_03B_438A:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActionId]
    cp a, $19
    jr c, Jump_03B_43E9
    cp a, $1E
    jr nc, Jump_03B_43E9
    call TargetOnLocalSide_Bank3B
    jr c, Jump_03B_43E9
    ld a, [wBattleKind]
    cp a, $03
    jr z, Jump_03B_43F5
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03

Jump_03B_43AD::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_03B_43E5
    ld a, c
    and a, $03
    ld hl, wBattleInitA1
    add_a_to_hl
    ld a, [hl]
    cp a, $07
    jr z, Jump_03B_43F5
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, Jump_03B_4406
    and a, $8C
    jr nz, Jump_03B_4417
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and a, $C0
    jr nz, Jump_03B_4428
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_03B_4439

Jump_03B_43E5::
    inc c
    dec b
    jr nz, Jump_03B_43AD

Jump_03B_43E9::
    ld a, $08
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

Jump_03B_43F5::
    call Call774CWithBattleFoeCount
    ld d, $7E
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4406::
    call Call774CWithBattleFoeCount
    ld d, $E6 ; battle text '0 can't eat while paralyzed!'
    farcall ShowBattleText
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4417::
    call Call774CWithBattleFoeCount
    ld d, $7B
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4428::
    call Call774CWithBattleFoeCount
    ld d, $7D
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4439::
    call Call774CWithBattleFoeCount
    ld d, $7C
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

; hFFC6 = wD890, then far-calls Func_03A_774C (E-0122)
; 5 call sites from 1 routine (e.g. RunBattleActions_Case08_Sub01_TargetOnLocalSide_Bank3B)
; reads: wBattleFoeCount
; writes: hTemp0
Call774CWithBattleFoeCount::
Func_03B_444A:: ; address name
    ld a, [wBattleFoeCount]
    ldh [hTemp0], a
    farcall Call774CWithBattleFoeCount_Sub01
    ret

; entry 3 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleResolveStep, wBattleStatus5
RunBattleActions_Case08_Sub01_ShowHeroIsAHunk::
Jump_03B_4456:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    ret z
    ld d, $66 ; battle text '0 is a hunk of iron!'
    farcall ShowBattleText
    call SetResolveStep0A
    ret

; entry 4 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleActions_Case08_Sub01_DispatchActionEffectTable_Bank3BAndStep::
Jump_03B_4473:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call DispatchActionEffectTable_Bank3B
    ret

; entry 5 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveMsgFlags, wBattleDamageLo, wBattleDamageHi, wBattleActionId, wBattleTarget
; writes: wResolveMsgFlags, wSlotsOccupiedFlag, wEffectFlags, wEffectFlags2
; points at: wBattleResolveStep
RunBattleActions_Case08_Sub01_Case05::
Jump_03B_447B:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    ld b, a
    bit 5, a
    jr z, Jump_03B_449D
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_03B_4497
    set 4, b
    jr Jump_03B_4499

Jump_03B_4497::
    res 4, b

Jump_03B_4499::
    ld a, b
    ld [wResolveMsgFlags], a

Jump_03B_449D::
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
    cp a, $01
    ret c
    cp a, $06
    jr c, Jump_03B_44DA
    cp a, $0B
    jr z, Jump_03B_44DA
    jr c, Jump_03B_44EF
    cp a, $0C
    jr z, Jump_03B_44EF
    cp a, $24
    ret c
    cp a, $28
    jr c, Jump_03B_44FE
    ret

Jump_03B_44DA::
    ld a, [wBattleTarget]
    cp a, $04
    jr c, Jump_03B_44FE
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l
    jr Jump_03B_450E

Jump_03B_44EF::
    ld hl, $0064
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, Jump_03B_450E
    ld hl, $0005
    jr Jump_03B_450A

Jump_03B_44FE::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l

Jump_03B_450A::
    call SubtractHLFromBattleMeterFloored
    ret

Jump_03B_450E::
    call AddHLToBattleMeterCappedAt1800
    ret

; entry 6 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveMsgFlags, wResolveMsgActor, wTemp0, wResolveMsgTarget
; writes: wTemp0
; points at: wBattleResolveStep
RunBattleActions_Case08_Sub01_ShowBattleText::
Jump_03B_4512:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, Jump_03B_4529
    ld a, [wResolveMsgActor]
    ld [wTemp0], a
    jr Jump_03B_452F

Jump_03B_4529::
    ld a, [wResolveMsgTarget]
    ld [wTemp0], a

Jump_03B_452F::
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    call SetResolveStep0AUnlessResolveMsgFlagsBit4
    ret

; returns when wDAC0 bit 4 is set, otherwise SetResolveStep0A (E-0116)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_ShowBattleText)
; reads: wResolveMsgFlags
SetResolveStep0AUnlessResolveMsgFlagsBit4::
Func_03B_453D:: ; address name
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret nz
    call SetResolveStep0A
    ret

; entry 7 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_Case08_Sub01_Return::
Jump_03B_4547:: ; address name
    ret

; entry 8 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveMsgArg, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleSubStep2
; points at: wBattleResolveStep, wBattleHP
RunBattleActions_Case08_Sub01_AddDoubleAToHL_Bank3B::
Jump_03B_4548:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgArg]
    and a, $C0
    cp a, $00
    jr z, Jump_03B_459E
    cp a, $40
    jr z, Jump_03B_458B
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_03B_4580
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_03B_458B
    inc hl

Jump_03B_4580::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, wBattleResolveStep
    dec [hl]
    xor a, a
    ld [wBattleSubStep2], a

Jump_03B_458B::
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank3B
    ld a, [wBattleTarget]
    call SetBit1OfLevelUpGainsIndexed_Bank3B
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3B
    ret

Jump_03B_459E::
    ret

; entry 9 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_Case08_Sub01_ToRunBattleSubStep2_6764::
Jump_03B_459F:: ; address name
    farcall RunBattleSubStep2_6764
    ret

; entry 10 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleFlag93, wBattleFlag92, wBattleTarget, wDefeatFlagsBA
; writes: wBattleTarget, wBattleResolveStep, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleResolveStep, wBattleMonsterId, wDefeatFlagsBA, wSpeciesGroups
RunBattleActions_Case08_Sub01_Case0A::
Jump_03B_45A6:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleFlag93]
    cp a, $1F
    jr z, Jump_03B_45CF
    cp a, $1D
    jr z, Jump_03B_45C7
    ld a, [wBattleFlag92]
    cp a, $10
    jr z, Jump_03B_4627
    cp a, $20
    ret nz
    ld a, [wBattleFlag93]
    cp a, $1E
    jr nz, Jump_03B_4627
    ret

Jump_03B_45C7::
    ld a, [wBattleTarget]
    cp a, $04
    ret c
    jr Jump_03B_4627

Jump_03B_45CF::
    ld a, [wDefeatFlagsBA]
    bit 7, a
    call z, GroupTargetsBySpeciesToSpeciesGroups
    ld a, [wBattleTarget]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    or a, a
    jr z, Jump_03B_45FF
    ld d, $2B
    farcall ShowBattleTextCategory0
    jr Jump_03B_4607

Jump_03B_45FF::
    ld d, $2A
    farcall ShowBattleTextCategory0

Jump_03B_4607::
    ld hl, wDefeatFlagsBA
    dec [hl]
    ld a, [hl]
    cp a, $80
    ret z
    ld a, $04
    ld [wBattleResolveStep], a
    ld a, [hl]
    and a, $7F
    dec a
    ld hl, wSpeciesGroups
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld [wBattleTarget], a
    ret

Jump_03B_4627::
    call RunOnce4650Then4673
    ret z
    ld a, c
    ld [wBattleTarget], a
    ld a, $03
    ld [wBattleResolveStep], a
    ret

; runs Func_03B_4650 once (marked by bit 7 of wDABA), then Func_03B_4673 each time; returns wDABA & $7F (E-0122)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_Case0A)
; reads: wDefeatFlagsBA
; writes: wDefeatFlagsBA
RunOnce4650Then4673::
Func_03B_4635:: ; address name
    ld a, [wDefeatFlagsBA]
    bit 7, a
    jr nz, Jump_03B_4647
    call RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty
    ld a, [wDefeatFlagsBA]
    or a, $80
    ld [wDefeatFlagsBA], a

Jump_03B_4647::
    call RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty_Sub02
    ld a, [wDefeatFlagsBA]
    and a, $7F
    ret

; only called from RunOnce4650Then4673 (E-0047)
; 1 call site from 1 routine (e.g. RunOnce4650Then4673)
; reads: wBattleTarget
; points at: wDefeatFlagsBA
RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty::
Func_03B_4650:: ; address name
    ld b, $04
    ld a, [wBattleTarget]
    and a, $04
    ld c, a

Jump_03B_4658::
    ld a, [wBattleTarget]
    cp a, c
    jr z, Jump_03B_4668
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, Jump_03B_4668
    jr z, Jump_03B_466C
    jr Jump_03B_466C

Jump_03B_4668::
    ld hl, wDefeatFlagsBA
    inc [hl]

Jump_03B_466C::
    inc c
    dec b
    ld a, b
    or a, a
    jr nz, Jump_03B_4658
    ret

; only called from RunOnce4650Then4673 (E-0047)
; 1 call site from 1 routine (e.g. RunOnce4650Then4673)
; reads: wBattleTarget, wRecordBufferData
; points at: wDefeatFlagsBA
RunOnce4650Then4673_CarryUnlessBattleSlotOutSlotEmpty_Sub02::
Func_03B_4673:: ; address name
    ld a, [wBattleTarget]
    inc a
    ld c, a
    ld hl, wDefeatFlagsBA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

Jump_03B_4680::
    ld a, [wRecordBufferData + $4]
    cp a, $80
    jr nz, Jump_03B_4694
    ld a, c
    and a, $03
    jr nz, Jump_03B_4694
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a

Jump_03B_4694::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    jr z, Jump_03B_469B

Jump_03B_469B::
    inc c
    jr Jump_03B_4680

; entry 11 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveMsgArg, wSlotsOccupiedFlag, wBattleFlag93, wCommandCursor, wMenuOption, wItemId, wItemRecord
; writes: wItemId, wInventorySlot
; points at: wBattleResolveStep
RunBattleActions_Case08_Sub01_LoadItemRecord::
Jump_03B_469E:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgArg]
    bit 0, a
    jr nz, Jump_03B_46AE
    ld a, [wSlotsOccupiedFlag]
    or a, a
    ret z

Jump_03B_46AE::
    ld a, [wBattleFlag93]
    ld [wItemId], a
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuOption]
    and a, $03
    add a, b
    ld [wInventorySlot], a
    farcall LoadItemRecord
    farcall ConsumeSelectedItemByChance
    ld a, [wItemId]
    cp a, $FF
    ret nz
    ld a, [wItemRecord + $3]
    cp a, $64
    jr nz, Jump_03B_46E6
    ld a, [wBattleFlag93]
    cp a, $1E
    jr z, Jump_03B_46E6
    ret

Jump_03B_46E6::
    ld d, $87 ; battle text 'The W shattered!'
    farcall ShowBattleText
    ret

; entry 12 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; writes: wDefeatFlagsBA, wBattleSubPhase, wBattleResolveStep
RunBattleActions_Case08_Sub01_Case0C::
Jump_03B_46EF:: ; address name
    xor a, a
    ld [wDefeatFlagsBA], a
    ld a, $07
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 13 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleActions_Case08_Sub01_ShowButNothingHappened::
Jump_03B_46FD:: ; address name
    ld d, $CC ; battle text 'But nothing happened!'
    farcall ShowBattleText
    ld a, $0C
    ld [wBattleResolveStep], a
    ret

; wBattleResolveStep = $0A (the damage-message step, ResolveStepDamageMessage) (E-0116)
; 2 call sites from 2 routines (e.g. SetResolveStep0AUnlessResolveMsgFlagsBit4, RunBattleActions_Case08_Sub01_ShowHeroIsAHunk)
; writes: wBattleResolveStep
SetResolveStep0A::
Func_03B_470B:: ; address name
    ld a, $0A
    ld [wBattleResolveStep], a
    ret

; lists the target side's species and groups the targets that share the target's species into wD88B-wD88D (bit 7 marks a group) (E-0131)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_Case0A)
; reads: wBattleTarget
; writes: wSpeciesGroups, wDefeatFlagsBA
; points at: wSpeciesGroups, wTemp0
GroupTargetsBySpeciesToSpeciesGroups::
Func_03B_4711:: ; address name
    ld a, $FF
    ld hl, wSpeciesGroups
    ld bc, $0003
    call FillBytes
    farcall ListSideMonsterIdsToWC0A0
    ld a, d
    cp a, $03
    jr z, Jump_03B_4735
    cp a, $02
    jp z, Jump_03B_47CD
    ld a, [wBattleTarget]
    ld [wSpeciesGroups], a
    jp Jump_03B_4813

Jump_03B_4735::
    ld a, [wBattleTarget]
    ld c, a
    ld a, c
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc c
    ld a, c
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4785
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4785
    inc c
    ld a, c
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4775
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4775
    ld a, c
    or a, $80
    ld [wSpeciesGroups], a
    jp Jump_03B_4813

Jump_03B_4775::
    ld a, [wBattleTarget]
    or a, $80
    ld [wSpeciesGroups + $1], a
    ld a, c
    ld d, a
    ld [wSpeciesGroups], a
    jp Jump_03B_481F

Jump_03B_4785::
    inc c
    ld a, c
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_47A8
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_47A8
    ld a, [wBattleTarget]
    or a, $80
    ld [wSpeciesGroups + $1], a
    dec c
    ld a, c
    ld d, a
    ld [wSpeciesGroups], a
    jr Jump_03B_481F

Jump_03B_47A8::
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec c
    ld a, c
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4823
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4823
    ld a, [wBattleTarget]
    ld [wSpeciesGroups + $1], a
    ld a, c
    ld d, a
    or a, $80
    ld [wSpeciesGroups], a
    jr Jump_03B_481F

Jump_03B_47CD::
    ld a, [wBattleTarget]
    ld c, a
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_03B_47E3
    inc c
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_03B_47E9
    ld d, c
    dec c
    ld e, c
    jr Jump_03B_47EE

Jump_03B_47E3::
    inc c
    ld e, c
    inc c
    ld d, c
    jr Jump_03B_47EE

Jump_03B_47E9::
    dec c
    ld e, c
    inc c
    inc c
    ld d, c

Jump_03B_47EE::
    ld a, e
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, d
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl+]
    cp a, c
    jr nz, Jump_03B_4817
    ld a, [hl]
    cp a, b
    jr nz, Jump_03B_4817
    ld a, e
    or a, $80
    ld [wSpeciesGroups], a

Jump_03B_4813::
    ld a, $01
    jr Jump_03B_4834

Jump_03B_4817::
    ld a, e
    ld [wSpeciesGroups + $1], a
    ld a, d
    ld [wSpeciesGroups], a

Jump_03B_481F::
    ld a, $02
    jr Jump_03B_4834

Jump_03B_4823::
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

Jump_03B_4834::
    or a, $80
    ld [wDefeatFlagsBA], a
    ret

; sets the damage word to the target's max HP for action $03, a random 30-40 for actions $01 and $38, else a random 60-70; adds it to the target's HP capped at max HP (the damage word becomes the amount actually added when capped) (E-0236)
; 2 call sites from 2 routines (e.g. RaiseWord3FAndRestoreHP, RestoreTargetHPIfHurt)
; reads: wBattleActionId, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleHP, wBattleMaxHP
RestoreTargetHPByActionAmount::
Func_03B_483A:: ; address name
    ld a, [wBattleActionId]
    cp a, $03
    jr z, Jump_03B_485F
    cp a, $01
    jr z, Jump_03B_4854
    cp a, $38
    jr z, Jump_03B_4854
    ld hl, $003C
    ld bc, $0046
    call SetDamageRandomInRange
    jr Jump_03B_4873

Jump_03B_4854::
    ld hl, $001E
    ld bc, $0028
    call SetDamageRandomInRange
    jr Jump_03B_4873

Jump_03B_485F::
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

Jump_03B_4873::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxHP_Bank3B
    call CompareHLToBC
    jr nc, Jump_03B_4896
    call SetDamageDEMinusBCPlusHL
    ld b, h
    ld c, l

Jump_03B_4896::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; only called from RestoreTargetMPIfLow (E-0047)
; 1 call site from 1 routine (e.g. RestoreTargetMPIfLow)
; reads: wBattleActionId, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleMP, wBattleMaxMP
RestoreTargetMPIfLow_SetDamageRandomInRange::
Func_03B_489B:: ; address name
    ld a, [wBattleActionId]
    cp a, $05
    jr z, Jump_03B_48AD
    ld hl, $0014
    ld bc, $001E
    call SetDamageRandomInRange
    jr Jump_03B_48C1

Jump_03B_48AD::
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

Jump_03B_48C1::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank3B
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxMP_Bank3B
    call CompareHLToBC
    jr nc, Jump_03B_48E4
    call SetDamageDEMinusBCPlusHL
    ld b, h
    ld c, l

Jump_03B_48E4::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; damage word = DE - (BC - HL) (E-0118)
; 2 call sites from 2 routines (e.g. RestoreTargetHPByActionAmount, RestoreTargetMPIfLow_SetDamageRandomInRange)
; writes: wBattleDamageLo, wBattleDamageHi
SetDamageDEMinusBCPlusHL::
Func_03B_48E9:: ; address name
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, e
    sub a, c
    ld [wBattleDamageLo], a
    ld a, d
    sbc a, b
    ld [wBattleDamageHi], a
    ret

; the target's wD93F word -= Data_03B_492A[action - $19], floored at 0 (E-0124)
; 2 call sites from 2 routines (e.g. InflictStatus0Bit0WithBattleWordArray3FReduction, ApplyTargetBattleWordArray3FReduction)
; reads: wBattleTarget, wBattleActionId
; points at: wBattleWordArray3F
SubtractActionAmountFromTargetBattleWordArray3F::
Func_03B_48FA:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleWordArray3F
    call AddDoubleAToHL_Bank3B
    push hl
    deref_hl
    push hl
    ld a, [wBattleActionId]
    sub a, $19
    add a, a
    ld hl, Data_03B_492A
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    pop hl
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    jr nc, Jump_03B_4925
    ld bc, $0000

Jump_03B_4925::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; address loaded by SubtractActionAmountFromTargetBattleWordArray3F
Data_03B_492A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $00, $0A, $00, $14, $00, $64, $00, $05, $00

; adds the word Data_03B_4949[action - $19] to wD89F, capped at 1800 (E-0122)
; 2 call sites from 2 routines (e.g. InflictStatus0Bit0WithBattleWordArray3FReduction, ApplyTargetBattleWordArray3FReduction)
; reads: wBattleActionId
AddActionAmountToBattleMeter::
Func_03B_4934:: ; address name
    ld a, [wBattleActionId]
    sub a, $19
    add a, a
    ld hl, Data_03B_4949
    add_a_to_hl
    deref_hl
    call AddHLToBattleMeterCappedAt1800
    ret

; address loaded by AddActionAmountToBattleMeter
Data_03B_4949:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $00, $1E, $00, $64, $00, $E7, $03, $05, $00

; wD89F += HL, capped at $0708 (1800) (E-0122)
; 2 call sites from 2 routines (e.g. AddActionAmountToBattleMeter, RunBattleActions_Case08_Sub01_Case05)
; reads: wBattleMeter
; writes: wBattleMeter
AddHLToBattleMeterCappedAt1800::
Func_03B_4953:: ; address name
    ld a, [wBattleMeter]
    ld c, a
    ld a, [wBattleMeter + $1]
    ld b, a
    add hl, bc
    ld bc, $0708
    call CompareHLToBC
    jr c, Jump_03B_4967
    ld hl, $0708

Jump_03B_4967::
    ld a, l
    ld [wBattleMeter], a
    ld a, h
    ld [wBattleMeter + $1], a
    ret

; wD89F -= HL, floored at 0 (E-0124)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_Case05)
; reads: wBattleMeter
; writes: wBattleMeter
SubtractHLFromBattleMeterFloored::
Func_03B_4970:: ; address name
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
    jr z, Jump_03B_4987
    ld hl, $0000

Jump_03B_4987::
    ld a, l
    ld [wBattleMeter], a
    ld a, h
    ld [wBattleMeter + $1], a
    ret

; actions $24 onward: damage = random in the range from Data_03B_4A24[action - $24], then scaled by the target's resistance level for that element (85 percent at level 1, less above) (E-0129)
; 1 call site from 1 routine (e.g. RollTableDamageWithMessage35)
; reads: wBattleActionId, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
RollTableDamageScaledByResistance::
Func_03B_4990:: ; address name
    ld a, [wBattleActionId]
    sub a, $24
    add a, a
    add a, a
    ld de, Data_03B_4A24
    add a, e
    ld e, a
    jr nc, Jump_03B_499F
    inc d

Jump_03B_499F::
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
    cp a, $24
    jr nz, Jump_03B_49BD
    call TargetSlotResistancesByte1_Bank3B
    rlca
    rlca
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49BD::
    cp a, $25
    jr nz, Jump_03B_49CA
    call TargetSlotResistancesByte1_Bank3B
    swap a
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49CA::
    cp a, $26
    jr nz, Jump_03B_49D7
    call TargetSlotResistancesByte1_Bank3B
    rrca
    rrca
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49D7::
    call TargetSlotResistancesByte0_Bank3B
    swap a
    and a, $03

Jump_03B_49DE::
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_03B_4A03
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

Jump_03B_4A03::
    cp a, $02
    jr nz, Jump_03B_4A1C
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

Jump_03B_4A1C::
    xor a, a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ret

; address loaded by RollTableDamageScaledByResistance
Data_03B_4A24:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $00, $18, $00, $23, $00, $32, $00, $78, $00, $8C, $00, $B4, $00, $C8, $00

; only called from InflictTargetStatus0Bit0 (E-0047)
; 1 call site from 1 routine (e.g. InflictTargetStatus0Bit0)
InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B::
Func_03B_4A34:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank3B
    call TargetWDA74Byte
    and a, $03
    call RollChanceByHLBits6And7_Bank3B
    ret

; wBattleDamageLo/wD873 = RandomInRange(HL, BC) (E-0116)
; 4 call sites from 3 routines (e.g. RestoreTargetHPByActionAmount, RestoreTargetMPIfLow_SetDamageRandomInRange, RollTableDamageScaledByResistance)
; writes: wBattleDamageLo, wBattleDamageHi
SetDamageRandomInRange::
Func_03B_4A40:: ; address name
    call RandomInRange
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ret

; HL = wD814 + 9 * [wD8A5] (AddAx9ToHL); A = [wD8A5] (the same 10 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B)
; reads: wBattleTarget
; points at: wBattleStatus8
HLToBattleStatus8EntryOfBattleTarget_Bank3B::
Func_03B_4A4C:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ret

; A = byte 0 of the target's 7-byte wDA72 record (E-0126)
; 1 call site from 1 routine (e.g. RollTableDamageScaledByResistance)
; reads: wBattleTarget
; points at: wSlotResistances
TargetSlotResistancesByte0_Bank3B::
Func_03B_4A56:: ; address name
    ld de, wSlotResistances
    jr Jump_03B_4A77

; A = byte 1 of the target's 7-byte wDA72 record (E-0126)
; 3 call sites from 1 routine (e.g. RollTableDamageScaledByResistance)
; reads: wBattleTarget
TargetSlotResistancesByte1_Bank3B::
Func_03B_4A5B:: ; address name
    ld de, wSlotResistances + $1
    jr Jump_03B_4A77

; A = byte 2 of the target's 7-byte wDA72 record (wDA74 + 7 * target) (E-0124)
; 1 call site from 1 routine (e.g. InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B)
; reads: wBattleTarget
TargetWDA74Byte::
Func_03B_4A60:: ; address name
    ld de, wSlotResistances + $2
    jr Jump_03B_4A77

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
GetTargetSlotResistancesByte3_Bank3B:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 36:61B5; C0
Func_03B_4A65:: ; address name
    ld de, wSlotResistances + $3
    jr Jump_03B_4A77
    db $11, $76, $DA, $18, $08, $11, $77, $DA, $18, $03, $11, $78, $DA

Jump_03B_4A77::
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_03B_4A84
    inc d

Jump_03B_4A84::
    ld a, [de]
    ret

; bit 6 of [HL]: Func_03B_4ABF; else bit 7: RollChanceByLevel_100_100_75_0_Bank3B; else RollChanceForLevelA_Bank3B (E-0122)
; 1 call site from 1 routine (e.g. InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B)
RollChanceByHLBits6And7_Bank3B::
Func_03B_4A86:: ; address name
    bit 6, [hl]
    jr z, Jump_03B_4A8F
    call RollChanceByHLBits6And7_Bank3B_Sub01
    jr Jump_03B_4A9B

Jump_03B_4A8F::
    bit 7, [hl]
    jr z, Jump_03B_4A98
    call RollChanceByLevel_100_100_75_0_Bank3B
    jr Jump_03B_4A9B

Jump_03B_4A98::
    call RollChanceForLevelA_Bank3B

Jump_03B_4A9B::
    ret

; level A: 0 returns carry; 1 and 2 take two chance rolls; 3 returns no carry (E-0122)
; 1 call site from 1 routine (e.g. RollChanceByHLBits6And7_Bank3B)
; reads: wRandomLo
RollChanceForLevelA_Bank3B::
Func_03B_4A9C:: ; address name
    and a, a
    jr nz, Jump_03B_4AA1
    scf
    ret

Jump_03B_4AA1::
    cp a, $01
    jr nz, Jump_03B_4AA8
    jp Jump_03B_4AD5

Jump_03B_4AA8::
    cp a, $02
    jr nz, Jump_03B_4AAF
    jp Jump_03B_4AE7

Jump_03B_4AAF::
    scf
    ccf
    ret

; the same instruction sequence as RollChanceByLevel_100_100_75_0 (bank $36) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. RollChanceByHLBits6And7_Bank3B)
; reads: wRandomLo
RollChanceByLevel_100_100_75_0_Bank3B::
Func_03B_4AB2:: ; address name
    cp a, $02
    jr nc, Jump_03B_4AB7
    ret

Jump_03B_4AB7::
    jr nz, Jump_03B_4ABC
    jp Jump_03B_4ADE

Jump_03B_4ABC::
    scf
    ccf
    ret

; only called from RollChanceByHLBits6And7_Bank3B (E-0047)
; 1 call site from 1 routine (e.g. RollChanceByHLBits6And7_Bank3B)
; reads: wRandomLo
RollChanceByHLBits6And7_Bank3B_Sub01::
Func_03B_4ABF:: ; address name
    and a, a
    jr nz, Jump_03B_4AC4
    scf
    ret

Jump_03B_4AC4::
    cp a, $01
    jr nz, Jump_03B_4ACB
    jp Jump_03B_4ADE

Jump_03B_4ACB::
    cp a, $02
    jr nz, Jump_03B_4AD2
    jp Jump_03B_4AF0

Jump_03B_4AD2::
    scf
    ccf
    ret

Jump_03B_4AD5::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $D8
    ret

Jump_03B_4ADE::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $BF
    ret

Jump_03B_4AE7::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $7F
    ret

Jump_03B_4AF0::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $66
    ret

; AdvanceRandom, then compares wC5E7 with $3F: carry (success) about one time in four (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo
RollChance3FOf256:: ; heuristic: follows a terminator; C0
Func_03B_4AF9:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $3F
    ret

; jumps to the routine whose address is at $4B11 + 2 * wBattleActionId (JumpToWordAtHL), the bank-$3B counterpart of DispatchActionEffectTable (E-0116)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_DispatchActionEffectTable_Bank3BAndStep)
; reads: wBattleActionId
DispatchActionEffectTable_Bank3B::
Func_03B_4B02:: ; address name
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld hl, $4B11
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; E-0239 (C1: Func_03B_4B02 jumps (JumpToWordAtHL) to the word at $4B11 + 2 * wBattleActionId; 64 words up to the first target at $4B91, a lone ret).
; record: effect routine for this wBattleActionId
ActionIdEffectTable_3B::
Data_03B_4B11:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
ActionIdEffectNone_3B_4B91:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4B91:: ; address name
    ret

; if the target's HP is below its max, runs Func_03B_483A and shows message $37; otherwise the no-effect path (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleHP, wBattleMaxHP
RestoreTargetHPIfHurt:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4B92:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank3B
    deref_hl
    call CompareHLToBC
    jr z, Jump_03B_4BBA
    call RestoreTargetHPByActionAmount
    ld l, $37
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4BBA::
    jp Jump_03B_4EE3

; if the target's MP is below its max, runs Func_03B_489B and shows message $C3; otherwise the no-effect path (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleMP, wBattleMaxMP
RestoreTargetMPIfLow:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4BBD:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank3B
    deref_hl
    call CompareHLToBC
    jr z, Jump_03B_4BE5
    call RestoreTargetMPIfLow_SetDamageRandomInRange
    ld l, $C3
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4BE5::
    jp Jump_03B_4EE3

; clears status byte 0 bits 0-1 of the target when set (message $4E); otherwise takes the no-effect path (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
CureTargetStatus0Bits01:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4BE8:: ; address name
    call ClearDamageAndReadTargetStatus0
    and a, $03
    jr z, Jump_03B_4BFB
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4BFB::
    jp Jump_03B_4EE3

; clears status byte 0 bit 6 of the target when set (message $4F, wDA5B[target] = 3); otherwise takes the no-effect path (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wSlotMarks
CureTargetStatus0Bit6:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4BFE:: ; address name
    call ClearDamageAndReadTargetStatus0
    and a, $40
    jr z, Jump_03B_4C1E
    ld a, [hl]
    and a, $BF
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $4F
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4C1E::
    jp Jump_03B_4EE3

; clears status byte 0 bit 5 of the target when set (message $51); otherwise takes the no-effect path (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
CureTargetStatus0Bit5:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4C21:: ; address name
    call ClearDamageAndReadTargetStatus0
    and a, $20
    jr z, Jump_03B_4C34
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4C34::
    jp Jump_03B_4EE3

; clears status byte 0 bits 2, 3 and 7 of the target when set (message $82, wDA5B[target] = 3); otherwise takes the no-effect path (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wSlotMarks
CureTargetStatus0Bits237:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4C37:: ; address name
    call ClearDamageAndReadTargetStatus0
    and a, $8C
    jr z, Jump_03B_4C57
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $82
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4C57::
    jp Jump_03B_4EE3

; clears status byte 0 bit 4 of the target when set (message $83, wDA5B[target] = 3); otherwise takes the no-effect path (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wSlotMarks
CureTargetStatus0Bit4:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4C5A:: ; address name
    call ClearDamageAndReadTargetStatus0
    and a, $10
    jr z, Jump_03B_4C7A
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4C7A::
    jp Jump_03B_4EE3

; if the target slot is occupied, far-calls ApplyTargetMaxHPAmount; otherwise one of two failure paths (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleResolveStep, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ApplyTargetMaxHPIfPresent:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4C7D:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, Jump_03B_4C8E
    jr z, Jump_03B_4C91
    farcall ApplyTargetMaxHPAmount
    ret

Jump_03B_4C8E::
    jp Jump_03B_4EE3

Jump_03B_4C91::
    jp Jump_03B_4F15

; a lone ret: the entry of ActionIdEffectTable_3B for 12 action ids (E-0239)
; no direct call (reached through a table, a jump or a vector)
ActionIdEffectNone_3B_4C94:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4C94:: ; address name
    ret

; for local targets adds the action amount to wD89F; for others checks status, block and resistance and subtracts the amount from the target's wD93F; then stores message $95 or $FD (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus
ApplyTargetBattleWordArray3FReduction:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4C95:: ; address name
    call TargetOnLocalSide_Bank3B
    jr c, Jump_03B_4C9F
    call AddActionAmountToBattleMeter
    jr Jump_03B_4CC8

Jump_03B_4C9F::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, Jump_03B_4CEA
    and a, $8C
    jr nz, Jump_03B_4CF2
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and a, $C0
    jr nz, Jump_03B_4D00
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jr c, Jump_03B_4D0E
    call SubtractActionAmountFromTargetBattleWordArray3F

Jump_03B_4CC8::
    ld a, [wBattleTarget]
    cp a, $03
    jr c, Jump_03B_4CE2
    farcall ListSideMonsterIdsToWC0A0
    ld a, b
    cp a, $01
    jr z, Jump_03B_4CE2
    ld l, $FD
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4CE2::
    ld l, $95
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4CEA::
    ld h, $E6
    ld bc, $0080
    jp Jump_03B_4EF6

Jump_03B_4CF2::
    ld d, $7B
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4D00::
    ld d, $7D
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4D0E::
    ld d, $7C
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp Jump_03B_4EFA

; reduces the target's wD93F (or adds to wD89F for local targets); when status bits 0-1 are clear and the chance roll passes, sets status bit 0 (message $75) (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatFlagsBA, wBattleTarget
; writes: wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus
InflictStatus0Bit0WithBattleWordArray3FReduction:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4D1C:: ; address name
    call TargetOnLocalSide_Bank3B
    jr c, Jump_03B_4D2C
    ld a, [wDefeatFlagsBA]
    or a, a
    jr nz, Jump_03B_4D59
    call AddActionAmountToBattleMeter
    jr Jump_03B_4D59

Jump_03B_4D2C::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jp nz, Jump_03B_4DD8
    and a, $8C
    jp nz, Jump_03B_4DE0
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and a, $C0
    jp nz, Jump_03B_4DEE
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jp c, Jump_03B_4DFC
    call SubtractActionAmountFromTargetBattleWordArray3F

Jump_03B_4D59::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, Jump_03B_4DAC
    push hl
    farcall RollTargetSlotResistancesByte4Bits01ChanceToE
    pop hl
    ld a, e
    or a, a
    jr nz, Jump_03B_4DAC
    set 0, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3B
    ld l, $75
    ld bc, $0090
    call ClearDamageAndStoreResolveMsgFlags_Bank3B
    ld a, [wDefeatFlagsBA]
    or a, a
    ret nz
    ld a, [wBattleTarget]
    cp a, $03
    jr c, Jump_03B_4DA3
    farcall ListSideMonsterIdsToWC0A0
    ld a, b
    cp a, $01
    jr z, Jump_03B_4DA3
    ld d, $FE ; battle text 'Monsters ate the meat fearfully! Monsters'
    farcall ShowBattleText
    ret

Jump_03B_4DA3::
    ld d, $96 ; battle text '0 ate the meat fearfully! 0'
    farcall ShowBattleText
    ret

Jump_03B_4DAC::
    call SetWDAC3B5AndResolveMsgFlagsTo0180
    ld a, [wDefeatFlagsBA]
    or a, a
    ret nz
    ld a, [wBattleTarget]
    cp a, $03
    jr c, Jump_03B_4DCF
    farcall ListSideMonsterIdsToWC0A0
    ld a, b
    cp a, $01
    jr z, Jump_03B_4DCF
    ld d, $FE ; battle text 'Monsters ate the meat fearfully! Monsters'
    farcall ShowBattleText
    ret

Jump_03B_4DCF::
    ld d, $96 ; battle text '0 ate the meat fearfully! 0'
    farcall ShowBattleText
    ret

Jump_03B_4DD8::
    ld h, $E6
    ld bc, $0080
    jp Jump_03B_4EF6

Jump_03B_4DE0::
    ld d, $7B
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4DEE::
    ld d, $7D
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4DFC::
    ld d, $7C
    farcall ShowBattleTextCategory0
    ld bc, $0000
    jp Jump_03B_4EFA

; wD894 = 1 and stores message $98 (ClearDamageAndStoreResolveMsgFlags_Bank3B) (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleEndFlag, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
SetBattleEndFlagAndMessage98:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4E0A:: ; address name
    ld a, $01
    ld [wBattleEndFlag], a
    ld l, $98
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B
    db $C9

; effect table entry that goes straight to the failure path Jump_03B_4F15 (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
JumpToEffectFailurePath4F15:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4E18:: ; address name
    jp Jump_03B_4F15

; unless already set, rolls the chance (Func_03B_4A34) and sets bit 0 of the target's wD80D status (message $3B); otherwise one of two failure paths (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleResolveStep
; points at: wBattleStatus1
InflictTargetStatus0Bit0:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4E1B:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_03B_4E40
    call InflictTargetStatus0Bit0_HLToBattleStatus8EntryOfBattleTarget_Bank3B
    jr nc, Jump_03B_4E43
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4E40::
    jp Jump_03B_4F15

Jump_03B_4E43::
    jp Jump_03B_4EEA

; sets bit 2 of the target's status byte 0 (message $43); if already set takes the failure path (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleResolveStep
; points at: wBattleStatus1
InflictTargetStatus0Bit2:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4E46:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, Jump_03B_4E5D
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank3B

Jump_03B_4E5D::
    jp Jump_03B_4F15

; calls RollTableDamageScaledByResistance, then stores resolve message $35 (wResolveMsgActor/Target = $35/$B5, flags $A8, arg $80); entry of ActionIdEffectTable_3B (E-0239; E-0236 had found no caller)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
RollTableDamageWithMessage35:: ; configured code entry (E-0236); C0
Func_03B_4E60:: ; address name
    call RollTableDamageScaledByResistance
    jp Jump_03B_4EB0

; adds 30 to the target's wBattleWordArray3F word capped at 999, then if its HP is below max runs RestoreTargetHPByActionAmount and shows message $37, otherwise takes the no-effect path; entry of ActionIdEffectTable_3B (E-0239; E-0236 had found no caller)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleWordArray3F, wBattleHP, wBattleMaxHP
RaiseWord3FAndRestoreHP:: ; code pointer of the table ActionIdEffectTable_3B; C0
Func_03B_4E66:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleWordArray3F
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    add a, $1E
    ld c, a
    ld a, [hl]
    adc a, $00
    ld b, a
    ld a, b
    sub a, $03
    ld a, c
    sbc a, $E7
    jr c, Jump_03B_4E82
    ld bc, $03E7

Jump_03B_4E82::
    ld [hl], b
    dec hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3B
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank3B
    deref_hl
    call CompareHLToBC
    jr z, Jump_03B_4EAD
    call RestoreTargetHPByActionAmount
    ld l, $37
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4EAD::
    jp Jump_03B_4EE3

Jump_03B_4EB0::
    ld hl, $B535
    ld bc, $80A8
    jr Jump_03B_4EBE

; HL = $D035, BC = $88A8, then falls into the resolve-message store at $4EBE; skipped by the jr before it and no caller found (E-0236)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
UnreferencedStoreResolveMessage35D0:: ; configured code entry (E-0236); C0
Func_03B_4EB8:: ; address name
    ld hl, $D035
    ld bc, $88A8

Jump_03B_4EBE::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, h
    ld [wResolveMsgTarget], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; clears wBattleDamageLo/wD873 (the damage word), then wDAC2 = L, wDAC0 = C, wDAC1 = B (the same instructions as the bank-$36 copy) (E-0073)
; 1 call site from 1 routine (e.g. InflictStatus0Bit0WithBattleWordArray3FReduction)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
ClearDamageAndStoreResolveMsgFlags_Bank3B::
Func_03B_4ECF:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

Jump_03B_4ED6::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

Jump_03B_4EE3::
    ld h, $CC
    ld bc, $0080
    jr Jump_03B_4EF6

Jump_03B_4EEA::
    ld h, $B5
    ld bc, $0080
    jr Jump_03B_4EF6

; wDAC3 = $B5 and the word wDAC0 = $0180 (E-0122)
; 1 call site from 1 routine (e.g. InflictStatus0Bit0WithBattleWordArray3FReduction)
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
SetWDAC3B5AndResolveMsgFlagsTo0180::
Func_03B_4EF1:: ; address name
    ld h, $B5
    ld bc, $0180

Jump_03B_4EF6::
    ld a, h
    ld [wResolveMsgTarget], a

Jump_03B_4EFA::
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; clears wBattleDamageLo/wD873, then A = status byte 0 of wBattleTarget (wBattleStatus + 9 * target), HL pointing at it (E-0078)
; 5 call sites from 5 routines (e.g. CureTargetStatus0Bit4, CureTargetStatus0Bits237, CureTargetStatus0Bit5, CureTargetStatus0Bit6, ...)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus
ClearDamageAndReadTargetStatus0::
Func_03B_4F03:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    ret

Jump_03B_4F15::
    ld a, $0A
    ld [wBattleResolveStep], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RestoreTargetHPByActionAmount)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank3B::
Func_03B_4F25:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_03B_4F48

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RestoreTargetMPIfLow_SetDamageRandomInRange)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank3B::
Func_03B_4F2A:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_03B_4F48

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_Bank3B:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4015; C0
Func_03B_4F2F:: ; address name
    ld hl, wBattleHP
    jr Jump_03B_4F48

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_Bank3B:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:401A; C0
Func_03B_4F34:: ; address name
    ld hl, wBattleMP
    jr Jump_03B_4F48
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_03B_4F48::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; 13 call sites from 7 routines (e.g. RaiseWord3FAndRestoreHP, RestoreTargetHPByActionAmount, SubtractActionAmountFromTargetBattleWordArray3F, RestoreTargetMPIfLow, ...)
AddDoubleAToHL_Bank3B::
Func_03B_4F52:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_4F59:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_03B_4F6E
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_03B_4F6E
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_03B_4F6E::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; 3 call sites from 3 routines (e.g. InflictStatus0Bit0WithBattleWordArray3FReduction, ApplyTargetBattleWordArray3FReduction, RunBattleActions_Case08_Sub01_TargetOnLocalSide_Bank3B)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank3B::
Func_03B_4F74:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_03B_4F89
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_03B_4F89
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_03B_4F89::
    ld a, [wBattleTarget]
    cp a, $04
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank3B:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_03B_4F8F:: ; address name
    ld a, d
    ld hl, Data_03B_4FA4
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; address loaded by ClearBattleStatusBitsWithMaskD_Bank3B
Data_03B_4FA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_AddDoubleAToHL_Bank3B)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank3B::
Func_03B_4FAB:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunBattleActions_Case08_Sub01_AddDoubleAToHL_Bank3B)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank3B::
Func_03B_4FB8:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 2 call sites from 2 routines (e.g. InflictStatus0Bit0WithBattleWordArray3FReduction, RunBattleActions_Case08_Sub01_AddDoubleAToHL_Bank3B)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank3B::
Func_03B_4FC5:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_4FD2:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03B_4FEE
    ld l, $09
    cp a, $40
    jr nc, Jump_03B_4FEE
    ld l, $12

Jump_03B_4FEE::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03B_5009
    ld l, $03
    cp a, $40
    jr nc, Jump_03B_5009
    ld l, $06

Jump_03B_5009::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03B_5024
    ld l, $01
    cp a, $40
    jr nc, Jump_03B_5024
    ld l, $02

Jump_03B_5024::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_5029:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03B_5043
    ld a, [hl]
    and a, $0C
    jr nz, Jump_03B_5043
    xor a, a
    jr Jump_03B_5044

Jump_03B_5043::
    scf

Jump_03B_5044::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_5048:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03B_5057
    ld a, [hl]
    and a, $0C

Jump_03B_5057::
    pop hl
    ret

; sets the sprite origin X = wD804, Y = $68, tile offset = wD801, attribute XOR = wDAB7, then builds OAM from the local sprite table (E-0121)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange)
; reads: wEffectSpriteX, wEffectTileOffset, wEffectSpriteAttrXor
; points at: hSpriteOriginX
DrawEffectSpriteAtEffectSpriteX_Bank3B::
Func_03B_5059:: ; address name
    ld hl, hSpriteOriginX
    ld a, [wEffectSpriteX]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $68
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, [wEffectTileOffset]
    ld [hl+], a
    ld a, [wEffectSpriteAttrXor]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld de, MetaSprites3B_507CTable
    call BuildOamFromSpriteTable_Bank3B
    ret

; E-0147 (C1: the caller of BuildOamFromSpriteTable_Bank3B passes DE = $3B:507C; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 51 words, up to the next code or data).
; record: meta-sprite set
MetaSprites3B_507CTable::
Data_03B_507C:: ; address name
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

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtEffectSpriteX_Bank3B)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank3B::
Func_03B_50E2:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    jr nc, Jump_03B_5132
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
    ld h, $C0

Jump_03B_5105::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_03B_5132
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, b
    add a, $10
    ld [hl+], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteOriginX]
    add a, b
    add a, $08
    ld [hl+], a
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [de]
    inc de
    add a, b
    ld [hl+], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteAttrXor]
    xor a, b
    ld [hl+], a
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr c, Jump_03B_5105

Jump_03B_5132::
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3B_507CSet00::
Data_03B_5133:: ; address name
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

; E-0147 (derived: frame 0 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame0::
Data_03B_5173:: ; address name
    db $F8, $F8, $00, $00 ; entry 0
    db $F8, $FF, $00, $20 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame1::
Data_03B_517C:: ; address name
    db $F8, $F0, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F8, $00, $03, $20 ; entry 2
    db $F8, $07, $02, $20 ; entry 3
    db $F0, $FF, $01, $20 ; entry 4
    db $F0, $F8, $01, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame2::
Data_03B_5195:: ; address name
    db $F8, $F0, $05, $00 ; entry 0
    db $F8, $F8, $06, $00 ; entry 1
    db $F8, $07, $05, $20 ; entry 2
    db $F8, $FF, $06, $20 ; entry 3
    db $F0, $F8, $04, $00 ; entry 4
    db $F0, $FF, $04, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame3::
Data_03B_51AE:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F0, $F8, $07, $00 ; entry 1
    db $F8, $FF, $08, $20 ; entry 2
    db $F0, $FF, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame4::
Data_03B_51BF:: ; address name
    db $F8, $FC, $0A, $00 ; entry 0
    db $F0, $FC, $09, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame5::
Data_03B_51C8:: ; address name
    db $F8, $FC, $0B, $00 ; entry 0
    db $F0, $FC, $0A, $00 ; entry 1
    db $E8, $FC, $09, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame6::
Data_03B_51D5:: ; address name
    db $E8, $FC, $0D, $00 ; entry 0
    db $F0, $FC, $0E, $00 ; entry 1
    db $F8, $FC, $0C, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame7::
Data_03B_51E2:: ; address name
    db $E8, $F8, $11, $00 ; entry 0
    db $E8, $00, $12, $00 ; entry 1
    db $E0, $F8, $0F, $00 ; entry 2
    db $E0, $00, $10, $00 ; entry 3
    db $F0, $FC, $0C, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame8::
Data_03B_51F7:: ; address name
    db $E4, $F4, $16, $00 ; entry 0
    db $E4, $FC, $17, $00 ; entry 1
    db $E4, $04, $18, $00 ; entry 2
    db $DC, $F4, $13, $00 ; entry 3
    db $DC, $FC, $14, $00 ; entry 4
    db $DC, $04, $15, $00 ; entry 5
    db $EC, $F8, $19, $00 ; entry 6
    db $EC, $00, $1A, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame9::
Data_03B_5218:: ; address name
    db $D8, $F0, $1B, $00 ; entry 0
    db $D8, $F8, $1C, $00 ; entry 1
    db $D8, $00, $1D, $00 ; entry 2
    db $E0, $F0, $1E, $00 ; entry 3
    db $E0, $F8, $1F, $00 ; entry 4
    db $E0, $00, $1F, $20 ; entry 5
    db $E8, $F8, $1F, $40 ; entry 6
    db $E8, $00, $1F, $60 ; entry 7
    db $E0, $08, $20, $00 ; entry 8
    db $E8, $08, $1E, $60 ; entry 9
    db $F0, $F0, $22, $00 ; entry 10
    db $F0, $F8, $23, $00 ; entry 11
    db $F0, $00, $24, $00 ; entry 12
    db $F0, $08, $25, $00 ; entry 13
    db $E8, $F0, $21, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame10::
Data_03B_5255:: ; address name
    db $DE, $EE, $2C, $00 ; entry 0
    db $DE, $F6, $2D, $00 ; entry 1
    db $D6, $EE, $2A, $00 ; entry 2
    db $D6, $F6, $2B, $00 ; entry 3
    db $DE, $02, $28, $00 ; entry 4
    db $DE, $0A, $29, $00 ; entry 5
    db $D6, $02, $26, $00 ; entry 6
    db $D6, $0A, $27, $00 ; entry 7
    db $EA, $0A, $2C, $60 ; entry 8
    db $EA, $02, $2D, $60 ; entry 9
    db $F2, $0A, $2A, $60 ; entry 10
    db $F2, $02, $2B, $60 ; entry 11
    db $EA, $F6, $28, $60 ; entry 12
    db $EA, $EE, $29, $60 ; entry 13
    db $F2, $F6, $26, $60 ; entry 14
    db $F2, $EE, $27, $60 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame11::
Data_03B_5296:: ; address name
    db $DA, $06, $2F, $00 ; entry 0
    db $D2, $06, $2E, $00 ; entry 1
    db $D6, $12, $2F, $00 ; entry 2
    db $DA, $F2, $2E, $20 ; entry 3
    db $D2, $F2, $2F, $20 ; entry 4
    db $D7, $EA, $2E, $20 ; entry 5
    db $EE, $F2, $2F, $60 ; entry 6
    db $F6, $F2, $2E, $60 ; entry 7
    db $F2, $E6, $2F, $60 ; entry 8
    db $EE, $06, $2E, $40 ; entry 9
    db $F6, $06, $2F, $40 ; entry 10
    db $F1, $0E, $2E, $40 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3B_507CSet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet00Frame12::
    db $80 ; end

; E-0147 (derived: meta-sprite set 46 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3B_507CSet2E::
Data_03B_52C8:: ; address name
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

; E-0147 (derived: frame 0 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame0::
Data_03B_5308:: ; address name
    db $F8, $B0, $14, $00 ; entry 0
    db $E0, $B8, $00, $00 ; entry 1
    db $E0, $C0, $01, $00 ; entry 2
    db $E0, $C8, $02, $00 ; entry 3
    db $F0, $D8, $10, $00 ; entry 4
    db $F8, $C8, $15, $00 ; entry 5
    db $F8, $C0, $14, $00 ; entry 6
    db $E8, $B0, $04, $00 ; entry 7
    db $E8, $B8, $05, $00 ; entry 8
    db $E8, $C0, $06, $00 ; entry 9
    db $E8, $C8, $07, $00 ; entry 10
    db $E8, $D0, $08, $00 ; entry 11
    db $F0, $B0, $0B, $00 ; entry 12
    db $F0, $B8, $0C, $00 ; entry 13
    db $F0, $C0, $0D, $00 ; entry 14
    db $F0, $C8, $0E, $00 ; entry 15
    db $F0, $D0, $0F, $00 ; entry 16
    db $F8, $B8, $13, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame1::
Data_03B_5351:: ; address name
    db $F0, $C0, $14, $00 ; entry 0
    db $D8, $C8, $00, $00 ; entry 1
    db $D8, $D0, $01, $00 ; entry 2
    db $D8, $D8, $02, $00 ; entry 3
    db $E8, $E8, $10, $00 ; entry 4
    db $F0, $D8, $15, $00 ; entry 5
    db $F0, $D0, $14, $00 ; entry 6
    db $E0, $B8, $03, $00 ; entry 7
    db $E0, $C0, $04, $00 ; entry 8
    db $E0, $C8, $05, $00 ; entry 9
    db $E0, $D0, $06, $00 ; entry 10
    db $E0, $D8, $07, $00 ; entry 11
    db $E0, $E0, $08, $00 ; entry 12
    db $F0, $B0, $11, $00 ; entry 13
    db $F0, $B8, $12, $00 ; entry 14
    db $E8, $B0, $09, $00 ; entry 15
    db $E8, $B8, $0A, $00 ; entry 16
    db $E8, $C0, $0B, $00 ; entry 17
    db $E8, $C8, $0C, $00 ; entry 18
    db $E8, $D0, $0D, $00 ; entry 19
    db $E8, $D8, $0E, $00 ; entry 20
    db $E8, $E0, $0F, $00 ; entry 21
    db $F0, $C8, $13, $00 ; entry 22
    db $F8, $B0, $17, $00 ; entry 23
    db $F8, $C8, $19, $00 ; entry 24
    db $F8, $B8, $18, $00 ; entry 25
    db $F8, $C0, $18, $00 ; entry 26
    db $F8, $D0, $18, $00 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame2::
Data_03B_53C2:: ; address name
    db $E8, $C8, $14, $00 ; entry 0
    db $D0, $D0, $00, $00 ; entry 1
    db $D0, $D8, $01, $00 ; entry 2
    db $D0, $E0, $02, $00 ; entry 3
    db $E0, $F0, $10, $00 ; entry 4
    db $E8, $E0, $15, $00 ; entry 5
    db $E8, $D8, $14, $00 ; entry 6
    db $D8, $C0, $03, $00 ; entry 7
    db $D8, $C8, $04, $00 ; entry 8
    db $D8, $D0, $05, $00 ; entry 9
    db $D8, $D8, $06, $00 ; entry 10
    db $D8, $E0, $07, $00 ; entry 11
    db $D8, $E8, $08, $00 ; entry 12
    db $E8, $B8, $11, $00 ; entry 13
    db $E8, $C0, $12, $00 ; entry 14
    db $F8, $E0, $15, $40 ; entry 15
    db $E0, $B8, $09, $00 ; entry 16
    db $E0, $C0, $0A, $00 ; entry 17
    db $E0, $C8, $0B, $00 ; entry 18
    db $E0, $D0, $0C, $00 ; entry 19
    db $E0, $D8, $0D, $00 ; entry 20
    db $E0, $E0, $0E, $00 ; entry 21
    db $E0, $E8, $0F, $00 ; entry 22
    db $E8, $D0, $13, $00 ; entry 23
    db $F8, $C0, $1C, $00 ; entry 24
    db $F8, $D8, $1D, $00 ; entry 25
    db $F0, $B8, $17, $00 ; entry 26
    db $F0, $D0, $19, $00 ; entry 27
    db $F0, $C0, $18, $00 ; entry 28
    db $F0, $B0, $16, $00 ; entry 29
    db $F8, $B0, $1A, $00 ; entry 30
    db $F0, $C8, $18, $00 ; entry 31
    db $F0, $D8, $18, $00 ; entry 32
    db $F8, $D0, $1C, $00 ; entry 33
    db $F8, $C8, $18, $00 ; entry 34
    db $F8, $B8, $1B, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame3::
Data_03B_5453:: ; address name
    db $E8, $D0, $14, $00 ; entry 0
    db $D0, $D8, $00, $00 ; entry 1
    db $D0, $E0, $01, $00 ; entry 2
    db $D0, $E8, $02, $00 ; entry 3
    db $E0, $F8, $10, $00 ; entry 4
    db $E8, $E8, $15, $00 ; entry 5
    db $E8, $E0, $14, $00 ; entry 6
    db $D8, $C8, $03, $00 ; entry 7
    db $D8, $D0, $04, $00 ; entry 8
    db $D8, $D8, $05, $00 ; entry 9
    db $D8, $E0, $06, $00 ; entry 10
    db $D8, $E8, $07, $00 ; entry 11
    db $D8, $F0, $08, $00 ; entry 12
    db $E8, $C0, $11, $00 ; entry 13
    db $E8, $C8, $12, $00 ; entry 14
    db $F8, $E8, $15, $40 ; entry 15
    db $E0, $C0, $09, $00 ; entry 16
    db $E0, $C8, $0A, $00 ; entry 17
    db $E0, $D0, $0B, $00 ; entry 18
    db $E0, $D8, $0C, $00 ; entry 19
    db $E0, $E0, $0D, $00 ; entry 20
    db $E0, $E8, $0E, $00 ; entry 21
    db $E0, $F0, $0F, $00 ; entry 22
    db $E8, $D8, $13, $00 ; entry 23
    db $F8, $C0, $1B, $00 ; entry 24
    db $F8, $C8, $1C, $00 ; entry 25
    db $F8, $E0, $1D, $00 ; entry 26
    db $F0, $C0, $17, $00 ; entry 27
    db $F0, $D8, $19, $00 ; entry 28
    db $F0, $C8, $18, $00 ; entry 29
    db $F0, $B8, $16, $00 ; entry 30
    db $F8, $B0, $16, $00 ; entry 31
    db $F8, $B8, $1A, $00 ; entry 32
    db $F0, $D0, $18, $00 ; entry 33
    db $F0, $E0, $18, $00 ; entry 34
    db $F8, $D8, $1C, $00 ; entry 35
    db $F8, $D0, $18, $00 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame4::
Data_03B_54E8:: ; address name
    db $E8, $E0, $14, $00 ; entry 0
    db $D0, $E8, $00, $00 ; entry 1
    db $D0, $F0, $01, $00 ; entry 2
    db $D0, $F8, $02, $00 ; entry 3
    db $E0, $08, $10, $00 ; entry 4
    db $E8, $F8, $15, $00 ; entry 5
    db $E8, $F0, $14, $00 ; entry 6
    db $D8, $D8, $03, $00 ; entry 7
    db $D8, $E0, $04, $00 ; entry 8
    db $D8, $E8, $05, $00 ; entry 9
    db $D8, $F0, $06, $00 ; entry 10
    db $D8, $F8, $07, $00 ; entry 11
    db $D8, $00, $08, $00 ; entry 12
    db $E8, $D0, $11, $00 ; entry 13
    db $E8, $D8, $12, $00 ; entry 14
    db $F8, $F8, $15, $40 ; entry 15
    db $E0, $D0, $09, $00 ; entry 16
    db $E0, $D8, $0A, $00 ; entry 17
    db $E0, $E0, $0B, $00 ; entry 18
    db $E0, $E8, $0C, $00 ; entry 19
    db $E0, $F0, $0D, $00 ; entry 20
    db $E0, $F8, $0E, $00 ; entry 21
    db $E0, $00, $0F, $00 ; entry 22
    db $E8, $E8, $13, $00 ; entry 23
    db $F8, $D0, $1B, $00 ; entry 24
    db $F8, $D8, $1C, $00 ; entry 25
    db $F8, $F0, $1D, $00 ; entry 26
    db $F0, $D0, $17, $00 ; entry 27
    db $F0, $E8, $19, $00 ; entry 28
    db $F0, $C8, $16, $00 ; entry 29
    db $F8, $C8, $1A, $00 ; entry 30
    db $F0, $E0, $18, $00 ; entry 31
    db $F0, $F0, $18, $00 ; entry 32
    db $F8, $E8, $1C, $00 ; entry 33
    db $F8, $B0, $20, $00 ; entry 34
    db $F8, $B8, $21, $00 ; entry 35
    db $F8, $C0, $1F, $00 ; entry 36
    db $F0, $D8, $19, $00 ; entry 37
    db $F8, $E0, $14, $40 ; entry 38
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame5::
Data_03B_5585:: ; address name
    db $F0, $E8, $14, $00 ; entry 0
    db $D8, $F0, $00, $00 ; entry 1
    db $D8, $F8, $01, $00 ; entry 2
    db $D8, $00, $02, $00 ; entry 3
    db $E8, $10, $10, $00 ; entry 4
    db $F0, $00, $15, $00 ; entry 5
    db $F0, $F8, $14, $00 ; entry 6
    db $E0, $E0, $03, $00 ; entry 7
    db $E0, $E8, $04, $00 ; entry 8
    db $E0, $F0, $05, $00 ; entry 9
    db $E0, $F8, $06, $00 ; entry 10
    db $E0, $00, $07, $00 ; entry 11
    db $E0, $08, $08, $00 ; entry 12
    db $F0, $E0, $12, $00 ; entry 13
    db $E8, $D8, $09, $00 ; entry 14
    db $E8, $E0, $0A, $00 ; entry 15
    db $E8, $E8, $0B, $00 ; entry 16
    db $E8, $F0, $0C, $00 ; entry 17
    db $E8, $F8, $0D, $00 ; entry 18
    db $E8, $00, $0E, $00 ; entry 19
    db $E8, $08, $0F, $00 ; entry 20
    db $F0, $F0, $13, $00 ; entry 21
    db $F8, $C0, $20, $00 ; entry 22
    db $F8, $C8, $21, $00 ; entry 23
    db $F8, $F8, $1D, $00 ; entry 24
    db $F8, $F0, $1C, $00 ; entry 25
    db $F8, $B0, $20, $20 ; entry 26
    db $F8, $00, $15, $40 ; entry 27
    db $F8, $E0, $12, $40 ; entry 28
    db $F8, $D8, $0E, $00 ; entry 29
    db $F8, $E8, $14, $40 ; entry 30
    db $F8, $D0, $23, $20 ; entry 31
    db $F0, $D8, $11, $00 ; entry 32
    db $F0, $D4, $16, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame6::
Data_03B_560E:: ; address name
    db $F8, $F8, $14, $00 ; entry 0
    db $E8, $F0, $03, $00 ; entry 1
    db $E8, $F8, $04, $00 ; entry 2
    db $E8, $00, $05, $00 ; entry 3
    db $F0, $00, $0C, $00 ; entry 4
    db $F0, $F8, $0C, $00 ; entry 5
    db $E8, $20, $27, $00 ; entry 6
    db $F8, $18, $2A, $00 ; entry 7
    db $E0, $18, $27, $00 ; entry 8
    db $E8, $18, $29, $00 ; entry 9
    db $F0, $18, $07, $00 ; entry 10
    db $F0, $08, $06, $00 ; entry 11
    db $F0, $10, $07, $00 ; entry 12
    db $F8, $00, $0B, $00 ; entry 13
    db $F8, $08, $0C, $00 ; entry 14
    db $F8, $10, $0E, $00 ; entry 15
    db $E8, $10, $28, $00 ; entry 16
    db $E8, $08, $07, $00 ; entry 17
    db $E0, $08, $27, $00 ; entry 18
    db $F0, $E8, $21, $00 ; entry 19
    db $F0, $F0, $22, $00 ; entry 20
    db $F0, $E0, $20, $00 ; entry 21
    db $F8, $D8, $22, $00 ; entry 22
    db $F8, $E8, $25, $00 ; entry 23
    db $F8, $E0, $24, $00 ; entry 24
    db $F0, $20, $29, $00 ; entry 25
    db $F8, $20, $2B, $00 ; entry 26
    db $F8, $F0, $2C, $00 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame7::
Data_03B_567F:: ; address name
    db $E8, $18, $00, $00 ; entry 0
    db $E8, $20, $01, $00 ; entry 1
    db $E8, $28, $02, $00 ; entry 2
    db $F0, $08, $03, $00 ; entry 3
    db $F0, $10, $04, $00 ; entry 4
    db $F0, $18, $05, $00 ; entry 5
    db $F8, $18, $0C, $00 ; entry 6
    db $F0, $20, $0E, $00 ; entry 7
    db $F0, $28, $0F, $00 ; entry 8
    db $F8, $20, $06, $00 ; entry 9
    db $F8, $28, $07, $00 ; entry 10
    db $F8, $10, $0C, $00 ; entry 11
    db $F8, $F0, $20, $00 ; entry 12
    db $F8, $F8, $21, $00 ; entry 13
    db $F8, $00, $22, $00 ; entry 14
    db $F8, $08, $24, $00 ; entry 15
    db $F0, $30, $10, $00 ; entry 16
    db $F8, $30, $10, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame8::
Data_03B_56C8:: ; address name
    db $E8, $40, $27, $00 ; entry 0
    db $F8, $38, $2A, $00 ; entry 1
    db $F8, $40, $2B, $00 ; entry 2
    db $F0, $38, $28, $00 ; entry 3
    db $F0, $40, $29, $00 ; entry 4
    db $F0, $28, $00, $00 ; entry 5
    db $F0, $30, $04, $00 ; entry 6
    db $F8, $28, $0C, $00 ; entry 7
    db $F8, $30, $0D, $00 ; entry 8
    db $F8, $10, $20, $00 ; entry 9
    db $F8, $18, $21, $00 ; entry 10
    db $F8, $20, $22, $00 ; entry 11
    db $F8, $08, $20, $20 ; entry 12
    db $F8, $00, $21, $20 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame9::
Data_03B_5701:: ; address name
    db $F8, $00, $23, $20 ; entry 0
    db $F0, $08, $20, $00 ; entry 1
    db $F0, $10, $21, $00 ; entry 2
    db $F0, $28, $21, $20 ; entry 3
    db $F0, $20, $22, $20 ; entry 4
    db $F0, $18, $23, $20 ; entry 5
    db $F8, $28, $25, $20 ; entry 6
    db $F8, $20, $26, $20 ; entry 7
    db $F8, $08, $24, $00 ; entry 8
    db $F8, $10, $25, $00 ; entry 9
    db $F8, $18, $2C, $00 ; entry 10
    db $F0, $30, $20, $20 ; entry 11
    db $F8, $30, $24, $20 ; entry 12
    db $F8, $38, $23, $00 ; entry 13
    db $F8, $48, $20, $20 ; entry 14
    db $F8, $40, $21, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame10::
Data_03B_5742:: ; address name
    db $F8, $08, $20, $00 ; entry 0
    db $F8, $10, $21, $00 ; entry 1
    db $F8, $18, $23, $20 ; entry 2
    db $F0, $20, $20, $00 ; entry 3
    db $F0, $28, $21, $00 ; entry 4
    db $F0, $40, $21, $20 ; entry 5
    db $F0, $38, $22, $20 ; entry 6
    db $F0, $30, $23, $20 ; entry 7
    db $F0, $48, $20, $20 ; entry 8
    db $F8, $48, $24, $20 ; entry 9
    db $F8, $40, $25, $20 ; entry 10
    db $F8, $20, $24, $00 ; entry 11
    db $F8, $28, $25, $00 ; entry 12
    db $F8, $30, $26, $00 ; entry 13
    db $F8, $00, $20, $20 ; entry 14
    db $F8, $38, $2C, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame11::
Data_03B_5783:: ; address name
    db $F8, $20, $20, $00 ; entry 0
    db $F8, $28, $21, $00 ; entry 1
    db $F8, $30, $23, $20 ; entry 2
    db $F0, $38, $20, $00 ; entry 3
    db $F0, $40, $21, $00 ; entry 4
    db $F0, $48, $23, $20 ; entry 5
    db $F8, $38, $24, $00 ; entry 6
    db $F8, $40, $25, $00 ; entry 7
    db $F8, $48, $26, $00 ; entry 8
    db $F8, $18, $20, $20 ; entry 9
    db $F8, $10, $21, $20 ; entry 10
    db $F8, $08, $23, $00 ; entry 11
    db $F8, $00, $22, $00 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame12::
Data_03B_57B8:: ; address name
    db $F8, $08, $20, $00 ; entry 0
    db $F8, $10, $21, $00 ; entry 1
    db $F8, $38, $20, $00 ; entry 2
    db $F8, $40, $21, $00 ; entry 3
    db $F8, $48, $23, $20 ; entry 4
    db $F8, $00, $20, $20 ; entry 5
    db $F8, $30, $20, $20 ; entry 6
    db $F8, $28, $21, $20 ; entry 7
    db $F8, $20, $23, $00 ; entry 8
    db $F8, $18, $22, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame13::
Data_03B_57E1:: ; address name
    db $F8, $20, $20, $00 ; entry 0
    db $F8, $28, $21, $00 ; entry 1
    db $F8, $18, $20, $20 ; entry 2
    db $F8, $10, $21, $20 ; entry 3
    db $F8, $48, $20, $20 ; entry 4
    db $F8, $40, $21, $20 ; entry 5
    db $F8, $38, $23, $00 ; entry 6
    db $F8, $30, $22, $00 ; entry 7
    db $F8, $08, $23, $00 ; entry 8
    db $F8, $00, $25, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame14::
Data_03B_580A:: ; address name
    db $F0, $28, $20, $00 ; entry 0
    db $F0, $30, $21, $00 ; entry 1
    db $F0, $38, $23, $20 ; entry 2
    db $F8, $28, $24, $00 ; entry 3
    db $F8, $30, $25, $00 ; entry 4
    db $F8, $10, $20, $00 ; entry 5
    db $F8, $18, $21, $00 ; entry 6
    db $F8, $20, $23, $20 ; entry 7
    db $F8, $08, $20, $20 ; entry 8
    db $F8, $00, $21, $20 ; entry 9
    db $F0, $48, $21, $20 ; entry 10
    db $F0, $40, $22, $20 ; entry 11
    db $F8, $48, $25, $20 ; entry 12
    db $F8, $40, $26, $20 ; entry 13
    db $F8, $38, $2C, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame15::
Data_03B_5847:: ; address name
    db $F8, $F8, $21, $00 ; entry 0
    db $F8, $00, $22, $00 ; entry 1
    db $F8, $20, $20, $20 ; entry 2
    db $F8, $18, $21, $20 ; entry 3
    db $F8, $10, $23, $00 ; entry 4
    db $F8, $30, $20, $00 ; entry 5
    db $F8, $38, $21, $00 ; entry 6
    db $F8, $40, $23, $20 ; entry 7
    db $F8, $48, $22, $20 ; entry 8
    db $F8, $08, $2C, $20 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame16::
Data_03B_5870:: ; address name
    db $F8, $00, $20, $20 ; entry 0
    db $F8, $F8, $21, $20 ; entry 1
    db $F8, $F0, $22, $20 ; entry 2
    db $F8, $D0, $20, $00 ; entry 3
    db $F8, $D8, $21, $00 ; entry 4
    db $F8, $E0, $23, $20 ; entry 5
    db $F8, $30, $20, $00 ; entry 6
    db $F8, $38, $20, $20 ; entry 7
    db $F8, $E8, $2C, $40 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame17::
Data_03B_5895:: ; address name
    db $F8, $40, $20, $00 ; entry 0
    db $F8, $48, $20, $20 ; entry 1
    db $F8, $00, $20, $00 ; entry 2
    db $F8, $08, $20, $20 ; entry 3
    db $F8, $D8, $20, $00 ; entry 4
    db $F8, $E0, $20, $20 ; entry 5
    db $F8, $C8, $20, $00 ; entry 6
    db $F8, $D0, $20, $20 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame18::
Data_03B_58B6:: ; address name
    db $F8, $D0, $21, $00 ; entry 0
    db $F8, $C8, $21, $20 ; entry 1
    db $F8, $C0, $22, $20 ; entry 2
    db $F0, $B8, $20, $20 ; entry 3
    db $F0, $B0, $21, $20 ; entry 4
    db $F8, $B8, $24, $20 ; entry 5
    db $F8, $B0, $25, $20 ; entry 6
    db $F0, $25, $27, $20 ; entry 7
    db $F8, $25, $29, $20 ; entry 8
    db $F8, $2D, $08, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame19::
Data_03B_58DF:: ; address name
    db $F8, $E8, $20, $20 ; entry 0
    db $F8, $E0, $21, $20 ; entry 1
    db $F8, $D8, $22, $20 ; entry 2
    db $F0, $D0, $20, $20 ; entry 3
    db $F0, $C8, $21, $20 ; entry 4
    db $F0, $B0, $21, $00 ; entry 5
    db $F0, $B8, $22, $00 ; entry 6
    db $F0, $C0, $23, $00 ; entry 7
    db $F8, $B0, $24, $00 ; entry 8
    db $F8, $B8, $25, $00 ; entry 9
    db $F8, $C8, $26, $00 ; entry 10
    db $F8, $D0, $24, $00 ; entry 11
    db $F8, $34, $29, $20 ; entry 12
    db $F0, $34, $27, $20 ; entry 13
    db $F8, $3C, $08, $00 ; entry 14
    db $F8, $C0, $2C, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame20::
Data_03B_5920:: ; address name
    db $F8, $C0, $22, $00 ; entry 0
    db $F0, $C8, $20, $00 ; entry 1
    db $F0, $D0, $21, $00 ; entry 2
    db $F0, $E8, $21, $20 ; entry 3
    db $F0, $E0, $22, $20 ; entry 4
    db $F0, $D8, $23, $20 ; entry 5
    db $F8, $E8, $24, $20 ; entry 6
    db $F8, $E0, $25, $20 ; entry 7
    db $F8, $D0, $26, $20 ; entry 8
    db $F8, $C8, $24, $20 ; entry 9
    db $F0, $F0, $20, $20 ; entry 10
    db $F8, $F8, $22, $20 ; entry 11
    db $F8, $F0, $24, $00 ; entry 12
    db $F8, $D8, $2C, $00 ; entry 13
    db $F8, $B0, $20, $00 ; entry 14
    db $F8, $B8, $21, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame21::
Data_03B_5961:: ; address name
    db $F8, $C0, $20, $00 ; entry 0
    db $F8, $C8, $21, $00 ; entry 1
    db $F8, $B8, $20, $20 ; entry 2
    db $F8, $B0, $21, $20 ; entry 3
    db $F8, $F0, $20, $00 ; entry 4
    db $F8, $F8, $21, $00 ; entry 5
    db $F8, $E0, $21, $20 ; entry 6
    db $F8, $D8, $22, $20 ; entry 7
    db $F8, $D0, $23, $20 ; entry 8
    db $F8, $E8, $20, $20 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame22::
Data_03B_598A:: ; address name
    db $F8, $D8, $20, $00 ; entry 0
    db $F8, $E0, $21, $00 ; entry 1
    db $F8, $D0, $20, $20 ; entry 2
    db $F8, $C8, $21, $20 ; entry 3
    db $F8, $F8, $21, $20 ; entry 4
    db $F8, $F0, $23, $00 ; entry 5
    db $F8, $E8, $22, $00 ; entry 6
    db $F8, $C0, $23, $00 ; entry 7
    db $F8, $B0, $24, $00 ; entry 8
    db $F8, $B8, $25, $00 ; entry 9
    db $F0, $B0, $21, $20 ; entry 10
    db $F0, $B8, $20, $20 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 23 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame23::
Data_03B_59BB:: ; address name
    db $F8, $F0, $20, $00 ; entry 0
    db $F8, $F8, $21, $00 ; entry 1
    db $F8, $E8, $20, $20 ; entry 2
    db $F8, $E0, $21, $20 ; entry 3
    db $F8, $D8, $23, $00 ; entry 4
    db $F8, $C8, $24, $00 ; entry 5
    db $F8, $D0, $25, $00 ; entry 6
    db $F0, $C0, $21, $20 ; entry 7
    db $F0, $B8, $22, $20 ; entry 8
    db $F0, $C8, $20, $20 ; entry 9
    db $F8, $C0, $25, $20 ; entry 10
    db $F8, $B8, $26, $20 ; entry 11
    db $F0, $B0, $18, $00 ; entry 12
    db $F8, $B0, $2C, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 24 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame24::
Data_03B_59F4:: ; address name
    db $F8, $F8, $21, $20 ; entry 0
    db $F8, $F0, $23, $00 ; entry 1
    db $F8, $E0, $24, $00 ; entry 2
    db $F8, $E8, $25, $00 ; entry 3
    db $F0, $D8, $21, $20 ; entry 4
    db $F0, $D0, $22, $20 ; entry 5
    db $F0, $E0, $20, $20 ; entry 6
    db $F8, $D8, $25, $20 ; entry 7
    db $F8, $D0, $26, $20 ; entry 8
    db $F0, $C8, $18, $00 ; entry 9
    db $F0, $B0, $20, $00 ; entry 10
    db $F0, $B8, $21, $00 ; entry 11
    db $F0, $C0, $23, $20 ; entry 12
    db $F8, $B0, $24, $00 ; entry 13
    db $F8, $B8, $25, $00 ; entry 14
    db $F8, $C0, $26, $00 ; entry 15
    db $F8, $C8, $2C, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 25 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame25::
Data_03B_5A39:: ; address name
    db $F8, $F8, $24, $00 ; entry 0
    db $F0, $F0, $21, $20 ; entry 1
    db $F0, $E8, $22, $20 ; entry 2
    db $F0, $F8, $20, $20 ; entry 3
    db $F8, $F0, $25, $20 ; entry 4
    db $F0, $C8, $20, $00 ; entry 5
    db $F0, $D0, $21, $00 ; entry 6
    db $F0, $D8, $23, $20 ; entry 7
    db $F8, $C8, $24, $00 ; entry 8
    db $F8, $D0, $25, $00 ; entry 9
    db $F8, $D8, $26, $00 ; entry 10
    db $F8, $B0, $20, $00 ; entry 11
    db $F8, $B8, $21, $00 ; entry 12
    db $F8, $C0, $23, $20 ; entry 13
    db $F8, $E8, $2C, $00 ; entry 14
    db $F8, $E0, $2C, $60 ; entry 15
    db $F0, $E0, $2C, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 26 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame26::
Data_03B_5A7E:: ; address name
    db $F8, $D8, $20, $00 ; entry 0
    db $F8, $E0, $21, $00 ; entry 1
    db $F8, $D0, $20, $20 ; entry 2
    db $F8, $C8, $21, $20 ; entry 3
    db $F8, $E8, $22, $00 ; entry 4
    db $F8, $C0, $23, $00 ; entry 5
    db $F8, $B0, $24, $00 ; entry 6
    db $F8, $B8, $25, $00 ; entry 7
    db $F0, $B0, $20, $20 ; entry 8
    db $F8, $F8, $23, $00 ; entry 9
    db $F8, $F0, $26, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 27 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame27::
Data_03B_5AAB:: ; address name
    db $F8, $F0, $20, $00 ; entry 0
    db $F8, $E8, $20, $20 ; entry 1
    db $F8, $E0, $21, $20 ; entry 2
    db $F8, $D8, $23, $00 ; entry 3
    db $F8, $C8, $24, $00 ; entry 4
    db $F8, $D0, $25, $00 ; entry 5
    db $F0, $C8, $20, $20 ; entry 6
    db $F0, $B0, $23, $20 ; entry 7
    db $F0, $C0, $21, $20 ; entry 8
    db $F0, $B8, $22, $20 ; entry 9
    db $F8, $C0, $25, $20 ; entry 10
    db $F8, $B0, $2C, $20 ; entry 11
    db $F8, $B8, $26, $00 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 28 of MetaSprites3B_507CSet2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2EFrame28::
    db $80 ; end

; E-0147 (derived: meta-sprite set 47 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3B_507CSet2F::
Data_03B_5AE1:: ; address name
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

; E-0147 (derived: frame 0 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame0::
Data_03B_5B21:: ; address name
    db $D8, $03, $20, $00 ; entry 0
    db $D8, $0B, $21, $00 ; entry 1
    db $D0, $03, $22, $00 ; entry 2
    db $D0, $0B, $23, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame1::
Data_03B_5B32:: ; address name
    db $DC, $00, $20, $00 ; entry 0
    db $DC, $08, $21, $00 ; entry 1
    db $E4, $F8, $20, $60 ; entry 2
    db $E4, $F0, $21, $60 ; entry 3
    db $D4, $00, $22, $00 ; entry 4
    db $D4, $08, $23, $00 ; entry 5
    db $EC, $F8, $22, $60 ; entry 6
    db $EC, $F0, $23, $60 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame2::
Data_03B_5B53:: ; address name
    db $F8, $F0, $24, $00 ; entry 0
    db $E8, $F4, $27, $00 ; entry 1
    db $E8, $FC, $28, $00 ; entry 2
    db $F0, $F0, $25, $00 ; entry 3
    db $F0, $F8, $26, $00 ; entry 4
    db $D8, $03, $2B, $00 ; entry 5
    db $E0, $F8, $29, $00 ; entry 6
    db $E0, $00, $2A, $00 ; entry 7
    db $D0, $08, $2B, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame3::
Data_03B_5B78:: ; address name
    db $F8, $EB, $27, $00 ; entry 0
    db $F8, $F3, $28, $00 ; entry 1
    db $E8, $FA, $2B, $00 ; entry 2
    db $F0, $EF, $29, $00 ; entry 3
    db $F0, $F7, $2A, $00 ; entry 4
    db $E0, $FE, $2C, $00 ; entry 5
    db $D0, $08, $2C, $00 ; entry 6
    db $D8, $03, $2C, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame4::
Data_03B_5B99:: ; address name
    db $F0, $F4, $2D, $00 ; entry 0
    db $F8, $EF, $2D, $00 ; entry 1
    db $E8, $F9, $2C, $00 ; entry 2
    db $DC, $01, $2C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame5::
Data_03B_5BAA:: ; address name
    db $F0, $F4, $2D, $00 ; entry 0
    db $E8, $F9, $2D, $00 ; entry 1
    db $E0, $FE, $2D, $00 ; entry 2
    db $F8, $EF, $2B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame6::
Data_03B_5BBB:: ; address name
    db $F8, $EF, $2D, $00 ; entry 0
    db $F0, $F4, $2D, $00 ; entry 1
    db $E8, $F9, $2D, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame7::
Data_03B_5BC8:: ; address name
    db $F8, $F8, $00, $00 ; entry 0
    db $F8, $00, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame8::
Data_03B_5BD1:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $03, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame9::
Data_03B_5BE2:: ; address name
    db $E8, $F8, $02, $00 ; entry 0
    db $E8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $F8, $F8, $06, $00 ; entry 4
    db $F8, $00, $07, $00 ; entry 5
    db $F8, $F0, $00, $00 ; entry 6
    db $F8, $08, $01, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame10::
Data_03B_5C03:: ; address name
    db $D8, $F0, $08, $00 ; entry 0
    db $D8, $F8, $09, $00 ; entry 1
    db $D8, $08, $08, $20 ; entry 2
    db $D8, $00, $09, $20 ; entry 3
    db $E0, $F0, $0A, $00 ; entry 4
    db $E0, $F8, $0B, $00 ; entry 5
    db $E0, $08, $0A, $20 ; entry 6
    db $E0, $00, $0B, $20 ; entry 7
    db $E8, $F0, $0C, $00 ; entry 8
    db $E8, $F8, $0D, $00 ; entry 9
    db $E8, $08, $0C, $20 ; entry 10
    db $E8, $00, $0D, $20 ; entry 11
    db $F0, $F8, $0E, $00 ; entry 12
    db $F0, $00, $0F, $00 ; entry 13
    db $F8, $F8, $10, $00 ; entry 14
    db $F8, $00, $11, $00 ; entry 15
    db $F0, $F0, $02, $00 ; entry 16
    db $F0, $08, $03, $00 ; entry 17
    db $F8, $08, $05, $00 ; entry 18
    db $F8, $F0, $04, $00 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame11::
Data_03B_5C54:: ; address name
    db $E0, $F0, $12, $00 ; entry 0
    db $E0, $F8, $13, $00 ; entry 1
    db $E0, $08, $12, $20 ; entry 2
    db $E0, $00, $13, $20 ; entry 3
    db $E8, $F0, $0E, $40 ; entry 4
    db $E8, $08, $0F, $40 ; entry 5
    db $F0, $F0, $0E, $00 ; entry 6
    db $F0, $08, $0F, $00 ; entry 7
    db $F8, $F0, $10, $00 ; entry 8
    db $F8, $08, $11, $00 ; entry 9
    db $E8, $F8, $14, $00 ; entry 10
    db $E8, $00, $15, $00 ; entry 11
    db $F0, $F8, $16, $00 ; entry 12
    db $F0, $00, $17, $00 ; entry 13
    db $D0, $F0, $18, $00 ; entry 14
    db $D0, $F8, $19, $00 ; entry 15
    db $D0, $08, $18, $20 ; entry 16
    db $D0, $00, $19, $20 ; entry 17
    db $D8, $F0, $1A, $00 ; entry 18
    db $D8, $F8, $1B, $00 ; entry 19
    db $D8, $08, $1A, $20 ; entry 20
    db $D8, $00, $1B, $20 ; entry 21
    db $F8, $F8, $16, $00 ; entry 22
    db $F8, $00, $17, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame12::
Data_03B_5CB5:: ; address name
    db $D0, $00, $04, $20 ; entry 0
    db $D0, $F8, $05, $20 ; entry 1
    db $E8, $F8, $1C, $40 ; entry 2
    db $E8, $00, $1C, $60 ; entry 3
    db $F8, $F8, $1C, $00 ; entry 4
    db $F8, $00, $1C, $20 ; entry 5
    db $E0, $F0, $1A, $00 ; entry 6
    db $E0, $F8, $1B, $00 ; entry 7
    db $E0, $08, $1A, $20 ; entry 8
    db $E0, $00, $1B, $20 ; entry 9
    db $F0, $F0, $1E, $00 ; entry 10
    db $F0, $F8, $1F, $00 ; entry 11
    db $F0, $08, $1E, $20 ; entry 12
    db $F0, $00, $1F, $20 ; entry 13
    db $D8, $08, $18, $20 ; entry 14
    db $D8, $00, $19, $20 ; entry 15
    db $D8, $F0, $18, $00 ; entry 16
    db $D8, $F8, $19, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame13::
Data_03B_5CFE:: ; address name
    db $F0, $08, $18, $20 ; entry 0
    db $F0, $00, $19, $20 ; entry 1
    db $F0, $F0, $18, $00 ; entry 2
    db $F0, $F8, $19, $00 ; entry 3
    db $E0, $F8, $1C, $00 ; entry 4
    db $E0, $00, $1C, $20 ; entry 5
    db $E8, $F8, $1D, $20 ; entry 6
    db $E8, $00, $1D, $00 ; entry 7
    db $D0, $F8, $1D, $60 ; entry 8
    db $D0, $00, $1D, $40 ; entry 9
    db $D8, $F0, $1E, $00 ; entry 10
    db $D8, $F8, $1F, $00 ; entry 11
    db $D8, $08, $1E, $20 ; entry 12
    db $D8, $00, $1F, $20 ; entry 13
    db $F8, $F0, $1A, $00 ; entry 14
    db $F8, $F8, $1B, $00 ; entry 15
    db $F8, $08, $1A, $20 ; entry 16
    db $F8, $00, $1B, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame14::
Data_03B_5D47:: ; address name
    db $E0, $08, $18, $20 ; entry 0
    db $E0, $00, $19, $20 ; entry 1
    db $E0, $F0, $18, $00 ; entry 2
    db $E0, $F8, $19, $00 ; entry 3
    db $F0, $F8, $1C, $00 ; entry 4
    db $D8, $00, $1D, $40 ; entry 5
    db $F0, $00, $1C, $20 ; entry 6
    db $D8, $F8, $1D, $60 ; entry 7
    db $D0, $F0, $1E, $00 ; entry 8
    db $D0, $F8, $1F, $00 ; entry 9
    db $D0, $08, $1E, $20 ; entry 10
    db $D0, $00, $1F, $20 ; entry 11
    db $F8, $F0, $1E, $00 ; entry 12
    db $F8, $F8, $1F, $00 ; entry 13
    db $F8, $08, $1E, $20 ; entry 14
    db $F8, $00, $1F, $20 ; entry 15
    db $E8, $F0, $1A, $00 ; entry 16
    db $E8, $F8, $1B, $00 ; entry 17
    db $E8, $08, $1A, $20 ; entry 18
    db $E8, $00, $1B, $20 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame15::
Data_03B_5D98:: ; address name
    db $E8, $F8, $1C, $00 ; entry 0
    db $E8, $00, $1C, $20 ; entry 1
    db $D0, $08, $18, $20 ; entry 2
    db $D0, $00, $19, $20 ; entry 3
    db $D0, $F0, $18, $00 ; entry 4
    db $D0, $F8, $19, $00 ; entry 5
    db $F8, $F8, $1D, $20 ; entry 6
    db $F8, $00, $1D, $00 ; entry 7
    db $F0, $F0, $1E, $00 ; entry 8
    db $F0, $F8, $1F, $00 ; entry 9
    db $F0, $08, $1E, $20 ; entry 10
    db $F0, $00, $1F, $20 ; entry 11
    db $E0, $F0, $1E, $00 ; entry 12
    db $E0, $F8, $1F, $00 ; entry 13
    db $E0, $08, $1E, $20 ; entry 14
    db $E0, $00, $1F, $20 ; entry 15
    db $D8, $F0, $1A, $00 ; entry 16
    db $D8, $F8, $1B, $00 ; entry 17
    db $D8, $08, $1A, $20 ; entry 18
    db $D8, $00, $1B, $20 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame16::
Data_03B_5DE9:: ; address name
    db $D0, $04, $2E, $20 ; entry 0
    db $F8, $04, $2E, $20 ; entry 1
    db $F0, $04, $2E, $20 ; entry 2
    db $E8, $04, $2E, $20 ; entry 3
    db $E0, $04, $2E, $20 ; entry 4
    db $D8, $04, $2E, $20 ; entry 5
    db $D0, $F4, $2E, $00 ; entry 6
    db $D8, $F4, $2E, $00 ; entry 7
    db $E0, $F4, $2E, $00 ; entry 8
    db $E8, $F4, $2E, $00 ; entry 9
    db $F0, $F4, $2E, $00 ; entry 10
    db $F8, $F4, $2E, $00 ; entry 11
    db $D0, $FC, $2F, $00 ; entry 12
    db $D8, $FC, $2F, $00 ; entry 13
    db $E0, $FC, $2F, $00 ; entry 14
    db $E8, $FC, $2F, $00 ; entry 15
    db $F0, $FC, $2F, $00 ; entry 16
    db $F8, $FC, $2F, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame17::
Data_03B_5E32:: ; address name
    db $D0, $F4, $2E, $20 ; entry 0
    db $F8, $F4, $2E, $20 ; entry 1
    db $F0, $F4, $2E, $20 ; entry 2
    db $E8, $F4, $2E, $20 ; entry 3
    db $E0, $F4, $2E, $20 ; entry 4
    db $D8, $F4, $2E, $20 ; entry 5
    db $D0, $04, $2E, $00 ; entry 6
    db $D8, $04, $2E, $00 ; entry 7
    db $E0, $04, $2E, $00 ; entry 8
    db $E8, $04, $2E, $00 ; entry 9
    db $F0, $04, $2E, $00 ; entry 10
    db $F8, $04, $2E, $00 ; entry 11
    db $D0, $FC, $2F, $20 ; entry 12
    db $D8, $FC, $2F, $20 ; entry 13
    db $E0, $FC, $2F, $20 ; entry 14
    db $E8, $FC, $2F, $20 ; entry 15
    db $F0, $FC, $2F, $20 ; entry 16
    db $F8, $FC, $2F, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3B_507CSet2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet2FFrame18::
    db $80 ; end

; E-0147 (derived: meta-sprite set 48 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3B_507CSet30::
Data_03B_5E7C:: ; address name
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

; E-0147 (derived: frame 0 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame0::
Data_03B_5EBC:: ; address name
    db $F8, $F8, $00, $00 ; entry 0
    db $F8, $00, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame1::
Data_03B_5EC5:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $03, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame2::
Data_03B_5ED6:: ; address name
    db $F0, $00, $02, $20 ; entry 0
    db $F0, $F8, $03, $20 ; entry 1
    db $F8, $00, $04, $20 ; entry 2
    db $F8, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame3::
Data_03B_5EE7:: ; address name
    db $E8, $F8, $02, $00 ; entry 0
    db $E8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $F8, $F8, $06, $00 ; entry 4
    db $F8, $00, $07, $00 ; entry 5
    db $F8, $F0, $00, $00 ; entry 6
    db $F8, $08, $01, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame4::
Data_03B_5F08:: ; address name
    db $D8, $F0, $08, $00 ; entry 0
    db $D8, $F8, $09, $00 ; entry 1
    db $D8, $08, $08, $20 ; entry 2
    db $D8, $00, $09, $20 ; entry 3
    db $E0, $F0, $0A, $00 ; entry 4
    db $E0, $F8, $0B, $00 ; entry 5
    db $E0, $08, $0A, $20 ; entry 6
    db $E0, $00, $0B, $20 ; entry 7
    db $E8, $F0, $0C, $00 ; entry 8
    db $E8, $F8, $0D, $00 ; entry 9
    db $E8, $08, $0C, $20 ; entry 10
    db $E8, $00, $0D, $20 ; entry 11
    db $F0, $F8, $0E, $00 ; entry 12
    db $F0, $00, $0F, $00 ; entry 13
    db $F8, $F8, $10, $00 ; entry 14
    db $F8, $00, $11, $00 ; entry 15
    db $F0, $F0, $02, $00 ; entry 16
    db $F0, $08, $03, $00 ; entry 17
    db $F8, $08, $05, $00 ; entry 18
    db $F8, $F0, $04, $00 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame5::
Data_03B_5F59:: ; address name
    db $D0, $F0, $18, $00 ; entry 0
    db $D0, $08, $18, $20 ; entry 1
    db $D0, $F8, $1A, $00 ; entry 2
    db $D0, $00, $1B, $00 ; entry 3
    db $D8, $F0, $28, $00 ; entry 4
    db $D8, $F8, $29, $00 ; entry 5
    db $D8, $08, $28, $20 ; entry 6
    db $D8, $00, $2B, $00 ; entry 7
    db $E0, $F0, $12, $00 ; entry 8
    db $E0, $F8, $13, $00 ; entry 9
    db $E0, $08, $12, $20 ; entry 10
    db $E0, $00, $13, $20 ; entry 11
    db $E8, $F0, $0E, $40 ; entry 12
    db $E8, $08, $0F, $40 ; entry 13
    db $F0, $F0, $0E, $00 ; entry 14
    db $F0, $08, $0F, $00 ; entry 15
    db $F8, $F0, $10, $00 ; entry 16
    db $F8, $08, $11, $00 ; entry 17
    db $E8, $F8, $14, $00 ; entry 18
    db $E8, $00, $15, $00 ; entry 19
    db $F0, $F8, $16, $00 ; entry 20
    db $F0, $00, $17, $00 ; entry 21
    db $F8, $F8, $20, $00 ; entry 22
    db $F8, $00, $21, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame6::
Data_03B_5FBA:: ; address name
    db $D0, $00, $04, $20 ; entry 0
    db $D0, $F8, $05, $20 ; entry 1
    db $D8, $E8, $18, $00 ; entry 2
    db $D8, $F0, $19, $00 ; entry 3
    db $D8, $F8, $1A, $00 ; entry 4
    db $D8, $00, $1B, $00 ; entry 5
    db $E0, $E8, $28, $00 ; entry 6
    db $E0, $F0, $29, $00 ; entry 7
    db $E0, $F8, $2A, $00 ; entry 8
    db $E0, $00, $2B, $00 ; entry 9
    db $D8, $10, $18, $20 ; entry 10
    db $D8, $08, $19, $20 ; entry 11
    db $E0, $10, $28, $20 ; entry 12
    db $E0, $08, $29, $20 ; entry 13
    db $E8, $F0, $1C, $00 ; entry 14
    db $E8, $F8, $1D, $00 ; entry 15
    db $E8, $08, $1C, $20 ; entry 16
    db $E8, $00, $1D, $20 ; entry 17
    db $F8, $F0, $1C, $00 ; entry 18
    db $F8, $F8, $1D, $00 ; entry 19
    db $F8, $08, $1C, $20 ; entry 20
    db $F8, $00, $1D, $20 ; entry 21
    db $F0, $E8, $22, $00 ; entry 22
    db $F0, $F0, $23, $00 ; entry 23
    db $F0, $F8, $24, $00 ; entry 24
    db $F0, $10, $22, $20 ; entry 25
    db $F0, $08, $23, $20 ; entry 26
    db $F0, $00, $24, $20 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame7::
Data_03B_602B:: ; address name
    db $F8, $E8, $28, $00 ; entry 0
    db $F8, $10, $28, $20 ; entry 1
    db $F8, $08, $29, $20 ; entry 2
    db $F8, $F8, $2A, $00 ; entry 3
    db $F8, $00, $2B, $00 ; entry 4
    db $F8, $F0, $29, $00 ; entry 5
    db $F0, $10, $18, $20 ; entry 6
    db $F0, $08, $19, $20 ; entry 7
    db $F0, $F8, $1A, $00 ; entry 8
    db $F0, $00, $1B, $00 ; entry 9
    db $F0, $E8, $18, $00 ; entry 10
    db $F0, $F0, $19, $00 ; entry 11
    db $E8, $F0, $1E, $00 ; entry 12
    db $E8, $F8, $1F, $00 ; entry 13
    db $E8, $08, $1E, $20 ; entry 14
    db $E8, $00, $1F, $20 ; entry 15
    db $E0, $F0, $1C, $00 ; entry 16
    db $E0, $F8, $1D, $00 ; entry 17
    db $E0, $08, $1C, $20 ; entry 18
    db $E0, $00, $1D, $20 ; entry 19
    db $D8, $E8, $22, $00 ; entry 20
    db $D8, $F0, $23, $00 ; entry 21
    db $D8, $F8, $24, $00 ; entry 22
    db $D8, $10, $22, $20 ; entry 23
    db $D8, $08, $23, $20 ; entry 24
    db $D8, $00, $24, $20 ; entry 25
    db $D0, $F0, $1E, $00 ; entry 26
    db $D0, $F8, $1F, $00 ; entry 27
    db $D0, $08, $1E, $20 ; entry 28
    db $D0, $00, $1F, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame8::
Data_03B_60A4:: ; address name
    db $E8, $E8, $28, $00 ; entry 0
    db $E8, $10, $28, $20 ; entry 1
    db $E8, $08, $29, $20 ; entry 2
    db $E8, $F8, $2A, $00 ; entry 3
    db $E8, $00, $2B, $00 ; entry 4
    db $E8, $F0, $29, $00 ; entry 5
    db $E0, $10, $18, $20 ; entry 6
    db $E0, $08, $19, $20 ; entry 7
    db $E0, $F8, $1A, $00 ; entry 8
    db $E0, $00, $1B, $00 ; entry 9
    db $E0, $E8, $18, $00 ; entry 10
    db $E0, $F0, $19, $00 ; entry 11
    db $F0, $F0, $1E, $00 ; entry 12
    db $F0, $F8, $1F, $00 ; entry 13
    db $F0, $08, $1E, $20 ; entry 14
    db $F0, $00, $1F, $20 ; entry 15
    db $F8, $E8, $22, $00 ; entry 16
    db $F8, $F0, $23, $00 ; entry 17
    db $F8, $F8, $24, $00 ; entry 18
    db $F8, $10, $22, $20 ; entry 19
    db $F8, $08, $23, $20 ; entry 20
    db $F8, $00, $24, $20 ; entry 21
    db $D8, $F0, $1E, $00 ; entry 22
    db $D8, $F8, $1F, $00 ; entry 23
    db $D8, $08, $1E, $20 ; entry 24
    db $D8, $00, $1F, $20 ; entry 25
    db $D0, $E8, $22, $00 ; entry 26
    db $D0, $F0, $23, $00 ; entry 27
    db $D0, $F8, $24, $00 ; entry 28
    db $D0, $10, $22, $20 ; entry 29
    db $D0, $08, $23, $20 ; entry 30
    db $D0, $00, $24, $20 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame9::
Data_03B_6125:: ; address name
    db $F0, $E8, $22, $00 ; entry 0
    db $F0, $F0, $23, $00 ; entry 1
    db $F0, $F8, $24, $00 ; entry 2
    db $F0, $10, $22, $20 ; entry 3
    db $F0, $08, $23, $20 ; entry 4
    db $F0, $00, $24, $20 ; entry 5
    db $F8, $F0, $1E, $00 ; entry 6
    db $F8, $F8, $1F, $00 ; entry 7
    db $F8, $08, $1E, $20 ; entry 8
    db $F8, $00, $1F, $20 ; entry 9
    db $E0, $E8, $22, $00 ; entry 10
    db $E0, $F0, $23, $00 ; entry 11
    db $E0, $F8, $24, $00 ; entry 12
    db $E0, $10, $22, $20 ; entry 13
    db $E0, $08, $23, $20 ; entry 14
    db $E0, $00, $24, $20 ; entry 15
    db $E8, $F0, $1C, $00 ; entry 16
    db $E8, $F8, $1D, $00 ; entry 17
    db $E8, $08, $1C, $20 ; entry 18
    db $E8, $00, $1D, $20 ; entry 19
    db $D8, $E8, $28, $00 ; entry 20
    db $D8, $10, $28, $20 ; entry 21
    db $D8, $08, $29, $20 ; entry 22
    db $D8, $F8, $2A, $00 ; entry 23
    db $D8, $00, $2B, $00 ; entry 24
    db $D8, $F0, $29, $00 ; entry 25
    db $D0, $10, $18, $20 ; entry 26
    db $D0, $08, $19, $20 ; entry 27
    db $D0, $F8, $1A, $00 ; entry 28
    db $D0, $00, $1B, $00 ; entry 29
    db $D0, $E8, $18, $00 ; entry 30
    db $D0, $F0, $19, $00 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame10::
Data_03B_61A6:: ; address name
    db $D0, $F0, $25, $00 ; entry 0
    db $D0, $F8, $26, $00 ; entry 1
    db $D8, $F0, $27, $00 ; entry 2
    db $D8, $F8, $2C, $00 ; entry 3
    db $D0, $00, $25, $00 ; entry 4
    db $D0, $08, $26, $00 ; entry 5
    db $D8, $00, $27, $00 ; entry 6
    db $D8, $08, $2C, $00 ; entry 7
    db $E0, $F0, $25, $00 ; entry 8
    db $E0, $F8, $26, $00 ; entry 9
    db $E8, $F0, $27, $00 ; entry 10
    db $E8, $F8, $2C, $00 ; entry 11
    db $E0, $00, $25, $00 ; entry 12
    db $E0, $08, $26, $00 ; entry 13
    db $E8, $00, $27, $00 ; entry 14
    db $E8, $08, $2C, $00 ; entry 15
    db $F0, $00, $25, $00 ; entry 16
    db $F0, $08, $26, $00 ; entry 17
    db $F8, $00, $27, $00 ; entry 18
    db $F8, $08, $2C, $00 ; entry 19
    db $F0, $F0, $25, $00 ; entry 20
    db $F0, $F8, $26, $00 ; entry 21
    db $F8, $F0, $27, $00 ; entry 22
    db $F8, $F8, $2C, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3B_507CSet30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet30Frame11::
    db $80 ; end

; E-0147 (derived: meta-sprite set 49 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3B_507CSet31::
Data_03B_6208:: ; address name
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

; E-0147 (derived: frame 0 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame0::
Data_03B_6248:: ; address name
    db $D8, $10, $00, $00 ; entry 0
    db $D0, $10, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame1::
Data_03B_6251:: ; address name
    db $D8, $08, $00, $20 ; entry 0
    db $E0, $10, $00, $00 ; entry 1
    db $D0, $08, $01, $20 ; entry 2
    db $D8, $10, $01, $00 ; entry 3
    db $D0, $10, $02, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame2::
Data_03B_6266:: ; address name
    db $D8, $00, $00, $00 ; entry 0
    db $E0, $08, $00, $20 ; entry 1
    db $E8, $10, $00, $00 ; entry 2
    db $D0, $00, $01, $00 ; entry 3
    db $D8, $08, $01, $20 ; entry 4
    db $E0, $10, $01, $00 ; entry 5
    db $D0, $08, $02, $20 ; entry 6
    db $D8, $10, $02, $00 ; entry 7
    db $D0, $10, $03, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame3::
Data_03B_628B:: ; address name
    db $D8, $F8, $00, $20 ; entry 0
    db $E0, $00, $00, $00 ; entry 1
    db $E8, $08, $00, $20 ; entry 2
    db $F0, $10, $00, $00 ; entry 3
    db $D0, $F8, $01, $20 ; entry 4
    db $D8, $00, $01, $00 ; entry 5
    db $E0, $08, $01, $20 ; entry 6
    db $E8, $10, $01, $00 ; entry 7
    db $D0, $00, $02, $00 ; entry 8
    db $D8, $08, $02, $20 ; entry 9
    db $E0, $10, $02, $00 ; entry 10
    db $D0, $08, $03, $20 ; entry 11
    db $D8, $10, $03, $00 ; entry 12
    db $D0, $10, $04, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame4::
Data_03B_62C4:: ; address name
    db $F8, $10, $00, $00 ; entry 0
    db $E8, $00, $00, $00 ; entry 1
    db $E8, $08, $01, $20 ; entry 2
    db $E8, $10, $02, $00 ; entry 3
    db $E0, $F8, $00, $20 ; entry 4
    db $E0, $00, $01, $00 ; entry 5
    db $E0, $08, $02, $20 ; entry 6
    db $E0, $10, $03, $00 ; entry 7
    db $D8, $F0, $00, $00 ; entry 8
    db $D8, $F8, $01, $20 ; entry 9
    db $D8, $00, $02, $00 ; entry 10
    db $D8, $08, $03, $20 ; entry 11
    db $D8, $10, $04, $00 ; entry 12
    db $D0, $F0, $01, $00 ; entry 13
    db $D0, $F8, $02, $20 ; entry 14
    db $D0, $00, $03, $00 ; entry 15
    db $D0, $08, $04, $20 ; entry 16
    db $F0, $08, $00, $20 ; entry 17
    db $F0, $10, $01, $00 ; entry 18
    db $D0, $10, $05, $00 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame5::
Data_03B_6315:: ; address name
    db $F8, $08, $00, $20 ; entry 0
    db $F8, $10, $01, $00 ; entry 1
    db $F0, $00, $00, $00 ; entry 2
    db $F0, $08, $01, $20 ; entry 3
    db $F0, $10, $02, $00 ; entry 4
    db $E8, $F8, $00, $20 ; entry 5
    db $E8, $00, $01, $00 ; entry 6
    db $E8, $08, $02, $20 ; entry 7
    db $E8, $10, $03, $00 ; entry 8
    db $E0, $F0, $00, $00 ; entry 9
    db $E0, $F8, $01, $20 ; entry 10
    db $E0, $00, $02, $00 ; entry 11
    db $E0, $08, $03, $20 ; entry 12
    db $E0, $10, $04, $00 ; entry 13
    db $D8, $E8, $00, $20 ; entry 14
    db $D8, $F0, $01, $00 ; entry 15
    db $D8, $F8, $02, $20 ; entry 16
    db $D8, $00, $03, $00 ; entry 17
    db $D8, $08, $04, $00 ; entry 18
    db $D0, $E8, $01, $20 ; entry 19
    db $D0, $F0, $02, $00 ; entry 20
    db $D0, $F8, $03, $20 ; entry 21
    db $D0, $00, $04, $00 ; entry 22
    db $D0, $08, $05, $00 ; entry 23
    db $D0, $10, $06, $00 ; entry 24
    db $D8, $10, $08, $00 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame6::
Data_03B_637E:: ; address name
    db $F8, $00, $00, $20 ; entry 0
    db $F8, $08, $01, $00 ; entry 1
    db $F8, $10, $02, $20 ; entry 2
    db $F0, $F8, $00, $00 ; entry 3
    db $F0, $00, $01, $20 ; entry 4
    db $F0, $08, $02, $00 ; entry 5
    db $F0, $10, $03, $20 ; entry 6
    db $E8, $F0, $00, $20 ; entry 7
    db $E8, $F8, $01, $00 ; entry 8
    db $E8, $00, $02, $20 ; entry 9
    db $E8, $08, $03, $00 ; entry 10
    db $E8, $10, $04, $00 ; entry 11
    db $E0, $E8, $00, $00 ; entry 12
    db $E0, $F0, $01, $20 ; entry 13
    db $E0, $F8, $02, $00 ; entry 14
    db $E0, $00, $03, $20 ; entry 15
    db $E0, $08, $04, $00 ; entry 16
    db $D8, $E8, $01, $00 ; entry 17
    db $D8, $F0, $02, $20 ; entry 18
    db $D8, $F8, $03, $00 ; entry 19
    db $D8, $00, $04, $00 ; entry 20
    db $D0, $E8, $02, $00 ; entry 21
    db $D0, $F0, $03, $20 ; entry 22
    db $D0, $F8, $04, $00 ; entry 23
    db $D8, $08, $08, $00 ; entry 24
    db $D8, $10, $07, $00 ; entry 25
    db $D0, $00, $05, $00 ; entry 26
    db $D0, $08, $06, $00 ; entry 27
    db $D0, $10, $05, $00 ; entry 28
    db $E0, $10, $05, $00 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame7::
Data_03B_63F7:: ; address name
    db $F8, $F8, $00, $20 ; entry 0
    db $F8, $00, $01, $00 ; entry 1
    db $F8, $08, $02, $20 ; entry 2
    db $F8, $10, $03, $00 ; entry 3
    db $F0, $F0, $00, $00 ; entry 4
    db $F0, $F8, $01, $20 ; entry 5
    db $F0, $00, $02, $00 ; entry 6
    db $F0, $08, $03, $20 ; entry 7
    db $F0, $10, $04, $00 ; entry 8
    db $E8, $E8, $00, $20 ; entry 9
    db $E8, $F0, $01, $00 ; entry 10
    db $E8, $F8, $02, $20 ; entry 11
    db $E8, $00, $03, $00 ; entry 12
    db $E8, $08, $04, $00 ; entry 13
    db $E0, $E8, $01, $20 ; entry 14
    db $E0, $F0, $02, $00 ; entry 15
    db $E0, $F8, $03, $20 ; entry 16
    db $E0, $00, $04, $00 ; entry 17
    db $D8, $E8, $02, $20 ; entry 18
    db $D8, $F0, $03, $00 ; entry 19
    db $D8, $F8, $04, $00 ; entry 20
    db $D0, $E8, $03, $20 ; entry 21
    db $D0, $F0, $04, $00 ; entry 22
    db $D0, $F8, $05, $00 ; entry 23
    db $D0, $00, $06, $00 ; entry 24
    db $D0, $08, $05, $00 ; entry 25
    db $D0, $10, $06, $00 ; entry 26
    db $D8, $00, $08, $00 ; entry 27
    db $D8, $08, $07, $00 ; entry 28
    db $D8, $10, $08, $00 ; entry 29
    db $E0, $08, $05, $00 ; entry 30
    db $E0, $10, $06, $00 ; entry 31
    db $E8, $10, $08, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame8::
Data_03B_647C:: ; address name
    db $F8, $F0, $00, $20 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $08, $03, $00 ; entry 3
    db $F8, $10, $04, $00 ; entry 4
    db $F0, $E8, $00, $00 ; entry 5
    db $F0, $F0, $01, $20 ; entry 6
    db $F0, $F8, $02, $00 ; entry 7
    db $F0, $00, $03, $20 ; entry 8
    db $F0, $08, $04, $00 ; entry 9
    db $E8, $E8, $01, $00 ; entry 10
    db $E8, $F0, $02, $20 ; entry 11
    db $E8, $F8, $03, $00 ; entry 12
    db $E8, $00, $04, $00 ; entry 13
    db $E0, $E8, $02, $00 ; entry 14
    db $E0, $F0, $03, $20 ; entry 15
    db $E0, $F8, $04, $00 ; entry 16
    db $D8, $E8, $03, $00 ; entry 17
    db $D8, $F0, $04, $00 ; entry 18
    db $D0, $E8, $04, $00 ; entry 19
    db $D0, $F0, $05, $00 ; entry 20
    db $D0, $F8, $06, $00 ; entry 21
    db $D0, $00, $05, $00 ; entry 22
    db $D0, $08, $06, $00 ; entry 23
    db $D0, $10, $05, $00 ; entry 24
    db $D8, $F8, $08, $00 ; entry 25
    db $D8, $00, $07, $00 ; entry 26
    db $D8, $08, $08, $00 ; entry 27
    db $D8, $10, $07, $00 ; entry 28
    db $E0, $00, $05, $00 ; entry 29
    db $E0, $08, $06, $00 ; entry 30
    db $E0, $10, $05, $00 ; entry 31
    db $F0, $10, $05, $00 ; entry 32
    db $E8, $08, $08, $00 ; entry 33
    db $E8, $10, $07, $00 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame9::
Data_03B_6509:: ; address name
    db $F8, $E8, $00, $20 ; entry 0
    db $F8, $F0, $01, $00 ; entry 1
    db $F8, $F8, $02, $20 ; entry 2
    db $F0, $E8, $01, $20 ; entry 3
    db $F0, $F0, $02, $00 ; entry 4
    db $E8, $E8, $02, $20 ; entry 5
    db $F8, $00, $03, $00 ; entry 6
    db $F8, $08, $04, $00 ; entry 7
    db $F0, $F8, $03, $20 ; entry 8
    db $F0, $00, $04, $00 ; entry 9
    db $E8, $F0, $03, $00 ; entry 10
    db $E8, $F8, $04, $00 ; entry 11
    db $E0, $E8, $03, $20 ; entry 12
    db $E0, $F0, $04, $00 ; entry 13
    db $D8, $E8, $04, $00 ; entry 14
    db $D0, $E8, $05, $00 ; entry 15
    db $D0, $F0, $06, $00 ; entry 16
    db $D0, $F8, $05, $00 ; entry 17
    db $D0, $00, $06, $00 ; entry 18
    db $D0, $08, $05, $00 ; entry 19
    db $D0, $10, $06, $00 ; entry 20
    db $D8, $F0, $08, $00 ; entry 21
    db $D8, $F8, $07, $00 ; entry 22
    db $D8, $00, $08, $00 ; entry 23
    db $D8, $08, $07, $00 ; entry 24
    db $D8, $10, $08, $00 ; entry 25
    db $E0, $F8, $05, $00 ; entry 26
    db $E0, $00, $06, $00 ; entry 27
    db $E0, $08, $05, $00 ; entry 28
    db $E0, $10, $06, $00 ; entry 29
    db $E8, $00, $08, $00 ; entry 30
    db $E8, $08, $07, $00 ; entry 31
    db $E8, $10, $08, $00 ; entry 32
    db $F8, $10, $08, $00 ; entry 33
    db $F0, $08, $05, $00 ; entry 34
    db $F0, $10, $06, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame10::
Data_03B_659A:: ; address name
    db $D8, $E8, $08, $00 ; entry 0
    db $F8, $E8, $01, $00 ; entry 1
    db $F8, $F0, $02, $20 ; entry 2
    db $F0, $E8, $02, $00 ; entry 3
    db $F8, $F8, $03, $00 ; entry 4
    db $F0, $F0, $03, $20 ; entry 5
    db $E8, $E8, $03, $00 ; entry 6
    db $E0, $E8, $04, $00 ; entry 7
    db $E8, $F0, $04, $00 ; entry 8
    db $F0, $F8, $04, $00 ; entry 9
    db $F8, $00, $04, $00 ; entry 10
    db $D0, $E8, $06, $00 ; entry 11
    db $D0, $F0, $05, $00 ; entry 12
    db $D0, $F8, $06, $00 ; entry 13
    db $D0, $00, $05, $00 ; entry 14
    db $D0, $08, $06, $00 ; entry 15
    db $D0, $10, $05, $00 ; entry 16
    db $D8, $F0, $07, $00 ; entry 17
    db $D8, $F8, $08, $00 ; entry 18
    db $D8, $00, $07, $00 ; entry 19
    db $D8, $08, $08, $00 ; entry 20
    db $D8, $10, $07, $00 ; entry 21
    db $E0, $F0, $05, $00 ; entry 22
    db $E0, $F8, $06, $00 ; entry 23
    db $E0, $00, $05, $00 ; entry 24
    db $E0, $08, $06, $00 ; entry 25
    db $E0, $10, $05, $00 ; entry 26
    db $E8, $F8, $08, $00 ; entry 27
    db $E8, $00, $07, $00 ; entry 28
    db $E8, $08, $08, $00 ; entry 29
    db $E8, $10, $07, $00 ; entry 30
    db $F0, $00, $05, $00 ; entry 31
    db $F0, $08, $06, $00 ; entry 32
    db $F0, $10, $05, $00 ; entry 33
    db $F8, $08, $08, $00 ; entry 34
    db $F8, $10, $07, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame11::
Data_03B_662B:: ; address name
    db $F8, $E8, $02, $20 ; entry 0
    db $F8, $F0, $03, $00 ; entry 1
    db $F0, $E8, $03, $20 ; entry 2
    db $E8, $E8, $04, $00 ; entry 3
    db $F0, $F0, $04, $00 ; entry 4
    db $F8, $F8, $04, $00 ; entry 5
    db $D0, $E8, $05, $00 ; entry 6
    db $D0, $F0, $06, $00 ; entry 7
    db $D0, $F8, $05, $00 ; entry 8
    db $D0, $00, $06, $00 ; entry 9
    db $D0, $08, $05, $00 ; entry 10
    db $D8, $E8, $07, $00 ; entry 11
    db $D8, $F0, $08, $00 ; entry 12
    db $D8, $F8, $07, $00 ; entry 13
    db $D8, $00, $08, $00 ; entry 14
    db $D8, $08, $07, $00 ; entry 15
    db $E0, $E8, $05, $00 ; entry 16
    db $E0, $F0, $06, $00 ; entry 17
    db $E0, $F8, $05, $00 ; entry 18
    db $E0, $00, $06, $00 ; entry 19
    db $E0, $08, $05, $00 ; entry 20
    db $E8, $F0, $08, $00 ; entry 21
    db $E8, $F8, $07, $00 ; entry 22
    db $E8, $00, $08, $00 ; entry 23
    db $E8, $08, $07, $00 ; entry 24
    db $F0, $F8, $05, $00 ; entry 25
    db $F0, $00, $06, $00 ; entry 26
    db $F0, $08, $05, $00 ; entry 27
    db $F8, $00, $08, $00 ; entry 28
    db $F8, $08, $07, $00 ; entry 29
    db $D0, $10, $06, $00 ; entry 30
    db $D8, $10, $08, $00 ; entry 31
    db $E0, $10, $06, $00 ; entry 32
    db $E8, $10, $08, $00 ; entry 33
    db $F0, $10, $06, $00 ; entry 34
    db $F8, $10, $08, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame12::
Data_03B_66BC:: ; address name
    db $F8, $E8, $03, $00 ; entry 0
    db $F0, $E8, $04, $00 ; entry 1
    db $F8, $F0, $04, $00 ; entry 2
    db $D0, $E8, $06, $00 ; entry 3
    db $D0, $F0, $05, $00 ; entry 4
    db $D0, $F8, $06, $00 ; entry 5
    db $D0, $00, $05, $00 ; entry 6
    db $D8, $E8, $08, $00 ; entry 7
    db $D8, $F0, $07, $00 ; entry 8
    db $D8, $F8, $08, $00 ; entry 9
    db $D8, $00, $07, $00 ; entry 10
    db $E0, $E8, $06, $00 ; entry 11
    db $E0, $F0, $05, $00 ; entry 12
    db $E0, $F8, $06, $00 ; entry 13
    db $E0, $00, $05, $00 ; entry 14
    db $E8, $E8, $08, $00 ; entry 15
    db $E8, $F0, $07, $00 ; entry 16
    db $E8, $F8, $08, $00 ; entry 17
    db $E8, $00, $07, $00 ; entry 18
    db $F0, $F0, $05, $00 ; entry 19
    db $F0, $F8, $06, $00 ; entry 20
    db $F0, $00, $05, $00 ; entry 21
    db $F8, $F8, $08, $00 ; entry 22
    db $F8, $00, $07, $00 ; entry 23
    db $D0, $08, $06, $00 ; entry 24
    db $D8, $08, $08, $00 ; entry 25
    db $E0, $08, $06, $00 ; entry 26
    db $E8, $08, $08, $00 ; entry 27
    db $F0, $08, $06, $00 ; entry 28
    db $F8, $08, $08, $00 ; entry 29
    db $D0, $10, $05, $00 ; entry 30
    db $D8, $10, $07, $00 ; entry 31
    db $E0, $10, $05, $00 ; entry 32
    db $E8, $10, $07, $00 ; entry 33
    db $F0, $10, $05, $00 ; entry 34
    db $F8, $10, $07, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame13::
Data_03B_674D:: ; address name
    db $F8, $E8, $04, $00 ; entry 0
    db $D0, $E8, $05, $00 ; entry 1
    db $D0, $F0, $06, $00 ; entry 2
    db $D0, $F8, $05, $00 ; entry 3
    db $D8, $E8, $07, $00 ; entry 4
    db $D8, $F0, $08, $00 ; entry 5
    db $D8, $F8, $07, $00 ; entry 6
    db $E0, $E8, $05, $00 ; entry 7
    db $E0, $F0, $06, $00 ; entry 8
    db $E0, $F8, $05, $00 ; entry 9
    db $E8, $E8, $07, $00 ; entry 10
    db $E8, $F0, $08, $00 ; entry 11
    db $E8, $F8, $07, $00 ; entry 12
    db $F0, $E8, $05, $00 ; entry 13
    db $F0, $F0, $06, $00 ; entry 14
    db $F0, $F8, $05, $00 ; entry 15
    db $F8, $F0, $08, $00 ; entry 16
    db $F8, $F8, $07, $00 ; entry 17
    db $D0, $00, $06, $00 ; entry 18
    db $D8, $00, $08, $00 ; entry 19
    db $E0, $00, $06, $00 ; entry 20
    db $E8, $00, $08, $00 ; entry 21
    db $F0, $00, $06, $00 ; entry 22
    db $F8, $00, $08, $00 ; entry 23
    db $D0, $08, $05, $00 ; entry 24
    db $D8, $08, $07, $00 ; entry 25
    db $E0, $08, $05, $00 ; entry 26
    db $E8, $08, $07, $00 ; entry 27
    db $F0, $08, $05, $00 ; entry 28
    db $F8, $08, $07, $00 ; entry 29
    db $D0, $10, $06, $00 ; entry 30
    db $D8, $10, $08, $00 ; entry 31
    db $E0, $10, $06, $00 ; entry 32
    db $E8, $10, $08, $00 ; entry 33
    db $F0, $10, $06, $00 ; entry 34
    db $F8, $10, $08, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame14::
Data_03B_67DE:: ; address name
    db $D0, $E8, $06, $00 ; entry 0
    db $D0, $F0, $05, $00 ; entry 1
    db $D8, $E8, $08, $00 ; entry 2
    db $D8, $F0, $07, $00 ; entry 3
    db $E0, $E8, $06, $00 ; entry 4
    db $E0, $F0, $05, $00 ; entry 5
    db $E8, $E8, $08, $00 ; entry 6
    db $E8, $F0, $07, $00 ; entry 7
    db $F0, $E8, $06, $00 ; entry 8
    db $F0, $F0, $05, $00 ; entry 9
    db $F8, $E8, $08, $00 ; entry 10
    db $F8, $F0, $07, $00 ; entry 11
    db $D0, $F8, $06, $00 ; entry 12
    db $D8, $F8, $08, $00 ; entry 13
    db $E0, $F8, $06, $00 ; entry 14
    db $E8, $F8, $08, $00 ; entry 15
    db $F0, $F8, $06, $00 ; entry 16
    db $F8, $F8, $08, $00 ; entry 17
    db $D0, $00, $05, $00 ; entry 18
    db $D8, $00, $07, $00 ; entry 19
    db $E0, $00, $05, $00 ; entry 20
    db $E8, $00, $07, $00 ; entry 21
    db $F0, $00, $05, $00 ; entry 22
    db $F8, $00, $07, $00 ; entry 23
    db $D0, $08, $06, $00 ; entry 24
    db $D8, $08, $08, $00 ; entry 25
    db $E0, $08, $06, $00 ; entry 26
    db $E8, $08, $08, $00 ; entry 27
    db $F0, $08, $06, $00 ; entry 28
    db $F8, $08, $08, $00 ; entry 29
    db $D0, $10, $05, $00 ; entry 30
    db $D8, $10, $07, $00 ; entry 31
    db $E0, $10, $05, $00 ; entry 32
    db $E8, $10, $07, $00 ; entry 33
    db $F0, $10, $05, $00 ; entry 34
    db $F8, $10, $07, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame15::
Data_03B_686F:: ; address name
    db $F8, $E8, $09, $00 ; entry 0
    db $F0, $E8, $09, $00 ; entry 1
    db $E8, $E8, $09, $00 ; entry 2
    db $E0, $E8, $09, $00 ; entry 3
    db $D8, $E8, $09, $00 ; entry 4
    db $D0, $E8, $09, $00 ; entry 5
    db $D0, $F0, $09, $00 ; entry 6
    db $D8, $F0, $09, $00 ; entry 7
    db $E0, $F0, $09, $00 ; entry 8
    db $E8, $F0, $09, $00 ; entry 9
    db $F0, $F0, $09, $00 ; entry 10
    db $F8, $F0, $09, $00 ; entry 11
    db $F8, $F8, $09, $00 ; entry 12
    db $F0, $F8, $09, $00 ; entry 13
    db $E8, $F8, $09, $00 ; entry 14
    db $E0, $F8, $09, $00 ; entry 15
    db $D8, $F8, $09, $00 ; entry 16
    db $D0, $F8, $09, $00 ; entry 17
    db $F8, $00, $09, $00 ; entry 18
    db $F0, $00, $09, $00 ; entry 19
    db $E8, $00, $09, $00 ; entry 20
    db $E0, $00, $09, $00 ; entry 21
    db $D8, $00, $09, $00 ; entry 22
    db $D0, $00, $09, $00 ; entry 23
    db $D0, $08, $09, $00 ; entry 24
    db $D8, $08, $09, $00 ; entry 25
    db $E0, $08, $09, $00 ; entry 26
    db $E8, $08, $09, $00 ; entry 27
    db $F0, $08, $09, $00 ; entry 28
    db $F8, $08, $09, $00 ; entry 29
    db $F8, $10, $09, $00 ; entry 30
    db $F0, $10, $09, $00 ; entry 31
    db $E8, $10, $09, $00 ; entry 32
    db $E0, $10, $09, $00 ; entry 33
    db $D8, $10, $09, $00 ; entry 34
    db $D0, $10, $09, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3B_507CSet31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet31Frame16::
    db $80 ; end

; E-0147 (derived: meta-sprite set 50 of MetaSprites3B_507CTable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3B_507CSet32::
Data_03B_6901:: ; address name
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

; E-0147 (derived: frame 0 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame0::
Data_03B_6941:: ; address name
    db $D0, $28, $00, $00 ; entry 0
    db $D0, $E0, $00, $00 ; entry 1
    db $D0, $C0, $01, $00 ; entry 2
    db $D8, $D0, $00, $00 ; entry 3
    db $E0, $F6, $01, $00 ; entry 4
    db $D8, $18, $01, $00 ; entry 5
    db $E0, $30, $02, $00 ; entry 6
    db $D0, $FE, $02, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame1::
Data_03B_6962:: ; address name
    db $F0, $28, $00, $00 ; entry 0
    db $F0, $E0, $00, $00 ; entry 1
    db $F0, $C0, $01, $00 ; entry 2
    db $F8, $18, $01, $00 ; entry 3
    db $F0, $FE, $02, $00 ; entry 4
    db $E8, $F2, $02, $00 ; entry 5
    db $D8, $1F, $00, $20 ; entry 6
    db $F8, $40, $01, $00 ; entry 7
    db $E0, $B8, $01, $00 ; entry 8
    db $E8, $30, $00, $00 ; entry 9
    db $E0, $18, $02, $20 ; entry 10
    db $D8, $FA, $00, $20 ; entry 11
    db $E0, $D8, $01, $20 ; entry 12
    db $D8, $E5, $02, $20 ; entry 13
    db $D8, $C0, $00, $20 ; entry 14
    db $E0, $40, $01, $20 ; entry 15
    db $D8, $30, $01, $20 ; entry 16
    db $E8, $D0, $00, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame2::
Data_03B_69AB:: ; address name
    db $E8, $C0, $01, $00 ; entry 0
    db $F0, $F2, $02, $00 ; entry 1
    db $E0, $1F, $00, $20 ; entry 2
    db $D0, $00, $00, $20 ; entry 3
    db $D0, $E2, $02, $20 ; entry 4
    db $D0, $3A, $01, $20 ; entry 5
    db $D0, $2A, $01, $20 ; entry 6
    db $F8, $B8, $01, $00 ; entry 7
    db $E8, $D8, $01, $20 ; entry 8
    db $F8, $E4, $00, $00 ; entry 9
    db $E0, $F8, $02, $00 ; entry 10
    db $F8, $00, $00, $00 ; entry 11
    db $E8, $10, $02, $20 ; entry 12
    db $F8, $2B, $00, $00 ; entry 13
    db $E8, $40, $01, $00 ; entry 14
    db $E0, $2E, $00, $00 ; entry 15
    db $D8, $0F, $01, $00 ; entry 16
    db $F8, $D0, $01, $00 ; entry 17
    db $D0, $D0, $00, $00 ; entry 18
    db $D0, $B8, $02, $00 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame3::
Data_03B_69FC:: ; address name
    db $E8, $D9, $00, $00 ; entry 0
    db $D8, $F8, $00, $00 ; entry 1
    db $D8, $BE, $01, $00 ; entry 2
    db $F0, $20, $01, $00 ; entry 3
    db $E8, $00, $02, $20 ; entry 4
    db $F0, $E8, $02, $00 ; entry 5
    db $F0, $B8, $01, $20 ; entry 6
    db $D8, $28, $00, $20 ; entry 7
    db $D8, $40, $02, $20 ; entry 8
    db $D0, $0C, $00, $20 ; entry 9
    db $D0, $20, $01, $20 ; entry 10
    db $D0, $C5, $03, $00 ; entry 11
    db $E8, $CA, $03, $00 ; entry 12
    db $D0, $F0, $03, $00 ; entry 13
    db $F8, $06, $03, $00 ; entry 14
    db $D8, $16, $03, $00 ; entry 15
    db $D0, $38, $03, $00 ; entry 16
    db $F0, $38, $03, $00 ; entry 17
    db $E0, $E9, $03, $00 ; entry 18
    db $D8, $CE, $03, $00 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame4::
Data_03B_6A4D:: ; address name
    db $F0, $18, $00, $20 ; entry 0
    db $F8, $E0, $01, $20 ; entry 1
    db $F8, $B8, $01, $20 ; entry 2
    db $E0, $40, $01, $20 ; entry 3
    db $E8, $C8, $00, $20 ; entry 4
    db $E0, $E0, $02, $00 ; entry 5
    db $E2, $20, $01, $00 ; entry 6
    db $D8, $13, $02, $00 ; entry 7
    db $F2, $D0, $04, $00 ; entry 8
    db $E2, $B8, $04, $00 ; entry 9
    db $F8, $38, $04, $00 ; entry 10
    db $DE, $D1, $04, $00 ; entry 11
    db $D8, $F2, $04, $00 ; entry 12
    db $E8, $E6, $04, $00 ; entry 13
    db $F8, $06, $04, $00 ; entry 14
    db $E0, $18, $04, $00 ; entry 15
    db $DC, $38, $04, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame5::
Data_03B_6A92:: ; address name
    db $F0, $06, $02, $20 ; entry 0
    db $D0, $16, $02, $00 ; entry 1
    db $D0, $CE, $01, $00 ; entry 2
    db $F8, $40, $01, $20 ; entry 3
    db $E8, $E8, $02, $00 ; entry 4
    db $E0, $CA, $00, $20 ; entry 5
    db $D0, $40, $02, $20 ; entry 6
    db $D0, $BE, $05, $00 ; entry 7
    db $E8, $B8, $05, $00 ; entry 8
    db $E0, $D9, $05, $00 ; entry 9
    db $D8, $E9, $05, $00 ; entry 10
    db $E0, $00, $05, $00 ; entry 11
    db $D0, $28, $05, $00 ; entry 12
    db $E0, $20, $05, $00 ; entry 13
    db $E8, $38, $05, $00 ; entry 14
    db $F8, $28, $05, $00 ; entry 15
    db $F8, $F8, $05, $00 ; entry 16
    db $F8, $CD, $05, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame6::
Data_03B_6ADB:: ; address name
    db $F0, $38, $05, $20 ; entry 0
    db $EC, $E8, $05, $20 ; entry 1
    db $E4, $BE, $05, $20 ; entry 2
    db $E8, $D9, $03, $00 ; entry 3
    db $EA, $00, $03, $00 ; entry 4
    db $E0, $28, $05, $20 ; entry 5
    db $EB, $20, $03, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame7::
Data_03B_6AF8:: ; address name
    db $ED, $2A, $03, $00 ; entry 0
    db $F8, $3C, $03, $00 ; entry 1
    db $F1, $BA, $03, $00 ; entry 2
    db $F8, $20, $03, $00 ; entry 3
    db $F8, $E6, $03, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3B_507CSet32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3B_507CSet32Frame8::
    db $80 ; end
    ds $14F2, $00
