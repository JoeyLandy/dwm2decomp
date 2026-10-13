SECTION "Bank 2A", ROMX[$4000], BANK[$2A]
    db $2a

; message bank $2A: when wStringIndex < $95, BeginStringDisplay with this bank's table
; MessageStrings_Bank2A; otherwise far-calls BeginStringDisplay_Bank2A_Overflow (E-0080)
BeginStringDisplay_Bank2A::
    ld a, [wStringIndex]
    cp $95
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2A_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2A
    call BeginStringDisplay
    ret

; message bank $2A: when wStringIndex < $95, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2A; otherwise far-calls CopyStringToBuffer_Bank2A_Overflow (E-0080)
CopyStringToBuffer_Bank2A::
    ld a, [wStringIndex]
    cp $95
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2A_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2A
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2A_4032::
MessageStrings_Bank2A::
    dw StringList_2A_4034 ; id 0

; category list of StringCategories_2A_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_2A_4034::
    dw Message_02_00 ; id 0
    dw Message_02_01 ; id 1
    dw Message_02_02 ; id 2
    dw Message_02_03 ; id 3
    dw Message_02_04 ; id 4
    dw Message_02_05 ; id 5
    dw Message_02_06 ; id 6
    dw Message_02_07 ; id 7
    dw Message_02_08 ; id 8
    dw Message_02_09 ; id 9
    dw Message_02_0A ; id 10
    dw Message_02_0B ; id 11
    dw Message_02_0C ; id 12
    dw Message_02_0D ; id 13
    dw Message_02_0E ; id 14
    dw Message_02_0F ; id 15
    dw Message_02_10 ; id 16
    dw Message_02_11 ; id 17
    dw Message_02_12 ; id 18
    dw Message_02_13 ; id 19
    dw Message_02_14 ; id 20
    dw Message_02_15 ; id 21
    dw Message_02_16 ; id 22
    dw Message_02_17 ; id 23
    dw Message_02_17 ; id 24
    dw Message_02_17 ; id 25
    dw Message_02_17 ; id 26
    dw Message_02_17 ; id 27
    dw Message_02_1C ; id 28
    dw Message_02_1D ; id 29
    dw Message_02_1E ; id 30
    dw Message_02_1F ; id 31
    dw Message_02_20 ; id 32
    dw Message_02_21 ; id 33
    dw Message_02_22 ; id 34
    dw Message_02_23 ; id 35
    dw Message_02_24 ; id 36
    dw Message_02_25 ; id 37
    dw Message_02_26 ; id 38
    dw Message_02_27 ; id 39
    dw Message_02_28 ; id 40
    dw Message_02_29 ; id 41
    dw Message_02_2A ; id 42
    dw Message_02_2B ; id 43
    dw Message_02_2C ; id 44
    dw Message_02_2D ; id 45
    dw Message_02_2E ; id 46
    dw Message_02_2F ; id 47
    dw Message_02_30 ; id 48
    dw Message_02_31 ; id 49
    dw Message_02_32 ; id 50
    dw Message_02_33 ; id 51
    dw Message_02_34 ; id 52
    dw Message_02_35 ; id 53
    dw Message_02_36 ; id 54
    dw Message_02_37 ; id 55
    dw Message_02_38 ; id 56
    dw Message_02_39 ; id 57
    dw Message_02_3A ; id 58
    dw Message_02_3B ; id 59
    dw Message_02_3C ; id 60
    dw Message_02_3D ; id 61
    dw Message_02_3E ; id 62
    dw Message_02_3F ; id 63
    dw Message_02_40 ; id 64
    dw Message_02_41 ; id 65
    dw Message_02_42 ; id 66
    dw Message_02_43 ; id 67
    dw Message_02_44 ; id 68
    dw Message_02_45 ; id 69
    dw Message_02_46 ; id 70
    dw Message_02_47 ; id 71
    dw Message_02_48 ; id 72
    dw Message_02_49 ; id 73
    dw Message_02_4A ; id 74
    dw Message_02_4B ; id 75
    dw Message_02_4B ; id 76
    dw Message_02_4B ; id 77
    dw Message_02_4B ; id 78
    dw Message_02_4B ; id 79
    dw Message_02_4B ; id 80
    dw Message_02_4B ; id 81
    dw Message_02_4B ; id 82
    dw Message_02_4B ; id 83
    dw Message_02_4B ; id 84
    dw Message_02_4B ; id 85
    dw Message_02_56 ; id 86
    dw Message_02_57 ; id 87
    dw Message_02_58 ; id 88
    dw Message_02_59 ; id 89
    dw Message_02_5A ; id 90
    dw Message_02_5B ; id 91
    dw Message_02_5C ; id 92
    dw Message_02_5D ; id 93
    dw Message_02_5E ; id 94
    dw Message_02_5F ; id 95
    dw Message_02_60 ; id 96
    dw Message_02_61 ; id 97
    dw Message_02_62 ; id 98
    dw Message_02_63 ; id 99
    dw Message_02_64 ; id 100
    dw Message_02_65 ; id 101
    dw Message_02_66 ; id 102
    dw Message_02_67 ; id 103
    dw Message_02_68 ; id 104
    dw Message_02_69 ; id 105
    dw Message_02_6A ; id 106
    dw Message_02_6B ; id 107
    dw Message_02_6C ; id 108
    dw Message_02_6D ; id 109
    dw Message_02_6E ; id 110
    dw Message_02_6F ; id 111
    dw Message_02_70 ; id 112
    dw Message_02_71 ; id 113
    dw Message_02_72 ; id 114
    dw Message_02_73 ; id 115
    dw Message_02_74 ; id 116
    dw Message_02_75 ; id 117
    dw Message_02_76 ; id 118
    dw Message_02_77 ; id 119
    dw Message_02_78 ; id 120
    dw Message_02_79 ; id 121
    dw Message_02_7A ; id 122
    dw Message_02_7B ; id 123
    dw Message_02_7C ; id 124
    dw Message_02_7D ; id 125
    dw Message_02_7E ; id 126
    dw Message_02_7F ; id 127
    dw Message_02_80 ; id 128
    dw Message_02_81 ; id 129
    dw Message_02_82 ; id 130
    dw Message_02_83 ; id 131
    dw Message_02_84 ; id 132
    dw Message_02_85 ; id 133
    dw Message_02_86 ; id 134
    dw Message_02_87 ; id 135
    dw Message_02_88 ; id 136
    dw Message_02_89 ; id 137
    dw Message_02_8A ; id 138
    dw Message_02_8B ; id 139
    dw Message_02_8C ; id 140
    dw Message_02_8D ; id 141
    dw Message_02_8E ; id 142
    dw Message_02_8F ; id 143
    dw Message_02_90 ; id 144
    dw Message_02_91 ; id 145
    dw Message_02_92 ; id 146
    dw Message_02_93 ; id 147
    dw Message_02_94 ; id 148

