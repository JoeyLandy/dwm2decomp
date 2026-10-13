SECTION "Bank 89", ROMX[$4000], BANK[$89]
    db $89

; message bank $89: when wStringIndex < $DE, BeginStringDisplay with this bank's table
; MessageStrings_Bank89; otherwise far-calls BeginStringDisplay_Bank89_Overflow (E-0080)
BeginStringDisplay_Bank89::
    ld a, [wStringIndex]
    cp $de
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank89_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank89
    call BeginStringDisplay
    ret

; message bank $89: when wStringIndex < $DE, CopyStringToBuffer with this bank's table
; MessageStrings_Bank89; otherwise far-calls CopyStringToBuffer_Bank89_Overflow (E-0080)
CopyStringToBuffer_Bank89::
    ld a, [wStringIndex]
    cp $de
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank89_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank89
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_89_4032::
MessageStrings_Bank89::
    dw StringList_89_4034 ; id 0

; category list of StringCategories_89_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_89_4034::
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

Message_0D_00::
    db $ea, "*: They say you use", $f1
    db "Magic Keys to go", $fa, $f7
    db $ef, $ee, "to other worlds.", $ef, $ee, "I guess they're", $fa, $f7
    db $ef, $ee, "indispensable to", $ef, $ee, "monster masters.", $f7
    db $f0

Message_0D_01::
    db $ea, "King: Then, you", $f1
    db "are excused.", $fa, $f7
    db $ef, $ee, "I'm looking", $ef, $ee, "forward to the", $fa, $f7
    db $ef, $ee, "next show.", $ef, $ee, $f7
    db $f0

Message_0D_02::
    db $ea, "King: You wish to", $f1
    db "see our treasures?", $fa, $f7
    db $ef, $ee, "You're quite sharp", $ef, $ee, "to have an eye out", $fa, $f7
    db $ef, $ee, "for treasures, I", $ef, $ee, "must say.", $f7
    db $f0

Message_0D_03::
    db $ea, "*: That will help", $f1
    db "you for certain.", $fa, $f7
    db $ef, $ee, "Use it where you", $ef, $ee, "feel it is right.", $f7
    db $f0

Message_0D_04::
    db $eb, "*: Hello, have you", $f1
    db "found a plug for", $fa, $f7
    db $ef, $ee, "the Log's Navel?", $ef, $ee, $ff, $f0

Message_0D_05::
    db $eb, "*: Oh. That's nice.", $f1
    db "Good for you.", $f7
    db $f0

Message_0D_06::
    db $eb, "*: I can show you", $f1
    db "my navel if you", $fa, $f7
    db $ef, $ee, "promise to keep it", $ef, $ee, "a secret.", $f7
    db $f0

Message_0D_07::
    db $ea, "*: The shortage of", $f1
    db "water has been", $fa, $f7
    db $ef, $ee, "corrected, and the", $ef, $ee, "gang of thieves", $fa, $f7
    db $ef, $ee, "was finally caught", $ef, $ee, "and jailed.", $fa, $f7
    db $ef, $ee, "We won't have to", $ef, $ee, "worry about those", $fa, $f7
    db $ef, $ee, "things anymore,", $ef, $ee, "thank goodness.", $f7
    db $f0

Message_0D_08::
    db $ea, "*: Oh, it's you lot.", $f1
    db "We haven't had any", $fa, $f7
    db $ef, $ee, "problems with the", $ef, $ee, "reservoir.", $f7
    db $f0

Message_0D_09::
    db $eb, "*: The well filled", $f1
    db "up with water", $fa, $f7
    db $ef, $ee, "again.", $ef, $ee, "I don't have any", $fa, $f7
    db $ef, $ee, "excuse not to do", $ef, $ee, "laundry anymore.", $f7
    db $f0

Message_0D_0A::
    db $ea, "*: The band of", $f1
    db "thieves made their", $fa, $f7
    db $ef, $ee, "hideout in Mirage", $ef, $ee, "Lake.", $fa, $f7
    db $ef, $ee, "Staying away from", $ef, $ee, "Mirage Lake was a", $fa, $f7
    db $ef, $ee, "smart thing in", $ef, $ee, "hindsight.", $f7
    db $f0

Message_0D_0B::
    db $ea, "*: The King gave", $f1
    db "away his prized", $fa, $f7
    db $ef, $ee, "TidalBell to some", $ef, $ee, "traveler as a", $fa, $f7
    db $ef, $ee, "reward of some", $ef, $ee, "sort.", $fa, $f7
    db $ef, $ee, "I didn't know that", $ef, $ee, "our King could be", $fa, $f7
    db $ef, $ee, "so generous.", $ef, $ee, $f7
    db $f0

Message_0D_0C::
    db $ea, "*: Up ahead is the", $f1
    db "Starry Shrine, and", $fa, $f7
    db $ef, $ee, "the Egg Evaluator's", $ef, $ee, "chamber.", $fa, $f7
    db $ef, $ee, "Both of them offer", $ef, $ee, "essential services", $fa, $f7
    db $ef, $ee, "to masters, but", $ef, $ee, "they're always", $fa, $f7
    db $ef, $ee, "packed by other", $ef, $ee, "masters.", $fa, $f7
    db $ef, $ee, "It looks like I'll", $ef, $ee, "be waiting here", $fa, $f7
    db $ef, $ee, "for a long time", $a4, $ef, $ee, $f7
    db $f0

Message_0D_0D::
    db $ea, "*: While I was on", $f1
    db "the way to the", $fa, $f7
    db $ef, $ee, "Magic Door, I saw", $ef, $ee, "Warubou stuck in a", $fa, $f7
    db $ef, $ee, "hole for some", $ef, $ee, "unknown reason.", $fa, $f7
    db $ef, $ee, "What the heck was", $ef, $ee, "it doing?", $f7
    db $f0

Message_0D_0E::
    db $eb, "*: You're really", $f1
    db "trying to become a", $fa, $f7
    db $ef, $ee, "monster master?", $ef, $ee, "Well, go for it!", $fa, $f7
    db $ef, $ee, "I'll be cheering", $ef, $ee, "you on!", $f7
    db $f0

Message_0D_0F::
    db $ea, "*: Hm, you are", $f1
    db "quite strong", $a4, $fa, $f7
    db $ef, $ee, "I have to admit", $ef, $ee, "I'm impressed.", $fa, $f7
    db $ef, $ee, "Will you let me go", $ef, $ee, "with you?", $fa, $f7
    db $ef, $ee, "You'll find my", $ef, $ee, "dancing special!", $ff, $f0

