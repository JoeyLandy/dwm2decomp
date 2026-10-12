SECTION "Bank 25", ROMX[$4000], BANK[$25]
    db $25

; ORs the attribute bits from Data_025_411E[hSpriteSetIndex] (when its bit 0 is set) into hSpriteAttrXor, then builds the sprite from Data_025_401E (E-0124)
; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, UpdateAndDrawSpriteSlots, AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80, DrawPartyFollowerSprites, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
DrawMetaSpriteSet_Bank25::
Func_025_4001:: ; address name
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, MetaSprites25Attrs
    add hl, de
    bit 0, [hl]
    jr z, .call_draw_meta_sprite_set_bank25_wait_oam
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or a, e
    ldh [hSpriteAttrXor], a

.call_draw_meta_sprite_set_bank25_wait_oam:
    ld de, MetaSprites25Table
    call DrawMetaSpriteSet_Bank25_WaitOamNextEntry
    ret

; E-0147 (C1: DrawMetaSpriteSet_Bank25 passes DE = $25:401E to the builder, which takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 128 words up to the attribute table at $411E).
; record: meta-sprite set
MetaSprites25Table::
Data_025_401E:: ; address name
    dw MetaSprites25Set00 ; id 0
    dw MetaSprites25Set00 ; id 1
    dw MetaSprites25Set02 ; id 2
    dw MetaSprites25Set03 ; id 3
    dw MetaSprites25Set04 ; id 4
    dw MetaSprites25Set05 ; id 5
    dw MetaSprites25Set06 ; id 6
    dw MetaSprites25Set07 ; id 7
    dw MetaSprites25Set08 ; id 8
    dw MetaSprites25Set09 ; id 9
    dw MetaSprites25Set0A ; id 10
    dw MetaSprites25Set0B ; id 11
    dw MetaSprites25Set0C ; id 12
    dw MetaSprites25Set0D ; id 13
    dw MetaSprites25Set0E ; id 14
    dw MetaSprites25Set0F ; id 15
    dw MetaSprites25Set10 ; id 16
    dw MetaSprites25Set11 ; id 17
    dw MetaSprites25Set12 ; id 18
    dw MetaSprites25Set13 ; id 19
    dw MetaSprites25Set14 ; id 20
    dw MetaSprites25Set15 ; id 21
    dw MetaSprites25Set16 ; id 22
    dw MetaSprites25Set17 ; id 23
    dw MetaSprites25Set18 ; id 24
    dw MetaSprites25Set19 ; id 25
    dw MetaSprites25Set1A ; id 26
    dw MetaSprites25Set1B ; id 27
    dw MetaSprites25Set1B ; id 28
    dw MetaSprites25Set1B ; id 29
    dw MetaSprites25Set1B ; id 30
    dw MetaSprites25Set1B ; id 31
    dw MetaSprites25Set1B ; id 32
    dw MetaSprites25Set1B ; id 33
    dw MetaSprites25Set1B ; id 34
    dw MetaSprites25Set1B ; id 35
    dw MetaSprites25Set1B ; id 36
    dw MetaSprites25Set25 ; id 37
    dw MetaSprites25Set26 ; id 38
    dw MetaSprites25Set27 ; id 39
    dw MetaSprites25Set28 ; id 40
    dw MetaSprites25Set29 ; id 41
    dw MetaSprites25Set2A ; id 42
    dw MetaSprites25Set2B ; id 43
    dw MetaSprites25Set2C ; id 44
    dw MetaSprites25Set2D ; id 45
    dw MetaSprites25Set2E ; id 46
    dw MetaSprites25Set2F ; id 47
    dw MetaSprites25Set30 ; id 48
    dw MetaSprites25Set31 ; id 49
    dw MetaSprites25Set32 ; id 50
    dw MetaSprites25Set33 ; id 51
    dw MetaSprites25Set34 ; id 52
    dw MetaSprites25Set35 ; id 53
    dw MetaSprites25Set36 ; id 54
    dw MetaSprites25Set37 ; id 55
    dw MetaSprites25Set38 ; id 56
    dw MetaSprites25Set39 ; id 57
    dw MetaSprites25Set3A ; id 58
    dw MetaSprites25Set3B ; id 59
    dw MetaSprites25Set3C ; id 60
    dw MetaSprites25Set3D ; id 61
    dw MetaSprites25Set3E ; id 62
    dw MetaSprites25Set3F ; id 63
    dw MetaSprites25Set40 ; id 64
    dw MetaSprites25Set41 ; id 65
    dw MetaSprites25Set42 ; id 66
    dw MetaSprites25Set43 ; id 67
    dw MetaSprites25Set43 ; id 68
    dw MetaSprites25Set43 ; id 69
    dw MetaSprites25Set43 ; id 70
    dw MetaSprites25Set43 ; id 71
    dw MetaSprites25Set48 ; id 72
    dw MetaSprites25Set49 ; id 73
    dw MetaSprites25Set4A ; id 74
    dw MetaSprites25Set4B ; id 75
    dw MetaSprites25Set4C ; id 76
    dw MetaSprites25Set4D ; id 77
    dw MetaSprites25Set4E ; id 78
    dw MetaSprites25Set4F ; id 79
    dw MetaSprites25Set50 ; id 80
    dw MetaSprites25Set51 ; id 81
    dw MetaSprites25Set52 ; id 82
    dw MetaSprites25Set53 ; id 83
    dw MetaSprites25Set54 ; id 84
    dw MetaSprites25Set55 ; id 85
    dw MetaSprites25Set56 ; id 86
    dw MetaSprites25Set57 ; id 87
    dw MetaSprites25Set58 ; id 88
    dw MetaSprites25Set59 ; id 89
    dw MetaSprites25Set5A ; id 90
    dw MetaSprites25Set5B ; id 91
    dw MetaSprites25Set5C ; id 92
    dw MetaSprites25Set5D ; id 93
    dw MetaSprites25Set5E ; id 94
    dw MetaSprites25Set5F ; id 95
    dw MetaSprites25Set60 ; id 96
    dw MetaSprites25Set61 ; id 97
    dw MetaSprites25Set62 ; id 98
    dw MetaSprites25Set63 ; id 99
    dw MetaSprites25Set64 ; id 100
    dw MetaSprites25Set65 ; id 101
    dw MetaSprites25Set66 ; id 102
    dw MetaSprites25Set67 ; id 103
    dw MetaSprites25Set67 ; id 104
    dw MetaSprites25Set67 ; id 105
    dw MetaSprites25Set67 ; id 106
    dw MetaSprites25Set6B ; id 107
    dw MetaSprites25Set6C ; id 108
    dw MetaSprites25Set6D ; id 109
    dw MetaSprites25Set6E ; id 110
    dw MetaSprites25Set6F ; id 111
    dw MetaSprites25Set70 ; id 112
    dw MetaSprites25Set71 ; id 113
    dw MetaSprites25Set72 ; id 114
    dw MetaSprites25Set73 ; id 115
    dw MetaSprites25Set74 ; id 116
    dw MetaSprites25Set75 ; id 117
    dw MetaSprites25Set76 ; id 118
    dw MetaSprites25Set77 ; id 119
    dw MetaSprites25Set78 ; id 120
    dw MetaSprites25Set79 ; id 121
    dw MetaSprites25Set7A ; id 122
    dw MetaSprites25Set7B ; id 123
    dw MetaSprites25Set7C ; id 124
    dw MetaSprites25Set7D ; id 125
    dw MetaSprites25Set7E ; id 126
    dw MetaSprites25Set7F ; id 127

; E-0147 (C1: DrawMetaSpriteSet_Bank25 reads the byte $411E + hSpriteSetIndex; when bit 0 is set it ORs its high nibble into hSpriteAttrXor before drawing).
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites25Attrs::
Data_025_411E:: ; address name
    db $00 ; id 0
    db $00 ; id 1
    db $00 ; id 2
    db $00 ; id 3
    db $00 ; id 4
    db $00 ; id 5
    db $00 ; id 6
    db $00 ; id 7
    db $00 ; id 8
    db $01 ; id 9
    db $00 ; id 10
    db $00 ; id 11
    db $00 ; id 12
    db $10 ; id 13
    db $00 ; id 14
    db $00 ; id 15
    db $00 ; id 16
    db $10 ; id 17
    db $10 ; id 18
    db $00 ; id 19
    db $01 ; id 20
    db $11 ; id 21
    db $01 ; id 22
    db $10 ; id 23
    db $00 ; id 24
    db $01 ; id 25
    db $01 ; id 26
    db $00 ; id 27
    db $00 ; id 28
    db $00 ; id 29
    db $00 ; id 30
    db $00 ; id 31
    db $00 ; id 32
    db $00 ; id 33
    db $00 ; id 34
    db $00 ; id 35
    db $00 ; id 36
    db $00 ; id 37
    db $00 ; id 38
    db $00 ; id 39
    db $10 ; id 40
    db $00 ; id 41
    db $00 ; id 42
    db $00 ; id 43
    db $01 ; id 44
    db $00 ; id 45
    db $10 ; id 46
    db $00 ; id 47
    db $00 ; id 48
    db $00 ; id 49
    db $00 ; id 50
    db $10 ; id 51
    db $00 ; id 52
    db $11 ; id 53
    db $01 ; id 54
    db $00 ; id 55
    db $00 ; id 56
    db $00 ; id 57
    db $11 ; id 58
    db $10 ; id 59
    db $00 ; id 60
    db $00 ; id 61
    db $00 ; id 62
    db $11 ; id 63
    db $11 ; id 64
    db $01 ; id 65
    db $11 ; id 66
    db $00 ; id 67
    db $00 ; id 68
    db $00 ; id 69
    db $00 ; id 70
    db $10 ; id 71
    db $00 ; id 72
    db $00 ; id 73
    db $00 ; id 74
    db $00 ; id 75
    db $00 ; id 76
    db $10 ; id 77
    db $10 ; id 78
    db $01 ; id 79
    db $10 ; id 80
    db $00 ; id 81
    db $10 ; id 82
    db $00 ; id 83
    db $00 ; id 84
    db $00 ; id 85
    db $10 ; id 86
    db $01 ; id 87
    db $11 ; id 88
    db $10 ; id 89
    db $10 ; id 90
    db $00 ; id 91
    db $00 ; id 92
    db $10 ; id 93
    db $10 ; id 94
    db $00 ; id 95
    db $00 ; id 96
    db $00 ; id 97
    db $00 ; id 98
    db $10 ; id 99
    db $11 ; id 100
    db $01 ; id 101
    db $01 ; id 102
    db $00 ; id 103
    db $00 ; id 104
    db $00 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $11 ; id 108
    db $10 ; id 109
    db $10 ; id 110
    db $00 ; id 111
    db $00 ; id 112
    db $00 ; id 113
    db $01 ; id 114
    db $00 ; id 115
    db $11 ; id 116
    db $00 ; id 117
    db $10 ; id 118
    db $00 ; id 119
    db $10 ; id 120
    db $00 ; id 121
    db $11 ; id 122
    db $00 ; id 123
    db $11 ; id 124
    db $00 ; id 125
    db $01 ; id 126
    db $00 ; id 127

; only called from DrawMetaSpriteSet_Bank25 (E-0047)
; 1 call site from 1 routine (e.g. DrawMetaSpriteSet_Bank25)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteSet_Bank25_WaitOamNextEntry::
Func_025_419E:: ; address name
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
    call BGTileUnderPointIsSpriteHideTile_Bank25
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
    call BGTileUnderPointIsSpriteHideTile_Bank25
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
; 2 call sites from 1 routine (e.g. DrawMetaSpriteSet_Bank25_WaitOamNextEntry)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsSpriteHideTile_Bank25::
Func_025_43E4:: ; address name
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

