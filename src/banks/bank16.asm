SECTION "Bank 16", ROMX[$4000], BANK[$16]
    db $16, $F0, $C6, $CD, $92, $4A, $C9

; wItemId (wD081) = item id: copies the 13-byte ItemTable record to wItemRecord (wD084)
; 4 call sites from 4 routines (e.g. PauseMenu_Items_Case00_Case01, LoadSelectedInventoryItemRecord, Func_03B_42F4_Case0B, Func_0F1_4001_Case00_Case01)
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
; 3 call sites from 3 routines (e.g. PauseMenu_Items_Case02_Case08, PauseMenu_Items_Case02_Case16, PauseMenu_Items_Case02_Case1B)
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
; 1 call site from 1 routine (e.g. Func_016_52C9_Case00)
; reads: wD083
; writes: wItemId
ItemUsable_Herb::
Func_016_40F6:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; 1 call site from 1 routine (e.g. Func_016_52C9_Case03)
; reads: wC6FD
; writes: wItemId, wD08E
ItemUsable_WorldDew::
Func_016_4118:: ; address name
    ld a, [wC6FD]
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
    ld a, [wC6FD]
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
    ld a, [wC6FD]
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
    ld [wD08E], a
    ret

; only called from ItemUsable_WorldDew (E-0047)
; 3 call sites from 1 routine (e.g. ItemUsable_WorldDew)
; reads: wD083
; writes: wD083
; points at: wC6FD, wC160
ItemUsable_WorldDew_Sub01::
Func_016_41B3:: ; address name
    ld [wD083], a
    ld hl, wC6FD
    cp a, [hl]
    ret nc
    push de
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [wD083]
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
    ld hl, wC160
    add_a_to_hl
    push hl
    ld a, [wD083]
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
; 1 call site from 1 routine (e.g. Func_016_52C9_Case05)
; reads: wD083
; writes: wItemId
ItemUsable_Potion::
Func_016_41FD:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; 1 call site from 1 routine (e.g. Func_016_52C9_Case0A)
; reads: wD083
; writes: wItemId
ItemUsable_Antidote::
Func_016_421F:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 2, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 7 MoonHerb; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
; writes: wItemId
ItemUsable_MoonHerb::
Jump_016_4234:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 3, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 8 Laurel; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
; writes: wItemId
ItemUsable_Laurel::
Jump_016_4249:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; when a party member without bit 7 of field $55 has bit 0 set, copies the eligible names to wC160 and wD08E = $32 + their count; otherwise wItemId = $FF (E-0127)
; 1 call site from 1 routine (e.g. Func_016_52C9_Case0B)
; reads: wC6FD
; writes: wItemId, wD08E
ListPartyMembersWithField55Bit0::
Func_016_425E:: ; address name
    ld a, [wC6FD]
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
    ld a, [wC6FD]
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
    ld a, [wC6FD]
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
    call CopyEligibleRecordNameToWC160Row
    ld a, $01
    call CopyEligibleRecordNameToWC160Row
    ld a, $02
    call CopyEligibleRecordNameToWC160Row
    ld a, $32
    add a, d
    ld [wD08E], a
    ret

; if record A (< wC6FD) has field $55 bit 7 clear and bit 0 set, copies its name and marks (field 1) to wC160 + 16 * D and increments D (E-0121)
; 3 call sites from 1 routine (e.g. ListPartyMembersWithField55Bit0)
; reads: wD083
; writes: wD083
; points at: wC6FD, wC160
CopyEligibleRecordNameToWC160Row::
Func_016_42C4:: ; address name
    ld [wD083], a
    ld hl, wC6FD
    cp a, [hl]
    ret nc
    push de
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 0, [hl]
    pop de
    ret z
    push de
    ld a, d
    swap a
    ld hl, wC160
    add_a_to_hl
    push hl
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_AwakeSand::
Jump_016_4301:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 1, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 10 SkyBell; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
; writes: wItemId
ItemUsable_SkyBell::
Jump_016_4316:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 4, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 12 WorldLeaf; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. Func_016_52C9_Case08)
; reads: wD083
; writes: wItemId
ItemUsable_WorldLeaf::
Func_016_432B:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 13 ATKseed; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemUsable_ATKseed::
Jump_016_433C:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
ItemUsable_DEFseed::
Jump_016_4352:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
ItemUsable_AGLseed::
Jump_016_4368:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
ItemUsable_INTseed::
Jump_016_437E:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
ItemUsable_LifeAcorn::
Jump_016_4394:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
ItemUsable_MysticNut::
Jump_016_43AA:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_Quest::
Jump_016_43C0:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_Horror::
Jump_016_43D6:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_BeNice::
Jump_016_43EB:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_Cheater::
Jump_016_4401:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_Smart::
Jump_016_4416:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD083
; writes: wItemId
ItemUsable_Comedy::
Jump_016_442C:: ; address name
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
    call CheckWD083RecordFlag55Bit7
    ret nz
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 31 BeastTail; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
ItemUsable_BeastTail::
Jump_016_4446:: ; address name
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 32 Repellent, 33 ShinyHarp; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 2 call sites from 2 routines (e.g. Func_016_52C9_Case11, Func_016_52C9_Case0C)
; reads: wC901
; writes: wItemId
ItemUsable_Repellent::
Func_016_4447:: ; address name
    ld a, [wC901]
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
; 1 call site from 1 routine (e.g. Func_016_52C9_Case12)
ItemUsable_Warp::
Func_016_4454:: ; address name
    call ItemUsable_WarpWing
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 46 LogTwig; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; no direct call (reached through a table, a jump or a vector)
; reads: wCC44, hFFD0, hMapId
; writes: wItemId
ItemUsable_LogTwig::
Jump_016_4458:: ; address name
    ld a, [wCC44]
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
    ldh a, [hFFD0]
    or a, a
    ret nz
    ld a, $FE
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 41 WarpWing, 54 TidalBell; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 2 call sites from 2 routines (e.g. Func_016_52C9_Case13, ItemUsable_Warp)
; reads: wCC44, hMapId
; writes: wItemId
ItemUsable_WarpWing::
Func_016_44AD:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_016_44BD
    cp a, $80
    ret z
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_44BD::
    ldh a, [hMapId]
    ld hl, Data_016_51C9
    add_a_to_hl
    bit 6, [hl]
    ret nz
    ld a, $FF
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId = $FF) for item(s) 42 ExitBell; item names from StringTable_ItemNames; the body is not interpreted (E-0085)
; 1 call site from 1 routine (e.g. Func_016_52C9_Case0F)
; reads: wCC44, hMapId
; writes: wItemId
ItemUsable_ExitBell::
Func_016_44D0:: ; address name
    ld a, [wCC44]
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
    ld hl, Data_016_51C9
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
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, hPlayerFacing
; writes: wItemId
ItemUsable_WaterCall::
Jump_016_44FB:: ; address name
    ld a, [wCC44]
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
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, hPlayerY, hPlayerFacing, hPlayerX
; writes: wItemId
ItemUsable_MoonRock::
Jump_016_4548:: ; address name
    ld a, [wCC44]
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
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, hPlayerFacing
; writes: wItemId
ItemUsable_Crest::
Jump_016_4583:: ; address name
    ld a, [wCC44]
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
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, hPlayerFacing
; writes: wItemId
ItemUsable_SleepHerb::
Jump_016_45C3:: ; address name
    ld a, [wCC44]
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
; reads: wCC44, hMapId, hMapScreenY, wCB7E
; writes: wItemId
ItemUsable_Change::
Jump_016_45FA:: ; address name
    ld a, [wCC44]
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
    ld a, [wCB7E]
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
    call CheckWD083RecordFlag55Bit7
    ret

; A = wD083, then CheckRecordFlag55Bit7 (E-0066)
; 22 call sites from 22 routines (e.g. ItemApply_WorldDew_Sub01, ItemUsable_VITbelt, ItemUsable_BeefJerky, ItemUsable_Comedy, ...)
; reads: wD083
; writes: wItemId
CheckWD083RecordFlag55Bit7::
Func_016_4633:: ; address name
    ld a, [wD083]

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
; reads: wCC44, wC901, hMapId
Bank16Func4645ResultTest_Sub01::
Func_016_4645:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_016_4655
    ld a, [wC901]
    and a, $7F
    jr nz, Jump_016_4667
    jr Jump_016_4663

Jump_016_4655::
    ldh a, [hMapId]
    ld hl, Data_016_51C9
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
; reads: wD08F
; writes: wItemId
; points at: wC160
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
    ld a, [wD08F]
    jr nz, Jump_016_4681
    cp a, l
    jr z, Jump_016_4681
    jr c, Jump_016_4681
    ld a, l

Jump_016_4681::
    ld hl, wC160
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
; reads: wC5E7, wD08F, wD083
ItemApply_Herb::
Jump_016_475F:: ; address name
    call NextTableByte
    ld a, [wC5E7]
    ld b, a
    ld a, $0B
    call DivideBByA
    ld b, a
    ld a, [wD08F]
    add a, b
    ld l, a
    ld h, $00
    ld a, [wD083]
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
; reads: wD083
; writes: wD083
; points at: wC6FD
ItemApply_WorldDew_Sub01::
Func_016_4790:: ; address name
    ld hl, wC6FD
    cp a, [hl]
    ret nc
    ld [wD083], a
    call CheckWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wD083]
    ld c, $5B
    call StoreHLToRecordField
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 4 Potion; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD08F, wD083
ItemApply_Potion::
Jump_016_47B0:: ; address name
    call NextTableByte
    ld a, [wC5E7]
    ld b, a
    ld a, $0B
    call DivideBByA
    ld b, a
    ld a, [wD08F]
    add a, b
    ld l, a
    ld h, $00
    ld a, [wD083]
    call AddHLToRecordMPCapped
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 5 ElfWater; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemApply_ElfWater::
Jump_016_47CE:: ; address name
    ld a, [wD083]
    ld c, $61
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wD083]
    ld c, $5F
    call StoreHLToRecordField
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 6 Antidote; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemApply_Antidote::
Jump_016_47E5:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    res 2, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 7 MoonHerb; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemApply_MoonHerb::
Jump_016_47F3:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    res 3, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 8 Laurel; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemApply_Laurel::
Jump_016_4801:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    res 0, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 9 AwakeSand; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemApply_AwakeSand::
Jump_016_480F:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    res 1, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 10 SkyBell; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
ItemApply_SkyBell::
Jump_016_481D:: ; address name
    ld a, [wD083]
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
; reads: wD083
; writes: wD095
ItemApply_WorldLeaf::
Jump_016_482C:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    ld [hl], $00
    ld a, [wD083]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wD083]
    ld c, $5B
    call StoreHLToRecordField
    ld a, $01
    ld [wD095], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 13 ATKseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_ATKseed::
Jump_016_4852:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_ATKseed_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 14 DEFseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_DEFseed::
Jump_016_4862:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_DEFseed_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 15 AGLseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_AGLseed::
Jump_016_4872:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_AGLseed_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 16 INTseed; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_INTseed::
Jump_016_4882:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_INTseed_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 17 LifeAcorn; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_LifeAcorn::
Jump_016_4892:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_LifeAcorn_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 18 MysticNut; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_MysticNut::
Jump_016_48A2:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_MysticNut_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 19 Quest?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_Quest::
Jump_016_48B2:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_Quest_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 20 Horror?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_Horror::
Jump_016_48C2:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_Horror_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 21 BeNice?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_BeNice::
Jump_016_48D2:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_BeNice_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 22 Cheater?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_Cheater::
Jump_016_48E2:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_Cheater_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 23 Smart?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_Smart::
Jump_016_48F2:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_Smart_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 24 Comedy?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_Comedy::
Jump_016_4902:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ItemApply_Comedy_Sub01
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 25 BeefJerky, 26 PorkChop, 27 Rib, 28 Sirloin; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_BeefJerky::
Jump_016_4912:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ApplyMeatToRecordField6B
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 29 BadMeat; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
; reads: wD08F, wD083
ItemApply_BadMeat::
Jump_016_4922:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call ApplyMeatToRecordField6B
    ld a, [wD083]
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
; writes: wD091
ItemApply_Repellent::
Jump_016_493E:: ; address name
    ld a, $C8
    ld [wD091], a
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
; reads: wC832
; writes: wC832
ItemApply_TidalBell::
Jump_016_499A:: ; address name
    ld a, [wC832]
    add a, $32
    jr nc, Jump_016_49A3
    ld a, $FF

Jump_016_49A3::
    cp a, $F0
    jr c, Jump_016_49A9
    ld a, $F0

Jump_016_49A9::
    ld [wC832], a
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
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 65 DracoBelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_DracoBelt::
Jump_016_49BA:: ; address name
    ld a, $50
    ld c, $5D
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 66 MagicBelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MagicBelt::
Jump_016_49C5:: ; address name
    ld a, $1E
    ld c, $61
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 67 OddBelt; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_OddBelt::
Jump_016_49D0:: ; address name
    ld a, $50
    ld c, $61
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 68 StoneFang; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_StoneFang::
Jump_016_49DB:: ; address name
    ld a, $0A
    ld c, $63
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 69 SteelFang; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_SteelFang::
Jump_016_49E6:: ; address name
    ld a, $32
    ld c, $63
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 70 MermScale; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MermScale::
Jump_016_49F1:: ; address name
    ld a, $0A
    ld c, $65
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 71 DrakScale; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_DrakScale::
Jump_016_49FC:: ; address name
    ld a, $32
    ld c, $65
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 72 AGL?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_AGL::
Jump_016_4A07:: ; address name
    ld a, $0A
    ld c, $67
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 73 Starry?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Starry::
Jump_016_4A12:: ; address name
    ld a, $32
    ld c, $67
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 74 Smart?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Smart_4A1D::
Jump_016_4A1D:: ; address name
    ld a, $32
    ld c, $69
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 75 Wise?; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Wise::
Jump_016_4A28:: ; address name
    ld a, $64
    ld c, $69
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 76 MagicCape, 77 DracoCape, 78 SilvrCape, 79 GoldCape, 80 PltnmCape, 81 OrcaCape, 82 BraveCape; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_MagicCape::
Jump_016_4A33:: ; address name
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 83 D-Scale; the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_DScale::
Jump_016_4A37:: ; address name
    ld a, $05
    ld c, $65
    call AddAToRecordWordCapped
    call EquipItemOnRecordWD083
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
    call EquipItemOnRecordWD083
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 98 (no name); the body is not interpreted beyond the Herb case (E-0089)
; no direct call (reached through a table, a jump or a vector)
ItemApply_Item62::
Jump_016_4A47:: ; address name
    ret

