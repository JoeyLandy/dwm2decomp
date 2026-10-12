SECTION "Bank 95", ROMX[$4000], BANK[$95]
    db $95

; compressed tileset of map $4E (the first map record using it)
; LZSS-compressed asset: 513 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4ETileset:: ; heuristic: map tileset stream; C0
Data_095_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $254001, $201

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4EScreens0::
Data_095_4202:: ; address name
    dfar Map4EScreens0_Y0X0 ; entry 0
    dfar Map4EScreens0_Y1X0 ; entry 1
    dfar Map4EScreens0_Y2X0 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4EAttrs0::
Data_095_420B:: ; address name
    dfar Map4EAttrs0_Y0X0 ; entry 0
    dfar Map4EAttrs0_Y1X0 ; entry 1
    dfar Map4EAttrs0_Y2X0 ; entry 2

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4EScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_095_4214:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $254214, $78

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4EScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_095_428C:: ; address name
    db $68, $01, $01, $01, $FF, $F2, $10, $19, $40, $41, $40, $41, $18, $11, $01, $FA
    db $F8, $12, $1B, $01, $08, $00, $1A, $13, $01, $FA, $FF, $4D, $01, $5A, $0F, $4D
    db $01, $BA, $0F, $4D, $01, $F2, $0F, $13

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4EScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_095_42B4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2542B4, $78

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4EAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_095_432C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25432C, $4A

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4EAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_095_4376:: ; address name
    db $68, $01, $02, $02, $FF, $F2, $01, $01, $03, $03, $03, $03, $01, $01, $02, $FA
    db $FF, $4D, $02, $5A, $0F, $4D, $02, $BA, $0F, $4D, $02, $06, $1F, $27

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4EAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_095_4394:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $254394, $52

; compressed tileset of map $92 (the first map record using it)
; LZSS-compressed asset: 411 bytes expand to 464 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map92Tileset:: ; heuristic: map tileset stream; C0
Data_095_43E6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2543E6, $19B

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map92Screens0::
Data_095_4581:: ; address name
    dfar Map92Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map92Attrs0::
Data_095_4584:: ; address name
    dfar Map92Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map92Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_095_4587:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $254587, $97

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map92Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_095_461E:: ; address name
    db $68, $01, $02, $03, $02, $00, $0F, $18, $01, $02, $2C, $07, $02, $24, $0F, $07
    db $02, $2C, $08, $02, $34, $04, $02, $52, $0F, $2F, $00, $00, $02, $96, $0F, $13
    db $02, $58, $0F, $37, $02, $2A, $0F, $15, $02, $28, $08, $02, $20, $0F, $01, $02
    db $00, $02

; only called from BeginStringDisplay_Bank08 (E-0047)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank08)
; reads: wStringCategory
; writes: wStringCategory
BeginStringDisplay_Bank08_BeginStringDisplay::
Func_095_4650:: ; address name
    ld de, StringCategories_95_4675
    ld a, [wStringCategory]
    sub a, $09
    ld [wStringCategory], a
    call BeginStringDisplay
    ret

; only called from CopyStringToBuffer_Bank08 (E-0047)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank08)
; reads: wStringCategory
; writes: wStringCategory
CopyStringToBuffer_Bank08_CopyStringToBuffer::
Func_095_465F:: ; address name
    ld de, StringCategories_95_4675
    ld a, [wStringCategory]
    sub a, $09
    ld [wStringCategory], a
    call CopyStringToBuffer
    ret
    db $CD, $50, $46, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_95_4675::
