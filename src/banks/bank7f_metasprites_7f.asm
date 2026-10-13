; ROM bank $7F: meta-sprite frames
; The annotated listing of this bank is build/listing/bank7f.asm.

SECTION "Bank 7F", ROMX[$4000], BANK[$7F]
    db $7f

; DrawMetaSpriteAt_40CC with DE = MetaSprites7F_4008Table (E-0116)
DrawMetaSprite4008::
    ld de, MetaSprites7F_4008Table
    call DrawMetaSpriteAt_40CC
    ret

; the caller of DrawMetaSprite4008 passes DE = $MetaSprites7F_4008Table; the builder takes the word
; at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 98
; words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites7F_4008Table::
    dw MetaSprites7F_4008Set00 ; id 0
    dw MetaSprites7F_4008Set01 ; id 1
    dw MetaSprites7F_4008Set02 ; id 2
    dw MetaSprites7F_4008Set03 ; id 3
    dw MetaSprites7F_4008Set04 ; id 4
    dw MetaSprites7F_4008Set05 ; id 5
    dw MetaSprites7F_4008Set06 ; id 6
    dw MetaSprites7F_4008Set07 ; id 7
    dw MetaSprites7F_4008Set08 ; id 8
    dw MetaSprites7F_4008Set09 ; id 9
    dw MetaSprites7F_4008Set0A ; id 10
    dw MetaSprites7F_4008Set0B ; id 11
    dw MetaSprites7F_4008Set0C ; id 12
    dw MetaSprites7F_4008Set0D ; id 13
    dw MetaSprites7F_4008Set0E ; id 14
    dw MetaSprites7F_4008Set0F ; id 15
    dw MetaSprites7F_4008Set10 ; id 16
    dw MetaSprites7F_4008Set11 ; id 17
    dw MetaSprites7F_4008Set12 ; id 18
    dw MetaSprites7F_4008Set13 ; id 19
    dw MetaSprites7F_4008Set14 ; id 20
    dw MetaSprites7F_4008Set15 ; id 21
    dw MetaSprites7F_4008Set16 ; id 22
    dw MetaSprites7F_4008Set17 ; id 23
    dw MetaSprites7F_4008Set18 ; id 24
    dw MetaSprites7F_4008Set19 ; id 25
    dw MetaSprites7F_4008Set1A ; id 26
    dw MetaSprites7F_4008Set1B ; id 27
    dw MetaSprites7F_4008Set1C ; id 28
    dw MetaSprites7F_4008Set1D ; id 29
    dw MetaSprites7F_4008Set1E ; id 30
    dw MetaSprites7F_4008Set1F ; id 31
    dw MetaSprites7F_4008Set20 ; id 32
    dw MetaSprites7F_4008Set21 ; id 33
    dw MetaSprites7F_4008Set22 ; id 34
    dw MetaSprites7F_4008Set23 ; id 35
    dw MetaSprites7F_4008Set24 ; id 36
    dw MetaSprites7F_4008Set25 ; id 37
    dw MetaSprites7F_4008Set26 ; id 38
    dw MetaSprites7F_4008Set27 ; id 39
    dw MetaSprites7F_4008Set28 ; id 40
    dw MetaSprites7F_4008Set29 ; id 41
    dw MetaSprites7F_4008Set2A ; id 42
    dw MetaSprites7F_4008Set2B ; id 43
    dw MetaSprites7F_4008Set2C ; id 44
    dw MetaSprites7F_4008Set2D ; id 45
    dw MetaSprites7F_4008Set2E ; id 46
    dw MetaSprites7F_4008Set2F ; id 47
    dw MetaSprites7F_4008Set30 ; id 48
    dw MetaSprites7F_4008Set31 ; id 49
    dw MetaSprites7F_4008Set32 ; id 50
    dw MetaSprites7F_4008Set33 ; id 51
    dw MetaSprites7F_4008Set34 ; id 52
    dw MetaSprites7F_4008Set35 ; id 53
    dw MetaSprites7F_4008Set36 ; id 54
    dw MetaSprites7F_4008Set37 ; id 55
    dw MetaSprites7F_4008Set38 ; id 56
    dw MetaSprites7F_4008Set39 ; id 57
    dw MetaSprites7F_4008Set3A ; id 58
    dw MetaSprites7F_4008Set3B ; id 59
    dw MetaSprites7F_4008Set3C ; id 60
    dw MetaSprites7F_4008Set3D ; id 61
    dw MetaSprites7F_4008Set3E ; id 62
    dw MetaSprites7F_4008Set3F ; id 63
    dw MetaSprites7F_4008Set40 ; id 64
    dw MetaSprites7F_4008Set41 ; id 65
    dw MetaSprites7F_4008Set42 ; id 66
    dw MetaSprites7F_4008Set43 ; id 67
    dw MetaSprites7F_4008Set44 ; id 68
    dw MetaSprites7F_4008Set45 ; id 69
    dw MetaSprites7F_4008Set46 ; id 70
    dw MetaSprites7F_4008Set47 ; id 71
    dw MetaSprites7F_4008Set48 ; id 72
    dw MetaSprites7F_4008Set49 ; id 73
    dw MetaSprites7F_4008Set4A ; id 74
    dw MetaSprites7F_4008Set4B ; id 75
    dw MetaSprites7F_4008Set4C ; id 76
    dw MetaSprites7F_4008Set4D ; id 77
    dw MetaSprites7F_4008Set4E ; id 78
    dw MetaSprites7F_4008Set4F ; id 79
    dw MetaSprites7F_4008Set50 ; id 80
    dw MetaSprites7F_4008Set51 ; id 81
    dw MetaSprites7F_4008Set52 ; id 82
    dw MetaSprites7F_4008Set53 ; id 83
    dw MetaSprites7F_4008Set54 ; id 84
    dw MetaSprites7F_4008Set55 ; id 85
    dw MetaSprites7F_4008Set56 ; id 86
    dw MetaSprites7F_4008Set57 ; id 87
    dw MetaSprites7F_4008Set58 ; id 88
    dw MetaSprites7F_4008Set59 ; id 89
    dw MetaSprites7F_4008Set5A ; id 90
    dw MetaSprites7F_4008Set5B ; id 91
    dw MetaSprites7F_4008Set5C ; id 92
    dw MetaSprites7F_4008Set46 ; id 93
    dw MetaSprites7F_4008Set46 ; id 94
    dw MetaSprites7F_4008Set5F ; id 95
    dw MetaSprites7F_4008Set46 ; id 96
    dw MetaSprites7F_4008Set61 ; id 97

; the same instruction sequence as DrawMetaSpriteAt (bank $7F) apart from label operands, which
; refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
DrawMetaSpriteAt_40CC::
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
    call BGTileUnderPointIsSpriteHideTile_Bank7F_4312
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
    call BGTileUnderPointIsSpriteHideTile_Bank7F_4312
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
BGTileUnderPointIsSpriteHideTile_Bank7F_4312::
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

; meta-sprite set 0 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set00::
    dw MetaSprites7F_4008Set00Frame0 ; entry 0
    dw MetaSprites7F_4008Set00Frame1 ; entry 1
    dw MetaSprites7F_4008Set00Frame2 ; entry 2
    dw MetaSprites7F_4008Set00Frame3 ; entry 3
    dw MetaSprites7F_4008Set00Frame4 ; entry 4
    dw MetaSprites7F_4008Set00Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set00; ends with $80 (E-0147)
MetaSprites7F_4008Set00Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set00; ends with $80 (E-0147)
MetaSprites7F_4008Set00Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set00; ends with $80 (E-0147)
MetaSprites7F_4008Set00Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set00; ends with $80 (E-0147)
MetaSprites7F_4008Set00Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 1 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set01::
    dw MetaSprites7F_4008Set01Frame0 ; entry 0
    dw MetaSprites7F_4008Set01Frame1 ; entry 1
    dw MetaSprites7F_4008Set01Frame2 ; entry 2
    dw MetaSprites7F_4008Set01Frame3 ; entry 3
    dw MetaSprites7F_4008Set01Frame4 ; entry 4
    dw MetaSprites7F_4008Set01Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set01; ends with $80 (E-0147)
MetaSprites7F_4008Set01Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set01; ends with $80 (E-0147)
MetaSprites7F_4008Set01Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set01; ends with $80 (E-0147)
MetaSprites7F_4008Set01Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set01; ends with $80 (E-0147)
MetaSprites7F_4008Set01Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set02::
    dw MetaSprites7F_4008Set02Frame0 ; entry 0
    dw MetaSprites7F_4008Set02Frame1 ; entry 1
    dw MetaSprites7F_4008Set02Frame2 ; entry 2
    dw MetaSprites7F_4008Set02Frame3 ; entry 3
    dw MetaSprites7F_4008Set02Frame4 ; entry 4
    dw MetaSprites7F_4008Set02Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set02; ends with $80 (E-0147)
MetaSprites7F_4008Set02Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set02; ends with $80 (E-0147)
MetaSprites7F_4008Set02Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set02; ends with $80 (E-0147)
MetaSprites7F_4008Set02Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set02; ends with $80 (E-0147)
MetaSprites7F_4008Set02Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set03::
    dw MetaSprites7F_4008Set03Frame0 ; entry 0
    dw MetaSprites7F_4008Set03Frame1 ; entry 1
    dw MetaSprites7F_4008Set03Frame2 ; entry 2
    dw MetaSprites7F_4008Set03Frame3 ; entry 3
    dw MetaSprites7F_4008Set03Frame4 ; entry 4
    dw MetaSprites7F_4008Set03Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set03; ends with $80 (E-0147)
MetaSprites7F_4008Set03Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set03; ends with $80 (E-0147)
MetaSprites7F_4008Set03Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set03; ends with $80 (E-0147)
MetaSprites7F_4008Set03Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set03; ends with $80 (E-0147)
MetaSprites7F_4008Set03Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $ff, $0c, $20 ; entry 2
    db $f9, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set04::
    dw MetaSprites7F_4008Set04Frame0 ; entry 0
    dw MetaSprites7F_4008Set04Frame1 ; entry 1
    dw MetaSprites7F_4008Set04Frame2 ; entry 2
    dw MetaSprites7F_4008Set04Frame3 ; entry 3
    dw MetaSprites7F_4008Set04Frame4 ; entry 4
    dw MetaSprites7F_4008Set04Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set04; ends with $80 (E-0147)
MetaSprites7F_4008Set04Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set04; ends with $80 (E-0147)
MetaSprites7F_4008Set04Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set04; ends with $80 (E-0147)
MetaSprites7F_4008Set04Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set04; ends with $80 (E-0147)
MetaSprites7F_4008Set04Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set05::
    dw MetaSprites7F_4008Set05Frame0 ; entry 0
    dw MetaSprites7F_4008Set05Frame1 ; entry 1
    dw MetaSprites7F_4008Set05Frame2 ; entry 2
    dw MetaSprites7F_4008Set05Frame3 ; entry 3
    dw MetaSprites7F_4008Set05Frame4 ; entry 4
    dw MetaSprites7F_4008Set05Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set05; ends with $80 (E-0147)
MetaSprites7F_4008Set05Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set05; ends with $80 (E-0147)
MetaSprites7F_4008Set05Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set05; ends with $80 (E-0147)
MetaSprites7F_4008Set05Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set05; ends with $80 (E-0147)
MetaSprites7F_4008Set05Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 6 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set06::
    dw MetaSprites7F_4008Set06Frame0 ; entry 0
    dw MetaSprites7F_4008Set06Frame1 ; entry 1
    dw MetaSprites7F_4008Set06Frame2 ; entry 2
    dw MetaSprites7F_4008Set06Frame3 ; entry 3
    dw MetaSprites7F_4008Set06Frame4 ; entry 4
    dw MetaSprites7F_4008Set06Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set06; ends with $80 (E-0147)
MetaSprites7F_4008Set06Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set06; ends with $80 (E-0147)
MetaSprites7F_4008Set06Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set06; ends with $80 (E-0147)
MetaSprites7F_4008Set06Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set06; ends with $80 (E-0147)
MetaSprites7F_4008Set06Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 7 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set07::
    dw MetaSprites7F_4008Set07Frame0 ; entry 0
    dw MetaSprites7F_4008Set07Frame1 ; entry 1
    dw MetaSprites7F_4008Set07Frame2 ; entry 2
    dw MetaSprites7F_4008Set07Frame3 ; entry 3
    dw MetaSprites7F_4008Set07Frame4 ; entry 4
    dw MetaSprites7F_4008Set07Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set07; ends with $80 (E-0147)
MetaSprites7F_4008Set07Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set07; ends with $80 (E-0147)
MetaSprites7F_4008Set07Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set07; ends with $80 (E-0147)
MetaSprites7F_4008Set07Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set07; ends with $80 (E-0147)
MetaSprites7F_4008Set07Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 8 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set08::
    dw MetaSprites7F_4008Set08Frame0 ; entry 0
    dw MetaSprites7F_4008Set08Frame1 ; entry 1
    dw MetaSprites7F_4008Set08Frame2 ; entry 2
    dw MetaSprites7F_4008Set08Frame3 ; entry 3
    dw MetaSprites7F_4008Set08Frame4 ; entry 4
    dw MetaSprites7F_4008Set08Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set08; ends with $80 (E-0147)
MetaSprites7F_4008Set08Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set08; ends with $80 (E-0147)
MetaSprites7F_4008Set08Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set08; ends with $80 (E-0147)
MetaSprites7F_4008Set08Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set08; ends with $80 (E-0147)
MetaSprites7F_4008Set08Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 9 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set09::
    dw MetaSprites7F_4008Set09Frame0 ; entry 0
    dw MetaSprites7F_4008Set09Frame1 ; entry 1
    dw MetaSprites7F_4008Set09Frame2 ; entry 2
    dw MetaSprites7F_4008Set09Frame3 ; entry 3
    dw MetaSprites7F_4008Set09Frame4 ; entry 4
    dw MetaSprites7F_4008Set09Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set09; ends with $80 (E-0147)
MetaSprites7F_4008Set09Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set09; ends with $80 (E-0147)
MetaSprites7F_4008Set09Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set09; ends with $80 (E-0147)
MetaSprites7F_4008Set09Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set09; ends with $80 (E-0147)
MetaSprites7F_4008Set09Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 10 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set0A::
    dw MetaSprites7F_4008Set0AFrame0 ; entry 0
    dw MetaSprites7F_4008Set0AFrame1 ; entry 1
    dw MetaSprites7F_4008Set0AFrame2 ; entry 2
    dw MetaSprites7F_4008Set0AFrame3 ; entry 3
    dw MetaSprites7F_4008Set0AFrame4 ; entry 4
    dw MetaSprites7F_4008Set0AFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set0A; ends with $80 (E-0147)
MetaSprites7F_4008Set0AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set0A; ends with $80 (E-0147)
MetaSprites7F_4008Set0AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set0A; ends with $80 (E-0147)
MetaSprites7F_4008Set0AFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set0A; ends with $80 (E-0147)
MetaSprites7F_4008Set0AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 11 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set0B::
    dw MetaSprites7F_4008Set0BFrame0 ; entry 0
    dw MetaSprites7F_4008Set0BFrame1 ; entry 1
    dw MetaSprites7F_4008Set0BFrame2 ; entry 2
    dw MetaSprites7F_4008Set0BFrame3 ; entry 3
    dw MetaSprites7F_4008Set0BFrame4 ; entry 4
    dw MetaSprites7F_4008Set0BFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set0B; ends with $80 (E-0147)
MetaSprites7F_4008Set0BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set0B; ends with $80 (E-0147)
MetaSprites7F_4008Set0BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set0B; ends with $80 (E-0147)
MetaSprites7F_4008Set0BFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set0B; ends with $80 (E-0147)
MetaSprites7F_4008Set0BFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 12 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set0C::
    dw MetaSprites7F_4008Set0CFrame0 ; entry 0
    dw MetaSprites7F_4008Set0CFrame1 ; entry 1
    dw MetaSprites7F_4008Set0CFrame2 ; entry 2
    dw MetaSprites7F_4008Set0CFrame3 ; entry 3
    dw MetaSprites7F_4008Set0CFrame4 ; entry 4
    dw MetaSprites7F_4008Set0CFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set0C; ends with $80 (E-0147)
