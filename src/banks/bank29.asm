SECTION "Bank 29", ROMX[$4000], BANK[$29]
    db $29

; message bank $29: when wStringIndex < $8E, BeginStringDisplay with this bank's table
; MessageStrings_Bank29; otherwise far-calls BeginStringDisplay_Bank29_Overflow (E-0080)
BeginStringDisplay_Bank29::
    ld a, [wStringIndex]
    cp $8e
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank29_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank29
    call BeginStringDisplay
    ret

; message bank $29: when wStringIndex < $8E, CopyStringToBuffer with this bank's table
; MessageStrings_Bank29; otherwise far-calls CopyStringToBuffer_Bank29_Overflow (E-0080)
CopyStringToBuffer_Bank29::
    ld a, [wStringIndex]
    cp $8e
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank29_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank29
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_29_4032::
MessageStrings_Bank29::
    dw StringList_29_4034 ; id 0

; category list of StringCategories_29_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_29_4034::
    dw Message_01_00 ; id 0
    dw Message_01_01 ; id 1
    dw Message_01_02 ; id 2
    dw Message_01_03 ; id 3
    dw Message_01_04 ; id 4
    dw Message_01_05 ; id 5
    dw Message_01_06 ; id 6
    dw Message_01_07 ; id 7
    dw Message_01_08 ; id 8
    dw Message_01_09 ; id 9
    dw Message_01_0A ; id 10
    dw Message_01_0B ; id 11
    dw Message_01_0C ; id 12
    dw Message_01_0D ; id 13
    dw Message_01_0E ; id 14
    dw Message_01_0F ; id 15
    dw Message_01_10 ; id 16
    dw Message_01_11 ; id 17
    dw Message_01_12 ; id 18
    dw Message_01_13 ; id 19
    dw Message_01_14 ; id 20
    dw Message_01_15 ; id 21
    dw Message_01_16 ; id 22
    dw Message_01_17 ; id 23
    dw Message_01_18 ; id 24
    dw Message_01_19 ; id 25
    dw Message_01_1A ; id 26
    dw Message_01_1B ; id 27
    dw Message_01_1C ; id 28
    dw Message_01_1D ; id 29
    dw Message_01_1E ; id 30
    dw Message_01_1F ; id 31
    dw Message_01_20 ; id 32
    dw Message_01_21 ; id 33
    dw Message_01_22 ; id 34
    dw Message_01_22 ; id 35
    dw Message_01_22 ; id 36
    dw Message_01_22 ; id 37
    dw Message_01_26 ; id 38
    dw Message_01_27 ; id 39
    dw Message_01_28 ; id 40
    dw Message_01_29 ; id 41
    dw Message_01_2A ; id 42
    dw Message_01_2B ; id 43
    dw Message_01_2C ; id 44
    dw Message_01_2D ; id 45
    dw Message_01_2E ; id 46
    dw Message_01_2E ; id 47
    dw Message_01_2E ; id 48
    dw Message_01_31 ; id 49
    dw Message_01_32 ; id 50
    dw Message_01_33 ; id 51
    dw Message_01_34 ; id 52
    dw Message_01_35 ; id 53
    dw Message_01_36 ; id 54
    dw Message_01_37 ; id 55
    dw Message_01_38 ; id 56
    dw Message_01_39 ; id 57
    dw Message_01_3A ; id 58
    dw Message_01_3B ; id 59
    dw Message_01_3C ; id 60
    dw Message_01_3D ; id 61
    dw Message_01_3E ; id 62
    dw Message_01_3F ; id 63
    dw Message_01_40 ; id 64
    dw Message_01_41 ; id 65
    dw Message_01_42 ; id 66
    dw Message_01_43 ; id 67
    dw Message_01_44 ; id 68
    dw Message_01_45 ; id 69
    dw Message_01_46 ; id 70
    dw Message_01_47 ; id 71
    dw Message_01_48 ; id 72
    dw Message_01_49 ; id 73
    dw Message_01_4A ; id 74
    dw Message_01_4B ; id 75
    dw Message_01_4C ; id 76
    dw Message_01_4D ; id 77
    dw Message_01_4E ; id 78
    dw Message_01_4F ; id 79
    dw Message_01_50 ; id 80
    dw Message_01_51 ; id 81
    dw Message_01_52 ; id 82
    dw Message_01_53 ; id 83
    dw Message_01_54 ; id 84
    dw Message_01_55 ; id 85
    dw Message_01_56 ; id 86
    dw Message_01_57 ; id 87
    dw Message_01_58 ; id 88
    dw Message_01_59 ; id 89
    dw Message_01_5A ; id 90
    dw Message_01_5B ; id 91
    dw Message_01_5C ; id 92
    dw Message_01_5D ; id 93
    dw Message_01_5E ; id 94
    dw Message_01_5F ; id 95
    dw Message_01_60 ; id 96
    dw Message_01_61 ; id 97
    dw Message_01_62 ; id 98
    dw Message_01_63 ; id 99
    dw Message_01_64 ; id 100
    dw Message_01_65 ; id 101
    dw Message_01_66 ; id 102
    dw Message_01_67 ; id 103
    dw Message_01_68 ; id 104
    dw Message_01_69 ; id 105
    dw Message_01_6A ; id 106
    dw Message_01_6B ; id 107
    dw Message_01_6C ; id 108
    dw Message_01_6D ; id 109
    dw Message_01_6E ; id 110
    dw Message_01_6F ; id 111
    dw Message_01_70 ; id 112
    dw Message_01_71 ; id 113
    dw Message_01_72 ; id 114
    dw Message_01_73 ; id 115
    dw Message_01_74 ; id 116
    dw Message_01_75 ; id 117
    dw Message_01_76 ; id 118
    dw Message_01_77 ; id 119
    dw Message_01_78 ; id 120
    dw Message_01_79 ; id 121
    dw Message_01_7A ; id 122
    dw Message_01_7B ; id 123
    dw Message_01_7C ; id 124
    dw Message_01_7D ; id 125
    dw Message_01_7E ; id 126
    dw Message_01_7F ; id 127
    dw Message_01_80 ; id 128
    dw Message_01_81 ; id 129
    dw Message_01_82 ; id 130
    dw Message_01_83 ; id 131
    dw Message_01_84 ; id 132
    dw Message_01_85 ; id 133
    dw Message_01_86 ; id 134
    dw Message_01_87 ; id 135
    dw Message_01_88 ; id 136
    dw Message_01_89 ; id 137
    dw Message_01_8A ; id 138
    dw Message_01_8B ; id 139
    dw Message_01_8C ; id 140
    dw Message_01_8D ; id 141

