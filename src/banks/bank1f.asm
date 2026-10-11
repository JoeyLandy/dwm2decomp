SECTION "Bank 1F", ROMX[$4000], BANK[$1F]
    db $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; E-0169 (C1: GlyphCopyArgsForA and LoadSixteenGlyphTilesFromTable73BC copy the 16 bytes at $4010 + 16 * glyph from bank $1F to VRAM, and CopyGlyphTilesToVRAM takes one glyph per text byte, so the glyph number is the character code; 259 glyphs up to SendSGBPacketSet at $5040).
; record: glyph tile (2bpp, 16 bytes)
GlyphFont::
Data_01F_4010:: ; address name
    db $FF, $7C, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $7C, $FF, $00 ; id 0 '0'
    db $FF, $10, $FF, $30, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $7C, $FF, $00 ; id 1 '1'
    db $FF, $7C, $FF, $82, $FF, $02, $FF, $0C, $FF, $30, $FF, $40, $FF, $FE, $FF, $00 ; id 2 '2'
    db $FF, $7C, $FF, $82, $FF, $02, $FF, $3C, $FF, $02, $FF, $82, $FF, $7C, $FF, $00 ; id 3 '3'
    db $FF, $0C, $FF, $14, $FF, $24, $FF, $44, $FF, $84, $FF, $FE, $FF, $04, $FF, $00 ; id 4 '4'
    db $FF, $FC, $FF, $80, $FF, $80, $FF, $FC, $FF, $02, $FF, $82, $FF, $7C, $FF, $00 ; id 5 '5'
    db $FF, $7C, $FF, $82, $FF, $80, $FF, $FC, $FF, $82, $FF, $82, $FF, $7C, $FF, $00 ; id 6 '6'
    db $FF, $7E, $FF, $82, $FF, $02, $FF, $04, $FF, $04, $FF, $08, $FF, $08, $FF, $00 ; id 7 '7'
    db $FF, $7C, $FF, $82, $FF, $82, $FF, $7C, $FF, $82, $FF, $82, $FF, $7C, $FF, $00 ; id 8 '8'
    db $FF, $7C, $FF, $82, $FF, $82, $FF, $7E, $FF, $02, $FF, $82, $FF, $7C, $FF, $00 ; id 9 '9'
    db $FF, $10, $FF, $28, $FF, $28, $FF, $44, $FF, $7C, $FF, $82, $FF, $82, $FF, $00 ; id 10 'A'
    db $FF, $F8, $FF, $84, $FF, $84, $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $00 ; id 11 'B'
    db $FF, $3C, $FF, $42, $FF, $80, $FF, $80, $FF, $80, $FF, $42, $FF, $3C, $FF, $00 ; id 12 'C'
Data_01F_40E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $F8, $FF, $84, $FF, $82, $FF, $82, $FF, $82, $FF, $84, $FF, $F8, $FF, $00 ; id 13 'D'
    db $FF, $FE, $FF, $80, $FF, $80, $FF, $FC, $FF, $80, $FF, $80, $FF, $FE, $FF, $00 ; id 14 'E'
    db $FF, $FE, $FF, $80, $FF, $80, $FF, $FC, $FF, $80, $FF, $80, $FF, $80, $FF, $00 ; id 15 'F'
Data_01F_4110:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $3C, $FF, $42, $FF, $80, $FF, $9E, $FF, $82, $FF, $42, $FF, $3C, $FF, $00 ; id 16 'G'
Data_01F_4120:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $82, $FF, $82, $FF, $FE, $FF, $82, $FF, $82, $FF, $82, $FF, $00 ; id 17 'H'
Data_01F_4130:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $7C, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $7C, $FF, $00 ; id 18 'I'
    db $FF, $7E, $FF, $08, $FF, $08, $FF, $08, $FF, $88, $FF, $88, $FF, $70, $FF, $00 ; id 19 'J'
    db $FF, $84, $FF, $88, $FF, $90, $FF, $B0, $FF, $C8, $FF, $84, $FF, $82, $FF, $00 ; id 20 'K'
Data_01F_4160:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $FE, $FF, $00 ; id 21 'L'
Data_01F_4170:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $C6, $FF, $AA, $FF, $92, $FF, $82, $FF, $82, $FF, $82, $FF, $00 ; id 22 'M'
Data_01F_4180:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $C2, $FF, $A2, $FF, $92, $FF, $8A, $FF, $86, $FF, $82, $FF, $00 ; id 23 'N'
Data_01F_4190:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $38, $FF, $44, $FF, $82, $FF, $82, $FF, $82, $FF, $44, $FF, $38, $FF, $00 ; id 24 'O'
Data_01F_41A0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $80, $FF, $80, $FF, $80, $FF, $00 ; id 25 'P'
    db $FF, $38, $FF, $44, $FF, $82, $FF, $82, $FF, $8A, $FF, $44, $FF, $3A, $FF, $00 ; id 26 'Q'
    db $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $88, $FF, $84, $FF, $82, $FF, $00 ; id 27 'R'
Data_01F_41D0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $78, $FF, $84, $FF, $80, $FF, $7C, $FF, $02, $FF, $82, $FF, $7C, $FF, $00 ; id 28 'S'
    db $FF, $FE, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00 ; id 29 'T'
    db $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $7C, $FF, $00 ; id 30 'U'
    db $FF, $82, $FF, $82, $FF, $44, $FF, $44, $FF, $28, $FF, $28, $FF, $10, $FF, $00 ; id 31 'V'
Data_01F_4210:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $92, $FF, $AA, $FF, $AA, $FF, $C6, $FF, $C6, $FF, $82, $FF, $00 ; id 32 'W'
    db $FF, $C6, $FF, $44, $FF, $28, $FF, $10, $FF, $28, $FF, $44, $FF, $C6, $FF, $00 ; id 33 'X'
Data_01F_4230:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $44, $FF, $28, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00 ; id 34 'Y'
    db $FF, $FE, $FF, $04, $FF, $08, $FF, $10, $FF, $20, $FF, $40, $FF, $FE, $FF, $00 ; id 35 'Z'
Data_01F_4250:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $04, $FF, $7C, $FF, $84, $FF, $7E, $FF, $00 ; id 36 'a'
Data_01F_4260:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $80, $FF, $80, $FF, $80, $FF, $F8, $FF, $84, $FF, $84, $FF, $F8, $FF, $00 ; id 37 'b'
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $80, $FF, $84, $FF, $78, $FF, $00 ; id 38 'c'
Data_01F_4280:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $04, $FF, $04, $FF, $04, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $00 ; id 39 'd'
Data_01F_4290:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $FC, $FF, $80, $FF, $7C, $FF, $00 ; id 40 'e'
    db $FF, $18, $FF, $24, $FF, $20, $FF, $FC, $FF, $20, $FF, $20, $FF, $20, $FF, $00 ; id 41 'f'
    db $FF, $00, $FF, $00, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $F8 ; id 42 'g'
    db $FF, $80, $FF, $80, $FF, $80, $FF, $F8, $FF, $84, $FF, $84, $FF, $84, $FF, $00 ; id 43 'h'
Data_01F_42D0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $00, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00 ; id 44 'i'
    db $FF, $00, $FF, $10, $FF, $00, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $60 ; id 45 'j'
    db $FF, $80, $FF, $80, $FF, $8C, $FF, $B0, $FF, $C0, $FF, $B0, $FF, $8C, $FF, $00 ; id 46 'k'
Data_01F_4300:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00 ; id 47 'l'
Data_01F_4310:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $EC, $FF, $92, $FF, $92, $FF, $92, $FF, $92, $FF, $00 ; id 48 'm'
Data_01F_4320:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $F8, $FF, $84, $FF, $84, $FF, $84, $FF, $84, $FF, $00 ; id 49 'n'
Data_01F_4330:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00 ; id 50 'o'
Data_01F_4340:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $F8, $FF, $84, $FF, $84, $FF, $F8, $FF, $80, $FF, $80 ; id 51 'p'
    db $FF, $00, $FF, $00, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $04 ; id 52 'q'
    db $FF, $00, $FF, $00, $FF, $9C, $FF, $A0, $FF, $C0, $FF, $80, $FF, $80, $FF, $00 ; id 53 'r'
Data_01F_4370:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $80, $FF, $78, $FF, $04, $FF, $F8, $FF, $00 ; id 54 's'
    db $FF, $00, $FF, $20, $FF, $FC, $FF, $20, $FF, $20, $FF, $20, $FF, $1C, $FF, $00 ; id 55 't'
    db $FF, $00, $FF, $00, $FF, $84, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00 ; id 56 'u'
    db $FF, $00, $FF, $00, $FF, $84, $FF, $84, $FF, $84, $FF, $48, $FF, $30, $FF, $00 ; id 57 'v'
    db $FF, $00, $FF, $00, $FF, $82, $FF, $92, $FF, $92, $FF, $AA, $FF, $44, $FF, $00 ; id 58 'w'