MetaSprites7F_4008Set0CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set0C; ends with $80 (E-0147)
MetaSprites7F_4008Set0CFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set0C; ends with $80 (E-0147)
MetaSprites7F_4008Set0CFrame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set0C; ends with $80 (E-0147)
MetaSprites7F_4008Set0CFrame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 13 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set0D::
    dw MetaSprites7F_4008Set0DFrame0 ; entry 0
    dw MetaSprites7F_4008Set0DFrame1 ; entry 1
    dw MetaSprites7F_4008Set0DFrame2 ; entry 2
    dw MetaSprites7F_4008Set0DFrame3 ; entry 3
    dw MetaSprites7F_4008Set0DFrame4 ; entry 4
    dw MetaSprites7F_4008Set0DFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set0D; ends with $80 (E-0147)
MetaSprites7F_4008Set0DFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set0D; ends with $80 (E-0147)
MetaSprites7F_4008Set0DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set0D; ends with $80 (E-0147)
MetaSprites7F_4008Set0DFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set0D; ends with $80 (E-0147)
MetaSprites7F_4008Set0DFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 14 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set0E::
    dw MetaSprites7F_4008Set0EFrame0 ; entry 0
    dw MetaSprites7F_4008Set0EFrame1 ; entry 1
    dw MetaSprites7F_4008Set0EFrame2 ; entry 2
    dw MetaSprites7F_4008Set0EFrame3 ; entry 3
    dw MetaSprites7F_4008Set0EFrame4 ; entry 4
    dw MetaSprites7F_4008Set0EFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set0E; ends with $80 (E-0147)
MetaSprites7F_4008Set0EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set0E; ends with $80 (E-0147)
MetaSprites7F_4008Set0EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set0E; ends with $80 (E-0147)
MetaSprites7F_4008Set0EFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set0E; ends with $80 (E-0147)
MetaSprites7F_4008Set0EFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set0F::
    dw MetaSprites7F_4008Set0FFrame0 ; entry 0
    dw MetaSprites7F_4008Set0FFrame1 ; entry 1
    dw MetaSprites7F_4008Set0FFrame2 ; entry 2
    dw MetaSprites7F_4008Set0FFrame3 ; entry 3
    dw MetaSprites7F_4008Set0FFrame4 ; entry 4
    dw MetaSprites7F_4008Set0FFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set0F; ends with $80 (E-0147)
MetaSprites7F_4008Set0FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set0F; ends with $80 (E-0147)
MetaSprites7F_4008Set0FFrame2::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $06, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set0F; ends with $80 (E-0147)
MetaSprites7F_4008Set0FFrame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $06, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set0F; ends with $80 (E-0147)
MetaSprites7F_4008Set0FFrame5::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0e, $20 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0c, $20 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set10::
    dw MetaSprites7F_4008Set10Frame0 ; entry 0
    dw MetaSprites7F_4008Set10Frame1 ; entry 1
    dw MetaSprites7F_4008Set10Frame2 ; entry 2
    dw MetaSprites7F_4008Set10Frame3 ; entry 3
    dw MetaSprites7F_4008Set10Frame4 ; entry 4
    dw MetaSprites7F_4008Set10Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set10; ends with $80 (E-0147)
MetaSprites7F_4008Set10Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set10; ends with $80 (E-0147)
MetaSprites7F_4008Set10Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set10; ends with $80 (E-0147)
MetaSprites7F_4008Set10Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set10; ends with $80 (E-0147)
MetaSprites7F_4008Set10Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set11::
    dw MetaSprites7F_4008Set11Frame0 ; entry 0
    dw MetaSprites7F_4008Set11Frame1 ; entry 1
    dw MetaSprites7F_4008Set11Frame2 ; entry 2
    dw MetaSprites7F_4008Set11Frame3 ; entry 3
    dw MetaSprites7F_4008Set11Frame4 ; entry 4
    dw MetaSprites7F_4008Set11Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set11; ends with $80 (E-0147)
MetaSprites7F_4008Set11Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set11; ends with $80 (E-0147)
MetaSprites7F_4008Set11Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set11; ends with $80 (E-0147)
MetaSprites7F_4008Set11Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set11; ends with $80 (E-0147)
MetaSprites7F_4008Set11Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 18 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set12::
    dw MetaSprites7F_4008Set12Frame0 ; entry 0
    dw MetaSprites7F_4008Set12Frame1 ; entry 1
    dw MetaSprites7F_4008Set12Frame2 ; entry 2
    dw MetaSprites7F_4008Set12Frame3 ; entry 3
    dw MetaSprites7F_4008Set12Frame4 ; entry 4
    dw MetaSprites7F_4008Set12Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set12; ends with $80 (E-0147)
MetaSprites7F_4008Set12Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set12; ends with $80 (E-0147)
MetaSprites7F_4008Set12Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set12; ends with $80 (E-0147)
MetaSprites7F_4008Set12Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set12; ends with $80 (E-0147)
MetaSprites7F_4008Set12Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 19 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set13::
    dw MetaSprites7F_4008Set13Frame0 ; entry 0
    dw MetaSprites7F_4008Set13Frame1 ; entry 1
    dw MetaSprites7F_4008Set13Frame2 ; entry 2
    dw MetaSprites7F_4008Set13Frame3 ; entry 3
    dw MetaSprites7F_4008Set13Frame4 ; entry 4
    dw MetaSprites7F_4008Set13Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame0::
    db $f0, $fa, $00, $00 ; entry 0
    db $f0, $02, $01, $00 ; entry 1
    db $f8, $fa, $02, $00 ; entry 2
    db $f8, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set13; ends with $80 (E-0147)
MetaSprites7F_4008Set13Frame1::
    db $f0, $fa, $00, $00 ; entry 0
    db $f0, $02, $01, $00 ; entry 1
    db $f8, $02, $03, $00 ; entry 2
    db $f8, $fa, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set13; ends with $80 (E-0147)
MetaSprites7F_4008Set13Frame2::
    db $f0, $f6, $05, $00 ; entry 0
    db $f0, $fe, $06, $00 ; entry 1
    db $f8, $f6, $07, $00 ; entry 2
    db $f8, $fe, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set13; ends with $80 (E-0147)
MetaSprites7F_4008Set13Frame3::
    db $f0, $f6, $05, $00 ; entry 0
    db $f0, $fe, $06, $00 ; entry 1
    db $f8, $f6, $07, $00 ; entry 2
    db $f8, $fe, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame4::
    db $f0, $f6, $0a, $00 ; entry 0
    db $f0, $fe, $0b, $00 ; entry 1
    db $f8, $f6, $0c, $00 ; entry 2
    db $f8, $fe, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set13; ends with $80 (E-0147)
MetaSprites7F_4008Set13Frame5::
    db $f0, $f6, $0a, $00 ; entry 0
    db $f0, $fe, $0b, $00 ; entry 1
    db $f8, $f6, $0c, $00 ; entry 2
    db $f8, $fe, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 20 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set14::
    dw MetaSprites7F_4008Set14Frame0 ; entry 0
    dw MetaSprites7F_4008Set14Frame1 ; entry 1
    dw MetaSprites7F_4008Set14Frame2 ; entry 2
    dw MetaSprites7F_4008Set14Frame3 ; entry 3
    dw MetaSprites7F_4008Set14Frame4 ; entry 4
    dw MetaSprites7F_4008Set14Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set14; ends with $80 (E-0147)
MetaSprites7F_4008Set14Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set14; ends with $80 (E-0147)
MetaSprites7F_4008Set14Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set14; ends with $80 (E-0147)
MetaSprites7F_4008Set14Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set14; ends with $80 (E-0147)
MetaSprites7F_4008Set14Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 21 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set15::
    dw MetaSprites7F_4008Set15Frame0 ; entry 0
    dw MetaSprites7F_4008Set15Frame1 ; entry 1
    dw MetaSprites7F_4008Set15Frame2 ; entry 2
    dw MetaSprites7F_4008Set15Frame3 ; entry 3
    dw MetaSprites7F_4008Set15Frame4 ; entry 4
    dw MetaSprites7F_4008Set15Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set15; ends with $80 (E-0147)
MetaSprites7F_4008Set15Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set15; ends with $80 (E-0147)
MetaSprites7F_4008Set15Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set15; ends with $80 (E-0147)
MetaSprites7F_4008Set15Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set15; ends with $80 (E-0147)
MetaSprites7F_4008Set15Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 22 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set16::
    dw MetaSprites7F_4008Set16Frame0 ; entry 0
    dw MetaSprites7F_4008Set16Frame1 ; entry 1
    dw MetaSprites7F_4008Set16Frame2 ; entry 2
    dw MetaSprites7F_4008Set16Frame3 ; entry 3
    dw MetaSprites7F_4008Set16Frame4 ; entry 4
    dw MetaSprites7F_4008Set16Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set16; ends with $80 (E-0147)
MetaSprites7F_4008Set16Frame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set16; ends with $80 (E-0147)
MetaSprites7F_4008Set16Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set16; ends with $80 (E-0147)
MetaSprites7F_4008Set16Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set16; ends with $80 (E-0147)
MetaSprites7F_4008Set16Frame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 23 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set17::
    dw MetaSprites7F_4008Set17Frame0 ; entry 0
    dw MetaSprites7F_4008Set17Frame1 ; entry 1
    dw MetaSprites7F_4008Set17Frame2 ; entry 2
    dw MetaSprites7F_4008Set17Frame3 ; entry 3
    dw MetaSprites7F_4008Set17Frame4 ; entry 4
    dw MetaSprites7F_4008Set17Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set17; ends with $80 (E-0147)
MetaSprites7F_4008Set17Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set17; ends with $80 (E-0147)
MetaSprites7F_4008Set17Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set17; ends with $80 (E-0147)
MetaSprites7F_4008Set17Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set17; ends with $80 (E-0147)
MetaSprites7F_4008Set17Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 24 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set18::
    dw MetaSprites7F_4008Set18Frame0 ; entry 0
    dw MetaSprites7F_4008Set18Frame1 ; entry 1
    dw MetaSprites7F_4008Set18Frame2 ; entry 2
    dw MetaSprites7F_4008Set18Frame3 ; entry 3
    dw MetaSprites7F_4008Set18Frame4 ; entry 4
    dw MetaSprites7F_4008Set18Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set18; ends with $80 (E-0147)
MetaSprites7F_4008Set18Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set18; ends with $80 (E-0147)
MetaSprites7F_4008Set18Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set18; ends with $80 (E-0147)
MetaSprites7F_4008Set18Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set18; ends with $80 (E-0147)
MetaSprites7F_4008Set18Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 25 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set19::
    dw MetaSprites7F_4008Set19Frame0 ; entry 0
    dw MetaSprites7F_4008Set19Frame1 ; entry 1
    dw MetaSprites7F_4008Set19Frame2 ; entry 2
    dw MetaSprites7F_4008Set19Frame3 ; entry 3
    dw MetaSprites7F_4008Set19Frame4 ; entry 4
    dw MetaSprites7F_4008Set19Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set19; ends with $80 (E-0147)
MetaSprites7F_4008Set19Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set19; ends with $80 (E-0147)
MetaSprites7F_4008Set19Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set19; ends with $80 (E-0147)
MetaSprites7F_4008Set19Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set19; ends with $80 (E-0147)
MetaSprites7F_4008Set19Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set1A::
    dw MetaSprites7F_4008Set1AFrame0 ; entry 0
    dw MetaSprites7F_4008Set1AFrame1 ; entry 1
    dw MetaSprites7F_4008Set1AFrame2 ; entry 2
    dw MetaSprites7F_4008Set1AFrame3 ; entry 3
    dw MetaSprites7F_4008Set1AFrame4 ; entry 4
    dw MetaSprites7F_4008Set1AFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set1A; ends with $80 (E-0147)
MetaSprites7F_4008Set1AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set1A; ends with $80 (E-0147)
MetaSprites7F_4008Set1AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set1A; ends with $80 (E-0147)
MetaSprites7F_4008Set1AFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set1A; ends with $80 (E-0147)
MetaSprites7F_4008Set1AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set1B::
    dw MetaSprites7F_4008Set1BFrame0 ; entry 0
    dw MetaSprites7F_4008Set1BFrame1 ; entry 1
    dw MetaSprites7F_4008Set1BFrame2 ; entry 2
    dw MetaSprites7F_4008Set1BFrame3 ; entry 3
    dw MetaSprites7F_4008Set1BFrame4 ; entry 4
    dw MetaSprites7F_4008Set1BFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set1B; ends with $80 (E-0147)
MetaSprites7F_4008Set1BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set1B; ends with $80 (E-0147)
MetaSprites7F_4008Set1BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set1B; ends with $80 (E-0147)
MetaSprites7F_4008Set1BFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set1B; ends with $80 (E-0147)
MetaSprites7F_4008Set1BFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 28 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set1C::
    dw MetaSprites7F_4008Set1CFrame0 ; entry 0
    dw MetaSprites7F_4008Set1CFrame1 ; entry 1
    dw MetaSprites7F_4008Set1CFrame2 ; entry 2
    dw MetaSprites7F_4008Set1CFrame3 ; entry 3
    dw MetaSprites7F_4008Set1CFrame4 ; entry 4
    dw MetaSprites7F_4008Set1CFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set1C; ends with $80 (E-0147)
MetaSprites7F_4008Set1CFrame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set1C; ends with $80 (E-0147)
MetaSprites7F_4008Set1CFrame2::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set1C; ends with $80 (E-0147)
MetaSprites7F_4008Set1CFrame3::
    db $f8, $f9, $0a, $00 ; entry 0
    db $f8, $01, $0b, $00 ; entry 1
    db $f0, $f9, $08, $00 ; entry 2
    db $f0, $01, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set1C; ends with $80 (E-0147)
MetaSprites7F_4008Set1CFrame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 29 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set1D::
    dw MetaSprites7F_4008Set1DFrame0 ; entry 0
    dw MetaSprites7F_4008Set1DFrame1 ; entry 1
    dw MetaSprites7F_4008Set1DFrame2 ; entry 2
    dw MetaSprites7F_4008Set1DFrame3 ; entry 3
    dw MetaSprites7F_4008Set1DFrame4 ; entry 4
    dw MetaSprites7F_4008Set1DFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set1D; ends with $80 (E-0147)
MetaSprites7F_4008Set1DFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set1D; ends with $80 (E-0147)
MetaSprites7F_4008Set1DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set1D; ends with $80 (E-0147)
MetaSprites7F_4008Set1DFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set1D; ends with $80 (E-0147)
MetaSprites7F_4008Set1DFrame5::
    db $f0, $00, $0a, $20 ; entry 0
    db $f0, $f8, $0b, $20 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 30 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set1E::
    dw MetaSprites7F_4008Set1EFrame0 ; entry 0
    dw MetaSprites7F_4008Set1EFrame1 ; entry 1
    dw MetaSprites7F_4008Set1EFrame2 ; entry 2
    dw MetaSprites7F_4008Set1EFrame3 ; entry 3
    dw MetaSprites7F_4008Set1EFrame4 ; entry 4
    dw MetaSprites7F_4008Set1EFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set1E; ends with $80 (E-0147)
MetaSprites7F_4008Set1EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set1E; ends with $80 (E-0147)
MetaSprites7F_4008Set1EFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f8, $f8, $08, $00 ; entry 1
    db $f8, $00, $09, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set1E; ends with $80 (E-0147)
MetaSprites7F_4008Set1EFrame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $0a, $00 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set1E; ends with $80 (E-0147)
MetaSprites7F_4008Set1EFrame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0e, $00 ; entry 1
    db $f8, $00, $0f, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 31 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set1F::
    dw MetaSprites7F_4008Set1FFrame0 ; entry 0
    dw MetaSprites7F_4008Set1FFrame1 ; entry 1
    dw MetaSprites7F_4008Set1FFrame2 ; entry 2
    dw MetaSprites7F_4008Set1FFrame3 ; entry 3
    dw MetaSprites7F_4008Set1FFrame4 ; entry 4
    dw MetaSprites7F_4008Set1FFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set1F; ends with $80 (E-0147)
