SECTION "Bank 98", ROMX[$4000], BANK[$98]
    db $98

; overflow for message bank $2B: wStringIndex -= $8A, then BeginStringDisplay with the table
; MessageStrings_Bank2B_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2B_Overflow::
    ld de, MessageStrings_Bank2B_Overflow
    ld a, [wStringIndex]
    sub $8a
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2B: wStringIndex -= $8A, then CopyStringToBuffer with the table
; MessageStrings_Bank2B_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2B_Overflow::
    ld de, MessageStrings_Bank2B_Overflow
    ld a, [wStringIndex]
    sub $8a
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; overflow for message bank $2C: wStringIndex -= $91, then BeginStringDisplay with the table
; MessageStrings_Bank2C_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2C_Overflow::
    ld de, MessageStrings_Bank2C_Overflow
    ld a, [wStringIndex]
    sub $91
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2C: wStringIndex -= $91, then CopyStringToBuffer with the table
; MessageStrings_Bank2C_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2C_Overflow::
    ld de, MessageStrings_Bank2C_Overflow
    ld a, [wStringIndex]
    sub $91
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $26, $40, $cd, $11, $26, $c9

; overflow for message bank $89: wStringIndex -= $DE, then BeginStringDisplay with the table
; MessageStrings_Bank89_Overflow in this bank (E-0080)
BeginStringDisplay_Bank89_Overflow::
    ld de, MessageStrings_Bank89_Overflow
    ld a, [wStringIndex]
    sub $de
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $89: wStringIndex -= $DE, then CopyStringToBuffer with the table
; MessageStrings_Bank89_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank89_Overflow::
    ld de, MessageStrings_Bank89_Overflow
    ld a, [wStringIndex]
    sub $de
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $4b, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_98_4070::
MessageStrings_Bank2B_Overflow::
    dw StringList_98_4072 ; id 0

; category list of StringCategories_98_4070; one pointer per wStringIndex (E-0217)
; record: string
StringList_98_4072::
    dw String_98_4070_00_00 ; id 0
    dw String_98_4070_00_01 ; id 1
    dw String_98_4070_00_02 ; id 2
    dw String_98_4070_00_03 ; id 3
    dw String_98_4070_00_04 ; id 4
    dw String_98_4070_00_05 ; id 5
    dw String_98_4070_00_06 ; id 6
    dw String_98_4070_00_07 ; id 7
    dw String_98_4070_00_08 ; id 8
    dw String_98_4070_00_09 ; id 9
    dw String_98_4070_00_0A ; id 10
    dw String_98_4070_00_0B ; id 11
    dw String_98_4070_00_0C ; id 12
    dw String_98_4070_00_0D ; id 13
    dw String_98_4070_00_0E ; id 14
    dw String_98_4070_00_0F ; id 15
    dw String_98_4070_00_10 ; id 16
    dw String_98_4070_00_11 ; id 17
    dw String_98_4070_00_12 ; id 18
    dw String_98_4070_00_13 ; id 19
    dw String_98_4070_00_14 ; id 20
    dw String_98_4070_00_15 ; id 21
    dw String_98_4070_00_16 ; id 22
    dw String_98_4070_00_17 ; id 23
    dw String_98_4070_00_18 ; id 24
    dw String_98_4070_00_19 ; id 25
    dw String_98_4070_00_1A ; id 26
    dw String_98_4070_00_1B ; id 27
    dw String_98_4070_00_1C ; id 28
    dw String_98_4070_00_1D ; id 29
    dw String_98_4070_00_1E ; id 30
    dw String_98_4070_00_1F ; id 31
    dw String_98_4070_00_20 ; id 32
    dw String_98_4070_00_21 ; id 33
    dw String_98_4070_00_22 ; id 34
    dw String_98_4070_00_23 ; id 35
    dw String_98_4070_00_24 ; id 36
    dw String_98_4070_00_25 ; id 37
    dw String_98_4070_00_26 ; id 38
    dw String_98_4070_00_27 ; id 39
    dw String_98_4070_00_28 ; id 40
    dw String_98_4070_00_29 ; id 41
    dw String_98_4070_00_2A ; id 42
    dw String_98_4070_00_2B ; id 43
    dw String_98_4070_00_2C ; id 44
    dw String_98_4070_00_2D ; id 45
    dw String_98_4070_00_2E ; id 46
    dw String_98_4070_00_2F ; id 47
    dw String_98_4070_00_30 ; id 48
    dw String_98_4070_00_30 ; id 49
    dw String_98_4070_00_30 ; id 50
    dw String_98_4070_00_30 ; id 51
    dw String_98_4070_00_30 ; id 52
    dw String_98_4070_00_30 ; id 53
    dw String_98_4070_00_30 ; id 54
    dw String_98_4070_00_30 ; id 55
    dw String_98_4070_00_30 ; id 56
    dw String_98_4070_00_39 ; id 57
    dw String_98_4070_00_39 ; id 58
    dw String_98_4070_00_39 ; id 59
    dw String_98_4070_00_39 ; id 60
    dw String_98_4070_00_39 ; id 61
    dw String_98_4070_00_39 ; id 62
    dw String_98_4070_00_39 ; id 63
    dw String_98_4070_00_39 ; id 64
    dw String_98_4070_00_39 ; id 65
    dw String_98_4070_00_39 ; id 66
    dw String_98_4070_00_39 ; id 67
    dw String_98_4070_00_39 ; id 68
    dw String_98_4070_00_39 ; id 69
    dw String_98_4070_00_39 ; id 70
    dw String_98_4070_00_39 ; id 71
    dw String_98_4070_00_39 ; id 72
    dw String_98_4070_00_39 ; id 73
    dw String_98_4070_00_39 ; id 74
    dw String_98_4070_00_39 ; id 75
    dw String_98_4070_00_39 ; id 76
    dw String_98_4070_00_39 ; id 77
    dw String_98_4070_00_39 ; id 78
    dw String_98_4070_00_39 ; id 79
    dw String_98_4070_00_39 ; id 80
    dw String_98_4070_00_39 ; id 81
    dw String_98_4070_00_39 ; id 82
    dw String_98_4070_00_39 ; id 83
    dw String_98_4070_00_39 ; id 84
    dw String_98_4070_00_39 ; id 85
    dw String_98_4070_00_39 ; id 86
    dw String_98_4070_00_39 ; id 87
    dw String_98_4070_00_39 ; id 88
    dw String_98_4070_00_39 ; id 89
    dw String_98_4070_00_39 ; id 90
    dw String_98_4070_00_39 ; id 91
    dw String_98_4070_00_39 ; id 92
    dw String_98_4070_00_39 ; id 93
    dw String_98_4070_00_39 ; id 94
    dw String_98_4070_00_39 ; id 95
    dw String_98_4070_00_39 ; id 96
    dw String_98_4070_00_39 ; id 97
    dw String_98_4070_00_39 ; id 98
    dw String_98_4070_00_39 ; id 99
    dw String_98_4070_00_39 ; id 100
    dw String_98_4070_00_39 ; id 101
    dw String_98_4070_00_39 ; id 102
    dw String_98_4070_00_39 ; id 103
    dw String_98_4070_00_39 ; id 104
    dw String_98_4070_00_39 ; id 105
    dw String_98_4070_00_39 ; id 106
    dw String_98_4070_00_39 ; id 107
    dw String_98_4070_00_39 ; id 108
    dw String_98_4070_00_39 ; id 109
    dw String_98_4070_00_39 ; id 110
    dw String_98_4070_00_39 ; id 111
    dw String_98_4070_00_39 ; id 112

