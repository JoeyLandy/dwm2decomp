SECTION "Bank 25", ROMX[$4000], BANK[$25]
    db $25

; ORs the attribute bits from MetaSprites25Attrs[hSpriteSetIndex] (when its bit 0 is set) into
; hSpriteAttrXor, then builds the sprite from MetaSprites25Table (E-0124)
DrawMetaSpriteSet_Bank25::
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, MetaSprites25Attrs
    add hl, de
    bit 0, [hl]
    jr z, .call_draw_meta_sprite_set_bank25_wait_oam
    ld a, [hl]
    and $f0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or e
    ldh [hSpriteAttrXor], a

.call_draw_meta_sprite_set_bank25_wait_oam:
    ld de, MetaSprites25Table
    call DrawMetaSpriteSet_Bank25_WaitOamNextEntry
    ret

; DrawMetaSpriteSet_Bank25 passes DE = $MetaSprites25Table to the builder, which takes the word at
; DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 128
; words up to the attribute table at $411E (E-0147, C1)
; record: meta-sprite set
MetaSprites25Table::
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

; DrawMetaSpriteSet_Bank25 reads the byte $411E + hSpriteSetIndex; when bit 0 is set it ORs its high
; nibble into hSpriteAttrXor before drawing (E-0147, C1)
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites25Attrs::
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

DrawMetaSpriteSet_Bank25_WaitOamNextEntry::
    ldh a, [hOamNextEntry]
    cp $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hMetaSpriteYLo], a
    ldh a, [hSpriteOriginYHi]
    adc b
    ldh [hMetaSpriteYHi], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hMetaSpriteXLo
    ldh a, [hSpriteOriginX]
    add c
    ld c, a
    ld [hli], a
    ldh a, [hSpriteOriginXHi]
    adc b
    ld b, a
    ld [hli], a
    ld a, c
    sub $08
    ld [hli], a
    ld a, b
    sbc $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a
    add e
    ld l, a
    ld a, $00
    adc d
    ld h, a
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a
    add a
    ld e, a
    ld d, $c0
    ldh a, [hSpriteWindowClipMode]
    or a
    jp nz, .check_sprite_attr_xor
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and $20
    jr nz, .loop2

.loop:
    ld a, [hli]
    cp $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $00
    jr nz, .next
    ld a, b
    cp $a8
    jr c, .skip
    jr .next

.read_meta_sprite_y_lo:
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $ff
    jr nz, .next
    ld a, b
    cp $a8
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
    ld a, [hli]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_lo
    ldh a, [hMetaSpriteXLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc $00
    jr nz, .next2
    ld a, b
    cp $b8
    jr c, .skip2
    jr .next2

.read_meta_sprite_x_lo:
    ldh a, [hMetaSpriteXLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc $ff
    jr nz, .next2
    ld a, b
    cp $b8
    jr c, .skip2

.next2:
    inc hl
    inc hl
    dec e
    xor a
    ld [de], a
    jr .loop

.skip2:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hli]
    add c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop
    ret

.loop2:
    ld a, [hli]
    cp $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo2
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $00
    jr nz, .next3
    ld a, b
    cp $a8
    jr c, .skip3
    jr .next3

.read_meta_sprite_y_lo2:
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $ff
    jr nz, .next3
    ld a, b
    cp $a8
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
    ld a, [hli]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_flip_lo
    ldh a, [hMetaSpriteXFlipLo]
    sub b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc $00
    jr z, .skip4
    jr nz, .next4
    ld a, b
    cp $b8
    jr c, .skip4
    jr .next4

.read_meta_sprite_x_flip_lo:
    ldh a, [hMetaSpriteXFlipLo]
    sub b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc $ff
    jr nz, .next4
    ld a, b
    cp $b8
    jr c, .skip4

.next4:
    inc hl
    inc hl
    dec e
    xor a
    ld [de], a
    jr .loop2

.skip4:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hli]
    add c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop2
    ret

.check_sprite_attr_xor:
    ldh a, [hSpriteAttrXor]
    and $20
    jr nz, .loop5

.loop3:
    ld a, [hli]
    cp $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo3
    dec b

.read_meta_sprite_y_lo3:
    ldh a, [hMetaSpriteYLo]
    add c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc b
    jr nz, .next5
    ld a, c
    cp $b8
    jr nc, .next5
    ldh a, [hSpriteWindowClipMode]
    or a
    jr z, .skip6
    cp $01
    jr nz, .cp_02
    ld a, c
    cp $34
    jr c, .next5
    jr .skip6

.cp_02:
    cp $02
    jr nz, .skip5
    ld a, c
    cp $71
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
    ld a, [hli]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_lo2
    dec b

.read_meta_sprite_x_lo2:
    ldh a, [hMetaSpriteXLo]
    add c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc b
    jr nz, .loop4
    ld a, c
    cp $b8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile

.loop4:
    inc hl
    inc hl
    dec e
    xor a
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
    ld a, [hli]
    add b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop3
    ret

.loop5:
    ld a, [hli]
    cp $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo4
    dec b

.read_meta_sprite_y_lo4:
    ldh a, [hMetaSpriteYLo]
    add c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc b
    jr nz, .next6
    ld a, c
    cp $b8
    jr nc, .next6
    ldh a, [hSpriteWindowClipMode]
    or a
    jr z, .skip8
    cp $01
    jr nz, .cp_022
    ld a, c
    cp $34
    jr c, .next6
    jr .skip8

.cp_022:
    cp $02
    jr nz, .skip7
    ld a, c
    cp $71
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
    ld a, [hli]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_flip_lo2
    dec b

.read_meta_sprite_x_flip_lo2:
    ldh a, [hMetaSpriteXFlipLo]
    sub c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc b
    jr nz, .loop6
    ld a, c
    cp $b8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile2

.loop6:
    inc hl
    inc hl
    dec e
    xor a
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
    ld a, [hli]
    add b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop5
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map
; entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after
; rSTAT bit 1 clears (interrupts off) and compares with hSpriteHideTile: Z set when equal, A = the
; tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
BGTileUnderPointIsSpriteHideTile_Bank25::
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add b
    sub $0c
    and $f8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add b
    sub $04
    and $f8
    rrca
    rrca
    rrca
    add l
    ld l, a
    ld a, h
    and $03
    adc $98
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
    cp b
    pop bc
    pop hl
    ret

; meta-sprite set 0 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set00::
    dw MetaSprites25Set00Frame0 ; entry 0
    dw MetaSprites25Set00Frame1 ; entry 1
    dw MetaSprites25Set00Frame2 ; entry 2
    dw MetaSprites25Set00Frame3 ; entry 3
    dw MetaSprites25Set00Frame4 ; entry 4
    dw MetaSprites25Set00Frame5 ; entry 5

; frame 0 of MetaSprites25Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set00; ends with $80 (E-0147)
MetaSprites25Set00Frame1::
    db $f9, $00, $01, $20 ; entry 0
    db $f9, $f8, $02, $20 ; entry 1
    db $f1, $f8, $03, $00 ; entry 2
    db $f1, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set00; ends with $80 (E-0147)
MetaSprites25Set00Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set00; ends with $80 (E-0147)
MetaSprites25Set00Frame3::
    db $f1, $00, $05, $00 ; entry 0
    db $f9, $00, $07, $00 ; entry 1
    db $f1, $f8, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set00Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set00; ends with $80 (E-0147)
MetaSprites25Set00Frame5::
    db $f9, $00, $0b, $20 ; entry 0
    db $f9, $f8, $0c, $20 ; entry 1
    db $f1, $f8, $0d, $00 ; entry 2
    db $f1, $00, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set02::
    dw MetaSprites25Set02Frame0 ; entry 0
    dw MetaSprites25Set02Frame1 ; entry 1
    dw MetaSprites25Set02Frame2 ; entry 2
    dw MetaSprites25Set02Frame3 ; entry 3
    dw MetaSprites25Set02Frame4 ; entry 4
    dw MetaSprites25Set02Frame5 ; entry 5

; frame 0 of MetaSprites25Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set02; ends with $80 (E-0147)
MetaSprites25Set02Frame1::
    db $f0, $f6, $03, $00 ; entry 0
    db $f0, $fe, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set02; ends with $80 (E-0147)
MetaSprites25Set02Frame2::
    db $f8, $f8, $07, $00 ; entry 0
    db $f8, $00, $08, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set02; ends with $80 (E-0147)
MetaSprites25Set02Frame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $fa, $09, $00 ; entry 2
    db $f0, $02, $03, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set02Frame4::
    db $f8, $f8, $0c, $00 ; entry 0
    db $f8, $00, $0d, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set02; ends with $80 (E-0147)
MetaSprites25Set02Frame5::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0f, $00 ; entry 1
    db $f0, $f6, $03, $00 ; entry 2
    db $f0, $fe, $09, $20 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set03::
    dw MetaSprites25Set03Frame0 ; entry 0
    dw MetaSprites25Set03Frame1 ; entry 1
    dw MetaSprites25Set03Frame2 ; entry 2
    dw MetaSprites25Set03Frame3 ; entry 3
    dw MetaSprites25Set03Frame4 ; entry 4
    dw MetaSprites25Set03Frame5 ; entry 5

; frame 0 of MetaSprites25Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f8, $00, $03, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set03; ends with $80 (E-0147)
MetaSprites25Set03Frame1::
    db $f1, $f8, $01, $00 ; entry 0
    db $f1, $ff, $01, $20 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set03; ends with $80 (E-0147)
MetaSprites25Set03Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $0a, $20 ; entry 2
    db $f8, $f8, $0b, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set03; ends with $80 (E-0147)
MetaSprites25Set03Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set03Frame4::
    db $f0, $f9, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set03; ends with $80 (E-0147)
MetaSprites25Set03Frame5::
    db $f1, $f9, $0f, $00 ; entry 0
    db $f1, $00, $0f, $20 ; entry 1
    db $f9, $01, $04, $20 ; entry 2
    db $f9, $f9, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set04::
    dw MetaSprites25Set04Frame0 ; entry 0
    dw MetaSprites25Set04Frame1 ; entry 1
    dw MetaSprites25Set04Frame2 ; entry 2
    dw MetaSprites25Set04Frame3 ; entry 3
    dw MetaSprites25Set04Frame4 ; entry 4
    dw MetaSprites25Set04Frame5 ; entry 5

; frame 0 of MetaSprites25Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set04; ends with $80 (E-0147)
MetaSprites25Set04Frame1::
    db $f9, $f8, $02, $00 ; entry 0
    db $f9, $00, $03, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set04; ends with $80 (E-0147)
MetaSprites25Set04Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set04; ends with $80 (E-0147)
MetaSprites25Set04Frame3::
    db $f9, $00, $08, $00 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $f8, $09, $00 ; entry 2
    db $f1, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set04Frame4::
    db $f8, $00, $0b, $00 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f0, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set04; ends with $80 (E-0147)
MetaSprites25Set04Frame5::
    db $f9, $00, $0b, $00 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $00, $04, $20 ; entry 2
    db $f1, $f8, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set05::
    dw MetaSprites25Set05Frame0 ; entry 0
    dw MetaSprites25Set05Frame1 ; entry 1
    dw MetaSprites25Set05Frame2 ; entry 2
    dw MetaSprites25Set05Frame3 ; entry 3
    dw MetaSprites25Set05Frame4 ; entry 4
    dw MetaSprites25Set05Frame5 ; entry 5

; frame 0 of MetaSprites25Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set05; ends with $80 (E-0147)
MetaSprites25Set05Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set05; ends with $80 (E-0147)
MetaSprites25Set05Frame2::
    db $f0, $00, $06, $00 ; entry 0
    db $f8, $f8, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f0, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set05; ends with $80 (E-0147)
MetaSprites25Set05Frame3::
    db $f1, $00, $06, $00 ; entry 0
    db $f9, $f8, $07, $00 ; entry 1
    db $f1, $f8, $01, $20 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set05Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set05; ends with $80 (E-0147)
MetaSprites25Set05Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 6 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set06::
    dw MetaSprites25Set06Frame0 ; entry 0
    dw MetaSprites25Set06Frame1 ; entry 1
    dw MetaSprites25Set06Frame2 ; entry 2
    dw MetaSprites25Set06Frame3 ; entry 3
    dw MetaSprites25Set06Frame4 ; entry 4
    dw MetaSprites25Set06Frame5 ; entry 5

; frame 0 of MetaSprites25Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set06; ends with $80 (E-0147)
MetaSprites25Set06Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $04, $00 ; entry 1
    db $f9, $f8, $05, $00 ; entry 2
    db $f9, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set06; ends with $80 (E-0147)
MetaSprites25Set06Frame2::
    db $f0, $f8, $01, $20 ; entry 0
    db $f8, $00, $02, $20 ; entry 1
    db $f0, $00, $07, $00 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set06; ends with $80 (E-0147)
MetaSprites25Set06Frame3::
    db $f1, $f8, $04, $20 ; entry 0
    db $f9, $00, $05, $20 ; entry 1
    db $f1, $00, $09, $00 ; entry 2
    db $f9, $f8, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set06Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set06; ends with $80 (E-0147)
MetaSprites25Set06Frame5::
    db $f1, $00, $0c, $00 ; entry 0
    db $f9, $00, $0f, $00 ; entry 1
    db $f1, $f8, $0e, $00 ; entry 2
    db $f9, $f8, $0a, $00 ; entry 3
    db $80 ; end

; meta-sprite set 7 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set07::
    dw MetaSprites25Set07Frame0 ; entry 0
    dw MetaSprites25Set07Frame1 ; entry 1
    dw MetaSprites25Set07Frame2 ; entry 2
    dw MetaSprites25Set07Frame3 ; entry 3
    dw MetaSprites25Set07Frame4 ; entry 4
    dw MetaSprites25Set07Frame5 ; entry 5

; frame 0 of MetaSprites25Set07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame0::
    db $f9, $f8, $00, $00 ; entry 0
    db $f9, $00, $00, $20 ; entry 1
    db $f1, $f8, $02, $00 ; entry 2
    db $f1, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set07; ends with $80 (E-0147)
MetaSprites25Set07Frame1::
    db $f8, $f8, $01, $00 ; entry 0
    db $f8, $00, $01, $20 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set07; ends with $80 (E-0147)
MetaSprites25Set07Frame2::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $00, $06, $20 ; entry 2
    db $f1, $f8, $07, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set07; ends with $80 (E-0147)
MetaSprites25Set07Frame3::
    db $f0, $00, $08, $20 ; entry 0
    db $f0, $f8, $09, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set07Frame4::
    db $f9, $f8, $0e, $00 ; entry 0
    db $f9, $00, $0e, $20 ; entry 1
    db $f1, $00, $02, $20 ; entry 2
    db $f1, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set07; ends with $80 (E-0147)
MetaSprites25Set07Frame5::
    db $f8, $f8, $0f, $00 ; entry 0
    db $f8, $00, $0f, $20 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $09, $00 ; entry 3
    db $80 ; end

; meta-sprite set 8 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set08::
    dw MetaSprites25Set08Frame0 ; entry 0
    dw MetaSprites25Set08Frame1 ; entry 1
    dw MetaSprites25Set08Frame2 ; entry 2
    dw MetaSprites25Set08Frame3 ; entry 3
    dw MetaSprites25Set08Frame4 ; entry 4
    dw MetaSprites25Set08Frame5 ; entry 5

; frame 0 of MetaSprites25Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame0::
    db $f3, $f8, $00, $00 ; entry 0
    db $f3, $00, $00, $20 ; entry 1
    db $fb, $f8, $01, $00 ; entry 2
    db $fb, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set08; ends with $80 (E-0147)
MetaSprites25Set08Frame1::
    db $f4, $f8, $02, $00 ; entry 0
    db $f4, $00, $02, $20 ; entry 1
    db $fc, $f8, $03, $00 ; entry 2
    db $fc, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set08; ends with $80 (E-0147)
MetaSprites25Set08Frame2::
    db $f3, $f8, $04, $00 ; entry 0
    db $f3, $00, $05, $00 ; entry 1
    db $fb, $f8, $06, $00 ; entry 2
    db $fb, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set08; ends with $80 (E-0147)
MetaSprites25Set08Frame3::
    db $fc, $f8, $0a, $00 ; entry 0
    db $fc, $00, $0b, $00 ; entry 1
    db $f4, $f8, $08, $00 ; entry 2
    db $f4, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set08Frame4::
    db $fb, $f8, $0d, $00 ; entry 0
    db $f3, $f8, $0c, $00 ; entry 1
    db $f3, $00, $0c, $20 ; entry 2
    db $fb, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set08; ends with $80 (E-0147)
MetaSprites25Set08Frame5::
    db $f4, $f8, $0e, $00 ; entry 0
    db $f4, $00, $0e, $20 ; entry 1
    db $fc, $f8, $0f, $00 ; entry 2
    db $fc, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 9 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set09::
    dw MetaSprites25Set09Frame0 ; entry 0
    dw MetaSprites25Set09Frame1 ; entry 1
    dw MetaSprites25Set09Frame2 ; entry 2
    dw MetaSprites25Set09Frame3 ; entry 3
    dw MetaSprites25Set09Frame4 ; entry 4
    dw MetaSprites25Set09Frame5 ; entry 5