; stores item wItemId - $3F in field $A4 of record wD083: an empty field consumes the item (hFFC6 = 0); otherwise the old item goes back to the inventory and its name to wC160 (hFFC6 = 1) (E-0125)
; 15 call sites from 15 routines (e.g. ItemApply_Life, ItemApply_DScale, ItemApply_MagicCape, ItemApply_Wise, ...)
; reads: wD083, wItemId, wD082
; writes: hFFC6, wItemId
; points at: wInventory, wC160
EquipItemOnRecordWD083::
Func_016_4A48:: ; address name
    ld a, [wD083]
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
    ldh [hFFC6], a
    ret

Jump_016_4A61::
    push af
    ld a, [wItemId]
    sub a, $3F
    ld [hl], a
    ld a, $FF
    ld [wItemId], a
    ld a, [wD082]
    ld hl, wInventory
    add_a_to_hl
    pop af
    add a, $3F
    ld [hl], a
    push af
    call CompactInventory
    pop af
    call CallFunc4A98KeepA
    ld l, a
    ld h, $05
    ld de, wC160
    call CopyStringHLToDE
    ld a, $01
    ldh [hFFC6], a
    ret

; calls Func_016_4A98 preserving A (E-0122)
; 1 call site from 1 routine (e.g. EquipItemOnRecordWD083)
CallFunc4A98KeepA::
Func_016_4A92:: ; address name
    push af
    call CallFunc4A98KeepA_Sub01
    pop af
    ret

; only called from CallFunc4A98KeepA (E-0047)
; 1 call site from 1 routine (e.g. CallFunc4A98KeepA)
CallFunc4A98KeepA_Sub01::
Func_016_4A98:: ; address name
    sub a, $40
    rst $00
    dw Func_016_4A98_Case00
    dw Func_016_4A98_Case01
    dw Func_016_4A98_Case02
    dw Func_016_4A98_Case03
    dw Func_016_4A98_Case04
    dw Func_016_4A98_Case05
    dw Func_016_4A98_Case06
    dw Func_016_4A98_Case07
    dw Func_016_4A98_Case08
    dw Func_016_4A98_Case09
    dw Func_016_4A98_Case0A
    dw Func_016_4A98_Case0B
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case0C
    dw Func_016_4A98_Case13
    dw Func_016_4A98_Case14
    dw Func_016_4A98_Case14
    dw Func_016_4A98_Case14
    dw Func_016_4A98_Case14
    dw Func_016_4A98_Case14
    dw Func_016_4A98_Case14
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case1A
    dw Func_016_4A98_Case22

; entry 0 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case00::
Jump_016_4AE1:: ; address name
    ld a, $1E
    ld c, $5D
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 1 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case01::
Jump_016_4AE9:: ; address name
    ld a, $50
    ld c, $5D
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 2 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case02::
Jump_016_4AF1:: ; address name
    ld a, $1E
    ld c, $61
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 3 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case03::
Jump_016_4AF9:: ; address name
    ld a, $50
    ld c, $61
    call SubtractAFromRecordWordPairFloor1
    ret

; entry 4 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case04::
Jump_016_4B01:: ; address name
    ld a, $0A
    ld c, $63
    call SubtractAFromRecordWordFloor1
    ret

; entry 5 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case05::
Jump_016_4B09:: ; address name
    ld a, $32
    ld c, $63
    call SubtractAFromRecordWordFloor1
    ret

; entry 6 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case06::
Jump_016_4B11:: ; address name
    ld a, $0A
    ld c, $65
    call SubtractAFromRecordWordFloor1
    ret

; entry 7 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case07::
Jump_016_4B19:: ; address name
    ld a, $32
    ld c, $65
    call SubtractAFromRecordWordFloor1
    ret

; entry 8 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case08::
Jump_016_4B21:: ; address name
    ld a, $0A
    ld c, $67
    call SubtractAFromRecordWordFloor1
    ret

; entry 9 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case09::
Jump_016_4B29:: ; address name
    ld a, $32
    ld c, $67
    call SubtractAFromRecordWordFloor1
    ret

; entry 10 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case0A::
Jump_016_4B31:: ; address name
    ld a, $32
    ld c, $69
    call SubtractAFromRecordWordFloor1
    ret

; entry 11 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case0B::
Jump_016_4B39:: ; address name
    ld a, $64
    ld c, $69
    call SubtractAFromRecordWordFloor1
    ret

; entry 12 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case0C::
Jump_016_4B41:: ; address name
    ret

; entry 19 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case13::
Jump_016_4B42:: ; address name
    ld a, $05
    ld c, $65
    call SubtractAFromRecordWordFloor1
    ret

; entry 20 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case14::
Jump_016_4B4A:: ; address name
    ret

; entry 26 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case1A::
Jump_016_4B4B:: ; address name
    ret

; entry 34 of the `rst $00` table in Func_016_4A98
; no direct call (reached through a table, a jump or a vector)
Func_016_4A98_Case22::
Jump_016_4B4C:: ; address name
    ret

; A = amount, record wD083 (SRAMRecordAddressMapped), field offset C: the word there += A, capped at 999 (CapDETo999) (E-0103)
; 9 call sites from 9 routines (e.g. ItemApply_DScale, ItemApply_Wise, ItemApply_Smart_4A1D, ItemApply_Starry, ...)
; reads: wD083, hFFC6
; writes: hFFC6
AddAToRecordWordCapped::
Func_016_4B4D:: ; address name
    ldh [hFFC6], a
    ld a, [wD083]
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hFFC6]
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
; reads: wD083, hFFC6
; writes: hFFC6
AddAToRecordWordPairCapped::
Func_016_4B68:: ; address name
    ldh [hFFC6], a
    ld a, [wD083]
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hFFC6]
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
    ldh a, [hFFC6]
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
; 9 call sites from 9 routines (e.g. Func_016_4A98_Case13, Func_016_4A98_Case0B, Func_016_4A98_Case0A, Func_016_4A98_Case09, ...)
; reads: wD083, hFFC6
; writes: hFFC6
SubtractAFromRecordWordFloor1::
Func_016_4B97:: ; address name
    ldh [hFFC6], a
    ld a, [wD083]
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
    ldh a, [hFFC6]
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
; 4 call sites from 4 routines (e.g. Func_016_4A98_Case03, Func_016_4A98_Case02, Func_016_4A98_Case01, Func_016_4A98_Case00)
; reads: wD083, hFFC6
; writes: hFFC6
SubtractAFromRecordWordPairFloor1::
Func_016_4BC4:: ; address name
    ldh [hFFC6], a
    ld a, [wD083]
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
    ldh a, [hFFC6]
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
    ldh a, [hFFC6]
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
; 33 call sites from 33 routines (e.g. EquipItemOnRecordWD083, ItemApply_LogTwig, ItemApply_Bookmark, ItemApply_ExitBell, ...)
; reads: wC5E7, wC5E8, wD082
; writes: wItemId
; points at: wD087, wInventory
ConsumeSelectedItemByChance::
Func_016_4C1D:: ; address name
    call NextTableByte
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, $64
    call DivideHLByA
    ld hl, wD087
    cp a, [hl]
    ret nc
    ld a, $FF
    ld [wItemId], a
    ld a, [wD082]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $FF
    call CompactInventory
    ret

; copies the 24 wInventory bytes to wD09D, refills wInventory with $FF, then copies back every byte that is neither $FF nor $00, closing the gaps (E-0063)
; 6 call sites from 6 routines (e.g. ConsumeSelectedItemByChance, EquipItemOnRecordWD083, RemoveWItemIdFromInventory, PauseMenu_Items_Case03_Case04, ...)
; points at: wD09D, wInventory
CompactInventory::
Func_016_4C48:: ; address name
    ld hl, wD09D
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
    ld hl, wD09D
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
Data_016_4CC2:: ; heuristic: start of a structured table; C0
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

Data_016_51C9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $10
    INCBIN "dwm2-cobi-us.gbc", $0591E9, $C3
    ds $1D, $00

; only called from PauseMenu_Skills_Case03_Case02 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case02)
; reads: wD082
; writes: wItemId
PauseMenu_Skills_Case03_Case02_Sub01::
Func_016_52C9:: ; address name
    ld a, [wD082]
    cp a, $14
    jr c, Jump_016_52D6
    ld a, $FF
    ld [wItemId], a
    ret

Jump_016_52D6::
    rst $00
    dw Func_016_52C9_Case00
    dw Func_016_52C9_Case00
    dw Func_016_52C9_Case00
    dw Func_016_52C9_Case03
    dw Func_016_52C9_Case03
    dw Func_016_52C9_Case05
    dw Func_016_52C9_Case05
    dw Func_016_52C9_Case05
    dw Func_016_52C9_Case08
    dw Func_016_52C9_Case08
    dw Func_016_52C9_Case0A
    dw Func_016_52C9_Case0B
    dw Func_016_52C9_Case0C
    dw Func_016_52C9_Case0C
    dw Func_016_52C9_Case0C
    dw Func_016_52C9_Case0F
    dw Func_016_52C9_Case0C
    dw Func_016_52C9_Case11
    dw Func_016_52C9_Case12
    dw Func_016_52C9_Case13

; entry 0 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
Func_016_52C9_Case00::
Jump_016_52FF:: ; address name
    call ItemUsable_Herb
    call SetWD08D12IfItemRefused
    ret

; entry 3 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
Func_016_52C9_Case03::
Jump_016_5306:: ; address name
    call ItemUsable_WorldDew
    call SetWD08D12IfItemRefused
    ret

; entry 5 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D, wD083
; writes: wItemId
Func_016_52C9_Case05::
Jump_016_530D:: ; address name
    ld a, [wC46D]
    ld c, a
    ld a, [wD083]
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
Func_016_52C9_Case08::
Jump_016_5325:: ; address name
    call ItemUsable_WorldLeaf
    call SetWD08D12IfItemRefused
    ret

; entry 10 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
Func_016_52C9_Case0A::
Jump_016_532C:: ; address name
    call ItemUsable_Antidote
    call SetWD08D12IfItemRefused
    ret

; entry 11 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
Func_016_52C9_Case0B::
Jump_016_5333:: ; address name
    call ListPartyMembersWithField55Bit0
    call SetWD08D12IfItemRefused
    ret

; entry 12 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wD082, wItemId
; writes: wD08D
Func_016_52C9_Case0C::
Jump_016_533A:: ; address name
    call ItemUsable_Repellent
    ld a, [wD082]
    cp a, $10
    jr z, Jump_016_5348
    call SetWD08D14IfItemRefused
    ret

Jump_016_5348::
    ld a, [wItemId]
    cp a, $FF
    jr nz, Jump_016_5355
    ld a, $15
    ld [wD08D], a
    ret

Jump_016_5355::
    call CollectUniqueEncounterIdsToWD09F
    ret

; entry 15 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
Func_016_52C9_Case0F::
Jump_016_5359:: ; address name
    call ItemUsable_ExitBell
    call SetWD08D14IfItemRefused
    ret

; entry 17 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wGoldHi, wGoldMid, wGoldLo, wC634
; writes: wItemId, wD08D
Func_016_52C9_Case11::
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
    ld [wD08D], a
    ret

Jump_016_5385::
    ld a, [wC634]
    or a, a
    ret z
    cp a, $FF
    ret z
    ld a, $FF
    ld [wItemId], a
    ld a, $16
    ld [wD08D], a
    ret

; entry 18 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
; reads: wCC47
; writes: wItemId, wD08D
; points at: wCC48
Func_016_52C9_Case12::
Jump_016_5398:: ; address name
    call ItemUsable_Warp
    call SetWD08D14IfItemRefused
    ret z
    ld a, [wCC47]
    or a, a
    jr z, Jump_016_53BB
    ld hl, wCC48
    ld a, [wCC47]
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
    ld [wD08D], a
    ret

Jump_016_53C6::
    ret

; entry 19 of the `rst $00` table in Func_016_52C9
; no direct call (reached through a table, a jump or a vector)
Func_016_52C9_Case13::
Jump_016_53C7:: ; address name
    call ItemUsable_WarpWing
    call SetWD08D14IfItemRefused
    ret

; when wItemId is $FF (refused): wD08D = $12 (E-0119)
; 6 call sites from 6 routines (e.g. Func_016_52C9_Case0B, Func_016_52C9_Case0A, Func_016_52C9_Case08, Func_016_52C9_Case05, ...)
; reads: wItemId
; writes: wD08D
SetWD08D12IfItemRefused::
Func_016_53CE:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret nz
    ld a, $12
    ld [wD08D], a
    ret

; when wItemId is $FF (refused): wD08D = $14 (E-0119)
; 5 call sites from 5 routines (e.g. Func_016_52C9_Case13, Func_016_52C9_Case12, Func_016_52C9_Case11, Func_016_52C9_Case0F, ...)
; reads: wItemId
; writes: wD08D
SetWD08D14IfItemRefused::
Func_016_53DA:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret nz
    ld a, $14
    ld [wD08D], a
    ret

; only called from PauseMenu_Skills_Case03_Case07 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case03_Case07)
; reads: wItemId, wD082
PauseMenu_Skills_Case03_Case07_Sub01::
Func_016_53E6:: ; address name
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld a, [wD082]
    rst $00
    dw Func_016_53E6_Case00
    dw Func_016_53E6_Case01
    dw FullHealRecordWD083
    dw Func_016_53E6_Case03
    dw Func_016_53E6_Case04
    dw Func_016_53E6_Case05
    dw Func_016_53E6_Case06
    dw Func_016_53E6_Case07
    dw Func_016_53E6_Case08
    dw Func_016_53E6_Case09
    dw Func_016_53E6_Case0A
    dw Func_016_53E6_Case0B
    dw Func_016_53E6_Case0C
    dw Func_016_53E6_Case0D
    dw Func_016_53E6_Case0E
    dw Func_016_53E6_Case0F
    dw Func_016_53E6_Case10
    dw Func_016_53E6_Case11
    dw Func_016_53E6_Case12
    dw Func_016_53E6_Case13