String_98_4070_00_00::
    db $ea, "*: A woodsman came", $f1
    db "by a while back.", $fa, $f7
    db $ef, $ee, "He said something", $ef, $ee, "very disturbing.", $fa, $f7
    db $ef, $ee, "He was in the big", $ef, $ee, "forest, which is", $fa, $f7
    db $ef, $ee, "across the bridge", $ef, $ee, "south of town.", $fa, $f7
    db $ef, $ee, "He claims to have", $ef, $ee, "been chased by the", $fa, $f7
    db $ef, $ee, "ghost of a young", $ef, $ee, "woman.", $fa, $f7
    db $ef, $ee, "The forest looks", $ef, $ee, "ordinary, but", $a4, $f7
    db $f0

String_98_4070_00_01::
    db $ea, "*: Hello! How may I", $f1
    db "serve you?", $f7
    db $f0

String_98_4070_00_02::
    db $ea, "*: The lake is", $f1
    db "frozen, so I can't", $fa, $f7
    db $ef, $ee, "very well take my", $ef, $ee, "boat out.", $fa, $f7
    db $ef, $ee, "The north winds", $ef, $ee, "seem to be unduly", $fa, $f7
    db $ef, $ee, "harsh this year", $ef, $ee, "for some reason.", $f7
    db $f0

String_98_4070_00_03::
    db $ea, "*: This is Westania", $f1
    db "Castle.", $fa, $f7
    db $ef, $ee, "Westania is the", $ef, $ee, "kingdom to the", $fa, $f7
    db $ef, $ee, "west of the lake.", $ef, $ee, $f7
    db $f0

String_98_4070_00_04::
    db $ea, "*: Nobody fails to", $f1
    db "be impressed when", $fa, $f7
    db $ef, $ee, "I breathe fire,", $ef, $ee, "and I mean nobody!", $fa, $f7
    db $ef, $ee, "I'm sure Lady Yuna", $ef, $ee, "will be delighted", $fa, $f7
    db $ef, $ee, "when she sees my", $ef, $ee, "act.", $f7
    db $f0

String_98_4070_00_05::
    db $ea, "*: I've brought with", $f1
    db "me a necklace that", $fa, $f7
    db $ef, $ee, "is studded with", $ef, $ee, "jewels.", $fa, $f7
    db $ef, $ee, "Any woman would be", $ef, $ee, "delighted by it!", $f7
    db $f0

String_98_4070_00_06::
    db $ea, "*: When I balance", $f1
    db "on my ball, people", $fa, $f7
    db $ef, $ee, "simply go wild.", $ef, $ee, "Just watch me!", $f7
    db $f0

String_98_4070_00_07::
    db $ea, "*: I hurl knives", $f1
    db "with incredible", $fa, $f7
    db $ef, $ee, "accuracy.", $ef, $ee, "I never miss!", $fa, $f7
    db $ef, $ee, "Even Lady Yuna", $ef, $ee, "will be surprised.", $fa, $f7
    db $ef, $ee, "That'll snap her", $ef, $ee, "out of her funk.", $f7
    db $f0

String_98_4070_00_08::
    db $ea, "*: Please, line up!", $f1
    db "And quit pushing!", $fa, $f7
    db $ef, $ee, "Everyone will get", $ef, $ee, "their turn.", $fa, $f7
    db $ef, $ee, $a4, "Sigh", $a4, " Everyone is", $ef, $ee, "after the reward", $a4, $f7
    db $f0

String_98_4070_00_09::
    db $ea, "*: Oh", $a4, " Lady Yuna", $a4, $f1
    db "To think that I", $fa, $f7
    db $ef, $ee, "won't get to see", $ef, $ee, "your smile again", $a4, $fa, $f7
    db $ef, $ee, "Oh, it's the end", $ef, $ee, "of the world! Huh?", $fa, $f7
    db $ef, $ee, "Gaaah! What are", $ef, $ee, "you doing here?", $fa, $f7
    db $ef, $ee, "You shouldn't be", $ef, $ee, "eavesdropping!", $f7
    db $f0

String_98_4070_00_0A::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Come all who have", $ef, $ee, "the confidence to", $fa, $f7
    db $ef, $ee, "delight Lady Yuna", $ef, $ee, "out of depression.", $fa, $f7
    db $ef, $ee, "Anyone restoring", $ef, $ee, "joyous laughter to", $fa, $f7
    db $ef, $ee, "her will receive a", $ef, $ee, "generous reward.", $95, $f7
    db $f0

String_98_4070_00_0B::
    db $ea, "Kameha: Well, if", $f1
    db "it isn't ", $f9, "0!", $fa, $f7
    db $ef, $ee, "You managed to get", $ef, $ee, "out of the Castle,", $fa, $f7
    db $ef, $ee, "did you? You can", $ef, $ee, "thank me for it.", $fa, $f7
    db $ef, $ee, "I let you have the", $ef, $ee, "glory last time,", $fa, $f7
    db $ef, $ee, "but this time, it", $ef, $ee, "will be mine!", $f7
    db $f0

String_98_4070_00_0C::
    db $ea, "*: It's a mean old", $f1
    db "world out there.", $fa, $f7
    db $ef, $ee, "I've heard there", $ef, $ee, "are even monsters", $fa, $f7
    db $ef, $ee, "in our midsts.", $ef, $ee, "It's frightening.", $fa, $f7
    db $ef, $ee, "You should record", $ef, $ee, "in your Journal", $fa, $f7
    db $ef, $ee, "whenever you do", $ef, $ee, "anything of note.", $f7
    db $f0

String_98_4070_00_0D::
    db $ea, "*: The Castle is in", $f1
    db "an uproar.", $f7
    db $f0

String_98_4070_00_0E::
    db $ea, "*: Lady Yuna used", $f1
    db "to be very lively.", $fa, $f7
    db $ef, $ee, "It makes no sense,", $ef, $ee, "her depression.", $f7
    db $f0

String_98_4070_00_0F::
    db $ea, "*: In the east", $f1
    db "lives an old man", $fa, $f7
    db $ef, $ee, "who had tutored", $ef, $ee, "Lady Yuna.", $fa, $f7
    db $ef, $ee, "He knows about her", $ef, $ee, "the best.", $f7
    db $f0

String_98_4070_00_10::
    db $ea, "*: What happened to", $f1
    db "Lady Yuna?", $fa, $f7
    db $ef, $ee, "It's as if she is", $ef, $ee, "a soulless puppet", $a4, $f7
    db $f0

String_98_4070_00_11::
    db $ea, "*: Before, Lady", $f1
    db "Yuna would be up", $fa, $f7
    db $ef, $ee, "and out playing at", $ef, $ee, "sunrise.", $fa, $f7
    db $ef, $ee, "But now, she never", $ef, $ee, "ventures out", $a4, $f7
    db $f0

String_98_4070_00_12::
    db $ea, "*: This leads to", $f1
    db "Lady Yuna's room.", $fa, $f7
    db $ef, $ee, "You may not go", $ef, $ee, "beyond here.", $f7
    db $f0

String_98_4070_00_13::
    db $ea, "*: You're here to", $f1
    db "cheer Lady Yuna.", $fa, $f7
    db $ef, $ee, "Please go right", $ef, $ee, "through.", $f7
    db $f0

String_98_4070_00_14::
    db $ea, "*: You're here to", $f1
    db "cheer Lady Yuna.", $fa, $f7
    db $ef, $ee, "Oh? Your monsters", $ef, $ee, "are not healthy.", $fa, $f7
    db $ef, $ee, "That won't do. No,", $ef, $ee, "not at all.", $fa, $f7
    db $ef, $ee, "You'll have to", $ef, $ee, "leave, I'm afraid.", $f7
    db $f0

