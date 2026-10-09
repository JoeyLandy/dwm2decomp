SECTION "Bank 6B", ROMX[$4000], BANK[$6B]
    INCBIN "dwm2-cobi-us.gbc", $1AC000, $379
    ds $12, $00
    dw Data_06B_43A3
    db $6B
    dw Data_06B_448F
    db $6B
    dw Data_06B_455A
    db $6B
    dw Data_06B_4636
    db $6B
    dw Data_06B_470A
    db $6B
    dw Data_06B_4773
    db $6B
    dw Data_06B_47C9
    db $6B
    dw Data_06B_4817
    db $6B

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_43A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC3A3, $EC

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_448F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC48F, $CB

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_455A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC55A, $DC

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4636:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC636, $D4

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_470A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC70A, $69

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4773:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC773, $56

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_47C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC7C9, $4E

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4817:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC817, $55F
    dw Data_06B_4D8E
    db $6B
    dw Data_06B_4E66
    db $6B
    dw Data_06B_4F4B
    db $6B
    dw Data_06B_501E
    db $6B
    dw Data_06B_5116
    db $6B
    dw Data_06B_516F
    db $6B
    dw Data_06B_51D0
    db $6B
    dw Data_06B_522F
    db $6B

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4D8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ACD8E, $D8

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4E66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ACE66, $E5

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4F4B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ACF4B, $D3

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_501E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD01E, $F8

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5116:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD116, $59

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_516F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD16F, $61

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_51D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD1D0, $5F

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_522F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD22F, $551
    dw Data_06B_5798
    db $6B
    dw Data_06B_5875
    db $6B
    dw Data_06B_5950
    db $6B
    dw Data_06B_5A51
    db $6B
    dw Data_06B_5B4A
    db $6B
    dw Data_06B_5BA8
    db $6B
    dw Data_06B_5BEE
    db $6B
    dw Data_06B_5C36
    db $6B

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5798:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD798, $DD

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5875:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD875, $DB

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5950:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD950, $101

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5A51:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADA51, $F9

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5B4A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADB4A, $5E

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5BA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADBA8, $46

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5BEE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADBEE, $48

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5C36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADC36, $4C7
    ds $12, $00
    dw Data_06B_6127
    db $6B
    dw Data_06B_6251
    db $6B
    dw Data_06B_633B
    db $6B
    dw Data_06B_643F
    db $6B
    dw Data_06B_653C
    db $6B
    dw Data_06B_658E
    db $6B
    dw Data_06B_65BF
    db $6B
    dw Data_06B_65ED
    db $6B

; LZSS-compressed asset: 298 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6127:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE127, $12A

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6251:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE251, $EA

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_633B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE33B, $104

; LZSS-compressed asset: 253 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_643F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE43F, $FD

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_653C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE53C, $52

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_658E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $03, $01, $00, $0F, $3C, $01, $A4, $FF, $49, $04, $04, $02, $02
    db $01, $9C, $0F, $0F, $04, $01, $D2, $01, $01, $C4, $0F, $0F, $01, $D0, $02, $01
    db $EC, $0F, $11, $01, $D6, $FF, $1B, $01, $F6, $F6, $02, $01, $5C, $11, $01, $4C
    db $02

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_65BF:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $04, $04, $FF, $FF, $2B, $02, $02, $04, $32, $0F, $05, $01, $01, $04
    db $32, $0E, $04, $58, $04, $04, $3E, $0A, $04, $E8, $FF, $43, $03, $03, $03, $03
    db $04, $3C, $0C, $04, $D8, $02, $04, $B2, $0F, $17, $04, $18, $1F, $39

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_65ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE5ED, $443
    ds $12, $00
    dw Data_06B_6A5A
    db $6B
    dw Data_06B_6B37
    db $6B
    dw Data_06B_6C24
    db $6B
    dw Data_06B_6D03
    db $6B
    dw Data_06B_6E0C
    db $6B
    dw Data_06B_6E6F
    db $6B
    dw Data_06B_6ECC
    db $6B
    dw Data_06B_6F0F
    db $6B

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6A5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEA5A, $DD

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6B37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEB37, $ED

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6C24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEC24, $DF

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6D03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AED03, $109

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6E0C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEE0C, $63

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6E6F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEE6F, $5D

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6ECC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEECC, $43

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6F0F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEF0F, $50F
    dw Data_06B_7436
    db $6B
    dw Data_06B_7557
    db $6B
    dw Data_06B_7645
    db $6B
    dw Data_06B_7765
    db $6B
    dw Data_06B_786E
    db $6B
    dw Data_06B_78E7
    db $6B
    dw Data_06B_795F
    db $6B
    dw Data_06B_79DB
    db $6B

; LZSS-compressed asset: 289 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7436:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF436, $121

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7557:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF557, $EE

; LZSS-compressed asset: 288 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7645:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF645, $120

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7765:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF765, $109

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_786E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF86E, $79

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_78E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF8E7, $78

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_795F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF95F, $7C

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_79DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF9DB, $69
    dw Data_06B_7A5C
    db $6B
    dw Data_06B_7B6E
    db $6B
    dw Data_06B_7C5B
    db $6B
    dw Data_06B_7D25
    db $6B
    dw Data_06B_7E1E
    db $6B
    dw Data_06B_7E72
    db $6B
    dw Data_06B_7EA4
    db $6B
    dw Data_06B_7EF3
    db $6B

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7A5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFA5C, $112

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7B6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFB6E, $ED

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7C5B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFC5B, $CA

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7D25:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFD25, $F9

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7E1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFE1E, $54

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7E72:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $02, $03, $00, $0F, $3E, $06, $03, $52, $01, $03, $44, $0F, $0D
    db $03, $52, $02, $06, $06, $01, $03, $80, $05, $03, $76, $0F, $11, $00, $00, $03
    db $9C, $0F, $13, $03, $86, $0F, $15, $03, $86, $0F, $07, $03, $50, $04, $03, $0C
    db $1F, $35

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7EA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFEA4, $4F

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7EF3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFEF3, $45
    ds $C8, $00