Message_02_00::
    db $eb, "*: You've been going", $f1
    db "out a lot lately.", $fa, $f7
    db $ef, $ee, "Where do you go", $ef, $ee, "out to play?", $fa, $f7
    db $ef, $ee, "Oh? You're trying", $ef, $ee, "to save GreatLog?", $fa, $f7
    db $ef, $ee, "Well, my hero, how", $ef, $ee, "about an errand?", $fa, $f7
    db $ef, $ee, "Could you go buy", $ef, $ee, "LoveWater?", $fa, $f7
    db $ef, $ee, "DrakSlime is badly", $ef, $ee, "sunburned, so I", $fa, $f7
    db $ef, $ee, "need to treat its", $ef, $ee, "condition.", $fa, $f7
    db $ef, $ee, "Here's some money.", $ef, $ee, "Keep the change!", $f7
    db $f0

Message_02_01::
    db "Mom handed over", $f1
    db "200G.", $f7
    db $f0

Message_02_02::
    db $eb, "*: Buy LoveWater", $f1
    db "for me, OK?", $f7
    db $f0

Message_02_03::
    db $ea, "*: I was taking a", $f1
    db "nap in the sun", $a4, $fa, $f7
    db $ef, $ee, "I'm all sunburned!", $ef, $ee, "It hurts!", $f7
    db $f0

Message_02_04::
    db $ea, "*: A bridge to the", $f1
    db "island there will", $fa, $f7
    db $ef, $ee, "increase the farm's", $ef, $ee, "space.", $fa, $f7
    db $ef, $ee, "Beavern's helping", $ef, $ee, "with the bridge.", $f7
    db $f0

Message_02_05::
    db $eb, "*: I don't need any", $f1
    db "help today, dear.", $f7
    db $f0

Message_02_06::
    db $ea, "*: You're the child", $f1
    db "of the farmer?", $fa, $f7
    db $ef, $ee, "Under his Majesty's", $ef, $ee, "decree, there will", $fa, $f7
    db $ef, $ee, "be a tournament", $ef, $ee, "for child masters.", $fa, $f7
    db $ef, $ee, "He wishes you to", $ef, $ee, "take part.", $fa, $f7
    db $ef, $ee, "Needless to say, a", $ef, $ee, "prize awaits the", $fa, $f7
    db $ef, $ee, "champion-the", $ef, $ee, "PirateKey.", $fa, $f7
    db $ef, $ee, "I'm not good with", $ef, $ee, "this sort of work,", $fa, $f7
    db $ef, $ee, "so I'll just ask", $ef, $ee, "that you come!", $f7
    db $f0

Message_02_07::
    db $ea, "Cobi: ", $f9, "0, what", $f1
    db "was it like in the", $fa, $f7
    db $ef, $ee, "other worlds?", $ef, $ee, "I", $44, " like to know.", $fa, $f7
    db $ef, $ee, $a4, "Oh", $a4, " The TidalBell", $ef, $ee, "wasn't the right", $fa, $f7
    db $ef, $ee, "size to fit the", $ef, $ee, "Log's Navel?", $fa, $f7
    db $ef, $ee, "Are you sure you", $ef, $ee, "can do it, ", $f9, "0?", $fa, $f7
    db $ef, $ee, "Well, yes, I guess", $ef, $ee, "I did leave it up", $fa, $f7
    db $ef, $ee, "to you, ", $f9, "0.", $ef, $ee, "I believe in you.", $fa, $f7
    db $ef, $ee, "Papa expanded the", $ef, $ee, "farm, so we can", $fa, $f7
    db $ef, $ee, "look after more of", $ef, $ee, "your monsters.", $fa, $f7
    db $ef, $ee, "So, what can I do", $ef, $ee, "for you, sis?", $f7
    db $f0

Message_02_08::
    db $eb, "Tara: Big brother,", $f1
    db "have you found a", $fa, $f7
    db $ef, $ee, "new plug for the", $ef, $ee, "Log's Navel?", $fa, $f7
    db $ef, $ee, $a4, "Oh", $a4, " The TidalBell", $ef, $ee, "didn't fit", $a4, $fa, $f7
    db $ef, $ee, "But I'm sure that", $ef, $ee, "you can do it.", $fa, $f7
    db $ef, $ee, "Don't give up, big", $ef, $ee, "brother!", $fa, $f7
    db $ef, $ee, "Papa made the farm", $ef, $ee, "a little bigger,", $fa, $f7
    db $ef, $ee, "so you can leave", $ef, $ee, "more monsters.", $fa, $f7
    db $ef, $ee, "Do you need me for", $ef, $ee, "anything?", $f7
    db $f0

Message_02_09::
    db $ea, "*: Did you know?", $f1
    db "You can record in", $fa, $f7
    db $ef, $ee, "your Journal only", $ef, $ee, "in a castle, town", $fa, $f7
    db $ef, $ee, "or a village in", $ef, $ee, "other worlds.", $f7
    db $f0

Message_02_0A::
    db $ea, "*: I'm chopping some", $f1
    db "trees down to make", $fa, $f7
    db $ef, $ee, "the farm larger.", $ef, $ee, "Stay well clear.", $fa, $f7
    db $ef, $ee, "Falling timber is", $ef, $ee, "very hazardous!", $f7
    db $f0

Message_02_0B::
    db $ea, "*: Take the ladder", $f1
    db "up ahead to the", $fa, $f7
    db $ef, $ee, "Library on the", $ef, $ee, "second level.", $fa, $f7
    db $ef, $ee, "They have many", $ef, $ee, "reference books.", $fa, $f7
    db $ef, $ee, "You should go take", $ef, $ee, "a look sometime.", $f7
    db $f0

Message_02_0C::
    db $eb, "*: The castle is in", $f1
    db "an uproar because", $fa, $f7
    db $ef, $ee, "Prince Kameha has", $ef, $ee, "disappeared.", $fa, $f7
    db $ef, $ee, "I bet he's hiding", $ef, $ee, "because one of his", $fa, $f7
    db $ef, $ee, "silly pranks was", $ef, $ee, "discovered.", $f7
    db $f0

