SECTION "Bank 2E", ROMX[$4000], BANK[$2E]
    db $2e

; message bank $2E: when wStringIndex < $A6, BeginStringDisplay with this bank's table
; MessageStrings_Bank2E; otherwise far-calls BeginStringDisplay_Bank2E_Overflow (E-0080)
BeginStringDisplay_Bank2E::
    ld a, [wStringIndex]
    cp $a6
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2E_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2E
    call BeginStringDisplay
    ret

; message bank $2E: when wStringIndex < $A6, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2E; otherwise far-calls CopyStringToBuffer_Bank2E_Overflow (E-0080)
CopyStringToBuffer_Bank2E::
    ld a, [wStringIndex]
    cp $a6
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2E_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2E
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2E_4032::
MessageStrings_Bank2E::
    dw StringList_2E_4034 ; id 0

; category list of StringCategories_2E_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_2E_4034::
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

Message_06_00::
    db $eb, "*: Oh!", $f7
    db $f0

Message_06_01::
    db $ea, "*: You're a human.", $f1
    db "How did you get in", $fa, $f7
    db $ef, $ee, "here? This world", $ef, $ee, "is only for elves.", $fa, $f7
    db $ef, $ee, "Get out of our", $ef, $ee, "world!", $f7
    db $f0

Message_06_02::
    db $ea, "*: Even worse, you", $f1
    db "have monsters.", $fa, $f7
    db $ef, $ee, "Get out of our", $ef, $ee, "world!", $f7
    db $f0

Message_06_03::
    db $eb, "*: Are you maybe a", $f1
    db "human?", $ff, $f0

Message_06_04::
    db $ea, "*: So Cyal took a", $f1
    db "shine to you?", $fa, $f7
    db $ef, $ee, "That means you're", $ef, $ee, "not evil.", $fa, $f7
    db $ef, $ee, "Well, fine. This", $ef, $ee, "is what we'll do.", $fa, $f7
    db $ef, $ee, "You be my sister", $ef, $ee, "Cyal's friend.", $fa, $f7
    db $ef, $ee, "If you", $44, " do that,", $ef, $ee, "I'll tell you where", $fa, $f7
    db $ef, $ee, "the Elven village", $ef, $ee, "is located.", $fa, $f7
    db $ef, $ee, "I'm Rolt, and I", $ef, $ee, "guard the forest.", $f7
    db $f0

Message_06_05::
    db $eb, "Cyal: Yay, you'll", $f1
    db "be my friend?", $fa, $f7
    db $ef, $ee, "What's your name?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, $a4, $f9, "0? We'll be", $ef, $ee, "good pals, ", $f9, "0.", $f7
    db $f0

Message_06_06::
    db $ea, "Rolt: Go south in", $f1
    db "the plains, and", $fa, $f7
    db $ef, $ee, "you'll reach our", $ef, $ee, "village.", $fa, $f7
    db $ef, $ee, $f9, "0, you really", $ef, $ee, "should go.", $f7
    db $f0

Message_06_07::
    db $eb, "Cyal: We're going", $f1
    db "back home now.", $fa, $f7
    db $ef, $ee, "Maybe we can meet", $ef, $ee, "in the village.", $f7
    db $f0

Message_06_08::
    db $ea, "*: Hello, munchkin.", $f1
    db "Enjoy your stay!", $f7
    db $f0

Message_06_09::
    db $eb, "*: A human here?", $f1
    db "It's been several", $fa, $f7
    db $ef, $ee, "centuries since", $ef, $ee, "one last visited.", $f7
    db $f0

Message_06_0A::
    db $ea, "*: You're not like", $f1
    db "us. You scare me", $a4, $f7
    db $f0

Message_06_0B::
    db $ea, "*: Hey there! I'm", $f1
    db "a talking horse.", $fa, $f7
    db $ef, $ee, "Glad to meet you,", $ef, $ee, "I'm sure.", $fa, $f7
    db $ef, $ee, "The monsters near", $ef, $ee, "the village are", $fa, $f7
    db $ef, $ee, "quite docile and", $ef, $ee, "harmless, but", $fa, $f7
    db $ef, $ee, "vicious monsters", $ef, $ee, "live farther away.", $fa, $f7
    db $ef, $ee, "It's dangerous, so", $ef, $ee, "I", $44, " stick close to", $fa, $f7
    db $ef, $ee, "the village if I", $ef, $ee, "were you.", $f7
    db $f0

Message_06_0C::
    db $eb, "*: This horse was", $f1
    db "here before us.", $f7
    db $f0

Message_06_0D::
    db $ea, "*: This is Elven", $f1
    db "village.", $fa, $f7
    db $ef, $ee, "You're a human,", $ef, $ee, "aren't you?", $f7
    db $f0

Message_06_0E::
    db $ea, "*: Welcome! How may", $f1
    db "I help you today?", $f7
    db $f0

Message_06_0F::
    db $ea, "*: Well, well", $a4, " It", $f1
    db "is a rare sight", $fa, $f7
    db $ef, $ee, "indeed to see a", $ef, $ee, "human here.", $fa, $f7
    db $ef, $ee, "I'm the Village", $ef, $ee, "Elder.", $fa, $f7
    db $ef, $ee, "By the way, have", $ef, $ee, "you seen two young", $fa, $f7
    db $ef, $ee, "elves? They are", $ef, $ee, "brother and sister", $fa, $f7
    db $ef, $ee, "and have yet to", $ef, $ee, "return from the", $fa, $f7
    db $ef, $ee, "forest in the", $ef, $ee, "north.", $f7
    db $f0

Message_06_10::
    db $ea, "*: Well, well, a", $f1
    db "human here is a", $fa, $f7
    db $ef, $ee, "rare sight to see", $ef, $ee, "indeed.", $fa, $f7
    db $ef, $ee, "What's that? You", $ef, $ee, "say Rolt told you", $fa, $f7
    db $ef, $ee, "how to find this", $ef, $ee, "village?", $fa, $f7
    db $ef, $ee, "I see. Welcome.", $ef, $ee, "You're our guests.", $f7
    db $f0

Message_06_11::
    db $ea, "Rolt: That was", $f1
    db "fast, ", $f9, "0.", $fa, $f7
    db $ef, $ee, "I was worried that", $ef, $ee, "you might be lost.", $f7
    db $f0

