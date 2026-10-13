SECTION "Bank 2B", ROMX[$4000], BANK[$2B]
    db $2b

; message bank $2B: when wStringIndex < $8A, BeginStringDisplay with this bank's table
; MessageStrings_Bank2B; otherwise far-calls BeginStringDisplay_Bank2B_Overflow (E-0080)
BeginStringDisplay_Bank2B::
    ld a, [wStringIndex]
    cp $8a
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2B_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2B
    call BeginStringDisplay
    ret

; message bank $2B: when wStringIndex < $8A, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2B; otherwise far-calls CopyStringToBuffer_Bank2B_Overflow (E-0080)
CopyStringToBuffer_Bank2B::
    ld a, [wStringIndex]
    cp $8a
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2B_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2B
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2B_4032::
MessageStrings_Bank2B::
    dw StringList_2B_4034 ; id 0

; category list of StringCategories_2B_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_2B_4034::
    dw Message_03_00 ; id 0
    dw Message_03_01 ; id 1
    dw Message_03_02 ; id 2
    dw Message_03_03 ; id 3
    dw Message_03_04 ; id 4
    dw Message_03_05 ; id 5
    dw Message_03_06 ; id 6
    dw Message_03_07 ; id 7
    dw Message_03_08 ; id 8
    dw Message_03_09 ; id 9
    dw Message_03_0A ; id 10
    dw Message_03_0B ; id 11
    dw Message_03_0C ; id 12
    dw Message_03_0D ; id 13
    dw Message_03_0E ; id 14
    dw Message_03_0F ; id 15
    dw Message_03_10 ; id 16
    dw Message_03_11 ; id 17
    dw Message_03_12 ; id 18
    dw Message_03_13 ; id 19
    dw Message_03_14 ; id 20
    dw Message_03_15 ; id 21
    dw Message_03_16 ; id 22
    dw Message_03_17 ; id 23
    dw Message_03_18 ; id 24
    dw Message_03_19 ; id 25
    dw Message_03_1A ; id 26
    dw Message_03_1B ; id 27
    dw Message_03_1C ; id 28
    dw Message_03_1D ; id 29
    dw Message_03_1E ; id 30
    dw Message_03_1F ; id 31
    dw Message_03_20 ; id 32
    dw Message_03_21 ; id 33
    dw Message_03_22 ; id 34
    dw Message_03_23 ; id 35
    dw Message_03_24 ; id 36
    dw Message_03_25 ; id 37
    dw Message_03_26 ; id 38
    dw Message_03_27 ; id 39
    dw Message_03_28 ; id 40
    dw Message_03_29 ; id 41
    dw Message_03_2A ; id 42
    dw Message_03_2B ; id 43
    dw Message_03_2C ; id 44
    dw Message_03_2D ; id 45
    dw Message_03_2E ; id 46
    dw Message_03_2F ; id 47
    dw Message_03_30 ; id 48
    dw Message_03_31 ; id 49
    dw Message_03_32 ; id 50
    dw Message_03_33 ; id 51
    dw Message_03_34 ; id 52
    dw Message_03_35 ; id 53
    dw Message_03_36 ; id 54
    dw Message_03_37 ; id 55
    dw Message_03_38 ; id 56
    dw Message_03_39 ; id 57
    dw Message_03_3A ; id 58
    dw Message_03_3B ; id 59
    dw Message_03_3C ; id 60
    dw Message_03_3D ; id 61
    dw Message_03_3E ; id 62
    dw Message_03_3F ; id 63
    dw Message_03_40 ; id 64
    dw Message_03_41 ; id 65
    dw Message_03_42 ; id 66
    dw Message_03_43 ; id 67
    dw Message_03_44 ; id 68
    dw Message_03_45 ; id 69
    dw Message_03_46 ; id 70
    dw Message_03_47 ; id 71
    dw Message_03_48 ; id 72
    dw Message_03_49 ; id 73
    dw Message_03_4A ; id 74
    dw Message_03_4B ; id 75
    dw Message_03_4C ; id 76
    dw Message_03_4D ; id 77
    dw Message_03_4E ; id 78
    dw Message_03_4F ; id 79
    dw Message_03_50 ; id 80
    dw Message_03_51 ; id 81
    dw Message_03_52 ; id 82
    dw Message_03_53 ; id 83
    dw Message_03_54 ; id 84
    dw Message_03_55 ; id 85
    dw Message_03_56 ; id 86
    dw Message_03_57 ; id 87
    dw Message_03_58 ; id 88
    dw Message_03_59 ; id 89
    dw Message_03_5A ; id 90
    dw Message_03_5B ; id 91
    dw Message_03_5C ; id 92
    dw Message_03_5D ; id 93
    dw Message_03_5E ; id 94
    dw Message_03_5F ; id 95
    dw Message_03_60 ; id 96
    dw Message_03_61 ; id 97
    dw Message_03_62 ; id 98
    dw Message_03_63 ; id 99
    dw Message_03_64 ; id 100
    dw Message_03_65 ; id 101
    dw Message_03_66 ; id 102
    dw Message_03_67 ; id 103
    dw Message_03_68 ; id 104
    dw Message_03_69 ; id 105
    dw Message_03_6A ; id 106
    dw Message_03_6B ; id 107
    dw Message_03_6C ; id 108
    dw Message_03_6D ; id 109
    dw Message_03_6E ; id 110
    dw Message_03_6F ; id 111
    dw Message_03_70 ; id 112
    dw Message_03_71 ; id 113
    dw Message_03_72 ; id 114
    dw Message_03_73 ; id 115
    dw Message_03_74 ; id 116
    dw Message_03_75 ; id 117
    dw Message_03_76 ; id 118
    dw Message_03_77 ; id 119
    dw Message_03_78 ; id 120
    dw Message_03_79 ; id 121
    dw Message_03_7A ; id 122
    dw Message_03_7B ; id 123
    dw Message_03_7C ; id 124
    dw Message_03_7D ; id 125
    dw Message_03_7E ; id 126
    dw Message_03_7F ; id 127
    dw Message_03_80 ; id 128
    dw Message_03_81 ; id 129
    dw Message_03_82 ; id 130
    dw Message_03_83 ; id 131
    dw Message_03_84 ; id 132
    dw Message_03_85 ; id 133
    dw Message_03_86 ; id 134
    dw Message_03_87 ; id 135
    dw Message_03_88 ; id 136
    dw Message_03_89 ; id 137

Message_03_00::
    db $ea, "*: This is Norden,", $f1
    db "the kingdom of the", $fa, $f7
    db $ef, $ee, "north.", $ef, $ee, $f7
    db $f0

