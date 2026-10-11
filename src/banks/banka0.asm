SECTION "Bank A0", ROMX[$4000], BANK[$A0]
    db $A0

; only called from GameMode7_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init)
; reads: wDataBank
; writes: wDataBankSave, wBattleKind
; points at: wEffectAnimState, wBattlePhase, wListPageSize, wWorkBuf
GameMode7_Init_Sub01::
Func_0A0_4001:: ; address name
    ld hl, wEffectAnimState
    ld bc, $0303
    xor a, a
    call FillBytes
    ld a, [wDataBank]
    ld [wDataBankSave], a
    ld hl, wBattlePhase
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wListPageSize
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $0A
    ld [wBattleKind], a
    call GameMode7_Init_Sub01_Sub01
    ld hl, wWorkBuf
    ld bc, $0200
    xor a, a
    call FillBytes
    call GameMode7_Init_Sub01_Sub05
    call GameMode7_Init_Sub01_Sub03
    call GameMode7_Init_Sub01_Sub02
    call GameMode7_Init_Sub01_Sub04
    call GameMode7_Init_Sub01_Sub06
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case00_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06)
; reads: wScreenCountPlusOne
; writes: wBattleTurn
; points at: wSlotMarks, wBattleArg0
RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub01::
Func_0A0_4047:: ; address name
    xor a, a
    ld hl, wBattleSlotOut + $4
    ld [hl+], a
    ld [hl+], a
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr z, Jump_0A0_405B
    xor a, a
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr Jump_0A0_405F

Jump_0A0_405B::
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_0A0_405F::
    ld hl, wSlotMarks
    ld a, $00
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, Jump_0A0_406B
    ld a, $03

Jump_0A0_406B::
    ld [hl+], a
    ld a, $01
    call CarryUnlessBattleSlotOutSlotEmpty
    ld a, $00
    jr nc, Jump_0A0_4077
    ld a, $03

Jump_0A0_4077::
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld a, $03
    call CarryUnlessBattleSlotOutSlotEmpty
    ld a, $00
    jr nc, Jump_0A0_4086
    ld a, $FF

Jump_0A0_4086::
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl+], a
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr z, Jump_0A0_409A
    ld a, $01
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr Jump_0A0_409E

Jump_0A0_409A::
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_0A0_409E::
    xor a, a
    ld [wBattleTurn], a
    ld hl, wBattleArg0
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01)
; reads: wBattleResultByte
; writes: wEffectId, wQueuedActionId, wBattleByteAD, wBattleFlag92, wDebugValue3, wDebugState, wDebugSubState, wDisplaySlot, ...
; points at: wMenuState, wSlotMarks, wSideControl, wBattleSlotOut, wBattleMonsterId, wSlotNameBytes, wActionQueue
GameMode7_Init_Sub01_Sub01::
Func_0A0_40B0:: ; address name
    ld a, $FF
    ld [wEffectId], a
    ld [wQueuedActionId], a
    ld [wBattleByteAD], a
    ld [wBattleFlag92], a
    ld hl, wMenuState
    ld bc, $0008
    xor a, a
    call FillBytes
    xor a, a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld hl, wSlotMarks
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    ld hl, wSideControl
    ld bc, $0008
    ld a, $80
    call FillBytes
    ld hl, wBattleSlotOut
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wBattleMonsterId
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld hl, wBattleSkills + $7F
    ld bc, $0020
    call FillBytes
    ld a, $FF
    ld hl, wSlotNameBytes
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $FF
    ld [wDisplaySlot], a
    ld a, $0A
    ld [wBattleMeter], a
    ld hl, wActionQueue
    ld bc, $000A
    ld a, $FF
    call FillBytes
    xor a, a
    ld [wBattleTurn], a
    ld a, $00
    ld [wBattleScene], a
    xor a, a
    ld [wBattleSetupD8], a
    ld [wBattleSetupD8 + $1], a
    ld [wBattleSetupD8 + $2], a
    ld [wLinkRuleTurnLimit], a
    ld a, $00
    ld [wScreenCountPlusOne], a
    ld a, $02
    ld [wBattlePartyCount], a
    ld a, $03
    ld [wBattleFoeCount], a
    ld a, [wBattleResultByte]
    ld [wBattleSetupDB], a
    ld a, $03
    ld [wBattleKindFlags], a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01)
; writes: wBGPaletteUploadRequest
GameMode7_Init_Sub01_Sub02::
Func_0A0_415D:: ; address name
    farcall ClearAttributesAndScreenBuffer_Bank31
    call GameMode7_Init_Sub01_Sub02_Sub01
    call GameMode7_Init_Sub01_Sub02_Sub02
    call GameMode7_Init_Sub01_Sub02_Sub03
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01)
GameMode7_Init_Sub01_Sub03::
Func_0A0_4181:: ; address name
    ld bc, $0200

Jump_0A0_4184::
    push bc
    call RunA04410Or456FBySlotC
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4184
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case00_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wSlotDamageFlags, wBattleSlotOut, wBattleMonsterId
RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub02::
Func_0A0_418E:: ; address name
    ld bc, $0204
    jr Jump_0A0_4196

; only called from RunBattlePhaseWhenTextIdle_A0_Case00_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wSlotDamageFlags, wBattleSlotOut, wBattleMonsterId
RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub03::
Func_0A0_4193:: ; address name
    ld bc, $0304

Jump_0A0_4196::
    push bc
    call RunA04410Or456FBySlotC
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4196
    call AdjustSkillsForBattleStart_A0
    ld de, wSlotDamageFlags
    ld bc, $0800

Jump_0A0_41A8::
    push bc
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_41DC
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesRecord
    pop de
    ld a, [wSpeciesRecord + $3]
    ld h, a
    ld a, [wSpeciesRecord + $2]
    swap a
    or a, h
    ld [de], a

Jump_0A0_41DC::
    pop bc
    inc de
    inc c
    dec b
    jr nz, Jump_0A0_41A8
    ret

; zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes; BC, HL kept (E-0067) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunA04410Or456FBySlotC)
; points at: wSpeciesRecord
ClearSpeciesRecordBuffer_BankA0::
Func_0A0_41E3:: ; address name
    push bc
    push hl
    ld hl, wSpeciesRecord
    ld bc, $002F
    xor a, a
    call FillBytes
    pop hl
    pop bc
    ret

; replaces skill $8F by $AA for slots without wD8AF set and marks skills $34 and $35 of the foe slots with tiles $AD and $AE (E-0127)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub03)
; points at: wSlotNameSuffix, wBattleSkills
AdjustSkillsForBattleStart_A0::
Func_0A0_41F2:: ; address name
    ld bc, $0800
    ld hl, wSlotNameSuffix

Jump_0A0_41F8::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_4203
    ld a, [hl]
    or a, a
    call z, ReplaceSkill8FWithAAInSlotC_A0

Jump_0A0_4203::
    inc c
    inc hl
    dec b
    jr nz, Jump_0A0_41F8
    ld bc, $0304
    ld hl, wBattleSkills + $40

Jump_0A0_420E::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_4230
    ld d, $04

Jump_0A0_4216::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_4230
    cp a, $34
    jr nz, Jump_0A0_4224
    call StoreTileADAtHL_BankA0
    jr Jump_0A0_422B

Jump_0A0_4224::
    cp a, $35
    jr nz, Jump_0A0_422B
    call StoreTileAEAtHL_BankA0

Jump_0A0_422B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_0A0_4216

Jump_0A0_4230::
    inc c
    ld a, c
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    dec b
    jr nz, Jump_0A0_420E
    ret

; in slot C's skill list replaces the first skill $8F by $AA, stopping at $FF (E-0124)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart_A0)
; points at: wBattleSkills
ReplaceSkill8FWithAAInSlotC_A0::
Func_0A0_4240:: ; address name
    push hl
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

Jump_0A0_424E::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_4259
    cp a, $8F
    jr nz, Jump_0A0_425B
    ld [hl], $AA

Jump_0A0_4259::
    pop hl
    ret

Jump_0A0_425B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_0A0_424E
    pop hl
    ret

; [HL] = $AD (E-0116)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart_A0)
StoreTileADAtHL_BankA0::
Func_0A0_4262:: ; address name
    ld [hl], $AD
    ret

; [HL] = $AE (E-0116)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart_A0)
StoreTileAEAtHL_BankA0::
Func_0A0_4265:: ; address name
    ld [hl], $AE
    ret

; only called from routines of RunA04410Or456FBySlotC (E-0098)
; 2 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_Sub01, RunA04410Or456FBySlotC_Sub02)
; points at: wBattleSlotOut, wBattleStatus
RunA04410Or456FBySlotC_Shared01::
Func_0A0_4268:: ; address name
    push hl
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_0A0_4272
    inc d

Jump_0A0_4272::
    bit 7, [hl]
    jr z, Jump_0A0_427B
    ld a, $01
    ld [de], a
    jr Jump_0A0_429A

Jump_0A0_427B::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wBattleStatus
    add a, a
    add a, a
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, Jump_0A0_428B
    inc d

Jump_0A0_428B::
    bit 0, [hl]
    jr z, Jump_0A0_4292
    ld a, $20
    ld [de], a

Jump_0A0_4292::
    bit 2, [hl]
    jr z, Jump_0A0_429A
    ld a, [de]
    or a, $01
    ld [de], a

Jump_0A0_429A::
    pop hl
    ret

; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks)
; 10 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_Sub01, RunA04410Or456FBySlotC_Sub02)
StoreByteAtDEPlusC_BankA0::
Func_0A0_429C:: ; address name
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0A0_42A2
    inc d

Jump_0A0_42A2::
    ld a, [hl+]
    ld [de], a
    ret

; DE += 2 * C; copies the word at HL to [DE]; HL += 2, DE ends on the second byte written (the same 13 bytes appear in 2 banks)
; 22 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_Sub01, RunA04410Or456FBySlotC_Sub02)
StoreWordAtDEPlus2C_BankA0::
Func_0A0_42A5:: ; address name
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0A0_42AC
    inc d

Jump_0A0_42AC::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

; copies the 20 x 18 screen tile buffer to the BG map at HL (32-byte rows) (E-0124)
; 3 call sites from 3 routines (e.g. GameMode7_Init_Sub01_Sub02, RunBattlePhaseWhenTextIdle_A0_Case03_Case05, RunBattlePhaseWhenTextIdle_A0_Case03_Case02)
; points at: wScreenTileBuffer
CopyScreenTileBufferToVRAM_A0::
Func_0A0_42B2:: ; address name
    ld de, wScreenTileBuffer
    ld bc, $1412

Jump_0A0_42B8::
    push bc
    push hl

Jump_0A0_42BA::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A0_42BA
    ld a, $0C
    add a, e
    ld e, a
    jr nc, Jump_0A0_42C9
    inc d

Jump_0A0_42C9::
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0A0_42B8
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01)
; reads: wBattleKind
GameMode7_Init_Sub01_Sub04::
Func_0A0_42D3:: ; address name
    ld a, [wBattleKind]
    or a, a
    jr nz, Jump_0A0_42DD
    ld a, $0F
    jr Jump_0A0_42DF

Jump_0A0_42DD::
    ld a, $13

Jump_0A0_42DF::
    call QueueMusic
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01)
; reads: wLinkRole
; points at: wBattlerRecords, wRecordBufA, wRecordBufB
GameMode7_Init_Sub01_Sub05::
Func_0A0_42E3:: ; address name
    ld de, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0A0_42F8
    ld hl, wRecordBufA
    call GameMode7_Init_Sub01_Sub05_Sub01
    ld hl, wRecordBufB
    jr GameMode7_Init_Sub01_Sub05_Sub01

Jump_0A0_42F8::
    ld hl, wRecordBufB
    call GameMode7_Init_Sub01_Sub05_Sub01
    ld hl, wRecordBufA

; only called from GameMode7_Init_Sub01_Sub05 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode7_Init_Sub01_Sub05)
GameMode7_Init_Sub01_Sub05_Sub01::
Func_0A0_4301:: ; address name
    inc hl
    ld b, $0E
    call CopyBytesDEFromHL_BankA0
    ld a, l
    add a, $25
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $08
    call CopyBytesDEFromHL_BankA0
    xor a, a
    ld [de], a
    inc de
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $01
    call CopyBytesDEFromHL_BankA0
    inc hl
    ld b, $15
    call CopyBytesDEFromHL_BankA0
    inc hl
    inc hl
    ld b, $1F
    call CopyBytesDEFromHL_BankA0
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [de], a
    inc de
    call ApplyTable4387IncrementsForA0DTo13
    ld a, $FF
    ld [de], a
    inc de
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 5 call sites from 1 routine (e.g. GameMode7_Init_Sub01_Sub05_Sub01)
CopyBytesDEFromHL_BankA0::
Func_0A0_4344:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA0
    ret

; for A in $0D-$13 increments (capped at 3) each byte listed in Data_0A0_4387 row A - $0D, relative to DE (E-0125)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub05_Sub01)
; writes: hTemp0, hTemp1
ApplyTable4387IncrementsForA0DTo13::
Func_0A0_434B:: ; address name
    or a, a
    ret z
    cp a, $0D
    ret c
    cp a, $14
    ret nc
    push af
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    push de
    sub a, $0D
    swap a
    ld de, Data_0A0_4387
    add a, e
    ld e, a
    jr nc, Jump_0A0_4368
    inc d

Jump_0A0_4368::
    ld a, [de]
    cp a, $80
    jr nz, Jump_0A0_436F
    pop de
    ret

Jump_0A0_436F::
    ld l, a
    ld h, $FF
    call IncrementTableByteCappedAt3_BankA0
    inc de
    jr Jump_0A0_4368

; increments the byte at HL + the word hFFC6/hFFC7 unless it is already 3 or more (the bank-$A0 copy of IncrementTableByteCappedAt3) (E-0118)
; 1 call site from 1 routine (e.g. ApplyTable4387IncrementsForA0DTo13)
; reads: hTemp0, hTemp1
IncrementTableByteCappedAt3_BankA0::
Func_0A0_4378:: ; address name
    ldh a, [hTemp0]
    add a, l
    ld l, a
    ldh a, [hTemp1]
    adc a, h
    ld h, a
    ld a, [hl]
    cp a, $03
    ret nc
    inc a
    ld [hl], a
    ret

; address loaded by ApplyTable4387IncrementsForA0DTo13
Data_0A0_4387:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $280387, $70

; runs Func_0A0_4410 for slots 0-3 or Func_0A0_456F for slots 4-7, clears the species record buffer and restores wD868 (E-0122)
; 2 call sites from 2 routines (e.g. GameMode7_Init_Sub01_Sub03, RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub03)
; reads: wBattleArg0
; writes: wBattleArg0
RunA04410Or456FBySlotC::
Func_0A0_43F7:: ; address name
    ld a, [wBattleArg0]
    push af
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_4405
    call RunA04410Or456FBySlotC_Sub01
    jr Jump_0A0_4408

Jump_0A0_4405::
    call RunA04410Or456FBySlotC_Sub02

Jump_0A0_4408::
    call ClearSpeciesRecordBuffer_BankA0
    pop af
    ld [wBattleArg0], a
    ret

; only called from RunA04410Or456FBySlotC (E-0047)
; 1 call site from 1 routine (e.g. RunA04410Or456FBySlotC)
; reads: wLinkRole, wBattleArg0, wLoadSlot
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wSlotLastTactic, wBattleSetupD8, wBattleLevel, wBattleMaxHP, wBattleMaxMP, ...
RunA04410Or456FBySlotC_Sub01::
Func_0A0_4410:: ; address name
    ld a, c
    push bc
    call BattlerRecordAddress_BankA0
    pop bc
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_0A0_4420
    inc d

Jump_0A0_4420::
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, wSlotNameSuffix
    add a, e
    ld e, a
    jr nc, Jump_0A0_4437
    inc d

Jump_0A0_4437::
    ld a, [hl]
    and a, $0F
    ld [de], a
    ld a, c
    ld de, wSlotTactic
    add a, e
    ld e, a
    jr nc, Jump_0A0_4444
    inc d

Jump_0A0_4444::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wSlotLastTactic
    add a, e
    ld e, a
    jr nc, Jump_0A0_4450
    inc d

Jump_0A0_4450::
    ld a, $00
    ld [de], a
    inc hl
    push af
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_4470
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0A0_4488
    ld a, c
    ld de, wBattleSetupD8
    add a, e
    ld e, a
    jr nc, Jump_0A0_446A
    inc d

Jump_0A0_446A::
    pop af
    and a, $03
    ld [de], a
    jr Jump_0A0_4489

Jump_0A0_4470::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_0A0_4488
    ld a, c
    and a, $03
    ld de, wBattleSetupD8
    add a, e
    ld e, a
    jr nc, Jump_0A0_4482
    inc d

Jump_0A0_4482::
    pop af
    and a, $03
    ld [de], a
    jr Jump_0A0_4489

Jump_0A0_4488::
    pop af

Jump_0A0_4489::
    push hl
    push bc
    ld a, [wBattleArg0]
    or a, a
    jr nz, Jump_0A0_4499
    farcall LoadSlotSkillsFromBattlerRecord
    jr Jump_0A0_449F

Jump_0A0_4499::
    farcall SetCFromBattleArg0ThenRun434D

Jump_0A0_449F::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLoadSlot]
    or a, a
    call z, RunA04410Or456FBySlotC_Shared01
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_BankA0
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a, a
    jr z, Jump_0A0_44D2
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0
    jr Jump_0A0_44EA

Jump_0A0_44D2::
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0

Jump_0A0_44EA::
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleWordArray3F
    call StoreWordAtDEPlus2C_BankA0
    ld a, [wLoadSlot]
    or a, a
    jr z, Jump_0A0_452B
    ld a, [wBattleArg0]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wBattleStatus1
    add_a_to_hl
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_0A0_452B
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A0_4543

Jump_0A0_452B::
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotTrait
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_BankA0

Jump_0A0_4543::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
    ld e, a
    jr nc, Jump_0A0_4550
    inc d

Jump_0A0_4550::
    push bc
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRun44C9
    pop bc
    farcall SetSlotAIModeFromINT
    ret