Data_01F_43C0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $84, $FF, $48, $FF, $30, $FF, $48, $FF, $84, $FF, $00 ; id 59 'x'
    db $FF, $00, $FF, $00, $FF, $84, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $F8 ; id 60 'y'
    db $FF, $00, $FF, $00, $FF, $FC, $FF, $08, $FF, $30, $FF, $40, $FF, $FC, $FF, $00 ; id 61 'z'
    db $FF, $80, $FF, $80, $FF, $3C, $FF, $40, $FF, $3C, $FF, $02, $FF, $7C, $FF, $00 ; id 62 ''s'
    db $FF, $80, $FF, $80, $FF, $76, $FF, $49, $FF, $49, $FF, $49, $FF, $49, $FF, $00 ; id 63 ''m'
    db $FF, $80, $FF, $80, $FF, $0E, $FF, $50, $FF, $60, $FF, $40, $FF, $40, $FF, $00 ; id 64 ''r'
    db $FF, $80, $FF, $90, $FF, $7E, $FF, $10, $FF, $10, $FF, $10, $FF, $0E, $FF, $00 ; id 65 ''t'
    db $FF, $80, $FF, $80, $FF, $00, $FF, $42, $FF, $42, $FF, $24, $FF, $18, $FF, $00 ; id 66
    db $FF, $88, $FF, $88, $FF, $08, $FF, $08, $FF, $08, $FF, $08, $FF, $08, $FF, $00 ; id 67 ''l'
Data_01F_4450:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $82, $FF, $02, $FF, $3E, $FF, $42, $FF, $42, $FF, $3E, $FF, $00 ; id 68
    db $FF, $00, $FF, $20, $FF, $A8, $FF, $72, $FF, $70, $FF, $A8, $FF, $22, $FF, $00 ; id 69
    db $FF, $70, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $70, $FF, $00 ; id 70
Data_01F_4480:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $F8, $FF, $50, $FF, $50, $FF, $50, $FF, $50, $FF, $50, $FF, $F8, $FF, $00 ; id 71
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 72
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 73
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 74
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 75
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 76
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 77
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 78
Data_01F_4500:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 79
Data_01F_4510:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $EE, $FF, $92, $FF, $92, $FF, $92, $FF, $92, $FF, $D6, $FF, $FE ; id 80
    db $FF, $0E, $FF, $1B, $FF, $11, $FF, $1B, $FF, $3E, $FF, $70, $FF, $E0, $FF, $C0 ; id 81
    db $FF, $0C, $FF, $1E, $FF, $65, $FF, $B9, $FF, $C9, $FF, $7F, $FF, $4A, $FF, $4E ; id 82
    db $FF, $03, $FF, $05, $FF, $CA, $FF, $74, $FF, $28, $FF, $78, $FF, $EC, $FF, $C4 ; id 83
    db $FF, $00, $FF, $FF, $FF, $4E, $FF, $2C, $FF, $18, $FF, $3C, $FF, $6E, $FF, $FF ; id 84
    db $FF, $18, $FF, $24, $FF, $7E, $FF, $C3, $FF, $81, $FF, $81, $FF, $42, $FF, $3C ; id 85
    db $FF, $06, $FF, $0A, $FF, $12, $FF, $12, $FF, $62, $FF, $BF, $FF, $81, $FF, $7E ; id 86
    db $FF, $3C, $FF, $7E, $FF, $FF, $FF, $FF, $FF, $81, $FF, $A5, $FF, $85, $FF, $FF ; id 87
    db $FF, $1C, $FF, $10, $FF, $D6, $FF, $BA, $FF, $82, $FF, $BA, $FF, $AA, $FF, $EE ; id 88
    db $FF, $38, $FF, $6C, $FF, $C6, $FF, $EE, $FF, $82, $FF, $FE, $FF, $AA, $FF, $EE ; id 89
    db $FF, $3C, $FF, $42, $FF, $99, $FF, $BD, $FF, $BD, $FF, $A5, $FF, $BD, $FF, $C3 ; id 90
    db $FF, $0E, $FF, $11, $FF, $15, $FF, $19, $FF, $2E, $FF, $58, $FF, $A0, $FF, $E0 ; id 91
    db $FF, $3C, $FF, $7E, $FF, $B9, $FF, $99, $FF, $D1, $FF, $46, $FF, $3C, $FF, $00 ; id 92
    db $FF, $36, $FF, $2A, $FF, $22, $FF, $2A, $FF, $22, $FF, $2A, $FF, $5D, $FF, $55 ; id 93
    db $FF, $7F, $FF, $41, $FF, $7F, $FF, $49, $FF, $7F, $FF, $49, $FF, $2A, $FF, $1C ; id 94
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 95
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 96
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 97
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 98
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 99
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 100
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 101
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 102
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 103
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 104
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 105
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 106
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 107
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 108
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 109
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 110
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 111
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 112
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 113
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 114
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 115
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 116
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 117
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 118
Data_01F_4780:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 119
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 120
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 121
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 122
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 123
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 124
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 125
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 126
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 127
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 128
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 129
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 130
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 131
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 132
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 133
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 134
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 135
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 136
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 137
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 138
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 139
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 140
Data_01F_48E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $05, $FF, $05, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 141
Data_01F_48F0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $02, $FF, $05, $FF, $02, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 142
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $30, $FF, $48, $FF, $48, $FF, $30 ; id 143
Data_01F_4910:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 144 ' '
    db $FF, $00, $EB, $08, $ED, $70, $FF, $82, $B7, $CA, $8B, $FE, $F7, $74, $FF, $00 ; id 145
    db $FF, $00, $FF, $24, $FF, $54, $FF, $58, $FF, $2A, $FF, $15, $FF, $15, $FF, $22 ; id 146
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $66, $FF, $66, $FF, $00 ; id 147
    db $FF, $00, $FF, $00, $FF, $00, $FF, $60, $FF, $00, $FF, $60, $FF, $20, $FF, $40 ; id 148
    db $FF, $60, $FF, $60, $FF, $20, $FF, $40, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 149
    db $FF, $00, $FF, $0E, $FF, $08, $FF, $08, $FF, $08, $FF, $08, $FF, $00, $FF, $00 ; id 150
    db $FF, $00, $FF, $00, $FF, $00, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $E0 ; id 151
Data_01F_4990:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $3C, $FF, $66, $FF, $66, $FF, $0C, $FF, $18, $FF, $00, $FF, $18 ; id 152 '?'
    db $FF, $00, $FF, $0C, $FF, $0C, $FF, $0C, $FF, $08, $FF, $08, $FF, $00, $FF, $18 ; id 153 '!'
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $40, $FF, $60, $FF, $60 ; id 154
    db $FF, $00, $FF, $00, $FF, $00, $FF, $18, $FF, $18, $FF, $00, $FF, $00, $FF, $00 ; id 155
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $FE, $FF, $00, $FF, $00, $FF, $00 ; id 156 '-'
    db $FF, $00, $FF, $00, $FF, $00, $FF, $60, $FF, $92, $FF, $0C, $FF, $00, $FF, $00 ; id 157
    db $FF, $00, $FF, $02, $FF, $04, $FF, $08, $FF, $10, $FF, $20, $FF, $40, $FF, $80 ; id 158
    db $FF, $00, $FF, $10, $FF, $92, $FF, $54, $FF, $38, $FF, $54, $FF, $92, $FF, $10 ; id 159
    db $FF, $00, $FF, $08, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $08 ; id 160
    db $FF, $00, $FF, $10, $FF, $08, $FF, $08, $FF, $08, $FF, $08, $FF, $08, $FF, $10 ; id 161
    db $FF, $00, $FF, $00, $FF, $10, $FF, $10, $FF, $7C, $FF, $10, $FF, $10, $FF, $00 ; id 162
