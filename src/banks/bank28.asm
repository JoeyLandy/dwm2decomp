SECTION "Bank 28", ROMX[$4000], BANK[$28]
    db $28

; if wStringIndex < $DA, BeginStringDisplay with this bank's table; otherwise far-calls
; BeginStringDisplay_Bank28_BeginStringDisplay
BeginStringDisplay_Bank28::
    ld a, [wStringIndex]
    cp $da
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank28_BeginStringDisplay
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank28
    call BeginStringDisplay
    ret

; message bank $28: when wStringIndex < $DA, CopyStringToBuffer with this bank's table
; MessageStrings_Bank28; otherwise far-calls CopyStringToBuffer_Bank28_Overflow (E-0080)
CopyStringToBuffer_Bank28::
    ld a, [wStringIndex]
    cp $da
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank28_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank28
    call CopyStringToBuffer
    ret

; BeginStringDisplay_Bank28 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank28::
    call BeginStringDisplay_Bank28
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_28_4032::
MessageStrings_Bank28::
    dw StringList_28_4034 ; id 0

; category list of StringCategories_28_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_28_4034::
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

Message_00_00::
    db "In the middle of", $f1
    db "the sea in the", $fa, $f7
    db $ef, $ee, "south floats the", $ef, $ee, "island GreatLog.", $fa, $f7
    db $ef, $ee, "To this eternally", $ef, $ee, "warm and natural", $fa, $f7
    db $ef, $ee, "setting, a family", $ef, $ee, "of monster farmers", $fa, $f7
    db $ef, $ee, "was headed to", $ef, $ee, "start a new life", $a4, $f7
    db $f0

Message_00_01::
    db $ea, "Cobi: ", $f9, "0!", $f1
    db "Papa's calling.", $fa, $f7
    db $ef, $ee, "He's at the stern.", $ef, $ee, "Hustle, hustle!", $f7
    db $f0

Message_00_02::
    db $eb, "Tara: There you", $f1
    db "are, big brother!", $fa, $f7
    db $ef, $ee, "Papa's calling at", $ef, $ee, "the stern.", $fa, $f7
    db $ef, $ee, "You", $44, " better go", $ef, $ee, "right away!", $f7
    db $f0

Message_00_03::
    db $ea, "Cobi: What's wrong,", $f1
    db $f9, "0?", $fa, $f7
    db $ef, $ee, "Papa's calling for", $ef, $ee, "you!", $f7
    db $f0

Message_00_04::
    db $eb, "Tara: Hurry! Papa", $f1
    db "will be angry!", $f7
    db $f0

Message_00_05::
    db $ea, "*: You folks run a", $f1
    db "monster farm?", $fa, $f7
    db $ef, $ee, "We've never had", $ef, $ee, "monsters on our", $fa, $f7
    db $ef, $ee, "ship before this.", $ef, $ee, "It's amazing!", $f7
    db $f0

Message_00_06::
    db $ea, "*: There's a spirit", $f1
    db "in GreatLog that's", $fa, $f7
    db $ef, $ee, "famous for getting", $ef, $ee, "into mischief.", $fa, $f7
    db $ef, $ee, "It's named", $a4, $ef, $ee, "Waru something.", $f7
    db $f0

Message_00_07::
    db $ea, "*: Sailing is sure", $ef, $ee, "exhilarating. ", $fa, $f7
    db $ef, $ee, "Right?", $ef, $ee, $ff, $f0

Message_00_08::
    db $ea, "*: Good. That's", $f1
    db "good to hear!", $fa, $f7
    db $ef, $ee, "You have got", $ef, $ee, "potential!", $f7
    db $f0

Message_00_09::
    db $ea, "*: Is that so?", $f1
    db "Too bad!", $fa, $f7
    db $ef, $ee, "You'll get used to", $ef, $ee, "it someday.", $f7
    db $f0

Message_00_0A::
    db $eb, "*: We'll soon be", $f1
    db "reaching GreatLog.", $fa, $f7
    db $ef, $ee, "I wonder, what", $ef, $ee, "will it be like?", $fa, $f7
    db $ef, $ee, "Isn't it exciting", $ef, $ee, "my dear child?", $f7
    db $f0

Message_00_0B::
    db $ea, "*: GreatLog's King", $f1
    db "asked us to settle", $fa, $f7
    db $ef, $ee, "in the kingdom and", $ef, $ee, "run our farm.", $fa, $f7
    db $ef, $ee, "He recognizes our", $ef, $ee, "worth, wahahah!", $fa, $f7
    db $ef, $ee, "This will be our", $ef, $ee, "new life.", $fa, $f7
    db $ef, $ee, "You're a growing", $ef, $ee, "boy, so I'll need", $fa, $f7
    db $ef, $ee, "you to be reliable", $ef, $ee, "and responsible.", $fa, $f7
    db $ef, $ee, "Do we have an", $ef, $ee, "understanding?", $fa, $f7
    db $ef, $ee, "Good. Stay with", $ef, $ee, "Tara, will you?", $f7
    db $f0

Message_00_0C::
    db $ea, "*: GreatLog's King", $f1
    db "asked us to settle", $fa, $f7
    db $ef, $ee, "in the kingdom and", $ef, $ee, "run our farm.", $fa, $f7
    db $ef, $ee, "He recognizes our", $ef, $ee, "worth, wahahah!", $fa, $f7
    db $ef, $ee, "This will be our", $ef, $ee, "new life.", $fa, $f7
    db $ef, $ee, "You're growing up,", $ef, $ee, "so you can't be a", $fa, $f7
    db $ef, $ee, "little baby", $ef, $ee, "anymore.", $fa, $f7
    db $ef, $ee, "Do we have an", $ef, $ee, "understanding?", $fa, $f7
    db $ef, $ee, "Good. Play with", $ef, $ee, "Cobi, will you?", $f7
    db $f0

Message_00_0D::
    db $ea, "*: When our farm", $f1
    db "gets established", $fa, $f7
    db $ef, $ee, "in the new land,", $ef, $ee, "I'll make life", $fa, $f7
    db $ef, $ee, "easier for mother", $ef, $ee, "and you two.", $fa, $f7
    db $ef, $ee, "We should be in", $ef, $ee, "GreatLog soon.", $f7
    db $f0

