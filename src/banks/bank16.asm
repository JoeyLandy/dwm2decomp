SECTION "Bank 16", ROMX[$4000], BANK[$16]
    db $16, $F0, $C6, $CD, $92, $4A, $C9

; wItemId (wD081) = item id: copies the 13-byte ItemTable record to wItemRecord (wD084)
; 4 call sites from 4 routines (e.g. PauseMenu_Items_Case00_Case01, LoadSelectedInventoryItemRecord, RunBattleActions_Case08_Sub01_Case0B, PauseMenu_State4_Sub02_Case00_Case01)
; reads: wItemId
; points at: wItemRecord
LoadItemRecord::
Func_016_4007:: ; address name
    ld de, wItemRecord
    push de
    ld a, [wItemId]
    ld c, $0D
    call Multiply8
    ld a, l
    add a, $C2
    ld l, a
    ld a, h
    adc a, $4C
    ld h, a
    pop de
    ld b, $0D

Jump_016_401E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_401E
    ret

; returns when wItemId is $FF; otherwise jumps through a table with one usability check per item id (a check refuses by setting wItemId = $FF; ApplyItemEffect then performs the use, E-0089) (most entries are the shared Jump_016_462F; for example Func_016_40F6 refuses use when the words at save-record offsets $5B and $5D, the monster's current and maximum HP, are equal)
; 3 call sites from 3 routines (e.g. PauseMenu_Items_Case02_Case08, PauseMenu_Items_Case02_Case16, PauseMenu_Items_Case02_ShowButItCouldntBe)
; reads: wItemId
CheckItemUsable::
Func_016_4025:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld a, [wItemId]
    rst $00
    dw ItemUsable_Item00
    dw ItemUsable_Herb
    dw ItemUsable_Herb
    dw ItemUsable_WorldDew
    dw ItemUsable_Potion
    dw ItemUsable_Potion
    dw ItemUsable_Antidote
    dw ItemUsable_MoonHerb
    dw ItemUsable_Laurel
    dw ItemUsable_AwakeSand
    dw ItemUsable_SkyBell
    dw ItemUsable_WorldDew
    dw ItemUsable_WorldLeaf
    dw ItemUsable_ATKseed
    dw ItemUsable_DEFseed
    dw ItemUsable_AGLseed
    dw ItemUsable_INTseed
    dw ItemUsable_LifeAcorn
    dw ItemUsable_MysticNut
    dw ItemUsable_Quest
    dw ItemUsable_Horror
    dw ItemUsable_BeNice
    dw ItemUsable_Cheater
    dw ItemUsable_Smart
    dw ItemUsable_Comedy
    dw ItemUsable_BeefJerky
    dw ItemUsable_BeefJerky
    dw ItemUsable_BeefJerky
    dw ItemUsable_BeefJerky
    dw ItemUsable_BeefJerky
    dw ItemUsable_BeefJerky
    dw ItemUsable_BeastTail
    dw ItemUsable_Repellent
    dw ItemUsable_Repellent
    dw ItemUsable_Mist
    dw ItemUsable_Mist
    dw ItemUsable_Mist
    dw ItemUsable_Mist
    dw ItemUsable_Mist
    dw ItemUsable_Mist
    dw ItemUsable_Warp
    dw ItemUsable_WarpWing
    dw ItemUsable_ExitBell
    dw ItemUsable_Mist
    dw ItemUsable_TinyMedal
    dw ItemUsable_TinyMedal
    dw ItemUsable_LogTwig
    dw ItemUsable_Item2F
    dw ItemUsable_WaterCall
    dw ItemUsable_MoonRock
    dw ItemUsable_Crest
    dw ItemUsable_YunaSoul
    dw ItemUsable_SleepHerb
    dw ItemUsable_Change
    dw ItemUsable_WarpWing
    dw ItemUsable_HarMirror
    dw ItemUsable_HarMirror
    dw ItemUsable_Heaven
    dw ItemUsable_Heaven
    dw ItemUsable_Heaven
    dw ItemUsable_Heaven
    dw ItemUsable_Heaven
    dw ItemUsable_Accessory
    dw ItemUsable_Accessory
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt
    dw ItemUsable_VITbelt

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 0 (no name); item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_Item00::
Jump_016_40F5:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 1 Herb, 2 LoveWater; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Herb)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Herb::
Func_016_40F6:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 3 WorldDew, 11 SageRock; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldDew)
; reads: wPartyCount
; writes: wItemId, wItemRecordByte0A
ItemUsable_WorldDew::
Func_016_4118:: ; address name
    ld a, [wPartyCount]
    or a, a
    jr z, Jump_016_4195
    ld a, $00
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, Jump_016_4141
    ld a, $00
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_016_419B

Jump_016_4141::
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_016_4195
    ld a, $01
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, Jump_016_416B
    ld a, $01
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_016_419B

Jump_016_416B::
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_016_4195
    ld a, $02
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, Jump_016_4195
    ld a, $02
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_016_419B

Jump_016_4195::
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_419B::
    ld d, $00
    ld a, $00
    call ItemUsable_WorldDew_Sub01
    ld a, $01
    call ItemUsable_WorldDew_Sub01
    ld a, $02
    call ItemUsable_WorldDew_Sub01
    ld a, $27
    add a, d
    ld [wItemRecordByte0A], a
    ret

; only called from ItemUsable_WorldDew (E-0047)
; 3 call sites from 1 routine (e.g. ItemUsable_WorldDew)
; reads: wTargetRecord
; writes: wTargetRecord
; points at: wPartyCount, wTextBuf3
ItemUsable_WorldDew_Sub01::
Func_016_41B3:: ; address name
    ld [wTargetRecord], a
    ld hl, wPartyCount
    cp a, [hl]
    ret nc
    push de
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [wTargetRecord]
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    pop de
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret z
    push de
    ld a, d
    swap a
    ld hl, wTextBuf3
    add_a_to_hl
    push hl
    ld a, [wTargetRecord]
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    pop hl
    call CopyFiveGlyphsPlusMarks
    pop de
    inc d
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 4 Potion, 5 ElfWater; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_Case05)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Potion::
Func_016_41FD:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $5F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 6 Antidote; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Antidote)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Antidote::
Func_016_421F:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 2, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 7 MoonHerb; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_MoonHerb::
Jump_016_4234:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 3, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 8 Laurel; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Laurel::
Jump_016_4249:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; when a party member without bit 7 of field $55 has bit 0 set, copies the eligible names to wC160 and wD08E = $32 + their count; otherwise wItemId = $FF (E-0127)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ListPartyMembersWithField55Bit0)
; reads: wPartyCount
; writes: wItemId, wItemRecordByte0A
ListPartyMembersWithField55Bit0::
Func_016_425E:: ; address name
    ld a, [wPartyCount]
    and a, a
    jr z, Jump_016_42A6
    xor a, a
    call CheckRecordFlag55Bit7
    jr nz, Jump_016_4274
    xor a, a
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    jr nz, Jump_016_42AC

Jump_016_4274::
    ld a, [wPartyCount]
    cp a, $02
    jr c, Jump_016_42A6
    ld a, $01
    call CheckRecordFlag55Bit7
    jr nz, Jump_016_428D
    ld a, $01
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    jr nz, Jump_016_42AC

Jump_016_428D::
    ld a, [wPartyCount]
    cp a, $03
    jr c, Jump_016_42A6
    ld a, $02
    call CheckRecordFlag55Bit7
    jr nz, Jump_016_42A6
    ld a, $02
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    jr nz, Jump_016_42AC

Jump_016_42A6::
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_42AC::
    ld d, $00
    ld a, $00
    call CopyEligibleRecordNameToTextBuf3Row
    ld a, $01
    call CopyEligibleRecordNameToTextBuf3Row
    ld a, $02
    call CopyEligibleRecordNameToTextBuf3Row
    ld a, $32
    add a, d
    ld [wItemRecordByte0A], a
    ret

; if record A (< wC6FD) has field $55 bit 7 clear and bit 0 set, copies its name and marks (field 1) to wC160 + 16 * D and increments D (E-0121)
; 3 call sites from 1 routine (e.g. ListPartyMembersWithField55Bit0)
; reads: wTargetRecord
; writes: wTargetRecord
; points at: wPartyCount, wTextBuf3
CopyEligibleRecordNameToTextBuf3Row::
Func_016_42C4:: ; address name
    ld [wTargetRecord], a
    ld hl, wPartyCount
    cp a, [hl]
    ret nc
    push de
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    pop de
    ret z
    push de
    ld a, d
    swap a
    ld hl, wTextBuf3
    add_a_to_hl
    push hl
    ld a, [wTargetRecord]
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    pop hl
    call CopyFiveGlyphsPlusMarks
    pop de
    inc d
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 9 AwakeSand; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_AwakeSand::
Jump_016_4301:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 1, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 10 SkyBell; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_SkyBell::
Jump_016_4316:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 4, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 12 WorldLeaf; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldLeaf)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_WorldLeaf::
Func_016_432B:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 13 ATKseed; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemUsable_ATKseed::
Jump_016_433C:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $63
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 14 DEFseed; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemUsable_DEFseed::
Jump_016_4352:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $65
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 15 AGLseed; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemUsable_AGLseed::
Jump_016_4368:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $67
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 16 INTseed; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemUsable_INTseed::
Jump_016_437E:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $69
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 17 LifeAcorn; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemUsable_LifeAcorn::
Jump_016_4394:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $5D
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 18 MysticNut; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemUsable_MysticNut::
Jump_016_43AA:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $61
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 19 Quest?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Quest::
Jump_016_43C0:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $6F
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 20 Horror?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Horror::
Jump_016_43D6:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $6F
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 21 BeNice?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_BeNice::
Jump_016_43EB:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $70
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 22 Cheater?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Cheater::
Jump_016_4401:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $70
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 23 Smart?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Smart::
Jump_016_4416:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $72
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 24 Comedy?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemId
ItemUsable_Comedy::
Jump_016_442C:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $72
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 25 BeefJerky, 26 PorkChop, 27 Rib, 28 Sirloin, 29 BadMeat, 30 MeteOrb; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_BeefJerky::
Jump_016_4441:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret nz
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 31 BeastTail; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_BeastTail::
Jump_016_4446:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 32 Repellent, 33 ShinyHarp; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case03_Case02_Sub01_Case11, PauseMenu_Skills_Case03_Case02_Sub01_Case0C)
; reads: wEncounterRate
; writes: wItemId
ItemUsable_Repellent::
Func_016_4447:: ; address name
    ld a, [wEncounterRate]
    and a, $7F
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 34 Mist?, 35 Friend?, 36 Wind?, 37 Bolt?, 38 Snow?, 39 Fire?, 43 Bookmark; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_Mist::
Jump_016_4453:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 40 Warp?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_Case12)
ItemUsable_Warp::
Func_016_4454:: ; address name
    call ItemUsable_WarpWing
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 46 LogTwig; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hTempA, hMapId
; writes: wItemId
ItemUsable_LogTwig::
Jump_016_4458:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_016_4469
    cp a, $80
    jr z, Jump_016_449D
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_4469::
    ldh a, [hMapId]
    cp a, $20
    jr z, Jump_016_449D
    cp a, $30
    jr z, Jump_016_449D
    cp a, $48
    jr z, Jump_016_449D
    cp a, $70
    jr z, Jump_016_449D
    cp a, $A0
    jr z, Jump_016_449D
    cp a, $A8
    jr z, Jump_016_449D
    cp a, $B0
    jr z, Jump_016_449D
    cp a, $B8
    jr z, Jump_016_449D
    cp a, $C8
    jr z, Jump_016_449D
    cp a, $D1
    jr z, Jump_016_449D
    cp a, $DA
    jr z, Jump_016_449D
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_449D::
    farcall ItemUsable_LogTwig_Sub01
    ldh a, [hTempA]
    or a, a
    ret nz
    ld a, $FE
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 41 WarpWing, 54 TidalBell; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WarpWing, ItemUsable_Warp)
; reads: wMapType, hMapId
; writes: wItemId
ItemUsable_WarpWing::
Func_016_44AD:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_016_44BD
    cp a, $80
    ret z
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_44BD::
    ldh a, [hMapId]
    ld hl, MapItemUseFlags
    add_a_to_hl
    bit 6, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 42 ExitBell; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_ExitBell)
; reads: wMapType, hMapId
; writes: wItemId
ItemUsable_ExitBell::
Func_016_44D0:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_016_44E6
    cp a, $81
    ret z
    cp a, $85
    ret z
    cp a, $86
    ret z
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_44E6::
    ldh a, [hMapId]
    ld hl, MapItemUseFlags
    add_a_to_hl
    bit 5, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 44 TinyMedal, 45 GoldPass; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_TinyMedal::
Jump_016_44F9:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 47 (no name); item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_Item2F::
Jump_016_44FA:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 48 WaterCall; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, hPlayerFacing
; writes: wItemId
ItemUsable_WaterCall::
Jump_016_44FB:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_016_4542
    ldh a, [hMapId]
    cp a, $2F
    jr nz, Jump_016_4542
    ldh a, [hMapScreenX]
    cp a, $00
    jr nz, Jump_016_4542
    ldh a, [hMapScreenY]
    cp a, $01
    jr nz, Jump_016_4542
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_016_4528
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_016_4542
    ldh a, [hPlayerFacing]
    cp a, $01
    jr nz, Jump_016_4542
    jr Jump_016_4538

Jump_016_4528::
    cp a, $50
    jr nz, Jump_016_4542
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_016_4542
    ldh a, [hPlayerFacing]
    cp a, $02
    jr nz, Jump_016_4542

Jump_016_4538::
    ld de, $0058
    call TestFlagBit
    jr c, Jump_016_4542
    jr Jump_016_4547

Jump_016_4542::
    ld a, $FF
    ld [wItemId], a

Jump_016_4547::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 49 MoonRock; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, hPlayerY, hPlayerFacing, hPlayerX
; writes: wItemId
ItemUsable_MoonRock::
Jump_016_4548:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_016_457D
    ldh a, [hMapId]
    cp a, $40
    jr nz, Jump_016_457D
    ldh a, [hMapScreenX]
    ld b, a
    ldh a, [hMapScreenY]
    or a, b
    jr nz, Jump_016_457D
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_016_457D
    ldh a, [hPlayerFacing]
    cp a, $02
    jr nz, Jump_016_457D
    ldh a, [hPlayerX]
    cp a, $40
    jr c, Jump_016_457D
    cp a, $51
    jr nc, Jump_016_457D
    ld de, $007A
    call TestFlagBit
    jr c, Jump_016_457D
    jr Jump_016_4582

Jump_016_457D::
    ld a, $FF
    ld [wItemId], a

Jump_016_4582::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 50 Crest; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, hPlayerFacing
; writes: wItemId
ItemUsable_Crest::
Jump_016_4583:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_016_45BC
    ldh a, [hMapId]
    cp a, $49
    jr nz, Jump_016_45BC
    ldh a, [hMapScreenX]
    ld b, a
    ldh a, [hMapScreenY]
    or a, b
    jr nz, Jump_016_45BC
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_016_45BC
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_016_45BC
    ldh a, [hPlayerFacing]
    cp a, $02
    jr nz, Jump_016_45BC
    ld de, $01E4
    call TestFlagBit
    jr nc, Jump_016_45BC
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_016_45BC
    jr Jump_016_45C1

Jump_016_45BC::
    ld a, $FF
    ld [wItemId], a

Jump_016_45C1::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 51 YunaSoul; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_YunaSoul::
Jump_016_45C2:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 52 SleepHerb; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, hPlayerFacing
; writes: wItemId
ItemUsable_SleepHerb::
Jump_016_45C3:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_016_45F4
    ldh a, [hMapId]
    cp a, $61
    jr nz, Jump_016_45F4
    ldh a, [hMapScreenX]
    ld b, a
    ldh a, [hMapScreenY]
    or a, b
    jr nz, Jump_016_45F4
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_016_45F4
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_016_45F4
    ldh a, [hPlayerFacing]
    cp a, $02
    jr nz, Jump_016_45F4
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_016_45F4
    jr Jump_016_45F9

Jump_016_45F4::
    ld a, $FF
    ld [wItemId], a

Jump_016_45F9::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 53 Change?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId, hMapScreenY, wScreenSavedFlag
; writes: wItemId
ItemUsable_Change::
Jump_016_45FA:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_016_4626
    ldh a, [hMapId]
    cp a, $70
    jr c, Jump_016_4626
    cp a, $A0
    jr nc, Jump_016_4626
    cp a, $76
    jr z, Jump_016_4626
    cp a, $9B
    jr z, Jump_016_4626
    cp a, $9A
    jr z, Jump_016_4626
    cp a, $7A
    jr nz, Jump_016_4621
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_016_4626

Jump_016_4621::
    ld a, [wScreenSavedFlag]
    or a, a
    ret nz

Jump_016_4626::
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 55 HarMirror, 56 Sky?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_HarMirror::
Jump_016_462C:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 57 Heaven?, 58 Heaven?, 59 Heaven?, 60 WizStone, 61 Pretty?; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_Heaven::
Jump_016_462D:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 62 Accessory, 63 Accessory; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_Accessory::
Jump_016_462E:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 64 VITbelt, 65 DracoBelt, 66 MagicBelt, 67 OddBelt, 68 StoneFang, 69 SteelFang, 70 MermScale, 71 DrakScale, 72 AGL?, 73 Starry? ...; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_VITbelt::
Jump_016_462F:: ; address name
    call CheckTargetRecordFlag55Bit7
    ret

; A = wD083, then CheckRecordFlag55Bit7 (E-0066)
; 22 call sites from 22 routines (e.g. ItemApply_WorldDew_Sub01, ItemUsable_VITbelt, ItemUsable_BeefJerky, ItemUsable_Comedy, ...)
; reads: wTargetRecord
; writes: wItemId
CheckTargetRecordFlag55Bit7::
Func_016_4633:: ; address name
    ld a, [wTargetRecord]

; A = record (SRAMRecordAddressMapped, offset $55; SRAM must be enabled): returns Z set when bit 7 of that byte is clear; when it is set, wItemId = $FF, A = $FF and Z is clear. What the bit means is not known (E-0066)
; 3 call sites from 1 routine (e.g. ListPartyMembersWithField55Bit0)
; writes: wItemId
CheckRecordFlag55Bit7::
Func_016_4636:: ; address name
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret z
    ld a, $FF
    ld [wItemId], a
    or a, a
    ret

; only called from Bank16Func4645ResultTest (E-0047)
; 1 call site from 1 routine (e.g. Bank16Func4645ResultTest)
; reads: wMapType, wEncounterRate, hMapId
Bank16Func4645ResultTest_Sub01::
Func_016_4645:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_016_4655
    ld a, [wEncounterRate]
    and a, $7F
    jr nz, Jump_016_4667
    jr Jump_016_4663

Jump_016_4655::
    ldh a, [hMapId]
    ld hl, MapItemUseFlags
    add_a_to_hl
    bit 4, [hl]
    jr z, Jump_016_4667

Jump_016_4663::
    ld c, $00
    jr Jump_016_4669

Jump_016_4667::
    ld c, $01

Jump_016_4669::
    ret

; HL = cap, BC = current value: when they are equal sets wItemId = $FF (refuse); otherwise writes min(HL - BC, wD08F) (wD08F when the difference is 256 or more) as a decimal string at wC160 (WriteDecimalByteString) (E-0103)
; 6 call sites from 6 routines (e.g. ItemUsable_MysticNut, ItemUsable_LifeAcorn, ItemUsable_INTseed, ItemUsable_AGLseed, ...)
; reads: wItemEffectAmount
; writes: wItemId
; points at: wTextBuf3
ShowRaiseAmountOrRefuse::
Func_016_466A:: ; address name
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_016_4688
    ld a, h
    or a, a
    ld a, [wItemEffectAmount]
    jr nz, Jump_016_4681
    cp a, l
    jr z, Jump_016_4681
    jr c, Jump_016_4681
    ld a, l

Jump_016_4681::
    ld hl, wTextBuf3
    call WriteDecimalByteString
    ret

Jump_016_4688::
    ld a, $FF
    ld [wItemId], a
    ret

; returns when wItemId is $FF; otherwise jumps through a 95-entry table with one effect per item id. The Herb entry adds (wC5E7 after NextTableByte) / 11 + wD08F to record wD083 (Func_016_57D1) and then runs ConsumeSelectedItemByChance; CheckItemUsable is the matching usability check (E-0089)
; 3 call sites from 3 routines (e.g. PauseMenu_Items_Case02_Case0B, PauseMenu_Items_Case02_Case19, PauseMenu_Items_Case02_Case1D)
; reads: wItemId
ApplyItemEffect::
Func_016_468E:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld a, [wItemId]
    rst $00
    dw ItemApply_Item00
    dw ItemApply_Herb
    dw ItemApply_Herb
    dw ItemApply_WorldDew
    dw ItemApply_Potion
    dw ItemApply_ElfWater
    dw ItemApply_Antidote
    dw ItemApply_MoonHerb
    dw ItemApply_Laurel
    dw ItemApply_AwakeSand
    dw ItemApply_SkyBell
    dw ItemApply_SageRock
    dw ItemApply_WorldLeaf
    dw ItemApply_ATKseed
    dw ItemApply_DEFseed
    dw ItemApply_AGLseed
    dw ItemApply_INTseed
    dw ItemApply_LifeAcorn
    dw ItemApply_MysticNut
    dw ItemApply_Quest
    dw ItemApply_Horror
    dw ItemApply_BeNice
    dw ItemApply_Cheater
    dw ItemApply_Smart
    dw ItemApply_Comedy
    dw ItemApply_BeefJerky
    dw ItemApply_BeefJerky
    dw ItemApply_BeefJerky
    dw ItemApply_BeefJerky
    dw ItemApply_BadMeat
    dw ItemApply_MeteOrb
    dw ItemApply_BeastTail
    dw ItemApply_Repellent
    dw ItemApply_ShinyHarp
    dw ItemApply_Mist
    dw ItemApply_Mist
    dw ItemApply_Mist
    dw ItemApply_Mist
    dw ItemApply_Mist
    dw ItemApply_Mist
    dw ItemApply_Warp
    dw ItemApply_WarpWing
    dw ItemApply_ExitBell
    dw ItemApply_Bookmark
    dw ItemApply_TinyMedal
    dw ItemApply_TinyMedal
    dw ItemApply_LogTwig
    dw ItemApply_Item2F
    dw ItemApply_WaterCall
    dw ItemApply_MoonRock
    dw ItemApply_Crest
    dw ItemApply_YunaSoul
    dw ItemApply_SleepHerb
    dw ItemApply_Change
    dw ItemApply_TidalBell
    dw ItemApply_HarMirror
    dw ItemApply_HarMirror
    dw ItemApply_HarMirror
    dw ItemApply_HarMirror
    dw ItemApply_HarMirror
    dw ItemApply_HarMirror
    dw ItemApply_HarMirror
    dw ItemApply_Accessory
    dw ItemApply_Accessory
    dw ItemApply_VITbelt
    dw ItemApply_DracoBelt
    dw ItemApply_MagicBelt
    dw ItemApply_OddBelt
    dw ItemApply_StoneFang
    dw ItemApply_SteelFang
    dw ItemApply_MermScale
    dw ItemApply_DrakScale
    dw ItemApply_AGL
    dw ItemApply_Starry
    dw ItemApply_Smart_4A1D
    dw ItemApply_Wise
    dw ItemApply_MagicCape
    dw ItemApply_MagicCape
    dw ItemApply_MagicCape
    dw ItemApply_MagicCape
    dw ItemApply_MagicCape
    dw ItemApply_MagicCape
    dw ItemApply_MagicCape
    dw ItemApply_DScale
    dw ItemApply_None
    dw ItemApply_None
    dw ItemApply_None
    dw ItemApply_None
    dw ItemApply_None
    dw ItemApply_None
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Life
    dw ItemApply_Item62

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 0 (no name); the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Item00::
Jump_016_475E:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 1 Herb, 2 LoveWater; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wItemEffectAmount, wTargetRecord
ItemApply_Herb::
Jump_016_475F:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, $0B
    call DivideBByA
    ld b, a
    ld a, [wItemEffectAmount]
    add a, b
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordHPCapped
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 3 WorldDew; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_WorldDew::
Jump_016_477D:: ; address name
    ld a, $00
    call ItemApply_WorldDew_Sub01
    ld a, $01
    call ItemApply_WorldDew_Sub01
    ld a, $02
    call ItemApply_WorldDew_Sub01
    call ConsumeSelectedItemByChance
    ret

; only called from ItemApply_WorldDew (E-0047)
; 3 call sites from 1 routine (e.g. ItemApply_WorldDew)
; reads: wTargetRecord
; writes: wTargetRecord
; points at: wPartyCount
ItemApply_WorldDew_Sub01::
Func_016_4790:: ; address name
    ld hl, wPartyCount
    cp a, [hl]
    ret nc
    ld [wTargetRecord], a
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, $5B
    call StoreHLToRecordField
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 4 Potion; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wItemEffectAmount, wTargetRecord
ItemApply_Potion::
Jump_016_47B0:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, $0B
    call DivideBByA
    ld b, a
    ld a, [wItemEffectAmount]
    add a, b
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordMPCapped
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 5 ElfWater; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemApply_ElfWater::
Jump_016_47CE:: ; address name
    ld a, [wTargetRecord]
    ld c, $61
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, $5F
    call StoreHLToRecordField
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 6 Antidote; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemApply_Antidote::
Jump_016_47E5:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 2, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 7 MoonHerb; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemApply_MoonHerb::
Jump_016_47F3:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 3, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 8 Laurel; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemApply_Laurel::
Jump_016_4801:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 0, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 9 AwakeSand; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemApply_AwakeSand::
Jump_016_480F:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 1, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 10 SkyBell; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
ItemApply_SkyBell::
Jump_016_481D:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 4, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 11 SageRock; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_SageRock::
Jump_016_482B:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 12 WorldLeaf; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wLevelUpGains
ItemApply_WorldLeaf::
Jump_016_482C:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    ld [hl], $00
    ld a, [wTargetRecord]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, $5B
    call StoreHLToRecordField
    ld a, $01
    ld [wLevelUpGains], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 13 ATKseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_ATKseed::
