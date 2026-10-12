SECTION "Bank 83", ROMX[$4000], BANK[$83]
    db $83

; message bank $83: when wStringIndex < $C7, BeginStringDisplay with this bank's table Data_083_4032; otherwise far-calls Func_097_4070 (E-0080)
; 2 call sites from 2 routines (e.g. DebugMessageTest_Update_Case12, ScriptCommand09_Case01_Sub01_Case0D)
; reads: wStringIndex
BeginStringDisplay_Bank83::
Func_083_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $C7
    jr c, Jump_083_400F
    farcall BeginStringDisplay_Bank83_Overflow
    ret

Jump_083_400F::
    ld de, MessageStrings_Bank83
    call BeginStringDisplay
    ret

; message bank $83: when wStringIndex < $C7, CopyStringToBuffer with this bank's table Data_083_4032; otherwise far-calls Func_097_407F (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank83:: ; heuristic: follows a terminator; C0
Func_083_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $C7
    jr c, Jump_083_4024
    farcall CopyStringToBuffer_Bank83_Overflow
    ret

Jump_083_4024::
    ld de, MessageStrings_Bank83
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_83_4032::
MessageStrings_Bank83:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_083_4032:: ; address name
    dw StringList_83_4034 ; id 0

; E-0217 (derived: category list of StringCategories_83_4032; one pointer per wStringIndex)
; record: string
StringList_83_4034::
Data_083_4034:: ; address name
    dw String_83_00_00 ; id 0
    dw String_83_00_00 ; id 1
    dw String_83_00_00 ; id 2
    dw String_83_00_00 ; id 3
    dw String_83_00_00 ; id 4
    dw String_83_00_00 ; id 5
    dw String_83_00_00 ; id 6
    dw String_83_00_00 ; id 7
    dw String_83_00_00 ; id 8
    dw String_83_00_00 ; id 9
    dw String_83_00_00 ; id 10
    dw String_83_00_00 ; id 11
    dw String_83_00_00 ; id 12
    dw String_83_00_00 ; id 13
    dw String_83_00_00 ; id 14
    dw String_83_00_00 ; id 15
    dw String_83_00_00 ; id 16
    dw String_83_00_00 ; id 17
    dw String_83_00_00 ; id 18
    dw String_83_00_00 ; id 19
    dw String_83_00_00 ; id 20
    dw String_83_00_00 ; id 21
    dw String_83_00_00 ; id 22
    dw String_83_00_00 ; id 23
    dw String_83_00_00 ; id 24
    dw String_83_00_00 ; id 25
    dw String_83_00_00 ; id 26
    dw String_83_00_00 ; id 27
    dw String_83_00_00 ; id 28
    dw String_83_00_00 ; id 29
    dw String_83_00_00 ; id 30
    dw String_83_00_00 ; id 31
    dw String_83_00_00 ; id 32
    dw String_83_00_21 ; id 33
    dw String_83_00_21 ; id 34
    dw String_83_00_23 ; id 35
    dw String_83_00_24 ; id 36
    dw String_83_00_25 ; id 37
    dw String_83_00_26 ; id 38
    dw String_83_00_27 ; id 39
    dw String_83_00_27 ; id 40
    dw String_83_00_29 ; id 41
    dw String_83_00_2A ; id 42
    dw String_83_00_2B ; id 43
    dw String_83_00_2C ; id 44
    dw String_83_00_2D ; id 45
    dw String_83_00_2E ; id 46
    dw String_83_00_2F ; id 47
    dw String_83_00_30 ; id 48
    dw String_83_00_31 ; id 49
    dw String_83_00_32 ; id 50
    dw String_83_00_33 ; id 51
    dw String_83_00_34 ; id 52
    dw String_83_00_35 ; id 53
    dw String_83_00_36 ; id 54
    dw String_83_00_37 ; id 55
    dw String_83_00_38 ; id 56
    dw String_83_00_39 ; id 57
    dw String_83_00_3A ; id 58
    dw String_83_00_3B ; id 59
    dw String_83_00_3C ; id 60
    dw String_83_00_3D ; id 61
    dw String_83_00_3E ; id 62
    dw String_83_00_3F ; id 63
    dw String_83_00_40 ; id 64
    dw String_83_00_41 ; id 65
    dw String_83_00_42 ; id 66
    dw String_83_00_43 ; id 67
    dw String_83_00_44 ; id 68
    dw String_83_00_45 ; id 69
    dw String_83_00_46 ; id 70
    dw String_83_00_46 ; id 71
    dw String_83_00_48 ; id 72
    dw String_83_00_49 ; id 73
    dw String_83_00_4A ; id 74
    dw String_83_00_4B ; id 75
    dw String_83_00_4C ; id 76
    dw String_83_00_4D ; id 77
    dw String_83_00_4E ; id 78
    dw String_83_00_4F ; id 79
    dw String_83_00_50 ; id 80
    dw String_83_00_51 ; id 81
    dw String_83_00_52 ; id 82
    dw String_83_00_53 ; id 83
    dw String_83_00_54 ; id 84
    dw String_83_00_55 ; id 85
    dw String_83_00_56 ; id 86
    dw String_83_00_57 ; id 87
    dw String_83_00_58 ; id 88
    dw String_83_00_59 ; id 89
    dw String_83_00_5A ; id 90
    dw String_83_00_5B ; id 91
    dw String_83_00_5C ; id 92
    dw String_83_00_5D ; id 93
    dw String_83_00_5E ; id 94
    dw String_83_00_5F ; id 95
    dw String_83_00_60 ; id 96
    dw String_83_00_61 ; id 97
    dw String_83_00_62 ; id 98
    dw String_83_00_63 ; id 99
    dw String_83_00_64 ; id 100
    dw String_83_00_65 ; id 101
    dw String_83_00_66 ; id 102
    dw String_83_00_67 ; id 103
    dw String_83_00_68 ; id 104
    dw String_83_00_69 ; id 105
    dw String_83_00_6A ; id 106
    dw String_83_00_6B ; id 107
    dw String_83_00_6C ; id 108
    dw String_83_00_6D ; id 109
    dw String_83_00_6E ; id 110
    dw String_83_00_6F ; id 111
    dw String_83_00_70 ; id 112
    dw String_83_00_71 ; id 113
    dw String_83_00_72 ; id 114
    dw String_83_00_73 ; id 115
    dw String_83_00_74 ; id 116
    dw String_83_00_75 ; id 117
    dw String_83_00_76 ; id 118
    dw String_83_00_77 ; id 119
    dw String_83_00_78 ; id 120
    dw String_83_00_79 ; id 121
    dw String_83_00_7A ; id 122
    dw String_83_00_7B ; id 123
    dw String_83_00_7C ; id 124
    dw String_83_00_7D ; id 125
    dw String_83_00_7E ; id 126
    dw String_83_00_7F ; id 127
    dw String_83_00_80 ; id 128
    dw String_83_00_81 ; id 129
    dw String_83_00_82 ; id 130
    dw String_83_00_83 ; id 131
    dw String_83_00_84 ; id 132
    dw String_83_00_85 ; id 133
    dw String_83_00_86 ; id 134
    dw String_83_00_87 ; id 135
    dw String_83_00_88 ; id 136
    dw String_83_00_89 ; id 137
    dw String_83_00_8A ; id 138
    dw String_83_00_8B ; id 139
    dw String_83_00_8C ; id 140
    dw String_83_00_8D ; id 141
    dw String_83_00_8E ; id 142
    dw String_83_00_8F ; id 143
    dw String_83_00_90 ; id 144
    dw String_83_00_91 ; id 145
    dw String_83_00_92 ; id 146
    dw String_83_00_93 ; id 147
    dw String_83_00_94 ; id 148
    dw String_83_00_95 ; id 149
    dw String_83_00_96 ; id 150
    dw String_83_00_97 ; id 151
    dw String_83_00_98 ; id 152
    dw String_83_00_99 ; id 153
    dw String_83_00_9A ; id 154
    dw String_83_00_9B ; id 155
    dw String_83_00_9C ; id 156
    dw String_83_00_9D ; id 157
    dw String_83_00_9E ; id 158
    dw String_83_00_9F ; id 159
    dw String_83_00_A0 ; id 160
    dw String_83_00_A1 ; id 161
    dw String_83_00_A2 ; id 162
    dw String_83_00_A3 ; id 163
    dw String_83_00_A4 ; id 164
    dw String_83_00_A5 ; id 165
    dw String_83_00_A6 ; id 166
    dw String_83_00_A7 ; id 167
    dw String_83_00_A8 ; id 168
    dw String_83_00_A9 ; id 169
    dw String_83_00_AA ; id 170
    dw String_83_00_AB ; id 171
    dw String_83_00_AC ; id 172
    dw String_83_00_AD ; id 173
    dw String_83_00_AE ; id 174
    dw String_83_00_AF ; id 175
    dw String_83_00_B0 ; id 176
    dw String_83_00_B1 ; id 177
    dw String_83_00_B2 ; id 178
    dw String_83_00_B3 ; id 179
    dw String_83_00_B4 ; id 180
    dw String_83_00_B5 ; id 181
    dw String_83_00_B6 ; id 182
    dw String_83_00_B7 ; id 183
    dw String_83_00_B8 ; id 184
    dw String_83_00_B9 ; id 185
    dw String_83_00_BA ; id 186
    dw String_83_00_BB ; id 187
    dw String_83_00_BC ; id 188
    dw String_83_00_BD ; id 189
    dw String_83_00_BE ; id 190
    dw String_83_00_BF ; id 191
    dw String_83_00_C0 ; id 192
    dw String_83_00_C1 ; id 193
    dw String_83_00_C2 ; id 194
    dw String_83_00_C3 ; id 195
    dw String_83_00_C4 ; id 196
    dw String_83_00_C5 ; id 197
    dw String_83_00_C6 ; id 198