Message_00_0E::
    db $eb, "*: Worried about", $f1
    db "your monsters?", $fa, $f7
    db $ef, $ee, "Don't be! They're", $ef, $ee, "being quiet.", $f7
    db $f0

Message_00_0F::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "clean water.", $f7
    db $f0

Message_00_10::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "Freshly caught", $ef, $ee, "fish were inside.", $f7
    db $f0

Message_00_11::
    db $ea, "Cobi: ", $f9, "0!", $f1
    db "They said GreatLog", $fa, $f7
    db $ef, $ee, "will be in sight", $ef, $ee, "soon.", $f7
    db $f0

Message_00_12::
    db $ea, "*: Land ho!", $f1
    db "There's GreatLog!", $f7
    db $f0

Message_00_13::
    db $eb, "Tara: Big brother!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "GreatLog will be", $ef, $ee, "in sight soon.", $f7
    db $f0

Message_00_14::
    db "This is a tale of", $f1
    db "children who came", $fa, $f7
    db $ef, $ee, "to the Kingdom of", $ef, $ee, "GreatLog", $a4, $f7
    db $f0

Message_00_15::
    db $ea, "*: Listen you two!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "Quit your horsing", $ef, $ee, "around and go", $fa, $f7
    db $ef, $ee, "help your mother.", $ef, $ee, "Do you hear me?", $f7
    db $f0

Message_00_16::
    db $ea, "*: It seems to me", $f1
    db "that the people", $fa, $f7
    db $ef, $ee, "here aren't very", $ef, $ee, "used to seeing", $fa, $f7
    db $ef, $ee, "monsters. We'll", $ef, $ee, "have to make sure", $fa, $f7
    db $ef, $ee, "that they don't go", $ef, $ee, "wander off on", $fa, $f7
    db $ef, $ee, "their own. Anyway,", $ef, $ee, "go help your", $fa, $f7
    db $ef, $ee, "mother.", $ef, $ee, $f7
    db $f0

Message_00_17::
    db $ea, "*: Yo, did you", $f1
    db "enjoy the voyage?", $fa, $f7
    db $ef, $ee, "The name's Slash,", $ef, $ee, "glad to know you!", $fa, $f7
    db $ef, $ee, "Slash: I guard the", $ef, $ee, "farm here.", $fa, $f7
    db $ef, $ee, "You can consider", $ef, $ee, "me the boss!", $fa, $f7
    db $ef, $ee, "If you need any", $ef, $ee, "advice, I'm here!", $f7
    db $f0

Message_00_18::
    db $ea, "Slash: If you're", $f1
    db "in need of advice,", $fa, $f7
    db $ef, $ee, "think of me!", $ef, $ee, "I'm the one!", $f7
    db $f0

Message_00_19::
    db $ea, "*: There aren't many", $f1
    db "friends here.", $fa, $f7
    db $ef, $ee, "It's lonely for an", $ef, $ee, "ant like me", $a4, $f7
    db $f0

Message_00_1A::
    db $ea, "*: I accidentally", $f1
    db "went outside.", $fa, $f7
    db $ef, $ee, "People gave me the", $ef, $ee, "eye. Whoopsy.", $f7
    db $f0

Message_00_1B::
    db $ea, "*: This hay is", $f1
    db "pretty good.", $fa, $f7
    db $ef, $ee, "Maybe I can use", $ef, $ee, "this", $a4, $f7
    db $f0

Message_00_1C::
    db $f9, "0 checked the", $f1
    db "pump.", $fa, $f7
    db $ef, $ee, "It's rusted and", $ef, $ee, "old, but it looks", $fa, $f7
    db $ef, $ee, "to be in working", $ef, $ee, "condition.", $f7
    db $f0

Message_00_1D::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It is full of", $ef, $ee, "dried hay.", $f7
    db $f0

Message_00_1E::
    db $eb, "*: You've come at", $f1
    db "the right time.", $fa, $f7
    db $ef, $ee, "Grandma sent her", $ef, $ee, "homemade nut pie", $fa, $f7
    db $ef, $ee, "for us to enjoy at", $ef, $ee, "our new homestead.", $fa, $f7
    db $ef, $ee, "I'm too busy to go", $ef, $ee, "get it right now,", $fa, $f7
    db $ef, $ee, "so can the two of", $ef, $ee, "you go instead?", $f7
    db $f0

Message_00_1F::
    db $ea, "Cobi: Sure, Mama!", $f1
    db "We'll be fine.", $f7
    db $f0

Message_00_20::
    db $eb, "*: Good, that's", $f1
    db "settled then.", $fa, $f7
    db $ef, $ee, "The Vault is west", $ef, $ee, "of the Farm.", $fa, $f7
    db $ef, $ee, "Don't dawdle, and", $ef, $ee, "be careful.", $f7
    db $f0

Message_00_21::
    db $eb, "Tara: We'll be OK!", $f1
    db "I'm going too.", $f7
    db $f0

Message_00_22::
    db $eb, "*: Go to the Vault", $f1
    db "and pick up the", $fa, $f7
    db $ef, $ee, "nut pie that", $ef, $ee, "Grandma sent.", $fa, $f7
    db $ef, $ee, "The Vault is west", $ef, $ee, "of the Farm.", $f7
    db $f0

Message_00_23::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Behavior of Wild", $ef, $ee, "Monsters", $a4, $fa, $f7
    db $ef, $ee, "Wild monsters are", $ef, $ee, "dangerous, but", $fa, $f7
    db $ef, $ee, "they can be tamed", $ef, $ee, "and trained.", $95, $f7
    db $f0

Message_00_24::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "Children's clothes", $ef, $ee, "were inside.", $f7
    db $f0

Message_00_25::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "It smelled of sun-", $ef, $ee, "dried laundry.", $f7
    db $f0

Message_00_26::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "It smelled of", $ef, $ee, "fresh bread.", $f7
    db $f0

