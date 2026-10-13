; ROM bank $E1: screen graphics, tiles and palettes
; The annotated listing of this bank is build/listing/banke1.asm.

SECTION "Bank E1", ROMX[$4000], BANK[$E1]
    db $e1

; LZSS-compressed: 213 bytes that expand to 304 (E-0016, E-0017)
Tiles2Gfx_E1_4001::
    INCBIN "gfx/misc/tiles2_gfx_e1_4001.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
ScreenTileBufferGfx_E1_40D6::
    db $68, $01, $13, $13, $a0, $ff, $4d, $13, $41, $0f, $2e, $01, $02, $03, $04, $05
    db $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $41, $0f
    db $4d, $13, $12, $1f, $42

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
ScreenAttrBufferGfx_E1_40FB::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

BGPaletteBufferData_E1_410E::
    db $b5, $56, $ff, $7f, $d7, $56, $00, $00

; LZSS-compressed: 1169 bytes that expand to 1600 (E-0016, E-0017)
Tiles2Gfx_E1_4116::
    INCBIN "gfx/misc/tiles2_gfx_e1_4116.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
ScreenTileBufferGfx_E1_45A7::
    INCBIN "gfx/misc/screen_tile_buffer_gfx_e1_45_a7.lz"

ScreenAttrBufferGfx_E1_45FC::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

BGPaletteBufferData_E1_460F::
    db $60, $31, $b5, $56, $e8, $62, $00, $00

; LZSS-compressed: 815 bytes that expand to 1552 (E-0016, E-0017)
Tiles2Gfx_E1_4617::
    INCBIN "gfx/misc/tiles2_gfx_e1_4617.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
ScreenTileBufferGfx_E1_4946::
    INCBIN "gfx/misc/screen_tile_buffer_gfx_e1_4946.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
ScreenAttrBufferGfx_E1_49BE::
    db $68, $01, $00, $08, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

BGPaletteBufferData_E1_49D2::
    db $0f, $3e, $bf, $73, $d7, $56, $00, $00

; LZSS-compressed: 1165 bytes that expand to 2048 (E-0016, E-0017)
Tiles1Gfx_E1_49DA::
    INCBIN "gfx/misc/tiles1_gfx_e1_49_da.lz"

; LZSS-compressed: 1438 bytes that expand to 2048 (E-0016, E-0017)
Tiles2Gfx_E1_4E67::
    INCBIN "gfx/misc/tiles2_gfx_e1_4_e67.lz"

; LZSS-compressed: 887 bytes that expand to 1152 (E-0016, E-0017)
Tiles2Gfx_E1_5405::
    INCBIN "gfx/misc/tiles2_gfx_e1_5405.lz"

; LZSS-compressed: 175 bytes that expand to 256 (E-0016, E-0017)
Tiles0Gfx_E1_577C::
    INCBIN "gfx/misc/tiles0_gfx_e1_577_c.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
ScreenTileBufferGfx_E1_582B::
    INCBIN "gfx/misc/screen_tile_buffer_gfx_e1_582_b.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
ScreenAttrBufferGfx_E1_58C3::
    INCBIN "gfx/misc/screen_attr_buffer_gfx_e1_58_c3.lz"

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
ScreenTileBufferGfx_E1_590F::
    INCBIN "gfx/misc/screen_tile_buffer_gfx_e1_590_f.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
ScreenAttrBufferGfx_E1_5974::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 112 bytes that expand to 1024 (E-0016, E-0017)
BGMap0Gfx_E1_5987::
    INCBIN "gfx/misc/bgmap0_gfx_e1_5987.lz"

; LZSS-compressed: 48 bytes that expand to 1024 (E-0016, E-0017)
BGMap0Gfx_E1_59F7::
    db $00, $04, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $20, $1f, $4d, $00, $80, $1f, $4d, $00, $e0, $1f, $4d, $00, $40, $2f, $4d
    db $00, $a0, $2f, $4d, $00, $00, $3f, $4d, $00, $60, $3f, $4d, $00, $a0, $3f, $2c

BGPaletteBufferData_E1_5A27::
    db $0f, $54, $ff, $7f, $1f, $13, $aa, $04, $0f, $54, $ff, $7f, $1f, $13, $d5, $09
    db $33, $05, $ff, $03, $bd, $21, $aa, $04, $33, $05, $ff, $7f, $1f, $13, $aa, $04
    db $33, $05, $ff, $7f, $bd, $21, $aa, $04, $36, $04, $ff, $7f, $1f, $13, $aa, $04
    db $36, $04, $ff, $7f, $1f, $13, $d5, $09, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f

