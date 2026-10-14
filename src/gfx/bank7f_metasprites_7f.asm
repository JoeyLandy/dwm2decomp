; ROM bank $7F: meta-sprite frames
; The annotated listing of this bank is build/listing/bank7f.asm.

SECTION "Bank 7F", ROMX[$4000], BANK[$7F]
    db $7f

; DrawMetaSpriteAt_2 with DE = MetaSprites7FTable (E-0116) (E-0344: the address in its name dropped
; or read as the label there; was DrawMetaSprite_2)
DrawMetaSprite_2::
    ld de, MetaSprites7FTable
    call DrawMetaSpriteAt_2
    ret

; the caller of DrawMetaSprite_2 passes DE = $MetaSprites7FTable; the builder takes the word at DE +
; 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 98 words,
; up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites7FTable::
    dw MetaSprites7FSet00 ; id 0
    dw MetaSprites7FSet01 ; id 1
    dw MetaSprites7FSet02 ; id 2
    dw MetaSprites7FSet03 ; id 3
    dw MetaSprites7FSet04 ; id 4
    dw MetaSprites7FSet05 ; id 5
    dw MetaSprites7FSet06 ; id 6
    dw MetaSprites7FSet07 ; id 7
    dw MetaSprites7FSet08 ; id 8
    dw MetaSprites7FSet09 ; id 9
    dw MetaSprites7FSet0A ; id 10
    dw MetaSprites7FSet0B ; id 11
    dw MetaSprites7FSet0C ; id 12
    dw MetaSprites7FSet0D ; id 13
    dw MetaSprites7FSet0E ; id 14
    dw MetaSprites7FSet0F ; id 15
    dw MetaSprites7FSet10 ; id 16
    dw MetaSprites7FSet11 ; id 17
    dw MetaSprites7FSet12 ; id 18
    dw MetaSprites7FSet13 ; id 19
    dw MetaSprites7FSet14 ; id 20
    dw MetaSprites7FSet15 ; id 21
    dw MetaSprites7FSet16 ; id 22
    dw MetaSprites7FSet17 ; id 23
    dw MetaSprites7FSet18 ; id 24
    dw MetaSprites7FSet19 ; id 25
    dw MetaSprites7FSet1A ; id 26
    dw MetaSprites7FSet1B ; id 27
    dw MetaSprites7FSet1C ; id 28
    dw MetaSprites7FSet1D ; id 29
    dw MetaSprites7FSet1E ; id 30
    dw MetaSprites7FSet1F ; id 31
    dw MetaSprites7FSet20 ; id 32
    dw MetaSprites7FSet21 ; id 33
    dw MetaSprites7FSet22 ; id 34
    dw MetaSprites7FSet23 ; id 35
    dw MetaSprites7FSet24 ; id 36
    dw MetaSprites7FSet25 ; id 37
    dw MetaSprites7FSet26 ; id 38
    dw MetaSprites7FSet27 ; id 39
    dw MetaSprites7FSet28 ; id 40
    dw MetaSprites7FSet29 ; id 41
    dw MetaSprites7FSet2A ; id 42
    dw MetaSprites7FSet2B ; id 43
    dw MetaSprites7FSet2C ; id 44
    dw MetaSprites7FSet2D ; id 45
    dw MetaSprites7FSet2E ; id 46
    dw MetaSprites7FSet2F ; id 47
    dw MetaSprites7FSet30 ; id 48
    dw MetaSprites7FSet31 ; id 49
    dw MetaSprites7FSet32 ; id 50
    dw MetaSprites7FSet33 ; id 51
    dw MetaSprites7FSet34 ; id 52
    dw MetaSprites7FSet35 ; id 53
    dw MetaSprites7FSet36 ; id 54
    dw MetaSprites7FSet37 ; id 55
    dw MetaSprites7FSet38 ; id 56
    dw MetaSprites7FSet39 ; id 57
    dw MetaSprites7FSet3A ; id 58
    dw MetaSprites7FSet3B ; id 59
    dw MetaSprites7FSet3C ; id 60
    dw MetaSprites7FSet3D ; id 61
    dw MetaSprites7FSet3E ; id 62
    dw MetaSprites7FSet3F ; id 63
    dw MetaSprites7FSet40 ; id 64
    dw MetaSprites7FSet41 ; id 65
    dw MetaSprites7FSet42 ; id 66
    dw MetaSprites7FSet43 ; id 67
    dw MetaSprites7FSet44 ; id 68
    dw MetaSprites7FSet45 ; id 69
    dw MetaSprites7FSet46 ; id 70
    dw MetaSprites7FSet47 ; id 71
    dw MetaSprites7FSet48 ; id 72
    dw MetaSprites7FSet49 ; id 73
    dw MetaSprites7FSet4A ; id 74
    dw MetaSprites7FSet4B ; id 75
    dw MetaSprites7FSet4C ; id 76
    dw MetaSprites7FSet4D ; id 77
    dw MetaSprites7FSet4E ; id 78
    dw MetaSprites7FSet4F ; id 79
    dw MetaSprites7FSet50 ; id 80
    dw MetaSprites7FSet51 ; id 81
    dw MetaSprites7FSet52 ; id 82
    dw MetaSprites7FSet53 ; id 83
    dw MetaSprites7FSet54 ; id 84
    dw MetaSprites7FSet55 ; id 85
    dw MetaSprites7FSet56 ; id 86
    dw MetaSprites7FSet57 ; id 87
    dw MetaSprites7FSet58 ; id 88
    dw MetaSprites7FSet59 ; id 89
    dw MetaSprites7FSet5A ; id 90
    dw MetaSprites7FSet5B ; id 91
    dw MetaSprites7FSet5C ; id 92
    dw MetaSprites7FSet46 ; id 93
    dw MetaSprites7FSet46 ; id 94
    dw MetaSprites7FSet5F ; id 95
    dw MetaSprites7FSet46 ; id 96
    dw MetaSprites7FSet61 ; id 97

; the same instruction sequence as DrawMetaSpriteAt (bank $7F) apart from label operands, which
; refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; (E-0344: the address in its name dropped or read as the label there; was DrawMetaSpriteAt_2)
DrawMetaSpriteAt_2::
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
    call BGTileUnderPointIsSpriteHideTile_Bank7F_2
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
    call BGTileUnderPointIsSpriteHideTile_Bank7F_2
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
BGTileUnderPointIsSpriteHideTile_Bank7F_2::
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

; meta-sprite set 0 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet00::
    dw MetaSprites7FSet00Frame0 ; entry 0
    dw MetaSprites7FSet00Frame1 ; entry 1
    dw MetaSprites7FSet00Frame2 ; entry 2
    dw MetaSprites7FSet00Frame3 ; entry 3
    dw MetaSprites7FSet00Frame4 ; entry 4
    dw MetaSprites7FSet00Frame5 ; entry 5

; frame 0 of MetaSprites7FSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet00Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet00; ends with $80 (E-0147)
MetaSprites7FSet00Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet00; ends with $80 (E-0147)
MetaSprites7FSet00Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet00; ends with $80 (E-0147)
MetaSprites7FSet00Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet00Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet00; ends with $80 (E-0147)
MetaSprites7FSet00Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 1 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet01::
    dw MetaSprites7FSet01Frame0 ; entry 0
    dw MetaSprites7FSet01Frame1 ; entry 1
    dw MetaSprites7FSet01Frame2 ; entry 2
    dw MetaSprites7FSet01Frame3 ; entry 3
    dw MetaSprites7FSet01Frame4 ; entry 4
    dw MetaSprites7FSet01Frame5 ; entry 5

; frame 0 of MetaSprites7FSet01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet01Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet01; ends with $80 (E-0147)
MetaSprites7FSet01Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet01; ends with $80 (E-0147)
MetaSprites7FSet01Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet01; ends with $80 (E-0147)
MetaSprites7FSet01Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet01Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet01; ends with $80 (E-0147)
MetaSprites7FSet01Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0e, $00 ; entry 2
    db $f9, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet02::
    dw MetaSprites7FSet02Frame0 ; entry 0
    dw MetaSprites7FSet02Frame1 ; entry 1
    dw MetaSprites7FSet02Frame2 ; entry 2
    dw MetaSprites7FSet02Frame3 ; entry 3
    dw MetaSprites7FSet02Frame4 ; entry 4
    dw MetaSprites7FSet02Frame5 ; entry 5

; frame 0 of MetaSprites7FSet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet02; ends with $80 (E-0147)
MetaSprites7FSet02Frame1::
    db $f1, $00, $00, $20 ; entry 0
    db $f1, $f8, $01, $20 ; entry 1
    db $f9, $00, $02, $20 ; entry 2
    db $f9, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet02; ends with $80 (E-0147)
MetaSprites7FSet02Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet02; ends with $80 (E-0147)
MetaSprites7FSet02Frame3::
    db $f1, $f8, $08, $00 ; entry 0
    db $f1, $00, $09, $00 ; entry 1
    db $f9, $f8, $0a, $00 ; entry 2
    db $f9, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet02Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet02; ends with $80 (E-0147)
MetaSprites7FSet02Frame5::
    db $f1, $00, $0c, $20 ; entry 0
    db $f1, $f8, $0d, $20 ; entry 1
    db $f9, $00, $0e, $20 ; entry 2
    db $f9, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet03::
    dw MetaSprites7FSet03Frame0 ; entry 0
    dw MetaSprites7FSet03Frame1 ; entry 1
    dw MetaSprites7FSet03Frame2 ; entry 2
    dw MetaSprites7FSet03Frame3 ; entry 3
    dw MetaSprites7FSet03Frame4 ; entry 4
    dw MetaSprites7FSet03Frame5 ; entry 5

; frame 0 of MetaSprites7FSet03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet03Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet03; ends with $80 (E-0147)
MetaSprites7FSet03Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $ff, $02, $20 ; entry 2
    db $f9, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet03; ends with $80 (E-0147)
MetaSprites7FSet03Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet03; ends with $80 (E-0147)
MetaSprites7FSet03Frame3::
    db $f1, $f8, $04, $00 ; entry 0
    db $f1, $00, $05, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet03Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet03; ends with $80 (E-0147)
MetaSprites7FSet03Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $ff, $0c, $20 ; entry 2
    db $f9, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet04::
    dw MetaSprites7FSet04Frame0 ; entry 0
    dw MetaSprites7FSet04Frame1 ; entry 1
    dw MetaSprites7FSet04Frame2 ; entry 2
    dw MetaSprites7FSet04Frame3 ; entry 3
    dw MetaSprites7FSet04Frame4 ; entry 4
    dw MetaSprites7FSet04Frame5 ; entry 5

; frame 0 of MetaSprites7FSet04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet04; ends with $80 (E-0147)
MetaSprites7FSet04Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet04; ends with $80 (E-0147)
MetaSprites7FSet04Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet04; ends with $80 (E-0147)
MetaSprites7FSet04Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet04Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet04; ends with $80 (E-0147)
MetaSprites7FSet04Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet05::
    dw MetaSprites7FSet05Frame0 ; entry 0
    dw MetaSprites7FSet05Frame1 ; entry 1
    dw MetaSprites7FSet05Frame2 ; entry 2
    dw MetaSprites7FSet05Frame3 ; entry 3
    dw MetaSprites7FSet05Frame4 ; entry 4
    dw MetaSprites7FSet05Frame5 ; entry 5

; frame 0 of MetaSprites7FSet05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet05Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet05; ends with $80 (E-0147)
MetaSprites7FSet05Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet05; ends with $80 (E-0147)
MetaSprites7FSet05Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet05; ends with $80 (E-0147)
MetaSprites7FSet05Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet05Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet05; ends with $80 (E-0147)
MetaSprites7FSet05Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 6 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet06::
    dw MetaSprites7FSet06Frame0 ; entry 0
    dw MetaSprites7FSet06Frame1 ; entry 1
    dw MetaSprites7FSet06Frame2 ; entry 2
    dw MetaSprites7FSet06Frame3 ; entry 3
    dw MetaSprites7FSet06Frame4 ; entry 4
    dw MetaSprites7FSet06Frame5 ; entry 5

; frame 0 of MetaSprites7FSet06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet06Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet06; ends with $80 (E-0147)
MetaSprites7FSet06Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet06; ends with $80 (E-0147)
MetaSprites7FSet06Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet06; ends with $80 (E-0147)
MetaSprites7FSet06Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet06Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet06; ends with $80 (E-0147)
MetaSprites7FSet06Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 7 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet07::
    dw MetaSprites7FSet07Frame0 ; entry 0
    dw MetaSprites7FSet07Frame1 ; entry 1
    dw MetaSprites7FSet07Frame2 ; entry 2
    dw MetaSprites7FSet07Frame3 ; entry 3
    dw MetaSprites7FSet07Frame4 ; entry 4
    dw MetaSprites7FSet07Frame5 ; entry 5

; frame 0 of MetaSprites7FSet07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet07Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet07; ends with $80 (E-0147)
MetaSprites7FSet07Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet07; ends with $80 (E-0147)
MetaSprites7FSet07Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet07; ends with $80 (E-0147)
MetaSprites7FSet07Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet07Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet07; ends with $80 (E-0147)
MetaSprites7FSet07Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 8 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet08::
    dw MetaSprites7FSet08Frame0 ; entry 0
    dw MetaSprites7FSet08Frame1 ; entry 1
    dw MetaSprites7FSet08Frame2 ; entry 2
    dw MetaSprites7FSet08Frame3 ; entry 3
    dw MetaSprites7FSet08Frame4 ; entry 4
    dw MetaSprites7FSet08Frame5 ; entry 5

; frame 0 of MetaSprites7FSet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet08Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet08; ends with $80 (E-0147)
MetaSprites7FSet08Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet08; ends with $80 (E-0147)
MetaSprites7FSet08Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet08; ends with $80 (E-0147)
MetaSprites7FSet08Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet08Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet08; ends with $80 (E-0147)
MetaSprites7FSet08Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 9 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet09::
    dw MetaSprites7FSet09Frame0 ; entry 0
    dw MetaSprites7FSet09Frame1 ; entry 1
    dw MetaSprites7FSet09Frame2 ; entry 2
    dw MetaSprites7FSet09Frame3 ; entry 3
    dw MetaSprites7FSet09Frame4 ; entry 4
    dw MetaSprites7FSet09Frame5 ; entry 5

; frame 0 of MetaSprites7FSet09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet09Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet09; ends with $80 (E-0147)
MetaSprites7FSet09Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet09; ends with $80 (E-0147)
MetaSprites7FSet09Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet09; ends with $80 (E-0147)
MetaSprites7FSet09Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet09Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet09; ends with $80 (E-0147)
MetaSprites7FSet09Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 10 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet0A::
    dw MetaSprites7FSet0AFrame0 ; entry 0
    dw MetaSprites7FSet0AFrame1 ; entry 1
    dw MetaSprites7FSet0AFrame2 ; entry 2
    dw MetaSprites7FSet0AFrame3 ; entry 3
    dw MetaSprites7FSet0AFrame4 ; entry 4
    dw MetaSprites7FSet0AFrame5 ; entry 5