Message_00_27::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was full of", $ef, $ee, "clear water.", $f7
    db $f0

Message_00_28::
    db $ea, "*: I've heard that", $f1
    db "there are monster", $fa, $f7
    db $ef, $ee, "masters in this", $ef, $ee, "kingdom.", $fa, $f7
    db $ef, $ee, "Have I told you", $ef, $ee, "about them?", $ff, $f0

Message_00_29::
    db $ea, "*: Oh? Well, that's", $f1
    db "fine then.", $fa, $f7
    db $ef, $ee, "Go on, run your", $ef, $ee, "mother's errand.", $f7
    db $f0

Message_00_2A::
    db $ea, "*: Monster masters", $f1
    db "are those people", $fa, $f7
    db $ef, $ee, "who tame and train", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "They commune with", $ef, $ee, "them and the", $fa, $f7
    db $ef, $ee, "monsters grow.", $ef, $ee, $f7
    db $f0

Message_00_2B::
    db $ea, "Cobi: Hahah! ", $f9, "0", $f1
    db "won't last a day!", $f7
    db $f0

Message_00_2C::
    db $ea, "*: I aspired to be", $f1
    db "one long ago", $a4, $fa, $f7
    db $ef, $ee, "Ahem! Go help your", $ef, $ee, "mother now.", $f7
    db $f0

Message_00_2D::
    db $eb, "Tara: Big brother", $f1
    db "can't do it then.", $f7
    db $f0

Message_00_2E::
    db $ea, "*: Go help your", $f1
    db "mother now.", $f7
    db $f0

Message_00_2F::
    db $ea, "*: If some monster", $f1
    db "masters keep their", $fa, $f7
    db $ef, $ee, "monsters with us,", $ef, $ee, "the Farm is sure", $fa, $f7
    db $ef, $ee, "to become busier", $ef, $ee, "and lively.", $f7
    db $f0

Message_00_30::
    db $ea, "*: Heh, so these", $f1
    db "are the newcomers?", $fa, $f7
    db $ef, $ee, "Hehehe, this is", $ef, $ee, "going to be fun", $a4, $f7
    db $f0

Message_00_31::
    db $ea, "*: C'mon, Warubou!", $f1
    db $f7
    db $f0

Message_00_32::
    db $ea, "*: Hello, there!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "You must be the", $ef, $ee, "farm kids!", $fa, $f7
    db $ef, $ee, "The Vault is west,", $ef, $ee, "then a bit north.", $f7
    db $f0

Message_00_33::
    db $eb, "*: Oh", $a4, " It's", $a4, " all", $f1
    db "spinning around", $a4, $fa, $f7
    db $ef, $ee, "That rotten little", $ef, $ee, "Prince and that", $fa, $f7
    db $ef, $ee, "elemental sidekick", $ef, $ee, "of his!", $f7
    db $f0

Message_00_34::
    db $eb, "*: The horrid", $f1
    db "Prince and that", $fa, $f7
    db $ef, $ee, "elemental sidekick", $ef, $ee, "of his!", $f7
    db $f0

Message_00_35::
    db $ea, "*: The King is too", $f1
    db "lenient on Prince", $fa, $f7
    db $ef, $ee, "Kameha, his only", $ef, $ee, "son.", $fa, $f7
    db $ef, $ee, "That's why we can't", $ef, $ee, "complain about all", $fa, $f7
    db $ef, $ee, "the trouble he", $ef, $ee, "causes.", $f7
    db $f0

Message_00_36::
    db $ea, "*: There were many", $f1
    db "wild monsters in", $fa, $f7
    db $ef, $ee, "this world in the", $ef, $ee, "past.", $fa, $f7
    db $ef, $ee, "The elemental", $ef, $ee, "spirits decided to", $fa, $f7
    db $ef, $ee, "send the monsters", $ef, $ee, "to other worlds", $fa, $f7
    db $ef, $ee, "until they were", $ef, $ee, "sure that humans", $fa, $f7
    db $ef, $ee, "could live safely", $ef, $ee, "with monsters.", $f7
    db $f0

Message_00_37::
    db $f9, "0 tried to", $f1
    db "open the chest.", $fa, $f7
    db $ef, $ee, "But the chest was", $ef, $ee, "locked tight.", $f7
    db $f0

Message_00_38::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "A large, salted", $ef, $ee, "fish was inside.", $f7
    db $f0

Message_00_39::
    db $ea, "*: Hey! You brats!", $f1
    db "Scram!", $fa, $f7
    db $ef, $ee, "Hands off my", $ef, $ee, "merchandise!", $f7
    db $f0

Message_00_3A::
    db $ea, "*: That weird ape", $f1
    db "thing is Warubou,", $fa, $f7
    db $ef, $ee, "GreatLog's", $ef, $ee, "elemental spirit.", $fa, $f7
    db $ef, $ee, "It's always up to", $ef, $ee, "mischief with", $fa, $f7
    db $ef, $ee, "Prince Kameha.", $ef, $ee, "What a pair!", $f7
    db $f0

Message_00_3B::
    db $eb, "*: This palm tree", $f1
    db "is GreatLog.", $fa, $f7
    db $ef, $ee, "We've bored out", $ef, $ee, "the inside of this", $fa, $f7
    db $ef, $ee, "enormous tree and", $ef, $ee, "made it our home.", $f7
    db $f0

Message_00_3C::
    db $ea, "*: You're the kids", $f1
    db "from the new farm.", $fa, $f7
    db $ef, $ee, "I'm a monster", $ef, $ee, "master myself.", $fa, $f7
    db $ef, $ee, "I'll have to use", $ef, $ee, "your farm soon.", $f7
    db $f0

Message_00_3D::
    db $eb, "*: We live inside", $f1
    db "here.", $fa, $f7
    db $ef, $ee, "I'm keeping my eyes", $ef, $ee, "out for Prince", $fa, $f7
    db $ef, $ee, "Kameha and his", $ef, $ee, "sidekick.", $f7
    db $f0