Jump_016_4852:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_ATKseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 14 DEFseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_DEFseed::
Jump_016_4862:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_DEFseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 15 AGLseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_AGLseed::
Jump_016_4872:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_AGLseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 16 INTseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_INTseed::
Jump_016_4882:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_INTseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 17 LifeAcorn; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_LifeAcorn::
Jump_016_4892:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_LifeAcorn_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 18 MysticNut; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_MysticNut::
Jump_016_48A2:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_MysticNut_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 19 Quest?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_Quest::
Jump_016_48B2:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Quest_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 20 Horror?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_Horror::
Jump_016_48C2:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Horror_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 21 BeNice?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_BeNice::
Jump_016_48D2:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_BeNice_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 22 Cheater?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_Cheater::
Jump_016_48E2:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Cheater_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 23 Smart?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_Smart::
Jump_016_48F2:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Smart_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 24 Comedy?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_Comedy::
Jump_016_4902:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Comedy_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 25 BeefJerky, 26 PorkChop, 27 Rib, 28 Sirloin; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_BeefJerky::
Jump_016_4912:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ApplyMeatToRecordField6B
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 29 BadMeat; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemEffectAmount, wTargetRecord
ItemApply_BadMeat::
Jump_016_4922:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ApplyMeatToRecordField6B
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    set 2, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 30 MeteOrb; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MeteOrb::
Jump_016_493C:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 31 BeastTail; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_BeastTail::
Jump_016_493D:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 32 Repellent; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wEncounterDelay
ItemApply_Repellent::
Jump_016_493E:: ; address name
    ld a, $C8
    ld [wEncounterDelay], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 33 ShinyHarp; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_ShinyHarp::
Jump_016_4947:: ; address name
    ld a, $01
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 34 Mist?, 35 Friend?, 36 Wind?, 37 Bolt?, 38 Snow?, 39 Fire?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Mist::
Jump_016_4950:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 40 Warp?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_Warp::
Jump_016_4951:: ; address name
    ld a, $02
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 41 WarpWing; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_WarpWing::
Jump_016_495A:: ; address name
    ld a, $03
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 42 ExitBell; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_ExitBell::
Jump_016_4963:: ; address name
    ld a, $04
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 43 Bookmark; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Bookmark::
Jump_016_496C:: ; address name
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 44 TinyMedal, 45 GoldPass; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_TinyMedal::
Jump_016_4970:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 46 LogTwig; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_LogTwig::
Jump_016_4971:: ; address name
    ld a, $09
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 47 (no name); the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Item2F::
Jump_016_497A:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 48 WaterCall; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_WaterCall::
Jump_016_497B:: ; address name
    ld a, $05
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 49 MoonRock; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_MoonRock::
Jump_016_4981:: ; address name
    ld a, $06
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 50 Crest; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_Crest::
Jump_016_4987:: ; address name
    ld a, $07
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 51 YunaSoul; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_YunaSoul::
Jump_016_498D:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 52 SleepHerb; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_SleepHerb::
Jump_016_498E:: ; address name
    ld a, $08
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 53 Change?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave
ItemApply_Change::
Jump_016_4994:: ; address name
    ld a, $0A
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 54 TidalBell; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wTownEventTimer
; writes: wTownEventTimer
ItemApply_TidalBell::
Jump_016_499A:: ; address name
    ld a, [wTownEventTimer]
    add a, $32
    jr nc, Jump_016_49A3
    ld a, $FF

Jump_016_49A3::
    cp a, $F0
    jr c, Jump_016_49A9
    ld a, $F0

Jump_016_49A9::
    ld [wTownEventTimer], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 55 HarMirror, 56 Sky?, 57 Heaven?, 58 Heaven?, 59 Heaven?, 60 WizStone, 61 Pretty?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_HarMirror::
Jump_016_49AD:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 62 Accessory, 63 Accessory; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Accessory::
Jump_016_49AE:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 64 VITbelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_VITbelt::
Jump_016_49AF:: ; address name
    ld a, $1E
    ld c, $5D
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 65 DracoBelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_DracoBelt::
Jump_016_49BA:: ; address name
    ld a, $50
    ld c, $5D
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 66 MagicBelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MagicBelt::
Jump_016_49C5:: ; address name
    ld a, $1E
    ld c, $61
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 67 OddBelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_OddBelt::
Jump_016_49D0:: ; address name
    ld a, $50
    ld c, $61
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 68 StoneFang; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_StoneFang::
Jump_016_49DB:: ; address name
    ld a, $0A
    ld c, $63
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 69 SteelFang; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_SteelFang::
Jump_016_49E6:: ; address name
    ld a, $32
    ld c, $63
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 70 MermScale; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MermScale::
Jump_016_49F1:: ; address name
    ld a, $0A
    ld c, $65
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 71 DrakScale; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_DrakScale::
Jump_016_49FC:: ; address name
    ld a, $32
    ld c, $65
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 72 AGL?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_AGL::
Jump_016_4A07:: ; address name
    ld a, $0A
    ld c, $67
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 73 Starry?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Starry::
Jump_016_4A12:: ; address name
    ld a, $32
    ld c, $67
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 74 Smart?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Smart_4A1D::
Jump_016_4A1D:: ; address name
    ld a, $32
    ld c, $69
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 75 Wise?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Wise::
Jump_016_4A28:: ; address name
    ld a, $64
    ld c, $69
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 76 MagicCape, 77 DracoCape, 78 SilvrCape, 79 GoldCape, 80 PltnmCape, 81 OrcaCape, 82 BraveCape; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MagicCape::
Jump_016_4A33:: ; address name
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 83 D-Scale; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_DScale::
Jump_016_4A37:: ; address name
    ld a, $05
    ld c, $65
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 84 None, 85 None, 86 None, 87 None, 88 None, 89 None; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_None::
Jump_016_4A42:: ; address name
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 90 Life?, 91 Divine?, 92 War?, 93 Mage?, 94 Fight?, 95 Sailor?, 96 Thief?, 97 Cleric?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Life::
Jump_016_4A43:: ; address name
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 98 (no name); the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Item62::
Jump_016_4A47:: ; address name
    ret

; stores item wItemId - $3F in field $A4 of record wD083: an empty field consumes the item (hFFC6 = 0); otherwise the old item goes back to the inventory and its name to wC160 (hFFC6 = 1) (E-0125)
; 15 call sites from 15 routines (e.g. ItemApply_Life, ItemApply_DScale, ItemApply_MagicCape, ItemApply_Wise, ...)
; reads: wTargetRecord, wItemId, wInventorySlot
; writes: hTemp0, wItemId
; points at: wInventory, wTextBuf3
EquipItemOnRecordTargetRecord::
Func_016_4A48:: ; address name
    ld a, [wTargetRecord]
    ld c, $A4
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    jr nz, Jump_016_4A61
    ld a, [wItemId]
    sub a, $3F
    ld [hl], a
    call ConsumeSelectedItemByChance
    xor a, a
    ldh [hTemp0], a
    ret

Jump_016_4A61::
    push af
    ld a, [wItemId]
    sub a, $3F
    ld [hl], a
    ld a, $FF
    ld [wItemId], a
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    pop af
    add a, $3F
    ld [hl], a
    push af
    call CompactInventory
    pop af
    call ApplyEquipmentEffectKeepA
    ld l, a
    ld h, $05
    ld de, wTextBuf3
    call CopyStringHLToDE
    ld a, $01
    ldh [hTemp0], a
    ret

; preserving A, runs the routine for item A - $40 (a jump table over the equipment items; EquipItemOnRecordTargetRecord calls it) (E-0122, E-0259)
; 1 call site from 1 routine (e.g. EquipItemOnRecordTargetRecord)
ApplyEquipmentEffectKeepA::
Func_016_4A92:: ; address name
    push af
    call ApplyEquipmentEffectKeepA_Sub01
    pop af
    ret

; only called from ApplyEquipmentEffectKeepA (E-0047)
; 1 call site from 1 routine (e.g. ApplyEquipmentEffectKeepA)
ApplyEquipmentEffectKeepA_Sub01::
Func_016_4A98:: ; address name
    sub a, $40
    rst $00
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case01
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case02
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case03
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case05
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case06
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case07
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case08
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case09
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case0A
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case0B
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_Return
    dw ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case13
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case14
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case14
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case14
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case14
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case14
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case14
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case1A
    dw ApplyEquipmentEffectKeepA_Sub01_Return_Case22

; entry 0 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1::
Jump_016_4AE1:: ; address name
    ld a, $1E
    ld c, $5D
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 1 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case01::
Jump_016_4AE9:: ; address name
    ld a, $50
    ld c, $5D
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 2 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case02::
Jump_016_4AF1:: ; address name
    ld a, $1E
    ld c, $61
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 3 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case03::
Jump_016_4AF9:: ; address name
    ld a, $50
    ld c, $61
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 4 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1::
Jump_016_4B01:: ; address name
    ld a, $0A
    ld c, $63
    call SubtractAFromRecordWordFloor1
    ret

; entry 5 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case05::
Jump_016_4B09:: ; address name
    ld a, $32
    ld c, $63
    call SubtractAFromRecordWordFloor1
    ret

; entry 6 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case06::
Jump_016_4B11:: ; address name
    ld a, $0A
    ld c, $65
    call SubtractAFromRecordWordFloor1
    ret

; entry 7 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case07::
Jump_016_4B19:: ; address name
    ld a, $32
    ld c, $65
    call SubtractAFromRecordWordFloor1
    ret

; entry 8 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case08::
Jump_016_4B21:: ; address name
    ld a, $0A
    ld c, $67
    call SubtractAFromRecordWordFloor1
    ret

; entry 9 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case09::
Jump_016_4B29:: ; address name
    ld a, $32
    ld c, $67
    call SubtractAFromRecordWordFloor1
    ret

; entry 10 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case0A::
Jump_016_4B31:: ; address name
    ld a, $32
    ld c, $69
    call SubtractAFromRecordWordFloor1
    ret

; entry 11 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case0B::
Jump_016_4B39:: ; address name
    ld a, $64
    ld c, $69
    call SubtractAFromRecordWordFloor1
    ret

; entry 12 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_Return::
Jump_016_4B41:: ; address name
    ret

; entry 19 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case13::
Jump_016_4B42:: ; address name
    ld a, $05
    ld c, $65
    call SubtractAFromRecordWordFloor1
    ret

; entry 20 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_Return_Case14::
Jump_016_4B4A:: ; address name
    ret

; entry 26 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_Return_Case1A::
Jump_016_4B4B:: ; address name
    ret

; entry 34 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
ApplyEquipmentEffectKeepA_Sub01_Return_Case22::
Jump_016_4B4C:: ; address name
    ret

; A = amount, record wD083 (SRAMRecordAddressMapped), field offset C: the word there += A, capped at 999 (CapDETo999) (E-0103)
; 9 call sites from 9 routines (e.g. ItemApply_DScale, ItemApply_Wise, ItemApply_Smart_4A1D, ItemApply_Starry, ...)
; reads: wTargetRecord, hTemp0
; writes: hTemp0
AddAToRecordWordCapped::
Func_016_4B4D:: ; address name
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hTemp0]
    add a, e
    ld e, a
    jr nc, Jump_016_4B60
    inc d

Jump_016_4B60::
    call CapDETo999
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

; A = amount, record wD083 (SRAMRecordAddressMapped), field offset C: adds A to the word at field C and to the word two bytes before it, each capped at 999 (E-0103)
; 4 call sites from 4 routines (e.g. ItemApply_OddBelt, ItemApply_MagicBelt, ItemApply_DracoBelt, ItemApply_VITbelt)
; reads: wTargetRecord, hTemp0
; writes: hTemp0
AddAToRecordWordPairCapped::
Func_016_4B68:: ; address name
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hTemp0]
    add a, e
    ld e, a
    jr nc, Jump_016_4B7B
    inc d

Jump_016_4B7B::
    call CapDETo999
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    dec hl
    dec hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hTemp0]
    add a, e
    ld e, a
    jr nc, Jump_016_4B8F
    inc d

Jump_016_4B8F::
    call CapDETo999
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

; A = amount, record wD083 (SRAMRecordAddressMapped), field offset C: leaves the word unchanged when it is 999; otherwise word -= A, but never below 1 (E-0103)
; 9 call sites from 9 routines (e.g. ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case13, ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case0B, ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case0A, ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordFloor1_Case09, ...)
; reads: wTargetRecord, hTemp0
; writes: hTemp0
SubtractAFromRecordWordFloor1::
Func_016_4B97:: ; address name
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    cp a, $E7
    jr nz, Jump_016_4BAC
    ld a, d
    cp a, $03
    ret z

Jump_016_4BAC::
    ld a, e
    push af
    ldh a, [hTemp0]
    ld e, a
    pop af
    sub a, e
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr z, Jump_016_4BBF
    ld de, $0001

Jump_016_4BBF::
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

; A = amount, record wD083 (SRAMRecordAddressMapped), field offset C: as SubtractAFromRecordWordFloor1 for the word at field C, then the same for the word two bytes before it (the second half is not read to its end) (E-0103)
; 4 call sites from 4 routines (e.g. ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case03, ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case02, ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1_Case01, ApplyEquipmentEffectKeepA_Sub01_ToSubtractAFromRecordWordPairFloor1)
; reads: wTargetRecord, hTemp0
; writes: hTemp0
SubtractAFromRecordWordPairFloor1::
Func_016_4BC4:: ; address name
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    cp a, $E7
    jr nz, Jump_016_4BD9
    ld a, d
    cp a, $03
    ret z

Jump_016_4BD9::
    ld a, e
    push af
    ldh a, [hTemp0]
    ld e, a
    pop af
    sub a, e
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr z, Jump_016_4BEC
    ld de, $0001

Jump_016_4BEC::
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    dec hl
    dec hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    push af
    ldh a, [hTemp0]
    ld e, a
    pop af
    sub a, e
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr z, Jump_016_4C09
    ld de, $0001

Jump_016_4C09::
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

; DE = min(DE, 999 ($03E7)) (E-0103)
; 3 call sites from 2 routines (e.g. AddAToRecordWordCapped, AddAToRecordWordPairCapped)
CapDETo999::
Func_016_4C0E:: ; address name
    ld a, d
    cp a, $03
    ret c
    jr nz, Jump_016_4C18
    ld a, e
    cp a, $E8
    ret c

Jump_016_4C18::
    ld e, $E7
    ld d, $03
    ret

; advances the random table (NextTableByte), takes A = (wC5E8:wC5E7) mod 100 and, when A < wD087, sets wItemId = $FF, clears wInventory[wD082] to $FF and runs CompactInventory; otherwise returns with carry clear and nothing changed (E-0063)
; 33 call sites from 33 routines (e.g. EquipItemOnRecordTargetRecord, ItemApply_LogTwig, ItemApply_Bookmark, ItemApply_ExitBell, ...)
; reads: wRandomLo, wRandomHi, wInventorySlot
; writes: wItemId
; points at: wInventory
ConsumeSelectedItemByChance::
Func_016_4C1D:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $64
    call DivideHLByA
    ld hl, wItemRecord + $3
    cp a, [hl]
    ret nc
    ld a, $FF
    ld [wItemId], a
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $FF
    call CompactInventory
    ret

; copies the 24 wInventory bytes to wD09D, refills wInventory with $FF, then copies back every byte that is neither $FF nor $00, closing the gaps (E-0063)
; 6 call sites from 6 routines (e.g. ConsumeSelectedItemByChance, EquipItemOnRecordTargetRecord, RemoveWItemIdFromInventory, PauseMenu_Items_Case03_Case04, ...)
; points at: wWorkBuf, wInventory
CompactInventory::
Func_016_4C48:: ; address name
    ld hl, wWorkBuf
    ld de, wInventory
    ld b, $18

Jump_016_4C50::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_016_4C50
    ld hl, wInventory
    ld bc, $0018
    ld a, $FF
    call FillBytes
    ld hl, wWorkBuf
    ld de, wInventory
    ld b, $18

Jump_016_4C69::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_4C74
    cp a, $00
    jr z, Jump_016_4C74
    ld [de], a
    inc de

Jump_016_4C74::
    dec b
    jr nz, Jump_016_4C69
    ret

