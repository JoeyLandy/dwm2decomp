SECTION "Bank 97", ROMX[$4000], BANK[$97]
    db $97

BeginStringDisplay_Bank28_BeginStringDisplay::
    ld de, MessageStrings_Bank28_Overflow
    ld a, [wStringIndex]
    sub $da
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $28: wStringIndex -= $DA, then CopyStringToBuffer with the table
; MessageStrings_Bank28_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank28_Overflow::
    ld de, MessageStrings_Bank28_Overflow
    ld a, [wStringIndex]
    sub $da
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; overflow for message bank $29: wStringIndex -= $8E, then BeginStringDisplay with the table
; MessageStrings_Bank29_Overflow in this bank (E-0080)
BeginStringDisplay_Bank29_Overflow::
    ld de, MessageStrings_Bank29_Overflow
    ld a, [wStringIndex]
    sub $8e
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $29: wStringIndex -= $8E, then CopyStringToBuffer with the table
; MessageStrings_Bank29_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank29_Overflow::
    ld de, MessageStrings_Bank29_Overflow
    ld a, [wStringIndex]
    sub $8e
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $26, $40, $cd, $11, $26, $c9

; overflow for message bank $2A: wStringIndex -= $95, then BeginStringDisplay with the table
; MessageStrings_Bank2A_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2A_Overflow::
    ld de, MessageStrings_Bank2A_Overflow
    ld a, [wStringIndex]
    sub $95
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2A: wStringIndex -= $95, then CopyStringToBuffer with the table
; MessageStrings_Bank2A_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2A_Overflow::
    ld de, MessageStrings_Bank2A_Overflow
    ld a, [wStringIndex]
    sub $95
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $4b, $40, $cd, $11, $26, $c9

; overflow for message bank $83: wStringIndex -= $C7, then BeginStringDisplay with the table
; MessageStrings_Bank83_Overflow in this bank (E-0080)
BeginStringDisplay_Bank83_Overflow::
    ld de, MessageStrings_Bank83_Overflow
    ld a, [wStringIndex]
    sub $c7
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $83: wStringIndex -= $C7, then CopyStringToBuffer with the table
; MessageStrings_Bank83_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank83_Overflow::
    ld de, MessageStrings_Bank83_Overflow
    ld a, [wStringIndex]
    sub $c7
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $70, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_97_4095::
MessageStrings_Bank28_Overflow::
    dw StringList_97_4097 ; id 0

; category list of StringCategories_97_4095; one pointer per wStringIndex (E-0217)
; record: string
StringList_97_4097::
    dw String_97_4095_00_00 ; id 0
    dw String_97_4095_00_01 ; id 1
    dw String_97_4095_00_02 ; id 2
    dw String_97_4095_00_03 ; id 3
    dw String_97_4095_00_04 ; id 4
    dw String_97_4095_00_05 ; id 5
    dw String_97_4095_00_06 ; id 6
    dw String_97_4095_00_07 ; id 7
    dw String_97_4095_00_08 ; id 8
    dw String_97_4095_00_09 ; id 9
    dw String_97_4095_00_0A ; id 10
    dw String_97_4095_00_0B ; id 11
    dw String_97_4095_00_0C ; id 12
    dw String_97_4095_00_0D ; id 13
    dw String_97_4095_00_0E ; id 14
    dw String_97_4095_00_0F ; id 15
    dw String_97_4095_00_10 ; id 16
    dw String_97_4095_00_11 ; id 17
    dw String_97_4095_00_12 ; id 18
    dw String_97_4095_00_13 ; id 19
    dw String_97_4095_00_14 ; id 20
    dw String_97_4095_00_15 ; id 21
    dw String_97_4095_00_16 ; id 22
    dw String_97_4095_00_16 ; id 23
    dw String_97_4095_00_16 ; id 24
    dw String_97_4095_00_16 ; id 25
    dw String_97_4095_00_1A ; id 26
    dw String_97_4095_00_1B ; id 27
    dw String_97_4095_00_1C ; id 28
    dw String_97_4095_00_1C ; id 29
    dw String_97_4095_00_1C ; id 30
    dw String_97_4095_00_1C ; id 31
    dw String_97_4095_00_1C ; id 32
    dw String_97_4095_00_21 ; id 33
    dw String_97_4095_00_22 ; id 34
    dw String_97_4095_00_23 ; id 35
    dw String_97_4095_00_24 ; id 36
    dw String_97_4095_00_25 ; id 37

String_97_4095_00_00::
    db $ea, "*: You have raised", $f1
    db "your charges well.", $fa, $f7
    db $ef, $ee, "Test them against", $ef, $ee, "me!", $f7
    db $f0

String_97_4095_00_01::
    db $ea, "*: What? How did", $f1
    db "you get here?", $fa, $f7
    db $ef, $ee, "Arrgh, don't meddle", $ef, $ee, "in my affairs!", $f7
    db $f0

String_97_4095_00_02::
    db $ea, "*: All those who", $f1
    db "stood before me", $fa, $f7
    db $ef, $ee, "I shattered with", $ef, $ee, "these hands!", $f7
    db $f0

String_97_4095_00_03::
    db $ea, "*: Let me show you", $f1
    db "why your monsters", $fa, $f7
    db $ef, $ee, "can't stop shaking!", $ef, $ee, $f7
    db $f0

String_97_4095_00_04::
    db $ea, "*: We can connect", $f1
    db "only in battle.", $fa, $f7
    db $ef, $ee, "Get ready!", $ef, $ee, $f7
    db $f0

String_97_4095_00_05::
    db $ea, "*: Power is the", $f1
    db "basis of all!", $fa, $f7
    db $ef, $ee, "Your words are", $ef, $ee, "meaningless!", $f7
    db $f0

String_97_4095_00_06::
    db $ea, "*: If you wish to", $f1
    db "pass, you'll have", $fa, $f7
    db $ef, $ee, "to beat me. There's", $ef, $ee, "no other way!", $f7
    db $f0

String_97_4095_00_07::
    db $ea, "*: You're going to", $f1
    db "beat the boss?", $fa, $f7
    db $ef, $ee, "You have me to", $ef, $ee, "deal with first!", $f7
    db $f0

String_97_4095_00_08::
    db $ea, "*: Courage alone", $f1
    db "won't let you win!", $f7
    db $f0

String_97_4095_00_09::
    db $ea, "*: So long as I", $f1
    db "stand, no one, but", $fa, $f7
    db $ef, $ee, "no one gets by", $ef, $ee, "here!", $f7
    db $f0

String_97_4095_00_0A::
    db $ea, "*: Oh? There still", $f1
    db "was someone with", $fa, $f7
    db $ef, $ee, "a little spine?", $ef, $ee, "Fwahahaha!", $f7
    db $f0

String_97_4095_00_0B::
    db $ea, "*: What? I'm busy!", $f1
    db "Make it quick!", $f7
    db $f0

String_97_4095_00_0C::
    db $ea, "*: Curse your luck", $f1
    db "for coming here!", $f7
    db $f0

String_97_4095_00_0D::
    db $ea, "*: You think I", $f1
    db "look weak! Don't", $fa, $f7
    db $ef, $ee, "you deny it!", $ef, $ee, "I can tell!", $f7
    db $f0

String_97_4095_00_0E::
    db $ea, "*: Just how much", $f1
    db "are you willing to", $fa, $f7
    db $ef, $ee, "sacrifice before", $ef, $ee, "you give up?", $f7
    db $f0

String_97_4095_00_0F::
    db $ea, "*: Hyahyahya!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "Another weakling", $ef, $ee, "come to amuse me!", $f7
    db $f0

String_97_4095_00_10::
    db $ea, "*: Too late for", $f1
    db "regrets now.", $fa, $f7
    db $ef, $ee, "I'll show you my", $ef, $ee, "true strength!", $f7
    db $f0

String_97_4095_00_11::
    db $ea, "*: Try to keep me", $f1
    db "amused at least.", $f7
    db $f0

String_97_4095_00_12::
    db $ea, "*: Hah! You're too", $f1
    db "weak to take me!", $f7
    db $f0

String_97_4095_00_13::
    db $ea, "*: The boss is", $f1
    db "beyond here.", $fa, $f7
    db $ef, $ee, "I can't let the", $ef, $ee, "likes of you pass.", $f7
    db $f0

