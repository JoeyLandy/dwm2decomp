SECTION "Bank 7C", ROMX[$4000], BANK[$7C]
    db $7c

; message bank $7C: when wStringIndex < $87, BeginStringDisplay with this bank's table
; MessageStrings_Bank7C; otherwise far-calls BeginStringDisplay_Bank7C_Overflow (E-0080)
BeginStringDisplay_Bank7C::
    ld a, [wStringIndex]
    cp $87
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank7C_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank7C
    call BeginStringDisplay
    ret

; message bank $7C: when wStringIndex < $87, CopyStringToBuffer with this bank's table
; MessageStrings_Bank7C; otherwise far-calls CopyStringToBuffer_Bank7C_Overflow (E-0080)
CopyStringToBuffer_Bank7C::
    ld a, [wStringIndex]
    cp $87
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank7C_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank7C
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_7C_4032::
MessageStrings_Bank7C::
    dw StringList_7C_4034 ; id 0

; category list of StringCategories_7C_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_7C_4034::
    dw Message_08_00 ; id 0
    dw Message_08_01 ; id 1
    dw Message_08_02 ; id 2
    dw Message_08_03 ; id 3
    dw Message_08_04 ; id 4
    dw Message_08_05 ; id 5
    dw Message_08_06 ; id 6
    dw Message_08_07 ; id 7
    dw Message_08_08 ; id 8
    dw Message_08_09 ; id 9
    dw Message_08_0A ; id 10
    dw Message_08_0B ; id 11
    dw Message_08_0C ; id 12
    dw Message_08_0D ; id 13
    dw Message_08_0E ; id 14
    dw Message_08_0F ; id 15
    dw Message_08_10 ; id 16
    dw Message_08_11 ; id 17
    dw Message_08_12 ; id 18
    dw Message_08_13 ; id 19
    dw Message_08_14 ; id 20
    dw Message_08_15 ; id 21
    dw Message_08_16 ; id 22
    dw Message_08_17 ; id 23
    dw Message_08_18 ; id 24
    dw Message_08_19 ; id 25
    dw Message_08_1A ; id 26
    dw Message_08_1B ; id 27
    dw Message_08_1C ; id 28
    dw Message_08_1D ; id 29
    dw Message_08_1E ; id 30
    dw Message_08_1F ; id 31
    dw Message_08_20 ; id 32
    dw Message_08_21 ; id 33
    dw Message_08_22 ; id 34
    dw Message_08_23 ; id 35
    dw Message_08_24 ; id 36
    dw Message_08_25 ; id 37
    dw Message_08_26 ; id 38
    dw Message_08_27 ; id 39
    dw Message_08_28 ; id 40
    dw Message_08_28 ; id 41
    dw Message_08_2A ; id 42
    dw Message_08_2B ; id 43
    dw Message_08_2C ; id 44
    dw Message_08_2D ; id 45
    dw Message_08_2E ; id 46
    dw Message_08_2F ; id 47
    dw Message_08_30 ; id 48
    dw Message_08_31 ; id 49
    dw Message_08_32 ; id 50
    dw Message_08_33 ; id 51
    dw Message_08_34 ; id 52
    dw Message_08_35 ; id 53
    dw Message_08_36 ; id 54
    dw Message_08_37 ; id 55
    dw Message_08_38 ; id 56
    dw Message_08_39 ; id 57
    dw Message_08_3A ; id 58
    dw Message_08_3B ; id 59
    dw Message_08_3C ; id 60
    dw Message_08_3D ; id 61
    dw Message_08_3E ; id 62
    dw Message_08_3F ; id 63
    dw Message_08_40 ; id 64
    dw Message_08_41 ; id 65
    dw Message_08_42 ; id 66
    dw Message_08_43 ; id 67
    dw Message_08_44 ; id 68
    dw Message_08_45 ; id 69
    dw Message_08_46 ; id 70
    dw Message_08_47 ; id 71
    dw Message_08_48 ; id 72
    dw Message_08_49 ; id 73
    dw Message_08_4A ; id 74
    dw Message_08_4B ; id 75
    dw Message_08_4C ; id 76
    dw Message_08_4D ; id 77
    dw Message_08_4E ; id 78
    dw Message_08_4F ; id 79
    dw Message_08_50 ; id 80
    dw Message_08_51 ; id 81
    dw Message_08_52 ; id 82
    dw Message_08_53 ; id 83
    dw Message_08_54 ; id 84
    dw Message_08_55 ; id 85
    dw Message_08_56 ; id 86
    dw Message_08_57 ; id 87
    dw Message_08_58 ; id 88
    dw Message_08_59 ; id 89
    dw Message_08_5A ; id 90
    dw Message_08_5B ; id 91
    dw Message_08_5C ; id 92
    dw Message_08_5D ; id 93
    dw Message_08_5E ; id 94
    dw Message_08_5F ; id 95
    dw Message_08_60 ; id 96
    dw Message_08_61 ; id 97
    dw Message_08_62 ; id 98
    dw Message_08_63 ; id 99
    dw Message_08_64 ; id 100
    dw Message_08_65 ; id 101
    dw Message_08_66 ; id 102
    dw Message_08_67 ; id 103
    dw Message_08_68 ; id 104
    dw Message_08_69 ; id 105
    dw Message_08_6A ; id 106
    dw Message_08_6B ; id 107
    dw Message_08_6C ; id 108
    dw Message_08_6D ; id 109
    dw Message_08_6E ; id 110
    dw Message_08_6F ; id 111
    dw Message_08_70 ; id 112
    dw Message_08_71 ; id 113
    dw Message_08_72 ; id 114
    dw Message_08_73 ; id 115
    dw Message_08_74 ; id 116
    dw Message_08_75 ; id 117
    dw Message_08_76 ; id 118
    dw Message_08_77 ; id 119
    dw Message_08_78 ; id 120
    dw Message_08_79 ; id 121
    dw Message_08_7A ; id 122
    dw Message_08_7B ; id 123
    dw Message_08_7C ; id 124
    dw Message_08_7D ; id 125
    dw Message_08_7E ; id 126
    dw Message_08_7F ; id 127
    dw Message_08_80 ; id 128
    dw Message_08_81 ; id 129
    dw Message_08_82 ; id 130
    dw Message_08_83 ; id 131
    dw Message_08_84 ; id 132
    dw Message_08_85 ; id 133
    dw Message_08_86 ; id 134

Message_08_00::
    db $ea, "*: This is the", $f1
    db "village of Yold.", $fa, $f7
    db $ef, $ee, "We're known for", $ef, $ee, "our fresh fish.", $f7
    db $f0

Message_08_01::
    db $eb, "*: In the northwest", $f1
    db "is a village that", $fa, $f7
    db $ef, $ee, "is famous for", $ef, $ee, "mermaids.", $f7
    db $f0