MetaSprites7F_4008Set1FFrame1::
    db $f0, $f7, $00, $00 ; entry 0
    db $f0, $ff, $01, $00 ; entry 1
    db $f8, $fe, $02, $20 ; entry 2
    db $f8, $f6, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set1F; ends with $80 (E-0147)
MetaSprites7F_4008Set1FFrame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f8, $f7, $06, $00 ; entry 1
    db $f8, $ff, $07, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set1F; ends with $80 (E-0147)
MetaSprites7F_4008Set1FFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set1F; ends with $80 (E-0147)
MetaSprites7F_4008Set1FFrame5::
    db $f0, $f9, $0a, $00 ; entry 0
    db $f8, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $20 ; entry 2
    db $f0, $01, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 32 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set20::
    dw MetaSprites7F_4008Set20Frame0 ; entry 0
    dw MetaSprites7F_4008Set20Frame1 ; entry 1
    dw MetaSprites7F_4008Set20Frame2 ; entry 2
    dw MetaSprites7F_4008Set20Frame3 ; entry 3
    dw MetaSprites7F_4008Set20Frame4 ; entry 4
    dw MetaSprites7F_4008Set20Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set20; ends with $80 (E-0147)
MetaSprites7F_4008Set20Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set20; ends with $80 (E-0147)
MetaSprites7F_4008Set20Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set20; ends with $80 (E-0147)
MetaSprites7F_4008Set20Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set20; ends with $80 (E-0147)
MetaSprites7F_4008Set20Frame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 33 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set21::
    dw MetaSprites7F_4008Set21Frame0 ; entry 0
    dw MetaSprites7F_4008Set21Frame1 ; entry 1
    dw MetaSprites7F_4008Set21Frame2 ; entry 2
    dw MetaSprites7F_4008Set21Frame3 ; entry 3
    dw MetaSprites7F_4008Set21Frame4 ; entry 4
    dw MetaSprites7F_4008Set21Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set21; ends with $80 (E-0147)
MetaSprites7F_4008Set21Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set21; ends with $80 (E-0147)
MetaSprites7F_4008Set21Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set21; ends with $80 (E-0147)
MetaSprites7F_4008Set21Frame3::
    db $f8, $f7, $08, $00 ; entry 0
    db $f8, $ff, $09, $00 ; entry 1
    db $f0, $f7, $04, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set21; ends with $80 (E-0147)
MetaSprites7F_4008Set21Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 34 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set22::
    dw MetaSprites7F_4008Set22Frame0 ; entry 0
    dw MetaSprites7F_4008Set22Frame1 ; entry 1
    dw MetaSprites7F_4008Set22Frame2 ; entry 2
    dw MetaSprites7F_4008Set22Frame3 ; entry 3
    dw MetaSprites7F_4008Set22Frame4 ; entry 4
    dw MetaSprites7F_4008Set22Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set22; ends with $80 (E-0147)
MetaSprites7F_4008Set22Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set22; ends with $80 (E-0147)
MetaSprites7F_4008Set22Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set22; ends with $80 (E-0147)
MetaSprites7F_4008Set22Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set22; ends with $80 (E-0147)
MetaSprites7F_4008Set22Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 35 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set23::
    dw MetaSprites7F_4008Set23Frame0 ; entry 0
    dw MetaSprites7F_4008Set23Frame1 ; entry 1
    dw MetaSprites7F_4008Set23Frame2 ; entry 2
    dw MetaSprites7F_4008Set23Frame3 ; entry 3
    dw MetaSprites7F_4008Set23Frame4 ; entry 4
    dw MetaSprites7F_4008Set23Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set23; ends with $80 (E-0147)
MetaSprites7F_4008Set23Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set23; ends with $80 (E-0147)
MetaSprites7F_4008Set23Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set23; ends with $80 (E-0147)
MetaSprites7F_4008Set23Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set23; ends with $80 (E-0147)
MetaSprites7F_4008Set23Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 36 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set24::
    dw MetaSprites7F_4008Set24Frame0 ; entry 0
    dw MetaSprites7F_4008Set24Frame1 ; entry 1
    dw MetaSprites7F_4008Set24Frame2 ; entry 2
    dw MetaSprites7F_4008Set24Frame3 ; entry 3
    dw MetaSprites7F_4008Set24Frame4 ; entry 4
    dw MetaSprites7F_4008Set24Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set24; ends with $80 (E-0147)
MetaSprites7F_4008Set24Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set24; ends with $80 (E-0147)
MetaSprites7F_4008Set24Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set24; ends with $80 (E-0147)
MetaSprites7F_4008Set24Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set24; ends with $80 (E-0147)
MetaSprites7F_4008Set24Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set25::
    dw MetaSprites7F_4008Set25Frame0 ; entry 0
    dw MetaSprites7F_4008Set25Frame1 ; entry 1
    dw MetaSprites7F_4008Set25Frame2 ; entry 2
    dw MetaSprites7F_4008Set25Frame3 ; entry 3
    dw MetaSprites7F_4008Set25Frame4 ; entry 4
    dw MetaSprites7F_4008Set25Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set25; ends with $80 (E-0147)
MetaSprites7F_4008Set25Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set25; ends with $80 (E-0147)
MetaSprites7F_4008Set25Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set25; ends with $80 (E-0147)
MetaSprites7F_4008Set25Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set25; ends with $80 (E-0147)
MetaSprites7F_4008Set25Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 38 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set26::
    dw MetaSprites7F_4008Set26Frame0 ; entry 0
    dw MetaSprites7F_4008Set26Frame1 ; entry 1
    dw MetaSprites7F_4008Set26Frame2 ; entry 2
    dw MetaSprites7F_4008Set26Frame3 ; entry 3
    dw MetaSprites7F_4008Set26Frame4 ; entry 4
    dw MetaSprites7F_4008Set26Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set26; ends with $80 (E-0147)
MetaSprites7F_4008Set26Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set26; ends with $80 (E-0147)
MetaSprites7F_4008Set26Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set26; ends with $80 (E-0147)
MetaSprites7F_4008Set26Frame3::
    db $f8, $f7, $08, $00 ; entry 0
    db $f8, $ff, $09, $00 ; entry 1
    db $f0, $f7, $04, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set26; ends with $80 (E-0147)
MetaSprites7F_4008Set26Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 39 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set27::
    dw MetaSprites7F_4008Set27Frame0 ; entry 0
    dw MetaSprites7F_4008Set27Frame1 ; entry 1
    dw MetaSprites7F_4008Set27Frame2 ; entry 2
    dw MetaSprites7F_4008Set27Frame3 ; entry 3
    dw MetaSprites7F_4008Set27Frame4 ; entry 4
    dw MetaSprites7F_4008Set27Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set27; ends with $80 (E-0147)
MetaSprites7F_4008Set27Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set27; ends with $80 (E-0147)
MetaSprites7F_4008Set27Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set27; ends with $80 (E-0147)
MetaSprites7F_4008Set27Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set27; ends with $80 (E-0147)
MetaSprites7F_4008Set27Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 40 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set28::
    dw MetaSprites7F_4008Set28Frame0 ; entry 0
    dw MetaSprites7F_4008Set28Frame1 ; entry 1
    dw MetaSprites7F_4008Set28Frame2 ; entry 2
    dw MetaSprites7F_4008Set28Frame3 ; entry 3
    dw MetaSprites7F_4008Set28Frame4 ; entry 4
    dw MetaSprites7F_4008Set28Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set28; ends with $80 (E-0147)
MetaSprites7F_4008Set28Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set28; ends with $80 (E-0147)
MetaSprites7F_4008Set28Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set28; ends with $80 (E-0147)
MetaSprites7F_4008Set28Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set28; ends with $80 (E-0147)
MetaSprites7F_4008Set28Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 41 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set29::
    dw MetaSprites7F_4008Set29Frame0 ; entry 0
    dw MetaSprites7F_4008Set29Frame1 ; entry 1
    dw MetaSprites7F_4008Set29Frame2 ; entry 2
    dw MetaSprites7F_4008Set29Frame3 ; entry 3
    dw MetaSprites7F_4008Set29Frame4 ; entry 4
    dw MetaSprites7F_4008Set29Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set29; ends with $80 (E-0147)
MetaSprites7F_4008Set29Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set29; ends with $80 (E-0147)
MetaSprites7F_4008Set29Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set29; ends with $80 (E-0147)
MetaSprites7F_4008Set29Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set29; ends with $80 (E-0147)
MetaSprites7F_4008Set29Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 42 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set2A::
    dw MetaSprites7F_4008Set2AFrame0 ; entry 0
    dw MetaSprites7F_4008Set2AFrame1 ; entry 1
    dw MetaSprites7F_4008Set2AFrame2 ; entry 2
    dw MetaSprites7F_4008Set2AFrame3 ; entry 3
    dw MetaSprites7F_4008Set2AFrame4 ; entry 4
    dw MetaSprites7F_4008Set2AFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set2A; ends with $80 (E-0147)
MetaSprites7F_4008Set2AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set2A; ends with $80 (E-0147)
MetaSprites7F_4008Set2AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set2A; ends with $80 (E-0147)
MetaSprites7F_4008Set2AFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set2A; ends with $80 (E-0147)
MetaSprites7F_4008Set2AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 43 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set2B::
    dw MetaSprites7F_4008Set2BFrame0 ; entry 0
    dw MetaSprites7F_4008Set2BFrame1 ; entry 1
    dw MetaSprites7F_4008Set2BFrame2 ; entry 2
    dw MetaSprites7F_4008Set2BFrame3 ; entry 3
    dw MetaSprites7F_4008Set2BFrame4 ; entry 4
    dw MetaSprites7F_4008Set2BFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set2B; ends with $80 (E-0147)
MetaSprites7F_4008Set2BFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set2B; ends with $80 (E-0147)
MetaSprites7F_4008Set2BFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set2B; ends with $80 (E-0147)
MetaSprites7F_4008Set2BFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set2B; ends with $80 (E-0147)
MetaSprites7F_4008Set2BFrame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $00, $0e, $00 ; entry 2
    db $f9, $f8, $0c, $00 ; entry 3
    db $80 ; end

; meta-sprite set 44 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set2C::
    dw MetaSprites7F_4008Set2CFrame0 ; entry 0
    dw MetaSprites7F_4008Set2CFrame1 ; entry 1
    dw MetaSprites7F_4008Set2CFrame2 ; entry 2
    dw MetaSprites7F_4008Set2CFrame3 ; entry 3
    dw MetaSprites7F_4008Set2CFrame4 ; entry 4
    dw MetaSprites7F_4008Set2CFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set2C; ends with $80 (E-0147)
MetaSprites7F_4008Set2CFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set2C; ends with $80 (E-0147)
MetaSprites7F_4008Set2CFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set2C; ends with $80 (E-0147)
MetaSprites7F_4008Set2CFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $fd, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set2C; ends with $80 (E-0147)
MetaSprites7F_4008Set2CFrame5::
    db $f9, $f8, $0e, $00 ; entry 0
    db $f9, $00, $0f, $00 ; entry 1
    db $f1, $f8, $0d, $00 ; entry 2
    db $f1, $fd, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 45 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set2D::
    dw MetaSprites7F_4008Set2DFrame0 ; entry 0
    dw MetaSprites7F_4008Set2DFrame1 ; entry 1
    dw MetaSprites7F_4008Set2DFrame2 ; entry 2
    dw MetaSprites7F_4008Set2DFrame3 ; entry 3
    dw MetaSprites7F_4008Set2DFrame4 ; entry 4
    dw MetaSprites7F_4008Set2DFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set2D; ends with $80 (E-0147)
MetaSprites7F_4008Set2DFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set2D; ends with $80 (E-0147)
MetaSprites7F_4008Set2DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set2D; ends with $80 (E-0147)
MetaSprites7F_4008Set2DFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set2D; ends with $80 (E-0147)
MetaSprites7F_4008Set2DFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 46 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set2E::
    dw MetaSprites7F_4008Set2EFrame0 ; entry 0
    dw MetaSprites7F_4008Set2EFrame1 ; entry 1
    dw MetaSprites7F_4008Set2EFrame2 ; entry 2
    dw MetaSprites7F_4008Set2EFrame3 ; entry 3
    dw MetaSprites7F_4008Set2EFrame4 ; entry 4
    dw MetaSprites7F_4008Set2EFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set2E; ends with $80 (E-0147)
MetaSprites7F_4008Set2EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set2E; ends with $80 (E-0147)
MetaSprites7F_4008Set2EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set2E; ends with $80 (E-0147)
MetaSprites7F_4008Set2EFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set2E; ends with $80 (E-0147)
MetaSprites7F_4008Set2EFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 47 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set2F::
    dw MetaSprites7F_4008Set2FFrame0 ; entry 0
    dw MetaSprites7F_4008Set2FFrame1 ; entry 1
    dw MetaSprites7F_4008Set2FFrame2 ; entry 2
    dw MetaSprites7F_4008Set2FFrame3 ; entry 3
    dw MetaSprites7F_4008Set2FFrame4 ; entry 4
    dw MetaSprites7F_4008Set2FFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set2F; ends with $80 (E-0147)
MetaSprites7F_4008Set2FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set2F; ends with $80 (E-0147)
MetaSprites7F_4008Set2FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set2F; ends with $80 (E-0147)
MetaSprites7F_4008Set2FFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set2F; ends with $80 (E-0147)
MetaSprites7F_4008Set2FFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 48 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set30::
    dw MetaSprites7F_4008Set30Frame0 ; entry 0
    dw MetaSprites7F_4008Set30Frame1 ; entry 1
    dw MetaSprites7F_4008Set30Frame2 ; entry 2
    dw MetaSprites7F_4008Set30Frame3 ; entry 3
    dw MetaSprites7F_4008Set30Frame4 ; entry 4
    dw MetaSprites7F_4008Set30Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set30; ends with $80 (E-0147)
MetaSprites7F_4008Set30Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f6, $00, $00 ; entry 2
    db $f0, $fe, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set30; ends with $80 (E-0147)
MetaSprites7F_4008Set30Frame2::
    db $f0, $f6, $04, $00 ; entry 0
    db $f0, $fe, $05, $00 ; entry 1
    db $f8, $f6, $06, $00 ; entry 2
    db $f8, $fe, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set30; ends with $80 (E-0147)
MetaSprites7F_4008Set30Frame3::
    db $f8, $f7, $08, $00 ; entry 0
    db $f8, $ff, $09, $00 ; entry 1
    db $f0, $f7, $04, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set30; ends with $80 (E-0147)
MetaSprites7F_4008Set30Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f6, $0a, $00 ; entry 2
    db $f0, $fe, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 49 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set31::
    dw MetaSprites7F_4008Set31Frame0 ; entry 0
    dw MetaSprites7F_4008Set31Frame1 ; entry 1
    dw MetaSprites7F_4008Set31Frame2 ; entry 2
    dw MetaSprites7F_4008Set31Frame3 ; entry 3
    dw MetaSprites7F_4008Set31Frame4 ; entry 4
    dw MetaSprites7F_4008Set31Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set31; ends with $80 (E-0147)
MetaSprites7F_4008Set31Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set31; ends with $80 (E-0147)
MetaSprites7F_4008Set31Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set31; ends with $80 (E-0147)
MetaSprites7F_4008Set31Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set31; ends with $80 (E-0147)
MetaSprites7F_4008Set31Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 50 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set32::
    dw MetaSprites7F_4008Set32Frame0 ; entry 0
    dw MetaSprites7F_4008Set32Frame1 ; entry 1
    dw MetaSprites7F_4008Set32Frame2 ; entry 2
    dw MetaSprites7F_4008Set32Frame3 ; entry 3
    dw MetaSprites7F_4008Set32Frame4 ; entry 4
    dw MetaSprites7F_4008Set32Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set32; ends with $80 (E-0147)