Message_0D_10::
    db $ea, "*: Great! Let's", $f1
    db "make this work!", $f7
    db $f0

Message_0D_11::
    db $ea, "*: Your party's", $f1
    db "full", $a4, $fa, $f7
    db $ef, $ee, "There isn't any", $ef, $ee, "room for me.", $f7
    db $f0

Message_0D_12::
    db $ea, "*: Oh, but", $a4, " I can", $f1
    db "be so useful", $a4, $f7
    db $f0

Message_0D_13::
    db $ea, "*: The lighthouse", $f1
    db "is out east.", $fa, $f7
    db $ef, $ee, "Stay away-it's", $ef, $ee, "dangerous.", $fa, $f7
    db $ef, $ee, "Even though the", $ef, $ee, "MoonRock has been", $fa, $f7
    db $ef, $ee, "recovered from", $ef, $ee, "pirates and put", $fa, $f7
    db $ef, $ee, "back where it", $ef, $ee, "belongs, monsters", $fa, $f7
    db $ef, $ee, "still roam freely", $ef, $ee, "in the lighthouse.", $f7
    db $f0

Message_0D_14::
    db $ea, "*: Another master", $f1
    db "was here with two", $fa, $f7
    db $ef, $ee, "monsters in tow a", $ef, $ee, "while back.", $fa, $f7
    db $ef, $ee, "I think his name", $ef, $ee, "was Kameha.", $fa, $f7
    db $ef, $ee, "I haven't seen him", $ef, $ee, "since then.", $fa, $f7
    db $ef, $ee, "I wonder where", $ef, $ee, "he's gone?", $f7
    db $f0

Message_0D_15::
    db $ea, "*: OK! Let me dig!", $f1
    db "One-two, one-two!", $fa, $f7
    db $ef, $ee, "Huh? I just hit", $ef, $ee, "something hard.", $f7
    db $f0

Message_0D_16::
    db $ea, "*: What's wrong,", $f1
    db "MadGopher?", $fa, $f7
    db $ef, $ee, "Did you find", $ef, $ee, "something?", $fa, $f7
    db $ef, $ee, "Hey, that's a", $ef, $ee, "Magic Key!", $fa, $f7
    db $ef, $ee, "That's great work,", $ef, $ee, "MadGopher!", $f7
    db $f0

Message_0D_17::
    db $ea, "*: Here, ", $f9, "0!", $f1
    db "You need this!", $f7
    db $f0

Message_0D_18::
    db $f9, "0 received the", $f1
    db "Ice Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_0D_19::
    db $ea, "*: Be careful when", $f1
    db "you're traveling", $fa, $f7
    db $ef, $ee, "in other worlds.", $ef, $ee, $f7
    db $f0

Message_0D_1A::
    db $ea, "Warubou: Wa-hey,", $f1
    db "find another Magic", $fa, $f7
    db $ef, $ee, "Key in GreatLog", $ef, $ee, "and off you go to", $fa, $f7
    db $ef, $ee, "another world,", $ef, $ee, "warooh.", $fa, $f7
    db $ef, $ee, "The Ice Key is", $ef, $ee, "what you want.", $f7
    db $f0

Message_0D_1B::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0! Too slow!", $fa, $f7
    db $ef, $ee, "Kameha went to", $ef, $ee, "another world", $fa, $f7
    db $ef, $ee, "before you again,", $ef, $ee, "warooh!", $fa, $f7
    db $ef, $ee, "But then it doesn't", $ef, $ee, "matter who gets", $fa, $f7
    db $ef, $ee, "the job done, you", $ef, $ee, "or Kameha", $a4, $fa, $f7
    db $ef, $ee, "But after last", $ef, $ee, "time, you can be", $fa, $f7
    db $ef, $ee, "trusted more than", $ef, $ee, "Kameha, I think.", $fa, $f7
    db $ef, $ee, "This time, you'll", $ef, $ee, "find a plug, yes?", $fa, $f7
    db $ef, $ee, "Oh, and don't", $ef, $ee, "forget, you have", $fa, $f7
    db $ef, $ee, "new abilities for", $ef, $ee, "crossing water and", $fa, $f7
    db $ef, $ee, "smashing boulders.", $ef, $ee, "Don't forget!", $f7
    db $f0

Message_0D_1C::
    db $ea, "*: The King of the", $f1
    db "north was a fake,", $fa, $f7
    db $ef, $ee, "or so I've heard.", $ef, $ee, "Why though?", $fa, $f7
    db $ef, $ee, "Why would a", $ef, $ee, "monster want to", $fa, $f7
    db $ef, $ee, "impersonate a", $ef, $ee, "king?", $f7
    db $f0

Message_0D_1D::
    db $ea, "*: If you go south,", $f1
    db "you'll eventually", $fa, $f7
    db $ef, $ee, "reach the town of", $ef, $ee, "Weston.", $fa, $f7
    db $ef, $ee, "From there, go up", $ef, $ee, "a river and travel", $fa, $f7
    db $ef, $ee, "west to reach the", $ef, $ee, "castle.", $f7
    db $f0

Message_0D_1E::
    db $ea, "*: Oh", $a4, " Lady Yuna", $a4, $f1
    db "I miss you so", $a4, $fa, $f7
    db $ef, $ee, "I should find", $ef, $ee, "my courage and", $fa, $f7
    db $ef, $ee, "climb the vines to", $ef, $ee, "her window", $a4, $fa, $f7
    db $ef, $ee, "No, I mustn't do", $ef, $ee, "that", $a4, $f7
    db $f0

Message_0D_1F::
    db $ea, "*: How can we help", $f1
    db "Queen Helen?", $fa, $f7
    db $ef, $ee, "If there was a", $ef, $ee, "good medicine", $a4, $fa, $f7
    db $ef, $ee, "Perhaps we should", $ef, $ee, "ask the scholar", $a4, $fa, $f7
    db $ef, $ee, "But the scholar", $ef, $ee, "has gone off to", $fa, $f7
    db $ef, $ee, "Nofor", $a4, " What to do,", $ef, $ee, "what to do", $a4, $f7
    db $f0

