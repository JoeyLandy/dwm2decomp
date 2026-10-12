SECTION "Bank 28", ROMX[$4000], BANK[$28]
    db $28

; if wC529 < $DA, BeginStringDisplay with this bank's table; otherwise far-calls Func_097_4001
; 5 call sites from 5 routines (e.g. ShowString_Bank28, DebugMessageTest_Update_Case02, ScriptCommand09_Case01_Sub01_Case00, ShowMessageHL_Case00, ...)
; reads: wStringIndex
BeginStringDisplay_Bank28::
Func_028_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $DA
    jr c, Jump_028_400F
    farcall BeginStringDisplay_Bank28_Sub01
    ret

Jump_028_400F::
    ld de, MessageStrings_Bank28
    call BeginStringDisplay
    ret

; message bank $28: when wStringIndex < $DA, CopyStringToBuffer with this bank's table Data_028_4032; otherwise far-calls Func_097_4010 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank28:: ; heuristic: follows a terminator; C0
Func_028_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $DA
    jr c, Jump_028_4024
    farcall CopyStringToBuffer_Bank28_Overflow
    ret

Jump_028_4024::
    ld de, MessageStrings_Bank28
    call CopyStringToBuffer
    ret

; Func_028_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 1 call site from 1 routine (e.g. SceneHomecoming_Case29)
ShowString_Bank28::
Func_028_402B:: ; address name
    call BeginStringDisplay_Bank28
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_28_4032::
MessageStrings_Bank28:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_028_4032:: ; address name
    dw StringList_28_4034 ; id 0

; E-0217 (derived: category list of StringCategories_28_4032; one pointer per wStringIndex)
; record: string
StringList_28_4034::
Data_028_4034:: ; address name
    dw Message_00_00 ; id 0
    dw Message_00_01 ; id 1
    dw Message_00_02 ; id 2
    dw Message_00_03 ; id 3
    dw Message_00_04 ; id 4
    dw Message_00_05 ; id 5
    dw Message_00_06 ; id 6
    dw Message_00_07 ; id 7
    dw Message_00_08 ; id 8
    dw Message_00_09 ; id 9
    dw Message_00_0A ; id 10
    dw Message_00_0B ; id 11
    dw Message_00_0C ; id 12
    dw Message_00_0D ; id 13
    dw Message_00_0E ; id 14
    dw Message_00_0F ; id 15
    dw Message_00_10 ; id 16
    dw Message_00_11 ; id 17
    dw Message_00_12 ; id 18
    dw Message_00_13 ; id 19
    dw Message_00_14 ; id 20
    dw Message_00_15 ; id 21
    dw Message_00_16 ; id 22
    dw Message_00_17 ; id 23
    dw Message_00_18 ; id 24
    dw Message_00_19 ; id 25
    dw Message_00_1A ; id 26
    dw Message_00_1B ; id 27
    dw Message_00_1C ; id 28
    dw Message_00_1D ; id 29
    dw Message_00_1E ; id 30
    dw Message_00_1F ; id 31
    dw Message_00_20 ; id 32
    dw Message_00_21 ; id 33
    dw Message_00_22 ; id 34
    dw Message_00_23 ; id 35
    dw Message_00_24 ; id 36
    dw Message_00_25 ; id 37
    dw Message_00_26 ; id 38
    dw Message_00_27 ; id 39
    dw Message_00_28 ; id 40
    dw Message_00_29 ; id 41
    dw Message_00_2A ; id 42
    dw Message_00_2B ; id 43
    dw Message_00_2C ; id 44
    dw Message_00_2D ; id 45
    dw Message_00_2E ; id 46
    dw Message_00_2F ; id 47
    dw Message_00_30 ; id 48
    dw Message_00_31 ; id 49
    dw Message_00_32 ; id 50
    dw Message_00_33 ; id 51
    dw Message_00_34 ; id 52
    dw Message_00_35 ; id 53
    dw Message_00_36 ; id 54
    dw Message_00_37 ; id 55
    dw Message_00_38 ; id 56
    dw Message_00_39 ; id 57
    dw Message_00_3A ; id 58
    dw Message_00_3B ; id 59
    dw Message_00_3C ; id 60
    dw Message_00_3D ; id 61
    dw Message_00_3E ; id 62
    dw Message_00_3F ; id 63
    dw Message_00_40 ; id 64
    dw Message_00_41 ; id 65
    dw Message_00_42 ; id 66
    dw Message_00_43 ; id 67
    dw Message_00_44 ; id 68
    dw Message_00_45 ; id 69
    dw Message_00_46 ; id 70
    dw Message_00_47 ; id 71
    dw Message_00_48 ; id 72
    dw Message_00_49 ; id 73
    dw Message_00_4A ; id 74
    dw Message_00_4B ; id 75
    dw Message_00_4C ; id 76
    dw Message_00_4D ; id 77
    dw Message_00_4E ; id 78
    dw Message_00_4F ; id 79
    dw Message_00_50 ; id 80
    dw Message_00_51 ; id 81
    dw Message_00_52 ; id 82
    dw Message_00_53 ; id 83
    dw Message_00_54 ; id 84
    dw Message_00_55 ; id 85
    dw Message_00_56 ; id 86
    dw Message_00_56 ; id 87
    dw Message_00_56 ; id 88
    dw Message_00_59 ; id 89
    dw Message_00_5A ; id 90
    dw Message_00_5B ; id 91
    dw Message_00_5C ; id 92
    dw Message_00_5D ; id 93
    dw Message_00_5E ; id 94
    dw Message_00_5F ; id 95
    dw Message_00_60 ; id 96
    dw Message_00_61 ; id 97
    dw Message_00_62 ; id 98
    dw Message_00_63 ; id 99
    dw Message_00_64 ; id 100
    dw Message_00_65 ; id 101
    dw Message_00_66 ; id 102
    dw Message_00_67 ; id 103
    dw Message_00_68 ; id 104
    dw Message_00_69 ; id 105
    dw Message_00_6A ; id 106
    dw Message_00_6B ; id 107
    dw Message_00_6C ; id 108
    dw Message_00_6D ; id 109
    dw Message_00_6E ; id 110
    dw Message_00_6F ; id 111
    dw Message_00_70 ; id 112
    dw Message_00_71 ; id 113
    dw Message_00_72 ; id 114
    dw Message_00_73 ; id 115
    dw Message_00_74 ; id 116
    dw Message_00_75 ; id 117
    dw Message_00_76 ; id 118
    dw Message_00_77 ; id 119
    dw Message_00_78 ; id 120
    dw Message_00_79 ; id 121
    dw Message_00_7A ; id 122
    dw Message_00_7B ; id 123
    dw Message_00_7C ; id 124
    dw Message_00_7D ; id 125
    dw Message_00_7E ; id 126
    dw Message_00_7F ; id 127
    dw Message_00_80 ; id 128
    dw Message_00_81 ; id 129
    dw Message_00_82 ; id 130
    dw Message_00_83 ; id 131
    dw Message_00_84 ; id 132
    dw Message_00_85 ; id 133
    dw Message_00_86 ; id 134
    dw Message_00_87 ; id 135
    dw Message_00_88 ; id 136
    dw Message_00_89 ; id 137
    dw Message_00_8A ; id 138
    dw Message_00_8B ; id 139
    dw Message_00_8C ; id 140
    dw Message_00_8D ; id 141
    dw Message_00_8E ; id 142
    dw Message_00_8F ; id 143
    dw Message_00_90 ; id 144
    dw Message_00_91 ; id 145
    dw Message_00_92 ; id 146
    dw Message_00_93 ; id 147
    dw Message_00_94 ; id 148
    dw Message_00_95 ; id 149
    dw Message_00_96 ; id 150
    dw Message_00_97 ; id 151
    dw Message_00_98 ; id 152
    dw Message_00_99 ; id 153
    dw Message_00_9A ; id 154
    dw Message_00_9B ; id 155
    dw Message_00_9B ; id 156
    dw Message_00_9B ; id 157
    dw Message_00_9B ; id 158
    dw Message_00_9B ; id 159
    dw Message_00_9B ; id 160
    dw Message_00_A1 ; id 161
    dw Message_00_A2 ; id 162
    dw Message_00_A3 ; id 163
    dw Message_00_A4 ; id 164
    dw Message_00_A5 ; id 165
    dw Message_00_A6 ; id 166
    dw Message_00_A7 ; id 167
    dw Message_00_A8 ; id 168
    dw Message_00_A9 ; id 169
    dw Message_00_AA ; id 170
    dw Message_00_AB ; id 171
    dw Message_00_AC ; id 172
    dw Message_00_AC ; id 173
    dw Message_00_AC ; id 174
    dw Message_00_AC ; id 175
    dw Message_00_AC ; id 176
    dw Message_00_AC ; id 177
    dw Message_00_AC ; id 178
    dw Message_00_AC ; id 179
    dw Message_00_AC ; id 180
    dw Message_00_AC ; id 181
    dw Message_00_AC ; id 182
    dw Message_00_AC ; id 183
    dw Message_00_AC ; id 184
    dw Message_00_AC ; id 185
    dw Message_00_AC ; id 186
    dw Message_00_AC ; id 187
    dw Message_00_AC ; id 188
    dw Message_00_AC ; id 189
    dw Message_00_AC ; id 190
    dw Message_00_AC ; id 191
    dw Message_00_AC ; id 192
    dw Message_00_AC ; id 193
    dw Message_00_AC ; id 194
    dw Message_00_AC ; id 195
    dw Message_00_AC ; id 196
    dw Message_00_AC ; id 197
    dw Message_00_AC ; id 198
    dw Message_00_AC ; id 199
    dw Message_00_AC ; id 200
    dw Message_00_AC ; id 201
    dw Message_00_AC ; id 202
    dw Message_00_AC ; id 203
    dw Message_00_AC ; id 204
    dw Message_00_AC ; id 205
    dw Message_00_AC ; id 206
    dw Message_00_AC ; id 207
    dw Message_00_AC ; id 208
    dw Message_00_D1 ; id 209
    dw Message_00_D2 ; id 210
    dw Message_00_D3 ; id 211
    dw Message_00_D4 ; id 212
    dw Message_00_D5 ; id 213
    dw Message_00_D6 ; id 214
    dw Message_00_D7 ; id 215
    dw Message_00_D8 ; id 216
    dw Message_00_D9 ; id 217