Message_03_01::
    db $ea, "*: There are three", $f1
    db "kingdoms situated", $fa, $f7
    db $ef, $ee, "around a lake.", $ef, $ee, "They are to the", $fa, $f7
    db $ef, $ee, "north, east and", $ef, $ee, "west.", $f7
    db $f0

Message_03_02::
    db $ea, "*: Travel north", $f1
    db "along the mountain", $fa, $f7
    db $ef, $ee, "range, and you'll", $ef, $ee, "find a spring.", $fa, $f7
    db $ef, $ee, "An elemental", $ef, $ee, "spirit of great", $fa, $f7
    db $ef, $ee, "beauty is said to", $ef, $ee, "live there.", $fa, $f7
    db $ef, $ee, "She is supposed to", $ef, $ee, "be a kindly spirit", $fa, $f7
    db $ef, $ee, "who watches over", $ef, $ee, "people.", $fa, $f7
    db $ef, $ee, "I", $44, " like to see", $ef, $ee, "her before I die", $a4, $f7
    db $f0

Message_03_03::
    db $ea, "*: The winter here", $f1
    db "is harsh.", $fa, $f7
    db $ef, $ee, "Stay outside and", $ef, $ee, "your eyelashes'll", $fa, $f7
    db $ef, $ee, "freeze and clamp", $ef, $ee, "your eyes shut!", $f7
    db $f0

Message_03_04::
    db $eb, "*: Listen, did you", $f1
    db "hear?", $fa, $f7
    db $ef, $ee, "They found gold on", $ef, $ee, "the border with", $fa, $f7
    db $ef, $ee, "the kingdom in the", $ef, $ee, "west.", $fa, $f7
    db $ef, $ee, "The northern", $ef, $ee, "kingdom found it", $fa, $f7
    db $ef, $ee, "first, but the", $ef, $ee, "western kingdom is", $fa, $f7
    db $ef, $ee, "trying to hoard", $ef, $ee, "all the gold!", $f7
    db $f0

Message_03_05::
    db $ea, "*: Urrrrrgh! The", $f1
    db "western wretches!", $fa, $f7
    db $ef, $ee, "The mine on the", $ef, $ee, "border is on a", $fa, $f7
    db $ef, $ee, "rich vein of pure", $ef, $ee, "gold!", $fa, $f7
    db $ef, $ee, "We should dig up", $ef, $ee, "the gold before", $fa, $f7
    db $ef, $ee, "the westerners", $ef, $ee, "take it!", $f7
    db $f0

Message_03_06::
    db $ea, "*: Everyone's been", $f1
    db "acting strangely", $fa, $f7
    db $ef, $ee, "since they found", $ef, $ee, "gold in the mine.", $fa, $f7
    db $ef, $ee, "Even the King has", $ef, $ee, "changed", $a4, $f7
    db $f0

Message_03_07::
    db $eb, "*: The spring in", $f1
    db "the north, where", $fa, $f7
    db $ef, $ee, "the elemental", $ef, $ee, "lives, has frozen.", $fa, $f7
    db $ef, $ee, "It has never done", $ef, $ee, "that before, even", $fa, $f7
    db $ef, $ee, "in the worst cold", $ef, $ee, "spells.", $fa, $f7
    db $ef, $ee, "The spring froze", $ef, $ee, "when the gold was", $fa, $f7
    db $ef, $ee, "found. Could it be", $ef, $ee, "mere coincidence?", $f7
    db $f0

Message_03_08::
    db $ea, "*: Have you heard", $f1
    db "about the spirit", $fa, $f7
    db $ef, $ee, "in the spring?", $ef, $ee, $ff, $f0

Message_03_09::
    db $ea, "*: A long time ago", $f1
    db "the spirit made a", $fa, $f7
    db $ef, $ee, "shield using her", $ef, $ee, "mystical powers.", $fa, $f7
    db $ef, $ee, "The shield floated", $ef, $ee, "into the sky where", $fa, $f7
    db $ef, $ee, "it grew to an", $ef, $ee, "enormous size.", $fa, $f7
    db $ef, $ee, "The shield guarded", $ef, $ee, "people for many", $fa, $f7
    db $ef, $ee, "years from awful", $ef, $ee, "blizzards.", $fa, $f7
    db $ef, $ee, "Over time, the", $ef, $ee, "shield shrank back", $fa, $f7
    db $ef, $ee, "in size and fell", $ef, $ee, "from the sky.", $fa, $f7
    db $ef, $ee, "It was called the", $ef, $ee, "SkyShield.", $fa, $f7
    db $ef, $ee, "It is now interred", $ef, $ee, "in the spring.", $f7
    db $f0

Message_03_0A::
    db $ea, "*: Many years ago,", $f1
    db "our ancestors came", $fa, $f7
    db $ef, $ee, "to this land after", $ef, $ee, "a long journey.", $fa, $f7
    db $ef, $ee, "They were in a", $ef, $ee, "precarious state", $fa, $f7
    db $ef, $ee, "because of the", $ef, $ee, "vicious cold.", $fa, $f7
    db $ef, $ee, "The spring's", $ef, $ee, "spirit took pity", $fa, $f7
    db $ef, $ee, "on them and used", $ef, $ee, "her power to melt", $fa, $f7
    db $ef, $ee, "the ice and", $ef, $ee, "relieve the cold.", $fa, $f7
    db $ef, $ee, "Since then, the", $ef, $ee, "spirit has never", $fa, $f7
    db $ef, $ee, "appeared before", $ef, $ee, "us, but she still", $fa, $f7
    db $ef, $ee, "watches over us", $ef, $ee, "with compassion.", $f7
    db $f0

Message_03_0B::
    db $eb, "*: Around these", $f1
    db "parts, we get a", $fa, $f7
    db $ef, $ee, "lot of star spuds", $ef, $ee, "as our food.", $fa, $f7
    db $ef, $ee, "They're sort of", $ef, $ee, "like potatoes, but", $fa, $f7
    db $ef, $ee, "they grow by the", $ef, $ee, "light of stars.", $fa, $f7
    db $ef, $ee, "They're gifts from", $ef, $ee, "the spirit.", $fa, $f7
    db $ef, $ee, "Huh? Log's Navel?", $ef, $ee, "They're just spuds.", $f7
    db $f0

Message_03_0C::
    db $ea, "*: It's become much", $f1
    db "colder.", $fa, $f7
    db $ef, $ee, "We may need the", $ef, $ee, "help of the spirit", $fa, $f7
    db $ef, $ee, "again to break the", $ef, $ee, "cold spell.", $f7
    db $f0

Message_03_0D::
    db $ea, "*: Welcome to our", $f1
    db "church.", $fa, $f7
    db $ef, $ee, "How may I be of", $ef, $ee, "service?", $f7
    db $f0