; entry 0 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08F, wD090, wD08D
Func_016_53E6_Case00::
Jump_016_5418:: ; address name
    ld a, $0A
    ld [wD08F], a
    ld a, $1E
    ld [wD090], a
    call HealRecordHPByRandomAmount
    ld a, $06
    ld [wD08D], a
    ret

; entry 1 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08F, wD090, wD08D
Func_016_53E6_Case01::
Jump_016_542B:: ; address name
    ld a, $0F
    ld [wD08F], a
    ld a, $4B
    ld [wD090], a
    call HealRecordHPByRandomAmount
    ld a, $06
    ld [wD08D], a
    ret

; record wD083: copies its word at field $5D (max HP) into field $5B (HP) (StoreHLToRecordField), then wD08D = 6 (E-0117)
; 1 call site from 1 routine (e.g. Func_016_53E6_Case09)
; reads: wD083
; writes: wD08D
FullHealRecordWD083::
Func_016_543E:: ; address name
    ld a, [wD083]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wD083]
    ld c, $5B
    call StoreHLToRecordField
    ld a, $06
    ld [wD08D], a
    ret

; entry 3 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wD08E, wD083
; writes: wD08F, wD090, wD08D, wD083
; points at: wC6FD
Func_016_53E6_Case03::
Jump_016_5457:: ; address name
    ld a, $1E
    ld [wD08F], a
    ld a, $5A
    ld [wD090], a
    ld a, [wD08E]
    ld [wD08D], a
    ld a, $00
    call HealPartyRecordAIfHurt
    ld a, $01
    call HealPartyRecordAIfHurt
    ld a, $02

; A = party index: returns when it is not below wC6FD, when record byte $55 bit 7 is set, or when HP ($5B) already equals max HP ($5D); otherwise Func_016_56AF (a random heal) (E-0120)
; 2 call sites from 1 routine (e.g. Func_016_53E6_Case03)
; reads: wD083
; writes: wD083
; points at: wC6FD
HealPartyRecordAIfHurt::
Func_016_5473:: ; address name
    ld hl, wC6FD
    cp a, [hl]
    ret nc
    ld [wD083], a
    call TestWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
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
; reads: wD08E, wD083
; writes: wD08D, wD083
; points at: wC6FD
Func_016_53E6_Case04::
Jump_016_549B:: ; address name
    ld a, [wD08E]
    ld [wD08D], a
    ld a, $00
    call FullHealPartyRecordA
    ld a, $01
    call FullHealPartyRecordA
    ld a, $02

; A = party index: returns when it is not below wC6FD or the record's byte $55 bit 7 is set; otherwise wD083 = A and the record's HP word ($5B) = its max HP word ($5D) (E-0117)
; 2 call sites from 1 routine (e.g. Func_016_53E6_Case04)
; reads: wD083
; writes: wD083
; points at: wC6FD
FullHealPartyRecordA::
Func_016_54AD:: ; address name
    ld hl, wC6FD
    cp a, [hl]
    ret nc
    ld [wD083], a
    call TestWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $5D
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wD083]
    ld c, $5B
    call StoreHLToRecordField
    ret

; entry 5 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08F, wD08D
Func_016_53E6_Case05::
Jump_016_54CD:: ; address name
    ld a, $0F
    ld [wD08F], a
    call HealRecordMPByWD08F
    ld a, $07
    ld [wD08D], a
    ret

; entry 6 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08F, wD08D
Func_016_53E6_Case06::
Jump_016_54DB:: ; address name
    ld a, $1E
    ld [wD08F], a
    call HealRecordMPByWD08F
    ld a, $07
    ld [wD08D], a
    ret

; entry 7 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08F, wD08D
Func_016_53E6_Case07::
Jump_016_54E9:: ; address name
    ld a, $50
    ld [wD08F], a
    call HealRecordMPByWD08F
    ld a, $07
    ld [wD08D], a
    ret

; entry 8 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
; writes: wD08D, wD095
Func_016_53E6_Case08::
Jump_016_54F7:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    ld [hl], $00
    ld a, [wD083]
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
    ld [wD08D], a
    ld a, $01
    ld [wD095], a
    ret

; entry 9 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
; writes: wD08D, wD095
Func_016_53E6_Case09::
Jump_016_5522:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    ld [hl], $00
    call FullHealRecordWD083
    ld a, $08
    ld [wD08D], a
    ld a, $01
    ld [wD095], a
    ret

; entry 10 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wD083
; writes: wD08D
Func_016_53E6_Case0A::
Jump_016_553A:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    res 2, [hl]
    ld a, $09
    ld [wD08D], a
    ret

; entry 11 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wD08E, wD083
; writes: wD08D, wD083
; points at: wC6FD
Func_016_53E6_Case0B::
Jump_016_554A:: ; address name
    ld a, [wD08E]
    ld [wD08D], a
    ld a, $00
    call ClearPartyRecordFlag55Bit0
    ld a, $01
    call ClearPartyRecordFlag55Bit0
    ld a, $02

; A = party index: returns when it is not below wC6FD or byte $55 bit 7 is set; otherwise clears bit 0 of the record's byte $55 (E-0117)
; 2 call sites from 1 routine (e.g. Func_016_53E6_Case0B)
; reads: wD083
; writes: wD083
; points at: wC6FD
ClearPartyRecordFlag55Bit0::
Func_016_555C:: ; address name
    ld hl, wC6FD
    cp a, [hl]
    ret nc
    ld [wD083], a
    call TestWD083RecordFlag55Bit7
    ret nz
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    res 0, [hl]
    ret

; entry 12 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave, wD08D, wItemId
Func_016_53E6_Case0C::
Jump_016_5573:: ; address name
    ld a, $01
    ld [wDataBankSave], a
    ld a, $FF
    ld [wD08D], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 13 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D
; writes: wDataBankSave, wD068, wD08D, wItemId
Func_016_53E6_Case0D::
Jump_016_5583:: ; address name
    ld a, $01
    ld [wDataBankSave], a
    ld a, [wC46D]
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $01
    xor a, $01
    or a, $10
    ld [wD068], a
    ld a, $FF
    ld [wD08D], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 14 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD069, wD08D, wItemId
Func_016_53E6_Case0E::
Jump_016_55A5:: ; address name
    ld a, $C8
    ld [wD069], a
    ld a, $FF
    ld [wD08D], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 15 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBankSave, wD08D, wItemId
Func_016_53E6_Case0F::
Jump_016_55B5:: ; address name
    ld a, $04
    ld [wDataBankSave], a
    ld a, $FF
    ld [wD08D], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 16 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08D
Func_016_53E6_Case10::
Jump_016_55C5:: ; address name
    ld a, $0B
    ld [wD08D], a
    ret

; entry 17 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; reads: wCC44, wC935, wC5E7, wC5E8
; writes: wSpriteSlotCount, wCB7E, wC935, wItemId, wD08D, wC634
; points at: wGoldLo, wC160
Func_016_53E6_Case11::
Jump_016_55CB:: ; address name
    ld a, [wCC44]
    cp a, $80
    jr nz, Jump_016_55E3
    ld a, [wC935]
    bit 7, a
    jr z, Jump_016_55E3
    xor a, a
    ld [wSpriteSlotCount], a
    ld [wCB7E], a
    ld [wC935], a

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
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
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
    ld [wC634], a
    ld l, c
    ld h, $05
    ld de, wC160
    call CopyStringHLToDE
    farcall CompactInventory

Jump_016_5688::
    ld a, $0E
    ld [wD08D], a
    ret

; entry 18 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wC950, wD08D, wItemId
Func_016_53E6_Case12::
Jump_016_568E:: ; address name
    ld a, $01
    ld [wC950], a
    ld a, $11
    ld [wD08D], a
    ld a, $FF
    ld [wItemId], a
    ret

; entry 19 of the `rst $00` table in Func_016_53E6
; no direct call (reached through a table, a jump or a vector)
; writes: wD08D, wItemId
Func_016_53E6_Case13::
Jump_016_569E:: ; address name
    farcall MarkVisitedScreens5x5AroundPlayer
    ld a, $1C
    ld [wD08D], a
    ld a, $FF
    ld [wItemId], a
    ret

; reads the next table byte, then heals record wD083's HP by wC5E7 / (wD08F + 1) + wD090 (capped at max HP) (E-0122)
; 3 call sites from 3 routines (e.g. HealPartyRecordAIfHurt, Func_016_53E6_Case01, Func_016_53E6_Case00)
; reads: wC5E7, wD08F, wD090, wD083
HealRecordHPByRandomAmount::
Func_016_56AF:: ; address name
    call NextTableByte
    ld a, [wC5E7]
    ld b, a
    ld a, [wD08F]
    inc a
    call DivideBByA
    ld b, a
    ld a, [wD090]
    add a, b
    ld l, a
    ld h, $00
    ld a, [wD083]
    call AddHLToRecordHPCapped
    ret

; heals record wD083's MP by wD08F (capped at max MP) (E-0122)
; 3 call sites from 3 routines (e.g. Func_016_53E6_Case07, Func_016_53E6_Case06, Func_016_53E6_Case05)
; reads: wD08F, wD083
HealRecordMPByWD08F::
Func_016_56CC:: ; address name
    ld a, [wD08F]
    ld l, a
    ld h, $00
    ld a, [wD083]
    call AddHLToRecordMPCapped
    ret

; Z clear when bit 7 of byte $55 of record wD083 is set (SRAMRecordAddressMapped); HL points at it (E-0114)
; 3 call sites from 3 routines (e.g. ClearPartyRecordFlag55Bit0, FullHealPartyRecordA, HealPartyRecordAIfHurt)
; reads: wD083
TestWD083RecordFlag55Bit7::
Func_016_56D9:: ; address name
    ld a, [wD083]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret

; for special maps copies the eight monster entries of the current screen (AddressOfWCD10EntryForCurrentScreen) to wD09F, removes duplicates and stores the count in wD09D; normal maps use Func_00A_4D5E (E-0129)
; 1 call site from 1 routine (e.g. Func_016_52C9_Case0C)
; reads: wCC44, wD09F, wD0A0, wD09E
; writes: wD09E, wD09D
; points at: wD09F, wD0A1
CollectUniqueEncounterIdsToWD09F::
Func_016_56E4:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_016_56F2
    farcall CollectUniqueEncounterIdsToWD09F_Sub01
    ret

Jump_016_56F2::
    call AddressOfWCD10EntryForCurrentScreen
    ld de, wD09F
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
    ld hl, wD0A1
    ld a, [wD09F]
    ld e, a
    ld a, [wD0A0]
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
    ld a, [wD09E]
    inc a
    ld [wD09E], a
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
    ld de, wD09F
    ld hl, wD09F
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
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ret

; HL = wCD10 + 2 * an index from the current map screen and the wCD70 table (index $20 when bit 3 of hFF8C is set) (E-0127)
; 1 call site from 1 routine (e.g. CollectUniqueEncounterIdsToWD09F)
; reads: hFF8C, wCC44, hMapScreenY, hMapScreenX, wCC45
; points at: wCD70, wCD10, wCD88
AddressOfWCD10EntryForCurrentScreen::
Func_016_5766:: ; address name
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_016_57C4
    ld a, [wCC44]
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
    ld hl, wCD70
    add_a_to_hl
    ld a, [hl]
    add a, a
    add a, a
    add a, c
    ld c, a
    jr Jump_016_57C6

Jump_016_5795::
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD88
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
    ld hl, wCD70
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
    ld hl, wCD10
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
; 2 call sites from 2 routines (e.g. HealRecordMPByWD08F, ItemApply_Potion)
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
ItemApply_ATKseed_Sub01::
Func_016_57FF:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $63
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_DEFseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_DEFseed)
ItemApply_DEFseed_Sub01::
Func_016_580B:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $65
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_AGLseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_AGLseed)
ItemApply_AGLseed_Sub01::
Func_016_5817:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $67
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_INTseed (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_INTseed)
ItemApply_INTseed_Sub01::
Func_016_5823:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $69
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_LifeAcorn (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_LifeAcorn)
ItemApply_LifeAcorn_Sub01::
Func_016_582F:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $5D
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_MysticNut (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_MysticNut)
ItemApply_MysticNut_Sub01::
Func_016_583B:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $61
    ld de, $03E7
    call AddToRecordFieldWordCapped
    ret

; only called from ItemApply_Quest (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Quest)
ItemApply_Quest_Sub01::
Func_016_5847:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $6F
    ld e, $FF
    call AddToRecordFieldByteCapped
    ret

; only called from ItemApply_Horror (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Horror)
ItemApply_Horror_Sub01::
Func_016_5852:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $6F
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; only called from ItemApply_BeNice (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_BeNice)
ItemApply_BeNice_Sub01::
Func_016_585D:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $70
    ld e, $FF
    call AddToRecordFieldByteCapped
    ret

; only called from ItemApply_Cheater (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Cheater)
ItemApply_Cheater_Sub01::
Func_016_5868:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $70
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; only called from ItemApply_Smart (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Smart)
ItemApply_Smart_Sub01::
Func_016_5873:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $72
    ld e, $FF
    call AddToRecordFieldByteCapped
    ret

; only called from ItemApply_Comedy (E-0047)
; 1 call site from 1 routine (e.g. ItemApply_Comedy)
ItemApply_Comedy_Sub01::
Func_016_587E:: ; address name
    call MapIndexViaWC6FEKeepHL
    ld c, $72
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; for the record selected through wC6FE, applies Func_016_58E0 to field $6B (E-0122)
; 2 call sites from 2 routines (e.g. ItemApply_BadMeat, ItemApply_BeefJerky)
ApplyMeatToRecordField6B::
Func_016_5889:: ; address name
    call MapIndexViaWC6FEKeepHL
    push hl
    ld c, $6B
    call SRAMRecordAddress
    pop de
    call ApplyMeatToRecordField6B_Sub01
    ret