Message_00_00:: ; heuristic: string; C0
Data_028_41E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In the middle of", $F1
    db "the sea in the", $FA, $F7
    db $EF, $EE, "south floats the", $EF, $EE, "island GreatLog.", $FA, $F7
    db $EF, $EE, "To this eternally", $EF, $EE, "warm and natural", $FA, $F7
    db $EF, $EE, "setting, a family", $EF, $EE, "of monster farmers", $FA, $F7
    db $EF, $EE, "was headed to", $EF, $EE, "start a new life", $A4, $F7
    db $F0

Message_00_01:: ; heuristic: string; C0
Data_028_42A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0!", $F1
    db "Papa's calling.", $FA, $F7
    db $EF, $EE, "He's at the stern.", $EF, $EE, "Hustle, hustle!", $F7
    db $F0

Message_00_02:: ; heuristic: string; C0
Data_028_42E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " There you", $F1
    db "are, big brother!", $FA, $F7
    db $EF, $EE, "Papa's calling at", $EF, $EE, "the stern.", $FA, $F7
    db $EF, $EE, "You", $44, " better go", $EF, $EE, "right away!", $F7
    db $F0

Message_00_03:: ; heuristic: string; C0
Data_028_4347:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What's wrong,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Papa's calling for", $EF, $EE, "you!", $F7
    db $F0

Message_00_04:: ; heuristic: string; C0
Data_028_437B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hurry! Papa", $F1
    db "will be angry!", $F7
    db $F0

Message_00_05:: ; heuristic: string; C0
Data_028_439E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You folks run a", $F1
    db "monster farm?", $FA, $F7
    db $EF, $EE, "We", $42, "e never had", $EF, $EE, "monsters on our", $FA, $F7
    db $EF, $EE, "ship before this.", $EF, $EE, "It's amazing!", $F7
    db $F0

Message_00_06:: ; heuristic: string; C0
Data_028_4406:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There's a spirit", $F1
    db "in GreatLog that's", $FA, $F7
    db $EF, $EE, "famous for getting", $EF, $EE, "into mischief.", $FA, $F7
    db $EF, $EE, "It's named", $A4, $EF, $EE, "Waru something.", $F7
    db $F0

Message_00_07:: ; heuristic: string; C0
Data_028_4471:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Sailing is sure", $EF, $EE, "exhilarating. ", $FA, $F7
    db $EF, $EE, "Right?", $EF, $EE, $FF, $F0

Message_00_08:: ; heuristic: string; C0
Data_028_44A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good. That's", $F1
    db "good to hear!", $FA, $F7
    db $EF, $EE, "You have got", $EF, $EE, "potential!", $F7
    db $F0

Message_00_09:: ; heuristic: string; C0
Data_028_44DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is that so?", $F1
    db "Too bad!", $FA, $F7
    db $EF, $EE, "You'll get used to", $EF, $EE, "it someday.", $F7
    db $F0

Message_00_0A:: ; heuristic: string; C0
Data_028_4516:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We'll soon be", $F1
    db "reaching GreatLog.", $FA, $F7
    db $EF, $EE, "I wonder, what", $EF, $EE, "will it be like?", $FA, $F7
    db $EF, $EE, "Isn't it exciting", $EF, $EE, "my dear child?", $F7
    db $F0

Message_00_0B:: ; heuristic: string; C0
Data_028_4582:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog's King", $F1
    db "asked us to settle", $FA, $F7
    db $EF, $EE, "in the kingdom and", $EF, $EE, "run our farm.", $FA, $F7
    db $EF, $EE, "He recognizes our", $EF, $EE, "worth, wahahah!", $FA, $F7
    db $EF, $EE, "This will be our", $EF, $EE, "new life.", $FA, $F7
    db $EF, $EE, "You're a growing", $EF, $EE, "boy, so I'll need", $FA, $F7
    db $EF, $EE, "you to be reliable", $EF, $EE, "and responsible.", $FA, $F7
    db $EF, $EE, "Do we have an", $EF, $EE, "understanding?", $FA, $F7
    db $EF, $EE, "Good. Stay with", $EF, $EE, "Tara, will you?", $F7
    db $F0

Message_00_0C:: ; heuristic: string; C0
Data_028_46A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog's King", $F1
    db "asked us to settle", $FA, $F7
    db $EF, $EE, "in the kingdom and", $EF, $EE, "run our farm.", $FA, $F7
    db $EF, $EE, "He recognizes our", $EF, $EE, "worth, wahahah!", $FA, $F7
    db $EF, $EE, "This will be our", $EF, $EE, "new life.", $FA, $F7
    db $EF, $EE, "You're growing up,", $EF, $EE, "so you can't be a", $FA, $F7
    db $EF, $EE, "little baby", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "Do we have an", $EF, $EE, "understanding?", $FA, $F7
    db $EF, $EE, "Good. Play with", $EF, $EE, "Cobi, will you?", $F7
    db $F0