; only called from RunA04410Or456FBySlotC (E-0047)
; 1 call site from 1 routine (e.g. RunA04410Or456FBySlotC)
; reads: wBattleArg0, wLoadSlot
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wBattleLevel, wBattleMaxHP, wBattleMaxMP, wBattleATK, wBattleDEF, ...
RunA04410Or456FBySlotC_Sub02::
Func_0A0_456F:: ; address name
    push bc
    call BattlerRecordAddress_BankA0
    pop bc
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_0A0_457E
    inc d

Jump_0A0_457E::
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, wSlotNameSuffix
    add a, e
    ld e, a
    jr nc, Jump_0A0_4595
    inc d

Jump_0A0_4595::
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, wSlotTactic
    add a, e
    ld e, a
    jr nc, Jump_0A0_45A0
    inc d

Jump_0A0_45A0::
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [wBattleArg0]
    or a, a
    jr nz, Jump_0A0_45B3
    farcall LoadSlotSkillsFromBattlerRecord
    jr Jump_0A0_45B9

Jump_0A0_45B3::
    farcall SetCFromBattleArg0ThenRun434D

Jump_0A0_45B9::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLoadSlot]
    or a, a
    call z, RunA04410Or456FBySlotC_Shared01
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_BankA0
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wLoadSlot]
    or a, a
    jr z, Jump_0A0_45ED
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0
    jr Jump_0A0_4605

Jump_0A0_45ED::
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0

Jump_0A0_4605::
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleWordArray3F
    call StoreWordAtDEPlus2C_BankA0
    ld a, [wLoadSlot]
    or a, a
    jr z, Jump_0A0_4646
    ld a, [wBattleArg0]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wBattleStatus1
    add_a_to_hl
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_0A0_4646
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A0_465E

Jump_0A0_4646::
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotTrait
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_BankA0

Jump_0A0_465E::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
    ld e, a
    jr nc, Jump_0A0_466B
    inc d

Jump_0A0_466B::
    push bc
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRun44C9
    pop bc
    farcall SetSlotAIModeFromINT
    ret

; A = battle slot: for slots 3 and 7 returns at once with Z set and HL unchanged; otherwise HL = wBattlerRecords + $4E * A' with A' = A - 1 for slots 4-6 (as BattlerRecordFieldAddress without the field offset) (E-0067) (the same 23 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_Sub01, RunA04410Or456FBySlotC_Sub02)
BattlerRecordAddress_BankA0::
Func_0A0_468A:: ; address name
    cp a, $03
    jr c, Jump_0A0_4693
    ret z
    cp a, $07
    ret z
    dec a

Jump_0A0_4693::
    ld c, $4E
    call Multiply8
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01)
; points at: wSlotMarks
GameMode7_Init_Sub01_Sub06::
Func_0A0_46A1:: ; address name
    ld bc, $0200
    ld hl, wSlotMarks

Jump_0A0_46A7::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, Jump_0A0_46BB
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_0A0_46B7
    ld [hl], $00
    jr Jump_0A0_46BD

Jump_0A0_46B7::
    ld [hl], $01
    jr Jump_0A0_46BD

Jump_0A0_46BB::
    ld [hl], $FF

Jump_0A0_46BD::
    inc c
    inc hl
    dec b
    jr nz, Jump_0A0_46A7
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case00_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06)
RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub04::
Func_0A0_46C3:: ; address name
    push bc
    call ComputeWildEncounterLevel
    pop bc
    call ApplyLevelScaledStatsToSlots
    ret

; computes the wild monster level wCFE3 and band wCFE4 from the party's stat totals (wD0F2-wD0FE) and size (E-0131)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub04)
; reads: wBattlerRecords, wBattlerRecordSlot1
; writes: wWildLevel, wWildBand
ComputeWildEncounterLevel::
Func_0A0_46CC:: ; address name
    push bc
    ld de, $0000
    ld hl, wBattlerRecords + $27
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $29
    call AddWordAtHLToDE
    srl d
    rr e
    ld hl, wBattlerRecords + $1D
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $21
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $23
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $25
    call AddWordAtHLToDE
    ld h, d
    ld l, e
    ld a, $32
    call DivideHLByA
    push hl
    ld a, [wBattlerRecords + $17]
    ld c, $18
    call Multiply8
    push hl
    ld de, $0000
    ld hl, wBattlerRecords + $1D
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $21
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $23
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $25
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $27
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + $29
    call AddWordAtHLToDE
    pop hl
    ld a, e
    sub a, l
    ld l, a
    ld a, d
    sbc a, h
    ld h, a
    jr nc, Jump_0A0_474D
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    ld a, $32
    call DivideHLByA
    ld a, l
    cpl
    ld l, a
    ld a, h
    cpl
    ld h, a
    inc hl
    jr Jump_0A0_4752

Jump_0A0_474D::
    ld a, $32
    call DivideHLByA

Jump_0A0_4752::
    pop de
    add hl, de
    bit 7, h
    jr z, Jump_0A0_475B
    ld hl, $0000

Jump_0A0_475B::
    ld a, h
    or a, a
    jr nz, Jump_0A0_4764
    ld a, l
    cp a, $64
    jr c, Jump_0A0_4767

Jump_0A0_4764::
    ld hl, $0063

Jump_0A0_4767::
    push hl
    ld de, $0000
    ld hl, wBattlerRecordSlot1 + $27
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $29
    call AddWordAtHLToDE
    srl d
    rr e
    ld hl, wBattlerRecordSlot1 + $1D
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $21
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $23
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $25
    call AddWordAtHLToDE
    ld h, d
    ld l, e
    ld a, $32
    call DivideHLByA
    push hl
    ld a, [wBattlerRecordSlot1 + $17]
    ld c, $18
    call Multiply8
    push hl
    ld de, $0000
    ld hl, wBattlerRecordSlot1 + $1D
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $21
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $23
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $25
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $27
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + $29
    call AddWordAtHLToDE
    pop hl
    ld a, e
    sub a, l
    ld l, a
    ld a, d
    sbc a, h
    ld h, a
    jr nc, Jump_0A0_47E8
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    ld a, $32
    call DivideHLByA
    ld a, h
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    jr Jump_0A0_47ED

Jump_0A0_47E8::
    ld a, $32
    call DivideHLByA

Jump_0A0_47ED::
    pop de
    add hl, de
    bit 7, h
    jr z, Jump_0A0_47F6
    ld hl, $0000

Jump_0A0_47F6::
    ld a, h
    or a, a
    jr nz, Jump_0A0_47FF
    ld a, l
    cp a, $64
    jr c, Jump_0A0_4802

Jump_0A0_47FF::
    ld hl, $0063

Jump_0A0_4802::
    pop bc
    ld a, l
    or a, c
    jr z, Jump_0A0_4816
    ld a, l
    or a, a
    jr z, Jump_0A0_481A
    ld a, c
    or a, a
    jr z, Jump_0A0_481D
    ld a, l
    cp a, c
    jr nc, Jump_0A0_4820
    ld a, c
    jr Jump_0A0_4820

Jump_0A0_4816::
    ld a, $01
    jr Jump_0A0_4820

Jump_0A0_481A::
    ld a, c
    jr Jump_0A0_4820

Jump_0A0_481D::
    ld a, l
    jr Jump_0A0_4820

Jump_0A0_4820::
    ld [wWildLevel], a
    pop bc
    or a, a
    jr z, Jump_0A0_4847
    cp a, $14
    jr c, Jump_0A0_4847
    cp a, $28
    jr c, Jump_0A0_484A
    cp a, $32
    jr c, Jump_0A0_484E
    cp a, $3C
    jr c, Jump_0A0_4852
    cp a, $46
    jr c, Jump_0A0_4856
    cp a, $50
    jr c, Jump_0A0_485A
    cp a, $5A
    jr c, Jump_0A0_485E
    ld a, $07
    jr Jump_0A0_4860

Jump_0A0_4847::
    xor a, a
    jr Jump_0A0_4860

Jump_0A0_484A::
    ld a, $01
    jr Jump_0A0_4860

Jump_0A0_484E::
    ld a, $02
    jr Jump_0A0_4860

Jump_0A0_4852::
    ld a, $03
    jr Jump_0A0_4860

Jump_0A0_4856::
    ld a, $04
    jr Jump_0A0_4860

Jump_0A0_485A::
    ld a, $05
    jr Jump_0A0_4860

Jump_0A0_485E::
    ld a, $06

Jump_0A0_4860::
    ld [wWildBand], a

Jump_0A0_4863::
    push bc
    call PickEncounterMonsterForSlotC
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4863
    ret

; DE += the word at [HL]; HL += 1 (ends on the high byte); clobbers A
; 24 call sites from 1 routine (e.g. ComputeWildEncounterLevel)
AddWordAtHLToDE::
Func_0A0_486D:: ; address name
    ld a, [hl+]
    add a, e
    ld e, a
    ld a, [hl]
    adc a, d
    ld d, a
    ret

; picks a monster for slot C from the band row Data_0A0_6D57 (PickRandomBand0To10, wCFE4) by a weighted roll and stores its id in wCFDD[C] (E-0127)
; 1 call site from 1 routine (e.g. ComputeWildEncounterLevel)
; reads: wWildBand
; points at: wRandomLo, wEncounterMonsters
PickEncounterMonsterForSlotC::
Func_0A0_4874:: ; address name
    push bc
    call PickRandomBand0To10
    add a, a
    add a, a
    add a, a
    add a, a
    ld hl, Data_0A0_6D57
    add_a_to_hl
    ld a, [wWildBand]
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [hl+]
    push hl
    or a, a
    jr z, Jump_0A0_48CC
    ld b, a
    push bc
    ld b, $FF
    call DivideBByA
    ld d, b
    call AdvanceRandom
    pop bc
    ld c, $00
    ld hl, wRandomLo
    ld a, d

Jump_0A0_48A7::
    cp a, [hl]
    jr nc, Jump_0A0_48B3
    add a, d
    jr c, Jump_0A0_48CC
    inc c
    dec b
    jr nz, Jump_0A0_48A7
    jr Jump_0A0_48CC

Jump_0A0_48B3::
    pop hl
    ld a, c
    add a, a
    add_a_to_hl
    pop bc
    ld de, wEncounterMonsters
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0A0_48C6
    inc d

Jump_0A0_48C6::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

Jump_0A0_48CC::
    pop hl
    pop bc
    jr PickEncounterMonsterForSlotC

; draws a random value and returns its band in the 11-entry threshold table Data_0A0_48F5; band 10 is redrawn while wCFE4 < 6 (E-0124)
; 1 call site from 1 routine (e.g. PickEncounterMonsterForSlotC)
; reads: wRandomLo, wWildBand
PickRandomBand0To10::
Func_0A0_48D0:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    ld bc, $0B00
    ld hl, Data_0A0_48F5

Jump_0A0_48DC::
    cp a, [hl]
    jr c, Jump_0A0_48E5
    inc hl
    inc c
    dec b
    jr nz, Jump_0A0_48DC
    dec c

Jump_0A0_48E5::
    ld a, c
    cp a, $0A
    jr nz, Jump_0A0_48F3
    ld a, [wWildBand]
    cp a, $06
    jr nc, Jump_0A0_48F3
    jr PickRandomBand0To10

Jump_0A0_48F3::
    ld a, c
    ret

; address loaded by PickRandomBand0To10
Data_0A0_48F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $19, $32, $4B, $64, $7D, $96, $AF, $C8, $E1, $FA, $FF

; copies battler records 0 and 1 ($4E bytes each, wBattlerRecords and wD123) to wD1BF and wD20D (E-0118)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06)
; points at: wBattlerRecords, wBattlerRecordSlot4, wBattlerRecordSlot1, wBattlerRecordSlot5
BackupBattlerRecords0And1::
Func_0A0_4900:: ; address name
    ld hl, wBattlerRecords
    ld de, wBattlerRecordSlot4
    ld bc, $004E
    call CopyBytes
    ld hl, wBattlerRecordSlot1
    ld de, wBattlerRecordSlot5
    ld bc, $004E
    call CopyBytes
    ret

; hFFC7 = min(4 * wCFE3 / 5 + 5, 99); runs Func_0A0_494F for B slots from C with wD86A = Data_0A0_4B0A[slot] (E-0125)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub04)
; reads: wWildLevel
; writes: hTemp1, wBattleArg2, wBattleArg3
ApplyLevelScaledStatsToSlots::
Func_0A0_4919:: ; address name
    push de
    ld a, [wWildLevel]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, $05
    call DivideHLByA
    ld a, $05
    add a, l
    pop de
    cp a, $64
    jr c, Jump_0A0_4931
    ld a, $63

Jump_0A0_4931::
    ldh [hTemp1], a

Jump_0A0_4933::
    push bc
    ld a, c
    ld hl, Data_0A0_4B0A
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wBattleArg2], a
    ld a, [hl]
    ld [wBattleArg3], a
    call ApplyLevelScaledStatsToSlots_Sub01
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4933
    ret

; only called from ApplyLevelScaledStatsToSlots (E-0047)
; 1 call site from 1 routine (e.g. ApplyLevelScaledStatsToSlots)
; reads: wBattleArg2, wBattleArg3, wSpeciesIdLo, wSpeciesIdHi, wSpeciesRecord, hTemp1
; writes: wBattleArg1, wSpeciesIdLo, wSpeciesIdHi, hTemp0, wBattleArg0
; points at: wEncounterMonsters
ApplyLevelScaledStatsToSlots_Sub01::
Func_0A0_494F:: ; address name
    push bc
    ld a, c
    ld [wBattleArg1], a
    add a, a
    ld hl, wEncounterMonsters
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wBattleArg2]
    add a, $0A
    ld l, a
    ld a, [wBattleArg3]
    adc a, $00
    ld h, a
    ld a, [wSpeciesIdLo]
    ld [hl+], a
    ld a, [wSpeciesIdHi]
    ld [hl+], a
    ld a, [wSpeciesRecord]
    ld [hl+], a
    ld a, [wSpeciesRecord + $1]
    ld [hl+], a
    ld a, [wSpeciesRecord + $8]
    ld [hl+], a
    ld a, [wSpeciesRecord + $9]
    ld [hl+], a
    ld a, [wSpeciesRecord + $A]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld a, [wSpeciesRecord + $C]
    ldh [hTemp0], a
    farcall StatFromGrowthRow
    pop hl
    ld a, $01
    ld [wBattleArg0], a
    call ScaleStatByWildLevelCapped999
    call StoreTemp2WordAtHL_BankA0
    ld a, [wSpeciesRecord + $D]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    ld a, $00
    ld [wBattleArg0], a
    call ScaleStatByWildLevelCapped999
    call StoreTemp2WordAtHL_BankA0
    ld a, [wSpeciesRecord + $E]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + $F]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + $10]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + $11]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, $E7
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call CopyWD01ARecordToHL_BankA0
    ld a, $00
    ld [hl+], a
    ld a, $07
    ld [hl+], a
    call RollRecordField0DState_A0
    farcall CheckSkillsLearnableAtLevel
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a
    pop bc
    ret

; advances the random table (NextTableByte) and stores the new wC5E7 at HL; HL += 1; AF, BC, DE kept apart from A = the byte (E-0067) (the same 16 bytes appear in 2 banks)
; 4 call sites from 1 routine (e.g. ApplyLevelScaledStatsToSlots_Sub01)
; reads: wRandomLo
StoreRandomByteAtHL_BankA0::
Func_0A0_4A45:: ; address name
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    ld [hl+], a
    ret

; the word hFFC8 = hFFC8 * (wCFE3 / 4 + 100) / 100, capped at 999, stored at [HL+] (E-0125)
; 6 call sites from 1 routine (e.g. ApplyLevelScaledStatsToSlots_Sub01)
; reads: hTemp2, hTemp3, wWildLevel
; writes: hTemp2, hTemp3
ScaleStatByWildLevelCapped999::
Func_0A0_4A55:: ; address name
    push af
    push bc
    push de
    push hl
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp3]
    ld b, a
    ld a, [wWildLevel]
    rrca
    rrca
    and a, $3F
    add a, $64
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, e
    or a, a
    jr nz, Jump_0A0_4A83
    ld bc, $03E7
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    bit 7, b
    jr nz, Jump_0A0_4A83
    jr Jump_0A0_4A86

Jump_0A0_4A83::
    ld hl, $03E7

Jump_0A0_4A86::
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    pop de
    pop bc
    pop af
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ret

; stores hFFC8 then hFFC9 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. ApplyLevelScaledStatsToSlots_Sub01)
; reads: hTemp2, hTemp3
StoreTemp2WordAtHL_BankA0::
Func_0A0_4A97:: ; address name
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ret

; copies the 27 ($1B) bytes at wD01A to HL; HL ends past the copy; clobbers A, B, DE (E-0065) (the same 12 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. ApplyLevelScaledStatsToSlots_Sub01)
CopyWD01ARecordToHL_BankA0::
Func_0A0_4A9E:: ; address name
    ld de, wSpeciesRecord + $12
    ld b, $1B

Jump_0A0_4AA3::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_4AA3
    ret

; field $0D of record wD86A: values 1, 2 and others roll with thresholds 2, $80 and $E6 and become 1 or 0 (E-0125)
; 1 call site from 1 routine (e.g. ApplyLevelScaledStatsToSlots_Sub01)
; reads: wBattleArg2, wBattleArg3, wRandomLo
RollRecordField0DState_A0::
Func_0A0_4AAA:: ; address name
    ld a, [wBattleArg2]
    add a, $0D
    ld l, a
    ld a, [wBattleArg3]
    adc a, $00
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_4AE2
    cp a, $01
    jr z, Jump_0A0_4AC6
    cp a, $02
    jr z, Jump_0A0_4ACA
    ld b, $E6
    jr Jump_0A0_4ACC

Jump_0A0_4AC6::
    ld b, $02
    jr Jump_0A0_4ACC

Jump_0A0_4ACA::
    ld b, $80

Jump_0A0_4ACC::
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    cp a, b
    jr c, Jump_0A0_4AE0
    xor a, a
    jr Jump_0A0_4AE2

Jump_0A0_4AE0::
    ld a, $01

Jump_0A0_4AE2::
    ld [hl], a
    ret