; frame 0 of MetaSprites7FSet0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet0A; ends with $80 (E-0147)
MetaSprites7FSet0AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet0A; ends with $80 (E-0147)
MetaSprites7FSet0AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet0A; ends with $80 (E-0147)
MetaSprites7FSet0AFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet0A; ends with $80 (E-0147)
MetaSprites7FSet0AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 11 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet0B::
    dw MetaSprites7FSet0BFrame0 ; entry 0
    dw MetaSprites7FSet0BFrame1 ; entry 1
    dw MetaSprites7FSet0BFrame2 ; entry 2
    dw MetaSprites7FSet0BFrame3 ; entry 3
    dw MetaSprites7FSet0BFrame4 ; entry 4
    dw MetaSprites7FSet0BFrame5 ; entry 5

; frame 0 of MetaSprites7FSet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet0B; ends with $80 (E-0147)
MetaSprites7FSet0BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet0B; ends with $80 (E-0147)
MetaSprites7FSet0BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet0B; ends with $80 (E-0147)
MetaSprites7FSet0BFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet0B; ends with $80 (E-0147)
MetaSprites7FSet0BFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 12 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet0C::
    dw MetaSprites7FSet0CFrame0 ; entry 0
    dw MetaSprites7FSet0CFrame1 ; entry 1
    dw MetaSprites7FSet0CFrame2 ; entry 2
    dw MetaSprites7FSet0CFrame3 ; entry 3
    dw MetaSprites7FSet0CFrame4 ; entry 4
    dw MetaSprites7FSet0CFrame5 ; entry 5

; frame 0 of MetaSprites7FSet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet0C; ends with $80 (E-0147)
MetaSprites7FSet0CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet0C; ends with $80 (E-0147)
MetaSprites7FSet0CFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet0C; ends with $80 (E-0147)
MetaSprites7FSet0CFrame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet0C; ends with $80 (E-0147)
MetaSprites7FSet0CFrame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 13 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet0D::
    dw MetaSprites7FSet0DFrame0 ; entry 0
    dw MetaSprites7FSet0DFrame1 ; entry 1
    dw MetaSprites7FSet0DFrame2 ; entry 2
    dw MetaSprites7FSet0DFrame3 ; entry 3
    dw MetaSprites7FSet0DFrame4 ; entry 4
    dw MetaSprites7FSet0DFrame5 ; entry 5

; frame 0 of MetaSprites7FSet0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet0D; ends with $80 (E-0147)
MetaSprites7FSet0DFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet0D; ends with $80 (E-0147)
MetaSprites7FSet0DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet0D; ends with $80 (E-0147)
MetaSprites7FSet0DFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet0D; ends with $80 (E-0147)
MetaSprites7FSet0DFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 14 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet0E::
    dw MetaSprites7FSet0EFrame0 ; entry 0
    dw MetaSprites7FSet0EFrame1 ; entry 1
    dw MetaSprites7FSet0EFrame2 ; entry 2
    dw MetaSprites7FSet0EFrame3 ; entry 3
    dw MetaSprites7FSet0EFrame4 ; entry 4
    dw MetaSprites7FSet0EFrame5 ; entry 5

; frame 0 of MetaSprites7FSet0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet0E; ends with $80 (E-0147)
MetaSprites7FSet0EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet0E; ends with $80 (E-0147)
MetaSprites7FSet0EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet0E; ends with $80 (E-0147)
MetaSprites7FSet0EFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0EFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet0E; ends with $80 (E-0147)
MetaSprites7FSet0EFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet0F::
    dw MetaSprites7FSet0FFrame0 ; entry 0
    dw MetaSprites7FSet0FFrame1 ; entry 1
    dw MetaSprites7FSet0FFrame2 ; entry 2
    dw MetaSprites7FSet0FFrame3 ; entry 3
    dw MetaSprites7FSet0FFrame4 ; entry 4
    dw MetaSprites7FSet0FFrame5 ; entry 5

; frame 0 of MetaSprites7FSet0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet0F; ends with $80 (E-0147)
MetaSprites7FSet0FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet0F; ends with $80 (E-0147)
MetaSprites7FSet0FFrame2::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $06, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet0F; ends with $80 (E-0147)
MetaSprites7FSet0FFrame3::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $06, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet0FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0d, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet0F; ends with $80 (E-0147)
MetaSprites7FSet0FFrame5::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0e, $20 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0c, $20 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet10::
    dw MetaSprites7FSet10Frame0 ; entry 0
    dw MetaSprites7FSet10Frame1 ; entry 1
    dw MetaSprites7FSet10Frame2 ; entry 2
    dw MetaSprites7FSet10Frame3 ; entry 3
    dw MetaSprites7FSet10Frame4 ; entry 4
    dw MetaSprites7FSet10Frame5 ; entry 5

; frame 0 of MetaSprites7FSet10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet10Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet10; ends with $80 (E-0147)
MetaSprites7FSet10Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet10; ends with $80 (E-0147)
MetaSprites7FSet10Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet10; ends with $80 (E-0147)
MetaSprites7FSet10Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet10Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet10; ends with $80 (E-0147)
MetaSprites7FSet10Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet11::
    dw MetaSprites7FSet11Frame0 ; entry 0
    dw MetaSprites7FSet11Frame1 ; entry 1
    dw MetaSprites7FSet11Frame2 ; entry 2
    dw MetaSprites7FSet11Frame3 ; entry 3
    dw MetaSprites7FSet11Frame4 ; entry 4
    dw MetaSprites7FSet11Frame5 ; entry 5

; frame 0 of MetaSprites7FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet11Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet11; ends with $80 (E-0147)
MetaSprites7FSet11Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet11; ends with $80 (E-0147)
MetaSprites7FSet11Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet11; ends with $80 (E-0147)
MetaSprites7FSet11Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet11Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet11; ends with $80 (E-0147)
MetaSprites7FSet11Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 18 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet12::
    dw MetaSprites7FSet12Frame0 ; entry 0
    dw MetaSprites7FSet12Frame1 ; entry 1
    dw MetaSprites7FSet12Frame2 ; entry 2
    dw MetaSprites7FSet12Frame3 ; entry 3
    dw MetaSprites7FSet12Frame4 ; entry 4
    dw MetaSprites7FSet12Frame5 ; entry 5

; frame 0 of MetaSprites7FSet12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet12Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet12; ends with $80 (E-0147)
MetaSprites7FSet12Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet12; ends with $80 (E-0147)
MetaSprites7FSet12Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet12; ends with $80 (E-0147)
MetaSprites7FSet12Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet12Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet12; ends with $80 (E-0147)
MetaSprites7FSet12Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 19 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet13::
    dw MetaSprites7FSet13Frame0 ; entry 0
    dw MetaSprites7FSet13Frame1 ; entry 1
    dw MetaSprites7FSet13Frame2 ; entry 2
    dw MetaSprites7FSet13Frame3 ; entry 3
    dw MetaSprites7FSet13Frame4 ; entry 4
    dw MetaSprites7FSet13Frame5 ; entry 5

; frame 0 of MetaSprites7FSet13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet13Frame0::
    db $f0, $fa, $00, $00 ; entry 0
    db $f0, $02, $01, $00 ; entry 1
    db $f8, $fa, $02, $00 ; entry 2
    db $f8, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet13; ends with $80 (E-0147)
MetaSprites7FSet13Frame1::
    db $f0, $fa, $00, $00 ; entry 0
    db $f0, $02, $01, $00 ; entry 1
    db $f8, $02, $03, $00 ; entry 2
    db $f8, $fa, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet13; ends with $80 (E-0147)
MetaSprites7FSet13Frame2::
    db $f0, $f6, $05, $00 ; entry 0
    db $f0, $fe, $06, $00 ; entry 1
    db $f8, $f6, $07, $00 ; entry 2
    db $f8, $fe, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet13; ends with $80 (E-0147)
MetaSprites7FSet13Frame3::
    db $f0, $f6, $05, $00 ; entry 0
    db $f0, $fe, $06, $00 ; entry 1
    db $f8, $f6, $07, $00 ; entry 2
    db $f8, $fe, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet13Frame4::
    db $f0, $f6, $0a, $00 ; entry 0
    db $f0, $fe, $0b, $00 ; entry 1
    db $f8, $f6, $0c, $00 ; entry 2
    db $f8, $fe, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet13; ends with $80 (E-0147)
MetaSprites7FSet13Frame5::
    db $f0, $f6, $0a, $00 ; entry 0
    db $f0, $fe, $0b, $00 ; entry 1
    db $f8, $f6, $0c, $00 ; entry 2
    db $f8, $fe, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 20 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet14::
    dw MetaSprites7FSet14Frame0 ; entry 0
    dw MetaSprites7FSet14Frame1 ; entry 1
    dw MetaSprites7FSet14Frame2 ; entry 2
    dw MetaSprites7FSet14Frame3 ; entry 3
    dw MetaSprites7FSet14Frame4 ; entry 4
    dw MetaSprites7FSet14Frame5 ; entry 5

; frame 0 of MetaSprites7FSet14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet14Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet14; ends with $80 (E-0147)
MetaSprites7FSet14Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet14; ends with $80 (E-0147)
MetaSprites7FSet14Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet14; ends with $80 (E-0147)
MetaSprites7FSet14Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet14Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet14; ends with $80 (E-0147)
MetaSprites7FSet14Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 21 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet15::
    dw MetaSprites7FSet15Frame0 ; entry 0
    dw MetaSprites7FSet15Frame1 ; entry 1
    dw MetaSprites7FSet15Frame2 ; entry 2
    dw MetaSprites7FSet15Frame3 ; entry 3
    dw MetaSprites7FSet15Frame4 ; entry 4
    dw MetaSprites7FSet15Frame5 ; entry 5

; frame 0 of MetaSprites7FSet15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet15Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet15; ends with $80 (E-0147)
MetaSprites7FSet15Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet15; ends with $80 (E-0147)
MetaSprites7FSet15Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet15; ends with $80 (E-0147)
MetaSprites7FSet15Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet15Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet15; ends with $80 (E-0147)
MetaSprites7FSet15Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 22 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet16::
    dw MetaSprites7FSet16Frame0 ; entry 0
    dw MetaSprites7FSet16Frame1 ; entry 1
    dw MetaSprites7FSet16Frame2 ; entry 2
    dw MetaSprites7FSet16Frame3 ; entry 3
    dw MetaSprites7FSet16Frame4 ; entry 4
    dw MetaSprites7FSet16Frame5 ; entry 5

; frame 0 of MetaSprites7FSet16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet16Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet16; ends with $80 (E-0147)
MetaSprites7FSet16Frame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet16; ends with $80 (E-0147)
MetaSprites7FSet16Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet16; ends with $80 (E-0147)
MetaSprites7FSet16Frame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet16Frame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet16; ends with $80 (E-0147)
MetaSprites7FSet16Frame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 23 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet17::
    dw MetaSprites7FSet17Frame0 ; entry 0
    dw MetaSprites7FSet17Frame1 ; entry 1
    dw MetaSprites7FSet17Frame2 ; entry 2
    dw MetaSprites7FSet17Frame3 ; entry 3
    dw MetaSprites7FSet17Frame4 ; entry 4
    dw MetaSprites7FSet17Frame5 ; entry 5

; frame 0 of MetaSprites7FSet17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet17Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet17; ends with $80 (E-0147)
MetaSprites7FSet17Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet17; ends with $80 (E-0147)
MetaSprites7FSet17Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet17; ends with $80 (E-0147)
MetaSprites7FSet17Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet17Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet17; ends with $80 (E-0147)
MetaSprites7FSet17Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 24 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet18::
    dw MetaSprites7FSet18Frame0 ; entry 0
    dw MetaSprites7FSet18Frame1 ; entry 1
    dw MetaSprites7FSet18Frame2 ; entry 2
    dw MetaSprites7FSet18Frame3 ; entry 3
    dw MetaSprites7FSet18Frame4 ; entry 4
    dw MetaSprites7FSet18Frame5 ; entry 5

; frame 0 of MetaSprites7FSet18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet18Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet18; ends with $80 (E-0147)
MetaSprites7FSet18Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet18; ends with $80 (E-0147)
MetaSprites7FSet18Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet18; ends with $80 (E-0147)
MetaSprites7FSet18Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet18Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet18; ends with $80 (E-0147)
MetaSprites7FSet18Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 25 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet19::
    dw MetaSprites7FSet19Frame0 ; entry 0
    dw MetaSprites7FSet19Frame1 ; entry 1
    dw MetaSprites7FSet19Frame2 ; entry 2
    dw MetaSprites7FSet19Frame3 ; entry 3
    dw MetaSprites7FSet19Frame4 ; entry 4
    dw MetaSprites7FSet19Frame5 ; entry 5

; frame 0 of MetaSprites7FSet19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet19Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet19; ends with $80 (E-0147)
MetaSprites7FSet19Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet19; ends with $80 (E-0147)
MetaSprites7FSet19Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet19; ends with $80 (E-0147)
MetaSprites7FSet19Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet19Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet19; ends with $80 (E-0147)
MetaSprites7FSet19Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet1A::
    dw MetaSprites7FSet1AFrame0 ; entry 0
    dw MetaSprites7FSet1AFrame1 ; entry 1
    dw MetaSprites7FSet1AFrame2 ; entry 2
    dw MetaSprites7FSet1AFrame3 ; entry 3
    dw MetaSprites7FSet1AFrame4 ; entry 4
    dw MetaSprites7FSet1AFrame5 ; entry 5

; frame 0 of MetaSprites7FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet1A; ends with $80 (E-0147)
MetaSprites7FSet1AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet1A; ends with $80 (E-0147)
MetaSprites7FSet1AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet1A; ends with $80 (E-0147)
MetaSprites7FSet1AFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet1A; ends with $80 (E-0147)
MetaSprites7FSet1AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet1B::
    dw MetaSprites7FSet1BFrame0 ; entry 0
    dw MetaSprites7FSet1BFrame1 ; entry 1
    dw MetaSprites7FSet1BFrame2 ; entry 2
    dw MetaSprites7FSet1BFrame3 ; entry 3
    dw MetaSprites7FSet1BFrame4 ; entry 4
    dw MetaSprites7FSet1BFrame5 ; entry 5

; frame 0 of MetaSprites7FSet1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet1B; ends with $80 (E-0147)
MetaSprites7FSet1BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet1B; ends with $80 (E-0147)
MetaSprites7FSet1BFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet1B; ends with $80 (E-0147)
MetaSprites7FSet1BFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet1B; ends with $80 (E-0147)
MetaSprites7FSet1BFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 28 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet1C::
    dw MetaSprites7FSet1CFrame0 ; entry 0
    dw MetaSprites7FSet1CFrame1 ; entry 1
    dw MetaSprites7FSet1CFrame2 ; entry 2
    dw MetaSprites7FSet1CFrame3 ; entry 3
    dw MetaSprites7FSet1CFrame4 ; entry 4
    dw MetaSprites7FSet1CFrame5 ; entry 5

; frame 0 of MetaSprites7FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet1C; ends with $80 (E-0147)
MetaSprites7FSet1CFrame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet1C; ends with $80 (E-0147)
MetaSprites7FSet1CFrame2::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet1C; ends with $80 (E-0147)
MetaSprites7FSet1CFrame3::
    db $f8, $f9, $0a, $00 ; entry 0
    db $f8, $01, $0b, $00 ; entry 1
    db $f0, $f9, $08, $00 ; entry 2
    db $f0, $01, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1CFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet1C; ends with $80 (E-0147)