Message_01_00::
    db $eb, "*: Are you going", $f1
    db "out to play?", $fa, $f7
    db $ef, $ee, "Be careful you", $ef, $ee, "don't get hurt.", $f7
    db $f0

Message_01_01::
    db $f9, "0 received an", $f1
    db "Herb.", $f7
    db $f0

Message_01_02::
    db $eb, "*: It's a beautiful", $f1
    db "day for laundry!", $fa, $f7
    db $ef, $ee, "You shouldn't be", $ef, $ee, "inside on a day", $fa, $f7
    db $ef, $ee, "like this!", $ef, $ee, $f7
    db $f0

Message_01_03::
    db $ea, "Cobi: ", $f9, "0, while", $f1
    db "you're gone, I'll", $fa, $f7
    db $ef, $ee, "stay here and tend", $ef, $ee, "to the monsters.", $fa, $f7
    db $ef, $ee, "If you catch any,", $ef, $ee, "I'll care for them.", $f7
    db $f0

Message_01_04::
    db $eb, "Tara: Big brother,", $f1
    db "while you're in", $fa, $f7
    db $ef, $ee, "another world,", $ef, $ee, "I'll stay here.", $fa, $f7
    db $ef, $ee, "I'll look after", $ef, $ee, "your monsters,", $fa, $f7
    db $ef, $ee, "so be sure to send", $ef, $ee, "them back to me.", $f7
    db $f0

Message_01_05::
    db $ea, "*: Why do you have", $f1
    db "a monster in tow?", $fa, $f7
    db $ef, $ee, "Are you going to", $ef, $ee, "become a master?", $fa, $f7
    db $ef, $ee, "If you are, or if", $ef, $ee, "you're going to", $fa, $f7
    db $ef, $ee, "inherit this farm,", $ef, $ee, "the key is to be", $fa, $f7
    db $ef, $ee, "friendly with", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "To break the ice,", $ef, $ee, "feed them meat.", $fa, $f7
    db $ef, $ee, "That will make", $ef, $ee, "them less wary.", $f7
    db $f0

Message_01_06::
    db $f9, "0 received a", $ef, $ee, "PorkChop.", $f7
    db $f0

Message_01_07::
    db $ea, "*: To win the trust", $f1
    db "of monsters, feed", $fa, $f7
    db $ef, $ee, "them some meat", $ef, $ee, "right away.", $fa, $f7
    db $ef, $ee, "You can battle", $ef, $ee, "them after, and", $fa, $f7
    db $ef, $ee, "rid them of their", $ef, $ee, "wild nature.", $f7
    db $f0

Message_01_08::
    db $ea, "*: It looks like", $f1
    db "you've become", $fa, $f7
    db $ef, $ee, "friends with some", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "That's my ", $f9, "0!", $ef, $ee, "You're talented!", $f7
    db $f0

Message_01_09::
    db $ea, "*: Your monsters", $f1
    db "are your friends", $fa, $f7
    db $ef, $ee, "who will serve you", $ef, $ee, "to the end.", $fa, $f7
    db $ef, $ee, "Be sure to raise", $ef, $ee, "them with love!", $f7
    db $f0

Message_01_0A::
    db $ea, "*: Off to another", $f1
    db "world!", $fa, $f7
    db $ef, $ee, "There are many", $ef, $ee, "items to be found", $fa, $f7
    db $ef, $ee, "just lying around", $ef, $ee, "in other worlds.", $fa, $f7
    db $ef, $ee, "They will help you", $ef, $ee, "on your trek!", $f7
    db $f0

Message_01_0B::
    db $ea, "*: A tropical isle", $f1
    db "is too hot for me.", $fa, $f7
    db $ef, $ee, "I might melt and", $ef, $ee, "become a Babble!", $f7
    db $f0

Message_01_0C::
    db $ea, "*: Oh, that's cute!", $f1
    db "Hahahahaha!", $fa, $f7
    db $ef, $ee, "We have a new", $ef, $ee, "monster master!", $f7
    db $f0

Message_01_0D::
    db $ea, "Cobi: Hi, I'm", $f1
    db "helping Papa to", $fa, $f7
    db $ef, $ee, "take care of the", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "You can drop off", $ef, $ee, "or pick up any of", $fa, $f7
    db $ef, $ee, "your monsters here", $ef, $ee, "with me.", $fa, $f7
    db $ef, $ee, "So, what can I do", $ef, $ee, "for you, sis?", $f7
    db $f0

Message_01_0E::
    db $ea, "Cobi: Hi, ", $f9, "0!", $f1
    db "What's up today?", $f7
    db $f0

Message_01_0F::
    db $eb, "Tara: I'm helping", $f1
    db "Papa take care of", $fa, $f7
    db $ef, $ee, "the monsters and", $ef, $ee, "the farm.", $fa, $f7
    db $ef, $ee, "You can drop off", $ef, $ee, "or pick up any of", $fa, $f7
    db $ef, $ee, "your monsters here", $ef, $ee, "with me.", $fa, $f7
    db $ef, $ee, "Do you need me for", $ef, $ee, "anything?", $f7
    db $f0

Message_01_10::
    db $eb, "Tara: Hi!", $f1
    db "How are you?", $fa, $f7
    db $ef, $ee, "Do you need me for", $ef, $ee, "anything today?", $f7
    db $f0

Message_01_11::
    db $ea, "*: Want to know how", $f1
    db "the farm works?", $ff, $f0

Message_01_12::
    db $ea, "*: Including the", $f1
    db "monsters with you,", $fa, $f7
    db $ef, $ee, "the farm can hold", $ef, $ee, "up to ten.", $fa, $f7
    db $ef, $ee, "It's not much to", $ef, $ee, "start, but the", $fa, $f7
    db $ef, $ee, "farm will hold", $ef, $ee, "more as it grows.", $fa, $f7
    db $ef, $ee, "Monsters in the", $ef, $ee, "farm earn some", $fa, $f7
    db $ef, $ee, "EX points as you", $ef, $ee, "battle.", $fa, $f7
    db $ef, $ee, "But if you leave", $ef, $ee, "them in the farm,", $fa, $f7
    db $ef, $ee, "they will grow", $ef, $ee, "without learning", $fa, $f7
    db $ef, $ee, "skills, and they", $ef, $ee, "turn disobedient.", $fa, $f7
    db $ef, $ee, "So, you should", $ef, $ee, "take different", $fa, $f7
    db $ef, $ee, "monsters out to", $ef, $ee, "train them.", $f7
    db $f0

Message_01_13::
    db $ea, "*: Aww", $a4, " You know", $f1
    db "already? Boring!", $f7
    db $f0