; the same 38 bytes as Multiply24By8 (19:4A74)
; no direct call (reached through a table, a jump or a vector)
Multiply24By8_BankA0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 19:4A74; C0
Func_0A0_4AE4:: ; address name
    push af
    push hl
    ld c, e
    call Multiply8
    pop bc
    pop af
    push hl
    push af
    push bc
    ld c, b
    call Multiply8
    pop bc
    pop af
    push hl
    call Multiply8
    pop bc
    ld a, c
    add a, h
    ld h, a
    ld a, b
    adc a, $00
    ld e, a
    pop bc
    ld a, c
    add a, e
    ld e, a
    ld a, b
    adc a, $00
    ld d, a
    ret

; address loaded by ApplyLevelScaledStatsToSlots
Data_0A0_4B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BF, $D1, $0D, $D2, $5B, $D2

; only called from GameMode7_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub02)
; reads: wLinkRole
; writes: wNameGlyphBuf
; points at: wBattlerRecords, wNameGlyphBuf, wBattlerRecordSlot1, wPlayerName, wLinkSeedCopy
GameMode7_Init_Sub01_Sub02_Sub01::
Func_0A0_4B10:: ; address name
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $F0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld hl, wBattlerRecords
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld hl, wBattlerRecordSlot1
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0A0_4B7A
    ld hl, wPlayerName
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld hl, wLinkSeedCopy
    jr Jump_0A0_4B8F

Jump_0A0_4B7A::
    ld hl, wLinkSeedCopy
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld hl, wPlayerName

Jump_0A0_4B8F::
    ld de, wNameGlyphBuf
    ld bc, $0400

Jump_0A0_4B95::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0A0_4BB1
    cp a, $8D
    jr z, Jump_0A0_4BA9
    cp a, $8E
    jr z, Jump_0A0_4BA9
    ld a, c
    cp a, $02
    jr z, Jump_0A0_4BCF
    inc c
    ld a, [hl]

Jump_0A0_4BA9::
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_0A0_4B95
    jr Jump_0A0_4BCF

Jump_0A0_4BB1::
    ld [de], a
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    ld de, vTiles1 + $4B0
    call CopyGlyphTilesToVRAM
    ret

Jump_0A0_4BCF::
    ld a, $F0
    ld [de], a
    push hl
    push bc
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    ld de, vTiles1 + $4B0
    call CopyGlyphTilesToVRAM
    pop bc
    ld a, b
    add a, $06
    ld b, a
    pop hl
    ld de, wNameGlyphBuf

Jump_0A0_4BF9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0A0_4C13
    cp a, $8D
    jr z, Jump_0A0_4C0D
    cp a, $8E
    jr z, Jump_0A0_4C0D
    ld a, c
    cp a, $05
    jr z, Jump_0A0_4C13
    inc c
    ld a, [hl]

Jump_0A0_4C0D::
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_0A0_4BF9

Jump_0A0_4C13::
    ld a, $F0
    ld [de], a
    ld de, vTiles1 + $4B0
    call CopyGlyphTilesToVRAM
    ret

; Fills the $160 bytes at wC278 with $C3; clobbers A, BC, HL (the same 15 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
FillWC278WithC3_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4C1D:: ; address name
    ld hl, wScreenTileBuffer + $E0
    ld bc, $0160

Jump_0A0_4C23::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A0_4C23
    ret

; only called from GameMode7_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub02)
GameMode7_Init_Sub01_Sub02_Sub02::
Func_0A0_4C2C:: ; address name
    ld hl, TileRect_A0_4D37
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ret

; copies rectangle Data_0A0_4DC7 to the screen buffer; unless bit 1 of wC57F is set, writes tiles $DA-$DE at wC1C3 (E-0122)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case04)
; reads: wLinkRole
DrawRect4DC7AndWriteDATiles::
Func_0A0_4C36:: ; address name
    ld hl, TileRect_A0_4DC7
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ld a, [wLinkRole]
    bit 1, a
    ret nz
    ld hl, wScreenTileBuffer + $2B
    ld b, $05
    ld a, $DA

Jump_0A0_4C4C::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0A0_4C4C
    ret

; only called from GameMode7_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub02)
GameMode7_Init_Sub01_Sub02_Sub03::
Func_0A0_4C52:: ; address name
    ld c, $00
    call DrawSlotPanelValues_BankA0
    ld c, $01

; DrawSlotHPDigits_BankA0, DrawSlotMPDigits_BankA0 and DrawSlotStatusMarks_BankA0 for slot C (E-0116)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub02_Sub03)
DrawSlotPanelValues_BankA0::
Func_0A0_4C59:: ; address name
    call DrawSlotHPDigits_BankA0
    call DrawSlotMPDigits_BankA0
    call DrawSlotStatusMarks_BankA0
    ret

; runs BuildAndCopySlotPanel_A0 for slot 0 and falls into it for slot 1 (E-0126)
; no direct call (reached through a table, a jump or a vector)
BuildAndCopySlotPanels0And1_A0:: ; heuristic: follows a terminator; C0
Func_0A0_4C63:: ; address name
    ld c, $00
    call BuildAndCopySlotPanel_A0
    ld c, $01

; runs Func_0A0_6BF0 and 6C22 for slot C and copies its panel row to VRAM (E-0122)
; 1 call site from 1 routine (e.g. BuildAndCopySlotPanels0And1_A0)
BuildAndCopySlotPanel_A0::
Func_0A0_4C6A:: ; address name
    call CopySlotPanelPart6D47ToVRAM
    call CopySlotPanelPart6D4BToVRAM
    call CopySlotPanelRowToVRAM_BankA0
    ret

; copies a 20 x 5 rectangle from wC338 (rows 32 bytes apart) to vBGMap0 + $1A0 (row 13) with CopyRect32StrideToVRAM_BankA0, as DrawWC338RowsToBGMapRow13 does in bank $31 (E-0076)
; 7 call sites from 7 routines (e.g. RunBattleSetup_BankA0_Case00_Case07, RunBattleSetup_BankA0_Case00_Case05, RunBattleSetup_BankA0_Case01_Case16, RunBattleSetup_BankA0_Case01_Case13, ...)
DrawWC338RowsToBGMapRow13_BankA0::
Func_0A0_4C74:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    call CopyRect32StrideToVRAM_BankA0
    ret

; only called from routines of RunBattleSetup_BankA0 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Case00_Case03, RunBattleSetup_BankA0_Case00_Case01)
RunBattleSetup_BankA0_Shared01::
Func_0A0_4C81:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $0E05
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 20 x 11 rectangle from wC278 to vBGMap0 + $E0 (row 7) with CopyRect32StrideToVRAM_BankA0 (E-0116)
; 3 call sites from 3 routines (e.g. RunBattleSetup_BankA0_Case01_Case04, RunBattleSetup_BankA0_Case01_Case03, RunBattleSetup_BankA0_Case01_Case01)
DrawWC278Rect20x11ToBGMapRow7_BankA0::
Func_0A0_4C8E:: ; address name
    ld de, wScreenTileBuffer + $E0
    ld hl, vBGMap0 + $E0
    ld bc, $140B
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies an 11 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9) with CopyRect32StrideToVRAM_BankA0 (E-0111)
; 4 call sites from 4 routines (e.g. RunBattleSetup_BankA0_Case01_Case0C, RunBattleSetup_BankA0_Case01_Case08, RunBattleSetup_BankA0_Case01_Case07, RunBattleSetup_BankA0_Case01_Case05)
DrawWC2B8Rect11x9ToBGMapRow9_BankA0::
Func_0A0_4C9B:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0B09
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 20 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9), then wD868 = 1 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleArg0
DrawWC2B8RowsToBGMapRow9_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CA8:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM_BankA0
    ld a, $01
    ld [wBattleArg0], a
    ret

; copies an 8 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9) (E-0116)
; no direct call (reached through a table, a jump or a vector)
DrawWC2B8LeftToBGMapRow9_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CBA:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 7 x 7 rectangle from wC2F8 to vBGMap0 + $160 (row 11) (E-0116)
; no direct call (reached through a table, a jump or a vector)
DrawWC2F8Rect7x7ToBGMapRow11_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CC7:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0707
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies 7 x 1 from wC2A4 to vBGMap0 + $10C and 20 x 9 from wC2B8 to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0) (E-0118)
; 3 call sites from 3 routines (e.g. RunBattleSetup_BankA0_Case01_Case10, RunBattleSetup_BankA0_Case01_Case0F, RunBattleSetup_BankA0_Case01_Case0D)
DrawWC2A4AndWC2B8Rects_BankA0::
Func_0A0_4CD4:: ; address name
    ld de, wScreenTileBuffer + $10C
    ld hl, vBGMap0 + $10C
    ld bc, $0701
    call CopyRect32StrideToVRAM_BankA0
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 13 x 7 rectangle from wC2F8 to vBGMap0 + $160 (row 11) (E-0116)
; no direct call (reached through a table, a jump or a vector)
DrawWC2F8Rect13x7ToBGMapRow11_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CED:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0D07
    call CopyRect32StrideToVRAM_BankA0
    ret

; the same 28 bytes as CopyRect32StrideToVRAM (31:753F)
; 10 call sites from 9 routines (e.g. DrawWC338RowsToBGMapRow13_BankA0, RunBattleSetup_BankA0_Shared01, DrawWC2A4AndWC2B8Rects_BankA0, DrawWC2B8Rect11x9ToBGMapRow9_BankA0, ...)
CopyRect32StrideToVRAM_BankA0::
Func_0A0_4CFA:: ; address name
    push bc
    push hl

Jump_0A0_4CFC::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A0_4CFC
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub a, b
    add a, e
    ld e, a
    jr nc, Jump_0A0_4D12
    inc d

Jump_0A0_4D12::
    dec c
    jr nz, CopyRect32StrideToVRAM_BankA0
    ret

; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. GameMode7_Init_Sub01_Sub02_Sub02, DrawRect4DC7AndWriteDATiles)
; points at: wScreenTileBuffer
ReadScreenBufferRectHeader_BankA0::
Func_0A0_4D16:: ; address name
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de
    ret

; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0 (E-0065) (the same 18 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. GameMode7_Init_Sub01_Sub02_Sub02, DrawRect4DC7AndWriteDATiles)
CopyRectToStride32_BankA0::
Func_0A0_4D25:: ; address name
    push bc
    push hl

Jump_0A0_4D27::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_4D27
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_BankA0
    ret

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 20 x 7 tiles
TileRect_A0_4D37::
Data_0A0_4D37:: ; address name
    dw $0000 ; entry 0
    db $14, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $B7, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $D5, $D6, $D7, $D8, $D9, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $BA, $B4, $B4, $B4, $B4, $B4, $B5, $B8, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $EB, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $B7, $B0, $B1, $B1, $B1, $B1, $B1, $B6, $EC, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $AF, $C3, $C3, $C3, $B7, $B6, $A4, $A5, $CB, $CC, $CD, $B6, $EA, $AF, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5, $B3, $B4, $B4, $B4, $B4, $B4, $B3, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 20 x 13 tiles
TileRect_A0_4DC7::
Data_0A0_4DC7:: ; address name
    dw $0000 ; entry 0
    db $14, $0D
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $C3, $B7, $B6, $A4, $A5, $CB, $CC, $CD, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $C3, $C3, $C3, $C3, $AF, $FB, $E1, $B7, $B6, $F7, $F8, $F9, $C3, $FA, $AF, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $FC, $FD, $FE, $FF, $00, $AF, $C3, $C3, $B7, $B6, $0E, $0F, $10, $C3, $11, $AF, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $01, $02, $03, $04, $05, $AF, $C3, $C3, $B7, $B6, $12, $13, $14, $C3, $15, $AF, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $06, $07, $08, $09, $C3, $AF, $C3, $C3, $B7, $B6, $16, $17, $18, $C3, $19, $AF, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $B6, $0A, $0B, $0C, $0D, $C3, $AF, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; start-up for wGameMode = 7; forcing this mode on the emulator shows: two monster panels when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case07)
; reads: wSGBActive, wIsCGB
; writes: wSGBPaletteSet, wSGBAttrFile, hScrollX, hScrollXHi, hScrollY, hScrollYHi, rVBK, wTextCursorLo, ...
GameMode7_Init::
Func_0A0_4ECF:: ; address name
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_0A0_4EED
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

Jump_0A0_4EED::
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $C3
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_4F19
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a, a
    call FillBytes
    xor a, a
    ldh [rVBK], a

Jump_0A0_4F19::
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    call GameMode7_Init_Sub01
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $FC
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0B
    jp Jump_000_077A

; per-frame routine for wGameMode = 7
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case07)
; reads: wEffectId, wEffectAnimState
GameMode7_Update::
Func_0A0_4F70:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp a, $FF
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp a, $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

; unless wC52B is set (text busy), runs the routine for wBattlePhase (jump table of four) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_4544_Case01)
; reads: wTextFlags, wBattlePhase
RunBattlePhaseWhenTextIdle_A0::
Func_0A0_4F8E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wBattlePhase]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case01
    dw RunBattlePhaseWhenTextIdle_A0_Case02
    dw RunBattlePhaseWhenTextIdle_A0_Case03

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00::
Jump_0A0_4F9F:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case01
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case02
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case03
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case04
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case05
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case06
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case07
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case08
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case09
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case0A
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case0B
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case0C
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case0D
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case0E
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case0F
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case10
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case11
    dw RunBattlePhaseWhenTextIdle_A0_Case00_Case12

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case00::
Jump_0A0_4FC9:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ld a, $0C
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case01::
Jump_0A0_4FD8:: ; address name
    ld a, [wLinkMessage]
    cp a, $0C
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wRandomHi
; writes: wLinkRecvBuffer, wBattleSetupByte98, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkSendByte, ...
; points at: wBattleStep, wLinkRecvBuffer, wLinkPartnerName
RunBattlePhaseWhenTextIdle_A0_Case00_Case02::
Jump_0A0_4FE7:: ; address name
    ld hl, wBattleStep
    inc [hl]
    ld a, [wRandomLo]
    ld [wLinkRecvBuffer], a
    ld a, [wRandomHi]
    ld [wBattleSetupByte98], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $02
    ld [wLinkBufferCountLo], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkReady
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case03::
Jump_0A0_501D:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case04::
Jump_0A0_5030:: ; address name
    ld hl, wBattleStep
    inc [hl]
    ld a, $03
    ld [wLinkSendByte], a
    ret

; entry 5 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wLinkPartnerName, wLinkPartnerByte1
; writes: wLinkSendByte, wLinkPartnerName, wRandomSeed2Lo, wRandomLo, wLinkPartnerByte1, wRandomSeed2Hi, wRandomHi
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case05::
Jump_0A0_503A:: ; address name
    ld a, [wLinkMessage]
    cp a, $03
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0A0_5055
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    jr Jump_0A0_505D

Jump_0A0_5055::
    ld a, [wLinkPartnerName]
    ld l, a
    ld a, [wLinkPartnerByte1]
    ld h, a

Jump_0A0_505D::
    ld a, l
    ld [wLinkPartnerName], a
    ld [wRandomSeed2Lo], a
    ld [wRandomLo], a
    ld a, h
    ld [wLinkPartnerByte1], a
    ld [wRandomSeed2Hi], a
    ld [wRandomHi], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCountPlusOne
; writes: wEncounterKind, wBattleFoeCount, wSide1Flag
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case06::
Jump_0A0_5076:: ; address name
    call RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub01
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr z, Jump_0A0_5093
    ld a, $02
    ld [wEncounterKind], a
    ld bc, $0300
    call RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub04
    call RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub03
    ld hl, wBattleStep
    inc [hl]
    ret

Jump_0A0_5093::
    ld a, $01
    ld [wEncounterKind], a
    ld a, $02
    ld [wBattleFoeCount], a
    ld a, $02
    ld [wSide1Flag], a
    call BackupBattlerRecords0And1
    call RunBattlePhaseWhenTextIdle_A0_Case00_Case06_Sub02
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScreenCountPlusOne
; writes: wStringIndex, wStringCategory
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case07::
Jump_0A0_50AD:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScreenCountPlusOne]
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePictureIds
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case08::
Jump_0A0_50C8:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePictureIds]
    ld l, a
    ld a, [wBattlePictureIds + $1]
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld a, $03
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattlePictureIds
; writes: hTemp0, wBGPaletteUploadRequest
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case09::
Jump_0A0_50F2:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_5105
    ld de, $0000
    ld hl, vBGMap0 + $E1
    ld a, $01
    ldh [hTemp0], a
    call LoadMonsterPictureAttributes

Jump_0A0_5105::
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld hl, vTiles2 + $140
    ld c, $01
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCountPlusOne, wIsCGB, wBattlePictureIds
; writes: hTemp0
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case0A::
Jump_0A0_511F:: ; address name
    ld hl, vBGMap0 + $E1
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, Jump_0A0_512C
    ld hl, vBGMap0 + $E4

Jump_0A0_512C::
    ld d, $14
    call RunBattlePhaseWhenTextIdle_A0_Shared01
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_5153
    ld hl, vBGMap0 + $E1
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, Jump_0A0_5144
    ld hl, vBGMap0 + $E4

Jump_0A0_5144::
    ld a, $01
    ldh [hTemp0], a
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    call LoadMonsterPictureAttributes

Jump_0A0_5153::
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePictureIds
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case0B::
Jump_0A0_5158:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePictureIds + $2]
    ld l, a
    ld a, [wBattlePictureIds + $3]
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld a, $04
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePictureIds
; writes: wBGPaletteUploadRequest
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case0C::
Jump_0A0_5182:: ; address name
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld hl, vTiles2 + $380
    ld c, $03
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCountPlusOne, wBattleStep, wIsCGB, wBattlePictureIds
; writes: wBattleStep, hTemp0
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case0D::
Jump_0A0_519C:: ; address name
    ld hl, vBGMap0 + $E7
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, Jump_0A0_51B1
    ld a, [wBattleStep]
    add a, $03
    ld [wBattleStep], a
    ld hl, vBGMap0 + $EA

Jump_0A0_51B1::
    ld d, $38
    call RunBattlePhaseWhenTextIdle_A0_Shared01
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_51D8
    ld hl, vBGMap0 + $E7
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, Jump_0A0_51C9
    ld hl, vBGMap0 + $EA

Jump_0A0_51C9::
    ld a, $03
    ldh [hTemp0], a
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    call LoadMonsterPictureAttributes

