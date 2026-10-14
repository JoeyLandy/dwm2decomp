; ROM bank $26: meta-sprite frames
; The annotated listing of this bank is build/listing/bank26.asm.

SECTION "Bank 26", ROMX[$4000], BANK[$26]
    db $26

; ORs the attribute bits from MetaSprites26Attrs[hSpriteSetIndex] (when its bit 0 is set) into
; hSpriteAttrXor, then builds the sprite from MetaSprites26Table (E-0124)
DrawMetaSpriteSet_Bank26::
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, MetaSprites26Attrs
    add hl, de
    bit 0, [hl]
    jr z, .call_draw_meta_sprite_set_bank26_wait_oam
    ld a, [hl]
    and $f0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or e
    ldh [hSpriteAttrXor], a

.call_draw_meta_sprite_set_bank26_wait_oam:
    ld de, MetaSprites26Table
    call DrawMetaSpriteSet_Bank26_WaitOamNextEntry
    ret

; DrawMetaSpriteSet_Bank26 passes DE = $MetaSprites26Table to the builder, which takes the word at
; DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 128
; words up to the attribute table at $411E (E-0147, C1)
; record: meta-sprite set
MetaSprites26Table::
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

; DrawMetaSpriteSet_Bank26 reads the byte $411E + hSpriteSetIndex; when bit 0 is set it ORs its high
; nibble into hSpriteAttrXor before drawing (E-0147, C1)
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites26Attrs::
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

; called from DrawMetaSpriteSet_Bank26: returns if hOamNextEntry is at least $27; sets
; hMetaSpriteYLo; sets hMetaSpriteYHi; branches on hSpriteWindowClipMode; returns if the byte at
; hMetaSpriteXLo is $80; branches on the byte at hMetaSpriteXLo; branches on B; ...
DrawMetaSpriteSet_Bank26_WaitOamNextEntry::
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
    call BGTileUnderPointIsSpriteHideTile_Bank26
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
    call BGTileUnderPointIsSpriteHideTile_Bank26
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
BGTileUnderPointIsSpriteHideTile_Bank26::
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

; meta-sprite set 0 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set00::
    dw MetaSprites26Set00Frame0 ; entry 0
    dw MetaSprites26Set00Frame1 ; entry 1
    dw MetaSprites26Set00Frame2 ; entry 2
    dw MetaSprites26Set00Frame3 ; entry 3
    dw MetaSprites26Set00Frame4 ; entry 4
    dw MetaSprites26Set00Frame5 ; entry 5

; frame 0 of MetaSprites26Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame0::
    db $ee, $f8, $00, $00 ; entry 0
    db $ee, $00, $01, $00 ; entry 1
    db $f6, $f8, $02, $00 ; entry 2
    db $f6, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set00; ends with $80 (E-0147)
MetaSprites26Set00Frame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set00; ends with $80 (E-0147)
MetaSprites26Set00Frame2::
    db $ee, $f8, $04, $00 ; entry 0
    db $ee, $00, $05, $00 ; entry 1
    db $f6, $f8, $06, $00 ; entry 2
    db $f6, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set00; ends with $80 (E-0147)
MetaSprites26Set00Frame3::
    db $f8, $f8, $09, $00 ; entry 0
    db $f8, $00, $0a, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame4::
    db $ee, $f8, $0b, $00 ; entry 0
    db $ee, $00, $0c, $00 ; entry 1
    db $f6, $f8, $0d, $00 ; entry 2
    db $f6, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set00; ends with $80 (E-0147)
MetaSprites26Set00Frame5::
    db $f0, $ff, $0b, $20 ; entry 0
    db $f0, $f7, $0c, $20 ; entry 1
    db $f8, $ff, $0d, $20 ; entry 2
    db $f8, $f7, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 1 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set01::
    dw MetaSprites26Set01Frame0 ; entry 0
    dw MetaSprites26Set01Frame1 ; entry 1
    dw MetaSprites26Set01Frame2 ; entry 2
    dw MetaSprites26Set01Frame3 ; entry 3
    dw MetaSprites26Set01Frame4 ; entry 4
    dw MetaSprites26Set01Frame5 ; entry 5

; frame 0 of MetaSprites26Set01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set01; ends with $80 (E-0147)
MetaSprites26Set01Frame1::
    db $ee, $f8, $02, $00 ; entry 0
    db $ee, $00, $02, $20 ; entry 1
    db $f6, $f8, $03, $00 ; entry 2
    db $f6, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set01; ends with $80 (E-0147)
MetaSprites26Set01Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set01; ends with $80 (E-0147)
MetaSprites26Set01Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f8, $f8, $09, $00 ; entry 1
    db $f0, $00, $05, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0a, $20 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set01; ends with $80 (E-0147)
MetaSprites26Set01Frame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set02::
    dw MetaSprites26Set02Frame0 ; entry 0
    dw MetaSprites26Set02Frame1 ; entry 1
    dw MetaSprites26Set02Frame2 ; entry 2
    dw MetaSprites26Set02Frame3 ; entry 3
    dw MetaSprites26Set02Frame4 ; entry 4
    dw MetaSprites26Set02Frame5 ; entry 5

; frame 0 of MetaSprites26Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set02; ends with $80 (E-0147)
MetaSprites26Set02Frame1::
    db $ef, $ff, $00, $20 ; entry 0
    db $ef, $f8, $00, $00 ; entry 1
    db $f7, $ff, $01, $20 ; entry 2
    db $f7, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set02; ends with $80 (E-0147)
MetaSprites26Set02Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set02; ends with $80 (E-0147)
MetaSprites26Set02Frame3::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $07, $00 ; entry 2
    db $f7, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set02; ends with $80 (E-0147)
MetaSprites26Set02Frame5::
    db $ef, $01, $09, $20 ; entry 0
    db $ef, $f9, $0a, $20 ; entry 1
    db $f7, $01, $0b, $20 ; entry 2
    db $f7, $f9, $0c, $20 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set03::
    dw MetaSprites26Set03Frame0 ; entry 0
    dw MetaSprites26Set03Frame1 ; entry 1
    dw MetaSprites26Set03Frame2 ; entry 2
    dw MetaSprites26Set03Frame3 ; entry 3
    dw MetaSprites26Set03Frame4 ; entry 4
    dw MetaSprites26Set03Frame5 ; entry 5

; frame 0 of MetaSprites26Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set03; ends with $80 (E-0147)
MetaSprites26Set03Frame1::
    db $ef, $00, $00, $20 ; entry 0
    db $ef, $f8, $01, $20 ; entry 1
    db $f7, $00, $02, $20 ; entry 2
    db $f7, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set03; ends with $80 (E-0147)
MetaSprites26Set03Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set03; ends with $80 (E-0147)
MetaSprites26Set03Frame3::
    db $ef, $00, $05, $00 ; entry 0
    db $f7, $f8, $09, $00 ; entry 1
    db $f7, $00, $0a, $00 ; entry 2
    db $ef, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set03; ends with $80 (E-0147)
MetaSprites26Set03Frame5::
    db $ef, $00, $0b, $20 ; entry 0
    db $ef, $f8, $0b, $00 ; entry 1
    db $f7, $00, $0c, $20 ; entry 2
    db $f7, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set04::
    dw MetaSprites26Set04Frame0 ; entry 0
    dw MetaSprites26Set04Frame1 ; entry 1
    dw MetaSprites26Set04Frame2 ; entry 2
    dw MetaSprites26Set04Frame3 ; entry 3
    dw MetaSprites26Set04Frame4 ; entry 4
    dw MetaSprites26Set04Frame5 ; entry 5

; frame 0 of MetaSprites26Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set04; ends with $80 (E-0147)
MetaSprites26Set04Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set04; ends with $80 (E-0147)
MetaSprites26Set04Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set04; ends with $80 (E-0147)
MetaSprites26Set04Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set04; ends with $80 (E-0147)
MetaSprites26Set04Frame5::
    db $f1, $00, $0a, $20 ; entry 0
    db $f1, $f8, $0b, $20 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set05::
    dw MetaSprites26Set05Frame0 ; entry 0
    dw MetaSprites26Set05Frame1 ; entry 1
    dw MetaSprites26Set05Frame2 ; entry 2
    dw MetaSprites26Set05Frame3 ; entry 3
    dw MetaSprites26Set05Frame4 ; entry 4
    dw MetaSprites26Set05Frame5 ; entry 5

; frame 0 of MetaSprites26Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set05; ends with $80 (E-0147)
MetaSprites26Set05Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set05; ends with $80 (E-0147)
MetaSprites26Set05Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set05; ends with $80 (E-0147)
MetaSprites26Set05Frame3::
    db $f1, $00, $05, $00 ; entry 0
    db $f1, $f8, $08, $00 ; entry 1
    db $f9, $f8, $09, $00 ; entry 2
    db $f9, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set05; ends with $80 (E-0147)
MetaSprites26Set05Frame5::
    db $f1, $00, $0b, $20 ; entry 0
    db $f1, $f8, $0c, $20 ; entry 1
    db $f9, $00, $0d, $20 ; entry 2
    db $f9, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 14 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set0E::
    dw MetaSprites26Set0EFrame0 ; entry 0
    dw MetaSprites26Set0EFrame1 ; entry 1
    dw MetaSprites26Set0EFrame2 ; entry 2
    dw MetaSprites26Set0EFrame3 ; entry 3
    dw MetaSprites26Set0EFrame4 ; entry 4
    dw MetaSprites26Set0EFrame5 ; entry 5

; frame 0 of MetaSprites26Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set0E; ends with $80 (E-0147)
MetaSprites26Set0EFrame1::
    db $f1, $f8, $03, $10 ; entry 0
    db $f1, $00, $04, $10 ; entry 1
    db $f9, $f8, $01, $10 ; entry 2
    db $f9, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set0E; ends with $80 (E-0147)
MetaSprites26Set0EFrame2::
    db $f8, $f8, $07, $10 ; entry 0
    db $f8, $00, $08, $10 ; entry 1
    db $f0, $f8, $09, $10 ; entry 2
    db $f0, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set0E; ends with $80 (E-0147)
MetaSprites26Set0EFrame3::
    db $f9, $f8, $07, $10 ; entry 0
    db $f9, $00, $08, $10 ; entry 1
    db $f1, $f8, $05, $10 ; entry 2
    db $f1, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0b, $30 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set0E; ends with $80 (E-0147)
MetaSprites26Set0EFrame5::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0d, $10 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set0F::
    dw MetaSprites26Set0FFrame0 ; entry 0
    dw MetaSprites26Set0FFrame1 ; entry 1
    dw MetaSprites26Set0FFrame2 ; entry 2
    dw MetaSprites26Set0FFrame3 ; entry 3
    dw MetaSprites26Set0FFrame4 ; entry 4
    dw MetaSprites26Set0FFrame5 ; entry 5

; frame 0 of MetaSprites26Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame0::
    db $f0, $00, $00, $30 ; entry 0
    db $f0, $f8, $00, $10 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set0F; ends with $80 (E-0147)
MetaSprites26Set0FFrame1::
    db $ef, $f8, $00, $10 ; entry 0
    db $ef, $00, $00, $30 ; entry 1
    db $f7, $00, $01, $30 ; entry 2
    db $f7, $f8, $02, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set0F; ends with $80 (E-0147)
MetaSprites26Set0FFrame2::
    db $ef, $f8, $03, $10 ; entry 0
    db $ef, $00, $04, $10 ; entry 1
    db $f7, $f8, $05, $10 ; entry 2
    db $f7, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set0F; ends with $80 (E-0147)
MetaSprites26Set0FFrame3::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $00, $04, $10 ; entry 1
    db $f8, $f8, $07, $10 ; entry 2
    db $f8, $00, $08, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame4::
    db $f0, $f8, $09, $10 ; entry 0
    db $f0, $00, $09, $30 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set0F; ends with $80 (E-0147)
MetaSprites26Set0FFrame5::
    db $ef, $f8, $09, $10 ; entry 0
    db $ef, $00, $09, $30 ; entry 1
    db $f7, $00, $0a, $30 ; entry 2
    db $f7, $f8, $0b, $30 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set10::
    dw MetaSprites26Set10Frame0 ; entry 0
    dw MetaSprites26Set10Frame1 ; entry 1
    dw MetaSprites26Set10Frame2 ; entry 2
    dw MetaSprites26Set10Frame3 ; entry 3
    dw MetaSprites26Set10Frame4 ; entry 4
    dw MetaSprites26Set10Frame5 ; entry 5

; frame 0 of MetaSprites26Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set10; ends with $80 (E-0147)
MetaSprites26Set10Frame1::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $02, $10 ; entry 2
    db $f9, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set10; ends with $80 (E-0147)
MetaSprites26Set10Frame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $09, $10 ; entry 2
    db $f8, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set10; ends with $80 (E-0147)
MetaSprites26Set10Frame3::
    db $f9, $f8, $09, $10 ; entry 0
    db $f9, $00, $0a, $10 ; entry 1
    db $f1, $00, $07, $10 ; entry 2
    db $f1, $f8, $08, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0c, $10 ; entry 1
    db $f8, $00, $02, $30 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set10; ends with $80 (E-0147)
MetaSprites26Set10Frame5::
    db $f9, $00, $02, $30 ; entry 0
    db $f9, $f8, $03, $30 ; entry 1
    db $f1, $f8, $0d, $10 ; entry 2
    db $f1, $00, $0e, $10 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set11::
    dw MetaSprites26Set11Frame0 ; entry 0
    dw MetaSprites26Set11Frame1 ; entry 1
    dw MetaSprites26Set11Frame2 ; entry 2
    dw MetaSprites26Set11Frame3 ; entry 3
    dw MetaSprites26Set11Frame4 ; entry 4
    dw MetaSprites26Set11Frame5 ; entry 5

