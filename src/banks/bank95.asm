SECTION "Bank 95", ROMX[$4000], BANK[$95]
    db $95

; compressed tileset of map $4E (the first map record using it)
; LZSS-compressed: 513 bytes that expand to 1280 (E-0016, E-0017)
Map4ETileset::
    INCBIN "dwm2-cobi-us.gbc", $254001, $201

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
    INCBIN "dwm2-cobi-us.gbc", $254214, $78

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
Map4EScreens0_Y1X0::
    db $68, $01, $01, $01, $ff, $f2, $10, $19, $40, $41, $40, $41, $18, $11, $01, $fa
    db $f8, $12, $1b, $01, $08, $00, $1a, $13, $01, $fa, $ff, $4d, $01, $5a, $0f, $4d
    db $01, $ba, $0f, $4d, $01, $f2, $0f, $13

Map4EScreens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $2542B4, $78

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map4EAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $25432C, $4A

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
Map4EAttrs0_Y1X0::
    db $68, $01, $02, $02, $ff, $f2, $01, $01, $03, $03, $03, $03, $01, $01, $02, $fa
    db $ff, $4d, $02, $5a, $0f, $4d, $02, $ba, $0f, $4d, $02, $06, $1f, $27

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map4EAttrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $254394, $52

; compressed tileset of map $92 (the first map record using it)
; LZSS-compressed: 411 bytes that expand to 464 (E-0016, E-0017)
Map92Tileset::
    INCBIN "dwm2-cobi-us.gbc", $2543E6, $19B

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map92Screens0::
    dfar Map92Screens0_Y0X0 ; entry 0

Map92Attrs0::
    dfar Map92Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map92Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $254587, $97

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map92Attrs0_Y0X0::
    db $68, $01, $02, $03, $02, $00, $0f, $18, $01, $02, $2c, $07, $02, $24, $0f, $07
    db $02, $2c, $08, $02, $34, $04, $02, $52, $0f, $2f, $00, $00, $02, $96, $0f, $13
    db $02, $58, $0f, $37, $02, $2a, $0f, $15, $02, $28, $08, $02, $20, $0f, $01, $02
    db $00, $02

BeginStringDisplay_Bank08_BeginStringDisplay::
    ld de, StringCategories_95_4675
    ld a, [wStringCategory]
    sub $09
    ld [wStringCategory], a
    call BeginStringDisplay
    ret

CopyStringToBuffer_Bank08_CopyStringToBuffer::
    ld de, StringCategories_95_4675
    ld a, [wStringCategory]
    sub $09
    ld [wStringCategory], a
    call CopyStringToBuffer
    ret
    db $cd, $50, $46, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_95_4675::
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

; category list of StringCategories_95_4675; one pointer per wStringIndex (E-0217)
; record: string
StringList_95_468D::
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

StringList_95_47ED::
StringTable95_Cat0A::
    dw String_95_01_00 ; id 0

StringList_95_47EF::
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

StringList_95_4837::
StringTable95_Cat0C_FieldActions::
    dw String_95_03_00 ; id 0

StringList_95_4839::
StringTable_FieldAbilities::
    dw String_95_04_00 ; id 0
    dw String_95_04_01 ; id 1
    dw String_95_04_02 ; id 2
    dw String_95_04_03 ; id 3
    dw String_95_04_04 ; id 4
    dw String_95_04_05 ; id 5
    dw String_95_04_06 ; id 6

StringList_95_4847::
StringTable95_Cat0E_Tactics::
    dw String_95_05_00 ; id 0
    dw String_95_05_00 ; id 1
    dw String_95_05_02 ; id 2
    dw String_95_05_03 ; id 3
    dw String_95_05_04 ; id 4
    dw String_95_05_05 ; id 5

StringList_95_4853::
StringTable95_Cat0F::
    dw String_95_06_00 ; id 0
    dw String_95_06_00 ; id 1

StringList_95_4857::
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

StringList_95_4869::
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

StringList_95_487F::
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

StringList_95_48B7::
StringTable95_Cat13_SkillTypes::
    dw String_95_0A_00 ; id 0
    dw String_95_0A_01 ; id 1
    dw String_95_0A_02 ; id 2
    dw String_95_0A_03 ; id 3
    dw String_95_0A_04 ; id 4
    dw String_95_0A_05 ; id 5
    dw String_95_0A_06 ; id 6
    dw String_95_0A_07 ; id 7

