SECTION "Bank 5A", ROMX[$4000], BANK[$5A]
    db $5A

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapAEScreens0::
Data_05A_4001:: ; heuristic: map screen array; C0
    dfar Data_05A_4049 ; entry 0
    dfar Data_05A_4066 ; entry 1
    dfar Data_05A_4101 ; entry 2
    dfar Data_05A_41A2 ; entry 3
    dfar Data_05A_4241 ; entry 4
    dfar Data_05A_42EA ; entry 5
    dfar Data_05A_437B ; entry 6
    dfar Data_05A_4413 ; entry 7
    dfar Data_05A_44D5 ; entry 8
    dfar Data_05A_458B ; entry 9
    dfar Data_05A_4649 ; entry 10
    dfar Data_05A_471C ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapAEAttrs0::
Data_05A_4025:: ; heuristic: map screen array; C0
    dfar Data_05A_4805 ; entry 0
    dfar Data_05A_4819 ; entry 1
    dfar Data_05A_482D ; entry 2
    dfar Data_05A_4854 ; entry 3
    dfar Data_05A_4880 ; entry 4
    dfar Data_05A_48A0 ; entry 5
    dfar Data_05A_48D4 ; entry 6
    dfar Data_05A_4904 ; entry 7
    dfar Data_05A_4935 ; entry 8
    dfar Data_05A_4962 ; entry 9
    dfar Data_05A_4976 ; entry 10
    dfar Data_05A_49A2 ; entry 11

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4049:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $20, $21, $00, $00, $0E, $30, $31, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4066:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $168066, $9B

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4101:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $168101, $A1

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_41A2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1681A2, $9F

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4241:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $168241, $A9

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_42EA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1682EA, $91

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_437B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16837B, $98

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4413:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $168413, $C2

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_44D5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1684D5, $B6

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_458B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16858B, $BE

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4649:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $168649, $D3

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_471C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16871C, $E9

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4805:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4819:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_482D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4A, $04, $04, $00, $4C, $0F, $11, $04, $04
    db $00, $72, $0F, $11, $00, $84, $00, $00, $9A, $0F, $0F, $00, $AA, $0F, $13, $00
    db $80, $0F, $17, $00, $00, $0F, $35

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4854:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $48, $04, $04, $04, $04, $00, $4C, $0F, $0B
    db $00, $5C, $00, $00, $5C, $0C, $00, $7E, $0F, $01, $00, $7C, $0F, $19, $00, $58
    db $02, $00, $C4, $0F, $13, $00, $FD, $0F, $4D, $00, $00, $06

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4880:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $04, $00, $56, $03, $00, $4A, $0F, $0D
    db $00, $54, $0F, $1D, $00, $46, $0F, $01, $00, $00, $0F, $43, $00, $00, $0F, $3D

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_48A0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $46, $04, $04, $00, $48, $0F, $0F, $04, $00
    db $7E, $03, $00, $72, $0F, $0B, $00, $7E, $04, $00, $82, $08, $00, $A4, $0F, $0D
    db $00, $5A, $04, $00, $CC, $0F, $03, $00, $7A, $06, $00, $52, $0A, $00, $80, $0E
    db $00, $00, $0F, $35

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_48D4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4C, $04, $04, $00, $4E, $0F, $11, $04, $04
    db $00, $74, $0F, $11, $03, $03, $00, $9A, $0F, $11, $00, $86, $00, $00, $60, $0C
    db $00, $D2, $0F, $05, $00, $76, $0F, $11, $00, $5E, $0F, $15, $00, $00, $0F, $0B

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4904:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $04, $04, $04, $04, $00, $54, $00, $00
    db $4A, $0F, $0B, $00, $56, $00, $00, $7C, $06, $00, $76, $0F, $2F, $00, $7A, $0A
    db $00, $C6, $0F, $09, $00, $7A, $06, $00, $4A, $0C, $00, $FC, $0C, $00, $00, $0F
    db $35

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4935:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4A, $04, $04, $04, $04, $00, $4E, $0F, $13
    db $00, $4C, $0F, $01, $00, $4E, $0F, $27, $00, $5E, $0E, $00, $D4, $0E, $00, $D4
    db $02, $00, $EC, $0F, $0F, $00, $84, $0F, $15, $00, $00, $0F, $0B

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4962:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4976:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $24, $0F, $10, $04, $04, $00, $72
    db $0F, $0F, $04, $00, $A8, $01, $00, $9A, $0F, $0D, $00, $A8, $02, $00, $AA, $0A
    db $00, $CE, $0F, $01, $00, $A6, $0F, $15, $00, $24, $0F, $37

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_49A2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $24, $04, $04, $00, $26, $0F, $11, $04, $04
    db $03, $03, $00, $4E, $0F, $11, $00, $85, $0F, $4D, $00, $E5, $0F, $4D, $00, $00
    db $0F, $0F