Message_02_0D::
    db $ea, "*: You're too young", $f1
    db "to be shopping.", $fa, $f7
    db $ef, $ee, "Next time, bring", $ef, $ee, "an adult, OK?", $fa, $f7
    db $ef, $ee, $a4, "Oh? An errand for", $ef, $ee, "your mother?", $fa, $f7
    db $ef, $ee, "For a youngster,", $ef, $ee, "you're obviously", $fa, $f7
    db $ef, $ee, "quite responsible.", $ef, $ee, "Sorry about that!", $fa, $f7
    db $ef, $ee, "What can I do for", $ef, $ee, "you today?", $f7
    db $f0

Message_02_0E::
    db $ea, "*: Welcome! How may", $f1
    db "I serve you today?", $f7
    db $f0

Message_02_0F::
    db $eb, "*: There are some", $f1
    db "items that can be", $fa, $f7
    db $ef, $ee, "equipped by your", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "D-Scale, which is", $ef, $ee, "sold here, is one.", $fa, $f7
    db $ef, $ee, "But it's just one", $ef, $ee, "item per monster.", $f7
    db $f0

Message_02_10::
    db $eb, "*: Oh, my", $a4, " Where", $f1
    db "did the shop go?", $fa, $f7
    db $ef, $ee, "Just when I needed", $ef, $ee, "to shop too.", $f7
    db $f0

Message_02_11::
    db $eb, "*: I hear rumors", $f1
    db "that Prince Kameha", $fa, $f7
    db $ef, $ee, "was seen near the", $ef, $ee, "Magic Door.", $fa, $f7
    db $ef, $ee, "Is that Prince", $ef, $ee, "going to spread", $fa, $f7
    db $ef, $ee, "his mischief to", $ef, $ee, "other worlds?", $f7
    db $f0

Message_02_12::
    db $eb, "*: Oh? You bought", $f1
    db "the LoveWater!", $fa, $f7
    db $ef, $ee, "This will heal", $ef, $ee, "DrakSlime!", $fa, $f7
    db $ef, $ee, "Thank you, dear!", $ef, $ee, $f7
    db $f0

Message_02_13::
    db $f9, "0 handed over", $f1
    db "the LoveWater.", $f7
    db $f0

Message_02_14::
    db $eb, "*: I'll get you to", $f1
    db "run more errands.", $fa, $f7
    db $ef, $ee, "Oh, don't look so", $ef, $ee, "glum, dear!", $f7
    db $f0

Message_02_15::
    db $ea, "*: Aooh, LoveWater", $f1
    db "soothes sunburn", $a4, $f7
    db $f0

Message_02_16::
    db $eb, "*: Play it safe", $f1
    db "against Skullroo.", $fa, $f7
    db $ef, $ee, "It's in the final", $ef, $ee, "of the Kids Class.", $fa, $f7
    db $ef, $ee, "Your monsters had", $ef, $ee, "better take cover", $fa, $f7
    db $ef, $ee, "if it starts", $ef, $ee, "charging power.", $fa, $f7
    db $ef, $ee, "Change your Plan", $ef, $ee, "to 'Defense' and", $fa, $f7
    db $ef, $ee, "your monsters may", $ef, $ee, "defend themselves.", $f7
    db $f0

Message_02_17::
    db $ea, "*: This leads to", $f1
    db "GreatLog Castle!", $fa, $f7
    db $ef, $ee, "No one enters", $ef, $ee, "without a permit!", $f7
    db $f0

Message_02_1C::
    db $eb, "*: Monsters hate", $f1
    db "being away from", $fa, $f7
    db $ef, $ee, "their master.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "They can turn", $ef, $ee, "rebellious out of", $fa, $f7
    db $ef, $ee, "sadness. Try to", $ef, $ee, "understand.", $f7
    db $f0

Message_02_1D::
    db $ea, "*: Take this slide", $f1
    db "as a shortcut!", $f7
    db $f0

Message_02_1E::
    db $ea, "*: It's easy to get", $f1
    db "down, but up? Ugh.", $f7
    db $f0

Message_02_1F::
    db $ea, "*: Do you know", $f1
    db "about LogTwig?", $fa, $f7
    db $ef, $ee, "It's an item that", $ef, $ee, "lets you move a", $fa, $f7
    db $ef, $ee, "Magic Door Shrine", $ef, $ee, "as you wish.", $fa, $f7
    db $ef, $ee, "It used to be sold", $ef, $ee, "here, but", $a4, $f7
    db $f0

Message_02_20::
    db $ea, "*: In other worlds,", $f1
    db "you'll meet other", $fa, $f7
    db $ef, $ee, "travelers like", $ef, $ee, "yourself.", $fa, $f7
    db $ef, $ee, "They're not all", $ef, $ee, "bad people, but", $fa, $f7
    db $ef, $ee, "there are some you", $ef, $ee, "need to watch.", $f7
    db $f0

Message_02_21::
    db $ea, "*: Hello there,", $f1
    db "youngster!", $fa, $f7
    db $ef, $ee, "Take these stairs", $ef, $ee, "to the Arena.", $fa, $f7
    db $ef, $ee, "Masters pit their", $ef, $ee, "trained monsters", $fa, $f7
    db $ef, $ee, "against each other", $ef, $ee, "down there.", $fa, $f7
    db $ef, $ee, "It's worth a look", $ef, $ee, "if you're a master.", $f7
    db $f0

Message_02_22::
    db $ea, "*: Hey, a little", $f1
    db "bitty master! Hi!", $fa, $f7
    db $ef, $ee, "You'll see a good", $ef, $ee, "crowd of skilled", $fa, $f7
    db $ef, $ee, "masters today in", $ef, $ee, "the Arena.", $fa, $f7
    db $ef, $ee, "It's a good chance", $ef, $ee, "to learn a few", $fa, $f7
    db $ef, $ee, "things about some", $ef, $ee, "monsters.", $f7
    db $f0

Message_02_23::
    db $ea, "*: Well, you're a", $f1
    db "mighty lively kid.", $fa, $f7
    db $ef, $ee, "Let me tell you", $ef, $ee, "something.", $fa, $f7
    db $ef, $ee, "Do you know about", $ef, $ee, "TinyMedals?", $fa, $f7
    db $ef, $ee, "They can't be sold,", $ef, $ee, "but they can be", $fa, $f7
    db $ef, $ee, "traded to a", $ef, $ee, "collector.", $fa, $f7
    db $ef, $ee, "You should store", $ef, $ee, "them in the Vault.", $f7
    db $f0

