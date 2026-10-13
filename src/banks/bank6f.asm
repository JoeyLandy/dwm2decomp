SECTION "Bank 6F", ROMX[$4000], BANK[$6F]
    db $6f

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC001, $58

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC059, $9B

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC0F4, $AB

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC19F, $DC

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC27B, $CE

; LZSS-compressed: 234 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC349, $EA

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC433, $D1

KeyWorldRoom04_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC504, $D1

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_45D5::
    INCBIN "dwm2-cobi-us.gbc", $1BC5D5, $6B

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_4640::
    INCBIN "dwm2-cobi-us.gbc", $1BC640, $E7

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_4727::
    INCBIN "dwm2-cobi-us.gbc", $1BC727, $EC

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_4813::
    INCBIN "dwm2-cobi-us.gbc", $1BC813, $C8

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8B_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC8DB, $64

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BC93F, $C7

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3D_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BCA06, $C0

; LZSS-compressed: 264 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3E_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BCAC6, $108

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $00, $78, $07
    db $00, $74, $0c, $00, $80, $0e, $03, $03, $00, $94, $0f, $19, $00, $88, $0a, $00
    db $ce, $0a, $00, $18, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCBF8, $41

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $40, $01, $01, $00, $4c, $0f, $0f, $01, $01
    db $01, $01, $03, $00, $7c, $01, $00, $78, $00, $00, $54, $00, $00, $82, $02, $00
    db $7c, $0f, $01, $00, $9e, $04, $00, $52, $02, $00, $9e, $0f, $07, $00, $46, $0c
    db $00, $c8, $0f, $01, $00, $00, $0f, $41, $00, $00, $0f, $11

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCC75, $45

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCCBA, $43

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCCFD, $56

KeyWorldRoom03_Y3X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $48, $03, $03, $00, $4a, $0f, $07, $01, $01
    db $01, $01, $00, $54, $08, $00, $78, $00, $00, $78, $0f, $2b, $00, $54, $06, $03
    db $03, $00, $88, $0e, $00, $d4, $04, $00, $74, $04, $00, $e8, $08, $00, $f0, $0f
    db $05, $00, $86, $0e, $00, $1a, $1f, $05, $00, $00, $0f, $0f

KeyWorldRoom04_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCD8F, $45

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_4DD4::
    db $68, $01, $04, $02, $04, $00, $0f, $4d, $04, $18, $0f, $04, $01, $01, $01, $01
    db $03, $04, $7c, $07, $04, $76, $02, $04, $7a, $0f, $03, $04, $78, $00, $00, $02
    db $04, $a8, $00, $04, $74, $04, $04, $a2, $03, $04, $fb, $f5, $04, $a0, $0f, $17
    db $04, $18, $0f, $4d, $04, $08, $1f, $05

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_4E0C::
    INCBIN "dwm2-cobi-us.gbc", $1BCE0C, $4D

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_4E59::
    INCBIN "dwm2-cobi-us.gbc", $1BCE59, $74

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_4ECD::
    INCBIN "dwm2-cobi-us.gbc", $1BCECD, $4A

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8B_Y3X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $00, $78, $01
    db $00, $18, $00, $05, $05, $05, $05, $03, $03, $00, $78, $02, $00, $7a, $0f, $03
    db $00, $7e, $0f, $3d, $00, $f3, $0f, $4d, $00, $08, $1f, $01

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCF43, $46

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3D_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCF89, $4B

KeyWorldRoom3E_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BCFD4, $4A

; compressed BG tiles (2048 bytes, 128 tiles): entry 6 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 736 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles6::
    INCBIN "dwm2-cobi-us.gbc", $1BD01E, $2E0

; entry 6 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes6::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $5f17, $15ae, $0044 ; entry 1
    dw $1528, $5f17, $15ae, $0000 ; entry 2
    dw $218c, $5f17, $15ae, $0044 ; entry 3
    dw $5d8c, $5f17, $5ab1, $0000 ; entry 4
    dw $7da0, $5f17, $7fe0, $0063 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD33E, $88

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD3C6, $AD

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD473, $8B

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD4FE, $D4

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0F_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD5D2, $92