MetaSprites7FSet1CFrame5::
    db $f0, $ff, $0c, $20 ; entry 0
    db $f0, $f7, $0d, $20 ; entry 1
    db $f8, $ff, $0e, $20 ; entry 2
    db $f8, $f7, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 29 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet1D::
    dw MetaSprites7FSet1DFrame0 ; entry 0
    dw MetaSprites7FSet1DFrame1 ; entry 1
    dw MetaSprites7FSet1DFrame2 ; entry 2
    dw MetaSprites7FSet1DFrame3 ; entry 3
    dw MetaSprites7FSet1DFrame4 ; entry 4
    dw MetaSprites7FSet1DFrame5 ; entry 5

; frame 0 of MetaSprites7FSet1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet1D; ends with $80 (E-0147)
MetaSprites7FSet1DFrame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet1D; ends with $80 (E-0147)
MetaSprites7FSet1DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet1D; ends with $80 (E-0147)
MetaSprites7FSet1DFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet1D; ends with $80 (E-0147)
MetaSprites7FSet1DFrame5::
    db $f0, $00, $0a, $20 ; entry 0
    db $f0, $f8, $0b, $20 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 30 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet1E::
    dw MetaSprites7FSet1EFrame0 ; entry 0
    dw MetaSprites7FSet1EFrame1 ; entry 1
    dw MetaSprites7FSet1EFrame2 ; entry 2
    dw MetaSprites7FSet1EFrame3 ; entry 3
    dw MetaSprites7FSet1EFrame4 ; entry 4
    dw MetaSprites7FSet1EFrame5 ; entry 5

; frame 0 of MetaSprites7FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet1E; ends with $80 (E-0147)
MetaSprites7FSet1EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet1E; ends with $80 (E-0147)
MetaSprites7FSet1EFrame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f8, $f8, $08, $00 ; entry 1
    db $f8, $00, $09, $00 ; entry 2
    db $f0, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet1E; ends with $80 (E-0147)
MetaSprites7FSet1EFrame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $0a, $00 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1EFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet1E; ends with $80 (E-0147)
MetaSprites7FSet1EFrame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0e, $00 ; entry 1
    db $f8, $00, $0f, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 31 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet1F::
    dw MetaSprites7FSet1FFrame0 ; entry 0
    dw MetaSprites7FSet1FFrame1 ; entry 1
    dw MetaSprites7FSet1FFrame2 ; entry 2
    dw MetaSprites7FSet1FFrame3 ; entry 3
    dw MetaSprites7FSet1FFrame4 ; entry 4
    dw MetaSprites7FSet1FFrame5 ; entry 5

; frame 0 of MetaSprites7FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet1F; ends with $80 (E-0147)
MetaSprites7FSet1FFrame1::
    db $f0, $f7, $00, $00 ; entry 0
    db $f0, $ff, $01, $00 ; entry 1
    db $f8, $fe, $02, $20 ; entry 2
    db $f8, $f6, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet1F; ends with $80 (E-0147)
MetaSprites7FSet1FFrame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f8, $f7, $06, $00 ; entry 1
    db $f8, $ff, $07, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet1F; ends with $80 (E-0147)
MetaSprites7FSet1FFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet1FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet1F; ends with $80 (E-0147)
MetaSprites7FSet1FFrame5::
    db $f0, $f9, $0a, $00 ; entry 0
    db $f8, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $20 ; entry 2
    db $f0, $01, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 32 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet20::
    dw MetaSprites7FSet20Frame0 ; entry 0
    dw MetaSprites7FSet20Frame1 ; entry 1
    dw MetaSprites7FSet20Frame2 ; entry 2
    dw MetaSprites7FSet20Frame3 ; entry 3
    dw MetaSprites7FSet20Frame4 ; entry 4
    dw MetaSprites7FSet20Frame5 ; entry 5

; frame 0 of MetaSprites7FSet20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet20Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet20; ends with $80 (E-0147)
MetaSprites7FSet20Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet20; ends with $80 (E-0147)
MetaSprites7FSet20Frame2::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet20; ends with $80 (E-0147)
MetaSprites7FSet20Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet20Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $ff, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet20; ends with $80 (E-0147)
MetaSprites7FSet20Frame5::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $ff, $0b, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 33 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet21::
    dw MetaSprites7FSet21Frame0 ; entry 0
    dw MetaSprites7FSet21Frame1 ; entry 1
    dw MetaSprites7FSet21Frame2 ; entry 2
    dw MetaSprites7FSet21Frame3 ; entry 3
    dw MetaSprites7FSet21Frame4 ; entry 4
    dw MetaSprites7FSet21Frame5 ; entry 5

; frame 0 of MetaSprites7FSet21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet21Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet21; ends with $80 (E-0147)
MetaSprites7FSet21Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet21; ends with $80 (E-0147)
MetaSprites7FSet21Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet21; ends with $80 (E-0147)
MetaSprites7FSet21Frame3::
    db $f8, $f7, $08, $00 ; entry 0
    db $f8, $ff, $09, $00 ; entry 1
    db $f0, $f7, $04, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet21Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet21; ends with $80 (E-0147)
MetaSprites7FSet21Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 34 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet22::
    dw MetaSprites7FSet22Frame0 ; entry 0
    dw MetaSprites7FSet22Frame1 ; entry 1
    dw MetaSprites7FSet22Frame2 ; entry 2
    dw MetaSprites7FSet22Frame3 ; entry 3
    dw MetaSprites7FSet22Frame4 ; entry 4
    dw MetaSprites7FSet22Frame5 ; entry 5

; frame 0 of MetaSprites7FSet22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet22Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet22; ends with $80 (E-0147)
MetaSprites7FSet22Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet22; ends with $80 (E-0147)
MetaSprites7FSet22Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet22; ends with $80 (E-0147)
MetaSprites7FSet22Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet22Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet22; ends with $80 (E-0147)
MetaSprites7FSet22Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 35 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet23::
    dw MetaSprites7FSet23Frame0 ; entry 0
    dw MetaSprites7FSet23Frame1 ; entry 1
    dw MetaSprites7FSet23Frame2 ; entry 2
    dw MetaSprites7FSet23Frame3 ; entry 3
    dw MetaSprites7FSet23Frame4 ; entry 4
    dw MetaSprites7FSet23Frame5 ; entry 5

; frame 0 of MetaSprites7FSet23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet23Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet23; ends with $80 (E-0147)
MetaSprites7FSet23Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet23; ends with $80 (E-0147)
MetaSprites7FSet23Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet23; ends with $80 (E-0147)
MetaSprites7FSet23Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet23Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet23; ends with $80 (E-0147)
MetaSprites7FSet23Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 36 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet24::
    dw MetaSprites7FSet24Frame0 ; entry 0
    dw MetaSprites7FSet24Frame1 ; entry 1
    dw MetaSprites7FSet24Frame2 ; entry 2
    dw MetaSprites7FSet24Frame3 ; entry 3
    dw MetaSprites7FSet24Frame4 ; entry 4
    dw MetaSprites7FSet24Frame5 ; entry 5

; frame 0 of MetaSprites7FSet24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet24Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet24; ends with $80 (E-0147)
MetaSprites7FSet24Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet24; ends with $80 (E-0147)
MetaSprites7FSet24Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet24; ends with $80 (E-0147)
MetaSprites7FSet24Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet24Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet24; ends with $80 (E-0147)
MetaSprites7FSet24Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet25::
    dw MetaSprites7FSet25Frame0 ; entry 0
    dw MetaSprites7FSet25Frame1 ; entry 1
    dw MetaSprites7FSet25Frame2 ; entry 2
    dw MetaSprites7FSet25Frame3 ; entry 3
    dw MetaSprites7FSet25Frame4 ; entry 4
    dw MetaSprites7FSet25Frame5 ; entry 5

; frame 0 of MetaSprites7FSet25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet25Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet25; ends with $80 (E-0147)
MetaSprites7FSet25Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet25; ends with $80 (E-0147)
MetaSprites7FSet25Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet25; ends with $80 (E-0147)
MetaSprites7FSet25Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet25Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet25; ends with $80 (E-0147)
MetaSprites7FSet25Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 38 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet26::
    dw MetaSprites7FSet26Frame0 ; entry 0
    dw MetaSprites7FSet26Frame1 ; entry 1
    dw MetaSprites7FSet26Frame2 ; entry 2
    dw MetaSprites7FSet26Frame3 ; entry 3
    dw MetaSprites7FSet26Frame4 ; entry 4
    dw MetaSprites7FSet26Frame5 ; entry 5

; frame 0 of MetaSprites7FSet26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet26Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet26; ends with $80 (E-0147)
MetaSprites7FSet26Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet26; ends with $80 (E-0147)
MetaSprites7FSet26Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet26; ends with $80 (E-0147)
MetaSprites7FSet26Frame3::
    db $f8, $f7, $08, $00 ; entry 0
    db $f8, $ff, $09, $00 ; entry 1
    db $f0, $f7, $04, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet26Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet26; ends with $80 (E-0147)
MetaSprites7FSet26Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 39 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet27::
    dw MetaSprites7FSet27Frame0 ; entry 0
    dw MetaSprites7FSet27Frame1 ; entry 1
    dw MetaSprites7FSet27Frame2 ; entry 2
    dw MetaSprites7FSet27Frame3 ; entry 3
    dw MetaSprites7FSet27Frame4 ; entry 4
    dw MetaSprites7FSet27Frame5 ; entry 5

; frame 0 of MetaSprites7FSet27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet27Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet27; ends with $80 (E-0147)
MetaSprites7FSet27Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet27; ends with $80 (E-0147)
MetaSprites7FSet27Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet27; ends with $80 (E-0147)
MetaSprites7FSet27Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet27Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet27; ends with $80 (E-0147)
MetaSprites7FSet27Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 40 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet28::
    dw MetaSprites7FSet28Frame0 ; entry 0
    dw MetaSprites7FSet28Frame1 ; entry 1
    dw MetaSprites7FSet28Frame2 ; entry 2
    dw MetaSprites7FSet28Frame3 ; entry 3
    dw MetaSprites7FSet28Frame4 ; entry 4
    dw MetaSprites7FSet28Frame5 ; entry 5

; frame 0 of MetaSprites7FSet28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet28Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet28; ends with $80 (E-0147)
MetaSprites7FSet28Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet28; ends with $80 (E-0147)
MetaSprites7FSet28Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet28; ends with $80 (E-0147)
MetaSprites7FSet28Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet28Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet28; ends with $80 (E-0147)
MetaSprites7FSet28Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 41 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet29::
    dw MetaSprites7FSet29Frame0 ; entry 0
    dw MetaSprites7FSet29Frame1 ; entry 1
    dw MetaSprites7FSet29Frame2 ; entry 2
    dw MetaSprites7FSet29Frame3 ; entry 3
    dw MetaSprites7FSet29Frame4 ; entry 4
    dw MetaSprites7FSet29Frame5 ; entry 5

; frame 0 of MetaSprites7FSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet29Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet29; ends with $80 (E-0147)
MetaSprites7FSet29Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet29; ends with $80 (E-0147)
MetaSprites7FSet29Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet29; ends with $80 (E-0147)
MetaSprites7FSet29Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet29Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet29; ends with $80 (E-0147)
MetaSprites7FSet29Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 42 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet2A::
    dw MetaSprites7FSet2AFrame0 ; entry 0
    dw MetaSprites7FSet2AFrame1 ; entry 1
    dw MetaSprites7FSet2AFrame2 ; entry 2
    dw MetaSprites7FSet2AFrame3 ; entry 3
    dw MetaSprites7FSet2AFrame4 ; entry 4
    dw MetaSprites7FSet2AFrame5 ; entry 5

; frame 0 of MetaSprites7FSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet2A; ends with $80 (E-0147)
MetaSprites7FSet2AFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet2A; ends with $80 (E-0147)
MetaSprites7FSet2AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet2A; ends with $80 (E-0147)
MetaSprites7FSet2AFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet2A; ends with $80 (E-0147)
MetaSprites7FSet2AFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 43 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet2B::
    dw MetaSprites7FSet2BFrame0 ; entry 0
    dw MetaSprites7FSet2BFrame1 ; entry 1
    dw MetaSprites7FSet2BFrame2 ; entry 2
    dw MetaSprites7FSet2BFrame3 ; entry 3
    dw MetaSprites7FSet2BFrame4 ; entry 4
    dw MetaSprites7FSet2BFrame5 ; entry 5

; frame 0 of MetaSprites7FSet2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet2B; ends with $80 (E-0147)
MetaSprites7FSet2BFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet2B; ends with $80 (E-0147)
MetaSprites7FSet2BFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet2B; ends with $80 (E-0147)
MetaSprites7FSet2BFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2BFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet2B; ends with $80 (E-0147)
MetaSprites7FSet2BFrame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $00, $0e, $00 ; entry 2
    db $f9, $f8, $0c, $00 ; entry 3
    db $80 ; end

; meta-sprite set 44 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet2C::
    dw MetaSprites7FSet2CFrame0 ; entry 0
    dw MetaSprites7FSet2CFrame1 ; entry 1
    dw MetaSprites7FSet2CFrame2 ; entry 2
    dw MetaSprites7FSet2CFrame3 ; entry 3
    dw MetaSprites7FSet2CFrame4 ; entry 4
    dw MetaSprites7FSet2CFrame5 ; entry 5

; frame 0 of MetaSprites7FSet2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet2C; ends with $80 (E-0147)
MetaSprites7FSet2CFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet2C; ends with $80 (E-0147)
MetaSprites7FSet2CFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet2C; ends with $80 (E-0147)
MetaSprites7FSet2CFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $fd, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet2C; ends with $80 (E-0147)
MetaSprites7FSet2CFrame5::
    db $f9, $f8, $0e, $00 ; entry 0
    db $f9, $00, $0f, $00 ; entry 1
    db $f1, $f8, $0d, $00 ; entry 2
    db $f1, $fd, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 45 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet2D::
    dw MetaSprites7FSet2DFrame0 ; entry 0
    dw MetaSprites7FSet2DFrame1 ; entry 1
    dw MetaSprites7FSet2DFrame2 ; entry 2
    dw MetaSprites7FSet2DFrame3 ; entry 3
    dw MetaSprites7FSet2DFrame4 ; entry 4
    dw MetaSprites7FSet2DFrame5 ; entry 5

; frame 0 of MetaSprites7FSet2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet2D; ends with $80 (E-0147)
MetaSprites7FSet2DFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet2D; ends with $80 (E-0147)
MetaSprites7FSet2DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet2D; ends with $80 (E-0147)
MetaSprites7FSet2DFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet2D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet2D; ends with $80 (E-0147)
MetaSprites7FSet2DFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 46 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet2E::
    dw MetaSprites7FSet2EFrame0 ; entry 0
    dw MetaSprites7FSet2EFrame1 ; entry 1
    dw MetaSprites7FSet2EFrame2 ; entry 2
    dw MetaSprites7FSet2EFrame3 ; entry 3
    dw MetaSprites7FSet2EFrame4 ; entry 4
    dw MetaSprites7FSet2EFrame5 ; entry 5

; frame 0 of MetaSprites7FSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet2E; ends with $80 (E-0147)
MetaSprites7FSet2EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet2E; ends with $80 (E-0147)
MetaSprites7FSet2EFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet2E; ends with $80 (E-0147)
MetaSprites7FSet2EFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet2E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2EFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet2E; ends with $80 (E-0147)
MetaSprites7FSet2EFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 47 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet2F::
    dw MetaSprites7FSet2FFrame0 ; entry 0
    dw MetaSprites7FSet2FFrame1 ; entry 1
    dw MetaSprites7FSet2FFrame2 ; entry 2
    dw MetaSprites7FSet2FFrame3 ; entry 3
    dw MetaSprites7FSet2FFrame4 ; entry 4
    dw MetaSprites7FSet2FFrame5 ; entry 5