String_98_4070_00_15::
    db $ea, "*: You're here to", $f1
    db "cheer Lady Yuna.", $fa, $f7
    db $ef, $ee, "Oh? You haven't", $ef, $ee, "three monsters?", $fa, $f7
    db $ef, $ee, "Your show can't be", $ef, $ee, "very impressive.", $fa, $f7
    db $ef, $ee, "You'll have to", $ef, $ee, "leave, I'm afraid.", $f7
    db $f0

String_98_4070_00_16::
    db $eb, "*: Enough", $a4, " Enough", $f1
    db "of that dancing!", $f7
    db $f0

String_98_4070_00_17::
    db $ea, "*: I am the King.", $f1
    db "What is your act?", $f7
    db $f0

String_98_4070_00_18::
    db $ea, "King: Magnificent!", $f1
    db "Don't you agree?", $f7
    db $f0

String_98_4070_00_19::
    db $eb, "*: ", $a4, $a4, $a4, $a4, $f1
    db $f7
    db $f0

String_98_4070_00_1A::
    db $ea, "King: ", $a4, "Sigh", $a4, $f1
    db "Not even this", $a4, $fa, $f7
    db $ef, $ee, "You were superb,", $ef, $ee, "but Yuna didn't", $fa, $f7
    db $ef, $ee, "appear to be much", $ef, $ee, "impressed", $a4, $fa, $f7
    db $ef, $ee, "She used to be", $ef, $ee, "full of laughter", $a4, $fa, $f7
    db $ef, $ee, "It happened so", $ef, $ee, "quickly.", $fa, $f7
    db $ef, $ee, "She came back to", $ef, $ee, "the castle like", $fa, $f7
    db $ef, $ee, "that one day and", $ef, $ee, "hasn't been the", $fa, $f7
    db $ef, $ee, "same ever since", $ef, $ee, "then.", $fa, $f7
    db $ef, $ee, "No one has any", $ef, $ee, "idea what to do", $a4, $f7
    db $f0

String_98_4070_00_1B::
    db $ea, "*: Many have tried", $f1
    db "to cheer Lady Yuna", $fa, $f7
    db $ef, $ee, "up to the way she", $ef, $ee, "was before.", $fa, $f7
    db $ef, $ee, "However, none have", $ef, $ee, "succeeded.", $fa, $f7
    db $ef, $ee, "Will we ever see", $ef, $ee, "her smile again?", $f7
    db $f0

String_98_4070_00_1C::
    db $ea, "*: This is the", $f1
    db "Castle of Estria,", $fa, $f7
    db $ef, $ee, "the eastern", $ef, $ee, "kingdom.", $f7
    db $f0

String_98_4070_00_1D::
    db $ea, "*: Queen Helen came", $f1
    db "by a while ago, so", $fa, $f7
    db $ef, $ee, "I greeted her. But", $ef, $ee, "she said nothing", $fa, $f7
    db $ef, $ee, "and walked by", $ef, $ee, "without notice.", $fa, $f7
    db $ef, $ee, "She used to greet", $ef, $ee, "us warmly before", $a4, $f7
    db $f0

String_98_4070_00_1E::
    db $eb, "*: The spirit's", $f1
    db "spring has frozen.", $fa, $f7
    db $ef, $ee, "The lake is full", $ef, $ee, "of ice too.", $fa, $f7
    db $ef, $ee, "These are terrible", $ef, $ee, "omens", $a4, $f7
    db $f0

String_98_4070_00_1F::
    db $ea, "*: Queen Helen's", $f1
    db "dreams come true.", $fa, $f7
    db $ef, $ee, "If she hadn't", $ef, $ee, "dreamed of this,", $fa, $f7
    db $ef, $ee, "we would've fared", $ef, $ee, "much worse.", $f7
    db $f0

String_98_4070_00_20::
    db $ea, "*: Our Queen is a", $f1
    db "kind person who", $fa, $f7
    db $ef, $ee, "has a friendly", $ef, $ee, "word for everyone,", $fa, $f7
    db $ef, $ee, "but lately she", $ef, $ee, "looks grim", $a4, $f7
    db $f0

String_98_4070_00_21::
    db $eb, "*: A teacher from", $f1
    db "the west lives", $fa, $f7
    db $ef, $ee, "over there.", $ef, $ee, "He once was a", $fa, $f7
    db $ef, $ee, "tutor to the west's", $ef, $ee, "princess.", $f7
    db $f0

String_98_4070_00_22::
    db $ea, "*: There is a", $f1
    db "spring in the far", $fa, $f7
    db $ef, $ee, "north that is home", $ef, $ee, "to a spirit.", $fa, $f7
    db $ef, $ee, "The spirit lends", $ef, $ee, "us the power to", $fa, $f7
    db $ef, $ee, "survive in these", $ef, $ee, "harsh conditions.", $f7
    db $f0

String_98_4070_00_23::
    db $eb, "*: I heard this on", $f1
    db "the sly from my", $fa, $f7
    db $ef, $ee, "sister who works", $ef, $ee, "in the Castle.", $fa, $f7
    db $ef, $ee, "Queen Helen is", $ef, $ee, "very upset over", $fa, $f7
    db $ef, $ee, "ominous dreams.", $ef, $ee, "They must be bad", $fa, $f7
    db $ef, $ee, "to keep her from", $ef, $ee, "sleeping.", $fa, $f7
    db $ef, $ee, "That's why she", $ef, $ee, "seems so cranky", $a4, $f7
    db $f0

String_98_4070_00_24::
    db $ea, "*: The Queen looks", $f1
    db "haggard recently.", $fa, $f7
    db $ef, $ee, "Lack of sleep must", $ef, $ee, "be very taxing.", $fa, $f7
    db $ef, $ee, "She has been", $ef, $ee, "rather irritable.", $f7
    db $f0

String_98_4070_00_25::
    db $eb, "*: Around these", $f1
    db "parts, there are", $fa, $f7
    db $ef, $ee, "times of perpetual", $ef, $ee, "days", $a4, " And nights", $a4, $fa, $f7
    db $ef, $ee, "It can be hard to", $ef, $ee, "sleep properly.", $fa, $f7
    db $ef, $ee, "I use a potion", $ef, $ee, "made by a scholar", $fa, $f7
    db $ef, $ee, "when I can't sleep.", $ef, $ee, "It works!", $f7
    db $f0

String_98_4070_00_26::
    db $ea, "*: This is no place", $f1
    db "for a child!", $f7
    db $f0

String_98_4070_00_27::
    db $ea, "*: Oh? An envoy", $f1
    db "from the spirit!", $f7
    db $f0

String_98_4070_00_28::
    db $ea, "*: I beg your", $f1
    db "pardon, please!", $f7
    db $f0

String_98_4070_00_29::
    db $ea, "*: Hello! What may", $f1
    db "I do for you?", $f7
    db $f0

String_98_4070_00_2A::
    db $eb, "*: A botanist does", $f1
    db "live here", $a4, $fa, $f7
    db $ef, $ee, "But he's been gone", $ef, $ee, "for quite some", $fa, $f7
    db $ef, $ee, "time on a research", $ef, $ee, "trip of some sort.", $fa, $f7
    db $ef, $ee, "Who knows where he", $ef, $ee, "could be now.", $f7
    db $f0

String_98_4070_00_2B::
    db $ea, "*: I retired as a", $f1
    db "teacher and came", $fa, $f7
    db $ef, $ee, "back home.", $ef, $ee, "But yes, I tutored", $fa, $f7
    db $ef, $ee, "Lady Yuna in the", $ef, $ee, "western kingdom.", $fa, $f7
    db $ef, $ee, "It brings back", $ef, $ee, "some memories", $a4, $fa, $f7
    db $ef, $ee, "Will you hear this", $ef, $ee, "old man reminisce?", $ff, $f0

