; ROM bank $27: meta-sprite frames
; The annotated listing of this bank is build/listing/bank27.asm.

SECTION "Bank 27", ROMX
    db $27

; Draws one meta-sprite of bank $27 into the shadow OAM. hSpriteSetIndex picks the set; when bit 0
; of MetaSprites27Attrs[hSpriteSetIndex] is set, its high nibble is ORed into hSpriteAttrXor (it
; flips or recolours every part). Then it calls DrawMetaSpriteSet_Bank27_BuildOam with DE =
; MetaSprites27Table, which builds the parts of frame hSpriteSubIndex of that set. The field sprite
; drawing in bank $04 picks the bank from the sprite graphics id: a nonzero high byte uses bank $27,
; bit 7 of the low byte set uses bank $26, otherwise bank $25, and the low 7 bits are the set index.
; Also farcalled from the debug menu (bank $01) and bank $1D. (C1, E-0378)
; ORs the attribute bits from MetaSprites27Attrs[hSpriteSetIndex] (when its bit 0 is set) into
; hSpriteAttrXor, then builds the sprite from MetaSprites27Table (E-0124)
DrawMetaSpriteSet_Bank27::
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, MetaSprites27Attrs
    add hl, de
    bit 0, [hl]
    jr z, .call_draw_meta_sprite_set_bank27_build_oam
    ld a, [hl]
    and $f0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or e
    ldh [hSpriteAttrXor], a

.call_draw_meta_sprite_set_bank27_build_oam:
    ld de, MetaSprites27Table
    call DrawMetaSpriteSet_Bank27_BuildOam
    ret

SECTION "Bank 27 MetaSprites27Table", ROMX

; DrawMetaSpriteSet_Bank27 passes DE = $MetaSprites27Table to the builder, which takes the word at
; DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 127
; words up to the attribute table at $411C (E-0147, C1)
; record: meta-sprite set
MetaSprites27Table::
    dw MetaSprites27Set00 ; id 0
    dw MetaSprites27Set01 ; id 1
    dw MetaSprites27Set02 ; id 2
    dw MetaSprites27Set03 ; id 3
    dw MetaSprites27Set04 ; id 4
    dw MetaSprites27Set05 ; id 5
    dw MetaSprites27Set06 ; id 6
    dw MetaSprites27Set07 ; id 7
    dw MetaSprites27Set08 ; id 8
    dw MetaSprites27Set09 ; id 9
    dw MetaSprites27Set0A ; id 10
    dw MetaSprites27Set0B ; id 11
    dw MetaSprites27Set0C ; id 12
    dw MetaSprites27Set0D ; id 13
    dw MetaSprites27Set0E ; id 14
    dw MetaSprites27Set0F ; id 15
    dw MetaSprites27Set10 ; id 16
    dw MetaSprites27Set11 ; id 17
    dw MetaSprites27Set11 ; id 18
    dw MetaSprites27Set11 ; id 19
    dw MetaSprites27Set11 ; id 20
    dw MetaSprites27Set11 ; id 21
    dw MetaSprites27Set11 ; id 22
    dw MetaSprites27Set11 ; id 23
    dw MetaSprites27Set11 ; id 24
    dw MetaSprites27Set11 ; id 25
    dw MetaSprites27Set1A ; id 26
    dw MetaSprites27Set1B ; id 27
    dw MetaSprites27Set1C ; id 28
    dw MetaSprites27Set1D ; id 29
    dw MetaSprites27Set1E ; id 30
    dw MetaSprites27Set1F ; id 31
    dw MetaSprites27Set20 ; id 32
    dw MetaSprites27Set21 ; id 33
    dw MetaSprites27Set22 ; id 34
    dw MetaSprites27Set23 ; id 35
    dw MetaSprites27Set24 ; id 36
    dw MetaSprites27Set25 ; id 37
    dw MetaSprites27Set26 ; id 38
    dw MetaSprites27Set27 ; id 39
    dw MetaSprites27Set28 ; id 40
    dw MetaSprites27Set29 ; id 41
    dw MetaSprites27Set2A ; id 42
    dw MetaSprites27Set2B ; id 43
    dw MetaSprites27Set2C ; id 44
    dw MetaSprites27Set2D ; id 45
    dw MetaSprites27Set2E ; id 46
    dw MetaSprites27Set2F ; id 47
    dw MetaSprites27Set30 ; id 48
    dw MetaSprites27Set31 ; id 49
    dw MetaSprites27Set32 ; id 50
    dw MetaSprites27Set33 ; id 51
    dw MetaSprites27Set34 ; id 52
    dw MetaSprites27Set35 ; id 53
    dw MetaSprites27Set36 ; id 54
    dw MetaSprites27Set37 ; id 55
    dw MetaSprites27Set38 ; id 56
    dw MetaSprites27Set39 ; id 57
    dw MetaSprites27Set39 ; id 58
    dw MetaSprites27Set39 ; id 59
    dw MetaSprites27Set39 ; id 60
    dw MetaSprites27Set3D ; id 61
    dw MetaSprites27Set3E ; id 62
    dw MetaSprites27Set3F ; id 63
    dw MetaSprites27Set40 ; id 64
    dw MetaSprites27Set41 ; id 65
    dw MetaSprites27Set42 ; id 66
    dw MetaSprites27Set43 ; id 67
    dw MetaSprites27Set44 ; id 68
    dw MetaSprites27Set45 ; id 69
    dw MetaSprites27Set46 ; id 70
    dw MetaSprites27Set47 ; id 71
    dw MetaSprites27Set48 ; id 72
    dw MetaSprites27Set49 ; id 73
    dw MetaSprites27Set4A ; id 74
    dw MetaSprites27Set4B ; id 75
    dw MetaSprites27Set4C ; id 76
    dw MetaSprites27Set4D ; id 77
    dw MetaSprites27Set4E ; id 78
    dw MetaSprites27Set4F ; id 79
    dw MetaSprites27Set50 ; id 80
    dw MetaSprites27Set51 ; id 81
    dw MetaSprites27Set52 ; id 82
    dw MetaSprites27Set53 ; id 83
    dw MetaSprites27Set54 ; id 84
    dw MetaSprites27Set55 ; id 85
    dw MetaSprites27Set56 ; id 86
    dw MetaSprites27Set57 ; id 87
    dw MetaSprites27Set58 ; id 88
    dw MetaSprites27Set59 ; id 89
    dw MetaSprites27Set5A ; id 90
    dw MetaSprites27Set5B ; id 91
    dw MetaSprites27Set5C ; id 92
    dw MetaSprites27Set5C ; id 93
    dw MetaSprites27Set5C ; id 94
    dw MetaSprites27Set5C ; id 95
    dw MetaSprites27Set60 ; id 96
    dw MetaSprites27Set61 ; id 97
    dw MetaSprites27Set62 ; id 98
    dw MetaSprites27Set63 ; id 99
    dw MetaSprites27Set64 ; id 100
    dw MetaSprites27Set65 ; id 101
    dw MetaSprites27Set66 ; id 102
    dw MetaSprites27Set67 ; id 103
    dw MetaSprites27Set68 ; id 104
    dw MetaSprites27Set69 ; id 105
    dw MetaSprites27Set6A ; id 106
    dw MetaSprites27Set6B ; id 107
    dw MetaSprites27Set6C ; id 108
    dw MetaSprites27Set6D ; id 109
    dw MetaSprites27Set6E ; id 110
    dw MetaSprites27Set6F ; id 111
    dw MetaSprites27Set70 ; id 112
    dw MetaSprites27Set71 ; id 113
    dw MetaSprites27Set72 ; id 114
    dw MetaSprites27Set73 ; id 115
    dw MetaSprites27Set74 ; id 116
    dw $0000 ; id 117
    dw $0000 ; id 118
    dw $0000 ; id 119
    dw $0000 ; id 120
    dw $0000 ; id 121
    dw $0000 ; id 122
    dw $0000 ; id 123
    dw MetaSprites27Set7C ; id 124
    dw MetaSprites27Set7D ; id 125
    dw MetaSprites27Set7E ; id 126

; DrawMetaSpriteSet_Bank27 reads the byte $411C + hSpriteSetIndex; when bit 0 is set it ORs its high
; nibble into hSpriteAttrXor before drawing (E-0147, C1)
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites27Attrs::
    db $00 ; id 0
    db $00 ; id 1
    db $00 ; id 2
    db $10 ; id 3
    db $11 ; id 4
    db $01 ; id 5
    db $01 ; id 6
    db $10 ; id 7
    db $00 ; id 8
    db $00 ; id 9
    db $00 ; id 10
    db $10 ; id 11
    db $01 ; id 12
    db $00 ; id 13
    db $00 ; id 14
    db $01 ; id 15
    db $11 ; id 16
    db $00 ; id 17
    db $00 ; id 18
    db $00 ; id 19
    db $00 ; id 20
    db $00 ; id 21
    db $00 ; id 22
    db $00 ; id 23
    db $00 ; id 24
    db $00 ; id 25
    db $00 ; id 26
    db $00 ; id 27
    db $00 ; id 28
    db $10 ; id 29
    db $00 ; id 30
    db $10 ; id 31
    db $00 ; id 32
    db $01 ; id 33
    db $00 ; id 34
    db $10 ; id 35
    db $00 ; id 36
    db $10 ; id 37
    db $00 ; id 38
    db $00 ; id 39
    db $01 ; id 40
    db $00 ; id 41
    db $11 ; id 42
    db $10 ; id 43
    db $10 ; id 44
    db $10 ; id 45
    db $00 ; id 46
    db $10 ; id 47
    db $01 ; id 48
    db $00 ; id 49
    db $10 ; id 50
    db $00 ; id 51
    db $10 ; id 52
    db $00 ; id 53
    db $01 ; id 54
    db $01 ; id 55
    db $01 ; id 56
    db $00 ; id 57
    db $00 ; id 58
    db $00 ; id 59
    db $01 ; id 60
    db $01 ; id 61
    db $01 ; id 62
    db $11 ; id 63
    db $11 ; id 64
    db $11 ; id 65
    db $01 ; id 66
    db $01 ; id 67
    db $01 ; id 68
    db $01 ; id 69
    db $11 ; id 70
    db $01 ; id 71
    db $11 ; id 72
    db $01 ; id 73
    db $01 ; id 74
    db $01 ; id 75
    db $11 ; id 76
    db $01 ; id 77
    db $11 ; id 78
    db $01 ; id 79
    db $11 ; id 80
    db $11 ; id 81
    db $11 ; id 82
    db $01 ; id 83
    db $11 ; id 84
    db $01 ; id 85
    db $01 ; id 86
    db $11 ; id 87
    db $01 ; id 88
    db $11 ; id 89
    db $01 ; id 90
    db $11 ; id 91
    db $00 ; id 92
    db $00 ; id 93
    db $00 ; id 94
    db $00 ; id 95
    db $00 ; id 96
    db $11 ; id 97
    db $00 ; id 98
    db $10 ; id 99
    db $11 ; id 100
    db $10 ; id 101
    db $00 ; id 102
    db $01 ; id 103
    db $10 ; id 104
    db $11 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $10 ; id 108
    db $10 ; id 109
    db $00 ; id 110
    db $11 ; id 111
    db $11 ; id 112
    db $00 ; id 113
    db $11 ; id 114
    db $01 ; id 115
    db $11 ; id 116
    db $00 ; id 117
    db $00 ; id 118
    db $00 ; id 119
    db $00 ; id 120
    db $00 ; id 121
    db $00 ; id 122
    db $01 ; id 123
    db $01 ; id 124
    db $11 ; id 125
    db $01 ; id 126
    db $00

; DE = a table of meta-sprite set pointers (DrawMetaSpriteSet_Bank27 passes MetaSprites27Table):
; returns at once when hOamNextEntry is $27 or more; otherwise adds the sprite scroll words to the
; origin (hMetaSpriteYLo/Hi, hMetaSpriteXLo/Hi, and X - 8 in hMetaSpriteXFlipLo/Hi), takes the set
; at DE + 2 * hSpriteSetIndex and the frame at set + 2 * hSpriteSubIndex, and writes each 4-byte
; entry (Y, X, tile + hSpriteTileOffset, attribute XOR hSpriteAttrXor; $80 ends the frame) to
; wShadowOAM at hOamNextEntry, skipping entries off screen and stopping at 40 entries. Bit 5 of
; hSpriteAttrXor mirrors the X offsets. With hSpriteWindowClipMode set it also drops entries above Y
; $34 (mode 1) or from Y $71 (mode 2), and entries whose BG tile
; (BGTileUnderPointIsSpriteHideTile_Bank27) is hSpriteHideTile or above. The same code as
; DrawMetaSpriteAt in bank $7F. (C1, E-0370)
DrawMetaSpriteSet_Bank27_BuildOam::
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
    call BGTileUnderPointIsSpriteHideTile_Bank27
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
    call BGTileUnderPointIsSpriteHideTile_Bank27
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

SECTION "Bank 27 BGTileUnderPointIsSpriteHideTile_Bank27", ROMX

; DE = the address of an X byte with its Y byte at DE - 1 (screen coordinates). Reads the $9800 BG
; map tile under (X + hScrollX - 4, Y + hScrollY - 12), with rows wrapping inside the map, after
; rSTAT bit 1 clears (interrupts off), and compares it with hSpriteHideTile. Returns A = that tile
; and the flags of cp hSpriteHideTile: Z when they are equal, carry when the tile is below it. Its
; two callers in this bank (the meta-sprite builder, used only when hSpriteWindowClipMode is
; nonzero) skip a sprite part on jr nc, that is when the tile is hSpriteHideTile or higher. BC and
; HL are kept. (C1, E-0378)
; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map
; entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after
; rSTAT bit 1 clears (interrupts off) and compares with hSpriteHideTile: Z set when equal, A = the
; tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
BGTileUnderPointIsSpriteHideTile_Bank27::
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

SECTION "Bank 27 MetaSprites27Set00", ROMX

; meta-sprite set 0 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set00::
    dw MetaSprites27Set00Frame0 ; entry 0
    dw MetaSprites27Set00Frame1 ; entry 1
    dw MetaSprites27Set00Frame2 ; entry 2
    dw MetaSprites27Set00Frame3 ; entry 3
    dw MetaSprites27Set00Frame4 ; entry 4
    dw MetaSprites27Set00Frame5 ; entry 5

; frame 0 of MetaSprites27Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set00; ends with $80 (E-0147)
MetaSprites27Set00Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $ff, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set00; ends with $80 (E-0147)
MetaSprites27Set00Frame2::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set00; ends with $80 (E-0147)
MetaSprites27Set00Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set00; ends with $80 (E-0147)
MetaSprites27Set00Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $ff, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 1 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set01::
    dw MetaSprites27Set01Frame0 ; entry 0
    dw MetaSprites27Set01Frame1 ; entry 1
    dw MetaSprites27Set01Frame2 ; entry 2
    dw MetaSprites27Set01Frame3 ; entry 3
    dw MetaSprites27Set01Frame4 ; entry 4
    dw MetaSprites27Set01Frame5 ; entry 5

; frame 0 of MetaSprites27Set01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set01; ends with $80 (E-0147)
MetaSprites27Set01Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set01; ends with $80 (E-0147)
MetaSprites27Set01Frame2::
    db $ef, $f8, $06, $00 ; entry 0
    db $ef, $00, $07, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set01; ends with $80 (E-0147)
MetaSprites27Set01Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set01; ends with $80 (E-0147)
MetaSprites27Set01Frame5::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0e, $00 ; entry 1
    db $f9, $00, $0f, $00 ; entry 2
    db $f9, $f8, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set02::
    dw MetaSprites27Set02Frame0 ; entry 0
    dw MetaSprites27Set02Frame1 ; entry 1
    dw MetaSprites27Set02Frame2 ; entry 2
    dw MetaSprites27Set02Frame3 ; entry 3
    dw MetaSprites27Set02Frame4 ; entry 4
    dw MetaSprites27Set02Frame5 ; entry 5

; frame 0 of MetaSprites27Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set02; ends with $80 (E-0147)
MetaSprites27Set02Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set02; ends with $80 (E-0147)
MetaSprites27Set02Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set02; ends with $80 (E-0147)
MetaSprites27Set02Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set02; ends with $80 (E-0147)
MetaSprites27Set02Frame5::
    db $f1, $00, $0a, $20 ; entry 0
    db $f1, $f8, $0b, $20 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set03::
    dw MetaSprites27Set03Frame0 ; entry 0
    dw MetaSprites27Set03Frame1 ; entry 1
    dw MetaSprites27Set03Frame2 ; entry 2
    dw MetaSprites27Set03Frame3 ; entry 3
    dw MetaSprites27Set03Frame4 ; entry 4
    dw MetaSprites27Set03Frame5 ; entry 5

; frame 0 of MetaSprites27Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set03; ends with $80 (E-0147)
MetaSprites27Set03Frame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $00, $03, $10 ; entry 2
    db $f9, $f8, $04, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set03; ends with $80 (E-0147)
MetaSprites27Set03Frame2::
    db $f0, $f8, $05, $10 ; entry 0
    db $f0, $00, $06, $10 ; entry 1
    db $f8, $f8, $07, $10 ; entry 2
    db $f8, $00, $08, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set03; ends with $80 (E-0147)
MetaSprites27Set03Frame3::
    db $f1, $f8, $05, $10 ; entry 0
    db $f1, $00, $06, $10 ; entry 1
    db $f9, $00, $08, $10 ; entry 2
    db $f9, $f8, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $07, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set03; ends with $80 (E-0147)
MetaSprites27Set03Frame5::
    db $f1, $f8, $0a, $10 ; entry 0
    db $f1, $00, $0b, $10 ; entry 1
    db $f9, $f8, $0c, $10 ; entry 2
    db $f9, $00, $09, $30 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set04::
    dw MetaSprites27Set04Frame0 ; entry 0
    dw MetaSprites27Set04Frame1 ; entry 1
    dw MetaSprites27Set04Frame2 ; entry 2
    dw MetaSprites27Set04Frame3 ; entry 3
    dw MetaSprites27Set04Frame4 ; entry 4
    dw MetaSprites27Set04Frame5 ; entry 5

; frame 0 of MetaSprites27Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set04; ends with $80 (E-0147)
MetaSprites27Set04Frame1::
    db $f1, $f6, $00, $00 ; entry 0
    db $f1, $fe, $01, $00 ; entry 1
    db $f9, $f6, $04, $00 ; entry 2
    db $f9, $fe, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set04; ends with $80 (E-0147)
MetaSprites27Set04Frame2::
    db $ef, $f9, $06, $00 ; entry 0
    db $ef, $01, $07, $00 ; entry 1
    db $f7, $f9, $08, $00 ; entry 2
    db $f7, $01, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set04; ends with $80 (E-0147)
MetaSprites27Set04Frame3::
    db $f1, $f7, $06, $00 ; entry 0
    db $f1, $ff, $07, $00 ; entry 1
    db $f9, $f7, $0a, $00 ; entry 2
    db $f9, $ff, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set04; ends with $80 (E-0147)
MetaSprites27Set04Frame5::
    db $f1, $fa, $0c, $00 ; entry 0
    db $f1, $02, $0d, $00 ; entry 1
    db $f9, $02, $04, $20 ; entry 2
    db $f9, $fa, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set05::
    dw MetaSprites27Set05Frame0 ; entry 0
    dw MetaSprites27Set05Frame1 ; entry 1
    dw MetaSprites27Set05Frame2 ; entry 2
    dw MetaSprites27Set05Frame3 ; entry 3
    dw MetaSprites27Set05Frame4 ; entry 4
    dw MetaSprites27Set05Frame5 ; entry 5

; frame 0 of MetaSprites27Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f9, $f8, $01, $00 ; entry 1
    db $f1, $ff, $00, $20 ; entry 2
    db $f9, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set05; ends with $80 (E-0147)
MetaSprites27Set05Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $ff, $02, $20 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set05; ends with $80 (E-0147)
MetaSprites27Set05Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set05; ends with $80 (E-0147)
MetaSprites27Set05Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $ff, $0c, $20 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set05; ends with $80 (E-0147)
MetaSprites27Set05Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $f7, $f8, $0f, $00 ; entry 1
    db $ef, $ff, $0e, $20 ; entry 2
    db $f7, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 6 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set06::
    dw MetaSprites27Set06Frame0 ; entry 0
    dw MetaSprites27Set06Frame1 ; entry 1
    dw MetaSprites27Set06Frame2 ; entry 2
    dw MetaSprites27Set06Frame3 ; entry 3
    dw MetaSprites27Set06Frame4 ; entry 4
    dw MetaSprites27Set06Frame5 ; entry 5