Message_00_3E::
    db $ea, "*: GreatLog's major", $f1
    db "facilities are", $fa, $f7
    db $ef, $ee, "situated above", $ef, $ee, "here.", $fa, $f7
    db $ef, $ee, "They're no place", $ef, $ee, "for kids. Shoo!", $f7
    db $f0

Message_00_3F::
    db $eb, "*: Inside the well", $f1
    db "is the Log's Navel.", $fa, $f7
    db $ef, $ee, "It's said to be", $ef, $ee, "the center of", $fa, $f7
    db $ef, $ee, "GreatLog.", $ef, $ee, "But it's not safe.", $fa, $f7
    db $ef, $ee, "Don't go in there.", $ef, $ee, $f7
    db $f0

Message_00_40::
    db $ea, "*: On this island,", $f1
    db "every day goes by", $fa, $f7
    db $ef, $ee, "without anything", $ef, $ee, "being different.", $fa, $f7
    db $ef, $ee, "But it's never", $ef, $ee, "boring.", $fa, $f7
    db $ef, $ee, "I consider it", $ef, $ee, "heavenly luxury!", $f7
    db $f0

Message_00_41::
    db $eb, "*: Warubou is the", $f1
    db "island's spirit.", $fa, $f7
    db $ef, $ee, "So we can't really", $ef, $ee, "complain about", $fa, $f7
    db $ef, $ee, "all the mischief", $ef, $ee, "it gets into", $a4, $f7
    db $f0

Message_00_42::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Danger!", $ef, $ee, "Stay clear!", $95, $f7
    db $f0

Message_00_43::
    db $f9, "0 checked the", $f1
    db "odd object.", $fa, $f7
    db $ef, $ee, "It appears to be", $ef, $ee, "plugging a hole", $a4, $f7
    db $f0

Message_00_44::
    db $f9, "0 checked the", $f1
    db "peculiar door.", $fa, $f7
    db $ef, $ee, "It has an oddly", $ef, $ee, "shaped keyhole", $a4, $f7
    db $f0

Message_00_45::
    db $ea, "*: You must be the", $f1
    db "farm kids.", $fa, $f7
    db $ef, $ee, "Your grandma sent", $ef, $ee, "a package for you.", $fa, $f7
    db $ef, $ee, "It smells really", $ef, $ee, "delicious!", $fa, $f7
    db $ef, $ee, "Here you go! Be", $ef, $ee, "careful with it!", $f7
    db $f0

Message_00_46::
    db $ea, "*: Thanks for", $f1
    db "coming by.", $fa, $f7
    db $ef, $ee, "I'll always be", $ef, $ee, "here to serve you!", $f7
    db $f0

Message_00_47::
    db $f9, "0 read the", $f1
    db "notice.", $fa, $f7
    db $ef, $ee, "'We guarantee the", $ef, $ee, "safekeeping of", $fa, $f7
    db $ef, $ee, "your precious", $ef, $ee, "items and money!", $95, $f7
    db $f0

Message_00_48::
    db $ea, "*: I'm Prince Kameha", $ef, $ee, "of GreatLog!", $fa, $f7
    db $ef, $ee, "You may not pass,", $ef, $ee, "peasants!", $f7
    db $f0

Message_00_49::
    db $ea, "Kameha: Wahahah!", $f1
    db "No going by me!", $f7
    db $f0

Message_00_4A::
    db $ea, "*: I'm Warubou,", $f1
    db "GreatLog's spirit!", $fa, $f7
    db $ef, $ee, "Warooh, wa-hey!", $ef, $ee, $f7
    db $f0

Message_00_4B::
    db $ea, "Warubou: It's a", $f1
    db "dead end, warooh!", $fa, $f7
    db $ef, $ee, "Look for another", $ef, $ee, "way, wa-hey!", $f7
    db $f0

Message_00_4C::
    db $ea, "*: Have you heard", $f1
    db "about Magic Keys?", $ff, $f0

Message_00_4D::
    db $ea, "*: Wow, you kids", $f1
    db "sure learn quick!", $f7
    db $f0

Message_00_4E::
    db $ea, "*: You need Magic", $f1
    db "Keys to open the", $fa, $f7
    db $ef, $ee, "magical door to", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "That's where I get", $ef, $ee, "my monsters.", $f7
    db $f0

Message_00_4F::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Give me something!", $fa, $f7
    db $ef, $ee, "Then, I'll let you", $ef, $ee, "pass, warooh!", $f7
    db $f0

Message_00_50::
    db $ea, "Warubou: Wha", $a4, "?", $f1
    db "I smell something!", $fa, $f7
    db $ef, $ee, "I smell something", $ef, $ee, "tasty.", $f7
    db $f0

Message_00_51::
    db $ea, "Warubou: What is", $f1
    db "this? Food?", $fa, $f7
    db $ef, $ee, "Perfect! I was", $ef, $ee, "hungry, wa-hey!", $f7
    db $f0

Message_00_52::
    db $eb, "*: Oh my, the well", $f1
    db "isn't safe!", $fa, $f7
    db $ef, $ee, "Don't be like", $ef, $ee, "Warubou!", $f7
    db $f0

Message_00_53::
    db $ea, "Warubou: Wa-hey!", $f1
    db "I'm starving!", $f7
    db $f0

Message_00_54::
    db $ea, "Kameha: Gimme it!", $f1
    db "You just ate!", $fa, $f7
    db $ef, $ee, "You grubby little", $ef, $ee, "elemental!", $f7
    db $f0

Message_00_55::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Some prince!", $fa, $f7
    db $ef, $ee, "Dirty mouth!", $ef, $ee, "Come on, warooh!", $f7
    db $f0

Message_00_56::
    db $ea, "Cobi: That's ours!", $f1
    db "Give it back!", $f7
    db $f0

Message_00_59::
    db $ea, "Warubou: Wa-wa-wa-", $f1
    db "wa-wa-hey!", $fa, $f7
    db $ef, $ee, "The Log's Navel's", $ef, $ee, "breached, warooh!", $f7
    db $f0

Message_00_5A::
    db $ea, "Kameha: I", $a4, " It", $a4, $f1
    db "It's not my fault!", $f7
    db $f0

