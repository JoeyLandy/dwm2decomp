; ROM bank $1F: the font, scripts, strings and SGB data
; The annotated listing of this bank is build/listing/bank1f.asm.

SECTION "Bank 1F", ROMX[$4000], BANK[$1F]
    db $1f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; GlyphCopyArgsForA and LoadSixteenGlyphTilesFromTable73BC copy the 16 bytes at $4010 + 16 * glyph
; from bank $1F to VRAM, and CopyGlyphTilesToVRAM takes one glyph per text byte, so the glyph number
; is the character code; 259 glyphs up to SendSGBPacketSet at $5040 (E-0169, C1)
; record: glyph tile (2bpp, 16 bytes)
GlyphFont::
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
Tiles1Plus260Tiles_1F_40E0::
    db $ff, $f8, $ff, $84, $ff, $82, $ff, $82, $ff, $82, $ff, $84, $ff, $f8, $ff, $00 ; id 13 'D'
    db $ff, $fe, $ff, $80, $ff, $80, $ff, $fc, $ff, $80, $ff, $80, $ff, $fe, $ff, $00 ; id 14 'E'
    db $ff, $fe, $ff, $80, $ff, $80, $ff, $fc, $ff, $80, $ff, $80, $ff, $80, $ff, $00 ; id 15 'F'
Tiles2Plus7F0Tiles_1F_4110::
    db $ff, $3c, $ff, $42, $ff, $80, $ff, $9e, $ff, $82, $ff, $42, $ff, $3c, $ff, $00 ; id 16 'G'
Tiles1Plus710Tiles_1F_4120::
    db $ff, $82, $ff, $82, $ff, $82, $ff, $fe, $ff, $82, $ff, $82, $ff, $82, $ff, $00 ; id 17 'H'
Tiles2Plus210Tiles_1F_4130::
    db $ff, $7c, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $7c, $ff, $00 ; id 18 'I'
    db $ff, $7e, $ff, $08, $ff, $08, $ff, $08, $ff, $88, $ff, $88, $ff, $70, $ff, $00 ; id 19 'J'
    db $ff, $84, $ff, $88, $ff, $90, $ff, $b0, $ff, $c8, $ff, $84, $ff, $82, $ff, $00 ; id 20 'K'
Tiles2Plus200Tiles_1F_4160::
    db $ff, $80, $ff, $80, $ff, $80, $ff, $80, $ff, $80, $ff, $80, $ff, $fe, $ff, $00 ; id 21 'L'
Tiles2Plus240Tiles_1F_4170::
    db $ff, $82, $ff, $c6, $ff, $aa, $ff, $92, $ff, $82, $ff, $82, $ff, $82, $ff, $00 ; id 22 'M'
Tiles1Plus6E0Tiles_1F_4180::
    db $ff, $82, $ff, $c2, $ff, $a2, $ff, $92, $ff, $8a, $ff, $86, $ff, $82, $ff, $00 ; id 23 'N'
Tiles2Plus230Tiles_1F_4190::
    db $ff, $38, $ff, $44, $ff, $82, $ff, $82, $ff, $82, $ff, $44, $ff, $38, $ff, $00 ; id 24 'O'
Tiles1Plus770Tiles_1F_41A0::
    db $ff, $fc, $ff, $82, $ff, $82, $ff, $fc, $ff, $80, $ff, $80, $ff, $80, $ff, $00 ; id 25 'P'
    db $ff, $38, $ff, $44, $ff, $82, $ff, $82, $ff, $8a, $ff, $44, $ff, $3a, $ff, $00 ; id 26 'Q'
    db $ff, $fc, $ff, $82, $ff, $82, $ff, $fc, $ff, $88, $ff, $84, $ff, $82, $ff, $00 ; id 27 'R'
Tiles2Plus250Tiles_1F_41D0::
    db $ff, $78, $ff, $84, $ff, $80, $ff, $7c, $ff, $02, $ff, $82, $ff, $7c, $ff, $00 ; id 28 'S'
    db $ff, $fe, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 29 'T'
    db $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $82, $ff, $7c, $ff, $00 ; id 30 'U'
    db $ff, $82, $ff, $82, $ff, $44, $ff, $44, $ff, $28, $ff, $28, $ff, $10, $ff, $00 ; id 31 'V'
Tiles1Plus700Tiles_1F_4210::
    db $ff, $82, $ff, $92, $ff, $aa, $ff, $aa, $ff, $c6, $ff, $c6, $ff, $82, $ff, $00 ; id 32 'W'
    db $ff, $c6, $ff, $44, $ff, $28, $ff, $10, $ff, $28, $ff, $44, $ff, $c6, $ff, $00 ; id 33 'X'
Tiles2Plus700Tiles_1F_4230::
    db $ff, $82, $ff, $44, $ff, $28, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 34 'Y'
    db $ff, $fe, $ff, $04, $ff, $08, $ff, $10, $ff, $20, $ff, $40, $ff, $fe, $ff, $00 ; id 35 'Z'