String_83_00_00:: ; heuristic: string; C0
Data_083_41C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am the King of", $F1
    db "this Kingdom!", $FA, $F7
    db $EF, $EE, "I'm busy, as you", $EF, $EE, "can see!", $FA, $F7
    db $EF, $EE, "Begone, if you", $42, "e", $EF, $EE, "no business here!", $F7
    db $F0

String_83_00_21:: ; heuristic: string; C0
Data_083_4229:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's safe in the", $F1
    db "Castle.", $FA, $F7
    db $EF, $EE, "A priest can tend", $EF, $EE, "to your party too.", $F7
    db $F0

String_83_00_23:: ; heuristic: string; C0
Data_083_426E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We get many", $F1
    db "visitors from", $FA, $F7
    db $EF, $EE, "other worlds.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "I can guess why", $EF, $EE, "you're here.", $F7
    db $F0

String_83_00_24:: ; heuristic: string; C0
Data_083_42C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your journey is", $F1
    db "a pilgrimage?", $FA, $F7
    db $EF, $EE, "That's impressive,", $EF, $EE, "my dear child!", $F7
    db $F0

String_83_00_25:: ; heuristic: string; C0
Data_083_4307:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " To attract wild", $F1
    db "monsters, you must", $FA, $F7
    db $EF, $EE, "not alarm them.", $EF, $EE, "Healing your own", $FA, $F7
    db $EF, $EE, "monsters will make", $EF, $EE, "wild opponents", $FA, $F7
    db $EF, $EE, "mistrust you.", $EF, $EE, $F7
    db $F0

String_83_00_26:: ; heuristic: string; C0
Data_083_438C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " K-keep monsters", $F1
    db "away from me!", $FA, $F7
    db $EF, $EE, "They frighten me!", $EF, $EE, $F7
    db $F0

String_83_00_27:: ; heuristic: string; C0
Data_083_43C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The people here", $F1
    db "live in peace.", $FA, $F7
    db $EF, $EE, "We don't want", $EF, $EE, "outsiders to bring", $FA, $F7
    db $EF, $EE, "in their problems.", $EF, $EE, $F7
    db $F0

String_83_00_29:: ; heuristic: string; C0
Data_083_4424:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e some odd", $F1
    db "monsters there.", $FA, $F7
    db $EF, $EE, "Where did you get", $EF, $EE, "them? Tell me!", $F7
    db $F0

String_83_00_2A:: ; heuristic: string; C0
Data_083_446C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Actually, if I", $F1
    db "wasn't the king,", $FA, $F7
    db $EF, $EE, "I may have left to", $EF, $EE, "travel too", $A4, $F7
    db $F0

String_83_00_2B:: ; heuristic: string; C0
Data_083_44B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I like the", $F1
    db "atmosphere here.", $FA, $F7
    db $EF, $EE, "I", $44, " rather you", $EF, $EE, "didn't bring in", $FA, $F7
    db $EF, $EE, "any problems from", $EF, $EE, "outside.", $F7
    db $F0

String_83_00_2C:: ; heuristic: string; C0
Data_083_4512:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Zzzz", $A4, $F1
    db $FA, $F7
    db $EF, $EE, $F3, "Hah? What?", $F1
    db "Excuse me!", $FA, $F7
    db $EF, $EE, "I", $42, "e been so busy", $EF, $EE, "of late, you see.", $F7
    db $F0

String_83_00_2D:: ; heuristic: string; C0
Data_083_455F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You look to be a", $F1
    db "genius at handling", $FA, $F7
    db $EF, $EE, "monsters.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "I suppose that", $EF, $EE, "makes them safe.", $F7
    db $F0

String_83_00_2E:: ; heuristic: string; C0
Data_083_45BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you have no", $F1
    db "meat when you see", $FA, $F7
    db $EF, $EE, "a monster you want", $EF, $EE, "to get, giving", $FA, $F7
    db $EF, $EE, "them Herbs will", $EF, $EE, "earn their trust.", $F7
    db $F0

String_83_00_2F:: ; heuristic: string; C0
Data_083_462C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster", $F1
    db "grows slowly, you", $FA, $F7
    db $EF, $EE, "ought to consider", $EF, $EE, "taking it alone.", $FA, $F7
    db $EF, $EE, "It will earn more", $EF, $EE, "EX points.", $F7
    db $F0

String_83_00_30:: ; heuristic: string; C0
Data_083_4697:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are some", $F1
    db "items that are to", $FA, $F7
    db $EF, $EE, "be equipped by", $EF, $EE, "monsters.", $F7
    db $F0

String_83_00_31:: ; heuristic: string; C0
Data_083_46D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Accessories for", $F1
    db "monsters are", $FA, $F7
    db $EF, $EE, "hidden in towers", $EF, $EE, "and caves.", $F7
    db $F0

String_83_00_32:: ; heuristic: string; C0
Data_083_471A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Equip D-Scale to", $F1
    db "raise DEF.", $F7
    db $F0

String_83_00_33:: ; heuristic: string; C0
Data_083_473A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "Some kinds provide", $EF, $EE, "better protection.", $F7
    db $F0, "  "

String_83_00_34:: ; heuristic: string; C0
Data_083_478E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "Some kinds promote", $EF, $EE, "stat growth.", $F7
    db $F0

String_83_00_35:: ; heuristic: string; C0
Data_083_47DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "One even restores", $EF, $EE, "HP as you walk.", $F7
    db $F0

String_83_00_36:: ; heuristic: string; C0
Data_083_4828:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "One even restores", $EF, $EE, "MP as you walk.", $F7
    db $F0

String_83_00_37:: ; heuristic: string; C0
Data_083_4876:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A monster can", $F1
    db "equip only one", $FA, $F7
    db $EF, $EE, "accessory, or so", $EF, $EE, "I", $42, "e heard.", $F7
    db $F0

