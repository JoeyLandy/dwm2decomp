SECTION "Bank 89", ROMX[$4000], BANK[$89]
    db $89

; message bank $89: when wStringIndex < $DE, BeginStringDisplay with this bank's table Data_089_4032; otherwise far-calls Func_098_404B (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank89, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89, ShowMessageHL_ToBeginStringDisplay_Bank89)
; reads: wStringIndex
BeginStringDisplay_Bank89::
Func_089_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $DE
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank89_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank89
    call BeginStringDisplay
    ret

; message bank $89: when wStringIndex < $DE, CopyStringToBuffer with this bank's table Data_089_4032; otherwise far-calls Func_098_405A (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank89:: ; heuristic: follows a terminator; C0
Func_089_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $DE
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank89_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank89
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_89_4032::
MessageStrings_Bank89:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_089_4032:: ; address name
    dw StringList_89_4034 ; id 0

; E-0217 (derived: category list of StringCategories_89_4032; one pointer per wStringIndex)
; record: string
StringList_89_4034::
Data_089_4034:: ; address name
    dw Message_0D_00 ; id 0
    dw Message_0D_01 ; id 1
    dw Message_0D_02 ; id 2
    dw Message_0D_03 ; id 3
    dw Message_0D_04 ; id 4
    dw Message_0D_05 ; id 5
    dw Message_0D_06 ; id 6
    dw Message_0D_07 ; id 7
    dw Message_0D_08 ; id 8
    dw Message_0D_09 ; id 9
    dw Message_0D_0A ; id 10
    dw Message_0D_0B ; id 11
    dw Message_0D_0C ; id 12
    dw Message_0D_0D ; id 13
    dw Message_0D_0E ; id 14
    dw Message_0D_0F ; id 15
    dw Message_0D_10 ; id 16
    dw Message_0D_11 ; id 17
    dw Message_0D_12 ; id 18
    dw Message_0D_13 ; id 19
    dw Message_0D_14 ; id 20
    dw Message_0D_15 ; id 21
    dw Message_0D_16 ; id 22
    dw Message_0D_17 ; id 23
    dw Message_0D_18 ; id 24
    dw Message_0D_19 ; id 25
    dw Message_0D_1A ; id 26
    dw Message_0D_1B ; id 27
    dw Message_0D_1C ; id 28
    dw Message_0D_1D ; id 29
    dw Message_0D_1E ; id 30
    dw Message_0D_1F ; id 31
    dw Message_0D_20 ; id 32
    dw Message_0D_21 ; id 33
    dw Message_0D_22 ; id 34
    dw Message_0D_23 ; id 35
    dw Message_0D_24 ; id 36
    dw Message_0D_25 ; id 37
    dw Message_0D_26 ; id 38
    dw Message_0D_27 ; id 39
    dw Message_0D_28 ; id 40
    dw Message_0D_29 ; id 41
    dw Message_0D_2A ; id 42
    dw Message_0D_2B ; id 43
    dw Message_0D_2C ; id 44
    dw Message_0D_2D ; id 45
    dw Message_0D_2E ; id 46
    dw Message_0D_2F ; id 47
    dw Message_0D_30 ; id 48
    dw Message_0D_31 ; id 49
    dw Message_0D_32 ; id 50
    dw Message_0D_33 ; id 51
    dw Message_0D_34 ; id 52
    dw Message_0D_35 ; id 53
    dw Message_0D_36 ; id 54
    dw Message_0D_37 ; id 55
    dw Message_0D_38 ; id 56
    dw Message_0D_39 ; id 57
    dw Message_0D_3A ; id 58
    dw Message_0D_3B ; id 59
    dw Message_0D_3C ; id 60
    dw Message_0D_3D ; id 61
    dw Message_0D_3E ; id 62
    dw Message_0D_3F ; id 63
    dw Message_0D_40 ; id 64
    dw Message_0D_41 ; id 65
    dw Message_0D_42 ; id 66
    dw Message_0D_43 ; id 67
    dw Message_0D_44 ; id 68
    dw Message_0D_45 ; id 69
    dw Message_0D_46 ; id 70
    dw Message_0D_47 ; id 71
    dw Message_0D_48 ; id 72
    dw Message_0D_49 ; id 73
    dw Message_0D_4A ; id 74
    dw Message_0D_4B ; id 75
    dw Message_0D_4C ; id 76
    dw Message_0D_4D ; id 77
    dw Message_0D_4E ; id 78
    dw Message_0D_4F ; id 79
    dw Message_0D_4F ; id 80
    dw Message_0D_51 ; id 81
    dw Message_0D_52 ; id 82
    dw Message_0D_53 ; id 83
    dw Message_0D_53 ; id 84
    dw Message_0D_53 ; id 85
    dw Message_0D_56 ; id 86
    dw Message_0D_57 ; id 87
    dw Message_0D_58 ; id 88
    dw Message_0D_58 ; id 89
    dw Message_0D_58 ; id 90
    dw Message_0D_58 ; id 91
    dw Message_0D_58 ; id 92
    dw Message_0D_58 ; id 93
    dw Message_0D_58 ; id 94
    dw Message_0D_58 ; id 95
    dw Message_0D_58 ; id 96
    dw Message_0D_61 ; id 97
    dw Message_0D_62 ; id 98
    dw Message_0D_63 ; id 99
    dw Message_0D_64 ; id 100
    dw Message_0D_65 ; id 101
    dw Message_0D_66 ; id 102
    dw Message_0D_67 ; id 103
    dw Message_0D_68 ; id 104
    dw Message_0D_69 ; id 105
    dw Message_0D_69 ; id 106
    dw Message_0D_69 ; id 107
    dw Message_0D_69 ; id 108
    dw Message_0D_69 ; id 109
    dw Message_0D_69 ; id 110
    dw Message_0D_69 ; id 111
    dw Message_0D_69 ; id 112
    dw Message_0D_69 ; id 113
    dw Message_0D_69 ; id 114
    dw Message_0D_69 ; id 115
    dw Message_0D_69 ; id 116
    dw Message_0D_69 ; id 117
    dw Message_0D_69 ; id 118
    dw Message_0D_69 ; id 119
    dw Message_0D_69 ; id 120
    dw Message_0D_69 ; id 121
    dw Message_0D_69 ; id 122
    dw Message_0D_69 ; id 123
    dw Message_0D_69 ; id 124
    dw Message_0D_69 ; id 125
    dw Message_0D_69 ; id 126
    dw Message_0D_69 ; id 127
    dw Message_0D_69 ; id 128
    dw Message_0D_81 ; id 129
    dw Message_0D_82 ; id 130
    dw Message_0D_83 ; id 131
    dw Message_0D_84 ; id 132
    dw Message_0D_85 ; id 133
    dw Message_0D_86 ; id 134
    dw Message_0D_87 ; id 135
    dw Message_0D_88 ; id 136
    dw Message_0D_89 ; id 137
    dw Message_0D_8A ; id 138
    dw Message_0D_8B ; id 139
    dw Message_0D_8C ; id 140
    dw Message_0D_8D ; id 141
    dw Message_0D_8E ; id 142
    dw Message_0D_8F ; id 143
    dw Message_0D_90 ; id 144
    dw Message_0D_91 ; id 145
    dw Message_0D_92 ; id 146
    dw Message_0D_93 ; id 147
    dw Message_0D_94 ; id 148
    dw Message_0D_95 ; id 149
    dw Message_0D_96 ; id 150
    dw Message_0D_96 ; id 151
    dw Message_0D_96 ; id 152
    dw Message_0D_96 ; id 153
    dw Message_0D_96 ; id 154
    dw Message_0D_96 ; id 155
    dw Message_0D_96 ; id 156
    dw Message_0D_96 ; id 157
    dw Message_0D_96 ; id 158
    dw Message_0D_96 ; id 159
    dw Message_0D_96 ; id 160
    dw Message_0D_A1 ; id 161
    dw Message_0D_A2 ; id 162
    dw Message_0D_A2 ; id 163
    dw Message_0D_A2 ; id 164
    dw Message_0D_A2 ; id 165
    dw Message_0D_A2 ; id 166
    dw Message_0D_A2 ; id 167
    dw Message_0D_A2 ; id 168
    dw Message_0D_A2 ; id 169
    dw Message_0D_A2 ; id 170
    dw Message_0D_A2 ; id 171
    dw Message_0D_A2 ; id 172
    dw Message_0D_A2 ; id 173
    dw Message_0D_A2 ; id 174
    dw Message_0D_A2 ; id 175
    dw Message_0D_A2 ; id 176
    dw Message_0D_B1 ; id 177
    dw Message_0D_B2 ; id 178
    dw Message_0D_B3 ; id 179
    dw Message_0D_B4 ; id 180
    dw Message_0D_B5 ; id 181
    dw Message_0D_B6 ; id 182
    dw Message_0D_B7 ; id 183
    dw Message_0D_B8 ; id 184
    dw Message_0D_B9 ; id 185
    dw Message_0D_BA ; id 186
    dw Message_0D_BB ; id 187
    dw Message_0D_BB ; id 188
    dw Message_0D_BB ; id 189
    dw Message_0D_BB ; id 190
    dw Message_0D_BB ; id 191
    dw Message_0D_BB ; id 192
    dw Message_0D_C1 ; id 193
    dw Message_0D_C2 ; id 194
    dw Message_0D_C3 ; id 195
    dw Message_0D_C4 ; id 196
    dw Message_0D_C5 ; id 197
    dw Message_0D_C6 ; id 198
    dw Message_0D_C7 ; id 199
    dw Message_0D_C8 ; id 200
    dw Message_0D_C9 ; id 201
    dw Message_0D_CA ; id 202
    dw Message_0D_CB ; id 203
    dw Message_0D_CC ; id 204
    dw Message_0D_CD ; id 205
    dw Message_0D_CE ; id 206
    dw Message_0D_CF ; id 207
    dw Message_0D_D0 ; id 208
    dw Message_0D_D1 ; id 209
    dw Message_0D_D2 ; id 210
    dw Message_0D_D3 ; id 211
    dw Message_0D_D4 ; id 212
    dw Message_0D_D5 ; id 213
    dw Message_0D_D6 ; id 214
    dw Message_0D_D7 ; id 215
    dw Message_0D_D8 ; id 216
    dw Message_0D_D9 ; id 217
    dw Message_0D_DA ; id 218
    dw Message_0D_DB ; id 219
    dw Message_0D_DC ; id 220
    dw Message_0D_DD ; id 221

