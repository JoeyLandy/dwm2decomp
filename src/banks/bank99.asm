SECTION "Bank 99", ROMX[$4000], BANK[$99]
    db $99

; overflow for message bank $2D: wStringIndex -= $D5, then BeginStringDisplay with the table
; MessageStrings_Bank2D_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2D_Overflow::
    ld de, MessageStrings_Bank2D_Overflow
    ld a, [wStringIndex]
    sub $d5
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2D: wStringIndex -= $D5, then CopyStringToBuffer with the table
; MessageStrings_Bank2D_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2D_Overflow::
    ld de, MessageStrings_Bank2D_Overflow
    ld a, [wStringIndex]
    sub $d5
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; overflow for message bank $2E: wStringIndex -= $A6, then BeginStringDisplay with the table
; MessageStrings_Bank2E_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2E_Overflow::
    ld de, MessageStrings_Bank2E_Overflow
    ld a, [wStringIndex]
    sub $a6
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2E: wStringIndex -= $A6, then CopyStringToBuffer with the table
; MessageStrings_Bank2E_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2E_Overflow::
    ld de, MessageStrings_Bank2E_Overflow
    ld a, [wStringIndex]
    sub $a6
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $26, $40, $cd, $11, $26, $c9

; overflow for message bank $7C: wStringIndex -= $87, then BeginStringDisplay with the table
; MessageStrings_Bank7C_Overflow in this bank (E-0080)
BeginStringDisplay_Bank7C_Overflow::
    ld de, MessageStrings_Bank7C_Overflow
    ld a, [wStringIndex]
    sub $87
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $7C: wStringIndex -= $87, then CopyStringToBuffer with the table
; MessageStrings_Bank7C_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank7C_Overflow::
    ld de, MessageStrings_Bank7C_Overflow
    ld a, [wStringIndex]
    sub $87
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $4b, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_99_4070::
MessageStrings_Bank2D_Overflow::
    dw StringList_99_4072 ; id 0

; category list of StringCategories_99_4070; one pointer per wStringIndex (E-0217)
; record: string
StringList_99_4072::
    dw String_99_4070_00_00 ; id 0
    dw String_99_4070_00_01 ; id 1
    dw String_99_4070_00_02 ; id 2
    dw String_99_4070_00_03 ; id 3
    dw String_99_4070_00_04 ; id 4
    dw String_99_4070_00_05 ; id 5
    dw String_99_4070_00_06 ; id 6
    dw String_99_4070_00_07 ; id 7
    dw String_99_4070_00_08 ; id 8
    dw String_99_4070_00_09 ; id 9
    dw String_99_4070_00_0A ; id 10
    dw String_99_4070_00_0B ; id 11
    dw String_99_4070_00_0C ; id 12
    dw String_99_4070_00_0D ; id 13
    dw String_99_4070_00_0E ; id 14
    dw String_99_4070_00_0F ; id 15
    dw String_99_4070_00_10 ; id 16
    dw String_99_4070_00_11 ; id 17
    dw String_99_4070_00_12 ; id 18
    dw String_99_4070_00_13 ; id 19
    dw String_99_4070_00_14 ; id 20
    dw String_99_4070_00_15 ; id 21
    dw String_99_4070_00_16 ; id 22
    dw String_99_4070_00_17 ; id 23
    dw String_99_4070_00_18 ; id 24
    dw String_99_4070_00_19 ; id 25
    dw String_99_4070_00_1A ; id 26
    dw String_99_4070_00_1B ; id 27
    dw String_99_4070_00_1C ; id 28
    dw String_99_4070_00_1D ; id 29
    dw String_99_4070_00_1E ; id 30
    dw String_99_4070_00_1F ; id 31
    dw String_99_4070_00_20 ; id 32
    dw String_99_4070_00_21 ; id 33
    dw String_99_4070_00_22 ; id 34
    dw String_99_4070_00_23 ; id 35
    dw String_99_4070_00_24 ; id 36
    dw String_99_4070_00_25 ; id 37
    dw String_99_4070_00_26 ; id 38
    dw String_99_4070_00_27 ; id 39
    dw String_99_4070_00_28 ; id 40
    dw String_99_4070_00_29 ; id 41
    dw String_99_4070_00_2A ; id 42

String_99_4070_00_00::
    db $ea, "*: Make sure you", $f1
    db "tell the others ", $fa, $f7
    db $ef, $ee, "that I'm No. 1,", $ef, $ee, "do you understand?", $f7
    db $f0

String_99_4070_00_01::
    db $ea, "*: I'm as plain as", $f1
    db "a baked potato.", $fa, $f7
    db $ef, $ee, "Even what I say is", $ef, $ee, "bland.", $f7
    db $f0

String_99_4070_00_02::
    db $ea, "*: Isn't the weather", $f1
    db "fabulous?", $fa, $f7
    db $ef, $ee, "We need to be out", $ef, $ee, "traveling!", $f7
    db $f0

String_99_4070_00_03::
    db $ea, "*: Don't be so", $f1
    db "obstinate?", $fa, $f7
    db $ef, $ee, "But I'm not!", $ef, $ee, "Huh? I'm acting it?", $f7
    db $f0

String_99_4070_00_04::
    db $ea, "*: Master, please", $f1
    db "consider saving", $fa, $f7
    db $ef, $ee, "your money, and", $ef, $ee, "not wasting it.", $f7
    db $f0

String_99_4070_00_05::
    db $ea, "*: I plan to leave", $f1
    db "as I see fit.", $fa, $f7
    db $ef, $ee, "Leave me alone,", $ef, $ee, "please.", $f7
    db $f0

String_99_4070_00_06::
    db $ea, "*: Meat, meat, give", $f1
    db "me meat!", $fa, $f7
    db $ef, $ee, "Or I won't work", $ef, $ee, "for you. Meat!", $f7
    db $f0

String_99_4070_00_07::
    db $ea, "*: Know your enemy,", $f1
    db "know yourself,", $fa, $f7
    db $ef, $ee, "and you will win", $ef, $ee, "without danger.", $f7
    db $f0

String_99_4070_00_08::
    db $ea, "*: Use a mate as a", $f1
    db "shield, escape", $a4, $fa, $f7
    db $ef, $ee, "Whoops, uh", $a4, " nah,", $ef, $ee, "nothing", $a4, $f7
    db $f0

String_99_4070_00_09::
    db $ea, "*: Enemies deserve", $f1
    db "no mercy!", $fa, $f7
    db $ef, $ee, "Crush them with", $ef, $ee, "all our might!", $f7
    db $f0

String_99_4070_00_0A::
    db $ea, "*: I", $a4, " Um", $a4, " Shy", $a4, $f1
    db "Sorry", $a4, " I'm sorry", $a4, $f7
    db $f0

String_99_4070_00_0B::
    db $ea, "*: For my partners,", $f1
    db "and most of all", $fa, $f7
    db $ef, $ee, "for you, master,", $ef, $ee, "I'll do my best!", $f7
    db $f0

String_99_4070_00_0C::
    db $ea, "*: Oh, no", $a4, $f1
    db "Must I go?", $fa, $f7
    db $ef, $ee, "Caves and dark", $ef, $ee, "places are scary", $a4, $f7
    db $f0

String_99_4070_00_0D::
    db $ea, "*: I'll clean, wash,", $f1
    db "whatever you wish!", $fa, $f7
    db $ef, $ee, "Just give me the", $ef, $ee, "word!", $f7
    db $f0

String_99_4070_00_0E::
    db $ea, "*: Well, is seems", $f1
    db "to me, the world", $fa, $f7
    db $ef, $ee, "at large is pretty", $ef, $ee, "peaceful, ayup!", $f7
    db $f0

String_99_4070_00_0F::
    db $ea, "*: Is there any way", $f1
    db "of fighting while", $fa, $f7
    db $ef, $ee, "you're asleep?", $ef, $ee, "How ideal!", $f7
    db $f0