; frame 0 of MetaSprites25Set09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set09; ends with $80 (E-0147)
MetaSprites25Set09Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $ff, $02, $20 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set09; ends with $80 (E-0147)
MetaSprites25Set09Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set09; ends with $80 (E-0147)
MetaSprites25Set09Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set09Frame4::
    db $f0, $00, $0c, $00 ; entry 0
    db $f8, $00, $0d, $00 ; entry 1
    db $f0, $f9, $0c, $20 ; entry 2
    db $f8, $f9, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set09; ends with $80 (E-0147)
MetaSprites25Set09Frame5::
    db $ef, $00, $0e, $00 ; entry 0
    db $f7, $00, $0f, $00 ; entry 1
    db $ef, $f9, $0e, $20 ; entry 2
    db $f7, $f9, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 10 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set0A::
    dw MetaSprites25Set0AFrame0 ; entry 0
    dw MetaSprites25Set0AFrame1 ; entry 1
    dw MetaSprites25Set0AFrame2 ; entry 2
    dw MetaSprites25Set0AFrame3 ; entry 3
    dw MetaSprites25Set0AFrame4 ; entry 4
    dw MetaSprites25Set0AFrame5 ; entry 5

; frame 0 of MetaSprites25Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame0::
    db $f1, $fd, $00, $00 ; entry 0
    db $f9, $f8, $01, $00 ; entry 1
    db $f9, $ff, $01, $20 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites25Set0A; ends with $80 (E-0147)
MetaSprites25Set0AFrame1::
    db $ef, $fd, $00, $00 ; entry 0
    db $f7, $f8, $02, $00 ; entry 1
    db $f7, $ff, $02, $20 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites25Set0A; ends with $80 (E-0147)
MetaSprites25Set0AFrame2::
    db $f1, $fd, $00, $00 ; entry 0
    db $f9, $f8, $03, $00 ; entry 1
    db $f9, $00, $05, $00 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites25Set0A; ends with $80 (E-0147)
MetaSprites25Set0AFrame3::
    db $ef, $fd, $00, $00 ; entry 0
    db $f7, $f8, $04, $00 ; entry 1
    db $f7, $00, $06, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites25Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0AFrame4::
    db $f1, $fd, $00, $00 ; entry 0
    db $f9, $f8, $03, $00 ; entry 1
    db $f9, $ff, $03, $20 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites25Set0A; ends with $80 (E-0147)
MetaSprites25Set0AFrame5::
    db $ef, $fd, $00, $00 ; entry 0
    db $f7, $f8, $04, $00 ; entry 1
    db $f7, $ff, $04, $20 ; entry 2
    db $80 ; end

; meta-sprite set 11 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set0B::
    dw MetaSprites25Set0BFrame0 ; entry 0
    dw MetaSprites25Set0BFrame1 ; entry 1
    dw MetaSprites25Set0BFrame2 ; entry 2
    dw MetaSprites25Set0BFrame3 ; entry 3
    dw MetaSprites25Set0BFrame4 ; entry 4
    dw MetaSprites25Set0BFrame5 ; entry 5

; frame 0 of MetaSprites25Set0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set0B; ends with $80 (E-0147)
MetaSprites25Set0BFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $ff, $00, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set0B; ends with $80 (E-0147)
MetaSprites25Set0BFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $ff, $07, $00 ; entry 2
    db $f8, $f7, $0a, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set0B; ends with $80 (E-0147)
MetaSprites25Set0BFrame3::
    db $ef, $f8, $05, $00 ; entry 0
    db $ef, $00, $06, $00 ; entry 1
    db $f7, $ff, $08, $00 ; entry 2
    db $f7, $f7, $0c, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0BFrame4::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $ff, $05, $20 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set0B; ends with $80 (E-0147)
MetaSprites25Set0BFrame5::
    db $ef, $f8, $05, $00 ; entry 0
    db $ef, $ff, $05, $20 ; entry 1
    db $f7, $f8, $0b, $00 ; entry 2
    db $f7, $00, $0c, $00 ; entry 3
    db $80 ; end

; meta-sprite set 12 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set0C::
    dw MetaSprites25Set0CFrame0 ; entry 0
    dw MetaSprites25Set0CFrame1 ; entry 1
    dw MetaSprites25Set0CFrame2 ; entry 2
    dw MetaSprites25Set0CFrame3 ; entry 3
    dw MetaSprites25Set0CFrame4 ; entry 4
    dw MetaSprites25Set0CFrame5 ; entry 5

; frame 0 of MetaSprites25Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame0::
    db $ee, $f8, $00, $00 ; entry 0
    db $ee, $00, $01, $00 ; entry 1
    db $f6, $f8, $02, $00 ; entry 2
    db $f6, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set0C; ends with $80 (E-0147)
MetaSprites25Set0CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set0C; ends with $80 (E-0147)
MetaSprites25Set0CFrame2::
    db $ee, $f8, $04, $00 ; entry 0
    db $ee, $00, $05, $00 ; entry 1
    db $f6, $f8, $06, $00 ; entry 2
    db $f6, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set0C; ends with $80 (E-0147)
MetaSprites25Set0CFrame3::
    db $f0, $fb, $04, $00 ; entry 0
    db $f8, $f7, $09, $00 ; entry 1
    db $f8, $ff, $0a, $00 ; entry 2
    db $f0, $03, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set0C; ends with $80 (E-0147)
MetaSprites25Set0CFrame5::
    db $ee, $f8, $0b, $00 ; entry 0
    db $ee, $00, $0c, $00 ; entry 1
    db $f6, $f8, $0e, $00 ; entry 2
    db $f6, $ff, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 13 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set0D::
    dw MetaSprites25Set0DFrame0 ; entry 0
    dw MetaSprites25Set0DFrame1 ; entry 1
    dw MetaSprites25Set0DFrame2 ; entry 2
    dw MetaSprites25Set0DFrame3 ; entry 3
    dw MetaSprites25Set0DFrame4 ; entry 4
    dw MetaSprites25Set0DFrame5 ; entry 5

; frame 0 of MetaSprites25Set0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame0::
    db $ef, $fb, $00, $10 ; entry 0
    db $f7, $f8, $01, $10 ; entry 1
    db $f7, $00, $02, $10 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites25Set0D; ends with $80 (E-0147)
MetaSprites25Set0DFrame1::
    db $f0, $fc, $03, $10 ; entry 0
    db $f8, $f8, $04, $10 ; entry 1
    db $f8, $00, $05, $10 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites25Set0D; ends with $80 (E-0147)
MetaSprites25Set0DFrame2::
    db $f0, $fb, $00, $10 ; entry 0
    db $f8, $f8, $06, $10 ; entry 1
    db $f8, $00, $07, $10 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites25Set0D; ends with $80 (E-0147)
MetaSprites25Set0DFrame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0DFrame4::
    db $f0, $fb, $00, $10 ; entry 0
    db $f8, $f8, $0c, $10 ; entry 1
    db $f8, $00, $0d, $10 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites25Set0D; ends with $80 (E-0147)
MetaSprites25Set0DFrame5::
    db $f9, $f8, $0e, $10 ; entry 0
    db $f9, $00, $0f, $10 ; entry 1
    db $f1, $fc, $03, $10 ; entry 2
    db $80 ; end

; meta-sprite set 14 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set0E::
    dw MetaSprites25Set0EFrame0 ; entry 0
    dw MetaSprites25Set0EFrame1 ; entry 1
    dw MetaSprites25Set0EFrame2 ; entry 2
    dw MetaSprites25Set0EFrame3 ; entry 3
    dw MetaSprites25Set0EFrame4 ; entry 4
    dw MetaSprites25Set0EFrame5 ; entry 5

; frame 0 of MetaSprites25Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set0E; ends with $80 (E-0147)
MetaSprites25Set0EFrame1::
    db $ee, $f8, $04, $00 ; entry 0
    db $ee, $00, $05, $00 ; entry 1
    db $f6, $f8, $06, $00 ; entry 2
    db $f6, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set0E; ends with $80 (E-0147)
MetaSprites25Set0EFrame2::
    db $f9, $f8, $08, $00 ; entry 0
    db $f9, $00, $09, $00 ; entry 1
    db $f1, $00, $00, $20 ; entry 2
    db $f1, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set0E; ends with $80 (E-0147)
MetaSprites25Set0EFrame3::
    db $f7, $f8, $0a, $00 ; entry 0
    db $f7, $00, $0b, $00 ; entry 1
    db $ef, $00, $04, $20 ; entry 2
    db $ef, $f8, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0EFrame4::
    db $f9, $f8, $0c, $00 ; entry 0
    db $f9, $00, $0d, $00 ; entry 1
    db $f1, $00, $00, $20 ; entry 2
    db $f1, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set0E; ends with $80 (E-0147)
MetaSprites25Set0EFrame5::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0f, $00 ; entry 1
    db $f0, $00, $04, $20 ; entry 2
    db $f0, $f8, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set0F::
    dw MetaSprites25Set0FFrame0 ; entry 0
    dw MetaSprites25Set0FFrame1 ; entry 1
    dw MetaSprites25Set0FFrame2 ; entry 2
    dw MetaSprites25Set0FFrame3 ; entry 3
    dw MetaSprites25Set0FFrame4 ; entry 4
    dw MetaSprites25Set0FFrame5 ; entry 5

; frame 0 of MetaSprites25Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame0::
    db $ef, $00, $00, $20 ; entry 0
    db $f7, $00, $01, $20 ; entry 1
    db $ef, $f8, $00, $00 ; entry 2
    db $f7, $f8, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set0F; ends with $80 (E-0147)
MetaSprites25Set0FFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set0F; ends with $80 (E-0147)
MetaSprites25Set0FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set0F; ends with $80 (E-0147)
MetaSprites25Set0FFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set0FFrame4::
    db $f3, $f8, $0c, $00 ; entry 0
    db $f3, $00, $0c, $20 ; entry 1
    db $fb, $f8, $0d, $00 ; entry 2
    db $fb, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set0F; ends with $80 (E-0147)
MetaSprites25Set0FFrame5::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set10::
    dw MetaSprites25Set10Frame0 ; entry 0
    dw MetaSprites25Set10Frame1 ; entry 1
    dw MetaSprites25Set10Frame2 ; entry 2
    dw MetaSprites25Set10Frame3 ; entry 3
    dw MetaSprites25Set10Frame4 ; entry 4
    dw MetaSprites25Set10Frame5 ; entry 5

; frame 0 of MetaSprites25Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set10; ends with $80 (E-0147)
MetaSprites25Set10Frame1::
    db $f1, $f8, $01, $00 ; entry 0
    db $f1, $00, $01, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set10; ends with $80 (E-0147)
MetaSprites25Set10Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set10; ends with $80 (E-0147)
MetaSprites25Set10Frame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $08, $00 ; entry 2
    db $f1, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set10Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0e, $00 ; entry 1
    db $f0, $00, $0c, $20 ; entry 2
    db $f8, $00, $0e, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set10; ends with $80 (E-0147)
MetaSprites25Set10Frame5::
    db $f1, $f8, $0d, $00 ; entry 0
    db $f9, $f8, $0f, $00 ; entry 1
    db $f1, $00, $0d, $20 ; entry 2
    db $f9, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set11::
    dw MetaSprites25Set11Frame0 ; entry 0
    dw MetaSprites25Set11Frame1 ; entry 1
    dw MetaSprites25Set11Frame2 ; entry 2
    dw MetaSprites25Set11Frame3 ; entry 3
    dw MetaSprites25Set11Frame4 ; entry 4
    dw MetaSprites25Set11Frame5 ; entry 5

; frame 0 of MetaSprites25Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame0::
    db $f1, $fd, $00, $10 ; entry 0
    db $f9, $f8, $01, $10 ; entry 1
    db $f9, $ff, $01, $30 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites25Set11; ends with $80 (E-0147)
MetaSprites25Set11Frame1::
    db $ef, $fd, $00, $10 ; entry 0
    db $f7, $f8, $02, $10 ; entry 1
    db $f7, $ff, $02, $30 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites25Set11; ends with $80 (E-0147)
MetaSprites25Set11Frame2::
    db $f1, $fd, $00, $10 ; entry 0
    db $f9, $f8, $03, $10 ; entry 1
    db $f9, $00, $05, $10 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites25Set11; ends with $80 (E-0147)
MetaSprites25Set11Frame3::
    db $ef, $fd, $00, $10 ; entry 0
    db $f7, $f8, $04, $10 ; entry 1
    db $f7, $00, $06, $10 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites25Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set11Frame4::
    db $f1, $fd, $00, $10 ; entry 0
    db $f9, $f8, $03, $10 ; entry 1
    db $f9, $ff, $03, $30 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites25Set11; ends with $80 (E-0147)
MetaSprites25Set11Frame5::
    db $ef, $fd, $00, $10 ; entry 0
    db $f7, $f8, $04, $10 ; entry 1
    db $f7, $ff, $04, $30 ; entry 2
    db $80 ; end

; meta-sprite set 18 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set12::
    dw MetaSprites25Set12Frame0 ; entry 0
    dw MetaSprites25Set12Frame1 ; entry 1
    dw MetaSprites25Set12Frame2 ; entry 2
    dw MetaSprites25Set12Frame3 ; entry 3
    dw MetaSprites25Set12Frame4 ; entry 4
    dw MetaSprites25Set12Frame5 ; entry 5

; frame 0 of MetaSprites25Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame0::
    db $f9, $f8, $00, $10 ; entry 0
    db $f9, $00, $00, $30 ; entry 1
    db $f1, $f8, $02, $10 ; entry 2
    db $f1, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set12; ends with $80 (E-0147)
MetaSprites25Set12Frame1::
    db $f8, $f8, $01, $10 ; entry 0
    db $f8, $00, $01, $30 ; entry 1
    db $f0, $f8, $04, $10 ; entry 2
    db $f0, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set12; ends with $80 (E-0147)
MetaSprites25Set12Frame2::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $00, $06, $30 ; entry 2
    db $f1, $f8, $07, $30 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set12; ends with $80 (E-0147)
MetaSprites25Set12Frame3::
    db $f0, $00, $08, $30 ; entry 0
    db $f0, $f8, $09, $30 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set12Frame4::
    db $f9, $f8, $0e, $10 ; entry 0
    db $f9, $00, $0e, $30 ; entry 1
    db $f1, $00, $02, $30 ; entry 2
    db $f1, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set12; ends with $80 (E-0147)
MetaSprites25Set12Frame5::
    db $f8, $f8, $0f, $10 ; entry 0
    db $f8, $00, $0f, $30 ; entry 1
    db $f0, $f8, $08, $10 ; entry 2
    db $f0, $00, $09, $10 ; entry 3
    db $80 ; end

; meta-sprite set 19 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set13::
    dw MetaSprites25Set13Frame0 ; entry 0
    dw MetaSprites25Set13Frame1 ; entry 1
    dw MetaSprites25Set13Frame2 ; entry 2
    dw MetaSprites25Set13Frame3 ; entry 3
    dw MetaSprites25Set13Frame4 ; entry 4
    dw MetaSprites25Set13Frame5 ; entry 5

; frame 0 of MetaSprites25Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $00, $20 ; entry 1
    db $f7, $f8, $01, $00 ; entry 2
    db $f7, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set13; ends with $80 (E-0147)
MetaSprites25Set13Frame1::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $03, $20 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set13; ends with $80 (E-0147)
MetaSprites25Set13Frame2::
    db $ef, $f8, $06, $00 ; entry 0
    db $ef, $00, $07, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set13; ends with $80 (E-0147)
MetaSprites25Set13Frame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $06, $00 ; entry 2
    db $f1, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set13Frame4::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $00, $20 ; entry 1
    db $f7, $f8, $0c, $00 ; entry 2
    db $f7, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set13; ends with $80 (E-0147)
MetaSprites25Set13Frame5::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $03, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 20 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set14::
    dw MetaSprites25Set14Frame0 ; entry 0
    dw MetaSprites25Set14Frame1 ; entry 1
    dw MetaSprites25Set14Frame2 ; entry 2
    dw MetaSprites25Set14Frame3 ; entry 3
    dw MetaSprites25Set14Frame4 ; entry 4
    dw MetaSprites25Set14Frame5 ; entry 5

; frame 0 of MetaSprites25Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set14; ends with $80 (E-0147)
MetaSprites25Set14Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f8, $ff, $03, $20 ; entry 2
    db $f0, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set14; ends with $80 (E-0147)
MetaSprites25Set14Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set14; ends with $80 (E-0147)
MetaSprites25Set14Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set14Frame4::
    db $f0, $f9, $0c, $00 ; entry 0
    db $f8, $f9, $0d, $00 ; entry 1
    db $f8, $00, $0d, $20 ; entry 2
    db $f0, $00, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set14; ends with $80 (E-0147)
