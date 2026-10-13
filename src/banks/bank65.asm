SECTION "Bank 65", ROMX[$4000], BANK[$65]
    db $65

; entry 3 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes3::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $026e, $3f7f, $02f3, $0188 ; entry 1
    dw $0152, $3f7f, $0218, $00c8 ; entry 2
    dw $2130, $3f7f, $39d9, $00c8 ; entry 3
    dw $158f, $3fbf, $2ab7, $0000 ; entry 4
    dw $0171, $3fbf, $2a13, $0000 ; entry 5
    dw $0018, $3f7f, $0218, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_4041::
KeyWorld10_0_Y1X2_Header::
    db $06, $03, $08, $0b, $0d, $33, $2c, $00 ; entry 0

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194049, $7B

KeyWorldScreenHeader_65_40C4::
KeyWorld15_1_Y1X2_Header::
    db $07, $03, $08, $0b, $0d, $33, $2d, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld15_1_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1940CC, $A1

KeyWorldScreenHeader_65_416D::
KeyWorld3C_1_Y3X2_Header::
    db $05, $05, $08, $0b, $0d, $33, $2e, $00 ; entry 0

KeyWorld3C_1_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194175, $7B

KeyWorldScreenHeader_65_41F0::
KeyWorld1E_0_Y1X2_Header::
    db $00, $03, $08, $0b, $0d, $33, $2f, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1941F8, $99

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_4291::
KeyWorld23_0_Y1X3_Header::
    db $03, $03, $08, $0b, $0d, $33, $30, $00 ; entry 0

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194299, $85

KeyWorldScreenHeader_65_431E::
KeyWorld12_0_Y3X2_Header::
    db $00, $03, $08, $0b, $0d, $33, $31, $00 ; entry 0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194326, $97

KeyWorldScreenHeader_65_43BD::
KeyWorld00_0_Y1X2_Header::
    db $ff, $02, $0b, $0d, $0f, $33, $32, $00 ; entry 0

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1943C5, $96

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_445B::
KeyWorld32_1_Y2X0_Header::
    db $ff, $03, $08, $0b, $0d, $33, $33, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_1_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194463, $88

KeyWorldScreenHeader_65_44EB::
KeyWorld1F_1_Y0X2_Header::
    db $06, $02, $06, $09, $0d, $33, $34, $00 ; entry 0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1F_1_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1944F3, $CD

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $03, $00, $8e
    db $0f, $15, $00, $a0, $0e, $00, $c8, $0f, $05, $00, $a0, $0c, $00, $f0, $0f, $07
    db $00, $a0, $0a, $00, $18, $1f, $09, $00, $a0, $08, $00, $40, $1f, $01

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld15_1_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1945EE, $55

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_1_Y3X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $00, $a0, $03
    db $00, $94, $0f, $15, $00, $a6, $08, $00, $c8, $0f, $4d, $00, $00, $1f, $19

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $1c, $02, $00, $30, $01, $00, $22, $0f, $0b
    db $00, $30, $02, $00, $30, $0a, $00, $54, $0e, $00, $58, $0c, $00, $76, $0f, $03
    db $03, $03, $03, $03, $00, $34, $0c, $00, $a0, $0f, $05, $00, $a0, $00, $00, $bc
    db $0f, $3d, $00, $ce, $08, $00, $18, $1f, $29

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $03, $00, $8e
    db $0f, $4d, $00, $b2, $0f, $05, $00, $b4, $0e, $00, $18, $1f, $05, $00, $40, $12
    db $00, $36, $1f, $0b

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y3X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1946BF, $4C

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $44, $03, $03, $03, $03, $00, $48, $0f, $0f
    db $00, $58, $00, $00, $7e, $02, $00, $74, $0f, $05, $00, $5a, $00, $00, $7e, $06
    db $00, $9a, $0f, $09, $00, $80, $06, $00, $c0, $0f, $15, $00, $76, $0f, $17, $00
    db $fe, $0f, $2f

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_1_Y2X0_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $20, $0f, $0c, $02, $02, $02, $02
    db $00, $70, $0f, $09, $03, $03, $00, $9c, $02, $00, $a6, $00, $00, $80, $04, $00
    db $a0, $0f, $03, $00, $c8, $08, $00, $c2, $0f, $15, $00, $9a, $04, $00, $f2, $0f
    db $05, $00, $20, $0a, $00, $18, $1f, $07, $00, $1a, $1a, $00, $40, $1f, $01

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1F_1_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $19477D, $5B

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 7: entry 7 of KeyWorldTilesetTable,
; decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed: 1185 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles7::
    INCBIN "dwm2-cobi-us.gbc", $1947D8, $4A1

