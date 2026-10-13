SECTION "Bank 2C", ROMX[$4000], BANK[$2C]
    db $2c

; message bank $2C: when wStringIndex < $91, BeginStringDisplay with this bank's table
; MessageStrings_Bank2C; otherwise far-calls BeginStringDisplay_Bank2C_Overflow (E-0080)
BeginStringDisplay_Bank2C::
    ld a, [wStringIndex]
    cp $91
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2C_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2C
    call BeginStringDisplay
    ret

; message bank $2C: when wStringIndex < $91, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2C; otherwise far-calls CopyStringToBuffer_Bank2C_Overflow (E-0080)
CopyStringToBuffer_Bank2C::
    ld a, [wStringIndex]
    cp $91
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2C_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2C
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2C_4032::
MessageStrings_Bank2C::
    dw StringList_2C_4034 ; id 0

; category list of StringCategories_2C_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_2C_4034::
    dw Message_04_00 ; id 0
    dw Message_04_01 ; id 1
    dw Message_04_02 ; id 2
    dw Message_04_03 ; id 3
    dw Message_04_04 ; id 4
    dw Message_04_05 ; id 5
    dw Message_04_06 ; id 6
    dw Message_04_07 ; id 7
    dw Message_04_08 ; id 8
    dw Message_04_09 ; id 9
    dw Message_04_0A ; id 10
    dw Message_04_0B ; id 11
    dw Message_04_0C ; id 12
    dw Message_04_0D ; id 13
    dw Message_04_0E ; id 14
    dw Message_04_0F ; id 15
    dw Message_04_10 ; id 16
    dw Message_04_11 ; id 17
    dw Message_04_12 ; id 18
    dw Message_04_13 ; id 19
    dw Message_04_14 ; id 20
    dw Message_04_15 ; id 21
    dw Message_04_16 ; id 22
    dw Message_04_17 ; id 23
    dw Message_04_18 ; id 24
    dw Message_04_19 ; id 25
    dw Message_04_1A ; id 26
    dw Message_04_1B ; id 27
    dw Message_04_1C ; id 28
    dw Message_04_1D ; id 29
    dw Message_04_1E ; id 30
    dw Message_04_1F ; id 31
    dw Message_04_20 ; id 32
    dw Message_04_21 ; id 33
    dw Message_04_22 ; id 34
    dw Message_04_23 ; id 35
    dw Message_04_24 ; id 36
    dw Message_04_25 ; id 37
    dw Message_04_26 ; id 38
    dw Message_04_27 ; id 39
    dw Message_04_28 ; id 40
    dw Message_04_29 ; id 41
    dw Message_04_2A ; id 42
    dw Message_04_2B ; id 43
    dw Message_04_2C ; id 44
    dw Message_04_2D ; id 45
    dw Message_04_2E ; id 46
    dw Message_04_2F ; id 47
    dw Message_04_30 ; id 48
    dw Message_04_31 ; id 49
    dw Message_04_32 ; id 50
    dw Message_04_33 ; id 51
    dw Message_04_34 ; id 52
    dw Message_04_35 ; id 53
    dw Message_04_36 ; id 54
    dw Message_04_37 ; id 55
    dw Message_04_38 ; id 56
    dw Message_04_39 ; id 57
    dw Message_04_3A ; id 58
    dw Message_04_3B ; id 59
    dw Message_04_3C ; id 60
    dw Message_04_3D ; id 61
    dw Message_04_3E ; id 62
    dw Message_04_3F ; id 63
    dw Message_04_40 ; id 64
    dw Message_04_41 ; id 65
    dw Message_04_42 ; id 66
    dw Message_04_43 ; id 67
    dw Message_04_44 ; id 68
    dw Message_04_45 ; id 69
    dw Message_04_46 ; id 70
    dw Message_04_47 ; id 71
    dw Message_04_48 ; id 72
    dw Message_04_49 ; id 73
    dw Message_04_4A ; id 74
    dw Message_04_4B ; id 75
    dw Message_04_4C ; id 76
    dw Message_04_4D ; id 77
    dw Message_04_4E ; id 78
    dw Message_04_4F ; id 79
    dw Message_04_50 ; id 80
    dw Message_04_51 ; id 81
    dw Message_04_52 ; id 82
    dw Message_04_53 ; id 83
    dw Message_04_53 ; id 84
    dw Message_04_53 ; id 85
    dw Message_04_56 ; id 86
    dw Message_04_57 ; id 87
    dw Message_04_58 ; id 88
    dw Message_04_59 ; id 89
    dw Message_04_5A ; id 90
    dw Message_04_5B ; id 91
    dw Message_04_5C ; id 92
    dw Message_04_5D ; id 93
    dw Message_04_5E ; id 94
    dw Message_04_5F ; id 95
    dw Message_04_60 ; id 96
    dw Message_04_61 ; id 97
    dw Message_04_62 ; id 98
    dw Message_04_63 ; id 99
    dw Message_04_64 ; id 100
    dw Message_04_65 ; id 101
    dw Message_04_66 ; id 102
    dw Message_04_67 ; id 103
    dw Message_04_68 ; id 104
    dw Message_04_69 ; id 105
    dw Message_04_6A ; id 106
    dw Message_04_6B ; id 107
    dw Message_04_6C ; id 108
    dw Message_04_6D ; id 109
    dw Message_04_6E ; id 110
    dw Message_04_6F ; id 111
    dw Message_04_70 ; id 112
    dw Message_04_71 ; id 113
    dw Message_04_72 ; id 114
    dw Message_04_73 ; id 115
    dw Message_04_74 ; id 116
    dw Message_04_75 ; id 117
    dw Message_04_76 ; id 118
    dw Message_04_77 ; id 119
    dw Message_04_78 ; id 120
    dw Message_04_79 ; id 121
    dw Message_04_7A ; id 122
    dw Message_04_7B ; id 123
    dw Message_04_7C ; id 124
    dw Message_04_7D ; id 125
    dw Message_04_7E ; id 126
    dw Message_04_7F ; id 127
    dw Message_04_80 ; id 128
    dw Message_04_81 ; id 129
    dw Message_04_82 ; id 130
    dw Message_04_83 ; id 131
    dw Message_04_84 ; id 132
    dw Message_04_85 ; id 133
    dw Message_04_86 ; id 134
    dw Message_04_87 ; id 135
    dw Message_04_88 ; id 136
    dw Message_04_88 ; id 137
    dw Message_04_88 ; id 138
    dw Message_04_8B ; id 139
    dw Message_04_8C ; id 140
    dw Message_04_8D ; id 141
    dw Message_04_8E ; id 142
    dw Message_04_8F ; id 143
    dw Message_04_90 ; id 144

