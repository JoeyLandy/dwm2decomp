; ROM bank $98: string tables
; The annotated listing of this bank is build/listing/bank98.asm.

SECTION "Bank 98", ROMX[$4000], BANK[$98]
    db $98

; Overflow half of the string lookup of message bank $2B: lowers wStringIndex by $8A (the first
; index the bank-$2B table does not hold), then BeginStringDisplay with DE =
; MessageStrings_Bank2B_Overflow, so the text printer starts on string (index - $8A) of category
; wStringCategory in this bank. Far-called by BeginStringDisplay_Bank2B when wStringIndex is $8A or
; more. (C1, E-0385)
; overflow for message bank $2B: wStringIndex -= $8A, then BeginStringDisplay with the table
; MessageStrings_Bank2B_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2B_Overflow::
    ld de, MessageStrings_Bank2B_Overflow
    ld a, [wStringIndex]
    sub $8a
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; Overflow half of the string copy of message bank $2B: lowers wStringIndex by $8A (the first index
; the bank-$2B table does not hold), then CopyStringToBuffer with DE =
; MessageStrings_Bank2B_Overflow, which copies string (index - $8A) of category wStringCategory,
; with its $F0 end byte, to the address in wStringDestLo/wStringDestHi (LookupString also stores
; this bank number in wStringBank). Far-called by CopyStringToBuffer_Bank2B when wStringIndex is $8A
; or more. The wrapper CopyStringToBuffer_Bank2B that far-calls it is not called by name anywhere in
; src/, so no path to it is known. (C2, E-0385)
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

; Overflow half of the string lookup of message bank $2C: lowers wStringIndex by $91 (the first
; index the bank-$2C table does not hold), then BeginStringDisplay with DE =
; MessageStrings_Bank2C_Overflow, so the text printer starts on string (index - $91) of category
; wStringCategory in this bank. Far-called by BeginStringDisplay_Bank2C when wStringIndex is $91 or
; more. (C1, E-0385)
; overflow for message bank $2C: wStringIndex -= $91, then BeginStringDisplay with the table
; MessageStrings_Bank2C_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2C_Overflow::
    ld de, MessageStrings_Bank2C_Overflow
    ld a, [wStringIndex]
    sub $91
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; Overflow half of the string copy of message bank $2C: lowers wStringIndex by $91 (the first index
; the bank-$2C table does not hold), then CopyStringToBuffer with DE =
; MessageStrings_Bank2C_Overflow, which copies string (index - $91) of category wStringCategory,
; with its $F0 end byte, to the address in wStringDestLo/wStringDestHi (LookupString also stores
; this bank number in wStringBank). Far-called by CopyStringToBuffer_Bank2C when wStringIndex is $91
; or more. The wrapper CopyStringToBuffer_Bank2C that far-calls it is not called by name anywhere in
; src/, so no path to it is known. (C2, E-0385)
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

; Overflow half of the string lookup of message bank $89: lowers wStringIndex by $DE (the first
; index the bank-$89 table does not hold), then BeginStringDisplay with DE =
; MessageStrings_Bank89_Overflow, so the text printer starts on string (index - $DE) of category
; wStringCategory in this bank. Far-called by BeginStringDisplay_Bank89 when wStringIndex is $DE or
; more. (C1, E-0385)
; overflow for message bank $89: wStringIndex -= $DE, then BeginStringDisplay with the table
; MessageStrings_Bank89_Overflow in this bank (E-0080)
BeginStringDisplay_Bank89_Overflow::
    ld de, MessageStrings_Bank89_Overflow
    ld a, [wStringIndex]
    sub $de
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; Overflow half of the string copy of message bank $89: lowers wStringIndex by $DE (the first index
; the bank-$89 table does not hold), then CopyStringToBuffer with DE =
; MessageStrings_Bank89_Overflow, which copies string (index - $DE) of category wStringCategory,
; with its $F0 end byte, to the address in wStringDestLo/wStringDestHi (LookupString also stores
; this bank number in wStringBank). Far-called by CopyStringToBuffer_Bank89 when wStringIndex is $DE
; or more. The wrapper CopyStringToBuffer_Bank89 that far-calls it is not called by name anywhere in
; src/, so no path to it is known. (C2, E-0385)
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
StringCategories_98::
; another name for the data at StringCategories_98, whose note is above (E-0381)
MessageStrings_Bank2B_Overflow::
    dw StringList_Bank2B_Overflow_0 ; id 0

; category list of StringCategories_98; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2B_Overflow_0::
    dw Text_AWoodsmanCameBy ; id 0
    dw Text_HelloHowMayI ; id 1
    dw Text_TheLakeIsFrozen ; id 2
    dw Text_ThisIsWestaniaCastle ; id 3
    dw Text_NobodyFailsToBe ; id 4
    dw Text_IveBroughtWithMe ; id 5
    dw Text_WhenIBalanceOn ; id 6
    dw Text_IHurlKnivesWith ; id 7
    dw Text_PleaseLineUpAnd ; id 8
    dw Text_OhLadyYunaTo ; id 9
    dw Text_ReadTheSignCome ; id 10
    dw Text_KamehaWellIfIt ; id 11
    dw Text_ItsAMeanOld ; id 12
    dw Text_TheCastleIsIn ; id 13
    dw Text_LadyYunaUsedTo ; id 14
    dw Text_InTheEastLives ; id 15
    dw Text_WhatHappenedToLady ; id 16
    dw Text_BeforeLadyYunaWould ; id 17
    dw Text_ThisLeadsToLady ; id 18
    dw Text_YoureHereToCheer ; id 19
    dw Text_YoureHereToCheer_2 ; id 20
    dw Text_YoureHereToCheer_3 ; id 21
    dw Text_EnoughEnoughOfThat ; id 22
    dw Text_IAmTheKing ; id 23
    dw Text_KingMagnificentDontYou ; id 24
    dw Text_LineWait ; id 25
    dw Text_KingSighNotEven ; id 26
    dw Text_ManyHaveTriedTo ; id 27
    dw Text_ThisIsTheCastle ; id 28
    dw Text_QueenHelenCameBy ; id 29
    dw Text_TheSpiritsSpringHas ; id 30
    dw Text_QueenHelensDreamsCome ; id 31
    dw Text_OurQueenIsA ; id 32
    dw Text_ATeacherFromThe ; id 33
    dw Text_ThereIsASpring ; id 34
    dw Text_IHeardThisOn ; id 35
    dw Text_TheQueenLooksHaggard ; id 36
    dw Text_AroundThesePartsThere ; id 37
    dw Text_ThisIsNoPlace ; id 38
    dw Text_OhAnEnvoyFrom ; id 39
    dw Text_IBegYourPardon ; id 40
    dw Text_HelloWhatMayI ; id 41
    dw Text_ABotanistDoesLive ; id 42
    dw Text_IRetiredAsA ; id 43
    dw Text_LadyYunaWasA ; id 44
    dw Text_OhYoureRushedFor ; id 45
    dw Text_IWantToReturn ; id 46
    dw Text_QueenHelenHasBeen ; id 47
    dw Text_Wait_2 ; id 48
    dw Text_Wait_2 ; id 49
    dw Text_Wait_2 ; id 50
    dw Text_Wait_2 ; id 51
    dw Text_Wait_2 ; id 52
    dw Text_Wait_2 ; id 53
    dw Text_Wait_2 ; id 54
    dw Text_Wait_2 ; id 55
    dw Text_Wait_2 ; id 56
    dw Text_Empty_6 ; id 57
    dw Text_Empty_6 ; id 58
    dw Text_Empty_6 ; id 59
    dw Text_Empty_6 ; id 60
    dw Text_Empty_6 ; id 61
    dw Text_Empty_6 ; id 62
    dw Text_Empty_6 ; id 63
    dw Text_Empty_6 ; id 64
    dw Text_Empty_6 ; id 65
    dw Text_Empty_6 ; id 66
    dw Text_Empty_6 ; id 67
    dw Text_Empty_6 ; id 68
    dw Text_Empty_6 ; id 69
    dw Text_Empty_6 ; id 70
    dw Text_Empty_6 ; id 71
    dw Text_Empty_6 ; id 72
    dw Text_Empty_6 ; id 73
    dw Text_Empty_6 ; id 74
    dw Text_Empty_6 ; id 75
    dw Text_Empty_6 ; id 76
    dw Text_Empty_6 ; id 77
    dw Text_Empty_6 ; id 78
    dw Text_Empty_6 ; id 79
    dw Text_Empty_6 ; id 80
    dw Text_Empty_6 ; id 81
    dw Text_Empty_6 ; id 82
    dw Text_Empty_6 ; id 83
    dw Text_Empty_6 ; id 84
    dw Text_Empty_6 ; id 85
    dw Text_Empty_6 ; id 86
    dw Text_Empty_6 ; id 87
    dw Text_Empty_6 ; id 88
    dw Text_Empty_6 ; id 89
    dw Text_Empty_6 ; id 90
    dw Text_Empty_6 ; id 91
    dw Text_Empty_6 ; id 92
    dw Text_Empty_6 ; id 93
    dw Text_Empty_6 ; id 94
    dw Text_Empty_6 ; id 95
    dw Text_Empty_6 ; id 96
    dw Text_Empty_6 ; id 97
    dw Text_Empty_6 ; id 98
    dw Text_Empty_6 ; id 99
    dw Text_Empty_6 ; id 100
    dw Text_Empty_6 ; id 101
    dw Text_Empty_6 ; id 102
    dw Text_Empty_6 ; id 103
    dw Text_Empty_6 ; id 104
    dw Text_Empty_6 ; id 105
    dw Text_Empty_6 ; id 106
    dw Text_Empty_6 ; id 107
    dw Text_Empty_6 ; id 108
    dw Text_Empty_6 ; id 109
    dw Text_Empty_6 ; id 110
    dw Text_Empty_6 ; id 111
    dw Text_Empty_6 ; id 112