Message_01_14::
    db $eb, "*: I haven't seen", $f1
    db "Prince Kameha or", $fa, $f7
    db $ef, $ee, "Warubou today.", $ef, $ee, "I hope they're not", $fa, $f7
    db $ef, $ee, "cooking up new", $ef, $ee, "pranks.", $f7
    db $f0

Message_01_15::
    db $ea, "*: I am a dealer-", $f1
    db "a merchant who", $fa, $f7
    db $ef, $ee, "buys and sells", $ef, $ee, "useful items.", $fa, $f7
    db $ef, $ee, "Now, come back", $ef, $ee, "with a grownup.", $f7
    db $f0

Message_01_16::
    db $eb, "*: You have such", $f1
    db "cute monsters!", $fa, $f7
    db $ef, $ee, "Are you playing", $ef, $ee, "monster master?", $f7
    db $f0

Message_01_17::
    db $eb, "*: I haven't seen", $f1
    db "Prince Kameha or", $fa, $f7
    db $ef, $ee, "Warubou at all.", $ef, $ee, "Perhaps we won't", $fa, $f7
    db $ef, $ee, "need to post", $ef, $ee, "lookouts anymore.", $f7
    db $f0

Message_01_18::
    db $eb, "*: Warubou has gone", $f1
    db "down the well and", $fa, $f7
    db $ef, $ee, "hasn't come back", $ef, $ee, "out yet.", $fa, $f7
    db $ef, $ee, "It's plotting, I", $ef, $ee, "bet.", $f7
    db $f0

Message_01_19::
    db $eb, "*: Monster masters", $f1
    db "are people who can", $fa, $f7
    db $ef, $ee, "open their hearts", $ef, $ee, "to monsters.", $fa, $f7
    db $ef, $ee, "If you're trying to", $ef, $ee, "become a master,", $fa, $f7
    db $ef, $ee, "treat monsters", $ef, $ee, "with love.", $f7
    db $f0

Message_01_1A::
    db $ea, "*: Even the most", $f1
    db "ordinary of days", $fa, $f7
    db $ef, $ee, "brings small", $ef, $ee, "changes.", $fa, $f7
    db $ef, $ee, "So long as there", $ef, $ee, "is somewhere you", $fa, $f7
    db $ef, $ee, "can relax, life", $ef, $ee, "isn't all that bad.", $f7
    db $f0

Message_01_1B::
    db $ea, "*: Hm? Are you a", $f1
    db "master hopeful?", $fa, $f7
    db $ef, $ee, "Well, aren't you a", $ef, $ee, "cute rival!", $f7
    db $f0

Message_01_1C::
    db $ea, "*: Oh, hi! Good to", $f1
    db "see you again!", $fa, $f7
    db $ef, $ee, "This is the Vault.", $ef, $ee, "You can keep your", $fa, $f7
    db $ef, $ee, "money and items", $ef, $ee, "safely here.", $fa, $f7
    db $ef, $ee, "You can take them", $ef, $ee, "out anytime too.", $fa, $f7
    db $ef, $ee, "It's free, so feel", $ef, $ee, "free to use us!", $fa, $f7
    db $ef, $ee, "So, how may I", $ef, $ee, "serve you today?", $f7
    db $f0

Message_01_1D::
    db $ea, "*: How may the", $f1
    db "Vault serve you?", $f7
    db $f0

Message_01_1E::
    db $ea, "*: If your party is", $f1
    db "wiped out, half", $fa, $f7
    db $ef, $ee, "your money's gone,", $ef, $ee, "just like that.", $fa, $f7
    db $ef, $ee, "But any money in", $ef, $ee, "the Vault is safe.", $fa, $f7
    db $ef, $ee, "Better saved than", $ef, $ee, "sorry, just like", $fa, $f7
    db $ef, $ee, "your Journal.", $ef, $ee, "Travel smart!", $f7
    db $f0

Message_01_1F::
    db $ea, "Warubou: Wa-hey!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "You remember the", $ef, $ee, "promise you made?", $ff, $f0

Message_01_20::
    db $ea, "Warubou: Quit", $f1
    db "dawdling, warooh!", $f7
    db $f0

Message_01_21::
    db $ea, "Warubou: Use a", $f1
    db "Magic Key and open", $fa, $f7
    db $ef, $ee, "the Magic Door in", $ef, $ee, "chamber ahead!", $fa, $f7
    db $ef, $ee, "Go to another", $ef, $ee, "world and find", $fa, $f7
    db $ef, $ee, "a plug for the", $ef, $ee, "Log's Navel!", $fa, $f7
    db $ef, $ee, "Use GreatLog Key", $ef, $ee, "to come back.", $fa, $f7
    db $ef, $ee, "That is all!", $ef, $ee, "Hurry, wa-hey!", $f7
    db $f0

Message_01_22::
    db $ea, "Warubou: Wa-hey!", $f1
    db "You did it, ", $f9, "0!", $fa, $f7
    db $ef, $ee, "I'll give you", $ef, $ee, "GreatLog's power!", $f7
    db $f0

Message_01_26::
    db $ea, "Warubou: There,", $f1
    db "your party's fine!", $fa, $f7
    db $ef, $ee, "So, the new plug", $ef, $ee, "for the Navel?", $f7
    db $f0

Message_01_27::
    db $ea, "Warubou: Wa-hey!", $f1
    db "So, this is it?", $fa, $f7
    db $ef, $ee, "This is the", $ef, $ee, "TidalBell, warooh?", $fa, $f7
    db $ef, $ee, "It exudes an odd", $ef, $ee, "power, yes.", $fa, $f7
    db $ef, $ee, "We'll see if it", $ef, $ee, "works, warooh!", $f7
    db $f0

Message_01_28::
    db $ea, "Warubou: Wa-hey!", $f1
    db "That's it!", $fa, $f7
    db $ef, $ee, "GreatLog is saved!", $ef, $ee, "Good, now", $a4, " Warooh?", $f7
    db $f0

Message_01_29::
    db $ea, "Warubou: Wa-hey!", $f1
    db "No good, no good!", $fa, $f7
    db $ef, $ee, "I have to plug the", $ef, $ee, "Navel again!", $f7
    db $f0

Message_01_2A::
    db $ea, "Warubou: Wa-hey", $a4, $f1
    db "That was no good.", $fa, $f7
    db $ef, $ee, "But TidalBell has", $ef, $ee, "magic in it.", $fa, $f7
    db $ef, $ee, "Give me your hand.", $ef, $ee, "I hold it, and", $a4, $fa, $f7
    db $ef, $ee, "Wa-hey!", $ef, $ee, $f7
    db $f0

