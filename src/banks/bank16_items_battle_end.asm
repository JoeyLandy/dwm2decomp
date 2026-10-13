; ROM bank $16: item use (usable and apply routines) and the end of a battle
; The annotated listing of this bank is build/listing/bank16.asm.

SECTION "Bank 16", ROMX[$4000], BANK[$16]
    db $16, $f0, $c6, $cd, $92, $4a, $c9

; wItemId (wItemId) = item id: copies the 13-byte ItemTable record to wItemRecord (wItemRecord)
LoadItemRecord::
    ld de, wItemRecord
    push de
    ld a, [wItemId]
    ld c, $0d
    call Multiply8
    ld a, l
    add $c2
    ld l, a
    ld a, h
    adc $4c
    ld h, a
    pop de
    ld b, $0d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; returns when wItemId is $FF; otherwise jumps through a table with one usability check per item id
; (a check refuses by setting wItemId = $FF; ApplyItemEffect then performs the use, E-0089) (most
; entries are the shared ItemUsable_VITbelt; for example ItemUsable_Herb refuses use when the words
; at save-record offsets $5B and $5D, the monster's current and maximum HP, are equal)
CheckItemUsable::
    ld a, [wItemId]
    cp $ff
    ret z
    ld a, [wItemId]
    jumptable
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

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 0 (no name); item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Item00::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 1 Herb, 2 LoveWater; item names from StringTable_ItemNames; the body is not
; interpreted (E-0085)
ItemUsable_Herb::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 3 WorldDew, 11 SageRock; item names from StringTable_ItemNames; the body is not
; interpreted (E-0085)
ItemUsable_WorldDew::
    ld a, [wPartyCount]
    or a
    jr z, .set_item_id_to_FF
    ld a, $00
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, .check_party_count
    ld a, $00
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    jr nz, .call_item_usable_world_dew_sram_record

.check_party_count:
    ld a, [wPartyCount]
    cp $01
    jr z, .set_item_id_to_FF
    ld a, $01
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, .check_party_count2
    ld a, $01
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    jr nz, .call_item_usable_world_dew_sram_record

.check_party_count2:
    ld a, [wPartyCount]
    cp $02
    jr z, .set_item_id_to_FF
    ld a, $02
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, .set_item_id_to_FF
    ld a, $02
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    jr nz, .call_item_usable_world_dew_sram_record

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a
    ret

.call_item_usable_world_dew_sram_record:
    ld d, $00
    ld a, $00
    call ItemUsable_WorldDew_SRAMRecordAddressMapped
    ld a, $01
    call ItemUsable_WorldDew_SRAMRecordAddressMapped
    ld a, $02
    call ItemUsable_WorldDew_SRAMRecordAddressMapped
    ld a, $27
    add d
    ld [wItemRecordByte0A], a
    ret

ItemUsable_WorldDew_SRAMRecordAddressMapped::
    ld [wTargetRecord], a
    ld hl, wPartyCount
    cp [hl]
    ret nc
    push de
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [wTargetRecord]
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    pop de
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    ret z
    push de
    ld a, d
    swap a
    ld hl, wTextBuf3
    add_a_to_hl
    push hl
    ld a, [wTargetRecord]
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    pop hl
    call CopyFiveGlyphsPlusMarks
    pop de
    inc d
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 4 Potion, 5 ElfWater; item names from StringTable_ItemNames; the body is not
; interpreted (E-0085)
ItemUsable_Potion::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 6 Antidote; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Antidote::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 2, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 7 MoonHerb; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_MoonHerb::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 3, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 8 Laurel; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Laurel::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 0, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; when a party member without bit 7 of field $55 has bit 0 set, copies the eligible names to
; wTextBuf3 and wItemRecordByte0A = $32 + their count; otherwise wItemId = $FF (E-0127)
ListPartyMembersWithField55Bit0::
    ld a, [wPartyCount]
    and a
    jr z, .set_item_id_to_FF
    xor a
    call CheckRecordFlag55Bit7
    jr nz, .check_party_count
    xor a
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 0, [hl]
    jr nz, .call_copy_eligible_record_name_to_text_buf3

.check_party_count:
    ld a, [wPartyCount]
    cp $02
    jr c, .set_item_id_to_FF
    ld a, $01
    call CheckRecordFlag55Bit7
    jr nz, .check_party_count2
    ld a, $01
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 0, [hl]
    jr nz, .call_copy_eligible_record_name_to_text_buf3

.check_party_count2:
    ld a, [wPartyCount]
    cp $03
    jr c, .set_item_id_to_FF
    ld a, $02
    call CheckRecordFlag55Bit7
    jr nz, .set_item_id_to_FF
    ld a, $02
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 0, [hl]
    jr nz, .call_copy_eligible_record_name_to_text_buf3

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a
    ret

.call_copy_eligible_record_name_to_text_buf3:
    ld d, $00
    ld a, $00
    call CopyEligibleRecordNameToTextBuf3Row
    ld a, $01
    call CopyEligibleRecordNameToTextBuf3Row
    ld a, $02
    call CopyEligibleRecordNameToTextBuf3Row
    ld a, $32
    add d
    ld [wItemRecordByte0A], a
    ret

; if record A (< wPartyCount) has field $55 bit 7 clear and bit 0 set, copies its name and marks
; (field 1) to wTextBuf3 + 16 * D and increments D (E-0121)
CopyEligibleRecordNameToTextBuf3Row::
    ld [wTargetRecord], a
    ld hl, wPartyCount
    cp [hl]
    ret nc
    push de
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [wTargetRecord]
    ld c, MON_STATUS
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
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    pop hl
    call CopyFiveGlyphsPlusMarks
    pop de
    inc d
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 9 AwakeSand; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_AwakeSand::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 1, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 10 SkyBell; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_SkyBell::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 4, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 12 WorldLeaf; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_WorldLeaf::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 13 ATKseed; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_ATKseed::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_ATK
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, $03e7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 14 DEFseed; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_DEFseed::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_DEF
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, $03e7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 15 AGLseed; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_AGLseed::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_AGL
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, $03e7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 16 INTseed; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_INTseed::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_INT
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, $03e7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 17 LifeAcorn; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_LifeAcorn::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_MAX_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, $03e7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 18 MysticNut; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_MysticNut::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_MAX_MP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, $03e7
    call ShowRaiseAmountOrRefuse
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 19 Quest?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Quest::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_PERSONALITY
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp $ff
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 20 Horror?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Horror::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_PERSONALITY
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 21 BeNice?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_BeNice::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_PERSONALITY + 1
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp $ff
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 22 Cheater?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Cheater::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_PERSONALITY + 1
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 23 Smart?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Smart::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_PERSONALITY + 3
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp $ff
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 24 Comedy?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Comedy::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_PERSONALITY + 3
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 25 BeefJerky, 26 PorkChop, 27 Rib, 28 Sirloin, 29 BadMeat, 30 MeteOrb; item names
; from StringTable_ItemNames; the body is not interpreted (E-0085)
ItemUsable_BeefJerky::
    call CheckTargetRecordFlag55Bit7
    ret nz
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 31 BeastTail; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_BeastTail::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 32 Repellent, 33 ShinyHarp; item names from StringTable_ItemNames; the body is
; not interpreted (E-0085)
ItemUsable_Repellent::
    ld a, [wEncounterRate]
    and $7f
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 34 Mist?, 35 Friend?, 36 Wind?, 37 Bolt?, 38 Snow?, 39 Fire?, 43 Bookmark; item
; names from StringTable_ItemNames; the body is not interpreted (E-0085)
ItemUsable_Mist::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 40 Warp?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Warp::
    call ItemUsable_WarpWing
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 46 LogTwig; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_LogTwig::
    ld a, [wMapType]
    bit 7, a
    jr z, .check_map_id
    cp $80
    jr z, .call_item_usable_log_twig_write_temp_a_and
    ld a, $ff
    ld [wItemId], a
    ret

.check_map_id:
    ldh a, [hMapId]
    cp $20
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $30
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $48
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $70
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $a0
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $a8
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $b0
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $b8
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $c8
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $d1
    jr z, .call_item_usable_log_twig_write_temp_a_and
    cp $da
    jr z, .call_item_usable_log_twig_write_temp_a_and
    ld a, $ff
    ld [wItemId], a
    ret

.call_item_usable_log_twig_write_temp_a_and:
    farcall ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc
    ldh a, [hTempA]
    or a
    ret nz
    ld a, $fe
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 41 WarpWing, 54 TidalBell; item names from StringTable_ItemNames; the body is not
; interpreted (E-0085)
ItemUsable_WarpWing::
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    cp $80
    ret z
    ld a, $ff
    ld [wItemId], a
    ret

.read_map_id:
    ldh a, [hMapId]
    ld hl, MapItemUseFlags
    add_a_to_hl
    bit 6, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 42 ExitBell; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_ExitBell::
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    cp $81
    ret z
    cp $85
    ret z
    cp $86
    ret z
    ld a, $ff
    ld [wItemId], a
    ret

.read_map_id:
    ldh a, [hMapId]
    ld hl, MapItemUseFlags
    add_a_to_hl
    bit 5, [hl]
    ret nz
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 44 TinyMedal, 45 GoldPass; item names from StringTable_ItemNames; the body is not
; interpreted (E-0085)
ItemUsable_TinyMedal::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 47 (no name); item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Item2F::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 48 WaterCall; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_WaterCall::
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_item_id_to_FF
    ldh a, [hMapId]
    cp $2f
    jr nz, .set_item_id_to_FF
    ldh a, [hMapScreenX]
    cp $00
    jr nz, .set_item_id_to_FF
    ldh a, [hMapScreenY]
    cp $01
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerX]
    cp $40
    jr nz, .cp_50
    ldh a, [hPlayerY]
    cp $30
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerFacing]
    cp $01
    jr nz, .set_item_id_to_FF
    jr .call_test_flag_bit

.cp_50:
    cp $50
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerY]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerFacing]
    cp $02
    jr nz, .set_item_id_to_FF

.call_test_flag_bit:
    ld de, $0058
    call TestFlagBit
    jr c, .set_item_id_to_FF
    jr .return

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a

.return:
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 49 MoonRock; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_MoonRock::
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_item_id_to_FF
    ldh a, [hMapId]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hMapScreenX]
    ld b, a
    ldh a, [hMapScreenY]
    or b
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerY]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerFacing]
    cp $02
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerX]
    cp $40
    jr c, .set_item_id_to_FF
    cp $51
    jr nc, .set_item_id_to_FF
    ld de, $007a
    call TestFlagBit
    jr c, .set_item_id_to_FF
    jr .return

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a

.return:
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 50 Crest; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Crest::
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_item_id_to_FF
    ldh a, [hMapId]
    cp $49
    jr nz, .set_item_id_to_FF
    ldh a, [hMapScreenX]
    ld b, a
    ldh a, [hMapScreenY]
    or b
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerX]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerY]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerFacing]
    cp $02
    jr nz, .set_item_id_to_FF
    ld de, EVENT_SCENE_SHIELD_1E4
    call TestFlagBit
    jr nc, .set_item_id_to_FF
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .set_item_id_to_FF
    jr .return

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a

.return:
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 51 YunaSoul; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_YunaSoul::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 52 SleepHerb; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_SleepHerb::
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_item_id_to_FF
    ldh a, [hMapId]
    cp $61
    jr nz, .set_item_id_to_FF
    ldh a, [hMapScreenX]
    ld b, a
    ldh a, [hMapScreenY]
    or b
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerX]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerY]
    cp $40
    jr nz, .set_item_id_to_FF
    ldh a, [hPlayerFacing]
    cp $02
    jr nz, .set_item_id_to_FF
    ld de, EVENT_SCENE_SHIELD_GUARDIAN
    call TestFlagBit
    jr c, .set_item_id_to_FF
    jr .return

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a

.return:
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 53 Change?; item names from StringTable_ItemNames; the body is not interpreted
; (E-0085)
ItemUsable_Change::
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_item_id_to_FF
    ldh a, [hMapId]
    cp $70
    jr c, .set_item_id_to_FF
    cp $a0
    jr nc, .set_item_id_to_FF
    cp $76
    jr z, .set_item_id_to_FF
    cp $9b
    jr z, .set_item_id_to_FF
    cp $9a
    jr z, .set_item_id_to_FF
    cp $7a
    jr nz, .check_screen_saved_flag
    ldh a, [hMapScreenY]
    cp $01
    jr z, .set_item_id_to_FF

.check_screen_saved_flag:
    ld a, [wScreenSavedFlag]
    or a
    ret nz

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 55 HarMirror, 56 Sky?; item names from StringTable_ItemNames; the body is not
; interpreted (E-0085)
ItemUsable_HarMirror::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 57 Heaven?, 58 Heaven?, 59 Heaven?, 60 WizStone, 61 Pretty?; item names from
; StringTable_ItemNames; the body is not interpreted (E-0085)
ItemUsable_Heaven::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 62 Accessory, 63 Accessory; item names from StringTable_ItemNames; the body is
; not interpreted (E-0085)
ItemUsable_Accessory::
    ret

; usability check reached through CheckItemUsable (indexed by wItemId; refuses by setting wItemId =
; $FF) for item(s) 64 VITbelt, 65 DracoBelt, 66 MagicBelt, 67 OddBelt, 68 StoneFang, 69 SteelFang,
; 70 MermScale, 71 DrakScale, 72 AGL?, 73 Starry? ...; item names from StringTable_ItemNames; the
; body is not interpreted (E-0085)
ItemUsable_VITbelt::
    call CheckTargetRecordFlag55Bit7
    ret

; A = wTargetRecord, then CheckRecordFlag55Bit7 (E-0066)
CheckTargetRecordFlag55Bit7::
    ld a, [wTargetRecord]

; A = record (SRAMRecordAddressMapped, offset $55; SRAM must be enabled): returns Z set when bit 7
; of that byte is clear; when it is set, wItemId = $FF, A = $FF and Z is clear. What the bit means
; is not known (E-0066)
CheckRecordFlag55Bit7::
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret z
    ld a, $ff
    ld [wItemId], a
    or a
    ret

; C = 1 when the game refuses to save here: when wMapType bit 7 is set, while wEncounterRate & $7F
; is non-zero; otherwise when bit 4 of MapItemUseFlags + hMapId is clear (C2 for the map flag from
; E-0322: in the Desert world, map $20, whose flag byte $C0 has bit 4 clear, PLAN's Journal shows
; 'You can't save here.'; bit 4 is set for GreatLog's maps $00-$1F and the towns $21-$26; the
; wMapType case C1)
SaveForbiddenHere::
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    ld a, [wEncounterRate]
    and $7f
    jr nz, .done
    jr .skip

.read_map_id:
    ldh a, [hMapId]
    ld hl, MapItemUseFlags
    add_a_to_hl
    bit 4, [hl]
    jr z, .done

.skip:
    ld c, $00
    jr .return

.done:
    ld c, $01

.return:
    ret

; HL = cap, BC = current value: when they are equal sets wItemId = $FF (refuse); otherwise writes
; min(HL - BC, wItemEffectAmount) (wItemEffectAmount when the difference is 256 or more) as a
; decimal string at wTextBuf3 (WriteDecimalByteString) (E-0103)
ShowRaiseAmountOrRefuse::
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    jr z, .set_item_id_to_FF
    ld a, h
    or a
    ld a, [wItemEffectAmount]
    jr nz, .call_write_decimal_byte_string
    cp l
    jr z, .call_write_decimal_byte_string
    jr c, .call_write_decimal_byte_string
    ld a, l

.call_write_decimal_byte_string:
    ld hl, wTextBuf3
    call WriteDecimalByteString
    ret

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a
    ret

; returns when wItemId is $FF; otherwise jumps through a 95-entry table with one effect per item id.
; The Herb entry adds (wRandomLo after NextTableByte) / 11 + wItemEffectAmount to record
; wTargetRecord (AddHLToRecordHPCapped) and then runs ConsumeSelectedItemByChance; CheckItemUsable
; is the matching usability check (E-0089)
ApplyItemEffect::
    ld a, [wItemId]
    cp $ff
    ret z
    ld a, [wItemId]
    jumptable
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

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 0 (no name); the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Item00::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 1 Herb, 2 LoveWater;
; the body is not interpreted beyond the Herb case (E-0089) (C2 from E-0326: a Herb on a record at
; 50 of 138 HP leaves 89; at 5 of 21, 21)
ItemApply_Herb::
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, $0b
    call DivideBByA
    ld b, a
    ld a, [wItemEffectAmount]
    add b
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordHPCapped
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 3 WorldDew; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_WorldDew::
    ld a, $00
    call ItemApply_WorldDew_CheckTargetRecordFlag55Bit7
    ld a, $01
    call ItemApply_WorldDew_CheckTargetRecordFlag55Bit7
    ld a, $02
    call ItemApply_WorldDew_CheckTargetRecordFlag55Bit7
    call ConsumeSelectedItemByChance
    ret

ItemApply_WorldDew_CheckTargetRecordFlag55Bit7::
    ld hl, wPartyCount
    cp [hl]
    ret nc
    ld [wTargetRecord], a
    call CheckTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_MAX_HP
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, MON_HP
    call StoreHLToRecordField
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 4 Potion; the body is
; not interpreted beyond the Herb case (E-0089)
ItemApply_Potion::
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, $0b
    call DivideBByA
    ld b, a
    ld a, [wItemEffectAmount]
    add b
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordMPCapped
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 5 ElfWater; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_ElfWater::
    ld a, [wTargetRecord]
    ld c, MON_MAX_MP
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, MON_MP
    call StoreHLToRecordField
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 6 Antidote; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Antidote::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 2, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 7 MoonHerb; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_MoonHerb::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 3, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 8 Laurel; the body is
; not interpreted beyond the Herb case (E-0089)
ItemApply_Laurel::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 0, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 9 AwakeSand; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_AwakeSand::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 1, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 10 SkyBell; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_SkyBell::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 4, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 11 SageRock; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_SageRock::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 12 WorldLeaf; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_WorldLeaf::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld [hl], $00
    ld a, [wTargetRecord]
    ld c, MON_MAX_HP
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, MON_HP
    call StoreHLToRecordField
    ld a, $01
    ld [wLevelUpGains], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 13 ATKseed; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_ATKseed::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_ATKseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 14 DEFseed; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_DEFseed::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_DEFseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 15 AGLseed; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_AGLseed::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_AGLseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 16 INTseed; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_INTseed::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_INTseed_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 17 LifeAcorn; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_LifeAcorn::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_LifeAcorn_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 18 MysticNut; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_MysticNut::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_MysticNut_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 19 Quest?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Quest::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Quest_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 20 Horror?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Horror::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Horror_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 21 BeNice?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_BeNice::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_BeNice_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 22 Cheater?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Cheater::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Cheater_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 23 Smart?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Smart::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Smart_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 24 Comedy?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Comedy::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ItemApply_Comedy_MapIndexViaPartyListKeepHL
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 25 BeefJerky, 26
; PorkChop, 27 Rib, 28 Sirloin; the body is not interpreted beyond the Herb case (E-0089)
ItemApply_BeefJerky::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ApplyMeatToRecordField6B
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 29 BadMeat; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_BadMeat::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call ApplyMeatToRecordField6B
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    set 2, [hl]
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 30 MeteOrb; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_MeteOrb::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 31 BeastTail; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_BeastTail::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 32 Repellent; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_Repellent::
    ld a, $c8
    ld [wEncounterDelay], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 33 ShinyHarp; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_ShinyHarp::
    ld a, $01
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 34 Mist?, 35 Friend?,
; 36 Wind?, 37 Bolt?, 38 Snow?, 39 Fire?; the body is not interpreted beyond the Herb case (E-0089)
ItemApply_Mist::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 40 Warp?; the body is
; not interpreted beyond the Herb case (E-0089)
ItemApply_Warp::
    ld a, $02
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 41 WarpWing; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_WarpWing::
    ld a, $03
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 42 ExitBell; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_ExitBell::
    ld a, $04
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 43 Bookmark; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Bookmark::
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 44 TinyMedal, 45
; GoldPass; the body is not interpreted beyond the Herb case (E-0089)
ItemApply_TinyMedal::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 46 LogTwig; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_LogTwig::
    ld a, $09
    ld [wDataBankSave], a
    call ConsumeSelectedItemByChance
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 47 (no name); the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_Item2F::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 48 WaterCall; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_WaterCall::
    ld a, $05
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 49 MoonRock; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_MoonRock::
    ld a, $06
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 50 Crest; the body is
; not interpreted beyond the Herb case (E-0089)
ItemApply_Crest::
    ld a, $07
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 51 YunaSoul; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_YunaSoul::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 52 SleepHerb; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_SleepHerb::
    ld a, $08
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 53 Change?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Change::
    ld a, $0a
    ld [wDataBankSave], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 54 TidalBell; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_TidalBell::
    ld a, [wTownEventTimer]
    add $32
    jr nc, .cp_F0
    ld a, $ff