String_99_4070_00_10::
    db $ea, "*: The dark fire", $f1
    db "that spirals in my", $fa, $f7
    db $ef, $ee, "heart shall never", $ef, $ee, "be extinguished!", $f7
    db $f0

String_99_4070_00_11::
    db $ea, "*: Seeing your joy", $f1
    db "adds to my own.", $f7
    db $f0

String_99_4070_00_12::
    db $ea, "*: I will take care", $f1
    db "of you totally!", $f7
    db $f0

String_99_4070_00_13::
    db $ea, "*: World domination", $f1
    db "is the ultimate", $fa, $f7
    db $ef, $ee, "goal in my life!", $ef, $ee, $f7
    db $f0

String_99_4070_00_14::
    db $ea, "*: However dire the", $f1
    db "situation, I will", $fa, $f7
    db $ef, $ee, "always shield you", $ef, $ee, "from danger.", $f7
    db $f0

String_99_4070_00_15::
    db $ea, "*: Human! You be", $f1
    db "grateful that I", $fa, $f7
    db $ef, $ee, "have even chosen", $ef, $ee, "to accompany you!", $f7
    db $f0

String_99_4070_00_16::
    db $ea, "*: Even once, I", $f1
    db "would have liked", $fa, $f7
    db $ef, $ee, "to have been a", $ef, $ee, "hero", $a4, $f7
    db $f0

String_99_4070_00_17::
    db $ea, "*: Fufufu", $a4, " Perhaps", $f1
    db "we will be enemies", $fa, $f7
    db $ef, $ee, "if we meet again", $ef, $ee, "in the future.", $f7
    db $f0

String_99_4070_00_18::
    db $ea, "*: For you, master,", $f1
    db "I will leap into", $fa, $f7
    db $ef, $ee, "a pool of fire, if", $ef, $ee, "you so command me.", $f7
    db $f0

String_99_4070_00_19::
    db $ea, "*: Excitement,", $f1
    db "tension", $a4, $fa, $f7
    db $ef, $ee, "They are emotions", $ef, $ee, "without meaning.", $f7
    db $f0

String_99_4070_00_1A::
    db $ea, "*: People and", $f1
    db "monsters should be", $fa, $f7
    db $ef, $ee, "punished alike for", $ef, $ee, "sins they commit.", $f7
    db $f0

String_99_4070_00_1B::
    db $ea, "*: Give me the", $f1
    db "chance to shine.", $fa, $f7
    db $ef, $ee, "I will protect you", $ef, $ee, "if you do.", $f7
    db $f0

String_99_4070_00_1C::
    db $ea, "*: I am the Lord of", $f1
    db "the monsters!", $fa, $f7
    db $ef, $ee, "What? Too plain?", $ef, $ee, "You think so?", $f7
    db $f0

String_99_4070_00_1D::
    db $ea, "*: Are there no", $f1
    db "unbreakable toys ", $fa, $f7
    db $ef, $ee, "that will keep", $ef, $ee, "coming back?", $f7
    db $f0

String_99_4070_00_1E::
    db $ea, "*: Don't bother me", $a4, $f1
    db "Leave me be", $a4, $f7
    db $f0

String_99_4070_00_1F::
    db $ea, "*: Let me conquer a", $f1
    db "world for you, eh?", $f7
    db $f0

String_99_4070_00_20::
    db $ea, "*: To be conquered", $f1
    db "by me is to know", $fa, $f7
    db $ef, $ee, "happiness!", $ef, $ee, "Hahahahahah!", $f7
    db $f0

String_99_4070_00_21::
    db $ea, "*: The world is", $f1
    db "mine!", $fa, $f7
    db $ef, $ee, "That is the way it", $ef, $ee, "has to be!", $f7
    db $f0

String_99_4070_00_22::
    db $ea, "*: Everything is", $f1
    db "according to plan.", $fa, $f7
    db $ef, $ee, "Nothing unexpected", $ef, $ee, "can happen.", $f7
    db $f0

String_99_4070_00_23::
    db $ea, "*: You can be the", $f1
    db "decoy. I'll strike", $fa, $f7
    db $ef, $ee, "while you're under", $ef, $ee, "attack. How's that?", $f7
    db $f0

String_99_4070_00_24::
    db $ea, "*: The feelings of", $f1
    db "hatred and sorrow", $fa, $f7
    db $ef, $ee, "become my power.", $ef, $ee, $f7
    db $f0

String_99_4070_00_25::
    db $ea, "*: Traveling is", $f1
    db "fine, but quietly", $fa, $f7
    db $ef, $ee, "reading is also", $ef, $ee, "pleasant", $a4, $f7
    db $f0

String_99_4070_00_26::
    db $ea, "*: All my power, I", $f1
    db "will use for you", $a4, $f7
    db $f0

String_99_4070_00_27::
    db $ea, "*: The p-power of", $f1
    db "heroes is scary", $a4, $f7
    db $f0

String_99_4070_00_28::
    db $ea, "*: If you would", $f1
    db "allow it, I wish", $fa, $f7
    db $ef, $ee, "to conquer this", $ef, $ee, "world.", $f7
    db $f0

String_99_4070_00_29::
    db $ea, "*: Life isn't bad!", $f1
    db "Take it easy,", $fa, $f7
    db $ef, $ee, "slow down, relax", $ef, $ee, "and enjoy!", $f7
    db $f0

String_99_4070_00_2A::
    db $ea, "*: I can't be", $f1
    db "bothered to chat", $a4, $fa, $f7
    db $ef, $ee, "Be gone", $a4, $ef, $ee, $f7
    db $f0

StringCategories_99_4B35::
MessageStrings_Bank2E_Overflow::
    dw StringList_99_4B37 ; id 0

; category list of StringCategories_99_4B35; one pointer per wStringIndex (E-0217)
StringList_99_4B37::
    dw String_99_4B35_00_00 ; id 0
    dw String_99_4B35_00_01 ; id 1
    dw String_99_4B35_00_02 ; id 2
    dw String_99_4B35_00_03 ; id 3
    dw String_99_4B35_00_04 ; id 4
    dw String_99_4B35_00_05 ; id 5
    dw String_99_4B35_00_06 ; id 6
    dw String_99_4B35_00_07 ; id 7
    dw String_99_4B35_00_08 ; id 8
    dw String_99_4B35_00_09 ; id 9
    dw String_99_4B35_00_0A ; id 10
    dw String_99_4B35_00_0B ; id 11
    dw String_99_4B35_00_0C ; id 12
    dw String_99_4B35_00_0D ; id 13
    dw String_99_4B35_00_0E ; id 14
    dw String_99_4B35_00_0F ; id 15
    dw String_99_4B35_00_10 ; id 16
    dw String_99_4B35_00_11 ; id 17
    dw String_99_4B35_00_12 ; id 18
    dw String_99_4B35_00_13 ; id 19
    dw String_99_4B35_00_14 ; id 20
    dw String_99_4B35_00_15 ; id 21
    dw String_99_4B35_00_16 ; id 22
    dw String_99_4B35_00_17 ; id 23
    dw String_99_4B35_00_18 ; id 24
    dw String_99_4B35_00_18 ; id 25
    dw String_99_4B35_00_1A ; id 26
    dw String_99_4B35_00_1B ; id 27
    dw String_99_4B35_00_1C ; id 28
    dw String_99_4B35_00_1D ; id 29
    dw String_99_4B35_00_1E ; id 30
    dw String_99_4B35_00_1F ; id 31
    dw String_99_4B35_00_20 ; id 32
    dw String_99_4B35_00_21 ; id 33
    dw String_99_4B35_00_22 ; id 34
    dw String_99_4B35_00_23 ; id 35
    dw String_99_4B35_00_24 ; id 36
    dw String_99_4B35_00_25 ; id 37
    dw String_99_4B35_00_26 ; id 38
    dw String_99_4B35_00_27 ; id 39
    dw String_99_4B35_00_28 ; id 40
    dw String_99_4B35_00_29 ; id 41
    dw String_99_4B35_00_2A ; id 42
    dw String_99_4B35_00_2B ; id 43
    dw String_99_4B35_00_2C ; id 44
    dw String_99_4B35_00_2D ; id 45
    dw String_99_4B35_00_2E ; id 46
    dw String_99_4B35_00_2F ; id 47
    dw String_99_4B35_00_30 ; id 48
    dw String_99_4B35_00_31 ; id 49
    dw String_99_4B35_00_32 ; id 50
    dw String_99_4B35_00_33 ; id 51
    dw String_99_4B35_00_34 ; id 52
    dw String_99_4B35_00_35 ; id 53
    dw String_99_4B35_00_36 ; id 54
    dw String_99_4B35_00_37 ; id 55
    dw String_99_4B35_00_38 ; id 56
    dw String_99_4B35_00_38 ; id 57
    dw String_99_4B35_00_38 ; id 58
    dw String_99_4B35_00_38 ; id 59
    dw String_99_4B35_00_38 ; id 60
    dw String_99_4B35_00_38 ; id 61
    dw String_99_4B35_00_38 ; id 62
    dw String_99_4B35_00_38 ; id 63
    dw String_99_4B35_00_38 ; id 64
    dw String_99_4B35_00_38 ; id 65
    dw String_99_4B35_00_38 ; id 66
    dw String_99_4B35_00_38 ; id 67
    dw String_99_4B35_00_38 ; id 68
    dw String_99_4B35_00_38 ; id 69
    dw String_99_4B35_00_38 ; id 70
    dw String_99_4B35_00_38 ; id 71
    dw String_99_4B35_00_38 ; id 72
    dw String_99_4B35_00_38 ; id 73
    dw String_99_4B35_00_38 ; id 74
    dw String_99_4B35_00_38 ; id 75
    dw String_99_4B35_00_38 ; id 76
    dw String_99_4B35_00_38 ; id 77
    dw String_99_4B35_00_38 ; id 78
    dw String_99_4B35_00_38 ; id 79
    dw String_99_4B35_00_38 ; id 80
    dw String_99_4B35_00_38 ; id 81
    dw String_99_4B35_00_38 ; id 82
    dw String_99_4B35_00_38 ; id 83
    dw String_99_4B35_00_38 ; id 84
    dw String_99_4B35_00_38 ; id 85
    dw String_99_4B35_00_38 ; id 86
    dw String_99_4B35_00_38 ; id 87
    dw String_99_4B35_00_38 ; id 88
    dw String_99_4B35_00_38 ; id 89