; field C of record A: adds E, capped at the limit passed in DE's partner (Func_016_58B8) (E-0122)
; 3 call sites from 3 routines (e.g. ItemApply_Smart_Sub01, ItemApply_BeNice_Sub01, ItemApply_Quest_Sub01)
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
; 3 call sites from 3 routines (e.g. ItemApply_Comedy_Sub01, ItemApply_Cheater_Sub01, ItemApply_Horror_Sub01)
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
; 6 call sites from 6 routines (e.g. ItemApply_MysticNut_Sub01, ItemApply_LifeAcorn_Sub01, ItemApply_INTseed_Sub01, ItemApply_AGLseed_Sub01, ...)
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
; 5 call sites from 5 routines (e.g. FullHealPartyRecordA, FullHealRecordWD083, ItemApply_WorldLeaf, ItemApply_ElfWater, ...)
StoreHLToRecordField::
Func_016_58FD:: ; address name
    push hl
    call SRAMRecordAddressMapped
    pop bc
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; MapIndexViaWC6FE with HL preserved (E-0072)
; 13 call sites from 13 routines (e.g. ApplyMeatToRecordField6B, ItemApply_Comedy_Sub01, ItemApply_Smart_Sub01, ItemApply_Cheater_Sub01, ...)
MapIndexViaWC6FEKeepHL::
Func_016_5906:: ; address name
    push hl
    call MapIndexViaWC6FE
    pop hl
    ret

; toggles the sort order in wC836 and sorts the 24 inventory slots by the key table Data_016_599E or Data_016_5A0E (empty slots last) (E-0128)
; 3 call sites from 3 routines (e.g. PauseMenu_Items_Case00_Case01, RunBattleSetup_Case02_Case02, Func_0F1_4001_Case00_Case01)
; reads: wC836, wD09D, wD09E
; writes: wD09D, wD09E, wC836
; points at: wD09F, wInventory, wD0A0
SortInventory::
Func_016_590C:: ; address name
    ld hl, wD09F
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld bc, $0018
    ld a, $FF
    call FillBytes
    ld a, [wC836]
    bit 7, a
    jr nz, Jump_016_5928
    xor a, $01

Jump_016_5928::
    res 7, a
    ld [wC836], a
    ld de, Data_016_599E
    bit 0, a
    jr z, Jump_016_5937
    ld de, Data_016_5A0E

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
    ld a, [wD09D]
    ld c, a
    ld a, [wD09E]
    ld b, a
    ld a, [hl]
    ld [bc], a
    inc bc
    ld a, c
    ld [wD09D], a
    ld a, b
    ld [wD09E], a
    pop hl
    pop bc
    inc hl
    dec b
    jr nz, Jump_016_593C
    ld a, $18
    ld [wD09D], a

Jump_016_5966::
    ld hl, wD09F
    ld de, wD0A0
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
    ld a, [wD09D]
    dec a
    ld [wD09D], a
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

Data_016_599E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05999E, $70

Data_016_5A0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $059A0E, $70

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

Data_016_5AA7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $04, $08, $10, $20, $40, $80

; sets the bit of monster id wSpeciesIdLo/Hi in wSpeciesFlags (TestSpeciesFlag) and clears the high nibble of wC7FB (E-0070)
; 8 call sites from 8 routines (e.g. RunBattleSubStep_6A4E_Case01, CreateMonsterRecordOfKindHFFC7_Sub01_Sub01, GameMode5_Update_Case01_Case06_Case06_Sub01, ScriptCommandF3_Run_Case05_Case0E_Sub01, ...)
; reads: wC7FB
; writes: wC7FB
SetSpeciesFlag::
Func_016_5AAF:: ; address name
    call TestSpeciesFlag
    ld a, b
    or a, [hl]
    ld [hl], a
    push af
    ld a, [wC7FB]
    and a, $0F
    ld [wC7FB], a
    pop af
    ret

; zeroes the 11 per-family counters at wD09D, then for monster ids 0-372 ($175 is the end) skips unused ids (family $FF) and adds 1 to wD09D[family] when the species' flag is set (TestSpeciesFlag) or, when it is not, when Func_015_68FA finds the id in the list at wC7FC (wD7F5 not $FF). Leaves wSpeciesIdLo/Hi = 373 (E-0070)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case05_Case00, TotalSpeciesFlaggedOrListed)
; reads: wSpeciesRecord, wSpeciesIdLo, wSpeciesIdHi, wD7F5
; writes: wSpeciesIdLo, wSpeciesIdHi, wD7F1, wD7F2, wD7F3, wD7F4
; points at: wD09D, wC7FC
CountSpeciesPerFamilyFlaggedOrListed::
Func_016_5AC0:: ; address name
    xor a, a
    ld hl, wD09D
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
    ld de, wD09D
    add a, e
    ld e, a
    jr nc, Jump_016_5AE6
    inc d

Jump_016_5AE6::
    call TestSpeciesFlag
    jr nz, Jump_016_5B13
    push de
    ld a, [wSpeciesIdLo]
    ld [wD7F1], a
    ld a, [wSpeciesIdHi]
    ld [wD7F2], a
    ld hl, wC7FC
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall TestBitInFieldAtWD7F3
    pop de
    ld a, [wD7F5]
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
; points at: wD09D
BattleEnd_Step3_Sub01_Sub01::
Func_016_5B33:: ; address name
    xor a, a
    ld hl, wD09D
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
    ld de, wD09D
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
; reads: wC58A, wCFC5, wDAAB, wC5E7, wC5E8, wD00C, wD894, wD89F, ...
; writes: wD890, wSpeciesIdLo, wSpeciesIdHi, wDAAB
; points at: wD8A1, wBattleMonsterId
BattleEnd_Step5_Case00_Sub01::
Func_016_5B7E:: ; address name
    ld a, $01
    ld [wD890], a
    ld a, [wC58A]
    or a, a
    jp nz, Jump_016_5CF5
    ld a, [wCFC5]
    cp a, $03
    jp z, Jump_016_5CF5
    cp a, $04
    jp z, Jump_016_5CF5
    cp a, $05
    jp z, Jump_016_5CF5
    cp a, $08
    jp nc, Jump_016_5CF5
    ld a, [wDAAB]
    cp a, $FF
    jp z, Jump_016_5CF5
    cp a, $04
    jp c, Jump_016_5CF5
    cp a, $07
    jp nc, Jump_016_5CF5
    and a, $03
    ld hl, wD8A1
    add_a_to_hl
    ld a, [hl]
    cp a, $07
    jp z, Jump_016_5CF5
    ld a, [wDAAB]
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
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, $C8
    call DivideHLByA
    ld b, a
    ld a, [wD00C]
    cp a, $07
    jp z, Jump_016_5CF5
    ld hl, Data_016_5CFB
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jp nc, Jump_016_5CFA
    ld a, [wD894]
    or a, a
    jp nz, Jump_016_5CFA
    ld de, Data_016_5D03

Jump_016_5C15::
    ld a, [wD89F]
    ld c, a
    ld a, [wD8A0]
    ld b, a
    ld a, [wDAAB]
    and a, $03
    ld hl, wD8A1
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
    ld a, [wD894]
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
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
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
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, $64
    call DivideHLByA
    inc a
    cp a, $5B
    jr c, Jump_016_5CFA

Jump_016_5CF5::
    ld a, $FF
    ld [wDAAB], a

Jump_016_5CFA::
    ret

Data_016_5CFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $32, $18, $0A, $06, $02, $01, $00

Data_016_5D03:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $07

Data_016_5D0B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $11, $12, $13, $14, $15, $16, $07

; only called from BattleEnd_Step5_Case01_Case01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case01_Case01)
; reads: wBattleSubStep
BattleEnd_Step5_Case01_Case01_Sub01::
Func_016_5D13:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_016_5D13_Case00
    dw Func_016_5D13_Case01
    dw Func_016_5D13_Case02
    dw Func_016_5D13_Case03
    dw Func_016_5D13_Case04
    dw Func_016_5D13_Case05
    dw Func_016_5D13_Case06
    dw Func_016_5D13_Case03
    dw Func_016_5D13_Case04
    dw Func_016_5D13_Case09
    dw Func_016_5D13_Case0A
    dw Func_016_5D13_Case0B
    dw Func_016_5D13_Case0C
    dw Func_016_5D13_Case0D
    dw Func_016_5D13_Case0E
    dw Func_016_5D13_Case0F
    dw Func_016_5D13_Case10
    dw Func_016_5D13_Case11
    dw Func_016_5D13_Case12
    dw Func_016_5D13_Case13
    dw Func_016_5D13_Case14
    dw Func_016_5D13_Case15
    dw Func_016_5D13_Case16
    dw Func_016_5D13_Case17
    dw Func_016_5D13_Case18
    dw Func_016_5D13_Case19
    dw Func_016_5D13_Case1A
    dw Func_016_5D13_Case1B
    dw Func_016_5D13_Case1C

; entry 0 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wCFC5, hFFC6
; writes: wStringIndex, wC470, wC471, wCFD6
; points at: wBattleSubStep, wC130
Func_016_5D13_Case00::
Jump_016_5D51:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld de, wC130
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, [wCFC5]
    cp a, $08
    jr nc, Jump_016_5D71
    and a, $01
    jr z, Jump_016_5D7A
    farcall KeyWorldAreaEncounterIndex
    ldh a, [hFFC6]
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
    ld [wC470], a
    ld [wC471], a
    ld [wCFD6], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleStep
Func_016_5D13_Case01::
Jump_016_5D8C:: ; address name
    ld a, [wC52B]
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
; reads: wC52B
; writes: wStringIndex
; points at: wBattleSubStep
Func_016_5D13_Case02::
Jump_016_5DA0:: ; address name
    ld a, [wC52B]
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
; reads: wC52B
; writes: wC46B, wCFD0, wCFD1, wCFD2, wCFD3
; points at: wC2A6, wBattleSubStep
Func_016_5D13_Case03::
Jump_016_5DB2:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld de, wC2A6
    ld hl, vBGMap0 + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM_Bank16
    xor a, a
    ld [wC46B], a
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wBattleSubStep
; points at: wC46B, wBattleSubStep, wC130
Func_016_5D13_Case04::
Jump_016_5DE6:: ; address name
    ld de, wC46B
    ld hl, Data_016_66E7
    call SetDEFlagOnBButton
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [de]
    or a, a
    ret z
    ld de, wC130
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, $0C
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC7C7, wC0A0, wC0A1
; writes: wBattleSubStep
; points at: wBattleSubStep, wBattleSubPhase
Func_016_5D13_Case05::
Jump_016_5E0B:: ; address name
    ld a, $BC
    ld hl, vBGMap0 + $12F
    call WriteVRAMByte
    ld a, [wC7C7]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld a, [wC0A0]
    ld b, a
    ld a, [wC0A1]
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
Func_016_5D13_Case06::
Jump_016_5E3B:: ; address name
    ld a, $0D
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wStringIndex
; points at: wBattleSubStep
Func_016_5D13_Case09::
Jump_016_5E48:: ; address name
    ld a, [wC52B]
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
; reads: wC52B
; writes: wC46B, wCFD0, wCFD1, wCFD2, wCFD3
; points at: wScreenTileBuffer, wBattleSubStep
Func_016_5D13_Case0A::
Jump_016_5E5A:: ; address name
    ld a, [wC52B]
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
    ld [wC46B], a
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC470, wC0A1
; writes: wC46B, wCFD1, wStringIndex, wBattleSubStep
; points at: wC46B, wBattleSubStep, wScreenTileBuffer
Func_016_5D13_Case0B::
Jump_016_5E96:: ; address name
    ld de, wC46B
    ld hl, Data_016_6701
    call SetDEFlagOnBButton
    ret z
    ld a, [wJoypadPressed]
    and a, $02
    jr nz, Jump_016_5ED7
    ld a, [de]
    ld e, a
    xor a, a
    ld [wC46B], a
    ld a, [wC470]
    ld [wCFD1], a
    ld hl, wBattleSubStep
    inc [hl]
    ld a, e
    or a, a
    ret z
    call CountRecordsByField6E
    ld a, [wC0A1]
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
; points at: wD789, wScreenTileBuffer, wBattleSubStep
Func_016_5D13_Case0C::
Jump_016_5EEC:: ; address name
    ld hl, wD789
    ld bc, $001E
    ld a, $FF
    call FillBytes
    farcall CopyRectRecord796FToScreenBufferAndPlaySound6C
    call Func_016_64DC
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
; reads: wJoypadPressedRepeat, wJoypadPressed, wCFD1
; writes: wC470, wBattleSubStep
; points at: wC46B, wBattleSubStep
Func_016_5D13_Case0D::
Jump_016_5F24:: ; address name
    ld de, wC46B
    ld hl, Data_016_66F7
    call Func_016_65FF
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_016_5F38
    call DrawRecordListPageWithNumbers
    ret

Jump_016_5F38::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_5F4D
    ld a, [wCFD1]
    ld [wC470], a
    call ShowRecordNameString12
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_016_5F4D::
    bit 1, a
    ret z
    ld a, [wCFD1]
    ld [wC470], a
    ld a, $09
    ld [wBattleSubStep], a
    ret

; entry 14 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC46B
; writes: wC2C5, wC46C, wCFD0, wCFD1, wCFD2, wCFD3
; points at: wC2A4, wBattleSubStep
Func_016_5D13_Case0E::
Jump_016_5F5C:: ; address name
    ld a, [wC46B]
    ld hl, Data_016_66F7
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $BB
    ld [wC2C5], a
    ld de, wC2A4
    ld hl, vBGMap0 + $10C
    ld bc, $0805
    call CopyRect32StrideToVRAM_Bank16
    xor a, a
    ld [wC46C], a
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46C, wC470
; writes: wC2A4, wC2C4, wC2E4, wC304, wC324, wC2A5, wC2C5, wC2E5, ...
; points at: wC46C, wBattleSubStep, wC2A2
Func_016_5D13_Case0F::
Jump_016_5FA4:: ; address name
    ld de, wC46C
    ld hl, Data_016_66EB
    call Func_016_65FF
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_5FC7
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wC46C]
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
    ld [wC2A4], a
    ld a, $25
    ld [wC2C4], a
    ld a, $2B
    ld [wC2E4], a
    ld a, $31
    ld [wC304], a
    ld a, $37
    ld [wC324], a
    ld a, $C3
    ld [wC2A5], a
    ld [wC2C5], a
    ld [wC2E5], a
    ld [wC305], a
    ld [wC325], a
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $BC
    ld [wC2C3], a
    ld de, wC2A2
    ld hl, vBGMap0 + $10A
    ld bc, $0A05
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wC470]
    ld [wCFD1], a
    ld a, $0C
    ld [wBattleSubStep], a
    ret

