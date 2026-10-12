SECTION "Bank 26", ROMX[$4000], BANK[$26]
    db $26

; ORs the attribute bits from Data_026_411E[hSpriteSetIndex] (when its bit 0 is set) into hSpriteAttrXor, then builds the sprite from Data_026_401E (E-0124)
; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, UpdateAndDrawSpriteSlots, AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80, DrawPartyFollowerSprites, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
DrawMetaSpriteSet_Bank26::
Func_026_4001:: ; address name
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, MetaSprites26Attrs
    add hl, de
    bit 0, [hl]
    jr z, .call_draw_meta_sprite_set_bank26_wait_oam
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or a, e
    ldh [hSpriteAttrXor], a

.call_draw_meta_sprite_set_bank26_wait_oam:
    ld de, MetaSprites26Table
    call DrawMetaSpriteSet_Bank26_WaitOamNextEntry
    ret

; E-0147 (C1: DrawMetaSpriteSet_Bank26 passes DE = $26:401E to the builder, which takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 128 words up to the attribute table at $411E).
; record: meta-sprite set
MetaSprites26Table::
Data_026_401E:: ; address name
    dw MetaSprites26Set00 ; id 0
    dw MetaSprites26Set01 ; id 1
    dw MetaSprites26Set02 ; id 2
    dw MetaSprites26Set03 ; id 3
    dw MetaSprites26Set04 ; id 4
    dw MetaSprites26Set05 ; id 5
    dw MetaSprites26Set05 ; id 6
    dw MetaSprites26Set05 ; id 7
    dw MetaSprites26Set05 ; id 8
    dw MetaSprites26Set05 ; id 9
    dw MetaSprites26Set05 ; id 10
    dw MetaSprites26Set05 ; id 11
    dw MetaSprites26Set05 ; id 12
    dw MetaSprites26Set05 ; id 13
    dw MetaSprites26Set0E ; id 14
    dw MetaSprites26Set0F ; id 15
    dw MetaSprites26Set10 ; id 16
    dw MetaSprites26Set11 ; id 17
    dw MetaSprites26Set12 ; id 18
    dw MetaSprites26Set13 ; id 19
    dw MetaSprites26Set14 ; id 20
    dw MetaSprites26Set15 ; id 21
    dw MetaSprites26Set16 ; id 22
    dw MetaSprites26Set17 ; id 23
    dw MetaSprites26Set18 ; id 24
    dw MetaSprites26Set19 ; id 25
    dw MetaSprites26Set1A ; id 26
    dw MetaSprites26Set1B ; id 27
    dw MetaSprites26Set1C ; id 28
    dw MetaSprites26Set1D ; id 29
    dw MetaSprites26Set1E ; id 30
    dw MetaSprites26Set1F ; id 31
    dw MetaSprites26Set20 ; id 32
    dw MetaSprites26Set21 ; id 33
    dw MetaSprites26Set22 ; id 34
    dw MetaSprites26Set23 ; id 35
    dw MetaSprites26Set24 ; id 36
    dw MetaSprites26Set25 ; id 37
    dw MetaSprites26Set26 ; id 38
    dw MetaSprites26Set27 ; id 39
    dw MetaSprites26Set28 ; id 40
    dw MetaSprites26Set28 ; id 41
    dw MetaSprites26Set28 ; id 42
    dw MetaSprites26Set28 ; id 43
    dw MetaSprites26Set28 ; id 44
    dw MetaSprites26Set28 ; id 45
    dw MetaSprites26Set28 ; id 46
    dw MetaSprites26Set28 ; id 47
    dw MetaSprites26Set28 ; id 48
    dw MetaSprites26Set31 ; id 49
    dw MetaSprites26Set32 ; id 50
    dw MetaSprites26Set33 ; id 51
    dw MetaSprites26Set34 ; id 52
    dw MetaSprites26Set35 ; id 53
    dw MetaSprites26Set36 ; id 54
    dw MetaSprites26Set37 ; id 55
    dw MetaSprites26Set38 ; id 56
    dw MetaSprites26Set39 ; id 57
    dw MetaSprites26Set3A ; id 58
    dw MetaSprites26Set3B ; id 59
    dw MetaSprites26Set3C ; id 60
    dw MetaSprites26Set3D ; id 61
    dw MetaSprites26Set3E ; id 62
    dw MetaSprites26Set3F ; id 63
    dw MetaSprites26Set40 ; id 64
    dw MetaSprites26Set41 ; id 65
    dw MetaSprites26Set42 ; id 66
    dw MetaSprites26Set43 ; id 67
    dw MetaSprites26Set44 ; id 68
    dw MetaSprites26Set45 ; id 69
    dw MetaSprites26Set46 ; id 70
    dw MetaSprites26Set47 ; id 71
    dw MetaSprites26Set48 ; id 72
    dw MetaSprites26Set49 ; id 73
    dw MetaSprites26Set4A ; id 74
    dw MetaSprites26Set4A ; id 75
    dw MetaSprites26Set4A ; id 76
    dw MetaSprites26Set4A ; id 77
    dw MetaSprites26Set4A ; id 78
    dw MetaSprites26Set4A ; id 79
    dw MetaSprites26Set4A ; id 80
    dw MetaSprites26Set4A ; id 81
    dw MetaSprites26Set4A ; id 82
    dw MetaSprites26Set4A ; id 83
    dw MetaSprites26Set54 ; id 84
    dw MetaSprites26Set55 ; id 85
    dw MetaSprites26Set56 ; id 86
    dw MetaSprites26Set57 ; id 87
    dw MetaSprites26Set58 ; id 88
    dw MetaSprites26Set59 ; id 89
    dw MetaSprites26Set5A ; id 90
    dw MetaSprites26Set5B ; id 91
    dw MetaSprites26Set5C ; id 92
    dw MetaSprites26Set5D ; id 93
    dw MetaSprites26Set5E ; id 94
    dw MetaSprites26Set5F ; id 95
    dw MetaSprites26Set60 ; id 96
    dw MetaSprites26Set61 ; id 97
    dw MetaSprites26Set62 ; id 98
    dw MetaSprites26Set63 ; id 99
    dw MetaSprites26Set64 ; id 100
    dw MetaSprites26Set65 ; id 101
    dw MetaSprites26Set66 ; id 102
    dw MetaSprites26Set67 ; id 103
    dw MetaSprites26Set68 ; id 104
    dw MetaSprites26Set69 ; id 105
    dw MetaSprites26Set6A ; id 106
    dw MetaSprites26Set6B ; id 107
    dw MetaSprites26Set6C ; id 108
    dw MetaSprites26Set6D ; id 109
    dw MetaSprites26Set6E ; id 110
    dw MetaSprites26Set6F ; id 111
    dw MetaSprites26Set70 ; id 112
    dw MetaSprites26Set71 ; id 113
    dw MetaSprites26Set71 ; id 114
    dw MetaSprites26Set71 ; id 115
    dw MetaSprites26Set71 ; id 116
    dw MetaSprites26Set71 ; id 117
    dw MetaSprites26Set71 ; id 118
    dw MetaSprites26Set77 ; id 119
    dw MetaSprites26Set78 ; id 120
    dw MetaSprites26Set79 ; id 121
    dw MetaSprites26Set7A ; id 122
    dw MetaSprites26Set7B ; id 123
    dw MetaSprites26Set7C ; id 124
    dw MetaSprites26Set7D ; id 125
    dw MetaSprites26Set7E ; id 126
    dw MetaSprites26Set7F ; id 127

; E-0147 (C1: DrawMetaSpriteSet_Bank26 reads the byte $411E + hSpriteSetIndex; when bit 0 is set it ORs its high nibble into hSpriteAttrXor before drawing).
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites26Attrs::
Data_026_411E:: ; address name
    db $00 ; id 0
    db $00 ; id 1
    db $01 ; id 2
    db $11 ; id 3
    db $01 ; id 4
    db $00 ; id 5
    db $00 ; id 6
    db $00 ; id 7
    db $00 ; id 8
    db $00 ; id 9
    db $00 ; id 10
    db $00 ; id 11
    db $00 ; id 12
    db $00 ; id 13
    db $11 ; id 14
    db $10 ; id 15
    db $10 ; id 16
    db $11 ; id 17
    db $00 ; id 18
    db $10 ; id 19
    db $10 ; id 20
    db $01 ; id 21
    db $10 ; id 22
    db $11 ; id 23
    db $10 ; id 24
    db $10 ; id 25
    db $11 ; id 26
    db $10 ; id 27
    db $00 ; id 28
    db $00 ; id 29
    db $10 ; id 30
    db $10 ; id 31
    db $11 ; id 32
    db $01 ; id 33
    db $00 ; id 34
    db $01 ; id 35
    db $01 ; id 36
    db $00 ; id 37
    db $01 ; id 38
    db $01 ; id 39
    db $00 ; id 40
    db $00 ; id 41
    db $00 ; id 42
    db $00 ; id 43
    db $00 ; id 44
    db $00 ; id 45
    db $00 ; id 46
    db $00 ; id 47
    db $00 ; id 48
    db $00 ; id 49
    db $00 ; id 50
    db $00 ; id 51
    db $00 ; id 52
    db $00 ; id 53
    db $00 ; id 54
    db $00 ; id 55
    db $01 ; id 56
    db $10 ; id 57
    db $00 ; id 58
    db $00 ; id 59
    db $11 ; id 60
    db $00 ; id 61
    db $00 ; id 62
    db $00 ; id 63
    db $00 ; id 64
    db $00 ; id 65
    db $01 ; id 66
    db $01 ; id 67
    db $10 ; id 68
    db $01 ; id 69
    db $10 ; id 70
    db $10 ; id 71
    db $11 ; id 72
    db $11 ; id 73
    db $00 ; id 74
    db $00 ; id 75
    db $00 ; id 76
    db $00 ; id 77
    db $00 ; id 78
    db $00 ; id 79
    db $00 ; id 80
    db $00 ; id 81
    db $00 ; id 82
    db $00 ; id 83
    db $10 ; id 84
    db $00 ; id 85
    db $00 ; id 86
    db $00 ; id 87
    db $10 ; id 88
    db $00 ; id 89
    db $00 ; id 90
    db $01 ; id 91
    db $00 ; id 92
    db $00 ; id 93
    db $00 ; id 94
    db $00 ; id 95
    db $00 ; id 96
    db $00 ; id 97
    db $00 ; id 98
    db $00 ; id 99
    db $00 ; id 100
    db $01 ; id 101
    db $00 ; id 102
    db $10 ; id 103
    db $00 ; id 104
    db $01 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $00 ; id 108
    db $00 ; id 109
    db $00 ; id 110
    db $01 ; id 111
    db $01 ; id 112
    db $00 ; id 113
    db $00 ; id 114
    db $00 ; id 115
    db $00 ; id 116
    db $00 ; id 117
    db $00 ; id 118
    db $00 ; id 119
    db $00 ; id 120
    db $10 ; id 121
    db $10 ; id 122
    db $10 ; id 123
    db $10 ; id 124
    db $00 ; id 125
    db $01 ; id 126
    db $00 ; id 127

; only called from DrawMetaSpriteSet_Bank26 (E-0047)
; 1 call site from 1 routine (e.g. DrawMetaSpriteSet_Bank26)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteSet_Bank26_WaitOamNextEntry::
Func_026_419E:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hMetaSpriteYLo], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hMetaSpriteYHi], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hMetaSpriteXLo
    ldh a, [hSpriteOriginX]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hSpriteOriginXHi]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jp nz, .check_sprite_attr_xor
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, .loop2

.loop:
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, .next
    ld a, b
    cp a, $A8
    jr c, .skip
    jr .next

.read_meta_sprite_y_lo:
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, .next
    ld a, b
    cp a, $A8
    jr c, .skip

.next:
    inc hl
    inc hl
    inc hl
    jr .loop

.skip:
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_lo
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, .next2
    ld a, b
    cp a, $B8
    jr c, .skip2
    jr .next2

.read_meta_sprite_x_lo:
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $FF
    jr nz, .next2
    ld a, b
    cp a, $B8
    jr c, .skip2

.next2:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop

.skip2:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop
    ret

.loop2:
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo2
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, .next3
    ld a, b
    cp a, $A8
    jr c, .skip3
    jr .next3

.read_meta_sprite_y_lo2:
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, .next3
    ld a, b
    cp a, $A8
    jr c, .skip3

.next3:
    inc hl
    inc hl
    inc hl
    jr .loop2

.skip3:
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_flip_lo
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, .skip4
    jr nz, .next4
    ld a, b
    cp a, $B8
    jr c, .skip4
    jr .next4

.read_meta_sprite_x_flip_lo:
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $FF
    jr nz, .next4
    ld a, b
    cp a, $B8
    jr c, .skip4

.next4:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop2

.skip4:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop2
    ret

.check_sprite_attr_xor:
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, .loop5

.loop3:
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo3
    dec b

.read_meta_sprite_y_lo3:
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, .next5
    ld a, c
    cp a, $B8
    jr nc, .next5
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, .skip6
    cp a, $01
    jr nz, .cp_02
    ld a, c
    cp a, $34
    jr c, .next5
    jr .skip6

.cp_02:
    cp a, $02
    jr nz, .skip5
    ld a, c
    cp a, $71
    jr c, .skip6
    jr .next5

.skip5:
    jr .skip6

.next5:
    inc hl
    inc hl
    inc hl
    jr .loop3

.skip6:
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_lo2
    dec b

