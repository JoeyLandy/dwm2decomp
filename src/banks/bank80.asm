SECTION "Bank 80", ROMX[$4000], BANK[$80]
    db $80

; message bank $80: when wStringIndex < $C8, BeginStringDisplay with this bank's table
; MessageStrings_Bank80; otherwise far-calls BeginStringDisplay_Bank80_Overflow (E-0080)
BeginStringDisplay_Bank80::
    ld a, [wStringIndex]
    cp $c8
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank80_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank80
    call BeginStringDisplay
    ret

; message bank $80: when wStringIndex < $C8, CopyStringToBuffer with this bank's table
; MessageStrings_Bank80; otherwise far-calls CopyStringToBuffer_Bank80_Overflow (E-0080)
CopyStringToBuffer_Bank80::
    ld a, [wStringIndex]
    cp $c8
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank80_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank80
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_80_4032::
MessageStrings_Bank80::
    dw StringList_80_4034 ; id 0

; category list of StringCategories_80_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_80_4034::
    dw Message_09_00 ; id 0
    dw Message_09_01 ; id 1
    dw Message_09_02 ; id 2
    dw Message_09_03 ; id 3
    dw Message_09_04 ; id 4
    dw Message_09_05 ; id 5
    dw Message_09_06 ; id 6
    dw Message_09_07 ; id 7
    dw Message_09_08 ; id 8
    dw Message_09_09 ; id 9
    dw Message_09_0A ; id 10
    dw Message_09_0B ; id 11
    dw Message_09_0C ; id 12
    dw Message_09_0D ; id 13
    dw Message_09_0E ; id 14
    dw Message_09_0F ; id 15
    dw Message_09_10 ; id 16
    dw Message_09_11 ; id 17
    dw Message_09_12 ; id 18
    dw Message_09_13 ; id 19
    dw Message_09_14 ; id 20
    dw Message_09_15 ; id 21
    dw Message_09_16 ; id 22
    dw Message_09_17 ; id 23
    dw Message_09_17 ; id 24
    dw Message_09_17 ; id 25
    dw Message_09_17 ; id 26
    dw Message_09_17 ; id 27
    dw Message_09_17 ; id 28
    dw Message_09_17 ; id 29
    dw Message_09_17 ; id 30
    dw Message_09_17 ; id 31
    dw Message_09_17 ; id 32
    dw Message_09_21 ; id 33
    dw Message_09_22 ; id 34
    dw Message_09_23 ; id 35
    dw Message_09_24 ; id 36
    dw Message_09_25 ; id 37
    dw Message_09_26 ; id 38
    dw Message_09_27 ; id 39
    dw Message_09_28 ; id 40
    dw Message_09_29 ; id 41
    dw Message_09_2A ; id 42
    dw Message_09_2B ; id 43
    dw Message_09_2C ; id 44
    dw Message_09_2D ; id 45
    dw Message_09_2E ; id 46
    dw Message_09_2F ; id 47
    dw Message_09_30 ; id 48
    dw Message_09_31 ; id 49
    dw Message_09_32 ; id 50
    dw Message_09_33 ; id 51
    dw Message_09_34 ; id 52
    dw Message_09_35 ; id 53
    dw Message_09_36 ; id 54
    dw Message_09_37 ; id 55
    dw Message_09_38 ; id 56
    dw Message_09_39 ; id 57
    dw Message_09_3A ; id 58
    dw Message_09_3B ; id 59
    dw Message_09_3C ; id 60
    dw Message_09_3D ; id 61
    dw Message_09_3E ; id 62
    dw Message_09_3F ; id 63
    dw Message_09_40 ; id 64
    dw Message_09_41 ; id 65
    dw Message_09_42 ; id 66
    dw Message_09_43 ; id 67
    dw Message_09_44 ; id 68
    dw Message_09_45 ; id 69
    dw Message_09_46 ; id 70
    dw Message_09_47 ; id 71
    dw Message_09_48 ; id 72
    dw Message_09_49 ; id 73
    dw Message_09_4A ; id 74
    dw Message_09_4B ; id 75
    dw Message_09_4C ; id 76
    dw Message_09_4D ; id 77
    dw Message_09_4E ; id 78
    dw Message_09_4F ; id 79
    dw Message_09_50 ; id 80
    dw Message_09_51 ; id 81
    dw Message_09_52 ; id 82
    dw Message_09_53 ; id 83
    dw Message_09_54 ; id 84
    dw Message_09_55 ; id 85
    dw Message_09_56 ; id 86
    dw Message_09_57 ; id 87
    dw Message_09_58 ; id 88
    dw Message_09_59 ; id 89
    dw Message_09_5A ; id 90
    dw Message_09_5B ; id 91
    dw Message_09_5C ; id 92
    dw Message_09_5D ; id 93
    dw Message_09_5E ; id 94
    dw Message_09_5F ; id 95
    dw Message_09_60 ; id 96
    dw Message_09_61 ; id 97
    dw Message_09_62 ; id 98
    dw Message_09_63 ; id 99
    dw Message_09_64 ; id 100
    dw Message_09_65 ; id 101
    dw Message_09_66 ; id 102
    dw Message_09_67 ; id 103
    dw Message_09_68 ; id 104
    dw Message_09_69 ; id 105
    dw Message_09_6A ; id 106
    dw Message_09_6B ; id 107
    dw Message_09_6C ; id 108
    dw Message_09_6D ; id 109
    dw Message_09_6E ; id 110
    dw Message_09_6F ; id 111
    dw Message_09_70 ; id 112
    dw Message_09_71 ; id 113
    dw Message_09_72 ; id 114
    dw Message_09_73 ; id 115
    dw Message_09_74 ; id 116
    dw Message_09_75 ; id 117
    dw Message_09_76 ; id 118
    dw Message_09_77 ; id 119
    dw Message_09_78 ; id 120
    dw Message_09_79 ; id 121
    dw Message_09_7A ; id 122
    dw Message_09_7B ; id 123
    dw Message_09_7C ; id 124
    dw Message_09_7D ; id 125
    dw Message_09_7E ; id 126
    dw Message_09_7F ; id 127
    dw Message_09_80 ; id 128
    dw Message_09_81 ; id 129
    dw Message_09_82 ; id 130
    dw Message_09_83 ; id 131
    dw Message_09_83 ; id 132
    dw Message_09_83 ; id 133
    dw Message_09_83 ; id 134
    dw Message_09_83 ; id 135
    dw Message_09_83 ; id 136
    dw Message_09_83 ; id 137
    dw Message_09_83 ; id 138
    dw Message_09_83 ; id 139
    dw Message_09_83 ; id 140
    dw Message_09_83 ; id 141
    dw Message_09_83 ; id 142
    dw Message_09_83 ; id 143
    dw Message_09_83 ; id 144
    dw Message_09_83 ; id 145
    dw Message_09_83 ; id 146
    dw Message_09_83 ; id 147
    dw Message_09_83 ; id 148
    dw Message_09_83 ; id 149
    dw Message_09_83 ; id 150
    dw Message_09_83 ; id 151
    dw Message_09_83 ; id 152
    dw Message_09_83 ; id 153
    dw Message_09_83 ; id 154
    dw Message_09_83 ; id 155
    dw Message_09_83 ; id 156
    dw Message_09_83 ; id 157
    dw Message_09_83 ; id 158
    dw Message_09_83 ; id 159
    dw Message_09_83 ; id 160
    dw Message_09_83 ; id 161
    dw Message_09_83 ; id 162
    dw Message_09_83 ; id 163
    dw Message_09_83 ; id 164
    dw Message_09_83 ; id 165
    dw Message_09_83 ; id 166
    dw Message_09_83 ; id 167
    dw Message_09_83 ; id 168
    dw Message_09_83 ; id 169
    dw Message_09_83 ; id 170
    dw Message_09_83 ; id 171
    dw Message_09_83 ; id 172
    dw Message_09_83 ; id 173
    dw Message_09_83 ; id 174
    dw Message_09_83 ; id 175
    dw Message_09_83 ; id 176
    dw Message_09_83 ; id 177
    dw Message_09_83 ; id 178
    dw Message_09_83 ; id 179
    dw Message_09_83 ; id 180
    dw Message_09_83 ; id 181
    dw Message_09_B6 ; id 182
    dw Message_09_B7 ; id 183
    dw Message_09_B8 ; id 184
    dw Message_09_B8 ; id 185
    dw Message_09_BA ; id 186
    dw Message_09_BB ; id 187
    dw Message_09_BC ; id 188
    dw Message_09_BD ; id 189
    dw Message_09_BE ; id 190
    dw Message_09_BF ; id 191
    dw Message_09_C0 ; id 192
    dw Message_09_C1 ; id 193
    dw Message_09_C2 ; id 194
    dw Message_09_C3 ; id 195
    dw Message_09_C4 ; id 196
    dw Message_09_C5 ; id 197
    dw Message_09_C6 ; id 198
    dw Message_09_C7 ; id 199