; frame 0 of MetaSprites26Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set11; ends with $80 (E-0147)
MetaSprites26Set11Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set11; ends with $80 (E-0147)
MetaSprites26Set11Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set11; ends with $80 (E-0147)
MetaSprites26Set11Frame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set11; ends with $80 (E-0147)
MetaSprites26Set11Frame5::
    db $f1, $00, $0c, $30 ; entry 0
    db $f1, $f8, $0d, $30 ; entry 1
    db $f9, $00, $0e, $30 ; entry 2
    db $f9, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 18 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set12::
    dw MetaSprites26Set12Frame0 ; entry 0
    dw MetaSprites26Set12Frame1 ; entry 1
    dw MetaSprites26Set12Frame2 ; entry 2
    dw MetaSprites26Set12Frame3 ; entry 3
    dw MetaSprites26Set12Frame4 ; entry 4
    dw MetaSprites26Set12Frame5 ; entry 5

; frame 0 of MetaSprites26Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $04, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set12; ends with $80 (E-0147)
MetaSprites26Set12Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $03, $00 ; entry 1
    db $f9, $f8, $05, $00 ; entry 2
    db $f9, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set12; ends with $80 (E-0147)
MetaSprites26Set12Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set12; ends with $80 (E-0147)
MetaSprites26Set12Frame3::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $03, $00 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame4::
    db $f0, $00, $0d, $20 ; entry 0
    db $f0, $f8, $0e, $20 ; entry 1
    db $f8, $00, $0f, $20 ; entry 2
    db $f8, $f8, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set12; ends with $80 (E-0147)
MetaSprites26Set12Frame5::
    db $f1, $00, $0d, $20 ; entry 0
    db $f1, $f8, $0e, $20 ; entry 1
    db $f9, $00, $0f, $20 ; entry 2
    db $f9, $f8, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 19 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set13::
    dw MetaSprites26Set13Frame0 ; entry 0
    dw MetaSprites26Set13Frame1 ; entry 1
    dw MetaSprites26Set13Frame2 ; entry 2
    dw MetaSprites26Set13Frame3 ; entry 3
    dw MetaSprites26Set13Frame4 ; entry 4
    dw MetaSprites26Set13Frame5 ; entry 5

; frame 0 of MetaSprites26Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $ff, $00, $30 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set13; ends with $80 (E-0147)
MetaSprites26Set13Frame1::
    db $f0, $ff, $00, $30 ; entry 0
    db $f0, $f8, $00, $10 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set13; ends with $80 (E-0147)
MetaSprites26Set13Frame2::
    db $f1, $f8, $06, $10 ; entry 0
    db $f1, $00, $07, $10 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set13; ends with $80 (E-0147)
MetaSprites26Set13Frame3::
    db $f1, $f8, $06, $10 ; entry 0
    db $f1, $00, $07, $10 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame4::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $ff, $03, $30 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set13; ends with $80 (E-0147)
MetaSprites26Set13Frame5::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $ff, $03, $30 ; entry 1
    db $f8, $ff, $04, $20 ; entry 2
    db $f8, $f7, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 20 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set14::
    dw MetaSprites26Set14Frame0 ; entry 0
    dw MetaSprites26Set14Frame1 ; entry 1
    dw MetaSprites26Set14Frame2 ; entry 2
    dw MetaSprites26Set14Frame3 ; entry 3
    dw MetaSprites26Set14Frame4 ; entry 4
    dw MetaSprites26Set14Frame5 ; entry 5

; frame 0 of MetaSprites26Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set14; ends with $80 (E-0147)
MetaSprites26Set14Frame1::
    db $f9, $00, $02, $30 ; entry 0
    db $f9, $f8, $03, $30 ; entry 1
    db $f1, $00, $00, $30 ; entry 2
    db $f1, $f8, $01, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set14; ends with $80 (E-0147)
MetaSprites26Set14Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set14; ends with $80 (E-0147)
MetaSprites26Set14Frame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set14; ends with $80 (E-0147)
MetaSprites26Set14Frame5::
    db $f1, $00, $0c, $30 ; entry 0
    db $f1, $f8, $0d, $30 ; entry 1
    db $f9, $00, $0e, $30 ; entry 2
    db $f9, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 21 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set15::
    dw MetaSprites26Set15Frame0 ; entry 0
    dw MetaSprites26Set15Frame1 ; entry 1
    dw MetaSprites26Set15Frame2 ; entry 2
    dw MetaSprites26Set15Frame3 ; entry 3
    dw MetaSprites26Set15Frame4 ; entry 4
    dw MetaSprites26Set15Frame5 ; entry 5

; frame 0 of MetaSprites26Set15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set15; ends with $80 (E-0147)
MetaSprites26Set15Frame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set15; ends with $80 (E-0147)
MetaSprites26Set15Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set15; ends with $80 (E-0147)
MetaSprites26Set15Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set15; ends with $80 (E-0147)
MetaSprites26Set15Frame5::
    db $ef, $ff, $0c, $20 ; entry 0
    db $ef, $f7, $0d, $20 ; entry 1
    db $f7, $ff, $0e, $20 ; entry 2
    db $f7, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 22 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set16::
    dw MetaSprites26Set16Frame0 ; entry 0
    dw MetaSprites26Set16Frame1 ; entry 1
    dw MetaSprites26Set16Frame2 ; entry 2
    dw MetaSprites26Set16Frame3 ; entry 3
    dw MetaSprites26Set16Frame4 ; entry 4
    dw MetaSprites26Set16Frame5 ; entry 5

; frame 0 of MetaSprites26Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set16; ends with $80 (E-0147)
MetaSprites26Set16Frame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $04, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set16; ends with $80 (E-0147)
MetaSprites26Set16Frame2::
    db $f0, $f8, $05, $10 ; entry 0
    db $f0, $00, $06, $10 ; entry 1
    db $f8, $f8, $07, $10 ; entry 2
    db $f8, $00, $08, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set16; ends with $80 (E-0147)
MetaSprites26Set16Frame3::
    db $f1, $f8, $05, $10 ; entry 0
    db $f1, $00, $06, $10 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0b, $30 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set16; ends with $80 (E-0147)
MetaSprites26Set16Frame5::
    db $f1, $f8, $0b, $10 ; entry 0
    db $f1, $00, $0b, $30 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 23 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set17::
    dw MetaSprites26Set17Frame0 ; entry 0
    dw MetaSprites26Set17Frame1 ; entry 1
    dw MetaSprites26Set17Frame2 ; entry 2
    dw MetaSprites26Set17Frame3 ; entry 3
    dw MetaSprites26Set17Frame4 ; entry 4
    dw MetaSprites26Set17Frame5 ; entry 5

; frame 0 of MetaSprites26Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set17; ends with $80 (E-0147)
MetaSprites26Set17Frame1::
    db $f9, $00, $02, $30 ; entry 0
    db $f9, $f8, $03, $30 ; entry 1
    db $f1, $00, $00, $30 ; entry 2
    db $f1, $f8, $01, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set17; ends with $80 (E-0147)
MetaSprites26Set17Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set17; ends with $80 (E-0147)
MetaSprites26Set17Frame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set17; ends with $80 (E-0147)
MetaSprites26Set17Frame5::
    db $f1, $00, $0c, $30 ; entry 0
    db $f1, $f8, $0d, $30 ; entry 1
    db $f9, $00, $0e, $30 ; entry 2
    db $f9, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 24 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set18::
    dw MetaSprites26Set18Frame0 ; entry 0
    dw MetaSprites26Set18Frame1 ; entry 1
    dw MetaSprites26Set18Frame2 ; entry 2
    dw MetaSprites26Set18Frame3 ; entry 3
    dw MetaSprites26Set18Frame4 ; entry 4
    dw MetaSprites26Set18Frame5 ; entry 5

; frame 0 of MetaSprites26Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set18; ends with $80 (E-0147)
MetaSprites26Set18Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set18; ends with $80 (E-0147)
MetaSprites26Set18Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set18; ends with $80 (E-0147)
MetaSprites26Set18Frame3::
    db $f1, $00, $05, $10 ; entry 0
    db $f1, $f8, $08, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set18; ends with $80 (E-0147)
MetaSprites26Set18Frame5::
    db $f1, $00, $0c, $30 ; entry 0
    db $f1, $f8, $0d, $30 ; entry 1
    db $f9, $00, $0e, $30 ; entry 2
    db $f9, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 25 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set19::
    dw MetaSprites26Set19Frame0 ; entry 0
    dw MetaSprites26Set19Frame1 ; entry 1
    dw MetaSprites26Set19Frame2 ; entry 2
    dw MetaSprites26Set19Frame3 ; entry 3
    dw MetaSprites26Set19Frame4 ; entry 4
    dw MetaSprites26Set19Frame5 ; entry 5

; frame 0 of MetaSprites26Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f8, $f8, $01, $10 ; entry 1
    db $f8, $00, $02, $10 ; entry 2
    db $f0, $00, $00, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set19; ends with $80 (E-0147)
MetaSprites26Set19Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f9, $00, $01, $30 ; entry 1
    db $f9, $f8, $02, $30 ; entry 2
    db $f1, $f8, $00, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set19; ends with $80 (E-0147)
MetaSprites26Set19Frame2::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $00, $04, $10 ; entry 1
    db $f8, $f8, $05, $10 ; entry 2
    db $f8, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set19; ends with $80 (E-0147)
MetaSprites26Set19Frame3::
    db $f1, $f8, $03, $10 ; entry 0
    db $f1, $00, $04, $10 ; entry 1
    db $f9, $f8, $07, $10 ; entry 2
    db $f9, $00, $08, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame4::
    db $f1, $f8, $09, $10 ; entry 0
    db $f1, $00, $09, $30 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set19; ends with $80 (E-0147)
MetaSprites26Set19Frame5::
    db $f0, $f8, $09, $10 ; entry 0
    db $f0, $00, $09, $30 ; entry 1
    db $f8, $00, $0a, $30 ; entry 2
    db $f8, $f8, $0b, $30 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set1A::
    dw MetaSprites26Set1AFrame0 ; entry 0
    dw MetaSprites26Set1AFrame1 ; entry 1
    dw MetaSprites26Set1AFrame2 ; entry 2
    dw MetaSprites26Set1AFrame3 ; entry 3
    dw MetaSprites26Set1AFrame4 ; entry 4
    dw MetaSprites26Set1AFrame5 ; entry 5

; frame 0 of MetaSprites26Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set1A; ends with $80 (E-0147)
MetaSprites26Set1AFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set1A; ends with $80 (E-0147)
MetaSprites26Set1AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set1A; ends with $80 (E-0147)
MetaSprites26Set1AFrame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set1A; ends with $80 (E-0147)
MetaSprites26Set1AFrame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set1B::
    dw MetaSprites26Set1BFrame0 ; entry 0
    dw MetaSprites26Set1BFrame1 ; entry 1
    dw MetaSprites26Set1BFrame2 ; entry 2
    dw MetaSprites26Set1BFrame3 ; entry 3
    dw MetaSprites26Set1BFrame4 ; entry 4
    dw MetaSprites26Set1BFrame5 ; entry 5

; frame 0 of MetaSprites26Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set1B; ends with $80 (E-0147)
MetaSprites26Set1BFrame1::
    db $ef, $f8, $00, $10 ; entry 0
    db $ef, $00, $01, $10 ; entry 1
    db $f7, $f8, $02, $10 ; entry 2
    db $f7, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set1B; ends with $80 (E-0147)
MetaSprites26Set1BFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set1B; ends with $80 (E-0147)
MetaSprites26Set1BFrame3::
    db $ef, $f8, $04, $10 ; entry 0
    db $ef, $00, $05, $10 ; entry 1
    db $f7, $f8, $06, $10 ; entry 2
    db $f7, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame4::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set1B; ends with $80 (E-0147)
MetaSprites26Set1BFrame5::
    db $ef, $f8, $08, $10 ; entry 0
    db $ef, $00, $09, $10 ; entry 1
    db $f7, $f8, $0a, $10 ; entry 2
    db $f7, $00, $0b, $10 ; entry 3
    db $80 ; end

; meta-sprite set 28 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set1C::
    dw MetaSprites26Set1CFrame0 ; entry 0
    dw MetaSprites26Set1CFrame1 ; entry 1
    dw MetaSprites26Set1CFrame2 ; entry 2
    dw MetaSprites26Set1CFrame3 ; entry 3
    dw MetaSprites26Set1CFrame4 ; entry 4
    dw MetaSprites26Set1CFrame5 ; entry 5

; frame 0 of MetaSprites26Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set1C; ends with $80 (E-0147)
MetaSprites26Set1CFrame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set1C; ends with $80 (E-0147)
MetaSprites26Set1CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set1C; ends with $80 (E-0147)
MetaSprites26Set1CFrame3::
    db $f9, $f8, $09, $00 ; entry 0
    db $f9, $00, $0a, $00 ; entry 1
    db $f1, $00, $05, $00 ; entry 2
    db $f1, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame4::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $00, $0c, $00 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set1C; ends with $80 (E-0147)
MetaSprites26Set1CFrame5::
    db $f0, $00, $0b, $20 ; entry 0
    db $f0, $f8, $0c, $20 ; entry 1
    db $f8, $00, $0d, $20 ; entry 2
    db $f8, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 29 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set1D::
    dw MetaSprites26Set1DFrame0 ; entry 0
    dw MetaSprites26Set1DFrame1 ; entry 1
    dw MetaSprites26Set1DFrame2 ; entry 2
    dw MetaSprites26Set1DFrame3 ; entry 3
    dw MetaSprites26Set1DFrame4 ; entry 4
    dw MetaSprites26Set1DFrame5 ; entry 5

; frame 0 of MetaSprites26Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame0::
    db $f0, $f7, $00, $00 ; entry 0
    db $f0, $ff, $01, $00 ; entry 1
    db $f8, $f7, $02, $00 ; entry 2
    db $f8, $ff, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set1D; ends with $80 (E-0147)
MetaSprites26Set1DFrame1::
    db $f0, $f7, $00, $00 ; entry 0
    db $f8, $f7, $05, $00 ; entry 1
    db $f8, $ff, $06, $00 ; entry 2
    db $f0, $ff, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set1D; ends with $80 (E-0147)