MetaSprites7F_4008Set32Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set32; ends with $80 (E-0147)
MetaSprites7F_4008Set32Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set32; ends with $80 (E-0147)
MetaSprites7F_4008Set32Frame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set32; ends with $80 (E-0147)
MetaSprites7F_4008Set32Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 51 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set33::
    dw MetaSprites7F_4008Set33Frame0 ; entry 0
    dw MetaSprites7F_4008Set33Frame1 ; entry 1
    dw MetaSprites7F_4008Set33Frame2 ; entry 2
    dw MetaSprites7F_4008Set33Frame3 ; entry 3
    dw MetaSprites7F_4008Set33Frame4 ; entry 4
    dw MetaSprites7F_4008Set33Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set33; ends with $80 (E-0147)
MetaSprites7F_4008Set33Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set33; ends with $80 (E-0147)
MetaSprites7F_4008Set33Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set33; ends with $80 (E-0147)
MetaSprites7F_4008Set33Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set33; ends with $80 (E-0147)
MetaSprites7F_4008Set33Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 52 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set34::
    dw MetaSprites7F_4008Set34Frame0 ; entry 0
    dw MetaSprites7F_4008Set34Frame1 ; entry 1
    dw MetaSprites7F_4008Set34Frame2 ; entry 2
    dw MetaSprites7F_4008Set34Frame3 ; entry 3
    dw MetaSprites7F_4008Set34Frame4 ; entry 4
    dw MetaSprites7F_4008Set34Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set34; ends with $80 (E-0147)
MetaSprites7F_4008Set34Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set34; ends with $80 (E-0147)
MetaSprites7F_4008Set34Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set34; ends with $80 (E-0147)
MetaSprites7F_4008Set34Frame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set34; ends with $80 (E-0147)
MetaSprites7F_4008Set34Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 53 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set35::
    dw MetaSprites7F_4008Set35Frame0 ; entry 0
    dw MetaSprites7F_4008Set35Frame1 ; entry 1
    dw MetaSprites7F_4008Set35Frame2 ; entry 2
    dw MetaSprites7F_4008Set35Frame3 ; entry 3
    dw MetaSprites7F_4008Set35Frame4 ; entry 4
    dw MetaSprites7F_4008Set35Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set35; ends with $80 (E-0147)
MetaSprites7F_4008Set35Frame1::
    db $f8, $fe, $02, $20 ; entry 0
    db $f8, $f6, $03, $20 ; entry 1
    db $f0, $f7, $00, $00 ; entry 2
    db $f0, $ff, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set35; ends with $80 (E-0147)
MetaSprites7F_4008Set35Frame2::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set35; ends with $80 (E-0147)
MetaSprites7F_4008Set35Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set35; ends with $80 (E-0147)
MetaSprites7F_4008Set35Frame5::
    db $f8, $00, $0c, $20 ; entry 0
    db $f8, $f8, $0d, $20 ; entry 1
    db $f0, $f9, $0a, $00 ; entry 2
    db $f0, $01, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 54 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set36::
    dw MetaSprites7F_4008Set36Frame0 ; entry 0
    dw MetaSprites7F_4008Set36Frame1 ; entry 1
    dw MetaSprites7F_4008Set36Frame2 ; entry 2
    dw MetaSprites7F_4008Set36Frame3 ; entry 3
    dw MetaSprites7F_4008Set36Frame4 ; entry 4
    dw MetaSprites7F_4008Set36Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set36; ends with $80 (E-0147)
MetaSprites7F_4008Set36Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set36; ends with $80 (E-0147)
MetaSprites7F_4008Set36Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set36; ends with $80 (E-0147)
MetaSprites7F_4008Set36Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set36; ends with $80 (E-0147)
MetaSprites7F_4008Set36Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 55 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set37::
    dw MetaSprites7F_4008Set37Frame0 ; entry 0
    dw MetaSprites7F_4008Set37Frame1 ; entry 1
    dw MetaSprites7F_4008Set37Frame2 ; entry 2
    dw MetaSprites7F_4008Set37Frame3 ; entry 3
    dw MetaSprites7F_4008Set37Frame4 ; entry 4
    dw MetaSprites7F_4008Set37Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set37; ends with $80 (E-0147)
MetaSprites7F_4008Set37Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set37; ends with $80 (E-0147)
MetaSprites7F_4008Set37Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set37; ends with $80 (E-0147)
MetaSprites7F_4008Set37Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set37; ends with $80 (E-0147)
MetaSprites7F_4008Set37Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 56 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set38::
    dw MetaSprites7F_4008Set38Frame0 ; entry 0
    dw MetaSprites7F_4008Set38Frame1 ; entry 1
    dw MetaSprites7F_4008Set38Frame2 ; entry 2
    dw MetaSprites7F_4008Set38Frame3 ; entry 3
    dw MetaSprites7F_4008Set38Frame4 ; entry 4
    dw MetaSprites7F_4008Set38Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set38; ends with $80 (E-0147)
MetaSprites7F_4008Set38Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set38; ends with $80 (E-0147)
MetaSprites7F_4008Set38Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set38; ends with $80 (E-0147)
MetaSprites7F_4008Set38Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set38; ends with $80 (E-0147)
MetaSprites7F_4008Set38Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 57 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set39::
    dw MetaSprites7F_4008Set39Frame0 ; entry 0
    dw MetaSprites7F_4008Set39Frame1 ; entry 1
    dw MetaSprites7F_4008Set39Frame2 ; entry 2
    dw MetaSprites7F_4008Set39Frame3 ; entry 3
    dw MetaSprites7F_4008Set39Frame4 ; entry 4
    dw MetaSprites7F_4008Set39Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set39; ends with $80 (E-0147)
MetaSprites7F_4008Set39Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set39; ends with $80 (E-0147)
MetaSprites7F_4008Set39Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set39; ends with $80 (E-0147)
MetaSprites7F_4008Set39Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set39; ends with $80 (E-0147)
MetaSprites7F_4008Set39Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 58 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set3A::
    dw MetaSprites7F_4008Set3AFrame0 ; entry 0
    dw MetaSprites7F_4008Set3AFrame1 ; entry 1
    dw MetaSprites7F_4008Set3AFrame2 ; entry 2
    dw MetaSprites7F_4008Set3AFrame3 ; entry 3
    dw MetaSprites7F_4008Set3AFrame4 ; entry 4
    dw MetaSprites7F_4008Set3AFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set3A; ends with $80 (E-0147)
MetaSprites7F_4008Set3AFrame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set3A; ends with $80 (E-0147)
MetaSprites7F_4008Set3AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set3A; ends with $80 (E-0147)
MetaSprites7F_4008Set3AFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set3A; ends with $80 (E-0147)
MetaSprites7F_4008Set3AFrame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 59 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set3B::
    dw MetaSprites7F_4008Set3BFrame0 ; entry 0
    dw MetaSprites7F_4008Set3BFrame1 ; entry 1
    dw MetaSprites7F_4008Set3BFrame2 ; entry 2
    dw MetaSprites7F_4008Set3BFrame3 ; entry 3
    dw MetaSprites7F_4008Set3BFrame4 ; entry 4
    dw MetaSprites7F_4008Set3BFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set3B; ends with $80 (E-0147)
MetaSprites7F_4008Set3BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set3B; ends with $80 (E-0147)
MetaSprites7F_4008Set3BFrame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set3B; ends with $80 (E-0147)
MetaSprites7F_4008Set3BFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set3B; ends with $80 (E-0147)
MetaSprites7F_4008Set3BFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $09, $20 ; entry 1
    db $f8, $00, $0a, $20 ; entry 2
    db $f8, $f8, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 60 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set3C::
    dw MetaSprites7F_4008Set3CFrame0 ; entry 0
    dw MetaSprites7F_4008Set3CFrame1 ; entry 1
    dw MetaSprites7F_4008Set3CFrame2 ; entry 2
    dw MetaSprites7F_4008Set3CFrame3 ; entry 3
    dw MetaSprites7F_4008Set3CFrame4 ; entry 4
    dw MetaSprites7F_4008Set3CFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set3C; ends with $80 (E-0147)
MetaSprites7F_4008Set3CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set3C; ends with $80 (E-0147)
MetaSprites7F_4008Set3CFrame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set3C; ends with $80 (E-0147)
MetaSprites7F_4008Set3CFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $f8, $0a, $00 ; entry 1
    db $f8, $00, $0b, $00 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set3C; ends with $80 (E-0147)
MetaSprites7F_4008Set3CFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $ff, $0a, $20 ; entry 1
    db $f8, $f7, $0b, $20 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; meta-sprite set 61 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set3D::
    dw MetaSprites7F_4008Set3DFrame0 ; entry 0
    dw MetaSprites7F_4008Set3DFrame1 ; entry 1
    dw MetaSprites7F_4008Set3DFrame2 ; entry 2
    dw MetaSprites7F_4008Set3DFrame3 ; entry 3
    dw MetaSprites7F_4008Set3DFrame4 ; entry 4
    dw MetaSprites7F_4008Set3DFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set3D; ends with $80 (E-0147)
MetaSprites7F_4008Set3DFrame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set3D; ends with $80 (E-0147)
MetaSprites7F_4008Set3DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set3D; ends with $80 (E-0147)
MetaSprites7F_4008Set3DFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set3D; ends with $80 (E-0147)
MetaSprites7F_4008Set3DFrame5::
    db $f0, $ff, $0a, $20 ; entry 0
    db $f0, $f7, $0b, $20 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 62 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set3E::
    dw MetaSprites7F_4008Set3EFrame0 ; entry 0
    dw MetaSprites7F_4008Set3EFrame1 ; entry 1
    dw MetaSprites7F_4008Set3EFrame2 ; entry 2
    dw MetaSprites7F_4008Set3EFrame3 ; entry 3
    dw MetaSprites7F_4008Set3EFrame4 ; entry 4
    dw MetaSprites7F_4008Set3EFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set3E; ends with $80 (E-0147)
MetaSprites7F_4008Set3EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set3E; ends with $80 (E-0147)
MetaSprites7F_4008Set3EFrame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set3E; ends with $80 (E-0147)
MetaSprites7F_4008Set3EFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $f8, $0a, $00 ; entry 1
    db $f8, $00, $0b, $00 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set3E; ends with $80 (E-0147)
MetaSprites7F_4008Set3EFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $ff, $0a, $20 ; entry 1
    db $f8, $f7, $0b, $20 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; meta-sprite set 63 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set3F::
    dw MetaSprites7F_4008Set3FFrame0 ; entry 0
    dw MetaSprites7F_4008Set3FFrame1 ; entry 1
    dw MetaSprites7F_4008Set3FFrame2 ; entry 2
    dw MetaSprites7F_4008Set3FFrame3 ; entry 3
    dw MetaSprites7F_4008Set3FFrame4 ; entry 4
    dw MetaSprites7F_4008Set3FFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set3F; ends with $80 (E-0147)
MetaSprites7F_4008Set3FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set3F; ends with $80 (E-0147)
MetaSprites7F_4008Set3FFrame2::
    db $f0, $f5, $03, $00 ; entry 0
    db $f0, $fd, $04, $00 ; entry 1
    db $f8, $f5, $05, $00 ; entry 2
    db $f8, $fd, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set3F; ends with $80 (E-0147)
MetaSprites7F_4008Set3FFrame3::
    db $f0, $fd, $04, $00 ; entry 0
    db $f0, $f5, $07, $00 ; entry 1
    db $f8, $f5, $08, $00 ; entry 2
    db $f8, $fd, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set3F; ends with $80 (E-0147)
MetaSprites7F_4008Set3FFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $ff, $0b, $20 ; entry 2
    db $f8, $f7, $0c, $20 ; entry 3
    db $80 ; end

; meta-sprite set 64 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set40::
    dw MetaSprites7F_4008Set40Frame0 ; entry 0
    dw MetaSprites7F_4008Set40Frame1 ; entry 1
    dw MetaSprites7F_4008Set40Frame2 ; entry 2
    dw MetaSprites7F_4008Set40Frame3 ; entry 3
    dw MetaSprites7F_4008Set40Frame4 ; entry 4
    dw MetaSprites7F_4008Set40Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set40; ends with $80 (E-0147)
MetaSprites7F_4008Set40Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set40; ends with $80 (E-0147)
MetaSprites7F_4008Set40Frame2::
    db $f0, $f5, $03, $00 ; entry 0
    db $f0, $fd, $04, $00 ; entry 1
    db $f8, $f5, $05, $00 ; entry 2
    db $f8, $fd, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set40; ends with $80 (E-0147)
MetaSprites7F_4008Set40Frame3::
    db $f0, $fd, $04, $00 ; entry 0
    db $f0, $f5, $07, $00 ; entry 1
    db $f8, $f5, $08, $00 ; entry 2
    db $f8, $fd, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set40; ends with $80 (E-0147)
MetaSprites7F_4008Set40Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 65 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set41::
    dw MetaSprites7F_4008Set41Frame0 ; entry 0
    dw MetaSprites7F_4008Set41Frame1 ; entry 1
    dw MetaSprites7F_4008Set41Frame2 ; entry 2
    dw MetaSprites7F_4008Set41Frame3 ; entry 3
    dw MetaSprites7F_4008Set41Frame4 ; entry 4
    dw MetaSprites7F_4008Set41Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set41; ends with $80 (E-0147)
MetaSprites7F_4008Set41Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set41; ends with $80 (E-0147)
MetaSprites7F_4008Set41Frame2::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $05, $00 ; entry 2
    db $f8, $ff, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set41; ends with $80 (E-0147)
MetaSprites7F_4008Set41Frame3::
    db $f0, $ff, $04, $00 ; entry 0
    db $f0, $f7, $07, $00 ; entry 1
    db $f8, $f7, $08, $00 ; entry 2
    db $f8, $ff, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set41; ends with $80 (E-0147)
MetaSprites7F_4008Set41Frame5::
    db $f0, $00, $0b, $20 ; entry 0
    db $f8, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $20 ; entry 2
    db $f0, $f8, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 66 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set42::
    dw MetaSprites7F_4008Set42Frame0 ; entry 0
    dw MetaSprites7F_4008Set42Frame1 ; entry 1
    dw MetaSprites7F_4008Set42Frame2 ; entry 2
    dw MetaSprites7F_4008Set42Frame3 ; entry 3
    dw MetaSprites7F_4008Set42Frame4 ; entry 4
    dw MetaSprites7F_4008Set42Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f8, $00, $03, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set42; ends with $80 (E-0147)
MetaSprites7F_4008Set42Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set42; ends with $80 (E-0147)
MetaSprites7F_4008Set42Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set42; ends with $80 (E-0147)
MetaSprites7F_4008Set42Frame3::
    db $f0, $ff, $05, $00 ; entry 0
    db $f0, $f7, $08, $00 ; entry 1
    db $f8, $f7, $09, $00 ; entry 2
    db $f8, $ff, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set42; ends with $80 (E-0147)
MetaSprites7F_4008Set42Frame5::
    db $f0, $ff, $0b, $20 ; entry 0
    db $f0, $f7, $0c, $20 ; entry 1
    db $f8, $ff, $0d, $20 ; entry 2
    db $f8, $f7, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 67 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set43::
    dw MetaSprites7F_4008Set43Frame0 ; entry 0
    dw MetaSprites7F_4008Set43Frame1 ; entry 1
    dw MetaSprites7F_4008Set43Frame2 ; entry 2
    dw MetaSprites7F_4008Set43Frame3 ; entry 3
    dw MetaSprites7F_4008Set43Frame4 ; entry 4
    dw MetaSprites7F_4008Set43Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set43; ends with $80 (E-0147)
MetaSprites7F_4008Set43Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set43; ends with $80 (E-0147)
MetaSprites7F_4008Set43Frame2::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $05, $00 ; entry 2
    db $f8, $ff, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set43; ends with $80 (E-0147)
MetaSprites7F_4008Set43Frame3::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $07, $00 ; entry 2
    db $f8, $ff, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set43; ends with $80 (E-0147)