String_83_00_38:: ; heuristic: string; C0
Data_083_48B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster", $F1
    db "gets equipped with", $FA, $F7
    db $EF, $EE, "an accessory, the", $EF, $EE, "old one's removed.", $FA, $F7
    db $EF, $EE, "It's not destroyed,", $EF, $EE, "so don't worry.", $F7
    db $F0

String_83_00_39:: ; heuristic: string; C0
Data_083_4929:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is there an", $F1
    db "accessory that'll", $FA, $F7
    db $EF, $EE, "let me stand up to", $EF, $EE, "my wife?", $F7
    db $F0

String_83_00_3A:: ; heuristic: string; C0
Data_083_496A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " One accessory", $F1
    db "can be equipped.", $FA, $F7
    db $EF, $EE, "You can choose to", $EF, $EE, "compensate for a", $FA, $F7
    db $EF, $EE, "weakness, or boost", $EF, $EE, "a strength.", $F7
    db $F0

String_83_00_3B:: ; heuristic: string; C0
Data_083_49D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You don't look", $F1
    db "familiar.", $FA, $F7
    db $EF, $EE, "A traveler, are", $EF, $EE, "you?", $FA, $F7
    db $EF, $EE, "Be courteous to", $EF, $EE, "our King!", $F7
    db $F0

String_83_00_3C:: ; heuristic: string; C0
Data_083_4A2A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ssh! Be quiet in", $F1
    db "the Castle!", $F7
    db $F0

String_83_00_3D:: ; heuristic: string; C0
Data_083_4A4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzzz", $A4, $F1
    db $FA, $F7
    db $EF, $EE, $F3, "Huh? N-no, I", $EF, $EE, "wasn't sleeping!", $F7
    db $F0

String_83_00_3E:: ; heuristic: string; C0
Data_083_4A78:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters and", $F1
    db "humans co-existed", $FA, $F7
    db $EF, $EE, "peacefully in the", $EF, $EE, "past.", $FA, $F7
    db $EF, $EE, "They won't attack", $EF, $EE, "you if you don't", $FA, $F7
    db $EF, $EE, "disturb their", $EF, $EE, "nests.", $F7
    db $F0

String_83_00_3F:: ; heuristic: string; C0
Data_083_4AF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Be careful in", $F1
    db "towers and caves.", $FA, $F7
    db $EF, $EE, "Monsters in them", $EF, $EE, "are stronger.", $F7
    db $F0

String_83_00_40:: ; heuristic: string; C0
Data_083_4B3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e got guts", $F1
    db "for a little kid!", $F7
    db $F0

String_83_00_41:: ; heuristic: string; C0
Data_083_4B61:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In times of", $F1
    db "peace, we must be", $FA, $F7
    db $EF, $EE, "even more vigilant", $EF, $EE, "than usual!", $F7
    db $F0

String_83_00_42:: ; heuristic: string; C0
Data_083_4BA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A high-power", $F1
    db "attack inflicts", $FA, $F7
    db $EF, $EE, "more damage, but", $EF, $EE, "it's not accurate.", $FA, $F7
    db $EF, $EE, "SideStep is a good", $EF, $EE, "countermeasure.", $F7
    db $F0

String_83_00_43:: ; heuristic: string; C0
Data_083_4C15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are some", $F1
    db "skills that are", $FA, $F7
    db $EF, $EE, "extra-effective on", $EF, $EE, "specific families.", $FA, $F7
    db $EF, $EE, "They're not flashy,", $EF, $EE, "but they work.", $F7
    db $F0

String_83_00_44:: ; heuristic: string; C0
Data_083_4C88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some skills put", $F1
    db "the user at risk.", $FA, $F7
    db $EF, $EE, "I like the gamble", $EF, $EE, "that they pose!", $F7
    db $F0

String_83_00_45:: ; heuristic: string; C0
Data_083_4CD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GigaSlash is", $F1
    db "revered.", $FA, $F7
    db $EF, $EE, "This sword skill", $EF, $EE, "is learned only by", $FA, $F7
    db $EF, $EE, "those who learn", $EF, $EE, "all sword skills.", $F7
    db $F0

String_83_00_46:: ; heuristic: string; C0
Data_083_4D3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A kid with", $F1
    db "monsters in tow?", $FA, $F7
    db $EF, $EE, "You're a brave", $EF, $EE, "soul!", $F7
    db $F0

String_83_00_48:: ; heuristic: string; C0
Data_083_4D74:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some monsters do", $F1
    db "not belong to any", $FA, $F7
    db $EF, $EE, "known family.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "They are powerful,", $EF, $EE, "terrible beings.", $FA, $F7
    db $EF, $EE, "They reign as", $EF, $EE, "lords and kings", $FA, $F7
    db $EF, $EE, "among demons and", $EF, $EE, "monsters.", $F7
    db $F0

String_83_00_49:: ; heuristic: string; C0
Data_083_4E18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A visitor came", $F1
    db "here with a rare", $FA, $F7
    db $EF, $EE, "monster in his", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "I", $42, "e never seen it", $EF, $EE, "around here.", $F7
    db $F0

String_83_00_4A:: ; heuristic: string; C0
Data_083_4E79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you seen a", $F1
    db "casino ship?", $FA, $F7
    db $EF, $EE, "You can bet on", $EF, $EE, "slot machines.", $FA, $F7
    db $EF, $EE, "You can win some", $EF, $EE, "decent prizes too.", $F7
    db $F0

String_83_00_4B:: ; heuristic: string; C0
Data_083_4EE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some monsters", $F1
    db "have attacks that", $FA, $F7
    db $EF, $EE, "hit and leave a", $EF, $EE, "lingering effect.", $FA, $F7
    db $EF, $EE, "Watch out for", $EF, $EE, "them.", $FA, $F7
    db $EF, $EE, "They'll be useful", $EF, $EE, "in your party.", $F7
    db $F0

String_83_00_4C:: ; heuristic: string; C0
Data_083_4F6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your eyes are", $F1
    db "unclouded", $A4, $FA, $F7
    db $EF, $EE, "You seem to be a", $EF, $EE, "good sort.", $F7
    db $F0

String_83_00_4D:: ; heuristic: string; C0
Data_083_4FA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When I was a", $F1
    db "kid, I wanted to", $FA, $F7
    db $EF, $EE, "travel everywhere.", $EF, $EE, "But at my age,", $FA, $F7
    db $EF, $EE, "home is where I", $EF, $EE, "want to be.", $F7
    db $F0

String_83_00_4E:: ; heuristic: string; C0
Data_083_500F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hoo boy, it sure", $F1
    db "is quiet.", $FA, $F7
    db $EF, $EE, "Of course, it's", $EF, $EE, "better that way.", $F7
    db $F0

String_83_00_4F:: ; heuristic: string; C0
Data_083_5052:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Sigh", $A4, " All I ever", $F1
    db "do is clean up,", $FA, $F7
    db $EF, $EE, "the way the boss", $EF, $EE, "says.", $FA, $F7
    db $EF, $EE, "When am I going to", $EF, $EE, "be promoted?", $F7
    db $F0

String_83_00_50:: ; heuristic: string; C0
Data_083_50B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The young people", $F1
    db "these days have no", $FA, $F7
    db $EF, $EE, "sense of gumption!", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Self-pitying", $EF, $EE, "whiners, they are!", $F7
    db $F0

String_83_00_51:: ; heuristic: string; C0
Data_083_511B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Halt!", $F1
    db "Who goes there?", $FA, $F7
    db $EF, $EE, "I look good as a", $EF, $EE, "guard, don't I?", $F7
    db $F0

String_83_00_52:: ; heuristic: string; C0
Data_083_5159:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm terrified of", $F1
    db "monsters!", $FA, $F7
    db $EF, $EE, "Keep them away", $EF, $EE, "from me!", $F7
    db $F0