Tiles1Plus2F0Tiles_1F_4250::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $04, $ff, $7c, $ff, $84, $ff, $7e, $ff, $00 ; id 36 'a'
Tiles1Plus4F0Tiles_1F_4260::
    db $ff, $80, $ff, $80, $ff, $80, $ff, $f8, $ff, $84, $ff, $84, $ff, $f8, $ff, $00 ; id 37 'b'
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $80, $ff, $84, $ff, $78, $ff, $00 ; id 38 'c'
Tiles1Plus2E0Tiles_1F_4280::
    db $ff, $04, $ff, $04, $ff, $04, $ff, $7c, $ff, $84, $ff, $84, $ff, $7c, $ff, $00 ; id 39 'd'
Tiles2Plus710Tiles_1F_4290::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $fc, $ff, $80, $ff, $7c, $ff, $00 ; id 40 'e'
    db $ff, $18, $ff, $24, $ff, $20, $ff, $fc, $ff, $20, $ff, $20, $ff, $20, $ff, $00 ; id 41 'f'
    db $ff, $00, $ff, $00, $ff, $7c, $ff, $84, $ff, $84, $ff, $7c, $ff, $04, $ff, $f8 ; id 42 'g'
    db $ff, $80, $ff, $80, $ff, $80, $ff, $f8, $ff, $84, $ff, $84, $ff, $84, $ff, $00 ; id 43 'h'
Tiles1Plus2E0Tiles_1F_42D0::
    db $ff, $00, $ff, $10, $ff, $00, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 44 'i'
    db $ff, $00, $ff, $10, $ff, $00, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $60 ; id 45 'j'
    db $ff, $80, $ff, $80, $ff, $8c, $ff, $b0, $ff, $c0, $ff, $b0, $ff, $8c, $ff, $00 ; id 46 'k'
Tiles1Plus7C0Tiles_1F_4300::
    db $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $10, $ff, $00 ; id 47 'l'
Tiles2Plus7B0Tiles_1F_4310::
    db $ff, $00, $ff, $00, $ff, $ec, $ff, $92, $ff, $92, $ff, $92, $ff, $92, $ff, $00 ; id 48 'm'
Tiles2Plus710Tiles_1F_4320::
    db $ff, $00, $ff, $00, $ff, $f8, $ff, $84, $ff, $84, $ff, $84, $ff, $84, $ff, $00 ; id 49 'n'
Tiles1Plus6F0Tiles_1F_4330::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $84, $ff, $84, $ff, $84, $ff, $78, $ff, $00 ; id 50 'o'
Tiles1Plus250Tiles_1F_4340::
    db $ff, $00, $ff, $00, $ff, $f8, $ff, $84, $ff, $84, $ff, $f8, $ff, $80, $ff, $80 ; id 51 'p'
    db $ff, $00, $ff, $00, $ff, $7c, $ff, $84, $ff, $84, $ff, $7c, $ff, $04, $ff, $04 ; id 52 'q'
    db $ff, $00, $ff, $00, $ff, $9c, $ff, $a0, $ff, $c0, $ff, $80, $ff, $80, $ff, $00 ; id 53 'r'
Tiles2Plus720Tiles_1F_4370::
    db $ff, $00, $ff, $00, $ff, $78, $ff, $80, $ff, $78, $ff, $04, $ff, $f8, $ff, $00 ; id 54 's'
    db $ff, $00, $ff, $20, $ff, $fc, $ff, $20, $ff, $20, $ff, $20, $ff, $1c, $ff, $00 ; id 55 't'
    db $ff, $00, $ff, $00, $ff, $84, $ff, $84, $ff, $84, $ff, $84, $ff, $78, $ff, $00 ; id 56 'u'
    db $ff, $00, $ff, $00, $ff, $84, $ff, $84, $ff, $84, $ff, $48, $ff, $30, $ff, $00 ; id 57 'v'
    db $ff, $00, $ff, $00, $ff, $82, $ff, $92, $ff, $92, $ff, $aa, $ff, $44, $ff, $00 ; id 58 'w'
Tiles1Plus2D0Tiles_1F_43C0::
    db $ff, $00, $ff, $00, $ff, $84, $ff, $48, $ff, $30, $ff, $48, $ff, $84, $ff, $00 ; id 59 'x'
    db $ff, $00, $ff, $00, $ff, $84, $ff, $84, $ff, $84, $ff, $7c, $ff, $04, $ff, $f8 ; id 60 'y'
    db $ff, $00, $ff, $00, $ff, $fc, $ff, $08, $ff, $30, $ff, $40, $ff, $fc, $ff, $00 ; id 61 'z'
    db $ff, $80, $ff, $80, $ff, $3c, $ff, $40, $ff, $3c, $ff, $02, $ff, $7c, $ff, $00 ; id 62 ''s'
    db $ff, $80, $ff, $80, $ff, $76, $ff, $49, $ff, $49, $ff, $49, $ff, $49, $ff, $00 ; id 63 ''m'
    db $ff, $80, $ff, $80, $ff, $0e, $ff, $50, $ff, $60, $ff, $40, $ff, $40, $ff, $00 ; id 64 ''r'
    db $ff, $80, $ff, $90, $ff, $7e, $ff, $10, $ff, $10, $ff, $10, $ff, $0e, $ff, $00 ; id 65 ''t'
    db $ff, $80, $ff, $80, $ff, $00, $ff, $42, $ff, $42, $ff, $24, $ff, $18, $ff, $00 ; id 66 ''v'
    db $ff, $88, $ff, $88, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $00 ; id 67 ''l'