.read_meta_sprite_x_lo2:
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc a, b
    jr nz, .loop4
    ld a, c
    cp a, $B8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile

.loop4:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop3

.call_bg_tile_under_point_is_sprite_hide_tile:
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank26
    jr nc, .loop4
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop3
    ret

.loop5:
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo4
    dec b

.read_meta_sprite_y_lo4:
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, .next6
    ld a, c
    cp a, $B8
    jr nc, .next6
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, .skip8
    cp a, $01
    jr nz, .cp_022
    ld a, c
    cp a, $34
    jr c, .next6
    jr .skip8

.cp_022:
    cp a, $02
    jr nz, .skip7
    ld a, c
    cp a, $71
    jr c, .skip8
    jr .next6

.skip7:
    jr .skip8

.next6:
    inc hl
    inc hl
    inc hl
    jr .loop5

.skip8:
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_flip_lo2
    dec b

.read_meta_sprite_x_flip_lo2:
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, b
    jr nz, .loop6
    ld a, c
    cp a, $B8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile2

.loop6:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop5

.call_bg_tile_under_point_is_sprite_hide_tile2:
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank26
    jr nc, .loop6
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop5
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. DrawMetaSpriteSet_Bank26_WaitOamNextEntry)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsSpriteHideTile_Bank26::
Func_026_43E4:: ; address name
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [hSpriteHideTile]
    ld b, a
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set00::
Data_026_441A:: ; address name
    dw MetaSprites26Set00Frame0 ; entry 0
    dw MetaSprites26Set00Frame1 ; entry 1
    dw MetaSprites26Set00Frame2 ; entry 2
    dw MetaSprites26Set00Frame3 ; entry 3
    dw MetaSprites26Set00Frame4 ; entry 4
    dw MetaSprites26Set00Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame0::
Data_026_4426:: ; address name
    db $EE, $F8, $00, $00 ; entry 0
    db $EE, $00, $01, $00 ; entry 1
    db $F6, $F8, $02, $00 ; entry 2
    db $F6, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame1::
Data_026_4437:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame2::
Data_026_4448:: ; address name
    db $EE, $F8, $04, $00 ; entry 0
    db $EE, $00, $05, $00 ; entry 1
    db $F6, $F8, $06, $00 ; entry 2
    db $F6, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame3::
Data_026_4459:: ; address name
    db $F8, $F8, $09, $00 ; entry 0
    db $F8, $00, $0A, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame4::
Data_026_446A:: ; address name
    db $EE, $F8, $0B, $00 ; entry 0
    db $EE, $00, $0C, $00 ; entry 1
    db $F6, $F8, $0D, $00 ; entry 2
    db $F6, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame5::
Data_026_447B:: ; address name
    db $F0, $FF, $0B, $20 ; entry 0
    db $F0, $F7, $0C, $20 ; entry 1
    db $F8, $FF, $0D, $20 ; entry 2
    db $F8, $F7, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 1 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set01::
Data_026_448C:: ; address name
    dw MetaSprites26Set01Frame0 ; entry 0
    dw MetaSprites26Set01Frame1 ; entry 1
    dw MetaSprites26Set01Frame2 ; entry 2
    dw MetaSprites26Set01Frame3 ; entry 3
    dw MetaSprites26Set01Frame4 ; entry 4
    dw MetaSprites26Set01Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame0::
Data_026_4498:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame1::
Data_026_44A9:: ; address name
    db $EE, $F8, $02, $00 ; entry 0
    db $EE, $00, $02, $20 ; entry 1
    db $F6, $F8, $03, $00 ; entry 2
    db $F6, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame2::
Data_026_44BA:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame3::
Data_026_44CB:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F8, $F8, $09, $00 ; entry 1
    db $F0, $00, $05, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame4::
Data_026_44DC:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0A, $20 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame5::
Data_026_44ED:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set02::
Data_026_44FE:: ; address name
    dw MetaSprites26Set02Frame0 ; entry 0
    dw MetaSprites26Set02Frame1 ; entry 1
    dw MetaSprites26Set02Frame2 ; entry 2
    dw MetaSprites26Set02Frame3 ; entry 3
    dw MetaSprites26Set02Frame4 ; entry 4
    dw MetaSprites26Set02Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame0::
Data_026_450A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame1::
Data_026_451B:: ; address name
    db $EF, $FF, $00, $20 ; entry 0
    db $EF, $F8, $00, $00 ; entry 1
    db $F7, $FF, $01, $20 ; entry 2
    db $F7, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame2::
Data_026_452C:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame3::
Data_026_453D:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $07, $00 ; entry 2
    db $F7, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame4::
Data_026_454E:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame5::
Data_026_455F:: ; address name
    db $EF, $01, $09, $20 ; entry 0
    db $EF, $F9, $0A, $20 ; entry 1
    db $F7, $01, $0B, $20 ; entry 2
    db $F7, $F9, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set03::
Data_026_4570:: ; address name
    dw MetaSprites26Set03Frame0 ; entry 0
    dw MetaSprites26Set03Frame1 ; entry 1
    dw MetaSprites26Set03Frame2 ; entry 2
    dw MetaSprites26Set03Frame3 ; entry 3
    dw MetaSprites26Set03Frame4 ; entry 4
    dw MetaSprites26Set03Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame0::
Data_026_457C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame1::
Data_026_458D:: ; address name
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $00, $02, $20 ; entry 2
    db $F7, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame2::
Data_026_459E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame3::
Data_026_45AF:: ; address name
    db $EF, $00, $05, $00 ; entry 0
    db $F7, $F8, $09, $00 ; entry 1
    db $F7, $00, $0A, $00 ; entry 2
    db $EF, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame4::
Data_026_45C0:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame5::
Data_026_45D1:: ; address name
    db $EF, $00, $0B, $20 ; entry 0
    db $EF, $F8, $0B, $00 ; entry 1
    db $F7, $00, $0C, $20 ; entry 2
    db $F7, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set04::
Data_026_45E2:: ; address name
    dw MetaSprites26Set04Frame0 ; entry 0
    dw MetaSprites26Set04Frame1 ; entry 1
    dw MetaSprites26Set04Frame2 ; entry 2
    dw MetaSprites26Set04Frame3 ; entry 3
    dw MetaSprites26Set04Frame4 ; entry 4
    dw MetaSprites26Set04Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame0::
Data_026_45EE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame1::
Data_026_45FF:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame2::
Data_026_4610:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame3::
Data_026_4621:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame4::
Data_026_4632:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame5::
Data_026_4643:: ; address name
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set05::
Data_026_4654:: ; address name
    dw MetaSprites26Set05Frame0 ; entry 0
    dw MetaSprites26Set05Frame1 ; entry 1
    dw MetaSprites26Set05Frame2 ; entry 2
    dw MetaSprites26Set05Frame3 ; entry 3
    dw MetaSprites26Set05Frame4 ; entry 4
    dw MetaSprites26Set05Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame0::
Data_026_4660:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame1::
Data_026_4671:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame2::
Data_026_4682:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame3::
Data_026_4693:: ; address name
    db $F1, $00, $05, $00 ; entry 0
    db $F1, $F8, $08, $00 ; entry 1
    db $F9, $F8, $09, $00 ; entry 2
    db $F9, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame4::
Data_026_46A4:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame5::
Data_026_46B5:: ; address name
    db $F1, $00, $0B, $20 ; entry 0
    db $F1, $F8, $0C, $20 ; entry 1
    db $F9, $00, $0D, $20 ; entry 2
    db $F9, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 14 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set0E::
Data_026_46C6:: ; address name
    dw MetaSprites26Set0EFrame0 ; entry 0
    dw MetaSprites26Set0EFrame1 ; entry 1
    dw MetaSprites26Set0EFrame2 ; entry 2
    dw MetaSprites26Set0EFrame3 ; entry 3
    dw MetaSprites26Set0EFrame4 ; entry 4
    dw MetaSprites26Set0EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame0::
Data_026_46D2:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame1::
Data_026_46E3:: ; address name
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame2::
Data_026_46F4:: ; address name
    db $F8, $F8, $07, $10 ; entry 0
    db $F8, $00, $08, $10 ; entry 1
    db $F0, $F8, $09, $10 ; entry 2
    db $F0, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame3::
Data_026_4705:: ; address name
    db $F9, $F8, $07, $10 ; entry 0
    db $F9, $00, $08, $10 ; entry 1
    db $F1, $F8, $05, $10 ; entry 2
    db $F1, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame4::
Data_026_4716:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0B, $30 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame5::
Data_026_4727:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0D, $10 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set0F::
Data_026_4738:: ; address name
    dw MetaSprites26Set0FFrame0 ; entry 0
    dw MetaSprites26Set0FFrame1 ; entry 1
    dw MetaSprites26Set0FFrame2 ; entry 2
    dw MetaSprites26Set0FFrame3 ; entry 3
    dw MetaSprites26Set0FFrame4 ; entry 4
    dw MetaSprites26Set0FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame0::
Data_026_4744:: ; address name
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $00, $10 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame1::
Data_026_4755:: ; address name
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $00, $30 ; entry 1
    db $F7, $00, $01, $30 ; entry 2
    db $F7, $F8, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame2::
Data_026_4766:: ; address name
    db $EF, $F8, $03, $10 ; entry 0
    db $EF, $00, $04, $10 ; entry 1
    db $F7, $F8, $05, $10 ; entry 2
    db $F7, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame3::
Data_026_4777:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $04, $10 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame4::
Data_026_4788:: ; address name
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $00, $09, $30 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame5::
Data_026_4799:: ; address name
    db $EF, $F8, $09, $10 ; entry 0
    db $EF, $00, $09, $30 ; entry 1
    db $F7, $00, $0A, $30 ; entry 2
    db $F7, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set10::
Data_026_47AA:: ; address name
    dw MetaSprites26Set10Frame0 ; entry 0
    dw MetaSprites26Set10Frame1 ; entry 1
    dw MetaSprites26Set10Frame2 ; entry 2
    dw MetaSprites26Set10Frame3 ; entry 3
    dw MetaSprites26Set10Frame4 ; entry 4
    dw MetaSprites26Set10Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame0::
Data_026_47B6:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame1::
Data_026_47C7:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame2::
Data_026_47D8:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $09, $10 ; entry 2
    db $F8, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame3::
Data_026_47E9:: ; address name
    db $F9, $F8, $09, $10 ; entry 0
    db $F9, $00, $0A, $10 ; entry 1
    db $F1, $00, $07, $10 ; entry 2
    db $F1, $F8, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame4::
Data_026_47FA:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame5::
Data_026_480B:: ; address name
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $F8, $0D, $10 ; entry 2
    db $F1, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set11::
Data_026_481C:: ; address name
    dw MetaSprites26Set11Frame0 ; entry 0
    dw MetaSprites26Set11Frame1 ; entry 1
    dw MetaSprites26Set11Frame2 ; entry 2
    dw MetaSprites26Set11Frame3 ; entry 3
    dw MetaSprites26Set11Frame4 ; entry 4
    dw MetaSprites26Set11Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame0::
Data_026_4828:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame1::
Data_026_4839:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame2::
Data_026_484A:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame3::
Data_026_485B:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame4::
Data_026_486C:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame5::
Data_026_487D:: ; address name
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 18 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set12::
Data_026_488E:: ; address name
    dw MetaSprites26Set12Frame0 ; entry 0
    dw MetaSprites26Set12Frame1 ; entry 1
    dw MetaSprites26Set12Frame2 ; entry 2
    dw MetaSprites26Set12Frame3 ; entry 3
    dw MetaSprites26Set12Frame4 ; entry 4
    dw MetaSprites26Set12Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame0::
Data_026_489A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $04, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame1::
Data_026_48AB:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $03, $00 ; entry 1
    db $F9, $F8, $05, $00 ; entry 2
    db $F9, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame2::
Data_026_48BC:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame3::
Data_026_48CD:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $03, $00 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame4::
Data_026_48DE:: ; address name
    db $F0, $00, $0D, $20 ; entry 0
    db $F0, $F8, $0E, $20 ; entry 1
    db $F8, $00, $0F, $20 ; entry 2
    db $F8, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame5::
Data_026_48EF:: ; address name
    db $F1, $00, $0D, $20 ; entry 0
    db $F1, $F8, $0E, $20 ; entry 1
    db $F9, $00, $0F, $20 ; entry 2
    db $F9, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 19 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set13::
Data_026_4900:: ; address name
    dw MetaSprites26Set13Frame0 ; entry 0
    dw MetaSprites26Set13Frame1 ; entry 1
    dw MetaSprites26Set13Frame2 ; entry 2
    dw MetaSprites26Set13Frame3 ; entry 3
    dw MetaSprites26Set13Frame4 ; entry 4
    dw MetaSprites26Set13Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame0::
Data_026_490C:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame1::
Data_026_491D:: ; address name
    db $F0, $FF, $00, $30 ; entry 0
    db $F0, $F8, $00, $10 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame2::
Data_026_492E:: ; address name
    db $F1, $F8, $06, $10 ; entry 0
    db $F1, $00, $07, $10 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame3::
Data_026_493F:: ; address name
    db $F1, $F8, $06, $10 ; entry 0
    db $F1, $00, $07, $10 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame4::
