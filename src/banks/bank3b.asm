SECTION "Bank 3B", ROMX[$4000], BANK[$3B]
    db $3B

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base HP: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's HP word (wCFF6) is returned; otherwise the word at offset $1D of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 3 call sites from 3 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01, Func_036_65E8)
; reads: wCFF6, wCFF7
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId, wCFE7
; points at: wDAAE
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a

Jump_03B_403C::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base MP: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's MP word (wCFF8) is returned; otherwise the word at offset $21 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 3 call sites from 3 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01, Func_036_6605)
; reads: wCFF8, wCFF9
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId, wCFE7
; points at: wDAAE
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a

Jump_03B_4080::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base ATK: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's ATK word (wCFFA) is returned; otherwise the word at offset $23 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 3 call sites from 3 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01, Func_036_6622)
; reads: wCFFA, wCFFB
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId, wCFE7
; points at: wDAAE
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFFA]
    ld c, a
    ld a, [wCFFB]
    ld b, a

Jump_03B_40C4::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base DEF: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's DEF word (wCFFC) is returned; otherwise the word at offset $25 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 7 call sites from 7 routines (e.g. Func_005_6B20, Func_032_5BE8, RecomputeTargetMaxHPAndMP, Func_032_6581, ...)
; reads: wCFFC, wCFFD
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId, wCFE7
; points at: wDAAE
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFFC]
    ld c, a
    ld a, [wCFFD]
    ld b, a

Jump_03B_4108::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base AGL: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's AGL word (wCFFE) is returned; otherwise the word at offset $27 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 7 call sites from 7 routines (e.g. Func_005_6B5F, Func_032_5BE8, RecomputeTargetMaxHPAndMP, Func_032_6581, ...)
; reads: wCFFE, wCFFF
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId, wCFE7
; points at: wDAAE
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFFE]
    ld c, a
    ld a, [wCFFF]
    ld b, a

Jump_03B_414C::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; C = battle slot: returns in wBattleStatResultLo/Hi the slot's base INT: for slot numbers whose low two bits are 3 (slots 3 and 7) the monster id from wDAAE is loaded with LoadMonsterRecord and the monster record's INT word (wD000) is returned; otherwise the word at offset $29 of the slot's 78-byte battler record (wBattlerRecords, BattlerRecordFieldAddress). The stat order is confirmed by the pause menu's INFO panel (E-0046)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01)
; reads: wD000, wD001
; writes: wBattleStatResultLo, wBattleStatResultHi, wMonsterId, wCFE7
; points at: wDAAE
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wD000]
    ld c, a
    ld a, [wD001]
    ld b, a

Jump_03B_4190::
    ld a, c
    ld [wBattleStatResultLo], a
    ld a, b
    ld [wBattleStatResultHi], a
    ret

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01)
; reads: wCFF5
; writes: wBattleStatResultLo, wMonsterId, wCFE7
; points at: wDAAE
Func_03B_4199::
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFF5]
    ld c, a

Jump_03B_41CE::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01)
; reads: wD002
; writes: wBattleStatResultLo, wMonsterId, wCFE7
; points at: wDAAE
Func_03B_41D3::
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wD002]
    ld c, a

Jump_03B_4208::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01)
; reads: wD004
; writes: wBattleStatResultLo, wMonsterId, wCFE7
; points at: wDAAE
Func_03B_420D::
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wD004]
    ld c, a

Jump_03B_4242::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01)
; reads: wD003
; writes: wBattleStatResultLo, wMonsterId, wCFE7
; points at: wDAAE
Func_03B_4247::
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wD003]
    ld c, a

Jump_03B_427C::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01)
; reads: wD005
; writes: wBattleStatResultLo, wMonsterId, wCFE7
; points at: wDAAE
Func_03B_4281::
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
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wD005]
    ld c, a

Jump_03B_42B6::
    ld a, c
    ld [wBattleStatResultLo], a
    ret

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_66D6)
; reads: wD00A, wD00B
; writes: wSpeciesIdLo, wSpeciesIdHi
Func_03B_42BB::
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
    ld a, [wD00A]
    swap a
    ld c, a
    ld a, [wD00B]
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
; 6 call sites from 6 routines (e.g. GetBaseINT, GetBaseATK, GetBaseMP, GetBaseHP, ...)
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
    dw Func_03B_42F4_Case00
    dw Func_03B_42F4_Case01
    dw Func_03B_42F4_Case02
    dw Func_03B_42F4_Case03
    dw Func_03B_42F4_Case04
    dw Func_03B_42F4_Case05
    dw Func_03B_42F4_Case06
    dw Func_03B_42F4_Case07
    dw Func_03B_42F4_Case08
    dw Func_03B_42F4_Case09
    dw Func_03B_42F4_Case0A
    dw Func_03B_42F4_Case0B
    dw Func_03B_42F4_Case0C
    dw Func_03B_42F4_Case0D

; entry 0 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wD892, wD893, wC57F
; writes: wDABA, wD808, wBattleTarget, wBattleActionId, wBattleResolveStep
; points at: wBattleResolveStep
Func_03B_42F4_Case00::
Jump_03B_4314:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wDABA], a
    xor a, a
    ld [wD808], a
    ld a, [wD892]
    cp a, $10
    jr z, Jump_03B_433E
    cp a, $20
    jr z, Jump_03B_434B
    and a, $07
    ld [wBattleTarget], a
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03B_435D
    ld a, [wD893]
    cp a, $0C
    jr z, Jump_03B_435D
    jr Jump_03B_4364

Jump_03B_433E::
    ld c, $00
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03B_4356
    ld c, $04
    jr Jump_03B_4356

Jump_03B_434B::
    ld c, $04
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03B_4356
    ld c, $00

Jump_03B_4356::
    call Func_03B_4373
    ld a, c
    ld [wBattleTarget], a

Jump_03B_435D::
    ld a, [wD893]
    ld [wBattleActionId], a
    ret

Jump_03B_4364::
    ld [wBattleActionId], a
    farcall Func_03A_6E92
    ld a, $0D
    ld [wBattleResolveStep], a
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case00)
Func_03B_4373::
    ld b, $03

Jump_03B_4375::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    inc c
    dec b
    jr nz, Jump_03B_4375
    ret

; entry 1 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
Func_03B_42F4_Case01::
Jump_03B_437F:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    farcall Func_03A_6E92
    ret