Message_08_02::
    db $ea, "*: Around these", $f1
    db "parts it's faster", $fa, $f7
    db $ef, $ee, "to travel by boat", $ef, $ee, "than walking,", $fa, $f7
    db $ef, $ee, "so everyone has", $ef, $ee, "their own boat.", $fa, $f7
    db $ef, $ee, "In the olden days", $ef, $ee, "it was dangerous", $fa, $f7
    db $ef, $ee, "because there were", $ef, $ee, "pirates.", $f7
    db $f0

Message_08_03::
    db $ea, "*: I saw a haunted", $f1
    db "ship in the north.", $fa, $f7
    db $ef, $ee, "It scared me so", $ef, $ee, "much, I can't get", $fa, $f7
    db $ef, $ee, "out of bed.", $ef, $ee, "Oooh, scary!", $f7
    db $f0

Message_08_04::
    db $ea, "*: The volcanic", $f1
    db "island off the", $fa, $f7
    db $ef, $ee, "coast appears to", $ef, $ee, "be in a bad mood.", $fa, $f7
    db $ef, $ee, "There have been", $ef, $ee, "many quakes.", $fa, $f7
    db $ef, $ee, "The fish aren't", $ef, $ee, "biting at all.", $f7
    db $f0

Message_08_05::
    db $eb, "*: Mermaids lived", $f1
    db "in the sea in the", $fa, $f7
    db $ef, $ee, "northwest. Among", $ef, $ee, "their treasures", $fa, $f7
    db $ef, $ee, "was a round mirror", $ef, $ee, "called HarMirror,", $fa, $f7
    db $ef, $ee, "but it was stolen", $ef, $ee, "by pirates.", $fa, $f7
    db $ef, $ee, "Nobody knows where", $ef, $ee, "it is now.", $f7
    db $f0

Message_08_06::
    db $ea, "*: ", $a4, "The birds are", $f1
    db "noisy", $a4, $fa, $f7
    db $ef, $ee, "It's a sign that a", $ef, $ee, "quake will hit.", $f7
    db $f0

Message_08_07::
    db $ea, "*: ", $a4, "See? What did I", $f1
    db "just say?", $f7
    db $f0

Message_08_08::
    db $ea, "*: I hope the", $f1
    db "volcanic island", $fa, $f7
    db $ef, $ee, "off the coast", $ef, $ee, "won't erupt", $a4, $f7
    db $f0

Message_08_09::
    db $ea, "*: I don't have", $f1
    db "much but", $a4, $fa, $f7
    db $ef, $ee, "Would you care to", $ef, $ee, "see my wares?", $f7
    db $f0

Message_08_0A::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "A folded fishnet", $ef, $ee, "was tucked inside.", $f7
    db $f0

Message_08_0B::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "colorful fruits.", $f7
    db $f0

Message_08_0C::
    db $eb, "*: Welcome to", $f1
    db "Polona.", $fa, $f7
    db $ef, $ee, "It's a tourist", $ef, $ee, "resort known for", $fa, $f7
    db $ef, $ee, "the mermaids in", $ef, $ee, "the area.", $f7
    db $f0

Message_08_0D::
    db $ea, "*: You could meet", $f1
    db "mermaids here in", $fa, $f7
    db $ef, $ee, "the past, but not", $ef, $ee, "anymore.", $fa, $f7
    db $ef, $ee, "Not since the", $ef, $ee, "pirates raided", $fa, $f7
    db $ef, $ee, "them and took", $ef, $ee, "their treasure.", $fa, $f7
    db $ef, $ee, "After that, the", $ef, $ee, "mermaids have kept", $fa, $f7
    db $ef, $ee, "away from people", $ef, $ee, "out of fear.", $fa, $f7
    db $ef, $ee, "It's a shame.", $ef, $ee, "They were decent", $fa, $f7
    db $ef, $ee, "sorts who liked to", $ef, $ee, "dance and sing.", $f7
    db $f0

Message_08_0E::
    db $ea, "*: I'm from the port", $f1
    db "in the northeast.", $fa, $f7
    db $ef, $ee, "I", $44, " almost reached", $ef, $ee, "here when ArmyAnts", $fa, $f7
    db $ef, $ee, "and MadGophers", $ef, $ee, "jumped me.", $fa, $f7
    db $ef, $ee, "I managed to get", $ef, $ee, "away though.", $fa, $f7
    db $ef, $ee, "I'm glad I made it", $ef, $ee, "here safely.", $fa, $f7
    db $ef, $ee, "It's quiet and", $ef, $ee, "restful.", $f7
    db $f0

Message_08_0F::
    db $eb, "*: You're not", $f1
    db "supposed to go", $fa, $f7
    db $ef, $ee, "near the cave in", $ef, $ee, "the west.", $fa, $f7
    db $ef, $ee, "It's on the cape.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Water monsters", $ef, $ee, "live there.", $fa, $f7
    db $ef, $ee, "Mama said it's", $ef, $ee, "dangerous.", $f7
    db $f0

Message_08_10::
    db $ea, "*: In the past,", $f1
    db "mermaids are said", $fa, $f7
    db $ef, $ee, "to have sang and", $ef, $ee, "danced with people", $fa, $f7
    db $ef, $ee, "where we stand", $ef, $ee, "now.", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "dance to remember", $fa, $f7
    db $ef, $ee, "and celebrate the", $ef, $ee, "days gone by?", $ff, $f0

Message_08_11::
    db $ea, "*: Then I'll sing!", $f1
    db "Lalala", $9d, " lala la", $9d, $f7
    db $f0

Message_08_12::
    db $eb, "*: Bravo, bravo!", $f1
    db "You were fabulous!", $fa, $f7
    db $ef, $ee, "You have a certain", $ef, $ee, "flair for genius!", $fa, $f7
    db $ef, $ee, "Please, take this", $ef, $ee, "as my thanks!", $f7
    db $f0

Message_08_13::
    db $f9, "0 received", $f1
    db "a TinyMedal.", $f7
    db $f0

Message_08_14::
    db $eb, "*: Bravo, bravo!", $f1
    db "You were fabulous!", $fa, $f7
    db $ef, $ee, "You have a certain", $ef, $ee, "flair for genius!", $fa, $f7
    db $ef, $ee, "Please, take this", $ef, $ee, "as my thanks!", $fa, $f7
    db $ef, $ee, "Oh? You have no", $ef, $ee, "room", $a4, " Next time!", $f7
    db $f0

Message_08_15::
    db $eb, "*: Bravo, bravo!", $f1
    db "You were fabulous!", $fa, $f7
    db $ef, $ee, "You have a certain", $ef, $ee, "flair for genius!", $fa, $f7
    db $ef, $ee, "I", $44, " love to see", $ef, $ee, "you dance again!", $f7
    db $f0

