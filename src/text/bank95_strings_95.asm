; ROM bank $95: string tables
; The annotated listing of this bank is build/listing/bank95.asm.

SECTION "Bank 95", ROMX[$4000], BANK[$95]
    db $95

; compressed tileset of map $4E (the first map record using it)
; LZSS-compressed: 513 bytes that expand to 1280 (E-0016, E-0017)
Map4ETileset::
    INCBIN "maps/map4_e/tileset.lz"

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map4EScreens0::
    dfar Map4EScreens0_Y0X0 ; entry 0
    dfar Map4EScreens0_Y1X0 ; entry 1
    dfar Map4EScreens0_Y2X0 ; entry 2

Map4EAttrs0::
    dfar Map4EAttrs0_Y0X0 ; entry 0
    dfar Map4EAttrs0_Y1X0 ; entry 1
    dfar Map4EAttrs0_Y2X0 ; entry 2

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
Map4EScreens0_Y0X0::
    INCBIN "maps/map4_e/screens0_y0_x0.lz"

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
Map4EScreens0_Y1X0::
    db $68, $01, $01, $01, $ff, $f2, $10, $19, $40, $41, $40, $41, $18, $11, $01, $fa
    db $f8, $12, $1b, $01, $08, $00, $1a, $13, $01, $fa, $ff, $4d, $01, $5a, $0f, $4d
    db $01, $ba, $0f, $4d, $01, $f2, $0f, $13

Map4EScreens0_Y2X0::
    INCBIN "maps/map4_e/screens0_y2_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map4EAttrs0_Y0X0::
    INCBIN "maps/map4_e/attrs0_y0_x0.lz"

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
Map4EAttrs0_Y1X0::
    db $68, $01, $02, $02, $ff, $f2, $01, $01, $03, $03, $03, $03, $01, $01, $02, $fa
    db $ff, $4d, $02, $5a, $0f, $4d, $02, $ba, $0f, $4d, $02, $06, $1f, $27

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map4EAttrs0_Y2X0::
    INCBIN "maps/map4_e/attrs0_y2_x0.lz"

; compressed tileset of map $92 (the first map record using it)
; LZSS-compressed: 411 bytes that expand to 464 (E-0016, E-0017)
Map92Tileset::
    INCBIN "maps/map92/tileset.lz"

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map92Screens0::
    dfar Map92Screens0_Y0X0 ; entry 0

Map92Attrs0::
    dfar Map92Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map92Screens0_Y0X0::
    INCBIN "maps/map92/screens0_y0_x0.lz"

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map92Attrs0_Y0X0::
    db $68, $01, $02, $03, $02, $00, $0f, $18, $01, $02, $2c, $07, $02, $24, $0f, $07
    db $02, $2c, $08, $02, $34, $04, $02, $52, $0f, $2f, $00, $00, $02, $96, $0f, $13
    db $02, $58, $0f, $37, $02, $2a, $0f, $15, $02, $28, $08, $02, $20, $0f, $01, $02
    db $00, $02

; Starts a string of category wStringCategory - 9 from this bank's categories (the ones after bank
; $08's nine). (C1, E-0357)
BeginStringDisplay_Bank08_Overflow::
    ld de, StringCategories_Bank95
    ld a, [wStringCategory]
    sub $09
    ld [wStringCategory], a
    call BeginStringDisplay
    ret

; Copies a string of category wStringCategory - 9 from this bank's categories to the buffer
; (CopyStringToBuffer). (C2, E-0357; probed E-0385)
CopyStringToBuffer_Bank08_Overflow::
    ld de, StringCategories_Bank95
    ld a, [wStringCategory]
    sub $09
    ld [wStringCategory], a
    call CopyStringToBuffer
    ret
    db $cd, $50, $46, $cd, $11, $26, $c9