Message_09_00::
    db $ea, "*: Queen Helen has", $f1
    db "become healthy.", $f7
    db $f0

Message_09_01::
    db $f9, "0 checked the", $f1
    db "shield.", $f7
    db $f0

Message_09_02::
    db $ea, "*: So it was you", $f1
    db "holding up plans", $a4, $fa, $f7
    db $ef, $ee, "The King of Limbo", $ef, $ee, "promised me strong", $fa, $f7
    db $ef, $ee, "monsters in return", $ef, $ee, "for the Sky Shield", $fa, $f7
    db $ef, $ee, "being taken from", $ef, $ee, "the elemental.", $fa, $f7
    db $ef, $ee, "Any more of your", $ef, $ee, "meddling will not", $fa, $f7
    db $ef, $ee, "be tolerated.", $ef, $ee, "You should just", $fa, $f7
    db $ef, $ee, "back off now.", $ef, $ee, "Do you really", $fa, $f7
    db $ef, $ee, "think you can", $ef, $ee, "challenge me?", $ff, $f0

Message_09_03::
    db $ea, "*: Tch, obstinate", $f1
    db "and foolish.", $fa, $f7
    db $ef, $ee, "You need to be", $ef, $ee, "taught a lesson.", $fa, $f7
    db $ef, $ee, "Come hither, my", $ef, $ee, "faithful fiends!", $fa, $f7
    db $ef, $ee, "Crush this fool!", $ef, $ee, $f7
    db $f0

Message_09_04::
    db $ea, "*: Wha", $a4, " No!", $f1
    db "My monsters!", $fa, $f7
    db $ef, $ee, "It won't be this", $ef, $ee, "easy next time!", $f7
    db $f0

Message_09_05::
    db $eb, "*: I bore witness", $f1
    db "to it all", $a4, $fa, $f7
    db $ef, $ee, "Your work has", $ef, $ee, "lifted the dark", $fa, $f7
    db $ef, $ee, "shadow that lay", $ef, $ee, "over this world.", $fa, $f7
    db $ef, $ee, "Peace should be", $ef, $ee, "quick to return.", $fa, $f7
    db $ef, $ee, "You no longer need", $ef, $ee, "the Crest.", $fa, $f7
    db $ef, $ee, "Throw it back into", $ef, $ee, "my spring.", $f7
    db $f0

Message_09_06::
    db $eb, "*: Throw the Crest", $f1
    db "into my spring.", $f7
    db $f0

Message_09_07::
    db $eb, "*: The Kingdoms", $f1
    db "should return to", $fa, $f7
    db $ef, $ee, "their peaceful", $ef, $ee, "states.", $fa, $f7
    db $ef, $ee, "As my thanks, take", $ef, $ee, "the Sky Shield.", $f7
    db $f0

Message_09_08::
    db $f9, "0 received", $f1
    db "the Sky Shield.", $f7
    db $f0

Message_09_09::
    db "A voice echoed", $f1
    db "from nowhere", $a4, $f7
    db $f0

Message_09_0A::
    db $ea, "*: ", $a4, "Wa-hey! ", $f9, "0,", $f1
    db "can you hear me?", $fa, $f7
    db $ef, $ee, "I felt an odd", $ef, $ee, "power stirring.", $fa, $f7
    db $ef, $ee, "You found a plug", $ef, $ee, "for the Navel!", $fa, $f7
    db $ef, $ee, "I'll bring you", $ef, $ee, "back! Don't move!", $f7
    db $f0

Message_09_0B::
    db $eb, "*: The spirit's", $f1
    db "spring in the", $fa, $f7
    db $ef, $ee, "north isn't icy", $ef, $ee, "anymore.", $fa, $f7
    db $ef, $ee, "However cold it", $ef, $ee, "may be, spring", $fa, $f7
    db $ef, $ee, "always comes, I", $ef, $ee, "guess.", $f7
    db $f0

Message_09_0C::
    db $ea, "*: The ice blocking", $f1
    db "the harbor finally", $fa, $f7
    db $ef, $ee, "broke up and", $ef, $ee, "melted away.", $fa, $f7
    db $ef, $ee, "We can get back to", $ef, $ee, "sailing again!", $f7
    db $f0

Message_09_0D::
    db $ea, "*: The long winter", $f1
    db "seems to be over.", $fa, $f7
    db $ef, $ee, "It feels a little", $ef, $ee, "warmer now.", $fa, $f7
    db $ef, $ee, "It's the perfect", $ef, $ee, "occasion for a", $fa, $f7
    db $ef, $ee, "celebration drink", $ef, $ee, "at the tavern.", $f7
    db $f0

Message_09_0E::
    db $ea, "*: We were visiting", $f1
    db "from the east.", $fa, $f7
    db $ef, $ee, "We found things to", $ef, $ee, "be good here, so", $fa, $f7
    db $ef, $ee, "we've decided to", $ef, $ee, "make this home.", $f7
    db $f0

Message_09_0F::
    db $ea, "*: When the harbor's", $f1
    db "ice disappeared,", $fa, $f7
    db $ef, $ee, "the sailors went", $ef, $ee, "away with it", $a4, $fa, $f7
    db $ef, $ee, "The tavern's not", $ef, $ee, "earning money.", $fa, $f7
    db $ef, $ee, "I'm still feeling", $ef, $ee, "blue", $a4, $f7
    db $f0