StringList_95_48C7::
StringTable95_Cat14_Usable::
    dw String_95_0B_00 ; id 0
    dw String_95_0B_01 ; id 1
    dw String_95_0B_02 ; id 2
    dw String_95_0B_03 ; id 3

String_95_00_00::
    db "Attacks an enemy", $f1
    db "with a fireball.", $f1
    db $f0

String_95_00_02::
    db "Attacks an enemy", $f1
    db "with a large", $f1
    db "fireball.", $f0

String_95_00_03::
    db "A towering pillar", $f1
    db "of fire roasts an", $f1
    db "enemy.", $f0

String_95_00_04::
    db "Attacks enemies", $f1
    db "with a blast of", $f1
    db "fire ", $a0, "all", $a1, ".", $f0

String_95_00_05::
    db "Attacks enemies", $f1
    db "with a wall of", $f1
    db "fire ", $a0, "all", $a1, ".", $f0

String_95_00_06::
    db "A huge wall of", $f1
    db "fire incinerates", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_07::
    db "Small explosions", $f1
    db "strike enemies", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_08::
    db "A succession of", $f1
    db "explosions strikes", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_09::
    db "Huge explosions", $f1
    db "blast enemies", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_0A::
    db "Razor sharp", $f1
    db "whirlwinds slash", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_0B::
    db "Twisters tear", $f1
    db "through enemies", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_0C::
    db "A huge tornado", $f1
    db "roars through", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0, " "

String_95_00_0D::
    db "Lightning strikes", $f1
    db "enemies ", $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_0E::
    db "Powerful bolts of", $f1
    db "lightning lash", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_0F::
    db "Huge shards of", $f1
    db "lightning rip", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_10::
    db "Small chunks of", $f1
    db "ice hail down on", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_11::
    db "Enemies are flash", $f1
    db "frozen ", $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_12::
    db "A wicked blizzard", $f1
    db "howls through", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_13::
    db "Instantly slays an", $f1
    db "enemy.", $f1
    db $f0

String_95_00_14::
    db "Instantly slays", $f1
    db "enemies ", $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_15::
    db "The user explodes", $f1
    db "to inflict damage", $f1
    db "on all enemies.", $f0

String_95_00_16::
    db "Restores HP by", $f1
    db "30", $9d, "40.", $f1
    db $f0

String_95_00_17::
    db "Restores HP by", $f1
    db "75", $9d, "90.", $f1
    db $f0

String_95_00_18::
    db "Fully restores", $f1
    db "HP.", $f1
    db $f0

String_95_00_19::
    db "Restores HP by", $f1
    db "90", $9d, "120 ", $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_1A::
    db "Fully restores HP", $f1
    db $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_1B::
    db "Gives 15MP to a", $f1
    db "party monster.", $f1
    db $f0

String_95_00_1C::
    db "Gives 30MP to a", $f1
    db "party monster.", $f1
    db $f0

String_95_00_1D::
    db "Gives 80MP to a", $f1
    db "party monster.", $f1
    db $f0

String_95_00_1E::
    db "May revive a dead", $f1
    db "monster.", $f1
    db $f0

String_95_00_1F::
    db "Revives a dead", $f1
    db "monster.", $f1
    db $f0

String_95_00_20::
    db "Revives dead mates", $f1
    db "in exchange for", $f1
    db "own life ", $a0, "all", $a1, ".", $f0

String_95_00_21::
    db "Cures one monster", $f1
    db "of poison.", $f1
    db $f0

String_95_00_22::
    db "Clears confusion", $f1
    db "in all party", $f1
    db "monsters.", $f0

String_95_00_23::
    db "Cures paralysis", $f1
    db "and sleep ", $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_24::
    db "Lifts a curse", $f1
    db $a0, "all", $a1, ".", $f1
    db $f0

String_95_00_25::
    db "Raises DEF of one", $f1
    db "monster.", $f1
    db $f0

String_95_00_26::
    db "Raises DEF of", $f1
    db "party monsters", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_27::
    db "Lowers DEF of one", $f1
    db "enemy.", $f1
    db $f0

String_95_00_28::
    db "Lowers DEF of all", $f1
    db "enemy monsters.", $f1
    db $f0