; frame 0 of MetaSprites7FSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet2F; ends with $80 (E-0147)
MetaSprites7FSet2FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet2F; ends with $80 (E-0147)
MetaSprites7FSet2FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet2F; ends with $80 (E-0147)
MetaSprites7FSet2FFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet2F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet2FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet2F; ends with $80 (E-0147)
MetaSprites7FSet2FFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 48 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet30::
    dw MetaSprites7FSet30Frame0 ; entry 0
    dw MetaSprites7FSet30Frame1 ; entry 1
    dw MetaSprites7FSet30Frame2 ; entry 2
    dw MetaSprites7FSet30Frame3 ; entry 3
    dw MetaSprites7FSet30Frame4 ; entry 4
    dw MetaSprites7FSet30Frame5 ; entry 5

; frame 0 of MetaSprites7FSet30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet30Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet30; ends with $80 (E-0147)
MetaSprites7FSet30Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f6, $00, $00 ; entry 2
    db $f0, $fe, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet30; ends with $80 (E-0147)
MetaSprites7FSet30Frame2::
    db $f0, $f6, $04, $00 ; entry 0
    db $f0, $fe, $05, $00 ; entry 1
    db $f8, $f6, $06, $00 ; entry 2
    db $f8, $fe, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet30; ends with $80 (E-0147)
MetaSprites7FSet30Frame3::
    db $f8, $f7, $08, $00 ; entry 0
    db $f8, $ff, $09, $00 ; entry 1
    db $f0, $f7, $04, $00 ; entry 2
    db $f0, $ff, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet30; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet30Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet30; ends with $80 (E-0147)
MetaSprites7FSet30Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f6, $0a, $00 ; entry 2
    db $f0, $fe, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 49 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet31::
    dw MetaSprites7FSet31Frame0 ; entry 0
    dw MetaSprites7FSet31Frame1 ; entry 1
    dw MetaSprites7FSet31Frame2 ; entry 2
    dw MetaSprites7FSet31Frame3 ; entry 3
    dw MetaSprites7FSet31Frame4 ; entry 4
    dw MetaSprites7FSet31Frame5 ; entry 5

; frame 0 of MetaSprites7FSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet31Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet31; ends with $80 (E-0147)
MetaSprites7FSet31Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet31; ends with $80 (E-0147)
MetaSprites7FSet31Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet31; ends with $80 (E-0147)
MetaSprites7FSet31Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet31; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet31Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet31; ends with $80 (E-0147)
MetaSprites7FSet31Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 50 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet32::
    dw MetaSprites7FSet32Frame0 ; entry 0
    dw MetaSprites7FSet32Frame1 ; entry 1
    dw MetaSprites7FSet32Frame2 ; entry 2
    dw MetaSprites7FSet32Frame3 ; entry 3
    dw MetaSprites7FSet32Frame4 ; entry 4
    dw MetaSprites7FSet32Frame5 ; entry 5

; frame 0 of MetaSprites7FSet32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet32Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet32; ends with $80 (E-0147)
MetaSprites7FSet32Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet32; ends with $80 (E-0147)
MetaSprites7FSet32Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet32; ends with $80 (E-0147)
MetaSprites7FSet32Frame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet32; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet32Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet32; ends with $80 (E-0147)
MetaSprites7FSet32Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 51 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet33::
    dw MetaSprites7FSet33Frame0 ; entry 0
    dw MetaSprites7FSet33Frame1 ; entry 1
    dw MetaSprites7FSet33Frame2 ; entry 2
    dw MetaSprites7FSet33Frame3 ; entry 3
    dw MetaSprites7FSet33Frame4 ; entry 4
    dw MetaSprites7FSet33Frame5 ; entry 5

; frame 0 of MetaSprites7FSet33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet33Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet33; ends with $80 (E-0147)
MetaSprites7FSet33Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet33; ends with $80 (E-0147)
MetaSprites7FSet33Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet33; ends with $80 (E-0147)
MetaSprites7FSet33Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet33; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet33Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet33; ends with $80 (E-0147)
MetaSprites7FSet33Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 52 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet34::
    dw MetaSprites7FSet34Frame0 ; entry 0
    dw MetaSprites7FSet34Frame1 ; entry 1
    dw MetaSprites7FSet34Frame2 ; entry 2
    dw MetaSprites7FSet34Frame3 ; entry 3
    dw MetaSprites7FSet34Frame4 ; entry 4
    dw MetaSprites7FSet34Frame5 ; entry 5

; frame 0 of MetaSprites7FSet34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet34Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet34; ends with $80 (E-0147)
MetaSprites7FSet34Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet34; ends with $80 (E-0147)
MetaSprites7FSet34Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet34; ends with $80 (E-0147)
MetaSprites7FSet34Frame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet34Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet34; ends with $80 (E-0147)
MetaSprites7FSet34Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 53 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet35::
    dw MetaSprites7FSet35Frame0 ; entry 0
    dw MetaSprites7FSet35Frame1 ; entry 1
    dw MetaSprites7FSet35Frame2 ; entry 2
    dw MetaSprites7FSet35Frame3 ; entry 3
    dw MetaSprites7FSet35Frame4 ; entry 4
    dw MetaSprites7FSet35Frame5 ; entry 5

; frame 0 of MetaSprites7FSet35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet35Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet35; ends with $80 (E-0147)
MetaSprites7FSet35Frame1::
    db $f8, $fe, $02, $20 ; entry 0
    db $f8, $f6, $03, $20 ; entry 1
    db $f0, $f7, $00, $00 ; entry 2
    db $f0, $ff, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet35; ends with $80 (E-0147)
MetaSprites7FSet35Frame2::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet35; ends with $80 (E-0147)
MetaSprites7FSet35Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet35Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet35; ends with $80 (E-0147)
MetaSprites7FSet35Frame5::
    db $f8, $00, $0c, $20 ; entry 0
    db $f8, $f8, $0d, $20 ; entry 1
    db $f0, $f9, $0a, $00 ; entry 2
    db $f0, $01, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 54 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet36::
    dw MetaSprites7FSet36Frame0 ; entry 0
    dw MetaSprites7FSet36Frame1 ; entry 1
    dw MetaSprites7FSet36Frame2 ; entry 2
    dw MetaSprites7FSet36Frame3 ; entry 3
    dw MetaSprites7FSet36Frame4 ; entry 4
    dw MetaSprites7FSet36Frame5 ; entry 5

; frame 0 of MetaSprites7FSet36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet36Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet36; ends with $80 (E-0147)
MetaSprites7FSet36Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet36; ends with $80 (E-0147)
MetaSprites7FSet36Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet36; ends with $80 (E-0147)
MetaSprites7FSet36Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet36Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet36; ends with $80 (E-0147)
MetaSprites7FSet36Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 55 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet37::
    dw MetaSprites7FSet37Frame0 ; entry 0
    dw MetaSprites7FSet37Frame1 ; entry 1
    dw MetaSprites7FSet37Frame2 ; entry 2
    dw MetaSprites7FSet37Frame3 ; entry 3
    dw MetaSprites7FSet37Frame4 ; entry 4
    dw MetaSprites7FSet37Frame5 ; entry 5

; frame 0 of MetaSprites7FSet37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet37Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet37; ends with $80 (E-0147)
MetaSprites7FSet37Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet37; ends with $80 (E-0147)
MetaSprites7FSet37Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet37; ends with $80 (E-0147)
MetaSprites7FSet37Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet37Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet37; ends with $80 (E-0147)
MetaSprites7FSet37Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 56 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet38::
    dw MetaSprites7FSet38Frame0 ; entry 0
    dw MetaSprites7FSet38Frame1 ; entry 1
    dw MetaSprites7FSet38Frame2 ; entry 2
    dw MetaSprites7FSet38Frame3 ; entry 3
    dw MetaSprites7FSet38Frame4 ; entry 4
    dw MetaSprites7FSet38Frame5 ; entry 5

; frame 0 of MetaSprites7FSet38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet38Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet38; ends with $80 (E-0147)
MetaSprites7FSet38Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet38; ends with $80 (E-0147)
MetaSprites7FSet38Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet38; ends with $80 (E-0147)
MetaSprites7FSet38Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet38Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet38; ends with $80 (E-0147)
MetaSprites7FSet38Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 57 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet39::
    dw MetaSprites7FSet39Frame0 ; entry 0
    dw MetaSprites7FSet39Frame1 ; entry 1
    dw MetaSprites7FSet39Frame2 ; entry 2
    dw MetaSprites7FSet39Frame3 ; entry 3
    dw MetaSprites7FSet39Frame4 ; entry 4
    dw MetaSprites7FSet39Frame5 ; entry 5

; frame 0 of MetaSprites7FSet39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet39Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet39; ends with $80 (E-0147)
MetaSprites7FSet39Frame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet39; ends with $80 (E-0147)
MetaSprites7FSet39Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet39; ends with $80 (E-0147)
MetaSprites7FSet39Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet39Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet39; ends with $80 (E-0147)
MetaSprites7FSet39Frame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 58 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet3A::
    dw MetaSprites7FSet3AFrame0 ; entry 0
    dw MetaSprites7FSet3AFrame1 ; entry 1
    dw MetaSprites7FSet3AFrame2 ; entry 2
    dw MetaSprites7FSet3AFrame3 ; entry 3
    dw MetaSprites7FSet3AFrame4 ; entry 4
    dw MetaSprites7FSet3AFrame5 ; entry 5

; frame 0 of MetaSprites7FSet3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet3A; ends with $80 (E-0147)
MetaSprites7FSet3AFrame1::
    db $f8, $ff, $02, $20 ; entry 0
    db $f8, $f7, $03, $20 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet3A; ends with $80 (E-0147)
MetaSprites7FSet3AFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet3A; ends with $80 (E-0147)
MetaSprites7FSet3AFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3AFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet3A; ends with $80 (E-0147)
MetaSprites7FSet3AFrame5::
    db $f8, $ff, $0c, $20 ; entry 0
    db $f8, $f7, $0d, $20 ; entry 1
    db $f0, $f8, $0a, $00 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 59 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet3B::
    dw MetaSprites7FSet3BFrame0 ; entry 0
    dw MetaSprites7FSet3BFrame1 ; entry 1
    dw MetaSprites7FSet3BFrame2 ; entry 2
    dw MetaSprites7FSet3BFrame3 ; entry 3
    dw MetaSprites7FSet3BFrame4 ; entry 4
    dw MetaSprites7FSet3BFrame5 ; entry 5

; frame 0 of MetaSprites7FSet3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet3B; ends with $80 (E-0147)
MetaSprites7FSet3BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet3B; ends with $80 (E-0147)
MetaSprites7FSet3BFrame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet3B; ends with $80 (E-0147)
MetaSprites7FSet3BFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3BFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet3B; ends with $80 (E-0147)
MetaSprites7FSet3BFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $09, $20 ; entry 1
    db $f8, $00, $0a, $20 ; entry 2
    db $f8, $f8, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 60 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet3C::
    dw MetaSprites7FSet3CFrame0 ; entry 0
    dw MetaSprites7FSet3CFrame1 ; entry 1
    dw MetaSprites7FSet3CFrame2 ; entry 2
    dw MetaSprites7FSet3CFrame3 ; entry 3
    dw MetaSprites7FSet3CFrame4 ; entry 4
    dw MetaSprites7FSet3CFrame5 ; entry 5

; frame 0 of MetaSprites7FSet3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet3C; ends with $80 (E-0147)
MetaSprites7FSet3CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet3C; ends with $80 (E-0147)
MetaSprites7FSet3CFrame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet3C; ends with $80 (E-0147)
MetaSprites7FSet3CFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet3C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3CFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $f8, $0a, $00 ; entry 1
    db $f8, $00, $0b, $00 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet3C; ends with $80 (E-0147)
MetaSprites7FSet3CFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $ff, $0a, $20 ; entry 1
    db $f8, $f7, $0b, $20 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; meta-sprite set 61 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet3D::
    dw MetaSprites7FSet3DFrame0 ; entry 0
    dw MetaSprites7FSet3DFrame1 ; entry 1
    dw MetaSprites7FSet3DFrame2 ; entry 2
    dw MetaSprites7FSet3DFrame3 ; entry 3
    dw MetaSprites7FSet3DFrame4 ; entry 4
    dw MetaSprites7FSet3DFrame5 ; entry 5

; frame 0 of MetaSprites7FSet3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3DFrame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet3D; ends with $80 (E-0147)
MetaSprites7FSet3DFrame1::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet3D; ends with $80 (E-0147)
MetaSprites7FSet3DFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet3D; ends with $80 (E-0147)
MetaSprites7FSet3DFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet3D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3DFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet3D; ends with $80 (E-0147)
MetaSprites7FSet3DFrame5::
    db $f0, $ff, $0a, $20 ; entry 0
    db $f0, $f7, $0b, $20 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 62 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet3E::
    dw MetaSprites7FSet3EFrame0 ; entry 0
    dw MetaSprites7FSet3EFrame1 ; entry 1
    dw MetaSprites7FSet3EFrame2 ; entry 2
    dw MetaSprites7FSet3EFrame3 ; entry 3
    dw MetaSprites7FSet3EFrame4 ; entry 4
    dw MetaSprites7FSet3EFrame5 ; entry 5

; frame 0 of MetaSprites7FSet3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet3E; ends with $80 (E-0147)
MetaSprites7FSet3EFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet3E; ends with $80 (E-0147)
MetaSprites7FSet3EFrame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet3E; ends with $80 (E-0147)
MetaSprites7FSet3EFrame3::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet3E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3EFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $f8, $0a, $00 ; entry 1
    db $f8, $00, $0b, $00 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet3E; ends with $80 (E-0147)
MetaSprites7FSet3EFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f8, $ff, $0a, $20 ; entry 1
    db $f8, $f7, $0b, $20 ; entry 2
    db $f0, $ff, $09, $20 ; entry 3
    db $80 ; end

; meta-sprite set 63 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet3F::
    dw MetaSprites7FSet3FFrame0 ; entry 0
    dw MetaSprites7FSet3FFrame1 ; entry 1
    dw MetaSprites7FSet3FFrame2 ; entry 2
    dw MetaSprites7FSet3FFrame3 ; entry 3
    dw MetaSprites7FSet3FFrame4 ; entry 4
    dw MetaSprites7FSet3FFrame5 ; entry 5

; frame 0 of MetaSprites7FSet3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet3F; ends with $80 (E-0147)
MetaSprites7FSet3FFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet3F; ends with $80 (E-0147)
MetaSprites7FSet3FFrame2::
    db $f0, $f5, $03, $00 ; entry 0
    db $f0, $fd, $04, $00 ; entry 1
    db $f8, $f5, $05, $00 ; entry 2
    db $f8, $fd, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet3F; ends with $80 (E-0147)
MetaSprites7FSet3FFrame3::
    db $f0, $fd, $04, $00 ; entry 0
    db $f0, $f5, $07, $00 ; entry 1
    db $f8, $f5, $08, $00 ; entry 2
    db $f8, $fd, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet3F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet3FFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet3F; ends with $80 (E-0147)