Message_06_12::
    db $eb, "Cyal: ", $f9, "0, let's", $f1
    db "play!", $fa, $f7
    db $ef, $ee, "I want to play", $ef, $ee, "hide and seek!", $fa, $f7
    db $ef, $ee, "I'll be waiting", $ef, $ee, "outside for you!", $f7
    db $f0

Message_06_13::
    db $ea, "*: I'm the village's", $f1
    db "elder.", $fa, $f7
    db $ef, $ee, "What's that? You", $ef, $ee, "say Rolt told you", $fa, $f7
    db $ef, $ee, "how to find this", $ef, $ee, "village?", $fa, $f7
    db $ef, $ee, "I see. Welcome.", $ef, $ee, "You're our guests.", $f7
    db $f0

Message_06_14::
    db $ea, "*: Tamed monsters,", $f1
    db "have you?", $fa, $f7
    db $ef, $ee, "That's impressive", $ef, $ee, "for a youngster.", $f7
    db $f0

Message_06_15::
    db $ea, "Rolt: ", $f9, "0, I can", $f1
    db "see that Cyal has", $fa, $f7
    db $ef, $ee, "taken a real", $ef, $ee, "liking to you.", $fa, $f7
    db $ef, $ee, "She", $44, " always looked", $ef, $ee, "forward to meeting", $fa, $f7
    db $ef, $ee, "a human, and she", $ef, $ee, "got her wish.", $fa, $f7
    db $ef, $ee, "Could you be a", $ef, $ee, "friend to her even", $fa, $f7
    db $ef, $ee, "if it's only for a", $ef, $ee, "short while?", $f7
    db $f0

Message_06_16::
    db $eb, "Cyal: Listen,", $f1
    db $f9, "0. We should", $fa, $f7
    db $ef, $ee, "go to the Elven", $ef, $ee, "forest.", $fa, $f7
    db $ef, $ee, "We can play in the", $ef, $ee, "big clearing!", $fa, $f7
    db $ef, $ee, "Do you remember?", $ef, $ee, "It's where we met.", $fa, $f7
    db $ef, $ee, "I'll go ahead, but", $ef, $ee, "don't make me wait!", $f7
    db $f0

Message_06_17::
    db $ea, "*: Cyal grew up as", $f1
    db "an orphan.", $fa, $f7
    db $ef, $ee, "Her parents were", $ef, $ee, "killed by monsters", $fa, $f7
    db $ef, $ee, "while she was", $ef, $ee, "still a baby.", $fa, $f7
    db $ef, $ee, "Rolt tries very", $ef, $ee, "hard to make sure", $fa, $f7
    db $ef, $ee, "Cyal doesn't get", $ef, $ee, "lonesome.", $fa, $f7
    db $ef, $ee, "That's why he", $ef, $ee, "pampers her.", $f7
    db $f0

Message_06_18::
    db $eb, "*: Cyal and Rolt", $f1
    db "have no family", $fa, $f7
    db $ef, $ee, "except each other.", $ef, $ee, "If you have any", $fa, $f7
    db $ef, $ee, "siblings, treat", $ef, $ee, "them with love.", $f7
    db $f0

Message_06_19::
    db $ea, "*: Cyal's parents", $f1
    db "were attacked by", $fa, $f7
    db $ef, $ee, "horrible monsters.", $ef, $ee, "They come and raid", $fa, $f7
    db $ef, $ee, "our village every", $ef, $ee, "so often.", $fa, $f7
    db $ef, $ee, "That's why we post", $ef, $ee, "lookouts around", $fa, $f7
    db $ef, $ee, "the village.", $ef, $ee, "Rolt says he will", $fa, $f7
    db $ef, $ee, "get his revenge", $ef, $ee, "one day.", $f7
    db $f0

Message_06_1B::
    db $ea, "*: I think Cyal's", $f1
    db "looking forward to", $fa, $f7
    db $ef, $ee, "playing with you", $ef, $ee, "a lot.", $f7
    db $f0

Message_06_1C::
    db $eb, "*: Humans can't be", $f1
    db "trusted, but", $a4, $fa, $f7
    db $ef, $ee, "Please watch over", $ef, $ee, "Cyal.", $f7
    db $f0

Message_06_1D::
    db $eb, "Cyal: Oh! ", $f9, "0!", $f1
    db "I'm over here!", $fa, $f7
    db $ef, $ee, "Let's play hide-", $ef, $ee, "and-seek!", $fa, $f7
    db $ef, $ee, "I'll hide, so you", $ef, $ee, "count to ten, and", $fa, $f7
    db $ef, $ee, "then come look for", $ef, $ee, "me, OK? ", $fa, $f7
    db $ef, $ee, "Ready? Start!", $ef, $ee, $f7
    db $f0

Message_06_1E::
    db $f9, "0 counted off", $a4, $f1
    db $f7
    db $f0

Message_06_1F::
    db $eb, "Cyal: Eeek, ", $f9, "0!", $f1
    db "Help me!", $f7
    db $f0

Message_06_20::
    db $ea, "*: Master AgDevil,", $f1
    db "a human, ruff!", $f7
    db $f0

Message_06_21::
    db $ea, "*: What shall we", $f1
    db "do, ruff?", $f7
    db $f0

Message_06_22::
    db $ea, "*: Human? They", $f1
    db "taste horrible", $a4, $fa, $f7
    db $ef, $ee, "You lot can have", $ef, $ee, "it, enjoy, kiki!", $fa, $f7
    db $ef, $ee, "I'll take this", $ef, $ee, "appetizing one and", $fa, $f7
    db $ef, $ee, "savor it slowly,", $ef, $ee, "kikiki!", $f7
    db $f0

Message_06_23::
    db $ea, "*: Tch, we have to", $f1
    db "eat the lousy food", $fa, $f7
    db $ef, $ee, "like we always do,", $ef, $ee, "ruff!", $f7
    db $f0

Message_06_24::
    db $ea, "*: That's what we'll", $f1
    db "do, kid.", $fa, $f7
    db $ef, $ee, "You're our dinner", $ef, $ee, "today, ruff!", $f7
    db $f0