Data_095_4675:: ; address name
    dw StringList_95_468D ; id 0
    dw StringList_95_47ED ; id 1
    dw StringList_95_47EF ; id 2
    dw StringList_95_4837 ; id 3
    dw StringList_95_4839 ; id 4
    dw StringList_95_4847 ; id 5
    dw StringList_95_4853 ; id 6
    dw StringList_95_4857 ; id 7
    dw StringList_95_4869 ; id 8
    dw StringList_95_487F ; id 9
    dw StringList_95_48B7 ; id 10
    dw StringList_95_48C7 ; id 11

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_468D::
StringTable95_Cat09_SkillDescriptions:: ; heuristic: string list; C0
Data_095_468D:: ; address name
    dw String_95_00_00 ; id 0
    dw String_95_00_00 ; id 1
    dw String_95_00_02 ; id 2
    dw String_95_00_03 ; id 3
    dw String_95_00_04 ; id 4
    dw String_95_00_05 ; id 5
    dw String_95_00_06 ; id 6
    dw String_95_00_07 ; id 7
    dw String_95_00_08 ; id 8
    dw String_95_00_09 ; id 9
    dw String_95_00_0A ; id 10
    dw String_95_00_0B ; id 11
    dw String_95_00_0C ; id 12
    dw String_95_00_0D ; id 13
    dw String_95_00_0E ; id 14
    dw String_95_00_0F ; id 15
    dw String_95_00_10 ; id 16
    dw String_95_00_11 ; id 17
    dw String_95_00_12 ; id 18
    dw String_95_00_13 ; id 19
    dw String_95_00_14 ; id 20
    dw String_95_00_15 ; id 21
    dw String_95_00_16 ; id 22
    dw String_95_00_17 ; id 23
    dw String_95_00_18 ; id 24
    dw String_95_00_19 ; id 25
    dw String_95_00_1A ; id 26
    dw String_95_00_1B ; id 27
    dw String_95_00_1C ; id 28
    dw String_95_00_1D ; id 29
    dw String_95_00_1E ; id 30
    dw String_95_00_1F ; id 31
    dw String_95_00_20 ; id 32
    dw String_95_00_21 ; id 33
    dw String_95_00_22 ; id 34
    dw String_95_00_23 ; id 35
    dw String_95_00_24 ; id 36
    dw String_95_00_25 ; id 37
    dw String_95_00_26 ; id 38
    dw String_95_00_27 ; id 39
    dw String_95_00_28 ; id 40
    dw String_95_00_29 ; id 41
    dw String_95_00_2A ; id 42
    dw String_95_00_2B ; id 43
    dw String_95_00_2C ; id 44
    dw String_95_00_2D ; id 45
    dw String_95_00_2E ; id 46
    dw String_95_00_2F ; id 47
    dw String_95_00_30 ; id 48
    dw String_95_00_31 ; id 49
    dw String_95_00_32 ; id 50
    dw String_95_00_33 ; id 51
    dw String_95_00_34 ; id 52
    dw String_95_00_35 ; id 53
    dw String_95_00_36 ; id 54
    dw String_95_00_37 ; id 55
    dw String_95_00_38 ; id 56
    dw String_95_00_39 ; id 57
    dw String_95_00_3A ; id 58
    dw String_95_00_3B ; id 59
    dw String_95_00_3C ; id 60
    dw String_95_00_3D ; id 61
    dw String_95_00_3E ; id 62
    dw String_95_00_3F ; id 63
    dw String_95_00_40 ; id 64
    dw String_95_00_41 ; id 65
    dw String_95_00_42 ; id 66
    dw String_95_00_43 ; id 67
    dw String_95_00_44 ; id 68
    dw String_95_00_45 ; id 69
    dw String_95_00_46 ; id 70
    dw String_95_00_47 ; id 71
    dw String_95_00_48 ; id 72
    dw String_95_00_49 ; id 73
    dw String_95_00_4A ; id 74
    dw String_95_00_4B ; id 75
    dw String_95_00_4C ; id 76
    dw String_95_00_4D ; id 77
    dw String_95_00_4E ; id 78
    dw String_95_00_4F ; id 79
    dw String_95_00_50 ; id 80
    dw String_95_00_51 ; id 81
    dw String_95_00_52 ; id 82
    dw String_95_00_53 ; id 83
    dw String_95_00_54 ; id 84
    dw String_95_00_55 ; id 85
    dw String_95_00_56 ; id 86
    dw String_95_00_57 ; id 87
    dw String_95_00_58 ; id 88
    dw String_95_00_59 ; id 89
    dw String_95_00_5A ; id 90
    dw String_95_00_5B ; id 91
    dw String_95_00_5C ; id 92
    dw String_95_00_5D ; id 93
    dw String_95_00_5E ; id 94
    dw String_95_00_5F ; id 95
    dw String_95_00_60 ; id 96
    dw String_95_00_61 ; id 97
    dw String_95_00_62 ; id 98
    dw String_95_00_63 ; id 99
    dw String_95_00_64 ; id 100
    dw String_95_00_65 ; id 101
    dw String_95_00_66 ; id 102
    dw String_95_00_67 ; id 103
    dw String_95_00_68 ; id 104
    dw String_95_00_69 ; id 105
    dw String_95_00_6A ; id 106
    dw String_95_00_6B ; id 107
    dw String_95_00_6C ; id 108
    dw String_95_00_6D ; id 109
    dw String_95_00_6E ; id 110
    dw String_95_00_6F ; id 111
    dw String_95_00_70 ; id 112
    dw String_95_00_71 ; id 113
    dw String_95_00_72 ; id 114
    dw String_95_00_73 ; id 115
    dw String_95_00_74 ; id 116
    dw String_95_00_75 ; id 117
    dw String_95_00_76 ; id 118
    dw String_95_00_77 ; id 119
    dw String_95_00_78 ; id 120
    dw String_95_00_79 ; id 121
    dw String_95_00_7A ; id 122
    dw String_95_00_7B ; id 123
    dw String_95_00_7C ; id 124
    dw String_95_00_7D ; id 125
    dw String_95_00_7E ; id 126
    dw String_95_00_7F ; id 127
    dw String_95_00_80 ; id 128
    dw String_95_00_81 ; id 129
    dw String_95_00_82 ; id 130
    dw String_95_00_83 ; id 131
    dw String_95_00_84 ; id 132
    dw String_95_00_85 ; id 133
    dw String_95_00_86 ; id 134
    dw String_95_00_87 ; id 135
    dw String_95_00_88 ; id 136
    dw String_95_00_89 ; id 137
    dw String_95_00_8A ; id 138
    dw String_95_00_8B ; id 139
    dw String_95_00_8C ; id 140
    dw String_95_00_8D ; id 141
    dw String_95_00_8E ; id 142
    dw String_95_00_8F ; id 143
    dw String_95_00_90 ; id 144
    dw String_95_00_91 ; id 145
    dw String_95_00_92 ; id 146
    dw String_95_00_93 ; id 147
    dw String_95_00_94 ; id 148
    dw String_95_00_95 ; id 149
    dw String_95_00_96 ; id 150
    dw String_95_00_97 ; id 151
    dw String_95_00_98 ; id 152
    dw String_95_00_99 ; id 153
    dw String_95_00_9A ; id 154
    dw String_95_00_9B ; id 155
    dw String_95_00_9C ; id 156
    dw String_95_00_9D ; id 157
    dw String_95_00_9E ; id 158
    dw String_95_00_9F ; id 159
    dw String_95_00_A0 ; id 160
    dw String_95_00_A1 ; id 161
    dw String_95_00_A2 ; id 162
    dw String_95_00_A3 ; id 163
    dw String_95_00_A4 ; id 164
    dw String_95_00_A5 ; id 165
    dw String_95_00_A6 ; id 166
    dw String_95_00_A7 ; id 167
    dw String_95_00_A8 ; id 168
    dw String_95_00_A9 ; id 169
    dw String_95_00_AA ; id 170
    dw String_95_00_AB ; id 171
    dw String_95_00_AB ; id 172
    dw String_95_00_AB ; id 173
    dw String_95_00_AB ; id 174
    dw String_95_00_AB ; id 175

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_47ED::
StringTable95_Cat0A:: ; heuristic: string list; C0
Data_095_47ED:: ; address name
    dw String_95_01_00 ; id 0

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_47EF::
StringTable95_Cat0B:: ; heuristic: string list; C0
Data_095_47EF:: ; address name
    dw String_95_02_00 ; id 0
    dw String_95_02_01 ; id 1
    dw String_95_02_02 ; id 2
    dw String_95_02_03 ; id 3
    dw String_95_02_04 ; id 4
    dw String_95_02_05 ; id 5
    dw String_95_02_06 ; id 6
    dw String_95_02_07 ; id 7
    dw String_95_02_08 ; id 8
    dw String_95_02_09 ; id 9
    dw String_95_02_0A ; id 10
    dw String_95_02_0B ; id 11
    dw String_95_02_0C ; id 12
    dw String_95_02_0D ; id 13
    dw String_95_02_0E ; id 14
    dw String_95_02_0F ; id 15
    dw String_95_02_10 ; id 16
    dw String_95_02_11 ; id 17
    dw String_95_02_12 ; id 18
    dw String_95_02_13 ; id 19
    dw String_95_02_14 ; id 20
    dw String_95_02_15 ; id 21
    dw String_95_02_15 ; id 22
    dw String_95_02_15 ; id 23
    dw String_95_02_15 ; id 24
    dw String_95_02_15 ; id 25
    dw String_95_02_15 ; id 26
    dw String_95_02_1B ; id 27
    dw String_95_02_1C ; id 28
    dw String_95_02_1D ; id 29
    dw String_95_02_1E ; id 30
    dw String_95_02_1F ; id 31
    dw String_95_02_20 ; id 32
    dw String_95_02_21 ; id 33
    dw String_95_02_22 ; id 34
    dw String_95_02_23 ; id 35

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_4837::
StringTable95_Cat0C_FieldActions:: ; heuristic: string list; C0
Data_095_4837:: ; address name
    dw String_95_03_00 ; id 0

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_4839::
StringTable_FieldAbilities:: ; heuristic: string list; C0
Data_095_4839:: ; address name
    dw String_95_04_00 ; id 0
    dw String_95_04_01 ; id 1
    dw String_95_04_02 ; id 2
    dw String_95_04_03 ; id 3
    dw String_95_04_04 ; id 4
    dw String_95_04_05 ; id 5
    dw String_95_04_06 ; id 6

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_4847::
StringTable95_Cat0E_Tactics:: ; heuristic: string list; C0
Data_095_4847:: ; address name
    dw String_95_05_00 ; id 0
    dw String_95_05_00 ; id 1
    dw String_95_05_02 ; id 2
    dw String_95_05_03 ; id 3
    dw String_95_05_04 ; id 4
    dw String_95_05_05 ; id 5

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_4853::
StringTable95_Cat0F:: ; heuristic: string list; C0
Data_095_4853:: ; address name
    dw String_95_06_00 ; id 0
    dw String_95_06_00 ; id 1

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_4857::
StringTable95_Cat10:: ; heuristic: string list; C0
Data_095_4857:: ; address name
    dw String_95_06_00 ; id 0
    dw String_95_07_01 ; id 1
    dw String_95_07_02 ; id 2
    dw String_95_07_03 ; id 3
    dw String_95_07_04 ; id 4
    dw String_95_07_05 ; id 5
    dw String_95_07_06 ; id 6
    dw String_95_07_07 ; id 7
    dw String_95_07_08 ; id 8

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_4869::
StringTable95_Cat11_Targets:: ; heuristic: string list; C0
Data_095_4869:: ; address name
    dw String_95_08_00 ; id 0
    dw String_95_08_01 ; id 1
    dw String_95_08_02 ; id 2
    dw String_95_08_03 ; id 3
    dw String_95_08_04 ; id 4
    dw String_95_08_05 ; id 5
    dw String_95_08_06 ; id 6
    dw String_95_08_07 ; id 7
    dw String_95_08_08 ; id 8
    dw String_95_08_09 ; id 9
    dw String_95_08_0A ; id 10

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_487F::
StringTable95_Cat12_SkillFamilies:: ; heuristic: string list; C0
Data_095_487F:: ; address name
    dw String_95_09_00 ; id 0
    dw String_95_09_01 ; id 1
    dw String_95_09_02 ; id 2
    dw String_95_09_03 ; id 3
    dw String_95_09_04 ; id 4
    dw String_95_09_05 ; id 5
    dw String_95_09_06 ; id 6
    dw String_95_09_07 ; id 7
    dw String_95_09_08 ; id 8
    dw String_95_09_09 ; id 9
    dw String_95_09_0A ; id 10
    dw String_95_09_0B ; id 11
    dw String_95_09_0C ; id 12
    dw String_95_09_0D ; id 13
    dw String_95_09_0E ; id 14
    dw String_95_09_0F ; id 15
    dw String_95_09_10 ; id 16
    dw String_95_09_11 ; id 17
    dw String_95_09_12 ; id 18
    dw String_95_09_13 ; id 19
    dw String_95_09_14 ; id 20
    dw String_95_09_15 ; id 21
    dw String_95_09_16 ; id 22
    dw String_95_09_17 ; id 23
    dw String_95_09_18 ; id 24
    dw String_95_09_19 ; id 25
    dw String_95_09_1A ; id 26
    dw String_95_09_1B ; id 27

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_48B7::
StringTable95_Cat13_SkillTypes:: ; heuristic: string list; C0
Data_095_48B7:: ; address name
    dw String_95_0A_00 ; id 0
    dw String_95_0A_01 ; id 1
    dw String_95_0A_02 ; id 2
    dw String_95_0A_03 ; id 3
    dw String_95_0A_04 ; id 4
    dw String_95_0A_05 ; id 5
    dw String_95_0A_06 ; id 6
    dw String_95_0A_07 ; id 7