Message_02_24::
    db $eb, "*: Take care to", $f1
    db "find Tiny Medals.", $fa, $f7
    db $ef, $ee, "Look in vases and", $ef, $ee, "barrels for them.", $f7
    db $f0

Message_02_25::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "There was a plant", $ef, $ee, "sprouting inside.", $f7
    db $f0

Message_02_26::
    db "There was also a", $f1
    db "letter.", $fa, $f7
    db $ef, $ee, "'This is a gift.", $ef, $ee, "Fwohohoho!", $95, $f7
    db $f0

Message_02_27::
    db $f9, "0 checked the", $f1
    db "pedestal.", $fa, $f7
    db $ef, $ee, "It's the Library", $ef, $ee, "Guide. Read it?", $ff, $f0

Message_02_28::
    db "'You may check", $f1
    db "your Catalog of", $fa, $f7
    db $ef, $ee, "monsters in the", $ef, $ee, "Library.", $fa, $f7
    db $ef, $ee, "The monsters you", $ef, $ee, "befriend or breed", $fa, $f7
    db $ef, $ee, "are cataloged by", $ef, $ee, "family, in which", $fa, $f7
    db $ef, $ee, "individual species", $ef, $ee, "are listed.", $fa, $f7
    db $ef, $ee, "To examine your", $ef, $ee, "Catalog, please", $fa, $f7
    db $ef, $ee, "speak to the", $ef, $ee, "receptionist.", $95, $fa, $f7
    db $ef, $ee, $f9, "0 put back the", $ef, $ee, "Library Guide.", $f7
    db $f0

Message_02_29::
    db $f9, "0 put back the", $f1
    db "Library Guide.", $f7
    db $f0

Message_02_2A::
    db $eb, "*: Welcome to the", $f1
    db "Library.", $fa, $f7
    db $ef, $ee, "You may check your", $ef, $ee, "Catalog here.", $fa, $f7
    db $ef, $ee, "The Catalog is", $ef, $ee, "personalized, so", $fa, $f7
    db $ef, $ee, "it won't contain", $ef, $ee, "data on monsters", $fa, $f7
    db $ef, $ee, "that you don't", $ef, $ee, "know. Anyway", $a4, $fa, $f7
    db $ef, $ee, "Which family would", $ef, $ee, "you like to check?", $f7
    db $f0

Message_02_2B::
    db $eb, "*: Welcome to the", $f1
    db "Library.", $fa, $f7
    db $ef, $ee, "Which family would", $ef, $ee, "you like to check?", $f7
    db $f0

Message_02_2C::
    db $ea, "*: There are books", $f1
    db "that change your", $fa, $f7
    db $ef, $ee, "personality just", $ef, $ee, "by reading them.", $f7
    db $f0

Message_02_2D::
    db $eb, "*: WarpWing returns", $f1
    db "you instantly to", $fa, $f7
    db $ef, $ee, "GreatLog, so I", $ef, $ee, "take one with me", $fa, $f7
    db $ef, $ee, "when I visit other", $ef, $ee, "worlds.", $f7
    db $f0

Message_02_2E::
    db $eb, "*: Snivel", $a4, " This", $f1
    db "book is so sad", $a4, $f7
    db $f0

Message_02_2F::
    db $ea, "*: Even I can cast", $f1
    db "spells if I have", $fa, $f7
    db $ef, $ee, "the right kind of", $ef, $ee, "staff.", $f7
    db $f0

Message_02_30::
    db $eb, "*: Do you have any", $f1
    db "idea about this", $fa, $f7
    db $ef, $ee, "monster families", $ef, $ee, "business?", $ff, $f0

Message_02_31::
    db $eb, "*: Oh", $a4, " You've read", $f1
    db "this book before.", $f7
    db $f0

Message_02_32::
    db $eb, "*: Monsters can be", $f1
    db "categorized in ten", $fa, $f7
    db $ef, $ee, "groups according", $ef, $ee, "to their features.", $fa, $f7
    db $ef, $ee, "Slime, dragon,", $ef, $ee, "beast, bird,", $fa, $f7
    db $ef, $ee, "plant, bug, devil,", $ef, $ee, "material, water", $a4, $fa, $f7
    db $ef, $ee, "and", $a4, " Ah-choo!", $ef, $ee, "Excuse me!", $fa, $f7
    db $ef, $ee, "Those ten groups", $ef, $ee, "are families.", $f7
    db $f0

Message_02_33::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Monster Skills", $a4, $ef, $ee, "Every species of", $fa, $f7
    db $ef, $ee, "monsters learns", $ef, $ee, "three skills.", $95, $f7
    db $f0

Message_02_34::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Monster Growth", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "By experiencing", $f1
    db "battle, monsters", $fa, $f7
    db $ef, $ee, "will gain power", $ef, $ee, "and skills.", $95, $f7
    db $f0

Message_02_35::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Personalities of", $ef, $ee, "Monsters", $a4, $fa, $f7
    db $ef, $ee, "Personalities are", $ef, $ee, "changed by the", $fa, $f7
    db $ef, $ee, "master's battle", $ef, $ee, "plan.", $fa, $f7
    db $ef, $ee, "Personality", $ef, $ee, "affects behavior.", $95, $f7
    db $f0

Message_02_36::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Nuts and Seeds", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "ATKseed and", $ef, $ee, "MysticNut are rare", $fa, $f7
    db $ef, $ee, "items that enhance", $ef, $ee, "stats slightly.", $95, $f7
    db $f0

Message_02_37::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'WorldLeaf", $a4, $ef, $ee, "An indispensable", $fa, $f7
    db $ef, $ee, "and mystic item", $ef, $ee, "that summons the", $fa, $f7
    db $ef, $ee, "soul of any dead", $ef, $ee, "monster.", $95, $f7
    db $f0

Message_02_38::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Magic Key Guide", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Every Magic Key is", $ef, $ee, "an original that", $fa, $f7
    db $ef, $ee, "opens the door to", $ef, $ee, "another world that", $fa, $f7
    db $ef, $ee, "is unlike any", $ef, $ee, "other.", $95, $f7
    db $f0

Message_02_39::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Magic Key Guide", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Unnamed Magic Keys", $ef, $ee, "cannot be used", $fa, $f7
    db $ef, $ee, "until they are", $ef, $ee, "appraised.", $fa, $f7
    db $ef, $ee, "Otherwise, it's", $ef, $ee, "impossible to", $fa, $f7
    db $ef, $ee, "figure out its", $ef, $ee, "destination.", $95, $f7
    db $f0