MetaSprites25Set14Frame5::
    db $f0, $f9, $0e, $00 ; entry 0
    db $f8, $f9, $0f, $00 ; entry 1
    db $f8, $00, $0f, $20 ; entry 2
    db $f0, $00, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 21 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set15::
    dw MetaSprites25Set15Frame0 ; entry 0
    dw MetaSprites25Set15Frame1 ; entry 1
    dw MetaSprites25Set15Frame2 ; entry 2
    dw MetaSprites25Set15Frame3 ; entry 3
    dw MetaSprites25Set15Frame4 ; entry 4
    dw MetaSprites25Set15Frame5 ; entry 5

; frame 0 of MetaSprites25Set15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set15; ends with $80 (E-0147)
MetaSprites25Set15Frame1::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set15; ends with $80 (E-0147)
MetaSprites25Set15Frame2::
    db $ef, $00, $07, $00 ; entry 0
    db $f7, $f8, $08, $00 ; entry 1
    db $f7, $00, $09, $00 ; entry 2
    db $ef, $f8, $0a, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set15; ends with $80 (E-0147)
MetaSprites25Set15Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set15Frame4::
    db $ef, $f8, $0b, $00 ; entry 0
    db $ef, $00, $0c, $00 ; entry 1
    db $f7, $00, $0d, $00 ; entry 2
    db $f7, $f9, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set15; ends with $80 (E-0147)
MetaSprites25Set15Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0f, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f8, $f9, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 22 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set16::
    dw MetaSprites25Set16Frame0 ; entry 0
    dw MetaSprites25Set16Frame1 ; entry 1
    dw MetaSprites25Set16Frame2 ; entry 2
    dw MetaSprites25Set16Frame3 ; entry 3
    dw MetaSprites25Set16Frame4 ; entry 4
    dw MetaSprites25Set16Frame5 ; entry 5

; frame 0 of MetaSprites25Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set16; ends with $80 (E-0147)
MetaSprites25Set16Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $ff, $02, $20 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set16; ends with $80 (E-0147)
MetaSprites25Set16Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set16; ends with $80 (E-0147)
MetaSprites25Set16Frame3::
    db $ef, $00, $05, $00 ; entry 0
    db $f7, $00, $07, $00 ; entry 1
    db $ef, $f8, $08, $00 ; entry 2
    db $f7, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set16Frame4::
    db $f0, $f9, $0a, $00 ; entry 0
    db $f8, $f9, $0b, $00 ; entry 1
    db $f0, $00, $0a, $20 ; entry 2
    db $f8, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set16; ends with $80 (E-0147)
MetaSprites25Set16Frame5::
    db $ef, $f9, $0c, $00 ; entry 0
    db $f7, $f9, $0d, $00 ; entry 1
    db $ef, $00, $0c, $20 ; entry 2
    db $f7, $00, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 23 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set17::
    dw MetaSprites25Set17Frame0 ; entry 0
    dw MetaSprites25Set17Frame1 ; entry 1
    dw MetaSprites25Set17Frame2 ; entry 2
    dw MetaSprites25Set17Frame3 ; entry 3
    dw MetaSprites25Set17Frame4 ; entry 4
    dw MetaSprites25Set17Frame5 ; entry 5

; frame 0 of MetaSprites25Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $02, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set17; ends with $80 (E-0147)
MetaSprites25Set17Frame1::
    db $f1, $f8, $01, $10 ; entry 0
    db $f1, $00, $01, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set17; ends with $80 (E-0147)
MetaSprites25Set17Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set17; ends with $80 (E-0147)
MetaSprites25Set17Frame3::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $f8, $08, $10 ; entry 2
    db $f1, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set17Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f8, $f8, $0e, $10 ; entry 1
    db $f0, $00, $0c, $30 ; entry 2
    db $f8, $00, $0e, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set17; ends with $80 (E-0147)
MetaSprites25Set17Frame5::
    db $f1, $f8, $0d, $10 ; entry 0
    db $f9, $f8, $0f, $10 ; entry 1
    db $f1, $00, $0d, $30 ; entry 2
    db $f9, $00, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 24 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set18::
    dw MetaSprites25Set18Frame0 ; entry 0
    dw MetaSprites25Set18Frame1 ; entry 1
    dw MetaSprites25Set18Frame2 ; entry 2
    dw MetaSprites25Set18Frame3 ; entry 3
    dw MetaSprites25Set18Frame4 ; entry 4
    dw MetaSprites25Set18Frame5 ; entry 5

; frame 0 of MetaSprites25Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set18; ends with $80 (E-0147)
MetaSprites25Set18Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set18; ends with $80 (E-0147)
MetaSprites25Set18Frame2::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $03, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set18; ends with $80 (E-0147)
MetaSprites25Set18Frame3::
    db $f9, $f8, $04, $00 ; entry 0
    db $f9, $00, $05, $00 ; entry 1
    db $f1, $f8, $06, $00 ; entry 2
    db $f1, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set18Frame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $08, $20 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $09, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set18; ends with $80 (E-0147)
MetaSprites25Set18Frame5::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $08, $20 ; entry 1
    db $f9, $f8, $09, $00 ; entry 2
    db $f9, $00, $09, $20 ; entry 3
    db $80 ; end

; meta-sprite set 25 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set19::
    dw MetaSprites25Set19Frame0 ; entry 0
    dw MetaSprites25Set19Frame1 ; entry 1
    dw MetaSprites25Set19Frame2 ; entry 2
    dw MetaSprites25Set19Frame3 ; entry 3
    dw MetaSprites25Set19Frame4 ; entry 4
    dw MetaSprites25Set19Frame5 ; entry 5

; frame 0 of MetaSprites25Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set19; ends with $80 (E-0147)
MetaSprites25Set19Frame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $f7, $f8, $01, $00 ; entry 1
    db $ef, $ff, $00, $20 ; entry 2
    db $f7, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set19; ends with $80 (E-0147)
MetaSprites25Set19Frame2::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $03, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set19; ends with $80 (E-0147)
MetaSprites25Set19Frame3::
    db $f7, $f8, $04, $00 ; entry 0
    db $f7, $00, $05, $00 ; entry 1
    db $ef, $f8, $02, $00 ; entry 2
    db $ef, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set19Frame4::
    db $f0, $00, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f9, $06, $20 ; entry 2
    db $f8, $f9, $07, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set19; ends with $80 (E-0147)
MetaSprites25Set19Frame5::
    db $ef, $00, $06, $00 ; entry 0
    db $f7, $00, $07, $00 ; entry 1
    db $ef, $f9, $06, $20 ; entry 2
    db $f7, $f9, $07, $20 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set1A::
    dw MetaSprites25Set1AFrame0 ; entry 0
    dw MetaSprites25Set1AFrame1 ; entry 1
    dw MetaSprites25Set1AFrame2 ; entry 2
    dw MetaSprites25Set1AFrame3 ; entry 3
    dw MetaSprites25Set1AFrame4 ; entry 4
    dw MetaSprites25Set1AFrame5 ; entry 5

; frame 0 of MetaSprites25Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame0::
    db $f2, $f8, $00, $00 ; entry 0
    db $f2, $00, $01, $00 ; entry 1
    db $fa, $f8, $02, $00 ; entry 2
    db $fa, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set1A; ends with $80 (E-0147)
MetaSprites25Set1AFrame1::
    db $f2, $f8, $04, $00 ; entry 0
    db $f2, $00, $05, $00 ; entry 1
    db $fa, $f8, $06, $00 ; entry 2
    db $fa, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set1A; ends with $80 (E-0147)
MetaSprites25Set1AFrame2::
    db $f2, $f8, $08, $00 ; entry 0
    db $f2, $00, $09, $00 ; entry 1
    db $fa, $f8, $0a, $00 ; entry 2
    db $fa, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set1A; ends with $80 (E-0147)
MetaSprites25Set1AFrame3::
    db $fa, $ff, $06, $20 ; entry 0
    db $fa, $f7, $07, $20 ; entry 1
    db $f2, $ff, $04, $20 ; entry 2
    db $f2, $f7, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1AFrame4::
    db $f2, $f8, $0c, $00 ; entry 0
    db $f2, $00, $0d, $00 ; entry 1
    db $fa, $f8, $0e, $00 ; entry 2
    db $fa, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set1A; ends with $80 (E-0147)
MetaSprites25Set1AFrame5::
    db $f2, $f8, $04, $00 ; entry 0
    db $f2, $00, $05, $00 ; entry 1
    db $fa, $f8, $06, $00 ; entry 2
    db $fa, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set1B::
    dw MetaSprites25Set1BFrame0 ; entry 0
    dw MetaSprites25Set1BFrame1 ; entry 1
    dw MetaSprites25Set1BFrame2 ; entry 2
    dw MetaSprites25Set1BFrame3 ; entry 3
    dw MetaSprites25Set1BFrame4 ; entry 4
    dw MetaSprites25Set1BFrame5 ; entry 5

; frame 0 of MetaSprites25Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set1B; ends with $80 (E-0147)
MetaSprites25Set1BFrame1::
    db $f2, $f8, $03, $00 ; entry 0
    db $f2, $00, $04, $00 ; entry 1
    db $fa, $f8, $02, $00 ; entry 2
    db $fa, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set1B; ends with $80 (E-0147)
MetaSprites25Set1BFrame2::
    db $f3, $f8, $09, $00 ; entry 0
    db $f3, $00, $0a, $00 ; entry 1
    db $fb, $f8, $0b, $00 ; entry 2
    db $fb, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set1B; ends with $80 (E-0147)
MetaSprites25Set1BFrame3::
    db $f4, $00, $0a, $00 ; entry 0
    db $f4, $f8, $0d, $00 ; entry 1
    db $fc, $f8, $0b, $00 ; entry 2
    db $fc, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set1BFrame4::
    db $f2, $f8, $05, $00 ; entry 0
    db $f2, $ff, $05, $20 ; entry 1
    db $fa, $f8, $06, $00 ; entry 2
    db $fa, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set1B; ends with $80 (E-0147)
MetaSprites25Set1BFrame5::
    db $f3, $f8, $08, $00 ; entry 0
    db $f3, $ff, $08, $20 ; entry 1
    db $fb, $ff, $06, $20 ; entry 2
    db $fb, $f7, $07, $20 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set25::
    dw MetaSprites25Set25Frame0 ; entry 0
    dw MetaSprites25Set25Frame1 ; entry 1
    dw MetaSprites25Set25Frame2 ; entry 2
    dw MetaSprites25Set25Frame3 ; entry 3
    dw MetaSprites25Set25Frame4 ; entry 4
    dw MetaSprites25Set25Frame5 ; entry 5

; frame 0 of MetaSprites25Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set25; ends with $80 (E-0147)
MetaSprites25Set25Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set25; ends with $80 (E-0147)
MetaSprites25Set25Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set25; ends with $80 (E-0147)
MetaSprites25Set25Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set25Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set25; ends with $80 (E-0147)
MetaSprites25Set25Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 38 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set26::
    dw MetaSprites25Set26Frame0 ; entry 0
    dw MetaSprites25Set26Frame1 ; entry 1
    dw MetaSprites25Set26Frame2 ; entry 2
    dw MetaSprites25Set26Frame3 ; entry 3
    dw MetaSprites25Set26Frame4 ; entry 4
    dw MetaSprites25Set26Frame5 ; entry 5

; frame 0 of MetaSprites25Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set26; ends with $80 (E-0147)
MetaSprites25Set26Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $00, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set26; ends with $80 (E-0147)
MetaSprites25Set26Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set26; ends with $80 (E-0147)
MetaSprites25Set26Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set26Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $00, $0c, $20 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set26; ends with $80 (E-0147)
MetaSprites25Set26Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f8, $f8, $0f, $00 ; entry 1
    db $f0, $00, $0e, $20 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 39 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set27::
    dw MetaSprites25Set27Frame0 ; entry 0
    dw MetaSprites25Set27Frame1 ; entry 1
    dw MetaSprites25Set27Frame2 ; entry 2
    dw MetaSprites25Set27Frame3 ; entry 3
    dw MetaSprites25Set27Frame4 ; entry 4
    dw MetaSprites25Set27Frame5 ; entry 5

; frame 0 of MetaSprites25Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame0::
    db $f0, $f9, $00, $00 ; entry 0
    db $f8, $f9, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set27; ends with $80 (E-0147)
MetaSprites25Set27Frame1::
    db $f0, $f9, $02, $00 ; entry 0
    db $f8, $f9, $03, $00 ; entry 1
    db $f0, $00, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set27; ends with $80 (E-0147)
MetaSprites25Set27Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set27; ends with $80 (E-0147)
MetaSprites25Set27Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set27Frame4::
    db $f0, $f9, $0c, $00 ; entry 0
    db $f8, $f9, $0d, $00 ; entry 1
    db $f0, $00, $0c, $20 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set27; ends with $80 (E-0147)
MetaSprites25Set27Frame5::
    db $f0, $f9, $0e, $00 ; entry 0
    db $f8, $f9, $0f, $00 ; entry 1
    db $f0, $00, $0e, $20 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 40 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set28::
    dw MetaSprites25Set28Frame0 ; entry 0
    dw MetaSprites25Set28Frame1 ; entry 1
    dw MetaSprites25Set28Frame2 ; entry 2
    dw MetaSprites25Set28Frame3 ; entry 3
    dw MetaSprites25Set28Frame4 ; entry 4
    dw MetaSprites25Set28Frame5 ; entry 5

; frame 0 of MetaSprites25Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $01, $10 ; entry 2
    db $f9, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set28; ends with $80 (E-0147)
MetaSprites25Set28Frame1::
    db $f0, $f8, $02, $10 ; entry 0
    db $f0, $00, $02, $30 ; entry 1
    db $f8, $f8, $03, $10 ; entry 2
    db $f8, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set28; ends with $80 (E-0147)
MetaSprites25Set28Frame2::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $06, $10 ; entry 2
    db $f9, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set28; ends with $80 (E-0147)
MetaSprites25Set28Frame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set28Frame4::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0c, $30 ; entry 1
    db $f9, $f8, $0d, $10 ; entry 2
    db $f9, $00, $0d, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set28; ends with $80 (E-0147)
MetaSprites25Set28Frame5::
    db $f0, $f8, $0e, $10 ; entry 0
    db $f0, $00, $0e, $30 ; entry 1
    db $f8, $f8, $0f, $10 ; entry 2
    db $f8, $00, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 41 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set29::
    dw MetaSprites25Set29Frame0 ; entry 0
    dw MetaSprites25Set29Frame1 ; entry 1
    dw MetaSprites25Set29Frame2 ; entry 2
    dw MetaSprites25Set29Frame3 ; entry 3
    dw MetaSprites25Set29Frame4 ; entry 4
    dw MetaSprites25Set29Frame5 ; entry 5

; frame 0 of MetaSprites25Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set29; ends with $80 (E-0147)
MetaSprites25Set29Frame1::
    db $f0, $00, $01, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f8, $f8, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set29; ends with $80 (E-0147)
MetaSprites25Set29Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set29; ends with $80 (E-0147)
MetaSprites25Set29Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $00, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set29Frame4::
    db $f0, $ff, $0b, $20 ; entry 0
    db $f8, $f7, $0c, $00 ; entry 1
    db $f8, $ff, $0d, $00 ; entry 2
    db $f0, $f8, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set29; ends with $80 (E-0147)
MetaSprites25Set29Frame5::
    db $f0, $ff, $0b, $20 ; entry 0
    db $f0, $f8, $0b, $00 ; entry 1
    db $f8, $f7, $0e, $00 ; entry 2
    db $f8, $ff, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 42 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set2A::
    dw MetaSprites25Set2AFrame0 ; entry 0
    dw MetaSprites25Set2AFrame1 ; entry 1
    dw MetaSprites25Set2AFrame2 ; entry 2
    dw MetaSprites25Set2AFrame3 ; entry 3
    dw MetaSprites25Set2AFrame4 ; entry 4
    dw MetaSprites25Set2AFrame5 ; entry 5

; frame 0 of MetaSprites25Set2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set2A; ends with $80 (E-0147)
MetaSprites25Set2AFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set2A; ends with $80 (E-0147)
MetaSprites25Set2AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set2A; ends with $80 (E-0147)
MetaSprites25Set2AFrame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set2A; ends with $80 (E-0147)
MetaSprites25Set2AFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 43 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set2B::
    dw MetaSprites25Set2BFrame0 ; entry 0
    dw MetaSprites25Set2BFrame1 ; entry 1
    dw MetaSprites25Set2BFrame2 ; entry 2
    dw MetaSprites25Set2BFrame3 ; entry 3
    dw MetaSprites25Set2BFrame4 ; entry 4
    dw MetaSprites25Set2BFrame5 ; entry 5

; frame 0 of MetaSprites25Set2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set2B; ends with $80 (E-0147)
MetaSprites25Set2BFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set2B; ends with $80 (E-0147)
MetaSprites25Set2BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set2B; ends with $80 (E-0147)
MetaSprites25Set2BFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set2B; ends with $80 (E-0147)
MetaSprites25Set2BFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 44 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set2C::
    dw MetaSprites25Set2CFrame0 ; entry 0
    dw MetaSprites25Set2CFrame1 ; entry 1
    dw MetaSprites25Set2CFrame2 ; entry 2
    dw MetaSprites25Set2CFrame3 ; entry 3
    dw MetaSprites25Set2CFrame4 ; entry 4
    dw MetaSprites25Set2CFrame5 ; entry 5

