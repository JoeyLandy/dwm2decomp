SECTION "Bank 2E", ROMX[$4000], BANK[$2E]
    db $2E

; message bank $2E: when wStringIndex < $A6, BeginStringDisplay with this bank's table Data_02E_4032; otherwise far-calls Func_099_4026 (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank2E, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2E, ShowMessageHL_ToBeginStringDisplay_Bank2E)
; reads: wStringIndex
BeginStringDisplay_Bank2E::
Func_02E_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $A6
    jr c, Jump_02E_400F
    farcall BeginStringDisplay_Bank2E_Overflow
    ret

Jump_02E_400F::
    ld de, MessageStrings_Bank2E
    call BeginStringDisplay
    ret

; message bank $2E: when wStringIndex < $A6, CopyStringToBuffer with this bank's table Data_02E_4032; otherwise far-calls Func_099_4035 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank2E:: ; heuristic: follows a terminator; C0
Func_02E_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $A6
    jr c, Jump_02E_4024
    farcall CopyStringToBuffer_Bank2E_Overflow
    ret

Jump_02E_4024::
    ld de, MessageStrings_Bank2E
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_2E_4032::
MessageStrings_Bank2E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_02E_4032:: ; address name
    dw StringList_2E_4034 ; id 0

; E-0217 (derived: category list of StringCategories_2E_4032; one pointer per wStringIndex)
; record: string
StringList_2E_4034::
Data_02E_4034:: ; address name
    dw Message_06_00 ; id 0
    dw Message_06_01 ; id 1
    dw Message_06_02 ; id 2
    dw Message_06_03 ; id 3
    dw Message_06_04 ; id 4
    dw Message_06_05 ; id 5
    dw Message_06_06 ; id 6
    dw Message_06_07 ; id 7
    dw Message_06_08 ; id 8
    dw Message_06_09 ; id 9
    dw Message_06_0A ; id 10
    dw Message_06_0B ; id 11
    dw Message_06_0C ; id 12
    dw Message_06_0D ; id 13
    dw Message_06_0E ; id 14
    dw Message_06_0F ; id 15
    dw Message_06_10 ; id 16
    dw Message_06_11 ; id 17
    dw Message_06_12 ; id 18
    dw Message_06_13 ; id 19
    dw Message_06_14 ; id 20
    dw Message_06_15 ; id 21
    dw Message_06_16 ; id 22
    dw Message_06_17 ; id 23
    dw Message_06_18 ; id 24
    dw Message_06_19 ; id 25
    dw Message_06_19 ; id 26
    dw Message_06_1B ; id 27
    dw Message_06_1C ; id 28
    dw Message_06_1D ; id 29
    dw Message_06_1E ; id 30
    dw Message_06_1F ; id 31
    dw Message_06_20 ; id 32
    dw Message_06_21 ; id 33
    dw Message_06_22 ; id 34
    dw Message_06_23 ; id 35
    dw Message_06_24 ; id 36
    dw Message_06_25 ; id 37
    dw Message_06_26 ; id 38
    dw Message_06_27 ; id 39
    dw Message_06_28 ; id 40
    dw Message_06_29 ; id 41
    dw Message_06_2A ; id 42
    dw Message_06_2B ; id 43
    dw Message_06_2C ; id 44
    dw Message_06_2D ; id 45
    dw Message_06_2E ; id 46
    dw Message_06_2F ; id 47
    dw Message_06_30 ; id 48
    dw Message_06_31 ; id 49
    dw Message_06_32 ; id 50
    dw Message_06_33 ; id 51
    dw Message_06_34 ; id 52
    dw Message_06_35 ; id 53
    dw Message_06_36 ; id 54
    dw Message_06_37 ; id 55
    dw Message_06_38 ; id 56
    dw Message_06_39 ; id 57
    dw Message_06_3A ; id 58
    dw Message_06_3B ; id 59
    dw Message_06_3C ; id 60
    dw Message_06_3D ; id 61
    dw Message_06_3E ; id 62
    dw Message_06_3F ; id 63
    dw Message_06_40 ; id 64
    dw Message_06_41 ; id 65
    dw Message_06_42 ; id 66
    dw Message_06_43 ; id 67
    dw Message_06_44 ; id 68
    dw Message_06_45 ; id 69
    dw Message_06_45 ; id 70
    dw Message_06_47 ; id 71
    dw Message_06_48 ; id 72
    dw Message_06_49 ; id 73
    dw Message_06_4A ; id 74
    dw Message_06_4B ; id 75
    dw Message_06_4C ; id 76
    dw Message_06_4D ; id 77
    dw Message_06_4E ; id 78
    dw Message_06_4F ; id 79
    dw Message_06_50 ; id 80
    dw Message_06_51 ; id 81
    dw Message_06_52 ; id 82
    dw Message_06_53 ; id 83
    dw Message_06_54 ; id 84
    dw Message_06_55 ; id 85
    dw Message_06_56 ; id 86
    dw Message_06_57 ; id 87
    dw Message_06_58 ; id 88
    dw Message_06_59 ; id 89
    dw Message_06_5A ; id 90
    dw Message_06_5B ; id 91
    dw Message_06_5C ; id 92
    dw Message_06_5D ; id 93
    dw Message_06_5E ; id 94
    dw Message_06_5F ; id 95
    dw Message_06_60 ; id 96
    dw Message_06_61 ; id 97
    dw Message_06_62 ; id 98
    dw Message_06_63 ; id 99
    dw Message_06_64 ; id 100
    dw Message_06_65 ; id 101
    dw Message_06_66 ; id 102
    dw Message_06_67 ; id 103
    dw Message_06_68 ; id 104
    dw Message_06_69 ; id 105
    dw Message_06_6A ; id 106
    dw Message_06_6B ; id 107
    dw Message_06_6C ; id 108
    dw Message_06_6D ; id 109
    dw Message_06_6E ; id 110
    dw Message_06_6F ; id 111
    dw Message_06_70 ; id 112
    dw Message_06_71 ; id 113
    dw Message_06_72 ; id 114
    dw Message_06_73 ; id 115
    dw Message_06_74 ; id 116
    dw Message_06_75 ; id 117
    dw Message_06_76 ; id 118
    dw Message_06_77 ; id 119
    dw Message_06_78 ; id 120
    dw Message_06_79 ; id 121
    dw Message_06_7A ; id 122
    dw Message_06_7B ; id 123
    dw Message_06_7C ; id 124
    dw Message_06_7D ; id 125
    dw Message_06_7E ; id 126
    dw Message_06_7F ; id 127
    dw Message_06_80 ; id 128
    dw Message_06_81 ; id 129
    dw Message_06_82 ; id 130
    dw Message_06_83 ; id 131
    dw Message_06_83 ; id 132
    dw Message_06_83 ; id 133
    dw Message_06_83 ; id 134
    dw Message_06_87 ; id 135
    dw Message_06_88 ; id 136
    dw Message_06_89 ; id 137
    dw Message_06_8A ; id 138
    dw Message_06_8B ; id 139
    dw Message_06_8C ; id 140
    dw Message_06_8D ; id 141
    dw Message_06_8E ; id 142
    dw Message_06_8F ; id 143
    dw Message_06_90 ; id 144
    dw Message_06_91 ; id 145
    dw Message_06_92 ; id 146
    dw Message_06_93 ; id 147
    dw Message_06_94 ; id 148
    dw Message_06_95 ; id 149
    dw Message_06_96 ; id 150
    dw Message_06_97 ; id 151
    dw Message_06_98 ; id 152
    dw Message_06_99 ; id 153
    dw Message_06_9A ; id 154
    dw Message_06_9B ; id 155
    dw Message_06_9C ; id 156
    dw Message_06_9D ; id 157
    dw Message_06_9E ; id 158
    dw Message_06_9F ; id 159
    dw Message_06_A0 ; id 160
    dw Message_06_A1 ; id 161
    dw Message_06_A2 ; id 162
    dw Message_06_A3 ; id 163
    dw Message_06_A4 ; id 164
    dw Message_06_A5 ; id 165