Jump_0A0_51D8::
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePictureIds
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case0E::
Jump_0A0_51DD:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld a, $05
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePictureIds
; writes: wBGPaletteUploadRequest
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case0F::
Jump_0A0_5207:: ; address name
    ld a, [wBattlePictureIds + $4]
    ld e, a
    ld a, [wBattlePictureIds + $5]
    ld d, a
    ld hl, vTiles2 + $5C0
    ld c, $05
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattlePictureIds
; writes: hTemp0
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case10::
Jump_0A0_5221:: ; address name
    ld d, $5C
    ld hl, vBGMap0 + $ED
    call RunBattlePhaseWhenTextIdle_A0_Shared01
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_5241
    ld hl, vBGMap0 + $ED
    ld a, $05
    ldh [hTemp0], a
    ld a, [wBattlePictureIds + $4]
    ld e, a
    ld a, [wBattlePictureIds + $5]
    ld d, a
    call LoadMonsterPictureAttributes

Jump_0A0_5241::
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wStringCategory, wStringIndex, wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case00_Case11::
Jump_0A0_5246:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $05
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wBattleStep, wLinkSendByte
; points at: wBattlePhase
RunBattlePhaseWhenTextIdle_A0_Case00_Case12::
Jump_0A0_5265:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattlePhase
    inc [hl]
    ret

; only called from routines of RunBattlePhaseWhenTextIdle_A0 (E-0098)
; 3 call sites from 3 routines (e.g. RunBattlePhaseWhenTextIdle_A0_Case00_Case10, RunBattlePhaseWhenTextIdle_A0_Case00_Case0D, RunBattlePhaseWhenTextIdle_A0_Case00_Case0A)
RunBattlePhaseWhenTextIdle_A0_Shared01::
Func_0A0_5278:: ; address name
    ld bc, $0606

Jump_0A0_527B::
    ld a, d
    inc d
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A0_527B
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $06
    dec c
    jr nz, Jump_0A0_527B
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case01::
Jump_0A0_5291:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case01_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case01_Case01
    dw RunBattlePhaseWhenTextIdle_A0_Case01_Case02
    dw RunBattlePhaseWhenTextIdle_A0_Case01_Case03
    dw RunBattlePhaseWhenTextIdle_A0_Case01_Case04

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case01_Case00::
Jump_0A0_529F:: ; address name
    call RunBattlePhaseWhenTextIdle_A0_Case01_Case00_Sub01
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case01
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_Case01_Case01::
Jump_0A0_52A7:: ; address name
    call RunBattleSetup_BankA0
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case01
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_Case01_Case02::
Jump_0A0_52AB:: ; address name
    farcall RunBattleCommandEntry_BankA1
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case01
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_Case01_Case03::
Jump_0A0_52B2:: ; address name
    farcall RunBattleActions
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case01
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_Case01_Case04::
Jump_0A0_52B9:: ; address name
    farcall RunBattleStep4
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02::
Jump_0A0_52C0:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case01
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case02
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case03
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case04
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case05
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case06
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case07
    dw RunBattlePhaseWhenTextIdle_A0_Case02_Case08

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case00::
Jump_0A0_52D6:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkSendByte
; points at: wBattleSlotOut, wLinkPartnerName, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case01::
Jump_0A0_52E0:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wBattleSlotOut
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $08
    ld [wLinkBufferCountLo], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wLinkPartnerByte1, wLinkPartnerName
; writes: wBattleSlotOut, wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case02::
Jump_0A0_530B:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0A0_5320
    ld a, [wLinkPartnerByte1]
    ld [wBattleSlotOut + $1], a
    jr Jump_0A0_5326

Jump_0A0_5320::
    ld a, [wLinkPartnerName]
    ld [wBattleSlotOut], a

Jump_0A0_5326::
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTurn, wLinkRuleTurnLimit, wScreenCountPlusOne
; writes: wLinkRuleTurnLimit, wStringIndex, wStringCategory, wBattleStep
; points at: wBattleSlotOut, wBattleStatus, wBattleStep, wBattlePhase
RunBattlePhaseWhenTextIdle_A0_Case02_Case03::
Jump_0A0_532F:: ; address name
    ld a, [wBattleTurn]
    inc a
    ld b, a
    ld a, [wLinkRuleTurnLimit]
    add a, b
    cp a, $64
    jr c, Jump_0A0_533E
    ld a, $63

Jump_0A0_533E::
    ld [wLinkRuleTurnLimit], a
    ld hl, wBattleSlotOut
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A0_5356
    ld a, $00
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr z, Jump_0A0_536B

Jump_0A0_5356::
    ld hl, wBattleSlotOut + $1
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A0_5383
    ld a, $01
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, Jump_0A0_5383

Jump_0A0_536B::
    ld a, [wScreenCountPlusOne]
    add a, $06
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

Jump_0A0_5383::
    ld a, $02
    call QueueMusic
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenCountPlusOne
; writes: wScreenCountPlusOne, wStringCategory, wStringIndex, wLinkSendByte, wBattleStep
; points at: wBattleStep, wBattlePhase
RunBattlePhaseWhenTextIdle_A0_Case02_Case04::
Jump_0A0_5391:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jp z, Jump_0A0_5415
    inc a
    ld [wScreenCountPlusOne], a
    farcall RunBattlePhaseWhenTextIdle_A0_Case02_Case04_Sub01
    ld c, $00
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $00
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPart7AC8ToVRAM
    ld c, $00
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPart7ACEToVRAM
    ld c, $01
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $01
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPart7AC8ToVRAM
    ld c, $01
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPart7ACEToVRAM
    ld a, $05
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

Jump_0A0_5415::
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 5 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case05::
Jump_0A0_5422:: ; address name
    ld hl, vBGMap0 + $E1
    ld bc, $1206
    ld de, $000E

Jump_0A0_542B::
    di

Jump_0A0_542C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0A0_542C
    ld [hl], $C3
    ei
    inc hl
    dec b
    jr nz, Jump_0A0_542B
    add hl, de
    ld b, $12
    dec c
    jr nz, Jump_0A0_542B
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, rSTAT
; writes: rVBK
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case06::
Jump_0A0_5444:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_546F
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $E1
    ld bc, $1206
    ld de, $000E

Jump_0A0_5457::
    di

Jump_0A0_5458::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0A0_5458
    ld [hl], $00
    ei
    inc hl
    dec b
    jr nz, Jump_0A0_5457
    add hl, de
    ld b, $12
    dec c
    jr nz, Jump_0A0_5457
    ld a, $00
    ldh [rVBK], a

Jump_0A0_546F::
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case07::
Jump_0A0_5474:: ; address name
    ld hl, wBattleStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 8 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wBattlePhase, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case02_Case08::
Jump_0A0_547E:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wBattlePhase], a
    xor a, a
    ld [wBattleStep], a
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case03_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00)
; reads: wPartyCount
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub01::
Func_0A0_5491:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

Jump_0A0_54A0::
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A0_54D2
    dec de
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_0A0_54A0

Jump_0A0_54D2::
    farcall ClampPartyHPAndMPToMax
    xor a, a
    ld [rRAMG], a
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03::
Jump_0A0_54DD:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case01
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case02
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case03
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case04
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case05
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case06
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case07
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case08
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case09
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case0A

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResultStep, wBattleResultCounter, wLinkRole, wBattleResultDelay
; writes: wBattleKindFlags, wBattleResultByte9B, wBattleResultByte9C, wBattleResultStep, wBattleResultCounter, wSaveStep, wSaveRecordIndex
; points at: wBattleSlotOut, wBattleStatus, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case00::
Jump_0A0_54F7:: ; address name
    ld a, $01
    ld [wBattleKindFlags], a
    ld a, [wBattleResultStep]
    ld l, a
    ld a, [wBattleResultCounter]
    ld h, a
    ld a, l
    ld [wBattleResultByte9B], a
    ld a, h
    ld [wBattleResultByte9C], a
    ld hl, wBattleSlotOut
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    sla a
    or a, c
    ld c, a
    ld hl, wBattleStatus
    ld a, [hl]
    and a, $40
    sra a
    sra a
    or a, c
    ld c, a
    ld hl, wBattleStatus + $9
    ld a, [hl]
    and a, $40
    sra a
    or a, c
    ld c, a
    and a, $03
    cp a, $03
    jr z, Jump_0A0_5568
    ld a, c
    and a, $30
    cp a, $30
    jr z, Jump_0A0_5568
    ld a, c
    and a, $21
    cp a, $21
    jr z, Jump_0A0_5568
    ld a, c
    and a, $12
    cp a, $12
    jr z, Jump_0A0_5568
    ld a, c
    and a, $03
    jr z, Jump_0A0_5560
    ld a, [wLinkRole]
    and a, $02
    rrca
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_5564
    jr Jump_0A0_556C

Jump_0A0_5560::
    ld a, $00
    jr Jump_0A0_556E

Jump_0A0_5564::
    ld a, $01
    jr Jump_0A0_556E

Jump_0A0_5568::
    ld a, $02
    jr Jump_0A0_556E

Jump_0A0_556C::
    ld a, $03

Jump_0A0_556E::
    ld [wBattleResultStep], a
    ld a, [wBattleResultDelay]
    ld [wBattleResultCounter], a
    call RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02
    call RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wBattleStep
    inc [hl]
    call RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep, wBattleResultStep
; writes: wStringIndex, wStringCategory
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case01::
Jump_0A0_558C:: ; address name
    farcall RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01
    ld a, [wSaveStep]
    bit 7, a
    ret z
    farcall SaveGameToSRAMWithChecksum
    ld a, [wBattleResultStep]
    add a, $0F
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenTileBuffer, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case02::
Jump_0A0_55B6:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wScreenTileBuffer
    ld bc, $01A0
    ld a, $C3
    call FillBytes
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case03::
Jump_0A0_55D1:: ; address name
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $2C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0801
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResultStep, wWildLevel, wLinkRuleTurnLimit, wWildBand, wWildByteE5
; writes: wWindowTileBuffer
; points at: wKeyNameBuf, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case04::
Jump_0A0_5622:: ; address name
    call DrawRect4DC7AndWriteDATiles
    ld a, [wBattleResultStep]
    ld hl, Data_0A0_56CA
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, wScreenTileBuffer + $61

Jump_0A0_5637::
    ld [hl], d
    inc d
    inc hl
    dec e
    ld a, e
    cp a, $00
    jr z, Jump_0A0_5647
    cp a, $02
    jr nc, Jump_0A0_5637
    inc hl
    jr Jump_0A0_5637

Jump_0A0_5647::
    ld a, [wWildLevel]
    ld hl, wScreenTileBuffer + $A7
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wLinkRuleTurnLimit]
    ld hl, wScreenTileBuffer + $E7
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wWildBand]
    ld hl, wScreenTileBuffer + $127
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wWildByteE5]
    add a, $20
    ld [wWindowTileBuffer], a
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $71
    call RunBattlePhaseWhenTextIdle_A0_Case03_Case04_Sub01
    ld hl, wBattleStep
    inc [hl]
    ret

; writes A as two digit tiles at HL, with a blank ($C3) for a leading zero (E-0122)
; 3 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case04)
; reads: wDigits
WriteTwoDigitsBlankLeading_A0::
Func_0A0_5678:: ; address name
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_0A0_568B
    ld a, $C3

Jump_0A0_568B::
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ret

; HL = ascending table of thresholds: C = A = the number of leading bytes that are <= A (the index of the first byte above A); HL ends on that byte. The table must contain a byte above A (E-0065) (the same 11 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
CountTableBytesAtOrBelowA_BankA0_5693:: ; heuristic: follows a terminator; C0
Func_0A0_5693:: ; address name
    ld c, $00

Jump_0A0_5695::
    cp a, [hl]
    jr c, Jump_0A0_569C
    inc c
    inc hl
    jr Jump_0A0_5695

Jump_0A0_569C::
    ld a, c
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case03_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case04)
; reads: wDigits
RunBattlePhaseWhenTextIdle_A0_Case03_Case04_Sub01::
Func_0A0_569E:: ; address name
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow

; writes [DE] (DE += 1) as two digit tiles at HL (no leading zero digit), then HL moves to the next row ($40 on) (E-0124)
; 3 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case04_Sub01)
; reads: wDigits
WriteTwoDigitsFromDEStepRow::
Func_0A0_56A7:: ; address name
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    or a, a
    jr z, Jump_0A0_56BA
    add a, $E0
    ld [hl], a

Jump_0A0_56BA::
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, l
    add a, $3F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case04
Data_0A0_56CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $F7, $04, $0E, $04, $12, $04, $16

; entry 5 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wTextBuf0
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case05::
Jump_0A0_56D2:: ; address name
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wRecordBufA + $1
    ld de, wTextBuf0
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wTextBuf0 + $A], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wBattleSubPhase, wBattleResultStep
; writes: wStringCategory, wStringIndex, wBattleSubPhase
; points at: wBattleStep, wTextBuf2
RunBattlePhaseWhenTextIdle_A0_Case03_Case06::
Jump_0A0_56F7:: ; address name
    ld a, [wWorkBuf + $9]
    cp a, $FF
    jr nz, Jump_0A0_5704
    ld hl, wBattleStep
    inc [hl]
    jr Jump_0A0_5737

Jump_0A0_5704::
    call CopyF0StringFromTable5A4AToTextBuf1
    ld a, [wWorkBuf + $A]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, [wBattleResultStep]
    cp a, $02
    ld a, $14
    jr c, Jump_0A0_571B
    ld a, $15

Jump_0A0_571B::
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleSubPhase
; writes: wStringCategory, wStringIndex, wBattleSubPhase
; points at: wTextBuf2, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case07::
Jump_0A0_5732:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz

Jump_0A0_5737::
    ld a, [wBattleSubPhase]
    call CopyF0StringFromTable5A4AToTextBuf1
    ld a, [wBattleSubPhase]
    ld hl, wWorkBuf + $A
    add_a_to_hl
    ld a, [hl]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, $05
    ld [wStringCategory], a
    ld a, $15
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld a, [wBattleSubPhase]
    inc a
    ld [wBattleSubPhase], a
    cp a, $06
    ret c
    xor a, a
    ld [wBattleSubPhase], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wWorkBuf, wBattleResultStep
; writes: hTemp0, hTemp1, hTemp2, wStringCategory, wStringIndex, wBattleSubPhase, wLinkSendByte
; points at: wTextBuf2, wBattleStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case08::
Jump_0A0_5772:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wWorkBuf + $10]
    ldh [hTemp0], a
    ld a, [wWorkBuf + $11]
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a
    ld hl, wTextBuf2
    call WriteNumber24AsDecimalString
    ld a, $05
    ld [wStringCategory], a
    ld a, $16
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ld a, [wBattleResultStep]
    cp a, $01
    ret z
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_Case03_Case09::
Jump_0A0_57B1:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case01

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case00::
Jump_0A0_57B9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wRecordBufB
; writes: wBattleScene, wLinkRules, wRecordBufB, wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wScreenState, ...
; points at: wRecordBufA, wRecordBufB, wModeChangeRequest, wBGFillFlag
RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case01::
Jump_0A0_57C8:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, $08
    ld [wBattleScene], a
    ld a, $01
    ld [wLinkRules + $9], a
    ld hl, wRecordBufA
    ld de, wRecordBufB
    ld bc, $00A5
    call CopyBytes
    ld a, $01
    ld [wRecordBufB], a
    ld a, $FF
    ld [wRecordBufB + $1A], a
    ld [wRecordBufB + $1B], a
    ld [wRecordBufB + $1C], a
    ld [wRecordBufB + $1D], a
    ld hl, wRecordBufB + $1E
    call WriteUnknownNamePlaceholder
    ld a, $FF
    ld [wRecordBufB + $28], a
    ld hl, wRecordBufB + $29
    call WriteUnknownNamePlaceholder
    ld a, $FF
    ld [wRecordBufB + $33], a
    call AppendMappedSkillsToWCA67
    xor a, a
    ld [wRecordBufB + $55], a
    ld a, $01
    ld [wRecordBufB + $56], a
    xor a, a
    ld [wRecordBufB + $58], a
    ld [wRecordBufB + $59], a
    ld [wRecordBufB + $5A], a
    ld a, [wRecordBufB + $5D]
    ld l, a
    ld a, [wRecordBufB + $5E]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + $5D], a
    ld a, h
    ld [wRecordBufB + $5E], a
    ld a, l
    ld [wRecordBufB + $5B], a
    ld a, h
    ld [wRecordBufB + $5C], a
    ld a, [wRecordBufB + $61]
    ld l, a
    ld a, [wRecordBufB + $62]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + $61], a
    ld a, h
    ld [wRecordBufB + $62], a
    ld a, l
    ld [wRecordBufB + $5F], a
    ld a, h
    ld [wRecordBufB + $60], a
    ld a, [wRecordBufB + $63]
    ld l, a
    ld a, [wRecordBufB + $64]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + $63], a
    ld a, h
    ld [wRecordBufB + $64], a
    ld a, [wRecordBufB + $65]
    ld l, a
    ld a, [wRecordBufB + $66]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + $65], a
    ld a, h
    ld [wRecordBufB + $66], a
    ld a, [wRecordBufB + $67]
    ld l, a
    ld a, [wRecordBufB + $68]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + $67], a
    ld a, h
    ld [wRecordBufB + $68], a
    ld a, [wRecordBufB + $69]
    ld l, a
    ld a, [wRecordBufB + $6A]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + $69], a
    ld a, h
    ld [wRecordBufB + $6A], a
    xor a, a
    ld [wRecordBufB + $6B], a
    ld [wRecordBufB + $6C], a
    xor a, a
    ld [wRecordBufB + $6D], a
    ld a, $01
    ld [wRecordBufB + $6E], a
    ld hl, wRecordBufB + $8E
    call WriteUnknownNamePlaceholder
    xor a, a
    ld [wRecordBufB + $98], a
    ld hl, wRecordBufB + $99
    call WriteUnknownNamePlaceholder
    xor a, a
    ld [wRecordBufB + $A3], a
    xor a, a
    ld [wRecordBufB + $A4], a
    ld a, $04
    call StartPaletteFade
    ld a, $06
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    xor a, a
    ld [wLinkScreenStep], a
    ret