Message_0D_00:: ; heuristic: string; C0
Data_089_41F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: They say you use", $F1
    db "Magic Keys to go", $FA, $F7
    db $EF, $EE, "to other worlds.", $EF, $EE, "I guess they're", $FA, $F7
    db $EF, $EE, "indispensable to", $EF, $EE, "monster masters.", $F7
    db $F0

Message_0D_01:: ; heuristic: string; C0
Data_089_4260:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King: Then, you", $F1
    db "are excused.", $FA, $F7
    db $EF, $EE, "I'm looking", $EF, $EE, "forward to the", $FA, $F7
    db $EF, $EE, "next show.", $EF, $EE, $F7
    db $F0

Message_0D_02:: ; heuristic: string; C0
Data_089_42AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King: You wish to", $F1
    db "see our treasures?", $FA, $F7
    db $EF, $EE, "You're quite sharp", $EF, $EE, "to have an eye out", $FA, $F7
    db $EF, $EE, "for treasures, I", $EF, $EE, "must say.", $F7
    db $F0

Message_0D_03:: ; heuristic: string; C0
Data_089_431C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: That will help", $F1
    db "you for certain.", $FA, $F7
    db $EF, $EE, "Use it where you", $EF, $EE, "feel it is right.", $F7
    db $F0

Message_0D_04:: ; heuristic: string; C0
Data_089_4367:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Hello, have you", $F1
    db "found a plug for", $FA, $F7
    db $EF, $EE, "the Log's Navel?", $EF, $EE, $FF, $F0

Message_0D_05:: ; heuristic: string; C0
Data_089_43A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Oh. That's nice.", $F1
    db "Good for you.", $F7
    db $F0

Message_0D_06:: ; heuristic: string; C0
Data_089_43C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: I can show you", $F1
    db "my navel if you", $FA, $F7
    db $EF, $EE, "promise to keep it", $EF, $EE, "a secret.", $F7
    db $F0

Message_0D_07:: ; heuristic: string; C0
Data_089_4407:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The shortage of", $F1
    db "water has been", $FA, $F7
    db $EF, $EE, "corrected, and the", $EF, $EE, "gang of thieves", $FA, $F7
    db $EF, $EE, "was finally caught", $EF, $EE, "and jailed.", $FA, $F7
    db $EF, $EE, "We won't have to", $EF, $EE, "worry about those", $FA, $F7
    db $EF, $EE, "things anymore,", $EF, $EE, "thank goodness.", $F7
    db $F0

Message_0D_08:: ; heuristic: string; C0
Data_089_44BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh, it's you lot.", $F1
    db "We haven't had any", $FA, $F7
    db $EF, $EE, "problems with the", $EF, $EE, "reservoir.", $F7
    db $F0

Message_0D_09:: ; heuristic: string; C0
Data_089_4506:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: The well filled", $F1
    db "up with water", $FA, $F7
    db $EF, $EE, "again.", $EF, $EE, "I don't have any", $FA, $F7
    db $EF, $EE, "excuse not to do", $EF, $EE, "laundry anymore.", $F7
    db $F0

Message_0D_0A:: ; heuristic: string; C0
Data_089_4569:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The band of", $F1
    db "thieves made their", $FA, $F7
    db $EF, $EE, "hideout in Mirage", $EF, $EE, "Lake.", $FA, $F7
    db $EF, $EE, "Staying away from", $EF, $EE, "Mirage Lake was a", $FA, $F7
    db $EF, $EE, "smart thing in", $EF, $EE, "hindsight.", $F7
    db $F0

Message_0D_0B:: ; heuristic: string; C0
Data_089_45EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The King gave", $F1
    db "away his prized", $FA, $F7
    db $EF, $EE, "TidalBell to some", $EF, $EE, "traveler as a", $FA, $F7
    db $EF, $EE, "reward of some", $EF, $EE, "sort.", $FA, $F7
    db $EF, $EE, "I didn't know that", $EF, $EE, "our King could be", $FA, $F7
    db $EF, $EE, "so generous.", $EF, $EE, $F7
    db $F0

Message_0D_0C:: ; heuristic: string; C0
Data_089_4687:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Up ahead is the", $F1
    db "Starry Shrine, and", $FA, $F7
    db $EF, $EE, "the Egg Evaluator's", $EF, $EE, "chamber.", $FA, $F7
    db $EF, $EE, "Both of them offer", $EF, $EE, "essential services", $FA, $F7
    db $EF, $EE, "to masters, but", $EF, $EE, "they're always", $FA, $F7
    db $EF, $EE, "packed by other", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "It looks like I'll", $EF, $EE, "be waiting here", $FA, $F7
    db $EF, $EE, "for a long time", $A4, $EF, $EE, $F7
    db $F0

Message_0D_0D:: ; heuristic: string; C0
Data_089_4773:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: While I was on", $F1
    db "the way to the", $FA, $F7
    db $EF, $EE, "Magic Door, I saw", $EF, $EE, "Warubou stuck in a", $FA, $F7
    db $EF, $EE, "hole for some", $EF, $EE, "unknown reason.", $FA, $F7
    db $EF, $EE, "What the heck was", $EF, $EE, "it doing?", $F7
    db $F0

Message_0D_0E:: ; heuristic: string; C0
Data_089_4800:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: You're really", $F1
    db "trying to become a", $FA, $F7
    db $EF, $EE, "monster master?", $EF, $EE, "Well, go for it!", $FA, $F7
    db $EF, $EE, "I'll be cheering", $EF, $EE, "you on!", $F7
    db $F0