; entry 2 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wCFC5, wBattleTarget
; writes: wDAD2, wBattleResolveStep
; points at: wBattleResolveStep, wD8A1, wBattleStatus
Func_03B_42F4_Case02::
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
    ld a, [wCFC5]
    cp a, $03
    jr z, Jump_03B_43F5
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03

Jump_03B_43AD::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03B_43E5
    ld a, c
    and a, $03
    ld hl, wD8A1
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
    ld [wDAD2], a
    farcall SelectEffectByWDAD2Flags
    ret

Jump_03B_43F5::
    call Func_03B_444A
    ld d, $7E
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4406::
    call Func_03B_444A
    ld d, $E6
    farcall ShowBattleText
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4417::
    call Func_03B_444A
    ld d, $7B
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4428::
    call Func_03B_444A
    ld d, $7D
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

Jump_03B_4439::
    call Func_03B_444A
    ld d, $7C
    farcall ShowBattleTextCategory0
    ld a, $0B
    ld [wBattleResolveStep], a
    ret

; 5 call sites from 1 routine (e.g. Func_03B_42F4_Case02)
; reads: wD890
; writes: hFFC6
Func_03B_444A::
    ld a, [wD890]
    ldh [hFFC6], a
    farcall Func_03A_774C
    ret

; entry 3 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleResolveStep, wD811
Func_03B_42F4_Case03::
Jump_03B_4456:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    ret z
    ld d, $66
    farcall ShowBattleText
    call Func_03B_470B
    ret

; entry 4 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
Func_03B_42F4_Case04::
Jump_03B_4473:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call Func_03B_4B02
    ret

; entry 5 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wDAC0, wBattleDamageLo, wD873, wBattleActionId, wBattleTarget
; writes: wDAC0, wD808, wDAD2, wDAD3
; points at: wBattleResolveStep
Func_03B_42F4_Case05::
Jump_03B_447B:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAC0]
    ld b, a
    bit 5, a
    jr z, Jump_03B_449D
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
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
    ld [wDAC0], a

Jump_03B_449D::
    ld a, [wDAC0]
    bit 4, a
    ret z
    ld a, $01
    ld [wD808], a
    ld a, $04
    ld [wDAD2], a
    farcall SelectEffectByWDAD2Flags
    ld a, $01
    ld [wDAD3], a
    farcall SelectEffectByWDAD3Flags
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
    ld a, [wD873]
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
    ld a, [wD873]
    ld h, a
    srl h
    rr l

Jump_03B_450A::
    call Func_03B_4970
    ret

Jump_03B_450E::
    call Func_03B_4953
    ret

; entry 6 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wDAC0, wDAC2, wC0A0, wDAC3
; writes: wC0A0
; points at: wBattleResolveStep
Func_03B_42F4_Case06::
Jump_03B_4512:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_03B_4529
    ld a, [wDAC2]
    ld [wC0A0], a
    jr Jump_03B_452F

Jump_03B_4529::
    ld a, [wDAC3]
    ld [wC0A0], a

Jump_03B_452F::
    ld a, [wC0A0]
    ld d, a
    farcall ShowBattleText
    call Func_03B_453D
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case06)
; reads: wDAC0
Func_03B_453D::
    ld a, [wDAC0]
    bit 4, a
    ret nz
    call Func_03B_470B
    ret

; entry 7 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
Func_03B_42F4_Case07::
Jump_03B_4547:: ; address name
    ret

; entry 8 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wDAC1, wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleSubStep2
; points at: wBattleResolveStep, wBattleHP
Func_03B_42F4_Case08::
Jump_03B_4548:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAC1]
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
    ld a, [wD873]
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
    call SetBit0OfWD095Indexed_Bank3B
    ld a, [wBattleTarget]
    call SetBit1OfWD095Indexed_Bank3B
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank3B
    ret

Jump_03B_459E::
    ret

; entry 9 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
Func_03B_42F4_Case09::
Jump_03B_459F:: ; address name
    farcall Func_032_6764
    ret

; entry 10 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wD893, wD892, wBattleTarget, wDABA
; writes: wBattleTarget, wBattleResolveStep, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleResolveStep, wBattleMonsterId, wDABA, wD88B
Func_03B_42F4_Case0A::
Jump_03B_45A6:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wD893]
    cp a, $1F
    jr z, Jump_03B_45CF
    cp a, $1D
    jr z, Jump_03B_45C7
    ld a, [wD892]
    cp a, $10
    jr z, Jump_03B_4627
    cp a, $20
    ret nz
    ld a, [wD893]
    cp a, $1E
    jr nz, Jump_03B_4627
    ret

Jump_03B_45C7::
    ld a, [wBattleTarget]
    cp a, $04
    ret c
    jr Jump_03B_4627

Jump_03B_45CF::
    ld a, [wDABA]
    bit 7, a
    call z, Func_03B_4711
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
    ld hl, wDABA
    dec [hl]
    ld a, [hl]
    cp a, $80
    ret z
    ld a, $04
    ld [wBattleResolveStep], a
    ld a, [hl]
    and a, $7F
    dec a
    ld hl, wD88B
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld [wBattleTarget], a
    ret

Jump_03B_4627::
    call Func_03B_4635
    ret z
    ld a, c
    ld [wBattleTarget], a
    ld a, $03
    ld [wBattleResolveStep], a
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case0A)
; reads: wDABA
; writes: wDABA
Func_03B_4635::
    ld a, [wDABA]
    bit 7, a
    jr nz, Jump_03B_4647
    call Func_03B_4650
    ld a, [wDABA]
    or a, $80
    ld [wDABA], a

Jump_03B_4647::
    call Func_03B_4673
    ld a, [wDABA]
    and a, $7F
    ret

; 1 call site from 1 routine (e.g. Func_03B_4635)
; reads: wBattleTarget
; points at: wDABA
Func_03B_4650::
    ld b, $04
    ld a, [wBattleTarget]
    and a, $04
    ld c, a

Jump_03B_4658::
    ld a, [wBattleTarget]
    cp a, c
    jr z, Jump_03B_4668
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03B_4668
    jr z, Jump_03B_466C
    jr Jump_03B_466C

Jump_03B_4668::
    ld hl, wDABA
    inc [hl]

Jump_03B_466C::
    inc c
    dec b
    ld a, b
    or a, a
    jr nz, Jump_03B_4658
    ret

; 1 call site from 1 routine (e.g. Func_03B_4635)
; reads: wBattleTarget, wCFF2
; points at: wDABA
Func_03B_4673::
    ld a, [wBattleTarget]
    inc a
    ld c, a
    ld hl, wDABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