; E-0217 (derived: category list of StringCategories_95_4675; one pointer per wStringIndex)
; record: string
StringList_95_48C7::
StringTable95_Cat14_Usable:: ; heuristic: string list; C0
Data_095_48C7:: ; address name
    dw String_95_0B_00 ; id 0
    dw String_95_0B_01 ; id 1
    dw String_95_0B_02 ; id 2
    dw String_95_0B_03 ; id 3

String_95_00_00:: ; heuristic: string; C0
Data_095_48CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks an enemy", $F1
    db "with a fireball.", $F1
    db $F0

String_95_00_02:: ; heuristic: string; C0
Data_095_48F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks an enemy", $F1
    db "with a large", $F1
    db "fireball.", $F0

String_95_00_03:: ; heuristic: string; C0
Data_095_491A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A towering pillar", $F1
    db "of fire roasts an", $F1
    db "enemy.", $F0

String_95_00_04:: ; heuristic: string; C0
Data_095_4945:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks enemies", $F1
    db "with a blast of", $F1
    db "fire ", $A0, "all", $A1, ".", $F0

String_95_00_05:: ; heuristic: string; C0
Data_095_4971:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks enemies", $F1
    db "with a wall of", $F1
    db "fire ", $A0, "all", $A1, ".", $F0

String_95_00_06:: ; heuristic: string; C0
Data_095_499C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A huge wall of", $F1
    db "fire incinerates", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_07:: ; heuristic: string; C0
Data_095_49CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small explosions", $F1
    db "strike enemies", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_08:: ; heuristic: string; C0
Data_095_49F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A succession of", $F1
    db "explosions strikes", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_09:: ; heuristic: string; C0
Data_095_4A24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Huge explosions", $F1
    db "blast enemies", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_0A:: ; heuristic: string; C0
Data_095_4A49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Razor sharp", $F1
    db "whirlwinds slash", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_0B:: ; heuristic: string; C0
Data_095_4A75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Twisters tear", $F1
    db "through enemies", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_0C:: ; heuristic: string; C0
Data_095_4A9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A huge tornado", $F1
    db "roars through", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0, " "

String_95_00_0D:: ; heuristic: string; C0
Data_095_4AC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lightning strikes", $F1
    db "enemies ", $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_0E:: ; heuristic: string; C0
Data_095_4AE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Powerful bolts of", $F1
    db "lightning lash", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_0F:: ; heuristic: string; C0
Data_095_4B19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Huge shards of", $F1
    db "lightning rip", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_10:: ; heuristic: string; C0