String_99_4B35_00_00::
    db $eb, "*: Our daughter's", $f1
    db "only memento was", $fa, $f7
    db $ef, $ee, "taken from us by", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "I'm losing the will", $ef, $ee, "to keep living", $a4, $f7
    db $f0

String_99_4B35_00_01::
    db $ea, "*: It doesn't look", $f1
    db "like the monsters", $fa, $f7
    db $ef, $ee, "are coming from", $ef, $ee, "anywhere close.", $fa, $f7
    db $ef, $ee, "You ought to pay a", $ef, $ee, "visit to the hut", $fa, $f7
    db $ef, $ee, "by the spring in", $ef, $ee, "the west.", $fa, $f7
    db $ef, $ee, "It's for use by", $ef, $ee, "travelers.", $fa, $f7
    db $ef, $ee, "You might talk to", $ef, $ee, "them for clues.", $f7
    db $f0

String_99_4B35_00_02::
    db $eb, "*: The old couple", $f1
    db "across the way", $fa, $f7
    db $ef, $ee, "were robbed of a", $ef, $ee, "precious item.", $fa, $f7
    db $ef, $ee, "That's why they", $ef, $ee, "were so sad.", $f7
    db $f0

String_99_4B35_00_03::
    db $ea, "*: This is the", $f1
    db "traveler's hut.", $fa, $f7
    db $ef, $ee, "Stay and rest your", $ef, $ee, "feet a while.", $f7
    db $f0

String_99_4B35_00_04::
    db $ea, "*: That dealer,", $f1
    db "how expensive!", $fa, $f7
    db $ef, $ee, "Nobody can afford", $ef, $ee, "what he sells!", $fa, $f7
    db $ef, $ee, "But he does have", $ef, $ee, "super merchandise", $a4, $f7
    db $f0

String_99_4B35_00_05::
    db $ea, "*: Lately, the town", $f1
    db "of Miagen has been", $fa, $f7
    db $ef, $ee, "hit by plundering", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "Did you know that?", $ef, $ee, $ff, $f0

String_99_4B35_00_06::
    db $ea, "*: It's rumored that", $f1
    db "monsters raid the", $fa, $f7
    db $ef, $ee, "town by scaling", $ef, $ee, "the mountain range", $fa, $f7
    db $ef, $ee, "to the north.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "I think there was", $ef, $ee, "a forest nearby.", $fa, $f7
    db $ef, $ee, "Perhaps they came", $ef, $ee, "from that forest.", $fa, $f7
    db $ef, $ee, "The forest is east", $ef, $ee, "from here.", $f7
    db $f0

String_99_4B35_00_07::
    db $ea, "*: You didn't know?", $f1
    db "Well, listen up.", $fa, $f7
    db $ef, $ee, "Go to the town of", $ef, $ee, "Miagen.", $fa, $f7
    db $ef, $ee, "The townspeople", $ef, $ee, "are in an uproar.", $f7
    db $f0

String_99_4B35_00_08::
    db $eb, "*: That dealer's", $f1
    db "wares", $a4, $fa, $f7
    db $ef, $ee, "Could he sell any", $ef, $ee, "at those prices?", $fa, $f7
    db $ef, $ee, "I", $44, " like to make", $ef, $ee, "money like that", $a4, $f7
    db $f0

String_99_4B35_00_09::
    db $ea, "*: How does this", $f1
    db "ornament look?", $fa, $f7
    db $ef, $ee, "Take it home for", $ef, $ee, "just 12,000G.", $fa, $f7
    db $ef, $ee, "You say that's too", $ef, $ee, "much?", $fa, $f7
    db $ef, $ee, "Heh, scram if you", $ef, $ee, "have no money.", $f7
    db $f0

String_99_4B35_00_0A::
    db $ea, "*: How does this", $f1
    db "jewelry look?", $fa, $f7
    db $ef, $ee, "It's yours for a", $ef, $ee, "mere 18,000G.", $fa, $f7
    db $ef, $ee, "You say that's too", $ef, $ee, "much?", $fa, $f7
    db $ef, $ee, "Heh, scram if you", $ef, $ee, "have no money.", $f7
    db $f0

String_99_4B35_00_0B::
    db $ea, "*: How does this", $f1
    db "grand vase look?", $fa, $f7
    db $ef, $ee, "A bargain at", $ef, $ee, "23,000G!", $fa, $f7
    db $ef, $ee, "You say that's too", $ef, $ee, "much?", $fa, $f7
    db $ef, $ee, "Heh, scram if you", $ef, $ee, "have no money.", $f7
    db $f0

String_99_4B35_00_0C::
    db $ea, "*: I've no use for", $f1
    db "the poor.", $fa, $f7
    db $ef, $ee, "Come back if you", $ef, $ee, "make some money.", $f7
    db $f0

String_99_4B35_00_0D::
    db $ea, "*: How does this", $f1
    db "ornament look?", $fa, $f7
    db $ef, $ee, "Take it home for", $ef, $ee, "just 12,000G.", $fa, $f7
    db $ef, $ee, "What? Monsters?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Get lost if you're", $ef, $ee, "not buying!", $f7
    db $f0

String_99_4B35_00_0E::
    db $ea, "*: How does this", $f1
    db "jewelry look?", $fa, $f7
    db $ef, $ee, "It's yours for a", $ef, $ee, "mere 18,000G.", $fa, $f7
    db $ef, $ee, "What? Monsters?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "I don't have time", $ef, $ee, "to play games!", $f7
    db $f0

String_99_4B35_00_0F::
    db $ea, "*: How does this", $f1
    db "grand vase look?", $fa, $f7
    db $ef, $ee, "A bargain at", $ef, $ee, "23,000G!", $fa, $f7
    db $ef, $ee, "What? Monsters?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "If you're not a", $ef, $ee, "customer, beat it!", $f7
    db $f0