String_98_4070_00_2C::
    db $ea, "*: Lady Yuna was a", $f1
    db "rambunctious soul.", $fa, $f7
    db $ef, $ee, "She was much more", $ef, $ee, "likely to be out", $fa, $f7
    db $ef, $ee, "playing in forests", $ef, $ee, "with animals than", $fa, $f7
    db $ef, $ee, "staying cooped up", $ef, $ee, "in the castle.", $fa, $f7
    db $ef, $ee, "She used to climb", $ef, $ee, "out of her room on", $fa, $f7
    db $ef, $ee, "vines outside her", $ef, $ee, "window.", $fa, $f7
    db $ef, $ee, "She often went to", $ef, $ee, "the forest south", $fa, $f7
    db $ef, $ee, "of the castle. She", $ef, $ee, "liked it there.", $fa, $f7
    db $ef, $ee, "Ah, good memories", $ef, $ee, "indeed! Fwohohoho!", $f7
    db $f0

String_98_4070_00_2D::
    db $ea, "*: Oh, you're rushed", $f1
    db "for time", $a4, " Sorry", $a4, $f7
    db $f0

String_98_4070_00_2E::
    db $ea, "*: I want to return", $f1
    db "to the north, but", $fa, $f7
    db $ef, $ee, "there are no ships", $ef, $ee, "sailing.", $fa, $f7
    db $ef, $ee, "The mountains in", $ef, $ee, "the north are too", $fa, $f7
    db $ef, $ee, "treacherous to", $ef, $ee, "attempt crossing.", $f7
    db $f0

String_98_4070_00_2F::
    db $ea, "*: Queen Helen has", $f1
    db "been suffering", $fa, $f7
    db $ef, $ee, "from nightmares", $ef, $ee, "terribly.", $fa, $f7
    db $ef, $ee, "They don't let her", $ef, $ee, "sleep.", $fa, $f7
    db $ef, $ee, "We're concerned", $ef, $ee, "for her health", $a4, $f7
    db $f0

String_98_4070_00_30::
    db $eb, "*: ", $a4, $a4, $a4, $a4, "?", $f7
    db $f0

String_98_4070_00_39::
    db $f0

StringCategories_98_572E::
MessageStrings_Bank2C_Overflow::
    dw StringList_98_5730 ; id 0

; category list of StringCategories_98_572E; one pointer per wStringIndex (E-0217)
StringList_98_5730::
    dw String_98_572E_00_00 ; id 0
    dw String_98_572E_00_01 ; id 1
    dw String_98_572E_00_02 ; id 2
    dw String_98_572E_00_03 ; id 3
    dw String_98_572E_00_04 ; id 4
    dw String_98_572E_00_05 ; id 5
    dw String_98_572E_00_06 ; id 6
    dw String_98_572E_00_07 ; id 7
    dw String_98_572E_00_08 ; id 8
    dw String_98_572E_00_09 ; id 9
    dw String_98_572E_00_0A ; id 10
    dw String_98_572E_00_0B ; id 11
    dw String_98_572E_00_0C ; id 12
    dw String_98_572E_00_0D ; id 13
    dw String_98_572E_00_0E ; id 14
    dw String_98_572E_00_0F ; id 15
    dw String_98_572E_00_10 ; id 16
    dw String_98_572E_00_11 ; id 17
    dw String_98_572E_00_12 ; id 18
    dw String_98_572E_00_13 ; id 19
    dw String_98_572E_00_14 ; id 20
    dw String_98_572E_00_15 ; id 21
    dw String_98_572E_00_16 ; id 22
    dw String_98_572E_00_17 ; id 23
    dw String_98_572E_00_18 ; id 24
    dw String_98_572E_00_19 ; id 25
    dw String_98_572E_00_1A ; id 26
    dw String_98_572E_00_1A ; id 27
    dw String_98_572E_00_1A ; id 28
    dw String_98_572E_00_1A ; id 29
    dw String_98_572E_00_1A ; id 30
    dw String_98_572E_00_1A ; id 31
    dw String_98_572E_00_20 ; id 32
    dw String_98_572E_00_21 ; id 33
    dw String_98_572E_00_22 ; id 34
    dw String_98_572E_00_23 ; id 35
    dw String_98_572E_00_24 ; id 36
    dw String_98_572E_00_25 ; id 37
    dw String_98_572E_00_26 ; id 38
    dw String_98_572E_00_27 ; id 39
    dw String_98_572E_00_28 ; id 40
    dw String_98_572E_00_29 ; id 41
    dw String_98_572E_00_2A ; id 42
    dw String_98_572E_00_2B ; id 43
    dw String_98_572E_00_2C ; id 44
    dw String_98_572E_00_2D ; id 45
    dw String_98_572E_00_2E ; id 46
    dw String_98_572E_00_2F ; id 47
    dw String_98_572E_00_30 ; id 48
    dw String_98_572E_00_31 ; id 49
    dw String_98_572E_00_32 ; id 50
    dw String_98_572E_00_33 ; id 51
    dw String_98_572E_00_34 ; id 52
    dw String_98_572E_00_35 ; id 53
    dw String_98_572E_00_36 ; id 54
    dw String_98_572E_00_37 ; id 55
    dw String_98_572E_00_38 ; id 56
    dw String_98_572E_00_39 ; id 57
    dw String_98_572E_00_3A ; id 58
    dw String_98_572E_00_3B ; id 59
    dw String_98_572E_00_3C ; id 60
    dw String_98_572E_00_3D ; id 61
    dw String_98_572E_00_3E ; id 62
    dw String_98_572E_00_3F ; id 63
    dw String_98_572E_00_40 ; id 64
    dw String_98_572E_00_41 ; id 65
    dw String_98_572E_00_42 ; id 66
    dw String_98_572E_00_42 ; id 67
    dw String_98_572E_00_42 ; id 68
    dw String_98_572E_00_42 ; id 69
    dw String_98_572E_00_42 ; id 70
    dw String_98_572E_00_42 ; id 71
    dw String_98_572E_00_42 ; id 72
    dw String_98_572E_00_42 ; id 73
    dw String_98_572E_00_42 ; id 74
    dw String_98_572E_00_42 ; id 75
    dw String_98_572E_00_42 ; id 76
    dw String_98_572E_00_42 ; id 77
    dw String_98_572E_00_42 ; id 78
    dw String_98_572E_00_42 ; id 79
    dw String_98_572E_00_42 ; id 80
    dw String_98_572E_00_42 ; id 81
    dw String_98_572E_00_42 ; id 82
    dw String_98_572E_00_42 ; id 83
    dw String_98_572E_00_42 ; id 84
    dw String_98_572E_00_42 ; id 85
    dw String_98_572E_00_42 ; id 86
    dw String_98_572E_00_42 ; id 87
    dw String_98_572E_00_42 ; id 88
    dw String_98_572E_00_42 ; id 89
    dw String_98_572E_00_42 ; id 90
    dw String_98_572E_00_42 ; id 91
    dw String_98_572E_00_42 ; id 92
    dw String_98_572E_00_42 ; id 93
    dw String_98_572E_00_42 ; id 94
    dw String_98_572E_00_42 ; id 95
    dw String_98_572E_00_42 ; id 96
    dw String_98_572E_00_42 ; id 97
    dw String_98_572E_00_42 ; id 98
    dw String_98_572E_00_42 ; id 99
    dw String_98_572E_00_42 ; id 100
    dw String_98_572E_00_42 ; id 101
    dw String_98_572E_00_42 ; id 102
    dw String_98_572E_00_42 ; id 103
    dw String_98_572E_00_42 ; id 104
    dw String_98_572E_00_42 ; id 105
    dw String_98_572E_00_42 ; id 106
    dw String_98_572E_00_42 ; id 107
    dw String_98_572E_00_42 ; id 108
    dw String_98_572E_00_42 ; id 109
    dw String_98_572E_00_42 ; id 110