MetaSprites26Set1DFrame2::
    db $f0, $f8, $07, $00 ; entry 0
    db $f0, $00, $08, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set1D; ends with $80 (E-0147)
MetaSprites26Set1DFrame3::
    db $f0, $00, $08, $00 ; entry 0
    db $f0, $f8, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame4::
    db $f8, $00, $02, $20 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f0, $f8, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set1D; ends with $80 (E-0147)
MetaSprites26Set1DFrame5::
    db $f8, $00, $05, $20 ; entry 0
    db $f8, $f8, $06, $20 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f0, $f8, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 30 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set1E::
    dw MetaSprites26Set1EFrame0 ; entry 0
    dw MetaSprites26Set1EFrame1 ; entry 1
    dw MetaSprites26Set1EFrame2 ; entry 2
    dw MetaSprites26Set1EFrame3 ; entry 3
    dw MetaSprites26Set1EFrame4 ; entry 4
    dw MetaSprites26Set1EFrame5 ; entry 5

; frame 0 of MetaSprites26Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $02, $10 ; entry 2
    db $f9, $00, $02, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set1E; ends with $80 (E-0147)
MetaSprites26Set1EFrame1::
    db $f8, $00, $02, $30 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f0, $f8, $01, $30 ; entry 2
    db $f8, $f8, $02, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set1E; ends with $80 (E-0147)
MetaSprites26Set1EFrame2::
    db $f1, $f8, $03, $10 ; entry 0
    db $f1, $00, $04, $10 ; entry 1
    db $f9, $f8, $05, $10 ; entry 2
    db $f9, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set1E; ends with $80 (E-0147)
MetaSprites26Set1EFrame3::
    db $f0, $f8, $07, $10 ; entry 0
    db $f0, $00, $08, $10 ; entry 1
    db $f8, $f8, $09, $10 ; entry 2
    db $f8, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0c, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set1E; ends with $80 (E-0147)
MetaSprites26Set1EFrame5::
    db $f7, $00, $0c, $30 ; entry 0
    db $f7, $f8, $0c, $10 ; entry 1
    db $ef, $00, $0a, $30 ; entry 2
    db $ef, $f8, $0b, $30 ; entry 3
    db $80 ; end

; meta-sprite set 31 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set1F::
    dw MetaSprites26Set1FFrame0 ; entry 0
    dw MetaSprites26Set1FFrame1 ; entry 1
    dw MetaSprites26Set1FFrame2 ; entry 2
    dw MetaSprites26Set1FFrame3 ; entry 3
    dw MetaSprites26Set1FFrame4 ; entry 4
    dw MetaSprites26Set1FFrame5 ; entry 5

; frame 0 of MetaSprites26Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set1F; ends with $80 (E-0147)
MetaSprites26Set1FFrame1::
    db $f9, $00, $02, $30 ; entry 0
    db $f9, $f8, $03, $30 ; entry 1
    db $f1, $00, $00, $30 ; entry 2
    db $f1, $f8, $01, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set1F; ends with $80 (E-0147)
MetaSprites26Set1FFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set1F; ends with $80 (E-0147)
MetaSprites26Set1FFrame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set1F; ends with $80 (E-0147)
MetaSprites26Set1FFrame5::
    db $f1, $00, $0c, $30 ; entry 0
    db $f1, $f8, $0d, $30 ; entry 1
    db $f9, $00, $0e, $30 ; entry 2
    db $f9, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 32 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set20::
    dw MetaSprites26Set20Frame0 ; entry 0
    dw MetaSprites26Set20Frame1 ; entry 1
    dw MetaSprites26Set20Frame2 ; entry 2
    dw MetaSprites26Set20Frame3 ; entry 3
    dw MetaSprites26Set20Frame4 ; entry 4
    dw MetaSprites26Set20Frame5 ; entry 5

; frame 0 of MetaSprites26Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f8, $f8, $01, $10 ; entry 1
    db $f0, $00, $00, $30 ; entry 2
    db $f8, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set20; ends with $80 (E-0147)
MetaSprites26Set20Frame1::
    db $f1, $f8, $02, $10 ; entry 0
    db $f1, $00, $02, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set20; ends with $80 (E-0147)
MetaSprites26Set20Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set20; ends with $80 (E-0147)
MetaSprites26Set20Frame3::
    db $f9, $f8, $06, $10 ; entry 0
    db $f9, $00, $07, $10 ; entry 1
    db $f1, $f8, $08, $10 ; entry 2
    db $f1, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0a, $30 ; entry 1
    db $f8, $f8, $0b, $10 ; entry 2
    db $f8, $00, $0b, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set20; ends with $80 (E-0147)
MetaSprites26Set20Frame5::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0c, $30 ; entry 1
    db $f9, $f8, $0d, $10 ; entry 2
    db $f9, $00, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 33 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set21::
    dw MetaSprites26Set21Frame0 ; entry 0
    dw MetaSprites26Set21Frame1 ; entry 1
    dw MetaSprites26Set21Frame2 ; entry 2
    dw MetaSprites26Set21Frame3 ; entry 3
    dw MetaSprites26Set21Frame4 ; entry 4
    dw MetaSprites26Set21Frame5 ; entry 5

; frame 0 of MetaSprites26Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame0::
    db $f1, $f9, $00, $00 ; entry 0
    db $f1, $01, $01, $00 ; entry 1
    db $f9, $f9, $02, $00 ; entry 2
    db $f9, $01, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set21; ends with $80 (E-0147)
MetaSprites26Set21Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set21; ends with $80 (E-0147)
MetaSprites26Set21Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set21; ends with $80 (E-0147)
MetaSprites26Set21Frame3::
    db $ef, $f7, $08, $00 ; entry 0
    db $ef, $ff, $09, $00 ; entry 1
    db $f7, $f7, $0a, $00 ; entry 2
    db $f7, $ff, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame4::
    db $f0, $f9, $0c, $00 ; entry 0
    db $f0, $01, $0d, $00 ; entry 1
    db $f8, $f9, $0e, $00 ; entry 2
    db $f8, $01, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set21; ends with $80 (E-0147)
MetaSprites26Set21Frame5::
    db $ef, $00, $0c, $20 ; entry 0
    db $ef, $f8, $0d, $20 ; entry 1
    db $f7, $00, $0e, $20 ; entry 2
    db $f7, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 34 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set22::
    dw MetaSprites26Set22Frame0 ; entry 0
    dw MetaSprites26Set22Frame1 ; entry 1
    dw MetaSprites26Set22Frame2 ; entry 2
    dw MetaSprites26Set22Frame3 ; entry 3
    dw MetaSprites26Set22Frame4 ; entry 4
    dw MetaSprites26Set22Frame5 ; entry 5

; frame 0 of MetaSprites26Set22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set22; ends with $80 (E-0147)
MetaSprites26Set22Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $00, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set22; ends with $80 (E-0147)
MetaSprites26Set22Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set22; ends with $80 (E-0147)
MetaSprites26Set22Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $00, $0c, $20 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set22; ends with $80 (E-0147)
MetaSprites26Set22Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f8, $f8, $0f, $00 ; entry 1
    db $f0, $00, $0e, $20 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 35 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set23::
    dw MetaSprites26Set23Frame0 ; entry 0
    dw MetaSprites26Set23Frame1 ; entry 1
    dw MetaSprites26Set23Frame2 ; entry 2
    dw MetaSprites26Set23Frame3 ; entry 3
    dw MetaSprites26Set23Frame4 ; entry 4
    dw MetaSprites26Set23Frame5 ; entry 5

; frame 0 of MetaSprites26Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set23; ends with $80 (E-0147)
MetaSprites26Set23Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $ff, $00, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set23; ends with $80 (E-0147)
MetaSprites26Set23Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set23; ends with $80 (E-0147)
MetaSprites26Set23Frame3::
    db $f1, $f9, $05, $00 ; entry 0
    db $f1, $01, $06, $00 ; entry 1
    db $f9, $f9, $09, $00 ; entry 2
    db $f9, $01, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set23; ends with $80 (E-0147)
MetaSprites26Set23Frame5::
    db $f1, $ff, $0b, $20 ; entry 0
    db $f1, $f7, $0c, $20 ; entry 1
    db $f9, $ff, $0d, $20 ; entry 2
    db $f9, $f7, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 36 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set24::
    dw MetaSprites26Set24Frame0 ; entry 0
    dw MetaSprites26Set24Frame1 ; entry 1
    dw MetaSprites26Set24Frame2 ; entry 2
    dw MetaSprites26Set24Frame3 ; entry 3
    dw MetaSprites26Set24Frame4 ; entry 4
    dw MetaSprites26Set24Frame5 ; entry 5

; frame 0 of MetaSprites26Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set24; ends with $80 (E-0147)
MetaSprites26Set24Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set24; ends with $80 (E-0147)
MetaSprites26Set24Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set24; ends with $80 (E-0147)
MetaSprites26Set24Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set24; ends with $80 (E-0147)
MetaSprites26Set24Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set25::
    dw MetaSprites26Set25Frame0 ; entry 0
    dw MetaSprites26Set25Frame1 ; entry 1
    dw MetaSprites26Set25Frame2 ; entry 2
    dw MetaSprites26Set25Frame3 ; entry 3
    dw MetaSprites26Set25Frame4 ; entry 4
    dw MetaSprites26Set25Frame5 ; entry 5

; frame 0 of MetaSprites26Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set25; ends with $80 (E-0147)
MetaSprites26Set25Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set25; ends with $80 (E-0147)
MetaSprites26Set25Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set25; ends with $80 (E-0147)
MetaSprites26Set25Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set25; ends with $80 (E-0147)
MetaSprites26Set25Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 38 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set26::
    dw MetaSprites26Set26Frame0 ; entry 0
    dw MetaSprites26Set26Frame1 ; entry 1
    dw MetaSprites26Set26Frame2 ; entry 2
    dw MetaSprites26Set26Frame3 ; entry 3
    dw MetaSprites26Set26Frame4 ; entry 4
    dw MetaSprites26Set26Frame5 ; entry 5

; frame 0 of MetaSprites26Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set26; ends with $80 (E-0147)
MetaSprites26Set26Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set26; ends with $80 (E-0147)
MetaSprites26Set26Frame2::
    db $f0, $fc, $04, $00 ; entry 0
    db $f8, $f8, $06, $00 ; entry 1
    db $f8, $00, $07, $00 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites26Set26; ends with $80 (E-0147)
MetaSprites26Set26Frame3::
    db $f1, $fc, $05, $00 ; entry 0
    db $f9, $f8, $08, $00 ; entry 1
    db $f9, $00, $09, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites26Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set26; ends with $80 (E-0147)
MetaSprites26Set26Frame5::
    db $f1, $00, $0a, $20 ; entry 0
    db $f1, $f8, $0b, $20 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 39 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set27::
    dw MetaSprites26Set27Frame0 ; entry 0
    dw MetaSprites26Set27Frame1 ; entry 1
    dw MetaSprites26Set27Frame2 ; entry 2
    dw MetaSprites26Set27Frame3 ; entry 3
    dw MetaSprites26Set27Frame4 ; entry 4
    dw MetaSprites26Set27Frame5 ; entry 5

; frame 0 of MetaSprites26Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set27; ends with $80 (E-0147)
MetaSprites26Set27Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set27; ends with $80 (E-0147)
MetaSprites26Set27Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set27; ends with $80 (E-0147)
MetaSprites26Set27Frame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $f8, $07, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame4::
    db $f0, $f9, $0a, $00 ; entry 0
    db $f0, $01, $0b, $00 ; entry 1
    db $f8, $f9, $0c, $00 ; entry 2
    db $f8, $01, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set27; ends with $80 (E-0147)
MetaSprites26Set27Frame5::
    db $f1, $f9, $0a, $00 ; entry 0
    db $f1, $01, $0b, $00 ; entry 1
    db $f9, $f9, $0e, $00 ; entry 2
    db $f9, $01, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 40 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set28::
    dw MetaSprites26Set28Frame0 ; entry 0
    dw MetaSprites26Set28Frame1 ; entry 1
    dw MetaSprites26Set28Frame2 ; entry 2
    dw MetaSprites26Set28Frame3 ; entry 3
    dw MetaSprites26Set28Frame4 ; entry 4
    dw MetaSprites26Set28Frame5 ; entry 5

; frame 0 of MetaSprites26Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set28; ends with $80 (E-0147)
MetaSprites26Set28Frame1::
    db $f2, $f8, $00, $00 ; entry 0
    db $f2, $00, $00, $20 ; entry 1
    db $fa, $f8, $03, $00 ; entry 2
    db $fa, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set28; ends with $80 (E-0147)
MetaSprites26Set28Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set28; ends with $80 (E-0147)
MetaSprites26Set28Frame3::
    db $f1, $f6, $05, $00 ; entry 0
    db $f1, $fe, $06, $00 ; entry 1
    db $f9, $f7, $09, $00 ; entry 2
    db $f9, $ff, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set28; ends with $80 (E-0147)
MetaSprites26Set28Frame5::
    db $f2, $f8, $0b, $00 ; entry 0
    db $f2, $00, $0b, $20 ; entry 1
    db $fa, $f8, $0e, $00 ; entry 2
    db $fa, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 49 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set31::
    dw MetaSprites26Set31Frame0 ; entry 0
    dw MetaSprites26Set31Frame1 ; entry 1
    dw MetaSprites26Set31Frame2 ; entry 2
    dw MetaSprites26Set31Frame3 ; entry 3
    dw MetaSprites26Set31Frame4 ; entry 4
    dw MetaSprites26Set31Frame5 ; entry 5

; frame 0 of MetaSprites26Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set31; ends with $80 (E-0147)
MetaSprites26Set31Frame1::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $05, $00 ; entry 2
    db $f8, $ff, $06, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set31; ends with $80 (E-0147)
MetaSprites26Set31Frame2::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $00, $07, $00 ; entry 2
    db $f0, $f8, $0c, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set31; ends with $80 (E-0147)