Message_01_2B::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Stop that!", $fa, $f7
    db $ef, $ee, "Why do you look so", $ef, $ee, "nasty at me?", $fa, $f7
    db $ef, $ee, "A hero should have", $ef, $ee, "the valor to clean", $fa, $f7
    db $ef, $ee, "up after someone", $ef, $ee, "else's mess!", $fa, $f7
    db $ef, $ee, "Come on, give me a", $ef, $ee, "big smile, warooh!", $f7
    db $f0

Message_01_2C::
    db $ea, "Warubou: Listen.", $f1
    db "I feel a strange", $fa, $f7
    db $ef, $ee, "power in another", $ef, $ee, "world, warooh.", $fa, $f7
    db $ef, $ee, "It has to be a", $ef, $ee, "plug, I know it!", $fa, $f7
    db $ef, $ee, "But I've no power", $ef, $ee, "to make a key", $a4, $fa, $f7
    db $ef, $ee, "That power is from", $ef, $ee, "GreatLog's tree.", $fa, $f7
    db $ef, $ee, "It is energy made", $ef, $ee, "by the bond tying", $fa, $f7
    db $ef, $ee, "people and their", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "Help people bond", $ef, $ee, "with monsters, and", $fa, $f7
    db $ef, $ee, "GreatLog's power", $ef, $ee, "will be boosted.", $f7
    db $f0

Message_01_2D::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0?", $fa, $f7
    db $ef, $ee, "Angry still with", $ef, $ee, "me, warooh?", $fa, $f7
    db $ef, $ee, "Anger is no good", $ef, $ee, "between friends!", $fa, $f7
    db $ef, $ee, "We're friends, so", $ef, $ee, "no anger, ", $f9, "0!", $ff, $f0

Message_01_2E::
    db $ea, "*: This is Kalka,", $f1
    db "an oasis village.", $f7
    db $f0

Message_01_31::
    db $ea, "*: A thieving band", $f1
    db "runs amok here.", $fa, $f7
    db $ef, $ee, "It's impossible to", $ef, $ee, "get any decent", $fa, $f7
    db $ef, $ee, "sleep because of", $ef, $ee, "their threat.", $f7
    db $f0

Message_01_32::
    db $eb, "*: Pardon? A plug", $f1
    db "for a navel?", $fa, $f7
    db $ef, $ee, "Sorry, I have no", $ef, $ee, "idea what that is.", $f7
    db $f0

Message_01_33::
    db $eb, "*: The oasis' water", $f1
    db "travels through an", $fa, $f7
    db $ef, $ee, "underground canal", $ef, $ee, "to Asiya.", $fa, $f7
    db $ef, $ee, "Asiya? It's a town", $ef, $ee, "that's due south.", $f7
    db $f0

Message_01_34::
    db $ea, "*: The leader of", $f1
    db "the thieves is a", $fa, $f7
    db $ef, $ee, "fearsome man.", $ef, $ee, "He commands horrid", $fa, $f7
    db $ef, $ee, "monsters to rob", $ef, $ee, "people.", $f7
    db $f0

Message_01_35::
    db $eb, "*: The Log's Navel?", $f1
    db "What is that?", $fa, $f7
    db $ef, $ee, "I can show you my", $ef, $ee, "navel on the sly.", $f7
    db $f0

Message_01_36::
    db $ea, "*: The Log's Navel?", $f1
    db "Let me think", $a4, $fa, $f7
    db $ef, $ee, "Perhaps the King", $ef, $ee, "in Asiya will", $f7
    db $ef, $ee, "know.", $ef, $ee, $f7
    db $f0

Message_01_37::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "A sharp, spicy", $ef, $ee, "aroma wafted out.", $f7
    db $f0

Message_01_38::
    db $ea, "*: The underground", $f1
    db "canal is ahead.", $fa, $f7
    db $ef, $ee, "The last King made", $ef, $ee, "it for our people", $fa, $f7
    db $ef, $ee, "when there were", $ef, $ee, "water shortages.", $fa, $f7
    db $ef, $ee, "It was a hard,", $ef, $ee, "hard task.", $f7
    db $f0

Message_01_39::
    db $eb, "*: The King called", $f1
    db "a circus troupe to", $fa, $f7
    db $ef, $ee, "the town in the", $ef, $ee, "south.", $fa, $f7
    db $ef, $ee, "I hope they weren't", $ef, $ee, "mauled by thugs.", $f7
    db $f0

Message_01_3A::
    db $ea, "*: This is Asiya,", $f1
    db "the desert flower.", $f7
    db $f0

Message_01_3B::
    db $ea, "*: Our King came", $f1
    db "into an enormous", $fa, $f7
    db $ef, $ee, "inheritance. It", $ef, $ee, "was mind-boggling.", $fa, $f7
    db $ef, $ee, "His treasury is", $ef, $ee, "overflowing with", $fa, $f7
    db $ef, $ee, "incredible gold", $ef, $ee, "and treasures.", $fa, $f7
    db $ef, $ee, "He's said to be", $ef, $ee, "particularly proud", $fa, $f7
    db $ef, $ee, "of something", $ef, $ee, "called TidalBell.", $f7
    db $f0

Message_01_3C::
    db $ea, "*: I saw a lake", $f1
    db "like a mirage.", $fa, $f7
    db $ef, $ee, "In the east of the", $ef, $ee, "desert, it was.", $fa, $f7
    db $ef, $ee, "But it disappeared", $ef, $ee, "as if by magic", $a4, $f7
    db $f0

Message_01_3D::
    db $eb, "*: Strong monsters", $f1
    db "are in the well.", $fa, $f7
    db $ef, $ee, "You", $44, " better be", $ef, $ee, "prepared if you", $fa, $f7
    db $ef, $ee, "are going down in", $ef, $ee, "there.", $f7
    db $f0

Message_01_3E::
    db $ea, "*: Our King has", $f1
    db "been a fan of", $fa, $f7
    db $ef, $ee, "circuses since he", $ef, $ee, "was a child.", $fa, $f7
    db $ef, $ee, "If there is a", $ef, $ee, "circus, he always", $fa, $f7
    db $ef, $ee, "summons the troupe", $ef, $ee, "to the castle.", $f7
    db $f0

Message_01_3F::
    db $ea, "*: The circus", $f1
    db "master was trying", $fa, $f7
    db $ef, $ee, "to recruit people", $ef, $ee, "at the inn.", $fa, $f7
    db $ef, $ee, "He says the troupe", $ef, $ee, "scattered when the", $fa, $f7
    db $ef, $ee, "thieves set on", $ef, $ee, "them.", $fa, $f7
    db $ef, $ee, "Traveling is much", $ef, $ee, "too risky for me!", $f7
    db $f0