String_83_00_53:: ; heuristic: string; C0
Data_083_5193:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A soldier has to", $F1
    db "obey orders.", $FA, $F7
    db $EF, $EE, "If soldiers don't", $EF, $EE, "obey, even a", $FA, $F7
    db $EF, $EE, "winnable battle", $EF, $EE, "will be lost.", $FA, $F7
    db $EF, $EE, "Train your party", $EF, $EE, "well so they won't", $FA, $F7
    db $EF, $EE, "rebel against you", $EF, $EE, "in battle.", $F7
    db $F0

String_83_00_54:: ; heuristic: string; C0
Data_083_5241:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is it really", $F1
    db "possible for", $FA, $F7
    db $EF, $EE, "people to co-exist", $EF, $EE, "with monsters?", $F7
    db $F0

String_83_00_55:: ; heuristic: string; C0
Data_083_5285:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're not from", $F1
    db "these parts.", $FA, $F7
    db $EF, $EE, "I can tell.", $EF, $EE, "You're a bumpkin.", $F7
    db $F0

String_83_00_56:: ; heuristic: string; C0
Data_083_52C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Money attracts", $F1
    db "greedy people.", $FA, $F7
    db $EF, $EE, "Keep extra money", $EF, $EE, "in the Vault.", $FA, $F7
    db $EF, $EE, "It will be safe", $EF, $EE, "there.", $F7
    db $F0

String_83_00_57:: ; heuristic: string; C0
Data_083_5326:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e run into", $F1
    db "dealers while I", $FA, $F7
    db $EF, $EE, "was traveling", $EF, $EE, "about.", $FA, $F7
    db $EF, $EE, "They charge crazy", $EF, $EE, "prices, though.", $F7
    db $F0

String_83_00_58:: ; heuristic: string; C0
Data_083_5386:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e met other", $F1
    db "travelers with", $FA, $F7
    db $EF, $EE, "monsters in tow", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "They said they", $EF, $EE, "were training.", $F7
    db $F0

String_83_00_59:: ; heuristic: string; C0
Data_083_53E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some monsters", $F1
    db "grow slowly when", $FA, $F7
    db $EF, $EE, "they are young,", $EF, $EE, "but watch how they", $FA, $F7
    db $EF, $EE, "grow when they get", $EF, $EE, "older. Wow!", $F7
    db $F0

String_83_00_5A:: ; heuristic: string; C0
Data_083_5454:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monster families", $F1
    db "have upper limits", $FA, $F7
    db $EF, $EE, "to their growth.", $EF, $EE, "But the limits can", $FA, $F7
    db $EF, $EE, "be raised by", $EF, $EE, "breeding.", $F7
    db $F0

String_83_00_5B:: ; heuristic: string; C0
Data_083_54BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Seeds and nuts", $F1
    db "that raise stats", $FA, $F7
    db $EF, $EE, "are invaluable", $EF, $EE, "items.", $FA, $F7
    db $EF, $EE, "On odd occasions,", $EF, $EE, "you'll find them", $FA, $F7
    db $EF, $EE, "as gambling", $EF, $EE, "prizes.", $F7
    db $F0

String_83_00_5C:: ; heuristic: string; C0
Data_083_5538:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are many", $F1
    db "worlds, and there", $FA, $F7
    db $EF, $EE, "are many people,", $EF, $EE, "both good and bad.", $FA, $F7
    db $EF, $EE, "That's why it's", $EF, $EE, "exciting!", $F7
    db $F0

String_83_00_5D:: ; heuristic: string; C0
Data_083_55A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm only a raw", $F1
    db "recruit, but one", $FA, $F7
    db $EF, $EE, "day, I'm going to", $EF, $EE, "become a hero.", $FA, $F7
    db $EF, $EE, "When that happens,", $EF, $EE, "I'll propose to my", $FA, $F7
    db $EF, $EE, "girl. I wonder if", $EF, $EE, "she'll wait?", $F7
    db $F0

String_83_00_5E:: ; heuristic: string; C0
Data_083_5633:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can't just", $F1
    db "work on physical", $FA, $F7
    db $EF, $EE, "might. You need to", $EF, $EE, "be sharp mentally", $FA, $F7
    db $EF, $EE, "if you want to do", $EF, $EE, "well in battle.", $F7
    db $F0

String_83_00_5F:: ; heuristic: string; C0
Data_083_56A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our King is", $F1
    db "named Al.", $FA, $F7
    db $EF, $EE, "Tell me, have you", $EF, $EE, "MetalKing?", $FA, $F7
    db $EF, $EE, "Whoops, you didn't", $EF, $EE, "find that funny?", $F7
    db $F0

String_83_00_60:: ; heuristic: string; C0
Data_083_5707:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are no", $F1
    db "human settlements", $FA, $F7
    db $EF, $EE, "around these parts", $EF, $EE, "except here.", $FA, $F7
    db $EF, $EE, "You should rest up", $EF, $EE, "before you leave.", $F7
    db $F0

String_83_00_61:: ; heuristic: string; C0
Data_083_5777:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the only", $F1
    db "human settlement", $FA, $F7
    db $EF, $EE, "in these parts.", $EF, $EE, "You might consider", $FA, $F7
    db $EF, $EE, "resting here", $EF, $EE, "before you go.", $F7
    db $F0

String_83_00_62:: ; heuristic: string; C0
Data_083_57E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are a few", $F1
    db "other places where", $FA, $F7
    db $EF, $EE, "people live in", $EF, $EE, "these parts.", $FA, $F7
    db $EF, $EE, "Each has different", $EF, $EE, "facilities.", $F7
    db $F0

String_83_00_63:: ; heuristic: string; C0
Data_083_584E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The merchandise", $F1
    db "of shops varies", $FA, $F7
    db $EF, $EE, "from place to", $EF, $EE, "place.", $F7
    db $F0

String_83_00_64:: ; heuristic: string; C0
Data_083_588B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome! Good of", $F1
    db "you to come!", $FA, $F7
    db $EF, $EE, "We don't get many", $EF, $EE, "visitors.", $F7
    db $F0

String_83_00_65:: ; heuristic: string; C0
Data_083_58CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's dangerous", $F1
    db "out there.", $FA, $F7
    db $EF, $EE, "Get some rest", $EF, $EE, "before you go.", $F7
    db $F0

String_83_00_66:: ; heuristic: string; C0
Data_083_590A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Uh", $A4, $F1
    db "Um", $A4, $FA, $F7
    db $EF, $EE, "Aren't you afraid", $EF, $EE, "of your monsters?", $F7
    db $F0

String_83_00_67:: ; heuristic: string; C0
Data_083_593D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you plan on", $F1
    db "traveling far, you", $FA, $F7
    db $EF, $EE, "should prepare for", $EF, $EE, "any emergency.", $FA, $F7
    db $EF, $EE, "There's no telling", $EF, $EE, "what could happen.", $F7
    db $F0

String_83_00_68:: ; heuristic: string; C0
Data_083_59B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A LogTwig is", $F1
    db "convenient.", $FA, $F7
    db $EF, $EE, "Leave it anywhere", $EF, $EE, "in the field, and", $FA, $F7
    db $EF, $EE, "you can get to it", $EF, $EE, "with a WarpStaff.", $F7
    db $F0

String_83_00_69:: ; heuristic: string; C0
Data_083_5A1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Teach me how to", $F1
    db "tame monsters.", $FA, $F7
    db $EF, $EE, "I could get them", $EF, $EE, "to cook and clean", $A4, $F7
    db $F0

String_83_00_6A:: ; heuristic: string; C0
Data_083_5A6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can make", $F1
    db "monsters friendly", $FA, $F7
    db $EF, $EE, "by taking them on", $EF, $EE, "your journeys.", $FA, $F7
    db $EF, $EE, "Feeding them meat", $EF, $EE, "is too costly.", $F7
    db $F0

