; ROM bank $71: key-world map screens
; The annotated listing of this bank is build/listing/bank71.asm.

SECTION "Bank 71", ROMX[$4000], BANK[$71]
    db $71

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room05_y1_x1_tiles.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X3_Tiles::
    INCBIN "maps/key_worlds/room00_y3_x3_tiles.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room08_y3_x1_tiles.lz"

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y3X0_Tiles::
    INCBIN "maps/key_worlds/room0_b_y3_x0_tiles.lz"

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room11_y2_x2_tiles.lz"

KeyWorldRoom24_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room24_y1_x0_tiles.lz"

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3A_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room3_a_y3_x1_tiles.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom12_Y3X3_Tiles::
    INCBIN "maps/key_worlds/room12_y3_x3_tiles.lz"

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_45D1::
    INCBIN "maps/screen_maps/71_45_d1.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_463A::
    INCBIN "maps/screen_maps/71_463_a.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_46F8::
    INCBIN "maps/screen_maps/71_46_f8.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_47D2::
    INCBIN "maps/screen_maps/71_47_d2.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room06_y3_x1_tiles.lz"

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom76_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room76_y2_x1_tiles.lz"

; LZSS-compressed: 240 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom61_Y3X2_Tiles::
    INCBIN "maps/key_worlds/room61_y3_x2_tiles.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room0_d_y3_x1_tiles.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y1X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $39, $00, $ba, $00, $00, $10, $1f
    db $13, $00, $38, $1f, $0b

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X3_Attrs::
    INCBIN "maps/key_worlds/room00_y3_x3_attrs.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room08_y3_x1_attrs.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y3X0_Attrs::
    INCBIN "maps/key_worlds/room0_b_y3_x0_attrs.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y2X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $03, $00, $08, $00, $00, $2a, $08, $00, $26, $0f, $05, $00, $28, $04, $00
    db $0e, $0e, $00, $0a, $0f, $0d, $00, $02, $0f, $07, $00, $06, $00, $00, $96, $0f
    db $13, $00, $cf, $0f, $4d, $00, $08, $1f, $25

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom24_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room24_y1_x0_attrs.lz"

KeyWorldRoom3A_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room3_a_y3_x1_attrs.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom12_Y3X3_Attrs::
    INCBIN "maps/key_worlds/room12_y3_x3_attrs.lz"

; LZSS-compressed: 664 bytes that expand to 771 (E-0016, E-0017)
Gfx_71_4E34::
    INCBIN "gfx/misc/gfx_71_4_e34.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room06_y3_x1_attrs.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom76_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room76_y2_x1_attrs.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom61_Y3X2_Attrs::
    INCBIN "maps/key_worlds/room61_y3_x2_attrs.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room0_d_y3_x1_attrs.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y0X0_Tiles::
    INCBIN "maps/key_worlds/room02_y0_x0_tiles.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y0X0_Tiles::
    INCBIN "maps/key_worlds/room04_y0_x0_tiles.lz"

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y0X3_Tiles::
    INCBIN "maps/key_worlds/room1_d_y0_x3_tiles.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room10_y0_x1_tiles.lz"

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room10_y0_x2_tiles.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom25_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room25_y0_x2_tiles.lz"

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room11_y0_x2_tiles.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom19_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room19_y1_x0_tiles.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_56B3::
    INCBIN "maps/screen_maps/71_56_b3.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_56FB::
    INCBIN "maps/screen_maps/71_56_fb.lz"

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_579C::
    INCBIN "maps/screen_maps/71_579_c.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_5868::
    INCBIN "maps/screen_maps/71_5868.lz"

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8A_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room8_a_y1_x1_tiles.lz"