Text_AWoodsmanCameBy::
    db "<VOICE1>*: A woodsman came<LINE>"
    db "by a while back.<PROMPT>"
    db "<NEXT>He said something"
    db "<NEXT>very disturbing.<PROMPT>"
    db "<NEXT>He was in the big"
    db "<NEXT>forest, which is<PROMPT>"
    db "<NEXT>across the bridge"
    db "<NEXT>south of town.<PROMPT>"
    db "<NEXT>He claims to have"
    db "<NEXT>been chased by the<PROMPT>"
    db "<NEXT>ghost of a young"
    db "<NEXT>woman.<PROMPT>"
    db "<NEXT>The forest looks"
    db "<NEXT>ordinary, but…<WAIT>"
    db "@"

Text_HelloHowMayI::
    db "<VOICE1>*: Hello! How may I<LINE>"
    db "serve you?<WAIT>"
    db "@"

Text_TheLakeIsFrozen::
    db "<VOICE1>*: The lake is<LINE>"
    db "frozen, so I can't<PROMPT>"
    db "<NEXT>very well take my"
    db "<NEXT>boat out.<PROMPT>"
    db "<NEXT>The north winds"
    db "<NEXT>seem to be unduly<PROMPT>"
    db "<NEXT>harsh this year"
    db "<NEXT>for some reason.<WAIT>"
    db "@"

Text_ThisIsWestaniaCastle::
    db "<VOICE1>*: This is Westania<LINE>"
    db "Castle.<PROMPT>"
    db "<NEXT>Westania is the"
    db "<NEXT>kingdom to the<PROMPT>"
    db "<NEXT>west of the lake."
    db "<NEXT><WAIT>"
    db "@"

Text_NobodyFailsToBe::
    db "<VOICE1>*: Nobody fails to<LINE>"
    db "be impressed when<PROMPT>"
    db "<NEXT>I breathe fire,"
    db "<NEXT>and I mean nobody!<PROMPT>"
    db "<NEXT>I'm sure Lady Yuna"
    db "<NEXT>will be delighted<PROMPT>"
    db "<NEXT>when she sees my"
    db "<NEXT>act.<WAIT>"
    db "@"

Text_IveBroughtWithMe::
    db "<VOICE1>*: I've brought with<LINE>"
    db "me a necklace that<PROMPT>"
    db "<NEXT>is studded with"
    db "<NEXT>jewels.<PROMPT>"
    db "<NEXT>Any woman would be"
    db "<NEXT>delighted by it!<WAIT>"
    db "@"

Text_WhenIBalanceOn::
    db "<VOICE1>*: When I balance<LINE>"
    db "on my ball, people<PROMPT>"
    db "<NEXT>simply go wild."
    db "<NEXT>Just watch me!<WAIT>"
    db "@"

Text_IHurlKnivesWith::
    db "<VOICE1>*: I hurl knives<LINE>"
    db "with incredible<PROMPT>"
    db "<NEXT>accuracy."
    db "<NEXT>I never miss!<PROMPT>"
    db "<NEXT>Even Lady Yuna"
    db "<NEXT>will be surprised.<PROMPT>"
    db "<NEXT>That'll snap her"
    db "<NEXT>out of her funk.<WAIT>"
    db "@"

Text_PleaseLineUpAnd::
    db "<VOICE1>*: Please, line up!<LINE>"
    db "And quit pushing!<PROMPT>"
    db "<NEXT>Everyone will get"
    db "<NEXT>their turn.<PROMPT>"
    db "<NEXT>…Sigh… Everyone is"
    db "<NEXT>after the reward…<WAIT>"
    db "@"

Text_OhLadyYunaTo::
    db "<VOICE1>*: Oh… Lady Yuna…<LINE>"
    db "To think that I<PROMPT>"
    db "<NEXT>won't get to see"
    db "<NEXT>your smile again…<PROMPT>"
    db "<NEXT>Oh, it's the end"
    db "<NEXT>of the world! Huh?<PROMPT>"
    db "<NEXT>Gaaah! What are"
    db "<NEXT>you doing here?<PROMPT>"
    db "<NEXT>You shouldn't be"
    db "<NEXT>eavesdropping!<WAIT>"
    db "@"

Text_ReadTheSignCome::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Come all who have"
    db "<NEXT>the confidence to<PROMPT>"
    db "<NEXT>delight Lady Yuna"
    db "<NEXT>out of depression.<PROMPT>"
    db "<NEXT>Anyone restoring"
    db "<NEXT>joyous laughter to<PROMPT>"
    db "<NEXT>her will receive a"
    db "<NEXT>generous reward.", $95, "<WAIT>"
    db "@"

Text_KamehaWellIfIt::
    db "<VOICE1>Kameha: Well, if<LINE>"
    db "it isn't <BUF0>!<PROMPT>"
    db "<NEXT>You managed to get"
    db "<NEXT>out of the Castle,<PROMPT>"
    db "<NEXT>did you? You can"
    db "<NEXT>thank me for it.<PROMPT>"
    db "<NEXT>I let you have the"
    db "<NEXT>glory last time,<PROMPT>"
    db "<NEXT>but this time, it"
    db "<NEXT>will be mine!<WAIT>"
    db "@"

Text_ItsAMeanOld::
    db "<VOICE1>*: It's a mean old<LINE>"
    db "world out there.<PROMPT>"
    db "<NEXT>I've heard there"
    db "<NEXT>are even monsters<PROMPT>"
    db "<NEXT>in our midsts."
    db "<NEXT>It's frightening.<PROMPT>"
    db "<NEXT>You should record"
    db "<NEXT>in your Journal<PROMPT>"
    db "<NEXT>whenever you do"
    db "<NEXT>anything of note.<WAIT>"
    db "@"

Text_TheCastleIsIn::
    db "<VOICE1>*: The Castle is in<LINE>"
    db "an uproar.<WAIT>"
    db "@"

Text_LadyYunaUsedTo::
    db "<VOICE1>*: Lady Yuna used<LINE>"
    db "to be very lively.<PROMPT>"
    db "<NEXT>It makes no sense,"
    db "<NEXT>her depression.<WAIT>"
    db "@"

Text_InTheEastLives::
    db "<VOICE1>*: In the east<LINE>"
    db "lives an old man<PROMPT>"
    db "<NEXT>who had tutored"
    db "<NEXT>Lady Yuna.<PROMPT>"
    db "<NEXT>He knows about her"
    db "<NEXT>the best.<WAIT>"
    db "@"