MetaSprites7F_4008Set43Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 68 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set44::
    dw MetaSprites7F_4008Set44Frame0 ; entry 0
    dw MetaSprites7F_4008Set44Frame1 ; entry 1
    dw MetaSprites7F_4008Set44Frame2 ; entry 2
    dw MetaSprites7F_4008Set44Frame3 ; entry 3
    dw MetaSprites7F_4008Set44Frame4 ; entry 4
    dw MetaSprites7F_4008Set44Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set44; ends with $80 (E-0147)
MetaSprites7F_4008Set44Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set44; ends with $80 (E-0147)
MetaSprites7F_4008Set44Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set44; ends with $80 (E-0147)
MetaSprites7F_4008Set44Frame3::
    db $f8, $f8, $07, $00 ; entry 0
    db $f8, $00, $08, $00 ; entry 1
    db $f0, $f7, $03, $00 ; entry 2
    db $f0, $ff, $04, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set44; ends with $80 (E-0147)
MetaSprites7F_4008Set44Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 69 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set45::
    dw MetaSprites7F_4008Set45Frame0 ; entry 0
    dw MetaSprites7F_4008Set45Frame1 ; entry 1
    dw MetaSprites7F_4008Set45Frame2 ; entry 2
    dw MetaSprites7F_4008Set45Frame3 ; entry 3
    dw MetaSprites7F_4008Set45Frame4 ; entry 4
    dw MetaSprites7F_4008Set45Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set45; ends with $80 (E-0147)
MetaSprites7F_4008Set45Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f9, $f8, $03, $00 ; entry 1
    db $f1, $00, $01, $00 ; entry 2
    db $f9, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set45; ends with $80 (E-0147)
MetaSprites7F_4008Set45Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set45; ends with $80 (E-0147)
MetaSprites7F_4008Set45Frame3::
    db $f9, $f7, $08, $00 ; entry 0
    db $f9, $ff, $09, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set45; ends with $80 (E-0147)
MetaSprites7F_4008Set45Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 70 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set46::
    dw MetaSprites7F_4008Set46Frame0 ; entry 0
    dw MetaSprites7F_4008Set46Frame1 ; entry 1
    dw MetaSprites7F_4008Set46Frame2 ; entry 2
    dw MetaSprites7F_4008Set46Frame3 ; entry 3
    dw MetaSprites7F_4008Set46Frame4 ; entry 4
    dw MetaSprites7F_4008Set46Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame0::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set46; ends with $80 (E-0147)
MetaSprites7F_4008Set46Frame1::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set46; ends with $80 (E-0147)
MetaSprites7F_4008Set46Frame2::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set46; ends with $80 (E-0147)
MetaSprites7F_4008Set46Frame3::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame4::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set46; ends with $80 (E-0147)
MetaSprites7F_4008Set46Frame5::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 71 of MetaSprites7F_4008Table: 3 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set47::
    dw MetaSprites7F_4008Set47Frame0 ; entry 0
    dw MetaSprites7F_4008Set47Frame1 ; entry 1
    dw MetaSprites7F_4008Set47Frame2 ; entry 2

; frame 0 of MetaSprites7F_4008Set47; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set47Frame0::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $f8, $01, $00 ; entry 1
    db $e0, $00, $02, $00 ; entry 2
    db $e0, $08, $03, $00 ; entry 3
    db $e8, $f0, $04, $00 ; entry 4
    db $e8, $f8, $05, $00 ; entry 5
    db $e8, $00, $06, $00 ; entry 6
    db $e8, $08, $07, $00 ; entry 7
    db $f0, $ee, $08, $00 ; entry 8
    db $f0, $f6, $09, $00 ; entry 9
    db $f0, $fe, $0a, $00 ; entry 10
    db $f0, $06, $0b, $00 ; entry 11
    db $f8, $ee, $0c, $00 ; entry 12
    db $f8, $f6, $0d, $00 ; entry 13
    db $f8, $fe, $0e, $00 ; entry 14
    db $f8, $06, $0f, $00 ; entry 15
    db $f1, $0e, $10, $00 ; entry 16
    db $f2, $e6, $10, $20 ; entry 17
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set47; ends with $80 (E-0147)
MetaSprites7F_4008Set47Frame1::
    db $e0, $f0, $11, $00 ; entry 0
    db $e0, $f8, $12, $00 ; entry 1
    db $e0, $07, $11, $20 ; entry 2
    db $e0, $ff, $12, $20 ; entry 3
    db $e8, $f0, $13, $00 ; entry 4
    db $e8, $f8, $14, $00 ; entry 5
    db $e8, $07, $13, $20 ; entry 6
    db $e8, $ff, $14, $20 ; entry 7
    db $f0, $e8, $15, $00 ; entry 8
    db $f0, $f0, $16, $00 ; entry 9
    db $f0, $f8, $17, $00 ; entry 10
    db $f0, $0f, $15, $20 ; entry 11
    db $f0, $07, $16, $20 ; entry 12
    db $f0, $ff, $17, $20 ; entry 13
    db $f8, $e8, $18, $00 ; entry 14
    db $f8, $f0, $19, $00 ; entry 15
    db $f8, $f8, $1a, $00 ; entry 16
    db $f8, $0f, $18, $20 ; entry 17
    db $f8, $07, $19, $20 ; entry 18
    db $f8, $ff, $1a, $20 ; entry 19
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set47; ends with $80 (E-0147)
MetaSprites7F_4008Set47Frame2::
    db $e0, $08, $00, $20 ; entry 0
    db $e0, $00, $01, $20 ; entry 1
    db $e0, $f8, $02, $20 ; entry 2
    db $e0, $f0, $03, $20 ; entry 3
    db $e8, $08, $04, $20 ; entry 4
    db $e8, $00, $05, $20 ; entry 5
    db $e8, $f8, $06, $20 ; entry 6
    db $e8, $f0, $07, $20 ; entry 7
    db $f0, $0a, $08, $20 ; entry 8
    db $f0, $02, $09, $20 ; entry 9
    db $f0, $fa, $0a, $20 ; entry 10
    db $f0, $f2, $0b, $20 ; entry 11
    db $f8, $0a, $0c, $20 ; entry 12
    db $f8, $02, $0d, $20 ; entry 13
    db $f8, $fa, $0e, $20 ; entry 14
    db $f8, $f2, $0f, $20 ; entry 15
    db $f1, $ea, $10, $20 ; entry 16
    db $f2, $12, $10, $00 ; entry 17
    db $80 ; end

; meta-sprite set 72 of MetaSprites7F_4008Table: 3 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set48::
    dw MetaSprites7F_4008Set48Frame0 ; entry 0
    dw MetaSprites7F_4008Set48Frame1 ; entry 1
    dw MetaSprites7F_4008Set48Frame2 ; entry 2

; frame 0 of MetaSprites7F_4008Set48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set48Frame0::
    db $f0, $f0, $08, $00 ; entry 0
    db $f0, $f8, $09, $00 ; entry 1
    db $f0, $00, $0a, $00 ; entry 2
    db $f0, $08, $0b, $00 ; entry 3
    db $f8, $f0, $0c, $00 ; entry 4
    db $f8, $f8, $0d, $00 ; entry 5
    db $f8, $00, $0e, $00 ; entry 6
    db $f8, $08, $0f, $00 ; entry 7
    db $e0, $f0, $00, $00 ; entry 8
    db $e0, $f8, $01, $00 ; entry 9
    db $e0, $00, $02, $00 ; entry 10
    db $e0, $08, $03, $00 ; entry 11
    db $e8, $f0, $04, $00 ; entry 12
    db $e8, $f8, $05, $00 ; entry 13
    db $e8, $00, $06, $00 ; entry 14
    db $e8, $08, $07, $00 ; entry 15
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set48; ends with $80 (E-0147)
MetaSprites7F_4008Set48Frame1::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f0, $0c, $00 ; entry 2
    db $f8, $f8, $0d, $00 ; entry 3
    db $f8, $00, $0e, $00 ; entry 4
    db $f8, $08, $0f, $00 ; entry 5
    db $e0, $f8, $01, $00 ; entry 6
    db $e0, $00, $02, $00 ; entry 7
    db $e8, $00, $06, $00 ; entry 8
    db $e8, $f0, $10, $00 ; entry 9
    db $e8, $f8, $11, $00 ; entry 10
    db $f0, $f0, $12, $00 ; entry 11
    db $e0, $08, $13, $00 ; entry 12
    db $e8, $08, $14, $00 ; entry 13
    db $f0, $08, $15, $00 ; entry 14
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set48; ends with $80 (E-0147)
MetaSprites7F_4008Set48Frame2::
    db $f0, $00, $0a, $00 ; entry 0
    db $f8, $f0, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $f8, $08, $0f, $00 ; entry 4
    db $e0, $f8, $01, $00 ; entry 5
    db $e0, $00, $02, $00 ; entry 6
    db $e8, $00, $06, $00 ; entry 7
    db $e8, $f0, $16, $00 ; entry 8
    db $e8, $f8, $17, $00 ; entry 9
    db $f0, $f0, $18, $00 ; entry 10
    db $f0, $f8, $19, $00 ; entry 11
    db $e0, $08, $1a, $00 ; entry 12
    db $e8, $08, $1b, $00 ; entry 13
    db $f0, $08, $1c, $00 ; entry 14
    db $80 ; end

; meta-sprite set 73 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set49::
    dw MetaSprites7F_4008Set49Frame0 ; entry 0
    dw MetaSprites7F_4008Set49Frame1 ; entry 1
    dw MetaSprites7F_4008Set49Frame2 ; entry 2
    dw MetaSprites7F_4008Set49Frame3 ; entry 3
    dw MetaSprites7F_4008Set49Frame4 ; entry 4
    dw MetaSprites7F_4008Set49Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame0::
    db $ee, $f8, $00, $00 ; entry 0
    db $ee, $00, $01, $00 ; entry 1
    db $f6, $f8, $02, $00 ; entry 2
    db $f6, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set49; ends with $80 (E-0147)
MetaSprites7F_4008Set49Frame1::
    db $ee, $00, $00, $20 ; entry 0
    db $ee, $f8, $01, $20 ; entry 1
    db $f6, $00, $02, $20 ; entry 2
    db $f6, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set49; ends with $80 (E-0147)
MetaSprites7F_4008Set49Frame2::
    db $ee, $f8, $04, $00 ; entry 0
    db $ee, $00, $05, $00 ; entry 1
    db $f6, $f8, $06, $00 ; entry 2
    db $f6, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set49; ends with $80 (E-0147)
MetaSprites7F_4008Set49Frame3::
    db $ee, $f8, $08, $00 ; entry 0
    db $ee, $00, $09, $00 ; entry 1
    db $f6, $f8, $0a, $00 ; entry 2
    db $f6, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame4::
    db $ee, $f8, $0c, $00 ; entry 0
    db $ee, $00, $0d, $00 ; entry 1
    db $f6, $f8, $0e, $00 ; entry 2
    db $f6, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set49; ends with $80 (E-0147)
MetaSprites7F_4008Set49Frame5::
    db $ee, $00, $0c, $20 ; entry 0
    db $ee, $f8, $0d, $20 ; entry 1
    db $f6, $00, $0e, $20 ; entry 2
    db $f6, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 74 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set4A::
    dw MetaSprites7F_4008Set4AFrame0 ; entry 0
    dw MetaSprites7F_4008Set4AFrame1 ; entry 1
    dw MetaSprites7F_4008Set4AFrame2 ; entry 2
    dw MetaSprites7F_4008Set4AFrame3 ; entry 3
    dw MetaSprites7F_4008Set4AFrame4 ; entry 4
    dw MetaSprites7F_4008Set4AFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set4A; ends with $80 (E-0147)
MetaSprites7F_4008Set4AFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set4A; ends with $80 (E-0147)
MetaSprites7F_4008Set4AFrame2::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set4A; ends with $80 (E-0147)
MetaSprites7F_4008Set4AFrame3::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame4::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set4A; ends with $80 (E-0147)
MetaSprites7F_4008Set4AFrame5::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 75 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set4B::
    dw MetaSprites7F_4008Set4BFrame0 ; entry 0
    dw MetaSprites7F_4008Set4BFrame1 ; entry 1
    dw MetaSprites7F_4008Set4BFrame2 ; entry 2
    dw MetaSprites7F_4008Set4BFrame3 ; entry 3
    dw MetaSprites7F_4008Set4BFrame4 ; entry 4
    dw MetaSprites7F_4008Set4BFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set4B; ends with $80 (E-0147)
MetaSprites7F_4008Set4BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set4B; ends with $80 (E-0147)
MetaSprites7F_4008Set4BFrame2::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $05, $00 ; entry 2
    db $f8, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set4B; ends with $80 (E-0147)
MetaSprites7F_4008Set4BFrame3::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set4B; ends with $80 (E-0147)
MetaSprites7F_4008Set4BFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 76 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set4C::
    dw MetaSprites7F_4008Set4CFrame0 ; entry 0
    dw MetaSprites7F_4008Set4CFrame1 ; entry 1
    dw MetaSprites7F_4008Set4CFrame2 ; entry 2
    dw MetaSprites7F_4008Set4CFrame3 ; entry 3
    dw MetaSprites7F_4008Set4CFrame4 ; entry 4
    dw MetaSprites7F_4008Set4CFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set4C; ends with $80 (E-0147)
MetaSprites7F_4008Set4CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set4C; ends with $80 (E-0147)
MetaSprites7F_4008Set4CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set4C; ends with $80 (E-0147)
MetaSprites7F_4008Set4CFrame3::
    db $f0, $00, $05, $00 ; entry 0
    db $f0, $f8, $08, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set4C; ends with $80 (E-0147)
MetaSprites7F_4008Set4CFrame5::
    db $f0, $00, $0c, $00 ; entry 0
    db $f0, $f8, $0f, $00 ; entry 1
    db $f8, $ff, $0d, $20 ; entry 2
    db $f8, $f7, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 77 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set4D::
    dw MetaSprites7F_4008Set4DFrame0 ; entry 0
    dw MetaSprites7F_4008Set4DFrame1 ; entry 1
    dw MetaSprites7F_4008Set4DFrame2 ; entry 2
    dw MetaSprites7F_4008Set4DFrame3 ; entry 3
    dw MetaSprites7F_4008Set4DFrame4 ; entry 4
    dw MetaSprites7F_4008Set4DFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set4D; ends with $80 (E-0147)
MetaSprites7F_4008Set4DFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set4D; ends with $80 (E-0147)
MetaSprites7F_4008Set4DFrame2::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $05, $00 ; entry 2
    db $f8, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set4D; ends with $80 (E-0147)
MetaSprites7F_4008Set4DFrame3::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set4D; ends with $80 (E-0147)
MetaSprites7F_4008Set4DFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 78 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set4E::
    dw MetaSprites7F_4008Set4EFrame0 ; entry 0
    dw MetaSprites7F_4008Set4EFrame1 ; entry 1
    dw MetaSprites7F_4008Set4EFrame2 ; entry 2
    dw MetaSprites7F_4008Set4EFrame3 ; entry 3
    dw MetaSprites7F_4008Set4EFrame4 ; entry 4
    dw MetaSprites7F_4008Set4EFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set4E; ends with $80 (E-0147)
MetaSprites7F_4008Set4EFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set4E; ends with $80 (E-0147)
MetaSprites7F_4008Set4EFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set4E; ends with $80 (E-0147)
MetaSprites7F_4008Set4EFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $fd, $0a, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set4E; ends with $80 (E-0147)
MetaSprites7F_4008Set4EFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $fd, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; meta-sprite set 79 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set4F::
    dw MetaSprites7F_4008Set4FFrame0 ; entry 0
    dw MetaSprites7F_4008Set4FFrame1 ; entry 1
    dw MetaSprites7F_4008Set4FFrame2 ; entry 2
    dw MetaSprites7F_4008Set4FFrame3 ; entry 3
    dw MetaSprites7F_4008Set4FFrame4 ; entry 4
    dw MetaSprites7F_4008Set4FFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set4F; ends with $80 (E-0147)