String_95_00_29::
    db "Raises AGL of one", $f1
    db "monster.", $f1
    db $f0

String_95_00_2A::
    db "Raises AGL of", $f1
    db "party monsters", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_2B::
    db "Lowers AGL of one", $f1
    db "enemy.", $f1
    db $f0

String_95_00_2C::
    db "Lowers AGL of all", $f1
    db "enemy monsters.", $f1
    db $f0

String_95_00_2D::
    db "Doubles the ATK of", $f1
    db "one monster.", $f1
    db $f0

String_95_00_2E::
    db "Surrounds all", $f1
    db "enemies in a", $f1
    db "mirage.", $f0

String_95_00_2F::
    db "Makes a single", $f1
    db "enemy sleep.", $f1
    db $f0

String_95_00_30::
    db "Makes all enemies", $f1
    db "sleep.", $f1
    db $f0

String_95_00_31::
    db "Absorbs the MP of", $f1
    db "a spell cast", $f1
    db "against the user.", $f0

String_95_00_32::
    db "Steals MP from an", $f1
    db "enemy.", $f1
    db $f0

String_95_00_33::
    db "Prevents spell", $f1
    db "casting by all", $f1
    db "enemies.", $f0

String_95_00_34::
    db "Confuses all", $f1
    db "enemies.", $f1
    db $f0

String_95_00_35::
    db "Changes all party", $f1
    db "monsters into", $f1
    db "chunks of iron.", $f0

String_95_00_36::
    db "Bounces back a", $f1
    db "spell once.", $f1
    db $f0

String_95_00_37::
    db "Bounces back all", $f1
    db "enemy spells.", $f1
    db $f0

String_95_00_38::
    db "Reduces damage", $f1
    db "from breath", $f1
    db "attacks ", $a0, "all", $a1, ".", $f0

String_95_00_39::
    db "Raises protection", $f1
    db "against magic", $f1
    db "spells ", $a0, "all", $a1, ".", $f0

String_95_00_3A::
    db "Transforms the", $f1
    db "user into a chosen", $f1
    db "enemy.", $f0

String_95_00_3B::
    db "Transforms the", $f1
    db "user into a", $f1
    db "ferocious dragon.", $f0

String_95_00_3C::
    db "There is no", $f1
    db "telling what may", $f1
    db "happen.", $f0

String_95_00_3D::
    db "The ultimate", $f1
    db "attack spell.", $f1
    db $f0

String_95_00_3E::
    db "Creates an", $f1
    db "enormous explosion", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_3F::
    db "Strikes all", $f1
    db "enemies with huge", $f1
    db "lightning.", $f0

String_95_00_40::
    db "Inflicts damage", $f1
    db "with a breath of", $f1
    db "fire ", $a0, "all", $a1, ".", $f0

String_95_00_41::
    db "Inflicts damage", $f1
    db "with a blast of", $f1
    db "fire ", $a0, "all", $a1, ".", $f0

String_95_00_42::
    db "Inflicts damage", $f1
    db "with a huge blast", $f1
    db "of fire ", $a0, "all", $a1, ".", $f0

String_95_00_43::
    db "Inflicts damage", $f1
    db "with incredible", $f1
    db "fire ", $a0, "all", $a1, ".", $f0

String_95_00_44::
    db "Inflicts damage", $f1
    db "with a breath of", $f1
    db "ice ", $a0, "all", $a1, ".", $f0

String_95_00_45::
    db "Inflicts damage", $f1
    db "with a freezing", $f1
    db "breath ", $a0, "all", $a1, ".", $f0

String_95_00_46::
    db "Inflicts damage by", $f1
    db "exhaling a", $f1
    db "blizzard ", $a0, "all", $a1, ".", $f0

String_95_00_47::
    db "Looses a white,", $f1
    db "shining breath of", $f1
    db "ice ", $a0, "all", $a1, ".", $f0

String_95_00_48::
    db "Slashes a single", $f1
    db "monster with sharp", $f1
    db "whirlwinds.", $f0

String_95_00_49::
    db "Creates a tornado", $f1
    db "with vicious winds", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_4A::
    db "Summons a", $f1
    db "lightning storm", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_4B::
    db "Hurls giant", $f1
    db "boulders at", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_4C::
    db "Shoots a high", $f1
    db "volume of water at", $f1
    db "an enemy.", $f0