String_83_00_6B:: ; heuristic: string; C0
Data_083_5AD7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you know the", $F1
    db "skill Errand?", $FA, $F7
    db $EF, $EE, "You can get a", $EF, $EE, "monster to go do", $FA, $F7
    db $EF, $EE, "some shopping for", $EF, $EE, "you.", $F7
    db $F0

String_83_00_6C:: ; heuristic: string; C0
Data_083_5B37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you heard", $F1
    db "of EagleEye?", $FA, $F7
    db $EF, $EE, "It's a skill for", $EF, $EE, "checking your", $FA, $F7
    db $EF, $EE, "surroundings from", $EF, $EE, "a bird's-eye view.", $F7
    db $F0

String_83_00_6D:: ; heuristic: string; C0
Data_083_5BA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do your monsters", $F1
    db "know Informer?", $FA, $F7
    db $EF, $EE, "It's a skill that", $EF, $EE, "identifies the", $FA, $F7
    db $EF, $EE, "kinds of monsters", $EF, $EE, "in the vicinity.", $F7
    db $F0

String_83_00_6E:: ; heuristic: string; C0
Data_083_5C10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Does any monster", $F1
    db "of yours know the", $FA, $F7
    db $EF, $EE, "skill MapMagic?", $EF, $EE, "It gives you an", $FA, $F7
    db $EF, $EE, "idea about your", $EF, $EE, "surrounding area.", $F7
    db $F0

String_83_00_6F:: ; heuristic: string; C0
Data_083_5C81:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You need money", $F1
    db "to buy items.", $FA, $F7
    db $EF, $EE, "But money is hard", $EF, $EE, "to find.", $FA, $F7
    db $EF, $EE, "I guess I have to", $EF, $EE, "sell extra items.", $F7
    db $F0

String_83_00_70:: ; heuristic: string; C0
Data_083_5CE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The slime family", $F1
    db "is tough against", $FA, $F7
    db $EF, $EE, "spells like", $EF, $EE, "Surround and Sap.", $FA, $F7
    db $EF, $EE, "If only they had", $EF, $EE, "higher ATK", $A4, $F7
    db $F0

String_83_00_71:: ; heuristic: string; C0
Data_083_5D52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Dragons are", $F1
    db "fire-resistant.", $FA, $F7
    db $EF, $EE, "If only they grew", $EF, $EE, "a bit faster", $A4, $F7
    db $F0

String_83_00_72:: ; heuristic: string; C0
Data_083_5D96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The beast family", $F1
    db "is very weak to", $FA, $F7
    db $EF, $EE, "attack spells.", $EF, $EE, "On the other hand,", $FA, $F7
    db $EF, $EE, "it has high ATK", $EF, $EE, "and HP.", $F7
    db $F0

String_83_00_73:: ; heuristic: string; C0
Data_083_5DFD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Birds are quite", $F1
    db "resistant to such", $FA, $F7
    db $EF, $EE, "spells as Infernos", $EF, $EE, "and Zap.", $FA, $F7
    db $EF, $EE, "They also grow", $EF, $EE, "fast.", $F7
    db $F0

String_83_00_74:: ; heuristic: string; C0
Data_083_5E5C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The plant family", $F1
    db "is strong against", $FA, $F7
    db $EF, $EE, "spells like Zap", $EF, $EE, "and Infernos.", $FA, $F7
    db $EF, $EE, "But it's vulnerable", $EF, $EE, "to fire.", $FA, $F7
    db $EF, $EE, "MP gain is high on", $EF, $EE, "leveling up.", $F7
    db $F0

String_83_00_75:: ; heuristic: string; C0
Data_083_5EE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The bug family", $F1
    db "is resistant to", $FA, $F7
    db $EF, $EE, "poison and", $EF, $EE, "paralysis.", $FA, $F7
    db $EF, $EE, "Bugs also grow", $EF, $EE, "fast, so they can", $FA, $F7
    db $EF, $EE, "become useful very", $EF, $EE, "quickly.", $F7
    db $F0

String_83_00_76:: ; heuristic: string; C0
Data_083_5F6B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The devil family", $F1
    db "is very resistant", $FA, $F7
    db $EF, $EE, "to all kinds of", $EF, $EE, "attack spells.", $FA, $F7
    db $EF, $EE, "They", $44, " be great if", $EF, $EE, "they didn't get", $FA, $F7
    db $EF, $EE, "poisoned or fall", $EF, $EE, "asleep easily.", $F7
    db $F0

String_83_00_77:: ; heuristic: string; C0
Data_083_5FFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zombies are", $F1
    db "virtually unharmed", $FA, $F7
    db $EF, $EE, "by death spells or", $EF, $EE, "curses.", $FA, $F7
    db $EF, $EE, "On the other hand,", $EF, $EE, "they are easily", $FA, $F7
    db $EF, $EE, "affected by fire", $EF, $EE, "and WarCry", $A4, $F7
    db $F0

String_83_00_78:: ; heuristic: string; C0
Data_083_6088:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are many", $F1
    db "kinds of material", $FA, $F7
    db $EF, $EE, "family monsters.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "It's impossible to", $EF, $EE, "describe their", $FA, $F7
    db $EF, $EE, "good points in one", $EF, $EE, "breath.", $F7
    db $F0

String_83_00_79:: ; heuristic: string; C0
Data_083_6108:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Water family", $F1
    db "monsters are very", $FA, $F7
    db $EF, $EE, "tough against fire", $EF, $EE, "and water skills.", $FA, $F7
    db $EF, $EE, "There isn't one", $EF, $EE, "that really stands", $FA, $F7
    db $EF, $EE, "out, but they can", $EF, $EE, "be quite useful.", $F7
    db $F0

String_83_00_7A:: ; heuristic: string; C0
Data_083_61A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you met any", $F1
    db "Demon Lords?", $FA, $F7
    db $EF, $EE, "They make nasty", $EF, $EE, "enemies, but if", $FA, $F7
    db $EF, $EE, "you could get them", $EF, $EE, "on your side", $A4, $F7
    db $F0

String_83_00_7B:: ; heuristic: string; C0
Data_083_620C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's getting", $F1
    db "mean out there.", $FA, $F7
    db $EF, $EE, "Strangers may want", $EF, $EE, "to battle you.", $F7
    db $F0

String_83_00_7C:: ; heuristic: string; C0
Data_083_6252:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Skills that", $F1
    db "induce sleep or", $FA, $F7
    db $EF, $EE, "paralysis are very", $EF, $EE, "effective.", $FA, $F7
    db $EF, $EE, "But watch out,", $EF, $EE, "some monsters are", $FA, $F7
    db $EF, $EE, "impervious to", $EF, $EE, "them.", $F7
    db $F0

String_83_00_7D:: ; heuristic: string; C0
Data_083_62D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you seen", $F1
    db "any metallic kinds", $FA, $F7
    db $EF, $EE, "of slime monsters?", $EF, $EE, "They're worth a", $FA, $F7
    db $EF, $EE, "huge amount of EX", $EF, $EE, "points.", $F7
    db $F0

String_83_00_7E:: ; heuristic: string; C0
Data_083_633A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My grandpa told", $F1
    db "me that if you see", $FA, $F7
    db $EF, $EE, "a bard, you're in", $EF, $EE, "luck.", $F7
    db $F0

String_83_00_7F:: ; heuristic: string; C0
Data_083_637C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you seen a", $F1
    db "Gold Pass?", $FA, $F7
    db $EF, $EE, "It's expensive,", $EF, $EE, "but it gives you", $FA, $F7
    db $EF, $EE, "discounts at any", $EF, $EE, "shop.", $F7
    db $F0