MetaSprites7FSet3FFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $ff, $0b, $20 ; entry 2
    db $f8, $f7, $0c, $20 ; entry 3
    db $80 ; end

; meta-sprite set 64 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet40::
    dw MetaSprites7FSet40Frame0 ; entry 0
    dw MetaSprites7FSet40Frame1 ; entry 1
    dw MetaSprites7FSet40Frame2 ; entry 2
    dw MetaSprites7FSet40Frame3 ; entry 3
    dw MetaSprites7FSet40Frame4 ; entry 4
    dw MetaSprites7FSet40Frame5 ; entry 5

; frame 0 of MetaSprites7FSet40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet40Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet40; ends with $80 (E-0147)
MetaSprites7FSet40Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $ff, $01, $20 ; entry 1
    db $f8, $f7, $02, $20 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet40; ends with $80 (E-0147)
MetaSprites7FSet40Frame2::
    db $f0, $f5, $03, $00 ; entry 0
    db $f0, $fd, $04, $00 ; entry 1
    db $f8, $f5, $05, $00 ; entry 2
    db $f8, $fd, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet40; ends with $80 (E-0147)
MetaSprites7FSet40Frame3::
    db $f0, $fd, $04, $00 ; entry 0
    db $f0, $f5, $07, $00 ; entry 1
    db $f8, $f5, $08, $00 ; entry 2
    db $f8, $fd, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet40; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet40Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet40; ends with $80 (E-0147)
MetaSprites7FSet40Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $ff, $0a, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 65 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet41::
    dw MetaSprites7FSet41Frame0 ; entry 0
    dw MetaSprites7FSet41Frame1 ; entry 1
    dw MetaSprites7FSet41Frame2 ; entry 2
    dw MetaSprites7FSet41Frame3 ; entry 3
    dw MetaSprites7FSet41Frame4 ; entry 4
    dw MetaSprites7FSet41Frame5 ; entry 5

; frame 0 of MetaSprites7FSet41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet41Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet41; ends with $80 (E-0147)
MetaSprites7FSet41Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $00, $01, $20 ; entry 2
    db $f8, $f8, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet41; ends with $80 (E-0147)
MetaSprites7FSet41Frame2::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $05, $00 ; entry 2
    db $f8, $ff, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet41; ends with $80 (E-0147)
MetaSprites7FSet41Frame3::
    db $f0, $ff, $04, $00 ; entry 0
    db $f0, $f7, $07, $00 ; entry 1
    db $f8, $f7, $08, $00 ; entry 2
    db $f8, $ff, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet41; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet41Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $00, $0d, $00 ; entry 2
    db $f0, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet41; ends with $80 (E-0147)
MetaSprites7FSet41Frame5::
    db $f0, $00, $0b, $20 ; entry 0
    db $f8, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $20 ; entry 2
    db $f0, $f8, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 66 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet42::
    dw MetaSprites7FSet42Frame0 ; entry 0
    dw MetaSprites7FSet42Frame1 ; entry 1
    dw MetaSprites7FSet42Frame2 ; entry 2
    dw MetaSprites7FSet42Frame3 ; entry 3
    dw MetaSprites7FSet42Frame4 ; entry 4
    dw MetaSprites7FSet42Frame5 ; entry 5

; frame 0 of MetaSprites7FSet42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet42Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $02, $00 ; entry 1
    db $f8, $00, $03, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet42; ends with $80 (E-0147)
MetaSprites7FSet42Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet42; ends with $80 (E-0147)
MetaSprites7FSet42Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet42; ends with $80 (E-0147)
MetaSprites7FSet42Frame3::
    db $f0, $ff, $05, $00 ; entry 0
    db $f0, $f7, $08, $00 ; entry 1
    db $f8, $f7, $09, $00 ; entry 2
    db $f8, $ff, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet42; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet42Frame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet42; ends with $80 (E-0147)
MetaSprites7FSet42Frame5::
    db $f0, $ff, $0b, $20 ; entry 0
    db $f0, $f7, $0c, $20 ; entry 1
    db $f8, $ff, $0d, $20 ; entry 2
    db $f8, $f7, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 67 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet43::
    dw MetaSprites7FSet43Frame0 ; entry 0
    dw MetaSprites7FSet43Frame1 ; entry 1
    dw MetaSprites7FSet43Frame2 ; entry 2
    dw MetaSprites7FSet43Frame3 ; entry 3
    dw MetaSprites7FSet43Frame4 ; entry 4
    dw MetaSprites7FSet43Frame5 ; entry 5

; frame 0 of MetaSprites7FSet43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet43Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet43; ends with $80 (E-0147)
MetaSprites7FSet43Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet43; ends with $80 (E-0147)
MetaSprites7FSet43Frame2::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $05, $00 ; entry 2
    db $f8, $ff, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet43; ends with $80 (E-0147)
MetaSprites7FSet43Frame3::
    db $f0, $f7, $03, $00 ; entry 0
    db $f0, $ff, $04, $00 ; entry 1
    db $f8, $f7, $07, $00 ; entry 2
    db $f8, $ff, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet43; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet43Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet43; ends with $80 (E-0147)
MetaSprites7FSet43Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 68 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet44::
    dw MetaSprites7FSet44Frame0 ; entry 0
    dw MetaSprites7FSet44Frame1 ; entry 1
    dw MetaSprites7FSet44Frame2 ; entry 2
    dw MetaSprites7FSet44Frame3 ; entry 3
    dw MetaSprites7FSet44Frame4 ; entry 4
    dw MetaSprites7FSet44Frame5 ; entry 5

; frame 0 of MetaSprites7FSet44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet44Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet44; ends with $80 (E-0147)
MetaSprites7FSet44Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet44; ends with $80 (E-0147)
MetaSprites7FSet44Frame2::
    db $f0, $f8, $03, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $00, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet44; ends with $80 (E-0147)
MetaSprites7FSet44Frame3::
    db $f8, $f8, $07, $00 ; entry 0
    db $f8, $00, $08, $00 ; entry 1
    db $f0, $f7, $03, $00 ; entry 2
    db $f0, $ff, $04, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet44; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet44Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet44; ends with $80 (E-0147)
MetaSprites7FSet44Frame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 69 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet45::
    dw MetaSprites7FSet45Frame0 ; entry 0
    dw MetaSprites7FSet45Frame1 ; entry 1
    dw MetaSprites7FSet45Frame2 ; entry 2
    dw MetaSprites7FSet45Frame3 ; entry 3
    dw MetaSprites7FSet45Frame4 ; entry 4
    dw MetaSprites7FSet45Frame5 ; entry 5

; frame 0 of MetaSprites7FSet45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet45Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f0, $f8, $00, $00 ; entry 1
    db $f0, $00, $01, $00 ; entry 2
    db $f8, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet45; ends with $80 (E-0147)
MetaSprites7FSet45Frame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f9, $f8, $03, $00 ; entry 1
    db $f1, $00, $01, $00 ; entry 2
    db $f9, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet45; ends with $80 (E-0147)
MetaSprites7FSet45Frame2::
    db $f0, $f7, $04, $00 ; entry 0
    db $f0, $ff, $05, $00 ; entry 1
    db $f8, $f7, $06, $00 ; entry 2
    db $f8, $ff, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet45; ends with $80 (E-0147)
MetaSprites7FSet45Frame3::
    db $f9, $f7, $08, $00 ; entry 0
    db $f9, $ff, $09, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet45; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet45Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f0, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet45; ends with $80 (E-0147)
MetaSprites7FSet45Frame5::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 70 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet46::
    dw MetaSprites7FSet46Frame0 ; entry 0
    dw MetaSprites7FSet46Frame1 ; entry 1
    dw MetaSprites7FSet46Frame2 ; entry 2
    dw MetaSprites7FSet46Frame3 ; entry 3
    dw MetaSprites7FSet46Frame4 ; entry 4
    dw MetaSprites7FSet46Frame5 ; entry 5

; frame 0 of MetaSprites7FSet46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet46Frame0::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet46; ends with $80 (E-0147)
MetaSprites7FSet46Frame1::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet46; ends with $80 (E-0147)
MetaSprites7FSet46Frame2::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet46; ends with $80 (E-0147)
MetaSprites7FSet46Frame3::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet46; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet46Frame4::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet46; ends with $80 (E-0147)
MetaSprites7FSet46Frame5::
    db $ef, $fa, $00, $00 ; entry 0
    db $ef, $02, $01, $00 ; entry 1
    db $f7, $fa, $02, $00 ; entry 2
    db $f7, $02, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 71 of MetaSprites7FTable: 3 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet47::
    dw MetaSprites7FSet47Frame0 ; entry 0
    dw MetaSprites7FSet47Frame1 ; entry 1
    dw MetaSprites7FSet47Frame2 ; entry 2

; frame 0 of MetaSprites7FSet47; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet47Frame0::
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

; frame 1 of MetaSprites7FSet47; ends with $80 (E-0147)
MetaSprites7FSet47Frame1::
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

; frame 2 of MetaSprites7FSet47; ends with $80 (E-0147)
MetaSprites7FSet47Frame2::
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

; meta-sprite set 72 of MetaSprites7FTable: 3 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet48::
    dw MetaSprites7FSet48Frame0 ; entry 0
    dw MetaSprites7FSet48Frame1 ; entry 1
    dw MetaSprites7FSet48Frame2 ; entry 2

; frame 0 of MetaSprites7FSet48; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet48Frame0::
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

; frame 1 of MetaSprites7FSet48; ends with $80 (E-0147)
MetaSprites7FSet48Frame1::
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

; frame 2 of MetaSprites7FSet48; ends with $80 (E-0147)
MetaSprites7FSet48Frame2::
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

; meta-sprite set 73 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet49::
    dw MetaSprites7FSet49Frame0 ; entry 0
    dw MetaSprites7FSet49Frame1 ; entry 1
    dw MetaSprites7FSet49Frame2 ; entry 2
    dw MetaSprites7FSet49Frame3 ; entry 3
    dw MetaSprites7FSet49Frame4 ; entry 4
    dw MetaSprites7FSet49Frame5 ; entry 5

; frame 0 of MetaSprites7FSet49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet49Frame0::
    db $ee, $f8, $00, $00 ; entry 0
    db $ee, $00, $01, $00 ; entry 1
    db $f6, $f8, $02, $00 ; entry 2
    db $f6, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet49; ends with $80 (E-0147)
MetaSprites7FSet49Frame1::
    db $ee, $00, $00, $20 ; entry 0
    db $ee, $f8, $01, $20 ; entry 1
    db $f6, $00, $02, $20 ; entry 2
    db $f6, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet49; ends with $80 (E-0147)
MetaSprites7FSet49Frame2::
    db $ee, $f8, $04, $00 ; entry 0
    db $ee, $00, $05, $00 ; entry 1
    db $f6, $f8, $06, $00 ; entry 2
    db $f6, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet49; ends with $80 (E-0147)
MetaSprites7FSet49Frame3::
    db $ee, $f8, $08, $00 ; entry 0
    db $ee, $00, $09, $00 ; entry 1
    db $f6, $f8, $0a, $00 ; entry 2
    db $f6, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet49; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet49Frame4::
    db $ee, $f8, $0c, $00 ; entry 0
    db $ee, $00, $0d, $00 ; entry 1
    db $f6, $f8, $0e, $00 ; entry 2
    db $f6, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet49; ends with $80 (E-0147)
MetaSprites7FSet49Frame5::
    db $ee, $00, $0c, $20 ; entry 0
    db $ee, $f8, $0d, $20 ; entry 1
    db $f6, $00, $0e, $20 ; entry 2
    db $f6, $f8, $0f, $20 ; entry 3
    db $80 ; end

; meta-sprite set 74 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet4A::
    dw MetaSprites7FSet4AFrame0 ; entry 0
    dw MetaSprites7FSet4AFrame1 ; entry 1
    dw MetaSprites7FSet4AFrame2 ; entry 2
    dw MetaSprites7FSet4AFrame3 ; entry 3
    dw MetaSprites7FSet4AFrame4 ; entry 4
    dw MetaSprites7FSet4AFrame5 ; entry 5

; frame 0 of MetaSprites7FSet4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4AFrame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet4A; ends with $80 (E-0147)
MetaSprites7FSet4AFrame1::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet4A; ends with $80 (E-0147)
MetaSprites7FSet4AFrame2::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet4A; ends with $80 (E-0147)
MetaSprites7FSet4AFrame3::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet4A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4AFrame4::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet4A; ends with $80 (E-0147)
MetaSprites7FSet4AFrame5::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 75 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet4B::
    dw MetaSprites7FSet4BFrame0 ; entry 0
    dw MetaSprites7FSet4BFrame1 ; entry 1
    dw MetaSprites7FSet4BFrame2 ; entry 2
    dw MetaSprites7FSet4BFrame3 ; entry 3
    dw MetaSprites7FSet4BFrame4 ; entry 4
    dw MetaSprites7FSet4BFrame5 ; entry 5

; frame 0 of MetaSprites7FSet4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet4B; ends with $80 (E-0147)
MetaSprites7FSet4BFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet4B; ends with $80 (E-0147)
MetaSprites7FSet4BFrame2::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $05, $00 ; entry 2
    db $f8, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet4B; ends with $80 (E-0147)
MetaSprites7FSet4BFrame3::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet4B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4BFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet4B; ends with $80 (E-0147)
MetaSprites7FSet4BFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 76 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet4C::
    dw MetaSprites7FSet4CFrame0 ; entry 0
    dw MetaSprites7FSet4CFrame1 ; entry 1
    dw MetaSprites7FSet4CFrame2 ; entry 2
    dw MetaSprites7FSet4CFrame3 ; entry 3
    dw MetaSprites7FSet4CFrame4 ; entry 4
    dw MetaSprites7FSet4CFrame5 ; entry 5

; frame 0 of MetaSprites7FSet4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet4C; ends with $80 (E-0147)
MetaSprites7FSet4CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet4C; ends with $80 (E-0147)
MetaSprites7FSet4CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet4C; ends with $80 (E-0147)
MetaSprites7FSet4CFrame3::
    db $f0, $00, $05, $00 ; entry 0
    db $f0, $f8, $08, $00 ; entry 1
    db $f8, $f8, $09, $00 ; entry 2
    db $f8, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet4C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4CFrame4::
    db $f0, $f8, $0b, $00 ; entry 0
    db $f0, $00, $0c, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet4C; ends with $80 (E-0147)
MetaSprites7FSet4CFrame5::
    db $f0, $00, $0c, $00 ; entry 0
    db $f0, $f8, $0f, $00 ; entry 1
    db $f8, $ff, $0d, $20 ; entry 2
    db $f8, $f7, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 77 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet4D::
    dw MetaSprites7FSet4DFrame0 ; entry 0
    dw MetaSprites7FSet4DFrame1 ; entry 1
    dw MetaSprites7FSet4DFrame2 ; entry 2
    dw MetaSprites7FSet4DFrame3 ; entry 3
    dw MetaSprites7FSet4DFrame4 ; entry 4
    dw MetaSprites7FSet4DFrame5 ; entry 5

; frame 0 of MetaSprites7FSet4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $02, $00 ; entry 2
    db $f0, $ff, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet4D; ends with $80 (E-0147)