Message_02_3A::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Starry Shrine", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "A sacred place", $ef, $ee, "that draws the", $fa, $f7
    db $ef, $ee, "Tree's life force", $ef, $ee, "from its roots to", $fa, $f7
    db $ef, $ee, "breed and hatch", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "From eggs come", $ef, $ee, "offspring that", $fa, $f7
    db $ef, $ee, "inherit the", $ef, $ee, "attributes and", $fa, $f7
    db $ef, $ee, "skills of its", $ef, $ee, "parents.", $95, $f7
    db $f0

Message_02_3B::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Egg Evaluators", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Those with the", $ef, $ee, "special ability to", $fa, $f7
    db $ef, $ee, "determine what", $ef, $ee, "hides in an Egg.", $fa, $f7
    db $ef, $ee, "They are also able", $ef, $ee, "to alter the", $fa, $f7
    db $ef, $ee, "gender of the Egg", $ef, $ee, "through singing.", $95, $f7
    db $f0

Message_02_3C::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Accessory Guide", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "A monster can wear", $ef, $ee, "one accessory.", $fa, $f7
    db $ef, $ee, "Accessories have", $ef, $ee, "many effects.", $95, $f7
    db $f0

Message_02_3D::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Hidden Abilities", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Monsters remain", $ef, $ee, "mysterious in many", $fa, $f7
    db $ef, $ee, "ways.They may have", $ef, $ee, "hidden abilities", $a4, $95, $f7
    db $f0

Message_02_3E::
    db $f9, "0 read the", $ef, $ee, "notice.", $fa, $f7
    db $ef, $ee, "'Please return", $ef, $ee, "books to their ", $fa, $f7
    db $ef, $ee, "proper places!", $ef, $ee, "-The Librarian.", $95, $f7
    db $f0

Message_02_3F::
    db $ea, "*: I was on my way", $f1
    db "to the Magic Door", $fa, $f7
    db $ef, $ee, "so I could go to", $ef, $ee, "another world.", $fa, $f7
    db $ef, $ee, "Warubou stopped me", $ef, $ee, "and demanded help.", $fa, $f7
    db $ef, $ee, "But, I've been", $ef, $ee, "conned enough by", $fa, $f7
    db $ef, $ee, "that prankster.", $ef, $ee, "Not this time!", $f7
    db $f0

Message_02_40::
    db $eb, "*: Pack properly if", $f1
    db "you're going off", $fa, $f7
    db $ef, $ee, "to another world.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Some have never", $ef, $ee, "returned", $a4, $f7
    db $f0

Message_02_41::
    db $ea, "*: Try the slide!", $f1
    db "It's a shortcut!", $f7
    db $f0

Message_02_42::
    db $ea, "*: My dad's a famous", $f1
    db "monster master.", $fa, $f7
    db $ef, $ee, "I'm going to be", $ef, $ee, "just like him!", $f7
    db $f0

Message_02_43::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Bookmark", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Place inside the", $ef, $ee, "Journal to record", $fa, $f7
    db $ef, $ee, "your quest in any", $ef, $ee, "location.", $95, $f7
    db $f0

Message_02_44::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Journal", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "A book that keeps", $ef, $ee, "record of your", $fa, $f7
    db $ef, $ee, "adventure.", $ef, $ee, "Can only be used", $fa, $f7
    db $ef, $ee, "in safe locations", $ef, $ee, "in other worlds.", $95, $f7
    db $f0

Message_02_45::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "colorful fruits.", $f7
    db $f0

Message_02_46::
    db $ea, "*: Hey, let me ask", $f1
    db "you something.", $fa, $f7
    db $ef, $ee, "Did you see the", $ef, $ee, "woman next door?", $ff, $f0

Message_02_47::
    db $ea, "*: Did she say", $f1
    db "anything to you?", $fa, $f7
    db $ef, $ee, "She's a nasty", $ef, $ee, "piece of work.", $fa, $f7
    db $ef, $ee, "How can she yap so", $ef, $ee, "much?", $f7
    db $f0

Message_02_48::
    db $ea, "*: Good, you're", $f1
    db "lucky!", $fa, $f7
    db $ef, $ee, "Stay away, that's", $ef, $ee, "the thing.", $f7
    db $f0

Message_02_49::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Diary", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "A girl with pretty", $ef, $ee, "eyes moved in next", $fa, $f7
    db $ef, $ee, "door. I thought I", $ef, $ee, "lucked out.", $fa, $f7
    db $ef, $ee, "But she had a", $ef, $ee, "sharp tongue", $a4, $95, $f7
    db $f0

Message_02_4A::
    db $f9, "0 checked the", $f1
    db "plush doll.", $fa, $f7
    db $ef, $ee, "It was fluffy and", $ef, $ee, "too big to hug.", $f7
    db $f0

Message_02_4B::
    db $ea, "*: The farm grew a", $f1
    db "lot bigger.", $fa, $f7
    db $ef, $ee, "Including the", $ef, $ee, "monsters with you,", $fa, $f7
    db $ef, $ee, "the farm can hold", $ef, $ee, "up to 20 now.", $fa, $f7
    db $ef, $ee, "Monsters in the", $ef, $ee, "farm earn some", $fa, $f7
    db $ef, $ee, "EX points as you", $ef, $ee, "battle.", $fa, $f7
    db $ef, $ee, "But if you leave", $ef, $ee, "them in the farm,", $fa, $f7
    db $ef, $ee, "they will grow", $ef, $ee, "without learning", $fa, $f7
    db $ef, $ee, "skills, and they", $ef, $ee, "turn disobedient.", $fa, $f7
    db $ef, $ee, "So, you should", $ef, $ee, "take different", $fa, $f7
    db $ef, $ee, "monsters out to", $ef, $ee, "train them.", $f7
    db $f0

Message_02_56::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "It was jammed with", $ef, $ee, "fancy clothing.", $f7
    db $f0

Message_02_57::
    db $eb, "*: Did you know", $f1
    db "that there's a", $fa, $f7
    db $ef, $ee, "place for changing", $ef, $ee, "monster names?", $ff, $f0

Message_02_58::
    db $eb, "*: Monsters should", $f1
    db "have cute names.", $f7
    db $f0

Message_02_59::
    db $eb, "*: Go visit the", $f1
    db "Christener.", $fa, $f7
    db $ef, $ee, "She's a lovely", $ef, $ee, "lady.", $fa, $f7
    db $ef, $ee, "She's not anything", $ef, $ee, "like that creep", $fa, $f7
    db $ef, $ee, "who lives next", $ef, $ee, "door!", $f7
    db $f0