String_97_4095_00_14::
    db $ea, "*: I've still got", $f1
    db "enough power to", $fa, $f7
    db $ef, $ee, "brush off a green", $ef, $ee, "master like you!", $f7
    db $f0

String_97_4095_00_15::
    db $ea, "*: Fufufu", $a4, " There is", $f1
    db "only winning or", $fa, $f7
    db $ef, $ee, "losing in battle,", $ef, $ee, "and nothing else.", $f7
    db $f0

String_97_4095_00_16::
    db "Get a tenth off", $f1
    db "the shop prices.", $f0

String_97_4095_00_1A::
    db "Use to create a", $f1
    db "door shrine.", $f0

String_97_4095_00_1B::
    db "It is an item with", $f1
    db "a magical power.", $f0

String_97_4095_00_1C::
    db $ea, "*: Hello! What can", $f1
    db "I do for you?", $f7
    db $f0

String_97_4095_00_21::
    db "THE END", $a4, $f0

String_97_4095_00_22::
    db $eb, "*: You have to eat", $f1
    db "your vegetables!", $fa, $f7
    db $ef, $ee, $f9, "0 was force-", $ef, $ee, "fed an INT Seed!", $f7
    db $f0

String_97_4095_00_23::
    db $ea, "*: Hey, that's mine!", $f1
    db $fa, $f7
    db $ef, $ee, $f9, "0 obtained a", $ef, $ee, "TinyMedal.", $f7
    db $f0

String_97_4095_00_24::
    db $ea, "Terry: Here, just", $f1
    db "take this.", $fa, $f7
    db $ef, $ee, $f9, "0 received", $ef, $ee, "10,000G!", $f7
    db $f0

String_97_4095_00_25::
    db $9f, $9f, $9f, " Composing ", $9f, $9f, $9f, $f7
    db $f0

StringCategories_97_474A::
MessageStrings_Bank29_Overflow::
    dw StringList_97_474C ; id 0

; category list of StringCategories_97_474A; one pointer per wStringIndex (E-0217)
StringList_97_474C::
    dw String_97_474A_00_00 ; id 0
    dw String_97_474A_00_01 ; id 1
    dw String_97_474A_00_02 ; id 2
    dw String_97_474A_00_03 ; id 3
    dw String_97_474A_00_04 ; id 4
    dw String_97_474A_00_05 ; id 5
    dw String_97_474A_00_06 ; id 6
    dw String_97_474A_00_07 ; id 7
    dw String_97_474A_00_08 ; id 8
    dw String_97_474A_00_09 ; id 9
    dw String_97_474A_00_0A ; id 10
    dw String_97_474A_00_0B ; id 11
    dw String_97_474A_00_0C ; id 12
    dw String_97_474A_00_0D ; id 13
    dw String_97_474A_00_0E ; id 14
    dw String_97_474A_00_0F ; id 15
    dw String_97_474A_00_10 ; id 16
    dw String_97_474A_00_11 ; id 17
    dw String_97_474A_00_12 ; id 18
    dw String_97_474A_00_13 ; id 19
    dw String_97_474A_00_14 ; id 20
    dw String_97_474A_00_15 ; id 21
    dw String_97_474A_00_16 ; id 22
    dw String_97_474A_00_17 ; id 23
    dw String_97_474A_00_18 ; id 24
    dw String_97_474A_00_19 ; id 25
    dw String_97_474A_00_1A ; id 26
    dw String_97_474A_00_1B ; id 27
    dw String_97_474A_00_1C ; id 28
    dw String_97_474A_00_1D ; id 29
    dw String_97_474A_00_1E ; id 30
    dw String_97_474A_00_1F ; id 31
    dw String_97_474A_00_20 ; id 32
    dw String_97_474A_00_21 ; id 33
    dw String_97_474A_00_22 ; id 34
    dw String_97_474A_00_23 ; id 35
    dw String_97_474A_00_24 ; id 36
    dw String_97_474A_00_25 ; id 37
    dw String_97_474A_00_26 ; id 38
    dw String_97_474A_00_27 ; id 39
    dw String_97_474A_00_28 ; id 40
    dw String_97_474A_00_29 ; id 41
    dw String_97_474A_00_2A ; id 42
    dw String_97_474A_00_2B ; id 43
    dw String_97_474A_00_2C ; id 44
    dw String_97_474A_00_2D ; id 45
    dw String_97_474A_00_2E ; id 46
    dw String_97_474A_00_2F ; id 47
    dw String_97_474A_00_30 ; id 48
    dw String_97_474A_00_31 ; id 49
    dw String_97_474A_00_32 ; id 50
    dw String_97_474A_00_33 ; id 51
    dw String_97_474A_00_33 ; id 52
    dw String_97_474A_00_33 ; id 53
    dw String_97_474A_00_33 ; id 54
    dw String_97_474A_00_33 ; id 55
    dw String_97_474A_00_33 ; id 56
    dw String_97_474A_00_33 ; id 57
    dw String_97_474A_00_33 ; id 58
    dw String_97_474A_00_33 ; id 59
    dw String_97_474A_00_33 ; id 60
    dw String_97_474A_00_33 ; id 61
    dw String_97_474A_00_33 ; id 62
    dw String_97_474A_00_33 ; id 63
    dw String_97_474A_00_33 ; id 64
    dw String_97_474A_00_33 ; id 65
    dw String_97_474A_00_33 ; id 66
    dw String_97_474A_00_43 ; id 67
    dw String_97_474A_00_44 ; id 68
    dw String_97_474A_00_45 ; id 69
    dw String_97_474A_00_46 ; id 70
    dw String_97_474A_00_47 ; id 71
    dw String_97_474A_00_47 ; id 72
    dw String_97_474A_00_47 ; id 73
    dw String_97_474A_00_47 ; id 74
    dw String_97_474A_00_47 ; id 75
    dw String_97_474A_00_47 ; id 76
    dw String_97_474A_00_47 ; id 77
    dw String_97_474A_00_47 ; id 78
    dw String_97_474A_00_47 ; id 79
    dw String_97_474A_00_47 ; id 80
    dw String_97_474A_00_47 ; id 81
    dw String_97_474A_00_47 ; id 82
    dw String_97_474A_00_47 ; id 83
    dw String_97_474A_00_47 ; id 84
    dw String_97_474A_00_47 ; id 85
    dw String_97_474A_00_47 ; id 86
    dw String_97_474A_00_47 ; id 87
    dw String_97_474A_00_47 ; id 88
    dw String_97_474A_00_47 ; id 89
    dw String_97_474A_00_47 ; id 90
    dw String_97_474A_00_47 ; id 91
    dw String_97_474A_00_47 ; id 92
    dw String_97_474A_00_47 ; id 93
    dw String_97_474A_00_47 ; id 94
    dw String_97_474A_00_47 ; id 95
    dw String_97_474A_00_47 ; id 96
    dw String_97_474A_00_47 ; id 97
    dw String_97_474A_00_47 ; id 98
    dw String_97_474A_00_47 ; id 99
    dw String_97_474A_00_47 ; id 100
    dw String_97_474A_00_47 ; id 101
    dw String_97_474A_00_47 ; id 102
    dw String_97_474A_00_47 ; id 103
    dw String_97_474A_00_47 ; id 104
    dw String_97_474A_00_47 ; id 105
    dw String_97_474A_00_47 ; id 106
    dw String_97_474A_00_47 ; id 107
    dw String_97_474A_00_47 ; id 108
    dw String_97_474A_00_47 ; id 109
    dw String_97_474A_00_47 ; id 110
    dw String_97_474A_00_47 ; id 111
    dw String_97_474A_00_47 ; id 112
    dw String_97_474A_00_47 ; id 113

String_97_474A_00_00::
    db $ea, "*: Don't chase what", $f1
    db "runs from you.", $fa, $f7
    db $ef, $ee, "Lay some bait, and", $ef, $ee, "let it come.", $fa, $f7
    db $ef, $ee, "That's the trick.", $ef, $ee, "Don't understand?", $fa, $f7
    db $ef, $ee, "The oasis is east", $ef, $ee, "of here, beyond", $fa, $f7
    db $ef, $ee, "a range of craggy", $ef, $ee, "mountains.", $fa, $f7
    db $ef, $ee, "Head for it, and", $ef, $ee, "you'll see.", $f7
    db $f0