Jump_03B_4680::
    ld a, [wCFF2]
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
    call CarryUnlessWDA63SlotEmpty
    ret nc
    jr z, Jump_03B_469B

Jump_03B_469B::
    inc c
    jr Jump_03B_4680

; entry 11 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; reads: wDAC1, wD808, wD893, wCFD5, wC471, wItemId, wD087
; writes: wItemId, wD082
; points at: wBattleResolveStep
Func_03B_42F4_Case0B::
Jump_03B_469E:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAC1]
    bit 0, a
    jr nz, Jump_03B_46AE
    ld a, [wD808]
    or a, a
    ret z

Jump_03B_46AE::
    ld a, [wD893]
    ld [wItemId], a
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wC471]
    and a, $03
    add a, b
    ld [wD082], a
    farcall LoadItemRecord
    farcall ConsumeSelectedItemByChance
    ld a, [wItemId]
    cp a, $FF
    ret nz
    ld a, [wD087]
    cp a, $64
    jr nz, Jump_03B_46E6
    ld a, [wD893]
    cp a, $1E
    jr z, Jump_03B_46E6
    ret

Jump_03B_46E6::
    ld d, $87
    farcall ShowBattleText
    ret

; entry 12 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; writes: wDABA, wBattleSubPhase, wBattleResolveStep
Func_03B_42F4_Case0C::
Jump_03B_46EF:: ; address name
    xor a, a
    ld [wDABA], a
    ld a, $07
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 13 of the `rst $00` table in Func_03B_42F4
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
Func_03B_42F4_Case0D::
Jump_03B_46FD:: ; address name
    ld d, $CC
    farcall ShowBattleText
    ld a, $0C
    ld [wBattleResolveStep], a
    ret

; 2 call sites from 2 routines (e.g. Func_03B_453D, Func_03B_42F4_Case03)
; writes: wBattleResolveStep
Func_03B_470B::
    ld a, $0A
    ld [wBattleResolveStep], a
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case0A)
; reads: wBattleTarget
; writes: wD88B, wDABA, wD88C, wD88D
; points at: wD88B, wC0A0
Func_03B_4711::
    ld a, $FF
    ld hl, wD88B
    ld bc, $0003
    call FillBytes
    farcall Func_03A_7AE3
    ld a, d
    cp a, $03
    jr z, Jump_03B_4735
    cp a, $02
    jp z, Jump_03B_47CD
    ld a, [wBattleTarget]
    ld [wD88B], a
    jp Jump_03B_4813

Jump_03B_4735::
    ld a, [wBattleTarget]
    ld c, a
    ld a, c
    add a, a
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc c
    ld a, c
    add a, a
    ld hl, wC0A0
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
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4775
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4775
    ld a, c
    or a, $80
    ld [wD88B], a
    jp Jump_03B_4813

Jump_03B_4775::
    ld a, [wBattleTarget]
    or a, $80
    ld [wD88C], a
    ld a, c
    ld d, a
    ld [wD88B], a
    jp Jump_03B_481F

Jump_03B_4785::
    inc c
    ld a, c
    add a, a
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_47A8
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_47A8
    ld a, [wBattleTarget]
    or a, $80
    ld [wD88C], a
    dec c
    ld a, c
    ld d, a
    ld [wD88B], a
    jr Jump_03B_481F

Jump_03B_47A8::
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec c
    ld a, c
    add a, a
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4823
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4823
    ld a, [wBattleTarget]
    ld [wD88C], a
    ld a, c
    ld d, a
    or a, $80
    ld [wD88B], a
    jr Jump_03B_481F

Jump_03B_47CD::
    ld a, [wBattleTarget]
    ld c, a
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03B_47E3
    inc c
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, d
    add a, a
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl+]
    cp a, c
    jr nz, Jump_03B_4817
    ld a, [hl]
    cp a, b
    jr nz, Jump_03B_4817
    ld a, e
    or a, $80
    ld [wD88B], a

Jump_03B_4813::
    ld a, $01
    jr Jump_03B_4834

Jump_03B_4817::
    ld a, e
    ld [wD88C], a
    ld a, d
    ld [wD88B], a

Jump_03B_481F::
    ld a, $02
    jr Jump_03B_4834

Jump_03B_4823::
    dec c
    ld a, c
    ld [wD88D], a
    inc c
    ld a, c
    ld [wD88C], a
    inc c
    ld a, c
    ld [wD88B], a
    ld a, $03

Jump_03B_4834::
    or a, $80
    ld [wDABA], a
    ret

; 1 call site from 1 routine (e.g. Func_03B_4B92)
; reads: wBattleActionId, wBattleTarget
; writes: wBattleDamageLo, wD873
; points at: wBattleHP, wBattleMaxHP
Func_03B_483A::
    ld a, [wBattleActionId]
    cp a, $03
    jr z, Jump_03B_485F
    cp a, $01
    jr z, Jump_03B_4854
    cp a, $38
    jr z, Jump_03B_4854
    ld hl, $003C
    ld bc, $0046
    call Func_03B_4A40
    jr Jump_03B_4873

Jump_03B_4854::
    ld hl, $001E
    ld bc, $0028
    call Func_03B_4A40
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
    ld [wD873], a

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
    call Func_03B_48E9
    ld b, h
    ld c, l

Jump_03B_4896::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_03B_4BBD)
; reads: wBattleActionId, wBattleTarget
; writes: wBattleDamageLo, wD873
; points at: wBattleMP, wBattleMaxMP
Func_03B_489B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActionId]
    cp a, $05
    jr z, Jump_03B_48AD
    ld hl, $0014
    ld bc, $001E
    call Func_03B_4A40
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
    ld [wD873], a

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
    call Func_03B_48E9
    ld b, h
    ld c, l

Jump_03B_48E4::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; 2 call sites from 2 routines (e.g. Func_03B_483A, Func_03B_489B)
; writes: wBattleDamageLo, wD873
Func_03B_48E9::
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
    ld [wD873], a
    ret

; 2 call sites from 2 routines (e.g. Func_03B_4D1C, Func_03B_4C95)
; reads: wBattleTarget, wBattleActionId
; points at: wD93F
Func_03B_48FA::
    ld a, [wBattleTarget]
    ld hl, wD93F
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

Data_03B_492A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $00, $0A, $00, $14, $00, $64, $00, $05, $00