Message_08_16::
    db $ea, "*: Erm", $a4, " The sense", $f1
    db "of rhythm just", $fa, $f7
    db $ef, $ee, "doesn't quite come", $ef, $ee, "through.", $fa, $f7
    db $ef, $ee, "If there were a", $ef, $ee, "monster that could", $fa, $f7
    db $ef, $ee, "lead the dance", $ef, $ee, "performance", $a4, $fa, $f7
    db $ef, $ee, "Oh, pardon me!", $ef, $ee, "You are a novice", $a4, $f7
    db $f0

Message_08_17::
    db $ea, "*: Ah", $a4, " Shame", $a4, $f1
    db "Please come again.", $f7
    db $f0

Message_08_18::
    db $ea, "*: Have you heard", $f1
    db "the legend about", $fa, $f7
    db $ef, $ee, "the mermaids", $95, $ef, $ee, "treasure?", $ff, $f0

Message_08_19::
    db $ea, "*: Ah, you've heard", $f1
    db "already.", $fa, $f7
    db $ef, $ee, "It's a tragic tale.", $ef, $ee, $f7
    db $f0

Message_08_1A::
    db $ea, "*: Long ago, a deft", $f1
    db "craftsman made a", $fa, $f7
    db $ef, $ee, "mirror with the", $ef, $ee, "power of darkness.", $fa, $f7
    db $ef, $ee, "It brought ruin to", $ef, $ee, "whatever its cold", $fa, $f7
    db $ef, $ee, "face reflected.", $ef, $ee, "Learning of this", $fa, $f7
    db $ef, $ee, "mirror, the people", $ef, $ee, "grew frightened.", $fa, $f7
    db $ef, $ee, "They took the", $ef, $ee, "mirror from the", $fa, $f7
    db $ef, $ee, "craftsman.", $ef, $ee, "It was hurled", $fa, $f7
    db $ef, $ee, "into the sea.", $ef, $ee, "The craftsman, out", $fa, $f7
    db $ef, $ee, "of sorrow, leapt", $ef, $ee, "after the mirror", $fa, $f7
    db $ef, $ee, "into the sea.", $ef, $ee, "The mirror drifted", $fa, $f7
    db $ef, $ee, "to the lair of", $ef, $ee, "mermaids where it", $fa, $f7
    db $ef, $ee, "was kept under", $ef, $ee, "secure seal as the", $fa, $f7
    db $ef, $ee, "HarMirror.", $ef, $ee, "And that's the", $fa, $f7
    db $ef, $ee, "tale.", $ef, $ee, $f7
    db $f0

Message_08_1B::
    db $eb, "*: Ahh", $a4, " This is", $f1
    db "heavenly!", $fa, $f7
    db $ef, $ee, "It makes me feel", $ef, $ee, "alive again!", $fa, $f7
    db $ef, $ee, "Relaxing here, all", $ef, $ee, "my troubles seem", $fa, $f7
    db $ef, $ee, "to melt away to", $ef, $ee, "insignificance.", $f7
    db $f0

Message_08_1C::
    db $ea, "*: I came from far", $f1
    db "away to see some", $fa, $f7
    db $ef, $ee, "mermaids, but I", $ef, $ee, "hear they've not", $fa, $f7
    db $ef, $ee, "been seen lately.", $ef, $ee, "That's a shame.", $f7
    db $f0

Message_08_1D::
    db $eb, "*: This is Port", $f1
    db "Ritz, where ships", $fa, $f7
    db $ef, $ee, "gather from all", $ef, $ee, "over the world.", $f7
    db $f0

Message_08_1E::
    db $ea, "*: The pirates were", $f1
    db "swallowed by the", $fa, $f7
    db $ef, $ee, "sea after monsters", $ef, $ee, "overwhelmed them.", $fa, $f7
    db $ef, $ee, "But before they", $ef, $ee, "sank, they're said", $fa, $f7
    db $ef, $ee, "to have hidden", $ef, $ee, "their treasures.", $f7
    db $f0

Message_08_1F::
    db $ea, "*: There's this old", $f1
    db "sailor man in the", $fa, $f7
    db $ef, $ee, "tavern who likes", $ef, $ee, "his grog too much.", $fa, $f7
    db $ef, $ee, "Whenever he's had", $ef, $ee, "a few, he'll regale", $fa, $f7
    db $ef, $ee, "you with tales of", $ef, $ee, "the high seas.", $fa, $f7
    db $ef, $ee, "But his stories", $ef, $ee, "tend to be a bit", $fa, $f7
    db $ef, $ee, "preposterous. I", $ef, $ee, "don't trust him.", $f7
    db $f0

Message_08_20::
    db $ea, "*: How may our", $f1
    db "church serve you?", $f7
    db $f0

Message_08_21::
    db $ea, "*: All sorts of", $f1
    db "people come here", $fa, $f7
    db $ef, $ee, "from around the", $ef, $ee, "world.", $fa, $f7
    db $ef, $ee, "But a little kid", $ef, $ee, "with monsters", $a4, $fa, $f7
    db $ef, $ee, "That's something", $ef, $ee, "you don't get to", $fa, $f7
    db $ef, $ee, "see too often, not", $ef, $ee, "even here.", $f7
    db $f0

Message_08_22::
    db $eb, "*: I went to Polona", $f1
    db "a while back", $a4, $fa, $f7
    db $ef, $ee, "You know, it's", $ef, $ee, "southwest of here.", $fa, $f7
    db $ef, $ee, "But I never got to", $ef, $ee, "see any mermaids.", $fa, $f7
    db $ef, $ee, "I was looking", $ef, $ee, "forward to it too", $a4, $f7
    db $f0

Message_08_23::
    db $ea, "*: I offer quality", $f1
    db "merchandise.", $fa, $f7
    db $ef, $ee, "Would you care to", $ef, $ee, "see my wares?", $f7
    db $f0

Message_08_24::
    db $ea, "*: There is a", $f1
    db "lighthouse to the", $fa, $f7
    db $ef, $ee, "east, but it's too", $ef, $ee, "dangerous.", $fa, $f7
    db $ef, $ee, "It's been overrun", $ef, $ee, "by monsters since", $fa, $f7
    db $ef, $ee, "the pirates stole", $ef, $ee, "the MoonRock from", $fa, $f7
    db $ef, $ee, "the top of the", $ef, $ee, "lighthouse.", $f7
    db $f0

Message_08_25::
    db $ea, "*: My ship sank in", $f1
    db "the eastern sea.", $fa, $f7
    db $ef, $ee, "We were sailing", $ef, $ee, "near a whirlpool", $fa, $f7
    db $ef, $ee, "when huge suction-", $ef, $ee, "cupped tentacles", $fa, $f7
    db $ef, $ee, "reached out and", $ef, $ee, "grabbed the ship.", $fa, $f7
    db $ef, $ee, "It's terrifying to", $ef, $ee, "even recall that!", $f7
    db $f0