Text_WhatHappenedToLady::
    db "<VOICE1>*: What happened to<LINE>"
    db "Lady Yuna?<PROMPT>"
    db "<NEXT>It's as if she is"
    db "<NEXT>a soulless puppet…<WAIT>"
    db "@"

Text_BeforeLadyYunaWould::
    db "<VOICE1>*: Before, Lady<LINE>"
    db "Yuna would be up<PROMPT>"
    db "<NEXT>and out playing at"
    db "<NEXT>sunrise.<PROMPT>"
    db "<NEXT>But now, she never"
    db "<NEXT>ventures out…<WAIT>"
    db "@"

Text_ThisLeadsToLady::
    db "<VOICE1>*: This leads to<LINE>"
    db "Lady Yuna's room.<PROMPT>"
    db "<NEXT>You may not go"
    db "<NEXT>beyond here.<WAIT>"
    db "@"

Text_YoureHereToCheer::
    db "<VOICE1>*: You're here to<LINE>"
    db "cheer Lady Yuna.<PROMPT>"
    db "<NEXT>Please go right"
    db "<NEXT>through.<WAIT>"
    db "@"

Text_YoureHereToCheer_2::
    db "<VOICE1>*: You're here to<LINE>"
    db "cheer Lady Yuna.<PROMPT>"
    db "<NEXT>Oh? Your monsters"
    db "<NEXT>are not healthy.<PROMPT>"
    db "<NEXT>That won't do. No,"
    db "<NEXT>not at all.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>leave, I'm afraid.<WAIT>"
    db "@"

Text_YoureHereToCheer_3::
    db "<VOICE1>*: You're here to<LINE>"
    db "cheer Lady Yuna.<PROMPT>"
    db "<NEXT>Oh? You haven't"
    db "<NEXT>three monsters?<PROMPT>"
    db "<NEXT>Your show can't be"
    db "<NEXT>very impressive.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>leave, I'm afraid.<WAIT>"
    db "@"

Text_EnoughEnoughOfThat::
    db "<VOICE2>*: Enough… Enough<LINE>"
    db "of that dancing!<WAIT>"
    db "@"

Text_IAmTheKing::
    db "<VOICE1>*: I am the King.<LINE>"
    db "What is your act?<WAIT>"
    db "@"

Text_KingMagnificentDontYou::
    db "<VOICE1>King: Magnificent!<LINE>"
    db "Don't you agree?<WAIT>"
    db "@"

Text_LineWait::
    db "<VOICE2>*: …………<LINE>"
    db "<WAIT>"
    db "@"

Text_KingSighNotEven::
    db "<VOICE1>King: …Sigh…<LINE>"
    db "Not even this…<PROMPT>"
    db "<NEXT>You were superb,"
    db "<NEXT>but Yuna didn't<PROMPT>"
    db "<NEXT>appear to be much"
    db "<NEXT>impressed…<PROMPT>"
    db "<NEXT>She used to be"
    db "<NEXT>full of laughter…<PROMPT>"
    db "<NEXT>It happened so"
    db "<NEXT>quickly.<PROMPT>"
    db "<NEXT>She came back to"
    db "<NEXT>the castle like<PROMPT>"
    db "<NEXT>that one day and"
    db "<NEXT>hasn't been the<PROMPT>"
    db "<NEXT>same ever since"
    db "<NEXT>then.<PROMPT>"
    db "<NEXT>No one has any"
    db "<NEXT>idea what to do…<WAIT>"
    db "@"

Text_ManyHaveTriedTo::
    db "<VOICE1>*: Many have tried<LINE>"
    db "to cheer Lady Yuna<PROMPT>"
    db "<NEXT>up to the way she"
    db "<NEXT>was before.<PROMPT>"
    db "<NEXT>However, none have"
    db "<NEXT>succeeded.<PROMPT>"
    db "<NEXT>Will we ever see"
    db "<NEXT>her smile again?<WAIT>"
    db "@"

Text_ThisIsTheCastle::
    db "<VOICE1>*: This is the<LINE>"
    db "Castle of Estria,<PROMPT>"
    db "<NEXT>the eastern"
    db "<NEXT>kingdom.<WAIT>"
    db "@"

Text_QueenHelenCameBy::
    db "<VOICE1>*: Queen Helen came<LINE>"
    db "by a while ago, so<PROMPT>"
    db "<NEXT>I greeted her. But"
    db "<NEXT>she said nothing<PROMPT>"
    db "<NEXT>and walked by"
    db "<NEXT>without notice.<PROMPT>"
    db "<NEXT>She used to greet"
    db "<NEXT>us warmly before…<WAIT>"
    db "@"

Text_TheSpiritsSpringHas::
    db "<VOICE2>*: The spirit's<LINE>"
    db "spring has frozen.<PROMPT>"
    db "<NEXT>The lake is full"
    db "<NEXT>of ice too.<PROMPT>"
    db "<NEXT>These are terrible"
    db "<NEXT>omens…<WAIT>"
    db "@"

Text_QueenHelensDreamsCome::
    db "<VOICE1>*: Queen Helen's<LINE>"
    db "dreams come true.<PROMPT>"
    db "<NEXT>If she hadn't"
    db "<NEXT>dreamed of this,<PROMPT>"
    db "<NEXT>we would've fared"
    db "<NEXT>much worse.<WAIT>"
    db "@"

Text_OurQueenIsA::
    db "<VOICE1>*: Our Queen is a<LINE>"
    db "kind person who<PROMPT>"
    db "<NEXT>has a friendly"
    db "<NEXT>word for everyone,<PROMPT>"
    db "<NEXT>but lately she"
    db "<NEXT>looks grim…<WAIT>"
    db "@"

Text_ATeacherFromThe::
    db "<VOICE2>*: A teacher from<LINE>"
    db "the west lives<PROMPT>"
    db "<NEXT>over there."
    db "<NEXT>He once was a<PROMPT>"
    db "<NEXT>tutor to the west's"
    db "<NEXT>princess.<WAIT>"
    db "@"

Text_ThereIsASpring::
    db "<VOICE1>*: There is a<LINE>"
    db "spring in the far<PROMPT>"
    db "<NEXT>north that is home"
    db "<NEXT>to a spirit.<PROMPT>"
    db "<NEXT>The spirit lends"
    db "<NEXT>us the power to<PROMPT>"
    db "<NEXT>survive in these"
    db "<NEXT>harsh conditions.<WAIT>"
    db "@"

Text_IHeardThisOn::
    db "<VOICE2>*: I heard this on<LINE>"
    db "the sly from my<PROMPT>"
    db "<NEXT>sister who works"
    db "<NEXT>in the Castle.<PROMPT>"
    db "<NEXT>Queen Helen is"
    db "<NEXT>very upset over<PROMPT>"
    db "<NEXT>ominous dreams."
    db "<NEXT>They must be bad<PROMPT>"
    db "<NEXT>to keep her from"
    db "<NEXT>sleeping.<PROMPT>"
    db "<NEXT>That's why she"
    db "<NEXT>seems so cranky…<WAIT>"
    db "@"

Text_TheQueenLooksHaggard::
    db "<VOICE1>*: The Queen looks<LINE>"
    db "haggard recently.<PROMPT>"
    db "<NEXT>Lack of sleep must"
    db "<NEXT>be very taxing.<PROMPT>"
    db "<NEXT>She has been"
    db "<NEXT>rather irritable.<WAIT>"
    db "@"

Text_AroundThesePartsThere::
    db "<VOICE2>*: Around these<LINE>"
    db "parts, there are<PROMPT>"
    db "<NEXT>times of perpetual"
    db "<NEXT>days… And nights…<PROMPT>"
    db "<NEXT>It can be hard to"
    db "<NEXT>sleep properly.<PROMPT>"
    db "<NEXT>I use a potion"
    db "<NEXT>made by a scholar<PROMPT>"
    db "<NEXT>when I can't sleep."
    db "<NEXT>It works!<WAIT>"
    db "@"

Text_ThisIsNoPlace::
    db "<VOICE1>*: This is no place<LINE>"
    db "for a child!<WAIT>"
    db "@"

Text_OhAnEnvoyFrom::
    db "<VOICE1>*: Oh? An envoy<LINE>"
    db "from the spirit!<WAIT>"
    db "@"