MetaSprites26Set31Frame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $03, $00 ; entry 2
    db $f0, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame4::
    db $f8, $f8, $0d, $00 ; entry 0
    db $f8, $00, $0e, $20 ; entry 1
    db $f0, $f9, $0c, $00 ; entry 2
    db $f0, $00, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set31; ends with $80 (E-0147)
MetaSprites26Set31Frame5::
    db $f8, $f9, $0e, $00 ; entry 0
    db $f8, $01, $0f, $00 ; entry 1
    db $f0, $01, $03, $20 ; entry 2
    db $f0, $f9, $04, $20 ; entry 3
    db $80 ; end

; meta-sprite set 50 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set32::
    dw MetaSprites26Set32Frame0 ; entry 0
    dw MetaSprites26Set32Frame1 ; entry 1
    dw MetaSprites26Set32Frame2 ; entry 2
    dw MetaSprites26Set32Frame3 ; entry 3
    dw MetaSprites26Set32Frame4 ; entry 4
    dw MetaSprites26Set32Frame5 ; entry 5

; frame 0 of MetaSprites26Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f9, $f8, $01, $00 ; entry 1
    db $f9, $00, $01, $20 ; entry 2
    db $f1, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set32; ends with $80 (E-0147)
MetaSprites26Set32Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set32; ends with $80 (E-0147)
MetaSprites26Set32Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set32; ends with $80 (E-0147)
MetaSprites26Set32Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set32; ends with $80 (E-0147)
MetaSprites26Set32Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 51 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set33::
    dw MetaSprites26Set33Frame0 ; entry 0
    dw MetaSprites26Set33Frame1 ; entry 1
    dw MetaSprites26Set33Frame2 ; entry 2
    dw MetaSprites26Set33Frame3 ; entry 3
    dw MetaSprites26Set33Frame4 ; entry 4
    dw MetaSprites26Set33Frame5 ; entry 5

; frame 0 of MetaSprites26Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set33; ends with $80 (E-0147)
MetaSprites26Set33Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $ef, $00, $02, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set33; ends with $80 (E-0147)
MetaSprites26Set33Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set33; ends with $80 (E-0147)
MetaSprites26Set33Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set33; ends with $80 (E-0147)
MetaSprites26Set33Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 52 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set34::
    dw MetaSprites26Set34Frame0 ; entry 0
    dw MetaSprites26Set34Frame1 ; entry 1
    dw MetaSprites26Set34Frame2 ; entry 2
    dw MetaSprites26Set34Frame3 ; entry 3
    dw MetaSprites26Set34Frame4 ; entry 4
    dw MetaSprites26Set34Frame5 ; entry 5

; frame 0 of MetaSprites26Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame0::
    db $f8, $f8, $01, $00 ; entry 0
    db $f8, $00, $02, $00 ; entry 1
    db $f0, $fd, $00, $00 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites26Set34; ends with $80 (E-0147)
MetaSprites26Set34Frame1::
    db $f8, $00, $01, $20 ; entry 0
    db $f8, $f8, $02, $20 ; entry 1
    db $f0, $fb, $00, $20 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites26Set34; ends with $80 (E-0147)
MetaSprites26Set34Frame2::
    db $f8, $f8, $04, $00 ; entry 0
    db $f8, $00, $05, $00 ; entry 1
    db $f0, $fa, $06, $00 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites26Set34; ends with $80 (E-0147)
MetaSprites26Set34Frame3::
    db $f0, $fb, $06, $00 ; entry 0
    db $f8, $f8, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites26Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame4::
    db $f0, $fd, $00, $00 ; entry 0
    db $f8, $f8, $09, $00 ; entry 1
    db $f8, $00, $0a, $00 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites26Set34; ends with $80 (E-0147)
MetaSprites26Set34Frame5::
    db $f8, $00, $09, $20 ; entry 0
    db $f8, $f8, $0a, $20 ; entry 1
    db $f0, $fb, $00, $20 ; entry 2
    db $80 ; end

; meta-sprite set 53 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set35::
    dw MetaSprites26Set35Frame0 ; entry 0
    dw MetaSprites26Set35Frame1 ; entry 1
    dw MetaSprites26Set35Frame2 ; entry 2
    dw MetaSprites26Set35Frame3 ; entry 3
    dw MetaSprites26Set35Frame4 ; entry 4
    dw MetaSprites26Set35Frame5 ; entry 5

; frame 0 of MetaSprites26Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set35; ends with $80 (E-0147)
MetaSprites26Set35Frame1::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set35; ends with $80 (E-0147)
MetaSprites26Set35Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set35; ends with $80 (E-0147)
MetaSprites26Set35Frame3::
    db $f1, $f7, $0a, $00 ; entry 0
    db $f1, $ff, $0b, $00 ; entry 1
    db $f9, $f7, $08, $00 ; entry 2
    db $f9, $ff, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame4::
    db $f0, $fb, $0c, $00 ; entry 0
    db $f8, $f8, $0e, $00 ; entry 1
    db $f8, $00, $0f, $00 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites26Set35; ends with $80 (E-0147)
MetaSprites26Set35Frame5::
    db $f9, $f8, $0e, $00 ; entry 0
    db $f9, $00, $0f, $00 ; entry 1
    db $f1, $fb, $0d, $00 ; entry 2
    db $80 ; end

; meta-sprite set 54 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set36::
    dw MetaSprites26Set36Frame0 ; entry 0
    dw MetaSprites26Set36Frame1 ; entry 1
    dw MetaSprites26Set36Frame2 ; entry 2
    dw MetaSprites26Set36Frame3 ; entry 3
    dw MetaSprites26Set36Frame4 ; entry 4
    dw MetaSprites26Set36Frame5 ; entry 5

; frame 0 of MetaSprites26Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set36; ends with $80 (E-0147)
MetaSprites26Set36Frame1::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $ff, $03, $20 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set36; ends with $80 (E-0147)
MetaSprites26Set36Frame2::
    db $f0, $f7, $06, $00 ; entry 0
    db $f0, $ff, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set36; ends with $80 (E-0147)
MetaSprites26Set36Frame3::
    db $f8, $f8, $0b, $00 ; entry 0
    db $f8, $00, $0c, $00 ; entry 1
    db $f0, $00, $0a, $00 ; entry 2
    db $f0, $f8, $06, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame4::
    db $f0, $f8, $0d, $00 ; entry 0
    db $f0, $ff, $0d, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set36; ends with $80 (E-0147)
MetaSprites26Set36Frame5::
    db $f0, $f8, $0d, $00 ; entry 0
    db $f0, $ff, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 55 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set37::
    dw MetaSprites26Set37Frame0 ; entry 0
    dw MetaSprites26Set37Frame1 ; entry 1
    dw MetaSprites26Set37Frame2 ; entry 2
    dw MetaSprites26Set37Frame3 ; entry 3
    dw MetaSprites26Set37Frame4 ; entry 4
    dw MetaSprites26Set37Frame5 ; entry 5

; frame 0 of MetaSprites26Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame0::
    db $f2, $f8, $00, $00 ; entry 0
    db $f2, $00, $01, $00 ; entry 1
    db $fa, $f8, $02, $00 ; entry 2
    db $fa, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set37; ends with $80 (E-0147)
MetaSprites26Set37Frame1::
    db $fb, $00, $02, $20 ; entry 0
    db $fb, $f8, $03, $20 ; entry 1
    db $f3, $f8, $04, $00 ; entry 2
    db $f3, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set37; ends with $80 (E-0147)
MetaSprites26Set37Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set37; ends with $80 (E-0147)
MetaSprites26Set37Frame3::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame4::
    db $fa, $f8, $0e, $00 ; entry 0
    db $fa, $00, $0f, $00 ; entry 1
    db $f2, $f8, $0d, $00 ; entry 2
    db $f2, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set37; ends with $80 (E-0147)
MetaSprites26Set37Frame5::
    db $fb, $00, $0e, $20 ; entry 0
    db $fb, $f8, $0f, $20 ; entry 1
    db $f3, $f8, $0c, $00 ; entry 2
    db $f3, $00, $0c, $20 ; entry 3
    db $80 ; end

; meta-sprite set 56 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set38::
    dw MetaSprites26Set38Frame0 ; entry 0
    dw MetaSprites26Set38Frame1 ; entry 1
    dw MetaSprites26Set38Frame2 ; entry 2
    dw MetaSprites26Set38Frame3 ; entry 3
    dw MetaSprites26Set38Frame4 ; entry 4
    dw MetaSprites26Set38Frame5 ; entry 5

; frame 0 of MetaSprites26Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set38; ends with $80 (E-0147)
MetaSprites26Set38Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f9, $f8, $03, $00 ; entry 1
    db $f1, $ff, $02, $20 ; entry 2
    db $f9, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set38; ends with $80 (E-0147)
MetaSprites26Set38Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set38; ends with $80 (E-0147)
MetaSprites26Set38Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $ff, $0c, $20 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set38; ends with $80 (E-0147)
MetaSprites26Set38Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f9, $f8, $0f, $00 ; entry 1
    db $f1, $ff, $0e, $20 ; entry 2
    db $f9, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 57 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set39::
    dw MetaSprites26Set39Frame0 ; entry 0
    dw MetaSprites26Set39Frame1 ; entry 1
    dw MetaSprites26Set39Frame2 ; entry 2
    dw MetaSprites26Set39Frame3 ; entry 3
    dw MetaSprites26Set39Frame4 ; entry 4
    dw MetaSprites26Set39Frame5 ; entry 5

; frame 0 of MetaSprites26Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $02, $10 ; entry 2
    db $f9, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set39; ends with $80 (E-0147)
MetaSprites26Set39Frame1::
    db $f1, $ff, $00, $30 ; entry 0
    db $f1, $f7, $01, $30 ; entry 1
    db $f9, $ff, $02, $30 ; entry 2
    db $f9, $f7, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set39; ends with $80 (E-0147)
MetaSprites26Set39Frame2::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $f8, $08, $10 ; entry 2
    db $f1, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set39; ends with $80 (E-0147)
MetaSprites26Set39Frame3::
    db $f1, $f9, $08, $10 ; entry 0
    db $f1, $01, $0c, $10 ; entry 1
    db $f9, $f9, $0d, $10 ; entry 2
    db $f9, $01, $0e, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame4::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $06, $10 ; entry 2
    db $f9, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set39; ends with $80 (E-0147)
MetaSprites26Set39Frame5::
    db $f9, $ff, $06, $30 ; entry 0
    db $f9, $f7, $07, $30 ; entry 1
    db $f1, $ff, $04, $30 ; entry 2
    db $f1, $f7, $05, $30 ; entry 3
    db $80 ; end

; meta-sprite set 58 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set3A::
    dw MetaSprites26Set3AFrame0 ; entry 0
    dw MetaSprites26Set3AFrame1 ; entry 1
    dw MetaSprites26Set3AFrame2 ; entry 2
    dw MetaSprites26Set3AFrame3 ; entry 3
    dw MetaSprites26Set3AFrame4 ; entry 4
    dw MetaSprites26Set3AFrame5 ; entry 5

; frame 0 of MetaSprites26Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set3A; ends with $80 (E-0147)
MetaSprites26Set3AFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set3A; ends with $80 (E-0147)
MetaSprites26Set3AFrame2::
    db $f1, $ff, $04, $00 ; entry 0
    db $f9, $f7, $05, $00 ; entry 1
    db $f9, $ff, $06, $00 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites26Set3A; ends with $80 (E-0147)
MetaSprites26Set3AFrame3::
    db $f0, $ff, $07, $00 ; entry 0
    db $f8, $f7, $08, $00 ; entry 1
    db $f8, $ff, $09, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites26Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0a, $20 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set3A; ends with $80 (E-0147)
MetaSprites26Set3AFrame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 59 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set3B::
    dw MetaSprites26Set3BFrame0 ; entry 0
    dw MetaSprites26Set3BFrame1 ; entry 1
    dw MetaSprites26Set3BFrame2 ; entry 2
    dw MetaSprites26Set3BFrame3 ; entry 3
    dw MetaSprites26Set3BFrame4 ; entry 4
    dw MetaSprites26Set3BFrame5 ; entry 5

; frame 0 of MetaSprites26Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set3B; ends with $80 (E-0147)
MetaSprites26Set3BFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $ff, $02, $20 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set3B; ends with $80 (E-0147)
MetaSprites26Set3BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set3B; ends with $80 (E-0147)
MetaSprites26Set3BFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set3B; ends with $80 (E-0147)
MetaSprites26Set3BFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f8, $f8, $0f, $00 ; entry 1
    db $f0, $ff, $0e, $20 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 60 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set3C::
    dw MetaSprites26Set3CFrame0 ; entry 0
    dw MetaSprites26Set3CFrame1 ; entry 1
    dw MetaSprites26Set3CFrame2 ; entry 2
    dw MetaSprites26Set3CFrame3 ; entry 3
    dw MetaSprites26Set3CFrame4 ; entry 4
    dw MetaSprites26Set3CFrame5 ; entry 5

; frame 0 of MetaSprites26Set3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set3C; ends with $80 (E-0147)
MetaSprites26Set3CFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $f9, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set3C; ends with $80 (E-0147)
MetaSprites26Set3CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set3C; ends with $80 (E-0147)
MetaSprites26Set3CFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $ff, $0e, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set3C; ends with $80 (E-0147)
MetaSprites26Set3CFrame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 61 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set3D::
    dw MetaSprites26Set3DFrame0 ; entry 0
    dw MetaSprites26Set3DFrame1 ; entry 1
    dw MetaSprites26Set3DFrame2 ; entry 2
    dw MetaSprites26Set3DFrame3 ; entry 3
    dw MetaSprites26Set3DFrame4 ; entry 4
    dw MetaSprites26Set3DFrame5 ; entry 5