String_97_474A_00_01::
    db $ea, "*: We didn't help", $f1
    db "the thieves!", $fa, $f7
    db $ef, $ee, "One of their men", $ef, $ee, "had joined the", $fa, $f7
    db $ef, $ee, "circus and used", $ef, $ee, "us as a cover.", $fa, $f7
    db $ef, $ee, "We had no idea.", $ef, $ee, "Please, we should", $fa, $f7
    db $ef, $ee, "be released!", $ef, $ee, $f7
    db $f0

String_97_474A_00_02::
    db $ea, "King: The lake was", $f1
    db "in sight, but once", $fa, $f7
    db $ef, $ee, "we get this close,", $ef, $ee, "it isn't there!", $fa, $f7
    db $ef, $ee, "We'll never be", $ef, $ee, "able to find the", $fa, $f7
    db $ef, $ee, "hideout of the", $ef, $ee, "thieves this way!", $f7
    db $f0

String_97_474A_00_03::
    db $ea, "*: We can see the", $f1
    db "hideout plainly,", $fa, $f7
    db $ef, $ee, "but where did the", $ef, $ee, "lake disappear to?", $f7
    db $f0

String_97_474A_00_04::
    db $ea, "*: The prisoner in", $f1
    db "the dungeon said", $fa, $f7
    db $ef, $ee, "that he saw the", $ef, $ee, "mirage lake.", $fa, $f7
    db $ef, $ee, "I wonder if he was", $ef, $ee, "being truthful", $a4, $f7
    db $f0

String_97_474A_00_05::
    db $ea, "*: How can we reach", $f1
    db "the hideout?", $f7
    db $f0

String_97_474A_00_06::
    db $eb, "*: Thieves drove us", $f1
    db "from our homes!", $f7
    db $f0

String_97_474A_00_07::
    db $ea, "*: The leader of", $f1
    db "the thieves is a", $fa, $f7
    db $ef, $ee, "terrible man!", $ef, $ee, "He uses monsters!", $f7
    db $f0

String_97_474A_00_08::
    db $ea, "*: Heh, you have", $f1
    db "monsters in tow?", $fa, $f7
    db $ef, $ee, "You're not from", $ef, $ee, "this world.", $fa, $f7
    db $ef, $ee, "I've come from the", $ef, $ee, "same world as you.", $fa, $f7
    db $ef, $ee, "I've been wandering", $ef, $ee, "through the other", $fa, $f7
    db $ef, $ee, "worlds seeking the", $ef, $ee, "ultimate monster.", $fa, $f7
    db $ef, $ee, "I was promised a", $ef, $ee, "strong monster by", $fa, $f7
    db $ef, $ee, "the Demon Lord of", $ef, $ee, "Limbo in exchange", $fa, $f7
    db $ef, $ee, "for this world's", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "Come forth, my", $ef, $ee, "pretty!", $fa, $f7
    db $ef, $ee, "Show them their", $ef, $ee, "place!", $f7
    db $f0

String_97_474A_00_09::
    db $ea, "*: You again!", $f1
    db "You're determined!", $fa, $f7
    db $ef, $ee, "But it won't make", $ef, $ee, "a difference!", $f7
    db $f0

String_97_474A_00_0A::
    db $ea, "*: You defeated my", $f1
    db "monster?", $fa, $f7
    db $ef, $ee, "Urggh", $a4, $ef, $ee, "Time to regroup!", $f7
    db $f0

String_97_474A_00_0B::
    db $ea, "King: You thieves!", $f1
    db "There's no escape!", $fa, $f7
    db $ef, $ee, "Repent for your", $ef, $ee, "misdeeds, and sur", $a4, $fa, $f7
    db $ef, $ee, "What? How did you", $ef, $ee, "get", $a4, " Ah, whatever!", $fa, $f7
    db $ef, $ee, "The thieves are in", $ef, $ee, "there?", $fa, $f7
    db $ef, $ee, "You're safe now!", $ef, $ee, "We're here!", $f7
    db $f0

String_97_474A_00_0C::
    db $ea, "King: Surrender", $f1
    db "and live!", $f7
    db $f0

String_97_474A_00_0D::
    db $ea, "*: Aiyeeh!", $f1
    db "Help me, boss!", $f7
    db $f0

String_97_474A_00_0E::
    db $ea, "*: Urgah! Mercy!", $f1
    db "I surrender!", $f7
    db $f0

String_97_474A_00_0F::
    db $ea, "King: Wahah! We've", $f1
    db "bagged the lot!", $fa, $f7
    db $ef, $ee, "Peace will be", $ef, $ee, "restored among", $fa, $f7
    db $ef, $ee, "people and", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "You've been a great", $ef, $ee, "help to us.", $fa, $f7
    db $ef, $ee, "I must reward your", $ef, $ee, "efforts.", $f7
    db $f0

String_97_474A_00_10::
    db $ea, "King: This is the", $f1
    db "TidalBell.", $fa, $f7
    db $ef, $ee, "It's imbued with a", $ef, $ee, "mystic power.", $fa, $f7
    db $ef, $ee, "What do you intend", $ef, $ee, "to do with it?", $fa, $f7
    db $ef, $ee, "Hm? A plug for a", $ef, $ee, "navel?", $fa, $f7
    db $ef, $ee, "Take this as my", $ef, $ee, "thanks!", $f7
    db $f0

String_97_474A_00_11::
    db $f9, "0 obtained the", $f1
    db "TidalBell.", $f7
    db $f0

String_97_474A_00_12::
    db $ea, "King: I've been a", $f1
    db "burden to you, but", $fa, $f7
    db $ef, $ee, "I'll be fine now.", $ef, $ee, "I know what to do.", $fa, $f7
    db $ef, $ee, "I will rule with", $ef, $ee, "confidence.", $fa, $f7
    db $ef, $ee, "You will always be", $ef, $ee, "welcome with us!", $f7
    db $f0

String_97_474A_00_13::
    db "A voice echoed", $f1
    db "from nowhere", $a4, $f7
    db $f0

String_97_474A_00_14::
    db $ea, "*: ", $a4, "Wa-hey!", $f1
    db "Can you hear me?", $fa, $f7
    db $ef, $ee, "I felt an odd", $ef, $ee, "power stirring.", $fa, $f7
    db $ef, $ee, "You found a plug", $ef, $ee, "for the Navel!", $fa, $f7
    db $ef, $ee, "I'll bring you", $ef, $ee, "back! Don't move!", $f7
    db $f0

String_97_474A_00_15::
    db $ea, "*: The King caught", $f1
    db "the thieves!", $f7
    db $f0

String_97_474A_00_16::
    db $eb, "*: The last king", $f1
    db "was a great man.", $fa, $f7
    db $ef, $ee, "Our King takes", $ef, $ee, "after him!", $f7
    db $f0

String_97_474A_00_17::
    db $ea, "*: We recovered", $f1
    db "everything that", $fa, $f7
    db $ef, $ee, "was taken from us.", $ef, $ee, $f7
    db $f0

String_97_474A_00_18::
    db $eb, "*: The circus has", $f1
    db "moved onto the", $fa, $f7
    db $ef, $ee, "town, and they got", $ef, $ee, "there safely.", $f7
    db $f0

String_97_474A_00_19::
    db $ea, "*: His Majesty's", $f1
    db "popularity has", $fa, $f7
    db $ef, $ee, "been growing like", $ef, $ee, "wildfire.", $fa, $f7
    db $ef, $ee, "So much for idle", $ef, $ee, "rumors.", $f7
    db $f0

String_97_474A_00_1A::
    db $ea, "*: Making a hideout", $f1
    db "in Mirage Lake", $a4, $fa, $f7
    db $ef, $ee, "No wonder they", $ef, $ee, "avoided detection!", $f7
    db $f0

String_97_474A_00_1B::
    db $ea, "*: They let us out", $f1
    db "when they realized", $fa, $f7
    db $ef, $ee, "that we were also", $ef, $ee, "victims like them.", $fa, $f7
    db $ef, $ee, "Indeed, it was a", $ef, $ee, "double whammy!", $f7
    db $f0

String_97_474A_00_1C::
    db $ea, "*: Come back and", $f1
    db "join the troupe!", $fa, $f7
    db $ef, $ee, "You'll become a", $ef, $ee, "legendary tamer!", $f7
    db $f0

String_97_474A_00_1D::
    db $ea, "*: The troupe'll", $f1
    db "reform!", $fa, $f7
    db $ef, $ee, "We'll recruit new", $ef, $ee, "members, watch!", $f7
    db $f0