Message_04_00::
    db $ea, "*: This is the", $f1
    db "village of Fhunt.", $fa, $f7
    db $ef, $ee, "We have guarded", $ef, $ee, "the grave of Ugor,", $fa, $f7
    db $ef, $ee, "the Great Sage,", $ef, $ee, "for generations.", $f7
    db $f0

Message_04_01::
    db $ea, "*: The Great Sage", $f1
    db "Ugor saved the", $fa, $f7
    db $ef, $ee, "world with the", $ef, $ee, "LightOrb.", $fa, $f7
    db $ef, $ee, "The LightOrb must", $ef, $ee, "have been very", $fa, $f7
    db $ef, $ee, "powerful to do", $ef, $ee, "that.", $f7
    db $f0

Message_04_02::
    db $ea, "*: You've come all", $f1
    db "this way, take the", $fa, $f7
    db $ef, $ee, "time to pay your", $ef, $ee, "respect to Ugor.", $fa, $f7
    db $ef, $ee, "His grave?", $ef, $ee, "You can't miss it!", $f7
    db $f0

Message_04_03::
    db $ea, "*: The Great Sage,", $f1
    db "after saving the", $fa, $f7
    db $ef, $ee, "world, sealed the", $ef, $ee, "LightOrb away.", $fa, $f7
    db $ef, $ee, "It is sealed high", $ef, $ee, "in the tower.", $fa, $f7
    db $ef, $ee, "He feared that its", $ef, $ee, "power would be", $fa, $f7
    db $ef, $ee, "misused by those", $ef, $ee, "impure of thought", $fa, $f7
    db $ef, $ee, "to become the king", $ef, $ee, "of monsters.", $fa, $f7
    db $ef, $ee, "So, the LightOrb", $ef, $ee, "could be dangerous", $fa, $f7
    db $ef, $ee, "if it falls into", $ef, $ee, "the wrong hands.", $f7
    db $f0

Message_04_04::
    db $ea, "*: You're not about", $f1
    db "to go after the", $fa, $f7
    db $ef, $ee, "LightOrb so you", $ef, $ee, "can be the king?", $fa, $f7
    db $ef, $ee, "I suggest you lose", $ef, $ee, "that thought now.", $f7
    db $f0

Message_04_05::
    db $ea, "*: Some time ago,", $f1
    db "lightning struck", $fa, $f7
    db $ef, $ee, "the tower, causing", $ef, $ee, "it to buckle.", $fa, $f7
    db $ef, $ee, "Did someone do it", $ef, $ee, "deliberately?", $fa, $f7
    db $ef, $ee, "No, that can't be", $ef, $ee, "right", $a4, $fa, $f7
    db $ef, $ee, "The Orb is guarded", $ef, $ee, "by the Great Sage", $a4, $f7
    db $f0

Message_04_06::
    db $ea, "*: Nobody can defy", $f1
    db "the Orb's bearer.", $fa, $f7
    db $ef, $ee, "It has absolute", $ef, $ee, "power over the", $fa, $f7
    db $ef, $ee, "will of monsters,", $ef, $ee, "they say.", $f7
    db $f0

Message_04_07::
    db $ea, "*: A suspension", $f1
    db "bridge is in the", $fa, $f7
    db $ef, $ee, "south, but it's", $ef, $ee, "under guard.", $fa, $f7
    db $ef, $ee, "Nobody suspicious", $ef, $ee, "is allowed across.", $fa, $f7
    db $ef, $ee, "A human will never", $ef, $ee, "be permitted.", $f7
    db $f0

Message_04_08::
    db $ea, "*: A huge bird", $f1
    db "perches atop the", $fa, $f7
    db $ef, $ee, "tower every so", $ef, $ee, "often.", $fa, $f7
    db $ef, $ee, "I tell you, it's", $ef, $ee, "creepy.", $f7
    db $f0

Message_04_09::
    db $ea, "*: The tower's gate", $f1
    db "is tightly sealed.", $fa, $f7
    db $ef, $ee, "Anyone with any", $ef, $ee, "trace of wildness", $fa, $f7
    db $ef, $ee, "is kept out of the", $ef, $ee, "tower by magic.", $fa, $f7
    db $ef, $ee, "Are your monsters", $ef, $ee, "still wild?", $f7
    db $f0

Message_04_0A::
    db $ea, "*: The top of the", $f1
    db "tower collapsed", $fa, $f7
    db $ef, $ee, "when it was hit by", $ef, $ee, "lightning.", $fa, $f7
    db $ef, $ee, "We're trying to", $ef, $ee, "put up a ladder to", $fa, $f7
    db $ef, $ee, "see if we can't", $ef, $ee, "get a look in.", $f7
    db $f0

Message_04_0B::
    db $f9, "0 checked the", $f1
    db "grave.", $fa, $f7
    db $ef, $ee, "There was an", $ef, $ee, "inscription.", $fa, $f7
    db $ef, $ee, "'Here lies Ugor,", $ef, $ee, "the Great Sage", $fa, $f7
    db $ef, $ee, "and the world's", $ef, $ee, "savior.", $95, $f7
    db $f0

Message_04_0C::
    db $ea, "*: Who disturbs my", $f1
    db "sleep?", $fa, $f7
    db $ef, $ee, "A visitor from", $ef, $ee, "another world?", $fa, $f7
    db $ef, $ee, "This is indeed a", $ef, $ee, "rare occasion.", $fa, $f7
    db $ef, $ee, "However, no one", $ef, $ee, "must be permitted", $fa, $f7
    db $ef, $ee, "to obtain the", $ef, $ee, "LightOrb.", $fa, $f7
    db $ef, $ee, "It has been sealed", $ef, $ee, "away to sleep", $a4, $fa, $f7
    db $ef, $ee, "Yes", $a4, " In the same", $ef, $ee, "way that I do", $a4, $f7
    db $f0

Message_04_0D::
    db $ea, "*: What? You again?", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "You seem to have", $ef, $ee, "come from afar,", $fa, $f7
    db $ef, $ee, "but the Orb must", $ef, $ee, "be left untouched.", $fa, $f7
    db $ef, $ee, "It will never fall", $ef, $ee, "into anyone's hands", $fa, $f7
    db $ef, $ee, "again. I assure", $ef, $ee, "you of that", $a4, $f7
    db $f0

Message_04_0E::
    db $f9, "0 checked the", $f1
    db "grave.", $fa, $f7
    db $ef, $ee, "The tombstone was", $ef, $ee, "covered in moss.", $f7
    db $f0

Message_04_0F::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "A peculiar meat", $ef, $ee, "broth was boiling.", $f7
    db $f0

Message_04_10::
    db $ea, "*: ", $a4, "Be gone!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "If your soul can't", $ef, $ee, "overcome natural", $fa, $f7
    db $ef, $ee, "wildness within,", $ef, $ee, "you are forbidden", $fa, $f7
    db $ef, $ee, "from entering the", $ef, $ee, "tower. Leave now!", $f7
    db $f0