Data_095_4B45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small chunks of", $F1
    db "ice hail down on", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_11:: ; heuristic: string; C0
Data_095_4B75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enemies are flash", $F1
    db "frozen ", $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_12:: ; heuristic: string; C0
Data_095_4B96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A wicked blizzard", $F1
    db "howls through", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_13:: ; heuristic: string; C0
Data_095_4BC5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly slays an", $F1
    db "enemy.", $F1
    db $F0

String_95_00_14:: ; heuristic: string; C0
Data_095_4BE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly slays", $F1
    db "enemies ", $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_15:: ; heuristic: string; C0
Data_095_4C00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The user explodes", $F1
    db "to inflict damage", $F1
    db "on all enemies.", $F0

String_95_00_16:: ; heuristic: string; C0
Data_095_4C34:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by", $F1
    db "30", $9D, "40.", $F1
    db $F0

String_95_00_17:: ; heuristic: string; C0
Data_095_4C4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by", $F1
    db "75", $9D, "90.", $F1
    db $F0

String_95_00_18:: ; heuristic: string; C0
Data_095_4C62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores", $F1
    db "HP.", $F1
    db $F0

String_95_00_19:: ; heuristic: string; C0
Data_095_4C76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by", $F1
    db "90", $9D, "120 ", $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_1A:: ; heuristic: string; C0
Data_095_4C94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores HP", $F1
    db $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_1B:: ; heuristic: string; C0
Data_095_4CAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gives 15MP to a", $F1
    db "party monster.", $F1
    db $F0

String_95_00_1C:: ; heuristic: string; C0
Data_095_4CCE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gives 30MP to a", $F1
    db "party monster.", $F1
    db $F0

String_95_00_1D:: ; heuristic: string; C0
Data_095_4CEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gives 80MP to a", $F1
    db "party monster.", $F1
    db $F0

String_95_00_1E:: ; heuristic: string; C0
Data_095_4D0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "May revive a dead", $F1
    db "monster.", $F1
    db $F0

String_95_00_1F:: ; heuristic: string; C0
Data_095_4D2A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F1
    db $F0

String_95_00_20:: ; heuristic: string; C0
Data_095_4D43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives dead mates", $F1
    db "in exchange for", $F1
    db "own life ", $A0, "all", $A1, ".", $F0

String_95_00_21:: ; heuristic: string; C0
Data_095_4D76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures one monster", $F1
    db "of poison.", $F1
    db $F0

String_95_00_22:: ; heuristic: string; C0
Data_095_4D94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Clears confusion", $F1
    db "in all party", $F1
    db "monsters.", $F0

String_95_00_23:: ; heuristic: string; C0
Data_095_4DBC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis", $F1
    db "and sleep ", $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_24:: ; heuristic: string; C0
Data_095_4DDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts a curse", $F1
    db $A0, "all", $A1, ".", $F1
    db $F0

String_95_00_25:: ; heuristic: string; C0
Data_095_4DF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF of one", $F1
    db "monster.", $F1
    db $F0

String_95_00_26:: ; heuristic: string; C0
Data_095_4E10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF of", $F1
    db "party monsters", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_27:: ; heuristic: string; C0
Data_095_4E34:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers DEF of one", $F1
    db "enemy.", $F1
    db $F0

String_95_00_28:: ; heuristic: string; C0
Data_095_4E4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers DEF of all", $F1
    db "enemy monsters.", $F1
    db $F0

String_95_00_29:: ; heuristic: string; C0
Data_095_4E71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL of one", $F1
    db "monster.", $F1
    db $F0

String_95_00_2A:: ; heuristic: string; C0
Data_095_4E8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL of", $F1
    db "party monsters", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_2B:: ; heuristic: string; C0
Data_095_4EB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers AGL of one", $F1
    db "enemy.", $F1
    db $F0

String_95_00_2C:: ; heuristic: string; C0
Data_095_4ECB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers AGL of all", $F1
    db "enemy monsters.", $F1
    db $F0

String_95_00_2D:: ; heuristic: string; C0
Data_095_4EEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles the ATK of", $F1
    db "one monster.", $F1
    db $F0

String_95_00_2E:: ; heuristic: string; C0
Data_095_4F0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surrounds all", $F1
    db "enemies in a", $F1
    db "mirage.", $F0

String_95_00_2F:: ; heuristic: string; C0
Data_095_4F32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes a single", $F1
    db "enemy sleep.", $F1
    db $F0

String_95_00_30:: ; heuristic: string; C0
Data_095_4F4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes all enemies", $F1
    db "sleep.", $F1
    db $F0

String_95_00_31:: ; heuristic: string; C0
Data_095_4F69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Absorbs the MP of", $F1
    db "a spell cast", $F1
    db "against the user.", $F0

String_95_00_32:: ; heuristic: string; C0
Data_095_4F9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Steals MP from an", $F1
    db "enemy.", $F1
    db $F0

String_95_00_33:: ; heuristic: string; C0
Data_095_4FB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents spell", $F1
    db "casting by all", $F1
    db "enemies.", $F0

String_95_00_34:: ; heuristic: string; C0
Data_095_4FDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Confuses all", $F1
    db "enemies.", $F1
    db $F0

String_95_00_35:: ; heuristic: string; C0
Data_095_4FF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Changes all party", $F1
    db "monsters into", $F1
    db "chunks of iron.", $F0

String_95_00_36:: ; heuristic: string; C0
Data_095_5022:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back a", $F1
    db "spell once.", $F1
    db $F0

String_95_00_37:: ; heuristic: string; C0
Data_095_503E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back all", $F1
    db "enemy spells.", $F1
    db $F0

String_95_00_38:: ; heuristic: string; C0
Data_095_505E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reduces damage", $F1
    db "from breath", $F1
    db "attacks ", $A0, "all", $A1, ".", $F0

String_95_00_39:: ; heuristic: string; C0
Data_095_5088:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises protection", $F1
    db "against magic", $F1
    db "spells ", $A0, "all", $A1, ".", $F0

String_95_00_3A:: ; heuristic: string; C0
Data_095_50B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms the", $F1
    db "user into a chosen", $F1
    db "enemy.", $F0

String_95_00_3B:: ; heuristic: string; C0
Data_095_50DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms the", $F1
    db "user into a", $F1
    db "ferocious dragon.", $F0

String_95_00_3C:: ; heuristic: string; C0
Data_095_510C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no", $F1
    db "telling what may", $F1
    db "happen.", $F0

String_95_00_3D:: ; heuristic: string; C0
Data_095_5131:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The ultimate", $F1
    db "attack spell.", $F1
    db $F0

String_95_00_3E:: ; heuristic: string; C0
Data_095_514D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates an", $F1
    db "enormous explosion", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_3F:: ; heuristic: string; C0