; HL >>= 2 (arithmetic), and 1 when that leaves 0 (E-0118)
; 6 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case01)
QuarterHLAtLeast1::
Func_0A0_590B:: ; address name
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or a, h
    ret nz
    ld hl, $0001
    ret

; writes '???' ($98 three times, the charmap '?') followed by seven $F0 bytes at HL: a 10-byte name field holding a placeholder (E-0111)
; 4 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case01)
WriteUnknownNamePlaceholder::
Func_0A0_591A:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; appends the eight skills at wCA5F (mapped through the pair list Data_0A0_597A) to the first free slot of wCA67, then clears wCA5F (E-0127)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case09_Case01)
AppendMappedSkillsToWCA67::
Func_0A0_5939:: ; address name
    ld de, wRecordBufB + $3C
    ld b, $19

Jump_0A0_593E::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A0_5948
    inc de
    dec b
    jr nz, Jump_0A0_593E
    ret

Jump_0A0_5948::
    ld b, $08
    ld hl, wRecordBufB + $34

Jump_0A0_594D::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_596E
    push hl
    ld c, a
    ld hl, Data_0A0_597A

Jump_0A0_5957::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_5966
    cp a, c
    jr z, Jump_0A0_5963
    inc hl
    inc hl
    jr Jump_0A0_5957

Jump_0A0_5963::
    inc hl
    ld a, [hl]
    ld c, a

Jump_0A0_5966::
    ld a, c
    ld [de], a
    pop hl
    inc hl
    inc de
    dec b
    jr nz, Jump_0A0_594D

Jump_0A0_596E::
    ld hl, wRecordBufB + $34
    ld b, $08

Jump_0A0_5973::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_5973
    ret

; address loaded by AppendMappedSkillsToWCA67
Data_0A0_597A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28197A, $5A

; entry 10 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_Case03_Case0A::
Jump_0A0_59D4:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case0A_Case00
    dw RunBattlePhaseWhenTextIdle_A0_Case03_Case0A_Case01

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_Case03_Case0A_Case00::
Jump_0A0_59DC:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_Case03_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wScreenState, wLinkSession, wLinkExchangeState, wLinkRole, ...
; points at: wModeChangeRequest
RunBattlePhaseWhenTextIdle_A0_Case03_Case0A_Case01::
Jump_0A0_59EB:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, $04
    call StartPaletteFade
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    xor a, a
    ld [wLinkScreenStep], a
    ret
    db $0A, $14, $1E

; copies the $F0-terminated string at Data_0A0_5A4A[A] to wC140, including the terminator (E-0122)
; 2 call sites from 2 routines (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case07, RunBattlePhaseWhenTextIdle_A0_Case03_Case06)
; points at: wTextBuf1
CopyF0StringFromTable5A4AToTextBuf1::
Func_0A0_5A30:: ; address name
    ld hl, Data_0A0_5A4A
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wTextBuf1

Jump_0A0_5A3F::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0A0_5A48
    ld [de], a
    inc de
    jr Jump_0A0_5A3F

Jump_0A0_5A48::
    ld [de], a
    ret

; address loaded by CopyF0StringFromTable5A4AToTextBuf1
Data_0A0_5A4A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $56, $5A, $59, $5A, $5C, $5A, $60, $5A, $64, $5A, $68, $5A, $11, $19, $F0, $16
    db $19, $F0, $0A, $1D, $14, $F0, $0D, $0E, $0F, $F0, $0A, $10, $15, $F0, $12, $17
    db $1D, $F0

; only called from RunBattlePhaseWhenTextIdle_A0_Case03_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00)
; reads: wBattleResultStep, wLinkRuleTurnLimit, wBattleRewardByte97, wBattleRewardByte98, wWildLevel
; writes: wWorkBuf, wWildBand, wWildByteE5
; points at: wKeyNameBuf
RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02::
Func_0A0_5A6C:: ; address name
    ld a, [wBattleResultStep]
    ld hl, wKeyNameBuf
    add_a_to_hl
    ld a, [hl]
    inc a
    cp a, $64
    jr c, Jump_0A0_5A7F
    ld a, $63

Jump_0A0_5A7F::
    ld [hl], a
    ld a, [wLinkRuleTurnLimit]
    ld hl, Data_0A0_5B25
    call CountTableBytesAtOrBelowA_BankA0
    ld hl, Data_0A0_5B2C
    add_a_to_hl
    push hl
    ld hl, wKeyNameBuf
    ld a, [hl+]
    add a, [hl]
    ld c, a
    ld b, $00
    push bc
    ld a, $0A
    call Multiply8
    pop bc
    ld a, [wBattleRewardByte97]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    ld a, [wBattleRewardByte98]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    call DivideHLByBC
    ld a, l
    ld [wWorkBuf], a
    ld [wWildBand], a
    ld hl, Data_0A0_5B33
    call CountTableBytesAtOrBelowA_BankA0
    ld hl, Data_0A0_5B39
    add_a_to_hl
    ld a, [wWildLevel]
    ld e, a
    ld d, $00
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, Jump_0A0_5ADB
    ld b, $FF

Jump_0A0_5ADB::
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    pop hl
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, Jump_0A0_5AEC
    ld b, $FF

Jump_0A0_5AEC::
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    bit 7, d
    jr z, Jump_0A0_5AFB
    ld de, $0000
    jr Jump_0A0_5B0C

Jump_0A0_5AFB::
    ld a, d
    or a, a
    jr z, Jump_0A0_5B04
    ld de, $0063
    jr Jump_0A0_5B0C

Jump_0A0_5B04::
    ld a, e
    cp a, $64
    jr c, Jump_0A0_5B0C
    ld de, $0063

Jump_0A0_5B0C::
    ld a, e
    ld hl, Data_0A0_5B3F
    call CountTableBytesAtOrBelowA_BankA0
    ld [wWorkBuf + $1], a
    ld [wWildByteE5], a
    ret

; HL = ascending table of thresholds: C = A = the number of leading bytes that are <= A (the index of the first byte above A); HL ends on that byte. The table must contain a byte above A (E-0065) (the same 11 bytes appear in 2 banks)
; 3 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02)
CountTableBytesAtOrBelowA_BankA0::
Func_0A0_5B1A:: ; address name
    ld c, $00

Jump_0A0_5B1C::
    cp a, [hl]
    jr c, Jump_0A0_5B23
    inc c
    inc hl
    jr Jump_0A0_5B1C

Jump_0A0_5B23::
    ld a, c
    ret

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02
Data_0A0_5B25:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $06, $0B, $15, $29, $33, $3D, $FF

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02
Data_0A0_5B2C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $0A, $05, $00, $FB, $F6, $EC

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02
Data_0A0_5B33:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $03, $05, $07, $09, $FF

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02
Data_0A0_5B39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $F6, $FB, $00, $05, $0A

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub02
Data_0A0_5B3F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $28, $32, $3C, $46, $50, $5A, $FF

; only called from RunBattlePhaseWhenTextIdle_A0_Case03_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00)
; reads: wLinkReceivedByte, wBattleResultStep, wWorkBuf, wGoldLo, wGoldMid, wGoldHi
; writes: wWorkBuf, rRAMG, rRAMB, wGoldLo, wGoldMid, wGoldHi
RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03::
Func_0A0_5B47:: ; address name
    ld a, $FF
    ld [wWorkBuf + $9], a
    ld [wWorkBuf + $A], a
    ld [wWorkBuf + $B], a
    ld [wWorkBuf + $C], a
    ld [wWorkBuf + $D], a
    ld [wWorkBuf + $E], a
    ld [wWorkBuf + $F], a
    ld [wWorkBuf + $10], a
    ld [wWorkBuf + $11], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wLinkReceivedByte]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [wBattleResultStep]
    or a, a
    jr z, Jump_0A0_5B85
    cp a, $01
    jr z, Jump_0A0_5B85
    cp a, $02
    jr z, Jump_0A0_5BAE
    jr Jump_0A0_5BCB

Jump_0A0_5B85::
    call OffsetByIndexOfMinOfFiveWords
    push hl
    ld a, [wWorkBuf + $1]
    ld hl, Data_0A0_5D5A
    add_a_to_hl
    ld c, [hl]
    pop hl
    call AddCToWordCappedAt999
    ld a, c
    ld [wWorkBuf + $A], a
    ld a, [wWorkBuf + $1]
    add a, a
    ld hl, Data_0A0_5D6A
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jr Jump_0A0_5C08

Jump_0A0_5BAE::
    call OffsetByIndexOfMaxOfFiveWords
    push hl
    ld a, [wWorkBuf + $1]
    ld hl, Data_0A0_5D62
    add_a_to_hl
    ld c, [hl]
    pop hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $A], a
    ld de, $03E8
    jr Jump_0A0_5C08

Jump_0A0_5BCB::
    push hl
    ld a, [wWorkBuf + $1]
    ld hl, Data_0A0_5D62
    add_a_to_hl
    ld c, [hl]
    pop hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $A], a
    inc hl
    inc hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $B], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $C], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $D], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $E], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $F], a
    ld de, $03E8

Jump_0A0_5C08::
    ld a, e
    ld [wWorkBuf + $10], a
    ld a, d
    ld [wWorkBuf + $11], a
    ld a, [wGoldLo]
    add a, e
    ld l, a
    ld a, [wGoldMid]
    adc a, d
    ld h, a
    ld a, [wGoldHi]
    adc a, $00
    ld e, a
    push hl
    ld a, l
    sub a, $9F
    ld l, a
    ld a, h
    sbc a, $86
    ld h, a
    ld a, e
    sbc a, $01
    jr c, Jump_0A0_5C4A
    or a, h
    or a, l
    jr z, Jump_0A0_5C4A
    ld a, l
    cpl
    ld l, a
    ld a, h
    cpl
    ld h, a
    inc hl
    ld a, l
    ld [wWorkBuf + $10], a
    ld a, h
    ld [wWorkBuf + $11], a
    pop hl
    ld e, $01
    ld h, $86
    ld l, $9F
    jr Jump_0A0_5C4B

Jump_0A0_5C4A::
    pop hl

Jump_0A0_5C4B::
    ld a, l
    ld [wGoldLo], a
    ld a, h
    ld [wGoldMid], a
    ld a, e
    ld [wGoldHi], a
    ld a, [wLinkReceivedByte]
    ld c, $5E
    call SRAMRecordAddress
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld l, [hl]
    ld a, h
    call CompareHLToBC
    pop hl
    jr c, Jump_0A0_5C70
    ld a, b
    ld [hl-], a
    ld [hl], c

Jump_0A0_5C70::
    ld a, [wLinkReceivedByte]
    ld c, $62
    call SRAMRecordAddress
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld a, [hl]
    ld l, a
    ld h, a
    call CompareHLToBC
    pop hl
    jr c, Jump_0A0_5C8A
    ld a, b
    ld [hl-], a
    ld [hl], c

Jump_0A0_5C8A::
    xor a, a
    ld [rRAMG], a
    ret

; the word at HL += C, capped at 999; C becomes the amount actually added (E-0124)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03)
AddCToWordCappedAt999::
Func_0A0_5C8F:: ; address name
    ld a, [hl+]
    add a, c
    ld e, a
    ld a, [hl]
    adc a, $00
    ld d, a
    push de
    ld a, e
    sub a, $E7
    ld e, a
    ld a, d
    sbc a, $03
    jr c, Jump_0A0_5CAD
    or a, e
    jr z, Jump_0A0_5CAD
    ld a, c
    sub a, e
    ld c, a
    pop de
    ld d, $03
    ld e, $E7
    jr Jump_0A0_5CAE

Jump_0A0_5CAD::
    pop de

Jump_0A0_5CAE::
    ld [hl], d
    dec hl
    ld [hl], e
    ret

; the word at HL -= C; results at or below 0 become 1 (B = the amount actually taken) (E-0124)
; 7 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03)
SubtractCFromWordMin1::
Func_0A0_5CB2:: ; address name
    ld b, c
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl-]
    sbc a, $00
    ld d, a
    jr c, Jump_0A0_5CC1
    or a, e
    jr nz, Jump_0A0_5CC8
    jr Jump_0A0_5CC5

Jump_0A0_5CC1::
    ld a, e
    cpl
    inc a
    ld b, a

Jump_0A0_5CC5::
    ld de, $0001

Jump_0A0_5CC8::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ret

; finds the entry with the smallest of five words after HL (ties broken randomly), stores its index in wD0A6 and returns HL + Data_0A0_5D54[index] (E-0122)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03)
; writes: wWorkBuf
OffsetByIndexOfMinOfFiveWords::
Func_0A0_5CCD:: ; address name
    push hl
    ld de, $0000
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    inc hl
    call KeepMinWordEntry
    call KeepMinWordEntry
    call KeepMinWordEntry
    call KeepMinWordEntry
    call KeepMinWordEntry
    ld a, e
    ld [wWorkBuf + $9], a
    ld hl, Data_0A0_5D54
    add_a_to_hl
    ld a, [hl]
    pop hl
    add_a_to_hl
    ret

; next table entry: D += 1; if its word is below BC (or equal and RollChance80Of256 succeeds), BC = word and E = D (E-0122)
; 5 call sites from 1 routine (e.g. OffsetByIndexOfMinOfFiveWords)
KeepMinWordEntry::
Func_0A0_5CF9:: ; address name
    inc hl
    inc d
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call CompareHLToBC
    call z, RollChance80Of256
    jr nc, Jump_0A0_5D0A
    ld b, h
    ld c, l
    ld e, d

Jump_0A0_5D0A::
    pop hl
    ret

; finds the entry with the largest of five words after HL (ties broken randomly), stores its index in wD0A6 and returns HL + Data_0A0_5D54[index] (E-0122)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03)
; writes: wWorkBuf
OffsetByIndexOfMaxOfFiveWords::
Func_0A0_5D0C:: ; address name
    push hl
    ld de, $0000
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    inc hl
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    ld a, e
    ld [wWorkBuf + $9], a
    ld hl, Data_0A0_5D54
    add_a_to_hl
    ld a, [hl]
    pop hl
    add_a_to_hl
    ret

; next table entry: D += 1; if its word is not below BC (equal only when RollChance80Of256 fails), BC = word and E = D (E-0122)
; 5 call sites from 1 routine (e.g. OffsetByIndexOfMaxOfFiveWords)
KeepMaxWordEntry::
Func_0A0_5D38:: ; address name
    inc hl
    inc d
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call CompareHLToBC
    call z, RollChance80Of256
    jr c, Jump_0A0_5D49
    ld b, h
    ld c, l
    ld e, d

Jump_0A0_5D49::
    pop hl
    ret

; AdvanceRandom, then compares wC5E7 with $80: carry (success) half the time (E-0116)
; 2 call sites from 2 routines (e.g. KeepMaxWordEntry, KeepMinWordEntry)
; reads: wRandomLo
RollChance80Of256::
Func_0A0_5D4B:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $80
    ret

; address loaded by OffsetByIndexOfMinOfFiveWords, OffsetByIndexOfMaxOfFiveWords
Data_0A0_5D54:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $04, $06, $08, $0A, $0C

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03
Data_0A0_5D5A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $03, $04, $05, $06, $08, $0A

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03
Data_0A0_5D62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $01, $01, $01, $01, $01, $01

; address loaded by RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub03
Data_0A0_5D6A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03

; only called from RunBattlePhaseWhenTextIdle_A0_Case01_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case01_Case00)
; writes: wBattleFlag92, wBattleFlag93, wMenuState
; points at: wSideControl, wSlotFlags854, wActionQueue, wBattleActionChoice, wSlotMarks, wBattleStep, wBattleStatus3
RunBattlePhaseWhenTextIdle_A0_Case01_Case00_Sub01::
Func_0A0_5D7A:: ; address name
    ld hl, wSideControl
    ld b, $08

Jump_0A0_5D7F::
    set 7, [hl]
    inc hl
    dec b
    jr nz, Jump_0A0_5D7F
    ld hl, wSlotFlags854
    ld bc, $0010
    xor a, a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000A
    xor a, a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld [wBattleFlag92], a
    ld [wBattleFlag93], a
    ld a, $00
    ld [wMenuState], a
    ld bc, $0200
    ld hl, wSlotMarks
    push bc

Jump_0A0_5DB8::
    ld a, [hl+]
    or a, a
    jr nz, Jump_0A0_5DBD
    inc c

Jump_0A0_5DBD::
    dec b
    jr nz, Jump_0A0_5DB8
    ld a, c
    or a, a
    jr nz, Jump_0A0_5DC8
    ld hl, wBattleStep
    inc [hl]

Jump_0A0_5DC8::
    pop bc

Jump_0A0_5DC9::
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_5DF8
    ld e, $01
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_0A0_5DF8
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A0_5DF8
    ld a, [hl+]
    and a, $0C
    jr nz, Jump_0A0_5DF8
    ld a, [hl+]
    and a, $30
    jr nz, Jump_0A0_5DF8
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_0A0_5DF8
    ld e, $00

Jump_0A0_5DF8::
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], e
    inc c
    dec b
    jr nz, Jump_0A0_5DC9
    ret

; the same instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case01_Case01)
; reads: wBattleSubPhase
RunBattleSetup_BankA0::
Func_0A0_5E07:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleSetup_BankA0_Case00
    dw RunBattleSetup_BankA0_Case01
    dw RunBattleSetup_BankA0_Case02
    dw RunBattleSetup_BankA0_Case03
    dw RunBattleSetup_BankA0_Case04
    dw RunBattleSetup_BankA0_Case05
    dw RunBattleSetup_BankA0_Case06
    dw RunBattleSetup_BankA0_Case07
    dw RunBattleSetup_BankA0_Case08
    dw RunBattleSetup_BankA0_Case09
    dw RunBattleSetup_BankA0_Case0A
    dw RunBattleSetup_BankA0_Case0B
    dw RunBattleSetup_BankA0_Case0C

; entry 0 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_BankA0_Case00::
Jump_0A0_5E25:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_BankA0_Case00_Case00
    dw RunBattleSetup_BankA0_Case00_Case01
    dw RunBattleSetup_BankA0_Case00_Case02
    dw RunBattleSetup_BankA0_Case00_Case03
    dw RunBattleSetup_BankA0_Case00_Case04
    dw RunBattleSetup_BankA0_Case00_Case05
    dw RunBattleSetup_BankA0_Case00_Case06
    dw RunBattleSetup_BankA0_Case00_Case07