; entry 7 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes7::
    dw $1412, $7fff, $259f, $0063 ; entry 0
    dw $318c, $5ad6, $4631, $0000 ; entry 1
    dw $1415, $7dff, $7c18, $2c09 ; entry 2
    dw $318c, $5ad6, $4631, $0000 ; entry 3
    dw $318c, $5ad6, $2a13, $0000 ; entry 4
    dw $0171, $3fbf, $5294, $0000 ; entry 5
    dw $7da0, $3fbf, $5294, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_65_4CB9::
    db $03, $04, $06, $09, $0b, $33, $50, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_4CC1::
    INCBIN "dwm2-cobi-us.gbc", $194CC1, $88

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_4D49::
KeyWorld4C_4_Y0X3_Header::
    db $01, $04, $06, $09, $0b, $33, $51, $00 ; entry 0

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_4_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194D51, $92

KeyWorldScreenHeader_65_4DE3::
KeyWorld41_2_Y2X2_Header::
    db $03, $04, $06, $09, $0b, $33, $52, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194DEB, $74

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_65_4E5F::
    db $01, $04, $06, $09, $0b, $33, $53, $00 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_4E67::
    INCBIN "dwm2-cobi-us.gbc", $194E67, $B6

KeyWorldScreenHeader_65_4F1D::
    db $05, $04, $06, $09, $0b, $33, $54, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_4F25::
    INCBIN "dwm2-cobi-us.gbc", $194F25, $88

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_4FAD::
KeyWorld4C_5_Y1X1_Header::
    db $04, $02, $07, $0b, $0f, $33, $55, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_5_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $194FB5, $A1

; record: screen header
KeyWorldScreenHeader_65_5056::
KeyWorld47_4_Y0X2_Header::
    db $ff, $02, $03, $04, $0b, $33, $56, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_4_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19505E, $98

KeyWorldScreenHeader_65_50F6::
KeyWorld55_1_Y3X3_Header::
    db $ff, $00, $04, $0c, $0f, $33, $57, $00 ; entry 0

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_1_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1950FE, $AC

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader_65_51AA::
    db $01, $03, $06, $09, $0f, $33, $58, $00 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_51B2::
    INCBIN "dwm2-cobi-us.gbc", $1951B2, $D8

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_528A::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $07, $00
    db $0a, $06, $00, $24, $0f, $09, $00, $2e, $0a, $00, $4e, $0f, $05, $00, $54, $0c
    db $00, $76, $0f, $03, $00, $7a, $0f, $13, $00, $52, $0f, $15, $00, $2c, $0f, $15
    db $00, $2c, $0a, $00, $02, $0e, $00, $22, $1f, $01, $00, $00, $0f, $0b

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_4_Y0X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1952C8, $56

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $08, $00, $1e, $06, $00, $76, $0f, $03, $00, $80, $0f, $0d, $00, $ac, $0f
    db $27, $00, $14, $0f, $4d, $00, $f6, $0a

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_5346::
    INCBIN "dwm2-cobi-us.gbc", $195346, $4B

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_5391::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $03, $00
    db $0a, $06, $00, $20, $0f, $4d, $00, $8e, $0f, $0b, $00, $3c, $0f, $4d, $00, $c2
    db $0f, $03, $00, $06, $0a, $00, $22, $1f, $01, $00, $00, $0f, $0b

KeyWorld4C_5_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1953BE, $56

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_4_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $195414, $43

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_1_Y3X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $195457, $4F

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_54A6::
    INCBIN "dwm2-cobi-us.gbc", $1954A6, $65

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_65_550B::
    db $00, $00, $02, $09, $0a, $33, $74, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_5513::
    INCBIN "dwm2-cobi-us.gbc", $195513, $74

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_5587::
KeyWorld40_4_Y0X3_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $75, $00 ; entry 0

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_4_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19558F, $53