Data_026_4950:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $FF, $03, $30 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame5::
Data_026_4961:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $FF, $03, $30 ; entry 1
    db $F8, $FF, $04, $20 ; entry 2
    db $F8, $F7, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 20 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set14::
Data_026_4972:: ; address name
    dw MetaSprites26Set14Frame0 ; entry 0
    dw MetaSprites26Set14Frame1 ; entry 1
    dw MetaSprites26Set14Frame2 ; entry 2
    dw MetaSprites26Set14Frame3 ; entry 3
    dw MetaSprites26Set14Frame4 ; entry 4
    dw MetaSprites26Set14Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame0::
Data_026_497E:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame1::
Data_026_498F:: ; address name
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $00, $00, $30 ; entry 2
    db $F1, $F8, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame2::
Data_026_49A0:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame3::
Data_026_49B1:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame4::
Data_026_49C2:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame5::
Data_026_49D3:: ; address name
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 21 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set15::
Data_026_49E4:: ; address name
    dw MetaSprites26Set15Frame0 ; entry 0
    dw MetaSprites26Set15Frame1 ; entry 1
    dw MetaSprites26Set15Frame2 ; entry 2
    dw MetaSprites26Set15Frame3 ; entry 3
    dw MetaSprites26Set15Frame4 ; entry 4
    dw MetaSprites26Set15Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame0::
Data_026_49F0:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame1::
Data_026_4A01:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame2::
Data_026_4A12:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame3::
Data_026_4A23:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame4::
Data_026_4A34:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame5::
Data_026_4A45:: ; address name
    db $EF, $FF, $0C, $20 ; entry 0
    db $EF, $F7, $0D, $20 ; entry 1
    db $F7, $FF, $0E, $20 ; entry 2
    db $F7, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 22 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set16::
Data_026_4A56:: ; address name
    dw MetaSprites26Set16Frame0 ; entry 0
    dw MetaSprites26Set16Frame1 ; entry 1
    dw MetaSprites26Set16Frame2 ; entry 2
    dw MetaSprites26Set16Frame3 ; entry 3
    dw MetaSprites26Set16Frame4 ; entry 4
    dw MetaSprites26Set16Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame0::
Data_026_4A62:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame1::
Data_026_4A73:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame2::
Data_026_4A84:: ; address name
    db $F0, $F8, $05, $10 ; entry 0
    db $F0, $00, $06, $10 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame3::
Data_026_4A95:: ; address name
    db $F1, $F8, $05, $10 ; entry 0
    db $F1, $00, $06, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame4::
Data_026_4AA6:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0B, $30 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame5::
Data_026_4AB7:: ; address name
    db $F1, $F8, $0B, $10 ; entry 0
    db $F1, $00, $0B, $30 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 23 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set17::
Data_026_4AC8:: ; address name
    dw MetaSprites26Set17Frame0 ; entry 0
    dw MetaSprites26Set17Frame1 ; entry 1
    dw MetaSprites26Set17Frame2 ; entry 2
    dw MetaSprites26Set17Frame3 ; entry 3
    dw MetaSprites26Set17Frame4 ; entry 4
    dw MetaSprites26Set17Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame0::
Data_026_4AD4:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame1::
Data_026_4AE5:: ; address name
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $00, $00, $30 ; entry 2
    db $F1, $F8, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame2::
Data_026_4AF6:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame3::
Data_026_4B07:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame4::
Data_026_4B18:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame5::
Data_026_4B29:: ; address name
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 24 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set18::
Data_026_4B3A:: ; address name
    dw MetaSprites26Set18Frame0 ; entry 0
    dw MetaSprites26Set18Frame1 ; entry 1
    dw MetaSprites26Set18Frame2 ; entry 2
    dw MetaSprites26Set18Frame3 ; entry 3
    dw MetaSprites26Set18Frame4 ; entry 4
    dw MetaSprites26Set18Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame0::
Data_026_4B46:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame1::
Data_026_4B57:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame2::
Data_026_4B68:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame3::
Data_026_4B79:: ; address name
    db $F1, $00, $05, $10 ; entry 0
    db $F1, $F8, $08, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame4::
Data_026_4B8A:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame5::
Data_026_4B9B:: ; address name
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 25 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set19::
Data_026_4BAC:: ; address name
    dw MetaSprites26Set19Frame0 ; entry 0
    dw MetaSprites26Set19Frame1 ; entry 1
    dw MetaSprites26Set19Frame2 ; entry 2
    dw MetaSprites26Set19Frame3 ; entry 3
    dw MetaSprites26Set19Frame4 ; entry 4
    dw MetaSprites26Set19Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame0::
Data_026_4BB8:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F8, $F8, $01, $10 ; entry 1
    db $F8, $00, $02, $10 ; entry 2
    db $F0, $00, $00, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame1::
Data_026_4BC9:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F9, $00, $01, $30 ; entry 1
    db $F9, $F8, $02, $30 ; entry 2
    db $F1, $F8, $00, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame2::
Data_026_4BDA:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $04, $10 ; entry 1
    db $F8, $F8, $05, $10 ; entry 2
    db $F8, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame3::
Data_026_4BEB:: ; address name
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $07, $10 ; entry 2
    db $F9, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame4::
Data_026_4BFC:: ; address name
    db $F1, $F8, $09, $10 ; entry 0
    db $F1, $00, $09, $30 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame5::
Data_026_4C0D:: ; address name
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $00, $09, $30 ; entry 1
    db $F8, $00, $0A, $30 ; entry 2
    db $F8, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1A::
Data_026_4C1E:: ; address name
    dw MetaSprites26Set1AFrame0 ; entry 0
    dw MetaSprites26Set1AFrame1 ; entry 1
    dw MetaSprites26Set1AFrame2 ; entry 2
    dw MetaSprites26Set1AFrame3 ; entry 3
    dw MetaSprites26Set1AFrame4 ; entry 4
    dw MetaSprites26Set1AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame0::
Data_026_4C2A:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame1::
Data_026_4C3B:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame2::
Data_026_4C4C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame3::
Data_026_4C5D:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame4::
Data_026_4C6E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame5::
Data_026_4C7F:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1B::
Data_026_4C90:: ; address name
    dw MetaSprites26Set1BFrame0 ; entry 0
    dw MetaSprites26Set1BFrame1 ; entry 1
    dw MetaSprites26Set1BFrame2 ; entry 2
    dw MetaSprites26Set1BFrame3 ; entry 3
    dw MetaSprites26Set1BFrame4 ; entry 4
    dw MetaSprites26Set1BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame0::
Data_026_4C9C:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame1::
Data_026_4CAD:: ; address name
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $01, $10 ; entry 1
    db $F7, $F8, $02, $10 ; entry 2
    db $F7, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame2::
Data_026_4CBE:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame3::
Data_026_4CCF:: ; address name
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $06, $10 ; entry 2
    db $F7, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame4::
Data_026_4CE0:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame5::
Data_026_4CF1:: ; address name
    db $EF, $F8, $08, $10 ; entry 0
    db $EF, $00, $09, $10 ; entry 1
    db $F7, $F8, $0A, $10 ; entry 2
    db $F7, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 28 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1C::
Data_026_4D02:: ; address name
    dw MetaSprites26Set1CFrame0 ; entry 0
    dw MetaSprites26Set1CFrame1 ; entry 1
    dw MetaSprites26Set1CFrame2 ; entry 2
    dw MetaSprites26Set1CFrame3 ; entry 3
    dw MetaSprites26Set1CFrame4 ; entry 4
    dw MetaSprites26Set1CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame0::
Data_026_4D0E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame1::
Data_026_4D1F:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame2::
Data_026_4D30:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame3::
Data_026_4D41:: ; address name
    db $F9, $F8, $09, $00 ; entry 0
    db $F9, $00, $0A, $00 ; entry 1
    db $F1, $00, $05, $00 ; entry 2
    db $F1, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame4::
Data_026_4D52:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0C, $00 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame5::
Data_026_4D63:: ; address name
    db $F0, $00, $0B, $20 ; entry 0
    db $F0, $F8, $0C, $20 ; entry 1
    db $F8, $00, $0D, $20 ; entry 2
    db $F8, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 29 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1D::
Data_026_4D74:: ; address name
    dw MetaSprites26Set1DFrame0 ; entry 0
    dw MetaSprites26Set1DFrame1 ; entry 1
    dw MetaSprites26Set1DFrame2 ; entry 2
    dw MetaSprites26Set1DFrame3 ; entry 3
    dw MetaSprites26Set1DFrame4 ; entry 4
    dw MetaSprites26Set1DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame0::
Data_026_4D80:: ; address name
    db $F0, $F7, $00, $00 ; entry 0
    db $F0, $FF, $01, $00 ; entry 1
    db $F8, $F7, $02, $00 ; entry 2
    db $F8, $FF, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame1::
Data_026_4D91:: ; address name
    db $F0, $F7, $00, $00 ; entry 0
    db $F8, $F7, $05, $00 ; entry 1
    db $F8, $FF, $06, $00 ; entry 2
    db $F0, $FF, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame2::
Data_026_4DA2:: ; address name
    db $F0, $F8, $07, $00 ; entry 0
    db $F0, $00, $08, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame3::
Data_026_4DB3:: ; address name
    db $F0, $00, $08, $00 ; entry 0
    db $F0, $F8, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame4::
Data_026_4DC4:: ; address name
    db $F8, $00, $02, $20 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F0, $F8, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame5::
Data_026_4DD5:: ; address name
    db $F8, $00, $05, $20 ; entry 0
    db $F8, $F8, $06, $20 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F0, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 30 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1E::
Data_026_4DE6:: ; address name
    dw MetaSprites26Set1EFrame0 ; entry 0
    dw MetaSprites26Set1EFrame1 ; entry 1
    dw MetaSprites26Set1EFrame2 ; entry 2
    dw MetaSprites26Set1EFrame3 ; entry 3
    dw MetaSprites26Set1EFrame4 ; entry 4
    dw MetaSprites26Set1EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame0::
Data_026_4DF2:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame1::
Data_026_4E03:: ; address name
    db $F8, $00, $02, $30 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F0, $F8, $01, $30 ; entry 2
    db $F8, $F8, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame2::
Data_026_4E14:: ; address name
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $05, $10 ; entry 2
    db $F9, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame3::
Data_026_4E25:: ; address name
    db $F0, $F8, $07, $10 ; entry 0
    db $F0, $00, $08, $10 ; entry 1
    db $F8, $F8, $09, $10 ; entry 2
    db $F8, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame4::
Data_026_4E36:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame5::
Data_026_4E47:: ; address name
    db $F7, $00, $0C, $30 ; entry 0
    db $F7, $F8, $0C, $10 ; entry 1
    db $EF, $00, $0A, $30 ; entry 2
    db $EF, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 31 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1F::
Data_026_4E58:: ; address name
    dw MetaSprites26Set1FFrame0 ; entry 0
    dw MetaSprites26Set1FFrame1 ; entry 1
    dw MetaSprites26Set1FFrame2 ; entry 2
    dw MetaSprites26Set1FFrame3 ; entry 3
    dw MetaSprites26Set1FFrame4 ; entry 4
    dw MetaSprites26Set1FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame0::
Data_026_4E64:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame1::
Data_026_4E75:: ; address name
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $00, $00, $30 ; entry 2
    db $F1, $F8, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame2::
Data_026_4E86:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame3::
Data_026_4E97:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame4::
Data_026_4EA8:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame5::
Data_026_4EB9:: ; address name
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 32 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set20::
Data_026_4ECA:: ; address name
    dw MetaSprites26Set20Frame0 ; entry 0
    dw MetaSprites26Set20Frame1 ; entry 1
    dw MetaSprites26Set20Frame2 ; entry 2
    dw MetaSprites26Set20Frame3 ; entry 3
    dw MetaSprites26Set20Frame4 ; entry 4
    dw MetaSprites26Set20Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame0::
Data_026_4ED6:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F8, $F8, $01, $10 ; entry 1
    db $F0, $00, $00, $30 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame1::
Data_026_4EE7:: ; address name
    db $F1, $F8, $02, $10 ; entry 0
    db $F1, $00, $02, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame2::
Data_026_4EF8:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame3::
Data_026_4F09:: ; address name
    db $F9, $F8, $06, $10 ; entry 0
    db $F9, $00, $07, $10 ; entry 1
    db $F1, $F8, $08, $10 ; entry 2
    db $F1, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame4::
Data_026_4F1A:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0A, $30 ; entry 1
    db $F8, $F8, $0B, $10 ; entry 2
    db $F8, $00, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame5::
Data_026_4F2B:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0C, $30 ; entry 1
    db $F9, $F8, $0D, $10 ; entry 2
    db $F9, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 33 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set21::
Data_026_4F3C:: ; address name
    dw MetaSprites26Set21Frame0 ; entry 0
    dw MetaSprites26Set21Frame1 ; entry 1
    dw MetaSprites26Set21Frame2 ; entry 2
    dw MetaSprites26Set21Frame3 ; entry 3
    dw MetaSprites26Set21Frame4 ; entry 4
    dw MetaSprites26Set21Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame0::
Data_026_4F48:: ; address name
    db $F1, $F9, $00, $00 ; entry 0
    db $F1, $01, $01, $00 ; entry 1
    db $F9, $F9, $02, $00 ; entry 2
    db $F9, $01, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame1::