Message_00_0D:: ; heuristic: string; C0
Data_028_47B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When our farm", $F1
    db "gets established", $FA, $F7
    db $EF, $EE, "in the new land,", $EF, $EE, "I'll make life", $FA, $F7
    db $EF, $EE, "easier for mother", $EF, $EE, "and you two.", $FA, $F7
    db $EF, $EE, "We should be in", $EF, $EE, "GreatLog soon.", $F7
    db $F0

Message_00_0E:: ; heuristic: string; C0
Data_028_4845:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Worried about", $F1
    db "your monsters?", $FA, $F7
    db $EF, $EE, "Don't be! They're", $EF, $EE, "being quiet.", $F7
    db $F0

Message_00_0F:: ; heuristic: string; C0
Data_028_4887:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "clean water.", $F7
    db $F0

Message_00_10:: ; heuristic: string; C0
Data_028_48C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "Freshly caught", $EF, $EE, "fish were inside.", $F7
    db $F0

Message_00_11:: ; heuristic: string; C0
Data_028_4906:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0!", $F1
    db "They said GreatLog", $FA, $F7
    db $EF, $EE, "will be in sight", $EF, $EE, "soon.", $F7
    db $F0

Message_00_12:: ; heuristic: string; C0
Data_028_4940:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Land ho!", $F1
    db "There's GreatLog!", $F7
    db $F0

Message_00_13:: ; heuristic: string; C0
Data_028_495E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "GreatLog will be", $EF, $EE, "in sight soon.", $F7
    db $F0

Message_00_14:: ; heuristic: string; C0
Data_028_4999:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "This is a tale of", $F1
    db "children who came", $FA, $F7
    db $EF, $EE, "to the Kingdom of", $EF, $EE, "GreatLog", $A4, $F7
    db $F0

Message_00_15:: ; heuristic: string; C0
Data_028_49DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Listen you two!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "Quit your horsing", $EF, $EE, "around and go", $FA, $F7
    db $EF, $EE, "help your mother.", $EF, $EE, "Do you hear me?", $F7
    db $F0

Message_00_16:: ; heuristic: string; C0
Data_028_4A3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It seems to me", $F1
    db "that the people", $FA, $F7
    db $EF, $EE, "here aren't very", $EF, $EE, "used to seeing", $FA, $F7
    db $EF, $EE, "monsters. We'll", $EF, $EE, "have to make sure", $FA, $F7
    db $EF, $EE, "that they don't go", $EF, $EE, "wander off on", $FA, $F7
    db $EF, $EE, "their own. Anyway,", $EF, $EE, "go help your", $FA, $F7
    db $EF, $EE, "mother.", $EF, $EE, $F7
    db $F0

Message_00_17:: ; heuristic: string; C0
Data_028_4AFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Yo, did you", $F1
    db "enjoy the voyage?", $FA, $F7
    db $EF, $EE, "The name's Slash,", $EF, $EE, "glad to know you!", $FA, $F7
    db $EF, $EE, "Slash", $A3, " I guard the", $EF, $EE, "farm here.", $FA, $F7
    db $EF, $EE, "You can consider", $EF, $EE, "me the boss!", $FA, $F7
    db $EF, $EE, "If you need any", $EF, $EE, "advice, I'm here!", $F7
    db $F0

Message_00_18:: ; heuristic: string; C0
Data_028_4BB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " If you're", $F1
    db "in need of advice,", $FA, $F7
    db $EF, $EE, "think of me!", $EF, $EE, "I'm the one!", $F7
    db $F0

Message_00_19:: ; heuristic: string; C0
Data_028_4BF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There aren't many", $F1
    db "friends here.", $FA, $F7
    db $EF, $EE, "It's lonely for an", $EF, $EE, "ant like me", $A4, $F7
    db $F0

Message_00_1A:: ; heuristic: string; C0
Data_028_4C38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I accidentally", $F1
    db "went outside.", $FA, $F7
    db $EF, $EE, "People gave me the", $EF, $EE, "eye. Whoopsy.", $F7
    db $F0

Message_00_1B:: ; heuristic: string; C0
Data_028_4C7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This hay is", $F1
    db "pretty good.", $FA, $F7
    db $EF, $EE, "Maybe I can use", $EF, $EE, "this", $A4, $F7
    db $F0

Message_00_1C:: ; heuristic: string; C0
Data_028_4CB5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pump.", $FA, $F7
    db $EF, $EE, "It's rusted and", $EF, $EE, "old, but it looks", $FA, $F7
    db $EF, $EE, "to be in working", $EF, $EE, "condition.", $F7
    db $F0

Message_00_1D:: ; heuristic: string; C0
Data_028_4D10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It is full of", $EF, $EE, "dried hay.", $F7
    db $F0

Message_00_1E:: ; heuristic: string; C0
Data_028_4D49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You", $42, "e come at", $F1
    db "the right time.", $FA, $F7
    db $EF, $EE, "Grandma sent her", $EF, $EE, "homemade nut pie", $FA, $F7
    db $EF, $EE, "for us to enjoy at", $EF, $EE, "our new homestead.", $FA, $F7
    db $EF, $EE, "I'm too busy to go", $EF, $EE, "get it right now,", $FA, $F7
    db $EF, $EE, "so can the two of", $EF, $EE, "you go instead?", $F7
    db $F0

Message_00_1F:: ; heuristic: string; C0
Data_028_4E09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Sure, Mama!", $F1
    db "We'll be fine.", $F7
    db $F0

Message_00_20:: ; heuristic: string; C0
Data_028_4E2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Good, that's", $F1
    db "settled then.", $FA, $F7
    db $EF, $EE, "The Vault is west", $EF, $EE, "of the Farm.", $FA, $F7
    db $EF, $EE, "Don't dawdle, and", $EF, $EE, "be careful.", $F7
    db $F0

Message_00_21:: ; heuristic: string; C0
Data_028_4E8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " We'll be OK!", $F1
    db "I'm going too.", $F7
    db $F0

Message_00_22:: ; heuristic: string; C0
Data_028_4EAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Go to the Vault", $F1
    db "and pick up the", $FA, $F7
    db $EF, $EE, "nut pie that", $EF, $EE, "Grandma sent.", $FA, $F7
    db $EF, $EE, "The Vault is west", $EF, $EE, "of the Farm.", $F7
    db $F0

Message_00_23:: ; heuristic: string; C0
Data_028_4F15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Behavior of Wild", $EF, $EE, "Monsters", $A4, $FA, $F7
    db $EF, $EE, "Wild monsters are", $EF, $EE, "dangerous, but", $FA, $F7
    db $EF, $EE, "they can be tamed", $EF, $EE, "and trained.", $95, $F7
    db $F0

Message_00_24:: ; heuristic: string; C0
Data_028_4F99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "Children's clothes", $EF, $EE, "were inside.", $F7
    db $F0

Message_00_25:: ; heuristic: string; C0
Data_028_4FD5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It smelled of sun-", $EF, $EE, "dried laundry.", $F7
    db $F0

Message_00_26:: ; heuristic: string; C0
Data_028_5014:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "It smelled of", $EF, $EE, "fresh bread.", $F7
    db $F0

Message_00_27:: ; heuristic: string; C0
Data_028_5049:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "clear water.", $F7
    db $F0

Message_00_28:: ; heuristic: string; C0
Data_028_5083:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e heard that", $F1
    db "there are monster", $FA, $F7
    db $EF, $EE, "masters in this", $EF, $EE, "kingdom.", $FA, $F7
    db $EF, $EE, "Have I told you", $EF, $EE, "about them?", $FF, $F0