KeyWorldScreenHeader_65_55E2::
KeyWorld47_0_Y2X3_Header::
    db $ff, $00, $02, $08, $09, $33, $76, $00 ; entry 0

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1955EA, $61

; record: screen header
KeyWorldScreenHeader_65_564B::
KeyWorld56_0_Y2X2_Header::
    db $00, $ff, $ff, $ff, $ff, $33, $77, $00 ; entry 0

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorld56_0_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195653, $65

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_56B8::
KeyWorld3C_0_Y3X3_Header::
    db $02, $00, $09, $0a, $0c, $33, $78, $00 ; entry 0

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_0_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1956C0, $77

KeyWorldScreenHeader_65_5737::
KeyWorld30_0_Y2X3_Header::
    db $02, $00, $06, $0d, $0f, $33, $79, $00 ; entry 0

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19573F, $91

; record: screen header
KeyWorldScreenHeader_65_57D0::
KeyWorld55_3_Y0X3_Header::
    db $ff, $04, $0b, $0c, $0e, $33, $7a, $00 ; entry 0

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_3_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1957D8, $7A

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_5852::
KeyWorld42_1_Y2X0_Header::
    db $ff, $07, $09, $0c, $0f, $33, $7b, $00 ; entry 0

; LZSS-compressed: 127 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19585A, $7F

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_65_58D9::
    db $00, $06, $08, $09, $0d, $33, $7c, $00 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_58E1::
    INCBIN "dwm2-cobi-us.gbc", $1958E1, $B6

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_5997::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $33, $00, $04, $08, $00, $78, $0f, $01, $00, $22, $0f
    db $43, $00, $f5, $0f, $4d, $00, $08, $1e

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_4_Y0X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $2f, $02
    db $02, $00, $0a, $06, $00, $4e, $0f, $09, $00, $58, $08, $00, $76, $0f, $03, $00
    db $9f, $0f, $4d, $00, $ff, $0f, $4d, $00, $0a, $04

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_0_Y2X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $08, $06, $00, $28, $0f, $2d, $00, $74, $08, $00, $74, $0f, $05, $00, $0c, $06
    db $00, $98, $0c, $00, $a6, $0f, $03, $00, $cf, $0f, $4d, $00, $08, $1f, $25

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld56_0_Y2X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $02
    db $02, $00, $1e, $0f, $11, $02, $02, $00, $44, $0f, $11, $00, $56, $00, $00, $6c
    db $0f, $0d, $00, $0a, $02, $00, $90, $0f, $01, $00, $90, $0f, $03, $00, $cf, $0f
    db $4d, $00, $08, $1f, $25

KeyWorld3C_0_Y3X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $33, $00
    db $06, $06, $00, $50, $0f, $29, $00, $4c, $0c, $00, $9c, $0f, $31, $00, $10, $08
    db $00, $ec, $0f, $0d, $00, $14, $1f, $35

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_0_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $195A75, $4B

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_3_Y0X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0f, $00
    db $06, $02, $00, $28, $0f, $0b, $00, $02, $06, $00, $50, $0f, $29, $00, $12, $04
    db $00, $32, $06, $00, $9e, $0f, $0f, $00, $0a, $0c, $00, $d0, $0a, $00, $aa, $08
    db $00, $ea, $0f, $0b, $00, $0c, $1f, $39

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y2X0_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $02
    db $00, $30, $05, $00, $26, $0f, $0b, $00, $2c, $06, $00, $4e, $0f, $0f, $00, $2c
    db $02, $00, $76, $0f, $03, $00, $9e, $0a, $00, $9a, $0f, $39, $00, $5a, $06, $00
    db $f0, $0f, $09, $00, $fa, $0f, $13, $00, $3c, $1f, $0f

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_65_5B33::
    INCBIN "dwm2-cobi-us.gbc", $195B33, $65

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_5B98::
KeyWorld42_1_Y3X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $17, $01 ; entry 0

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y3X0_Tiles::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y3X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

KeyWorldScreenHeader_65_5BD1::
KeyWorld29_1_Y2X2_Header::
    db $02, $01, $05, $0e, $0f, $00, $98, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_1_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195BD9, $98

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_5C71::
KeyWorld05_0_Y2X2_Header::
    db $07, $01, $05, $0e, $0f, $00, $99, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195C79, $A4