; puts wItemId in the first empty inventory slot; sets wItemId = $FF when all 24 are full (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wItemId
; points at: wInventory
AddWItemIdToInventory:: ; heuristic: follows a terminator; C0
Func_016_4C78:: ; address name
    ld a, [wItemId]
    cp a, $00
    ret z
    cp a, $FF
    ret z
    ld hl, wInventory
    ld b, $18

Jump_016_4C86::
    ld a, [hl]
    cp a, $00
    jr z, Jump_016_4C99
    cp a, $FF
    jr z, Jump_016_4C99
    inc hl
    dec b
    jr nz, Jump_016_4C86
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_4C99::
    ld a, [wItemId]
    ld [hl], a
    ret

; removes the first inventory slot holding wItemId and compacts the inventory; sets wItemId = $FF when not found (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wItemId
; points at: wInventory
RemoveWItemIdFromInventory:: ; heuristic: follows a terminator; C0
Func_016_4C9E:: ; address name
    ld a, [wItemId]
    cp a, $00
    ret z
    cp a, $FF
    ret z
    ld hl, wInventory
    ld b, $18

Jump_016_4CAC::
    ld a, [wItemId]
    cp a, [hl]
    jr z, Jump_016_4CBC
    inc hl
    dec b
    jr nz, Jump_016_4CAC
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_4CBC::
    ld [hl], $FF
    call CompactInventory
    ret

; E-0034 (C1: LoadItemRecord copies 13 bytes from here by item id (wD081) to wD084; RunItemEffect dispatches on the same id; wC61D is a 24-slot bag of such ids, empty at the start of a new game, matching the item menu's 'No items'; the herb handler compares the words at save-record offsets $5B and $5D to refuse use at full HP). 99 records: the next bytes are a different table. The meaning of the fields is not established beyond the first amount being 10, 50, 500, 200 and 2000 for ids 1-5.
; record: byte 0 (0, 1, 2 or 6); 16-bit amount (10, 50, 500, 200, 2000 for the first five items); byte 3 (usually $64); byte 4; byte 5; byte 6; byte 7; byte 8; byte 9; byte 10; byte 11; byte 12
ItemTable::
Data_016_4CC2:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $0A, $00, $64, $00, $00, $04, $02, $00, $03, $04, $1E, $28 ; id 1
    db $00, $32, $00, $64, $00, $00, $04, $03, $00, $03, $04, $3C, $46 ; id 2
    db $00, $F4, $01, $64, $00, $00, $05, $03, $00, $06, $04, $FF, $FF ; id 3
    db $00, $C8, $00, $64, $00, $00, $04, $03, $00, $03, $07, $14, $1E ; id 4
    db $00, $D0, $07, $64, $00, $00, $04, $03, $00, $03, $07, $FF, $FF ; id 5
    db $01, $04, $00, $64, $00, $00, $04, $02, $00, $03, $08, $00, $00 ; id 6
    db $01, $14, $00, $64, $00, $00, $04, $02, $00, $03, $09, $00, $00 ; id 7
    db $01, $14, $00, $64, $00, $00, $04, $02, $00, $03, $0B, $00, $00 ; id 8
    db $01, $14, $00, $64, $00, $00, $04, $03, $00, $03, $0C, $00, $00 ; id 9
    db $01, $14, $00, $64, $00, $00, $04, $04, $00, $03, $0A, $00, $00 ; id 10
    db $00, $E8, $03, $14, $02, $00, $05, $00, $00, $05, $04, $2D, $37 ; id 11
    db $01, $E8, $03, $64, $00, $00, $04, $02, $00, $03, $0D, $00, $00 ; id 12
    db $02, $14, $00, $64, $01, $00, $00, $05, $00, $03, $10, $03, $00 ; id 13
    db $02, $14, $00, $64, $01, $00, $00, $05, $00, $03, $11, $03, $00 ; id 14
    db $02, $14, $00, $64, $01, $00, $00, $05, $00, $03, $12, $03, $00 ; id 15
    db $02, $14, $00, $64, $01, $00, $00, $05, $00, $03, $13, $03, $00 ; id 16
    db $02, $14, $00, $64, $01, $00, $00, $05, $00, $03, $0E, $05, $00 ; id 17
    db $02, $14, $00, $64, $01, $00, $00, $05, $00, $03, $0F, $05, $00 ; id 18
    db $02, $10, $27, $64, $01, $00, $00, $00, $00, $1A, $1B, $32, $32 ; id 19
    db $02, $10, $27, $64, $01, $00, $00, $00, $00, $1A, $1C, $32, $32 ; id 20
    db $02, $10, $27, $64, $01, $00, $00, $00, $00, $1A, $1D, $32, $32 ; id 21
    db $02, $10, $27, $64, $01, $00, $00, $00, $00, $1A, $1E, $32, $32 ; id 22
    db $02, $10, $27, $64, $01, $00, $00, $00, $00, $1A, $1F, $32, $32 ; id 23
    db $02, $10, $27, $64, $01, $00, $00, $00, $00, $1A, $20, $32, $32 ; id 24
    db $03, $0A, $00, $64, $00, $01, $04, $06, $00, $14, $15, $05, $0A ; id 25
    db $03, $28, $00, $64, $00, $01, $04, $06, $00, $14, $15, $0A, $1E ; id 26
    db $03, $C8, $00, $64, $00, $01, $04, $06, $00, $14, $15, $14, $64 ; id 27
    db $03, $E8, $03, $64, $00, $01, $04, $06, $00, $14, $15, $64, $FF ; id 28
    db $06, $14, $00, $64, $00, $01, $04, $06, $04, $14, $16, $05, $05 ; id 29
    db $03, $88, $13, $64, $02, $01, $03, $00, $00, $21, $22, $00, $FF ; id 30
    db $06, $20, $03, $00, $02, $01, $07, $00, $00, $2B, $2C, $00, $00 ; id 31
    db $06, $64, $00, $64, $01, $00, $07, $03, $00, $06, $23, $00, $00 ; id 32
    db $06, $B0, $04, $00, $01, $00, $07, $00, $01, $24, $FF, $00, $00 ; id 33
    db $04, $BC, $02, $14, $02, $00, $03, $07, $00, $00, $00, $00, $00 ; id 34
    db $04, $20, $03, $3C, $02, $00, $00, $07, $00, $00, $00, $00, $00 ; id 35
    db $04, $DC, $05, $0A, $02, $00, $03, $07, $00, $00, $00, $08, $18 ; id 36
    db $04, $B8, $0B, $14, $02, $00, $03, $07, $00, $00, $00, $23, $32 ; id 37
    db $04, $A0, $0F, $14, $02, $00, $03, $07, $00, $00, $00, $78, $8C ; id 38
    db $04, $88, $13, $14, $02, $00, $02, $07, $00, $00, $00, $B4, $C8 ; id 39
    db $05, $32, $00, $64, $01, $00, $07, $07, $00, $17, $FF, $00, $00 ; id 40
    db $05, $19, $00, $64, $01, $00, $07, $08, $00, $18, $FF, $00, $00 ; id 41
    db $05, $32, $00, $64, $01, $00, $07, $04, $00, $19, $FF, $00, $00 ; id 42
    db $06, $32, $00, $64, $01, $00, $07, $00, $00, $25, $25, $00, $00 ; id 43
    db $06, $01, $00, $64, $03, $00, $07, $09, $05, $19, $00, $00, $00 ; id 44
    db $06, $01, $00, $00, $03, $00, $07, $00, $05, $00, $00, $00, $00 ; id 45
    db $06, $32, $00, $64, $01, $00, $07, $00, $00, $19, $FF, $00, $00 ; id 46
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 47
    db $06, $00, $00, $00, $01, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 48
    db $06, $00, $00, $00, $01, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 49
    db $06, $00, $00, $00, $01, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 50
    db $06, $00, $00, $00, $03, $00, $07, $00, $07, $19, $00, $00, $00 ; id 51
    db $06, $00, $00, $00, $01, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 52
    db $06, $00, $00, $00, $01, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 53
    db $06, $00, $00, $00, $01, $00, $07, $00, $07, $19, $2F, $00, $00 ; id 54
    db $06, $00, $00, $00, $02, $00, $03, $00, $07, $19, $FF, $00, $00 ; id 55
    db $06, $00, $00, $00, $02, $00, $01, $00, $07, $21, $FF, $00, $00 ; id 56
    db $06, $00, $00, $00, $03, $00, $07, $00, $07, $00, $00, $00, $00 ; id 57
    db $06, $00, $00, $00, $03, $00, $07, $00, $07, $00, $00, $00, $00 ; id 58
    db $06, $00, $00, $00, $03, $00, $07, $00, $07, $00, $00, $00, $00 ; id 59
    db $06, $00, $00, $00, $03, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 60
    db $06, $00, $00, $00, $03, $00, $07, $00, $07, $19, $FF, $00, $00 ; id 61
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 62
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 63
    db $06, $C8, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 64
    db $06, $F4, $01, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 65
    db $06, $C8, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 66
    db $06, $F4, $01, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 67
    db $06, $C8, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 68
    db $06, $F4, $01, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 69
    db $06, $C8, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 70
    db $06, $F4, $01, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 71
    db $06, $C8, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 72
    db $06, $F4, $01, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 73
    db $06, $C8, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 74
    db $06, $F4, $01, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 75
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 76
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 77
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 78
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 79
    db $06, $88, $13, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 80
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 81
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 82
    db $06, $14, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 83
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 84
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 85
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 86
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 87
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 88
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 89
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 90
    db $06, $E8, $03, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 91
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 92
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 93
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 94
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 95
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 96
    db $06, $D0, $07, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 97
    db $06, $0D, $00, $64, $01, $00, $00, $00, $00, $30, $27, $00, $00 ; id 98

; E-0229 (C1: ItemUsable_WarpWing tests bit 6, the ExitBell check (Func_016_44D0, E-0085) bit 5 and Func_016_4645 bit 4 of the byte at $51C9 + hMapId; a clear bit refuses the item (wItemId = $FF) or gives C = 0; 256 bytes, one per map number, end at Func_016_52C9).
; record: flag bits for this map (bit 6: WarpWing, bit 5: ExitBell, bit 4: Func_016_4645)
MapItemUseFlags::
Data_016_51C9:: ; address name
    db $10 ; id 0
    db $10 ; id 1
    db $10 ; id 2
    db $10 ; id 3
    db $10 ; id 4
    db $10 ; id 5
    db $10 ; id 6
    db $10 ; id 7
    db $10 ; id 8
    db $10 ; id 9
    db $10 ; id 10
    db $10 ; id 11
    db $10 ; id 12
    db $10 ; id 13
    db $10 ; id 14
    db $10 ; id 15
    db $10 ; id 16
    db $10 ; id 17
    db $10 ; id 18
    db $10 ; id 19
    db $10 ; id 20
    db $10 ; id 21
    db $10 ; id 22
    db $10 ; id 23
    db $10 ; id 24
    db $10 ; id 25
    db $10 ; id 26
    db $10 ; id 27
    db $10 ; id 28
    db $10 ; id 29
    db $10 ; id 30
    db $10 ; id 31
    db $C0 ; id 32
    db $10 ; id 33
    db $10 ; id 34
    db $10 ; id 35
    db $10 ; id 36
    db $10 ; id 37
    db $10 ; id 38
    db $00 ; id 39
    db $00 ; id 40
    db $10 ; id 41
    db $10 ; id 42
    db $A0 ; id 43
    db $00 ; id 44
    db $10 ; id 45
    db $10 ; id 46
    db $40 ; id 47
    db $C0 ; id 48
    db $10 ; id 49
    db $10 ; id 50
    db $10 ; id 51
    db $10 ; id 52
    db $A0 ; id 53
    db $00 ; id 54
    db $80 ; id 55
    db $A0 ; id 56
    db $A0 ; id 57
    db $A0 ; id 58
    db $20 ; id 59
    db $10 ; id 60
    db $10 ; id 61
    db $A0 ; id 62
    db $A0 ; id 63
    db $20 ; id 64
    db $10 ; id 65
    db $80 ; id 66
    db $C0 ; id 67
    db $00 ; id 68
    db $10 ; id 69
    db $00 ; id 70
    db $00 ; id 71
    db $C0 ; id 72
    db $40 ; id 73
    db $10 ; id 74
    db $10 ; id 75
    db $10 ; id 76
    db $10 ; id 77
    db $10 ; id 78
    db $10 ; id 79
    db $10 ; id 80
    db $10 ; id 81
    db $10 ; id 82
    db $A0 ; id 83
    db $A0 ; id 84
    db $A0 ; id 85
    db $A0 ; id 86
    db $20 ; id 87
    db $10 ; id 88
    db $10 ; id 89
    db $10 ; id 90
    db $10 ; id 91
    db $10 ; id 92
    db $A0 ; id 93
    db $10 ; id 94
    db $10 ; id 95
    db $10 ; id 96
    db $10 ; id 97
    db $A0 ; id 98
    db $A0 ; id 99
    db $A0 ; id 100
    db $A0 ; id 101
    db $A0 ; id 102
    db $A0 ; id 103
    db $10 ; id 104
    db $00 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $00 ; id 108
    db $00 ; id 109
    db $00 ; id 110
    db $00 ; id 111
    db $C0 ; id 112
    db $10 ; id 113
    db $10 ; id 114
    db $A0 ; id 115
    db $A0 ; id 116
    db $A0 ; id 117
    db $A0 ; id 118
    db $10 ; id 119
    db $10 ; id 120
    db $10 ; id 121
    db $40 ; id 122
    db $10 ; id 123
    db $10 ; id 124
    db $10 ; id 125
    db $10 ; id 126
    db $10 ; id 127
    db $10 ; id 128
    db $A0 ; id 129
    db $A0 ; id 130
    db $A0 ; id 131
    db $20 ; id 132
    db $A0 ; id 133
    db $A0 ; id 134
    db $A0 ; id 135
    db $A0 ; id 136
    db $10 ; id 137
    db $20 ; id 138
    db $A0 ; id 139
    db $A0 ; id 140
    db $20 ; id 141
    db $A0 ; id 142
    db $20 ; id 143
    db $A0 ; id 144
    db $20 ; id 145
    db $10 ; id 146
    db $20 ; id 147
    db $20 ; id 148
    db $20 ; id 149
    db $20 ; id 150
    db $20 ; id 151
    db $20 ; id 152
    db $20 ; id 153
    db $20 ; id 154
    db $20 ; id 155
    db $00 ; id 156
    db $10 ; id 157
    db $00 ; id 158
    db $00 ; id 159
    db $C0 ; id 160
    db $20 ; id 161
    db $20 ; id 162
    db $20 ; id 163
    db $10 ; id 164
    db $00 ; id 165
    db $00 ; id 166
    db $00 ; id 167
    db $C0 ; id 168
    db $10 ; id 169
    db $40 ; id 170
    db $10 ; id 171
    db $20 ; id 172
    db $A0 ; id 173
    db $A0 ; id 174
    db $10 ; id 175
    db $C0 ; id 176
    db $10 ; id 177
    db $10 ; id 178
    db $A0 ; id 179
    db $A0 ; id 180
    db $A0 ; id 181
    db $20 ; id 182
    db $00 ; id 183
    db $C0 ; id 184
    db $10 ; id 185
    db $10 ; id 186
    db $20 ; id 187
    db $10 ; id 188
    db $20 ; id 189
    db $A0 ; id 190
    db $A0 ; id 191
    db $A0 ; id 192
    db $A0 ; id 193
    db $A0 ; id 194
    db $A0 ; id 195
    db $A0 ; id 196
    db $10 ; id 197
    db $00 ; id 198
    db $00 ; id 199
    db $40 ; id 200
    db $20 ; id 201
    db $20 ; id 202
    db $20 ; id 203
    db $20 ; id 204
    db $20 ; id 205
    db $20 ; id 206
    db $00 ; id 207
    db $10 ; id 208
    db $40 ; id 209
    db $20 ; id 210
    db $20 ; id 211
    db $20 ; id 212
    db $20 ; id 213
    db $20 ; id 214
    db $20 ; id 215
    db $00 ; id 216
    db $10 ; id 217
    db $40 ; id 218
    db $20 ; id 219
    db $20 ; id 220
    db $20 ; id 221
    db $20 ; id 222
    db $20 ; id 223
    db $20 ; id 224
    db $00 ; id 225
    db $10 ; id 226
    db $00 ; id 227
    db $00 ; id 228
    db $00 ; id 229
    db $00 ; id 230
    db $00 ; id 231
    db $00 ; id 232
    db $00 ; id 233
    db $00 ; id 234
    db $00 ; id 235
    db $00 ; id 236
    db $00 ; id 237
    db $00 ; id 238
    db $00 ; id 239
    db $00 ; id 240
    db $00 ; id 241
    db $00 ; id 242
    db $00 ; id 243
    db $00 ; id 244
    db $00 ; id 245
    db $00 ; id 246
    db $00 ; id 247
    db $00 ; id 248
    db $00 ; id 249
    db $00 ; id 250
    db $00 ; id 251
    db $00 ; id 252
    db $00 ; id 253
    db $00 ; id 254
    db $00 ; id 255

; only called from PauseMenu_Skills_Case03_Case02 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02)
; reads: wInventorySlot
; writes: wItemId
PauseMenu_Skills_Case03_Case02_Sub01::
Func_016_52C9:: ; address name
    ld a, [wInventorySlot]
    cp a, $14
    jr c, Jump_016_52D6
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_52D6::
    rst $00
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Herb
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Herb
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Herb
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldDew
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldDew
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case05
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case05
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case05
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldLeaf
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldLeaf
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Antidote
    dw PauseMenu_Skills_Case03_Case02_Sub01_ListPartyMembersWithField55Bit0
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case0C
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case0C
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case0C
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_ExitBell
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case0C
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case11
    dw PauseMenu_Skills_Case03_Case02_Sub01_Case12
    dw PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WarpWing

; entry 0 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Herb::
Jump_016_52FF:: ; address name
    call ItemUsable_Herb
    call SetWD08D12IfItemRefused
    ret

; entry 3 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldDew::
Jump_016_5306:: ; address name
    call ItemUsable_WorldDew
    call SetWD08D12IfItemRefused
    ret

; entry 5 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember, wTargetRecord
; writes: wItemId
PauseMenu_Skills_Case03_Case02_Sub01_Case05::
Jump_016_530D:: ; address name
    ld a, [wMenuSelectedMember]
    ld c, a
    ld a, [wTargetRecord]
    cp a, c
    jr nz, Jump_016_531E
    ld a, $FF
    ld [wItemId], a
    jr Jump_016_5321

Jump_016_531E::
    call ItemUsable_Potion

Jump_016_5321::
    call SetWD08D12IfItemRefused
    ret

; entry 8 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldLeaf::
Jump_016_5325:: ; address name
    call ItemUsable_WorldLeaf
    call SetWD08D12IfItemRefused
    ret

; entry 10 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Antidote::
Jump_016_532C:: ; address name
    call ItemUsable_Antidote
    call SetWD08D12IfItemRefused
    ret

; entry 11 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ListPartyMembersWithField55Bit0::
Jump_016_5333:: ; address name
    call ListPartyMembersWithField55Bit0
    call SetWD08D12IfItemRefused
    ret

; entry 12 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wInventorySlot, wItemId
; writes: wItemMessage
PauseMenu_Skills_Case03_Case02_Sub01_Case0C::
Jump_016_533A:: ; address name
    call ItemUsable_Repellent
    ld a, [wInventorySlot]
    cp a, $10
    jr z, Jump_016_5348
    call SetWD08D14IfItemRefused
    ret

Jump_016_5348::
    ld a, [wItemId]
    cp a, $FF
    jr nz, Jump_016_5355
    ld a, $15
    ld [wItemMessage], a
    ret

Jump_016_5355::
    call CollectUniqueEncounterIdsToWD09F
    ret

; entry 15 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_ExitBell::
Jump_016_5359:: ; address name
    call ItemUsable_ExitBell
    call SetWD08D14IfItemRefused
    ret

; entry 17 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wGoldHi, wGoldMid, wGoldLo, wInventory
; writes: wItemId, wItemMessage
PauseMenu_Skills_Case03_Case02_Sub01_Case11::
Jump_016_5360:: ; address name
    call ItemUsable_Repellent
    call SetWD08D14IfItemRefused
    ret z
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_016_5385
    ld a, [wGoldMid]
    or a, a
    jr nz, Jump_016_5385
    ld a, [wGoldLo]
    cp a, $64
    jr nc, Jump_016_5385
    ld a, $FF
    ld [wItemId], a
    ld a, $17
    ld [wItemMessage], a
    ret

Jump_016_5385::
    ld a, [wInventory + $17]
    or a, a
    ret z
    cp a, $FF
    ret z
    ld a, $FF
    ld [wItemId], a
    ld a, $16
    ld [wItemMessage], a
    ret

; entry 18 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wMapObjectCount
; writes: wItemId, wItemMessage
; points at: wMapObjects
PauseMenu_Skills_Case03_Case02_Sub01_Case12::
Jump_016_5398:: ; address name
    call ItemUsable_Warp
    call SetWD08D14IfItemRefused
    ret z
    ld a, [wMapObjectCount]
    or a, a
    jr z, Jump_016_53BB
    ld hl, wMapObjects
    ld a, [wMapObjectCount]
    ld b, a

Jump_016_53AC::
    bit 7, [hl]
    jr z, Jump_016_53C6
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_53AC

Jump_016_53BB::
    ld a, $FF
    ld [wItemId], a
    ld a, $18
    ld [wItemMessage], a
    ret

Jump_016_53C6::
    ret

; entry 19 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WarpWing::
Jump_016_53C7:: ; address name
    call ItemUsable_WarpWing
    call SetWD08D14IfItemRefused
    ret

; when wItemId is $FF (refused): wD08D = $12 (E-0119)
; 6 call sites from 6 routines (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ListPartyMembersWithField55Bit0, PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_Antidote, PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WorldLeaf, PauseMenu_Skills_Case03_Case02_Sub01_Case05, ...)
; reads: wItemId
; writes: wItemMessage
SetWD08D12IfItemRefused::
Func_016_53CE:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret nz
    ld a, $12
    ld [wItemMessage], a
    ret

; when wItemId is $FF (refused): wD08D = $14 (E-0119)
; 5 call sites from 5 routines (e.g. PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_WarpWing, PauseMenu_Skills_Case03_Case02_Sub01_Case12, PauseMenu_Skills_Case03_Case02_Sub01_Case11, PauseMenu_Skills_Case03_Case02_Sub01_ItemUsable_ExitBell, ...)
; reads: wItemId
; writes: wItemMessage
SetWD08D14IfItemRefused::
Func_016_53DA:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret nz
    ld a, $14
    ld [wItemMessage], a
    ret

; only called from PauseMenu_Skills_Case03_Case07 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case07)
; reads: wItemId, wInventorySlot
PauseMenu_Skills_Case03_Case07_Sub01::
Func_016_53E6:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld a, [wInventorySlot]
    rst $00
    dw PauseMenu_Skills_Case03_Case07_Sub01_HealRecordHPByRandomAmount
    dw PauseMenu_Skills_Case03_Case07_Sub01_HealRecordHPByRandomAmount_Case01
    dw FullHealRecordTargetRecord
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case03
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case04
    dw PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount
    dw PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount_Case06
    dw PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount_Case07
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case08
    dw PauseMenu_Skills_Case03_Case07_Sub01_SRAMRecordAddressMapped
    dw PauseMenu_Skills_Case03_Case07_Sub01_SRAMRecordAddressMapped_Case0A
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case0B
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case0C
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case0D
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case0E
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case0F
    dw PauseMenu_Skills_Case03_Case07_Sub01_SetItemMessageTo0B
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case11
    dw PauseMenu_Skills_Case03_Case07_Sub01_Case12
    dw PauseMenu_Skills_Case03_Case07_Sub01_MarkVisitedScreens5x5AroundPlayer

; entry 0 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemEffectAmount, wItemEffectRange, wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_HealRecordHPByRandomAmount::
Jump_016_5418:: ; address name
    ld a, $0A
    ld [wItemEffectAmount], a
    ld a, $1E
    ld [wItemEffectRange], a
    call HealRecordHPByRandomAmount
    ld a, $06
    ld [wItemMessage], a
    ret

; entry 1 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemEffectAmount, wItemEffectRange, wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_HealRecordHPByRandomAmount_Case01::
Jump_016_542B:: ; address name
    ld a, $0F
    ld [wItemEffectAmount], a
    ld a, $4B
    ld [wItemEffectRange], a
    call HealRecordHPByRandomAmount
    ld a, $06
    ld [wItemMessage], a
    ret

; record wD083: copies its word at field $5D (max HP) into field $5B (HP) (StoreHLToRecordField), then wD08D = 6 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case07_Sub01_SRAMRecordAddressMapped)
; reads: wTargetRecord
; writes: wItemMessage
FullHealRecordTargetRecord::
Func_016_543E:: ; address name
    ld a, [wTargetRecord]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, $5B
    call StoreHLToRecordField
    ld a, $06
    ld [wItemMessage], a
    ret

; entry 3 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecordByte0A, wTargetRecord
; writes: wItemEffectAmount, wItemEffectRange, wItemMessage, wTargetRecord
; points at: wPartyCount
PauseMenu_Skills_Case03_Case07_Sub01_Case03::
Jump_016_5457:: ; address name
    ld a, $1E
    ld [wItemEffectAmount], a
    ld a, $5A
    ld [wItemEffectRange], a
    ld a, [wItemRecordByte0A]
    ld [wItemMessage], a
    ld a, $00
    call HealPartyRecordAIfHurt
    ld a, $01
    call HealPartyRecordAIfHurt
    ld a, $02

; A = party index: returns when it is not below wC6FD, when record byte $55 bit 7 is set, or when HP ($5B) already equals max HP ($5D); otherwise Func_016_56AF (a random heal) (E-0120)
; 2 call sites from 1 routine (e.g. PauseMenu_Skills_Case03_Case07_Sub01_Case03)
; reads: wTargetRecord
; writes: wTargetRecord
; points at: wPartyCount
HealPartyRecordAIfHurt::
Func_016_5473:: ; address name
    ld hl, wPartyCount
    cp a, [hl]
    ret nc
    ld [wTargetRecord], a
    call TestTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret z
    call HealRecordHPByRandomAmount
    ret

; entry 4 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecordByte0A, wTargetRecord
; writes: wItemMessage, wTargetRecord
; points at: wPartyCount
PauseMenu_Skills_Case03_Case07_Sub01_Case04::
Jump_016_549B:: ; address name
    ld a, [wItemRecordByte0A]
    ld [wItemMessage], a
    ld a, $00
    call FullHealPartyRecordA
    ld a, $01
    call FullHealPartyRecordA
    ld a, $02

; A = party index: returns when it is not below wC6FD or the record's byte $55 bit 7 is set; otherwise wD083 = A and the record's HP word ($5B) = its max HP word ($5D) (E-0117)
; 2 call sites from 1 routine (e.g. PauseMenu_Skills_Case03_Case07_Sub01_Case04)
; reads: wTargetRecord
; writes: wTargetRecord
; points at: wPartyCount
FullHealPartyRecordA::
Func_016_54AD:: ; address name
    ld hl, wPartyCount
    cp a, [hl]
    ret nc
    ld [wTargetRecord], a
    call TestTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, $5B
    call StoreHLToRecordField
    ret

; entry 5 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemEffectAmount, wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount::
Jump_016_54CD:: ; address name
    ld a, $0F
    ld [wItemEffectAmount], a
    call HealRecordMPByItemEffectAmount
    ld a, $07
    ld [wItemMessage], a
    ret

; entry 6 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemEffectAmount, wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount_Case06::
Jump_016_54DB:: ; address name
    ld a, $1E
    ld [wItemEffectAmount], a
    call HealRecordMPByItemEffectAmount
    ld a, $07
    ld [wItemMessage], a
    ret

; entry 7 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemEffectAmount, wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount_Case07::
Jump_016_54E9:: ; address name
    ld a, $50
    ld [wItemEffectAmount], a
    call HealRecordMPByItemEffectAmount
    ld a, $07
    ld [wItemMessage], a
    ret

; entry 8 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemMessage, wLevelUpGains
PauseMenu_Skills_Case03_Case07_Sub01_Case08::
Jump_016_54F7:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    ld [hl], $00
    ld a, [wTargetRecord]
    ld c, $5B
    call SRAMRecordAddressMapped
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    srl b
    rr c
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, $08
    ld [wItemMessage], a
    ld a, $01
    ld [wLevelUpGains], a
    ret

; entry 9 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemMessage, wLevelUpGains
PauseMenu_Skills_Case03_Case07_Sub01_SRAMRecordAddressMapped::
Jump_016_5522:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    ld [hl], $00
    call FullHealRecordTargetRecord
    ld a, $08
    ld [wItemMessage], a
    ld a, $01
    ld [wLevelUpGains], a
    ret

; entry 10 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wTargetRecord
; writes: wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_SRAMRecordAddressMapped_Case0A::
Jump_016_553A:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 2, [hl]
    ld a, $09
    ld [wItemMessage], a
    ret

; entry 11 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecordByte0A, wTargetRecord
; writes: wItemMessage, wTargetRecord
; points at: wPartyCount
PauseMenu_Skills_Case03_Case07_Sub01_Case0B::
Jump_016_554A:: ; address name
    ld a, [wItemRecordByte0A]
    ld [wItemMessage], a
    ld a, $00
    call ClearPartyRecordFlag55Bit0
    ld a, $01
    call ClearPartyRecordFlag55Bit0
    ld a, $02

; A = party index: returns when it is not below wC6FD or byte $55 bit 7 is set; otherwise clears bit 0 of the record's byte $55 (E-0117)
; 2 call sites from 1 routine (e.g. PauseMenu_Skills_Case03_Case07_Sub01_Case0B)
; reads: wTargetRecord
; writes: wTargetRecord
; points at: wPartyCount
ClearPartyRecordFlag55Bit0::
Func_016_555C:: ; address name
    ld hl, wPartyCount
    cp a, [hl]
    ret nc
    ld [wTargetRecord], a
    call TestTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    res 0, [hl]
    ret

; entry 12 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave, wItemMessage, wItemId
PauseMenu_Skills_Case03_Case07_Sub01_Case0C::
Jump_016_5573:: ; address name
    ld a, $01
    ld [wDataBankSave], a
    ld a, $FF
    ld [wItemMessage], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 13 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; writes: wDataBankSave, wNewRecordByte0D, wItemMessage, wItemId
PauseMenu_Skills_Case03_Case07_Sub01_Case0D::
Jump_016_5583:: ; address name
    ld a, $01
    ld [wDataBankSave], a
    ld a, [wMenuSelectedMember]
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $01
    xor a, $01
    or a, $10
    ld [wNewRecordByte0D], a
    ld a, $FF
    ld [wItemMessage], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 14 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wTalkCountdown, wItemMessage, wItemId
PauseMenu_Skills_Case03_Case07_Sub01_Case0E::
Jump_016_55A5:: ; address name
    ld a, $C8
    ld [wTalkCountdown], a
    ld a, $FF
    ld [wItemMessage], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 15 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave, wItemMessage, wItemId
PauseMenu_Skills_Case03_Case07_Sub01_Case0F::
Jump_016_55B5:: ; address name
    ld a, $04
    ld [wDataBankSave], a
    ld a, $FF
    ld [wItemMessage], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 16 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemMessage
PauseMenu_Skills_Case03_Case07_Sub01_SetItemMessageTo0B::
Jump_016_55C5:: ; address name
    ld a, $0B
    ld [wItemMessage], a
    ret

; entry 17 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, wPendingFieldEvent, wRandomLo, wRandomHi
; writes: wSpriteSlotCount, wScreenSavedFlag, wPendingFieldEvent, wItemId, wItemMessage, wInventory
; points at: wGoldLo, wTextBuf3
PauseMenu_Skills_Case03_Case07_Sub01_Case11::
Jump_016_55CB:: ; address name
    ld a, [wMapType]
    cp a, $80
    jr nz, Jump_016_55E3
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, Jump_016_55E3
    xor a, a
    ld [wSpriteSlotCount], a
    ld [wScreenSavedFlag], a
    ld [wPendingFieldEvent], a

Jump_016_55E3::
    ld hl, wGoldLo
    ld a, [hl]
    sub a, $64
    ld [hl+], a
    ld a, [hl]
    sbc a, $00
    ld [hl+], a
    ld a, [hl]
    sbc a, $00
    ld [hl], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $64
    call Divide24ByA
    ld c, $01
    sub a, $19
    jr c, Jump_016_5675
    ld c, $02
    sub a, $0A
    jr c, Jump_016_5675
    ld c, $04
    sub a, $05
    jr c, Jump_016_5675
    ld c, $06
    sub a, $05
    jr c, Jump_016_5675
    ld c, $07
    sub a, $05
    jr c, Jump_016_5675
    ld c, $08
    sub a, $05
    jr c, Jump_016_5675
    ld c, $09
    sub a, $05
    jr c, Jump_016_5675
    ld c, $0A
    sub a, $05
    jr c, Jump_016_5675
    ld c, $19
    sub a, $05
    jr c, Jump_016_5675
    ld c, $1A
    sub a, $05
    jr c, Jump_016_5675
    ld c, $1B
    sub a, $02
    jr c, Jump_016_5675
    ld c, $1C
    sub a, $01
    jr c, Jump_016_5675
    ld c, $1D
    sub a, $05
    jr c, Jump_016_5675
    ld c, $20
    sub a, $05
    jr c, Jump_016_5675
    ld c, $28
    sub a, $05
    jr c, Jump_016_5675
    ld c, $29
    sub a, $01
    jr c, Jump_016_5675
    ld c, $2A
    sub a, $05
    jr c, Jump_016_5675
    ld c, $2B
    sub a, $01
    jr c, Jump_016_5675
    ld a, $FF
    ld [wItemId], a
    jr Jump_016_5688

Jump_016_5675::
    ld a, c
    ld [wInventory + $17], a
    ld l, c
    ld h, $05
    ld de, wTextBuf3
    call CopyStringHLToDE
    farcall CompactInventory

Jump_016_5688::
    ld a, $0E
    ld [wItemMessage], a
    ret

; entry 18 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode2Byte50, wItemMessage, wItemId
PauseMenu_Skills_Case03_Case07_Sub01_Case12::
Jump_016_568E:: ; address name
    ld a, $01
    ld [wGameMode2Byte50], a
    ld a, $11
    ld [wItemMessage], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 19 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wItemMessage, wItemId
PauseMenu_Skills_Case03_Case07_Sub01_MarkVisitedScreens5x5AroundPlayer::
Jump_016_569E:: ; address name
    farcall MarkVisitedScreens5x5AroundPlayer
    ld a, $1C
    ld [wItemMessage], a
    ld a, $FF
    ld [wItemId], a
    ret

; reads the next table byte, then heals record wD083's HP by wC5E7 / (wD08F + 1) + wD090 (capped at max HP) (E-0122)
; 3 call sites from 3 routines (e.g. HealPartyRecordAIfHurt, PauseMenu_Skills_Case03_Case07_Sub01_HealRecordHPByRandomAmount_Case01, PauseMenu_Skills_Case03_Case07_Sub01_HealRecordHPByRandomAmount)
; reads: wRandomLo, wItemEffectAmount, wItemEffectRange, wTargetRecord
HealRecordHPByRandomAmount::
Func_016_56AF:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, [wItemEffectAmount]
    inc a
    call DivideBByA
    ld b, a
    ld a, [wItemEffectRange]
    add a, b
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordHPCapped
    ret

; heals record wD083's MP by wD08F (capped at max MP) (E-0122)
; 3 call sites from 3 routines (e.g. PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount_Case07, PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount_Case06, PauseMenu_Skills_Case03_Case07_Sub01_HealRecordMPByItemEffectAmount)
; reads: wItemEffectAmount, wTargetRecord
HealRecordMPByItemEffectAmount::
Func_016_56CC:: ; address name
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordMPCapped
    ret

; Z clear when bit 7 of byte $55 of record wD083 is set (SRAMRecordAddressMapped); HL points at it (E-0114)
; 3 call sites from 3 routines (e.g. ClearPartyRecordFlag55Bit0, FullHealPartyRecordA, HealPartyRecordAIfHurt)
; reads: wTargetRecord
TestTargetRecordFlag55Bit7::
Func_016_56D9:: ; address name
    ld a, [wTargetRecord]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret

; for special maps copies the eight monster entries of the current screen (AddressOfKeyWorldMonstersEntryForCurrentScreen) to wD09F, removes duplicates and stores the count in wD09D; normal maps use Func_00A_4D5E (E-0129)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02_Sub01_Case0C)
; reads: wMapType, wWorkBuf
; writes: wWorkBuf
CollectUniqueEncounterIdsToWD09F::
Func_016_56E4:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_016_56F2
    farcall CollectUniqueEncounterIdsToWD09F_Sub01
    ret

Jump_016_56F2::
    call AddressOfKeyWorldMonstersEntryForCurrentScreen
    ld de, wWorkBuf + $2
    ld b, $08

Jump_016_56FA::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    and a, $01
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_56FA
    ld hl, wWorkBuf + $4
    ld a, [wWorkBuf + $2]
    ld e, a
    ld a, [wWorkBuf + $3]
    ld d, a
    ld bc, $0707

Jump_016_5713::
    push bc
    push hl

Jump_016_5715::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_016_5728
    ld a, [hl]
    cp a, d
    jr nz, Jump_016_5728
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    ld a, $FF
    ld [hl-], a
    ld [hl+], a

Jump_016_5728::
    inc hl
    dec c
    jr nz, Jump_016_5715
    pop hl
    pop bc

Jump_016_572E::
    dec c
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, e
    and a, d
    cp a, $FF
    jr nz, Jump_016_573E
    dec b
    jr nz, Jump_016_572E
    jr Jump_016_5741

Jump_016_573E::
    dec b
    jr nz, Jump_016_5713

Jump_016_5741::
    ld de, wWorkBuf + $2
    ld hl, wWorkBuf + $2
    ld bc, $0800

Jump_016_574A::
    ld a, [hl+]
    ld [de], a
    cp a, $FF
    ld a, [hl]
    jr nz, Jump_016_5755
    cp a, $FF
    jr z, Jump_016_5759

Jump_016_5755::
    inc de
    ld [de], a
    inc de
    inc c