Data_095_5172:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strikes all", $F1
    db "enemies with huge", $F1
    db "lightning.", $F0

String_95_00_40:: ; heuristic: string; C0
Data_095_519B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a breath of", $F1
    db "fire ", $A0, "all", $A1, ".", $F0

String_95_00_41:: ; heuristic: string; C0
Data_095_51C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a blast of", $F1
    db "fire ", $A0, "all", $A1, ".", $F0

String_95_00_42:: ; heuristic: string; C0
Data_095_51F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a huge blast", $F1
    db "of fire ", $A0, "all", $A1, ".", $F0

String_95_00_43:: ; heuristic: string; C0
Data_095_5225:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with incredible", $F1
    db "fire ", $A0, "all", $A1, ".", $F0

String_95_00_44:: ; heuristic: string; C0
Data_095_5251:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a breath of", $F1
    db "ice ", $A0, "all", $A1, ".", $F0

String_95_00_45:: ; heuristic: string; C0
Data_095_527D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a freezing", $F1
    db "breath ", $A0, "all", $A1, ".", $F0

String_95_00_46:: ; heuristic: string; C0
Data_095_52AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage by", $F1
    db "exhaling a", $F1
    db "blizzard ", $A0, "all", $A1, ".", $F0

String_95_00_47:: ; heuristic: string; C0
Data_095_52D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Looses a white,", $F1
    db "shining breath of", $F1
    db "ice ", $A0, "all", $A1, ".", $F0

String_95_00_48:: ; heuristic: string; C0
Data_095_5306:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slashes a single", $F1
    db "monster with sharp", $F1
    db "whirlwinds.", $F0

String_95_00_49:: ; heuristic: string; C0
Data_095_5336:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates a tornado", $F1
    db "with vicious winds", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_4A:: ; heuristic: string; C0
Data_095_5362:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a", $F1
    db "lightning storm", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_4B:: ; heuristic: string; C0
Data_095_5383:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hurls giant", $F1
    db "boulders at", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_4C:: ; heuristic: string; C0
Data_095_53AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shoots a high", $F1
    db "volume of water at", $F1
    db "an enemy.", $F0

String_95_00_4D:: ; heuristic: string; C0
Data_095_53D5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a towering", $F1
    db "wall of water", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_4E:: ; heuristic: string; C0
Data_095_53FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons friends", $F1
    db "who attack in", $F1
    db "droves.", $F0

String_95_00_4F:: ; heuristic: string; C0
Data_095_5423:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a mass of", $F1
    db "friends that", $F1
    db "attack in droves.", $F0

String_95_00_50:: ; heuristic: string; C0
Data_095_5454:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A fiery sword", $F1
    db "attack.", $F1
    db $F0

String_95_00_51:: ; heuristic: string; C0
Data_095_546B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "enhanced by", $F1
    db "whirlwinds.", $F0

String_95_00_52:: ; heuristic: string; C0
Data_095_5492:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "made stronger by", $F1
    db "lightning.", $F0

String_95_00_53:: ; heuristic: string; C0
Data_095_54BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "made stronger by", $F1
    db "the power of ice.", $F0

String_95_00_54:: ; heuristic: string; C0
Data_095_54EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "slime family.", $F0

String_95_00_55:: ; heuristic: string; C0
Data_095_551B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "dragon family.", $F0

String_95_00_56:: ; heuristic: string; C0
Data_095_5548:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "beast family.", $F0

String_95_00_57:: ; heuristic: string; C0
Data_095_5574:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "bird family.", $F0

String_95_00_58:: ; heuristic: string; C0
Data_095_559F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "bug family.", $F0

String_95_00_59:: ; heuristic: string; C0
Data_095_55C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "plant family.", $F0

String_95_00_5A:: ; heuristic: string; C0
Data_095_55F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "devil family.", $F0

String_95_00_5B:: ; heuristic: string; C0
Data_095_5621:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "zombie family.", $F0

String_95_00_5C:: ; heuristic: string; C0
Data_095_564E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "material family.", $F0

String_95_00_5D:: ; heuristic: string; C0
Data_095_567D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "water family.", $F0

String_95_00_5E:: ; heuristic: string; C0
Data_095_56A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "on a high DEF", $F1
    db "enemy.", $F0

String_95_00_5F:: ; heuristic: string; C0
Data_095_56CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that may poison", $F1
    db "the target.", $F0

String_95_00_60:: ; heuristic: string; C0
Data_095_56FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that may paralyze", $F1
    db "the target.", $F0

String_95_00_61:: ; heuristic: string; C0
Data_095_572C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that may put the", $F1
    db "target to sleep.", $F0

String_95_00_62:: ; heuristic: string; C0
Data_095_5760:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that hits first.", $F1
    db $F0

String_95_00_63:: ; heuristic: string; C0
Data_095_5784:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that strikes twice", $F1
    db "in succession.", $F0

String_95_00_64:: ; heuristic: string; C0
Data_095_57B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that strikes four", $F1
    db "times.", $F0

String_95_00_65:: ; heuristic: string; C0
Data_095_57E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "that hits all", $F1
    db "enemies.", $F0, $F0

String_95_00_66:: ; heuristic: string; C0
Data_095_580A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A cross-cutting", $F1
    db "sword attack", $F1
    db $A0, "all", $A1, ".", $F0

String_95_00_67:: ; heuristic: string; C0
Data_095_582E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The ultimate sword", $F1
    db "attack.", $F1
    db $F0

String_95_00_68:: ; heuristic: string; C0
Data_095_584A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the next", $F1
    db "turn.", $F0

String_95_00_69:: ; heuristic: string; C0
Data_095_5873:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage at the end", $F1
    db "of the turn.", $F0

String_95_00_6A:: ; heuristic: string; C0
Data_095_58A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The user leaps and", $F1
    db "attacks in the", $F1
    db "next turn.", $F0

String_95_00_6B:: ; heuristic: string; C0
Data_095_58CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A powerful, but", $F1
    db "wildly aimed,", $F1
    db "sword attack.", $F0

String_95_00_6C:: ; heuristic: string; C0
Data_095_58FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on one", $F1
    db "friend or foe.", $F0

String_95_00_6D:: ; heuristic: string; C0
Data_095_5928:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage, but also", $F1
    db "hurts the user.", $F0

String_95_00_6E:: ; heuristic: string; C0
Data_095_5959:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A powerful attack", $F1
    db "that leaves the", $F1
    db "user vulnerable.", $F0

String_95_00_6F:: ; heuristic: string; C0
Data_095_598C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A full-body tackle", $F1
    db "that also hurts", $F1
    db "the user.", $F0