Data_026_4F59:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame2::
Data_026_4F6A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame3::
Data_026_4F7B:: ; address name
    db $EF, $F7, $08, $00 ; entry 0
    db $EF, $FF, $09, $00 ; entry 1
    db $F7, $F7, $0A, $00 ; entry 2
    db $F7, $FF, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame4::
Data_026_4F8C:: ; address name
    db $F0, $F9, $0C, $00 ; entry 0
    db $F0, $01, $0D, $00 ; entry 1
    db $F8, $F9, $0E, $00 ; entry 2
    db $F8, $01, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame5::
Data_026_4F9D:: ; address name
    db $EF, $00, $0C, $20 ; entry 0
    db $EF, $F8, $0D, $20 ; entry 1
    db $F7, $00, $0E, $20 ; entry 2
    db $F7, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 34 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set22::
Data_026_4FAE:: ; address name
    dw MetaSprites26Set22Frame0 ; entry 0
    dw MetaSprites26Set22Frame1 ; entry 1
    dw MetaSprites26Set22Frame2 ; entry 2
    dw MetaSprites26Set22Frame3 ; entry 3
    dw MetaSprites26Set22Frame4 ; entry 4
    dw MetaSprites26Set22Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame0::
Data_026_4FBA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame1::
Data_026_4FCB:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $00, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame2::
Data_026_4FDC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame3::
Data_026_4FED:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame4::
Data_026_4FFE:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame5::
Data_026_500F:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $00, $0E, $20 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 35 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set23::
Data_026_5020:: ; address name
    dw MetaSprites26Set23Frame0 ; entry 0
    dw MetaSprites26Set23Frame1 ; entry 1
    dw MetaSprites26Set23Frame2 ; entry 2
    dw MetaSprites26Set23Frame3 ; entry 3
    dw MetaSprites26Set23Frame4 ; entry 4
    dw MetaSprites26Set23Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame0::
Data_026_502C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame1::
Data_026_503D:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame2::
Data_026_504E:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame3::
Data_026_505F:: ; address name
    db $F1, $F9, $05, $00 ; entry 0
    db $F1, $01, $06, $00 ; entry 1
    db $F9, $F9, $09, $00 ; entry 2
    db $F9, $01, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame4::
Data_026_5070:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame5::
Data_026_5081:: ; address name
    db $F1, $FF, $0B, $20 ; entry 0
    db $F1, $F7, $0C, $20 ; entry 1
    db $F9, $FF, $0D, $20 ; entry 2
    db $F9, $F7, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 36 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set24::
Data_026_5092:: ; address name
    dw MetaSprites26Set24Frame0 ; entry 0
    dw MetaSprites26Set24Frame1 ; entry 1
    dw MetaSprites26Set24Frame2 ; entry 2
    dw MetaSprites26Set24Frame3 ; entry 3
    dw MetaSprites26Set24Frame4 ; entry 4
    dw MetaSprites26Set24Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame0::
Data_026_509E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame1::
Data_026_50AF:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame2::
Data_026_50C0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame3::
Data_026_50D1:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame4::
Data_026_50E2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame5::
Data_026_50F3:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set25::
Data_026_5104:: ; address name
    dw MetaSprites26Set25Frame0 ; entry 0
    dw MetaSprites26Set25Frame1 ; entry 1
    dw MetaSprites26Set25Frame2 ; entry 2
    dw MetaSprites26Set25Frame3 ; entry 3
    dw MetaSprites26Set25Frame4 ; entry 4
    dw MetaSprites26Set25Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame0::
Data_026_5110:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame1::
Data_026_5121:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame2::
Data_026_5132:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame3::
Data_026_5143:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame4::
Data_026_5154:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame5::
Data_026_5165:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set26::
Data_026_5176:: ; address name
    dw MetaSprites26Set26Frame0 ; entry 0
    dw MetaSprites26Set26Frame1 ; entry 1
    dw MetaSprites26Set26Frame2 ; entry 2
    dw MetaSprites26Set26Frame3 ; entry 3
    dw MetaSprites26Set26Frame4 ; entry 4
    dw MetaSprites26Set26Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame0::
Data_026_5182:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame1::
Data_026_5193:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame2::
Data_026_51A4:: ; address name
    db $F0, $FC, $04, $00 ; entry 0
    db $F8, $F8, $06, $00 ; entry 1
    db $F8, $00, $07, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame3::
Data_026_51B1:: ; address name
    db $F1, $FC, $05, $00 ; entry 0
    db $F9, $F8, $08, $00 ; entry 1
    db $F9, $00, $09, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame4::
Data_026_51BE:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame5::
Data_026_51CF:: ; address name
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set27::
Data_026_51E0:: ; address name
    dw MetaSprites26Set27Frame0 ; entry 0
    dw MetaSprites26Set27Frame1 ; entry 1
    dw MetaSprites26Set27Frame2 ; entry 2
    dw MetaSprites26Set27Frame3 ; entry 3
    dw MetaSprites26Set27Frame4 ; entry 4
    dw MetaSprites26Set27Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame0::
Data_026_51EC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame1::
Data_026_51FD:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame2::
Data_026_520E:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame3::
Data_026_521F:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $F8, $07, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame4::
Data_026_5230:: ; address name
    db $F0, $F9, $0A, $00 ; entry 0
    db $F0, $01, $0B, $00 ; entry 1
    db $F8, $F9, $0C, $00 ; entry 2
    db $F8, $01, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame5::
Data_026_5241:: ; address name
    db $F1, $F9, $0A, $00 ; entry 0
    db $F1, $01, $0B, $00 ; entry 1
    db $F9, $F9, $0E, $00 ; entry 2
    db $F9, $01, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set28::
Data_026_5252:: ; address name
    dw MetaSprites26Set28Frame0 ; entry 0
    dw MetaSprites26Set28Frame1 ; entry 1
    dw MetaSprites26Set28Frame2 ; entry 2
    dw MetaSprites26Set28Frame3 ; entry 3
    dw MetaSprites26Set28Frame4 ; entry 4
    dw MetaSprites26Set28Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame0::
Data_026_525E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame1::
Data_026_526F:: ; address name
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $00, $20 ; entry 1
    db $FA, $F8, $03, $00 ; entry 2
    db $FA, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame2::
Data_026_5280:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame3::
Data_026_5291:: ; address name
    db $F1, $F6, $05, $00 ; entry 0
    db $F1, $FE, $06, $00 ; entry 1
    db $F9, $F7, $09, $00 ; entry 2
    db $F9, $FF, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame4::
Data_026_52A2:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame5::
Data_026_52B3:: ; address name
    db $F2, $F8, $0B, $00 ; entry 0
    db $F2, $00, $0B, $20 ; entry 1
    db $FA, $F8, $0E, $00 ; entry 2
    db $FA, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 49 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set31::
Data_026_52C4:: ; address name
    dw MetaSprites26Set31Frame0 ; entry 0
    dw MetaSprites26Set31Frame1 ; entry 1
    dw MetaSprites26Set31Frame2 ; entry 2
    dw MetaSprites26Set31Frame3 ; entry 3
    dw MetaSprites26Set31Frame4 ; entry 4
    dw MetaSprites26Set31Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame0::
Data_026_52D0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame1::
Data_026_52E1:: ; address name
    db $F0, $F7, $03, $00 ; entry 0
    db $F0, $FF, $04, $00 ; entry 1
    db $F8, $F7, $05, $00 ; entry 2
    db $F8, $FF, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame2::
Data_026_52F2:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $00, $07, $00 ; entry 2
    db $F0, $F8, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame3::
Data_026_5303:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $03, $00 ; entry 2
    db $F0, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame4::
Data_026_5314:: ; address name
    db $F8, $F8, $0D, $00 ; entry 0
    db $F8, $00, $0E, $20 ; entry 1
    db $F0, $F9, $0C, $00 ; entry 2
    db $F0, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame5::
Data_026_5325:: ; address name
    db $F8, $F9, $0E, $00 ; entry 0
    db $F8, $01, $0F, $00 ; entry 1
    db $F0, $01, $03, $20 ; entry 2
    db $F0, $F9, $04, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 50 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set32::
Data_026_5336:: ; address name
    dw MetaSprites26Set32Frame0 ; entry 0
    dw MetaSprites26Set32Frame1 ; entry 1
    dw MetaSprites26Set32Frame2 ; entry 2
    dw MetaSprites26Set32Frame3 ; entry 3
    dw MetaSprites26Set32Frame4 ; entry 4
    dw MetaSprites26Set32Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame0::
Data_026_5342:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F9, $F8, $01, $00 ; entry 1
    db $F9, $00, $01, $20 ; entry 2
    db $F1, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame1::
Data_026_5353:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame2::
Data_026_5364:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame3::
Data_026_5375:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame4::
Data_026_5386:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame5::
Data_026_5397:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 51 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set33::
Data_026_53A8:: ; address name
    dw MetaSprites26Set33Frame0 ; entry 0
    dw MetaSprites26Set33Frame1 ; entry 1
    dw MetaSprites26Set33Frame2 ; entry 2
    dw MetaSprites26Set33Frame3 ; entry 3
    dw MetaSprites26Set33Frame4 ; entry 4
    dw MetaSprites26Set33Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame0::
Data_026_53B4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame1::
Data_026_53C5:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $00, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame2::
Data_026_53D6:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame3::
Data_026_53E7:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame4::
Data_026_53F8:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame5::
Data_026_5409:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 52 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set34::
Data_026_541A:: ; address name
    dw MetaSprites26Set34Frame0 ; entry 0
    dw MetaSprites26Set34Frame1 ; entry 1
    dw MetaSprites26Set34Frame2 ; entry 2
    dw MetaSprites26Set34Frame3 ; entry 3
    dw MetaSprites26Set34Frame4 ; entry 4
    dw MetaSprites26Set34Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame0::
Data_026_5426:: ; address name
    db $F8, $F8, $01, $00 ; entry 0
    db $F8, $00, $02, $00 ; entry 1
    db $F0, $FD, $00, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame1::
Data_026_5433:: ; address name
    db $F8, $00, $01, $20 ; entry 0
    db $F8, $F8, $02, $20 ; entry 1
    db $F0, $FB, $00, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame2::
Data_026_5440:: ; address name
    db $F8, $F8, $04, $00 ; entry 0
    db $F8, $00, $05, $00 ; entry 1
    db $F0, $FA, $06, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame3::
Data_026_544D:: ; address name
    db $F0, $FB, $06, $00 ; entry 0
    db $F8, $F8, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame4::
Data_026_545A:: ; address name
    db $F0, $FD, $00, $00 ; entry 0
    db $F8, $F8, $09, $00 ; entry 1
    db $F8, $00, $0A, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame5::
Data_026_5467:: ; address name
    db $F8, $00, $09, $20 ; entry 0
    db $F8, $F8, $0A, $20 ; entry 1
    db $F0, $FB, $00, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 53 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set35::
Data_026_5474:: ; address name
    dw MetaSprites26Set35Frame0 ; entry 0
    dw MetaSprites26Set35Frame1 ; entry 1
    dw MetaSprites26Set35Frame2 ; entry 2
    dw MetaSprites26Set35Frame3 ; entry 3
    dw MetaSprites26Set35Frame4 ; entry 4
    dw MetaSprites26Set35Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame0::
Data_026_5480:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame1::
Data_026_5491:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame2::
Data_026_54A2:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame3::
Data_026_54B3:: ; address name
    db $F1, $F7, $0A, $00 ; entry 0
    db $F1, $FF, $0B, $00 ; entry 1
    db $F9, $F7, $08, $00 ; entry 2
    db $F9, $FF, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame4::
Data_026_54C4:: ; address name
    db $F0, $FB, $0C, $00 ; entry 0
    db $F8, $F8, $0E, $00 ; entry 1
    db $F8, $00, $0F, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame5::
Data_026_54D1:: ; address name
    db $F9, $F8, $0E, $00 ; entry 0
    db $F9, $00, $0F, $00 ; entry 1
    db $F1, $FB, $0D, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 54 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set36::
Data_026_54DE:: ; address name
    dw MetaSprites26Set36Frame0 ; entry 0
    dw MetaSprites26Set36Frame1 ; entry 1
    dw MetaSprites26Set36Frame2 ; entry 2
    dw MetaSprites26Set36Frame3 ; entry 3
    dw MetaSprites26Set36Frame4 ; entry 4
    dw MetaSprites26Set36Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame0::
Data_026_54EA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame1::
Data_026_54FB:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $FF, $03, $20 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame2::
Data_026_550C:: ; address name
    db $F0, $F7, $06, $00 ; entry 0
    db $F0, $FF, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame3::
Data_026_551D:: ; address name
    db $F8, $F8, $0B, $00 ; entry 0
    db $F8, $00, $0C, $00 ; entry 1
    db $F0, $00, $0A, $00 ; entry 2
    db $F0, $F8, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame4::
Data_026_552E:: ; address name
    db $F0, $F8, $0D, $00 ; entry 0
    db $F0, $FF, $0D, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame5::
Data_026_553F:: ; address name
    db $F0, $F8, $0D, $00 ; entry 0
    db $F0, $FF, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 55 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set37::
Data_026_5550:: ; address name
    dw MetaSprites26Set37Frame0 ; entry 0
    dw MetaSprites26Set37Frame1 ; entry 1
    dw MetaSprites26Set37Frame2 ; entry 2
    dw MetaSprites26Set37Frame3 ; entry 3
    dw MetaSprites26Set37Frame4 ; entry 4
    dw MetaSprites26Set37Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame0::