KeyWorldScreenHeader_65_5D1D::
KeyWorld24_1_Y2X0_Header::
    db $06, $01, $05, $0e, $0f, $31, $9a, $00 ; entry 0

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
KeyWorld24_1_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195D25, $AF

KeyWorldScreenHeader_65_5DD4::
KeyWorld13_0_Y1X1_Header::
    db $ff, $01, $06, $0e, $0f, $31, $9b, $00 ; entry 0

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
KeyWorld13_0_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195DDC, $B0

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_5E8C::
KeyWorld17_1_Y0X1_Header::
    db $01, $01, $05, $0e, $0f, $00, $9c, $00 ; entry 0

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195E94, $AE

KeyWorldScreenHeader_65_5F42::
KeyWorld01_0_Y1X1_Header::
    db $07, $01, $05, $0e, $0f, $00, $9d, $00 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X1_Tiles::
    db $68, $01, $02, $00, $01, $02, $00, $03, $27, $42, $43, $40, $41, $02, $0c, $02
    db $01, $00, $01, $11, $12, $13, $35, $36, $36, $37, $52, $53, $50, $51, $02, $20
    db $02, $02, $06, $02, $02, $2c, $02, $02, $0c, $05, $11, $02, $1c, $00, $02, $40

; LZSS-compressed: 485 bytes that expand to 514 (E-0016, E-0017)
Gfx_65_5F7A::
    INCBIN "dwm2-cobi-us.gbc", $195F7A, $6B

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_5FE5::
KeyWorld10_1_Y0X1_Header::
    db $ff, $01, $06, $0e, $0f, $00, $9e, $00 ; entry 0

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $195FED, $B5

KeyWorldScreenHeader_65_60A2::
KeyWorld16_0_Y2X1_Header::
    db $ff, $01, $03, $0e, $0f, $00, $9f, $00 ; entry 0

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_0_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1960AA, $B4

KeyWorld29_0_Y1X2_Header::
    db $07

; LZSS-compressed: 1253 bytes that expand to 1281 (E-0016, E-0017)
Gfx_65_615F::
    db $01, $05, $0b, $0e, $00, $a0, $00

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_0_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196166, $B0

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_1_Y2X2_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $09, $02, $0a
    db $06, $02, $26, $0f, $09, $02, $30, $08, $02, $4e, $0f, $07, $02, $56, $0a, $02
    db $76, $0f, $03, $02, $9f, $0f, $4d, $02, $ff, $0f, $4d, $02, $0c, $04

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $196244, $4F

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorld24_1_Y2X0_Attrs::
    db $68, $01, $03, $03, $ff, $f6, $01, $03, $0a, $05, $03, $00, $0f, $4d, $03, $10
    db $06, $03, $1e, $06, $03, $74, $0f, $05, $01, $01, $02, $02, $03, $92, $0c, $03
    db $a0, $0f, $05, $03, $ca, $00, $03, $bc, $0f, $15, $03, $ca, $0a, $03, $f2, $0f
    db $01, $03, $f0, $06, $03, $e6, $0f, $01, $03, $a4, $0e, $03, $38, $1f, $0b

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld13_0_Y1X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $09, $02, $0a
    db $06, $02, $26, $0f, $0b, $02, $08, $0f, $0f, $02, $12, $04, $02, $6e, $0f, $0b
    db $02, $0e, $06, $02, $96, $0f, $11, $02, $cd, $0f, $4d, $02, $08, $1f, $27

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $196301, $4A

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $19634B, $46

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $33, $02, $08
    db $06, $02, $50, $0f, $0d, $02, $06, $04, $02, $fa, $ff, $03, $02, $8e, $0f, $15
    db $02, $12, $02, $02, $c8, $08, $02, $c8, $0f, $0d, $02, $f8, $08, $02, $f4, $0f
    db $01, $02, $0c, $1f, $39

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_0_Y2X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $33, $02, $08
    db $06, $02, $50, $0f, $03, $02, $10, $0e, $02, $78, $0f, $01, $02, $0c, $0c, $02
    db $9c, $0f, $0d, $02, $10, $04, $02, $c4, $0f, $39, $02, $14, $1f, $31

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_0_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1963F4, $4B

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_643F::
KeyWorld07_0_Y0X1_Header::
    db $05, $03, $04, $0a, $0d, $37, $bc, $00 ; entry 0

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196447, $83