Message_04_11::
    db $ea, "*: ", $a4, "Fine!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "You've done well", $ef, $ee, "to quell the wild", $fa, $f7
    db $ef, $ee, "heart that beats", $ef, $ee, "inside.", $fa, $f7
    db $ef, $ee, "You've earned the", $ef, $ee, "right to enter!", $f7
    db $f0

Message_04_12::
    db $ea, "*: Kweeeeh!", $f1
    db $f7
    db $f0

Message_04_13::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "The chest was", $ef, $ee, "empty.", $fa, $f7
    db $ef, $ee, "Could the LightOrb", $ef, $ee, "have been in it?", $f7
    db $f0

Message_04_14::
    db $ea, "*: What? What?", $f1
    db "What happened?", $fa, $f7
    db $ef, $ee, "I saw a huge bird", $ef, $ee, "fly up and go into", $fa, $f7
    db $ef, $ee, "the tower and", $ef, $ee, "then it came out", $fa, $f7
    db $ef, $ee, "clutching a shiny", $ef, $ee, "object.", $fa, $f7
    db $ef, $ee, "It flew off to the", $ef, $ee, "west.", $f7
    db $f0

Message_04_15::
    db $ea, "*: Who disturbs my", $f1
    db "sleep?", $fa, $f7
    db $ef, $ee, "A visitor from", $ef, $ee, "another world?", $fa, $f7
    db $ef, $ee, "This is indeed a", $ef, $ee, "rare occasion.", $fa, $f7
    db $ef, $ee, "However, no one", $ef, $ee, "must be permitted", $fa, $f7
    db $ef, $ee, "to obtain the", $ef, $ee, "LightOrb.", $fa, $f7
    db $ef, $ee, "It has been sealed", $ef, $ee, "away to sleep", $a4, $fa, $f7
    db $ef, $ee, "Yes", $a4, " In the same", $ef, $ee, "way that I do", $a4, $fa, $f7
    db $ef, $ee, "What? The LightOrb", $ef, $ee, "was stolen?", $fa, $f7
    db $ef, $ee, "If it falls into", $ef, $ee, "the wrong hands", $a4, $fa, $f7
    db $ef, $ee, "Urrrgh", $a4, $ef, $ee, "What to do", $a4, $fa, $f7
    db $ef, $ee, "I know! Can you go", $ef, $ee, "recover it?", $ff, $f0

Message_04_16::
    db $ea, "*: Ah, you'll do", $f1
    db "it? Excellent!", $fa, $f7
    db $ef, $ee, "But you, being a", $ef, $ee, "human-you stand ", $fa, $f7
    db $ef, $ee, "out too much in", $ef, $ee, "this world.", $fa, $f7
    db $ef, $ee, "Look behind my", $ef, $ee, "gravestone and", $fa, $f7
    db $ef, $ee, "take what you", $ef, $ee, "find. It's a gift.", $f7
    db $f0

Message_04_17::
    db $ea, "*: I had thought", $f1
    db "that you could be", $fa, $f7
    db $ef, $ee, "trusted with the", $ef, $ee, "LightOrb", $a4, $f7
    db $f0

Message_04_18::
    db $ea, "*: Who disturbs my", $f1
    db "sleep?", $fa, $f7
    db $ef, $ee, "Oh, it's you again.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Sorry, but the", $ef, $ee, "LightOrb", $a4, $fa, $f7
    db $ef, $ee, "What? The LightOrb", $ef, $ee, "was stolen?", $fa, $f7
    db $ef, $ee, "If it falls into", $ef, $ee, "the wrong hands", $a4, $fa, $f7
    db $ef, $ee, "Urrrgh", $a4, $ef, $ee, "What to do", $a4, $fa, $f7
    db $ef, $ee, "I know! Can you go", $ef, $ee, "recover it?", $ff, $f0

Message_04_19::
    db $ea, "*: Well? Will you", $f1
    db "go look for the", $fa, $f7
    db $ef, $ee, "stolen LightOrb", $ef, $ee, "for me?", $ff, $f0

Message_04_1A::
    db $f9, "0 checked", $f1
    db "behind the grave.", $fa, $f7
    db $ef, $ee, "The ChangeStaff", $ef, $ee, "was found!", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, "ChangeStaff.", $f7
    db $f0

Message_04_1B::
    db $f9, "0 checked", $f1
    db "behind the grave.", $fa, $f7
    db $ef, $ee, "The ChangeStaff", $ef, $ee, "was found!", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it.", $fa, $f7
    db $ef, $ee, $f9, "0 put back the", $ef, $ee, "ChangeStaff.", $f7
    db $f0

Message_04_1C::
    db $ea, "*: Hm? You're a", $f1
    db "stranger!", $fa, $f7
    db $ef, $ee, "You make me very", $ef, $ee, "suspicious!", $fa, $f7
    db $ef, $ee, "I won't let you go", $ef, $ee, "past me!", $f7
    db $f0

Message_04_1D::
    db $ea, "*: Hm? You're from", $f1
    db "the village!", $fa, $f7
    db $ef, $ee, "Hurry up and go", $ef, $ee, "through!", $f7
    db $f0

Message_04_1E::
    db $eb, "*: This is the town", $f1
    db "of Pei.", $fa, $f7
    db $ef, $ee, "You'll find most", $ef, $ee, "travel items here.", $f7
    db $f0

Message_04_1F::
    db $eb, "*: Nya? Travelers?", $f1
    db "That's rare!", $f7
    db $f0

Message_04_20::
    db $ea, "*: To the west is a", $f1
    db "mountain.", $fa, $f7
    db $ef, $ee, "A huge bird that", $ef, $ee, "likes shiny things", $fa, $f7
    db $ef, $ee, "makes its nest", $ef, $ee, "there.", $f7
    db $f0

Message_04_21::
    db $ea, "*: You should stay", $f1
    db "well clear of the", $fa, $f7
    db $ef, $ee, "mountain in the", $ef, $ee, "west.", $fa, $f7
    db $ef, $ee, "The immense bird", $ef, $ee, "that lives there", $fa, $f7
    db $ef, $ee, "will carry you off", $ef, $ee, "if you get close.", $f7
    db $f0

Message_04_22::
    db $ea, "*: I came close to", $f1
    db "being abducted by", $fa, $f7
    db $ef, $ee, "a huge bird a", $ef, $ee, "while ago.", $fa, $f7
    db $ef, $ee, "Be careful if you", $ef, $ee, "have any shiny", $fa, $f7
    db $ef, $ee, "monsters like me.", $ef, $ee, "It's dangerous!", $f7
    db $f0