Message_06_00:: ; heuristic: string; C0
Data_02E_4180:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh!", $F7
    db $F0

Message_06_01:: ; heuristic: string; C0
Data_02E_4188:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're a human.", $F1
    db "How did you get in", $FA, $F7
    db $EF, $EE, "here? This world", $EF, $EE, "is only for elves.", $FA, $F7
    db $EF, $EE, "Get out of our", $EF, $EE, "world!", $F7
    db $F0

Message_06_02:: ; heuristic: string; C0
Data_02E_41F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Even worse, you", $F1
    db "have monsters.", $FA, $F7
    db $EF, $EE, "Get out of our", $EF, $EE, "world!", $F7
    db $F0

Message_06_03:: ; heuristic: string; C0
Data_02E_422D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Are you maybe a", $F1
    db "human?", $FF, $F0

Message_06_04:: ; heuristic: string; C0
Data_02E_4248:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So Cyal took a", $F1
    db "shine to you?", $FA, $F7
    db $EF, $EE, "That means you're", $EF, $EE, "not evil.", $FA, $F7
    db $EF, $EE, "Well, fine. This", $EF, $EE, "is what we'll do.", $FA, $F7
    db $EF, $EE, "You be my sister", $EF, $EE, "Cyal's friend.", $FA, $F7
    db $EF, $EE, "If you", $44, " do that,", $EF, $EE, "I'll tell you where", $FA, $F7
    db $EF, $EE, "the Elven village", $EF, $EE, "is located.", $FA, $F7
    db $EF, $EE, "I'm Rolt, and I", $EF, $EE, "guard the forest.", $F7
    db $F0

Message_06_05:: ; heuristic: string; C0
Data_02E_4340:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " Yay, you'll", $F1
    db "be my friend?", $FA, $F7
    db $EF, $EE, "What's your name?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, $A4, $F9, "0? We'll be", $EF, $EE, "good pals, ", $F9, "0.", $F7
    db $F0

Message_06_06:: ; heuristic: string; C0
Data_02E_4398:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " Go south in", $F1
    db "the plains, and", $FA, $F7
    db $EF, $EE, "you'll reach our", $EF, $EE, "village.", $FA, $F7
    db $EF, $EE, $F9, "0, you really", $EF, $EE, "should go.", $F7
    db $F0

Message_06_07:: ; heuristic: string; C0
Data_02E_43F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " We're going", $F1
    db "back home now.", $FA, $F7
    db $EF, $EE, "Maybe we can meet", $EF, $EE, "in the village.", $F7
    db $F0

Message_06_08:: ; heuristic: string; C0
Data_02E_443F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello, munchkin.", $F1
    db "Enjoy your stay!", $F7
    db $F0

Message_06_09:: ; heuristic: string; C0
Data_02E_4465:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " A human here?", $F1
    db "It's been several", $FA, $F7
    db $EF, $EE, "centuries since", $EF, $EE, "one last visited.", $F7
    db $F0

Message_06_0A:: ; heuristic: string; C0
Data_02E_44AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're not like", $F1
    db "us. You scare me", $A4, $F7
    db $F0

Message_06_0B:: ; heuristic: string; C0
Data_02E_44D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey there! I'm", $F1
    db "a talking horse.", $FA, $F7
    db $EF, $EE, "Glad to meet you,", $EF, $EE, "I'm sure.", $FA, $F7
    db $EF, $EE, "The monsters near", $EF, $EE, "the village are", $FA, $F7
    db $EF, $EE, "quite docile and", $EF, $EE, "harmless, but", $FA, $F7
    db $EF, $EE, "vicious monsters", $EF, $EE, "live farther away.", $FA, $F7
    db $EF, $EE, "It's dangerous, so", $EF, $EE, "I", $44, " stick close to", $FA, $F7
    db $EF, $EE, "the village if I", $EF, $EE, "were you.", $F7
    db $F0

Message_06_0C:: ; heuristic: string; C0
Data_02E_45CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This horse was", $F1
    db "here before us.", $F7
    db $F0

Message_06_0D:: ; heuristic: string; C0
Data_02E_45F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is Elven", $F1
    db "village.", $FA, $F7
    db $EF, $EE, "You're a human,", $EF, $EE, "aren't you?", $F7
    db $F0

Message_06_0E:: ; heuristic: string; C0
Data_02E_4629:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome! How may", $F1
    db "I help you today?", $F7
    db $F0

Message_06_0F:: ; heuristic: string; C0
Data_02E_4650:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, well", $A4, " It", $F1
    db "is a rare sight", $FA, $F7
    db $EF, $EE, "indeed to see a", $EF, $EE, "human here.", $FA, $F7
    db $EF, $EE, "I'm the Village", $EF, $EE, "Elder.", $FA, $F7
    db $EF, $EE, "By the way, have", $EF, $EE, "you seen two young", $FA, $F7
    db $EF, $EE, "elves? They are", $EF, $EE, "brother and sister", $FA, $F7
    db $EF, $EE, "and have yet to", $EF, $EE, "return from the", $FA, $F7
    db $EF, $EE, "forest in the", $EF, $EE, "north.", $F7
    db $F0

Message_06_10:: ; heuristic: string; C0
Data_02E_4739:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, well, a", $F1
    db "human here is a", $FA, $F7
    db $EF, $EE, "rare sight to see", $EF, $EE, "indeed.", $FA, $F7
    db $EF, $EE, "What's that? You", $EF, $EE, "say Rolt told you", $FA, $F7
    db $EF, $EE, "how to find this", $EF, $EE, "village?", $FA, $F7
    db $EF, $EE, "I see. Welcome.", $EF, $EE, "You're our guests.", $F7
    db $F0

Message_06_11:: ; heuristic: string; C0
Data_02E_47E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " That was", $F1
    db "fast, ", $F9, "0.", $FA, $F7
    db $EF, $EE, "I was worried that", $EF, $EE, "you might be lost.", $F7
    db $F0

Message_06_12:: ; heuristic: string; C0
Data_02E_4828:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " ", $F9, "0, let's", $F1
    db "play!", $FA, $F7
    db $EF, $EE, "I want to play", $EF, $EE, "hide and seek!", $FA, $F7
    db $EF, $EE, "I'll be waiting", $EF, $EE, "outside for you!", $F7
    db $F0

Message_06_13:: ; heuristic: string; C0
Data_02E_4885:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm the village's", $F1
    db "elder.", $FA, $F7
    db $EF, $EE, "What's that? You", $EF, $EE, "say Rolt told you", $FA, $F7
    db $EF, $EE, "how to find this", $EF, $EE, "village?", $FA, $F7
    db $EF, $EE, "I see. Welcome.", $EF, $EE, "You're our guests.", $F7
    db $F0

Message_06_14:: ; heuristic: string; C0
Data_02E_490A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tamed monsters,", $F1
    db "have you?", $FA, $F7
    db $EF, $EE, "That's impressive", $EF, $EE, "for a youngster.", $F7
    db $F0

Message_06_15:: ; heuristic: string; C0
Data_02E_494E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " ", $F9, "0, I can", $F1
    db "see that Cyal has", $FA, $F7
    db $EF, $EE, "taken a real", $EF, $EE, "liking to you.", $FA, $F7
    db $EF, $EE, "She", $44, " always looked", $EF, $EE, "forward to meeting", $FA, $F7
    db $EF, $EE, "a human, and she", $EF, $EE, "got her wish.", $FA, $F7
    db $EF, $EE, "Could you be a", $EF, $EE, "friend to her even", $FA, $F7
    db $EF, $EE, "if it's only for a", $EF, $EE, "short while?", $F7
    db $F0