Data_026_555C:: ; address name
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $01, $00 ; entry 1
    db $FA, $F8, $02, $00 ; entry 2
    db $FA, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame1::
Data_026_556D:: ; address name
    db $FB, $00, $02, $20 ; entry 0
    db $FB, $F8, $03, $20 ; entry 1
    db $F3, $F8, $04, $00 ; entry 2
    db $F3, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame2::
Data_026_557E:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame3::
Data_026_558F:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame4::
Data_026_55A0:: ; address name
    db $FA, $F8, $0E, $00 ; entry 0
    db $FA, $00, $0F, $00 ; entry 1
    db $F2, $F8, $0D, $00 ; entry 2
    db $F2, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame5::
Data_026_55B1:: ; address name
    db $FB, $00, $0E, $20 ; entry 0
    db $FB, $F8, $0F, $20 ; entry 1
    db $F3, $F8, $0C, $00 ; entry 2
    db $F3, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 56 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set38::
Data_026_55C2:: ; address name
    dw MetaSprites26Set38Frame0 ; entry 0
    dw MetaSprites26Set38Frame1 ; entry 1
    dw MetaSprites26Set38Frame2 ; entry 2
    dw MetaSprites26Set38Frame3 ; entry 3
    dw MetaSprites26Set38Frame4 ; entry 4
    dw MetaSprites26Set38Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame0::
Data_026_55CE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame1::
Data_026_55DF:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F9, $F8, $03, $00 ; entry 1
    db $F1, $FF, $02, $20 ; entry 2
    db $F9, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame2::
Data_026_55F0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame3::
Data_026_5601:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame4::
Data_026_5612:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame5::
Data_026_5623:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F9, $F8, $0F, $00 ; entry 1
    db $F1, $FF, $0E, $20 ; entry 2
    db $F9, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 57 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set39::
Data_026_5634:: ; address name
    dw MetaSprites26Set39Frame0 ; entry 0
    dw MetaSprites26Set39Frame1 ; entry 1
    dw MetaSprites26Set39Frame2 ; entry 2
    dw MetaSprites26Set39Frame3 ; entry 3
    dw MetaSprites26Set39Frame4 ; entry 4
    dw MetaSprites26Set39Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame0::
Data_026_5640:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame1::
Data_026_5651:: ; address name
    db $F1, $FF, $00, $30 ; entry 0
    db $F1, $F7, $01, $30 ; entry 1
    db $F9, $FF, $02, $30 ; entry 2
    db $F9, $F7, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame2::
Data_026_5662:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F8, $08, $10 ; entry 2
    db $F1, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame3::
Data_026_5673:: ; address name
    db $F1, $F9, $08, $10 ; entry 0
    db $F1, $01, $0C, $10 ; entry 1
    db $F9, $F9, $0D, $10 ; entry 2
    db $F9, $01, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame4::
Data_026_5684:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $06, $10 ; entry 2
    db $F9, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame5::
Data_026_5695:: ; address name
    db $F9, $FF, $06, $30 ; entry 0
    db $F9, $F7, $07, $30 ; entry 1
    db $F1, $FF, $04, $30 ; entry 2
    db $F1, $F7, $05, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 58 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3A::
Data_026_56A6:: ; address name
    dw MetaSprites26Set3AFrame0 ; entry 0
    dw MetaSprites26Set3AFrame1 ; entry 1
    dw MetaSprites26Set3AFrame2 ; entry 2
    dw MetaSprites26Set3AFrame3 ; entry 3
    dw MetaSprites26Set3AFrame4 ; entry 4
    dw MetaSprites26Set3AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame0::
Data_026_56B2:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame1::
Data_026_56C3:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame2::
Data_026_56D4:: ; address name
    db $F1, $FF, $04, $00 ; entry 0
    db $F9, $F7, $05, $00 ; entry 1
    db $F9, $FF, $06, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame3::
Data_026_56E1:: ; address name
    db $F0, $FF, $07, $00 ; entry 0
    db $F8, $F7, $08, $00 ; entry 1
    db $F8, $FF, $09, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame4::
Data_026_56EE:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0A, $20 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame5::
Data_026_56FF:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 59 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3B::
Data_026_5710:: ; address name
    dw MetaSprites26Set3BFrame0 ; entry 0
    dw MetaSprites26Set3BFrame1 ; entry 1
    dw MetaSprites26Set3BFrame2 ; entry 2
    dw MetaSprites26Set3BFrame3 ; entry 3
    dw MetaSprites26Set3BFrame4 ; entry 4
    dw MetaSprites26Set3BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame0::
Data_026_571C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame1::
Data_026_572D:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame2::
Data_026_573E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame3::
Data_026_574F:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame4::
Data_026_5760:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame5::
Data_026_5771:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $FF, $0E, $20 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 60 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3C::
Data_026_5782:: ; address name
    dw MetaSprites26Set3CFrame0 ; entry 0
    dw MetaSprites26Set3CFrame1 ; entry 1
    dw MetaSprites26Set3CFrame2 ; entry 2
    dw MetaSprites26Set3CFrame3 ; entry 3
    dw MetaSprites26Set3CFrame4 ; entry 4
    dw MetaSprites26Set3CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame0::
Data_026_578E:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame1::
Data_026_579F:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $F9, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame2::
Data_026_57B0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame3::
Data_026_57C1:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame4::
Data_026_57D2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $FF, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame5::
Data_026_57E3:: ; address name
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 61 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3D::
Data_026_57F4:: ; address name
    dw MetaSprites26Set3DFrame0 ; entry 0
    dw MetaSprites26Set3DFrame1 ; entry 1
    dw MetaSprites26Set3DFrame2 ; entry 2
    dw MetaSprites26Set3DFrame3 ; entry 3
    dw MetaSprites26Set3DFrame4 ; entry 4
    dw MetaSprites26Set3DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame0::
Data_026_5800:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame1::
Data_026_5811:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame2::
Data_026_5822:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame3::
Data_026_5833:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame4::
Data_026_5844:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame5::
Data_026_5855:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 62 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3E::
Data_026_5866:: ; address name
    dw MetaSprites26Set3EFrame0 ; entry 0
    dw MetaSprites26Set3EFrame1 ; entry 1
    dw MetaSprites26Set3EFrame2 ; entry 2
    dw MetaSprites26Set3EFrame3 ; entry 3
    dw MetaSprites26Set3EFrame4 ; entry 4
    dw MetaSprites26Set3EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame0::
Data_026_5872:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame1::
Data_026_5883:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame2::
Data_026_5894:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame3::
Data_026_58A5:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame4::
Data_026_58B6:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame5::
Data_026_58C7:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 63 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3F::
Data_026_58D8:: ; address name
    dw MetaSprites26Set3FFrame0 ; entry 0
    dw MetaSprites26Set3FFrame1 ; entry 1
    dw MetaSprites26Set3FFrame2 ; entry 2
    dw MetaSprites26Set3FFrame3 ; entry 3
    dw MetaSprites26Set3FFrame4 ; entry 4
    dw MetaSprites26Set3FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame0::
Data_026_58E4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame1::
Data_026_58F5:: ; address name
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame2::
Data_026_5906:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame3::
Data_026_5917:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame4::
Data_026_5928:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame5::
Data_026_5939:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 64 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set40::
Data_026_594A:: ; address name
    dw MetaSprites26Set40Frame0 ; entry 0
    dw MetaSprites26Set40Frame1 ; entry 1
    dw MetaSprites26Set40Frame2 ; entry 2
    dw MetaSprites26Set40Frame3 ; entry 3
    dw MetaSprites26Set40Frame4 ; entry 4
    dw MetaSprites26Set40Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame0::
Data_026_5956:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame1::
Data_026_5967:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame2::
Data_026_5978:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame3::
Data_026_5989:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame4::
Data_026_599A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame5::
Data_026_59AB:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 65 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set41::
Data_026_59BC:: ; address name
    dw MetaSprites26Set41Frame0 ; entry 0
    dw MetaSprites26Set41Frame1 ; entry 1
    dw MetaSprites26Set41Frame2 ; entry 2
    dw MetaSprites26Set41Frame3 ; entry 3
    dw MetaSprites26Set41Frame4 ; entry 4
    dw MetaSprites26Set41Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame0::
Data_026_59C8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame1::
Data_026_59D9:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $00, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame2::
Data_026_59EA:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame3::
Data_026_59FB:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame4::
Data_026_5A0C:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F9, $00, $0D, $20 ; entry 1
    db $F1, $F8, $0C, $00 ; entry 2
    db $F9, $F8, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame5::
Data_026_5A1D:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 66 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set42::
Data_026_5A2E:: ; address name
    dw MetaSprites26Set42Frame0 ; entry 0
    dw MetaSprites26Set42Frame1 ; entry 1
    dw MetaSprites26Set42Frame2 ; entry 2
    dw MetaSprites26Set42Frame3 ; entry 3
    dw MetaSprites26Set42Frame4 ; entry 4
    dw MetaSprites26Set42Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame0::
Data_026_5A3A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame1::
Data_026_5A4B:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $00, $02, $20 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame2::
Data_026_5A5C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame3::
Data_026_5A6D:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame4::
Data_026_5A7E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame5::
Data_026_5A8F:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $F7, $F8, $0F, $00 ; entry 1
    db $EF, $00, $0E, $20 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 67 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set43::
Data_026_5AA0:: ; address name
    dw MetaSprites26Set43Frame0 ; entry 0
    dw MetaSprites26Set43Frame1 ; entry 1
    dw MetaSprites26Set43Frame2 ; entry 2
    dw MetaSprites26Set43Frame3 ; entry 3
    dw MetaSprites26Set43Frame4 ; entry 4
    dw MetaSprites26Set43Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame0::
Data_026_5AAC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame1::
Data_026_5ABD:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame2::
Data_026_5ACE:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame3::
Data_026_5ADF:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame4::
Data_026_5AF0:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame5::
Data_026_5B01:: ; address name
    db $F1, $FF, $0C, $20 ; entry 0
    db $F1, $F7, $0D, $20 ; entry 1
    db $F9, $FF, $0E, $20 ; entry 2
    db $F9, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 68 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set44::
Data_026_5B12:: ; address name
    dw MetaSprites26Set44Frame0 ; entry 0
    dw MetaSprites26Set44Frame1 ; entry 1
    dw MetaSprites26Set44Frame2 ; entry 2
    dw MetaSprites26Set44Frame3 ; entry 3
    dw MetaSprites26Set44Frame4 ; entry 4
    dw MetaSprites26Set44Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame0::
Data_026_5B1E:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame1::
Data_026_5B2F:: ; address name
    db $F1, $FF, $00, $30 ; entry 0
    db $F1, $F8, $00, $10 ; entry 1
    db $F9, $FF, $01, $30 ; entry 2
    db $F9, $F7, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame2::
Data_026_5B40:: ; address name
    db $F0, $F9, $03, $10 ; entry 0
    db $F0, $01, $04, $10 ; entry 1
    db $F8, $F9, $05, $10 ; entry 2
    db $F8, $01, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame3::
Data_026_5B51:: ; address name
    db $F1, $F9, $03, $10 ; entry 0
    db $F1, $01, $04, $10 ; entry 1
    db $F9, $F9, $07, $10 ; entry 2
    db $F9, $01, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame4::
Data_026_5B62:: ; address name
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $FF, $09, $30 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame5::
Data_026_5B73:: ; address name
    db $F1, $FF, $09, $30 ; entry 0
    db $F1, $F8, $09, $10 ; entry 1
    db $F9, $FF, $0A, $30 ; entry 2
    db $F9, $F7, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 69 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set45::
Data_026_5B84:: ; address name
    dw MetaSprites26Set45Frame0 ; entry 0
    dw MetaSprites26Set45Frame1 ; entry 1
    dw MetaSprites26Set45Frame2 ; entry 2
    dw MetaSprites26Set45Frame3 ; entry 3
    dw MetaSprites26Set45Frame4 ; entry 4
    dw MetaSprites26Set45Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame0::
Data_026_5B90:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame1::
Data_026_5BA1:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame2::
Data_026_5BB2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame3::
Data_026_5BC3:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame4::
Data_026_5BD4:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame5::
Data_026_5BE5:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 70 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set46::
Data_026_5BF6:: ; address name
    dw MetaSprites26Set46Frame0 ; entry 0
    dw MetaSprites26Set46Frame1 ; entry 1
    dw MetaSprites26Set46Frame2 ; entry 2
    dw MetaSprites26Set46Frame3 ; entry 3
    dw MetaSprites26Set46Frame4 ; entry 4
    dw MetaSprites26Set46Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame0::
Data_026_5C02:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame1::
Data_026_5C13:: ; address name
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $01, $30 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame2::
Data_026_5C24:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame3::
Data_026_5C35:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame4::
Data_026_5C46:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame5::
Data_026_5C57:: ; address name
    db $F0, $00, $0C, $30 ; entry 0
    db $F0, $F8, $0D, $30 ; entry 1
    db $F8, $00, $0E, $30 ; entry 2
    db $F8, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 71 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set47::