Data_01F_4A40:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $18, $FF, $18, $FF, $00, $FF, $00, $FF, $18, $FF, $18, $FF, $00 ; id 163
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $92, $FF, $00 ; id 164
Data_01F_4A60:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $80, $FF, $80, $FF, $80, $FF, $8A, $FF, $8A, $FF, $84, $FF, $F4 ; id 165
Data_01F_4A70:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $E0, $FF, $80, $FF, $80, $FF, $EA, $FF, $84, $FF, $84, $FF, $EA ; id 166
Data_01F_4A80:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $1E, $FF, $06, $FF, $0A, $FF, $72, $FF, $90, $FF, $90, $FF, $60 ; id 167
Data_01F_4A90:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $38, $FF, $44, $FF, $44, $FF, $38, $FF, $10, $FF, $7C, $FF, $10 ; id 168
Data_01F_4AA0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $38, $FF, $7C, $FF, $FE, $FF, $38, $FF, $38, $FF, $38 ; id 169
    db $FF, $00, $FF, $6C, $FF, $6C, $FF, $24, $FF, $48, $FF, $00, $FF, $00, $FF, $00 ; id 170
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $60, $FF, $60, $FF, $20, $FF, $40 ; id 171 ','
Data_01F_4AD0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $10, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6 ; id 172
Data_01F_4AE0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $38, $FF, $38, $FF, $38, $FF, $FE, $FF, $7C, $FF, $38, $FF, $10, $FF, $00 ; id 173
    db $FF, $00, $FF, $10, $FF, $30, $FF, $7E, $FF, $FE, $FF, $7E, $FF, $30, $FF, $10 ; id 174
    db $FF, $00, $FF, $10, $FF, $18, $FF, $FC, $FF, $FE, $FF, $FC, $FF, $18, $FF, $10 ; id 175
    db $FF, $00, $FF, $7C, $FF, $78, $FF, $7C, $FF, $7E, $FF, $5C, $FF, $08, $FF, $00 ; id 176
    db $FF, $00, $FF, $3E, $FF, $1E, $FF, $3E, $FF, $7E, $FF, $3A, $FF, $10, $FF, $00 ; id 177
    db $FF, $00, $FF, $08, $FF, $5C, $FF, $7E, $FF, $7C, $FF, $78, $FF, $7C, $FF, $00 ; id 178
    db $FF, $00, $FF, $10, $FF, $3A, $FF, $7E, $FF, $3E, $FF, $1E, $FF, $3E, $FF, $00 ; id 179
    db $FF, $F0, $FF, $20, $FF, $40, $FF, $F0, $FF, $0F, $FF, $02, $FF, $04, $FF, $0F ; id 180
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $18, $FF, $18 ; id 181 '.'
    db $FF, $00, $FF, $20, $FF, $50, $FF, $50, $FF, $20, $FF, $54, $FF, $8C, $FF, $72 ; id 182
    db $FF, $00, $FF, $06, $FF, $06, $FF, $02, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 183
    db $FF, $00, $FF, $38, $FF, $44, $FF, $BA, $FF, $A2, $FF, $BA, $FF, $44, $FF, $38 ; id 184
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
    db $FF, $82, $FF, $C2, $FF, $A2, $FF, $92, $FF, $8A, $FF, $86, $FF, $82, $FF, $00 ; id 256
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00 ; id 257
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; id 258

; returns at once when wSGBActive is 0; otherwise sends the packet set chosen by wSGBPacketIndex ($FF = the buffer at wSGBPacketBuffer, else the pointer in the table at $5094): the packet count is the first byte's low 3 bits, each 16-byte packet is sent through rP1 as a $00/$30 reset pulse, 128 bits (a 1 bit is written as $10, a 0 bit as $20, each followed by $30) and a stop bit
; 25 call sites from 10 routines (e.g. BootAndMainLoop, DetectSGB, SGBTransferCompressed, SGBTransferRaw, ...)
; reads: wSGBActive, wSGBPacketIndex
; points at: wSGBPacketBuffer
SendSGBPacketSet::
Func_01F_5040:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, [wSGBPacketIndex]
    cp a, $FF
    jr nz, Jump_01F_5051
    ld hl, wSGBPacketBuffer
    jr Jump_01F_505E

Jump_01F_5051::
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

Jump_01F_505E::
    ld a, [hl]
    and a, $07
    ret z
    ld b, a
    ld c, $00

Jump_01F_5065::
    push bc
    ld a, $00
    ldh [c], a
    ld a, $30
    ldh [c], a
    ld b, $10

Jump_01F_506E::
    ld e, $08
    ld a, [hl+]
    ld d, a

Jump_01F_5072::
    bit 0, d
    ld a, $10
    jr nz, Jump_01F_507A
    ld a, $20

Jump_01F_507A::
    ldh [c], a
    ld a, $30
    ldh [c], a
    rr d
    dec e
    jr nz, Jump_01F_5072
    dec b
    jr nz, Jump_01F_506E
    ld a, $20
    ldh [c], a
    ld a, $30
    ldh [c], a
    pop bc
    dec b
    ret z
    call SpinDelay
    jr Jump_01F_5065

; E-0179 (C1: SendSGBPacketSet reads the word $5094 + 2 * wSGBPacketIndex ($FF selects wSGBPacketBuffer instead) and sends byte-0 & 7 packets of 16 bytes from there through the joypad register).
; record: first 16-byte SGB packet of this set
SGBPacketSetTable::
Data_01F_5094:: ; address name
    dw Data_01F_513E ; id 0
    dw Data_01F_514E ; id 1
    dw SGBPackets ; id 2
    dw Data_01F_50CE ; id 3
    dw Data_01F_50DE ; id 4
    dw Data_01F_50EE ; id 5
    dw Data_01F_50FE ; id 6
    dw Data_01F_510E ; id 7
    dw Data_01F_511E ; id 8
    dw Data_01F_512E ; id 9
    dw Data_01F_515E ; id 10
    dw Data_01F_516E ; id 11
    dw Data_01F_517E ; id 12
    dw Data_01F_518E ; id 13
    dw Data_01F_519E ; id 14
    dw Data_01F_51AE ; id 15
    dw Data_01F_51BE ; id 16
    dw Data_01F_51CE ; id 17
    dw Data_01F_51DE ; id 18
    dw Data_01F_51EE ; id 19
    dw Data_01F_51FE ; id 20

; E-0179 (C1: the packets SGBPacketSetTable points at; each set is one packet here; 21 packets end at $520E).
; record: SGB packet (byte 0 = command * 8 + packet count)
SGBPackets::
Data_01F_50BE:: ; address name
    db $79, $5D, $08, $00, $0B, $8C, $D0, $F4, $60, $00, $00, $00, $00, $00, $00, $00 ; id 0
Data_01F_50CE:: ; heuristic: SGB packet; C0
    db $79, $52, $08, $00, $0B, $A9, $E7, $9F, $01, $C0, $7E, $E8, $E8, $E8, $E8, $E0 ; id 1
Data_01F_50DE:: ; heuristic: SGB packet; C0
    db $79, $47, $08, $00, $0B, $C4, $D0, $16, $A5, $CB, $C9, $05, $D0, $10, $A2, $28 ; id 2
Data_01F_50EE:: ; heuristic: SGB packet; C0
    db $79, $3C, $08, $00, $0B, $F0, $12, $A5, $C9, $C9, $C8, $D0, $1C, $A5, $CA, $C9 ; id 3
Data_01F_50FE:: ; heuristic: SGB packet; C0
    db $79, $31, $08, $00, $0B, $0C, $A5, $CA, $C9, $7E, $D0, $06, $A5, $CB, $C9, $7E ; id 4
Data_01F_510E:: ; heuristic: SGB packet; C0
    db $79, $26, $08, $00, $0B, $39, $CD, $48, $0C, $D0, $34, $A5, $C9, $C9, $80, $D0 ; id 5
Data_01F_511E:: ; heuristic: SGB packet; C0
    db $79, $1B, $08, $00, $0B, $EA, $EA, $EA, $EA, $EA, $A9, $01, $CD, $4F, $0C, $D0 ; id 6
Data_01F_512E:: ; heuristic: SGB packet; C0
    db $79, $10, $08, $00, $0B, $4C, $20, $08, $EA, $EA, $EA, $EA, $EA, $60, $EA, $EA ; id 7
Data_01F_513E:: ; heuristic: SGB packet; C0
    db $B9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 8
Data_01F_514E:: ; heuristic: SGB packet; C0
    db $B9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
Data_01F_515E:: ; heuristic: SGB packet; C0
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
Data_01F_516E:: ; heuristic: SGB packet; C0
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
Data_01F_517E:: ; heuristic: SGB packet; C0
    db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
Data_01F_518E:: ; heuristic: SGB packet; C0
    db $A9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
Data_01F_519E:: ; heuristic: SGB packet; C0
    db $51, $00, $00, $01, $00, $02, $00, $03, $00, $C0, $00, $00, $00, $00, $00, $00 ; id 14
Data_01F_51AE:: ; heuristic: SGB packet; C0
    db $A1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
Data_01F_51BE:: ; heuristic: SGB packet; C0
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
Data_01F_51CE:: ; heuristic: SGB packet; C0
    db $99, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17
Data_01F_51DE:: ; heuristic: SGB packet; C0
    db $C9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
Data_01F_51EE:: ; heuristic: SGB packet; C0
    db $71, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19
Data_01F_51FE:: ; heuristic: SGB packet; C0
    db $B9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 20