Jump_016_5759::
    inc hl
    dec b
    jr nz, Jump_016_574A
    ld a, c
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; HL = wCD10 + 2 * an index from the current map screen and the wCD70 table (index $20 when bit 3 of hFF8C is set) (E-0127)
; 1 call site from 1 routine (e.g. CollectUniqueEncounterIdsToWD09F)
; reads: hPlayerStateFlags, wMapType, hMapScreenY, hMapScreenX, wKeyWorldFloor
; points at: wKeyWorldAreas, wKeyWorldMonsters, wKeyWorldFloorInfo
AddressOfKeyWorldMonstersEntryForCurrentScreen::
Func_016_5766:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_016_57C4
    ld a, [wMapType]
    and a, $07
    cp a, $01
    jr z, Jump_016_5778
    or a, a
    jr nz, Jump_016_5795

Jump_016_5778::
    ldh a, [hMapScreenY]
    srl a
    and a, $FE
    ld c, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add a, c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    add a, a
    add a, a
    add a, c
    ld c, a
    jr Jump_016_57C6

Jump_016_5795::
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    push af
    and a, $0F
    srl a
    and a, $FE
    ld c, a
    pop af
    swap a
    and a, $0F
    srl a
    srl a
    add a, c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    add a, a
    add a, a
    add a, a
    ld c, a
    jr Jump_016_57C6

Jump_016_57C4::
    ld c, $20

Jump_016_57C6::
    ld a, c
    add a, a
    ld hl, wKeyWorldMonsters
    add_a_to_hl
    ret

; adds HL to record A's HP (field $5B), capped at its max HP (field $5D), through Func_016_58CC (E-0122)
; 2 call sites from 2 routines (e.g. HealRecordHPByRandomAmount, ItemApply_Herb)
AddHLToRecordHPCapped::
Func_016_57D1:: ; address name
    push af
    push hl
    ld c, $5D
    call SRAMRecordAddressMapped
    pop de
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    pop af
    push bc
    ld c, $5B
    call SRAMRecordAddressMapped
    pop bc
    call AddDEToWordAtHLCappedAtBC
    ret

; adds HL to record A's MP (field $5F), capped at its max MP (field $61), through Func_016_58CC (E-0122)
; 2 call sites from 2 routines (e.g. HealRecordMPByItemEffectAmount, ItemApply_Potion)
AddHLToRecordMPCapped::
Func_016_57E8:: ; address name
    push af
    push hl
    ld c, $61
    call SRAMRecordAddressMapped
    pop de
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    pop af
    push bc
    ld c, $5F
    call SRAMRecordAddressMapped
    pop bc
    call AddDEToWordAtHLCappedAtBC
    ret

; only called from ItemApply_ATKseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_ATKseed)
ItemApply_ATKseed_MapIndexViaPartyListKeepHL::
Func_016_57FF:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $63
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_DEFseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_DEFseed)
ItemApply_DEFseed_MapIndexViaPartyListKeepHL::
Func_016_580B:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $65
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_AGLseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_AGLseed)
ItemApply_AGLseed_MapIndexViaPartyListKeepHL::
Func_016_5817:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $67
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_INTseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_INTseed)
ItemApply_INTseed_MapIndexViaPartyListKeepHL::
Func_016_5823:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $69
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_LifeAcorn (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_LifeAcorn)
ItemApply_LifeAcorn_MapIndexViaPartyListKeepHL::
Func_016_582F:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $5D
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_MysticNut (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_MysticNut)
ItemApply_MysticNut_MapIndexViaPartyListKeepHL::
Func_016_583B:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $61
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_Quest (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Quest)
ItemApply_Quest_MapIndexViaPartyListKeepHL::
Func_016_5847:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $6F
    ld e, $FF
    call AddToRecordFieldByteCapped
    ret

; only called from ItemApply_Horror (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Horror)
ItemApply_Horror_MapIndexViaPartyListKeepHL::
Func_016_5852:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $6F
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; only called from ItemApply_BeNice (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_BeNice)
ItemApply_BeNice_MapIndexViaPartyListKeepHL::
Func_016_585D:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $70
    ld e, $FF
    call AddToRecordFieldByteCapped
    ret

; only called from ItemApply_Cheater (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Cheater)
ItemApply_Cheater_MapIndexViaPartyListKeepHL::
Func_016_5868:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $70
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; only called from ItemApply_Smart (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Smart)
ItemApply_Smart_MapIndexViaPartyListKeepHL::
Func_016_5873:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $72
    ld e, $FF
    call AddToRecordFieldByteCapped
    ret

; only called from ItemApply_Comedy (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Comedy)
ItemApply_Comedy_MapIndexViaPartyListKeepHL::
Func_016_587E:: ; address name
    call MapIndexViaPartyListKeepHL
    ld c, $72
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; for the record selected through wC6FE, applies Func_016_58E0 to field $6B (E-0122)
; 2 call sites from 2 routines (e.g. ItemApply_BadMeat, ItemApply_BeefJerky)
ApplyMeatToRecordField6B::
Func_016_5889:: ; address name
    call MapIndexViaPartyListKeepHL
    push hl
    ld c, $6B
    call SRAMRecordAddress
    pop de
    call ApplyMeatToRecordField6B_Sub01
    ret

; field C of record A: adds E, capped at the limit passed in DE's partner (Func_016_58B8) (E-0122)
; 3 call sites from 3 routines (e.g. ItemApply_Smart_MapIndexViaPartyListKeepHL, ItemApply_BeNice_MapIndexViaPartyListKeepHL, ItemApply_Quest_MapIndexViaPartyListKeepHL)
AddToRecordFieldByteCapped::
Func_016_5897:: ; address name
    push hl
    push de
    call SRAMRecordAddress
    pop bc
    pop de
    call AddEToByteAtHLCappedAtC
    ret

; field C of record A: subtracts E, floored at the limit (Func_016_58C2) (E-0122)
; 3 call sites from 3 routines (e.g. ItemApply_Comedy_MapIndexViaPartyListKeepHL, ItemApply_Cheater_MapIndexViaPartyListKeepHL, ItemApply_Horror_MapIndexViaPartyListKeepHL)
SubtractFromRecordFieldByteFloored::
Func_016_58A2:: ; address name
    push hl
    push de
    call SRAMRecordAddress
    pop bc
    pop de
    call SubtractEFromByteAtHLFlooredAtC
    ret

; field C of record A: adds the amount, capped at the limit (Func_016_58CC) (E-0122)
; 6 call sites from 6 routines (e.g. ItemApply_MysticNut_MapIndexViaPartyListKeepHL, ItemApply_LifeAcorn_MapIndexViaPartyListKeepHL, ItemApply_INTseed_MapIndexViaPartyListKeepHL, ItemApply_AGLseed_MapIndexViaPartyListKeepHL, ...)
AddToRecordFieldWordCapped::
Func_016_58AD:: ; address name
    push hl
    push de
    call SRAMRecordAddress
    pop bc
    pop de
    call AddDEToWordAtHLCappedAtBC
    ret

; [HL] += E, capped at C (also on overflow) (E-0122)
; 1 call site from 1 routine (e.g. AddToRecordFieldByteCapped)
AddEToByteAtHLCappedAtC::
Func_016_58B8:: ; address name
    ld a, [hl]
    add a, e
    jr c, Jump_016_58BF
    cp a, c
    jr c, Jump_016_58C0

Jump_016_58BF::
    ld a, c

Jump_016_58C0::
    ld [hl], a
    ret

; [HL] -= E, floored at C (also on underflow) (E-0122)
; 1 call site from 1 routine (e.g. SubtractFromRecordFieldByteFloored)
SubtractEFromByteAtHLFlooredAtC::
Func_016_58C2:: ; address name
    ld a, [hl]
    sub a, e
    jr c, Jump_016_58C9
    cp a, c
    jr nc, Jump_016_58CA

Jump_016_58C9::
    ld a, c

Jump_016_58CA::
    ld [hl], a
    ret

; the word at HL += DE, capped at BC (also on overflow) (E-0124)
; 3 call sites from 3 routines (e.g. AddHLToRecordMPCapped, AddHLToRecordHPCapped, AddToRecordFieldWordCapped)
AddDEToWordAtHLCappedAtBC::
Func_016_58CC:: ; address name
    push hl
    deref_hl
    add hl, de
    jr c, Jump_016_58D9
    ld a, l
    sub a, c
    ld a, h
    sbc a, b
    jr nc, Jump_016_58DB

Jump_016_58D9::
    ld c, l
    ld b, h

Jump_016_58DB::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; only called from ApplyMeatToRecordField6B (E-0047)
; 1 call site from 1 routine (e.g. ApplyMeatToRecordField6B)
ApplyMeatToRecordField6B_Sub01::
Func_016_58E0:: ; address name
    push hl
    deref_hl
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    jr nc, Jump_016_58EF
    ld hl, $0000

Jump_016_58EF::
    ld e, l
    ld d, h
    pop hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    ret

; A = record (SRAMRecordAddressMapped), C = field offset: stores the low byte of the caller's HL (moved to C) at that field (E-0114)
; no direct call (reached through a table, a jump or a vector)
StoreCToRecordField:: ; heuristic: follows a terminator; C0
Func_016_58F6:: ; address name
    push hl
    call SRAMRecordAddressMapped
    pop bc
    ld [hl], c
    ret

; A = record (SRAMRecordAddressMapped), C = field offset: stores HL (low byte first) at that field (E-0103)
; 5 call sites from 5 routines (e.g. FullHealPartyRecordA, FullHealRecordTargetRecord, ItemApply_WorldLeaf, ItemApply_ElfWater, ...)
StoreHLToRecordField::
Func_016_58FD:: ; address name
    push hl
    call SRAMRecordAddressMapped
    pop bc
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; MapIndexViaPartyList with HL preserved (E-0072)
; 13 call sites from 13 routines (e.g. ApplyMeatToRecordField6B, ItemApply_Comedy_MapIndexViaPartyListKeepHL, ItemApply_Smart_MapIndexViaPartyListKeepHL, ItemApply_Cheater_MapIndexViaPartyListKeepHL, ...)
MapIndexViaPartyListKeepHL::
Func_016_5906:: ; address name
    push hl
    call MapIndexViaPartyList
    pop hl
    ret

; toggles the sort order in wC836 and sorts the 24 inventory slots by the key table Data_016_599E or Data_016_5A0E (empty slots last) (E-0128)
; 3 call sites from 3 routines (e.g. PauseMenu_Items_Case00_Case01, RunBattleSetup_Case02_Case02, PauseMenu_State4_Sub02_Case00_Case01)
; reads: wGameFlags836, wWorkBuf
; writes: wWorkBuf, wGameFlags836
; points at: wInventory
SortInventory::
Func_016_590C:: ; address name
    ld hl, wWorkBuf + $2
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld bc, $0018
    ld a, $FF
    call FillBytes
    ld a, [wGameFlags836]
    bit 7, a
    jr nz, Jump_016_5928
    xor a, $01

Jump_016_5928::
    res 7, a
    ld [wGameFlags836], a
    ld de, InventorySortKeysA
    bit 0, a
    jr z, Jump_016_5937
    ld de, InventorySortKeysB

Jump_016_5937::
    ld hl, wInventory
    ld b, $18

Jump_016_593C::
    push bc
    push hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_016_5944
    xor a, a

Jump_016_5944::
    ld l, a
    ld h, $00
    add hl, de
    ld a, [wWorkBuf]
    ld c, a
    ld a, [wWorkBuf + $1]
    ld b, a
    ld a, [hl]
    ld [bc], a
    inc bc
    ld a, c
    ld [wWorkBuf], a
    ld a, b
    ld [wWorkBuf + $1], a
    pop hl
    pop bc
    inc hl
    dec b
    jr nz, Jump_016_593C
    ld a, $18
    ld [wWorkBuf], a

Jump_016_5966::
    ld hl, wWorkBuf + $2
    ld de, wWorkBuf + $3
    ld b, $17
    ld c, $00

Jump_016_5970::
    ld a, [de]
    cp a, [hl]
    jr nc, Jump_016_597C
    push af
    ld a, [hl]
    ld [de], a
    pop af
    ld [hl], a
    call SwapInventorySlotCWithNext

Jump_016_597C::
    inc de
    inc hl
    inc c
    dec b
    jr nz, Jump_016_5970
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    jr nz, Jump_016_5966
    ret

; swaps wInventory[C] and wInventory[C + 1]; HL kept (E-0118)
; 1 call site from 1 routine (e.g. SortInventory)
; points at: wInventory
SwapInventorySlotCWithNext::
Func_016_598C:: ; address name
    push hl
    ld hl, wInventory
    ld a, c
    add_a_to_hl
    ld a, [hl+]
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    pop hl
    ret

; E-0229 (C1: SortInventory sorts the 24 inventory slots by the byte at $599E + item id (one sort order of wGameFlags836); 112 bytes end at InventorySortKeysB).
; record: sort key for this item id
InventorySortKeysA::
Data_016_599E:: ; address name
    db $FF ; id 0
    db $08 ; id 1
    db $09 ; id 2
    db $0A ; id 3
    db $0B ; id 4
    db $0C ; id 5
    db $0D ; id 6
    db $0E ; id 7
    db $0F ; id 8
    db $10 ; id 9
    db $11 ; id 10
    db $12 ; id 11
    db $13 ; id 12
    db $20 ; id 13
    db $21 ; id 14
    db $22 ; id 15
    db $23 ; id 16
    db $24 ; id 17
    db $25 ; id 18
    db $1A ; id 19
    db $1B ; id 20
    db $1C ; id 21
    db $1D ; id 22
    db $1E ; id 23
    db $1F ; id 24
    db $14 ; id 25
    db $15 ; id 26
    db $16 ; id 27
    db $17 ; id 28
    db $18 ; id 29
    db $19 ; id 30
    db $05 ; id 31
    db $06 ; id 32
    db $00 ; id 33
    db $4B ; id 34
    db $4C ; id 35
    db $4D ; id 36
    db $4E ; id 37
    db $4F ; id 38
    db $50 ; id 39
    db $01 ; id 40
    db $02 ; id 41
    db $03 ; id 42
    db $06 ; id 43
    db $25 ; id 44
    db $26 ; id 45
    db $04 ; id 46
    db $FF ; id 47
    db $51 ; id 48
    db $52 ; id 49
    db $53 ; id 50
    db $54 ; id 51
    db $55 ; id 52
    db $56 ; id 53
    db $57 ; id 54
    db $58 ; id 55
    db $59 ; id 56
    db $5A ; id 57
    db $5B ; id 58
    db $5C ; id 59
    db $5D ; id 60
    db $5E ; id 61
    db $FF ; id 62
    db $FF ; id 63
    db $27 ; id 64
    db $28 ; id 65
    db $29 ; id 66
    db $2A ; id 67
    db $2B ; id 68
    db $2C ; id 69
    db $2D ; id 70
    db $2E ; id 71
    db $2F ; id 72
    db $30 ; id 73
    db $31 ; id 74
    db $32 ; id 75
    db $33 ; id 76
    db $34 ; id 77
    db $35 ; id 78
    db $36 ; id 79
    db $37 ; id 80
    db $38 ; id 81
    db $39 ; id 82
    db $3A ; id 83
    db $3B ; id 84
    db $3C ; id 85
    db $3D ; id 86
    db $3E ; id 87
    db $3F ; id 88
    db $40 ; id 89
    db $41 ; id 90
    db $42 ; id 91
    db $43 ; id 92
    db $44 ; id 93
    db $45 ; id 94
    db $46 ; id 95
    db $47 ; id 96
    db $48 ; id 97
    db $49 ; id 98
    db $FF ; id 99
    db $FF ; id 100
    db $FF ; id 101
    db $FF ; id 102
    db $FF ; id 103
    db $FF ; id 104
    db $FF ; id 105
    db $FF ; id 106
    db $FF ; id 107
    db $FF ; id 108
    db $FF ; id 109
    db $FF ; id 110
    db $FF ; id 111

; E-0229 (C1: the key table of the other sort order of SortInventory; 112 bytes).
; record: sort key for this item id
InventorySortKeysB::
Data_016_5A0E:: ; address name
    db $FF ; id 0
    db $00 ; id 1
    db $01 ; id 2
    db $02 ; id 3
    db $03 ; id 4
    db $04 ; id 5
    db $05 ; id 6
    db $06 ; id 7
    db $07 ; id 8
    db $08 ; id 9
    db $09 ; id 10
    db $0A ; id 11
    db $0B ; id 12
    db $1E ; id 13
    db $1F ; id 14
    db $20 ; id 15
    db $21 ; id 16
    db $22 ; id 17
    db $23 ; id 18
    db $18 ; id 19
    db $19 ; id 20
    db $1A ; id 21
    db $1B ; id 22
    db $1C ; id 23
    db $1D ; id 24
    db $12 ; id 25
    db $13 ; id 26
    db $14 ; id 27
    db $15 ; id 28
    db $16 ; id 29
    db $17 ; id 30
    db $4E ; id 31
    db $4F ; id 32
    db $49 ; id 33
    db $0C ; id 34
    db $0D ; id 35
    db $0E ; id 36
    db $0F ; id 37
    db $10 ; id 38
    db $11 ; id 39
    db $4A ; id 40
    db $4B ; id 41
    db $4C ; id 42
    db $50 ; id 43
    db $24 ; id 44
    db $25 ; id 45
    db $4D ; id 46
    db $FF ; id 47
    db $51 ; id 48
    db $52 ; id 49
    db $53 ; id 50
    db $54 ; id 51
    db $55 ; id 52
    db $56 ; id 53
    db $57 ; id 54
    db $58 ; id 55
    db $59 ; id 56
    db $5A ; id 57
    db $5B ; id 58
    db $5C ; id 59
    db $5D ; id 60
    db $5E ; id 61
    db $FF ; id 62
    db $FF ; id 63
    db $26 ; id 64
    db $27 ; id 65
    db $28 ; id 66
    db $29 ; id 67
    db $2A ; id 68
    db $2B ; id 69
    db $2C ; id 70
    db $2D ; id 71
    db $2E ; id 72
    db $2F ; id 73
    db $30 ; id 74
    db $31 ; id 75
    db $32 ; id 76
    db $33 ; id 77
    db $34 ; id 78
    db $35 ; id 79
    db $36 ; id 80
    db $37 ; id 81
    db $38 ; id 82
    db $39 ; id 83
    db $3A ; id 84
    db $3B ; id 85
    db $3C ; id 86
    db $3D ; id 87
    db $3E ; id 88
    db $3F ; id 89
    db $40 ; id 90
    db $41 ; id 91
    db $42 ; id 92
    db $43 ; id 93
    db $44 ; id 94
    db $45 ; id 95
    db $46 ; id 96
    db $47 ; id 97
    db $48 ; id 98
    db $FF ; id 99
    db $FF ; id 100
    db $FF ; id 101
    db $FF ; id 102
    db $FF ; id 103
    db $FF ; id 104
    db $FF ; id 105
    db $FF ; id 106
    db $FF ; id 107
    db $FF ; id 108
    db $FF ; id 109
    db $FF ; id 110
    db $FF ; id 111

; monster id = wSpeciesIdLo/Hi: HL = wSpeciesFlags + id / 8, B = the mask 1 << (id & 7) (Data_016_5AA7); C = A = [HL] & B, so Z is set when the species' bit is clear (E-0070)
; 12 call sites from 12 routines (e.g. SetSpeciesFlag, CountSpeciesPerFamilyFlaggedOrListed, BattleEnd_Step3_Sub01_Sub01, BattleEnd_Step5_Case00_Sub01, ...)
; reads: wSpeciesIdLo, wSpeciesIdHi
; points at: wSpeciesFlags
TestSpeciesFlag::
Func_016_5A7E:: ; address name
    ld a, [wSpeciesIdLo]
    ld c, a
    ld a, [wSpeciesIdHi]
    ld b, a
    ld a, c
    and a, $07
    ld hl, Data_016_5AA7
    add_a_to_hl
    ld a, [hl]
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    ld hl, wSpeciesFlags
    add hl, bc
    ld b, a
    ld a, [hl]
    and a, b
    ld c, a
    ret

; address loaded by TestSpeciesFlag
Data_016_5AA7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $04, $08, $10, $20, $40, $80

; sets the bit of monster id wSpeciesIdLo/Hi in wSpeciesFlags (TestSpeciesFlag) and clears the high nibble of wC7FB (E-0070)
; 8 call sites from 8 routines (e.g. RunBattleEndStep5SubSteps_Case01, CreateMonsterRecordOfKindTemp1_Sub01_Sub01, GameMode5_Update_Case01_Case06_Case06_Sub01, MedalPrizeMenu_Case05_Case0E_Sub01, ...)
; reads: wSpeciesFlagCount
; writes: wSpeciesFlagCount
SetSpeciesFlag::
Func_016_5AAF:: ; address name
    call TestSpeciesFlag
    ld a, b
    or a, [hl]
    ld [hl], a
    push af
    ld a, [wSpeciesFlagCount]
    and a, $0F
    ld [wSpeciesFlagCount], a
    pop af
    ret

; zeroes the 11 per-family counters at wD09D, then for monster ids 0-372 ($175 is the end) skips unused ids (family $FF) and adds 1 to wD09D[family] when the species' flag is set (TestSpeciesFlag) or, when it is not, when Func_015_68FA finds the id in the list at wC7FC (wD7F5 not $FF). Leaves wSpeciesIdLo/Hi = 373 (E-0070)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case05_Case00, TotalSpeciesFlaggedOrListed)
; reads: wSpeciesRecord, wSpeciesIdLo, wSpeciesIdHi, wArg5
; writes: wSpeciesIdLo, wSpeciesIdHi, wArg1, wArg2, wArg3, wArg4
; points at: wWorkBuf, wMonsterLibraryBuf
CountSpeciesPerFamilyFlaggedOrListed::
Func_016_5AC0:: ; address name
    xor a, a
    ld hl, wWorkBuf
    ld bc, $000B
    call FillBytes
    xor a, a
    ld [wSpeciesIdLo], a
    ld [wSpeciesIdHi], a

Jump_016_5AD1::
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    cp a, $FF
    jr z, Jump_016_5B16
    ld de, wWorkBuf
    add a, e
    ld e, a
    jr nc, Jump_016_5AE6
    inc d

Jump_016_5AE6::
    call TestSpeciesFlag
    jr nz, Jump_016_5B13
    push de
    ld a, [wSpeciesIdLo]
    ld [wArg1], a
    ld a, [wSpeciesIdHi]
    ld [wArg2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    pop de
    ld a, [wArg5]
    cp a, $FF
    jr z, Jump_016_5B13
    jr Jump_016_5B16

Jump_016_5B13::
    ld a, [de]
    inc a
    ld [de], a

Jump_016_5B16::
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    inc hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    ld bc, $0175
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_016_5AD1
    ret

; only called from BattleEnd_Step3_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub01)
; reads: wSpeciesRecord, wSpeciesIdLo, wSpeciesIdHi
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wWorkBuf
BattleEnd_Step3_Sub01_Sub01::
Func_016_5B33:: ; address name
    xor a, a
    ld hl, wWorkBuf
    ld bc, $000B
    call FillBytes
    xor a, a
    ld [wSpeciesIdLo], a
    ld [wSpeciesIdHi], a

Jump_016_5B44::
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    cp a, $FF
    jr z, Jump_016_5B61
    ld de, wWorkBuf
    add a, e
    ld e, a
    jr nc, Jump_016_5B59
    inc d

Jump_016_5B59::
    call TestSpeciesFlag
    jr z, Jump_016_5B61
    ld a, [de]
    inc a
    ld [de], a

Jump_016_5B61::
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    inc hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    ld bc, $0175
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_016_5B44
    ret

; only called from BattleEnd_Step5_Case00 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case00)
; reads: wLinkMode, wBattleKind, wDisplaySlot, wRandomLo, wRandomHi, wSpeciesRecord, wBattleEndFlag, wBattleMeter
; writes: wBattleFoeCount, wSpeciesIdLo, wSpeciesIdHi, wDisplaySlot
; points at: wBattleInitA1, wBattleMonsterId
BattleEnd_Step5_Case00_Sub01::
Func_016_5B7E:: ; address name
    ld a, $01
    ld [wBattleFoeCount], a
    ld a, [wLinkMode]
    or a, a
    jp nz, Jump_016_5CF5
    ld a, [wBattleKind]
    cp a, $03
    jp z, Jump_016_5CF5
    cp a, $04
    jp z, Jump_016_5CF5
    cp a, $05
    jp z, Jump_016_5CF5
    cp a, $08
    jp nc, Jump_016_5CF5
    ld a, [wDisplaySlot]
    cp a, $FF
    jp z, Jump_016_5CF5
    cp a, $04
    jp c, Jump_016_5CF5
    cp a, $07
    jp nc, Jump_016_5CF5
    and a, $03
    ld hl, wBattleInitA1
    add_a_to_hl
    ld a, [hl]
    cp a, $07
    jp z, Jump_016_5CF5
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    call TestSpeciesFlag
    ld de, Data_016_5D0B
    jr nz, Jump_016_5C15
    farcall LoadSpeciesRecord
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $C8
    call DivideHLByA
    ld b, a
    ld a, [wSpeciesRecord + $4]
    cp a, $07
    jp z, Jump_016_5CF5
    ld hl, Data_016_5CFB
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jp nc, Jump_016_5CFA
    ld a, [wBattleEndFlag]
    or a, a
    jp nz, Jump_016_5CFA
    ld de, Data_016_5D03

Jump_016_5C15::
    ld a, [wBattleMeter]
    ld c, a
    ld a, [wBattleMeter + $1]
    ld b, a
    ld a, [wDisplaySlot]
    and a, $03
    ld hl, wBattleInitA1
    add_a_to_hl
    ld a, [hl]
    add a, e
    ld e, a
    jr nc, Jump_016_5C30
    inc d

Jump_016_5C30::
    ld a, [de]
    ld h, b
    ld l, c
    or a, a
    jp z, Jump_016_5CFA
    cp a, $07
    jp z, Jump_016_5CF5
    ld a, [wBattleEndFlag]
    or a, a
    jp nz, Jump_016_5CFA
    ld a, [de]
    cp a, $01
    jr z, Jump_016_5C77
    cp a, $02
    jr z, Jump_016_5C7C
    cp a, $03
    jr z, Jump_016_5C7F
    cp a, $04
    jr z, Jump_016_5C81
    cp a, $05
    jr z, Jump_016_5C87
    cp a, $06
    jr z, Jump_016_5C8E
    cp a, $11
    jr z, Jump_016_5CA0
    cp a, $12
    jr z, Jump_016_5CA2
    cp a, $13
    jr z, Jump_016_5CAC
    cp a, $14
    jr z, Jump_016_5CAC
    cp a, $15
    jr z, Jump_016_5CAC
    cp a, $16
    jr z, Jump_016_5CBA
    jp Jump_016_5CF5