Message_0D_20::
    db $ea, "*: Oh! That blue", $f1
    db "flower!", $fa, $f7
    db $ef, $ee, "It's unmistakably", $ef, $ee, "the SleepHerb!", $fa, $f7
    db $ef, $ee, "All you need to do", $ef, $ee, "is eat its leaves.", $fa, $f7
    db $ef, $ee, "As soon as you do,", $ef, $ee, "you drop off to a", $fa, $f7
    db $ef, $ee, "deep and relaxing", $ef, $ee, "sleep.", $f7
    db $f0

Message_0D_21::
    db $eb, "*: Star spuds grow", $f1
    db "plentifully around", $fa, $f7
    db $ef, $ee, "these parts. They", $ef, $ee, "are spuds that", $fa, $f7
    db $ef, $ee, "grow by the light", $ef, $ee, "of the stars.", $fa, $f7
    db $ef, $ee, "They're gifts from", $ef, $ee, "the spirit.", $f7
    db $f0

Message_0D_22::
    db $ea, "*: Out at the", $f1
    db "western castle,", $fa, $f7
    db $ef, $ee, "I heard that no", $ef, $ee, "one managed to", $fa, $f7
    db $ef, $ee, "cheer up Lady Yuna", $ef, $ee, "in the end.", $fa, $f7
    db $ef, $ee, "So, nobody got the", $ef, $ee, "reward.", $f7
    db $f0

Message_0D_23::
    db $ea, "*: I just heard a", $f1
    db "rumor", $a4, $fa, $f7
    db $ef, $ee, "The girl's ghost", $ef, $ee, "seems to be gone.", $f7
    db $f0

Message_0D_24::
    db $ea, "*: Now that I think", $f1
    db "about it, I'm not", $fa, $f7
    db $ef, $ee, "sure what I saw", $ef, $ee, "was a ghost.", $fa, $f7
    db $ef, $ee, "I may have been", $ef, $ee, "mistaken, even.", $fa, $f7
    db $ef, $ee, "In fact, I'm sure", $ef, $ee, "I was wrong!", $f7
    db $f0

Message_0D_25::
    db $ea, "*: ArmyAnt's help", $f1
    db "means I can open", $fa, $f7
    db $ef, $ee, "my shop just as I", $ef, $ee, "had planned.", $f7
    db $f0

Message_0D_26::
    db $ea, "*: Hup, hup, hup!", $f1
    db "Heh, this stuff is", $fa, $f7
    db $ef, $ee, "nothing to move", $ef, $ee, "around!", $f7
    db $f0

Message_0D_27::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "The Crest was", $ef, $ee, "found.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it", $a4, $f7
    db $f0

Message_0D_28::
    db $f9, "0 obtained the", $f1
    db "Sky Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_0D_29::
    db $ea, "King: Kameha made", $f1
    db "off with the Key's", $fa, $f7
    db $ef, $ee, "duplicate from the", $ef, $ee, "Castle.", $fa, $f7
    db $ef, $ee, "I can imagine him", $ef, $ee, "being a nuisance,", $fa, $f7
    db $ef, $ee, "but I'm counting", $ef, $ee, "on your support.", $f7
    db $f0

Message_0D_2A::
    db $ea, "Warubou: Wa-hey,", $f1
    db "find another Magic", $fa, $f7
    db $ef, $ee, "Key in GreatLog", $ef, $ee, "and you go off to", $fa, $f7
    db $ef, $ee, "another world,", $ef, $ee, "warooh.", $fa, $f7
    db $ef, $ee, "The Sky Key, I", $ef, $ee, "think it is.", $f7
    db $f0

Message_0D_2B::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0!", $fa, $f7
    db $ef, $ee, "You have the Sky", $ef, $ee, "Key, warooh.", $fa, $f7
    db $ef, $ee, "Kameha took off", $ef, $ee, "before you again.", $fa, $f7
    db $ef, $ee, "I'm beginning to", $ef, $ee, "suffer from this", $a4, $fa, $f7
    db $ef, $ee, "This time, you'll", $ef, $ee, "find a plug, yes?", $fa, $f7
    db $ef, $ee, "Oh, and now, you", $ef, $ee, "have the ability", $fa, $f7
    db $ef, $ee, "to summon a cloud", $ef, $ee, "and fly.", $fa, $f7
    db $ef, $ee, "Sky Shield gave", $ef, $ee, "you that ability.", $fa, $f7
    db $ef, $ee, "Keep that in mind,", $ef, $ee, "warooh!", $f7
    db $f0

Message_0D_2C::
    db $ea, "*: That giant bird", $f1
    db "hasn't flown over", $fa, $f7
    db $ef, $ee, "for a while.", $ef, $ee, $f7
    db $f0

Message_0D_2D::
    db $ea, "*: Was that bird", $f1
    db "going after the", $fa, $f7
    db $ef, $ee, "LightOrb?", $ef, $ee, $f7
    db $f0

Message_0D_2E::
    db $ea, "*: They say the", $f1
    db "giant bird has", $fa, $f7
    db $ef, $ee, "disappeared.", $ef, $ee, "I wonder if it's", $fa, $f7
    db $ef, $ee, "safe for me to go", $ef, $ee, "outside now", $a4, $f7
    db $f0

Message_0D_2F::
    db $ea, "*: The giant bird", $f1
    db "took off with a", $fa, $f7
    db $ef, $ee, "human child", $a4, $ef, $ee, "Is he safe now?", $f7
    db $f0

Message_0D_30::
    db $ea, "*: What if the", $f1
    db "island sinks, and", $fa, $f7
    db $ef, $ee, "you return from", $ef, $ee, "another world?", $fa, $f7
    db $ef, $ee, "Would you suddenly", $ef, $ee, "appear underwater?", $f7
    db $f0

Message_0D_31::
    db $ea, "*: For the sake of", $f1
    db "my grandchild, it", $fa, $f7
    db $ef, $ee, "may be best that", $ef, $ee, "we leave.", $fa, $f7
    db $ef, $ee, "She may make", $ef, $ee, "friends elsewhere.", $f7
    db $f0

Message_0D_32::
    db $eb, "*: Do we have to", $f1
    db "leave GreatLog?", $fa, $f7
    db $ef, $ee, "It doesn't matter,", $ef, $ee, "though.", $fa, $f7
    db $ef, $ee, "There's nothing", $ef, $ee, "here for me.", $f7
    db $f0

Message_0D_33::
    db $ea, "*: You saved us all", $f1
    db "by yourself.", $fa, $f7
    db $ef, $ee, "Your future is so", $ef, $ee, "full of promise!", $f7
    db $f0