; frame 0 of MetaSprites25Set2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set2C; ends with $80 (E-0147)
MetaSprites25Set2CFrame1::
    db $ef, $ff, $00, $20 ; entry 0
    db $ef, $f7, $01, $20 ; entry 1
    db $f7, $ff, $02, $20 ; entry 2
    db $f7, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set2C; ends with $80 (E-0147)
MetaSprites25Set2CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set2C; ends with $80 (E-0147)
MetaSprites25Set2CFrame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set2C; ends with $80 (E-0147)
MetaSprites25Set2CFrame5::
    db $ef, $01, $0c, $20 ; entry 0
    db $ef, $f9, $0d, $20 ; entry 1
    db $f7, $01, $0e, $20 ; entry 2
    db $f7, $f9, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 45 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set2D::
    dw MetaSprites25Set2DFrame0 ; entry 0
    dw MetaSprites25Set2DFrame1 ; entry 1
    dw MetaSprites25Set2DFrame2 ; entry 2
    dw MetaSprites25Set2DFrame3 ; entry 3
    dw MetaSprites25Set2DFrame4 ; entry 4
    dw MetaSprites25Set2DFrame5 ; entry 5

; frame 0 of MetaSprites25Set2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set2D; ends with $80 (E-0147)
MetaSprites25Set2DFrame1::
    db $f8, $00, $02, $20 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f0, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set2D; ends with $80 (E-0147)
MetaSprites25Set2DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set2D; ends with $80 (E-0147)
MetaSprites25Set2DFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2DFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set2D; ends with $80 (E-0147)
MetaSprites25Set2DFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 46 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set2E::
    dw MetaSprites25Set2EFrame0 ; entry 0
    dw MetaSprites25Set2EFrame1 ; entry 1
    dw MetaSprites25Set2EFrame2 ; entry 2
    dw MetaSprites25Set2EFrame3 ; entry 3
    dw MetaSprites25Set2EFrame4 ; entry 4
    dw MetaSprites25Set2EFrame5 ; entry 5

; frame 0 of MetaSprites25Set2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set2E; ends with $80 (E-0147)
MetaSprites25Set2EFrame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set2E; ends with $80 (E-0147)
MetaSprites25Set2EFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set2E; ends with $80 (E-0147)
MetaSprites25Set2EFrame3::
    db $f1, $00, $05, $10 ; entry 0
    db $f1, $f8, $08, $10 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2EFrame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0c, $10 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set2E; ends with $80 (E-0147)
MetaSprites25Set2EFrame5::
    db $f1, $00, $0b, $30 ; entry 0
    db $f1, $f8, $0c, $30 ; entry 1
    db $f9, $00, $0d, $30 ; entry 2
    db $f9, $f8, $0e, $30 ; entry 3
    db $80 ; end

; meta-sprite set 47 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set2F::
    dw MetaSprites25Set2FFrame0 ; entry 0
    dw MetaSprites25Set2FFrame1 ; entry 1
    dw MetaSprites25Set2FFrame2 ; entry 2
    dw MetaSprites25Set2FFrame3 ; entry 3
    dw MetaSprites25Set2FFrame4 ; entry 4
    dw MetaSprites25Set2FFrame5 ; entry 5

; frame 0 of MetaSprites25Set2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set2F; ends with $80 (E-0147)
MetaSprites25Set2FFrame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set2F; ends with $80 (E-0147)
MetaSprites25Set2FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set2F; ends with $80 (E-0147)
MetaSprites25Set2FFrame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $08, $00 ; entry 2
    db $f1, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set2FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set2F; ends with $80 (E-0147)
MetaSprites25Set2FFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 48 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set30::
    dw MetaSprites25Set30Frame0 ; entry 0
    dw MetaSprites25Set30Frame1 ; entry 1
    dw MetaSprites25Set30Frame2 ; entry 2
    dw MetaSprites25Set30Frame3 ; entry 3
    dw MetaSprites25Set30Frame4 ; entry 4
    dw MetaSprites25Set30Frame5 ; entry 5

; frame 0 of MetaSprites25Set30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f8, $00, $03, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set30; ends with $80 (E-0147)
MetaSprites25Set30Frame1::
    db $f8, $00, $02, $20 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $00, $01, $20 ; entry 2
    db $f0, $f9, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set30; ends with $80 (E-0147)
MetaSprites25Set30Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set30; ends with $80 (E-0147)
MetaSprites25Set30Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set30Frame4::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0f, $00 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $ff, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set30; ends with $80 (E-0147)
MetaSprites25Set30Frame5::
    db $f8, $00, $0e, $20 ; entry 0
    db $f8, $f8, $0f, $20 ; entry 1
    db $f0, $00, $0d, $20 ; entry 2
    db $f0, $f9, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 49 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set31::
    dw MetaSprites25Set31Frame0 ; entry 0
    dw MetaSprites25Set31Frame1 ; entry 1
    dw MetaSprites25Set31Frame2 ; entry 2
    dw MetaSprites25Set31Frame3 ; entry 3
    dw MetaSprites25Set31Frame4 ; entry 4
    dw MetaSprites25Set31Frame5 ; entry 5

; frame 0 of MetaSprites25Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set31; ends with $80 (E-0147)
MetaSprites25Set31Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set31; ends with $80 (E-0147)
MetaSprites25Set31Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set31; ends with $80 (E-0147)
MetaSprites25Set31Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set31Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set31; ends with $80 (E-0147)
MetaSprites25Set31Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 50 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set32::
    dw MetaSprites25Set32Frame0 ; entry 0
    dw MetaSprites25Set32Frame1 ; entry 1
    dw MetaSprites25Set32Frame2 ; entry 2
    dw MetaSprites25Set32Frame3 ; entry 3
    dw MetaSprites25Set32Frame4 ; entry 4
    dw MetaSprites25Set32Frame5 ; entry 5

; frame 0 of MetaSprites25Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set32; ends with $80 (E-0147)
MetaSprites25Set32Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set32; ends with $80 (E-0147)
MetaSprites25Set32Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set32; ends with $80 (E-0147)
MetaSprites25Set32Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set32Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set32; ends with $80 (E-0147)
MetaSprites25Set32Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 51 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set33::
    dw MetaSprites25Set33Frame0 ; entry 0
    dw MetaSprites25Set33Frame1 ; entry 1
    dw MetaSprites25Set33Frame2 ; entry 2
    dw MetaSprites25Set33Frame3 ; entry 3
    dw MetaSprites25Set33Frame4 ; entry 4
    dw MetaSprites25Set33Frame5 ; entry 5

; frame 0 of MetaSprites25Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set33; ends with $80 (E-0147)
MetaSprites25Set33Frame1::
    db $f9, $00, $01, $30 ; entry 0
    db $f9, $f8, $02, $30 ; entry 1
    db $f1, $f8, $03, $10 ; entry 2
    db $f1, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set33; ends with $80 (E-0147)
MetaSprites25Set33Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set33; ends with $80 (E-0147)
MetaSprites25Set33Frame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set33Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0c, $30 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set33; ends with $80 (E-0147)
MetaSprites25Set33Frame5::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0c, $30 ; entry 1
    db $f9, $00, $0d, $30 ; entry 2
    db $f9, $f8, $0e, $30 ; entry 3
    db $80 ; end

; meta-sprite set 52 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set34::
    dw MetaSprites25Set34Frame0 ; entry 0
    dw MetaSprites25Set34Frame1 ; entry 1
    dw MetaSprites25Set34Frame2 ; entry 2
    dw MetaSprites25Set34Frame3 ; entry 3
    dw MetaSprites25Set34Frame4 ; entry 4
    dw MetaSprites25Set34Frame5 ; entry 5

; frame 0 of MetaSprites25Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set34; ends with $80 (E-0147)
MetaSprites25Set34Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set34; ends with $80 (E-0147)
MetaSprites25Set34Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set34; ends with $80 (E-0147)
MetaSprites25Set34Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set34Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set34; ends with $80 (E-0147)
MetaSprites25Set34Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 53 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set35::
    dw MetaSprites25Set35Frame0 ; entry 0
    dw MetaSprites25Set35Frame1 ; entry 1
    dw MetaSprites25Set35Frame2 ; entry 2
    dw MetaSprites25Set35Frame3 ; entry 3
    dw MetaSprites25Set35Frame4 ; entry 4
    dw MetaSprites25Set35Frame5 ; entry 5

; frame 0 of MetaSprites25Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set35; ends with $80 (E-0147)
MetaSprites25Set35Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $ff, $02, $20 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set35; ends with $80 (E-0147)
MetaSprites25Set35Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set35; ends with $80 (E-0147)
MetaSprites25Set35Frame3::
    db $ef, $00, $05, $00 ; entry 0
    db $f7, $00, $07, $00 ; entry 1
    db $ef, $f8, $08, $00 ; entry 2
    db $f7, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set35Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $f8, $0b, $00 ; entry 1
    db $f0, $ff, $0a, $20 ; entry 2
    db $f8, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set35; ends with $80 (E-0147)
MetaSprites25Set35Frame5::
    db $ef, $f8, $0c, $00 ; entry 0
    db $f7, $f8, $0d, $00 ; entry 1
    db $ef, $ff, $0c, $20 ; entry 2
    db $f7, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 54 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set36::
    dw MetaSprites25Set36Frame0 ; entry 0
    dw MetaSprites25Set36Frame1 ; entry 1
    dw MetaSprites25Set36Frame2 ; entry 2
    dw MetaSprites25Set36Frame3 ; entry 3
    dw MetaSprites25Set36Frame4 ; entry 4
    dw MetaSprites25Set36Frame5 ; entry 5

; frame 0 of MetaSprites25Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set36; ends with $80 (E-0147)
MetaSprites25Set36Frame1::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $03, $20 ; entry 1
    db $f7, $f8, $04, $00 ; entry 2
    db $f7, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set36; ends with $80 (E-0147)
MetaSprites25Set36Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set36; ends with $80 (E-0147)
MetaSprites25Set36Frame3::
    db $ef, $f8, $0a, $00 ; entry 0
    db $f7, $f8, $0b, $00 ; entry 1
    db $f7, $00, $0c, $00 ; entry 2
    db $ef, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set36Frame4::
    db $f0, $f8, $0d, $00 ; entry 0
    db $f0, $00, $0d, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set36; ends with $80 (E-0147)
MetaSprites25Set36Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $00, $04, $20 ; entry 2
    db $f7, $f8, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 55 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set37::
    dw MetaSprites25Set37Frame0 ; entry 0
    dw MetaSprites25Set37Frame1 ; entry 1
    dw MetaSprites25Set37Frame2 ; entry 2
    dw MetaSprites25Set37Frame3 ; entry 3
    dw MetaSprites25Set37Frame4 ; entry 4
    dw MetaSprites25Set37Frame5 ; entry 5

; frame 0 of MetaSprites25Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set37; ends with $80 (E-0147)
MetaSprites25Set37Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f0, $f7, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set37; ends with $80 (E-0147)
MetaSprites25Set37Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set37; ends with $80 (E-0147)
MetaSprites25Set37Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set37Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set37; ends with $80 (E-0147)
MetaSprites25Set37Frame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 56 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set38::
    dw MetaSprites25Set38Frame0 ; entry 0
    dw MetaSprites25Set38Frame1 ; entry 1
    dw MetaSprites25Set38Frame2 ; entry 2
    dw MetaSprites25Set38Frame3 ; entry 3
    dw MetaSprites25Set38Frame4 ; entry 4
    dw MetaSprites25Set38Frame5 ; entry 5

; frame 0 of MetaSprites25Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set38; ends with $80 (E-0147)
MetaSprites25Set38Frame1::
    db $f9, $00, $01, $20 ; entry 0
    db $f9, $f8, $02, $20 ; entry 1
    db $f1, $f8, $03, $00 ; entry 2
    db $f1, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set38; ends with $80 (E-0147)
MetaSprites25Set38Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set38; ends with $80 (E-0147)
MetaSprites25Set38Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set38Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set38; ends with $80 (E-0147)
MetaSprites25Set38Frame5::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $00, $0d, $20 ; entry 2
    db $f9, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 57 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set39::
    dw MetaSprites25Set39Frame0 ; entry 0
    dw MetaSprites25Set39Frame1 ; entry 1
    dw MetaSprites25Set39Frame2 ; entry 2
    dw MetaSprites25Set39Frame3 ; entry 3
    dw MetaSprites25Set39Frame4 ; entry 4
    dw MetaSprites25Set39Frame5 ; entry 5

; frame 0 of MetaSprites25Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set39; ends with $80 (E-0147)
MetaSprites25Set39Frame1::
    db $ef, $00, $00, $20 ; entry 0
    db $ef, $f8, $01, $20 ; entry 1
    db $f7, $00, $02, $20 ; entry 2
    db $f7, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set39; ends with $80 (E-0147)
MetaSprites25Set39Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set39; ends with $80 (E-0147)
MetaSprites25Set39Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set39Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set39; ends with $80 (E-0147)
MetaSprites25Set39Frame5::
    db $ef, $00, $0c, $20 ; entry 0
    db $ef, $f8, $0d, $20 ; entry 1
    db $f7, $00, $0e, $20 ; entry 2
    db $f7, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 58 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set3A::
    dw MetaSprites25Set3AFrame0 ; entry 0
    dw MetaSprites25Set3AFrame1 ; entry 1
    dw MetaSprites25Set3AFrame2 ; entry 2
    dw MetaSprites25Set3AFrame3 ; entry 3
    dw MetaSprites25Set3AFrame4 ; entry 4
    dw MetaSprites25Set3AFrame5 ; entry 5

; frame 0 of MetaSprites25Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set3A; ends with $80 (E-0147)
MetaSprites25Set3AFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set3A; ends with $80 (E-0147)
MetaSprites25Set3AFrame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set3A; ends with $80 (E-0147)
MetaSprites25Set3AFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3AFrame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set3A; ends with $80 (E-0147)
MetaSprites25Set3AFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 59 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set3B::
    dw MetaSprites25Set3BFrame0 ; entry 0
    dw MetaSprites25Set3BFrame1 ; entry 1
    dw MetaSprites25Set3BFrame2 ; entry 2
    dw MetaSprites25Set3BFrame3 ; entry 3
    dw MetaSprites25Set3BFrame4 ; entry 4
    dw MetaSprites25Set3BFrame5 ; entry 5

; frame 0 of MetaSprites25Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $01, $10 ; entry 2
    db $f9, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set3B; ends with $80 (E-0147)
MetaSprites25Set3BFrame1::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $00, $03, $30 ; entry 1
    db $f8, $f8, $04, $10 ; entry 2
    db $f8, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set3B; ends with $80 (E-0147)
MetaSprites25Set3BFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set3B; ends with $80 (E-0147)
MetaSprites25Set3BFrame3::
    db $f0, $f9, $06, $10 ; entry 0
    db $f0, $01, $07, $10 ; entry 1
    db $f8, $f9, $0a, $10 ; entry 2
    db $f8, $01, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3BFrame4::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0d, $10 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set3B; ends with $80 (E-0147)
MetaSprites25Set3BFrame5::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $00, $0e, $30 ; entry 2
    db $f8, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 60 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set3C::
    dw MetaSprites25Set3CFrame0 ; entry 0
    dw MetaSprites25Set3CFrame1 ; entry 1
    dw MetaSprites25Set3CFrame2 ; entry 2
    dw MetaSprites25Set3CFrame3 ; entry 3
    dw MetaSprites25Set3CFrame4 ; entry 4
    dw MetaSprites25Set3CFrame5 ; entry 5

; frame 0 of MetaSprites25Set3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set3C; ends with $80 (E-0147)
MetaSprites25Set3CFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set3C; ends with $80 (E-0147)
MetaSprites25Set3CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set3C; ends with $80 (E-0147)
MetaSprites25Set3CFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set3C; ends with $80 (E-0147)
MetaSprites25Set3CFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 61 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set3D::
    dw MetaSprites25Set3DFrame0 ; entry 0
    dw MetaSprites25Set3DFrame1 ; entry 1
    dw MetaSprites25Set3DFrame2 ; entry 2
    dw MetaSprites25Set3DFrame3 ; entry 3
    dw MetaSprites25Set3DFrame4 ; entry 4
    dw MetaSprites25Set3DFrame5 ; entry 5

; frame 0 of MetaSprites25Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set3D; ends with $80 (E-0147)
MetaSprites25Set3DFrame1::
    db $f0, $f9, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f9, $03, $00 ; entry 2
    db $f8, $01, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set3D; ends with $80 (E-0147)
MetaSprites25Set3DFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set3D; ends with $80 (E-0147)
MetaSprites25Set3DFrame3::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3DFrame4::
    db $f8, $f8, $0c, $00 ; entry 0
    db $f8, $00, $0d, $00 ; entry 1
    db $f0, $f9, $0b, $00 ; entry 2
    db $f0, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set3D; ends with $80 (E-0147)