MetaSprites7FSet4DFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $ff, $00, $20 ; entry 1
    db $f8, $ff, $01, $20 ; entry 2
    db $f8, $f7, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet4D; ends with $80 (E-0147)
MetaSprites7FSet4DFrame2::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $05, $00 ; entry 2
    db $f8, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet4D; ends with $80 (E-0147)
MetaSprites7FSet4DFrame3::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $07, $00 ; entry 2
    db $f8, $01, $08, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet4D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4DFrame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet4D; ends with $80 (E-0147)
MetaSprites7FSet4DFrame5::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $ff, $09, $20 ; entry 1
    db $f8, $ff, $0a, $20 ; entry 2
    db $f8, $f7, $0b, $20 ; entry 3
    db $80 ; end

; meta-sprite set 78 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet4E::
    dw MetaSprites7FSet4EFrame0 ; entry 0
    dw MetaSprites7FSet4EFrame1 ; entry 1
    dw MetaSprites7FSet4EFrame2 ; entry 2
    dw MetaSprites7FSet4EFrame3 ; entry 3
    dw MetaSprites7FSet4EFrame4 ; entry 4
    dw MetaSprites7FSet4EFrame5 ; entry 5

; frame 0 of MetaSprites7FSet4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet4E; ends with $80 (E-0147)
MetaSprites7FSet4EFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet4E; ends with $80 (E-0147)
MetaSprites7FSet4EFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet4E; ends with $80 (E-0147)
MetaSprites7FSet4EFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet4E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4EFrame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $fd, $0a, $20 ; entry 1
    db $f9, $f8, $0d, $00 ; entry 2
    db $f9, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet4E; ends with $80 (E-0147)
MetaSprites7FSet4EFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $fd, $0a, $20 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0c, $00 ; entry 3
    db $80 ; end

; meta-sprite set 79 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet4F::
    dw MetaSprites7FSet4FFrame0 ; entry 0
    dw MetaSprites7FSet4FFrame1 ; entry 1
    dw MetaSprites7FSet4FFrame2 ; entry 2
    dw MetaSprites7FSet4FFrame3 ; entry 3
    dw MetaSprites7FSet4FFrame4 ; entry 4
    dw MetaSprites7FSet4FFrame5 ; entry 5

; frame 0 of MetaSprites7FSet4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet4F; ends with $80 (E-0147)
MetaSprites7FSet4FFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet4F; ends with $80 (E-0147)
MetaSprites7FSet4FFrame2::
    db $f0, $f8, $05, $00 ; entry 0
    db $f0, $00, $06, $00 ; entry 1
    db $f8, $f8, $07, $00 ; entry 2
    db $f8, $00, $08, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet4F; ends with $80 (E-0147)
MetaSprites7FSet4FFrame3::
    db $f1, $f8, $05, $00 ; entry 0
    db $f1, $00, $06, $00 ; entry 1
    db $f9, $00, $08, $00 ; entry 2
    db $f9, $f8, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet4F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet4FFrame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $fd, $0a, $20 ; entry 1
    db $f9, $f8, $0b, $00 ; entry 2
    db $f9, $00, $0c, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet4F; ends with $80 (E-0147)
MetaSprites7FSet4FFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $fd, $0a, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; meta-sprite set 80 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet50::
    dw MetaSprites7FSet50Frame0 ; entry 0
    dw MetaSprites7FSet50Frame1 ; entry 1
    dw MetaSprites7FSet50Frame2 ; entry 2
    dw MetaSprites7FSet50Frame3 ; entry 3
    dw MetaSprites7FSet50Frame4 ; entry 4
    dw MetaSprites7FSet50Frame5 ; entry 5

; frame 0 of MetaSprites7FSet50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet50Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet50; ends with $80 (E-0147)
MetaSprites7FSet50Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet50; ends with $80 (E-0147)
MetaSprites7FSet50Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet50; ends with $80 (E-0147)
MetaSprites7FSet50Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet50; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet50Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet50; ends with $80 (E-0147)
MetaSprites7FSet50Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $00, $0c, $20 ; entry 2
    db $f8, $f8, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 81 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet51::
    dw MetaSprites7FSet51Frame0 ; entry 0
    dw MetaSprites7FSet51Frame1 ; entry 1
    dw MetaSprites7FSet51Frame2 ; entry 2
    dw MetaSprites7FSet51Frame3 ; entry 3
    dw MetaSprites7FSet51Frame4 ; entry 4
    dw MetaSprites7FSet51Frame5 ; entry 5

; frame 0 of MetaSprites7FSet51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet51Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet51; ends with $80 (E-0147)
MetaSprites7FSet51Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet51; ends with $80 (E-0147)
MetaSprites7FSet51Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet51; ends with $80 (E-0147)
MetaSprites7FSet51Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet51; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet51Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet51; ends with $80 (E-0147)
MetaSprites7FSet51Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 82 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet52::
    dw MetaSprites7FSet52Frame0 ; entry 0
    dw MetaSprites7FSet52Frame1 ; entry 1
    dw MetaSprites7FSet52Frame2 ; entry 2
    dw MetaSprites7FSet52Frame3 ; entry 3
    dw MetaSprites7FSet52Frame4 ; entry 4
    dw MetaSprites7FSet52Frame5 ; entry 5

; frame 0 of MetaSprites7FSet52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet52Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet52; ends with $80 (E-0147)
MetaSprites7FSet52Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet52; ends with $80 (E-0147)
MetaSprites7FSet52Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet52; ends with $80 (E-0147)
MetaSprites7FSet52Frame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet52; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet52Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet52; ends with $80 (E-0147)
MetaSprites7FSet52Frame5::
    db $f0, $ff, $0a, $20 ; entry 0
    db $f0, $f7, $0b, $20 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 83 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet53::
    dw MetaSprites7FSet53Frame0 ; entry 0
    dw MetaSprites7FSet53Frame1 ; entry 1
    dw MetaSprites7FSet53Frame2 ; entry 2
    dw MetaSprites7FSet53Frame3 ; entry 3
    dw MetaSprites7FSet53Frame4 ; entry 4
    dw MetaSprites7FSet53Frame5 ; entry 5

; frame 0 of MetaSprites7FSet53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet53Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet53; ends with $80 (E-0147)
MetaSprites7FSet53Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet53; ends with $80 (E-0147)
MetaSprites7FSet53Frame2::
    db $f0, $f6, $04, $00 ; entry 0
    db $f0, $fe, $05, $00 ; entry 1
    db $f8, $f6, $06, $00 ; entry 2
    db $f8, $fe, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet53; ends with $80 (E-0147)
MetaSprites7FSet53Frame3::
    db $f8, $f6, $08, $00 ; entry 0
    db $f8, $fe, $09, $00 ; entry 1
    db $f0, $f6, $04, $00 ; entry 2
    db $f0, $fe, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet53; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet53Frame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $ff, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet53; ends with $80 (E-0147)
MetaSprites7FSet53Frame5::
    db $f0, $f7, $0b, $20 ; entry 0
    db $f8, $ff, $0d, $20 ; entry 1
    db $f0, $ff, $0a, $20 ; entry 2
    db $f8, $f8, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 84 of MetaSprites7FTable: 8 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet54::
    dw MetaSprites7FSet54Frame0 ; entry 0
    dw MetaSprites7FSet54Frame1 ; entry 1
    dw MetaSprites7FSet54Frame2 ; entry 2
    dw MetaSprites7FSet54Frame3 ; entry 3
    dw MetaSprites7FSet54Frame4 ; entry 4
    dw MetaSprites7FSet54Frame5 ; entry 5
    dw MetaSprites7FSet54Frame6 ; entry 6
    dw MetaSprites7FSet54Frame7 ; entry 7

; frame 0 of MetaSprites7FSet54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet54Frame0::
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

; frame 1 of MetaSprites7FSet54; ends with $80 (E-0147)
MetaSprites7FSet54Frame1::
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

; frame 2 of MetaSprites7FSet54; ends with $80 (E-0147)
MetaSprites7FSet54Frame2::
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

; frame 3 of MetaSprites7FSet54; ends with $80 (E-0147)
MetaSprites7FSet54Frame3::
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

; frame 4 of MetaSprites7FSet54; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet54Frame4::
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

; frame 5 of MetaSprites7FSet54; ends with $80 (E-0147)
MetaSprites7FSet54Frame5::
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

; frame 6 of MetaSprites7FSet54; ends with $80 (E-0147)
MetaSprites7FSet54Frame6::
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

; frame 7 of MetaSprites7FSet54; ends with $80 (E-0147)
MetaSprites7FSet54Frame7::
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

; meta-sprite set 85 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet55::
    dw MetaSprites7FSet55Frame0 ; entry 0
    dw MetaSprites7FSet55Frame1 ; entry 1
    dw MetaSprites7FSet55Frame2 ; entry 2
    dw MetaSprites7FSet55Frame3 ; entry 3
    dw MetaSprites7FSet55Frame4 ; entry 4
    dw MetaSprites7FSet55Frame5 ; entry 5

; frame 0 of MetaSprites7FSet55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet55Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet55; ends with $80 (E-0147)
MetaSprites7FSet55Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet55; ends with $80 (E-0147)
MetaSprites7FSet55Frame2::
    db $f1, $f8, $06, $00 ; entry 0
    db $f1, $00, $07, $00 ; entry 1
    db $f9, $f8, $08, $00 ; entry 2
    db $f9, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet55; ends with $80 (E-0147)
MetaSprites7FSet55Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet55; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet55Frame4::
    db $f1, $ff, $00, $20 ; entry 0
    db $f1, $f7, $01, $20 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet55; ends with $80 (E-0147)
MetaSprites7FSet55Frame5::
    db $f0, $ff, $00, $20 ; entry 0
    db $f0, $f7, $01, $20 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; meta-sprite set 86 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet56::
    dw MetaSprites7FSet56Frame0 ; entry 0
    dw MetaSprites7FSet56Frame1 ; entry 1
    dw MetaSprites7FSet56Frame2 ; entry 2
    dw MetaSprites7FSet56Frame3 ; entry 3
    dw MetaSprites7FSet56Frame4 ; entry 4
    dw MetaSprites7FSet56Frame5 ; entry 5

; frame 0 of MetaSprites7FSet56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet56Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet56; ends with $80 (E-0147)
MetaSprites7FSet56Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet56; ends with $80 (E-0147)
MetaSprites7FSet56Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet56; ends with $80 (E-0147)
MetaSprites7FSet56Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet56; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet56Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet56; ends with $80 (E-0147)
MetaSprites7FSet56Frame5::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 87 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet57::
    dw MetaSprites7FSet57Frame0 ; entry 0
    dw MetaSprites7FSet57Frame1 ; entry 1
    dw MetaSprites7FSet57Frame2 ; entry 2
    dw MetaSprites7FSet57Frame3 ; entry 3
    dw MetaSprites7FSet57Frame4 ; entry 4
    dw MetaSprites7FSet57Frame5 ; entry 5

; frame 0 of MetaSprites7FSet57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet57Frame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $ff, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet57; ends with $80 (E-0147)
MetaSprites7FSet57Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet57; ends with $80 (E-0147)
MetaSprites7FSet57Frame2::
    db $f9, $f8, $06, $00 ; entry 0
    db $f9, $00, $07, $00 ; entry 1
    db $f1, $f8, $04, $00 ; entry 2
    db $f1, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet57; ends with $80 (E-0147)
MetaSprites7FSet57Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet57; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet57Frame4::
    db $f1, $f8, $0a, $00 ; entry 0
    db $f1, $00, $0b, $00 ; entry 1
    db $f9, $f8, $0c, $00 ; entry 2
    db $f9, $ff, $0c, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet57; ends with $80 (E-0147)
MetaSprites7FSet57Frame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $ff, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 88 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet58::
    dw MetaSprites7FSet58Frame0 ; entry 0
    dw MetaSprites7FSet58Frame1 ; entry 1
    dw MetaSprites7FSet58Frame2 ; entry 2
    dw MetaSprites7FSet58Frame3 ; entry 3
    dw MetaSprites7FSet58Frame4 ; entry 4
    dw MetaSprites7FSet58Frame5 ; entry 5

; frame 0 of MetaSprites7FSet58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet58Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet58; ends with $80 (E-0147)
MetaSprites7FSet58Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet58; ends with $80 (E-0147)
MetaSprites7FSet58Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet58; ends with $80 (E-0147)
MetaSprites7FSet58Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet58; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet58Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet58; ends with $80 (E-0147)
MetaSprites7FSet58Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 89 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet59::
    dw MetaSprites7FSet59Frame0 ; entry 0
    dw MetaSprites7FSet59Frame1 ; entry 1
    dw MetaSprites7FSet59Frame2 ; entry 2
    dw MetaSprites7FSet59Frame3 ; entry 3
    dw MetaSprites7FSet59Frame4 ; entry 4
    dw MetaSprites7FSet59Frame5 ; entry 5

; frame 0 of MetaSprites7FSet59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet59Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet59; ends with $80 (E-0147)
MetaSprites7FSet59Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet59; ends with $80 (E-0147)
MetaSprites7FSet59Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet59; ends with $80 (E-0147)
MetaSprites7FSet59Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet59; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet59Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet59; ends with $80 (E-0147)
MetaSprites7FSet59Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; meta-sprite set 90 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet5A::
    dw MetaSprites7FSet5AFrame0 ; entry 0
    dw MetaSprites7FSet5AFrame1 ; entry 1
    dw MetaSprites7FSet5AFrame2 ; entry 2
    dw MetaSprites7FSet5AFrame3 ; entry 3
    dw MetaSprites7FSet5AFrame4 ; entry 4
    dw MetaSprites7FSet5AFrame5 ; entry 5

; frame 0 of MetaSprites7FSet5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5AFrame0::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet5A; ends with $80 (E-0147)
MetaSprites7FSet5AFrame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet5A; ends with $80 (E-0147)
MetaSprites7FSet5AFrame2::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet5A; ends with $80 (E-0147)
MetaSprites7FSet5AFrame3::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet5A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5AFrame4::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet5A; ends with $80 (E-0147)
MetaSprites7FSet5AFrame5::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; meta-sprite set 91 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet5B::
    dw MetaSprites7FSet5BFrame0 ; entry 0
    dw MetaSprites7FSet5BFrame1 ; entry 1
    dw MetaSprites7FSet5BFrame2 ; entry 2
    dw MetaSprites7FSet5BFrame3 ; entry 3
    dw MetaSprites7FSet5BFrame4 ; entry 4
    dw MetaSprites7FSet5BFrame5 ; entry 5

; frame 0 of MetaSprites7FSet5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5BFrame0::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet5B; ends with $80 (E-0147)
MetaSprites7FSet5BFrame1::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet5B; ends with $80 (E-0147)
MetaSprites7FSet5BFrame2::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet5B; ends with $80 (E-0147)
MetaSprites7FSet5BFrame3::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet5B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5BFrame4::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet5B; ends with $80 (E-0147)
MetaSprites7FSet5BFrame5::
    db $f1, $f8, $00, $00 ; entry 0
    db $f1, $00, $01, $00 ; entry 1
    db $f9, $f8, $02, $00 ; entry 2
    db $f9, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 92 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet5C::
    dw MetaSprites7FSet5CFrame0 ; entry 0
    dw MetaSprites7FSet5CFrame1 ; entry 1
    dw MetaSprites7FSet5CFrame2 ; entry 2
    dw MetaSprites7FSet5CFrame3 ; entry 3
    dw MetaSprites7FSet5CFrame4 ; entry 4
    dw MetaSprites7FSet5CFrame5 ; entry 5