; compressed tileset of map $B0 (the first map record using it)
; LZSS-compressed asset: 1219 bytes expand to 1856 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapB0Tileset:: ; heuristic: map tileset stream; C0
Data_05A_49C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1689C4, $4C1
    dw Data_05A_54B8

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB0Screens0::
Data_05A_4E87:: ; heuristic: map screen array; C0
    dfar Data_05A_4EAB ; entry 0
    dfar Data_05A_4F48 ; entry 1
    dfar Data_05A_4FF2 ; entry 2
    dfar Data_05A_5089 ; entry 3
    dfar Data_05A_5136 ; entry 4
    dfar Data_05A_51C3 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB0Attrs0::
Data_05A_4E99:: ; heuristic: map screen array; C0
    dfar Data_05A_5234 ; entry 0
    dfar Data_05A_526F ; entry 1
    dfar Data_05A_52A4 ; entry 2
    dfar Data_05A_52E4 ; entry 3
    dfar Data_05A_532D ; entry 4
    dfar Data_05A_5365 ; entry 5

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4EAB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $168EAB, $9D

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4F48:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $168F48, $AA

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4FF2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $168FF2, $97

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5089:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $169089, $AD

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5136:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $169136, $8D

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_51C3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1691C3, $71

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5234:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $1A, $02, $02, $02, $02, $00, $1E, $0F, $0F
    db $00, $2E, $00, $02, $02, $01, $00, $5A, $01, $00, $4C, $0F, $07, $00, $54, $08
    db $00, $5A, $04, $00, $7A, $0F, $05, $00, $80, $08, $00, $9E, $0F, $05, $03, $03
    db $00, $A6, $0A, $00, $C6, $0F, $4D, $00, $FE, $0F, $1B

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_526F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $1A, $01, $00, $2E, $02, $00, $21, $0F, $0C
    db $00, $2E, $03, $00, $30, $09, $00, $54, $0C, $00, $54, $08, $02, $00, $84, $01
    db $00, $76, $0F, $0B, $05, $05, $00, $7C, $06, $00, $A0, $0F, $09, $00, $CF, $0F
    db $4D, $00, $08, $1F, $25

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_52A4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $40, $02, $02, $02, $02, $00, $44, $0F, $0F
    db $00, $54, $00, $00, $54, $00, $01, $01, $00, $70, $0F, $09, $00, $80, $00, $00
    db $A2, $06, $00, $9A, $0F, $07, $00, $A2, $08, $01, $01, $00, $56, $02, $00, $C8
    db $0F, $11, $00, $56, $00, $00, $F0, $0F, $0D, $00, $7A, $02, $00, $16, $1F, $2B

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_52E4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1692E4, $49

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_532D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $20, $02, $00, $34, $03, $00, $28, $0F, $0B
    db $00, $34, $02, $03, $03, $03, $03, $00, $50, $0F, $09, $00, $5C, $04, $00, $74
    db $0F, $0D, $00, $84, $04, $00, $9C, $0F, $09, $00, $A8, $08, $00, $C4, $0F, $05
    db $00, $EF, $0F, $4D, $00, $08, $1F, $05

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5365:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0C, $01, $03, $03, $00, $00, $0F
    db $01, $00, $0C, $00, $00, $06, $08, $00, $24, $0F, $05, $00, $4E, $00, $00, $32
    db $04, $00, $48, $0F, $15, $00, $4E, $02, $00, $76, $0F, $2F, $00, $26, $02, $00
    db $C0, $0A, $00, $CC, $0F, $03, $00, $F5, $0F, $4D, $00, $08, $1E

; compressed tileset of map $B1 (the first map record using it)
; LZSS-compressed asset: 1045 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapB1Tileset:: ; heuristic: map tileset stream; C0
Data_05A_53A2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1693A2, $116