Text_IBegYourPardon::
    db "<VOICE1>*: I beg your<LINE>"
    db "pardon, please!<WAIT>"
    db "@"

Text_HelloWhatMayI::
    db "<VOICE1>*: Hello! What may<LINE>"
    db "I do for you?<WAIT>"
    db "@"

Text_ABotanistDoesLive::
    db "<VOICE2>*: A botanist does<LINE>"
    db "live here…<PROMPT>"
    db "<NEXT>But he's been gone"
    db "<NEXT>for quite some<PROMPT>"
    db "<NEXT>time on a research"
    db "<NEXT>trip of some sort.<PROMPT>"
    db "<NEXT>Who knows where he"
    db "<NEXT>could be now.<WAIT>"
    db "@"

Text_IRetiredAsA::
    db "<VOICE1>*: I retired as a<LINE>"
    db "teacher and came<PROMPT>"
    db "<NEXT>back home."
    db "<NEXT>But yes, I tutored<PROMPT>"
    db "<NEXT>Lady Yuna in the"
    db "<NEXT>western kingdom.<PROMPT>"
    db "<NEXT>It brings back"
    db "<NEXT>some memories…<PROMPT>"
    db "<NEXT>Will you hear this"
    db "<NEXT>old man reminisce?<CHOICE>"
    db "@"

Text_LadyYunaWasA::
    db "<VOICE1>*: Lady Yuna was a<LINE>"
    db "rambunctious soul.<PROMPT>"
    db "<NEXT>She was much more"
    db "<NEXT>likely to be out<PROMPT>"
    db "<NEXT>playing in forests"
    db "<NEXT>with animals than<PROMPT>"
    db "<NEXT>staying cooped up"
    db "<NEXT>in the castle.<PROMPT>"
    db "<NEXT>She used to climb"
    db "<NEXT>out of her room on<PROMPT>"
    db "<NEXT>vines outside her"
    db "<NEXT>window.<PROMPT>"
    db "<NEXT>She often went to"
    db "<NEXT>the forest south<PROMPT>"
    db "<NEXT>of the castle. She"
    db "<NEXT>liked it there.<PROMPT>"
    db "<NEXT>Ah, good memories"
    db "<NEXT>indeed! Fwohohoho!<WAIT>"
    db "@"

Text_OhYoureRushedFor::
    db "<VOICE1>*: Oh, you're rushed<LINE>"
    db "for time… Sorry…<WAIT>"
    db "@"

Text_IWantToReturn::
    db "<VOICE1>*: I want to return<LINE>"
    db "to the north, but<PROMPT>"
    db "<NEXT>there are no ships"
    db "<NEXT>sailing.<PROMPT>"
    db "<NEXT>The mountains in"
    db "<NEXT>the north are too<PROMPT>"
    db "<NEXT>treacherous to"
    db "<NEXT>attempt crossing.<WAIT>"
    db "@"

Text_QueenHelenHasBeen::
    db "<VOICE1>*: Queen Helen has<LINE>"
    db "been suffering<PROMPT>"
    db "<NEXT>from nightmares"
    db "<NEXT>terribly.<PROMPT>"
    db "<NEXT>They don't let her"
    db "<NEXT>sleep.<PROMPT>"
    db "<NEXT>We're concerned"
    db "<NEXT>for her health…<WAIT>"
    db "@"

Text_Wait_2::
    db "<VOICE2>*: …………?<WAIT>"
    db "@"

Text_Empty_6::
    db $f0

StringCategories_98_2::
; another name for the data at StringCategories_98_2, whose note is above (E-0381)
MessageStrings_Bank2C_Overflow::
    dw StringList_Bank2C_Overflow_0 ; id 0

; category list of StringCategories_98_2; one pointer per wStringIndex (E-0217)
StringList_Bank2C_Overflow_0::
    dw Text_WaHeyCanYou_2 ; id 0
    dw Text_SomeTimeAgoLightning ; id 1
    dw Text_WhoDisturbsMySleep ; id 2
    dw Text_IHeardOnMy ; id 3
    dw Text_TheMonsterKingDisappeared ; id 4
    dw Text_WhenTheMonsterKing ; id 5
    dw Text_TheCastleIsNow ; id 6
    dw Text_RumorHasItThat ; id 7
    dw Text_WhereHasOurKing ; id 8
    dw Text_TheresNoPointStaying ; id 9
    dw Text_IfIHadThe ; id 10
    dw Text_ReadTheSignTown ; id 11
    dw Text_TheMayorIsBeyond ; id 12
    dw Text_IveBecomeTheMayor ; id 13
    dw Text_ReleasedTheGravesButton ; id 14
    dw Text_TheCastlesLordSummons ; id 15
    dw Text_AButtonHidesBehind ; id 16
    dw Text_CheckedBehindTheGrave ; id 17
    dw Text_TheKingsGoneWhat ; id 18
    dw Text_SouthBeyondTheMountains ; id 19
    dw Text_SeveralAncientRuinsRemain ; id 20
    dw Text_IWasTakingA ; id 21
    dw Text_ThisWayHereHere ; id 22
    dw Text_WhereIsMyCasket ; id 23
    dw Text_CheckedTheNoticeGuide ; id 24
    dw Text_ReadTheSignDetermine ; id 25
    dw Text_ILostAgainI ; id 26
    dw Text_ILostAgainI ; id 27
    dw Text_ILostAgainI ; id 28
    dw Text_ILostAgainI ; id 29
    dw Text_ILostAgainI ; id 30
    dw Text_ILostAgainI ; id 31
    dw Text_GoodLetsGetStarted ; id 32
    dw Text_IllBeHereFor ; id 33
    dw Text_ILostAgainI_2 ; id 34
    dw Text_WhenYouBreedThe ; id 35
    dw Text_DoYouKnowAll ; id 36
    dw Text_IfYouEatAny ; id 37
    dw Text_HmLittleOneAre ; id 38
    dw Text_GoodLetsGetThis ; id 39
    dw Text_OhTooBadAnother ; id 40
    dw Text_IfYouGetAn ; id 41
    dw Text_NoctoKingIsMyName ; id 42
    dw Text_ILearnedHowTo ; id 43
    dw Text_YoUpCloseYou ; id 44
    dw Text_ILikeYourStyle ; id 45
    dw Text_WhatAreYouSure ; id 46
    dw Text_AllRightyWellDo ; id 47
    dw Text_ArrMateyImCaptDead ; id 48
    dw Text_IStrikeWithMy ; id 49
    dw Text_WelcomeImTheChristener ; id 50
    dw Text_WelcomeImTheChristener_2 ; id 51
    dw Text_CheckedTheBookshelfHandbook ; id 52
    dw Text_CheckedTheBookshelfHandbook_2 ; id 53
    dw Text_CheckedTheBookshelfHandbook_3 ; id 54
    dw Text_IWasOnceA ; id 55
    dw Text_HaveYouShownThem ; id 56
    dw Text_YouveNotFoundAny ; id 57
    dw Text_ThatKeyIUsed ; id 58
    dw Text_CheckedTheShelfSouvenirs ; id 59
    dw Text_CheckedTheShelfObtained ; id 60
    dw Text_CheckedTheShelfFound ; id 61
    dw Text_PeeredIntoTheVase_5 ; id 62
    dw Text_ReadTheSignMonster ; id 63
    dw Text_ThereAreTimesWhen ; id 64
    dw Text_UpAheadIsThe ; id 65
    dw Text_Empty_7 ; id 66
    dw Text_Empty_7 ; id 67
    dw Text_Empty_7 ; id 68
    dw Text_Empty_7 ; id 69
    dw Text_Empty_7 ; id 70
    dw Text_Empty_7 ; id 71
    dw Text_Empty_7 ; id 72
    dw Text_Empty_7 ; id 73
    dw Text_Empty_7 ; id 74
    dw Text_Empty_7 ; id 75
    dw Text_Empty_7 ; id 76
    dw Text_Empty_7 ; id 77
    dw Text_Empty_7 ; id 78
    dw Text_Empty_7 ; id 79
    dw Text_Empty_7 ; id 80
    dw Text_Empty_7 ; id 81
    dw Text_Empty_7 ; id 82
    dw Text_Empty_7 ; id 83
    dw Text_Empty_7 ; id 84
    dw Text_Empty_7 ; id 85
    dw Text_Empty_7 ; id 86
    dw Text_Empty_7 ; id 87
    dw Text_Empty_7 ; id 88
    dw Text_Empty_7 ; id 89
    dw Text_Empty_7 ; id 90
    dw Text_Empty_7 ; id 91
    dw Text_Empty_7 ; id 92
    dw Text_Empty_7 ; id 93
    dw Text_Empty_7 ; id 94
    dw Text_Empty_7 ; id 95
    dw Text_Empty_7 ; id 96
    dw Text_Empty_7 ; id 97
    dw Text_Empty_7 ; id 98
    dw Text_Empty_7 ; id 99
    dw Text_Empty_7 ; id 100
    dw Text_Empty_7 ; id 101
    dw Text_Empty_7 ; id 102
    dw Text_Empty_7 ; id 103
    dw Text_Empty_7 ; id 104
    dw Text_Empty_7 ; id 105
    dw Text_Empty_7 ; id 106
    dw Text_Empty_7 ; id 107
    dw Text_Empty_7 ; id 108
    dw Text_Empty_7 ; id 109
    dw Text_Empty_7 ; id 110