; entry 0 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case00::
Jump_0A0_5E39:: ; address name
    ld hl, wSideControl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    farcall DrawWC278RowsToBGMapRow7
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    farcall CopyRectRecord73ADToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case01::
Jump_0A0_5E71:: ; address name
    call RunBattleSetup_BankA0_Shared01
    ld hl, Data_0A0_6977
    ld a, [wMenuState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wMenuState, wMenuSubState, wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case02::
Jump_0A0_5E93:: ; address name
    ld de, Data_0A0_6977
    ld hl, wMenuState
    call RunBattleSetup_BankA0_Case00_Case02_Sub01
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_0A0_5EBD
    ld a, $69
    call QueueSoundEffect
    ld hl, wMenuSubState
    ld bc, $0007
    ld a, $00
    call FillBytes
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_0A0_5EBD::
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case03::
Jump_0A0_5EBE:: ; address name
    call RunBattleSetup_BankA0_Shared01
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState, wLinkRole
; writes: wBattleSetupDB, wStringIndex, wStringCategory, wCommandMonster, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep, wSlotMarks
RunBattleSetup_BankA0_Case00_Case04::
Jump_0A0_5EC6:: ; address name
    ld a, [wMenuState]
    and a, $03
    ld [wBattleSetupDB], a
    or a, a
    jr z, Jump_0A0_5EDB
    cp a, $01
    jr z, Jump_0A0_5EEA
    cp a, $02
    jr z, Jump_0A0_5F1C
    jr Jump_0A0_5F20

Jump_0A0_5EDB::
    call RunBattleSetup_BankA0_Case00_Case04_Sub01
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jp Jump_0A0_5F2D

Jump_0A0_5EEA::
    ld a, [wLinkRole]
    rrca
    and a, $01
    ld c, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_5F0D
    ld a, $00
    ld [wStringCategory], a
    ld a, $2D
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_0A0_5F2D

Jump_0A0_5F0D::
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_0A0_5F2D

Jump_0A0_5F1C::
    ld a, $1D
    jr Jump_0A0_5F22

Jump_0A0_5F20::
    ld a, $20

Jump_0A0_5F22::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_0A0_5F2D::
    ret

; only called from RunBattleSetup_BankA0_Case00_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_Case00_Case04)
; reads: wLinkRole
; points at: wBattleActionChoice
RunBattleSetup_BankA0_Case00_Case04_Sub01::
Func_0A0_5F2E:: ; address name
    ld a, [wLinkRole]
    and a, $02
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case05::
Jump_0A0_5F40:: ; address name
    call RunBattleSetup_BankA0_Shared04
    farcall CopyRectRecord7345ToScreenBuffer
    call DrawWC338RowsToBGMapRow13_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case06::
Jump_0A0_5F51:: ; address name
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_BankA0_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_BankA0_Case00_Case07::
Jump_0A0_5F5C:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawWC338RowsToBGMapRow13_BankA0
    farcall CopyRectRecord73ADToScreenBuffer
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_BankA0_Case01::
Jump_0A0_5F76:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_BankA0_Case01_Case00
    dw RunBattleSetup_BankA0_Case01_Case01
    dw RunBattleSetup_BankA0_Case01_Case02
    dw RunBattleSetup_BankA0_Case01_Case03
    dw RunBattleSetup_BankA0_Case01_Case04
    dw RunBattleSetup_BankA0_Case01_Case05
    dw RunBattleSetup_BankA0_Case01_Case06
    dw RunBattleSetup_BankA0_Case01_Case07
    dw RunBattleSetup_BankA0_Case01_Case08
    dw RunBattleSetup_BankA0_Case01_Case09
    dw RunBattleSetup_BankA0_Case01_Case0A
    dw RunBattleSetup_BankA0_Case01_Case0B
    dw RunBattleSetup_BankA0_Case01_Case0C
    dw RunBattleSetup_BankA0_Case01_Case0D
    dw RunBattleSetup_BankA0_Case01_Case0E
    dw RunBattleSetup_BankA0_Case01_Case0F
    dw RunBattleSetup_BankA0_Case01_Case10
    dw RunBattleSetup_BankA0_Case01_Case11
    dw RunBattleSetup_BankA0_Case01_Case12
    dw RunBattleSetup_BankA0_Case01_Case13
    dw RunBattleSetup_BankA0_Case01_Case14
    dw RunBattleSetup_BankA0_Case01_Case08
    dw RunBattleSetup_BankA0_Case01_Case16
    dw RunBattleSetup_BankA0_Case01_Case0A
    dw RunBattleSetup_BankA0_Case01_Case0B

; entry 0 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case00::
Jump_0A0_5FAC:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    ld a, $08
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_BankA0
    xor a, a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    farcall CopyRectRecord747FToScreenBuffer
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable67D2
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandMonster, wMenuSubState
; writes: wMenuSubState, wListLastPageSize
; points at: wBattleSetupD8, wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case01::
Jump_0A0_5FEB:: ; address name
    ld a, [wCommandMonster]
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawWC278Rect20x11ToBGMapRow7_BankA0
    ld hl, Data_0A0_697F
    ld a, [wMenuSubState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSubState
; writes: wBattleArg1, wBattleResolveStep, wBattleSubPhase
; points at: wMenuSubState, wBattleSetupD8, wBattleResolveStep, wBattleActionChoice, wSideControl
RunBattleSetup_BankA0_Case01_Case02::
Jump_0A0_6021:: ; address name
    ld de, Data_0A0_697F
    ld hl, wMenuSubState
    call RunBattleSetup_BankA0_Shared02
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_0A0_6062
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [wMenuSubState]
    and a, $03
    ld [hl], a
    call SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0
    cp a, $03
    jr nz, Jump_0A0_606D
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $00
    ld [wBattleArg1], a
    ret

Jump_0A0_6062::
    bit 1, a
    jr z, Jump_0A0_609F
    ld a, $00
    ld [wBattleArg1], a
    jr Jump_0A0_6095

Jump_0A0_606D::
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a
    jr Jump_0A0_609F

Jump_0A0_6095::
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_0A0_609F::
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_BankA0_Case01_Case03::
Jump_0A0_60A0:: ; address name
    call DrawWC278Rect20x11ToBGMapRow7_BankA0
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster
; writes: wBattleArg1, wStringCategory, wStringIndex, wMenuSelectedMember
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case04::
Jump_0A0_60AC:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC278Rect20x11ToBGMapRow7_BankA0
    xor a, a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6D0
    ld de, $0803
    ld a, $02
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    farcall CopyRectRecord75ABToScreenBuffer
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $142
    call WriteFiveTilesFromTable67D2
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case05::
Jump_0A0_60F3:: ; address name
    call DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    ld hl, Data_0A0_6987
    ld a, [wMenuSelectedMember]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSelectedMember
; writes: wBattleArg1, wBattleResolveStep
; points at: wMenuSelectedMember, wBattleResolveStep, wSideControl, wBattleActionChoice
RunBattleSetup_BankA0_Case01_Case06::
Jump_0A0_6115:: ; address name
    ld de, Data_0A0_6987
    ld hl, wMenuSelectedMember
    call RunBattleSetup_BankA0_Case01_Case06_Sub01
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_0A0_6137
    ld a, $00
    ld [wBattleArg1], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    jp Jump_0A0_61D9

Jump_0A0_6137::
    bit 0, a
    jp z, Jump_0A0_61D9
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    or a, a
    jr z, Jump_0A0_6167
    cp a, $01
    jr z, Jump_0A0_6192
    jr Jump_0A0_61B7

Jump_0A0_6167::
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $C0
    ld [hl+], a
    ld a, [wCommandMonster]
    xor a, $01
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_6185
    ld a, c
    ld [hl], a
    jr Jump_0A0_61CA

Jump_0A0_6185::
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $15
    ld [wBattleResolveStep], a
    jr Jump_0A0_61D9

Jump_0A0_6192::
    call RunBattleSetup_BankA0_Case01_Case06_Sub02
    ld a, d
    or a, a
    jr nz, Jump_0A0_61A6
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr Jump_0A0_61D9

Jump_0A0_61A6::
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    xor a, a
    ld [wBattleArg1], a
    ld a, $0C
    ld [wBattleResolveStep], a
    jr Jump_0A0_61D9

Jump_0A0_61B7::
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $AC
    ld [hl+], a
    ld a, [wCommandMonster]
    ld [hl], a

Jump_0A0_61CA::
    ld a, $01
    ld [wBattleArg1], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_0A0_61D9::
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case07::
Jump_0A0_61DA:: ; address name
    call DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    ld a, [wBattleArg1]
    or a, a
    jr z, Jump_0A0_61E5
    ld a, $14

Jump_0A0_61E5::
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case08::
Jump_0A0_61E9:: ; address name
    call DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case09::
Jump_0A0_61FA:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case16::
Jump_0A0_6212:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $7F
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case0A::
Jump_0A0_622A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case0B::
Jump_0A0_623A:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster, wBattleArg2, wBattleArg3, wCommandCursor, wMenuCursor
; writes: wBattleArg1, wMenuCursor, wCommandCursor, wStringCategory
; points at: wSideControl, wCommandCursor, wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case0C::
Jump_0A0_6243:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    xor a, a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, Data_0A0_697F
    call ShowSkillPageNames_BankA0
    call RunBattleSetup_BankA0_Shared03
    farcall CopyRectRecords7600And7734ToScreenBuffer
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    and a, $03
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_BankA0_Shared05
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuCursor
; writes: wListLastPageSize
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case0D::
Jump_0A0_62A3:: ; address name
    call DrawWC2A4AndWC2B8Rects_BankA0
    ld hl, Data_0A0_697F
    ld a, [wMenuCursor]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call DrawInventoryPageIndicator_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 14 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wRecordBufferData, wCommandMonster, wCommandCursor, wMenuCursor, wRecordBuffer
; writes: wBattleArg1, wStringIndex
; points at: wMenuCursor, wBattleMP, wSideControl, wBattleActionChoice, wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case0E::
Jump_0A0_62CD:: ; address name
    ld de, Data_0A0_697F
    ld hl, wMenuCursor
    call RunBattleSetup_BankA0_Shared02
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_0A0_6354
    ld a, $69
    call QueueSoundEffect
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $14
    ld [wBattleArg1], a
    call LoadSelectedSkillRecord_BankA0
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jp z, Jump_0A0_6373
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp a, $FF
    jr nz, Jump_0A0_6312
    ld c, $01

Jump_0A0_6312::
    xor a, a
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jp nz, Jump_0A0_6387
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_6354::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_0A0_636C
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $04
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_636C::
    call RunBattleSetup_BankA0_Shared03
    call DrawInventoryPageIndicator_BankA0

Jump_0A0_6372::
    ret

Jump_0A0_6373::
    ld a, $25
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_6387::
    ld a, $26
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_0A0_6372

; entry 15 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep, wBattleArg1
RunBattleSetup_BankA0_Case01_Case0F::
Jump_0A0_639B:: ; address name
    call DrawWC2A4AndWC2B8Rects_BankA0
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleArg1], a
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case10::
Jump_0A0_63A9:: ; address name
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawWC2A4AndWC2B8Rects_BankA0
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case11::
Jump_0A0_63BD:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case12::
Jump_0A0_63CF:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_BankA0_Case01_Case13::
Jump_0A0_63DF:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $0C
    ld [wBattleResolveStep], a
    ret

; entry 20 of the `rst $00` table in RunBattleSetup_BankA0_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_BankA0_Case01_Case14::
Jump_0A0_63E8:: ; address name
    xor a, a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
RunBattleSetup_BankA0_Case02::
Jump_0A0_63F2:: ; address name
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wLinkSendByte
; points at: wSlotMarks, wBattleSubPhase
RunBattleSetup_BankA0_Case03::
Jump_0A0_63F3:: ; address name
    ld b, $08
    ld hl, wSlotMarks

Jump_0A0_63F8::
    ld a, [hl]
    or a, a
    jr nz, Jump_0A0_63FE
    ld [hl], $01

Jump_0A0_63FE::
    inc hl
    dec b
    jr nz, Jump_0A0_63F8
    xor a, a
    ld [wBattleActor], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call RunBattleSetup_BankA0_Shared04
    farcall CopyRectRecord7345ToScreenBuffer
    farcall DrawWC278RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wLinkSeedCopy, wTextBuf0, wBattleSubPhase
RunBattleSetup_BankA0_Case04::
Jump_0A0_6424:: ; address name
    ld de, wLinkSeedCopy
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wRandomHi, wLinkRole, wMenuState, wMenuSubState, wSideControl, wBattleActionChoice, wBattleTargetChoice
; writes: wLinkSendByte
; points at: wSlotTactic, wLinkRecvBuffer, wBattleSubPhase
RunBattleSetup_BankA0_Case05::
Jump_0A0_6442:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $F3
    ret z
    ld a, [wRandomHi]
    cp a, $F3
    ret z
    ld a, [wLinkRole]
    rrca
    and a, $01
    ld hl, wSlotTactic
    add_a_to_hl
    ld d, [hl]
    ld hl, wLinkRecvBuffer
    ld a, [wMenuState]
    ld [hl+], a
    ld a, [wMenuSubState]
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, [wRandomLo]
    ld [hl+], a
    ld a, [wRandomHi]
    ld [hl+], a
    ld a, [wSideControl]
    ld [hl+], a
    ld a, [wSideControl + $1]
    ld [hl+], a
    ld a, [wBattleActionChoice]
    ld [hl+], a
    ld a, [wBattleTargetChoice]
    ld [hl+], a
    ld a, [wBattleActionChoice + $2]
    ld [hl+], a
    ld a, [wBattleActionChoice + $3]
    ld [hl+], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkBufferCountHi, wLinkBufferCountLo, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi
; points at: wBattleSubPhase, wLinkRecvBuffer, wLinkPartnerName
RunBattleSetup_BankA0_Case06::
Jump_0A0_6497:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wLinkBufferCountHi], a
    ld a, $0B
    ld [wLinkBufferCountLo], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkReady
; points at: wBattleSubPhase
RunBattleSetup_BankA0_Case07::
Jump_0A0_64C1:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wBattleSetupFlagsLo, wBattleSetupFlagsHi
; writes: wLinkSendByte, wLinkReady, wCommandBytesE9, wCommandByteEA, wSlotTactic, wSideControl, wBattleActionChoice, wMenuState, ...
; points at: wLinkPartnerName, wBattleSubPhase, wMenuState, wSlotTactic, wSlotLastTactic
RunBattleSetup_BankA0_Case08::
Jump_0A0_64D0:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0A0_6513
    ld hl, wLinkPartnerName
    ld a, [hl+]
    ld [wCommandBytesE9], a
    ld a, [hl+]
    ld [wCommandByteEA], a
    ld a, [hl+]
    ld [wSlotTactic + $1], a
    ld a, [wBattleSetupFlagsLo]
    ld [hl+], a
    ld a, [wBattleSetupFlagsHi]
    ld [hl+], a
    inc hl
    ld a, [hl+]
    ld [wSideControl + $1], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wBattleActionChoice + $2], a
    ld a, [hl]
    ld [wBattleActionChoice + $3], a
    ld hl, wSlotTactic + $1
    ld de, wSlotLastTactic + $1
    jr Jump_0A0_6548

Jump_0A0_6513::
    ld hl, wMenuState
    ld a, [hl+]
    ld [wCommandBytesE9], a
    ld a, [hl]
    ld [wCommandByteEA], a
    ld hl, wLinkPartnerName
    ld a, [hl+]
    ld [wMenuState], a
    ld a, [hl+]
    ld [wMenuSubState], a
    ld a, [hl+]
    ld [wSlotTactic], a
    ld a, [hl+]
    ld [wRandomLo], a
    ld a, [hl+]
    ld [wRandomHi], a
    ld a, [hl+]
    ld [wSideControl], a
    inc hl
    ld a, [hl+]
    ld [wBattleActionChoice], a
    ld a, [hl]
    ld [wBattleTargetChoice], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

Jump_0A0_6548::
    ld a, [hl]
    cp a, $03
    jr z, Jump_0A0_654E
    ld [de], a

Jump_0A0_654E::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wRandomSeed2Lo, wRandomHi, wRandomSeed2Hi
; writes: wLinkSendByte, wCounterPtr0Lo
; points at: wBattleSetupFlagsLo, wBattleSubPhase
RunBattleSetup_BankA0_Case09::
Jump_0A0_6553:: ; address name
    ld hl, wBattleSetupFlagsLo
    ld a, [hl+]
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    ld a, [wRandomSeed2Lo]
    cp a, b
    jr nz, Jump_0A0_6578
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp a, b
    ld a, [wRandomSeed2Hi]
    cp a, b
    jr nz, Jump_0A0_6578
    ld a, $22
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a
    jr Jump_0A0_6580

Jump_0A0_6578::
    ld a, $33
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a

Jump_0A0_6580::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wCounterPtr0Hi, wLinkSendByte
; points at: wBattleSubPhase
RunBattleSetup_BankA0_Case0A::
Jump_0A0_6585:: ; address name
    ld a, [wLinkMessage]
    cp a, $22
    jr z, Jump_0A0_6591
    cp a, $33
    jr z, Jump_0A0_6591
    ret

Jump_0A0_6591::
    ld [wCounterPtr0Hi], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wCounterPtr0Lo, wCounterPtr0Hi
; writes: wLinkSendByte, wBattleSubPhase
; points at: wBattleSubPhase
RunBattleSetup_BankA0_Case0B::
Jump_0A0_659D:: ; address name
    ld a, [wCounterPtr0Lo]
    cp a, $22
    jr nz, Jump_0A0_65AD
    ld a, [wCounterPtr0Hi]
    cp a, $22
    jr nz, Jump_0A0_65AD
    jr Jump_0A0_65B3

Jump_0A0_65AD::
    ld a, $05
    ld [wBattleSubPhase], a
    ret

Jump_0A0_65B3::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $02
    ld [wLinkSendByte], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wBattleSubPhase
; points at: wBattleStep
RunBattleSetup_BankA0_Case0C::
Jump_0A0_65BD:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; only called from RunBattleSetup_BankA0_Case00_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_Case00_Case02)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_BankA0_Case00_Case02_Sub01::
Func_0A0_65CF:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_0A0_65E7
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr Jump_0A0_6612