MetaSprites7F_4008Set4FFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set4F; ends with $80 (E-0147)
MetaSprites7F_4008Set4FFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set4F; ends with $80 (E-0147)
MetaSprites7F_4008Set4FFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $fd, $0a, $20 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set4F; ends with $80 (E-0147)
MetaSprites7F_4008Set4FFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $fd, $0a, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 80 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set50::
    dw MetaSprites7F_4008Set50Frame0 ; entry 0
    dw MetaSprites7F_4008Set50Frame1 ; entry 1
    dw MetaSprites7F_4008Set50Frame2 ; entry 2
    dw MetaSprites7F_4008Set50Frame3 ; entry 3
    dw MetaSprites7F_4008Set50Frame4 ; entry 4
    dw MetaSprites7F_4008Set50Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set50; ends with $80 (E-0147)
MetaSprites7F_4008Set50Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set50; ends with $80 (E-0147)
MetaSprites7F_4008Set50Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set50; ends with $80 (E-0147)
MetaSprites7F_4008Set50Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set50; ends with $80 (E-0147)
MetaSprites7F_4008Set50Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 81 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set51::
    dw MetaSprites7F_4008Set51Frame0 ; entry 0
    dw MetaSprites7F_4008Set51Frame1 ; entry 1
    dw MetaSprites7F_4008Set51Frame2 ; entry 2
    dw MetaSprites7F_4008Set51Frame3 ; entry 3
    dw MetaSprites7F_4008Set51Frame4 ; entry 4
    dw MetaSprites7F_4008Set51Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set51; ends with $80 (E-0147)
MetaSprites7F_4008Set51Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set51; ends with $80 (E-0147)
MetaSprites7F_4008Set51Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set51; ends with $80 (E-0147)
MetaSprites7F_4008Set51Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set51; ends with $80 (E-0147)
MetaSprites7F_4008Set51Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 82 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set52::
    dw MetaSprites7F_4008Set52Frame0 ; entry 0
    dw MetaSprites7F_4008Set52Frame1 ; entry 1
    dw MetaSprites7F_4008Set52Frame2 ; entry 2
    dw MetaSprites7F_4008Set52Frame3 ; entry 3
    dw MetaSprites7F_4008Set52Frame4 ; entry 4
    dw MetaSprites7F_4008Set52Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set52; ends with $80 (E-0147)
MetaSprites7F_4008Set52Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set52; ends with $80 (E-0147)
MetaSprites7F_4008Set52Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set52; ends with $80 (E-0147)
MetaSprites7F_4008Set52Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set52; ends with $80 (E-0147)
MetaSprites7F_4008Set52Frame5::
    db $f0, $ff, $0a, $20 ; entry 0
    db $f0, $f7, $0b, $20 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 83 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set53::
    dw MetaSprites7F_4008Set53Frame0 ; entry 0
    dw MetaSprites7F_4008Set53Frame1 ; entry 1
    dw MetaSprites7F_4008Set53Frame2 ; entry 2
    dw MetaSprites7F_4008Set53Frame3 ; entry 3
    dw MetaSprites7F_4008Set53Frame4 ; entry 4
    dw MetaSprites7F_4008Set53Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set53; ends with $80 (E-0147)
MetaSprites7F_4008Set53Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set53; ends with $80 (E-0147)
MetaSprites7F_4008Set53Frame2::
    db $f0, $f6, $04, $00 ; entry 0
    db $f0, $fe, $05, $00 ; entry 1
    db $f8, $f6, $06, $00 ; entry 2
    db $f8, $fe, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set53; ends with $80 (E-0147)
MetaSprites7F_4008Set53Frame3::
    db $f8, $f6, $08, $00 ; entry 0
    db $f8, $fe, $09, $00 ; entry 1
    db $f0, $f6, $04, $00 ; entry 2
    db $f0, $fe, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $ff, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set53; ends with $80 (E-0147)
MetaSprites7F_4008Set53Frame5::
    db $f0, $f7, $0b, $20 ; entry 0
    db $f8, $ff, $0d, $20 ; entry 1
    db $f0, $ff, $0a, $20 ; entry 2
    db $f8, $f8, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 84 of MetaSprites7F_4008Table: 8 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set54::
    dw MetaSprites7F_4008Set54Frame0 ; entry 0
    dw MetaSprites7F_4008Set54Frame1 ; entry 1
    dw MetaSprites7F_4008Set54Frame2 ; entry 2
    dw MetaSprites7F_4008Set54Frame3 ; entry 3
    dw MetaSprites7F_4008Set54Frame4 ; entry 4
    dw MetaSprites7F_4008Set54Frame5 ; entry 5
    dw MetaSprites7F_4008Set54Frame6 ; entry 6
    dw MetaSprites7F_4008Set54Frame7 ; entry 7

; frame 0 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame0::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $08, $03, $00 ; entry 1
    db $e8, $07, $04, $20 ; entry 2
    db $e8, $ff, $05, $20 ; entry 3
    db $f0, $07, $06, $20 ; entry 4
    db $f0, $ff, $07, $20 ; entry 5
    db $f8, $07, $08, $20 ; entry 6
    db $f8, $ff, $09, $20 ; entry 7
    db $e0, $f8, $01, $00 ; entry 8
    db $e0, $00, $02, $00 ; entry 9
    db $e8, $f0, $04, $00 ; entry 10
    db $e8, $f8, $05, $00 ; entry 11
    db $f0, $f0, $06, $00 ; entry 12
    db $f0, $f8, $07, $00 ; entry 13
    db $f8, $f0, $08, $00 ; entry 14
    db $f8, $f8, $09, $00 ; entry 15
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
MetaSprites7F_4008Set54Frame1::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $08, $03, $00 ; entry 1
    db $e8, $07, $04, $20 ; entry 2
    db $f0, $07, $06, $20 ; entry 3
    db $f0, $ff, $07, $20 ; entry 4
    db $f8, $07, $08, $20 ; entry 5
    db $f8, $ff, $09, $20 ; entry 6
    db $e0, $f8, $01, $00 ; entry 7
    db $e0, $00, $02, $00 ; entry 8
    db $e8, $f0, $04, $00 ; entry 9
    db $f0, $f0, $06, $00 ; entry 10
    db $f0, $f8, $07, $00 ; entry 11
    db $f8, $f0, $08, $00 ; entry 12
    db $f8, $f8, $09, $00 ; entry 13
    db $e8, $f8, $0a, $00 ; entry 14
    db $e8, $ff, $19, $20 ; entry 15
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
MetaSprites7F_4008Set54Frame2::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $08, $03, $00 ; entry 1
    db $e8, $07, $04, $20 ; entry 2
    db $f0, $07, $06, $20 ; entry 3
    db $f0, $ff, $07, $20 ; entry 4
    db $f8, $07, $08, $20 ; entry 5
    db $f8, $ff, $09, $20 ; entry 6
    db $e0, $f8, $01, $00 ; entry 7
    db $e0, $00, $02, $00 ; entry 8
    db $e8, $f0, $04, $00 ; entry 9
    db $f0, $f0, $06, $00 ; entry 10
    db $f0, $f8, $07, $00 ; entry 11
    db $f8, $f0, $08, $00 ; entry 12
    db $f8, $f8, $09, $00 ; entry 13
    db $e8, $ff, $0a, $20 ; entry 14
    db $e8, $f8, $19, $00 ; entry 15
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
MetaSprites7F_4008Set54Frame3::
    db $e0, $f0, $00, $00 ; entry 0
    db $e8, $ff, $05, $20 ; entry 1
    db $f0, $07, $06, $20 ; entry 2
    db $f0, $ff, $07, $20 ; entry 3
    db $f8, $07, $08, $20 ; entry 4
    db $f8, $ff, $09, $20 ; entry 5
    db $e0, $f8, $01, $00 ; entry 6
    db $e8, $f0, $04, $00 ; entry 7
    db $e8, $f8, $05, $00 ; entry 8
    db $f0, $f0, $06, $00 ; entry 9
    db $f0, $f8, $07, $00 ; entry 10
    db $f8, $f0, $08, $00 ; entry 11
    db $f8, $f8, $09, $00 ; entry 12
    db $e0, $ff, $01, $20 ; entry 13
    db $e0, $07, $0b, $00 ; entry 14
    db $e8, $07, $0c, $00 ; entry 15
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame4::
    db $e0, $f0, $00, $00 ; entry 0
    db $e8, $ff, $05, $20 ; entry 1
    db $f0, $07, $06, $20 ; entry 2
    db $f0, $ff, $07, $20 ; entry 3
    db $f8, $07, $08, $20 ; entry 4
    db $f8, $ff, $09, $20 ; entry 5
    db $e0, $f8, $01, $00 ; entry 6
    db $e8, $f0, $04, $00 ; entry 7
    db $e8, $f8, $05, $00 ; entry 8
    db $f0, $f0, $06, $00 ; entry 9
    db $f0, $f8, $07, $00 ; entry 10
    db $f8, $f0, $08, $00 ; entry 11
    db $f8, $f8, $09, $00 ; entry 12
    db $e0, $07, $00, $20 ; entry 13
    db $e0, $ff, $01, $20 ; entry 14
    db $e8, $07, $0d, $00 ; entry 15
    db $e8, $0f, $0e, $00 ; entry 16
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
MetaSprites7F_4008Set54Frame5::
    db $e0, $f0, $00, $00 ; entry 0
    db $e8, $ff, $05, $20 ; entry 1
    db $f0, $07, $06, $20 ; entry 2
    db $f0, $ff, $07, $20 ; entry 3
    db $f8, $07, $08, $20 ; entry 4
    db $f8, $ff, $09, $20 ; entry 5
    db $e0, $f8, $01, $00 ; entry 6
    db $e8, $f0, $04, $00 ; entry 7
    db $e8, $f8, $05, $00 ; entry 8
    db $f0, $f0, $06, $00 ; entry 9
    db $f0, $f8, $07, $00 ; entry 10
    db $f8, $f0, $08, $00 ; entry 11
    db $f8, $f8, $09, $00 ; entry 12
    db $e0, $ff, $01, $20 ; entry 13
    db $e0, $07, $0f, $00 ; entry 14
    db $e0, $0f, $10, $00 ; entry 15
    db $e8, $07, $11, $00 ; entry 16
    db $80 ; end

; frame 6 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
MetaSprites7F_4008Set54Frame6::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $08, $03, $00 ; entry 1
    db $e8, $07, $04, $20 ; entry 2
    db $f0, $07, $06, $20 ; entry 3
    db $f8, $07, $08, $20 ; entry 4
    db $f8, $ff, $09, $20 ; entry 5
    db $e8, $f0, $04, $00 ; entry 6
    db $f0, $f0, $06, $00 ; entry 7
    db $f8, $f0, $08, $00 ; entry 8
    db $f8, $f8, $09, $00 ; entry 9
    db $e8, $ff, $14, $20 ; entry 10
    db $e0, $f8, $12, $00 ; entry 11
    db $e0, $00, $13, $00 ; entry 12
    db $e8, $f8, $14, $00 ; entry 13
    db $f0, $f8, $07, $00 ; entry 14
    db $f0, $ff, $07, $20 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites7F_4008Set54; ends with $80 (E-0147)
MetaSprites7F_4008Set54Frame7::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $08, $03, $00 ; entry 1
    db $e8, $07, $04, $20 ; entry 2
    db $f0, $07, $06, $20 ; entry 3
    db $f8, $07, $08, $20 ; entry 4
    db $f8, $ff, $09, $20 ; entry 5
    db $e8, $f0, $04, $00 ; entry 6
    db $f0, $f0, $06, $00 ; entry 7
    db $f8, $f0, $08, $00 ; entry 8
    db $f8, $f8, $09, $00 ; entry 9
    db $e0, $f8, $15, $00 ; entry 10
    db $e0, $00, $16, $00 ; entry 11
    db $e8, $f8, $17, $00 ; entry 12
    db $e8, $ff, $17, $20 ; entry 13
    db $f0, $f8, $18, $00 ; entry 14
    db $f0, $ff, $18, $20 ; entry 15
    db $80 ; end

; meta-sprite set 85 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set55::
    dw MetaSprites7F_4008Set55Frame0 ; entry 0
    dw MetaSprites7F_4008Set55Frame1 ; entry 1
    dw MetaSprites7F_4008Set55Frame2 ; entry 2
    dw MetaSprites7F_4008Set55Frame3 ; entry 3
    dw MetaSprites7F_4008Set55Frame4 ; entry 4
    dw MetaSprites7F_4008Set55Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set55; ends with $80 (E-0147)
MetaSprites7F_4008Set55Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set55; ends with $80 (E-0147)
MetaSprites7F_4008Set55Frame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set55; ends with $80 (E-0147)
MetaSprites7F_4008Set55Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame4::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set55; ends with $80 (E-0147)
MetaSprites7F_4008Set55Frame5::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 86 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set56::
    dw MetaSprites7F_4008Set56Frame0 ; entry 0
    dw MetaSprites7F_4008Set56Frame1 ; entry 1
    dw MetaSprites7F_4008Set56Frame2 ; entry 2
    dw MetaSprites7F_4008Set56Frame3 ; entry 3
    dw MetaSprites7F_4008Set56Frame4 ; entry 4
    dw MetaSprites7F_4008Set56Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set56; ends with $80 (E-0147)
MetaSprites7F_4008Set56Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set56; ends with $80 (E-0147)
MetaSprites7F_4008Set56Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set56; ends with $80 (E-0147)
MetaSprites7F_4008Set56Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set56; ends with $80 (E-0147)
MetaSprites7F_4008Set56Frame5::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 87 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set57::
    dw MetaSprites7F_4008Set57Frame0 ; entry 0
    dw MetaSprites7F_4008Set57Frame1 ; entry 1
    dw MetaSprites7F_4008Set57Frame2 ; entry 2
    dw MetaSprites7F_4008Set57Frame3 ; entry 3
    dw MetaSprites7F_4008Set57Frame4 ; entry 4
    dw MetaSprites7F_4008Set57Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set57; ends with $80 (E-0147)
MetaSprites7F_4008Set57Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set57; ends with $80 (E-0147)
MetaSprites7F_4008Set57Frame2::
    db $f9, $f8, $06, $00 ; entry 0
    db $f9, $00, $07, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set57; ends with $80 (E-0147)
MetaSprites7F_4008Set57Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $ff, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set57; ends with $80 (E-0147)
MetaSprites7F_4008Set57Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 88 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set58::
    dw MetaSprites7F_4008Set58Frame0 ; entry 0
    dw MetaSprites7F_4008Set58Frame1 ; entry 1
    dw MetaSprites7F_4008Set58Frame2 ; entry 2
    dw MetaSprites7F_4008Set58Frame3 ; entry 3
    dw MetaSprites7F_4008Set58Frame4 ; entry 4
    dw MetaSprites7F_4008Set58Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set58; ends with $80 (E-0147)
MetaSprites7F_4008Set58Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set58; ends with $80 (E-0147)
MetaSprites7F_4008Set58Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set58; ends with $80 (E-0147)
MetaSprites7F_4008Set58Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set58; ends with $80 (E-0147)
MetaSprites7F_4008Set58Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 89 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set59::
    dw MetaSprites7F_4008Set59Frame0 ; entry 0
    dw MetaSprites7F_4008Set59Frame1 ; entry 1
    dw MetaSprites7F_4008Set59Frame2 ; entry 2
    dw MetaSprites7F_4008Set59Frame3 ; entry 3
    dw MetaSprites7F_4008Set59Frame4 ; entry 4
    dw MetaSprites7F_4008Set59Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set59; ends with $80 (E-0147)