Text_WaHeyCanYou_2::
    db "<VOICE1>*: Wa-hey! Can you<LINE>"
    db "hear me, <BUF0>?<PROMPT>"
    db "<NEXT>Things have turned"
    db "<NEXT>serious, warooh!<PROMPT>"
    db "<NEXT>I'll bring you back"
    db "<NEXT>to GreatLog.<PROMPT>"
    db "<NEXT>Don't move!"
    db "<NEXT><WAIT>"
    db "@"

Text_SomeTimeAgoLightning::
    db "<VOICE1>*: Some time ago,<LINE>"
    db "lightning struck<PROMPT>"
    db "<NEXT>the tower, causing"
    db "<NEXT>it to buckle.<PROMPT>"
    db "<NEXT>A huge bird flew"
    db "<NEXT>out of the rubble.<WAIT>"
    db "@"

Text_WhoDisturbsMySleep::
    db "<VOICE1>*: Who disturbs my<LINE>"
    db "sleep?<PROMPT>"
    db "<NEXT>The visitor from"
    db "<NEXT>another world.<PROMPT>"
    db "<NEXT>I no longer feel"
    db "<NEXT>the LightOrb's<PROMPT>"
    db "<NEXT>presence in this"
    db "<NEXT>world.<PROMPT>"
    db "<NEXT>The Orb will no"
    db "<NEXT>longer be a cause<PROMPT>"
    db "<NEXT>of strife in our"
    db "<NEXT>world…<WAIT>"
    db "@"

Text_IHeardOnMy::
    db "<VOICE1>*: I heard on my<LINE>"
    db "travels that the<PROMPT>"
    db "<NEXT>monster King has"
    db "<NEXT>disappeared.<PROMPT>"
    db "<NEXT>Where could he"
    db "<NEXT>have gone?<PROMPT>"
    db "<NEXT>Well, it's not a"
    db "<NEXT>bad thing.<WAIT>"
    db "@"

Text_TheMonsterKingDisappeared::
    db "<VOICE1>*: The monster King<LINE>"
    db "disappeared.<PROMPT>"
    db "<NEXT>He", $44, " made monsters"
    db "<NEXT>obey using magic.<WAIT>"
    db "@"

Text_WhenTheMonsterKing::
    db "<VOICE1>*: When the monster<LINE>"
    db "King disappeared,<PROMPT>"
    db "<NEXT>we all gained our"
    db "<NEXT>freedom.<PROMPT>"
    db "<NEXT>But everyone's been"
    db "<NEXT>having so much fun<PROMPT>"
    db "<NEXT>treasure hunting,"
    db "<NEXT>no one's quit!<WAIT>"
    db "@"

Text_TheCastleIsNow::
    db "<VOICE1>*: The Castle is<LINE>"
    db "now managed by all<PROMPT>"
    db "<NEXT>of us in the town."
    db "<NEXT><WAIT>"
    db "@"

Text_RumorHasItThat::
    db "<VOICE1>*: Rumor has it<LINE>"
    db "that almost no one<PROMPT>"
    db "<NEXT>has seen the"
    db "<NEXT>monster King.<PROMPT>"
    db "<NEXT>Maybe he looked"
    db "<NEXT>weak and frail.<WAIT>"
    db "@"

Text_WhereHasOurKing::
    db "<VOICE1>*: Where has our<LINE>"
    db "King gone?<WAIT>"
    db "@"

Text_TheresNoPointStaying::
    db "<VOICE1>*: There's no point<LINE>"
    db "staying in the<PROMPT>"
    db "<NEXT>army. I should go"
    db "<NEXT>back home.<WAIT>"
    db "@"

Text_IfIHadThe::
    db "<VOICE1>*: If I had the<LINE>"
    db "LightOrb, even I<PROMPT>"
    db "<NEXT>could become the"
    db "<NEXT>King of monsters.<PROMPT>"
    db "<NEXT>Could you please"
    db "<NEXT>tell me where I<PROMPT>"
    db "<NEXT>could find the"
    db "<NEXT>LightOrb?<WAIT>"
    db "@"

Text_ReadTheSignTown::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Town of Hitano"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Where treasure"
    db "<NEXT>hunters gather.", $95, "<WAIT>"
    db "@"

Text_TheMayorIsBeyond::
    db "<VOICE1>*: The Mayor is<LINE>"
    db "beyond here.<PROMPT>"
    db "<NEXT>Please watch your"
    db "<NEXT>manners.<WAIT>"
    db "@"

Text_IveBecomeTheMayor::
    db "<VOICE1>*: I've become the<LINE>"
    db "Mayor, but what<PROMPT>"
    db "<NEXT>exactly should I"
    db "<NEXT>be doing?<WAIT>"
    db "@"

Text_ReleasedTheGravesButton::
    db "<BUF0> released the<LINE>"
    db "grave's button.<WAIT>"
    db "@"

Text_TheCastlesLordSummons::
    db "<VOICE1>*: The castle's lord<LINE>"
    db "summons monsters…<WAIT>"
    db "@"

Text_AButtonHidesBehind::
    db "<VOICE1>*: A button hides<LINE>"
    db "behind a grave…<PROMPT>"
    db "<NEXT>A button that"
    db "<NEXT>opens a door…<WAIT>"
    db "@"

Text_CheckedBehindTheGrave::
    db "<BUF0> checked<LINE>"
    db "behind the grave.<PROMPT>"
    db "<NEXT>There was nothing"
    db "<NEXT>of interest.<WAIT>"
    db "@"

Text_TheKingsGoneWhat::
    db "<VOICE1>*: The King's gone.<LINE>"
    db "What should I do?<PROMPT>"
    db "<NEXT>I guess there's no"
    db "<NEXT>Sirloin for me.<WAIT>"
    db "@"

Text_SouthBeyondTheMountains::
    db "<VOICE1>*: South beyond the<LINE>"
    db "mountains is the<PROMPT>"
    db "<NEXT>King's castle."
    db "<NEXT>I understand that<PROMPT>"
    db "<NEXT>it's bustling with"
    db "<NEXT>treasure hunters.<WAIT>"
    db "@"

Text_SeveralAncientRuinsRemain::
    db "<VOICE1>*: Several ancient<LINE>"
    db "ruins remain in<PROMPT>"
    db "<NEXT>the southern part"
    db "<NEXT>of the continent.<PROMPT>"
    db "<NEXT>Treasures may be"
    db "<NEXT>hidden in them.<WAIT>"
    db "@"

Text_IWasTakingA::
    db "<VOICE1>*: I was taking a<LINE>"
    db "walk outside with<PROMPT>"
    db "<NEXT>my friend Roboster"
    db "<NEXT>when he was almost<PROMPT>"
    db "<NEXT>taken away by a"
    db "<NEXT>giant MadCondor.<PROMPT>"
    db "<NEXT>I think it was his"
    db "<NEXT>shiny metal body<PROMPT>"
    db "<NEXT>that attracted the"
    db "<NEXT>bird.<PROMPT>"
    db "<NEXT>That may mean"
    db "<NEXT>lamps and armor<PROMPT>"
    db "<NEXT>will also draw the"
    db "<NEXT>bird's attention.<WAIT>"
    db "@"