Message_06_25::
    db $ea, "*: Tch, I can't", $f1
    db "enjoy my meal like", $fa, $f7
    db $ef, $ee, "this. I'll have my", $ef, $ee, "meal back home,", $fa, $f7
    db $ef, $ee, "kiki! Bye, you", $ef, $ee, "horrible tasting", $fa, $f7
    db $ef, $ee, "human!", $ef, $ee, $f7
    db $f0

Message_06_26::
    db $ea, "*: Huh? It's here", $f1
    db "again, ruff!", $fa, $f7
    db $ef, $ee, "It's persistent,", $ef, $ee, "ruff!", $fa, $f7
    db $ef, $ee, "This time, we'll", $ef, $ee, "show no mercy!", $fa, $f7
    db $ef, $ee, "Say your prayers,", $ef, $ee, "ruff!", $f7
    db $f0

Message_06_27::
    db $ea, "*: You've come back", $f1
    db "again, ruff?", $fa, $f7
    db $ef, $ee, "You're stupid but", $ef, $ee, "brave, ruff!", $f7
    db $f0

Message_06_28::
    db $ea, "Rolt: What? Cyal", $f1
    db "was abducted?", $fa, $f7
    db $ef, $ee, "Who did it?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "What? An AgDevil", $ef, $ee, "took my sister?", $fa, $f7
    db $ef, $ee, "That fiend!", $ef, $ee, "Arrrrgh!", $f7
    db $f0

Message_06_29::
    db $ea, "*: Rolt, wait!", $f1
    db $a4, "Gone already", $a4, $f7
    db $f0

Message_06_2A::
    db $ea, "*: AgDevil killed", $f1
    db "Rolt's parents.", $fa, $f7
    db $ef, $ee, "Rolt must have", $ef, $ee, "gone to save Cyal", $a4, $fa, $f7
    db $ef, $ee, "But no one seems", $ef, $ee, "to know exactly", $fa, $f7
    db $ef, $ee, "where the monsters", $ef, $ee, "come from.", $fa, $f7
    db $ef, $ee, "Perhaps someone in", $ef, $ee, "the lookout post", $fa, $f7
    db $ef, $ee, "would have a", $ef, $ee, "better idea", $a4, $f7
    db $f0

Message_06_2B::
    db $ea, "*: AgDevil appears", $f1
    db "to come from deep", $fa, $f7
    db $ef, $ee, "in the mountains.", $ef, $ee, "Perhaps someone in", $fa, $f7
    db $ef, $ee, "the lookout post", $ef, $ee, "would know more.", $f7
    db $f0

Message_06_2C::
    db $ea, "*: AgDevil is a", $f1
    db "total terror.", $fa, $f7
    db $ef, $ee, "We built a lookout", $ef, $ee, "post so we can", $fa, $f7
    db $ef, $ee, "keep an eye out", $ef, $ee, "for him.", $fa, $f7
    db $ef, $ee, "It's in the middle", $ef, $ee, "of the plains to", $fa, $f7
    db $ef, $ee, "the east where few", $ef, $ee, "trees grow.", $fa, $f7
    db $ef, $ee, "Someone in the", $ef, $ee, "lookout post may", $fa, $f7
    db $ef, $ee, "have an idea where", $ef, $ee, "the monsters live.", $f7
    db $f0

Message_06_2D::
    db $ea, "*: Cyal was taken", $f1
    db "away by monsters?", $fa, $f7
    db $ef, $ee, "That", $a4, " That's just", $ef, $ee, "terrible!", $fa, $f7
    db $ef, $ee, "What were the", $ef, $ee, "lookouts doing?", $fa, $f7
    db $ef, $ee, "Where is the", $ef, $ee, "lookout post?", $fa, $f7
    db $ef, $ee, "It's out in the", $ef, $ee, "east.", $f7
    db $f0

Message_06_2E::
    db $eb, "*: Didn't I ask you", $f1
    db "to protect Cyal?", $f7
    db $f0

Message_06_2F::
    db $ea, "*: This is Elven's", $f1
    db "lookout post.", $fa, $f7
    db $ef, $ee, "We stand guard to", $ef, $ee, "prevent monsters", $fa, $f7
    db $ef, $ee, "from attacking the", $ef, $ee, "village.", $fa, $f7
    db $ef, $ee, "Your monsters won't", $ef, $ee, "do anything bad?", $f7
    db $f0

Message_06_30::
    db $eb, "*: Horrid monsters", $f1
    db "that attack elves", $fa, $f7
    db $ef, $ee, "appear often in", $ef, $ee, "these parts.", $fa, $f7
    db $ef, $ee, "You can avoid", $ef, $ee, "monsters in this", $fa, $f7
    db $ef, $ee, "lookout, and Elven", $ef, $ee, "village.", $fa, $f7
    db $ef, $ee, "Those are about", $ef, $ee, "the only havens.", $f7
    db $f0

Message_06_31::
    db $ea, "*: This is the", $f1
    db "lookout post.", $fa, $f7
    db $ef, $ee, "Rolt came by a", $ef, $ee, "while ago asking", $fa, $f7
    db $ef, $ee, "about the hideouts", $ef, $ee, "of monsters.", $fa, $f7
    db $ef, $ee, "What? Cyal was", $ef, $ee, "abducted?", $fa, $f7
    db $ef, $ee, $a4, "That AgDevil, it's", $ef, $ee, "from the mountains", $fa, $f7
    db $ef, $ee, "in the north, I", $ef, $ee, "think.", $fa, $f7
    db $ef, $ee, "Go east, then turn", $ef, $ee, "north up into the", $fa, $f7
    db $ef, $ee, "mountains. It's", $ef, $ee, "around there.", $f7
    db $f0

Message_06_32::
    db $ea, "*: That AgDevil is", $ef, $ee, "from the mountains", $fa, $f7
    db $ef, $ee, "in the north, I", $ef, $ee, "think.", $fa, $f7
    db $ef, $ee, "Go east, then turn", $ef, $ee, "north up into the", $fa, $f7
    db $ef, $ee, "mountains. It's", $ef, $ee, "around there.", $f7
    db $f0

Message_06_33::
    db $eb, "*: You're not going", $f1
    db "to the northern", $fa, $f7
    db $ef, $ee, "mountains where", $ef, $ee, "the monsters live?", $fa, $f7
    db $ef, $ee, "Don't do it!", $ef, $ee, "They have no pity,", $fa, $f7
    db $ef, $ee, "not even for small", $ef, $ee, "children!", $f7
    db $f0