Data_026_5C68:: ; address name
    dw MetaSprites26Set47Frame0 ; entry 0
    dw MetaSprites26Set47Frame1 ; entry 1
    dw MetaSprites26Set47Frame2 ; entry 2
    dw MetaSprites26Set47Frame3 ; entry 3
    dw MetaSprites26Set47Frame4 ; entry 4
    dw MetaSprites26Set47Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame0::
Data_026_5C74:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $FF, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame1::
Data_026_5C85:: ; address name
    db $EF, $F8, $02, $10 ; entry 0
    db $EF, $FF, $02, $30 ; entry 1
    db $F7, $F8, $03, $10 ; entry 2
    db $F7, $FF, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame2::
Data_026_5C96:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame3::
Data_026_5CA7:: ; address name
    db $EF, $F8, $08, $10 ; entry 0
    db $EF, $00, $09, $10 ; entry 1
    db $F7, $F8, $0A, $10 ; entry 2
    db $F7, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame4::
Data_026_5CB8:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F8, $F8, $0D, $10 ; entry 1
    db $F0, $FF, $0C, $30 ; entry 2
    db $F8, $FF, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame5::
Data_026_5CC9:: ; address name
    db $EF, $F8, $0E, $10 ; entry 0
    db $F7, $F8, $0F, $10 ; entry 1
    db $EF, $FF, $0E, $30 ; entry 2
    db $F7, $FF, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 72 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set48::
Data_026_5CDA:: ; address name
    dw MetaSprites26Set48Frame0 ; entry 0
    dw MetaSprites26Set48Frame1 ; entry 1
    dw MetaSprites26Set48Frame2 ; entry 2
    dw MetaSprites26Set48Frame3 ; entry 3
    dw MetaSprites26Set48Frame4 ; entry 4
    dw MetaSprites26Set48Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame0::
Data_026_5CE6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame1::
Data_026_5CF7:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame2::
Data_026_5D08:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame3::
Data_026_5D19:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame4::
Data_026_5D2A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame5::
Data_026_5D3B:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 73 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set49::
Data_026_5D4C:: ; address name
    dw MetaSprites26Set49Frame0 ; entry 0
    dw MetaSprites26Set49Frame1 ; entry 1
    dw MetaSprites26Set49Frame2 ; entry 2
    dw MetaSprites26Set49Frame3 ; entry 3
    dw MetaSprites26Set49Frame4 ; entry 4
    dw MetaSprites26Set49Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame0::
Data_026_5D58:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame1::
Data_026_5D69:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame2::
Data_026_5D7A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame3::
Data_026_5D8B:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame4::
Data_026_5D9C:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame5::
Data_026_5DAD:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 74 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set4A::
Data_026_5DBE:: ; address name
    dw MetaSprites26Set4AFrame0 ; entry 0
    dw MetaSprites26Set4AFrame1 ; entry 1
    dw MetaSprites26Set4AFrame2 ; entry 2
    dw MetaSprites26Set4AFrame3 ; entry 3
    dw MetaSprites26Set4AFrame4 ; entry 4
    dw MetaSprites26Set4AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame0::
Data_026_5DCA:: ; address name
    db $F8, $F8, $01, $00 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame1::
Data_026_5DDB:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame2::
Data_026_5DEC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame3::
Data_026_5DFD:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame4::
Data_026_5E0E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame5::
Data_026_5E1F:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $FF, $0E, $20 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 84 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set54::
Data_026_5E30:: ; address name
    dw MetaSprites26Set54Frame0 ; entry 0
    dw MetaSprites26Set54Frame1 ; entry 1
    dw MetaSprites26Set54Frame2 ; entry 2
    dw MetaSprites26Set54Frame3 ; entry 3
    dw MetaSprites26Set54Frame4 ; entry 4
    dw MetaSprites26Set54Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame0::
Data_026_5E3C:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame1::
Data_026_5E4D:: ; address name
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $02, $30 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame2::
Data_026_5E5E:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $06, $10 ; entry 2
    db $F9, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame3::
Data_026_5E6F:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame4::
Data_026_5E80:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0C, $30 ; entry 1
    db $F9, $F8, $0D, $10 ; entry 2
    db $F9, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame5::
Data_026_5E91:: ; address name
    db $F0, $F8, $0E, $10 ; entry 0
    db $F0, $00, $0E, $30 ; entry 1
    db $F8, $F8, $0F, $10 ; entry 2
    db $F8, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 85 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set55::
Data_026_5EA2:: ; address name
    dw MetaSprites26Set55Frame0 ; entry 0
    dw MetaSprites26Set55Frame1 ; entry 1
    dw MetaSprites26Set55Frame2 ; entry 2
    dw MetaSprites26Set55Frame3 ; entry 3
    dw MetaSprites26Set55Frame4 ; entry 4
    dw MetaSprites26Set55Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame0::
Data_026_5EAE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame1::
Data_026_5EBF:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame2::
Data_026_5ED0:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame3::
Data_026_5EE1:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame4::
Data_026_5EF2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame5::
Data_026_5F03:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 86 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set56::
Data_026_5F14:: ; address name
    dw MetaSprites26Set56Frame0 ; entry 0
    dw MetaSprites26Set56Frame1 ; entry 1
    dw MetaSprites26Set56Frame2 ; entry 2
    dw MetaSprites26Set56Frame3 ; entry 3
    dw MetaSprites26Set56Frame4 ; entry 4
    dw MetaSprites26Set56Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame0::
Data_026_5F20:: ; address name
    db $F3, $F9, $00, $00 ; entry 0
    db $F3, $01, $01, $00 ; entry 1
    db $FB, $F9, $02, $00 ; entry 2
    db $FB, $01, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame1::
Data_026_5F31:: ; address name
    db $F2, $F9, $00, $00 ; entry 0
    db $F2, $01, $01, $00 ; entry 1
    db $FA, $F9, $04, $00 ; entry 2
    db $FA, $01, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame2::
Data_026_5F42:: ; address name
    db $F0, $F6, $0A, $00 ; entry 0
    db $F0, $FE, $0B, $00 ; entry 1
    db $F8, $F6, $0C, $00 ; entry 2
    db $F8, $FE, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame3::
Data_026_5F53:: ; address name
    db $F1, $F6, $0A, $00 ; entry 0
    db $F1, $FE, $0B, $00 ; entry 1
    db $F9, $FE, $0E, $00 ; entry 2
    db $F9, $F6, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame4::
Data_026_5F64:: ; address name
    db $F3, $F6, $06, $00 ; entry 0
    db $F3, $FE, $07, $00 ; entry 1
    db $FB, $FE, $08, $00 ; entry 2
    db $FB, $F6, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame5::
Data_026_5F75:: ; address name
    db $F2, $F6, $06, $00 ; entry 0
    db $F2, $FE, $07, $00 ; entry 1
    db $FA, $FE, $09, $00 ; entry 2
    db $FA, $F6, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 87 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set57::
Data_026_5F86:: ; address name
    dw MetaSprites26Set57Frame0 ; entry 0
    dw MetaSprites26Set57Frame1 ; entry 1
    dw MetaSprites26Set57Frame2 ; entry 2
    dw MetaSprites26Set57Frame3 ; entry 3
    dw MetaSprites26Set57Frame4 ; entry 4
    dw MetaSprites26Set57Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame0::
Data_026_5F92:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame1::
Data_026_5FA3:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame2::
Data_026_5FB4:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame3::
Data_026_5FC5:: ; address name
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $04, $00 ; entry 1
    db $F9, $F8, $07, $00 ; entry 2
    db $F9, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame4::
Data_026_5FD6:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame5::
Data_026_5FE7:: ; address name
    db $F1, $F8, $09, $00 ; entry 0
    db $F1, $FF, $09, $20 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 88 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set58::
Data_026_5FF8:: ; address name
    dw MetaSprites26Set58Frame0 ; entry 0
    dw MetaSprites26Set58Frame1 ; entry 1
    dw MetaSprites26Set58Frame2 ; entry 2
    dw MetaSprites26Set58Frame3 ; entry 3
    dw MetaSprites26Set58Frame4 ; entry 4
    dw MetaSprites26Set58Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame0::
Data_026_6004:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame1::
Data_026_6015:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame2::
Data_026_6026:: ; address name
    db $F0, $F8, $05, $10 ; entry 0
    db $F8, $F8, $07, $10 ; entry 1
    db $F8, $00, $08, $10 ; entry 2
    db $F0, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame3::
Data_026_6037:: ; address name
    db $F1, $F8, $05, $10 ; entry 0
    db $F1, $00, $06, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame4::
Data_026_6048:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0B, $30 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame5::
Data_026_6059:: ; address name
    db $F1, $F8, $0B, $10 ; entry 0
    db $F1, $00, $0B, $30 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 89 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set59::
Data_026_606A:: ; address name
    dw MetaSprites26Set59Frame0 ; entry 0
    dw MetaSprites26Set59Frame1 ; entry 1
    dw MetaSprites26Set59Frame2 ; entry 2
    dw MetaSprites26Set59Frame3 ; entry 3
    dw MetaSprites26Set59Frame4 ; entry 4
    dw MetaSprites26Set59Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame0::
Data_026_6076:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame1::
Data_026_6087:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame2::
Data_026_6098:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame3::
Data_026_60A9:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame4::
Data_026_60BA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame5::
Data_026_60CB:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 90 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5A::
Data_026_60DC:: ; address name
    dw MetaSprites26Set5AFrame0 ; entry 0
    dw MetaSprites26Set5AFrame1 ; entry 1
    dw MetaSprites26Set5AFrame2 ; entry 2
    dw MetaSprites26Set5AFrame3 ; entry 3
    dw MetaSprites26Set5AFrame4 ; entry 4
    dw MetaSprites26Set5AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame0::
Data_026_60E8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame1::
Data_026_60F9:: ; address name
    db $F8, $F8, $03, $00 ; entry 0
    db $F8, $00, $04, $00 ; entry 1
    db $F0, $F9, $00, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame2::
Data_026_610A:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame3::
Data_026_611B:: ; address name
    db $F0, $00, $06, $00 ; entry 0
    db $F0, $F8, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame4::
Data_026_612C:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame5::
Data_026_613D:: ; address name
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $F9, $0F, $00 ; entry 2
    db $F0, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 91 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5B::
Data_026_614E:: ; address name
    dw MetaSprites26Set5BFrame0 ; entry 0
    dw MetaSprites26Set5BFrame1 ; entry 1
    dw MetaSprites26Set5BFrame2 ; entry 2
    dw MetaSprites26Set5BFrame3 ; entry 3
    dw MetaSprites26Set5BFrame4 ; entry 4
    dw MetaSprites26Set5BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame0::
Data_026_615A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame1::
Data_026_616B:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame2::
Data_026_617C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame3::
Data_026_618D:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame4::
Data_026_619E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame5::
Data_026_61AF:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 92 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5C::
Data_026_61C0:: ; address name
    dw MetaSprites26Set5CFrame0 ; entry 0
    dw MetaSprites26Set5CFrame1 ; entry 1
    dw MetaSprites26Set5CFrame2 ; entry 2
    dw MetaSprites26Set5CFrame3 ; entry 3
    dw MetaSprites26Set5CFrame4 ; entry 4
    dw MetaSprites26Set5CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame0::
Data_026_61CC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame1::
Data_026_61DD:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $FF, $02, $20 ; entry 2
    db $F7, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame2::
Data_026_61EE:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame3::
Data_026_61FF:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame4::
Data_026_6210:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame5::
Data_026_6221:: ; address name
    db $EF, $F8, $0A, $00 ; entry 0
    db $EF, $00, $0B, $00 ; entry 1
    db $F7, $01, $0C, $20 ; entry 2
    db $F7, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 93 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5D::
Data_026_6232:: ; address name
    dw MetaSprites26Set5DFrame0 ; entry 0
    dw MetaSprites26Set5DFrame1 ; entry 1
    dw MetaSprites26Set5DFrame2 ; entry 2
    dw MetaSprites26Set5DFrame3 ; entry 3
    dw MetaSprites26Set5DFrame4 ; entry 4
    dw MetaSprites26Set5DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame0::
Data_026_623E:: ; address name
    db $F0, $F9, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F9, $01, $00 ; entry 2
    db $F8, $01, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame1::
Data_026_624F:: ; address name
    db $F8, $00, $01, $20 ; entry 0
    db $F8, $F8, $02, $20 ; entry 1
    db $F0, $F9, $03, $00 ; entry 2
    db $F0, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame2::
Data_026_6260:: ; address name
    db $F0, $F5, $04, $00 ; entry 0
    db $F0, $FD, $05, $00 ; entry 1
    db $F8, $F5, $06, $00 ; entry 2
    db $F8, $FD, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame3::
Data_026_6271:: ; address name
    db $F0, $FD, $05, $00 ; entry 0
    db $F8, $F5, $06, $40 ; entry 1
    db $F0, $F5, $08, $00 ; entry 2
    db $F8, $FD, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame4::
Data_026_6282:: ; address name
    db $F8, $F8, $0B, $00 ; entry 0
    db $F8, $00, $0C, $00 ; entry 1
    db $F0, $FF, $0A, $20 ; entry 2
    db $F0, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame5::