Message_04_23::
    db $ea, "*: Some time ago, a", $f1
    db "human child was", $fa, $f7
    db $ef, $ee, "taken away by the", $ef, $ee, "huge bird.", $fa, $f7
    db $ef, $ee, "The child hasn't", $ef, $ee, "been seen since.", $f7
    db $f0

Message_04_24::
    db $ea, "*: There wasn't a", $f1
    db "monster king for", $fa, $f7
    db $ef, $ee, "a long time, but a", $ef, $ee, "new king appeared", $fa, $f7
    db $ef, $ee, "recently to take", $ef, $ee, "the vacant throne.", $f7
    db $f0

Message_04_25::
    db $ea, "*: The new monster", $f1
    db "king makes others", $fa, $f7
    db $ef, $ee, "obey using magical", $ef, $ee, "powers.", $fa, $f7
    db $ef, $ee, "Nobody appears to", $ef, $ee, "be rebelling.", $f7
    db $f0

Message_04_26::
    db $ea, "*: You", $a4, " Are you a", $f1
    db "monster?", $ff, $f0

Message_04_27::
    db $ea, "*: Uh-huh", $a4, " You don't", $f1
    db "look very strong.", $f7
    db $f0

Message_04_28::
    db $ea, "*: Uh-huh", $a4, " You look", $f1
    db "uh", $a4, " delicious.", $f7
    db $f0

Message_04_29::
    db $ea, "*: Any way you want", $f1
    db "to look at this,", $fa, $f7
    db $ef, $ee, "I look stronger", $ef, $ee, "than you.", $f7
    db $f0

Message_04_2A::
    db $ea, "*: This is just a", $f1
    db "rumor, but the new", $fa, $f7
    db $ef, $ee, "monster king likes", $ef, $ee, "precious items.", $fa, $f7
    db $ef, $ee, "Especially those", $ef, $ee, "imbued with magic.", $f7
    db $f0

Message_04_2B::
    db $ea, "*: The tunnel in", $f1
    db "the west will take", $fa, $f7
    db $ef, $ee, "you to the castle", $ef, $ee, "of Hitano.", $fa, $f7
    db $ef, $ee, "Perhaps because of", $ef, $ee, "the new monster", $fa, $f7
    db $ef, $ee, "king, treasure", $ef, $ee, "hunters of all", $fa, $f7
    db $ef, $ee, "stripes are said", $ef, $ee, "to be there.", $f7
    db $f0

Message_04_2C::
    db $ea, "*: Are you looking", $f1
    db "for something?", $fa, $f7
    db $ef, $ee, "Huh? The LightOrb?", $ef, $ee, "What is that?", $fa, $f7
    db $ef, $ee, "Well, if it glows,", $ef, $ee, "I have a suspect.", $fa, $f7
    db $ef, $ee, "It's a MadCondor", $ef, $ee, "that nests atop a", $fa, $f7
    db $ef, $ee, "mountain in the", $ef, $ee, "west.", $f7
    db $f0

Message_04_2D::
    db $ea, "*: Good day. How", $f1
    db "may I help you?", $f7
    db $f0

Message_04_2E::
    db $ea, "*: How may we serve", $f1
    db "your mortal souls?", $f7
    db $f0

Message_04_2F::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "Water reflected", $ef, $ee, "the cloudless sky.", $f7
    db $f0

Message_04_30::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, $a4, "It appeared to be", $ef, $ee, "merchandise", $a4, $f7
    db $f0

Message_04_31::
    db $f9, "0 tried to", $f1
    db "open the chest.", $fa, $f7
    db $ef, $ee, "But the chest was", $ef, $ee, "locked.", $f7
    db $f0

Message_04_32::
    db $ea, "*: Welcome to the", $f1
    db "traveler's inn.", $f7
    db $f0

Message_04_33::
    db $ea, "*: Kweeeeeh!", $f1
    db $f7
    db $f0

Message_04_34::
    db $ea, "*: When I passed", $f1
    db "too close to the", $fa, $f7
    db $ef, $ee, "mountain, I ended", $ef, $ee, "up in a nest!", $f7
    db $f0

Message_04_35::
    db $ea, "*: I", $a4, " I didn't take", $f1
    db "anything!", $fa, $f7
    db $ef, $ee, "There was nothing", $ef, $ee, "here already!", $fa, $f7
    db $ef, $ee, "Somebody's beaten", $ef, $ee, "us to it!", $f7
    db $f0

Message_04_36::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "But it was empty.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Where has the", $ef, $ee, "LightOrb gone", $a4, $f7
    db $f0

Message_04_37::
    db $ea, "*: This is the", $f1
    db "Castle of Hitano.", $fa, $f7
    db $ef, $ee, "It bustles with", $ef, $ee, "treasure hunters.", $f7
    db $f0

Message_04_38::
    db $ea, "*: A monster king", $f1
    db "has appeared to", $fa, $f7
    db $ef, $ee, "take over the", $ef, $ee, "world, but all it", $fa, $f7
    db $ef, $ee, "seems to want is", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "Things haven't", $ef, $ee, "changed much.", $f7
    db $f0

Message_04_39::
    db $ea, "*: I've lived here", $f1
    db "for 200 years now.", $fa, $f7
    db $ef, $ee, "Care to hear about", $ef, $ee, "the past?", $ff, $f0

Message_04_3A::
    db $ea, "*: This area had", $f1
    db "been prosperous,", $fa, $f7
    db $ef, $ee, "but a long war", $ef, $ee, "laid it to waste.", $fa, $f7
    db $ef, $ee, "The treasures that", $ef, $ee, "you find harken", $fa, $f7
    db $ef, $ee, "back to the olden", $ef, $ee, "days.", $fa, $f7
    db $ef, $ee, "If the Great Sage", $ef, $ee, "didn't quell the", $fa, $f7
    db $ef, $ee, "war with the", $ef, $ee, "LightOrb, perhaps", $fa, $f7
    db $ef, $ee, "even this Castle", $ef, $ee, "may not exist", $a4, $f7
    db $f0

Message_04_3B::
    db $ea, "*: Oh", $a4, " You won't", $f1
    db "humor an old man", $a4, $f7
    db $f0

Message_04_3C::
    db $ea, "*: The Castle is", $f1
    db "under the monster", $fa, $f7
    db $ef, $ee, "King's rule now.", $ef, $ee, "You can earn a", $fa, $f7
    db $ef, $ee, "promotion by", $ef, $ee, "finding treasures.", $f7
    db $f0

Message_04_3D::
    db $ea, "*: Did you see the", $f1
    db "monster King's", $fa, $f7
    db $ef, $ee, "proclamation?", $ef, $ee, "If you find three", $fa, $f7
    db $ef, $ee, "treasures, you get", $ef, $ee, "the LightOrb!", $f7
    db $f0