Message_03_0E::
    db $ea, "*: His Majesty is", $f1
    db "in talks with the", $fa, $f7
    db $ef, $ee, "western kingdom's", $ef, $ee, "representatives.", $fa, $f7
    db $ef, $ee, "He has no time to", $ef, $ee, "deal with a child.", $fa, $f7
    db $ef, $ee, "Well, there was", $ef, $ee, "another kid, but", $fa, $f7
    db $ef, $ee, "he claimed to be a", $ef, $ee, "prince somewhere.", $fa, $f7
    db $ef, $ee, "We had to let him", $ef, $ee, "through.", $f7
    db $f0

Message_03_0F::
    db $ea, "*: The mine on the", $f1
    db "western border is", $fa, $f7
    db $ef, $ee, "closed right now.", $ef, $ee, "It will reopen", $fa, $f7
    db $ef, $ee, "when the trouble", $ef, $ee, "is solved.", $f7
    db $f0

Message_03_10::
    db $ea, "*: Welcome! How may", $f1
    db "I serve you today?", $f7
    db $f0

Message_03_11::
    db "*: ", $f9, "0 peered", $f1
    db "into the vase.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "lumpy potatoes.", $f7
    db $f0

Message_03_12::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "black rocks.", $f7
    db $f0

Message_03_13::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "It felt just a", $ef, $ee, "little warm.", $f7
    db $f0

Message_03_14::
    db $f9, "0 tried to", $f1
    db "open the chest.", $fa, $f7
    db $ef, $ee, "But the treasure", $ef, $ee, "chest was locked.", $f7
    db $f0

Message_03_15::
    db $ea, "*: The border is", $f1
    db "closed, so I can't", $fa, $f7
    db $ef, $ee, "get to the western", $ef, $ee, "kingdom.", $fa, $f7
    db $ef, $ee, "That's the only", $ef, $ee, "way to cross the", $fa, $f7
    db $ef, $ee, "mountains though.", $ef, $ee, "What a headache!", $f7
    db $f0

Message_03_16::
    db $f9, "0 checked the", $f1
    db "shield.", $fa, $f7
    db $ef, $ee, "A beautiful voice", $ef, $ee, "echoed.", $f7
    db $f0

Message_03_17::
    db $eb, "*: I am surprised", $f1
    db "that you hear me.", $fa, $f7
    db $ef, $ee, "You aren't from", $ef, $ee, "this world.", $fa, $f7
    db $ef, $ee, "I am the elemental", $ef, $ee, "spirit who guards", $fa, $f7
    db $ef, $ee, "over this world.", $ef, $ee, "At least I did.", $fa, $f7
    db $ef, $ee, "I had lost my", $ef, $ee, "power, you see.", $fa, $f7
    db $ef, $ee, "I was rebuilding", $ef, $ee, "my power to make", $fa, $f7
    db $ef, $ee, "my return to the", $ef, $ee, "people, but some", $fa, $f7
    db $ef, $ee, "being cast a", $ef, $ee, "shadow over the", $fa, $f7
    db $ef, $ee, "hearts of the", $ef, $ee, "people.", $fa, $f7
    db $ef, $ee, "Even my spring", $ef, $ee, "finally froze.", $fa, $f7
    db $ef, $ee, "If peace returns", $ef, $ee, "to the souls of", $fa, $f7
    db $ef, $ee, "people, I too", $ef, $ee, "will be saved.", $fa, $f7
    db $ef, $ee, "I sense a magical", $ef, $ee, "power in you.", $fa, $f7
    db $ef, $ee, "Will you restore", $ef, $ee, "peace to people?", $ff, $f0

Message_03_18::
    db $eb, "*: You will?", $f1
    db "No words of thanks", $fa, $f7
    db $ef, $ee, "can ever be enough", $ef, $ee, "for what I feel.", $fa, $f7
    db $ef, $ee, "If you restore", $ef, $ee, "this world's peace,", $fa, $f7
    db $ef, $ee, "I will give you", $ef, $ee, "this Sky Shield.", $fa, $f7
    db $ef, $ee, "Take this Crest,", $ef, $ee, "child.", $fa, $f7
    db $ef, $ee, "It shows that you", $ef, $ee, "act as my envoy.", $fa, $f7
    db $ef, $ee, "It will let you", $ef, $ee, "into castles.", $f7
    db $f0

Message_03_19::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, "Crest.", $f7
    db $f0

Message_03_1A::
    db $eb, "*: You may think", $f1
    db "terrible of me for", $fa, $f7
    db $ef, $ee, "asking you, a", $ef, $ee, "total stranger, to", $fa, $f7
    db $ef, $ee, "bear such a heavy", $ef, $ee, "burden", $a4, $fa, $f7
    db $ef, $ee, "But only you seem", $ef, $ee, "to hear my voice.", $fa, $f7
    db $ef, $ee, "Please. You are my", $ef, $ee, "only hope.", $f7
    db $f0

Message_03_1B::
    db $eb, "*: If you restore", $f1
    db "this world's peace,", $fa, $f7
    db $ef, $ee, "I will give you", $ef, $ee, "this Sky Shield.", $fa, $f7
    db $ef, $ee, "My Crest will", $ef, $ee, "allow entry into", $fa, $f7
    db $ef, $ee, "castles as my", $ef, $ee, "envoy.", $f7
    db $f0

Message_03_1C::
    db $ea, "*: What is that", $f1
    db "dirty medal?", $fa, $f7
    db $ef, $ee, "The spirit's Crest!", $ef, $ee, "You're an envoy!", $fa, $f7
    db $ef, $ee, "I beg your pardon!", $ef, $ee, $f7
    db $f0

Message_03_1D::
    db $ea, "*: Please enter,", $f1
    db "your envoyship!", $f7
    db $f0

Message_03_1E::
    db $ea, "*: His Majesty has", $f1
    db "been cranky", $a4, $fa, $f7
    db $ef, $ee, "Is the trouble at", $ef, $ee, "the mine weighing", $fa, $f7
    db $ef, $ee, "heavily on his", $ef, $ee, "mind?", $f7
    db $f0

Message_03_1F::
    db $ea, "*: After the gold", $f1
    db "discovery, our", $fa, $f7
    db $ef, $ee, "relationship with", $ef, $ee, "the west soured.", $fa, $f7
    db $ef, $ee, "It might lead to", $ef, $ee, "war", $a4, " ", $a4, "Shudder", $a4, $f7
    db $f0

Message_03_20::
    db $ea, "*: I remember the", $f1
    db "King to be placid,", $fa, $f7
    db $ef, $ee, "but he has been", $ef, $ee, "working hard as if", $fa, $f7
    db $ef, $ee, "he were possessed", $ef, $ee, "of late.", $f7
    db $f0