.cp_F0:
    cp $f0
    jr c, .set_town_event_timer
    ld a, $f0

.set_town_event_timer:
    ld [wTownEventTimer], a
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 55 HarMirror, 56
; Sky?, 57 Heaven?, 58 Heaven?, 59 Heaven?, 60 WizStone, 61 Pretty?; the body is not interpreted
; beyond the Herb case (E-0089)
ItemApply_HarMirror::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 62 Accessory, 63
; Accessory; the body is not interpreted beyond the Herb case (E-0089)
ItemApply_Accessory::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 64 VITbelt; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_VITbelt::
    ld a, $1e
    ld c, MON_MAX_HP
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 65 DracoBelt; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_DracoBelt::
    ld a, $50
    ld c, MON_MAX_HP
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 66 MagicBelt; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_MagicBelt::
    ld a, $1e
    ld c, MON_MAX_MP
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 67 OddBelt; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_OddBelt::
    ld a, $50
    ld c, MON_MAX_MP
    call AddAToRecordWordPairCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 68 StoneFang; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_StoneFang::
    ld a, $0a
    ld c, MON_ATK
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 69 SteelFang; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_SteelFang::
    ld a, $32
    ld c, MON_ATK
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 70 MermScale; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_MermScale::
    ld a, $0a
    ld c, MON_DEF
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 71 DrakScale; the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_DrakScale::
    ld a, $32
    ld c, MON_DEF
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 72 AGL?; the body is
; not interpreted beyond the Herb case (E-0089)
ItemApply_AGL::
    ld a, $0a
    ld c, MON_AGL
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 73 Starry?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Starry::
    ld a, $32
    ld c, MON_AGL
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 74 Smart?; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_Smart_4A1D::
    ld a, $32
    ld c, MON_INT
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 75 Wise?; the body is
; not interpreted beyond the Herb case (E-0089)
ItemApply_Wise::
    ld a, $64
    ld c, MON_INT
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 76 MagicCape, 77
; DracoCape, 78 SilvrCape, 79 GoldCape, 80 PltnmCape, 81 OrcaCape, 82 BraveCape; the body is not
; interpreted beyond the Herb case (E-0089)
ItemApply_MagicCape::
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 83 D-Scale; the body
; is not interpreted beyond the Herb case (E-0089)
ItemApply_DScale::
    ld a, $05
    ld c, MON_DEF
    call AddAToRecordWordCapped
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 84 None, 85 None, 86
; None, 87 None, 88 None, 89 None; the body is not interpreted beyond the Herb case (E-0089)
ItemApply_None::
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 90 Life?, 91 Divine?,
; 92 War?, 93 Mage?, 94 Fight?, 95 Sailor?, 96 Thief?, 97 Cleric?; the body is not interpreted
; beyond the Herb case (E-0089)
ItemApply_Life::
    call EquipItemOnRecordTargetRecord
    ret

; item effect reached through ApplyItemEffect (indexed by wItemId) for item(s) 98 (no name); the
; body is not interpreted beyond the Herb case (E-0089)
ItemApply_Item62::
    ret

; stores item wItemId - $3F in field $A4 of record wTargetRecord: an empty field consumes the item
; (hTemp0 = 0); otherwise the old item goes back to the inventory and its name to wTextBuf3 (hTemp0
; = 1) (E-0125)
EquipItemOnRecordTargetRecord::
    ld a, [wTargetRecord]
    ld c, MON_ITEM
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    jr nz, .read_item_id
    ld a, [wItemId]
    sub $3f
    ld [hl], a
    call ConsumeSelectedItemByChance
    xor a
    ldh [hTemp0], a
    ret

.read_item_id:
    push af
    ld a, [wItemId]
    sub $3f
    ld [hl], a
    ld a, $ff
    ld [wItemId], a
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    pop af
    add $3f
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

; preserving A, runs the routine for item A - $40 (a jump table over the equipment items;
; EquipItemOnRecordTargetRecord calls it) (E-0122, E-0259)
ApplyEquipmentEffectKeepA::
    push af
    call ApplyEquipmentEffectKeepA_ByItem
    pop af
    ret

; jumps by (item id - $40) to a step that subtracts A from one or two record words with a floor of
; 1, or returns
ApplyEquipmentEffectKeepA_ByItem::
    sub $40
    jumptable
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1_Case01
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1_Case02
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1_Case03
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case05
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case06
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case07
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case08
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case09
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case0A
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case0B
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_Return
    dw ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case13
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case14
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case14
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case14
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case14
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case14
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case14
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case1A
    dw ApplyEquipmentEffectKeepA_ByItem_Return_Case22

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1::
    ld a, $1e
    ld c, MON_MAX_HP
    call SubtractAFromRecordWordPairFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1_Case01::
    ld a, $50
    ld c, MON_MAX_HP
    call SubtractAFromRecordWordPairFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1_Case02::
    ld a, $1e
    ld c, MON_MAX_MP
    call SubtractAFromRecordWordPairFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordPairFloor1_Case03::
    ld a, $50
    ld c, MON_MAX_MP
    call SubtractAFromRecordWordPairFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1::
    ld a, $0a
    ld c, MON_ATK
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case05::
    ld a, $32
    ld c, MON_ATK
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case06::
    ld a, $0a
    ld c, MON_DEF
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case07::
    ld a, $32
    ld c, MON_DEF
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case08::
    ld a, $0a
    ld c, MON_AGL
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case09::
    ld a, $32
    ld c, MON_AGL
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case0A::
    ld a, $32
    ld c, MON_INT
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case0B::
    ld a, $64
    ld c, MON_INT
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_Return::
    ret

ApplyEquipmentEffectKeepA_ByItem_ToSubtractAFromRecordWordFloor1_Case13::
    ld a, $05
    ld c, MON_DEF
    call SubtractAFromRecordWordFloor1
    ret

ApplyEquipmentEffectKeepA_ByItem_Return_Case14::
    ret

ApplyEquipmentEffectKeepA_ByItem_Return_Case1A::
    ret

ApplyEquipmentEffectKeepA_ByItem_Return_Case22::
    ret

; A = amount, record wTargetRecord (SRAMRecordAddressMapped), field offset C: the word there += A,
; capped at 999 (CapDETo999) (E-0103)
AddAToRecordWordCapped::
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hTemp0]
    add e
    ld e, a
    jr nc, .call_cap_de_to999
    inc d

.call_cap_de_to999:
    call CapDETo999
    ld a, d
    ld [hld], a
    ld a, e
    ld [hl], a
    ret

; A = amount, record wTargetRecord (SRAMRecordAddressMapped), field offset C: adds A to the word at
; field C and to the word two bytes before it, each capped at 999 (E-0103)
AddAToRecordWordPairCapped::
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hTemp0]
    add e
    ld e, a
    jr nc, .call_cap_de_to999
    inc d

.call_cap_de_to999:
    call CapDETo999
    ld a, d
    ld [hld], a
    ld a, e
    ld [hl], a
    dec hl
    dec hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [hTemp0]
    add e
    ld e, a
    jr nc, .call_cap_de_to9992
    inc d

.call_cap_de_to9992:
    call CapDETo999
    ld a, d
    ld [hld], a
    ld a, e
    ld [hl], a
    ret

; A = amount, record wTargetRecord (SRAMRecordAddressMapped), field offset C: leaves the word
; unchanged when it is 999; otherwise word -= A, but never below 1 (E-0103)
SubtractAFromRecordWordFloor1::
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    cp $e7
    jr nz, .read_temp0
    ld a, d
    cp $03
    ret z

.read_temp0:
    ld a, e
    push af
    ldh a, [hTemp0]
    ld e, a
    pop af
    sub e
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    bit 7, a
    jr z, .skip
    ld de, $0001

.skip:
    ld a, d
    ld [hld], a
    ld a, e
    ld [hl], a
    ret

; A = amount, record wTargetRecord (SRAMRecordAddressMapped), field offset C: as
; SubtractAFromRecordWordFloor1 for the word at field C, then the same for the word two bytes before
; it (the second half is not read to its end) (E-0103)
SubtractAFromRecordWordPairFloor1::
    ldh [hTemp0], a
    ld a, [wTargetRecord]
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    cp $e7
    jr nz, .read_temp0
    ld a, d
    cp $03
    ret z

.read_temp0:
    ld a, e
    push af
    ldh a, [hTemp0]
    ld e, a
    pop af
    sub e
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    bit 7, a
    jr z, .skip
    ld de, $0001

.skip:
    ld a, d
    ld [hld], a
    ld a, e
    ld [hl], a
    dec hl
    dec hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    push af
    ldh a, [hTemp0]
    ld e, a
    pop af
    sub e
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    bit 7, a
    jr z, .skip2
    ld de, $0001

.skip2:
    ld a, d
    ld [hld], a
    ld a, e
    ld [hl], a
    ret

; DE = min(DE, 999 ($03E7)) (E-0103)
CapDETo999::
    ld a, d
    cp $03
    ret c
    jr nz, .done
    ld a, e
    cp $e8
    ret c

.done:
    ld e, $e7
    ld d, $03
    ret

; advances the random table (NextTableByte), takes A = (wRandomHi:wRandomLo) mod 100 and, when A <
; wItemRecord + $3, sets wItemId = $FF, clears wInventory[wInventorySlot] to $FF and runs
; CompactInventory; otherwise returns with carry clear and nothing changed (E-0063)
ConsumeSelectedItemByChance::
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $64
    call DivideHLByA
    ld hl, wItemRecord + $3
    cp [hl]
    ret nc
    ld a, $ff
    ld [wItemId], a
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $ff
    call CompactInventory
    ret

; copies the 24 wInventory bytes to wWorkBuf, refills wInventory with $FF, then copies back every
; byte that is neither $FF nor $00, closing the gaps (E-0063) (C2 from E-0326: the used Herb leaves
; the bag, which closes up)
CompactInventory::
    ld hl, wWorkBuf
    ld de, wInventory
    ld b, $18

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wInventory
    ld bc, $0018
    ld a, $ff
    call FillBytes
    ld hl, wWorkBuf
    ld de, wInventory
    ld b, $18

.loop2:
    ld a, [hli]
    cp $ff
    jr z, .next
    cp $00
    jr z, .next
    ld [de], a
    inc de

.next:
    dec b
    jr nz, .loop2
    ret

; puts wItemId in the first empty inventory slot; sets wItemId = $FF when all 24 are full (E-0124)
AddWItemIdToInventory::
    ld a, [wItemId]
    cp ITEM_00
    ret z
    cp $ff
    ret z
    ld hl, wInventory
    ld b, $18

.loop:
    ld a, [hl]
    cp $00
    jr z, .read_item_id
    cp $ff
    jr z, .read_item_id
    inc hl
    dec b
    jr nz, .loop
    ld a, $ff
    ld [wItemId], a
    ret

.read_item_id:
    ld a, [wItemId]
    ld [hl], a
    ret

; removes the first inventory slot holding wItemId and compacts the inventory; sets wItemId = $FF
; when not found (E-0124)
RemoveWItemIdFromInventory::
    ld a, [wItemId]
    cp ITEM_00
    ret z
    cp $ff
    ret z
    ld hl, wInventory
    ld b, $18

.loop:
    ld a, [wItemId]
    cp [hl]
    jr z, .call_compact_inventory
    inc hl
    dec b
    jr nz, .loop
    ld a, $ff
    ld [wItemId], a
    ret

.call_compact_inventory:
    ld [hl], $ff
    call CompactInventory
    ret

; E-0034 (C1: LoadItemRecord copies 13 bytes from here by item id (wItemId) to wItemRecord;
; RunItemEffect dispatches on the same id; wInventory is a 24-slot bag of such ids, empty at the
; start of a new game, matching the item menu's 'No items'; the herb handler compares the words at
; save-record offsets $5B and $5D to refuse use at full HP). 99 records: the next bytes are a
; different table. The meaning of the fields is not established beyond the first amount being 10,
; 50, 500, 200 and 2000 for ids 1-5.
; record: byte 0 (0, 1, 2 or 6); 16-bit amount (10, 50, 500, 200, 2000 for the first five items);
; byte 3 (usually $64); byte 4; byte 5 (never read); byte 6; byte 7; byte 8; byte 9; byte 10; byte
; 11; byte 12
ItemTable::
    db $00 ; id 0
    dw 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00 ; id 1
    dw 10
    db $64, $00, $00, $04, $02, $00, $03, $04, $1e, $28
    db $00 ; id 2
    dw 50
    db $64, $00, $00, $04, $03, $00, $03, $04, $3c, $46
    db $00 ; id 3
    dw 500
    db $64, $00, $00, $05, $03, $00, $06, $04, $ff, $ff
    db $00 ; id 4
    dw 200
    db $64, $00, $00, $04, $03, $00, $03, $07, $14, $1e
    db $00 ; id 5
    dw 2000
    db $64, $00, $00, $04, $03, $00, $03, $07, $ff, $ff
    db $01 ; id 6
    dw 4
    db $64, $00, $00, $04, $02, $00, $03, $08, $00, $00
    db $01 ; id 7
    dw 20
    db $64, $00, $00, $04, $02, $00, $03, $09, $00, $00
    db $01 ; id 8
    dw 20
    db $64, $00, $00, $04, $02, $00, $03, $0b, $00, $00
    db $01 ; id 9
    dw 20
    db $64, $00, $00, $04, $03, $00, $03, $0c, $00, $00
    db $01 ; id 10
    dw 20
    db $64, $00, $00, $04, $04, $00, $03, $0a, $00, $00
    db $00 ; id 11
    dw 1000
    db $14, $02, $00, $05, $00, $00, $05, $04, $2d, $37
    db $01 ; id 12
    dw 1000
    db $64, $00, $00, $04, $02, $00, $03, $0d, $00, $00
    db $02 ; id 13
    dw 20
    db $64, $01, $00, $00, $05, $00, $03, $10, $03, $00
    db $02 ; id 14
    dw 20
    db $64, $01, $00, $00, $05, $00, $03, $11, $03, $00
    db $02 ; id 15
    dw 20
    db $64, $01, $00, $00, $05, $00, $03, $12, $03, $00
    db $02 ; id 16
    dw 20
    db $64, $01, $00, $00, $05, $00, $03, $13, $03, $00
    db $02 ; id 17
    dw 20
    db $64, $01, $00, $00, $05, $00, $03, $0e, $05, $00
    db $02 ; id 18
    dw 20
    db $64, $01, $00, $00, $05, $00, $03, $0f, $05, $00
    db $02 ; id 19
    dw 10000
    db $64, $01, $00, $00, $00, $00, $1a, $1b, $32, $32
    db $02 ; id 20
    dw 10000
    db $64, $01, $00, $00, $00, $00, $1a, $1c, $32, $32
    db $02 ; id 21
    dw 10000
    db $64, $01, $00, $00, $00, $00, $1a, $1d, $32, $32
    db $02 ; id 22
    dw 10000
    db $64, $01, $00, $00, $00, $00, $1a, $1e, $32, $32
    db $02 ; id 23
    dw 10000
    db $64, $01, $00, $00, $00, $00, $1a, $1f, $32, $32
    db $02 ; id 24
    dw 10000
    db $64, $01, $00, $00, $00, $00, $1a, $20, $32, $32
    db $03 ; id 25
    dw 10
    db $64, $00, $01, $04, $06, $00, $14, $15, $05, $0a
    db $03 ; id 26
    dw 40
    db $64, $00, $01, $04, $06, $00, $14, $15, $0a, $1e
    db $03 ; id 27
    dw 200
    db $64, $00, $01, $04, $06, $00, $14, $15, $14, $64
    db $03 ; id 28
    dw 1000
    db $64, $00, $01, $04, $06, $00, $14, $15, $64, $ff
    db $06 ; id 29
    dw 20
    db $64, $00, $01, $04, $06, $04, $14, $16, $05, $05
    db $03 ; id 30
    dw 5000
    db $64, $02, $01, $03, $00, $00, $21, $22, $00, $ff
    db $06 ; id 31
    dw 800
    db $00, $02, $01, $07, $00, $00, $2b, $2c, $00, $00
    db $06 ; id 32
    dw 100
    db $64, $01, $00, $07, $03, $00, $06, $23, $00, $00
    db $06 ; id 33
    dw 1200
    db $00, $01, $00, $07, $00, $01, $24, $ff, $00, $00
    db $04 ; id 34
    dw 700
    db $14, $02, $00, $03, $07, $00, $00, $00, $00, $00
    db $04 ; id 35
    dw 800
    db $3c, $02, $00, $00, $07, $00, $00, $00, $00, $00
    db $04 ; id 36
    dw 1500
    db $0a, $02, $00, $03, $07, $00, $00, $00, $08, $18
    db $04 ; id 37
    dw 3000
    db $14, $02, $00, $03, $07, $00, $00, $00, $23, $32
    db $04 ; id 38
    dw 4000
    db $14, $02, $00, $03, $07, $00, $00, $00, $78, $8c
    db $04 ; id 39
    dw 5000
    db $14, $02, $00, $02, $07, $00, $00, $00, $b4, $c8
    db $05 ; id 40
    dw 50
    db $64, $01, $00, $07, $07, $00, $17, $ff, $00, $00
    db $05 ; id 41
    dw 25
    db $64, $01, $00, $07, $08, $00, $18, $ff, $00, $00
    db $05 ; id 42
    dw 50
    db $64, $01, $00, $07, $04, $00, $19, $ff, $00, $00
    db $06 ; id 43
    dw 50
    db $64, $01, $00, $07, $00, $00, $25, $25, $00, $00
    db $06 ; id 44
    dw 1
    db $64, $03, $00, $07, $09, $05, $19, $00, $00, $00
    db $06 ; id 45
    dw 1
    db $00, $03, $00, $07, $00, $05, $00, $00, $00, $00
    db $06 ; id 46
    dw 50
    db $64, $01, $00, $07, $00, $00, $19, $ff, $00, $00
    db $00 ; id 47
    dw 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $06 ; id 48
    dw 0
    db $00, $01, $00, $07, $00, $07, $19, $ff, $00, $00
    db $06 ; id 49
    dw 0
    db $00, $01, $00, $07, $00, $07, $19, $ff, $00, $00
    db $06 ; id 50
    dw 0
    db $00, $01, $00, $07, $00, $07, $19, $ff, $00, $00
    db $06 ; id 51
    dw 0
    db $00, $03, $00, $07, $00, $07, $19, $00, $00, $00
    db $06 ; id 52
    dw 0
    db $00, $01, $00, $07, $00, $07, $19, $ff, $00, $00
    db $06 ; id 53
    dw 0
    db $00, $01, $00, $07, $00, $07, $19, $ff, $00, $00
    db $06 ; id 54
    dw 0
    db $00, $01, $00, $07, $00, $07, $19, $2f, $00, $00
    db $06 ; id 55
    dw 0
    db $00, $02, $00, $03, $00, $07, $19, $ff, $00, $00
    db $06 ; id 56
    dw 0
    db $00, $02, $00, $01, $00, $07, $21, $ff, $00, $00
    db $06 ; id 57
    dw 0
    db $00, $03, $00, $07, $00, $07, $00, $00, $00, $00
    db $06 ; id 58
    dw 0
    db $00, $03, $00, $07, $00, $07, $00, $00, $00, $00
    db $06 ; id 59
    dw 0
    db $00, $03, $00, $07, $00, $07, $00, $00, $00, $00
    db $06 ; id 60
    dw 0
    db $00, $03, $00, $07, $00, $07, $19, $ff, $00, $00
    db $06 ; id 61
    dw 0
    db $00, $03, $00, $07, $00, $07, $19, $ff, $00, $00
    db $00 ; id 62
    dw 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00 ; id 63
    dw 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $06 ; id 64
    dw 200
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 65
    dw 500
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 66
    dw 200
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 67
    dw 500
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 68
    dw 200
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 69
    dw 500
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 70
    dw 200
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 71
    dw 500
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 72
    dw 200
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 73
    dw 500
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 74
    dw 200
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 75
    dw 500
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 76
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 77
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 78
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 79
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 80
    dw 5000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 81
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 82
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 83
    dw 20
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 84
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 85
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 86
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 87
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 88
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 89
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 90
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 91
    dw 1000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 92
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 93
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 94
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 95
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 96
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 97
    dw 2000
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00
    db $06 ; id 98
    dw 13
    db $64, $01, $00, $00, $00, $00, $30, $27, $00, $00