String_97_474A_00_1E::
    db $ea, "*: We're more", $f1
    db "vigilant now!", $fa, $f7
    db $ef, $ee, "No thieves will", $ef, $ee, "succeed again!", $f7
    db $f0

String_97_474A_00_1F::
    db $ea, "*: I will do my", $f1
    db "best to help make", $fa, $f7
    db $ef, $ee, "the Kingdom a", $ef, $ee, "better place.", $f7
    db $f0

String_97_474A_00_20::
    db $ea, "*: Welcome, our", $f1
    db "honored guests!", $fa, $f7
    db $ef, $ee, "The King is eager", $ef, $ee, "to see you!", $f7
    db $f0

String_97_474A_00_21::
    db $ea, "*: Mirage Lake is a", $f1
    db "mystical place", $fa, $f7
    db $ef, $ee, "that can be seen,", $ef, $ee, "but never reached.", $fa, $f7
    db $ef, $ee, "It's famous as a", $ef, $ee, "haven for Beavern.", $f7
    db $f0

String_97_474A_00_22::
    db $ea, "King: Ah, good of", $f1
    db "you to visit!", $fa, $f7
    db $ef, $ee, "Our people are", $ef, $ee, "living in peace", $fa, $f7
    db $ef, $ee, "again, much thanks", $ef, $ee, "to you!", $f7
    db $f0

String_97_474A_00_23::
    db $ea, "*: The dungeon is", $f1
    db "full of thieves!", $f7
    db $f0

String_97_474A_00_24::
    db $eb, "*: Cooh, our home", $f1
    db "come back to us!", $f7
    db $f0

String_97_474A_00_25::
    db $ea, "*: Cooh! Thieves", $f1
    db "are gone!", $fa, $f7
    db $ef, $ee, "No more worries!", $ef, $ee, "Cooqueeh!", $f7
    db $f0

String_97_474A_00_26::
    db $ea, "*: Cooh! This bed", $f1
    db "perfect for sleep!", $f7
    db $f0

String_97_474A_00_27::
    db $eb, "*: Kyooh! Swimming", $f1
    db "in a desert", $a4, $fa, $f7
    db $ef, $ee, "This is luxury!", $ef, $ee, "No doubt!", $f7
    db $f0

String_97_474A_00_28::
    db $ea, "*: Kyukyooh! You", $f1
    db "are good human.", $fa, $f7
    db $ef, $ee, "I respect you now!", $ef, $ee, $f7
    db $f0

String_97_474A_00_29::
    db $ea, "*: Cooh, I heard", $f1
    db "from others held", $fa, $f7
    db $ef, $ee, "captive by the", $ef, $ee, "thieves.", $fa, $f7
    db $ef, $ee, "You beat their", $ef, $ee, "boss!", $fa, $f7
    db $ef, $ee, "I see how you beat", $ef, $ee, "me now!", $fa, $f7
    db $ef, $ee, "Let me join your", $ef, $ee, "party!", $ff, $f0

String_97_474A_00_2A::
    db $ea, "*: We are partners,", $f1
    db "and good ones too!", $f7
    db $f0

String_97_474A_00_2B::
    db $ea, "*: ", $a4, "But you have no", $f1
    db "room for me", $a4, $f7
    db $f0

String_97_474A_00_2C::
    db $ea, "*: Tch, I think", $f1
    db "I can help you", $a4, $f7
    db $f0

String_97_474A_00_2D::
    db $ea, "*: Welcome to our", $f1
    db "inn!", $f7
    db $f0

String_97_474A_00_2E::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "Thieves have", $ef, $ee, "emptied it", $a4, $f7
    db $f0

String_97_474A_00_2F::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was full of", $ef, $ee, "wood chips.", $f7
    db $f0

String_97_474A_00_30::
    db $f9, "0 checked the", $f1
    db "dresser.", $fa, $f7
    db $ef, $ee, "There was a long,", $ef, $ee, "thin cloth.", $f7
    db $f0

String_97_474A_00_31::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "The prisoners", $95, $ef, $ee, "things were there.", $f7
    db $f0

String_97_474A_00_32::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "But it was empty", $a4, $ef, $ee, $f7
    db $f0

String_97_474A_00_33::
    db $ea, "*: This is a great", $f1
    db "spot to raise a", $fa, $f7
    db $ef, $ee, "monster's egg.", $ef, $ee, "Eggs are supposed", $fa, $f7
    db $ef, $ee, "to be hatched at", $ef, $ee, "the Starry Shrine,", $fa, $f7
    db $ef, $ee, "but they won't", $ef, $ee, "notice if we hatch", $fa, $f7
    db $ef, $ee, "one here.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Have you ever", $f1
    db "found a Dream Egg?", $ff, $f0

String_97_474A_00_43::
    db $ea, "*: Put the Dream", $f1
    db "Egg on the hay.", $fa, $f7
    db $ef, $ee, "To raise it, give", $ef, $ee, "it items.", $fa, $f7
    db $ef, $ee, "An Herb will raise", $ef, $ee, "HP, for example.", $fa, $f7
    db $ef, $ee, "To make the egg", $ef, $ee, "hatch, it needs", $fa, $f7
    db $ef, $ee, "you to talk to", $ef, $ee, "many people.", $fa, $f7
    db $ef, $ee, "If you're lucky,", $ef, $ee, "you may get a", $fa, $f7
    db $ef, $ee, "powerful monster", $ef, $ee, "to hatch.", $f7
    db $f0

String_97_474A_00_44::
    db $ea, "*: This talk is too", $f1
    db "early for you.", $f7
    db $f0

String_97_474A_00_45::
    db $ea, "*: Have you ever", $f1
    db "found a Dream Egg?", $ff, $f0

String_97_474A_00_46::
    db $ea, "*: You're the child", $f1
    db "of the farmer?", $fa, $f7
    db $ef, $ee, "Under his Majesty's", $ef, $ee, "decree, there will", $fa, $f7
    db $ef, $ee, "be a tournament", $ef, $ee, "for child masters.", $fa, $f7
    db $ef, $ee, "He wishes you to", $ef, $ee, "take part.", $fa, $f7
    db $ef, $ee, "Needless to say, a", $ef, $ee, "prize awaits the", $fa, $f7
    db $ef, $ee, "champion - the", $ef, $ee, "PirateKey.", $fa, $f7
    db $ef, $ee, "The winner also", $ef, $ee, "wins the right to", $fa, $f7
    db $ef, $ee, "use the Starry", $ef, $ee, "Shrine and Egg", $fa, $f7
    db $ef, $ee, "Evaluator's", $ef, $ee, "services.", $f7
    db $f0

String_97_474A_00_47::
    db $f0

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_97_5BBF::
MessageStrings_Bank2A_Overflow::
    dw StringList_97_5BC1 ; id 0