; entry 16 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A0, wC46B, wC470
; writes: wD7A9, wD7AB, wD7AF, wD780, wD781, wD782
; points at: wScreenTileBuffer, wBattleSubPhase
Func_016_5D13_Case10::
Jump_016_6017:: ; address name
    ld a, [wC0A0]
    ld [wD7A9], a
    ld a, [wC46B]
    ld [wD7AB], a
    ld a, [wC470]
    ld [wD7AF], a
    farcall ClampRecordListPageCursor5
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0C
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wD782], a
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
; reads: wD7AB, wD7AF
; writes: wC46B, wC470, wCFD1, wC2C5, wCFD0, wCFD2, wCFD3, wBattleSubStep
; points at: wScreenTileBuffer
Func_016_5D13_Case11::
Jump_016_6058:: ; address name
    farcall CopyRectRecord796FToScreenBufferAndPlaySound6C
    ld a, [wD7AB]
    ld [wC46B], a
    ld hl, Data_016_66DD
    add a, a
    add_a_to_hl
    deref_hl
    ld [hl], $BC
    ld a, [wD7AF]
    ld [wC470], a
    ld [wCFD1], a
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $BB
    ld [wC2C5], a
    call Func_016_64DC
    call DrawRecordListPageWithNumbers
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM_Bank16
    call ShowRecordNameString12
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    ld a, $0F
    ld [wBattleSubStep], a
    ret

; entry 18 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC470, wC46B, wC6FD, wC6FE, wBattleSlotOut, wDA64, wC6FF, wDA65, ...
; writes: wStringIndex, wBattleSubStep, rRAMG
; points at: wD789, wBattleSubStep, wBattleSlotOut, wDA64, wDA65
Func_016_5D13_Case12::
Jump_016_60B5:: ; address name
    ld a, $BC
    ld hl, vBGMap0 + $16D
    call WriteVRAMByte
    ld a, [wC470]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wC46B]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld b, [hl]
    ld a, [wC6FD]
    cp a, $01
    jr nz, Jump_016_60ED
    ld a, [wC6FE]
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
    ld a, [wC6FD]
    cp a, $02
    jr nz, Jump_016_6118
    ld a, [wBattleSlotOut]
    ld c, a
    ld a, [wDA64]
    or a, c
    jr z, Jump_016_6143
    ld hl, wBattleSlotOut
    ld a, [wC6FE]
    cp a, b
    jr z, Jump_016_6112
    ld hl, wDA64
    ld a, [wC6FF]
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
    ld a, [wDA64]
    add a, c
    ld a, [wDA65]
    add a, c
    cp a, $02
    jr c, Jump_016_6143
    ld hl, wBattleSlotOut
    ld a, [wC6FE]
    cp a, b
    jr z, Jump_016_6112
    ld hl, wDA64
    ld a, [wC6FF]
    cp a, b
    jr z, Jump_016_6112
    ld hl, wDA65
    ld a, [wC700]
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
Func_016_5D13_Case13::
Jump_016_614C:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wBattleSubStep
Func_016_5D13_Case14::
Jump_016_6151:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, $13
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ret

; entry 21 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC470, wC46B, wC6FD, wC6FE, wC6FF, wC700
; writes: rRAMG, rRAMB, wD7F1, wD7F2, wD88F, wC6FF, wC700, wC0A0, ...
; points at: wD789, wBattleSubPhase
Func_016_5D13_Case15::
Jump_016_615E:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC470]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wC46B]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    pop hl
    ld a, [wC6FD]
    ld [wD88F], a
    cp a, $03
    jr z, Jump_016_61A8
    cp a, $02
    jr z, Jump_016_61A3
    ld a, $FF
    ld [wC6FF], a

Jump_016_61A3::
    ld a, $FF
    ld [wC700], a

Jump_016_61A8::
    ld a, [wC6FE]
    ld [wC0A0], a
    ld a, [wC6FF]
    ld [wC0A1], a
    ld a, [wC700]
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
; reads: wC0A1, wC471, wCFD6
; writes: wC303, wStringIndex, wD7A9, wCFD3, wCFD7, wCFD2, wC322, wC31F, ...
; points at: wScreenTileBuffer, wBattleSubStep
Func_016_5D13_Case16::
Jump_016_61D2:: ; address name
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $BC
    ld [wC303], a
    farcall CopyRectRecord78AAToScreenBuffer
    ld a, $6C
    call QueueSoundEffect
    ld a, $16
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    call CountRecordsByField6E
    call ListRecordsWithField6EToWD789
    ld a, [wC0A1]
    ld [wD7A9], a
    dec a
    ld b, a
    and a, $03
    inc a
    ld [wCFD3], a
    ld a, b
    and a, $FC
    rrca
    rrca
    ld [wCFD7], a
    inc a
    ld [wCFD2], a
    cp a, $02
    jr c, Jump_016_622B
    add a, $E0
    ld [wC322], a
    ld a, $C5
    ld [wC31F], a
    ld a, $BE
    ld [wC321], a
    ld a, $C6
    ld [wC323], a

Jump_016_622B::
    ld a, $04
    ld [wCFD0], a
    ld a, [wC471]
    ld [wCFD1], a
    ld a, [wCFD6]
    ld [wC46B], a
    call DrawFourListEntriesForPageWCFD1
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wC320, wJoypadPressed, wC46B, wCFD1
; writes: wCFD6, wC471, wBattleSubStep
; points at: wC46B, wC243, wBattleSubStep, wScreenTileBuffer
Func_016_5D13_Case17::
Jump_016_6250:: ; address name
    ld de, wC46B
    ld hl, Data_016_66EF
    call Func_016_65FF
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_016_6279
    call DrawFourListEntriesForPageWCFD1
    ld hl, vBGMap0 + $AB
    ld de, wC243
    ld bc, $0107
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wC320]
    ld hl, vBGMap0 + $188
    call WriteVRAMByte
    ret

Jump_016_6279::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_016_6291
    ld a, [wC46B]
    ld [wCFD6], a
    ld a, [wCFD1]
    ld [wC471], a
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
; reads: wCFD2, wCFD6
; writes: wC322, wC31F, wC321, wC323, wC46D, wCFD0, wCFD1, wCFD2, ...
; points at: wScreenTileBuffer, wBattleSubStep
Func_016_5D13_Case18::
Jump_016_62A9:: ; address name
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord78AAToScreenBuffer
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, [wCFD2]
    cp a, $02
    jr c, Jump_016_62D3
    add a, $E0
    ld [wC322], a
    ld a, $C5
    ld [wC31F], a
    ld a, $BE
    ld [wC321], a
    ld a, $C6
    ld [wC323], a

Jump_016_62D3::
    call DrawFourListEntriesForPageWCFD1
    ld a, [wCFD6]
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
    ld [wC46D], a
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    call ShowListedRecordNameMessage
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC471, wCFD6
; writes: rRAMG, rRAMB, wStringIndex, wBattleSubStep
; points at: wC46D, wBattleSubStep, wD789, wC140
Func_016_5D13_Case19::
Jump_016_631B:: ; address name
    ld hl, Data_016_66EB
    ld de, wC46D
    call Func_016_65FF
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
    ld a, [wC471]
    add a, a
    add a, a
    ld b, a
    ld a, [wCFD6]
    add a, b
    ld hl, wD789
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
    ld de, wC140
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
; reads: wC46B, wC471
; writes: wD7AB, wD7AF, wD780, wD781, wD782
; points at: wScreenTileBuffer, wBattleSubPhase
Func_016_5D13_Case1A::
Jump_016_637E:: ; address name
    ld a, [wC46B]
    ld [wD7AB], a
    ld a, [wC471]
    ld [wD7AF], a
    farcall ClampRecordListPageCursor4
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0D
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wD782], a
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
; reads: wD7AB, wD7AF, wCFD7
; writes: wC46B, wCFD6, wC471, wCFD1, wC2C5, wC322, wC31F, wC321, ...
; points at: wScreenTileBuffer
Func_016_5D13_Case1B::
Jump_016_63B9:: ; address name
    farcall CopyRectRecord78AAToScreenBuffer
    ld a, [wD7AB]
    ld [wC46B], a
    ld [wCFD6], a
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
    ld a, [wD7AF]
    ld [wC471], a
    ld [wCFD1], a
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $BB
    ld [wC2C5], a
    ld a, [wCFD7]
    inc a
    cp a, $02
    jr c, Jump_016_640E
    add a, $E0
    ld [wC322], a
    ld a, $C5
    ld [wC31F], a
    ld a, $BE
    ld [wC321], a
    ld a, $C6
    ld [wC323], a

Jump_016_640E::
    call ListRecordsWithField6EToWD789
    call DrawFourListEntriesForPageWCFD1
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    call ShowListedRecordNameMessage
    ld a, $19
    ld [wBattleSubStep], a
    ret

; entry 28 of the `rst $00` table in Func_016_5D13
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC471, wCFD6
; writes: rRAMG, rRAMB, wD7F1, wD7F2, wBattleResolveStep, wBattleSubStep
; points at: wD789, wBattleSubPhase
Func_016_5D13_Case1C::
Jump_016_643D:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC471]
    add a, a
    add a, a
    ld b, a
    ld a, [wCFD6]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
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
; 2 call sites from 2 routines (e.g. Func_016_5D13_Case0B, Func_016_5D13_Case04)
; reads: wJoypadPressed
SetDEFlagOnBButton::
Func_016_6480:: ; address name
    call Func_016_65FF
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
; 3 call sites from 3 routines (e.g. Func_016_5D13_Case16, Func_016_5D13_Case0B, Func_016_5D13_Case00)
; reads: wC7C7
; writes: rRAMG, rRAMB, wC0A0, wC0A1
; points at: sA000
CountRecordsByField6E::
Func_016_6493:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC7C7]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sA000
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
    ld [wC0A0], a
    ld a, d
    ld [wC0A1], a
    xor a, a
    ld [rRAMG], a
    ret

; 2 call sites from 2 routines (e.g. Func_016_5D13_Case11, Func_016_5D13_Case0C)
; reads: wC6FD, wC0A0, wC7C7, wC470, wCFD2
; writes: rRAMG, rRAMB, wC0A0, wCFD3, wCFD2, wCFD0, wC1B8, wC1F8, ...
; points at: wD789, wC6FE, sA000
Func_016_64DC::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wC0A0], a
    ld de, wD789
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_016_64F3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wC0A0]
    inc a
    ld [wC0A0], a
    dec b
    jr nz, Jump_016_64F3
    ld a, [wC7C7]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sA000
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
    ld a, [wC0A0]
    inc a
    ld [wC0A0], a

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
    ld a, [wC0A0]
    dec a
    ld b, a
    ld a, $05
    call DivideBByA
    inc a
    ld [wCFD3], a
    ld a, b
    inc a
    ld [wCFD2], a
    ld a, $05
    ld [wCFD0], a
    ld a, [wC470]
    or a, a
    jr nz, Jump_016_657B
    ld a, $E1
    ld [wC1B8], a
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_016_6580
    ld a, $E2
    ld [wC1F8], a
    ld a, [wC6FD]
    cp a, $02
    jr z, Jump_016_6585
    ld a, $E3
    ld [wC238], a
    jr Jump_016_658A

Jump_016_657B::
    ld a, $B6
    ld [wC1B8], a

Jump_016_6580::
    ld a, $B6
    ld [wC1F8], a

Jump_016_6585::
    ld a, $B6
    ld [wC238], a

Jump_016_658A::
    ld a, [wCFD2]
    cp a, $02
    jr c, Jump_016_65B0
    ld a, $C5
    ld [wC2DA], a
    ld a, $BE
    ld [wC2DC], a
    ld a, $C6
    ld [wC2DE], a
    ld a, [wC470]
    add a, $E1
    ld [wC2DB], a
    ld a, [wCFD2]
    add a, $E0
    ld [wC2DD], a

Jump_016_65B0::
    ret

; fills wD789 ($1E bytes) with $FF, then lists the indexes of the first Data_016_75EB[wC7C7] SRAM records that have field $6E set (E-0127)
; 2 call sites from 2 routines (e.g. Func_016_5D13_Case1B, Func_016_5D13_Case16)
; reads: wC7C7
; writes: rRAMG, rRAMB
; points at: wD789, sA000
ListRecordsWithField6EToWD789::
Func_016_65B1:: ; address name
    ld hl, wD789
    ld bc, $001E
    ld a, $FF
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC7C7]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sA000
    ld de, wD789
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

; 8 call sites from 8 routines (e.g. Func_016_6C16_Case0C, Func_016_6C16_Case0A, Func_016_6C16_Case02, Func_016_5D13_Case19, ...)
; reads: wJoypadPressedRepeat, wCFD2, wCFD1, wCFD3, wCFD0, wFrameCounterLo
; writes: wFrameCounterLo, wCFD1
Func_016_65FF::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, Jump_016_662B
    call BlankTileAtTableEntryDE
    ld a, [de]
    sub a, $01
    jp nc, Jump_016_6691
    ld a, [wCFD2]
    cp a, $02
    jr c, Jump_016_661E
    ld b, a
    ld a, [wCFD1]
    inc a
    cp a, b
    jr nz, Jump_016_6625

Jump_016_661E::
    ld a, [wCFD3]
    dec a
    jp Jump_016_6691

Jump_016_6625::
    ld a, [wCFD0]
    dec a
    jr Jump_016_6691

Jump_016_662B::
    bit 7, a
    jr z, Jump_016_664E
    call BlankTileAtTableEntryDE
    ld a, [wCFD1]
    inc a
    ld b, a
    ld a, [wCFD2]
    cp a, b
    jr nz, Jump_016_6642
    ld a, [wCFD3]
    jr Jump_016_6645

Jump_016_6642::
    ld a, [wCFD0]

Jump_016_6645::
    ld b, a
    ld a, [de]
    inc a
    cp a, b
    jr c, Jump_016_6691
    xor a, a
    jr Jump_016_6691