Message_09_10::
    db $eb, "*: Welcome! Oh?", $f1
    db "Hi, there!", $fa, $f7
    db $ef, $ee, "Well, you're a bit", $ef, $ee, "too young, but", $a4, $fa, $f7
    db $ef, $ee, "Since it's quiet,", $ef, $ee, "you're welcome.", $f7
    db $f0

Message_09_11::
    db $ea, "*: The eastern", $f1
    db "kingdom's castle", $fa, $f7
    db $ef, $ee, "is across the sea", $ef, $ee, "from here.", $fa, $f7
    db $ef, $ee, "Rumor has it that", $ef, $ee, "Queen Helen has", $fa, $f7
    db $ef, $ee, "recovered from her", $ef, $ee, "illness.", $f7
    db $f0

Message_09_12::
    db $ea, "*: The harbor has", $f1
    db "been busy with", $fa, $f7
    db $ef, $ee, "boats coming and", $ef, $ee, "going recently.", $fa, $f7
    db $ef, $ee, "I wonder how all", $ef, $ee, "the ice melted.", $f7
    db $f0

Message_09_13::
    db $ea, "*: The piled up ice", $f1
    db "floes disappeared", $fa, $f7
    db $ef, $ee, "from the harbor", $ef, $ee, "just like that.", $fa, $f7
    db $ef, $ee, "The elemental in", $ef, $ee, "the spring must", $fa, $f7
    db $ef, $ee, "have done it for", $ef, $ee, "us.", $f7
    db $f0

Message_09_14::
    db $ea, "*: The warm weather", $f1
    db "melted the ice in", $fa, $f7
    db $ef, $ee, "the elemental's", $ef, $ee, "spring.", $f7
    db $f0

Message_09_15::
    db $eb, "*: The scholar came", $f1
    db "back finally from", $fa, $f7
    db $ef, $ee, "his research trip.", $ef, $ee, "Who knows where he", $fa, $f7
    db $ef, $ee, "could have been", $ef, $ee, "all this time!", $f7
    db $f0

Message_09_16::
    db $ea, "*: My maid is angry", $f1
    db "that I left the", $fa, $f7
    db $ef, $ee, "house vacant for", $ef, $ee, "so long.", $fa, $f7
    db $ef, $ee, "I wasn't wandering", $ef, $ee, "aimlessly, but", $a4, $f7
    db $f0

Message_09_17::
    db $eb, "*: Father dug under", $f1
    db "the island, and he", $fa, $f7
    db $ef, $ee, "made a stable for", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "You can make them", $ef, $ee, "sleep now.", $f7
    db $f0

Message_09_21::
    db $eb, "*: I was going to", $f1
    db "ask Cobi, but I", $fa, $f7
    db $ef, $ee, "think you could do", $ef, $ee, "this, ", $f9, "0.", $fa, $f7
    db $ef, $ee, "Could you find", $ef, $ee, "something for me?", $ff, $f0

Message_09_22::
    db $eb, "*: The farm that", $f1
    db "your father always", $fa, $f7
    db $ef, $ee, "dreamed about is", $ef, $ee, "finally completed.", $fa, $f7
    db $ef, $ee, "I want to have a", $ef, $ee, "nice dinner to", $fa, $f7
    db $ef, $ee, "celebrate, so I", $44, $ef, $ee, "like some Sirloin.", $fa, $f7
    db $ef, $ee, "Please go buy some", $ef, $ee, "for me.", $f7
    db $f0

Message_09_23::
    db "*: Mama handed over", $f1
    db "1,200G.", $f7
    db $f0

Message_09_24::
    db $eb, "*: Oh", $a4, " Then I'll", $f1
    db "ask Cobi.", $f7
    db $f0

Message_09_25::
    db $eb, "*: I was going to", $f1
    db "ask Tara, but you", $fa, $f7
    db $ef, $ee, "could do this", $ef, $ee, "instead, ", $f9, "0.", $fa, $f7
    db $ef, $ee, "Could you find", $ef, $ee, "something for me?", $ff, $f0

Message_09_26::
    db $eb, "*: Oh", $a4, " Then I'll", $f1
    db "ask Tara.", $f7
    db $f0

Message_09_27::
    db $eb, "*: Buy some Sirloin", $f1
    db "for our dinner.", $f7
    db $f0

Message_09_28::
    db $eb, "*: They didn't have", $f1
    db "any around here.", $fa, $f7
    db $ef, $ee, "I'm surprised you", $ef, $ee, "found this.", $f7
    db $f0

Message_09_29::
    db $f9, "0 handed over", $f1
    db "the Sirloin.", $f7
    db $f0

Message_09_2A::
    db $eb, "*: I don't have any", $f1
    db "errands right now.", $fa, $f7
    db $ef, $ee, "I'll ask if there's", $ef, $ee, "anything, ", $f9, "0.", $f7
    db $f0

Message_09_2B::
    db $ea, "*: MadGopher helped", $f1
    db "me excavate.", $fa, $f7
    db $ef, $ee, "Look at the great", $ef, $ee, "stable we made!", $fa, $f7
    db $ef, $ee, "My dream farm is", $ef, $ee, "finally finished!", $f7
    db $f0

Message_09_2C::
    db $ea, "*: Whew. I'm done", $f1
    db "working finally.", $fa, $f7
    db $ef, $ee, "Can you take me", $ef, $ee, "out somewhere?", $ff, $f0

Message_09_2D::
    db $ea, "*: You will?", $f1
    db "I'll cut loose!", $f7
    db $f0

Message_09_2E::
    db $ea, "*: Oh, but you have", $f1
    db "no room for me", $a4, $f7
    db $f0

Message_09_2F::
    db $ea, "*: Oh, don't be", $f1
    db "that way.", $fa, $f7
    db $ef, $ee, "I'm sure I can", $ef, $ee, "help you.", $f7
    db $f0

Message_09_30::
    db $ea, "Cobi: ", $f9, "0, what", $f1
    db "was it like in the", $fa, $f7
    db $ef, $ee, "other worlds?", $ef, $ee, "I", $44, " like to know.", $fa, $f7
    db $ef, $ee, $a4, "You met an", $ef, $ee, "elemental spirit?", $fa, $f7
    db $ef, $ee, "Wow. I wish I got", $ef, $ee, "to meet her.", $fa, $f7
    db $ef, $ee, "Papa made a stable", $ef, $ee, "under the island,", $fa, $f7
    db $ef, $ee, "so monsters can go", $ef, $ee, "to sleep.", $fa, $f7
    db $ef, $ee, "So, what can I do", $ef, $ee, "for you, sis?", $f7
    db $f0

Message_09_31::
    db $eb, "Tara: Big brother,", $f1
    db "tell me about what", $fa, $f7
    db $ef, $ee, "you've seen in the", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "An elemental in a", $ef, $ee, "spring?", $fa, $f7
    db $ef, $ee, "Was she really", $ef, $ee, "pretty?", $fa, $f7
    db $ef, $ee, $a4, "Big brother, lose", $ef, $ee, "that smirk!", $fa, $f7
    db $ef, $ee, "Papa made a stable", $ef, $ee, "under the island,", $fa, $f7
    db $ef, $ee, "so monsters can go", $ef, $ee, "to sleep.", $fa, $f7
    db $ef, $ee, "Anyway, do you", $ef, $ee, "need any help?", $f7
    db $f0