; category list of StringCategories_97_5BBF; one pointer per wStringIndex (E-0217)
; record: string
StringList_97_5BC1::
    dw String_97_5BBF_00_00 ; id 0
    dw String_97_5BBF_00_01 ; id 1
    dw String_97_5BBF_00_02 ; id 2
    dw String_97_5BBF_00_03 ; id 3
    dw String_97_5BBF_00_04 ; id 4
    dw String_97_5BBF_00_05 ; id 5
    dw String_97_5BBF_00_06 ; id 6
    dw String_97_5BBF_00_07 ; id 7
    dw String_97_5BBF_00_08 ; id 8
    dw String_97_5BBF_00_09 ; id 9
    dw String_97_5BBF_00_0A ; id 10
    dw String_97_5BBF_00_0B ; id 11
    dw String_97_5BBF_00_0C ; id 12
    dw String_97_5BBF_00_0D ; id 13
    dw String_97_5BBF_00_0E ; id 14
    dw String_97_5BBF_00_0F ; id 15
    dw String_97_5BBF_00_10 ; id 16
    dw String_97_5BBF_00_11 ; id 17
    dw String_97_5BBF_00_12 ; id 18
    dw String_97_5BBF_00_13 ; id 19
    dw String_97_5BBF_00_14 ; id 20
    dw String_97_5BBF_00_15 ; id 21
    dw String_97_5BBF_00_16 ; id 22
    dw String_97_5BBF_00_17 ; id 23
    dw String_97_5BBF_00_18 ; id 24
    dw String_97_5BBF_00_19 ; id 25
    dw String_97_5BBF_00_1A ; id 26
    dw String_97_5BBF_00_1B ; id 27
    dw String_97_5BBF_00_1C ; id 28
    dw String_97_5BBF_00_1D ; id 29
    dw String_97_5BBF_00_1E ; id 30
    dw String_97_5BBF_00_1E ; id 31
    dw String_97_5BBF_00_1E ; id 32
    dw String_97_5BBF_00_1E ; id 33
    dw String_97_5BBF_00_1E ; id 34
    dw String_97_5BBF_00_1E ; id 35
    dw String_97_5BBF_00_1E ; id 36
    dw String_97_5BBF_00_1E ; id 37
    dw String_97_5BBF_00_1E ; id 38
    dw String_97_5BBF_00_1E ; id 39
    dw String_97_5BBF_00_1E ; id 40
    dw String_97_5BBF_00_1E ; id 41
    dw String_97_5BBF_00_1E ; id 42
    dw String_97_5BBF_00_1E ; id 43
    dw String_97_5BBF_00_1E ; id 44
    dw String_97_5BBF_00_1E ; id 45
    dw String_97_5BBF_00_1E ; id 46
    dw String_97_5BBF_00_1E ; id 47
    dw String_97_5BBF_00_1E ; id 48
    dw String_97_5BBF_00_1E ; id 49
    dw String_97_5BBF_00_1E ; id 50
    dw String_97_5BBF_00_1E ; id 51
    dw String_97_5BBF_00_1E ; id 52
    dw String_97_5BBF_00_1E ; id 53
    dw String_97_5BBF_00_1E ; id 54
    dw String_97_5BBF_00_1E ; id 55
    dw String_97_5BBF_00_1E ; id 56
    dw String_97_5BBF_00_1E ; id 57
    dw String_97_5BBF_00_1E ; id 58
    dw String_97_5BBF_00_1E ; id 59
    dw String_97_5BBF_00_1E ; id 60
    dw String_97_5BBF_00_1E ; id 61
    dw String_97_5BBF_00_1E ; id 62
    dw String_97_5BBF_00_1E ; id 63
    dw String_97_5BBF_00_1E ; id 64
    dw String_97_5BBF_00_1E ; id 65
    dw String_97_5BBF_00_1E ; id 66
    dw String_97_5BBF_00_1E ; id 67
    dw String_97_5BBF_00_1E ; id 68
    dw String_97_5BBF_00_1E ; id 69
    dw String_97_5BBF_00_1E ; id 70
    dw String_97_5BBF_00_1E ; id 71
    dw String_97_5BBF_00_48 ; id 72
    dw String_97_5BBF_00_49 ; id 73
    dw String_97_5BBF_00_49 ; id 74
    dw String_97_5BBF_00_49 ; id 75
    dw String_97_5BBF_00_49 ; id 76
    dw String_97_5BBF_00_49 ; id 77
    dw String_97_5BBF_00_49 ; id 78
    dw String_97_5BBF_00_49 ; id 79
    dw String_97_5BBF_00_49 ; id 80
    dw String_97_5BBF_00_49 ; id 81
    dw String_97_5BBF_00_52 ; id 82
    dw String_97_5BBF_00_52 ; id 83
    dw String_97_5BBF_00_52 ; id 84
    dw String_97_5BBF_00_55 ; id 85
    dw String_97_5BBF_00_55 ; id 86
    dw String_97_5BBF_00_55 ; id 87
    dw String_97_5BBF_00_58 ; id 88
    dw String_97_5BBF_00_59 ; id 89
    dw String_97_5BBF_00_59 ; id 90
    dw String_97_5BBF_00_59 ; id 91
    dw String_97_5BBF_00_59 ; id 92
    dw String_97_5BBF_00_59 ; id 93
    dw String_97_5BBF_00_59 ; id 94
    dw String_97_5BBF_00_59 ; id 95
    dw String_97_5BBF_00_59 ; id 96
    dw String_97_5BBF_00_59 ; id 97
    dw String_97_5BBF_00_59 ; id 98
    dw String_97_5BBF_00_59 ; id 99
    dw String_97_5BBF_00_59 ; id 100
    dw String_97_5BBF_00_59 ; id 101
    dw String_97_5BBF_00_59 ; id 102
    dw String_97_5BBF_00_59 ; id 103
    dw String_97_5BBF_00_59 ; id 104
    dw String_97_5BBF_00_59 ; id 105
    dw String_97_5BBF_00_59 ; id 106

String_97_5BBF_00_00::
    db $eb, "*: In an Arena", $f1
    db "battle, you can't", $fa, $f7
    db $ef, $ee, "command your", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "You have to leave", $ef, $ee, "it up to them.", $fa, $f7
    db $ef, $ee, "What kinds of", $ef, $ee, "personalities they", $fa, $f7
    db $ef, $ee, "have will decide", $ef, $ee, "how they act.", $f7
    db $f0

String_97_5BBF_00_01::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was filled with", $ef, $ee, "the crowd's trash.", $f7
    db $f0

String_97_5BBF_00_02::
    db $ea, "*: Welcome to my", $f1
    db "Key Shop!", $fa, $f7
    db $ef, $ee, "I appraise and", $ef, $ee, "identify keys!", $fa, $f7
    db $ef, $ee, "An unidentified", $ef, $ee, "key can't be used!", $fa, $f7
    db $ef, $ee, "Should I appraise", $ef, $ee, "your keys?", $f0

String_97_5BBF_00_03::
    db $ea, "*: Welcome to my", $f1
    db "Key Shop!", $fa, $f7
    db $ef, $ee, "Should I appraise", $ef, $ee, "your keys?", $f0

String_97_5BBF_00_04::
    db $ea, "*: I'm apprenticing", $f1
    db "under the boss.", $fa, $f7
    db $ef, $ee, "He told me that", $ef, $ee, "the name of a key", $fa, $f7
    db $ef, $ee, "hints at its", $ef, $ee, "destination.", $f7
    db $f0

String_97_5BBF_00_05::
    db $ea, "*: Day after day,", $f1
    db "I examine keys.", $fa, $f7
    db $ef, $ee, "But I'm nothing", $ef, $ee, "compared to the", $fa, $f7
    db $ef, $ee, "boss yet.", $ef, $ee, $f7
    db $f0

String_97_5BBF_00_06::
    db $ea, "*: I found a key in", $f1
    db "another world, so", $fa, $f7
    db $ef, $ee, "I'm having it", $ef, $ee, "appraised.", $fa, $f7
    db $ef, $ee, "I hope it leads to", $ef, $ee, "a world with some", $fa, $f7
    db $ef, $ee, "monsters I've not", $ef, $ee, "yet seen.", $f7
    db $f0

String_97_5BBF_00_07::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "It greedily sucked", $ef, $ee, "air into its fire.", $f7
    db $f0

String_97_5BBF_00_08::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was full of", $ef, $ee, "jet-black coal.", $f7
    db $f0

String_97_5BBF_00_09::
    db $ea, "Warubou: Wa-hey!", $f1
    db "This time, you'll", $fa, $f7
    db $ef, $ee, "have to find the", $ef, $ee, "key first, warooh.", $fa, $f7
    db $ef, $ee, "The key, it should", $ef, $ee, "be in GreatLog.", $fa, $f7
    db $ef, $ee, "I think it is the", $ef, $ee, "PirateKey.", $fa, $f7
    db $ef, $ee, "Don't you forget", $ef, $ee, "it, warooh.", $f7
    db $f0

String_97_5BBF_00_0A::
    db $ea, "Warubou: Wa-hey,", $f1
    db "hurry.", $fa, $f7
    db $ef, $ee, "You need to gather", $ef, $ee, "more energy.", $f7
    db $f0

String_97_5BBF_00_0B::
    db $ea, "Warubou: Wa-hey,", $f1
    db "you've gathered", $fa, $f7
    db $ef, $ee, "enough energy for", $ef, $ee, "just one person.", $fa, $f7
    db $ef, $ee, "I need more energy", $ef, $ee, "still, hurry!", $f7
    db $f0

String_97_5BBF_00_0C::
    db $ea, "Warubou: Wa-hey, I", $f1
    db "have enough energy", $fa, $f7
    db $ef, $ee, "for two people.", $ef, $ee, "But I need more.", $fa, $f7
    db $ef, $ee, "Just a bit more,", $ef, $ee, "and I'll be ready.", $f7
    db $f0