Message_08_26::
    db $ea, "*: The old man in", $f1
    db "the tavern's neat!", $fa, $f7
    db $ef, $ee, "He tells me all", $ef, $ee, "sorts of things.", $fa, $f7
    db $ef, $ee, "I wish I would get", $ef, $ee, "kidnapped by some", $fa, $f7
    db $ef, $ee, "pirates one day.", $ef, $ee, "It", $44, " be neat!", $f7
    db $f0

Message_08_27::
    db $ea, "*: This port used", $f1
    db "to be lively in", $fa, $f7
    db $ef, $ee, "the past, but it's", $ef, $ee, "become run down", $a4, $fa, $f7
    db $ef, $ee, "The pirates have", $ef, $ee, "all gone, but the", $fa, $f7
    db $ef, $ee, "port's still fading", $ef, $ee, "away", $a4, $f7
    db $f0

Message_08_28::
    db $ea, "*: The lighthouse", $f1
    db "had the MoonRock", $fa, $f7
    db $ef, $ee, "installed at its", $ef, $ee, "pinnacle.", $fa, $f7
    db $ef, $ee, "It would glow at", $ef, $ee, "night to light the", $fa, $f7
    db $ef, $ee, "way for mariners", $ef, $ee, "at sea.", $fa, $f7
    db $ef, $ee, "It was a gift from", $ef, $ee, "mermaids, you see.", $f7
    db $f0

Message_08_2A::
    db $eb, "*: The sea's level", $f1
    db "has gone down.", $fa, $f7
    db $ef, $ee, "Many shoals have", $ef, $ee, "appeared.", $fa, $f7
    db $ef, $ee, "And that's resulted", $ef, $ee, "in countless ships", $fa, $f7
    db $ef, $ee, "running aground in", $ef, $ee, "these parts.", $f7
    db $f0

Message_08_2B::
    db $ea, "*: Listen, did you", $f1
    db "know?", $fa, $f7
    db $ef, $ee, "Mermaids appear to", $ef, $ee, "love dancing.", $fa, $f7
    db $ef, $ee, "By the way, there's", $ef, $ee, "a cave west of", $fa, $f7
    db $ef, $ee, "Polona. A giant", $ef, $ee, "squid lives there.", $fa, $f7
    db $ef, $ee, "That squid is said", $ef, $ee, "to love to dance.", $fa, $f7
    db $ef, $ee, "I don't know if I", $ef, $ee, "want to see that", $a4, $f7
    db $f0

Message_08_2C::
    db $f9, "0 tried to", $f1
    db "check the chest.", $f7
    db $f0

Message_08_2D::
    db $ea, "*: Whoa! Hands off", $f1
    db "my merchandise!", $f7
    db $f0

Message_08_2E::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "gigantic beans.", $f7
    db $f0

Message_08_2F::
    db $ea, "*: This area was a", $f1
    db "lot more lively in", $fa, $f7
    db $ef, $ee, "the old days, but", $ef, $ee, "now it's just a", $fa, $f7
    db $ef, $ee, "deathtrap for any", $ef, $ee, "kind of boat.", $fa, $f7
    db $ef, $ee, "We're ringed by", $ef, $ee, "shoals!", $fa, $f7
    db $ef, $ee, "Not many captains", $ef, $ee, "will risk their", $fa, $f7
    db $ef, $ee, "boat to bother", $ef, $ee, "dealing with us.", $f7
    db $f0

Message_08_30::
    db $ea, "*: When you're out", $f1
    db "at sea, you get to", $fa, $f7
    db $ef, $ee, "see some peculiar", $ef, $ee, "sights.", $fa, $f7
    db $ef, $ee, "But when I saw a", $ef, $ee, "ghost ship loom", $fa, $f7
    db $ef, $ee, "out of thick fog", $a4, $ef, $ee, "Hair-raising!", $f7
    db $f0

Message_08_31::
    db $ea, "*: Heh, that old", $f1
    db "man, he was too", $fa, $f7
    db $ef, $ee, "grogged to make", $ef, $ee, "any sense", $a4, $fa, $f7
    db $ef, $ee, "Captain, sir,", $ef, $ee, "what'll we do?", $f7
    db $f0

Message_08_32::
    db $ea, "*: Tch, made me", $f1
    db "waste my time", $a4, $fa, $f7
    db $ef, $ee, "We'll come back", $ef, $ee, "later for him.", $f7
    db $f0

Message_08_33::
    db $ea, "Kameha: Hey! You're", $f1
    db $f9, "0, the farmer!", $fa, $f7
    db $ef, $ee, "Don't tell me", $ef, $ee, "you're looking", $fa, $f7
    db $ef, $ee, "for something to", $ef, $ee, "plug the Navel?", $fa, $f7
    db $ef, $ee, "So, Warubou asked", $ef, $ee, "you too, huh?", $fa, $f7
    db $ef, $ee, "But those monsters", $ef, $ee, "you're with", $a4, $fa, $f7
    db $ef, $ee, "Don't they look", $ef, $ee, "frail and wimpy?", $fa, $f7
    db $ef, $ee, "Look, I've already", $ef, $ee, "got two sidekicks!", $fa, $f7
    db $ef, $ee, "I'll find the plug", $ef, $ee, "before you!", $fa, $f7
    db $ef, $ee, "Come on, team,", $ef, $ee, "let's go!", $f7
    db $f0

Message_08_34::
    db $ea, "*: When that old", $f1
    db "man gets grogged", $a4, $fa, $f7
    db $ef, $ee, "You can't move him", $ef, $ee, "with a crowbar.", $fa, $f7
    db $ef, $ee, "It's like he casts", $ef, $ee, "Ironize on", $fa, $f7
    db $ef, $ee, "himself.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "What can we do", $f1
    db "about it?", $f7
    db $f0

Message_08_35::
    db $ea, "*: The old fellow", $f1
    db "there, the instant", $fa, $f7
    db $ef, $ee, "he smells a sea", $ef, $ee, "monster, he wakes", $fa, $f7
    db $ef, $ee, "up, even if he's", $ef, $ee, "tanked on grog.", $fa, $f7
    db $ef, $ee, "That's a real sea", $ef, $ee, "dog, I", $44, " say!", $f7
    db $f0

Message_08_36::
    db $ea, "*: The volcanic", $f1
    db "island off the", $fa, $f7
    db $ef, $ee, "coast is vicious", $ef, $ee, "to ships.", $fa, $f7
    db $ef, $ee, "Its ring of shoals", $ef, $ee, "keeps boats away.", $f7
    db $f0

Message_08_37::
    db $ea, "*: Hnnnr", $a4, " Hic", $a4, " Gnn", $a4, $f1
    db "Zzz", $a4, " Gfffff", $a4, $f7
    db $f0