; frame 0 of MetaSprites27Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set06; ends with $80 (E-0147)
MetaSprites27Set06Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set06; ends with $80 (E-0147)
MetaSprites27Set06Frame2::
    db $f1, $01, $06, $00 ; entry 0
    db $f1, $f9, $01, $20 ; entry 1
    db $f9, $f8, $07, $00 ; entry 2
    db $f9, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set06; ends with $80 (E-0147)
MetaSprites27Set06Frame3::
    db $f0, $01, $06, $00 ; entry 0
    db $f0, $f9, $01, $20 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame4::
    db $f0, $f9, $0b, $20 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set06; ends with $80 (E-0147)
MetaSprites27Set06Frame5::
    db $f1, $f9, $0b, $20 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 7 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set07::
    dw MetaSprites27Set07Frame0 ; entry 0
    dw MetaSprites27Set07Frame1 ; entry 1
    dw MetaSprites27Set07Frame2 ; entry 2
    dw MetaSprites27Set07Frame3 ; entry 3
    dw MetaSprites27Set07Frame4 ; entry 4
    dw MetaSprites27Set07Frame5 ; entry 5

; frame 0 of MetaSprites27Set07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set07; ends with $80 (E-0147)
MetaSprites27Set07Frame1::
    db $ee, $f8, $00, $10 ; entry 0
    db $ee, $00, $01, $10 ; entry 1
    db $f6, $f8, $04, $10 ; entry 2
    db $f6, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set07; ends with $80 (E-0147)
MetaSprites27Set07Frame2::
    db $f1, $f8, $06, $10 ; entry 0
    db $f1, $00, $07, $10 ; entry 1
    db $f9, $00, $09, $10 ; entry 2
    db $f9, $f8, $0a, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set07; ends with $80 (E-0147)
MetaSprites27Set07Frame3::
    db $ef, $f8, $06, $10 ; entry 0
    db $ef, $00, $07, $10 ; entry 1
    db $f7, $f8, $08, $10 ; entry 2
    db $f7, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame4::
    db $f8, $f8, $0c, $10 ; entry 0
    db $f8, $00, $0d, $10 ; entry 1
    db $f0, $f8, $06, $10 ; entry 2
    db $f0, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set07; ends with $80 (E-0147)
MetaSprites27Set07Frame5::
    db $f9, $f8, $0e, $10 ; entry 0
    db $f9, $00, $0f, $10 ; entry 1
    db $f1, $f8, $06, $10 ; entry 2
    db $f1, $00, $0b, $10 ; entry 3
    db $80 ; end

; meta-sprite set 8 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set08::
    dw MetaSprites27Set08Frame0 ; entry 0
    dw MetaSprites27Set08Frame1 ; entry 1
    dw MetaSprites27Set08Frame2 ; entry 2
    dw MetaSprites27Set08Frame3 ; entry 3
    dw MetaSprites27Set08Frame4 ; entry 4
    dw MetaSprites27Set08Frame5 ; entry 5

; frame 0 of MetaSprites27Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set08; ends with $80 (E-0147)
MetaSprites27Set08Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set08; ends with $80 (E-0147)
MetaSprites27Set08Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set08; ends with $80 (E-0147)
MetaSprites27Set08Frame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $06, $00 ; entry 2
    db $f1, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set08; ends with $80 (E-0147)
MetaSprites27Set08Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 9 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set09::
    dw MetaSprites27Set09Frame0 ; entry 0
    dw MetaSprites27Set09Frame1 ; entry 1
    dw MetaSprites27Set09Frame2 ; entry 2
    dw MetaSprites27Set09Frame3 ; entry 3
    dw MetaSprites27Set09Frame4 ; entry 4
    dw MetaSprites27Set09Frame5 ; entry 5

; frame 0 of MetaSprites27Set09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set09; ends with $80 (E-0147)
MetaSprites27Set09Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set09; ends with $80 (E-0147)
MetaSprites27Set09Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set09; ends with $80 (E-0147)
MetaSprites27Set09Frame3::
    db $f9, $f8, $0a, $00 ; entry 0
    db $f9, $00, $0b, $00 ; entry 1
    db $f1, $f8, $06, $00 ; entry 2
    db $f1, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $00, $0e, $00 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set09; ends with $80 (E-0147)
MetaSprites27Set09Frame5::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $00, $0f, $00 ; entry 2
    db $f9, $f8, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 10 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set0A::
    dw MetaSprites27Set0AFrame0 ; entry 0
    dw MetaSprites27Set0AFrame1 ; entry 1
    dw MetaSprites27Set0AFrame2 ; entry 2
    dw MetaSprites27Set0AFrame3 ; entry 3
    dw MetaSprites27Set0AFrame4 ; entry 4
    dw MetaSprites27Set0AFrame5 ; entry 5

; frame 0 of MetaSprites27Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set0A; ends with $80 (E-0147)
MetaSprites27Set0AFrame1::
    db $ef, $00, $00, $20 ; entry 0
    db $ef, $f8, $01, $20 ; entry 1
    db $f7, $00, $02, $20 ; entry 2
    db $f7, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set0A; ends with $80 (E-0147)
MetaSprites27Set0AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set0A; ends with $80 (E-0147)
MetaSprites27Set0AFrame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set0A; ends with $80 (E-0147)
MetaSprites27Set0AFrame5::
    db $ef, $00, $0c, $20 ; entry 0
    db $ef, $f8, $0d, $20 ; entry 1
    db $f7, $00, $0e, $20 ; entry 2
    db $f7, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 11 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set0B::
    dw MetaSprites27Set0BFrame0 ; entry 0
    dw MetaSprites27Set0BFrame1 ; entry 1
    dw MetaSprites27Set0BFrame2 ; entry 2
    dw MetaSprites27Set0BFrame3 ; entry 3
    dw MetaSprites27Set0BFrame4 ; entry 4
    dw MetaSprites27Set0BFrame5 ; entry 5

; frame 0 of MetaSprites27Set0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set0B; ends with $80 (E-0147)
MetaSprites27Set0BFrame1::
    db $f8, $ff, $02, $30 ; entry 0
    db $f8, $f7, $03, $30 ; entry 1
    db $f0, $f8, $04, $10 ; entry 2
    db $f0, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set0B; ends with $80 (E-0147)
MetaSprites27Set0BFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f8, $f8, $07, $10 ; entry 1
    db $f0, $00, $01, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set0B; ends with $80 (E-0147)
MetaSprites27Set0BFrame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f8, $f8, $09, $10 ; entry 1
    db $f0, $00, $05, $10 ; entry 2
    db $f8, $00, $02, $30 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame4::
    db $f0, $f7, $0a, $10 ; entry 0
    db $f0, $ff, $0b, $10 ; entry 1
    db $f8, $f7, $0c, $10 ; entry 2
    db $f8, $ff, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set0B; ends with $80 (E-0147)
MetaSprites27Set0BFrame5::
    db $f8, $00, $0c, $30 ; entry 0
    db $f8, $f8, $0d, $30 ; entry 1
    db $f0, $f7, $0e, $10 ; entry 2
    db $f0, $ff, $0f, $10 ; entry 3
    db $80 ; end

; meta-sprite set 12 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set0C::
    dw MetaSprites27Set0CFrame0 ; entry 0
    dw MetaSprites27Set0CFrame1 ; entry 1
    dw MetaSprites27Set0CFrame2 ; entry 2
    dw MetaSprites27Set0CFrame3 ; entry 3
    dw MetaSprites27Set0CFrame4 ; entry 4
    dw MetaSprites27Set0CFrame5 ; entry 5

; frame 0 of MetaSprites27Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set0C; ends with $80 (E-0147)
MetaSprites27Set0CFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set0C; ends with $80 (E-0147)
MetaSprites27Set0CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set0C; ends with $80 (E-0147)
MetaSprites27Set0CFrame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set0C; ends with $80 (E-0147)
MetaSprites27Set0CFrame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $00, $0c, $20 ; entry 2
    db $f9, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 13 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set0D::
    dw MetaSprites27Set0DFrame0 ; entry 0
    dw MetaSprites27Set0DFrame1 ; entry 1
    dw MetaSprites27Set0DFrame2 ; entry 2
    dw MetaSprites27Set0DFrame3 ; entry 3
    dw MetaSprites27Set0DFrame4 ; entry 4
    dw MetaSprites27Set0DFrame5 ; entry 5

; frame 0 of MetaSprites27Set0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set0D; ends with $80 (E-0147)
MetaSprites27Set0DFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set0D; ends with $80 (E-0147)
MetaSprites27Set0DFrame2::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0e, $00 ; entry 1
    db $f0, $00, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set0D; ends with $80 (E-0147)
MetaSprites27Set0DFrame3::
    db $f0, $f8, $0d, $20 ; entry 0
    db $f8, $f8, $0f, $20 ; entry 1
    db $f0, $00, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set0D; ends with $80 (E-0147)
MetaSprites27Set0DFrame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 14 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set0E::
    dw MetaSprites27Set0EFrame0 ; entry 0
    dw MetaSprites27Set0EFrame1 ; entry 1
    dw MetaSprites27Set0EFrame2 ; entry 2
    dw MetaSprites27Set0EFrame3 ; entry 3
    dw MetaSprites27Set0EFrame4 ; entry 4
    dw MetaSprites27Set0EFrame5 ; entry 5

; frame 0 of MetaSprites27Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set0E; ends with $80 (E-0147)
MetaSprites27Set0EFrame1::
    db $f1, $f8, $03, $00 ; entry 0
    db $f1, $00, $04, $00 ; entry 1
    db $f9, $f8, $05, $00 ; entry 2
    db $f9, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set0E; ends with $80 (E-0147)
MetaSprites27Set0EFrame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set0E; ends with $80 (E-0147)
MetaSprites27Set0EFrame3::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame4::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0e, $20 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set0E; ends with $80 (E-0147)
MetaSprites27Set0EFrame5::
    db $f9, $f8, $0f, $00 ; entry 0
    db $f9, $00, $0f, $20 ; entry 1
    db $f1, $f8, $0c, $00 ; entry 2
    db $f1, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set0F::
    dw MetaSprites27Set0FFrame0 ; entry 0
    dw MetaSprites27Set0FFrame1 ; entry 1
    dw MetaSprites27Set0FFrame2 ; entry 2
    dw MetaSprites27Set0FFrame3 ; entry 3
    dw MetaSprites27Set0FFrame4 ; entry 4
    dw MetaSprites27Set0FFrame5 ; entry 5

; frame 0 of MetaSprites27Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set0F; ends with $80 (E-0147)
MetaSprites27Set0FFrame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set0F; ends with $80 (E-0147)
MetaSprites27Set0FFrame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set0F; ends with $80 (E-0147)
MetaSprites27Set0FFrame3::
    db $f9, $f7, $06, $00 ; entry 0
    db $f1, $f7, $04, $00 ; entry 1
    db $f1, $ff, $08, $00 ; entry 2
    db $f9, $ff, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set0F; ends with $80 (E-0147)
MetaSprites27Set0FFrame5::
    db $f1, $f8, $0d, $00 ; entry 0
    db $f1, $00, $0d, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set10::
    dw MetaSprites27Set10Frame0 ; entry 0
    dw MetaSprites27Set10Frame1 ; entry 1
    dw MetaSprites27Set10Frame2 ; entry 2
    dw MetaSprites27Set10Frame3 ; entry 3
    dw MetaSprites27Set10Frame4 ; entry 4
    dw MetaSprites27Set10Frame5 ; entry 5

; frame 0 of MetaSprites27Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set10; ends with $80 (E-0147)
MetaSprites27Set10Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $00, $03, $00 ; entry 2
    db $f9, $f8, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set10; ends with $80 (E-0147)
MetaSprites27Set10Frame2::
    db $f0, $f9, $05, $00 ; entry 0
    db $f0, $01, $06, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set10; ends with $80 (E-0147)
MetaSprites27Set10Frame3::
    db $f9, $f9, $07, $00 ; entry 0
    db $f1, $f9, $05, $00 ; entry 1
    db $f1, $01, $06, $00 ; entry 2
    db $f9, $01, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set10; ends with $80 (E-0147)
MetaSprites27Set10Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set11::
    dw MetaSprites27Set11Frame0 ; entry 0
    dw MetaSprites27Set11Frame1 ; entry 1
    dw MetaSprites27Set11Frame2 ; entry 2
    dw MetaSprites27Set11Frame3 ; entry 3
    dw MetaSprites27Set11Frame4 ; entry 4
    dw MetaSprites27Set11Frame5 ; entry 5

; frame 0 of MetaSprites27Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set11; ends with $80 (E-0147)
MetaSprites27Set11Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set11; ends with $80 (E-0147)
MetaSprites27Set11Frame2::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set11; ends with $80 (E-0147)
MetaSprites27Set11Frame3::
    db $f0, $00, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $f8, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame4::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $0e, $00 ; entry 2
    db $f8, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set11; ends with $80 (E-0147)
MetaSprites27Set11Frame5::
    db $f0, $00, $04, $20 ; entry 0
    db $f0, $f8, $05, $20 ; entry 1
    db $f8, $00, $0f, $00 ; entry 2
    db $f8, $f8, $0c, $00 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set1A::
    dw MetaSprites27Set1AFrame0 ; entry 0
    dw MetaSprites27Set1AFrame1 ; entry 1
    dw MetaSprites27Set1AFrame2 ; entry 2
    dw MetaSprites27Set1AFrame3 ; entry 3
    dw MetaSprites27Set1AFrame4 ; entry 4
    dw MetaSprites27Set1AFrame5 ; entry 5

; frame 0 of MetaSprites27Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set1A; ends with $80 (E-0147)
MetaSprites27Set1AFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set1A; ends with $80 (E-0147)
MetaSprites27Set1AFrame2::
    db $ef, $f8, $05, $00 ; entry 0
    db $ef, $00, $06, $00 ; entry 1
    db $f7, $f8, $07, $00 ; entry 2
    db $f7, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set1A; ends with $80 (E-0147)
MetaSprites27Set1AFrame3::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set1A; ends with $80 (E-0147)
MetaSprites27Set1AFrame5::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $00, $0b, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set1B::
    dw MetaSprites27Set1BFrame0 ; entry 0
    dw MetaSprites27Set1BFrame1 ; entry 1
    dw MetaSprites27Set1BFrame2 ; entry 2
    dw MetaSprites27Set1BFrame3 ; entry 3
    dw MetaSprites27Set1BFrame4 ; entry 4
    dw MetaSprites27Set1BFrame5 ; entry 5

; frame 0 of MetaSprites27Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set1B; ends with $80 (E-0147)
MetaSprites27Set1BFrame1::
    db $f9, $00, $02, $20 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $00, $00, $20 ; entry 2
    db $f1, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set1B; ends with $80 (E-0147)
MetaSprites27Set1BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set1B; ends with $80 (E-0147)
MetaSprites27Set1BFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set1B; ends with $80 (E-0147)
MetaSprites27Set1BFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 28 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set1C::
    dw MetaSprites27Set1CFrame0 ; entry 0
    dw MetaSprites27Set1CFrame1 ; entry 1
    dw MetaSprites27Set1CFrame2 ; entry 2
    dw MetaSprites27Set1CFrame3 ; entry 3
    dw MetaSprites27Set1CFrame4 ; entry 4
    dw MetaSprites27Set1CFrame5 ; entry 5

; frame 0 of MetaSprites27Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set1C; ends with $80 (E-0147)
MetaSprites27Set1CFrame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $f7, $f8, $03, $00 ; entry 1
    db $ef, $ff, $02, $20 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set1C; ends with $80 (E-0147)
MetaSprites27Set1CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set1C; ends with $80 (E-0147)
MetaSprites27Set1CFrame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set1C; ends with $80 (E-0147)
MetaSprites27Set1CFrame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $f7, $f8, $0f, $00 ; entry 1
    db $ef, $ff, $0e, $20 ; entry 2
    db $f7, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 29 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set1D::
    dw MetaSprites27Set1DFrame0 ; entry 0
    dw MetaSprites27Set1DFrame1 ; entry 1
    dw MetaSprites27Set1DFrame2 ; entry 2
    dw MetaSprites27Set1DFrame3 ; entry 3
    dw MetaSprites27Set1DFrame4 ; entry 4
    dw MetaSprites27Set1DFrame5 ; entry 5

; frame 0 of MetaSprites27Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $ff, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $ff, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set1D; ends with $80 (E-0147)
MetaSprites27Set1DFrame1::
    db $f1, $f8, $02, $10 ; entry 0
    db $f1, $ff, $02, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $ff, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set1D; ends with $80 (E-0147)
MetaSprites27Set1DFrame2::
    db $ef, $f8, $04, $10 ; entry 0
    db $ef, $00, $05, $10 ; entry 1
    db $f7, $f8, $06, $10 ; entry 2
    db $f7, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set1D; ends with $80 (E-0147)
MetaSprites27Set1DFrame3::
    db $f8, $f8, $06, $10 ; entry 0
    db $f8, $00, $07, $10 ; entry 1
    db $f0, $f8, $08, $10 ; entry 2
    db $f0, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame4::
    db $f0, $f8, $09, $10 ; entry 0
    db $f0, $ff, $09, $30 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $ff, $0a, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set1D; ends with $80 (E-0147)
MetaSprites27Set1DFrame5::
    db $f1, $f8, $0b, $10 ; entry 0
    db $f1, $ff, $0b, $30 ; entry 1
    db $f9, $f8, $0c, $10 ; entry 2
    db $f9, $ff, $0c, $30 ; entry 3
    db $80 ; end

; meta-sprite set 30 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set1E::
    dw MetaSprites27Set1EFrame0 ; entry 0
    dw MetaSprites27Set1EFrame1 ; entry 1
    dw MetaSprites27Set1EFrame2 ; entry 2
    dw MetaSprites27Set1EFrame3 ; entry 3
    dw MetaSprites27Set1EFrame4 ; entry 4
    dw MetaSprites27Set1EFrame5 ; entry 5

; frame 0 of MetaSprites27Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set1E; ends with $80 (E-0147)
MetaSprites27Set1EFrame1::
    db $f9, $00, $02, $20 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $00, $00, $20 ; entry 2
    db $f1, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set1E; ends with $80 (E-0147)
MetaSprites27Set1EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set1E; ends with $80 (E-0147)
MetaSprites27Set1EFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set1E; ends with $80 (E-0147)
MetaSprites27Set1EFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 31 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set1F::
    dw MetaSprites27Set1FFrame0 ; entry 0
    dw MetaSprites27Set1FFrame1 ; entry 1
    dw MetaSprites27Set1FFrame2 ; entry 2
    dw MetaSprites27Set1FFrame3 ; entry 3
    dw MetaSprites27Set1FFrame4 ; entry 4
    dw MetaSprites27Set1FFrame5 ; entry 5

; frame 0 of MetaSprites27Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set1F; ends with $80 (E-0147)
MetaSprites27Set1FFrame1::
    db $ef, $f8, $00, $10 ; entry 0
    db $ef, $00, $00, $30 ; entry 1
    db $f7, $00, $01, $30 ; entry 2
    db $f7, $f8, $02, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set1F; ends with $80 (E-0147)
MetaSprites27Set1FFrame2::
    db $ef, $f8, $03, $10 ; entry 0
    db $ef, $00, $04, $10 ; entry 1
    db $f7, $f8, $05, $10 ; entry 2
    db $f7, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set1F; ends with $80 (E-0147)
MetaSprites27Set1FFrame3::
    db $f0, $f8, $03, $10 ; entry 0
    db $f8, $f8, $08, $10 ; entry 1
    db $f8, $00, $09, $10 ; entry 2
    db $f0, $00, $04, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0a, $30 ; entry 1
    db $f8, $f8, $0b, $10 ; entry 2
    db $f8, $00, $0c, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set1F; ends with $80 (E-0147)
MetaSprites27Set1FFrame5::
    db $ef, $f8, $0a, $10 ; entry 0
    db $ef, $00, $0a, $30 ; entry 1
    db $f7, $00, $0b, $30 ; entry 2
    db $f7, $f8, $0c, $30 ; entry 3
    db $80 ; end

; meta-sprite set 32 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set20::
    dw MetaSprites27Set20Frame0 ; entry 0
    dw MetaSprites27Set20Frame1 ; entry 1
    dw MetaSprites27Set20Frame2 ; entry 2
    dw MetaSprites27Set20Frame3 ; entry 3
    dw MetaSprites27Set20Frame4 ; entry 4
    dw MetaSprites27Set20Frame5 ; entry 5

; frame 0 of MetaSprites27Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set20; ends with $80 (E-0147)
MetaSprites27Set20Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $00, $04, $00 ; entry 2
    db $f8, $f8, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set20; ends with $80 (E-0147)