Message_04_3E::
    db $ea, "*: The cave to the", $f1
    db "south", $a4, $fa, $f7
    db $ef, $ee, "That has treasure", $ef, $ee, "in it for sure.", $fa, $f7
    db $ef, $ee, "But the entrance", $ef, $ee, "is too small.", $fa, $f7
    db $ef, $ee, "There's no way I", $ef, $ee, "can squeeze in.", $f7
    db $f0

Message_04_3F::
    db $ea, "*: The new monster", $f1
    db "King is said to", $fa, $f7
    db $ef, $ee, "like his treasures", $ef, $ee, "a lot.", $fa, $f7
    db $ef, $ee, "If I take him some", $ef, $ee, "precious items,", $fa, $f7
    db $ef, $ee, "will he let me", $ef, $ee, "join his army?", $f7
    db $f0

Message_04_40::
    db $ea, "*: Hardly no one", $f1
    db "has seen the new", $fa, $f7
    db $ef, $ee, "Monster King. He", $ef, $ee, "must be cautious", $fa, $f7
    db $ef, $ee, "not to leave his", $ef, $ee, "castle very much.", $f7
    db $f0

Message_04_41::
    db $ea, "*: This is only for", $f1
    db "army personnel!", $fa, $f7
    db $ef, $ee, "Stay out, you", $ef, $ee, "civilians!", $f7
    db $f0

Message_04_42::
    db $ea, "*: The King has", $f1
    db "posted a notice.", $fa, $f7
    db $ef, $ee, "Read the sign over", $ef, $ee, "there.", $f7
    db $f0

Message_04_43::
    db $ea, "*: If you wish to", $f1
    db "join our army,", $fa, $f7
    db $ef, $ee, "then you should", $ef, $ee, "bring items that", $fa, $f7
    db $ef, $ee, "would please our", $ef, $ee, "new Majesty.", $f7
    db $f0

Message_04_44::
    db $ea, "*: Give away the", $f1
    db "LightOrb?", $fa, $f7
    db $ef, $ee, "But that's what", $ef, $ee, "gives the monster", $fa, $f7
    db $ef, $ee, "King his power,", $ef, $ee, "the LightOrb does.", $fa, $f7
    db $ef, $ee, "Our King thinks in", $ef, $ee, "mysterious ways.", $f7
    db $f0

Message_04_45::
    db $ea, "*: If you have the", $f1
    db "LightOrb, you can", $fa, $f7
    db $ef, $ee, "become our King", $ef, $ee, "with its power.", $fa, $f7
    db $ef, $ee, "What should I do", $ef, $ee, "if I were king", $a4, $fa, $f7
    db $ef, $ee, "As a starter, I'll", $ef, $ee, "eat Sirloin every", $fa, $f7
    db $ef, $ee, "day-three square", $ef, $ee, "meals a day!", $fa, $f7
    db $ef, $ee, "But I've been", $ef, $ee, "gaining weight", $a4, $fa, $f7
    db $ef, $ee, "I'm afraid I won't", $ef, $ee, "be able to fly", $a4, $f7
    db $f0

Message_04_46::
    db $ea, "*: If I had the", $f1
    db "LightOrb, even I", $fa, $f7
    db $ef, $ee, "could become the", $ef, $ee, "king of monsters.", $fa, $f7
    db $ef, $ee, "Could you please", $ef, $ee, "tell me where I", $fa, $f7
    db $ef, $ee, "could find some", $ef, $ee, "treasures?", $f7
    db $f0

Message_04_47::
    db $ea, "*: Want to know the", $f1
    db "most fundamental", $fa, $f7
    db $ef, $ee, "point to treasure", $ef, $ee, "hunting?", $ff, $f0

Message_04_48::
    db $ea, "*: Walk. Learn to", $f1
    db "walk everywhere.", $fa, $f7
    db $ef, $ee, "Be careful to look", $ef, $ee, "everywhere.", $fa, $f7
    db $ef, $ee, "If you can fly,", $ef, $ee, "use that ability.", $f7
    db $f0

Message_04_49::
    db $ea, "*: I see. You wish", $f1
    db "to chart your own", $fa, $f7
    db $ef, $ee, "destiny, do you?", $ef, $ee, "That is admirable.", $f7
    db $f0

Message_04_4A::
    db $ea, "*: Hear me out if", $f1
    db "you wish to fly.", $fa, $f7
    db $ef, $ee, "Stand at the edge", $ef, $ee, "of the world, and", $fa, $f7
    db $ef, $ee, "ride upon the wind", $ef, $ee, "to cross the sky.", $f7
    db $f0

Message_04_4B::
    db $ea, "*: Welcome! How may", $f1
    db "I serve you?", $f7
    db $f0

Message_04_4C::
    db $ea, "*: How may our", $f1
    db "church help you?", $f7
    db $f0

Message_04_4D::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'The finder of", $ef, $ee, "three treasures", $fa, $f7
    db $ef, $ee, "shall earn a", $ef, $ee, "handsome reward.", $fa, $f7
    db $ef, $ee, "They are the", $ef, $ee, "Heaven Sword,", $fa, $f7
    db $ef, $ee, "Heaven Armor and", $ef, $ee, "Heaven Helmet.", $95, $f7
    db $f0

Message_04_4E::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'The Heaven Sword,", $ef, $ee, "Heaven Armor and", $fa, $f7
    db $ef, $ee, "the Heaven Helmet.", $ef, $ee, "Gather these, and", $fa, $f7
    db $ef, $ee, "the LightOrb shall", $ef, $ee, "be your reward.", $fa, $f7
    db $ef, $ee, "I will await word", $ef, $ee, "in the Castle.", $fa, $f7
    db $ef, $ee, "-The King", $95, $ef, $ee, $f7
    db $f0

Message_04_4F::
    db $f9, "0 checked the", $f1
    db "oven.", $fa, $f7
    db $ef, $ee, "Bizarre bugs were", $ef, $ee, "on skewers.", $f7
    db $f0

Message_04_50::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "A face grinned up", $ef, $ee, "from the darkness.", $fa, $f7
    db $ef, $ee, "The vase actually", $ef, $ee, "was an EvilPot.", $f7
    db $f0

Message_04_51::
    db $ea, "*: Welcome to our", $f1
    db "inn.", $f7
    db $f0

Message_04_52::
    db $ea, "*: The Change Staff", $f1
    db "will open paths.", $fa, $f7
    db $ef, $ee, "I am counting on", $ef, $ee, "you to find the", $fa, $f7
    db $ef, $ee, "LightOrb.", $ef, $ee, "Don't fail me!", $f7
    db $f0

Message_04_53::
    db $ea, "*: Hey, kiddo!", $f1
    db "You're new here.", $fa, $f7
    db $ef, $ee, "Don't cause any", $ef, $ee, "trouble in here!", $f7
    db $f0