Message_00_29:: ; heuristic: string; C0
Data_028_50E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? Well, that's", $F1
    db "fine then.", $FA, $F7
    db $EF, $EE, "Go on, run your", $EF, $EE, "mother's errand.", $F7
    db $F0

Message_00_2A:: ; heuristic: string; C0
Data_028_5128:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monster masters", $F1
    db "are those people", $FA, $F7
    db $EF, $EE, "who tame and train", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "They commune with", $EF, $EE, "them and the", $FA, $F7
    db $EF, $EE, "monsters grow.", $EF, $EE, $F7
    db $F0

Message_00_2B:: ; heuristic: string; C0
Data_028_51A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Hahah! ", $F9, "0", $F1
    db "won't last a day!", $F7
    db $F0

Message_00_2C:: ; heuristic: string; C0
Data_028_51C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I aspired to be", $F1
    db "one long ago", $A4, $FA, $F7
    db $EF, $EE, "Ahem! Go help your", $EF, $EE, "mother now.", $F7
    db $F0

Message_00_2D:: ; heuristic: string; C0
Data_028_520D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother", $F1
    db "can't do it then.", $F7
    db $F0

Message_00_2E:: ; heuristic: string; C0
Data_028_5232:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Go help your", $F1
    db "mother now.", $F7
    db $F0

Message_00_2F:: ; heuristic: string; C0
Data_028_524F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If some monster", $F1
    db "masters keep their", $FA, $F7
    db $EF, $EE, "monsters with us,", $EF, $EE, "the Farm is sure", $FA, $F7
    db $EF, $EE, "to become busier", $EF, $EE, "and lively.", $F7
    db $F0

Message_00_30:: ; heuristic: string; C0
Data_028_52BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, so these", $F1
    db "are the newcomers?", $FA, $F7
    db $EF, $EE, "Hehehe, this is", $EF, $EE, "going to be fun", $A4, $F7
    db $F0

Message_00_31:: ; heuristic: string; C0
Data_028_5308:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " C'mon, Warubou!", $F1
    db $F7
    db $F0

Message_00_32:: ; heuristic: string; C0
Data_028_531C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello, there!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "You must be the", $EF, $EE, "farm kids!", $FA, $F7
    db $EF, $EE, "The Vault is west,", $EF, $EE, "then a bit north.", $F7
    db $F0

Message_00_33:: ; heuristic: string; C0
Data_028_5378:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " It's", $A4, " all", $F1
    db "spinning around", $A4, $FA, $F7
    db $EF, $EE, "That rotten little", $EF, $EE, "Prince and that", $FA, $F7
    db $EF, $EE, "elemental sidekick", $EF, $EE, "of his!", $F7
    db $F0

Message_00_34:: ; heuristic: string; C0
Data_028_53E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The horrid", $F1
    db "Prince and that", $FA, $F7
    db $EF, $EE, "elemental sidekick", $EF, $EE, "of his!", $F7
    db $F0

Message_00_35:: ; heuristic: string; C0
Data_028_541E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King is too", $F1
    db "lenient on Prince", $FA, $F7
    db $EF, $EE, "Kameha, his only", $EF, $EE, "son.", $FA, $F7
    db $EF, $EE, "That's why we can't", $EF, $EE, "complain about all", $FA, $F7
    db $EF, $EE, "the trouble he", $EF, $EE, "causes.", $F7
    db $F0

Message_00_36:: ; heuristic: string; C0
Data_028_54A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There were many", $F1
    db "wild monsters in", $FA, $F7
    db $EF, $EE, "this world in the", $EF, $EE, "past.", $FA, $F7
    db $EF, $EE, "The elemental", $EF, $EE, "spirits decided to", $FA, $F7
    db $EF, $EE, "send the monsters", $EF, $EE, "to other worlds", $FA, $F7
    db $EF, $EE, "until they were", $EF, $EE, "sure that humans", $FA, $F7
    db $EF, $EE, "could live safely", $EF, $EE, "with monsters.", $F7
    db $F0

Message_00_37:: ; heuristic: string; C0
Data_028_5578:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But the chest was", $EF, $EE, "locked tight.", $F7
    db $F0

Message_00_38:: ; heuristic: string; C0
Data_028_55B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "A large, salted", $EF, $EE, "fish was inside.", $F7
    db $F0

Message_00_39:: ; heuristic: string; C0
Data_028_55F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey! You brats!", $F1
    db "Scram!", $FA, $F7
    db $EF, $EE, "Hands off my", $EF, $EE, "merchandise!", $F7
    db $F0

Message_00_3A:: ; heuristic: string; C0
Data_028_5631:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That weird ape", $F1
    db "thing is Warubou,", $FA, $F7
    db $EF, $EE, "GreatLog's", $EF, $EE, "elemental spirit.", $FA, $F7
    db $EF, $EE, "It's always up to", $EF, $EE, "mischief with", $FA, $F7
    db $EF, $EE, "Prince Kameha.", $EF, $EE, "What a pair!", $F7
    db $F0

Message_00_3B:: ; heuristic: string; C0
Data_028_56B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This palm tree", $F1
    db "is GreatLog.", $FA, $F7
    db $EF, $EE, "We", $42, "e bored out", $EF, $EE, "the inside of this", $FA, $F7
    db $EF, $EE, "enormous tree and", $EF, $EE, "made it our home.", $F7
    db $F0

Message_00_3C:: ; heuristic: string; C0
Data_028_5727:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're the kids", $F1
    db "from the new farm.", $FA, $F7
    db $EF, $EE, "I'm a monster", $EF, $EE, "master myself.", $FA, $F7
    db $EF, $EE, "I'll have to use", $EF, $EE, "your farm soon.", $F7
    db $F0

Message_00_3D:: ; heuristic: string; C0
Data_028_5791:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We live inside", $F1
    db "here.", $FA, $F7
    db $EF, $EE, "I'm keeping my eyes", $EF, $EE, "out for Prince", $FA, $F7
    db $EF, $EE, "Kameha and his", $EF, $EE, "sidekick.", $F7
    db $F0

Message_00_3E:: ; heuristic: string; C0
Data_028_57ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog's major", $F1
    db "facilities are", $FA, $F7
    db $EF, $EE, "situated above", $EF, $EE, "here.", $FA, $F7
    db $EF, $EE, "They're no place", $EF, $EE, "for kids. Shoo!", $F7
    db $F0

Message_00_3F:: ; heuristic: string; C0
Data_028_584D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Inside the well", $F1
    db "is the Log's Navel.", $FA, $F7
    db $EF, $EE, "It's said to be", $EF, $EE, "the center of", $FA, $F7
    db $EF, $EE, "GreatLog.", $EF, $EE, "But it's not safe.", $FA, $F7
    db $EF, $EE, "Don't go in there.", $EF, $EE, $F7
    db $F0

Message_00_40:: ; heuristic: string; C0
Data_028_58CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " On this island,", $F1
    db "every day goes by", $FA, $F7
    db $EF, $EE, "without anything", $EF, $EE, "being different.", $FA, $F7
    db $EF, $EE, "But it's never", $EF, $EE, "boring.", $FA, $F7
    db $EF, $EE, "I consider it", $EF, $EE, "heavenly luxury!", $F7
    db $F0

Message_00_41:: ; heuristic: string; C0
Data_028_5955:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Warubou is the", $F1
    db "island's spirit.", $FA, $F7
    db $EF, $EE, "So we can't really", $EF, $EE, "complain about", $FA, $F7
    db $EF, $EE, "all the mischief", $EF, $EE, "it gets into", $A4, $F7
    db $F0