Data_05A_54B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1694B8, $2FF

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapB1Palettes::
Data_05A_57B7:: ; heuristic: map BG palettes; C0
    dw $192C, $7FFF, $31CF, $0000 ; entry 0
    dw $056F, $331F, $01F5, $0000 ; entry 1
    dw $00EC, $3216, $1572, $0000 ; entry 2
    dw $012F, $331F, $01DA, $0000 ; entry 3
    dw $7E04, $7FFF, $1415, $0000 ; entry 4
    dw $04E6, $3F7F, $03E7, $0000 ; entry 5
    dw $3128, $331F, $45CC, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB1Screens0::
Data_05A_57F7:: ; heuristic: map screen array; C0
    dfar Data_05A_57FD ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB1Attrs0::
Data_05A_57FA:: ; heuristic: map screen array; C0
    dfar Data_05A_58E1 ; entry 0

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_57FD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1697FD, $E4

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_58E1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1698E1, $54

; compressed tileset of map $B3 (the first map record using it)
; LZSS-compressed asset: 707 bytes expand to 896 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapB3Tileset:: ; heuristic: map tileset stream; C0
Data_05A_5935:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $169935, $119

Data_05A_5A4E:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_05A_5A4F:: ; heuristic: target of a monotone pointer table; C0
    db $0F

Data_05A_5A50:: ; heuristic: target of a monotone pointer table; C0
    db $DF

Data_05A_5A51:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_05A_5A52:: ; heuristic: target of a monotone pointer table; C0
    db $FD

Data_05A_5A53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $169A53, $1A5

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapB3Palettes::
Data_05A_5BF8:: ; heuristic: map BG palettes; C0
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $0191, $5BBF, $32D6, $00C8 ; entry 1
    dw $0263, $3F7F, $03E7, $00A0 ; entry 2
    dw $01D3, $5BBF, $029A, $0000 ; entry 3
    dw $3189, $7FFF, $4E4F, $0000 ; entry 4
    dw $1415, $4FFF, $3C1F, $0000 ; entry 5
    dw $00A0, $00A0, $00A0, $00A0 ; entry 6
    dw $00A0, $00A0, $00A0, $00A0 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB3Screens0::
Data_05A_5C38:: ; heuristic: map screen array; C0
    dfar Data_05A_5C50 ; entry 0
    dfar Data_05A_5D20 ; entry 1
    dfar Data_05A_5DF8 ; entry 2
    dfar Data_05A_5EF4 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB3Attrs0::
Data_05A_5C44:: ; heuristic: map screen array; C0
    dfar Data_05A_5F99 ; entry 0
    dfar Data_05A_5FB4 ; entry 1
    dfar Data_05A_5FCF ; entry 2
    dfar Data_05A_5FED ; entry 3

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5C50:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $169C50, $D0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5D20:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $169D20, $D8

; LZSS-compressed asset: 252 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5DF8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $169DF8, $FC

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5EF4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $169EF4, $A5

; LZSS-compressed asset: 27 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5F99:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $04, $00, $52, $0D, $00, $50, $0F, $4D
    db $00, $B0, $0F, $4D, $00, $C2, $04, $00, $18, $1F, $29

; LZSS-compressed asset: 27 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5FB4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3C, $04, $00, $50, $0D, $00, $4E, $0F, $4D
    db $00, $AE, $0F, $43, $00, $B2, $0E, $00, $16, $1F, $2B

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5FCF:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $04, $00, $02, $0B, $01, $01, $00, $00, $0F, $4D, $00
    db $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $3E, $1F, $13

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5FED:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $04, $00, $02, $0B, $01, $01, $00, $00, $0F, $4D, $00
    db $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $3E, $1F, $13

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB4Screens0::
Data_05A_600B:: ; heuristic: map screen array; C0
    dfar Data_05A_6023 ; entry 0
    dfar Data_05A_60E5 ; entry 1
    dfar Data_05A_61C6 ; entry 2
    dfar Data_05A_62BC ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB4Attrs0::