Message_03_21::
    db $ea, "*: Ah, you are the", $f1
    db "spirit's envoy.", $fa, $f7
    db $ef, $ee, "His Majesty is", $ef, $ee, "beyond here.", $fa, $f7
    db $ef, $ee, "I ask that you be", $ef, $ee, "on your best", $fa, $f7
    db $ef, $ee, "behavior.", $ef, $ee, $f7
    db $f0

Message_03_22::
    db $ea, "*: You're the envoy?", $f1
    db $a4, "Well, no matter!", $fa, $f7
    db $ef, $ee, "We had started", $ef, $ee, "mining the", $fa, $f7
    db $ef, $ee, "mountains on the", $ef, $ee, "border first.", $fa, $f7
    db $ef, $ee, "The west comes", $ef, $ee, "along later and", $fa, $f7
    db $ef, $ee, "demands mining", $ef, $ee, "rights?", $fa, $f7
    db $ef, $ee, "Pah! The brazen", $ef, $ee, "nerve of them!", $fa, $f7
    db $ef, $ee, "This problem is", $ef, $ee, "solved by the west", $fa, $f7
    db $ef, $ee, "abandoning their", $ef, $ee, "frivolous claim.", $fa, $f7
    db $ef, $ee, "Until then, the", $ef, $ee, "border is closed!", $f7
    db $f0

Message_03_23::
    db $ea, "*: His Majesty is", $f1
    db "furious over the", $fa, $f7
    db $ef, $ee, "western kingdom's", $ef, $ee, "conduct.", $fa, $f7
    db $ef, $ee, "He isn't open to", $ef, $ee, "reason anymore.", $f7
    db $f0

Message_03_24::
    db $ea, "*: This tunnel goes", $f1
    db "to a port.", $fa, $f7
    db $ef, $ee, "The lake is frozen", $ef, $ee, "around it though,", $fa, $f7
    db $ef, $ee, "so now it can't", $ef, $ee, "serve as a port.", $f7
    db $f0

Message_03_25::
    db $ea, "*: This is the port", $f1
    db "of Nofor.", $f7
    db $f0

Message_03_26::
    db $ea, "*: It's useless!", $f1
    db "Beyond useless!", $fa, $f7
    db $ef, $ee, "The ice has the", $ef, $ee, "port clogged.", $fa, $f7
    db $ef, $ee, "No ships can sail.", $ef, $ee, "I'll go bankrupt!", $f7
    db $f0

Message_03_27::
    db $ea, "*: In all my years,", $f1
    db "I've never seen", $fa, $f7
    db $ef, $ee, "the port frozen in", $ef, $ee, "like that.", $f7
    db $f0

Message_03_28::
    db $eb, "*: Three kingdoms", $f1
    db "ring this lake.", $fa, $f7
    db $ef, $ee, "They are in the", $ef, $ee, "north, west and", $fa, $f7
    db $ef, $ee, "east of the", $ef, $ee, "inland sea.", $fa, $f7
    db $ef, $ee, "The east is ruled", $ef, $ee, "by Queen Helen.", $fa, $f7
    db $ef, $ee, "She foresees the", $ef, $ee, "future in her", $fa, $f7
    db $ef, $ee, "dreams with", $ef, $ee, "amazing accuracy.", $f7
    db $f0

Message_03_29::
    db $ea, "*: The border?", $f1
    db "It's not here.", $fa, $f7
    db $ef, $ee, "The border is at", $ef, $ee, "the gold mine.", $fa, $f7
    db $ef, $ee, "Go back up through", $ef, $ee, "the tunnel, and go", $fa, $f7
    db $ef, $ee, "southwest along", $ef, $ee, "the mountains.", $f7
    db $f0

Message_03_2A::
    db $ea, "*: Mama said to", $f1
    db "stay off the ice.", $fa, $f7
    db $ef, $ee, "It can break if", $ef, $ee, "it's too thin.", $f7
    db $f0

Message_03_2B::
    db $ea, "*: We were passing", $f1
    db "through from the", $fa, $f7
    db $ef, $ee, "east, but the ice", $ef, $ee, "sealed us in.", $fa, $f7
    db $ef, $ee, "We've been stuck", $ef, $ee, "here a month.", $f7
    db $f0

Message_03_2C::
    db $eb, "*: They discovered", $f1
    db "gold at the mine", $fa, $f7
    db $ef, $ee, "on the western", $ef, $ee, "border!", $fa, $f7
    db $ef, $ee, "I wish someone", $44, $ef, $ee, "give me some.", $f7
    db $f0

Message_03_2D::
    db $ea, "*: I hear the west", $f1
    db "and the north are", $fa, $f7
    db $ef, $ee, "locking horns over", $ef, $ee, "the gold mine.", $fa, $f7
    db $ef, $ee, "I can feel trouble", $ef, $ee, "stirring", $a4, $f7
    db $f0

Message_03_2E::
    db $ea, "*: Do you know Lady", $f1
    db "Yuna of the west?", $fa, $f7
    db $ef, $ee, "I heard that she's", $ef, $ee, "really lively.", $fa, $f7
    db $ef, $ee, "I like cheerfully", $ef, $ee, "loud girls.", $f7
    db $f0

Message_03_2F::
    db $ea, "*: The scholar in", $f1
    db "the tavern said he", $fa, $f7
    db $ef, $ee, "came from the", $ef, $ee, "eastern kingdom.", $fa, $f7
    db $ef, $ee, "He knows of every", $ef, $ee, "plant in the area.", $f7
    db $f0

Message_03_30::
    db $ea, "*: Don't you think", $f1
    db "it's too expensive?", $fa, $f7
    db $ef, $ee, "If I had a Gold", $ef, $ee, "Pass, I", $44, " get a", $fa, $f7
    db $ef, $ee, "bit of a discount,", $ef, $ee, "but even then", $a4, $f7
    db $f0

Message_03_31::
    db $ea, "*: Welcome! What", $f1
    db "can I do for you?", $f7
    db $f0

Message_03_32::
    db $ea, "*: Greetings! How", $f1
    db "shall I serve you?", $f7
    db $f0

Message_03_33::
    db $ea, "*: Hello! Have a", $f1
    db "look at my wares!", $f7
    db $f0

Message_03_34::
    db $ea, "*: We've been full", $f1
    db "up with sailors", $fa, $f7
    db $ef, $ee, "who've been stuck", $ef, $ee, "in port.", $fa, $f7
    db $ef, $ee, "We're doing brisk", $ef, $ee, "business, but the", $fa, $f7
    db $ef, $ee, "atmosphere-it's", $ef, $ee, "like a funeral.", $fa, $f7
    db $ef, $ee, "I can understand", $ef, $ee, "why a landlocked", $fa, $f7
    db $ef, $ee, "sailor would be", $ef, $ee, "down, but", $a4, $f7
    db $f0