String_98_572E_00_00::
    db $ea, "*: Wa-hey! Can you", $f1
    db "hear me, ", $f9, "0?", $fa, $f7
    db $ef, $ee, "Things have turned", $ef, $ee, "serious, warooh!", $fa, $f7
    db $ef, $ee, "I'll bring you back", $ef, $ee, "to GreatLog.", $fa, $f7
    db $ef, $ee, "Don't move!", $ef, $ee, $f7
    db $f0

String_98_572E_00_01::
    db $ea, "*: Some time ago,", $f1
    db "lightning struck", $fa, $f7
    db $ef, $ee, "the tower, causing", $ef, $ee, "it to buckle.", $fa, $f7
    db $ef, $ee, "A huge bird flew", $ef, $ee, "out of the rubble.", $f7
    db $f0

String_98_572E_00_02::
    db $ea, "*: Who disturbs my", $f1
    db "sleep?", $fa, $f7
    db $ef, $ee, "The visitor from", $ef, $ee, "another world.", $fa, $f7
    db $ef, $ee, "I no longer feel", $ef, $ee, "the LightOrb's", $fa, $f7
    db $ef, $ee, "presence in this", $ef, $ee, "world.", $fa, $f7
    db $ef, $ee, "The Orb will no", $ef, $ee, "longer be a cause", $fa, $f7
    db $ef, $ee, "of strife in our", $ef, $ee, "world", $a4, $f7
    db $f0

String_98_572E_00_03::
    db $ea, "*: I heard on my", $f1
    db "travels that the", $fa, $f7
    db $ef, $ee, "monster King has", $ef, $ee, "disappeared.", $fa, $f7
    db $ef, $ee, "Where could he", $ef, $ee, "have gone?", $fa, $f7
    db $ef, $ee, "Well, it's not a", $ef, $ee, "bad thing.", $f7
    db $f0

String_98_572E_00_04::
    db $ea, "*: The monster King", $f1
    db "disappeared.", $fa, $f7
    db $ef, $ee, "He", $44, " made monsters", $ef, $ee, "obey using magic.", $f7
    db $f0

String_98_572E_00_05::
    db $ea, "*: When the monster", $f1
    db "King disappeared,", $fa, $f7
    db $ef, $ee, "we all gained our", $ef, $ee, "freedom.", $fa, $f7
    db $ef, $ee, "But everyone's been", $ef, $ee, "having so much fun", $fa, $f7
    db $ef, $ee, "treasure hunting,", $ef, $ee, "no one's quit!", $f7
    db $f0

String_98_572E_00_06::
    db $ea, "*: The Castle is", $f1
    db "now managed by all", $fa, $f7
    db $ef, $ee, "of us in the town.", $ef, $ee, $f7
    db $f0

String_98_572E_00_07::
    db $ea, "*: Rumor has it", $f1
    db "that almost no one", $fa, $f7
    db $ef, $ee, "has seen the", $ef, $ee, "monster King.", $fa, $f7
    db $ef, $ee, "Maybe he looked", $ef, $ee, "weak and frail.", $f7
    db $f0

String_98_572E_00_08::
    db $ea, "*: Where has our", $f1
    db "King gone?", $f7
    db $f0

String_98_572E_00_09::
    db $ea, "*: There's no point", $f1
    db "staying in the", $fa, $f7
    db $ef, $ee, "army. I should go", $ef, $ee, "back home.", $f7
    db $f0

String_98_572E_00_0A::
    db $ea, "*: If I had the", $f1
    db "LightOrb, even I", $fa, $f7
    db $ef, $ee, "could become the", $ef, $ee, "King of monsters.", $fa, $f7
    db $ef, $ee, "Could you please", $ef, $ee, "tell me where I", $fa, $f7
    db $ef, $ee, "could find the", $ef, $ee, "LightOrb?", $f7
    db $f0

String_98_572E_00_0B::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Town of Hitano", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Where treasure", $ef, $ee, "hunters gather.", $95, $f7
    db $f0

String_98_572E_00_0C::
    db $ea, "*: The Mayor is", $f1
    db "beyond here.", $fa, $f7
    db $ef, $ee, "Please watch your", $ef, $ee, "manners.", $f7
    db $f0

String_98_572E_00_0D::
    db $ea, "*: I've become the", $f1
    db "Mayor, but what", $fa, $f7
    db $ef, $ee, "exactly should I", $ef, $ee, "be doing?", $f7
    db $f0

String_98_572E_00_0E::
    db $f9, "0 released the", $f1
    db "grave's button.", $f7
    db $f0

String_98_572E_00_0F::
    db $ea, "*: The castle's lord", $f1
    db "summons monsters", $a4, $f7
    db $f0

String_98_572E_00_10::
    db $ea, "*: A button hides", $f1
    db "behind a grave", $a4, $fa, $f7
    db $ef, $ee, "A button that", $ef, $ee, "opens a door", $a4, $f7
    db $f0

String_98_572E_00_11::
    db $f9, "0 checked", $f1
    db "behind the grave.", $fa, $f7
    db $ef, $ee, "There was nothing", $ef, $ee, "of interest.", $f7
    db $f0

String_98_572E_00_12::
    db $ea, "*: The King's gone.", $f1
    db "What should I do?", $fa, $f7
    db $ef, $ee, "I guess there's no", $ef, $ee, "Sirloin for me.", $f7
    db $f0

String_98_572E_00_13::
    db $ea, "*: South beyond the", $f1
    db "mountains is the", $fa, $f7
    db $ef, $ee, "King's castle.", $ef, $ee, "I understand that", $fa, $f7
    db $ef, $ee, "it's bustling with", $ef, $ee, "treasure hunters.", $f7
    db $f0

String_98_572E_00_14::
    db $ea, "*: Several ancient", $f1
    db "ruins remain in", $fa, $f7
    db $ef, $ee, "the southern part", $ef, $ee, "of the continent.", $fa, $f7
    db $ef, $ee, "Treasures may be", $ef, $ee, "hidden in them.", $f7
    db $f0

String_98_572E_00_15::
    db $ea, "*: I was taking a", $f1
    db "walk outside with", $fa, $f7
    db $ef, $ee, "my friend Roboster", $ef, $ee, "when he was almost", $fa, $f7
    db $ef, $ee, "taken away by a", $ef, $ee, "giant MadCondor.", $fa, $f7
    db $ef, $ee, "I think it was his", $ef, $ee, "shiny metal body", $fa, $f7
    db $ef, $ee, "that attracted the", $ef, $ee, "bird.", $fa, $f7
    db $ef, $ee, "That may mean", $ef, $ee, "lamps and armor", $fa, $f7
    db $ef, $ee, "will also draw the", $ef, $ee, "bird's attention.", $f7
    db $f0

String_98_572E_00_16::
    db $ea, "*: ", $a4, $a4, "This way", $a4, $f1
    db $a4, "Here", $a4, " ", $a4, "Here", $a4, $f7
    db $f0

String_98_572E_00_17::
    db $eb, "*: ", $a4, "Where is my", $f1
    db "casket", $a4, " Where", $a4, $fa, $f7
    db $ef, $ee, "Ring the bell", $a4, $ef, $ee, $a4, "Please", $a4, $f7
    db $f0