; LZSS-compressed: 32 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y0X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $44, $01, $01, $01, $01, $00, $48, $0f, $13
    db $00, $46, $0f, $01, $00, $46, $0f, $29, $00, $be, $0f, $4d, $00, $f6, $0f, $23

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y0X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $01, $00, $52, $09, $00, $4c, $0f, $13
    db $00, $4a, $0f, $01, $00, $00, $04, $03, $03, $00, $90, $0f, $15, $00, $ca, $00
    db $00, $82, $08, $00, $c8, $0f, $09, $00, $ce, $0a, $00, $f2, $0f, $07, $00, $bc
    db $0f, $05, $00, $d2, $08, $00, $4e, $04, $00, $42, $0f, $01, $00, $00, $04

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y0X3_Attrs::
    INCBIN "maps/key_worlds/room1_d_y0_x3_attrs.lz"

KeyWorldRoom10_Y0X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $16, $01, $01, $00, $18, $0f, $4d, $00, $3c
    db $0f, $0d, $01, $01, $00, $3e, $04, $00, $a2, $0f, $03, $00, $ac, $04, $00, $c0
    db $0f, $0b, $03, $03, $00, $ca, $02, $00, $ca, $06, $00, $f0, $0f, $05, $00, $1a
    db $10, $00, $f6, $0a, $00, $1a, $1f, $01, $00, $a6, $0c, $00, $3e, $1f, $03

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y0X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $1a, $01, $00, $2e, $01, $00, $20, $0f, $35
    db $00, $2e, $02, $00, $30, $0a, $00, $7c, $0f, $01, $00, $7a, $06, $00, $9a, $0f
    db $39, $00, $1e, $0f, $01, $00, $00, $08, $03, $03, $03, $03, $00, $2e, $0c, $00
    db $1a, $1f, $01, $00, $f0, $0f, $13

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom25_Y0X2_Attrs::
    INCBIN "maps/key_worlds/room25_y0_x2_attrs.lz"

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y0X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4c, $01, $01, $00, $4e, $0f, $11, $01, $01
    db $00, $74, $0f, $09, $00, $86, $00, $00, $9c, $06, $00, $9e, $0f, $07, $00, $0c
    db $0f, $4d, $00, $58, $0f, $0b, $00, $74, $0f, $0b

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom19_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room19_y1_x0_attrs.lz"

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_5C00::
    db $68, $01, $03, $02, $03, $00, $0f, $1c, $01, $01, $01, $01, $03, $20, $0f, $4d
    db $03, $80, $0f, $4d, $03, $00, $00, $00, $02, $03, $ff, $fe, $03, $fc, $ff, $01
    db $03, $94, $0f, $35

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_5C24::
    INCBIN "maps/key_worlds/screen_71_5_c24.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_5C70::
    INCBIN "maps/key_worlds/screen_71_5_c70.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_5CC8::
    INCBIN "maps/key_worlds/screen_71_5_cc8.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8A_Y1X1_Attrs::
    INCBIN "maps/key_worlds/room8_a_y1_x1_attrs.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X2_Tiles::
    INCBIN "maps/key_worlds/room00_y3_x2_tiles.lz"

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0F_Y0X3_Tiles::
    INCBIN "maps/key_worlds/room0_f_y0_x3_tiles.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room06_y0_x1_tiles.lz"

; LZSS-compressed: 142 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom16_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room16_y2_x3_tiles.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom2D_Y0X3_Tiles::
    INCBIN "maps/key_worlds/room2_d_y0_x3_tiles.lz"

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom32_Y0X3_Tiles::
    INCBIN "maps/key_worlds/room32_y0_x3_tiles.lz"

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1E_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room1_e_y0_x1_tiles.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom25_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room25_y0_x1_tiles.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_62DF::
    INCBIN "maps/screen_maps/71_62_df.lz"

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_6338::
    INCBIN "maps/screen_maps/71_6338.lz"

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_63ED::
    INCBIN "maps/screen_maps/71_63_ed.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_64BE::
    INCBIN "maps/screen_maps/71_64_be.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room1_b_y0_x1_tiles.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom5A_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room5_a_y1_x2_tiles.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room06_y2_x3_tiles.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room37_y2_x3_tiles.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $00, $78, $0d
    db $00, $76, $0f, $4d, $00, $86, $02, $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0F_Y0X3_Attrs::
    INCBIN "maps/key_worlds/room0_f_y0_x3_attrs.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y0X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $16, $01, $01, $01, $01, $00, $1a, $0f, $15
    db $00, $2a, $0c, $00, $52, $0e, $00, $52, $04, $00, $6c, $0f, $0f, $00, $4c, $08
    db $03, $03, $00, $9c, $0f, $07, $00, $c8, $08, $00, $c2, $0f, $07, $00, $a6, $06
    db $00, $f8, $02, $00, $ec, $0f, $07, $00, $14, $1f, $3b

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom16_Y2X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $18, $01, $00, $2c, $09, $00, $26, $0f, $05
    db $00, $2c, $02, $03, $00, $58, $03, $00, $4c, $0f, $05, $00, $2c, $04, $03, $03
    db $00, $00, $00, $00, $72, $0f, $4d, $00, $82, $06, $00, $50, $0f, $15, $00, $28
    db $0f, $17, $00, $00, $0f, $13

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom2D_Y0X3_Attrs::
    INCBIN "maps/key_worlds/room2_d_y0_x3_attrs.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom32_Y0X3_Attrs::
    INCBIN "maps/key_worlds/room32_y0_x3_attrs.lz"