Jump_016_664E::
    ld a, [wCFD2]
    cp a, $02
    jr c, Jump_016_6682
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, Jump_016_666D
    call BlankTileAtTableEntryDE
    ld a, [wCFD1]
    dec a
    cp a, $FF
    jr nz, Jump_016_669B
    ld a, [wCFD2]
    dec a
    jr Jump_016_669B

Jump_016_666D::
    bit 4, a
    jr z, Jump_016_6682
    call BlankTileAtTableEntryDE
    ld a, [wCFD2]
    ld b, a
    ld a, [wCFD1]
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
    ld [wCFD1], a
    ld b, a
    ld a, [wCFD2]
    dec a
    cp a, b
    jr nz, Jump_016_66B1
    ld a, [wCFD3]
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
; 4 call sites from 1 routine (e.g. Func_016_65FF)
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
; 2 call sites from 1 routine (e.g. Func_016_65FF)
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

Data_016_66DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B9, $C1, $F9, $C1, $39, $C2, $79, $C2, $B9, $C2

Data_016_66E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

Data_016_66EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $99, $6D, $99

Data_016_66EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98, $21, $99, $61, $99

Data_016_66F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $98, $61, $98, $A1, $98, $E1, $98, $21, $99

Data_016_6701:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $99, $6B, $99

; shows five record names of page wCFD1 at vTiles2 + $3B0 and the slot numbers ($E1-$E3) or marks ($B6) beside them (E-0128)
; 3 call sites from 3 routines (e.g. Func_016_5D13_Case11, Func_016_5D13_Case0D, Func_016_5D13_Case0C)
; reads: wC52D, wC52E, wC52F, wC530, wCFD1, wC6FD, wCFD2
; writes: wC52F, wC530, wC52D, wC52E
; points at: wD789
DrawRecordListPageWithNumbers::
Func_016_6705:: ; address name
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wCFD1]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld hl, wD789
    add_a_to_hl
    ld b, $05
    ld de, vTiles2 + $3B0
    call ShowRecordNamesListFromHL
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, [wCFD1]
    or a, a
    jr nz, Jump_016_677A
    ld a, $E1
    ld hl, vBGMap0 + $20
    call WriteVRAMByte
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_016_6782
    ld a, $E2
    ld hl, vBGMap0 + $60
    call WriteVRAMByte
    ld a, [wC6FD]
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
    ld a, [wCFD2]
    cp a, $02
    jr c, Jump_016_67A4
    ld a, [wCFD1]
    add a, $E1
    ld hl, vBGMap0 + $143
    call WriteVRAMByte

Jump_016_67A4::
    ret

; draws four values from wD868 at vTiles2 + $3B0 with size $0105 (Func_016_67E0), preserving the window settings (E-0121)
; 1 call site from 1 routine (e.g. CopyRect7923AndDrawWD868Values)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52F, wC530, wC52D, wC52E
; points at: wD868
DrawWD868ValuesAtTiles23B0::
Func_016_67A5:: ; address name
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, wD868
    ld b, $04
    ld de, vTiles2 + $3B0
    call ShowRecordNamesListFromHL
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ret

; for B record indexes at HL shows each record name (or an empty one for $FF) as string 5 of category 8 at successive window rows from DE (E-0127)
; 2 call sites from 2 routines (e.g. DrawWD868ValuesAtTiles23B0, DrawRecordListPageWithNumbers)
; writes: rRAMG, rRAMB, wStringCategory, wStringIndex, wC52D, wC52E
; points at: wC130
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
    ld de, wC130
    jr Jump_016_6810

Jump_016_6802::
    call SRAMRecordAddress
    ld b, $0A
    ld de, wC130

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
    ld [wC52D], a
    ld a, d
    ld [wC52E], a
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
; 4 call sites from 4 routines (e.g. Func_016_5D13_Case1B, Func_016_5D13_Case18, Func_016_5D13_Case17, Func_016_5D13_Case16)
; reads: wCFD1
; writes: wC52F, wC530, rRAMG, rRAMB, wD868, wC52D, wC52E
; points at: wD789
DrawFourListEntriesForPageWCFD1::
Func_016_682F:: ; address name
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wCFD1]
    add a, a
    add a, a
    ld hl, wD789
    add_a_to_hl
    ld a, $00
    ld [wD868], a
    call DrawFourListEntriesForPageWCFD1_Sub01
    inc hl
    ld a, $01
    ld [wD868], a
    call DrawFourListEntriesForPageWCFD1_Sub01
    inc hl
    ld a, $02
    ld [wD868], a
    call DrawFourListEntriesForPageWCFD1_Sub01
    inc hl
    ld a, $03
    ld [wD868], a
    call DrawFourListEntriesForPageWCFD1_Sub01
    xor a, a
    ld [rRAMG], a
    call DrawListPageDigitIfLong
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; only called from DrawFourListEntriesForPageWCFD1 (E-0047)
; 4 call sites from 1 routine (e.g. DrawFourListEntriesForPageWCFD1)
; reads: wD868
DrawFourListEntriesForPageWCFD1_Sub01::
Func_016_6891:: ; address name
    ld a, [hl]
    cp a, $FF
    jr z, Jump_016_68CB
    push hl
    call DrawFourListEntriesForPageWCFD1_Sub01_Sub01
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
    ld a, [wD868]
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
    call ShowStringBCAtTileRowWD868
    ld a, [wD868]
    ld hl, Data_016_690F
    add a, a
    add_a_to_hl
    deref_hl
    ld [hl], $C3
    pop hl
    ret

; only called from DrawFourListEntriesForPageWCFD1_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DrawFourListEntriesForPageWCFD1_Sub01)
; reads: wD868
; writes: wStringIndex, wStringCategory, wC52D, wC52E
DrawFourListEntriesForPageWCFD1_Sub01_Sub01::
Func_016_68E5:: ; address name
    ld c, $0B
    call SRAMRecordAddress
    ld c, [hl]
    inc hl
    ld a, [hl]
    add a, $02
    ld b, a

; wStringCategory = B, wStringIndex = C, string window destination = $9400 + 256 * wD868, then ShowString_Bank08 (E-0118)
; 1 call site from 1 routine (e.g. DrawFourListEntriesForPageWCFD1_Sub01)
; reads: wD868
; writes: wStringIndex, wStringCategory, wC52D, wC52E
ShowStringBCAtTileRowWD868::
Func_016_68F0:: ; address name
    ld a, c
    ld [wStringIndex], a
    ld a, b
    ld [wStringCategory], a
    ld a, [wD868]
    add a, $94
    ld h, a
    ld l, $00
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank08
    ret

Data_016_690F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $43, $C2, $83, $C2, $C3, $C2, $03, $C3

; when wD7A9 is 5 or more: wC320 = $E1 + wCFD1 (the page number tile) (E-0119)
; 1 call site from 1 routine (e.g. DrawFourListEntriesForPageWCFD1)
; reads: wD7A9, wCFD1
; writes: wC320
DrawListPageDigitIfLong::
Func_016_6917:: ; address name
    ld a, [wD7A9]
    cp a, $05
    ret c
    ld a, [wCFD1]
    add a, $E1
    ld [wC320], a
    ret

; removes the $FF entry from the party list wC6FE, wC6FD -= 1, wD88F = new count, and terminates the list with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wC6FD, wD88F
; points at: wC6FE, wC0A0
RemovePartyMemberMarkedFF:: ; heuristic: follows a terminator; C0
Func_016_6926:: ; address name
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, wC0A0

Jump_016_6930::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_6937
    ld [de], a
    inc de

Jump_016_6937::
    dec b
    jr nz, Jump_016_6930
    ld a, [wC6FD]
    dec a
    ld [wC6FD], a
    ld [wD88F], a
    ld b, a
    ld hl, wC0A0
    ld de, wC6FE

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
; 16 call sites from 14 routines (e.g. ShowRecordNameString1D, Func_016_6C16_Case0C, Func_016_6C16_Case05, Func_016_6C16_Case03, ...)
; writes: wStringCategory
ShowStringCategory5_Bank16::
Func_016_6955:: ; address name
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; wStringCategory = 5 (wStringIndex set by the caller), then far-calls ShowString_Bank2F (E-0074)
; 9 call sites from 9 routines (e.g. Func_016_6C16_Case13, Func_016_6C16_Case11, Func_016_6C16_Case10, Func_016_6C16_Case08, ...)
; writes: wStringCategory
ShowStringCategory5Immediate_Bank16::
Func_016_6961:: ; address name
    ld a, $05
    ld [wStringCategory], a
    farcall ShowString_Bank2F
    ret

; copies the name of record wD789[5 * wC470 + wC46B] to wC140 and shows string $12 of category 5 (E-0125)
; 2 call sites from 2 routines (e.g. Func_016_5D13_Case11, Func_016_5D13_Case0D)
; reads: wC470, wC46B
; writes: rRAMG, rRAMB, wStringIndex
; points at: wD789, wC140
ShowRecordNameString12::
Func_016_696D:: ; address name
    ld a, [wC470]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wC46B]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld b, $0A
    ld de, wC140

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
; 2 call sites from 2 routines (e.g. Func_016_5D13_Case1B, Func_016_5D13_Case18)
; reads: wC471, wCFD6
; writes: rRAMG, rRAMB, wStringIndex
; points at: wD789, wC140
ShowListedRecordNameMessage::
Func_016_69AB:: ; address name
    ld a, [wC471]
    add a, a
    add a, a
    ld b, a
    ld a, [wCFD6]
    add a, b
    ld hl, wD789
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
    ld de, wC140
    call CopyStringHLToDE
    ld a, $17
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ret

; copies the name of record wD868[wC46C] to wC130 and shows string $1D of category 5 (E-0124)
; 2 call sites from 2 routines (e.g. Func_016_6C16_Case0F, Func_016_6C16_Case0B)
; reads: wC46C
; writes: rRAMG, rRAMB, wStringIndex
; points at: wD868, wC130
ShowRecordNameString1D::
Func_016_69E2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC46C]
    ld hl, wD868
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wC130
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
; 3 call sites from 3 routines (e.g. RunBattleSubStep_6A4E_Case00, Func_016_5D13_Case04, Func_016_5D13_Case00)
; reads: wDAAB
; points at: wD8AF
CopyBattleMonsterNameWithLetterSuffix::
Func_016_6A10:: ; address name
    push de
    call CopyMonsterNameOfWDAABSlotToDE
    ld a, [wDAAB]
    ld hl, wD8AF
    add_a_to_hl
    ld a, [hl]
    and a, $01
    add a, $A7
    ld d, a
    ld a, [wDAAB]
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
; reads: wDAAB
; points at: wBattleMonsterId
CopyMonsterNameOfWDAABSlotToDE::
Func_016_6A36:: ; address name
    ld a, [wDAAB]
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
RunBattleSubStep_6A4E::
Func_016_6A4E:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw RunBattleSubStep_6A4E_Case00
    dw RunBattleSubStep_6A4E_Case01
    dw RunBattleSubStep_6A4E_Case02
    dw RunBattleSubStep_6A4E_Case03
    dw RunBattleSubStep_6A4E_Case04

; entry 0 of the `rst $00` table in RunBattleSubStep_6A4E
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex
; points at: wC130, wBattleSubStep
RunBattleSubStep_6A4E_Case00::
Jump_016_6A5C:: ; address name
    ld de, wC130
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, $14
    ld [wStringIndex], a
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSubStep_6A4E
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wDAAB
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wSpeciesIdLo, wD7F5, wSpeciesIdHi, wC52D, ...
; points at: wCFA8, wD8AF, wC986, wScreenTileBuffer, wBattleSubStep
RunBattleSubStep_6A4E_Case01::
Jump_016_6A6F:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wCFA8
    ld bc, $001D
    xor a, a
    call FillBytes
    ld a, $01
    ld [wD7F1], a
    ld a, [wDAAB]
    ld hl, wD8AF
    add_a_to_hl
    ld a, [hl]
    ld [wD7F2], a
    ld a, [wDAAB]
    ld hl, wC986
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [wD7F3], a
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [wD7F4], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wD7F5], a
    ld [wSpeciesIdHi], a
    call SetSpeciesFlag
    ld a, $C3
    ld hl, wScreenTileBuffer
    ld bc, $02D0
    call FillBytes
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSubStep_6A4E
; no direct call (reached through a table, a jump or a vector)
; reads: wDAAB, wD7F5
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5
; points at: wD8AF, wC986, wCFCF, wD09E, wC8CF, wBattleSubStep
RunBattleSubStep_6A4E_Case02::
Jump_016_6AE3:: ; address name
    ld a, $01
    ld [wD7F1], a
    ld a, [wDAAB]
    ld hl, wD8AF
    add_a_to_hl
    ld a, [hl]
    ld [wD7F2], a
    ld a, [wDAAB]
    ld hl, wC986
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [wD7F3], a
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [wD7F4], a
    ld a, [hl]
    ld [wD7F5], a
    farcall RunWCFA8StateWhenNotFading
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToVRAM
    ld hl, wCFCF
    inc [hl]
    ld hl, wD09E
    ld de, wC8CF
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

; entry 3 of the `rst $00` table in RunBattleSubStep_6A4E
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
RunBattleSubStep_6A4E_Case03::
Jump_016_6B52:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleSubStep_6A4E
; no direct call (reached through a table, a jump or a vector)
; reads: wC7C7, wC6FD
; writes: rRAMG, rRAMB, wBattleSubStep, wD09D
; points at: sA000, wBattleSubPhase, wD09E, wC991
RunBattleSubStep_6A4E_Case04::
Jump_016_6B57:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC7C7]
    ld hl, Data_016_75EB
    add_a_to_hl
    ld b, [hl]
    ld hl, sA000
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
    ld [wD09D], a
    ld [hl], $01
    inc hl
    ld b, $0A
    ld de, wD09E
    call CopyBBytesDEToHL_Bank16
    ld de, wC991
    ld b, $9A
    call CopyBBytesDEToHL_Bank16
    ld a, $00
    ld c, $55
    call SRAMRecordAddressMapped
    ld c, $00
    call InitSlotFromRecordFlags
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_016_6BCC
    ld a, $01
    ld c, $55
    call SRAMRecordAddressMapped
    ld c, $01
    call InitSlotFromRecordFlags
    ld a, [wC6FD]
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
; 2 call sites from 1 routine (e.g. RunBattleSubStep_6A4E_Case04)
CopyBBytesDEToHL_Bank16::
Func_016_6BD9:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank16
    ret

