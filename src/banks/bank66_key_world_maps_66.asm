; ROM bank $66: key-world map screens
; The annotated listing of this bank is build/listing/bank66.asm.

SECTION "Bank 66", ROMX[$4000], BANK[$66]
    db $66

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 3: entry 3 of KeyWorldTilesetTable,
; decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed: 1188 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles3::
    INCBIN "dwm2-cobi-us.gbc", $198001, $4A4

KeyWorld06_0_Y3X1_Header::
    db $02, $02, $05, $06, $0b, $3a, $e9, $00

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1984AD, $99

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_4546::
KeyWorld05_0_Y3X2_Header::
    db $ff, $ff, $ff, $ff, $ff, $09, $ea, $00 ; entry 0

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19854E, $66

KeyWorldScreenHeader_66_45B4::
KeyWorld0A_0_Y1X2_Header::
    db $ff, $ff, $ff, $ff, $ff, $09, $eb, $00 ; entry 0

; LZSS-compressed: 121 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0A_0_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1985BC, $79

KeyWorldScreenHeader_66_4635::
KeyWorld05_0_Y3X1_Header::
    db $ff, $ff, $ff, $ff, $ff, $09, $ec, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19863D, $88

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_46C5::
KeyWorld04_0_Y3X2_Header::
    db $05, $00, $06, $07, $0b, $3a, $ed, $00 ; entry 0

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1986CD, $C1

KeyWorldScreenHeader_66_478E::
KeyWorld02_0_Y2X2_Header::
    db $04, $03, $06, $07, $08, $3a, $ee, $00 ; entry 0

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198796, $C3

KeyWorldScreenHeader_66_4859::
KeyWorld00_0_Y3X1_Header::
    db $ff, $00, $09, $0a, $0c, $3a, $ef, $00 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198861, $B6

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_4917::
KeyWorld00_0_Y3X2_Header::
    db $ff, $00, $05, $07, $08, $3a, $f0, $00 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19891F, $D8

KeyWorldScreenHeader_66_49F7::
KeyWorld27_1_Y3X1_Header::
    db $00, $06, $07, $09, $0e, $3a, $f1, $00 ; entry 0

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_1_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1989FF, $D4

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y3X1_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $40, $0f, $2c, $02, $fa, $fa, $02
    db $f4, $ff, $01, $02, $ae, $0f, $21, $02, $fe, $f2, $02, $f0, $ff, $01, $02, $a0
    db $ff, $45

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X2_Attrs::
    db $68, $01, $03, $01, $03, $00, $0f, $20, $02, $02, $03, $22, $0f, $11, $03, $34
    db $0f, $11, $02, $03, $7e, $01, $03, $70, $0f, $09, $03, $a0, $ff, $4d, $03, $ff
    db $0f, $4d, $03, $5f, $14

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0A_0_Y1X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $42, $02, $f8, $ff, $01, $02, $f8, $fe, $02
    db $f4, $ff, $01, $02, $f4, $fc, $02, $a0, $ff, $4d, $02, $ff, $0f, $4d, $02, $5f
    db $14

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X1_Attrs::
    db $68, $01, $03, $01, $03, $00, $0f, $20, $02, $02, $02, $02, $03, $24, $0f, $09
    db $03, $34, $00, $03, $fc, $f0, $03, $34, $00, $03, $36, $04, $03, $54, $0e, $03
    db $54, $04, $03, $fa, $f2, $03, $74, $0f, $05, $03, $a0, $ff, $4d, $03, $ff, $0f
    db $4d, $03, $5f, $14

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y3X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $198B6F, $51

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $198BC0, $44

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X1_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $1e, $0f, $0a, $02, $fc, $ff, $01
    db $02, $fc, $fa, $02, $fe, $f2, $02, $fc, $f8, $02, $fc, $f4, $02, $a6, $0e, $02
    db $fa, $f8, $02, $fa, $f4, $02, $cc, $0e, $02, $f8, $fa, $02, $ec, $0f, $0f, $02
    db $21, $1f, $33

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $198C37, $42

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_1_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $198C79, $5D

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_4CD6::
KeyWorld02_0_Y2X3_Header::
    db $00, $00, $02, $09, $0a, $3b, $f2, $00 ; entry 0

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198CDE, $9F