; A table of twelve words, one per string category $09-$14 of the shared string scheme (index
; wStringCategory - 9): lists of 176, 1, 36, 1, 7, 6, 2, 9, 11, 28, 8 and 4 string pointers, named
; StringTable95_Cat09_SkillDescriptions, StringTable95_Cat0A, StringTable95_Cat0B,
; StringTable95_Cat0C_FieldActions, StringTable_FieldAbilities, StringTable95_Cat0E_Tactics,
; StringTable95_Cat0F, StringTable95_Cat10, StringTable95_Cat11_Targets,
; StringTable95_Cat12_SkillFamilies, StringTable95_Cat13_SkillTypes and StringTable95_Cat14_Usable.
; BeginStringDisplay_Bank08_Overflow and CopyStringToBuffer_Bank08_Overflow subtract 9 from
; wStringCategory and pass the table in DE to BeginStringDisplay and CopyStringToBuffer. (C1,
; E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_Bank95::
    dw StringTable95_Cat09_SkillDescriptions ; id 0
    dw StringTable95_Cat0A ; id 1
    dw StringTable95_Cat0B ; id 2
    dw StringTable95_Cat0C_FieldActions ; id 3
    dw StringTable_FieldAbilities ; id 4
    dw StringTable95_Cat0E_Tactics ; id 5
    dw StringTable95_Cat0F ; id 6
    dw StringTable95_Cat10 ; id 7
    dw StringTable95_Cat11_Targets ; id 8
    dw StringTable95_Cat12_SkillFamilies ; id 9
    dw StringTable95_Cat13_SkillTypes ; id 10
    dw StringTable95_Cat14_Usable ; id 11

; string table of category $09 (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): skill descriptions, for example 'Attacks an enemy with a fireball'
; (E-0033)
; category list of StringCategories_Bank95; one pointer per wStringIndex (E-0217)
; record: string
StringTable95_Cat09_SkillDescriptions::
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

; string table of category $0A (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): two-line names such as 'VIT Belt', 'Draco Belt', 'Stone Fang' (the
; table at $47EF is the same list one entry later) (E-0033)
StringTable95_Cat0A::
    dw String_95_01_00 ; id 0

; string table of category $0B (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): the same names as category $0A without the blank first entry
; (E-0033)
StringTable95_Cat0B::
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

; string table of category $0C (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): short two-line phrases such as 'Call ship', 'Call cloud', 'Smash
; rock', 'Burn', 'Cut', 'Open door' (E-0033)
; category list of StringCategories_Bank95; one pointer per wStringIndex (E-0217)
; record: string
StringTable95_Cat0C_FieldActions::
    dw String_95_03_00 ; id 0

; string category $0D (bank $95 category 4): the field abilities indexed by species byte $0B
; (SPECIES_FIELD_ABILITY): None, Call ship, Call cloud, Smash rock, Burn, Cut, Open door (E-0313)
StringTable_FieldAbilities::
    dw String_95_04_00 ; id 0
    dw String_95_04_01 ; id 1
    dw String_95_04_02 ; id 2
    dw String_95_04_03 ; id 3
    dw String_95_04_04 ; id 4
    dw String_95_04_05 ; id 5
    dw String_95_04_06 ; id 6

; string table of category $0E (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'Attack', 'Charge', 'Mixed', 'Cautious', 'Command' (E-0033)
StringTable95_Cat0E_Tactics::
    dw String_95_05_00 ; id 0
    dw String_95_05_00 ; id 1
    dw String_95_05_02 ; id 2
    dw String_95_05_03 ; id 3
    dw String_95_05_04 ; id 4
    dw String_95_05_05 ; id 5

; string table of category $0F (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'Charge', 'Mixed', 'Cautious', 'ZoneOut' (overlaps category $0E)
; (E-0033)
; category list of StringCategories_Bank95; one pointer per wStringIndex (E-0217)
; record: string
StringTable95_Cat0F::
    dw String_95_06_00 ; id 0
    dw String_95_06_00 ; id 1

; string table of category $10 (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'Charge', 'Mixed', 'Cautious', 'ZoneOut', 'Chance', 'Confusion',
; shown for the high nibble of a skill record's byte 3 (E-0033)
StringTable95_Cat10::
    dw String_95_06_00 ; id 0
    dw String_95_07_01 ; id 1
    dw String_95_07_02 ; id 2
    dw String_95_07_03 ; id 3
    dw String_95_07_04 ; id 4
    dw String_95_07_05 ; id 5
    dw String_95_07_06 ; id 6
    dw String_95_07_07 ; id 7
    dw String_95_07_08 ; id 8

; string table of category $11 (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'No area', '1 enemy', 'All enemies', 'Foes multi-hit', '1 friend',
; 'All friends', 'Choose 1' (E-0033)
StringTable95_Cat11_Targets::
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

; string table of category $12 (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'None', 'Blaze', 'Firebal', 'Bang', 'Infernos', 'Bolt', 'IceBolt'
; (E-0033)
; category list of StringCategories_Bank95; one pointer per wStringIndex (E-0217)
; record: string
StringTable95_Cat12_SkillFamilies::
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

; string table of category $13 (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'Type A' ... 'Type G' (E-0033)
StringTable95_Cat13_SkillTypes::
    dw String_95_0A_00 ; id 0
    dw String_95_0A_01 ; id 1
    dw String_95_0A_02 ; id 2
    dw String_95_0A_03 ; id 3
    dw String_95_0A_04 ; id 4
    dw String_95_0A_05 ; id 5
    dw String_95_0A_06 ; id 6
    dw String_95_0A_07 ; id 7

; string table of category $14 (the string database extension in bank $95, selected when
; wStringCategory is 9 or more): 'None', 'Battle', 'Field', 'Anytime' (E-0033)
StringTable95_Cat14_Usable::
    dw String_95_0B_00 ; id 0
    dw String_95_0B_01 ; id 1
    dw String_95_0B_02 ; id 2
    dw String_95_0B_03 ; id 3

String_95_00_00::
    db "Attacks an enemy<LINE>"
    db "with a fireball.<LINE>"
    db "@"

String_95_00_02::
    db "Attacks an enemy<LINE>"
    db "with a large<LINE>"
    db "fireball.@"

String_95_00_03::
    db "A towering pillar<LINE>"
    db "of fire roasts an<LINE>"
    db "enemy.@"

String_95_00_04::
    db "Attacks enemies<LINE>"
    db "with a blast of<LINE>"
    db "fire (all).@"

String_95_00_05::
    db "Attacks enemies<LINE>"
    db "with a wall of<LINE>"
    db "fire (all).@"

String_95_00_06::
    db "A huge wall of<LINE>"
    db "fire incinerates<LINE>"
    db "enemies (all).@"

String_95_00_07::
    db "Small explosions<LINE>"
    db "strike enemies<LINE>"
    db "(all).@"

String_95_00_08::
    db "A succession of<LINE>"
    db "explosions strikes<LINE>"
    db "enemies (all).@"

String_95_00_09::
    db "Huge explosions<LINE>"
    db "blast enemies<LINE>"
    db "(all).@"

String_95_00_0A::
    db "Razor sharp<LINE>"
    db "whirlwinds slash<LINE>"
    db "enemies (all).@"

String_95_00_0B::
    db "Twisters tear<LINE>"
    db "through enemies<LINE>"
    db "(all).@"

String_95_00_0C::
    db "A huge tornado<LINE>"
    db "roars through<LINE>"
    db "enemies (all).@"
    db " "

String_95_00_0D::
    db "Lightning strikes<LINE>"
    db "enemies (all).<LINE>"
    db "@"

String_95_00_0E::
    db "Powerful bolts of<LINE>"
    db "lightning lash<LINE>"
    db "enemies (all).@"

String_95_00_0F::
    db "Huge shards of<LINE>"
    db "lightning rip<LINE>"
    db "enemies (all).@"

String_95_00_10::
    db "Small chunks of<LINE>"
    db "ice hail down on<LINE>"
    db "enemies (all).@"

String_95_00_11::
    db "Enemies are flash<LINE>"
    db "frozen (all).<LINE>"
    db "@"

String_95_00_12::
    db "A wicked blizzard<LINE>"
    db "howls through<LINE>"
    db "enemies (all).@"

String_95_00_13::
    db "Instantly slays an<LINE>"
    db "enemy.<LINE>"
    db "@"

String_95_00_14::
    db "Instantly slays<LINE>"
    db "enemies (all).<LINE>"
    db "@"

String_95_00_15::
    db "The user explodes<LINE>"
    db "to inflict damage<LINE>"
    db "on all enemies.@"

String_95_00_16::
    db "Restores HP by<LINE>"
    db "30~40.<LINE>"
    db "@"

String_95_00_17::
    db "Restores HP by<LINE>"
    db "75~90.<LINE>"
    db "@"

String_95_00_18::
    db "Fully restores<LINE>"
    db "HP.<LINE>"
    db "@"

String_95_00_19::
    db "Restores HP by<LINE>"
    db "90~120 (all).<LINE>"
    db "@"

String_95_00_1A::
    db "Fully restores HP<LINE>"
    db "(all).<LINE>"
    db "@"

String_95_00_1B::
    db "Gives 15MP to a<LINE>"
    db "party monster.<LINE>"
    db "@"

String_95_00_1C::
    db "Gives 30MP to a<LINE>"
    db "party monster.<LINE>"
    db "@"

String_95_00_1D::
    db "Gives 80MP to a<LINE>"
    db "party monster.<LINE>"
    db "@"

String_95_00_1E::
    db "May revive a dead<LINE>"
    db "monster.<LINE>"
    db "@"

String_95_00_1F::
    db "Revives a dead<LINE>"
    db "monster.<LINE>"
    db "@"

String_95_00_20::
    db "Revives dead mates<LINE>"
    db "in exchange for<LINE>"
    db "own life (all).@"

String_95_00_21::
    db "Cures one monster<LINE>"
    db "of poison.<LINE>"
    db "@"

String_95_00_22::
    db "Clears confusion<LINE>"
    db "in all party<LINE>"
    db "monsters.@"

String_95_00_23::
    db "Cures paralysis<LINE>"
    db "and sleep (all).<LINE>"
    db "@"

String_95_00_24::
    db "Lifts a curse<LINE>"
    db "(all).<LINE>"
    db "@"

String_95_00_25::
    db "Raises DEF of one<LINE>"
    db "monster.<LINE>"
    db "@"

String_95_00_26::
    db "Raises DEF of<LINE>"
    db "party monsters<LINE>"
    db "(all).@"

String_95_00_27::
    db "Lowers DEF of one<LINE>"
    db "enemy.<LINE>"
    db "@"

String_95_00_28::
    db "Lowers DEF of all<LINE>"
    db "enemy monsters.<LINE>"
    db "@"

String_95_00_29::
    db "Raises AGL of one<LINE>"
    db "monster.<LINE>"
    db "@"

String_95_00_2A::
    db "Raises AGL of<LINE>"
    db "party monsters<LINE>"
    db "(all).@"

String_95_00_2B::
    db "Lowers AGL of one<LINE>"
    db "enemy.<LINE>"
    db "@"

String_95_00_2C::
    db "Lowers AGL of all<LINE>"
    db "enemy monsters.<LINE>"
    db "@"

String_95_00_2D::
    db "Doubles the ATK of<LINE>"
    db "one monster.<LINE>"
    db "@"

String_95_00_2E::
    db "Surrounds all<LINE>"
    db "enemies in a<LINE>"
    db "mirage.@"

String_95_00_2F::
    db "Makes a single<LINE>"
    db "enemy sleep.<LINE>"
    db "@"

String_95_00_30::
    db "Makes all enemies<LINE>"
    db "sleep.<LINE>"
    db "@"

String_95_00_31::
    db "Absorbs the MP of<LINE>"
    db "a spell cast<LINE>"
    db "against the user.@"

String_95_00_32::
    db "Steals MP from an<LINE>"
    db "enemy.<LINE>"
    db "@"

String_95_00_33::
    db "Prevents spell<LINE>"
    db "casting by all<LINE>"
    db "enemies.@"

String_95_00_34::
    db "Confuses all<LINE>"
    db "enemies.<LINE>"
    db "@"

String_95_00_35::
    db "Changes all party<LINE>"
    db "monsters into<LINE>"
    db "chunks of iron.@"

String_95_00_36::
    db "Bounces back a<LINE>"
    db "spell once.<LINE>"
    db "@"

String_95_00_37::
    db "Bounces back all<LINE>"
    db "enemy spells.<LINE>"
    db "@"

String_95_00_38::
    db "Reduces damage<LINE>"
    db "from breath<LINE>"
    db "attacks (all).@"

String_95_00_39::
    db "Raises protection<LINE>"
    db "against magic<LINE>"
    db "spells (all).@"

String_95_00_3A::
    db "Transforms the<LINE>"
    db "user into a chosen<LINE>"
    db "enemy.@"

String_95_00_3B::
    db "Transforms the<LINE>"
    db "user into a<LINE>"
    db "ferocious dragon.@"

String_95_00_3C::
    db "There is no<LINE>"
    db "telling what may<LINE>"
    db "happen.@"

String_95_00_3D::
    db "The ultimate<LINE>"
    db "attack spell.<LINE>"
    db "@"

String_95_00_3E::
    db "Creates an<LINE>"
    db "enormous explosion<LINE>"
    db "(all).@"

String_95_00_3F::
    db "Strikes all<LINE>"
    db "enemies with huge<LINE>"
    db "lightning.@"

String_95_00_40::
    db "Inflicts damage<LINE>"
    db "with a breath of<LINE>"
    db "fire (all).@"

String_95_00_41::
    db "Inflicts damage<LINE>"
    db "with a blast of<LINE>"
    db "fire (all).@"

String_95_00_42::
    db "Inflicts damage<LINE>"
    db "with a huge blast<LINE>"
    db "of fire (all).@"

String_95_00_43::
    db "Inflicts damage<LINE>"
    db "with incredible<LINE>"
    db "fire (all).@"

String_95_00_44::
    db "Inflicts damage<LINE>"
    db "with a breath of<LINE>"
    db "ice (all).@"

String_95_00_45::
    db "Inflicts damage<LINE>"
    db "with a freezing<LINE>"
    db "breath (all).@"

String_95_00_46::
    db "Inflicts damage by<LINE>"
    db "exhaling a<LINE>"
    db "blizzard (all).@"

String_95_00_47::
    db "Looses a white,<LINE>"
    db "shining breath of<LINE>"
    db "ice (all).@"

String_95_00_48::
    db "Slashes a single<LINE>"
    db "monster with sharp<LINE>"
    db "whirlwinds.@"

String_95_00_49::
    db "Creates a tornado<LINE>"
    db "with vicious winds<LINE>"
    db "(all).@"

String_95_00_4A::
    db "Summons a<LINE>"
    db "lightning storm<LINE>"
    db "(all).@"

String_95_00_4B::
    db "Hurls giant<LINE>"
    db "boulders at<LINE>"
    db "enemies (all).@"

String_95_00_4C::
    db "Shoots a high<LINE>"
    db "volume of water at<LINE>"
    db "an enemy.@"

String_95_00_4D::
    db "Summons a towering<LINE>"
    db "wall of water<LINE>"
    db "(all).@"

String_95_00_4E::
    db "Summons friends<LINE>"
    db "who attack in<LINE>"
    db "droves.@"

String_95_00_4F::
    db "Summons a mass of<LINE>"
    db "friends that<LINE>"
    db "attack in droves.@"

String_95_00_50::
    db "A fiery sword<LINE>"
    db "attack.<LINE>"
    db "@"

String_95_00_51::
    db "A sword attack<LINE>"
    db "enhanced by<LINE>"
    db "whirlwinds.@"

String_95_00_52::
    db "A sword attack<LINE>"
    db "made stronger by<LINE>"
    db "lightning.@"

String_95_00_53::
    db "A sword attack<LINE>"
    db "made stronger by<LINE>"
    db "the power of ice.@"

String_95_00_54::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "slime family.@"

String_95_00_55::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "dragon family.@"

String_95_00_56::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "beast family.@"

String_95_00_57::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "bird family.@"

String_95_00_58::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "bug family.@"

String_95_00_59::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "plant family.@"

String_95_00_5A::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "devil family.@"

String_95_00_5B::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "zombie family.@"

String_95_00_5C::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "material family.@"

String_95_00_5D::
    db "Inflicts severe<LINE>"
    db "damage on the<LINE>"
    db "water family.@"

String_95_00_5E::
    db "Inflicts damage<LINE>"
    db "on a high DEF<LINE>"
    db "enemy.@"

String_95_00_5F::
    db "A physical attack<LINE>"
    db "that may poison<LINE>"
    db "the target.@"

String_95_00_60::
    db "A physical attack<LINE>"
    db "that may paralyze<LINE>"
    db "the target.@"

String_95_00_61::
    db "A physical attack<LINE>"
    db "that may put the<LINE>"
    db "target to sleep.@"

String_95_00_62::
    db "A physical attack<LINE>"
    db "that hits first.<LINE>"
    db "@"

String_95_00_63::
    db "A physical attack<LINE>"
    db "that strikes twice<LINE>"
    db "in succession.@"

String_95_00_64::
    db "A physical attack<LINE>"
    db "that strikes four<LINE>"
    db "times.@"

String_95_00_65::
    db "A sword attack<LINE>"
    db "that hits all<LINE>"
    db "enemies.@"
    db "@"

String_95_00_66::
    db "A cross-cutting<LINE>"
    db "sword attack<LINE>"
    db "(all).@"

String_95_00_67::
    db "The ultimate sword<LINE>"
    db "attack.<LINE>"
    db "@"

String_95_00_68::
    db "Inflicts severe<LINE>"
    db "damage on the next<LINE>"
    db "turn.@"

String_95_00_69::
    db "Inflicts severe<LINE>"
    db "damage at the end<LINE>"
    db "of the turn.@"

String_95_00_6A::
    db "The user leaps and<LINE>"
    db "attacks in the<LINE>"
    db "next turn.@"

String_95_00_6B::
    db "A powerful, but<LINE>"
    db "wildly aimed,<LINE>"
    db "sword attack.@"

String_95_00_6C::
    db "Inflicts severe<LINE>"
    db "damage on one<LINE>"
    db "friend or foe.@"

String_95_00_6D::
    db "Inflicts severe<LINE>"
    db "damage, but also<LINE>"
    db "hurts the user.@"

String_95_00_6E::
    db "A powerful attack<LINE>"
    db "that leaves the<LINE>"
    db "user vulnerable.@"

String_95_00_6F::
    db "A full-body tackle<LINE>"
    db "that also hurts<LINE>"
    db "the user.@"

String_95_00_70::
    db "Leaves the user<LINE>"
    db "and target on the<LINE>"
    db "verge of death.@"

String_95_00_71::
    db "A breath that<LINE>"
    db "induces sleep in<LINE>"
    db "all enemies.@"

String_95_00_72::
    db "A breath that<LINE>"
    db "paralyzes all<LINE>"
    db "enemies.@"

String_95_00_73::
    db "A breath that<LINE>"
    db "poisons all<LINE>"
    db "enemies.@"

String_95_00_74::
    db "A breath that<LINE>"
    db "badly poisons all<LINE>"
    db "enemies.@"

String_95_00_75::
    db "Lays a curse on<LINE>"
    db "all enemies.<LINE>"
    db "@"

String_95_00_76::
    db "A dance that<LINE>"
    db "reduces an enemy's<LINE>"
    db "MP.@"

String_95_00_77::
    db "A dance that<LINE>"
    db "steals an enemy's<LINE>"
    db "MP.@"

String_95_00_78::
    db "A dance that<LINE>"
    db "confuses all<LINE>"
    db "enemies.@"

String_95_00_79::
    db "A dance that<LINE>"
    db "induces death in<LINE>"
    db "all enemies.@"

String_95_00_7A::
    db "A dance that makes<LINE>"
    db "all enemies want<LINE>"
    db "to join in.@"

String_95_00_7B::
    db "A sacrificial<LINE>"
    db "dance to revive<LINE>"
    db "dead friends.@"

String_95_00_7C::
    db "A dance that<LINE>"
    db "restores HP by<LINE>"
    db "70~80 (all).@"

String_95_00_7D::
    db "A quick-footed<LINE>"
    db "skill for dodging<LINE>"
    db "attacks.@"

String_95_00_7E::
    db "Obscures the<LINE>"
    db "visibility of all<LINE>"
    db "enemies.@"

String_95_00_7F::
    db "A blast of light<LINE>"
    db "blinds all the<LINE>"
    db "enemies.@"

String_95_00_80::
    db "Weakens all<LINE>"
    db "enemies to magic<LINE>"
    db "spells.@"

String_95_00_81::
    db "Eliminates all<LINE>"
    db "status problems<LINE>"
    db "among friends.@"

String_95_00_82::
    db "Greatly weakens an<LINE>"
    db "enemy.<LINE>"
    db "@"

String_95_00_83::
    db "Lifts the effects<LINE>"
    db "of all spells on<LINE>"
    db "enemies (all).@"

String_95_00_84::
    db "Creates a fog that<LINE>"
    db "prevents the use<LINE>"
    db "of all spells.@"

String_95_00_85::
    db "Summons Tatsu to<LINE>"
    db "battle.<LINE>"
    db "@"

String_95_00_86::
    db "Summons Diago to<LINE>"
    db "battle.<LINE>"
    db "@"

String_95_00_87::
    db "Summons Samsi to<LINE>"
    db "battle.<LINE>"
    db "@"

String_95_00_88::
    db "Summons Bazoo to<LINE>"
    db "battle.<LINE>"
    db "@"

String_95_00_89::
    db "Holds in a breath<LINE>"
    db "to inflict severe<LINE>"
    db "damage next turn.@"

String_95_00_8A::
    db "Enables two moves<LINE>"
    db "in the next turn.<LINE>"
    db "@"

String_95_00_8B::
    db "Licks one enemy to<LINE>"
    db "stop it for one<LINE>"
    db "turn.@"

String_95_00_8C::
    db "Licks one enemy to<LINE>"
    db "reduce its DEF.<LINE>"
    db "@"

String_95_00_8D::
    db "Sweeps the leg out<LINE>"
    db "from under one<LINE>"
    db "enemy.@"

String_95_00_8E::
    db "Sweeps the legs<LINE>"
    db "out from under all<LINE>"
    db "enemies.@"

String_95_00_8F::
    db "Soft, plushy and<LINE>"
    db "very pleasant.<LINE>"
    db "@"

String_95_00_90::
    db "A terrifying cry<LINE>"
    db "that stops all<LINE>"
    db "enemies.@"

String_95_00_91::
    db "Opens a geyser to<LINE>"
    db "send an enemy<LINE>"
    db "flying.@"

String_95_00_92::
    db "Prevents all<LINE>"
    db "enemies from<LINE>"
    db "dancing.@"

String_95_00_93::
    db "Prevents all<LINE>"
    db "enemies from using<LINE>"
    db "breath attacks.@"

String_95_00_94::
    db "Strongly protects<LINE>"
    db "the user against<LINE>"
    db "all attacks.@"

String_95_00_95::
    db "Deflects any<LINE>"
    db "physical attack to<LINE>"
    db "another monster.@"

String_95_00_96::
    db "Protects the user<LINE>"
    db "and enables<LINE>"
    db "retaliation.@"

String_95_00_97::
    db "Takes all attacks<LINE>"
    db "meant for another<LINE>"
    db "monster.@"

String_95_00_98::
    db "Takes all attacks<LINE>"
    db "meant for party<LINE>"
    db "monsters.@"

String_95_00_99::
    db "Bounces back a<LINE>"
    db "breath attack to<LINE>"
    db "an enemy.@"

String_95_00_9A::
    db "Bounces back all<LINE>"
    db "breath attacks to<LINE>"
    db "all enemies.@"

String_95_00_9B::
    db "Creates a barrier<LINE>"
    db "that blocks an<LINE>"
    db "attack.@"

String_95_00_9C::
    db "Seals a skill used<LINE>"
    db "by the enemy.<LINE>"
    db "@"

String_95_00_9D::
    db "Inhales all breath<LINE>"
    db "attacks meant for<LINE>"
    db "the party.@"

String_95_00_9E::
    db "Imitates the<LINE>"
    db "enemy's moves.<LINE>"
    db "@"

String_95_00_9F::
    db "Meditates to<LINE>"
    db "restore HP by 500.<LINE>"
    db "@"

String_95_00_A0::
    db "Revives all dead<LINE>"
    db "friends in the<LINE>"
    db "next turn.@"

String_95_00_A1::
    db "Summons rain that<LINE>"
    db "restores HP.<LINE>"
    db "@"

String_95_00_A2::
    db "Attracts enemy<LINE>"
    db "monsters.<LINE>"
    db "@"

String_95_00_A3::
    db "Attracts enemy<LINE>"
    db "monsters of the<LINE>"
    db "opposite gender.@"

String_95_00_A4::
    db "Protects the party<LINE>"
    db "from injurious<LINE>"
    db "terrain.@"

String_95_00_A5::
    db "Instantly warps<LINE>"
    db "the party out from<LINE>"
    db "caves and towers.@"

String_95_00_A6::
    db "Use to obtain<LINE>"
    db "information on<LINE>"
    db "monsters.@"

String_95_00_A7::
    db "Makes the monster<LINE>"
    db "run an errand for<LINE>"
    db "100G.@"

String_95_00_A8::
    db "Determines the<LINE>"
    db "presence of items<LINE>"
    db "nearby.@"

String_95_00_A9::
    db "Checks the<LINE>"
    db "surrounding area's<LINE>"
    db "terrain.@"

String_95_00_AA::
    db "Soft, plushy and<LINE>"
    db "very pleasant.<LINE>"
    db "@"

String_95_00_AB::
    db $f0

String_95_01_00::
    db $f0

String_95_02_00::
    db "None<LINE>"
    db "@"

String_95_02_01::
    db "VIT<LINE>"
    db "Belt@"

String_95_02_02::
    db "Draco<LINE>"
    db "Belt@"

String_95_02_03::
    db "Magic<LINE>"
    db "Belt@"

String_95_02_04::
    db "Odd<LINE>"
    db "Belt@"

String_95_02_05::
    db "Stone<LINE>"
    db "Fang@"

String_95_02_06::
    db "Steel<LINE>"
    db "Fang@"

String_95_02_07::
    db "Merm<LINE>"
    db "Scale@"

String_95_02_08::
    db "Drak<LINE>"
    db "Scale@"

String_95_02_09::
    db "AGL<LINE>"
    db "Bangle@"

String_95_02_0A::
    db "Starry<LINE>"
    db "Bangle@"

String_95_02_0B::
    db "Smart<LINE>"
    db "Hat@"

String_95_02_0C::
    db "Wise<LINE>"
    db "Hat@"

String_95_02_0D::
    db "Magic<LINE>"
    db "Cape@"

String_95_02_0E::
    db "Draco<LINE>"
    db "Cape@"

String_95_02_0F::
    db "Silver<LINE>"
    db "Cape@"

String_95_02_10::
    db "Gold<LINE>"
    db "Cape@"

String_95_02_11::
    db "Pltnm<LINE>"
    db "Cape@"

String_95_02_12::
    db "Orca<LINE>"
    db "Cape@"

String_95_02_13::
    db "Brave<LINE>"
    db "Cape@"

String_95_02_14::
    db "D-<LINE>"
    db "Scale@"

String_95_02_15::
    db $f1, $f0

String_95_02_1B::
    db "Life<LINE>"
    db "Ring@"

String_95_02_1C::
    db "Divine<LINE>"
    db "Ring@"

String_95_02_1D::
    db "War<LINE>"
    db "Ring@"

String_95_02_1E::
    db "Mage<LINE>"
    db "Ring@"

String_95_02_1F::
    db "Fight<LINE>"
    db "Ring@"

String_95_02_20::
    db "Sailor<LINE>"
    db "Ring@"

String_95_02_21::
    db "Thief<LINE>"
    db "Ring@"

String_95_02_22::
    db "Cleric<LINE>"
    db "Ring@"

String_95_02_23::
    db $f1, $f0

String_95_03_00::
    db $f0

String_95_04_00::
    db "None<LINE>"
    db "@"

String_95_04_01::
    db "Call<LINE>"
    db "ship@"

String_95_04_02::
    db "Call<LINE>"
    db "cloud@"

String_95_04_03::
    db "Smash<LINE>"
    db "rock@"

String_95_04_04::
    db "Burn<LINE>"
    db "@"

String_95_04_05::
    db "Cut<LINE>"
    db "@"

String_95_04_06::
    db "Open<LINE>"
    db "door@"

String_95_05_00::
    db "Attack@"

String_95_05_02::
    db "Charge@"

String_95_05_03::
    db "Mixed@"

String_95_05_04::
    db "Cautious@"

String_95_05_05::
    db "Command@"

String_95_06_00::
    db $f0

String_95_07_01::
    db "Charge@"

String_95_07_02::
    db "Mixed@"

String_95_07_03::
    db "Cautious@"

String_95_07_04::
    db "ZoneOut@"

String_95_07_05::
    db "Chance@"

String_95_07_06::
    db "Confusion@"

String_95_07_07::
    db "Auto@"

String_95_07_08::
    db "Item@"

String_95_08_00::
    db "No area@"

String_95_08_01::
    db "1 enemy@"

String_95_08_02::
    db "All enemies@"

String_95_08_03::
    db "Foes multi-hit@"

String_95_08_04::
    db "1 friend@"

String_95_08_05::
    db "All friends@"

String_95_08_06::
    db "Choose 1@"

String_95_08_07::
    db "Choose all@"

String_95_08_08::
    db "Self@"

String_95_08_09::
    db "All@"

String_95_08_0A::
    db "Random@"

String_95_09_00::
    db "None@"

String_95_09_01::
    db "Blaze@"

String_95_09_02::
    db "Firebal@"

String_95_09_03::
    db "Bang@"

String_95_09_04::
    db "Infernos@"

String_95_09_05::
    db "Bolt@"

String_95_09_06::
    db "IceBolt@"

String_95_09_07::
    db "Surround@"

String_95_09_08::
    db "Sleep@"

String_95_09_09::
    db "Beat@"

String_95_09_0A::
    db "RobMagic@"

String_95_09_0B::
    db "StopSpell@"

String_95_09_0C::
    db "PanicAll@"

String_95_09_0D::
    db "Sap@"

String_95_09_0E::
    db "SlowAll@"

String_95_09_0F::
    db "Sacrifice@"

String_95_09_10::
    db "MegaMagic@"

String_95_09_11::
    db "Fire@"

String_95_09_12::
    db "Blizzard@"

String_95_09_13::
    db "Poison@"

String_95_09_14::
    db "Paralysis@"

String_95_09_15::
    db "Curse@"

String_95_09_16::
    db "Rest@"

String_95_09_17::
    db "Dance@"

String_95_09_18::
    db "Breath@"

String_95_09_19::
    db "Friend@"

String_95_09_1A::
    db "Bash@"

String_95_09_1B::
    db "Water@"

String_95_0A_00::
    db "Type A@"

String_95_0A_01::
    db "Type B@"

String_95_0A_02::
    db "Type C@"

String_95_0A_03::
    db "Type D@"

String_95_0A_04::
    db "Type E@"

String_95_0A_05::
    db "Type F@"

String_95_0A_06::
    db "Type G@"

String_95_0A_07::
    db "Type H@"

String_95_0B_00::
    db "None@"

String_95_0B_01::
    db "Battle@"

String_95_0B_02::
    db "Field@"

String_95_0B_03::
    db "Anytime@"
    ds $19cd, $00