Message_06_16:: ; heuristic: string; C0
Data_02E_4A28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " Listen,", $F1
    db $F9, "0. We should", $FA, $F7
    db $EF, $EE, "go to the Elven", $EF, $EE, "forest.", $FA, $F7
    db $EF, $EE, "We can play in the", $EF, $EE, "big clearing!", $FA, $F7
    db $EF, $EE, "Do you remember?", $EF, $EE, "It's where we met.", $FA, $F7
    db $EF, $EE, "I'll go ahead, but", $EF, $EE, "don't make me wait!", $F7
    db $F0

Message_06_17:: ; heuristic: string; C0
Data_02E_4AD7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cyal grew up as", $F1
    db "an orphan.", $FA, $F7
    db $EF, $EE, "Her parents were", $EF, $EE, "killed by monsters", $FA, $F7
    db $EF, $EE, "while she was", $EF, $EE, "still a baby.", $FA, $F7
    db $EF, $EE, "Rolt tries very", $EF, $EE, "hard to make sure", $FA, $F7
    db $EF, $EE, "Cyal doesn't get", $EF, $EE, "lonesome.", $FA, $F7
    db $EF, $EE, "That's why he", $EF, $EE, "pampers her.", $F7
    db $F0

Message_06_18:: ; heuristic: string; C0
Data_02E_4BA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Cyal and Rolt", $F1
    db "have no family", $FA, $F7
    db $EF, $EE, "except each other.", $EF, $EE, "If you have any", $FA, $F7
    db $EF, $EE, "siblings, treat", $EF, $EE, "them with love.", $F7
    db $F0

Message_06_19:: ; heuristic: string; C0
Data_02E_4C0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cyal's parents", $F1
    db "were attacked by", $FA, $F7
    db $EF, $EE, "horrible monsters.", $EF, $EE, "They come and raid", $FA, $F7
    db $EF, $EE, "our village every", $EF, $EE, "so often.", $FA, $F7
    db $EF, $EE, "That's why we post", $EF, $EE, "lookouts around", $FA, $F7
    db $EF, $EE, "the village.", $EF, $EE, "Rolt says he will", $FA, $F7
    db $EF, $EE, "get his revenge", $EF, $EE, "one day.", $F7
    db $F0

Message_06_1B:: ; heuristic: string; C0
Data_02E_4CDF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I think Cyal's", $F1
    db "looking forward to", $FA, $F7
    db $EF, $EE, "playing with you", $EF, $EE, "a lot.", $F7
    db $F0

Message_06_1C:: ; heuristic: string; C0
Data_02E_4D20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Humans can't be", $F1
    db "trusted, but", $A4, $FA, $F7
    db $EF, $EE, "Please watch over", $EF, $EE, "Cyal.", $F7
    db $F0

Message_06_1D:: ; heuristic: string; C0
Data_02E_4D5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " Oh! ", $F9, "0!", $F1
    db "I'm over here!", $FA, $F7
    db $EF, $EE, "Let's play hide-", $EF, $EE, "and-seek!", $FA, $F7
    db $EF, $EE, "I'll hide, so you", $EF, $EE, "count to ten, and", $FA, $F7
    db $EF, $EE, "then come look for", $EF, $EE, "me, OK? ", $FA, $F7
    db $EF, $EE, "Ready? Start!", $EF, $EE, $F7
    db $F0

Message_06_1E:: ; heuristic: string; C0
Data_02E_4DF3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 counted off", $A4, $F1
    db $F7
    db $F0

Message_06_1F:: ; heuristic: string; C0
Data_02E_4E05:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " Eeek, ", $F9, "0!", $F1
    db "Help me!", $F7
    db $F0

Message_06_20:: ; heuristic: string; C0
Data_02E_4E20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master AgDevil,", $F1
    db "a human, ruff!", $F7
    db $F0

Message_06_21:: ; heuristic: string; C0
Data_02E_4E43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What shall we", $F1
    db "do, ruff?", $F7
    db $F0

Message_06_22:: ; heuristic: string; C0
Data_02E_4E5F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Human? They", $F1
    db "taste horrible", $A4, $FA, $F7
    db $EF, $EE, "You lot can have", $EF, $EE, "it, enjoy, kiki!", $FA, $F7
    db $EF, $EE, "I'll take this", $EF, $EE, "appetizing one and", $FA, $F7
    db $EF, $EE, "savor it slowly,", $EF, $EE, "kikiki!", $F7
    db $F0

Message_06_23:: ; heuristic: string; C0
Data_02E_4EE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, we have to", $F1
    db "eat the lousy food", $FA, $F7
    db $EF, $EE, "like we always do,", $EF, $EE, "ruff!", $F7
    db $F0

Message_06_24:: ; heuristic: string; C0
Data_02E_4F2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That's what we'll", $F1
    db "do, kid.", $FA, $F7
    db $EF, $EE, "You're our dinner", $EF, $EE, "today, ruff!", $F7
    db $F0

Message_06_25:: ; heuristic: string; C0
Data_02E_4F6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, I can't", $F1
    db "enjoy my meal like", $FA, $F7
    db $EF, $EE, "this. I'll have my", $EF, $EE, "meal back home,", $FA, $F7
    db $EF, $EE, "kiki! Bye, you", $EF, $EE, "horrible tasting", $FA, $F7
    db $EF, $EE, "human!", $EF, $EE, $F7
    db $F0

Message_06_26:: ; heuristic: string; C0
Data_02E_4FE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? It's here", $F1
    db "again, ruff!", $FA, $F7
    db $EF, $EE, "It's persistent,", $EF, $EE, "ruff!", $FA, $F7
    db $EF, $EE, "This time, we'll", $EF, $EE, "show no mercy!", $FA, $F7
    db $EF, $EE, "Say your prayers,", $EF, $EE, "ruff!", $F7
    db $F0

Message_06_27:: ; heuristic: string; C0
Data_02E_505B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e come back", $F1
    db "again, ruff?", $FA, $F7
    db $EF, $EE, "You're stupid but", $EF, $EE, "brave, ruff!", $F7
    db $F0

Message_06_28:: ; heuristic: string; C0
Data_02E_509E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " What? Cyal", $F1
    db "was abducted?", $FA, $F7
    db $EF, $EE, "Who did it?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "What? An AgDevil", $EF, $EE, "took my sister?", $FA, $F7
    db $EF, $EE, "That fiend!", $EF, $EE, "Arrrrgh!", $F7
    db $F0

Message_06_29:: ; heuristic: string; C0
Data_02E_510F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Rolt, wait!", $F1
    db $A4, "Gone already", $A4, $F7
    db $F0

Message_06_2A:: ; heuristic: string; C0
Data_02E_512E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " AgDevil killed", $F1
    db "Rolt's parents.", $FA, $F7
    db $EF, $EE, "Rolt must have", $EF, $EE, "gone to save Cyal", $A4, $FA, $F7
    db $EF, $EE, "But no one seems", $EF, $EE, "to know exactly", $FA, $F7
    db $EF, $EE, "where the monsters", $EF, $EE, "come from.", $FA, $F7
    db $EF, $EE, "Perhaps someone in", $EF, $EE, "the lookout post", $FA, $F7
    db $EF, $EE, "would have a", $EF, $EE, "better idea", $A4, $F7
    db $F0

Message_06_2B:: ; heuristic: string; C0
Data_02E_5203:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " AgDevil appears", $F1
    db "to come from deep", $FA, $F7
    db $EF, $EE, "in the mountains.", $EF, $EE, "Perhaps someone in", $FA, $F7
    db $EF, $EE, "the lookout post", $EF, $EE, "would know more.", $F7
    db $F0