String_99_4B35_00_10::
    db $ea, "*: This pendant is", $f1
    db "yours for 38,000G", $a4, $fa, $f7
    db $ef, $ee, "What? Monsters?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "I don't know a", $ef, $ee, "thing about that!", $fa, $f7
    db $ef, $ee, "You're bad for", $ef, $ee, "business, vamoose!", $f7
    db $f0

String_99_4B35_00_11::
    db "The tower's entry", $f1
    db "is sealed tight.", $f7
    db $f0

String_99_4B35_00_12::
    db $ea, "*: Who are you?", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "You shouldn't be", $ef, $ee, "meddling here!", $f7
    db $f0

String_99_4B35_00_13::
    db $ea, "*: You're going to", $f1
    db "regret seeing us.", $fa, $f7
    db $ef, $ee, "We can't let you", $ef, $ee, "go blab. Gwaaaaah!", $f7
    db $f0

String_99_4B35_00_14::
    db $ea, "*: What, not you", $f1
    db "again!", $f7
    db $f0

String_99_4B35_00_15::
    db $ea, "*: We'll smash you", $f1
    db "as often as it", $fa, $f7
    db $ef, $ee, "takes to make you", $ef, $ee, "stop meddling!", $f7
    db $f0

String_99_4B35_00_16::
    db $ea, "*: Please! Mercy!", $f1
    db "Spare us!", $fa, $f7
    db $ef, $ee, "Take back every-", $ef, $ee, "thing we took!", $f7
    db $f0

String_99_4B35_00_17::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, "Pretty Ring.", $f7
    db $f0

String_99_4B35_00_18::
    db $f9, "0 found the", $f1
    db "Pretty Ring.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "Pretty Ring back.", $f7
    db $f0

String_99_4B35_00_1A::
    db $ea, "*: I dug deep in my", $f1
    db "purse to buy from", $fa, $f7
    db $ef, $ee, "that dealer, but", $ef, $ee, "it feel very odd.", $fa, $f7
    db $ef, $ee, "What I buy look", $ef, $ee, "very familiar.", $fa, $f7
    db $ef, $ee, "I don't know why.", $ef, $ee, "I will remember.", $f7
    db $f0

String_99_4B35_00_1B::
    db $ea, "*: What? Monsters", $f1
    db "attacked you in", $fa, $f7
    db $ef, $ee, "the northern", $ef, $ee, "forest?", $fa, $f7
    db $ef, $ee, "I'm surprised to", $ef, $ee, "see you alive.", $fa, $f7
    db $ef, $ee, "Um", $a4, " Are you maybe", $ef, $ee, "really tough?", $f7
    db $f0

String_99_4B35_00_1C::
    db $eb, "*: That dealer is a", $f1
    db "greedy hound!", $fa, $f7
    db $ef, $ee, "He won't tell me", $ef, $ee, "where he gets his", $fa, $f7
    db $ef, $ee, "merchandise, the", $ef, $ee, "cheapskate!", $f7
    db $f0

String_99_4B35_00_1D::
    db $ea, "*: For 47,000G this", $f1
    db "earring", $a4, " What?", $fa, $f7
    db $ef, $ee, "You went to the", $ef, $ee, "northern forest?", $fa, $f7
    db $ef, $ee, "Monsters didn't", $ef, $ee, "attack you?", $f7
    db $f0

String_99_4B35_00_1E::
    db $ea, "*: You defeated the", $f1
    db "monsters?", $fa, $f7
    db $ef, $ee, "You're not joking,", $ef, $ee, "are you?", $f7
    db $f0

String_99_4B35_00_1F::
    db $ea, "*: You defeated the", $f1
    db "monsters", $a4, $fa, $f7
    db $ef, $ee, $a4, "You're not joking,", $ef, $ee, "are you?", $f7
    db $f0

String_99_4B35_00_20::
    db $eb, "*: Are you Milayou's", $f1
    db "friend?", $fa, $f7
    db $ef, $ee, "The little monster", $ef, $ee, "master?", $fa, $f7
    db $ef, $ee, "You're after the", $ef, $ee, "bad monsters aren't", $fa, $f7
    db $ef, $ee, "you? That is just", $ef, $ee, "so neat!", $f7
    db $f0

String_99_4B35_00_21::
    db $ea, "*: If a monster", $f1
    db "could be good or", $fa, $f7
    db $ef, $ee, "bad, does that", $ef, $ee, "mean there are", $fa, $f7
    db $ef, $ee, "both good masters", $ef, $ee, "and bad ones?", $f7
    db $f0

String_99_4B35_00_22::
    db $ea, "*: Don't you think", $f1
    db "it's odd that the", $fa, $f7
    db $ef, $ee, "monsters are after", $ef, $ee, "treasures?", $fa, $f7
    db $ef, $ee, "I can understand", $ef, $ee, "if they went for", $fa, $f7
    db $ef, $ee, "food, but", $a4, $ef, $ee, $f7
    db $f0

String_99_4B35_00_23::
    db $eb, "*: Arrrgh! This is", $f1
    db "so infuriating!", $fa, $f7
    db $ef, $ee, "The monsters took", $ef, $ee, "my lingerie again!", $fa, $f7
    db $ef, $ee, "What exactly would", $ef, $ee, "they want with my", $fa, $f7
    db $ef, $ee, "underwear anyway?", $ef, $ee, "It makes no sense!", $f7
    db $f0

String_99_4B35_00_24::
    db $f9, "0 showed the", $f1
    db "Pretty Ring.", $f7
    db $f0

String_99_4B35_00_25::
    db $ea, "*: Ah", $a4, " That ring", $a4, $f1
    db "Is", $a4, " Is it", $a4, $fa, $f7
    db $ef, $ee, "That's my daughter's", $ef, $ee, "ring!", $f7
    db $f0

String_99_4B35_00_26::
    db $f9, "0 handed over", $f1
    db "the Pretty Ring.", $f7
    db $f0

String_99_4B35_00_27::
    db $ea, "*: Thank you for", $f1
    db "getting the ring", $fa, $f7
    db $ef, $ee, "back for me.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "But things haven't", $ef, $ee, "been good for us.", $fa, $f7
    db $ef, $ee, "First, there was a", $ef, $ee, "traveling dealer", $fa, $f7
    db $ef, $ee, "who was terribly", $ef, $ee, "pushy and rude.", $fa, $f7
    db $ef, $ee, "He also stared at", $ef, $ee, "our belongings.", $fa, $f7
    db $ef, $ee, "We had to throw", $ef, $ee, "him out.", $f7
    db $f0

String_99_4B35_00_28::
    db $ea, "*: Things haven't", $f1
    db "been good for us.", $fa, $f7
    db $ef, $ee, "There was a", $ef, $ee, "traveling dealer", $fa, $f7
    db $ef, $ee, "who was terribly", $ef, $ee, "pushy and rude.", $fa, $f7
    db $ef, $ee, "He also stared at", $ef, $ee, "our belongings.", $fa, $f7
    db $ef, $ee, "We had to throw", $ef, $ee, "him out.", $f7
    db $f0

String_99_4B35_00_29::
    db $eb, "*: Thank you for", $f1
    db "recovering our", $fa, $f7
    db $ef, $ee, "daughter's ring.", $ef, $ee, "As a show of our", $fa, $f7
    db $ef, $ee, "thanks, would you", $ef, $ee, "accept this?", $f7
    db $f0

String_99_4B35_00_2A::
    db $f9, "0 received a", $f1
    db "SageRock.", $f7
    db $f0

String_99_4B35_00_2B::
    db $f9, "0 received a", $f1
    db "SageRock.", $fa, $f7
    db $ef, $ee, "But there is no", $ef, $ee, "room for it.", $fa, $f7
    db $ef, $ee, $f9, "0 gave back", $ef, $ee, "the SageRock.", $f7
    db $f0