Message_00_42:: ; heuristic: string; C0
Data_028_59C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Danger!", $EF, $EE, "Stay clear!", $95, $F7
    db $F0

Message_00_43:: ; heuristic: string; C0
Data_028_59ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "odd object.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "plugging a hole", $A4, $F7
    db $F0

Message_00_44:: ; heuristic: string; C0
Data_028_5A2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "peculiar door.", $FA, $F7
    db $EF, $EE, "It has an oddly", $EF, $EE, "shaped keyhole", $A4, $F7
    db $F0

Message_00_45:: ; heuristic: string; C0
Data_028_5A72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You must be the", $F1
    db "farm kids.", $FA, $F7
    db $EF, $EE, "Your grandma sent", $EF, $EE, "a package for you.", $FA, $F7
    db $EF, $EE, "It smells really", $EF, $EE, "delicious!", $FA, $F7
    db $EF, $EE, "Here you go! Be", $EF, $EE, "careful with it!", $F7
    db $F0

Message_00_46:: ; heuristic: string; C0
Data_028_5AFF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Thanks for", $F1
    db "coming by.", $FA, $F7
    db $EF, $EE, "I'll always be", $EF, $EE, "here to serve you!", $F7
    db $F0

Message_00_47:: ; heuristic: string; C0
Data_028_5B3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "notice.", $FA, $F7
    db $EF, $EE, $95, "We guarantee the", $EF, $EE, "safekeeping of", $FA, $F7
    db $EF, $EE, "your precious", $EF, $EE, "items and money!", $95, $F7
    db $F0

Message_00_48:: ; heuristic: string; C0
Data_028_5B9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm Prince Kameha", $EF, $EE, "of GreatLog!", $FA, $F7
    db $EF, $EE, "You may not pass,", $EF, $EE, "peasants!", $F7
    db $F0

Message_00_49:: ; heuristic: string; C0
Data_028_5BDF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wahahah!", $F1
    db "No going by me!", $F7
    db $F0

Message_00_4A:: ; heuristic: string; C0
Data_028_5C02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm Warubou,", $F1
    db "GreatLog's spirit!", $FA, $F7
    db $EF, $EE, "Warooh, wa-hey!", $EF, $EE, $F7
    db $F0

Message_00_4B:: ; heuristic: string; C0
Data_028_5C39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " It's a", $F1
    db "dead end, warooh!", $FA, $F7
    db $EF, $EE, "Look for another", $EF, $EE, "way, wa-hey!", $F7
    db $F0

Message_00_4C:: ; heuristic: string; C0
Data_028_5C7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you heard", $F1
    db "about Magic Keys?", $FF, $F0

Message_00_4D:: ; heuristic: string; C0
Data_028_5CA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wow, you kids", $F1
    db "sure learn quick!", $F7
    db $F0

Message_00_4E:: ; heuristic: string; C0
Data_028_5CC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You need Magic", $F1
    db "Keys to open the", $FA, $F7
    db $EF, $EE, "magical door to", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "That's where I get", $EF, $EE, "my monsters.", $F7
    db $F0

Message_00_4F:: ; heuristic: string; C0
Data_028_5D30:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Give me something!", $FA, $F7
    db $EF, $EE, "Then, I'll let you", $EF, $EE, "pass, warooh!", $F7
    db $F0

Message_00_50:: ; heuristic: string; C0
Data_028_5D7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wha", $A4, "?", $F1
    db "I smell something!", $FA, $F7
    db $EF, $EE, "I smell something", $EF, $EE, "tasty.", $F7
    db $F0

Message_00_51:: ; heuristic: string; C0
Data_028_5DBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " What is", $F1
    db "this? Food?", $FA, $F7
    db $EF, $EE, "Perfect! I was", $EF, $EE, "hungry, wa-hey!", $F7
    db $F0

Message_00_52:: ; heuristic: string; C0
Data_028_5DFD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh my, the well", $F1
    db "isn't safe!", $FA, $F7
    db $EF, $EE, "Don't be like", $EF, $EE, "Warubou!", $F7
    db $F0

Message_00_53:: ; heuristic: string; C0
Data_028_5E36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I'm starving!", $F7
    db $F0

Message_00_54:: ; heuristic: string; C0
Data_028_5E56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Gimme it!", $F1
    db "You just ate!", $FA, $F7
    db $EF, $EE, "You grubby little", $EF, $EE, "elemental!", $F7
    db $F0

Message_00_55:: ; heuristic: string; C0
Data_028_5E99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Some prince!", $FA, $F7
    db $EF, $EE, "Dirty mouth!", $EF, $EE, "Come on, warooh!", $F7
    db $F0

Message_00_56:: ; heuristic: string; C0
Data_028_5EDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's ours!", $F1
    db "Give it back!", $F7
    db $F0

Message_00_59:: ; heuristic: string; C0
Data_028_5EFD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-wa-wa-", $F1
    db "wa-wa-hey!", $FA, $F7
    db $EF, $EE, "The Log's Navel's", $EF, $EE, "breached, warooh!", $F7
    db $F0

Message_00_5A:: ; heuristic: string; C0
Data_028_5F43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I", $A4, " It", $A4, $F1
    db "It's not my fault!", $F7
    db $F0

Message_00_5B:: ; heuristic: string; C0
Data_028_5F66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "It's the only way!", $F7
    db $F0

Message_00_5C:: ; heuristic: string; C0
Data_028_5F8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Warooh!", $F1
    db "Will it hold?", $FA, $F7
    db $EF, $EE, "You two, come here", $EF, $EE, "now, warooh!", $F7
    db $F0

Message_00_5D:: ; heuristic: string; C0
Data_028_5FD0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Calm down", $F1
    db "and listen!", $FA, $F7
    db $EF, $EE, "What came out of", $EF, $EE, "the hole now, that", $FA, $F7
    db $EF, $EE, "was the life force", $EF, $EE, "of GreatLog's tree.", $FA, $F7
    db $EF, $EE, "GreatLog is an", $EF, $EE, "island kept afloat", $FA, $F7
    db $EF, $EE, "by the palm tree,", $EF, $EE, "do you see?", $FA, $F7
    db $EF, $EE, "If the palm tree", $EF, $EE, "dies, the island", $FA, $F7
    db $EF, $EE, "sinks into the", $EF, $EE, "deep, deep ocean.", $FA, $F7
    db $EF, $EE, "A plug! That is", $EF, $EE, "what we need!", $FA, $F7
    db $EF, $EE, "A plug to plug the", $EF, $EE, "Log's Navel!", $FA, $F7
    db $EF, $EE, "Hurry, go fetch a", $EF, $EE, "monster master!", $F7
    db $F0

Message_00_5E:: ; heuristic: string; C0
Data_028_6141:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " That's ours!", $F1
    db "Give it back!", $F7
    db $F0

Message_00_5F:: ; heuristic: string; C0
Data_028_6163:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " A new", $F1
    db "plug for the", $FA, $F7
    db $EF, $EE, "Log's Navel needs", $EF, $EE, "a monster master", $FA, $F7
    db $EF, $EE, "to find, yes it", $EF, $EE, "does, warooh!", $FA, $F7
    db $EF, $EE, "Quick, fetch a", $EF, $EE, "monster master!", $F7
    db $F0

Message_00_60:: ; heuristic: string; C0
Data_028_61EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hah? The island's", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "You shouldn't lie", $EF, $EE, "like that ", $F9, "0.", $F7
    db $F0

Message_00_61:: ; heuristic: string; C0
Data_028_6233:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Why won't you", $F1
    db "believe us?", $FA, $F7
    db $EF, $EE, "You stubborn old", $EF, $EE, "goat!", $F7
    db $F0