Jump_016_5C77::
    add hl, hl
    add hl, hl
    add hl, bc
    jr Jump_016_5CBF

Jump_016_5C7C::
    add hl, hl
    jr Jump_016_5CBF

Jump_016_5C7F::
    jr Jump_016_5CBF

Jump_016_5C81::
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5C87::
    ld a, $05
    call DivideHLByA
    jr Jump_016_5CBF

Jump_016_5C8E::
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5CA0::
    jr Jump_016_5CBF

Jump_016_5CA2::
    srl h
    rr l
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5CAC::
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5CBA::
    ld a, $14
    call DivideHLByA

Jump_016_5CBF::
    push hl
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $5B
    call DivideHLByA
    add a, $0A
    ld c, a
    ld b, $00
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jr nz, Jump_016_5CF5
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $64
    call DivideHLByA
    inc a
    cp a, $5B
    jr c, Jump_016_5CFA

Jump_016_5CF5::
    ld a, $FF
    ld [wDisplaySlot], a

Jump_016_5CFA::
    ret

; address loaded by BattleEnd_Step5_Case00_Sub01
Data_016_5CFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $32, $18, $0A, $06, $02, $01, $00

; address loaded by BattleEnd_Step5_Case00_Sub01
Data_016_5D03:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $07

; address loaded by BattleEnd_Step5_Case00_Sub01
Data_016_5D0B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $11, $12, $13, $14, $15, $16, $07

; only called from BattleEnd_Step5_Case01_Case01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case01_Case01)
; reads: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01::
Func_016_5D13:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case00
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case01
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case02
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case03
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case04
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case05
    dw BattleEnd_Step5_Case01_Case01_Sub01_ShowStringCategory5_Bank16AndStep
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case03
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case04
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case09
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case0A
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case0B
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case0C
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case0D
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case0E
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case0F
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case10
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case11
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case12
    dw BattleEnd_Step5_Case01_Case01_Sub01_AdvanceBattleSubStep
    dw BattleEnd_Step5_Case01_Case01_Sub01_ShowStringCategory5_Bank16
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case15
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case16
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case17
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case18
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case19
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case1A
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case1B
    dw BattleEnd_Step5_Case01_Case01_Sub01_Case1C

; entry 0 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleKind, hTemp0
; writes: wStringIndex, wSubMenuCursor2, wMenuOption, wCommandCursorMax
; points at: wBattleSubStep, wTextBuf0
BattleEnd_Step5_Case01_Case01_Sub01_Case00::
Jump_016_5D51:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld de, wTextBuf0
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, [wBattleKind]
    cp a, $08
    jr nc, Jump_016_5D71
    and a, $01
    jr z, Jump_016_5D7A
    farcall KeyWorldAreaEncounterIndex
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_016_5D7A

Jump_016_5D71::
    ld a, $1E
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

Jump_016_5D7A::
    call CountRecordsByField6E
    xor a, a
    ld [wSubMenuCursor2], a
    ld [wMenuOption], a
    ld [wCommandCursorMax], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleStep
BattleEnd_Step5_Case01_Case01_Sub01_Case01::
Jump_016_5D8C:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld [wBattleSubStep], a
    ret

; entry 2 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wStringIndex
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case02::
Jump_016_5DA0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0B
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wMenuState, wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case03::
Jump_016_5DB2:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld de, wScreenTileBuffer + $10E
    ld hl, vBGMap0 + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM_Bank16
    xor a, a
    ld [wMenuState], a
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wBattleSubStep
; points at: wMenuState, wBattleSubStep, wTextBuf0
BattleEnd_Step5_Case01_Case01_Sub01_Case04::
Jump_016_5DE6:: ; address name
    ld de, wMenuState
    ld hl, Data_016_66E7
    call SetDEFlagOnBButton
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [de]
    or a, a
    ret z
    ld de, wTextBuf0
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, $0C
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wFarmLevel, wTemp0, wTemp1
; writes: wBattleSubStep
; points at: wBattleSubStep, wBattleSubPhase
BattleEnd_Step5_Case01_Case01_Sub01_Case05::
Jump_016_5E0B:: ; address name
    ld a, $BC
    ld hl, vBGMap0 + $12F
    call WriteVRAMByte
    ld a, [wFarmLevel]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld a, [wTemp0]
    ld b, a
    ld a, [wTemp1]
    add a, b
    cp a, [hl]
    jr c, Jump_016_5E2E
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_016_5E2E::
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 6 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_ShowStringCategory5_Bank16AndStep::
Jump_016_5E3B:: ; address name
    ld a, $0D
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wStringIndex
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case09::
Jump_016_5E48:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0E
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wMenuState, wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wScreenTileBuffer, wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case0A::
Jump_016_5E5A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $6C
    call QueueSoundEffect
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    xor a, a
    ld [wMenuState], a
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor2, wTemp1
; writes: wMenuState, wListPage, wStringIndex, wBattleSubStep
; points at: wMenuState, wBattleSubStep, wScreenTileBuffer
BattleEnd_Step5_Case01_Case01_Sub01_Case0B::
Jump_016_5E96:: ; address name
    ld de, wMenuState
    ld hl, Data_016_6701
    call SetDEFlagOnBButton
    ret z
    ld a, [wJoypadPressed]
    and a, $02
    jr nz, Jump_016_5ED7
    ld a, [de]
    ld e, a
    xor a, a
    ld [wMenuState], a
    ld a, [wSubMenuCursor2]
    ld [wListPage], a
    ld hl, wBattleSubStep
    inc [hl]
    ld a, e
    or a, a
    ret z
    call CountRecordsByField6E
    ld a, [wTemp1]
    or a, a
    jr nz, Jump_016_5ED1
    ld a, $0F
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

Jump_016_5ED1::
    ld a, $16
    ld [wBattleSubStep], a
    ret

Jump_016_5ED7::
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, $06
    ld [wBattleSubStep], a
    ret

; entry 12 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wListEntries, wScreenTileBuffer, wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case0C::
Jump_016_5EEC:: ; address name
    ld hl, wListEntries
    ld bc, $001E
    ld a, $FF
    call FillBytes
    farcall CopyRectRecord796FToScreenBufferAndPlaySound6C
    call ListPartyAndStoredRecordsForPage
    call DrawRecordListPageWithNumbers
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $080B
    call CopyRect32StrideToVRAM_Bank16
    ld hl, vBGMap0 + $12B
    ld a, $BC
    call WriteVRAMByte
    ld a, $11
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListPage
; writes: wSubMenuCursor2, wBattleSubStep
; points at: wMenuState, wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case0D::
Jump_016_5F24:: ; address name
    ld de, wMenuState
    ld hl, Data_016_66F7
    call MovePagedListCursor
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_016_5F38
    call DrawRecordListPageWithNumbers
    ret

Jump_016_5F38::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_5F4D
    ld a, [wListPage]
    ld [wSubMenuCursor2], a
    call ShowRecordNameString12
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_016_5F4D::
    bit 1, a
    ret z
    ld a, [wListPage]
    ld [wSubMenuCursor2], a
    ld a, $09
    ld [wBattleSubStep], a
    ret

; entry 14 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; writes: wScreenTileBuffer, wMenuSubState, wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case0E::
Jump_016_5F5C:: ; address name
    ld a, [wMenuState]
    ld hl, Data_016_66F7
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $BB
    ld [wScreenTileBuffer + $12D], a
    ld de, wScreenTileBuffer + $10C
    ld hl, vBGMap0 + $10C
    ld bc, $0805
    call CopyRect32StrideToVRAM_Bank16
    xor a, a
    ld [wMenuSubState], a
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState, wSubMenuCursor2
; writes: wScreenTileBuffer, wWindowTileBuffer, wListPage, wBattleSubStep
; points at: wMenuSubState, wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case0F::
Jump_016_5FA4:: ; address name
    ld de, wMenuSubState
    ld hl, Data_016_66EB
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_5FC7
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wMenuSubState]
    and a, $01
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_016_5FC7::
    bit 1, a
    ret z
    ld a, $1F
    ld [wScreenTileBuffer + $10C], a
    ld a, $25
    ld [wScreenTileBuffer + $12C], a
    ld a, $2B
    ld [wScreenTileBuffer + $14C], a
    ld a, $31
    ld [wWindowTileBuffer + $4], a
    ld a, $37
    ld [wWindowTileBuffer + $24], a
    ld a, $C3
    ld [wScreenTileBuffer + $10D], a
    ld [wScreenTileBuffer + $12D], a
    ld [wScreenTileBuffer + $14D], a
    ld [wWindowTileBuffer + $5], a
    ld [wWindowTileBuffer + $25], a
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $BC
    ld [wScreenTileBuffer + $12B], a
    ld de, wScreenTileBuffer + $10A
    ld hl, vBGMap0 + $10A
    ld bc, $0A05
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wSubMenuCursor2]
    ld [wListPage], a
    ld a, $0C
    ld [wBattleSubStep], a
    ret

; entry 16 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp0, wMenuState, wSubMenuCursor2
; writes: wListCount, wListCursor, wListPageIndex, wScreenState, wScreenStep, wScreenSubStep
; points at: wScreenTileBuffer, wBattleSubPhase
BattleEnd_Step5_Case01_Case01_Sub01_Case10::
Jump_016_6017:: ; address name
    ld a, [wTemp0]
    ld [wListCount], a
    ld a, [wMenuState]
    ld [wListCursor], a
    ld a, [wSubMenuCursor2]
    ld [wListPageIndex], a
    farcall ClampRecordListPageCursor5
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0C
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    farcall ListRecordsInUseWithByte6EClear
    ld hl, wScreenTileBuffer
    ld bc, $02D0
    ld a, $C3
    call FillBytes
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 17 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wListPageIndex
; writes: wMenuState, wSubMenuCursor2, wListPage, wScreenTileBuffer, wListPageSize, wListPageCount, wListLastPageSize, wBattleSubStep
; points at: wScreenTileBuffer
BattleEnd_Step5_Case01_Case01_Sub01_Case11::
Jump_016_6058:: ; address name
    farcall CopyRectRecord796FToScreenBufferAndPlaySound6C
    ld a, [wListCursor]
    ld [wMenuState], a
    ld hl, Data_016_66DD
    add a, a
    add_a_to_hl
    deref_hl
    ld [hl], $BC
    ld a, [wListPageIndex]
    ld [wSubMenuCursor2], a
    ld [wListPage], a
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $BB
    ld [wScreenTileBuffer + $12D], a
    call ListPartyAndStoredRecordsForPage
    call DrawRecordListPageWithNumbers
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM_Bank16
    call ShowRecordNameString12
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld a, $0F
    ld [wBattleSubStep], a
    ret

; entry 18 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2, wMenuState, wPartyCount, wPartyList, wBattleSlotOut
; writes: wStringIndex, wBattleSubStep, rRAMG
; points at: wListEntries, wBattleSubStep, wBattleSlotOut
BattleEnd_Step5_Case01_Case01_Sub01_Case12::
Jump_016_60B5:: ; address name
    ld a, $BC
    ld hl, vBGMap0 + $16D
    call WriteVRAMByte
    ld a, [wSubMenuCursor2]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wMenuState]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld b, [hl]
    ld a, [wPartyCount]
    cp a, $01
    jr nz, Jump_016_60ED
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_016_6143

Jump_016_60DF::
    ld a, $15
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

Jump_016_60ED::
    ld a, [wPartyCount]
    cp a, $02
    jr nz, Jump_016_6118
    ld a, [wBattleSlotOut]
    ld c, a
    ld a, [wBattleSlotOut + $1]
    or a, c
    jr z, Jump_016_6143
    ld hl, wBattleSlotOut
    ld a, [wPartyList]
    cp a, b
    jr z, Jump_016_6112
    ld hl, wBattleSlotOut + $1
    ld a, [wPartyList + $1]
    cp a, b
    jr z, Jump_016_6112
    jr Jump_016_6143

Jump_016_6112::
    ld a, [hl]
    or a, a
    jr z, Jump_016_60DF
    jr Jump_016_6143

Jump_016_6118::
    ld a, [wBattleSlotOut]
    ld c, a
    ld a, [wBattleSlotOut + $1]
    add a, c
    ld a, [wBattleSlotOut + $2]
    add a, c
    cp a, $02
    jr c, Jump_016_6143
    ld hl, wBattleSlotOut
    ld a, [wPartyList]
    cp a, b
    jr z, Jump_016_6112
    ld hl, wBattleSlotOut + $1
    ld a, [wPartyList + $1]
    cp a, b
    jr z, Jump_016_6112
    ld hl, wBattleSlotOut + $2
    ld a, [wPartyList + $2]
    cp a, b
    jr z, Jump_016_6112

Jump_016_6143::
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_AdvanceBattleSubStep::
Jump_016_614C:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_ShowStringCategory5_Bank16::
Jump_016_6151:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, $13
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

; entry 21 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSubMenuCursor2, wMenuState, wPartyCount, wPartyList
; writes: rRAMG, rRAMB, wArg1, wArg2, wBattlePartyCount, wPartyList, wTemp0, wTemp1, ...
; points at: wListEntries, wBattleSubPhase
BattleEnd_Step5_Case01_Case01_Sub01_Case15::
Jump_016_615E:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wSubMenuCursor2]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wMenuState]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    pop hl
    ld a, [wPartyCount]
    ld [wBattlePartyCount], a
    cp a, $03
    jr z, Jump_016_61A8
    cp a, $02
    jr z, Jump_016_61A3
    ld a, $FF
    ld [wPartyList + $1], a

Jump_016_61A3::
    ld a, $FF
    ld [wPartyList + $2], a

Jump_016_61A8::
    ld a, [wPartyList]
    ld [wTemp0], a
    ld a, [wPartyList + $1]
    ld [wTemp1], a
    ld a, [wPartyList + $2]
    ld [wMenuRowCount], a
    call RunFunc710FForPartyMembers
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 22 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1, wMenuOption, wCommandCursorMax
; writes: wWindowTileBuffer, wStringIndex, wListCount, wListLastPageSize, wCommandPageCount, wListPageCount, wListPageSize, wListPage, ...
; points at: wScreenTileBuffer, wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case16::
Jump_016_61D2:: ; address name
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $BC
    ld [wWindowTileBuffer + $3], a
    farcall CopyRectRecord78AAToScreenBuffer
    ld a, $6C
    call QueueSoundEffect
    ld a, $16
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    call CountRecordsByField6E
    call ListRecordsWithField6EToListEntries
    ld a, [wTemp1]
    ld [wListCount], a
    dec a
    ld b, a
    and a, $03
    inc a
    ld [wListLastPageSize], a
    ld a, b
    and a, $FC
    rrca
    rrca
    ld [wCommandPageCount], a
    inc a
    ld [wListPageCount], a
    cp a, $02
    jr c, Jump_016_622B
    add a, $E0
    ld [wWindowTileBuffer + $22], a
    ld a, $C5
    ld [wWindowTileBuffer + $1F], a
    ld a, $BE
    ld [wWindowTileBuffer + $21], a
    ld a, $C6
    ld [wWindowTileBuffer + $23], a

Jump_016_622B::
    ld a, $04
    ld [wListPageSize], a
    ld a, [wMenuOption]
    ld [wListPage], a
    ld a, [wCommandCursorMax]
    ld [wMenuState], a
    call DrawFourListEntriesForPageListPage
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wWindowTileBuffer, wJoypadPressed, wMenuState, wListPage
; writes: wCommandCursorMax, wMenuOption, wBattleSubStep
; points at: wMenuState, wBattleSubStep, wScreenTileBuffer
BattleEnd_Step5_Case01_Case01_Sub01_Case17::
Jump_016_6250:: ; address name
    ld de, wMenuState
    ld hl, Data_016_66EF
    call MovePagedListCursor
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_016_6279
    call DrawFourListEntriesForPageListPage
    ld hl, vBGMap0 + $AB
    ld de, wScreenTileBuffer + $AB
    ld bc, $0107
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wWindowTileBuffer + $20]
    ld hl, vBGMap0 + $188
    call WriteVRAMByte
    ret

Jump_016_6279::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_6291
    ld a, [wMenuState]
    ld [wCommandCursorMax], a
    ld a, [wListPage]
    ld [wMenuOption], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_016_6291::
    bit 1, a
    ret z
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

; entry 24 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wListPageCount, wCommandCursorMax
; writes: wWindowTileBuffer, wMenuSelectedMember, wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wScreenTileBuffer, wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01_Case18::
Jump_016_62A9:: ; address name
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord78AAToScreenBuffer
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, [wListPageCount]
    cp a, $02
    jr c, Jump_016_62D3
    add a, $E0
    ld [wWindowTileBuffer + $22], a
    ld a, $C5
    ld [wWindowTileBuffer + $1F], a
    ld a, $BE
    ld [wWindowTileBuffer + $21], a
    ld a, $C6
    ld [wWindowTileBuffer + $23], a

Jump_016_62D3::
    call DrawFourListEntriesForPageListPage
    ld a, [wCommandCursorMax]
    ld hl, Data_016_66EF
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    xor a, a
    ld [wMenuSelectedMember], a
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    call ShowListedRecordNameMessage
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuOption, wCommandCursorMax
; writes: rRAMG, rRAMB, wStringIndex, wBattleSubStep
; points at: wMenuSelectedMember, wBattleSubStep, wListEntries, wTextBuf1
BattleEnd_Step5_Case01_Case01_Sub01_Case19::
Jump_016_631B:: ; address name
    ld hl, Data_016_66EB
    ld de, wMenuSelectedMember
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_6375
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [de]
    or a, a
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wMenuOption]
    add a, a
    add a, a
    ld b, a
    ld a, [wCommandCursorMax]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call SRAMRecordAddress
    deref_hl
    ld a, h
    add a, $02
    ld h, a
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, $18
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    xor a, a
    ld [rRAMG], a
    ret

Jump_016_6375::
    bit 1, a
    ret z
    ld a, $16
    ld [wBattleSubStep], a
    ret

; entry 26 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState, wMenuOption
; writes: wListCursor, wListPageIndex, wScreenState, wScreenStep, wScreenSubStep
; points at: wScreenTileBuffer, wBattleSubPhase
BattleEnd_Step5_Case01_Case01_Sub01_Case1A::
Jump_016_637E:: ; address name
    ld a, [wMenuState]
    ld [wListCursor], a
    ld a, [wMenuOption]
    ld [wListPageIndex], a
    farcall ClampRecordListPageCursor4
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0D
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    farcall ListRecordsInUseWithByte6ESet
    ld hl, wScreenTileBuffer
    ld bc, $02D0
    ld a, $C3
    call FillBytes
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 27 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wListPageIndex, wCommandPageCount
; writes: wMenuState, wCommandCursorMax, wMenuOption, wListPage, wScreenTileBuffer, wWindowTileBuffer, wListPageSize, wListPageCount, ...
; points at: wScreenTileBuffer
BattleEnd_Step5_Case01_Case01_Sub01_Case1B::
Jump_016_63B9:: ; address name
    farcall CopyRectRecord78AAToScreenBuffer
    ld a, [wListCursor]
    ld [wMenuState], a
    ld [wCommandCursorMax], a
    ld hl, Data_016_66EF
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ld a, [wListPageIndex]
    ld [wMenuOption], a
    ld [wListPage], a
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $BB
    ld [wScreenTileBuffer + $12D], a
    ld a, [wCommandPageCount]
    inc a
    cp a, $02
    jr c, Jump_016_640E
    add a, $E0
    ld [wWindowTileBuffer + $22], a
    ld a, $C5
    ld [wWindowTileBuffer + $1F], a
    ld a, $BE
    ld [wWindowTileBuffer + $21], a
    ld a, $C6
    ld [wWindowTileBuffer + $23], a

Jump_016_640E::
    call ListRecordsWithField6EToListEntries
    call DrawFourListEntriesForPageListPage
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    call ShowListedRecordNameMessage
    ld a, $19
    ld [wBattleSubStep], a
    ret

; entry 28 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMenuOption, wCommandCursorMax
; writes: rRAMG, rRAMB, wArg1, wArg2, wBattleResolveStep, wBattleSubStep
; points at: wListEntries, wBattleSubPhase
BattleEnd_Step5_Case01_Case01_Sub01_Case1C::
Jump_016_643D:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wMenuOption]
    add a, a
    add a, a
    ld b, a
    ld a, [wCommandCursorMax]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; runs Func_016_65FF; unless A is pressed, writes 1 at DE when B is pressed (E-0122)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case0B, BattleEnd_Step5_Case01_Case01_Sub01_Case04)
; reads: wJoypadPressed
SetDEFlagOnBButton::
Func_016_6480:: ; address name
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and a, $01
    ret nz
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld a, $01
    ld [de], a
    ret

; counts the first Data_016_75EB[wC7C7] SRAM records: wC0A1 = those with field $6E set, wC0A0 = the others (E-0125)
; 3 call sites from 3 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case16, BattleEnd_Step5_Case01_Case01_Sub01_Case0B, BattleEnd_Step5_Case01_Case01_Sub01_Case00)
; reads: wFarmLevel
; writes: rRAMG, rRAMB, wTemp0, wTemp1
; points at: sRecords
CountRecordsByField6E::
Func_016_6493:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wFarmLevel]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld de, $0000

Jump_016_64AE::
    ld a, [hl]
    or a, a
    jr z, Jump_016_64C4
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    pop hl
    or a, a
    jr z, Jump_016_64C3
    inc d
    jr Jump_016_64C4

Jump_016_64C3::
    inc e

Jump_016_64C4::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_64AE
    ld a, e
    ld [wTemp0], a
    ld a, d
    ld [wTemp1], a
    xor a, a
    ld [rRAMG], a
    ret

; lists the party records and then the stored records (state 1, field $6E clear) in wD789 and sets the page counts wCFD0-wCFD3 (E-0130)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case11, BattleEnd_Step5_Case01_Case01_Sub01_Case0C)
; reads: wPartyCount, wTemp0, wFarmLevel, wSubMenuCursor2, wListPageCount
; writes: rRAMG, rRAMB, wTemp0, wListLastPageSize, wListPageCount, wListPageSize, wScreenTileBuffer
; points at: wListEntries, wPartyList, sRecords
ListPartyAndStoredRecordsForPage::
Func_016_64DC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wTemp0], a
    ld de, wListEntries
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_016_64F3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wTemp0]
    inc a
    ld [wTemp0], a
    dec b
    jr nz, Jump_016_64F3
    ld a, [wFarmLevel]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld c, $00

Jump_016_6511::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_016_652E
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    pop hl
    or a, a
    jr nz, Jump_016_652E
    ld a, c
    ld [de], a
    inc de
    ld a, [wTemp0]
    inc a
    ld [wTemp0], a

Jump_016_652E::
    inc c
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_6511
    xor a, a
    ld [rRAMG], a
    ld a, [wTemp0]
    dec a
    ld b, a
    ld a, $05
    call DivideBByA
    inc a
    ld [wListLastPageSize], a
    ld a, b
    inc a
    ld [wListPageCount], a
    ld a, $05
    ld [wListPageSize], a
    ld a, [wSubMenuCursor2]
    or a, a
    jr nz, Jump_016_657B
    ld a, $E1
    ld [wScreenTileBuffer + $20], a
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_016_6580
    ld a, $E2
    ld [wScreenTileBuffer + $60], a
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_016_6585
    ld a, $E3
    ld [wScreenTileBuffer + $A0], a
    jr Jump_016_658A

Jump_016_657B::
    ld a, $B6
    ld [wScreenTileBuffer + $20], a

Jump_016_6580::
    ld a, $B6
    ld [wScreenTileBuffer + $60], a

Jump_016_6585::
    ld a, $B6
    ld [wScreenTileBuffer + $A0], a

Jump_016_658A::
    ld a, [wListPageCount]
    cp a, $02
    jr c, Jump_016_65B0
    ld a, $C5
    ld [wScreenTileBuffer + $142], a
    ld a, $BE
    ld [wScreenTileBuffer + $144], a
    ld a, $C6
    ld [wScreenTileBuffer + $146], a
    ld a, [wSubMenuCursor2]
    add a, $E1
    ld [wScreenTileBuffer + $143], a
    ld a, [wListPageCount]
    add a, $E0
    ld [wScreenTileBuffer + $145], a

Jump_016_65B0::
    ret

; fills wD789 ($1E bytes) with $FF, then lists the indexes of the first Data_016_75EB[wC7C7] SRAM records that have field $6E set (E-0127)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case1B, BattleEnd_Step5_Case01_Case01_Sub01_Case16)
; reads: wFarmLevel
; writes: rRAMG, rRAMB
; points at: wListEntries, sRecords
ListRecordsWithField6EToListEntries::
Func_016_65B1:: ; address name
    ld hl, wListEntries
    ld bc, $001E
    ld a, $FF
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wFarmLevel]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld de, wListEntries
    ld c, $00

Jump_016_65D9::
    ld a, [hl]
    or a, a
    jr z, Jump_016_65EE
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    pop hl
    or a, a
    jr z, Jump_016_65EE
    ld a, c
    ld [de], a
    inc de

Jump_016_65EE::
    inc c
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_65D9
    xor a, a
    ld [rRAMG], a
    ret

; up/down/left/right move the cursor at [DE] and the page wCFD1 within the page sizes wCFD0/wCFD3 and page count wCFD2 (E-0130)
; 8 call sites from 8 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case0C, BattleEnd_Step5_Case04_Sub01_Case0A, BattleEnd_Step5_Case04_Sub01_Case02, BattleEnd_Step5_Case01_Case01_Sub01_Case19, ...)
; reads: wJoypadPressedRepeat, wListPageCount, wListPage, wListLastPageSize, wListPageSize, wFrameCounterLo
; writes: wFrameCounterLo, wListPage
MovePagedListCursor::
Func_016_65FF:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, Jump_016_662B
    call BlankTileAtTableEntryDE
    ld a, [de]
    sub a, $01
    jp nc, Jump_016_6691
    ld a, [wListPageCount]
    cp a, $02
    jr c, Jump_016_661E
    ld b, a
    ld a, [wListPage]
    inc a
    cp a, b
    jr nz, Jump_016_6625

Jump_016_661E::
    ld a, [wListLastPageSize]
    dec a
    jp Jump_016_6691

Jump_016_6625::
    ld a, [wListPageSize]
    dec a
    jr Jump_016_6691

Jump_016_662B::
    bit 7, a
    jr z, Jump_016_664E
    call BlankTileAtTableEntryDE
    ld a, [wListPage]
    inc a
    ld b, a
    ld a, [wListPageCount]
    cp a, b
    jr nz, Jump_016_6642
    ld a, [wListLastPageSize]
    jr Jump_016_6645

Jump_016_6642::
    ld a, [wListPageSize]

Jump_016_6645::
    ld b, a
    ld a, [de]
    inc a
    cp a, b
    jr c, Jump_016_6691
    xor a, a
    jr Jump_016_6691