; HL = a record flag byte, C = battle slot: unless bit 7 is set, marks the slot present (wBattleSlotOut = 0), clears its status byte 0 and sets status bit 0 when flag bit 2 is set and status bit 5 when flag bit 0 is set (E-0118)
; 3 call sites from 1 routine (e.g. RunBattleSubStep_6A4E_Case04)
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
    dw Func_016_6C16_Case00
    dw Func_016_6C16_Case01
    dw Func_016_6C16_Case02
    dw Func_016_6C16_Case03
    dw Func_016_6C16_Case04
    dw Func_016_6C16_Case05
    dw Func_016_6C16_Case06
    dw Func_016_6C16_Case07
    dw Func_016_6C16_Case08
    dw Func_016_6C16_Case09
    dw Func_016_6C16_Case0A
    dw Func_016_6C16_Case0B
    dw Func_016_6C16_Case0C
    dw Func_016_6C16_Case0D
    dw Func_016_6C16_Case0E
    dw Func_016_6C16_Case0F
    dw Func_016_6C16_Case10
    dw Func_016_6C16_Case11
    dw Func_016_6C16_Case12
    dw Func_016_6C16_Case13

; entry 0 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wD09D, wD88F
; writes: rRAMG, rRAMB, wStringIndex, wC46B
; points at: wScreenTileBuffer, wD868, wC6FE, wC130, wBattleSubStep
Func_016_6C16_Case00::
Jump_016_6C42:: ; address name
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wD09D]
    push af
    ld a, [wD88F]
    ld b, a
    ld hl, wD868
    ld de, wC6FE

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
    ld de, wC130

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
    ld [wC46B], a
    ret

; entry 1 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wCFD0, wCFD1, wCFD2, wCFD3
; points at: wC2A6, wBattleSubStep
Func_016_6C16_Case01::
Jump_016_6C9E:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, vBGMap0 + $10E
    ld de, wC2A6
    ld bc, $0605
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46B
; writes: wBattleSubStep
; points at: wC46B, wBattleSubStep
Func_016_6C16_Case02::
Jump_016_6CC8:: ; address name
    ld hl, Data_016_66E7
    ld de, wC46B
    call Func_016_65FF
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_016_6CEA
    ld a, $6C
    call QueueSoundEffect
    ld a, [wC46B]
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
Func_016_6C16_Case03::
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
Func_016_6C16_Case04::
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
; reads: wC6FD
; writes: wBattleSubStep, wStringIndex
; points at: wBattleSubStep
Func_016_6C16_Case05::
Jump_016_6D1E:: ; address name
    ld a, [wC6FD]
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
; reads: wC52B, wC6FD
; writes: wD88F
; points at: wD868, wC6FD, wC6FE, wBattleSubStep
Func_016_6C16_Case06::
Jump_016_6D47:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC6FD]
    ld hl, wD868
    add_a_to_hl
    ld b, [hl]
    ld hl, wC6FD
    inc [hl]
    ld a, [hl]
    ld [wD88F], a
    dec a
    ld hl, wC6FE
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
Func_016_6C16_Case07::
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
; writes: wStringIndex, wC46C
; points at: wC2C7, wBattleSubStep
Func_016_6C16_Case08::
Jump_016_6D8D:: ; address name
    call CopyRect7923AndDrawWD868Values
    ld a, $1C
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    xor a, a
    ld [wC46C], a
    ld hl, wC2C7
    ld [hl], $BC
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC46C
; writes: wCFD0, wCFD1, wCFD2, wCFD3
; points at: wScreenTileBuffer, wBattleSubStep
Func_016_6C16_Case09::
Jump_016_6DA6:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $04
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $04
    ld [wCFD3], a
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $140D
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wC46C]
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
; reads: wJoypadPressed, wD88F
; writes: rRAMG, rRAMB, wBattleSubStep
; points at: wC46C, wD868, wC130, wBattleSubStep
Func_016_6C16_Case0A::
Jump_016_6DE4:: ; address name
    ld hl, Data_016_66F7
    ld de, wC46C
    call Func_016_65FF
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_016_6E22
    ld a, [wD88F]
    ld hl, wD868
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld b, $0A
    ld de, wC130

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
; reads: wC46C
; writes: wC46D, wCFD0, wCFD1, wCFD2, wCFD3
; points at: wC2A4, wBattleSubStep
Func_016_6C16_Case0B::
Jump_016_6E38:: ; address name
    xor a, a
    ld [wC46D], a
    ld hl, vBGMap0 + $10C
    ld de, wC2A4
    ld bc, $0805
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wCFD0], a
    ld a, $00
    ld [wCFD1], a
    ld a, $01
    ld [wCFD2], a
    ld a, $02
    ld [wCFD3], a
    ld hl, Data_016_66F7
    ld a, [wC46C]
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
; reads: wJoypadPressed, wC46D, wC46C
; writes: rRAMG, rRAMB, wStringIndex, wBattleSubStep
; points at: wC46D, wBattleSubStep, wD868, wC130
Func_016_6C16_Case0C::
Jump_016_6E80:: ; address name
    ld hl, Data_016_66EB
    ld de, wC46D
    call Func_016_65FF
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_016_6ED4
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
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
    ld a, [wC46C]
    ld hl, wD868
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wC130
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
; reads: wD88F, wC46C
; writes: wD7A9, wD7AB, wD7AF, wD780, wD781, wD782
; points at: wD789, wD868, wBattleSubStep
Func_016_6C16_Case0D::
Jump_016_6EE9:: ; address name
    ld hl, wD789
    ld bc, $001E
    xor a, a
    call FillBytes
    ld a, [wD88F]
    inc a
    ld [wD7A9], a
    ld b, a
    ld de, wD868
    ld hl, wD789

Jump_016_6F01::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_016_6F01
    ld a, [wC46C]
    ld [wD7AB], a
    ld a, $00
    ld [wD7AF], a
    farcall ClampRecordListPageCursor5
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0E
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD7BC, wD7BA, wD7BB
; writes: hFFB9, hFFBA, hFF8D, wSpriteSlotCount
; points at: wCFCF, wBattleSubStep
Func_016_6C16_Case0E::
Jump_016_6F30:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    ld a, [wD7BC]
    ldh [hFFB9], a
    ld a, $80
    ldh [hFFBA], a
    ld a, [wD7BA]
    ldh [hFF8D], a
    ld a, [wD7BB]
    ld [wSpriteSlotCount], a
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToVRAM
    ld hl, wCFCF
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB
; writes: wC46C, wBattleSubStep
; points at: wScreenTileBuffer
Func_016_6C16_Case0F::
Jump_016_6F6F:: ; address name
    call BuildBattleMenuScreen_733F
    call CopyRect7923AndDrawWD868Values
    ld a, [wD7AB]
    ld [wC46C], a
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
; writes: wC2A4, wC2C4, wC2E4, wC304, wC324, wC2A5, wC2C5, wC2E5, ...
; points at: wC2A4
Func_016_6C16_Case10::
Jump_016_6FA4:: ; address name
    ld a, $1F
    ld [wC2A4], a
    ld a, $25
    ld [wC2C4], a
    ld a, $2B
    ld [wC2E4], a
    ld a, $31
    ld [wC304], a
    ld a, $37
    ld [wC324], a
    ld a, $C3
    ld [wC2A5], a
    ld [wC2C5], a
    ld [wC2E5], a
    ld [wC305], a
    ld [wC325], a
    farcall LoadCursorTileAndRect7826
    ld hl, vBGMap0 + $10C
    ld hl, wC2A4
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
; writes: wC46D, wStringIndex, wBattleSubStep
; points at: wC2C7
Func_016_6C16_Case11::
Jump_016_6FEE:: ; address name
    call CopyRect7923AndDrawWD868Values
    ld hl, wC2C7
    ld [hl], $BC
    xor a, a
    ld [wC46D], a
    ld a, $1C
    ld [wStringIndex], a
    call ShowStringCategory5Immediate_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

; entry 18 of the `rst $00` table in Func_016_6C16
; no direct call (reached through a table, a jump or a vector)
; reads: wC46C, wD88F
; writes: wBattleSubStep
; points at: wD868, wC6FE, wScreenTileBuffer
Func_016_6C16_Case12::
Jump_016_7008:: ; address name
    ld a, [wC46C]
    ld hl, wD868
    add_a_to_hl
    ld a, [hl]
    call RestoreRecordAFully
    ld [hl], $FF
    ld hl, wD868
    ld de, wC6FE
    ld a, [wD88F]
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
; writes: wStringIndex, wBattleSubStep, wC46B
; points at: wScreenTileBuffer
Func_016_6C16_Case13::
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
    ld [wC46B], a
    ret

; copies rectangle record $7923 to the screen buffer and draws the wD868 values at vTiles2 + $3B0 (E-0122)
; 3 call sites from 3 routines (e.g. Func_016_6C16_Case11, Func_016_6C16_Case0F, Func_016_6C16_Case08)
CopyRect7923AndDrawWD868Values::
Func_016_7078:: ; address name
    farcall CopyRectRecord7923ToScreenBuffer
    call DrawWD868ValuesAtTiles23B0
    ret

; for record A: field 0 = 1, field $55 = 0, HP (field $5B) = max HP ($5D), MP ($5F) = max MP ($61) (E-0127)
; 1 call site from 1 routine (e.g. Func_016_6C16_Case12)
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
; 1 call site from 1 routine (e.g. Func_016_6C16_Case06)
; writes: rRAMG, rRAMB
SetRecordState2ForB::
Func_016_70C5:: ; address name
    ld a, b

; A = record: sets its byte 0 (state) to 2 in SRAM bank 0 (SRAMRecordAddress with C = 0) (E-0118)
; 1 call site from 1 routine (e.g. Func_016_6C16_Case12)
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
; 3 call sites from 3 routines (e.g. Func_016_6C16_Case12, Func_016_6C16_Case06, Func_016_5D13_Case15)
; reads: wC6FE, wC6FD, wC6FF, wC700
; writes: rRAMG, rRAMB
RunFunc710FForPartyMembers::
Func_016_70DB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld c, $00
    ld a, [wC6FE]
    call RunFunc710FForPartyMembers_Sub01
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_016_710A
    ld c, $01
    ld a, [wC6FF]
    call RunFunc710FForPartyMembers_Sub01
    ld a, [wC6FD]
    cp a, $02
    jr z, Jump_016_710A
    ld c, $02
    ld a, [wC700]
    call RunFunc710FForPartyMembers_Sub01

Jump_016_710A::
    xor a, a
    ld [rRAMG], a
    ret

; only called from RunFunc710FForPartyMembers (E-0047)
; 3 call sites from 1 routine (e.g. RunFunc710FForPartyMembers)
; points at: wD8B7, wBattleHP, wBattleMP, wBattleSlotOut, wBattleStatus
RunFunc710FForPartyMembers_Sub01::
Func_016_710F:: ; address name
    push bc
    ld c, $56
    call SRAMRecordAddress
    pop bc
    ld a, c
    ld de, wD8B7
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
; 2 call sites from 2 routines (e.g. Func_016_6C16_Case05, Func_016_6C16_Case03)
; reads: wDAAB
; points at: wBattleMonsterId
BattleMonsterTable71ACAtLeast6::
Func_016_7188:: ; address name
    ld a, [wDAAB]
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
    INCBIN "dwm2-cobi-us.gbc", $05B1AC, $175

; B = width, C = rows, DE = source with rows 32 bytes apart, HL = VRAM address with rows 32 bytes apart: copies a B x C rectangle with WriteVRAMByteInc; DE and HL end at the start of the row below; B kept, C = 0 (E-0066)
; 21 call sites from 20 routines (e.g. Func_016_6C16_Case13, Func_016_6C16_Case12, Func_016_6C16_Case10, Func_016_6C16_Case0F, ...)
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
; 11 call sites from 11 routines (e.g. Func_016_6C16_Case13, Func_016_6C16_Case12, Func_016_6C16_Case0F, Func_016_6C16_Case0C, ...)
BuildBattleMenuScreen_733F::
Func_016_733F:: ; address name
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForWD88F_Bank31
    farcall DrawPartySlotStatusPanels
    farcall LayoutTileBlocksForWD890Count
    farcall LoadBattleMonsterPictureAttributes
    farcall CopyRectRecord7345ToScreenBuffer
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wCFC5, wC9DC, wC991, wC992, wD00E, wC9E3, wC9E4, wC9E7, ...
; writes: wC9DC, wSpeciesIdLo, wSpeciesIdHi, wC9DD, wC9E3, wC9E4, wC9E1, wC9E2, ...
; points at: wD09D
BattleEnd_Step3_Sub01::
Func_016_7364:: ; address name
    ld a, [wCFC5]
    cp a, $02
    jr nz, Jump_016_736F
    ld c, $00
    jr Jump_016_7382

Jump_016_736F::
    call NextTableByte
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, $05
    call DivideHLByA
    sub a, $02
    ld c, a

Jump_016_7382::
    ld a, [wC9DC]
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
    ld [wC9DC], a
    ld a, [wC991]
    ld l, a
    ld a, [wC992]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD00E]
    ld c, a
    ld a, [wC9DC]
    cp a, c
    jr c, Jump_016_73BB
    ld c, a

Jump_016_73BB::
    ld a, c
    ld [wC9DD], a
    ld a, [wCFC5]
    cp a, $02
    jp z, Jump_016_7456
    ld a, [wC9E3]
    ld c, a
    ld a, [wC9E4]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub03
    ld a, l
    ld [wC9E3], a
    ld a, h
    ld [wC9E4], a
    ld a, l
    ld [wC9E1], a
    ld a, h
    ld [wC9E2], a
    ld a, [wC9E7]
    ld c, a
    ld a, [wC9E8]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wC9E7], a
    ld a, h
    ld [wC9E8], a
    ld a, l
    ld [wC9E5], a
    ld a, h
    ld [wC9E6], a
    ld a, [wC9E9]
    ld c, a
    ld a, [wC9EA]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wC9E9], a
    ld a, h
    ld [wC9EA], a
    ld a, [wC9EB]
    ld c, a
    ld a, [wC9EC]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wC9EB], a
    ld a, h
    ld [wC9EC], a
    ld a, [wC9ED]
    ld c, a
    ld a, [wC9EE]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wC9ED], a
    ld a, h
    ld [wC9EE], a
    ld a, [wC9EF]
    ld c, a
    ld a, [wC9F0]
    ld b, a
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wC9EF], a
    ld a, h
    ld [wC9F0], a
    ld a, [wC9F7]
    ld c, a
    ld b, $00
    call BattleEnd_Step3_Sub01_Sub02
    ld a, l
    ld [wC9F7], a