Message_0D_0F:: ; heuristic: string; C0
Data_089_4865:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hm, you are", $F1
    db "quite strong", $A4, $FA, $F7
    db $EF, $EE, "I have to admit", $EF, $EE, "I'm impressed.", $FA, $F7
    db $EF, $EE, "Will you let me go", $EF, $EE, "with you?", $FA, $F7
    db $EF, $EE, "You'll find my", $EF, $EE, "dancing special!", $FF, $F0

Message_0D_10:: ; heuristic: string; C0
Data_089_48E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Great! Let's", $F1
    db "make this work!", $F7
    db $F0

Message_0D_11:: ; heuristic: string; C0
Data_089_4909:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Your party's", $F1
    db "full", $A4, $FA, $F7
    db $EF, $EE, "There isn't any", $EF, $EE, "room for me.", $F7
    db $F0

Message_0D_12:: ; heuristic: string; C0
Data_089_493F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh, but", $A4, " I can", $F1
    db "be so useful", $A4, $F7
    db $F0

Message_0D_13:: ; heuristic: string; C0
Data_089_4960:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The lighthouse", $F1
    db "is out east.", $FA, $F7
    db $EF, $EE, "Stay away-it's", $EF, $EE, "dangerous.", $FA, $F7
    db $EF, $EE, "Even though the", $EF, $EE, "MoonRock has been", $FA, $F7
    db $EF, $EE, "recovered from", $EF, $EE, "pirates and put", $FA, $F7
    db $EF, $EE, "back where it", $EF, $EE, "belongs, monsters", $FA, $F7
    db $EF, $EE, "still roam freely", $EF, $EE, "in the lighthouse.", $F7
    db $F0

Message_0D_14:: ; heuristic: string; C0
Data_089_4A33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Another master", $F1
    db "was here with two", $FA, $F7
    db $EF, $EE, "monsters in tow a", $EF, $EE, "while back.", $FA, $F7
    db $EF, $EE, "I think his name", $EF, $EE, "was Kameha.", $FA, $F7
    db $EF, $EE, "I haven't seen him", $EF, $EE, "since then.", $FA, $F7
    db $EF, $EE, "I wonder where", $EF, $EE, "he's gone?", $F7
    db $F0

Message_0D_15:: ; heuristic: string; C0
Data_089_4ADA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: OK! Let me dig!", $F1
    db "One-two, one-two!", $FA, $F7
    db $EF, $EE, "Huh? I just hit", $EF, $EE, "something hard.", $F7
    db $F0

Message_0D_16:: ; heuristic: string; C0
Data_089_4B24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What's wrong,", $F1
    db "MadGopher?", $FA, $F7
    db $EF, $EE, "Did you find", $EF, $EE, "something?", $FA, $F7
    db $EF, $EE, "Hey, that's a", $EF, $EE, "Magic Key!", $FA, $F7
    db $EF, $EE, "That's great work,", $EF, $EE, "MadGopher!", $F7
    db $F0

Message_0D_17:: ; heuristic: string; C0
Data_089_4B99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here, ", $F9, "0!", $F1
    db "You need this!", $F7
    db $F0

Message_0D_18:: ; heuristic: string; C0
Data_089_4BB6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Ice Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Message_0D_19:: ; heuristic: string; C0
Data_089_4BD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Be careful when", $F1
    db "you're traveling", $FA, $F7
    db $EF, $EE, "in other worlds.", $EF, $EE, $F7
    db $F0

Message_0D_1A:: ; heuristic: string; C0
Data_089_4C0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db "find another Magic", $FA, $F7
    db $EF, $EE, "Key in GreatLog", $EF, $EE, "and off you go to", $FA, $F7
    db $EF, $EE, "another world,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "The Ice Key is", $EF, $EE, "what you want.", $F7
    db $F0

Message_0D_1B:: ; heuristic: string; C0
Data_089_4C97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db $F9, "0! Too slow!", $FA, $F7
    db $EF, $EE, "Kameha went to", $EF, $EE, "another world", $FA, $F7
    db $EF, $EE, "before you again,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "But then it doesn't", $EF, $EE, "matter who gets", $FA, $F7
    db $EF, $EE, "the job done, you", $EF, $EE, "or Kameha", $A4, $FA, $F7
    db $EF, $EE, "But after last", $EF, $EE, "time, you can be", $FA, $F7
    db $EF, $EE, "trusted more than", $EF, $EE, "Kameha, I think.", $FA, $F7
    db $EF, $EE, "This time, you'll", $EF, $EE, "find a plug, yes?", $FA, $F7
    db $EF, $EE, "Oh, and don't", $EF, $EE, "forget, you have", $FA, $F7
    db $EF, $EE, "new abilities for", $EF, $EE, "crossing water and", $FA, $F7
    db $EF, $EE, "smashing boulders.", $EF, $EE, "Don't forget!", $F7
    db $F0

Message_0D_1C:: ; heuristic: string; C0
Data_089_4E20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The King of the", $F1
    db "north was a fake,", $FA, $F7
    db $EF, $EE, "or so I've heard.", $EF, $EE, "Why though?", $FA, $F7
    db $EF, $EE, "Why would a", $EF, $EE, "monster want to", $FA, $F7
    db $EF, $EE, "impersonate a", $EF, $EE, "king?", $F7
    db $F0

Message_0D_1D:: ; heuristic: string; C0
Data_089_4E9F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: If you go south,", $F1
    db "you'll eventually", $FA, $F7
    db $EF, $EE, "reach the town of", $EF, $EE, "Weston.", $FA, $F7
    db $EF, $EE, "From there, go up", $EF, $EE, "a river and travel", $FA, $F7
    db $EF, $EE, "west to reach the", $EF, $EE, "castle.", $F7
    db $F0

Message_0D_1E:: ; heuristic: string; C0
Data_089_4F2A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh", $A4, " Lady Yuna", $A4, $F1
    db "I miss you so", $A4, $FA, $F7
    db $EF, $EE, "I should find", $EF, $EE, "my courage and", $FA, $F7
    db $EF, $EE, "climb the vines to", $EF, $EE, "her window", $A4, $FA, $F7
    db $EF, $EE, "No, I mustn't do", $EF, $EE, "that", $A4, $F7
    db $F0

Message_0D_1F:: ; heuristic: string; C0
Data_089_4FAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How can we help", $F1
    db "Queen Helen?", $FA, $F7
    db $EF, $EE, "If there was a", $EF, $EE, "good medicine", $A4, $FA, $F7
    db $EF, $EE, "Perhaps we should", $EF, $EE, "ask the scholar", $A4, $FA, $F7
    db $EF, $EE, "But the scholar", $EF, $EE, "has gone off to", $FA, $F7
    db $EF, $EE, "Nofor", $A4, " What to do,", $EF, $EE, "what to do", $A4, $F7
    db $F0

Message_0D_20:: ; heuristic: string; C0
Data_089_505B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh! That blue", $F1
    db "flower!", $FA, $F7
    db $EF, $EE, "It's unmistakably", $EF, $EE, "the SleepHerb!", $FA, $F7
    db $EF, $EE, "All you need to do", $EF, $EE, "is eat its leaves.", $FA, $F7
    db $EF, $EE, "As soon as you do,", $EF, $EE, "you drop off to a", $FA, $F7
    db $EF, $EE, "deep and relaxing", $EF, $EE, "sleep.", $F7
    db $F0

Message_0D_21:: ; heuristic: string; C0
Data_089_5109:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Star spuds grow", $F1
    db "plentifully around", $FA, $F7
    db $EF, $EE, "these parts. They", $EF, $EE, "are spuds that", $FA, $F7
    db $EF, $EE, "grow by the light", $EF, $EE, "of the stars.", $FA, $F7
    db $EF, $EE, "They're gifts from", $EF, $EE, "the spirit.", $F7
    db $F0