; 2 call sites from 2 routines (e.g. Func_03B_4D1C, Func_03B_4C95)
; reads: wBattleActionId
Func_03B_4934::
    ld a, [wBattleActionId]
    sub a, $19
    add a, a
    ld hl, Data_03B_4949
    add_a_to_hl
    deref_hl
    call Func_03B_4953
    ret

Data_03B_4949:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $00, $1E, $00, $64, $00, $E7, $03, $05, $00

; 2 call sites from 2 routines (e.g. Func_03B_42F4_Case05, Func_03B_4934)
; reads: wD89F, wD8A0
; writes: wD89F, wD8A0
Func_03B_4953::
    ld a, [wD89F]
    ld c, a
    ld a, [wD8A0]
    ld b, a
    add hl, bc
    ld bc, $0708
    call CompareHLToBC
    jr c, Jump_03B_4967
    ld hl, $0708

Jump_03B_4967::
    ld a, l
    ld [wD89F], a
    ld a, h
    ld [wD8A0], a
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case05)
; reads: wD89F, wD8A0
; writes: wD89F, wD8A0
Func_03B_4970::
    ld a, [wD89F]
    ld c, a
    ld a, [wD8A0]
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
    ld [wD89F], a
    ld a, h
    ld [wD8A0], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_03B_4990:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActionId]
    sub a, $24
    add a, a
    add a, a
    ld de, Func_03B_4A24
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
    call Func_03B_4A40
    ld a, [wBattleActionId]
    cp a, $24
    jr nz, Jump_03B_49BD
    call Func_03B_4A5B
    rlca
    rlca
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49BD::
    cp a, $25
    jr nz, Jump_03B_49CA
    call Func_03B_4A5B
    swap a
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49CA::
    cp a, $26
    jr nz, Jump_03B_49D7
    call Func_03B_4A5B
    rrca
    rrca
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49D7::
    call Func_03B_4A56
    swap a
    and a, $03

Jump_03B_49DE::
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_03B_4A03
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
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
    ld [wD873], a
    ret

Jump_03B_4A03::
    cp a, $02
    jr nz, Jump_03B_4A1C
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    srl h
    rr l
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_03B_4A1C::
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_03B_4A24:: ; heuristic: follows a terminator; C0
    ld [$1800], sp
    nop
    inc hl
    nop
    ld [hl-], a
    nop
    ld a, b
    nop
    adc a, h
    nop
    or a, h
    nop
    ret z
    nop

; 1 call site from 1 routine (e.g. Func_03B_4E1B)
Func_03B_4A34::
    call HLToWD814EntryOfWD8A5_Bank3B
    call Func_03B_4A60
    and a, $03
    call Func_03B_4A86
    ret

; 4 call sites from 3 routines (e.g. Func_03B_4990, Func_03B_483A, Func_03B_489B)
; writes: wBattleDamageLo, wD873
Func_03B_4A40::
    call RandomInRange
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ret

; HL = wD814 + 9 * [wD8A5] (AddAx9ToHL); A = [wD8A5] (the same 10 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_03B_4A34)
; reads: wBattleTarget
; points at: wD814
HLToWD814EntryOfWD8A5_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_4A4C:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    ret

; 1 call site from 1 routine (e.g. Func_03B_4990)
; reads: wBattleTarget
; points at: wDA72
Func_03B_4A56::
    ld de, wDA72
    jr Jump_03B_4A77

; 3 call sites from 1 routine (e.g. Func_03B_4990)
; reads: wBattleTarget
; points at: wDA73
Func_03B_4A5B::
    ld de, wDA73
    jr Jump_03B_4A77

; 1 call site from 1 routine (e.g. Func_03B_4A34)
; reads: wBattleTarget
; points at: wDA74
Func_03B_4A60::
    ld de, wDA74
    jr Jump_03B_4A77
    db $11, $75, $DA, $18, $0D, $11, $76, $DA, $18, $08, $11, $77, $DA, $18, $03, $11
    db $78, $DA

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

; 1 call site from 1 routine (e.g. Func_03B_4A34)
Func_03B_4A86:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_03B_4A8F
    call Func_03B_4ABF
    jr Jump_03B_4A9B

Jump_03B_4A8F::
    bit 7, [hl]
    jr z, Jump_03B_4A98
    call Func_03B_4AB2
    jr Jump_03B_4A9B

Jump_03B_4A98::
    call Func_03B_4A9C

Jump_03B_4A9B::
    ret

; 1 call site from 1 routine (e.g. Func_03B_4A86)
; reads: wC5E7
Func_03B_4A9C::
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

; 1 call site from 1 routine (e.g. Func_03B_4A86)
; reads: wC5E7
Func_03B_4AB2::
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

; 1 call site from 1 routine (e.g. Func_03B_4A86)
; reads: wC5E7
Func_03B_4ABF::
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
    ld a, [wC5E7]
    cp a, $D8
    ret

Jump_03B_4ADE::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $BF
    ret

Jump_03B_4AE7::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $7F
    ret

Jump_03B_4AF0::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $66
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7
Func_03B_4AF9:: ; heuristic: follows a terminator; C0
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $3F
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case04)
; reads: wBattleActionId
Func_03B_4B02::
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld hl, $4B11
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret
    db $91, $4B, $92, $4B, $92, $4B, $92, $4B, $BD, $4B, $BD, $4B
    dw Func_03B_4BE8
    dw Func_03B_4BFE
    dw Func_03B_4C21
    dw Func_03B_4C37
    dw Func_03B_4C5A
    dw Func_03B_4B92
    dw Func_03B_4C7D
    db $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C
    db $94, $4C, $94, $4C, $94, $4C, $94, $4C
    dw Func_03B_4C95
    dw Func_03B_4C95
    dw Func_03B_4C95
    dw Func_03B_4C95
    dw Func_03B_4D1C
    dw Func_03B_4E0A
    dw Func_03B_4E18
    INCBIN "dwm2-cobi-us.gbc", $0ECB51, $41

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleHP, wBattleMaxHP
Func_03B_4B92:: ; heuristic: target of a pointer table; C0
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
    call Func_03B_483A
    ld l, $37
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4BBA::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleMP, wBattleMaxMP
Func_03B_4BBD:: ; heuristic: follows a terminator; C0
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
    call Func_03B_489B
    ld l, $C3
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4BE5::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
Func_03B_4BE8:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $03
    jr z, Jump_03B_4BFB
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4BFB::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wDA5B
Func_03B_4BFE:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $40
    jr z, Jump_03B_4C1E
    ld a, [hl]
    and a, $BF
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld l, $4F
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4C1E::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
Func_03B_4C21:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $20
    jr z, Jump_03B_4C34
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4C34::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wDA5B
Func_03B_4C37:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $8C
    jr z, Jump_03B_4C57
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld l, $82
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4C57::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wDA5B
Func_03B_4C5A:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $10
    jr z, Jump_03B_4C7A
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4C7A::
    jp Jump_03B_4EE3

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleResolveStep, wDAC3, wDAC0, wDAC1
Func_03B_4C7D:: ; heuristic: target of a pointer table; C0
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03B_4C8E
    jr z, Jump_03B_4C91
    farcall Func_036_6D0A
    ret