Message_06_2C:: ; heuristic: string; C0
Data_02E_5278:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " AgDevil is a", $F1
    db "total terror.", $FA, $F7
    db $EF, $EE, "We built a lookout", $EF, $EE, "post so we can", $FA, $F7
    db $EF, $EE, "keep an eye out", $EF, $EE, "for him.", $FA, $F7
    db $EF, $EE, "It's in the middle", $EF, $EE, "of the plains to", $FA, $F7
    db $EF, $EE, "the east where few", $EF, $EE, "trees grow.", $FA, $F7
    db $EF, $EE, "Someone in the", $EF, $EE, "lookout post may", $FA, $F7
    db $EF, $EE, "have an idea where", $EF, $EE, "the monsters live.", $F7
    db $F0

Message_06_2D:: ; heuristic: string; C0
Data_02E_5372:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cyal was taken", $F1
    db "away by monsters?", $FA, $F7
    db $EF, $EE, "That", $A4, " That's just", $EF, $EE, "terrible!", $FA, $F7
    db $EF, $EE, "What were the", $EF, $EE, "lookouts doing?", $FA, $F7
    db $EF, $EE, "Where is the", $EF, $EE, "lookout post?", $FA, $F7
    db $EF, $EE, "It's out in the", $EF, $EE, "east.", $F7
    db $F0

Message_06_2E:: ; heuristic: string; C0
Data_02E_5410:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Didn't I ask you", $F1
    db "to protect Cyal?", $F7
    db $F0

Message_06_2F:: ; heuristic: string; C0
Data_02E_5435:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is Elven's", $F1
    db "lookout post.", $FA, $F7
    db $EF, $EE, "We stand guard to", $EF, $EE, "prevent monsters", $FA, $F7
    db $EF, $EE, "from attacking the", $EF, $EE, "village.", $FA, $F7
    db $EF, $EE, "Your monsters won't", $EF, $EE, "do anything bad?", $F7
    db $F0

Message_06_30:: ; heuristic: string; C0
Data_02E_54C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Horrid monsters", $F1
    db "that attack elves", $FA, $F7
    db $EF, $EE, "appear often in", $EF, $EE, "these parts.", $FA, $F7
    db $EF, $EE, "You can avoid", $EF, $EE, "monsters in this", $FA, $F7
    db $EF, $EE, "lookout, and Elven", $EF, $EE, "village.", $FA, $F7
    db $EF, $EE, "Those are about", $EF, $EE, "the only havens.", $F7
    db $F0

Message_06_31:: ; heuristic: string; C0
Data_02E_5574:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "lookout post.", $FA, $F7
    db $EF, $EE, "Rolt came by a", $EF, $EE, "while ago asking", $FA, $F7
    db $EF, $EE, "about the hideouts", $EF, $EE, "of monsters.", $FA, $F7
    db $EF, $EE, "What? Cyal was", $EF, $EE, "abducted?", $FA, $F7
    db $EF, $EE, $A4, "That AgDevil, it's", $EF, $EE, "from the mountains", $FA, $F7
    db $EF, $EE, "in the north, I", $EF, $EE, "think.", $FA, $F7
    db $EF, $EE, "Go east, then turn", $EF, $EE, "north up into the", $FA, $F7
    db $EF, $EE, "mountains. It's", $EF, $EE, "around there.", $F7
    db $F0

Message_06_32:: ; heuristic: string; C0
Data_02E_5686:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That AgDevil is", $EF, $EE, "from the mountains", $FA, $F7
    db $EF, $EE, "in the north, I", $EF, $EE, "think.", $FA, $F7
    db $EF, $EE, "Go east, then turn", $EF, $EE, "north up into the", $FA, $F7
    db $EF, $EE, "mountains. It's", $EF, $EE, "around there.", $F7
    db $F0

Message_06_33:: ; heuristic: string; C0
Data_02E_5713:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You're not going", $F1
    db "to the northern", $FA, $F7
    db $EF, $EE, "mountains where", $EF, $EE, "the monsters live?", $FA, $F7
    db $EF, $EE, "Don't do it!", $EF, $EE, "They have no pity,", $FA, $F7
    db $EF, $EE, "not even for small", $EF, $EE, "children!", $F7
    db $F0

Message_06_34:: ; heuristic: string; C0
Data_02E_57A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " I", $42, "e found", $F1
    db "you at last!", $FA, $F7
    db $EF, $EE, "Everything you", $42, "e", $EF, $EE, "taken from us, I'm", $FA, $F7
    db $EF, $EE, "going to take back", $EF, $EE, "from you now!", $F7
    db $F0

Message_06_35:: ; heuristic: string; C0
Data_02E_580D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Kikiki, what", $F1
    db "just you?", $FA, $F7
    db $EF, $EE, "That's utterly", $EF, $EE, "laughable!", $F7
    db $F0

Message_06_36:: ; heuristic: string; C0
Data_02E_5845:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " Shut up!", $F1
    db "Give back Cyal!", $F7
    db $F0

Message_06_37:: ; heuristic: string; C0
Data_02E_5866:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Humph", $A4, $F1
    db "How boring", $A4, $F7
    db $F0

Message_06_38:: ; heuristic: string; C0
Data_02E_587D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " Urrrgh", $A4, $F1
    db $F9, "0", $A4, " Please", $A4, $FA, $F7
    db $EF, $EE, "Please save Cyal!", $EF, $EE, $F7
    db $F0

Message_06_39:: ; heuristic: string; C0
Data_02E_58B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The human in the", $F1
    db "forest again?", $FA, $F7
    db $EF, $EE, "You think you can", $EF, $EE, "defy me?", $FA, $F7
    db $EF, $EE, "Such a rude child!", $EF, $EE, "I'll crush you!", $F7
    db $F0

Message_06_3A:: ; heuristic: string; C0
Data_02E_5918:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What, you again?", $F1
    db "Rude, rude, rude!", $F7
    db $F0

Message_06_3B:: ; heuristic: string; C0
Data_02E_593F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wh-what? I", $A4, $F1
    db "Lost to a child?", $F7
    db $F0

Message_06_3C:: ; heuristic: string; C0
Data_02E_5960:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " Wow", $A4, " ", $F9, "0,", $F1
    db "you're tough.", $FA, $F7
    db $EF, $EE, "Oh! Cyal!", $EF, $EE, "Where's Cyal?", $F7
    db $F0

Message_06_3D:: ; heuristic: string; C0
Data_02E_5999:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " Cyal! Are", $F1
    db "you OK? Cyal!", $F7
    db $F0

Message_06_3E:: ; heuristic: string; C0
Data_02E_59B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " Big brother!", $F1
    db "I was so scared!", $F7
    db $F0

Message_06_3F:: ; heuristic: string; C0
Data_02E_59DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " You're safe", $F1
    db "now. ", $F9, "0 did it.", $F7
    db $F0

Message_06_40:: ; heuristic: string; C0
Data_02E_5A02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " ", $F9, "0, I'm", $F1
    db "sorry we put you", $FA, $F7
    db $EF, $EE, "through so much", $EF, $EE, "trouble.", $FA, $F7
    db $EF, $EE, "It was my fault", $EF, $EE, "for putting you", $FA, $F7
    db $EF, $EE, "into danger.", $EF, $EE, "I'm sorry.", $FA, $F7
    db $EF, $EE, "I have to thank", $EF, $EE, "you somehow.", $FA, $F7
    db $EF, $EE, "But, let's go back", $EF, $EE, "to the village.", $F7
    db $F0

Message_06_41:: ; heuristic: string; C0
Data_02E_5AC5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm glad that", $F1
    db "Cyal and Rolt are", $FA, $F7
    db $EF, $EE, "safe. ", $F9, "0, we", $EF, $EE, "owe it all to you.", $F7
    db $F0