Message_09_32::
    db $ea, "*: There are powers", $f1
    db "that let you cross", $fa, $f7
    db $ef, $ee, "the sea or fly up", $ef, $ee, "in the sky.", $fa, $f7
    db $ef, $ee, "If you get such", $ef, $ee, "powers, face the", $fa, $f7
    db $ef, $ee, "sea or sky and", $ef, $ee, "push a button!", $f7
    db $f0

Message_09_33::
    db $ea, "*: Have you been to", $f1
    db "the Starry Shrine?", $fa, $f7
    db $ef, $ee, "Breeding toughens", $ef, $ee, "up monsters.", $fa, $f7
    db $ef, $ee, "The offspring", $ef, $ee, "inherits the", $fa, $f7
    db $ef, $ee, "stats, attributes", $ef, $ee, "and skills of", $fa, $f7
    db $ef, $ee, "parents.", $ef, $ee, $f7
    db $f0

Message_09_34::
    db $ea, "*: Uheheheh, did", $f1
    db "you know this?", $fa, $f7
    db $ef, $ee, "Zombies like me", $ef, $ee, "aren't bothered by", $fa, $f7
    db $ef, $ee, "death spells or", $ef, $ee, "curses.", $fa, $f7
    db $ef, $ee, "We're specialists", $ef, $ee, "in that area.", $f7
    db $f0

Message_09_35::
    db $ea, "*: I'm a bug, so", $f1
    db "I'm not badly", $fa, $f7
    db $ef, $ee, "affected by poison", $ef, $ee, "or paralysis.", $f7
    db $f0

Message_09_36::
    db $ea, "*: Prince Kameha", $f1
    db "has been missing", $fa, $f7
    db $ef, $ee, "from the castle a", $ef, $ee, "long time", $a4, $fa, $f7
    db $ef, $ee, "The King thought", $ef, $ee, "it was another of", $fa, $f7
    db $ef, $ee, "the Prince's silly", $ef, $ee, "pranks at first,", $fa, $f7
    db $ef, $ee, "but he's worried", $ef, $ee, "and appears unable", $fa, $f7
    db $ef, $ee, "to concentrate on", $ef, $ee, "work now.", $fa, $f7
    db $ef, $ee, "Have you seen", $ef, $ee, "Prince Kameha?", $ff, $f0

Message_09_37::
    db $ea, "*: What's that?", $f1
    db "You saw Prince", $fa, $f7
    db $ef, $ee, "Kameha in another", $ef, $ee, "world?", $fa, $f7
    db $ef, $ee, "Come with me to", $ef, $ee, "see his Majesty!", $f7
    db $f0

Message_09_38::
    db $ea, "*: You", $44, " better be", $f1
    db "telling the truth.", $fa, $f7
    db $ef, $ee, "If you see the", $ef, $ee, "Prince, you let us", $fa, $f7
    db $ef, $ee, "know right away,", $ef, $ee, "get it?", $f7
    db $f0

Message_09_39::
    db $eb, "*: The man here has", $f1
    db "rare keys.", $fa, $f7
    db $ef, $ee, "Doesn't it intrigue", $ef, $ee, "you what sort of", $fa, $f7
    db $ef, $ee, "worlds his keys", $ef, $ee, "lead to?", $f7
    db $f0

Message_09_3A::
    db $ea, "*: Sire, this child", $f1
    db "claims to know", $fa, $f7
    db $ef, $ee, "Prince Kameha's", $ef, $ee, "whereabouts.", $f7
    db $f0

Message_09_3B::
    db $ea, "King: What's that?", $f1
    db "Is that so?", $fa, $f7
    db $ef, $ee, "Where has Kameha", $ef, $ee, "gotten to?", $fa, $f7
    db $ef, $ee, "What?", $ef, $ee, "Another world?", $fa, $f7
    db $ef, $ee, "So the rumors were", $ef, $ee, "true", $a4, $fa, $f7
    db $ef, $ee, "No wonder he could", $ef, $ee, "not be found.", $fa, $f7
    db $ef, $ee, "Well, so long as", $ef, $ee, "he is safe, it's", $fa, $f7
    db $ef, $ee, "fine. It is quiet", $ef, $ee, "when he's absent.", $fa, $f7
    db $ef, $ee, "If you see Kameha", $ef, $ee, "again, I'll ask", $fa, $f7
    db $ef, $ee, "that you let me", $ef, $ee, "know.", $fa, $f7
    db $ef, $ee, "Ah, I should also", $ef, $ee, "give you this.", $fa, $f7
    db $ef, $ee, "It's a Magic Key", $ef, $ee, "named Sky Key.", $f7
    db $f0

Message_09_3C::
    db $ea, "King: If you see", $f1
    db "Kameha again, I'll", $fa, $f7
    db $ef, $ee, "ask that you let", $ef, $ee, "me know.", $fa, $f7
    db $ef, $ee, "I realize that he", $ef, $ee, "is a mischievous", $fa, $f7
    db $ef, $ee, "handful, but I", $ef, $ee, "need your help.", $f7
    db $f0

Message_09_3D::
    db $ea, "*: Prince Kameha", $f1
    db "wandered off like", $fa, $f7
    db $ef, $ee, "a kite without its", $ef, $ee, "string", $a4, $fa, $f7
    db $ef, $ee, "Who did he take", $ef, $ee, "after", $a4, $fa, $f7
    db $ef, $ee, $a4, "Uh, never mind,", $ef, $ee, "ignore that!", $f7
    db $f0

Message_09_3E::
    db $ea, "*: You're free to", $f1
    db "go anywhere in the", $fa, $f7
    db $ef, $ee, "Castle as you see", $ef, $ee, "fit.", $fa, $f7
    db $ef, $ee, "You can visit the", $ef, $ee, "Christener on the", $fa, $f7
    db $ef, $ee, "third level to", $ef, $ee, "rename monsters.", $fa, $f7
    db $ef, $ee, "Or drop into the", $ef, $ee, "tavern on four.", $fa, $f7
    db $ef, $ee, "But don't expect", $ef, $ee, "to be served!", $f7
    db $f0

Message_09_3F::
    db $ea, "*: The King and", $f1
    db "Prince's chamber", $fa, $f7
    db $ef, $ee, "is beyond here.", $ef, $ee, "If I let you go", $fa, $f7
    db $ef, $ee, "through, I'll catch", $ef, $ee, "royal heck.", $f7
    db $f0

Message_09_40::
    db $ea, "*: Please enter.", $f1
    db "The King awaits", $fa, $f7
    db $ef, $ee, "you in the", $ef, $ee, "reception hall.", $f7
    db $f0

Message_09_41::
    db $ea, "*: This is GreatLog", $f1
    db "Castle.", $fa, $f7
    db $ef, $ee, "The reception hall", $ef, $ee, "is beyond here.", $fa, $f7
    db $ef, $ee, "The stairs will", $ef, $ee, "take you to the", $fa, $f7
    db $ef, $ee, "top of GreatLog's", $ef, $ee, "tree.", $f7
    db $f0