Text_ThisWayHereHere::
    db "<VOICE1>*: ……This way…<LINE>"
    db "…Here… …Here…<WAIT>"
    db "@"

Text_WhereIsMyCasket::
    db "<VOICE2>*: …Where is my<LINE>"
    db "casket… Where…<PROMPT>"
    db "<NEXT>Ring the bell…"
    db "<NEXT>…Please…<WAIT>"
    db "@"

Text_CheckedTheNoticeGuide::
    db "<BUF0> checked the<LINE>"
    db "notice.<PROMPT>"
    db "<NEXT>'Guide the lost"
    db "<NEXT>souls…", $95, "<WAIT>"
    db "@"

Text_ReadTheSignDetermine::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Determine where"
    db "<NEXT>you will land<PROMPT>"
    db "<NEXT>before flying"
    db "<NEXT>off.", $95, "<WAIT>"
    db "@"

Text_ILostAgainI::
    db "<VOICE2>*: I lost again.<LINE>"
    db "I need to train my<PROMPT>"
    db "<NEXT>monsters a lot"
    db "<NEXT>more to win.<PROMPT>"
    db "<NEXT>I'll have to go"
    db "<NEXT>back to a world<PROMPT>"
    db "<NEXT>I've already"
    db "<NEXT>finished, and<PROMPT>"
    db "<NEXT>raise their levels"
    db "<NEXT>some more.<PROMPT>"
    db "<NEXT>There might be"
    db "<NEXT>something new for<PROMPT>"
    db "<NEXT>me to discover."
    db "<NEXT>Who knows?<WAIT>"
    db "@"

Text_GoodLetsGetStarted::
    db "<VOICE2>*: Good! Let's get<LINE>"
    db "started!<WAIT>"
    db "@"

Text_IllBeHereFor::
    db "<VOICE2>*: I'll be here for<LINE>"
    db "a while longer.<PROMPT>"
    db "<NEXT>If you change your"
    db "<NEXT>mind, come back.<WAIT>"
    db "@"

Text_ILostAgainI_2::
    db "<VOICE2>*: I lost again.<LINE>"
    db "I need to train my<PROMPT>"
    db "<NEXT>monsters a lot"
    db "<NEXT>more to win.<PROMPT>"
    db "<NEXT>I'll have to go"
    db "<NEXT>back to a world<PROMPT>"
    db "<NEXT>I've already"
    db "<NEXT>finished, and<PROMPT>"
    db "<NEXT>raise their levels"
    db "<NEXT>some more.<PROMPT>"
    db "<NEXT>There might be"
    db "<NEXT>something new for<PROMPT>"
    db "<NEXT>me to discover."
    db "<NEXT>Who knows?<WAIT>"
    db "@"

Text_WhenYouBreedThe::
    db "<VOICE2>*: When you breed,<LINE>"
    db "the offspring<PROMPT>"
    db "<NEXT>inherit the"
    db "<NEXT>parents' skills<PROMPT>"
    db "<NEXT>and abilities."
    db "<NEXT>So, you're better<PROMPT>"
    db "<NEXT>off breeding"
    db "<NEXT>monsters.<WAIT>"
    db "@"

Text_DoYouKnowAll::
    db "<VOICE1>*: Do you know all<LINE>"
    db "the kinds of meat?<PROMPT>"
    db "<NEXT>There's BeefJerky,"
    db "<NEXT>PorkChop, Rib and<PROMPT>"
    db "<NEXT>then there's"
    db "<NEXT>Sirloin.<PROMPT>"
    db "<NEXT>Sirloin is the"
    db "<NEXT>ultimate!<PROMPT>"
    db "<NEXT>So tender and"
    db "<NEXT>heavenly tasty!<WAIT>"
    db "@"

Text_IfYouEatAny::
    db "<VOICE1>*: If you eat any<LINE>"
    db "BadMeat like me,<PROMPT>"
    db "<NEXT>you'll get"
    db "<NEXT>poisoned.<WAIT>"
    db "@"

Text_HmLittleOneAre::
    db "<VOICE1>*: Hm? Little one,<LINE>"
    db "are you a master?<PROMPT>"
    db "<NEXT>How would you like"
    db "<NEXT>to breed one of<PROMPT>"
    db "<NEXT>your monsters with"
    db "<NEXT>my Armorpede?<CHOICE>"
    db "@"

Text_GoodLetsGetThis::
    db "<VOICE1>*: Good! Let's get<LINE>"
    db "this started!<WAIT>"
    db "@"

Text_OhTooBadAnother::
    db "<VOICE1>*: Oh, too bad.<LINE>"
    db "Another time.<PROMPT>"
    db "<NEXT>Tell me if you"
    db "<NEXT>change your mind.<WAIT>"
    db "@"

Text_IfYouGetAn::
    db "<VOICE1>*: If you get an<LINE>"
    db "EvilArmor, I", $44, "<PROMPT>"
    db "<NEXT>breed it with a"
    db "<NEXT>material family<PROMPT>"
    db "<NEXT>partner. It's a"
    db "<NEXT>tough combo.<WAIT>"
    db "@"

Text_NoctoKingIsMyName::
    db "<VOICE1>*: NoctoKing is my<LINE>"
    db "name!<PROMPT>"
    db "<NEXT>Darkness is my"
    db "<NEXT>domain!<PROMPT>"
    db "<NEXT>Perchance, do you"
    db "<NEXT>know a skill named<PROMPT>"
    db "<NEXT>Ahhh? Its effects"
    db "<NEXT>differ markedly<PROMPT>"
    db "<NEXT>depending on the"
    db "<NEXT>gender.<WAIT>"
    db "@"

Text_ILearnedHowTo::
    db "<VOICE1>*: I learned how to<LINE>"
    db "Massacre!<PROMPT>"
    db "<NEXT>But I ended up"
    db "<NEXT>clocking my mates<PROMPT>"
    db "<NEXT>pretty good too."
    db "<NEXT>Ehehe.<WAIT>"
    db "@"

Text_YoUpCloseYou::
    db "<VOICE1>*: Yo! Up close,<LINE>"
    db "you look tougher<PROMPT>"
    db "<NEXT>than you first"
    db "<NEXT>appeared.<PROMPT>"
    db "<NEXT>Want to breed a"
    db "<NEXT>monster with my<PROMPT>"
    db "<NEXT>WildApe? Does"
    db "<NEXT>that sound good?<CHOICE>"
    db "@"

Text_ILikeYourStyle::
    db "<VOICE1>*: I like your<LINE>"
    db "style!<PROMPT>"
    db "<NEXT>Let's get started"
    db "<NEXT>with this.<WAIT>"
    db "@"

Text_WhatAreYouSure::
    db "<VOICE1>*: What? Are you<LINE>"
    db "sure about that?<WAIT>"
    db "@"

Text_AllRightyWellDo::
    db "<VOICE1>*: All righty!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>We'll do this again"
    db "<NEXT>next time too!<WAIT>"
    db "@"

Text_ArrMateyImCaptDead::
    db "<VOICE1>*: Arr, matey!<LINE>"
    db "I'm CaptDead!<PROMPT>"
    db "<NEXT>A dashing zombie"
    db "<NEXT>of the open seas!<PROMPT>"
    db "<NEXT>If I CallHelp, my"
    db "<NEXT>trusty crew will<PROMPT>"
    db "<NEXT>come running,"
    db "<NEXT>cutlasses ready!<WAIT>"
    db "@"

Text_IStrikeWithMy::
    db "<VOICE1>*: I strike with my<LINE>"
    db "eight tentacles.<PROMPT>"
    db "<NEXT>That means I hit"
    db "<NEXT>eight times!<WAIT>"
    db "@"

Text_WelcomeImTheChristener::
    db "<VOICE2>*: Welcome. I'm the<LINE>"
    db "Christener.<PROMPT>"
    db "<NEXT>I can rename your"
    db "<NEXT>monsters here.<PROMPT>"
    db "<NEXT>Do you wish to"
    db "<NEXT>rename one?@"