KeyWorldScreenHeader_65_64CA::
KeyWorld01_0_Y0X2_Header::
    db $07, $03, $04, $0a, $0d, $04, $bd, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1964D2, $74

KeyWorldScreenHeader_65_6546::
KeyWorld00_0_Y0X1_Header::
    db $ff, $01, $04, $0d, $0f, $04, $be, $00 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19654E, $9C

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_65EA::
KeyWorld04_0_Y0X2_Header::
    db $ff, $01, $04, $0a, $0f, $04, $bf, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1965F2, $52

; LZSS-compressed: 512 bytes that expand to 512 (E-0016, E-0017)
Gfx_65_6644::
    INCBIN "dwm2-cobi-us.gbc", $196644, $4F

KeyWorldScreenHeader_65_6693::
KeyWorld04_0_Y0X1_Header::
    db $03, $04, $05, $08, $0c, $37, $c0, $00 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19669B, $9B

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_6736::
KeyWorld00_0_Y0X2_Header::
    db $05, $08, $09, $0a, $0d, $37, $c1, $00 ; entry 0

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19673E, $CA

KeyWorldScreenHeader_65_6808::
KeyWorld06_0_Y0X1_Header::
    db $ff, $04, $05, $08, $0d, $37, $c2, $00 ; entry 0

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X1_Tiles::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $01, $11, $12, $13, $02, $1a
    db $00, $14, $02, $00, $03, $02, $00, $01, $27, $42, $43, $02, $2e, $00, $08, $02
    db $0d, $06, $11, $36, $37, $52, $53, $02, $42, $00, $18, $02, $21, $06, $07, $02
    db $2e, $02, $20, $21

; LZSS-compressed: 509 bytes that expand to 526 (E-0016, E-0017)
Gfx_65_6844::
    INCBIN "dwm2-cobi-us.gbc", $196844, $73

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_68B7::
KeyWorld06_0_Y0X2_Header::
    db $ff, $04, $08, $0b, $0d, $37, $c3, $00 ; entry 0

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1968BF, $D2

KeyWorldScreenHeader_65_6991::
KeyWorld27_0_Y0X2_Header::
    db $01, $03, $06, $08, $0d, $37, $c4, $00 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_0_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196999, $A8

; LZSS-compressed: 517 bytes that expand to 514 (E-0016, E-0017)
Gfx_65_6A41::
    db $02, $02, $b6, $00, $02, $ee, $02, $02, $f2, $00, $02, $a8, $02, $02, $18, $12
    db $02, $b8, $00, $02, $06, $10, $02, $bc, $02, $02, $2c, $12, $02, $18, $12, $02
    db $7c, $00, $02, $40, $14, $02, $2a, $14, $02, $90, $00, $02, $54, $14, $50, $51

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $1e, $0f, $0b, $01, $02, $7e, $03, $02
    db $72, $0f, $07, $02, $7e, $04, $02, $a7, $0f, $4d, $02, $07, $1f, $4d

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X2_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $40, $0f, $2d, $01, $03, $a0, $01, $02
    db $03, $a6, $03, $03, $a0, $02, $03, $a0, $0f, $03, $03, $a6, $04, $03, $a6, $08
    db $03, $ca, $0f, $01, $03, $c8, $0a, $03, $c2, $0f, $01, $03, $b0, $0f, $07, $03
    db $a2, $0f, $05, $03, $3a, $1f, $0f

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $40, $0f, $2d, $01, $01, $01, $01, $02
    db $94, $0c, $02, $a0, $0f, $2d, $02, $a2, $06, $02, $ec, $06, $02, $f4, $0f, $03
    db $02, $12, $1f, $37

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $196AEA, $42

KeyWorld04_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $07, $02, $24, $0f, $07, $02
    db $2c, $08, $02, $34, $04, $02, $52, $0f, $27, $02, $52, $0c, $02, $af, $0f, $4d
    db $02, $08, $1f, $45

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $196B50, $4F

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $1b, $01, $02, $2e, $01, $02, $20, $0f, $0d, $02
    db $2e, $0f, $13, $02, $2c, $0f, $13, $02, $2e, $02, $02, $30, $06, $02, $a0, $06
    db $02, $a6, $0f, $05, $02, $32, $02, $02, $c4, $0f, $11, $02, $fb, $0f, $4d, $02
    db $b2, $08

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $196BD1, $54

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_0_Y0X2_Attrs::
    db $68, $01, $03, $03, $ff, $ff, $1d, $02, $02, $02, $02, $03, $20, $0f, $0d, $03
    db $30, $00, $04, $04, $03, $30, $00, $03, $32, $06, $03, $54, $0e, $02, $02, $01
    db $03