Message_0D_34::
    db $ea, "*: Please, eat up,", $f1
    db "eat up!", $fa, $f7
    db $ef, $ee, "Don't worry about", $ef, $ee, "your manners!", $f7
    db $f0

Message_0D_35::
    db $ea, "*: Hm? I saw your", $f1
    db "family.", $fa, $f7
    db $ef, $ee, "They were up on", $ef, $ee, "the treetop.", $f7
    db $f0

Message_0D_36::
    db $ea, "*: The Kingdom is", $f1
    db "rejoicing!", $f7
    db $f0

Message_0D_37::
    db $ea, "*: Instead of", $f1
    db "standing around,", $fa, $f7
    db $ef, $ee, "you should go and", $ef, $ee, "enjoy yourselves.", $f7
    db $f0

Message_0D_38::
    db $ea, "*: Just imagine if", $f1
    db "you weren't here.", $fa, $f7
    db $ef, $ee, "That's a sobering", $ef, $ee, "thought.", $f7
    db $f0

Message_0D_39::
    db $ea, "*: Ah, GreatLog's", $f1
    db "mighty hero!", $fa, $f7
    db $ef, $ee, "I hope you're", $ef, $ee, "enjoying this!", $f7
    db $f0

Message_0D_3A::
    db $ea, "*: To be honest, I", $f1
    db "was getting ready", $fa, $f7
    db $ef, $ee, "to clear out.", $ef, $ee, "You saved us!", $f7
    db $f0

Message_0D_3B::
    db $ea, "*: Whinny!", $f7
    db $f0

Message_0D_3C::
    db $eb, "*: ", $a4, $a4, $a4, $a4, "!", $f7
    db $f0

Message_0D_3D::
    db $ea, "*: They say Lady", $f1
    db "Yuna is back to", $fa, $f7
    db $ef, $ee, "her usual cheerful", $ef, $ee, "self.", $fa, $f7
    db $ef, $ee, "Perhaps she's still", $ef, $ee, "too young to mope", $fa, $f7
    db $ef, $ee, "over matters of", $ef, $ee, "the heart", $a4, $f7
    db $f0

Message_0D_3E::
    db $ea, "*: Huh? There is", $f1
    db "something here.", $fa, $f7
    db $ef, $ee, "Under the", $ef, $ee, "merchandise.", $f7
    db $f0

Message_0D_3F::
    db $ea, "*: What's that?", $f1
    db "Hey, a TinyMedal!", $fa, $f7
    db $ef, $ee, "That took good,", $ef, $ee, "compound eyes to", $fa, $f7
    db $ef, $ee, "spot on the ground", $ef, $ee, "like that!", $f7
    db $f0

Message_0D_40::
    db $ea, "*: I", $44, " like you to", $f1
    db "have this.", $fa, $f7
    db $ef, $ee, "Sort of a thanks", $ef, $ee, "for ArmyAnt.", $f7
    db $f0

Message_0D_41::
    db $f9, "0 received a", $f1
    db "TinyMedal!", $f7
    db $f0

Message_0D_42::
    db $ea, "*: I'll pray for", $f1
    db "your safety.", $fa, $f7
    db $ef, $ee, "Take good care of", $ef, $ee, "yourself.", $f7
    db $f0

Message_0D_43::
    db $ea, "*: I", $44, " like you to", $f1
    db "have this.", $fa, $f7
    db $ef, $ee, "Sort of a thanks", $ef, $ee, "for ArmyAnt.", $fa, $f7
    db $ef, $ee, "Oh, wait. There's", $ef, $ee, "no room for this.", $fa, $f7
    db $ef, $ee, "I'll leave it with", $ef, $ee, "my ArmyAnt, so be", $fa, $f7
    db $ef, $ee, "sure to come get", $ef, $ee, "it later.", $f7
    db $f0

Message_0D_44::
    db $ea, "*: Here it is-the", $f1
    db "TinyMedal.", $fa, $f7
    db $ef, $ee, "My master had me", $ef, $ee, "hold it for you.", $f7
    db $f0

Message_0D_45::
    db $ea, "*: Here it is-the", $f1
    db "TinyMedal.", $fa, $f7
    db $ef, $ee, "My master had me", $ef, $ee, "hold it for you.", $fa, $f7
    db $ef, $ee, $a4, "You still don't", $ef, $ee, "have room for it", $a4, $f7
    db $f0

Message_0D_46::
    db $ea, "*: What's wrong,", $f1
    db "MadGopher?", $fa, $f7
    db $ef, $ee, "Did you dig", $ef, $ee, "something up?", $fa, $f7
    db $ef, $ee, "Oh, hey!", $ef, $ee, "That's a TinyMedal!", $fa, $f7
    db $ef, $ee, "Good going,", $ef, $ee, "MadGopher!", $f7
    db $f0

Message_0D_47::
    db $ea, "*: Here, ", $f9, "0!", $f1
    db "You hold onto it.", $f7
    db $f0

Message_0D_48::
    db $ea, "*: Here, ", $f9, "0!", $f1
    db "You hold onto it.", $fa, $f7
    db $ef, $ee, "Oh, but look, you", $ef, $ee, "have no room.", $fa, $f7
    db $ef, $ee, "MadGopher will", $ef, $ee, "hold it for you.", $f7
    db $f0

Message_0D_49::
    db $ea, "*: Here's that", $f1
    db "TinyMedal.", $f7
    db $f0

Message_0D_4A::
    db $ea, "*: Here's that", $f1
    db "TinyMedal.", $fa, $f7
    db $ef, $ee, $a4, "Wait, you still", $ef, $ee, "have no room.", $f7
    db $f0

Message_0D_4B::
    db $ea, "*: What's that?", $f1
    db "Hey, a Magic Key!", $fa, $f7
    db $ef, $ee, "How did you manage", $ef, $ee, "to find that?", $f7
    db $f0

Message_0D_4C::
    db $eb, "*: ", $a4, $a4, $a4, $a4, "?", $f1
    db "You startled me", $a4, $fa, $f7
    db $ef, $ee, "I don't remember", $ef, $ee, "who I am, what I'm", $fa, $f7
    db $ef, $ee, "doing here, or", $ef, $ee, "anything else", $a4, $fa, $f7
    db $ef, $ee, "I just know that I", $ef, $ee, "need help", $a4, $fa, $f7
    db $ef, $ee, "But you don't seem", $ef, $ee, "to know who I am", $a4, $f7
    db $f0

