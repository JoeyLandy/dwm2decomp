SECTION "Bank 6A", ROMX[$4000], BANK[$6A]
    db $6a

; compressed tileset of special map record 0 (SpecialMapRecords)
; LZSS-compressed: 1131 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap00Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1A8001, $46B

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap00Palettes::
    dw $0220, $7fff, $357b, $0000 ; entry 0
    dw $01c0, $3c1f, $03e2, $0000 ; entry 1
    dw $49ae, $6b79, $4acd, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $012f, $035f, $01da, $0000 ; entry 4
    dw $1012, $4fff, $3c1f, $0000 ; entry 5
    dw $7d68, $7fff, $7f32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap00Screens::
    dfar SpecialMap00Screens_Y0X0 ; entry 0
    dfar SpecialMap00Screens_Y1X0 ; entry 1

SpecialMap00Attrs::
    dfar SpecialMap00Attrs_Y0X0 ; entry 0
    dfar SpecialMap00Attrs_Y1X0 ; entry 1

; LZSS-compressed: 256 bytes that expand to 360 (E-0016, E-0017)
SpecialMap00Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A84B8, $100

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
SpecialMap00Screens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A85B8, $110

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
SpecialMap00Attrs_Y0X0::
    db $68, $01, $01, $02, $01, $00, $0f, $2e, $04, $01, $42, $01, $01, $34, $0b, $05
    db $05, $05, $05, $01, $47, $0f, $0a, $01, $fa, $f3, $01, $57, $00, $01, $77, $04
    db $01, $77, $0f, $04, $01, $00, $0a, $01, $9c, $0f, $0c, $01, $7f, $01, $01, $c0
    db $0f, $31, $01, $00, $03, $01, $cf, $05, $01, $00, $07, $01, $1f, $1f, $22

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
SpecialMap00Attrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A8707, $5F

; compressed tileset of special map record 1 (SpecialMapRecords)
; LZSS-compressed: 1268 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap01Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1A8766, $4F4

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap01Palettes::
    dw $00ce, $7fff, $01da, $0063 ; entry 0
    dw $1415, $3f7f, $029a, $0000 ; entry 1
    dw $01d3, $3f7f, $029a, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $012f, $035f, $01da, $0000 ; entry 4
    dw $1415, $035f, $3c1f, $0000 ; entry 5
    dw $7d68, $7fff, $7f32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap01Screens::
    dfar SpecialMap01Screens_Y0X0 ; entry 0
    dfar SpecialMap01Screens_Y1X0 ; entry 1

SpecialMap01Attrs::
    dfar SpecialMap01Attrs_Y0X0 ; entry 0
    dfar SpecialMap01Attrs_Y1X0 ; entry 1

; LZSS-compressed: 256 bytes that expand to 360 (E-0016, E-0017)
SpecialMap01Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A8CA6, $100

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
SpecialMap01Screens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A8DA6, $EC

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
SpecialMap01Attrs_Y0X0::
    db $68, $01, $03, $02, $02, $01, $01, $02, $03, $04, $05, $03, $02, $04, $03, $02
    db $0f, $05, $03, $fa, $fc, $03, $2a, $0f, $05, $04, $05, $05, $05, $05, $04, $03
    db $00, $0a, $03, $56, $04, $03, $70, $08, $03, $57, $00, $05, $05, $03, $70, $0f
    db $4d, $03, $d0, $0f, $4d, $03, $08, $1f, $11

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
SpecialMap01Attrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A8ECB, $44

; compressed tileset of special map record 2 (SpecialMapRecords)
; LZSS-compressed: 1173 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap02Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1A8F0F, $495

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap02Palettes::
    dw $31ef, $7fff, $357b, $0000 ; entry 0
    dw $258c, $5bdf, $39f3, $0000 ; entry 1
    dw $31ef, $7fff, $4acd, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $012f, $035f, $01da, $0000 ; entry 4
    dw $1415, $4fff, $3c1f, $0000 ; entry 5
    dw $7d68, $7fff, $7f32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap02Screens::
    dfar SpecialMap02Screens_Y0X0 ; entry 0
    dfar SpecialMap02Screens_Y1X0 ; entry 1

SpecialMap02Attrs::
    dfar SpecialMap02Attrs_Y0X0 ; entry 0
    dfar SpecialMap02Attrs_Y1X0 ; entry 1

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
SpecialMap02Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A93F0, $D7

; LZSS-compressed: 239 bytes that expand to 360 (E-0016, E-0017)
SpecialMap02Screens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A94C7, $EF

; LZSS-compressed: 112 bytes that expand to 360 (E-0016, E-0017)
SpecialMap02Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A95B6, $70

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
SpecialMap02Attrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A9626, $55

; compressed tileset of special map record 3 (SpecialMapRecords)
; LZSS-compressed: 1327 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap03Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1A967B, $52F

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap03Palettes::
    dw $1c2e, $7fff, $357b, $0000 ; entry 0
    dw $1c2e, $5f17, $357b, $0000 ; entry 1
    dw $218c, $7fff, $5ab1, $0000 ; entry 2
    dw $1586, $7fff, $02c0, $0000 ; entry 3
    dw $012f, $035f, $01da, $0000 ; entry 4
    dw $0015, $035f, $481f, $0000 ; entry 5
    dw $7d68, $7fff, $7f32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap03Screens::
    dfar SpecialMap03Screens_Y0X0 ; entry 0
    dfar SpecialMap03Screens_Y1X0 ; entry 1