; frame 0 of MetaSprites26Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set3D; ends with $80 (E-0147)
MetaSprites26Set3DFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set3D; ends with $80 (E-0147)
MetaSprites26Set3DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set3D; ends with $80 (E-0147)
MetaSprites26Set3DFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set3D; ends with $80 (E-0147)
MetaSprites26Set3DFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 62 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set3E::
    dw MetaSprites26Set3EFrame0 ; entry 0
    dw MetaSprites26Set3EFrame1 ; entry 1
    dw MetaSprites26Set3EFrame2 ; entry 2
    dw MetaSprites26Set3EFrame3 ; entry 3
    dw MetaSprites26Set3EFrame4 ; entry 4
    dw MetaSprites26Set3EFrame5 ; entry 5

; frame 0 of MetaSprites26Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set3E; ends with $80 (E-0147)
MetaSprites26Set3EFrame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set3E; ends with $80 (E-0147)
MetaSprites26Set3EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set3E; ends with $80 (E-0147)
MetaSprites26Set3EFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set3E; ends with $80 (E-0147)
MetaSprites26Set3EFrame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $00, $0e, $20 ; entry 1
    db $f9, $f8, $0f, $00 ; entry 2
    db $f9, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 63 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set3F::
    dw MetaSprites26Set3FFrame0 ; entry 0
    dw MetaSprites26Set3FFrame1 ; entry 1
    dw MetaSprites26Set3FFrame2 ; entry 2
    dw MetaSprites26Set3FFrame3 ; entry 3
    dw MetaSprites26Set3FFrame4 ; entry 4
    dw MetaSprites26Set3FFrame5 ; entry 5

; frame 0 of MetaSprites26Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set3F; ends with $80 (E-0147)
MetaSprites26Set3FFrame1::
    db $f9, $00, $02, $20 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $00, $00, $20 ; entry 2
    db $f1, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set3F; ends with $80 (E-0147)
MetaSprites26Set3FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set3F; ends with $80 (E-0147)
MetaSprites26Set3FFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set3F; ends with $80 (E-0147)
MetaSprites26Set3FFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 64 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set40::
    dw MetaSprites26Set40Frame0 ; entry 0
    dw MetaSprites26Set40Frame1 ; entry 1
    dw MetaSprites26Set40Frame2 ; entry 2
    dw MetaSprites26Set40Frame3 ; entry 3
    dw MetaSprites26Set40Frame4 ; entry 4
    dw MetaSprites26Set40Frame5 ; entry 5

; frame 0 of MetaSprites26Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set40; ends with $80 (E-0147)
MetaSprites26Set40Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set40; ends with $80 (E-0147)
MetaSprites26Set40Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set40; ends with $80 (E-0147)
MetaSprites26Set40Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set40; ends with $80 (E-0147)
MetaSprites26Set40Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $00, $0e, $20 ; entry 1
    db $f9, $f8, $0f, $00 ; entry 2
    db $f9, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 65 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set41::
    dw MetaSprites26Set41Frame0 ; entry 0
    dw MetaSprites26Set41Frame1 ; entry 1
    dw MetaSprites26Set41Frame2 ; entry 2
    dw MetaSprites26Set41Frame3 ; entry 3
    dw MetaSprites26Set41Frame4 ; entry 4
    dw MetaSprites26Set41Frame5 ; entry 5

; frame 0 of MetaSprites26Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set41; ends with $80 (E-0147)
MetaSprites26Set41Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $ef, $00, $02, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set41; ends with $80 (E-0147)
MetaSprites26Set41Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set41; ends with $80 (E-0147)
MetaSprites26Set41Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame4::
    db $f1, $00, $0c, $20 ; entry 0
    db $f9, $00, $0d, $20 ; entry 1
    db $f1, $f8, $0c, $00 ; entry 2
    db $f9, $f8, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set41; ends with $80 (E-0147)
MetaSprites26Set41Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 66 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set42::
    dw MetaSprites26Set42Frame0 ; entry 0
    dw MetaSprites26Set42Frame1 ; entry 1
    dw MetaSprites26Set42Frame2 ; entry 2
    dw MetaSprites26Set42Frame3 ; entry 3
    dw MetaSprites26Set42Frame4 ; entry 4
    dw MetaSprites26Set42Frame5 ; entry 5

; frame 0 of MetaSprites26Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set42; ends with $80 (E-0147)
MetaSprites26Set42Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $00, $02, $20 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set42; ends with $80 (E-0147)
MetaSprites26Set42Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set42; ends with $80 (E-0147)
MetaSprites26Set42Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $00, $0c, $20 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set42; ends with $80 (E-0147)
MetaSprites26Set42Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $f7, $f8, $0f, $00 ; entry 1
    db $ef, $00, $0e, $20 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 67 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set43::
    dw MetaSprites26Set43Frame0 ; entry 0
    dw MetaSprites26Set43Frame1 ; entry 1
    dw MetaSprites26Set43Frame2 ; entry 2
    dw MetaSprites26Set43Frame3 ; entry 3
    dw MetaSprites26Set43Frame4 ; entry 4
    dw MetaSprites26Set43Frame5 ; entry 5

; frame 0 of MetaSprites26Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set43; ends with $80 (E-0147)
MetaSprites26Set43Frame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set43; ends with $80 (E-0147)
MetaSprites26Set43Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set43; ends with $80 (E-0147)
MetaSprites26Set43Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set43; ends with $80 (E-0147)
MetaSprites26Set43Frame5::
    db $f1, $ff, $0c, $20 ; entry 0
    db $f1, $f7, $0d, $20 ; entry 1
    db $f9, $ff, $0e, $20 ; entry 2
    db $f9, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 68 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set44::
    dw MetaSprites26Set44Frame0 ; entry 0
    dw MetaSprites26Set44Frame1 ; entry 1
    dw MetaSprites26Set44Frame2 ; entry 2
    dw MetaSprites26Set44Frame3 ; entry 3
    dw MetaSprites26Set44Frame4 ; entry 4
    dw MetaSprites26Set44Frame5 ; entry 5

; frame 0 of MetaSprites26Set44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $ff, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set44; ends with $80 (E-0147)
MetaSprites26Set44Frame1::
    db $f1, $ff, $00, $30 ; entry 0
    db $f1, $f8, $00, $10 ; entry 1
    db $f9, $ff, $01, $30 ; entry 2
    db $f9, $f7, $02, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set44; ends with $80 (E-0147)
MetaSprites26Set44Frame2::
    db $f0, $f9, $03, $10 ; entry 0
    db $f0, $01, $04, $10 ; entry 1
    db $f8, $f9, $05, $10 ; entry 2
    db $f8, $01, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set44; ends with $80 (E-0147)
MetaSprites26Set44Frame3::
    db $f1, $f9, $03, $10 ; entry 0
    db $f1, $01, $04, $10 ; entry 1
    db $f9, $f9, $07, $10 ; entry 2
    db $f9, $01, $08, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame4::
    db $f0, $f8, $09, $10 ; entry 0
    db $f0, $ff, $09, $30 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set44; ends with $80 (E-0147)
MetaSprites26Set44Frame5::
    db $f1, $ff, $09, $30 ; entry 0
    db $f1, $f8, $09, $10 ; entry 1
    db $f9, $ff, $0a, $30 ; entry 2
    db $f9, $f7, $0b, $30 ; entry 3
    db $80 ; end

; meta-sprite set 69 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set45::
    dw MetaSprites26Set45Frame0 ; entry 0
    dw MetaSprites26Set45Frame1 ; entry 1
    dw MetaSprites26Set45Frame2 ; entry 2
    dw MetaSprites26Set45Frame3 ; entry 3
    dw MetaSprites26Set45Frame4 ; entry 4
    dw MetaSprites26Set45Frame5 ; entry 5

; frame 0 of MetaSprites26Set45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set45; ends with $80 (E-0147)
MetaSprites26Set45Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set45; ends with $80 (E-0147)
MetaSprites26Set45Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set45; ends with $80 (E-0147)
MetaSprites26Set45Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set45; ends with $80 (E-0147)
MetaSprites26Set45Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 70 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set46::
    dw MetaSprites26Set46Frame0 ; entry 0
    dw MetaSprites26Set46Frame1 ; entry 1
    dw MetaSprites26Set46Frame2 ; entry 2
    dw MetaSprites26Set46Frame3 ; entry 3
    dw MetaSprites26Set46Frame4 ; entry 4
    dw MetaSprites26Set46Frame5 ; entry 5

; frame 0 of MetaSprites26Set46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set46; ends with $80 (E-0147)
MetaSprites26Set46Frame1::
    db $f0, $00, $00, $30 ; entry 0
    db $f0, $f8, $01, $30 ; entry 1
    db $f8, $00, $02, $30 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set46; ends with $80 (E-0147)
MetaSprites26Set46Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set46; ends with $80 (E-0147)
MetaSprites26Set46Frame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set46; ends with $80 (E-0147)
MetaSprites26Set46Frame5::
    db $f0, $00, $0c, $30 ; entry 0
    db $f0, $f8, $0d, $30 ; entry 1
    db $f8, $00, $0e, $30 ; entry 2
    db $f8, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 71 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set47::
    dw MetaSprites26Set47Frame0 ; entry 0
    dw MetaSprites26Set47Frame1 ; entry 1
    dw MetaSprites26Set47Frame2 ; entry 2
    dw MetaSprites26Set47Frame3 ; entry 3
    dw MetaSprites26Set47Frame4 ; entry 4
    dw MetaSprites26Set47Frame5 ; entry 5

; frame 0 of MetaSprites26Set47; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $ff, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $ff, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set47; ends with $80 (E-0147)
MetaSprites26Set47Frame1::
    db $ef, $f8, $02, $10 ; entry 0
    db $ef, $ff, $02, $30 ; entry 1
    db $f7, $f8, $03, $10 ; entry 2
    db $f7, $ff, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set47; ends with $80 (E-0147)
MetaSprites26Set47Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set47; ends with $80 (E-0147)
MetaSprites26Set47Frame3::
    db $ef, $f8, $08, $10 ; entry 0
    db $ef, $00, $09, $10 ; entry 1
    db $f7, $f8, $0a, $10 ; entry 2
    db $f7, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set47; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f8, $f8, $0d, $10 ; entry 1
    db $f0, $ff, $0c, $30 ; entry 2
    db $f8, $ff, $0d, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set47; ends with $80 (E-0147)
MetaSprites26Set47Frame5::
    db $ef, $f8, $0e, $10 ; entry 0
    db $f7, $f8, $0f, $10 ; entry 1
    db $ef, $ff, $0e, $30 ; entry 2
    db $f7, $ff, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 72 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set48::
    dw MetaSprites26Set48Frame0 ; entry 0
    dw MetaSprites26Set48Frame1 ; entry 1
    dw MetaSprites26Set48Frame2 ; entry 2
    dw MetaSprites26Set48Frame3 ; entry 3
    dw MetaSprites26Set48Frame4 ; entry 4
    dw MetaSprites26Set48Frame5 ; entry 5

; frame 0 of MetaSprites26Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set48; ends with $80 (E-0147)
MetaSprites26Set48Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set48; ends with $80 (E-0147)
MetaSprites26Set48Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set48; ends with $80 (E-0147)
MetaSprites26Set48Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set48; ends with $80 (E-0147)
MetaSprites26Set48Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 73 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set49::
    dw MetaSprites26Set49Frame0 ; entry 0
    dw MetaSprites26Set49Frame1 ; entry 1
    dw MetaSprites26Set49Frame2 ; entry 2
    dw MetaSprites26Set49Frame3 ; entry 3
    dw MetaSprites26Set49Frame4 ; entry 4
    dw MetaSprites26Set49Frame5 ; entry 5

; frame 0 of MetaSprites26Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set49; ends with $80 (E-0147)
MetaSprites26Set49Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set49; ends with $80 (E-0147)
MetaSprites26Set49Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set49; ends with $80 (E-0147)
MetaSprites26Set49Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set49; ends with $80 (E-0147)
MetaSprites26Set49Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 74 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set4A::
    dw MetaSprites26Set4AFrame0 ; entry 0
    dw MetaSprites26Set4AFrame1 ; entry 1
    dw MetaSprites26Set4AFrame2 ; entry 2
    dw MetaSprites26Set4AFrame3 ; entry 3
    dw MetaSprites26Set4AFrame4 ; entry 4
    dw MetaSprites26Set4AFrame5 ; entry 5

; frame 0 of MetaSprites26Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame0::
    db $f8, $f8, $01, $00 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set4A; ends with $80 (E-0147)
MetaSprites26Set4AFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $ff, $02, $20 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set4A; ends with $80 (E-0147)
MetaSprites26Set4AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set4A; ends with $80 (E-0147)
MetaSprites26Set4AFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $ff, $0c, $20 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set4A; ends with $80 (E-0147)
MetaSprites26Set4AFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f8, $f8, $0f, $00 ; entry 1
    db $f0, $ff, $0e, $20 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 84 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set54::
    dw MetaSprites26Set54Frame0 ; entry 0
    dw MetaSprites26Set54Frame1 ; entry 1
    dw MetaSprites26Set54Frame2 ; entry 2
    dw MetaSprites26Set54Frame3 ; entry 3
    dw MetaSprites26Set54Frame4 ; entry 4
    dw MetaSprites26Set54Frame5 ; entry 5

; frame 0 of MetaSprites26Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $01, $10 ; entry 2
    db $f9, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set54; ends with $80 (E-0147)
MetaSprites26Set54Frame1::
    db $f0, $f8, $02, $10 ; entry 0
    db $f0, $00, $02, $30 ; entry 1
    db $f8, $f8, $03, $10 ; entry 2
    db $f8, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set54; ends with $80 (E-0147)
MetaSprites26Set54Frame2::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $06, $10 ; entry 2
    db $f9, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set54; ends with $80 (E-0147)
MetaSprites26Set54Frame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame4::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0c, $30 ; entry 1
    db $f9, $f8, $0d, $10 ; entry 2
    db $f9, $00, $0d, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set54; ends with $80 (E-0147)
MetaSprites26Set54Frame5::
    db $f0, $f8, $0e, $10 ; entry 0
    db $f0, $00, $0e, $30 ; entry 1
    db $f8, $f8, $0f, $10 ; entry 2
    db $f8, $00, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 85 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set55::
    dw MetaSprites26Set55Frame0 ; entry 0
    dw MetaSprites26Set55Frame1 ; entry 1
    dw MetaSprites26Set55Frame2 ; entry 2
    dw MetaSprites26Set55Frame3 ; entry 3
    dw MetaSprites26Set55Frame4 ; entry 4
    dw MetaSprites26Set55Frame5 ; entry 5