String_97_5BBF_00_0D::
    db $ea, "Warubou: Wa-hey.", $f1
    db "I need you to go", $fa, $f7
    db $ef, $ee, "to another world", $ef, $ee, "to find a plug.", $fa, $f7
    db $ef, $ee, "But I've no power", $ef, $ee, "to make a key", $a4, $fa, $f7
    db $ef, $ee, "That power is from", $ef, $ee, "GreatLog's tree.", $fa, $f7
    db $ef, $ee, "It is energy made", $ef, $ee, "by the bond tying", $fa, $f7
    db $ef, $ee, "people and their", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "Help people bond", $ef, $ee, "with monsters, and", $fa, $f7
    db $ef, $ee, "GreatLog's power", $ef, $ee, "will be boosted.", $f7
    db $f0

String_97_5BBF_00_0E::
    db $ea, "Warubou: Wa-hey!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "There is enough", $ef, $ee, "power for me to", $fa, $f7
    db $ef, $ee, "make a Magic Key,", $ef, $ee, "yes, warooh!", $fa, $f7
    db $ef, $ee, "Good job, ", $f9, "0!", $ef, $ee, "Just wait now!", $fa, $f7
    db $ef, $ee, "I'll make the key", $ef, $ee, "right away.", $f7
    db $f0

String_97_5BBF_00_0F::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0 you're slow!", $fa, $f7
    db $ef, $ee, "Kameha already", $ef, $ee, "came by today with", $fa, $f7
    db $ef, $ee, "the PirateKey,", $ef, $ee, "warooh.", $fa, $f7
    db $ef, $ee, "He got it from the", $ef, $ee, "King by whining.", $fa, $f7
    db $ef, $ee, "You", $44, " better follow", $ef, $ee, "him to the other", $fa, $f7
    db $ef, $ee, "world right away.", $ef, $ee, "Don't be late!", $fa, $f7
    db $ef, $ee, "Also, Kameha isn't", $ef, $ee, "a bad guy, warooh.", $fa, $f7
    db $ef, $ee, "If you see him", $ef, $ee, "over there, help", $fa, $f7
    db $ef, $ee, "him if he needs", $ef, $ee, "it.", $fa, $f7
    db $ef, $ee, "And, don't forget.", $ef, $ee, "You can cross", $fa, $f7
    db $ef, $ee, "water by using the", $ef, $ee, "TidalBell.", $fa, $f7
    db $ef, $ee, "Bring me back some", $ef, $ee, "good news, warooh!", $f7
    db $f0

String_97_5BBF_00_10::
    db $f9, "0 received the", $f1
    db "PirateKey.", $e5, $58, $f7
    db $e9, $ff, $f0

String_97_5BBF_00_11::
    db $ea, "*: Putting up a", $f1
    db "bridge is easy!", $f7
    db $f0

String_97_5BBF_00_12::
    db $ea, "Warubou: Wa-hey!", $f1
    db "You did it, ", $f9, "0!", $fa, $f7
    db $ef, $ee, "GreatLog's power", $ef, $ee, "will heal you!", $f7
    db $f0

String_97_5BBF_00_13::
    db $ea, "Warubou: There,", $f1
    db "your party's fine!", $fa, $f7
    db $ef, $ee, "So, the new plug", $ef, $ee, "for Log's Navel?", $f7
    db $f0

String_97_5BBF_00_14::
    db $ea, "Warubou: Wa-hey!", $f1
    db "So, this is it?", $fa, $f7
    db $ef, $ee, "This is the", $ef, $ee, "HarMirror, warooh?", $fa, $f7
    db $ef, $ee, "I can feel an odd", $ef, $ee, "power from it!", $f7
    db $f0

String_97_5BBF_00_15::
    db $ea, "Warubou: Wa-hey!", $f1
    db "That's it!", $fa, $f7
    db $ef, $ee, "GreatLog is saved!", $ef, $ee, "Good, now", $a4, " Warooh?", $f7
    db $f0

String_97_5BBF_00_16::
    db $ea, "Warubou: Wa-hey!", $f1
    db "No good, no good!", $fa, $f7
    db $ef, $ee, "I have to plug the", $ef, $ee, "Navel again!", $f7
    db $f0

String_97_5BBF_00_17::
    db $ea, "Warubou: Wa-hey", $a4, $f1
    db "That was no good.", $fa, $f7
    db $ef, $ee, "But HarMirror does", $ef, $ee, "have magic in it.", $fa, $f7
    db $ef, $ee, "Give me your hand,", $ef, $ee, $f9, "0. Wa-hey!", $f7
    db $f0

String_97_5BBF_00_18::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Stop that!", $fa, $f7
    db $ef, $ee, "Why do you look so", $ef, $ee, "unhappy at me?", $fa, $f7
    db $ef, $ee, "A hero doesn't walk", $ef, $ee, "from someone in", $fa, $f7
    db $ef, $ee, "trouble, you ought", $ef, $ee, "to know that!", $fa, $f7
    db $ef, $ee, "Come on, give me a", $ef, $ee, "big smile, warooh!", $ff, $f0

String_97_5BBF_00_19::
    db $ea, "Warubou: Listen.", $f1
    db "I feel a strange", $fa, $f7
    db $ef, $ee, "power in another", $ef, $ee, "world, warooh.", $fa, $f7
    db $ef, $ee, "It has to be a", $ef, $ee, "plug, I can tell!", $fa, $f7
    db $ef, $ee, "Wa-hey, gather", $ef, $ee, "more of the energy", $fa, $f7
    db $ef, $ee, "from GreatLog's", $ef, $ee, "tree, I need it.", $f7
    db $f0

String_97_5BBF_00_1A::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0?", $fa, $f7
    db $ef, $ee, "Angry still with", $ef, $ee, "me, warooh?", $fa, $f7
    db $ef, $ee, "Wasted energy,", $ef, $ee, "that is!", $fa, $f7
    db $ef, $ee, "Come on, cheer up", $ef, $ee, "and smile, wa-hey!", $ff, $f0

String_97_5BBF_00_1B::
    db $f9, "0 peered into", $f1
    db "the barrel.", $fa, $f7
    db $ef, $ee, "It was full of", $ef, $ee, "junk.", $f7
    db $f0

String_97_5BBF_00_1C::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "It was still warm", $ef, $ee, "from cooking.", $f7
    db $f0

String_97_5BBF_00_1D::
    db $eb, "*: Come back if you", $f1
    db "need to check up", $fa, $f7
    db $ef, $ee, "on your monster", $ef, $ee, "Catalog.", $f7
    db $f0

String_97_5BBF_00_1E::
    db $ea, "*: GreatLog's", $f1
    db "Starry Shrine", $fa, $f7
    db $ef, $ee, "wasn't in use for", $ef, $ee, "a long time.", $fa, $f7
    db $ef, $ee, "But research into", $ef, $ee, "breeding shed new", $fa, $f7
    db $ef, $ee, "light on its great", $ef, $ee, "potential.", $fa, $f7
    db $ef, $ee, "Now, the Shrine is", $ef, $ee, "considered to be", $fa, $f7
    db $ef, $ee, "an indispensable", $ef, $ee, "place for masters.", $f7
    db $f0

String_97_5BBF_00_48::
    db $ea, "*: Parents pass on", $f1
    db "abilities to their", $fa, $f7
    db $ef, $ee, "children, who in", $ef, $ee, "turn pass on their", $fa, $f7
    db $ef, $ee, "abilities to their", $ef, $ee, "own offspring.", $fa, $f7
    db $ef, $ee, "Saying goodbye is", $ef, $ee, "never easy, but", $fa, $f7
    db $ef, $ee, "that is the cycle", $ef, $ee, "of life.", $f7
    db $f0

String_97_5BBF_00_49::
    db $f9, "0 received the", $f1
    db "IceKey.", $e5, $58, $f7
    db $e9, $ff, $f0

String_97_5BBF_00_52::
    db $ea, "Warubou: Wa-hey?", $f1
    db "So, this is it?", $fa, $f7
    db $ef, $ee, "This is the", $ef, $ee, "SkyShield, warooh?", $fa, $f7
    db $ef, $ee, "It gives off more", $ef, $ee, "magical power than", $fa, $f7
    db $ef, $ee, "the other things", $ef, $ee, "you've brought me.", $fa, $f7
    db $ef, $ee, "We'll see if it", $ef, $ee, "works, warooh!", $f7
    db $f0