Message_06_34::
    db $ea, "Rolt: I've found", $f1
    db "you at last!", $fa, $f7
    db $ef, $ee, "Everything you've", $ef, $ee, "taken from us, I'm", $fa, $f7
    db $ef, $ee, "going to take back", $ef, $ee, "from you now!", $f7
    db $f0

Message_06_35::
    db $ea, "*: Kikiki, what", $f1
    db "just you?", $fa, $f7
    db $ef, $ee, "That's utterly", $ef, $ee, "laughable!", $f7
    db $f0

Message_06_36::
    db $ea, "Rolt: Shut up!", $f1
    db "Give back Cyal!", $f7
    db $f0

Message_06_37::
    db $ea, "*: Humph", $a4, $f1
    db "How boring", $a4, $f7
    db $f0

Message_06_38::
    db $ea, "Rolt: Urrrgh", $a4, $f1
    db $f9, "0", $a4, " Please", $a4, $fa, $f7
    db $ef, $ee, "Please save Cyal!", $ef, $ee, $f7
    db $f0

Message_06_39::
    db $ea, "*: The human in the", $f1
    db "forest again?", $fa, $f7
    db $ef, $ee, "You think you can", $ef, $ee, "defy me?", $fa, $f7
    db $ef, $ee, "Such a rude child!", $ef, $ee, "I'll crush you!", $f7
    db $f0

Message_06_3A::
    db $ea, "*: What, you again?", $f1
    db "Rude, rude, rude!", $f7
    db $f0

Message_06_3B::
    db $ea, "*: Wh-what? I", $a4, $f1
    db "Lost to a child?", $f7
    db $f0

Message_06_3C::
    db $ea, "Rolt: Wow", $a4, " ", $f9, "0,", $f1
    db "you're tough.", $fa, $f7
    db $ef, $ee, "Oh! Cyal!", $ef, $ee, "Where's Cyal?", $f7
    db $f0

Message_06_3D::
    db $ea, "Rolt: Cyal! Are", $f1
    db "you OK? Cyal!", $f7
    db $f0

Message_06_3E::
    db $eb, "Cyal: Big brother!", $f1
    db "I was so scared!", $f7
    db $f0

Message_06_3F::
    db $ea, "Rolt: You're safe", $f1
    db "now. ", $f9, "0 did it.", $f7
    db $f0

Message_06_40::
    db $ea, "Rolt: ", $f9, "0, I'm", $f1
    db "sorry we put you", $fa, $f7
    db $ef, $ee, "through so much", $ef, $ee, "trouble.", $fa, $f7
    db $ef, $ee, "It was my fault", $ef, $ee, "for putting you", $fa, $f7
    db $ef, $ee, "into danger.", $ef, $ee, "I'm sorry.", $fa, $f7
    db $ef, $ee, "I have to thank", $ef, $ee, "you somehow.", $fa, $f7
    db $ef, $ee, "But, let's go back", $ef, $ee, "to the village.", $f7
    db $f0

Message_06_41::
    db $ea, "*: I'm glad that", $f1
    db "Cyal and Rolt are", $fa, $f7
    db $ef, $ee, "safe. ", $f9, "0, we", $ef, $ee, "owe it all to you.", $f7
    db $f0

Message_06_42::
    db $eb, "Cyal: ", $f9, "0, thank", $f1
    db "you", $a4, $f7
    db $f0

Message_06_43::
    db $ea, "Rolt: Cyal must be", $f1
    db "a bit overwhelmed.", $fa, $f7
    db $ef, $ee, "She's happy you", $ef, $ee, "saved her, ", $f9, "0.", $f7
    db $f0

Message_06_44::
    db $ea, "*: Our gratitude is", $f1
    db "as plentiful as", $fa, $f7
    db $ef, $ee, "there are stars in", $ef, $ee, "the sky!", $f7
    db $f0

Message_06_45::
    db $ea, "Rolt: I'm going to", $f1
    db "get strong like", $fa, $f7
    db $ef, $ee, $f9, "0, and I'll", $ef, $ee, "protect Cyal!", $f7
    db $f0

Message_06_47::
    db $eb, "Cyal: I hope you'll", $f1
    db "stay my friend.", $fa, $f7
    db $ef, $ee, "Please come visit", $ef, $ee, "again.", $f7
    db $f0

Message_06_48::
    db $eb, "Cyal: I ought to", $f1
    db "become a master", $fa, $f7
    db $ef, $ee, "like you, ", $f9, "0.", $ef, $ee, "It's so dashing!", $f7
    db $f0

Message_06_49::
    db $ea, "*: We owe you a big", $f1
    db "thanks.", $fa, $f7
    db $ef, $ee, "I couldn't do a", $ef, $ee, "thing", $a4, $fa, $f7
    db $ef, $ee, "I have to become", $ef, $ee, "much stronger.", $fa, $f7
    db $ef, $ee, "I can't embarrass", $ef, $ee, "myself as a guard", $fa, $f7
    db $ef, $ee, "of the forest,", $ef, $ee, "after all.", $f7
    db $f0

Message_06_4A::
    db $eb, "*: Thanks to you,", $f1
    db "we can live in", $fa, $f7
    db $ef, $ee, "peace, free of", $ef, $ee, "fear. Thank you!", $f7
    db $f0

Message_06_4B::
    db $ea, "*: You look kind", $f1
    db "and caring.", $fa, $f7
    db $ef, $ee, "I'm sorry I said I", $ef, $ee, "was scared of you.", $f7
    db $f0

Message_06_4C::
    db $ea, "*: Brave human,", $f1
    db "hear this.", $fa, $f7
    db $ef, $ee, "The King of Plants", $ef, $ee, "rises from a rose", $fa, $f7
    db $ef, $ee, "and a giant.", $ef, $ee, "Do you understand?", $f7
    db $f0

Message_06_4D::
    db $eb, "*: The talking", $f1
    db "horse came from", $fa, $f7
    db $ef, $ee, "somewhere outside", $ef, $ee, "this world.", $fa, $f7
    db $ef, $ee, "It's a mystery", $ef, $ee, "that's beyond me.", $f7
    db $f0

