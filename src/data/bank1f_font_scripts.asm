; ROM bank $1F: the font, scripts, strings and SGB data
; The annotated listing of this bank is build/listing/bank1f.asm.

SECTION "Bank 1F", ROMX[$4000], BANK[$1F]
    db $1f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; GlyphCopyArgsForA and LoadSixteenGlyphTilesFromTable copy the 16 bytes at $4010 + 16 * glyph from
; bank $1F to VRAM, and CopyGlyphTilesToVRAM takes one glyph per text byte, so the glyph number is
; the character code; 259 glyphs up to SendSGBPacketSet at $5040 (E-0169, C1)
; record: glyph tile (2bpp, 16 bytes)
GlyphFont::
    ASSERT (GlyphFont & 1) == 0, "DrawTextGlyph steps a glyph's 2-byte rows with inc e (E-0388): rows must not cross a 256-byte page"
    db $ff, $7c, $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $7c, $ff, $00 ; id 0 '0'
    db $ff, $10, $ff, $30, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $7c, $ff, $00 ; id 1 '1'
    db $ff, $7c, $ff, $82, $ff, $02, $ff, $0c, $ff, $30, $ff, $40, $ff, $fe, $ff, $00 ; id 2 '2'
    db $ff, $7c, $ff, $82, $ff, $02, $ff, $3c, $ff, $02, $ff, $82, $ff, $7c, $ff, $00 ; id 3 '3'
    db $ff, $0c, $ff, $14, $ff, $24, $ff, $44, $ff, $84, $ff, $fe, $ff, $04, $ff, $00 ; id 4 '4'
    db $ff, $fc, $ff, $80, $ff, $80, $ff, $fc, $ff, $02, $ff, $82, $ff, $7c, $ff, $00 ; id 5 '5'
    db $ff, $7c, $ff, $82, $ff, $80, $ff, $fc, $ff, $82, $ff, $82, $ff, $7c, $ff, $00 ; id 6 '6'
    db $ff, $7e, $ff, $82, $ff, $02, $ff, $04, $ff, $04, $ff, $08, $ff, $08, $ff, $00 ; id 7 '7'
    db $ff, $7c, $ff, $82, $ff, $82, $ff, $7c, $ff, $82, $ff, $82, $ff, $7c, $ff, $00 ; id 8 '8'
    db $ff, $7c, $ff, $82, $ff, $82, $ff, $7e, $ff, $02, $ff, $82, $ff, $7c, $ff, $00 ; id 9 '9'
    db $ff, $10, $ff, $28, $ff, $28, $ff, $44, $ff, $7c, $ff, $82, $ff, $82, $ff, $00 ; id 10 'A'
    db $ff, $f8, $ff, $84, $ff, $84, $ff, $fc, $ff, $82, $ff, $82, $ff, $fc, $ff, $00 ; id 11 'B'
    db $ff, $3c, $ff, $42, $ff, $80, $ff, $80, $ff, $80, $ff, $42, $ff, $3c, $ff, $00 ; id 12 'C'
Tiles1Plus260Tiles::
    db $ff, $f8, $ff, $84, $ff, $82, $ff, $82, $ff, $82, $ff, $84, $ff, $f8, $ff, $00 ; id 13 'D'
    db $ff, $fe, $ff, $80, $ff, $80, $ff, $fc, $ff, $80, $ff, $80, $ff, $fe, $ff, $00 ; id 14 'E'
    db $ff, $fe, $ff, $80, $ff, $80, $ff, $fc, $ff, $80, $ff, $80, $ff, $80, $ff, $00 ; id 15 'F'
Tiles2Plus7F0Tiles::
    db $ff, $3c, $ff, $42, $ff, $80, $ff, $9e, $ff, $82, $ff, $42, $ff, $3c, $ff, $00 ; id 16 'G'
Tiles1Plus710Tiles::
    db $ff, $82, $ff, $82, $ff, $82, $ff, $fe, $ff, $82, $ff, $82, $ff, $82, $ff, $00 ; id 17 'H'
Tiles2Plus210Tiles::
    db $ff, $7c, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $7c, $ff, $00 ; id 18 'I'
    db $ff, $7e, $ff, $08, $ff, $08, $ff, $08, $ff, $88, $ff, $88, $ff, $70, $ff, $00 ; id 19 'J'
    db $ff, $84, $ff, $88, $ff, $90, $ff, $b0, $ff, $c8, $ff, $84, $ff, $82, $ff, $00 ; id 20 'K'
Tiles2Plus200Tiles::
    db $ff, $80, $ff, $80, $ff, $80, $ff, $80, $ff, $80, $ff, $80, $ff, $fe, $ff, $00 ; id 21 'L'
Tiles2Plus240Tiles::
    db $ff, $82, $ff, $c6, $ff, $aa, $ff, $92, $ff, $82, $ff, $82, $ff, $82, $ff, $00 ; id 22 'M'
Tiles1Plus6E0Tiles::
    db $ff, $82, $ff, $c2, $ff, $a2, $ff, $92, $ff, $8a, $ff, $86, $ff, $82, $ff, $00 ; id 23 'N'
Tiles2Plus230Tiles::
    db $ff, $38, $ff, $44, $ff, $82, $ff, $82, $ff, $82, $ff, $44, $ff, $38, $ff, $00 ; id 24 'O'
Tiles1Plus770Tiles::
    db $ff, $fc, $ff, $82, $ff, $82, $ff, $fc, $ff, $80, $ff, $80, $ff, $80, $ff, $00 ; id 25 'P'
    db $ff, $38, $ff, $44, $ff, $82, $ff, $82, $ff, $8a, $ff, $44, $ff, $3a, $ff, $00 ; id 26 'Q'
    db $ff, $fc, $ff, $82, $ff, $82, $ff, $fc, $ff, $88, $ff, $84, $ff, $82, $ff, $00 ; id 27 'R'
Tiles2Plus250Tiles::
    db $ff, $78, $ff, $84, $ff, $80, $ff, $7c, $ff, $02, $ff, $82, $ff, $7c, $ff, $00 ; id 28 'S'
    db $ff, $fe, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 29 'T'
    db $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $7c, $ff, $00 ; id 30 'U'
    db $ff, $82, $ff, $82, $ff, $44, $ff, $44, $ff, $28, $ff, $28, $ff, $10, $ff, $00 ; id 31 'V'
Tiles1Plus700Tiles::
    db $ff, $82, $ff, $92, $ff, $aa, $ff, $aa, $ff, $c6, $ff, $c6, $ff, $82, $ff, $00 ; id 32 'W'
    db $ff, $c6, $ff, $44, $ff, $28, $ff, $10, $ff, $28, $ff, $44, $ff, $c6, $ff, $00 ; id 33 'X'
Tiles2Plus700Tiles::
    db $ff, $82, $ff, $44, $ff, $28, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 34 'Y'
    db $ff, $fe, $ff, $04, $ff, $08, $ff, $10, $ff, $20, $ff, $40, $ff, $fe, $ff, $00 ; id 35 'Z'
Tiles1Plus2F0Tiles::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $04, $ff, $7c, $ff, $84, $ff, $7e, $ff, $00 ; id 36 'a'
Tiles1Plus4F0Tiles::
    db $ff, $80, $ff, $80, $ff, $80, $ff, $f8, $ff, $84, $ff, $84, $ff, $f8, $ff, $00 ; id 37 'b'
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $80, $ff, $84, $ff, $78, $ff, $00 ; id 38 'c'
Tiles1Plus2E0Tiles::
    db $ff, $04, $ff, $04, $ff, $04, $ff, $7c, $ff, $84, $ff, $84, $ff, $7c, $ff, $00 ; id 39 'd'
Tiles2Plus710Tiles::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $fc, $ff, $80, $ff, $7c, $ff, $00 ; id 40 'e'
    db $ff, $18, $ff, $24, $ff, $20, $ff, $fc, $ff, $20, $ff, $20, $ff, $20, $ff, $00 ; id 41 'f'
    db $ff, $00, $ff, $00, $ff, $7c, $ff, $84, $ff, $84, $ff, $7c, $ff, $04, $ff, $f8 ; id 42 'g'
    db $ff, $80, $ff, $80, $ff, $80, $ff, $f8, $ff, $84, $ff, $84, $ff, $84, $ff, $00 ; id 43 'h'
Tiles1Plus2E0Tiles_2::
    db $ff, $00, $ff, $10, $ff, $00, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 44 'i'
    db $ff, $00, $ff, $10, $ff, $00, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $60 ; id 45 'j'
    db $ff, $80, $ff, $80, $ff, $8c, $ff, $b0, $ff, $c0, $ff, $b0, $ff, $8c, $ff, $00 ; id 46 'k'
Tiles1Plus7C0Tiles::
    db $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 47 'l'
Tiles2Plus7B0Tiles::
    db $ff, $00, $ff, $00, $ff, $ec, $ff, $92, $ff, $92, $ff, $92, $ff, $92, $ff, $00 ; id 48 'm'
Tiles2Plus710Tiles_2::
    db $ff, $00, $ff, $00, $ff, $f8, $ff, $84, $ff, $84, $ff, $84, $ff, $84, $ff, $00 ; id 49 'n'
Tiles1Plus6F0Tiles::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $84, $ff, $84, $ff, $78, $ff, $00 ; id 50 'o'
Tiles1Plus250Tiles::
    db $ff, $00, $ff, $00, $ff, $f8, $ff, $84, $ff, $84, $ff, $f8, $ff, $80, $ff, $80 ; id 51 'p'
    db $ff, $00, $ff, $00, $ff, $7c, $ff, $84, $ff, $84, $ff, $7c, $ff, $04, $ff, $04 ; id 52 'q'
    db $ff, $00, $ff, $00, $ff, $9c, $ff, $a0, $ff, $c0, $ff, $80, $ff, $80, $ff, $00 ; id 53 'r'
Tiles2Plus720Tiles::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $80, $ff, $78, $ff, $04, $ff, $f8, $ff, $00 ; id 54 's'
    db $ff, $00, $ff, $20, $ff, $fc, $ff, $20, $ff, $20, $ff, $20, $ff, $1c, $ff, $00 ; id 55 't'
    db $ff, $00, $ff, $00, $ff, $84, $ff, $84, $ff, $84, $ff, $84, $ff, $78, $ff, $00 ; id 56 'u'
    db $ff, $00, $ff, $00, $ff, $84, $ff, $84, $ff, $84, $ff, $48, $ff, $30, $ff, $00 ; id 57 'v'
    db $ff, $00, $ff, $00, $ff, $82, $ff, $92, $ff, $92, $ff, $aa, $ff, $44, $ff, $00 ; id 58 'w'
Tiles1Plus2D0Tiles::
    db $ff, $00, $ff, $00, $ff, $84, $ff, $48, $ff, $30, $ff, $48, $ff, $84, $ff, $00 ; id 59 'x'
    db $ff, $00, $ff, $00, $ff, $84, $ff, $84, $ff, $84, $ff, $7c, $ff, $04, $ff, $f8 ; id 60 'y'
    db $ff, $00, $ff, $00, $ff, $fc, $ff, $08, $ff, $30, $ff, $40, $ff, $fc, $ff, $00 ; id 61 'z'
    db $ff, $80, $ff, $80, $ff, $3c, $ff, $40, $ff, $3c, $ff, $02, $ff, $7c, $ff, $00 ; id 62 ''s'
    db $ff, $80, $ff, $80, $ff, $76, $ff, $49, $ff, $49, $ff, $49, $ff, $49, $ff, $00 ; id 63 ''m'
    db $ff, $80, $ff, $80, $ff, $0e, $ff, $50, $ff, $60, $ff, $40, $ff, $40, $ff, $00 ; id 64 ''r'
    db $ff, $80, $ff, $90, $ff, $7e, $ff, $10, $ff, $10, $ff, $10, $ff, $0e, $ff, $00 ; id 65 ''t'
    db $ff, $80, $ff, $80, $ff, $00, $ff, $42, $ff, $42, $ff, $24, $ff, $18, $ff, $00 ; id 66 ''v'
    db $ff, $88, $ff, $88, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $00 ; id 67 ''l'
Tiles1Plus6F0Tiles_2::
    db $ff, $82, $ff, $82, $ff, $02, $ff, $3e, $ff, $42, $ff, $42, $ff, $3e, $ff, $00 ; id 68
    db $ff, $00, $ff, $20, $ff, $a8, $ff, $72, $ff, $70, $ff, $a8, $ff, $22, $ff, $00 ; id 69 '*:'
    db $ff, $70, $ff, $20, $ff, $20, $ff, $20, $ff, $20, $ff, $20, $ff, $70, $ff, $00 ; id 70