; ItemUsable_WarpWing tests bit 6, the ExitBell check (ItemUsable_ExitBell, E-0085) bit 5 and
; SaveForbiddenHere bit 4 of the byte at $51C9 + hMapId; a clear bit refuses the item (wItemId =
; $FF) or, for bit 4, gives C = 1 (no saving, E-0322); 256 bytes, one per map number, end at
; PauseMenu_Skills_UseFieldSkill_Case02_WriteItemId (E-0229, C1)
; record: flag bits for this map (bit 6: WarpWing, bit 5: ExitBell, bit 4: saving allowed,
; SaveForbiddenHere)
MapItemUseFlags::
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
    db $c0 ; id 32
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
    db $a0 ; id 43
    db $00 ; id 44
    db $10 ; id 45
    db $10 ; id 46
    db $40 ; id 47
    db $c0 ; id 48
    db $10 ; id 49
    db $10 ; id 50
    db $10 ; id 51
    db $10 ; id 52
    db $a0 ; id 53
    db $00 ; id 54
    db $80 ; id 55
    db $a0 ; id 56
    db $a0 ; id 57
    db $a0 ; id 58
    db $20 ; id 59
    db $10 ; id 60
    db $10 ; id 61
    db $a0 ; id 62
    db $a0 ; id 63
    db $20 ; id 64
    db $10 ; id 65
    db $80 ; id 66
    db $c0 ; id 67
    db $00 ; id 68
    db $10 ; id 69
    db $00 ; id 70
    db $00 ; id 71
    db $c0 ; id 72
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
    db $a0 ; id 83
    db $a0 ; id 84
    db $a0 ; id 85
    db $a0 ; id 86
    db $20 ; id 87
    db $10 ; id 88
    db $10 ; id 89
    db $10 ; id 90
    db $10 ; id 91
    db $10 ; id 92
    db $a0 ; id 93
    db $10 ; id 94
    db $10 ; id 95
    db $10 ; id 96
    db $10 ; id 97
    db $a0 ; id 98
    db $a0 ; id 99
    db $a0 ; id 100
    db $a0 ; id 101
    db $a0 ; id 102
    db $a0 ; id 103
    db $10 ; id 104
    db $00 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $00 ; id 108
    db $00 ; id 109
    db $00 ; id 110
    db $00 ; id 111
    db $c0 ; id 112
    db $10 ; id 113
    db $10 ; id 114
    db $a0 ; id 115
    db $a0 ; id 116
    db $a0 ; id 117
    db $a0 ; id 118
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
    db $a0 ; id 129
    db $a0 ; id 130
    db $a0 ; id 131
    db $20 ; id 132
    db $a0 ; id 133
    db $a0 ; id 134
    db $a0 ; id 135
    db $a0 ; id 136
    db $10 ; id 137
    db $20 ; id 138
    db $a0 ; id 139
    db $a0 ; id 140
    db $20 ; id 141
    db $a0 ; id 142
    db $20 ; id 143
    db $a0 ; id 144
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
    db $c0 ; id 160
    db $20 ; id 161
    db $20 ; id 162
    db $20 ; id 163
    db $10 ; id 164
    db $00 ; id 165
    db $00 ; id 166
    db $00 ; id 167
    db $c0 ; id 168
    db $10 ; id 169
    db $40 ; id 170
    db $10 ; id 171
    db $20 ; id 172
    db $a0 ; id 173
    db $a0 ; id 174
    db $10 ; id 175
    db $c0 ; id 176
    db $10 ; id 177
    db $10 ; id 178
    db $a0 ; id 179
    db $a0 ; id 180
    db $a0 ; id 181
    db $20 ; id 182
    db $00 ; id 183
    db $c0 ; id 184
    db $10 ; id 185
    db $10 ; id 186
    db $20 ; id 187
    db $10 ; id 188
    db $20 ; id 189
    db $a0 ; id 190
    db $a0 ; id 191
    db $a0 ; id 192
    db $a0 ; id 193
    db $a0 ; id 194
    db $a0 ; id 195
    db $a0 ; id 196
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

PauseMenu_Skills_UseFieldSkill_Case02_WriteItemId::
    ld a, [wInventorySlot]
    cp $14
    jr c, .skip
    ld a, $ff
    ld [wItemId], a
    ret

.skip:
    jumptable
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Herb
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Herb
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Herb
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WorldDew
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WorldDew
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Potion
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Potion
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Potion
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WorldLeaf
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WorldLeaf
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Antidote
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ListPartyMembersWithField55Bit0
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Repellent
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Repellent
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Repellent
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_ExitBell
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Repellent
    dw PauseMenu_Skills_UseFieldSkill_SetItemMessage14IfItemRefused
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Warp
    dw PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WarpWing

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Herb::
    call ItemUsable_Herb
    call SetItemMessage12IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WorldDew::
    call ItemUsable_WorldDew
    call SetItemMessage12IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Potion::
    ld a, [wMenuSelectedMember]
    ld c, a
    ld a, [wTargetRecord]
    cp c
    jr nz, .call_item_usable_potion
    ld a, $ff
    ld [wItemId], a
    jr .call_set_item_message12_if_item_refused

.call_item_usable_potion:
    call ItemUsable_Potion

.call_set_item_message12_if_item_refused:
    call SetItemMessage12IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WorldLeaf::
    call ItemUsable_WorldLeaf
    call SetItemMessage12IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Antidote::
    call ItemUsable_Antidote
    call SetItemMessage12IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ListPartyMembersWithField55Bit0::
    call ListPartyMembersWithField55Bit0
    call SetItemMessage12IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Repellent::
    call ItemUsable_Repellent
    ld a, [wInventorySlot]
    cp $10
    jr z, .check_item_id
    call SetItemMessage14IfItemRefused
    ret

.check_item_id:
    ld a, [wItemId]
    cp $ff
    jr nz, .call_collect_unique_encounter_ids_to_work
    ld a, $15
    ld [wItemMessage], a
    ret

.call_collect_unique_encounter_ids_to_work:
    call CollectUniqueEncounterIdsToWorkBuf2
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_ExitBell::
    call ItemUsable_ExitBell
    call SetItemMessage14IfItemRefused
    ret

PauseMenu_Skills_UseFieldSkill_SetItemMessage14IfItemRefused::
    call ItemUsable_Repellent
    call SetItemMessage14IfItemRefused
    ret z
    ld a, [wGoldHi]
    or a
    jr nz, .check_inventory
    ld a, [wGoldMid]
    or a
    jr nz, .check_inventory
    ld a, [wGoldLo]
    cp $64
    jr nc, .check_inventory
    ld a, $ff
    ld [wItemId], a
    ld a, $17
    ld [wItemMessage], a
    ret

.check_inventory:
    ld a, [wInventory + $17]
    or a
    ret z
    cp $ff
    ret z
    ld a, $ff
    ld [wItemId], a
    ld a, $16
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_Warp::
    call ItemUsable_Warp
    call SetItemMessage14IfItemRefused
    ret z
    ld a, [wMapObjectCount]
    or a
    jr z, .set_item_id_to_FF
    ld hl, wMapObjects
    ld a, [wMapObjectCount]
    ld b, a

.loop:
    bit 7, [hl]
    jr z, .return
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop

.set_item_id_to_FF:
    ld a, $ff
    ld [wItemId], a
    ld a, $18
    ld [wItemMessage], a
    ret

.return:
    ret

PauseMenu_Skills_UseFieldSkill_Case02_Sub01_ItemUsable_WarpWing::
    call ItemUsable_WarpWing
    call SetItemMessage14IfItemRefused
    ret

; when wItemId is $FF (refused): wItemMessage = $12 (E-0119) (E-0340: the address in its name read
; as its RAM name; was SetWD08D12IfItemRefused)
SetItemMessage12IfItemRefused::
    ld a, [wItemId]
    cp $ff
    ret nz
    ld a, $12
    ld [wItemMessage], a
    ret

; when wItemId is $FF (refused): wItemMessage = $14 (E-0119) (E-0340: the address in its name read
; as its RAM name; was SetWD08D14IfItemRefused)
SetItemMessage14IfItemRefused::
    ld a, [wItemId]
    cp $ff
    ret nz
    ld a, $14
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_WaitItemId::
    ld a, [wItemId]
    cp $ff
    ret z
    ld a, [wInventorySlot]
    jumptable
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordHPByRandomAmount
    dw PauseMenu_Skills_UseFieldSkill_SetItemEffectAmount
    dw FullHealRecordTargetRecord
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealPartyRecordAIfHurt
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_FullHealPartyRecordA
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordMPByItemEffectAmount
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordMPByItemEffectAmount_Case06_SetItemEffectAmount
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordMPByItemEffectAmount_Case07_SetItemEffectAmount
    dw PauseMenu_Skills_UseFieldSkill_SetItemMessage
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_FullHealRecordTargetRecord
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SRAMRecordAddressMapped
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_ClearPartyRecordFlag55Bit0
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetDataBankSave
    dw PauseMenu_Skills_UseFieldSkill_SetDataBankSave
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetTalkCountdown
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetDataBankSave_Case0F_SetDataBankSave
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetItemMessageTo0B
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_NextTableByte
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetGameMode2Byte50
    dw PauseMenu_Skills_UseFieldSkill_Case07_Sub01_MarkVisitedScreens5x5AroundPlayer

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordHPByRandomAmount::
    ld a, $0a
    ld [wItemEffectAmount], a
    ld a, $1e
    ld [wItemEffectRange], a
    call HealRecordHPByRandomAmount
    ld a, $06
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_SetItemEffectAmount::
    ld a, $0f
    ld [wItemEffectAmount], a
    ld a, $4b
    ld [wItemEffectRange], a
    call HealRecordHPByRandomAmount
    ld a, $06
    ld [wItemMessage], a
    ret

; record wTargetRecord: copies its word at field $5D (max HP) into field $5B (HP)
; (StoreHLToRecordField), then wItemMessage = 6 (E-0117)
FullHealRecordTargetRecord::
    ld a, [wTargetRecord]
    ld c, MON_MAX_HP
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, MON_HP
    call StoreHLToRecordField
    ld a, $06
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealPartyRecordAIfHurt::
    ld a, $1e
    ld [wItemEffectAmount], a
    ld a, $5a
    ld [wItemEffectRange], a
    ld a, [wItemRecordByte0A]
    ld [wItemMessage], a
    ld a, $00
    call HealPartyRecordAIfHurt
    ld a, $01
    call HealPartyRecordAIfHurt
    ld a, $02

; A = party index: returns when it is not below wPartyCount, when record byte $55 bit 7 is set, or
; when HP ($5B) already equals max HP ($5D); otherwise HealRecordHPByRandomAmount (a random heal)
; (E-0120)
HealPartyRecordAIfHurt::
    ld hl, wPartyCount
    cp [hl]
    ret nc
    ld [wTargetRecord], a
    call TestTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    ret z
    call HealRecordHPByRandomAmount
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_FullHealPartyRecordA::
    ld a, [wItemRecordByte0A]
    ld [wItemMessage], a
    ld a, $00
    call FullHealPartyRecordA
    ld a, $01
    call FullHealPartyRecordA
    ld a, $02

; A = party index: returns when it is not below wPartyCount or the record's byte $55 bit 7 is set;
; otherwise wTargetRecord = A and the record's HP word ($5B) = its max HP word ($5D) (E-0117)
FullHealPartyRecordA::
    ld hl, wPartyCount
    cp [hl]
    ret nc
    ld [wTargetRecord], a
    call TestTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_MAX_HP
    call SRAMRecordAddressMapped
    deref_hl
    ld a, [wTargetRecord]
    ld c, MON_HP
    call StoreHLToRecordField
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordMPByItemEffectAmount::
    ld a, $0f
    ld [wItemEffectAmount], a
    call HealRecordMPByItemEffectAmount
    ld a, $07
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordMPByItemEffectAmount_Case06_SetItemEffectAmount::
    ld a, $1e
    ld [wItemEffectAmount], a
    call HealRecordMPByItemEffectAmount
    ld a, $07
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_HealRecordMPByItemEffectAmount_Case07_SetItemEffectAmount::
    ld a, $50
    ld [wItemEffectAmount], a
    call HealRecordMPByItemEffectAmount
    ld a, $07
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_SetItemMessage::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld [hl], $00
    ld a, [wTargetRecord]
    ld c, MON_HP
    call SRAMRecordAddressMapped
    push hl
    inc hl
    inc hl
    ld a, [hli]
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

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_FullHealRecordTargetRecord::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld [hl], $00
    call FullHealRecordTargetRecord
    ld a, $08
    ld [wItemMessage], a
    ld a, $01
    ld [wLevelUpGains], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SRAMRecordAddressMapped::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 2, [hl]
    ld a, $09
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_ClearPartyRecordFlag55Bit0::
    ld a, [wItemRecordByte0A]
    ld [wItemMessage], a
    ld a, $00
    call ClearPartyRecordFlag55Bit0
    ld a, $01
    call ClearPartyRecordFlag55Bit0
    ld a, $02

; A = party index: returns when it is not below wPartyCount or byte $55 bit 7 is set; otherwise
; clears bit 0 of the record's byte $55 (E-0117)
ClearPartyRecordFlag55Bit0::
    ld hl, wPartyCount
    cp [hl]
    ret nc
    ld [wTargetRecord], a
    call TestTargetRecordFlag55Bit7
    ret nz
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    res 0, [hl]
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetDataBankSave::
    ld a, $01
    ld [wDataBankSave], a
    ld a, $ff
    ld [wItemMessage], a
    ld a, $ff
    ld [wItemId], a
    ret

PauseMenu_Skills_UseFieldSkill_SetDataBankSave::
    ld a, $01
    ld [wDataBankSave], a
    ld a, [wMenuSelectedMember]
    ld c, MON_SEX
    call SRAMRecordAddressMapped
    ld a, [hl]
    and $01
    xor $01
    or $10
    ld [wNewRecordByte0D], a
    ld a, $ff
    ld [wItemMessage], a
    ld a, $ff
    ld [wItemId], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetTalkCountdown::
    ld a, $c8
    ld [wTalkCountdown], a
    ld a, $ff
    ld [wItemMessage], a
    ld a, $ff
    ld [wItemId], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetDataBankSave_Case0F_SetDataBankSave::
    ld a, $04
    ld [wDataBankSave], a
    ld a, $ff
    ld [wItemMessage], a
    ld a, $ff
    ld [wItemId], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetItemMessageTo0B::
    ld a, $0b
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_NextTableByte::
    ld a, [wMapType]
    cp $80
    jr nz, .skip
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, .skip
    xor a
    ld [wSpriteSlotCount], a
    ld [wScreenSavedFlag], a
    ld [wPendingFieldEvent], a

.skip:
    ld hl, wGoldLo
    ld a, [hl]
    sub $64
    ld [hli], a
    ld a, [hl]
    sbc $00
    ld [hli], a
    ld a, [hl]
    sbc $00
    ld [hl], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $64
    call Divide24ByA
    ld c, $01
    sub $19
    jr c, .set_inventory
    ld c, $02
    sub $0a
    jr c, .set_inventory
    ld c, $04
    sub $05
    jr c, .set_inventory
    ld c, $06
    sub $05
    jr c, .set_inventory
    ld c, $07
    sub $05
    jr c, .set_inventory
    ld c, $08
    sub $05
    jr c, .set_inventory
    ld c, $09
    sub $05
    jr c, .set_inventory
    ld c, $0a
    sub $05
    jr c, .set_inventory
    ld c, $19
    sub $05
    jr c, .set_inventory
    ld c, $1a
    sub $05
    jr c, .set_inventory
    ld c, $1b
    sub $02
    jr c, .set_inventory
    ld c, $1c
    sub $01
    jr c, .set_inventory
    ld c, $1d
    sub $05
    jr c, .set_inventory
    ld c, $20
    sub $05
    jr c, .set_inventory
    ld c, $28
    sub $05
    jr c, .set_inventory
    ld c, $29
    sub $01
    jr c, .set_inventory
    ld c, $2a
    sub $05
    jr c, .set_inventory
    ld c, $2b
    sub $01
    jr c, .set_inventory
    ld a, $ff
    ld [wItemId], a
    jr .set_item_message_to_0E

.set_inventory:
    ld a, c
    ld [wInventory + $17], a
    ld l, c
    ld h, $05
    ld de, wTextBuf3
    call CopyStringHLToDE
    farcall CompactInventory

.set_item_message_to_0E:
    ld a, $0e
    ld [wItemMessage], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_SetGameMode2Byte50::
    ld a, $01
    ld [wGameMode2Byte50], a
    ld a, $11
    ld [wItemMessage], a
    ld a, $ff
    ld [wItemId], a
    ret

PauseMenu_Skills_UseFieldSkill_Case07_Sub01_MarkVisitedScreens5x5AroundPlayer::
    farcall MarkVisitedScreens5x5AroundPlayer
    ld a, $1c
    ld [wItemMessage], a
    ld a, $ff
    ld [wItemId], a
    ret

; reads the next table byte, then heals record wTargetRecord's HP by wRandomLo / (wItemEffectAmount
; + 1) + wItemEffectRange (capped at max HP) (E-0122)
HealRecordHPByRandomAmount::
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, [wItemEffectAmount]
    inc a
    call DivideBByA
    ld b, a
    ld a, [wItemEffectRange]
    add b
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordHPCapped
    ret

; heals record wTargetRecord's MP by wItemEffectAmount (capped at max MP) (E-0122)
HealRecordMPByItemEffectAmount::
    ld a, [wItemEffectAmount]
    ld l, a
    ld h, $00
    ld a, [wTargetRecord]
    call AddHLToRecordMPCapped
    ret

; Z clear when bit 7 of byte $55 of record wTargetRecord is set (SRAMRecordAddressMapped); HL points
; at it (E-0114)
TestTargetRecordFlag55Bit7::
    ld a, [wTargetRecord]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    ret

; for special maps copies the eight monster entries of the current screen
; (AddressOfKeyWorldMonstersEntryForCurrentScreen) to wWorkBuf + $2, removes duplicates and stores
; the count in wWorkBuf; normal maps use
; CollectUniqueEncounterIdsToWorkBuf2_ReadMapIdAndPlayerStateFlags (E-0129) (E-0340: the address in
; its name read as its RAM name; was CollectUniqueEncounterIdsToWD09F)
CollectUniqueEncounterIdsToWorkBuf2::
    ld a, [wMapType]
    bit 7, a
    jr nz, .call_address_of_key_world_monsters_entry_for
    farcall CollectUniqueEncounterIdsToWorkBuf2_ReadMapIdAndPlayerStateFlags
    ret

.call_address_of_key_world_monsters_entry_for:
    call AddressOfKeyWorldMonstersEntryForCurrentScreen
    ld de, wWorkBuf + $2
    ld b, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    and $01
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wWorkBuf + $4
    ld a, [wWorkBuf + $2]
    ld e, a
    ld a, [wWorkBuf + $3]
    ld d, a
    ld bc, $0707

.loop2:
    push bc
    push hl

.loop3:
    ld a, [hli]
    cp e
    jr nz, .next
    ld a, [hl]
    cp d
    jr nz, .next
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    ld a, $ff
    ld [hld], a
    ld [hli], a

.next:
    inc hl
    dec c
    jr nz, .loop3
    pop hl
    pop bc

.loop4:
    dec c
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, e
    and d
    cp $ff
    jr nz, .next2
    dec b
    jr nz, .loop4
    jr .skip