String_99_4B35_00_2C::
    db $eb, "*: We are grateful", $f1
    db "that you recovered", $fa, $f7
    db $ef, $ee, "our daughter's", $ef, $ee, "ring. As a show of", $fa, $f7
    db $ef, $ee, "our thanks, would", $ef, $ee, "you accept this?", $f7
    db $f0

String_99_4B35_00_2D::
    db $eb, "*: We are grateful", $f1
    db "that you recovered", $fa, $f7
    db $ef, $ee, "our daughter's", $ef, $ee, "ring.", $f7
    db $f0

String_99_4B35_00_2E::
    db $ea, "*: The old couple", $f1
    db "look happy after", $fa, $f7
    db $ef, $ee, "they got their", $ef, $ee, "treasure back.", $f7
    db $f0

String_99_4B35_00_2F::
    db $eb, "*: I'm so glad the", $f1
    db "people across the", $fa, $f7
    db $ef, $ee, "way got back their", $ef, $ee, "stolen treasure.", $f7
    db $f0

String_99_4B35_00_30::
    db $ea, "*: What do those", $f1
    db "monsters do with", $fa, $f7
    db $ef, $ee, "the things that", $ef, $ee, "they steal?", $fa, $f7
    db $ef, $ee, "If it were me, I", $44, $ef, $ee, "act as a fence and", $fa, $f7
    db $ef, $ee, "sell them on the", $ef, $ee, "sly for big money", $a4, $fa, $f7
    db $ef, $ee, "I'm only joking!", $ef, $ee, "Just a joke!", $f7
    db $f0

String_99_4B35_00_31::
    db $eb, "Milayou: I've been", $f1
    db "checking around,", $fa, $f7
    db $ef, $ee, "and I think the", $ef, $ee, "evidence is clear.", $fa, $f7
    db $ef, $ee, "Somebody is behind", $ef, $ee, "the monsters.", $fa, $f7
    db $ef, $ee, "It's the work of a", $ef, $ee, "dark master.", $fa, $f7
    db $ef, $ee, "I don't know who", $ef, $ee, "it is, though.", $fa, $f7
    db $ef, $ee, "Do you have any", $ef, $ee, "idea who?", $f7
    db $f0

String_99_4B35_00_32::
    db $ea, "*: I dug deep in my", $f1
    db "purse to buy from", $fa, $f7
    db $ef, $ee, "that dealer, but", $ef, $ee, "that ornament, it", $fa, $f7
    db $ef, $ee, "was the one stolen", $ef, $ee, "from my neighbor.", $fa, $f7
    db $ef, $ee, "What sort of", $ef, $ee, "nonsense is this?", $f7
    db $f0

String_99_4B35_00_33::
    db $ea, "*: The thieving", $f1
    db "monsters had a", $fa, $f7
    db $ef, $ee, "boss, didn't they?", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "He must be a sly", $ef, $ee, "scoundrel to let", $fa, $f7
    db $ef, $ee, "his underlings do", $ef, $ee, "his dirty deeds.", $f7
    db $f0

String_99_4B35_00_34::
    db $ea, "*: What? Where", $44, " I", $f1
    db "get my wares?", $fa, $f7
    db $ef, $ee, "Uh", $a4, " Erm", $a4, " Whoops!", $ef, $ee, "Look at the time!", $fa, $f7
    db $ef, $ee, "Out of the way,", $ef, $ee, "I'm late!", $f7
    db $f0

String_99_4B35_00_35::
    db $eb, "*: That greedhound", $f1
    db "dealer scuttled", $fa, $f7
    db $ef, $ee, "off in an awful", $ef, $ee, "hurry.", $f7
    db $f0

String_99_4B35_00_36::
    db $eb, "Milayou: I thought", $f1
    db "this forest looked", $fa, $f7
    db $ef, $ee, "suspicious, so I", $ef, $ee, "was investigating", $a4, $fa, $f7
    db $ef, $ee, "I was jumped from", $ef, $ee, "behind and my", $fa, $f7
    db $ef, $ee, "party was crushed", $ef, $ee, "just like that.", $fa, $f7
    db $ef, $ee, "A man, he looked", $ef, $ee, "like a dealer, was", $fa, $f7
    db $ef, $ee, "commanding the", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "He must have been", $ef, $ee, "the mastermind.", $fa, $f7
    db $ef, $ee, "The dark master", $ef, $ee, "went into the", $fa, $f7
    db $ef, $ee, "tower. Please go", $ef, $ee, "after him for me!", $f7
    db $f0

String_99_4B35_00_37::
    db $eb, "Milayou: Please", $f1
    db "defeat the dark", $fa, $f7
    db $ef, $ee, "master and bring", $ef, $ee, "him to justice!", $f7
    db $f0

String_99_4B35_00_38::
    db $f0

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_99_6366::
MessageStrings_Bank7C_Overflow::
    dw StringList_99_6368 ; id 0

; category list of StringCategories_99_6366; one pointer per wStringIndex (E-0217)
; record: string
StringList_99_6368::
    dw String_99_6366_00_00 ; id 0
    dw String_99_6366_00_01 ; id 1
    dw String_99_6366_00_02 ; id 2
    dw String_99_6366_00_03 ; id 3
    dw String_99_6366_00_04 ; id 4
    dw String_99_6366_00_05 ; id 5
    dw String_99_6366_00_06 ; id 6
    dw String_99_6366_00_07 ; id 7
    dw String_99_6366_00_08 ; id 8
    dw String_99_6366_00_09 ; id 9
    dw String_99_6366_00_0A ; id 10
    dw String_99_6366_00_0B ; id 11
    dw String_99_6366_00_0C ; id 12
    dw String_99_6366_00_0D ; id 13
    dw String_99_6366_00_0E ; id 14
    dw String_99_6366_00_0E ; id 15
    dw String_99_6366_00_0E ; id 16
    dw String_99_6366_00_0E ; id 17
    dw String_99_6366_00_0E ; id 18
    dw String_99_6366_00_0E ; id 19
    dw String_99_6366_00_0E ; id 20
    dw String_99_6366_00_0E ; id 21
    dw String_99_6366_00_0E ; id 22
    dw String_99_6366_00_0E ; id 23
    dw String_99_6366_00_0E ; id 24
    dw String_99_6366_00_0E ; id 25
    dw String_99_6366_00_1A ; id 26
    dw String_99_6366_00_1B ; id 27
    dw String_99_6366_00_1C ; id 28
    dw String_99_6366_00_1D ; id 29
    dw String_99_6366_00_1E ; id 30
    dw String_99_6366_00_1F ; id 31
    dw String_99_6366_00_20 ; id 32
    dw String_99_6366_00_21 ; id 33
    dw String_99_6366_00_22 ; id 34
    dw String_99_6366_00_23 ; id 35
    dw String_99_6366_00_24 ; id 36
    dw String_99_6366_00_24 ; id 37
    dw String_99_6366_00_26 ; id 38
    dw String_99_6366_00_27 ; id 39
    dw String_99_6366_00_28 ; id 40
    dw String_99_6366_00_29 ; id 41
    dw String_99_6366_00_2A ; id 42
    dw String_99_6366_00_2B ; id 43
    dw String_99_6366_00_2C ; id 44
    dw String_99_6366_00_2D ; id 45
    dw String_99_6366_00_2E ; id 46
    dw String_99_6366_00_2F ; id 47
    dw String_99_6366_00_30 ; id 48
    dw String_99_6366_00_31 ; id 49
    dw String_99_6366_00_32 ; id 50
    dw String_99_6366_00_33 ; id 51
    dw String_99_6366_00_34 ; id 52
    dw String_99_6366_00_35 ; id 53
    dw String_99_6366_00_36 ; id 54
    dw String_99_6366_00_37 ; id 55
    dw String_99_6366_00_38 ; id 56
    dw String_99_6366_00_39 ; id 57
    dw String_99_6366_00_3A ; id 58
    dw String_99_6366_00_3B ; id 59
    dw String_99_6366_00_3C ; id 60
    dw String_99_6366_00_3D ; id 61
    dw String_99_6366_00_3E ; id 62
    dw String_99_6366_00_3F ; id 63
    dw String_99_6366_00_3F ; id 64
    dw String_99_6366_00_41 ; id 65
    dw String_99_6366_00_42 ; id 66
    dw String_99_6366_00_43 ; id 67
    dw String_99_6366_00_44 ; id 68
    dw String_99_6366_00_45 ; id 69
    dw String_99_6366_00_46 ; id 70
    dw String_99_6366_00_47 ; id 71
    dw String_99_6366_00_48 ; id 72
    dw String_99_6366_00_49 ; id 73
    dw String_99_6366_00_4A ; id 74
    dw String_99_6366_00_4B ; id 75
    dw String_99_6366_00_4C ; id 76
    dw String_99_6366_00_4D ; id 77
    dw String_99_6366_00_4E ; id 78
    dw String_99_6366_00_4F ; id 79
    dw String_99_6366_00_50 ; id 80
    dw String_99_6366_00_51 ; id 81
    dw String_99_6366_00_52 ; id 82
    dw String_99_6366_00_53 ; id 83
    dw String_99_6366_00_53 ; id 84
    dw String_99_6366_00_53 ; id 85
    dw String_99_6366_00_53 ; id 86
    dw String_99_6366_00_53 ; id 87
    dw String_99_6366_00_53 ; id 88
    dw String_99_6366_00_53 ; id 89
    dw String_99_6366_00_53 ; id 90
    dw String_99_6366_00_53 ; id 91
    dw String_99_6366_00_53 ; id 92
    dw String_99_6366_00_53 ; id 93
    dw String_99_6366_00_53 ; id 94
    dw String_99_6366_00_53 ; id 95
    dw String_99_6366_00_53 ; id 96
    dw String_99_6366_00_53 ; id 97
    dw String_99_6366_00_53 ; id 98
    dw String_99_6366_00_63 ; id 99
    dw String_99_6366_00_63 ; id 100
    dw String_99_6366_00_63 ; id 101
    dw String_99_6366_00_63 ; id 102
    dw String_99_6366_00_63 ; id 103
    dw String_99_6366_00_63 ; id 104
    dw String_99_6366_00_63 ; id 105
    dw String_99_6366_00_63 ; id 106
    dw String_99_6366_00_63 ; id 107
    dw String_99_6366_00_63 ; id 108
    dw String_99_6366_00_63 ; id 109
    dw String_99_6366_00_63 ; id 110
    dw String_99_6366_00_63 ; id 111
    dw String_99_6366_00_63 ; id 112
    dw String_99_6366_00_63 ; id 113
    dw String_99_6366_00_63 ; id 114
    dw String_99_6366_00_63 ; id 115
    dw String_99_6366_00_63 ; id 116
    dw String_99_6366_00_63 ; id 117
    dw String_99_6366_00_63 ; id 118
    dw String_99_6366_00_63 ; id 119
    dw String_99_6366_00_63 ; id 120