MetaSprites7F_4008Set59Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set59; ends with $80 (E-0147)
MetaSprites7F_4008Set59Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set59; ends with $80 (E-0147)
MetaSprites7F_4008Set59Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set59; ends with $80 (E-0147)
MetaSprites7F_4008Set59Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; meta-sprite set 90 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set5A::
    dw MetaSprites7F_4008Set5AFrame0 ; entry 0
    dw MetaSprites7F_4008Set5AFrame1 ; entry 1
    dw MetaSprites7F_4008Set5AFrame2 ; entry 2
    dw MetaSprites7F_4008Set5AFrame3 ; entry 3
    dw MetaSprites7F_4008Set5AFrame4 ; entry 4
    dw MetaSprites7F_4008Set5AFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame0::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set5A; ends with $80 (E-0147)
MetaSprites7F_4008Set5AFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set5A; ends with $80 (E-0147)
MetaSprites7F_4008Set5AFrame2::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set5A; ends with $80 (E-0147)
MetaSprites7F_4008Set5AFrame3::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame4::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set5A; ends with $80 (E-0147)
MetaSprites7F_4008Set5AFrame5::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; meta-sprite set 91 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set5B::
    dw MetaSprites7F_4008Set5BFrame0 ; entry 0
    dw MetaSprites7F_4008Set5BFrame1 ; entry 1
    dw MetaSprites7F_4008Set5BFrame2 ; entry 2
    dw MetaSprites7F_4008Set5BFrame3 ; entry 3
    dw MetaSprites7F_4008Set5BFrame4 ; entry 4
    dw MetaSprites7F_4008Set5BFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set5B; ends with $80 (E-0147)
MetaSprites7F_4008Set5BFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set5B; ends with $80 (E-0147)
MetaSprites7F_4008Set5BFrame2::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set5B; ends with $80 (E-0147)
MetaSprites7F_4008Set5BFrame3::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame4::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set5B; ends with $80 (E-0147)
MetaSprites7F_4008Set5BFrame5::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 92 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set5C::
    dw MetaSprites7F_4008Set5CFrame0 ; entry 0
    dw MetaSprites7F_4008Set5CFrame1 ; entry 1
    dw MetaSprites7F_4008Set5CFrame2 ; entry 2
    dw MetaSprites7F_4008Set5CFrame3 ; entry 3
    dw MetaSprites7F_4008Set5CFrame4 ; entry 4
    dw MetaSprites7F_4008Set5CFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set5C; ends with $80 (E-0147)
MetaSprites7F_4008Set5CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set5C; ends with $80 (E-0147)
MetaSprites7F_4008Set5CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set5C; ends with $80 (E-0147)
MetaSprites7F_4008Set5CFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set5C; ends with $80 (E-0147)
MetaSprites7F_4008Set5CFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 95 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set5F::
    dw MetaSprites7F_4008Set5FFrame0 ; entry 0
    dw MetaSprites7F_4008Set5FFrame1 ; entry 1
    dw MetaSprites7F_4008Set5FFrame2 ; entry 2
    dw MetaSprites7F_4008Set5FFrame3 ; entry 3
    dw MetaSprites7F_4008Set5FFrame4 ; entry 4
    dw MetaSprites7F_4008Set5FFrame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set5F; ends with $80 (E-0147)
MetaSprites7F_4008Set5FFrame1::
    db $f9, $00, $01, $20 ; entry 0
    db $f9, $f8, $02, $20 ; entry 1
    db $f1, $f8, $03, $00 ; entry 2
    db $f1, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set5F; ends with $80 (E-0147)
MetaSprites7F_4008Set5FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set5F; ends with $80 (E-0147)
MetaSprites7F_4008Set5FFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set5F; ends with $80 (E-0147)
MetaSprites7F_4008Set5FFrame5::
    db $f1, $f8, $0f, $00 ; entry 0
    db $f1, $00, $0f, $20 ; entry 1
    db $f9, $00, $0d, $20 ; entry 2
    db $f9, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 97 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_4008Set61::
    dw MetaSprites7F_4008Set61Frame0 ; entry 0
    dw MetaSprites7F_4008Set61Frame1 ; entry 1
    dw MetaSprites7F_4008Set61Frame2 ; entry 2
    dw MetaSprites7F_4008Set61Frame3 ; entry 3
    dw MetaSprites7F_4008Set61Frame4 ; entry 4
    dw MetaSprites7F_4008Set61Frame5 ; entry 5

; frame 0 of MetaSprites7F_4008Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_4008Set61; ends with $80 (E-0147)
MetaSprites7F_4008Set61Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_4008Set61; ends with $80 (E-0147)
MetaSprites7F_4008Set61Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_4008Set61; ends with $80 (E-0147)
MetaSprites7F_4008Set61Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_4008Set61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_4008Set61; ends with $80 (E-0147)
MetaSprites7F_4008Set61Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; DE = MetaSprites7F_7011Table (the table of meta-sprite sets), then DrawMetaSpriteAt
DrawMetaSprite::
    ld de, MetaSprites7F_7011Table
    call DrawMetaSpriteAt
    ret

; the caller of DrawMetaSprite passes DE = $MetaSprites7F_7011Table; the builder takes the word at
; DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 42
; words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites7F_7011Table::
    dw MetaSprites7F_7011Set00 ; id 0
    dw MetaSprites7F_7011Set01 ; id 1
    dw MetaSprites7F_7011Set02 ; id 2
    dw MetaSprites7F_7011Set03 ; id 3
    dw MetaSprites7F_7011Set04 ; id 4
    dw MetaSprites7F_7011Set05 ; id 5
    dw MetaSprites7F_7011Set06 ; id 6
    dw MetaSprites7F_7011Set07 ; id 7
    dw MetaSprites7F_7011Set08 ; id 8
    dw MetaSprites7F_7011Set09 ; id 9
    dw MetaSprites7F_7011Set0A ; id 10
    dw MetaSprites7F_7011Set0B ; id 11
    dw MetaSprites7F_7011Set0C ; id 12
    dw MetaSprites7F_7011Set0D ; id 13
    dw MetaSprites7F_7011Set0E ; id 14
    dw MetaSprites7F_7011Set0F ; id 15
    dw MetaSprites7F_7011Set10 ; id 16
    dw MetaSprites7F_7011Set11 ; id 17
    dw MetaSprites7F_7011Set12 ; id 18
    dw MetaSprites7F_7011Set13 ; id 19
    dw MetaSprites7F_7011Set14 ; id 20
    dw MetaSprites7F_7011Set15 ; id 21
    dw MetaSprites7F_7011Set16 ; id 22
    dw MetaSprites7F_7011Set17 ; id 23
    dw MetaSprites7F_7011Set18 ; id 24
    dw MetaSprites7F_7011Set19 ; id 25
    dw MetaSprites7F_7011Set1A ; id 26
    dw MetaSprites7F_7011Set1B ; id 27
    dw MetaSprites7F_7011Set1C ; id 28
    dw MetaSprites7F_7011Set1D ; id 29
    dw MetaSprites7F_7011Set1E ; id 30
    dw MetaSprites7F_7011Set1F ; id 31
    dw MetaSprites7F_7011Set20 ; id 32
    dw MetaSprites7F_7011Set21 ; id 33
    dw MetaSprites7F_7011Set22 ; id 34
    dw MetaSprites7F_7011Set23 ; id 35
    dw MetaSprites7F_7011Set24 ; id 36
    dw MetaSprites7F_7011Set25 ; id 37
    dw MetaSprites7F_7011Set26 ; id 38
    dw MetaSprites7F_7011Set27 ; id 39
    dw MetaSprites7F_7011Set28 ; id 40
    dw MetaSprites7F_7011Set29 ; id 41

; DE = table of set pointers: returns at once when hOamNextEntry is $27 or more; otherwise converts
; the 16-bit position (hSpriteOriginX with hSpriteOriginXHi, hSpriteOriginY with hSpriteOriginYHi)
; to screen coordinates by adding the scroll-offset words hSpriteScrollXLo/Hi and
; hSpriteScrollYLo/Hi, and writes OAM entries for the sprite chosen by hSpriteSetIndex and
; hSpriteSubIndex (tile += hSpriteTileOffset, attribute ^= hSpriteAttrXor)
DrawMetaSpriteAt::
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
    call BGTileUnderPointIsSpriteHideTile_Bank7F
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
    call BGTileUnderPointIsSpriteHideTile_Bank7F
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
BGTileUnderPointIsSpriteHideTile_Bank7F::
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

; meta-sprite set 0 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set00::
    dw MetaSprites7F_7011Set00Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set00Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 1 of MetaSprites7F_7011Table: 2 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set01::
    dw MetaSprites7F_7011Set01Frame0 ; entry 0
    dw MetaSprites7F_7011Set01Frame1 ; entry 1

; frame 0 of MetaSprites7F_7011Set01; ends with $80 (E-0147)
MetaSprites7F_7011Set01Frame0::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set01; ends with $80 (E-0147)
MetaSprites7F_7011Set01Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set02::
    dw MetaSprites7F_7011Set02Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set03::
    dw MetaSprites7F_7011Set03Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set03; ends with $80 (E-0147)
MetaSprites7F_7011Set03Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set04::
    dw MetaSprites7F_7011Set04Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set05::
    dw MetaSprites7F_7011Set05Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set05; ends with $80 (E-0147)
MetaSprites7F_7011Set05Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 6 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set06::
    dw MetaSprites7F_7011Set06Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set06Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 7 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set07::
    dw MetaSprites7F_7011Set07Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set07; ends with $80 (E-0147)
MetaSprites7F_7011Set07Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 8 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set08::
    dw MetaSprites7F_7011Set08Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set08Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 9 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set09::
    dw MetaSprites7F_7011Set09Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set09; ends with $80 (E-0147)
MetaSprites7F_7011Set09Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 10 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set0A::
    dw MetaSprites7F_7011Set0AFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 11 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set0B::
    dw MetaSprites7F_7011Set0BFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set0B; ends with $80 (E-0147)
MetaSprites7F_7011Set0BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 12 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set0C::
    dw MetaSprites7F_7011Set0CFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 13 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set0D::
    dw MetaSprites7F_7011Set0DFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set0D; ends with $80 (E-0147)
MetaSprites7F_7011Set0DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 14 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set0E::
    dw MetaSprites7F_7011Set0EFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set0F::
    dw MetaSprites7F_7011Set0FFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set0F; ends with $80 (E-0147)
MetaSprites7F_7011Set0FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set10::
    dw MetaSprites7F_7011Set10Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set10Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set11::
    dw MetaSprites7F_7011Set11Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set11; ends with $80 (E-0147)
MetaSprites7F_7011Set11Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 18 of MetaSprites7F_7011Table: 4 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set12::
    dw MetaSprites7F_7011Set12Frame0 ; entry 0
    dw MetaSprites7F_7011Set12Frame1 ; entry 1
    dw MetaSprites7F_7011Set12Frame2 ; entry 2
    dw MetaSprites7F_7011Set12Frame3 ; entry 3

; frame 0 of MetaSprites7F_7011Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set12Frame0::
    db $ec, $f8, $00, $00 ; entry 0
    db $f4, $f8, $01, $00 ; entry 1
    db $f4, $00, $01, $20 ; entry 2
    db $ec, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set12; ends with $80 (E-0147)
MetaSprites7F_7011Set12Frame1::
    db $ed, $f8, $02, $00 ; entry 0
    db $f5, $f8, $03, $00 ; entry 1
    db $ed, $00, $02, $20 ; entry 2
    db $f5, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set12; ends with $80 (E-0147)
MetaSprites7F_7011Set12Frame2::
    db $ec, $f8, $04, $00 ; entry 0
    db $f4, $f8, $05, $00 ; entry 1
    db $ec, $00, $04, $20 ; entry 2
    db $f4, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set12; ends with $80 (E-0147)
MetaSprites7F_7011Set12Frame3::
    db $ed, $f8, $06, $00 ; entry 0
    db $f5, $f8, $07, $00 ; entry 1
    db $ed, $00, $06, $20 ; entry 2
    db $f5, $00, $07, $20 ; entry 3
    db $80 ; end

; meta-sprite set 19 of MetaSprites7F_7011Table: 4 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set13::
    dw MetaSprites7F_7011Set13Frame0 ; entry 0
    dw MetaSprites7F_7011Set13Frame1 ; entry 1
    dw MetaSprites7F_7011Set13Frame2 ; entry 2
    dw MetaSprites7F_7011Set13Frame3 ; entry 3

; frame 0 of MetaSprites7F_7011Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set13Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set13; ends with $80 (E-0147)
MetaSprites7F_7011Set13Frame1::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set13; ends with $80 (E-0147)
MetaSprites7F_7011Set13Frame2::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set13; ends with $80 (E-0147)
MetaSprites7F_7011Set13Frame3::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0f, $00 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 20 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set14::
    dw MetaSprites7F_7011Set14Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set14Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 21 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set15::
    dw MetaSprites7F_7011Set15Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set15; ends with $80 (E-0147)
MetaSprites7F_7011Set15Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 22 of MetaSprites7F_7011Table: 2 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set16::
    dw MetaSprites7F_7011Set16Frame0 ; entry 0
    dw MetaSprites7F_7011Set16Frame1 ; entry 1

; frame 0 of MetaSprites7F_7011Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set16Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set16; ends with $80 (E-0147)
MetaSprites7F_7011Set16Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 23 of MetaSprites7F_7011Table: 3 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set17::
    dw MetaSprites7F_7011Set17Frame0 ; entry 0
    dw MetaSprites7F_7011Set17Frame1 ; entry 1
    dw MetaSprites7F_7011Set17Frame2 ; entry 2

; frame 0 of MetaSprites7F_7011Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set17Frame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set17; ends with $80 (E-0147)
MetaSprites7F_7011Set17Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set17; ends with $80 (E-0147)
MetaSprites7F_7011Set17Frame2::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 24 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set18::
    dw MetaSprites7F_7011Set18Frame0 ; entry 0
    dw MetaSprites7F_7011Set18Frame1 ; entry 1
    dw MetaSprites7F_7011Set18Frame2 ; entry 2
    dw MetaSprites7F_7011Set18Frame3 ; entry 3
    dw MetaSprites7F_7011Set18Frame4 ; entry 4
    dw MetaSprites7F_7011Set18Frame5 ; entry 5

; frame 0 of MetaSprites7F_7011Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set18; ends with $80 (E-0147)
MetaSprites7F_7011Set18Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set18; ends with $80 (E-0147)
MetaSprites7F_7011Set18Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set18; ends with $80 (E-0147)
MetaSprites7F_7011Set18Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set18; ends with $80 (E-0147)
MetaSprites7F_7011Set18Frame5::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 25 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set19::
    dw MetaSprites7F_7011Set19Frame0 ; entry 0
    dw MetaSprites7F_7011Set19Frame1 ; entry 1
    dw MetaSprites7F_7011Set19Frame2 ; entry 2
    dw MetaSprites7F_7011Set19Frame3 ; entry 3
    dw MetaSprites7F_7011Set19Frame4 ; entry 4
    dw MetaSprites7F_7011Set19Frame5 ; entry 5

; frame 0 of MetaSprites7F_7011Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set19; ends with $80 (E-0147)
MetaSprites7F_7011Set19Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set19; ends with $80 (E-0147)
MetaSprites7F_7011Set19Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set19; ends with $80 (E-0147)
MetaSprites7F_7011Set19Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set19; ends with $80 (E-0147)
MetaSprites7F_7011Set19Frame5::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites7F_7011Table: 2 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set1A::
    dw MetaSprites7F_7011Set1AFrame0 ; entry 0
    dw MetaSprites7F_7011Set1AFrame1 ; entry 1

; frame 0 of MetaSprites7F_7011Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1AFrame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set1A; ends with $80 (E-0147)
MetaSprites7F_7011Set1AFrame1::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set1B::
    dw MetaSprites7F_7011Set1BFrame0 ; entry 0
    dw MetaSprites7F_7011Set1BFrame1 ; entry 1
    dw MetaSprites7F_7011Set1BFrame2 ; entry 2
    dw MetaSprites7F_7011Set1BFrame3 ; entry 3
    dw MetaSprites7F_7011Set1BFrame4 ; entry 4
    dw MetaSprites7F_7011Set1BFrame5 ; entry 5