.next2:
    dec b
    jr nz, .loop2

.skip:
    ld de, wWorkBuf + $2
    ld hl, wWorkBuf + $2
    ld bc, $0800

.loop5:
    ld a, [hli]
    ld [de], a
    cp $ff
    ld a, [hl]
    jr nz, .next3
    cp $ff
    jr z, .next4

.next3:
    inc de
    ld [de], a
    inc de
    inc c

.next4:
    inc hl
    dec b
    jr nz, .loop5
    ld a, c
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

; HL = wKeyWorldMonsters + 2 * an index from the current map screen and the wKeyWorldAreas table
; (index $20 when bit 3 of hPlayerStateFlags is set) (E-0127)
AddressOfKeyWorldMonstersEntryForCurrentScreen::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .skip
    ld a, [wMapType]
    and $07
    cp $01
    jr z, .read_map_screen_y
    or a
    jr nz, .read_key_world_floor

.read_map_screen_y:
    ldh a, [hMapScreenY]
    srl a
    and $fe
    ld c, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    add a
    add a
    add c
    ld c, a
    jr .skip2

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    push af
    and $0f
    srl a
    and $fe
    ld c, a
    pop af
    swap a
    and $0f
    srl a
    srl a
    add c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    add a
    add a
    add a
    ld c, a
    jr .skip2

.skip:
    ld c, $20

.skip2:
    ld a, c
    add a
    ld hl, wKeyWorldMonsters
    add_a_to_hl
    ret

; adds HL to record A's HP (field $5B), capped at its max HP (field $5D), through
; AddDEToWordAtHLCappedAtBC (E-0122) (C2 from E-0326: it adds a Herb's 30-40 to MON_HP, capped at
; MON_MAX_HP)
AddHLToRecordHPCapped::
    push af
    push hl
    ld c, MON_MAX_HP
    call SRAMRecordAddressMapped
    pop de
    ld a, [hli]
    ld b, [hl]
    ld c, a
    pop af
    push bc
    ld c, MON_HP
    call SRAMRecordAddressMapped
    pop bc
    call AddDEToWordAtHLCappedAtBC
    ret

; adds HL to record A's MP (field $5F), capped at its max MP (field $61), through
; AddDEToWordAtHLCappedAtBC (E-0122)
AddHLToRecordMPCapped::
    push af
    push hl
    ld c, MON_MAX_MP
    call SRAMRecordAddressMapped
    pop de
    ld a, [hli]
    ld b, [hl]
    ld c, a
    pop af
    push bc
    ld c, MON_MP
    call SRAMRecordAddressMapped
    pop bc
    call AddDEToWordAtHLCappedAtBC
    ret

ItemApply_ATKseed_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_ATK
    ld de, $03e7
    call AddToRecordFieldWordCapped
    ret

ItemApply_DEFseed_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_DEF
    ld de, $03e7
    call AddToRecordFieldWordCapped
    ret

ItemApply_AGLseed_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_AGL
    ld de, $03e7
    call AddToRecordFieldWordCapped
    ret

ItemApply_INTseed_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_INT
    ld de, $03e7
    call AddToRecordFieldWordCapped
    ret

ItemApply_LifeAcorn_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_MAX_HP
    ld de, $03e7
    call AddToRecordFieldWordCapped
    ret

ItemApply_MysticNut_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_MAX_MP
    ld de, $03e7
    call AddToRecordFieldWordCapped
    ret

ItemApply_Quest_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_PERSONALITY
    ld e, $ff
    call AddToRecordFieldByteCapped
    ret

ItemApply_Horror_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_PERSONALITY
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

ItemApply_BeNice_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_PERSONALITY + 1
    ld e, $ff
    call AddToRecordFieldByteCapped
    ret

ItemApply_Cheater_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_PERSONALITY + 1
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

ItemApply_Smart_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_PERSONALITY + 3
    ld e, $ff
    call AddToRecordFieldByteCapped
    ret

ItemApply_Comedy_MapIndexViaPartyListKeepHL::
    call MapIndexViaPartyListKeepHL
    ld c, MON_PERSONALITY + 3
    ld e, $00
    call SubtractFromRecordFieldByteFloored
    ret

; for the record selected through wPartyList, applies ApplyMeatToRecordField6B_SubtractDEFloor0 to
; field $6B (E-0122)
ApplyMeatToRecordField6B::
    call MapIndexViaPartyListKeepHL
    push hl
    ld c, MON_WLD
    call SRAMRecordAddress
    pop de
    call ApplyMeatToRecordField6B_SubtractDEFloor0
    ret

; field C of record A: adds E, capped at the limit passed in DE's partner (AddEToByteAtHLCappedAtC)
; (E-0122)
AddToRecordFieldByteCapped::
    push hl
    push de
    call SRAMRecordAddress
    pop bc
    pop de
    call AddEToByteAtHLCappedAtC
    ret

; field C of record A: subtracts E, floored at the limit (SubtractEFromByteAtHLFlooredAtC) (E-0122)
SubtractFromRecordFieldByteFloored::
    push hl
    push de
    call SRAMRecordAddress
    pop bc
    pop de
    call SubtractEFromByteAtHLFlooredAtC
    ret

; field C of record A: adds the amount, capped at the limit (AddDEToWordAtHLCappedAtBC) (E-0122)
AddToRecordFieldWordCapped::
    push hl
    push de
    call SRAMRecordAddress
    pop bc
    pop de
    call AddDEToWordAtHLCappedAtBC
    ret

; [HL] += E, capped at C (also on overflow) (E-0122)
AddEToByteAtHLCappedAtC::
    ld a, [hl]
    add e
    jr c, .done
    cp c
    jr c, .done2

.done:
    ld a, c

.done2:
    ld [hl], a
    ret

; [HL] -= E, floored at C (also on underflow) (E-0122)
SubtractEFromByteAtHLFlooredAtC::
    ld a, [hl]
    sub e
    jr c, .done
    cp c
    jr nc, .done2

.done:
    ld a, c

.done2:
    ld [hl], a
    ret

; the word at HL += DE, capped at BC (also on overflow) (E-0124)
AddDEToWordAtHLCappedAtBC::
    push hl
    deref_hl
    add hl, de
    jr c, .skip
    ld a, l
    sub c
    ld a, h
    sbc b
    jr nc, .restore

.skip:
    ld c, l
    ld b, h

.restore:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

; the word at HL -= DE, not below 0 (field $6B is MON_WLD, E-0296)
ApplyMeatToRecordField6B_SubtractDEFloor0::
    push hl
    deref_hl
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    jr nc, .skip
    ld hl, $0000

.skip:
    ld e, l
    ld d, h
    pop hl
    ld a, e
    ld [hli], a
    ld [hl], d
    ret

; A = record (SRAMRecordAddressMapped), C = field offset: stores the low byte of the caller's HL
; (moved to C) at that field (E-0114)
StoreCToRecordField::
    push hl
    call SRAMRecordAddressMapped
    pop bc
    ld [hl], c
    ret

; A = record (SRAMRecordAddressMapped), C = field offset: stores HL (low byte first) at that field
; (E-0103)
StoreHLToRecordField::
    push hl
    call SRAMRecordAddressMapped
    pop bc
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

; MapIndexViaPartyList with HL preserved (E-0072)
MapIndexViaPartyListKeepHL::
    push hl
    call MapIndexViaPartyList
    pop hl
    ret

; toggles the sort order in wInventorySortFlags and sorts the 24 inventory slots by the key table
; InventorySortKeysA or InventorySortKeysB (empty slots last) (E-0128)
SortInventory::
    ld hl, wWorkBuf + $2
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld bc, $0018
    ld a, $ff
    call FillBytes
    ld a, [wInventorySortFlags]
    bit 7, a
    jr nz, .set_inventory_sort_flags
    xor $01

.set_inventory_sort_flags:
    res 7, a
    ld [wInventorySortFlags], a
    ld de, InventorySortKeysA
    bit 0, a
    jr z, .skip
    ld de, InventorySortKeysB

.skip:
    ld hl, wInventory
    ld b, $18

.loop:
    push bc
    push hl
    ld a, [hl]
    cp $ff
    jr nz, .skip2
    xor a

.skip2:
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
    jr nz, .loop
    ld a, $18
    ld [wWorkBuf], a

.loop2:
    ld hl, wWorkBuf + $2
    ld de, wWorkBuf + $3
    ld b, $17
    ld c, $00

.loop3:
    ld a, [de]
    cp [hl]
    jr nc, .next
    push af
    ld a, [hl]
    ld [de], a
    pop af
    ld [hl], a
    call SwapInventorySlotCWithNext

.next:
    inc de
    inc hl
    inc c
    dec b
    jr nz, .loop3
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    jr nz, .loop2
    ret

; swaps wInventory[C] and wInventory[C + 1]; HL kept (E-0118)
SwapInventorySlotCWithNext::
    push hl
    ld hl, wInventory
    ld a, c
    add_a_to_hl
    ld a, [hli]
    push af
    ld a, [hld]
    ld [hli], a
    pop af
    ld [hl], a
    pop hl
    ret

; SortInventory sorts the 24 inventory slots by the byte at $599E + item id (one sort order of
; wInventorySortFlags); 112 bytes end at InventorySortKeysB (E-0229, C1)
; record: sort key for this item id
InventorySortKeysA::
    db $ff ; id 0
    db $08 ; id 1
    db $09 ; id 2
    db $0a ; id 3
    db $0b ; id 4
    db $0c ; id 5
    db $0d ; id 6
    db $0e ; id 7
    db $0f ; id 8
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
    db $1a ; id 19
    db $1b ; id 20
    db $1c ; id 21
    db $1d ; id 22
    db $1e ; id 23
    db $1f ; id 24
    db $14 ; id 25
    db $15 ; id 26
    db $16 ; id 27
    db $17 ; id 28
    db $18 ; id 29
    db $19 ; id 30
    db $05 ; id 31
    db $06 ; id 32
    db $00 ; id 33
    db $4b ; id 34
    db $4c ; id 35
    db $4d ; id 36
    db $4e ; id 37
    db $4f ; id 38
    db $50 ; id 39
    db $01 ; id 40
    db $02 ; id 41
    db $03 ; id 42
    db $06 ; id 43
    db $25 ; id 44
    db $26 ; id 45
    db $04 ; id 46
    db $ff ; id 47
    db $51 ; id 48
    db $52 ; id 49
    db $53 ; id 50
    db $54 ; id 51
    db $55 ; id 52
    db $56 ; id 53
    db $57 ; id 54
    db $58 ; id 55
    db $59 ; id 56
    db $5a ; id 57
    db $5b ; id 58
    db $5c ; id 59
    db $5d ; id 60
    db $5e ; id 61
    db $ff ; id 62
    db $ff ; id 63
    db $27 ; id 64
    db $28 ; id 65
    db $29 ; id 66
    db $2a ; id 67
    db $2b ; id 68
    db $2c ; id 69
    db $2d ; id 70
    db $2e ; id 71
    db $2f ; id 72
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
    db $3a ; id 83
    db $3b ; id 84
    db $3c ; id 85
    db $3d ; id 86
    db $3e ; id 87
    db $3f ; id 88
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
    db $ff ; id 99
    db $ff ; id 100
    db $ff ; id 101
    db $ff ; id 102
    db $ff ; id 103
    db $ff ; id 104
    db $ff ; id 105
    db $ff ; id 106
    db $ff ; id 107
    db $ff ; id 108
    db $ff ; id 109
    db $ff ; id 110
    db $ff ; id 111

; the key table of the other sort order of SortInventory; 112 bytes (E-0229, C1)
InventorySortKeysB::
    db $ff ; id 0
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
    db $0a ; id 11
    db $0b ; id 12
    db $1e ; id 13
    db $1f ; id 14
    db $20 ; id 15
    db $21 ; id 16
    db $22 ; id 17
    db $23 ; id 18
    db $18 ; id 19
    db $19 ; id 20
    db $1a ; id 21
    db $1b ; id 22
    db $1c ; id 23
    db $1d ; id 24
    db $12 ; id 25
    db $13 ; id 26
    db $14 ; id 27
    db $15 ; id 28
    db $16 ; id 29
    db $17 ; id 30
    db $4e ; id 31
    db $4f ; id 32
    db $49 ; id 33
    db $0c ; id 34
    db $0d ; id 35
    db $0e ; id 36
    db $0f ; id 37
    db $10 ; id 38
    db $11 ; id 39
    db $4a ; id 40
    db $4b ; id 41
    db $4c ; id 42
    db $50 ; id 43
    db $24 ; id 44
    db $25 ; id 45
    db $4d ; id 46
    db $ff ; id 47
    db $51 ; id 48
    db $52 ; id 49
    db $53 ; id 50
    db $54 ; id 51
    db $55 ; id 52
    db $56 ; id 53
    db $57 ; id 54
    db $58 ; id 55
    db $59 ; id 56
    db $5a ; id 57
    db $5b ; id 58
    db $5c ; id 59
    db $5d ; id 60
    db $5e ; id 61
    db $ff ; id 62
    db $ff ; id 63
    db $26 ; id 64
    db $27 ; id 65
    db $28 ; id 66
    db $29 ; id 67
    db $2a ; id 68
    db $2b ; id 69
    db $2c ; id 70
    db $2d ; id 71
    db $2e ; id 72
    db $2f ; id 73
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
    db $3a ; id 84
    db $3b ; id 85
    db $3c ; id 86
    db $3d ; id 87
    db $3e ; id 88
    db $3f ; id 89
    db $40 ; id 90
    db $41 ; id 91
    db $42 ; id 92
    db $43 ; id 93
    db $44 ; id 94
    db $45 ; id 95
    db $46 ; id 96
    db $47 ; id 97
    db $48 ; id 98
    db $ff ; id 99
    db $ff ; id 100
    db $ff ; id 101
    db $ff ; id 102
    db $ff ; id 103
    db $ff ; id 104
    db $ff ; id 105
    db $ff ; id 106
    db $ff ; id 107
    db $ff ; id 108
    db $ff ; id 109
    db $ff ; id 110
    db $ff ; id 111

; monster id = wSpeciesIdLo/Hi: HL = wSpeciesFlags + id / 8, B = the mask 1 << (id & 7)
; (TestSpeciesFlag_Data); C = A = [HL] & B, so Z is set when the species' bit is clear (E-0070)
TestSpeciesFlag::
    ld a, [wSpeciesIdLo]
    ld c, a
    ld a, [wSpeciesIdHi]
    ld b, a
    ld a, c
    and $07
    ld hl, TestSpeciesFlag_Data
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
    and b
    ld c, a
    ret

TestSpeciesFlag_Data::
    db $01, $02, $04, $08, $10, $20, $40, $80

; sets the bit of monster id wSpeciesIdLo/Hi in wSpeciesFlags (TestSpeciesFlag) and clears the high
; nibble of wSpeciesFlagCount (E-0070)
SetSpeciesFlag::
    call TestSpeciesFlag
    ld a, b
    or [hl]
    ld [hl], a
    push af
    ld a, [wSpeciesFlagCount]
    and $0f
    ld [wSpeciesFlagCount], a
    pop af
    ret