SpecialMap03Attrs::
    dfar SpecialMap03Attrs_Y0X0 ; entry 0
    dfar SpecialMap03Attrs_Y1X0 ; entry 1

; LZSS-compressed: 288 bytes that expand to 360 (E-0016, E-0017)
SpecialMap03Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A9BF6, $120

; LZSS-compressed: 275 bytes that expand to 360 (E-0016, E-0017)
SpecialMap03Screens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A9D16, $113

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
SpecialMap03Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A9E29, $5E

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
SpecialMap03Attrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A9E87, $53

; compressed tileset of special map record 4 (SpecialMapRecords)
; LZSS-compressed: 1126 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap04Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1A9EDA, $466

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap04Palettes::
    dw $7da0, $7fff, $7d51, $0063 ; entry 0
    dw $1147, $4718, $3252, $0063 ; entry 1
    dw $012f, $357b, $1c2e, $0000 ; entry 2
    dw $01c0, $3f7f, $01da, $0000 ; entry 3
    dw $012f, $035f, $01da, $0000 ; entry 4
    dw $2010, $035f, $3c1f, $0000 ; entry 5
    dw $7d68, $7fff, $7f32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap04Screens::
    dfar SpecialMap04Screens_Y0X0 ; entry 0
    dfar SpecialMap04Screens_Y1X0 ; entry 1

SpecialMap04Attrs::
    dfar SpecialMap04Attrs_Y0X0 ; entry 0
    dfar SpecialMap04Attrs_Y1X0 ; entry 1

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
SpecialMap04Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AA38C, $F9

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
SpecialMap04Screens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1AA485, $F5

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
SpecialMap04Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AA57A, $5D

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
SpecialMap04Attrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1AA5D7, $69

; compressed tileset of special map record 5 (SpecialMapRecords)
; LZSS-compressed: 1138 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap05Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1AA640, $472

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap05Palettes::
    dw $38a8, $7fff, $3a33, $0000 ; entry 0
    dw $3c6b, $3a52, $2510, $0000 ; entry 1
    dw $194a, $5f17, $3a33, $0000 ; entry 2
    dw $1415, $5f17, $3a33, $0000 ; entry 3
    dw $012f, $035f, $01da, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $7d68, $7fff, $7f32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap05Screens::
    dfar SpecialMap05Screens_Y0X0 ; entry 0
    dfar SpecialMap05Screens_Y1X0 ; entry 1

SpecialMap05Attrs::
    dfar SpecialMap05Attrs_Y0X0 ; entry 0
    dfar SpecialMap05Attrs_Y1X0 ; entry 1

; LZSS-compressed: 306 bytes that expand to 360 (E-0016, E-0017)
SpecialMap05Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AAAFE, $132

; LZSS-compressed: 296 bytes that expand to 360 (E-0016, E-0017)
SpecialMap05Screens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1AAC30, $128

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
SpecialMap05Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AAD58, $65

; LZSS-compressed: 109 bytes that expand to 360 (E-0016, E-0017)
SpecialMap05Attrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1AADBD, $6D

; compressed tileset of special map record 31 (SpecialMapRecords)
; LZSS-compressed: 712 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap1FTileset::
    INCBIN "dwm2-cobi-us.gbc", $1AAE2A, $2C8

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap1FPalettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $014c, $0252, $01d0, $00c8 ; entry 1
    dw $5084, $7ed2, $61a8, $0044 ; entry 2
    dw $1986, $664e, $2a4a, $0044 ; entry 3
    dw $50c6, $664e, $61a8, $0044 ; entry 4
    dw $012f, $02fc, $01d5, $00c8 ; entry 5
    dw $218c, $4f18, $3a52, $0ca5 ; entry 6
    dw $218c, $4f18, $3a52, $0ca5 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1FScreens::
    dfar SpecialMap1FScreens_Y0X0 ; entry 0

SpecialMap1FAttrs::
    dfar SpecialMap1FAttrs_Y0X0 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1FScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AB138, $D8

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1FAttrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AB210, $5D

; compressed tileset of special map record 32 (SpecialMapRecords)
; LZSS-compressed: 712 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap20Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1AB26D, $2C8

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap20Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $014c, $0252, $01d0, $00c8 ; entry 1
    dw $1094, $4a9f, $21b8, $0044 ; entry 2
    dw $1986, $3a1c, $2a4a, $0044 ; entry 3
    dw $1094, $3a1c, $21b8, $0044 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap20Screens::
    dfar SpecialMap20Screens_Y0X0 ; entry 0

SpecialMap20Attrs::
    dfar SpecialMap20Attrs_Y0X0 ; entry 0

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
SpecialMap20Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AB57B, $DF

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
SpecialMap20Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AB65A, $68

; compressed tileset of special map record 33 (SpecialMapRecords)
; LZSS-compressed: 441 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap21Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1AB6C2, $1B9

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap21Palettes::
    dw $0173, $7fff, $029a, $0084 ; entry 0
    dw $01d3, $3f7f, $029a, $00c8 ; entry 1
    dw $012f, $029a, $01d5, $0044 ; entry 2
    dw $2112, $7fff, $39da, $0000 ; entry 3
    dw $1528, $7fff, $6b2b, $0020 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap21Screens::
    dfar SpecialMap21Screens_Y0X0 ; entry 0

SpecialMap21Attrs::
    dfar SpecialMap21Attrs_Y0X0 ; entry 0

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
SpecialMap21Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AB8C1, $AE

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
SpecialMap21Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1AB96F, $6A
    ds $627, $00