Message_04_56::
    db $ea, "*: Hey, kiddo! You", $f1
    db "treasure hunting?", $fa, $f7
    db $ef, $ee, "The place is just", $ef, $ee, "crawling with", $fa, $f7
    db $ef, $ee, "treasure hunters", $ef, $ee, "and the like!", $f7
    db $f0

Message_04_57::
    db $ea, "*: On the island to", $f1
    db "the west, there is", $fa, $f7
    db $ef, $ee, "the Wind Tower.", $ef, $ee, "But I can't fly,", $fa, $f7
    db $ef, $ee, "so I can't get over", $ef, $ee, "there.", $f7
    db $f0

Message_04_58::
    db $ea, "*: To the east is a", $f1
    db "suspension bridge.", $fa, $f7
    db $ef, $ee, "Beyond it is a", $ef, $ee, "haunted castle.", $fa, $f7
    db $ef, $ee, "There, the undead", $ef, $ee, "guard a treasure.", $fa, $f7
    db $ef, $ee, "However, if you", $ef, $ee, "can't break the", $fa, $f7
    db $ef, $ee, "traps that they", $ef, $ee, "have in place, you", $fa, $f7
    db $ef, $ee, "could end up", $ef, $ee, "joining them.", $f7
    db $f0

Message_04_59::
    db $ea, "*: Those inside the", $f1
    db "haunted castle", $fa, $f7
    db $ef, $ee, "speak only amongst", $ef, $ee, "themselves.", $fa, $f7
    db $ef, $ee, "You'll have to", $ef, $ee, "solve the traps", $fa, $f7
    db $ef, $ee, "yourself-there is", $ef, $ee, "no one to help.", $f7
    db $f0

Message_04_5A::
    db $f9, "0 checked the", $f1
    db "small hole.", $fa, $f7
    db $ef, $ee, "It looked large", $ef, $ee, "enough to enter.", $f7
    db $f0

Message_04_5B::
    db $f9, "0 checked the", $f1
    db "small hole.", $fa, $f7
    db $ef, $ee, "It's too small to", $ef, $ee, "fit some heads", $a4, $f7
    db $f0

Message_04_5C::
    db $f9, "0 checked the", $f1
    db "small hole.", $fa, $f7
    db $ef, $ee, "It's too small to", $ef, $ee, "fit some heads", $a4, $f7
    db $f0

Message_04_5D::
    db $ea, "*: You can take", $f1
    db "this treasure,", $fa, $f7
    db $ef, $ee, "but only if you", $ef, $ee, "can beat me!", $fa, $f7
    db $ef, $ee, "No need to hold", $ef, $ee, "back just because", $fa, $f7
    db $ef, $ee, "I happen to be", $ef, $ee, "smaller than you!", $f7
    db $f0

Message_04_5E::
    db $ea, "*: I'm up for your", $f1
    db "challenge anytime!", $f7
    db $f0

Message_04_5F::
    db $ea, "*: Heh, you're not", $f1
    db "half bad!", $fa, $f7
    db $ef, $ee, "As promised, here's", $ef, $ee, "your treasure!", $f7
    db $f0

Message_04_60::
    db $ea, "*: Let the power of", $f1
    db "justice smite the", $fa, $f7
    db $ef, $ee, "greedy seekers of", $ef, $ee, "treasure", $a4, $f7
    db $f0

Message_04_61::
    db $ea, "*: Step once on", $f1
    db "each of the two", $fa, $f7
    db $ef, $ee, "floor tiles on the", $ef, $ee, "right.", $f7
    db $f0

Message_04_62::
    db $f9, "0 checked the", $f1
    db "notice.", $fa, $f7
    db $ef, $ee, "'Lay the souls to", $ef, $ee, "eternal rest.", $95, $f7
    db $f0

Message_04_63::
    db $f9, "0 checked the", $f1
    db "notice.", $fa, $f7
    db $ef, $ee, "'Follow the eyes", $ef, $ee, "of the undead.", $fa, $f7
    db $ef, $ee, "The key lies at", $ef, $ee, "the end.", $95, $f7
    db $f0

Message_04_64::
    db $f9, "0 checked the", $f1
    db "gravestone.", $fa, $f7
    db $ef, $ee, "There was a round", $ef, $ee, "button. Press it?", $ff, $f0

Message_04_65::
    db "A door opened", $f1
    db "somewhere", $a4, $f7
    db $f0

Message_04_66::
    db $ea, "*: You overcame the", $f1
    db "traps I laid", $a4, $fa, $f7
    db $ef, $ee, "I'm impressed by", $ef, $ee, "your courage, and", $fa, $f7
    db $ef, $ee, "moreso because of", $ef, $ee, "your age.", $fa, $f7
    db $ef, $ee, "But if you want", $ef, $ee, "the treasure,", $fa, $f7
    db $ef, $ee, "you'll have to", $ef, $ee, "defeat me first!", $f7
    db $f0

Message_04_67::
    db $ea, "*: Wahahahah! Here", $f1
    db "again, are you?", $fa, $f7
    db $ef, $ee, "I commend you on", $ef, $ee, "your courage!", $fa, $f7
    db $ef, $ee, "But if you want", $ef, $ee, "the treasure,", $fa, $f7
    db $ef, $ee, "you'll have to", $ef, $ee, "defeat me first!", $f7
    db $f0

Message_04_68::
    db $ea, "*: You've beaten me", $f1
    db "fairly", $a4, $fa, $f7
    db $ef, $ee, "Take the treasure", $a4, $ef, $ee, "Farewell", $a4, $f7
    db $f0

Message_04_69::
    db $ea, "*: What? You have", $f1
    db "the three items?", $fa, $f7
    db $ef, $ee, $a4, "It's true", $a4, $ef, $ee, "They're here.", $fa, $f7
    db $ef, $ee, "Fine, go in!", $ef, $ee, $f7
    db $f0

Message_04_6A::
    db $ea, "*: The King's castle", $f1
    db "is reached by the", $fa, $f7
    db $ef, $ee, "traveler's gate", $ef, $ee, "here.", $f7
    db $f0

Message_04_6B::
    db $ea, "*: What? You have", $f1
    db "the three items?", $fa, $f7
    db $ef, $ee, "I'm busy! Don't", $ef, $ee, "waste my time!", $f7
    db $f0

Message_04_6C::
    db $ea, "*: Who would've", $f1
    db "thought anyone", $fa, $f7
    db $ef, $ee, "would collect all", $ef, $ee, "three treasures", $a4, $f7
    db $f0

Message_04_6D::
    db $ea, "*: The monster", $f1
    db "army's general is", $fa, $f7
    db $ef, $ee, "beyond here.", $ef, $ee, "You had better", $fa, $f7
    db $ef, $ee, "be on your best", $ef, $ee, "behavior.", $f7
    db $f0