KeyWorldRoom0F_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD664, $D4

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD738, $E3

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BD81B, $C9

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_58E4::
    INCBIN "dwm2-cobi-us.gbc", $1BD8E4, $8B

; LZSS-compressed: 252 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_596F::
    INCBIN "dwm2-cobi-us.gbc", $1BD96F, $FC

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_5A6B::
    INCBIN "dwm2-cobi-us.gbc", $1BDA6B, $BE

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_5B29::
    INCBIN "dwm2-cobi-us.gbc", $1BDB29, $C5

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_5BEE::
    INCBIN "dwm2-cobi-us.gbc", $1BDBEE, $93

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom44_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BDC81, $C7

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom67_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BDD48, $F9

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom52_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BDE41, $DC

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y0X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $20, $0f, $0c, $03, $03, $03, $03
    db $01, $01, $02, $02, $01, $01, $00, $84, $00, $00, $7a, $0f, $09, $00, $88, $02
    db $00, $9c, $0f, $11, $00, $86, $02, $00, $c6, $0f, $11, $00, $72, $0c, $00, $fa
    db $0f, $01, $03, $03, $00, $10, $1f, $11, $00, $88, $08, $00, $40, $1f, $01

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BDF5C, $44

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y0X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $26, $0f, $12, $01, $01, $03, $03
    db $01, $01, $00, $78, $0f, $33, $01, $00, $d2, $05, $00, $c8, $0f, $0b, $03, $00
    db $fa, $01, $00, $26, $0a, $00, $fa, $0f, $01, $00, $86, $00, $00, $76, $0f, $01
    db $00, $76, $0e, $00, $74, $0f, $01, $00, $26, $04

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BDFDA, $4A

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0F_Y0X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $28, $0f, $14, $03, $03, $01, $01
    db $00, $78, $0f, $0d, $03, $00, $ac, $01, $00, $9e, $0f, $0b, $01, $01, $01, $01
    db $00, $ac, $00, $00, $ce, $00, $00, $c8, $0f, $0f, $00, $28, $0a, $00, $f8, $0f
    db $01, $00, $88, $0f, $11, $00, $cc, $04, $00, $38, $1f, $09

KeyWorldRoom0F_Y1X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BE060, $4A

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BE0AA, $4D

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BE0F7, $43

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_613A::
    INCBIN "dwm2-cobi-us.gbc", $1BE13A, $42

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_617C::
    INCBIN "dwm2-cobi-us.gbc", $1BE17C, $68

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_61E4::
    INCBIN "dwm2-cobi-us.gbc", $1BE1E4, $6B

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_624F::
    INCBIN "dwm2-cobi-us.gbc", $1BE24F, $4B

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_629A::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $01, $01, $01, $01
    db $05, $05, $00, $7e, $00, $00, $7e, $00, $00, $78, $0f, $09, $05, $05, $03, $03
    db $03, $03, $00, $9a, $0f, $0f, $00, $a6, $08, $00, $c8, $0f, $07, $00, $7c, $02
    db $00, $6e, $0f, $01, $00, $fc, $0f, $45

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom44_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BE2D2, $45

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom67_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BE317, $47

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom52_Y2X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $05, $05, $00, $7c
    db $02, $01, $00, $86, $01, $00, $78, $0f, $07, $03, $03, $00, $82, $06, $00, $9e
    db $0f, $09, $05, $05, $00, $a6, $00, $00, $c0, $0f, $0f, $00, $1e, $00, $00, $ea
    db $0c, $00, $f6, $0f, $05, $00, $1e, $0f, $33

; compressed BG tiles (2048 bytes, 128 tiles): entry 7 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 697 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles7::
    INCBIN "dwm2-cobi-us.gbc", $1BE397, $DE

; LZSS-compressed: 1043 bytes that expand to 1040 (E-0016, E-0017)
Gfx_6F_6475::
    INCBIN "dwm2-cobi-us.gbc", $1BE475, $1DB