String_98_572E_00_18::
    db $f9, "0 checked the", $f1
    db "notice.", $fa, $f7
    db $ef, $ee, "'Guide the lost", $ef, $ee, "souls", $a4, $95, $f7
    db $f0

String_98_572E_00_19::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Determine where", $ef, $ee, "you will land", $fa, $f7
    db $ef, $ee, "before flying", $ef, $ee, "off.", $95, $f7
    db $f0

String_98_572E_00_1A::
    db $eb, "*: I lost again.", $f1
    db "I need to train my", $fa, $f7
    db $ef, $ee, "monsters a lot", $ef, $ee, "more to win.", $fa, $f7
    db $ef, $ee, "I'll have to go", $ef, $ee, "back to a world", $fa, $f7
    db $ef, $ee, "I've already", $ef, $ee, "finished, and", $fa, $f7
    db $ef, $ee, "raise their levels", $ef, $ee, "some more.", $fa, $f7
    db $ef, $ee, "There might be", $ef, $ee, "something new for", $fa, $f7
    db $ef, $ee, "me to discover.", $ef, $ee, "Who knows?", $f7
    db $f0

String_98_572E_00_20::
    db $eb, "*: Good! Let's get", $f1
    db "started!", $f7
    db $f0

String_98_572E_00_21::
    db $eb, "*: I'll be here for", $f1
    db "a while longer.", $fa, $f7
    db $ef, $ee, "If you change your", $ef, $ee, "mind, come back.", $f7
    db $f0

String_98_572E_00_22::
    db $eb, "*: I lost again.", $f1
    db "I need to train my", $fa, $f7
    db $ef, $ee, "monsters a lot", $ef, $ee, "more to win.", $fa, $f7
    db $ef, $ee, "I'll have to go", $ef, $ee, "back to a world", $fa, $f7
    db $ef, $ee, "I've already", $ef, $ee, "finished, and", $fa, $f7
    db $ef, $ee, "raise their levels", $ef, $ee, "some more.", $fa, $f7
    db $ef, $ee, "There might be", $ef, $ee, "something new for", $fa, $f7
    db $ef, $ee, "me to discover.", $ef, $ee, "Who knows?", $f7
    db $f0

String_98_572E_00_23::
    db $eb, "*: When you breed,", $f1
    db "the offspring", $fa, $f7
    db $ef, $ee, "inherit the", $ef, $ee, "parents' skills", $fa, $f7
    db $ef, $ee, "and abilities.", $ef, $ee, "So, you're better", $fa, $f7
    db $ef, $ee, "off breeding", $ef, $ee, "monsters.", $f7
    db $f0

String_98_572E_00_24::
    db $ea, "*: Do you know all", $f1
    db "the kinds of meat?", $fa, $f7
    db $ef, $ee, "There's BeefJerky,", $ef, $ee, "PorkChop, Rib and", $fa, $f7
    db $ef, $ee, "then there's", $ef, $ee, "Sirloin.", $fa, $f7
    db $ef, $ee, "Sirloin is the", $ef, $ee, "ultimate!", $fa, $f7
    db $ef, $ee, "So tender and", $ef, $ee, "heavenly tasty!", $f7
    db $f0

String_98_572E_00_25::
    db $ea, "*: If you eat any", $f1
    db "BadMeat like me,", $fa, $f7
    db $ef, $ee, "you'll get", $ef, $ee, "poisoned.", $f7
    db $f0

String_98_572E_00_26::
    db $ea, "*: Hm? Little one,", $f1
    db "are you a master?", $fa, $f7
    db $ef, $ee, "How would you like", $ef, $ee, "to breed one of", $fa, $f7
    db $ef, $ee, "your monsters with", $ef, $ee, "my Armorpede?", $ff, $f0

String_98_572E_00_27::
    db $ea, "*: Good! Let's get", $f1
    db "this started!", $f7
    db $f0

String_98_572E_00_28::
    db $ea, "*: Oh, too bad.", $f1
    db "Another time.", $fa, $f7
    db $ef, $ee, "Tell me if you", $ef, $ee, "change your mind.", $f7
    db $f0

String_98_572E_00_29::
    db $ea, "*: If you get an", $f1
    db "EvilArmor, I", $44, $fa, $f7
    db $ef, $ee, "breed it with a", $ef, $ee, "material family", $fa, $f7
    db $ef, $ee, "partner. It's a", $ef, $ee, "tough combo.", $f7
    db $f0

String_98_572E_00_2A::
    db $ea, "*: NoctoKing is my", $f1
    db "name!", $fa, $f7
    db $ef, $ee, "Darkness is my", $ef, $ee, "domain!", $fa, $f7
    db $ef, $ee, "Perchance, do you", $ef, $ee, "know a skill named", $fa, $f7
    db $ef, $ee, "Ahhh? Its effects", $ef, $ee, "differ markedly", $fa, $f7
    db $ef, $ee, "depending on the", $ef, $ee, "gender.", $f7
    db $f0

String_98_572E_00_2B::
    db $ea, "*: I learned how to", $f1
    db "Massacre!", $fa, $f7
    db $ef, $ee, "But I ended up", $ef, $ee, "clocking my mates", $fa, $f7
    db $ef, $ee, "pretty good too.", $ef, $ee, "Ehehe.", $f7
    db $f0

String_98_572E_00_2C::
    db $ea, "*: Yo! Up close,", $f1
    db "you look tougher", $fa, $f7
    db $ef, $ee, "than you first", $ef, $ee, "appeared.", $fa, $f7
    db $ef, $ee, "Want to breed a", $ef, $ee, "monster with my", $fa, $f7
    db $ef, $ee, "WildApe? Does", $ef, $ee, "that sound good?", $ff, $f0

String_98_572E_00_2D::
    db $ea, "*: I like your", $f1
    db "style!", $fa, $f7
    db $ef, $ee, "Let's get started", $ef, $ee, "with this.", $f7
    db $f0

String_98_572E_00_2E::
    db $ea, "*: What? Are you", $f1
    db "sure about that?", $f7
    db $f0

String_98_572E_00_2F::
    db $ea, "*: All righty!", $f1
    db $fa, $f7
    db $ef, $ee, $f3, "We'll do this again", $ef, $ee, "next time too!", $f7
    db $f0

String_98_572E_00_30::
    db $ea, "*: Arr, matey!", $f1
    db "I'm CaptDead!", $fa, $f7
    db $ef, $ee, "A dashing zombie", $ef, $ee, "of the open seas!", $fa, $f7
    db $ef, $ee, "If I CallHelp, my", $ef, $ee, "trusty crew will", $fa, $f7
    db $ef, $ee, "come running,", $ef, $ee, "cutlasses ready!", $f7
    db $f0

String_98_572E_00_31::
    db $ea, "*: I strike with my", $f1
    db "eight tentacles.", $fa, $f7
    db $ef, $ee, "That means I hit", $ef, $ee, "eight times!", $f7
    db $f0

String_98_572E_00_32::
    db $eb, "*: Welcome. I'm the", $f1
    db "Christener.", $fa, $f7
    db $ef, $ee, "I can rename your", $ef, $ee, "monsters here.", $fa, $f7
    db $ef, $ee, "Do you wish to", $ef, $ee, "rename one?", $f0

String_98_572E_00_33::
    db $eb, "*: Welcome. I'm the", $f1
    db "Christener.", $fa, $f7
    db $ef, $ee, "Do you wish to", $ef, $ee, "rename someone?", $f0

String_98_572E_00_34::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Handbook on", $ef, $ee, "Naming", $a4, $fa, $f7
    db $ef, $ee, "Using a part of", $ef, $ee, "the species name", $fa, $f7
    db $ef, $ee, "enables easier", $ef, $ee, "identification.", $95, $f7
    db $f0