String_83_00_80:: ; heuristic: string; C0
Data_083_63DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the deepest", $F1
    db "part of a cave,", $FA, $F7
    db $EF, $EE, "a monster boss", $EF, $EE, "makes its throne.", $FA, $F7
    db $EF, $EE, "It reigns over", $EF, $EE, "other monsters.", $F7
    db $F0

String_83_00_81:: ; heuristic: string; C0
Data_083_6445:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " At the top of a", $F1
    db "tower, you'll find", $FA, $F7
    db $EF, $EE, "a monster boss on", $EF, $EE, "its throne.", $FA, $F7
    db $EF, $EE, "It reigns over", $EF, $EE, "other monsters.", $F7
    db $F0

String_83_00_82:: ; heuristic: string; C0
Data_083_64B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I hear that", $F1
    db "there's a monster", $FA, $F7
    db $EF, $EE, "boss in a castle", $EF, $EE, "somewhere.", $FA, $F7
    db $EF, $EE, "It reigns over", $EF, $EE, "other monsters.", $F7
    db $F0

String_83_00_83:: ; heuristic: string; C0
Data_083_6514:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Treasure chests", $F1
    db "are hidden in", $FA, $F7
    db $EF, $EE, "caves and towers,", $EF, $EE, "I", $42, "e heard.", $FA, $F7
    db $EF, $EE, "They must contain", $EF, $EE, "amazing treasures!", $F7
    db $F0

String_83_00_84:: ; heuristic: string; C0
Data_083_6580:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you must be", $F1
    db "a traveler.", $FA, $F7
    db $EF, $EE, "There isn't much", $EF, $EE, "here, but it is", $FA, $F7
    db $EF, $EE, "a nice place to", $EF, $EE, "rest up.", $F7
    db $F0

String_83_00_85:: ; heuristic: string; C0
Data_083_65E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You may find", $F1
    db "things in the", $FA, $F7
    db $EF, $EE, "oddest places.", $EF, $EE, "You have to look.", $F7
    db $F0

String_83_00_86:: ; heuristic: string; C0
Data_083_6625:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Now, where's my", $F1
    db "husband wandering?", $FA, $F7
    db $EF, $EE, "I send him out on", $EF, $EE, "a simple errand", $A4, $FA, $F7
    db $EF, $EE, "It's beyond belief,", $EF, $EE, "let me tell you!", $F7
    db $F0

String_83_00_87:: ; heuristic: string; C0
Data_083_669A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " What to make for", $F1
    db "supper", $A4, $F7
    db $F0

String_83_00_88:: ; heuristic: string; C0
Data_083_66B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh my!", $F1
    db "What delicious", $A4, $FA, $F7
    db $EF, $EE, "I mean cute! Yes,", $EF, $EE, "cute, monsters!", $F7
    db $F0

String_83_00_89:: ; heuristic: string; C0
Data_083_66F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wish my boy", $F1
    db "was as mature as", $FA, $F7
    db $EF, $EE, "you, but he's just", $EF, $EE, "so rambunctious.", $FA, $F7
    db $EF, $EE, "I can't let him", $EF, $EE, "out of sight.", $F7
    db $F0

String_83_00_8A:: ; heuristic: string; C0
Data_083_6763:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Look at your", $F1
    db "dirty clothes!", $FA, $F7
    db $EF, $EE, "Are you washing", $EF, $EE, "them properly?", $F7
    db $F0

String_83_00_8B:: ; heuristic: string; C0
Data_083_67A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Our children", $F1
    db "grow like weeds.", $FA, $F7
    db $EF, $EE, "You should see how", $EF, $EE, "much they eat.", $F7
    db $F0

String_83_00_8C:: ; heuristic: string; C0
Data_083_67EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That man there", $F1
    db "keeps staring.", $FA, $F7
    db $EF, $EE, "Does he think I'm", $EF, $EE, "strange?", $F7
    db $F0

String_83_00_8D:: ; heuristic: string; C0
Data_083_682E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, aren't you", $F1
    db "cute!", $FA, $F7
    db $EF, $EE, "And your monsters", $EF, $EE, "are adorable too!", $F7
    db $F0

String_83_00_8E:: ; heuristic: string; C0
Data_083_686E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It would be so", $F1
    db "nice to be able to", $FA, $F7
    db $EF, $EE, "cross the sea or", $EF, $EE, "fly.", $FA, $F7
    db $EF, $EE, "If I could, I", $EF, $EE, "would go see my", $FA, $F7
    db $EF, $EE, "boyfriend whenever", $EF, $EE, "I wanted.", $F7
    db $F0

String_83_00_8F:: ; heuristic: string; C0
Data_083_68F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wish I had a", $F1
    db "sibling like you.", $F7
    db $F0

String_83_00_90:: ; heuristic: string; C0
Data_083_6916:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " My boy is a", $F1
    db "dirt magnet!", $FA, $F7
    db $EF, $EE, "I can't keep up", $EF, $EE, "with the wash!", $F7
    db $F0

String_83_00_91:: ; heuristic: string; C0
Data_083_6955:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, "Sigh", $A4, " When will", $F1
    db "he come back?", $FA, $F7
    db $EF, $EE, "He hasn't written", $EF, $EE, "once, the clod!", $F7
    db $F0

String_83_00_92:: ; heuristic: string; C0
Data_083_699D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Is it safe alone", $F1
    db "like that?", $FA, $F7
    db $EF, $EE, "Don't break your", $EF, $EE, "parents", $95, " hearts!", $F7
    db $F0

String_83_00_93:: ; heuristic: string; C0
Data_083_69E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Monsters have", $F1
    db "personalities that", $FA, $F7
    db $EF, $EE, "determine how they", $EF, $EE, "behave.", $F7
    db $F0

String_83_00_94:: ; heuristic: string; C0
Data_083_6A26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I thought", $F1
    db "monsters were", $FA, $F7
    db $EF, $EE, "frightful things,", $EF, $EE, "but the ones you", $FA, $F7
    db $EF, $EE, "have all look", $EF, $EE, "cheerful.", $F7
    db $F0

String_83_00_95:: ; heuristic: string; C0
Data_083_6A85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You're on a", $F1
    db "journey with", $FA, $F7
    db $EF, $EE, "monsters?", $EF, $EE, "I'm impressed.", $F7
    db $F0

String_83_00_96:: ; heuristic: string; C0
Data_083_6ABD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I pack lightly", $F1
    db "for a journey.", $FA, $F7
    db $EF, $EE, "A WarpWing and a", $EF, $EE, "Bookmark-", $FA, $F7
    db $EF, $EE, "those are basic.", $EF, $EE, "After these two,", $FA, $F7
    db $EF, $EE, "I take the bare", $EF, $EE, "minimum, so I can", $FA, $F7
    db $EF, $EE, "pick up more items", $EF, $EE, "that I find.", $F7
    db $F0

String_83_00_97:: ; heuristic: string; C0
Data_083_6B6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I love squishy", $F1
    db "monsters!", $FA, $F7
    db $EF, $EE, "They look so", $EF, $EE, "appetizing!", $FA, $F7
    db $EF, $EE, "I'm joking!", $EF, $EE, "Don't be scared!", $F7
    db $F0

String_83_00_98:: ; heuristic: string; C0
Data_083_6BC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " How do monsters", $F1
    db "live in the wild?", $FA, $F7
    db $EF, $EE, "We don't know much", $EF, $EE, "about them.", $F7
    db $F0

String_83_00_99:: ; heuristic: string; C0
Data_083_6C0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The FriendStaff", $F1
    db "works exactly like", $FA, $F7
    db $EF, $EE, "the spell TwinHits", $EF, $EE, "in battle.", $FA, $F7
    db $EF, $EE, "It will definitely", $EF, $EE, "come in handy.", $F7
    db $F0