Message_0D_4D::
    db $eb, "*: I don't remember", $f1
    db "who I am, what I'm", $fa, $f7
    db $ef, $ee, "doing here, or", $ef, $ee, "anything else", $a4, $fa, $f7
    db $ef, $ee, "I just know that I", $ef, $ee, "need help", $a4, $fa, $f7
    db $ef, $ee, "But you don't seem", $ef, $ee, "to know who I am", $a4, $f7
    db $f0

Message_0D_4E::
    db $ea, "*: I'm digging here", $f1
    db "because I think", $fa, $f7
    db $ef, $ee, "this hole leads", $ef, $ee, "somewhere", $a4, $f7
    db $f0

Message_0D_4F::
    db "Pick the monster", $f1
    db "to go to the farm.", $f7
    db $f0

Message_0D_51::
    db $f9, "N joined", $f1
    db "the party.", $e5, $d6, $f7
    db $f0

Message_0D_52::
    db $f9, "N headed off", $f1
    db "to the farm.", $e5, $d6, $f7
    db $f0

Message_0D_53::
    db $ea, "*: ", $a4, "Wait, the farm", $f1
    db "is full", $a4, $f7
    db $f0

Message_0D_56::
    db $ea, "*: Let me join your", $f1
    db "party?", $ff, $f0

Message_0D_57::
    db $ea, "*: ", $a4, "The farm has no", $f1
    db "room left for me", $a4, $f7
    db $f0

Message_0D_58::
    db "What will you give", $f1
    db "to the Egg?", $f7
    db $f0

Message_0D_61::
    db $f9, "Y has been", $f1
    db "given to the Egg.", $fa, $f7
    db $ef, $ee, "What will you give", $ef, $ee, "it next?", $f7
    db $f0

Message_0D_62::
    db "The farm is full.", $f7
    db $f0

Message_0D_63::
    db "Lamia entered", $f1
    db "the farm.", $f7
    db $f0

Message_0D_64::
    db "Dimensaur entered", $f1
    db "the farm.", $f7
    db $f0

Message_0D_65::
    db "Kagebou entered", $f1
    db "the farm.", $f7
    db $f0

Message_0D_66::
    db $f9, "0 cataloged", $f1
    db "100 monsters.", $f7
    db $f0

Message_0D_67::
    db $f9, "0 cataloged", $f1
    db "200 monsters.", $f7
    db $f0

Message_0D_68::
    db $f9, "0 cataloged", $f1
    db "all the monsters.", $f7
    db $f0

Message_0D_69::
    db $eb, "*: Really? Let's go", $f1
    db "to the Arena!", $f7
    db $f0

Message_0D_81::
    db $eb, "*: Aww", $a4, " How boring", $a4, $f1
    db "Visit us again!", $f7
    db $f0

Message_0D_82::
    db $eb, "*: Aww", $a4, " I lose.", $f1
    db "You are good!", $fa, $f7
    db $ef, $ee, "I wasn't trying", $ef, $ee, "very hard", $a4, $fa, $f7
    db $ef, $ee, "Eheheh, actually,", $ef, $ee, "I did want to win.", $f7
    db $f0

Message_0D_83::
    db $eb, "*: Yay! I won!", $f1
    db "Am I awesome?", $f7
    db $f0

Message_0D_84::
    db $ea, "*: Some monsters", $f1
    db "may be tough, but", $fa, $f7
    db $ef, $ee, "they could have", $ef, $ee, "surprising weak", $fa, $f7
    db $ef, $ee, "spots that can be", $ef, $ee, "exploited.", $fa, $f7
    db $ef, $ee, "Skills and dances", $ef, $ee, "that cause status", $fa, $f7
    db $ef, $ee, "problems can come", $ef, $ee, "in very handy.", $f7
    db $f0

Message_0D_85::
    db $ea, "*: A master who can", $f1
    db "satisfy me", $a4, $fa, $f7
    db $ef, $ee, "Does such a", $ef, $ee, "battler exist?", $f7
    db $f0

Message_0D_86::
    db $eb, "*: Welcome! Do you", $f1
    db "wish to battle?", $f0

Message_0D_87::
    db $ea, "*: GreatLog is a", $f1
    db "floating island?", $fa, $f7
    db $ef, $ee, "If I dig any more,", $ef, $ee, "the bottom'll go.", $f7
    db $f0

Message_0D_88::
    db $ea, "*: I teased you as", $f1
    db "a cute rival", $a4, $fa, $f7
    db $ef, $ee, "But you've gone", $ef, $ee, "far beyond me.", $f7
    db $f0

Message_0D_89::
    db $ea, "*: Well, well!", $f1
    db "If it isn't the", $fa, $f7
    db $ef, $ee, "little hero who", $ef, $ee, "saved GreatLog?", $fa, $f7
    db $ef, $ee, "Make yourself at", $ef, $ee, "home and shop!", $fa, $f7
    db $ef, $ee, "What can I do for", $ef, $ee, "you today?", $f7
    db $f0

Message_0D_8A::
    db $ea, "*: My ArmyAnt,", $f1
    db "which I got from a", $fa, $f7
    db $ef, $ee, "monster master,", $ef, $ee, "made it possible", $fa, $f7
    db $ef, $ee, "for me to open", $ef, $ee, "this shop.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you today?", $f7
    db $f0

Message_0D_8B::
    db $ea, "*: You might know", $f1
    db "this already, but", $fa, $f7
    db $ef, $ee, "this is a good", $ef, $ee, "breeding pair,", $fa, $f7
    db $ef, $ee, "LizardMan and", $ef, $ee, "WingSlime.", $fa, $f7
    db $ef, $ee, "That will make you", $ef, $ee, "a Rayburn.", $f7
    db $f0

Message_0D_8C::
    db $ea, "*: Wata, wata.", $f1
    db "Terry battled in", $fa, $f7
    db $ef, $ee, "the Starry Night", $ef, $ee, "Tournament as", $fa, $f7
    db $ef, $ee, "GreatTree's master,", $ef, $ee, "wataah.", $f7
    db $f0

Message_0D_8D::
    db $ea, "*: Fwahahahaha!", $f1
    db "How amusing!", $fa, $f7
    db $ef, $ee, "Even I fell before", $ef, $ee, "Terry's might!", $fa, $f7
    db $ef, $ee, "How you fare shall", $ef, $ee, "be intriguing.", $f7
    db $f0