Message_00_62:: ; heuristic: string; C0
Data_028_626F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Look, an island", $F1
    db "just doesn't sink.", $FA, $F7
    db $EF, $EE, "Listen to yourself", $EF, $EE, "for a moment.", $FA, $F7
    db $EF, $EE, "Anyway, did you", $EF, $EE, "run Mom's errand?", $F7
    db $F0

Message_00_63:: ; heuristic: string; C0
Data_028_62DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Why aren't", $F1
    db "you listening?", $FA, $F7
    db $EF, $EE, "Papa, you're such", $EF, $EE, "a blockhead!", $F7
    db $F0

Message_00_64:: ; heuristic: string; C0
Data_028_6322:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The island's", $F1
    db "sinking, right.", $FA, $F7
    db $EF, $EE, "Not you too.", $EF, $EE, "Look, I'm busy.", $FA, $F7
    db $EF, $EE, "Warubou and the", $EF, $EE, "Prince are just", $FA, $F7
    db $EF, $EE, "pulling your legs,", $EF, $EE, "I'm sure of it.", $F7
    db $F0

Message_00_65:: ; heuristic: string; C0
Data_028_63AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " The island's", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "That's a genuine", $EF, $EE, "crisis!", $FA, $F7
    db $EF, $EE, "I'm right here if", $EF, $EE, "you need any help!", $F7
    db $F0

Message_00_66:: ; heuristic: string; C0
Data_028_6414:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This island is", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "I", $A4, " The tide seems", $EF, $EE, "to be higher!", $F7
    db $F0

Message_00_67:: ; heuristic: string; C0
Data_028_645A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We're going to", $F1
    db "sink?", $FA, $F7
    db $EF, $EE, "I can't swim!", $EF, $EE, "What should I do?", $F7
    db $F0

Message_00_68:: ; heuristic: string; C0
Data_028_6495:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? The island", $F1
    db "is going to sink?", $FA, $F7
    db $EF, $EE, "Are you in Prince", $EF, $EE, "Kameha's gang?", $F7
    db $F0

Message_00_69:: ; heuristic: string; C0
Data_028_64DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Prince Kameha", $F1
    db "was saying the", $FA, $F7
    db $EF, $EE, "same thing a", $EF, $EE, "little while ago.", $F7
    db $F0

Message_00_6A:: ; heuristic: string; C0
Data_028_6523:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Did you get", $F1
    db "the package", $FA, $F7
    db $EF, $EE, "from grandma?", $EF, $EE, $F7
    db $F0

Message_00_6B:: ; heuristic: string; C0
Data_028_6552:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh goodness,", $F1
    db "you're filthy!", $FA, $F7
    db $EF, $EE, "What happened to", $EF, $EE, "you two?", $FA, $F7
    db $EF, $EE, $A4, "Giggle", $A4, " You were", $EF, $EE, "tricked by that", $FA, $F7
    db $EF, $EE, "silly Warubou.", $EF, $EE, "Don't worry.", $FA, $F7
    db $EF, $EE, "The island won't", $EF, $EE, "sink that easily.", $F7
    db $F0

Message_00_6C:: ; heuristic: string; C0
Data_028_65FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You can go out,", $F1
    db "but not too late!", $F7
    db $F0

Message_00_6D:: ; heuristic: string; C0
Data_028_6620:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The island's", $EF, $EE, "going to sink?", $FA, $F7
    db $EF, $EE, "I know, you were", $EF, $EE, "fooled by Warubou.", $FA, $F7
    db $EF, $EE, "Last time he was", $EF, $EE, "yelling about the", $FA, $F7
    db $EF, $EE, "great King of", $EF, $EE, "Terror from the", $FA, $F7
    db $EF, $EE, "sky", $A4, $EF, $EE, $F7
    db $F0

Message_00_6E:: ; heuristic: string; C0
Data_028_66BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The island is", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "Prince Kameha put", $EF, $EE, "you up to this.", $F7
    db $F0

Message_00_6F:: ; heuristic: string; C0
Data_028_66FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you kids!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "You shouldn't be", $EF, $EE, "in the well.", $FA, $F7
    db $EF, $EE, "What? The Log's", $EF, $EE, "Navel is broken?", $FA, $F7
    db $EF, $EE, "But why is that", $EF, $EE, "important?", $F7
    db $F0

Message_00_70:: ; heuristic: string; C0
Data_028_6774:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The island isn't", $F1
    db "sinking.", $FA, $F7
    db $EF, $EE, "If you lie, your", $EF, $EE, "nose will grow!", $F7
    db $F0

Message_00_71:: ; heuristic: string; C0
Data_028_67B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Looking for a", $F1
    db "monster master?", $FA, $F7
    db $EF, $EE, "I have no time for", $EF, $EE, "child's play!", $F7
    db $F0

Message_00_72:: ; heuristic: string; C0
Data_028_67FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This island is", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "If that's true,", $EF, $EE, "it's a disaster", $A4, $FA, $F7
    db $EF, $EE, "But I haven't", $EF, $EE, "heard anything", $FA, $F7
    db $EF, $EE, "about it!", $EF, $EE, $F7
    db $F0

Message_00_73:: ; heuristic: string; C0
Data_028_686A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? Warubou", $F1
    db "wants you to find", $FA, $F7
    db $EF, $EE, "a monster master", $EF, $EE, "for him?", $FA, $F7
    db $EF, $EE, "Well I am one but", $EF, $EE, "I don't want to", $FA, $F7
    db $EF, $EE, "have anything to", $EF, $EE, "do with Warubou.", $FA, $F7
    db $EF, $EE, "Sorry, but can you", $EF, $EE, "try someone else?", $F7
    db $F0

Message_00_74:: ; heuristic: string; C0
Data_028_691E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You're after a", $F1
    db "monster master?", $FA, $F7
    db $EF, $EE, "I saw one lolling", $EF, $EE, "around the Vault.", $F7
    db $F0

Message_00_75:: ; heuristic: string; C0
Data_028_6968:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The island's", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "Don't spread silly", $EF, $EE, "rumors like that.", $FA, $F7
    db $EF, $EE, "What if it scares", $EF, $EE, "off customers?", $F7
    db $F0

Message_00_76:: ; heuristic: string; C0
Data_028_69D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The island is", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "Hahah, no worries!", $EF, $EE, "We can all escape", $FA, $F7
    db $EF, $EE, "to another world.", $EF, $EE, "Wait a sec", $A4, " How", $FA, $F7
    db $EF, $EE, "would we get", $EF, $EE, "there?", $F7
    db $F0

Message_00_77:: ; heuristic: string; C0
Data_028_6A56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The island's", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "That's hard to", $EF, $EE, "believe, but", $A4, $FA, $F7
    db $EF, $EE, "You don't look like", $EF, $EE, "a liar", $A4, $FA, $F7
    db $EF, $EE, "I was going to", $EF, $EE, "open a shop here,", $FA, $F7
    db $EF, $EE, "but I guess I'll", $EF, $EE, "hit the road.", $F7
    db $F0

Message_00_78:: ; heuristic: string; C0
Data_028_6AF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's pointless", $F1
    db "if you're dead.", $FA, $F7
    db $EF, $EE, "I'm going to leave", $EF, $EE, "again.", $F7
    db $F0

Message_00_79:: ; heuristic: string; C0
Data_028_6B33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You say the", $F1
    db "island will sink?", $FA, $F7
    db $EF, $EE, "Sorry, but I can't", $EF, $EE, "believe that.", $F7
    db $F0