Message_0D_22:: ; heuristic: string; C0
Data_089_519B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Out at the", $F1
    db "western castle,", $FA, $F7
    db $EF, $EE, "I heard that no", $EF, $EE, "one managed to", $FA, $F7
    db $EF, $EE, "cheer up Lady Yuna", $EF, $EE, "in the end.", $FA, $F7
    db $EF, $EE, "So, nobody got the", $EF, $EE, "reward.", $F7
    db $F0

Message_0D_23:: ; heuristic: string; C0
Data_089_521F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I just heard a", $F1
    db "rumor", $A4, $FA, $F7
    db $EF, $EE, "The girl's ghost", $EF, $EE, "seems to be gone.", $F7
    db $F0

Message_0D_24:: ; heuristic: string; C0
Data_089_525F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Now that I think", $F1
    db "about it, I'm not", $FA, $F7
    db $EF, $EE, "sure what I saw", $EF, $EE, "was a ghost.", $FA, $F7
    db $EF, $EE, "I may have been", $EF, $EE, "mistaken, even.", $FA, $F7
    db $EF, $EE, "In fact, I'm sure", $EF, $EE, "I was wrong!", $F7
    db $F0

Message_0D_25:: ; heuristic: string; C0
Data_089_52EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: ArmyAnt's help", $F1
    db "means I can open", $FA, $F7
    db $EF, $EE, "my shop just as I", $EF, $EE, "had planned.", $F7
    db $F0

Message_0D_26:: ; heuristic: string; C0
Data_089_5332:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hup, hup, hup!", $F1
    db "Heh, this stuff is", $FA, $F7
    db $EF, $EE, "nothing to move", $EF, $EE, "around!", $F7
    db $F0

Message_0D_27:: ; heuristic: string; C0
Data_089_5374:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "The Crest was", $EF, $EE, "found.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it", $A4, $F7
    db $F0

Message_0D_28:: ; heuristic: string; C0
Data_089_53CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Sky Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Message_0D_29:: ; heuristic: string; C0
Data_089_53EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King: Kameha made", $F1
    db "off with the Key's", $FA, $F7
    db $EF, $EE, "duplicate from the", $EF, $EE, "Castle.", $FA, $F7
    db $EF, $EE, "I can imagine him", $EF, $EE, "being a nuisance,", $FA, $F7
    db $EF, $EE, "but I'm counting", $EF, $EE, "on your support.", $F7
    db $F0

Message_0D_2A:: ; heuristic: string; C0
Data_089_547E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db "find another Magic", $FA, $F7
    db $EF, $EE, "Key in GreatLog", $EF, $EE, "and you go off to", $FA, $F7
    db $EF, $EE, "another world,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "The Sky Key, I", $EF, $EE, "think it is.", $F7
    db $F0

Message_0D_2B:: ; heuristic: string; C0
Data_089_5505:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db $F9, "0!", $FA, $F7
    db $EF, $EE, "You have the Sky", $EF, $EE, "Key, warooh.", $FA, $F7
    db $EF, $EE, "Kameha took off", $EF, $EE, "before you again.", $FA, $F7
    db $EF, $EE, "I'm beginning to", $EF, $EE, "suffer from this", $A4, $FA, $F7
    db $EF, $EE, "This time, you'll", $EF, $EE, "find a plug, yes?", $FA, $F7
    db $EF, $EE, "Oh, and now, you", $EF, $EE, "have the ability", $FA, $F7
    db $EF, $EE, "to summon a cloud", $EF, $EE, "and fly.", $FA, $F7
    db $EF, $EE, "Sky Shield gave", $EF, $EE, "you that ability.", $FA, $F7
    db $EF, $EE, "Keep that in mind,", $EF, $EE, "warooh!", $F7
    db $F0

Message_0D_2C:: ; heuristic: string; C0
Data_089_563B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: That giant bird", $F1
    db "hasn't flown over", $FA, $F7
    db $EF, $EE, "for a while.", $EF, $EE, $F7
    db $F0

Message_0D_2D:: ; heuristic: string; C0
Data_089_5672:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Was that bird", $F1
    db "going after the", $FA, $F7
    db $EF, $EE, "LightOrb?", $EF, $EE, $F7
    db $F0

Message_0D_2E:: ; heuristic: string; C0
Data_089_56A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: They say the", $F1
    db "giant bird has", $FA, $F7
    db $EF, $EE, "disappeared.", $EF, $EE, "I wonder if it's", $FA, $F7
    db $EF, $EE, "safe for me to go", $EF, $EE, "outside now", $A4, $F7
    db $F0

Message_0D_2F:: ; heuristic: string; C0
Data_089_5707:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The giant bird", $F1
    db "took off with a", $FA, $F7
    db $EF, $EE, "human child", $A4, $EF, $EE, "Is he safe now?", $F7
    db $F0

Message_0D_30:: ; heuristic: string; C0
Data_089_574B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What if the", $F1
    db "island sinks, and", $FA, $F7
    db $EF, $EE, "you return from", $EF, $EE, "another world?", $FA, $F7
    db $EF, $EE, "Would you suddenly", $EF, $EE, "appear underwater?", $F7
    db $F0

Message_0D_31:: ; heuristic: string; C0
Data_089_57BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: For the sake of", $F1
    db "my grandchild, it", $FA, $F7
    db $EF, $EE, "may be best that", $EF, $EE, "we leave.", $FA, $F7
    db $EF, $EE, "She may make", $EF, $EE, "friends elsewhere.", $F7
    db $F0

Message_0D_32:: ; heuristic: string; C0
Data_089_5823:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Do we have to", $F1
    db "leave GreatLog?", $FA, $F7
    db $EF, $EE, "It doesn't matter,", $EF, $EE, "though.", $FA, $F7
    db $EF, $EE, "There's nothing", $EF, $EE, "here for me.", $F7
    db $F0

Message_0D_33:: ; heuristic: string; C0
Data_089_5883:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You saved us all", $F1
    db "by yourself.", $FA, $F7
    db $EF, $EE, "Your future is so", $EF, $EE, "full of promise!", $F7
    db $F0

Message_0D_34:: ; heuristic: string; C0
Data_089_58CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Please, eat up,", $F1
    db "eat up!", $FA, $F7
    db $EF, $EE, "Don't worry about", $EF, $EE, "your manners!", $F7
    db $F0

Message_0D_35:: ; heuristic: string; C0
Data_089_590B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hm? I saw your", $F1
    db "family.", $FA, $F7
    db $EF, $EE, "They were up on", $EF, $EE, "the treetop.", $F7
    db $F0

Message_0D_36:: ; heuristic: string; C0
Data_089_5947:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The Kingdom is", $F1
    db "rejoicing!", $F7
    db $F0

Message_0D_37:: ; heuristic: string; C0
Data_089_5965:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Instead of", $F1
    db "standing around,", $FA, $F7
    db $EF, $EE, "you should go and", $EF, $EE, "enjoy yourselves.", $F7
    db $F0

Message_0D_38:: ; heuristic: string; C0
Data_089_59AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Just imagine if", $F1
    db "you weren't here.", $FA, $F7
    db $EF, $EE, "That's a sobering", $EF, $EE, "thought.", $F7
    db $F0

Message_0D_39:: ; heuristic: string; C0
Data_089_59F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Ah, GreatLog's", $F1
    db "mighty hero!", $FA, $F7
    db $EF, $EE, "I hope you're", $EF, $EE, "enjoying this!", $F7
    db $F0

Message_0D_3A:: ; heuristic: string; C0
Data_089_5A2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: To be honest, I", $F1
    db "was getting ready", $FA, $F7
    db $EF, $EE, "to clear out.", $EF, $EE, "You saved us!", $F7
    db $F0

Message_0D_3B:: ; heuristic: string; C0
Data_089_5A75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Whinny!", $F7
    db $F0

Message_0D_3C:: ; heuristic: string; C0
Data_089_5A81:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: ", $A4, $A4, $A4, $A4, "!", $F7
    db $F0