Message_01_40::
    db $ea, "*: No one enters", $f1
    db "the castle without", $fa, $f7
    db $ef, $ee, "a proper permit!", $ef, $ee, "Move along!", $f7
    db $f0

Message_01_41::
    db $ea, "*: If you want to", $f1
    db "get in that badly,", $fa, $f7
    db $ef, $ee, "we could arrest", $ef, $ee, "you and toss you", $fa, $f7
    db $ef, $ee, "in the dungeon,", $ef, $ee, "how's that sound?", $f7
    db $f0

Message_01_42::
    db $eb, "*: Did you want", $f1
    db "something, honey?", $fa, $f7
    db $ef, $ee, "A plug for the", $ef, $ee, "Log's Navel?", $fa, $f7
    db $ef, $ee, "Well, the King", $ef, $ee, "likes collecting", $fa, $f7
    db $ef, $ee, "all sorts of odd", $ef, $ee, "things, so he may", $fa, $f7
    db $ef, $ee, "have something", $ef, $ee, "that will work.", $f7
    db $f0

Message_01_43::
    db $ea, "*: When we get a", $f1
    db "hot spell, I sleep", $fa, $f7
    db $ef, $ee, "in the daytime,", $ef, $ee, "and work at night.", $fa, $f7
    db $ef, $ee, "That's the only", $ef, $ee, "way of coping!", $f7
    db $f0

Message_01_44::
    db $ea, "*: Welcome to my", $f1
    db "item shop!", $fa, $f7
    db $ef, $ee, "You may buy or", $ef, $ee, "sell items here.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you today?", $f7
    db $f0

Message_01_45::
    db $ea, "*: Hello! How may I", $f1
    db "serve you today?", $f7
    db $f0

Message_01_46::
    db $ea, "*: The church", $f1
    db "welcomes you.", $fa, $f7
    db $ef, $ee, "We can heal you", $ef, $ee, "from poisoning,", $fa, $f7
    db $ef, $ee, "lift curses, and", $ef, $ee, "revive the dead.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you, my child?", $f7
    db $f0

Message_01_47::
    db $ea, "*: I am a servant", $f1
    db "to the gods.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you, my child?", $f7
    db $f0

Message_01_48::
    db $ea, "*: I am the leader", $f1
    db "of a circus.", $fa, $f7
    db $ef, $ee, "We were invited to", $ef, $ee, "perform before the", $fa, $f7
    db $ef, $ee, "King, but my group", $ef, $ee, "has scattered like", $fa, $f7
    db $ef, $ee, "so many leaves in", $ef, $ee, "a storm.", $fa, $f7
    db $ef, $ee, "So, I am the only", $ef, $ee, "one in my circus.", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "join me as a star?", $ff, $f0

Message_01_49::
    db $ea, "*: Did you say yes?", $f1
    db "Yes, yes, you did!", $fa, $f7
    db $ef, $ee, "Your monsters will", $ef, $ee, "make a fine act!", $fa, $f7
    db $ef, $ee, "You can have top", $ef, $ee, "billing as our one", $fa, $f7
    db $ef, $ee, "and only fearless", $ef, $ee, "monster master!", $fa, $f7
    db $ef, $ee, "Come, we must go", $ef, $ee, "to the castle!", $f7
    db $f0

Message_01_4A::
    db $ea, "*: Did you say yes?", $f1
    db "Yes, yes, you did!", $fa, $f7
    db $ef, $ee, "Your monsters will", $ef, $ee, "make a fine act!", $fa, $f7
    db $ef, $ee, "You can have top", $ef, $ee, "billing as our one", $fa, $f7
    db $ef, $ee, "and only fearless", $ef, $ee, "monster master!", $fa, $f7
    db $ef, $ee, "But a dead monster", $ef, $ee, "is no good.", $fa, $f7
    db $ef, $ee, "It wouldn't look", $ef, $ee, "good as an act.", $fa, $f7
    db $ef, $ee, "You must get three", $ef, $ee, "healthy monsters.", $f7
    db $f0

Message_01_4B::
    db $ea, "*: Did you say yes?", $f1
    db "Yes, yes, you did!", $fa, $f7
    db $ef, $ee, "Your monsters will", $ef, $ee, "make a fine act!", $fa, $f7
    db $ef, $ee, "You can have top", $ef, $ee, "billing as our one", $fa, $f7
    db $ef, $ee, "and only fearless", $ef, $ee, "monster master!", $fa, $f7
    db $ef, $ee, "But you need a", $ef, $ee, "trio of monsters", $fa, $f7
    db $ef, $ee, "to make the act", $ef, $ee, "work.", $fa, $f7
    db $ef, $ee, "You must get three", $ef, $ee, "healthy monsters.", $f7
    db $f0

Message_01_4C::
    db $ea, "*: You close the", $f1
    db "door to stardom?", $fa, $f7
    db $ef, $ee, "That is most", $ef, $ee, "unfortunate.", $fa, $f7
    db $ef, $ee, "If you change your", $ef, $ee, "mind, I'll be here.", $f7
    db $f0

Message_01_4D::
    db $ea, "*: Ah, three", $f1
    db "healthy monsters!", $fa, $f7
    db $ef, $ee, "Very well done!", $ef, $ee, "Bravo to you!", $fa, $f7
    db $ef, $ee, "You are officially", $ef, $ee, "a circus member!", $fa, $f7
    db $ef, $ee, "Come, we must go", $ef, $ee, "to the castle!", $f7
    db $f0

Message_01_4E::
    db $ea, "*: Oh, you need a", $f1
    db "trio of monsters", $fa, $f7
    db $ef, $ee, "to make the act", $ef, $ee, "work.", $fa, $f7
    db $ef, $ee, "You must get three", $ef, $ee, "healthy monsters.", $f7
    db $f0

Message_01_4F::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "a gooey oil.", $f7
    db $f0

Message_01_50::
    db $ea, "*: I heard that the", $f1
    db "thieves disappear", $fa, $f7
    db $ef, $ee, "as soon as they", $ef, $ee, "get their loot.", $fa, $f7
    db $ef, $ee, "No one's seen", $ef, $ee, "their hideout.", $f7
    db $f0

Message_01_51::
    db $ea, "*: And that was the", $f1
    db "firebreather!", $fa, $f7
    db $ef, $ee, "Let's hear it for", $ef, $ee, "this brave soul!", $f7
    db $f0

Message_01_52::
    db $ea, "*: Next, monsters", $ef, $ee, "will perform some", $fa, $f7
    db $ef, $ee, "amazing, death", $ef, $ee, "defying stunts!", $f7
    db $f0