Message_00_7A:: ; heuristic: string; C0
Data_028_6B79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, you're back.", $FA, $F7
    db $EF, $EE, "You told everyone", $EF, $EE, "GreatLog'll sink?", $FA, $F7
    db $EF, $EE, "So, where is the", $EF, $EE, "monster master?", $FA, $F7
    db $EF, $EE, $A4, "What? Nobody", $EF, $EE, "believed you?", $FA, $F7
    db $EF, $EE, "Warooh, they are", $EF, $EE, "so complacent!", $FA, $F7
    db $EF, $EE, "Wa-hey, it can't", $EF, $EE, "be helped now.", $FA, $F7
    db $EF, $EE, "You go instead.", $EF, $EE, "No other way!", $F7
    db $F0

Message_00_7B:: ; heuristic: string; C0
Data_028_6C73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " No time", $F1
    db "to waste, warooh!", $FA, $F7
    db $EF, $EE, "If you don't go,", $EF, $EE, "GreatLog goes to", $FA, $F7
    db $EF, $EE, "the bottom of the", $EF, $EE, "sea soon enough!", $FA, $F7
    db $EF, $EE, "You will go find a", $EF, $EE, "new plug for the", $FA, $F7
    db $EF, $EE, "Log's Navel,", $EF, $EE, "wa-hey?", $FF, $F0

Message_00_7C:: ; heuristic: string; C0
Data_028_6D24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " No?", $F1
    db "Then find someone!", $F7
    db $F0

Message_00_7D:: ; heuristic: string; C0
Data_028_6D46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "No one believed!", $FA, $F7
    db $EF, $EE, "You have to go, no", $EF, $EE, "choice about it!", $F7
    db $F0

Message_00_7E:: ; heuristic: string; C0
Data_028_6D92:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "No more dawdling!", $FA, $F7
    db $EF, $EE, "GreatLog will sink", $EF, $EE, "into the sea!", $FA, $F7
    db $EF, $EE, "You have to go, no", $EF, $EE, "choice about it!", $FF, $F0

Message_00_7F:: ; heuristic: string; C0
Data_028_6E04:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, good, good!", $FA, $F7
    db $EF, $EE, "In you, I saw the", $EF, $EE, "potential, warooh!", $FA, $F7
    db $EF, $EE, "A good idea I have", $EF, $EE, "for plugging up", $FA, $F7
    db $EF, $EE, "the Log's Navel,", $EF, $EE, "yes I do, warooh.", $FA, $F7
    db $EF, $EE, "I'm an elemental", $EF, $EE, "so I know such!", $FA, $F7
    db $EF, $EE, "Here, take this,", $EF, $EE, "you, warooh.", $F7
    db $F0

Message_00_80:: ; heuristic: string; C0
Data_028_6EE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " This here", $F1
    db "is a Magic Key.", $FA, $F7
    db $EF, $EE, "It opens the door", $EF, $EE, "to other worlds.", $FA, $F7
    db $EF, $EE, "Specially made it", $EF, $EE, "is, by elemental", $FA, $F7
    db $EF, $EE, "power, making it", $EF, $EE, "magic, warooh.", $FA, $F7
    db $EF, $EE, "Use to open the", $EF, $EE, "magic door ahead.", $FA, $F7
    db $EF, $EE, "It takes you to", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "Another world, it", $EF, $EE, "might be, warooh,", $FA, $F7
    db $EF, $EE, "but it is not much", $EF, $EE, "different.", $FA, $F7
    db $EF, $EE, "Only difference is", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Monsters live in", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "But a monster", $EF, $EE, "master needs to", $FA, $F7
    db $EF, $EE, "fear not a thing,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "I see you have", $EF, $EE, "great potential.", $FA, $F7
    db $EF, $EE, "You go to other", $EF, $EE, "worlds, and bring", $FA, $F7
    db $EF, $EE, "back a plug for", $EF, $EE, "the Log's Navel.", $FA, $F7
    db $EF, $EE, "That something, I", $EF, $EE, "don't know what.", $FA, $F7
    db $EF, $EE, "But you will know", $EF, $EE, "when you find it!", $FA, $F7
    db $EF, $EE, "Now, warooh, take", $EF, $EE, "this!", $F7
    db $F0

Message_00_81:: ; heuristic: string; C0
Data_028_716B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Oasis Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Message_00_82:: ; heuristic: string; C0
Data_028_718B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I trust you! Go!", $F7
    db $F0

Message_00_83:: ; heuristic: string; C0
Data_028_71AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Forgot something!", $F7
    db $F0

Message_00_84:: ; heuristic: string; C0
Data_028_71D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " This you", $F1
    db "use to come back", $FA, $F7
    db $EF, $EE, "to GreatLog from", $EF, $EE, "other worlds.", $F7
    db $F0

Message_00_85:: ; heuristic: string; C0
Data_028_721C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "GreatLog Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Message_00_86:: ; heuristic: string; C0
Data_028_723F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Dangerous", $F1
    db "are other worlds!", $FA, $F7
    db $EF, $EE, "So you take", $EF, $EE, "monsters, warooh.", $FA, $F7
    db $EF, $EE, "Wa-hey, I'm", $EF, $EE, "GreatLog's spirit.", $FA, $F7
    db $EF, $EE, "One with the", $EF, $EE, "island I am.", $FA, $F7
    db $EF, $EE, "If you can't stop", $EF, $EE, "the island from", $FA, $F7
    db $EF, $EE, "sinking, so ends", $EF, $EE, "my life, warooh.", $FA, $F7
    db $EF, $EE, "Not just me, but", $EF, $EE, "everyone here.", $FA, $F7
    db $EF, $EE, "So, you must!", $EF, $EE, "Must find a plug!", $F7
    db $F0

Message_00_87:: ; heuristic: string; C0
Data_028_735A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " This is bad.", $F1
    db "What'll we do?", $FA, $F7
    db $EF, $EE, "Let's go home and", $EF, $EE, "talk about it.", $F7
    db $F0

Message_00_88:: ; heuristic: string; C0
Data_028_73A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Oh, wow.", $F1
    db "This is terrible.", $FA, $F7
    db $EF, $EE, "We should talk", $EF, $EE, "about it at home.", $F7
    db $F0

Message_00_89:: ; heuristic: string; C0
Data_028_73E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " If we don't", $F1
    db "find a plug for", $FA, $F7
    db $EF, $EE, "the Log's Navel,", $EF, $EE, "the island sinks.", $FA, $F7
    db $EF, $EE, "Our house and the", $EF, $EE, "farm too.", $FA, $F7
    db $EF, $EE, "We have to go look", $EF, $EE, "ourselves, right?", $F7
    db $F0

Message_00_8A:: ; heuristic: string; C0
Data_028_747B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " But if we", $F1
    db "both go to other", $FA, $F7
    db $EF, $EE, "worlds, Mama will", $EF, $EE, "be worried.", $F7
    db $F0

Message_00_8B:: ; heuristic: string; C0
Data_028_74C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's true", $A4, $F1
    db "If we both went to", $FA, $F7
    db $EF, $EE, "other worlds, Mama", $EF, $EE, "would be worried.", $F7
    db $F0

Message_00_8C:: ; heuristic: string; C0
Data_028_7510:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " Hey, why", $F1
    db "the long faces?", $FA, $F7
    db $EF, $EE, "I couldn't help", $EF, $EE, "overhearing you.", $FA, $F7
    db $EF, $EE, "I'll go with you", $EF, $EE, "to other worlds.", $FA, $F7
    db $EF, $EE, "That way, one of", $EF, $EE, "you can stay here.", $FA, $F7
    db $EF, $EE, "That solves your", $EF, $EE, "little problem!", $F7
    db $F0