Message_0D_3D:: ; heuristic: string; C0
Data_089_5A8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: They say Lady", $F1
    db "Yuna is back to", $FA, $F7
    db $EF, $EE, "her usual cheerful", $EF, $EE, "self.", $FA, $F7
    db $EF, $EE, "Perhaps she's still", $EF, $EE, "too young to mope", $FA, $F7
    db $EF, $EE, "over matters of", $EF, $EE, "the heart", $A4, $F7
    db $F0

Message_0D_3E:: ; heuristic: string; C0
Data_089_5B12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Huh? There is", $F1
    db "something here.", $FA, $F7
    db $EF, $EE, "Under the", $EF, $EE, "merchandise.", $F7
    db $F0

Message_0D_3F:: ; heuristic: string; C0
Data_089_5B4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What's that?", $F1
    db "Hey, a TinyMedal!", $FA, $F7
    db $EF, $EE, "That took good,", $EF, $EE, "compound eyes to", $FA, $F7
    db $EF, $EE, "spot on the ground", $EF, $EE, "like that!", $F7
    db $F0

Message_0D_40:: ; heuristic: string; C0
Data_089_5BB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I", $44, " like you to", $F1
    db "have this.", $FA, $F7
    db $EF, $EE, "Sort of a thanks", $EF, $EE, "for ArmyAnt.", $F7
    db $F0

Message_0D_41:: ; heuristic: string; C0
Data_089_5BF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "TinyMedal!", $F7
    db $F0

Message_0D_42:: ; heuristic: string; C0
Data_089_5C12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I'll pray for", $F1
    db "your safety.", $FA, $F7
    db $EF, $EE, "Take good care of", $EF, $EE, "yourself.", $F7
    db $F0

Message_0D_43:: ; heuristic: string; C0
Data_089_5C50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I", $44, " like you to", $F1
    db "have this.", $FA, $F7
    db $EF, $EE, "Sort of a thanks", $EF, $EE, "for ArmyAnt.", $FA, $F7
    db $EF, $EE, "Oh, wait. There's", $EF, $EE, "no room for this.", $FA, $F7
    db $EF, $EE, "I'll leave it with", $EF, $EE, "my ArmyAnt, so be", $FA, $F7
    db $EF, $EE, "sure to come get", $EF, $EE, "it later.", $F7
    db $F0

Message_0D_44:: ; heuristic: string; C0
Data_089_5CFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here it is-the", $F1
    db "TinyMedal.", $FA, $F7
    db $EF, $EE, "My master had me", $EF, $EE, "hold it for you.", $F7
    db $F0

Message_0D_45:: ; heuristic: string; C0
Data_089_5D42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here it is-the", $F1
    db "TinyMedal.", $FA, $F7
    db $EF, $EE, "My master had me", $EF, $EE, "hold it for you.", $FA, $F7
    db $EF, $EE, $A4, "You still don't", $EF, $EE, "have room for it", $A4, $F7
    db $F0

Message_0D_46:: ; heuristic: string; C0
Data_089_5DAC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What's wrong,", $F1
    db "MadGopher?", $FA, $F7
    db $EF, $EE, "Did you dig", $EF, $EE, "something up?", $FA, $F7
    db $EF, $EE, "Oh, hey!", $EF, $EE, "That's a TinyMedal!", $FA, $F7
    db $EF, $EE, "Good going,", $EF, $EE, "MadGopher!", $F7
    db $F0

Message_0D_47:: ; heuristic: string; C0
Data_089_5E21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here, ", $F9, "0!", $F1
    db "You hold onto it.", $F7
    db $F0

Message_0D_48:: ; heuristic: string; C0
Data_089_5E41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here, ", $F9, "0!", $F1
    db "You hold onto it.", $FA, $F7
    db $EF, $EE, "Oh, but look, you", $EF, $EE, "have no room.", $FA, $F7
    db $EF, $EE, "MadGopher will", $EF, $EE, "hold it for you.", $F7
    db $F0

Message_0D_49:: ; heuristic: string; C0
Data_089_5EA9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here's that", $F1
    db "TinyMedal.", $F7
    db $F0

Message_0D_4A:: ; heuristic: string; C0
Data_089_5EC3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here's that", $F1
    db "TinyMedal.", $FA, $F7
    db $EF, $EE, $A4, "Wait, you still", $EF, $EE, "have no room.", $F7
    db $F0

Message_0D_4B:: ; heuristic: string; C0
Data_089_5F00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What's that?", $F1
    db "Hey, a Magic Key!", $FA, $F7
    db $EF, $EE, "How did you manage", $EF, $EE, "to find that?", $F7
    db $F0

Message_0D_4C:: ; heuristic: string; C0
Data_089_5F47:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: ", $A4, $A4, $A4, $A4, "?", $F1
    db "You startled me", $A4, $FA, $F7
    db $EF, $EE, "I don't remember", $EF, $EE, "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "But you don't seem", $EF, $EE, "to know who I am", $A4, $F7
    db $F0

Message_0D_4D:: ; heuristic: string; C0
Data_089_5FF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: I don't remember", $F1
    db "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "But you don't seem", $EF, $EE, "to know who I am", $A4, $F7
    db $F0

Message_0D_4E:: ; heuristic: string; C0
Data_089_6086:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I'm digging here", $F1
    db "because I think", $FA, $F7
    db $EF, $EE, "this hole leads", $EF, $EE, "somewhere", $A4, $F7
    db $F0

Message_0D_4F:: ; heuristic: string; C0
Data_089_60C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pick the monster", $F1
    db "to go to the farm.", $F7
    db $F0

Message_0D_51:: ; heuristic: string; C0
Data_089_60EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N joined", $F1
    db "the party.", $E5, $D6, $F7
    db $F0

Message_0D_52:: ; heuristic: string; C0
Data_089_6106:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N headed off", $F1
    db "to the farm.", $E5, $D6, $F7
    db $F0

Message_0D_53:: ; heuristic: string; C0
Data_089_6124:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: ", $A4, "Wait, the farm", $F1
    db "is full", $A4, $F7
    db $F0

Message_0D_56:: ; heuristic: string; C0
Data_089_6141:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Let me join your", $F1
    db "party?", $FF, $F0

Message_0D_57:: ; heuristic: string; C0
Data_089_615D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: ", $A4, "The farm has no", $F1
    db "room left for me", $A4, $F7
    db $F0

Message_0D_58:: ; heuristic: string; C0
Data_089_6184:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What will you give", $F1
    db "to the Egg?", $F7
    db $F0

Message_0D_61:: ; heuristic: string; C0
Data_089_61A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "Y has been", $F1
    db "given to the Egg.", $FA, $F7
    db $EF, $EE, "What will you give", $EF, $EE, "it next?", $F7
    db $F0

Message_0D_62:: ; heuristic: string; C0
Data_089_61E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The farm is full.", $F7
    db $F0

Message_0D_63:: ; heuristic: string; C0
Data_089_61F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lamia entered", $F1
    db "the farm.", $F7
    db $F0

Message_0D_64:: ; heuristic: string; C0
Data_089_620F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dimensaur entered", $F1
    db "the farm.", $F7
    db $F0

Message_0D_65:: ; heuristic: string; C0
Data_089_622C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kagebou entered", $F1
    db "the farm.", $F7
    db $F0

Message_0D_66:: ; heuristic: string; C0
Data_089_6247:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cataloged", $F1
    db "100 monsters.", $F7
    db $F0

Message_0D_67:: ; heuristic: string; C0
Data_089_6263:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cataloged", $F1
    db "200 monsters.", $F7
    db $F0

Message_0D_68:: ; heuristic: string; C0
Data_089_627F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cataloged", $F1
    db "all the monsters.", $F7
    db $F0

Message_0D_69:: ; heuristic: string; C0
Data_089_629F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Really? Let's go", $F1
    db "to the Arena!", $F7
    db $F0

Message_0D_81:: ; heuristic: string; C0
Data_089_62C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Aww", $A4, " How boring", $A4, $F1
    db "Visit us again!", $F7
    db $F0

Message_0D_82:: ; heuristic: string; C0
Data_089_62E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Aww", $A4, " I lose.", $F1
    db "You are good!", $FA, $F7
    db $EF, $EE, "I wasn't trying", $EF, $EE, "very hard", $A4, $FA, $F7
    db $EF, $EE, "Eheheh, actually,", $EF, $EE, "I did want to win.", $F7
    db $F0