MetaSprites25Set3DFrame5::
    db $f0, $fa, $0b, $00 ; entry 0
    db $f0, $01, $0b, $20 ; entry 1
    db $f8, $f9, $0e, $00 ; entry 2
    db $f8, $01, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 62 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set3E::
    dw MetaSprites25Set3EFrame0 ; entry 0
    dw MetaSprites25Set3EFrame1 ; entry 1
    dw MetaSprites25Set3EFrame2 ; entry 2
    dw MetaSprites25Set3EFrame3 ; entry 3
    dw MetaSprites25Set3EFrame4 ; entry 4
    dw MetaSprites25Set3EFrame5 ; entry 5

; frame 0 of MetaSprites25Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set3E; ends with $80 (E-0147)
MetaSprites25Set3EFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set3E; ends with $80 (E-0147)
MetaSprites25Set3EFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set3E; ends with $80 (E-0147)
MetaSprites25Set3EFrame3::
    db $f7, $00, $08, $00 ; entry 0
    db $ef, $f8, $09, $00 ; entry 1
    db $ef, $00, $07, $00 ; entry 2
    db $f7, $f8, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3EFrame4::
    db $f8, $f8, $0c, $00 ; entry 0
    db $f8, $00, $0d, $00 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set3E; ends with $80 (E-0147)
MetaSprites25Set3EFrame5::
    db $ef, $00, $0b, $00 ; entry 0
    db $f7, $00, $0d, $00 ; entry 1
    db $ef, $f8, $0e, $00 ; entry 2
    db $f7, $f8, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 63 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set3F::
    dw MetaSprites25Set3FFrame0 ; entry 0
    dw MetaSprites25Set3FFrame1 ; entry 1
    dw MetaSprites25Set3FFrame2 ; entry 2
    dw MetaSprites25Set3FFrame3 ; entry 3
    dw MetaSprites25Set3FFrame4 ; entry 4
    dw MetaSprites25Set3FFrame5 ; entry 5

; frame 0 of MetaSprites25Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set3F; ends with $80 (E-0147)
MetaSprites25Set3FFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $ff, $00, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set3F; ends with $80 (E-0147)
MetaSprites25Set3FFrame2::
    db $f0, $fb, $05, $00 ; entry 0
    db $f8, $f9, $06, $00 ; entry 1
    db $f8, $01, $07, $00 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites25Set3F; ends with $80 (E-0147)
MetaSprites25Set3FFrame3::
    db $ef, $fb, $05, $00 ; entry 0
    db $f7, $f9, $08, $00 ; entry 1
    db $f7, $01, $09, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites25Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set3FFrame4::
    db $f0, $00, $0a, $00 ; entry 0
    db $f0, $f9, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set3F; ends with $80 (E-0147)
MetaSprites25Set3FFrame5::
    db $ef, $00, $0a, $00 ; entry 0
    db $ef, $f9, $0a, $20 ; entry 1
    db $f7, $f8, $0d, $00 ; entry 2
    db $f7, $00, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 64 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set40::
    dw MetaSprites25Set40Frame0 ; entry 0
    dw MetaSprites25Set40Frame1 ; entry 1
    dw MetaSprites25Set40Frame2 ; entry 2
    dw MetaSprites25Set40Frame3 ; entry 3
    dw MetaSprites25Set40Frame4 ; entry 4
    dw MetaSprites25Set40Frame5 ; entry 5

; frame 0 of MetaSprites25Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set40; ends with $80 (E-0147)
MetaSprites25Set40Frame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set40; ends with $80 (E-0147)
MetaSprites25Set40Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set40; ends with $80 (E-0147)
MetaSprites25Set40Frame3::
    db $f7, $00, $08, $00 ; entry 0
    db $ef, $f8, $09, $00 ; entry 1
    db $ef, $00, $07, $00 ; entry 2
    db $f7, $f8, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set40Frame4::
    db $f8, $f8, $0c, $00 ; entry 0
    db $f8, $00, $0d, $00 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set40; ends with $80 (E-0147)
MetaSprites25Set40Frame5::
    db $ef, $00, $0b, $00 ; entry 0
    db $f7, $00, $0d, $00 ; entry 1
    db $ef, $f8, $0e, $00 ; entry 2
    db $f7, $f8, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 65 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set41::
    dw MetaSprites25Set41Frame0 ; entry 0
    dw MetaSprites25Set41Frame1 ; entry 1
    dw MetaSprites25Set41Frame2 ; entry 2
    dw MetaSprites25Set41Frame3 ; entry 3
    dw MetaSprites25Set41Frame4 ; entry 4
    dw MetaSprites25Set41Frame5 ; entry 5

; frame 0 of MetaSprites25Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set41; ends with $80 (E-0147)
MetaSprites25Set41Frame1::
    db $ef, $ff, $00, $20 ; entry 0
    db $ef, $f7, $01, $20 ; entry 1
    db $f7, $ff, $02, $20 ; entry 2
    db $f7, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set41; ends with $80 (E-0147)
MetaSprites25Set41Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set41; ends with $80 (E-0147)
MetaSprites25Set41Frame3::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set41Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set41; ends with $80 (E-0147)
MetaSprites25Set41Frame5::
    db $ef, $01, $0a, $20 ; entry 0
    db $ef, $f9, $0b, $20 ; entry 1
    db $f7, $01, $0c, $20 ; entry 2
    db $f7, $f9, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 66 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set42::
    dw MetaSprites25Set42Frame0 ; entry 0
    dw MetaSprites25Set42Frame1 ; entry 1
    dw MetaSprites25Set42Frame2 ; entry 2
    dw MetaSprites25Set42Frame3 ; entry 3
    dw MetaSprites25Set42Frame4 ; entry 4
    dw MetaSprites25Set42Frame5 ; entry 5

; frame 0 of MetaSprites25Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set42; ends with $80 (E-0147)
MetaSprites25Set42Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set42; ends with $80 (E-0147)
MetaSprites25Set42Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set42; ends with $80 (E-0147)
MetaSprites25Set42Frame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $08, $00 ; entry 2
    db $f1, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set42Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set42; ends with $80 (E-0147)
MetaSprites25Set42Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 67 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set43::
    dw MetaSprites25Set43Frame0 ; entry 0
    dw MetaSprites25Set43Frame1 ; entry 1
    dw MetaSprites25Set43Frame2 ; entry 2
    dw MetaSprites25Set43Frame3 ; entry 3
    dw MetaSprites25Set43Frame4 ; entry 4
    dw MetaSprites25Set43Frame5 ; entry 5

; frame 0 of MetaSprites25Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set43; ends with $80 (E-0147)
MetaSprites25Set43Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set43; ends with $80 (E-0147)
MetaSprites25Set43Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set43; ends with $80 (E-0147)
MetaSprites25Set43Frame3::
    db $f1, $00, $05, $10 ; entry 0
    db $f1, $f8, $08, $10 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set43Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0c, $10 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set43; ends with $80 (E-0147)
MetaSprites25Set43Frame5::
    db $f1, $00, $0b, $30 ; entry 0
    db $f1, $f8, $0c, $30 ; entry 1
    db $f9, $00, $0d, $30 ; entry 2
    db $f9, $f8, $0e, $30 ; entry 3
    db $80 ; end

; meta-sprite set 72 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set48::
    dw MetaSprites25Set48Frame0 ; entry 0
    dw MetaSprites25Set48Frame1 ; entry 1
    dw MetaSprites25Set48Frame2 ; entry 2
    dw MetaSprites25Set48Frame3 ; entry 3
    dw MetaSprites25Set48Frame4 ; entry 4
    dw MetaSprites25Set48Frame5 ; entry 5

; frame 0 of MetaSprites25Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set48; ends with $80 (E-0147)
MetaSprites25Set48Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $ef, $00, $02, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set48; ends with $80 (E-0147)
MetaSprites25Set48Frame2::
    db $ef, $01, $04, $20 ; entry 0
    db $ef, $f9, $05, $20 ; entry 1
    db $f7, $01, $06, $20 ; entry 2
    db $f7, $f9, $07, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set48; ends with $80 (E-0147)
MetaSprites25Set48Frame3::
    db $f0, $00, $08, $20 ; entry 0
    db $f0, $f8, $09, $20 ; entry 1
    db $f8, $00, $0a, $20 ; entry 2
    db $f8, $f8, $0b, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set48Frame4::
    db $f2, $f8, $0c, $00 ; entry 0
    db $f2, $00, $0c, $20 ; entry 1
    db $fa, $f8, $0d, $00 ; entry 2
    db $fa, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set48; ends with $80 (E-0147)
MetaSprites25Set48Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 73 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set49::
    dw MetaSprites25Set49Frame0 ; entry 0
    dw MetaSprites25Set49Frame1 ; entry 1
    dw MetaSprites25Set49Frame2 ; entry 2
    dw MetaSprites25Set49Frame3 ; entry 3
    dw MetaSprites25Set49Frame4 ; entry 4
    dw MetaSprites25Set49Frame5 ; entry 5

; frame 0 of MetaSprites25Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set49; ends with $80 (E-0147)
MetaSprites25Set49Frame1::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $03, $20 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set49; ends with $80 (E-0147)
MetaSprites25Set49Frame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set49; ends with $80 (E-0147)
MetaSprites25Set49Frame3::
    db $f0, $00, $0a, $00 ; entry 0
    db $f8, $f8, $0b, $00 ; entry 1
    db $f8, $00, $09, $00 ; entry 2
    db $f0, $f8, $06, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set49Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set49; ends with $80 (E-0147)
MetaSprites25Set49Frame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 74 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set4A::
    dw MetaSprites25Set4AFrame0 ; entry 0
    dw MetaSprites25Set4AFrame1 ; entry 1
    dw MetaSprites25Set4AFrame2 ; entry 2
    dw MetaSprites25Set4AFrame3 ; entry 3
    dw MetaSprites25Set4AFrame4 ; entry 4
    dw MetaSprites25Set4AFrame5 ; entry 5

; frame 0 of MetaSprites25Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set4A; ends with $80 (E-0147)
MetaSprites25Set4AFrame1::
    db $ef, $ff, $00, $30 ; entry 0
    db $ef, $f7, $01, $30 ; entry 1
    db $f7, $ff, $02, $30 ; entry 2
    db $f7, $f7, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set4A; ends with $80 (E-0147)
MetaSprites25Set4AFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set4A; ends with $80 (E-0147)
MetaSprites25Set4AFrame3::
    db $ef, $f8, $04, $10 ; entry 0
    db $ef, $00, $05, $10 ; entry 1
    db $f7, $f8, $08, $10 ; entry 2
    db $f7, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4AFrame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set4A; ends with $80 (E-0147)
MetaSprites25Set4AFrame5::
    db $ef, $ff, $0a, $30 ; entry 0
    db $ef, $f7, $0b, $30 ; entry 1
    db $f7, $ff, $0c, $30 ; entry 2
    db $f7, $f7, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 75 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set4B::
    dw MetaSprites25Set4BFrame0 ; entry 0
    dw MetaSprites25Set4BFrame1 ; entry 1
    dw MetaSprites25Set4BFrame2 ; entry 2
    dw MetaSprites25Set4BFrame3 ; entry 3
    dw MetaSprites25Set4BFrame4 ; entry 4
    dw MetaSprites25Set4BFrame5 ; entry 5

; frame 0 of MetaSprites25Set4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set4B; ends with $80 (E-0147)
MetaSprites25Set4BFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set4B; ends with $80 (E-0147)
MetaSprites25Set4BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set4B; ends with $80 (E-0147)
MetaSprites25Set4BFrame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4BFrame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set4B; ends with $80 (E-0147)
MetaSprites25Set4BFrame5::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 76 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set4C::
    dw MetaSprites25Set4CFrame0 ; entry 0
    dw MetaSprites25Set4CFrame1 ; entry 1
    dw MetaSprites25Set4CFrame2 ; entry 2
    dw MetaSprites25Set4CFrame3 ; entry 3
    dw MetaSprites25Set4CFrame4 ; entry 4
    dw MetaSprites25Set4CFrame5 ; entry 5

; frame 0 of MetaSprites25Set4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set4C; ends with $80 (E-0147)
MetaSprites25Set4CFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set4C; ends with $80 (E-0147)
MetaSprites25Set4CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set4C; ends with $80 (E-0147)
MetaSprites25Set4CFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set4C; ends with $80 (E-0147)
MetaSprites25Set4CFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 77 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set4D::
    dw MetaSprites25Set4DFrame0 ; entry 0
    dw MetaSprites25Set4DFrame1 ; entry 1
    dw MetaSprites25Set4DFrame2 ; entry 2
    dw MetaSprites25Set4DFrame3 ; entry 3
    dw MetaSprites25Set4DFrame4 ; entry 4
    dw MetaSprites25Set4DFrame5 ; entry 5

; frame 0 of MetaSprites25Set4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $01, $10 ; entry 2
    db $f9, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set4D; ends with $80 (E-0147)
MetaSprites25Set4DFrame1::
    db $ef, $f8, $02, $10 ; entry 0
    db $ef, $00, $02, $30 ; entry 1
    db $f7, $f8, $03, $10 ; entry 2
    db $f7, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set4D; ends with $80 (E-0147)
MetaSprites25Set4DFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set4D; ends with $80 (E-0147)
MetaSprites25Set4DFrame3::
    db $ee, $f7, $08, $10 ; entry 0
    db $ee, $ff, $09, $10 ; entry 1
    db $f6, $f7, $0a, $10 ; entry 2
    db $f6, $ff, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4DFrame4::
    db $f2, $f8, $0c, $10 ; entry 0
    db $f2, $00, $0c, $30 ; entry 1
    db $fa, $f8, $0d, $10 ; entry 2
    db $fa, $00, $0d, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set4D; ends with $80 (E-0147)
MetaSprites25Set4DFrame5::
    db $ef, $f8, $0e, $10 ; entry 0
    db $ef, $00, $0e, $30 ; entry 1
    db $f7, $f8, $0f, $10 ; entry 2
    db $f7, $00, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 78 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set4E::
    dw MetaSprites25Set4EFrame0 ; entry 0
    dw MetaSprites25Set4EFrame1 ; entry 1
    dw MetaSprites25Set4EFrame2 ; entry 2
    dw MetaSprites25Set4EFrame3 ; entry 3
    dw MetaSprites25Set4EFrame4 ; entry 4
    dw MetaSprites25Set4EFrame5 ; entry 5

; frame 0 of MetaSprites25Set4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set4E; ends with $80 (E-0147)
MetaSprites25Set4EFrame1::
    db $f9, $00, $02, $30 ; entry 0
    db $f9, $f8, $03, $30 ; entry 1
    db $f1, $f8, $00, $10 ; entry 2
    db $f1, $00, $01, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set4E; ends with $80 (E-0147)
MetaSprites25Set4EFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set4E; ends with $80 (E-0147)
MetaSprites25Set4EFrame3::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $f8, $06, $10 ; entry 2
    db $f1, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4EFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set4E; ends with $80 (E-0147)
MetaSprites25Set4EFrame5::
    db $f1, $00, $0c, $30 ; entry 0
    db $f1, $f8, $0d, $30 ; entry 1
    db $f9, $00, $0e, $30 ; entry 2
    db $f9, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 79 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set4F::
    dw MetaSprites25Set4FFrame0 ; entry 0
    dw MetaSprites25Set4FFrame1 ; entry 1
    dw MetaSprites25Set4FFrame2 ; entry 2
    dw MetaSprites25Set4FFrame3 ; entry 3
    dw MetaSprites25Set4FFrame4 ; entry 4
    dw MetaSprites25Set4FFrame5 ; entry 5

; frame 0 of MetaSprites25Set4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set4F; ends with $80 (E-0147)
MetaSprites25Set4FFrame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $f7, $03, $20 ; entry 2
    db $f9, $ff, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set4F; ends with $80 (E-0147)
MetaSprites25Set4FFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set4F; ends with $80 (E-0147)
MetaSprites25Set4FFrame3::
    db $f1, $f9, $05, $00 ; entry 0
    db $f1, $01, $06, $00 ; entry 1
    db $f9, $f9, $09, $00 ; entry 2
    db $f9, $01, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set4FFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set4F; ends with $80 (E-0147)
MetaSprites25Set4FFrame5::
    db $f1, $ff, $0b, $20 ; entry 0
    db $f1, $f7, $0c, $20 ; entry 1
    db $f9, $f7, $0e, $20 ; entry 2
    db $f9, $ff, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 80 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set50::
    dw MetaSprites25Set50Frame0 ; entry 0
    dw MetaSprites25Set50Frame1 ; entry 1
    dw MetaSprites25Set50Frame2 ; entry 2
    dw MetaSprites25Set50Frame3 ; entry 3
    dw MetaSprites25Set50Frame4 ; entry 4
    dw MetaSprites25Set50Frame5 ; entry 5

; frame 0 of MetaSprites25Set50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set50; ends with $80 (E-0147)
MetaSprites25Set50Frame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set50; ends with $80 (E-0147)
MetaSprites25Set50Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set50; ends with $80 (E-0147)
MetaSprites25Set50Frame3::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $08, $10 ; entry 2
    db $f9, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set50Frame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set50; ends with $80 (E-0147)