Message_09_42::
    db $ea, "*: The tavern just", $f1
    db "outside the Castle", $fa, $f7
    db $ef, $ee, "is frequented by", $ef, $ee, "masters.", $fa, $f7
    db $ef, $ee, "They'll offer to", $ef, $ee, "breed monsters,", $fa, $f7
    db $ef, $ee, "and they'll give", $ef, $ee, "you some tips.", $f7
    db $f0

Message_09_43::
    db $ea, "*: Hey, welcome!", $f1
    db "All masters are", $fa, $f7
    db $ef, $ee, "welcome here, even", $ef, $ee, "little kids.", $fa, $f7
    db $ef, $ee, "Skilled masters", $ef, $ee, "congregate here.", $fa, $f7
    db $ef, $ee, "You might get the", $ef, $ee, "chance to breed", $fa, $f7
    db $ef, $ee, "some monsters.", $ef, $ee, "Don't miss out.", $fa, $f7
    db $ef, $ee, "Raising monsters", $ef, $ee, "alone is tough, so", $fa, $f7
    db $ef, $ee, "don't waste any", $ef, $ee, "chance to breed.", $f7
    db $f0

Message_09_44::
    db $ea, "*: When you breed,", $f1
    db "notice a number", $fa, $f7
    db $ef, $ee, "after a plus sign", $ef, $ee, "in the name?", $fa, $f7
    db $ef, $ee, "The higher that", $ef, $ee, "number, the more", $fa, $f7
    db $ef, $ee, "the monster can", $ef, $ee, "grow.", $fa, $f7
    db $ef, $ee, "So you can level", $ef, $ee, "it up more!", $f7
    db $f0

Message_09_45::
    db $ea, "*: If you want to", $f1
    db "make a certain", $fa, $f7
    db $ef, $ee, "species stronger,", $ef, $ee, "just breed it with", $fa, $f7
    db $ef, $ee, "a monster of the", $ef, $ee, "same family.", $fa, $f7
    db $ef, $ee, "Even though the", $ef, $ee, "species remains", $fa, $f7
    db $ef, $ee, "unchanged, the", $ef, $ee, "monster will have", $fa, $f7
    db $ef, $ee, "inherited the", $ef, $ee, "partner's powers.", $f7
    db $f0

Message_09_46::
    db $ea, "*: I'm a traveling", $f1
    db "merchant.", $fa, $f7
    db $ef, $ee, "I'm also a master", $ef, $ee, "as a hobby.", $fa, $f7
    db $ef, $ee, "Listen, would you", $ef, $ee, "like to breed", $fa, $f7
    db $ef, $ee, "something with my", $ef, $ee, "SpikyBoy?", $fa, $f7
    db $ef, $ee, "If possible, I", $44, $ef, $ee, "like to breed mine", $fa, $f7
    db $ef, $ee, "with another", $ef, $ee, "SpikyBoy. Well?", $ff, $f0

Message_09_47::
    db $ea, "*: Then let's breed", $f1
    db "them!", $f7
    db $f0

Message_09_48::
    db $ea, "*: Oh, too bad.", $f1
    db "Another time.", $f7
    db $f0

Message_09_49::
    db $ea, "*: Breeding could", $f1
    db "result in monsters", $fa, $f7
    db $ef, $ee, "with skills you", $ef, $ee, "wouldn't expect.", $fa, $f7
    db $ef, $ee, "It's an added perk", $ef, $ee, "of breeding.", $f7
    db $f0

Message_09_4A::
    db $ea, "*: From up here", $f1
    db "people look like", $fa, $f7
    db $ef, $ee, "ants scurrying", $ef, $ee, "about, but they're", $fa, $f7
    db $ef, $ee, "not as big as", $ef, $ee, "ArmyAnts.", $f7
    db $f0

Message_09_4B::
    db $eb, "*: On the horizon,", $f1
    db "you can see an", $fa, $f7
    db $ef, $ee, "enormous tree like", $ef, $ee, "this one.", $fa, $f7
    db $ef, $ee, "It's the Kingdom", $ef, $ee, "of GreatTree.", $fa, $f7
    db $ef, $ee, "It's GreatLog's", $ef, $ee, "rival kingdom.", $f7
    db $f0

Message_09_4C::
    db $ea, "*: GreatLog Castle", $f1
    db "was made by", $fa, $f7
    db $ef, $ee, "hollowing out", $ef, $ee, "giant coconuts.", $fa, $f7
    db $ef, $ee, "GreatLog should", $ef, $ee, "have four in all.", $fa, $f7
    db $ef, $ee, "That means there", $ef, $ee, "must be two more", $fa, $f7
    db $ef, $ee, "coconuts below", $ef, $ee, "this level.", $f7
    db $f0

Message_09_4D::
    db $ea, "*: The island used", $f1
    db "to be lush with", $fa, $f7
    db $ef, $ee, "plants, but they", $ef, $ee, "are dying slowly", $a4, $fa, $f7
    db $ef, $ee, "Will GreatLog", $ef, $ee, "suffer that way?", $fa, $f7
    db $ef, $ee, "People don't appear", $ef, $ee, "to be concerned,", $fa, $f7
    db $ef, $ee, "but something is", $ef, $ee, "going to happen", $a4, $f7
    db $f0

Message_09_4E::
    db $ea, "*: Hello, ", $f9, "0,", $f1
    db "welcome!", $fa, $f7
    db $ef, $ee, "This is the stable", $ef, $ee, "where you can keep", $fa, $f7
    db $ef, $ee, "monsters stored,", $ef, $ee, "but hibernating.", $fa, $f7
    db $ef, $ee, "A monster won't", $ef, $ee, "gain any EX points", $fa, $f7
    db $ef, $ee, "while hibernating,", $ef, $ee, "but it also won't", $fa, $f7
    db $ef, $ee, "return to its wild", $ef, $ee, "state.", $fa, $f7
    db $ef, $ee, "Do you want to", $ef, $ee, "have a monster", $fa, $f7
    db $ef, $ee, "hibernate in the", $ef, $ee, "stable?", $f7
    db $f0

Message_09_4F::
    db $ea, "*: Hello, ", $f9, "0,", $f1
    db "welcome!", $fa, $f7
    db $ef, $ee, "Want to use the", $ef, $ee, "stable?", $f7
    db $f0

Message_09_50::
    db $ea, "*: Zzzz", $a4, " Yawn", $a4, $f1
    db "Huh?", $fa, $f7
    db $ef, $ee, "Is it morning", $ef, $ee, "already?", $f7
    db $f0

Message_09_51::
    db $ea, "*: When a ", $ac, " appears", $f1
    db "by a monster's", $fa, $f7
    db $ef, $ee, "level number, it", $ef, $ee, "stops growing.", $fa, $f7
    db $ef, $ee, "It won't learn any", $ef, $ee, "more skills too.", $fa, $f7
    db $ef, $ee, "In other words, it", $ef, $ee, "indicates that the", $fa, $f7
    db $ef, $ee, "monster has grown", $ef, $ee, "as much as it can.", $f7
    db $f0

Message_09_52::
    db $ea, "*: Our kind always", $f1
    db "stays near water.", $fa, $f7
    db $ef, $ee, "Go traveling on", $ef, $ee, "water if you want", $fa, $f7
    db $ef, $ee, "to see others like", $ef, $ee, "me.", $f7
    db $f0