String_99_6366_00_00::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained", $ef, $ee, "the MoonRock.", $f7
    db $f0

String_99_6366_00_01::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "There was the", $ef, $ee, "MoonRock inside.", $fa, $f7
    db $ef, $ee, "But there was no", $ef, $ee, "room for it.", $f7
    db $f0

String_99_6366_00_02::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "It smelled of", $ef, $ee, "grilled fish.", $f7
    db $f0

String_99_6366_00_03::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "merchandise.", $f7
    db $f0

String_99_6366_00_04::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Welcome to the", $ef, $ee, "Port of Polona!", $fa, $f7
    db $ef, $ee, "Frolic with", $ef, $ee, "mermaids", $a4, $95, $f7
    db $f0

String_99_6366_00_05::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "There were tourist", $ef, $ee, "pamphlets inside.", $fa, $f7
    db $ef, $ee, "'Infinitely clear", $ef, $ee, "blue waters and", $fa, $f7
    db $ef, $ee, "playful mermaids", $ef, $ee, "await you!", $95, $f7
    db $f0

String_99_6366_00_06::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "Two shiny pots", $ef, $ee, "were inside.", $f7
    db $f0

String_99_6366_00_07::
    db $eb, "*: This is the", $f1
    db "mermaid kingdom.", $fa, $f7
    db $ef, $ee, "Did you want to go", $ef, $ee, "home?", $ff, $f0

String_99_6366_00_08::
    db $eb, "*: Close your eyes", $f1
    db "for a little bit", $a4, $f7
    db $f0

String_99_6366_00_09::
    db $eb, "*: Oh. Tell me if", $f1
    db "you want to go.", $f7
    db $f0

String_99_6366_00_0A::
    db $ea, "Kameha: Aiyeeeeeh", $a4, $f1
    db $f7
    db $f0

String_99_6366_00_0B::
    db $ea, "*: ", $a4, "Your monsters", $f1
    db "appear dispirited", $a4, $fa, $f7
    db $ef, $ee, "It's unfortunate,", $ef, $ee, "but next time.", $f7
    db $f0

String_99_6366_00_0C::
    db "Thick, suction-", $f1
    db "cupped tentacles", $fa, $f7
    db $ef, $ee, "snaked out of the", $ef, $ee, "whirlpool!", $f7
    db $f0

String_99_6366_00_0D::
    db "The raging sea", $f1
    db "calmed, and the", $fa, $f7
    db $ef, $ee, "whirlpool smoothed", $ef, $ee, "to nothing.", $f7
    db $f0

String_99_6366_00_0E::
    db $eb, "*: Father put up a", $f1
    db "bridge across to", $fa, $f7
    db $ef, $ee, "that tiny island.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "We have more room", $ef, $ee, "for monsters now.", $f7
    db $f0

String_99_6366_00_1A::
    db $eb, "*: Oh? You'll run", $f1
    db "another errand?", $ff, $f0

String_99_6366_00_1B::
    db $eb, "*: My, what has", $f1
    db "gotten into you?", $fa, $f7
    db $ef, $ee, "Will miracles", $ef, $ee, "never cease?", $fa, $f7
    db $ef, $ee, "Could you go buy a", $ef, $ee, "Potion for me?", $fa, $f7
    db $ef, $ee, "Father's run down", $ef, $ee, "from overwork.", $f7
    db $f0

String_99_6366_00_1C::
    db "Mama handed over", $f1
    db "400G.", $f7
    db $f0

String_99_6366_00_1D::
    db $eb, "*: No miracles", $f1
    db "today! Oh, well.", $fa, $f7
    db $ef, $ee, "Of course, off you", $ef, $ee, "go and play!", $f7
    db $f0

String_99_6366_00_1E::
    db $eb, "*: I need you to", $f1
    db "get me a Potion.", $f7
    db $f0

String_99_6366_00_1F::
    db $eb, "*: Oh", $a4, " You've found", $f1
    db "what I wanted.", $fa, $f7
    db $ef, $ee, "I knew I could", $ef, $ee, "count on you!", $f7
    db $f0

String_99_6366_00_20::
    db $f9, "0 handed over", $f1
    db "the Potion.", $f7
    db $f0

String_99_6366_00_21::
    db $eb, "*: Well, could you", $f1
    db "go buy a Rib?", $fa, $f7
    db $ef, $ee, "It'll be a change", $ef, $ee, "from fish.", $f7
    db $f0

String_99_6366_00_22::
    db "Mama handed over", $f1
    db "600G.", $f7
    db $f0

String_99_6366_00_23::
    db $eb, "*: I want you to", $f1
    db "buy me a Rib.", $f7
    db $f0

String_99_6366_00_24::
    db $f9, "0 handed over", $f1
    db "the Rib.", $f7
    db $f0

String_99_6366_00_26::
    db $eb, "*: Thanks, ", $f9, "0!", $f1
    db "You're great help!", $f7
    db $f0