; LZSS-compressed: 97 bytes that expand to 380 (E-0016, E-0017)
Gfx_65_6C46::
    db $7c, $01, $04, $04, $03, $58, $02, $03, $76, $0f, $03, $03, $7c, $02, $03, $a0
    db $04, $03, $58, $00, $03, $a0, $0a, $03, $ac, $0f, $01, $04, $04, $03, $b2, $0c
    db $03, $d2, $0a, $03, $56, $00, $03, $ae, $0c, $03, $f4, $0f, $01, $03, $f2, $00
    db $03, $d6, $0e, $03, $1e, $1f, $01, $03, $34, $1f, $0f

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_6C81::
KeyWorld03_0_Y1X2_Header::
    db $01, $02, $04, $07, $0c, $39, $e0, $00 ; entry 0

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196C89, $84

KeyWorldScreenHeader_65_6D0D::
KeyWorld04_0_Y1X3_Header::
    db $ff, $02, $04, $05, $07, $08, $e1, $00 ; entry 0

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196D15, $50

KeyWorldScreenHeader_65_6D65::
KeyWorld00_0_Y2X3_Header::
    db $ff, $00, $01, $02, $04, $08, $e2, $00 ; entry 0

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196D6D, $76

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_6DE3::
KeyWorld00_0_Y1X3_Header::
    db $ff, $00, $01, $02, $07, $08, $e3, $00 ; entry 0

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196DEB, $A0

KeyWorldScreenHeader_65_6E8B::
KeyWorld02_0_Y1X3_Header::
    db $05, $02, $06, $0c, $0d, $39, $e4, $00 ; entry 0

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196E93, $DD

KeyWorldScreenHeader_65_6F70::
KeyWorld08_0_Y2X3_Header::
    db $00, $04, $06, $09, $0c, $39, $e5, $00 ; entry 0

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $196F78, $AB

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_7023::
KeyWorld06_0_Y2X3_Header::
    db $00, $02, $03, $06, $0f, $39, $e6, $00 ; entry 0

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19702B, $92

KeyWorldScreenHeader_65_70BD::
KeyWorld05_0_Y1X1_Header::
    db $ff, $03, $08, $09, $0b, $39, $e7, $00 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1970C5, $9C

KeyWorldScreenHeader_65_7161::
KeyWorld07_0_Y2X1_Header::
    db $01, $03, $05, $0a, $0b, $39, $e8, $00 ; entry 0

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $197169, $E8

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y1X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $4d, $02, $1a, $0f, $05, $02
    db $1a, $06, $02, $78, $0f, $0f, $02, $1c, $02, $02, $a0, $0f, $0f, $02, $72, $0f
    db $11, $02, $1e, $0f, $4d, $02, $f6, $0a

; LZSS-compressed: 23 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $4d, $02, $56, $0f, $4d, $02
    db $b6, $0f, $4d, $02, $02, $1f, $2b

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $37, $02, $f0, $ff, $01, $02
    db $54, $0f, $4d, $02, $8c, $0f, $19, $02, $8e, $0c, $02, $f0, $0f, $07, $02, $06
    db $0f, $37

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X3_Attrs::
    db $68, $01, $03, $01, $03, $00, $05, $03, $f6, $ff, $3b, $03, $f4, $ff, $01, $03
    db $f4, $fe, $02, $02, $03, $6c, $0f, $11, $03, $7e, $0a, $03, $9e, $0f, $31, $03
    db $f4, $00, $03, $e6, $0f, $0f, $03, $7c, $00, $03, $08, $0e, $03, $1e, $1f, $01
    db $03, $06, $0f, $0f

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1972E6, $4E

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $197334, $48

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y2X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $39, $02, $f2, $ff, $01, $02
    db $56, $0f, $29, $02, $04, $0a, $02, $a0, $0f, $0d, $02, $06, $04, $02, $c8, $0f
    db $11, $02, $08, $00, $02, $f0, $0f, $0b, $02, $f6, $ff, $33

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1973A8, $42

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1973EA, $55

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_743F::
KeyWorld01_0_Y0X3_Header::
    db $03, $03, $06, $07, $09, $3d, $04, $01 ; entry 0

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $197447, $6F