Jump_0A0_65E7::
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_0A0_65FF
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr Jump_0A0_6612

Jump_0A0_65FF::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_0A0_661A
    bit 6, [hl]
    jr z, Jump_0A0_660F
    call ClearBit6AndCursorEntryTile_BankA0
    jr Jump_0A0_6612

Jump_0A0_660F::
    call SetBit6AndBlankEntryTile_BankA0

Jump_0A0_6612::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_0A0_661A::
    ret

; only called from RunBattleSetup_BankA0_Case01_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_Case01_Case06)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_BankA0_Case01_Case06_Sub01::
Func_0A0_661B:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_0A0_6631
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $03
    dec a
    cp a, $FF
    jr nz, Jump_0A0_6644
    ld a, $02
    jr Jump_0A0_6644

Jump_0A0_6631::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_0A0_664F
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $03
    inc a
    cp a, $03
    jr nz, Jump_0A0_6644
    xor a, a

Jump_0A0_6644::
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr Jump_0A0_6662

Jump_0A0_664F::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_0A0_666A
    bit 6, [hl]
    jr z, Jump_0A0_665F
    call ClearBit6AndCursorEntryTile_BankA0
    jr Jump_0A0_6662

Jump_0A0_665F::
    call SetBit6AndBlankEntryTile_BankA0

Jump_0A0_6662::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_0A0_666A::
    ret

; only called from routines of RunBattleSetup_BankA0 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Case01_Case0E, RunBattleSetup_BankA0_Case01_Case02)
; reads: wJoypadPressedRepeat, wCommandCursor, wCommandPageCount, wCommandCursorMax, wFrameCounterLo, wListLastPageSize
; writes: wFrameCounterLo, wCommandCursor
RunBattleSetup_BankA0_Shared02::
Func_0A0_666B:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_0A0_66AF
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, Jump_0A0_6693
    ld a, [wCommandCursorMax]
    or a, a
    jp z, Jump_0A0_6771
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0A0_66A1
    ld a, [wCommandCursorMax]
    jr Jump_0A0_66A1

Jump_0A0_6693::
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0A0_66A1
    ld a, [wListLastPageSize]

Jump_0A0_66A1::
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jp Jump_0A0_6771

Jump_0A0_66AF::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_0A0_66F4
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, Jump_0A0_66D7
    ld a, [wCommandCursorMax]
    or a, a
    jp z, Jump_0A0_6771
    ld b, a
    call SetBit6AndBlankEntryTile_BankA0
    inc b
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_0A0_66E7
    ld a, $00
    jr Jump_0A0_66E7

Jump_0A0_66D7::
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_0A0_66E7
    xor a, a

Jump_0A0_66E7::
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr Jump_0A0_6771

Jump_0A0_66F4::
    ld a, [wCommandPageCount]
    or a, a
    jr z, Jump_0A0_6735
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_0A0_6718
    ld a, [wCommandCursor]
    or a, a
    jr nz, Jump_0A0_670B
    ld a, b
    jr Jump_0A0_670C

Jump_0A0_670B::
    dec a

Jump_0A0_670C::
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_0A0_674A

Jump_0A0_6718::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_0A0_6735
    ld a, [wCommandCursor]
    cp a, b
    jr nz, Jump_0A0_6728
    xor a, a
    jr Jump_0A0_6729

Jump_0A0_6728::
    inc a

Jump_0A0_6729::
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_0A0_674A

Jump_0A0_6735::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_0A0_6779
    bit 6, [hl]
    jr z, Jump_0A0_6745
    call ClearBit6AndCursorEntryTile_BankA0
    jr Jump_0A0_6771

Jump_0A0_6745::
    call SetBit6AndBlankEntryTile_BankA0
    jr Jump_0A0_6771

Jump_0A0_674A::
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [wCommandPageCount]
    ld b, a
    ld a, [wCommandCursor]
    res 7, a
    cp a, b
    jr nz, Jump_0A0_6771
    ld a, [wCommandCursorMax]
    or a, a
    jr nz, Jump_0A0_6762
    xor a, a
    jr Jump_0A0_676E

Jump_0A0_6762::
    ld b, a

Jump_0A0_6763::
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_0A0_676E
    jr c, Jump_0A0_6771
    dec [hl]
    jr Jump_0A0_6763

Jump_0A0_676E::
    set 7, a
    ld [hl], a

Jump_0A0_6771::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_0A0_6779::
    ret

; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 12 call sites from 3 routines (e.g. RunBattleSetup_BankA0_Case00_Case02_Sub01, RunBattleSetup_BankA0_Shared02, RunBattleSetup_BankA0_Case01_Case06_Sub01)
SetBit6AndBlankEntryTile_BankA0::
Func_0A0_677A:: ; address name
    set 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $C3
    call WriteVRAMByte
    pop hl
    ret

; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 9 call sites from 4 routines (e.g. RunBattleSetup_BankA0_Case00_Case02_Sub01, RunBattleSetup_BankA0_Shared03, RunBattleSetup_BankA0_Shared02, RunBattleSetup_BankA0_Case01_Case06_Sub01)
ClearBit6AndCursorEntryTile_BankA0::
Func_0A0_6799:: ; address name
    res 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $BB
    call WriteVRAMByte
    pop hl
    ret

; clears wC46C and writes five consecutive tile numbers starting at Data_0A0_67D2[wCFD4] to HL (E-0122)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Case01_Case04, RunBattleSetup_BankA0_Case01_Case00)
; reads: wCommandMonster
; writes: wMenuSubState
WriteFiveTilesFromTable67D2::
Func_0A0_67B8:: ; address name
    push hl
    ld a, [wCommandMonster]
    ld hl, Data_0A0_67D2
    add_a_to_hl
    xor a, a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

Jump_0A0_67CC::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0A0_67CC
    ret

; address loaded by WriteFiveTilesFromTable67D2
Data_0A0_67D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5

; only called from RunBattleSetup_BankA0_Case01_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_Case01_Case06)
; reads: wCommandMonster
; writes: wBattleArg2, wBattleArg3, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleSkills
RunBattleSetup_BankA0_Case01_Case06_Sub02::
Func_0A0_67D4:: ; address name
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

Jump_0A0_67F0::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_0A0_6806
    or a, a
    jr z, Jump_0A0_6806
    cp a, $A2
    jr c, Jump_0A0_6800
    cp a, $AA
    jr c, Jump_0A0_6801

Jump_0A0_6800::
    inc d

Jump_0A0_6801::
    inc c
    inc hl
    dec b
    jr nz, Jump_0A0_67F0

Jump_0A0_6806::
    ld a, c
    cp a, $05
    ld a, $00
    jr c, Jump_0A0_680E
    inc a

Jump_0A0_680E::
    ld [wCommandPageCount], a
    ld a, c
    or a, a
    jr z, Jump_0A0_681A
    and a, $03
    dec a
    and a, $03

Jump_0A0_681A::
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    ret

; shows the four skill names (category 4) of page wCFD5 of monster wCFD4's skills (wD989 + 16 * wCFD4) in the four tile rows; $FF shows string 0 (E-0121)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Shared03, RunBattleSetup_BankA0_Case01_Case0C)
; reads: wCommandMonster, wCommandCursor
; writes: wStringCategory, wBattleArg2, wBattleArg3
; points at: wBattleSkills
ShowSkillPageNames_BankA0::
Func_0A0_6822:: ; address name
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles16D0_BankA0
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles1760_BankA0
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles17F0_BankA0
    ld a, [hl]
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles2080_BankA0
    ret

; A = 0 (xor a); a two-byte handler stub (E-0111)
; 4 call sites from 1 routine (e.g. ShowSkillPageNames_BankA0)
ReturnZero_6871::
Func_0A0_6871:: ; address name
    xor a, a
    ret

; only called from routines of RunBattleSetup_BankA0 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Case01_Case0E, RunBattleSetup_BankA0_Case01_Case0C)
; reads: wCommandCursor, wMenuCursor, wBattleArg2, wBattleArg3
; writes: wCommandCursor, wMenuCursor, wStringCategory
; points at: wMenuCursor
RunBattleSetup_BankA0_Shared03::
Func_0A0_6873:: ; address name
    ld a, [wCommandCursor]
    bit 7, a
    jr z, Jump_0A0_688D
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuCursor
    call ClearBit6AndCursorEntryTile_BankA0
    call ShowSkillPageNames_BankA0
    ld hl, wMenuCursor
    set 7, [hl]