Data_05A_6017:: ; heuristic: map screen array; C0
    dfar Data_05A_63B3 ; entry 0
    dfar Data_05A_63D3 ; entry 1
    dfar Data_05A_63F7 ; entry 2
    dfar Data_05A_6418 ; entry 3

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6023:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A023, $C2

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_60E5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A0E5, $E1

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_61C6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A1C6, $F6

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_62BC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A2BC, $F7

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_63B3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $04, $00, $52, $0D, $00, $50, $0F, $33
    db $00, $46, $0F, $01, $00, $AA, $0F, $2D, $00, $9A, $0F, $01, $00, $FE, $0F, $43

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_63D3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3C, $04, $00, $50, $0D, $00, $4E, $0F, $2B
    db $00, $4A, $0E, $00, $9E, $0F, $2B, $00, $50, $0F, $3D, $00, $9A, $08, $00, $48
    db $08, $00, $00, $0C

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_63F7:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $04, $00, $02, $03, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $40, $1F
    db $13

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6418:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $0B, $00, $00, $0F, $31, $00
    db $00, $00, $00, $58, $02, $00, $4E, $0F, $4D, $00, $5E, $06, $00, $C8, $0A, $00
    db $C6, $0F, $4D, $00, $00, $0F, $01, $00, $3E, $1F, $07

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB5Screens0::
Data_05A_6443:: ; heuristic: map screen array; C0
    dfar Data_05A_645B ; entry 0
    dfar Data_05A_645B ; entry 1
    dfar Data_05A_6506 ; entry 2
    dfar Data_05A_65F8 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB5Attrs0::
Data_05A_644F:: ; heuristic: map screen array; C0
    dfar Data_05A_66DB ; entry 0
    dfar Data_05A_66DB ; entry 1
    dfar Data_05A_66FD ; entry 2
    dfar Data_05A_672F ; entry 3

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_645B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A45B, $AB

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6506:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A506, $F2

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_65F8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A5F8, $E3

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_66DB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $04, $00, $52, $0B, $00, $4E, $0F, $4D
    db $00, $AE, $0F, $4D, $00, $D2, $0F, $0D, $00, $4C, $06, $00, $42, $0F, $01, $00
    db $00, $04

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_66FD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0F, $2B, $00, $08, $00, $00, $52, $08, $00, $4E, $0F, $15, $00, $0A, $00, $00
    db $7A, $0F, $4D, $00, $9E, $0F, $01, $00, $4E, $0F, $29, $00, $0C, $0C, $00, $3E
    db $1F, $07

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_672F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1C, $04, $04, $04, $04, $00, $20, $0F, $0B
    db $00, $30, $00, $00, $52, $08, $00, $4E, $0F, $03, $00, $52, $0C, $00, $74, $0F
    db $4D, $00, $5C, $0F, $09, $00, $F0, $0F, $2B, $00, $00, $0F, $13

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB6Screens0::
Data_05A_675C:: ; heuristic: map screen array; C0
    dfar Data_05A_6762 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB6Attrs0::
Data_05A_675F:: ; heuristic: map screen array; C0
    dfar Data_05A_685A ; entry 0

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6762:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A762, $F8

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_685A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16A85A, $4F

; compressed tileset of map $B8 (the first map record using it)
; LZSS-compressed asset: 1222 bytes expand to 1920 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapB8Tileset:: ; heuristic: map tileset stream; C0
Data_05A_68A9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16A8A9, $4C6

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapB8Palettes::
Data_05A_6D6F:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $012F, $3FBF, $03E2, $0000 ; entry 2
    dw $318C, $5294, $03E2, $0000 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