Message_03_35::
    db $ea, "*: Urrrp! Hoo,", $f1
    db "listen to this!", $fa, $f7
    db $ef, $ee, "My ship, she froze", $ef, $ee, "solid in ice, hey?", $fa, $f7
    db $ef, $ee, "We left her and", $ef, $ee, "managed to make it", $fa, $f7
    db $ef, $ee, "ashore barely.", $ef, $ee, "Our cursed luck!", $f7
    db $f0

Message_03_36::
    db $eb, "*: ", $a4, "Sigh", $a4, " Isn't that", $f1
    db "scholar appealing?", $fa, $f7
    db $ef, $ee, "The intellect in", $ef, $ee, "his eyes", $a4, " Ooh", $a4, $f7
    db $f0

Message_03_37::
    db $ea, "*: I came from the", $f1
    db "eastern kingdom.", $fa, $f7
    db $ef, $ee, "I'm a scholar of", $ef, $ee, "plants.", $fa, $f7
    db $ef, $ee, "My studies have", $ef, $ee, "taken me afar.", $fa, $f7
    db $ef, $ee, "I", $44, " like to go", $ef, $ee, "back home though.", $fa, $f7
    db $ef, $ee, "I wonder when the", $ef, $ee, "ships will sail?", $f7
    db $f0

Message_03_38::
    db $ea, "*: The King of the", $f1
    db "west is said to", $fa, $f7
    db $ef, $ee, "dote on his only", $ef, $ee, "daughter.", $fa, $f7
    db $ef, $ee, "She's supposed to", $ef, $ee, "be a lively kid.", $f7
    db $f0

Message_03_39::
    db $ea, "*: This is the", $f1
    db "border we share", $fa, $f7
    db $ef, $ee, "with the western", $ef, $ee, "kingdom.", $fa, $f7
    db $ef, $ee, "The cave you see", $ef, $ee, "there is the mine", $fa, $f7
    db $ef, $ee, "in which gold was", $ef, $ee, "discovered.", $f7
    db $f0

Message_03_3A::
    db $ea, "*: The border has", $f1
    db "been sealed by the", $fa, $f7
    db $ef, $ee, "King's orders", $ef, $ee, "until the west", $fa, $f7
    db $ef, $ee, "recognizes the", $ef, $ee, "mine to be ours.", $f7
    db $f0

Message_03_3B::
    db $ea, "*: A traveler, are", $f1
    db "you?", $fa, $f7
    db $ef, $ee, "Sorry, but I can't", $ef, $ee, "allow you to pass.", $fa, $f7
    db $ef, $ee, "The west is beyond", $ef, $ee, "here, but they've", $fa, $f7
    db $ef, $ee, "also been digging", $ef, $ee, "from their side.", $fa, $f7
    db $ef, $ee, "So our hole and", $ef, $ee, "their hole ended", $fa, $f7
    db $ef, $ee, "up linking in the", $ef, $ee, "mountain.", $fa, $f7
    db $ef, $ee, "It's a sticky", $ef, $ee, "little mess.", $f7
    db $f0

Message_03_3C::
    db $ea, "*: Our tunneling", $f1
    db "found gold, but we", $fa, $f7
    db $ef, $ee, "also ran into the", $ef, $ee, "tunnel the west", $fa, $f7
    db $ef, $ee, "was boring from", $ef, $ee, "their side.", $fa, $f7
    db $ef, $ee, "Both sides have", $ef, $ee, "laid claim to the", $fa, $f7
    db $ef, $ee, "gold and refuse", $ef, $ee, "to concede.", $fa, $f7
    db $ef, $ee, "That's why we have", $ef, $ee, "this standoff.", $f7
    db $f0

Message_03_3D::
    db $ea, "*: This side is the", $f1
    db "western kingdom!", $fa, $f7
    db $ef, $ee, "You've come from", $ef, $ee, "the other side!", $fa, $f7
    db $ef, $ee, "You're from the", $ef, $ee, "north! Be gone!", $f7
    db $f0

Message_03_3E::
    db $ea, "*: The northerners", $ef, $ee, "want our gold!", $fa, $f7
    db $ef, $ee, "There's no trusting", $ef, $ee, "the greedy scum!", $fa, $f7
    db $ef, $ee, "They must be", $ef, $ee, "conspiring to take", $fa, $f7
    db $ef, $ee, "our land too, I", $ef, $ee, "just know it!", $f7
    db $f0

Message_03_3F::
    db $ea, "*: The northerners", $f1
    db "muscled in on the", $fa, $f7
    db $ef, $ee, "gold mine that we", $ef, $ee, "discovered.", $fa, $f7
    db $ef, $ee, "Can you understand", $ef, $ee, "the arrogance?", $f7
    db $f0

Message_03_40::
    db $ea, "*: Heh, you've come", $f1
    db "way down deep.", $fa, $f7
    db $ef, $ee, "The monsters are", $ef, $ee, "tough down here!", $f7
    db $f0

Message_03_41::
    db $ea, "*: There is a", $f1
    db "boulder blocking", $fa, $f7
    db $ef, $ee, "the way a little", $ef, $ee, "further ahead.", $fa, $f7
    db $ef, $ee, "If there was a way", $ef, $ee, "to break it", $a4, $f7
    db $f0

Message_03_42::
    db $ea, "*: Hurry! We have", $f1
    db "to beat the swine", $fa, $f7
    db $ef, $ee, "of the west to the", $ef, $ee, "mine!", $f7
    db $f0

Message_03_43::
    db $ea, "*: The vein of gold", $f1
    db "is just ahead!", $fa, $f7
    db $ef, $ee, "Hurry! It's winner", $ef, $ee, "take all!", $f7
    db $f0

Message_03_44::
    db $ea, "*: The gold is", $f1
    db "ours! The west", $fa, $f7
    db $ef, $ee, "must not get their", $ef, $ee, "hands on it!", $fa, $f7
    db $ef, $ee, "Hurry, we're almost", $ef, $ee, "there!", $f7
    db $f0

Message_03_45::
    db $ea, "*: Kid, you have", $f1
    db "guts to be here.", $f7
    db $f0

Message_03_46::
    db $ea, "*: Don't you touch", $f1
    db "that.", $fa, $f7
    db $ef, $ee, "If you had only", $ef, $ee, "dreamt of the gold", $fa, $f7
    db $ef, $ee, "like the fools", $ef, $ee, "outside", $a4, $fa, $f7
    db $ef, $ee, "Your sneaking", $ef, $ee, "around isn't good", $fa, $f7
    db $ef, $ee, "for our plans.", $ef, $ee, "You'll have to go.", $f7
    db $f0

Message_03_47::
    db $ea, "*: You again? I'll", $f1
    db "have to get ugly.", $f7
    db $f0