String_97_5BBF_00_55::
    db $ea, "Warubou: Wa-hey", $a4, $f1
    db "That was no good.", $fa, $f7
    db $ef, $ee, "But this too has", $ef, $ee, "magic in it.", $fa, $f7
    db $ef, $ee, "Give me your hand,", $ef, $ee, $f9, "0. Wa-hey!", $f7
    db $f0

String_97_5BBF_00_58::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Stop that!", $fa, $f7
    db $ef, $ee, "Why do you look so", $ef, $ee, "disgusted with me?", $fa, $f7
    db $ef, $ee, "People can do", $ef, $ee, "anything if they", $fa, $f7
    db $ef, $ee, "buckle down and", $ef, $ee, "work, warooh!", $fa, $f7
    db $ef, $ee, "Come on, give me a", $ef, $ee, "big smile, ", $f9, "0!", $ff, $f0

String_97_5BBF_00_59::
    db $f0

StringCategories_97_6DC1::
MessageStrings_Bank83_Overflow::
    dw StringList_97_6DC3 ; id 0

; category list of StringCategories_97_6DC1; one pointer per wStringIndex (E-0217)
StringList_97_6DC3::
    dw String_97_6DC1_00_00 ; id 0
    dw String_97_6DC1_00_01 ; id 1
    dw String_97_6DC1_00_02 ; id 2
    dw String_97_6DC1_00_03 ; id 3
    dw String_97_6DC1_00_04 ; id 4
    dw String_97_6DC1_00_05 ; id 5
    dw String_97_6DC1_00_06 ; id 6
    dw String_97_6DC1_00_07 ; id 7
    dw String_97_6DC1_00_08 ; id 8
    dw String_97_6DC1_00_09 ; id 9
    dw String_97_6DC1_00_0A ; id 10
    dw String_97_6DC1_00_0B ; id 11
    dw String_97_6DC1_00_0C ; id 12
    dw String_97_6DC1_00_0D ; id 13
    dw String_97_6DC1_00_0E ; id 14
    dw String_97_6DC1_00_0F ; id 15
    dw String_97_6DC1_00_10 ; id 16
    dw String_97_6DC1_00_11 ; id 17
    dw String_97_6DC1_00_12 ; id 18
    dw String_97_6DC1_00_13 ; id 19
    dw String_97_6DC1_00_14 ; id 20
    dw String_97_6DC1_00_15 ; id 21
    dw String_97_6DC1_00_16 ; id 22
    dw String_97_6DC1_00_17 ; id 23
    dw String_97_6DC1_00_18 ; id 24
    dw String_97_6DC1_00_19 ; id 25
    dw String_97_6DC1_00_1A ; id 26
    dw String_97_6DC1_00_1B ; id 27
    dw String_97_6DC1_00_1C ; id 28
    dw String_97_6DC1_00_1D ; id 29
    dw String_97_6DC1_00_1E ; id 30
    dw String_97_6DC1_00_1F ; id 31
    dw String_97_6DC1_00_20 ; id 32
    dw String_97_6DC1_00_21 ; id 33
    dw String_97_6DC1_00_22 ; id 34
    dw String_97_6DC1_00_23 ; id 35
    dw String_97_6DC1_00_24 ; id 36
    dw String_97_6DC1_00_25 ; id 37
    dw String_97_6DC1_00_26 ; id 38
    dw String_97_6DC1_00_27 ; id 39
    dw String_97_6DC1_00_28 ; id 40
    dw String_97_6DC1_00_29 ; id 41
    dw String_97_6DC1_00_2A ; id 42
    dw String_97_6DC1_00_2B ; id 43
    dw String_97_6DC1_00_2B ; id 44
    dw String_97_6DC1_00_2B ; id 45
    dw String_97_6DC1_00_2B ; id 46
    dw String_97_6DC1_00_2B ; id 47
    dw String_97_6DC1_00_2B ; id 48
    dw String_97_6DC1_00_2B ; id 49
    dw String_97_6DC1_00_2B ; id 50
    dw String_97_6DC1_00_2B ; id 51
    dw String_97_6DC1_00_2B ; id 52
    dw String_97_6DC1_00_2B ; id 53
    dw String_97_6DC1_00_2B ; id 54
    dw String_97_6DC1_00_2B ; id 55
    dw String_97_6DC1_00_2B ; id 56

String_97_6DC1_00_00::
    db $ea, "*: The skills that", $f1
    db "are learned by", $fa, $f7
    db $ef, $ee, "monsters depends", $ef, $ee, "on their families.", $fa, $f7
    db $ef, $ee, "Through breeding,", $ef, $ee, "monsters will", $fa, $f7
    db $ef, $ee, "learn a greater", $ef, $ee, "variety of skills.", $f7
    db $f0

String_97_6DC1_00_01::
    db $ea, "*: How quickly the", $f1
    db "different stats", $fa, $f7
    db $ef, $ee, "rise varies by the", $ef, $ee, "monster family.", $fa, $f7
    db $ef, $ee, "I bet you didn't", $ef, $ee, "know that.", $f7
    db $f0

String_97_6DC1_00_02::
    db $ea, "*: I wish I could", $f1
    db "play outside", $a4, $fa, $f7
    db $ef, $ee, "But Mom won't let", $ef, $ee, "me go anywhere", $a4, $f7
    db $f0

String_97_6DC1_00_03::
    db $ea, "*: Aren't you lonely", $f1
    db "traveling alone?", $fa, $f7
    db $ef, $ee, "Oh, but then you're", $ef, $ee, "with monsters.", $f7
    db $f0

String_97_6DC1_00_04::
    db $ea, "*: I wish I had", $f1
    db "monster friends.", $fa, $f7
    db $ef, $ee, "They could help me", $ef, $ee, "with my homework.", $f7
    db $f0

String_97_6DC1_00_05::
    db $ea, "*: Why are you", $f1
    db "consorting with", $fa, $f7
    db $ef, $ee, "monsters?", $ef, $ee, "I don't trust you!", $f7
    db $f0

String_97_6DC1_00_06::
    db $ea, "*: When I grow up,", $f1
    db "I'm going to take", $fa, $f7
    db $ef, $ee, "over my dad's job", $ef, $ee, "as a dealer.", $fa, $f7
    db $ef, $ee, "He travels from", $ef, $ee, "town to town!", $f7
    db $f0

String_97_6DC1_00_07::
    db $ea, "*: D-don't t-try to", $f1
    db "scare me.", $fa, $f7
    db $ef, $ee, "I", $a4, " I'm not scared", $ef, $ee, "of monsters!", $f7
    db $f0

String_97_6DC1_00_08::
    db $ea, "*: If we could fly", $f1
    db "like birds", $a4, $fa, $f7
    db $ef, $ee, "We", $44, " be able to go", $ef, $ee, "anywhere.", $fa, $f7
    db $ef, $ee, "Now that's freedom.", $ef, $ee, "Don't you think?", $f7
    db $f0

String_97_6DC1_00_09::
    db $ea, "*: Would you be my", $f1
    db "friend?", $f7
    db $f0

String_97_6DC1_00_0A::
    db $ea, "*: Don't goof off!", $f1
    db "Do your homework!", $fa, $f7
    db $ef, $ee, "My mom says that", $ef, $ee, "all the time.", $f7
    db $f0

String_97_6DC1_00_0B::
    db $ea, "*: Mom's going to", $f1
    db "have a baby soon.", $fa, $f7
    db $ef, $ee, "I wonder if it", $ef, $ee, "will be a boy or", $fa, $f7
    db $ef, $ee, "girl. It doesn't", $ef, $ee, "matter, though!", $f7
    db $f0

String_97_6DC1_00_0C::
    db $ea, "*: A bard, that's", $f1
    db "what I'm gonna be.", $fa, $f7
    db $ef, $ee, "Gonna travel and", $ef, $ee, "sing about it.", $fa, $f7
    db $ef, $ee, "I practice!", $ef, $ee, "La", $9d, " lalala", $9d, ".", $f7
    db $f0

String_97_6DC1_00_0D::
    db $ea, "*: I", $44, " love to ride", $f1
    db "through forests on", $fa, $f7
    db $ef, $ee, "a Unicorn.", $ef, $ee, "That's my dream.", $fa, $f7
    db $ef, $ee, "If it comes true,", $ef, $ee, "I'll let you ride!", $f7
    db $f0