; E-0147 (derived: meta-sprite set 0 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set00::
Data_025_441A:: ; address name
    dw MetaSprites25Set00Frame0 ; entry 0
    dw MetaSprites25Set00Frame1 ; entry 1
    dw MetaSprites25Set00Frame2 ; entry 2
    dw MetaSprites25Set00Frame3 ; entry 3
    dw MetaSprites25Set00Frame4 ; entry 4
    dw MetaSprites25Set00Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame0::
Data_025_4426:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame1::
Data_025_4437:: ; address name
    db $F9, $00, $01, $20 ; entry 0
    db $F9, $F8, $02, $20 ; entry 1
    db $F1, $F8, $03, $00 ; entry 2
    db $F1, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame2::
Data_025_4448:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame3::
Data_025_4459:: ; address name
    db $F1, $00, $05, $00 ; entry 0
    db $F9, $00, $07, $00 ; entry 1
    db $F1, $F8, $08, $00 ; entry 2
    db $F9, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame4::
Data_025_446A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame5::
Data_025_447B:: ; address name
    db $F9, $00, $0B, $20 ; entry 0
    db $F9, $F8, $0C, $20 ; entry 1
    db $F1, $F8, $0D, $00 ; entry 2
    db $F1, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set02::
Data_025_448C:: ; address name
    dw MetaSprites25Set02Frame0 ; entry 0
    dw MetaSprites25Set02Frame1 ; entry 1
    dw MetaSprites25Set02Frame2 ; entry 2
    dw MetaSprites25Set02Frame3 ; entry 3
    dw MetaSprites25Set02Frame4 ; entry 4
    dw MetaSprites25Set02Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame0::
Data_025_4498:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame1::
Data_025_44A9:: ; address name
    db $F0, $F6, $03, $00 ; entry 0
    db $F0, $FE, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame2::
Data_025_44BA:: ; address name
    db $F8, $F8, $07, $00 ; entry 0
    db $F8, $00, $08, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame3::
Data_025_44CB:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $FA, $09, $00 ; entry 2
    db $F0, $02, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame4::
Data_025_44DC:: ; address name
    db $F8, $F8, $0C, $00 ; entry 0
    db $F8, $00, $0D, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame5::
Data_025_44ED:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0F, $00 ; entry 1
    db $F0, $F6, $03, $00 ; entry 2
    db $F0, $FE, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set03::
Data_025_44FE:: ; address name
    dw MetaSprites25Set03Frame0 ; entry 0
    dw MetaSprites25Set03Frame1 ; entry 1
    dw MetaSprites25Set03Frame2 ; entry 2
    dw MetaSprites25Set03Frame3 ; entry 3
    dw MetaSprites25Set03Frame4 ; entry 4
    dw MetaSprites25Set03Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame0::
Data_025_450A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F8, $00, $03, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame1::
Data_025_451B:: ; address name
    db $F1, $F8, $01, $00 ; entry 0
    db $F1, $FF, $01, $20 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame2::
Data_025_452C:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $0A, $20 ; entry 2
    db $F8, $F8, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame3::
Data_025_453D:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame4::
Data_025_454E:: ; address name
    db $F0, $F9, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame5::
Data_025_455F:: ; address name
    db $F1, $F9, $0F, $00 ; entry 0
    db $F1, $00, $0F, $20 ; entry 1
    db $F9, $01, $04, $20 ; entry 2
    db $F9, $F9, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set04::
Data_025_4570:: ; address name
    dw MetaSprites25Set04Frame0 ; entry 0
    dw MetaSprites25Set04Frame1 ; entry 1
    dw MetaSprites25Set04Frame2 ; entry 2
    dw MetaSprites25Set04Frame3 ; entry 3
    dw MetaSprites25Set04Frame4 ; entry 4
    dw MetaSprites25Set04Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame0::
Data_025_457C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame1::
Data_025_458D:: ; address name
    db $F9, $F8, $02, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame2::
Data_025_459E:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame3::
Data_025_45AF:: ; address name
    db $F9, $00, $08, $00 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $F8, $09, $00 ; entry 2
    db $F1, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame4::
Data_025_45C0:: ; address name
    db $F8, $00, $0B, $00 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F0, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame5::
Data_025_45D1:: ; address name
    db $F9, $00, $0B, $00 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $00, $04, $20 ; entry 2
    db $F1, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set05::
Data_025_45E2:: ; address name
    dw MetaSprites25Set05Frame0 ; entry 0
    dw MetaSprites25Set05Frame1 ; entry 1
    dw MetaSprites25Set05Frame2 ; entry 2
    dw MetaSprites25Set05Frame3 ; entry 3
    dw MetaSprites25Set05Frame4 ; entry 4
    dw MetaSprites25Set05Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame0::
Data_025_45EE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame1::
Data_025_45FF:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame2::
Data_025_4610:: ; address name
    db $F0, $00, $06, $00 ; entry 0
    db $F8, $F8, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F0, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame3::
Data_025_4621:: ; address name
    db $F1, $00, $06, $00 ; entry 0
    db $F9, $F8, $07, $00 ; entry 1
    db $F1, $F8, $01, $20 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame4::
Data_025_4632:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame5::
Data_025_4643:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 6 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set06::
Data_025_4654:: ; address name
    dw MetaSprites25Set06Frame0 ; entry 0
    dw MetaSprites25Set06Frame1 ; entry 1
    dw MetaSprites25Set06Frame2 ; entry 2
    dw MetaSprites25Set06Frame3 ; entry 3
    dw MetaSprites25Set06Frame4 ; entry 4
    dw MetaSprites25Set06Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame0::
Data_025_4660:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame1::
Data_025_4671:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $04, $00 ; entry 1
    db $F9, $F8, $05, $00 ; entry 2
    db $F9, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame2::
Data_025_4682:: ; address name
    db $F0, $F8, $01, $20 ; entry 0
    db $F8, $00, $02, $20 ; entry 1
    db $F0, $00, $07, $00 ; entry 2
    db $F8, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame3::
Data_025_4693:: ; address name
    db $F1, $F8, $04, $20 ; entry 0
    db $F9, $00, $05, $20 ; entry 1
    db $F1, $00, $09, $00 ; entry 2
    db $F9, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame4::
Data_025_46A4:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F8, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame5::
Data_025_46B5:: ; address name
    db $F1, $00, $0C, $00 ; entry 0
    db $F9, $00, $0F, $00 ; entry 1
    db $F1, $F8, $0E, $00 ; entry 2
    db $F9, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 7 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set07::
Data_025_46C6:: ; address name
    dw MetaSprites25Set07Frame0 ; entry 0
    dw MetaSprites25Set07Frame1 ; entry 1
    dw MetaSprites25Set07Frame2 ; entry 2
    dw MetaSprites25Set07Frame3 ; entry 3
    dw MetaSprites25Set07Frame4 ; entry 4
    dw MetaSprites25Set07Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame0::
Data_025_46D2:: ; address name
    db $F9, $F8, $00, $00 ; entry 0
    db $F9, $00, $00, $20 ; entry 1
    db $F1, $F8, $02, $00 ; entry 2
    db $F1, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame1::
Data_025_46E3:: ; address name
    db $F8, $F8, $01, $00 ; entry 0
    db $F8, $00, $01, $20 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame2::
Data_025_46F4:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $00, $06, $20 ; entry 2
    db $F1, $F8, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame3::
Data_025_4705:: ; address name
    db $F0, $00, $08, $20 ; entry 0
    db $F0, $F8, $09, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame4::
Data_025_4716:: ; address name
    db $F9, $F8, $0E, $00 ; entry 0
    db $F9, $00, $0E, $20 ; entry 1
    db $F1, $00, $02, $20 ; entry 2
    db $F1, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame5::
Data_025_4727:: ; address name
    db $F8, $F8, $0F, $00 ; entry 0
    db $F8, $00, $0F, $20 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 8 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set08::
Data_025_4738:: ; address name
    dw MetaSprites25Set08Frame0 ; entry 0
    dw MetaSprites25Set08Frame1 ; entry 1
    dw MetaSprites25Set08Frame2 ; entry 2
    dw MetaSprites25Set08Frame3 ; entry 3
    dw MetaSprites25Set08Frame4 ; entry 4
    dw MetaSprites25Set08Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame0::
Data_025_4744:: ; address name
    db $F3, $F8, $00, $00 ; entry 0
    db $F3, $00, $00, $20 ; entry 1
    db $FB, $F8, $01, $00 ; entry 2
    db $FB, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame1::
Data_025_4755:: ; address name
    db $F4, $F8, $02, $00 ; entry 0
    db $F4, $00, $02, $20 ; entry 1
    db $FC, $F8, $03, $00 ; entry 2
    db $FC, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame2::
Data_025_4766:: ; address name
    db $F3, $F8, $04, $00 ; entry 0
    db $F3, $00, $05, $00 ; entry 1
    db $FB, $F8, $06, $00 ; entry 2
    db $FB, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame3::
Data_025_4777:: ; address name
    db $FC, $F8, $0A, $00 ; entry 0
    db $FC, $00, $0B, $00 ; entry 1
    db $F4, $F8, $08, $00 ; entry 2
    db $F4, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame4::
Data_025_4788:: ; address name
    db $FB, $F8, $0D, $00 ; entry 0
    db $F3, $F8, $0C, $00 ; entry 1
    db $F3, $00, $0C, $20 ; entry 2
    db $FB, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame5::
Data_025_4799:: ; address name
    db $F4, $F8, $0E, $00 ; entry 0
    db $F4, $00, $0E, $20 ; entry 1
    db $FC, $F8, $0F, $00 ; entry 2
    db $FC, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 9 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set09::
Data_025_47AA:: ; address name
    dw MetaSprites25Set09Frame0 ; entry 0
    dw MetaSprites25Set09Frame1 ; entry 1
    dw MetaSprites25Set09Frame2 ; entry 2
    dw MetaSprites25Set09Frame3 ; entry 3
    dw MetaSprites25Set09Frame4 ; entry 4
    dw MetaSprites25Set09Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame0::
Data_025_47B6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame1::
Data_025_47C7:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $FF, $02, $20 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame2::
Data_025_47D8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame3::
Data_025_47E9:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame4::
Data_025_47FA:: ; address name
    db $F0, $00, $0C, $00 ; entry 0
    db $F8, $00, $0D, $00 ; entry 1
    db $F0, $F9, $0C, $20 ; entry 2
    db $F8, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame5::
Data_025_480B:: ; address name
    db $EF, $00, $0E, $00 ; entry 0
    db $F7, $00, $0F, $00 ; entry 1
    db $EF, $F9, $0E, $20 ; entry 2
    db $F7, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 10 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set0A::
Data_025_481C:: ; address name
    dw MetaSprites25Set0AFrame0 ; entry 0
    dw MetaSprites25Set0AFrame1 ; entry 1
    dw MetaSprites25Set0AFrame2 ; entry 2
    dw MetaSprites25Set0AFrame3 ; entry 3
    dw MetaSprites25Set0AFrame4 ; entry 4
    dw MetaSprites25Set0AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame0::
Data_025_4828:: ; address name
    db $F1, $FD, $00, $00 ; entry 0
    db $F9, $F8, $01, $00 ; entry 1
    db $F9, $FF, $01, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame1::
Data_025_4835:: ; address name
    db $EF, $FD, $00, $00 ; entry 0
    db $F7, $F8, $02, $00 ; entry 1
    db $F7, $FF, $02, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame2::
Data_025_4842:: ; address name
    db $F1, $FD, $00, $00 ; entry 0
    db $F9, $F8, $03, $00 ; entry 1
    db $F9, $00, $05, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame3::
Data_025_484F:: ; address name
    db $EF, $FD, $00, $00 ; entry 0
    db $F7, $F8, $04, $00 ; entry 1
    db $F7, $00, $06, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame4::
Data_025_485C:: ; address name
    db $F1, $FD, $00, $00 ; entry 0
    db $F9, $F8, $03, $00 ; entry 1
    db $F9, $FF, $03, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame5::
Data_025_4869:: ; address name
    db $EF, $FD, $00, $00 ; entry 0
    db $F7, $F8, $04, $00 ; entry 1
    db $F7, $FF, $04, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 11 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set0B::
Data_025_4876:: ; address name
    dw MetaSprites25Set0BFrame0 ; entry 0
    dw MetaSprites25Set0BFrame1 ; entry 1
    dw MetaSprites25Set0BFrame2 ; entry 2
    dw MetaSprites25Set0BFrame3 ; entry 3
    dw MetaSprites25Set0BFrame4 ; entry 4
    dw MetaSprites25Set0BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame0::
Data_025_4882:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame1::
Data_025_4893:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $FF, $00, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame2::
Data_025_48A4:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $FF, $07, $00 ; entry 2
    db $F8, $F7, $0A, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame3::
Data_025_48B5:: ; address name
    db $EF, $F8, $05, $00 ; entry 0
    db $EF, $00, $06, $00 ; entry 1
    db $F7, $FF, $08, $00 ; entry 2
    db $F7, $F7, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame4::
Data_025_48C6:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $FF, $05, $20 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame5::
Data_025_48D7:: ; address name
    db $EF, $F8, $05, $00 ; entry 0
    db $EF, $FF, $05, $20 ; entry 1
    db $F7, $F8, $0B, $00 ; entry 2
    db $F7, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 12 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set0C::
Data_025_48E8:: ; address name
    dw MetaSprites25Set0CFrame0 ; entry 0
    dw MetaSprites25Set0CFrame1 ; entry 1
    dw MetaSprites25Set0CFrame2 ; entry 2
    dw MetaSprites25Set0CFrame3 ; entry 3
    dw MetaSprites25Set0CFrame4 ; entry 4
    dw MetaSprites25Set0CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame0::
Data_025_48F4:: ; address name
    db $EE, $F8, $00, $00 ; entry 0
    db $EE, $00, $01, $00 ; entry 1
    db $F6, $F8, $02, $00 ; entry 2
    db $F6, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame1::
Data_025_4905:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame2::
Data_025_4916:: ; address name
    db $EE, $F8, $04, $00 ; entry 0
    db $EE, $00, $05, $00 ; entry 1
    db $F6, $F8, $06, $00 ; entry 2
    db $F6, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame3::
Data_025_4927:: ; address name
    db $F0, $FB, $04, $00 ; entry 0
    db $F8, $F7, $09, $00 ; entry 1
    db $F8, $FF, $0A, $00 ; entry 2
    db $F0, $03, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame4::
Data_025_4938:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame5::
Data_025_4949:: ; address name
    db $EE, $F8, $0B, $00 ; entry 0
    db $EE, $00, $0C, $00 ; entry 1
    db $F6, $F8, $0E, $00 ; entry 2
    db $F6, $FF, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 13 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set0D::
Data_025_495A:: ; address name
    dw MetaSprites25Set0DFrame0 ; entry 0
    dw MetaSprites25Set0DFrame1 ; entry 1
    dw MetaSprites25Set0DFrame2 ; entry 2
    dw MetaSprites25Set0DFrame3 ; entry 3
    dw MetaSprites25Set0DFrame4 ; entry 4
    dw MetaSprites25Set0DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame0::
Data_025_4966:: ; address name
    db $EF, $FB, $00, $10 ; entry 0
    db $F7, $F8, $01, $10 ; entry 1
    db $F7, $00, $02, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame1::
Data_025_4973:: ; address name
    db $F0, $FC, $03, $10 ; entry 0
    db $F8, $F8, $04, $10 ; entry 1
    db $F8, $00, $05, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame2::
Data_025_4980:: ; address name
    db $F0, $FB, $00, $10 ; entry 0
    db $F8, $F8, $06, $10 ; entry 1
    db $F8, $00, $07, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame3::
Data_025_498D:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame4::
Data_025_499E:: ; address name
    db $F0, $FB, $00, $10 ; entry 0
    db $F8, $F8, $0C, $10 ; entry 1
    db $F8, $00, $0D, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame5::
Data_025_49AB:: ; address name
    db $F9, $F8, $0E, $10 ; entry 0
    db $F9, $00, $0F, $10 ; entry 1
    db $F1, $FC, $03, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 14 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set0E::
Data_025_49B8:: ; address name
    dw MetaSprites25Set0EFrame0 ; entry 0
    dw MetaSprites25Set0EFrame1 ; entry 1
    dw MetaSprites25Set0EFrame2 ; entry 2
    dw MetaSprites25Set0EFrame3 ; entry 3
    dw MetaSprites25Set0EFrame4 ; entry 4
    dw MetaSprites25Set0EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame0::
Data_025_49C4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame1::
Data_025_49D5:: ; address name
    db $EE, $F8, $04, $00 ; entry 0
    db $EE, $00, $05, $00 ; entry 1
    db $F6, $F8, $06, $00 ; entry 2
    db $F6, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame2::
Data_025_49E6:: ; address name
    db $F9, $F8, $08, $00 ; entry 0
    db $F9, $00, $09, $00 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame3::
Data_025_49F7:: ; address name
    db $F7, $F8, $0A, $00 ; entry 0
    db $F7, $00, $0B, $00 ; entry 1
    db $EF, $00, $04, $20 ; entry 2
    db $EF, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame4::
Data_025_4A08:: ; address name
    db $F9, $F8, $0C, $00 ; entry 0
    db $F9, $00, $0D, $00 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame5::
Data_025_4A19:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0F, $00 ; entry 1
    db $F0, $00, $04, $20 ; entry 2
    db $F0, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set0F::
Data_025_4A2A:: ; address name
    dw MetaSprites25Set0FFrame0 ; entry 0
    dw MetaSprites25Set0FFrame1 ; entry 1
    dw MetaSprites25Set0FFrame2 ; entry 2
    dw MetaSprites25Set0FFrame3 ; entry 3
    dw MetaSprites25Set0FFrame4 ; entry 4
    dw MetaSprites25Set0FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame0::
Data_025_4A36:: ; address name
    db $EF, $00, $00, $20 ; entry 0
    db $F7, $00, $01, $20 ; entry 1
    db $EF, $F8, $00, $00 ; entry 2
    db $F7, $F8, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame1::
Data_025_4A47:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame2::
Data_025_4A58:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame3::
Data_025_4A69:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame4::
Data_025_4A7A:: ; address name
    db $F3, $F8, $0C, $00 ; entry 0
    db $F3, $00, $0C, $20 ; entry 1
    db $FB, $F8, $0D, $00 ; entry 2
    db $FB, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame5::
Data_025_4A8B:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set10::
Data_025_4A9C:: ; address name
    dw MetaSprites25Set10Frame0 ; entry 0
    dw MetaSprites25Set10Frame1 ; entry 1
    dw MetaSprites25Set10Frame2 ; entry 2
    dw MetaSprites25Set10Frame3 ; entry 3
    dw MetaSprites25Set10Frame4 ; entry 4
    dw MetaSprites25Set10Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame0::
Data_025_4AA8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame1::
Data_025_4AB9:: ; address name
    db $F1, $F8, $01, $00 ; entry 0
    db $F1, $00, $01, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame2::
Data_025_4ACA:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame3::
Data_025_4ADB:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $08, $00 ; entry 2
    db $F1, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame4::
Data_025_4AEC:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0E, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame5::
Data_025_4AFD:: ; address name
    db $F1, $F8, $0D, $00 ; entry 0
    db $F9, $F8, $0F, $00 ; entry 1
    db $F1, $00, $0D, $20 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set11::
Data_025_4B0E:: ; address name
    dw MetaSprites25Set11Frame0 ; entry 0
    dw MetaSprites25Set11Frame1 ; entry 1
    dw MetaSprites25Set11Frame2 ; entry 2
    dw MetaSprites25Set11Frame3 ; entry 3
    dw MetaSprites25Set11Frame4 ; entry 4
    dw MetaSprites25Set11Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame0::
Data_025_4B1A:: ; address name
    db $F1, $FD, $00, $10 ; entry 0
    db $F9, $F8, $01, $10 ; entry 1
    db $F9, $FF, $01, $30 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame1::
Data_025_4B27:: ; address name
    db $EF, $FD, $00, $10 ; entry 0
    db $F7, $F8, $02, $10 ; entry 1
    db $F7, $FF, $02, $30 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame2::
Data_025_4B34:: ; address name
    db $F1, $FD, $00, $10 ; entry 0
    db $F9, $F8, $03, $10 ; entry 1
    db $F9, $00, $05, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame3::
Data_025_4B41:: ; address name
    db $EF, $FD, $00, $10 ; entry 0
    db $F7, $F8, $04, $10 ; entry 1
    db $F7, $00, $06, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame4::
Data_025_4B4E:: ; address name
    db $F1, $FD, $00, $10 ; entry 0
    db $F9, $F8, $03, $10 ; entry 1
    db $F9, $FF, $03, $30 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame5::
Data_025_4B5B:: ; address name
    db $EF, $FD, $00, $10 ; entry 0
    db $F7, $F8, $04, $10 ; entry 1
    db $F7, $FF, $04, $30 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 18 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set12::
Data_025_4B68:: ; address name
    dw MetaSprites25Set12Frame0 ; entry 0
    dw MetaSprites25Set12Frame1 ; entry 1
    dw MetaSprites25Set12Frame2 ; entry 2
    dw MetaSprites25Set12Frame3 ; entry 3
    dw MetaSprites25Set12Frame4 ; entry 4
    dw MetaSprites25Set12Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame0::
Data_025_4B74:: ; address name
    db $F9, $F8, $00, $10 ; entry 0
    db $F9, $00, $00, $30 ; entry 1
    db $F1, $F8, $02, $10 ; entry 2
    db $F1, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame1::
Data_025_4B85:: ; address name
    db $F8, $F8, $01, $10 ; entry 0
    db $F8, $00, $01, $30 ; entry 1
    db $F0, $F8, $04, $10 ; entry 2
    db $F0, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame2::
Data_025_4B96:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $00, $06, $30 ; entry 2
    db $F1, $F8, $07, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame3::
Data_025_4BA7:: ; address name
    db $F0, $00, $08, $30 ; entry 0
    db $F0, $F8, $09, $30 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame4::
Data_025_4BB8:: ; address name
    db $F9, $F8, $0E, $10 ; entry 0
    db $F9, $00, $0E, $30 ; entry 1
    db $F1, $00, $02, $30 ; entry 2
    db $F1, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame5::
Data_025_4BC9:: ; address name
    db $F8, $F8, $0F, $10 ; entry 0
    db $F8, $00, $0F, $30 ; entry 1
    db $F0, $F8, $08, $10 ; entry 2
    db $F0, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 19 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set13::
Data_025_4BDA:: ; address name
    dw MetaSprites25Set13Frame0 ; entry 0
    dw MetaSprites25Set13Frame1 ; entry 1
    dw MetaSprites25Set13Frame2 ; entry 2
    dw MetaSprites25Set13Frame3 ; entry 3
    dw MetaSprites25Set13Frame4 ; entry 4
    dw MetaSprites25Set13Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame0::
Data_025_4BE6:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $00, $20 ; entry 1
    db $F7, $F8, $01, $00 ; entry 2
    db $F7, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame1::
Data_025_4BF7:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $03, $20 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame2::
Data_025_4C08:: ; address name
    db $EF, $F8, $06, $00 ; entry 0
    db $EF, $00, $07, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame3::
Data_025_4C19:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $06, $00 ; entry 2
    db $F1, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame4::
Data_025_4C2A:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $00, $20 ; entry 1
    db $F7, $F8, $0C, $00 ; entry 2
    db $F7, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame5::
Data_025_4C3B:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $03, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 20 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set14::
Data_025_4C4C:: ; address name
    dw MetaSprites25Set14Frame0 ; entry 0
    dw MetaSprites25Set14Frame1 ; entry 1
    dw MetaSprites25Set14Frame2 ; entry 2
    dw MetaSprites25Set14Frame3 ; entry 3
    dw MetaSprites25Set14Frame4 ; entry 4
    dw MetaSprites25Set14Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame0::
Data_025_4C58:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame1::
Data_025_4C69:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F8, $FF, $03, $20 ; entry 2
    db $F0, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame2::
Data_025_4C7A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame3::
Data_025_4C8B:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame4::
Data_025_4C9C:: ; address name
    db $F0, $F9, $0C, $00 ; entry 0
    db $F8, $F9, $0D, $00 ; entry 1
    db $F8, $00, $0D, $20 ; entry 2
    db $F0, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame5::
Data_025_4CAD:: ; address name
    db $F0, $F9, $0E, $00 ; entry 0
    db $F8, $F9, $0F, $00 ; entry 1
    db $F8, $00, $0F, $20 ; entry 2
    db $F0, $00, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 21 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set15::
Data_025_4CBE:: ; address name
    dw MetaSprites25Set15Frame0 ; entry 0
    dw MetaSprites25Set15Frame1 ; entry 1
    dw MetaSprites25Set15Frame2 ; entry 2
    dw MetaSprites25Set15Frame3 ; entry 3
    dw MetaSprites25Set15Frame4 ; entry 4
    dw MetaSprites25Set15Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame0::
Data_025_4CCA:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame1::
Data_025_4CDB:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame2::
Data_025_4CEC:: ; address name
    db $EF, $00, $07, $00 ; entry 0
    db $F7, $F8, $08, $00 ; entry 1
    db $F7, $00, $09, $00 ; entry 2
    db $EF, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame3::
Data_025_4CFD:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame4::
Data_025_4D0E:: ; address name
    db $EF, $F8, $0B, $00 ; entry 0
    db $EF, $00, $0C, $00 ; entry 1
    db $F7, $00, $0D, $00 ; entry 2
    db $F7, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame5::
Data_025_4D1F:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0F, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F8, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 22 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set16::
Data_025_4D30:: ; address name
    dw MetaSprites25Set16Frame0 ; entry 0
    dw MetaSprites25Set16Frame1 ; entry 1
    dw MetaSprites25Set16Frame2 ; entry 2
    dw MetaSprites25Set16Frame3 ; entry 3
    dw MetaSprites25Set16Frame4 ; entry 4
    dw MetaSprites25Set16Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame0::
Data_025_4D3C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame1::
Data_025_4D4D:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $FF, $02, $20 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame2::
Data_025_4D5E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame3::
Data_025_4D6F:: ; address name
    db $EF, $00, $05, $00 ; entry 0
    db $F7, $00, $07, $00 ; entry 1
    db $EF, $F8, $08, $00 ; entry 2
    db $F7, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame4::
Data_025_4D80:: ; address name
    db $F0, $F9, $0A, $00 ; entry 0
    db $F8, $F9, $0B, $00 ; entry 1
    db $F0, $00, $0A, $20 ; entry 2
    db $F8, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame5::
Data_025_4D91:: ; address name
    db $EF, $F9, $0C, $00 ; entry 0
    db $F7, $F9, $0D, $00 ; entry 1
    db $EF, $00, $0C, $20 ; entry 2
    db $F7, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 23 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set17::
Data_025_4DA2:: ; address name
    dw MetaSprites25Set17Frame0 ; entry 0
    dw MetaSprites25Set17Frame1 ; entry 1
    dw MetaSprites25Set17Frame2 ; entry 2
    dw MetaSprites25Set17Frame3 ; entry 3
    dw MetaSprites25Set17Frame4 ; entry 4
    dw MetaSprites25Set17Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame0::
Data_025_4DAE:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame1::
Data_025_4DBF:: ; address name
    db $F1, $F8, $01, $10 ; entry 0
    db $F1, $00, $01, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame2::
Data_025_4DD0:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame3::
Data_025_4DE1:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F8, $08, $10 ; entry 2
    db $F1, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame4::
Data_025_4DF2:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F8, $F8, $0E, $10 ; entry 1
    db $F0, $00, $0C, $30 ; entry 2
    db $F8, $00, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame5::
Data_025_4E03:: ; address name
    db $F1, $F8, $0D, $10 ; entry 0
    db $F9, $F8, $0F, $10 ; entry 1
    db $F1, $00, $0D, $30 ; entry 2
    db $F9, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 24 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set18::
Data_025_4E14:: ; address name
    dw MetaSprites25Set18Frame0 ; entry 0
    dw MetaSprites25Set18Frame1 ; entry 1
    dw MetaSprites25Set18Frame2 ; entry 2
    dw MetaSprites25Set18Frame3 ; entry 3
    dw MetaSprites25Set18Frame4 ; entry 4
    dw MetaSprites25Set18Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame0::
Data_025_4E20:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame1::
Data_025_4E31:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame2::
Data_025_4E42:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $03, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame3::
Data_025_4E53:: ; address name
    db $F9, $F8, $04, $00 ; entry 0
    db $F9, $00, $05, $00 ; entry 1
    db $F1, $F8, $06, $00 ; entry 2
    db $F1, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame4::
Data_025_4E64:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $08, $20 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame5::
Data_025_4E75:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $08, $20 ; entry 1
    db $F9, $F8, $09, $00 ; entry 2
    db $F9, $00, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 25 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set19::
Data_025_4E86:: ; address name
    dw MetaSprites25Set19Frame0 ; entry 0
    dw MetaSprites25Set19Frame1 ; entry 1
    dw MetaSprites25Set19Frame2 ; entry 2
    dw MetaSprites25Set19Frame3 ; entry 3
    dw MetaSprites25Set19Frame4 ; entry 4
    dw MetaSprites25Set19Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame0::
Data_025_4E92:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame1::
Data_025_4EA3:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $F7, $F8, $01, $00 ; entry 1
    db $EF, $FF, $00, $20 ; entry 2
    db $F7, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame2::
Data_025_4EB4:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $03, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame3::
Data_025_4EC5:: ; address name
    db $F7, $F8, $04, $00 ; entry 0
    db $F7, $00, $05, $00 ; entry 1
    db $EF, $F8, $02, $00 ; entry 2
    db $EF, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame4::
Data_025_4ED6:: ; address name
    db $F0, $00, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F9, $06, $20 ; entry 2
    db $F8, $F9, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame5::
Data_025_4EE7:: ; address name
    db $EF, $00, $06, $00 ; entry 0
    db $F7, $00, $07, $00 ; entry 1
    db $EF, $F9, $06, $20 ; entry 2
    db $F7, $F9, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set1A::
Data_025_4EF8:: ; address name
    dw MetaSprites25Set1AFrame0 ; entry 0
    dw MetaSprites25Set1AFrame1 ; entry 1
    dw MetaSprites25Set1AFrame2 ; entry 2
    dw MetaSprites25Set1AFrame3 ; entry 3
    dw MetaSprites25Set1AFrame4 ; entry 4
    dw MetaSprites25Set1AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame0::
Data_025_4F04:: ; address name
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $01, $00 ; entry 1
    db $FA, $F8, $02, $00 ; entry 2
    db $FA, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame1::
Data_025_4F15:: ; address name
    db $F2, $F8, $04, $00 ; entry 0
    db $F2, $00, $05, $00 ; entry 1
    db $FA, $F8, $06, $00 ; entry 2
    db $FA, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame2::
Data_025_4F26:: ; address name
    db $F2, $F8, $08, $00 ; entry 0
    db $F2, $00, $09, $00 ; entry 1
    db $FA, $F8, $0A, $00 ; entry 2
    db $FA, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame3::
Data_025_4F37:: ; address name
    db $FA, $FF, $06, $20 ; entry 0
    db $FA, $F7, $07, $20 ; entry 1
    db $F2, $FF, $04, $20 ; entry 2
    db $F2, $F7, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame4::
Data_025_4F48:: ; address name
    db $F2, $F8, $0C, $00 ; entry 0
    db $F2, $00, $0D, $00 ; entry 1
    db $FA, $F8, $0E, $00 ; entry 2
    db $FA, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame5::
Data_025_4F59:: ; address name
    db $F2, $F8, $04, $00 ; entry 0
    db $F2, $00, $05, $00 ; entry 1
    db $FA, $F8, $06, $00 ; entry 2
    db $FA, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set1B::
Data_025_4F6A:: ; address name
    dw MetaSprites25Set1BFrame0 ; entry 0
    dw MetaSprites25Set1BFrame1 ; entry 1
    dw MetaSprites25Set1BFrame2 ; entry 2
    dw MetaSprites25Set1BFrame3 ; entry 3
    dw MetaSprites25Set1BFrame4 ; entry 4
    dw MetaSprites25Set1BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame0::
Data_025_4F76:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame1::
Data_025_4F87:: ; address name
    db $F2, $F8, $03, $00 ; entry 0
    db $F2, $00, $04, $00 ; entry 1
    db $FA, $F8, $02, $00 ; entry 2
    db $FA, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame2::
Data_025_4F98:: ; address name
    db $F3, $F8, $09, $00 ; entry 0
    db $F3, $00, $0A, $00 ; entry 1
    db $FB, $F8, $0B, $00 ; entry 2
    db $FB, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame3::
Data_025_4FA9:: ; address name
    db $F4, $00, $0A, $00 ; entry 0
    db $F4, $F8, $0D, $00 ; entry 1
    db $FC, $F8, $0B, $00 ; entry 2
    db $FC, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame4::
Data_025_4FBA:: ; address name
    db $F2, $F8, $05, $00 ; entry 0
    db $F2, $FF, $05, $20 ; entry 1
    db $FA, $F8, $06, $00 ; entry 2
    db $FA, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame5::
Data_025_4FCB:: ; address name
    db $F3, $F8, $08, $00 ; entry 0
    db $F3, $FF, $08, $20 ; entry 1
    db $FB, $FF, $06, $20 ; entry 2
    db $FB, $F7, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set25::
Data_025_4FDC:: ; address name
    dw MetaSprites25Set25Frame0 ; entry 0
    dw MetaSprites25Set25Frame1 ; entry 1
    dw MetaSprites25Set25Frame2 ; entry 2
    dw MetaSprites25Set25Frame3 ; entry 3
    dw MetaSprites25Set25Frame4 ; entry 4
    dw MetaSprites25Set25Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame0::
Data_025_4FE8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame1::
Data_025_4FF9:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame2::
Data_025_500A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame3::
Data_025_501B:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame4::
Data_025_502C:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame5::
Data_025_503D:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set26::
Data_025_504E:: ; address name
    dw MetaSprites25Set26Frame0 ; entry 0
    dw MetaSprites25Set26Frame1 ; entry 1
    dw MetaSprites25Set26Frame2 ; entry 2
    dw MetaSprites25Set26Frame3 ; entry 3
    dw MetaSprites25Set26Frame4 ; entry 4
    dw MetaSprites25Set26Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame0::
Data_025_505A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame1::
Data_025_506B:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $00, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame2::
Data_025_507C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame3::
Data_025_508D:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame4::
Data_025_509E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame5::
Data_025_50AF:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $00, $0E, $20 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set27::
Data_025_50C0:: ; address name
    dw MetaSprites25Set27Frame0 ; entry 0
    dw MetaSprites25Set27Frame1 ; entry 1
    dw MetaSprites25Set27Frame2 ; entry 2
    dw MetaSprites25Set27Frame3 ; entry 3
    dw MetaSprites25Set27Frame4 ; entry 4
    dw MetaSprites25Set27Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame0::
Data_025_50CC:: ; address name
    db $F0, $F9, $00, $00 ; entry 0
    db $F8, $F9, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame1::
Data_025_50DD:: ; address name
    db $F0, $F9, $02, $00 ; entry 0
    db $F8, $F9, $03, $00 ; entry 1
    db $F0, $00, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame2::
Data_025_50EE:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame3::
Data_025_50FF:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame4::
Data_025_5110:: ; address name
    db $F0, $F9, $0C, $00 ; entry 0
    db $F8, $F9, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame5::
Data_025_5121:: ; address name
    db $F0, $F9, $0E, $00 ; entry 0
    db $F8, $F9, $0F, $00 ; entry 1
    db $F0, $00, $0E, $20 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set28::
Data_025_5132:: ; address name
    dw MetaSprites25Set28Frame0 ; entry 0
    dw MetaSprites25Set28Frame1 ; entry 1
    dw MetaSprites25Set28Frame2 ; entry 2
    dw MetaSprites25Set28Frame3 ; entry 3
    dw MetaSprites25Set28Frame4 ; entry 4
    dw MetaSprites25Set28Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame0::
Data_025_513E:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame1::
Data_025_514F:: ; address name
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $02, $30 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame2::
Data_025_5160:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $06, $10 ; entry 2
    db $F9, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame3::
Data_025_5171:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame4::
Data_025_5182:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0C, $30 ; entry 1
    db $F9, $F8, $0D, $10 ; entry 2
    db $F9, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame5::
Data_025_5193:: ; address name
    db $F0, $F8, $0E, $10 ; entry 0
    db $F0, $00, $0E, $30 ; entry 1
    db $F8, $F8, $0F, $10 ; entry 2
    db $F8, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 41 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set29::
Data_025_51A4:: ; address name
    dw MetaSprites25Set29Frame0 ; entry 0
    dw MetaSprites25Set29Frame1 ; entry 1
    dw MetaSprites25Set29Frame2 ; entry 2
    dw MetaSprites25Set29Frame3 ; entry 3
    dw MetaSprites25Set29Frame4 ; entry 4
    dw MetaSprites25Set29Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame0::
Data_025_51B0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame1::
Data_025_51C1:: ; address name
    db $F0, $00, $01, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F8, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame2::
Data_025_51D2:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame3::
Data_025_51E3:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame4::
Data_025_51F4:: ; address name
    db $F0, $FF, $0B, $20 ; entry 0
    db $F8, $F7, $0C, $00 ; entry 1
    db $F8, $FF, $0D, $00 ; entry 2
    db $F0, $F8, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame5::
Data_025_5205:: ; address name
    db $F0, $FF, $0B, $20 ; entry 0
    db $F0, $F8, $0B, $00 ; entry 1
    db $F8, $F7, $0E, $00 ; entry 2
    db $F8, $FF, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 42 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set2A::
Data_025_5216:: ; address name
    dw MetaSprites25Set2AFrame0 ; entry 0
    dw MetaSprites25Set2AFrame1 ; entry 1
    dw MetaSprites25Set2AFrame2 ; entry 2
    dw MetaSprites25Set2AFrame3 ; entry 3
    dw MetaSprites25Set2AFrame4 ; entry 4
    dw MetaSprites25Set2AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame0::
Data_025_5222:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame1::
Data_025_5233:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame2::
Data_025_5244:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame3::
Data_025_5255:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame4::
Data_025_5266:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame5::
Data_025_5277:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 43 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set2B::
Data_025_5288:: ; address name
    dw MetaSprites25Set2BFrame0 ; entry 0
    dw MetaSprites25Set2BFrame1 ; entry 1
    dw MetaSprites25Set2BFrame2 ; entry 2
    dw MetaSprites25Set2BFrame3 ; entry 3
    dw MetaSprites25Set2BFrame4 ; entry 4
    dw MetaSprites25Set2BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame0::
Data_025_5294:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame1::
Data_025_52A5:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame2::
Data_025_52B6:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame3::
Data_025_52C7:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame4::
Data_025_52D8:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame5::
Data_025_52E9:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 44 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set2C::
Data_025_52FA:: ; address name
    dw MetaSprites25Set2CFrame0 ; entry 0
    dw MetaSprites25Set2CFrame1 ; entry 1
    dw MetaSprites25Set2CFrame2 ; entry 2
    dw MetaSprites25Set2CFrame3 ; entry 3
    dw MetaSprites25Set2CFrame4 ; entry 4
    dw MetaSprites25Set2CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame0::
Data_025_5306:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame1::
Data_025_5317:: ; address name
    db $EF, $FF, $00, $20 ; entry 0
    db $EF, $F7, $01, $20 ; entry 1
    db $F7, $FF, $02, $20 ; entry 2
    db $F7, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame2::
Data_025_5328:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame3::
Data_025_5339:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame4::
Data_025_534A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame5::
Data_025_535B:: ; address name
    db $EF, $01, $0C, $20 ; entry 0
    db $EF, $F9, $0D, $20 ; entry 1
    db $F7, $01, $0E, $20 ; entry 2
    db $F7, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 45 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set2D::
Data_025_536C:: ; address name
    dw MetaSprites25Set2DFrame0 ; entry 0
    dw MetaSprites25Set2DFrame1 ; entry 1
    dw MetaSprites25Set2DFrame2 ; entry 2
    dw MetaSprites25Set2DFrame3 ; entry 3
    dw MetaSprites25Set2DFrame4 ; entry 4
    dw MetaSprites25Set2DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame0::
Data_025_5378:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame1::
Data_025_5389:: ; address name
    db $F8, $00, $02, $20 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F0, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame2::
Data_025_539A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame3::
Data_025_53AB:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame4::
Data_025_53BC:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame5::
Data_025_53CD:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 46 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set2E::
Data_025_53DE:: ; address name
    dw MetaSprites25Set2EFrame0 ; entry 0
    dw MetaSprites25Set2EFrame1 ; entry 1
    dw MetaSprites25Set2EFrame2 ; entry 2
    dw MetaSprites25Set2EFrame3 ; entry 3
    dw MetaSprites25Set2EFrame4 ; entry 4
    dw MetaSprites25Set2EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame0::
Data_025_53EA:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame1::
Data_025_53FB:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame2::
Data_025_540C:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame3::
Data_025_541D:: ; address name
    db $F1, $00, $05, $10 ; entry 0
    db $F1, $F8, $08, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame4::
Data_025_542E:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame5::
Data_025_543F:: ; address name
    db $F1, $00, $0B, $30 ; entry 0
    db $F1, $F8, $0C, $30 ; entry 1
    db $F9, $00, $0D, $30 ; entry 2
    db $F9, $F8, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 47 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set2F::
Data_025_5450:: ; address name
    dw MetaSprites25Set2FFrame0 ; entry 0
    dw MetaSprites25Set2FFrame1 ; entry 1
    dw MetaSprites25Set2FFrame2 ; entry 2
    dw MetaSprites25Set2FFrame3 ; entry 3
    dw MetaSprites25Set2FFrame4 ; entry 4
    dw MetaSprites25Set2FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame0::
Data_025_545C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame1::
Data_025_546D:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame2::
Data_025_547E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame3::
Data_025_548F:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $08, $00 ; entry 2
    db $F1, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame4::
Data_025_54A0:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame5::
Data_025_54B1:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 48 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set30::
Data_025_54C2:: ; address name
    dw MetaSprites25Set30Frame0 ; entry 0
    dw MetaSprites25Set30Frame1 ; entry 1
    dw MetaSprites25Set30Frame2 ; entry 2
    dw MetaSprites25Set30Frame3 ; entry 3
    dw MetaSprites25Set30Frame4 ; entry 4
    dw MetaSprites25Set30Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame0::
Data_025_54CE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F8, $00, $03, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame1::
Data_025_54DF:: ; address name
    db $F8, $00, $02, $20 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $01, $20 ; entry 2
    db $F0, $F9, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame2::
Data_025_54F0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame3::
Data_025_5501:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame4::
Data_025_5512:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0F, $00 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $FF, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame5::
Data_025_5523:: ; address name
    db $F8, $00, $0E, $20 ; entry 0
    db $F8, $F8, $0F, $20 ; entry 1
    db $F0, $00, $0D, $20 ; entry 2
    db $F0, $F9, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 49 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set31::
Data_025_5534:: ; address name
    dw MetaSprites25Set31Frame0 ; entry 0
    dw MetaSprites25Set31Frame1 ; entry 1
    dw MetaSprites25Set31Frame2 ; entry 2
    dw MetaSprites25Set31Frame3 ; entry 3
    dw MetaSprites25Set31Frame4 ; entry 4
    dw MetaSprites25Set31Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame0::
Data_025_5540:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame1::
Data_025_5551:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame2::
Data_025_5562:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame3::
Data_025_5573:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame4::
Data_025_5584:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame5::
Data_025_5595:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 50 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set32::
Data_025_55A6:: ; address name
    dw MetaSprites25Set32Frame0 ; entry 0
    dw MetaSprites25Set32Frame1 ; entry 1
    dw MetaSprites25Set32Frame2 ; entry 2
    dw MetaSprites25Set32Frame3 ; entry 3
    dw MetaSprites25Set32Frame4 ; entry 4
    dw MetaSprites25Set32Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame0::
Data_025_55B2:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame1::
Data_025_55C3:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame2::
Data_025_55D4:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame3::
Data_025_55E5:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame4::
Data_025_55F6:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame5::
Data_025_5607:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 51 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set33::
Data_025_5618:: ; address name
    dw MetaSprites25Set33Frame0 ; entry 0
    dw MetaSprites25Set33Frame1 ; entry 1
    dw MetaSprites25Set33Frame2 ; entry 2
    dw MetaSprites25Set33Frame3 ; entry 3
    dw MetaSprites25Set33Frame4 ; entry 4
    dw MetaSprites25Set33Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame0::
Data_025_5624:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame1::
Data_025_5635:: ; address name
    db $F9, $00, $01, $30 ; entry 0
    db $F9, $F8, $02, $30 ; entry 1
    db $F1, $F8, $03, $10 ; entry 2
    db $F1, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame2::
Data_025_5646:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame3::
Data_025_5657:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame4::
Data_025_5668:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0C, $30 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame5::
Data_025_5679:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0C, $30 ; entry 1
    db $F9, $00, $0D, $30 ; entry 2
    db $F9, $F8, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 52 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set34::
Data_025_568A:: ; address name
    dw MetaSprites25Set34Frame0 ; entry 0
    dw MetaSprites25Set34Frame1 ; entry 1
    dw MetaSprites25Set34Frame2 ; entry 2
    dw MetaSprites25Set34Frame3 ; entry 3
    dw MetaSprites25Set34Frame4 ; entry 4
    dw MetaSprites25Set34Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame0::
Data_025_5696:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame1::
Data_025_56A7:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame2::
Data_025_56B8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame3::
Data_025_56C9:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame4::
Data_025_56DA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame5::
Data_025_56EB:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 53 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set35::
Data_025_56FC:: ; address name
    dw MetaSprites25Set35Frame0 ; entry 0
    dw MetaSprites25Set35Frame1 ; entry 1
    dw MetaSprites25Set35Frame2 ; entry 2
    dw MetaSprites25Set35Frame3 ; entry 3
    dw MetaSprites25Set35Frame4 ; entry 4
    dw MetaSprites25Set35Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame0::
Data_025_5708:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame1::
Data_025_5719:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $FF, $02, $20 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame2::
Data_025_572A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame3::
Data_025_573B:: ; address name
    db $EF, $00, $05, $00 ; entry 0
    db $F7, $00, $07, $00 ; entry 1
    db $EF, $F8, $08, $00 ; entry 2
    db $F7, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame4::
Data_025_574C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F8, $F8, $0B, $00 ; entry 1
    db $F0, $FF, $0A, $20 ; entry 2
    db $F8, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame5::
Data_025_575D:: ; address name
    db $EF, $F8, $0C, $00 ; entry 0
    db $F7, $F8, $0D, $00 ; entry 1
    db $EF, $FF, $0C, $20 ; entry 2
    db $F7, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 54 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set36::
Data_025_576E:: ; address name
    dw MetaSprites25Set36Frame0 ; entry 0
    dw MetaSprites25Set36Frame1 ; entry 1
    dw MetaSprites25Set36Frame2 ; entry 2
    dw MetaSprites25Set36Frame3 ; entry 3
    dw MetaSprites25Set36Frame4 ; entry 4
    dw MetaSprites25Set36Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame0::
Data_025_577A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame1::
Data_025_578B:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $03, $20 ; entry 1
    db $F7, $F8, $04, $00 ; entry 2
    db $F7, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame2::
Data_025_579C:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame3::
Data_025_57AD:: ; address name
    db $EF, $F8, $0A, $00 ; entry 0
    db $F7, $F8, $0B, $00 ; entry 1
    db $F7, $00, $0C, $00 ; entry 2
    db $EF, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame4::
Data_025_57BE:: ; address name
    db $F0, $F8, $0D, $00 ; entry 0
    db $F0, $00, $0D, $20 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame5::
Data_025_57CF:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $00, $04, $20 ; entry 2
    db $F7, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 55 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set37::
Data_025_57E0:: ; address name
    dw MetaSprites25Set37Frame0 ; entry 0
    dw MetaSprites25Set37Frame1 ; entry 1
    dw MetaSprites25Set37Frame2 ; entry 2
    dw MetaSprites25Set37Frame3 ; entry 3
    dw MetaSprites25Set37Frame4 ; entry 4
    dw MetaSprites25Set37Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame0::
Data_025_57EC:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame1::
Data_025_57FD:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F0, $F7, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame2::
Data_025_580E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame3::
Data_025_581F:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame4::
Data_025_5830:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame5::
Data_025_5841:: ; address name
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 56 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set38::
Data_025_5852:: ; address name
    dw MetaSprites25Set38Frame0 ; entry 0
    dw MetaSprites25Set38Frame1 ; entry 1
    dw MetaSprites25Set38Frame2 ; entry 2
    dw MetaSprites25Set38Frame3 ; entry 3
    dw MetaSprites25Set38Frame4 ; entry 4
    dw MetaSprites25Set38Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame0::
Data_025_585E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame1::
Data_025_586F:: ; address name
    db $F9, $00, $01, $20 ; entry 0
    db $F9, $F8, $02, $20 ; entry 1
    db $F1, $F8, $03, $00 ; entry 2
    db $F1, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame2::
Data_025_5880:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame3::
Data_025_5891:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame4::
Data_025_58A2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame5::
Data_025_58B3:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $00, $0D, $20 ; entry 2
    db $F9, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 57 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set39::
Data_025_58C4:: ; address name
    dw MetaSprites25Set39Frame0 ; entry 0
    dw MetaSprites25Set39Frame1 ; entry 1
    dw MetaSprites25Set39Frame2 ; entry 2
    dw MetaSprites25Set39Frame3 ; entry 3
    dw MetaSprites25Set39Frame4 ; entry 4
    dw MetaSprites25Set39Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame0::
Data_025_58D0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame1::
Data_025_58E1:: ; address name
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $00, $02, $20 ; entry 2
    db $F7, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame2::
Data_025_58F2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame3::
Data_025_5903:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame4::
Data_025_5914:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame5::
Data_025_5925:: ; address name
    db $EF, $00, $0C, $20 ; entry 0
    db $EF, $F8, $0D, $20 ; entry 1
    db $F7, $00, $0E, $20 ; entry 2
    db $F7, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 58 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set3A::
Data_025_5936:: ; address name
    dw MetaSprites25Set3AFrame0 ; entry 0
    dw MetaSprites25Set3AFrame1 ; entry 1
    dw MetaSprites25Set3AFrame2 ; entry 2
    dw MetaSprites25Set3AFrame3 ; entry 3
    dw MetaSprites25Set3AFrame4 ; entry 4
    dw MetaSprites25Set3AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame0::
Data_025_5942:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame1::
Data_025_5953:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame2::
Data_025_5964:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame3::
Data_025_5975:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame4::
Data_025_5986:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame5::
Data_025_5997:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 59 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set3B::
Data_025_59A8:: ; address name
    dw MetaSprites25Set3BFrame0 ; entry 0
    dw MetaSprites25Set3BFrame1 ; entry 1
    dw MetaSprites25Set3BFrame2 ; entry 2
    dw MetaSprites25Set3BFrame3 ; entry 3
    dw MetaSprites25Set3BFrame4 ; entry 4
    dw MetaSprites25Set3BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame0::
Data_025_59B4:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame1::
Data_025_59C5:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $03, $30 ; entry 1
    db $F8, $F8, $04, $10 ; entry 2
    db $F8, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame2::
Data_025_59D6:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame3::
Data_025_59E7:: ; address name
    db $F0, $F9, $06, $10 ; entry 0
    db $F0, $01, $07, $10 ; entry 1
    db $F8, $F9, $0A, $10 ; entry 2
    db $F8, $01, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame4::
Data_025_59F8:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0D, $10 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame5::
Data_025_5A09:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $00, $0E, $30 ; entry 2
    db $F8, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 60 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set3C::
Data_025_5A1A:: ; address name
    dw MetaSprites25Set3CFrame0 ; entry 0
    dw MetaSprites25Set3CFrame1 ; entry 1
    dw MetaSprites25Set3CFrame2 ; entry 2
    dw MetaSprites25Set3CFrame3 ; entry 3
    dw MetaSprites25Set3CFrame4 ; entry 4
    dw MetaSprites25Set3CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame0::
Data_025_5A26:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame1::
Data_025_5A37:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame2::
Data_025_5A48:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame3::
Data_025_5A59:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame4::
Data_025_5A6A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame5::
Data_025_5A7B:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 61 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set3D::
Data_025_5A8C:: ; address name
    dw MetaSprites25Set3DFrame0 ; entry 0
    dw MetaSprites25Set3DFrame1 ; entry 1
    dw MetaSprites25Set3DFrame2 ; entry 2
    dw MetaSprites25Set3DFrame3 ; entry 3
    dw MetaSprites25Set3DFrame4 ; entry 4
    dw MetaSprites25Set3DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame0::
Data_025_5A98:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame1::
Data_025_5AA9:: ; address name
    db $F0, $F9, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F9, $03, $00 ; entry 2
    db $F8, $01, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame2::
Data_025_5ABA:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame3::
Data_025_5ACB:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame4::
Data_025_5ADC:: ; address name
    db $F8, $F8, $0C, $00 ; entry 0
    db $F8, $00, $0D, $00 ; entry 1
    db $F0, $F9, $0B, $00 ; entry 2
    db $F0, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame5::
Data_025_5AED:: ; address name
    db $F0, $FA, $0B, $00 ; entry 0
    db $F0, $01, $0B, $20 ; entry 1
    db $F8, $F9, $0E, $00 ; entry 2
    db $F8, $01, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 62 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set3E::
Data_025_5AFE:: ; address name
    dw MetaSprites25Set3EFrame0 ; entry 0
    dw MetaSprites25Set3EFrame1 ; entry 1
    dw MetaSprites25Set3EFrame2 ; entry 2
    dw MetaSprites25Set3EFrame3 ; entry 3
    dw MetaSprites25Set3EFrame4 ; entry 4
    dw MetaSprites25Set3EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame0::
Data_025_5B0A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame1::
Data_025_5B1B:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame2::
Data_025_5B2C:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame3::
Data_025_5B3D:: ; address name
    db $F7, $00, $08, $00 ; entry 0
    db $EF, $F8, $09, $00 ; entry 1
    db $EF, $00, $07, $00 ; entry 2
    db $F7, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame4::
Data_025_5B4E:: ; address name
    db $F8, $F8, $0C, $00 ; entry 0
    db $F8, $00, $0D, $00 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame5::
Data_025_5B5F:: ; address name
    db $EF, $00, $0B, $00 ; entry 0
    db $F7, $00, $0D, $00 ; entry 1
    db $EF, $F8, $0E, $00 ; entry 2
    db $F7, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 63 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set3F::
Data_025_5B70:: ; address name
    dw MetaSprites25Set3FFrame0 ; entry 0
    dw MetaSprites25Set3FFrame1 ; entry 1
    dw MetaSprites25Set3FFrame2 ; entry 2
    dw MetaSprites25Set3FFrame3 ; entry 3
    dw MetaSprites25Set3FFrame4 ; entry 4
    dw MetaSprites25Set3FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame0::
Data_025_5B7C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame1::
Data_025_5B8D:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $FF, $00, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame2::
Data_025_5B9E:: ; address name
    db $F0, $FB, $05, $00 ; entry 0
    db $F8, $F9, $06, $00 ; entry 1
    db $F8, $01, $07, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame3::
Data_025_5BAB:: ; address name
    db $EF, $FB, $05, $00 ; entry 0
    db $F7, $F9, $08, $00 ; entry 1
    db $F7, $01, $09, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame4::
Data_025_5BB8:: ; address name
    db $F0, $00, $0A, $00 ; entry 0
    db $F0, $F9, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame5::
Data_025_5BC9:: ; address name
    db $EF, $00, $0A, $00 ; entry 0
    db $EF, $F9, $0A, $20 ; entry 1
    db $F7, $F8, $0D, $00 ; entry 2
    db $F7, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 64 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set40::
Data_025_5BDA:: ; address name
    dw MetaSprites25Set40Frame0 ; entry 0
    dw MetaSprites25Set40Frame1 ; entry 1
    dw MetaSprites25Set40Frame2 ; entry 2
    dw MetaSprites25Set40Frame3 ; entry 3
    dw MetaSprites25Set40Frame4 ; entry 4
    dw MetaSprites25Set40Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame0::
Data_025_5BE6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame1::
Data_025_5BF7:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame2::
Data_025_5C08:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame3::
Data_025_5C19:: ; address name
    db $F7, $00, $08, $00 ; entry 0
    db $EF, $F8, $09, $00 ; entry 1
    db $EF, $00, $07, $00 ; entry 2
    db $F7, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame4::
Data_025_5C2A:: ; address name
    db $F8, $F8, $0C, $00 ; entry 0
    db $F8, $00, $0D, $00 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame5::
Data_025_5C3B:: ; address name
    db $EF, $00, $0B, $00 ; entry 0
    db $F7, $00, $0D, $00 ; entry 1
    db $EF, $F8, $0E, $00 ; entry 2
    db $F7, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 65 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set41::
Data_025_5C4C:: ; address name
    dw MetaSprites25Set41Frame0 ; entry 0
    dw MetaSprites25Set41Frame1 ; entry 1
    dw MetaSprites25Set41Frame2 ; entry 2
    dw MetaSprites25Set41Frame3 ; entry 3
    dw MetaSprites25Set41Frame4 ; entry 4
    dw MetaSprites25Set41Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame0::
Data_025_5C58:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame1::
Data_025_5C69:: ; address name
    db $EF, $FF, $00, $20 ; entry 0
    db $EF, $F7, $01, $20 ; entry 1
    db $F7, $FF, $02, $20 ; entry 2
    db $F7, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame2::
Data_025_5C7A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame3::
Data_025_5C8B:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame4::
Data_025_5C9C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame5::
Data_025_5CAD:: ; address name
    db $EF, $01, $0A, $20 ; entry 0
    db $EF, $F9, $0B, $20 ; entry 1
    db $F7, $01, $0C, $20 ; entry 2
    db $F7, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 66 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set42::
Data_025_5CBE:: ; address name
    dw MetaSprites25Set42Frame0 ; entry 0
    dw MetaSprites25Set42Frame1 ; entry 1
    dw MetaSprites25Set42Frame2 ; entry 2
    dw MetaSprites25Set42Frame3 ; entry 3
    dw MetaSprites25Set42Frame4 ; entry 4
    dw MetaSprites25Set42Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame0::
Data_025_5CCA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame1::
Data_025_5CDB:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame2::
Data_025_5CEC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame3::
Data_025_5CFD:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $08, $00 ; entry 2
    db $F1, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame4::
Data_025_5D0E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame5::
Data_025_5D1F:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 67 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set43::
Data_025_5D30:: ; address name
    dw MetaSprites25Set43Frame0 ; entry 0
    dw MetaSprites25Set43Frame1 ; entry 1
    dw MetaSprites25Set43Frame2 ; entry 2
    dw MetaSprites25Set43Frame3 ; entry 3
    dw MetaSprites25Set43Frame4 ; entry 4
    dw MetaSprites25Set43Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame0::
Data_025_5D3C:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame1::
Data_025_5D4D:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame2::
Data_025_5D5E:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame3::
Data_025_5D6F:: ; address name
    db $F1, $00, $05, $10 ; entry 0
    db $F1, $F8, $08, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame4::
Data_025_5D80:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame5::
Data_025_5D91:: ; address name
    db $F1, $00, $0B, $30 ; entry 0
    db $F1, $F8, $0C, $30 ; entry 1
    db $F9, $00, $0D, $30 ; entry 2
    db $F9, $F8, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 72 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set48::
Data_025_5DA2:: ; address name
    dw MetaSprites25Set48Frame0 ; entry 0
    dw MetaSprites25Set48Frame1 ; entry 1
    dw MetaSprites25Set48Frame2 ; entry 2
    dw MetaSprites25Set48Frame3 ; entry 3
    dw MetaSprites25Set48Frame4 ; entry 4
    dw MetaSprites25Set48Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame0::
Data_025_5DAE:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame1::
Data_025_5DBF:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $00, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame2::
Data_025_5DD0:: ; address name
    db $EF, $01, $04, $20 ; entry 0
    db $EF, $F9, $05, $20 ; entry 1
    db $F7, $01, $06, $20 ; entry 2
    db $F7, $F9, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame3::
Data_025_5DE1:: ; address name
    db $F0, $00, $08, $20 ; entry 0
    db $F0, $F8, $09, $20 ; entry 1
    db $F8, $00, $0A, $20 ; entry 2
    db $F8, $F8, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame4::
Data_025_5DF2:: ; address name
    db $F2, $F8, $0C, $00 ; entry 0
    db $F2, $00, $0C, $20 ; entry 1
    db $FA, $F8, $0D, $00 ; entry 2
    db $FA, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame5::
Data_025_5E03:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 73 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set49::
Data_025_5E14:: ; address name
    dw MetaSprites25Set49Frame0 ; entry 0
    dw MetaSprites25Set49Frame1 ; entry 1
    dw MetaSprites25Set49Frame2 ; entry 2
    dw MetaSprites25Set49Frame3 ; entry 3
    dw MetaSprites25Set49Frame4 ; entry 4
    dw MetaSprites25Set49Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame0::
Data_025_5E20:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame1::
Data_025_5E31:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $03, $20 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame2::
Data_025_5E42:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame3::
Data_025_5E53:: ; address name
    db $F0, $00, $0A, $00 ; entry 0
    db $F8, $F8, $0B, $00 ; entry 1
    db $F8, $00, $09, $00 ; entry 2
    db $F0, $F8, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame4::
Data_025_5E64:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame5::
Data_025_5E75:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 74 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set4A::
Data_025_5E86:: ; address name
    dw MetaSprites25Set4AFrame0 ; entry 0
    dw MetaSprites25Set4AFrame1 ; entry 1
    dw MetaSprites25Set4AFrame2 ; entry 2
    dw MetaSprites25Set4AFrame3 ; entry 3
    dw MetaSprites25Set4AFrame4 ; entry 4
    dw MetaSprites25Set4AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame0::
Data_025_5E92:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame1::
Data_025_5EA3:: ; address name
    db $EF, $FF, $00, $30 ; entry 0
    db $EF, $F7, $01, $30 ; entry 1
    db $F7, $FF, $02, $30 ; entry 2
    db $F7, $F7, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame2::
Data_025_5EB4:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame3::
Data_025_5EC5:: ; address name
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $08, $10 ; entry 2
    db $F7, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame4::
Data_025_5ED6:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame5::
Data_025_5EE7:: ; address name
    db $EF, $FF, $0A, $30 ; entry 0
    db $EF, $F7, $0B, $30 ; entry 1
    db $F7, $FF, $0C, $30 ; entry 2
    db $F7, $F7, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 75 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set4B::
Data_025_5EF8:: ; address name
    dw MetaSprites25Set4BFrame0 ; entry 0
    dw MetaSprites25Set4BFrame1 ; entry 1
    dw MetaSprites25Set4BFrame2 ; entry 2
    dw MetaSprites25Set4BFrame3 ; entry 3
    dw MetaSprites25Set4BFrame4 ; entry 4
    dw MetaSprites25Set4BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame0::
Data_025_5F04:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame1::
Data_025_5F15:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame2::
Data_025_5F26:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame3::
Data_025_5F37:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame4::
Data_025_5F48:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame5::
Data_025_5F59:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 76 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set4C::
Data_025_5F6A:: ; address name
    dw MetaSprites25Set4CFrame0 ; entry 0
    dw MetaSprites25Set4CFrame1 ; entry 1
    dw MetaSprites25Set4CFrame2 ; entry 2
    dw MetaSprites25Set4CFrame3 ; entry 3
    dw MetaSprites25Set4CFrame4 ; entry 4
    dw MetaSprites25Set4CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame0::
Data_025_5F76:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame1::
Data_025_5F87:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame2::
Data_025_5F98:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame3::
Data_025_5FA9:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame4::
Data_025_5FBA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame5::
Data_025_5FCB:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 77 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set4D::
Data_025_5FDC:: ; address name
    dw MetaSprites25Set4DFrame0 ; entry 0
    dw MetaSprites25Set4DFrame1 ; entry 1
    dw MetaSprites25Set4DFrame2 ; entry 2
    dw MetaSprites25Set4DFrame3 ; entry 3
    dw MetaSprites25Set4DFrame4 ; entry 4
    dw MetaSprites25Set4DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame0::
Data_025_5FE8:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame1::
Data_025_5FF9:: ; address name
    db $EF, $F8, $02, $10 ; entry 0
    db $EF, $00, $02, $30 ; entry 1
    db $F7, $F8, $03, $10 ; entry 2
    db $F7, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame2::
Data_025_600A:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame3::
Data_025_601B:: ; address name
    db $EE, $F7, $08, $10 ; entry 0
    db $EE, $FF, $09, $10 ; entry 1
    db $F6, $F7, $0A, $10 ; entry 2
    db $F6, $FF, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame4::
Data_025_602C:: ; address name
    db $F2, $F8, $0C, $10 ; entry 0
    db $F2, $00, $0C, $30 ; entry 1
    db $FA, $F8, $0D, $10 ; entry 2
    db $FA, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame5::
Data_025_603D:: ; address name
    db $EF, $F8, $0E, $10 ; entry 0
    db $EF, $00, $0E, $30 ; entry 1
    db $F7, $F8, $0F, $10 ; entry 2
    db $F7, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 78 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set4E::
Data_025_604E:: ; address name
    dw MetaSprites25Set4EFrame0 ; entry 0
    dw MetaSprites25Set4EFrame1 ; entry 1
    dw MetaSprites25Set4EFrame2 ; entry 2
    dw MetaSprites25Set4EFrame3 ; entry 3
    dw MetaSprites25Set4EFrame4 ; entry 4
    dw MetaSprites25Set4EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame0::
Data_025_605A:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame1::
Data_025_606B:: ; address name
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $F8, $00, $10 ; entry 2
    db $F1, $00, $01, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame2::
Data_025_607C:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame3::
Data_025_608D:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F8, $06, $10 ; entry 2
    db $F1, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame4::
Data_025_609E:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame5::
Data_025_60AF:: ; address name
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 79 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set4F::
Data_025_60C0:: ; address name
    dw MetaSprites25Set4FFrame0 ; entry 0
    dw MetaSprites25Set4FFrame1 ; entry 1
    dw MetaSprites25Set4FFrame2 ; entry 2
    dw MetaSprites25Set4FFrame3 ; entry 3
    dw MetaSprites25Set4FFrame4 ; entry 4
    dw MetaSprites25Set4FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame0::
Data_025_60CC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame1::
Data_025_60DD:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $F7, $03, $20 ; entry 2
    db $F9, $FF, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame2::
Data_025_60EE:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame3::
Data_025_60FF:: ; address name
    db $F1, $F9, $05, $00 ; entry 0
    db $F1, $01, $06, $00 ; entry 1
    db $F9, $F9, $09, $00 ; entry 2
    db $F9, $01, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame4::
Data_025_6110:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame5::
Data_025_6121:: ; address name
    db $F1, $FF, $0B, $20 ; entry 0
    db $F1, $F7, $0C, $20 ; entry 1
    db $F9, $F7, $0E, $20 ; entry 2
    db $F9, $FF, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 80 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set50::
Data_025_6132:: ; address name
    dw MetaSprites25Set50Frame0 ; entry 0
    dw MetaSprites25Set50Frame1 ; entry 1
    dw MetaSprites25Set50Frame2 ; entry 2
    dw MetaSprites25Set50Frame3 ; entry 3
    dw MetaSprites25Set50Frame4 ; entry 4
    dw MetaSprites25Set50Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame0::
Data_025_613E:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame1::
Data_025_614F:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame2::
Data_025_6160:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame3::
Data_025_6171:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $08, $10 ; entry 2
    db $F9, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame4::
Data_025_6182:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame5::
Data_025_6193:: ; address name
    db $F1, $F8, $0A, $10 ; entry 0
    db $F1, $00, $0B, $10 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 81 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set51::
Data_025_61A4:: ; address name
    dw MetaSprites25Set51Frame0 ; entry 0
    dw MetaSprites25Set51Frame1 ; entry 1
    dw MetaSprites25Set51Frame2 ; entry 2
    dw MetaSprites25Set51Frame3 ; entry 3
    dw MetaSprites25Set51Frame4 ; entry 4
    dw MetaSprites25Set51Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame0::
Data_025_61B0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame1::
Data_025_61C1:: ; address name
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame2::
Data_025_61D2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame3::
Data_025_61E3:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame4::
Data_025_61F4:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame5::
Data_025_6205:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 82 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set52::
Data_025_6216:: ; address name
    dw MetaSprites25Set52Frame0 ; entry 0
    dw MetaSprites25Set52Frame1 ; entry 1
    dw MetaSprites25Set52Frame2 ; entry 2
    dw MetaSprites25Set52Frame3 ; entry 3
    dw MetaSprites25Set52Frame4 ; entry 4
    dw MetaSprites25Set52Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame0::
Data_025_6222:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame1::
Data_025_6233:: ; address name
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $01, $30 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame2::
Data_025_6244:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame3::
Data_025_6255:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame4::
Data_025_6266:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F8, $F8, $0E, $10 ; entry 1
    db $F8, $00, $0F, $10 ; entry 2
    db $F0, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame5::
Data_025_6277:: ; address name
    db $F0, $00, $0C, $30 ; entry 0
    db $F8, $00, $0E, $30 ; entry 1
    db $F8, $F8, $0F, $30 ; entry 2
    db $F0, $F8, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 83 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set53::
Data_025_6288:: ; address name
    dw MetaSprites25Set53Frame0 ; entry 0
    dw MetaSprites25Set53Frame1 ; entry 1
    dw MetaSprites25Set53Frame2 ; entry 2
    dw MetaSprites25Set53Frame3 ; entry 3
    dw MetaSprites25Set53Frame4 ; entry 4
    dw MetaSprites25Set53Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame0::
Data_025_6294:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame1::
Data_025_62A5:: ; address name
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame2::
Data_025_62B6:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame3::
Data_025_62C7:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $06, $00 ; entry 2
    db $F1, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame4::
Data_025_62D8:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame5::
Data_025_62E9:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 84 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set54::
Data_025_62FA:: ; address name
    dw MetaSprites25Set54Frame0 ; entry 0
    dw MetaSprites25Set54Frame1 ; entry 1
    dw MetaSprites25Set54Frame2 ; entry 2
    dw MetaSprites25Set54Frame3 ; entry 3
    dw MetaSprites25Set54Frame4 ; entry 4
    dw MetaSprites25Set54Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame0::
Data_025_6306:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame1::
Data_025_6317:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame2::
Data_025_6328:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame3::
Data_025_6339:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame4::
Data_025_634A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $00, $0E, $00 ; entry 2
    db $F8, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame5::
Data_025_635B:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $00, $0F, $00 ; entry 2
    db $F9, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 85 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set55::
Data_025_636C:: ; address name
    dw MetaSprites25Set55Frame0 ; entry 0
    dw MetaSprites25Set55Frame1 ; entry 1
    dw MetaSprites25Set55Frame2 ; entry 2
    dw MetaSprites25Set55Frame3 ; entry 3
    dw MetaSprites25Set55Frame4 ; entry 4
    dw MetaSprites25Set55Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame0::
Data_025_6378:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame1::
Data_025_6389:: ; address name
    db $F0, $F9, $03, $00 ; entry 0
    db $F8, $F8, $02, $20 ; entry 1
    db $F8, $00, $04, $00 ; entry 2
    db $F0, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame2::
Data_025_639A:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame3::
Data_025_63AB:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $00, $0B, $00 ; entry 2
    db $F8, $F9, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame4::
Data_025_63BC:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame5::
Data_025_63CD:: ; address name
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $F9, $0F, $00 ; entry 2
    db $F0, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 86 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set56::
Data_025_63DE:: ; address name
    dw MetaSprites25Set56Frame0 ; entry 0
    dw MetaSprites25Set56Frame1 ; entry 1
    dw MetaSprites25Set56Frame2 ; entry 2
    dw MetaSprites25Set56Frame3 ; entry 3
    dw MetaSprites25Set56Frame4 ; entry 4
    dw MetaSprites25Set56Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame0::
Data_025_63EA:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame1::
Data_025_63FB:: ; address name
    db $EF, $01, $00, $30 ; entry 0
    db $EF, $F9, $01, $30 ; entry 1
    db $F7, $01, $02, $30 ; entry 2
    db $F7, $F9, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame2::
Data_025_640C:: ; address name
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $06, $10 ; entry 2
    db $F7, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame3::
Data_025_641D:: ; address name
    db $F8, $F8, $09, $10 ; entry 0
    db $F8, $00, $0A, $10 ; entry 1
    db $F0, $F8, $08, $10 ; entry 2
    db $F0, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame4::
Data_025_642E:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame5::
Data_025_643F:: ; address name
    db $EF, $01, $0B, $30 ; entry 0
    db $EF, $F9, $0C, $30 ; entry 1
    db $F7, $01, $0D, $30 ; entry 2
    db $F7, $F9, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 87 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set57::
Data_025_6450:: ; address name
    dw MetaSprites25Set57Frame0 ; entry 0
    dw MetaSprites25Set57Frame1 ; entry 1
    dw MetaSprites25Set57Frame2 ; entry 2
    dw MetaSprites25Set57Frame3 ; entry 3
    dw MetaSprites25Set57Frame4 ; entry 4
    dw MetaSprites25Set57Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame0::
Data_025_645C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame1::
Data_025_646D:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame2::
Data_025_647E:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame3::
Data_025_648F:: ; address name
    db $EF, $F8, $09, $00 ; entry 0
    db $F7, $F8, $02, $00 ; entry 1
    db $EF, $00, $07, $00 ; entry 2
    db $F7, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame4::
Data_025_64A0:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame5::
Data_025_64B1:: ; address name
    db $F7, $F8, $0C, $00 ; entry 0
    db $F7, $00, $0D, $00 ; entry 1
    db $EF, $F8, $0E, $00 ; entry 2
    db $EF, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 88 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set58::
Data_025_64C2:: ; address name
    dw MetaSprites25Set58Frame0 ; entry 0
    dw MetaSprites25Set58Frame1 ; entry 1
    dw MetaSprites25Set58Frame2 ; entry 2
    dw MetaSprites25Set58Frame3 ; entry 3
    dw MetaSprites25Set58Frame4 ; entry 4
    dw MetaSprites25Set58Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame0::
Data_025_64CE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame1::
Data_025_64DF:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $00, $02, $20 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame2::
Data_025_64F0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame3::
Data_025_6501:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame4::
Data_025_6512:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F0, $00, $0B, $20 ; entry 2
    db $F8, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame5::
Data_025_6523:: ; address name
    db $EF, $F8, $0D, $00 ; entry 0
    db $F7, $F8, $0E, $00 ; entry 1
    db $EF, $00, $0D, $20 ; entry 2
    db $F7, $00, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 89 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set59::
Data_025_6534:: ; address name
    dw MetaSprites25Set59Frame0 ; entry 0
    dw MetaSprites25Set59Frame1 ; entry 1
    dw MetaSprites25Set59Frame2 ; entry 2
    dw MetaSprites25Set59Frame3 ; entry 3
    dw MetaSprites25Set59Frame4 ; entry 4
    dw MetaSprites25Set59Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame0::
Data_025_6540:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame1::
Data_025_6551:: ; address name
    db $F0, $F9, $00, $10 ; entry 0
    db $F0, $01, $01, $10 ; entry 1
    db $F8, $F9, $04, $10 ; entry 2
    db $F8, $01, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame2::
Data_025_6562:: ; address name
    db $F0, $F9, $06, $10 ; entry 0
    db $F0, $01, $07, $10 ; entry 1
    db $F8, $F9, $08, $10 ; entry 2
    db $F8, $01, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame3::
Data_025_6573:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame4::
Data_025_6584:: ; address name
    db $F8, $F8, $0E, $10 ; entry 0
    db $F8, $00, $0F, $10 ; entry 1
    db $F0, $F8, $0C, $10 ; entry 2
    db $F0, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame5::
Data_025_6595:: ; address name
    db $F8, $00, $0E, $30 ; entry 0
    db $F8, $F8, $0F, $30 ; entry 1
    db $F0, $F9, $0C, $10 ; entry 2
    db $F0, $01, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 90 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set5A::
Data_025_65A6:: ; address name
    dw MetaSprites25Set5AFrame0 ; entry 0
    dw MetaSprites25Set5AFrame1 ; entry 1
    dw MetaSprites25Set5AFrame2 ; entry 2
    dw MetaSprites25Set5AFrame3 ; entry 3
    dw MetaSprites25Set5AFrame4 ; entry 4
    dw MetaSprites25Set5AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame0::
Data_025_65B2:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame1::
Data_025_65C3:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $04, $10 ; entry 2
    db $F9, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame2::
Data_025_65D4:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame3::
Data_025_65E5:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F8, $06, $10 ; entry 2
    db $F1, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame4::
Data_025_65F6:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $00, $0E, $10 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame5::
Data_025_6607:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0D, $10 ; entry 1
    db $F9, $00, $0F, $10 ; entry 2
    db $F9, $F8, $05, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 91 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set5B::
Data_025_6618:: ; address name
    dw MetaSprites25Set5BFrame0 ; entry 0
    dw MetaSprites25Set5BFrame1 ; entry 1
    dw MetaSprites25Set5BFrame2 ; entry 2
    dw MetaSprites25Set5BFrame3 ; entry 3
    dw MetaSprites25Set5BFrame4 ; entry 4
    dw MetaSprites25Set5BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame0::
Data_025_6624:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame1::
Data_025_6635:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $03, $20 ; entry 1
    db $F7, $00, $01, $20 ; entry 2
    db $F7, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame2::
Data_025_6646:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame3::
Data_025_6657:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F8, $F8, $09, $00 ; entry 1
    db $F0, $00, $05, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame4::
Data_025_6668:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame5::
Data_025_6679:: ; address name
    db $EF, $F8, $0D, $00 ; entry 0
    db $EF, $00, $0D, $20 ; entry 1
    db $F7, $F8, $0E, $00 ; entry 2
    db $F7, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 92 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set5C::
Data_025_668A:: ; address name
    dw MetaSprites25Set5CFrame0 ; entry 0
    dw MetaSprites25Set5CFrame1 ; entry 1
    dw MetaSprites25Set5CFrame2 ; entry 2
    dw MetaSprites25Set5CFrame3 ; entry 3
    dw MetaSprites25Set5CFrame4 ; entry 4
    dw MetaSprites25Set5CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame0::
Data_025_6696:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame1::
Data_025_66A7:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame2::
Data_025_66B8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame3::
Data_025_66C9:: ; address name
    db $F0, $00, $05, $00 ; entry 0
    db $F0, $F8, $08, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame4::
Data_025_66DA:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame5::
Data_025_66EB:: ; address name
    db $F0, $00, $0B, $20 ; entry 0
    db $F0, $F8, $0C, $20 ; entry 1
    db $F8, $00, $0D, $20 ; entry 2
    db $F8, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 93 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set5D::
Data_025_66FC:: ; address name
    dw MetaSprites25Set5DFrame0 ; entry 0
    dw MetaSprites25Set5DFrame1 ; entry 1
    dw MetaSprites25Set5DFrame2 ; entry 2
    dw MetaSprites25Set5DFrame3 ; entry 3
    dw MetaSprites25Set5DFrame4 ; entry 4
    dw MetaSprites25Set5DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame0::
Data_025_6708:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame1::
Data_025_6719:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $00, $10 ; entry 1
    db $F9, $00, $01, $30 ; entry 2
    db $F9, $F8, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame2::
Data_025_672A:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $04, $10 ; entry 1
    db $F8, $F8, $05, $10 ; entry 2
    db $F8, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame3::
Data_025_673B:: ; address name
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $07, $10 ; entry 2
    db $F9, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame4::
Data_025_674C:: ; address name
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $00, $09, $30 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame5::
Data_025_675D:: ; address name
    db $F1, $F8, $09, $10 ; entry 0
    db $F1, $00, $09, $30 ; entry 1
    db $F9, $00, $0A, $30 ; entry 2
    db $F9, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 94 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set5E::
Data_025_676E:: ; address name
    dw MetaSprites25Set5EFrame0 ; entry 0
    dw MetaSprites25Set5EFrame1 ; entry 1
    dw MetaSprites25Set5EFrame2 ; entry 2
    dw MetaSprites25Set5EFrame3 ; entry 3
    dw MetaSprites25Set5EFrame4 ; entry 4
    dw MetaSprites25Set5EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame0::
Data_025_677A:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame1::
Data_025_678B:: ; address name
    db $EF, $00, $00, $30 ; entry 0
    db $EF, $F8, $01, $30 ; entry 1
    db $F7, $00, $02, $30 ; entry 2
    db $F7, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame2::
Data_025_679C:: ; address name
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $06, $10 ; entry 2
    db $F7, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame3::
Data_025_67AD:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame4::
Data_025_67BE:: ; address name
    db $F8, $F8, $0E, $10 ; entry 0
    db $F8, $00, $0F, $10 ; entry 1
    db $F0, $F8, $0C, $10 ; entry 2
    db $F0, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame5::
Data_025_67CF:: ; address name
    db $F7, $00, $0E, $30 ; entry 0
    db $F7, $F8, $0F, $30 ; entry 1
    db $EF, $00, $0C, $30 ; entry 2
    db $EF, $F8, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 95 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set5F::
Data_025_67E0:: ; address name
    dw MetaSprites25Set5FFrame0 ; entry 0
    dw MetaSprites25Set5FFrame1 ; entry 1
    dw MetaSprites25Set5FFrame2 ; entry 2
    dw MetaSprites25Set5FFrame3 ; entry 3
    dw MetaSprites25Set5FFrame4 ; entry 4
    dw MetaSprites25Set5FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame0::
Data_025_67EC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F8, $00, $03, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame1::
Data_025_67FD:: ; address name
    db $F1, $F8, $01, $00 ; entry 0
    db $F1, $00, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame2::
Data_025_680E:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame3::
Data_025_681F:: ; address name
    db $F1, $F9, $0A, $00 ; entry 0
    db $F1, $01, $0B, $00 ; entry 1
    db $F9, $F9, $0C, $00 ; entry 2
    db $F9, $01, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame4::
Data_025_6830:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $04, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame5::
Data_025_6841:: ; address name
    db $F9, $00, $0E, $20 ; entry 0
    db $F9, $F8, $0F, $20 ; entry 1
    db $F1, $F8, $05, $00 ; entry 2
    db $F1, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 96 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set60::
Data_025_6852:: ; address name
    dw MetaSprites25Set60Frame0 ; entry 0
    dw MetaSprites25Set60Frame1 ; entry 1
    dw MetaSprites25Set60Frame2 ; entry 2
    dw MetaSprites25Set60Frame3 ; entry 3
    dw MetaSprites25Set60Frame4 ; entry 4
    dw MetaSprites25Set60Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame0::
Data_025_685E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame1::
Data_025_686F:: ; address name
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $03, $20 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame2::
Data_025_6880:: ; address name
    db $EF, $F8, $06, $00 ; entry 0
    db $EF, $00, $07, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame3::
Data_025_6891:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame4::
Data_025_68A2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame5::
Data_025_68B3:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 97 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set61::
Data_025_68C4:: ; address name
    dw MetaSprites25Set61Frame0 ; entry 0
    dw MetaSprites25Set61Frame1 ; entry 1
    dw MetaSprites25Set61Frame2 ; entry 2
    dw MetaSprites25Set61Frame3 ; entry 3
    dw MetaSprites25Set61Frame4 ; entry 4
    dw MetaSprites25Set61Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame0::
Data_025_68D0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame1::
Data_025_68E1:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame2::
Data_025_68F2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame3::
Data_025_6903:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame4::
Data_025_6914:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame5::
Data_025_6925:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 98 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set62::
Data_025_6936:: ; address name
    dw MetaSprites25Set62Frame0 ; entry 0
    dw MetaSprites25Set62Frame1 ; entry 1
    dw MetaSprites25Set62Frame2 ; entry 2
    dw MetaSprites25Set62Frame3 ; entry 3
    dw MetaSprites25Set62Frame4 ; entry 4
    dw MetaSprites25Set62Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame0::
Data_025_6942:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame1::
Data_025_6953:: ; address name
    db $F1, $F9, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $00, $01, $20 ; entry 2
    db $F9, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame2::
Data_025_6964:: ; address name
    db $F2, $F8, $07, $00 ; entry 0
    db $F2, $00, $08, $00 ; entry 1
    db $FA, $F8, $09, $00 ; entry 2
    db $FA, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame3::
Data_025_6975:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $08, $00 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame4::
Data_025_6986:: ; address name
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $04, $00 ; entry 1
    db $F9, $F8, $05, $00 ; entry 2
    db $F9, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame5::
Data_025_6997:: ; address name
    db $F9, $00, $05, $20 ; entry 0
    db $F9, $F8, $06, $20 ; entry 1
    db $F1, $00, $03, $20 ; entry 2
    db $F1, $F8, $04, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 99 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set63::
Data_025_69A8:: ; address name
    dw MetaSprites25Set63Frame0 ; entry 0
    dw MetaSprites25Set63Frame1 ; entry 1
    dw MetaSprites25Set63Frame2 ; entry 2
    dw MetaSprites25Set63Frame3 ; entry 3
    dw MetaSprites25Set63Frame4 ; entry 4
    dw MetaSprites25Set63Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame0::
Data_025_69B4:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame1::
Data_025_69C5:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame2::
Data_025_69D6:: ; address name
    db $F1, $F8, $06, $10 ; entry 0
    db $F1, $00, $07, $10 ; entry 1
    db $F9, $F8, $08, $10 ; entry 2
    db $F9, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame3::
Data_025_69E7:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame4::
Data_025_69F8:: ; address name
    db $F0, $F8, $0E, $10 ; entry 0
    db $F0, $00, $0F, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame5::
Data_025_6A09:: ; address name
    db $F1, $00, $0E, $30 ; entry 0
    db $F1, $F8, $0F, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 100 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set64::
Data_025_6A1A:: ; address name
    dw MetaSprites25Set64Frame0 ; entry 0
    dw MetaSprites25Set64Frame1 ; entry 1
    dw MetaSprites25Set64Frame2 ; entry 2
    dw MetaSprites25Set64Frame3 ; entry 3
    dw MetaSprites25Set64Frame4 ; entry 4
    dw MetaSprites25Set64Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame0::
Data_025_6A26:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame1::
Data_025_6A37:: ; address name
    db $EF, $FF, $00, $20 ; entry 0
    db $EF, $F7, $01, $20 ; entry 1
    db $F7, $FF, $02, $20 ; entry 2
    db $F7, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame2::
Data_025_6A48:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame3::
Data_025_6A59:: ; address name
    db $EF, $00, $05, $00 ; entry 0
    db $EF, $F8, $08, $00 ; entry 1
    db $F7, $F8, $09, $00 ; entry 2
    db $F7, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame4::
Data_025_6A6A:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame5::
Data_025_6A7B:: ; address name
    db $EF, $01, $0B, $20 ; entry 0
    db $EF, $F9, $0C, $20 ; entry 1
    db $F7, $01, $0D, $20 ; entry 2
    db $F7, $F9, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 101 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set65::
Data_025_6A8C:: ; address name
    dw MetaSprites25Set65Frame0 ; entry 0
    dw MetaSprites25Set65Frame1 ; entry 1
    dw MetaSprites25Set65Frame2 ; entry 2
    dw MetaSprites25Set65Frame3 ; entry 3
    dw MetaSprites25Set65Frame4 ; entry 4
    dw MetaSprites25Set65Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame0::
Data_025_6A98:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame1::
Data_025_6AA9:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F9, $F8, $03, $00 ; entry 1
    db $F9, $00, $04, $00 ; entry 2
    db $F1, $F8, $00, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame2::
Data_025_6ABA:: ; address name
    db $F0, $F9, $05, $00 ; entry 0
    db $F0, $01, $06, $00 ; entry 1
    db $F8, $F9, $07, $00 ; entry 2
    db $F8, $01, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame3::
Data_025_6ACB:: ; address name
    db $F9, $F9, $09, $00 ; entry 0
    db $F9, $01, $0A, $00 ; entry 1
    db $F1, $F9, $05, $00 ; entry 2
    db $F1, $01, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame4::
Data_025_6ADC:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame5::
Data_025_6AED:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0B, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 102 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set66::
Data_025_6AFE:: ; address name
    dw MetaSprites25Set66Frame0 ; entry 0
    dw MetaSprites25Set66Frame1 ; entry 1
    dw MetaSprites25Set66Frame2 ; entry 2
    dw MetaSprites25Set66Frame3 ; entry 3
    dw MetaSprites25Set66Frame4 ; entry 4
    dw MetaSprites25Set66Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame0::
Data_025_6B0A:: ; address name
    db $F0, $F8, $00, $20 ; entry 0
    db $F0, $FF, $00, $00 ; entry 1
    db $F8, $F7, $01, $00 ; entry 2
    db $F8, $FF, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame1::
Data_025_6B1B:: ; address name
    db $F1, $F8, $00, $20 ; entry 0
    db $F1, $FF, $00, $00 ; entry 1
    db $F9, $F7, $03, $00 ; entry 2
    db $F9, $FF, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame2::
Data_025_6B2C:: ; address name
    db $F8, $F8, $07, $00 ; entry 0
    db $F8, $00, $08, $00 ; entry 1
    db $F0, $F8, $05, $00 ; entry 2
    db $F0, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame3::
Data_025_6B3D:: ; address name
    db $F9, $F8, $09, $00 ; entry 0
    db $F9, $00, $0A, $00 ; entry 1
    db $F1, $F8, $05, $00 ; entry 2
    db $F1, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame4::
Data_025_6B4E:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F0, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame5::
Data_025_6B5F:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $FF, $0B, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 103 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set67::
Data_025_6B70:: ; address name
    dw MetaSprites25Set67Frame0 ; entry 0
    dw MetaSprites25Set67Frame1 ; entry 1
    dw MetaSprites25Set67Frame2 ; entry 2
    dw MetaSprites25Set67Frame3 ; entry 3
    dw MetaSprites25Set67Frame4 ; entry 4
    dw MetaSprites25Set67Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame0::
Data_025_6B7C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame1::
Data_025_6B8D:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame2::
Data_025_6B9E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame3::
Data_025_6BAF:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame4::
Data_025_6BC0:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame5::
Data_025_6BD1:: ; address name
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 107 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set6B::
Data_025_6BE2:: ; address name
    dw MetaSprites25Set6BFrame0 ; entry 0
    dw MetaSprites25Set6BFrame1 ; entry 1
    dw MetaSprites25Set6BFrame2 ; entry 2
    dw MetaSprites25Set6BFrame3 ; entry 3
    dw MetaSprites25Set6BFrame4 ; entry 4
    dw MetaSprites25Set6BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame0::
Data_025_6BEE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FC, $01, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame1::
Data_025_6BFB:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $FF, $02, $20 ; entry 1
    db $F9, $FC, $01, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame2::
Data_025_6C08:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame3::
Data_025_6C19:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F8, $F8, $0B, $00 ; entry 1
    db $F8, $00, $0C, $00 ; entry 2
    db $F0, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame4::
Data_025_6C2A:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $FF, $03, $20 ; entry 1
    db $F8, $FC, $04, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame5::
Data_025_6C37:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $FF, $05, $20 ; entry 1
    db $F9, $FC, $04, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 108 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set6C::
Data_025_6C44:: ; address name
    dw MetaSprites25Set6CFrame0 ; entry 0
    dw MetaSprites25Set6CFrame1 ; entry 1
    dw MetaSprites25Set6CFrame2 ; entry 2
    dw MetaSprites25Set6CFrame3 ; entry 3
    dw MetaSprites25Set6CFrame4 ; entry 4
    dw MetaSprites25Set6CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame0::
Data_025_6C50:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame1::
Data_025_6C61:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame2::
Data_025_6C72:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame3::
Data_025_6C83:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame4::
Data_025_6C94:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame5::
Data_025_6CA5:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 109 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set6D::
Data_025_6CB6:: ; address name
    dw MetaSprites25Set6DFrame0 ; entry 0
    dw MetaSprites25Set6DFrame1 ; entry 1
    dw MetaSprites25Set6DFrame2 ; entry 2
    dw MetaSprites25Set6DFrame3 ; entry 3
    dw MetaSprites25Set6DFrame4 ; entry 4
    dw MetaSprites25Set6DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame0::
Data_025_6CC2:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame1::
Data_025_6CD3:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame2::
Data_025_6CE4:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame3::
Data_025_6CF5:: ; address name
    db $F9, $F8, $08, $10 ; entry 0
    db $F9, $00, $09, $10 ; entry 1
    db $F1, $F8, $0A, $10 ; entry 2
    db $F1, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame4::
Data_025_6D06:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0C, $30 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame5::
Data_025_6D17:: ; address name
    db $F9, $F8, $0E, $10 ; entry 0
    db $F9, $00, $0F, $10 ; entry 1
    db $F1, $F8, $0D, $10 ; entry 2
    db $F1, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 110 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set6E::
Data_025_6D28:: ; address name
    dw MetaSprites25Set6EFrame0 ; entry 0
    dw MetaSprites25Set6EFrame1 ; entry 1
    dw MetaSprites25Set6EFrame2 ; entry 2
    dw MetaSprites25Set6EFrame3 ; entry 3
    dw MetaSprites25Set6EFrame4 ; entry 4
    dw MetaSprites25Set6EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame0::
Data_025_6D34:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame1::
Data_025_6D45:: ; address name
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $00, $30 ; entry 1
    db $F7, $F8, $01, $10 ; entry 2
    db $F7, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame2::
Data_025_6D56:: ; address name
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $03, $10 ; entry 1
    db $F8, $F8, $04, $10 ; entry 2
    db $F8, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame3::
Data_025_6D67:: ; address name
    db $EF, $F8, $02, $10 ; entry 0
    db $EF, $00, $03, $10 ; entry 1
    db $F7, $F8, $04, $10 ; entry 2
    db $F7, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame4::
Data_025_6D78:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $06, $30 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $07, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame5::
Data_025_6D89:: ; address name
    db $EF, $F8, $06, $10 ; entry 0
    db $EF, $00, $06, $30 ; entry 1
    db $F7, $F8, $07, $10 ; entry 2
    db $F7, $00, $07, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 111 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set6F::
Data_025_6D9A:: ; address name
    dw MetaSprites25Set6FFrame0 ; entry 0
    dw MetaSprites25Set6FFrame1 ; entry 1
    dw MetaSprites25Set6FFrame2 ; entry 2
    dw MetaSprites25Set6FFrame3 ; entry 3
    dw MetaSprites25Set6FFrame4 ; entry 4
    dw MetaSprites25Set6FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame0::
Data_025_6DA6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame1::
Data_025_6DB7:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame2::
Data_025_6DC8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame3::
Data_025_6DD9:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame4::
Data_025_6DEA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame5::
Data_025_6DFB:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 112 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set70::
Data_025_6E0C:: ; address name
    dw MetaSprites25Set70Frame0 ; entry 0
    dw MetaSprites25Set70Frame1 ; entry 1
    dw MetaSprites25Set70Frame2 ; entry 2
    dw MetaSprites25Set70Frame3 ; entry 3
    dw MetaSprites25Set70Frame4 ; entry 4
    dw MetaSprites25Set70Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame0::
Data_025_6E18:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame1::
Data_025_6E29:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $00, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame2::
Data_025_6E3A:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame3::
Data_025_6E4B:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame4::
Data_025_6E5C:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame5::
Data_025_6E6D:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 113 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set71::
Data_025_6E7E:: ; address name
    dw MetaSprites25Set71Frame0 ; entry 0
    dw MetaSprites25Set71Frame1 ; entry 1
    dw MetaSprites25Set71Frame2 ; entry 2
    dw MetaSprites25Set71Frame3 ; entry 3
    dw MetaSprites25Set71Frame4 ; entry 4
    dw MetaSprites25Set71Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame0::
Data_025_6E8A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame1::
Data_025_6E9B:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $00, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame2::
Data_025_6EAC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame3::
Data_025_6EBD:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame4::
Data_025_6ECE:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame5::
Data_025_6EDF:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 114 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set72::
Data_025_6EF0:: ; address name
    dw MetaSprites25Set72Frame0 ; entry 0
    dw MetaSprites25Set72Frame1 ; entry 1
    dw MetaSprites25Set72Frame2 ; entry 2
    dw MetaSprites25Set72Frame3 ; entry 3
    dw MetaSprites25Set72Frame4 ; entry 4
    dw MetaSprites25Set72Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame0::
Data_025_6EFC:: ; address name
    db $EF, $F9, $00, $00 ; entry 0
    db $EF, $01, $01, $00 ; entry 1
    db $F7, $F9, $02, $00 ; entry 2
    db $F7, $01, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame1::
Data_025_6F0D:: ; address name
    db $F0, $F9, $00, $00 ; entry 0
    db $F8, $F9, $02, $00 ; entry 1
    db $F0, $01, $04, $00 ; entry 2
    db $F8, $01, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame2::
Data_025_6F1E:: ; address name
    db $EF, $F8, $06, $00 ; entry 0
    db $EF, $00, $07, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame3::
Data_025_6F2F:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame4::
Data_025_6F40:: ; address name
    db $EF, $F7, $01, $20 ; entry 0
    db $F7, $F7, $03, $20 ; entry 1
    db $EF, $FF, $0C, $00 ; entry 2
    db $F7, $FF, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame5::
Data_025_6F51:: ; address name
    db $F0, $F7, $04, $20 ; entry 0
    db $F8, $F7, $05, $20 ; entry 1
    db $F0, $FF, $0E, $00 ; entry 2
    db $F8, $FF, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 115 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set73::
Data_025_6F62:: ; address name
    dw MetaSprites25Set73Frame0 ; entry 0
    dw MetaSprites25Set73Frame1 ; entry 1
    dw MetaSprites25Set73Frame2 ; entry 2
    dw MetaSprites25Set73Frame3 ; entry 3
    dw MetaSprites25Set73Frame4 ; entry 4
    dw MetaSprites25Set73Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame0::
Data_025_6F6E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame1::
Data_025_6F7F:: ; address name
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $03, $20 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame2::
Data_025_6F90:: ; address name
    db $F0, $00, $06, $20 ; entry 0
    db $F8, $00, $07, $20 ; entry 1
    db $F8, $F8, $08, $20 ; entry 2
    db $F0, $F9, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame3::
Data_025_6FA1:: ; address name
    db $F1, $00, $06, $20 ; entry 0
    db $F9, $00, $09, $20 ; entry 1
    db $F9, $F8, $0A, $20 ; entry 2
    db $F1, $F9, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame4::
Data_025_6FB2:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame5::
Data_025_6FC3:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 116 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set74::
Data_025_6FD4:: ; address name
    dw MetaSprites25Set74Frame0 ; entry 0
    dw MetaSprites25Set74Frame1 ; entry 1
    dw MetaSprites25Set74Frame2 ; entry 2
    dw MetaSprites25Set74Frame3 ; entry 3
    dw MetaSprites25Set74Frame4 ; entry 4
    dw MetaSprites25Set74Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame0::
Data_025_6FE0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame1::
Data_025_6FF1:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $03, $20 ; entry 1
    db $F7, $F8, $04, $00 ; entry 2
    db $F7, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame2::
Data_025_7002:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame3::
Data_025_7013:: ; address name
    db $EF, $00, $07, $00 ; entry 0
    db $EF, $F8, $0A, $00 ; entry 1
    db $F7, $FB, $0B, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame4::
Data_025_7020:: ; address name
    db $F8, $F8, $01, $00 ; entry 0
    db $F8, $00, $02, $00 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame5::
Data_025_7031:: ; address name
    db $F7, $F8, $04, $00 ; entry 0
    db $F7, $00, $05, $00 ; entry 1
    db $EF, $F8, $0D, $00 ; entry 2
    db $EF, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 117 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set75::
Data_025_7042:: ; address name
    dw MetaSprites25Set75Frame0 ; entry 0
    dw MetaSprites25Set75Frame1 ; entry 1
    dw MetaSprites25Set75Frame2 ; entry 2
    dw MetaSprites25Set75Frame3 ; entry 3
    dw MetaSprites25Set75Frame4 ; entry 4
    dw MetaSprites25Set75Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set75; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame0::
Data_025_704E:: ; address name
    db $F0, $F8, $01, $00 ; entry 0
    db $F0, $00, $02, $00 ; entry 1
    db $F8, $F8, $00, $00 ; entry 2
    db $F8, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set75; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame1::
Data_025_705F:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $00, $00 ; entry 2
    db $F7, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set75; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame2::
Data_025_7070:: ; address name
    db $EF, $F8, $05, $00 ; entry 0
    db $EF, $00, $06, $00 ; entry 1
    db $F7, $F8, $07, $00 ; entry 2
    db $F7, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set75; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame3::
Data_025_7081:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $00, $06, $00 ; entry 2
    db $F8, $F8, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set75; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame4::
Data_025_7092:: ; address name
    db $F8, $F8, $0B, $00 ; entry 0
    db $F8, $00, $0B, $20 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set75; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame5::
Data_025_70A3:: ; address name
    db $F7, $F8, $0B, $00 ; entry 0
    db $F7, $00, $0B, $20 ; entry 1
    db $EF, $F8, $0E, $00 ; entry 2
    db $EF, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 118 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set76::
Data_025_70B4:: ; address name
    dw MetaSprites25Set76Frame0 ; entry 0
    dw MetaSprites25Set76Frame1 ; entry 1
    dw MetaSprites25Set76Frame2 ; entry 2
    dw MetaSprites25Set76Frame3 ; entry 3
    dw MetaSprites25Set76Frame4 ; entry 4
    dw MetaSprites25Set76Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set76; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame0::
Data_025_70C0:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set76; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame1::
Data_025_70D1:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set76; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame2::
Data_025_70E2:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set76; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame3::
Data_025_70F3:: ; address name
    db $F1, $00, $04, $30 ; entry 0
    db $F1, $F8, $05, $30 ; entry 1
    db $F9, $F8, $08, $10 ; entry 2
    db $F9, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set76; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame4::
Data_025_7104:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set76; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame5::
Data_025_7115:: ; address name
    db $F1, $00, $0A, $30 ; entry 0
    db $F1, $F8, $0B, $30 ; entry 1
    db $F9, $00, $0C, $30 ; entry 2
    db $F9, $F8, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 119 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set77::
Data_025_7126:: ; address name
    dw MetaSprites25Set77Frame0 ; entry 0
    dw MetaSprites25Set77Frame1 ; entry 1
    dw MetaSprites25Set77Frame2 ; entry 2
    dw MetaSprites25Set77Frame3 ; entry 3
    dw MetaSprites25Set77Frame4 ; entry 4
    dw MetaSprites25Set77Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame0::
Data_025_7132:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame1::
Data_025_7143:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame2::
Data_025_7154:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame3::
Data_025_7165:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame4::
Data_025_7176:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame5::
Data_025_7187:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 120 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set78::
Data_025_7198:: ; address name
    dw MetaSprites25Set78Frame0 ; entry 0
    dw MetaSprites25Set78Frame1 ; entry 1
    dw MetaSprites25Set78Frame2 ; entry 2
    dw MetaSprites25Set78Frame3 ; entry 3
    dw MetaSprites25Set78Frame4 ; entry 4
    dw MetaSprites25Set78Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame0::
Data_025_71A4:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame1::
Data_025_71B5:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame2::
Data_025_71C6:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame3::
Data_025_71D7:: ; address name
    db $F1, $00, $05, $10 ; entry 0
    db $F9, $00, $07, $10 ; entry 1
    db $F1, $F8, $08, $10 ; entry 2
    db $F9, $F8, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame4::
Data_025_71E8:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame5::
Data_025_71F9:: ; address name
    db $F1, $F8, $0A, $10 ; entry 0
    db $F1, $00, $0B, $10 ; entry 1
    db $F9, $F8, $0D, $10 ; entry 2
    db $F9, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 121 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set79::
Data_025_720A:: ; address name
    dw MetaSprites25Set79Frame0 ; entry 0
    dw MetaSprites25Set79Frame1 ; entry 1
    dw MetaSprites25Set79Frame2 ; entry 2
    dw MetaSprites25Set79Frame3 ; entry 3
    dw MetaSprites25Set79Frame4 ; entry 4
    dw MetaSprites25Set79Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame0::
Data_025_7216:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame1::
Data_025_7227:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame2::
Data_025_7238:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame3::
Data_025_7249:: ; address name
    db $F1, $00, $05, $00 ; entry 0
    db $F9, $00, $07, $00 ; entry 1
    db $F1, $F8, $08, $00 ; entry 2
    db $F9, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame4::
Data_025_725A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame5::
Data_025_726B:: ; address name
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 122 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set7A::
Data_025_727C:: ; address name
    dw MetaSprites25Set7AFrame0 ; entry 0
    dw MetaSprites25Set7AFrame1 ; entry 1
    dw MetaSprites25Set7AFrame2 ; entry 2
    dw MetaSprites25Set7AFrame3 ; entry 3
    dw MetaSprites25Set7AFrame4 ; entry 4
    dw MetaSprites25Set7AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame0::
Data_025_7288:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $FF, $00, $20 ; entry 1
    db $F7, $F8, $01, $00 ; entry 2
    db $F7, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame1::
Data_025_7299:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame2::
Data_025_72AA:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $05, $00 ; entry 2
    db $F7, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame3::
Data_025_72BB:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame4::
Data_025_72CC:: ; address name
    db $EF, $00, $09, $00 ; entry 0
    db $EF, $F9, $09, $20 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame5::
Data_025_72DD:: ; address name
    db $F0, $F9, $09, $20 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $01, $0A, $20 ; entry 2
    db $F8, $F9, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 123 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set7B::
Data_025_72EE:: ; address name
    dw MetaSprites25Set7BFrame0 ; entry 0
    dw MetaSprites25Set7BFrame1 ; entry 1
    dw MetaSprites25Set7BFrame2 ; entry 2
    dw MetaSprites25Set7BFrame3 ; entry 3
    dw MetaSprites25Set7BFrame4 ; entry 4
    dw MetaSprites25Set7BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame0::
Data_025_72FA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame1::
Data_025_730B:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $FF, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame2::
Data_025_731C:: ; address name
    db $F8, $F8, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame3::
Data_025_732D:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame4::
Data_025_733E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame5::
Data_025_734F:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $FF, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 124 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set7C::
Data_025_7360:: ; address name
    dw MetaSprites25Set7CFrame0 ; entry 0
    dw MetaSprites25Set7CFrame1 ; entry 1
    dw MetaSprites25Set7CFrame2 ; entry 2
    dw MetaSprites25Set7CFrame3 ; entry 3
    dw MetaSprites25Set7CFrame4 ; entry 4
    dw MetaSprites25Set7CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame0::
Data_025_736C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame1::
Data_025_737D:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame2::
Data_025_738E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame3::
Data_025_739F:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame4::
Data_025_73B0:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame5::
Data_025_73C1:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $FF, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 125 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set7D::
Data_025_73D2:: ; address name
    dw MetaSprites25Set7DFrame0 ; entry 0
    dw MetaSprites25Set7DFrame1 ; entry 1
    dw MetaSprites25Set7DFrame2 ; entry 2
    dw MetaSprites25Set7DFrame3 ; entry 3
    dw MetaSprites25Set7DFrame4 ; entry 4
    dw MetaSprites25Set7DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame0::
Data_025_73DE:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $FF, $00, $20 ; entry 1
    db $F7, $F8, $01, $00 ; entry 2
    db $F7, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame1::
Data_025_73EF:: ; address name
    db $F8, $FF, $01, $20 ; entry 0
    db $F8, $F7, $02, $20 ; entry 1
    db $F0, $F8, $03, $00 ; entry 2
    db $F0, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame2::
Data_025_7400:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame3::
Data_025_7411:: ; address name
    db $F0, $00, $05, $00 ; entry 0
    db $F0, $F8, $08, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame4::
Data_025_7422:: ; address name
    db $EF, $F8, $0B, $00 ; entry 0
    db $EF, $FF, $0B, $20 ; entry 1
    db $F7, $F8, $0C, $00 ; entry 2
    db $F7, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame5::
Data_025_7433:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0E, $00 ; entry 2
    db $F0, $FF, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 126 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set7E::
Data_025_7444:: ; address name
    dw MetaSprites25Set7EFrame0 ; entry 0
    dw MetaSprites25Set7EFrame1 ; entry 1
    dw MetaSprites25Set7EFrame2 ; entry 2
    dw MetaSprites25Set7EFrame3 ; entry 3
    dw MetaSprites25Set7EFrame4 ; entry 4
    dw MetaSprites25Set7EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame0::
Data_025_7450:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame1::
Data_025_7461:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $FF, $02, $20 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame2::
Data_025_7472:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame3::
Data_025_7483:: ; address name
    db $EF, $00, $05, $00 ; entry 0
    db $F7, $00, $07, $00 ; entry 1
    db $EF, $F8, $08, $00 ; entry 2
    db $F7, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame4::
Data_025_7494:: ; address name
    db $F0, $00, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F9, $0A, $20 ; entry 2
    db $F8, $F9, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame5::
Data_025_74A5:: ; address name
    db $EF, $00, $0C, $00 ; entry 0
    db $F7, $00, $0D, $00 ; entry 1
    db $EF, $F9, $0C, $20 ; entry 2
    db $F7, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 127 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites25Set7F::
Data_025_74B6:: ; address name
    dw MetaSprites25Set7FFrame0 ; entry 0
    dw MetaSprites25Set7FFrame1 ; entry 1
    dw MetaSprites25Set7FFrame2 ; entry 2
    dw MetaSprites25Set7FFrame3 ; entry 3
    dw MetaSprites25Set7FFrame4 ; entry 4
    dw MetaSprites25Set7FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites25Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame0::
Data_025_74C2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites25Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame1::
Data_025_74D3:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $FF, $02, $20 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites25Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame2::
Data_025_74E4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites25Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame3::
Data_025_74F5:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites25Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame4::
Data_025_7506:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites25Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame5::
Data_025_7517:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $F7, $F8, $0F, $00 ; entry 1
    db $EF, $FF, $0E, $20 ; entry 2
    db $F7, $FF, $0F, $20 ; entry 3
    db $80 ; end
    ds $AD8, $00