String_83_00_9A:: ; heuristic: string; C0
Data_083_6C7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The MistStaff", $F1
    db "does the same work", $FA, $F7
    db $EF, $EE, "as the spell", $EF, $EE, "StopSpell.", $FA, $F7
    db $EF, $EE, "Use it to silence", $EF, $EE, "spell-casters.", $F7
    db $F0

String_83_00_9B:: ; heuristic: string; C0
Data_083_6CE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You can attack", $F1
    db "monsters using", $FA, $F7
    db $EF, $EE, "the powers of", $EF, $EE, "certain staves.", $FA, $F7
    db $EF, $EE, "But monsters won't", $EF, $EE, "like you for it.", $F7
    db $F0

String_83_00_9C:: ; heuristic: string; C0
Data_083_6D4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " BadMeat acts", $F1
    db "like poison.", $FA, $F7
    db $EF, $EE, "Don't feed it to", $EF, $EE, "your monsters,", $FA, $F7
    db $EF, $EE, "but it works on", $EF, $EE, "enemies well.", $F7
    db $F0

String_83_00_9D:: ; heuristic: string; C0
Data_083_6DB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Repellent keeps", $F1
    db "monsters away.", $FA, $F7
    db $EF, $EE, "The Shiny Harp", $EF, $EE, "does the opposite.", $F7
    db $F0

String_83_00_9E:: ; heuristic: string; C0
Data_083_6DFB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " How adorable!", $F1
    db "How would you like", $FA, $F7
    db $EF, $EE, "a nice powderpuff", $EF, $EE, "massage?", $FA, $F7
    db $EF, $EE, "Oh? Not you.", $EF, $EE, "I love monsters!", $F7
    db $F0

String_83_00_9F:: ; heuristic: string; C0
Data_083_6E61:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Have you heard", $F1
    db "about the great", $FA, $F7
    db $EF, $EE, "master tamer?", $EF, $EE, "He's amazing.", $FA, $F7
    db $EF, $EE, "He's named Terry.", $EF, $EE, "He's still young!", $F7
    db $F0

String_83_00_A0:: ; heuristic: string; C0
Data_083_6EC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Magic Keys are", $F1
    db "indeed magical.", $FA, $F7
    db $EF, $EE, "It's magical how", $EF, $EE, "they lead to", $FA, $F7
    db $EF, $EE, "different worlds", $EF, $EE, "we don't know.", $F7
    db $F0

String_83_00_A1:: ; heuristic: string; C0
Data_083_6F30:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If something is", $F1
    db "rare or valuable", $A4, $FA, $F7
    db $EF, $EE, "You", $44, " never leave", $EF, $EE, "it in plain sight.", $F7
    db $F0

String_83_00_A2:: ; heuristic: string; C0
Data_083_6F7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Caves and towers", $F1
    db "teem with danger!", $FA, $F7
    db $EF, $EE, "Going in is only", $EF, $EE, "half the job.", $FA, $F7
    db $EF, $EE, "You have to get", $EF, $EE, "yourself back out!", $F7
    db $F0

String_83_00_A3:: ; heuristic: string; C0
Data_083_6FEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A treasure chest", $F1
    db "holds one item.", $F7
    db $F0

String_83_00_A4:: ; heuristic: string; C0
Data_083_7014:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, I can't", $F1
    db "recall seeing a", $FA, $F7
    db $EF, $EE, "cuter visitor than", $EF, $EE, "you, dear child.", $FA, $F7
    db $EF, $EE, "Do take the time", $EF, $EE, "to relax here.", $F7
    db $F0

String_83_00_A5:: ; heuristic: string; C0
Data_083_707F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you're ever", $F1
    db "in need of help,", $FA, $F7
    db $EF, $EE, "be sure to come", $EF, $EE, "back here.", $F7
    db $F0

String_83_00_A6:: ; heuristic: string; C0
Data_083_70C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Other worlds,", $F1
    db "you say?", $FA, $F7
    db $EF, $EE, "I", $44, " like to go", $EF, $EE, "somewhere", $A4, $F7
    db $F0

String_83_00_A7:: ; heuristic: string; C0
Data_083_70F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So good of you", $F1
    db "to visit us at", $FA, $F7
    db $EF, $EE, "this distant and", $EF, $EE, "forgotten outpost.", $FA, $F7
    db $EF, $EE, "There is nothing", $EF, $EE, "here at all.", $FA, $F7
    db $EF, $EE, "But feel free to", $EF, $EE, "stay as long as", $FA, $F7
    db $EF, $EE, "you wish.", $EF, $EE, $F7
    db $F0

String_83_00_A8:: ; heuristic: string; C0
Data_083_7199:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, you're such", $F1
    db "a cute cherub!", $FA, $F7
    db $EF, $EE, "You look exactly", $EF, $EE, "as my son did.", $FA, $F7
    db $EF, $EE, "Wait! Are you my", $EF, $EE, "grandchild?", $F7
    db $F0

String_83_00_A9:: ; heuristic: string; C0
Data_083_7200:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hah? You have", $F1
    db "tamed monsters?", $FA, $F7
    db $EF, $EE, "You're to be", $EF, $EE, "commended!", $FA, $F7
    db $EF, $EE, "I did the same", $EF, $EE, "when I was young", $A4, $F7
    db $F0

String_83_00_AA:: ; heuristic: string; C0
Data_083_7262:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If something", $F1
    db "comes easily,", $FA, $F7
    db $EF, $EE, "one is apt to not", $EF, $EE, "realize its worth.", $FA, $F7
    db $EF, $EE, "When you do, it's", $EF, $EE, "usually been lost", $A4, $F7
    db $F0

String_83_00_AB:: ; heuristic: string; C0
Data_083_72D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you wish to", $F1
    db "meet travelers", $FA, $F7
    db $EF, $EE, "like yourself, you", $EF, $EE, "must walk.", $FA, $F7
    db $EF, $EE, "You'll get to see", $EF, $EE, "them, by and by.", $F7
    db $F0

String_83_00_AC:: ; heuristic: string; C0
Data_083_733C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When I was your", $F1
    db "age, I admit I was", $FA, $F7
    db $EF, $EE, "a mischievous lad,", $EF, $EE, "if I may say so.", $FA, $F7
    db $EF, $EE, "I remember those", $EF, $EE, "days clearly", $A4, $F7
    db $F0

String_83_00_AD:: ; heuristic: string; C0
Data_083_73AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I take my walk", $F1
    db "on the same route", $FA, $F7
    db $EF, $EE, "every day. I never", $EF, $EE, "go anywhere else.", $FA, $F7
    db $EF, $EE, "But, like the way", $EF, $EE, "I met you today,", $FA, $F7
    db $EF, $EE, "there is always a", $EF, $EE, "new discovery.", $F7
    db $F0

String_83_00_AE:: ; heuristic: string; C0
Data_083_7448:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My eyesight isn't", $F1
    db "what it once was.", $FA, $F7
    db $EF, $EE, "But my nose works", $EF, $EE, "quite fine.", $FA, $F7
    db $EF, $EE, "The friends behind", $EF, $EE, "you desperately", $FA, $F7
    db $EF, $EE, "need a bath, I can", $EF, $EE, "tell that much.", $F7
    db $F0

String_83_00_AF:: ; heuristic: string; C0
Data_083_74DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah-ha, you're", $F1
    db "such a cute child!", $FA, $F7
    db $EF, $EE, "About a tenth of", $EF, $EE, "the cuteness of my", $FA, $F7
    db $EF, $EE, "grandchildren, I", $EF, $EE, "would think.", $F7
    db $F0

String_83_00_B0:: ; heuristic: string; C0
Data_083_754D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I was a fine-", $F1
    db "looking fellow", $FA, $F7
    db $EF, $EE, "with many lady", $EF, $EE, "friends.", $FA, $F7
    db $EF, $EE, "Not that you could", $EF, $EE, "tell from this", $FA, $F7
    db $EF, $EE, "wrinkled old sack", $EF, $EE, "of bones!", $F7
    db $F0