String_95_00_70:: ; heuristic: string; C0
Data_095_59B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Leaves the user", $F1
    db "and target on the", $F1
    db "verge of death.", $F0

String_95_00_71:: ; heuristic: string; C0
Data_095_59EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "induces sleep in", $F1
    db "all enemies.", $F0

String_95_00_72:: ; heuristic: string; C0
Data_095_5A17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "paralyzes all", $F1
    db "enemies.", $F0

String_95_00_73:: ; heuristic: string; C0
Data_095_5A3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "poisons all", $F1
    db "enemies.", $F0

String_95_00_74:: ; heuristic: string; C0
Data_095_5A5F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "badly poisons all", $F1
    db "enemies.", $F0

String_95_00_75:: ; heuristic: string; C0
Data_095_5A88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lays a curse on", $F1
    db "all enemies.", $F1
    db $F0

String_95_00_76:: ; heuristic: string; C0
Data_095_5AA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "reduces an enemy's", $F1
    db "MP.", $F0

String_95_00_77:: ; heuristic: string; C0
Data_095_5AC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "steals an enemy's", $F1
    db "MP.", $F0

String_95_00_78:: ; heuristic: string; C0
Data_095_5AEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "confuses all", $F1
    db "enemies.", $F0

String_95_00_79:: ; heuristic: string; C0
Data_095_5B0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "induces death in", $F1
    db "all enemies.", $F0

String_95_00_7A:: ; heuristic: string; C0
Data_095_5B39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that makes", $F1
    db "all enemies want", $F1
    db "to join in.", $F0

String_95_00_7B:: ; heuristic: string; C0
Data_095_5B69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sacrificial", $F1
    db "dance to revive", $F1
    db "dead friends.", $F0

String_95_00_7C:: ; heuristic: string; C0
Data_095_5B95:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "restores HP by", $F1
    db "70", $9D, "80 ", $A0, "all", $A1, ".", $F0

String_95_00_7D:: ; heuristic: string; C0
Data_095_5BBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A quick-footed", $F1
    db "skill for dodging", $F1
    db "attacks.", $F0

String_95_00_7E:: ; heuristic: string; C0
Data_095_5BE8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Obscures the", $F1
    db "visibility of all", $F1
    db "enemies.", $F0

String_95_00_7F:: ; heuristic: string; C0
Data_095_5C10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blast of light", $F1
    db "blinds all the", $F1
    db "enemies.", $F0

String_95_00_80:: ; heuristic: string; C0
Data_095_5C39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Weakens all", $F1
    db "enemies to magic", $F1
    db "spells.", $F0

String_95_00_81:: ; heuristic: string; C0
Data_095_5C5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eliminates all", $F1
    db "status problems", $F1
    db "among friends.", $F0

String_95_00_82:: ; heuristic: string; C0
Data_095_5C8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Greatly weakens an", $F1
    db "enemy.", $F1
    db $F0

String_95_00_83:: ; heuristic: string; C0
Data_095_5CA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts the effects", $F1
    db "of all spells on", $F1
    db "enemies ", $A0, "all", $A1, ".", $F0

String_95_00_84:: ; heuristic: string; C0
Data_095_5CD9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates a fog that", $F1
    db "prevents the use", $F1
    db "of all spells.", $F0

String_95_00_85:: ; heuristic: string; C0
Data_095_5D0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Tatsu to", $F1
    db "battle.", $F1
    db $F0

String_95_00_86:: ; heuristic: string; C0
Data_095_5D26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Diago to", $F1
    db "battle.", $F1
    db $F0

String_95_00_87:: ; heuristic: string; C0
Data_095_5D40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Samsi to", $F1
    db "battle.", $F1
    db $F0

String_95_00_88:: ; heuristic: string; C0
Data_095_5D5A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Bazoo to", $F1
    db "battle.", $F1
    db $F0

String_95_00_89:: ; heuristic: string; C0
Data_095_5D74:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Holds in a breath", $F1
    db "to inflict severe", $F1
    db "damage next turn.", $F0

String_95_00_8A:: ; heuristic: string; C0
Data_095_5DAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables two moves", $F1
    db "in the next turn.", $F1
    db $F0

String_95_00_8B:: ; heuristic: string; C0
Data_095_5DCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Licks one enemy to", $F1
    db "stop it for one", $F1
    db "turn.", $F0

String_95_00_8C:: ; heuristic: string; C0
Data_095_5DF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Licks one enemy to", $F1
    db "reduce its DEF.", $F1
    db $F0

String_95_00_8D:: ; heuristic: string; C0
Data_095_5E1C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sweeps the leg out", $F1
    db "from under one", $F1
    db "enemy.", $F0

String_95_00_8E:: ; heuristic: string; C0
Data_095_5E45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sweeps the legs", $F1
    db "out from under all", $F1
    db "enemies.", $F0

String_95_00_8F:: ; heuristic: string; C0
Data_095_5E71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soft, plushy and", $F1
    db "very pleasant.", $F1
    db $F0

String_95_00_90:: ; heuristic: string; C0
Data_095_5E92:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A terrifying cry", $F1
    db "that stops all", $F1
    db "enemies.", $F0

String_95_00_91:: ; heuristic: string; C0
Data_095_5EBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Opens a geyser to", $F1
    db "send an enemy", $F1
    db "flying.", $F0

String_95_00_92:: ; heuristic: string; C0
Data_095_5EE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents all", $F1
    db "enemies from", $F1
    db "dancing.", $F0

String_95_00_93:: ; heuristic: string; C0
Data_095_5F06:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents all", $F1
    db "enemies from using", $F1
    db "breath attacks.", $F0

String_95_00_94:: ; heuristic: string; C0
Data_095_5F36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strongly protects", $F1
    db "the user against", $F1
    db "all attacks.", $F0

String_95_00_95:: ; heuristic: string; C0
Data_095_5F66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Deflects any", $F1
    db "physical attack to", $F1
    db "another monster.", $F0

String_95_00_96:: ; heuristic: string; C0
Data_095_5F97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Protects the user", $F1
    db "and enables", $F1
    db "retaliation.", $F0

String_95_00_97:: ; heuristic: string; C0
Data_095_5FC2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Takes all attacks", $F1
    db "meant for another", $F1
    db "monster.", $F0

String_95_00_98:: ; heuristic: string; C0
Data_095_5FEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Takes all attacks", $F1
    db "meant for party", $F1
    db "monsters.", $F0

String_95_00_99:: ; heuristic: string; C0
Data_095_601B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back a", $F1
    db "breath attack to", $F1
    db "an enemy.", $F0

String_95_00_9A:: ; heuristic: string; C0
Data_095_6045:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back all", $F1
    db "breath attacks to", $F1
    db "all enemies.", $F0