Message_01_53::
    db $ea, "*: Very good show!", $f1
    db "That was splendid", $fa, $f7
    db $ef, $ee, "for your debut", $ef, $ee, "performance!", $fa, $f7
    db $ef, $ee, "The audience was", $ef, $ee, "quite pleased.", $fa, $f7
    db $ef, $ee, "We are to stay for", $ef, $ee, "more shows here,", $fa, $f7
    db $ef, $ee, "so we have been", $ef, $ee, "permitted to go", $fa, $f7
    db $ef, $ee, "into the castle by", $ef, $ee, "the King.", $f7
    db $f0

Message_01_54::
    db $ea, "*: Several of our", $f1
    db "members came back.", $fa, $f7
    db $ef, $ee, "We have enough to", $ef, $ee, "put on our shows.", $f7
    db $f0

Message_01_55::
    db $ea, "*: When the thieves", $f1
    db "raided us, we ran.", $fa, $f7
    db $ef, $ee, "But while we kept", $ef, $ee, "our lives, we were", $fa, $f7
    db $ef, $ee, "separated from our", $ef, $ee, "circus master.", $f7
    db $f0

Message_01_56::
    db $ea, "*: I wonder if the", $f1
    db "others are safe", $a4, $f7
    db $f0

Message_01_57::
    db $ea, "*: Heh, did you see", $f1
    db "the looks I got", $fa, $f7
    db $ef, $ee, "when I blew fire?", $ef, $ee, "Made me feel good!", $f7
    db $f0

Message_01_58::
    db $ea, "*: This is the", $f1
    db "King's treasury!", $fa, $f7
    db $ef, $ee, "No one, but no one", $ef, $ee, "is allowed inside!", $f7
    db $f0

Message_01_59::
    db $ea, "*: What? See his", $f1
    db "Majesty's treasure?", $fa, $f7
    db $ef, $ee, "What foolishness!", $ef, $ee, "No one gets by me", $fa, $f7
    db $ef, $ee, "without the King's", $ef, $ee, "permission!", $f7
    db $f0

Message_01_5A::
    db $ea, "*: His Majesty is", $f1
    db "honest and most", $fa, $f7
    db $ef, $ee, "certainly not evil", $ef, $ee, "in any way.", $fa, $f7
    db $ef, $ee, "But, he is rather", $ef, $ee, "impetuous.", $fa, $f7
    db $ef, $ee, "I wish he wouldn't", $ef, $ee, "order us on whim", $a4, $f7
    db $f0

Message_01_5B::
    db $ea, "*: We frown upon", $f1
    db "strangers who", $fa, $f7
    db $ef, $ee, "wander through our", $ef, $ee, "castle!", $f7
    db $f0

Message_01_5C::
    db $ea, "*: Why are you", $f1
    db "snooping around?", $fa, $f7
    db $ef, $ee, "Are you looking", $ef, $ee, "for something?", $ff, $f0

Message_01_5D::
    db $ea, "*: A new plug for", $f1
    db "the Log's Navel?", $fa, $f7
    db $ef, $ee, "It has to have a", $ef, $ee, "magic power?", $fa, $f7
    db $ef, $ee, "Well, then there's", $ef, $ee, "only the King's", $fa, $f7
    db $ef, $ee, "TidalBell among", $ef, $ee, "his treasures.", $fa, $f7
    db $ef, $ee, "It can be used to", $ef, $ee, "cross the sea.", $f7
    db $f0

Message_01_5E::
    db $ea, "*: Oh, it looked", $f1
    db "like you were on", $fa, $f7
    db $ef, $ee, "the prowl for", $ef, $ee, "something.", $f7
    db $f0

Message_01_5F::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "There were neatly", $ef, $ee, "folded silk robes.", $f7
    db $f0

Message_01_60::
    db $ea, "King: Ah, you're", $f1
    db "the monster tamer", $fa, $f7
    db $ef, $ee, "from the circus.", $ef, $ee, "Good show!", $fa, $f7
    db $ef, $ee, "So, do you wish", $ef, $ee, "something of me?", $ff, $f0

Message_01_61::
    db $ea, "King: I see. This", $f1
    db "is what we'll do.", $fa, $f7
    db $ef, $ee, "I'll help you, if", $ef, $ee, "you help me.", $fa, $f7
    db $ef, $ee, "I inherited the", $ef, $ee, "throne from my", $fa, $f7
    db $ef, $ee, "father, who was a", $ef, $ee, "great king.", $fa, $f7
    db $ef, $ee, "But my rule has", $ef, $ee, "been beset by one", $fa, $f7
    db $ef, $ee, "disaster after", $ef, $ee, "another.", $fa, $f7
    db $ef, $ee, "No one listens to", $ef, $ee, "my orders now", $a4, $fa, $f7
    db $ef, $ee, "Will you go find", $ef, $ee, "out what concerns", $fa, $f7
    db $ef, $ee, "my people may", $ef, $ee, "have?", $fa, $f7
    db $ef, $ee, "If I solved their", $ef, $ee, "problems, I should", $fa, $f7
    db $ef, $ee, "regain their trust", $ef, $ee, "and respect.", $fa, $f7
    db $ef, $ee, "Well? Will you do", $ef, $ee, "this for me?", $ff, $f0

Message_01_62::
    db $ea, "King: Then make", $f1
    db "way to the town.", $fa, $f7
    db $ef, $ee, "If you succeed,", $ef, $ee, "you can have the", $fa, $f7
    db $ef, $ee, "TidalBell from my", $ef, $ee, "treasures.", $f7
    db $f0

Message_01_63::
    db $ea, "King: Oh", $a4, $f1
    db "You won't?", $fa, $f7
    db $ef, $ee, "Then, I can't help", $ef, $ee, "you either.", $f7
    db $f0

Message_01_64::
    db $ea, "King: Investigate", $f1
    db "what concerns my", $fa, $f7
    db $ef, $ee, "people may have.", $ef, $ee, "Hurry!", $f7
    db $f0

Message_01_65::
    db $ea, "King: So? Have you", $f1
    db "decided to see", $fa, $f7
    db $ef, $ee, "what concerns my", $ef, $ee, "people have?", $ff, $f0

Message_01_66::
    db $ea, "*: That fool is a", $f1
    db "terrible swindler.", $fa, $f7
    db $ef, $ee, "I wouldn't lend an", $ef, $ee, "ear to him!", $f7
    db $f0

Message_01_67::
    db $ea, "*: Humph! A mirage", $f1
    db "lake, he says!", $fa, $f7
    db $ef, $ee, "No one's seen such", $ef, $ee, "a thing.", $fa, $f7
    db $ef, $ee, "Everything he says", $ef, $ee, "is a lie!", $f7
    db $f0