KeyWorldScreenHeader_66_4D7D::
KeyWorld00_0_Y3X3_Header::
    db $ff, $ff, $ff, $ff, $ff, $0a, $f3, $00 ; entry 0

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198D85, $5F

KeyWorldScreenHeader_66_4DE4::
KeyWorld01_0_Y3X2_Header::
    db $ff, $00, $02, $08, $09, $24, $f4, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198DEC, $82

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_4E6E::
KeyWorld01_0_Y2X3_Header::
    db $00, $ff, $ff, $ff, $ff, $24, $f5, $00 ; entry 0

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198E76, $81

KeyWorldScreenHeader_66_4EF7::
KeyWorld08_0_Y3X3_Header::
    db $02, $00, $09, $0a, $0c, $3b, $f6, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198EFF, $5B

; LZSS-compressed: 560 bytes that expand to 563 (E-0016, E-0017)
Gfx_66_4F5A::
    db $33, $02, $90, $06, $02, $1c, $02, $00, $01, $00, $07, $02, $58, $02, $02, $aa
    db $09, $17, $02, $6c, $02, $02, $be, $09, $0b, $02, $a0, $02, $02, $aa, $09, $02
    db $0c, $00, $33, $02, $e4, $0b, $02, $0b, $00, $0b, $0c, $0d, $02, $20, $12, $0e
    db $02, $01, $16, $02, $2d, $19, $02, $2d, $1f, $00, $02, $2b, $1f, $02

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_4F98::
KeyWorld03_0_Y2X2_Header::
    db $02, $00, $06, $0d, $0f, $3b, $f7, $00 ; entry 0

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $198FA0, $BC

KeyWorldScreenHeader_66_505C::
KeyWorld10_1_Y3X3_Header::
    db $ff, $04, $0b, $0c, $0e, $3b, $f8, $00 ; entry 0

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $199064, $B1

KeyWorldScreenHeader_66_5115::
KeyWorld05_0_Y3X3_Header::
    db $ff, $07, $09, $0c, $0f, $3b, $f9, $00 ; entry 0

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19911D, $6D

; LZSS-compressed: 560 bytes that expand to 567 (E-0016, E-0017)
Gfx_66_518A::
    db $37, $02, $c2, $0b, $27, $42, $43, $02, $34, $04, $02, $de, $04, $36, $37, $52
    db $53, $02, $48, $04, $02, $0c, $03, $07, $02, $2e, $04, $20, $21, $0e, $02, $b3
    db $04, $17, $02, $42, $04, $30, $00, $01, $02, $c7, $04, $0b, $02, $a0, $04, $0e
    db $01, $00, $02, $b3, $0a, $02, $0c, $03

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_51C2::
KeyWorld0F_0_Y3X1_Header::
    db $00, $06, $08, $09, $0d, $3b, $fa, $00 ; entry 0

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0F_0_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1991CA, $D6

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $13, $02, $f4, $ff, $01, $02
    db $30, $0f, $29, $02, $04, $08, $02, $78, $0f, $01, $02, $22, $0f, $43, $02, $f5
    db $0f, $4d, $02, $55, $1e

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X3_Attrs::
    db $68, $01, $03, $01, $03, $00, $05, $03, $f6, $ff, $39, $02, $02, $03, $f4, $fe
    db $03, $56, $0f, $01, $03, $f2, $ff, $01, $03, $a0, $ff, $4d, $03, $f1, $0f, $4d
    db $03, $51, $1f, $03

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y3X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $15, $02, $08, $06, $02, $28
    db $0f, $2d, $02, $74, $08, $02, $74, $0f, $05, $02, $f8, $f6, $02, $ee, $ff, $01
    db $02, $a0, $ff, $4d, $02, $1d, $1f, $37

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X3_Attrs::
    db $68, $01, $03, $01, $03, $00, $05, $03, $f6, $ff, $13, $02, $02, $03, $1e, $0f
    db $11, $02, $02, $03, $44, $0f, $11, $03, $56, $00, $03, $6c, $0f, $0d, $03, $fa
    db $f2, $03, $90, $0f, $01, $03, $90, $0f, $03, $03, $cf, $0f, $4d, $03, $2f, $1f
    db $25