Tiles1Plus7B0Tiles::
    db $ff, $f8, $ff, $50, $ff, $50, $ff, $50, $ff, $50, $ff, $50, $ff, $f8, $ff, $00 ; id 71
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 72
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 73
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 74
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 75
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 76
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 77
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 78
Tiles1Plus4C0Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 79
Tiles1Plus6E0Tiles_2::
    db $ff, $00, $ff, $ee, $ff, $92, $ff, $92, $ff, $92, $ff, $92, $ff, $d6, $ff, $fe ; id 80
    db $ff, $0e, $ff, $1b, $ff, $11, $ff, $1b, $ff, $3e, $ff, $70, $ff, $e0, $ff, $c0 ; id 81
    db $ff, $0c, $ff, $1e, $ff, $65, $ff, $b9, $ff, $c9, $ff, $7f, $ff, $4a, $ff, $4e ; id 82
    db $ff, $03, $ff, $05, $ff, $ca, $ff, $74, $ff, $28, $ff, $78, $ff, $ec, $ff, $c4 ; id 83
    db $ff, $00, $ff, $ff, $ff, $4e, $ff, $2c, $ff, $18, $ff, $3c, $ff, $6e, $ff, $ff ; id 84
    db $ff, $18, $ff, $24, $ff, $7e, $ff, $c3, $ff, $81, $ff, $81, $ff, $42, $ff, $3c ; id 85
    db $ff, $06, $ff, $0a, $ff, $12, $ff, $12, $ff, $62, $ff, $bf, $ff, $81, $ff, $7e ; id 86
    db $ff, $3c, $ff, $7e, $ff, $ff, $ff, $ff, $ff, $81, $ff, $a5, $ff, $85, $ff, $ff ; id 87
    db $ff, $1c, $ff, $10, $ff, $d6, $ff, $ba, $ff, $82, $ff, $ba, $ff, $aa, $ff, $ee ; id 88
    db $ff, $38, $ff, $6c, $ff, $c6, $ff, $ee, $ff, $82, $ff, $fe, $ff, $aa, $ff, $ee ; id 89
    db $ff, $3c, $ff, $42, $ff, $99, $ff, $bd, $ff, $bd, $ff, $a5, $ff, $bd, $ff, $c3 ; id 90
    db $ff, $0e, $ff, $11, $ff, $15, $ff, $19, $ff, $2e, $ff, $58, $ff, $a0, $ff, $e0 ; id 91
    db $ff, $3c, $ff, $7e, $ff, $b9, $ff, $99, $ff, $d1, $ff, $46, $ff, $3c, $ff, $00 ; id 92
    db $ff, $36, $ff, $2a, $ff, $22, $ff, $2a, $ff, $22, $ff, $2a, $ff, $5d, $ff, $55 ; id 93
    db $ff, $7f, $ff, $41, $ff, $7f, $ff, $49, $ff, $7f, $ff, $49, $ff, $2a, $ff, $1c ; id 94
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 95
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 96
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 97
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 98
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 99
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 100
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 101
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 102
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 103
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 104
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 105
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 106
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 107
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 108
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 109
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 110
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 111
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 112
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 113
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 114
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 115
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 116
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 117
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 118
Tiles1Plus7C0Tiles_2::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 119
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 120
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 121
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 122
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 123
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 124
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 125
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 126
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 127
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 128
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 129
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 130
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 131
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 132
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 133
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 134
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 135
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 136
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 137
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 138
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 139
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 140
CopyGlyphTilesToVRAM_Data1::
    db $ff, $05, $ff, $05, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 141