String_95_00_4D::
    db "Summons a towering", $f1
    db "wall of water", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_4E::
    db "Summons friends", $f1
    db "who attack in", $f1
    db "droves.", $f0

String_95_00_4F::
    db "Summons a mass of", $f1
    db "friends that", $f1
    db "attack in droves.", $f0

String_95_00_50::
    db "A fiery sword", $f1
    db "attack.", $f1
    db $f0

String_95_00_51::
    db "A sword attack", $f1
    db "enhanced by", $f1
    db "whirlwinds.", $f0

String_95_00_52::
    db "A sword attack", $f1
    db "made stronger by", $f1
    db "lightning.", $f0

String_95_00_53::
    db "A sword attack", $f1
    db "made stronger by", $f1
    db "the power of ice.", $f0

String_95_00_54::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "slime family.", $f0

String_95_00_55::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "dragon family.", $f0

String_95_00_56::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "beast family.", $f0

String_95_00_57::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "bird family.", $f0

String_95_00_58::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "bug family.", $f0

String_95_00_59::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "plant family.", $f0

String_95_00_5A::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "devil family.", $f0

String_95_00_5B::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "zombie family.", $f0

String_95_00_5C::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "material family.", $f0

String_95_00_5D::
    db "Inflicts severe", $f1
    db "damage on the", $f1
    db "water family.", $f0

String_95_00_5E::
    db "Inflicts damage", $f1
    db "on a high DEF", $f1
    db "enemy.", $f0

String_95_00_5F::
    db "A physical attack", $f1
    db "that may poison", $f1
    db "the target.", $f0

String_95_00_60::
    db "A physical attack", $f1
    db "that may paralyze", $f1
    db "the target.", $f0

String_95_00_61::
    db "A physical attack", $f1
    db "that may put the", $f1
    db "target to sleep.", $f0

String_95_00_62::
    db "A physical attack", $f1
    db "that hits first.", $f1
    db $f0

String_95_00_63::
    db "A physical attack", $f1
    db "that strikes twice", $f1
    db "in succession.", $f0

String_95_00_64::
    db "A physical attack", $f1
    db "that strikes four", $f1
    db "times.", $f0

String_95_00_65::
    db "A sword attack", $f1
    db "that hits all", $f1
    db "enemies.", $f0, $f0

String_95_00_66::
    db "A cross-cutting", $f1
    db "sword attack", $f1
    db $a0, "all", $a1, ".", $f0

String_95_00_67::
    db "The ultimate sword", $f1
    db "attack.", $f1
    db $f0

String_95_00_68::
    db "Inflicts severe", $f1
    db "damage on the next", $f1
    db "turn.", $f0

String_95_00_69::
    db "Inflicts severe", $f1
    db "damage at the end", $f1
    db "of the turn.", $f0

String_95_00_6A::
    db "The user leaps and", $f1
    db "attacks in the", $f1
    db "next turn.", $f0

String_95_00_6B::
    db "A powerful, but", $f1
    db "wildly aimed,", $f1
    db "sword attack.", $f0

String_95_00_6C::
    db "Inflicts severe", $f1
    db "damage on one", $f1
    db "friend or foe.", $f0

String_95_00_6D::
    db "Inflicts severe", $f1
    db "damage, but also", $f1
    db "hurts the user.", $f0

String_95_00_6E::
    db "A powerful attack", $f1
    db "that leaves the", $f1
    db "user vulnerable.", $f0

String_95_00_6F::
    db "A full-body tackle", $f1
    db "that also hurts", $f1
    db "the user.", $f0

String_95_00_70::
    db "Leaves the user", $f1
    db "and target on the", $f1
    db "verge of death.", $f0

String_95_00_71::
    db "A breath that", $f1
    db "induces sleep in", $f1
    db "all enemies.", $f0

String_95_00_72::
    db "A breath that", $f1
    db "paralyzes all", $f1
    db "enemies.", $f0

String_95_00_73::
    db "A breath that", $f1
    db "poisons all", $f1
    db "enemies.", $f0

String_95_00_74::
    db "A breath that", $f1
    db "badly poisons all", $f1
    db "enemies.", $f0