Message_0D_83:: ; heuristic: string; C0
Data_089_634C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Yay! I won!", $F1
    db "Am I awesome?", $F7
    db $F0

Message_0D_84:: ; heuristic: string; C0
Data_089_636A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Some monsters", $F1
    db "may be tough, but", $FA, $F7
    db $EF, $EE, "they could have", $EF, $EE, "surprising weak", $FA, $F7
    db $EF, $EE, "spots that can be", $EF, $EE, "exploited.", $FA, $F7
    db $EF, $EE, "Skills and dances", $EF, $EE, "that cause status", $FA, $F7
    db $EF, $EE, "problems can come", $EF, $EE, "in very handy.", $F7
    db $F0

Message_0D_85:: ; heuristic: string; C0
Data_089_6420:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: A master who can", $F1
    db "satisfy me", $A4, $FA, $F7
    db $EF, $EE, "Does such a", $EF, $EE, "battler exist?", $F7
    db $F0

Message_0D_86:: ; heuristic: string; C0
Data_089_6460:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Welcome! Do you", $F1
    db "wish to battle?", $F0

Message_0D_87:: ; heuristic: string; C0
Data_089_6483:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: GreatLog is a", $F1
    db "floating island?", $FA, $F7
    db $EF, $EE, "If I dig any more,", $EF, $EE, "the bottom'll go.", $F7
    db $F0

Message_0D_88:: ; heuristic: string; C0
Data_089_64CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I teased you as", $F1
    db "a cute rival", $A4, $FA, $F7
    db $EF, $EE, "But you've gone", $EF, $EE, "far beyond me.", $F7
    db $F0

Message_0D_89:: ; heuristic: string; C0
Data_089_6512:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Well, well!", $F1
    db "If it isn't the", $FA, $F7
    db $EF, $EE, "little hero who", $EF, $EE, "saved GreatLog?", $FA, $F7
    db $EF, $EE, "Make yourself at", $EF, $EE, "home and shop!", $FA, $F7
    db $EF, $EE, "What can I do for", $EF, $EE, "you today?", $F7
    db $F0

Message_0D_8A:: ; heuristic: string; C0
Data_089_659A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: My ArmyAnt,", $F1
    db "which I got from a", $FA, $F7
    db $EF, $EE, "monster master,", $EF, $EE, "made it possible", $FA, $F7
    db $EF, $EE, "for me to open", $EF, $EE, "this shop.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

Message_0D_8B:: ; heuristic: string; C0
Data_089_661F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You might know", $F1
    db "this already, but", $FA, $F7
    db $EF, $EE, "this is a good", $EF, $EE, "breeding pair,", $FA, $F7
    db $EF, $EE, "LizardMan and", $EF, $EE, "WingSlime.", $FA, $F7
    db $EF, $EE, "That will make you", $EF, $EE, "a Rayburn.", $F7
    db $F0

Message_0D_8C:: ; heuristic: string; C0
Data_089_66A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Wata, wata.", $F1
    db "Terry battled in", $FA, $F7
    db $EF, $EE, "the Starry Night", $EF, $EE, "Tournament as", $FA, $F7
    db $EF, $EE, "GreatTree's master,", $EF, $EE, "wataah.", $F7
    db $F0

Message_0D_8D:: ; heuristic: string; C0
Data_089_6708:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Fwahahahaha!", $F1
    db "How amusing!", $FA, $F7
    db $EF, $EE, "Even I fell before", $EF, $EE, "Terry's might!", $FA, $F7
    db $EF, $EE, "How you fare shall", $EF, $EE, "be intriguing.", $F7
    db $F0

Message_0D_8E:: ; heuristic: string; C0
Data_089_6771:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I", $44, " heard of a", $F1
    db "little hero", $A4, $FA, $F7
    db $EF, $EE, "But, it seems to", $EF, $EE, "be a bogus lead.", $FA, $F7
    db $EF, $EE, "I'll continue with", $EF, $EE, "my travels", $A4, $F7
    db $F0

Message_0D_8F:: ; heuristic: string; C0
Data_089_67D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: What a scruffy", $F1
    db "lot of masters", $A4, $FA, $F7
    db $EF, $EE, "I shouldn't believe", $EF, $EE, "vague rumors", $A4, $F7
    db $F0

Message_0D_90:: ; heuristic: string; C0
Data_089_6820:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Humph", $A4, $F1
    db "I'm Terry.", $FA, $F7
    db $EF, $EE, "Terry: I'm a master", $EF, $EE, "from GreatTree.", $FA, $F7
    db $EF, $EE, "I", $44, " heard about", $EF, $EE, "GreatLog's heroic", $FA, $F7
    db $EF, $EE, "master, so I came", $EF, $EE, "to look.", $FA, $F7
    db $EF, $EE, "But you can't be", $EF, $EE, "that master, you", $FA, $F7
    db $EF, $EE, "don't have a full", $EF, $EE, "party.", $F7
    db $F0

Message_0D_91:: ; heuristic: string; C0
Data_089_68E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: ", $F9, "0, you were", $F1
    db "so busy saving", $FA, $F7
    db $EF, $EE, "GreatLog that you", $EF, $EE, "forgot all about", $FA, $F7
    db $EF, $EE, "my errand, didn't", $EF, $EE, "you?", $FA, $F7
    db $EF, $EE, "I went and got the", $EF, $EE, "LoveWater myself.", $F7
    db $F0

Message_0D_92:: ; heuristic: string; C0
Data_089_696A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha: I think I", $F1
    db "have the natural", $FA, $F7
    db $EF, $EE, "talent to be a", $EF, $EE, "master.", $FA, $F7
    db $EF, $EE, $A4, "Don't give me", $EF, $EE, "that look!", $FA, $F7
    db $EF, $EE, "You don't believe", $EF, $EE, "me at all.", $FA, $F7
    db $EF, $EE, "Just you watch,", $EF, $EE, $F9, "0.", $FA, $F7
    db $EF, $EE, "I'll surpass you", $EF, $EE, "in no time!", $F7
    db $F0

Message_0D_93:: ; heuristic: string; C0
Data_089_6A1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: We've had reports", $F1
    db "of rogue masters", $FA, $F7
    db $EF, $EE, "who terrorize", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "We're investigating", $EF, $EE, "these reports, but", $FA, $F7
    db $EF, $EE, "it's serious if", $EF, $EE, "they're true!", $F7
    db $F0

Message_0D_94:: ; heuristic: string; C0
Data_089_6AAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Ah, bless you!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "As GreatLog's hero,", $F1
    db "you set a shining", $FA, $F7
    db $EF, $EE, "example to other", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "Thanks to you, our", $EF, $EE, "Kingdom's honor", $FA, $F7
    db $EF, $EE, "has been kept", $EF, $EE, "untarnished!", $F7
    db $F0

Message_0D_95:: ; heuristic: string; C0
Data_089_6B4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey", $A4, $F1
    db "That's cold of you.", $FA, $F7
    db $EF, $EE, "After all we've", $EF, $EE, "been through", $A4, $FA, $F7
    db $EF, $EE, "Yet you refuse me,", $EF, $EE, "warooh?", $F7
    db $F0

Message_0D_96:: ; heuristic: string; C0
Data_089_6BB5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Our church is", $F1
    db "impoverished, so", $FA, $F7
    db $EF, $EE, "I was sent out to", $EF, $EE, "this village.", $FA, $F7
    db $EF, $EE, "I can heal you of", $EF, $EE, "poison, nullify", $FA, $F7
    db $EF, $EE, "curses, and raise", $EF, $EE, "those knocked out.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you?", $F7
    db $F0

Message_0D_A1:: ; heuristic: string; C0
Data_089_6C64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Our church is", $F1
    db "impoverished, so", $FA, $F7
    db $EF, $EE, "I was sent out to", $EF, $EE, "this village.", $FA, $F7
    db $EF, $EE, "The slow pace of", $EF, $EE, "life here makes", $FA, $F7
    db $EF, $EE, "one lose sight of", $EF, $EE, "the flowing time.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you?", $F7
    db $F0