Message_08_38::
    db $ea, "*: Who are you?", $f1
    db "This is our surf!", $fa, $f7
    db $ef, $ee, $a4, "I mean turf!", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "You show me some", $ef, $ee, "respect on our su", $a4, $fa, $f7
    db $ef, $ee, "Turf! That's it,", $ef, $ee, "I'm mad!", $f7
    db $f0

Message_08_39::
    db $ea, "*: You can keep", $f1
    db "trying, but you're", $fa, $f7
    db $ef, $ee, "never going to", $ef, $ee, "win, punk!", $f7
    db $f0

Message_08_3A::
    db $ea, "*: Zzz", $a4, " Zzz", $a4, $f1
    db "Huh! Watch out!", $f7
    db $f0

Message_08_3B::
    db $ea, "*: What! Why are", $f1
    db "you with monsters?", $fa, $f7
    db $ef, $ee, "You're an odd", $ef, $ee, "little child.", $fa, $f7
    db $ef, $ee, "Did you want to", $ef, $ee, "hear my tales?", $ff, $f0

Message_08_3C::
    db $ea, "*: It was in my", $f1
    db "callow youth", $a4, $fa, $f7
    db $ef, $ee, "The ship I was on", $ef, $ee, "was captured by", $fa, $f7
    db $ef, $ee, "pirates who kept", $ef, $ee, "us as slaves.", $fa, $f7
    db $ef, $ee, "We toiled for", $ef, $ee, "months that way.", $fa, $f7
    db $ef, $ee, "But one day, I", $ef, $ee, "overheard them", $fa, $f7
    db $ef, $ee, "talking about the", $ef, $ee, "MoonRock.", $fa, $f7
    db $ef, $ee, "If it were taken", $ef, $ee, "from the top of", $fa, $f7
    db $ef, $ee, "the lighthouse,", $ef, $ee, "the sea would ebb.", $fa, $f7
    db $ef, $ee, "And that would", $ef, $ee, "make it impossible", $fa, $f7
    db $ef, $ee, "to approach the", $ef, $ee, "volcanic island", $fa, $f7
    db $ef, $ee, "where they hid", $ef, $ee, "their loot.", $fa, $f7
    db $ef, $ee, "Unfortunately,", $ef, $ee, "they saw me.", $fa, $f7
    db $ef, $ee, "They would never", $ef, $ee, "allow someone to", $fa, $f7
    db $ef, $ee, "live knowing their", $ef, $ee, "secret.", $fa, $f7
    db $ef, $ee, "So I ran and leapt", $ef, $ee, "into the sea.", $fa, $f7
    db $ef, $ee, "I was rescued by a", $ef, $ee, "passing ship.", $f7
    db $f0

Message_08_3D::
    db $ea, "*: The pirates", $95, $f1
    db "loot is probably", $fa, $f7
    db $ef, $ee, "still on the", $ef, $ee, "volcanic island.", $fa, $f7
    db $ef, $ee, "But, there is no", $ef, $ee, "way of getting", $fa, $f7
    db $ef, $ee, "close to the", $ef, $ee, "island.", $fa, $f7
    db $ef, $ee, "It should be", $ef, $ee, "possible to go to", $fa, $f7
    db $ef, $ee, "the island if the", $ef, $ee, "MoonRock were to", $fa, $f7
    db $ef, $ee, "be returned to the", $ef, $ee, "lighthouse.", $fa, $f7
    db $ef, $ee, "But the MoonRock", $ef, $ee, "sank with the", $fa, $f7
    db $ef, $ee, "pirates and their", $ef, $ee, "ship.", $fa, $f7
    db $ef, $ee, "Maybe if mermaids", $ef, $ee, "could help", $a4, $fa, $f7
    db $ef, $ee, "Can mermaids still", $ef, $ee, "be seen in Polona?", $f7
    db $f0

Message_08_3E::
    db $ea, "*: It's a tale of", $f1
    db "high adventure", $a4, $f7
    db $f0

Message_08_3F::
    db $ea, "*: What? Are you", $f1
    db "here for my tales?", $ff, $f0

Message_08_40::
    db $ea, "*: The pirates", $f1
    db "stole the MoonRock", $fa, $f7
    db $ef, $ee, "from its mount in", $ef, $ee, "the lighthouse.", $fa, $f7
    db $ef, $ee, "That made it", $ef, $ee, "impossible for", $fa, $f7
    db $ef, $ee, "ships to go near", $ef, $ee, "the volcanic isle", $fa, $f7
    db $ef, $ee, "where they hid", $ef, $ee, "their loot.", $fa, $f7
    db $ef, $ee, "If the MoonRock", $ef, $ee, "was returned to", $fa, $f7
    db $ef, $ee, "lighthouse, the", $ef, $ee, "island will become", $fa, $f7
    db $ef, $ee, "accessible by sea", $ef, $ee, "again.", $fa, $f7
    db $ef, $ee, "Maybe if mermaids", $ef, $ee, "could help", $a4, $fa, $f7
    db $ef, $ee, "Can mermaids still", $ef, $ee, "be seen in Polona?", $f7
    db $f0

Message_08_41::
    db $ea, "*: It's a chance to", $f1
    db "hear an intriguing", $fa, $f7
    db $ef, $ee, "tale of mystery", $a4, $ef, $ee, "Shame", $a4, $f7
    db $f0

Message_08_42::
    db $ea, "*: I'm tired of the", $f1
    db "geezer's tales.", $f7
    db $f0

Message_08_43::
    db $ea, "*: I saw a child", $f1
    db "cross the sea on a", $fa, $f7
    db $ef, $ee, "giant clam. No, no", $ef, $ee, "lie! I saw it!", $f7
    db $f0

Message_08_44::
    db $ea, "*: Watch me dance,", $f1
    db "and you'll want to", $fa, $f7
    db $ef, $ee, "dance too. I can", $ef, $ee, "see that you do!", $fa, $f7
    db $ef, $ee, "I'm mimicking an", $ef, $ee, "Octokid's moves.", $f7
    db $f0

Message_08_45::
    db $ea, "*: What", $a4, " What are", $f1
    db "you doing? Stop!", $f7
    db $f0

Message_08_46::
    db $ea, "Kameha: Gahahah!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "Looks like we made", $ef, $ee, "it here first!", $fa, $f7
    db $ef, $ee, "All we have to do", $ef, $ee, "now is get the", $fa, $f7
    db $ef, $ee, "MoonRock from the", $ef, $ee, "mermaids, and the", $fa, $f7
    db $ef, $ee, "pirate's loot will", $ef, $ee, "be all mine!", $fa, $f7
    db $ef, $ee, "Sit back and watch", $ef, $ee, "our soaring dance!", $f7
    db $f0

Message_08_47::
    db $ea, "Kameha: ", $a4, "So where", $f1
    db "are the mermaids?", $fa, $f7
    db $ef, $ee, "That geezer was", $ef, $ee, "pulling our legs!", $f7
    db $f0