Message_04_6E::
    db $ea, "*: Our King's castle", $f1
    db "is an invincible", $fa, $f7
    db $ef, $ee, "fortress that is", $ef, $ee, "guarded by the", $fa, $f7
    db $ef, $ee, "elite in the", $ef, $ee, "monster army.", $f7
    db $f0

Message_04_6F::
    db $ea, "*: What? You've got", $f1
    db "the three items?", $fa, $f7
    db $ef, $ee, "That means you get", $ef, $ee, "the LightOrb", $a4, $fa, $f7
    db $ef, $ee, "That means you'll", $ef, $ee, "be our next King!", $fa, $f7
    db $ef, $ee, "Well, when you do", $ef, $ee, "become King, I do", $fa, $f7
    db $ef, $ee, "hope you will", $ef, $ee, "remember me.", $f7
    db $f0

Message_04_70::
    db $ea, "*: Hm? How did you", $f1
    db "get in here?", $f7
    db $f0

Message_04_71::
    db $ea, "*: I'm surprised", $f1
    db "anyone managed to", $fa, $f7
    db $ef, $ee, "find all three", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "Anyway, the King", $ef, $ee, "has left orders", $fa, $f7
    db $ef, $ee, "that you should", $ef, $ee, "bring your trove", $fa, $f7
    db $ef, $ee, "to the meeting", $ef, $ee, "chamber.", $fa, $f7
    db $ef, $ee, "To reach the King's", $ef, $ee, "castle, take the", $fa, $f7
    db $ef, $ee, "traveler's gate at", $ef, $ee, "the back.", $f7
    db $f0

Message_04_72::
    db $ea, "*: If you can't even", $f1
    db "reach the Castle's", $fa, $f7
    db $ef, $ee, "meeting chamber, I", $ef, $ee, "would think that", $fa, $f7
    db $ef, $ee, "you don't have the", $ef, $ee, "right to get the", $fa, $f7
    db $ef, $ee, "LightOrb from the", $ef, $ee, "current King.", $f7
    db $f0

Message_04_73::
    db $ea, "*: You! I've never", $f1
    db "seen you before!", $fa, $f7
    db $ef, $ee, "You're not one of", $ef, $ee, "our army!", $f7
    db $f0

Message_04_74::
    db $ea, "*: Hm? Are you a", $f1
    db "new recruit?", $fa, $f7
    db $ef, $ee, "What unit do you", $ef, $ee, "belong to?", $fa, $f7
    db $ef, $ee, "Why aren't you", $ef, $ee, "answering me?", $fa, $f7
    db $ef, $ee, "Are you a spy?", $ef, $ee, "That must be it!", $f7
    db $f0

Message_04_75::
    db $ea, "*: Oh, you're the", $f1
    db "cooking crew.", $fa, $f7
    db $ef, $ee, "Do a good job with", $ef, $ee, "our meals.", $f7
    db $f0

Message_04_76::
    db $ea, "*: Awaargh, I'm", $f1
    db "late, I'm late!", $fa, $f7
    db $ef, $ee, "They overwork us", $ef, $ee, "terribly here.", $f7
    db $f0

Message_04_77::
    db $ea, "*: They keep piling", $f1
    db "on these ludicrous", $fa, $f7
    db $ef, $ee, "orders. If I ever", $ef, $ee, "become important,", $fa, $f7
    db $ef, $ee, "they", $44, " better watch", $ef, $ee, "out!", $f7
    db $f0

Message_04_78::
    db $ea, "*: Gaah! You found", $f1
    db "me while I was", $fa, $f7
    db $ef, $ee, "sluffing off from", $ef, $ee, "work", $a4, $f7
    db $f0

Message_04_79::
    db $ea, "*: Ah, so good of", $f1
    db "you to come!", $fa, $f7
    db $ef, $ee, "Well? Where are", $ef, $ee, "the three items?", $fa, $f7
    db $ef, $ee, "What? You didn't", $ef, $ee, "bring them?", $fa, $f7
    db $ef, $ee, "Why did you bother", $ef, $ee, "coming here?", $fa, $f7
    db $ef, $ee, "Find the three", $ef, $ee, "treasures and", $fa, $f7
    db $ef, $ee, "bring them to me.", $ef, $ee, "I will wait here", $fa, $f7
    db $ef, $ee, "for as long as it", $ef, $ee, "takes.", $f7
    db $f0

Message_04_7A::
    db $ea, "*: Ah, so good of", $f1
    db "you to come!", $fa, $f7
    db $ef, $ee, "Well? Where are", $ef, $ee, "the three items?", $f7
    db $f0

Message_04_7B::
    db $f9, "0 handed over", $f1
    db "the Heaven Helmet.", $f7
    db $f0

Message_04_7C::
    db $f9, "0 handed over", $f1
    db "the Heaven Armor.", $f7
    db $f0

Message_04_7D::
    db $f9, "0 handed over", $f1
    db "the Heaven Sword.", $f7
    db $f0

Message_04_7E::
    db $ea, "*: Good. You have", $f1
    db "brought the three", $fa, $f7
    db $ef, $ee, "treasures that I", $ef, $ee, "asked for.", $fa, $f7
    db $ef, $ee, "Well done.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, $a4, "And now, the", $ef, $ee, "final test.", $fa, $f7
    db $ef, $ee, "Show me that you", $ef, $ee, "are worthy of", $fa, $f7
    db $ef, $ee, "receiving the", $ef, $ee, "LightOrb!", $f7
    db $f0

Message_04_7F::
    db $ea, "*: Fwahahaha! Don't", $f1
    db "you ever give up?", $fa, $f7
    db $ef, $ee, "Fine! If you want", $ef, $ee, "the LightOrb, you", $fa, $f7
    db $ef, $ee, "will have to take", $ef, $ee, "it by force!", $f7
    db $f0

Message_04_80::
    db $ea, "*: Gwaah! You've", $f1
    db "beaten me fairly!", $fa, $f7
    db $ef, $ee, "But I am merely a", $ef, $ee, "gate keeper.", $fa, $f7
    db $ef, $ee, "I'm under the", $ef, $ee, "LightOrb's spell,", $fa, $f7
    db $ef, $ee, "like everyone", $ef, $ee, "else.", $fa, $f7
    db $ef, $ee, "The real King is", $ef, $ee, "in a room beyond", $fa, $f7
    db $ef, $ee, "this one. If you", $ef, $ee, "want the LightOrb,", $fa, $f7
    db $ef, $ee, "you'll have to", $ef, $ee, "keep going.", $f7
    db $f0