Message_06_42:: ; heuristic: string; C0
Data_02E_5B0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " ", $F9, "0, thank", $F1
    db "you", $A4, $F7
    db $F0

Message_06_43:: ; heuristic: string; C0
Data_02E_5B23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " Cyal must be", $F1
    db "a bit overwhelmed.", $FA, $F7
    db $EF, $EE, "She's happy you", $EF, $EE, "saved her, ", $F9, "0.", $F7
    db $F0

Message_06_44:: ; heuristic: string; C0
Data_02E_5B6D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our gratitude is", $F1
    db "as plentiful as", $FA, $F7
    db $EF, $EE, "there are stars in", $EF, $EE, "the sky!", $F7
    db $F0

Message_06_45:: ; heuristic: string; C0
Data_02E_5BB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Rolt", $A3, " I'm going to", $F1
    db "get strong like", $FA, $F7
    db $EF, $EE, $F9, "0, and I'll", $EF, $EE, "protect Cyal!", $F7
    db $F0

Message_06_47:: ; heuristic: string; C0
Data_02E_5BF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " I hope you'll", $F1
    db "stay my friend.", $FA, $F7
    db $EF, $EE, "Please come visit", $EF, $EE, "again.", $F7
    db $F0

Message_06_48:: ; heuristic: string; C0
Data_02E_5C36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Cyal", $A3, " I ought to", $F1
    db "become a master", $FA, $F7
    db $EF, $EE, "like you, ", $F9, "0.", $EF, $EE, "It's so dashing!", $F7
    db $F0

Message_06_49:: ; heuristic: string; C0
Data_02E_5C7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We owe you a big", $F1
    db "thanks.", $FA, $F7
    db $EF, $EE, "I couldn't do a", $EF, $EE, "thing", $A4, $FA, $F7
    db $EF, $EE, "I have to become", $EF, $EE, "much stronger.", $FA, $F7
    db $EF, $EE, "I can't embarrass", $EF, $EE, "myself as a guard", $FA, $F7
    db $EF, $EE, "of the forest,", $EF, $EE, "after all.", $F7
    db $F0

Message_06_4A:: ; heuristic: string; C0
Data_02E_5D1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Thanks to you,", $F1
    db "we can live in", $FA, $F7
    db $EF, $EE, "peace, free of", $EF, $EE, "fear. Thank you!", $F7
    db $F0

Message_06_4B:: ; heuristic: string; C0
Data_02E_5D61:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You look kind", $F1
    db "and caring.", $FA, $F7
    db $EF, $EE, "I'm sorry I said I", $EF, $EE, "was scared of you.", $F7
    db $F0

Message_06_4C:: ; heuristic: string; C0
Data_02E_5DA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Brave human,", $F1
    db "hear this.", $FA, $F7
    db $EF, $EE, "The King of Plants", $EF, $EE, "rises from a rose", $FA, $F7
    db $EF, $EE, "and a giant.", $EF, $EE, "Do you understand?", $F7
    db $F0

Message_06_4D:: ; heuristic: string; C0
Data_02E_5E11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The talking", $F1
    db "horse came from", $FA, $F7
    db $EF, $EE, "somewhere outside", $EF, $EE, "this world.", $FA, $F7
    db $EF, $EE, "It's a mystery", $EF, $EE, "that's beyond me.", $F7
    db $F0

Message_06_4E:: ; heuristic: string; C0
Data_02E_5E76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You put down", $F1
    db "that fiend?", $FA, $F7
    db $EF, $EE, "You're tough!", $EF, $EE, "Unlike your looks.", $F7
    db $F0

Message_06_4F:: ; heuristic: string; C0
Data_02E_5EB7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You", $A4, " You're a", $F1
    db "savage but I must", $FA, $F7
    db $EF, $EE, "thank you as a", $EF, $EE, "courtesy.", $F7
    db $F0

Message_06_50:: ; heuristic: string; C0
Data_02E_5EF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is Elven's", $F1
    db "lookout post.", $FA, $F7
    db $EF, $EE, "We stand guard", $EF, $EE, "against monsters.", $FA, $F7
    db $EF, $EE, "But ever since you", $EF, $EE, "defeated AgDevil,", $FA, $F7
    db $EF, $EE, "it's been quiet.", $EF, $EE, "Thank you, really!", $F7
    db $F0

Message_06_51:: ; heuristic: string; C0
Data_02E_5F8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Beating AgDevil", $A4, $F1
    db "That's incredible!", $FA, $F7
    db $EF, $EE, "But now that it's", $EF, $EE, "become quiet, some", $FA, $F7
    db $EF, $EE, "lookouts have been", $EF, $EE, "slacking off", $A4, $F7
    db $F0

Message_06_52:: ; heuristic: string; C0
Data_02E_6001:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I", $42, "e heard that", $F1
    db "humans are wild", $FA, $F7
    db $EF, $EE, "savages. Don't get", $EF, $EE, "too close to me!", $F7
    db $F0

Message_06_53:: ; heuristic: string; C0
Data_02E_604B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "I'm the Village", $F1
    db "Elder.", $FA, $F7
    db $EF, $EE, "By the way, have", $EF, $EE, "you seen two young", $FA, $F7
    db $EF, $EE, "elves? They are", $EF, $EE, "brother and", $FA, $F7
    db $EF, $EE, "sister. They have", $EF, $EE, "yet to return", $FA, $F7
    db $EF, $EE, "from the forest in", $EF, $EE, "the north.", $F7
    db $F0

Message_06_54:: ; heuristic: string; C0
Data_02E_60F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Too strong", $A4, $F1
    db "Arroooh!", $F7
    db $F0

Message_06_55:: ; heuristic: string; C0
Data_02E_610B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Not only their", $F1
    db "parents, but Cyal", $FA, $F7
    db $EF, $EE, "was taken too?", $EF, $EE, "Poor Rolt", $A4, $FA, $F7
    db $EF, $EE, "You're Cyal's", $EF, $EE, "friend, aren't you?", $FA, $F7
    db $EF, $EE, "Can't you help her?", $EF, $EE, $F7
    db $F0

Message_06_56:: ; heuristic: string; C0
Data_02E_6189:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "Herbs for sale.", $F7
    db $F0

Message_06_57:: ; heuristic: string; C0
Data_02E_61CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "A sharp aroma of", $EF, $EE, "medicine wafted", $A4, $F7
    db $F0

Message_06_58:: ; heuristic: string; C0
Data_02E_6206:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "Stew simmered and", $EF, $EE, "bubbled in a pot.", $F7
    db $F0

Message_06_59:: ; heuristic: string; C0
Data_02E_6244:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hoh? Ah, excuse", $F1
    db "my incivility.", $FA, $F7
    db $EF, $EE, "It's not often we", $EF, $EE, "get visitors here.", $FA, $F7
    db $EF, $EE, "Hm, what manner of", $EF, $EE, "person are you?", $FA, $F7
    db $EF, $EE, "Having monsters as", $EF, $EE, "your chaperones.", $FA, $F7
    db $EF, $EE, "Ah, you are what,", $EF, $EE, "a monster master?", $FA, $F7
    db $EF, $EE, "Ah, I am Professor", $EF, $EE, "Kiral, by the way.", $FA, $F7
    db $EF, $EE, "Kiral", $A3, " I conduct", $EF, $EE, "research here.", $FA, $F7
    db $EF, $EE, "I am in need of an", $EF, $EE, "assistant now", $A4, $FA, $F7
    db $EF, $EE, "How would you like", $EF, $EE, "to work for me?", $FA, $F7
    db $EF, $EE, "Not for free, of", $EF, $EE, "course. Well?", $FF, $F0

Message_06_5A:: ; heuristic: string; C0
Data_02E_63C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Pii", $A4, " Ggzz", $A4, $F1
    db "Piiiiii", $A4, $F7
    db $F0