CopyGlyphTilesToVRAM_Data2::
    db $ff, $02, $ff, $05, $ff, $02, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 142
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $30, $ff, $48, $ff, $48, $ff, $30 ; id 143
Tiles2Plus710Tiles_3::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 144 ' '
    db $ff, $00, $eb, $08, $ed, $70, $ff, $82, $b7, $ca, $8b, $fe, $f7, $74, $ff, $00 ; id 145
    db $ff, $00, $ff, $24, $ff, $54, $ff, $58, $ff, $2a, $ff, $15, $ff, $15, $ff, $22 ; id 146
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $66, $ff, $66, $ff, $00 ; id 147
    db $ff, $00, $ff, $00, $ff, $00, $ff, $60, $ff, $00, $ff, $60, $ff, $20, $ff, $40 ; id 148
    db $ff, $60, $ff, $60, $ff, $20, $ff, $40, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 149 '''
    db $ff, $00, $ff, $0e, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $00, $ff, $00 ; id 150
    db $ff, $00, $ff, $00, $ff, $00, $ff, $20, $ff, $20, $ff, $20, $ff, $20, $ff, $e0 ; id 151
Tiles2Plus420Tiles::
    db $ff, $00, $ff, $3c, $ff, $66, $ff, $66, $ff, $0c, $ff, $18, $ff, $00, $ff, $18 ; id 152 '?'
    db $ff, $00, $ff, $0c, $ff, $0c, $ff, $0c, $ff, $08, $ff, $08, $ff, $00, $ff, $18 ; id 153 '!'
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $40, $ff, $60, $ff, $60 ; id 154
    db $ff, $00, $ff, $00, $ff, $00, $ff, $18, $ff, $18, $ff, $00, $ff, $00, $ff, $00 ; id 155
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $fe, $ff, $00, $ff, $00, $ff, $00 ; id 156 '-'
    db $ff, $00, $ff, $00, $ff, $00, $ff, $60, $ff, $92, $ff, $0c, $ff, $00, $ff, $00 ; id 157 '~'
    db $ff, $00, $ff, $02, $ff, $04, $ff, $08, $ff, $10, $ff, $20, $ff, $40, $ff, $80 ; id 158 '/'
    db $ff, $00, $ff, $10, $ff, $92, $ff, $54, $ff, $38, $ff, $54, $ff, $92, $ff, $10 ; id 159
    db $ff, $00, $ff, $08, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $08 ; id 160 '('
    db $ff, $00, $ff, $10, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $10 ; id 161 ')'
    db $ff, $00, $ff, $00, $ff, $10, $ff, $10, $ff, $7c, $ff, $10, $ff, $10, $ff, $00 ; id 162 '+'
Tiles1Plus7D0Tiles::
    db $ff, $00, $ff, $18, $ff, $18, $ff, $00, $ff, $00, $ff, $18, $ff, $18, $ff, $00 ; id 163 ':'
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $92, $ff, $00 ; id 164 '…'
Tiles1Plus6A0Tiles::
    db $ff, $00, $ff, $80, $ff, $80, $ff, $80, $ff, $8a, $ff, $8a, $ff, $84, $ff, $f4 ; id 165
Tiles1Plus7F0Tiles::
    db $ff, $00, $ff, $e0, $ff, $80, $ff, $80, $ff, $ea, $ff, $84, $ff, $84, $ff, $ea ; id 166
Tiles1Plus7E0Tiles::
    db $ff, $00, $ff, $1e, $ff, $06, $ff, $0a, $ff, $72, $ff, $90, $ff, $90, $ff, $60 ; id 167
Tiles1Plus7F0Tiles_2::
    db $ff, $00, $ff, $38, $ff, $44, $ff, $44, $ff, $38, $ff, $10, $ff, $7c, $ff, $10 ; id 168
Tiles2Plus20Tiles::
    db $ff, $00, $ff, $10, $ff, $38, $ff, $7c, $ff, $fe, $ff, $38, $ff, $38, $ff, $38 ; id 169
    db $ff, $00, $ff, $6c, $ff, $6c, $ff, $24, $ff, $48, $ff, $00, $ff, $00, $ff, $00 ; id 170
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $60, $ff, $60, $ff, $20, $ff, $40 ; id 171 ','
Tiles1Plus4A0Tiles::
    db $ff, $00, $ff, $10, $ff, $10, $ff, $fe, $ff, $7c, $ff, $38, $ff, $7c, $ff, $c6 ; id 172 '★'
Tiles2Plus30Tiles::
    db $ff, $38, $ff, $38, $ff, $38, $ff, $fe, $ff, $7c, $ff, $38, $ff, $10, $ff, $00 ; id 173
    db $ff, $00, $ff, $10, $ff, $30, $ff, $7e, $ff, $fe, $ff, $7e, $ff, $30, $ff, $10 ; id 174
    db $ff, $00, $ff, $10, $ff, $18, $ff, $fc, $ff, $fe, $ff, $fc, $ff, $18, $ff, $10 ; id 175
    db $ff, $00, $ff, $7c, $ff, $78, $ff, $7c, $ff, $7e, $ff, $5c, $ff, $08, $ff, $00 ; id 176
    db $ff, $00, $ff, $3e, $ff, $1e, $ff, $3e, $ff, $7e, $ff, $3a, $ff, $10, $ff, $00 ; id 177
    db $ff, $00, $ff, $08, $ff, $5c, $ff, $7e, $ff, $7c, $ff, $78, $ff, $7c, $ff, $00 ; id 178
    db $ff, $00, $ff, $10, $ff, $3a, $ff, $7e, $ff, $3e, $ff, $1e, $ff, $3e, $ff, $00 ; id 179
    db $ff, $f0, $ff, $20, $ff, $40, $ff, $f0, $ff, $0f, $ff, $02, $ff, $04, $ff, $0f ; id 180
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $18, $ff, $18 ; id 181 '.'
    db $ff, $00, $ff, $20, $ff, $50, $ff, $50, $ff, $20, $ff, $54, $ff, $8c, $ff, $72 ; id 182
    db $ff, $00, $ff, $06, $ff, $06, $ff, $02, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 183
    db $ff, $00, $ff, $38, $ff, $44, $ff, $ba, $ff, $a2, $ff, $ba, $ff, $44, $ff, $38 ; id 184 '©'
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 185
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 186
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 187
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 188
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 189
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 190
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 191
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 192
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 193
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 194
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 195
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 196
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 197
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 198
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 199
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 200
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 201
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 202
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 203
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 204
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 205
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 206
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 207
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 208
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 209
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 210
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 211
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 212
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 213
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 214
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 215
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 216
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 217
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 218
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 219
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 220
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 221
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 222
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 223
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 224
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 225
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 226
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 227
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 228
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 229
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 230
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 231
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 232
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 233
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 234
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 235
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 236
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 237
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 238
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 239
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 240
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 241
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 242
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 243
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 244
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 245
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 246
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 247
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 248
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 249
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 250
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 251
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 252
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 253
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 254
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 255
    db $ff, $82, $ff, $c2, $ff, $a2, $ff, $92, $ff, $8a, $ff, $86, $ff, $82, $ff, $00 ; id 256
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $84, $ff, $84, $ff, $78, $ff, $00 ; id 257
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 258

; Sends a Super Game Boy command packet set when wSGBActive is nonzero, and returns at once when it
; is 0. wSGBPacketIndex $FF selects the packet buffer at wSGBPacketBuffer; any other value picks the
; pointer at entry wSGBPacketIndex of SGBPacketSetTable. The low 3 bits of the first byte are the
; packet count (0 sends nothing); each 16-byte packet goes out through rP1 as a reset pulse ($00
; then $30), 128 bits (a 1 bit as $10, a 0 bit as $20, each followed by $30) and a stop bit, with
; SpinDelay between packets. Called by farcall_b from banks $00, $02, $07, $1C and $E0. (C2, E-0378)
; returns at once when wSGBActive is 0; otherwise sends the packet set chosen by wSGBPacketIndex
; ($FF = the buffer at wSGBPacketBuffer, else the pointer in the table at $5094): the packet count
; is the first byte's low 3 bits, each 16-byte packet is sent through rP1 as a $00/$30 reset pulse,
; 128 bits (a 1 bit is written as $10, a 0 bit as $20, each followed by $30) and a stop bit
SendSGBPacketSet::
    ld a, [wSGBActive]
    or a
    ret z
    ld a, [wSGBPacketIndex]
    cp $ff
    jr nz, .skip
    ld hl, wSGBPacketBuffer
    jr .skip2

.skip:
    ld l, a
    ld h, $00
    add hl, hl
    ld de, SGBPacketSetTable
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    pop hl

.skip2:
    ld a, [hl]
    and $07
    ret z
    ld b, a
    ld c, $00

.skip3:
    push bc
    ld a, $00
    ldh [c], a
    ld a, $30
    ldh [c], a
    ld b, $10

.loop:
    ld e, $08
    ld a, [hli]
    ld d, a

.loop2:
    bit 0, d
    ld a, $10
    jr nz, .skip4
    ld a, $20

.skip4:
    ldh [c], a
    ld a, $30
    ldh [c], a
    rr d
    dec e
    jr nz, .loop2
    dec b
    jr nz, .loop
    ld a, $20
    ldh [c], a
    ld a, $30
    ldh [c], a
    pop bc
    dec b
    ret z
    call SpinDelay
    jr .skip3

; SendSGBPacketSet reads the word $5094 + 2 * wSGBPacketIndex ($FF selects wSGBPacketBuffer instead)
; and sends byte-0 & 7 packets of 16 bytes from there through the joypad register (E-0179, C1)
; record: first 16-byte SGB packet of this set
SGBPacketSetTable::
    dw SgbMaskEn_SGBPacketSetTable_0 ; id 0
    dw SgbMaskEn_SGBPacketSetTable_1 ; id 1
    dw SGBPackets ; id 2
    dw SgbDataSnd_SGBPacketSetTable_3 ; id 3
    dw SgbDataSnd_SGBPacketSetTable_4 ; id 4
    dw SgbDataSnd_SGBPacketSetTable_5 ; id 5
    dw SgbDataSnd_SGBPacketSetTable_6 ; id 6
    dw SgbDataSnd_SGBPacketSetTable_7 ; id 7
    dw SgbDataSnd_SGBPacketSetTable_8 ; id 8
    dw SgbDataSnd_SGBPacketSetTable_9 ; id 9
    dw SgbMltReq_SGBPacketSetTable_10 ; id 10
    dw SgbMltReq_SGBPacketSetTable_11 ; id 11
    dw SgbPalTrn_SGBPacketSetTable_12 ; id 12
    dw SgbAttrTrn_SGBPacketSetTable_13 ; id 13
    dw SgbPalSet_SGBPacketSetTable_14 ; id 14
    dw SgbPctTrn_SGBPacketSetTable_15 ; id 15
    dw SgbChrTrn_SGBPacketSetTable_16 ; id 16
    dw SgbChrTrn_SGBPacketSetTable_17 ; id 17
    dw SGBPackets_12 ; id 18
    dw SgbIconEn_SGBPacketSetTable_19 ; id 19
    dw SgbMaskEn_SGBPacketSetTable_20 ; id 20

; the packets SGBPacketSetTable points at; each set is one packet here; 21 packets end at $520E
; (E-0179, C1)
; record: SGB packet (byte 0 = command * 8 + packet count)
SGBPackets::
; entry 0 of SGBPackets, whose note is above (E-0381, E-0387)
SgbDataSnd1F_1::
    db $79, $5d, $08, $00, $0b, $8c, $d0, $f4, $60, $00, $00, $00, $00, $00, $00, $00 ; id 0
SgbDataSnd_SGBPacketSetTable_3::
    db $79, $52, $08, $00, $0b, $a9, $e7, $9f, $01, $c0, $7e, $e8, $e8, $e8, $e8, $e0 ; id 1
SgbDataSnd_SGBPacketSetTable_4::
    db $79, $47, $08, $00, $0b, $c4, $d0, $16, $a5, $cb, $c9, $05, $d0, $10, $a2, $28 ; id 2
SgbDataSnd_SGBPacketSetTable_5::
    db $79, $3c, $08, $00, $0b, $f0, $12, $a5, $c9, $c9, $c8, $d0, $1c, $a5, $ca, $c9 ; id 3
SgbDataSnd_SGBPacketSetTable_6::
    db $79, $31, $08, $00, $0b, $0c, $a5, $ca, $c9, $7e, $d0, $06, $a5, $cb, $c9, $7e ; id 4
SgbDataSnd_SGBPacketSetTable_7::
    db $79, $26, $08, $00, $0b, $39, $cd, $48, $0c, $d0, $34, $a5, $c9, $c9, $80, $d0 ; id 5
SgbDataSnd_SGBPacketSetTable_8::
    db $79, $1b, $08, $00, $0b, $ea, $ea, $ea, $ea, $ea, $a9, $01, $cd, $4f, $0c, $d0 ; id 6
SgbDataSnd_SGBPacketSetTable_9::
    db $79, $10, $08, $00, $0b, $4c, $20, $08, $ea, $ea, $ea, $ea, $ea, $60, $ea, $ea ; id 7
SgbMaskEn_SGBPacketSetTable_0::
    db $b9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 8
SgbMaskEn_SGBPacketSetTable_1::
    db $b9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
SgbMltReq_SGBPacketSetTable_10::
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
SgbMltReq_SGBPacketSetTable_11::
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
SgbPalTrn_SGBPacketSetTable_12::
    db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
SgbAttrTrn_SGBPacketSetTable_13::
    db $a9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
SgbPalSet_SGBPacketSetTable_14::
    db $51, $00, $00, $01, $00, $02, $00, $03, $00, $c0, $00, $00, $00, $00, $00, $00 ; id 14
SgbPctTrn_SGBPacketSetTable_15::
    db $a1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
SgbChrTrn_SGBPacketSetTable_16::
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
SgbChrTrn_SGBPacketSetTable_17::
    db $99, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17
SGBPackets_12::
    db $c9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
SgbIconEn_SGBPacketSetTable_19::
    db $71, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19
SgbMaskEn_SGBPacketSetTable_20::
    db $b9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 20

; Bank $1F copy of the string display starter: loads DE with
; BeginStringDisplay_Bank1F_StringCategories (this bank has one category with one string) and calls
; BeginStringDisplay, which blanks the text window, points the text printer at the string and sets
; wTextFlags to 1; the drawing happens later in StepTextPrinter. Its only caller is a farcall from
; the debug menu code in bank $01. The 14 bytes after its ret have no label: they decode as a second
; copy of this routine (ld de, $5223 / call BeginStringDisplay / ret) and a wrapper that prints the
; string to its end (call BeginStringDisplay_Bank1F / call RunStringDisplayToEnd / ret), the pair
; that bank $28 labels BeginStringDisplay_Bank28 and ShowString_Bank28. (C1, E-0378)
; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank1F::
    ld de, BeginStringDisplay_Bank1F_StringCategories
    call BeginStringDisplay
    ret
    db $11, $23, $52, $cd, $fe, $25, $c9, $cd, $0e, $52, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank1F_StringCategories::
    dw StringList_Bank1F_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank1F_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank1F_StringCategories_0::
    dw String_1F_00_00 ; id 0
    dw String_1F_00_00 ; id 1
    dw String_1F_00_02 ; id 2
    dw String_1F_00_03 ; id 3
    dw String_1F_00_04 ; id 4
    dw String_1F_00_05 ; id 5
    dw String_1F_00_06 ; id 6
    dw String_1F_00_07 ; id 7
    dw String_1F_00_08 ; id 8
    dw String_1F_00_09 ; id 9
    dw String_1F_00_0A ; id 10
    dw String_1F_00_0B ; id 11
    dw String_1F_00_0C ; id 12
    dw String_1F_00_0D ; id 13
    dw String_1F_00_0E ; id 14
    dw String_1F_00_0F ; id 15
    dw String_1F_00_10 ; id 16
    dw String_1F_00_11 ; id 17
    dw String_1F_00_12 ; id 18
    dw String_1F_00_13 ; id 19
    dw String_1F_00_14 ; id 20
    dw String_1F_00_14 ; id 21
    dw String_1F_00_16 ; id 22
    dw String_1F_00_17 ; id 23
    dw String_1F_00_18 ; id 24
    dw String_1F_00_19 ; id 25
    dw String_1F_00_1A ; id 26
    dw String_1F_00_1B ; id 27
    dw String_1F_00_1C ; id 28
    dw String_1F_00_1D ; id 29
    dw String_1F_00_1E ; id 30
    dw String_1F_00_1E ; id 31
    dw String_1F_00_1E ; id 32
    dw String_1F_00_1E ; id 33
    dw String_1F_00_22 ; id 34
    dw String_1F_00_23 ; id 35
    dw String_1F_00_24 ; id 36
    dw String_1F_00_25 ; id 37
    dw String_1F_00_26 ; id 38
    dw String_1F_00_27 ; id 39
    dw String_1F_00_28 ; id 40
    dw String_1F_00_29 ; id 41
    dw String_1F_00_2A ; id 42
    dw String_1F_00_2B ; id 43
    dw String_1F_00_2C ; id 44
    dw String_1F_00_2D ; id 45
    dw String_1F_00_2E ; id 46
    dw String_1F_00_2F ; id 47
    dw String_1F_00_30 ; id 48
    dw String_1F_00_31 ; id 49
    dw String_1F_00_32 ; id 50
    dw String_1F_00_33 ; id 51
    dw String_1F_00_34 ; id 52
    dw String_1F_00_34 ; id 53
    dw String_1F_00_36 ; id 54
    dw String_1F_00_37 ; id 55
    dw String_1F_00_38 ; id 56
    dw String_1F_00_39 ; id 57
    dw String_1F_00_3A ; id 58
    dw String_1F_00_3B ; id 59
    dw String_1F_00_3C ; id 60
    dw String_1F_00_3D ; id 61
    dw Script_SwapMonsters ; id 62
    dw Script_SwapMonsters ; id 63

String_1F_00_00::
    db "<VOICE1>Cobi: Is your<LINE>"
    db "adventure done?<PROMPT>"
    db "<NEXT>Or do you need"
    db "<NEXT>something?<WAIT>"
    db "@"

String_1F_00_02::
    db "<VOICE1>Cobi: Which one's<LINE>"
    db "staying here?@"

String_1F_00_03::
    db "<VOICE1>Cobi: So this one<LINE>"
    db "is staying here?@"

String_1F_00_04::
    db "<VOICE1>Cobi: Check up on<LINE>"
    db "the others too.<WAIT>"
    db "@"

String_1F_00_05::
    db "<VOICE1>Cobi: Do you need<LINE>"
    db "anything else?@"

String_1F_00_06::
    db "<VOICE1>Cobi: No, you can't<LINE>"
    db "go off all alone.<WAIT>"
    db "@"

String_1F_00_07::
    db "<VOICE1>Cobi: Switch with<LINE>"
    db "one on the farm?@"

String_1F_00_08::
    db "<VOICE1>Cobi: What'll you<LINE>"
    db "switch it with?@"

String_1F_00_09::
    db "<VOICE1>Cobi: So you'll<LINE>"
    db "take this one?@"

String_1F_00_0A::
    db "<VOICE1>Cobi: I switched<LINE>"
    db "<BUF0>.<WAIT>"
    db "@"

String_1F_00_0B::
    db "<VOICE1>Cobi: The farm has<LINE>"
    db "no more room.<WAIT>"
    db "@"

String_1F_00_0C::
    db "<VOICE1>Cobi: What'll you<LINE>"
    db "switch it with?@"

String_1F_00_0D::
    db "<VOICE1>Cobi: Which one<LINE>"
    db "will you take?@"

String_1F_00_0E::
    db "<VOICE1>Cobi: Is this the<LINE>"
    db "one you'll take?@"

String_1F_00_0F::
    db "<VOICE1>Cobi: It's eager<LINE>"
    db "to go, <BUF0>.<WAIT>"
    db "@"

String_1F_00_10::
    db "<VOICE1>Cobi: You haven't<LINE>"
    db "left any here.<WAIT>"
    db "@"

String_1F_00_11::
    db "<VOICE1>Cobi: You can't<LINE>"
    db "take any more.<WAIT>"
    db "@"

String_1F_00_12::
    db "<VOICE1>Cobi: What do you<LINE>"
    db "want to check?@"

String_1F_00_13::
    db "<VOICE1>Cobi: We don't have<LINE>"
    db "any of your eggs.<WAIT>"
    db "@"

String_1F_00_14::
    db "<VOICE1>Cobi: Which one<LINE>"
    db "will you check?@"

String_1F_00_16::
    db "<VOICE1>Cobi: Which egg<LINE>"
    db "will you check?@"

String_1F_00_17::
    db "<VOICE1>Cobi: What  do you<LINE>"
    db "want to release?@"

String_1F_00_18::
    db "<VOICE1>Cobi: Which one<LINE>"
    db "will you release?@"

String_1F_00_19::
    db "<VOICE1>Cobi: Which egg<LINE>"
    db "will you release?@"

String_1F_00_1A::
    db "<VOICE1>Cobi: It'll be gone<LINE>"
    db "forever. Sure?@"

String_1F_00_1B::
    db "The egg was<LINE>"
    db "released.<WAIT>"
    db "@"

String_1F_00_1C::
    db "<BUF0> was released<LINE>"
    db "in the wild.@"

String_1F_00_1D::
    db "<VOICE1>Cobi: Come back<LINE>"
    db "anytime, sis!<WAIT>"
    db "@"

String_1F_00_1E::
    db "<VOICE2>Tara: Hi, big<LINE>"
    db "brother!<PROMPT>"
    db "<NEXT>Do you need"
    db "<NEXT>anything?@"

String_1F_00_22::
    db "<VOICE2>Tara: Which one's<LINE>"
    db "staying here?@"

String_1F_00_23::
    db "<VOICE2>Tara: So this one<LINE>"
    db "is staying here?@"

String_1F_00_24::
    db "<VOICE2>Tara: Say bye to<LINE>"
    db "<BUF0> for a while.<WAIT>"
    db "@"

String_1F_00_25::
    db "<VOICE2>Tara: Do you need<LINE>"
    db "anything else?@"

String_1F_00_26::
    db "<VOICE2>Tara: You'll be<LINE>"
    db "left all alone!<WAIT>"
    db "@"

String_1F_00_27::
    db "<VOICE2>Tara: Switch with<LINE>"
    db "one on the farm?@"

String_1F_00_28::
    db "<VOICE2>Tara: What'll you<LINE>"
    db "switch it with?@"

String_1F_00_29::
    db "<VOICE2>Tara: So you'll<LINE>"
    db "take this one?@"

String_1F_00_2A::
    db "<VOICE2>Tara: I switched<LINE>"
    db "<BUF0>.<WAIT>"
    db "@"

String_1F_00_2B::
    db "<VOICE2>Tara: The farm is<LINE>"
    db "out of room.<WAIT>"
    db "@"

String_1F_00_2C::
    db "<VOICE2>Tara: What'll you<LINE>"
    db "switch it with?@"

String_1F_00_2D::
    db "<VOICE2>Tara: Which one<LINE>"
    db "will you take?@"

String_1F_00_2E::
    db "<VOICE2>Tara: Is this the<LINE>"
    db "one you'll take?@"

String_1F_00_2F::
    db "<VOICE2>Tara: <BUF0>, it<LINE>"
    db "really missed you.<WAIT>"
    db "@"

String_1F_00_30::
    db "<VOICE2>Tara: You haven't<LINE>"
    db "left any here.<WAIT>"
    db "@"

String_1F_00_31::
    db "<VOICE2>Tara: You can't<LINE>"
    db "take any more.<WAIT>"
    db "@"

String_1F_00_32::
    db "<VOICE2>Tara: What do you<LINE>"
    db "want to check?@"

String_1F_00_33::
    db "<VOICE2>Tara: We don't have<LINE>"
    db "any of your eggs.<WAIT>"
    db "@"

String_1F_00_34::
    db "<VOICE2>Tara: Which one<LINE>"
    db "will you check?@"

String_1F_00_36::
    db "<VOICE2>Tara: Which egg<LINE>"
    db "will you check?@"

String_1F_00_37::
    db "<VOICE2>Tara: What  do you<LINE>"
    db "want to release?@"

String_1F_00_38::
    db "<VOICE2>Tara: Which one<LINE>"
    db "will you release?@"

String_1F_00_39::
    db "<VOICE2>Tara: Which egg<LINE>"
    db "will you release?@"

String_1F_00_3A::
    db "<VOICE2>Tara: It'll be gone<LINE>"
    db "forever. OK?@"

String_1F_00_3B::
    db "The egg was<LINE>"
    db "released.<WAIT>"
    db "@"

String_1F_00_3C::
    db "<BUF0> was released<LINE>"
    db "in the wild.<WAIT>"
    db "@"

String_1F_00_3D::
    db "<VOICE2>Tara: Please tell<LINE>"
    db "me about your<PROMPT>"
    db "<NEXT>adventure next"
    db "<NEXT>time, big brother!<WAIT>"
    db "@"

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_SwapMonsters::
    script_command SCRIPT_SWAP_MONSTERS
Script_SwapMonsters_2::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_3, Script_ToSwapMonsters_11, Script_ToSwapMonsters_22, Script_ToSwapMonsters_25, Script_CobiComeBackAnytime
Script_CobiComeBackAnytime::
    script_command SCRIPT_MENU_CLOSE
    script_message_unless_flag0 $801d ; flag 0 set: 'Cobi: Come back anytime, sis!'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_ToSwapMonsters_25::
    script_jump Script_SwapMonsters_25
Script_ToSwapMonsters_22::
    script_jump Script_SwapMonsters_22
Script_ToSwapMonsters_11::
    script_jump Script_SwapMonsters_11
Script_SwapMonsters_3::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_ToCobiNoYouCan, Script_CobiWhichOne
Script_ToCobiNoYouCan::
    script_jump Script_CobiNoYouCan
Script_CobiWhichOne::
    script_message_unless_flag0 $c002 ; flag 0 set: 'Cobi: Which one's staying here?'
Script_SwapMonsters_4::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiSoThisOne, Script_CobiDoYouNeed
Script_CobiDoYouNeed::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_2
Script_CobiSoThisOne::
    script_message_unless_flag0 $c003 ; flag 0 set: 'Cobi: So this one is staying'
Script_SwapMonsters_5::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_6, Script_CobiCheckUpOn, Script_CobiWhichOne_2
Script_CobiWhichOne_2::
    script_message_unless_flag0 $c002 ; flag 0 set: 'Cobi: Which one's staying here?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_4
Script_CobiCheckUpOn::
    script_message_unless_flag0 $c004 ; flag 0 set: 'Cobi: Check up on the others'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_CobiDoYouNeed
Script_SwapMonsters_6::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_5
Script_CobiNoYouCan::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiDoYouNeed_2, Script_CobiSwitchWithOne
Script_CobiDoYouNeed_2::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_CobiSwitchWithOne::
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
Script_SwapMonsters_7::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiWhat, Script_CobiDoYouNeed_3
Script_CobiDoYouNeed_3::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_CobiWhat::
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
Script_SwapMonsters_8::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiSoYou, Script_CobiSwitchWithOne_2
Script_CobiSwitchWithOne_2::
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
    script_jump Script_SwapMonsters_7
Script_CobiSoYou::
    script_message_unless_flag0 $c009 ; flag 0 set: 'Cobi: So you'll take this one?'
Script_SwapMonsters_9::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_10, Script_CobiISwitchedHero, Script_CobiWhat_2
Script_CobiWhat_2::
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_8
Script_CobiISwitchedHero::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c00a ; flag 0 set: 'Cobi: I switched 0.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_SwapMonsters_10::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_9
Script_SwapMonsters_11::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiYouHaven, Script_ToCobiYouCan, Script_CobiWhichOneWill
Script_CobiYouHaven::
    script_message_unless_flag0 $c010 ; flag 0 set: 'Cobi: You haven't left any here.'
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_ToCobiYouCan::
    script_jump Script_CobiYouCan
Script_CobiWhichOneWill::
    script_message_unless_flag0 $c00d ; flag 0 set: 'Cobi: Which one will you take?'
Script_SwapMonsters_12::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiIsThisThe, Script_CobiDoYouNeed_4
Script_CobiDoYouNeed_4::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_CobiIsThisThe::
    script_message_unless_flag0 $c00e ; flag 0 set: 'Cobi: Is this the one you'll'
Script_SwapMonsters_13::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_14, Script_CobiIt, Script_CobiWhichOneWill_2
Script_CobiWhichOneWill_2::
    script_message_unless_flag0 $c00d ; flag 0 set: 'Cobi: Which one will you take?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_12
Script_CobiIt::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c00f ; flag 0 set: 'Cobi: It's eager to go, 0.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_SwapMonsters_14::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_13
Script_CobiYouCan::
    script_message_unless_flag0 $c011 ; flag 0 set: 'Cobi: You can't take any more.'
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
Script_SwapMonsters_15::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiWhat_3, Script_CobiDoYouNeed_5
Script_CobiDoYouNeed_5::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_CobiWhat_3::
    script_message_unless_flag0 $c00c ; flag 0 set: 'Cobi: What'll you switch it with?'
Script_SwapMonsters_16::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiSoThisOne_2, Script_CobiSwitchWithOne_3
Script_CobiSwitchWithOne_3::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
    script_jump Script_SwapMonsters_15
Script_CobiSoThisOne_2::
    script_message_unless_flag0 $c003 ; flag 0 set: 'Cobi: So this one is staying'
Script_SwapMonsters_17::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_18, Script_CobiWhat_5, Script_CobiWhat_4
Script_CobiWhat_4::
    script_message_unless_flag0 $c00c ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_16
Script_CobiWhat_5::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_jump Script_SwapMonsters_19
Script_SwapMonsters_18::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_17
Script_SwapMonsters_19::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiIsThisThe_2, Script_CobiWhat_6
Script_CobiWhat_6::
    script_message_unless_flag0 $c00c ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_jump Script_SwapMonsters_16
Script_CobiIsThisThe_2::
    script_message_unless_flag0 $c00e ; flag 0 set: 'Cobi: Is this the one you'll'
Script_SwapMonsters_20::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_21, Script_CobiISwitchedHero_2, Script_CobiWhat_7
Script_CobiWhat_7::
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_19
Script_CobiISwitchedHero_2::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c00a ; flag 0 set: 'Cobi: I switched 0.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_SwapMonsters_21::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_20
Script_SwapMonsters_22::
    script_command SCRIPT_SWAP_MONSTERS
Script_CobiWhatDoYou::
    script_message_unless_flag0 $c012 ; flag 0 set: 'Cobi: What do you want to'
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_ToCobiWhichOneWill_3, Script_ToCobiWhichEggWill, Script_CobiWeDon, Script_ToCobiDoYouNeed_6
Script_ToCobiWhichOneWill_3::
    script_jump Script_CobiWhichOneWill_3
Script_ToCobiWhichEggWill::
    script_jump Script_CobiWhichEggWill
Script_CobiWeDon::
    script_message_unless_flag0 $c013 ; flag 0 set: 'Cobi: We don't have any of'
    script_jump Script_CobiWhatDoYou
Script_CobiDoYouNeed_6::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_ToCobiDoYouNeed_6::
    script_jump Script_CobiDoYouNeed_6
Script_CobiWhichOneWill_3::
    script_message_unless_flag0 $c015 ; flag 0 set: 'Cobi: Which one will you check?'
Script_SwapMonsters_23::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_24, Script_ToCobiWhatDoYou
Script_ToCobiWhatDoYou::
    script_jump Script_CobiWhatDoYou
Script_SwapMonsters_24::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_23
Script_CobiWhichEggWill::
    script_message_unless_flag0 $c016 ; flag 0 set: 'Cobi: Which egg will you check?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_CobiWhatDoYou
Script_SwapMonsters_25::
    script_command SCRIPT_SWAP_MONSTERS
Script_CobiWhatDoYou_2::
    script_message_unless_flag0 $c017 ; flag 0 set: 'Cobi: What do you want to'
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_ToCobiWhichOneWill_4, Script_ToCobiWhichEggWill_2, Script_CobiWeDon_2, Script_ToCobiDoYouNeed_7, Script_CobiNoYouCan_2
Script_CobiNoYouCan_2::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
    script_jump Script_CobiWhatDoYou_2
Script_ToCobiWhichOneWill_4::
    script_jump Script_CobiWhichOneWill_4
Script_ToCobiWhichEggWill_2::
    script_jump Script_CobiWhichEggWill_2
Script_CobiWeDon_2::
    script_message_unless_flag0 $c013 ; flag 0 set: 'Cobi: We don't have any of'
    script_jump Script_CobiWhatDoYou_2
Script_CobiDoYouNeed_7::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_ToCobiDoYouNeed_7::
    script_jump Script_CobiDoYouNeed_7
Script_CobiWhichOneWill_4::
    script_message_unless_flag0 $c018 ; flag 0 set: 'Cobi: Which one will you release?'
Script_SwapMonsters_26::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiIt_2, Script_ToCobiWhatDoYou_2
Script_ToCobiWhatDoYou_2::
    script_jump Script_CobiWhatDoYou_2
Script_CobiIt_2::
    script_message_unless_flag0 $c01a ; flag 0 set: 'Cobi: It'll be gone forever. Sure?'
Script_SwapMonsters_27::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_28, Script_HeroWasReleasedIn, Script_CobiWhichOneWill_5, Script_CobiNoYouCan_3
Script_CobiNoYouCan_3::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
Script_CobiWhichOneWill_5::
    script_message_unless_flag0 $c018 ; flag 0 set: 'Cobi: Which one will you release?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_26
Script_HeroWasReleasedIn::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c01c ; flag 0 set: '0 was released in the wild.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_SwapMonsters_28::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_27
Script_CobiWhichEggWill_2::
    script_message_unless_flag0 $c019 ; flag 0 set: 'Cobi: Which egg will you release?'
Script_SwapMonsters_29::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_CobiIt_3, Script_ToCobiWhatDoYou_2_2
Script_ToCobiWhatDoYou_2_2::
    script_jump Script_CobiWhatDoYou_2
Script_CobiIt_3::
    script_message_unless_flag0 $c01a ; flag 0 set: 'Cobi: It'll be gone forever. Sure?'
Script_SwapMonsters_30::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_SwapMonsters_31, Script_TheEggWasReleased, Script_CobiWhichEggWill_3, Script_CobiNoYouCan_4
Script_CobiNoYouCan_4::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
Script_CobiWhichEggWill_3::
    script_message_unless_flag0 $c019 ; flag 0 set: 'Cobi: Which egg will you release?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_29
Script_TheEggWasReleased::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c01b ; flag 0 set: 'The egg was released.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_SwapMonsters_2
Script_SwapMonsters_31::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_SwapMonsters_30

; Draws the names of the records on the current page of a record list into VRAM, one name per call
; to the glyph copier, then moves on to the next screen step. It opens SRAM (rRAMG2 = $0A, bank 0),
; takes the record numbers from wListEntries starting at entry 5 * wListPageIndex, and for each of
; up to five entries (stopping at wListCount) copies the name with CopyRecordNameToNameGlyphBuf,
; ends it with $F0 and draws it: entries 0-3 with CopyGlyphTilesToVRAM at the addresses in
; DrawRecordListPageNames_Data ($8D00, $8D50, $8DA0, $8F00), the fifth with
; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F. Finally closes SRAM and increments wScreenStep.
; All three paths that test wListLastRow and wListPages read the same wListCount, so those tests
; change nothing. (C1, E-0378)
; for the visible entries of record-list page wListPageIndex draws each record name at
; DrawRecordListPageNames_Data[n] (the fifth through the mark-overlay drawer) (E-0128)
DrawRecordListPageNames::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    ld b, a
    add a
    add a
    add b
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp $04
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp $01
    jr nz, .read_list_count
    ld a, [wListCount]
    jr .read_list_page_index

.read_list_count:
    ld a, [wListCount]

.read_list_page_index:
    ld b, a
    ld a, [wListPageIndex]
    push bc
    ld c, a
    add a
    add a
    add c
    pop bc
    add c
    cp b
    jr nc, .check_screen_step
    push hl
    push bc
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    pop bc
    push bc
    ld a, c
    cp $04
    jr nz, .skip
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F
    jr .restore

.skip:
    ld a, c
    add a
    ld hl, DrawRecordListPageNames_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr z, .check_screen_step
    ld a, c
    cp $05
    jr c, .loop

.check_screen_step:
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Five little-endian words, $8D00, $8D50, $8DA0, $8F00 and $8A40: VRAM addresses for the names of
; the five cells of a record list page. DrawRecordListPageNames indexes it by the cell number 0 to 3
; and draws that cell name with CopyGlyphTilesToVRAM; cell 4 is drawn by
; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F, which takes its addresses from
; GlyphCopyArgsForA_Data, so the fifth word is not read. (C1, E-0381)
DrawRecordListPageNames_Data::
    db $00, $8d, $50, $8d, $a0, $8d, $00, $8f, $40, $8a

; Draws the $F0-terminated name in wNameGlyphBuf one glyph at a time into the VRAM tiles listed in
; GlyphCopyArgsForA_Data ($8A40, $8A50, $8A60, $8CE0, $8CF0), counting the character in
; wGlyphListPos and the destination tile in wGlyphListStart. An ordinary character is copied as a
; 16-byte tile with CopyFromBankWaitVRAM. The marks $8D and $8E take no tile of their own: the
; destination counter first steps back one, and the mark glyph is ORed onto the previous tile with
; OrFromBankWaitVRAM, so it sits on top of the letter before it. Both counters are reset to 0 at the
; start and the end. Only caller is DrawRecordListPageNames, for the fifth name of a page. (C1,
; E-0378)
; draws the $F0-terminated text at wNameGlyphBuf glyph by glyph; marks $8D and $8E are ORed onto the
; previous tile (E-0125)
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F::
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp $f0
    jp z, .clear_glyph_list_start
    cp $8d
    jr z, .check_glyph_list_start
    cp $8e
    jr z, .check_glyph_list_start
    call GlyphCopyArgsForA
    call CopyFromBankWaitVRAM
    jr .check_glyph_list_start2

.check_glyph_list_start:
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    call GlyphCopyArgsForA
    call OrFromBankWaitVRAM

.check_glyph_list_start2:
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr .read_glyph_list_pos

.clear_glyph_list_start:
    pop hl
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; Sets up the arguments for copying one font glyph to VRAM. A = glyph number; returns DE = GlyphFont
; + 16 * A (the glyph tile in bank $1F, which starts at $4010), HL = the destination word at index
; wGlyphListStart of GlyphCopyArgsForA_Data ($8A40, $8A50, $8A60, $8CE0, $8CF0), B = $1F (the bank)
; and C = 16 (bytes), ready for CopyFromBankWaitVRAM or OrFromBankWaitVRAM. Only
; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F calls it. (C2, E-0378)
; DE = GlyphFont + 16 * A (the glyph's tile), HL = the VRAM address from GlyphCopyArgsForA_Data + 2
; * wGlyphListStart, B = $1F (bank), C = 16 (bytes) (E-0120)
GlyphCopyArgsForA::
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    ld hl, GlyphFont
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, GlyphCopyArgsForA_Data
    ld a, [wGlyphListStart]
    sla a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1f
    ld c, $10
    ret

; Five little-endian VRAM addresses of 16-byte tiles: $8A40, $8A50, $8A60, $8CE0 and $8CF0.
; GlyphCopyArgsForA indexes it by wGlyphListStart (the destination tile counter of
; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F) and returns the word in HL as the place for the
; next glyph of the fifth name of a record list page. (C1, E-0381)
GlyphCopyArgsForA_Data::
    db $40, $8a, $50, $8a, $60, $8a, $e0, $8c, $f0, $8c

; Copies a tile rectangle: wArg1/wArg2 = source, wArg3 = width, wArg4 = rows, wArg5/wArg6 = BG map
; address; each row is written in mode 0-1 only, wrapping at the 32-tile row, and on CGB (unless
; wArg7) the attribute bytes of the same cells are cleared in VRAM bank 1; rows step $20, wrapping
; within the BG map. (C1, E-0357)
; parameters wArg1/wArg2 = source (high, low), wArg3 = width, wArg4 = rows, wArg5/wArg6 = BG map
; destination (high, low): copies each row of tiles to the BG map with interrupts off after rSTAT
; bit 1 clears, wrapping columns inside the 32-entry row; on CGB, when wArg7 is 0, also zero-fills
; the same entries in VRAM bank 1 (attributes); the row loop is not read to its end (E-0093)
DrawTileRectFromArg1Params::
    ld hl, wArg1
    ld d, [hl]
    inc hl
    ld e, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld a, [wArg6]
    ld l, a

.loop:
    push hl
    push bc

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [de]
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a
    jr z, .restore
    ld a, [wArg7]
    and a
    jr nz, .restore
    ld a, $01
    ldh [rVBK], a

.loop4:
    di

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    xor a
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next2
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next2:
    dec b
    jr nz, .loop4
    xor a
    ldh [rVBK], a

.restore:
    pop bc
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a
    dec c
    jr nz, .loop
    ret

; Fills a rectangle of the BG map with one tile. Inputs: wArg1/wArg2 = the address of the tile byte
; (high, low; every caller passes BGFillTile, tile $C3), wArg3 = width, wArg4 = rows, wArg5/wArg6 =
; the BG map address of the first cell. Each cell is written with interrupts off after waiting for
; rSTAT bit 1 to clear, wrapping inside the 32-entry row; a row of the rectangle starts $20 after
; the one before, kept inside the map by masking the high byte with $9B. On the Game Boy Color
; (wIsCGB nonzero), unless wArg7 is nonzero, the same cells in VRAM bank 1 (their attributes) are
; set to 0. Unlike DrawTileRectFromArg1Params it never moves the source pointer. (C1, E-0378)
; fills a wArg3 x wArg4 rectangle of the BG map at wArg5/6 (wrapping inside the 32-entry row) with
; the one tile byte at wArg1/2: unlike DrawTileRectFromArg1Params it never advances DE; on CGB,
; unless wArg7 is set, clears the same entries' attributes; every caller passes BGFillTile (E-0186,
; correcting E-0129)
FillTileRectWithArg1Tile::
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    ld a, [wArg3]
    ld b, a
    ld a, [wArg4]
    ld c, a
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a

.loop:
    push hl
    push bc

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [de]
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next:
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a
    jr z, .restore
    ld a, [wArg7]
    and a
    jr nz, .restore
    ld a, $01
    ldh [rVBK], a

.loop4:
    di

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    xor a
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next2
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next2:
    dec b
    jr nz, .loop4
    xor a
    ldh [rVBK], a

.restore:
    pop bc
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a
    dec c
    ld a, c
    and a
    jr nz, .loop
    ret

; one byte, tile $C3: the tile FillTileRectWithArg1Tile repeats over the whole rectangle; all ten
; callers pass this address (E-0186)
BGFillTile::
    db $c3

; A 12 x 3 tile strip (36 bytes): the top border ($B0, ten $B1, $B2), a blank row between the side
; borders ($B6, ten $C3, $B7) and a divider row ($B8, ten $B9, $BA), the same as the top three rows
; of the right-hand box of PartyMemberDetailsScreenTileRect.
; SwapMonstersMenu_ShowMonsterDetails_StatsFrames (stats screen, step 28) and
; MonsterDetails_DrawSummaryPanelFrames (far-called from banks $37 and $F1) draw it at the scroll
; origin + 8 (row 0, column 8) with wArg3 = 12 and wArg4 = 3, just before
; MonsterDetailsItemBoxTileRect at + $160. (C1, E-0373)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 3 tiles, one row per line
MonsterDetailsPanelTopTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2

; A 20 x 18 tile screen. Left: a box on rows 0-6 with three text rows (tiles $D0-$D4, $D5-$D9,
; $DA-$DE), blank below. Right: a box whose blank top row is split off by a divider, with five label
; rows (glyph tiles $02-$0C, each label followed by tile $ED), and under it a box of two rows ($F5
; $F7 and $F6 $F7, tile $ED, and $BE between the two number places).
; SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame (party member stats, step 3) draws it at the
; scroll origin with DrawTileRectAtHLFromDE_Bank1E. (C1, E-0372)
; record: 20 x 18 tiles, one row per line
PartyMemberDetailsScreenTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7, $b6, $c3, $02, $03, $04, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7, $b6, $c3, $05, $06, $07, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $02, $bf, $09, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0a, $0b, $03, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0c, $09, $05, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 12
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 13
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 14
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 16
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; the same box layout as PartyMemberDetailsScreenTileRect, which
; SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame draws as 20 x 18; the four screens are
; contiguous, 360 bytes each; no reader of this one was found (E-0187, C1)
TileScreen1F_1::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; entry 0: row 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $b6, $15, $1f, $1b, $1c, $1d, $ed, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 15
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

TileScreen1F_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; entry 0: row 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $c3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7, $b6, $c3, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7, $b6, $c3, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $b7 ; row 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $b7 ; row 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $b7 ; row 11
    db $b6, $15, $1f, $1b, $1c, $1d, $ed, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $b7 ; row 13
    db $b6, $68, $69, $6a, $6b, $6c, $6d, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $b7 ; row 15
    db $b6, $6e, $6f, $70, $71, $72, $73, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

TileScreen1F_3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; entry 0: row 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $13, $14, $15, $0e, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $0d, $0d, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $0d, $14, $10, $0e, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 13
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 15
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $0d, $0d, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 16
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

; A 12 x 18 tile panel of two boxes, one per parent: each has a label of four glyph tiles and $ED, a
; mark tile ($6C in the first box, $6D in the second) and rows of text tiles ($20-$33 in the first,
; $34-$47 in the second) where the parents' names are drawn. Drawn at the scroll origin + 8 by
; SwapMonstersMenu_ShowMonsterDetails_DrawPedigree (stats screen, step 30, before the parents step),
; PartnerStats_DrawPedigreeFrame (bank $37) and RunScreenStateWhenNotFading_F1_StatsPedigreeFrame
; (bank $F1). (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 18 tiles, one row per line
MonsterDetailsPedigreeTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $13, $14, $15, $0e, $ed, $20, $21, $22, $23, $24, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $6c, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $0d, $0d, $ed, $2f, $30, $31, $32, $33, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 9
    db $b6, $0d, $14, $10, $0e, $ed, $34, $35, $36, $37, $38, $b7 ; id 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $6d, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $b6, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $b7 ; id 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $b6, $0d, $0d, $ed, $43, $44, $45, $46, $47, $c3, $c3, $b7 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; A 6 x 6 block of the tile numbers $20-$43 in order: the monster picture that LoadMonsterPicture
; puts at vTiles2 + $200. SwapMonstersMenu_ShowMonsterDetails_LoadPicture (stats screen, step 5) and
; DrawRecordBufBSpeciesMonsterPictureInTwoSteps draw it at the scroll origin + $161 (row 11, column
; 1) in their second sub-step, after the picture tiles are loaded. (C1, E-0372)
; record: 6 x 6 tiles, one row per line
MonsterDetailsPictureTileRect::
    db $20, $21, $22, $23, $24, $25 ; id 0
    db $26, $27, $28, $29, $2a, $2b ; id 1
    db $2c, $2d, $2e, $2f, $30, $31 ; id 2
    db $32, $33, $34, $35, $36, $37 ; id 3
    db $38, $39, $3a, $3b, $3c, $3d ; id 4
    db $3e, $3f, $40, $41, $42, $43 ; id 5

LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect::
    db $02, $03, $04, $05, $06, $07 ; id 0
    db $08, $09, $0a, $0b, $0c, $0d ; id 1
    db $0e, $0f, $10, $11, $12, $13 ; id 2
    db $14, $15, $16, $17, $18, $19 ; id 3
    db $1a, $1b, $1c, $1d, $1e, $1f ; id 4
    db $20, $21, $22, $23, $24, $25 ; id 5

SwapMonstersMenu_ShowParents2_LoadPicture_TileRect::
    db $48, $49, $4a, $4b, $4c, $4d ; id 0
    db $4e, $4f, $50, $51, $52, $53 ; id 1
    db $54, $55, $56, $57, $58, $59 ; id 2
    db $5a, $5b, $5c, $5d, $5e, $5f ; id 3
    db $60, $61, $62, $63, $64, $65 ; id 4
    db $66, $67, $68, $69, $6a, $6b ; id 5

; A 6 x 6 block of the blank tile $C3. The picture drawers put it over the picture place before a
; new picture is loaded: LibraryMenu_ShowMonsterEntry_DrawPicture (scroll origin + $21),
; SwapMonstersMenu_ShowMonsterDetails_LoadPicture, DrawRecordBufBSpeciesMonsterPictureInTwoSteps and
; the A keys of SwapMonstersMenu_ShowMonsterDetails_Cursor1,
; SwapMonstersMenu_ShowPartyMemberDetails_ListPage, PartnerStats_Cursor and
; RunScreenStateWhenNotFading_F1_StatsPage1Keys (scroll origin + $161), and
; DrawRect6x6FromAtScroll41 and LinkRecordScreen_DrawBlankPicture (+ $41). (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
BlankPictureTileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 5

; An 8 x 7 block of the blank tile $C3 for the scroll origin + $160 (rows 11-17, columns 0-7, the
; area that holds the picture at + $161), drawn right after MonsterDetailsStatsTileRect by
; SwapMonstersMenu_ShowMonsterDetails_StatsCursor, SwapMonstersMenu_ShowPartyMemberDetails_StatsPage
; and MonsterDetails_DrawStatsPageFrames. (C1, E-0372)
; record: 8 x 7 tiles, one row per line
MonsterDetailsStatsLowerLeftTileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; A 12 x 15 tile panel drawn at the scroll origin + $68 (row 3, column 8): a box of text rows (tiles
; $20-$28, $A7-$AF, a row with tile $C7, and a labelled row with tiles $29-$2D), then a box with two
; rows starting $FF $ED around a word in glyph tiles $0B-$12. Drawn by
; SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame (stats screen, step 17, before the personality
; and experience steps), PartnerStats_DrawPage2Frame and
; RunScreenStateWhenNotFading_F1_StatsPage2Frame (the partner's second page). (C1, E-0372)
; record: 12 x 15 tiles, one row per line
MonsterDetailsPage2TileRect::
    db $b6, $20, $21, $22, $23, $24, $25, $26, $27, $28, $c3, $b7 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $0d, $0d, $ed, $29, $2a, $2b, $2c, $2d, $c3, $c3, $b7 ; id 6
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 7
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 8
    db $b6, $ff, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 10
    db $b6, $0b, $0e, $0f, $10, $c3, $09, $0e, $11, $0e, $12, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $ff, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 14

; A 12 x 15 tile stats panel drawn at the scroll origin + $68 (row 3, column 8): a box of five label
; rows (glyph tiles $02 $03 $04, $05 $06 $07, $02 $BF $09, $0A $0B $03 and $0C $09 $05, each
; followed by tile $ED) and a box with two rows ($F5 $F7 and $F6 $F7, tile $ED, and $BE between the
; number places). DrawListEntriesCell5RecordDetails_DrawStats (MON_ATK to MON_WLD) and
; DrawListEntriesCell5RecordDetails_DrawHPAndMP (whose offsets
; DrawListEntriesCell5RecordDetails_HPMPOffsets land on its two lower rows) draw the numbers into
; it. Readers: SwapMonstersMenu_ShowMonsterDetails_StatsCursor,
; SwapMonstersMenu_ShowPartyMemberDetails_StatsPage and MonsterDetails_DrawStatsPageFrames. (C1,
; E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
MonsterDetailsStatsTileRect::
    db $b6, $c3, $02, $03, $04, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $05, $06, $07, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $02, $bf, $09, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $0a, $0b, $03, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $0c, $09, $05, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 8
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 9
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 10
    db $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 13
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 14

; An 8 x 7 tile area for the scroll origin + $160: a blank row, a 6 x 2 text box showing tiles
; $32-$37 and $38-$3D, and a blank row. ShowListEntriesCell5RecordItemName writes the record's
; MON_ITEM name (string category $0B) into exactly those tiles ($9320, 6 x 2). Drawn by
; SwapMonstersMenu_ShowMonsterDetails_LoadSprite (step 20),
; SwapMonstersMenu_ShowMonsterDetails_StatsFrames, MonsterDetails_DrawSummaryPanelFrames,
; PartnerStats_LoadSprite and RunScreenStateWhenNotFading_F1_StatsLoadSprite. (C1, E-0372)
; record: 8 x 7 tiles, one row per line
MonsterDetailsItemBoxTileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 1
    db $b6, $32, $33, $34, $35, $36, $37, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $38, $39, $3a, $3b, $3c, $3d, $b7 ; id 4
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; The 20 x 18 tile screen of the stats screen. Left: a box on rows 0-10 with five text rows (tiles
; $D0-$D4, $D5-$D9, $DA-$DE, $F0-$F4 and $A4 $A5 $A6 $CE $CF), blank below. Right: the same boxes as
; PartyMemberDetailsScreenTileRect (a divided top row, five label rows, then the two-row box).
; SwapMonstersMenu_ShowMonsterDetails_DrawFrame (step 3) draws it at the scroll origin. (C1, E-0372)
; record: 20 x 18 tiles, one row per line
MonsterDetailsScreenTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7, $b6, $c3, $02, $03, $04, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7, $b6, $c3, $05, $06, $07, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $b7, $b6, $c3, $02, $bf, $09, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $a4, $a5, $a6, $ce, $cf, $b7, $b6, $c3, $0a, $0b, $03, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0c, $09, $05, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 12
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 13
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 14
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 16
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
PartnerStats_DrawFrame_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $02, $03, $04, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $05, $06, $07, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $02, $bf, $09, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0a, $0b, $03, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0c, $09, $05, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 12
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 13
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 14
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 16
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; The 20 x 18 tile screen of SwapMonstersMenu_ShowMonsterDetails3, drawn by
; SwapMonstersMenu_ShowMonsterDetails3_DrawFrame (step 3): the layout of
; MonsterDetailsScreenTileRect except that the left box has four text rows and ends on row 8. (C1,
; E-0372)
MonsterDetails3ScreenTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7, $b6, $c3, $02, $03, $04, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7, $b6, $c3, $05, $06, $07, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $b7, $b6, $c3, $02, $bf, $09, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0a, $0b, $03, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $0c, $09, $05, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; id 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 12
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 13
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 14
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 16
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; A 12 x 18 empty box (edges only, the bottom edge doubled) drawn at the scroll origin + 8 by
; SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames (stats screen, step 23) and
; MonsterDetails_DrawBlankPageFrames, together with MonsterDetailsBlankPageLowerLeftTileRect. (C1,
; E-0372)
; record: 12 x 18 tiles, one row per line
MonsterDetailsBlankPageTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; An 8 x 7 block of the blank tile $C3 drawn at the scroll origin + $160 with
; MonsterDetailsBlankPageTileRect by SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames and
; MonsterDetails_DrawBlankPageFrames. (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
MonsterDetailsBlankPageLowerLeftTileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; A 12 x 18 box with eight text rows of nine tiles each ($20-$28, $29-$31, ... $5F-$67) separated by
; blank rows, drawn at the scroll origin + 8 by SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
; (step 24) and MonsterDetails_DrawSkillsPageFrames after they blank the tiles from vTiles2 + $200.
; The next stats-screen step, SwapMonstersMenu_ShowMonsterDetails_ListSkills, writes the record's
; skill names into those tiles. (C1, E-0372)
; record: 12 x 18 tiles, one row per line
MonsterDetailsSkillsPageTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $b7 ; id 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $c3, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $b7 ; id 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $c3, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $b7 ; id 15
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; An 8 x 7 block of the blank tile $C3 drawn at the scroll origin + $160 with
; MonsterDetailsSkillsPageTileRect by SwapMonstersMenu_ShowMonsterDetails_DrawNextPage and
; MonsterDetails_DrawSkillsPageFrames. (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
MonsterDetailsSkillsLowerLeftTileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; A 12 x 18 panel with the two boxes of MonsterDetailsPedigreeTileRect (the same label rows) but
; without the mark and name tiles. Drawn at the scroll origin + 8 by DrawSummaryFrames,
; SwapMonstersMenu_ShowMonsterDetails_Cursor2 and SwapMonstersMenu_ShowPartyMemberDetails_Cursor on
; their A key, before the full pedigree panel is drawn. (C1, E-0372)
; record: 12 x 18 tiles, one row per line
MonsterDetailsEmptyPedigreeTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $13, $14, $15, $0e, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $0d, $0d, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 9
    db $b6, $0d, $14, $10, $0e, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $b6, $0d, $0d, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; An 8 x 7 tile area for the scroll origin + $160: blank except a small figure of tiles $7C, $6E
; $7E, $6F $7E and $7D in columns 3-4 of rows 1-4 (the figure
; SwapMonstersMenu_ShowParents2_DrawFrame_TileRect also has on its left). Drawn with
; MonsterDetailsEmptyPedigreeTileRect by DrawSummaryFrames,
; SwapMonstersMenu_ShowMonsterDetails_Cursor2 and SwapMonstersMenu_ShowPartyMemberDetails_Cursor.
; (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
MonsterDetailsPedigreeLowerLeftTileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $7c, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $6e, $7e, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $6f, $7e, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $7d, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; record: 20 x 18 tiles, one row per line
SwapMonstersMenu_ShowParents2_DrawFrame_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $13, $14, $15, $0e, $ed, $20, $21, $22, $23, $24, $b7 ; id 1
    db $c3, $48, $49, $4a, $4b, $4c, $4d, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $c3, $4e, $4f, $50, $51, $52, $53, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $c3, $54, $55, $56, $57, $58, $59, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $c3, $5a, $5b, $5c, $5d, $5e, $5f, $c3, $b6, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $b7 ; id 5
    db $c3, $60, $61, $62, $63, $64, $65, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $c3, $66, $67, $68, $69, $6a, $6b, $c3, $b6, $0d, $0d, $ed, $2f, $30, $31, $32, $33, $c3, $c3, $b7 ; id 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $0d, $14, $10, $0e, $ed, $34, $35, $36, $37, $38, $b7 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $c3, $c3, $c3, $c3, $7c, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $c3, $c3, $c3, $6e, $7e, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $c3, $c3, $c3, $6f, $7e, $c3, $c3, $c3, $b6, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $b7 ; id 14
    db $c3, $c3, $c3, $c3, $7d, $c3, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $0d, $0d, $ed, $43, $44, $45, $46, $47, $c3, $c3, $b7 ; id 16
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; The 20 x 18 name-entry screen: a 2 x 3 block of tile $00 at the left and a small box with text
; tiles $50-$54 on rows 0-3, then a box with a heading row of glyph tiles, a divider, and the
; keyboard: five rows of character tiles ($02-$4B in order, a blank column before the last four of
; each row) separated by blank rows, the last row ending in tiles $06 $13 $05.
; RunNameEntryStateWhenNotFading_Setup_DrawKeyboard (name entry set-up, step 2) draws it;
; RunNameEntryStateWhenNotFading_RedrawKeyboard_Data is a second label at its row 8. (C1, E-0372)
NameEntryKeyboardTileRect::
    db $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $00, $00, $c3, $c3, $b6, $c3, $50, $51, $52, $53, $54, $c3, $b7, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $00, $00, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $00, $00, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $06, $35, $3b, $28, $39, $c3, $13, $24, $30, $28, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 6
    db $b6, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $c3, $0f, $10, $11, $12, $b7 ; id 7
RunNameEntryStateWhenNotFading_RedrawKeyboard_Data::
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $13, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f, $c3, $20, $21, $22, $23, $b7 ; id 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $c3, $31, $32, $33, $34, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $c3, $42, $43, $44, $45, $b7 ; id 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $46, $47, $48, $49, $4a, $4b, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $06, $13, $05, $c3, $b7 ; id 15
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; A 20 x 5 box with two rows of text tiles, $5C-$6D and $6E-$7F, separated by a blank row;
; RunNameEntryStateWhenNotFading_DrawFrameRow_Data is a second label at that blank row.
; RunNameEntryStateWhenNotFading_DrawFrameBottom (name entry, state 2, step 3) draws it. (C1,
; E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 5 tiles, one row per line
NameEntryTwoRowWindowTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $b7 ; id 1
RunNameEntryStateWhenNotFading_DrawFrameRow_Data::
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $6e, $6f, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; A 20 x 3 box with one row of text tiles $5C-$6D, drawn by
; RunNameEntryStateWhenNotFading_DrawFramePart (name entry, state 2, step 2). (C1, E-0372)
; record: 20 x 3 tiles, one row per line
NameEntryOneRowWindowTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; record: 6 x 5 tiles, one row per line
RunNameEntryStateWhenNotFading_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $13, $36, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; Three 20 x 6 tile panels, $78 bytes each, for one, two or three 6 x 6 pictures centred on the
; blank tile $C3: one picture of tiles $00-$23 at columns 7-12; two of $00-$23 and $24-$47 at
; columns 4-15; three of $00-$23, $24-$47 and $48-$6B at columns 1-18. GameMode6_Init_DrawPictureRow
; (bank $24) picks panel wSharedMenuWork - 1 and far-calls DrawTileRectFromArg1Params (bank $1F) to
; draw it at the scroll origin + $E0 with wArg7 = 1. (C1, E-0372); E-0187 (C1:
; GameMode6_Init_DrawPictureRow sets wArg1/wArg2 = $720D + (wScreenByteBD - 1) * $78, wArg3 = 20,
; wArg4 = 6, wArg7 = 1 and far-calls DrawTileRectFromArg1Params at the scroll origin + $E0; three
; panels fill $720D-$7375). (named from its reading, E-0372; was
; GameMode6_Init_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24_TileRect)
; record: one 20 x 6 tile panel (wScreenByteBD selects it)
GameMode6_PictureRowTileRects::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $00, $01, $02, $03, $04, $05, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1: row 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $06, $07, $08, $09, $0a, $0b, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $0c, $0d, $0e, $0f, $10, $11, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $12, $13, $14, $15, $16, $17, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $18, $19, $1a, $1b, $1c, $1d, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $1e, $1f, $20, $21, $22, $23, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 5
    db $c3, $c3, $c3, $c3, $00, $01, $02, $03, $04, $05, $24, $25, $26, $27, $28, $29, $c3, $c3, $c3, $c3 ; id 2: row 0
    db $c3, $c3, $c3, $c3, $06, $07, $08, $09, $0a, $0b, $2a, $2b, $2c, $2d, $2e, $2f, $c3, $c3, $c3, $c3 ; row 1
    db $c3, $c3, $c3, $c3, $0c, $0d, $0e, $0f, $10, $11, $30, $31, $32, $33, $34, $35, $c3, $c3, $c3, $c3 ; row 2
    db $c3, $c3, $c3, $c3, $12, $13, $14, $15, $16, $17, $36, $37, $38, $39, $3a, $3b, $c3, $c3, $c3, $c3 ; row 3
    db $c3, $c3, $c3, $c3, $18, $19, $1a, $1b, $1c, $1d, $3c, $3d, $3e, $3f, $40, $41, $c3, $c3, $c3, $c3 ; row 4
    db $c3, $c3, $c3, $c3, $1e, $1f, $20, $21, $22, $23, $42, $43, $44, $45, $46, $47, $c3, $c3, $c3, $c3 ; row 5
    db $c3, $00, $01, $02, $03, $04, $05, $24, $25, $26, $27, $28, $29, $48, $49, $4a, $4b, $4c, $4d, $c3 ; id 3: row 0
    db $c3, $06, $07, $08, $09, $0a, $0b, $2a, $2b, $2c, $2d, $2e, $2f, $4e, $4f, $50, $51, $52, $53, $c3 ; row 1
    db $c3, $0c, $0d, $0e, $0f, $10, $11, $30, $31, $32, $33, $34, $35, $54, $55, $56, $57, $58, $59, $c3 ; row 2
    db $c3, $12, $13, $14, $15, $16, $17, $36, $37, $38, $39, $3a, $3b, $5a, $5b, $5c, $5d, $5e, $5f, $c3 ; row 3
    db $c3, $18, $19, $1a, $1b, $1c, $1d, $3c, $3d, $3e, $3f, $40, $41, $60, $61, $62, $63, $64, $65, $c3 ; row 4
    db $c3, $1e, $1f, $20, $21, $22, $23, $42, $43, $44, $45, $46, $47, $66, $67, $68, $69, $6a, $6b, $c3 ; row 5

; Copies 16 font glyph tiles into VRAM. For each index 0-15 it takes a glyph number from
; LoadSixteenGlyphTilesFromTable_Data1, finds its tile at GlyphFont + 16 * glyph in bank $1F, and
; copies the 16 bytes with CopyFromBankWaitVRAM to the address in word the same index of
; LoadSixteenGlyphTilesFromTable_Data2. Called by farcall from the partner stats screen (bank $37)
; and the record stats screen (bank $F1), step 1, right after the heading is drawn. (C1, E-0378)
; copies 16 glyph tiles (LoadSixteenGlyphTilesFromTable_Data1) from bank $1F to the VRAM addresses
; in LoadSixteenGlyphTilesFromTable_Data2 (E-0127) (E-0344: the address in its name dropped or read
; as the label there; was LoadSixteenGlyphTilesFromTable)
LoadSixteenGlyphTilesFromTable::
    ld c, $00

.loop:
    push bc
    ld a, c
    ld de, LoadSixteenGlyphTilesFromTable_Data1
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, GlyphFont
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    sla a
    ld de, LoadSixteenGlyphTilesFromTable_Data2
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    ld a, c
    cp $10
    jr c, .loop
    ret

; Sixteen glyph numbers, $A3 $54 $44 $11 $16 $19 $48 $24 $A6 $12 $31 $29 $32 $18 $14 $25 (in the
; text charmap: colon, H, M, P, a, I, n, f, o, O, K, b, and four numbers the charmap does not list).
; Same list as SwapMonstersMenu_CopySixteenTiles_Data1 except the last byte.
; LoadSixteenGlyphTilesFromTable takes byte n as the glyph to copy from GlyphFont (bank $1F, 16
; bytes each) to the VRAM address in word n of LoadSixteenGlyphTilesFromTable_Data2. (C1, E-0381)
LoadSixteenGlyphTilesFromTable_Data1::
    db $a3, $54, $44, $11, $16, $19, $48, $24, $a6, $12, $31, $29, $32, $18, $14, $25

; Sixteen little-endian VRAM addresses: $8ED0, $8EE0, $8EF0, $8F50, $8F60, $8F70, $8FD0, $8FE0,
; $8FF0, then $9700 to $9760 in steps of $10. The same words as
; SwapMonstersMenu_CopySixteenTiles_Data2. LoadSixteenGlyphTilesFromTable copies the glyph given by
; byte n of LoadSixteenGlyphTilesFromTable_Data1 to word n. (C1, E-0381)
LoadSixteenGlyphTilesFromTable_Data2::
    db $d0, $8e, $e0, $8e, $f0, $8e, $50, $8f, $60, $8f, $70, $8f, $d0, $8f, $e0, $8f
    db $f0, $8f, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; Draws the monster picture of the record in wRecordBufB on the stats screen, over two calls told
; apart by wScreenSubStep. Call 1 (wScreenSubStep 0): draws the 6 x 6 frame BlankPictureTileRect at
; the BG map scroll origin + $161 (wArg7 = 0), loads the picture of the species word at wRecordBufB
; + MON_SPECIES into VRAM at vTiles2 + $200 with palette slot 1 (LoadMonsterPicture) and sets
; wScreenSubStep to 1. Call 2: on the Game Boy Color it uploads the BG palettes
; (wBGPaletteUploadRequest = $7F) and writes the picture attributes with palette 1
; (LoadMonsterPictureAttributes); then on every system it draws MonsterDetailsPictureTileRect, 6 x 6
; tiles $20-$31 laid out in rows, at the same place with wArg7 = 1, clears wScreenSubStep and
; increments wScreenStep. Callers are step 5 of PartnerStats and its record stats twin in bank $F1.
; (C1, E-0378)
; first call: draws the 6 x 6 frame BlankPictureTileRect and loads the picture of species
; wRecordBufB + $B at vTiles2 + $200; second call: loads its CGB attributes and draws the picture
; (E-0128) (E-0340: the address in its name read as its RAM name; was
; DrawRecordBufBSpeciesMonsterPictureInTwoSteps)
DrawRecordBufBSpeciesMonsterPictureInTwoSteps::
    ld a, [wScreenSubStep]
    and a
    jp nz, .check_is_cgb
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, BlankPictureTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld a, [wRecordBufB + MON_SPECIES]
    ld e, a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_is_cgb:
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank1_f
    ld a, [wRecordBufB + MON_SPECIES]
    ld e, a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld d, a
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.call_bg_map_address_at_scroll_bank1_f:
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsPictureTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Starts a stats screen: fills the whole 32 x 32 BG map from the scroll origin with BGFillTile (tile
; $C3) through FillTileRectWithArg1Tile, with wArg7 = 0 so the attribute bytes are cleared too on
; the Game Boy Color. Then copies three 16-byte tiles from bank $1F to vTiles1 + $7E0
; (Tiles1Plus2F0Tiles), vTiles1 + $7F0 (Tiles1Plus7F0Tiles) and vTiles2 + $6F0 (Tiles1Plus4A0Tiles)
; with CopyFromBankWaitVRAM, the frame tiles the later steps draw with. Step 0 of PartnerStats and
; of the record stats screen in bank $F1. (C1, E-0378)
; fills the 32 x 32 BG map from the scroll origin with BGFillTile (tile $C3), then copies three
; tiles from bank $1F to vTiles1 + $7E0, + $7F0 and vTiles2 + $6F0 (E-0121; fill, not a tile map:
; E-0186)
ClearBGMapAndLoadFrameTiles::
    call BGMapAddressAtScroll_Bank1F
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, BGFillTile
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $20
    ld [wArg3], a
    ld a, $20
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call FillTileRectWithArg1Tile
    ld de, Tiles1Plus2F0Tiles
    ld hl, vTiles1 + $7e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles
    ld hl, vTiles1 + $7f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus4A0Tiles
    ld hl, vTiles2 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Draws the two frames of the first stats page: MonsterDetailsStatsTileRect (12 wide, 15 rows) at
; the BG map scroll origin + $68, then MonsterDetailsStatsLowerLeftTileRect (8 wide, 7 rows) at the
; scroll origin + $160, both with wArg7 = 0 through DrawTileRectFromArg1Params. Farcalled by the
; PartnerStats code (bank $37) and the bank $F1 record stats screen when the player comes back from
; the second page to the first, just before the stats are drawn again at step 4. (C1, E-0378)
; draws the tile rectangles MonsterDetailsStatsTileRect (12 x 15 at scroll + $68) and
; MonsterDetailsStatsLowerLeftTileRect (8 x 7 at scroll + $160) (E-0121) (E-0344: the address in its
; name dropped or read as the label there; was MonsterDetails_DrawStatsPageFrames)
MonsterDetails_DrawStatsPageFrames::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0068
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsStatsTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0c
    ld [wArg3], a
    ld a, $0f
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsStatsLowerLeftTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; Draws the two frames of an emptied page: MonsterDetailsBlankPageTileRect (12 wide, 18 rows) at the
; BG map scroll origin + 8, then MonsterDetailsBlankPageLowerLeftTileRect (8 wide, 7 rows) at the
; scroll origin + $160, with wArg7 = 0 through DrawTileRectFromArg1Params. It is the first step (23)
; of the skills page in PartnerStats and its bank $F1 twin; step 24 then draws the skills frames
; over it. (C1, E-0378)
; draws the tile rectangles MonsterDetailsBlankPageTileRect (12 x 18 at scroll + 8) and
; MonsterDetailsBlankPageLowerLeftTileRect (8 x 7 at scroll + $160) (E-0121) (E-0344: the address in
; its name dropped or read as the label there; was MonsterDetails_DrawBlankPageFrames)
MonsterDetails_DrawBlankPageFrames::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsBlankPageTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsBlankPageLowerLeftTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; Prepares the skills page. It blanks 21 x 4 tiles at vTiles2 + $200 with FillTilesFromRequest (the
; area the skill names will be written into), then draws MonsterDetailsSkillsPageTileRect (12 wide,
; 18 rows) at the BG map scroll origin + 8 and MonsterDetailsSkillsLowerLeftTileRect (8 wide, 7
; rows) at the scroll origin + $160, with wArg7 = 0. Step 24 of PartnerStats and of its bank $F1
; twin; step 25 shows the skill names. (C1, E-0378)
; clears 21 x 4 tiles at vTiles2 + $200 and draws the tile rectangles
; MonsterDetailsSkillsPageTileRect (12 x 18) and MonsterDetailsSkillsLowerLeftTileRect (8 x 7)
; (E-0127) (E-0344: the address in its name dropped or read as the label there; was
; MonsterDetails_DrawSkillsPageFrames)
MonsterDetails_DrawSkillsPageFrames::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1504
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsSkillsPageTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsSkillsLowerLeftTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; Shows the skill names of the record in wRecordBufB on the skills page. If the first skill byte
; (wRecordBufB + MON_SKILLS) is $FF or 0 the record has no skills: it blanks 21 x 4 tiles at vTiles2
; + $200 and shows string $0E of category 8 there with ShowString_Bank08. Otherwise it goes through
; the eight skill bytes; each one is a 9 x 1 tile box, $90 bytes of VRAM after the one before it
; from vTiles2 + $200, filled with blank tiles when the byte is 0 or $FF and with string category 4,
; index = the skill id, when not. At the end the text window is put back to vTiles1, 18 wide and 2
; rows. Step 25 of PartnerStats and its bank $F1 twin. (C1, E-0378)
; shows the eight skill names of the record at wRecordBufB (field $34) in rows from vTiles2 + $200,
; or string $0E of category 8 when it has none (E-0129)
ShowRecordBufBSkillNamesOrNone::
    ld a, [wRecordBufB + MON_SKILLS]
    cp $ff
    jr z, .set_text_window_tile_lo
    and a
    jr z, .set_text_window_tile_lo
    jr .skip

.set_text_window_tile_lo:
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1504
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0e
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr .set_text_window_tile_lo2

.skip:
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08

.loop:
    push bc
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, wRecordBufB
    ld a, c
    add_a_to_hl
    ld a, [hl]
    and a
    jr z, .call_fill_tiles_from_request
    cp $ff
    jr z, .call_fill_tiles_from_request
    jr .set_string_index

.call_fill_tiles_from_request:
    call FillTilesFromRequest
    jr .restore

.set_string_index:
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    farcall ShowString_Bank08

.restore:
    pop hl
    ld a, l
    add $90
    ld l, a
    ld a, h
    adc $00
    ld h, a
    pop bc
    inc c
    dec b
    jr nz, .loop

.set_text_window_tile_lo2:
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; Clears the pedigree and summary pages so the summary page can be built. Draws
; MonsterDetailsPedigreeLowerLeftTileRect (8 x 7) at the BG map scroll origin + $160, blanks 2 x 1
; tiles at vTiles2 + $6C0, draws MonsterDetailsEmptyPedigreeTileRect (12 x 18) at the scroll origin
; + 8, blanks 8 x 5 tiles at vTiles2 + $200, and ends by setting the text window to vTiles1, 18 wide
; and 2 rows. All rectangles use wArg7 = 0. Farcalled at step 27 of PartnerStats and of its bank $F1
; twin when the player goes on from the skills page; wScreenStep then moves ahead by three. (C1,
; E-0378)
; draws the tile rectangles MonsterDetailsPedigreeLowerLeftTileRect and
; MonsterDetailsEmptyPedigreeTileRect, clears tile rows and sets up the summary text window (E-0128)
; (E-0344: the address in its name dropped or read as the label there; was DrawSummaryFrames)
DrawSummaryFrames::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsPedigreeLowerLeftTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld hl, vTiles2 + $6c0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsEmptyPedigreeTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0805
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; Draws the frames of the summary page: MonsterDetailsPanelTopTileRect (12 wide, 3 rows) at the BG
; map scroll origin + 8 and MonsterDetailsItemBoxTileRect (8 wide, 7 rows) at the scroll origin +
; $160, both with wArg7 = 0 through DrawTileRectFromArg1Params. Called at step 28 of PartnerStats
; (and of its bank $F1 twin), the first of the two calls of wScreenSubStep. (C1, E-0378)
; draws the tile rectangles MonsterDetailsPanelTopTileRect (12 x 3 at scroll + 8) and
; MonsterDetailsItemBoxTileRect (8 x 7 at scroll + $160) (E-0121) (E-0344: the address in its name
; dropped or read as the label there; was MonsterDetails_DrawSummaryPanelFrames)
MonsterDetails_DrawSummaryPanelFrames::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsPanelTopTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0c
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, MonsterDetailsItemBoxTileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; Returns HL = the BG map address of the tile at the scroll position: $9800 + (hScrollY & $F8) * 4 +
; hScrollX / 8 (32 tiles per map row, 8 pixels per tile; the low 3 bits of each scroll value are
; ignored). Clobbers A, DE. The same 41 bytes are in other banks too (for example
; BGMapAddressAtScroll_Bank37). Used by every frame-drawing routine of this bank to place rectangles
; relative to the screen. (C2, E-0378)
; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY);
; clobbers A, DE (the same 41 bytes appear in 3 banks)
BGMapAddressAtScroll_Bank1F::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_Priest::
    script_command SCRIPT_PRIEST
Script_Priest_2::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_ToPriest_3, Script_OhButNoneAppear, Script_OhButNoOne, Script_ButNoneAppearTo, Script_MayTheGodsGo
Script_MayTheGodsGo::
    script_command SCRIPT_BREED_CLOSE
    script_message $8005 ; '*: May the gods go with'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_ButNoneAppearTo::
    script_message $c003 ; '*: But none appear to be'
    script_jump Script_DoYouNeedAny
Script_OhButNoOne::
    script_message $c002 ; '*: Oh? But no one is'
    script_jump Script_DoYouNeedAny
Script_OhButNoneAppear::
    script_message $c001 ; '*: Oh? But none appear to'
    script_jump Script_DoYouNeedAny
Script_ToPriest_3::
    script_jump Script_Priest_3
Script_DoYouNeedAny::
    script_message $c004 ; '*: Do you need any other'
    script_jump Script_Priest_2
Script_Priest_3::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_WhichMonsterShouldBe, Script_WhoShouldBeCured, Script_WhoShouldBeFreed
Script_WhoShouldBeFreed::
    script_message $c008 ; '*: Who should be freed of'
    script_jump Script_Priest_4
Script_WhoShouldBeCured::
    script_message $c007 ; '*: Who should be cured of'
    script_jump Script_Priest_4
Script_WhichMonsterShouldBe::
    script_message $c006 ; '*: Which monster should be revived?'
Script_Priest_4::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_Priest_6, Script_Priest_5
Script_Priest_5::
    script_command SCRIPT_PRIEST
    script_jump Script_DoYouNeedAny
Script_Priest_6::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_IMustAskFor, Script_SurelyYouJestThat, Script_ButThatMonsterIs_2, Script_ButThatMonsterIs
Script_ButThatMonsterIs::
    script_message $c00b ; '*: But that monster is not'
    script_jump Script_Priest_3
Script_ButThatMonsterIs_2::
    script_message $c00a ; '*: But that monster is not'
    script_jump Script_Priest_3
Script_SurelyYouJestThat::
    script_message $c009 ; '*: Surely you jest. That one'
    script_jump Script_Priest_3
Script_IMustAskFor::
    script_command SCRIPT_PRIEST
    script_message $c00c ; '*: I must ask for a'
    script_command SCRIPT_PRIEST
    script_choice_jump Script_Priest_8, Script_OhMyMyHow, Script_Priest_7
Script_Priest_7::
    script_command SCRIPT_PRIEST
    script_jump Script_Priest_3
Script_OhMyMyHow::
    script_message $c014 ; '*: Oh, my, my… How deplorable!'
    script_command SCRIPT_PRIEST
    script_jump Script_DoYouNeedAny
Script_Priest_8::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_GodsTheSpiritsOf, Script_GodsIBegYou_2, Script_GodsIBegYou
Script_GodsIBegYou::
    script_message $c00f ; '*: Gods, I beg you, free'
    script_jump Script_Priest_9
Script_GodsIBegYou_2::
    script_message $c00e ; '*: Gods, I beg you, purify'
    script_jump Script_Priest_9
Script_GodsTheSpiritsOf::
    script_message $c00d ; '*: Gods, the spirits of earth!'
Script_Priest_9::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_HeroWasRevived, Script_HeroWasCleansedOf, Script_HeroWasFreedFrom
Script_HeroWasFreedFrom::
    script_message $c012 ; '0 was freed from the curse.'
    script_jump Script_Priest_10
Script_HeroWasCleansedOf::
    script_message $c011 ; '0 was cleansed of poison.'
    script_jump Script_Priest_10
Script_HeroWasRevived::
    script_message $c010 ; '0 was revived!'
Script_Priest_10::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_Priest_11, Script_NoOneElseSeems
Script_NoOneElseSeems::
    script_command SCRIPT_BREED_CLOSE
    script_message $8013 ; 'No one else seems to need'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_Priest_11::
    script_command SCRIPT_PRIEST
    script_jump Script_DoYouNeedAny
Script_Library::
    script_command SCRIPT_LIBRARY
Script_Library_2::
    script_command SCRIPT_LIBRARY
    script_choice_jump Script_WhichSpeciesWillYou, Script_ThatFamilyIsA, Script_ComeBackIfYou
Script_ComeBackIfYou::
    script_command SCRIPT_LIBRARY
    script_message $8002 ; '*: Come back if you need'
    script_command SCRIPT_LIBRARY
    script_end
Script_ThatFamilyIsA::
    script_message $c005 ; '*: That family is a mystery'
    script_message $c004 ; '*: Which family will you check?'
    script_jump Script_Library_2
Script_WhichSpeciesWillYou::
    script_message $c003 ; '*: Which species will you check?'
Script_Library_3::
    script_command SCRIPT_LIBRARY
    script_choice_jump Script_WhichSpeciesWillYou_2, Script_WhichFamilyWillYou
Script_WhichFamilyWillYou::
    script_command SCRIPT_LIBRARY
    script_message $c004 ; '*: Which family will you check?'
    script_command SCRIPT_LIBRARY
    script_jump Script_Library_2
Script_WhichSpeciesWillYou_2::
    script_command SCRIPT_LIBRARY
    script_message $c003 ; '*: Which species will you check?'
    script_command SCRIPT_LIBRARY
    script_jump Script_Library_3
    ds $759, $00