Jump_03B_4C8E::
    jp Jump_03B_4EE3

Jump_03B_4C91::
    jp Jump_03B_4F15
    db $C9

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleStatus
Func_03B_4C95:: ; heuristic: target of a pointer table; C0
    call TargetOnLocalSide_Bank3B
    jr c, Jump_03B_4C9F
    call Func_03B_4934
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
    call Func_03B_48FA

Jump_03B_4CC8::
    ld a, [wBattleTarget]
    cp a, $03
    jr c, Jump_03B_4CE2
    farcall Func_03A_7AE3
    ld a, b
    cp a, $01
    jr z, Jump_03B_4CE2
    ld l, $FD
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4CE2::
    ld l, $95
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank3B

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

; no direct call (reached through a table, a jump or a vector)
; reads: wDABA, wBattleTarget
; writes: wDAC0, wDAC1, wDAC3
; points at: wBattleStatus
Func_03B_4D1C:: ; heuristic: target of a pointer table; C0
    call TargetOnLocalSide_Bank3B
    jr c, Jump_03B_4D2C
    ld a, [wDABA]
    or a, a
    jr nz, Jump_03B_4D59
    call Func_03B_4934
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
    call Func_03B_48FA

Jump_03B_4D59::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, Jump_03B_4DAC
    push hl
    farcall Func_036_60D1
    pop hl
    ld a, e
    or a, a
    jr nz, Jump_03B_4DAC
    set 0, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank3B
    ld l, $75
    ld bc, $0090
    call ClearDamageAndStoreWDAC0_Bank3B
    ld a, [wDABA]
    or a, a
    ret nz
    ld a, [wBattleTarget]
    cp a, $03
    jr c, Jump_03B_4DA3
    farcall Func_03A_7AE3
    ld a, b
    cp a, $01
    jr z, Jump_03B_4DA3
    ld d, $FE
    farcall ShowBattleText
    ret

Jump_03B_4DA3::
    ld d, $96
    farcall ShowBattleText
    ret

Jump_03B_4DAC::
    call Func_03B_4EF1
    ld a, [wDABA]
    or a, a
    ret nz
    ld a, [wBattleTarget]
    cp a, $03
    jr c, Jump_03B_4DCF
    farcall Func_03A_7AE3
    ld a, b
    cp a, $01
    jr z, Jump_03B_4DCF
    ld d, $FE
    farcall ShowBattleText
    ret

Jump_03B_4DCF::
    ld d, $96
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

; no direct call (reached through a table, a jump or a vector)
; writes: wD894, wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
Func_03B_4E0A:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD894], a
    ld l, $98
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank3B
    db $C9

; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
Func_03B_4E18:: ; heuristic: target of a pointer table; C0
    jp Jump_03B_4F15

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleResolveStep
; points at: wD80D
Func_03B_4E1B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_03B_4E40
    call Func_03B_4A34
    jr nc, Jump_03B_4E43
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4E40::
    jp Jump_03B_4F15

Jump_03B_4E43::
    jp Jump_03B_4EEA

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wBattleResolveStep
; points at: wD80D
Func_03B_4E46:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, Jump_03B_4E5D
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank3B

Jump_03B_4E5D::
    jp Jump_03B_4F15
    INCBIN "dwm2-cobi-us.gbc", $0ECE60, $6F

; clears wBattleDamageLo/wD873 (the damage word), then wDAC2 = L, wDAC0 = C, wDAC1 = B (the same instructions as the bank-$36 copy) (E-0073)
; 1 call site from 1 routine (e.g. Func_03B_4D1C)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
ClearDamageAndStoreWDAC0_Bank3B::
Func_03B_4ECF:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_03B_4ED6::
    ld a, l
    ld [wDAC2], a
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

Jump_03B_4EE3::
    ld h, $CC
    ld bc, $0080
    jr Jump_03B_4EF6

Jump_03B_4EEA::
    ld h, $B5
    ld bc, $0080
    jr Jump_03B_4EF6

; 1 call site from 1 routine (e.g. Func_03B_4D1C)
; writes: wDAC3, wDAC0, wDAC1
Func_03B_4EF1::
    ld h, $B5
    ld bc, $0180

Jump_03B_4EF6::
    ld a, h
    ld [wDAC3], a

Jump_03B_4EFA::
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

; 5 call sites from 5 routines (e.g. Func_03B_4C5A, Func_03B_4C37, Func_03B_4C21, Func_03B_4BFE, ...)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873
; points at: wBattleStatus
Func_03B_4F03::
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a
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
; 1 call site from 1 routine (e.g. Func_03B_483A)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank3B::
Func_03B_4F25:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_03B_4F48

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. Func_03B_489B)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank3B::
Func_03B_4F2A:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_03B_4F48
    db $21, $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21
    db $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_03B_4F48::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; 10 call sites from 6 routines (e.g. Func_03B_42F4_Case08, Func_03B_48FA, Func_03B_4B92, Func_03B_483A, ...)
AddDoubleAToHL_Bank3B::
Func_03B_4F52:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_4F59:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03B_4F6E
    ld a, [wC57F]
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

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 11 banks)
; 3 call sites from 3 routines (e.g. Func_03B_42F4_Case02, Func_03B_4D1C, Func_03B_4C95)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_Bank3B::
Func_03B_4F74:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03B_4F89
    ld a, [wC57F]
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
    db $7A, $21, $A4, $4F, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. Func_03B_42F4_Case08)