Message_02_5A::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "It was tidily", $ef, $ee, "organized.", $f7
    db $f0

Message_02_5B::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'This is the first", $ef, $ee, "day for me alone.", $fa, $f7
    db $ef, $ee, "While moving in,", $ef, $ee, "I noticed a good", $fa, $f7
    db $ef, $ee, "looking man living", $ef, $ee, "next door.", $fa, $f7
    db $ef, $ee, "But he stared and", $ef, $ee, "whistled at me!", $fa, $f7
    db $ef, $ee, "How rude and so", $ef, $ee, "ungallant!", $95, $f7
    db $f0

Message_02_5C::
    db $f9, "0 peered into", $f1
    db "the mirror.", $fa, $f7
    db $ef, $ee, "A little girl", $ef, $ee, "peered back.", $f7
    db $f0

Message_02_5D::
    db $f9, "0 peered into", $f1
    db "the mirror.", $fa, $f7
    db $ef, $ee, "A little boy", $ef, $ee, "stared back.", $f7
    db $f0

Message_02_5E::
    db $ea, "*: My granddaughter", $f1
    db "is painfully shy.", $fa, $f7
    db $ef, $ee, "She seems so sad", $ef, $ee, "by herself", $a4, $f7
    db $f0

Message_02_5F::
    db $ea, "*: I've never seen", $f1
    db "my granddaughter", $fa, $f7
    db $ef, $ee, "so happy and full", $ef, $ee, "of life.", $fa, $f7
    db $ef, $ee, "Let me thank you", $ef, $ee, "with a gift.", $f7
    db $f0

Message_02_60::
    db $f9, "0 received", $f1
    db "a LifeAcorn.", $f7
    db $f0

Message_02_61::
    db $ea, "*: I've never seen", $f1
    db "my granddaughter", $fa, $f7
    db $ef, $ee, "so happy and full", $ef, $ee, "of life.", $fa, $f7
    db $ef, $ee, "Let me thank you", $ef, $ee, "with a gift.", $fa, $f7
    db $ef, $ee, $a4, "Oh, but you have", $ef, $ee, "no room for it.", $f7
    db $f0

Message_02_62::
    db $ea, "*: My granddaughter", $f1
    db "now insists that", $fa, $f7
    db $ef, $ee, "she will become a", $ef, $ee, "monster master.", $fa, $f7
    db $ef, $ee, "Well, whatever the", $ef, $ee, "case, I'm delighted", $fa, $f7
    db $ef, $ee, "that she is happy", $ef, $ee, "and lively.", $f7
    db $f0

Message_02_63::
    db $eb, "*: Oh", $a4, " You're so", $f1
    db "lucky to have some", $fa, $f7
    db $ef, $ee, "friends like that.", $ef, $ee, "I wish I had one.", $fa, $f7
    db $ef, $ee, "A SpotSlime would", $ef, $ee, "be so adorable", $a4, $f7
    db $f0

Message_02_64::
    db $eb, "*: Oh", $a4, " You're so", $f1
    db "lucky to have", $fa, $f7
    db $ef, $ee, "friends like that.", $ef, $ee, "I wish I had one.", $fa, $f7
    db $ef, $ee, "Your SpotSlime is", $ef, $ee, "so adorable", $a4, $fa, $f7
    db $ef, $ee, "Um", $a4, " Can I have it?", $ef, $ee, $ff, $f0

Message_02_65::
    db $eb, "*: R", $a4, " Really?", $f1
    db "Wow! Thank you!", $fa, $f7
    db $ef, $ee, "I promise, I'll", $ef, $ee, "take care of it!", $f7
    db $f0

Message_02_66::
    db $eb, "*: Oh", $a4, " Sorry", $a4, $f1
    db "It's your friend", $a4, $f7
    db $f0

Message_02_67::
    db $eb, "*: What should I do", $ef, $ee, "with Butch today", $a4, $fa, $f7
    db $ef, $ee, "That's what I named", $ef, $ee, "my SpotSlime.", $f7
    db $f0

Message_02_68::
    db $eb, "*: Yep, she's taking", $f1
    db "good care of me.", $fa, $f7
    db $ef, $ee, "But I need to get", $ef, $ee, "more exercise.", $fa, $f7
    db $ef, $ee, "I might bloat up", $ef, $ee, "to become a", $fa, $f7
    db $ef, $ee, "SpotKing!", $ef, $ee, $f7
    db $f0

Message_02_69::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "Girls' clothes", $ef, $ee, "were inside.", $f7
    db $f0

Message_02_6A::
    db $f9, "0 checked the", $f1
    db "plush doll.", $fa, $f7
    db $ef, $ee, "It had patches all", $ef, $ee, "over it.", $f7
    db $f0

Message_02_6B::
    db $eb, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "Masters pit their", $ef, $ee, "teams in battle", $fa, $f7
    db $ef, $ee, "to test their", $ef, $ee, "power.", $fa, $f7
    db $ef, $ee, "Will you enter", $ef, $ee, "your monsters?", $ff, $f0

Message_02_6C::
    db $eb, "*: You're young, so", $f1
    db "you have to start", $fa, $f7
    db $ef, $ee, "in the Kids Class.", $ef, $ee, "But don't scoff!", $fa, $f7
    db $ef, $ee, "You'll lose if", $ef, $ee, "you're complacent.", $fa, $f7
    db $ef, $ee, "Here are the", $ef, $ee, "Arena rules.", $fa, $f7
    db $ef, $ee, "You can't use any", $ef, $ee, "items in battle.", $fa, $f7
    db $ef, $ee, "And you forfeit if", $ef, $ee, "you flee.", $fa, $f7
    db $ef, $ee, "Win three battles", $ef, $ee, "to take the title.", $fa, $f7
    db $ef, $ee, "The PirateKey is", $ef, $ee, "the prize.", $f7
    db $f0

Message_02_6D::
    db $eb, "*: Oh, then you", $f1
    db "must be here to", $fa, $f7
    db $ef, $ee, "see how other", $ef, $ee, "masters battle.", $fa, $f7
    db $ef, $ee, "Take the corridor", $ef, $ee, "on the right.", $f7
    db $f0

Message_02_6E::
    db $eb, "*: You lost?", $f1
    db "That's too bad.", $fa, $f7
    db $ef, $ee, "Train some more", $ef, $ee, "and try again!", $f7
    db $f0