Message_09_53::
    db $ea, "*: Zzz", $a4, " Zzz", $a4, $f1
    db "Zzz", $a4, " Whoops!", $fa, $f7
    db $ef, $ee, "Was I breathing", $ef, $ee, "fire there?", $f7
    db $f0

Message_09_54::
    db $ea, "*: Do you want to", $f1
    db "know how much your", $fa, $f7
    db $ef, $ee, "companions can", $ef, $ee, "grow?", $ff, $f0

Message_09_55::
    db $ea, $f9, "N's growth", $f1
    db "limit is Lv ", $f9, $4e, ".", $f7
    db $f0

Message_09_56::
    db $ea, $f9, "N has reached", $f1
    db "its growth limit.", $f7
    db $f0

Message_09_57::
    db $ea, "Once a monster", $f1
    db "reaches its growth", $fa, $f7
    db $ef, $ee, "limit, it won't", $ef, $ee, "level up anymore.", $f7
    db $f0

Message_09_58::
    db $ea, "*: Everyone has a", $f1
    db "growth limit.", $fa, $f7
    db $ef, $ee, "Whether you accept", $ef, $ee, "this or not, you", $fa, $f7
    db $ef, $ee, "can't defy the", $ef, $ee, "march of time.", $f7
    db $f0

Message_09_59::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Ssh", $a4, " Monsters are", $ef, $ee, "sleeping.", $fa, $f7
    db $ef, $ee, "Please be quiet in", $ef, $ee, "the stable.", $95, $f7
    db $f0

Message_09_5A::
    db $f9, "0 checked the", $f1
    db "casket.", $f7
    db $f0

Message_09_5B::
    db $ea, "*: Zzz", $a4, " Use the", $f1
    db "plan 'Charge' in", $fa, $f7
    db $ef, $ee, "battle to boost", $ef, $ee, "monster courage.", $95, $f7
    db $f0

Message_09_5C::
    db $ea, "*: Zzz", $a4, $f1
    db "Hnnnnnrgh", $a4, " Huh?", $fa, $f7
    db $ef, $ee, "Being 'Cautious", $95, $ef, $ee, "in battle makes", $fa, $f7
    db $ef, $ee, "monsters more", $ef, $ee, "compassionate.", $f7
    db $f0

Message_09_5D::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Watch your step!", $ef, $ee, "Monster at sleep!", $95, $f7
    db $f0

Message_09_5E::
    db $f9, "0 peered into", $f1
    db "the hole.", $f7
    db $f0

Message_09_5F::
    db $ea, "*: Zzz", $a4, " Zzz", $a4, $f1
    db "Some skills are", $fa, $f7
    db $ef, $ee, "developed from", $ef, $ee, "skills that have", $fa, $f7
    db $ef, $ee, "been learned", $ef, $ee, "already.", $f7
    db $f0

Message_09_60::
    db $eb, "*: Oh, you're the", $f1
    db "Kids Class Champ!", $fa, $f7
    db $ef, $ee, "Want to hear", $ef, $ee, "something good?", $ff, $f0

Message_09_61::
    db $eb, "*: In the C Class", $f1
    db "final, you'll be", $fa, $f7
    db $ef, $ee, "facing HammerMan", $ef, $ee, "and Stubsuck.", $fa, $f7
    db $ef, $ee, "HammerMan uses", $ef, $ee, "EvilSlash.", $fa, $f7
    db $ef, $ee, "It's one tough", $ef, $ee, "customer!", $f7
    db $f0

Message_09_62::
    db $eb, "*: Oh, you're the", $f1
    db "C Class Champ!", $fa, $f7
    db $ef, $ee, "Want to hear", $ef, $ee, "something good?", $ff, $f0

Message_09_63::
    db $eb, "*: In the B Class", $f1
    db "final, you'll face", $fa, $f7
    db $ef, $ee, "three monsters-", $ef, $ee, "HerbMan, DanceVegi", $fa, $f7
    db $ef, $ee, "and MudDoll. Watch", $ef, $ee, "out for Hustle!", $f7
    db $f0

Message_09_64::
    db $eb, "*: Oh, you're the", $f1
    db "B Class Champ!", $fa, $f7
    db $ef, $ee, "Want to hear", $ef, $ee, "something good?", $ff, $f0

Message_09_65::
    db $eb, "*: In the A Class", $f1
    db "final, you'll face", $fa, $f7
    db $ef, $ee, "MistyWing, Copycat", $ef, $ee, "and NiteWhip.", $fa, $f7
    db $ef, $ee, "Watch out for the", $ef, $ee, "skill Imitate!", $f7
    db $f0

Message_09_66::
    db $eb, "*: Oh, you're the", $f1
    db "A Class Champ!", $fa, $f7
    db $ef, $ee, "The S Class is", $ef, $ee, "next.", $fa, $f7
    db $ef, $ee, "It's the final", $ef, $ee, "battle class.", $fa, $f7
    db $ef, $ee, "It's nothing like", $ef, $ee, "what you've seen.", $fa, $f7
    db $ef, $ee, "Want to hear", $ef, $ee, "something good?", $ff, $f0

Message_09_67::
    db $eb, "*: In the S Class", $f1
    db "final, you'll face", $fa, $f7
    db $ef, $ee, "Serpentia, Orochi", $ef, $ee, "and GigaDraco.", $fa, $f7
    db $ef, $ee, "They're horribly", $ef, $ee, "strong.", $fa, $f7
    db $ef, $ee, "You'll have to", $ef, $ee, "stop their attacks", $fa, $f7
    db $ef, $ee, "to get a chance at", $ef, $ee, "winning.", $f7
    db $f0

Message_09_68::
    db $eb, "*: My Emyu is very", $f1
    db "timid.", $fa, $f7
    db $ef, $ee, "I've taken it down", $ef, $ee, "to the Coliseum,", $fa, $f7
    db $ef, $ee, "but all it does is", $ef, $ee, "take cover", $a4, $f7
    db $f0

Message_09_69::
    db $eb, "*: Wow, you've got", $f1
    db "a brave monster!", $fa, $f7
    db $ef, $ee, "Look, Emyu!", $ef, $ee, "Do you see that?", $fa, $f7
    db $ef, $ee, "That's how I want", $ef, $ee, "you to be!", $f7
    db $f0

Message_09_6A::
    db $eb, "*: Has my Emyu", $f1
    db "learned to be more", $fa, $f7
    db $ef, $ee, "brave? I really", $ef, $ee, "wonder about that", $a4, $f7
    db $f0

Message_09_6B::
    db $ea, "*: Monsters look so", $f1
    db "frightening", $a4, $fa, $f7
    db $ef, $ee, "Yes, I know, I'm", $ef, $ee, "one too, but", $a4, $fa, $f7
    db $ef, $ee, "But when one", $ef, $ee, "glares at me", $a4, $fa, $f7
    db $ef, $ee, "Just the thought", $ef, $ee, "is scary!", $f7
    db $f0

Message_09_6C::
    db $ea, "*: I should be more", $f1
    db "assertive.", $fa, $f7
    db $ef, $ee, "It's not as if I'm", $ef, $ee, "going to die.", $f7
    db $f0