String_95_00_9B:: ; heuristic: string; C0
Data_095_6075:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates a barrier", $F1
    db "that blocks an", $F1
    db "attack.", $F0

String_95_00_9C:: ; heuristic: string; C0
Data_095_609E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Seals a skill used", $F1
    db "by the enemy.", $F1
    db $F0

String_95_00_9D:: ; heuristic: string; C0
Data_095_60C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inhales all breath", $F1
    db "attacks meant for", $F1
    db "the party.", $F0

String_95_00_9E:: ; heuristic: string; C0
Data_095_60F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Imitates the", $F1
    db "enemy's moves.", $F1
    db $F0

String_95_00_9F:: ; heuristic: string; C0
Data_095_610C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Meditates to", $F1
    db "restore HP by 500.", $F1
    db $F0

String_95_00_A0:: ; heuristic: string; C0
Data_095_612D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives all dead", $F1
    db "friends in the", $F1
    db "next turn.", $F0

String_95_00_A1:: ; heuristic: string; C0
Data_095_6158:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons rain that", $F1
    db "restores HP.", $F1
    db $F0

String_95_00_A2:: ; heuristic: string; C0
Data_095_6178:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts enemy", $F1
    db "monsters.", $F1
    db $F0

String_95_00_A3:: ; heuristic: string; C0
Data_095_6192:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts enemy", $F1
    db "monsters of the", $F1
    db "opposite gender.", $F0

String_95_00_A4:: ; heuristic: string; C0
Data_095_61C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Protects the party", $F1
    db "from injurious", $F1
    db "terrain.", $F0

String_95_00_A5:: ; heuristic: string; C0
Data_095_61ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps", $F1
    db "the party out from", $F1
    db "caves and towers.", $F0

String_95_00_A6:: ; heuristic: string; C0
Data_095_6222:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Use to obtain", $F1
    db "information on", $F1
    db "monsters.", $F0

String_95_00_A7:: ; heuristic: string; C0
Data_095_6249:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the monster", $F1
    db "run an errand for", $F1
    db "100G.", $F0

String_95_00_A8:: ; heuristic: string; C0
Data_095_6273:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Determines the", $F1
    db "presence of items", $F1
    db "nearby.", $F0

String_95_00_A9:: ; heuristic: string; C0
Data_095_629C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks the", $F1
    db "surrounding area's", $F1
    db "terrain.", $F0

String_95_00_AA:: ; heuristic: string; C0
Data_095_62C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soft, plushy and", $F1
    db "very pleasant.", $F1
    db $F0

String_95_00_AB:: ; heuristic: string; C0
Data_095_62E3:: ; address name
    db $F0

String_95_01_00:: ; heuristic: string; C0
Data_095_62E4:: ; address name
    db $F0

String_95_02_00:: ; heuristic: string; C0
Data_095_62E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F1
    db $F0

String_95_02_01:: ; heuristic: string; C0
Data_095_62EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "VIT", $F1
    db "Belt", $F0

String_95_02_02:: ; heuristic: string; C0
Data_095_62F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Draco", $F1
    db "Belt", $F0

String_95_02_03:: ; heuristic: string; C0
Data_095_62FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic", $F1
    db "Belt", $F0

String_95_02_04:: ; heuristic: string; C0
Data_095_630A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Odd", $F1
    db "Belt", $F0

String_95_02_05:: ; heuristic: string; C0
Data_095_6313:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stone", $F1
    db "Fang", $F0

String_95_02_06:: ; heuristic: string; C0
Data_095_631E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Steel", $F1
    db "Fang", $F0

String_95_02_07:: ; heuristic: string; C0
Data_095_6329:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Merm", $F1
    db "Scale", $F0

String_95_02_08:: ; heuristic: string; C0
Data_095_6334:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drak", $F1
    db "Scale", $F0

String_95_02_09:: ; heuristic: string; C0
Data_095_633F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AGL", $F1
    db "Bangle", $F0

String_95_02_0A:: ; heuristic: string; C0
Data_095_634A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starry", $F1
    db "Bangle", $F0

String_95_02_0B:: ; heuristic: string; C0
Data_095_6358:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smart", $F1
    db "Hat", $F0

String_95_02_0C:: ; heuristic: string; C0
Data_095_6362:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wise", $F1
    db "Hat", $F0

String_95_02_0D:: ; heuristic: string; C0
Data_095_636B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic", $F1
    db "Cape", $F0

String_95_02_0E:: ; heuristic: string; C0
Data_095_6376:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Draco", $F1
    db "Cape", $F0

String_95_02_0F:: ; heuristic: string; C0
Data_095_6381:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Silver", $F1
    db "Cape", $F0

String_95_02_10:: ; heuristic: string; C0
Data_095_638D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gold", $F1
    db "Cape", $F0

String_95_02_11:: ; heuristic: string; C0
Data_095_6397:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pltnm", $F1
    db "Cape", $F0

String_95_02_12:: ; heuristic: string; C0
Data_095_63A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orca", $F1
    db "Cape", $F0

String_95_02_13:: ; heuristic: string; C0
Data_095_63AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brave", $F1
    db "Cape", $F0

String_95_02_14:: ; heuristic: string; C0
Data_095_63B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "D-", $F1
    db "Scale", $F0

String_95_02_15:: ; heuristic: string; C0
Data_095_63C0:: ; address name
    db $F1, $F0

String_95_02_1B:: ; heuristic: string; C0
Data_095_63C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Life", $F1
    db "Ring", $F0

String_95_02_1C:: ; heuristic: string; C0
Data_095_63CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divine", $F1
    db "Ring", $F0

String_95_02_1D:: ; heuristic: string; C0
Data_095_63D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "War", $F1
    db "Ring", $F0

String_95_02_1E:: ; heuristic: string; C0
Data_095_63E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mage", $F1
    db "Ring", $F0

String_95_02_1F:: ; heuristic: string; C0
Data_095_63EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fight", $F1
    db "Ring", $F0

String_95_02_20:: ; heuristic: string; C0
Data_095_63F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sailor", $F1
    db "Ring", $F0

String_95_02_21:: ; heuristic: string; C0
Data_095_6402:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thief", $F1
    db "Ring", $F0

String_95_02_22:: ; heuristic: string; C0
Data_095_640D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cleric", $F1
    db "Ring", $F0

String_95_02_23:: ; heuristic: string; C0
Data_095_6419:: ; address name
    db $F1, $F0

String_95_03_00:: ; heuristic: string; C0
Data_095_641B:: ; address name
    db $F0

String_95_04_00:: ; heuristic: string; C0
Data_095_641C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F1
    db $F0

String_95_04_01:: ; heuristic: string; C0
Data_095_6422:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Call", $F1
    db "ship", $F0