Data_026_6293:: ; address name
    db $F8, $FF, $0B, $20 ; entry 0
    db $F8, $F7, $0C, $20 ; entry 1
    db $F0, $F8, $0D, $00 ; entry 2
    db $F0, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 94 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5E::
Data_026_62A4:: ; address name
    dw MetaSprites26Set5EFrame0 ; entry 0
    dw MetaSprites26Set5EFrame1 ; entry 1
    dw MetaSprites26Set5EFrame2 ; entry 2
    dw MetaSprites26Set5EFrame3 ; entry 3
    dw MetaSprites26Set5EFrame4 ; entry 4
    dw MetaSprites26Set5EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame0::
Data_026_62B0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame1::
Data_026_62C1:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame2::
Data_026_62D2:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame3::
Data_026_62E3:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame4::
Data_026_62F4:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame5::
Data_026_6305:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 95 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5F::
Data_026_6316:: ; address name
    dw MetaSprites26Set5FFrame0 ; entry 0
    dw MetaSprites26Set5FFrame1 ; entry 1
    dw MetaSprites26Set5FFrame2 ; entry 2
    dw MetaSprites26Set5FFrame3 ; entry 3
    dw MetaSprites26Set5FFrame4 ; entry 4
    dw MetaSprites26Set5FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame0::
Data_026_6322:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame1::
Data_026_6333:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame2::
Data_026_6344:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame3::
Data_026_6355:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame4::
Data_026_6366:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame5::
Data_026_6377:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 96 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set60::
Data_026_6388:: ; address name
    dw MetaSprites26Set60Frame0 ; entry 0
    dw MetaSprites26Set60Frame1 ; entry 1
    dw MetaSprites26Set60Frame2 ; entry 2
    dw MetaSprites26Set60Frame3 ; entry 3
    dw MetaSprites26Set60Frame4 ; entry 4
    dw MetaSprites26Set60Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame0::
Data_026_6394:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame1::
Data_026_63A5:: ; address name
    db $EE, $00, $00, $20 ; entry 0
    db $EE, $F8, $01, $20 ; entry 1
    db $F6, $00, $02, $20 ; entry 2
    db $F6, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame2::
Data_026_63B6:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame3::
Data_026_63C7:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame4::
Data_026_63D8:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame5::
Data_026_63E9:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 97 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set61::
Data_026_63FA:: ; address name
    dw MetaSprites26Set61Frame0 ; entry 0
    dw MetaSprites26Set61Frame1 ; entry 1
    dw MetaSprites26Set61Frame2 ; entry 2
    dw MetaSprites26Set61Frame3 ; entry 3
    dw MetaSprites26Set61Frame4 ; entry 4
    dw MetaSprites26Set61Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame0::
Data_026_6406:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame1::
Data_026_6417:: ; address name
    db $F8, $F8, $04, $00 ; entry 0
    db $F8, $00, $05, $00 ; entry 1
    db $F0, $F7, $00, $00 ; entry 2
    db $F0, $FF, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame2::
Data_026_6428:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame3::
Data_026_6439:: ; address name
    db $F0, $F9, $06, $00 ; entry 0
    db $F0, $01, $07, $00 ; entry 1
    db $F8, $F9, $0A, $00 ; entry 2
    db $F8, $01, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame4::
Data_026_644A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame5::
Data_026_645B:: ; address name
    db $F8, $00, $0E, $20 ; entry 0
    db $F8, $F8, $0F, $20 ; entry 1
    db $F0, $F7, $0C, $00 ; entry 2
    db $F0, $FF, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 98 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set62::
Data_026_646C:: ; address name
    dw MetaSprites26Set62Frame0 ; entry 0
    dw MetaSprites26Set62Frame1 ; entry 1
    dw MetaSprites26Set62Frame2 ; entry 2
    dw MetaSprites26Set62Frame3 ; entry 3
    dw MetaSprites26Set62Frame4 ; entry 4
    dw MetaSprites26Set62Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame0::
Data_026_6478:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame1::
Data_026_6489:: ; address name
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $00, $02, $20 ; entry 2
    db $F7, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame2::
Data_026_649A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame3::
Data_026_64AB:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame4::
Data_026_64BC:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame5::
Data_026_64CD:: ; address name
    db $EF, $00, $0C, $20 ; entry 0
    db $EF, $F8, $0D, $20 ; entry 1
    db $F7, $00, $0E, $20 ; entry 2
    db $F7, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 99 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set63::
Data_026_64DE:: ; address name
    dw MetaSprites26Set63Frame0 ; entry 0
    dw MetaSprites26Set63Frame1 ; entry 1
    dw MetaSprites26Set63Frame2 ; entry 2
    dw MetaSprites26Set63Frame3 ; entry 3
    dw MetaSprites26Set63Frame4 ; entry 4
    dw MetaSprites26Set63Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame0::
Data_026_64EA:: ; address name
    db $F8, $F8, $01, $00 ; entry 0
    db $F8, $00, $02, $00 ; entry 1
    db $F0, $F9, $00, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame1::
Data_026_64FB:: ; address name
    db $F0, $FA, $00, $00 ; entry 0
    db $F0, $01, $00, $20 ; entry 1
    db $F8, $F9, $03, $00 ; entry 2
    db $F8, $01, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame2::
Data_026_650C:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame3::
Data_026_651D:: ; address name
    db $F0, $F7, $05, $00 ; entry 0
    db $F0, $FF, $06, $00 ; entry 1
    db $F8, $F7, $09, $00 ; entry 2
    db $F8, $FF, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame4::
Data_026_652E:: ; address name
    db $F8, $F8, $0C, $00 ; entry 0
    db $F8, $00, $0E, $00 ; entry 1
    db $F0, $F9, $0B, $00 ; entry 2
    db $F0, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame5::
Data_026_653F:: ; address name
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $F8, $0B, $00 ; entry 2
    db $F0, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 100 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set64::
Data_026_6550:: ; address name
    dw MetaSprites26Set64Frame0 ; entry 0
    dw MetaSprites26Set64Frame1 ; entry 1
    dw MetaSprites26Set64Frame2 ; entry 2
    dw MetaSprites26Set64Frame3 ; entry 3
    dw MetaSprites26Set64Frame4 ; entry 4
    dw MetaSprites26Set64Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame0::
Data_026_655C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame1::
Data_026_656D:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame2::
Data_026_657E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame3::
Data_026_658F:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame4::
Data_026_65A0:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame5::
Data_026_65B1:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 101 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set65::
Data_026_65C2:: ; address name
    dw MetaSprites26Set65Frame0 ; entry 0
    dw MetaSprites26Set65Frame1 ; entry 1
    dw MetaSprites26Set65Frame2 ; entry 2
    dw MetaSprites26Set65Frame3 ; entry 3
    dw MetaSprites26Set65Frame4 ; entry 4
    dw MetaSprites26Set65Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame0::
Data_026_65CE:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame1::
Data_026_65DF:: ; address name
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $01, $00 ; entry 1
    db $FA, $F8, $04, $00 ; entry 2
    db $FA, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame2::
Data_026_65F0:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame3::
Data_026_6601:: ; address name
    db $F2, $F8, $06, $00 ; entry 0
    db $F2, $00, $07, $00 ; entry 1
    db $FA, $F8, $0A, $00 ; entry 2
    db $FA, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame4::
Data_026_6612:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $00, $0E, $00 ; entry 2
    db $F9, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame5::
Data_026_6623:: ; address name
    db $F2, $F8, $0C, $00 ; entry 0
    db $F2, $00, $0D, $00 ; entry 1
    db $FA, $00, $0F, $00 ; entry 2
    db $FA, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 102 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set66::
Data_026_6634:: ; address name
    dw MetaSprites26Set66Frame0 ; entry 0
    dw MetaSprites26Set66Frame1 ; entry 1
    dw MetaSprites26Set66Frame2 ; entry 2
    dw MetaSprites26Set66Frame3 ; entry 3
    dw MetaSprites26Set66Frame4 ; entry 4
    dw MetaSprites26Set66Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame0::
Data_026_6640:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame1::
Data_026_6651:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame2::
Data_026_6662:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame3::
Data_026_6673:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame4::
Data_026_6684:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame5::
Data_026_6695:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 103 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set67::
Data_026_66A6:: ; address name
    dw MetaSprites26Set67Frame0 ; entry 0
    dw MetaSprites26Set67Frame1 ; entry 1
    dw MetaSprites26Set67Frame2 ; entry 2
    dw MetaSprites26Set67Frame3 ; entry 3
    dw MetaSprites26Set67Frame4 ; entry 4
    dw MetaSprites26Set67Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame0::
Data_026_66B2:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame1::
Data_026_66C3:: ; address name
    db $F8, $FF, $01, $30 ; entry 0
    db $F8, $F7, $02, $30 ; entry 1
    db $F0, $F8, $03, $10 ; entry 2
    db $F0, $FF, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame2::
Data_026_66D4:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame3::
Data_026_66E5:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame4::
Data_026_66F6:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $FF, $0C, $30 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame5::
Data_026_6707:: ; address name
    db $F8, $FF, $0D, $30 ; entry 0
    db $F8, $F7, $0E, $30 ; entry 1
    db $F0, $F8, $0F, $10 ; entry 2
    db $F0, $FF, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 104 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set68::
Data_026_6718:: ; address name
    dw MetaSprites26Set68Frame0 ; entry 0
    dw MetaSprites26Set68Frame1 ; entry 1
    dw MetaSprites26Set68Frame2 ; entry 2
    dw MetaSprites26Set68Frame3 ; entry 3
    dw MetaSprites26Set68Frame4 ; entry 4
    dw MetaSprites26Set68Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame0::
Data_026_6724:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame1::
Data_026_6735:: ; address name
    db $F0, $00, $01, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F8, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame2::
Data_026_6746:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame3::
Data_026_6757:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $08, $00 ; entry 2
    db $F8, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame4::
Data_026_6768:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame5::
Data_026_6779:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 105 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set69::
Data_026_678A:: ; address name
    dw MetaSprites26Set69Frame0 ; entry 0
    dw MetaSprites26Set69Frame1 ; entry 1
    dw MetaSprites26Set69Frame2 ; entry 2
    dw MetaSprites26Set69Frame3 ; entry 3
    dw MetaSprites26Set69Frame4 ; entry 4
    dw MetaSprites26Set69Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame0::
Data_026_6796:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame1::
Data_026_67A7:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame2::
Data_026_67B8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame3::
Data_026_67C9:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame4::
Data_026_67DA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame5::
Data_026_67EB:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 106 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6A::
Data_026_67FC:: ; address name
    dw MetaSprites26Set6AFrame0 ; entry 0
    dw MetaSprites26Set6AFrame1 ; entry 1
    dw MetaSprites26Set6AFrame2 ; entry 2
    dw MetaSprites26Set6AFrame3 ; entry 3
    dw MetaSprites26Set6AFrame4 ; entry 4
    dw MetaSprites26Set6AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame0::
Data_026_6808:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame1::
Data_026_6819:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame2::
Data_026_682A:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F0, $F9, $06, $00 ; entry 1
    db $F0, $01, $07, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame3::
Data_026_683B:: ; address name
    db $F8, $F8, $09, $00 ; entry 0
    db $F0, $F9, $06, $00 ; entry 1
    db $F0, $01, $07, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame4::
Data_026_684C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame5::
Data_026_685D:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 107 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6B::
Data_026_686E:: ; address name
    dw MetaSprites26Set6BFrame0 ; entry 0
    dw MetaSprites26Set6BFrame1 ; entry 1
    dw MetaSprites26Set6BFrame2 ; entry 2
    dw MetaSprites26Set6BFrame3 ; entry 3
    dw MetaSprites26Set6BFrame4 ; entry 4
    dw MetaSprites26Set6BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame0::
Data_026_687A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame1::
Data_026_688B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame2::
Data_026_689C:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame3::
Data_026_68AD:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame4::
Data_026_68BE:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame5::
Data_026_68CF:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $01, $0E, $20 ; entry 2
    db $F8, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 108 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6C::
Data_026_68E0:: ; address name
    dw MetaSprites26Set6CFrame0 ; entry 0
    dw MetaSprites26Set6CFrame1 ; entry 1
    dw MetaSprites26Set6CFrame2 ; entry 2
    dw MetaSprites26Set6CFrame3 ; entry 3
    dw MetaSprites26Set6CFrame4 ; entry 4
    dw MetaSprites26Set6CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame0::
Data_026_68EC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame1::
Data_026_68FD:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame2::
Data_026_690E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame3::
Data_026_691F:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame4::
Data_026_6930:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F8, $F8, $08, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame5::
Data_026_6941:: ; address name
    db $F0, $00, $0C, $00 ; entry 0
    db $F0, $F8, $0E, $00 ; entry 1
    db $F8, $00, $0F, $00 ; entry 2
    db $F8, $F8, $0A, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 109 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6D::
Data_026_6952:: ; address name
    dw MetaSprites26Set6DFrame0 ; entry 0
    dw MetaSprites26Set6DFrame1 ; entry 1
    dw MetaSprites26Set6DFrame2 ; entry 2
    dw MetaSprites26Set6DFrame3 ; entry 3
    dw MetaSprites26Set6DFrame4 ; entry 4
    dw MetaSprites26Set6DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame0::