Jump_016_7456::
    call BattleEnd_Step3_Sub01_Sub01
    ld hl, wD09D
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
    ld a, [wC9DC]
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
    ld [wC9F1], a
    ld a, h
    ld [wC9F2], a
    ret

; only called from BattleEnd_Step3_Sub01 (E-0047)
; 6 call sites from 1 routine (e.g. BattleEnd_Step3_Sub01)
; reads: wC5E7, wC5E8, wD87F, wD87D, wD87E
; writes: wD87D, wD87E, wD87F, wD880
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
    ld [wD87D], a
    ld a, b
    ld [wD87E], a
    ld a, $14
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, l
    ld [wD87F], a
    ld a, h
    ld [wD880], a
    call NextTableByte
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, [wD87F]
    or a, a
    call nz, DivideHLByA
    ld c, a
    ld a, [wD87D]
    sub a, c
    ld l, a
    ld a, [wD87E]
    sbc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub01)
; reads: wC5E7, wC5E8, wD87F, wD87D, wD87E
; writes: wD87D, wD87E, wD87F, wD880
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
    ld [wD87D], a
    ld a, b
    ld [wD87E], a
    ld a, $14
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, l
    ld [wD87F], a
    ld a, h
    ld [wD880], a
    call NextTableByte
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, [wD87F]
    or a, a
    call nz, DivideHLByA
    ld c, a
    ld a, [wD87D]
    sub a, c
    ld l, a
    ld a, [wD87E]
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
; writes: wC52F, wC530, wC52D, wC52E, wStringCategory, wStringIndex
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
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, vTiles1 + $6D0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1 + $750
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, $07
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1 + $7D0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, $08
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Data_016_75EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

; checks the save; when valid, loads the player name, play time, party summaries and other title-screen details from SRAM bank 1 into wD0D5 onward (E-0129)
; 1 call site from 1 routine (e.g. Func_016_7783)
; reads: hFFC6, sBC00, sBC01, sBC02, sBC03, sBD3A, sBE0D, sBB07, ...
; writes: wBattlerRecords, rRAMG, rRAMB, wD0E5, wD09D, wD09E, wD09F, wD10A, ...
; points at: wBattlerRecords, sBB0F, wD0D6, sBD30, wD0E0, wD0E6, wD0F2, wD0FE, ...
LoadSaveFileSummary::
Func_016_75EE:: ; address name
    ld hl, wBattlerRecords
    ld bc, $003C
    xor a, a
    call FillBytes
    farcall CheckSaveData
    ldh a, [hFFC6]
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
    ld hl, sBB0F
    ld de, wD0D6
    ld b, $0A
    call CopyBytesDEFromHL_Bank16
    ld hl, sBD30
    ld de, wD0E0
    ld b, $05
    call CopyBytesDEFromHL_Bank16
    ld a, [sBC00]
    ld [wD0E5], a
    push af
    ld a, [sBC01]
    ld [wD09D], a
    ld de, wD0E6
    ld a, e
    ld [wD09E], a
    ld a, d
    ld [wD09F], a
    call BuildRecordSummaryForWD09D
    pop af
    cp a, $01
    jr z, Jump_016_767E
    push af
    ld a, [sBC02]
    ld [wD09D], a
    ld de, wD0F2
    ld a, e
    ld [wD09E], a
    ld a, d
    ld [wD09F], a
    call BuildRecordSummaryForWD09D
    pop af
    cp a, $02
    jr z, Jump_016_767E
    ld a, [sBC03]
    ld [wD09D], a
    ld de, wD0FE
    ld a, e
    ld [wD09E], a
    ld a, d
    ld [wD09F], a
    call BuildRecordSummaryForWD09D

Jump_016_767E::
    ld a, [sBD3A]
    ld [wD10A], a
    ld a, [sBE0D]
    ld [wD10B], a
    ld a, [sBB07]
    ld [wD10C], a
    ld a, [sBD36]
    ld hl, sBC0A
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wD10D], a
    ld a, [hl+]
    ld [wD10E], a
    ld a, [hl+]
    ld [wD10F], a
    ld a, [hl]
    ld [wD110], a
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
; reads: wD09D, wD09E, wD09F, wD0A0, wD0A1
; writes: wD0A0, wD0A1
BuildRecordSummaryForWD09D::
Func_016_76BD:: ; address name
    ld a, [wD09D]
    ld c, $6F
    call Multiply8
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [wD0A0], a
    ld a, h
    ld [wD0A1], a
    ld a, [wD09E]
    ld e, a
    ld a, [wD09F]
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
    ld a, [wD0A0]
    add a, $03
    ld l, a
    ld a, [wD0A1]
    adc a, $00
    ld h, a
    call BuildRecordSummaryForWD09D_Sub01
    ld a, [wD0A0]
    add a, $62
    ld l, a
    ld a, [wD0A1]
    adc a, $00
    ld h, a
    ld a, [wD09E]
    add a, $0B
    ld e, a
    ld a, [wD09F]
    adc a, $00
    ld d, a
    ld a, [hl]
    and a, $7F
    ld [de], a
    ret

; only called from BuildRecordSummaryForWD09D (E-0047)
; 1 call site from 1 routine (e.g. BuildRecordSummaryForWD09D)
BuildRecordSummaryForWD09D_Sub01::
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
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case06_Case00_Sub01, RunWD06BSubState_60E9_Case02_Case00_Case00)
; reads: wBattlerRecords, wGameMode, wD0E3, wD0E4, wD0E2, wD0E5
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
; points at: wC1D9, wC219, wC25C, wC29C, wD0D6, wC1E5, wC225, wC1E9, ...
DecompressA4GraphicsAndContinue::
Func_016_777B:: ; address name
    farcall DecompressGraphicsA4ToTiles0
    jr Jump_016_77A6

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattlerRecords, wGameMode, wD0E3, wD0E4, wD0E2, wD0E5
; writes: wC527, wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
; points at: wOBJPaletteBuffer, wC1D9, wC219, wC25C, wC29C, wD0D6, wC1E5, wC225, ...
Func_016_7783:: ; heuristic: follows a terminator; C0
    ld b, $7E
    ld de, Data_07E_5B63
    ld hl, vTiles0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_016_77A6
    ld de, Data_07E_5BB8
    ld b, $7E
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a

Jump_016_77A6::
    call LoadSaveFileSummary
    ld a, [wBattlerRecords]
    or a, a
    jp nz, Jump_016_7832
    ld hl, wC1D9
    ld bc, $1104
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_77C0
    ld hl, wC219

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
    ld hl, wC25C
    ld b, $0E
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_77E4
    ld hl, wC29C
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0E01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0A
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Jump_016_7832::
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld hl, wD0D6
    ld de, vTiles2 + $200
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_7857
    ld de, vTiles2 + $400

Jump_016_7857::
    call ShowTenByteNameAtDE
    ld a, [wD0E3]
    ld l, a
    ld a, [wD0E4]
    ld h, a
    call HLToDecimalDigits
    ld de, wC1E5
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_7872
    ld de, wC225

Jump_016_7872::
    call WriteThreeDigitTilesWC8C0_Bank16
    ld a, [wD0E2]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wC1E9
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_788B
    ld de, wC229

Jump_016_788B::
    call WriteTwoDigitTilesWC8C1NoBlank_Bank16
    ld a, [wD0E5]
    ld b, a
    ld c, $00
    ld hl, wD0E6
    call DrawSaveSummaryPartyEntryC
    ld c, $01
    ld hl, wD0F2
    call DrawSaveSummaryPartyEntryC
    ld c, $02
    ld hl, wD0FE
    call DrawSaveSummaryPartyEntryC
    call BlankTwoTileCellByGameMode
    call ShowKeyNameOrStringForWD10B
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; writes wC8C0 as a digit tile at DE and falls into WriteTwoDigitTilesWC8C1NoBlank_Bank16 (E-0126)
; 1 call site from 1 routine (e.g. Func_016_7783)
; points at: wC8C0, wC8C1
WriteThreeDigitTilesWC8C0_Bank16::
Func_016_78C7:: ; address name
    ld hl, wC8C0
    ld a, [hl]
    add a, $E0
    ld [de], a
    inc de

; writes wC8C1 and wC8C2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank) (E-0117) (the same 13 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. Func_016_7783, DrawSaveSummaryPartyEntryC)
; points at: wC8C1
WriteTwoDigitTilesWC8C1NoBlank_Bank16::
Func_016_78CF:: ; address name
    ld hl, wC8C1
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    ret

; window at DE: copies 10 bytes from HL to wC130 with a $F0 terminator and shows it (ShowString_Bank08) (E-0122)
; 2 call sites from 2 routines (e.g. Func_016_7783, DrawSaveSummaryPartyEntryC)
; writes: wC52D, wC52E
; points at: wC130
ShowTenByteNameAtDE::
Func_016_78DC:: ; address name
    ld a, e
    ld [wC52D], a
    ld a, d
    ld [wC52E], a
    ld de, wC130
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
; 3 call sites from 1 routine (e.g. Func_016_7783)
; reads: wGameMode
; writes: wD09D, wD09E
; points at: hFFF7
DrawSaveSummaryPartyEntryC::
Func_016_78F9:: ; address name
    ld a, c
    cp a, b
    jr nc, Jump_016_7969
    push bc
    ld a, [hl+]
    ld [wD09D], a
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
    ld [wD09E], a
    push hl
    call LoadFamilyIconTileForWD09D
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
; 1 call site from 1 routine (e.g. Func_016_7783)
; reads: wGameMode
; writes: wC227, wC228, wC247, wC248, wC267, wC268, wC287, wC288
BlankTwoTileCellByGameMode::
Func_016_7990:: ; address name
    ld a, [wGameMode]
    cp a, $05
    jr z, Jump_016_79A6
    ld a, $C3
    ld [wC227], a
    ld [wC228], a
    ld [wC247], a
    ld [wC248], a
    ret

Jump_016_79A6::
    ld a, $C3
    ld [wC267], a
    ld [wC268], a
    ld [wC287], a
    ld [wC288], a
    ret

; window at vTiles2 + $3B0 (or + $5B0 in game mode 5): shows string wD10C + $0A, or builds a two-word key name from wD10E/wD10F (E-0127)
; 1 call site from 1 routine (e.g. Func_016_7783)
; reads: wGameMode, wD10B, wD10C, wD110, wD10E, wD10F, wD10D
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory
; points at: wC130
ShowKeyNameOrStringForWD10B::
Func_016_79B5:: ; address name
    ld hl, vTiles2 + $3B0
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_016_79C2
    ld hl, vTiles2 + $5B0

Jump_016_79C2::
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0D01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wD10B]
    bit 7, a
    jr nz, Jump_016_79EF
    ld a, [wD10C]
    add a, $0A
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_Bank08
    ret

Jump_016_79EF::
    ld a, [wD110]
    bit 7, a
    jr nz, Jump_016_7A22
    ld de, wC130
    ld a, [wD10E]
    inc a
    call CopyKeyNameWordToDE_Bank16
    dec de
    ld a, [wD10F]
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
; 2 call sites from 1 routine (e.g. ShowKeyNameOrStringForWD10B)
CopyKeyNameWordToDE_Bank16::
Func_016_7A1E:: ; address name
    call CopyKeyNameWordToDE
    ret

Jump_016_7A22::
    ld a, [wD10D]
    and a, $3F
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall ShowString_Bank09
    ret

Data_016_7A36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $25, $2B, $31

Data_016_7A39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $45, $4B, $51

Data_016_7A3C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $22, $C2, $62, $C2, $A2, $C2

Data_016_7A42:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $C2, $A2, $C2, $E2, $C2

; writes the 16-byte icon tile of family wD09D (Data_016_7ACD + 16 * family) to VRAM tile wD09E through Func_016_7AAF; corrected in E-0124, first named as a palette load (E-0122)
; 19 call sites from 19 routines (e.g. DrawSaveSummaryPartyEntryC, ShowSpeciesNameAndIconForSlotB, ScriptCommandF6_Run_Case10_Case04, ScriptCommandF6_Run_Case10_Case06_Sub02, ...)
; reads: wD09D
LoadFamilyIconTileForWD09D::
Func_016_7A48:: ; address name
    ld a, [wD09D]
    swap a
    ld de, Data_016_7ACD
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
    ld de, Data_016_7ACD
    ld b, $B0
    call WriteBytesToVRAMTileWD09E
    ret

; with SRAM enabled (bank 0), runs LoadTileForRecordByte0D for record list entries 0, 1 and 2 with H = $C7, $C8 and $C9, stopping after wC6FD entries; then disables SRAM (E-0103)
; 6 call sites from 6 routines (e.g. Func_002_66CC, Func_003_4208_Case00, PauseMenu_State3_Case00_Case00, ScriptCommandF6_Run_Case08, ...)
; reads: wC6FD
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
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_016_7A91
    ld a, $01
    ld h, $C8
    call LoadTileForRecordByte0D
    ld a, [wC6FD]
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
    ld de, Data_016_7ACD
    add a, e
    ld e, a
    jr nc, Jump_016_7AAA
    inc d

Jump_016_7AAA::
    ld b, $10
    pop af
    jr Jump_016_7AB2

; writes B bytes from DE to VRAM tile wD09E ($8000 + 16 * index; indices below $80 use the $9000 area) (E-0124)
; 2 call sites from 2 routines (e.g. LoadFamilyIconTileForWD09D, LoadAllFamilyIconTiles)
; reads: wD09E
WriteBytesToVRAMTileWD09E::
Func_016_7AAF:: ; address name
    ld a, [wD09E]

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

Data_016_7ACD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05BACD, $B0

; LZSS-compressed asset: 405 bytes expand to 624 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_016_7B7D:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $05BB7D, $1D7
    ds $2AC, $00