MetaSprites27Set20Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set20; ends with $80 (E-0147)
MetaSprites27Set20Frame3::
    db $f0, $00, $07, $00 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f8, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set20; ends with $80 (E-0147)
MetaSprites27Set20Frame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; meta-sprite set 33 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set21::
    dw MetaSprites27Set21Frame0 ; entry 0
    dw MetaSprites27Set21Frame1 ; entry 1
    dw MetaSprites27Set21Frame2 ; entry 2
    dw MetaSprites27Set21Frame3 ; entry 3
    dw MetaSprites27Set21Frame4 ; entry 4
    dw MetaSprites27Set21Frame5 ; entry 5

; frame 0 of MetaSprites27Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set21; ends with $80 (E-0147)
MetaSprites27Set21Frame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set21; ends with $80 (E-0147)
MetaSprites27Set21Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set21; ends with $80 (E-0147)
MetaSprites27Set21Frame3::
    db $f8, $f8, $07, $00 ; entry 0
    db $f8, $00, $08, $00 ; entry 1
    db $f0, $f8, $03, $00 ; entry 2
    db $f0, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set21; ends with $80 (E-0147)
MetaSprites27Set21Frame5::
    db $f0, $ff, $09, $20 ; entry 0
    db $f0, $f8, $09, $00 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 34 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set22::
    dw MetaSprites27Set22Frame0 ; entry 0
    dw MetaSprites27Set22Frame1 ; entry 1
    dw MetaSprites27Set22Frame2 ; entry 2
    dw MetaSprites27Set22Frame3 ; entry 3
    dw MetaSprites27Set22Frame4 ; entry 4
    dw MetaSprites27Set22Frame5 ; entry 5

; frame 0 of MetaSprites27Set22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set22; ends with $80 (E-0147)
MetaSprites27Set22Frame1::
    db $f1, $f8, $03, $00 ; entry 0
    db $f1, $00, $04, $00 ; entry 1
    db $f9, $f8, $05, $00 ; entry 2
    db $f9, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set22; ends with $80 (E-0147)
MetaSprites27Set22Frame2::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $08, $20 ; entry 1
    db $f0, $f8, $06, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set22; ends with $80 (E-0147)
MetaSprites27Set22Frame3::
    db $f1, $f8, $09, $00 ; entry 0
    db $f1, $00, $0a, $00 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame4::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $08, $20 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set22; ends with $80 (E-0147)
MetaSprites27Set22Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $00, $0f, $00 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 35 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set23::
    dw MetaSprites27Set23Frame0 ; entry 0
    dw MetaSprites27Set23Frame1 ; entry 1
    dw MetaSprites27Set23Frame2 ; entry 2
    dw MetaSprites27Set23Frame3 ; entry 3
    dw MetaSprites27Set23Frame4 ; entry 4
    dw MetaSprites27Set23Frame5 ; entry 5

; frame 0 of MetaSprites27Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $00, $30 ; entry 1
    db $f9, $f8, $01, $10 ; entry 2
    db $f9, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set23; ends with $80 (E-0147)
MetaSprites27Set23Frame1::
    db $f8, $f8, $01, $10 ; entry 0
    db $f8, $00, $01, $30 ; entry 1
    db $f0, $f8, $02, $10 ; entry 2
    db $f0, $00, $02, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set23; ends with $80 (E-0147)
MetaSprites27Set23Frame2::
    db $f1, $f8, $03, $10 ; entry 0
    db $f1, $00, $04, $10 ; entry 1
    db $f9, $f8, $05, $10 ; entry 2
    db $f9, $00, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set23; ends with $80 (E-0147)
MetaSprites27Set23Frame3::
    db $f8, $f8, $05, $10 ; entry 0
    db $f8, $00, $06, $10 ; entry 1
    db $f0, $00, $07, $10 ; entry 2
    db $f0, $f8, $03, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame4::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $08, $30 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $09, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set23; ends with $80 (E-0147)
MetaSprites27Set23Frame5::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $08, $30 ; entry 1
    db $f8, $f8, $09, $10 ; entry 2
    db $f8, $00, $09, $30 ; entry 3
    db $80 ; end

; meta-sprite set 36 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set24::
    dw MetaSprites27Set24Frame0 ; entry 0
    dw MetaSprites27Set24Frame1 ; entry 1
    dw MetaSprites27Set24Frame2 ; entry 2
    dw MetaSprites27Set24Frame3 ; entry 3
    dw MetaSprites27Set24Frame4 ; entry 4
    dw MetaSprites27Set24Frame5 ; entry 5

; frame 0 of MetaSprites27Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set24; ends with $80 (E-0147)
MetaSprites27Set24Frame1::
    db $f8, $00, $01, $20 ; entry 0
    db $f8, $f8, $02, $20 ; entry 1
    db $f0, $f9, $03, $00 ; entry 2
    db $f0, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set24; ends with $80 (E-0147)
MetaSprites27Set24Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set24; ends with $80 (E-0147)
MetaSprites27Set24Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set24; ends with $80 (E-0147)
MetaSprites27Set24Frame5::
    db $f8, $00, $0d, $20 ; entry 0
    db $f8, $f8, $0e, $20 ; entry 1
    db $f0, $00, $0f, $20 ; entry 2
    db $f0, $f9, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set25::
    dw MetaSprites27Set25Frame0 ; entry 0
    dw MetaSprites27Set25Frame1 ; entry 1
    dw MetaSprites27Set25Frame2 ; entry 2
    dw MetaSprites27Set25Frame3 ; entry 3
    dw MetaSprites27Set25Frame4 ; entry 4
    dw MetaSprites27Set25Frame5 ; entry 5

; frame 0 of MetaSprites27Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $ff, $00, $30 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set25; ends with $80 (E-0147)
MetaSprites27Set25Frame1::
    db $f0, $f9, $01, $10 ; entry 0
    db $f0, $00, $01, $30 ; entry 1
    db $f8, $f9, $04, $10 ; entry 2
    db $f8, $01, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set25; ends with $80 (E-0147)
MetaSprites27Set25Frame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set25; ends with $80 (E-0147)
MetaSprites27Set25Frame3::
    db $f0, $00, $07, $10 ; entry 0
    db $f0, $f8, $0a, $10 ; entry 1
    db $f8, $f8, $0b, $10 ; entry 2
    db $f8, $00, $0c, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame4::
    db $f0, $f8, $0d, $10 ; entry 0
    db $f0, $ff, $0d, $30 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set25; ends with $80 (E-0147)
MetaSprites27Set25Frame5::
    db $f8, $00, $0e, $30 ; entry 0
    db $f8, $f8, $0f, $30 ; entry 1
    db $f0, $f9, $0d, $10 ; entry 2
    db $f0, $00, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 38 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set26::
    dw MetaSprites27Set26Frame0 ; entry 0
    dw MetaSprites27Set26Frame1 ; entry 1
    dw MetaSprites27Set26Frame2 ; entry 2
    dw MetaSprites27Set26Frame3 ; entry 3
    dw MetaSprites27Set26Frame4 ; entry 4
    dw MetaSprites27Set26Frame5 ; entry 5

; frame 0 of MetaSprites27Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set26; ends with $80 (E-0147)
MetaSprites27Set26Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set26; ends with $80 (E-0147)
MetaSprites27Set26Frame2::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set26; ends with $80 (E-0147)
MetaSprites27Set26Frame3::
    db $ef, $f9, $04, $00 ; entry 0
    db $ef, $01, $05, $00 ; entry 1
    db $f7, $f9, $06, $00 ; entry 2
    db $f7, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame4::
    db $f2, $f8, $0c, $00 ; entry 0
    db $f2, $00, $0c, $20 ; entry 1
    db $fa, $f8, $0d, $00 ; entry 2
    db $fa, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set26; ends with $80 (E-0147)
MetaSprites27Set26Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $ef, $00, $0e, $20 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 39 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set27::
    dw MetaSprites27Set27Frame0 ; entry 0
    dw MetaSprites27Set27Frame1 ; entry 1
    dw MetaSprites27Set27Frame2 ; entry 2
    dw MetaSprites27Set27Frame3 ; entry 3
    dw MetaSprites27Set27Frame4 ; entry 4
    dw MetaSprites27Set27Frame5 ; entry 5

; frame 0 of MetaSprites27Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set27; ends with $80 (E-0147)
MetaSprites27Set27Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set27; ends with $80 (E-0147)
MetaSprites27Set27Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set27; ends with $80 (E-0147)
MetaSprites27Set27Frame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set27; ends with $80 (E-0147)
MetaSprites27Set27Frame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 40 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set28::
    dw MetaSprites27Set28Frame0 ; entry 0
    dw MetaSprites27Set28Frame1 ; entry 1
    dw MetaSprites27Set28Frame2 ; entry 2
    dw MetaSprites27Set28Frame3 ; entry 3
    dw MetaSprites27Set28Frame4 ; entry 4
    dw MetaSprites27Set28Frame5 ; entry 5

; frame 0 of MetaSprites27Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame0::
    db $f0, $f7, $00, $10 ; entry 0
    db $f0, $ff, $01, $10 ; entry 1
    db $f8, $f7, $03, $10 ; entry 2
    db $f8, $ff, $04, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set28; ends with $80 (E-0147)
MetaSprites27Set28Frame1::
    db $f0, $ff, $01, $10 ; entry 0
    db $f0, $f7, $02, $10 ; entry 1
    db $f8, $f7, $05, $10 ; entry 2
    db $f8, $ff, $06, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set28; ends with $80 (E-0147)
MetaSprites27Set28Frame2::
    db $f0, $f9, $07, $10 ; entry 0
    db $f0, $01, $08, $10 ; entry 1
    db $f8, $f9, $09, $10 ; entry 2
    db $f8, $01, $0a, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set28; ends with $80 (E-0147)
MetaSprites27Set28Frame3::
    db $f0, $f9, $07, $10 ; entry 0
    db $f0, $01, $08, $10 ; entry 1
    db $f8, $f9, $0b, $10 ; entry 2
    db $f8, $01, $0c, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame4::
    db $f0, $fa, $0d, $10 ; entry 0
    db $f0, $02, $0e, $10 ; entry 1
    db $f8, $02, $05, $30 ; entry 2
    db $f8, $fa, $06, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set28; ends with $80 (E-0147)
MetaSprites27Set28Frame5::
    db $f0, $fa, $0d, $10 ; entry 0
    db $f0, $02, $0f, $10 ; entry 1
    db $f8, $02, $03, $30 ; entry 2
    db $f8, $fa, $04, $30 ; entry 3
    db $80 ; end

; meta-sprite set 41 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set29::
    dw MetaSprites27Set29Frame0 ; entry 0
    dw MetaSprites27Set29Frame1 ; entry 1
    dw MetaSprites27Set29Frame2 ; entry 2
    dw MetaSprites27Set29Frame3 ; entry 3
    dw MetaSprites27Set29Frame4 ; entry 4
    dw MetaSprites27Set29Frame5 ; entry 5

; frame 0 of MetaSprites27Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set29; ends with $80 (E-0147)
MetaSprites27Set29Frame1::
    db $f8, $00, $02, $20 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set29; ends with $80 (E-0147)
MetaSprites27Set29Frame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set29; ends with $80 (E-0147)
MetaSprites27Set29Frame3::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame4::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0f, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set29; ends with $80 (E-0147)
MetaSprites27Set29Frame5::
    db $f1, $00, $0e, $20 ; entry 0
    db $f1, $f8, $0f, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; meta-sprite set 42 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set2A::
    dw MetaSprites27Set2AFrame0 ; entry 0
    dw MetaSprites27Set2AFrame1 ; entry 1
    dw MetaSprites27Set2AFrame2 ; entry 2
    dw MetaSprites27Set2AFrame3 ; entry 3
    dw MetaSprites27Set2AFrame4 ; entry 4
    dw MetaSprites27Set2AFrame5 ; entry 5

; frame 0 of MetaSprites27Set2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set2A; ends with $80 (E-0147)
MetaSprites27Set2AFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set2A; ends with $80 (E-0147)
MetaSprites27Set2AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set2A; ends with $80 (E-0147)
MetaSprites27Set2AFrame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set2A; ends with $80 (E-0147)
MetaSprites27Set2AFrame5::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 43 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set2B::
    dw MetaSprites27Set2BFrame0 ; entry 0
    dw MetaSprites27Set2BFrame1 ; entry 1
    dw MetaSprites27Set2BFrame2 ; entry 2
    dw MetaSprites27Set2BFrame3 ; entry 3
    dw MetaSprites27Set2BFrame4 ; entry 4
    dw MetaSprites27Set2BFrame5 ; entry 5

; frame 0 of MetaSprites27Set2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set2B; ends with $80 (E-0147)
MetaSprites27Set2BFrame1::
    db $f1, $f8, $02, $10 ; entry 0
    db $f1, $00, $02, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set2B; ends with $80 (E-0147)
MetaSprites27Set2BFrame2::
    db $ef, $f8, $04, $10 ; entry 0
    db $ef, $00, $05, $10 ; entry 1
    db $f7, $f8, $06, $10 ; entry 2
    db $f7, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set2B; ends with $80 (E-0147)
MetaSprites27Set2BFrame3::
    db $f0, $00, $04, $30 ; entry 0
    db $f0, $f8, $05, $30 ; entry 1
    db $f8, $00, $06, $30 ; entry 2
    db $f8, $f8, $07, $30 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame4::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $08, $30 ; entry 1
    db $f8, $f8, $09, $10 ; entry 2
    db $f8, $00, $09, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set2B; ends with $80 (E-0147)
MetaSprites27Set2BFrame5::
    db $f1, $f8, $0a, $10 ; entry 0
    db $f1, $00, $0a, $30 ; entry 1
    db $f9, $f8, $0b, $10 ; entry 2
    db $f9, $00, $0b, $30 ; entry 3
    db $80 ; end

; meta-sprite set 44 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set2C::
    dw MetaSprites27Set2CFrame0 ; entry 0
    dw MetaSprites27Set2CFrame1 ; entry 1
    dw MetaSprites27Set2CFrame2 ; entry 2
    dw MetaSprites27Set2CFrame3 ; entry 3
    dw MetaSprites27Set2CFrame4 ; entry 4
    dw MetaSprites27Set2CFrame5 ; entry 5

; frame 0 of MetaSprites27Set2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame0::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $02, $10 ; entry 2
    db $f9, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set2C; ends with $80 (E-0147)
MetaSprites27Set2CFrame1::
    db $f0, $00, $00, $30 ; entry 0
    db $f0, $f8, $01, $30 ; entry 1
    db $f8, $00, $02, $30 ; entry 2
    db $f8, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set2C; ends with $80 (E-0147)
MetaSprites27Set2CFrame2::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $06, $10 ; entry 2
    db $f9, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set2C; ends with $80 (E-0147)
MetaSprites27Set2CFrame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame4::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0d, $10 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set2C; ends with $80 (E-0147)
MetaSprites27Set2CFrame5::
    db $f8, $00, $0e, $30 ; entry 0
    db $f8, $f8, $0f, $30 ; entry 1
    db $f0, $00, $0c, $30 ; entry 2
    db $f0, $f8, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 45 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set2D::
    dw MetaSprites27Set2DFrame0 ; entry 0
    dw MetaSprites27Set2DFrame1 ; entry 1
    dw MetaSprites27Set2DFrame2 ; entry 2
    dw MetaSprites27Set2DFrame3 ; entry 3
    dw MetaSprites27Set2DFrame4 ; entry 4
    dw MetaSprites27Set2DFrame5 ; entry 5

; frame 0 of MetaSprites27Set2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame0::
    db $f2, $00, $01, $10 ; entry 0
    db $fa, $00, $02, $10 ; entry 1
    db $f5, $f8, $00, $10 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites27Set2D; ends with $80 (E-0147)
MetaSprites27Set2DFrame1::
    db $f0, $f8, $03, $10 ; entry 0
    db $f8, $f8, $04, $10 ; entry 1
    db $f9, $00, $05, $10 ; entry 2
    db $f1, $00, $01, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set2D; ends with $80 (E-0147)
MetaSprites27Set2DFrame2::
    db $f8, $f8, $06, $10 ; entry 0
    db $f8, $00, $07, $10 ; entry 1
    db $f0, $f9, $08, $10 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites27Set2D; ends with $80 (E-0147)
MetaSprites27Set2DFrame3::
    db $f8, $f8, $0b, $10 ; entry 0
    db $f8, $00, $0c, $10 ; entry 1
    db $f0, $f8, $09, $10 ; entry 2
    db $f0, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame4::
    db $f0, $00, $03, $30 ; entry 0
    db $f0, $f8, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set2D; ends with $80 (E-0147)
MetaSprites27Set2DFrame5::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $00, $0d, $30 ; entry 1
    db $f8, $00, $0e, $30 ; entry 2
    db $f8, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 46 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set2E::
    dw MetaSprites27Set2EFrame0 ; entry 0
    dw MetaSprites27Set2EFrame1 ; entry 1
    dw MetaSprites27Set2EFrame2 ; entry 2
    dw MetaSprites27Set2EFrame3 ; entry 3
    dw MetaSprites27Set2EFrame4 ; entry 4
    dw MetaSprites27Set2EFrame5 ; entry 5

; frame 0 of MetaSprites27Set2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame0::
    db $f2, $00, $01, $10 ; entry 0
    db $fa, $00, $02, $10 ; entry 1
    db $f5, $f8, $00, $10 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites27Set2E; ends with $80 (E-0147)
MetaSprites27Set2EFrame1::
    db $f0, $f8, $03, $10 ; entry 0
    db $f8, $f8, $04, $10 ; entry 1
    db $f9, $00, $05, $10 ; entry 2
    db $f1, $00, $01, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set2E; ends with $80 (E-0147)
MetaSprites27Set2EFrame2::
    db $f8, $f8, $06, $10 ; entry 0
    db $f8, $00, $07, $10 ; entry 1
    db $f0, $f9, $08, $10 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites27Set2E; ends with $80 (E-0147)
MetaSprites27Set2EFrame3::
    db $f8, $f8, $0b, $10 ; entry 0
    db $f8, $00, $0c, $10 ; entry 1
    db $f0, $f8, $09, $10 ; entry 2
    db $f0, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame4::
    db $f0, $00, $03, $30 ; entry 0
    db $f0, $f8, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set2E; ends with $80 (E-0147)
MetaSprites27Set2EFrame5::
    db $f0, $f8, $03, $10 ; entry 0
    db $f0, $00, $0d, $30 ; entry 1
    db $f8, $00, $0e, $30 ; entry 2
    db $f8, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 47 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set2F::
    dw MetaSprites27Set2FFrame0 ; entry 0
    dw MetaSprites27Set2FFrame1 ; entry 1
    dw MetaSprites27Set2FFrame2 ; entry 2
    dw MetaSprites27Set2FFrame3 ; entry 3
    dw MetaSprites27Set2FFrame4 ; entry 4
    dw MetaSprites27Set2FFrame5 ; entry 5

; frame 0 of MetaSprites27Set2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set2F; ends with $80 (E-0147)
MetaSprites27Set2FFrame1::
    db $f0, $f8, $02, $10 ; entry 0
    db $f0, $00, $02, $30 ; entry 1
    db $f8, $f8, $03, $10 ; entry 2
    db $f8, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set2F; ends with $80 (E-0147)
MetaSprites27Set2FFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set2F; ends with $80 (E-0147)
MetaSprites27Set2FFrame3::
    db $ef, $f8, $08, $10 ; entry 0
    db $ef, $00, $09, $10 ; entry 1
    db $f7, $00, $0a, $10 ; entry 2
    db $f7, $f8, $06, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame4::
    db $f0, $00, $00, $30 ; entry 0
    db $f0, $f8, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0c, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set2F; ends with $80 (E-0147)
MetaSprites27Set2FFrame5::
    db $f7, $f8, $0c, $10 ; entry 0
    db $f7, $00, $0c, $30 ; entry 1
    db $ef, $f8, $0d, $10 ; entry 2
    db $ef, $00, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 48 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set30::
    dw MetaSprites27Set30Frame0 ; entry 0
    dw MetaSprites27Set30Frame1 ; entry 1
    dw MetaSprites27Set30Frame2 ; entry 2
    dw MetaSprites27Set30Frame3 ; entry 3
    dw MetaSprites27Set30Frame4 ; entry 4
    dw MetaSprites27Set30Frame5 ; entry 5