MetaSprites25Set50Frame5::
    db $f1, $f8, $0a, $10 ; entry 0
    db $f1, $00, $0b, $10 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 81 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set51::
    dw MetaSprites25Set51Frame0 ; entry 0
    dw MetaSprites25Set51Frame1 ; entry 1
    dw MetaSprites25Set51Frame2 ; entry 2
    dw MetaSprites25Set51Frame3 ; entry 3
    dw MetaSprites25Set51Frame4 ; entry 4
    dw MetaSprites25Set51Frame5 ; entry 5

; frame 0 of MetaSprites25Set51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set51; ends with $80 (E-0147)
MetaSprites25Set51Frame1::
    db $f9, $00, $02, $20 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $00, $00, $20 ; entry 2
    db $f1, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set51; ends with $80 (E-0147)
MetaSprites25Set51Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set51; ends with $80 (E-0147)
MetaSprites25Set51Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set51Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set51; ends with $80 (E-0147)
MetaSprites25Set51Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 82 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set52::
    dw MetaSprites25Set52Frame0 ; entry 0
    dw MetaSprites25Set52Frame1 ; entry 1
    dw MetaSprites25Set52Frame2 ; entry 2
    dw MetaSprites25Set52Frame3 ; entry 3
    dw MetaSprites25Set52Frame4 ; entry 4
    dw MetaSprites25Set52Frame5 ; entry 5

; frame 0 of MetaSprites25Set52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set52; ends with $80 (E-0147)
MetaSprites25Set52Frame1::
    db $f0, $00, $00, $30 ; entry 0
    db $f0, $f8, $01, $30 ; entry 1
    db $f8, $00, $02, $30 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set52; ends with $80 (E-0147)
MetaSprites25Set52Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set52; ends with $80 (E-0147)
MetaSprites25Set52Frame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set52Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f8, $f8, $0e, $10 ; entry 1
    db $f8, $00, $0f, $10 ; entry 2
    db $f0, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set52; ends with $80 (E-0147)
MetaSprites25Set52Frame5::
    db $f0, $00, $0c, $30 ; entry 0
    db $f8, $00, $0e, $30 ; entry 1
    db $f8, $f8, $0f, $30 ; entry 2
    db $f0, $f8, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 83 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set53::
    dw MetaSprites25Set53Frame0 ; entry 0
    dw MetaSprites25Set53Frame1 ; entry 1
    dw MetaSprites25Set53Frame2 ; entry 2
    dw MetaSprites25Set53Frame3 ; entry 3
    dw MetaSprites25Set53Frame4 ; entry 4
    dw MetaSprites25Set53Frame5 ; entry 5

; frame 0 of MetaSprites25Set53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set53; ends with $80 (E-0147)
MetaSprites25Set53Frame1::
    db $f9, $00, $02, $20 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $f8, $00, $00 ; entry 2
    db $f1, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set53; ends with $80 (E-0147)
MetaSprites25Set53Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set53; ends with $80 (E-0147)
MetaSprites25Set53Frame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $06, $00 ; entry 2
    db $f1, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set53Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set53; ends with $80 (E-0147)
MetaSprites25Set53Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 84 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set54::
    dw MetaSprites25Set54Frame0 ; entry 0
    dw MetaSprites25Set54Frame1 ; entry 1
    dw MetaSprites25Set54Frame2 ; entry 2
    dw MetaSprites25Set54Frame3 ; entry 3
    dw MetaSprites25Set54Frame4 ; entry 4
    dw MetaSprites25Set54Frame5 ; entry 5

; frame 0 of MetaSprites25Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set54; ends with $80 (E-0147)
MetaSprites25Set54Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set54; ends with $80 (E-0147)
MetaSprites25Set54Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set54; ends with $80 (E-0147)
MetaSprites25Set54Frame3::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set54Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $00, $0e, $00 ; entry 2
    db $f8, $f8, $0a, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set54; ends with $80 (E-0147)
MetaSprites25Set54Frame5::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $00, $0f, $00 ; entry 2
    db $f9, $f8, $08, $00 ; entry 3
    db $80 ; end

; meta-sprite set 85 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set55::
    dw MetaSprites25Set55Frame0 ; entry 0
    dw MetaSprites25Set55Frame1 ; entry 1
    dw MetaSprites25Set55Frame2 ; entry 2
    dw MetaSprites25Set55Frame3 ; entry 3
    dw MetaSprites25Set55Frame4 ; entry 4
    dw MetaSprites25Set55Frame5 ; entry 5

; frame 0 of MetaSprites25Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set55; ends with $80 (E-0147)
MetaSprites25Set55Frame1::
    db $f0, $f9, $03, $00 ; entry 0
    db $f8, $f8, $02, $20 ; entry 1
    db $f8, $00, $04, $00 ; entry 2
    db $f0, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set55; ends with $80 (E-0147)
MetaSprites25Set55Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set55; ends with $80 (E-0147)
MetaSprites25Set55Frame3::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $00, $0b, $00 ; entry 2
    db $f8, $f9, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set55Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set55; ends with $80 (E-0147)
MetaSprites25Set55Frame5::
    db $f8, $00, $0d, $20 ; entry 0
    db $f8, $f8, $0e, $20 ; entry 1
    db $f0, $f9, $0f, $00 ; entry 2
    db $f0, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 86 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set56::
    dw MetaSprites25Set56Frame0 ; entry 0
    dw MetaSprites25Set56Frame1 ; entry 1
    dw MetaSprites25Set56Frame2 ; entry 2
    dw MetaSprites25Set56Frame3 ; entry 3
    dw MetaSprites25Set56Frame4 ; entry 4
    dw MetaSprites25Set56Frame5 ; entry 5

; frame 0 of MetaSprites25Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set56; ends with $80 (E-0147)
MetaSprites25Set56Frame1::
    db $ef, $01, $00, $30 ; entry 0
    db $ef, $f9, $01, $30 ; entry 1
    db $f7, $01, $02, $30 ; entry 2
    db $f7, $f9, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set56; ends with $80 (E-0147)
MetaSprites25Set56Frame2::
    db $ef, $f8, $04, $10 ; entry 0
    db $ef, $00, $05, $10 ; entry 1
    db $f7, $f8, $06, $10 ; entry 2
    db $f7, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set56; ends with $80 (E-0147)
MetaSprites25Set56Frame3::
    db $f8, $f8, $09, $10 ; entry 0
    db $f8, $00, $0a, $10 ; entry 1
    db $f0, $f8, $08, $10 ; entry 2
    db $f0, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set56Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0c, $10 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set56; ends with $80 (E-0147)
MetaSprites25Set56Frame5::
    db $ef, $01, $0b, $30 ; entry 0
    db $ef, $f9, $0c, $30 ; entry 1
    db $f7, $01, $0d, $30 ; entry 2
    db $f7, $f9, $0e, $30 ; entry 3
    db $80 ; end

; meta-sprite set 87 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set57::
    dw MetaSprites25Set57Frame0 ; entry 0
    dw MetaSprites25Set57Frame1 ; entry 1
    dw MetaSprites25Set57Frame2 ; entry 2
    dw MetaSprites25Set57Frame3 ; entry 3
    dw MetaSprites25Set57Frame4 ; entry 4
    dw MetaSprites25Set57Frame5 ; entry 5

; frame 0 of MetaSprites25Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set57; ends with $80 (E-0147)
MetaSprites25Set57Frame1::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set57; ends with $80 (E-0147)
MetaSprites25Set57Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $02, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set57; ends with $80 (E-0147)
MetaSprites25Set57Frame3::
    db $ef, $f8, $09, $00 ; entry 0
    db $f7, $f8, $02, $00 ; entry 1
    db $ef, $00, $07, $00 ; entry 2
    db $f7, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set57Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set57; ends with $80 (E-0147)
MetaSprites25Set57Frame5::
    db $f7, $f8, $0c, $00 ; entry 0
    db $f7, $00, $0d, $00 ; entry 1
    db $ef, $f8, $0e, $00 ; entry 2
    db $ef, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 88 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set58::
    dw MetaSprites25Set58Frame0 ; entry 0
    dw MetaSprites25Set58Frame1 ; entry 1
    dw MetaSprites25Set58Frame2 ; entry 2
    dw MetaSprites25Set58Frame3 ; entry 3
    dw MetaSprites25Set58Frame4 ; entry 4
    dw MetaSprites25Set58Frame5 ; entry 5

; frame 0 of MetaSprites25Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set58; ends with $80 (E-0147)
MetaSprites25Set58Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $00, $02, $20 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set58; ends with $80 (E-0147)
MetaSprites25Set58Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set58; ends with $80 (E-0147)
MetaSprites25Set58Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set58Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f0, $00, $0b, $20 ; entry 2
    db $f8, $00, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set58; ends with $80 (E-0147)
MetaSprites25Set58Frame5::
    db $ef, $f8, $0d, $00 ; entry 0
    db $f7, $f8, $0e, $00 ; entry 1
    db $ef, $00, $0d, $20 ; entry 2
    db $f7, $00, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 89 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set59::
    dw MetaSprites25Set59Frame0 ; entry 0
    dw MetaSprites25Set59Frame1 ; entry 1
    dw MetaSprites25Set59Frame2 ; entry 2
    dw MetaSprites25Set59Frame3 ; entry 3
    dw MetaSprites25Set59Frame4 ; entry 4
    dw MetaSprites25Set59Frame5 ; entry 5

; frame 0 of MetaSprites25Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set59; ends with $80 (E-0147)
MetaSprites25Set59Frame1::
    db $f0, $f9, $00, $10 ; entry 0
    db $f0, $01, $01, $10 ; entry 1
    db $f8, $f9, $04, $10 ; entry 2
    db $f8, $01, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set59; ends with $80 (E-0147)
MetaSprites25Set59Frame2::
    db $f0, $f9, $06, $10 ; entry 0
    db $f0, $01, $07, $10 ; entry 1
    db $f8, $f9, $08, $10 ; entry 2
    db $f8, $01, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set59; ends with $80 (E-0147)
MetaSprites25Set59Frame3::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set59Frame4::
    db $f8, $f8, $0e, $10 ; entry 0
    db $f8, $00, $0f, $10 ; entry 1
    db $f0, $f8, $0c, $10 ; entry 2
    db $f0, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set59; ends with $80 (E-0147)
MetaSprites25Set59Frame5::
    db $f8, $00, $0e, $30 ; entry 0
    db $f8, $f8, $0f, $30 ; entry 1
    db $f0, $f9, $0c, $10 ; entry 2
    db $f0, $01, $0d, $10 ; entry 3
    db $80 ; end

; meta-sprite set 90 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set5A::
    dw MetaSprites25Set5AFrame0 ; entry 0
    dw MetaSprites25Set5AFrame1 ; entry 1
    dw MetaSprites25Set5AFrame2 ; entry 2
    dw MetaSprites25Set5AFrame3 ; entry 3
    dw MetaSprites25Set5AFrame4 ; entry 4
    dw MetaSprites25Set5AFrame5 ; entry 5

; frame 0 of MetaSprites25Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set5A; ends with $80 (E-0147)
MetaSprites25Set5AFrame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $04, $10 ; entry 2
    db $f9, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set5A; ends with $80 (E-0147)
MetaSprites25Set5AFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set5A; ends with $80 (E-0147)
MetaSprites25Set5AFrame3::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $f8, $06, $10 ; entry 2
    db $f1, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5AFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $00, $0e, $10 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set5A; ends with $80 (E-0147)
MetaSprites25Set5AFrame5::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0d, $10 ; entry 1
    db $f9, $00, $0f, $10 ; entry 2
    db $f9, $f8, $05, $30 ; entry 3
    db $80 ; end

; meta-sprite set 91 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set5B::
    dw MetaSprites25Set5BFrame0 ; entry 0
    dw MetaSprites25Set5BFrame1 ; entry 1
    dw MetaSprites25Set5BFrame2 ; entry 2
    dw MetaSprites25Set5BFrame3 ; entry 3
    dw MetaSprites25Set5BFrame4 ; entry 4
    dw MetaSprites25Set5BFrame5 ; entry 5

; frame 0 of MetaSprites25Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set5B; ends with $80 (E-0147)
MetaSprites25Set5BFrame1::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $03, $20 ; entry 1
    db $f7, $00, $01, $20 ; entry 2
    db $f7, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set5B; ends with $80 (E-0147)
MetaSprites25Set5BFrame2::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set5B; ends with $80 (E-0147)
MetaSprites25Set5BFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f8, $f8, $09, $00 ; entry 1
    db $f0, $00, $05, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set5B; ends with $80 (E-0147)
MetaSprites25Set5BFrame5::
    db $ef, $f8, $0d, $00 ; entry 0
    db $ef, $00, $0d, $20 ; entry 1
    db $f7, $f8, $0e, $00 ; entry 2
    db $f7, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 92 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set5C::
    dw MetaSprites25Set5CFrame0 ; entry 0
    dw MetaSprites25Set5CFrame1 ; entry 1
    dw MetaSprites25Set5CFrame2 ; entry 2
    dw MetaSprites25Set5CFrame3 ; entry 3
    dw MetaSprites25Set5CFrame4 ; entry 4
    dw MetaSprites25Set5CFrame5 ; entry 5

; frame 0 of MetaSprites25Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set5C; ends with $80 (E-0147)
MetaSprites25Set5CFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set5C; ends with $80 (E-0147)
MetaSprites25Set5CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set5C; ends with $80 (E-0147)
MetaSprites25Set5CFrame3::
    db $f0, $00, $05, $00 ; entry 0
    db $f0, $f8, $08, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set5C; ends with $80 (E-0147)
MetaSprites25Set5CFrame5::
    db $f0, $00, $0b, $20 ; entry 0
    db $f0, $f8, $0c, $20 ; entry 1
    db $f8, $00, $0d, $20 ; entry 2
    db $f8, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 93 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set5D::
    dw MetaSprites25Set5DFrame0 ; entry 0
    dw MetaSprites25Set5DFrame1 ; entry 1
    dw MetaSprites25Set5DFrame2 ; entry 2
    dw MetaSprites25Set5DFrame3 ; entry 3
    dw MetaSprites25Set5DFrame4 ; entry 4
    dw MetaSprites25Set5DFrame5 ; entry 5

; frame 0 of MetaSprites25Set5D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set5D; ends with $80 (E-0147)
MetaSprites25Set5DFrame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $00, $10 ; entry 1
    db $f9, $00, $01, $30 ; entry 2
    db $f9, $f8, $02, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set5D; ends with $80 (E-0147)
MetaSprites25Set5DFrame2::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $00, $04, $10 ; entry 1
    db $f8, $f8, $05, $10 ; entry 2
    db $f8, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set5D; ends with $80 (E-0147)
MetaSprites25Set5DFrame3::
    db $f1, $f8, $03, $10 ; entry 0
    db $f1, $00, $04, $10 ; entry 1
    db $f9, $f8, $07, $10 ; entry 2
    db $f9, $00, $08, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set5D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5DFrame4::
    db $f0, $f8, $09, $10 ; entry 0
    db $f0, $00, $09, $30 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set5D; ends with $80 (E-0147)
MetaSprites25Set5DFrame5::
    db $f1, $f8, $09, $10 ; entry 0
    db $f1, $00, $09, $30 ; entry 1
    db $f9, $00, $0a, $30 ; entry 2
    db $f9, $f8, $0b, $30 ; entry 3
    db $80 ; end

; meta-sprite set 94 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set5E::
    dw MetaSprites25Set5EFrame0 ; entry 0
    dw MetaSprites25Set5EFrame1 ; entry 1
    dw MetaSprites25Set5EFrame2 ; entry 2
    dw MetaSprites25Set5EFrame3 ; entry 3
    dw MetaSprites25Set5EFrame4 ; entry 4
    dw MetaSprites25Set5EFrame5 ; entry 5

; frame 0 of MetaSprites25Set5E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set5E; ends with $80 (E-0147)
MetaSprites25Set5EFrame1::
    db $ef, $00, $00, $30 ; entry 0
    db $ef, $f8, $01, $30 ; entry 1
    db $f7, $00, $02, $30 ; entry 2
    db $f7, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set5E; ends with $80 (E-0147)
MetaSprites25Set5EFrame2::
    db $ef, $f8, $04, $10 ; entry 0
    db $ef, $00, $05, $10 ; entry 1
    db $f7, $f8, $06, $10 ; entry 2
    db $f7, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set5E; ends with $80 (E-0147)
MetaSprites25Set5EFrame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set5E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5EFrame4::
    db $f8, $f8, $0e, $10 ; entry 0
    db $f8, $00, $0f, $10 ; entry 1
    db $f0, $f8, $0c, $10 ; entry 2
    db $f0, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set5E; ends with $80 (E-0147)
MetaSprites25Set5EFrame5::
    db $f7, $00, $0e, $30 ; entry 0
    db $f7, $f8, $0f, $30 ; entry 1
    db $ef, $00, $0c, $30 ; entry 2
    db $ef, $f8, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 95 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set5F::
    dw MetaSprites25Set5FFrame0 ; entry 0
    dw MetaSprites25Set5FFrame1 ; entry 1
    dw MetaSprites25Set5FFrame2 ; entry 2
    dw MetaSprites25Set5FFrame3 ; entry 3
    dw MetaSprites25Set5FFrame4 ; entry 4
    dw MetaSprites25Set5FFrame5 ; entry 5