String_95_04_02:: ; heuristic: string; C0
Data_095_642C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Call", $F1
    db "cloud", $F0

String_95_04_03:: ; heuristic: string; C0
Data_095_6437:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smash", $F1
    db "rock", $F0

String_95_04_04:: ; heuristic: string; C0
Data_095_6442:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Burn", $F1
    db $F0

String_95_04_05:: ; heuristic: string; C0
Data_095_6448:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cut", $F1
    db $F0

String_95_04_06:: ; heuristic: string; C0
Data_095_644D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Open", $F1
    db "door", $F0

String_95_05_00:: ; heuristic: string; C0
Data_095_6457:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attack", $F0

String_95_05_02:: ; heuristic: string; C0
Data_095_645E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Charge", $F0

String_95_05_03:: ; heuristic: string; C0
Data_095_6465:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mixed", $F0

String_95_05_04:: ; heuristic: string; C0
Data_095_646B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cautious", $F0

String_95_05_05:: ; heuristic: string; C0
Data_095_6474:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Command", $F0

String_95_06_00:: ; heuristic: string; C0
Data_095_647C:: ; address name
    db $F0

String_95_07_01:: ; heuristic: string; C0
Data_095_647D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Charge", $F0

String_95_07_02:: ; heuristic: string; C0
Data_095_6484:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mixed", $F0

String_95_07_03:: ; heuristic: string; C0
Data_095_648A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cautious", $F0

String_95_07_04:: ; heuristic: string; C0
Data_095_6493:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZoneOut", $F0

String_95_07_05:: ; heuristic: string; C0
Data_095_649B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Chance", $F0

String_95_07_06:: ; heuristic: string; C0
Data_095_64A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Confusion", $F0

String_95_07_07:: ; heuristic: string; C0
Data_095_64AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

String_95_07_08:: ; heuristic: string; C0
Data_095_64B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Item", $F0

String_95_08_00:: ; heuristic: string; C0
Data_095_64B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No area", $F0

String_95_08_01:: ; heuristic: string; C0
Data_095_64BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1 enemy", $F0

String_95_08_02:: ; heuristic: string; C0
Data_095_64C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "All enemies", $F0

String_95_08_03:: ; heuristic: string; C0
Data_095_64D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Foes multi-hit", $F0

String_95_08_04:: ; heuristic: string; C0
Data_095_64E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1 friend", $F0

String_95_08_05:: ; heuristic: string; C0
Data_095_64EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "All friends", $F0

String_95_08_06:: ; heuristic: string; C0
Data_095_64F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose 1", $F0

String_95_08_07:: ; heuristic: string; C0
Data_095_64FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose all", $F0

String_95_08_08:: ; heuristic: string; C0
Data_095_650A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Self", $F0

String_95_08_09:: ; heuristic: string; C0
Data_095_650F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "All", $F0

String_95_08_0A:: ; heuristic: string; C0
Data_095_6513:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Random", $F0

String_95_09_00:: ; heuristic: string; C0
Data_095_651A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F0

String_95_09_01:: ; heuristic: string; C0
Data_095_651F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blaze", $F0

String_95_09_02:: ; heuristic: string; C0
Data_095_6525:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Firebal", $F0

String_95_09_03:: ; heuristic: string; C0
Data_095_652D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bang", $F0

String_95_09_04:: ; heuristic: string; C0
Data_095_6532:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Infernos", $F0

String_95_09_05:: ; heuristic: string; C0
Data_095_653B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bolt", $F0

String_95_09_06:: ; heuristic: string; C0
Data_095_6540:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceBolt", $F0

String_95_09_07:: ; heuristic: string; C0
Data_095_6548:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surround", $F0

String_95_09_08:: ; heuristic: string; C0
Data_095_6551:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sleep", $F0

String_95_09_09:: ; heuristic: string; C0
Data_095_6557:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beat", $F0

String_95_09_0A:: ; heuristic: string; C0
Data_095_655C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RobMagic", $F0

String_95_09_0B:: ; heuristic: string; C0
Data_095_6565:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StopSpell", $F0

String_95_09_0C:: ; heuristic: string; C0
Data_095_656F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PanicAll", $F0

String_95_09_0D:: ; heuristic: string; C0
Data_095_6578:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sap", $F0

String_95_09_0E:: ; heuristic: string; C0
Data_095_657C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlowAll", $F0

String_95_09_0F:: ; heuristic: string; C0
Data_095_6584:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sacrifice", $F0

String_95_09_10:: ; heuristic: string; C0
Data_095_658E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MegaMagic", $F0

String_95_09_11:: ; heuristic: string; C0
Data_095_6598:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fire", $F0

String_95_09_12:: ; heuristic: string; C0
Data_095_659D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blizzard", $F0

String_95_09_13:: ; heuristic: string; C0
Data_095_65A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poison", $F0

String_95_09_14:: ; heuristic: string; C0
Data_095_65AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Paralysis", $F0

String_95_09_15:: ; heuristic: string; C0
Data_095_65B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Curse", $F0

String_95_09_16:: ; heuristic: string; C0
Data_095_65BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rest", $F0

String_95_09_17:: ; heuristic: string; C0
Data_095_65C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dance", $F0

String_95_09_18:: ; heuristic: string; C0
Data_095_65C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breath", $F0

String_95_09_19:: ; heuristic: string; C0
Data_095_65CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Friend", $F0

String_95_09_1A:: ; heuristic: string; C0
Data_095_65D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bash", $F0

String_95_09_1B:: ; heuristic: string; C0
Data_095_65DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

String_95_0A_00:: ; heuristic: string; C0
Data_095_65E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type A", $F0

String_95_0A_01:: ; heuristic: string; C0
Data_095_65E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type B", $F0

String_95_0A_02:: ; heuristic: string; C0
Data_095_65EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type C", $F0

String_95_0A_03:: ; heuristic: string; C0
Data_095_65F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type D", $F0

String_95_0A_04:: ; heuristic: string; C0
Data_095_65FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type E", $F0

String_95_0A_05:: ; heuristic: string; C0
Data_095_6604:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type F", $F0

String_95_0A_06:: ; heuristic: string; C0
Data_095_660B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type G", $F0

String_95_0A_07:: ; heuristic: string; C0
Data_095_6612:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type H", $F0

String_95_0B_00:: ; heuristic: string; C0
Data_095_6619:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F0

String_95_0B_01:: ; heuristic: string; C0
Data_095_661E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battle", $F0

String_95_0B_02:: ; heuristic: string; C0
Data_095_6625:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Field", $F0

String_95_0B_03:: ; heuristic: string; C0
Data_095_662B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Anytime", $F0
    ds $19CD, $00