Message_0D_A2:: ; heuristic: string; C0
Data_089_6D11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey!", $F1
    db "I was the plug in", $FA, $F7
    db $EF, $EE, "the Log's Navel for", $EF, $EE, "a long time!", $FA, $F7
    db $EF, $EE, "The pie is my", $EF, $EE, "reward, warooh!", $FA, $F7
    db $EF, $EE, "I get to eat lots", $EF, $EE, "of it!", $F7
    db $F0

Message_0D_B1:: ; heuristic: string; C0
Data_089_6D99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha: I went and", $F1
    db "faced danger in", $FA, $F7
    db $EF, $EE, "other worlds for", $EF, $EE, "GreatLog's sake!", $FA, $F7
    db $EF, $EE, "All you did was", $EF, $EE, "loaf around here!", $F7
    db $F0

Message_0D_B2:: ; heuristic: string; C0
Data_089_6E09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: WA-HEY!", $F1
    db "Some Prince!", $FA, $F7
    db $EF, $EE, "Always a dirty", $EF, $EE, "mouth, warooh!", $F7
    db $F0

Message_0D_B3:: ; heuristic: string; C0
Data_089_6E4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha: You're a", $F1
    db "glutton!", $FA, $F7
    db $EF, $EE, "You haven't changed", $EF, $EE, "at all, glutton!", $F7
    db $F0

Message_0D_B4:: ; heuristic: string; C0
Data_089_6E8E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi: Pot-kettle-", $F1
    db "black, you two.", $FA, $F7
    db $EF, $EE, "You both need to", $EF, $EE, "smarten up.", $F7
    db $F0

Message_0D_B5:: ; heuristic: string; C0
Data_089_6ED3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara: You two went", $F1
    db "through all that,", $FA, $F7
    db $EF, $EE, "but you haven't", $EF, $EE, "wised up at all?", $F7
    db $F0

Message_0D_B6:: ; heuristic: string; C0
Data_089_6F1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey!", $F1
    db "Now look, warooh!", $FA, $F7
    db $EF, $EE, "It's your fault", $EF, $EE, "they find us!", $F7
    db $F0

Message_0D_B7:: ; heuristic: string; C0
Data_089_6F64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha: No one's", $F1
    db "taking this pie", $FA, $F7
    db $EF, $EE, "away from me!", $EF, $EE, $F7
    db $F0

Message_0D_B8:: ; heuristic: string; C0
Data_089_6F99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey", $A4, $F1
    db "I have seen this", $A4, $F7
    db $F0

Message_0D_B9:: ; heuristic: string; C0
Data_089_6FBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi: That's enough", $F1
    db "already.", $F7
    db $F0

Message_0D_BA:: ; heuristic: string; C0
Data_089_6FDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "What if you break", $EF, $EE, "the plug again?", $F7
    db $F0

Message_0D_BB:: ; heuristic: string; C0
Data_089_7001:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db "the ability to", $FA, $F7
    db $EF, $EE, "cross the sea is", $EF, $EE, "in you, warooh!", $FA, $F7
    db $EF, $EE, "Talk to the sea,", $EF, $EE, "and it will reply.", $FA, $F7
    db $EF, $EE, "Wa-hey? I felt an", $EF, $EE, "odd power!", $FA, $F7
    db $EF, $EE, "It's the sea!", $EF, $EE, "It's calling!", $FA, $F7
    db $EF, $EE, "A dilapidated", $EF, $EE, "pirate ship is", $FA, $F7
    db $EF, $EE, "what I see on the", $EF, $EE, "sea, warooh.", $FA, $F7
    db $EF, $EE, "But this time, you", $EF, $EE, "must find the key.", $FA, $F7
    db $EF, $EE, "It's right here in", $EF, $EE, "GreatLog, I think.", $FA, $F7
    db $EF, $EE, "The Pirate Key is", $EF, $EE, "what you want.", $F7
    db $F0

Message_0D_C1:: ; heuristic: string; C0
Data_089_716B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db "you can now crush", $FA, $F7
    db $EF, $EE, "huge boulders,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "You try in front", $EF, $EE, "of a boulder or a", $FA, $F7
    db $EF, $EE, "tree that's in the", $EF, $EE, "way. Anyway", $A4, $FA, $F7
    db $EF, $EE, $F9, "0, you will go", $EF, $EE, "look again?", $FA, $F7
    db $EF, $EE, "Wa-hey? I felt an", $EF, $EE, "odd power!", $FA, $F7
    db $EF, $EE, "It's cold!", $EF, $EE, "It's in ice!", $FA, $F7
    db $EF, $EE, "You know what I'm", $EF, $EE, "going to say", $A4, $FA, $F7
    db $EF, $EE, "I don't have the", $EF, $EE, "key, warooh.", $FA, $F7
    db $EF, $EE, "The Ice Key is", $EF, $EE, "what you want.", $F7
    db $F0

Message_0D_C2:: ; heuristic: string; C0
Data_089_72B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: It's exciting to", $F1
    db "think where an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key will take you.", $F7
    db $F0

Message_0D_C3:: ; heuristic: string; C0
Data_089_7300:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The shoals that", $F1
    db "ringed the volcano", $FA, $F7
    db $EF, $EE, "have suddenly", $EF, $EE, "disappeared.", $FA, $F7
    db $EF, $EE, "The sea can be so", $EF, $EE, "mysterious.", $F7
    db $F0

Message_0D_C4:: ; heuristic: string; C0
Data_089_7368:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What is it?", $F1
    db "Ah, it's you.", $FA, $F7
    db $EF, $EE, "What's that?", $EF, $EE, "The MoonRock?", $FA, $F7
    db $EF, $EE, "Ah, the mermaids", $EF, $EE, "helped you!", $F7
    db $F0

Message_0D_C5:: ; heuristic: string; C0
Data_089_73C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Welcome, my", $F1
    db "young hero!", $FA, $F7
    db $EF, $EE, "No words could", $EF, $EE, "ever do justice", $FA, $F7
    db $EF, $EE, "for the gratitude", $EF, $EE, "I feel for you.", $FA, $F7
    db $EF, $EE, "Instead, take this", $EF, $EE, "ring.", $FA, $F7
    db $EF, $EE, "I found it inside", $EF, $EE, "a sunken ship.", $FA, $F7
    db $EF, $EE, "It is best that it", $EF, $EE, "be returned to a", $FA, $F7
    db $EF, $EE, "human, namely you.", $EF, $EE, $F7
    db $F0

Message_0D_C6:: ; heuristic: string; C0
Data_089_74AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Sailor Ring.", $F7
    db $F0

Message_0D_C7:: ; heuristic: string; C0
Data_089_74C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Welcome, my", $F1
    db "young hero!", $FA, $F7
    db $EF, $EE, "No words could", $EF, $EE, "ever do justice", $FA, $F7
    db $EF, $EE, "for the gratitude", $EF, $EE, "I feel for you.", $FA, $F7
    db $EF, $EE, "Instead, take this", $EF, $EE, "ring.", $FA, $F7
    db $EF, $EE, "Ah, but you have", $EF, $EE, "no room for it.", $FA, $F7
    db $EF, $EE, "I'll keep it till", $EF, $EE, "you make room.", $F7
    db $F0

Message_0D_C8:: ; heuristic: string; C0
Data_089_7594:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Lady Yuna has", $F1
    db "always been highly", $FA, $F7
    db $EF, $EE, "energetic and", $EF, $EE, "rambunctious.", $FA, $F7
    db $EF, $EE, "We had a dickens", $EF, $EE, "of a time because", $FA, $F7
    db $EF, $EE, "she would always", $EF, $EE, "sneak off.", $F7
    db $F0