Message_00_8D:: ; heuristic: string; C0
Data_028_75C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's true.", $F1
    db "What to do", $A4, $FA, $F7
    db $EF, $EE, "Huh? ", $F9, "0?", $EF, $EE, "Do you want to go?", $FF, $F0

Message_00_8E:: ; heuristic: string; C0
Data_028_7608:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Don't waste", $F1
    db "your time lying.", $FA, $F7
    db $EF, $EE, "I can see it in", $EF, $EE, "your eyes.", $FA, $F7
    db $EF, $EE, "You really want to", $EF, $EE, "go, don't you?", $FF, $F0

Message_00_8F:: ; heuristic: string; C0
Data_028_7670:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Fine. But", $F1
    db $F9, "0, by", $FA, $F7
    db $EF, $EE, "yourself", $A4, $F7
    db $F0

Message_00_90:: ; heuristic: string; C0
Data_028_7696:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " Don't worry!", $F1
    db "I'm riding along!", $F7
    db $F0

Message_00_91:: ; heuristic: string; C0
Data_028_76BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " And ", $F9, "0", $F1
    db "has potential,", $FA, $F7
    db $EF, $EE, "I think, to be a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "We'll need the", $EF, $EE, "help of monsters", $FA, $F7
    db $EF, $EE, "when we go to", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "So that potential", $EF, $EE, "will help a lot!", $F7
    db $F0

Message_00_92:: ; heuristic: string; C0
Data_028_776A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Fine, ", $F9, "0.", $F1
    db "It's up to you.", $FA, $F7
    db $EF, $EE, "You do your best", $EF, $EE, "and save us!", $F7
    db $F0

Message_00_93:: ; heuristic: string; C0
Data_028_77AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " That's", $F1
    db "settled, then!", $FA, $F7
    db $EF, $EE, "We'll leave", $EF, $EE, "tomorrow morning.", $FA, $F7
    db $EF, $EE, "Get plenty of rest", $EF, $EE, "tonight!", $F7
    db $F0

Message_00_94:: ; heuristic: string; C0
Data_028_780C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " If we don't", $F1
    db "go find something", $FA, $F7
    db $EF, $EE, "to put in the Log's", $EF, $EE, "Navel, this house,", $FA, $F7
    db $EF, $EE, "the farm and", $EF, $EE, "everything else", $FA, $F7
    db $EF, $EE, "will sink with the", $EF, $EE, "island.", $FA, $F7
    db $EF, $EE, "So we have to go", $EF, $EE, "to other worlds,", $FA, $F7
    db $EF, $EE, "right?", $FF, $F0

Message_00_95:: ; heuristic: string; C0
Data_028_78CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " But if we", $F1
    db "both went, Mama", $FA, $F7
    db $EF, $EE, "would be really", $EF, $EE, "worried about us.", $F7
    db $F0

Message_00_96:: ; heuristic: string; C0
Data_028_7913:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Oh", $A4, " If we", $F1
    db "both went, Mama", $FA, $F7
    db $EF, $EE, "would be really", $EF, $EE, "worried about us.", $F7
    db $F0

Message_00_97:: ; heuristic: string; C0
Data_028_795B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0, you", $F1
    db "want to go.", $FA, $F7
    db $EF, $EE, $F9, "0, do you want", $EF, $EE, "me to stay home?", $FF, $F0

Message_00_98:: ; heuristic: string; C0
Data_028_799C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You don't", $F1
    db "have to lie.", $FA, $F7
    db $EF, $EE, "We'll be all right", $EF, $EE, "here.", $FA, $F7
    db $EF, $EE, "You do really want", $EF, $EE, "to go, right?", $FF, $F0

Message_00_99:: ; heuristic: string; C0
Data_028_79FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " But ", $F9, "0,", $F1
    db "what about your", $FA, $F7
    db $EF, $EE, "terrible sense of", $EF, $EE, "direction?", $F7
    db $F0

Message_00_9A:: ; heuristic: string; C0
Data_028_7A3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Then it's", $F1
    db "your job, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "Make me proud, big", $EF, $EE, "brother!", $F7
    db $F0

Message_00_9B:: ; heuristic: string; C0
Data_028_7A7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, $F9, "Y.", $F7
    db $F0

Message_00_A1:: ; heuristic: string; C0
Data_028_7AB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty", $A4, $EF, $EE, $F7
    db $F0

Message_00_A2:: ; heuristic: string; C0
Data_028_7AE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 found the", $EF, $EE, $F9, "Y.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, $F9, "Y back.", $F7
    db $F0

Message_00_A3:: ; heuristic: string; C0
Data_028_7B56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, $F9, "Y.", $F7
    db $F0

Message_00_A4:: ; heuristic: string; C0
Data_028_7B88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Message_00_A5:: ; heuristic: string; C0
Data_028_7BB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, $F9, "0 found the", $EF, $EE, $F9, "Y.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, $F9, "Y back.", $F7
    db $F0

Message_00_A6:: ; heuristic: string; C0
Data_028_7C21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, $F9, "Y.", $F7
    db $F0

Message_00_A7:: ; heuristic: string; C0
Data_028_7C55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Message_00_A8:: ; heuristic: string; C0
Data_028_7C88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, $F9, "0 found the", $EF, $EE, $F9, "Y.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, $F9, "Y back.", $F7
    db $F0

Message_00_A9:: ; heuristic: string; C0
Data_028_7CF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained a", $EF, $EE, "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Message_00_AA:: ; heuristic: string; C0
Data_028_7D32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty", $A4, $EF, $EE, $F7
    db $F0

Message_00_AB:: ; heuristic: string; C0
Data_028_7D69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 found a", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

Message_00_AC:: ; heuristic: string; C0
Data_028_7DDF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let's see how", $F1
    db "good you are!", $F7
    db $F0

Message_00_D1:: ; heuristic: string; C0
Data_028_7DFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You think you", $F1
    db "could win?", $FA, $F7
    db $EF, $EE, "Dream on, you", $EF, $EE, "insolent fools!", $F7
    db $F0

Message_00_D2:: ; heuristic: string; C0
Data_028_7E3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, I", $44, " never", $F1
    db "expected you here.", $FA, $F7
    db $EF, $EE, "But this shall be", $EF, $EE, "your tomb!", $F7
    db $F0

Message_00_D3:: ; heuristic: string; C0
Data_028_7E84:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Prepare to be", $F1
    db "overwhelmed!", $F7
    db $F0

Message_00_D4:: ; heuristic: string; C0
Data_028_7EA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Those monsters", $F1
    db "are my foes?", $FA, $F7
    db $EF, $EE, "Fwahahaha!", $EF, $EE, "How ludicrous!", $F7
    db $F0

Message_00_D5:: ; heuristic: string; C0
Data_028_7EE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you win, you", $F1
    db "can be the boss!", $F7
    db $F0

Message_00_D6:: ; heuristic: string; C0
Data_028_7F06:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll show you how", $F1
    db "small you are in", $FA, $F7
    db $EF, $EE, "the grand scheme", $EF, $EE, "of things!", $F7
    db $F0

Message_00_D7:: ; heuristic: string; C0
Data_028_7F4C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? My rival is", $F1
    db "here? Come on!", $F7
    db $F0

Message_00_D8:: ; heuristic: string; C0
Data_028_7F6F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Finally, someone", $F1
    db "to ignite my soul!", $F7
    db $F0

Message_00_D9:: ; heuristic: string; C0
Data_028_7F97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I feel your", $F1
    db "strength", $A4, $FA, $F7
    db $EF, $EE, "This will be a", $EF, $EE, "long battle.", $F7
    db $F0
    ds $2F, $00