Message_06_4E::
    db $ea, "*: You put down", $f1
    db "that fiend?", $fa, $f7
    db $ef, $ee, "You're tough!", $ef, $ee, "Unlike your looks.", $f7
    db $f0

Message_06_4F::
    db $eb, "*: You", $a4, " You're a", $f1
    db "savage but I must", $fa, $f7
    db $ef, $ee, "thank you as a", $ef, $ee, "courtesy.", $f7
    db $f0

Message_06_50::
    db $ea, "*: This is Elven's", $f1
    db "lookout post.", $fa, $f7
    db $ef, $ee, "We stand guard", $ef, $ee, "against monsters.", $fa, $f7
    db $ef, $ee, "But ever since you", $ef, $ee, "defeated AgDevil,", $fa, $f7
    db $ef, $ee, "it's been quiet.", $ef, $ee, "Thank you, really!", $f7
    db $f0

Message_06_51::
    db $eb, "*: Beating AgDevil", $a4, $f1
    db "That's incredible!", $fa, $f7
    db $ef, $ee, "But now that it's", $ef, $ee, "become quiet, some", $fa, $f7
    db $ef, $ee, "lookouts have been", $ef, $ee, "slacking off", $a4, $f7
    db $f0

Message_06_52::
    db $eb, "*: I've heard that", $f1
    db "humans are wild", $fa, $f7
    db $ef, $ee, "savages. Don't get", $ef, $ee, "too close to me!", $f7
    db $f0

Message_06_53::
    db $ea, "I'm the Village", $f1
    db "Elder.", $fa, $f7
    db $ef, $ee, "By the way, have", $ef, $ee, "you seen two young", $fa, $f7
    db $ef, $ee, "elves? They are", $ef, $ee, "brother and", $fa, $f7
    db $ef, $ee, "sister. They have", $ef, $ee, "yet to return", $fa, $f7
    db $ef, $ee, "from the forest in", $ef, $ee, "the north.", $f7
    db $f0

Message_06_54::
    db $ea, "*: ", $a4, "Too strong", $a4, $f1
    db "Arroooh!", $f7
    db $f0

Message_06_55::
    db $ea, "*: Not only their", $f1
    db "parents, but Cyal", $fa, $f7
    db $ef, $ee, "was taken too?", $ef, $ee, "Poor Rolt", $a4, $fa, $f7
    db $ef, $ee, "You're Cyal's", $ef, $ee, "friend, aren't you?", $fa, $f7
    db $ef, $ee, "Can't you help her?", $ef, $ee, $f7
    db $f0

Message_06_56::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "Herbs for sale.", $f7
    db $f0

Message_06_57::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "A sharp aroma of", $ef, $ee, "medicine wafted", $a4, $f7
    db $f0

Message_06_58::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "Stew simmered and", $ef, $ee, "bubbled in a pot.", $f7
    db $f0

Message_06_59::
    db $ea, "*: Hoh? Ah, excuse", $f1
    db "my incivility.", $fa, $f7
    db $ef, $ee, "It's not often we", $ef, $ee, "get visitors here.", $fa, $f7
    db $ef, $ee, "Hm, what manner of", $ef, $ee, "person are you?", $fa, $f7
    db $ef, $ee, "Having monsters as", $ef, $ee, "your chaperones.", $fa, $f7
    db $ef, $ee, "Ah, you are what,", $ef, $ee, "a monster master?", $fa, $f7
    db $ef, $ee, "Ah, I am Professor", $ef, $ee, "Kiral, by the way.", $fa, $f7
    db $ef, $ee, "Kiral: I conduct", $ef, $ee, "research here.", $fa, $f7
    db $ef, $ee, "I am in need of an", $ef, $ee, "assistant now", $a4, $fa, $f7
    db $ef, $ee, "How would you like", $ef, $ee, "to work for me?", $fa, $f7
    db $ef, $ee, "Not for free, of", $ef, $ee, "course. Well?", $ff, $f0

Message_06_5A::
    db $ea, "*: Pii", $a4, " Ggzz", $a4, $f1
    db "Piiiiii", $a4, $f7
    db $f0

Message_06_5B::
    db $ea, "Kiral: Hohoh!", $f1
    db "Grand, grand!", $fa, $f7
    db $ef, $ee, "Go fetch the", $ef, $ee, "treasure I've", $fa, $f7
    db $ef, $ee, "stored. It's", $ef, $ee, "inside a barrel in", $fa, $f7
    db $ef, $ee, "the basement room.", $ef, $ee, "Monsters have", $fa, $f7
    db $ef, $ee, "infested the lower", $ef, $ee, "levels, hence it", $fa, $f7
    db $ef, $ee, "is impossible for", $ef, $ee, "me to set foot", $fa, $f7
    db $ef, $ee, "down there.", $f7
    db $f0

Message_06_5C::
    db $ea, "Kiral: Oh! Foolish", $f1
    db "of me, I almost", $fa, $f7
    db $ef, $ee, "forgot to mention", $ef, $ee, "that there is a", $fa, $f7
    db $ef, $ee, "guard in the room", $ef, $ee, "of barrels.", $fa, $f7
    db $ef, $ee, "It may appear", $ef, $ee, "intimidating,", $fa, $f7
    db $ef, $ee, "but when it sees", $ef, $ee, "that you are in my", $fa, $f7
    db $ef, $ee, "employ, it should", $ef, $ee, "become compliant.", $fa, $f7
    db $ef, $ee, "I'm counting on", $ef, $ee, "you. Hohoh!", $f7
    db $f0

Message_06_5D::
    db $ea, "Kiral: No? ", $f1
    db "How disappointing.", $fa, $f7
    db $ef, $ee, "Your efforts would", $ef, $ee, "be rewarded.", $f7
    db $f0

Message_06_5E::
    db $ea, "Kiral: I need help", $f1
    db "with my studies.", $fa, $f7
    db $ef, $ee, "Will you help me?", $ef, $ee, $ff, $f0

Message_06_5F::
    db $ea, "Kiral: Fetch me my", $f1
    db "treasure from the", $fa, $f7
    db $ef, $ee, "barrel room in the", $ef, $ee, "basement.", $fa, $f7
    db $ef, $ee, "There is a guard", $ef, $ee, "there, but it will", $fa, $f7
    db $ef, $ee, "become docile once", $ef, $ee, "it realizes you", $fa, $f7
    db $ef, $ee, "are working on my", $ef, $ee, "behalf.", $f7
    db $f0