KeyWorld08_0_Y3X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $3d, $02, $06, $06, $02, $50
    db $0f, $29, $02, $4c, $0c, $02, $9c, $0f, $31, $02, $fc, $f8, $02, $ec, $0f, $0d
    db $02, $1f, $1f, $35

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $199366, $47

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y3X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $19, $02, $06

; LZSS-compressed: 501 bytes that expand to 514 (E-0016, E-0017)
Gfx_66_53BA::
    db $02, $02, $28, $0f, $0b, $02, $02, $06, $02, $50, $0f, $29, $02, $fe, $f4, $02
    db $32, $06, $02, $9e, $0f, $0f, $02, $f6, $fc, $02, $f0, $ff, $01, $02, $e4, $0f
    db $11, $02, $1b, $1f, $39

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X3_Attrs::
    db $68, $01, $03, $01, $03, $00, $05, $03, $f6, $ff, $13, $02, $03, $30, $05, $03
    db $26, $0f, $0b, $03, $2c, $06, $03, $4e, $0f, $0f, $03, $2c, $02, $03, $76, $0f
    db $03, $03, $f2, $fc, $03, $9c, $0f, $37, $03, $5a, $06, $03, $f0, $0f, $09, $03
    db $fa, $0f, $13, $03, $45, $1f, $0f

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0F_0_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $199416, $61

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_5477::
KeyWorld02_0_Y0X0_Header::
    db $07, $05, $06, $0c, $0d, $3e, $0d, $01 ; entry 0

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19947F, $7E

KeyWorldScreenHeader_66_54FD::
KeyWorld00_0_Y0X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $0d, $0e, $01 ; entry 0

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $199505, $5B

KeyWorldScreenHeader_66_5560::
KeyWorld01_0_Y1X0_Header::
    db $ff, $06, $07, $0c, $0f, $27, $0f, $01 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $199568, $47

; LZSS-compressed: 522 bytes that expand to 519 (E-0016, E-0017)
Gfx_66_55AF::
    db $07, $02, $d0, $08, $02, $da, $03, $17, $02, $e4, $08, $02, $ee, $03, $0b, $22
    db $23, $02, $f8, $0d, $00, $01, $33, $02, $0c, $1d, $01, $00, $0b, $0c, $23, $02
    db $fc, $04, $02, $2a, $15, $02, $31, $11, $02, $12, $12, $50, $51

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_55DC::
KeyWorld01_0_Y0X1_Header::
    db $ff, $09, $0a, $0d, $0f, $27, $10, $01 ; entry 0

KeyWorld01_0_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1995E4, $74

KeyWorldScreenHeader_66_5658::
KeyWorld0B_0_Y0X0_Header::
    db $05, $02, $05, $06, $0c, $3e, $11, $01 ; entry 0

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $199660, $A5

KeyWorldScreenHeader_66_5705::
KeyWorld04_0_Y0X0_Header::
    db $07, $00, $08, $09, $07, $3e, $12, $01 ; entry 0

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $19970D, $AC

; LZSS-compressed: 519 bytes that expand to 519 (E-0016, E-0017)
Gfx_66_57B9::
    db $07, $02, $f6, $0a, $02, $02, $11, $17, $02, $0a, $1a, $02, $16, $11, $0b, $0c
    db $0d, $0c, $0d, $02, $f2, $00, $02, $24, $17, $02, $00, $02, $33, $02, $66, $06

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_57D9::
KeyWorld17_1_Y2X1_Header::
    db $ff, $00, $03, $04, $0a, $3e, $13, $01 ; entry 0

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1997E1, $BB

KeyWorldScreenHeader_66_589C::
KeyWorld10_1_Y0X0_Header::
    db $ff, $00, $03, $07, $09, $3e, $14, $01 ; entry 0

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1998A4, $C7

KeyWorldScreenHeader_66_596B::
KeyWorld07_0_Y0X0_Header::
    db $07, $02, $06, $07, $09, $3e, $15, $01 ; entry 0

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $199973, $4D