; entry 7 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes7::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $5f17, $15ae, $0044 ; entry 1
    dw $1528, $5f17, $15ae, $0000 ; entry 2
    dw $7da0, $7fff, $7fe0, $0063 ; entry 3
    dw $5d8c, $5f17, $5ab1, $0000 ; entry 4
    dw $218c, $5f17, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 142 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BE690, $8E

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BE71E, $B9

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BE7D7, $B1

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BE888, $CA

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BE952, $DB

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BEA2D, $AD

KeyWorldRoom03_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BEADA, $CA

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom12_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BEBA4, $F7

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_6C9B::
    INCBIN "dwm2-cobi-us.gbc", $1BEC9B, $99

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_6D34::
    INCBIN "dwm2-cobi-us.gbc", $1BED34, $D8

; LZSS-compressed: 225 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_6E0C::
    INCBIN "dwm2-cobi-us.gbc", $1BEE0C, $E1

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_6EED::
    INCBIN "dwm2-cobi-us.gbc", $1BEEED, $D6

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6F_6FC3::
    INCBIN "dwm2-cobi-us.gbc", $1BEFC3, $88

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom44_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BF04B, $BA

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom67_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BF105, $EB

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3D_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BF1F0, $DD

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y0X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $01, $01, $01
    db $00, $76, $00, $00, $6c, $0f, $15, $00, $7e, $08, $00, $a0, $0f, $05, $01, $01
    db $03, $03, $00, $bc, $0f, $0d, $00, $70, $06, $00, $e6, $0f, $13, $00, $50, $0f
    db $1b, $00, $3a, $1f, $07

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF302, $4C

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $01, $01, $01
    db $00, $68, $0f, $17, $00, $7a, $0a, $00, $a0, $0f, $0b, $00, $78, $06, $00, $c8
    db $0f, $01, $00, $72, $04, $00, $76, $02, $00, $7a, $08, $00, $f6, $0f, $03, $01
    db $01, $03, $03, $03, $03, $00, $12, $1f, $0d, $00, $76, $0f, $0f

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $03, $03, $00, $40, $0f, $11, $01, $01
    db $01, $01, $00, $68, $0f, $1b, $03, $00, $aa, $01, $00, $9c, $0f, $09, $00, $78
    db $02, $01, $01, $00, $c0, $0f, $09, $00, $74, $02, $00, $74, $0e, $00, $f4, $0f
    db $01, $00, $ee, $08, $00, $14, $1f, $0d, $00, $78, $0f, $0d

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF3C7, $46

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $1a, $01, $01, $00, $1c, $0f, $35, $01, $01
    db $00, $2e, $00, $00, $6a, $0f, $13, $00, $78, $02, $00, $96, $0f, $0d, $03, $03
    db $03, $03, $00, $ba, $0f, $0f, $00, $00, $00, $00, $e0, $0f, $15, $00, $9e, $04
    db $00, $10, $1f, $0f, $00, $76, $04, $00, $3a, $1f, $07

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF448, $44

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom12_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF48C, $54

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_74E0::
    db $68, $01, $04, $02, $04, $00, $0f, $4d, $04, $18, $0f, $04, $01, $04, $78, $01
    db $03, $03, $04, $6c, $0f, $13, $00, $02, $03, $03, $04, $7e, $06, $04, $a0, $03
    db $00, $04, $a8, $0c, $00, $02, $04, $ff, $fa, $04, $b6, $02, $04, $fe, $ff, $2d
    db $01, $01, $04, $10, $1f, $11, $04, $78, $00, $04, $38, $1f, $09

KeyWorldScreen_6F_751D::
    INCBIN "dwm2-cobi-us.gbc", $1BF51D, $54

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_7571::
    INCBIN "dwm2-cobi-us.gbc", $1BF571, $61

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_75D2::
    INCBIN "dwm2-cobi-us.gbc", $1BF5D2, $59

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6F_762B::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $01, $00, $18
    db $02, $05, $05, $00, $6e, $0f, $0d, $00, $a0, $02, $00, $94, $0f, $13, $05, $05
    db $00, $78, $04, $00, $c4, $0f, $05, $00, $70, $0c, $00, $ec, $0f, $0f, $00, $e4
    db $0e, $00, $20, $1f, $21

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom44_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF660, $47

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom67_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF6A7, $51

KeyWorldRoom3D_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BF6F8, $51
    ds $8b7, $00