Message_06_60::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "A recent diary was", $ef, $ee, "found.", $fa, $f7
    db $ef, $ee, "'Monsters appeared", $ef, $ee, "in the basement.", $fa, $f7
    db $ef, $ee, "The cause remains", $ef, $ee, "unknown.", $fa, $f7
    db $ef, $ee, "The lower levels", $ef, $ee, "can't be entered.", $95, $f7
    db $f0

Message_06_61::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "A very old diary", $ef, $ee, "was found.", $fa, $f7
    db $ef, $ee, "'The treasure must", $ef, $ee, "be protected.", $fa, $f7
    db $ef, $ee, "Rob-N will be", $ef, $ee, "ideal.", $fa, $f7
    db $ef, $ee, "He can be trusted", $ef, $ee, "with the job.", $95, $f7
    db $f0

Message_06_62::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "Rolled blueprints", $ef, $ee, "were in a bundle.", $f7
    db $f0

Message_06_63::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It faintly smelled", $ef, $ee, "of mold", $a4, $f7
    db $f0

Message_06_64::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There were things", $ef, $ee, "squirming inside.", $f7
    db $f0

Message_06_65::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There was a note", $ef, $ee, "at the bottom.", $fa, $f7
    db $ef, $ee, "'The blue stone", $ef, $ee, "gives life.", $95, $f7
    db $f0

Message_06_66::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "A quite old diary", $ef, $ee, "was found.", $fa, $f7
    db $ef, $ee, "'A Roboster with", $ef, $ee, "outstanding specs", $fa, $f7
    db $ef, $ee, "was born. I gave", $ef, $ee, "it the name Rob-N.", $fa, $f7
    db $ef, $ee, "It is loyal, and", $ef, $ee, "obeys me without", $fa, $f7
    db $ef, $ee, "question or a hint", $ef, $ee, "of complaint.", $fa, $f7
    db $ef, $ee, "In fact it is too", $ef, $ee, "loyal", $a4, $95, $f7
    db $f0

Message_06_67::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "A monster had been", $ef, $ee, "lurking inside.", $fa, $f7
    db $ef, $ee, "The monster reared", $ef, $ee, "up and lunged!", $f7
    db $f0

Message_06_68::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There was nothing", $ef, $ee, "inside.", $f7
    db $f0

Message_06_69::
    db $ea, "*: PROFESSOR", $a4, " SAY", $f1
    db "GUARD", $a4, " TREASURE", $a4, $fa, $f7
    db $ef, $ee, "NEVER", $a4, " SURRENDER", $ef, $ee, "IT", $a4, " NEGATIVE", $a4, $f7
    db $f0

Message_06_6A::
    db "Roboster is acting", $f1
    db "strangely.", $fa, $f7
    db $ef, $ee, "It appears to be", $ef, $ee, "damaged somewhere.", $f7
    db $f0

Message_06_6B::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There was a blue", $ef, $ee, "shining stone.", $fa, $f7
    db $ef, $ee, $f9, "0 reached for", $ef, $ee, "the stone.", $fa, $f7
    db $ef, $ee, "Roboster sprang", $ef, $ee, "into action!", $f7
    db $f0

Message_06_6C::
    db $ea, "*: PROFESSOR", $a4, " SAY", $f1
    db "GUARD TREASURE", $a4, $f7
    db $f0

Message_06_6D::
    db $ea, "*: PRO", $a4, " SOR", $a4, " AY", $a4, $f1
    db "GGGGUARD", $a4, " TREZZZT", $a4, $f7
    db $f0

Message_06_6E::
    db "Its damage appears", $f1
    db "to have worsened.", $f7
    db $f0

Message_06_6F::
    db $ea, "*: PRO", $a4, " SOR", $a4, " AY", $a4, $f1
    db "GGGGUARD", $a4, " TREZZZT", $a4, $f7
    db $f0

Message_06_70::
    db $ea, "*: PIPIPI", $a4, $f1
    db "GGGGGGAGAGAGA", $a4, $f7
    db $f0

Message_06_71::
    db "Roboster is acting", $f1
    db "bizarrely.", $fa, $f7
    db $ef, $ee, "It appears to be", $ef, $ee, "seriously damaged.", $f7
    db $f0

Message_06_72::
    db $ea, "*: PIPIPI", $a4, $f1
    db "GGGGGGAGAGAGA", $a4, $f7
    db $f0

Message_06_73::
    db $ea, "*: PI", $a4, " PI", $a4, $f7
    db $f0

Message_06_74::
    db "Roboster is acting", $f1
    db "as if demented.", $fa, $f7
    db $ef, $ee, "It appears to be", $ef, $ee, "totally haywire.", $f7
    db $f0

Message_06_75::
    db $ea, "*: PI", $a4, " PI", $a4, $f7
    db $f0

Message_06_76::
    db $ea, "Kiral: Ah! Back!", $f1
    db "The treasure?", $fa, $f7
    db $ef, $ee, "What? A Roboster?", $ef, $ee, "Gone haywire? Ah", $a4, $fa, $f7
    db $ef, $ee, "He", $a4, " He's broken but", $ef, $ee, "he guarded the", $fa, $f7
    db $ef, $ee, "treasure all this", $ef, $ee, "time", $a4, $fa, $f7
    db $ef, $ee, "The monsters down", $ef, $ee, "there, he probably", $fa, $f7
    db $ef, $ee, "summoned to keep", $ef, $ee, "intruders away", $a4, $fa, $f7
    db $ef, $ee, "All for following", $ef, $ee, "my orders", $a4, $f7
    db $f0

Message_06_77::
    db $ea, "Kiral: Please", $a4, $f1
    db "Go stop him.", $fa, $f7
    db $ef, $ee, "He will never know", $ef, $ee, "rest, otherwise.", $fa, $f7
    db $ef, $ee, "You can get the", $ef, $ee, "treasure later.", $f7
    db $f0

Message_06_78::
    db $ea, "Kiral: Please", $a4, $f1
    db "Go stop him.", $fa, $f7
    db $ef, $ee, "You can get the", $ef, $ee, "treasure later.", $f7
    db $f0