Message_00_5B::
    db $ea, "Warubou: Wa-hey!", $f1
    db "It's the only way!", $f7
    db $f0

Message_00_5C::
    db $ea, "Warubou: Warooh!", $f1
    db "Will it hold?", $fa, $f7
    db $ef, $ee, "You two, come here", $ef, $ee, "now, warooh!", $f7
    db $f0

Message_00_5D::
    db $ea, "Warubou: Calm down", $f1
    db "and listen!", $fa, $f7
    db $ef, $ee, "What came out of", $ef, $ee, "the hole now, that", $fa, $f7
    db $ef, $ee, "was the life force", $ef, $ee, "of GreatLog's tree.", $fa, $f7
    db $ef, $ee, "GreatLog is an", $ef, $ee, "island kept afloat", $fa, $f7
    db $ef, $ee, "by the palm tree,", $ef, $ee, "do you see?", $fa, $f7
    db $ef, $ee, "If the palm tree", $ef, $ee, "dies, the island", $fa, $f7
    db $ef, $ee, "sinks into the", $ef, $ee, "deep, deep ocean.", $fa, $f7
    db $ef, $ee, "A plug! That is", $ef, $ee, "what we need!", $fa, $f7
    db $ef, $ee, "A plug to plug the", $ef, $ee, "Log's Navel!", $fa, $f7
    db $ef, $ee, "Hurry, go fetch a", $ef, $ee, "monster master!", $f7
    db $f0

Message_00_5E::
    db $eb, "Tara: That's ours!", $f1
    db "Give it back!", $f7
    db $f0

Message_00_5F::
    db $ea, "Warubou: A new", $f1
    db "plug for the", $fa, $f7
    db $ef, $ee, "Log's Navel needs", $ef, $ee, "a monster master", $fa, $f7
    db $ef, $ee, "to find, yes it", $ef, $ee, "does, warooh!", $fa, $f7
    db $ef, $ee, "Quick, fetch a", $ef, $ee, "monster master!", $f7
    db $f0

Message_00_60::
    db $ea, "*: Hah? The island's", $f1
    db "going to sink?", $fa, $f7
    db $ef, $ee, "You shouldn't lie", $ef, $ee, "like that ", $f9, "0.", $f7
    db $f0

Message_00_61::
    db $ea, "Cobi: Why won't you", $f1
    db "believe us?", $fa, $f7
    db $ef, $ee, "You stubborn old", $ef, $ee, "goat!", $f7
    db $f0

Message_00_62::
    db $ea, "*: Look, an island", $f1
    db "just doesn't sink.", $fa, $f7
    db $ef, $ee, "Listen to yourself", $ef, $ee, "for a moment.", $fa, $f7
    db $ef, $ee, "Anyway, did you", $ef, $ee, "run Mom's errand?", $f7
    db $f0

Message_00_63::
    db $eb, "Tara: Why aren't", $f1
    db "you listening?", $fa, $f7
    db $ef, $ee, "Papa, you're such", $ef, $ee, "a blockhead!", $f7
    db $f0

Message_00_64::
    db $ea, "*: The island's", $f1
    db "sinking, right.", $fa, $f7
    db $ef, $ee, "Not you too.", $ef, $ee, "Look, I'm busy.", $fa, $f7
    db $ef, $ee, "Warubou and the", $ef, $ee, "Prince are just", $fa, $f7
    db $ef, $ee, "pulling your legs,", $ef, $ee, "I'm sure of it.", $f7
    db $f0

Message_00_65::
    db $ea, "Slash: The island's", $f1
    db "going to sink?", $fa, $f7
    db $ef, $ee, "That's a genuine", $ef, $ee, "crisis!", $fa, $f7
    db $ef, $ee, "I'm right here if", $ef, $ee, "you need any help!", $f7
    db $f0

Message_00_66::
    db $ea, "*: This island is", $f1
    db "going to sink?", $fa, $f7
    db $ef, $ee, "I", $a4, " The tide seems", $ef, $ee, "to be higher!", $f7
    db $f0

Message_00_67::
    db $ea, "*: We're going to", $f1
    db "sink?", $fa, $f7
    db $ef, $ee, "I can't swim!", $ef, $ee, "What should I do?", $f7
    db $f0

Message_00_68::
    db $ea, "*: Huh? The island", $f1
    db "is going to sink?", $fa, $f7
    db $ef, $ee, "Are you in Prince", $ef, $ee, "Kameha's gang?", $f7
    db $f0

Message_00_69::
    db $ea, "*: Prince Kameha", $f1
    db "was saying the", $fa, $f7
    db $ef, $ee, "same thing a", $ef, $ee, "little while ago.", $f7
    db $f0

Message_00_6A::
    db $eb, "*: Did you get", $f1
    db "the package", $fa, $f7
    db $ef, $ee, "from grandma?", $ef, $ee, $f7
    db $f0

Message_00_6B::
    db $eb, "*: Oh goodness,", $f1
    db "you're filthy!", $fa, $f7
    db $ef, $ee, "What happened to", $ef, $ee, "you two?", $fa, $f7
    db $ef, $ee, $a4, "Giggle", $a4, " You were", $ef, $ee, "tricked by that", $fa, $f7
    db $ef, $ee, "silly Warubou.", $ef, $ee, "Don't worry.", $fa, $f7
    db $ef, $ee, "The island won't", $ef, $ee, "sink that easily.", $f7
    db $f0

Message_00_6C::
    db $eb, "*: You can go out,", $f1
    db "but not too late!", $f7
    db $f0

Message_00_6D::
    db $eb, "*: The island's", $ef, $ee, "going to sink?", $fa, $f7
    db $ef, $ee, "I know, you were", $ef, $ee, "fooled by Warubou.", $fa, $f7
    db $ef, $ee, "Last time he was", $ef, $ee, "yelling about the", $fa, $f7
    db $ef, $ee, "great King of", $ef, $ee, "Terror from the", $fa, $f7
    db $ef, $ee, "sky", $a4, $ef, $ee, $f7
    db $f0