; ld de, this bank's string table / BeginStringDisplay
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_Case17)
BeginStringDisplay_Bank1F::
Func_01F_520E:: ; address name
    ld de, Data_01F_5223
    call BeginStringDisplay
    ret
    db $11, $23, $52, $CD, $FE, $25, $C9, $CD, $0E, $52, $CD, $11, $26, $C9

; address loaded by BeginStringDisplay_Bank1F
Data_01F_5223:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01F_5225

Data_01F_5225:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01F_52A5
    dw Data_01F_52A5
    dw Data_01F_52E3
    dw Data_01F_5303
    dw Data_01F_5327
    dw Data_01F_534B
    dw Data_01F_536D
    dw Data_01F_5394
    dw Data_01F_53B8
    dw Data_01F_53DA
    dw Data_01F_53F9
    dw Data_01F_5410
    dw Data_01F_5433
    dw Data_01F_5455
    dw Data_01F_5475
    dw Data_01F_5498
    dw Data_01F_54B5
    dw Data_01F_54D7
    dw Data_01F_54F7
    dw Data_01F_5519
    dw Data_01F_5540
    dw Data_01F_5540
    dw Data_01F_5561
    dw Data_01F_5582
    dw Data_01F_55A7
    dw Data_01F_55CA
    dw Data_01F_55ED
    dw Data_01F_5610
    dw Data_01F_5627
    dw Data_01F_5644
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5696
    dw Data_01F_56B6
    dw Data_01F_56DA
    dw Data_01F_56FD
    dw Data_01F_571F
    dw Data_01F_5740
    dw Data_01F_5764
    dw Data_01F_5786
    dw Data_01F_57A5
    dw Data_01F_57BC
    dw Data_01F_57DD
    dw Data_01F_57FF
    dw Data_01F_581F
    dw Data_01F_5842
    dw Data_01F_5864
    dw Data_01F_5886
    dw Data_01F_58A6
    dw Data_01F_58C8
    dw Data_01F_58EF
    dw Data_01F_58EF
    dw Data_01F_5910
    dw Data_01F_5931
    dw Data_01F_5956
    dw Data_01F_5979
    dw Data_01F_599C
    dw Data_01F_59BD
    dw Data_01F_59D4
    dw Data_01F_59F2
    dw Script_1F_5A3A
    dw Script_1F_5A3A

Data_01F_52A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Is your", $F1
    db "adventure done?", $FA, $F7
    db $EF, $EE, "Or do you need", $EF, $EE, "something?", $F7
    db $F0

Data_01F_52E3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one's", $F1
    db "staying here?", $F0

Data_01F_5303:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " So this one", $F1
    db "is staying here?", $F0

Data_01F_5327:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Check up on", $F1
    db "the others too.", $F7
    db $F0

Data_01F_534B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Do you need", $F1
    db "anything else?", $F0

Data_01F_536D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " No, you can't", $F1
    db "go off all alone.", $F7
    db $F0

Data_01F_5394:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Switch with", $F1
    db "one on the farm?", $F0

Data_01F_53B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_53DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " So you'll", $F1
    db "take this one?", $F0

Data_01F_53F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " I switched", $F1
    db $F9, "0.", $F7
    db $F0

Data_01F_5410:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " The farm has", $F1
    db "no more room.", $F7
    db $F0

Data_01F_5433:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_5455:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you take?", $F0

Data_01F_5475:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Is this the", $F1
    db "one you'll take?", $F0

Data_01F_5498:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " It's eager", $F1
    db "to go, ", $F9, "0.", $F7
    db $F0

Data_01F_54B5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " You haven't", $F1
    db "left any here.", $F7
    db $F0

Data_01F_54D7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " You can't", $F1
    db "take any more.", $F7
    db $F0

Data_01F_54F7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What do you", $F1
    db "want to check?", $F0

Data_01F_5519:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " We don't have", $F1
    db "any of your eggs.", $F7
    db $F0

Data_01F_5540:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you check?", $F0

Data_01F_5561:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which egg", $F1
    db "will you check?", $F0

Data_01F_5582:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What  do you", $F1
    db "want to release?", $F0

Data_01F_55A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you release?", $F0

Data_01F_55CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which egg", $F1
    db "will you release?", $F0

Data_01F_55ED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " It'll be gone", $F1
    db "forever. Sure?", $F0

Data_01F_5610:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The egg was", $F1
    db "released.", $F7
    db $F0

Data_01F_5627:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 was released", $F1
    db "in the wild.", $F0

Data_01F_5644:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Come back", $F1
    db "anytime, sis!", $F7
    db $F0

Data_01F_5664:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hi, big", $F1
    db "brother!", $FA, $F7
    db $EF, $EE, "Do you need", $EF, $EE, "anything?", $F0

Data_01F_5696:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one's", $F1
    db "staying here?", $F0

Data_01F_56B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " So this one", $F1
    db "is staying here?", $F0

Data_01F_56DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Say bye to", $F1
    db $F9, "0 for a while.", $F7
    db $F0

Data_01F_56FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Do you need", $F1
    db "anything else?", $F0

Data_01F_571F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You'll be", $F1
    db "left all alone!", $F7
    db $F0

Data_01F_5740:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Switch with", $F1
    db "one on the farm?", $F0

Data_01F_5764:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_5786:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " So you'll", $F1
    db "take this one?", $F0

Data_01F_57A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " I switched", $F1
    db $F9, "0.", $F7
    db $F0

Data_01F_57BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " The farm is", $F1
    db "out of room.", $F7
    db $F0

Data_01F_57DD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_57FF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you take?", $F0

Data_01F_581F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Is this the", $F1
    db "one you'll take?", $F0

Data_01F_5842:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0, it", $F1
    db "really missed you.", $F7
    db $F0

Data_01F_5864:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You haven't", $F1
    db "left any here.", $F7
    db $F0

Data_01F_5886:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You can't", $F1
    db "take any more.", $F7
    db $F0

Data_01F_58A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What do you", $F1
    db "want to check?", $F0

Data_01F_58C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " We don't have", $F1
    db "any of your eggs.", $F7
    db $F0

Data_01F_58EF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you check?", $F0

Data_01F_5910:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which egg", $F1
    db "will you check?", $F0

Data_01F_5931:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What  do you", $F1
    db "want to release?", $F0

Data_01F_5956:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you release?", $F0

Data_01F_5979:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which egg", $F1
    db "will you release?", $F0

Data_01F_599C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " It'll be gone", $F1
    db "forever. OK?", $F0

Data_01F_59BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The egg was", $F1
    db "released.", $F7
    db $F0

Data_01F_59D4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 was released", $F1
    db "in the wild.", $F7
    db $F0

Data_01F_59F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Please tell", $F1
    db "me about your", $FA, $F7
    db $EF, $EE, "adventure next", $EF, $EE, "time, big brother!", $F7
    db $F0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_5A3A:: ; heuristic: event script entry or jump target; C0
Data_01F_5A3A:: ; address name
    script_command $E8
Script_1F_5A3B:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5A51, Script_1F_5A4E, Script_1F_5A4B, Script_1F_5A48, Script_1F_5A42
Script_1F_5A42:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_op $EA, $1D, $80 ; '0 checked the pump. It's rusted'
    script_command $E9
    script_end
Script_1F_5A48:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B96
Script_1F_5A4B:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B61
Script_1F_5A4E:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5AC5
Script_1F_5A51:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5A55, Script_1F_5A58
Script_1F_5A55:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5A80
Script_1F_5A58:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $02, $C0 ; 'Cobi 0! Papa's calling. He's at'
Script_1F_5A5B:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5A66, Script_1F_5A5F
Script_1F_5A5F:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_command $E8
    script_jump Script_1F_5A3B
Script_1F_5A66:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $03, $C0 ; 'Tara There you are, big brother!'
Script_1F_5A69:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5A7C, Script_1F_5A75, Script_1F_5A6E
Script_1F_5A6E:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $02, $C0 ; 'Cobi 0! Papa's calling. He's at'
    script_command $E8
    script_jump Script_1F_5A5B
Script_1F_5A75:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $04, $C0 ; 'Cobi What's wrong, 0? Papa's calling'
    script_command $E8
    script_jump Script_1F_5A5F
Script_1F_5A7C:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5A69
Script_1F_5A80:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $06, $C0 ; 'You folks run a monster farm?'
    script_command $E8
    script_choice_jump Script_1F_5A87, Script_1F_5A8D
Script_1F_5A87:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5A8D:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $07, $C0 ; 'There's a spirit in GreatLog that's'
Script_1F_5A90:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5A9A, Script_1F_5A94
Script_1F_5A94:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5A9A:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $08, $C0 ; 'Sailing is sure exhilarating. Right?'
Script_1F_5A9D:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5AA7, Script_1F_5AA1
Script_1F_5AA1:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $07, $C0 ; 'There's a spirit in GreatLog that's'
    script_jump Script_1F_5A90