Message_06_79::
    db $ea, "*: PROFE", $a4, " SOR", $a4, $f1
    db "ORDER", $a4, " MUST", $a4, " OBEY", $a4, $f7
    db $f0

Message_06_7A::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There was a blue", $ef, $ee, "shining stone.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, "WizStone.", $f7
    db $f0

Message_06_7B::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There was a blue", $ef, $ee, "shining stone.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it", $a4, $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "stone back.", $f7
    db $f0

Message_06_7C::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There was nothing", $ef, $ee, "inside.", $f7
    db $f0

Message_06_7D::
    db $ea, "Kiral: Ah! Back!", $f1
    db "Is", $a4, " Rob-N", $a4, $fa, $f7
    db $ef, $ee, "Did you stop him?", $ef, $ee, $a4, "You did", $a4, $fa, $f7
    db $ef, $ee, "He served as a", $ef, $ee, "guard so well", $a4, $fa, $f7
    db $ef, $ee, "I'll fix him soon.", $ef, $ee, "And the treasure?", $f7
    db $f0

Message_06_7E::
    db $f9, "0 handed over", $f1
    db "the blue stone.", $f7
    db $f0

Message_06_7F::
    db $ea, "Kiral: This stone,", $f1
    db "the WizStone, it", $fa, $f7
    db $ef, $ee, "is Roboster's fuel.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "The new type will", $ef, $ee, "become functional!", $f7
    db $f0

Message_06_80::
    db "Professor Kiral", $f1
    db "used the WizStone", $fa, $f7
    db $ef, $ee, "on a new robot.", $ef, $ee, "It began to move!", $f7
    db $f0

Message_06_81::
    db $ea, "Kiral: Yes! Yes!", $f1
    db "Success!", $fa, $f7
    db $ef, $ee, "I owe this success", $ef, $ee, "to you!", $fa, $f7
    db $ef, $ee, "Take this. It's my", $ef, $ee, "thanks to you.", $f7
    db $f0

Message_06_82::
    db $f9, "0 received the", $f1
    db "SmartBook.", $f7
    db $f0

Message_06_83::
    db $ea, "Kiral: You've been", $f1
    db "a great help.", $fa, $f7
    db $ef, $ee, "I'll study how the", $ef, $ee, "new type breeds.", $fa, $f7
    db $ef, $ee, "I'll tell you if I", $ef, $ee, "discover how.", $fa, $f7
    db $ef, $ee, "Visit me when you", $ef, $ee, "have the time.", $f7
    db $f0

Message_06_87::
    db $ea, "Kiral: Visit me", $f1
    db "when you're free.", $f7
    db $f0

Message_06_88::
    db $ea, "*: I AM THE LATEST", $f1
    db "ROBOSTER.", $fa, $f7
    db $ef, $ee, "ROBOSTER2 IS MY", $ef, $ee, "OFFICIAL NAME.", $fa, $f7
    db $ef, $ee, "BUT THE PROFESSOR", $ef, $ee, "WILL GIVE ME A NEW", $fa, $f7
    db $ef, $ee, "NAME. IT FILLS ME", $ef, $ee, "WITH ANTICIPATION.", $f7
    db $f0

Message_06_89::
    db $ea, "Kiral: Hohoh! I've", $f1
    db "got good news!", $fa, $f7
    db $ef, $ee, "Breed two Roboster", $ef, $ee, "units, and you may", $fa, $f7
    db $ef, $ee, "end up with a", $ef, $ee, "Roboster2.", $fa, $f7
    db $ef, $ee, "However, the two", $ef, $ee, "Robosters have to", $fa, $f7
    db $ef, $ee, "be modified to a", $ef, $ee, "certain degree.", $fa, $f7
    db $ef, $ee, "Otherwise, the", $ef, $ee, "breeding process", $fa, $f7
    db $ef, $ee, "ends prematurely", $ef, $ee, "with no recourse.", $f7
    db $f0

Message_06_8A::
    db $ea, "Kiral: Roboster2's", $f1
    db "skills are simply", $fa, $f7
    db $ef, $ee, "exceptional.", $ef, $ee, "It can learn the", $fa, $f7
    db $ef, $ee, "ultimate sword", $ef, $ee, "attack.", $fa, $f7
    db $ef, $ee, "It was called", $a4, $ef, $ee, "Giga-something.", $f7
    db $f0

Message_06_8B::
    db $ea, "*: MY NAME IS LEO.", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "THE PROFESSOR GAVE", $ef, $ee, "ME THAT NAME.", $fa, $f7
    db $ef, $ee, "IT SOUNDS STRONG.", $ef, $ee, "I LIKE IT.", $f7
    db $f0

Message_06_8C::
    db $ea, "*: WELCOME.", $f1
    db "I AM ROB-N.", $fa, $f7
    db $ef, $ee, "I SERVE AS THE", $ef, $ee, "PROFESSOR'S AIDE.", $f7
    db $f0

Message_06_8D::
    db $a4, "Roboster stopped", $f1
    db "moving", $a4, $f7
    db $f0

Message_06_8E::
    db "Roboster stopped", $f1
    db "moving entirely", $a4, $f7
    db $f0

Message_06_8F::
    db $ea, "*: This is the town", $f1
    db "of Miagen.", $fa, $f7
    db $ef, $ee, "It's quite an", $ef, $ee, "affluent place.", $fa, $f7
    db $ef, $ee, "But it's been a bit", $ef, $ee, "rough these days", $a4, $f7
    db $f0

Message_06_90::
    db $eb, "*: Are you friends", $f1
    db "with monsters?", $fa, $f7
    db $ef, $ee, "You're just like", $ef, $ee, "this girl Milayou.", $fa, $f7
    db $ef, $ee, "Do you know who", $ef, $ee, "she is?", $f7
    db $f0

Message_06_91::
    db $ea, "*: Wow! You have", $f1
    db "monsters! Neat!", $fa, $f7
    db $ef, $ee, "Are they strong?", $ef, $ee, "Can they beat up", $fa, $f7
    db $ef, $ee, "bad people and", $ef, $ee, "monsters?", $f7
    db $f0

Message_06_92::
    db $eb, "*: Are your", $f1
    db "monsters good?", $fa, $f7
    db $ef, $ee, "I don't like bad", $ef, $ee, "monsters!", $f7
    db $f0