; frame 0 of MetaSprites26Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set55; ends with $80 (E-0147)
MetaSprites26Set55Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set55; ends with $80 (E-0147)
MetaSprites26Set55Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set55; ends with $80 (E-0147)
MetaSprites26Set55Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set55; ends with $80 (E-0147)
MetaSprites26Set55Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 86 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set56::
    dw MetaSprites26Set56Frame0 ; entry 0
    dw MetaSprites26Set56Frame1 ; entry 1
    dw MetaSprites26Set56Frame2 ; entry 2
    dw MetaSprites26Set56Frame3 ; entry 3
    dw MetaSprites26Set56Frame4 ; entry 4
    dw MetaSprites26Set56Frame5 ; entry 5

; frame 0 of MetaSprites26Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame0::
    db $f3, $f9, $00, $00 ; entry 0
    db $f3, $01, $01, $00 ; entry 1
    db $fb, $f9, $02, $00 ; entry 2
    db $fb, $01, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set56; ends with $80 (E-0147)
MetaSprites26Set56Frame1::
    db $f2, $f9, $00, $00 ; entry 0
    db $f2, $01, $01, $00 ; entry 1
    db $fa, $f9, $04, $00 ; entry 2
    db $fa, $01, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set56; ends with $80 (E-0147)
MetaSprites26Set56Frame2::
    db $f0, $f6, $0a, $00 ; entry 0
    db $f0, $fe, $0b, $00 ; entry 1
    db $f8, $f6, $0c, $00 ; entry 2
    db $f8, $fe, $0d, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set56; ends with $80 (E-0147)
MetaSprites26Set56Frame3::
    db $f1, $f6, $0a, $00 ; entry 0
    db $f1, $fe, $0b, $00 ; entry 1
    db $f9, $fe, $0e, $00 ; entry 2
    db $f9, $f6, $0c, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame4::
    db $f3, $f6, $06, $00 ; entry 0
    db $f3, $fe, $07, $00 ; entry 1
    db $fb, $fe, $08, $00 ; entry 2
    db $fb, $f6, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set56; ends with $80 (E-0147)
MetaSprites26Set56Frame5::
    db $f2, $f6, $06, $00 ; entry 0
    db $f2, $fe, $07, $00 ; entry 1
    db $fa, $fe, $09, $00 ; entry 2
    db $fa, $f6, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 87 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set57::
    dw MetaSprites26Set57Frame0 ; entry 0
    dw MetaSprites26Set57Frame1 ; entry 1
    dw MetaSprites26Set57Frame2 ; entry 2
    dw MetaSprites26Set57Frame3 ; entry 3
    dw MetaSprites26Set57Frame4 ; entry 4
    dw MetaSprites26Set57Frame5 ; entry 5

; frame 0 of MetaSprites26Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set57; ends with $80 (E-0147)
MetaSprites26Set57Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $ff, $00, $20 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set57; ends with $80 (E-0147)
MetaSprites26Set57Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set57; ends with $80 (E-0147)
MetaSprites26Set57Frame3::
    db $f1, $f8, $03, $00 ; entry 0
    db $f1, $00, $04, $00 ; entry 1
    db $f9, $f8, $07, $00 ; entry 2
    db $f9, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set57; ends with $80 (E-0147)
MetaSprites26Set57Frame5::
    db $f1, $f8, $09, $00 ; entry 0
    db $f1, $ff, $09, $20 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 88 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set58::
    dw MetaSprites26Set58Frame0 ; entry 0
    dw MetaSprites26Set58Frame1 ; entry 1
    dw MetaSprites26Set58Frame2 ; entry 2
    dw MetaSprites26Set58Frame3 ; entry 3
    dw MetaSprites26Set58Frame4 ; entry 4
    dw MetaSprites26Set58Frame5 ; entry 5

; frame 0 of MetaSprites26Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set58; ends with $80 (E-0147)
MetaSprites26Set58Frame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $04, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set58; ends with $80 (E-0147)
MetaSprites26Set58Frame2::
    db $f0, $f8, $05, $10 ; entry 0
    db $f8, $f8, $07, $10 ; entry 1
    db $f8, $00, $08, $10 ; entry 2
    db $f0, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set58; ends with $80 (E-0147)
MetaSprites26Set58Frame3::
    db $f1, $f8, $05, $10 ; entry 0
    db $f1, $00, $06, $10 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0b, $30 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set58; ends with $80 (E-0147)
MetaSprites26Set58Frame5::
    db $f1, $f8, $0b, $10 ; entry 0
    db $f1, $00, $0b, $30 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 89 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set59::
    dw MetaSprites26Set59Frame0 ; entry 0
    dw MetaSprites26Set59Frame1 ; entry 1
    dw MetaSprites26Set59Frame2 ; entry 2
    dw MetaSprites26Set59Frame3 ; entry 3
    dw MetaSprites26Set59Frame4 ; entry 4
    dw MetaSprites26Set59Frame5 ; entry 5

; frame 0 of MetaSprites26Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set59; ends with $80 (E-0147)
MetaSprites26Set59Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set59; ends with $80 (E-0147)
MetaSprites26Set59Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set59; ends with $80 (E-0147)
MetaSprites26Set59Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set59; ends with $80 (E-0147)
MetaSprites26Set59Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 90 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set5A::
    dw MetaSprites26Set5AFrame0 ; entry 0
    dw MetaSprites26Set5AFrame1 ; entry 1
    dw MetaSprites26Set5AFrame2 ; entry 2
    dw MetaSprites26Set5AFrame3 ; entry 3
    dw MetaSprites26Set5AFrame4 ; entry 4
    dw MetaSprites26Set5AFrame5 ; entry 5

; frame 0 of MetaSprites26Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set5A; ends with $80 (E-0147)
MetaSprites26Set5AFrame1::
    db $f8, $f8, $03, $00 ; entry 0
    db $f8, $00, $04, $00 ; entry 1
    db $f0, $f9, $00, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set5A; ends with $80 (E-0147)
MetaSprites26Set5AFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set5A; ends with $80 (E-0147)
MetaSprites26Set5AFrame3::
    db $f0, $00, $06, $00 ; entry 0
    db $f0, $f8, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set5A; ends with $80 (E-0147)
MetaSprites26Set5AFrame5::
    db $f8, $00, $0d, $20 ; entry 0
    db $f8, $f8, $0e, $20 ; entry 1
    db $f0, $f9, $0f, $00 ; entry 2
    db $f0, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 91 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set5B::
    dw MetaSprites26Set5BFrame0 ; entry 0
    dw MetaSprites26Set5BFrame1 ; entry 1
    dw MetaSprites26Set5BFrame2 ; entry 2
    dw MetaSprites26Set5BFrame3 ; entry 3
    dw MetaSprites26Set5BFrame4 ; entry 4
    dw MetaSprites26Set5BFrame5 ; entry 5

; frame 0 of MetaSprites26Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set5B; ends with $80 (E-0147)
MetaSprites26Set5BFrame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set5B; ends with $80 (E-0147)
MetaSprites26Set5BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set5B; ends with $80 (E-0147)
MetaSprites26Set5BFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set5B; ends with $80 (E-0147)
MetaSprites26Set5BFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 92 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set5C::
    dw MetaSprites26Set5CFrame0 ; entry 0
    dw MetaSprites26Set5CFrame1 ; entry 1
    dw MetaSprites26Set5CFrame2 ; entry 2
    dw MetaSprites26Set5CFrame3 ; entry 3
    dw MetaSprites26Set5CFrame4 ; entry 4
    dw MetaSprites26Set5CFrame5 ; entry 5

; frame 0 of MetaSprites26Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set5C; ends with $80 (E-0147)
MetaSprites26Set5CFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $ff, $02, $20 ; entry 2
    db $f7, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set5C; ends with $80 (E-0147)
MetaSprites26Set5CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set5C; ends with $80 (E-0147)
MetaSprites26Set5CFrame3::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set5C; ends with $80 (E-0147)
MetaSprites26Set5CFrame5::
    db $ef, $f8, $0a, $00 ; entry 0
    db $ef, $00, $0b, $00 ; entry 1
    db $f7, $01, $0c, $20 ; entry 2
    db $f7, $f9, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 93 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set5D::
    dw MetaSprites26Set5DFrame0 ; entry 0
    dw MetaSprites26Set5DFrame1 ; entry 1
    dw MetaSprites26Set5DFrame2 ; entry 2
    dw MetaSprites26Set5DFrame3 ; entry 3
    dw MetaSprites26Set5DFrame4 ; entry 4
    dw MetaSprites26Set5DFrame5 ; entry 5

; frame 0 of MetaSprites26Set5D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame0::
    db $f0, $f9, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f9, $01, $00 ; entry 2
    db $f8, $01, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set5D; ends with $80 (E-0147)
MetaSprites26Set5DFrame1::
    db $f8, $00, $01, $20 ; entry 0
    db $f8, $f8, $02, $20 ; entry 1
    db $f0, $f9, $03, $00 ; entry 2
    db $f0, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set5D; ends with $80 (E-0147)
MetaSprites26Set5DFrame2::
    db $f0, $f5, $04, $00 ; entry 0
    db $f0, $fd, $05, $00 ; entry 1
    db $f8, $f5, $06, $00 ; entry 2
    db $f8, $fd, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set5D; ends with $80 (E-0147)
MetaSprites26Set5DFrame3::
    db $f0, $fd, $05, $00 ; entry 0
    db $f8, $f5, $06, $40 ; entry 1
    db $f0, $f5, $08, $00 ; entry 2
    db $f8, $fd, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set5D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame4::
    db $f8, $f8, $0b, $00 ; entry 0
    db $f8, $00, $0c, $00 ; entry 1
    db $f0, $ff, $0a, $20 ; entry 2
    db $f0, $f8, $0a, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set5D; ends with $80 (E-0147)
MetaSprites26Set5DFrame5::
    db $f8, $ff, $0b, $20 ; entry 0
    db $f8, $f7, $0c, $20 ; entry 1
    db $f0, $f8, $0d, $00 ; entry 2
    db $f0, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 94 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set5E::
    dw MetaSprites26Set5EFrame0 ; entry 0
    dw MetaSprites26Set5EFrame1 ; entry 1
    dw MetaSprites26Set5EFrame2 ; entry 2
    dw MetaSprites26Set5EFrame3 ; entry 3
    dw MetaSprites26Set5EFrame4 ; entry 4
    dw MetaSprites26Set5EFrame5 ; entry 5

; frame 0 of MetaSprites26Set5E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set5E; ends with $80 (E-0147)
MetaSprites26Set5EFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set5E; ends with $80 (E-0147)
MetaSprites26Set5EFrame2::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set5E; ends with $80 (E-0147)
MetaSprites26Set5EFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set5E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set5E; ends with $80 (E-0147)
MetaSprites26Set5EFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 95 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set5F::
    dw MetaSprites26Set5FFrame0 ; entry 0
    dw MetaSprites26Set5FFrame1 ; entry 1
    dw MetaSprites26Set5FFrame2 ; entry 2
    dw MetaSprites26Set5FFrame3 ; entry 3
    dw MetaSprites26Set5FFrame4 ; entry 4
    dw MetaSprites26Set5FFrame5 ; entry 5

; frame 0 of MetaSprites26Set5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set5F; ends with $80 (E-0147)
MetaSprites26Set5FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set5F; ends with $80 (E-0147)
MetaSprites26Set5FFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set5F; ends with $80 (E-0147)
MetaSprites26Set5FFrame3::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set5F; ends with $80 (E-0147)
MetaSprites26Set5FFrame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 96 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set60::
    dw MetaSprites26Set60Frame0 ; entry 0
    dw MetaSprites26Set60Frame1 ; entry 1
    dw MetaSprites26Set60Frame2 ; entry 2
    dw MetaSprites26Set60Frame3 ; entry 3
    dw MetaSprites26Set60Frame4 ; entry 4
    dw MetaSprites26Set60Frame5 ; entry 5

; frame 0 of MetaSprites26Set60; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set60; ends with $80 (E-0147)
MetaSprites26Set60Frame1::
    db $ee, $00, $00, $20 ; entry 0
    db $ee, $f8, $01, $20 ; entry 1
    db $f6, $00, $02, $20 ; entry 2
    db $f6, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set60; ends with $80 (E-0147)
MetaSprites26Set60Frame2::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set60; ends with $80 (E-0147)
MetaSprites26Set60Frame3::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set60; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame4::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set60; ends with $80 (E-0147)
MetaSprites26Set60Frame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 97 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set61::
    dw MetaSprites26Set61Frame0 ; entry 0
    dw MetaSprites26Set61Frame1 ; entry 1
    dw MetaSprites26Set61Frame2 ; entry 2
    dw MetaSprites26Set61Frame3 ; entry 3
    dw MetaSprites26Set61Frame4 ; entry 4
    dw MetaSprites26Set61Frame5 ; entry 5

; frame 0 of MetaSprites26Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set61; ends with $80 (E-0147)
MetaSprites26Set61Frame1::
    db $f8, $f8, $04, $00 ; entry 0
    db $f8, $00, $05, $00 ; entry 1
    db $f0, $f7, $00, $00 ; entry 2
    db $f0, $ff, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set61; ends with $80 (E-0147)
MetaSprites26Set61Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set61; ends with $80 (E-0147)
MetaSprites26Set61Frame3::
    db $f0, $f9, $06, $00 ; entry 0
    db $f0, $01, $07, $00 ; entry 1
    db $f8, $f9, $0a, $00 ; entry 2
    db $f8, $01, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set61; ends with $80 (E-0147)