; zeroes the 11 per-family counters at wWorkBuf, then for monster ids 0-372 ($175 is the end) skips
; unused ids (family $FF) and adds 1 to wWorkBuf[family] when the species' flag is set
; (TestSpeciesFlag) or, when it is not, when TestBitInFieldAtArg3 finds the id in the list at
; wMonsterLibraryBuf (wArg5 not $FF). Leaves wSpeciesIdLo/Hi = 373 (E-0070) (C2 from E-0329 for the
; flag source: the library's 11 counts equal the flagged species per family; the list was empty)
CountSpeciesPerFamilyFlaggedOrListed::
    xor a
    ld hl, wWorkBuf
    ld bc, $000b
    call FillBytes
    xor a
    ld [wSpeciesIdLo], a
    ld [wSpeciesIdHi], a

.loop:
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    cp $ff
    jr z, .read_species_id_lo
    ld de, wWorkBuf
    add e
    ld e, a
    jr nc, .call_test_species_flag
    inc d

.call_test_species_flag:
    call TestSpeciesFlag
    jr nz, .skip
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
    cp $ff
    jr z, .skip
    jr .read_species_id_lo

.skip:
    ld a, [de]
    inc a
    ld [de], a

.read_species_id_lo:
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
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    jr c, .loop
    ret

BattleEnd_Step3_Sub01_LoadSpeciesFamily::
    xor a
    ld hl, wWorkBuf
    ld bc, $000b
    call FillBytes
    xor a
    ld [wSpeciesIdLo], a
    ld [wSpeciesIdHi], a

.loop:
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    cp $ff
    jr z, .read_species_id_lo
    ld de, wWorkBuf
    add e
    ld e, a
    jr nc, .call_test_species_flag
    inc d

.call_test_species_flag:
    call TestSpeciesFlag
    jr z, .read_species_id_lo
    ld a, [de]
    inc a
    ld [de], a

.read_species_id_lo:
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
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    jr c, .loop
    ret

BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc::
    ld a, $01
    ld [wBattleFoeCount], a
    ld a, [wLinkMode]
    or a
    jp nz, .set_display_slot_to_FF
    ld a, [wBattleKind]
    cp $03
    jp z, .set_display_slot_to_FF
    cp $04
    jp z, .set_display_slot_to_FF
    cp $05
    jp z, .set_display_slot_to_FF
    cp $08
    jp nc, .set_display_slot_to_FF
    ld a, [wDisplaySlot]
    cp $ff
    jp z, .set_display_slot_to_FF
    cp $04
    jp c, .set_display_slot_to_FF
    cp $07
    jp nc, .set_display_slot_to_FF
    and $03
    ld hl, wFoeJoinClass1
    add_a_to_hl
    ld a, [hl]
    cp $07
    jp z, .set_display_slot_to_FF
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    call TestSpeciesFlag
    ld de, BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc_Data2
    jr nz, .read_battle_meter
    farcall LoadSpeciesRecord
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $c8
    call DivideHLByA
    ld b, a
    ld a, [wSpeciesRecord + SPECIES_JOIN_CLASS]
    cp $07
    jp z, .set_display_slot_to_FF
    ld hl, JoinChanceByClass
    add_a_to_hl
    ld a, [hl]
    cp b
    jp nc, .return
    ld a, [wBattleEndFlag]
    or a
    jp nz, .return
    ld de, BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc_Data1

.read_battle_meter:
    ld a, [wBattleMeter]
    ld c, a
    ld a, [wBattleMeter + $1]
    ld b, a
    ld a, [wDisplaySlot]
    and $03
    ld hl, wFoeJoinClass1
    add_a_to_hl
    ld a, [hl]
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld h, b
    ld l, c
    or a
    jp z, .return
    cp $07
    jp z, .set_display_slot_to_FF
    ld a, [wBattleEndFlag]
    or a
    jp nz, .return
    ld a, [de]
    cp $01
    jr z, .skip2
    cp $02
    jr z, .skip3
    cp $03
    jr z, .skip4
    cp $04
    jr z, .skip5
    cp $05
    jr z, .call_divide_hl_by_a
    cp $06
    jr z, .skip6
    cp $11
    jr z, .skip7
    cp $12
    jr z, .skip8
    cp $13
    jr z, .skip9
    cp $14
    jr z, .skip9
    cp $15
    jr z, .skip9
    cp $16
    jr z, .call_divide_hl_by_a2
    jp .set_display_slot_to_FF

.skip2:
    add hl, hl
    add hl, hl
    add hl, bc
    jr .call_next_table_byte

.skip3:
    add hl, hl
    jr .call_next_table_byte

.skip4:
    jr .call_next_table_byte

.skip5:
    srl h
    rr l
    jr .call_next_table_byte

.call_divide_hl_by_a:
    ld a, $05
    call DivideHLByA
    jr .call_next_table_byte

.skip6:
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr .call_next_table_byte

.skip7:
    jr .call_next_table_byte

.skip8:
    srl h
    rr l
    srl h
    rr l
    jr .call_next_table_byte

.skip9:
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr .call_next_table_byte

.call_divide_hl_by_a2:
    ld a, $14
    call DivideHLByA

.call_next_table_byte:
    push hl
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $5b
    call DivideHLByA
    add $0a
    ld c, a
    ld b, $00
    pop hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jr nz, .set_display_slot_to_FF
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $64
    call DivideHLByA
    inc a
    cp $5b
    jr c, .return

.set_display_slot_to_FF:
    ld a, $ff
    ld [wDisplaySlot], a

.return:
    ret

; join chance out of 200 per join-chance class 0-7: 100, 50, 24, 10, 6, 2, 1, 0; the defeated
; monster may join when (random mod 200) is below the entry for SPECIES_JOIN_CLASS
JoinChanceByClass::
    db $64, $32, $18, $0a, $06, $02, $01, $00

BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc_Data1::
    db $00, $01, $02, $03, $04, $05, $06, $07

BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc_Data2::
    db $00, $11, $12, $13, $14, $15, $16, $07

; by wBattleSubStep: copies the defeated monster's name and asks 'got up, looking hopeful. Allow 0
; to join you?' (category 5 string $0B), then the follow-ups ($0D 'But there is no more room!
; Release a monster to make room?', $0E 'Which will you choose?')
BattleEnd_AskToJoin::
    ld a, [wBattleSubStep]
    jumptable
    dw BattleEnd_AskToJoin_CopyBattleMonsterNameWithLetterSuffix
    dw BattleEnd_AskToJoin_WaitTextFlags
    dw BattleEnd_AskToJoin_ShowHeroGotUpLooking
    dw BattleEnd_AskToJoin_LoadCursorTileAndRect7826
    dw BattleEnd_AskToJoin_ShowHeroDepartedSadly
    dw BattleEnd_AskToJoin_WriteVRAMByte
    dw BattleEnd_AskToJoin_ShowButThereIsNo
    dw BattleEnd_AskToJoin_LoadCursorTileAndRect7826
    dw BattleEnd_AskToJoin_ShowHeroDepartedSadly
    dw BattleEnd_AskToJoin_ShowWhichWillYouChoose
    dw BattleEnd_AskToJoin_BuildBattleMenuScreen_733F
    dw BattleEnd_AskToJoin_ShowYouHaveNoEggs
    dw BattleEnd_AskToJoin_ShowChooseAMonsterTo
    dw BattleEnd_AskToJoin_MovePagedListCursor
    dw BattleEnd_AskToJoin_WriteVRAMByte_CopyRectRecord787EAndPlaySound6C
    dw BattleEnd_AskToJoin_MovePagedListCursor_AdvanceBattleSubStep
    dw BattleEnd_AskToJoin_ClampRecordListPageCursor5
    dw BattleEnd_AskToJoin_CopyRectRecord796FToScreenBufferAndPlaySound6C
    dw BattleEnd_AskToJoin_WriteVRAMByte_YouCan
    dw BattleEnd_AskToJoin_AdvanceBattleSubStep
    dw BattleEnd_AskToJoin_ShowGWasSetFree
    dw BattleEnd_AskToJoin_WaitTextFlags_SetArg1
    dw BattleEnd_AskToJoin_ShowChooseAnEggTo
    dw BattleEnd_AskToJoin_MovePagedListCursor_DrawFourListEntriesForPageListPage
    dw BattleEnd_AskToJoin_BuildBattleMenuScreen_733F_CopyRectRecord78AAToScreenBuffer
    dw BattleEnd_AskToJoin_MovePagedListCursor_Case19_AdvanceBattleSubStep
    dw BattleEnd_AskToJoin_ClampRecordListPageCursor4
    dw BattleEnd_AskToJoin_CopyRectRecord78AAToScreenBuffer
    dw BattleEnd_AskToJoin_WaitTextFlags_Case1C_SetArg1

BattleEnd_AskToJoin_CopyBattleMonsterNameWithLetterSuffix::
    ld hl, wBattleSubStep
    inc [hl]
    ld de, wTextBuf0
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, [wBattleKind]
    cp $08
    jr nc, .set_string_index_to_1E
    and $01
    jr z, .call_count_records_by_field6_e
    farcall KeyWorldAreaEncounterIndex
    ldh a, [hTemp0]
    or a
    jr nz, .call_count_records_by_field6_e

.set_string_index_to_1E:
    ld a, $1e
    ld [wStringIndex], a ; '0 got up, looking hopeful. But'
    call ShowStringCategory5_Bank16
    ret

.call_count_records_by_field6_e:
    call CountRecordsByField6E
    xor a
    ld [wSubMenuCursor2], a
    ld [wMenuOption], a
    ld [wCommandCursorMax], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_ShowHeroGotUpLooking::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0b
    ld [wStringIndex], a ; '0 got up, looking hopeful. Allow'
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_LoadCursorTileAndRect7826::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld de, wScreenTileBuffer + $10e
    ld hl, vBGMap0 + $10e
    lb bc, $06, $05
    call CopyRect32StrideToVRAM_Bank16
    xor a
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

BattleEnd_AskToJoin_ShowHeroDepartedSadly::
    ld de, wMenuState
    ld hl, BattleEnd_AskToJoin_ShowHeroDepartedSadly_Data
    call SetDEFlagOnBButton
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [de]
    or a
    ret z
    ld de, wTextBuf0
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, $0c
    ld [wStringIndex], a ; '0 departed sadly…'
    call ShowStringCategory5_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_WriteVRAMByte::
    ld a, $bc
    ld hl, vBGMap0 + $12f
    call WriteVRAMByte
    ld a, [wFarmLevel]
    ld hl, BattleEnd_AskToJoin_WriteVRAMByte_Data
    add_a_to_hl
    ld a, [wTemp0]
    ld b, a
    ld a, [wTemp1]
    add b
    cp [hl]
    jr c, .skip
    ld hl, wBattleSubStep
    inc [hl]
    ret

.skip:
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_ShowButThereIsNo::
    ld a, $0d
    ld [wStringIndex], a ; 'But there is no more room!'
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_ShowWhichWillYouChoose::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0e
    ld [wStringIndex], a ; 'Which will you choose?'
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_BuildBattleMenuScreen_733F::
    ld a, [wTextFlags]
    or a
    ret nz
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $6c
    call QueueSoundEffect
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    xor a
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

BattleEnd_AskToJoin_ShowYouHaveNoEggs::
    ld de, wMenuState
    ld hl, BattleEnd_AskToJoin_ShowYouHaveNoEggs_Data
    call SetDEFlagOnBButton
    ret z
    ld a, [wJoypadPressed]
    and $02
    jr nz, .call_build_battle_menu_screen_733_f
    ld a, [de]
    ld e, a
    xor a
    ld [wMenuState], a
    ld a, [wSubMenuCursor2]
    ld [wListPage], a
    ld hl, wBattleSubStep
    inc [hl]
    ld a, e
    or a
    ret z
    call CountRecordsByField6E
    ld a, [wTemp1]
    or a
    jr nz, .set_battle_sub_step_to_16
    ld a, $0f
    ld [wStringIndex], a ; 'You have no eggs.'
    call ShowStringCategory5_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

.set_battle_sub_step_to_16:
    ld a, $16
    ld [wBattleSubStep], a
    ret

.call_build_battle_menu_screen_733_f:
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld a, $06
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_ShowChooseAMonsterTo::
    ld hl, wListEntries
    ld bc, $001e
    ld a, $ff
    call FillBytes
    farcall CopyRectRecord796FToScreenBufferAndPlaySound6C
    call ListPartyAndStoredRecordsForPage
    call DrawRecordListPageWithNumbers
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    lb bc, $08, $0b
    call CopyRect32StrideToVRAM_Bank16
    ld hl, vBGMap0 + $12b
    ld a, $bc
    call WriteVRAMByte
    ld a, $11
    ld [wStringIndex], a ; 'Choose a monster to release.'
    call ShowStringCategory5Immediate_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_MovePagedListCursor::
    ld de, wMenuState
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Data
    call MovePagedListCursor
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_joypad_pressed
    call DrawRecordListPageWithNumbers
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, [wListPage]
    ld [wSubMenuCursor2], a
    call ShowRecordNameString12
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, [wListPage]
    ld [wSubMenuCursor2], a
    ld a, $09
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_WriteVRAMByte_CopyRectRecord787EAndPlaySound6C::
    ld a, [wMenuState]
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $bb
    ld [wScreenTileBuffer + $12d], a
    ld de, wScreenTileBuffer + $10c
    ld hl, vBGMap0 + $10c
    lb bc, $08, $05
    call CopyRect32StrideToVRAM_Bank16
    xor a
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

BattleEnd_AskToJoin_MovePagedListCursor_AdvanceBattleSubStep::
    ld de, wMenuSubState
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Case0F_Data
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wMenuSubState]
    and $01
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, $1f
    ld [wScreenTileBuffer + $10c], a
    ld a, $25
    ld [wScreenTileBuffer + $12c], a
    ld a, $2b
    ld [wScreenTileBuffer + $14c], a
    ld a, $31
    ld [wWindowTileBuffer + $4], a
    ld a, $37
    ld [wWindowTileBuffer + $24], a
    ld a, $c3
    ld [wScreenTileBuffer + $10d], a
    ld [wScreenTileBuffer + $12d], a
    ld [wScreenTileBuffer + $14d], a
    ld [wWindowTileBuffer + $5], a
    ld [wWindowTileBuffer + $25], a
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $bc
    ld [wScreenTileBuffer + $12b], a
    ld de, wScreenTileBuffer + $10a
    ld hl, vBGMap0 + $10a
    lb bc, $0a, $05
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wSubMenuCursor2]
    ld [wListPage], a
    ld a, $0c
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_ClampRecordListPageCursor5::
    ld a, [wTemp0]
    ld [wListCount], a
    ld a, [wMenuState]
    ld [wListCursor], a
    ld a, [wSubMenuCursor2]
    ld [wListPageIndex], a
    farcall ClampRecordListPageCursor5
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0c
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    farcall ListRecordsInUseWithByte6EClear
    ld hl, wScreenTileBuffer
    ld bc, $02d0
    ld a, $c3
    call FillBytes
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_AskToJoin_CopyRectRecord796FToScreenBufferAndPlaySound6C::
    farcall CopyRectRecord796FToScreenBufferAndPlaySound6C
    ld a, [wListCursor]
    ld [wMenuState], a
    ld hl, BattleEnd_AskToJoin_CopyRectRecord796FToScreenBufferAndPlaySound6C_Data
    add a
    add_a_to_hl
    deref_hl
    ld [hl], $bc
    ld a, [wListPageIndex]
    ld [wSubMenuCursor2], a
    ld [wListPage], a
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $bb
    ld [wScreenTileBuffer + $12d], a
    call ListPartyAndStoredRecordsForPage
    call DrawRecordListPageWithNumbers
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    lb bc, $14, $12
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
    ld a, $0f
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_WriteVRAMByte_YouCan::
    ld a, $bc
    ld hl, vBGMap0 + $16d
    call WriteVRAMByte
    ld a, [wSubMenuCursor2]
    ld b, a
    add a
    add a
    add b
    ld b, a
    ld a, [wMenuState]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld b, [hl]
    ld a, [wPartyCount]
    cp $01
    jr nz, .check_party_count
    ld a, [wPartyList]
    cp b
    jr nz, .skip

.loop:
    ld a, $15
    ld [wStringIndex], a ; 'You can't travel all alone.'
    call ShowStringCategory5_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $02
    jr nz, .read_battle_slot_out
    ld a, [wBattleSlotOut]
    ld c, a
    ld a, [wBattleSlotOut + $1]
    or c
    jr z, .skip
    ld hl, wBattleSlotOut
    ld a, [wPartyList]
    cp b
    jr z, .loop2
    ld hl, wBattleSlotOut + $1
    ld a, [wPartyList + $1]
    cp b
    jr z, .loop2
    jr .skip

.loop2:
    ld a, [hl]
    or a
    jr z, .loop
    jr .skip

.read_battle_slot_out:
    ld a, [wBattleSlotOut]
    ld c, a
    ld a, [wBattleSlotOut + $1]
    add c
    ld a, [wBattleSlotOut + $2]
    add c
    cp $02
    jr c, .skip
    ld hl, wBattleSlotOut
    ld a, [wPartyList]
    cp b
    jr z, .loop2
    ld hl, wBattleSlotOut + $1
    ld a, [wPartyList + $1]
    cp b
    jr z, .loop2
    ld hl, wBattleSlotOut + $2
    ld a, [wPartyList + $2]
    cp b
    jr z, .loop2

.skip:
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_AdvanceBattleSubStep::
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_ShowGWasSetFree::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, $13
    ld [wStringIndex], a ; 'G was set free in the'
    call ShowStringCategory5_Bank16
    ret

BattleEnd_AskToJoin_WaitTextFlags_SetArg1::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wSubMenuCursor2]
    ld b, a
    add a
    add a
    add b
    ld b, a
    ld a, [wMenuState]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    pop hl
    ld a, [wPartyCount]
    ld [wBattlePartyCount], a
    cp $03
    jr z, .read_party_list
    cp $02
    jr z, .set_party_list_to_FF
    ld a, $ff
    ld [wPartyList + $1], a

.set_party_list_to_FF:
    ld a, $ff
    ld [wPartyList + $2], a

.read_party_list:
    ld a, [wPartyList]
    ld [wTemp0], a
    ld a, [wPartyList + $1]
    ld [wTemp1], a
    ld a, [wPartyList + $2]
    ld [wMenuRowCount], a
    call RunFunc710FForPartyMembers
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_ShowChooseAnEggTo::
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord7848ToScreenBuffer
    ld a, $bc
    ld [wWindowTileBuffer + $3], a
    farcall CopyRectRecord78AAToScreenBuffer
    ld a, $6c
    call QueueSoundEffect
    ld a, $16
    ld [wStringIndex], a ; 'Choose an egg to abandon.'
    call ShowStringCategory5Immediate_Bank16
    call CountRecordsByField6E
    call ListRecordsWithField6EToListEntries
    ld a, [wTemp1]
    ld [wListCount], a
    dec a
    ld b, a
    and $03
    inc a
    ld [wListLastPageSize], a
    ld a, b
    and $fc
    rrca
    rrca
    ld [wCommandPageCount], a
    inc a
    ld [wListPageCount], a
    cp $02
    jr c, .set_list_page_size_to_04
    add $e0
    ld [wWindowTileBuffer + $22], a
    ld a, $c5
    ld [wWindowTileBuffer + $1f], a
    ld a, $be
    ld [wWindowTileBuffer + $21], a
    ld a, $c6
    ld [wWindowTileBuffer + $23], a

.set_list_page_size_to_04:
    ld a, $04
    ld [wListPageSize], a
    ld a, [wMenuOption]
    ld [wListPage], a
    ld a, [wCommandCursorMax]
    ld [wMenuState], a
    call DrawFourListEntriesForPageListPage
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AskToJoin_MovePagedListCursor_DrawFourListEntriesForPageListPage::
    ld de, wMenuState
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Case17_Data
    call MovePagedListCursor
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_joypad_pressed
    call DrawFourListEntriesForPageListPage
    ld hl, vBGMap0 + $ab
    ld de, wScreenTileBuffer + $ab
    lb bc, $01, $07
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wWindowTileBuffer + $20]
    ld hl, vBGMap0 + $188
    call WriteVRAMByte
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, [wMenuState]
    ld [wCommandCursorMax], a
    ld a, [wListPage]
    ld [wMenuOption], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_BuildBattleMenuScreen_733F_CopyRectRecord78AAToScreenBuffer::
    call BuildBattleMenuScreen_733F
    farcall CopyRectRecord78AAToScreenBuffer
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, [wListPageCount]
    cp $02
    jr c, .call_draw_four_list_entries_for_page_list
    add $e0
    ld [wWindowTileBuffer + $22], a
    ld a, $c5
    ld [wWindowTileBuffer + $1f], a
    ld a, $be
    ld [wWindowTileBuffer + $21], a
    ld a, $c6
    ld [wWindowTileBuffer + $23], a

.call_draw_four_list_entries_for_page_list:
    call DrawFourListEntriesForPageListPage
    ld a, [wCommandCursorMax]
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Case17_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $29
    ld h, a
    ld [hl], $bc
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    xor a
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

BattleEnd_AskToJoin_MovePagedListCursor_Case19_AdvanceBattleSubStep::
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Case0F_Data
    ld de, wMenuSelectedMember
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [de]
    or a
    ret z
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wMenuOption]
    add a
    add a
    ld b, a
    ld a, [wCommandCursorMax]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
    call SRAMRecordAddress
    deref_hl
    ld a, h
    add $02
    ld h, a
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, $18
    ld [wStringIndex], a ; 'G's egg was abandoned.'
    call ShowStringCategory5_Bank16
    xor a
    ld [rRAMG], a
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, $16
    ld [wBattleSubStep], a
    ret

BattleEnd_AskToJoin_ClampRecordListPageCursor4::
    ld a, [wMenuState]
    ld [wListCursor], a
    ld a, [wMenuOption]
    ld [wListPageIndex], a
    farcall ClampRecordListPageCursor4
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0d
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    farcall ListRecordsInUseWithByte6ESet
    ld hl, wScreenTileBuffer
    ld bc, $02d0
    ld a, $c3
    call FillBytes
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_AskToJoin_CopyRectRecord78AAToScreenBuffer::
    farcall CopyRectRecord78AAToScreenBuffer
    ld a, [wListCursor]
    ld [wMenuState], a
    ld [wCommandCursorMax], a
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Case17_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $29
    ld h, a
    ld [hl], $bc
    ld a, [wListPageIndex]
    ld [wMenuOption], a
    ld [wListPage], a
    farcall CopyRectRecord787EAndPlaySound6C
    ld a, $bb
    ld [wScreenTileBuffer + $12d], a
    ld a, [wCommandPageCount]
    inc a
    cp $02
    jr c, .call_list_records_with_field6_e_to_list
    add $e0
    ld [wWindowTileBuffer + $22], a
    ld a, $c5
    ld [wWindowTileBuffer + $1f], a
    ld a, $be
    ld [wWindowTileBuffer + $21], a
    ld a, $c6
    ld [wWindowTileBuffer + $23], a

.call_list_records_with_field6_e_to_list:
    call ListRecordsWithField6EToListEntries
    call DrawFourListEntriesForPageListPage
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    lb bc, $14, $12
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

BattleEnd_AskToJoin_WaitTextFlags_Case1C_SetArg1::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wMenuOption]
    add a
    add a
    ld b, a
    ld a, [wCommandCursorMax]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; runs MovePagedListCursor; unless A is pressed, writes 1 at DE when B is pressed (E-0122)
SetDEFlagOnBButton::
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and $01
    ret nz
    ld a, [wJoypadPressed]
    and $02
    ret z
    ld a, $01
    ld [de], a
    ret

; counts the first BattleEnd_AskToJoin_WriteVRAMByte_Data[wFarmLevel] SRAM records: wTemp1 = those
; with field $6E set, wTemp0 = the others (E-0125)
CountRecordsByField6E::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wFarmLevel]
    ld hl, BattleEnd_AskToJoin_WriteVRAMByte_Data
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld de, $0000

.loop:
    ld a, [hl]
    or a
    jr z, .skip
    push hl
    ld a, l
    add $6e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    pop hl
    or a
    jr z, .next
    inc d
    jr .skip

.next:
    inc e

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop
    ld a, e
    ld [wTemp0], a
    ld a, d
    ld [wTemp1], a
    xor a
    ld [rRAMG], a
    ret

; lists the party records and then the stored records (state 1, field $6E clear) in wListEntries and
; sets the page counts wListPageSize-wListLastPageSize (E-0130)
ListPartyAndStoredRecordsForPage::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    xor a
    ld [wTemp0], a
    ld de, wListEntries
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [wTemp0]
    inc a
    ld [wTemp0], a
    dec b
    jr nz, .loop
    ld a, [wFarmLevel]
    ld hl, BattleEnd_AskToJoin_WriteVRAMByte_Data
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld c, $00

.loop2:
    ld a, [hl]
    cp $01
    jr nz, .next
    push hl
    ld a, l
    add $6e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    pop hl
    or a
    jr nz, .next
    ld a, c
    ld [de], a
    inc de
    ld a, [wTemp0]
    inc a
    ld [wTemp0], a