Message_09_6D::
    db $ea, "*: You can call me", $f1
    db "the Medal Master.", $fa, $f7
    db $ef, $ee, "I am a collector", $ef, $ee, "of TinyMedals.", $fa, $f7
    db $ef, $ee, "I only recently", $ef, $ee, "moved to GreatLog.", $fa, $f7
    db $ef, $ee, "TinyMedals are all", $ef, $ee, "over the world.", $fa, $f7
    db $ef, $ee, "If you find any,", $ef, $ee, "can you bring them", $fa, $f7
    db $ef, $ee, "to me? I'll trade", $ef, $ee, "gifts for them.", $f7
    db $f0

Message_09_6E::
    db $ea, "*: You can call me", $f1
    db "the Medal Master.", $fa, $f7
    db $ef, $ee, "I am a collector", $ef, $ee, "of TinyMedals.", $f7
    db $f0

Message_09_6F::
    db $eb, "*: My husband loves", $f1
    db "to collect things", $fa, $f7
    db $ef, $ee, "that are of no", $ef, $ee, "value to others.", $fa, $f7
    db $ef, $ee, "TinyMedals are", $ef, $ee, "what he's after", $fa, $f7
    db $ef, $ee, "right now.", $ef, $ee, "It's a passion!", $f7
    db $f0

Message_09_70::
    db $ea, "*: I like making", $f1
    db "the Medal Master", $fa, $f7
    db $ef, $ee, "happy.", $ef, $ee, $fa, $f7
    db "If you have any", $ef, $ee, "TinyMedals can I", $fa, $f7
    db $ef, $ee, "have them?", $ff, $f0

Message_09_71::
    db $ea, "*: Yippee! Thanks a", $f1
    db "whole bunch!", $fa, $f7
    db $ef, $ee, "This will make the", $ef, $ee, "Medal Master ", $fa, $f7
    db $ef, $ee, "happy!", $ef, $ee, $f7
    db $f0

Message_09_72::
    db $ea, "*: Yippee! Thanks a", $f1
    db "whole bunch!", $fa, $f7
    db $ef, $ee, "This will make the", $ef, $ee, "Medal Master", $fa, $f7
    db $ef, $ee, "happy! ", $ef, $ee, $fa, $f7
    db "Oh? You don't have", $ef, $ee, "any TinyMedals", $a4, $f7
    db $f0

Message_09_73::
    db $ea, "*: Aww", $a4, " That's so", $f1
    db "disappointing.", $fa, $f7
    db $ef, $ee, "I wanted to please", $ef, $ee, "the Medal Master", $a4, $f7
    db $f0

Message_09_74::
    db $ea, "*: The Medal Master", $f1
    db "was famous as a", $fa, $f7
    db $ef, $ee, "monster master", $ef, $ee, "when he was young.", $fa, $f7
    db $ef, $ee, "The dresser is", $ef, $ee, "full of treasures", $fa, $f7
    db $ef, $ee, "that he collected", $ef, $ee, "back then.", $f7
    db $f0

Message_09_75::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "It overflowed with", $ef, $ee, "treasures.", $f7
    db $f0

Message_09_76::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "It overflowed with", $ef, $ee, "TinyMedals.", $fa, $f7
    db $ef, $ee, "The Medal Master", $ef, $ee, "glanced sharply,", $fa, $f7
    db $ef, $ee, "prompting ", $f9, "0 to", $ef, $ee, "close the dresser.", $f7
    db $f0

Message_09_77::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "There was an old,", $ef, $ee, "polished pot.", $f7
    db $f0

Message_09_78::
    db $ea, "Warubou: Wa-hey, I", $f1
    db "feel an odd power", $fa, $f7
    db $ef, $ee, "stirring again in", $ef, $ee, "another world.", $fa, $f7
    db $ef, $ee, "It must be the", $ef, $ee, "LightOrb, which is", $fa, $f7
    db $ef, $ee, "sealed away safely", $ef, $ee, "somewhere, warooh.", $fa, $f7
    db $ef, $ee, "Take this Sky Key", $ef, $ee, "and find it!", $f7
    db $f0

Message_09_79::
    db $f9, "0 received the", $f1
    db "Sky Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_09_7A::
    db $ea, "Warubou: Wa-hey!", $f1
    db $f9, "0 and Kameha!", $fa, $f7
    db $ef, $ee, "I share GreatLog's", $ef, $ee, "power with you!", $f7
    db $f0

Message_09_7B::
    db $ea, "Warubou: There!", $f1
    db "All healed now!", $fa, $f7
    db $ef, $ee, "There is something", $ef, $ee, "strange, warooh.", $fa, $f7
    db $ef, $ee, "I feel an odd sort", $ef, $ee, "of power coming", $fa, $f7
    db $ef, $ee, "from Limbo, but I", $ef, $ee, "can't tell if it's", $fa, $f7
    db $ef, $ee, "from anything that", $ef, $ee, "could be a plug.", $fa, $f7
    db $ef, $ee, "But no choice is", $ef, $ee, "what we have.", $fa, $f7
    db $ef, $ee, "You have to do the", $ef, $ee, "King's bidding.", $fa, $f7
    db $ef, $ee, "GreatLog's life", $ef, $ee, "force is almost", $fa, $f7
    db $ef, $ee, "all used up", $a4, $ef, $ee, "Huh?", $f7
    db $f0

Message_09_7C::
    db $ea, "Kameha: I", $a4, " I have", $f1
    db "to go back to the", $fa, $f7
    db $ef, $ee, "Castle for a", $ef, $ee, "while! Later!", $f7
    db $f0

Message_09_7D::
    db $ea, "Warubou: Wa-hey,", $f1
    db "there is little", $fa, $f7
    db $ef, $ee, "time left to us", $ef, $ee, "now.", $fa, $f7
    db $ef, $ee, $f9, "0, this is our", $ef, $ee, "last chance.", $fa, $f7
    db $ef, $ee, "If we don't find a", $ef, $ee, "proper plug this", $fa, $f7
    db $ef, $ee, "time, GreatLog is", $ef, $ee, "finished, warooh!", $f7
    db $f0

Message_09_7E::
    db $ea, "Warubou: Wa-hey,", $f1
    db "we don't have the", $fa, $f7
    db $ef, $ee, "time to be in", $ef, $ee, "shock, warooh.", $fa, $f7
    db $ef, $ee, "I have here the", $ef, $ee, "treasures that", $fa, $f7
    db $ef, $ee, "didn't work as the", $ef, $ee, "Navel's plug.", $fa, $f7
    db $ef, $ee, "Come get them when", $ef, $ee, "you are ready to", $fa, $f7
    db $ef, $ee, "leave to the world", $ef, $ee, "of Limbo, warooh.", $f7
    db $f0

Message_09_7F::
    db $eb, "*: In the C Class", $f1
    db "final, you'll be", $fa, $f7
    db $ef, $ee, "facing HammerMan", $ef, $ee, "and Stubsuck.", $fa, $f7
    db $ef, $ee, "HammerMan uses", $ef, $ee, "Heal, so you", $fa, $f7
    db $ef, $ee, "should knock it", $ef, $ee, "out first.", $f7
    db $f0