; frame 0 of MetaSprites25Set5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f8, $00, $03, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set5F; ends with $80 (E-0147)
MetaSprites25Set5FFrame1::
    db $f1, $f8, $01, $00 ; entry 0
    db $f1, $00, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set5F; ends with $80 (E-0147)
MetaSprites25Set5FFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set5F; ends with $80 (E-0147)
MetaSprites25Set5FFrame3::
    db $f1, $f9, $0a, $00 ; entry 0
    db $f1, $01, $0b, $00 ; entry 1
    db $f9, $f9, $0c, $00 ; entry 2
    db $f9, $01, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set5FFrame4::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $04, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set5F; ends with $80 (E-0147)
MetaSprites25Set5FFrame5::
    db $f9, $00, $0e, $20 ; entry 0
    db $f9, $f8, $0f, $20 ; entry 1
    db $f1, $f8, $05, $00 ; entry 2
    db $f1, $00, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 96 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set60::
    dw MetaSprites25Set60Frame0 ; entry 0
    dw MetaSprites25Set60Frame1 ; entry 1
    dw MetaSprites25Set60Frame2 ; entry 2
    dw MetaSprites25Set60Frame3 ; entry 3
    dw MetaSprites25Set60Frame4 ; entry 4
    dw MetaSprites25Set60Frame5 ; entry 5

; frame 0 of MetaSprites25Set60; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set60; ends with $80 (E-0147)
MetaSprites25Set60Frame1::
    db $f1, $f8, $03, $00 ; entry 0
    db $f1, $00, $03, $20 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set60; ends with $80 (E-0147)
MetaSprites25Set60Frame2::
    db $ef, $f8, $06, $00 ; entry 0
    db $ef, $00, $07, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set60; ends with $80 (E-0147)
MetaSprites25Set60Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set60; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set60Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set60; ends with $80 (E-0147)
MetaSprites25Set60Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 97 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set61::
    dw MetaSprites25Set61Frame0 ; entry 0
    dw MetaSprites25Set61Frame1 ; entry 1
    dw MetaSprites25Set61Frame2 ; entry 2
    dw MetaSprites25Set61Frame3 ; entry 3
    dw MetaSprites25Set61Frame4 ; entry 4
    dw MetaSprites25Set61Frame5 ; entry 5

; frame 0 of MetaSprites25Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set61; ends with $80 (E-0147)
MetaSprites25Set61Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set61; ends with $80 (E-0147)
MetaSprites25Set61Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set61; ends with $80 (E-0147)
MetaSprites25Set61Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set61Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set61; ends with $80 (E-0147)
MetaSprites25Set61Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 98 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set62::
    dw MetaSprites25Set62Frame0 ; entry 0
    dw MetaSprites25Set62Frame1 ; entry 1
    dw MetaSprites25Set62Frame2 ; entry 2
    dw MetaSprites25Set62Frame3 ; entry 3
    dw MetaSprites25Set62Frame4 ; entry 4
    dw MetaSprites25Set62Frame5 ; entry 5

; frame 0 of MetaSprites25Set62; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $ff, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set62; ends with $80 (E-0147)
MetaSprites25Set62Frame1::
    db $f1, $f9, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $00, $01, $20 ; entry 2
    db $f9, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set62; ends with $80 (E-0147)
MetaSprites25Set62Frame2::
    db $f2, $f8, $07, $00 ; entry 0
    db $f2, $00, $08, $00 ; entry 1
    db $fa, $f8, $09, $00 ; entry 2
    db $fa, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set62; ends with $80 (E-0147)
MetaSprites25Set62Frame3::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $00, $08, $00 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set62; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set62Frame4::
    db $f1, $f8, $03, $00 ; entry 0
    db $f1, $00, $04, $00 ; entry 1
    db $f9, $f8, $05, $00 ; entry 2
    db $f9, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set62; ends with $80 (E-0147)
MetaSprites25Set62Frame5::
    db $f9, $00, $05, $20 ; entry 0
    db $f9, $f8, $06, $20 ; entry 1
    db $f1, $00, $03, $20 ; entry 2
    db $f1, $f8, $04, $20 ; entry 3
    db $80 ; end

; meta-sprite set 99 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set63::
    dw MetaSprites25Set63Frame0 ; entry 0
    dw MetaSprites25Set63Frame1 ; entry 1
    dw MetaSprites25Set63Frame2 ; entry 2
    dw MetaSprites25Set63Frame3 ; entry 3
    dw MetaSprites25Set63Frame4 ; entry 4
    dw MetaSprites25Set63Frame5 ; entry 5

; frame 0 of MetaSprites25Set63; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $02, $10 ; entry 2
    db $f9, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set63; ends with $80 (E-0147)
MetaSprites25Set63Frame1::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $00, $02, $30 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set63; ends with $80 (E-0147)
MetaSprites25Set63Frame2::
    db $f1, $f8, $06, $10 ; entry 0
    db $f1, $00, $07, $10 ; entry 1
    db $f9, $f8, $08, $10 ; entry 2
    db $f9, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set63; ends with $80 (E-0147)
MetaSprites25Set63Frame3::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set63; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set63Frame4::
    db $f0, $f8, $0e, $10 ; entry 0
    db $f0, $00, $0f, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set63; ends with $80 (E-0147)
MetaSprites25Set63Frame5::
    db $f1, $00, $0e, $30 ; entry 0
    db $f1, $f8, $0f, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; meta-sprite set 100 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set64::
    dw MetaSprites25Set64Frame0 ; entry 0
    dw MetaSprites25Set64Frame1 ; entry 1
    dw MetaSprites25Set64Frame2 ; entry 2
    dw MetaSprites25Set64Frame3 ; entry 3
    dw MetaSprites25Set64Frame4 ; entry 4
    dw MetaSprites25Set64Frame5 ; entry 5

; frame 0 of MetaSprites25Set64; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set64; ends with $80 (E-0147)
MetaSprites25Set64Frame1::
    db $ef, $ff, $00, $20 ; entry 0
    db $ef, $f7, $01, $20 ; entry 1
    db $f7, $ff, $02, $20 ; entry 2
    db $f7, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set64; ends with $80 (E-0147)
MetaSprites25Set64Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set64; ends with $80 (E-0147)
MetaSprites25Set64Frame3::
    db $ef, $00, $05, $00 ; entry 0
    db $ef, $f8, $08, $00 ; entry 1
    db $f7, $f8, $09, $00 ; entry 2
    db $f7, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set64; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set64Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set64; ends with $80 (E-0147)
MetaSprites25Set64Frame5::
    db $ef, $01, $0b, $20 ; entry 0
    db $ef, $f9, $0c, $20 ; entry 1
    db $f7, $01, $0d, $20 ; entry 2
    db $f7, $f9, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 101 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set65::
    dw MetaSprites25Set65Frame0 ; entry 0
    dw MetaSprites25Set65Frame1 ; entry 1
    dw MetaSprites25Set65Frame2 ; entry 2
    dw MetaSprites25Set65Frame3 ; entry 3
    dw MetaSprites25Set65Frame4 ; entry 4
    dw MetaSprites25Set65Frame5 ; entry 5

; frame 0 of MetaSprites25Set65; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set65; ends with $80 (E-0147)
MetaSprites25Set65Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f9, $f8, $03, $00 ; entry 1
    db $f9, $00, $04, $00 ; entry 2
    db $f1, $f8, $00, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set65; ends with $80 (E-0147)
MetaSprites25Set65Frame2::
    db $f0, $f9, $05, $00 ; entry 0
    db $f0, $01, $06, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set65; ends with $80 (E-0147)
MetaSprites25Set65Frame3::
    db $f9, $f9, $09, $00 ; entry 0
    db $f9, $01, $0a, $00 ; entry 1
    db $f1, $f9, $05, $00 ; entry 2
    db $f1, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set65; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set65Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set65; ends with $80 (E-0147)
MetaSprites25Set65Frame5::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $00, $0b, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 102 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set66::
    dw MetaSprites25Set66Frame0 ; entry 0
    dw MetaSprites25Set66Frame1 ; entry 1
    dw MetaSprites25Set66Frame2 ; entry 2
    dw MetaSprites25Set66Frame3 ; entry 3
    dw MetaSprites25Set66Frame4 ; entry 4
    dw MetaSprites25Set66Frame5 ; entry 5

; frame 0 of MetaSprites25Set66; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame0::
    db $f0, $f8, $00, $20 ; entry 0
    db $f0, $ff, $00, $00 ; entry 1
    db $f8, $f7, $01, $00 ; entry 2
    db $f8, $ff, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set66; ends with $80 (E-0147)
MetaSprites25Set66Frame1::
    db $f1, $f8, $00, $20 ; entry 0
    db $f1, $ff, $00, $00 ; entry 1
    db $f9, $f7, $03, $00 ; entry 2
    db $f9, $ff, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set66; ends with $80 (E-0147)
MetaSprites25Set66Frame2::
    db $f8, $f8, $07, $00 ; entry 0
    db $f8, $00, $08, $00 ; entry 1
    db $f0, $f8, $05, $00 ; entry 2
    db $f0, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set66; ends with $80 (E-0147)
MetaSprites25Set66Frame3::
    db $f9, $f8, $09, $00 ; entry 0
    db $f9, $00, $0a, $00 ; entry 1
    db $f1, $f8, $05, $00 ; entry 2
    db $f1, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set66; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set66Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set66; ends with $80 (E-0147)
MetaSprites25Set66Frame5::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $ff, $0b, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 103 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set67::
    dw MetaSprites25Set67Frame0 ; entry 0
    dw MetaSprites25Set67Frame1 ; entry 1
    dw MetaSprites25Set67Frame2 ; entry 2
    dw MetaSprites25Set67Frame3 ; entry 3
    dw MetaSprites25Set67Frame4 ; entry 4
    dw MetaSprites25Set67Frame5 ; entry 5

; frame 0 of MetaSprites25Set67; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set67; ends with $80 (E-0147)
MetaSprites25Set67Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set67; ends with $80 (E-0147)
MetaSprites25Set67Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set67; ends with $80 (E-0147)
MetaSprites25Set67Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set67; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set67Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set67; ends with $80 (E-0147)
MetaSprites25Set67Frame5::
    db $f1, $00, $0a, $20 ; entry 0
    db $f1, $f8, $0b, $20 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 107 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set6B::
    dw MetaSprites25Set6BFrame0 ; entry 0
    dw MetaSprites25Set6BFrame1 ; entry 1
    dw MetaSprites25Set6BFrame2 ; entry 2
    dw MetaSprites25Set6BFrame3 ; entry 3
    dw MetaSprites25Set6BFrame4 ; entry 4
    dw MetaSprites25Set6BFrame5 ; entry 5

; frame 0 of MetaSprites25Set6B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $fc, $01, $00 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites25Set6B; ends with $80 (E-0147)
MetaSprites25Set6BFrame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $ff, $02, $20 ; entry 1
    db $f9, $fc, $01, $00 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites25Set6B; ends with $80 (E-0147)
MetaSprites25Set6BFrame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set6B; ends with $80 (E-0147)
MetaSprites25Set6BFrame3::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $f8, $0b, $00 ; entry 1
    db $f8, $00, $0c, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set6B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6BFrame4::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $ff, $03, $20 ; entry 1
    db $f8, $fc, $04, $00 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites25Set6B; ends with $80 (E-0147)
MetaSprites25Set6BFrame5::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $ff, $05, $20 ; entry 1
    db $f9, $fc, $04, $00 ; entry 2
    db $80 ; end

; meta-sprite set 108 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set6C::
    dw MetaSprites25Set6CFrame0 ; entry 0
    dw MetaSprites25Set6CFrame1 ; entry 1
    dw MetaSprites25Set6CFrame2 ; entry 2
    dw MetaSprites25Set6CFrame3 ; entry 3
    dw MetaSprites25Set6CFrame4 ; entry 4
    dw MetaSprites25Set6CFrame5 ; entry 5

; frame 0 of MetaSprites25Set6C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set6C; ends with $80 (E-0147)
MetaSprites25Set6CFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set6C; ends with $80 (E-0147)
MetaSprites25Set6CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set6C; ends with $80 (E-0147)
MetaSprites25Set6CFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set6C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set6C; ends with $80 (E-0147)
MetaSprites25Set6CFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 109 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set6D::
    dw MetaSprites25Set6DFrame0 ; entry 0
    dw MetaSprites25Set6DFrame1 ; entry 1
    dw MetaSprites25Set6DFrame2 ; entry 2
    dw MetaSprites25Set6DFrame3 ; entry 3
    dw MetaSprites25Set6DFrame4 ; entry 4
    dw MetaSprites25Set6DFrame5 ; entry 5

; frame 0 of MetaSprites25Set6D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set6D; ends with $80 (E-0147)
MetaSprites25Set6DFrame1::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $02, $10 ; entry 2
    db $f9, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set6D; ends with $80 (E-0147)
MetaSprites25Set6DFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set6D; ends with $80 (E-0147)
MetaSprites25Set6DFrame3::
    db $f9, $f8, $08, $10 ; entry 0
    db $f9, $00, $09, $10 ; entry 1
    db $f1, $f8, $0a, $10 ; entry 2
    db $f1, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set6D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6DFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0c, $30 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set6D; ends with $80 (E-0147)
MetaSprites25Set6DFrame5::
    db $f9, $f8, $0e, $10 ; entry 0
    db $f9, $00, $0f, $10 ; entry 1
    db $f1, $f8, $0d, $10 ; entry 2
    db $f1, $00, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 110 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set6E::
    dw MetaSprites25Set6EFrame0 ; entry 0
    dw MetaSprites25Set6EFrame1 ; entry 1
    dw MetaSprites25Set6EFrame2 ; entry 2
    dw MetaSprites25Set6EFrame3 ; entry 3
    dw MetaSprites25Set6EFrame4 ; entry 4
    dw MetaSprites25Set6EFrame5 ; entry 5

; frame 0 of MetaSprites25Set6E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set6E; ends with $80 (E-0147)
MetaSprites25Set6EFrame1::
    db $ef, $f8, $00, $10 ; entry 0
    db $ef, $00, $00, $30 ; entry 1
    db $f7, $f8, $01, $10 ; entry 2
    db $f7, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set6E; ends with $80 (E-0147)
MetaSprites25Set6EFrame2::
    db $f0, $f8, $02, $10 ; entry 0
    db $f0, $00, $03, $10 ; entry 1
    db $f8, $f8, $04, $10 ; entry 2
    db $f8, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set6E; ends with $80 (E-0147)
MetaSprites25Set6EFrame3::
    db $ef, $f8, $02, $10 ; entry 0
    db $ef, $00, $03, $10 ; entry 1
    db $f7, $f8, $04, $10 ; entry 2
    db $f7, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set6E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6EFrame4::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $06, $30 ; entry 1
    db $f8, $f8, $07, $10 ; entry 2
    db $f8, $00, $07, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set6E; ends with $80 (E-0147)
MetaSprites25Set6EFrame5::
    db $ef, $f8, $06, $10 ; entry 0
    db $ef, $00, $06, $30 ; entry 1
    db $f7, $f8, $07, $10 ; entry 2
    db $f7, $00, $07, $30 ; entry 3
    db $80 ; end

; meta-sprite set 111 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set6F::
    dw MetaSprites25Set6FFrame0 ; entry 0
    dw MetaSprites25Set6FFrame1 ; entry 1
    dw MetaSprites25Set6FFrame2 ; entry 2
    dw MetaSprites25Set6FFrame3 ; entry 3
    dw MetaSprites25Set6FFrame4 ; entry 4
    dw MetaSprites25Set6FFrame5 ; entry 5

; frame 0 of MetaSprites25Set6F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set6F; ends with $80 (E-0147)
MetaSprites25Set6FFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set6F; ends with $80 (E-0147)
MetaSprites25Set6FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set6F; ends with $80 (E-0147)
MetaSprites25Set6FFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set6F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set6FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set6F; ends with $80 (E-0147)
MetaSprites25Set6FFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 112 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set70::
    dw MetaSprites25Set70Frame0 ; entry 0
    dw MetaSprites25Set70Frame1 ; entry 1
    dw MetaSprites25Set70Frame2 ; entry 2
    dw MetaSprites25Set70Frame3 ; entry 3
    dw MetaSprites25Set70Frame4 ; entry 4
    dw MetaSprites25Set70Frame5 ; entry 5

; frame 0 of MetaSprites25Set70; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set70; ends with $80 (E-0147)
MetaSprites25Set70Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $ef, $00, $02, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set70; ends with $80 (E-0147)
MetaSprites25Set70Frame2::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set70; ends with $80 (E-0147)
MetaSprites25Set70Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set70; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set70Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set70; ends with $80 (E-0147)
MetaSprites25Set70Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 113 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set71::
    dw MetaSprites25Set71Frame0 ; entry 0
    dw MetaSprites25Set71Frame1 ; entry 1
    dw MetaSprites25Set71Frame2 ; entry 2
    dw MetaSprites25Set71Frame3 ; entry 3
    dw MetaSprites25Set71Frame4 ; entry 4
    dw MetaSprites25Set71Frame5 ; entry 5