String_95_00_75::
    db "Lays a curse on", $f1
    db "all enemies.", $f1
    db $f0

String_95_00_76::
    db "A dance that", $f1
    db "reduces an enemy's", $f1
    db "MP.", $f0

String_95_00_77::
    db "A dance that", $f1
    db "steals an enemy's", $f1
    db "MP.", $f0

String_95_00_78::
    db "A dance that", $f1
    db "confuses all", $f1
    db "enemies.", $f0

String_95_00_79::
    db "A dance that", $f1
    db "induces death in", $f1
    db "all enemies.", $f0

String_95_00_7A::
    db "A dance that makes", $f1
    db "all enemies want", $f1
    db "to join in.", $f0

String_95_00_7B::
    db "A sacrificial", $f1
    db "dance to revive", $f1
    db "dead friends.", $f0

String_95_00_7C::
    db "A dance that", $f1
    db "restores HP by", $f1
    db "70", $9d, "80 ", $a0, "all", $a1, ".", $f0

String_95_00_7D::
    db "A quick-footed", $f1
    db "skill for dodging", $f1
    db "attacks.", $f0

String_95_00_7E::
    db "Obscures the", $f1
    db "visibility of all", $f1
    db "enemies.", $f0

String_95_00_7F::
    db "A blast of light", $f1
    db "blinds all the", $f1
    db "enemies.", $f0

String_95_00_80::
    db "Weakens all", $f1
    db "enemies to magic", $f1
    db "spells.", $f0

String_95_00_81::
    db "Eliminates all", $f1
    db "status problems", $f1
    db "among friends.", $f0

String_95_00_82::
    db "Greatly weakens an", $f1
    db "enemy.", $f1
    db $f0

String_95_00_83::
    db "Lifts the effects", $f1
    db "of all spells on", $f1
    db "enemies ", $a0, "all", $a1, ".", $f0

String_95_00_84::
    db "Creates a fog that", $f1
    db "prevents the use", $f1
    db "of all spells.", $f0

String_95_00_85::
    db "Summons Tatsu to", $f1
    db "battle.", $f1
    db $f0

String_95_00_86::
    db "Summons Diago to", $f1
    db "battle.", $f1
    db $f0

String_95_00_87::
    db "Summons Samsi to", $f1
    db "battle.", $f1
    db $f0

String_95_00_88::
    db "Summons Bazoo to", $f1
    db "battle.", $f1
    db $f0

String_95_00_89::
    db "Holds in a breath", $f1
    db "to inflict severe", $f1
    db "damage next turn.", $f0

String_95_00_8A::
    db "Enables two moves", $f1
    db "in the next turn.", $f1
    db $f0

String_95_00_8B::
    db "Licks one enemy to", $f1
    db "stop it for one", $f1
    db "turn.", $f0

String_95_00_8C::
    db "Licks one enemy to", $f1
    db "reduce its DEF.", $f1
    db $f0

String_95_00_8D::
    db "Sweeps the leg out", $f1
    db "from under one", $f1
    db "enemy.", $f0

String_95_00_8E::
    db "Sweeps the legs", $f1
    db "out from under all", $f1
    db "enemies.", $f0

String_95_00_8F::
    db "Soft, plushy and", $f1
    db "very pleasant.", $f1
    db $f0

String_95_00_90::
    db "A terrifying cry", $f1
    db "that stops all", $f1
    db "enemies.", $f0

String_95_00_91::
    db "Opens a geyser to", $f1
    db "send an enemy", $f1
    db "flying.", $f0

String_95_00_92::
    db "Prevents all", $f1
    db "enemies from", $f1
    db "dancing.", $f0

String_95_00_93::
    db "Prevents all", $f1
    db "enemies from using", $f1
    db "breath attacks.", $f0

String_95_00_94::
    db "Strongly protects", $f1
    db "the user against", $f1
    db "all attacks.", $f0

String_95_00_95::
    db "Deflects any", $f1
    db "physical attack to", $f1
    db "another monster.", $f0

String_95_00_96::
    db "Protects the user", $f1
    db "and enables", $f1
    db "retaliation.", $f0

String_95_00_97::
    db "Takes all attacks", $f1
    db "meant for another", $f1
    db "monster.", $f0

String_95_00_98::
    db "Takes all attacks", $f1
    db "meant for party", $f1
    db "monsters.", $f0