.next:
    inc c
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop2
    xor a
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
    or a
    jr nz, .set_screen_tile_buffer_to_B6
    ld a, $e1
    ld [wScreenTileBuffer + $20], a
    ld a, [wPartyCount]
    cp $01
    jr z, .set_screen_tile_buffer_to_B62
    ld a, $e2
    ld [wScreenTileBuffer + $60], a
    ld a, [wPartyCount]
    cp $02
    jr z, .set_screen_tile_buffer_to_B63
    ld a, $e3
    ld [wScreenTileBuffer + $a0], a
    jr .check_list_page_count

.set_screen_tile_buffer_to_B6:
    ld a, $b6
    ld [wScreenTileBuffer + $20], a

.set_screen_tile_buffer_to_B62:
    ld a, $b6
    ld [wScreenTileBuffer + $60], a

.set_screen_tile_buffer_to_B63:
    ld a, $b6
    ld [wScreenTileBuffer + $a0], a

.check_list_page_count:
    ld a, [wListPageCount]
    cp $02
    jr c, .return
    ld a, $c5
    ld [wScreenTileBuffer + $142], a
    ld a, $be
    ld [wScreenTileBuffer + $144], a
    ld a, $c6
    ld [wScreenTileBuffer + $146], a
    ld a, [wSubMenuCursor2]
    add $e1
    ld [wScreenTileBuffer + $143], a
    ld a, [wListPageCount]
    add $e0
    ld [wScreenTileBuffer + $145], a

.return:
    ret

; fills wListEntries ($1E bytes) with $FF, then lists the indexes of the first
; BattleEnd_AskToJoin_WriteVRAMByte_Data[wFarmLevel] SRAM records that have field $6E set (E-0127)
ListRecordsWithField6EToListEntries::
    ld hl, wListEntries
    ld bc, $001e
    ld a, $ff
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wFarmLevel]
    ld hl, BattleEnd_AskToJoin_WriteVRAMByte_Data
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld de, wListEntries
    ld c, $00

.loop:
    ld a, [hl]
    or a
    jr z, .next
    push hl
    ld a, l
    add $6e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    pop hl
    or a
    jr z, .next
    ld a, c
    ld [de], a
    inc de

.next:
    inc c
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; up/down/left/right move the cursor at [DE] and the page wListPage within the page sizes
; wListPageSize/wListLastPageSize and page count wListPageCount (E-0130)
MovePagedListCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    call BlankTileAtTableEntryDE
    ld a, [de]
    sub $01
    jp nc, .call_draw_cursor_tile_at_table_entry_de
    ld a, [wListPageCount]
    cp $02
    jr c, .check_list_last_page_size
    ld b, a
    ld a, [wListPage]
    inc a
    cp b
    jr nz, .check_list_page_size

.check_list_last_page_size:
    ld a, [wListLastPageSize]
    dec a
    jp .call_draw_cursor_tile_at_table_entry_de

.check_list_page_size:
    ld a, [wListPageSize]
    dec a
    jr .call_draw_cursor_tile_at_table_entry_de

.check_bit7:
    bit 7, a
    jr z, .check_list_page_count
    call BlankTileAtTableEntryDE
    ld a, [wListPage]
    inc a
    ld b, a
    ld a, [wListPageCount]
    cp b
    jr nz, .read_list_page_size
    ld a, [wListLastPageSize]
    jr .skip

.read_list_page_size:
    ld a, [wListPageSize]

.skip:
    ld b, a
    ld a, [de]
    inc a
    cp b
    jr c, .call_draw_cursor_tile_at_table_entry_de
    xor a
    jr .call_draw_cursor_tile_at_table_entry_de

.check_list_page_count:
    ld a, [wListPageCount]
    cp $02
    jr c, .check_frame_counter_lo
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_bit4
    call BlankTileAtTableEntryDE
    ld a, [wListPage]
    dec a
    cp $ff
    jr nz, .set_list_page
    ld a, [wListPageCount]
    dec a
    jr .set_list_page

.check_bit4:
    bit 4, a
    jr z, .check_frame_counter_lo
    call BlankTileAtTableEntryDE
    ld a, [wListPageCount]
    ld b, a
    ld a, [wListPage]
    inc a
    cp b
    jr c, .set_list_page
    xor a
    jr .set_list_page

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    ret z
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, BlankTileAtTableEntryDE
    jr DrawCursorTileAtTableEntryDE

.call_draw_cursor_tile_at_table_entry_de:
    ld [de], a
    call DrawCursorTileAtTableEntryDE
    ld a, $02
    ld [wFrameCounterLo], a
    ret

.set_list_page:
    ld [wListPage], a
    ld b, a
    ld a, [wListPageCount]
    dec a
    cp b
    jr nz, .call_draw_cursor_tile_at_table_entry_de2
    ld a, [wListLastPageSize]
    ld b, a
    ld a, [de]
    cp b
    jr c, .call_draw_cursor_tile_at_table_entry_de2
    ld a, b
    dec a
    ld [de], a

.call_draw_cursor_tile_at_table_entry_de2:
    call DrawCursorTileAtTableEntryDE
    xor a
    ld [wFrameCounterLo], a
    ret

; HL = table of VRAM addresses, [DE] = index: writes tile $C3 at that entry's address
; (WriteVRAMByte); HL kept (E-0103)
BlankTileAtTableEntryDE::
    ld a, [de]
    push hl
    add a
    add_a_to_hl
    deref_hl
    ld a, $c3
    call WriteVRAMByte
    pop hl
    ret

; HL = table of VRAM addresses, [DE] = index: writes the cursor tile $BB at that entry's address
; (WriteVRAMByte); HL kept (E-0118)
DrawCursorTileAtTableEntryDE::
    ld a, [de]
    push hl
    add a
    add_a_to_hl
    deref_hl
    ld a, $bb
    call WriteVRAMByte
    pop hl
    ret

BattleEnd_AskToJoin_CopyRectRecord796FToScreenBufferAndPlaySound6C_Data::
    db $b9, $c1, $f9, $c1, $39, $c2, $79, $c2, $b9, $c2

BattleEnd_AskToJoin_ShowHeroDepartedSadly_Data::
    db $2f, $99, $6f, $99

BattleEnd_AskToJoin_MovePagedListCursor_Case0F_Data::
    db $2d, $99, $6d, $99

BattleEnd_AskToJoin_MovePagedListCursor_Case17_Data::
    db $a1, $98, $e1, $98, $21, $99, $61, $99

BattleEnd_AskToJoin_MovePagedListCursor_Data::
    db $21, $98, $61, $98, $a1, $98, $e1, $98, $21, $99

BattleEnd_AskToJoin_ShowYouHaveNoEggs_Data::
    db $2b, $99, $6b, $99

; shows five record names of page wListPage at vTiles2 + $3B0 and the slot numbers ($E1-$E3) or
; marks ($B6) beside them (E-0128)
DrawRecordListPageWithNumbers::
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
    add a
    add a
    add b
    ld b, a
    ld hl, wListEntries
    add_a_to_hl
    ld b, $05
    ld de, vTiles2 + $3b0
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
    or a
    jr nz, .call_write_vram_byte
    ld a, $e1
    ld hl, vBGMap0 + $20
    call WriteVRAMByte
    ld a, [wPartyCount]
    cp $01
    jr z, .call_write_vram_byte2
    ld a, $e2
    ld hl, vBGMap0 + $60
    call WriteVRAMByte
    ld a, [wPartyCount]
    cp $02
    jr z, .call_write_vram_byte3
    ld a, $e3
    ld hl, vBGMap0 + $a0
    call WriteVRAMByte
    jr .check_list_page_count

.call_write_vram_byte:
    ld a, $b6
    ld hl, vBGMap0 + $20
    call WriteVRAMByte

.call_write_vram_byte2:
    ld a, $b6
    ld hl, vBGMap0 + $60
    call WriteVRAMByte

.call_write_vram_byte3:
    ld a, $b6
    ld hl, vBGMap0 + $a0
    call WriteVRAMByte

.check_list_page_count:
    ld a, [wListPageCount]
    cp $02
    jr c, .return
    ld a, [wListPage]
    add $e1
    ld hl, vBGMap0 + $143
    call WriteVRAMByte

.return:
    ret

; draws four values from wBattleArg0 at vTiles2 + $3B0 with size $0105 (ShowRecordNamesListFromHL),
; preserving the window settings (E-0121)
DrawBattleArg0ValuesAtTiles23B0::
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
    ld de, vTiles2 + $3b0
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

; for B record indexes at HL shows each record name (or an empty one for $FF) as string 5 of
; category 8 at successive window rows from DE (E-0127)
ShowRecordNamesListFromHL::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a

.loop:
    ld a, [hli]
    push bc
    ld c, $01
    push hl
    push de
    cp $ff
    jr nz, .call_sram_record_address
    ld de, wTextBuf0
    jr .skip

.call_sram_record_address:
    call SRAMRecordAddress
    ld b, $0a
    ld de, wTextBuf0

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2

.skip:
    ld a, $f0
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
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; for the four entries of WD789 page wListPage runs
; DrawFourListEntriesForPageListPage_SRAMRecordAddress with wBattleArg0 = 0-3, draws the page digit,
; then restores the default window (E-0121)
DrawFourListEntriesForPageListPage::
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wListPage]
    add a
    add a
    ld hl, wListEntries
    add_a_to_hl
    ld a, $00
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_SRAMRecordAddress
    inc hl
    ld a, $01
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_SRAMRecordAddress
    inc hl
    ld a, $02
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_SRAMRecordAddress
    inc hl
    ld a, $03
    ld [wBattleArg0], a
    call DrawFourListEntriesForPageListPage_SRAMRecordAddress
    xor a
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

DrawFourListEntriesForPageListPage_SRAMRecordAddress::
    ld a, [hl]
    cp $ff
    jr z, .call_show_string_bc_at_tile_row_battle_arg0
    push hl
    call DrawFourListEntriesForPageListPage_Sub01_SRAMRecordAddress
    pop hl
    ld a, [hl]
    push hl
    ld c, MON_EGG
    call SRAMRecordAddress
    ld a, [hl]
    cp $02
    jr nz, .read_battle_arg0
    ld a, l
    add $a0
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, [hl]
    and $01
    add $cc
    jr .read_battle_arg02

.read_battle_arg0:
    ld a, $c9

.read_battle_arg02:
    ld c, a
    ld a, [wBattleArg0]
    ld hl, DrawFourListEntriesForPageListPage_SRAMRecordAddress_Data
    add a
    add_a_to_hl
    deref_hl
    ld [hl], c
    pop hl
    ret

.call_show_string_bc_at_tile_row_battle_arg0:
    push hl
    ld bc, $0200
    call ShowStringBCAtTileRowBattleArg0
    ld a, [wBattleArg0]
    ld hl, DrawFourListEntriesForPageListPage_SRAMRecordAddress_Data
    add a
    add_a_to_hl
    deref_hl
    ld [hl], $c3
    pop hl
    ret

DrawFourListEntriesForPageListPage_Sub01_SRAMRecordAddress::
    ld c, MON_SPECIES
    call SRAMRecordAddress
    ld c, [hl]
    inc hl
    ld a, [hl]
    add $02
    ld b, a

; wStringCategory = B, wStringIndex = C, string window destination = $9400 + 256 * wBattleArg0, then
; ShowString_Bank08 (E-0118)
ShowStringBCAtTileRowBattleArg0::
    ld a, c
    ld [wStringIndex], a
    ld a, b
    ld [wStringCategory], a
    ld a, [wBattleArg0]
    add $94
    ld h, a
    ld l, $00
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    ret

DrawFourListEntriesForPageListPage_SRAMRecordAddress_Data::
    db $43, $c2, $83, $c2, $c3, $c2, $03, $c3

; when wListCount is 5 or more: wWindowTileBuffer + $20 = $E1 + wListPage (the page number tile)
; (E-0119)
DrawListPageDigitIfLong::
    ld a, [wListCount]
    cp $05
    ret c
    ld a, [wListPage]
    add $e1
    ld [wWindowTileBuffer + $20], a
    ret

; removes the $FF entry from the party list wPartyList, wPartyCount -= 1, wBattlePartyCount = new
; count, and terminates the list with $FF (E-0124)
RemovePartyMemberMarkedFF::
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wTemp0

.loop:
    ld a, [hli]
    cp $ff
    jr z, .next
    ld [de], a
    inc de

.next:
    dec b
    jr nz, .loop
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    ld [wBattlePartyCount], a
    ld b, a
    ld hl, wTemp0
    ld de, wPartyList

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $ff
    ld [de], a
    ret

; wStringCategory = 5 (wStringIndex set by the caller), then far-calls BeginStringDisplay_Bank2F
; (E-0072)
ShowStringCategory5_Bank16::
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; wStringCategory = 5 (wStringIndex set by the caller), then far-calls ShowString_Bank2F (E-0074)
ShowStringCategory5Immediate_Bank16::
    ld a, $05
    ld [wStringCategory], a
    farcall ShowString_Bank2F
    ret

; copies the name of record wListEntries[5 * wSubMenuCursor2 + wMenuState] to wTextBuf1 and shows
; string $12 of category 5 (E-0125)
ShowRecordNameString12::
    ld a, [wSubMenuCursor2]
    ld b, a
    add a
    add a
    add b
    ld b, a
    ld a, [wMenuState]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld b, $0a
    ld de, wTextBuf1

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    xor a
    ld [rRAMG], a
    ld a, $12
    ld [wStringIndex], a ; 'Do you want to release G?'
    call ShowStringCategory5Immediate_Bank16
    ret

; copies the monster name of record wListEntries[wMenuOption * 4 + wCommandCursorMax] (its id word
; at field $0B) into wTextBuf1, then shows string $17 of category 5
; (ShowStringCategory5Immediate_Bank16) (E-0120)
ShowListedRecordNameMessage::
    ld a, [wMenuOption]
    add a
    add a
    ld b, a
    ld a, [wCommandCursorMax]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
    call SRAMRecordAddress
    deref_hl
    ld a, h
    add $02
    ld h, a
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, $17
    ld [wStringIndex], a ; 'Abandon G's egg?'
    call ShowStringCategory5Immediate_Bank16
    ret

; copies the name of record wBattleArg0[wMenuSubState] to wTextBuf0 and shows string $1D of category
; 5 (E-0124)
ShowRecordNameString1D::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wMenuSubState]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld de, wTextBuf0
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $1d
    ld [wStringIndex], a ; 'Send 0 back to the farm?'
    call ShowStringCategory5_Bank16
    ret

; copies the name of battle slot wDisplaySlot to DE and appends tile $A7 + (wSlotNameSuffix[slot] &
; 1) before the terminator (E-0124)
CopyBattleMonsterNameWithLetterSuffix::
    push de
    call CopyMonsterNameOfDisplaySlotToDE
    ld a, [wDisplaySlot]
    ld hl, wSlotNameSuffix
    add_a_to_hl
    ld a, [hl]
    and $01
    add $a7
    ld d, a
    ld a, [wDisplaySlot]
    pop hl

.skip:
    ld a, [hl]
    cp $f0
    jr z, .skip2
    inc hl
    jr .skip

.skip2:
    ld [hl], d
    inc hl
    ld [hl], $f0
    ret

; copies the name of the monster in slot wDisplaySlot to DE: string category 2 + the id's high byte
; (StringTable_MonsterNames, then StringTable_MonsterNames2 from id 256), index = the low byte
; (CopyStringHLToDE) (E-0069)
CopyMonsterNameOfDisplaySlotToDE::
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    push af
    ld a, [hl]
    add $02
    ld h, a
    pop af
    ld l, a
    call CopyStringHLToDE
    ret

; runs the routine for wBattleSubStep (jump table of five) (E-0122)
RunBattleEndStep5SubSteps::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleEndStep5SubSteps_ShowPleaseNameHero
    dw RunBattleEndStep5SubSteps_FillBytes
    dw RunBattleEndStep5SubSteps_WriteArg1AndArg2Etc
    dw RunBattleEndStep5SubSteps_AdvanceBattleSubStep
    dw RunBattleEndStep5SubSteps_WriteRAMGAndRAMBEtc

RunBattleEndStep5SubSteps_ShowPleaseNameHero::
    ld de, wTextBuf0
    call CopyBattleMonsterNameWithLetterSuffix
    ld a, $14
    ld [wStringIndex], a ; 'Please name 0.'
    call ShowStringCategory5_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    ret

RunBattleEndStep5SubSteps_FillBytes::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wNameEntryState
    ld bc, $001d
    xor a
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
    add $0d
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    ld [wArg3], a
    ld a, l
    add $fe
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, [hli]
    ld [wArg4], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wArg5], a
    ld [wSpeciesIdHi], a
    call SetSpeciesFlag
    ld a, $c3
    ld hl, wScreenTileBuffer
    ld bc, $02d0
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

RunBattleEndStep5SubSteps_WriteArg1AndArg2Etc::
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
    add $0d
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    ld [wArg3], a
    ld a, l
    add $fe
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, [hli]
    ld [wArg4], a
    ld a, [hl]
    ld [wArg5], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp $ff
    ret nz
    ld b, $31
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5f0
    call DecompressToVRAM
    ld hl, wBattleScreenFlags
    inc [hl]
    ld hl, wWorkBuf + $1
    ld de, wNameGlyphBuf
    ld b, $0a

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wBattleSubStep
    inc [hl]
    ret

RunBattleEndStep5SubSteps_AdvanceBattleSubStep::
    ld hl, wBattleSubStep
    inc [hl]
    ret

RunBattleEndStep5SubSteps_WriteRAMGAndRAMBEtc::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wFarmLevel]
    ld hl, BattleEnd_AskToJoin_WriteVRAMByte_Data
    add_a_to_hl
    ld b, [hl]
    ld hl, sRecords
    ld c, $00

.loop:
    ld a, [hl]
    or a
    jr z, .set_work_buf
    inc c
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop
    jr .skip

.set_work_buf:
    ld a, c
    ld [wWorkBuf], a
    ld [hl], $01
    inc hl
    ld b, $0a
    ld de, wWorkBuf + $1
    call CopyBBytesDEToHL_Bank16
    ld de, wRecordBufA + MON_SPECIES
    ld b, $9a
    call CopyBBytesDEToHL_Bank16
    ld a, $00
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld c, $00
    call InitSlotFromRecordFlags
    ld a, [wPartyCount]
    cp $01
    jr z, .skip
    ld a, $01
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld c, $01
    call InitSlotFromRecordFlags
    ld a, [wPartyCount]
    cp $02
    jr z, .skip
    ld a, $02
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld c, $02
    call InitSlotFromRecordFlags

.skip:
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    xor a
    ld [rRAMG], a
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
CopyBBytesDEToHL_Bank16::
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank16
    ret

; HL = a record flag byte, C = battle slot: unless bit 7 is set, marks the slot present
; (wBattleSlotOut = 0), clears its status byte 0 and sets status bit 0 when flag bit 2 is set and
; status bit 5 when flag bit 0 is set (E-0118)
InitSlotFromRecordFlags::
    bit 7, [hl]
    jr nz, SetBit0AtHL_Skip
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
SetBit5AtHL::
    set 5, [hl]
    ret

; [HL] |= $01 (E-0114)
SetBit0AtHL::
    set 0, [hl]
    ret

SetBit0AtHL_Skip::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $01
    ret

; by wBattleSubStep: the record list and cursor, SetRecordState2ForB, SwapMonstersMenu and
; RestoreRecordAFully: places the monster that joined
BattleEnd_AddJoinedMonster::
    ld a, [wBattleSubStep]
    jumptable
    dw BattleEnd_AddJoinedMonster_BuildBattleMenuScreen_733F
    dw BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16_SetListPageSize
    dw BattleEnd_AddJoinedMonster_MovePagedListCursor
    dw BattleEnd_AddJoinedMonster_ShowHeroWasSentTo
    dw BattleEnd_AddJoinedMonster_SetBattleStep
    dw BattleEnd_AddJoinedMonster_WriteBattleSubStepAndStringIndex
    dw BattleEnd_AddJoinedMonster_SetRecordState2ForB
    dw BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16
    dw BattleEnd_AddJoinedMonster_ShowChooseTheMonsterTo
    dw BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16_Case09_SetListPageSize
    dw BattleEnd_AddJoinedMonster_MovePagedListCursor_SetBattleSubStep
    dw BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16_SetMenuSelectedMember
    dw BattleEnd_AddJoinedMonster_MovePagedListCursor_AdvanceBattleSubStep
    dw BattleEnd_AddJoinedMonster_ClampRecordListPageCursor5
    dw BattleEnd_AddJoinedMonster_SwapMonstersMenu
    dw BattleEnd_AddJoinedMonster_BuildBattleMenuScreen_733F_CopyRect7923AndDrawBattleArg0Values
    dw BattleEnd_AddJoinedMonster_ShowWillYouTakeHero
    dw BattleEnd_AddJoinedMonster_ShowChooseTheMonsterTo_ChooseTheMonsterTo
    dw BattleEnd_AddJoinedMonster_RestoreRecordAFully
    dw BattleEnd_AddJoinedMonster_ShowWillYouTakeHero_WillYouTakeHero