MetaSprites26Set61Frame5::
    db $f8, $00, $0e, $20 ; entry 0
    db $f8, $f8, $0f, $20 ; entry 1
    db $f0, $f7, $0c, $00 ; entry 2
    db $f0, $ff, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 98 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set62::
    dw MetaSprites26Set62Frame0 ; entry 0
    dw MetaSprites26Set62Frame1 ; entry 1
    dw MetaSprites26Set62Frame2 ; entry 2
    dw MetaSprites26Set62Frame3 ; entry 3
    dw MetaSprites26Set62Frame4 ; entry 4
    dw MetaSprites26Set62Frame5 ; entry 5

; frame 0 of MetaSprites26Set62; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set62; ends with $80 (E-0147)
MetaSprites26Set62Frame1::
    db $ef, $00, $00, $20 ; entry 0
    db $ef, $f8, $01, $20 ; entry 1
    db $f7, $00, $02, $20 ; entry 2
    db $f7, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set62; ends with $80 (E-0147)
MetaSprites26Set62Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set62; ends with $80 (E-0147)
MetaSprites26Set62Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set62; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set62; ends with $80 (E-0147)
MetaSprites26Set62Frame5::
    db $ef, $00, $0c, $20 ; entry 0
    db $ef, $f8, $0d, $20 ; entry 1
    db $f7, $00, $0e, $20 ; entry 2
    db $f7, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 99 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set63::
    dw MetaSprites26Set63Frame0 ; entry 0
    dw MetaSprites26Set63Frame1 ; entry 1
    dw MetaSprites26Set63Frame2 ; entry 2
    dw MetaSprites26Set63Frame3 ; entry 3
    dw MetaSprites26Set63Frame4 ; entry 4
    dw MetaSprites26Set63Frame5 ; entry 5

; frame 0 of MetaSprites26Set63; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame0::
    db $f8, $f8, $01, $00 ; entry 0
    db $f8, $00, $02, $00 ; entry 1
    db $f0, $f9, $00, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set63; ends with $80 (E-0147)
MetaSprites26Set63Frame1::
    db $f0, $fa, $00, $00 ; entry 0
    db $f0, $01, $00, $20 ; entry 1
    db $f8, $f9, $03, $00 ; entry 2
    db $f8, $01, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set63; ends with $80 (E-0147)
MetaSprites26Set63Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set63; ends with $80 (E-0147)
MetaSprites26Set63Frame3::
    db $f0, $f7, $05, $00 ; entry 0
    db $f0, $ff, $06, $00 ; entry 1
    db $f8, $f7, $09, $00 ; entry 2
    db $f8, $ff, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set63; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame4::
    db $f8, $f8, $0c, $00 ; entry 0
    db $f8, $00, $0e, $00 ; entry 1
    db $f0, $f9, $0b, $00 ; entry 2
    db $f0, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set63; ends with $80 (E-0147)
MetaSprites26Set63Frame5::
    db $f8, $00, $0d, $20 ; entry 0
    db $f8, $f8, $0e, $20 ; entry 1
    db $f0, $f8, $0b, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 100 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set64::
    dw MetaSprites26Set64Frame0 ; entry 0
    dw MetaSprites26Set64Frame1 ; entry 1
    dw MetaSprites26Set64Frame2 ; entry 2
    dw MetaSprites26Set64Frame3 ; entry 3
    dw MetaSprites26Set64Frame4 ; entry 4
    dw MetaSprites26Set64Frame5 ; entry 5

; frame 0 of MetaSprites26Set64; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set64; ends with $80 (E-0147)
MetaSprites26Set64Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set64; ends with $80 (E-0147)
MetaSprites26Set64Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set64; ends with $80 (E-0147)
MetaSprites26Set64Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set64; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set64; ends with $80 (E-0147)
MetaSprites26Set64Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 101 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set65::
    dw MetaSprites26Set65Frame0 ; entry 0
    dw MetaSprites26Set65Frame1 ; entry 1
    dw MetaSprites26Set65Frame2 ; entry 2
    dw MetaSprites26Set65Frame3 ; entry 3
    dw MetaSprites26Set65Frame4 ; entry 4
    dw MetaSprites26Set65Frame5 ; entry 5

; frame 0 of MetaSprites26Set65; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set65; ends with $80 (E-0147)
MetaSprites26Set65Frame1::
    db $f2, $f8, $00, $00 ; entry 0
    db $f2, $00, $01, $00 ; entry 1
    db $fa, $f8, $04, $00 ; entry 2
    db $fa, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set65; ends with $80 (E-0147)
MetaSprites26Set65Frame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set65; ends with $80 (E-0147)
MetaSprites26Set65Frame3::
    db $f2, $f8, $06, $00 ; entry 0
    db $f2, $00, $07, $00 ; entry 1
    db $fa, $f8, $0a, $00 ; entry 2
    db $fa, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set65; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $00, $0e, $00 ; entry 2
    db $f9, $f8, $05, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set65; ends with $80 (E-0147)
MetaSprites26Set65Frame5::
    db $f2, $f8, $0c, $00 ; entry 0
    db $f2, $00, $0d, $00 ; entry 1
    db $fa, $00, $0f, $00 ; entry 2
    db $fa, $f8, $03, $20 ; entry 3
    db $80 ; end

; meta-sprite set 102 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set66::
    dw MetaSprites26Set66Frame0 ; entry 0
    dw MetaSprites26Set66Frame1 ; entry 1
    dw MetaSprites26Set66Frame2 ; entry 2
    dw MetaSprites26Set66Frame3 ; entry 3
    dw MetaSprites26Set66Frame4 ; entry 4
    dw MetaSprites26Set66Frame5 ; entry 5

; frame 0 of MetaSprites26Set66; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set66; ends with $80 (E-0147)
MetaSprites26Set66Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set66; ends with $80 (E-0147)
MetaSprites26Set66Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $04, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set66; ends with $80 (E-0147)
MetaSprites26Set66Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set66; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set66; ends with $80 (E-0147)
MetaSprites26Set66Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 103 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set67::
    dw MetaSprites26Set67Frame0 ; entry 0
    dw MetaSprites26Set67Frame1 ; entry 1
    dw MetaSprites26Set67Frame2 ; entry 2
    dw MetaSprites26Set67Frame3 ; entry 3
    dw MetaSprites26Set67Frame4 ; entry 4
    dw MetaSprites26Set67Frame5 ; entry 5

; frame 0 of MetaSprites26Set67; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $ff, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set67; ends with $80 (E-0147)
MetaSprites26Set67Frame1::
    db $f8, $ff, $01, $30 ; entry 0
    db $f8, $f7, $02, $30 ; entry 1
    db $f0, $f8, $03, $10 ; entry 2
    db $f0, $ff, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set67; ends with $80 (E-0147)
MetaSprites26Set67Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set67; ends with $80 (E-0147)
MetaSprites26Set67Frame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set67; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $ff, $0c, $30 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set67; ends with $80 (E-0147)
MetaSprites26Set67Frame5::
    db $f8, $ff, $0d, $30 ; entry 0
    db $f8, $f7, $0e, $30 ; entry 1
    db $f0, $f8, $0f, $10 ; entry 2
    db $f0, $ff, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 104 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set68::
    dw MetaSprites26Set68Frame0 ; entry 0
    dw MetaSprites26Set68Frame1 ; entry 1
    dw MetaSprites26Set68Frame2 ; entry 2
    dw MetaSprites26Set68Frame3 ; entry 3
    dw MetaSprites26Set68Frame4 ; entry 4
    dw MetaSprites26Set68Frame5 ; entry 5

; frame 0 of MetaSprites26Set68; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set68; ends with $80 (E-0147)
MetaSprites26Set68Frame1::
    db $f0, $00, $01, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f8, $f8, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set68; ends with $80 (E-0147)
MetaSprites26Set68Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set68; ends with $80 (E-0147)
MetaSprites26Set68Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $00, $08, $00 ; entry 2
    db $f8, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set68; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set68; ends with $80 (E-0147)
MetaSprites26Set68Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 105 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set69::
    dw MetaSprites26Set69Frame0 ; entry 0
    dw MetaSprites26Set69Frame1 ; entry 1
    dw MetaSprites26Set69Frame2 ; entry 2
    dw MetaSprites26Set69Frame3 ; entry 3
    dw MetaSprites26Set69Frame4 ; entry 4
    dw MetaSprites26Set69Frame5 ; entry 5

; frame 0 of MetaSprites26Set69; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set69; ends with $80 (E-0147)
MetaSprites26Set69Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set69; ends with $80 (E-0147)
MetaSprites26Set69Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set69; ends with $80 (E-0147)
MetaSprites26Set69Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set69; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set69; ends with $80 (E-0147)
MetaSprites26Set69Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 106 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set6A::
    dw MetaSprites26Set6AFrame0 ; entry 0
    dw MetaSprites26Set6AFrame1 ; entry 1
    dw MetaSprites26Set6AFrame2 ; entry 2
    dw MetaSprites26Set6AFrame3 ; entry 3
    dw MetaSprites26Set6AFrame4 ; entry 4
    dw MetaSprites26Set6AFrame5 ; entry 5

; frame 0 of MetaSprites26Set6A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set6A; ends with $80 (E-0147)
MetaSprites26Set6AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set6A; ends with $80 (E-0147)
MetaSprites26Set6AFrame2::
    db $f8, $f8, $08, $00 ; entry 0
    db $f0, $f9, $06, $00 ; entry 1
    db $f0, $01, $07, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set6A; ends with $80 (E-0147)
MetaSprites26Set6AFrame3::
    db $f8, $f8, $09, $00 ; entry 0
    db $f0, $f9, $06, $00 ; entry 1
    db $f0, $01, $07, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set6A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set6A; ends with $80 (E-0147)
MetaSprites26Set6AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 107 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set6B::
    dw MetaSprites26Set6BFrame0 ; entry 0
    dw MetaSprites26Set6BFrame1 ; entry 1
    dw MetaSprites26Set6BFrame2 ; entry 2
    dw MetaSprites26Set6BFrame3 ; entry 3
    dw MetaSprites26Set6BFrame4 ; entry 4
    dw MetaSprites26Set6BFrame5 ; entry 5

; frame 0 of MetaSprites26Set6B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set6B; ends with $80 (E-0147)
MetaSprites26Set6BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set6B; ends with $80 (E-0147)
MetaSprites26Set6BFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set6B; ends with $80 (E-0147)
MetaSprites26Set6BFrame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set6B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set6B; ends with $80 (E-0147)
MetaSprites26Set6BFrame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $01, $0e, $20 ; entry 2
    db $f8, $f9, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 108 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set6C::
    dw MetaSprites26Set6CFrame0 ; entry 0
    dw MetaSprites26Set6CFrame1 ; entry 1
    dw MetaSprites26Set6CFrame2 ; entry 2
    dw MetaSprites26Set6CFrame3 ; entry 3
    dw MetaSprites26Set6CFrame4 ; entry 4
    dw MetaSprites26Set6CFrame5 ; entry 5

; frame 0 of MetaSprites26Set6C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set6C; ends with $80 (E-0147)
MetaSprites26Set6CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set6C; ends with $80 (E-0147)
MetaSprites26Set6CFrame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $08, $00 ; entry 2
    db $f8, $f8, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set6C; ends with $80 (E-0147)
MetaSprites26Set6CFrame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f0, $00, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set6C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f8, $f8, $08, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set6C; ends with $80 (E-0147)
MetaSprites26Set6CFrame5::
    db $f0, $00, $0c, $00 ; entry 0
    db $f0, $f8, $0e, $00 ; entry 1
    db $f8, $00, $0f, $00 ; entry 2
    db $f8, $f8, $0a, $20 ; entry 3
    db $80 ; end

; meta-sprite set 109 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set6D::
    dw MetaSprites26Set6DFrame0 ; entry 0
    dw MetaSprites26Set6DFrame1 ; entry 1
    dw MetaSprites26Set6DFrame2 ; entry 2
    dw MetaSprites26Set6DFrame3 ; entry 3
    dw MetaSprites26Set6DFrame4 ; entry 4
    dw MetaSprites26Set6DFrame5 ; entry 5

; frame 0 of MetaSprites26Set6D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set6D; ends with $80 (E-0147)
MetaSprites26Set6DFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f9, $00, $00 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set6D; ends with $80 (E-0147)
MetaSprites26Set6DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set6D; ends with $80 (E-0147)
MetaSprites26Set6DFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set6D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set6D; ends with $80 (E-0147)
MetaSprites26Set6DFrame5::
    db $f8, $00, $0d, $20 ; entry 0
    db $f8, $f8, $0e, $20 ; entry 1
    db $f0, $00, $0f, $20 ; entry 2
    db $f0, $f9, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 110 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set6E::
    dw MetaSprites26Set6EFrame0 ; entry 0
    dw MetaSprites26Set6EFrame1 ; entry 1
    dw MetaSprites26Set6EFrame2 ; entry 2
    dw MetaSprites26Set6EFrame3 ; entry 3
    dw MetaSprites26Set6EFrame4 ; entry 4
    dw MetaSprites26Set6EFrame5 ; entry 5

; frame 0 of MetaSprites26Set6E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set6E; ends with $80 (E-0147)
MetaSprites26Set6EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set6E; ends with $80 (E-0147)
MetaSprites26Set6EFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set6E; ends with $80 (E-0147)
MetaSprites26Set6EFrame3::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set6E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set6E; ends with $80 (E-0147)
MetaSprites26Set6EFrame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 111 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set6F::
    dw MetaSprites26Set6FFrame0 ; entry 0
    dw MetaSprites26Set6FFrame1 ; entry 1
    dw MetaSprites26Set6FFrame2 ; entry 2
    dw MetaSprites26Set6FFrame3 ; entry 3
    dw MetaSprites26Set6FFrame4 ; entry 4
    dw MetaSprites26Set6FFrame5 ; entry 5