; frame 0 of MetaSprites27Set30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set30; ends with $80 (E-0147)
MetaSprites27Set30Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set30; ends with $80 (E-0147)
MetaSprites27Set30Frame2::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set30; ends with $80 (E-0147)
MetaSprites27Set30Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set30; ends with $80 (E-0147)
MetaSprites27Set30Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 49 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set31::
    dw MetaSprites27Set31Frame0 ; entry 0
    dw MetaSprites27Set31Frame1 ; entry 1
    dw MetaSprites27Set31Frame2 ; entry 2
    dw MetaSprites27Set31Frame3 ; entry 3
    dw MetaSprites27Set31Frame4 ; entry 4
    dw MetaSprites27Set31Frame5 ; entry 5

; frame 0 of MetaSprites27Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set31; ends with $80 (E-0147)
MetaSprites27Set31Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set31; ends with $80 (E-0147)
MetaSprites27Set31Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set31; ends with $80 (E-0147)
MetaSprites27Set31Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set31; ends with $80 (E-0147)
MetaSprites27Set31Frame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 50 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set32::
    dw MetaSprites27Set32Frame0 ; entry 0
    dw MetaSprites27Set32Frame1 ; entry 1
    dw MetaSprites27Set32Frame2 ; entry 2
    dw MetaSprites27Set32Frame3 ; entry 3
    dw MetaSprites27Set32Frame4 ; entry 4
    dw MetaSprites27Set32Frame5 ; entry 5

; frame 0 of MetaSprites27Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set32; ends with $80 (E-0147)
MetaSprites27Set32Frame1::
    db $f0, $01, $00, $30 ; entry 0
    db $f0, $f9, $01, $30 ; entry 1
    db $f8, $01, $02, $30 ; entry 2
    db $f8, $f9, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set32; ends with $80 (E-0147)
MetaSprites27Set32Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set32; ends with $80 (E-0147)
MetaSprites27Set32Frame3::
    db $f0, $f8, $08, $10 ; entry 0
    db $f0, $00, $09, $10 ; entry 1
    db $f8, $f8, $0a, $10 ; entry 2
    db $f8, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set32; ends with $80 (E-0147)
MetaSprites27Set32Frame5::
    db $f0, $01, $0c, $30 ; entry 0
    db $f0, $f9, $0d, $30 ; entry 1
    db $f8, $01, $0e, $30 ; entry 2
    db $f8, $f9, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 51 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set33::
    dw MetaSprites27Set33Frame0 ; entry 0
    dw MetaSprites27Set33Frame1 ; entry 1
    dw MetaSprites27Set33Frame2 ; entry 2
    dw MetaSprites27Set33Frame3 ; entry 3
    dw MetaSprites27Set33Frame4 ; entry 4
    dw MetaSprites27Set33Frame5 ; entry 5

; frame 0 of MetaSprites27Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set33; ends with $80 (E-0147)
MetaSprites27Set33Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set33; ends with $80 (E-0147)
MetaSprites27Set33Frame2::
    db $f0, $f9, $06, $00 ; entry 0
    db $f0, $01, $07, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set33; ends with $80 (E-0147)
MetaSprites27Set33Frame3::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f7, $08, $00 ; entry 2
    db $f0, $ff, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set33; ends with $80 (E-0147)
MetaSprites27Set33Frame5::
    db $f0, $00, $0a, $20 ; entry 0
    db $f0, $f8, $0b, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 52 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set34::
    dw MetaSprites27Set34Frame0 ; entry 0
    dw MetaSprites27Set34Frame1 ; entry 1
    dw MetaSprites27Set34Frame2 ; entry 2
    dw MetaSprites27Set34Frame3 ; entry 3
    dw MetaSprites27Set34Frame4 ; entry 4
    dw MetaSprites27Set34Frame5 ; entry 5

; frame 0 of MetaSprites27Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame0::
    db $f0, $f8, $00, $30 ; entry 0
    db $f0, $ff, $00, $10 ; entry 1
    db $f8, $fa, $01, $10 ; entry 2
    db $f8, $02, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set34; ends with $80 (E-0147)
MetaSprites27Set34Frame1::
    db $f0, $f9, $00, $30 ; entry 0
    db $f0, $00, $00, $10 ; entry 1
    db $f8, $fe, $01, $30 ; entry 2
    db $f8, $f6, $02, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set34; ends with $80 (E-0147)
MetaSprites27Set34Frame2::
    db $f0, $f9, $00, $30 ; entry 0
    db $f0, $ff, $00, $10 ; entry 1
    db $f8, $fa, $05, $10 ; entry 2
    db $f8, $02, $06, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set34; ends with $80 (E-0147)
MetaSprites27Set34Frame3::
    db $f0, $00, $00, $10 ; entry 0
    db $f0, $fa, $00, $30 ; entry 1
    db $f8, $fb, $07, $10 ; entry 2
    db $f8, $03, $08, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame4::
    db $f0, $f8, $00, $30 ; entry 0
    db $f0, $ff, $00, $10 ; entry 1
    db $f8, $f8, $03, $10 ; entry 2
    db $f8, $00, $04, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set34; ends with $80 (E-0147)
MetaSprites27Set34Frame5::
    db $f0, $00, $00, $10 ; entry 0
    db $f0, $f9, $00, $30 ; entry 1
    db $f8, $00, $03, $30 ; entry 2
    db $f8, $f8, $04, $30 ; entry 3
    db $80 ; end

; meta-sprite set 53 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set35::
    dw MetaSprites27Set35Frame0 ; entry 0
    dw MetaSprites27Set35Frame1 ; entry 1
    dw MetaSprites27Set35Frame2 ; entry 2
    dw MetaSprites27Set35Frame3 ; entry 3
    dw MetaSprites27Set35Frame4 ; entry 4
    dw MetaSprites27Set35Frame5 ; entry 5

; frame 0 of MetaSprites27Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set35; ends with $80 (E-0147)
MetaSprites27Set35Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set35; ends with $80 (E-0147)
MetaSprites27Set35Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set35; ends with $80 (E-0147)
MetaSprites27Set35Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set35; ends with $80 (E-0147)
MetaSprites27Set35Frame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 54 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set36::
    dw MetaSprites27Set36Frame0 ; entry 0
    dw MetaSprites27Set36Frame1 ; entry 1
    dw MetaSprites27Set36Frame2 ; entry 2
    dw MetaSprites27Set36Frame3 ; entry 3
    dw MetaSprites27Set36Frame4 ; entry 4
    dw MetaSprites27Set36Frame5 ; entry 5

; frame 0 of MetaSprites27Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set36; ends with $80 (E-0147)
MetaSprites27Set36Frame1::
    db $f7, $f8, $00, $50 ; entry 0
    db $f7, $00, $00, $70 ; entry 1
    db $ef, $f8, $01, $50 ; entry 2
    db $ef, $00, $01, $70 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set36; ends with $80 (E-0147)
MetaSprites27Set36Frame2::
    db $f0, $f8, $02, $10 ; entry 0
    db $f0, $00, $03, $10 ; entry 1
    db $f8, $f8, $04, $10 ; entry 2
    db $f8, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set36; ends with $80 (E-0147)
MetaSprites27Set36Frame3::
    db $f7, $f8, $02, $50 ; entry 0
    db $f7, $00, $03, $50 ; entry 1
    db $ef, $f8, $04, $50 ; entry 2
    db $ef, $00, $05, $50 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame4::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $06, $30 ; entry 1
    db $f8, $f8, $07, $10 ; entry 2
    db $f8, $00, $07, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set36; ends with $80 (E-0147)
MetaSprites27Set36Frame5::
    db $f7, $f8, $06, $50 ; entry 0
    db $f7, $00, $06, $70 ; entry 1
    db $ef, $f8, $07, $50 ; entry 2
    db $ef, $00, $07, $70 ; entry 3
    db $80 ; end

; meta-sprite set 55 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set37::
    dw MetaSprites27Set37Frame0 ; entry 0
    dw MetaSprites27Set37Frame1 ; entry 1
    dw MetaSprites27Set37Frame2 ; entry 2
    dw MetaSprites27Set37Frame3 ; entry 3
    dw MetaSprites27Set37Frame4 ; entry 4
    dw MetaSprites27Set37Frame5 ; entry 5

; frame 0 of MetaSprites27Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set37; ends with $80 (E-0147)
MetaSprites27Set37Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $01, $02, $20 ; entry 2
    db $f9, $f9, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set37; ends with $80 (E-0147)
MetaSprites27Set37Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set37; ends with $80 (E-0147)
MetaSprites27Set37Frame3::
    db $f9, $f8, $08, $00 ; entry 0
    db $f9, $00, $09, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set37; ends with $80 (E-0147)
MetaSprites27Set37Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $ff, $0c, $20 ; entry 2
    db $f9, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 56 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set38::
    dw MetaSprites27Set38Frame0 ; entry 0
    dw MetaSprites27Set38Frame1 ; entry 1
    dw MetaSprites27Set38Frame2 ; entry 2
    dw MetaSprites27Set38Frame3 ; entry 3
    dw MetaSprites27Set38Frame4 ; entry 4
    dw MetaSprites27Set38Frame5 ; entry 5

; frame 0 of MetaSprites27Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set38; ends with $80 (E-0147)
MetaSprites27Set38Frame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set38; ends with $80 (E-0147)
MetaSprites27Set38Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set38; ends with $80 (E-0147)
MetaSprites27Set38Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set38; ends with $80 (E-0147)
MetaSprites27Set38Frame5::
    db $f1, $ff, $0c, $20 ; entry 0
    db $f1, $f7, $0d, $20 ; entry 1
    db $f9, $ff, $0e, $20 ; entry 2
    db $f9, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 57 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set39::
    dw MetaSprites27Set39Frame0 ; entry 0
    dw MetaSprites27Set39Frame1 ; entry 1
    dw MetaSprites27Set39Frame2 ; entry 2
    dw MetaSprites27Set39Frame3 ; entry 3
    dw MetaSprites27Set39Frame4 ; entry 4
    dw MetaSprites27Set39Frame5 ; entry 5

; frame 0 of MetaSprites27Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame0::
    db $f7, $f8, $00, $00 ; entry 0
    db $f7, $00, $00, $20 ; entry 1
    db $ef, $f8, $02, $00 ; entry 2
    db $ef, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set39; ends with $80 (E-0147)
MetaSprites27Set39Frame1::
    db $f9, $f8, $01, $00 ; entry 0
    db $f9, $00, $01, $20 ; entry 1
    db $f1, $f8, $02, $00 ; entry 2
    db $f1, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set39; ends with $80 (E-0147)
MetaSprites27Set39Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set39; ends with $80 (E-0147)
MetaSprites27Set39Frame3::
    db $f2, $f8, $04, $00 ; entry 0
    db $f2, $00, $05, $00 ; entry 1
    db $fa, $f8, $08, $00 ; entry 2
    db $fa, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame4::
    db $ef, $f8, $0a, $00 ; entry 0
    db $ef, $00, $0a, $20 ; entry 1
    db $f7, $f8, $0c, $00 ; entry 2
    db $f7, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set39; ends with $80 (E-0147)
MetaSprites27Set39Frame5::
    db $f1, $f8, $0b, $00 ; entry 0
    db $f1, $00, $0b, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 61 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set3D::
    dw MetaSprites27Set3DFrame0 ; entry 0
    dw MetaSprites27Set3DFrame1 ; entry 1
    dw MetaSprites27Set3DFrame2 ; entry 2
    dw MetaSprites27Set3DFrame3 ; entry 3
    dw MetaSprites27Set3DFrame4 ; entry 4
    dw MetaSprites27Set3DFrame5 ; entry 5

; frame 0 of MetaSprites27Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set3D; ends with $80 (E-0147)
MetaSprites27Set3DFrame1::
    db $f1, $00, $01, $00 ; entry 0
    db $f9, $00, $03, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f9, $f8, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set3D; ends with $80 (E-0147)
MetaSprites27Set3DFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set3D; ends with $80 (E-0147)
MetaSprites27Set3DFrame3::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame4::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set3D; ends with $80 (E-0147)
MetaSprites27Set3DFrame5::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 62 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set3E::
    dw MetaSprites27Set3EFrame0 ; entry 0
    dw MetaSprites27Set3EFrame1 ; entry 1
    dw MetaSprites27Set3EFrame2 ; entry 2
    dw MetaSprites27Set3EFrame3 ; entry 3
    dw MetaSprites27Set3EFrame4 ; entry 4
    dw MetaSprites27Set3EFrame5 ; entry 5

; frame 0 of MetaSprites27Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set3E; ends with $80 (E-0147)
MetaSprites27Set3EFrame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set3E; ends with $80 (E-0147)
MetaSprites27Set3EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set3E; ends with $80 (E-0147)
MetaSprites27Set3EFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set3E; ends with $80 (E-0147)
MetaSprites27Set3EFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 63 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set3F::
    dw MetaSprites27Set3FFrame0 ; entry 0
    dw MetaSprites27Set3FFrame1 ; entry 1
    dw MetaSprites27Set3FFrame2 ; entry 2
    dw MetaSprites27Set3FFrame3 ; entry 3
    dw MetaSprites27Set3FFrame4 ; entry 4
    dw MetaSprites27Set3FFrame5 ; entry 5

; frame 0 of MetaSprites27Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set3F; ends with $80 (E-0147)
MetaSprites27Set3FFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $00, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set3F; ends with $80 (E-0147)
MetaSprites27Set3FFrame2::
    db $f0, $f9, $05, $00 ; entry 0
    db $f0, $01, $06, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set3F; ends with $80 (E-0147)
MetaSprites27Set3FFrame3::
    db $ef, $01, $06, $00 ; entry 0
    db $f7, $01, $08, $00 ; entry 1
    db $ef, $f9, $09, $00 ; entry 2
    db $f7, $f9, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set3F; ends with $80 (E-0147)
MetaSprites27Set3FFrame5::
    db $ef, $f8, $0b, $00 ; entry 0
    db $ef, $00, $0b, $20 ; entry 1
    db $f7, $f8, $0e, $00 ; entry 2
    db $f7, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 64 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set40::
    dw MetaSprites27Set40Frame0 ; entry 0
    dw MetaSprites27Set40Frame1 ; entry 1
    dw MetaSprites27Set40Frame2 ; entry 2
    dw MetaSprites27Set40Frame3 ; entry 3
    dw MetaSprites27Set40Frame4 ; entry 4
    dw MetaSprites27Set40Frame5 ; entry 5

; frame 0 of MetaSprites27Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set40; ends with $80 (E-0147)
MetaSprites27Set40Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $ff, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set40; ends with $80 (E-0147)
MetaSprites27Set40Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set40; ends with $80 (E-0147)
MetaSprites27Set40Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set40; ends with $80 (E-0147)
MetaSprites27Set40Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $ff, $0e, $20 ; entry 1
    db $f9, $f8, $0f, $00 ; entry 2
    db $f9, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 65 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set41::
    dw MetaSprites27Set41Frame0 ; entry 0
    dw MetaSprites27Set41Frame1 ; entry 1
    dw MetaSprites27Set41Frame2 ; entry 2
    dw MetaSprites27Set41Frame3 ; entry 3
    dw MetaSprites27Set41Frame4 ; entry 4
    dw MetaSprites27Set41Frame5 ; entry 5

; frame 0 of MetaSprites27Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set41; ends with $80 (E-0147)
MetaSprites27Set41Frame1::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $ff, $05, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set41; ends with $80 (E-0147)
MetaSprites27Set41Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set41; ends with $80 (E-0147)
MetaSprites27Set41Frame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $ff, $0a, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set41; ends with $80 (E-0147)
MetaSprites27Set41Frame5::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $0b, $00 ; entry 2
    db $f7, $ff, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 66 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set42::
    dw MetaSprites27Set42Frame0 ; entry 0
    dw MetaSprites27Set42Frame1 ; entry 1
    dw MetaSprites27Set42Frame2 ; entry 2
    dw MetaSprites27Set42Frame3 ; entry 3
    dw MetaSprites27Set42Frame4 ; entry 4
    dw MetaSprites27Set42Frame5 ; entry 5

; frame 0 of MetaSprites27Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set42; ends with $80 (E-0147)
MetaSprites27Set42Frame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set42; ends with $80 (E-0147)
MetaSprites27Set42Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set42; ends with $80 (E-0147)
MetaSprites27Set42Frame3::
    db $f2, $f8, $08, $00 ; entry 0
    db $f2, $00, $09, $00 ; entry 1
    db $fa, $f8, $0a, $00 ; entry 2
    db $fa, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set42; ends with $80 (E-0147)
MetaSprites27Set42Frame5::
    db $f1, $01, $0c, $20 ; entry 0
    db $f1, $f9, $0d, $20 ; entry 1
    db $f9, $01, $0e, $20 ; entry 2
    db $f9, $f9, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 67 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set43::
    dw MetaSprites27Set43Frame0 ; entry 0
    dw MetaSprites27Set43Frame1 ; entry 1
    dw MetaSprites27Set43Frame2 ; entry 2
    dw MetaSprites27Set43Frame3 ; entry 3
    dw MetaSprites27Set43Frame4 ; entry 4
    dw MetaSprites27Set43Frame5 ; entry 5

; frame 0 of MetaSprites27Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set43; ends with $80 (E-0147)
MetaSprites27Set43Frame1::
    db $f9, $f8, $02, $00 ; entry 0
    db $f9, $00, $03, $00 ; entry 1
    db $f1, $f8, $00, $00 ; entry 2
    db $f1, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set43; ends with $80 (E-0147)
MetaSprites27Set43Frame2::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set43; ends with $80 (E-0147)
MetaSprites27Set43Frame3::
    db $f9, $f8, $02, $00 ; entry 0
    db $f9, $00, $03, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame4::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set43; ends with $80 (E-0147)
MetaSprites27Set43Frame5::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; meta-sprite set 68 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set44::
    dw MetaSprites27Set44Frame0 ; entry 0
    dw MetaSprites27Set44Frame1 ; entry 1
    dw MetaSprites27Set44Frame2 ; entry 2
    dw MetaSprites27Set44Frame3 ; entry 3
    dw MetaSprites27Set44Frame4 ; entry 4
    dw MetaSprites27Set44Frame5 ; entry 5

; frame 0 of MetaSprites27Set44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set44; ends with $80 (E-0147)
MetaSprites27Set44Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set44; ends with $80 (E-0147)
MetaSprites27Set44Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set44; ends with $80 (E-0147)
MetaSprites27Set44Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set44; ends with $80 (E-0147)
MetaSprites27Set44Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 69 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set45::
    dw MetaSprites27Set45Frame0 ; entry 0
    dw MetaSprites27Set45Frame1 ; entry 1
    dw MetaSprites27Set45Frame2 ; entry 2
    dw MetaSprites27Set45Frame3 ; entry 3
    dw MetaSprites27Set45Frame4 ; entry 4
    dw MetaSprites27Set45Frame5 ; entry 5

; frame 0 of MetaSprites27Set45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set45; ends with $80 (E-0147)
MetaSprites27Set45Frame1::
    db $f1, $01, $00, $20 ; entry 0
    db $f1, $f9, $01, $20 ; entry 1
    db $f9, $01, $02, $20 ; entry 2
    db $f9, $f9, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set45; ends with $80 (E-0147)
MetaSprites27Set45Frame2::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $06, $00 ; entry 2
    db $f9, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set45; ends with $80 (E-0147)
MetaSprites27Set45Frame3::
    db $f1, $f9, $04, $00 ; entry 0
    db $f1, $01, $05, $00 ; entry 1
    db $f9, $01, $02, $20 ; entry 2
    db $f9, $f9, $03, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame4::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set45; ends with $80 (E-0147)
MetaSprites27Set45Frame5::
    db $f1, $01, $08, $20 ; entry 0
    db $f1, $f9, $09, $20 ; entry 1
    db $f9, $01, $02, $20 ; entry 2
    db $f9, $f9, $03, $20 ; entry 3
    db $80 ; end

; meta-sprite set 70 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set46::
    dw MetaSprites27Set46Frame0 ; entry 0
    dw MetaSprites27Set46Frame1 ; entry 1
    dw MetaSprites27Set46Frame2 ; entry 2
    dw MetaSprites27Set46Frame3 ; entry 3
    dw MetaSprites27Set46Frame4 ; entry 4
    dw MetaSprites27Set46Frame5 ; entry 5

; frame 0 of MetaSprites27Set46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame0::
    db $f7, $f8, $01, $00 ; entry 0
    db $f7, $00, $01, $20 ; entry 1
    db $ef, $fc, $00, $00 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites27Set46; ends with $80 (E-0147)
MetaSprites27Set46Frame1::
    db $f8, $f8, $03, $00 ; entry 0
    db $f8, $00, $03, $20 ; entry 1
    db $f0, $fc, $02, $00 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites27Set46; ends with $80 (E-0147)