; frame 0 of MetaSprites7FSet5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet5C; ends with $80 (E-0147)
MetaSprites7FSet5CFrame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $ff, $02, $20 ; entry 2
    db $f8, $f7, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet5C; ends with $80 (E-0147)
MetaSprites7FSet5CFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet5C; ends with $80 (E-0147)
MetaSprites7FSet5CFrame3::
    db $f8, $f8, $08, $00 ; entry 0
    db $f8, $00, $09, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet5C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5CFrame4::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $f8, $0c, $00 ; entry 2
    db $f8, $00, $0d, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet5C; ends with $80 (E-0147)
MetaSprites7FSet5CFrame5::
    db $f0, $f8, $0a, $00 ; entry 0
    db $f0, $00, $0b, $00 ; entry 1
    db $f8, $ff, $0c, $20 ; entry 2
    db $f8, $f7, $0d, $20 ; entry 3
    db $80 ; end

; meta-sprite set 95 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet5F::
    dw MetaSprites7FSet5FFrame0 ; entry 0
    dw MetaSprites7FSet5FFrame1 ; entry 1
    dw MetaSprites7FSet5FFrame2 ; entry 2
    dw MetaSprites7FSet5FFrame3 ; entry 3
    dw MetaSprites7FSet5FFrame4 ; entry 4
    dw MetaSprites7FSet5FFrame5 ; entry 5

; frame 0 of MetaSprites7FSet5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet5F; ends with $80 (E-0147)
MetaSprites7FSet5FFrame1::
    db $f9, $00, $01, $20 ; entry 0
    db $f9, $f8, $02, $20 ; entry 1
    db $f1, $f8, $03, $00 ; entry 2
    db $f1, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet5F; ends with $80 (E-0147)
MetaSprites7FSet5FFrame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet5F; ends with $80 (E-0147)
MetaSprites7FSet5FFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet5F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet5FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0c, $20 ; entry 1
    db $f8, $f8, $0d, $00 ; entry 2
    db $f8, $00, $0e, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet5F; ends with $80 (E-0147)
MetaSprites7FSet5FFrame5::
    db $f1, $f8, $0f, $00 ; entry 0
    db $f1, $00, $0f, $20 ; entry 1
    db $f9, $00, $0d, $20 ; entry 2
    db $f9, $f8, $0e, $20 ; entry 3
    db $80 ; end

; meta-sprite set 97 of MetaSprites7FTable: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FSet61::
    dw MetaSprites7FSet61Frame0 ; entry 0
    dw MetaSprites7FSet61Frame1 ; entry 1
    dw MetaSprites7FSet61Frame2 ; entry 2
    dw MetaSprites7FSet61Frame3 ; entry 3
    dw MetaSprites7FSet61Frame4 ; entry 4
    dw MetaSprites7FSet61Frame5 ; entry 5

; frame 0 of MetaSprites7FSet61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet61Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FSet61; ends with $80 (E-0147)
MetaSprites7FSet61Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FSet61; ends with $80 (E-0147)
MetaSprites7FSet61Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FSet61; ends with $80 (E-0147)
MetaSprites7FSet61Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FSet61; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FSet61Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FSet61; ends with $80 (E-0147)
MetaSprites7FSet61Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $02, $20 ; entry 3
    db $80 ; end

; DE = MetaSprites7FTable_2 (the table of meta-sprite sets), then DrawMetaSpriteAt (E-0030)
DrawMetaSprite::
    ld de, MetaSprites7FTable_2
    call DrawMetaSpriteAt
    ret

; the caller of DrawMetaSprite passes DE = $MetaSprites7FTable_2; the builder takes the word at DE +
; 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 42 words,
; up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites7FTable_2::
    dw MetaSprites7FTable_2Set00 ; id 0
    dw MetaSprites7FTable_2Set01 ; id 1
    dw MetaSprites7FTable_2Set02 ; id 2
    dw MetaSprites7FTable_2Set03 ; id 3
    dw MetaSprites7FTable_2Set04 ; id 4
    dw MetaSprites7FTable_2Set05 ; id 5
    dw MetaSprites7FTable_2Set06 ; id 6
    dw MetaSprites7FTable_2Set07 ; id 7
    dw MetaSprites7FTable_2Set08 ; id 8
    dw MetaSprites7FTable_2Set09 ; id 9
    dw MetaSprites7FTable_2Set0A ; id 10
    dw MetaSprites7FTable_2Set0B ; id 11
    dw MetaSprites7FTable_2Set0C ; id 12
    dw MetaSprites7FTable_2Set0D ; id 13
    dw MetaSprites7FTable_2Set0E ; id 14
    dw MetaSprites7FTable_2Set0F ; id 15
    dw MetaSprites7FTable_2Set10 ; id 16
    dw MetaSprites7FTable_2Set11 ; id 17
    dw MetaSprites7FTable_2Set12 ; id 18
    dw MetaSprites7FTable_2Set13 ; id 19
    dw MetaSprites7FTable_2Set14 ; id 20
    dw MetaSprites7FTable_2Set15 ; id 21
    dw MetaSprites7FTable_2Set16 ; id 22
    dw MetaSprites7FTable_2Set17 ; id 23
    dw MetaSprites7FTable_2Set18 ; id 24
    dw MetaSprites7FTable_2Set19 ; id 25
    dw MetaSprites7FTable_2Set1A ; id 26
    dw MetaSprites7FTable_2Set1B ; id 27
    dw MetaSprites7FTable_2Set1C ; id 28
    dw MetaSprites7FTable_2Set1D ; id 29
    dw MetaSprites7FTable_2Set1E ; id 30
    dw MetaSprites7FTable_2Set1F ; id 31
    dw MetaSprites7FTable_2Set20 ; id 32
    dw MetaSprites7FTable_2Set21 ; id 33
    dw MetaSprites7FTable_2Set22 ; id 34
    dw MetaSprites7FTable_2Set23 ; id 35
    dw MetaSprites7FTable_2Set24 ; id 36
    dw MetaSprites7FTable_2Set25 ; id 37
    dw MetaSprites7FTable_2Set26 ; id 38
    dw MetaSprites7FTable_2Set27 ; id 39
    dw MetaSprites7FTable_2Set28 ; id 40
    dw MetaSprites7FTable_2Set29 ; id 41

; DE = table of set pointers: returns at once when hOamNextEntry is $27 or more; otherwise converts
; the 16-bit position (hSpriteOriginX with hSpriteOriginXHi, hSpriteOriginY with hSpriteOriginYHi)
; to screen coordinates by adding the scroll-offset words hSpriteScrollXLo/Hi and
; hSpriteScrollYLo/Hi, and writes OAM entries for the sprite chosen by hSpriteSetIndex and
; hSpriteSubIndex (tile += hSpriteTileOffset, attribute ^= hSpriteAttrXor) (E-0030)
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

; meta-sprite set 0 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set00::
    dw MetaSprites7FTable_2Set00Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set00Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 1 of MetaSprites7FTable_2: 2 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set01::
    dw MetaSprites7FTable_2Set01Frame0 ; entry 0
    dw MetaSprites7FTable_2Set01Frame1 ; entry 1

; frame 0 of MetaSprites7FTable_2Set01; ends with $80 (E-0147)
MetaSprites7FTable_2Set01Frame0::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $02, $20 ; entry 1
    db $f8, $f8, $03, $00 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set01; ends with $80 (E-0147)
MetaSprites7FTable_2Set01Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f8, $01, $00 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; meta-sprite set 2 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set02::
    dw MetaSprites7FTable_2Set02Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set02Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 3 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set03::
    dw MetaSprites7FTable_2Set03Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set03; ends with $80 (E-0147)
MetaSprites7FTable_2Set03Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 4 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set04::
    dw MetaSprites7FTable_2Set04Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set04Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 5 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set05::
    dw MetaSprites7FTable_2Set05Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set05; ends with $80 (E-0147)
MetaSprites7FTable_2Set05Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 6 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set06::
    dw MetaSprites7FTable_2Set06Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set06Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 7 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set07::
    dw MetaSprites7FTable_2Set07Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set07; ends with $80 (E-0147)
MetaSprites7FTable_2Set07Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 8 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set08::
    dw MetaSprites7FTable_2Set08Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set08Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 9 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set09::
    dw MetaSprites7FTable_2Set09Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set09; ends with $80 (E-0147)
MetaSprites7FTable_2Set09Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 10 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set0A::
    dw MetaSprites7FTable_2Set0AFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set0AFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 11 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set0B::
    dw MetaSprites7FTable_2Set0BFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set0B; ends with $80 (E-0147)
MetaSprites7FTable_2Set0BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 12 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set0C::
    dw MetaSprites7FTable_2Set0CFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set0CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 13 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set0D::
    dw MetaSprites7FTable_2Set0DFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set0D; ends with $80 (E-0147)
MetaSprites7FTable_2Set0DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 14 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set0E::
    dw MetaSprites7FTable_2Set0EFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set0E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set0EFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 15 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set0F::
    dw MetaSprites7FTable_2Set0FFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set0F; ends with $80 (E-0147)
MetaSprites7FTable_2Set0FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 16 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set10::
    dw MetaSprites7FTable_2Set10Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set10Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 17 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set11::
    dw MetaSprites7FTable_2Set11Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set11; ends with $80 (E-0147)
MetaSprites7FTable_2Set11Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 18 of MetaSprites7FTable_2: 4 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set12::
    dw MetaSprites7FTable_2Set12Frame0 ; entry 0
    dw MetaSprites7FTable_2Set12Frame1 ; entry 1
    dw MetaSprites7FTable_2Set12Frame2 ; entry 2
    dw MetaSprites7FTable_2Set12Frame3 ; entry 3

; frame 0 of MetaSprites7FTable_2Set12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set12Frame0::
    db $ec, $f8, $00, $00 ; entry 0
    db $f4, $f8, $01, $00 ; entry 1
    db $f4, $00, $01, $20 ; entry 2
    db $ec, $00, $00, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set12; ends with $80 (E-0147)
MetaSprites7FTable_2Set12Frame1::
    db $ed, $f8, $02, $00 ; entry 0
    db $f5, $f8, $03, $00 ; entry 1
    db $ed, $00, $02, $20 ; entry 2
    db $f5, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set12; ends with $80 (E-0147)
MetaSprites7FTable_2Set12Frame2::
    db $ec, $f8, $04, $00 ; entry 0
    db $f4, $f8, $05, $00 ; entry 1
    db $ec, $00, $04, $20 ; entry 2
    db $f4, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set12; ends with $80 (E-0147)
MetaSprites7FTable_2Set12Frame3::
    db $ed, $f8, $06, $00 ; entry 0
    db $f5, $f8, $07, $00 ; entry 1
    db $ed, $00, $06, $20 ; entry 2
    db $f5, $00, $07, $20 ; entry 3
    db $80 ; end

; meta-sprite set 19 of MetaSprites7FTable_2: 4 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set13::
    dw MetaSprites7FTable_2Set13Frame0 ; entry 0
    dw MetaSprites7FTable_2Set13Frame1 ; entry 1
    dw MetaSprites7FTable_2Set13Frame2 ; entry 2
    dw MetaSprites7FTable_2Set13Frame3 ; entry 3

; frame 0 of MetaSprites7FTable_2Set13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set13Frame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set13; ends with $80 (E-0147)
MetaSprites7FTable_2Set13Frame1::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set13; ends with $80 (E-0147)
MetaSprites7FTable_2Set13Frame2::
    db $f8, $f8, $0a, $00 ; entry 0
    db $f8, $00, $0b, $00 ; entry 1
    db $f0, $f8, $08, $00 ; entry 2
    db $f0, $00, $09, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set13; ends with $80 (E-0147)
MetaSprites7FTable_2Set13Frame3::
    db $f8, $f8, $0e, $00 ; entry 0
    db $f8, $00, $0f, $00 ; entry 1
    db $f0, $f8, $0c, $00 ; entry 2
    db $f0, $00, $0d, $00 ; entry 3
    db $80 ; end

; meta-sprite set 20 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set14::
    dw MetaSprites7FTable_2Set14Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set14Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 21 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set15::
    dw MetaSprites7FTable_2Set15Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set15; ends with $80 (E-0147)
MetaSprites7FTable_2Set15Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 22 of MetaSprites7FTable_2: 2 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set16::
    dw MetaSprites7FTable_2Set16Frame0 ; entry 0
    dw MetaSprites7FTable_2Set16Frame1 ; entry 1

; frame 0 of MetaSprites7FTable_2Set16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set16Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set16; ends with $80 (E-0147)
MetaSprites7FTable_2Set16Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 23 of MetaSprites7FTable_2: 3 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set17::
    dw MetaSprites7FTable_2Set17Frame0 ; entry 0
    dw MetaSprites7FTable_2Set17Frame1 ; entry 1
    dw MetaSprites7FTable_2Set17Frame2 ; entry 2

; frame 0 of MetaSprites7FTable_2Set17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set17Frame0::
    db $ef, $f8, $00, $00 ; entry 0
    db $ef, $00, $01, $00 ; entry 1
    db $f7, $f8, $02, $00 ; entry 2
    db $f7, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set17; ends with $80 (E-0147)
MetaSprites7FTable_2Set17Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set17; ends with $80 (E-0147)
MetaSprites7FTable_2Set17Frame2::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 24 of MetaSprites7FTable_2: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set18::
    dw MetaSprites7FTable_2Set18Frame0 ; entry 0
    dw MetaSprites7FTable_2Set18Frame1 ; entry 1
    dw MetaSprites7FTable_2Set18Frame2 ; entry 2
    dw MetaSprites7FTable_2Set18Frame3 ; entry 3
    dw MetaSprites7FTable_2Set18Frame4 ; entry 4
    dw MetaSprites7FTable_2Set18Frame5 ; entry 5

; frame 0 of MetaSprites7FTable_2Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set18Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set18; ends with $80 (E-0147)
MetaSprites7FTable_2Set18Frame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $04, $00 ; entry 1
    db $f8, $f8, $04, $00 ; entry 2
    db $f8, $00, $04, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set18; ends with $80 (E-0147)
MetaSprites7FTable_2Set18Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set18; ends with $80 (E-0147)
MetaSprites7FTable_2Set18Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set18Frame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set18; ends with $80 (E-0147)
MetaSprites7FTable_2Set18Frame5::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 25 of MetaSprites7FTable_2: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set19::
    dw MetaSprites7FTable_2Set19Frame0 ; entry 0
    dw MetaSprites7FTable_2Set19Frame1 ; entry 1
    dw MetaSprites7FTable_2Set19Frame2 ; entry 2
    dw MetaSprites7FTable_2Set19Frame3 ; entry 3
    dw MetaSprites7FTable_2Set19Frame4 ; entry 4
    dw MetaSprites7FTable_2Set19Frame5 ; entry 5

; frame 0 of MetaSprites7FTable_2Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set19Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set19; ends with $80 (E-0147)
MetaSprites7FTable_2Set19Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set19; ends with $80 (E-0147)
MetaSprites7FTable_2Set19Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set19; ends with $80 (E-0147)
MetaSprites7FTable_2Set19Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set19Frame4::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set19; ends with $80 (E-0147)
MetaSprites7FTable_2Set19Frame5::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 26 of MetaSprites7FTable_2: 2 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set1A::
    dw MetaSprites7FTable_2Set1AFrame0 ; entry 0
    dw MetaSprites7FTable_2Set1AFrame1 ; entry 1