String_98_572E_00_35::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Handbook on", $ef, $ee, "Naming", $a4, $fa, $f7
    db $ef, $ee, "Borrowing from the", $ef, $ee, "parents' names", $fa, $f7
    db $ef, $ee, "adds to the weight", $ef, $ee, "of a name.", $95, $f7
    db $f0

String_98_572E_00_36::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Handbook on", $ef, $ee, "Naming", $a4, $fa, $f7
    db $ef, $ee, "A string of the", $ef, $ee, "same character", $fa, $f7
    db $ef, $ee, "makes a terrible", $ef, $ee, "name. Where is", $fa, $f7
    db $ef, $ee, "your love for your", $ef, $ee, "monster?", $95, $f7
    db $f0

String_98_572E_00_37::
    db $ea, "*: I was once a", $f1
    db "great master who", $fa, $f7
    db $ef, $ee, "traveled from", $ef, $ee, "world to world.", $fa, $f7
    db $ef, $ee, "I used that key to", $ef, $ee, "reach a world.", $fa, $f7
    db $ef, $ee, "You have your own", $ef, $ee, "Magic Keys, yes?", $ff, $f0

String_98_572E_00_38::
    db $ea, "*: Have you shown", $f1
    db "them to the Key", $fa, $f7
    db $ef, $ee, "Shop's boss?", $ef, $ee, "He'll make it so", $fa, $f7
    db $ef, $ee, "you can go to", $ef, $ee, "other worlds.", $f7
    db $f0

String_98_572E_00_39::
    db $ea, "*: You've not found", $f1
    db "any yet?", $fa, $f7
    db $ef, $ee, "That's a", $ef, $ee, "rotten shame", $a4, $fa, $f7
    db $ef, $ee, "Fine, look on the", $ef, $ee, "shelf there.", $fa, $f7
    db $ef, $ee, "You can take one", $ef, $ee, "of my keys.", $f7
    db $f0

String_98_572E_00_3A::
    db $ea, "*: That key, I used", $f1
    db "on my travels to", $fa, $f7
    db $ef, $ee, "other worlds in my", $ef, $ee, "youth.", $fa, $f7
    db $ef, $ee, "It brings back", $ef, $ee, "memories.", $fa, $f7
    db $ef, $ee, "No, you may not", $ef, $ee, "have it.", $f7
    db $f0

String_98_572E_00_3B::
    db $f9, "0 checked the", $f1
    db "shelf.", $fa, $f7
    db $ef, $ee, "Souvenirs from", $ef, $ee, "other worlds", $fa, $f7
    db $ef, $ee, "covered the shelf", $ef, $ee, "haphazardly.", $f7
    db $f0

String_98_572E_00_3C::
    db $f9, "0 checked the", $f1
    db "shelf.", $fa, $f7
    db $ef, $ee, $f9, "0 obtained a", $ef, $ee, "Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_98_572E_00_3D::
    db $f9, "0 checked the", $f1
    db "shelf.", $fa, $f7
    db $ef, $ee, $f9, "0 found a", $ef, $ee, "Magic Key.", $fa, $f7
    db $ef, $ee, "But the key ring", $ef, $ee, "was full.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "Magic Key back.", $f7
    db $f0

String_98_572E_00_3E::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "It was full of", $ef, $ee, "esoteric junk.", $f7
    db $f0

String_98_572E_00_3F::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Monster Arena,", $ef, $ee, "where masters meet", $fa, $f7
    db $ef, $ee, "for battle!", $ef, $ee, "Downstairs!", $95, $f7
    db $f0

String_98_572E_00_40::
    db $ea, "*: There are times", $f1
    db "when you have to", $fa, $f7
    db $ef, $ee, "take weak monsters", $ef, $ee, "out and about.", $fa, $f7
    db $ef, $ee, "If you want to", $ef, $ee, "avoid battles,", $fa, $f7
    db $ef, $ee, "sprinkle on some", $ef, $ee, "Repellent.", $f7
    db $f0

String_98_572E_00_41::
    db $ea, "*: Up ahead is the", $f1
    db "Starry Shrine and", $fa, $f7
    db $ef, $ee, "the Egg Evaluator's", $ef, $ee, "room.", $fa, $f7
    db $ef, $ee, "Both facilities", $ef, $ee, "are absolutely", $fa, $f7
    db $ef, $ee, "indispensable to", $ef, $ee, "masters.", $fa, $f7
    db $ef, $ee, "But they're only", $ef, $ee, "open to certified", $fa, $f7
    db $ef, $ee, "masters, and no", $ef, $ee, "one else.", $f7
    db $f0

String_98_572E_00_42::
    db $f0

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_98_7032::
MessageStrings_Bank89_Overflow::
    dw StringList_98_7034 ; id 0

; category list of StringCategories_98_7032; one pointer per wStringIndex (E-0217)
; record: string
StringList_98_7034::
    dw String_98_7032_00_00 ; id 0
    dw String_98_7032_00_01 ; id 1
    dw String_98_7032_00_02 ; id 2
    dw String_98_7032_00_03 ; id 3
    dw String_98_7032_00_04 ; id 4
    dw String_98_7032_00_05 ; id 5
    dw String_98_7032_00_06 ; id 6
    dw String_98_7032_00_07 ; id 7
    dw String_98_7032_00_08 ; id 8
    dw String_98_7032_00_09 ; id 9
    dw String_98_7032_00_0A ; id 10
    dw String_98_7032_00_0B ; id 11
    dw String_98_7032_00_0C ; id 12
    dw String_98_7032_00_0D ; id 13
    dw String_98_7032_00_0E ; id 14
    dw String_98_7032_00_0F ; id 15
    dw String_98_7032_00_10 ; id 16
    dw String_98_7032_00_11 ; id 17
    dw String_98_7032_00_12 ; id 18
    dw String_98_7032_00_13 ; id 19
    dw String_98_7032_00_14 ; id 20
    dw String_98_7032_00_15 ; id 21
    dw String_98_7032_00_16 ; id 22
    dw String_98_7032_00_17 ; id 23
    dw String_98_7032_00_18 ; id 24
    dw String_98_7032_00_19 ; id 25
    dw String_98_7032_00_1A ; id 26
    dw String_98_7032_00_1B ; id 27
    dw String_98_7032_00_1B ; id 28
    dw String_98_7032_00_1B ; id 29
    dw String_98_7032_00_1B ; id 30
    dw String_98_7032_00_1B ; id 31
    dw String_98_7032_00_1B ; id 32
    dw String_98_7032_00_1B ; id 33

String_98_7032_00_00::
    db $ea, "*: What? You don't", $f1
    db "know about the", $fa, $f7
    db $ef, $ee, "Starry Shrine or", $ef, $ee, "the Egg Evaluator?", $fa, $f7
    db $ef, $ee, "Urrrgh", $a4, " Look them", $ef, $ee, "up at the Library.", $fa, $f7
    db $ef, $ee, "I'm not much good", $ef, $ee, "at explaining, but", $fa, $f7
    db $ef, $ee, "I've gotten you", $ef, $ee, "the word!", $f7
    db $f0

String_98_7032_00_01::
    db "A beautiful voice", $f1
    db "echoed", $a4, $f7
    db $f0

String_98_7032_00_02::
    db $eb, "Helen: I thank you", $f1
    db "from the heart.", $fa, $f7
    db $ef, $ee, "Please give my", $ef, $ee, "regards to the", $fa, $f7
    db $ef, $ee, "spirit in the", $ef, $ee, "spring.", $f7
    db $f0