; LZSS-compressed: 539 bytes that expand to 536 (E-0016, E-0017)
Gfx_66_59C0::
    INCBIN "dwm2-cobi-us.gbc", $1999C0, $7B

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y0X0_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $1e, $0f, $0b, $01, $02, $7e, $03, $02
    db $72, $0f, $15, $02, $80, $08, $02, $a6, $0f, $29, $02, $a2, $0a, $02, $f0, $0f
    db $4d, $02, $82, $00

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X0_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $50, $0f, $3d, $01, $01, $01, $01, $02
    db $a0, $0f, $0f, $02, $b0, $00, $02, $c6, $0f, $0f, $02, $d6, $02, $02, $ee, $0f
    db $0d, $02, $fc, $04, $02, $16, $1f, $2b

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X0_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $28, $0f, $15, $01, $01, $02, $76, $0f
    db $0f, $01, $02, $ac, $03, $02, $a0, $0f, $09, $02, $ac, $04, $02, $c4, $0f, $0b
    db $02, $d0, $08, $02, $ee, $0f, $09, $02, $ce, $0f, $15, $02, $cc, $0a, $02, $40
    db $1f, $01

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X1_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $22, $0f, $0f, $02, $02, $02, $02, $03
    db $72, $0f, $15, $02, $02, $01, $01, $01, $01, $03, $a0, $0f, $0d, $03, $b0, $00
    db $03, $c4, $0f, $4d, $03, $e8, $0e, $03, $e8, $04, $03, $3e, $1f, $03

KeyWorld0B_0_Y0X0_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $03, $02, $20, $0f, $15, $02
    db $30, $08, $02, $54, $0f, $29, $02, $52, $0a, $02, $32, $04, $02, $a6, $0f, $01
    db $02, $52, $0f, $4b, $02, $18, $1f, $29

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $199B0F, $4B

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y2X1_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $17, $01, $01, $02, $18, $0f, $15, $02, $2a, $06
    db $02, $2a, $04, $02, $52, $0f, $0b, $02, $7a, $0f, $0f, $02, $2a, $02, $02, $a2
    db $02, $02, $2a, $00, $02, $a2, $0f, $07, $02, $ca, $08, $02, $c8, $0f, $2b, $02
    db $a8, $08, $02, $12, $1f, $0d, $02, $1a, $1a, $02, $40, $1f, $01

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $199B97, $42

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $199BD9, $59

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_66_5C32::
KeyWorld52_0_Y3X3_Header::
    db $ff, $03, $08, $09, $0a, $32, $16, $01 ; entry 0

; LZSS-compressed: 142 bytes that expand to 360 (E-0016, E-0017)
KeyWorld52_0_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $199C3A, $8E

KeyWorldScreenHeader_66_5CC8::
KeyWorld01_0_Y0X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $32, $16, $01 ; entry 0

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X0_Tiles::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader_66_5CEC::
    db $ff, $02, $05, $0a, $0d, $32, $16, $01 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_5CF4::
    INCBIN "dwm2-cobi-us.gbc", $199CF4, $9B

; record: screen header
KeyWorldScreenHeader_66_5D8F::
    db $ff, $04, $05, $06, $0b, $32, $16, $01 ; entry 0

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_5D97::
    INCBIN "dwm2-cobi-us.gbc", $199D97, $C6

KeyWorldScreenHeader_66_5E5D::
    db $ff, $03, $04, $08, $0d, $32, $16, $01 ; entry 0

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_5E65::
    INCBIN "dwm2-cobi-us.gbc", $199E65, $B9

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader_66_5F1E::
    db $ff, $06, $07, $08, $09, $32, $16, $01 ; entry 0

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_5F26::
    INCBIN "dwm2-cobi-us.gbc", $199F26, $9F

; record: screen header
KeyWorldScreenHeader_66_5FC5::
    db $ff, $ff, $ff, $ff, $ff, $32, $16, $01 ; entry 0

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_5FCD::
    INCBIN "dwm2-cobi-us.gbc", $199FCD, $85