Jump_016_664E::
    ld a, [wListPageCount]
    cp a, $02
    jr c, Jump_016_6682
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, Jump_016_666D
    call BlankTileAtTableEntryDE
    ld a, [wListPage]
    dec a
    cp a, $FF
    jr nz, Jump_016_669B
    ld a, [wListPageCount]
    dec a
    jr Jump_016_669B

Jump_016_666D::
    bit 4, a
    jr z, Jump_016_6682
    call BlankTileAtTableEntryDE
    ld a, [wListPageCount]
    ld b, a
    ld a, [wListPage]
    inc a
    cp a, b
    jr c, Jump_016_669B
    xor a, a
    jr Jump_016_669B

Jump_016_6682::
    ld a, [wFrameCounterLo]
    and a, $0F
    ret z
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, BlankTileAtTableEntryDE
    jr DrawCursorTileAtTableEntryDE

Jump_016_6691::
    ld [de], a
    call DrawCursorTileAtTableEntryDE
    ld a, $02
    ld [wFrameCounterLo], a
    ret

Jump_016_669B::
    ld [wListPage], a
    ld b, a
    ld a, [wListPageCount]
    dec a
    cp a, b
    jr nz, Jump_016_66B1
    ld a, [wListLastPageSize]
    ld b, a
    ld a, [de]
    cp a, b
    jr c, Jump_016_66B1
    ld a, b
    dec a
    ld [de], a

Jump_016_66B1::
    call DrawCursorTileAtTableEntryDE
    xor a, a
    ld [wFrameCounterLo], a
    ret

; HL = table of VRAM addresses, [DE] = index: writes tile $C3 at that entry's address (WriteVRAMByte); HL kept (E-0103)
; 4 call sites from 1 routine (e.g. MovePagedListCursor)
BlankTileAtTableEntryDE::
Func_016_66B9:: ; address name
    ld a, [de]
    push hl
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $C3
    call WriteVRAMByte
    pop hl
    ret

; HL = table of VRAM addresses, [DE] = index: writes the cursor tile $BB at that entry's address (WriteVRAMByte); HL kept (E-0118)
; 2 call sites from 1 routine (e.g. MovePagedListCursor)
DrawCursorTileAtTableEntryDE::
Func_016_66CB:: ; address name
    ld a, [de]
    push hl
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BB
    call WriteVRAMByte
    pop hl
    ret

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case11, BattleEnd_Step5_Case04_Sub01_Case0F
Data_016_66DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B9, $C1, $F9, $C1, $39, $C2, $79, $C2, $B9, $C2

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case04, BattleEnd_Step5_Case04_Sub01_Case02
Data_016_66E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case0F, BattleEnd_Step5_Case01_Case01_Sub01_Case19, BattleEnd_Step5_Case04_Sub01_Case0C
Data_016_66EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $99, $6D, $99

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case17, BattleEnd_Step5_Case01_Case01_Sub01_Case18, BattleEnd_Step5_Case01_Case01_Sub01_Case1B
Data_016_66EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98, $21, $99, $61, $99

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case0D, BattleEnd_Step5_Case01_Case01_Sub01_Case0E, BattleEnd_Step5_Case04_Sub01_Case09, BattleEnd_Step5_Case04_Sub01_Case0A and 1 more
Data_016_66F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $98, $61, $98, $A1, $98, $E1, $98, $21, $99

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case0B
Data_016_6701:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $99, $6B, $99

; shows five record names of page wCFD1 at vTiles2 + $3B0 and the slot numbers ($E1-$E3) or marks ($B6) beside them (E-0128)
; 3 call sites from 3 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case11, BattleEnd_Step5_Case01_Case01_Sub01_Case0D, BattleEnd_Step5_Case01_Case01_Sub01_Case0C)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wListPage, wPartyCount, wListPageCount
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi
; points at: wListEntries
DrawRecordListPageWithNumbers::
Func_016_6705:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wListPage]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld hl, wListEntries
    add_a_to_hl
    ld b, $05
    ld de, vTiles2 + $3B0
    call ShowRecordNamesListFromHL
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, [wListPage]
    or a, a
    jr nz, Jump_016_677A
    ld a, $E1
    ld hl, vBGMap0 + $20
    call WriteVRAMByte
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_016_6782
    ld a, $E2
    ld hl, vBGMap0 + $60
    call WriteVRAMByte
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_016_678A
    ld a, $E3
    ld hl, vBGMap0 + $A0
    call WriteVRAMByte
    jr Jump_016_6792

Jump_016_677A::
    ld a, $B6
    ld hl, vBGMap0 + $20
    call WriteVRAMByte

Jump_016_6782::
    ld a, $B6
    ld hl, vBGMap0 + $60
    call WriteVRAMByte

Jump_016_678A::
    ld a, $B6
    ld hl, vBGMap0 + $A0
    call WriteVRAMByte

Jump_016_6792::
    ld a, [wListPageCount]
    cp a, $02
    jr c, Jump_016_67A4
    ld a, [wListPage]
    add a, $E1
    ld hl, vBGMap0 + $143
    call WriteVRAMByte

Jump_016_67A4::
    ret

; draws four values from wD868 at vTiles2 + $3B0 with size $0105 (Func_016_67E0), preserving the window settings (E-0121)
; 1 call site from 1 routine (e.g. CopyRect7923AndDrawBattleArg0Values)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi
; points at: wBattleArg0
DrawBattleArg0ValuesAtTiles23B0::
Func_016_67A5:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, wBattleArg0
    ld b, $04
    ld de, vTiles2 + $3B0
    call ShowRecordNamesListFromHL
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; for B record indexes at HL shows each record name (or an empty one for $FF) as string 5 of category 8 at successive window rows from DE (E-0127)
; 2 call sites from 2 routines (e.g. DrawBattleArg0ValuesAtTiles23B0, DrawRecordListPageWithNumbers)
; writes: rRAMG, rRAMB, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi
; points at: wTextBuf0
ShowRecordNamesListFromHL::
Func_016_67E0:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a

Jump_016_67F3::
    ld a, [hl+]
    push bc
    ld c, $01
    push hl
    push de
    cp a, $FF
    jr nz, Jump_016_6802
    ld de, wTextBuf0
    jr Jump_016_6810

Jump_016_6802::
    call SRAMRecordAddress
    ld b, $0A
    ld de, wTextBuf0

Jump_016_680A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_680A

Jump_016_6810::
    ld a, $F0
    ld [de], a
    pop de
    push de
    ld a, e
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    pop de
    inc d
    pop hl
    pop bc
    dec b
    jr nz, Jump_016_67F3
    xor a, a
    ld [rRAMG], a
    ret

; for the four entries of WD789 page wCFD1 runs Func_016_6891 with wD868 = 0-3, draws the page digit, then restores the default window (E-0121)
; 4 call sites from 4 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case1B, BattleEnd_Step5_Case01_Case01_Sub01_Case18, BattleEnd_Step5_Case01_Case01_Sub01_Case17, BattleEnd_Step5_Case01_Case01_Sub01_Case16)
; reads: wListPage
; writes: wTextWindowRows, wTextWindowWidth, rRAMG, rRAMB, wBattleArg0, wTextWindowTileLo, wTextWindowTileHi
; points at: wListEntries
DrawFourListEntriesForPageListPage::
Func_016_682F:: ; address name
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wListPage]
    add a, a
    add a, a
    ld hl, wListEntries
    add_a_to_hl
    ld a, $00
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_Sub01
    inc hl
    ld a, $01
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_Sub01
    inc hl
    ld a, $02
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_Sub01
    inc hl
    ld a, $03
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_Sub01
    xor a, a
    ld [rRAMG], a
    call DrawListPageDigitIfLong
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; only called from DrawFourListEntriesForPageListPage (E-0047)
; 4 call sites from 1 routine (e.g. DrawFourListEntriesForPageListPage)
; reads: wBattleArg0
DrawFourListEntriesForPageListPage_Sub01::
Func_016_6891:: ; address name
    ld a, [hl]
    cp a, $FF
    jr z, Jump_016_68CB
    push hl
    call DrawFourListEntriesForPageListPage_Sub01_Sub01
    pop hl
    ld a, [hl]
    push hl
    ld c, $6E
    call SRAMRecordAddress
    ld a, [hl]
    cp a, $02
    jr nz, Jump_016_68B6
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl]
    and a, $01
    add a, $CC
    jr Jump_016_68B8

Jump_016_68B6::
    ld a, $C9

Jump_016_68B8::
    ld c, a
    ld a, [wBattleArg0]
    ld hl, Data_016_690F
    add a, a
    add_a_to_hl
    deref_hl
    ld [hl], c
    pop hl
    ret

Jump_016_68CB::
    push hl
    ld bc, $0200
    call ShowStringBCAtTileRowBattleArg0
    ld a, [wBattleArg0]
    ld hl, Data_016_690F
    add a, a
    add_a_to_hl
    deref_hl
    ld [hl], $C3
    pop hl
    ret

; only called from DrawFourListEntriesForPageListPage_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DrawFourListEntriesForPageListPage_Sub01)
; reads: wBattleArg0
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi
DrawFourListEntriesForPageListPage_Sub01_Sub01::
Func_016_68E5:: ; address name
    ld c, $0B
    call SRAMRecordAddress
    ld c, [hl]
    inc hl
    ld a, [hl]
    add a, $02
    ld b, a

; wStringCategory = B, wStringIndex = C, string window destination = $9400 + 256 * wD868, then ShowString_Bank08 (E-0118)
; 1 call site from 1 routine (e.g. DrawFourListEntriesForPageListPage_Sub01)
; reads: wBattleArg0
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi
ShowStringBCAtTileRowBattleArg0::
Func_016_68F0:: ; address name
    ld a, c
    ld [wStringIndex], a
    ld a, b
    ld [wStringCategory], a
    ld a, [wBattleArg0]
    add a, $94
    ld h, a
    ld l, $00
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    ret

; address loaded by DrawFourListEntriesForPageListPage_Sub01
Data_016_690F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $43, $C2, $83, $C2, $C3, $C2, $03, $C3

; when wD7A9 is 5 or more: wC320 = $E1 + wCFD1 (the page number tile) (E-0119)
; 1 call site from 1 routine (e.g. DrawFourListEntriesForPageListPage)
; reads: wListCount, wListPage
; writes: wWindowTileBuffer
DrawListPageDigitIfLong::
Func_016_6917:: ; address name
    ld a, [wListCount]
    cp a, $05
    ret c
    ld a, [wListPage]
    add a, $E1
    ld [wWindowTileBuffer + $20], a
    ret

; removes the $FF entry from the party list wC6FE, wC6FD -= 1, wD88F = new count, and terminates the list with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wPartyCount, wBattlePartyCount
; points at: wPartyList, wTemp0
RemovePartyMemberMarkedFF:: ; heuristic: follows a terminator; C0
Func_016_6926:: ; address name
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wTemp0

Jump_016_6930::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_6937
    ld [de], a
    inc de

Jump_016_6937::
    dec b
    jr nz, Jump_016_6930
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    ld [wBattlePartyCount], a
    ld b, a
    ld hl, wTemp0
    ld de, wPartyList

Jump_016_694B::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_694B
    ld a, $FF
    ld [de], a
    ret

; wStringCategory = 5 (wStringIndex set by the caller), then far-calls BeginStringDisplay_Bank2F (E-0072)
; 16 call sites from 14 routines (e.g. ShowRecordNameString1D, BattleEnd_Step5_Case04_Sub01_Case0C, BattleEnd_Step5_Case04_Sub01_Case05, BattleEnd_Step5_Case04_Sub01_Case03, ...)
; writes: wStringCategory
ShowStringCategory5_Bank16::
Func_016_6955:: ; address name
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; wStringCategory = 5 (wStringIndex set by the caller), then far-calls ShowString_Bank2F (E-0074)
; 9 call sites from 9 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case13, BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0Values, BattleEnd_Step5_Case04_Sub01_Case10, BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0ValuesAndStep, ...)
; writes: wStringCategory
ShowStringCategory5Immediate_Bank16::
Func_016_6961:: ; address name
    ld a, $05
    ld [wStringCategory], a
    farcall ShowString_Bank2F
    ret

; copies the name of record wD789[5 * wC470 + wC46B] to wC140 and shows string $12 of category 5 (E-0125)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case11, BattleEnd_Step5_Case01_Case01_Sub01_Case0D)
; reads: wSubMenuCursor2, wMenuState
; writes: rRAMG, rRAMB, wStringIndex
; points at: wListEntries, wTextBuf1
ShowRecordNameString12::
Func_016_696D:: ; address name
    ld a, [wSubMenuCursor2]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wMenuState]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld b, $0A
    ld de, wTextBuf1

Jump_016_6995::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6995
    ld a, $F0
    ld [de], a
    xor a, a
    ld [rRAMG], a
    ld a, $12
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ret

; copies the monster name of record wD789[wC471 * 4 + wCFD6] (its id word at field $0B) into wC140, then shows string $17 of category 5 (ShowStringCategory5Immediate_Bank16) (E-0120)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case01_Case01_Sub01_Case1B, BattleEnd_Step5_Case01_Case01_Sub01_Case18)
; reads: wMenuOption, wCommandCursorMax
; writes: rRAMG, rRAMB, wStringIndex
; points at: wListEntries, wTextBuf1
ShowListedRecordNameMessage::
Func_016_69AB:: ; address name
    ld a, [wMenuOption]
    add a, a
    add a, a
    ld b, a
    ld a, [wCommandCursorMax]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call SRAMRecordAddress
    deref_hl
    ld a, h
    add a, $02
    ld h, a
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, $17
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ret

; copies the name of record wD868[wC46C] to wC130 and shows string $1D of category 5 (E-0124)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case0F, BattleEnd_Step5_Case04_Sub01_Case0B)
; reads: wMenuSubState
; writes: rRAMG, rRAMB, wStringIndex
; points at: wBattleArg0, wTextBuf0
ShowRecordNameString1D::
Func_016_69E2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wMenuSubState]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wTextBuf0
    ld b, $0A

Jump_016_6A01::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6A01
    ld a, $1D
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

; copies the name of battle slot wDAAB to DE and appends tile $A7 + (wD8AF[slot] & 1) before the terminator (E-0124)
; 3 call sites from 3 routines (e.g. RunBattleEndStep5SubSteps_CopyBattleMonsterNameWithLetterSuffixAndStep, BattleEnd_Step5_Case01_Case01_Sub01_Case04, BattleEnd_Step5_Case01_Case01_Sub01_Case00)
; reads: wDisplaySlot
; points at: wSlotNameSuffix
CopyBattleMonsterNameWithLetterSuffix::
Func_016_6A10:: ; address name
    push de
    call CopyMonsterNameOfDisplaySlotToDE
    ld a, [wDisplaySlot]
    ld hl, wSlotNameSuffix
    add_a_to_hl
    ld a, [hl]
    and a, $01
    add a, $A7
    ld d, a
    ld a, [wDisplaySlot]
    pop hl

Jump_016_6A29::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_016_6A31
    inc hl
    jr Jump_016_6A29

Jump_016_6A31::
    ld [hl], d
    inc hl
    ld [hl], $F0
    ret

; copies the name of the monster in slot wDAAB to DE: string category 2 + the id's high byte (StringTable_MonsterNames, then StringTable_MonsterNames2 from id 256), index = the low byte (CopyStringHLToDE) (E-0069)
; 1 call site from 1 routine (e.g. CopyBattleMonsterNameWithLetterSuffix)
; reads: wDisplaySlot
; points at: wBattleMonsterId
CopyMonsterNameOfDisplaySlotToDE::
Func_016_6A36:: ; address name
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    push af
    ld a, [hl]
    add a, $02
    ld h, a
    pop af
    ld l, a
    call CopyStringHLToDE
    ret

; runs the routine for wBattleSubStep (jump table of five) (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case03)
; reads: wBattleSubStep
RunBattleEndStep5SubSteps::
Func_016_6A4E:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw RunBattleEndStep5SubSteps_CopyBattleMonsterNameWithLetterSuffixAndStep
    dw RunBattleEndStep5SubSteps_Case01
    dw RunBattleEndStep5SubSteps_Case02
    dw RunBattleEndStep5SubSteps_AdvanceBattleSubStep
    dw RunBattleEndStep5SubSteps_Case04

; entry 0 of the `rst $00` table in RunBattleEndStep5SubSteps
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wTextBuf0, wBattleSubStep
RunBattleEndStep5SubSteps_CopyBattleMonsterNameWithLetterSuffixAndStep::
Jump_016_6A5C:: ; address name
    ld de, wTextBuf0
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, $14
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleEndStep5SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wDisplaySlot
; writes: wArg1, wArg2, wArg3, wArg4, wSpeciesIdLo, wArg5, wSpeciesIdHi, wTextWindowTileLo, ...
; points at: wNameEntryState, wSlotNameSuffix, wRecordBufA, wScreenTileBuffer, wBattleSubStep
RunBattleEndStep5SubSteps_Case01::
Jump_016_6A6F:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wNameEntryState
    ld bc, $001D
    xor a, a
    call FillBytes
    ld a, $01
    ld [wArg1], a
    ld a, [wDisplaySlot]
    ld hl, wSlotNameSuffix
    add_a_to_hl
    ld a, [hl]
    ld [wArg2], a
    ld a, [wDisplaySlot]
    ld hl, wRecordBufA
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [wArg3], a
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [wArg4], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wArg5], a
    ld [wSpeciesIdHi], a
    call SetSpeciesFlag
    ld a, $C3
    ld hl, wScreenTileBuffer
    ld bc, $02D0
    call FillBytes
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleEndStep5SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wDisplaySlot, wArg5
; writes: wArg1, wArg2, wArg3, wArg4, wArg5
; points at: wSlotNameSuffix, wRecordBufA, wBattleScreenFlags, wNameGlyphBuf, wBattleSubStep
RunBattleEndStep5SubSteps_Case02::
Jump_016_6AE3:: ; address name
    ld a, $01
    ld [wArg1], a
    ld a, [wDisplaySlot]
    ld hl, wSlotNameSuffix
    add_a_to_hl
    ld a, [hl]
    ld [wArg2], a
    ld a, [wDisplaySlot]
    ld hl, wRecordBufA
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [wArg3], a
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [wArg4], a
    ld a, [hl]
    ld [wArg5], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld b, $31
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToVRAM
    ld hl, wBattleScreenFlags
    inc [hl]
    ld hl, wWorkBuf + $1
    ld de, wNameGlyphBuf
    ld b, $0A

Jump_016_6B47::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_016_6B47
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunBattleEndStep5SubSteps
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
RunBattleEndStep5SubSteps_AdvanceBattleSubStep::
Jump_016_6B52:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleEndStep5SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wFarmLevel, wPartyCount
; writes: rRAMG, rRAMB, wBattleSubStep, wWorkBuf
; points at: sRecords, wBattleSubPhase
RunBattleEndStep5SubSteps_Case04::
Jump_016_6B57:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wFarmLevel]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld c, $00

Jump_016_6B71::
    ld a, [hl]
    or a, a
    jr z, Jump_016_6B83
    inc c
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_6B71
    jr Jump_016_6BCC

Jump_016_6B83::
    ld a, c
    ld [wWorkBuf], a
    ld [hl], $01
    inc hl
    ld b, $0A
    ld de, wWorkBuf + $1
    call CopyBBytesDEToHL_Bank16
    ld de, wRecordBufA + $B
    ld b, $9A
    call CopyBBytesDEToHL_Bank16
    ld a, $00
    ld c, $55
    call SRAMRecordAddressMapped
    ld c, $00
    call InitSlotFromRecordFlags
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_016_6BCC
    ld a, $01
    ld c, $55
    call SRAMRecordAddressMapped
    ld c, $01
    call InitSlotFromRecordFlags
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_016_6BCC
    ld a, $02
    ld c, $55
    call SRAMRecordAddressMapped
    ld c, $02
    call InitSlotFromRecordFlags

Jump_016_6BCC::
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    xor a, a
    ld [rRAMG], a
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
; 2 call sites from 1 routine (e.g. RunBattleEndStep5SubSteps_Case04)
CopyBBytesDEToHL_Bank16::
Func_016_6BD9:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank16
    ret

; HL = a record flag byte, C = battle slot: unless bit 7 is set, marks the slot present (wBattleSlotOut = 0), clears its status byte 0 and sets status bit 0 when flag bit 2 is set and status bit 5 when flag bit 0 is set (E-0118)
; 3 call sites from 1 routine (e.g. RunBattleEndStep5SubSteps_Case04)
; points at: wBattleSlotOut, wBattleStatus
InitSlotFromRecordFlags::
Func_016_6BE0:: ; address name
    bit 7, [hl]
    jr nz, Jump_016_6C0A
    ld d, [hl]
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld [hl], $00
    bit 2, d
    call nz, SetBit0AtHL
    bit 0, d
    call nz, SetBit5AtHL
    ret

; [HL] |= $20 (E-0114)
; 1 call site from 1 routine (e.g. InitSlotFromRecordFlags)
SetBit5AtHL::
Func_016_6C04:: ; address name
    set 5, [hl]
    ret

; [HL] |= $01 (E-0114)
; 1 call site from 1 routine (e.g. InitSlotFromRecordFlags)
SetBit0AtHL::
Func_016_6C07:: ; address name
    set 0, [hl]
    ret

Jump_016_6C0A::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $01
    ret

; only called from BattleEnd_Step5_Case04 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case04)
; reads: wBattleSubStep
BattleEnd_Step5_Case04_Sub01::
Func_016_6C16:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw BattleEnd_Step5_Case04_Sub01_Case00
    dw BattleEnd_Step5_Case04_Sub01_Case01
    dw BattleEnd_Step5_Case04_Sub01_Case02
    dw BattleEnd_Step5_Case04_Sub01_Case03
    dw BattleEnd_Step5_Case04_Sub01_Case04
    dw BattleEnd_Step5_Case04_Sub01_Case05
    dw BattleEnd_Step5_Case04_Sub01_Case06
    dw BattleEnd_Step5_Case04_Sub01_CopyRect32StrideToVRAM_Bank16
    dw BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0ValuesAndStep
    dw BattleEnd_Step5_Case04_Sub01_Case09
    dw BattleEnd_Step5_Case04_Sub01_Case0A
    dw BattleEnd_Step5_Case04_Sub01_Case0B
    dw BattleEnd_Step5_Case04_Sub01_Case0C
    dw BattleEnd_Step5_Case04_Sub01_Case0D
    dw BattleEnd_Step5_Case04_Sub01_Case0E
    dw BattleEnd_Step5_Case04_Sub01_Case0F
    dw BattleEnd_Step5_Case04_Sub01_Case10
    dw BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0Values
    dw BattleEnd_Step5_Case04_Sub01_Case12
    dw BattleEnd_Step5_Case04_Sub01_Case13

; entry 0 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wBattlePartyCount
; writes: rRAMG, rRAMB, wStringIndex, wMenuState
; points at: wScreenTileBuffer, wBattleArg0, wPartyList, wTextBuf0, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case00::
Jump_016_6C42:: ; address name
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wWorkBuf]
    push af
    ld a, [wBattlePartyCount]
    ld b, a
    ld hl, wBattleArg0
    ld de, wPartyList

Jump_016_6C5F::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_016_6C5F
    pop af
    ld [hl], a
    ld c, $01
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld b, $0A
    ld de, wTextBuf0

Jump_016_6C7A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6C7A
    ld a, $F0
    ld [de], a
    xor a, a
    ld [rRAMG], a
    farcall LoadCursorTileAndRect7826
    ld a, $19
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    xor a, a
    ld [wMenuState], a
    ret

; entry 1 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case01::
Jump_016_6C9E:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, vBGMap0 + $10E
    ld de, wScreenTileBuffer + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuState
; writes: wBattleSubStep
; points at: wMenuState, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case02::
Jump_016_6CC8:: ; address name
    ld hl, Data_016_66E7
    ld de, wMenuState
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_016_6CEA
    ld a, $6C
    call QueueSoundEffect
    ld a, [wMenuState]
    and a, $01
    jr nz, Jump_016_6CF0
    ld a, $05
    ld [wBattleSubStep], a
    ret

Jump_016_6CEA::
    ld a, [wJoypadPressed]
    and a, $02
    ret z

Jump_016_6CF0::
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case03::
Jump_016_6CF5:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    call BattleMonsterTable71ACAtLeast6
    or a, a
    jr z, Jump_016_6D08
    ld a, $20
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

Jump_016_6D08::
    ld a, $1A
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

; entry 4 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleSubStep
; points at: wBattleStep
BattleEnd_Step5_Case04_Sub01_Case04::
Jump_016_6D11:: ; address name
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wBattleSubStep, wStringIndex
; points at: wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case05::
Jump_016_6D1E:: ; address name
    ld a, [wPartyCount]
    cp a, $03
    jr c, Jump_016_6D2B
    ld a, $08
    ld [wBattleSubStep], a
    ret

Jump_016_6D2B::
    ld hl, wBattleSubStep
    inc [hl]
    call BattleMonsterTable71ACAtLeast6
    or a, a
    jr z, Jump_016_6D3E
    ld a, $21
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

Jump_016_6D3E::
    ld a, $1B
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

; entry 6 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wPartyCount
; writes: wBattlePartyCount
; points at: wBattleArg0, wPartyCount, wPartyList, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case06::
Jump_016_6D47:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wPartyCount]
    ld hl, wBattleArg0
    add_a_to_hl
    ld b, [hl]
    ld hl, wPartyCount
    inc [hl]
    ld a, [hl]
    ld [wBattlePartyCount], a
    dec a
    ld hl, wPartyList
    add_a_to_hl
    ld [hl], b
    call SetRecordState2ForB
    call LoadRecordListNameTiles
    call RunFunc710FForPartyMembers
    call BuildBattleMenuScreen_733F
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wScreenTileBuffer
BattleEnd_Step5_Case04_Sub01_CopyRect32StrideToVRAM_Bank16::
Jump_016_6D7B:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, $04
    ld [wBattleSubStep], a
    ret

; entry 8 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wMenuSubState
; points at: wBattleSubStep
BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0ValuesAndStep::
Jump_016_6D8D:: ; address name
    call CopyRect7923AndDrawBattleArg0Values
    ld a, $1C
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    xor a, a
    ld [wMenuSubState], a
    ld hl, wScreenTileBuffer + $12F
    ld [hl], $BC
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMenuSubState
; writes: wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wScreenTileBuffer, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case09::
Jump_016_6DA6:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $04
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $04
    ld [wListLastPageSize], a
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wMenuSubState]
    ld hl, Data_016_66F7
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wBattlePartyCount
; writes: rRAMG, rRAMB, wBattleSubStep
; points at: wMenuSubState, wBattleArg0, wTextBuf0, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case0A::
Jump_016_6DE4:: ; address name
    ld hl, Data_016_66F7
    ld de, wMenuSubState
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_016_6E22
    ld a, [wBattlePartyCount]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld b, $0A
    ld de, wTextBuf0

Jump_016_6E13::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6E13
    ld a, $F0
    ld [de], a
    ld a, $13
    ld [wBattleSubStep], a
    ret