Message_01_68::
    db $eb, "*: Do I have any", $f1
    db "concerns?", $fa, $f7
    db $ef, $ee, "You'll tell the", $ef, $ee, "King for me?", $fa, $f7
    db $ef, $ee, "Then listen. The", $ef, $ee, "well's almost dry.", $fa, $f7
    db $ef, $ee, "Could the King do", $ef, $ee, "anything about it?", $f7
    db $f0

Message_01_69::
    db $eb, "*: We're worried", $f1
    db "about the well.", $fa, $f7
    db $ef, $ee, "The water level is", $ef, $ee, "dropping sharply.", $fa, $f7
    db $ef, $ee, "We don't have any", $ef, $ee, "confidence in the", $fa, $f7
    db $ef, $ee, "King, so we're not", $ef, $ee, "sure what to do.", $f7
    db $f0

Message_01_6A::
    db $ea, "*: The King has", $f1
    db "given permission", $fa, $f7
    db $ef, $ee, "for you to come", $ef, $ee, "and go freely.", $f7
    db $f0

Message_01_6B::
    db $ea, "*: The King is so", $f1
    db "frivolous.", $fa, $f7
    db $ef, $ee, "A circus makes him", $ef, $ee, "happy? Please!", $f7
    db $f0

Message_01_6C::
    db $ea, "*: So, have you", $f1
    db "discovered what", $fa, $f7
    db $ef, $ee, "concerns my people", $ef, $ee, "may have?", $fa, $f7
    db $ef, $ee, "What? The well is", $ef, $ee, "running dry?", $fa, $f7
    db $ef, $ee, "I will order my", $ef, $ee, "men to raise the", $fa, $f7
    db $ef, $ee, "flow of water into", $ef, $ee, "the canal.", $fa, $f7
    db $ef, $ee, "Guards! Duke!", $ef, $ee, "Anyone?", $f7
    db $f0

Message_01_6D::
    db $ea, "King: The canal is", $f1
    db "managed by the", $fa, $f7
    db $ef, $ee, "village of Kalka,", $ef, $ee, "isn't that right?", $fa, $f7
    db $ef, $ee, "Send someone to", $ef, $ee, "Kalka and have the", $fa, $f7
    db $ef, $ee, "manager open the", $ef, $ee, "Canal Gate more!", $f7
    db $f0

Message_01_6E::
    db $ea, "*: Your Majesty, I", $f1
    db "must remind you", $a4, $fa, $f7
    db $ef, $ee, "If that was done,", $ef, $ee, "the oasis will", $fa, $f7
    db $ef, $ee, "become drained", $ef, $ee, "immediately.", $f7
    db $f0

Message_01_6F::
    db $ea, "King: What?", $f1
    db "Never mind, then!", $fa, $f7
    db $ef, $ee, "I'll go to Kalka,", $ef, $ee, "and check myself!", $f7
    db $f0

Message_01_70::
    db $ea, "*: I feel badly for", $ef, $ee, "his Majesty, but", $fa, $f7
    db $ef, $ee, "he must think", $ef, $ee, "things through.", $fa, $f7
    db $ef, $ee, "Rash actions with", $ef, $ee, "no thought of the", $fa, $f7
    db $ef, $ee, "consequences won't", $ef, $ee, "do for a ruler.", $f7
    db $f0

Message_01_71::
    db $ea, "*: What? Open the", $f1
    db "Canal Gate more?", $fa, $f7
    db $ef, $ee, "The oasis will run", $ef, $ee, "dry if we did!", $fa, $f7
    db $ef, $ee, "That's an order I", $ef, $ee, "simply cannot", $fa, $f7
    db $ef, $ee, "accept, King or no", $ef, $ee, "King.", $f7
    db $f0

Message_01_72::
    db $ea, "King: Arrgh!", $f1
    db "I know that!", $fa, $f7
    db $ef, $ee, "I want to know why", $ef, $ee, "the water is gone!", $fa, $f7
    db $ef, $ee, "Fine, I'll go find", $ef, $ee, "out myself!", $f7
    db $f0

Message_01_73::
    db $ea, "*: ", $a4, "My, our King", $f1
    db "has no patience", $a4, $f7
    db $f0

Message_01_74::
    db $ea, "*: I discovered why", $f1
    db "the water is low.", $fa, $f7
    db $ef, $ee, "This beast's dam", $ef, $ee, "is at fault.", $fa, $f7
    db $ef, $ee, "I've been trying to", $ef, $ee, "get it to destroy", $fa, $f7
    db $ef, $ee, "the dam, but to no", $ef, $ee, "avail.", $f7
    db $f0

Message_01_75::
    db $ea, "*: I'm making a new", $f1
    db "home for my clan!", $fa, $f7
    db $ef, $ee, "Leave us be, or", $ef, $ee, "pay the price!", $f7
    db $f0

Message_01_76::
    db $ea, "*: Gaah! You're too", $f1
    db "strong! You win!", $fa, $f7
    db $ef, $ee, "I didn't mean to", $ef, $ee, "cause any trouble.", $fa, $f7
    db $ef, $ee, "We used to live in", $ef, $ee, "Mirage Lake, but", $fa, $f7
    db $ef, $ee, "we were kicked out", $ef, $ee, "by a band of thugs", $fa, $f7
    db $ef, $ee, "who made it their", $ef, $ee, "hideout!", $fa, $f7
    db $ef, $ee, "I was looking for", $ef, $ee, "a place to live", $a4, $f7
    db $f0

Message_01_77::
    db $ea, "King: What? So", $f1
    db "that's the truth?", $fa, $f7
    db $ef, $ee, "Those wretched", $ef, $ee, "scoundrels!", $fa, $f7
    db $ef, $ee, "I promise, I will", $ef, $ee, "imprison them!", $f7
    db $f0

Message_01_78::
    db $ea, "*: You will?", $f1
    db "So we can go back", $fa, $f7
    db $ef, $ee, "to Mirage Lake and", $ef, $ee, "live peacefully?", $fa, $f7
    db $ef, $ee, "Please catch the", $ef, $ee, "thieves!", $f7
    db $f0

Message_01_79::
    db $ea, "King: This should", $f1
    db "solve the water", $fa, $f7
    db $ef, $ee, "shortage in the", $ef, $ee, "town.", $fa, $f7
    db $ef, $ee, "I humbly thank you", $ef, $ee, "for your help!", $fa, $f7
    db $ef, $ee, "Come see me in the", $ef, $ee, "Castle.", $fa, $f7
    db $ef, $ee, "I will have the", $ef, $ee, "TidalBell for you.", $f7
    db $f0