Message_06_5B:: ; heuristic: string; C0
Data_02E_63DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Hohoh!", $F1
    db "Grand, grand!", $FA, $F7
    db $EF, $EE, "Go fetch the", $EF, $EE, "treasure I", $42, "e", $FA, $F7
    db $EF, $EE, "stored. It's", $EF, $EE, "inside a barrel in", $FA, $F7
    db $EF, $EE, "the basement room.", $EF, $EE, "Monsters have", $FA, $F7
    db $EF, $EE, "infested the lower", $EF, $EE, "levels, hence it", $FA, $F7
    db $EF, $EE, "is impossible for", $EF, $EE, "me to set foot", $FA, $F7
    db $EF, $EE, "down there.", $F7
    db $F0

Message_06_5C:: ; heuristic: string; C0
Data_02E_64BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Oh! Foolish", $F1
    db "of me, I almost", $FA, $F7
    db $EF, $EE, "forgot to mention", $EF, $EE, "that there is a", $FA, $F7
    db $EF, $EE, "guard in the room", $EF, $EE, "of barrels.", $FA, $F7
    db $EF, $EE, "It may appear", $EF, $EE, "intimidating,", $FA, $F7
    db $EF, $EE, "but when it sees", $EF, $EE, "that you are in my", $FA, $F7
    db $EF, $EE, "employ, it should", $EF, $EE, "become compliant.", $FA, $F7
    db $EF, $EE, "I'm counting on", $EF, $EE, "you. Hohoh!", $F7
    db $F0

Message_06_5D:: ; heuristic: string; C0
Data_02E_65B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " No? ", $F1
    db "How disappointing.", $FA, $F7
    db $EF, $EE, "Your efforts would", $EF, $EE, "be rewarded.", $F7
    db $F0

Message_06_5E:: ; heuristic: string; C0
Data_02E_65FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " I need help", $F1
    db "with my studies.", $FA, $F7
    db $EF, $EE, "Will you help me?", $EF, $EE, $FF, $F0

Message_06_5F:: ; heuristic: string; C0
Data_02E_663A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Fetch me my", $F1
    db "treasure from the", $FA, $F7
    db $EF, $EE, "barrel room in the", $EF, $EE, "basement.", $FA, $F7
    db $EF, $EE, "There is a guard", $EF, $EE, "there, but it will", $FA, $F7
    db $EF, $EE, "become docile once", $EF, $EE, "it realizes you", $FA, $F7
    db $EF, $EE, "are working on my", $EF, $EE, "behalf.", $F7
    db $F0

Message_06_60:: ; heuristic: string; C0
Data_02E_66EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, "A recent diary was", $EF, $EE, "found.", $FA, $F7
    db $EF, $EE, $95, "Monsters appeared", $EF, $EE, "in the basement.", $FA, $F7
    db $EF, $EE, "The cause remains", $EF, $EE, "unknown.", $FA, $F7
    db $EF, $EE, "The lower levels", $EF, $EE, "can't be entered.", $95, $F7
    db $F0

Message_06_61:: ; heuristic: string; C0
Data_02E_6796:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, "A very old diary", $EF, $EE, "was found.", $FA, $F7
    db $EF, $EE, $95, "The treasure must", $EF, $EE, "be protected.", $FA, $F7
    db $EF, $EE, "Rob-N will be", $EF, $EE, "ideal.", $FA, $F7
    db $EF, $EE, "He can be trusted", $EF, $EE, "with the job.", $95, $F7
    db $F0

Message_06_62:: ; heuristic: string; C0
Data_02E_6834:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "Rolled blueprints", $EF, $EE, "were in a bundle.", $F7
    db $F0

Message_06_63:: ; heuristic: string; C0
Data_02E_6876:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It faintly smelled", $EF, $EE, "of mold", $A4, $F7
    db $F0

Message_06_64:: ; heuristic: string; C0
Data_02E_68B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There were things", $EF, $EE, "squirming inside.", $F7
    db $F0

Message_06_65:: ; heuristic: string; C0
Data_02E_68F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There was a note", $EF, $EE, "at the bottom.", $FA, $F7
    db $EF, $EE, $95, "The blue stone", $EF, $EE, "gives life.", $95, $F7
    db $F0

Message_06_66:: ; heuristic: string; C0
Data_02E_6957:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "A quite old diary", $EF, $EE, "was found.", $FA, $F7
    db $EF, $EE, $95, "A Roboster with", $EF, $EE, "outstanding specs", $FA, $F7
    db $EF, $EE, "was born. I gave", $EF, $EE, "it the name Rob-N.", $FA, $F7
    db $EF, $EE, "It is loyal, and", $EF, $EE, "obeys me without", $FA, $F7
    db $EF, $EE, "question or a hint", $EF, $EE, "of complaint.", $FA, $F7
    db $EF, $EE, "In fact it is too", $EF, $EE, "loyal", $A4, $95, $F7
    db $F0

Message_06_67:: ; heuristic: string; C0
Data_02E_6A4C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "A monster had been", $EF, $EE, "lurking inside.", $FA, $F7
    db $EF, $EE, "The monster reared", $EF, $EE, "up and lunged!", $F7
    db $F0

Message_06_68:: ; heuristic: string; C0
Data_02E_6AB5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There was nothing", $EF, $EE, "inside.", $F7
    db $F0

Message_06_69:: ; heuristic: string; C0
Data_02E_6AEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PROFESSOR", $A4, " SAY", $F1
    db "GUARD", $A4, " TREASURE", $A4, $FA, $F7
    db $EF, $EE, "NEVER", $A4, " SURRENDER", $EF, $EE, "IT", $A4, " NEGATIVE", $A4, $F7
    db $F0

Message_06_6A:: ; heuristic: string; C0
Data_02E_6B36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster is acting", $F1
    db "strangely.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "damaged somewhere.", $F7
    db $F0

Message_06_6B:: ; heuristic: string; C0
Data_02E_6B7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There was a blue", $EF, $EE, "shining stone.", $FA, $F7
    db $EF, $EE, $F9, "0 reached for", $EF, $EE, "the stone.", $FA, $F7
    db $EF, $EE, "Roboster sprang", $EF, $EE, "into action!", $F7
    db $F0

Message_06_6C:: ; heuristic: string; C0
Data_02E_6BFC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PROFESSOR", $A4, " SAY", $F1
    db "GUARD TREASURE", $A4, $F7
    db $F0

Message_06_6D:: ; heuristic: string; C0
Data_02E_6C1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PRO", $A4, " SOR", $A4, " AY", $A4, $F1
    db "GGGGUARD", $A4, " TREZZZT", $A4, $F7
    db $F0

Message_06_6E:: ; heuristic: string; C0
Data_02E_6C44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its damage appears", $F1
    db "to have worsened.", $F7
    db $F0

Message_06_6F:: ; heuristic: string; C0
Data_02E_6C6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PRO", $A4, " SOR", $A4, " AY", $A4, $F1
    db "GGGGUARD", $A4, " TREZZZT", $A4, $F7
    db $F0

Message_06_70:: ; heuristic: string; C0
Data_02E_6C8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PIPIPI", $A4, $F1
    db "GGGGGGAGAGAGA", $A4, $F7
    db $F0

Message_06_71:: ; heuristic: string; C0
Data_02E_6CAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster is acting", $F1
    db "bizarrely.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "seriously damaged.", $F7
    db $F0

Message_06_72:: ; heuristic: string; C0
Data_02E_6CF1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PIPIPI", $A4, $F1
    db "GGGGGGAGAGAGA", $A4, $F7
    db $F0

Message_06_73:: ; heuristic: string; C0
Data_02E_6D0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PI", $A4, " PI", $A4, $F7
    db $F0

Message_06_74:: ; heuristic: string; C0
Data_02E_6D18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster is acting", $F1
    db "as if demented.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "totally haywire.", $F7
    db $F0