String_95_00_99::
    db "Bounces back a", $f1
    db "breath attack to", $f1
    db "an enemy.", $f0

String_95_00_9A::
    db "Bounces back all", $f1
    db "breath attacks to", $f1
    db "all enemies.", $f0

String_95_00_9B::
    db "Creates a barrier", $f1
    db "that blocks an", $f1
    db "attack.", $f0

String_95_00_9C::
    db "Seals a skill used", $f1
    db "by the enemy.", $f1
    db $f0

String_95_00_9D::
    db "Inhales all breath", $f1
    db "attacks meant for", $f1
    db "the party.", $f0

String_95_00_9E::
    db "Imitates the", $f1
    db "enemy's moves.", $f1
    db $f0

String_95_00_9F::
    db "Meditates to", $f1
    db "restore HP by 500.", $f1
    db $f0

String_95_00_A0::
    db "Revives all dead", $f1
    db "friends in the", $f1
    db "next turn.", $f0

String_95_00_A1::
    db "Summons rain that", $f1
    db "restores HP.", $f1
    db $f0

String_95_00_A2::
    db "Attracts enemy", $f1
    db "monsters.", $f1
    db $f0

String_95_00_A3::
    db "Attracts enemy", $f1
    db "monsters of the", $f1
    db "opposite gender.", $f0

String_95_00_A4::
    db "Protects the party", $f1
    db "from injurious", $f1
    db "terrain.", $f0

String_95_00_A5::
    db "Instantly warps", $f1
    db "the party out from", $f1
    db "caves and towers.", $f0

String_95_00_A6::
    db "Use to obtain", $f1
    db "information on", $f1
    db "monsters.", $f0

String_95_00_A7::
    db "Makes the monster", $f1
    db "run an errand for", $f1
    db "100G.", $f0

String_95_00_A8::
    db "Determines the", $f1
    db "presence of items", $f1
    db "nearby.", $f0

String_95_00_A9::
    db "Checks the", $f1
    db "surrounding area's", $f1
    db "terrain.", $f0

String_95_00_AA::
    db "Soft, plushy and", $f1
    db "very pleasant.", $f1
    db $f0

String_95_00_AB::
    db $f0

String_95_01_00::
    db $f0

String_95_02_00::
    db "None", $f1
    db $f0

String_95_02_01::
    db "VIT", $f1
    db "Belt", $f0

String_95_02_02::
    db "Draco", $f1
    db "Belt", $f0

String_95_02_03::
    db "Magic", $f1
    db "Belt", $f0

String_95_02_04::
    db "Odd", $f1
    db "Belt", $f0

String_95_02_05::
    db "Stone", $f1
    db "Fang", $f0

String_95_02_06::
    db "Steel", $f1
    db "Fang", $f0

String_95_02_07::
    db "Merm", $f1
    db "Scale", $f0

String_95_02_08::
    db "Drak", $f1
    db "Scale", $f0

String_95_02_09::
    db "AGL", $f1
    db "Bangle", $f0

String_95_02_0A::
    db "Starry", $f1
    db "Bangle", $f0

String_95_02_0B::
    db "Smart", $f1
    db "Hat", $f0

String_95_02_0C::
    db "Wise", $f1
    db "Hat", $f0

String_95_02_0D::
    db "Magic", $f1
    db "Cape", $f0

String_95_02_0E::
    db "Draco", $f1
    db "Cape", $f0

String_95_02_0F::
    db "Silver", $f1
    db "Cape", $f0

String_95_02_10::
    db "Gold", $f1
    db "Cape", $f0

String_95_02_11::
    db "Pltnm", $f1
    db "Cape", $f0

String_95_02_12::
    db "Orca", $f1
    db "Cape", $f0

String_95_02_13::
    db "Brave", $f1
    db "Cape", $f0

String_95_02_14::
    db "D-", $f1
    db "Scale", $f0

String_95_02_15::
    db $f1, $f0

String_95_02_1B::
    db "Life", $f1
    db "Ring", $f0

String_95_02_1C::
    db "Divine", $f1
    db "Ring", $f0

String_95_02_1D::
    db "War", $f1
    db "Ring", $f0

String_95_02_1E::
    db "Mage", $f1
    db "Ring", $f0