Message_0D_8E::
    db $ea, "*: I", $44, " heard of a", $f1
    db "little hero", $a4, $fa, $f7
    db $ef, $ee, "But, it seems to", $ef, $ee, "be a bogus lead.", $fa, $f7
    db $ef, $ee, "I'll continue with", $ef, $ee, "my travels", $a4, $f7
    db $f0

Message_0D_8F::
    db $eb, "*: What a scruffy", $f1
    db "lot of masters", $a4, $fa, $f7
    db $ef, $ee, "I shouldn't believe", $ef, $ee, "vague rumors", $a4, $f7
    db $f0

Message_0D_90::
    db $ea, "*: Humph", $a4, $f1
    db "I'm Terry.", $fa, $f7
    db $ef, $ee, "Terry: I'm a master", $ef, $ee, "from GreatTree.", $fa, $f7
    db $ef, $ee, "I", $44, " heard about", $ef, $ee, "GreatLog's heroic", $fa, $f7
    db $ef, $ee, "master, so I came", $ef, $ee, "to look.", $fa, $f7
    db $ef, $ee, "But you can't be", $ef, $ee, "that master, you", $fa, $f7
    db $ef, $ee, "don't have a full", $ef, $ee, "party.", $f7
    db $f0

Message_0D_91::
    db $eb, "*: ", $f9, "0, you were", $f1
    db "so busy saving", $fa, $f7
    db $ef, $ee, "GreatLog that you", $ef, $ee, "forgot all about", $fa, $f7
    db $ef, $ee, "my errand, didn't", $ef, $ee, "you?", $fa, $f7
    db $ef, $ee, "I went and got the", $ef, $ee, "LoveWater myself.", $f7
    db $f0

Message_0D_92::
    db $ea, "Kameha: I think I", $f1
    db "have the natural", $fa, $f7
    db $ef, $ee, "talent to be a", $ef, $ee, "master.", $fa, $f7
    db $ef, $ee, $a4, "Don't give me", $ef, $ee, "that look!", $fa, $f7
    db $ef, $ee, "You don't believe", $ef, $ee, "me at all.", $fa, $f7
    db $ef, $ee, "Just you watch,", $ef, $ee, $f9, "0.", $fa, $f7
    db $ef, $ee, "I'll surpass you", $ef, $ee, "in no time!", $f7
    db $f0

Message_0D_93::
    db $ea, "*: We've had reports", $f1
    db "of rogue masters", $fa, $f7
    db $ef, $ee, "who terrorize", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "We're investigating", $ef, $ee, "these reports, but", $fa, $f7
    db $ef, $ee, "it's serious if", $ef, $ee, "they're true!", $f7
    db $f0

Message_0D_94::
    db $ea, "*: Ah, bless you!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "As GreatLog's hero,", $f1
    db "you set a shining", $fa, $f7
    db $ef, $ee, "example to other", $ef, $ee, "masters.", $fa, $f7
    db $ef, $ee, "Thanks to you, our", $ef, $ee, "Kingdom's honor", $fa, $f7
    db $ef, $ee, "has been kept", $ef, $ee, "untarnished!", $f7
    db $f0

Message_0D_95::
    db $ea, "Warubou: Wa-hey", $a4, $f1
    db "That's cold of you.", $fa, $f7
    db $ef, $ee, "After all we've", $ef, $ee, "been through", $a4, $fa, $f7
    db $ef, $ee, "Yet you refuse me,", $ef, $ee, "warooh?", $f7
    db $f0

Message_0D_96::
    db $ea, "*: Our church is", $f1
    db "impoverished, so", $fa, $f7
    db $ef, $ee, "I was sent out to", $ef, $ee, "this village.", $fa, $f7
    db $ef, $ee, "I can heal you of", $ef, $ee, "poison, nullify", $fa, $f7
    db $ef, $ee, "curses, and raise", $ef, $ee, "those knocked out.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you?", $f7
    db $f0

Message_0D_A1::
    db $ea, "*: Our church is", $f1
    db "impoverished, so", $fa, $f7
    db $ef, $ee, "I was sent out to", $ef, $ee, "this village.", $fa, $f7
    db $ef, $ee, "The slow pace of", $ef, $ee, "life here makes", $fa, $f7
    db $ef, $ee, "one lose sight of", $ef, $ee, "the flowing time.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you?", $f7
    db $f0

Message_0D_A2::
    db $ea, "Warubou: Wa-hey!", $f1
    db "I was the plug in", $fa, $f7
    db $ef, $ee, "the Log's Navel for", $ef, $ee, "a long time!", $fa, $f7
    db $ef, $ee, "The pie is my", $ef, $ee, "reward, warooh!", $fa, $f7
    db $ef, $ee, "I get to eat lots", $ef, $ee, "of it!", $f7
    db $f0

Message_0D_B1::
    db $ea, "Kameha: I went and", $f1
    db "faced danger in", $fa, $f7
    db $ef, $ee, "other worlds for", $ef, $ee, "GreatLog's sake!", $fa, $f7
    db $ef, $ee, "All you did was", $ef, $ee, "loaf around here!", $f7
    db $f0

Message_0D_B2::
    db $ea, "Warubou: WA-HEY!", $f1
    db "Some Prince!", $fa, $f7
    db $ef, $ee, "Always a dirty", $ef, $ee, "mouth, warooh!", $f7
    db $f0

Message_0D_B3::
    db $ea, "Kameha: You're a", $f1
    db "glutton!", $fa, $f7
    db $ef, $ee, "You haven't changed", $ef, $ee, "at all, glutton!", $f7
    db $f0

Message_0D_B4::
    db $ea, "Cobi: Pot-kettle-", $f1
    db "black, you two.", $fa, $f7
    db $ef, $ee, "You both need to", $ef, $ee, "smarten up.", $f7
    db $f0

Message_0D_B5::
    db $eb, "Tara: You two went", $f1
    db "through all that,", $fa, $f7
    db $ef, $ee, "but you haven't", $ef, $ee, "wised up at all?", $f7
    db $f0

Message_0D_B6::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Now look, warooh!", $fa, $f7
    db $ef, $ee, "It's your fault", $ef, $ee, "they find us!", $f7
    db $f0

Message_0D_B7::
    db $ea, "Kameha: No one's", $f1
    db "taking this pie", $fa, $f7
    db $ef, $ee, "away from me!", $ef, $ee, $f7
    db $f0