; frame 0 of MetaSprites7F_7011Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set1B; ends with $80 (E-0147)
MetaSprites7F_7011Set1BFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set1B; ends with $80 (E-0147)
MetaSprites7F_7011Set1BFrame2::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set1B; ends with $80 (E-0147)
MetaSprites7F_7011Set1BFrame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set1B; ends with $80 (E-0147)
MetaSprites7F_7011Set1BFrame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 28 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set1C::
    dw MetaSprites7F_7011Set1CFrame0 ; entry 0
    dw MetaSprites7F_7011Set1CFrame1 ; entry 1
    dw MetaSprites7F_7011Set1CFrame2 ; entry 2
    dw MetaSprites7F_7011Set1CFrame3 ; entry 3
    dw MetaSprites7F_7011Set1CFrame4 ; entry 4
    dw MetaSprites7F_7011Set1CFrame5 ; entry 5

; frame 0 of MetaSprites7F_7011Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set1C; ends with $80 (E-0147)
MetaSprites7F_7011Set1CFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set1C; ends with $80 (E-0147)
MetaSprites7F_7011Set1CFrame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set1C; ends with $80 (E-0147)
MetaSprites7F_7011Set1CFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set1C; ends with $80 (E-0147)
MetaSprites7F_7011Set1CFrame5::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 29 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set1D::
    dw MetaSprites7F_7011Set1DFrame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 30 of MetaSprites7F_7011Table: 4 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set1E::
    dw MetaSprites7F_7011Set1EFrame0 ; entry 0
    dw MetaSprites7F_7011Set1EFrame1 ; entry 1
    dw MetaSprites7F_7011Set1EFrame2 ; entry 2
    dw MetaSprites7F_7011Set1EFrame3 ; entry 3

; frame 0 of MetaSprites7F_7011Set1E; ends with $80 (E-0147)
MetaSprites7F_7011Set1EFrame0::
    db $f4, $fc, $00, $00 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set1E; ends with $80 (E-0147)
MetaSprites7F_7011Set1EFrame1::
    db $f4, $fc, $01, $00 ; entry 0
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1EFrame2::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $ff, $02, $20 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set1E; ends with $80 (E-0147)
MetaSprites7F_7011Set1EFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $ff, $04, $20 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $ff, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 31 of MetaSprites7F_7011Table: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set1F::
    dw MetaSprites7F_7011Set1FFrame0 ; entry 0
    dw MetaSprites7F_7011Set1FFrame1 ; entry 1
    dw MetaSprites7F_7011Set1FFrame2 ; entry 2
    dw MetaSprites7F_7011Set1FFrame3 ; entry 3
    dw MetaSprites7F_7011Set1FFrame4 ; entry 4
    dw MetaSprites7F_7011Set1FFrame5 ; entry 5
    dw MetaSprites7F_7011Set1FFrame6 ; entry 6
    dw MetaSprites7F_7011Set1FFrame7 ; entry 7
    dw MetaSprites7F_7011Set1FFrame7 ; entry 8
    dw MetaSprites7F_7011Set1FFrame7 ; entry 9
    dw MetaSprites7F_7011Set1FFrame7 ; entry 10
    dw MetaSprites7F_7011Set1FFrame7 ; entry 11
    dw MetaSprites7F_7011Set1FFrame7 ; entry 12
    dw MetaSprites7F_7011Set1FFrame7 ; entry 13
    dw MetaSprites7F_7011Set1FFrame7 ; entry 14
    dw MetaSprites7F_7011Set1FFrame7 ; entry 15
    dw MetaSprites7F_7011Set1FFrame7 ; entry 16
    dw MetaSprites7F_7011Set1FFrame7 ; entry 17
    dw MetaSprites7F_7011Set1FFrame7 ; entry 18
    dw MetaSprites7F_7011Set1FFrame7 ; entry 19
    dw MetaSprites7F_7011Set1FFrame7 ; entry 20
    dw MetaSprites7F_7011Set1FFrame7 ; entry 21
    dw MetaSprites7F_7011Set1FFrame7 ; entry 22
    dw MetaSprites7F_7011Set1FFrame7 ; entry 23
    dw MetaSprites7F_7011Set1FFrame7 ; entry 24
    dw MetaSprites7F_7011Set1FFrame7 ; entry 25
    dw MetaSprites7F_7011Set1FFrame7 ; entry 26
    dw MetaSprites7F_7011Set1FFrame7 ; entry 27
    dw MetaSprites7F_7011Set1FFrame7 ; entry 28
    dw MetaSprites7F_7011Set1FFrame7 ; entry 29
    dw MetaSprites7F_7011Set1FFrame7 ; entry 30
    dw MetaSprites7F_7011Set1FFrame7 ; entry 31

; frame 0 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
MetaSprites7F_7011Set1FFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
MetaSprites7F_7011Set1FFrame2::
    db $f0, $00, $04, $20 ; entry 0
    db $f0, $f8, $05, $20 ; entry 1
    db $f8, $00, $06, $20 ; entry 2
    db $f8, $f8, $07, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
MetaSprites7F_7011Set1FFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
MetaSprites7F_7011Set1FFrame5::
    db $f0, $f8, $10, $00 ; entry 0
    db $f0, $00, $11, $00 ; entry 1
    db $f8, $f8, $12, $00 ; entry 2
    db $f8, $00, $13, $00 ; entry 3
    db $f0, $f5, $18, $00 ; entry 4
    db $ee, $fc, $19, $00 ; entry 5
    db $ea, $04, $1a, $00 ; entry 6
    db $e8, $f5, $16, $00 ; entry 7
    db $e6, $fc, $17, $00 ; entry 8
    db $80 ; end

; frame 6 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
MetaSprites7F_7011Set1FFrame6::
    db $f0, $f8, $10, $00 ; entry 0
    db $f0, $00, $11, $00 ; entry 1
    db $f8, $f8, $14, $00 ; entry 2
    db $f8, $00, $15, $00 ; entry 3
    db $f8, $08, $1a, $00 ; entry 4
    db $f9, $ef, $16, $00 ; entry 5
    db $f8, $0c, $17, $00 ; entry 6
    db $80 ; end

; frame 7 of MetaSprites7F_7011Set1F; ends with $80 (E-0147)
MetaSprites7F_7011Set1FFrame7::
    db $08, $e0, $00, $00 ; entry 0
    db $08, $e8, $01, $00 ; entry 1
    db $08, $f0, $02, $00 ; entry 2
    db $08, $f8, $03, $00 ; entry 3
    db $08, $00, $04, $00 ; entry 4
    db $08, $08, $05, $00 ; entry 5
    db $08, $10, $06, $00 ; entry 6
    db $08, $18, $07, $00 ; entry 7
    db $10, $e0, $10, $00 ; entry 8
    db $10, $e8, $11, $00 ; entry 9
    db $10, $f0, $12, $00 ; entry 10
    db $10, $f8, $13, $00 ; entry 11
    db $10, $00, $14, $00 ; entry 12
    db $10, $08, $15, $00 ; entry 13
    db $10, $10, $16, $00 ; entry 14
    db $10, $18, $17, $00 ; entry 15
    db $18, $e0, $20, $00 ; entry 16
    db $18, $e8, $21, $00 ; entry 17
    db $18, $f0, $22, $00 ; entry 18
    db $18, $f8, $23, $00 ; entry 19
    db $18, $00, $24, $00 ; entry 20
    db $18, $08, $25, $00 ; entry 21
    db $18, $10, $26, $00 ; entry 22
    db $18, $18, $27, $00 ; entry 23
    db $20, $e0, $30, $00 ; entry 24
    db $20, $e8, $31, $00 ; entry 25
    db $20, $f0, $32, $00 ; entry 26
    db $20, $f8, $33, $00 ; entry 27
    db $20, $00, $34, $00 ; entry 28
    db $20, $08, $35, $00 ; entry 29
    db $20, $10, $36, $00 ; entry 30
    db $20, $18, $37, $00 ; entry 31
    db $28, $e0, $40, $00 ; entry 32
    db $28, $e8, $41, $00 ; entry 33
    db $28, $f0, $42, $00 ; entry 34
    db $28, $f8, $43, $00 ; entry 35
    db $28, $00, $44, $00 ; entry 36
    db $28, $08, $45, $00 ; entry 37
    db $28, $10, $46, $00 ; entry 38
    db $28, $18, $47, $00 ; entry 39
    db $30, $e0, $50, $00 ; entry 40
    db $30, $e8, $51, $00 ; entry 41
    db $30, $f0, $52, $00 ; entry 42
    db $30, $f8, $53, $00 ; entry 43
    db $30, $00, $54, $00 ; entry 44
    db $30, $08, $55, $00 ; entry 45
    db $30, $10, $56, $00 ; entry 46
    db $30, $18, $57, $00 ; entry 47
    db $38, $e0, $00, $00 ; entry 48
    db $38, $e8, $01, $00 ; entry 49
    db $38, $f0, $02, $00 ; entry 50
    db $38, $f8, $03, $00 ; entry 51
    db $38, $00, $04, $00 ; entry 52
    db $38, $08, $05, $00 ; entry 53
    db $38, $10, $06, $00 ; entry 54
    db $38, $18, $07, $00 ; entry 55
    db $40, $e0, $10, $00 ; entry 56
    db $40, $e8, $11, $00 ; entry 57
    db $40, $f0, $12, $00 ; entry 58
    db $40, $f8, $13, $00 ; entry 59
    db $40, $00, $14, $00 ; entry 60
    db $40, $08, $15, $00 ; entry 61
    db $40, $10, $16, $00 ; entry 62
    db $40, $18, $17, $00 ; entry 63
    db $80 ; end

; meta-sprite set 32 of MetaSprites7F_7011Table: 7 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set20::
    dw MetaSprites7F_7011Set20Frame0 ; entry 0
    dw MetaSprites7F_7011Set20Frame1 ; entry 1
    dw MetaSprites7F_7011Set20Frame2 ; entry 2
    dw MetaSprites7F_7011Set20Frame3 ; entry 3
    dw MetaSprites7F_7011Set20Frame4 ; entry 4
    dw MetaSprites7F_7011Set20Frame5 ; entry 5
    dw MetaSprites7F_7011Set20Frame6 ; entry 6

; frame 0 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
MetaSprites7F_7011Set20Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $00, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
MetaSprites7F_7011Set20Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f8, $f8, $05, $00 ; entry 1
    db $f0, $00, $04, $20 ; entry 2
    db $f8, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
MetaSprites7F_7011Set20Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $08, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
MetaSprites7F_7011Set20Frame5::
    db $f0, $00, $06, $20 ; entry 0
    db $f0, $f8, $07, $20 ; entry 1
    db $f8, $00, $08, $20 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 6 of MetaSprites7F_7011Set20; ends with $80 (E-0147)
MetaSprites7F_7011Set20Frame6::
    db $f0, $00, $09, $20 ; entry 0
    db $f0, $f8, $0a, $20 ; entry 1
    db $f8, $00, $0b, $20 ; entry 2
    db $f8, $f8, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 33 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set21::
    dw MetaSprites7F_7011Set21Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set21Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 34 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set22::
    dw MetaSprites7F_7011Set22Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set22; ends with $80 (E-0147)
MetaSprites7F_7011Set22Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 35 of MetaSprites7F_7011Table: 5 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set23::
    dw MetaSprites7F_7011Set23Frame0 ; entry 0
    dw MetaSprites7F_7011Set23Frame1 ; entry 1
    dw MetaSprites7F_7011Set23Frame2 ; entry 2
    dw MetaSprites7F_7011Set23Frame3 ; entry 3
    dw MetaSprites7F_7011Set23Frame4 ; entry 4

; frame 0 of MetaSprites7F_7011Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set23; ends with $80 (E-0147)
MetaSprites7F_7011Set23Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $03, $00 ; entry 1
    db $f8, $00, $02, $60 ; entry 2
    db $f8, $f8, $03, $60 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set23; ends with $80 (E-0147)
MetaSprites7F_7011Set23Frame2::
    db $f0, $00, $02, $20 ; entry 0
    db $f0, $f8, $03, $20 ; entry 1
    db $f8, $f8, $02, $40 ; entry 2
    db $f8, $00, $03, $40 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set23; ends with $80 (E-0147)
MetaSprites7F_7011Set23Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $00, $04, $60 ; entry 2
    db $f8, $f8, $05, $60 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame4::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $06, $60 ; entry 2
    db $f8, $f8, $07, $60 ; entry 3
    db $80 ; end

; meta-sprite set 36 of MetaSprites7F_7011Table: 5 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set24::
    dw MetaSprites7F_7011Set24Frame0 ; entry 0
    dw MetaSprites7F_7011Set24Frame1 ; entry 1
    dw MetaSprites7F_7011Set24Frame2 ; entry 2
    dw MetaSprites7F_7011Set24Frame3 ; entry 3
    dw MetaSprites7F_7011Set24Frame4 ; entry 4

; frame 0 of MetaSprites7F_7011Set24; ends with $80 (E-0147)
MetaSprites7F_7011Set24Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set24Frame1::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set24; ends with $80 (E-0147)
MetaSprites7F_7011Set24Frame2::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set24; ends with $80 (E-0147)
MetaSprites7F_7011Set24Frame3::
    db $f0, $01, $04, $20 ; entry 0
    db $f0, $f9, $05, $20 ; entry 1
    db $f8, $01, $06, $20 ; entry 2
    db $f8, $f9, $07, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set24; ends with $80 (E-0147)
MetaSprites7F_7011Set24Frame4::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites7F_7011Table: 5 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set25::
    dw MetaSprites7F_7011Set25Frame0 ; entry 0
    dw MetaSprites7F_7011Set25Frame1 ; entry 1
    dw MetaSprites7F_7011Set25Frame1 ; entry 2
    dw MetaSprites7F_7011Set25Frame2 ; entry 3
    dw MetaSprites7F_7011Set25Frame3 ; entry 4

; frame 0 of MetaSprites7F_7011Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set25Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set25; ends with $80 (E-0147)
MetaSprites7F_7011Set25Frame1::
    db $f0, $f8, $01, $00 ; entry 0
    db $f0, $00, $02, $00 ; entry 1
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set25; ends with $80 (E-0147)
MetaSprites7F_7011Set25Frame2::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $05, $00 ; entry 2
    db $f8, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set25; ends with $80 (E-0147)
MetaSprites7F_7011Set25Frame3::
    db $f8, $00, $07, $00 ; entry 0
    db $f8, $f8, $05, $00 ; entry 1
    db $80 ; end

; meta-sprite set 38 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set26::
    dw MetaSprites7F_7011Set26Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set26Frame0::
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; meta-sprite set 39 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set27::
    dw MetaSprites7F_7011Set27Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set27; ends with $80 (E-0147)
MetaSprites7F_7011Set27Frame0::
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; meta-sprite set 40 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7F_7011Set28::
    dw MetaSprites7F_7011Set28Frame0 ; entry 0

; frame 0 of MetaSprites7F_7011Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set28Frame0::
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; meta-sprite set 41 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
MetaSprites7F_7011Set29::
    dw MetaSprites7F_7011Set29Frame0 ; entry 0
    dw MetaSprites7F_7011Set29Frame1 ; entry 1
    dw MetaSprites7F_7011Set29Frame2 ; entry 2
    dw MetaSprites7F_7011Set29Frame3 ; entry 3
    dw MetaSprites7F_7011Set29Frame4 ; entry 4
    dw MetaSprites7F_7011Set29Frame5 ; entry 5

; frame 0 of MetaSprites7F_7011Set29; ends with $80 (E-0147)
MetaSprites7F_7011Set29Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7F_7011Set29; ends with $80 (E-0147)
MetaSprites7F_7011Set29Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7F_7011Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7F_7011Set29; ends with $80 (E-0147)
MetaSprites7F_7011Set29Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7F_7011Set29; ends with $80 (E-0147)
MetaSprites7F_7011Set29Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7F_7011Set29; ends with $80 (E-0147)
MetaSprites7F_7011Set29Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end
    ds $46a, $00