BGPaletteBufferData_E1_5A67::
    db $0f, $54, $ff, $7f, $1f, $13, $aa, $04, $0f, $54, $ff, $7f, $1f, $13, $d5, $09
    db $33, $05, $ff, $03, $bd, $21, $aa, $04, $33, $05, $ff, $7f, $1f, $13, $aa, $04
    db $33, $05, $ff, $7f, $bd, $21, $aa, $04, $36, $04, $ff, $7f, $1f, $13, $aa, $04
    db $36, $04, $ff, $7f, $1f, $13, $d5, $09, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f

OBJPaletteBufferData_E1_5AA7::
    db $20, $7c, $ff, $7f, $a8, $14, $00, $00, $20, $7c, $ff, $7f, $35, $04, $00, $00

; runs RunE15AC0For5ABE_WaitOamNextEntry with DE = RunE15AC0For5ABE_Data (E-0122)
RunE15AC0For5ABE::
    ld de, RunE15AC0For5ABE_Data
    call RunE15AC0For5ABE_WaitOamNextEntry
    ret

RunE15AC0For5ABE_Data::
    db $3c, $5d

RunE15AC0For5ABE_WaitOamNextEntry::
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
    call BGTileUnderPointIsSpriteHideTile_BankE1
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
    call BGTileUnderPointIsSpriteHideTile_BankE1
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
BGTileUnderPointIsSpriteHideTile_BankE1::
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

; shape only; no reference found and the bytes occur nowhere else in the ROM; two words point at the
; two frames that follow, each laid out as the E-0147 meta-sprite frames: 4-byte sprites (Y offset,
; X offset, tile, attribute) ending with $80 (E-0236, C1)
; record: frame
UnreferencedMetaSpriteSet_E1::
    dw UnreferencedMetaSpriteSet_E1_Frame0 ; id 0
    dw UnreferencedMetaSpriteSet_E1_Frame1 ; id 1

; shape only; frame 0 of UnreferencedMetaSpriteSet_E1; ends with $80 (E-0236, C1)
; record: sprite: Y offset, X offset, tile, attribute
UnreferencedMetaSpriteSet_E1_Frame0::
    db $f0, $25, $0b, $01 ; entry 0
    db $08, $15, $05, $00 ; entry 1
    db $08, $08, $07, $00 ; entry 2
    db $10, $08, $09, $00 ; entry 3
    db $10, $10, $0a, $00 ; entry 4
    db $10, $01, $07, $00 ; entry 5
    db $18, $03, $07, $00 ; entry 6
    db $18, $ff, $08, $00 ; entry 7
    db $f8, $18, $0c, $00 ; entry 8
    db $f8, $28, $0d, $00 ; entry 9
    db $00, $1b, $0e, $00 ; entry 10
    db $00, $28, $0f, $00 ; entry 11
    db $80 ; end

; shape only; frame 1 of UnreferencedMetaSpriteSet_E1; ends with $80 (E-0236, C1)
UnreferencedMetaSpriteSet_E1_Frame1::
    db $f7, $1f, $0b, $01 ; entry 0
    db $f0, $20, $00, $00 ; entry 1
    db $f8, $18, $01, $00 ; entry 2
    db $f8, $20, $02, $00 ; entry 3
    db $f8, $28, $03, $00 ; entry 4
    db $00, $1b, $04, $00 ; entry 5
    db $08, $15, $05, $00 ; entry 6
    db $02, $28, $06, $00 ; entry 7
    db $08, $08, $07, $00 ; entry 8
    db $10, $08, $09, $00 ; entry 9
    db $10, $10, $0a, $00 ; entry 10
    db $10, $01, $07, $00 ; entry 11
    db $18, $03, $07, $00 ; entry 12
    db $18, $ff, $08, $00 ; entry 13
    db $80 ; end

; Super Game Boy border set 4: border tiles $00-$7F (4096 bytes, sent with packet set $10);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3046 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py,
; E-0016/E-0017; C1)
SGBBorder4TilesA::
    INCBIN "gfx/sgb_border/4_tiles_a.lz"

; Super Game Boy border set 4: border tiles $80-$FF (4096 bytes, packet set $11);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3410 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py,
; E-0016/E-0017; C1)
SGBBorder4TilesB::
    INCBIN "gfx/sgb_border/4_tiles_b.lz"

; Super Game Boy border set 4: border map and palettes ($880 bytes, packet set $0F);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed: 1133 bytes that expand to 2176 (E-0016, E-0017)
SGBBorder4MapAndPalettes::
    INCBIN "gfx/sgb_border/4_map_and_palettes.lz"
    ds $4a9, $00