Message_03_48::
    db $ea, "*: Darn! Take this!", $f1
    db "SACRIFICE!", $f7
    db $f0

Message_03_49::
    db $ea, "*: What? What was", $f1
    db "that explosion?", $f7
    db $f0

Message_03_4A::
    db $ea, "*: That dust there", $a4, $f1
    db "Is that the gold?", $f7
    db $f0

Message_03_4B::
    db $ea, "*: What? That's all", $f1
    db "that there was?", $fa, $f7
    db $ef, $ee, "You mean to tell", $ef, $ee, "me that we've been", $fa, $f7
    db $ef, $ee, "acting like", $ef, $ee, "loggerheads over", $fa, $f7
    db $ef, $ee, "just that?", $ef, $ee, $f7
    db $f0

Message_03_4C::
    db $ea, "*: We", $44, " better get", $f1
    db "word to the King!", $f7
    db $f0

Message_03_4D::
    db $ea, "*: That's true", $a4, $f1
    db "I've got to", $a4, $fa, $f7
    db $ef, $ee, "I have to tell my", $ef, $ee, "King the news!", $f7
    db $f0

Message_03_4E::
    db $ea, "*: We almost went", $f1
    db "to war with the", $fa, $f7
    db $ef, $ee, "west over a tiny", $ef, $ee, "amount of gold.", $fa, $f7
    db $ef, $ee, "We must have been", $ef, $ee, "possessed.", $f7
    db $f0

Message_03_4F::
    db $ea, "*: The King has", $f1
    db "sealed the border.", $fa, $f7
    db $ef, $ee, "He suspects that", $ef, $ee, "the whole incident", $fa, $f7
    db $ef, $ee, "was concocted by", $ef, $ee, "the west.", $f7
    db $f0

Message_03_50::
    db $ea, "*: We're still under", $f1
    db "orders to keep the", $fa, $f7
    db $ef, $ee, "border with the", $ef, $ee, "west sealed.", $fa, $f7
    db $ef, $ee, "This, despite the", $ef, $ee, "absence of gold.", $fa, $f7
    db $ef, $ee, "What's gotten into", $ef, $ee, "his Majesty?", $f7
    db $f0

Message_03_51::
    db $ea, "*: Was that really", $f1
    db "all the gold?", $fa, $f7
    db $ef, $ee, "To find out, we've", $ef, $ee, "started excavating", $fa, $f7
    db $ef, $ee, "together with the", $ef, $ee, "westerners.", $fa, $f7
    db $ef, $ee, "Once you get to", $ef, $ee, "know them, they're", $fa, $f7
    db $ef, $ee, "not bad people at", $ef, $ee, "all.", $f7
    db $f0

Message_03_52::
    db $ea, "*: I've heard", $a4, $f1
    db $fa, $f7
    db $ef, $ee, $f3, "There was almost", $ef, $ee, "no gold at all.", $fa, $f7
    db $ef, $ee, "What purpose did", $ef, $ee, "we serve?", $f7
    db $f0

Message_03_53::
    db $ea, "*: The north's King", $f1
    db "still suspects us.", $fa, $f7
    db $ef, $ee, "I'm sorry, but we", $ef, $ee, "can't let you pass.", $f7
    db $f0

Message_03_54::
    db $ea, "*: We're not certain", $f1
    db "about what we'll", $fa, $f7
    db $ef, $ee, "find, but we'll", $ef, $ee, "keep picking away.", $f7
    db $f0

Message_03_55::
    db $eb, "*: I've heard about", $f1
    db "the mine.", $fa, $f7
    db $ef, $ee, "Isn't it horrible?", $ef, $ee, "Squabbling over", $fa, $f7
    db $ef, $ee, "gold that wasn't", $ef, $ee, "even there", $a4, $f7
    db $f0

Message_03_56::
    db $ea, "*: There's just no", $f1
    db "telling what greed", $fa, $f7
    db $ef, $ee, "will make people", $ef, $ee, "do", $a4, $f7
    db $f0

Message_03_57::
    db $ea, "*: Did you know?", $f1
    db "There is a tunnel", $fa, $f7
    db $ef, $ee, "on the way to the", $ef, $ee, "border.", $fa, $f7
    db $ef, $ee, "It leads to a", $ef, $ee, "little port.", $fa, $f7
    db $ef, $ee, "If you're going to", $ef, $ee, "the west, it might", $fa, $f7
    db $ef, $ee, "be worth your time", $ef, $ee, "to visit.", $f7
    db $f0

Message_03_58::
    db $ea, "*: I've heard from", $f1
    db "friends who came", $fa, $f7
    db $ef, $ee, "back from the mine", $ef, $ee, "that there's no", $fa, $f7
    db $ef, $ee, "gold to be found", $ef, $ee, "there at all.", $fa, $f7
    db $ef, $ee, "But the King still", $ef, $ee, "suspects the west", $a4, $f7
    db $f0

Message_03_59::
    db $ea, "*: We reported to", $f1
    db "the King that the", $fa, $f7
    db $ef, $ee, "mine had no gold", $ef, $ee, "to start with,", $fa, $f7
    db $ef, $ee, "but he refuses to", $ef, $ee, "believe us and", $fa, $f7
    db $ef, $ee, "blames the west", $ef, $ee, "for stealing the", $fa, $f7
    db $ef, $ee, "gold.", $ef, $ee, "Perhaps you can", $fa, $f7
    db $ef, $ee, "speak to him?", $ef, $ee, $f7
    db $f0

Message_03_5A::
    db $ea, "*: What is it, you", $f1
    db "whelp!?", $fa, $f7
    db $ef, $ee, "You claim that the", $ef, $ee, "mine has no gold?", $fa, $f7
    db $ef, $ee, "You dare question", $ef, $ee, "my authority?", $f7
    db $f0

Message_03_5B::
    db $ea, "*: You're no envoy", $f1
    db "of the spirit!", $fa, $f7
    db $ef, $ee, "You must be a", $ef, $ee, "western spy!", $fa, $f7
    db $ef, $ee, "You can rot in the", $ef, $ee, "dungeon!", $f7
    db $f0

Message_03_5C::
    db $ea, "*: Ah, saved at", $f1
    db "last!", $fa, $f7
    db $ef, $ee, "The two of us were", $ef, $ee, "trapped alone.", $fa, $f7
    db $ef, $ee, "I'm the real King.", $ef, $ee, "The one on my", $fa, $f7
    db $ef, $ee, "throne is a vile", $ef, $ee, "impostor!", $fa, $f7
    db $ef, $ee, "I was abducted in", $ef, $ee, "my sleep and held", $fa, $f7
    db $ef, $ee, "captive down here.", $ef, $ee, "I tried to escape", $fa, $f7
    db $ef, $ee, "but the exit has", $ef, $ee, "been sealed.", $fa, $f7
    db $ef, $ee, "It was closed up", $ef, $ee, "recently, but I", $fa, $f7
    db $ef, $ee, "have no idea where", $ef, $ee, "to find it.", $f7
    db $f0