BattleEnd_AddJoinedMonster_BuildBattleMenuScreen_733F::
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wWorkBuf]
    push af
    ld a, [wBattlePartyCount]
    ld b, a
    ld hl, wBattleArg0
    ld de, wPartyList

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop af
    ld [hl], a
    ld c, MON_NAME
    call SRAMRecordAddress
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld b, $0a
    ld de, wTextBuf0

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $f0
    ld [de], a
    xor a
    ld [rRAMG], a
    farcall LoadCursorTileAndRect7826
    ld a, $19
    ld [wStringIndex], a ; 'Will you take 0 with you?'
    call ShowStringCategory5Immediate_Bank16
    ld hl, wBattleSubStep
    inc [hl]
    xor a
    ld [wMenuState], a
    ret

BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16_SetListPageSize::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, vBGMap0 + $10e
    ld de, wScreenTileBuffer + $10e
    lb bc, $06, $05
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

BattleEnd_AddJoinedMonster_MovePagedListCursor::
    ld hl, BattleEnd_AskToJoin_ShowHeroDepartedSadly_Data
    ld de, wMenuState
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $6c
    call QueueSoundEffect
    ld a, [wMenuState]
    and $01
    jr nz, .done
    ld a, $05
    ld [wBattleSubStep], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z

.done:
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_ShowHeroWasSentTo::
    ld hl, wBattleSubStep
    inc [hl]
    call BattleMonsterTable71ACAtLeast6
    or a
    jr z, .set_string_index_to_1A
    ld a, $20
    ld [wStringIndex], a ; '0 was sent to the farm.'
    call ShowStringCategory5_Bank16
    ret

.set_string_index_to_1A:
    ld a, $1a
    ld [wStringIndex], a ; '0 was sent back to the'
    call ShowStringCategory5_Bank16
    ret

BattleEnd_AddJoinedMonster_SetBattleStep::
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_WriteBattleSubStepAndStringIndex::
    ld a, [wPartyCount]
    cp $03
    jr c, .call_battle_monster_table71_ac_at_least6
    ld a, $08
    ld [wBattleSubStep], a
    ret

.call_battle_monster_table71_ac_at_least6:
    ld hl, wBattleSubStep
    inc [hl]
    call BattleMonsterTable71ACAtLeast6
    or a
    jr z, .set_string_index_to_1B
    ld a, $21
    ld [wStringIndex], a ; '0 joined the party.'
    call ShowStringCategory5_Bank16
    ret

.set_string_index_to_1B:
    ld a, $1b
    ld [wStringIndex], a ; '0 joined the party.'
    call ShowStringCategory5_Bank16
    ret

BattleEnd_AddJoinedMonster_SetRecordState2ForB::
    ld a, [wTextFlags]
    or a
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

BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16::
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld a, $04
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_ShowChooseTheMonsterTo::
    call CopyRect7923AndDrawBattleArg0Values
    ld a, $1c
    ld [wStringIndex], a ; 'Choose the monster to send home.'
    call ShowStringCategory5Immediate_Bank16
    xor a
    ld [wMenuSubState], a
    ld hl, wScreenTileBuffer + $12f
    ld [hl], $bc
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16_Case09_SetListPageSize::
    ld a, [wTextFlags]
    or a
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
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld a, [wMenuSubState]
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_MovePagedListCursor_SetBattleSubStep::
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Data
    ld de, wMenuSubState
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wBattlePartyCount]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld b, $0a
    ld de, wTextBuf0

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    ld a, $13
    ld [wBattleSubStep], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    farcall CopyRectRecord787EAndPlaySound6C
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_CopyRect32StrideToVRAM_Bank16_SetMenuSelectedMember::
    xor a
    ld [wMenuSelectedMember], a
    ld hl, vBGMap0 + $10c
    ld de, wScreenTileBuffer + $10c
    lb bc, $08, $05
    call CopyRect32StrideToVRAM_Bank16
    ld a, $02
    ld [wListPageSize], a
    ld a, $00
    ld [wListPage], a
    ld a, $01
    ld [wListPageCount], a
    ld a, $02
    ld [wListLastPageSize], a
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Data
    ld a, [wMenuSubState]
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ld hl, vBGMap0 + $12d
    ld a, $bb
    call WriteVRAMByte
    call ShowRecordNameString1D
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_MovePagedListCursor_AdvanceBattleSubStep::
    ld hl, BattleEnd_AskToJoin_MovePagedListCursor_Case0F_Data
    ld de, wMenuSelectedMember
    call MovePagedListCursor
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and $01
    jr nz, .skip
    ld hl, wBattleSubStep
    inc [hl]
    ret

.skip:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wMenuSubState]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld de, wTextBuf0
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $1a
    ld [wStringIndex], a ; '0 was sent back to the'
    call ShowStringCategory5_Bank16
    ld a, $12
    ld [wBattleSubStep], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z
    call BuildBattleMenuScreen_733F
    farcall LoadCursorTileAndRect7826
    ld a, $11
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_ClampRecordListPageCursor5::
    ld hl, wListEntries
    ld bc, $001e
    xor a
    call FillBytes
    ld a, [wBattlePartyCount]
    inc a
    ld [wListCount], a
    ld b, a
    ld de, wBattleArg0
    ld hl, wListEntries

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wMenuSubState]
    ld [wListCursor], a
    ld a, $00
    ld [wListPageIndex], a
    farcall ClampRecordListPageCursor5
    farcall SaveAndHideSpriteState_Bank1E
    ld a, $0e
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_SwapMonstersMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
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
    ld hl, vTiles1 + $5f0
    call DecompressToVRAM
    ld hl, wBattleScreenFlags
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_AddJoinedMonster_BuildBattleMenuScreen_733F_CopyRect7923AndDrawBattleArg0Values::
    call BuildBattleMenuScreen_733F
    call CopyRect7923AndDrawBattleArg0Values
    ld a, [wListCursor]
    ld [wMenuSubState], a
    ld hl, BattleEnd_AskToJoin_CopyRectRecord796FToScreenBufferAndPlaySound6C_Data
    add a
    add_a_to_hl
    deref_hl
    ld [hl], $bc
    farcall CopyRectRecord787EAndPlaySound6C
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $12
    call CopyRect32StrideToVRAM_Bank16
    call ShowRecordNameString1D
    ld a, $0c
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_ShowWillYouTakeHero::
    ld a, $1f
    ld [wScreenTileBuffer + $10c], a
    ld a, $25
    ld [wScreenTileBuffer + $12c], a
    ld a, $2b
    ld [wScreenTileBuffer + $14c], a
    ld a, $31
    ld [wWindowTileBuffer + $4], a
    ld a, $37
    ld [wWindowTileBuffer + $24], a
    ld a, $c3
    ld [wScreenTileBuffer + $10d], a
    ld [wScreenTileBuffer + $12d], a
    ld [wScreenTileBuffer + $14d], a
    ld [wWindowTileBuffer + $5], a
    ld [wWindowTileBuffer + $25], a
    farcall LoadCursorTileAndRect7826
    ld hl, vBGMap0 + $10c
    ld hl, wScreenTileBuffer + $10c
    lb bc, $08, $05
    call CopyRect32StrideToVRAM_Bank16
    ld a, $19
    ld [wStringIndex], a ; 'Will you take 0 with you?'
    call ShowStringCategory5Immediate_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_ShowChooseTheMonsterTo_ChooseTheMonsterTo::
    call CopyRect7923AndDrawBattleArg0Values
    ld hl, wScreenTileBuffer + $12f
    ld [hl], $bc
    xor a
    ld [wMenuSelectedMember], a
    ld a, $1c
    ld [wStringIndex], a ; 'Choose the monster to send home.'
    call ShowStringCategory5Immediate_Bank16
    ld a, $09
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_RestoreRecordAFully::
    ld a, [wMenuSubState]
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    call RestoreRecordAFully
    ld [hl], $ff
    ld hl, wBattleArg0
    ld de, wPartyList
    ld a, [wBattlePartyCount]
    ld b, a

.loop:
    ld a, [hli]
    cp $ff
    jr z, .loop
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
    jr nz, .loop
    call LoadRecordListNameTiles
    call RunFunc710FForPartyMembers
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    ld a, $04
    ld [wBattleSubStep], a
    ret

BattleEnd_AddJoinedMonster_ShowWillYouTakeHero_WillYouTakeHero::
    call BuildBattleMenuScreen_733F
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $0d
    call CopyRect32StrideToVRAM_Bank16
    farcall LoadCursorTileAndRect7826
    ld a, $19
    ld [wStringIndex], a ; 'Will you take 0 with you?'
    call ShowStringCategory5Immediate_Bank16
    ld a, $01
    ld [wBattleSubStep], a
    xor a
    ld [wMenuState], a
    ret

; copies rectangle record $7923 to the screen buffer and draws the wBattleArg0 values at vTiles2 +
; $3B0 (E-0122)
CopyRect7923AndDrawBattleArg0Values::
    farcall CopyRectRecord7923ToScreenBuffer
    call DrawBattleArg0ValuesAtTiles23B0
    ret

; for record A: field 0 = 1, field $55 = 0, HP (field $5B) = max HP ($5D), MP ($5F) = max MP ($61)
; (E-0127)
RestoreRecordAFully::
    push hl
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld [hl], $01
    ld a, l
    add $55
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld [hl], $00
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push hl
    ld a, l
    add $fc
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], b
    pop hl
    ld b, h
    ld c, l
    inc hl
    inc hl
    ld a, [hli]
    ld [bc], a
    inc bc
    ld a, [hl]
    ld [bc], a
    xor a
    ld [rRAMG], a
    pop hl
    ret

; A = B, then falls into SetRecordState2 (E-0126)
SetRecordState2ForB::
    ld a, b

; A = record: sets its byte 0 (state) to 2 in SRAM bank 0 (SRAMRecordAddress with C = 0) (E-0118)
SetRecordState2::
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld [hl], $02
    xor a
    ld [rRAMG], a
    ret

; with SRAM enabled runs RunFunc710FForPartyMembers_SRAMRecordAddress for each of the first one to
; three party records (E-0124)
RunFunc710FForPartyMembers::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld c, $00
    ld a, [wPartyList]
    call RunFunc710FForPartyMembers_SRAMRecordAddress
    ld a, [wPartyCount]
    cp $01
    jr z, .done
    ld c, $01
    ld a, [wPartyList + $1]
    call RunFunc710FForPartyMembers_SRAMRecordAddress
    ld a, [wPartyCount]
    cp $02
    jr z, .done
    ld c, $02
    ld a, [wPartyList + $2]
    call RunFunc710FForPartyMembers_SRAMRecordAddress

.done:
    xor a
    ld [rRAMG], a
    ret

RunFunc710FForPartyMembers_SRAMRecordAddress::
    push bc
    ld c, MON_LEVEL
    call SRAMRecordAddress
    pop bc
    ld a, c
    ld de, wBattleLevel
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hl]
    ld [de], a
    ld a, l
    add $05
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, c
    ld de, wBattleHP
    add a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc hl
    inc hl
    ld a, c
    ld de, wBattleMP
    add a
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, c
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    xor a
    ld [de], a
    ld a, l
    add $f4
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    bit 7, [hl]
    jr nz, .done
    ld a, c
    add a
    add a
    add a
    add c
    ld de, wBattleStatus
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    xor a
    ld [de], a
    bit 0, [hl]
    call nz, SetBit5AtDE
    bit 2, [hl]
    call nz, SetBit0AtDE
    ret

.done:
    ld a, $01
    ld [de], a
    ret

; [DE] |= $20; clobbers A (E-0114)
SetBit5AtDE::
    ld a, [de]
    set 5, a
    ld [de], a
    ret

; [DE] |= $01; clobbers A (E-0114)
SetBit0AtDE::
    ld a, [de]
    set 0, a
    ld [de], a
    ret

; A = 1 when Data $71AC[battle monster id of wDisplaySlot] is at least 6, else 0 (E-0124)
BattleMonsterTable71ACAtLeast6::
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    push af
    ld a, [hl]
    ld h, a
    pop af
    ld l, a
    ld a, l
    add $ac
    ld l, a
    ld a, h
    adc $71
    ld h, a
    ld a, [hl]
    cp $06
    jr c, .return_0
    ld a, $01
    ret

.return_0:
    xor a
    ret

; BattleMonsterTable71ACAtLeast6 reads the byte at $71AC + the wBattleMonsterId of wDisplaySlot and
; returns A = 1 when it is 6 or more; BattleEnd_Step5_Case04_Sub01_Case03 and _Case05 call it; 373
; bytes (monster ids 0-$174) end at the rectangle copier after them; what the classes mean is not
; read (E-0206, C1)
; record: class 0-7
MonsterClassByteTable_71AC::
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

; B = width, C = rows, DE = source with rows 32 bytes apart, HL = VRAM address with rows 32 bytes
; apart: copies a B x C rectangle with WriteVRAMByteInc; DE and HL end at the start of the row
; below; B kept, C = 0 (E-0066)
CopyRect32StrideToVRAM_Bank16::
    push bc
    push de
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    pop hl
    ld de, $0020
    add hl, de
    pop de
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop bc
    dec c
    jr nz, CopyRect32StrideToVRAM_Bank16
    ret

; clears attributes and the screen buffer and lays out the battle menu rectangles (bank $31 routines
; for wBattlePartyCount and wBattleFoeCount) (E-0122)
BuildBattleMenuScreen_733F::
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall DrawPartySlotStatusPanels
    farcall LayoutTileBlocksForBattleFoeCount
    farcall LoadBattleMonsterPictureAttributes
    farcall CopyRectRecord7345ToScreenBuffer
    ret

BattleEnd_Step3_NextTableByte::
    ld a, [wBattleKind]
    cp $02
    jr nz, .call_next_table_byte
    ld c, $00
    jr .read_record_buf_a

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, $05
    call DivideHLByA
    sub $02
    ld c, a

.read_record_buf_a:
    ld a, [wRecordBufA + MON_LEVEL]
    add c
    bit 7, a
    jr nz, .set_record_buf_a_to_01
    or a
    jr z, .set_record_buf_a_to_01
    cp $64
    jr c, .set_record_buf_a
    ld a, $63
    jr .set_record_buf_a

.set_record_buf_a_to_01:
    ld a, $01

.set_record_buf_a:
    ld [wRecordBufA + MON_LEVEL], a
    ld a, [wRecordBufA + MON_SPECIES]
    ld l, a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld c, a
    ld a, [wRecordBufA + MON_LEVEL]
    cp c
    jr c, .set_record_buf_a2
    ld c, a

.set_record_buf_a2:
    ld a, c
    ld [wRecordBufA + MON_MAX_LEVEL], a
    ld a, [wBattleKind]
    cp $02
    jp z, .call_battle_end_step3_sub01_load_species
    ld a, [wRecordBufA + MON_MAX_HP]
    ld c, a
    ld a, [wRecordBufA + MON_MAX_HP + 1]
    ld b, a
    call BattleEnd_Step3_Sub01_Multiply8By16
    ld a, l
    ld [wRecordBufA + MON_MAX_HP], a
    ld a, h
    ld [wRecordBufA + MON_MAX_HP + 1], a
    ld a, l
    ld [wRecordBufA + MON_HP], a
    ld a, h
    ld [wRecordBufA + MON_HP + 1], a
    ld a, [wRecordBufA + MON_MAX_MP]
    ld c, a
    ld a, [wRecordBufA + MON_MAX_MP + 1]
    ld b, a
    call BattleEnd_Step3_Sub01_Multiply8By16_Sub02
    ld a, l
    ld [wRecordBufA + MON_MAX_MP], a
    ld a, h
    ld [wRecordBufA + MON_MAX_MP + 1], a
    ld a, l
    ld [wRecordBufA + MON_MP], a
    ld a, h
    ld [wRecordBufA + MON_MP + 1], a
    ld a, [wRecordBufA + MON_ATK]
    ld c, a
    ld a, [wRecordBufA + MON_ATK + 1]
    ld b, a
    call BattleEnd_Step3_Sub01_Multiply8By16_Sub02
    ld a, l
    ld [wRecordBufA + MON_ATK], a
    ld a, h
    ld [wRecordBufA + MON_ATK + 1], a
    ld a, [wRecordBufA + MON_DEF]
    ld c, a
    ld a, [wRecordBufA + MON_DEF + 1]
    ld b, a
    call BattleEnd_Step3_Sub01_Multiply8By16_Sub02
    ld a, l
    ld [wRecordBufA + MON_DEF], a
    ld a, h
    ld [wRecordBufA + MON_DEF + 1], a
    ld a, [wRecordBufA + MON_AGL]
    ld c, a
    ld a, [wRecordBufA + MON_AGL + 1]
    ld b, a
    call BattleEnd_Step3_Sub01_Multiply8By16_Sub02
    ld a, l
    ld [wRecordBufA + MON_AGL], a
    ld a, h
    ld [wRecordBufA + MON_AGL + 1], a
    ld a, [wRecordBufA + MON_INT]
    ld c, a
    ld a, [wRecordBufA + MON_INT + 1]
    ld b, a
    call BattleEnd_Step3_Sub01_Multiply8By16_Sub02
    ld a, l
    ld [wRecordBufA + MON_INT], a
    ld a, h
    ld [wRecordBufA + MON_INT + 1], a
    ld a, [wRecordBufAByte71]
    ld c, a
    ld b, $00
    call BattleEnd_Step3_Sub01_Multiply8By16_Sub02
    ld a, l
    ld [wRecordBufAByte71], a

.call_battle_end_step3_sub01_load_species:
    call BattleEnd_Step3_Sub01_LoadSpeciesFamily
    ld hl, wWorkBuf
    ld b, $0b
    ld de, $0000

.loop:
    ld a, e
    add [hl]
    ld e, a
    ld a, d
    adc $00
    ld d, a
    inc hl
    dec b
    jr nz, .loop
    ld a, d
    or a
    jr nz, .read_record_buf_a2
    ld hl, $0000
    ld a, e
    cp $15
    jr c, .read_record_buf_a3
    ld hl, $0032
    cp $29
    jr c, .read_record_buf_a3
    ld hl, $0064
    cp $3d
    jr c, .read_record_buf_a3
    ld hl, $0096
    cp $51
    jr c, .read_record_buf_a3
    ld hl, $00c8
    cp $65
    jr c, .read_record_buf_a3
    ld hl, $00fa
    cp $79
    jr c, .read_record_buf_a3
    ld hl, $012c
    cp $8d
    jr c, .read_record_buf_a3

.read_record_buf_a2:
    ld hl, $0190

.read_record_buf_a3:
    push hl
    ld a, [wRecordBufA + MON_LEVEL]
    ld c, $19
    call Multiply8
    pop de
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    bit 7, h
    jr z, .skip
    ld hl, $0000
    jr .set_record_buf_a3

.skip:
    ld a, l
    sub $e7
    ld a, h
    sbc $03
    jr c, .set_record_buf_a3
    ld hl, $03e7

.set_record_buf_a3:
    ld a, l
    ld [wRecordBufA + MON_WLD], a
    ld a, h
    ld [wRecordBufA + MON_WLD + 1], a
    ret

BattleEnd_Step3_Sub01_Multiply8By16_Sub02::
    ld hl, $03e7
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jr z, .set_battle_temp_buf
    ld bc, $03e7