MetaSprites27Set46Frame2::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set46; ends with $80 (E-0147)
MetaSprites27Set46Frame3::
    db $f0, $00, $08, $00 ; entry 0
    db $f8, $f8, $09, $00 ; entry 1
    db $f8, $00, $0a, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites27Set46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame4::
    db $f7, $f8, $0b, $00 ; entry 0
    db $f7, $00, $0c, $00 ; entry 1
    db $ef, $fc, $00, $20 ; entry 2
    db $80 ; end

; frame 5 of MetaSprites27Set46; ends with $80 (E-0147)
MetaSprites27Set46Frame5::
    db $f8, $f8, $0d, $00 ; entry 0
    db $f8, $00, $0e, $00 ; entry 1
    db $f0, $fc, $02, $20 ; entry 2
    db $80 ; end

; meta-sprite set 71 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set47::
    dw MetaSprites27Set47Frame0 ; entry 0
    dw MetaSprites27Set47Frame1 ; entry 1
    dw MetaSprites27Set47Frame2 ; entry 2
    dw MetaSprites27Set47Frame3 ; entry 3
    dw MetaSprites27Set47Frame4 ; entry 4
    dw MetaSprites27Set47Frame5 ; entry 5

; frame 0 of MetaSprites27Set47; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame0::
    db $f9, $f8, $02, $00 ; entry 0
    db $f9, $00, $03, $00 ; entry 1
    db $f1, $f8, $00, $00 ; entry 2
    db $f1, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set47; ends with $80 (E-0147)
MetaSprites27Set47Frame1::
    db $f8, $f7, $04, $00 ; entry 0
    db $f8, $ff, $05, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set47; ends with $80 (E-0147)
MetaSprites27Set47Frame2::
    db $f8, $f9, $08, $00 ; entry 0
    db $f8, $01, $09, $00 ; entry 1
    db $f0, $f9, $06, $00 ; entry 2
    db $f0, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set47; ends with $80 (E-0147)
MetaSprites27Set47Frame3::
    db $f7, $f8, $0a, $00 ; entry 0
    db $f7, $00, $0b, $00 ; entry 1
    db $ef, $f8, $06, $00 ; entry 2
    db $ef, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set47; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame4::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0f, $00 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set47; ends with $80 (E-0147)
MetaSprites27Set47Frame5::
    db $f7, $01, $0e, $20 ; entry 0
    db $f7, $f9, $0f, $20 ; entry 1
    db $ef, $01, $0c, $20 ; entry 2
    db $ef, $f9, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 72 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set48::
    dw MetaSprites27Set48Frame0 ; entry 0
    dw MetaSprites27Set48Frame1 ; entry 1
    dw MetaSprites27Set48Frame2 ; entry 2
    dw MetaSprites27Set48Frame3 ; entry 3
    dw MetaSprites27Set48Frame4 ; entry 4
    dw MetaSprites27Set48Frame5 ; entry 5

; frame 0 of MetaSprites27Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set48; ends with $80 (E-0147)
MetaSprites27Set48Frame1::
    db $f9, $00, $02, $20 ; entry 0
    db $f9, $f8, $03, $20 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set48; ends with $80 (E-0147)
MetaSprites27Set48Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set48; ends with $80 (E-0147)
MetaSprites27Set48Frame3::
    db $f1, $00, $07, $00 ; entry 0
    db $f9, $00, $09, $00 ; entry 1
    db $f1, $f8, $0a, $00 ; entry 2
    db $f9, $f8, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set48; ends with $80 (E-0147)
MetaSprites27Set48Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 73 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set49::
    dw MetaSprites27Set49Frame0 ; entry 0
    dw MetaSprites27Set49Frame1 ; entry 1
    dw MetaSprites27Set49Frame2 ; entry 2
    dw MetaSprites27Set49Frame3 ; entry 3
    dw MetaSprites27Set49Frame4 ; entry 4
    dw MetaSprites27Set49Frame5 ; entry 5

; frame 0 of MetaSprites27Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set49; ends with $80 (E-0147)
MetaSprites27Set49Frame1::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set49; ends with $80 (E-0147)
MetaSprites27Set49Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set49; ends with $80 (E-0147)
MetaSprites27Set49Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set49; ends with $80 (E-0147)
MetaSprites27Set49Frame5::
    db $f1, $01, $0a, $20 ; entry 0
    db $f1, $f9, $0b, $20 ; entry 1
    db $f9, $01, $0c, $20 ; entry 2
    db $f9, $f9, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 74 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set4A::
    dw MetaSprites27Set4AFrame0 ; entry 0
    dw MetaSprites27Set4AFrame1 ; entry 1
    dw MetaSprites27Set4AFrame2 ; entry 2
    dw MetaSprites27Set4AFrame3 ; entry 3
    dw MetaSprites27Set4AFrame4 ; entry 4
    dw MetaSprites27Set4AFrame5 ; entry 5

; frame 0 of MetaSprites27Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set4A; ends with $80 (E-0147)
MetaSprites27Set4AFrame1::
    db $ee, $00, $00, $20 ; entry 0
    db $ee, $f8, $01, $20 ; entry 1
    db $f6, $00, $02, $20 ; entry 2
    db $f6, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set4A; ends with $80 (E-0147)
MetaSprites27Set4AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set4A; ends with $80 (E-0147)
MetaSprites27Set4AFrame3::
    db $ee, $f8, $08, $00 ; entry 0
    db $ee, $00, $09, $00 ; entry 1
    db $f6, $f8, $0a, $00 ; entry 2
    db $f6, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set4A; ends with $80 (E-0147)
MetaSprites27Set4AFrame5::
    db $ee, $00, $0c, $20 ; entry 0
    db $ee, $f8, $0d, $20 ; entry 1
    db $f6, $00, $0e, $20 ; entry 2
    db $f6, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 75 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set4B::
    dw MetaSprites27Set4BFrame0 ; entry 0
    dw MetaSprites27Set4BFrame1 ; entry 1
    dw MetaSprites27Set4BFrame2 ; entry 2
    dw MetaSprites27Set4BFrame3 ; entry 3
    dw MetaSprites27Set4BFrame4 ; entry 4
    dw MetaSprites27Set4BFrame5 ; entry 5

; frame 0 of MetaSprites27Set4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set4B; ends with $80 (E-0147)
MetaSprites27Set4BFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set4B; ends with $80 (E-0147)
MetaSprites27Set4BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set4B; ends with $80 (E-0147)
MetaSprites27Set4BFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set4B; ends with $80 (E-0147)
MetaSprites27Set4BFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 76 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set4C::
    dw MetaSprites27Set4CFrame0 ; entry 0
    dw MetaSprites27Set4CFrame1 ; entry 1
    dw MetaSprites27Set4CFrame2 ; entry 2
    dw MetaSprites27Set4CFrame3 ; entry 3
    dw MetaSprites27Set4CFrame4 ; entry 4
    dw MetaSprites27Set4CFrame5 ; entry 5

; frame 0 of MetaSprites27Set4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set4C; ends with $80 (E-0147)
MetaSprites27Set4CFrame1::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set4C; ends with $80 (E-0147)
MetaSprites27Set4CFrame2::
    db $f8, $f8, $08, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f0, $f8, $01, $20 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set4C; ends with $80 (E-0147)
MetaSprites27Set4CFrame3::
    db $f7, $f8, $09, $00 ; entry 0
    db $ef, $00, $04, $20 ; entry 1
    db $ef, $f8, $05, $20 ; entry 2
    db $f7, $00, $06, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $00 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set4C; ends with $80 (E-0147)
MetaSprites27Set4CFrame5::
    db $ef, $f8, $0d, $00 ; entry 0
    db $ef, $00, $0e, $00 ; entry 1
    db $f7, $00, $0f, $00 ; entry 2
    db $f7, $f8, $09, $00 ; entry 3
    db $80 ; end

; meta-sprite set 77 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set4D::
    dw MetaSprites27Set4DFrame0 ; entry 0
    dw MetaSprites27Set4DFrame1 ; entry 1
    dw MetaSprites27Set4DFrame2 ; entry 2
    dw MetaSprites27Set4DFrame3 ; entry 3
    dw MetaSprites27Set4DFrame4 ; entry 4
    dw MetaSprites27Set4DFrame5 ; entry 5

; frame 0 of MetaSprites27Set4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame0::
    db $f3, $f8, $00, $00 ; entry 0
    db $f3, $00, $00, $20 ; entry 1
    db $fb, $f8, $01, $00 ; entry 2
    db $fb, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set4D; ends with $80 (E-0147)
MetaSprites27Set4DFrame1::
    db $f2, $f8, $03, $00 ; entry 0
    db $f2, $00, $03, $20 ; entry 1
    db $fa, $f8, $04, $00 ; entry 2
    db $fa, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set4D; ends with $80 (E-0147)
MetaSprites27Set4DFrame2::
    db $f3, $f8, $06, $00 ; entry 0
    db $f3, $00, $07, $00 ; entry 1
    db $fb, $f8, $08, $00 ; entry 2
    db $fb, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set4D; ends with $80 (E-0147)
MetaSprites27Set4DFrame3::
    db $fa, $f8, $08, $00 ; entry 0
    db $fa, $00, $09, $00 ; entry 1
    db $f2, $f8, $0a, $00 ; entry 2
    db $f2, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set4D; ends with $80 (E-0147)
MetaSprites27Set4DFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $00, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 78 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set4E::
    dw MetaSprites27Set4EFrame0 ; entry 0
    dw MetaSprites27Set4EFrame1 ; entry 1
    dw MetaSprites27Set4EFrame2 ; entry 2
    dw MetaSprites27Set4EFrame3 ; entry 3
    dw MetaSprites27Set4EFrame4 ; entry 4
    dw MetaSprites27Set4EFrame5 ; entry 5

; frame 0 of MetaSprites27Set4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $ff, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set4E; ends with $80 (E-0147)
MetaSprites27Set4EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set4E; ends with $80 (E-0147)
MetaSprites27Set4EFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set4E; ends with $80 (E-0147)
MetaSprites27Set4EFrame3::
    db $ef, $f8, $05, $00 ; entry 0
    db $f7, $f8, $07, $00 ; entry 1
    db $ef, $00, $09, $00 ; entry 2
    db $f7, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set4E; ends with $80 (E-0147)
MetaSprites27Set4EFrame5::
    db $ef, $f8, $0b, $00 ; entry 0
    db $ef, $ff, $0b, $20 ; entry 1
    db $f7, $f8, $0e, $00 ; entry 2
    db $f7, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 79 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set4F::
    dw MetaSprites27Set4FFrame0 ; entry 0
    dw MetaSprites27Set4FFrame1 ; entry 1
    dw MetaSprites27Set4FFrame2 ; entry 2
    dw MetaSprites27Set4FFrame3 ; entry 3
    dw MetaSprites27Set4FFrame4 ; entry 4
    dw MetaSprites27Set4FFrame5 ; entry 5

; frame 0 of MetaSprites27Set4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set4F; ends with $80 (E-0147)
MetaSprites27Set4FFrame1::
    db $f1, $01, $00, $30 ; entry 0
    db $f1, $f9, $01, $30 ; entry 1
    db $f9, $01, $02, $30 ; entry 2
    db $f9, $f9, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set4F; ends with $80 (E-0147)
MetaSprites27Set4FFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set4F; ends with $80 (E-0147)
MetaSprites27Set4FFrame3::
    db $f1, $f9, $08, $10 ; entry 0
    db $f1, $01, $09, $10 ; entry 1
    db $f9, $f9, $0a, $10 ; entry 2
    db $f9, $01, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0d, $10 ; entry 1
    db $f8, $f8, $0e, $10 ; entry 2
    db $f8, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set4F; ends with $80 (E-0147)
MetaSprites27Set4FFrame5::
    db $f1, $01, $0c, $30 ; entry 0
    db $f1, $f9, $0d, $30 ; entry 1
    db $f9, $01, $0e, $30 ; entry 2
    db $f9, $f9, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 80 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set50::
    dw MetaSprites27Set50Frame0 ; entry 0
    dw MetaSprites27Set50Frame1 ; entry 1
    dw MetaSprites27Set50Frame2 ; entry 2
    dw MetaSprites27Set50Frame3 ; entry 3
    dw MetaSprites27Set50Frame4 ; entry 4
    dw MetaSprites27Set50Frame5 ; entry 5

; frame 0 of MetaSprites27Set50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set50; ends with $80 (E-0147)
MetaSprites27Set50Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set50; ends with $80 (E-0147)
MetaSprites27Set50Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set50; ends with $80 (E-0147)
MetaSprites27Set50Frame3::
    db $ef, $f8, $08, $00 ; entry 0
    db $ef, $00, $09, $00 ; entry 1
    db $f7, $f8, $0a, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set50; ends with $80 (E-0147)
MetaSprites27Set50Frame5::
    db $ef, $00, $0b, $20 ; entry 0
    db $ef, $f8, $0c, $20 ; entry 1
    db $f7, $00, $0d, $20 ; entry 2
    db $f7, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 81 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set51::
    dw MetaSprites27Set51Frame0 ; entry 0
    dw MetaSprites27Set51Frame1 ; entry 1
    dw MetaSprites27Set51Frame2 ; entry 2
    dw MetaSprites27Set51Frame3 ; entry 3
    dw MetaSprites27Set51Frame4 ; entry 4
    dw MetaSprites27Set51Frame5 ; entry 5

; frame 0 of MetaSprites27Set51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $ff, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set51; ends with $80 (E-0147)
MetaSprites27Set51Frame1::
    db $f0, $f9, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set51; ends with $80 (E-0147)
MetaSprites27Set51Frame2::
    db $f9, $f8, $05, $00 ; entry 0
    db $f9, $00, $06, $00 ; entry 1
    db $f1, $f8, $03, $00 ; entry 2
    db $f1, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set51; ends with $80 (E-0147)
MetaSprites27Set51Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $07, $00 ; entry 2
    db $f0, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame4::
    db $f9, $f8, $0b, $00 ; entry 0
    db $f9, $00, $0c, $00 ; entry 1
    db $f1, $f8, $0a, $00 ; entry 2
    db $f1, $ff, $0a, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set51; ends with $80 (E-0147)
MetaSprites27Set51Frame5::
    db $f8, $00, $0b, $20 ; entry 0
    db $f8, $f8, $0c, $20 ; entry 1
    db $f0, $f9, $0a, $00 ; entry 2
    db $f0, $00, $0a, $20 ; entry 3
    db $80 ; end

; meta-sprite set 82 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set52::
    dw MetaSprites27Set52Frame0 ; entry 0
    dw MetaSprites27Set52Frame1 ; entry 1
    dw MetaSprites27Set52Frame2 ; entry 2
    dw MetaSprites27Set52Frame3 ; entry 3
    dw MetaSprites27Set52Frame4 ; entry 4
    dw MetaSprites27Set52Frame5 ; entry 5

; frame 0 of MetaSprites27Set52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set52; ends with $80 (E-0147)
MetaSprites27Set52Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set52; ends with $80 (E-0147)
MetaSprites27Set52Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set52; ends with $80 (E-0147)
MetaSprites27Set52Frame3::
    db $f1, $00, $05, $00 ; entry 0
    db $f1, $f8, $08, $00 ; entry 1
    db $f9, $f8, $09, $00 ; entry 2
    db $f9, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set52; ends with $80 (E-0147)
MetaSprites27Set52Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $00, $0e, $20 ; entry 1
    db $f9, $f8, $0f, $00 ; entry 2
    db $f9, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 83 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set53::
    dw MetaSprites27Set53Frame0 ; entry 0
    dw MetaSprites27Set53Frame1 ; entry 1
    dw MetaSprites27Set53Frame2 ; entry 2
    dw MetaSprites27Set53Frame3 ; entry 3
    dw MetaSprites27Set53Frame4 ; entry 4
    dw MetaSprites27Set53Frame5 ; entry 5

; frame 0 of MetaSprites27Set53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set53; ends with $80 (E-0147)
MetaSprites27Set53Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set53; ends with $80 (E-0147)
MetaSprites27Set53Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set53; ends with $80 (E-0147)
MetaSprites27Set53Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set53; ends with $80 (E-0147)
MetaSprites27Set53Frame5::
    db $f1, $f8, $0d, $00 ; entry 0
    db $f1, $00, $0d, $20 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 84 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set54::
    dw MetaSprites27Set54Frame0 ; entry 0
    dw MetaSprites27Set54Frame1 ; entry 1
    dw MetaSprites27Set54Frame2 ; entry 2
    dw MetaSprites27Set54Frame3 ; entry 3
    dw MetaSprites27Set54Frame4 ; entry 4
    dw MetaSprites27Set54Frame5 ; entry 5

; frame 0 of MetaSprites27Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set54; ends with $80 (E-0147)
MetaSprites27Set54Frame1::
    db $ef, $00, $00, $20 ; entry 0
    db $ef, $f8, $01, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set54; ends with $80 (E-0147)
MetaSprites27Set54Frame2::
    db $f0, $00, $05, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f8, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set54; ends with $80 (E-0147)
MetaSprites27Set54Frame3::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set54; ends with $80 (E-0147)
MetaSprites27Set54Frame5::
    db $ef, $00, $0a, $20 ; entry 0
    db $ef, $f8, $0b, $20 ; entry 1
    db $f7, $f8, $0e, $00 ; entry 2
    db $f7, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 85 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set55::
    dw MetaSprites27Set55Frame0 ; entry 0
    dw MetaSprites27Set55Frame1 ; entry 1
    dw MetaSprites27Set55Frame2 ; entry 2
    dw MetaSprites27Set55Frame3 ; entry 3
    dw MetaSprites27Set55Frame4 ; entry 4
    dw MetaSprites27Set55Frame5 ; entry 5

; frame 0 of MetaSprites27Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set55; ends with $80 (E-0147)
MetaSprites27Set55Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set55; ends with $80 (E-0147)
MetaSprites27Set55Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set55; ends with $80 (E-0147)
MetaSprites27Set55Frame3::
    db $ef, $f8, $03, $00 ; entry 0
    db $ef, $00, $04, $00 ; entry 1
    db $f7, $f8, $07, $00 ; entry 2
    db $f7, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set55; ends with $80 (E-0147)
MetaSprites27Set55Frame5::
    db $ef, $f8, $09, $00 ; entry 0
    db $ef, $00, $09, $20 ; entry 1
    db $f7, $00, $0a, $20 ; entry 2
    db $f7, $f8, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 86 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set56::
    dw MetaSprites27Set56Frame0 ; entry 0
    dw MetaSprites27Set56Frame1 ; entry 1
    dw MetaSprites27Set56Frame2 ; entry 2
    dw MetaSprites27Set56Frame3 ; entry 3
    dw MetaSprites27Set56Frame4 ; entry 4
    dw MetaSprites27Set56Frame5 ; entry 5

; frame 0 of MetaSprites27Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set56; ends with $80 (E-0147)
MetaSprites27Set56Frame1::
    db $f7, $00, $02, $20 ; entry 0
    db $f7, $f8, $03, $20 ; entry 1
    db $ef, $00, $00, $20 ; entry 2
    db $ef, $f8, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set56; ends with $80 (E-0147)
MetaSprites27Set56Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set56; ends with $80 (E-0147)
MetaSprites27Set56Frame3::
    db $ef, $00, $05, $00 ; entry 0
    db $f7, $f8, $09, $00 ; entry 1
    db $f7, $00, $0a, $00 ; entry 2
    db $ef, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set56; ends with $80 (E-0147)
MetaSprites27Set56Frame5::
    db $ef, $00, $0b, $20 ; entry 0
    db $ef, $f8, $0c, $20 ; entry 1
    db $f7, $00, $0d, $20 ; entry 2
    db $f7, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 87 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set57::
    dw MetaSprites27Set57Frame0 ; entry 0
    dw MetaSprites27Set57Frame1 ; entry 1
    dw MetaSprites27Set57Frame2 ; entry 2
    dw MetaSprites27Set57Frame3 ; entry 3
    dw MetaSprites27Set57Frame4 ; entry 4
    dw MetaSprites27Set57Frame5 ; entry 5

; frame 0 of MetaSprites27Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set57; ends with $80 (E-0147)
MetaSprites27Set57Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $04, $00 ; entry 2
    db $f9, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set57; ends with $80 (E-0147)
MetaSprites27Set57Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set57; ends with $80 (E-0147)
MetaSprites27Set57Frame3::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame4::
    db $f8, $00, $02, $20 ; entry 0
    db $f8, $f8, $03, $20 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set57; ends with $80 (E-0147)