Message_03_5D::
    db $ea, "*: I want to get", $f1
    db "out, but the exit", $fa, $f7
    db $ef, $ee, "has been sealed.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "It was closed up", $ef, $ee, "recently, but I", $fa, $f7
    db $ef, $ee, "have no idea where", $ef, $ee, "to find it.", $f7
    db $f0

Message_03_5E::
    db $ea, "Kameha: Where's", $f1
    db "the exit?", $fa, $f7
    db $ef, $ee, "We'll starve down", $ef, $ee, "here if we don't", $fa, $f7
    db $ef, $ee, "find the way out", $ef, $ee, "soon!", $f7
    db $f0

Message_03_5F::
    db $ea, "Kameha: Where's", $f1
    db "the exit?", $fa, $f7
    db $ef, $ee, "We'll starve down", $ef, $ee, "here if we don't", $fa, $f7
    db $ef, $ee, "find the way out", $ef, $ee, "soon!", $f7
    db $f0

Message_03_60::
    db $f9, "0 tapped on", $f1
    db "the wall.", $fa, $f7
    db $ef, $ee, "The wall sounded", $ef, $ee, "heavy and solid.", $f7
    db $f0

Message_03_61::
    db $ea, "Kameha: So that's", $f1
    db "where the exit is!", $fa, $f7
    db $ef, $ee, $f9, "0, here, stand", $ef, $ee, "aside!", $f7
    db $f0

Message_03_62::
    db $ea, "Kameha: ", $a4, $f9, "0", $a4, $f1
    db "That wasn't it", $a4, $f7
    db $f0

Message_03_63::
    db $f9, "0 tapped on", $f1
    db "the wall.", $fa, $f7
    db $ef, $ee, "Sound echoed as if", $ef, $ee, "it were hollow.", $f7
    db $f0

Message_03_64::
    db $ea, "Kameha: That's it!", $f1
    db "That's the exit!", $fa, $f7
    db $ef, $ee, $f9, "0, I'll go on", $ef, $ee, "ahead!", $f7
    db $f0

Message_03_65::
    db $ea, "*: I'm the real", $f1
    db "King, you fake!", $f7
    db $f0

Message_03_66::
    db $ea, "*: What? How dare", $f1
    db "you, impostor!", $fa, $f7
    db $ef, $ee, "I'm the real King!", $ef, $ee, "Not you!", $f7
    db $f0

Message_03_67::
    db $ea, "*: I'm real! Don't", $f1
    db "you believe me?", $f7
    db $f0

Message_03_68::
    db $ea, "*: Look in my eyes!", $f1
    db "I'm not lying!", $f7
    db $f0

Message_03_69::
    db $ea, "*: If you can't see", $f1
    db "the truth, you'll", $fa, $f7
    db $ef, $ee, "never become a", $ef, $ee, "great hero!", $f7
    db $f0

Message_03_6A::
    db $ea, "*: Didn't we work", $f1
    db "together to escape", $fa, $f7
    db $ef, $ee, "from the dungeon?", $ef, $ee, "I'm the real King!", $f7
    db $f0

Message_03_6B::
    db "The mirror shows", $f1
    db "the King.", $f7
    db $f0

Message_03_6C::
    db $ea, "*: I am real!", $f1
    db "Don't believe him!", $f7
    db $f0

Message_03_6D::
    db $ea, "*: My regal bearing", $f1
    db "should be evidence", $fa, $f7
    db $ef, $ee, "that I am the real", $ef, $ee, "King!", $f7
    db $f0

Message_03_6E::
    db $ea, "*: Look at him!", $f1
    db "He's grimy!", $fa, $f7
    db $ef, $ee, "He's no comparison", $ef, $ee, "to me!", $f7
    db $f0

Message_03_6F::
    db $ea, "*: You suspect me", $f1
    db "still? Kiki!", $fa, $f7
    db $ef, $ee, "Gaaah! A slip of", $ef, $ee, "the tongue, kiki!", $f7
    db $f0

Message_03_70::
    db $ea, "*: Arrgh, you've", $f1
    db "ruined my plan to", $fa, $f7
    db $ef, $ee, "cause conflict by", $ef, $ee, "impersonating the", $fa, $f7
    db $ef, $ee, "King, kikiki!", $ef, $ee, "You will pay!", $f7
    db $f0

Message_03_71::
    db "The mirror shows a", $f1
    db "monster.", $f7
    db $f0

Message_03_72::
    db $ea, "*: It almost worked", $f1
    db "to perfection!", $fa, $f7
    db $ef, $ee, "It's all your", $ef, $ee, "fault, kikiki!", $f7
    db $f0

Message_03_73::
    db $ea, "*: Awaaargh!", $f1
    db "A m-m-monster!", $fa, $f7
    db $ef, $ee, "A monster was", $ef, $ee, "impersonating me!", $f7
    db $f0

Message_03_74::
    db $ea, "*: Bravo!", $f1
    db "We're saved!", $fa, $f7
    db $ef, $ee, "Thank you for", $ef, $ee, "seeing that I am", $fa, $f7
    db $ef, $ee, "the true King of", $ef, $ee, "Norden!", $fa, $f7
    db $ef, $ee, "I will put a stop", $ef, $ee, "to the squabbling", $fa, $f7
    db $ef, $ee, "with the western", $ef, $ee, "kingdom.", $fa, $f7
    db $ef, $ee, "I'll have the", $ef, $ee, "border reopened.", $f7
    db $f0

Message_03_75::
    db $ea, "King: I'll have", $f1
    db "the border opened.", $fa, $f7
    db $ef, $ee, "It is a long way", $ef, $ee, "to the western", $fa, $f7
    db $ef, $ee, "kingdom, however.", $ef, $ee, "Do take care.", $f7
    db $f0

Message_03_76::
    db $ea, "*: Who would've", $f1
    db "thought that a", $fa, $f7
    db $ef, $ee, "monster would pose", $ef, $ee, "as the King?", $fa, $f7
    db $ef, $ee, "Nobody realized", $ef, $ee, "what happened.", $fa, $f7
    db $ef, $ee, "The King must be", $ef, $ee, "furious", $a4, $f7
    db $f0

Message_03_77::
    db $ea, "*: Well, we managed", $f1
    db "to avoid war with", $fa, $f7
    db $ef, $ee, "the west. That's a", $ef, $ee, "good thing.", $f7
    db $f0