Message_08_48::
    db $ea, "*: Oh, my", $a4, " Who were", $f1
    db "those barbarians?", $fa, $f7
    db $ef, $ee, "How perfectly", $ef, $ee, "shocking and rude!", $f7
    db $f0

Message_08_49::
    db $eb, "*: Bravo, bravo!", $f1
    db "You were fabulous!", $fa, $f7
    db $ef, $ee, "You have a certain", $ef, $ee, "flair for genius!", $fa, $f7
    db $ef, $ee, "Oh? You say you", $ef, $ee, "want the MoonRock?", $fa, $f7
    db $ef, $ee, "Well", $a4, " All right.", $ef, $ee, "Your monsters say", $fa, $f7
    db $ef, $ee, "that you're a good", $ef, $ee, "human.", $fa, $f7
    db $ef, $ee, "I'll take you to", $ef, $ee, "our Queen.", $fa, $f7
    db $ef, $ee, "Close your eyes a", $ef, $ee, "little while.", $f7
    db $f0

Message_08_4A::
    db $ea, "*: I'm astonished.", $f1
    db "Mermaids exist.", $f7
    db $f0

Message_08_4B::
    db $eb, "*: Do you want to", $f1
    db "go to the kingdom", $fa, $f7
    db $ef, $ee, "of mermaids?", $ef, $ee, $ff, $f0

Message_08_4C::
    db $eb, "*: Close your eyes", $f1
    db "a little while.", $f7
    db $f0

Message_08_4D::
    db $eb, "*: Come back for a", $f1
    db "visit anytime!", $fa, $f7
    db $ef, $ee, "You'll always be", $ef, $ee, "welcome here!", $f7
    db $f0

Message_08_4E::
    db $eb, "*: This is the", $f1
    db "mermaid kingdom.", $fa, $f7
    db $ef, $ee, "It is built on the", $ef, $ee, "ocean floor.", $fa, $f7
    db $ef, $ee, "It's very rare to", $ef, $ee, "see a human here.", $fa, $f7
    db $ef, $ee, "Tell me if you", $ef, $ee, "want to go home.", $f7
    db $f0

Message_08_4F::
    db $eb, "*: I know not all", $f1
    db "humans are bad", $a4, $fa, $f7
    db $ef, $ee, "But the pirates", $ef, $ee, "who stole our", $fa, $f7
    db $ef, $ee, "treasure were", $ef, $ee, "humans too.", $fa, $f7
    db $ef, $ee, "I hope HarMirror", $ef, $ee, "is not being used", $fa, $f7
    db $ef, $ee, "for their wicked", $ef, $ee, "misdeeds", $a4, $f7
    db $f0

Message_08_50::
    db $eb, "*: The pirates", $f1
    db "caught us in nets", $fa, $f7
    db $ef, $ee, "and blackmailed", $ef, $ee, "our Queen into", $fa, $f7
    db $ef, $ee, "handing over our", $ef, $ee, "treasures", $a4, $f7
    db $f0

Message_08_51::
    db $eb, "*: The HarMirror", $f1
    db "was exquisite.", $fa, $f7
    db $ef, $ee, "It was so flawless", $ef, $ee, "that it made real", $fa, $f7
    db $ef, $ee, "its reflection", $ef, $ee, "while the original", $fa, $f7
    db $ef, $ee, "ceased to exist in", $ef, $ee, "this world.", $f7
    db $f0

Message_08_52::
    db $eb, "*: The MoonRock", $f1
    db "fell from the sky.", $fa, $f7
    db $ef, $ee, "It glows like the", $ef, $ee, "Moon at night.", $f7
    db $f0

Message_08_53::
    db $eb, "*: The pirates sank", $f1
    db "with their ship.", $fa, $f7
    db $ef, $ee, "However, their", $ef, $ee, "greed for treasure", $fa, $f7
    db $ef, $ee, "would not allow", $ef, $ee, "them to rest easy.", $fa, $f7
    db $ef, $ee, "They now drift the", $ef, $ee, "sea as the ghostly", $fa, $f7
    db $ef, $ee, "crew of a spectral", $ef, $ee, "ship.", $f7
    db $f0

Message_08_54::
    db $eb, "*: We mermaids are", $f1
    db "peaceful beings.", $fa, $f7
    db $ef, $ee, "We shy away from", $ef, $ee, "violence.", $fa, $f7
    db $ef, $ee, "The thought of a", $ef, $ee, "haunted ship", $fa, $f7
    db $ef, $ee, "roaming the sea", $ef, $ee, "makes us uneasy.", $fa, $f7
    db $ef, $ee, "It will make our", $ef, $ee, "scales go coarse.", $f7
    db $f0

Message_08_55::
    db $eb, "*: Welcome, young", $f1
    db "human.", $fa, $f7
    db $ef, $ee, "I heard that you", $ef, $ee, "seek the MoonRock", $fa, $f7
    db $ef, $ee, "to land on the", $ef, $ee, "volcanic island.", $fa, $f7
    db $ef, $ee, "The MoonRock is no", $ef, $ee, "longer here.", $fa, $f7
    db $ef, $ee, "But I can tell you", $ef, $ee, "where it is.", $fa, $f7
    db $ef, $ee, "It remains on the", $ef, $ee, "ghost ship.", $fa, $f7
    db $ef, $ee, "It is a spectral", $ef, $ee, "ship manned by the", $fa, $f7
    db $ef, $ee, "spirits of pirates", $ef, $ee, "who died at sea.", $fa, $f7
    db $ef, $ee, "Driven by greed", $ef, $ee, "for treasures, the", $fa, $f7
    db $ef, $ee, "ship still wanders", $ef, $ee, "upon the waves.", $fa, $f7
    db $ef, $ee, "Look north from", $ef, $ee, "Yold for her.", $f7
    db $f0

Message_08_56::
    db $eb, "*: Ah, your will", $f1
    db "appears strong.", $fa, $f7
    db $ef, $ee, "You deserve to", $ef, $ee, "hear the truth.", $fa, $f7
    db $ef, $ee, "The MoonRock is on", $ef, $ee, "the ghost ship.", $fa, $f7
    db $ef, $ee, "It is a spectral", $ef, $ee, "ship manned by the", $fa, $f7
    db $ef, $ee, "spirits of pirates", $ef, $ee, "who died at sea.", $fa, $f7
    db $ef, $ee, "Driven by greed", $ef, $ee, "for treasures, the", $fa, $f7
    db $ef, $ee, "ship still wanders", $ef, $ee, "upon the waves.", $fa, $f7
    db $ef, $ee, "Look north from", $ef, $ee, "Yold for her.", $f7
    db $f0