String_99_6366_00_27::
    db $ea, "*: My father was a", $f1
    db "Slime and Mama was", $fa, $f7
    db $ef, $ee, "a MiniDrak, and", $ef, $ee, "I'm neither.", $fa, $f7
    db $ef, $ee, "When the parents", $ef, $ee, "are different, the", $fa, $f7
    db $ef, $ee, "offspring are", $ef, $ee, "different too.", $f7
    db $f0

String_99_6366_00_28::
    db $ea, "*: Beavern helped", $f1
    db "put up the bridge.", $fa, $f7
    db $ef, $ee, "It's a solid piece", $ef, $ee, "of work, this!", $fa, $f7
    db $ef, $ee, "An underground", $ef, $ee, "stable is next,", $fa, $f7
    db $ef, $ee, "or at least if I", $ef, $ee, "can get help.", $fa, $f7
    db $ef, $ee, "Have you seen any", $ef, $ee, "MadGophers?", $ff, $f0

String_99_6366_00_29::
    db $ea, "*: I", $44, " like to get", $f1
    db "help for digging.", $fa, $f7
    db $ef, $ee, "Could you befriend", $ef, $ee, "a MadGopher?", $f7
    db $f0

String_99_6366_00_2A::
    db $ea, "*: If one joins", $f1
    db "you, could you", $fa, $f7
    db $ef, $ee, "bring it home to", $ef, $ee, "meet me?", $f7
    db $f0

String_99_6366_00_2B::
    db $ea, "*: A MadGopher", $f1
    db "joined you?", $fa, $f7
    db $ef, $ee, "Could you pass it", $ef, $ee, "over to me?", $fa, $f7
    db $ef, $ee, $a4, "But that will", $ef, $ee, "leave you alone", $a4, $f7
    db $f0

String_99_6366_00_2C::
    db $ea, "*: A MadGopher", $f1
    db "joined you?", $fa, $f7
    db $ef, $ee, "Could you pass it", $ef, $ee, "over to me?", $ff, $f0

String_99_6366_00_2D::
    db $ea, "*: Great, ", $f9, "0!", $f1
    db "Thanks a lot!", $fa, $f7
    db $ef, $ee, "This will make the", $ef, $ee, "farm more useful!", $f7
    db $f0

String_99_6366_00_2E::
    db $ea, "*: ", $f9, "0, I need", $f1
    db "your help.", $fa, $f7
    db $ef, $ee, "Please get me a", $ef, $ee, "MadGopher.", $f7
    db $f0

String_99_6366_00_2F::
    db $ea, "*: MadGopher's been", $f1
    db "a great help.", $fa, $f7
    db $ef, $ee, "The excavation", $ef, $ee, "should go quickly.", $f7
    db $f0

String_99_6366_00_30::
    db $ea, "*: I've finished", $f1
    db "working.", $fa, $f7
    db $ef, $ee, "Can I go with you", $ef, $ee, "again?", $ff, $f0

String_99_6366_00_31::
    db $ea, "*: I'm counting on", $f1
    db "you!", $f7
    db $f0

String_99_6366_00_32::
    db $ea, "*: ", $a4, "But you have no", $f1
    db "room for me", $a4, $f7
    db $f0

String_99_6366_00_33::
    db $ea, "*: Tch, I thought I", $f1
    db "could help you", $a4, $f7
    db $f0

String_99_6366_00_34::
    db $ea, "*: You have to tamp", $f1
    db "the ground firmly", $fa, $f7
    db $ef, $ee, "around where you", $ef, $ee, "do your digging.", $f7
    db $f0

String_99_6366_00_35::
    db $ea, "Cobi: ", $f9, "0, what", $f1
    db "was it like in the", $fa, $f7
    db $ef, $ee, "other worlds?", $ef, $ee, "I", $44, " like to know.", $fa, $f7
    db $ef, $ee, $a4, "Oh", $a4, " Kameha's out", $ef, $ee, "there too.", $fa, $f7
    db $ef, $ee, "No wonder he hasn't", $ef, $ee, "been around.", $fa, $f7
    db $ef, $ee, "There's a bridge", $ef, $ee, "over to the next", $fa, $f7
    db $ef, $ee, "island, so the", $ef, $ee, "farm grew a bit", $fa, $f7
    db $ef, $ee, "bigger.", $ef, $ee, "So, what can I do", $fa, $f7
    db $ef, $ee, "for you, sis?", $ef, $ee, $f7
    db $f0

String_99_6366_00_36::
    db $eb, "Tara: Big brother,", $f1
    db "tell me about your", $fa, $f7
    db $ef, $ee, "adventures in", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, $a4, "Oh", $a4, " The Prince is", $ef, $ee, "searching too.", $fa, $f7
    db $ef, $ee, "Papa put a bridge", $ef, $ee, "over to that tiny", $fa, $f7
    db $ef, $ee, "island, so the", $ef, $ee, "farm is bigger.", $fa, $f7
    db $ef, $ee, "You can leave more", $ef, $ee, "monsters now.", $fa, $f7
    db $ef, $ee, "Do you need me for", $ef, $ee, "anything?", $f7
    db $f0

String_99_6366_00_37::
    db $ea, "*: Including the", $f1
    db "monsters with you,", $fa, $f7
    db $ef, $ee, "the farm can hold", $ef, $ee, "up to 30 now.", $fa, $f7
    db $ef, $ee, "Expansion added to", $ef, $ee, "capacity.", $fa, $f7
    db $ef, $ee, "Monsters in the", $ef, $ee, "farm earn some", $fa, $f7
    db $ef, $ee, "EX points as you", $ef, $ee, "battle.", $fa, $f7
    db $ef, $ee, "But if you leave", $ef, $ee, "them in the farm,", $fa, $f7
    db $ef, $ee, "they will grow", $ef, $ee, "without learning", $fa, $f7
    db $ef, $ee, "skills, and they", $ef, $ee, "turn disobedient.", $fa, $f7
    db $ef, $ee, "So, you should", $ef, $ee, "take different", $fa, $f7
    db $ef, $ee, "monsters out for", $ef, $ee, "training.", $f7
    db $f0

String_99_6366_00_38::
    db $ea, "*: Master only", $f1
    db "makes me charge.", $fa, $f7
    db $ef, $ee, "It made me more", $ef, $ee, "courageous!", $f7
    db $f0

String_99_6366_00_39::
    db $ea, "*: We get more and", $f1
    db "more stubborn as", $fa, $f7
    db $ef, $ee, "we grow to higher", $ef, $ee, "levels.", $fa, $f7
    db $ef, $ee, "Our personalities", $ef, $ee, "don't change much,", $fa, $f7
    db $ef, $ee, "once we get old.", $ef, $ee, "Fwohohoho!", $f7
    db $f0

String_99_6366_00_3A::
    db $ea, "*: Hey! You're the", $f1
    db "kid who said the", $fa, $f7
    db $ef, $ee, "island was going", $ef, $ee, "to sink!", $fa, $f7
    db $ef, $ee, "I believed you and", $ef, $ee, "sailed off, but", $fa, $f7
    db $ef, $ee, "the island's still", $ef, $ee, "here!", $fa, $f7
    db $ef, $ee, "You rotten little", $ef, $ee, "lie master!", $f7
    db $f0

String_99_6366_00_3B::
    db $ea, "*: I have nothing", $f1
    db "for a liar!", $f7
    db $f0

String_99_6366_00_3C::
    db $eb, "*: To take off an", $f1
    db "accessory, just", $fa, $f7
    db $ef, $ee, "put a different", $ef, $ee, "accessory on.", $fa, $f7
    db $ef, $ee, "Try equipping a", $ef, $ee, "D-Scale, that will", $fa, $f7
    db $ef, $ee, "remove whatever is", $ef, $ee, "equipped.", $fa, $f7
    db $ef, $ee, "It's common", $ef, $ee, "knowledge!", $f7
    db $f0

String_99_6366_00_3D::
    db $eb, "*: The woman next", $f1
    db "to me, she repeats", $fa, $f7
    db $ef, $ee, "whatever she hears", $ef, $ee, "from other people", $fa, $f7
    db $ef, $ee, "and acts smart.", $ef, $ee, "What a Copycat", $a4, $f7
    db $f0