KeyWorldScreenHeader_66_6052::
    db $ff, $ff, $ff, $ff, $ff, $32, $16, $01 ; entry 0

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_605A::
    INCBIN "dwm2-cobi-us.gbc", $19A05A, $76

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader_66_60D0::
    db $ff, $ff, $ff, $ff, $ff, $32, $16, $01 ; entry 0

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_60D8::
    INCBIN "dwm2-cobi-us.gbc", $19A0D8, $60

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld52_0_Y3X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $1b, $01, $02, $2e, $03, $02, $22, $0f, $0b, $02
    db $2e, $04, $02, $32, $08, $02, $54, $0f, $4d, $02, $b4, $0f, $41, $02, $2c, $0f
    db $15, $02, $43, $1f, $11

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X0_Attrs::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_6170::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $01, $02, $1e, $0f, $19, $02
    db $30, $06, $02, $54, $0f, $0b, $02, $22, $0f, $29, $02, $1c, $0f, $03, $02, $30
    db $0a, $02, $d2, $0f, $2f, $02, $aa, $0f, $15, $02, $4f, $1f, $05

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_619D::
    INCBIN "dwm2-cobi-us.gbc", $19A19D, $42

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_61DF::
    db $68, $01, $01, $01, $ff, $ff, $1d, $02, $02, $02, $02, $01, $20, $0f, $0d, $01
    db $30, $00, $01, $54, $02, $01, $4a, $0f, $15, $01, $30, $06, $01, $7c, $0e, $01
    db $96, $0a, $01, $4e, $0a, $01, $aa, $0f, $21, $01, $52, $04, $01, $2c, $0a, $01
    db $f4, $0f, $01, $01, $26, $0f, $1b, $01, $49, $1f, $0b

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_621A::
    db $68, $01, $03, $03, $ff, $ff, $19, $01, $03, $2c, $07, $03, $24, $0f, $07, $03
    db $2c, $00, $02, $03, $56, $03, $03, $34, $04, $03, $52, $0f, $03, $03, $5a, $04
    db $03, $5a, $02, $03, $76, $0f, $09, $03, $2c, $04, $03, $9a, $0f, $0d, $03, $7e
    db $0f, $13, $03, $54, $0f, $13, $03, $2a, $0f, $15, $03, $41, $1f, $13

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_6258::
    db $68, $01, $02, $02, $ff, $ff, $41, $01, $02, $54, $01, $02, $46, $0f, $0f, $02
    db $02, $0f, $41, $02, $50, $04, $02, $c4, $0f, $09, $02, $ea, $0f, $15, $02, $1b
    db $1f, $39

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_627A::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $46, $0f, $33, $01, $01, $01, $01, $03
    db $96, $0f, $0f, $03, $a6, $00, $03, $a6, $0c, $03, $cc, $0f, $03, $02, $02, $03
    db $e4, $0f, $11, $00, $00, $02, $02, $02, $02, $03, $46, $0c, $03, $1e, $1f, $01
    db $03, $45, $1f, $0f

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_66_62AE::
    db $68, $01, $02, $02, $ff, $ff, $41, $01, $02, $54, $07, $02, $4c, $0f, $0b, $04
    db $02, $7e, $03, $02, $72, $0f, $0f, $02, $54, $00, $02, $98, $0f, $11, $02, $80
    db $0f, $13, $02, $56, $0f, $13, $02, $1b, $1f, $39

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map54Screens0::
    dfar Map54Screens0_Y0X0 ; entry 0

Map54Attrs0::
    dfar Map54Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map54Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19A2DE, $D7

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map54Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19A3B5, $4D

; compressed tileset of map $62 (the first map record using it)
; LZSS-compressed: 1152 bytes that expand to 1312 (E-0016, E-0017)
Map62Tileset::
    INCBIN "dwm2-cobi-us.gbc", $19A402, $480

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map62Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $194c, $7fff, $01da, $0000 ; entry 1
    dw $001b, $2bff, $023f, $0000 ; entry 2
    dw $218c, $7fff, $5ab1, $0000 ; entry 3
    dw $194c, $3a9a, $01da, $0000 ; entry 4
    dw $0142, $7fff, $7e80, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 8 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map62Screens0::
    dfar Map62Screens0_Y0X0 ; entry 0
    dfar Map62Screens0_Y0X1 ; entry 1
    dfar Map62Screens0_Y1X0 ; entry 2
    dfar Map62Screens0_Y1X1 ; entry 3
    dfar Map62Screens0_Y2X0 ; entry 4
    dfar Map62Screens0_Y2X1 ; entry 5
    dfar Map62Screens0_Y3X0 ; entry 6
    dfar Map62Screens0_Y3X1 ; entry 7