; points at: wD095
SetBit0OfWD095Indexed_Bank3B::
Func_03B_4FAB:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. Func_03B_42F4_Case08)
; points at: wD095
SetBit1OfWD095Indexed_Bank3B::
Func_03B_4FB8:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. Func_03B_42F4_Case08, Func_03B_4D1C)
; points at: wD095
SetBit2OfWD095Indexed_Bank3B::
Func_03B_4FC5:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
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

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 7 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
CheckSlotStatusBlockWide_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_5029:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
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

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 8 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
SlotHasStatus3Or4Bits_Bank3B:: ; heuristic: follows a terminator; C0
Func_03B_5048:: ; address name
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03B_5057
    ld a, [hl]
    and a, $0C

Jump_03B_5057::
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_03A_5383)
; reads: wD804, wD801, wDAB7
; points at: hSpriteOriginX
Func_03B_5059::
    ld hl, hSpriteOriginX
    ld a, [wD804]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $68
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, [wD801]
    ld [hl+], a
    ld a, [wDAB7]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld de, Data_03B_507C
    call BuildOamFromSpriteTable_Bank3B
    ret

Data_03B_507C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_52C8
    dw Data_03B_5AE1
    dw Data_03B_5E7C
    dw Data_03B_6208
    dw Data_03B_6901

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. Func_03B_5059)
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

Data_03B_5133:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5173
    dw Data_03B_517C
    dw Data_03B_5195
    dw Data_03B_51AE
    dw Data_03B_51BF
    dw Data_03B_51C8
    dw Data_03B_51D5
    dw Data_03B_51E2
    dw Data_03B_51F7
    dw Data_03B_5218
    dw Data_03B_5255
    dw Data_03B_5296
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7

Data_03B_5173:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $FF, $00, $20, $80

Data_03B_517C:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $02, $00, $F8, $F8, $03, $00, $F8, $00, $03, $20, $F8, $07, $02, $20
    db $F0, $FF, $01, $20, $F0, $F8, $01, $00, $80

Data_03B_5195:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $05, $00, $F8, $F8, $06, $00, $F8, $07, $05, $20, $F8, $FF, $06, $20
    db $F0, $F8, $04, $00, $F0, $FF, $04, $20, $80

Data_03B_51AE:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $08, $00, $F0, $F8, $07, $00, $F8, $FF, $08, $20, $F0, $FF, $07, $20
    db $80

Data_03B_51BF:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $0A, $00, $F0, $FC, $09, $00, $80

Data_03B_51C8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $0B, $00, $F0, $FC, $0A, $00, $E8, $FC, $09, $00, $80

Data_03B_51D5:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $0D, $00, $F0, $FC, $0E, $00, $F8, $FC, $0C, $00, $80

Data_03B_51E2:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $11, $00, $E8, $00, $12, $00, $E0, $F8, $0F, $00, $E0, $00, $10, $00
    db $F0, $FC, $0C, $00, $80

Data_03B_51F7:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F4, $16, $00, $E4, $FC, $17, $00, $E4, $04, $18, $00, $DC, $F4, $13, $00
    db $DC, $FC, $14, $00, $DC, $04, $15, $00, $EC, $F8, $19, $00, $EC, $00, $1A, $00
    db $80

Data_03B_5218:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F0, $1B, $00, $D8, $F8, $1C, $00, $D8, $00, $1D, $00, $E0, $F0, $1E, $00
    db $E0, $F8, $1F, $00, $E0, $00, $1F, $20, $E8, $F8, $1F, $40, $E8, $00, $1F, $60
    db $E0, $08, $20, $00, $E8, $08, $1E, $60, $F0, $F0, $22, $00, $F0, $F8, $23, $00
    db $F0, $00, $24, $00, $F0, $08, $25, $00, $E8, $F0, $21, $00, $80

Data_03B_5255:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED255, $41

Data_03B_5296:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $06, $2F, $00, $D2, $06, $2E, $00, $D6, $12, $2F, $00, $DA, $F2, $2E, $20
    db $D2, $F2, $2F, $20, $D7, $EA, $2E, $20, $EE, $F2, $2F, $60, $F6, $F2, $2E, $60
    db $F2, $E6, $2F, $60, $EE, $06, $2E, $40, $F6, $06, $2F, $40, $F1, $0E, $2E, $40
    db $80

Data_03B_52C7:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_52C8:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5308
    dw Data_03B_5351
    dw Data_03B_53C2
    dw Data_03B_5453
    dw Data_03B_54E8
    dw Data_03B_5585
    dw Data_03B_560E
    dw Data_03B_567F
    dw Data_03B_56C8
    dw Data_03B_5701
    dw Data_03B_5742
    dw Data_03B_5783
    dw Data_03B_57B8
    dw Data_03B_57E1
    dw Data_03B_580A
    dw Data_03B_5847
    dw Data_03B_5870
    dw Data_03B_5895
    dw Data_03B_58B6
    dw Data_03B_58DF
    dw Data_03B_5920
    dw Data_03B_5961
    dw Data_03B_598A
    dw Data_03B_59BB
    dw Data_03B_59F4
    dw Data_03B_5A39
    dw Data_03B_5A7E
    dw Data_03B_5AAB
    dw Data_03B_5AE0
    dw Data_03B_5AE0
    dw Data_03B_5AE0
    dw Data_03B_5AE0

Data_03B_5308:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED308, $49

Data_03B_5351:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED351, $71

Data_03B_53C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED3C2, $91

Data_03B_5453:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED453, $95

Data_03B_54E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED4E8, $9D

Data_03B_5585:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED585, $89

Data_03B_560E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED60E, $71

Data_03B_567F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED67F, $49

Data_03B_56C8:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $40, $27, $00, $F8, $38, $2A, $00, $F8, $40, $2B, $00, $F0, $38, $28, $00
    db $F0, $40, $29, $00, $F0, $28, $00, $00, $F0, $30, $04, $00, $F8, $28, $0C, $00
    db $F8, $30, $0D, $00, $F8, $10, $20, $00, $F8, $18, $21, $00, $F8, $20, $22, $00
    db $F8, $08, $20, $20, $F8, $00, $21, $20, $80

Data_03B_5701:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED701, $41

Data_03B_5742:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED742, $41

Data_03B_5783:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $20, $20, $00, $F8, $28, $21, $00, $F8, $30, $23, $20, $F0, $38, $20, $00
    db $F0, $40, $21, $00, $F0, $48, $23, $20, $F8, $38, $24, $00, $F8, $40, $25, $00
    db $F8, $48, $26, $00, $F8, $18, $20, $20, $F8, $10, $21, $20, $F8, $08, $23, $00
    db $F8, $00, $22, $00, $80