Script_1F_5AA7:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $09, $C0 ; 'Good. That's good to hear! You'
Script_1F_5AAA:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5AC1, Script_1F_5AB6, Script_1F_5AAF
Script_1F_5AAF:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $08, $C0 ; 'Sailing is sure exhilarating. Right?'
    script_command $E8
    script_jump Script_1F_5A9D
Script_1F_5AB6:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $0A, $C0 ; 'Is that so? Too bad! You'll'
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5AC1:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5AAA
Script_1F_5AC5:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5ACA, Script_1F_5AD3, Script_1F_5AD6
Script_1F_5ACA:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $10, $C0 ; '0 peered into the barrel. It'
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5AD3:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B01
Script_1F_5AD6:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0D, $C0 ; 'GreatLog's King asked us to settle'
Script_1F_5AD9:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5AE3, Script_1F_5ADD
Script_1F_5ADD:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5AE3:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0E, $C0 ; 'When our farm gets established in'
Script_1F_5AE6:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5AFD, Script_1F_5AF2, Script_1F_5AEB
Script_1F_5AEB:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0D, $C0 ; 'GreatLog's King asked us to settle'
    script_command $E8
    script_jump Script_1F_5AD9
Script_1F_5AF2:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $0F, $C0 ; 'Worried about your monsters? Don't be!'
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5AFD:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5AE6
Script_1F_5B01:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $11, $C0 ; '0 peered into the vase. Freshly'
    script_op $EA, $07, $C0 ; 'There's a spirit in GreatLog that's'
Script_1F_5B07:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5B11, Script_1F_5B0B
Script_1F_5B0B:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5B11:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0C, $C0 ; 'GreatLog's King asked us to settle'
Script_1F_5B14:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5B1F, Script_1F_5B18
Script_1F_5B18:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $07, $C0 ; 'There's a spirit in GreatLog that's'
    script_jump Script_1F_5B07
Script_1F_5B1F:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $03, $C0 ; 'Tara There you are, big brother!'
Script_1F_5B22:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5B35, Script_1F_5B2E, Script_1F_5B27
Script_1F_5B27:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0C, $C0 ; 'GreatLog's King asked us to settle'
    script_command $E8
    script_jump Script_1F_5B14
Script_1F_5B2E:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $08, $C0 ; 'Sailing is sure exhilarating. Right?'
    script_jump Script_1F_5B39
Script_1F_5B35:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5B22
Script_1F_5B39:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5B43, Script_1F_5B3D
Script_1F_5B3D:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0C, $C0 ; 'GreatLog's King asked us to settle'
    script_jump Script_1F_5B14
Script_1F_5B43:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $0E, $C0 ; 'When our farm gets established in'
Script_1F_5B46:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5B5D, Script_1F_5B52, Script_1F_5B4B
Script_1F_5B4B:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $08, $C0 ; 'Sailing is sure exhilarating. Right?'
    script_command $E8
    script_jump Script_1F_5B39
Script_1F_5B52:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $0A, $C0 ; 'Is that so? Too bad! You'll'
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5B5D:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5B46
Script_1F_5B61:: ; heuristic: event script entry or jump target; C0
    script_command $E8
Script_1F_5B62:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $12, $C0 ; 'Cobi 0! They said GreatLog will'
    script_command $E8
    script_choice_jump Script_1F_5B6B, Script_1F_5B6E, Script_1F_5B71, Script_1F_5B7E
Script_1F_5B6B:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B81
Script_1F_5B6E:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B8F
Script_1F_5B71:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $13, $C0 ; 'Land ho! There's GreatLog!'
    script_jump Script_1F_5B62
Script_1F_5B77:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5B7E:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B77
Script_1F_5B81:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $15, $C0 ; 'This is a tale of children'
Script_1F_5B84:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5B8B, Script_1F_5B88
Script_1F_5B88:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B62
Script_1F_5B8B:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5B84
Script_1F_5B8F:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $16, $C0 ; 'Listen you two! Quit your horsing'
    script_command $E8
    script_jump Script_1F_5B62
Script_1F_5B96:: ; heuristic: event script entry or jump target; C0
    script_command $E8
Script_1F_5B97:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $17, $C0 ; 'It seems to me that the'
    script_command $E8
    script_choice_jump Script_1F_5BA7, Script_1F_5BAA, Script_1F_5BAD, Script_1F_5BBA, Script_1F_5BA1
Script_1F_5BA1:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $06, $C0 ; 'You folks run a monster farm?'
    script_jump Script_1F_5B97
Script_1F_5BA7:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5BBD
Script_1F_5BAA:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5BE9
Script_1F_5BAD:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $13, $C0 ; 'Land ho! There's GreatLog!'
    script_jump Script_1F_5B97
Script_1F_5BB3:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5BBA:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5BB3
Script_1F_5BBD:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $18, $C0 ; 'Yo, did you enjoy the voyage?'
Script_1F_5BC0:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5BC7, Script_1F_5BC4
Script_1F_5BC4:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B97
Script_1F_5BC7:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $1A, $C0 ; 'There aren't many friends here. It's'
Script_1F_5BCA:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5BE5, Script_1F_5BDA, Script_1F_5BD3, Script_1F_5BD0
Script_1F_5BD0:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $06, $C0 ; 'You folks run a monster farm?'
Script_1F_5BD3:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $18, $C0 ; 'Yo, did you enjoy the voyage?'
    script_command $E8
    script_jump Script_1F_5BC0
Script_1F_5BDA:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $1C, $C0 ; 'This hay is pretty good. Maybe'
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5BE5:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5BCA
Script_1F_5BE9:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $19, $C0 ; 'Slash If you're in need of'
Script_1F_5BEC:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5BF3, Script_1F_5BF0
Script_1F_5BF0:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_5B97
Script_1F_5BF3:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $1A, $C0 ; 'There aren't many friends here. It's'
Script_1F_5BF6:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_choice_jump Script_1F_5C11, Script_1F_5C06, Script_1F_5BFF, Script_1F_5BFC
Script_1F_5BFC:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $06, $C0 ; 'You folks run a monster farm?'
Script_1F_5BFF:: ; heuristic: event script entry or jump target; C0
    script_op $EA, $19, $C0 ; 'Slash If you're in need of'
    script_command $E8
    script_jump Script_1F_5BEC
Script_1F_5C06:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_op $EA, $1B, $C0 ; 'I accidentally went outside. People gave'
    script_command $E8
    script_op $EA, $05, $C0 ; 'Tara Hurry! Papa will be angry!'
    script_jump Script_1F_5A3B
Script_1F_5C11:: ; heuristic: event script entry or jump target; C0
    script_command $E8
    script_jump Script_1F_5BF6

; for the visible entries of record-list page wD7AF draws each record name at Data_01F_5C9C[n] (the fifth through the mark-overlay drawer) (E-0128)
; 8 call sites from 8 routines (e.g. ScriptCommandEB_Run_Case05_Case20, ScriptCommandED_Run_Case04_Case03, ScriptCommandED_Run_Case07_Case0E, ScriptCommandED_Run_Case12_Case06, ...)
; reads: wListPageIndex, wListLastRow, wListCount, wScreenStep, wListPages
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenStep
; points at: wListEntries
DrawRecordListPageNames::
Func_01F_5C15:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    ld b, a
    add a, a
    add a, a
    add a, b
    add_a_to_hl
    ld c, $00

Jump_01F_5C2F::
    ld a, [wListLastRow]
    cp a, $04
    jr c, Jump_01F_5C3B
    ld a, [wListCount]
    jr Jump_01F_5C4A

Jump_01F_5C3B::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_01F_5C47
    ld a, [wListCount]
    jr Jump_01F_5C4A

Jump_01F_5C47::
    ld a, [wListCount]

Jump_01F_5C4A::
    ld b, a
    ld a, [wListPageIndex]
    push bc
    ld c, a
    add a, a
    add a, a
    add a, c
    pop bc
    add a, c
    cp a, b
    jr nc, Jump_01F_5C90
    push hl
    push bc
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, Jump_01F_5C71
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F
    jr Jump_01F_5C81

Jump_01F_5C71::
    ld a, c
    add a, a
    ld hl, Data_01F_5C9C
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM

Jump_01F_5C81::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_01F_5C90
    ld a, c
    cp a, $05
    jr c, Jump_01F_5C2F

Jump_01F_5C90::
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by DrawRecordListPageNames
Data_01F_5C9C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; draws the $F0-terminated text at wC8CF glyph by glyph; marks $8D and $8E are ORed onto the previous tile (E-0125)
; 1 call site from 1 routine (e.g. DrawRecordListPageNames)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F::
Func_01F_5CA6:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