Message_06_93::
    db $ea, "*: Monsters can be", $f1
    db "good or bad.", $fa, $f7
    db $ef, $ee, "Your monsters", $ef, $ee, "appear to be good.", $fa, $f7
    db $ef, $ee, "That's really", $ef, $ee, "reassuring!", $f7
    db $f0

Message_06_94::
    db $eb, "*: You appear to", $f1
    db "have the power to", $fa, $f7
    db $ef, $ee, "control monsters.", $ef, $ee, "You're just like", $fa, $f7
    db $ef, $ee, "Milayou who's over", $ef, $ee, "at the inn.", $fa, $f7
    db $ef, $ee, "You two are", $ef, $ee, "something else.", $fa, $f7
    db $ef, $ee, "Maybe I should", $ef, $ee, "copy what you do.", $f7
    db $f0

Message_06_95::
    db $ea, "*: Sigh", $a4, $f7
    db $f0

Message_06_96::
    db "The old man's sigh", $f1
    db "sounded sad", $a4, $f7
    db $f0

Message_06_97::
    db $eb, "*: Sigh", $a4, $f7
    db $f0

Message_06_98::
    db "The old woman's", $f1
    db "sigh was desolate", $a4, $f7
    db $f0

Message_06_99::
    db $ea, "*: Monsters raided", $f1
    db "this house within", $fa, $f7
    db $ef, $ee, "the last while.", $ef, $ee, "They apparently", $fa, $f7
    db $ef, $ee, "stole something of", $ef, $ee, "great importance.", $f7
    db $f0

Message_06_9A::
    db $eb, "*: The old people", $f1
    db "across the way", $fa, $f7
    db $ef, $ee, "look very sad", $ef, $ee, "recently.", $f7
    db $f0

Message_06_9B::
    db $ea, "*: Monsters have", $f1
    db "taken to attacking", $fa, $f7
    db $ef, $ee, "the town recently.", $ef, $ee, "But rather than", $fa, $f7
    db $ef, $ee, "people, they go", $ef, $ee, "after treasures.", $f7
    db $f0

Message_06_9C::
    db $eb, "*: Grrrr!", $f1
    db "I'm so angry!", $fa, $f7
    db $ef, $ee, "Monsters stole my", $ef, $ee, "lingerie!", $fa, $f7
    db $ef, $ee, "I've never seen", $ef, $ee, "such sauciness!", $f7
    db $f0

Message_06_9D::
    db $ea, "*: Hello! What may", $f1
    db "I do for you?", $f7
    db $f0

Message_06_9E::
    db $ea, "*: Welcome to our", $f1
    db "traveler's inn.", $f7
    db $f0

Message_06_9F::
    db $ea, "*: If you travel", $f1
    db "west along the", $fa, $f7
    db $ef, $ee, "plains, there is", $ef, $ee, "a hut.", $fa, $f7
    db $ef, $ee, "It should be by a", $ef, $ee, "small spring.", $fa, $f7
    db $ef, $ee, "The hut is for", $ef, $ee, "travelers and", $fa, $f7
    db $ef, $ee, "merchants to rest", $ef, $ee, "while on the road.", $f7
    db $f0

Message_06_A0::
    db $eb, "*: Excuse me, are", $f1
    db "you a master?", $fa, $f7
    db $ef, $ee, "The town has been", $ef, $ee, "having a terrible", $fa, $f7
    db $ef, $ee, "time with monsters", $ef, $ee, "attacking and", $fa, $f7
    db $ef, $ee, "stealing treasures", $ef, $ee, "from homes.", $fa, $f7
    db $ef, $ee, "I want to help the", $ef, $ee, "people here.", $fa, $f7
    db $ef, $ee, "Could I ask for", $ef, $ee, "your help too?", $fa, $f7
    db $ef, $ee, "I", $44, " like you to", $ef, $ee, "battle and punish", $fa, $f7
    db $ef, $ee, "the bad monsters.", $ef, $ee, "Well? Could you?", $ff, $f0

Message_06_A1::
    db $eb, "*: Thank you! I", $f1
    db "knew you", $44, " agree!", $fa, $f7
    db $ef, $ee, "My name's Milayou.", $ef, $ee, "I'm a master too.", $fa, $f7
    db $ef, $ee, "Milayou: First,", $ef, $ee, "you should speak", $fa, $f7
    db $ef, $ee, "with the victims", $ef, $ee, "and see how you", $fa, $f7
    db $ef, $ee, "could help them", $ef, $ee, "over the crisis.", $fa, $f7
    db $ef, $ee, "I'll investigate", $ef, $ee, "where the monsters", $fa, $f7
    db $ef, $ee, "are coming from.", $ef, $ee, "Let's meet up", $fa, $f7
    db $ef, $ee, "again later on", $ef, $ee, "back here.", $f7
    db $f0

Message_06_A2::
    db $eb, "*: I can't count on", $f1
    db "your support?", $fa, $f7
    db $ef, $ee, "That's really too", $ef, $ee, "bad", $a4, $f7
    db $f0

Message_06_A3::
    db $eb, "*: Have you changed", $f1
    db "your mind?", $fa, $f7
    db $ef, $ee, "You will help the", $ef, $ee, "people in town?", $ff, $f0

Message_06_A4::
    db $ea, "*: Could you humor", $f1
    db "this old man and", $fa, $f7
    db $ef, $ee, "hear his tale of", $ef, $ee, "woe?", $fa, $f7
    db $ef, $ee, "My daughter wedded", $ef, $ee, "a man from far", $fa, $f7
    db $ef, $ee, "away and left", $ef, $ee, "with him.", $fa, $f7
    db $ef, $ee, "A ring was the", $ef, $ee, "only memento I had", $fa, $f7
    db $ef, $ee, "of hers. Monsters", $ef, $ee, "stole it from me", $a4, $f7
    db $f0

Message_06_A5::
    db $ea, "*: My daughter", $f1
    db "wedded a man from", $fa, $f7
    db $ef, $ee, "far away and left", $ef, $ee, "with him.", $fa, $f7
    db $ef, $ee, "A ring was the", $ef, $ee, "only memento I had", $fa, $f7
    db $ef, $ee, "of hers. Monsters", $ef, $ee, "stole it from us", $a4, $f7
    db $f0
    ds $cf, $00