Message_06_75:: ; heuristic: string; C0
Data_02E_6D62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PI", $A4, " PI", $A4, $F7
    db $F0

Message_06_76:: ; heuristic: string; C0
Data_02E_6D6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Ah! Back!", $F1
    db "The treasure?", $FA, $F7
    db $EF, $EE, "What? A Roboster?", $EF, $EE, "Gone haywire? Ah", $A4, $FA, $F7
    db $EF, $EE, "He", $A4, " He's broken but", $EF, $EE, "he guarded the", $FA, $F7
    db $EF, $EE, "treasure all this", $EF, $EE, "time", $A4, $FA, $F7
    db $EF, $EE, "The monsters down", $EF, $EE, "there, he probably", $FA, $F7
    db $EF, $EE, "summoned to keep", $EF, $EE, "intruders away", $A4, $FA, $F7
    db $EF, $EE, "All for following", $EF, $EE, "my orders", $A4, $F7
    db $F0

Message_06_77:: ; heuristic: string; C0
Data_02E_6E68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Please", $A4, $F1
    db "Go stop him.", $FA, $F7
    db $EF, $EE, "He will never know", $EF, $EE, "rest, otherwise.", $FA, $F7
    db $EF, $EE, "You can get the", $EF, $EE, "treasure later.", $F7
    db $F0

Message_06_78:: ; heuristic: string; C0
Data_02E_6ED2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Please", $A4, $F1
    db "Go stop him.", $FA, $F7
    db $EF, $EE, "You can get the", $EF, $EE, "treasure later.", $F7
    db $F0

Message_06_79:: ; heuristic: string; C0
Data_02E_6F14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " PROFE", $A4, " SOR", $A4, $F1
    db "ORDER", $A4, " MUST", $A4, " OBEY", $A4, $F7
    db $F0

Message_06_7A:: ; heuristic: string; C0
Data_02E_6F37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There was a blue", $EF, $EE, "shining stone.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "WizStone.", $F7
    db $F0

Message_06_7B:: ; heuristic: string; C0
Data_02E_6F95:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There was a blue", $EF, $EE, "shining stone.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it", $A4, $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "stone back.", $F7
    db $F0

Message_06_7C:: ; heuristic: string; C0
Data_02E_7011:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There was nothing", $EF, $EE, "inside.", $F7
    db $F0

Message_06_7D:: ; heuristic: string; C0
Data_02E_704B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Ah! Back!", $F1
    db "Is", $A4, " Rob-N", $A4, $FA, $F7
    db $EF, $EE, "Did you stop him?", $EF, $EE, $A4, "You did", $A4, $FA, $F7
    db $EF, $EE, "He served as a", $EF, $EE, "guard so well", $A4, $FA, $F7
    db $EF, $EE, "I'll fix him soon.", $EF, $EE, "And the treasure?", $F7
    db $F0

Message_06_7E:: ; heuristic: string; C0
Data_02E_70D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the blue stone.", $F7
    db $F0

Message_06_7F:: ; heuristic: string; C0
Data_02E_70F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " This stone,", $F1
    db "the WizStone, it", $FA, $F7
    db $EF, $EE, "is Roboster's fuel.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "The new type will", $EF, $EE, "become functional!", $F7
    db $F0

Message_06_80:: ; heuristic: string; C0
Data_02E_715B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Professor Kiral", $F1
    db "used the WizStone", $FA, $F7
    db $EF, $EE, "on a new robot.", $EF, $EE, "It began to move!", $F7
    db $F0

Message_06_81:: ; heuristic: string; C0
Data_02E_71A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Yes! Yes!", $F1
    db "Success!", $FA, $F7
    db $EF, $EE, "I owe this success", $EF, $EE, "to you!", $FA, $F7
    db $EF, $EE, "Take this. It's my", $EF, $EE, "thanks to you.", $F7
    db $F0

Message_06_82:: ; heuristic: string; C0
Data_02E_7204:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "SmartBook.", $F7
    db $F0

Message_06_83:: ; heuristic: string; C0
Data_02E_7220:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " You", $42, "e been", $F1
    db "a great help.", $FA, $F7
    db $EF, $EE, "I'll study how the", $EF, $EE, "new type breeds.", $FA, $F7
    db $EF, $EE, "I'll tell you if I", $EF, $EE, "discover how.", $FA, $F7
    db $EF, $EE, "Visit me when you", $EF, $EE, "have the time.", $F7
    db $F0

Message_06_87:: ; heuristic: string; C0
Data_02E_72B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Visit me", $F1
    db "when you're free.", $F7
    db $F0

Message_06_88:: ; heuristic: string; C0
Data_02E_72D5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I AM THE LATEST", $F1
    db "ROBOSTER.", $FA, $F7
    db $EF, $EE, "ROBOSTER2 IS MY", $EF, $EE, "OFFICIAL NAME.", $FA, $F7
    db $EF, $EE, "BUT THE PROFESSOR", $EF, $EE, "WILL GIVE ME A NEW", $FA, $F7
    db $EF, $EE, "NAME. IT FILLS ME", $EF, $EE, "WITH ANTICIPATION.", $F7
    db $F0

Message_06_89:: ; heuristic: string; C0
Data_02E_7368:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Hohoh! I", $42, "e", $F1
    db "got good news!", $FA, $F7
    db $EF, $EE, "Breed two Roboster", $EF, $EE, "units, and you may", $FA, $F7
    db $EF, $EE, "end up with a", $EF, $EE, "Roboster2.", $FA, $F7
    db $EF, $EE, "However, the two", $EF, $EE, "Robosters have to", $FA, $F7
    db $EF, $EE, "be modified to a", $EF, $EE, "certain degree.", $FA, $F7
    db $EF, $EE, "Otherwise, the", $EF, $EE, "breeding process", $FA, $F7
    db $EF, $EE, "ends prematurely", $EF, $EE, "with no recourse.", $F7
    db $F0

Message_06_8A:: ; heuristic: string; C0
Data_02E_7469:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kiral", $A3, " Roboster2's", $F1
    db "skills are simply", $FA, $F7
    db $EF, $EE, "exceptional.", $EF, $EE, "It can learn the", $FA, $F7
    db $EF, $EE, "ultimate sword", $EF, $EE, "attack.", $FA, $F7
    db $EF, $EE, "It was called", $A4, $EF, $EE, "Giga-something.", $F7
    db $F0

Message_06_8B:: ; heuristic: string; C0
Data_02E_74EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " MY NAME IS LEO.", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "THE PROFESSOR GAVE", $EF, $EE, "ME THAT NAME.", $FA, $F7
    db $EF, $EE, "IT SOUNDS STRONG.", $EF, $EE, "I LIKE IT.", $F7
    db $F0

Message_06_8C:: ; heuristic: string; C0
Data_02E_754B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " WELCOME.", $F1
    db "I AM ROB-N.", $FA, $F7
    db $EF, $EE, "I SERVE AS THE", $EF, $EE, "PROFESSOR", $95, "S AIDE.", $F7
    db $F0

Message_06_8D:: ; heuristic: string; C0
Data_02E_7589:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $A4, "Roboster stopped", $F1
    db "moving", $A4, $F7
    db $F0

Message_06_8E:: ; heuristic: string; C0
Data_02E_75A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster stopped", $F1
    db "moving entirely", $A4, $F7
    db $F0

Message_06_8F:: ; heuristic: string; C0
Data_02E_75C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the town", $F1
    db "of Miagen.", $FA, $F7
    db $EF, $EE, "It's quite an", $EF, $EE, "affluent place.", $FA, $F7
    db $EF, $EE, "But it's been a bit", $EF, $EE, "rough these days", $A4, $F7
    db $F0