Message_08_57::
    db $eb, "*: I see", $a4, " It can't", $f1
    db "be helped, then.", $fa, $f7
    db $ef, $ee, "However, if your", $ef, $ee, "destination is the", $fa, $f7
    db $ef, $ee, "volcanic island,", $ef, $ee, "you cannot help", $fa, $f7
    db $ef, $ee, "but come across", $ef, $ee, "the ghost ship.", $f7
    db $f0

Message_08_58::
    db $eb, "*: The MoonRock is", $f1
    db "on the ghost ship.", $fa, $f7
    db $ef, $ee, "It is a spectral", $ef, $ee, "ship manned by the", $fa, $f7
    db $ef, $ee, "spirits of pirates", $ef, $ee, "who died at sea.", $fa, $f7
    db $ef, $ee, "Driven by greed", $ef, $ee, "for treasures, the", $fa, $f7
    db $ef, $ee, "ship still wanders", $ef, $ee, "upon the waves.", $fa, $f7
    db $ef, $ee, "Look north from", $ef, $ee, "Yold for her.", $f7
    db $f0

Message_08_59::
    db $ea, "*: How could we die", $f1
    db "before enjoying", $fa, $f7
    db $ef, $ee, "all the loot we", $ef, $ee, "amassed", $a4, $f7
    db $f0

Message_08_5A::
    db $ea, "*: The treasures", $f1
    db "are ours", $a4, $fa, $f7
    db $ef, $ee, "No one will take", $ef, $ee, "them from us", $a4, $f7
    db $f0

Message_08_5B::
    db $ea, "*: This is what", $f1
    db "became of us", $a4, $fa, $f7
    db $ef, $ee, "The pirates who", $ef, $ee, "savaged the seas", $a4, $f7
    db $f0

Message_08_5C::
    db $ea, "*: It nags and nags", $f1
    db "that we left our", $fa, $f7
    db $ef, $ee, "treasures behind", $a4, $ef, $ee, $f7
    db $f0

Message_08_5D::
    db $ea, "*: Check the wooden", $f1
    db "crate", $a4, $f7
    db $f0

Message_08_5E::
    db $ea, "*: Who disturbs us", $f1
    db "in our sleep", $a4, $fa, $f7
    db $ef, $ee, "Oh? There are", $ef, $ee, "still fools", $fa, $f7
    db $ef, $ee, "chasing our", $ef, $ee, "treasures after", $fa, $f7
    db $ef, $ee, "all this time?", $ef, $ee, $f7
    db $f0

Message_08_5F::
    db $ea, "*: ", $a4, "You seem to not", $f1
    db "understand", $a4, $fa, $f7
    db $ef, $ee, "The treasures", $ef, $ee, "belong to us.", $fa, $f7
    db $ef, $ee, "You shall see how", $ef, $ee, "powerless you are", $a4, $f7
    db $f0

Message_08_60::
    db $ea, "*: Child", $a4, $f1
    db "We have lost", $a4, $fa, $f7
    db $ef, $ee, "Finally, we can", $ef, $ee, "sleep", $a4, $f7
    db $f0

Message_08_61::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "A mummified fish", $ef, $ee, "lay inside.", $f7
    db $f0

Message_08_62::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "There were dry,", $ef, $ee, "shriveled fruits.", $f7
    db $f0

Message_08_63::
    db $f9, "0 checked the", $f1
    db "crate.", $fa, $f7
    db $ef, $ee, "There was a hidden", $ef, $ee, "staircase.", $f7
    db $f0

Message_08_64::
    db $f9, "0 checked the", $f1
    db "ledger.", $fa, $f7
    db $ef, $ee, "'Voyage Log", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Sunrise obscured", $ef, $ee, "by deep fog", $a4, $fa, $f7
    db $ef, $ee, "Lookout reports", $a4, $ef, $ee, "there is some", $a4, $95, $f7
    db $f0

Message_08_65::
    db $f9, "0 checked the", $f1
    db "pedestal.", $fa, $f7
    db $ef, $ee, "It has a hole to", $ef, $ee, "accept an item.", $f7
    db $f0

Message_08_66::
    db "The MoonRock fit", $f1
    db "snugly into place.", $f7
    db $f0

Message_08_67::
    db $f9, "0 checked the", $f1
    db "pedestal.", $fa, $f7
    db $ef, $ee, "The MoonRock sat", $ef, $ee, "on the pedestal.", $f7
    db $f0

Message_08_68::
    db $ea, "Kameha: Wahahahah!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "Thanks for guiding", $ef, $ee, "me here!", $fa, $f7
    db $ef, $ee, "I figured that you", $ef, $ee, "would figure out", $fa, $f7
    db $ef, $ee, "where the loot was", $ef, $ee, "so I tailed you!", $fa, $f7
    db $ef, $ee, "I'll take the", $ef, $ee, "treasures home!", $f7
    db $f0

Message_08_69::
    db $ea, "Kameha: Urk! How", $44, $f1
    db "you catch up?", $fa, $f7
    db $ef, $ee, "You're faster than", $ef, $ee, "you look", $a4, $fa, $f7
    db $ef, $ee, "Come on, mateys!", $ef, $ee, "Follow me!", $f7
    db $f0

Message_08_6A::
    db $ea, "*: ", $a4, "Aye, aye, sir!", $f1
    db "Right behind you!", $f7
    db $f0

Message_08_6B::
    db $ea, "Kameha: Arrrrh,", $f1
    db "clear the way!", $fa, $f7
    db $ef, $ee, "I'm grabbing the", $ef, $ee, "treasure first!", $f7
    db $f0

Message_08_6C::
    db $ea, "Kameha: ", $a4, "Gasp", $a4, $f1
    db $a4, "Hack", $a4, " I did it", $a4, $fa, $f7
    db $ef, $ee, "The treasures are", $ef, $ee, "mine! All mine!", $f7
    db $f0

Message_08_6D::
    db $ea, "Kameha: What?!", $f1
    db "What is this?", $f7
    db $f0

Message_08_6E::
    db $ea, "*: Kahahaha", $a4, $f1
    db $f7
    db $f0

Message_08_6F::
    db $ea, "*: This is what it", $f1
    db "means, nincompoop!", $fa, $f7
    db $ef, $ee, "You put us through", $ef, $ee, "all this trouble", $a4, $fa, $f7
    db $ef, $ee, "Saying how we", $ef, $ee, "needed your help", $fa, $f7
    db $ef, $ee, "to find the", $ef, $ee, "treasure", $a4, $fa, $f7
    db $ef, $ee, "That you wouldn't", $ef, $ee, "cooperate unless", $fa, $f7
    db $ef, $ee, "we became your", $ef, $ee, "sidekicks, pah!", $fa, $f7
    db $ef, $ee, "For all that talk,", $ef, $ee, "you were useless!", $fa, $f7
    db $ef, $ee, "We'll take the loot", $ef, $ee, "for our King!", $fa, $f7
    db $ef, $ee, "You're not worthy", $ef, $ee, "of it anyway!", $f7
    db $f0