String_98_7032_00_03::
    db $ea, "*: Seeing the", $f1
    db "liveliness of", $fa, $f7
    db $ef, $ee, "Lady Yuna lifts", $ef, $ee, "our spirits.", $f7
    db $f0

String_98_7032_00_04::
    db $f9, "0 checked the", $f1
    db "tombstone.", $fa, $f7
    db $ef, $ee, "There appeared to", $ef, $ee, "be nothing.", $f7
    db $f0

String_98_7032_00_05::
    db $ea, "*: The sea is huge", $f1
    db "and mysterious.", $fa, $f7
    db $ef, $ee, "There must be", $ef, $ee, "totally different", $fa, $f7
    db $ef, $ee, "monsters in the", $ef, $ee, "sea.", $f7
    db $f0

String_98_7032_00_06::
    db $ea, "*: Huh? Has the sea", $f1
    db "risen?", $fa, $f7
    db $ef, $ee, "Oh, well. I'm a", $ef, $ee, "good swimmer.", $f7
    db $f0

String_98_7032_00_07::
    db $ea, "*: The water flowed", $f1
    db "right over the", $fa, $f7
    db $ef, $ee, "ground almost", $ef, $ee, "instantly.", $fa, $f7
    db $ef, $ee, "Is GreatLog really", $ef, $ee, "safe?", $f7
    db $f0

String_98_7032_00_08::
    db "Look! A MadCondor!", $f1
    db "It has something!", $fa, $f7
    db $ef, $ee, "It clutched a", $ef, $ee, "glowing ball!", $f7
    db $f0

String_98_7032_00_09::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 20 species!", $fa, $f7
    db $ef, $ee, "Keep at it, and", $ef, $ee, "get some more!", $f7
    db $f0

String_98_7032_00_0A::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 30 species!", $fa, $f7
    db $ef, $ee, "You can check up", $ef, $ee, "on your monsters", $95, $fa, $f7
    db $ef, $ee, "cataloged data at", $ef, $ee, "the Library.", $f7
    db $f0

String_98_7032_00_0B::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 40 species!", $fa, $f7
    db $ef, $ee, "If the farm is", $ef, $ee, "full, you should", $fa, $f7
    db $ef, $ee, "try breeding some", $ef, $ee, "of your monsters.", $f7
    db $f0

String_98_7032_00_0C::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 50 species!", $fa, $f7
    db $ef, $ee, "By the way, I", $ef, $ee, "think Prince", $fa, $f7
    db $ef, $ee, "Kameha had some", $ef, $ee, "rare Magic Keys.", $f7
    db $f0

String_98_7032_00_0D::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 100 species!", $fa, $f7
    db $ef, $ee, "You've grown up a", $ef, $ee, "lot through this.", $fa, $f7
    db $ef, $ee, "I'm proud of you!", $ef, $ee, $f7
    db $f0

String_98_7032_00_0E::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 150 species!", $fa, $f7
    db $ef, $ee, "Have you met a boy", $ef, $ee, "named Terry?", $fa, $f7
    db $ef, $ee, "You should be good", $ef, $ee, "enough as a master", $fa, $f7
    db $ef, $ee, "to be worthy of", $ef, $ee, "his approval.", $f7
    db $f0

String_98_7032_00_0F::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 200 species!", $fa, $f7
    db $ef, $ee, "I doubt no one has", $ef, $ee, "cataloged as many", $fa, $f7
    db $ef, $ee, "monsters as you.", $ef, $ee, $a4, "What's that?", $fa, $f7
    db $ef, $ee, "Am I embarrassing", $ef, $ee, "you?", $f7
    db $f0

String_98_7032_00_10::
    db $ea, "*: Hey, ", $f9, "0!", $f1
    db "You've befriended", $fa, $f7
    db $ef, $ee, "a good number of", $ef, $ee, "monsters!", $fa, $f7
    db $ef, $ee, "You've got at", $ef, $ee, "least 250 species!", $fa, $f7
    db $ef, $ee, "I had no idea that", $ef, $ee, "there were so many", $fa, $f7
    db $ef, $ee, "distinct species", $ef, $ee, "of monsters. Even", $fa, $f7
    db $ef, $ee, "Professor Monster", $ef, $ee, "can't know them", $fa, $f7
    db $ef, $ee, "all.", $ef, $ee, $f7
    db $f0

String_98_7032_00_11::
    db $ea, "*: Congratulations,", $f1
    db $f9, "0!", $fa, $f7
    db $ef, $ee, "You've cataloged", $ef, $ee, "every species.", $fa, $f7
    db $ef, $ee, "There appear to", $ef, $ee, "be no monsters", $fa, $f7
    db $ef, $ee, "left to be caught", $ef, $ee, "and cataloged.", $fa, $f7
    db $ef, $ee, "You hung in for", $ef, $ee, "all this time.", $fa, $f7
    db $ef, $ee, "I'm sincerely", $ef, $ee, "proud of you.", $fa, $f7
    db $ef, $ee, $f9, "0, I'm counting", $ef, $ee, "on you to look", $fa, $f7
    db $ef, $ee, "after the farm and", $ef, $ee, "the monsters.", $f7
    db $f0

String_98_7032_00_12::
    db $eb, "*: Welcome to the", $f1
    db "Library!", $fa, $f7
    db $ef, $ee, "Your monster", $ef, $ee, "Catalog is done!", $e5, $4d, $f7
    db $e9, $ff, $f0

String_98_7032_00_13::
    db $eb, "*: We need fanfare", $f1
    db "right about now", $a4, $fa, $f7
    db $ef, $ee, "Congratulations,", $ef, $ee, "our little hero!", $fa, $f7
    db $ef, $ee, "Here is your newly", $ef, $ee, "filled Catalog!", $fa, $f7
    db $ef, $ee, "Which family would", $ef, $ee, "you like to check?", $f7
    db $f0

String_98_7032_00_14::
    db $ea, "*: The weather has", $f1
    db "been mild.", $fa, $f7
    db $ef, $ee, "It's a good thing.", $ef, $ee, $f7
    db $f0

String_98_7032_00_15::
    db $ea, "*: Lady Yuna has", $f1
    db "come out of her", $fa, $f7
    db $ef, $ee, "depression. I've", $ef, $ee, "heard.", $fa, $f7
    db $ef, $ee, "When it comes to", $ef, $ee, "rumors, good ones", $fa, $f7
    db $ef, $ee, "are the best, I", $ef, $ee, "have to say.", $f7
    db $f0

String_98_7032_00_16::
    db $ea, "*: The Queen's lost", $f1
    db "her scary look!", $f7
    db $f0

String_98_7032_00_17::
    db $ea, "*: The kingdoms of", $f1
    db "the north and west", $fa, $f7
    db $ef, $ee, "have reconciled", $ef, $ee, "from their ugly", $fa, $f7
    db $ef, $ee, "squabble over the", $ef, $ee, "mine.", $f7
    db $f0

String_98_7032_00_18::
    db $ea, "*: The scholar who", $f1
    db "was in the tavern?", $fa, $f7
    db $ef, $ee, "I think he went", $ef, $ee, "back home.", $f7
    db $f0

String_98_7032_00_19::
    db $ea, "Warubou: Wa-hey?", $f1
    db "Feel that, warooh?", $fa, $f7
    db $ef, $ee, "Did something", $ef, $ee, "shake?", $f7
    db $f0

String_98_7032_00_1A::
    db $ea, "*: ZZZZZ", $a4, " Ssss", $a4, $f1
    db "ZZZZZ", $a4, " Ssss", $a4, $f7
    db $f0

String_98_7032_00_1B::
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
    db "0000000000000000000000000000000000"