Message_00_6E::
    db $eb, "*: The island is", $f1
    db "sinking?", $fa, $f7
    db $ef, $ee, "Prince Kameha put", $ef, $ee, "you up to this.", $f7
    db $f0

Message_00_6F::
    db $eb, "*: Oh, you kids!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "You shouldn't be", $ef, $ee, "in the well.", $fa, $f7
    db $ef, $ee, "What? The Log's", $ef, $ee, "Navel is broken?", $fa, $f7
    db $ef, $ee, "But why is that", $ef, $ee, "important?", $f7
    db $f0

Message_00_70::
    db $eb, "*: The island isn't", $f1
    db "sinking.", $fa, $f7
    db $ef, $ee, "If you lie, your", $ef, $ee, "nose will grow!", $f7
    db $f0

Message_00_71::
    db $ea, "*: Looking for a", $f1
    db "monster master?", $fa, $f7
    db $ef, $ee, "I have no time for", $ef, $ee, "child's play!", $f7
    db $f0

Message_00_72::
    db $ea, "*: This island is", $f1
    db "sinking?", $fa, $f7
    db $ef, $ee, "If that's true,", $ef, $ee, "it's a disaster", $a4, $fa, $f7
    db $ef, $ee, "But I haven't", $ef, $ee, "heard anything", $fa, $f7
    db $ef, $ee, "about it!", $ef, $ee, $f7
    db $f0

Message_00_73::
    db $ea, "*: Hm? Warubou", $f1
    db "wants you to find", $fa, $f7
    db $ef, $ee, "a monster master", $ef, $ee, "for him?", $fa, $f7
    db $ef, $ee, "Well I am one but", $ef, $ee, "I don't want to", $fa, $f7
    db $ef, $ee, "have anything to", $ef, $ee, "do with Warubou.", $fa, $f7
    db $ef, $ee, "Sorry, but can you", $ef, $ee, "try someone else?", $f7
    db $f0

Message_00_74::
    db $eb, "*: You're after a", $f1
    db "monster master?", $fa, $f7
    db $ef, $ee, "I saw one lolling", $ef, $ee, "around the Vault.", $f7
    db $f0

Message_00_75::
    db $ea, "*: The island's", $f1
    db "going to sink?", $fa, $f7
    db $ef, $ee, "Don't spread silly", $ef, $ee, "rumors like that.", $fa, $f7
    db $ef, $ee, "What if it scares", $ef, $ee, "off customers?", $f7
    db $f0

Message_00_76::
    db $ea, "*: The island is", $f1
    db "sinking?", $fa, $f7
    db $ef, $ee, "Hahah, no worries!", $ef, $ee, "We can all escape", $fa, $f7
    db $ef, $ee, "to another world.", $ef, $ee, "Wait a sec", $a4, " How", $fa, $f7
    db $ef, $ee, "would we get", $ef, $ee, "there?", $f7
    db $f0

Message_00_77::
    db $ea, "*: The island's", $f1
    db "sinking?", $fa, $f7
    db $ef, $ee, "That's hard to", $ef, $ee, "believe, but", $a4, $fa, $f7
    db $ef, $ee, "You don't look like", $ef, $ee, "a liar", $a4, $fa, $f7
    db $ef, $ee, "I was going to", $ef, $ee, "open a shop here,", $fa, $f7
    db $ef, $ee, "but I guess I'll", $ef, $ee, "hit the road.", $f7
    db $f0

Message_00_78::
    db $ea, "*: It's pointless", $f1
    db "if you're dead.", $fa, $f7
    db $ef, $ee, "I'm going to leave", $ef, $ee, "again.", $f7
    db $f0

Message_00_79::
    db $ea, "*: You say the", $f1
    db "island will sink?", $fa, $f7
    db $ef, $ee, "Sorry, but I can't", $ef, $ee, "believe that.", $f7
    db $f0

Message_00_7A::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Good, you're back.", $fa, $f7
    db $ef, $ee, "You told everyone", $ef, $ee, "GreatLog'll sink?", $fa, $f7
    db $ef, $ee, "So, where is the", $ef, $ee, "monster master?", $fa, $f7
    db $ef, $ee, $a4, "What? Nobody", $ef, $ee, "believed you?", $fa, $f7
    db $ef, $ee, "Warooh, they are", $ef, $ee, "so complacent!", $fa, $f7
    db $ef, $ee, "Wa-hey, it can't", $ef, $ee, "be helped now.", $fa, $f7
    db $ef, $ee, "You go instead.", $ef, $ee, "No other way!", $f7
    db $f0

Message_00_7B::
    db $ea, "Warubou: No time", $f1
    db "to waste, warooh!", $fa, $f7
    db $ef, $ee, "If you don't go,", $ef, $ee, "GreatLog goes to", $fa, $f7
    db $ef, $ee, "the bottom of the", $ef, $ee, "sea soon enough!", $fa, $f7
    db $ef, $ee, "You will go find a", $ef, $ee, "new plug for the", $fa, $f7
    db $ef, $ee, "Log's Navel,", $ef, $ee, "wa-hey?", $ff, $f0

Message_00_7C::
    db $ea, "Warubou: No?", $f1
    db "Then find someone!", $f7
    db $f0

Message_00_7D::
    db $ea, "Warubou: Wa-hey?", $f1
    db "No one believed!", $fa, $f7
    db $ef, $ee, "You have to go, no", $ef, $ee, "choice about it!", $f7
    db $f0

Message_00_7E::
    db $ea, "Warubou: Wa-hey!", $f1
    db "No more dawdling!", $fa, $f7
    db $ef, $ee, "GreatLog will sink", $ef, $ee, "into the sea!", $fa, $f7
    db $ef, $ee, "You have to go, no", $ef, $ee, "choice about it!", $ff, $f0

Message_00_7F::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Good, good, good!", $fa, $f7
    db $ef, $ee, "In you, I saw the", $ef, $ee, "potential, warooh!", $fa, $f7
    db $ef, $ee, "A good idea I have", $ef, $ee, "for plugging up", $fa, $f7
    db $ef, $ee, "the Log's Navel,", $ef, $ee, "yes I do, warooh.", $fa, $f7
    db $ef, $ee, "I'm an elemental", $ef, $ee, "so I know such!", $fa, $f7
    db $ef, $ee, "Here, take this,", $ef, $ee, "you, warooh.", $f7
    db $f0