String_95_02_1F::
    db "Fight", $f1
    db "Ring", $f0

String_95_02_20::
    db "Sailor", $f1
    db "Ring", $f0

String_95_02_21::
    db "Thief", $f1
    db "Ring", $f0

String_95_02_22::
    db "Cleric", $f1
    db "Ring", $f0

String_95_02_23::
    db $f1, $f0

String_95_03_00::
    db $f0

String_95_04_00::
    db "None", $f1
    db $f0

String_95_04_01::
    db "Call", $f1
    db "ship", $f0

String_95_04_02::
    db "Call", $f1
    db "cloud", $f0

String_95_04_03::
    db "Smash", $f1
    db "rock", $f0

String_95_04_04::
    db "Burn", $f1
    db $f0

String_95_04_05::
    db "Cut", $f1
    db $f0

String_95_04_06::
    db "Open", $f1
    db "door", $f0

String_95_05_00::
    db "Attack", $f0

String_95_05_02::
    db "Charge", $f0

String_95_05_03::
    db "Mixed", $f0

String_95_05_04::
    db "Cautious", $f0

String_95_05_05::
    db "Command", $f0

String_95_06_00::
    db $f0

String_95_07_01::
    db "Charge", $f0

String_95_07_02::
    db "Mixed", $f0

String_95_07_03::
    db "Cautious", $f0

String_95_07_04::
    db "ZoneOut", $f0

String_95_07_05::
    db "Chance", $f0

String_95_07_06::
    db "Confusion", $f0

String_95_07_07::
    db "Auto", $f0

String_95_07_08::
    db "Item", $f0

String_95_08_00::
    db "No area", $f0

String_95_08_01::
    db "1 enemy", $f0

String_95_08_02::
    db "All enemies", $f0

String_95_08_03::
    db "Foes multi-hit", $f0

String_95_08_04::
    db "1 friend", $f0

String_95_08_05::
    db "All friends", $f0

String_95_08_06::
    db "Choose 1", $f0

String_95_08_07::
    db "Choose all", $f0

String_95_08_08::
    db "Self", $f0

String_95_08_09::
    db "All", $f0

String_95_08_0A::
    db "Random", $f0

String_95_09_00::
    db "None", $f0

String_95_09_01::
    db "Blaze", $f0

String_95_09_02::
    db "Firebal", $f0

String_95_09_03::
    db "Bang", $f0

String_95_09_04::
    db "Infernos", $f0

String_95_09_05::
    db "Bolt", $f0

String_95_09_06::
    db "IceBolt", $f0

String_95_09_07::
    db "Surround", $f0

String_95_09_08::
    db "Sleep", $f0

String_95_09_09::
    db "Beat", $f0

String_95_09_0A::
    db "RobMagic", $f0

String_95_09_0B::
    db "StopSpell", $f0

String_95_09_0C::
    db "PanicAll", $f0

String_95_09_0D::
    db "Sap", $f0

String_95_09_0E::
    db "SlowAll", $f0

String_95_09_0F::
    db "Sacrifice", $f0

String_95_09_10::
    db "MegaMagic", $f0

String_95_09_11::
    db "Fire", $f0

String_95_09_12::
    db "Blizzard", $f0

String_95_09_13::
    db "Poison", $f0

String_95_09_14::
    db "Paralysis", $f0

String_95_09_15::
    db "Curse", $f0

String_95_09_16::
    db "Rest", $f0

String_95_09_17::
    db "Dance", $f0

String_95_09_18::
    db "Breath", $f0

String_95_09_19::
    db "Friend", $f0

String_95_09_1A::
    db "Bash", $f0

String_95_09_1B::
    db "Water", $f0

String_95_0A_00::
    db "Type A", $f0

String_95_0A_01::
    db "Type B", $f0

String_95_0A_02::
    db "Type C", $f0

String_95_0A_03::
    db "Type D", $f0

String_95_0A_04::
    db "Type E", $f0

String_95_0A_05::
    db "Type F", $f0

String_95_0A_06::
    db "Type G", $f0

String_95_0A_07::
    db "Type H", $f0

String_95_0B_00::
    db "None", $f0

String_95_0B_01::
    db "Battle", $f0

String_95_0B_02::
    db "Field", $f0

String_95_0B_03::
    db "Anytime", $f0
    ds $19cd, $00