Message_0D_B8::
    db $ea, "Warubou: Wa-hey", $a4, $f1
    db "I have seen this", $a4, $f7
    db $f0

Message_0D_B9::
    db $ea, "Cobi: That's enough", $f1
    db "already.", $f7
    db $f0

Message_0D_BA::
    db $eb, "What if you break", $ef, $ee, "the plug again?", $f7
    db $f0

Message_0D_BB::
    db $ea, "Warubou: Wa-hey,", $f1
    db "the ability to", $fa, $f7
    db $ef, $ee, "cross the sea is", $ef, $ee, "in you, warooh!", $fa, $f7
    db $ef, $ee, "Talk to the sea,", $ef, $ee, "and it will reply.", $fa, $f7
    db $ef, $ee, "Wa-hey? I felt an", $ef, $ee, "odd power!", $fa, $f7
    db $ef, $ee, "It's the sea!", $ef, $ee, "It's calling!", $fa, $f7
    db $ef, $ee, "A dilapidated", $ef, $ee, "pirate ship is", $fa, $f7
    db $ef, $ee, "what I see on the", $ef, $ee, "sea, warooh.", $fa, $f7
    db $ef, $ee, "But this time, you", $ef, $ee, "must find the key.", $fa, $f7
    db $ef, $ee, "It's right here in", $ef, $ee, "GreatLog, I think.", $fa, $f7
    db $ef, $ee, "The Pirate Key is", $ef, $ee, "what you want.", $f7
    db $f0

Message_0D_C1::
    db $ea, "Warubou: Wa-hey,", $f1
    db "you can now crush", $fa, $f7
    db $ef, $ee, "huge boulders,", $ef, $ee, "warooh!", $fa, $f7
    db $ef, $ee, "You try in front", $ef, $ee, "of a boulder or a", $fa, $f7
    db $ef, $ee, "tree that's in the", $ef, $ee, "way. Anyway", $a4, $fa, $f7
    db $ef, $ee, $f9, "0, you will go", $ef, $ee, "look again?", $fa, $f7
    db $ef, $ee, "Wa-hey? I felt an", $ef, $ee, "odd power!", $fa, $f7
    db $ef, $ee, "It's cold!", $ef, $ee, "It's in ice!", $fa, $f7
    db $ef, $ee, "You know what I'm", $ef, $ee, "going to say", $a4, $fa, $f7
    db $ef, $ee, "I don't have the", $ef, $ee, "key, warooh.", $fa, $f7
    db $ef, $ee, "The Ice Key is", $ef, $ee, "what you want.", $f7
    db $f0

Message_0D_C2::
    db $ea, "*: It's exciting to", $f1
    db "think where an", $fa, $f7
    db $ef, $ee, "appraised Magic", $ef, $ee, "Key will take you.", $f7
    db $f0

Message_0D_C3::
    db $ea, "*: The shoals that", $f1
    db "ringed the volcano", $fa, $f7
    db $ef, $ee, "have suddenly", $ef, $ee, "disappeared.", $fa, $f7
    db $ef, $ee, "The sea can be so", $ef, $ee, "mysterious.", $f7
    db $f0

Message_0D_C4::
    db $ea, "*: What is it?", $f1
    db "Ah, it's you.", $fa, $f7
    db $ef, $ee, "What's that?", $ef, $ee, "The MoonRock?", $fa, $f7
    db $ef, $ee, "Ah, the mermaids", $ef, $ee, "helped you!", $f7
    db $f0

Message_0D_C5::
    db $eb, "*: Welcome, my", $f1
    db "young hero!", $fa, $f7
    db $ef, $ee, "No words could", $ef, $ee, "ever do justice", $fa, $f7
    db $ef, $ee, "for the gratitude", $ef, $ee, "I feel for you.", $fa, $f7
    db $ef, $ee, "Instead, take this", $ef, $ee, "ring.", $fa, $f7
    db $ef, $ee, "I found it inside", $ef, $ee, "a sunken ship.", $fa, $f7
    db $ef, $ee, "It is best that it", $ef, $ee, "be returned to a", $fa, $f7
    db $ef, $ee, "human, namely you.", $ef, $ee, $f7
    db $f0

Message_0D_C6::
    db $f9, "0 received the", $f1
    db "Sailor Ring.", $f7
    db $f0

Message_0D_C7::
    db $eb, "*: Welcome, my", $f1
    db "young hero!", $fa, $f7
    db $ef, $ee, "No words could", $ef, $ee, "ever do justice", $fa, $f7
    db $ef, $ee, "for the gratitude", $ef, $ee, "I feel for you.", $fa, $f7
    db $ef, $ee, "Instead, take this", $ef, $ee, "ring.", $fa, $f7
    db $ef, $ee, "Ah, but you have", $ef, $ee, "no room for it.", $fa, $f7
    db $ef, $ee, "I'll keep it till", $ef, $ee, "you make room.", $f7
    db $f0

Message_0D_C8::
    db $ea, "*: Lady Yuna has", $f1
    db "always been highly", $fa, $f7
    db $ef, $ee, "energetic and", $ef, $ee, "rambunctious.", $fa, $f7
    db $ef, $ee, "We had a dickens", $ef, $ee, "of a time because", $fa, $f7
    db $ef, $ee, "she would always", $ef, $ee, "sneak off.", $f7
    db $f0

Message_0D_C9::
    db $ea, "*: How can we save", $f1
    db "Queen Helen?", $fa, $f7
    db $ef, $ee, "According to some", $ef, $ee, "medical books,", $fa, $f7
    db $ef, $ee, "there is something", $ef, $ee, "called SleepHerb.", $fa, $f7
    db $ef, $ee, "The scholar may", $ef, $ee, "know, but he has", $fa, $f7
    db $ef, $ee, "gone on a study", $ef, $ee, "trip to Nofor.", $f7
    db $f0

Message_0D_CA::
    db $eb, "*: Let me show you", $f1
    db "my resurrected", $fa, $f7
    db $ef, $ee, "powers", $a4, $ef, $ee, $f7
    db $f0