; frame 0 of MetaSprites25Set71; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set71; ends with $80 (E-0147)
MetaSprites25Set71Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $00, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set71; ends with $80 (E-0147)
MetaSprites25Set71Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set71; ends with $80 (E-0147)
MetaSprites25Set71Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set71; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set71Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set71; ends with $80 (E-0147)
MetaSprites25Set71Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 114 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set72::
    dw MetaSprites25Set72Frame0 ; entry 0
    dw MetaSprites25Set72Frame1 ; entry 1
    dw MetaSprites25Set72Frame2 ; entry 2
    dw MetaSprites25Set72Frame3 ; entry 3
    dw MetaSprites25Set72Frame4 ; entry 4
    dw MetaSprites25Set72Frame5 ; entry 5

; frame 0 of MetaSprites25Set72; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame0::
    db $ef, $f9, $00, $00 ; entry 0
    db $ef, $01, $01, $00 ; entry 1
    db $f7, $f9, $02, $00 ; entry 2
    db $f7, $01, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set72; ends with $80 (E-0147)
MetaSprites25Set72Frame1::
    db $f0, $f9, $00, $00 ; entry 0
    db $f8, $f9, $02, $00 ; entry 1
    db $f0, $01, $04, $00 ; entry 2
    db $f8, $01, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set72; ends with $80 (E-0147)
MetaSprites25Set72Frame2::
    db $ef, $f8, $06, $00 ; entry 0
    db $ef, $00, $07, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set72; ends with $80 (E-0147)
MetaSprites25Set72Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set72; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set72Frame4::
    db $ef, $f7, $01, $20 ; entry 0
    db $f7, $f7, $03, $20 ; entry 1
    db $ef, $ff, $0c, $00 ; entry 2
    db $f7, $ff, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set72; ends with $80 (E-0147)
MetaSprites25Set72Frame5::
    db $f0, $f7, $04, $20 ; entry 0
    db $f8, $f7, $05, $20 ; entry 1
    db $f0, $ff, $0e, $00 ; entry 2
    db $f8, $ff, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 115 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set73::
    dw MetaSprites25Set73Frame0 ; entry 0
    dw MetaSprites25Set73Frame1 ; entry 1
    dw MetaSprites25Set73Frame2 ; entry 2
    dw MetaSprites25Set73Frame3 ; entry 3
    dw MetaSprites25Set73Frame4 ; entry 4
    dw MetaSprites25Set73Frame5 ; entry 5

; frame 0 of MetaSprites25Set73; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set73; ends with $80 (E-0147)
MetaSprites25Set73Frame1::
    db $f1, $f8, $03, $00 ; entry 0
    db $f1, $00, $03, $20 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set73; ends with $80 (E-0147)
MetaSprites25Set73Frame2::
    db $f0, $00, $06, $20 ; entry 0
    db $f8, $00, $07, $20 ; entry 1
    db $f8, $f8, $08, $20 ; entry 2
    db $f0, $f9, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set73; ends with $80 (E-0147)
MetaSprites25Set73Frame3::
    db $f1, $00, $06, $20 ; entry 0
    db $f9, $00, $09, $20 ; entry 1
    db $f9, $f8, $0a, $20 ; entry 2
    db $f1, $f9, $0e, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set73; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set73Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set73; ends with $80 (E-0147)
MetaSprites25Set73Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $00, $0e, $20 ; entry 1
    db $f9, $f8, $0f, $00 ; entry 2
    db $f9, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 116 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set74::
    dw MetaSprites25Set74Frame0 ; entry 0
    dw MetaSprites25Set74Frame1 ; entry 1
    dw MetaSprites25Set74Frame2 ; entry 2
    dw MetaSprites25Set74Frame3 ; entry 3
    dw MetaSprites25Set74Frame4 ; entry 4
    dw MetaSprites25Set74Frame5 ; entry 5

; frame 0 of MetaSprites25Set74; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set74; ends with $80 (E-0147)
MetaSprites25Set74Frame1::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $03, $20 ; entry 1
    db $f7, $f8, $04, $00 ; entry 2
    db $f7, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set74; ends with $80 (E-0147)
MetaSprites25Set74Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set74; ends with $80 (E-0147)
MetaSprites25Set74Frame3::
    db $ef, $00, $07, $00 ; entry 0
    db $ef, $f8, $0a, $00 ; entry 1
    db $f7, $fb, $0b, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites25Set74; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set74Frame4::
    db $f8, $f8, $01, $00 ; entry 0
    db $f8, $00, $02, $00 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set74; ends with $80 (E-0147)
MetaSprites25Set74Frame5::
    db $f7, $f8, $04, $00 ; entry 0
    db $f7, $00, $05, $00 ; entry 1
    db $ef, $f8, $0d, $00 ; entry 2
    db $ef, $00, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 117 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set75::
    dw MetaSprites25Set75Frame0 ; entry 0
    dw MetaSprites25Set75Frame1 ; entry 1
    dw MetaSprites25Set75Frame2 ; entry 2
    dw MetaSprites25Set75Frame3 ; entry 3
    dw MetaSprites25Set75Frame4 ; entry 4
    dw MetaSprites25Set75Frame5 ; entry 5

; frame 0 of MetaSprites25Set75; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame0::
    db $f0, $f8, $01, $00 ; entry 0
    db $f0, $00, $02, $00 ; entry 1
    db $f8, $f8, $00, $00 ; entry 2
    db $f8, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set75; ends with $80 (E-0147)
MetaSprites25Set75Frame1::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $00, $00 ; entry 2
    db $f7, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set75; ends with $80 (E-0147)
MetaSprites25Set75Frame2::
    db $ef, $f8, $05, $00 ; entry 0
    db $ef, $00, $06, $00 ; entry 1
    db $f7, $f8, $07, $00 ; entry 2
    db $f7, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set75; ends with $80 (E-0147)
MetaSprites25Set75Frame3::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $00, $06, $00 ; entry 2
    db $f8, $f8, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set75; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set75Frame4::
    db $f8, $f8, $0b, $00 ; entry 0
    db $f8, $00, $0b, $20 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set75; ends with $80 (E-0147)
MetaSprites25Set75Frame5::
    db $f7, $f8, $0b, $00 ; entry 0
    db $f7, $00, $0b, $20 ; entry 1
    db $ef, $f8, $0e, $00 ; entry 2
    db $ef, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 118 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set76::
    dw MetaSprites25Set76Frame0 ; entry 0
    dw MetaSprites25Set76Frame1 ; entry 1
    dw MetaSprites25Set76Frame2 ; entry 2
    dw MetaSprites25Set76Frame3 ; entry 3
    dw MetaSprites25Set76Frame4 ; entry 4
    dw MetaSprites25Set76Frame5 ; entry 5

; frame 0 of MetaSprites25Set76; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set76; ends with $80 (E-0147)
MetaSprites25Set76Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set76; ends with $80 (E-0147)
MetaSprites25Set76Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set76; ends with $80 (E-0147)
MetaSprites25Set76Frame3::
    db $f1, $00, $04, $30 ; entry 0
    db $f1, $f8, $05, $30 ; entry 1
    db $f9, $f8, $08, $10 ; entry 2
    db $f9, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set76; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set76Frame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set76; ends with $80 (E-0147)
MetaSprites25Set76Frame5::
    db $f1, $00, $0a, $30 ; entry 0
    db $f1, $f8, $0b, $30 ; entry 1
    db $f9, $00, $0c, $30 ; entry 2
    db $f9, $f8, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 119 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set77::
    dw MetaSprites25Set77Frame0 ; entry 0
    dw MetaSprites25Set77Frame1 ; entry 1
    dw MetaSprites25Set77Frame2 ; entry 2
    dw MetaSprites25Set77Frame3 ; entry 3
    dw MetaSprites25Set77Frame4 ; entry 4
    dw MetaSprites25Set77Frame5 ; entry 5

; frame 0 of MetaSprites25Set77; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame0::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set77; ends with $80 (E-0147)
MetaSprites25Set77Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set77; ends with $80 (E-0147)
MetaSprites25Set77Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set77; ends with $80 (E-0147)
MetaSprites25Set77Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set77; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set77Frame4::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set77; ends with $80 (E-0147)
MetaSprites25Set77Frame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 120 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set78::
    dw MetaSprites25Set78Frame0 ; entry 0
    dw MetaSprites25Set78Frame1 ; entry 1
    dw MetaSprites25Set78Frame2 ; entry 2
    dw MetaSprites25Set78Frame3 ; entry 3
    dw MetaSprites25Set78Frame4 ; entry 4
    dw MetaSprites25Set78Frame5 ; entry 5

; frame 0 of MetaSprites25Set78; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $02, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set78; ends with $80 (E-0147)
MetaSprites25Set78Frame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set78; ends with $80 (E-0147)
MetaSprites25Set78Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set78; ends with $80 (E-0147)
MetaSprites25Set78Frame3::
    db $f1, $00, $05, $10 ; entry 0
    db $f9, $00, $07, $10 ; entry 1
    db $f1, $f8, $08, $10 ; entry 2
    db $f9, $f8, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set78; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set78Frame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0c, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set78; ends with $80 (E-0147)
MetaSprites25Set78Frame5::
    db $f1, $f8, $0a, $10 ; entry 0
    db $f1, $00, $0b, $10 ; entry 1
    db $f9, $f8, $0d, $10 ; entry 2
    db $f9, $00, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 121 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set79::
    dw MetaSprites25Set79Frame0 ; entry 0
    dw MetaSprites25Set79Frame1 ; entry 1
    dw MetaSprites25Set79Frame2 ; entry 2
    dw MetaSprites25Set79Frame3 ; entry 3
    dw MetaSprites25Set79Frame4 ; entry 4
    dw MetaSprites25Set79Frame5 ; entry 5

; frame 0 of MetaSprites25Set79; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set79; ends with $80 (E-0147)
MetaSprites25Set79Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set79; ends with $80 (E-0147)
MetaSprites25Set79Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set79; ends with $80 (E-0147)
MetaSprites25Set79Frame3::
    db $f1, $00, $05, $00 ; entry 0
    db $f9, $00, $07, $00 ; entry 1
    db $f1, $f8, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set79; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set79Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set79; ends with $80 (E-0147)
MetaSprites25Set79Frame5::
    db $f1, $00, $0a, $20 ; entry 0
    db $f1, $f8, $0b, $20 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 122 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set7A::
    dw MetaSprites25Set7AFrame0 ; entry 0
    dw MetaSprites25Set7AFrame1 ; entry 1
    dw MetaSprites25Set7AFrame2 ; entry 2
    dw MetaSprites25Set7AFrame3 ; entry 3
    dw MetaSprites25Set7AFrame4 ; entry 4
    dw MetaSprites25Set7AFrame5 ; entry 5

; frame 0 of MetaSprites25Set7A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $ff, $00, $20 ; entry 1
    db $f7, $f8, $01, $00 ; entry 2
    db $f7, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set7A; ends with $80 (E-0147)
MetaSprites25Set7AFrame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set7A; ends with $80 (E-0147)
MetaSprites25Set7AFrame2::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $05, $00 ; entry 2
    db $f7, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set7A; ends with $80 (E-0147)
MetaSprites25Set7AFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set7A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7AFrame4::
    db $ef, $00, $09, $00 ; entry 0
    db $ef, $f9, $09, $20 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set7A; ends with $80 (E-0147)
MetaSprites25Set7AFrame5::
    db $f0, $f9, $09, $20 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $01, $0a, $20 ; entry 2
    db $f8, $f9, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 123 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set7B::
    dw MetaSprites25Set7BFrame0 ; entry 0
    dw MetaSprites25Set7BFrame1 ; entry 1
    dw MetaSprites25Set7BFrame2 ; entry 2
    dw MetaSprites25Set7BFrame3 ; entry 3
    dw MetaSprites25Set7BFrame4 ; entry 4
    dw MetaSprites25Set7BFrame5 ; entry 5

; frame 0 of MetaSprites25Set7B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set7B; ends with $80 (E-0147)
MetaSprites25Set7BFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $ff, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set7B; ends with $80 (E-0147)
MetaSprites25Set7BFrame2::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set7B; ends with $80 (E-0147)
MetaSprites25Set7BFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set7B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set7B; ends with $80 (E-0147)
MetaSprites25Set7BFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $ff, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 124 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set7C::
    dw MetaSprites25Set7CFrame0 ; entry 0
    dw MetaSprites25Set7CFrame1 ; entry 1
    dw MetaSprites25Set7CFrame2 ; entry 2
    dw MetaSprites25Set7CFrame3 ; entry 3
    dw MetaSprites25Set7CFrame4 ; entry 4
    dw MetaSprites25Set7CFrame5 ; entry 5

; frame 0 of MetaSprites25Set7C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set7C; ends with $80 (E-0147)
MetaSprites25Set7CFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $ff, $02, $20 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set7C; ends with $80 (E-0147)
MetaSprites25Set7CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set7C; ends with $80 (E-0147)
MetaSprites25Set7CFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set7C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set7C; ends with $80 (E-0147)
MetaSprites25Set7CFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $ff, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 125 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set7D::
    dw MetaSprites25Set7DFrame0 ; entry 0
    dw MetaSprites25Set7DFrame1 ; entry 1
    dw MetaSprites25Set7DFrame2 ; entry 2
    dw MetaSprites25Set7DFrame3 ; entry 3
    dw MetaSprites25Set7DFrame4 ; entry 4
    dw MetaSprites25Set7DFrame5 ; entry 5

; frame 0 of MetaSprites25Set7D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $ff, $00, $20 ; entry 1
    db $f7, $f8, $01, $00 ; entry 2
    db $f7, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set7D; ends with $80 (E-0147)
MetaSprites25Set7DFrame1::
    db $f8, $ff, $01, $20 ; entry 0
    db $f8, $f7, $02, $20 ; entry 1
    db $f0, $f8, $03, $00 ; entry 2
    db $f0, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set7D; ends with $80 (E-0147)
MetaSprites25Set7DFrame2::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set7D; ends with $80 (E-0147)
MetaSprites25Set7DFrame3::
    db $f0, $00, $05, $00 ; entry 0
    db $f0, $f8, $08, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set7D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7DFrame4::
    db $ef, $f8, $0b, $00 ; entry 0
    db $ef, $ff, $0b, $20 ; entry 1
    db $f7, $f8, $0c, $00 ; entry 2
    db $f7, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set7D; ends with $80 (E-0147)
MetaSprites25Set7DFrame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0e, $00 ; entry 2
    db $f0, $ff, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 126 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set7E::
    dw MetaSprites25Set7EFrame0 ; entry 0
    dw MetaSprites25Set7EFrame1 ; entry 1
    dw MetaSprites25Set7EFrame2 ; entry 2
    dw MetaSprites25Set7EFrame3 ; entry 3
    dw MetaSprites25Set7EFrame4 ; entry 4
    dw MetaSprites25Set7EFrame5 ; entry 5

; frame 0 of MetaSprites25Set7E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set7E; ends with $80 (E-0147)
MetaSprites25Set7EFrame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $ff, $02, $20 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set7E; ends with $80 (E-0147)
MetaSprites25Set7EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set7E; ends with $80 (E-0147)
MetaSprites25Set7EFrame3::
    db $ef, $00, $05, $00 ; entry 0
    db $f7, $00, $07, $00 ; entry 1
    db $ef, $f8, $08, $00 ; entry 2
    db $f7, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set7E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7EFrame4::
    db $f0, $00, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f9, $0a, $20 ; entry 2
    db $f8, $f9, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set7E; ends with $80 (E-0147)
MetaSprites25Set7EFrame5::
    db $ef, $00, $0c, $00 ; entry 0
    db $f7, $00, $0d, $00 ; entry 1
    db $ef, $f9, $0c, $20 ; entry 2
    db $f7, $f9, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 127 of MetaSprites25Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites25Set7F::
    dw MetaSprites25Set7FFrame0 ; entry 0
    dw MetaSprites25Set7FFrame1 ; entry 1
    dw MetaSprites25Set7FFrame2 ; entry 2
    dw MetaSprites25Set7FFrame3 ; entry 3
    dw MetaSprites25Set7FFrame4 ; entry 4
    dw MetaSprites25Set7FFrame5 ; entry 5

; frame 0 of MetaSprites25Set7F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites25Set7F; ends with $80 (E-0147)
MetaSprites25Set7FFrame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $ff, $02, $20 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites25Set7F; ends with $80 (E-0147)
MetaSprites25Set7FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites25Set7F; ends with $80 (E-0147)
MetaSprites25Set7FFrame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites25Set7F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites25Set7FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $ff, $0c, $20 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites25Set7F; ends with $80 (E-0147)
MetaSprites25Set7FFrame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $f7, $f8, $0f, $00 ; entry 1
    db $ef, $ff, $0e, $20 ; entry 2
    db $f7, $ff, $0f, $20 ; entry 3
    db $80 ; end
    ds $ad8, $00