String_83_00_B1:: ; heuristic: string; C0
Data_083_75D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A monster can", $F1
    db "equip a single", $FA, $F7
    db $EF, $EE, "accessory, and no", $EF, $EE, "more.", $FA, $F7
    db $EF, $EE, "If you equip", $EF, $EE, "another one, the", $FA, $F7
    db $EF, $EE, "old one is taken", $EF, $EE, "off.", $F7
    db $F0

String_83_00_B2:: ; heuristic: string; C0
Data_083_7649:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If someone asks", $F1
    db "you to mate some", $FA, $F7
    db $EF, $EE, "monsters, be quick", $EF, $EE, "to accept.", $FA, $F7
    db $EF, $EE, "Traveling masters", $EF, $EE, "don't stay long.", $F7
    db $F0

String_83_00_B3:: ; heuristic: string; C0
Data_083_76B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm, when I was", $F1
    db "young, I must say", $FA, $F7
    db $EF, $EE, "that I was foolish", $EF, $EE, "and reckless.", $FA, $F7
    db $EF, $EE, "To see someone as", $EF, $EE, "young as you", $FA, $F7
    db $EF, $EE, "traveling with", $EF, $EE, "monsters", $A4, $FA, $F7
    db $EF, $EE, "You're nothing if", $EF, $EE, "not reckless!", $F7
    db $F0

String_83_00_B4:: ; heuristic: string; C0
Data_083_7763:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you see a", $F1
    db "fellow traveler,", $FA, $F7
    db $EF, $EE, "talk to him or her", $EF, $EE, "right away.", $FA, $F7
    db $EF, $EE, "They'll wander off", $EF, $EE, "if you don't.", $F7
    db $F0

String_83_00_B5:: ; heuristic: string; C0
Data_083_77CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I see something", $F1
    db "in your eyes", $A4, $FA, $F7
    db $EF, $EE, "I get the feeling", $EF, $EE, "that you're going", $FA, $F7
    db $EF, $EE, "to do something", $EF, $EE, "extraordinary.", $F7
    db $F0

String_83_00_B6:: ; heuristic: string; C0
Data_083_7837:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The personality", $F1
    db "of a monster gets", $FA, $F7
    db $EF, $EE, "changed by your", $EF, $EE, "battle plans.", $FA, $F7
    db $EF, $EE, "If you don't train", $EF, $EE, "it properly, it", $FA, $F7
    db $EF, $EE, "may not battle", $EF, $EE, "effectively.", $F7
    db $F0

String_83_00_B7:: ; heuristic: string; C0
Data_083_78C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster is", $F1
    db "made to ", $95, "Charge", $95, $FA, $F7
    db $EF, $EE, "all the time, it", $EF, $EE, "will become more", $FA, $F7
    db $EF, $EE, "brave, but less", $EF, $EE, "sensible.", $F7
    db $F0

String_83_00_B8:: ; heuristic: string; C0
Data_083_792E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster is", $F1
    db "given a ", $95, "Mixed", $95, $FA, $F7
    db $EF, $EE, "plan, it becomes", $EF, $EE, "more sensible.", $FA, $F7
    db $EF, $EE, "But it also turns", $EF, $EE, "less kindly.", $F7
    db $F0

String_83_00_B9:: ; heuristic: string; C0
Data_083_7999:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster is", $F1
    db "ordered to use", $FA, $F7
    db $EF, $EE, $95, "Defense", $95, " in", $EF, $EE, "battle, it will", $FA, $F7
    db $EF, $EE, "turn increasingly", $EF, $EE, "compassionate.", $FA, $F7
    db $EF, $EE, "But, it also turns", $EF, $EE, "less brave.", $F7
    db $F0

String_83_00_BA:: ; heuristic: string; C0
Data_083_7A25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster's", $F1
    db "personality is", $FA, $F7
    db $EF, $EE, $95, "Coward", $95, " or ", $95, "EZ", $EF, $EE, "going", $95, ", it's not", $FA, $F7
    db $EF, $EE, "really suitable", $EF, $EE, "for attacking.", $F7
    db $F0

String_83_00_BB:: ; heuristic: string; C0
Data_083_7A8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster's", $F1
    db "personality is", $FA, $F7
    db $EF, $EE, $95, "Daredevil", $95, " or", $EF, $EE, $95, "Carefree", $95, ", it's", $FA, $F7
    db $EF, $EE, "not good in a", $EF, $EE, "supporting role.", $F7
    db $F0

String_83_00_BC:: ; heuristic: string; C0
Data_083_7AF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster's", $F1
    db "personality is", $FA, $F7
    db $EF, $EE, $95, "Snobby", $95, " or", $EF, $EE, $95, "Spoiled", $95, ", don't", $FA, $F7
    db $EF, $EE, "expect it to make", $EF, $EE, "a good healer.", $F7
    db $F0

String_83_00_BD:: ; heuristic: string; C0
Data_083_7B5A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A monster's", $F1
    db "personality is an", $FA, $F7
    db $EF, $EE, "important factor", $EF, $EE, "in battle.", $FA, $F7
    db $EF, $EE, "Be sure to check", $EF, $EE, "them in advance.", $F7
    db $F0

String_83_00_BE:: ; heuristic: string; C0
Data_083_7BC1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I see a dark", $F1
    db "shadow casting its", $FA, $F7
    db $EF, $EE, "pall over your", $EF, $EE, "monsters", $A4, $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "an evil sign.", $FA, $F7
    db $EF, $EE, "Don't push them", $EF, $EE, "too hard.", $F7
    db $F0

String_83_00_BF:: ; heuristic: string; C0
Data_083_7C42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Just pushing me", $F1
    db "won't budge me!", $F7
    db $F0

String_83_00_C0:: ; heuristic: string; C0
Data_083_7C65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The personality", $F1
    db "of a monster", $FA, $F7
    db $EF, $EE, "changes depending", $EF, $EE, "on battle plans.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

String_83_00_C1:: ; heuristic: string; C0
Data_083_7CCC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Seeds and nuts", $F1
    db "can raise monster", $FA, $F7
    db $EF, $EE, "stats even if they", $EF, $EE, "can't level up.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

String_83_00_C2:: ; heuristic: string; C0
Data_083_7D36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How quickly", $F1
    db "monsters level up", $FA, $F7
    db $EF, $EE, "varies from family", $EF, $EE, "to family.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

String_83_00_C3:: ; heuristic: string; C0
Data_083_7D99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monster families", $F1
    db "have different", $FA, $F7
    db $EF, $EE, "resistance levels", $EF, $EE, "to spell types.", $FA, $F7
    db $EF, $EE, "Some are tough", $EF, $EE, "against fire, and", $FA, $F7
    db $EF, $EE, "weak to water, for", $EF, $EE, "instance.", $F7
    db $F0

String_83_00_C4:: ; heuristic: string; C0
Data_083_7E29:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A monster marked", $F1
    db "with a ", $AC, " won't grow", $FA, $F7
    db $EF, $EE, "anymore. Its level", $EF, $EE, "is maxed out.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

String_83_00_C5:: ; heuristic: string; C0
Data_083_7E95:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e seen your", $F1
    db "monsters score", $FA, $F7
    db $EF, $EE, "critical hits,", $EF, $EE, "right?", $FA, $F7
    db $EF, $EE, "There's a family", $EF, $EE, "that gets more", $FA, $F7
    db $EF, $EE, "critical hits than", $EF, $EE, "others.", $F7
    db $F0

String_83_00_C6:: ; heuristic: string; C0
Data_083_7F14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Y-your monsters", $F1
    db "are staring at me", $A4, $FA, $F7
    db $EF, $EE, "And", $A4, " And they're", $EF, $EE, "drooling!", $F7
    db $F0
    ds $A7, $00