Data_03B_57B8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $08, $20, $00, $F8, $10, $21, $00, $F8, $38, $20, $00, $F8, $40, $21, $00
    db $F8, $48, $23, $20, $F8, $00, $20, $20, $F8, $30, $20, $20, $F8, $28, $21, $20
    db $F8, $20, $23, $00, $F8, $18, $22, $00, $80

Data_03B_57E1:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $20, $20, $00, $F8, $28, $21, $00, $F8, $18, $20, $20, $F8, $10, $21, $20
    db $F8, $48, $20, $20, $F8, $40, $21, $20, $F8, $38, $23, $00, $F8, $30, $22, $00
    db $F8, $08, $23, $00, $F8, $00, $25, $00, $80

Data_03B_580A:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $28, $20, $00, $F0, $30, $21, $00, $F0, $38, $23, $20, $F8, $28, $24, $00
    db $F8, $30, $25, $00, $F8, $10, $20, $00, $F8, $18, $21, $00, $F8, $20, $23, $20
    db $F8, $08, $20, $20, $F8, $00, $21, $20, $F0, $48, $21, $20, $F0, $40, $22, $20
    db $F8, $48, $25, $20, $F8, $40, $26, $20, $F8, $38, $2C, $00, $80

Data_03B_5847:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $21, $00, $F8, $00, $22, $00, $F8, $20, $20, $20, $F8, $18, $21, $20
    db $F8, $10, $23, $00, $F8, $30, $20, $00, $F8, $38, $21, $00, $F8, $40, $23, $20
    db $F8, $48, $22, $20, $F8, $08, $2C, $20, $80

Data_03B_5870:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $00, $20, $20, $F8, $F8, $21, $20, $F8, $F0, $22, $20, $F8, $D0, $20, $00
    db $F8, $D8, $21, $00, $F8, $E0, $23, $20, $F8, $30, $20, $00, $F8, $38, $20, $20
    db $F8, $E8, $2C, $40, $80

Data_03B_5895:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $40, $20, $00, $F8, $48, $20, $20, $F8, $00, $20, $00, $F8, $08, $20, $20
    db $F8, $D8, $20, $00, $F8, $E0, $20, $20, $F8, $C8, $20, $00, $F8, $D0, $20, $20
    db $80

Data_03B_58B6:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D0, $21, $00, $F8, $C8, $21, $20, $F8, $C0, $22, $20, $F0, $B8, $20, $20
    db $F0, $B0, $21, $20, $F8, $B8, $24, $20, $F8, $B0, $25, $20, $F0, $25, $27, $20
    db $F8, $25, $29, $20, $F8, $2D, $08, $00, $80

Data_03B_58DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED8DF, $41

Data_03B_5920:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED920, $41

Data_03B_5961:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C0, $20, $00, $F8, $C8, $21, $00, $F8, $B8, $20, $20, $F8, $B0, $21, $20
    db $F8, $F0, $20, $00, $F8, $F8, $21, $00, $F8, $E0, $21, $20, $F8, $D8, $22, $20
    db $F8, $D0, $23, $20, $F8, $E8, $20, $20, $80

Data_03B_598A:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D8, $20, $00, $F8, $E0, $21, $00, $F8, $D0, $20, $20, $F8, $C8, $21, $20
    db $F8, $F8, $21, $20, $F8, $F0, $23, $00, $F8, $E8, $22, $00, $F8, $C0, $23, $00
    db $F8, $B0, $24, $00, $F8, $B8, $25, $00, $F0, $B0, $21, $20, $F0, $B8, $20, $20
    db $80

Data_03B_59BB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $20, $00, $F8, $F8, $21, $00, $F8, $E8, $20, $20, $F8, $E0, $21, $20
    db $F8, $D8, $23, $00, $F8, $C8, $24, $00, $F8, $D0, $25, $00, $F0, $C0, $21, $20
    db $F0, $B8, $22, $20, $F0, $C8, $20, $20, $F8, $C0, $25, $20, $F8, $B8, $26, $20
    db $F0, $B0, $18, $00, $F8, $B0, $2C, $00, $80

Data_03B_59F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED9F4, $45

Data_03B_5A39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDA39, $45

Data_03B_5A7E:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D8, $20, $00, $F8, $E0, $21, $00, $F8, $D0, $20, $20, $F8, $C8, $21, $20
    db $F8, $E8, $22, $00, $F8, $C0, $23, $00, $F8, $B0, $24, $00, $F8, $B8, $25, $00
    db $F0, $B0, $20, $20, $F8, $F8, $23, $00, $F8, $F0, $26, $00, $80

Data_03B_5AAB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $20, $00, $F8, $E8, $20, $20, $F8, $E0, $21, $20, $F8, $D8, $23, $00
    db $F8, $C8, $24, $00, $F8, $D0, $25, $00, $F0, $C8, $20, $20, $F0, $B0, $23, $20
    db $F0, $C0, $21, $20, $F0, $B8, $22, $20, $F8, $C0, $25, $20, $F8, $B0, $2C, $20
    db $F8, $B8, $26, $00, $80

Data_03B_5AE0:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_5AE1:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5B21
    dw Data_03B_5B32
    dw Data_03B_5B53
    dw Data_03B_5B78
    dw Data_03B_5B99
    dw Data_03B_5BAA
    dw Data_03B_5BBB
    dw Data_03B_5BC8
    dw Data_03B_5BD1
    dw Data_03B_5BE2
    dw Data_03B_5C03
    dw Data_03B_5C54
    dw Data_03B_5CB5
    dw Data_03B_5CFE
    dw Data_03B_5D47
    dw Data_03B_5D98
    dw Data_03B_5DE9
    dw Data_03B_5E32
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B

Data_03B_5B21:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $20, $00, $D8, $0B, $21, $00, $D0, $03, $22, $00, $D0, $0B, $23, $00
    db $80

Data_03B_5B32:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $20, $00, $DC, $08, $21, $00, $E4, $F8, $20, $60, $E4, $F0, $21, $60
    db $D4, $00, $22, $00, $D4, $08, $23, $00, $EC, $F8, $22, $60, $EC, $F0, $23, $60
    db $80

Data_03B_5B53:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $24, $00, $E8, $F4, $27, $00, $E8, $FC, $28, $00, $F0, $F0, $25, $00
    db $F0, $F8, $26, $00, $D8, $03, $2B, $00, $E0, $F8, $29, $00, $E0, $00, $2A, $00
    db $D0, $08, $2B, $00, $80