.set_battle_temp_buf:
    ld a, c
    ld [wBattleTempBuf], a
    ld a, b
    ld [wBattleTempBuf + $1], a
    ld a, $14
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, l
    ld [wBattleTempBuf + $2], a
    ld a, h
    ld [wBattleTempBuf + $3], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, [wBattleTempBuf + $2]
    or a
    call nz, DivideHLByA
    ld c, a
    ld a, [wBattleTempBuf]
    sub c
    ld l, a
    ld a, [wBattleTempBuf + $1]
    sbc $00
    ld h, a
    ret

BattleEnd_Step3_Sub01_Multiply8By16::
    ld hl, $03e7
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jr z, .set_battle_temp_buf
    ld bc, $03e7

.set_battle_temp_buf:
    ld a, c
    ld [wBattleTempBuf], a
    ld a, b
    ld [wBattleTempBuf + $1], a
    ld a, $14
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, l
    ld [wBattleTempBuf + $2], a
    ld a, h
    ld [wBattleTempBuf + $3], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, [wBattleTempBuf + $2]
    or a
    call nz, DivideHLByA
    ld c, a
    ld a, [wBattleTempBuf]
    sub c
    ld l, a
    ld a, [wBattleTempBuf + $1]
    sbc $00
    ld h, a
    ld a, h
    cp $03
    ret z
    ld a, $08
    add_a_to_hl
    ret

; copies a tile to vTiles1 + $6D0, shows strings 6, 7 and 8 of category 2 (bank 09) at vTiles1 +
; $6D0, $750 and $7D0, then restores the default window (E-0127)
ShowStrings6To8Bank09InRows::
    ld de, vTiles1 + $2f0
    ld hl, vTiles1 + $6d0
    ld b, $10

.loop:
    call WaitForVRAMAccess
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld hl, $0301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1 + $6d0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a ; 'Skill On/Off Orb ID Odds'
    farcall ShowString_Bank09
    ld hl, vTiles1 + $750
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $07
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1 + $7d0
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

BattleEnd_AskToJoin_WriteVRAMByte_Data::
    db $0a, $14, $1e

; checks the save; when valid, loads the player name, play time, party summaries and other
; title-screen details from SRAM bank 1 into wBattlerRecords onward (E-0129)
LoadSaveFileSummary::
    ld hl, wBattlerRecords
    ld bc, $003c
    xor a
    call FillBytes
    farcall CheckSaveData
    ldh a, [hTemp0]
    or a
    jr z, .set_battler_records_to_01
    ld a, $00
    ld [wBattlerRecords], a
    jp .return

.set_battler_records_to_01:
    ld a, $01
    ld [wBattlerRecords], a
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedPlayerName
    ld de, wTitlePlayerName
    ld b, $0a
    call CopyBytesDEFromHL_Bank16
    ld hl, sSavedPlayTime
    ld de, wBattlerRecords + BATTLER_SPECIES + 1
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
    cp $01
    jr z, .read_saved_arena_byte37
    push af
    ld a, [sSaveData + $101]
    ld [wWorkBuf], a
    ld de, wBattlerRecords + BATTLER_MAX_HP
    ld a, e
    ld [wWorkBuf + $1], a
    ld a, d
    ld [wWorkBuf + $2], a
    call BuildRecordSummaryForWorkBuf
    pop af
    cp $02
    jr z, .read_saved_arena_byte37
    ld a, [sSaveData + $102]
    ld [wWorkBuf], a
    ld de, wBattlerRecords + BATTLER_INT
    ld a, e
    ld [wWorkBuf + $1], a
    ld a, d
    ld [wWorkBuf + $2], a
    call BuildRecordSummaryForWorkBuf

.read_saved_arena_byte37:
    ld a, [sSavedArenaByte37]
    ld [wTitleByte0A], a
    ld a, [sSavedMapType]
    ld [wTitleKeyFlag], a
    ld a, [sSavedMapId]
    ld [wTitleStringIndex], a
    ld a, [sSavedKeyIndex]
    ld hl, sSavedKeyList
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wTitleKeyEntry], a
    ld a, [hli]
    ld [wTitleKeyWord1], a
    ld a, [hli]
    ld [wTitleKeyWord2], a
    ld a, [hl]
    ld [wTitleKeyByte3], a
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a

.return:
    ret

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL)
CopyBytesDEFromHL_Bank16::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank16
    ret

; for SRAM bank-1 record wWorkBuf writes its family nibble, a packed field from bytes $21/$27
; (BuildRecordSummaryForWorkBuf_ClearAndCopy) and field $62 & $7F to the buffer at wWorkBuf + $1
; (E-0127)
BuildRecordSummaryForWorkBuf::
    ld a, [wWorkBuf]
    ld c, $6f
    call Multiply8
    ld a, l
    add $6f
    ld l, a
    ld a, h
    adc $a0
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
    and $0f
    ld [de], a
    inc de
    ld a, l
    add $21
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, [hl]
    ld a, l
    add $06
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld c, [hl]
    ld a, [wWorkBuf + $3]
    add $03
    ld l, a
    ld a, [wWorkBuf + $4]
    adc $00
    ld h, a
    call BuildRecordSummaryForWorkBuf_ClearAndCopy
    ld a, [wWorkBuf + $3]
    add $62
    ld l, a
    ld a, [wWorkBuf + $4]
    adc $00
    ld h, a
    ld a, [wWorkBuf + $1]
    add $0b
    ld e, a
    ld a, [wWorkBuf + $2]
    adc $00
    ld d, a
    ld a, [hl]
    and $7f
    ld [de], a
    ret

; fills ten bytes at DE with $F0, then copies bytes from HL by the flags in B
BuildRecordSummaryForWorkBuf_ClearAndCopy::
    push de
    ld a, $f0
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
    ld a, [hli]
    ld [de], a
    ld a, b
    and $c0
    jr z, .next
    inc de
    rlca
    rlca
    add $8c
    ld [de], a

.next:
    inc de
    ld a, [hli]
    ld [de], a
    ld a, b
    and $30
    jr z, .next2
    inc de
    swap a
    add $8c
    ld [de], a

.next2:
    inc de
    ld a, [hli]
    ld [de], a
    ld a, b
    and $0c
    jr z, .next3
    inc de
    rrca
    rrca
    add $8c
    ld [de], a

.next3:
    inc de
    ld a, [hli]
    ld [de], a
    ld a, b
    and $03
    jr z, .next4
    inc de
    add $8c
    ld [de], a

.next4:
    inc de
    ld a, [hli]
    ld [de], a
    ld a, c
    and $c0
    jr z, .return
    inc de
    rlca
    rlca
    add $8c
    ld [de], a

.return:
    ret

; far-calls DecompressGraphicsA4ToTiles0 and continues at
; DrawTitleSaveSummaryScreen_CallLoadSaveFileSummary (E-0127)
DecompressA4GraphicsAndContinue::
    farcall DecompressGraphicsA4ToTiles0
    jr DrawTitleSaveSummaryScreen_CallLoadSaveFileSummary

; loads the summary graphics and palette, the save file summary, and draws the player name, party
; icons, names, levels and key name on the title screen (E-0131)
DrawTitleSaveSummaryScreen::
    ld b, $7e
    ld de, Tiles0Gfx_7E_5B63
    ld hl, vTiles0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jr z, DrawTitleSaveSummaryScreen_CallLoadSaveFileSummary
    ld de, OBJPaletteBufferData_7E_5BB8
    ld b, $7e
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

DrawTitleSaveSummaryScreen_CallLoadSaveFileSummary::
    call LoadSaveFileSummary
    ld a, [wBattlerRecords]
    or a
    jp nz, .set_text_window_rows
    ld hl, wScreenTileBuffer + $41
    ld bc, $1104
    ld a, [wGameMode]
    cp $05
    jr nz, .skip
    ld hl, wScreenTileBuffer + $81

.skip:
    ld a, $c3

.loop:
    push bc
    push hl

.loop2:
    ld [hli], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ld hl, wScreenTileBuffer + $c4
    ld b, $0e
    ld a, [wGameMode]
    cp $05
    jr nz, .skip2
    ld hl, wScreenTileBuffer + $104
    ld a, $40
    jr .loop3

.skip2:
    ld a, $20

.loop3:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop3
    ld hl, vTiles2 + $200
    ld a, [wGameMode]
    cp $05
    jr nz, .set_text_window_tile_lo
    ld hl, vTiles2 + $400

.set_text_window_tile_lo:
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0e01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0a
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

.set_text_window_rows:
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
    cp $05
    jr nz, .call_show_ten_byte_name_at_de
    ld de, vTiles2 + $400

.call_show_ten_byte_name_at_de:
    call ShowTenByteNameAtDE
    ld a, [wTitlePlayHoursLo]
    ld l, a
    ld a, [wTitlePlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $4d
    ld a, [wGameMode]
    cp $05
    jr nz, .call_write_three_digit_tiles_digits_bank16
    ld de, wScreenTileBuffer + $8d

.call_write_three_digit_tiles_digits_bank16:
    call WriteThreeDigitTilesDigits_Bank16
    ld a, [wTitlePlayMinutes]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $51
    ld a, [wGameMode]
    cp $05
    jr nz, .call_write_two_digit_tiles_digits1_no_blank
    ld de, wScreenTileBuffer + $91

.call_write_two_digit_tiles_digits1_no_blank:
    call WriteTwoDigitTilesDigits1NoBlank_Bank16
    ld a, [wTitlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wTitlePartySummary
    call DrawSaveSummaryPartyEntryC
    ld c, $01
    ld hl, wBattlerRecords + BATTLER_MAX_HP
    call DrawSaveSummaryPartyEntryC
    ld c, $02
    ld hl, wBattlerRecords + BATTLER_INT
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

; writes wDigits as a digit tile at DE and falls into WriteTwoDigitTilesWC8C1NoBlank_Bank16 (E-0126)
WriteThreeDigitTilesDigits_Bank16::
    ld hl, wDigits
    ld a, [hl]
    add $e0
    ld [de], a
    inc de

; writes wDigits + $1 and wDigits + $2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank)
; (E-0117) (the same 13 bytes appear in 2 banks)
WriteTwoDigitTilesDigits1NoBlank_Bank16::
    ld hl, wDigits + $1
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hl]
    add $e0
    ld [de], a
    ret

; window at DE: copies 10 bytes from HL to wTextBuf0 with a $F0 terminator and shows it
; (ShowString_Bank08) (E-0122)
ShowTenByteNameAtDE::
    ld a, e
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    ld de, wTextBuf0
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    farcall ShowString_Bank08
    ret

; for summary entry C (below B) loads its family icon, shows its 10-byte name and writes its level;
; otherwise blanks the entry (E-0129)
DrawSaveSummaryPartyEntryC::
    ld a, c
    cp b
    jr nc, .check_game_mode
    push bc
    ld a, [hli]
    ld [wWorkBuf], a
    push hl
    ld a, c
    ld hl, DrawSaveSummaryPartyEntryC_Data1
    push af
    ld a, [wGameMode]
    cp $05
    jr nz, .restore
    ld hl, DrawSaveSummaryPartyEntryC_Data2

.restore:
    pop af
    add_a_to_hl
    ld a, [hl]
    ld [wWorkBuf + $1], a
    push hl
    call LoadFamilyIconTileForWorkBuf
    pop hl
    ld a, [hl]
    swap a
    and $0f
    or $90
    ld d, a
    ld a, [hl]
    swap a
    and $f0
    ld e, a
    ld a, e
    add $10
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop hl
    push hl
    call ShowTenByteNameAtDE
    pop hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld l, [hl]
    ld h, $00
    call HLToDecimalDigits
    pop bc
    ld a, c
    ld hl, DrawSaveSummaryPartyEntryC_Data3
    push af
    ld a, [wGameMode]
    cp $05
    jr nz, .restore2
    ld hl, DrawSaveSummaryPartyEntryC_Data4

.restore2:
    pop af
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call WriteTwoDigitTilesDigits1NoBlank_Bank16
    ret

.check_game_mode:
    ld hl, DrawSaveSummaryPartyEntryC_Data3
    push af
    ld a, [wGameMode]
    cp $05
    jr nz, .restore3
    ld hl, DrawSaveSummaryPartyEntryC_Data4

.restore3:
    pop af
    add a
    add_a_to_hl
    deref_hl
    ld de, $fff7
    add hl, de
    push bc
    ld b, $0b
    ld a, $c3

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    pop bc
    ret

; writes $C3 to wScreenTileBuffer + $8F/8 and wScreenTileBuffer + $AF/8, or to wScreenTileBuffer +
; $CF/8 and wScreenTileBuffer + $EF/8 in game mode 5 (E-0122)
BlankTwoTileCellByGameMode::
    ld a, [wGameMode]
    cp $05
    jr z, .set_screen_tile_buffer_to_C3
    ld a, $c3
    ld [wScreenTileBuffer + $8f], a
    ld [wScreenTileBuffer + $90], a
    ld [wScreenTileBuffer + $af], a
    ld [wScreenTileBuffer + $b0], a
    ret

.set_screen_tile_buffer_to_C3:
    ld a, $c3
    ld [wScreenTileBuffer + $cf], a
    ld [wScreenTileBuffer + $d0], a
    ld [wScreenTileBuffer + $ef], a
    ld [wScreenTileBuffer + $f0], a
    ret

; window at vTiles2 + $3B0 (or + $5B0 in game mode 5): shows string wTitleStringIndex + $0A, or
; builds a two-word key name from wTitleKeyWord1/wTitleKeyWord2 (E-0127)
ShowKeyNameOrStringForTitleKeyFlag::
    ld hl, vTiles2 + $3b0
    ld a, [wGameMode]
    cp $05
    jr nz, .set_text_window_tile_lo
    ld hl, vTiles2 + $5b0

.set_text_window_tile_lo:
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0d01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wTitleKeyFlag]
    bit 7, a
    jr nz, .check_title_key_byte3
    ld a, [wTitleStringIndex]
    add $0a
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall ShowString_Bank08
    ret

.check_title_key_byte3:
    ld a, [wTitleKeyByte3]
    bit 7, a
    jr nz, CopyKeyNameWordToDE_Bank16_CheckTitleKeyEntry
    ld de, wTextBuf0
    ld a, [wTitleKeyWord1]
    inc a
    call CopyKeyNameWordToDE_Bank16
    dec de
    ld a, [wTitleKeyWord2]
    add $11
    call CopyKeyNameWordToDE_Bank16
    dec de
    ld a, $f0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ret

; calls CopyKeyNameWordToDE (bank $00) (E-0114)
CopyKeyNameWordToDE_Bank16::
    call CopyKeyNameWordToDE
    ret

CopyKeyNameWordToDE_Bank16_CheckTitleKeyEntry::
    ld a, [wTitleKeyEntry]
    and $3f
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall ShowString_Bank09
    ret

DrawSaveSummaryPartyEntryC_Data1::
    db $25, $2b, $31

DrawSaveSummaryPartyEntryC_Data2::
    db $45, $4b, $51

DrawSaveSummaryPartyEntryC_Data3::
    db $22, $c2, $62, $c2, $a2, $c2

DrawSaveSummaryPartyEntryC_Data4::
    db $62, $c2, $a2, $c2, $e2, $c2

; writes the 16-byte icon tile of family wWorkBuf (FamilyIconTiles + 16 * family) to VRAM tile
; wWorkBuf + $1 through WriteBytesToVRAMTileWorkBuf1; corrected in E-0124, first named as a palette
; load (E-0122)
LoadFamilyIconTileForWorkBuf::
    ld a, [wWorkBuf]
    swap a
    ld de, FamilyIconTiles
    add e
    ld e, a
    jr nc, .call_write_bytes_to_vram_tile_work_buf1
    inc d

.call_write_bytes_to_vram_tile_work_buf1:
    ld b, $10
    call WriteBytesToVRAMTileWorkBuf1
    ret

; writes the $B0 bytes at FamilyIconTiles (the eleven family icon tiles) to VRAM from tile wWorkBuf
; + $1; corrected in E-0124 (E-0122)
LoadAllFamilyIconTiles::
    ld de, FamilyIconTiles
    ld b, $b0
    call WriteBytesToVRAMTileWorkBuf1
    ret

; with SRAM enabled (bank 0), runs LoadTileForRecordByte0D for record list entries 0, 1 and 2 with H
; = $C7, $C8 and $C9, stopping after wPartyCount entries; then disables SRAM (E-0103)
LoadTilesForPartyRecords::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, $00
    ld h, $c7
    call LoadTileForRecordByte0D
    ld a, [wPartyCount]
    cp $01
    jr z, .done
    ld a, $01
    ld h, $c8
    call LoadTileForRecordByte0D
    ld a, [wPartyCount]
    cp $02
    jr z, .done
    ld a, $02
    ld h, $c9
    call LoadTileForRecordByte0D

.done:
    ld a, $00
    ld [rRAMG], a
    ret

; A = record (SRAMRecordAddressMapped, offset $0D), H = destination page: picks 16 bytes from
; FamilyIconTiles by the low nibble of record byte $0D and copies them on through the shared copy
; loop at WriteBytesToVRAMTileWorkBuf1_Skip (not read to its end) (E-0103)
LoadTileForRecordByte0D::
    push hl
    ld c, MON_FAMILY
    call SRAMRecordAddressMapped
    ld a, [hl]
    and $0f
    swap a
    ld de, FamilyIconTiles
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $10
    pop af
    jr WriteBytesToVRAMTileWorkBuf1_Skip

; writes B bytes from DE to VRAM tile wWorkBuf + $1 ($8000 + 16 * index; indices below $80 use the
; $9000 area) (E-0124) (E-0340: the address in its name read as its RAM name; was
; WriteBytesToVRAMTileWD09E)
WriteBytesToVRAMTileWorkBuf1::
    ld a, [wWorkBuf + $1]

WriteBytesToVRAMTileWorkBuf1_Skip::
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
    or $80
    ld h, a
    cp $88
    jr nc, .loop
    set 4, h

.loop:
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, .loop
    ret

; LoadFamilyIconTileForWorkBuf copies the 16 bytes at $7ACD + 16 * family (wWorkBuf) to VRAM; 11
; families (E-0229, C1)
; record: the 16-byte icon tile of one family
FamilyIconTiles::
    db $ff, $10, $ff, $10, $ef, $38, $ef, $54, $ff, $aa, $ab, $d6, $83, $fe, $ff, $7c ; id 0
    db $f7, $0e, $ff, $0c, $ff, $1e, $f7, $ec, $ff, $fe, $ff, $ae, $ff, $1c, $ef, $70 ; id 1
    db $ff, $00, $ff, $18, $ff, $db, $ff, $c3, $ff, $3c, $ff, $7e, $ff, $7e, $ff, $3c ; id 2
    db $ff, $06, $fd, $0b, $ff, $16, $fd, $23, $e7, $56, $bb, $c6, $f3, $b0, $ff, $c0 ; id 3
    db $ff, $18, $e7, $24, $e7, $24, $c3, $42, $d3, $52, $f7, $76, $ff, $18, $db, $18 ; id 4
    db $bb, $82, $ff, $44, $ff, $28, $ff, $7c, $bb, $fe, $d7, $92, $ff, $fe, $ff, $7c ; id 5
    db $ff, $18, $ff, $36, $eb, $2a, $f7, $15, $eb, $2b, $df, $56, $bf, $a0, $ff, $c0 ; id 6
    db $ff, $00, $ff, $7c, $ff, $fe, $ff, $92, $ff, $ee, $ff, $fe, $ff, $54, $ff, $38 ; id 7
    db $ff, $00, $ff, $7c, $c7, $c6, $ef, $aa, $ab, $82, $d7, $d6, $ab, $aa, $ff, $7c ; id 8
    db $ff, $10, $ff, $10, $e7, $30, $db, $60, $9b, $e6, $83, $fe, $c7, $7c, $ff, $38 ; id 9
    db $bb, $7c, $7d, $c6, $ff, $ba, $7d, $f6, $bb, $6c, $d7, $38, $ff, $28, $d7, $38 ; id 10

; LZSS-compressed: 405 bytes that expand to 624 (E-0016, E-0017)
Tiles1Plus6E0Gfx_16_7B7D::
    INCBIN "gfx/misc/tiles1_plus6_e0_gfx_16_7_b7_d.lz"

; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
Gfx_16_7D12::
    INCBIN "gfx/misc/gfx_16_7_d12.lz"
    ds $2ac, $00