Text_WelcomeImTheChristener_2::
    db "<VOICE2>*: Welcome. I'm the<LINE>"
    db "Christener.<PROMPT>"
    db "<NEXT>Do you wish to"
    db "<NEXT>rename someone?@"

Text_CheckedTheBookshelfHandbook::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Handbook on"
    db "<NEXT>Naming…<PROMPT>"
    db "<NEXT>Using a part of"
    db "<NEXT>the species name<PROMPT>"
    db "<NEXT>enables easier"
    db "<NEXT>identification.", $95, "<WAIT>"
    db "@"

Text_CheckedTheBookshelfHandbook_2::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Handbook on"
    db "<NEXT>Naming…<PROMPT>"
    db "<NEXT>Borrowing from the"
    db "<NEXT>parents' names<PROMPT>"
    db "<NEXT>adds to the weight"
    db "<NEXT>of a name.", $95, "<WAIT>"
    db "@"

Text_CheckedTheBookshelfHandbook_3::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Handbook on"
    db "<NEXT>Naming…<PROMPT>"
    db "<NEXT>A string of the"
    db "<NEXT>same character<PROMPT>"
    db "<NEXT>makes a terrible"
    db "<NEXT>name. Where is<PROMPT>"
    db "<NEXT>your love for your"
    db "<NEXT>monster?", $95, "<WAIT>"
    db "@"

Text_IWasOnceA::
    db "<VOICE1>*: I was once a<LINE>"
    db "great master who<PROMPT>"
    db "<NEXT>traveled from"
    db "<NEXT>world to world.<PROMPT>"
    db "<NEXT>I used that key to"
    db "<NEXT>reach a world.<PROMPT>"
    db "<NEXT>You have your own"
    db "<NEXT>Magic Keys, yes?<CHOICE>"
    db "@"

Text_HaveYouShownThem::
    db "<VOICE1>*: Have you shown<LINE>"
    db "them to the Key<PROMPT>"
    db "<NEXT>Shop's boss?"
    db "<NEXT>He'll make it so<PROMPT>"
    db "<NEXT>you can go to"
    db "<NEXT>other worlds.<WAIT>"
    db "@"

Text_YouveNotFoundAny::
    db "<VOICE1>*: You've not found<LINE>"
    db "any yet?<PROMPT>"
    db "<NEXT>That's a"
    db "<NEXT>rotten shame…<PROMPT>"
    db "<NEXT>Fine, look on the"
    db "<NEXT>shelf there.<PROMPT>"
    db "<NEXT>You can take one"
    db "<NEXT>of my keys.<WAIT>"
    db "@"

Text_ThatKeyIUsed::
    db "<VOICE1>*: That key, I used<LINE>"
    db "on my travels to<PROMPT>"
    db "<NEXT>other worlds in my"
    db "<NEXT>youth.<PROMPT>"
    db "<NEXT>It brings back"
    db "<NEXT>memories.<PROMPT>"
    db "<NEXT>No, you may not"
    db "<NEXT>have it.<WAIT>"
    db "@"

Text_CheckedTheShelfSouvenirs::
    db "<BUF0> checked the<LINE>"
    db "shelf.<PROMPT>"
    db "<NEXT>Souvenirs from"
    db "<NEXT>other worlds<PROMPT>"
    db "<NEXT>covered the shelf"
    db "<NEXT>haphazardly.<WAIT>"
    db "@"

Text_CheckedTheShelfObtained::
    db "<BUF0> checked the<LINE>"
    db "shelf.<PROMPT>"
    db "<NEXT><BUF0> obtained a"
    db "<NEXT>Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_CheckedTheShelfFound::
    db "<BUF0> checked the<LINE>"
    db "shelf.<PROMPT>"
    db "<NEXT><BUF0> found a"
    db "<NEXT>Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>was full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

Text_PeeredIntoTheVase_5::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was full of"
    db "<NEXT>esoteric junk.<WAIT>"
    db "@"

Text_ReadTheSignMonster::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Monster Arena,"
    db "<NEXT>where masters meet<PROMPT>"
    db "<NEXT>for battle!"
    db "<NEXT>Downstairs!", $95, "<WAIT>"
    db "@"

Text_ThereAreTimesWhen::
    db "<VOICE1>*: There are times<LINE>"
    db "when you have to<PROMPT>"
    db "<NEXT>take weak monsters"
    db "<NEXT>out and about.<PROMPT>"
    db "<NEXT>If you want to"
    db "<NEXT>avoid battles,<PROMPT>"
    db "<NEXT>sprinkle on some"
    db "<NEXT>Repellent.<WAIT>"
    db "@"

Text_UpAheadIsThe::
    db "<VOICE1>*: Up ahead is the<LINE>"
    db "Starry Shrine and<PROMPT>"
    db "<NEXT>the Egg Evaluator's"
    db "<NEXT>room.<PROMPT>"
    db "<NEXT>Both facilities"
    db "<NEXT>are absolutely<PROMPT>"
    db "<NEXT>indispensable to"
    db "<NEXT>masters.<PROMPT>"
    db "<NEXT>But they're only"
    db "<NEXT>open to certified<PROMPT>"
    db "<NEXT>masters, and no"
    db "<NEXT>one else.<WAIT>"
    db "@"

Text_Empty_7::
    db $f0

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_98_3::
; another name for the data at StringCategories_98_3, whose note is above (E-0381)
MessageStrings_Bank89_Overflow::
    dw StringList_Bank89_Overflow_0 ; id 0

; category list of StringCategories_98_3; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank89_Overflow_0::
    dw Text_WhatYouDontKnow ; id 0
    dw Text_ABeautifulVoiceEchoed ; id 1
    dw Text_HelenIThankYou ; id 2
    dw Text_SeeingTheLivelinessOf ; id 3
    dw Text_CheckedTheTombstoneThere ; id 4
    dw Text_TheSeaIsHuge ; id 5
    dw Text_HuhHasTheSea ; id 6
    dw Text_TheWaterFlowedRight ; id 7
    dw Text_LookAMadCondorIt ; id 8
    dw Text_HeyYouveBefriendedA ; id 9
    dw Text_HeyYouveBefriendedA_2 ; id 10
    dw Text_HeyYouveBefriendedA_3 ; id 11
    dw Text_HeyYouveBefriendedA_4 ; id 12
    dw Text_HeyYouveBefriendedA_5 ; id 13
    dw Text_HeyYouveBefriendedA_6 ; id 14
    dw Text_HeyYouveBefriendedA_7 ; id 15
    dw Text_HeyYouveBefriendedA_8 ; id 16
    dw Text_CongratulationsYouveCatalogedEvery ; id 17
    dw Text_WelcomeToTheLibrary ; id 18
    dw Text_WeNeedFanfareRight ; id 19
    dw Text_TheWeatherHasBeen ; id 20
    dw Text_LadyYunaHasCome ; id 21
    dw Text_TheQueensLostHer ; id 22
    dw Text_TheKingdomsOfThe ; id 23
    dw Text_TheScholarWhoWas ; id 24
    dw Text_WarubouWaHeyFeel ; id 25
    dw Text_ZZZZZSsssZZZZZSsss ; id 26
    dw Text_HeroHeroHeroHero_2 ; id 27
    dw Text_HeroHeroHeroHero_2 ; id 28
    dw Text_HeroHeroHeroHero_2 ; id 29
    dw Text_HeroHeroHeroHero_2 ; id 30
    dw Text_HeroHeroHeroHero_2 ; id 31
    dw Text_HeroHeroHeroHero_2 ; id 32
    dw Text_HeroHeroHeroHero_2 ; id 33

Text_WhatYouDontKnow::
    db "<VOICE1>*: What? You don't<LINE>"
    db "know about the<PROMPT>"
    db "<NEXT>Starry Shrine or"
    db "<NEXT>the Egg Evaluator?<PROMPT>"
    db "<NEXT>Urrrgh… Look them"
    db "<NEXT>up at the Library.<PROMPT>"
    db "<NEXT>I'm not much good"
    db "<NEXT>at explaining, but<PROMPT>"
    db "<NEXT>I've gotten you"
    db "<NEXT>the word!<WAIT>"
    db "@"