MetaSprites27Set57Frame5::
    db $f9, $00, $04, $20 ; entry 0
    db $f9, $f8, $05, $20 ; entry 1
    db $f1, $f8, $0c, $00 ; entry 2
    db $f1, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 88 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set58::
    dw MetaSprites27Set58Frame0 ; entry 0
    dw MetaSprites27Set58Frame1 ; entry 1
    dw MetaSprites27Set58Frame2 ; entry 2
    dw MetaSprites27Set58Frame3 ; entry 3
    dw MetaSprites27Set58Frame4 ; entry 4
    dw MetaSprites27Set58Frame5 ; entry 5

; frame 0 of MetaSprites27Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set58; ends with $80 (E-0147)
MetaSprites27Set58Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $00, $03, $00 ; entry 2
    db $f9, $f8, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set58; ends with $80 (E-0147)
MetaSprites27Set58Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set58; ends with $80 (E-0147)
MetaSprites27Set58Frame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $f8, $07, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set58; ends with $80 (E-0147)
MetaSprites27Set58Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $00, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 89 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set59::
    dw MetaSprites27Set59Frame0 ; entry 0
    dw MetaSprites27Set59Frame1 ; entry 1
    dw MetaSprites27Set59Frame2 ; entry 2
    dw MetaSprites27Set59Frame3 ; entry 3
    dw MetaSprites27Set59Frame4 ; entry 4
    dw MetaSprites27Set59Frame5 ; entry 5

; frame 0 of MetaSprites27Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $ff, $00, $20 ; entry 1
    db $f9, $f8, $01, $00 ; entry 2
    db $f9, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set59; ends with $80 (E-0147)
MetaSprites27Set59Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $ff, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set59; ends with $80 (E-0147)
MetaSprites27Set59Frame2::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $06, $00 ; entry 2
    db $f7, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set59; ends with $80 (E-0147)
MetaSprites27Set59Frame3::
    db $f0, $f9, $08, $00 ; entry 0
    db $f0, $01, $09, $00 ; entry 1
    db $f8, $f9, $0a, $00 ; entry 2
    db $f8, $01, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $ff, $0c, $20 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set59; ends with $80 (E-0147)
MetaSprites27Set59Frame5::
    db $ef, $f8, $0e, $00 ; entry 0
    db $f7, $f8, $0f, $00 ; entry 1
    db $ef, $ff, $0e, $20 ; entry 2
    db $f7, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 90 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set5A::
    dw MetaSprites27Set5AFrame0 ; entry 0
    dw MetaSprites27Set5AFrame1 ; entry 1
    dw MetaSprites27Set5AFrame2 ; entry 2
    dw MetaSprites27Set5AFrame3 ; entry 3
    dw MetaSprites27Set5AFrame4 ; entry 4
    dw MetaSprites27Set5AFrame5 ; entry 5

; frame 0 of MetaSprites27Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame0::
    db $f0, $f9, $00, $00 ; entry 0
    db $f8, $f9, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set5A; ends with $80 (E-0147)
MetaSprites27Set5AFrame1::
    db $f1, $f9, $02, $00 ; entry 0
    db $f9, $f9, $03, $00 ; entry 1
    db $f1, $00, $02, $20 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set5A; ends with $80 (E-0147)
MetaSprites27Set5AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set5A; ends with $80 (E-0147)
MetaSprites27Set5AFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame4::
    db $f0, $f9, $0c, $00 ; entry 0
    db $f8, $f9, $0d, $00 ; entry 1
    db $f0, $00, $0c, $20 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set5A; ends with $80 (E-0147)
MetaSprites27Set5AFrame5::
    db $f1, $f9, $0e, $00 ; entry 0
    db $f9, $f9, $0f, $00 ; entry 1
    db $f1, $00, $0e, $20 ; entry 2
    db $f9, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 91 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set5B::
    dw MetaSprites27Set5BFrame0 ; entry 0
    dw MetaSprites27Set5BFrame1 ; entry 1
    dw MetaSprites27Set5BFrame2 ; entry 2
    dw MetaSprites27Set5BFrame3 ; entry 3
    dw MetaSprites27Set5BFrame4 ; entry 4
    dw MetaSprites27Set5BFrame5 ; entry 5

; frame 0 of MetaSprites27Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set5B; ends with $80 (E-0147)
MetaSprites27Set5BFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set5B; ends with $80 (E-0147)
MetaSprites27Set5BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set5B; ends with $80 (E-0147)
MetaSprites27Set5BFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set5B; ends with $80 (E-0147)
MetaSprites27Set5BFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 92 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set5C::
    dw MetaSprites27Set5CFrame0 ; entry 0
    dw MetaSprites27Set5CFrame1 ; entry 1
    dw MetaSprites27Set5CFrame2 ; entry 2
    dw MetaSprites27Set5CFrame3 ; entry 3
    dw MetaSprites27Set5CFrame4 ; entry 4
    dw MetaSprites27Set5CFrame5 ; entry 5

; frame 0 of MetaSprites27Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set5C; ends with $80 (E-0147)
MetaSprites27Set5CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set5C; ends with $80 (E-0147)
MetaSprites27Set5CFrame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set5C; ends with $80 (E-0147)
MetaSprites27Set5CFrame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame4::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0d, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set5C; ends with $80 (E-0147)
MetaSprites27Set5CFrame5::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 96 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set60::
    dw MetaSprites27Set60Frame0 ; entry 0
    dw MetaSprites27Set60Frame1 ; entry 1
    dw MetaSprites27Set60Frame2 ; entry 2
    dw MetaSprites27Set60Frame3 ; entry 3
    dw MetaSprites27Set60Frame4 ; entry 4
    dw MetaSprites27Set60Frame5 ; entry 5

; frame 0 of MetaSprites27Set60; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set60; ends with $80 (E-0147)
MetaSprites27Set60Frame1::
    db $f9, $00, $01, $20 ; entry 0
    db $f9, $f8, $02, $20 ; entry 1
    db $f1, $f8, $03, $00 ; entry 2
    db $f1, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set60; ends with $80 (E-0147)
MetaSprites27Set60Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set60; ends with $80 (E-0147)
MetaSprites27Set60Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set60; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set60; ends with $80 (E-0147)
MetaSprites27Set60Frame5::
    db $f1, $f8, $0c, $00 ; entry 0
    db $f1, $00, $0c, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 97 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set61::
    dw MetaSprites27Set61Frame0 ; entry 0
    dw MetaSprites27Set61Frame1 ; entry 1
    dw MetaSprites27Set61Frame2 ; entry 2
    dw MetaSprites27Set61Frame3 ; entry 3
    dw MetaSprites27Set61Frame4 ; entry 4
    dw MetaSprites27Set61Frame5 ; entry 5

; frame 0 of MetaSprites27Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set61; ends with $80 (E-0147)
MetaSprites27Set61Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set61; ends with $80 (E-0147)
MetaSprites27Set61Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set61; ends with $80 (E-0147)
MetaSprites27Set61Frame3::
    db $f1, $00, $05, $00 ; entry 0
    db $f1, $f8, $08, $00 ; entry 1
    db $f9, $f8, $09, $00 ; entry 2
    db $f9, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set61; ends with $80 (E-0147)
MetaSprites27Set61Frame5::
    db $f9, $00, $0c, $20 ; entry 0
    db $f9, $f8, $0d, $20 ; entry 1
    db $f1, $f8, $0b, $00 ; entry 2
    db $f1, $00, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 98 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set62::
    dw MetaSprites27Set62Frame0 ; entry 0
    dw MetaSprites27Set62Frame1 ; entry 1
    dw MetaSprites27Set62Frame2 ; entry 2
    dw MetaSprites27Set62Frame3 ; entry 3
    dw MetaSprites27Set62Frame4 ; entry 4
    dw MetaSprites27Set62Frame5 ; entry 5

; frame 0 of MetaSprites27Set62; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set62; ends with $80 (E-0147)
MetaSprites27Set62Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set62; ends with $80 (E-0147)
MetaSprites27Set62Frame2::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set62; ends with $80 (E-0147)
MetaSprites27Set62Frame3::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set62; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame4::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $05, $20 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $06, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set62; ends with $80 (E-0147)
MetaSprites27Set62Frame5::
    db $f0, $f8, $07, $00 ; entry 0
    db $f8, $f8, $08, $00 ; entry 1
    db $f8, $00, $08, $20 ; entry 2
    db $f0, $00, $07, $20 ; entry 3
    db $80 ; end

; meta-sprite set 99 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set63::
    dw MetaSprites27Set63Frame0 ; entry 0
    dw MetaSprites27Set63Frame1 ; entry 1
    dw MetaSprites27Set63Frame2 ; entry 2
    dw MetaSprites27Set63Frame3 ; entry 3
    dw MetaSprites27Set63Frame4 ; entry 4
    dw MetaSprites27Set63Frame5 ; entry 5

; frame 0 of MetaSprites27Set63; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $01, $30 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set63; ends with $80 (E-0147)
MetaSprites27Set63Frame1::
    db $f1, $f8, $02, $10 ; entry 0
    db $f1, $00, $02, $30 ; entry 1
    db $f9, $f8, $03, $10 ; entry 2
    db $f9, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set63; ends with $80 (E-0147)
MetaSprites27Set63Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set63; ends with $80 (E-0147)
MetaSprites27Set63Frame3::
    db $f1, $f8, $08, $10 ; entry 0
    db $f1, $00, $09, $10 ; entry 1
    db $f9, $f8, $0a, $10 ; entry 2
    db $f9, $00, $0b, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set63; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f0, $00, $0c, $30 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0d, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set63; ends with $80 (E-0147)
MetaSprites27Set63Frame5::
    db $f1, $f8, $0e, $10 ; entry 0
    db $f1, $00, $0e, $30 ; entry 1
    db $f9, $f8, $0f, $10 ; entry 2
    db $f9, $00, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 100 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set64::
    dw MetaSprites27Set64Frame0 ; entry 0
    dw MetaSprites27Set64Frame1 ; entry 1
    dw MetaSprites27Set64Frame2 ; entry 2
    dw MetaSprites27Set64Frame3 ; entry 3
    dw MetaSprites27Set64Frame4 ; entry 4
    dw MetaSprites27Set64Frame5 ; entry 5

; frame 0 of MetaSprites27Set64; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set64; ends with $80 (E-0147)
MetaSprites27Set64Frame1::
    db $f1, $f8, $02, $00 ; entry 0
    db $f1, $00, $02, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set64; ends with $80 (E-0147)
MetaSprites27Set64Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set64; ends with $80 (E-0147)
MetaSprites27Set64Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set64; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set64; ends with $80 (E-0147)
MetaSprites27Set64Frame5::
    db $f1, $f8, $0e, $00 ; entry 0
    db $f1, $00, $0e, $20 ; entry 1
    db $f9, $f8, $0f, $00 ; entry 2
    db $f9, $00, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 101 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set65::
    dw MetaSprites27Set65Frame0 ; entry 0
    dw MetaSprites27Set65Frame1 ; entry 1
    dw MetaSprites27Set65Frame2 ; entry 2
    dw MetaSprites27Set65Frame3 ; entry 3
    dw MetaSprites27Set65Frame4 ; entry 4
    dw MetaSprites27Set65Frame5 ; entry 5

; frame 0 of MetaSprites27Set65; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set65; ends with $80 (E-0147)
MetaSprites27Set65Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set65; ends with $80 (E-0147)
MetaSprites27Set65Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set65; ends with $80 (E-0147)
MetaSprites27Set65Frame3::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $08, $10 ; entry 2
    db $f9, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set65; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set65; ends with $80 (E-0147)
MetaSprites27Set65Frame5::
    db $f1, $00, $0a, $30 ; entry 0
    db $f1, $f8, $0b, $30 ; entry 1
    db $f9, $00, $0c, $30 ; entry 2
    db $f9, $f8, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 102 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set66::
    dw MetaSprites27Set66Frame0 ; entry 0
    dw MetaSprites27Set66Frame1 ; entry 1
    dw MetaSprites27Set66Frame2 ; entry 2
    dw MetaSprites27Set66Frame3 ; entry 3
    dw MetaSprites27Set66Frame4 ; entry 4
    dw MetaSprites27Set66Frame5 ; entry 5

; frame 0 of MetaSprites27Set66; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set66; ends with $80 (E-0147)
MetaSprites27Set66Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set66; ends with $80 (E-0147)
MetaSprites27Set66Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set66; ends with $80 (E-0147)
MetaSprites27Set66Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set66; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set66; ends with $80 (E-0147)
MetaSprites27Set66Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 103 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set67::
    dw MetaSprites27Set67Frame0 ; entry 0
    dw MetaSprites27Set67Frame1 ; entry 1
    dw MetaSprites27Set67Frame2 ; entry 2
    dw MetaSprites27Set67Frame3 ; entry 3
    dw MetaSprites27Set67Frame4 ; entry 4
    dw MetaSprites27Set67Frame5 ; entry 5

; frame 0 of MetaSprites27Set67; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame0::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set67; ends with $80 (E-0147)
MetaSprites27Set67Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $00, $20 ; entry 1
    db $f9, $f8, $03, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set67; ends with $80 (E-0147)
MetaSprites27Set67Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set67; ends with $80 (E-0147)
MetaSprites27Set67Frame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $f8, $09, $00 ; entry 2
    db $f9, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set67; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set67; ends with $80 (E-0147)
MetaSprites27Set67Frame5::
    db $f9, $00, $0c, $20 ; entry 0
    db $f9, $f8, $0d, $20 ; entry 1
    db $f1, $f8, $0b, $00 ; entry 2
    db $f1, $00, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 104 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set68::
    dw MetaSprites27Set68Frame0 ; entry 0
    dw MetaSprites27Set68Frame1 ; entry 1
    dw MetaSprites27Set68Frame2 ; entry 2
    dw MetaSprites27Set68Frame3 ; entry 3
    dw MetaSprites27Set68Frame4 ; entry 4
    dw MetaSprites27Set68Frame5 ; entry 5

; frame 0 of MetaSprites27Set68; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set68; ends with $80 (E-0147)
MetaSprites27Set68Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set68; ends with $80 (E-0147)
MetaSprites27Set68Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set68; ends with $80 (E-0147)
MetaSprites27Set68Frame3::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $08, $10 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set68; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0c, $10 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set68; ends with $80 (E-0147)
MetaSprites27Set68Frame5::
    db $f1, $00, $0b, $30 ; entry 0
    db $f1, $f8, $0c, $30 ; entry 1
    db $f9, $00, $0d, $30 ; entry 2
    db $f9, $f8, $0e, $30 ; entry 3
    db $80 ; end

; meta-sprite set 105 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set69::
    dw MetaSprites27Set69Frame0 ; entry 0
    dw MetaSprites27Set69Frame1 ; entry 1
    dw MetaSprites27Set69Frame2 ; entry 2
    dw MetaSprites27Set69Frame3 ; entry 3
    dw MetaSprites27Set69Frame4 ; entry 4
    dw MetaSprites27Set69Frame5 ; entry 5

; frame 0 of MetaSprites27Set69; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set69; ends with $80 (E-0147)
MetaSprites27Set69Frame1::
    db $f1, $00, $00, $30 ; entry 0
    db $f1, $f8, $01, $30 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set69; ends with $80 (E-0147)
MetaSprites27Set69Frame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set69; ends with $80 (E-0147)
MetaSprites27Set69Frame3::
    db $f1, $00, $05, $10 ; entry 0
    db $f1, $f8, $08, $10 ; entry 1
    db $f9, $f8, $09, $10 ; entry 2
    db $f9, $00, $0a, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set69; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame4::
    db $f0, $f8, $0b, $10 ; entry 0
    db $f0, $00, $0c, $10 ; entry 1
    db $f8, $f8, $0d, $10 ; entry 2
    db $f8, $00, $0e, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set69; ends with $80 (E-0147)
MetaSprites27Set69Frame5::
    db $f1, $00, $0b, $30 ; entry 0
    db $f1, $f8, $0c, $30 ; entry 1
    db $f9, $00, $0d, $30 ; entry 2
    db $f9, $f8, $0e, $30 ; entry 3
    db $80 ; end

; meta-sprite set 106 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set6A::
    dw MetaSprites27Set6AFrame0 ; entry 0
    dw MetaSprites27Set6AFrame1 ; entry 1
    dw MetaSprites27Set6AFrame2 ; entry 2
    dw MetaSprites27Set6AFrame3 ; entry 3
    dw MetaSprites27Set6AFrame4 ; entry 4
    dw MetaSprites27Set6AFrame5 ; entry 5

; frame 0 of MetaSprites27Set6A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set6A; ends with $80 (E-0147)
MetaSprites27Set6AFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set6A; ends with $80 (E-0147)
MetaSprites27Set6AFrame2::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set6A; ends with $80 (E-0147)
MetaSprites27Set6AFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set6A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set6A; ends with $80 (E-0147)
MetaSprites27Set6AFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 107 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set6B::
    dw MetaSprites27Set6BFrame0 ; entry 0
    dw MetaSprites27Set6BFrame1 ; entry 1
    dw MetaSprites27Set6BFrame2 ; entry 2
    dw MetaSprites27Set6BFrame3 ; entry 3
    dw MetaSprites27Set6BFrame4 ; entry 4
    dw MetaSprites27Set6BFrame5 ; entry 5

; frame 0 of MetaSprites27Set6B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set6B; ends with $80 (E-0147)
MetaSprites27Set6BFrame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set6B; ends with $80 (E-0147)
MetaSprites27Set6BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set6B; ends with $80 (E-0147)
MetaSprites27Set6BFrame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set6B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set6B; ends with $80 (E-0147)
MetaSprites27Set6BFrame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 108 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set6C::
    dw MetaSprites27Set6CFrame0 ; entry 0
    dw MetaSprites27Set6CFrame1 ; entry 1
    dw MetaSprites27Set6CFrame2 ; entry 2
    dw MetaSprites27Set6CFrame3 ; entry 3
    dw MetaSprites27Set6CFrame4 ; entry 4
    dw MetaSprites27Set6CFrame5 ; entry 5

; frame 0 of MetaSprites27Set6C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set6C; ends with $80 (E-0147)
MetaSprites27Set6CFrame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $00, $02, $30 ; entry 2
    db $f9, $f8, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set6C; ends with $80 (E-0147)
MetaSprites27Set6CFrame2::
    db $f0, $f8, $04, $10 ; entry 0
    db $f0, $00, $05, $10 ; entry 1
    db $f8, $f8, $06, $10 ; entry 2
    db $f8, $00, $07, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set6C; ends with $80 (E-0147)
MetaSprites27Set6CFrame3::
    db $f1, $f8, $04, $10 ; entry 0
    db $f1, $00, $05, $10 ; entry 1
    db $f9, $f8, $08, $10 ; entry 2
    db $f9, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set6C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame4::
    db $f0, $f8, $0a, $10 ; entry 0
    db $f0, $00, $0b, $10 ; entry 1
    db $f8, $f8, $0c, $10 ; entry 2
    db $f8, $00, $0d, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set6C; ends with $80 (E-0147)
MetaSprites27Set6CFrame5::
    db $f1, $00, $0a, $30 ; entry 0
    db $f1, $f8, $0b, $30 ; entry 1
    db $f9, $00, $0c, $30 ; entry 2
    db $f9, $f8, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 109 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set6D::
    dw MetaSprites27Set6DFrame0 ; entry 0
    dw MetaSprites27Set6DFrame1 ; entry 1
    dw MetaSprites27Set6DFrame2 ; entry 2
    dw MetaSprites27Set6DFrame3 ; entry 3
    dw MetaSprites27Set6DFrame4 ; entry 4
    dw MetaSprites27Set6DFrame5 ; entry 5

; frame 0 of MetaSprites27Set6D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $01, $10 ; entry 1
    db $f8, $f8, $02, $10 ; entry 2
    db $f8, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set6D; ends with $80 (E-0147)
MetaSprites27Set6DFrame1::
    db $f1, $f8, $00, $10 ; entry 0
    db $f1, $00, $01, $10 ; entry 1
    db $f9, $f8, $04, $10 ; entry 2
    db $f9, $00, $05, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set6D; ends with $80 (E-0147)
MetaSprites27Set6DFrame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set6D; ends with $80 (E-0147)
MetaSprites27Set6DFrame3::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $f7, $06, $10 ; entry 2
    db $f1, $ff, $07, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set6D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame4::
    db $f1, $f8, $0c, $10 ; entry 0
    db $f1, $00, $0d, $10 ; entry 1
    db $f9, $f8, $0e, $10 ; entry 2
    db $f9, $00, $0f, $10 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set6D; ends with $80 (E-0147)
MetaSprites27Set6DFrame5::
    db $f0, $00, $0c, $30 ; entry 0
    db $f0, $f8, $0d, $30 ; entry 1
    db $f8, $00, $0e, $30 ; entry 2
    db $f8, $f8, $0f, $30 ; entry 3
    db $80 ; end