String_99_6366_00_3E::
    db $ea, "*: I want to open", $f1
    db "up a shop here,", $fa, $f7
    db $ef, $ee, "but I need help", $ef, $ee, "unloading my ship.", $fa, $f7
    db $ef, $ee, "I heard an ArmyAnt", $ef, $ee, "can carry things", $fa, $f7
    db $ef, $ee, "much bigger than", $ef, $ee, "itself.", $fa, $f7
    db $ef, $ee, "Yep, an ArmyAnt", $ef, $ee, "would be helpful", $a4, $f7
    db $f0

String_99_6366_00_3F::
    db $ea, "*: Wait! Could I", $f1
    db "get you to leave", $fa, $f7
    db $ef, $ee, "your Army Ant with", $ef, $ee, "me?", $fa, $f7
    db $ef, $ee, "Oh", $a4, " But that would", $ef, $ee, "leave you alone", $a4, $f7
    db $f0

String_99_6366_00_41::
    db $ea, "*: Wait! Could I", $f1
    db "get you to leave", $fa, $f7
    db $ef, $ee, "your Army Ant with", $ef, $ee, "me?", $ff, $f0

String_99_6366_00_42::
    db $ea, "*: Fantastic! I can", $f1
    db "open my shop now!", $f7
    db $f0

String_99_6366_00_43::
    db $ea, "*: Oh", $a4, " That's very", $f1
    db "disappointing.", $fa, $f7
    db $ef, $ee, "I could have my", $ef, $ee, "shop quickly too", $a4, $f7
    db $f0

String_99_6366_00_44::
    db $ea, "*: ArmyAnt helped", $f1
    db "me get my shop up.", $fa, $f7
    db $ef, $ee, "Would you care to", $ef, $ee, "see my wares?", $f7
    db $f0

String_99_6366_00_45::
    db $ea, "*: Welcome! How may", $f1
    db "I serve you?", $f7
    db $f0

String_99_6366_00_46::
    db $f9, "0 checked the", $f1
    db "door.", $fa, $f7
    db $ef, $ee, "The door won't open", $ef, $ee, "with any key.", $f7
    db $f0

String_99_6366_00_47::
    db $ea, "*: Many trees have", $f1
    db "submerged", $a4, $fa, $f7
    db $ef, $ee, "The island seems", $ef, $ee, "to be undergoing", $fa, $f7
    db $ef, $ee, "an unwelcome", $ef, $ee, "change", $a4, $f7
    db $f0

String_99_6366_00_48::
    db $eb, "*: Um", $a4, " I'm the Egg", $f1
    db "Evaluator.", $fa, $f7
    db $ef, $ee, "You don't know who", $ef, $ee, "I am", $a4, " Right?", $fa, $f7
    db $ef, $ee, "Um", $a4, " All monsters", $ef, $ee, "hatch from eggs.", $fa, $f7
    db $ef, $ee, "I check your eggs", $ef, $ee, "to determine the", $fa, $f7
    db $ef, $ee, "gender of the", $ef, $ee, "monster inside.", $fa, $f7
    db $ef, $ee, "I can also sing a", $ef, $ee, "song to change the", $fa, $f7
    db $ef, $ee, "gender of the", $ef, $ee, "monster in an egg.", $fa, $f7
    db $ef, $ee, "May I help you in", $ef, $ee, "any way today?", $f7
    db $f0

String_99_6366_00_49::
    db $eb, "*: I'm the Egg", $f1
    db "Evaluator.", $fa, $f7
    db $ef, $ee, "May I help you in", $ef, $ee, "any way today?", $f7
    db $f0

String_99_6366_00_4A::
    db $ea, "*: The Evaluator", $f1
    db "said I had an", $fa, $f7
    db $ef, $ee, "amazing egg.", $ef, $ee, "But I stumbled on", $fa, $f7
    db $ef, $ee, "the stairs and", $ef, $ee, "almost broke it.", $f7
    db $f0

String_99_6366_00_4B::
    db $eb, "*: Go down these", $f1
    db "stairs to the", $fa, $f7
    db $ef, $ee, "Starry Shrine.", $ef, $ee, $f7
    db $f0

String_99_6366_00_4C::
    db $ea, "*: Welcome to the", $f1
    db "Starry Shrine.", $fa, $f7
    db $ef, $ee, "I'm Professor", $ef, $ee, "Monster.", $fa, $f7
    db $ef, $ee, "I have the run of", $ef, $ee, "the place while I", $fa, $f7
    db $ef, $ee, "study monsters and", $ef, $ee, "their breeding.", $fa, $f7
    db $ef, $ee, "I can help you", $ef, $ee, "breed monsters", $fa, $f7
    db $ef, $ee, "and hatch the eggs", $ef, $ee, "that result.", $fa, $f7
    db $ef, $ee, "So, what do you", $ef, $ee, "need of me today?", $f7
    db $f0

String_99_6366_00_4D::
    db $ea, "*: Welcome to the", $f1
    db "Starry Shrine.", $fa, $f7
    db $ef, $ee, "What do you need", $ef, $ee, "of me today?", $f7
    db $f0

String_99_6366_00_4E::
    db $ea, "*: I'm the Prof's", $f1
    db "assistant.", $fa, $f7
    db $ef, $ee, "Do you want to", $ef, $ee, "hear about the", $fa, $f7
    db $ef, $ee, "Starry Shrine?", $ef, $ee, $ff, $f0

String_99_6366_00_4F::
    db $ea, "*: You can breed", $f1
    db "monsters and hatch", $fa, $f7
    db $ef, $ee, "their eggs here at", $ef, $ee, "the Starry Shrine.", $fa, $f7
    db $ef, $ee, "Breeding happens", $ef, $ee, "when two monsters", $fa, $f7
    db $ef, $ee, "get married to", $ef, $ee, "each other.", $fa, $f7
    db $ef, $ee, "Their egg contains", $ef, $ee, "a monster that", $fa, $f7
    db $ef, $ee, "has the abilities", $ef, $ee, "of the parents.", $fa, $f7
    db $ef, $ee, "We can hatch that", $ef, $ee, "egg for you too.", $fa, $f7
    db $ef, $ee, "The parents will", $ef, $ee, "go away somewhere,", $fa, $f7
    db $ef, $ee, "but you won't lose", $ef, $ee, "accessories.", $fa, $f7
    db $ef, $ee, "Those get sent to", $ef, $ee, "the Vault.", $f7
    db $f0

String_99_6366_00_50::
    db $ea, "*: Talk to the Prof", $f1
    db "if you need help.", $f7
    db $f0

String_99_6366_00_51::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Breeding Guide", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "In breeding, the", $ef, $ee, "monster chosen as", $fa, $f7
    db $ef, $ee, "the base sets the", $ef, $ee, "baby's family.", $fa, $f7
    db $ef, $ee, "If a Slime family", $ef, $ee, "monster is chosen", $fa, $f7
    db $ef, $ee, "as the base, the", $ef, $ee, "baby will also be", $fa, $f7
    db $ef, $ee, "of the Slime", $ef, $ee, "family.", $fa, $f7
    db $ef, $ee, "And if a Dragon", $ef, $ee, "family monster is", $fa, $f7
    db $ef, $ee, "the base monster,", $ef, $ee, "the baby will also", $fa, $f7
    db $ef, $ee, "be of the Dragon", $ef, $ee, "family.", $95, $f7
    db $f0

String_99_6366_00_52::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Breeding Guide", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "In breeding, the", $ef, $ee, "families and the", $fa, $f7
    db $ef, $ee, "species of the", $ef, $ee, "parents determine", $fa, $f7
    db $ef, $ee, "the species of the", $ef, $ee, "baby.", $fa, $f7
    db $ef, $ee, "Changing the mix", $ef, $ee, "of families and", $fa, $f7
    db $ef, $ee, "species results in", $ef, $ee, "different babies.", $95, $f7
    db $f0

String_99_6366_00_53::
    db $ea

String_99_6366_00_63::
    db $f0
    ds $112, $00