Jump_016_6E22::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    farcall CopyRectRecord787EAndPlaySound6C
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSubState
; writes: wMenuSelectedMember, wListPageSize, wListPage, wListPageCount, wListLastPageSize
; points at: wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case0B::
Jump_016_6E38:: ; address name
    xor a, a
    ld [wMenuSelectedMember], a
    ld hl, vBGMap0 + $10C
    ld de, wScreenTileBuffer + $10C
    ld bc, $0805
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld hl, Data_016_66F7
    ld a, [wMenuSubState]
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ld hl, vBGMap0 + $12D
    ld a, $BB
    call WriteVRAMByte
    call ShowRecordNameString1D
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember, wMenuSubState
; writes: rRAMG, rRAMB, wStringIndex, wBattleSubStep
; points at: wMenuSelectedMember, wBattleSubStep, wBattleArg0, wTextBuf0
BattleEnd_Step5_Case04_Sub01_Case0C::
Jump_016_6E80:: ; address name
    ld hl, Data_016_66EB
    ld de, wMenuSelectedMember
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_016_6ED4
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr nz, Jump_016_6EA1
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_016_6EA1::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wMenuSubState]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wTextBuf0
    ld b, $0A

Jump_016_6EC0::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6EC0
    ld a, $1A
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld a, $12
    ld [wBattleSubStep], a
    ret

Jump_016_6ED4::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    call BuildBattleMenuScreen_733F
    farcall LoadCursorTileAndRect7826
    ld a, $11
    ld [wBattleSubStep], a
    ret

; entry 13 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePartyCount, wMenuSubState
; writes: wListCount, wListCursor, wListPageIndex, wScreenState, wScreenStep, wScreenSubStep
; points at: wListEntries, wBattleArg0, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case0D::
Jump_016_6EE9:: ; address name
    ld hl, wListEntries
    ld bc, $001E
    xor a, a
    call FillBytes
    ld a, [wBattlePartyCount]
    inc a
    ld [wListCount], a
    ld b, a
    ld de, wBattleArg0
    ld hl, wListEntries

Jump_016_6F01::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_016_6F01
    ld a, [wMenuSubState]
    ld [wListCursor], a
    ld a, $00
    ld [wListPageIndex], a
    farcall ClampRecordListPageCursor5
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0E
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wSavedSpriteClipMode, wSavedFieldDrawFlags, wSavedSpriteSlotCount
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wSpriteSlotCount
; points at: wBattleScreenFlags, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case0E::
Jump_016_6F30:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    ld [wSpriteSlotCount], a
    ld b, $31
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToVRAM
    ld hl, wBattleScreenFlags
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
; writes: wMenuSubState, wBattleSubStep
; points at: wScreenTileBuffer
BattleEnd_Step5_Case04_Sub01_Case0F::
Jump_016_6F6F:: ; address name
    call BuildBattleMenuScreen_733F
    call CopyRect7923AndDrawBattleArg0Values
    ld a, [wListCursor]
    ld [wMenuSubState], a
    ld hl, Data_016_66DD
    add a, a
    add_a_to_hl
    deref_hl
    ld [hl], $BC
    farcall CopyRectRecord787EAndPlaySound6C
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412
    call CopyRect32StrideToVRAM_Bank16
    call ShowRecordNameString1D
    ld a, $0C
    ld [wBattleSubStep], a
    ret

; entry 16 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTileBuffer, wWindowTileBuffer, wStringIndex, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_Case10::
Jump_016_6FA4:: ; address name
    ld a, $1F
    ld [wScreenTileBuffer + $10C], a
    ld a, $25
    ld [wScreenTileBuffer + $12C], a
    ld a, $2B
    ld [wScreenTileBuffer + $14C], a
    ld a, $31
    ld [wWindowTileBuffer + $4], a
    ld a, $37
    ld [wWindowTileBuffer + $24], a
    ld a, $C3
    ld [wScreenTileBuffer + $10D], a
    ld [wScreenTileBuffer + $12D], a
    ld [wScreenTileBuffer + $14D], a
    ld [wWindowTileBuffer + $5], a
    ld [wWindowTileBuffer + $25], a
    farcall LoadCursorTileAndRect7826
    ld hl, vBGMap0 + $10C
    ld hl, wScreenTileBuffer + $10C
    ld bc, $0805
    call CopyRect32StrideToVRAM_Bank16
    ld a, $19
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 17 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuSelectedMember, wStringIndex, wBattleSubStep
BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0Values::
Jump_016_6FEE:: ; address name
    call CopyRect7923AndDrawBattleArg0Values
    ld hl, wScreenTileBuffer + $12F
    ld [hl], $BC
    xor a, a
    ld [wMenuSelectedMember], a
    ld a, $1C
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

; entry 18 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSubState, wBattlePartyCount
; writes: wBattleSubStep
; points at: wBattleArg0, wPartyList, wScreenTileBuffer
BattleEnd_Step5_Case04_Sub01_Case12::
Jump_016_7008:: ; address name
    ld a, [wMenuSubState]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    call RestoreRecordAFully
    ld [hl], $FF
    ld hl, wBattleArg0
    ld de, wPartyList
    ld a, [wBattlePartyCount]
    ld b, a

Jump_016_7023::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_7023
    ld [de], a
    push hl
    push de
    push bc
    call SetRecordState2
    pop bc
    pop de
    pop hl
    inc de
    dec b
    jr nz, Jump_016_7023
    call LoadRecordListNameTiles
    call RunFunc710FForPartyMembers
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, $04
    ld [wBattleSubStep], a
    ret

; entry 19 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wBattleSubStep, wMenuState
; points at: wScreenTileBuffer
BattleEnd_Step5_Case04_Sub01_Case13::
Jump_016_7051:: ; address name
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    farcall LoadCursorTileAndRect7826
    ld a, $19
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    xor a, a
    ld [wMenuState], a
    ret

; copies rectangle record $7923 to the screen buffer and draws the wD868 values at vTiles2 + $3B0 (E-0122)
; 3 call sites from 3 routines (e.g. BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0Values, BattleEnd_Step5_Case04_Sub01_Case0F, BattleEnd_Step5_Case04_Sub01_CopyRect7923AndDrawBattleArg0ValuesAndStep)
CopyRect7923AndDrawBattleArg0Values::
Func_016_7078:: ; address name
    farcall CopyRectRecord7923ToScreenBuffer
    call DrawBattleArg0ValuesAtTiles23B0
    ret

; for record A: field 0 = 1, field $55 = 0, HP (field $5B) = max HP ($5D), MP ($5F) = max MP ($61) (E-0127)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case04_Sub01_Case12)
; writes: rRAMG, rRAMB
RestoreRecordAFully::
Func_016_7082:: ; address name
    push hl
    ld c, $00
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld [hl], $01
    ld a, l
    add a, $55
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld [hl], $00
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    ld a, l
    add a, $FC
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    pop hl
    ld b, h
    ld c, l
    inc hl
    inc hl
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    ld [bc], a
    xor a, a
    ld [rRAMG], a
    pop hl
    ret

; A = B, then falls into SetRecordState2 (E-0126)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case04_Sub01_Case06)
; writes: rRAMG, rRAMB
SetRecordState2ForB::
Func_016_70C5:: ; address name
    ld a, b

; A = record: sets its byte 0 (state) to 2 in SRAM bank 0 (SRAMRecordAddress with C = 0) (E-0118)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case04_Sub01_Case12)
; writes: rRAMG, rRAMB
SetRecordState2::
Func_016_70C6:: ; address name
    ld c, $00
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld [hl], $02
    xor a, a
    ld [rRAMG], a
    ret

; with SRAM enabled runs Func_016_710F for each of the first one to three party records (E-0124)
; 3 call sites from 3 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case12, BattleEnd_Step5_Case04_Sub01_Case06, BattleEnd_Step5_Case01_Case01_Sub01_Case15)
; reads: wPartyList, wPartyCount
; writes: rRAMG, rRAMB
RunFunc710FForPartyMembers::
Func_016_70DB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld c, $00
    ld a, [wPartyList]
    call RunFunc710FForPartyMembers_Sub01
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_016_710A
    ld c, $01
    ld a, [wPartyList + $1]
    call RunFunc710FForPartyMembers_Sub01
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_016_710A
    ld c, $02
    ld a, [wPartyList + $2]
    call RunFunc710FForPartyMembers_Sub01

Jump_016_710A::
    xor a, a
    ld [rRAMG], a
    ret

; only called from RunFunc710FForPartyMembers (E-0047)
; 3 call sites from 1 routine (e.g. RunFunc710FForPartyMembers)
; points at: wBattleLevel, wBattleHP, wBattleMP, wBattleSlotOut, wBattleStatus
RunFunc710FForPartyMembers_Sub01::
Func_016_710F:: ; address name
    push bc
    ld c, $56
    call SRAMRecordAddress
    pop bc
    ld a, c
    ld de, wBattleLevel
    add a, e
    ld e, a
    jr nc, Jump_016_711F
    inc d

Jump_016_711F::
    ld a, [hl]
    ld [de], a
    ld a, l
    add a, $05
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, c
    ld de, wBattleHP
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_016_7133
    inc d

Jump_016_7133::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    inc hl
    ld a, c
    ld de, wBattleMP
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_016_7144
    inc d

Jump_016_7144::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_016_7152
    inc d

Jump_016_7152::
    xor a, a
    ld [de], a
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    bit 7, [hl]
    jr nz, Jump_016_717A
    ld a, c
    add a, a
    add a, a
    add a, a
    add a, c
    ld de, wBattleStatus
    add a, e
    ld e, a
    jr nc, Jump_016_716D
    inc d

Jump_016_716D::
    xor a, a
    ld [de], a
    bit 0, [hl]
    call nz, SetBit5AtDE
    bit 2, [hl]
    call nz, SetBit0AtDE
    ret

Jump_016_717A::
    ld a, $01
    ld [de], a
    ret

; [DE] |= $20; clobbers A (E-0114)
; 1 call site from 1 routine (e.g. RunFunc710FForPartyMembers_Sub01)
SetBit5AtDE::
Func_016_717E:: ; address name
    ld a, [de]
    set 5, a
    ld [de], a
    ret

; [DE] |= $01; clobbers A (E-0114)
; 1 call site from 1 routine (e.g. RunFunc710FForPartyMembers_Sub01)
SetBit0AtDE::
Func_016_7183:: ; address name
    ld a, [de]
    set 0, a
    ld [de], a
    ret

; A = 1 when Data $71AC[battle monster id of wDAAB] is at least 6, else 0 (E-0124)
; 2 call sites from 2 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case05, BattleEnd_Step5_Case04_Sub01_Case03)
; reads: wDisplaySlot
; points at: wBattleMonsterId
BattleMonsterTable71ACAtLeast6::
Func_016_7188:: ; address name
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    push af
    ld a, [hl]
    ld h, a
    pop af
    ld l, a
    ld a, l
    add a, $AC
    ld l, a
    ld a, h
    adc a, $71
    ld h, a
    ld a, [hl]
    cp a, $06
    jr c, Jump_016_71AA
    ld a, $01
    ret

Jump_016_71AA::
    xor a, a
    ret

; E-0206 (C1: BattleMonsterTable71ACAtLeast6 reads the byte at $71AC + the wBattleMonsterId of wDisplaySlot and returns A = 1 when it is 6 or more; BattleEnd_Step5_Case04_Sub01_Case03 and _Case05 call it; 373 bytes (monster ids 0-$174) end at the rectangle copier after them; what the classes mean is not read).
; record: class 0-7
MonsterClassByteTable_71AC::
Data_016_71AC:: ; address name
    db $00 ; id 0
    db $03 ; id 1 DrakSlime
    db $00 ; id 2 SpotSlime
    db $02 ; id 3 WingSlime
    db $01 ; id 4 TreeSlime
    db $00 ; id 5 Snaily
    db $03 ; id 6 SlimeNite
    db $01 ; id 7 Babble
    db $02 ; id 8 BoxSlime
    db $02 ; id 9 PearlGel
    db $01 ; id 10 Slime
    db $02 ; id 11 Healer
    db $03 ; id 12 FangSlime
    db $03 ; id 13 RockSlime
    db $03 ; id 14 SlimeBorg
    db $00 ; id 15 Slabbit
    db $05 ; id 16 KingSlime
    db $04 ; id 17 Metaly
    db $05 ; id 18 Metabble
    db $04 ; id 19 SpotKing
    db $01 ; id 20 TropicGel
    db $04 ; id 21 MimeSlime
    db $04 ; id 22 HaloSlime
    db $05 ; id 23 MetalKing
    db $06 ; id 24 GoldSlime
    db $07 ; id 25 GranSlime
    db $07 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $02 ; id 36 DragonKid
    db $02 ; id 37 Tortragon
    db $02 ; id 38 Pteranod
    db $02 ; id 39 Gasgon
    db $00 ; id 40 FairyDrak
    db $04 ; id 41 LizardMan
    db $01 ; id 42 Poisongon
    db $03 ; id 43 Swordgon
    db $03 ; id 44 Drygon
    db $04 ; id 45 Dragon
    db $01 ; id 46 MiniDrak
    db $04 ; id 47 MadDragon
    db $03 ; id 48 Rayburn
    db $00 ; id 49 Chamelgon
    db $00 ; id 50 LizardFly
    db $04 ; id 51 Andreal
    db $01 ; id 52 KingCobra
    db $03 ; id 53 Vampirus
    db $01 ; id 54 SnakeBat
    db $04 ; id 55 Spikerous
    db $05 ; id 56 GreatDrak
    db $01 ; id 57 Crestpent
    db $02 ; id 58 WingSnake
    db $04 ; id 59 Coatol
    db $06 ; id 60 Orochi
    db $05 ; id 61 BattleRex
    db $05 ; id 62 SkyDragon
    db $05 ; id 63 Serpentia
    db $06 ; id 64 Divinegon
    db $07 ; id 65 Orligon
    db $06 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $02 ; id 71 Tonguella
    db $00 ; id 72 Almiraj
    db $00 ; id 73 CatFly
    db $00 ; id 74 PillowRat
    db $00 ; id 75 Saccer
    db $04 ; id 76 GulpBeast
    db $01 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $02 ; id 79 Beavern
    db $00 ; id 80 Antbear
    db $02 ; id 81 SuperTen
    db $02 ; id 82 IronTurt
    db $01 ; id 83 Mommonja
    db $01 ; id 84 HammerMan
    db $03 ; id 85 Grizzly
    db $03 ; id 86 Yeti
    db $01 ; id 87 ArrowDog
    db $02 ; id 88 NoctoKing
    db $02 ; id 89 BeastNite
    db $01 ; id 90 MadGopher
    db $00 ; id 91 FairyRat
    db $05 ; id 92 Unicorn
    db $03 ; id 93 Goategon
    db $03 ; id 94 WildApe
    db $04 ; id 95 Trumpeter
    db $06 ; id 96 KingLeo
    db $05 ; id 97 DarkHorn
    db $04 ; id 98 MadCat
    db $04 ; id 99 BigEye
    db $07 ; id 100 Gorago
    db $03 ; id 101 CatMage
    db $03 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $00 ; id 106 Picky
    db $03 ; id 107 Wyvern
    db $02 ; id 108 BullBird
    db $01 ; id 109 Florajay
    db $03 ; id 110 DuckKite
    db $03 ; id 111 MadPecker
    db $01 ; id 112 MadRaven
    db $02 ; id 113 MistyWing
    db $02 ; id 114 AquaHawk
    db $00 ; id 115 Dracky
    db $01 ; id 116 KiteHawk
    db $01 ; id 117 BigRoost
    db $02 ; id 118 StubBird
    db $02 ; id 119 LandOwl
    db $03 ; id 120 MadGoose
    db $03 ; id 121 MadCondor
    db $03 ; id 122 Emyu
    db $04 ; id 123 Blizzardy
    db $04 ; id 124 Phoenix
    db $04 ; id 125 ZapBird
    db $05 ; id 126 Garudian
    db $05 ; id 127 WhipBird
    db $04 ; id 128 FunkyBird
    db $06 ; id 129 RainHawk
    db $07 ; id 130 Azurile
    db $06 ; id 131 Shantak
    db $02 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $01 ; id 141 MadPlant
    db $02 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $01 ; id 144 WingTree
    db $00 ; id 145 CactiBall
    db $02 ; id 146 Gulpple
    db $00 ; id 147 Toadstool
    db $03 ; id 148 AmberWeed
    db $00 ; id 149 Slurperon
    db $02 ; id 150 Stubsuck
    db $01 ; id 151 Oniono
    db $02 ; id 152 DanceVegi
    db $03 ; id 153 TreeBoy
    db $03 ; id 154 Devipine
    db $05 ; id 155 FaceTree
    db $05 ; id 156 HerbMan
    db $03 ; id 157 BeanMan
    db $03 ; id 158 EvilSeed
    db $03 ; id 159 ManEater
    db $04 ; id 160 Snapper
    db $04 ; id 161 GhosTree
    db $06 ; id 162 Rosevine
    db $07 ; id 163 Egdracil
    db $07 ; id 164 Warubou
    db $07 ; id 165 Watabou
    db $00 ; id 166 Eggplaton
    db $03 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $00 ; id 176 GiantSlug
    db $03 ; id 177 Catapila
    db $01 ; id 178 Gophecada
    db $01 ; id 179 Butterfly
    db $03 ; id 180 WeedBug
    db $00 ; id 181 GiantWorm
    db $02 ; id 182 Lipsy
    db $02 ; id 183 StagBug
    db $02 ; id 184 Pyuro
    db $00 ; id 185 ArmyAnt
    db $01 ; id 186 GoHopper
    db $00 ; id 187 TailEater
    db $03 ; id 188 ArmorPede
    db $02 ; id 189 Eyeder
    db $03 ; id 190 GiantMoth
    db $03 ; id 191 Droll
    db $04 ; id 192 ArmyCrab
    db $03 ; id 193 MadHornet
    db $02 ; id 194 Belzebub
    db $05 ; id 195 WarMantis
    db $05 ; id 196 HornBeet
    db $04 ; id 197 Sickler
    db $06 ; id 198 Armorpion
    db $05 ; id 199 Digster
    db $07 ; id 200 Skularach
    db $03 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $00 ; id 211 Pixy
    db $02 ; id 212 MedusaEye
    db $04 ; id 213 AgDevil
    db $00 ; id 214 Demonite
    db $03 ; id 215 DarkEye
    db $02 ; id 216 EyeBall
    db $03 ; id 217 SkulRider
    db $04 ; id 218 EvilBeast
    db $04 ; id 219 Bubblemon
    db $01 ; id 220 1EyeClown
    db $01 ; id 221 Gremlin
    db $05 ; id 222 ArcDemon
    db $04 ; id 223 Lionex
    db $05 ; id 224 GoatHorn
    db $03 ; id 225 Orc
    db $04 ; id 226 Ogre
    db $05 ; id 227 GateGuard
    db $05 ; id 228 ChopClown
    db $05 ; id 229 BossTroll
    db $05 ; id 230 Grendal
    db $06 ; id 231 Akubar
    db $04 ; id 232 MadKnight
    db $05 ; id 233 EvilWell
    db $03 ; id 234 Gigantes
    db $05 ; id 235 Centasaur
    db $03 ; id 236 EvilArmor
    db $06 ; id 237 Jamirus
    db $06 ; id 238 Durran
    db $07 ; id 239 Titanis
    db $06 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $00 ; id 246 Spooky
    db $05 ; id 247 Skullgon
    db $02 ; id 248 PutrePup
    db $01 ; id 249 RotRaven
    db $02 ; id 250 Mummy
    db $03 ; id 251 DarkCrab
    db $03 ; id 252 DeadNite
    db $02 ; id 253 Shadow
    db $02 ; id 254 Skulpent
    db $02 ; id 255 Hork
    db $01 ; id 256 Mudron
    db $02 ; id 257 NiteWhip
    db $02 ; id 258 WindMerge
    db $03 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $01 ; id 261 FoxFire
    db $03 ; id 262 CaptDead
    db $06 ; id 263 DeadNoble
    db $06 ; id 264 WhiteKing
    db $03 ; id 265 BoneSlave
    db $04 ; id 266 Skeletor
    db $05 ; id 267 Servant
    db $07 ; id 268 Lazamanus
    db $06 ; id 269 Copycat
    db $03 ; id 270 MadSpirit
    db $02 ; id 271 PomPomBom
    db $06 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $01 ; id 281 JewelBag
    db $02 ; id 282 EvilWand
    db $00 ; id 283 MadCandle
    db $01 ; id 284 CoilBird
    db $00 ; id 285 Facer
    db $00 ; id 286 SpikyBoy
    db $03 ; id 287 MadMirror
    db $03 ; id 288 RogueNite
    db $02 ; id 289 Puppetor
    db $00 ; id 290 Goopi
    db $03 ; id 291 Voodoll
    db $04 ; id 292 MetalDrak
    db $05 ; id 293 Balzak
    db $03 ; id 294 SabreMan
    db $02 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $04 ; id 297 Roboster
    db $05 ; id 298 Roboster2
    db $03 ; id 299 EvilPot
    db $03 ; id 300 Gismo
    db $05 ; id 301 LavaMan
    db $05 ; id 302 IceMan
    db $04 ; id 303 Mimic
    db $03 ; id 304 Exaucers
    db $00 ; id 305 MudDoll
    db $04 ; id 306 Golem
    db $05 ; id 307 StoneMan
    db $04 ; id 308 BombCrag
    db $06 ; id 309 GoldGolem
    db $07 ; id 310 DarkMate
    db $02 ; id 311 ProtoMech
    db $04 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $00 ; id 316 Petiteel
    db $00 ; id 317 Moray
    db $03 ; id 318 WalrusMan
    db $03 ; id 319 RayGigas
    db $02 ; id 320 Anemon
    db $02 ; id 321 Aquarella
    db $03 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $02 ; id 325 Octoreach
    db $03 ; id 326 Angleron
    db $03 ; id 327 FishRider
    db $04 ; id 328 RushFish
    db $01 ; id 329 Gamanian
    db $03 ; id 330 Clawster
    db $04 ; id 331 CancerMan
    db $02 ; id 332 RogueWave
    db $01 ; id 333 Scallopa
    db $04 ; id 334 SeaHorse
    db $04 ; id 335 HoodSquid
    db $04 ; id 336 MerTiger
    db $05 ; id 337 AxeShark
    db $05 ; id 338 Octogon
    db $06 ; id 339 KingSquid
    db $05 ; id 340 Digong
    db $05 ; id 341 WhaleMage
    db $06 ; id 342 Aquadon
    db $05 ; id 343 Octoraid
    db $06 ; id 344 Grakos
    db $07 ; id 345 Poseidon
    db $02 ; id 346 Pumpoise
    db $01 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $06 ; id 351 DracoLord
    db $07 ; id 352 DracoLord
    db $07 ; id 353 LordDraco
    db $06 ; id 354 Hargon
    db $07 ; id 355 Sidoh
    db $07 ; id 356 Genosidoh
    db $06 ; id 357 Baramos
    db $07 ; id 358 Zoma
    db $07 ; id 359 AsuraZoma
    db $07 ; id 360 Pizzaro
    db $07 ; id 361 PsychoPiz
    db $06 ; id 362 Esterk
    db $06 ; id 363 Mirudraas
    db $07 ; id 364 Mirudraas
    db $06 ; id 365 Mudou
    db $07 ; id 366 DeathMore
    db $07 ; id 367 DeathMore
    db $07 ; id 368 DeathMore
    db $07 ; id 369 Darkdrium
    db $07 ; id 370 Orgodemir
    db $07 ; id 371 Orgodemir
    db $07 ; id 372 Darck

; B = width, C = rows, DE = source with rows 32 bytes apart, HL = VRAM address with rows 32 bytes apart: copies a B x C rectangle with WriteVRAMByteInc; DE and HL end at the start of the row below; B kept, C = 0 (E-0066)
; 21 call sites from 20 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case13, BattleEnd_Step5_Case04_Sub01_Case12, BattleEnd_Step5_Case04_Sub01_Case10, BattleEnd_Step5_Case04_Sub01_Case0F, ...)
CopyRect32StrideToVRAM_Bank16::
Func_016_7321:: ; address name
    push bc
    push de
    push hl

Jump_016_7324::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_016_7324
    pop hl
    ld de, $0020
    add hl, de
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, CopyRect32StrideToVRAM_Bank16
    ret

; clears attributes and the screen buffer and lays out the battle menu rectangles (bank $31 routines for wD88F and wD890) (E-0122)
; 11 call sites from 11 routines (e.g. BattleEnd_Step5_Case04_Sub01_Case13, BattleEnd_Step5_Case04_Sub01_Case12, BattleEnd_Step5_Case04_Sub01_Case0F, BattleEnd_Step5_Case04_Sub01_Case0C, ...)
BuildBattleMenuScreen_733F::
Func_016_733F:: ; address name
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall DrawPartySlotStatusPanels
    farcall LayoutTileBlocksForBattleFoeCount
    farcall LoadBattleMonsterPictureAttributes
    farcall CopyRectRecord7345ToScreenBuffer
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wBattleKind, wRecordBufA, wSpeciesRecord, wRecordBufAByte71, wRandomLo, wRandomHi
; writes: wRecordBufA, wSpeciesIdLo, wSpeciesIdHi, wRecordBufAByte71
; points at: wWorkBuf
BattleEnd_Step3_Sub01::
Func_016_7364:: ; address name
    ld a, [wBattleKind]
    cp a, $02
    jr nz, Jump_016_736F
    ld c, $00
    jr Jump_016_7382

Jump_016_736F::
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $05
    call DivideHLByA
    sub a, $02
    ld c, a

Jump_016_7382::
    ld a, [wRecordBufA + $56]
    add a, c
    bit 7, a
    jr nz, Jump_016_7395
    or a, a
    jr z, Jump_016_7395
    cp a, $64
    jr c, Jump_016_7397
    ld a, $63
    jr Jump_016_7397

Jump_016_7395::
    ld a, $01

Jump_016_7397::
    ld [wRecordBufA + $56], a
    ld a, [wRecordBufA + $B]
    ld l, a
    ld a, [wRecordBufA + $C]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $6]
    ld c, a
    ld a, [wRecordBufA + $56]
    cp a, c
    jr c, Jump_016_73BB
    ld c, a