Map62Attrs0::
    dfar Map62Attrs0_Y0X0 ; entry 0
    dfar Map62Attrs0_Y0X1 ; entry 1
    dfar Map62Attrs0_Y1X0 ; entry 2
    dfar Map62Attrs0_Y1X1 ; entry 3
    dfar Map62Attrs0_Y2X0 ; entry 4
    dfar Map62Attrs0_Y2X1 ; entry 5
    dfar Map62Attrs0_Y3X0 ; entry 6
    dfar Map62Attrs0_Y3X1 ; entry 7

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19A8F2, $C5

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $19A9B7, $E8

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $19AA9F, $B4

Map62Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $19AB53, $B4

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $19AC07, $AF

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $19ACB6, $90

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $19AD46, $AB

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
Map62Screens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $19ADF1, $DD

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19AECE, $5C

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $19AF2A, $61

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $19AF8B, $41

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $19AFCC, $54

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $19B020, $52

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y2X1::
    db $68, $01, $00, $01, $01, $04, $04, $01, $00, $04, $0d, $00, $02, $0f, $31, $00
    db $02, $08, $00, $52, $08, $03, $03, $00, $60, $0f, $01, $00, $86, $00, $00, $78
    db $0f, $4b, $00, $04, $02, $00, $86, $02, $00, $f0, $04, $00, $ea, $0f, $1b, $00
    db $0e, $0c, $00, $22, $18, $00, $34, $1f, $09, $00, $04, $00

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $19B0AE, $4F

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map62Attrs0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $19B0FD, $62

; compressed tileset of map $63 (the first map record using it)
; LZSS-compressed: 856 bytes that expand to 1536 (E-0016, E-0017)
Map63Tileset::
    INCBIN "dwm2-cobi-us.gbc", $19B15F, $358

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map63Palettes::
    dw $294a, $7fff, $5294, $0000 ; entry 0
    dw $24c6, $7fd9, $5ab1, $0063 ; entry 1
    dw $7da0, $7f75, $6b40, $0063 ; entry 2
    dw $7da0, $7fd9, $7380, $0063 ; entry 3
    dw $5d8c, $7fd9, $5ab1, $0000 ; entry 4
    dw $7da0, $7fd9, $7fe0, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $03e0 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map63Screens0::
    dfar Map63Screens0_Y0X0 ; entry 0
    dfar Map63Screens0_Y0X1 ; entry 1
    dfar Map63Screens0_Y1X0 ; entry 2
    dfar Map63Screens0_Y1X1 ; entry 3

Map63Attrs0::
    dfar Map63Attrs0_Y0X0 ; entry 0
    dfar Map63Attrs0_Y0X1 ; entry 1
    dfar Map63Attrs0_Y1X0 ; entry 2
    dfar Map63Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map63Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19B50F, $95

; LZSS-compressed: 168 bytes that expand to 360 (E-0016, E-0017)
Map63Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $19B5A4, $A8

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
Map63Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $19B64C, $9B

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map63Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $19B6E7, $72

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map63Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19B759, $45

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map63Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $19B79E, $49

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map63Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $19B7E7, $4E

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map63Attrs0_Y1X1::
    db $68, $01, $01, $03, $03, $03, $03, $01, $f6, $fa, $02, $02, $01, $00, $0f, $29
    db $04, $04, $04, $04, $01, $f8, $f8, $01, $10, $00, $01, $f4, $fc, $01, $60, $0a
    db $01, $5c, $02, $01, $74, $0f, $0b, $01, $82, $04, $01, $9a, $0f, $07, $01, $a6
    db $08, $01, $c0, $0f, $4d, $01, $a8, $08, $01, $3e, $1f, $15

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map64Screens0::
    dfar Map64Screens0_Y0X0 ; entry 0
    dfar Map64Screens0_Y0X1 ; entry 1
    dfar Map64Screens0_Y1X0 ; entry 2
    dfar Map64Screens0_Y1X1 ; entry 3