Message_02_6F::
    db $eb, "*: Congratulations!", $f1
    db "You're the champ!", $fa, $f7
    db $ef, $ee, "For winning the", $ef, $ee, "Kids Class, you've", $fa, $f7
    db $ef, $ee, "earned the King's", $ef, $ee, "recognition as an", $fa, $f7
    db $ef, $ee, "official monster", $ef, $ee, "master.", $fa, $f7
    db $ef, $ee, "You can now use", $ef, $ee, "the Starry Shrine", $fa, $f7
    db $ef, $ee, "and the Egg", $ef, $ee, "Evaluator.", $fa, $f7
    db $ef, $ee, "From now on, you", $ef, $ee, "will face adults", $fa, $f7
    db $ef, $ee, "in the Arena", $94, $ef, $ee, "so be sure to", $fa, $f7
    db $ef, $ee, "continue raising", $ef, $ee, "stronger monsters.", $fa, $f7
    db $ef, $ee, "Here's your prize,", $ef, $ee, "the PirateKey!", $f7
    db $f0

Message_02_70::
    db $eb, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "The rules are", $a4, $ef, $ee, "Well, you know.", $fa, $f7
    db $ef, $ee, "You'll be facing", $ef, $ee, "grownups too now.", $fa, $f7
    db $ef, $ee, "There are four", $ef, $ee, "classes in all.", $fa, $f7
    db $ef, $ee, "By becoming the", $ef, $ee, "champ of a class,", $fa, $f7
    db $ef, $ee, "you will earn a", $ef, $ee, "Magic Key.", $fa, $f7
    db $ef, $ee, "If you win the", $ef, $ee, "S Class title,", $fa, $f7
    db $ef, $ee, "you will face even", $ef, $ee, "tougher masters.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f7
    db $f0

Message_02_71::
    db $eb, "*: Hello, which", $f1
    db "Class will it be?", $f7
    db $f0

Message_02_72::
    db $eb, "*: Congratulations!", $f1
    db "You're the champ!", $fa, $f7
    db $ef, $ee, "The D Class Champ", $ef, $ee, "wins a Magic Key!", $f7
    db $f0

Message_02_73::
    db $f9, "0 received", $f1
    db "a Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_02_74::
    db $eb, "*: Oh? But your key", $f1
    db "ring is full.", $fa, $f7
    db $ef, $ee, "Make room, and", $ef, $ee, "return for this!", $f7
    db $f0

Message_02_75::
    db $eb, "*: Here's the Magic", $f1
    db "Key you won!", $f7
    db $f0

Message_02_76::
    db $eb, "*: If you want to", $f1
    db "enter, please", $fa, $f7
    db $ef, $ee, "register with the", $ef, $ee, "girl next to me.", $f7
    db $f0

Message_02_77::
    db $eb, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "hear the rules?", $ff, $f0

Message_02_78::
    db $eb, "*: Your party may", $f1
    db "enter in battles", $fa, $f7
    db $ef, $ee, "ranging from the", $ef, $ee, "C to S Class, but", $fa, $f7
    db $ef, $ee, "there is an entry", $ef, $ee, "fee per Class.", $fa, $f7
    db $ef, $ee, "Win three battles", $ef, $ee, "to take the title.", $fa, $f7
    db $ef, $ee, "A Magic Key is the", $ef, $ee, "champ's prize.", $fa, $f7
    db $ef, $ee, "You can't use any", $ef, $ee, "items in battle.", $fa, $f7
    db $ef, $ee, "And you forfeit if", $ef, $ee, "you flee.", $fa, $f7
    db $ef, $ee, "Shoot for glory as", $ef, $ee, "the S Class champ!", $f7
    db $f0

Message_02_79::
    db $eb, "*: Oops, it's not", $f1
    db "your first time!", $fa, $f7
    db $ef, $ee, "Please excuse my", $ef, $ee, "rudeness, sweetie!", $f7
    db $f0

Message_02_7A::
    db $ea, "*: Listen, this is", $f1
    db "a secret.", $fa, $f7
    db $ef, $ee, "There's a man who", $ef, $ee, "trades TinyMedals", $fa, $f7
    db $ef, $ee, "for impressive", $ef, $ee, "gifts.", $f7
    db $f0

Message_02_7B::
    db $eb, "*: Which to take?", $f1
    db "Monsters you've", $fa, $f7
    db $ef, $ee, "raised, or those", $ef, $ee, "you befriended?", $f7
    db $f0

Message_02_7C::
    db $ea, "*: You need luck on", $f1
    db "your side to win", $fa, $f7
    db $ef, $ee, "at the Arena.", $ef, $ee, "Put another way,", $fa, $f7
    db $ef, $ee, "you could win just", $ef, $ee, "by getting lucky.", $f7
    db $f0

Message_02_7D::
    db $eb, "*: What do you", $f1
    db "suppose monsters", $fa, $f7
    db $ef, $ee, "are thinking?", $ef, $ee, "I can never tell.", $fa, $f7
    db $ef, $ee, "It bothers me when", $ef, $ee, "they stare.", $fa, $f7
    db $ef, $ee, "Do they consider", $ef, $ee, "me to be food?", $f7
    db $f0

Message_02_7E::
    db $ea, "*: GRAH, HUNGRY.", $f1
    db "LOOK DELICIOUS", $a4, $f7
    db $f0

Message_02_7F::
    db $eb, "*: It's not easy to", $f1
    db "win right away.", $fa, $f7
    db $ef, $ee, "Take note of your", $ef, $ee, "opponents, and put", $fa, $f7
    db $ef, $ee, "together a winning", $ef, $ee, "team and strategy!", $f7
    db $f0

Message_02_80::
    db $eb, "*: Mama is a big", $f1
    db "worrier", $a4, $fa, $f7
    db $ef, $ee, "But she wants me", $ef, $ee, "to be a master", $a4, $fa, $f7
    db $ef, $ee, "How selfish can", $ef, $ee, "she be?", $f7
    db $f0

Message_02_81::
    db $eb, "*: Oh, a cute", $f1
    db "little master!", $fa, $f7
    db $ef, $ee, "Are you going to", $ef, $ee, "compete?", $fa, $f7
    db $ef, $ee, $a4, "Want to hear", $ef, $ee, "something useful?", $ff, $f0

Message_02_82::
    db $eb, "*: In the Kids", $f1
    db "Class final, watch", $fa, $f7
    db $ef, $ee, "out for KiteHawk.", $ef, $ee, "Monsters need to", $fa, $f7
    db $ef, $ee, "take guard if it", $ef, $ee, "charges power.", $f7
    db $f0