Jump_016_73BB::
    ld a, c
    ld [wRecordBufA + $57], a
    ld a, [wBattleKind]
    cp a, $02
    jp z, Jump_016_7456
    ld a, [wRecordBufA + $5D]
    ld c, a
    ld a, [wRecordBufA + $5E]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub03
    ld a, l
    ld [wRecordBufA + $5D], a
    ld a, h
    ld [wRecordBufA + $5E], a
    ld a, l
    ld [wRecordBufA + $5B], a
    ld a, h
    ld [wRecordBufA + $5C], a
    ld a, [wRecordBufA + $61]
    ld c, a
    ld a, [wRecordBufA + $62]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wRecordBufA + $61], a
    ld a, h
    ld [wRecordBufA + $62], a
    ld a, l
    ld [wRecordBufA + $5F], a
    ld a, h
    ld [wRecordBufA + $60], a
    ld a, [wRecordBufA + $63]
    ld c, a
    ld a, [wRecordBufA + $64]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wRecordBufA + $63], a
    ld a, h
    ld [wRecordBufA + $64], a
    ld a, [wRecordBufA + $65]
    ld c, a
    ld a, [wRecordBufA + $66]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wRecordBufA + $65], a
    ld a, h
    ld [wRecordBufA + $66], a
    ld a, [wRecordBufA + $67]
    ld c, a
    ld a, [wRecordBufA + $68]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wRecordBufA + $67], a
    ld a, h
    ld [wRecordBufA + $68], a
    ld a, [wRecordBufA + $69]
    ld c, a
    ld a, [wRecordBufA + $6A]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wRecordBufA + $69], a
    ld a, h
    ld [wRecordBufA + $6A], a
    ld a, [wRecordBufAByte71]
    ld c, a
    ld b, $00
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wRecordBufAByte71], a

Jump_016_7456::
    call BattleEnd_Step3_Sub01_Sub01
    ld hl, wWorkBuf
    ld b, $0B
    ld de, $0000

Jump_016_7461::
    ld a, e
    add a, [hl]
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    dec b
    jr nz, Jump_016_7461
    ld a, d
    or a, a
    jr nz, Jump_016_74A2
    ld hl, $0000
    ld a, e
    cp a, $15
    jr c, Jump_016_74A5
    ld hl, $0032
    cp a, $29
    jr c, Jump_016_74A5
    ld hl, $0064
    cp a, $3D
    jr c, Jump_016_74A5
    ld hl, $0096
    cp a, $51
    jr c, Jump_016_74A5
    ld hl, $00C8
    cp a, $65
    jr c, Jump_016_74A5
    ld hl, $00FA
    cp a, $79
    jr c, Jump_016_74A5
    ld hl, $012C
    cp a, $8D
    jr c, Jump_016_74A5

Jump_016_74A2::
    ld hl, $0190

Jump_016_74A5::
    push hl
    ld a, [wRecordBufA + $56]
    ld c, $19
    call Multiply8
    pop de
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_016_74BE
    ld hl, $0000
    jr Jump_016_74C9

Jump_016_74BE::
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr c, Jump_016_74C9
    ld hl, $03E7

Jump_016_74C9::
    ld a, l
    ld [wRecordBufA + $6B], a
    ld a, h
    ld [wRecordBufA + $6C], a
    ret

; only called from BattleEnd_Step3_Sub01 (E-0047)
; 6 call sites from 1 routine (e.g. BattleEnd_Step3_Sub01)
; reads: wRandomLo, wRandomHi, wBattleTemp7F, wBattleTemp7D, wBattleTemp7E
; writes: wBattleTemp7D, wBattleTemp7E, wBattleTemp7F, wBattleTemp80
BattleEnd_Step3_Sub01_Sub02::
Func_016_74D2:: ; address name
    ld hl, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jr z, Jump_016_74E2
    ld bc, $03E7

Jump_016_74E2::
    ld a, c
    ld [wBattleTemp7D], a
    ld a, b
    ld [wBattleTemp7E], a
    ld a, $14
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, l
    ld [wBattleTemp7F], a
    ld a, h
    ld [wBattleTemp80], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, [wBattleTemp7F]
    or a, a
    call nz, DivideHLByA
    ld c, a
    ld a, [wBattleTemp7D]
    sub a, c
    ld l, a
    ld a, [wBattleTemp7E]
    sbc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub01)
; reads: wRandomLo, wRandomHi, wBattleTemp7F, wBattleTemp7D, wBattleTemp7E
; writes: wBattleTemp7D, wBattleTemp7E, wBattleTemp7F, wBattleTemp80
BattleEnd_Step3_Sub01_Sub03::
Func_016_751B:: ; address name
    ld hl, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jr z, Jump_016_752B
    ld bc, $03E7

Jump_016_752B::
    ld a, c
    ld [wBattleTemp7D], a
    ld a, b
    ld [wBattleTemp7E], a
    ld a, $14
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, l
    ld [wBattleTemp7F], a
    ld a, h
    ld [wBattleTemp80], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, [wBattleTemp7F]
    or a, a
    call nz, DivideHLByA
    ld c, a
    ld a, [wBattleTemp7D]
    sub a, c
    ld l, a
    ld a, [wBattleTemp7E]
    sbc a, $00
    ld h, a
    ld a, h
    cp a, $03
    ret z
    ld a, $08
    add_a_to_hl
    ret

; copies a tile to vTiles1 + $6D0, shows strings 6, 7 and 8 of category 2 (bank 09) at vTiles1 + $6D0, $750 and $7D0, then restores the default window (E-0127)
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi, wStringCategory, wStringIndex
ShowStrings6To8Bank09InRows:: ; heuristic: follows a terminator; C0
Func_016_756F:: ; address name
    ld de, vTiles1 + $2F0
    ld hl, vTiles1 + $6D0
    ld b, $10

Jump_016_7577::
    call WaitForVRAMAccess
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_016_7577
    ld hl, $0301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1 + $6D0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a ; 'Skill On Off Orb ID Odds'
    farcall ShowString_Bank09
    ld hl, vTiles1 + $750
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $07
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1 + $7D0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $08
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; address loaded by BattleEnd_Step5_Case01_Case01_Sub01_Case05, CountRecordsByField6E, ListPartyAndStoredRecordsForPage, ListRecordsWithField6EToListEntries and 1 more
Data_016_75EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

; checks the save; when valid, loads the player name, play time, party summaries and other title-screen details from SRAM bank 1 into wD0D5 onward (E-0129)
; 1 call site from 1 routine (e.g. DrawTitleSaveSummaryScreen)
; reads: hTemp0, sSavedPartyCount, sSavedPartyList, sSaveData, sSavedArenaByte37, sSavedMapType, sSavedMapId, sSavedKeyIndex
; writes: wBattlerRecords, rRAMG, rRAMB, wTitlePartyCount, wWorkBuf, wTitleByte0A, wTitleKeyFlag, wTitleStringIndex, ...
; points at: wBattlerRecords, sSavedPlayerName, wTitlePlayerName, sSavedPlayTime, wTitlePartySummary, sSavedKeyList
LoadSaveFileSummary::
Func_016_75EE:: ; address name
    ld hl, wBattlerRecords
    ld bc, $003C
    xor a, a
    call FillBytes
    farcall CheckSaveData
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_016_760B
    ld a, $00
    ld [wBattlerRecords], a
    jp Jump_016_76B5

Jump_016_760B::
    ld a, $01
    ld [wBattlerRecords], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedPlayerName
    ld de, wTitlePlayerName
    ld b, $0A
    call CopyBytesDEFromHL_Bank16
    ld hl, sSavedPlayTime
    ld de, wBattlerRecords + $B
    ld b, $05
    call CopyBytesDEFromHL_Bank16
    ld a, [sSavedPartyCount]
    ld [wTitlePartyCount], a
    push af
    ld a, [sSavedPartyList]
    ld [wWorkBuf], a
    ld de, wTitlePartySummary
    ld a, e
    ld [wWorkBuf + $1], a
    ld a, d
    ld [wWorkBuf + $2], a
    call BuildRecordSummaryForWorkBuf
    pop af
    cp a, $01
    jr z, Jump_016_767E
    push af
    ld a, [sSaveData + $101]
    ld [wWorkBuf], a
    ld de, wBattlerRecords + $1D
    ld a, e
    ld [wWorkBuf + $1], a
    ld a, d
    ld [wWorkBuf + $2], a
    call BuildRecordSummaryForWorkBuf
    pop af
    cp a, $02
    jr z, Jump_016_767E
    ld a, [sSaveData + $102]
    ld [wWorkBuf], a
    ld de, wBattlerRecords + $29
    ld a, e
    ld [wWorkBuf + $1], a
    ld a, d
    ld [wWorkBuf + $2], a
    call BuildRecordSummaryForWorkBuf

Jump_016_767E::
    ld a, [sSavedArenaByte37]
    ld [wTitleByte0A], a
    ld a, [sSavedMapType]
    ld [wTitleKeyFlag], a
    ld a, [sSavedMapId]
    ld [wTitleStringIndex], a
    ld a, [sSavedKeyIndex]
    ld hl, sSavedKeyList
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wTitleKeyEntry], a
    ld a, [hl+]
    ld [wTitleKeyWord1], a
    ld a, [hl+]
    ld [wTitleKeyWord2], a
    ld a, [hl]
    ld [wTitleKeyByte3], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a

Jump_016_76B5::
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 2 call sites from 1 routine (e.g. LoadSaveFileSummary)
CopyBytesDEFromHL_Bank16::
Func_016_76B6:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank16
    ret

; for SRAM bank-1 record wD09D writes its family nibble, a packed field from bytes $21/$27 (Func_016_7720) and field $62 & $7F to the buffer at wD09E (E-0127)
; 3 call sites from 1 routine (e.g. LoadSaveFileSummary)
; reads: wWorkBuf
; writes: wWorkBuf
BuildRecordSummaryForWorkBuf::
Func_016_76BD:: ; address name
    ld a, [wWorkBuf]
    ld c, $6F
    call Multiply8
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [wWorkBuf + $3], a
    ld a, h
    ld [wWorkBuf + $4], a
    ld a, [wWorkBuf + $1]
    ld e, a
    ld a, [wWorkBuf + $2]
    ld d, a
    ld a, [hl]
    and a, $0F
    ld [de], a
    inc de
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, [hl]
    ld a, l
    add a, $06
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld c, [hl]
    ld a, [wWorkBuf + $3]
    add a, $03
    ld l, a
    ld a, [wWorkBuf + $4]
    adc a, $00
    ld h, a
    call BuildRecordSummaryForWorkBuf_Sub01
    ld a, [wWorkBuf + $3]
    add a, $62
    ld l, a
    ld a, [wWorkBuf + $4]
    adc a, $00
    ld h, a
    ld a, [wWorkBuf + $1]
    add a, $0B
    ld e, a
    ld a, [wWorkBuf + $2]
    adc a, $00
    ld d, a
    ld a, [hl]
    and a, $7F
    ld [de], a
    ret

; only called from BuildRecordSummaryForWorkBuf (E-0047)
; 1 call site from 1 routine (e.g. BuildRecordSummaryForWorkBuf)
BuildRecordSummaryForWorkBuf_Sub01::
Func_016_7720:: ; address name
    push de
    ld a, $F0
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    pop de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $C0
    jr z, Jump_016_7744
    inc de
    rlca
    rlca
    add a, $8C
    ld [de], a

Jump_016_7744::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $30
    jr z, Jump_016_7752
    inc de
    swap a
    add a, $8C
    ld [de], a

Jump_016_7752::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $0C
    jr z, Jump_016_7760
    inc de
    rrca
    rrca
    add a, $8C
    ld [de], a

Jump_016_7760::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $03
    jr z, Jump_016_776C
    inc de
    add a, $8C
    ld [de], a

Jump_016_776C::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, c
    and a, $C0
    jr z, Jump_016_777A
    inc de
    rlca
    rlca
    add a, $8C
    ld [de], a

Jump_016_777A::
    ret

; far-calls DecompressGraphicsA4ToTiles0 and continues at Jump_016_77A6 (E-0127)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case06_Case00_Sub01, RunGameMode5Case01SubStates_Case02_Case00_ShowMaster)
; reads: wBattlerRecords, wGameMode, wTitlePlayHoursLo, wTitlePlayHoursHi, wTitlePlayMinutes, wTitlePartyCount
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wTitlePlayerName, wTitlePartySummary
DecompressA4GraphicsAndContinue::
Func_016_777B:: ; address name
    farcall DecompressGraphicsA4ToTiles0
    jr Jump_016_77A6

; loads the summary graphics and palette, the save file summary, and draws the player name, party icons, names, levels and key name on the title screen (E-0131)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattlerRecords, wGameMode, wTitlePlayHoursLo, wTitlePlayHoursHi, wTitlePlayMinutes, wTitlePartyCount
; writes: wOBJPaletteUploadRequest, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wOBJPaletteBuffer, wTitlePlayerName, wTitlePartySummary
DrawTitleSaveSummaryScreen:: ; heuristic: follows a terminator; C0
Func_016_7783:: ; address name
    ld b, $7E
    ld de, Tiles0Gfx_7E_5B63
    ld hl, vTiles0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_016_77A6
    ld de, OBJPaletteBufferData_7E_5BB8
    ld b, $7E
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

Jump_016_77A6::
    call LoadSaveFileSummary
    ld a, [wBattlerRecords]
    or a, a
    jp nz, Jump_016_7832
    ld hl, wScreenTileBuffer + $41
    ld bc, $1104
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_77C0
    ld hl, wScreenTileBuffer + $81

Jump_016_77C0::
    ld a, $C3

Jump_016_77C2::
    push bc
    push hl

Jump_016_77C4::
    ld [hl+], a
    dec b
    jr nz, Jump_016_77C4
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_016_77C2
    ld hl, wScreenTileBuffer + $C4
    ld b, $0E
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_77E4
    ld hl, wScreenTileBuffer + $104
    ld a, $40
    jr Jump_016_77E6

Jump_016_77E4::
    ld a, $20

Jump_016_77E6::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_016_77E6
    ld hl, vTiles2 + $200
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_77F8
    ld hl, vTiles2 + $400

Jump_016_77F8::
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0E01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0A
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

Jump_016_7832::
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld hl, wTitlePlayerName
    ld de, vTiles2 + $200
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_7857
    ld de, vTiles2 + $400

Jump_016_7857::
    call ShowTenByteNameAtDE
    ld a, [wTitlePlayHoursLo]
    ld l, a
    ld a, [wTitlePlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $4D
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_7872
    ld de, wScreenTileBuffer + $8D

Jump_016_7872::
    call WriteThreeDigitTilesDigits_Bank16
    ld a, [wTitlePlayMinutes]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $51
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_788B
    ld de, wScreenTileBuffer + $91

Jump_016_788B::
    call WriteTwoDigitTilesWC8C1NoBlank_Bank16
    ld a, [wTitlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wTitlePartySummary
    call DrawSaveSummaryPartyEntryC
    ld c, $01
    ld hl, wBattlerRecords + $1D
    call DrawSaveSummaryPartyEntryC
    ld c, $02
    ld hl, wBattlerRecords + $29
    call DrawSaveSummaryPartyEntryC
    call BlankTwoTileCellByGameMode
    call ShowKeyNameOrStringForTitleKeyFlag
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; writes wC8C0 as a digit tile at DE and falls into WriteTwoDigitTilesWC8C1NoBlank_Bank16 (E-0126)
; 1 call site from 1 routine (e.g. DrawTitleSaveSummaryScreen)
; points at: wDigits
WriteThreeDigitTilesDigits_Bank16::
Func_016_78C7:: ; address name
    ld hl, wDigits
    ld a, [hl]
    add a, $E0
    ld [de], a
    inc de

; writes wC8C1 and wC8C2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank) (E-0117) (the same 13 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. DrawTitleSaveSummaryScreen, DrawSaveSummaryPartyEntryC)
WriteTwoDigitTilesWC8C1NoBlank_Bank16::
Func_016_78CF:: ; address name
    ld hl, wDigits + $1
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    ret

; window at DE: copies 10 bytes from HL to wC130 with a $F0 terminator and shows it (ShowString_Bank08) (E-0122)
; 2 call sites from 2 routines (e.g. DrawTitleSaveSummaryScreen, DrawSaveSummaryPartyEntryC)
; writes: wTextWindowTileLo, wTextWindowTileHi
; points at: wTextBuf0
ShowTenByteNameAtDE::
Func_016_78DC:: ; address name
    ld a, e
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    ld de, wTextBuf0
    ld b, $0A

Jump_016_78E9::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_78E9
    ld a, $F0
    ld [de], a
    farcall ShowString_Bank08
    ret

; for summary entry C (below B) loads its family icon, shows its 10-byte name and writes its level; otherwise blanks the entry (E-0129)
; 3 call sites from 1 routine (e.g. DrawTitleSaveSummaryScreen)
; reads: wGameMode
; writes: wWorkBuf
DrawSaveSummaryPartyEntryC::
Func_016_78F9:: ; address name
    ld a, c
    cp a, b
    jr nc, Jump_016_7969
    push bc
    ld a, [hl+]
    ld [wWorkBuf], a
    push hl
    ld a, c
    ld hl, Data_016_7A36
    push af
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_7912
    ld hl, Data_016_7A39

Jump_016_7912::
    pop af
    add_a_to_hl
    ld a, [hl]
    ld [wWorkBuf + $1], a
    push hl
    call LoadFamilyIconTileForWorkBuf
    pop hl
    ld a, [hl]
    swap a
    and a, $0F
    or a, $90
    ld d, a
    ld a, [hl]
    swap a
    and a, $F0
    ld e, a
    ld a, e
    add a, $10
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    push hl
    call ShowTenByteNameAtDE
    pop hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld l, [hl]
    ld h, $00
    call HLToDecimalDigits
    pop bc
    ld a, c
    ld hl, Data_016_7A3C
    push af
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_795B
    ld hl, Data_016_7A42

Jump_016_795B::
    pop af
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call WriteTwoDigitTilesWC8C1NoBlank_Bank16
    ret

Jump_016_7969::
    ld hl, Data_016_7A3C
    push af
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_7977
    ld hl, Data_016_7A42

Jump_016_7977::
    pop af
    add a, a
    add_a_to_hl
    deref_hl
    ld de, $FFF7
    add hl, de
    push bc
    ld b, $0B
    ld a, $C3

Jump_016_798A::
    ld [hl+], a
    dec b
    jr nz, Jump_016_798A
    pop bc
    ret

; writes $C3 to wC227/8 and wC247/8, or to wC267/8 and wC287/8 in game mode 5 (E-0122)
; 1 call site from 1 routine (e.g. DrawTitleSaveSummaryScreen)
; reads: wGameMode
; writes: wScreenTileBuffer
BlankTwoTileCellByGameMode::
Func_016_7990:: ; address name
    ld a, [wGameMode]
    cp a, $05
    jr z, Jump_016_79A6
    ld a, $C3
    ld [wScreenTileBuffer + $8F], a
    ld [wScreenTileBuffer + $90], a
    ld [wScreenTileBuffer + $AF], a
    ld [wScreenTileBuffer + $B0], a
    ret

Jump_016_79A6::
    ld a, $C3
    ld [wScreenTileBuffer + $CF], a
    ld [wScreenTileBuffer + $D0], a
    ld [wScreenTileBuffer + $EF], a
    ld [wScreenTileBuffer + $F0], a
    ret

; window at vTiles2 + $3B0 (or + $5B0 in game mode 5): shows string wD10C + $0A, or builds a two-word key name from wD10E/wD10F (E-0127)
; 1 call site from 1 routine (e.g. DrawTitleSaveSummaryScreen)
; reads: wGameMode, wTitleKeyFlag, wTitleStringIndex, wTitleKeyByte3, wTitleKeyWord1, wTitleKeyWord2, wTitleKeyEntry
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory
; points at: wTextBuf0
ShowKeyNameOrStringForTitleKeyFlag::
Func_016_79B5:: ; address name
    ld hl, vTiles2 + $3B0
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_79C2
    ld hl, vTiles2 + $5B0

Jump_016_79C2::
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0D01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wTitleKeyFlag]
    bit 7, a
    jr nz, Jump_016_79EF
    ld a, [wTitleStringIndex]
    add a, $0A
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_Bank08
    ret

Jump_016_79EF::
    ld a, [wTitleKeyByte3]
    bit 7, a
    jr nz, Jump_016_7A22
    ld de, wTextBuf0
    ld a, [wTitleKeyWord1]
    inc a
    call CopyKeyNameWordToDE_Bank16
    dec de
    ld a, [wTitleKeyWord2]
    add a, $11
    call CopyKeyNameWordToDE_Bank16
    dec de
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ret

; calls CopyKeyNameWordToDE (bank $00) (E-0114)
; 2 call sites from 1 routine (e.g. ShowKeyNameOrStringForTitleKeyFlag)
CopyKeyNameWordToDE_Bank16::
Func_016_7A1E:: ; address name
    call CopyKeyNameWordToDE
    ret

Jump_016_7A22::
    ld a, [wTitleKeyEntry]
    and a, $3F
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall ShowString_Bank09
    ret

; address loaded by DrawSaveSummaryPartyEntryC
Data_016_7A36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $25, $2B, $31

; address loaded by DrawSaveSummaryPartyEntryC
Data_016_7A39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $45, $4B, $51

; address loaded by DrawSaveSummaryPartyEntryC
Data_016_7A3C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $22, $C2, $62, $C2, $A2, $C2

; address loaded by DrawSaveSummaryPartyEntryC
Data_016_7A42:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $C2, $A2, $C2, $E2, $C2

; writes the 16-byte icon tile of family wD09D (Data_016_7ACD + 16 * family) to VRAM tile wD09E through Func_016_7AAF; corrected in E-0124, first named as a palette load (E-0122)
; 19 call sites from 19 routines (e.g. DrawSaveSummaryPartyEntryC, ShowSpeciesNameAndIconForSlotB, LibraryMenu_Case10_Case04, LibraryMenu_Case10_Case06_Sub02, ...)
; reads: wWorkBuf
LoadFamilyIconTileForWorkBuf::
Func_016_7A48:: ; address name
    ld a, [wWorkBuf]
    swap a
    ld de, FamilyIconTiles
    add a, e
    ld e, a
    jr nc, Jump_016_7A55
    inc d

Jump_016_7A55::
    ld b, $10
    call WriteBytesToVRAMTileWD09E
    ret

; writes the $B0 bytes at Data_016_7ACD (the eleven family icon tiles) to VRAM from tile wD09E; corrected in E-0124 (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case05_Case00, GameMode5_Init_Case04)
LoadAllFamilyIconTiles::
Func_016_7A5B:: ; address name
    ld de, FamilyIconTiles
    ld b, $B0
    call WriteBytesToVRAMTileWD09E
    ret

; with SRAM enabled (bank 0), runs LoadTileForRecordByte0D for record list entries 0, 1 and 2 with H = $C7, $C8 and $C9, stopping after wC6FD entries; then disables SRAM (E-0103)
; 6 call sites from 6 routines (e.g. ShowIdlePartyStatusWindow, PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor, PauseMenu_State3_Case00_Case00, LibraryMenu_Case08, ...)
; reads: wPartyCount
; writes: rRAMG, rRAMB
LoadTilesForPartyRecords::
Func_016_7A64:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, $00
    ld h, $C7
    call LoadTileForRecordByte0D
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_016_7A91
    ld a, $01
    ld h, $C8
    call LoadTileForRecordByte0D
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_016_7A91
    ld a, $02
    ld h, $C9
    call LoadTileForRecordByte0D

Jump_016_7A91::
    ld a, $00
    ld [rRAMG], a
    ret

; A = record (SRAMRecordAddressMapped, offset $0D), H = destination page: picks 16 bytes from Data_016_7ACD by the low nibble of record byte $0D and copies them on through the shared copy loop at Jump_016_7AB2 (not read to its end) (E-0103)
; 3 call sites from 1 routine (e.g. LoadTilesForPartyRecords)
LoadTileForRecordByte0D::
Func_016_7A97:: ; address name
    push hl
    ld c, $0D
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $0F
    swap a
    ld de, FamilyIconTiles
    add a, e
    ld e, a
    jr nc, Jump_016_7AAA
    inc d

Jump_016_7AAA::
    ld b, $10
    pop af
    jr Jump_016_7AB2

; writes B bytes from DE to VRAM tile wD09E ($8000 + 16 * index; indices below $80 use the $9000 area) (E-0124)
; 2 call sites from 2 routines (e.g. LoadFamilyIconTileForWorkBuf, LoadAllFamilyIconTiles)
; reads: wWorkBuf
WriteBytesToVRAMTileWD09E::
Func_016_7AAF:: ; address name
    ld a, [wWorkBuf + $1]

Jump_016_7AB2::
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    or a, $80
    ld h, a
    cp a, $88
    jr nc, Jump_016_7AC4
    set 4, h

Jump_016_7AC4::
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, Jump_016_7AC4
    ret

; E-0229 (C1: LoadFamilyIconTileForWorkBuf copies the 16 bytes at $7ACD + 16 * family (wWorkBuf) to VRAM; 11 families).
; record: the 16-byte icon tile of one family
FamilyIconTiles::
Data_016_7ACD:: ; address name
    db $FF, $10, $FF, $10, $EF, $38, $EF, $54, $FF, $AA, $AB, $D6, $83, $FE, $FF, $7C ; id 0
    db $F7, $0E, $FF, $0C, $FF, $1E, $F7, $EC, $FF, $FE, $FF, $AE, $FF, $1C, $EF, $70 ; id 1
    db $FF, $00, $FF, $18, $FF, $DB, $FF, $C3, $FF, $3C, $FF, $7E, $FF, $7E, $FF, $3C ; id 2
    db $FF, $06, $FD, $0B, $FF, $16, $FD, $23, $E7, $56, $BB, $C6, $F3, $B0, $FF, $C0 ; id 3
    db $FF, $18, $E7, $24, $E7, $24, $C3, $42, $D3, $52, $F7, $76, $FF, $18, $DB, $18 ; id 4
    db $BB, $82, $FF, $44, $FF, $28, $FF, $7C, $BB, $FE, $D7, $92, $FF, $FE, $FF, $7C ; id 5
    db $FF, $18, $FF, $36, $EB, $2A, $F7, $15, $EB, $2B, $DF, $56, $BF, $A0, $FF, $C0 ; id 6
    db $FF, $00, $FF, $7C, $FF, $FE, $FF, $92, $FF, $EE, $FF, $FE, $FF, $54, $FF, $38 ; id 7
    db $FF, $00, $FF, $7C, $C7, $C6, $EF, $AA, $AB, $82, $D7, $D6, $AB, $AA, $FF, $7C ; id 8
    db $FF, $10, $FF, $10, $E7, $30, $DB, $60, $9B, $E6, $83, $FE, $C7, $7C, $FF, $38 ; id 9
    db $BB, $7C, $7D, $C6, $FF, $BA, $7D, $F6, $BB, $6C, $D7, $38, $FF, $28, $D7, $38 ; id 10

; address loaded by DecompressMenuTilesTo16E0
; LZSS-compressed asset: 405 bytes expand to 624 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles1Plus6E0Gfx_16_7B7D:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_016_7B7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05BB7D, $195

; LZSS-compressed asset: 67 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_016_7D12:: ; heuristic: stream found by tiling the gap after another stream; C0
    INCBIN "dwm2-cobi-us.gbc", $05BD12, $42
    ds $2AC, $00