Message_00_80::
    db $ea, "Warubou: This here", $f1
    db "is a Magic Key.", $fa, $f7
    db $ef, $ee, "It opens the door", $ef, $ee, "to other worlds.", $fa, $f7
    db $ef, $ee, "Specially made it", $ef, $ee, "is, by elemental", $fa, $f7
    db $ef, $ee, "power, making it", $ef, $ee, "magic, warooh.", $fa, $f7
    db $ef, $ee, "Use to open the", $ef, $ee, "magic door ahead.", $fa, $f7
    db $ef, $ee, "It takes you to", $ef, $ee, "another world.", $fa, $f7
    db $ef, $ee, "Another world, it", $ef, $ee, "might be, warooh,", $fa, $f7
    db $ef, $ee, "but it is not much", $ef, $ee, "different.", $fa, $f7
    db $ef, $ee, "Only difference is", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "Monsters live in", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "But a monster", $ef, $ee, "master needs to", $fa, $f7
    db $ef, $ee, "fear not a thing,", $ef, $ee, "warooh.", $fa, $f7
    db $ef, $ee, "I see you have", $ef, $ee, "great potential.", $fa, $f7
    db $ef, $ee, "You go to other", $ef, $ee, "worlds, and bring", $fa, $f7
    db $ef, $ee, "back a plug for", $ef, $ee, "the Log's Navel.", $fa, $f7
    db $ef, $ee, "That something, I", $ef, $ee, "don't know what.", $fa, $f7
    db $ef, $ee, "But you will know", $ef, $ee, "when you find it!", $fa, $f7
    db $ef, $ee, "Now, warooh, take", $ef, $ee, "this!", $f7
    db $f0

Message_00_81::
    db $f9, "0 received the", $f1
    db "Oasis Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_00_82::
    db $ea, "Warubou: Wa-hey!", $f1
    db "I trust you! Go!", $f7
    db $f0

Message_00_83::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Forgot something!", $f7
    db $f0

Message_00_84::
    db $ea, "Warubou: This you", $f1
    db "use to come back", $fa, $f7
    db $ef, $ee, "to GreatLog from", $ef, $ee, "other worlds.", $f7
    db $f0

Message_00_85::
    db $f9, "0 received the", $f1
    db "GreatLog Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_00_86::
    db $ea, "Warubou: Dangerous", $f1
    db "are other worlds!", $fa, $f7
    db $ef, $ee, "So you take", $ef, $ee, "monsters, warooh.", $fa, $f7
    db $ef, $ee, "Wa-hey, I'm", $ef, $ee, "GreatLog's spirit.", $fa, $f7
    db $ef, $ee, "One with the", $ef, $ee, "island I am.", $fa, $f7
    db $ef, $ee, "If you can't stop", $ef, $ee, "the island from", $fa, $f7
    db $ef, $ee, "sinking, so ends", $ef, $ee, "my life, warooh.", $fa, $f7
    db $ef, $ee, "Not just me, but", $ef, $ee, "everyone here.", $fa, $f7
    db $ef, $ee, "So, you must!", $ef, $ee, "Must find a plug!", $f7
    db $f0

Message_00_87::
    db $ea, "Cobi: This is bad.", $f1
    db "What'll we do?", $fa, $f7
    db $ef, $ee, "Let's go home and", $ef, $ee, "talk about it.", $f7
    db $f0

Message_00_88::
    db $eb, "Tara: Oh, wow.", $f1
    db "This is terrible.", $fa, $f7
    db $ef, $ee, "We should talk", $ef, $ee, "about it at home.", $f7
    db $f0

Message_00_89::
    db $ea, "Cobi: If we don't", $f1
    db "find a plug for", $fa, $f7
    db $ef, $ee, "the Log's Navel,", $ef, $ee, "the island sinks.", $fa, $f7
    db $ef, $ee, "Our house and the", $ef, $ee, "farm too.", $fa, $f7
    db $ef, $ee, "We have to go look", $ef, $ee, "ourselves, right?", $f7
    db $f0

Message_00_8A::
    db $ea, "Cobi: But if we", $f1
    db "both go to other", $fa, $f7
    db $ef, $ee, "worlds, Mama will", $ef, $ee, "be worried.", $f7
    db $f0

Message_00_8B::
    db $ea, "Cobi: That's true", $a4, $f1
    db "If we both went to", $fa, $f7
    db $ef, $ee, "other worlds, Mama", $ef, $ee, "would be worried.", $f7
    db $f0

Message_00_8C::
    db $ea, "Slash: Hey, why", $f1
    db "the long faces?", $fa, $f7
    db $ef, $ee, "I couldn't help", $ef, $ee, "overhearing you.", $fa, $f7
    db $ef, $ee, "I'll go with you", $ef, $ee, "to other worlds.", $fa, $f7
    db $ef, $ee, "That way, one of", $ef, $ee, "you can stay here.", $fa, $f7
    db $ef, $ee, "That solves your", $ef, $ee, "little problem!", $f7
    db $f0

Message_00_8D::
    db $ea, "Cobi: That's true.", $f1
    db "What to do", $a4, $fa, $f7
    db $ef, $ee, "Huh? ", $f9, "0?", $ef, $ee, "Do you want to go?", $ff, $f0

Message_00_8E::
    db $ea, "Cobi: Don't waste", $f1
    db "your time lying.", $fa, $f7
    db $ef, $ee, "I can see it in", $ef, $ee, "your eyes.", $fa, $f7
    db $ef, $ee, "You really want to", $ef, $ee, "go, don't you?", $ff, $f0

Message_00_8F::
    db $ea, "Cobi: Fine. But", $f1
    db $f9, "0, by", $fa, $f7
    db $ef, $ee, "yourself", $a4, $f7
    db $f0

Message_00_90::
    db $ea, "Slash: Don't worry!", $f1
    db "I'm riding along!", $f7
    db $f0