Jump_01F_5CB0::
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01F_5CEF
    cp a, $8D
    jr z, Jump_01F_5CCF
    cp a, $8E
    jr z, Jump_01F_5CCF
    call GlyphCopyArgsForA
    call CopyFromBankWaitVRAM
    jr Jump_01F_5CDE

Jump_01F_5CCF::
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    call GlyphCopyArgsForA
    call OrFromBankWaitVRAM

Jump_01F_5CDE::
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr Jump_01F_5CB0

Jump_01F_5CEF::
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DE = Data_01F_4010 + 16 * A (the glyph's tile), HL = the VRAM address from Data_01F_5D20 + 2 * wD785, B = $1F (bank), C = 16 (bytes) (E-0120)
; 2 call sites from 1 routine (e.g. DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F)
; reads: wGlyphListStart
GlyphCopyArgsForA::
Func_01F_5CF8:: ; address name
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, GlyphFont
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, Data_01F_5D20
    ld a, [wGlyphListStart]
    sla a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

; address loaded by GlyphCopyArgsForA
Data_01F_5D20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; parameters wD7F1/wD7F2 = source (high, low), wD7F3 = width, wD7F4 = rows, wD7F5/wD7F6 = BG map destination (high, low): copies each row of tiles to the BG map with interrupts off after rSTAT bit 1 clears, wrapping columns inside the 32-entry row; on CGB, when wD7F7 is 0, also zero-fills the same entries in VRAM bank 1 (attributes); the row loop is not read to its end (E-0093)
; 25 call sites from 18 routines (e.g. DrawWCA36MonsterPictureInTwoSteps, DrawRects662BAnd653F, DrawRects6B4FAnd6C27, ClearTilesAndDrawRects6C5FAnd6D37, ...)
; reads: wArg6, rSTAT, wIsCGB, wArg7
; writes: rVBK
; points at: wArg1
DrawTileRectFromArg1Params::
Func_01F_5D2A:: ; address name
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

Jump_01F_5D3B::
    push hl
    push bc

Jump_01F_5D3D::
    di

Jump_01F_5D3E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5D3E
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5D54
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5D54::
    inc de
    dec b
    jr nz, Jump_01F_5D3D
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_5D89
    ld a, [wArg7]
    and a, a
    jr nz, Jump_01F_5D89
    ld a, $01
    ldh [rVBK], a

Jump_01F_5D6C::
    di

Jump_01F_5D6D::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5D6D
    xor a, a
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5D83
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5D83::
    dec b
    jr nz, Jump_01F_5D6C
    xor a, a
    ldh [rVBK], a

Jump_01F_5D89::
    pop bc
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec c
    jr nz, Jump_01F_5D3B
    ret

; fills a wArg3 x wArg4 rectangle of the BG map at wArg5/6 (wrapping inside the 32-entry row) with the one tile byte at wArg1/2: unlike DrawTileRectFromArg1Params it never advances DE; on CGB, unless wArg7 is set, clears the same entries' attributes; every caller passes BGFillTile (E-0186, correcting E-0129)
; 10 call sites from 10 routines (e.g. ClearBGMapAndLoadFrameTiles, ScriptCommandF6_Run_Shared06, RunNameEntryStateWhenNotFading_Case00_Case00, RunNameEntryStateWhenNotFading_Case06_Case00, ...)
; reads: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6, rSTAT, wIsCGB, ...
; writes: rVBK
FillTileRectWithArg1Tile::
Func_01F_5D9A:: ; address name
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

Jump_01F_5DB2::
    push hl
    push bc

Jump_01F_5DB4::
    di

Jump_01F_5DB5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5DB5
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5DCB
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5DCB::
    dec b
    jr nz, Jump_01F_5DB4
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_5DFF
    ld a, [wArg7]
    and a, a
    jr nz, Jump_01F_5DFF
    ld a, $01
    ldh [rVBK], a

Jump_01F_5DE2::
    di

Jump_01F_5DE3::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5DE3
    xor a, a
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5DF9
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5DF9::
    dec b
    jr nz, Jump_01F_5DE2
    xor a, a
    ldh [rVBK], a

Jump_01F_5DFF::
    pop bc
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec c
    ld a, c
    and a, a
    jr nz, Jump_01F_5DB2
    ret

; one byte, tile $C3: the tile FillTileRectWithArg1Tile repeats over the whole rectangle; all ten callers pass this address (E-0186)
; address loaded by ScriptCommandF6_Run_Shared06, RunNameEntryStateWhenNotFading_Case00_Case00, RunNameEntryStateWhenNotFading_Case06_Case00, ScriptCommandED_Run_Case0B_Case00 and 6 more
BGFillTile:: ; heuristic: wArg1/wArg2 source of a far call to FillTileRectWithArg1Tile; C0
Data_01F_5E12:: ; address name
    db $C3

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 3 tiles, one row per line
TileRect_1F_5E13::
Data_01F_5E13:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_1F_5E37::
Data_01F_5E37:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7, $B6, $C3, $02, $03, $04, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $C3, $05, $06, $07, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $02, $BF, $09, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0A, $0B, $03, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 9
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0C, $09, $05, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 11
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 12
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 13
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 14
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 16
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0187 (C1: the same box layout as TileRect_1F_5E37, which ScriptCommandE8_Run_Case08_Case03 draws as 20 x 18; the four screens are contiguous, 360 bytes each; no reader of this one was found).
; record: 20 x 18 tiles, one row per line
TileScreen_1F_5F9F::
Data_01F_5F9F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; entry 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $15, $1F, $1B, $1C, $1D, $ED, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0187 (C1: the same box layout as TileRect_1F_5E37, which ScriptCommandE8_Run_Case08_Case03 draws as 20 x 18; the four screens are contiguous, 360 bytes each; no reader of this one was found).
; record: 20 x 18 tiles, one row per line
TileScreen_1F_6107::
Data_01F_6107:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; entry 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7, $B6, $C3, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $C3, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $B7
    db $B6, $15, $1F, $1B, $1C, $1D, $ED, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $B7
    db $B6, $68, $69, $6A, $6B, $6C, $6D, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $B7
    db $B6, $6E, $6F, $70, $71, $72, $73, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0187 (C1: the same box layout as TileRect_1F_5E37, which ScriptCommandE8_Run_Case08_Case03 draws as 20 x 18; the four screens are contiguous, 360 bytes each; no reader of this one was found).
; record: 20 x 18 tiles, one row per line
TileScreen_1F_626F::
Data_01F_626F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; entry 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $13, $14, $15, $0E, $ED, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $0D, $0D, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $0D, $14, $10, $0E, $ED, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $0D, $0D, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 18 tiles, one row per line
TileRect_1F_63D7::
Data_01F_63D7:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $13, $14, $15, $0E, $ED, $20, $21, $22, $23, $24, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $6C, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $0D, $0D, $ED, $2F, $30, $31, $32, $33, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 9
    db $B6, $0D, $14, $10, $0E, $ED, $34, $35, $36, $37, $38, $B7 ; id 10
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $6D, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $B6, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $B7 ; id 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $B6, $0D, $0D, $ED, $43, $44, $45, $46, $47, $C3, $C3, $B7 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 6 tiles, one row per line
TileRect_1F_64AF::
Data_01F_64AF:: ; address name
    db $20, $21, $22, $23, $24, $25 ; id 0
    db $26, $27, $28, $29, $2A, $2B ; id 1
    db $2C, $2D, $2E, $2F, $30, $31 ; id 2
    db $32, $33, $34, $35, $36, $37 ; id 3
    db $38, $39, $3A, $3B, $3C, $3D ; id 4
    db $3E, $3F, $40, $41, $42, $43 ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 6 tiles, one row per line
TileRect_1F_64D3::
Data_01F_64D3:: ; address name
    db $02, $03, $04, $05, $06, $07 ; id 0
    db $08, $09, $0A, $0B, $0C, $0D ; id 1
    db $0E, $0F, $10, $11, $12, $13 ; id 2
    db $14, $15, $16, $17, $18, $19 ; id 3
    db $1A, $1B, $1C, $1D, $1E, $1F ; id 4
    db $20, $21, $22, $23, $24, $25 ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 6 tiles, one row per line
TileRect_1F_64F7::
Data_01F_64F7:: ; address name
    db $48, $49, $4A, $4B, $4C, $4D ; id 0
    db $4E, $4F, $50, $51, $52, $53 ; id 1
    db $54, $55, $56, $57, $58, $59 ; id 2
    db $5A, $5B, $5C, $5D, $5E, $5F ; id 3
    db $60, $61, $62, $63, $64, $65 ; id 4
    db $66, $67, $68, $69, $6A, $6B ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 6 tiles, one row per line
TileRect_1F_651B::
Data_01F_651B:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1F_653F::
Data_01F_653F:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 15 tiles, one row per line
TileRect_1F_6577::
Data_01F_6577:: ; address name
    db $B6, $20, $21, $22, $23, $24, $25, $26, $27, $28, $C3, $B7 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $0D, $0D, $ED, $29, $2A, $2B, $2C, $2D, $C3, $C3, $B7 ; id 6
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 7
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 8
    db $B6, $FF, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 10
    db $B6, $0B, $0E, $0F, $10, $C3, $09, $0E, $11, $0E, $12, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $FF, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 14

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 15 tiles, one row per line
TileRect_1F_662B::
Data_01F_662B:: ; address name
    db $B6, $C3, $02, $03, $04, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $05, $06, $07, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $02, $BF, $09, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $0A, $0B, $03, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $0C, $09, $05, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 8
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 9
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 10
    db $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 13
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 14

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1F_66DF::
Data_01F_66DF:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 1
    db $B6, $32, $33, $34, $35, $36, $37, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $38, $39, $3A, $3B, $3C, $3D, $B7 ; id 4
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_1F_6717::
Data_01F_6717:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7, $B6, $C3, $02, $03, $04, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $C3, $05, $06, $07, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7, $B6, $C3, $02, $BF, $09, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $A4, $A5, $A6, $CE, $CF, $B7, $B6, $C3, $0A, $0B, $03, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0C, $09, $05, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 11
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 12
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 13
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 14
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 16
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_1F_687F::
Data_01F_687F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $02, $03, $04, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $05, $06, $07, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $02, $BF, $09, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0A, $0B, $03, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 9
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0C, $09, $05, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 11
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 12
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 13
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 14
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 16
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_1F_69E7::
Data_01F_69E7:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7, $B6, $C3, $02, $03, $04, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $C3, $05, $06, $07, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7, $B6, $C3, $02, $BF, $09, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0A, $0B, $03, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 9
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $0C, $09, $05, $C3, $C3, $ED, $C3, $C3, $C3, $B7 ; id 11
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 12
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 13
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 14
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 16
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 18 tiles, one row per line
TileRect_1F_6B4F::
Data_01F_6B4F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1F_6C27::
Data_01F_6C27:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 18 tiles, one row per line
TileRect_1F_6C5F::
Data_01F_6C5F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $C3, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $B7 ; id 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $C3, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $B7 ; id 15
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1F_6D37::
Data_01F_6D37:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 18 tiles, one row per line
TileRect_1F_6D6F::
Data_01F_6D6F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $13, $14, $15, $0E, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $0D, $0D, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 9
    db $B6, $0D, $14, $10, $0E, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $B6, $0D, $0D, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1F_6E47::
Data_01F_6E47:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $7C, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $6E, $7E, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $6F, $7E, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $7D, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_1F_6E7F::
Data_01F_6E7F:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $13, $14, $15, $0E, $ED, $20, $21, $22, $23, $24, $B7 ; id 1
    db $C3, $48, $49, $4A, $4B, $4C, $4D, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $C3, $4E, $4F, $50, $51, $52, $53, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $C3, $54, $55, $56, $57, $58, $59, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $C3, $5A, $5B, $5C, $5D, $5E, $5F, $C3, $B6, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $B7 ; id 5
    db $C3, $60, $61, $62, $63, $64, $65, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $C3, $66, $67, $68, $69, $6A, $6B, $C3, $B6, $0D, $0D, $ED, $2F, $30, $31, $32, $33, $C3, $C3, $B7 ; id 7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 9
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $0D, $14, $10, $0E, $ED, $34, $35, $36, $37, $38, $B7 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $C3, $C3, $C3, $C3, $7C, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $C3, $C3, $C3, $6E, $7E, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $C3, $C3, $C3, $6F, $7E, $C3, $C3, $C3, $B6, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $B7 ; id 14
    db $C3, $C3, $C3, $C3, $7D, $C3, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $0D, $0D, $ED, $43, $44, $45, $46, $47, $C3, $C3, $B7 ; id 16
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_1F_6FE7::
Data_01F_6FE7:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $00, $00, $C3, $C3, $B6, $C3, $50, $51, $52, $53, $54, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $00, $00, $C3, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $00, $00, $C3, $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $06, $35, $3B, $28, $39, $C3, $13, $24, $30, $28, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 6
    db $B6, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $C3, $0F, $10, $11, $12, $B7 ; id 7
Data_01F_7087:: ; heuristic: wArg1/wArg2 source of a far call to DrawTileRectFromArg1Params; C0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $C3, $20, $21, $22, $23, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $C3, $31, $32, $33, $34, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $C3, $42, $43, $44, $45, $B7 ; id 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $46, $47, $48, $49, $4A, $4B, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $06, $13, $05, $C3, $B7 ; id 15
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_1F_714F::
Data_01F_714F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $B7 ; id 1
Data_01F_7177:: ; heuristic: wArg1/wArg2 source of a far call to DrawTileRectFromArg1Params; C0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $6E, $6F, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 3 tiles, one row per line
TileRect_1F_71B3::
Data_01F_71B3:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1F_71EF::
Data_01F_71EF:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $13, $36, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0187 (C1: Jump_024_513A sets wArg1/wArg2 = $720D + (wScreenByteBD - 1) * $78, wArg3 = 20, wArg4 = 6, wArg7 = 1 and far-calls DrawTileRectFromArg1Params at the scroll origin + $E0; three panels fill $720D-$7375).
; record: one 20 x 6 tile panel (wScreenByteBD selects it)
TileRect_1F_720D::
Data_01F_720D:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $00, $01, $02, $03, $04, $05, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $06, $07, $08, $09, $0A, $0B, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $0C, $0D, $0E, $0F, $10, $11, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $12, $13, $14, $15, $16, $17, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $18, $19, $1A, $1B, $1C, $1D, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $1E, $1F, $20, $21, $22, $23, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $00, $01, $02, $03, $04, $05, $24, $25, $26, $27, $28, $29, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $06, $07, $08, $09, $0A, $0B, $2A, $2B, $2C, $2D, $2E, $2F, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $0C, $0D, $0E, $0F, $10, $11, $30, $31, $32, $33, $34, $35, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $12, $13, $14, $15, $16, $17, $36, $37, $38, $39, $3A, $3B, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $18, $19, $1A, $1B, $1C, $1D, $3C, $3D, $3E, $3F, $40, $41, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $1E, $1F, $20, $21, $22, $23, $42, $43, $44, $45, $46, $47, $C3, $C3, $C3, $C3
    db $C3, $00, $01, $02, $03, $04, $05, $24, $25, $26, $27, $28, $29, $48, $49, $4A, $4B, $4C, $4D, $C3 ; id 3
    db $C3, $06, $07, $08, $09, $0A, $0B, $2A, $2B, $2C, $2D, $2E, $2F, $4E, $4F, $50, $51, $52, $53, $C3
    db $C3, $0C, $0D, $0E, $0F, $10, $11, $30, $31, $32, $33, $34, $35, $54, $55, $56, $57, $58, $59, $C3
    db $C3, $12, $13, $14, $15, $16, $17, $36, $37, $38, $39, $3A, $3B, $5A, $5B, $5C, $5D, $5E, $5F, $C3
    db $C3, $18, $19, $1A, $1B, $1C, $1D, $3C, $3D, $3E, $3F, $40, $41, $60, $61, $62, $63, $64, $65, $C3
    db $C3, $1E, $1F, $20, $21, $22, $23, $42, $43, $44, $45, $46, $47, $66, $67, $68, $69, $6A, $6B, $C3

; copies 16 glyph tiles (Data_01F_73BC) from bank $1F to the VRAM addresses in Data_01F_73CC (E-0127)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case01, RunScreenStateWhenNotFading_F1_Case0D_Case01)
LoadSixteenGlyphTilesFromTable73BC::
Func_01F_7375:: ; address name
    ld c, $00