; meta-sprite set 110 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set6E::
    dw MetaSprites27Set6EFrame0 ; entry 0
    dw MetaSprites27Set6EFrame1 ; entry 1
    dw MetaSprites27Set6EFrame2 ; entry 2
    dw MetaSprites27Set6EFrame3 ; entry 3
    dw MetaSprites27Set6EFrame4 ; entry 4
    dw MetaSprites27Set6EFrame5 ; entry 5

; frame 0 of MetaSprites27Set6E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set6E; ends with $80 (E-0147)
MetaSprites27Set6EFrame1::
    db $f7, $ff, $01, $20 ; entry 0
    db $ef, $f8, $02, $00 ; entry 1
    db $ef, $00, $03, $00 ; entry 2
    db $f7, $f8, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set6E; ends with $80 (E-0147)
MetaSprites27Set6EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set6E; ends with $80 (E-0147)
MetaSprites27Set6EFrame3::
    db $f7, $00, $07, $00 ; entry 0
    db $ef, $f8, $08, $00 ; entry 1
    db $ef, $00, $09, $00 ; entry 2
    db $f7, $f8, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set6E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $ff, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set6E; ends with $80 (E-0147)
MetaSprites27Set6EFrame5::
    db $ef, $f8, $0d, $00 ; entry 0
    db $ef, $00, $0e, $00 ; entry 1
    db $f7, $f8, $0f, $00 ; entry 2
    db $f7, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 111 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set6F::
    dw MetaSprites27Set6FFrame0 ; entry 0
    dw MetaSprites27Set6FFrame1 ; entry 1
    dw MetaSprites27Set6FFrame2 ; entry 2
    dw MetaSprites27Set6FFrame3 ; entry 3
    dw MetaSprites27Set6FFrame4 ; entry 4
    dw MetaSprites27Set6FFrame5 ; entry 5

; frame 0 of MetaSprites27Set6F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set6F; ends with $80 (E-0147)
MetaSprites27Set6FFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set6F; ends with $80 (E-0147)
MetaSprites27Set6FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set6F; ends with $80 (E-0147)
MetaSprites27Set6FFrame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set6F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set6F; ends with $80 (E-0147)
MetaSprites27Set6FFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 112 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set70::
    dw MetaSprites27Set70Frame0 ; entry 0
    dw MetaSprites27Set70Frame1 ; entry 1
    dw MetaSprites27Set70Frame2 ; entry 2
    dw MetaSprites27Set70Frame3 ; entry 3
    dw MetaSprites27Set70Frame4 ; entry 4
    dw MetaSprites27Set70Frame5 ; entry 5

; frame 0 of MetaSprites27Set70; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame0::
    db $f0, $ff, $00, $20 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f0, $f8, $00, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set70; ends with $80 (E-0147)
MetaSprites27Set70Frame1::
    db $ef, $f8, $02, $00 ; entry 0
    db $ef, $ff, $02, $20 ; entry 1
    db $f7, $f8, $03, $00 ; entry 2
    db $f7, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set70; ends with $80 (E-0147)
MetaSprites27Set70Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set70; ends with $80 (E-0147)
MetaSprites27Set70Frame3::
    db $ef, $f8, $04, $00 ; entry 0
    db $ef, $00, $05, $00 ; entry 1
    db $f7, $f8, $08, $00 ; entry 2
    db $f7, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set70; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set70; ends with $80 (E-0147)
MetaSprites27Set70Frame5::
    db $ef, $f8, $0c, $00 ; entry 0
    db $ef, $ff, $0c, $20 ; entry 1
    db $f7, $f8, $0d, $00 ; entry 2
    db $f7, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 113 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set71::
    dw MetaSprites27Set71Frame0 ; entry 0
    dw MetaSprites27Set71Frame1 ; entry 1
    dw MetaSprites27Set71Frame2 ; entry 2
    dw MetaSprites27Set71Frame3 ; entry 3
    dw MetaSprites27Set71Frame4 ; entry 4
    dw MetaSprites27Set71Frame5 ; entry 5

; frame 0 of MetaSprites27Set71; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set71; ends with $80 (E-0147)
MetaSprites27Set71Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set71; ends with $80 (E-0147)
MetaSprites27Set71Frame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set71; ends with $80 (E-0147)
MetaSprites27Set71Frame3::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set71; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set71; ends with $80 (E-0147)
MetaSprites27Set71Frame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 114 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set72::
    dw MetaSprites27Set72Frame0 ; entry 0
    dw MetaSprites27Set72Frame1 ; entry 1
    dw MetaSprites27Set72Frame2 ; entry 2
    dw MetaSprites27Set72Frame3 ; entry 3
    dw MetaSprites27Set72Frame4 ; entry 4
    dw MetaSprites27Set72Frame5 ; entry 5

; frame 0 of MetaSprites27Set72; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set72; ends with $80 (E-0147)
MetaSprites27Set72Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set72; ends with $80 (E-0147)
MetaSprites27Set72Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set72; ends with $80 (E-0147)
MetaSprites27Set72Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set72; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set72; ends with $80 (E-0147)
MetaSprites27Set72Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $ff, $0c, $20 ; entry 2
    db $f9, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 115 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set73::
    dw MetaSprites27Set73Frame0 ; entry 0
    dw MetaSprites27Set73Frame1 ; entry 1
    dw MetaSprites27Set73Frame2 ; entry 2
    dw MetaSprites27Set73Frame3 ; entry 3
    dw MetaSprites27Set73Frame4 ; entry 4
    dw MetaSprites27Set73Frame5 ; entry 5

; frame 0 of MetaSprites27Set73; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set73; ends with $80 (E-0147)
MetaSprites27Set73Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set73; ends with $80 (E-0147)
MetaSprites27Set73Frame2::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set73; ends with $80 (E-0147)
MetaSprites27Set73Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set73; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set73; ends with $80 (E-0147)
MetaSprites27Set73Frame5::
    db $f0, $00, $0a, $20 ; entry 0
    db $f0, $f8, $0b, $20 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 116 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set74::
    dw MetaSprites27Set74Frame0 ; entry 0
    dw MetaSprites27Set74Frame1 ; entry 1
    dw MetaSprites27Set74Frame2 ; entry 2
    dw MetaSprites27Set74Frame3 ; entry 3
    dw MetaSprites27Set74Frame4 ; entry 4
    dw MetaSprites27Set74Frame5 ; entry 5

; frame 0 of MetaSprites27Set74; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame0::
    db $f0, $f8, $00, $10 ; entry 0
    db $f0, $00, $00, $30 ; entry 1
    db $f8, $f8, $01, $10 ; entry 2
    db $f8, $00, $02, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set74; ends with $80 (E-0147)
MetaSprites27Set74Frame1::
    db $f9, $f8, $04, $10 ; entry 0
    db $f9, $00, $05, $10 ; entry 1
    db $f1, $f8, $03, $10 ; entry 2
    db $f1, $00, $03, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set74; ends with $80 (E-0147)
MetaSprites27Set74Frame2::
    db $f0, $f8, $06, $10 ; entry 0
    db $f0, $00, $07, $10 ; entry 1
    db $f8, $f8, $08, $10 ; entry 2
    db $f8, $00, $09, $10 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set74; ends with $80 (E-0147)
MetaSprites27Set74Frame3::
    db $f9, $f8, $0a, $10 ; entry 0
    db $f9, $00, $0b, $10 ; entry 1
    db $f1, $f9, $06, $10 ; entry 2
    db $f1, $01, $07, $10 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set74; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame4::
    db $f0, $f8, $0c, $10 ; entry 0
    db $f8, $f8, $0e, $10 ; entry 1
    db $f8, $00, $0f, $10 ; entry 2
    db $f0, $00, $0c, $30 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set74; ends with $80 (E-0147)
MetaSprites27Set74Frame5::
    db $f9, $00, $0e, $30 ; entry 0
    db $f9, $f8, $0f, $30 ; entry 1
    db $f1, $f8, $0d, $10 ; entry 2
    db $f1, $00, $0d, $30 ; entry 3
    db $80 ; end

; meta-sprite set 124 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set7C::
    dw MetaSprites27Set7CFrame0 ; entry 0
    dw MetaSprites27Set7CFrame1 ; entry 1
    dw MetaSprites27Set7CFrame2 ; entry 2
    dw MetaSprites27Set7CFrame3 ; entry 3
    dw MetaSprites27Set7CFrame4 ; entry 4
    dw MetaSprites27Set7CFrame5 ; entry 5

; frame 0 of MetaSprites27Set7C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set7C; ends with $80 (E-0147)
MetaSprites27Set7CFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $ff, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set7C; ends with $80 (E-0147)
MetaSprites27Set7CFrame2::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set7C; ends with $80 (E-0147)
MetaSprites27Set7CFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set7C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $ff, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set7C; ends with $80 (E-0147)
MetaSprites27Set7CFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $ff, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 125 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set7D::
    dw MetaSprites27Set7DFrame0 ; entry 0
    dw MetaSprites27Set7DFrame1 ; entry 1
    dw MetaSprites27Set7DFrame2 ; entry 2
    dw MetaSprites27Set7DFrame3 ; entry 3
    dw MetaSprites27Set7DFrame4 ; entry 4
    dw MetaSprites27Set7DFrame5 ; entry 5

; frame 0 of MetaSprites27Set7D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set7D; ends with $80 (E-0147)
MetaSprites27Set7DFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $ff, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set7D; ends with $80 (E-0147)
MetaSprites27Set7DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set7D; ends with $80 (E-0147)
MetaSprites27Set7DFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set7D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f8, $f8, $0d, $00 ; entry 1
    db $f0, $ff, $0c, $20 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set7D; ends with $80 (E-0147)
MetaSprites27Set7DFrame5::
    db $f0, $f8, $0e, $00 ; entry 0
    db $f0, $ff, $0e, $20 ; entry 1
    db $f8, $f8, $0f, $00 ; entry 2
    db $f8, $ff, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 126 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites27Set7E::
    dw MetaSprites27Set7EFrame0 ; entry 0
    dw MetaSprites27Set7EFrame1 ; entry 1
    dw MetaSprites27Set7EFrame2 ; entry 2
    dw MetaSprites27Set7EFrame3 ; entry 3
    dw MetaSprites27Set7EFrame4 ; entry 4
    dw MetaSprites27Set7EFrame5 ; entry 5

; frame 0 of MetaSprites27Set7E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites27Set7E; ends with $80 (E-0147)
MetaSprites27Set7EFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites27Set7E; ends with $80 (E-0147)
MetaSprites27Set7EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites27Set7E; ends with $80 (E-0147)
MetaSprites27Set7EFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites27Set7E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites27Set7E; ends with $80 (E-0147)
MetaSprites27Set7EFrame5::
    db $f0, $00, $0c, $20 ; entry 0
    db $f0, $f8, $0d, $20 ; entry 1
    db $f8, $00, $0e, $20 ; entry 2
    db $f8, $f8, $0f, $20 ; entry 3
    db $80 ; end

; on CGB, with hTemp2 = 0, DecompressGraphicsTemp0ToTemp4 copies the 8 bytes at 27:$7328 + 8 *
; monster id to wOBJPaletteBuffer + 8 * hTemp3; the count matches MonsterSpriteTable (E-0143, C1)
; record: one CGB OBJ palette: 4 BGR555 colours
MonsterSpritePalettes::
    dw $0000, $6bff, $027f, $0800 ; id 0
    dw $0000, $6bff, $027f, $0800 ; id 1 DrakSlime
    dw $0000, $6bff, $035f, $0800 ; id 2 SpotSlime
    dw $0000, $01bf, $4ba0, $0800 ; id 3 WingSlime
    dw $0000, $03e2, $78b4, $0800 ; id 4 TreeSlime
    dw $0000, $6bff, $0f8a, $0800 ; id 5 Snaily
    dw $0000, $6bff, $3e60, $0800 ; id 6 SlimeNite
    dw $0000, $6bff, $0f8a, $0800 ; id 7 Babble
    dw $0000, $6bff, $0c7f, $0800 ; id 8 BoxSlime
    dw $0000, $6bff, $6f40, $0800 ; id 9 PearlGel
    dw $0000, $6bff, $7ea0, $0800 ; id 10 Slime
    dw $0000, $035f, $7ce1, $0800 ; id 11 Healer
    dw $0000, $027f, $4a60, $0800 ; id 12 FangSlime
    dw $0000, $3ad9, $0112, $0800 ; id 13 RockSlime
    dw $0000, $6bff, $31ac, $0800 ; id 14 SlimeBorg
    dw $0000, $6bff, $391f, $0800 ; id 15 Slabbit
    dw $0000, $031f, $7e42, $0800 ; id 16 KingSlime
    dw $0000, $6bff, $2549, $0800 ; id 17 Metaly
    dw $0000, $6bff, $296a, $0800 ; id 18 Metabble
    dw $0000, $6bff, $031f, $0800 ; id 19 SpotKing
    dw $0000, $6bff, $022a, $0800 ; id 20 TropicGel
    dw $0000, $03df, $4472, $0800 ; id 21 MimeSlime
    dw $0000, $7fe0, $391c, $0800 ; id 22 HaloSlime
    dw $0000, $2a1f, $2549, $0800 ; id 23 MetalKing
    dw $0000, $1bff, $029f, $0800 ; id 24 GoldSlime
    dw $0000, $6bff, $0240, $0800 ; id 25 GranSlime
    dw $0000, $6bff, $22de, $0800 ; id 26 WonderEgg
    dw $0000, $6bff, $027f, $0800 ; id 27 Butch
    dw $0000, $6bff, $027f, $0800 ; id 28 ?
    dw $0000, $6bff, $027f, $0800 ; id 29 ?
    dw $0000, $6bff, $027f, $0800 ; id 30 ?
    dw $0000, $6bff, $027f, $0800 ; id 31 ?
    dw $0000, $6bff, $027f, $0800 ; id 32 ?
    dw $0000, $6bff, $027f, $0800 ; id 33 ?
    dw $0000, $6bff, $027f, $0800 ; id 34 ?
    dw $0000, $6bff, $027f, $0800 ; id 35 ?
    dw $0000, $6bff, $01de, $0800 ; id 36 DragonKid
    dw $0000, $029f, $7e80, $0800 ; id 37 Tortragon
    dw $0000, $6bff, $7371, $0800 ; id 38 Pteranod
    dw $0000, $03bf, $1c37, $0800 ; id 39 Gasgon
    dw $0000, $209d, $37e0, $0800 ; id 40 FairyDrak
    dw $0000, $6bff, $6d48, $0800 ; id 41 LizardMan
    dw $0000, $6bff, $02d7, $0800 ; id 42 Poisongon
    dw $0000, $6bff, $7e00, $0800 ; id 43 Swordgon
    dw $0000, $6de7, $7f20, $0800 ; id 44 Drygon
    dw $0000, $33bf, $32a0, $0800 ; id 45 Dragon
    dw $0000, $6bff, $02bf, $0800 ; id 46 MiniDrak
    dw $0000, $6bff, $7e80, $0800 ; id 47 MadDragon
    dw $0000, $6bff, $02ff, $0800 ; id 48 Rayburn
    dw $0000, $0f7f, $06a0, $0800 ; id 49 Chamelgon
    dw $0000, $6bff, $03b6, $0800 ; id 50 LizardFly
    dw $0000, $6b5a, $1525, $0800 ; id 51 Andreal
    dw $0000, $075f, $1479, $0800 ; id 52 KingCobra
    dw $3800, $6bff, $71ed, $0800 ; id 53 Vampirus
    dw $3800, $6bff, $030b, $0800 ; id 54 SnakeBat
    dw $0000, $6bff, $3e51, $0800 ; id 55 Spikerous
    dw $0000, $075c, $0a3d, $0800 ; id 56 GreatDrak
    dw $0000, $007f, $06c5, $0800 ; id 57 Crestpent
    dw $0000, $033f, $7e60, $0800 ; id 58 WingSnake
    dw $0000, $1f00, $015a, $0800 ; id 59 Coatol
    dw $0000, $6bff, $0286, $0800 ; id 60 Orochi
    dw $0000, $037f, $076f, $0800 ; id 61 BattleRex
    dw $0000, $6bff, $023d, $0800 ; id 62 SkyDragon
    dw $0000, $7f20, $001d, $0800 ; id 63 Serpentia
    dw $0000, $6bff, $1bec, $0800 ; id 64 Divinegon
    dw $0000, $6bff, $01cf, $0800 ; id 65 Orligon
    dw $0000, $6bff, $155e, $0800 ; id 66 GigaDraco
    dw $0000, $6bff, $01de, $0800 ; id 67 ?
    dw $0000, $6bff, $01de, $0800 ; id 68 ?
    dw $0000, $6bff, $01de, $0800 ; id 69 ?
    dw $0000, $6bff, $01de, $0800 ; id 70 ?
    dw $0000, $7f00, $021a, $0800 ; id 71 Tonguella
    dw $0000, $6bff, $7cb8, $0800 ; id 72 Almiraj
    dw $0000, $6bff, $01ff, $0800 ; id 73 CatFly
    dw $0000, $02d3, $15ff, $0800 ; id 74 PillowRat
    dw $0000, $6bff, $0176, $0800 ; id 75 Saccer
    dw $0000, $6bff, $0270, $0800 ; id 76 GulpBeast
    dw $0000, $6bff, $033f, $0800 ; id 77 Skullroo
    dw $0000, $6bff, $7f00, $0800 ; id 78 WindBeast
    dw $0000, $6bff, $027d, $0800 ; id 79 Beavern
    dw $0000, $075f, $7dc7, $0800 ; id 80 Antbear
    dw $0000, $025f, $7c15, $0800 ; id 81 SuperTen
    dw $0000, $03e8, $00d6, $0800 ; id 82 IronTurt
    dw $0000, $035f, $4a53, $0800 ; id 83 Mommonja
    dw $0000, $01b6, $1b9f, $0800 ; id 84 HammerMan
    dw $0000, $6bff, $422e, $0800 ; id 85 Grizzly
    dw $0000, $6bff, $455f, $0800 ; id 86 Yeti
    dw $3800, $6bff, $5293, $0800 ; id 87 ArrowDog
    dw $3800, $6bff, $3416, $0800 ; id 88 NoctoKing
    dw $0000, $7fff, $1cff, $0800 ; id 89 BeastNite
    dw $0000, $6bff, $7a87, $0800 ; id 90 MadGopher
    dw $0000, $1b9f, $753c, $0800 ; id 91 FairyRat
    dw $0000, $6bff, $5a17, $0800 ; id 92 Unicorn
    dw $0000, $1b9f, $75a0, $0800 ; id 93 Goategon
    dw $0000, $075f, $6475, $0800 ; id 94 WildApe
    dw $0000, $7c1f, $76f0, $0800 ; id 95 Trumpeter
    dw $0000, $6bff, $7ee4, $0800 ; id 96 KingLeo
    dw $0000, $02bf, $7edc, $0800 ; id 97 DarkHorn
    dw $0000, $03bf, $01bf, $0800 ; id 98 MadCat
    dw $0000, $6bff, $01d8, $0800 ; id 99 BigEye
    dw $0000, $7fff, $027d, $0800 ; id 100 Gorago
    dw $0000, $4e52, $01d8, $0800 ; id 101 CatMage
    dw $0000, $025f, $451e, $0800 ; id 102 Dumbira
    dw $0000, $7f00, $021a, $0800 ; id 103 ?
    dw $0000, $7f00, $021a, $0800 ; id 104 ?
    dw $0000, $7f00, $021a, $0800 ; id 105 ?
    dw $0000, $201f, $02fe, $0800 ; id 106 Picky
    dw $0000, $5ef8, $011b, $0800 ; id 107 Wyvern
    dw $0000, $03df, $2cc6, $0800 ; id 108 BullBird
    dw $0000, $7d10, $1857, $0800 ; id 109 Florajay
    dw $0000, $6bff, $3c9f, $0800 ; id 110 DuckKite
    dw $0000, $7c1f, $01ff, $0800 ; id 111 MadPecker
    dw $0000, $7dd6, $02bb, $0800 ; id 112 MadRaven
    dw $0000, $077f, $00df, $0800 ; id 113 MistyWing
    dw $0000, $7ee0, $02bf, $0800 ; id 114 AquaHawk
    dw $0000, $6bff, $007b, $0800 ; id 115 Dracky
    dw $0000, $03e0, $540e, $0800 ; id 116 KiteHawk
    dw $0000, $37df, $3037, $0800 ; id 117 BigRoost
    dw $0000, $0fbf, $7de0, $0800 ; id 118 StubBird
    dw $0000, $6bff, $483b, $0800 ; id 119 LandOwl
    dw $0000, $0218, $0fbf, $0800 ; id 120 MadGoose
    dw $0000, $51f8, $6bff, $0800 ; id 121 MadCondor
    dw $0000, $009f, $7d40, $0800 ; id 122 Emyu
    dw $0000, $66d4, $6bff, $0800 ; id 123 Blizzardy
    dw $0000, $179f, $00bb, $0800 ; id 124 Phoenix
    dw $0000, $03fd, $7d2f, $0800 ; id 125 ZapBird
    dw $0000, $037f, $6566, $0800 ; id 126 Garudian
    dw $0000, $179f, $0033, $0800 ; id 127 WhipBird
    dw $0000, $179f, $7f69, $0800 ; id 128 FunkyBird
    dw $0000, $179f, $3c1f, $0800 ; id 129 RainHawk
    dw $0000, $039f, $1fd3, $0800 ; id 130 Azurile
    dw $0000, $039f, $5cef, $0800 ; id 131 Shantak
    dw $0000, $077f, $7ea0, $0800 ; id 132 CragDevil
    dw $0000, $201f, $02fe, $0800 ; id 133 ?
    dw $0000, $201f, $02fe, $0800 ; id 134 ?
    dw $0000, $201f, $02fe, $0800 ; id 135 ?
    dw $0000, $201f, $02fe, $0800 ; id 136 ?
    dw $0000, $201f, $02fe, $0800 ; id 137 ?
    dw $0000, $201f, $02fe, $0800 ; id 138 ?
    dw $0000, $201f, $02fe, $0800 ; id 139 ?
    dw $0000, $201f, $02fe, $0800 ; id 140 ?
    dw $0000, $031e, $038d, $0800 ; id 141 MadPlant
    dw $0000, $7d35, $2feb, $0800 ; id 142 FireWeed
    dw $0000, $7f4f, $60b2, $0800 ; id 143 FloraMan
    dw $0000, $640e, $02f1, $0800 ; id 144 WingTree
    dw $0000, $6bff, $032a, $0800 ; id 145 CactiBall
    dw $0000, $6bff, $038d, $0800 ; id 146 Gulpple
    dw $0000, $6bff, $6891, $0800 ; id 147 Toadstool
    dw $0000, $7e19, $01ff, $0800 ; id 148 AmberWeed
    dw $0000, $6bff, $0320, $0800 ; id 149 Slurperon
    dw $0000, $6bff, $0110, $0800 ; id 150 Stubsuck
    dw $0000, $02df, $02ed, $0800 ; id 151 Oniono
    dw $0000, $0360, $025f, $0800 ; id 152 DanceVegi
    dw $0000, $6ff1, $012f, $0800 ; id 153 TreeBoy
    dw $0000, $6bff, $0115, $0800 ; id 154 Devipine
    dw $0000, $001f, $0217, $0800 ; id 155 FaceTree
    dw $0000, $02c0, $0217, $0800 ; id 156 HerbMan
    dw $0000, $033f, $032c, $0800 ; id 157 BeanMan
    dw $0000, $6bff, $021f, $0800 ; id 158 EvilSeed
    dw $0000, $03aa, $005b, $0800 ; id 159 ManEater
    dw $0000, $6bff, $01c8, $0800 ; id 160 Snapper
    dw $0000, $6bff, $2a16, $0800 ; id 161 GhosTree
    dw $0000, $001f, $036c, $0800 ; id 162 Rosevine
    dw $0000, $036c, $296d, $0800 ; id 163 Egdracil
    dw $0000, $6e5f, $6017, $0800 ; id 164 Warubou