Message_00_91::
    db $ea, "Slash: And ", $f9, "0", $f1
    db "has potential,", $fa, $f7
    db $ef, $ee, "I think, to be a", $ef, $ee, "monster master.", $fa, $f7
    db $ef, $ee, "We'll need the", $ef, $ee, "help of monsters", $fa, $f7
    db $ef, $ee, "when we go to", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "So that potential", $ef, $ee, "will help a lot!", $f7
    db $f0

Message_00_92::
    db $ea, "Cobi: Fine, ", $f9, "0.", $f1
    db "It's up to you.", $fa, $f7
    db $ef, $ee, "You do your best", $ef, $ee, "and save us!", $f7
    db $f0

Message_00_93::
    db $ea, "Slash: That's", $f1
    db "settled, then!", $fa, $f7
    db $ef, $ee, "We'll leave", $ef, $ee, "tomorrow morning.", $fa, $f7
    db $ef, $ee, "Get plenty of rest", $ef, $ee, "tonight!", $f7
    db $f0

Message_00_94::
    db $eb, "Tara: If we don't", $f1
    db "go find something", $fa, $f7
    db $ef, $ee, "to put in the Log's", $ef, $ee, "Navel, this house,", $fa, $f7
    db $ef, $ee, "the farm and", $ef, $ee, "everything else", $fa, $f7
    db $ef, $ee, "will sink with the", $ef, $ee, "island.", $fa, $f7
    db $ef, $ee, "So we have to go", $ef, $ee, "to other worlds,", $fa, $f7
    db $ef, $ee, "right?", $ff, $f0

Message_00_95::
    db $eb, "Tara: But if we", $f1
    db "both went, Mama", $fa, $f7
    db $ef, $ee, "would be really", $ef, $ee, "worried about us.", $f7
    db $f0

Message_00_96::
    db $eb, "Tara: Oh", $a4, " If we", $f1
    db "both went, Mama", $fa, $f7
    db $ef, $ee, "would be really", $ef, $ee, "worried about us.", $f7
    db $f0

Message_00_97::
    db $eb, "Tara: ", $f9, "0, you", $f1
    db "want to go.", $fa, $f7
    db $ef, $ee, $f9, "0, do you want", $ef, $ee, "me to stay home?", $ff, $f0

Message_00_98::
    db $eb, "Tara: You don't", $f1
    db "have to lie.", $fa, $f7
    db $ef, $ee, "We'll be all right", $ef, $ee, "here.", $fa, $f7
    db $ef, $ee, "You do really want", $ef, $ee, "to go, right?", $ff, $f0

Message_00_99::
    db $eb, "Tara: But ", $f9, "0,", $f1
    db "what about your", $fa, $f7
    db $ef, $ee, "terrible sense of", $ef, $ee, "direction?", $f7
    db $f0

Message_00_9A::
    db $eb, "Tara: Then it's", $f1
    db "your job, ", $f9, "0!", $fa, $f7
    db $ef, $ee, "Make me proud, big", $ef, $ee, "brother!", $f7
    db $f0

Message_00_9B::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, $f9, "Y.", $f7
    db $f0

Message_00_A1::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "But it was empty", $a4, $ef, $ee, $f7
    db $f0

Message_00_A2::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 found the", $ef, $ee, $f9, "Y.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, $f9, "Y back.", $f7
    db $f0

Message_00_A3::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, $f9, "Y.", $f7
    db $f0

Message_00_A4::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "But it was empty.", $ef, $ee, $f7
    db $f0

Message_00_A5::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, $f9, "0 found the", $ef, $ee, $f9, "Y.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, $f9, "Y back.", $f7
    db $f0

Message_00_A6::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, $f9, "Y.", $f7
    db $f0

Message_00_A7::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "But it was empty.", $ef, $ee, $f7
    db $f0

Message_00_A8::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, $f9, "0 found the", $ef, $ee, $f9, "Y.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, $f9, "Y back.", $f7
    db $f0

Message_00_A9::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained a", $ef, $ee, "Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_00_AA::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "But it was empty", $a4, $ef, $ee, $f7
    db $f0

Message_00_AB::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 found a", $ef, $ee, "Magic Key.", $fa, $f7
    db $ef, $ee, "But the key ring", $ef, $ee, "is full.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "Magic Key back.", $f7
    db $f0

Message_00_AC::
    db $ea, "*: Let's see how", $f1
    db "good you are!", $f7
    db $f0

Message_00_D1::
    db $ea, "*: You think you", $f1
    db "could win?", $fa, $f7
    db $ef, $ee, "Dream on, you", $ef, $ee, "insolent fools!", $f7
    db $f0

Message_00_D2::
    db $ea, "*: Well, I", $44, " never", $f1
    db "expected you here.", $fa, $f7
    db $ef, $ee, "But this shall be", $ef, $ee, "your tomb!", $f7
    db $f0

Message_00_D3::
    db $ea, "*: Prepare to be", $f1
    db "overwhelmed!", $f7
    db $f0

Message_00_D4::
    db $ea, "*: Those monsters", $f1
    db "are my foes?", $fa, $f7
    db $ef, $ee, "Fwahahaha!", $ef, $ee, "How ludicrous!", $f7
    db $f0

Message_00_D5::
    db $ea, "*: If you win, you", $f1
    db "can be the boss!", $f7
    db $f0

Message_00_D6::
    db $ea, "*: I'll show you how", $f1
    db "small you are in", $fa, $f7
    db $ef, $ee, "the grand scheme", $ef, $ee, "of things!", $f7
    db $f0

Message_00_D7::
    db $ea, "*: Hm? My rival is", $f1
    db "here? Come on!", $f7
    db $f0

Message_00_D8::
    db $ea, "*: Finally, someone", $f1
    db "to ignite my soul!", $f7
    db $f0

Message_00_D9::
    db $ea, "*: I feel your", $f1
    db "strength", $a4, $fa, $f7
    db $ef, $ee, "This will be a", $ef, $ee, "long battle.", $f7
    db $f0
    ds $2f, $00