Jump_01F_7377::
    push bc
    ld a, c
    ld de, Data_01F_73BC
    add a, e
    ld e, a
    jr nc, Jump_01F_7381
    inc d

Jump_01F_7381::
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
    ld de, Data_01F_73CC
    add a, e
    ld e, a
    jr nc, Jump_01F_73A7
    inc d

Jump_01F_73A7::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_01F_7377
    ret

; address loaded by LoadSixteenGlyphTilesFromTable73BC
Data_01F_73BC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A3, $54, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $25

; address loaded by LoadSixteenGlyphTilesFromTable73BC
Data_01F_73CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; first call: draws the 6 x 6 frame Data_01F_651B and loads the picture of species wCA36 at vTiles2 + $200; second call: loads its CGB attributes and draws the picture (E-0128)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case05, RunScreenStateWhenNotFading_F1_Case0D_Case05)
; reads: wScreenSubStep, wRecordBufB, wIsCGB, wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenSubStep, ...
DrawWCA36MonsterPictureInTwoSteps::
Func_01F_73EC:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_01F_7436
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
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld a, [wRecordBufB + $B]
    ld e, a
    ld a, [wRecordBufB + $C]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01F_7436::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_745C
    ld a, [wRecordBufB + $B]
    ld e, a
    ld a, [wRecordBufB + $C]
    ld d, a
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