Message_01_7A::
    db $ea, "*: Oh? You say that", $f1
    db "a monster had been", $fa, $f7
    db $ef, $ee, "blocking the canal", $ef, $ee, "with a dam?", $f7
    db $f0

Message_01_7B::
    db $eb, "*: The well has", $f1
    db "ample water again.", $fa, $f7
    db $ef, $ee, "Our King managed", $ef, $ee, "to do it!", $fa, $f7
    db $ef, $ee, "Maybe he isn't a", $ef, $ee, "total buffoon", $a4, $f7
    db $f0

Message_01_7C::
    db $ea, "*: We have heard", $f1
    db "from his Majesty.", $fa, $f7
    db $ef, $ee, "Please, do go", $ef, $ee, "right through.", $f7
    db $f0

Message_01_7D::
    db $eb, "*: Hi! Did you hear", $f1
    db "the news?", $fa, $f7
    db $ef, $ee, "Our King is quite", $ef, $ee, "the brave man.", $fa, $f7
    db $ef, $ee, "With just one", $ef, $ee, "underling, he", $fa, $f7
    db $ef, $ee, "defeated monsters", $ef, $ee, "in the canal, and", $fa, $f7
    db $ef, $ee, "saved the town", $ef, $ee, "from a drought!", $f7
    db $f0

Message_01_7E::
    db $ea, "*: The King solved", $f1
    db "our water shortage", $fa, $f7
    db $ef, $ee, "all by himself,", $ef, $ee, "I've heard.", $fa, $f7
    db $ef, $ee, "Perhaps we were", $ef, $ee, "wrong about him.", $f7
    db $f0

Message_01_7F::
    db $ea, "*: Our King worked", $f1
    db "to save all of us", $a4, $fa, $f7
    db $ef, $ee, "I'm ashamed", $a4, " What", $ef, $ee, "have I done?", $f7
    db $f0

Message_01_80::
    db $ea, "*: The King appears", $f1
    db "to have turned a", $fa, $f7
    db $ef, $ee, "new leaf as a", $ef, $ee, "great ruler.", $fa, $f7
    db $ef, $ee, "I can finally say", $ef, $ee, "I've fulfilled my", $fa, $f7
    db $ef, $ee, "promise to his", $ef, $ee, "late father", $a4, $f7
    db $f0

Message_01_81::
    db $ea, "King: The town's", $f1
    db "water shortage", $fa, $f7
    db $ef, $ee, "seems to be no", $ef, $ee, "longer a concern.", $fa, $f7
    db $ef, $ee, "I thank you again", $ef, $ee, "for your work.", $fa, $f7
    db $ef, $ee, "Your reward is the", $ef, $ee, "TidalBell.", $fa, $f7
    db $ef, $ee, "Come, follow me to", $ef, $ee, "the treasury.", $f7
    db $f0

Message_01_82::
    db $ea, "King: Wha-what?", $f1
    db "What happened?", $f7
    db $f0

Message_01_83::
    db $ea, "*: ", $a4, "We", $a4, " We were", $f1
    db "jumped by thieves", $a4, $fa, $f7
    db $ef, $ee, "They", $a4, " made off", $ef, $ee, "with the treasure", $a4, $f7
    db $f0

Message_01_84::
    db $ea, "King: What?", $f1
    db "Arrrrgh!", $fa, $f7
    db $ef, $ee, "Round up all the", $ef, $ee, "men at once!", $fa, $f7
    db $ef, $ee, "Have them report", $ef, $ee, "to my chamber!", $f7
    db $f0

Message_01_85::
    db $ea, "King: The hideout", $f1
    db "of the thieves is", $fa, $f7
    db $ef, $ee, "said to be in", $ef, $ee, "Mirage Lake!", $fa, $f7
    db $ef, $ee, "They must be", $ef, $ee, "caught!", $fa, $f7
    db $ef, $ee, "I will lead the", $ef, $ee, "expedition myself!", $fa, $f7
    db $ef, $ee, "Who will join me", $ef, $ee, "in this quest?", $f7
    db $f0

Message_01_86::
    db $ea, "King: Good! Your", $f1
    db "valor be praised!", $fa, $f7
    db $ef, $ee, "We must capture", $ef, $ee, "the thieves, at", $fa, $f7
    db $ef, $ee, "all costs.", $ef, $ee, "This is a mission!", $f7
    db $f0

Message_01_87::
    db $ea, "King: I apologize,", $f1
    db "but my treasures", $fa, $f7
    db $ef, $ee, "were taken by the", $ef, $ee, "thieves.", $fa, $f7
    db $ef, $ee, "I will head to", $ef, $ee, "Mirage Lake and", $fa, $f7
    db $ef, $ee, "bring them to", $ef, $ee, "justice.", $fa, $f7
    db $ef, $ee, "If we return", $ef, $ee, "safely, you shall", $fa, $f7
    db $ef, $ee, "have the promised", $ef, $ee, "TidalBell.", $f7
    db $f0

Message_01_88::
    db $ea, "*: Wh-where is", $f1
    db "everybody?", $fa, $f7
    db $ef, $ee, "I haven't been fed", $ef, $ee, "at all", $a4, $fa, $f7
    db $ef, $ee, "Listen, I'll let", $ef, $ee, "you in on a secret", $fa, $f7
    db $ef, $ee, "if you have any", $ef, $ee, "food. Well?", $ff, $f0

Message_01_89::
    db $f9, "0 handed over", $f1
    db "some food.", $f7
    db $f0

Message_01_8A::
    db $ea, "*: Munch, munch", $a4, $f1
    db "Chew, gulp", $a4, $fa, $f7
    db $ef, $ee, "Fwoaar, that hits", $ef, $ee, "the spot! Thanks!", $fa, $f7
    db $ef, $ee, "Well, here's the", $ef, $ee, "secret I promised.", $fa, $f7
    db $ef, $ee, "Don't chase what", $ef, $ee, "runs from you.", $fa, $f7
    db $ef, $ee, "Lay some bait, and", $ef, $ee, "let it come.", $fa, $f7
    db $ef, $ee, "That's the trick.", $ef, $ee, "Here, take this.", $f7
    db $f0

Message_01_8B::
    db $f9, "0 received a", $f1
    db "WaterCall.", $f7
    db $f0

Message_01_8C::
    db $f9, "0 had no food", $f1
    db "to give", $a4, $f7
    db $f0

Message_01_8D::
    db $ea, "*: Tch, what good", $f1
    db "are you?", $fa, $f7
    db $ef, $ee, "I'm starving here.", $ef, $ee, "Anything'll do.", $fa, $f7
    db $ef, $ee, "Even food for", $ef, $ee, "monsters is good!", $f7
    db $f0
    ds $16a, $00