; frame 0 of MetaSprites7FTable_2Set1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1AFrame0::
    db $f8, $f8, $02, $00 ; entry 0
    db $f8, $00, $03, $00 ; entry 1
    db $f0, $f8, $00, $00 ; entry 2
    db $f0, $00, $01, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set1A; ends with $80 (E-0147)
MetaSprites7FTable_2Set1AFrame1::
    db $f8, $f8, $06, $00 ; entry 0
    db $f8, $00, $07, $00 ; entry 1
    db $f0, $f8, $04, $00 ; entry 2
    db $f0, $00, $05, $00 ; entry 3
    db $80 ; end

; meta-sprite set 27 of MetaSprites7FTable_2: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set1B::
    dw MetaSprites7FTable_2Set1BFrame0 ; entry 0
    dw MetaSprites7FTable_2Set1BFrame1 ; entry 1
    dw MetaSprites7FTable_2Set1BFrame2 ; entry 2
    dw MetaSprites7FTable_2Set1BFrame3 ; entry 3
    dw MetaSprites7FTable_2Set1BFrame4 ; entry 4
    dw MetaSprites7FTable_2Set1BFrame5 ; entry 5

; frame 0 of MetaSprites7FTable_2Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1BFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set1B; ends with $80 (E-0147)
MetaSprites7FTable_2Set1BFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set1B; ends with $80 (E-0147)
MetaSprites7FTable_2Set1BFrame2::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set1B; ends with $80 (E-0147)
MetaSprites7FTable_2Set1BFrame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1BFrame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set1B; ends with $80 (E-0147)
MetaSprites7FTable_2Set1BFrame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 28 of MetaSprites7FTable_2: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set1C::
    dw MetaSprites7FTable_2Set1CFrame0 ; entry 0
    dw MetaSprites7FTable_2Set1CFrame1 ; entry 1
    dw MetaSprites7FTable_2Set1CFrame2 ; entry 2
    dw MetaSprites7FTable_2Set1CFrame3 ; entry 3
    dw MetaSprites7FTable_2Set1CFrame4 ; entry 4
    dw MetaSprites7FTable_2Set1CFrame5 ; entry 5

; frame 0 of MetaSprites7FTable_2Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1CFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set1C; ends with $80 (E-0147)
MetaSprites7FTable_2Set1CFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set1C; ends with $80 (E-0147)
MetaSprites7FTable_2Set1CFrame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set1C; ends with $80 (E-0147)
MetaSprites7FTable_2Set1CFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1CFrame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set1C; ends with $80 (E-0147)
MetaSprites7FTable_2Set1CFrame5::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 29 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set1D::
    dw MetaSprites7FTable_2Set1DFrame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1DFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 30 of MetaSprites7FTable_2: 4 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set1E::
    dw MetaSprites7FTable_2Set1EFrame0 ; entry 0
    dw MetaSprites7FTable_2Set1EFrame1 ; entry 1
    dw MetaSprites7FTable_2Set1EFrame2 ; entry 2
    dw MetaSprites7FTable_2Set1EFrame3 ; entry 3

; frame 0 of MetaSprites7FTable_2Set1E; ends with $80 (E-0147)
MetaSprites7FTable_2Set1EFrame0::
    db $f4, $fc, $00, $00 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set1E; ends with $80 (E-0147)
MetaSprites7FTable_2Set1EFrame1::
    db $f4, $fc, $01, $00 ; entry 0
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1EFrame2::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $ff, $02, $20 ; entry 2
    db $f8, $ff, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set1E; ends with $80 (E-0147)
MetaSprites7FTable_2Set1EFrame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $ff, $04, $20 ; entry 1
    db $f8, $f8, $05, $00 ; entry 2
    db $f8, $ff, $05, $20 ; entry 3
    db $80 ; end

; meta-sprite set 31 of MetaSprites7FTable_2: 32 frame pointer(s), chosen by hSpriteSubIndex
; (E-0147)
; record: frame
MetaSprites7FTable_2Set1F::
    dw MetaSprites7FTable_2Set1FFrame0 ; entry 0
    dw MetaSprites7FTable_2Set1FFrame1 ; entry 1
    dw MetaSprites7FTable_2Set1FFrame2 ; entry 2
    dw MetaSprites7FTable_2Set1FFrame3 ; entry 3
    dw MetaSprites7FTable_2Set1FFrame4 ; entry 4
    dw MetaSprites7FTable_2Set1FFrame5 ; entry 5
    dw MetaSprites7FTable_2Set1FFrame6 ; entry 6
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 7
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 8
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 9
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 10
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 11
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 12
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 13
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 14
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 15
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 16
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 17
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 18
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 19
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 20
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 21
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 22
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 23
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 24
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 25
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 26
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 27
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 28
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 29
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 30
    dw MetaSprites7FTable_2Set1FFrame7 ; entry 31

; frame 0 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1FFrame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
MetaSprites7FTable_2Set1FFrame1::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
MetaSprites7FTable_2Set1FFrame2::
    db $f0, $00, $04, $20 ; entry 0
    db $f0, $f8, $05, $20 ; entry 1
    db $f8, $00, $06, $20 ; entry 2
    db $f8, $f8, $07, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
MetaSprites7FTable_2Set1FFrame3::
    db $f0, $f8, $08, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f8, $f8, $0a, $00 ; entry 2
    db $f8, $00, $0b, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set1FFrame4::
    db $f0, $f8, $0c, $00 ; entry 0
    db $f0, $00, $0d, $00 ; entry 1
    db $f8, $f8, $0e, $00 ; entry 2
    db $f8, $00, $0f, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
MetaSprites7FTable_2Set1FFrame5::
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

; frame 6 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
MetaSprites7FTable_2Set1FFrame6::
    db $f0, $f8, $10, $00 ; entry 0
    db $f0, $00, $11, $00 ; entry 1
    db $f8, $f8, $14, $00 ; entry 2
    db $f8, $00, $15, $00 ; entry 3
    db $f8, $08, $1a, $00 ; entry 4
    db $f9, $ef, $16, $00 ; entry 5
    db $f8, $0c, $17, $00 ; entry 6
    db $80 ; end

; frame 7 of MetaSprites7FTable_2Set1F; ends with $80 (E-0147)
MetaSprites7FTable_2Set1FFrame7::
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

; meta-sprite set 32 of MetaSprites7FTable_2: 7 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set20::
    dw MetaSprites7FTable_2Set20Frame0 ; entry 0
    dw MetaSprites7FTable_2Set20Frame1 ; entry 1
    dw MetaSprites7FTable_2Set20Frame2 ; entry 2
    dw MetaSprites7FTable_2Set20Frame3 ; entry 3
    dw MetaSprites7FTable_2Set20Frame4 ; entry 4
    dw MetaSprites7FTable_2Set20Frame5 ; entry 5
    dw MetaSprites7FTable_2Set20Frame6 ; entry 6

; frame 0 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set20Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $00, $00, $20 ; entry 2
    db $f8, $00, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
MetaSprites7FTable_2Set20Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f8, $f8, $03, $00 ; entry 1
    db $f0, $00, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
MetaSprites7FTable_2Set20Frame2::
    db $f0, $f8, $04, $00 ; entry 0
    db $f8, $f8, $05, $00 ; entry 1
    db $f0, $00, $04, $20 ; entry 2
    db $f8, $00, $05, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
MetaSprites7FTable_2Set20Frame3::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $f8, $08, $00 ; entry 2
    db $f8, $00, $08, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set20Frame4::
    db $f0, $f8, $09, $00 ; entry 0
    db $f0, $00, $0a, $00 ; entry 1
    db $f8, $f8, $0b, $00 ; entry 2
    db $f8, $00, $0b, $20 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
MetaSprites7FTable_2Set20Frame5::
    db $f0, $00, $06, $20 ; entry 0
    db $f0, $f8, $07, $20 ; entry 1
    db $f8, $00, $08, $20 ; entry 2
    db $f8, $f8, $08, $00 ; entry 3
    db $80 ; end

; frame 6 of MetaSprites7FTable_2Set20; ends with $80 (E-0147)
MetaSprites7FTable_2Set20Frame6::
    db $f0, $00, $09, $20 ; entry 0
    db $f0, $f8, $0a, $20 ; entry 1
    db $f8, $00, $0b, $20 ; entry 2
    db $f8, $f8, $0b, $00 ; entry 3
    db $80 ; end

; meta-sprite set 33 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set21::
    dw MetaSprites7FTable_2Set21Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set21Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 34 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set22::
    dw MetaSprites7FTable_2Set22Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set22; ends with $80 (E-0147)
MetaSprites7FTable_2Set22Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; meta-sprite set 35 of MetaSprites7FTable_2: 5 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set23::
    dw MetaSprites7FTable_2Set23Frame0 ; entry 0
    dw MetaSprites7FTable_2Set23Frame1 ; entry 1
    dw MetaSprites7FTable_2Set23Frame2 ; entry 2
    dw MetaSprites7FTable_2Set23Frame3 ; entry 3
    dw MetaSprites7FTable_2Set23Frame4 ; entry 4

; frame 0 of MetaSprites7FTable_2Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set23Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f0, $ff, $00, $20 ; entry 2
    db $f8, $ff, $01, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set23; ends with $80 (E-0147)
MetaSprites7FTable_2Set23Frame1::
    db $f0, $f8, $02, $00 ; entry 0
    db $f0, $00, $03, $00 ; entry 1
    db $f8, $00, $02, $60 ; entry 2
    db $f8, $f8, $03, $60 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set23; ends with $80 (E-0147)
MetaSprites7FTable_2Set23Frame2::
    db $f0, $00, $02, $20 ; entry 0
    db $f0, $f8, $03, $20 ; entry 1
    db $f8, $f8, $02, $40 ; entry 2
    db $f8, $00, $03, $40 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set23; ends with $80 (E-0147)
MetaSprites7FTable_2Set23Frame3::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $00, $04, $60 ; entry 2
    db $f8, $f8, $05, $60 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set23Frame4::
    db $f0, $f8, $06, $00 ; entry 0
    db $f0, $00, $07, $00 ; entry 1
    db $f8, $00, $06, $60 ; entry 2
    db $f8, $f8, $07, $60 ; entry 3
    db $80 ; end

; meta-sprite set 36 of MetaSprites7FTable_2: 5 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set24::
    dw MetaSprites7FTable_2Set24Frame0 ; entry 0
    dw MetaSprites7FTable_2Set24Frame1 ; entry 1
    dw MetaSprites7FTable_2Set24Frame2 ; entry 2
    dw MetaSprites7FTable_2Set24Frame3 ; entry 3
    dw MetaSprites7FTable_2Set24Frame4 ; entry 4

; frame 0 of MetaSprites7FTable_2Set24; ends with $80 (E-0147)
MetaSprites7FTable_2Set24Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set24Frame1::
    db $f0, $f9, $04, $00 ; entry 0
    db $f0, $01, $05, $00 ; entry 1
    db $f8, $f9, $06, $00 ; entry 2
    db $f8, $01, $07, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set24; ends with $80 (E-0147)
MetaSprites7FTable_2Set24Frame2::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $00, $02, $20 ; entry 2
    db $f8, $f8, $03, $20 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set24; ends with $80 (E-0147)
MetaSprites7FTable_2Set24Frame3::
    db $f0, $01, $04, $20 ; entry 0
    db $f0, $f9, $05, $20 ; entry 1
    db $f8, $01, $06, $20 ; entry 2
    db $f8, $f9, $07, $20 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set24; ends with $80 (E-0147)
MetaSprites7FTable_2Set24Frame4::
    db $f0, $f8, $04, $00 ; entry 0
    db $f0, $00, $05, $00 ; entry 1
    db $f8, $f8, $06, $00 ; entry 2
    db $f8, $00, $07, $00 ; entry 3
    db $80 ; end

; meta-sprite set 37 of MetaSprites7FTable_2: 5 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set25::
    dw MetaSprites7FTable_2Set25Frame0 ; entry 0
    dw MetaSprites7FTable_2Set25Frame1 ; entry 1
    dw MetaSprites7FTable_2Set25Frame1 ; entry 2
    dw MetaSprites7FTable_2Set25Frame2 ; entry 3
    dw MetaSprites7FTable_2Set25Frame3 ; entry 4

; frame 0 of MetaSprites7FTable_2Set25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set25Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set25; ends with $80 (E-0147)
MetaSprites7FTable_2Set25Frame1::
    db $f0, $f8, $01, $00 ; entry 0
    db $f0, $00, $02, $00 ; entry 1
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set25; ends with $80 (E-0147)
MetaSprites7FTable_2Set25Frame2::
    db $f0, $f9, $03, $00 ; entry 0
    db $f0, $01, $04, $00 ; entry 1
    db $f8, $f9, $05, $00 ; entry 2
    db $f8, $01, $06, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set25; ends with $80 (E-0147)
MetaSprites7FTable_2Set25Frame3::
    db $f8, $00, $07, $00 ; entry 0
    db $f8, $f8, $05, $00 ; entry 1
    db $80 ; end

; meta-sprite set 38 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set26::
    dw MetaSprites7FTable_2Set26Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set26Frame0::
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; meta-sprite set 39 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set27::
    dw MetaSprites7FTable_2Set27Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set27; ends with $80 (E-0147)
MetaSprites7FTable_2Set27Frame0::
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; meta-sprite set 40 of MetaSprites7FTable_2: 1 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites7FTable_2Set28::
    dw MetaSprites7FTable_2Set28Frame0 ; entry 0

; frame 0 of MetaSprites7FTable_2Set28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set28Frame0::
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; meta-sprite set 41 of MetaSprites7FTable_2: 6 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
MetaSprites7FTable_2Set29::
    dw MetaSprites7FTable_2Set29Frame0 ; entry 0
    dw MetaSprites7FTable_2Set29Frame1 ; entry 1
    dw MetaSprites7FTable_2Set29Frame2 ; entry 2
    dw MetaSprites7FTable_2Set29Frame3 ; entry 3
    dw MetaSprites7FTable_2Set29Frame4 ; entry 4
    dw MetaSprites7FTable_2Set29Frame5 ; entry 5

; frame 0 of MetaSprites7FTable_2Set29; ends with $80 (E-0147)
MetaSprites7FTable_2Set29Frame0::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites7FTable_2Set29; ends with $80 (E-0147)
MetaSprites7FTable_2Set29Frame1::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites7FTable_2Set29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7FTable_2Set29Frame2::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites7FTable_2Set29; ends with $80 (E-0147)
MetaSprites7FTable_2Set29Frame3::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites7FTable_2Set29; ends with $80 (E-0147)
MetaSprites7FTable_2Set29Frame4::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites7FTable_2Set29; ends with $80 (E-0147)
MetaSprites7FTable_2Set29Frame5::
    db $f0, $f8, $00, $00 ; entry 0
    db $f0, $00, $01, $00 ; entry 1
    db $f8, $f8, $02, $00 ; entry 2
    db $f8, $00, $03, $00 ; entry 3
    db $80 ; end
    ds $46a, $00