Message_06_90:: ; heuristic: string; C0
Data_02E_7631:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Are you friends", $F1
    db "with monsters?", $FA, $F7
    db $EF, $EE, "You're just like", $EF, $EE, "this girl Milayou.", $FA, $F7
    db $EF, $EE, "Do you know who", $EF, $EE, "she is?", $F7
    db $F0

Message_06_91:: ; heuristic: string; C0
Data_02E_7697:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wow! You have", $F1
    db "monsters! Neat!", $FA, $F7
    db $EF, $EE, "Are they strong?", $EF, $EE, "Can they beat up", $FA, $F7
    db $EF, $EE, "bad people and", $EF, $EE, "monsters?", $F7
    db $F0

Message_06_92:: ; heuristic: string; C0
Data_02E_76FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Are your", $F1
    db "monsters good?", $FA, $F7
    db $EF, $EE, "I don't like bad", $EF, $EE, "monsters!", $F7
    db $F0

Message_06_93:: ; heuristic: string; C0
Data_02E_7736:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters can be", $F1
    db "good or bad.", $FA, $F7
    db $EF, $EE, "Your monsters", $EF, $EE, "appear to be good.", $FA, $F7
    db $EF, $EE, "That's really", $EF, $EE, "reassuring!", $F7
    db $F0

Message_06_94:: ; heuristic: string; C0
Data_02E_7799:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You appear to", $F1
    db "have the power to", $FA, $F7
    db $EF, $EE, "control monsters.", $EF, $EE, "You're just like", $FA, $F7
    db $EF, $EE, "Milayou who's over", $EF, $EE, "at the inn.", $FA, $F7
    db $EF, $EE, "You two are", $EF, $EE, "something else.", $FA, $F7
    db $EF, $EE, "Maybe I should", $EF, $EE, "copy what you do.", $F7
    db $F0

Message_06_95:: ; heuristic: string; C0
Data_02E_784A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Sigh", $A4, $F7
    db $F0

Message_06_96:: ; heuristic: string; C0
Data_02E_7854:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The old man's sigh", $F1
    db "sounded sad", $A4, $F7
    db $F0

Message_06_97:: ; heuristic: string; C0
Data_02E_7874:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Sigh", $A4, $F7
    db $F0

Message_06_98:: ; heuristic: string; C0
Data_02E_787E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The old woman's", $F1
    db "sigh was desolate", $A4, $F7
    db $F0

Message_06_99:: ; heuristic: string; C0
Data_02E_78A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters raided", $F1
    db "this house within", $FA, $F7
    db $EF, $EE, "the last while.", $EF, $EE, "They apparently", $FA, $F7
    db $EF, $EE, "stole something of", $EF, $EE, "great importance.", $F7
    db $F0

Message_06_9A:: ; heuristic: string; C0
Data_02E_7914:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The old people", $F1
    db "across the way", $FA, $F7
    db $EF, $EE, "look very sad", $EF, $EE, "recently.", $F7
    db $F0

Message_06_9B:: ; heuristic: string; C0
Data_02E_7952:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters have", $F1
    db "taken to attacking", $FA, $F7
    db $EF, $EE, "the town recently.", $EF, $EE, "But rather than", $FA, $F7
    db $EF, $EE, "people, they go", $EF, $EE, "after treasures.", $F7
    db $F0

Message_06_9C:: ; heuristic: string; C0
Data_02E_79C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Grrrr!", $F1
    db "I'm so angry!", $FA, $F7
    db $EF, $EE, "Monsters stole my", $EF, $EE, "lingerie!", $FA, $F7
    db $EF, $EE, "I", $42, "e never seen", $EF, $EE, "such sauciness!", $F7
    db $F0

Message_06_9D:: ; heuristic: string; C0
Data_02E_7A1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! What may", $F1
    db "I do for you?", $F7
    db $F0

Message_06_9E:: ; heuristic: string; C0
Data_02E_7A40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to our", $F1
    db "traveler's inn.", $F7
    db $F0

Message_06_9F:: ; heuristic: string; C0
Data_02E_7A62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you travel", $F1
    db "west along the", $FA, $F7
    db $EF, $EE, "plains, there is", $EF, $EE, "a hut.", $FA, $F7
    db $EF, $EE, "It should be by a", $EF, $EE, "small spring.", $FA, $F7
    db $EF, $EE, "The hut is for", $EF, $EE, "travelers and", $FA, $F7
    db $EF, $EE, "merchants to rest", $EF, $EE, "while on the road.", $F7
    db $F0

Message_06_A0:: ; heuristic: string; C0
Data_02E_7B0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Excuse me, are", $F1
    db "you a master?", $FA, $F7
    db $EF, $EE, "The town has been", $EF, $EE, "having a terrible", $FA, $F7
    db $EF, $EE, "time with monsters", $EF, $EE, "attacking and", $FA, $F7
    db $EF, $EE, "stealing treasures", $EF, $EE, "from homes.", $FA, $F7
    db $EF, $EE, "I want to help the", $EF, $EE, "people here.", $FA, $F7
    db $EF, $EE, "Could I ask for", $EF, $EE, "your help too?", $FA, $F7
    db $EF, $EE, "I", $44, " like you to", $EF, $EE, "battle and punish", $FA, $F7
    db $EF, $EE, "the bad monsters.", $EF, $EE, "Well? Could you?", $FF, $F0

Message_06_A1:: ; heuristic: string; C0
Data_02E_7C31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Thank you! I", $F1
    db "knew you", $44, " agree!", $FA, $F7
    db $EF, $EE, "My name's Milayou.", $EF, $EE, "I'm a master too.", $FA, $F7
    db $EF, $EE, "Milayou", $A3, " First,", $EF, $EE, "you should speak", $FA, $F7
    db $EF, $EE, "with the victims", $EF, $EE, "and see how you", $FA, $F7
    db $EF, $EE, "could help them", $EF, $EE, "over the crisis.", $FA, $F7
    db $EF, $EE, "I'll investigate", $EF, $EE, "where the monsters", $FA, $F7
    db $EF, $EE, "are coming from.", $EF, $EE, "Let's meet up", $FA, $F7
    db $EF, $EE, "again later on", $EF, $EE, "back here.", $F7
    db $F0

Message_06_A2:: ; heuristic: string; C0
Data_02E_7D50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I can't count on", $F1
    db "your support?", $FA, $F7
    db $EF, $EE, "That's really too", $EF, $EE, "bad", $A4, $F7
    db $F0

Message_06_A3:: ; heuristic: string; C0
Data_02E_7D8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Have you changed", $F1
    db "your mind?", $FA, $F7
    db $EF, $EE, "You will help the", $EF, $EE, "people in town?", $FF, $F0

Message_06_A4:: ; heuristic: string; C0
Data_02E_7DD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Could you humor", $F1
    db "this old man and", $FA, $F7
    db $EF, $EE, "hear his tale of", $EF, $EE, "woe?", $FA, $F7
    db $EF, $EE, "My daughter wedded", $EF, $EE, "a man from far", $FA, $F7
    db $EF, $EE, "away and left", $EF, $EE, "with him.", $FA, $F7
    db $EF, $EE, "A ring was the", $EF, $EE, "only memento I had", $FA, $F7
    db $EF, $EE, "of hers. Monsters", $EF, $EE, "stole it from me", $A4, $F7
    db $F0

Message_06_A5:: ; heuristic: string; C0
Data_02E_7EA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My daughter", $F1
    db "wedded a man from", $FA, $F7
    db $EF, $EE, "far away and left", $EF, $EE, "with him.", $FA, $F7
    db $EF, $EE, "A ring was the", $EF, $EE, "only memento I had", $FA, $F7
    db $EF, $EE, "of hers. Monsters", $EF, $EE, "stole it from us", $A4, $F7
    db $F0
    ds $CF, $00