String_97_6DC1_00_0E::
    db $ea, "*: I hate carrots!", $f1
    db "It tastes blecch!", $fa, $f7
    db $ef, $ee, "I bet a DanceVegi", $ef, $ee, "tastes awful too!", $f7
    db $f0

String_97_6DC1_00_0F::
    db $ea, "*: Lipsy always", $f1
    db "wants to kiss.", $fa, $f7
    db $ef, $ee, "Mommy's like that", $ef, $ee, "after some cider.", $f7
    db $f0

String_97_6DC1_00_10::
    db $ea, "*: I'm going to be", $f1
    db "like my dad and", $fa, $f7
    db $ef, $ee, "become a soldier.", $ef, $ee, "I'll get to wear", $fa, $f7
    db $ef, $ee, "the awesome armor", $ef, $ee, "they have.", $f7
    db $f0

String_97_6DC1_00_11::
    db $ea, "*: Do you think it's", $f1
    db "impressive to have", $fa, $f7
    db $ef, $ee, "monsters around?", $ef, $ee, "I'm not jealous.", $fa, $f7
    db $ef, $ee, "No, really, I'm", $ef, $ee, "not envious!", $f7
    db $f0

String_97_6DC1_00_12::
    db $ea, "*: I'm your master", $f1
    db "from now on!", $fa, $f7
    db $ef, $ee, "Your first order", $ef, $ee, "is", $a4, $fa, $f7
    db $ef, $ee, "Wait! Listen!", $ef, $ee, "Will you listen?", $f7
    db $f0

String_97_6DC1_00_13::
    db $ea, "*: You act big for", $f1
    db "an outsider!", $fa, $f7
    db $ef, $ee, "Don't think you", $ef, $ee, "scare me with your", $fa, $f7
    db $ef, $ee, "monsters. I", $a4, " I'm", $ef, $ee, "not scared a bit!", $f7
    db $f0

String_97_6DC1_00_14::
    db $ea, "*: Monsters get", $f1
    db "discouraged if you", $fa, $f7
    db $ef, $ee, "order them around", $ef, $ee, "all the time.", $fa, $f7
    db $ef, $ee, "You should assign", $ef, $ee, "them a plan, and", $fa, $f7
    db $ef, $ee, "let them do what", $ef, $ee, "they want.", $f7
    db $f0

String_97_6DC1_00_15::
    db $ea, "*: A bred monster", $f1
    db "learns the skills", $fa, $f7
    db $ef, $ee, "that its parents", $ef, $ee, "knew.", $fa, $f7
    db $ef, $ee, "So, it will learn", $ef, $ee, "many skills.", $f7
    db $f0

String_97_6DC1_00_16::
    db $ea, "*: Skills come in", $f1
    db "the three groups", $fa, $f7
    db $ef, $ee, "of attack, support", $ef, $ee, "and defense.", $f7
    db $f0

String_97_6DC1_00_17::
    db $ea, "*: You'll find it", $f1
    db "easier to raise", $fa, $f7
    db $ef, $ee, "monsters if you", $ef, $ee, "assign them roles.", $fa, $f7
    db $ef, $ee, "On the other hand,", $ef, $ee, "you could raise", $fa, $f7
    db $ef, $ee, "one like a hero-", $ef, $ee, "useful all around.", $f7
    db $f0

String_97_6DC1_00_18::
    db $ea, "*: I've never met", $f1
    db "anyone like you.", $fa, $f7
    db $ef, $ee, "Your quiet way is", $ef, $ee, "just so cool!", $f7
    db $f0

String_97_6DC1_00_19::
    db $ea, "*: You came from", $f1
    db "GreatLog?", $fa, $f7
    db $ef, $ee, "I've never heard", $ef, $ee, "of it, sorry.", $f7
    db $f0

String_97_6DC1_00_1A::
    db $ea, "*: Ah, you're a", $f1
    db "traveler?", $fa, $f7
    db $ef, $ee, "From GreatLog, you", $ef, $ee, "say.", $fa, $f7
    db $ef, $ee, "I've been to", $ef, $ee, "GreatTree, myself.", $f7
    db $f0

String_97_6DC1_00_1B::
    db $ea, "*: I've heard tales", $f1
    db "that GreatLog is a", $fa, $f7
    db $ef, $ee, "hollowed out palm", $ef, $ee, "tree.", $f7
    db $f0

String_97_6DC1_00_1C::
    db $ea, "*: You're from", $f1
    db "GreatLog?", $f7
    db $f0, "Isn't that where", $f1
    db "the prince is a", $fa, $f7
    db $ef, $ee, "little terror?", $ef, $ee, "Kameha, right?", $fa, $f7
    db $ef, $ee, "Royalty can be so", $ef, $ee, "selfish.", $f7
    db $f0

String_97_6DC1_00_1D::
    db $ea, "*: I understand", $f1
    db "monster masters", $fa, $f7
    db $ef, $ee, "flock to the", $ef, $ee, "kingdom of", $fa, $f7
    db $ef, $ee, "GreatLog.", $ef, $ee, $fa, $f7
    db $ef, $ee, "Oh? You're from", $ef, $ee, "GreatLog, you say?", $f7
    db $f0

String_97_6DC1_00_1E::
    db $eb, "*: I wander the", $f1
    db "other worlds", $a4, $fa, $f7
    db $ef, $ee, "I'm sure we will", $ef, $ee, "meet again.", $f7
    db $f0

String_97_6DC1_00_1F::
    db $eb, "*: I wander the", $f1
    db "other worlds", $a4, $fa, $f7
    db $ef, $ee, "I chronicle what", $ef, $ee, "I've experienced.", $f7
    db $f0

String_97_6DC1_00_20::
    db $eb, "*: I wander the", $f1
    db "other worlds", $a4, $fa, $f7
    db $ef, $ee, "I'll see more, as", $ef, $ee, "I've done today.", $f7
    db $f0

String_97_6DC1_00_21::
    db $eb, "*: I wander the", $f1
    db "other worlds", $a4, $fa, $f7
    db $ef, $ee, "I'll soon leave", $ef, $ee, "for another world.", $f7
    db $f0

String_97_6DC1_00_22::
    db $eb, "*: I wander the", $f1
    db "other worlds", $a4, $fa, $f7
    db $ef, $ee, "We may have", $ef, $ee, "crossed paths", $a4, $f7
    db $f0

String_97_6DC1_00_23::
    db $ea, "*: I study monsters", $f1
    db "in other worlds.", $fa, $f7
    db $ef, $ee, "I'm intrigued by", $ef, $ee, "your monsters.", $f7
    db $f0

String_97_6DC1_00_24::
    db $ea, "*: I study monsters", $f1
    db "in other worlds.", $fa, $f7
    db $ef, $ee, "I think I'm done", $ef, $ee, "with this area.", $f7
    db $f0

String_97_6DC1_00_25::
    db $ea, "*: I study monsters", $f1
    db "in other worlds.", $fa, $f7
    db $ef, $ee, "What monsters", $ef, $ee, "await me next?", $f7
    db $f0

String_97_6DC1_00_26::
    db $ea, "*: I study monsters", $f1
    db "in other worlds.", $fa, $f7
    db $ef, $ee, "Haven't I seen you", $ef, $ee, "elsewhere before?", $f7
    db $f0

String_97_6DC1_00_27::
    db $ea, "*: Humph", $a4, $f1
    db $fa, $f7
    db $ef, $ee, $f3, "That's my Terry", $ef, $ee, "impression. So?", $f7
    db $f0

String_97_6DC1_00_28::
    db $ea, "*: I met this girl", $f1
    db "named Milayou.", $fa, $f7
    db $ef, $ee, "Hoo boy, she was", $ef, $ee, "some kind of cute.", $fa, $f7
    db $ef, $ee, "She'll become", $ef, $ee, "stunning for sure!", $f7
    db $f0

String_97_6DC1_00_29::
    db $ea, "*: I wish Terry", $44, $f1
    db "visit again.", $fa, $f7
    db $ef, $ee, "The girls come out", $ef, $ee, "to see him.", $f7
    db $f0

String_97_6DC1_00_2A::
    db $ea, "*: I'm going to", $f1
    db "marry Milayou.", $fa, $f7
    db $ef, $ee, "You bet I will!", $ef, $ee, "I said so!", $f7
    db $f0

String_97_6DC1_00_2B::
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000"