Data_03B_5B78:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EB, $27, $00, $F8, $F3, $28, $00, $E8, $FA, $2B, $00, $F0, $EF, $29, $00
    db $F0, $F7, $2A, $00, $E0, $FE, $2C, $00, $D0, $08, $2C, $00, $D8, $03, $2C, $00
    db $80

Data_03B_5B99:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $2D, $00, $F8, $EF, $2D, $00, $E8, $F9, $2C, $00, $DC, $01, $2C, $00
    db $80

Data_03B_5BAA:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $2D, $00, $E8, $F9, $2D, $00, $E0, $FE, $2D, $00, $F8, $EF, $2B, $00
    db $80

Data_03B_5BBB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EF, $2D, $00, $F0, $F4, $2D, $00, $E8, $F9, $2D, $00, $80

Data_03B_5BC8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $00, $01, $00, $80

Data_03B_5BD1:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $02, $00, $F0, $00, $03, $00, $F8, $F8, $04, $00, $F8, $00, $05, $00
    db $80

Data_03B_5BE2:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $02, $00, $E8, $00, $03, $00, $F0, $F8, $04, $00, $F0, $00, $05, $00
    db $F8, $F8, $06, $00, $F8, $00, $07, $00, $F8, $F0, $00, $00, $F8, $08, $01, $00
    db $80

Data_03B_5C03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDC03, $51

Data_03B_5C54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDC54, $61

Data_03B_5CB5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDCB5, $49

Data_03B_5CFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDCFE, $49

Data_03B_5D47:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDD47, $51

Data_03B_5D98:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDD98, $51

Data_03B_5DE9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDDE9, $49

Data_03B_5E32:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDE32, $49

Data_03B_5E7B:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_5E7C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5EBC
    dw Data_03B_5EC5
    dw Data_03B_5ED6
    dw Data_03B_5EE7
    dw Data_03B_5F08
    dw Data_03B_5F59
    dw Data_03B_5FBA
    dw Data_03B_602B
    dw Data_03B_60A4
    dw Data_03B_6125
    dw Data_03B_61A6
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207

Data_03B_5EBC:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $00, $01, $00, $80

Data_03B_5EC5:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $02, $00, $F0, $00, $03, $00, $F8, $F8, $04, $00, $F8, $00, $05, $00
    db $80

Data_03B_5ED6:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $00, $02, $20, $F0, $F8, $03, $20, $F8, $00, $04, $20, $F8, $F8, $05, $20
    db $80

Data_03B_5EE7:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $02, $00, $E8, $00, $03, $00, $F0, $F8, $04, $00, $F0, $00, $05, $00
    db $F8, $F8, $06, $00, $F8, $00, $07, $00, $F8, $F0, $00, $00, $F8, $08, $01, $00
    db $80

Data_03B_5F08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDF08, $51

Data_03B_5F59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDF59, $61

Data_03B_5FBA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDFBA, $71

Data_03B_602B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE02B, $79

Data_03B_60A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE0A4, $81

Data_03B_6125:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE125, $81

Data_03B_61A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE1A6, $61

Data_03B_6207:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_6208:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_6248
    dw Data_03B_6251
    dw Data_03B_6266
    dw Data_03B_628B
    dw Data_03B_62C4
    dw Data_03B_6315
    dw Data_03B_637E
    dw Data_03B_63F7
    dw Data_03B_647C
    dw Data_03B_6509
    dw Data_03B_659A
    dw Data_03B_662B
    dw Data_03B_66BC
    dw Data_03B_674D
    dw Data_03B_67DE
    dw Data_03B_686F
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900

Data_03B_6248:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $10, $00, $00, $D0, $10, $01, $00, $80

Data_03B_6251:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $08, $00, $20, $E0, $10, $00, $00, $D0, $08, $01, $20, $D8, $10, $01, $00
    db $D0, $10, $02, $00, $80

Data_03B_6266:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $00, $00, $E0, $08, $00, $20, $E8, $10, $00, $00, $D0, $00, $01, $00
    db $D8, $08, $01, $20, $E0, $10, $01, $00, $D0, $08, $02, $20, $D8, $10, $02, $00
    db $D0, $10, $03, $00, $80

Data_03B_628B:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F8, $00, $20, $E0, $00, $00, $00, $E8, $08, $00, $20, $F0, $10, $00, $00
    db $D0, $F8, $01, $20, $D8, $00, $01, $00, $E0, $08, $01, $20, $E8, $10, $01, $00
    db $D0, $00, $02, $00, $D8, $08, $02, $20, $E0, $10, $02, $00, $D0, $08, $03, $20
    db $D8, $10, $03, $00, $D0, $10, $04, $00, $80

Data_03B_62C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE2C4, $51

Data_03B_6315:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE315, $69

Data_03B_637E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE37E, $79

Data_03B_63F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE3F7, $85

Data_03B_647C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE47C, $8D

Data_03B_6509:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE509, $91

Data_03B_659A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE59A, $91

Data_03B_662B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE62B, $91

Data_03B_66BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE6BC, $91

Data_03B_674D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE74D, $91

Data_03B_67DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE7DE, $91

Data_03B_686F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE86F, $91

Data_03B_6900:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_6901:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_6941
    dw Data_03B_6962
    dw Data_03B_69AB
    dw Data_03B_69FC
    dw Data_03B_6A4D
    dw Data_03B_6A92
    dw Data_03B_6ADB
    dw Data_03B_6AF8
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D

Data_03B_6941:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $28, $00, $00, $D0, $E0, $00, $00, $D0, $C0, $01, $00, $D8, $D0, $00, $00
    db $E0, $F6, $01, $00, $D8, $18, $01, $00, $E0, $30, $02, $00, $D0, $FE, $02, $00
    db $80

Data_03B_6962:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE962, $49

Data_03B_69AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE9AB, $51

Data_03B_69FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE9FC, $51

Data_03B_6A4D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EEA4D, $45

Data_03B_6A92:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EEA92, $49

Data_03B_6ADB:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $38, $05, $20, $EC, $E8, $05, $20, $E4, $BE, $05, $20, $E8, $D9, $03, $00
    db $EA, $00, $03, $00, $E0, $28, $05, $20, $EB, $20, $03, $00, $80

Data_03B_6AF8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $2A, $03, $00, $F8, $3C, $03, $00, $F1, $BA, $03, $00, $F8, $20, $03, $00
    db $F8, $E6, $03, $00, $80

Data_03B_6B0D:: ; heuristic: target of a monotone pointer table; C0
    db $80
    ds $14F2, $00