Map64Attrs0::
    dfar Map64Attrs0_Y0X0 ; entry 0
    dfar Map64Attrs0_Y0X1 ; entry 1
    dfar Map64Attrs0_Y1X0 ; entry 2
    dfar Map64Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
Map64Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19B889, $B0

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map64Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $19B939, $A2

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
Map64Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $19B9DB, $82

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map64Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $19BA5D, $84

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map64Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19BAE1, $67

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map64Attrs0_Y0X1::
    db $68, $01, $01, $02, $01, $00, $0f, $3c, $03, $03, $04, $04, $03, $01, $54, $01
    db $01, $52, $00, $01, $52, $00, $01, $4e, $00, $00, $00, $01, $54, $0c, $04, $04
    db $01, $66, $0e, $01, $fc, $f0, $01, $7c, $0f, $4d, $01, $b4, $0f, $17, $01, $54
    db $02, $01, $0c, $1f, $0d, $01, $4c, $02, $01, $3e, $0f, $01, $01, $00, $0a

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map64Attrs0_Y1X0::
    db $68, $01, $00, $02, $02, $03, $03, $02, $00, $04, $0d, $00, $02, $0f, $2b, $00
    db $52, $02, $04, $04, $00, $58, $02, $00, $4e, $0f, $09, $00, $5a, $04, $00, $72
    db $0f, $11, $00, $56, $04, $00, $9e, $0f, $0d, $00, $6e, $0f, $19, $00, $52, $00
    db $00, $ee, $0f, $11, $00, $72, $0f, $09, $00, $3e, $1f, $13

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
Map64Attrs0_Y1X1::
    db $68, $01, $00, $02, $02, $02, $02, $03, $03, $00, $00, $00, $00, $06, $0a, $00
    db $04, $0f, $27, $03, $00, $52, $0b, $00, $4e, $0f, $2d, $00, $9e, $0f, $3d, $00
    db $52, $0f, $4d, $00, $9e, $0f, $03

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map65Screens0::
    dfar Map65Screens0_Y0X0 ; entry 0
    dfar Map65Screens0_Y0X1 ; entry 1
    dfar Map65Screens0_Y1X0 ; entry 2
    dfar Map65Screens0_Y1X1 ; entry 3

Map65Attrs0::
    dfar Map65Attrs0_Y0X0 ; entry 0
    dfar Map65Attrs0_Y0X1 ; entry 1
    dfar Map65Attrs0_Y1X0 ; entry 2
    dfar Map65Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map65Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19BC02, $52

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map65Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $19BC54, $60

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
Map65Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $19BCB4, $61

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map65Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $19BD15, $BD

; LZSS-compressed: 38 bytes that expand to 360 (E-0016, E-0017)
Map65Attrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $03, $00, $52, $0d, $00, $50, $0f, $03
    db $04, $00, $7a, $0d, $00, $78, $0f, $03, $00, $52, $0f, $4d, $00, $b2, $0f, $3d
    db $00, $4e, $0f, $01, $02, $02

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
Map65Attrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3c, $03, $00, $50, $0d, $00, $4e, $0f, $03
    db $04, $00, $78, $0d, $00, $76, $0f, $03, $00, $50, $0f, $4d, $00, $b0, $0f, $2d
    db $00, $00, $0f, $15

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
Map65Attrs0_Y1X0::
    db $68, $01, $00, $02, $02, $03, $00, $02, $0b, $02, $02, $00, $00, $0f, $03, $04
    db $00, $2a, $0b, $00, $26, $0f, $05, $00, $02, $0f, $4d, $00, $62, $0f, $4d, $00
    db $c2, $0f, $1d, $00, $3e, $1f, $13

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map65Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $19BE43, $76

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map67Screens0::
    dfar Map67Screens0_Y0X0 ; entry 0

Map67Attrs0::
    dfar Map67Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
Map67Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19BEBF, $D0

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
Map67Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $19BF8F, $58
    ds $19, $00