Message_03_78::
    db $ea, "*: This is just", $f1
    db "between you and", $fa, $f7
    db $ef, $ee, "me, but the fake", $ef, $ee, "King was a harder", $fa, $f7
    db $ef, $ee, "worker than the", $ef, $ee, "real King.", $f7
    db $f0

Message_03_79::
    db $ea, "*: Who was that boy", $f1
    db "who came out of", $fa, $f7
    db $ef, $ee, "the dungeon with", $ef, $ee, "the King?", $fa, $f7
    db $ef, $ee, "He can't be the", $ef, $ee, "King's son, but he", $fa, $f7
    db $ef, $ee, "was dressed in a", $ef, $ee, "regal manner", $a4, $f7
    db $f0

Message_03_7A::
    db $ea, "*: The border with", $f1
    db "the west is open!", $fa, $f7
    db $ef, $ee, "But the western", $ef, $ee, "kingdom is far", $fa, $f7
    db $ef, $ee, "away, you should", $ef, $ee, "be very cautious.", $f7
    db $f0

Message_03_7B::
    db $eb, "*: The discovery of", $f1
    db "gold was a bust", $a4, $fa, $f7
    db $ef, $ee, "It's disappointing,", $ef, $ee, "it really is", $a4, $fa, $f7
    db $ef, $ee, "My rings", $a4, $ef, $ee, "My bangles", $a4, $f7
    db $f0

Message_03_7C::
    db $ea, "*: The King gave", $f1
    db "word to lift the", $fa, $f7
    db $ef, $ee, "blockade of the", $ef, $ee, "border.", $fa, $f7
    db $ef, $ee, "The trouble is", $ef, $ee, "finally over.", $f7
    db $f0

Message_03_7D::
    db $ea, "*: A monster was", $f1
    db "playing the part", $fa, $f7
    db $ef, $ee, "of our King", $a4, $ef, $ee, "It's no wonder we", $fa, $f7
    db $ef, $ee, "were getting such", $ef, $ee, "bizarre orders.", $f7
    db $f0

Message_03_7E::
    db $eb, "*: This is the town", $f1
    db "of Weston.", $fa, $f7
    db $ef, $ee, "It's the western", $ef, $ee, "kingdom's port.", $f7
    db $f0

Message_03_7F::
    db $ea, "*: The west's castle", $f1
    db "has seen a steady", $fa, $f7
    db $ef, $ee, "stream of visitors", $ef, $ee, "and gifts.", $fa, $f7
    db $ef, $ee, "They're offering a", $ef, $ee, "reward if you can", $fa, $f7
    db $ef, $ee, "cheer Lady Yuna", $ef, $ee, "up.", $fa, $f7
    db $ef, $ee, "I'm thinking of", $ef, $ee, "going myself.", $f7
    db $f0

Message_03_80::
    db $ea, "*: Across from us", $f1
    db "on the lake is the", $fa, $f7
    db $ef, $ee, "eastern kingdom.", $ef, $ee, "It's ruled by", $fa, $f7
    db $ef, $ee, "Queen Helen, I", $ef, $ee, "think.", $fa, $f7
    db $ef, $ee, "Will our Lady Yuna", $ef, $ee, "become our queen?", $f7
    db $f0

Message_03_81::
    db $eb, "*: I saw Lady Yuna", $f1
    db "riding towards the", $fa, $f7
    db $ef, $ee, "forest in the", $ef, $ee, "southeast.", $fa, $f7
    db $ef, $ee, "She looked dashing", $ef, $ee, "on her steed.", $f7
    db $f0

Message_03_82::
    db $ea, "*: Lady Yuna has", $f1
    db "been a lively girl", $fa, $f7
    db $ef, $ee, "for as long as I", $ef, $ee, "can remember.", $fa, $f7
    db $ef, $ee, "Her habit of", $ef, $ee, "sneaking out of", $fa, $f7
    db $ef, $ee, "the Castle vexed", $ef, $ee, "us to no end.", $f7
    db $f0

Message_03_83::
    db $ea, "*: I haven't been", $f1
    db "seeing too many", $fa, $f7
    db $ef, $ee, "ships coming into", $ef, $ee, "our harbor.", $fa, $f7
    db $ef, $ee, "I wonder why that", $ef, $ee, "could be.", $fa, $f7
    db $ef, $ee, "Ships make great", $ef, $ee, "transportation.", $f7
    db $f0

Message_03_84::
    db $ea, "*: Lady Yuna is", $f1
    db "said to be quiet", $fa, $f7
    db $ef, $ee, "and withdrawn", $ef, $ee, "these days.", $fa, $f7
    db $ef, $ee, "Perhaps she is", $ef, $ee, "trying to cope", $fa, $f7
    db $ef, $ee, "with adolescent", $ef, $ee, "concerns", $a4, $f7
    db $f0

Message_03_85::
    db $ea, "*: I've heard rumors", $f1
    db "that something is", $fa, $f7
    db $ef, $ee, "wrong with Lady", $ef, $ee, "Yuna.", $fa, $f7
    db $ef, $ee, "I wonder what it", $ef, $ee, "could be?", $f7
    db $f0

Message_03_86::
    db $ea, "*: The King dotes", $f1
    db "over Lady Yuna.", $fa, $f7
    db $ef, $ee, "He", $44, " gladly give", $ef, $ee, "up his own life", $fa, $f7
    db $ef, $ee, "for her sake, I'm", $ef, $ee, "sure.", $f7
    db $f0

Message_03_87::
    db $ea, "*: The road to the", $f1
    db "eastern kingdom is", $fa, $f7
    db $ef, $ee, "teeming with tough", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "If you're thinking", $ef, $ee, "of going, it may", $fa, $f7
    db $ef, $ee, "be less dangerous", $ef, $ee, "to cross the lake.", $f7
    db $f0

Message_03_88::
    db $eb, "*: Lady Yuna locks", $f1
    db "herself in her", $fa, $f7
    db $ef, $ee, "room all day long", $ef, $ee, "and won't come out.", $fa, $f7
    db $ef, $ee, "The King is at his", $ef, $ee, "wit's end.", $f7
    db $f0

Message_03_89::
    db $ea, "*: If you can cheer", $f1
    db "up the princess,", $fa, $f7
    db $ef, $ee, "you can earn a", $ef, $ee, "reward, I hear.", $fa, $f7
    db $ef, $ee, "A whole lot of", $ef, $ee, "challengers have", $fa, $f7
    db $ef, $ee, "already gone to", $ef, $ee, "the Castle.", $fa, $f7
    db $ef, $ee, "Maybe I ought to", $ef, $ee, "try too", $a4, $fa, $f7
    db $ef, $ee, "The Castle is to", $ef, $ee, "the west. Just go", $fa, $f7
    db $ef, $ee, "along the river", $ef, $ee, "and you're there!", $f7
    db $f0
    ds $183, $00