Message_0D_CB::
    db $ea, "Warubou: Wa-hey,", $f1
    db "you can now fly", $fa, $f7
    db $ef, $ee, "across the sky on", $ef, $ee, "a cloud, warooh!", $fa, $f7
    db $ef, $ee, "You try at the", $ef, $ee, "edge of land and", $fa, $f7
    db $ef, $ee, "the open sky.", $ef, $ee, "Anyway", $a4, $fa, $f7
    db $ef, $ee, $f9, "0, you will go", $ef, $ee, "look again?", $fa, $f7
    db $ef, $ee, "Wa-hey? I felt an", $ef, $ee, "odd power!", $fa, $f7
    db $ef, $ee, "I see it! A land", $ef, $ee, "floating way up", $fa, $f7
    db $ef, $ee, "high in the sky,", $ef, $ee, "warooh!", $fa, $f7
    db $ef, $ee, "The Sky Key is", $ef, $ee, "what you want.", $f7
    db $f0

Message_0D_CC::
    db $ea, "*: YOUR LIFE ENDS", $f1
    db "HERE! GIVE IT UP!", $f7
    db $f0

Message_0D_CD::
    db $ea, "*: KAHAHAHA!", $f1
    db "THEN LEAVE!", $f7
    db $f0

Message_0D_CE::
    db $ea, "*: I see", $a4, " But I", $f1
    db "will crush you!", $f7
    db $f0

Message_0D_CF::
    db $ea, "*: I see", $a4, " Then", $f1
    db "leave at once.", $f7
    db $f0

Message_0D_D0::
    db $ea, "*: Impetuous fool!", $f1
    db "I'll show you!", $fa, $f7
    db $ef, $ee, "Come hither, my", $ef, $ee, "servants!", $f7
    db $f0

Message_0D_D1::
    db $ea, "*: Hm, fine, I'll", $f1
    db "ignore it.", $fa, $f7
    db $ef, $ee, "But just this", $ef, $ee, "time!", $f7
    db $f0

Message_0D_D2::
    db "The princess did", $f1
    db "not reply.", $fa, $f7
    db $ef, $ee, "But a malevolent", $ef, $ee, "voice spoke up", $a4, $f7
    db $f0

Message_0D_D3::
    db "'Inn downstairs.", $f1
    db "Rooms available.", $95, $f7
    db $f0

Message_0D_D4::
    db $ea, "*: If you breed,", $f1
    db "the parents go", $fa, $f7
    db $ef, $ee, "away somewhere,", $ef, $ee, "and their baby", $fa, $f7
    db $ef, $ee, "hatches at just", $ef, $ee, "level 1.", $fa, $f7
    db $ef, $ee, "But the baby will", $ef, $ee, "grow to surpass", $fa, $f7
    db $ef, $ee, "its parents if you", $ef, $ee, "raise it.", $f7
    db $f0

Message_0D_D5::
    db $eb, "*: Monster skills", $f1
    db "are passed on from", $fa, $f7
    db $ef, $ee, "parents to their", $ef, $ee, "offspring.", $fa, $f7
    db $ef, $ee, "Retain the skills", $ef, $ee, "you like on your", $fa, $f7
    db $ef, $ee, "monsters, and keep", $ef, $ee, "breeding them.", $fa, $f7
    db $ef, $ee, "Eventually, you'll", $ef, $ee, "have monsters that", $fa, $f7
    db $ef, $ee, "possess the moves", $ef, $ee, "you like best.", $f7
    db $f0

Message_0D_D6::
    db $ea, "*: Nightmares so", $f1
    db "horrible that they", $fa, $f7
    db $ef, $ee, "keep Queen Helen", $ef, $ee, "from sleeping", $a4, $fa, $f7
    db $ef, $ee, "What is happening", $ef, $ee, "to the kingdom?", $f7
    db $f0

Message_0D_D7::
    db $ea, "*: Our hearts are", $f1
    db "like the skies", $fa, $f7
    db $ef, $ee, "above-heavy and", $ef, $ee, "clouded", $a4, $fa, $f7
    db $ef, $ee, "We're all starved", $ef, $ee, "for cheerful news.", $f7
    db $f0

Message_0D_D8::
    db $eb, "*: Queen Helen is", $f1
    db "wracked by awful", $fa, $f7
    db $ef, $ee, "nightmares night", $ef, $ee, "after night", $a4, $fa, $f7
    db $ef, $ee, "She's managed only", $ef, $ee, "snatches of sleep", $a4, $fa, $f7
    db $ef, $ee, "It's left her in a", $ef, $ee, "cranky mood", $a4, $f7
    db $f0

Message_0D_D9::
    db $ea, "*: The reception", $f1
    db "hall is beyond", $fa, $f7
    db $ef, $ee, "here. Our Queen is", $ef, $ee, "waiting for you.", $f7
    db $f0

Message_0D_DA::
    db $ea, "*: Our Queen Helen's", $f1
    db "premonition made", $fa, $f7
    db $ef, $ee, "it possible for us", $ef, $ee, "to overcome the", $fa, $f7
    db $ef, $ee, "terrible cold", $ef, $ee, "spell for now", $a4, $fa, $f7
    db $ef, $ee, "But if the cold", $ef, $ee, "weather persists,", $fa, $f7
    db $ef, $ee, "who knows what", $ef, $ee, "will happen?", $f7
    db $f0

Message_0D_DB::
    db $eb, "*: What is it?", $f1
    db "Leave at once!", $fa, $f7
    db $ef, $ee, "This is no place", $ef, $ee, "for a child!", $fa, $f7
    db $ef, $ee, "What? Lady Yuna of", $ef, $ee, "the west?", $fa, $f7
    db $ef, $ee, "She's behaving in", $ef, $ee, "a peculiar manner?", $fa, $f7
    db $ef, $ee, "What rot!", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "That is of no", $ef, $ee, "concern to me!", $f7
    db $f0

Message_0D_DC::
    db $ea, "*: This happened", $f1
    db "when I was deep in", $fa, $f7
    db $ef, $ee, "the forest far to", $ef, $ee, "the west.", $fa, $f7
    db $ef, $ee, "A young girl just", $ef, $ee, "appeared and she", $fa, $f7
    db $ef, $ee, "sort of glided", $ef, $ee, "over to me without", $fa, $f7
    db $ef, $ee, "moving her feet", $ef, $ee, "one bit.", $fa, $f7
    db $ef, $ee, "I turned and ran,", $ef, $ee, "but she followed!", $f7
    db $f0

Message_0D_DD::
    db $eb, "*: My father is so", $f1
    db "cowardly, getting", $fa, $f7
    db $ef, $ee, "all spooked by a", $ef, $ee, "ghost.", $fa, $f7
    db $ef, $ee, "Your monsters", $ef, $ee, "frighten me more.", $f7
    db $f0
    ds $8c, $00