Message_04_81::
    db $ea, "Kameha: So it was", $f1
    db "you who got the", $fa, $f7
    db $ef, $ee, "three treasures,", $ef, $ee, $f9, "0", $a4, $fa, $f7
    db $ef, $ee, "Surprised? I'm the", $ef, $ee, "Monster King!", $fa, $f7
    db $ef, $ee, "While looking for", $ef, $ee, "a plug for the", $fa, $f7
    db $ef, $ee, "Log's Navel, a", $ef, $ee, "huge bird caught", $fa, $f7
    db $ef, $ee, "me, and hauled me", $ef, $ee, "up to its nest.", $fa, $f7
    db $ef, $ee, "There, I found the", $ef, $ee, "LightOrb.", $fa, $f7
    db $ef, $ee, "The Orb didn't work", $ef, $ee, "as the plug.", $fa, $f7
    db $ef, $ee, "So, I used the", $ef, $ee, "LightOrb's power", $fa, $f7
    db $ef, $ee, "to become the King", $ef, $ee, "of the monsters.", $fa, $f7
    db $ef, $ee, "And then I ordered", $ef, $ee, "my subordinates to", $fa, $f7
    db $ef, $ee, "look for treasures", $ef, $ee, "that might work.", $f7
    db $f0

Message_04_82::
    db $ea, "Kameha: If the", $f1
    db "three items that", $fa, $f7
    db $ef, $ee, "you brought are no", $ef, $ee, "good as plugs,", $fa, $f7
    db $ef, $ee, "there can't be", $ef, $ee, "anything else", $fa, $f7
    db $ef, $ee, "useable in this", $ef, $ee, "world.", $fa, $f7
    db $ef, $ee, "They must be", $ef, $ee, "worried about me", $fa, $f7
    db $ef, $ee, "back home. I", $44, $ef, $ee, "better go home.", $f7
    db $f0

Message_04_83::
    db $ea, "Kameha: Wha-wha", $f1
    db "whaaaat?", $fa, $f7
    db $ef, $ee, "What just happened", $ef, $ee, "now?", $f7
    db $f0

Message_04_84::
    db $ea, "Kameha: Who are", $f1
    db "you to disturb me?", $f7
    db $f0

Message_04_85::
    db $ea, "*: Greetings! I am", $f1
    db "Darck, the King of", $fa, $f7
    db $ef, $ee, "Limbo, a world", $ef, $ee, "between worlds.", $fa, $f7
    db $ef, $ee, "Darck: I travel to", $ef, $ee, "many worlds as I", $fa, $f7
    db $ef, $ee, "seek treasures for", $ef, $ee, "my collection.", $fa, $f7
    db $ef, $ee, "I'm here to collect", $ef, $ee, "your treasure.", $f7
    db $f0

Message_04_86::
    db $ea, "Kameha: What? Why", $f1
    db "do you do that?", $f7
    db $f0

Message_04_87::
    db $ea, "Darck: Well, for", $f1
    db "me, anything that", $fa, $f7
    db $ef, $ee, "evokes envy or", $ef, $ee, "jealousy in others", $fa, $f7
    db $ef, $ee, "is an invaluable", $ef, $ee, "treasure.", $fa, $f7
    db $ef, $ee, "For those emotions", $ef, $ee, "give me strength.", $fa, $f7
    db $ef, $ee, "I am the true", $ef, $ee, "Monster King.", $fa, $f7
    db $ef, $ee, "While I was away,", $ef, $ee, "I understand my", $fa, $f7
    db $ef, $ee, "subordinates were", $ef, $ee, "abused by you?", $fa, $f7
    db $ef, $ee, "Tch, the fools.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "One could never", $ef, $ee, "get good help", $a4, $fa, $f7
    db $ef, $ee, "Anyway, enough of", $ef, $ee, "this idle chatter.", $fa, $f7
    db $ef, $ee, "In my collection,", $ef, $ee, "I have something", $fa, $f7
    db $ef, $ee, "that will plug the", $ef, $ee, "Log's Navel.", $fa, $f7
    db $ef, $ee, "You need it to", $ef, $ee, "save GreatLog.", $fa, $f7
    db $ef, $ee, "I'm willing to", $ef, $ee, "exchange it for", $fa, $f7
    db $ef, $ee, "the treasures that", $ef, $ee, "you've collected.", $fa, $f7
    db $ef, $ee, "I would consider", $ef, $ee, "that an equitable", $fa, $f7
    db $ef, $ee, "arrangement.", $ef, $ee, "Wouldn't you agree?", $ff, $f0

Message_04_88::
    db $ea, "Darck: I imagine", $f1
    db "that you don't have", $fa, $f7
    db $ef, $ee, "much time left, do", $ef, $ee, "you?", $fa, $f7
    db $ef, $ee, "I don't think my", $ef, $ee, "offer is unfair.", $fa, $f7
    db $ef, $ee, "Wouldn't you agree?", $ef, $ee, $ff, $f0

Message_04_8B::
    db $ea, "Darck: Good!", $f1
    db "We have a deal!", $fa, $f7
    db $ef, $ee, "Fine, fine!", $ef, $ee, "Fwahahahaha!", $fa, $f7
    db $ef, $ee, "I will take this", $ef, $ee, "LightOrb and the", $fa, $f7
    db $ef, $ee, "treasures here", $ef, $ee, "first.", $fa, $f7
    db $ef, $ee, "In return, take", $ef, $ee, "this Magic Key.", $f7
    db $f0

Message_04_8C::
    db $ea, "Darck: That key", $f1
    db "will bring you to", $fa, $f7
    db $ef, $ee, "my Castle.", $ef, $ee, "I will be waiting", $fa, $f7
    db $ef, $ee, "for you to bring", $ef, $ee, "me more treasures.", $f7
    db $f0

Message_04_8D::
    db $f9, "0 received the", $f1
    db "Limbo Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_04_8E::
    db $ea, "Darck: I will be", $f1
    db "readying a proper", $fa, $f7
    db $ef, $ee, "welcome for you", $ef, $ee, "when you come.", $f7
    db $f0

Message_04_8F::
    db $ea, "Kameha: Our", $f1
    db "treasures!", $fa, $f7
    db $ef, $ee, "He took them all", $ef, $ee, "away from us!", $fa, $f7
    db $ef, $ee, $a4, "Anyway, are you", $ef, $ee, "sure about what", $fa, $f7
    db $ef, $ee, "you just did?", $ef, $ee, "That promise", $a4, $fa, $f7
    db $ef, $ee, "He even wants the", $ef, $ee, "treasures you got", $fa, $f7
    db $ef, $ee, "already as plugs", $ef, $ee, "for the Navel", $a4, $fa, $f7
    db $ef, $ee, "It has to be a", $ef, $ee, "trap!", $f7
    db $f0

Message_04_90::
    db "A voice echoed", $f1
    db "from nowhere", $a4, $f7
    db $f0
    ds $13d, $00