; frame 0 of MetaSprites26Set6F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set6F; ends with $80 (E-0147)
MetaSprites26Set6FFrame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set6F; ends with $80 (E-0147)
MetaSprites26Set6FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set6F; ends with $80 (E-0147)
MetaSprites26Set6FFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set6F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set6F; ends with $80 (E-0147)
MetaSprites26Set6FFrame5::
    db $f1, $ff, $0c, $20 ; entry 0
    db $f1, $f7, $0d, $20 ; entry 1
    db $f9, $ff, $0e, $20 ; entry 2
    db $f9, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 112 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set70::
    dw MetaSprites26Set70Frame0 ; entry 0
    dw MetaSprites26Set70Frame1 ; entry 1
    dw MetaSprites26Set70Frame2 ; entry 2
    dw MetaSprites26Set70Frame3 ; entry 3
    dw MetaSprites26Set70Frame4 ; entry 4
    dw MetaSprites26Set70Frame5 ; entry 5

; frame 0 of MetaSprites26Set70; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set70; ends with $80 (E-0147)
MetaSprites26Set70Frame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set70; ends with $80 (E-0147)
MetaSprites26Set70Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set70; ends with $80 (E-0147)
MetaSprites26Set70Frame3::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set70; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set70; ends with $80 (E-0147)
MetaSprites26Set70Frame5::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 113 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set71::
    dw MetaSprites26Set71Frame0 ; entry 0
    dw MetaSprites26Set71Frame1 ; entry 1
    dw MetaSprites26Set71Frame2 ; entry 2
    dw MetaSprites26Set71Frame3 ; entry 3
    dw MetaSprites26Set71Frame4 ; entry 4
    dw MetaSprites26Set71Frame5 ; entry 5

; frame 0 of MetaSprites26Set71; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set71; ends with $80 (E-0147)
MetaSprites26Set71Frame1::
    db $f9, $f8, $04, $00 ; entry 0
    db $f9, $00, $05, $00 ; entry 1
    db $f1, $f8, $00, $00 ; entry 2
    db $f1, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set71; ends with $80 (E-0147)
MetaSprites26Set71Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set71; ends with $80 (E-0147)
MetaSprites26Set71Frame3::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $00, $09, $00 ; entry 2
    db $f9, $f8, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set71; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set71; ends with $80 (E-0147)
MetaSprites26Set71Frame5::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $00, $0c, $00 ; entry 1
    db $f9, $00, $0f, $00 ; entry 2
    db $f9, $f8, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 119 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set77::
    dw MetaSprites26Set77Frame0 ; entry 0
    dw MetaSprites26Set77Frame1 ; entry 1
    dw MetaSprites26Set77Frame2 ; entry 2
    dw MetaSprites26Set77Frame3 ; entry 3
    dw MetaSprites26Set77Frame4 ; entry 4
    dw MetaSprites26Set77Frame5 ; entry 5

; frame 0 of MetaSprites26Set77; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set77; ends with $80 (E-0147)
MetaSprites26Set77Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f0, $f7, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set77; ends with $80 (E-0147)
MetaSprites26Set77Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set77; ends with $80 (E-0147)
MetaSprites26Set77Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set77; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set77; ends with $80 (E-0147)
MetaSprites26Set77Frame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 120 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set78::
    dw MetaSprites26Set78Frame0 ; entry 0
    dw MetaSprites26Set78Frame1 ; entry 1
    dw MetaSprites26Set78Frame2 ; entry 2
    dw MetaSprites26Set78Frame3 ; entry 3
    dw MetaSprites26Set78Frame4 ; entry 4
    dw MetaSprites26Set78Frame5 ; entry 5

; frame 0 of MetaSprites26Set78; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame0::
    db $f3, $f8, $00, $00 ; entry 0
    db $f3, $00, $01, $00 ; entry 1
    db $fb, $f8, $02, $00 ; entry 2
    db $fb, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set78; ends with $80 (E-0147)
MetaSprites26Set78Frame1::
    db $fb, $00, $02, $20 ; entry 0
    db $fb, $f8, $03, $20 ; entry 1
    db $f3, $f8, $04, $00 ; entry 2
    db $f3, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set78; ends with $80 (E-0147)
MetaSprites26Set78Frame2::
    db $f3, $f8, $06, $00 ; entry 0
    db $f3, $00, $07, $00 ; entry 1
    db $fb, $f8, $08, $00 ; entry 2
    db $fb, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set78; ends with $80 (E-0147)
MetaSprites26Set78Frame3::
    db $f3, $f9, $06, $00 ; entry 0
    db $fb, $f9, $09, $20 ; entry 1
    db $f2, $01, $07, $00 ; entry 2
    db $fa, $01, $08, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set78; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame4::
    db $f3, $f8, $0a, $00 ; entry 0
    db $f3, $00, $0b, $00 ; entry 1
    db $fb, $f8, $0c, $00 ; entry 2
    db $fb, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set78; ends with $80 (E-0147)
MetaSprites26Set78Frame5::
    db $f3, $f8, $0e, $00 ; entry 0
    db $f3, $00, $0f, $00 ; entry 1
    db $fb, $00, $0c, $20 ; entry 2
    db $fb, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 121 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set79::
    dw MetaSprites26Set79Frame0 ; entry 0
    dw MetaSprites26Set79Frame1 ; entry 1
    dw MetaSprites26Set79Frame2 ; entry 2
    dw MetaSprites26Set79Frame3 ; entry 3
    dw MetaSprites26Set79Frame4 ; entry 4
    dw MetaSprites26Set79Frame5 ; entry 5

; frame 0 of MetaSprites26Set79; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $fe, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set79; ends with $80 (E-0147)
MetaSprites26Set79Frame1::
    db $f8, $f8, $04, $10 ; entry 0
    db $f8, $00, $05, $10 ; entry 1
    db $f0, $01, $01, $10 ; entry 2
    db $f0, $fa, $01, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set79; ends with $80 (E-0147)
MetaSprites26Set79Frame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $00, $09, $10 ; entry 2
    db $f8, $f8, $08, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set79; ends with $80 (E-0147)
MetaSprites26Set79Frame3::
    db $f8, $00, $0a, $10 ; entry 0
    db $f8, $f8, $03, $30 ; entry 1
    db $f0, $f9, $06, $10 ; entry 2
    db $f0, $01, $07, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set79; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame4::
    db $f8, $00, $03, $10 ; entry 0
    db $f0, $f9, $0b, $10 ; entry 1
    db $f0, $ff, $0c, $10 ; entry 2
    db $f8, $f8, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set79; ends with $80 (E-0147)
MetaSprites26Set79Frame5::
    db $f0, $01, $0c, $10 ; entry 0
    db $f0, $fa, $0c, $30 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 122 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set7A::
    dw MetaSprites26Set7AFrame0 ; entry 0
    dw MetaSprites26Set7AFrame1 ; entry 1
    dw MetaSprites26Set7AFrame2 ; entry 2
    dw MetaSprites26Set7AFrame3 ; entry 3
    dw MetaSprites26Set7AFrame4 ; entry 4
    dw MetaSprites26Set7AFrame5 ; entry 5

; frame 0 of MetaSprites26Set7A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set7A; ends with $80 (E-0147)
MetaSprites26Set7AFrame1::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set7A; ends with $80 (E-0147)
MetaSprites26Set7AFrame2::
    db $f8, $f8, $08, $10 ; entry 0
    db $f8, $00, $09, $10 ; entry 1
    db $f0, $f8, $00, $10 ; entry 2
    db $f0, $00, $01, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set7A; ends with $80 (E-0147)
MetaSprites26Set7AFrame3::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set7A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame4::
    db $f8, $f8, $0d, $10 ; entry 0
    db $f8, $00, $0e, $10 ; entry 1
    db $f0, $00, $00, $30 ; entry 2
    db $f0, $f8, $0c, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set7A; ends with $80 (E-0147)
MetaSprites26Set7AFrame5::
    db $f8, $00, $0d, $30 ; entry 0
    db $f8, $f8, $0e, $30 ; entry 1
    db $f0, $00, $04, $30 ; entry 2
    db $f0, $f8, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 123 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set7B::
    dw MetaSprites26Set7BFrame0 ; entry 0
    dw MetaSprites26Set7BFrame1 ; entry 1
    dw MetaSprites26Set7BFrame2 ; entry 2
    dw MetaSprites26Set7BFrame3 ; entry 3
    dw MetaSprites26Set7BFrame4 ; entry 4
    dw MetaSprites26Set7BFrame5 ; entry 5

; frame 0 of MetaSprites26Set7B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame0::
    db $ef, $f8, $00, $10 ; entry 0
    db $ef, $00, $00, $30 ; entry 1
    db $f7, $f8, $01, $10 ; entry 2
    db $f7, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set7B; ends with $80 (E-0147)
MetaSprites26Set7BFrame1::
    db $f0, $f8, $02, $10 ; entry 0
    db $f0, $00, $02, $30 ; entry 1
    db $f8, $f8, $03, $10 ; entry 2
    db $f8, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set7B; ends with $80 (E-0147)
MetaSprites26Set7BFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set7B; ends with $80 (E-0147)
MetaSprites26Set7BFrame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set7B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0c, $30 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0d, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set7B; ends with $80 (E-0147)
MetaSprites26Set7BFrame5::
    db $f1, $f8, $0e, $10 ; entry 0
    db $f1, $00, $0e, $30 ; entry 1
    db $f9, $f8, $0f, $10 ; entry 2
    db $f9, $00, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 124 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set7C::
    dw MetaSprites26Set7CFrame0 ; entry 0
    dw MetaSprites26Set7CFrame1 ; entry 1
    dw MetaSprites26Set7CFrame2 ; entry 2
    dw MetaSprites26Set7CFrame3 ; entry 3
    dw MetaSprites26Set7CFrame4 ; entry 4
    dw MetaSprites26Set7CFrame5 ; entry 5

; frame 0 of MetaSprites26Set7C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set7C; ends with $80 (E-0147)
MetaSprites26Set7CFrame1::
    db $ef, $f8, $00, $10 ; entry 0
    db $ef, $00, $01, $10 ; entry 1
    db $f7, $f8, $04, $10 ; entry 2
    db $f7, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set7C; ends with $80 (E-0147)
MetaSprites26Set7CFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set7C; ends with $80 (E-0147)
MetaSprites26Set7CFrame3::
    db $ef, $f8, $06, $10 ; entry 0
    db $ef, $00, $07, $10 ; entry 1
    db $f7, $f8, $0a, $10 ; entry 2
    db $f7, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set7C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $00, $02, $30 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set7C; ends with $80 (E-0147)
MetaSprites26Set7CFrame5::
    db $ef, $f8, $0c, $10 ; entry 0
    db $ef, $00, $0d, $10 ; entry 1
    db $f7, $00, $04, $30 ; entry 2
    db $f7, $f8, $05, $30 ; entry 3
    db $80 ; end

; meta-sprite set 125 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set7D::
    dw MetaSprites26Set7DFrame0 ; entry 0
    dw MetaSprites26Set7DFrame1 ; entry 1
    dw MetaSprites26Set7DFrame2 ; entry 2
    dw MetaSprites26Set7DFrame3 ; entry 3
    dw MetaSprites26Set7DFrame4 ; entry 4
    dw MetaSprites26Set7DFrame5 ; entry 5

; frame 0 of MetaSprites26Set7D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set7D; ends with $80 (E-0147)
MetaSprites26Set7DFrame1::
    db $ee, $f8, $02, $00 ; entry 0
    db $ee, $00, $02, $20 ; entry 1
    db $f6, $f8, $03, $00 ; entry 2
    db $f6, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set7D; ends with $80 (E-0147)
MetaSprites26Set7DFrame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set7D; ends with $80 (E-0147)
MetaSprites26Set7DFrame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set7D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set7D; ends with $80 (E-0147)
MetaSprites26Set7DFrame5::
    db $ee, $f8, $0e, $00 ; entry 0
    db $ee, $00, $0e, $20 ; entry 1
    db $f6, $f8, $0f, $00 ; entry 2
    db $f6, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 126 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set7E::
    dw MetaSprites26Set7EFrame0 ; entry 0
    dw MetaSprites26Set7EFrame1 ; entry 1
    dw MetaSprites26Set7EFrame2 ; entry 2
    dw MetaSprites26Set7EFrame3 ; entry 3
    dw MetaSprites26Set7EFrame4 ; entry 4
    dw MetaSprites26Set7EFrame5 ; entry 5

; frame 0 of MetaSprites26Set7E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set7E; ends with $80 (E-0147)
MetaSprites26Set7EFrame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set7E; ends with $80 (E-0147)
MetaSprites26Set7EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set7E; ends with $80 (E-0147)
MetaSprites26Set7EFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set7E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set7E; ends with $80 (E-0147)
MetaSprites26Set7EFrame5::
    db $f1, $01, $0c, $20 ; entry 0
    db $f1, $f9, $0d, $20 ; entry 1
    db $f9, $01, $0e, $20 ; entry 2
    db $f9, $f9, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 127 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites26Set7F::
    dw MetaSprites26Set7FFrame0 ; entry 0
    dw MetaSprites26Set7FFrame1 ; entry 1
    dw MetaSprites26Set7FFrame2 ; entry 2
    dw MetaSprites26Set7FFrame3 ; entry 3
    dw MetaSprites26Set7FFrame4 ; entry 4
    dw MetaSprites26Set7FFrame5 ; entry 5

; frame 0 of MetaSprites26Set7F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame0::
    db $f9, $f8, $02, $00 ; entry 0
    db $f9, $00, $03, $00 ; entry 1
    db $f1, $f8, $00, $00 ; entry 2
    db $f1, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites26Set7F; ends with $80 (E-0147)
MetaSprites26Set7FFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites26Set7F; ends with $80 (E-0147)
MetaSprites26Set7FFrame2::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites26Set7F; ends with $80 (E-0147)
MetaSprites26Set7FFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites26Set7F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame4::
    db $f9, $f8, $06, $00 ; entry 0
    db $f9, $00, $07, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites26Set7F; ends with $80 (E-0147)
MetaSprites26Set7FFrame5::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $ff, $06, $20 ; entry 2
    db $f9, $f7, $07, $20 ; entry 3
    db $80 ; end
    ds $1072, $00