Data_026_695E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame1::
Data_026_696F:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F9, $00, $00 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame2::
Data_026_6980:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame3::
Data_026_6991:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame4::
Data_026_69A2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame5::
Data_026_69B3:: ; address name
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $00, $0F, $20 ; entry 2
    db $F0, $F9, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 110 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6E::
Data_026_69C4:: ; address name
    dw MetaSprites26Set6EFrame0 ; entry 0
    dw MetaSprites26Set6EFrame1 ; entry 1
    dw MetaSprites26Set6EFrame2 ; entry 2
    dw MetaSprites26Set6EFrame3 ; entry 3
    dw MetaSprites26Set6EFrame4 ; entry 4
    dw MetaSprites26Set6EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame0::
Data_026_69D0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame1::
Data_026_69E1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame2::
Data_026_69F2:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame3::
Data_026_6A03:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame4::
Data_026_6A14:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame5::
Data_026_6A25:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 111 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6F::
Data_026_6A36:: ; address name
    dw MetaSprites26Set6FFrame0 ; entry 0
    dw MetaSprites26Set6FFrame1 ; entry 1
    dw MetaSprites26Set6FFrame2 ; entry 2
    dw MetaSprites26Set6FFrame3 ; entry 3
    dw MetaSprites26Set6FFrame4 ; entry 4
    dw MetaSprites26Set6FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame0::
Data_026_6A42:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame1::
Data_026_6A53:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame2::
Data_026_6A64:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame3::
Data_026_6A75:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame4::
Data_026_6A86:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame5::
Data_026_6A97:: ; address name
    db $F1, $FF, $0C, $20 ; entry 0
    db $F1, $F7, $0D, $20 ; entry 1
    db $F9, $FF, $0E, $20 ; entry 2
    db $F9, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 112 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set70::
Data_026_6AA8:: ; address name
    dw MetaSprites26Set70Frame0 ; entry 0
    dw MetaSprites26Set70Frame1 ; entry 1
    dw MetaSprites26Set70Frame2 ; entry 2
    dw MetaSprites26Set70Frame3 ; entry 3
    dw MetaSprites26Set70Frame4 ; entry 4
    dw MetaSprites26Set70Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame0::
Data_026_6AB4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame1::
Data_026_6AC5:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame2::
Data_026_6AD6:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame3::
Data_026_6AE7:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame4::
Data_026_6AF8:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame5::
Data_026_6B09:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 113 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set71::
Data_026_6B1A:: ; address name
    dw MetaSprites26Set71Frame0 ; entry 0
    dw MetaSprites26Set71Frame1 ; entry 1
    dw MetaSprites26Set71Frame2 ; entry 2
    dw MetaSprites26Set71Frame3 ; entry 3
    dw MetaSprites26Set71Frame4 ; entry 4
    dw MetaSprites26Set71Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame0::
Data_026_6B26:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame1::
Data_026_6B37:: ; address name
    db $F9, $F8, $04, $00 ; entry 0
    db $F9, $00, $05, $00 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame2::
Data_026_6B48:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame3::
Data_026_6B59:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $00, $09, $00 ; entry 2
    db $F9, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame4::
Data_026_6B6A:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame5::
Data_026_6B7B:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0C, $00 ; entry 1
    db $F9, $00, $0F, $00 ; entry 2
    db $F9, $F8, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 119 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set77::
Data_026_6B8C:: ; address name
    dw MetaSprites26Set77Frame0 ; entry 0
    dw MetaSprites26Set77Frame1 ; entry 1
    dw MetaSprites26Set77Frame2 ; entry 2
    dw MetaSprites26Set77Frame3 ; entry 3
    dw MetaSprites26Set77Frame4 ; entry 4
    dw MetaSprites26Set77Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame0::
Data_026_6B98:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame1::
Data_026_6BA9:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F0, $F7, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame2::
Data_026_6BBA:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame3::
Data_026_6BCB:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame4::
Data_026_6BDC:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame5::
Data_026_6BED:: ; address name
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 120 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set78::
Data_026_6BFE:: ; address name
    dw MetaSprites26Set78Frame0 ; entry 0
    dw MetaSprites26Set78Frame1 ; entry 1
    dw MetaSprites26Set78Frame2 ; entry 2
    dw MetaSprites26Set78Frame3 ; entry 3
    dw MetaSprites26Set78Frame4 ; entry 4
    dw MetaSprites26Set78Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame0::
Data_026_6C0A:: ; address name
    db $F3, $F8, $00, $00 ; entry 0
    db $F3, $00, $01, $00 ; entry 1
    db $FB, $F8, $02, $00 ; entry 2
    db $FB, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame1::
Data_026_6C1B:: ; address name
    db $FB, $00, $02, $20 ; entry 0
    db $FB, $F8, $03, $20 ; entry 1
    db $F3, $F8, $04, $00 ; entry 2
    db $F3, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame2::
Data_026_6C2C:: ; address name
    db $F3, $F8, $06, $00 ; entry 0
    db $F3, $00, $07, $00 ; entry 1
    db $FB, $F8, $08, $00 ; entry 2
    db $FB, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame3::
Data_026_6C3D:: ; address name
    db $F3, $F9, $06, $00 ; entry 0
    db $FB, $F9, $09, $20 ; entry 1
    db $F2, $01, $07, $00 ; entry 2
    db $FA, $01, $08, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame4::
Data_026_6C4E:: ; address name
    db $F3, $F8, $0A, $00 ; entry 0
    db $F3, $00, $0B, $00 ; entry 1
    db $FB, $F8, $0C, $00 ; entry 2
    db $FB, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame5::
Data_026_6C5F:: ; address name
    db $F3, $F8, $0E, $00 ; entry 0
    db $F3, $00, $0F, $00 ; entry 1
    db $FB, $00, $0C, $20 ; entry 2
    db $FB, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 121 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set79::
Data_026_6C70:: ; address name
    dw MetaSprites26Set79Frame0 ; entry 0
    dw MetaSprites26Set79Frame1 ; entry 1
    dw MetaSprites26Set79Frame2 ; entry 2
    dw MetaSprites26Set79Frame3 ; entry 3
    dw MetaSprites26Set79Frame4 ; entry 4
    dw MetaSprites26Set79Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame0::
Data_026_6C7C:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FE, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame1::
Data_026_6C8D:: ; address name
    db $F8, $F8, $04, $10 ; entry 0
    db $F8, $00, $05, $10 ; entry 1
    db $F0, $01, $01, $10 ; entry 2
    db $F0, $FA, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame2::
Data_026_6C9E:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $00, $09, $10 ; entry 2
    db $F8, $F8, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame3::
Data_026_6CAF:: ; address name
    db $F8, $00, $0A, $10 ; entry 0
    db $F8, $F8, $03, $30 ; entry 1
    db $F0, $F9, $06, $10 ; entry 2
    db $F0, $01, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame4::
Data_026_6CC0:: ; address name
    db $F8, $00, $03, $10 ; entry 0
    db $F0, $F9, $0B, $10 ; entry 1
    db $F0, $FF, $0C, $10 ; entry 2
    db $F8, $F8, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame5::
Data_026_6CD1:: ; address name
    db $F0, $01, $0C, $10 ; entry 0
    db $F0, $FA, $0C, $30 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 122 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7A::
Data_026_6CE2:: ; address name
    dw MetaSprites26Set7AFrame0 ; entry 0
    dw MetaSprites26Set7AFrame1 ; entry 1
    dw MetaSprites26Set7AFrame2 ; entry 2
    dw MetaSprites26Set7AFrame3 ; entry 3
    dw MetaSprites26Set7AFrame4 ; entry 4
    dw MetaSprites26Set7AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame0::
Data_026_6CEE:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame1::
Data_026_6CFF:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame2::
Data_026_6D10:: ; address name
    db $F8, $F8, $08, $10 ; entry 0
    db $F8, $00, $09, $10 ; entry 1
    db $F0, $F8, $00, $10 ; entry 2
    db $F0, $00, $01, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame3::
Data_026_6D21:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame4::
Data_026_6D32:: ; address name
    db $F8, $F8, $0D, $10 ; entry 0
    db $F8, $00, $0E, $10 ; entry 1
    db $F0, $00, $00, $30 ; entry 2
    db $F0, $F8, $0C, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame5::
Data_026_6D43:: ; address name
    db $F8, $00, $0D, $30 ; entry 0
    db $F8, $F8, $0E, $30 ; entry 1
    db $F0, $00, $04, $30 ; entry 2
    db $F0, $F8, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 123 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7B::
Data_026_6D54:: ; address name
    dw MetaSprites26Set7BFrame0 ; entry 0
    dw MetaSprites26Set7BFrame1 ; entry 1
    dw MetaSprites26Set7BFrame2 ; entry 2
    dw MetaSprites26Set7BFrame3 ; entry 3
    dw MetaSprites26Set7BFrame4 ; entry 4
    dw MetaSprites26Set7BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame0::
Data_026_6D60:: ; address name
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $00, $30 ; entry 1
    db $F7, $F8, $01, $10 ; entry 2
    db $F7, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame1::
Data_026_6D71:: ; address name
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $02, $30 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame2::
Data_026_6D82:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame3::
Data_026_6D93:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame4::
Data_026_6DA4:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0C, $30 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame5::
Data_026_6DB5:: ; address name
    db $F1, $F8, $0E, $10 ; entry 0
    db $F1, $00, $0E, $30 ; entry 1
    db $F9, $F8, $0F, $10 ; entry 2
    db $F9, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 124 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7C::
Data_026_6DC6:: ; address name
    dw MetaSprites26Set7CFrame0 ; entry 0
    dw MetaSprites26Set7CFrame1 ; entry 1
    dw MetaSprites26Set7CFrame2 ; entry 2
    dw MetaSprites26Set7CFrame3 ; entry 3
    dw MetaSprites26Set7CFrame4 ; entry 4
    dw MetaSprites26Set7CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame0::
Data_026_6DD2:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame1::
Data_026_6DE3:: ; address name
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $01, $10 ; entry 1
    db $F7, $F8, $04, $10 ; entry 2
    db $F7, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame2::
Data_026_6DF4:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame3::
Data_026_6E05:: ; address name
    db $EF, $F8, $06, $10 ; entry 0
    db $EF, $00, $07, $10 ; entry 1
    db $F7, $F8, $0A, $10 ; entry 2
    db $F7, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame4::
Data_026_6E16:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame5::
Data_026_6E27:: ; address name
    db $EF, $F8, $0C, $10 ; entry 0
    db $EF, $00, $0D, $10 ; entry 1
    db $F7, $00, $04, $30 ; entry 2
    db $F7, $F8, $05, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 125 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7D::
Data_026_6E38:: ; address name
    dw MetaSprites26Set7DFrame0 ; entry 0
    dw MetaSprites26Set7DFrame1 ; entry 1
    dw MetaSprites26Set7DFrame2 ; entry 2
    dw MetaSprites26Set7DFrame3 ; entry 3
    dw MetaSprites26Set7DFrame4 ; entry 4
    dw MetaSprites26Set7DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame0::
Data_026_6E44:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame1::
Data_026_6E55:: ; address name
    db $EE, $F8, $02, $00 ; entry 0
    db $EE, $00, $02, $20 ; entry 1
    db $F6, $F8, $03, $00 ; entry 2
    db $F6, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame2::
Data_026_6E66:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame3::
Data_026_6E77:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame4::
Data_026_6E88:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame5::
Data_026_6E99:: ; address name
    db $EE, $F8, $0E, $00 ; entry 0
    db $EE, $00, $0E, $20 ; entry 1
    db $F6, $F8, $0F, $00 ; entry 2
    db $F6, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 126 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7E::
Data_026_6EAA:: ; address name
    dw MetaSprites26Set7EFrame0 ; entry 0
    dw MetaSprites26Set7EFrame1 ; entry 1
    dw MetaSprites26Set7EFrame2 ; entry 2
    dw MetaSprites26Set7EFrame3 ; entry 3
    dw MetaSprites26Set7EFrame4 ; entry 4
    dw MetaSprites26Set7EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame0::
Data_026_6EB6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame1::
Data_026_6EC7:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame2::
Data_026_6ED8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame3::
Data_026_6EE9:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame4::
Data_026_6EFA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame5::
Data_026_6F0B:: ; address name
    db $F1, $01, $0C, $20 ; entry 0
    db $F1, $F9, $0D, $20 ; entry 1
    db $F9, $01, $0E, $20 ; entry 2
    db $F9, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 127 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7F::
Data_026_6F1C:: ; address name
    dw MetaSprites26Set7FFrame0 ; entry 0
    dw MetaSprites26Set7FFrame1 ; entry 1
    dw MetaSprites26Set7FFrame2 ; entry 2
    dw MetaSprites26Set7FFrame3 ; entry 3
    dw MetaSprites26Set7FFrame4 ; entry 4
    dw MetaSprites26Set7FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame0::
Data_026_6F28:: ; address name
    db $F9, $F8, $02, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame1::
Data_026_6F39:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame2::
Data_026_6F4A:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame3::
Data_026_6F5B:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame4::
Data_026_6F6C:: ; address name
    db $F9, $F8, $06, $00 ; entry 0
    db $F9, $00, $07, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame5::
Data_026_6F7D:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $FF, $06, $20 ; entry 2
    db $F9, $F7, $07, $20 ; entry 3
    db $80 ; end
    ds $1072, $00