; E-0142 (derived: 25 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB8Screens0::
Data_05A_6DAF:: ; heuristic: map screen array; C0
    dfar Data_05A_6E45 ; entry 0
    dfar Data_05A_6EB7 ; entry 1
    dfar Data_05A_6F42 ; entry 2
    dfar Data_05A_6FA5 ; entry 3
    dfar Data_05A_6FF6 ; entry 4
    dfar Data_05A_7056 ; entry 5
    dfar Data_05A_70E6 ; entry 6
    dfar Data_05A_7188 ; entry 7
    dfar Data_05A_71F6 ; entry 8
    dfar Data_05A_7276 ; entry 9
    dfar Data_05A_7310 ; entry 10
    dfar Data_05A_737A ; entry 11
    dfar Data_05A_73FE ; entry 12
    dfar Data_05A_7467 ; entry 13
    dfar Data_05A_74ED ; entry 14
    dfar Data_05A_756A ; entry 15
    dfar Data_05A_75DB ; entry 16
    dfar Data_05A_7663 ; entry 17
    dfar Data_05A_76E4 ; entry 18
    dfar Data_05A_7779 ; entry 19
    dfar Data_05A_7815 ; entry 20
    dfar Data_05A_7890 ; entry 21
    dfar Data_05A_7915 ; entry 22
    dfar Data_05A_7989 ; entry 23
    dfar Data_05A_79E7 ; entry 24

; E-0142 (derived: 25 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB8Attrs0::
Data_05A_6DFA:: ; heuristic: map screen array; C0
    dfar Data_05A_7A5F ; entry 0
    dfar Data_05A_7A90 ; entry 1
    dfar Data_05A_7AC8 ; entry 2
    dfar Data_05A_7AE4 ; entry 3
    dfar Data_05A_7B0A ; entry 4
    dfar Data_05A_7B3C ; entry 5
    dfar Data_05A_7B83 ; entry 6
    dfar Data_05A_7BAF ; entry 7
    dfar Data_05A_7BCF ; entry 8
    dfar Data_05A_7C10 ; entry 9
    dfar Data_05A_7C69 ; entry 10
    dfar Data_05A_7CAB ; entry 11
    dfar Data_05A_7CD2 ; entry 12
    dfar Data_05A_7D0E ; entry 13
    dfar Data_05A_7D4E ; entry 14
    dfar Data_05A_7D94 ; entry 15
    dfar Data_05A_7DD8 ; entry 16
    dfar Data_05A_7DF9 ; entry 17
    dfar Data_05A_7E2F ; entry 18
    dfar Data_05A_7E70 ; entry 19
    dfar Data_05A_7EB8 ; entry 20
    dfar Data_05A_7EFB ; entry 21
    dfar Data_05A_7F33 ; entry 22
    dfar Data_05A_7F6B ; entry 23
    dfar Data_05A_7F9F ; entry 24

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6E45:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16AE45, $72

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6EB7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16AEB7, $8B

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6F42:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16AF42, $63

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6FA5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16AFA5, $51

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6FF6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16AFF6, $60

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7056:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B056, $90

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_70E6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B0E6, $A2

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7188:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B188, $6E

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_71F6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B1F6, $80

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7276:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B276, $9A

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7310:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B310, $6A

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_737A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B37A, $84

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_73FE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B3FE, $69

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7467:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B467, $86

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_74ED:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B4ED, $7D

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_756A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B56A, $71

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_75DB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B5DB, $88

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7663:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B663, $81

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_76E4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B6E4, $95

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7779:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B779, $9C

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7815:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B815, $7B

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7890:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B890, $85

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7915:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B915, $74

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7989:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B989, $5E

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_79E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16B9E7, $78

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7A5F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $44, $02, $00, $58, $03, $00, $4C, $0F, $13
    db $01, $00, $86, $01, $00, $78, $0F, $05, $00, $80, $08, $00, $9C, $0F, $0D, $00
    db $AA, $06, $00, $C6, $0F, $0B, $00, $A8, $0F, $39, $00, $56, $00, $00, $34, $1F
    db $0D

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7A90:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $40, $02, $02, $02, $02, $00, $00, $00, $01
    db $00, $5C, $03, $00, $50, $0F, $01, $01, $01, $00, $54, $00, $00, $6A, $0F, $11
    db $00, $78, $02, $00, $94, $0F, $11, $00, $78, $02, $00, $C0, $0A, $00, $CC, $0F
    db $03, $00, $F5, $0F, $4D, $00, $08, $1E

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7AC8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $3C, $01, $00, $50, $05, $00, $46, $0F, $15
    db $00, $81, $0F, $4D, $00, $E1, $0F, $4D, $00, $08, $1F, $13

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7AE4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $18, $0F, $04, $01, $00, $78, $03
    db $00, $6C, $0F, $15, $00, $7E, $08, $00, $A0, $0F, $0B, $00, $7E, $06, $00, $C8
    db $0F, $4D, $00, $00, $1F, $19

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7B0A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $1C, $0F, $08, $01, $00, $7C, $05
    db $00, $72, $0F, $0F, $05, $05, $00, $80, $0A, $00, $A4, $0E, $00, $7C, $06, $00
    db $C0, $0F, $33, $00, $C8, $0A, $00, $14, $1F, $09, $02, $02, $02, $02, $00, $34
    db $1F, $0D

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7B3C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BB3C, $47

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7B83:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $02, $00, $0F, $42, $02, $FC, $FF, $01, $02, $56, $0F, $05
    db $02, $FE, $FC, $02, $7E, $0F, $07, $02, $FE, $FA, $02, $F8, $FF, $01, $05, $05
    db $02, $BC, $0F, $13, $02, $54, $0F, $17, $02, $0E, $0F, $35

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7BAF:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $9C, $0F, $28
    db $03, $03, $03, $03, $00, $EC, $0F, $0F, $00, $FC, $0F, $13, $00, $FA, $0F, $0D

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7BCF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BBCF, $41

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7C10:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BC10, $59

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7C69:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BC69, $42

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7CAB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $18, $0F, $04, $02, $02, $00, $66
    db $0F, $15, $00, $78, $0E, $00, $A0, $0F, $05, $00, $78, $0C, $00, $C8, $0F, $2D
    db $00, $90, $0F, $29, $00, $18, $0C

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7CD2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $03, $03, $03, $00, $00, $06, $00, $04
    db $0F, $07, $00, $08, $00, $00, $22, $0F, $15, $00, $0C, $0F, $11, $00, $0A, $00
    db $00, $82, $02, $00, $78, $0F, $31, $00, $82, $06, $00, $C6, $0F, $09, $00, $D0
    db $08, $00, $EE, $0F, $07, $00, $F6, $0A, $00, $16, $1F, $2B

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7D0E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $40, $03, $00, $54, $03, $00, $00, $02, $02
    db $02, $00, $50, $0F, $01, $00, $54, $04, $00, $58, $04, $02, $02, $00, $76, $0F
    db $09, $00, $76, $04, $00, $9A, $0F, $0B, $00, $9C, $08, $00, $C4, $0F, $0B, $00
    db $52, $06, $00, $EC, $0F, $09, $00, $50, $08, $00, $54, $08, $00, $20, $1F, $21

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7D4E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BD4E, $46

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7D94:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BD94, $44

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7DD8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $02, $02, $01, $00, $04, $0B, $00, $00, $0F, $4D, $00
    db $10, $02, $00, $18, $0C, $00, $76, $0F, $2B, $00, $C7, $0F, $4D, $00, $08, $1F
    db $2D

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7DF9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $0B, $00, $00, $0F, $05, $00
    db $28, $02, $00, $1E, $0F, $15, $00, $00, $06, $00, $50, $0F, $0F, $00, $85, $0F
    db $4D, $00, $C6, $0F, $2D, $02, $02, $02, $02, $00, $16, $1F, $0F, $00, $26, $10
    db $00, $26, $1C, $00, $4C, $14

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7E2F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BE2F, $41

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7E70:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BE70, $48

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7EB8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16BEB8, $43

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7EFB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $46, $02, $02, $00, $48, $0F, $0F, $02, $00
    db $7E, $03, $00, $7C, $02, $00, $78, $0F, $05, $00, $7E, $04, $00, $7E, $06, $00
    db $A2, $0E, $00, $A4, $06, $03, $00, $D2, $05, $00, $C8, $0F, $09, $00, $D2, $06
    db $00, $EE, $0F, $03, $00, $0C, $1F, $3D

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7F33:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0C, $03, $00, $00, $0F, $05, $00
    db $26, $04, $00, $20, $0F, $0B, $00, $32, $06, $00, $48, $0F, $09, $00, $68, $0F
    db $3D, $03, $03, $00, $C4, $02, $00, $CE, $00, $00, $C0, $0F, $0B, $00, $F0, $0A
    db $00, $EC, $0F, $15, $00, $18, $1F, $2D

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7F6B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $33, $00, $08, $0F, $1D, $03, $03, $03, $03, $00, $A0
    db $0F, $07, $00, $AA, $06, $00, $C4, $0F, $09, $00, $B0, $00, $00, $E4, $0F, $0D
    db $00, $10, $1F, $3D

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7F9F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $33, $00
    db $06, $06, $00, $50, $0F, $0F, $00, $08, $02, $00, $78, $0F, $01, $00, $4C, $0C
    db $00, $9C, $0F, $39, $00, $0A, $06, $00, $F2, $0F, $03, $00, $10, $1F, $39
    ds $32, $00