Text_ABeautifulVoiceEchoed::
    db "A beautiful voice<LINE>"
    db "echoed…<WAIT>"
    db "@"

Text_HelenIThankYou::
    db "<VOICE2>Helen: I thank you<LINE>"
    db "from the heart.<PROMPT>"
    db "<NEXT>Please give my"
    db "<NEXT>regards to the<PROMPT>"
    db "<NEXT>spirit in the"
    db "<NEXT>spring.<WAIT>"
    db "@"

Text_SeeingTheLivelinessOf::
    db "<VOICE1>*: Seeing the<LINE>"
    db "liveliness of<PROMPT>"
    db "<NEXT>Lady Yuna lifts"
    db "<NEXT>our spirits.<WAIT>"
    db "@"

Text_CheckedTheTombstoneThere::
    db "<BUF0> checked the<LINE>"
    db "tombstone.<PROMPT>"
    db "<NEXT>There appeared to"
    db "<NEXT>be nothing.<WAIT>"
    db "@"

Text_TheSeaIsHuge::
    db "<VOICE1>*: The sea is huge<LINE>"
    db "and mysterious.<PROMPT>"
    db "<NEXT>There must be"
    db "<NEXT>totally different<PROMPT>"
    db "<NEXT>monsters in the"
    db "<NEXT>sea.<WAIT>"
    db "@"

Text_HuhHasTheSea::
    db "<VOICE1>*: Huh? Has the sea<LINE>"
    db "risen?<PROMPT>"
    db "<NEXT>Oh, well. I'm a"
    db "<NEXT>good swimmer.<WAIT>"
    db "@"

Text_TheWaterFlowedRight::
    db "<VOICE1>*: The water flowed<LINE>"
    db "right over the<PROMPT>"
    db "<NEXT>ground almost"
    db "<NEXT>instantly.<PROMPT>"
    db "<NEXT>Is GreatLog really"
    db "<NEXT>safe?<WAIT>"
    db "@"

Text_LookAMadCondorIt::
    db "Look! A MadCondor!<LINE>"
    db "It has something!<PROMPT>"
    db "<NEXT>It clutched a"
    db "<NEXT>glowing ball!<WAIT>"
    db "@"

Text_HeyYouveBefriendedA::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 20 species!<PROMPT>"
    db "<NEXT>Keep at it, and"
    db "<NEXT>get some more!<WAIT>"
    db "@"

Text_HeyYouveBefriendedA_2::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 30 species!<PROMPT>"
    db "<NEXT>You can check up"
    db "<NEXT>on your monsters", $95, "<PROMPT>"
    db "<NEXT>cataloged data at"
    db "<NEXT>the Library.<WAIT>"
    db "@"

Text_HeyYouveBefriendedA_3::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 40 species!<PROMPT>"
    db "<NEXT>If the farm is"
    db "<NEXT>full, you should<PROMPT>"
    db "<NEXT>try breeding some"
    db "<NEXT>of your monsters.<WAIT>"
    db "@"

Text_HeyYouveBefriendedA_4::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 50 species!<PROMPT>"
    db "<NEXT>By the way, I"
    db "<NEXT>think Prince<PROMPT>"
    db "<NEXT>Kameha had some"
    db "<NEXT>rare Magic Keys.<WAIT>"
    db "@"

Text_HeyYouveBefriendedA_5::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 100 species!<PROMPT>"
    db "<NEXT>You've grown up a"
    db "<NEXT>lot through this.<PROMPT>"
    db "<NEXT>I'm proud of you!"
    db "<NEXT><WAIT>"
    db "@"

Text_HeyYouveBefriendedA_6::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 150 species!<PROMPT>"
    db "<NEXT>Have you met a boy"
    db "<NEXT>named Terry?<PROMPT>"
    db "<NEXT>You should be good"
    db "<NEXT>enough as a master<PROMPT>"
    db "<NEXT>to be worthy of"
    db "<NEXT>his approval.<WAIT>"
    db "@"

Text_HeyYouveBefriendedA_7::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 200 species!<PROMPT>"
    db "<NEXT>I doubt no one has"
    db "<NEXT>cataloged as many<PROMPT>"
    db "<NEXT>monsters as you."
    db "<NEXT>…What's that?<PROMPT>"
    db "<NEXT>Am I embarrassing"
    db "<NEXT>you?<WAIT>"
    db "@"

Text_HeyYouveBefriendedA_8::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 250 species!<PROMPT>"
    db "<NEXT>I had no idea that"
    db "<NEXT>there were so many<PROMPT>"
    db "<NEXT>distinct species"
    db "<NEXT>of monsters. Even<PROMPT>"
    db "<NEXT>Professor Monster"
    db "<NEXT>can't know them<PROMPT>"
    db "<NEXT>all."
    db "<NEXT><WAIT>"
    db "@"

Text_CongratulationsYouveCatalogedEvery::
    db "<VOICE1>*: Congratulations,<LINE>"
    db "<BUF0>!<PROMPT>"
    db "<NEXT>You've cataloged"
    db "<NEXT>every species.<PROMPT>"
    db "<NEXT>There appear to"
    db "<NEXT>be no monsters<PROMPT>"
    db "<NEXT>left to be caught"
    db "<NEXT>and cataloged.<PROMPT>"
    db "<NEXT>You hung in for"
    db "<NEXT>all this time.<PROMPT>"
    db "<NEXT>I'm sincerely"
    db "<NEXT>proud of you.<PROMPT>"
    db "<NEXT><BUF0>, I'm counting"
    db "<NEXT>on you to look<PROMPT>"
    db "<NEXT>after the farm and"
    db "<NEXT>the monsters.<WAIT>"
    db "@"

Text_WelcomeToTheLibrary::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Library!<PROMPT>"
    db "<NEXT>Your monster"
    db "<NEXT>Catalog is done!<MUSIC_WAIT>", $4d, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_WeNeedFanfareRight::
    db "<VOICE2>*: We need fanfare<LINE>"
    db "right about now…<PROMPT>"
    db "<NEXT>Congratulations,"
    db "<NEXT>our little hero!<PROMPT>"
    db "<NEXT>Here is your newly"
    db "<NEXT>filled Catalog!<PROMPT>"
    db "<NEXT>Which family would"
    db "<NEXT>you like to check?<WAIT>"
    db "@"

Text_TheWeatherHasBeen::
    db "<VOICE1>*: The weather has<LINE>"
    db "been mild.<PROMPT>"
    db "<NEXT>It's a good thing."
    db "<NEXT><WAIT>"
    db "@"

Text_LadyYunaHasCome::
    db "<VOICE1>*: Lady Yuna has<LINE>"
    db "come out of her<PROMPT>"
    db "<NEXT>depression. I've"
    db "<NEXT>heard.<PROMPT>"
    db "<NEXT>When it comes to"
    db "<NEXT>rumors, good ones<PROMPT>"
    db "<NEXT>are the best, I"
    db "<NEXT>have to say.<WAIT>"
    db "@"

Text_TheQueensLostHer::
    db "<VOICE1>*: The Queen's lost<LINE>"
    db "her scary look!<WAIT>"
    db "@"

Text_TheKingdomsOfThe::
    db "<VOICE1>*: The kingdoms of<LINE>"
    db "the north and west<PROMPT>"
    db "<NEXT>have reconciled"
    db "<NEXT>from their ugly<PROMPT>"
    db "<NEXT>squabble over the"
    db "<NEXT>mine.<WAIT>"
    db "@"

Text_TheScholarWhoWas::
    db "<VOICE1>*: The scholar who<LINE>"
    db "was in the tavern?<PROMPT>"
    db "<NEXT>I think he went"
    db "<NEXT>back home.<WAIT>"
    db "@"

Text_WarubouWaHeyFeel::
    db "<VOICE1>Warubou: Wa-hey?<LINE>"
    db "Feel that, warooh?<PROMPT>"
    db "<NEXT>Did something"
    db "<NEXT>shake?<WAIT>"
    db "@"

Text_ZZZZZSsssZZZZZSsss::
    db "<VOICE1>*: ZZZZZ… Ssss…<LINE>"
    db "ZZZZZ… Ssss…<WAIT>"
    db "@"

Text_HeroHeroHeroHero_2::
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