Jump_0A0_688D::
    ld a, [wMenuCursor]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuCursor], a
    and a, $0F
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_BankA0_Shared05
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1F0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_BankA0 at vTiles1 + $6D0 with size $0901; HL kept (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles16D0_BankA0::
Func_0A0_68CF:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6D0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles1 + $760 with size $0901; HL kept (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles1760_BankA0::
Func_0A0_68DE:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles1 + $7F0 with size $0901; HL kept (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles17F0_BankA0::
Func_0A0_68ED:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7F0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles2 + $80 with size $0901 (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles2080_BankA0::
Func_0A0_68FC:: ; address name
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    ret

; only called from routines of RunBattleSetup_BankA0 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Shared03, RunBattleSetup_BankA0_Case01_Case0C)
; reads: wRecordBufferData, wCommandMonster
; writes: wStringIndex, wRecordBuffer
; points at: wBattleMP
RunBattleSetup_BankA0_Shared05::
Func_0A0_6909:: ; address name
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_BankA0
    pop af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, Jump_0A0_693C
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    jr Jump_0A0_6941

Jump_0A0_693C::
    ld l, a
    ld h, $00
    jr Jump_0A0_6941

Jump_0A0_6941::
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $88
    call WriteDecimalDigitTiles
    ret

; when wCFD7 is non-zero writes tiles $C5, $E0 + (wCFD5 & 7) + 1, $BE, $E0 + wCFD7 + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0121)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Case01_Case0E, RunBattleSetup_BankA0_Case01_Case0D)
; reads: wCommandPageCount, wCommandCursor
DrawInventoryPageIndicator_BankA0::
Func_0A0_694B:: ; address name
    ld a, [wCommandPageCount]
    or a, a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $C5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and a, $07
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $BE
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $C6
    call WriteVRAMByte
    ret

; address loaded by RunBattleSetup_BankA0_Case00_Case01, RunBattleSetup_BankA0_Case00_Case02
Data_0A0_6977:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C1, $01, $01, $02, $C7, $01, $07, $02

; address loaded by RunBattleSetup_BankA0_Case01_Case01, RunBattleSetup_BankA0_Case01_Case02, RunBattleSetup_BankA0_Case01_Case0C, RunBattleSetup_BankA0_Case01_Case0D and 1 more
Data_0A0_697F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $01, $81, $01, $C1, $01, $01, $02

; address loaded by RunBattleSetup_BankA0_Case01_Case05, RunBattleSetup_BankA0_Case01_Case06
Data_0A0_6987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $01, $C1, $01, $01, $02, $C1, $01, $01, $02, $C1, $01, $01, $02, $29, $00
    db $69, $00, $A9, $00, $E9, $00, $2F, $01, $6F, $01

; A = value: stores A in wDA43[wCFD4], and also in wDA4B[wCFD4] unless A is 3 (E-0118)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_Case01_Case02)
; reads: wCommandMonster
; points at: wSlotTactic, wSlotLastTactic
SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0::
Func_0A0_69A1:: ; address name
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; wRecordBuffer = the skill at wD989 + 16 * wCFD4 + 2 * (4 * (wCFD5 & 1) + (wC46E & 3)), wCFED = 0, then far-calls LoadSkillRecord (E-0120) (the same 48 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_Case01_Case0E)
; reads: wMenuCursor, wCommandCursor, wCommandMonster
; writes: wRecordBuffer
; points at: wBattleSkills
LoadSelectedSkillRecord_BankA0::
Func_0A0_69C1:: ; address name
    ld a, [wMenuCursor]
    and a, $03
    ld b, a
    ld a, [wCommandCursor]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; side base = ((wC57F << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A, BC (E-0067) (the same 28 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
CountPresentFoesOfLinkRoleSide_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_69F1:: ; address name
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_0A0_6A00::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_6A08
    inc d
    ld e, c

Jump_0A0_6A08::
    inc c
    dec b
    jr nz, Jump_0A0_6A00
    ret

; side base = (wC57F << 1) & 4: D = how many of its three slots are present; clobbers A, BC (E-0067) (the same 24 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
CountPresentSlotsOfLinkRoleSide_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_6A0D:: ; address name
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld c, a

Jump_0A0_6A19::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_6A20
    inc d

Jump_0A0_6A20::
    inc c
    dec b
    jr nz, Jump_0A0_6A19
    ret

; far-calls RunDebugState_E0 (E-0122)
; no direct call (reached through a table, a jump or a vector)
CallFunc443BInBankE0_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_6A25:: ; address name
    farcall RunDebugState_E0
    ret

; only called from routines of RunBattleSetup_BankA0 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_Case03, RunBattleSetup_BankA0_Case00_Case05)
; reads: rSTAT
RunBattleSetup_BankA0_Shared04::
Func_0A0_6A2C:: ; address name
    ld hl, vTiles1
    ld bc, $0120

Jump_0A0_6A32::
    di

Jump_0A0_6A33::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0A0_6A33
    ld a, $FF
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A0_6A32
    ret

; C = slot 0-2: when the slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1, 4, 5, 6 and 7 that is set (the zero-status path is not read) (E-0111)
; 2 call sites from 2 routines (e.g. DrawSlotPanelValues_BankA0, DrawSlotStatusMarks)
; points at: wBattleStatus
DrawSlotStatusMarks_BankA0::
Func_0A0_6A45:: ; address name
    push bc
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6AA9
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A0_6A95
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_6A7F
    call DrawSlotStatusMarks_BankA0_Sub01
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_BankA0_Sub03
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_BankA0_Sub04
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_BankA0_Sub06
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_BankA0_Sub02
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_BankA0_Sub07
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_BankA0_Sub05
    jr Jump_0A0_6AA9

Jump_0A0_6A7F::
    call DrawSlotLevel_BankA0
    ld a, c
    and a, $03
    ld hl, Data_0A0_6B1A
    add a, a
    add_a_to_hl
    call DerefHL_BankA0
    ld [hl], $C3
    jr Jump_0A0_6AA9

Jump_0A0_6A95::
    call DrawSlotLevel_BankA0
    ld a, c
    and a, $03
    ld hl, Data_0A0_6B1A
    add a, a
    add_a_to_hl
    call DerefHL_BankA0
    ld [hl], $C2

Jump_0A0_6AA9::
    pop bc
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub01::
Func_0A0_6AAB:: ; address name
    push hl
    ld hl, Data_0A0_6B0A
    call ReadWordTableEntryForSlotC_BankA0
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub02::
Func_0A0_6ABB:: ; address name
    push hl
    ld hl, Data_0A0_6B0A
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C0
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub03::
Func_0A0_6AC6:: ; address name
    push hl
    ld hl, Data_0A0_6B12
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C1
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub04::
Func_0A0_6AD1:: ; address name
    push hl
    ld hl, Data_0A0_6B12
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C7
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub05::
Func_0A0_6ADC:: ; address name
    push hl
    ld hl, Data_0A0_6B16
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C8
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub06::
Func_0A0_6AE7:: ; address name
    push hl
    ld hl, Data_0A0_6B0E
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C9
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_Sub07::
Func_0A0_6AF2:: ; address name
    push hl
    ld hl, Data_0A0_6B1A
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $CA
    pop hl
    ret

; the same 13 bytes as ReadWordTableEntryForSlotC (31:778E)
; 7 call sites from 7 routines (e.g. DrawSlotStatusMarks_BankA0_Sub05, DrawSlotStatusMarks_BankA0_Sub07, DrawSlotStatusMarks_BankA0_Sub02, DrawSlotStatusMarks_BankA0_Sub06, ...)
ReadWordTableEntryForSlotC_BankA0::
Func_0A0_6AFD:: ; address name
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, DerefHL_BankA0
    inc h

; the same 4 bytes as DerefHL_Bank31 (31:7797)
; 2 call sites from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DerefHL_BankA0::
Func_0A0_6B06:: ; address name
    deref_hl
    ret

; address loaded by DrawSlotStatusMarks_BankA0_Sub01, DrawSlotStatusMarks_BankA0_Sub02
Data_0A0_6B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $39, $C2, $46, $C2

; address loaded by DrawSlotStatusMarks_BankA0_Sub06
Data_0A0_6B0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $C2, $47, $C2

; address loaded by DrawSlotStatusMarks_BankA0_Sub03, DrawSlotStatusMarks_BankA0_Sub04
Data_0A0_6B12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3B, $C2, $48, $C2

; address loaded by DrawSlotStatusMarks_BankA0_Sub05
Data_0A0_6B16:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $C2, $49, $C2

; address loaded by DrawSlotStatusMarks_BankA0, DrawSlotStatusMarks_BankA0_Sub07
Data_0A0_6B1A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3D, $C2, $4A, $C2

; C = slot 0-2: copies the 5-tile panel row at Data_0A0_6D53's offset from wScreenTileBuffer to vBGMap0 (the wC58A = 2 form of CopySlotPanelRowToVRAM) (E-0111)
; 2 call sites from 2 routines (e.g. BuildAndCopySlotPanel_A0, CopySlotPanelRowToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelRowToVRAM_BankA0::
Func_0A0_6B1E:: ; address name
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6B45
    ld hl, Data_0A0_6D53
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld b, $05

Jump_0A0_6B3D::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A0_6B3D

Jump_0A0_6B45::
    ret

; C = slot 0-2: writes the slot's HP as decimal digit tiles into wScreenTileBuffer at the position from Data_0A0_6D47 (the wC58A = 2 form of DrawSlotHPDigits) (E-0111)
; 2 call sites from 2 routines (e.g. DrawSlotPanelValues_BankA0, DrawSlotHPDigits)
; points at: wBattleHP, wScreenTileBuffer
DrawSlotHPDigits_BankA0::
Func_0A0_6B46:: ; address name
    push bc
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6B77
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_0A0_6D47
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

Jump_0A0_6B77::
    pop bc
    ret

; C = slot 0-2: writes the slot's MP as decimal digit tiles into wScreenTileBuffer at the position from Data_0A0_6D4B (the wC58A = 2 form of DrawSlotMPDigits) (E-0111)
; 2 call sites from 2 routines (e.g. DrawSlotPanelValues_BankA0, DrawSlotMPDigits)
; points at: wBattleMP, wScreenTileBuffer
DrawSlotMPDigits_BankA0::
Func_0A0_6B79:: ; address name
    push bc
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6BB1
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6BB1
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_0A0_6D4B
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

Jump_0A0_6BB1::
    pop bc
    ret

; C = slot 0-2: writes tiles $EA, $AF (not in the charmap; probably a level mark) into wScreenTileBuffer at the position from Data_0A0_6D4F, then the value wD8B7[slot] as digits (probably the level; the digit part is not read to its end) (E-0111)
; 3 call sites from 2 routines (e.g. DrawSlotStatusMarks_BankA0, DrawSlotStatusMarks_Sub08)
; points at: wScreenTileBuffer, wBattleLevel
DrawSlotLevel_BankA0::
Func_0A0_6BB3:: ; address name
    push bc
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6BEE
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6BEE
    ld a, c
    and a, $03
    ld hl, Data_0A0_6D4F
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
    inc hl
    push hl
    ld a, c
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    pop de
    call WriteTwoDigitTilesFromWC8C1

Jump_0A0_6BEE::
    pop bc
    ret

; for slots 0-2: copies three tiles at offset Data_0A0_6D47[slot] from the screen buffer to vBGMap0 (E-0124)
; 2 call sites from 2 routines (e.g. BuildAndCopySlotPanel_A0, CopySlotPanelPart7AC8ToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelPart6D47ToVRAM::
Func_0A0_6BF0:: ; address name
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C21
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C21
    ld hl, Data_0A0_6D47
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_0A0_6C21::
    ret

; for slots 0-2: copies three tiles at offset Data_0A0_6D4B[slot] from the screen buffer to vBGMap0 (E-0124)
; 2 call sites from 2 routines (e.g. BuildAndCopySlotPanel_A0, CopySlotPanelPart7ACEToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelPart6D4BToVRAM::
Func_0A0_6C22:: ; address name
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C53
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C53
    ld hl, Data_0A0_6D4B
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_0A0_6C53::
    ret

; for slots 0-2: copies two tiles at offset Data_0A0_6D4F[slot] from the screen buffer to vBGMap0 (E-0124)
; 1 call site from 1 routine (e.g. CopySlotPanelPart7AD4ToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelPart6D4FToVRAM:: ; heuristic: follows a terminator; C0
Func_0A0_6C54:: ; address name
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C80
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C80
    ld hl, Data_0A0_6D4F
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_0A0_6C80::
    ret

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes appear in 3 banks)
; 4 call sites from 3 routines (e.g. RunBattleSetup_BankA0_Case00_Case00, RunBattleSetup_BankA0_Case01_Case04, RunBattleSetup_BankA0_Case01_Case00)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtTilesHL_BankA0::
Func_0A0_6C81:: ; address name
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes appear in 2 banks)
; 5 call sites from 5 routines (e.g. RunBattleSetup_BankA0_Shared05, ShowStringAAtTiles2080_BankA0, ShowStringAAtTiles17F0_BankA0, ShowStringAAtTiles1760_BankA0, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_BankA0::
Func_0A0_6CBC:: ; address name
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $282CF7, $50

; address loaded by DrawSlotHPDigits_BankA0, CopySlotPanelPart6D47ToVRAM
Data_0A0_6D47:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $00, $6F, $00

; address loaded by DrawSlotMPDigits_BankA0, CopySlotPanelPart6D4BToVRAM
Data_0A0_6D4B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $00, $8F, $00

; address loaded by DrawSlotLevel_BankA0, CopySlotPanelPart6D4FToVRAM
Data_0A0_6D4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $AE, $00

; address loaded by CopySlotPanelRowToVRAM_BankA0
Data_0A0_6D53:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $AE, $00

; address loaded by PickEncounterMonsterForSlotC
Data_0A0_6D57:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0A0_6E07
    dw Data_0A0_6E0E
    dw Data_0A0_6E17
    dw Data_0A0_6E20
    dw Data_0A0_6E2B
    dw Data_0A0_6E34
    dw Data_0A0_6E3B
    dw Data_0A0_6E3E
    dw Data_0A0_6E43
    dw Data_0A0_6E4A
    dw Data_0A0_6E55
    dw Data_0A0_6E60
    dw Data_0A0_6E69
    dw Data_0A0_6E76
    dw Data_0A0_6E7F
    dw Data_0A0_6E86
    dw Data_0A0_6E89
    dw Data_0A0_6E96
    dw Data_0A0_6EA3
    dw Data_0A0_6EB0
    dw Data_0A0_6EBD
    dw Data_0A0_6EC6
    dw Data_0A0_6ECB
    dw Data_0A0_6ECE
    dw Data_0A0_6ED1
    dw Data_0A0_6ED6
    dw Data_0A0_6EDF
    dw Data_0A0_6EEC
    dw Data_0A0_6EF9
    dw Data_0A0_6F02
    dw Data_0A0_6F07
    dw Data_0A0_6F0C
    dw Data_0A0_6F0F
    dw Data_0A0_6F18
    dw Data_0A0_6F1F
    dw Data_0A0_6F2A
    dw Data_0A0_6F39
    dw Data_0A0_6F3E
    dw Data_0A0_6F43
    dw Data_0A0_6F46
    dw Data_0A0_6F4D
    dw Data_0A0_6F56
    dw Data_0A0_6F5D
    dw Data_0A0_6F68
    dw Data_0A0_6F77
    dw Data_0A0_6F7C
    dw Data_0A0_6F83
    dw Data_0A0_6F86
    dw Data_0A0_6F89
    dw Data_0A0_6F8E
    dw Data_0A0_6F93
    dw Data_0A0_6F9A
    dw Data_0A0_6FA3
    dw Data_0A0_6FB0
    dw Data_0A0_6FC1
    dw Data_0A0_6FCA
    dw Data_0A0_6FCD
    dw Data_0A0_6FD0
    dw Data_0A0_6FD9
    dw Data_0A0_6FEA
    dw Data_0A0_6FF7
    dw Data_0A0_6FFA
    dw Data_0A0_6FFF
    dw Data_0A0_7008
    dw Data_0A0_700B
    dw Data_0A0_7016
    dw Data_0A0_701F
    dw Data_0A0_7026
    dw Data_0A0_7037
    dw Data_0A0_7044
    dw Data_0A0_704D
    dw Data_0A0_7050
    dw Data_0A0_7053
    dw Data_0A0_705A
    dw Data_0A0_7063
    dw Data_0A0_706E
    dw Data_0A0_707B
    dw Data_0A0_7086
    dw Data_0A0_7091
    dw Data_0A0_7098
    dw Data_0A0_709B
    dw Data_0A0_70A8
    dw Data_0A0_70B5
    dw Data_0A0_70C2
    dw Data_0A0_70CF
    dw Data_0A0_70DC
    dw Data_0A0_70EA
    dw Data_0A0_70F7

Data_0A0_6E07:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $05, $00, $0F, $00

Data_0A0_6E0E:: ; heuristic: target of a monotone pointer table; C0
    db $04, $04, $00, $07, $00, $0A, $00, $14, $00

Data_0A0_6E17:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $08, $00, $09, $00, $0B, $00

Data_0A0_6E20:: ; heuristic: target of a monotone pointer table; C0
    db $05, $01, $00, $06, $00, $0C, $00, $0D, $00, $0E, $00

Data_0A0_6E2B:: ; heuristic: target of a monotone pointer table; C0
    db $04, $11, $00, $13, $00, $15, $00, $16, $00

Data_0A0_6E34:: ; heuristic: target of a monotone pointer table; C0
    db $03, $10, $00, $12, $00, $17, $00

Data_0A0_6E3B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $18, $00

Data_0A0_6E3E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $19, $00, $1A, $00

Data_0A0_6E43:: ; heuristic: target of a monotone pointer table; C0
    db $03, $28, $00, $31, $00, $32, $00

Data_0A0_6E4A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $2A, $00, $2E, $00, $34, $00, $36, $00, $39, $00

Data_0A0_6E55:: ; heuristic: target of a monotone pointer table; C0
    db $05, $24, $00, $25, $00, $26, $00, $27, $00, $3A, $00

Data_0A0_6E60:: ; heuristic: target of a monotone pointer table; C0
    db $04, $2B, $00, $2C, $00, $30, $00, $35, $00

Data_0A0_6E69:: ; heuristic: target of a monotone pointer table; C0
    db $06, $29, $00, $2D, $00, $2F, $00, $33, $00, $37, $00, $3B, $00

Data_0A0_6E76:: ; heuristic: target of a monotone pointer table; C0
    db $04, $38, $00, $3D, $00, $3E, $00, $3F, $00

Data_0A0_6E7F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3C, $00, $40, $00, $42, $00

Data_0A0_6E86:: ; heuristic: target of a monotone pointer table; C0
    db $01, $41, $00

Data_0A0_6E89:: ; heuristic: target of a monotone pointer table; C0
    db $06, $48, $00, $49, $00, $4A, $00, $4B, $00, $50, $00, $5B, $00

Data_0A0_6E96:: ; heuristic: target of a monotone pointer table; C0
    db $06, $4D, $00, $4E, $00, $53, $00, $54, $00, $57, $00, $5A, $00

Data_0A0_6EA3:: ; heuristic: target of a monotone pointer table; C0
    db $06, $47, $00, $4F, $00, $51, $00, $52, $00, $58, $00, $59, $00

Data_0A0_6EB0:: ; heuristic: target of a monotone pointer table; C0
    db $06, $55, $00, $56, $00, $5D, $00, $5E, $00, $65, $00, $66, $00

Data_0A0_6EBD:: ; heuristic: target of a monotone pointer table; C0
    db $04, $4C, $00, $5F, $00, $62, $00, $63, $00

Data_0A0_6EC6:: ; heuristic: target of a monotone pointer table; C0
    db $02, $5C, $00, $61, $00

Data_0A0_6ECB:: ; heuristic: target of a monotone pointer table; C0
    db $01, $60, $00

Data_0A0_6ECE:: ; heuristic: target of a monotone pointer table; C0
    db $01, $64, $00

Data_0A0_6ED1:: ; heuristic: target of a monotone pointer table; C0
    db $02, $6A, $00, $73, $00

Data_0A0_6ED6:: ; heuristic: target of a monotone pointer table; C0
    db $04, $6D, $00, $70, $00, $74, $00, $75, $00

Data_0A0_6EDF:: ; heuristic: target of a monotone pointer table; C0
    db $06, $6C, $00, $71, $00, $72, $00, $76, $00, $77, $00, $84, $00

Data_0A0_6EEC:: ; heuristic: target of a monotone pointer table; C0
    db $06, $6B, $00, $6E, $00, $6F, $00, $78, $00, $79, $00, $7A, $00

Data_0A0_6EF9:: ; heuristic: target of a monotone pointer table; C0
    db $04, $7B, $00, $7C, $00, $7D, $00, $80, $00

Data_0A0_6F02:: ; heuristic: target of a monotone pointer table; C0
    db $02, $7E, $00, $7F, $00

Data_0A0_6F07:: ; heuristic: target of a monotone pointer table; C0
    db $02, $81, $00, $83, $00

Data_0A0_6F0C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $82, $00

Data_0A0_6F0F:: ; heuristic: target of a monotone pointer table; C0
    db $04, $91, $00, $93, $00, $95, $00, $A6, $00

Data_0A0_6F18:: ; heuristic: target of a monotone pointer table; C0
    db $03, $8D, $00, $90, $00, $97, $00

Data_0A0_6F1F:: ; heuristic: target of a monotone pointer table; C0
    db $05, $8E, $00, $8F, $00, $92, $00, $96, $00, $98, $00

Data_0A0_6F2A:: ; heuristic: target of a monotone pointer table; C0
    db $07, $94, $00, $99, $00, $9A, $00, $9D, $00, $9E, $00, $9F, $00, $A7, $00

Data_0A0_6F39:: ; heuristic: target of a monotone pointer table; C0
    db $02, $A0, $00, $A1, $00

Data_0A0_6F3E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $9B, $00, $9C, $00

Data_0A0_6F43:: ; heuristic: target of a monotone pointer table; C0
    db $01, $A2, $00

Data_0A0_6F46:: ; heuristic: target of a monotone pointer table; C0
    db $03, $A3, $00, $A4, $00, $A5, $00

Data_0A0_6F4D:: ; heuristic: target of a monotone pointer table; C0
    db $04, $B0, $00, $B5, $00, $B9, $00, $BB, $00

Data_0A0_6F56:: ; heuristic: target of a monotone pointer table; C0
    db $03, $B2, $00, $B3, $00, $BA, $00

Data_0A0_6F5D:: ; heuristic: target of a monotone pointer table; C0
    db $05, $B6, $00, $B7, $00, $B8, $00, $BD, $00, $C2, $00

Data_0A0_6F68:: ; heuristic: target of a monotone pointer table; C0
    db $07, $B1, $00, $B4, $00, $BC, $00, $BE, $00, $BF, $00, $C1, $00, $C9, $00

Data_0A0_6F77:: ; heuristic: target of a monotone pointer table; C0
    db $02, $C0, $00, $C5, $00

Data_0A0_6F7C:: ; heuristic: target of a monotone pointer table; C0
    db $03, $C3, $00, $C4, $00, $C7, $00

Data_0A0_6F83:: ; heuristic: target of a monotone pointer table; C0
    db $01, $C6, $00

Data_0A0_6F86:: ; heuristic: target of a monotone pointer table; C0
    db $01, $C8, $00

Data_0A0_6F89:: ; heuristic: target of a monotone pointer table; C0
    db $02, $D3, $00, $D6, $00

Data_0A0_6F8E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $DC, $00, $DD, $00

Data_0A0_6F93:: ; heuristic: target of a monotone pointer table; C0
    db $03, $D4, $00, $D8, $00, $E1, $00

Data_0A0_6F9A:: ; heuristic: target of a monotone pointer table; C0
    db $04, $D7, $00, $D9, $00, $EA, $00, $EC, $00

Data_0A0_6FA3:: ; heuristic: target of a monotone pointer table; C0
    db $06, $D5, $00, $DA, $00, $DB, $00, $DF, $00, $E2, $00, $E8, $00

Data_0A0_6FB0:: ; heuristic: target of a monotone pointer table; C0
    db $08, $DE, $00, $E0, $00, $E3, $00, $E4, $00, $E5, $00, $E6, $00, $E9, $00, $EB
    db $00

Data_0A0_6FC1:: ; heuristic: target of a monotone pointer table; C0
    db $04, $E7, $00, $ED, $00, $EE, $00, $F0, $00

Data_0A0_6FCA:: ; heuristic: target of a monotone pointer table; C0
    db $01, $EF, $00

Data_0A0_6FCD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $F6, $00

Data_0A0_6FD0:: ; heuristic: target of a monotone pointer table; C0
    db $04, $F9, $00, $00, $01, $04, $01, $05, $01

Data_0A0_6FD9:: ; heuristic: target of a monotone pointer table; C0
    db $08, $F8, $00, $FA, $00, $FD, $00, $FE, $00, $FF, $00, $01, $01, $02, $01, $0F
    db $01

Data_0A0_6FEA:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FB, $00, $FC, $00, $03, $01, $06, $01, $09, $01, $0E, $01

Data_0A0_6FF7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0A, $01

Data_0A0_6FFA:: ; heuristic: target of a monotone pointer table; C0
    db $02, $F7, $00, $0B, $01

Data_0A0_6FFF:: ; heuristic: target of a monotone pointer table; C0
    db $04, $07, $01, $08, $01, $0D, $01, $10, $01

Data_0A0_7008:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $01

Data_0A0_700B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $1B, $01, $1D, $01, $1E, $01, $22, $01, $31, $01

Data_0A0_7016:: ; heuristic: target of a monotone pointer table; C0
    db $04, $19, $01, $1C, $01, $28, $01, $37, $01

Data_0A0_701F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $1A, $01, $21, $01, $27, $01

Data_0A0_7026:: ; heuristic: target of a monotone pointer table; C0
    db $08, $1F, $01, $20, $01, $23, $01, $26, $01, $2B, $01, $2C, $01, $30, $01, $38
    db $01

Data_0A0_7037:: ; heuristic: target of a monotone pointer table; C0
    db $06, $24, $01, $29, $01, $2F, $01, $32, $01, $33, $01, $34, $01

Data_0A0_7044:: ; heuristic: target of a monotone pointer table; C0
    db $04, $25, $01, $2A, $01, $2D, $01, $2E, $01

Data_0A0_704D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $35, $01

Data_0A0_7050:: ; heuristic: target of a monotone pointer table; C0
    db $01, $36, $01

Data_0A0_7053:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3C, $01, $3D, $01, $44, $01

Data_0A0_705A:: ; heuristic: target of a monotone pointer table; C0
    db $04, $43, $01, $49, $01, $4D, $01, $5B, $01

Data_0A0_7063:: ; heuristic: target of a monotone pointer table; C0
    db $05, $40, $01, $41, $01, $45, $01, $4C, $01, $5A, $01

Data_0A0_706E:: ; heuristic: target of a monotone pointer table; C0
    db $06, $3E, $01, $3F, $01, $42, $01, $46, $01, $47, $01, $4A, $01

Data_0A0_707B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $48, $01, $4B, $01, $4E, $01, $4F, $01, $50, $01

Data_0A0_7086:: ; heuristic: target of a monotone pointer table; C0
    db $05, $51, $01, $52, $01, $54, $01, $55, $01, $57, $01

Data_0A0_7091:: ; heuristic: target of a monotone pointer table; C0
    db $03, $53, $01, $56, $01, $58, $01

Data_0A0_7098:: ; heuristic: target of a monotone pointer table; C0
    db $01, $59, $01

Data_0A0_709B:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70A8:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70B5:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70C2:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70CF:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70DC:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01, $06

Data_0A0_70EA:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70F7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $60, $01, $61, $01, $63, $01, $64, $01, $66, $01, $67, $01, $68, $01, $69
    db $01, $6C, $01, $6E, $01, $6F, $01, $70, $01, $71, $01, $72, $01, $73, $01, $74
    db $01
    ds $EE8, $00