Message_0D_C9:: ; heuristic: string; C0
Data_089_7620:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How can we save", $F1
    db "Queen Helen?", $FA, $F7
    db $EF, $EE, "According to some", $EF, $EE, "medical books,", $FA, $F7
    db $EF, $EE, "there is something", $EF, $EE, "called SleepHerb.", $FA, $F7
    db $EF, $EE, "The scholar may", $EF, $EE, "know, but he has", $FA, $F7
    db $EF, $EE, "gone on a study", $EF, $EE, "trip to Nofor.", $F7
    db $F0

Message_0D_CA:: ; heuristic: string; C0
Data_089_76D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Let me show you", $F1
    db "my resurrected", $FA, $F7
    db $EF, $EE, "powers", $A4, $EF, $EE, $F7
    db $F0

Message_0D_CB:: ; heuristic: string; C0
Data_089_7707:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou: Wa-hey,", $F1
    db "you can now fly", $FA, $F7
    db $EF, $EE, "across the sky on", $EF, $EE, "a cloud, warooh!", $FA, $F7
    db $EF, $EE, "You try at the", $EF, $EE, "edge of land and", $FA, $F7
    db $EF, $EE, "the open sky.", $EF, $EE, "Anyway", $A4, $FA, $F7
    db $EF, $EE, $F9, "0, you will go", $EF, $EE, "look again?", $FA, $F7
    db $EF, $EE, "Wa-hey? I felt an", $EF, $EE, "odd power!", $FA, $F7
    db $EF, $EE, "I see it! A land", $EF, $EE, "floating way up", $FA, $F7
    db $EF, $EE, "high in the sky,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "The Sky Key is", $EF, $EE, "what you want.", $F7
    db $F0

Message_0D_CC:: ; heuristic: string; C0
Data_089_7834:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: YOUR LIFE ENDS", $F1
    db "HERE! GIVE IT UP!", $F7
    db $F0

Message_0D_CD:: ; heuristic: string; C0
Data_089_7859:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: KAHAHAHA!", $F1
    db "THEN LEAVE!", $F7
    db $F0

Message_0D_CE:: ; heuristic: string; C0
Data_089_7873:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I see", $A4, " But I", $F1
    db "will crush you!", $F7
    db $F0

Message_0D_CF:: ; heuristic: string; C0
Data_089_7894:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I see", $A4, " Then", $F1
    db "leave at once.", $F7
    db $F0

Message_0D_D0:: ; heuristic: string; C0
Data_089_78B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Impetuous fool!", $F1
    db "I'll show you!", $FA, $F7
    db $EF, $EE, "Come hither, my", $EF, $EE, "servants!", $F7
    db $F0

Message_0D_D1:: ; heuristic: string; C0
Data_089_78F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hm, fine, I'll", $F1
    db "ignore it.", $FA, $F7
    db $EF, $EE, "But just this", $EF, $EE, "time!", $F7
    db $F0

Message_0D_D2:: ; heuristic: string; C0
Data_089_7928:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The princess did", $F1
    db "not reply.", $FA, $F7
    db $EF, $EE, "But a malevolent", $EF, $EE, "voice spoke up", $A4, $F7
    db $F0

Message_0D_D3:: ; heuristic: string; C0
Data_089_796A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "'Inn downstairs.", $F1
    db "Rooms available.", $95, $F7
    db $F0

Message_0D_D4:: ; heuristic: string; C0
Data_089_798E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: If you breed,", $F1
    db "the parents go", $FA, $F7
    db $EF, $EE, "away somewhere,", $EF, $EE, "and their baby", $FA, $F7
    db $EF, $EE, "hatches at just", $EF, $EE, "level 1.", $FA, $F7
    db $EF, $EE, "But the baby will", $EF, $EE, "grow to surpass", $FA, $F7
    db $EF, $EE, "its parents if you", $EF, $EE, "raise it.", $F7
    db $F0

Message_0D_D5:: ; heuristic: string; C0
Data_089_7A36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Monster skills", $F1
    db "are passed on from", $FA, $F7
    db $EF, $EE, "parents to their", $EF, $EE, "offspring.", $FA, $F7
    db $EF, $EE, "Retain the skills", $EF, $EE, "you like on your", $FA, $F7
    db $EF, $EE, "monsters, and keep", $EF, $EE, "breeding them.", $FA, $F7
    db $EF, $EE, "Eventually, you'll", $EF, $EE, "have monsters that", $FA, $F7
    db $EF, $EE, "possess the moves", $EF, $EE, "you like best.", $F7
    db $F0

Message_0D_D6:: ; heuristic: string; C0
Data_089_7B17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Nightmares so", $F1
    db "horrible that they", $FA, $F7
    db $EF, $EE, "keep Queen Helen", $EF, $EE, "from sleeping", $A4, $FA, $F7
    db $EF, $EE, "What is happening", $EF, $EE, "to the kingdom?", $F7
    db $F0

Message_0D_D7:: ; heuristic: string; C0
Data_089_7B86:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Our hearts are", $F1
    db "like the skies", $FA, $F7
    db $EF, $EE, "above-heavy and", $EF, $EE, "clouded", $A4, $FA, $F7
    db $EF, $EE, "We're all starved", $EF, $EE, "for cheerful news.", $F7
    db $F0

Message_0D_D8:: ; heuristic: string; C0
Data_089_7BED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Queen Helen is", $F1
    db "wracked by awful", $FA, $F7
    db $EF, $EE, "nightmares night", $EF, $EE, "after night", $A4, $FA, $F7
    db $EF, $EE, "She's managed only", $EF, $EE, "snatches of sleep", $A4, $FA, $F7
    db $EF, $EE, "It's left her in a", $EF, $EE, "cranky mood", $A4, $F7
    db $F0

Message_0D_D9:: ; heuristic: string; C0
Data_089_7C7F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The reception", $F1
    db "hall is beyond", $FA, $F7
    db $EF, $EE, "here. Our Queen is", $EF, $EE, "waiting for you.", $F7
    db $F0

Message_0D_DA:: ; heuristic: string; C0
Data_089_7CC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Our Queen Helen's", $F1
    db "premonition made", $FA, $F7
    db $EF, $EE, "it possible for us", $EF, $EE, "to overcome the", $FA, $F7
    db $EF, $EE, "terrible cold", $EF, $EE, "spell for now", $A4, $FA, $F7
    db $EF, $EE, "But if the cold", $EF, $EE, "weather persists,", $FA, $F7
    db $EF, $EE, "who knows what", $EF, $EE, "will happen?", $F7
    db $F0

Message_0D_DB:: ; heuristic: string; C0
Data_089_7D7C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: What is it?", $F1
    db "Leave at once!", $FA, $F7
    db $EF, $EE, "This is no place", $EF, $EE, "for a child!", $FA, $F7
    db $EF, $EE, "What? Lady Yuna of", $EF, $EE, "the west?", $FA, $F7
    db $EF, $EE, "She's behaving in", $EF, $EE, "a peculiar manner?", $FA, $F7
    db $EF, $EE, "What rot!", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "That is of no", $EF, $EE, "concern to me!", $F7
    db $F0

Message_0D_DC:: ; heuristic: string; C0
Data_089_7E37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: This happened", $F1
    db "when I was deep in", $FA, $F7
    db $EF, $EE, "the forest far to", $EF, $EE, "the west.", $FA, $F7
    db $EF, $EE, "A young girl just", $EF, $EE, "appeared and she", $FA, $F7
    db $EF, $EE, "sort of glided", $EF, $EE, "over to me without", $FA, $F7
    db $EF, $EE, "moving her feet", $EF, $EE, "one bit.", $FA, $F7
    db $EF, $EE, "I turned and ran,", $EF, $EE, "but she followed!", $F7
    db $F0

Message_0D_DD:: ; heuristic: string; C0
Data_089_7F0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: My father is so", $F1
    db "cowardly, getting", $FA, $F7
    db $EF, $EE, "all spooked by a", $EF, $EE, "ghost.", $FA, $F7
    db $EF, $EE, "Your monsters", $EF, $EE, "frighten me more.", $F7
    db $F0
    ds $8C, $00