Tiles1Plus6F0Tiles_1F_4450::
    db $ff, $82, $ff, $82, $ff, $02, $ff, $3e, $ff, $42, $ff, $42, $ff, $3e, $ff, $00 ; id 68
    db $ff, $00, $ff, $20, $ff, $a8, $ff, $72, $ff, $70, $ff, $a8, $ff, $22, $ff, $00 ; id 69 '*:'
    db $ff, $70, $ff, $20, $ff, $20, $ff, $20, $ff, $20, $ff, $20, $ff, $70, $ff, $00 ; id 70
Tiles1Plus7B0Tiles_1F_4480::
    db $ff, $f8, $ff, $50, $ff, $50, $ff, $50, $ff, $50, $ff, $50, $ff, $f8, $ff, $00 ; id 71
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 72
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 73
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 74
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 75
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 76
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 77
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 78
Tiles1Plus4C0Tiles_1F_4500::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 79
Tiles1Plus6E0Tiles_1F_4510::
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
Tiles1Plus7C0Tiles_1F_4780::
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
RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data::
    db $ff, $05, $ff, $05, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 141
DebugResultsDisplay_Init_Data::
    db $ff, $02, $ff, $05, $ff, $02, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 142
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $30, $ff, $48, $ff, $48, $ff, $30 ; id 143
Tiles2Plus710Tiles_1F_4910::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 144 ' '
    db $ff, $00, $eb, $08, $ed, $70, $ff, $82, $b7, $ca, $8b, $fe, $f7, $74, $ff, $00 ; id 145
    db $ff, $00, $ff, $24, $ff, $54, $ff, $58, $ff, $2a, $ff, $15, $ff, $15, $ff, $22 ; id 146
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $66, $ff, $66, $ff, $00 ; id 147
    db $ff, $00, $ff, $00, $ff, $00, $ff, $60, $ff, $00, $ff, $60, $ff, $20, $ff, $40 ; id 148
    db $ff, $60, $ff, $60, $ff, $20, $ff, $40, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; id 149 '''
    db $ff, $00, $ff, $0e, $ff, $08, $ff, $08, $ff, $08, $ff, $08, $ff, $00, $ff, $00 ; id 150
    db $ff, $00, $ff, $00, $ff, $00, $ff, $20, $ff, $20, $ff, $20, $ff, $20, $ff, $e0 ; id 151
Tiles2Plus420Tiles_1F_4990::
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
Tiles1Plus7D0Tiles_1F_4A40::
    db $ff, $00, $ff, $18, $ff, $18, $ff, $00, $ff, $00, $ff, $18, $ff, $18, $ff, $00 ; id 163 ':'
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $92, $ff, $00 ; id 164 '…'
Tiles1Plus6A0Tiles_1F_4A60::
    db $ff, $00, $ff, $80, $ff, $80, $ff, $80, $ff, $8a, $ff, $8a, $ff, $84, $ff, $f4 ; id 165
Tiles1Plus7F0Tiles_1F_4A70::
    db $ff, $00, $ff, $e0, $ff, $80, $ff, $80, $ff, $ea, $ff, $84, $ff, $84, $ff, $ea ; id 166
Tiles1Plus7E0Tiles_1F_4A80::
    db $ff, $00, $ff, $1e, $ff, $06, $ff, $0a, $ff, $72, $ff, $90, $ff, $90, $ff, $60 ; id 167
Tiles1Plus7F0Tiles_1F_4A90::
    db $ff, $00, $ff, $38, $ff, $44, $ff, $44, $ff, $38, $ff, $10, $ff, $7c, $ff, $10 ; id 168
Tiles2Plus20Tiles_1F_4AA0::
    db $ff, $00, $ff, $10, $ff, $38, $ff, $7c, $ff, $fe, $ff, $38, $ff, $38, $ff, $38 ; id 169
    db $ff, $00, $ff, $6c, $ff, $6c, $ff, $24, $ff, $48, $ff, $00, $ff, $00, $ff, $00 ; id 170
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $60, $ff, $60, $ff, $20, $ff, $40 ; id 171 ','
Tiles1Plus4A0Tiles_1F_4AD0::
    db $ff, $00, $ff, $10, $ff, $10, $ff, $fe, $ff, $7c, $ff, $38, $ff, $7c, $ff, $c6 ; id 172 '★'
Tiles2Plus30Tiles_1F_4AE0::
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
    dw SgbMaskEn_1F_513E ; id 0
    dw SgbMaskEn_1F_514E ; id 1
    dw SGBPackets ; id 2
    dw SgbDataSnd_1F_50CE ; id 3
    dw SgbDataSnd_1F_50DE ; id 4
    dw SgbDataSnd_1F_50EE ; id 5
    dw SgbDataSnd_1F_50FE ; id 6
    dw SgbDataSnd_1F_510E ; id 7
    dw SgbDataSnd_1F_511E ; id 8
    dw SgbDataSnd_1F_512E ; id 9
    dw SgbMltReq_1F_515E ; id 10
    dw SgbMltReq_1F_516E ; id 11
    dw SgbPalTrn_1F_517E ; id 12
    dw SgbAttrTrn_1F_518E ; id 13
    dw SgbPalSet_1F_519E ; id 14
    dw SgbPctTrn_1F_51AE ; id 15
    dw SgbChrTrn_1F_51BE ; id 16
    dw SgbChrTrn_1F_51CE ; id 17
    dw SGBPackets_12 ; id 18
    dw SgbIconEn_1F_51EE ; id 19
    dw SgbMaskEn_1F_51FE ; id 20

; the packets SGBPacketSetTable points at; each set is one packet here; 21 packets end at $520E
; (E-0179, C1)
; record: SGB packet (byte 0 = command * 8 + packet count)
SGBPackets::
SgbDataSnd_1F_50BE::
    db $79, $5d, $08, $00, $0b, $8c, $d0, $f4, $60, $00, $00, $00, $00, $00, $00, $00 ; id 0
SgbDataSnd_1F_50CE::
    db $79, $52, $08, $00, $0b, $a9, $e7, $9f, $01, $c0, $7e, $e8, $e8, $e8, $e8, $e0 ; id 1
SgbDataSnd_1F_50DE::
    db $79, $47, $08, $00, $0b, $c4, $d0, $16, $a5, $cb, $c9, $05, $d0, $10, $a2, $28 ; id 2
SgbDataSnd_1F_50EE::
    db $79, $3c, $08, $00, $0b, $f0, $12, $a5, $c9, $c9, $c8, $d0, $1c, $a5, $ca, $c9 ; id 3
SgbDataSnd_1F_50FE::
    db $79, $31, $08, $00, $0b, $0c, $a5, $ca, $c9, $7e, $d0, $06, $a5, $cb, $c9, $7e ; id 4
SgbDataSnd_1F_510E::
    db $79, $26, $08, $00, $0b, $39, $cd, $48, $0c, $d0, $34, $a5, $c9, $c9, $80, $d0 ; id 5
SgbDataSnd_1F_511E::
    db $79, $1b, $08, $00, $0b, $ea, $ea, $ea, $ea, $ea, $a9, $01, $cd, $4f, $0c, $d0 ; id 6
SgbDataSnd_1F_512E::
    db $79, $10, $08, $00, $0b, $4c, $20, $08, $ea, $ea, $ea, $ea, $ea, $60, $ea, $ea ; id 7
SgbMaskEn_1F_513E::
    db $b9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 8
SgbMaskEn_1F_514E::
    db $b9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
SgbMltReq_1F_515E::
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
SgbMltReq_1F_516E::
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
SgbPalTrn_1F_517E::
    db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
SgbAttrTrn_1F_518E::
    db $a9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
SgbPalSet_1F_519E::
    db $51, $00, $00, $01, $00, $02, $00, $03, $00, $c0, $00, $00, $00, $00, $00, $00 ; id 14
SgbPctTrn_1F_51AE::
    db $a1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
SgbChrTrn_1F_51BE::
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
SgbChrTrn_1F_51CE::
    db $99, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17
SGBPackets_12::
    db $c9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
SgbIconEn_1F_51EE::
    db $71, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19
SgbMaskEn_1F_51FE::
    db $b9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 20

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank1F::
    ld de, StringCategories_1F_5223
    call BeginStringDisplay
    ret
    db $11, $23, $52, $cd, $fe, $25, $c9, $cd, $0e, $52, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_1F_5223::
    dw StringList_1F_5225 ; id 0

; category list of StringCategories_1F_5223; one pointer per wStringIndex (E-0217)
; record: string
StringList_1F_5225::
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
    dw Script_1F_5A3A ; id 62
    dw Script_1F_5A3A ; id 63

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
Script_1F_5A3A::
    script_command SCRIPT_SWAP_MONSTERS
Script_1F_5A3B::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5A51, Script_1F_5A4E, Script_1F_5A4B, Script_1F_5A48, Script_1F_5A42
Script_1F_5A42::
    script_command SCRIPT_MENU_CLOSE
    script_message_unless_flag0 $801d ; flag 0 set: 'Cobi: Come back anytime, sis!'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_1F_5A48::
    script_jump Script_1F_5B96
Script_1F_5A4B::
    script_jump Script_1F_5B61
Script_1F_5A4E::
    script_jump Script_1F_5AC5
Script_1F_5A51::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5A55, Script_1F_5A58
Script_1F_5A55::
    script_jump Script_1F_5A80
Script_1F_5A58::
    script_message_unless_flag0 $c002 ; flag 0 set: 'Cobi: Which one's staying here?'
Script_1F_5A5B::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5A66, Script_1F_5A5F
Script_1F_5A5F::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5A3B
Script_1F_5A66::
    script_message_unless_flag0 $c003 ; flag 0 set: 'Cobi: So this one is staying'
Script_1F_5A69::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5A7C, Script_1F_5A75, Script_1F_5A6E
Script_1F_5A6E::
    script_message_unless_flag0 $c002 ; flag 0 set: 'Cobi: Which one's staying here?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5A5B
Script_1F_5A75::
    script_message_unless_flag0 $c004 ; flag 0 set: 'Cobi: Check up on the others'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5A5F
Script_1F_5A7C::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5A69
Script_1F_5A80::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5A87, Script_1F_5A8D
Script_1F_5A87::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5A8D::
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
Script_1F_5A90::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5A9A, Script_1F_5A94
Script_1F_5A94::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5A9A::
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
Script_1F_5A9D::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5AA7, Script_1F_5AA1
Script_1F_5AA1::
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
    script_jump Script_1F_5A90
Script_1F_5AA7::
    script_message_unless_flag0 $c009 ; flag 0 set: 'Cobi: So you'll take this one?'
Script_1F_5AAA::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5AC1, Script_1F_5AB6, Script_1F_5AAF
Script_1F_5AAF::
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5A9D
Script_1F_5AB6::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c00a ; flag 0 set: 'Cobi: I switched 0.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5AC1::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5AAA
Script_1F_5AC5::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5ACA, Script_1F_5AD3, Script_1F_5AD6
Script_1F_5ACA::
    script_message_unless_flag0 $c010 ; flag 0 set: 'Cobi: You haven't left any here.'
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5AD3::
    script_jump Script_1F_5B01
Script_1F_5AD6::
    script_message_unless_flag0 $c00d ; flag 0 set: 'Cobi: Which one will you take?'
Script_1F_5AD9::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5AE3, Script_1F_5ADD
Script_1F_5ADD::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5AE3::
    script_message_unless_flag0 $c00e ; flag 0 set: 'Cobi: Is this the one you'll'
Script_1F_5AE6::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5AFD, Script_1F_5AF2, Script_1F_5AEB
Script_1F_5AEB::
    script_message_unless_flag0 $c00d ; flag 0 set: 'Cobi: Which one will you take?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5AD9
Script_1F_5AF2::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c00f ; flag 0 set: 'Cobi: It's eager to go, 0.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5AFD::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5AE6
Script_1F_5B01::
    script_message_unless_flag0 $c011 ; flag 0 set: 'Cobi: You can't take any more.'
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
Script_1F_5B07::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B11, Script_1F_5B0B
Script_1F_5B0B::
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5B11::
    script_message_unless_flag0 $c00c ; flag 0 set: 'Cobi: What'll you switch it with?'
Script_1F_5B14::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B1F, Script_1F_5B18
Script_1F_5B18::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c007 ; flag 0 set: 'Cobi: Switch with one on the'
    script_jump Script_1F_5B07
Script_1F_5B1F::
    script_message_unless_flag0 $c003 ; flag 0 set: 'Cobi: So this one is staying'
Script_1F_5B22::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B35, Script_1F_5B2E, Script_1F_5B27
Script_1F_5B27::
    script_message_unless_flag0 $c00c ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5B14
Script_1F_5B2E::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_jump Script_1F_5B39
Script_1F_5B35::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5B22
Script_1F_5B39::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B43, Script_1F_5B3D
Script_1F_5B3D::
    script_message_unless_flag0 $c00c ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_jump Script_1F_5B14
Script_1F_5B43::
    script_message_unless_flag0 $c00e ; flag 0 set: 'Cobi: Is this the one you'll'
Script_1F_5B46::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B5D, Script_1F_5B52, Script_1F_5B4B
Script_1F_5B4B::
    script_message_unless_flag0 $c008 ; flag 0 set: 'Cobi: What'll you switch it with?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5B39
Script_1F_5B52::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c00a ; flag 0 set: 'Cobi: I switched 0.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5B5D::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5B46
Script_1F_5B61::
    script_command SCRIPT_SWAP_MONSTERS
Script_1F_5B62::
    script_message_unless_flag0 $c012 ; flag 0 set: 'Cobi: What do you want to'
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B6B, Script_1F_5B6E, Script_1F_5B71, Script_1F_5B7E
Script_1F_5B6B::
    script_jump Script_1F_5B81
Script_1F_5B6E::
    script_jump Script_1F_5B8F
Script_1F_5B71::
    script_message_unless_flag0 $c013 ; flag 0 set: 'Cobi: We don't have any of'
    script_jump Script_1F_5B62
Script_1F_5B77::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5B7E::
    script_jump Script_1F_5B77
Script_1F_5B81::
    script_message_unless_flag0 $c015 ; flag 0 set: 'Cobi: Which one will you check?'
Script_1F_5B84::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5B8B, Script_1F_5B88
Script_1F_5B88::
    script_jump Script_1F_5B62
Script_1F_5B8B::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5B84
Script_1F_5B8F::
    script_message_unless_flag0 $c016 ; flag 0 set: 'Cobi: Which egg will you check?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5B62
Script_1F_5B96::
    script_command SCRIPT_SWAP_MONSTERS
Script_1F_5B97::
    script_message_unless_flag0 $c017 ; flag 0 set: 'Cobi: What do you want to'
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5BA7, Script_1F_5BAA, Script_1F_5BAD, Script_1F_5BBA, Script_1F_5BA1
Script_1F_5BA1::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
    script_jump Script_1F_5B97
Script_1F_5BA7::
    script_jump Script_1F_5BBD
Script_1F_5BAA::
    script_jump Script_1F_5BE9
Script_1F_5BAD::
    script_message_unless_flag0 $c013 ; flag 0 set: 'Cobi: We don't have any of'
    script_jump Script_1F_5B97
Script_1F_5BB3::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5BBA::
    script_jump Script_1F_5BB3
Script_1F_5BBD::
    script_message_unless_flag0 $c018 ; flag 0 set: 'Cobi: Which one will you release?'
Script_1F_5BC0::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5BC7, Script_1F_5BC4
Script_1F_5BC4::
    script_jump Script_1F_5B97
Script_1F_5BC7::
    script_message_unless_flag0 $c01a ; flag 0 set: 'Cobi: It'll be gone forever. Sure?'
Script_1F_5BCA::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5BE5, Script_1F_5BDA, Script_1F_5BD3, Script_1F_5BD0
Script_1F_5BD0::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
Script_1F_5BD3::
    script_message_unless_flag0 $c018 ; flag 0 set: 'Cobi: Which one will you release?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5BC0
Script_1F_5BDA::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c01c ; flag 0 set: '0 was released in the wild.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5BE5::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5BCA
Script_1F_5BE9::
    script_message_unless_flag0 $c019 ; flag 0 set: 'Cobi: Which egg will you release?'
Script_1F_5BEC::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5BF3, Script_1F_5BF0
Script_1F_5BF0::
    script_jump Script_1F_5B97
Script_1F_5BF3::
    script_message_unless_flag0 $c01a ; flag 0 set: 'Cobi: It'll be gone forever. Sure?'
Script_1F_5BF6::
    script_command SCRIPT_SWAP_MONSTERS
    script_choice_jump Script_1F_5C11, Script_1F_5C06, Script_1F_5BFF, Script_1F_5BFC
Script_1F_5BFC::
    script_message_unless_flag0 $c006 ; flag 0 set: 'Cobi: No, you can't go off'
Script_1F_5BFF::
    script_message_unless_flag0 $c019 ; flag 0 set: 'Cobi: Which egg will you release?'
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5BEC
Script_1F_5C06::
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c01b ; flag 0 set: 'The egg was released.'
    script_command SCRIPT_SWAP_MONSTERS
    script_message_unless_flag0 $c005 ; flag 0 set: 'Cobi: Do you need anything else?'
    script_jump Script_1F_5A3B
Script_1F_5C11::
    script_command SCRIPT_SWAP_MONSTERS
    script_jump Script_1F_5BF6

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

DrawRecordListPageNames_Data::
    db $00, $8d, $50, $8d, $a0, $8d, $00, $8f, $40, $8a

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

GlyphCopyArgsForA_Data::
    db $40, $8a, $50, $8a, $60, $8a, $e0, $8c, $f0, $8c

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

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 3 tiles, one row per line
TileRect_1F_5E13::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2

; record: 20 x 18 tiles, one row per line
TileRect_1F_5E37::
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

; the same box layout as TileRect_1F_5E37, which SwapMonstersMenu_Case08_Case03 draws as 20 x 18;
; the four screens are contiguous, 360 bytes each; no reader of this one was found (E-0187, C1)
TileScreen_1F_5F9F::
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

TileScreen_1F_6107::
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

TileScreen_1F_626F::
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

; record: 12 x 18 tiles, one row per line
TileRect_1F_63D7::
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

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 6 tiles, one row per line
TileRect_1F_64AF::
    db $20, $21, $22, $23, $24, $25 ; id 0
    db $26, $27, $28, $29, $2a, $2b ; id 1
    db $2c, $2d, $2e, $2f, $30, $31 ; id 2
    db $32, $33, $34, $35, $36, $37 ; id 3
    db $38, $39, $3a, $3b, $3c, $3d ; id 4
    db $3e, $3f, $40, $41, $42, $43 ; id 5

TileRect_1F_64D3::
    db $02, $03, $04, $05, $06, $07 ; id 0
    db $08, $09, $0a, $0b, $0c, $0d ; id 1
    db $0e, $0f, $10, $11, $12, $13 ; id 2
    db $14, $15, $16, $17, $18, $19 ; id 3
    db $1a, $1b, $1c, $1d, $1e, $1f ; id 4
    db $20, $21, $22, $23, $24, $25 ; id 5

TileRect_1F_64F7::
    db $48, $49, $4a, $4b, $4c, $4d ; id 0
    db $4e, $4f, $50, $51, $52, $53 ; id 1
    db $54, $55, $56, $57, $58, $59 ; id 2
    db $5a, $5b, $5c, $5d, $5e, $5f ; id 3
    db $60, $61, $62, $63, $64, $65 ; id 4
    db $66, $67, $68, $69, $6a, $6b ; id 5

TileRect_1F_651B::
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 5

; record: 8 x 7 tiles, one row per line
TileRect_1F_653F::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; record: 12 x 15 tiles, one row per line
TileRect_1F_6577::
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

TileRect_1F_662B::
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

TileRect_1F_66DF::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 1
    db $b6, $32, $33, $34, $35, $36, $37, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $38, $39, $3a, $3b, $3c, $3d, $b7 ; id 4
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

; record: 20 x 18 tiles, one row per line
TileRect_1F_6717::
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
TileRect_1F_687F::
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

TileRect_1F_69E7::
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

; record: 12 x 18 tiles, one row per line
TileRect_1F_6B4F::
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

; record: 8 x 7 tiles, one row per line
TileRect_1F_6C27::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

TileRect_1F_6C5F::
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

TileRect_1F_6D37::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

TileRect_1F_6D6F::
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

TileRect_1F_6E47::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $7c, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $6e, $7e, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $6f, $7e, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $7d, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6

TileRect_1F_6E7F::
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

TileRect_1F_6FE7::
    db $c3, $c3, $c3, $c3, $c3, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $00, $00, $c3, $c3, $b6, $c3, $50, $51, $52, $53, $54, $c3, $b7, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $00, $00, $c3, $c3, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $00, $00, $c3, $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $06, $35, $3b, $28, $39, $c3, $13, $24, $30, $28, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 6
    db $b6, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $c3, $0f, $10, $11, $12, $b7 ; id 7
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Case07_Data::
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

; record: 20 x 5 tiles, one row per line
TileRect_1F_714F::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $b7 ; id 1
RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params_Data::
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $6e, $6f, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 20 x 3 tiles, one row per line
TileRect_1F_71B3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
TileRect_1F_71EF::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $13, $36, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; GameMode6_Init_Sub01_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24 sets wArg1/wArg2 = $720D +
; (wScreenByteBD - 1) * $78, wArg3 = 20, wArg4 = 6, wArg7 = 1 and far-calls
; DrawTileRectFromArg1Params at the scroll origin + $E0; three panels fill $720D-$7375 (E-0187, C1)
; record: one 20 x 6 tile panel (wScreenByteBD selects it)
TileRect_1F_720D::
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

; copies 16 glyph tiles (LoadSixteenGlyphTilesFromTable73BC_Data1) from bank $1F to the VRAM
; addresses in LoadSixteenGlyphTilesFromTable73BC_Data2 (E-0127)
LoadSixteenGlyphTilesFromTable73BC::
    ld c, $00

.loop:
    push bc
    ld a, c
    ld de, LoadSixteenGlyphTilesFromTable73BC_Data1
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
    ld de, LoadSixteenGlyphTilesFromTable73BC_Data2
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

LoadSixteenGlyphTilesFromTable73BC_Data1::
    db $a3, $54, $44, $11, $16, $19, $48, $24, $a6, $12, $31, $29, $32, $18, $14, $25

LoadSixteenGlyphTilesFromTable73BC_Data2::
    db $d0, $8e, $e0, $8e, $f0, $8e, $50, $8f, $60, $8f, $70, $8f, $d0, $8f, $e0, $8f
    db $f0, $8f, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; first call: draws the 6 x 6 frame TileRect_1F_651B and loads the picture of species wRecordBufB +
; $B at vTiles2 + $200; second call: loads its CGB attributes and draws the picture (E-0128)
; (E-0340: the address in its name read as its RAM name; was DrawWCA36MonsterPictureInTwoSteps)
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
    ld de, TileRect_1F_651B
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
    ld de, TileRect_1F_64AF
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
    ld de, Tiles1Plus2F0Tiles_1F_4250
    ld hl, vTiles1 + $7e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_1F_4A70
    ld hl, vTiles1 + $7f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus4A0Tiles_1F_4AD0
    ld hl, vTiles2 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; draws the tile rectangles TileRect_1F_662B (12 x 15 at scroll + $68) and TileRect_1F_653F (8 x 7
; at scroll + $160) (E-0121)
DrawRects662BAnd653F::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0068
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_662B
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
    ld de, TileRect_1F_653F
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

; draws the tile rectangles TileRect_1F_6B4F (12 x 18 at scroll + 8) and TileRect_1F_6C27 (8 x 7 at
; scroll + $160) (E-0121)
DrawRects6B4FAnd6C27::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_6B4F
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
    ld de, TileRect_1F_6C27
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

; clears 21 x 4 tiles at vTiles2 + $200 and draws the tile rectangles TileRect_1F_6C5F (12 x 18) and
; TileRect_1F_6D37 (8 x 7) (E-0127)
ClearTilesAndDrawRects6C5FAnd6D37::
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
    ld de, TileRect_1F_6C5F
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
    ld de, TileRect_1F_6D37
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

; draws the tile rectangles TileRect_1F_6E47 and TileRect_1F_6D6F, clears tile rows and sets up the
; summary text window (E-0128)
DrawSummaryFrames6E47And6D6F::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_6E47
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
    ld de, TileRect_1F_6D6F
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

; draws the tile rectangles TileRect_1F_5E13 (12 x 3 at scroll + 8) and TileRect_1F_66DF (8 x 7 at
; scroll + $160) (E-0121)
DrawRects5E13And66DF::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_5E13
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
    ld de, TileRect_1F_66DF
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
Script_1F_77D4::
    script_command SCRIPT_PRIEST
Script_1F_77D5::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_77F4, Script_1F_77EE, Script_1F_77E8, Script_1F_77E2, Script_1F_77DC
Script_1F_77DC::
    script_command SCRIPT_BREED_CLOSE
    script_message $8005 ; '*: May the gods go with'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_1F_77E2::
    script_message $c003 ; '*: But none appear to be'
    script_jump Script_1F_77F7
Script_1F_77E8::
    script_message $c002 ; '*: Oh? But no one is'
    script_jump Script_1F_77F7
Script_1F_77EE::
    script_message $c001 ; '*: Oh? But none appear to'
    script_jump Script_1F_77F7
Script_1F_77F4::
    script_jump Script_1F_77FD
Script_1F_77F7::
    script_message $c004 ; '*: Do you need any other'
    script_jump Script_1F_77D5
Script_1F_77FD::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_780E, Script_1F_7808, Script_1F_7802
Script_1F_7802::
    script_message $c008 ; '*: Who should be freed of'
    script_jump Script_1F_7811
Script_1F_7808::
    script_message $c007 ; '*: Who should be cured of'
    script_jump Script_1F_7811
Script_1F_780E::
    script_message $c006 ; '*: Which monster should be revived?'
Script_1F_7811::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_7819, Script_1F_7815
Script_1F_7815::
    script_command SCRIPT_PRIEST
    script_jump Script_1F_77F7
Script_1F_7819::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_7831, Script_1F_782B, Script_1F_7825, Script_1F_781F
Script_1F_781F::
    script_message $c00b ; '*: But that monster is not'
    script_jump Script_1F_77FD
Script_1F_7825::
    script_message $c00a ; '*: But that monster is not'
    script_jump Script_1F_77FD
Script_1F_782B::
    script_message $c009 ; '*: Surely you jest. That one'
    script_jump Script_1F_77FD
Script_1F_7831::
    script_command SCRIPT_PRIEST
    script_message $c00c ; '*: I must ask for a'
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_7845, Script_1F_783E, Script_1F_783A
Script_1F_783A::
    script_command SCRIPT_PRIEST
    script_jump Script_1F_77FD
Script_1F_783E::
    script_message $c014 ; '*: Oh, my, my… How deplorable!'
    script_command SCRIPT_PRIEST
    script_jump Script_1F_77F7
Script_1F_7845::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_7856, Script_1F_7850, Script_1F_784A
Script_1F_784A::
    script_message $c00f ; '*: Gods, I beg you, free'
    script_jump Script_1F_7859
Script_1F_7850::
    script_message $c00e ; '*: Gods, I beg you, purify'
    script_jump Script_1F_7859
Script_1F_7856::
    script_message $c00d ; '*: Gods, the spirits of earth!'
Script_1F_7859::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_786A, Script_1F_7864, Script_1F_785E
Script_1F_785E::
    script_message $c012 ; '0 was freed from the curse.'
    script_jump Script_1F_786D
Script_1F_7864::
    script_message $c011 ; '0 was cleansed of poison.'
    script_jump Script_1F_786D
Script_1F_786A::
    script_message $c010 ; '0 was revived!'
Script_1F_786D::
    script_command SCRIPT_PRIEST
    script_choice_jump Script_1F_7877, Script_1F_7871
Script_1F_7871::
    script_command SCRIPT_BREED_CLOSE
    script_message $8013 ; 'No one else seems to need'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_1F_7877::
    script_command SCRIPT_PRIEST
    script_jump Script_1F_77F7
Script_1F_787B::
    script_command SCRIPT_LIBRARY
Script_1F_787C::
    script_command SCRIPT_LIBRARY
    script_choice_jump Script_1F_7890, Script_1F_7887, Script_1F_7881
Script_1F_7881::
    script_command SCRIPT_LIBRARY
    script_message $8002 ; '*: Come back if you need'
    script_command SCRIPT_LIBRARY
    script_end
Script_1F_7887::
    script_message $c005 ; '*: That family is a mystery'
    script_message $c004 ; '*: Which family will you check?'
    script_jump Script_1F_787C
Script_1F_7890::
    script_message $c003 ; '*: Which species will you check?'
Script_1F_7893::
    script_command SCRIPT_LIBRARY
    script_choice_jump Script_1F_789F, Script_1F_7897
Script_1F_7897::
    script_command SCRIPT_LIBRARY
    script_message $c004 ; '*: Which family will you check?'
    script_command SCRIPT_LIBRARY
    script_jump Script_1F_787C
Script_1F_789F::
    script_command SCRIPT_LIBRARY
    script_message $c003 ; '*: Which species will you check?'
    script_command SCRIPT_LIBRARY
    script_jump Script_1F_7893
    ds $759, $00