KeyWorldRoom1E_Y0X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $48, $01, $00, $5c, $01, $00, $4e, $0f, $03
    db $00, $5e, $06, $00, $78, $0f, $15, $00, $5a, $00, $00, $9a, $0f, $0b, $00, $5e
    db $04, $00, $cc, $08, $00, $cc, $0c, $00, $6e, $0a, $00, $d4, $0a, $00, $c6, $0a
    db $00, $50, $0c, $00, $16, $1f, $11, $00, $00, $0f, $07

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom25_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room25_y0_x1_attrs.lz"

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_6A83::
    db $68, $01, $03, $02, $03, $00, $0f, $4d, $03, $18, $0f, $04, $01, $03, $78, $03
    db $00, $03, $77, $05, $03, $76, $07, $00, $03, $82, $0f, $00, $03, $81, $0f, $16
    db $03, $d0, $00, $03, $86, $0c, $03, $fc, $f0, $03, $86, $02, $03, $ef, $0f, $4d
    db $03, $08, $1f, $05

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_6AB7::
    INCBIN "maps/key_worlds/screen_71_6_ab7.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_6B1D::
    INCBIN "maps/key_worlds/screen_71_6_b1_d.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_6B6E::
    INCBIN "maps/key_worlds/screen_71_6_b6_e.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room1_b_y0_x1_attrs.lz"

KeyWorldRoom5A_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room5_a_y1_x2_attrs.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y2X3_Attrs::
    INCBIN "maps/key_worlds/room06_y2_x3_attrs.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y2X3_Attrs::
    INCBIN "maps/key_worlds/room37_y2_x3_attrs.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room02_y0_x1_tiles.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room04_y1_x1_tiles.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room04_y0_x1_tiles.lz"

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom19_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room19_y0_x2_tiles.lz"

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room04_y2_x1_tiles.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room1_b_y3_x1_tiles.lz"

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room1_d_y3_x1_tiles.lz"

KeyWorldRoom3A_Y3X2_Tiles::
    INCBIN "maps/key_worlds/room3_a_y3_x2_tiles.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_7293::
    INCBIN "maps/screen_maps/71_7293.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_72E6::
    INCBIN "maps/screen_maps/71_72_e6.lz"