OBJPaletteBufferPlus18Data::
    dw $0000, $7fb5, $7ea6, $0800 ; id 165 Watabou
    dw $0000, $7fff, $6cd6, $0800 ; id 166 Eggplaton
    dw $0000, $02ff, $024a, $0800 ; id 167 FooHero
    dw $0000, $031e, $038d, $0800 ; id 168 ?
    dw $0000, $031e, $038d, $0800 ; id 169 ?
    dw $0000, $031e, $038d, $0800 ; id 170 ?
    dw $0000, $031e, $038d, $0800 ; id 171 ?
    dw $0000, $031e, $038d, $0800 ; id 172 ?
    dw $0000, $031e, $038d, $0800 ; id 173 ?
    dw $0000, $031e, $038d, $0800 ; id 174 ?
    dw $0000, $031e, $038d, $0800 ; id 175 ?
    dw $0000, $475f, $0275, $0800 ; id 176 GiantSlug
    dw $0000, $7ddf, $034b, $0800 ; id 177 Catapila
    dw $0000, $371f, $01dc, $0800 ; id 178 Gophecada
    dw $0000, $7fff, $7cb7, $0800 ; id 179 Butterfly
    dw $0000, $63f4, $36c0, $0800 ; id 180 WeedBug
    dw $0000, $729f, $3cfb, $0800 ; id 181 GiantWorm
    dw $0000, $4eff, $034f, $0800 ; id 182 Lipsy
    dw $0000, $6980, $0258, $0800 ; id 183 StagBug
    dw $0000, $427f, $017f, $0800 ; id 184 Pyuro
    dw $0000, $7fff, $3f01, $0800 ; id 185 ArmyAnt
    dw $0000, $7fff, $029d, $0800 ; id 186 GoHopper
    dw $0000, $3eb8, $3538, $0800 ; id 187 TailEater
    dw $0000, $7fff, $013f, $0800 ; id 188 ArmorPede
    dw $0000, $7fff, $027f, $0800 ; id 189 Eyeder
    dw $0000, $1b5d, $0278, $0800 ; id 190 GiantMoth
    dw $0000, $627f, $3157, $0800 ; id 191 Droll
    dw $0000, $7fff, $01bf, $0800 ; id 192 ArmyCrab
    dw $0000, $7fff, $021d, $0800 ; id 193 MadHornet
    dw $0000, $037f, $601a, $0800 ; id 194 Belzebub
    dw $0000, $037f, $0208, $0800 ; id 195 WarMantis
    dw $0000, $0218, $00d0, $0800 ; id 196 HornBeet
    dw $0000, $6bff, $2be0, $0800 ; id 197 Sickler
    dw $0000, $6bff, $017d, $0800 ; id 198 Armorpion
    dw $0000, $6bff, $04bd, $0800 ; id 199 Digster
    dw $0000, $6bff, $541f, $0800 ; id 200 Skularach
    dw $0000, $7fff, $017d, $0800 ; id 201 MultiEyes
    dw $0000, $475f, $0275, $0800 ; id 202 ?
    dw $0000, $475f, $0275, $0800 ; id 203 ?
    dw $0000, $475f, $0275, $0800 ; id 204 ?
    dw $0000, $475f, $0275, $0800 ; id 205 ?
    dw $0000, $475f, $0275, $0800 ; id 206 ?
    dw $0000, $475f, $0275, $0800 ; id 207 ?
    dw $0000, $475f, $0275, $0800 ; id 208 ?
    dw $0000, $475f, $0275, $0800 ; id 209 ?
    dw $0000, $475f, $0275, $0800 ; id 210 ?
    dw $0000, $6bff, $7dc0, $0800 ; id 211 Pixy
    dw $0000, $6bff, $7a00, $0800 ; id 212 MedusaEye
    dw $0000, $6bff, $7ee7, $0800 ; id 213 AgDevil
    dw $0000, $6bff, $023f, $0800 ; id 214 Demonite
    dw $0000, $6bff, $7d57, $0800 ; id 215 DarkEye
    dw $0000, $6bff, $7ea4, $0800 ; id 216 EyeBall
    dw $0000, $6bff, $029f, $0800 ; id 217 SkulRider
    dw $0000, $6bff, $6a18, $0800 ; id 218 EvilBeast
    dw $0000, $6bff, $170e, $0800 ; id 219 Bubblemon
    dw $0000, $179f, $009b, $0800 ; id 220 1EyeClown
    dw $0000, $71bc, $179f, $0800 ; id 221 Gremlin
    dw $0000, $179f, $64b9, $0800 ; id 222 ArcDemon
    dw $0000, $6bff, $023c, $0800 ; id 223 Lionex
    dw $0000, $6bff, $011c, $0800 ; id 224 GoatHorn
    dw $0000, $6bff, $025d, $0800 ; id 225 Orc
    dw $0000, $6bff, $0f68, $0800 ; id 226 Ogre
    dw $0000, $179f, $5917, $0800 ; id 227 GateGuard
    dw $0000, $6bff, $7d8e, $0800 ; id 228 ChopClown
    dw $0000, $6bff, $032b, $0800 ; id 229 BossTroll
    dw $0000, $6bff, $7ea0, $0800 ; id 230 Grendal
    dw $0000, $6bff, $029f, $0800 ; id 231 Akubar
    dw $0000, $6bff, $3544, $0800 ; id 232 MadKnight
    dw $0000, $6bff, $001b, $0800 ; id 233 EvilWell
    dw $0000, $6be0, $6580, $0800 ; id 234 Gigantes
    dw $0000, $0f7f, $7720, $0800 ; id 235 Centasaur
    dw $0000, $6bff, $001d, $0800 ; id 236 EvilArmor
    dw $0000, $179f, $5a53, $0800 ; id 237 Jamirus
    dw $0000, $6bff, $01df, $0800 ; id 238 Durran
    dw $0000, $6bff, $3c73, $0800 ; id 239 Titanis
    dw $0000, $6bff, $748f, $0800 ; id 240 LampGenie
    dw $0000, $6bff, $7dc0, $0800 ; id 241 ?
    dw $0000, $6bff, $7dc0, $0800 ; id 242 ?
    dw $0000, $6bff, $7dc0, $0800 ; id 243 ?
    dw $0000, $6bff, $7dc0, $0800 ; id 244 ?
    dw $0000, $6bff, $7dc0, $0800 ; id 245 ?
    dw $0000, $029f, $011e, $0800 ; id 246 Spooky
    dw $0000, $42dc, $1992, $0800 ; id 247 Skullgon
    dw $0000, $7fff, $7a20, $0800 ; id 248 PutrePup
    dw $0000, $531e, $4472, $0800 ; id 249 RotRaven
    dw $0000, $7e7f, $70f5, $0800 ; id 250 Mummy
    dw $0000, $7fff, $5cca, $0800 ; id 251 DarkCrab
    dw $0000, $7fff, $0196, $0800 ; id 252 DeadNite
    dw $0000, $02bf, $420b, $0800 ; id 253 Shadow
    dw $0000, $6bff, $601a, $0800 ; id 254 Skulpent
    dw $0000, $7fff, $0196, $0800 ; id 255 Hork
    dw $0000, $03bf, $0219, $0800 ; id 256 Mudron
    dw $0000, $33ff, $027c, $0800 ; id 257 NiteWhip
    dw $0000, $03ff, $7f46, $0800 ; id 258 WindMerge
    dw $0000, $6abf, $021d, $0800 ; id 259 Reaper
    dw $0000, $7f00, $2a16, $0800 ; id 260 Inverzon
    dw $0000, $7f00, $7d80, $0800 ; id 261 FoxFire
    dw $0000, $6bff, $001d, $0800 ; id 262 CaptDead
    dw $0000, $7fff, $7d88, $0800 ; id 263 DeadNoble
    dw $0000, $7e5f, $447b, $0800 ; id 264 WhiteKing
    dw $0000, $3f1c, $017e, $0800 ; id 265 BoneSlave
    dw $0000, $7fff, $7571, $0800 ; id 266 Skeletor
    dw $0000, $7fff, $28d0, $0800 ; id 267 Servant
    dw $0000, $007f, $7c15, $0800 ; id 268 Lazamanus
    dw $0000, $035f, $021c, $0800 ; id 269 Copycat
    dw $0000, $7fff, $68f8, $0800 ; id 270 MadSpirit
    dw $0000, $02dd, $501f, $0800 ; id 271 PomPomBom
    dw $0000, $135f, $3c1d, $0800 ; id 272 Niterich
    dw $0000, $029f, $011e, $0800 ; id 273 ?
    dw $0000, $029f, $011e, $0800 ; id 274 ?
    dw $0000, $029f, $011e, $0800 ; id 275 ?
    dw $0000, $029f, $011e, $0800 ; id 276 ?
    dw $0000, $029f, $011e, $0800 ; id 277 ?
    dw $0000, $029f, $011e, $0800 ; id 278 ?
    dw $0000, $029f, $011e, $0800 ; id 279 ?
    dw $0000, $029f, $011e, $0800 ; id 280 ?
    dw $0000, $33ff, $023f, $0800 ; id 281 JewelBag
    dw $0000, $4b7f, $021a, $0800 ; id 282 EvilWand
    dw $0000, $6bff, $021f, $0800 ; id 283 MadCandle
    dw $0000, $033f, $01fd, $0800 ; id 284 CoilBird
    dw $0000, $439f, $190f, $0800 ; id 285 Facer
    dw $0000, $6bff, $036d, $0800 ; id 286 SpikyBoy
    dw $0000, $439f, $1417, $0800 ; id 287 MadMirror
    dw $0000, $7ed9, $0038, $0800 ; id 288 RogueNite
    dw $0000, $3b5e, $170e, $0800 ; id 289 Puppetor
    dw $0000, $3b5e, $025c, $0800 ; id 290 Goopi
    dw $0000, $03ff, $5815, $0800 ; id 291 Voodoll
    dw $0000, $6bff, $7f54, $0800 ; id 292 MetalDrak
    dw $0000, $03ff, $38ed, $0800 ; id 293 Balzak
    dw $0000, $6bff, $7f0b, $0800 ; id 294 SabreMan
    dw $0000, $6bff, $02bf, $0800 ; id 295 CurseLamp
    dw $0000, $3b5e, $0160, $0800 ; id 296 Brushead
    dw $0000, $6bff, $7ec5, $0800 ; id 297 Roboster
    dw $0000, $6bff, $7dc0, $0800 ; id 298 Roboster2
    dw $0000, $7d9f, $025c, $0800 ; id 299 EvilPot
    dw $0000, $6bff, $4dcd, $0800 ; id 300 Gismo
    dw $0000, $6bff, $0018, $0800 ; id 301 LavaMan
    dw $0000, $6bff, $7e09, $0800 ; id 302 IceMan
    dw $0000, $7f15, $59ec, $0800 ; id 303 Mimic
    dw $0000, $6bff, $7eec, $0800 ; id 304 Exaucers
    dw $0000, $1ebc, $01b7, $0800 ; id 305 MudDoll
    dw $0000, $6bff, $025b, $0800 ; id 306 Golem
    dw $0000, $6bff, $3a73, $0800 ; id 307 StoneMan
    dw $0000, $6bff, $6186, $0800 ; id 308 BombCrag
    dw $0000, $6bff, $02ff, $0800 ; id 309 GoldGolem
    dw $0000, $00df, $7969, $0800 ; id 310 DarkMate
    dw $0000, $7fff, $7d00, $0800 ; id 311 ProtoMech
    dw $0000, $7fff, $7e87, $0800 ; id 312 CloudKing
    dw $0000, $33ff, $023f, $0800 ; id 313 ?
    dw $0000, $33ff, $023f, $0800 ; id 314 ?
    dw $0000, $33ff, $023f, $0800 ; id 315 ?
    dw $0000, $6bff, $6c17, $0800 ; id 316 Petiteel
    dw $0000, $7d80, $023f, $0800 ; id 317 Moray
    dw $0000, $6bff, $169f, $0800 ; id 318 WalrusMan
    dw $0000, $6bff, $1c1c, $0800 ; id 319 RayGigas
    dw $0000, $6bff, $0099, $0800 ; id 320 Anemon
    dw $0000, $6bff, $5413, $0800 ; id 321 Aquarella
    dw $0000, $6bff, $65ab, $0800 ; id 322 Merman
    dw $0000, $6bff, $493f, $0800 ; id 323 Octokid
    dw $0000, $7fff, $24d3, $0800 ; id 324 PutreFish
    dw $0000, $033f, $7230, $0800 ; id 325 Octoreach
    dw $0000, $6bff, $2552, $0800 ; id 326 Angleron
    dw $0000, $6bff, $7f00, $0800 ; id 327 FishRider
    dw $0000, $6bff, $60a3, $0800 ; id 328 RushFish
    dw $0000, $6bff, $007f, $0800 ; id 329 Gamanian
    dw $0000, $6bff, $027b, $0800 ; id 330 Clawster
    dw $0000, $6bff, $017f, $0800 ; id 331 CancerMan
    dw $0000, $6bff, $5182, $0800 ; id 332 RogueWave
    dw $0000, $6bff, $74db, $0800 ; id 333 Scallopa
    dw $0000, $6bff, $5413, $0800 ; id 334 SeaHorse
    dw $0000, $6be8, $281b, $0800 ; id 335 HoodSquid
    dw $0000, $6bff, $02ff, $0800 ; id 336 MerTiger
    dw $0000, $6bff, $7e40, $0800 ; id 337 AxeShark
    dw $0000, $6bff, $7dcd, $0800 ; id 338 Octogon
    dw $0000, $6bff, $7d5a, $0800 ; id 339 KingSquid
    dw $0000, $6bff, $021f, $0800 ; id 340 Digong
    dw $0000, $6bff, $5413, $0800 ; id 341 WhaleMage
    dw $0000, $037f, $69ee, $0800 ; id 342 Aquadon
    dw $0000, $039f, $005b, $0800 ; id 343 Octoraid
    dw $0000, $03df, $0ac3, $0800 ; id 344 Grakos
    dw $0000, $6bff, $0320, $0800 ; id 345 Poseidon
    dw $0000, $7fff, $0240, $0800 ; id 346 Pumpoise
    dw $0000, $56a0, $1859, $0800 ; id 347 Starfish
    dw $0000, $6bff, $6c17, $0800 ; id 348 ?
    dw $0000, $6bff, $6c17, $0800 ; id 349 ?
    dw $0000, $6bff, $6c17, $0800 ; id 350 ?
    dw $0000, $6bff, $4414, $0800 ; id 351 DracoLord
    dw $0000, $019f, $6c73, $0800 ; id 352 DracoLord
    dw $0000, $6bff, $653b, $0800 ; id 353 LordDraco
    dw $0000, $6bff, $6c1a, $0800 ; id 354 Hargon
    dw $0000, $019f, $7e20, $0800 ; id 355 Sidoh
    dw $0000, $02bf, $51d4, $0800 ; id 356 Genosidoh
    dw $0000, $03e9, $6939, $0800 ; id 357 Baramos
    dw $0000, $6bff, $015c, $0800 ; id 358 Zoma
    dw $0000, $6bff, $75a0, $0800 ; id 359 AsuraZoma
    dw $0000, $6bff, $0e71, $0800 ; id 360 Pizzaro
    dw $0000, $03e9, $60dd, $0800 ; id 361 PsychoPiz
    dw $0000, $6bff, $00bf, $0800 ; id 362 Esterk
    dw $0000, $6bff, $0310, $0800 ; id 363 Mirudraas
    dw $0000, $6bff, $493f, $0800 ; id 364 Mirudraas
    dw $0000, $325f, $02e0, $0800 ; id 365 Mudou
    dw $0000, $6bff, $493f, $0800 ; id 366 DeathMore
    dw $0000, $6bff, $493f, $0800 ; id 367 DeathMore
    dw $0000, $03ff, $493f, $0800 ; id 368 DeathMore
    dw $0000, $425a, $0553, $0800 ; id 369 Darkdrium
    dw $0000, $6f7b, $480d, $0800 ; id 370 Orgodemir
    dw $0000, $6f7b, $3ea8, $0800 ; id 371 Orgodemir
    dw $0000, $6bff, $021f, $0800 ; id 372 Darck
    dw $0000, $6bff, $4414, $0800 ; id 373 Tatsu
    dw $0000, $6bff, $4414, $0800 ; id 374 Diago
    dw $0000, $6bff, $4414, $0800 ; id 375 Samsi
    dw $0000, $6bff, $4414, $0800 ; id 376 Bazoo
    dw $0000, $6bff, $4414, $0800 ; id 377 ?
    dw $0000, $6bff, $4414, $0800 ; id 378 ?
    dw $0000, $6bff, $4414, $0800 ; id 379 ?
    dw $0000, $6bff, $009f, $0800 ; id 380 Lamia
    dw $0000, $6bff, $6f50, $0800 ; id 381 Dimensaur
    dw $0000, $331f, $021f, $0800 ; id 382 Kagebou
    dw $0000, $0000, $0000, $0000 ; id 383 ?
    ds $d8, $00