Message_09_80::
    db $eb, "*: In the B Class", $f1
    db "final, you'll face", $fa, $f7
    db $ef, $ee, "three monsters-", $ef, $ee, "HerbMan, DanceVegi", $fa, $f7
    db $ef, $ee, "and MudDoll. Watch", $ef, $ee, "out for Hustle!", $f7
    db $f0

Message_09_81::
    db $eb, "*: In the A Class", $f1
    db "final, you'll face", $fa, $f7
    db $ef, $ee, "MistyWing, Copycat", $ef, $ee, "and NiteWhip.", $fa, $f7
    db $ef, $ee, "Watch out for the", $ef, $ee, "skill Imitate!", $f7
    db $f0

Message_09_82::
    db $eb, "*: In the S Class", $f1
    db "final, you'll be", $fa, $f7
    db $ef, $ee, "facing DrakSlime,", $ef, $ee, "MetalKing and", $fa, $f7
    db $ef, $ee, "MimeSlime.", $ef, $ee, "That's the team.", $fa, $f7
    db $ef, $ee, "Don't be fooled by", $ef, $ee, "the way they look.", $fa, $f7
    db $ef, $ee, "You won't even", $ef, $ee, "scratch them if", $fa, $f7
    db $ef, $ee, "you don't attack", $ef, $ee, "them hard.", $f7
    db $f0

Message_09_83::
    db $eb, "*: ", $a4, $a4, $a4, $a4, "?", $f1
    db "You startled me", $a4, $fa, $f7
    db $ef, $ee, "I don't remember", $ef, $ee, "who I am, what I'm", $fa, $f7
    db $ef, $ee, "doing here, or", $ef, $ee, "anything else", $a4, $fa, $f7
    db $ef, $ee, "I just know that I", $ef, $ee, "need help", $a4, $fa, $f7
    db $ef, $ee, "Oh? Do you know", $ef, $ee, "who I am?", $fa, $f7
    db $ef, $ee, "Could I get you to", $ef, $ee, "take me back home?", $ff, $f0

Message_09_B6::
    db $eb, "*: You will?", $f1
    db "Thank you!", $fa, $f7
    db $ef, $ee, "Let me hide among", $ef, $ee, "your items.", $f7
    db $f0

Message_09_B7::
    db $f9, "0 obtained", $f1
    db "YunaSoul.", $f7
    db $f0

Message_09_B8::
    db $ea, "*: If you've come", $f1
    db "to entertain Lady", $fa, $f7
    db $ef, $ee, "Yuna, you", $44, " better", $ef, $ee, "hurry in.", $fa, $f7
    db $ef, $ee, "Someone else could", $ef, $ee, "win the reward!", $f7
    db $f0

Message_09_BA::
    db $ea, "*: Am I dreaming?", $f1
    db "Two Kings?", $f7
    db $f0

Message_09_BB::
    db $ea, "*: What? Why are", $f1
    db "there two Kings?", $f7
    db $f0

Message_09_BC::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "It felt just a", $ef, $ee, "little warm.", $f7
    db $f0

Message_09_BD::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'History of the", $ef, $ee, "Lake Kingdoms", $a4, $fa, $f7
    db $ef, $ee, "The three Kingdoms", $ef, $ee, "surrounding the", $fa, $f7
    db $ef, $ee, "lake were once a", $ef, $ee, "single kingdom.", $fa, $f7
    db $ef, $ee, "The three Kingdoms", $ef, $ee, "were formed when", $fa, $f7
    db $ef, $ee, "three princes were", $ef, $ee, "allowed to divide", $fa, $f7
    db $ef, $ee, "the kingdom among", $ef, $ee, "themselves.", $95, $f7
    db $f0

Message_09_BE::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'History of the", $ef, $ee, "Lake Kingdoms", $a4, $fa, $f7
    db $ef, $ee, "The elemental", $ef, $ee, "spirit in the", $fa, $f7
    db $ef, $ee, "spring is a kind-", $ef, $ee, "hearted being who", $fa, $f7
    db $ef, $ee, "has watched over", $ef, $ee, "human settlers", $fa, $f7
    db $ef, $ee, "since their", $ef, $ee, "earliest days.", $95, $f7
    db $f0

Message_09_BF::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "a noxious fluid.", $f7
    db $f0

Message_09_C0::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'History of the", $ef, $ee, "Lake Kingdoms", $a4, $fa, $f7
    db $ef, $ee, "In the middle of", $ef, $ee, "the lake is a", $fa, $f7
    db $ef, $ee, "tower made by a", $ef, $ee, "wizard.", $fa, $f7
    db $ef, $ee, "It is said to have", $ef, $ee, "been built in the", $fa, $f7
    db $ef, $ee, "distant past to", $ef, $ee, "guard treasures.", $95, $f7
    db $f0

Message_09_C1::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'History of the", $ef, $ee, "Lake Kingdoms", $a4, $fa, $f7
    db $ef, $ee, "Ringed by the", $ef, $ee, "three Kingdoms,", $fa, $f7
    db $ef, $ee, "the lake serves as", $ef, $ee, "their reservoir.", $fa, $f7
    db $ef, $ee, "It also acts as a", $ef, $ee, "road that is never", $fa, $f7
    db $ef, $ee, "blocked by snow or", $ef, $ee, "ice.", $95, $f7
    db $f0

Message_09_C2::
    db $ea, "King: The spirit", $f1
    db "made it possible", $fa, $f7
    db $ef, $ee, "for us to survive", $ef, $ee, "the harsh cold.", $fa, $f7
    db $ef, $ee, "Could I ask you to", $ef, $ee, "thank her on", $fa, $f7
    db $ef, $ee, "behalf of all of", $ef, $ee, "us?", $f7
    db $f0

Message_09_C3::
    db $ea, "*: This tunnel", $f1
    db "leads to a port.", $f7
    db $f0

Message_09_C4::
    db $ea, "*: The ice melted", $f1
    db "away!", $fa, $f7
    db $ef, $ee, "The port can be", $ef, $ee, "used again.", $f7
    db $f0

Message_09_C5::
    db $eb, "Yuna: I heard that", $f1
    db "you saved Queen", $fa, $f7
    db $ef, $ee, "Helen, isn't that", $ef, $ee, "right?", $fa, $f7
    db $ef, $ee, "That means I can", $ef, $ee, "sneak out of the", $fa, $f7
    db $ef, $ee, "Castle without", $ef, $ee, "worry again!", $f7
    db $f0

Message_09_C6::
    db $ea, "*: Queen Helen came", $f1
    db "by the other day,", $fa, $f7
    db $ef, $ee, "so I found my", $ef, $ee, "courage and said,", $fa, $f7
    db $ef, $ee, $aa, "Hello,", $aa, " to her.", $ef, $ee, "Do you know what?", $fa, $f7
    db $ef, $ee, "She gave me a", $ef, $ee, "really nice smile", $fa, $f7
    db $ef, $ee, "and said, ", $aa, "Hello,", $aa, $ef, $ee, "right back!", $f7
    db $f0

Message_09_C7::
    db $ea, "*: Queen Helen's", $f1
    db "dreams come true", $fa, $f7
    db $ef, $ee, "more often than", $ef, $ee, "not.", $f7
    db $f0
    ds $45, $00