Message_02_83::
    db $eb, "*: Oh. Well, I'll", $f1
    db "be here for you.", $f7
    db $f0

Message_02_84::
    db $ea, "*: I come to watch", $f1
    db "every day.", $fa, $f7
    db $ef, $ee, "The masters are", $ef, $ee, "getting tougher!", $f7
    db $f0

Message_02_85::
    db $eb, "*: Monsters mirror", $f1
    db "their masters.", $fa, $f7
    db $ef, $ee, "The plans you give", $ef, $ee, "in battle", $fa, $f7
    db $ef, $ee, "gradually change", $ef, $ee, "personality.", $f7
    db $f0

Message_02_86::
    db $ea, "*: The Arena is", $f1
    db "where masters can", $fa, $f7
    db $ef, $ee, "test their mettle", $ef, $ee, "against others.", $fa, $f7
    db $ef, $ee, "Battles between", $ef, $ee, "tough masters are", $fa, $f7
    db $ef, $ee, "intense to see,", $ef, $ee, "let me tell you.", $fa, $f7
    db $ef, $ee, "The S Class is", $ef, $ee, "especially hot!", $f7
    db $f0

Message_02_87::
    db $ea, "*: Monsters can", $f1
    db "grow only so much.", $fa, $f7
    db $ef, $ee, "They won't level", $ef, $ee, "up after that.", $f7
    db $f0

Message_02_88::
    db $eb, "*: My husband is a", $f1
    db "master still.", $fa, $f7
    db $ef, $ee, "He may be old, but", $ef, $ee, "he has knowledge", $fa, $f7
    db $ef, $ee, "that the young", $ef, $ee, "people don't.", $f7
    db $f0

Message_02_89::
    db $ea, "*: Hello there.", $f1
    db "Do you know about", $fa, $f7
    db $ef, $ee, "the Starry Night", $ef, $ee, "Tournament?", $ff, $f0

Message_02_8A::
    db $ea, "*: The strongest", $f1
    db "master I've ever", $fa, $f7
    db $ef, $ee, "seen, that had to", $ef, $ee, "be GreatLog's rep", $fa, $f7
    db $ef, $ee, "in the last Starry", $ef, $ee, "Night Tournament.", $fa, $f7
    db $ef, $ee, "Her name was", $ef, $ee, "Milayou.", $fa, $f7
    db $ef, $ee, "She came so close", $ef, $ee, "to winning!", $f7
    db $f0

Message_02_8B::
    db $ea, "*: You don't know?", $f1
    db "Sorry about that.", $fa, $f7
    db $ef, $ee, "The Starry Night", $ef, $ee, "Tournament is held", $fa, $f7
    db $ef, $ee, "on the night of a", $ef, $ee, "meteor shower that", $fa, $f7
    db $ef, $ee, "arrives on every", $ef, $ee, "47th full moon.", $fa, $f7
    db $ef, $ee, "On that night,", $ef, $ee, "masters gather", $fa, $f7
    db $ef, $ee, "from all over the", $ef, $ee, "world to battle.", $fa, $f7
    db $ef, $ee, "The winner is said", $ef, $ee, "to bring great", $fa, $f7
    db $ef, $ee, "happiness to their", $ef, $ee, "home kingdom.", $f7
    db $f0

Message_02_8C::
    db $ea, "*: Listen, to win", $f1
    db "you need balance.", $fa, $f7
    db $ef, $ee, "Attack, support", $ef, $ee, "and heal-these", $fa, $f7
    db $ef, $ee, "roles should be", $ef, $ee, "assigned to your", $fa, $f7
    db $ef, $ee, "monsters in a", $ef, $ee, "balanced manner.", $fa, $f7
    db $ef, $ee, "That's the recipe", $ef, $ee, "for victory.", $f7
    db $f0

Message_02_8D::
    db $ea, "*: It's not all", $f1
    db "about winning.", $fa, $f7
    db $ef, $ee, "We should, like,", $ef, $ee, "take it easier.", $f7
    db $f0

Message_02_8E::
    db $ea, "*: Arrrrroooh!", $f1
    db "My blood burns!", $fa, $f7
    db $ef, $ee, "I can taste the", $ef, $ee, "glory of battle!", $f7
    db $f0

Message_02_8F::
    db $ea, "*: If you come", $f1
    db "across a monster", $fa, $f7
    db $ef, $ee, "that you want,", $ef, $ee, "don't be stingy.", $fa, $f7
    db $ef, $ee, "Give it lots of", $ef, $ee, "tasty meat.", $fa, $f7
    db $ef, $ee, "That will make it", $ef, $ee, "want to join you.", $f7
    db $f0

Message_02_90::
    db $ea, "*: Sirloin is the", $f1
    db "tops, harrumph!", $fa, $f7
    db $ef, $ee, "It just seems to", $ef, $ee, "melt in the mouth!", $f7
    db $f0

Message_02_91::
    db $ea, "*: I", $a4, " I didn't fall", $f1
    db "for any meat.", $fa, $f7
    db $ef, $ee, "I was impressed by", $ef, $ee, "my master", $a4, $fa, $f7
    db $ef, $ee, "Hey! Don't look", $ef, $ee, "skeptical at me!", $f7
    db $f0

Message_02_92::
    db $ea, "*: They take entry", $f1
    db "fees from masters", $fa, $f7
    db $ef, $ee, "for competing in", $ef, $ee, "the Arena.", $fa, $f7
    db $ef, $ee, "The fee goes up", $ef, $ee, "with the Class.", $fa, $f7
    db $ef, $ee, "The Kids Class is", $ef, $ee, "free to enter.", $f7
    db $f0

Message_02_93::
    db $ea, "*: If you win in", $f1
    db "the S Class, you", $fa, $f7
    db $ef, $ee, "can enter in more", $ef, $ee, "battles to earn", $fa, $f7
    db $ef, $ee, "Magic Keys and", $ef, $ee, "special items.", $fa, $f7
    db $ef, $ee, "I should become a", $ef, $ee, "master too.", $f7
    db $f0

Message_02_94::
    db $eb, "*: If you win an", $f1
    db "Arena tourney,", $fa, $f7
    db $ef, $ee, "your prize is a", $ef, $ee, "Magic Key.", $fa, $f7
    db $ef, $ee, "But you have to", $ef, $ee, "get it appraised", $fa, $f7
    db $ef, $ee, "at the Key Shop to", $ef, $ee, "use it.", $f7
    db $f0
    ds $10f, $00