KeyWorldScreenHeader_65_74B6::
KeyWorld03_0_Y0X2_Header::
    db $ff, $ff, $ff, $ff, $ff, $0c, $05, $01 ; entry 0

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1974BE, $5F

KeyWorldScreenHeader_65_751D::
KeyWorld07_0_Y0X3_Header::
    db $ff, $03, $04, $05, $06, $26, $06, $01 ; entry 0

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $197525, $7E

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_75A3::
KeyWorld02_0_Y0X3_Header::
    db $01, $03, $06, $07, $09, $3d, $07, $01 ; entry 0

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1975AB, $96

KeyWorldScreenHeader_65_7641::
KeyWorld00_0_Y0X3_Header::
    db $05, $05, $06, $08, $0b, $3d, $08, $01 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $197649, $A4

KeyWorldScreenHeader_65_76ED::
KeyWorld04_0_Y0X3_Header::
    db $01, $04, $09, $0b, $0d, $3d, $09, $01 ; entry 0

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1976F5, $AF

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_77A4::
KeyWorld11_1_Y0X3_Header::
    db $ff, $02, $04, $0a, $0c, $3d, $0a, $01 ; entry 0

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1977AC, $CC

KeyWorldScreenHeader_65_7878::
KeyWorld1D_1_Y2X3_Header::
    db $ff, $02, $05, $0b, $0d, $3d, $0b, $01 ; entry 0

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1D_1_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $197880, $CA

KeyWorldScreenHeader_65_794A::
KeyWorld17_0_Y3X2_Header::
    db $01, $04, $09, $02, $0c, $3d, $0c, $01 ; entry 0

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $197952, $DE

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X3_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $1e, $0f, $0b, $01, $02, $7e, $03, $02
    db $72, $0f, $07, $02, $7e, $04, $02, $94, $0f, $3f, $02, $74, $0e, $02, $f8, $0f
    db $49

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y0X2_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $40, $0f, $2d, $01, $01, $02, $02, $03
    db $90, $0f, $15, $03, $a2, $0c, $03, $c8, $0f, $07, $03, $a2, $0a, $03, $f0, $0f
    db $09, $03, $a2, $08, $03, $18, $1f, $03, $03, $40, $14, $03, $36, $1f, $0b

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $43, $01, $01, $02, $44, $0f, $0f, $01, $02, $7a
    db $01, $02, $6c, $0f, $0d, $02, $7a, $02, $02, $7c, $0a, $02, $a0, $0f, $0b, $02
    db $56, $06, $02, $c8, $0f, $4d, $02, $9c, $0f, $19

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y0X3_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $20, $0f, $0d, $02, $02, $02, $02, $03
    db $70, $0f, $09, $01, $03, $a0, $01, $03, $80, $00, $03, $80, $06, $03, $a0, $0f
    db $07, $03, $a4, $02, $03, $98, $0a, $03, $ce, $0f, $03, $01, $01, $03, $20, $06
    db $03, $f0, $0f, $4d, $03, $63, $10

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $1d, $01, $02, $30, $01, $02, $22, $0f, $15, $02
    db $34, $0a, $02, $58, $0c, $02, $58, $04, $02, $70, $0f, $09, $02, $7c, $08, $02
    db $34, $04, $02, $a0, $0f, $4d, $02, $78, $0a, $02, $4e, $0e, $02, $20, $1f, $21

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $197B11, $4F

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y0X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $01, $02, $1a, $0f, $3d, $02, $2c, $06
    db $02, $2c, $04, $02, $7c, $0c, $02, $7c, $00, $02, $7c, $06, $02, $7c, $02, $02
    db $a0, $0f, $0d, $02, $a2, $04, $02, $c8, $0f, $09, $02, $c8, $0e, $02, $f6, $0f
    db $09, $02, $76, $06, $02, $1c, $1f, $07, $02, $72, $0a, $02, $44, $1c

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1D_1_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $197B9E, $46

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y3X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $197BE4, $5B
    ds $3c1, $00