Jump_01F_745C::
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
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; fills the 32 x 32 BG map from the scroll origin with BGFillTile (tile $C3), then copies three tiles from bank $1F to vTiles1 + $7E0, + $7F0 and vTiles2 + $6F0 (E-0121; fill, not a tile map: E-0186)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case00, RunScreenStateWhenNotFading_F1_Case0D_Case00)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
ClearBGMapAndLoadFrameTiles::
Func_01F_7494:: ; address name
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
    xor a, a
    ld [wArg7], a
    call FillTileRectWithArg1Tile
    ld de, Data_01F_4250
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; draws the tile rectangles Data_01F_662B (12 x 15 at scroll + $68) and Data_01F_653F (8 x 7 at scroll + $160) (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case15, RunScreenStateWhenNotFading_F1_Case0D_Case15)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawRects662BAnd653F::
Func_01F_74E3:: ; address name
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
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
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
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; draws the tile rectangles Data_01F_6B4F (12 x 18 at scroll + 8) and Data_01F_6C27 (8 x 7 at scroll + $160) (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case17, RunScreenStateWhenNotFading_F1_Case0D_Case17)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawRects6B4FAnd6C27::
Func_01F_753A:: ; address name
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
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
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
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; clears 21 x 4 tiles at vTiles2 + $200 and draws the tile rectangles Data_01F_6C5F (12 x 18) and Data_01F_6D37 (8 x 7) (E-0127)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case18, RunScreenStateWhenNotFading_F1_Case0D_Case18)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wArg5, wArg6, wArg1, wArg2, ...
ClearTilesAndDrawRects6C5FAnd6D37::
Func_01F_7591:: ; address name
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
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
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
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; shows the eight skill names of the record at wCA2B (field $34) in rows from vTiles2 + $200, or string $0E of category 8 when it has none (E-0129)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case19, RunScreenStateWhenNotFading_F1_Case0D_Case19)
; reads: wRecordBufB
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory
; points at: wRecordBufB
ShowRecordBufBSkillNamesOrNone::
Func_01F_7601:: ; address name
    ld a, [wRecordBufB + $34]
    cp a, $FF
    jr z, Jump_01F_760D
    and a, a
    jr z, Jump_01F_760D
    jr Jump_01F_764E

Jump_01F_760D::
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
    ld a, $0E
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr Jump_01F_769E

Jump_01F_764E::
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08

Jump_01F_7655::
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
    and a, a
    jr z, Jump_01F_767D
    cp a, $FF
    jr z, Jump_01F_767D
    jr Jump_01F_7682

Jump_01F_767D::
    call FillTilesFromRequest
    jr Jump_01F_7690

Jump_01F_7682::
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    farcall ShowString_Bank08

Jump_01F_7690::
    pop hl
    ld a, l
    add a, $90
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    inc c
    dec b
    jr nz, Jump_01F_7655

Jump_01F_769E::
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

; draws the tile rectangles Data_01F_6E47 and Data_01F_6D6F, clears tile rows and sets up the summary text window (E-0128)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1B, RunScreenStateWhenNotFading_F1_Case0D_Case1B)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wTextWindowTileLo, ...
DrawSummaryFrames6E47And6D6F::
Func_01F_76B5:: ; address name
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
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld hl, vTiles2 + $6C0
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
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
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

; draws the tile rectangles Data_01F_5E13 (12 x 3 at scroll + 8) and Data_01F_66DF (8 x 7 at scroll + $160) (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1C, RunScreenStateWhenNotFading_F1_Case0D_Case1C)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawRects5E13And66DF::
Func_01F_7754:: ; address name
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
    ld a, $0C
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a, a
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
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 41 bytes appear in 3 banks)
; 14 call sites from 7 routines (e.g. ClearBGMapAndLoadFrameTiles, DrawWCA36MonsterPictureInTwoSteps, DrawRects662BAnd653F, DrawRects6B4FAnd6C27, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1F::
Func_01F_77AB:: ; address name
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_01F_77CF
    inc d

Jump_01F_77CF::
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_77D4:: ; heuristic: event script entry or jump target; C0
    script_command $F8
Script_1F_77D5:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_77F4, Script_1F_77EE, Script_1F_77E8, Script_1F_77E2, Script_1F_77DC
Script_1F_77DC:: ; heuristic: event script entry or jump target; C0
    script_command $EE
    script_message $8005 ; 'Tara Hurry! Papa will be angry!'
    script_command $EE
    script_end
Script_1F_77E2:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'Tara There you are, big brother!'
    script_jump Script_1F_77F7
Script_1F_77E8:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Cobi 0! Papa's calling. He's at'
    script_jump Script_1F_77F7
Script_1F_77EE:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'In the middle of the sea'
    script_jump Script_1F_77F7
Script_1F_77F4:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_77FD
Script_1F_77F7:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'Cobi What's wrong, 0? Papa's calling'
    script_jump Script_1F_77D5
Script_1F_77FD:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_780E, Script_1F_7808, Script_1F_7802
Script_1F_7802:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'Sailing is sure exhilarating. Right?'
    script_jump Script_1F_7811
Script_1F_7808:: ; heuristic: event script entry or jump target; C0
    script_message $C007 ; 'There's a spirit in GreatLog that's'
    script_jump Script_1F_7811
Script_1F_780E:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'You folks run a monster farm?'
Script_1F_7811:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7819, Script_1F_7815
Script_1F_7815:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_jump Script_1F_77F7
Script_1F_7819:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7831, Script_1F_782B, Script_1F_7825, Script_1F_781F
Script_1F_781F:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'We'll soon be reaching GreatLog. I'
    script_jump Script_1F_77FD
Script_1F_7825:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'Is that so? Too bad! You'll'
    script_jump Script_1F_77FD
Script_1F_782B:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Good. That's good to hear! You'
    script_jump Script_1F_77FD
Script_1F_7831:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_message $C00C ; 'GreatLog's King asked us to settle'
    script_command $F8
    script_choice_jump Script_1F_7845, Script_1F_783E, Script_1F_783A
Script_1F_783A:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_jump Script_1F_77FD
Script_1F_783E:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'Tara Big brother! GreatLog will be'
    script_command $F8
    script_jump Script_1F_77F7
Script_1F_7845:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7856, Script_1F_7850, Script_1F_784A
Script_1F_784A:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'Worried about your monsters? Don't be!'
    script_jump Script_1F_7859
Script_1F_7850:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'When our farm gets established in'
    script_jump Script_1F_7859
Script_1F_7856:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'GreatLog's King asked us to settle'
Script_1F_7859:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_786A, Script_1F_7864, Script_1F_785E
Script_1F_785E:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; 'Cobi 0! They said GreatLog will'
    script_jump Script_1F_786D
Script_1F_7864:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '0 peered into the vase. Freshly'
    script_jump Script_1F_786D
Script_1F_786A:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; '0 peered into the barrel. It'
Script_1F_786D:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7877, Script_1F_7871
Script_1F_7871:: ; heuristic: event script entry or jump target; C0
    script_command $EE
    script_message $8013 ; 'Land ho! There's GreatLog!'
    script_command $EE
    script_end
Script_1F_7877:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_jump Script_1F_77F7
Script_1F_787B:: ; heuristic: event script entry or jump target; C0
    script_command $F6
Script_1F_787C:: ; heuristic: event script entry or jump target; C0
    script_command $F6
    script_choice_jump Script_1F_7890, Script_1F_7887, Script_1F_7881
Script_1F_7881:: ; heuristic: event script entry or jump target; C0
    script_command $F6
    script_message $8002 ; 'Cobi 0! Papa's calling. He's at'
    script_command $F6
    script_end
Script_1F_7887:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'Tara Hurry! Papa will be angry!'
    script_message $C004 ; 'Cobi What's wrong, 0? Papa's calling'
    script_jump Script_1F_787C
Script_1F_7890:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'Tara There you are, big brother!'
Script_1F_7893:: ; heuristic: event script entry or jump target; C0
    script_command $F6
    script_choice_jump Script_1F_789F, Script_1F_7897
Script_1F_7897:: ; heuristic: event script entry or jump target; C0
    script_command $F6
    script_message $C004 ; 'Cobi What's wrong, 0? Papa's calling'
    script_command $F6
    script_jump Script_1F_787C
Script_1F_789F:: ; heuristic: event script entry or jump target; C0
    script_command $F6
    script_message $C003 ; 'Tara There you are, big brother!'
    script_command $F6
    script_jump Script_1F_7893
    ds $759, $00