ScreenMap_71_737A::
    INCBIN "maps/screen_maps/71_737_a.lz"

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_7456::
    INCBIN "maps/screen_maps/71_7456.lz"

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom14_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room14_y2_x1_tiles.lz"

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom53_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room53_y1_x0_tiles.lz"

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_76FE::
    INCBIN "maps/screen_maps/71_76_fe.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_71_77EC::
    INCBIN "maps/screen_maps/71_77_ec.lz"

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y0X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $01, $00, $7e, $09
    db $00, $78, $0f, $4d, $00, $88, $06, $00, $f5, $0f, $4d, $00, $08, $1e

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y1X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4a, $01, $01, $01, $01, $00, $4e, $0f, $07
    db $00, $5e, $00, $00, $7c, $08, $00, $78, $0f, $2d, $00, $78, $0c, $00, $c8, $0f
    db $09, $03, $03, $03, $03, $00, $c2, $0a, $00, $f6, $0f, $01, $00, $f8, $00, $00
    db $f8, $04, $00, $16, $1f, $09, $00, $00, $0f, $0f

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y0X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $1e, $01, $00, $32, $03, $00, $26, $0f, $31
    db $00, $32, $04, $00, $34, $08, $00, $7e, $0f, $4d, $00, $32, $0f, $39, $00, $00
    db $0f, $17

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom19_Y0X2_Attrs::
    INCBIN "maps/key_worlds/room19_y0_x2_attrs.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $16, $01, $01, $01, $01, $03, $03, $00, $2a
    db $00, $01, $01, $00, $22, $0f, $13, $00, $20, $0f, $01, $00, $20, $08, $00, $1e
    db $0c, $00, $78, $0f, $4d, $00, $88, $04, $00, $2c, $00, $00, $f6, $00, $00, $32
    db $06, $00, $f2, $0f, $01, $00, $2e, $02, $00, $0c, $1f, $0f, $00, $00, $0f, $13

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y3X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $1a, $01, $00, $2e, $07, $00, $26, $0f, $0d
    db $00, $1e, $0f, $01, $00, $5a, $0f, $07, $00, $7e, $0f, $4d, $00, $98, $0f, $05
    db $00, $60, $0f, $0b, $00, $0e, $1f, $37

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y3X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $20, $0f, $0c, $03, $03, $03, $03
    db $00, $20, $00, $01, $01, $01, $01, $00, $78, $0f, $03, $00, $8a, $02, $00, $94
    db $0f, $17, $00, $8a, $02, $00, $c4, $0f, $07, $00, $84, $04, $00, $88, $08, $00
    db $f2, $0f, $05, $00, $84, $0c, $00, $1a, $1f, $09, $00, $20, $0f, $0b

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3A_Y3X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $16, $01, $00, $2a, $0b, $00, $26, $0f, $05
    db $03, $03, $03, $03, $00, $42, $0f, $13, $00, $1e, $0c, $00, $78, $0f, $11, $00
    db $28, $00, $00, $a0, $0f, $2f, $00, $34, $06, $00, $00, $02, $00, $f2, $0f, $03
    db $00, $52, $04, $00, $10, $1f, $0b, $00, $00, $0f, $13

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7A3D::
    db $68, $01, $03, $02, $03, $00, $0f, $4d, $03, $1e, $0f, $0a, $01, $03, $7e, $01
    db $00, $03, $7d, $03, $03, $78, $09, $00, $03, $86, $0f, $00, $03, $85, $0f, $36
    db $03, $f5, $0f, $4d, $03, $08, $1e

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7A64::
    INCBIN "maps/key_worlds/screen_71_7_a64.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7AA7::
    INCBIN "maps/key_worlds/screen_71_7_aa7.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7AF1::
    INCBIN "maps/key_worlds/screen_71_7_af1.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom14_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room14_y2_x1_attrs.lz"

KeyWorldRoom53_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room53_y1_x0_attrs.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7BDD::
    INCBIN "maps/key_worlds/screen_71_7_bdd.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7C31::
    INCBIN "maps/key_worlds/screen_71_7_c31.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y1X0_Tiles::
    db $68, $01, $01, $20, $21, $01, $00, $0c, $00, $00, $30, $31, $01, $14, $0c, $01
    db $fe, $ff, $4d, $01, $5e, $0f, $4d, $01, $be, $0f, $47, $01, $3f, $1f, $15

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7C96::
    INCBIN "maps/key_worlds/screen_71_7_c96.lz"

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7D18::
    INCBIN "maps/key_worlds/screen_71_7_d18.lz"

KeyWorldScreen_71_7D92::
    INCBIN "maps/key_worlds/screen_71_7_d92.lz"

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_71_7E0C::
    INCBIN "maps/key_worlds/screen_71_7_e0_c.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room05_y1_x0_attrs.lz"
    ds $b9, $00