Message_08_70::
    db $ea, "Kameha: Urrrggh", $a4, $f1
    db "You tricked me!", $fa, $f7
    db $ef, $ee, "You're not getting", $ef, $ee, "away with this!", $f7
    db $f0

Message_08_71::
    db $ea, "Kameha: I was", $f1
    db "stupid to trust", $fa, $f7
    db $ef, $ee, "and believe in", $ef, $ee, "those monsters", $a4, $fa, $f7
    db $ef, $ee, "You take the loot", $ef, $ee, "back", $a4, " Later!", $f7
    db $f0

Message_08_72::
    db "A voice echoed", $f1
    db "from nowhere", $a4, $f7
    db $f0

Message_08_73::
    db $ea, "*: ", $a4, "Wa-hey!", $f1
    db $f9, "0, hear me?", $fa, $f7
    db $ef, $ee, "I felt an odd", $ef, $ee, "power stirring.", $fa, $f7
    db $ef, $ee, "You found a plug", $ef, $ee, "for the Navel!", $fa, $f7
    db $ef, $ee, "I'll bring you", $ef, $ee, "back! Don't move!", $f7
    db $f0

Message_08_74::
    db $ea, "*: I haven't seen", $f1
    db "the ghost ship in", $fa, $f7
    db $ef, $ee, "some time now, but", $ef, $ee, "I'm still afraid", $fa, $f7
    db $ef, $ee, "to get out of bed", $ef, $ee, "at night", $a4, $f7
    db $f0

Message_08_75::
    db $ea, "*: The volcanic", $f1
    db "island appears to", $fa, $f7
    db $ef, $ee, "have calmed down", $ef, $ee, "again.", $fa, $f7
    db $ef, $ee, "Perhaps it took a", $ef, $ee, "sacrifice", $a4, $f7
    db $f0

Message_08_76::
    db $eb, "*: Sigh", $a4, " Will the", $f1
    db "HarMirror make me", $fa, $f7
    db $ef, $ee, "appear beautiful", $ef, $ee, "on the other side", $a4, $f7
    db $f0

Message_08_77::
    db $ea, "*: My grandson just", $f1
    db "shivers now", $a4, $fa, $f7
    db $ef, $ee, "He's been wetting", $ef, $ee, "the bed too", $a4, $f7
    db $f0

Message_08_78::
    db $ea, "*: The mermaids", $f1
    db "came back.", $f7
    db $f0

Message_08_79::
    db $ea, "*: I've seen", $f1
    db "mermaids too.", $fa, $f7
    db $ef, $ee, "I think I'm in", $ef, $ee, "love!", $f7
    db $f0

Message_08_7A::
    db $ea, "*: The pirates hid", $f1
    db "their loot on the", $fa, $f7
    db $ef, $ee, "volcanic island,", $ef, $ee, "I heard!", $fa, $f7
    db $ef, $ee, "All these years", $ef, $ee, "searching, and it", $fa, $f7
    db $ef, $ee, "was always right", $ef, $ee, "before my eyes!", $f7
    db $f0

Message_08_7B::
    db $ea, "*: The sea around", $f1
    db "here is safe now.", $fa, $f7
    db $ef, $ee, "The town should be", $ef, $ee, "revitalized.", $f7
    db $f0

Message_08_7C::
    db $ea, "*: The MoonRock", $f1
    db "glows at night", $fa, $f7
    db $ef, $ee, "from atop the", $ef, $ee, "lighthouse again.", $fa, $f7
    db $ef, $ee, "Someone restored", $ef, $ee, "it to its place.", $f7
    db $f0

Message_08_7D::
    db $eb, "*: The sea's level", $f1
    db "has risen.", $fa, $f7
    db $ef, $ee, "No ships have", $ef, $ee, "foundered lately.", $f7
    db $f0

Message_08_7E::
    db $ea, "*: For some reason,", $f1
    db "the shoals sank", $fa, $f7
    db $ef, $ee, "almost instantly.", $ef, $ee, "It's a good thing.", $fa, $f7
    db $ef, $ee, "Ships should come", $ef, $ee, "back to restore", $fa, $f7
    db $ef, $ee, "the town to its", $ef, $ee, "former glory.", $f7
    db $f0

Message_08_7F::
    db $ea, "*: Did you hear?", $f1
    db "Pirates hid their", $fa, $f7
    db $ef, $ee, "treasure on the", $ef, $ee, "volcanic island.", $fa, $f7
    db $ef, $ee, "I should have", $ef, $ee, "listened to the", $fa, $f7
    db $ef, $ee, "geezer and gone to", $ef, $ee, "see for myself", $a4, $f7
    db $f0

Message_08_80::
    db $ea, "*: What?", $f1
    db "You again?", $fa, $f7
    db $ef, $ee, "Back to hear more", $ef, $ee, "of my tales?", $fa, $f7
    db $ef, $ee, "Hah? No, no!", $ef, $ee, "The treasure on", $fa, $f7
    db $ef, $ee, "the sunken ship is", $ef, $ee, "a secret!", $f7
    db $f0

Message_08_81::
    db $eb, "*: Our words of", $f1
    db "thanks could never", $fa, $f7
    db $ef, $ee, "do justice to the", $ef, $ee, "way we feel.", $f7
    db $f0

Message_08_82::
    db $eb, "*: Mermaids and", $f1
    db "humans can live", $fa, $f7
    db $ef, $ee, "side by side in", $ef, $ee, "harmony again!", $f7
    db $f0

Message_08_83::
    db $eb, "*: Thanks to you,", $f1
    db "the spectral ship", $fa, $f7
    db $ef, $ee, "sank again, this", $ef, $ee, "time for good.", $fa, $f7
    db $ef, $ee, "The cravings of", $ef, $ee, "the ghostly crew", $fa, $f7
    db $ef, $ee, "for treasures must", $ef, $ee, "have been quelled.", $f7
    db $f0

Message_08_84::
    db $eb, "*: That wandering", $f1
    db "ghost ship's gone!", $fa, $f7
    db $ef, $ee, "My scales will", $ef, $ee, "be glossy once", $fa, $f7
    db $ef, $ee, "again!", $ef, $ee, $f7
    db $f0

Message_08_85::
    db $eb, "*: Welcome, young", $f1
    db "hero!", $fa, $f7
    db $ef, $ee, "No words could", $ef, $ee, "ever adequately", $fa, $f7
    db $ef, $ee, "express our", $ef, $ee, "gratitude!", $f7
    db $f0

Message_08_86::
    db $f9, "N's", $f1
    db "dancing lured", $fa, $f7
    db $ef, $ee, "a mermaid to the", $ef, $ee, "surface.", $f7
    db $f0
    ds $124, $00
