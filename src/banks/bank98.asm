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

String_98_4070_00_01::
    db "<VOICE1>*: Hello! How may I<LINE>"
    db "serve you?<WAIT>"
    db "@"

String_98_4070_00_02::
    db "<VOICE1>*: The lake is<LINE>"
    db "frozen, so I can't<PROMPT>"
    db "<NEXT>very well take my"
    db "<NEXT>boat out.<PROMPT>"
    db "<NEXT>The north winds"
    db "<NEXT>seem to be unduly<PROMPT>"
    db "<NEXT>harsh this year"
    db "<NEXT>for some reason.<WAIT>"
    db "@"

String_98_4070_00_03::
    db "<VOICE1>*: This is Westania<LINE>"
    db "Castle.<PROMPT>"
    db "<NEXT>Westania is the"
    db "<NEXT>kingdom to the<PROMPT>"
    db "<NEXT>west of the lake."
    db "<NEXT><WAIT>"
    db "@"

String_98_4070_00_04::
    db "<VOICE1>*: Nobody fails to<LINE>"
    db "be impressed when<PROMPT>"
    db "<NEXT>I breathe fire,"
    db "<NEXT>and I mean nobody!<PROMPT>"
    db "<NEXT>I'm sure Lady Yuna"
    db "<NEXT>will be delighted<PROMPT>"
    db "<NEXT>when she sees my"
    db "<NEXT>act.<WAIT>"
    db "@"

String_98_4070_00_05::
    db "<VOICE1>*: I've brought with<LINE>"
    db "me a necklace that<PROMPT>"
    db "<NEXT>is studded with"
    db "<NEXT>jewels.<PROMPT>"
    db "<NEXT>Any woman would be"
    db "<NEXT>delighted by it!<WAIT>"
    db "@"

String_98_4070_00_06::
    db "<VOICE1>*: When I balance<LINE>"
    db "on my ball, people<PROMPT>"
    db "<NEXT>simply go wild."
    db "<NEXT>Just watch me!<WAIT>"
    db "@"

String_98_4070_00_07::
    db "<VOICE1>*: I hurl knives<LINE>"
    db "with incredible<PROMPT>"
    db "<NEXT>accuracy."
    db "<NEXT>I never miss!<PROMPT>"
    db "<NEXT>Even Lady Yuna"
    db "<NEXT>will be surprised.<PROMPT>"
    db "<NEXT>That'll snap her"
    db "<NEXT>out of her funk.<WAIT>"
    db "@"

String_98_4070_00_08::
    db "<VOICE1>*: Please, line up!<LINE>"
    db "And quit pushing!<PROMPT>"
    db "<NEXT>Everyone will get"
    db "<NEXT>their turn.<PROMPT>"
    db "<NEXT>…Sigh… Everyone is"
    db "<NEXT>after the reward…<WAIT>"
    db "@"

String_98_4070_00_09::
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

String_98_4070_00_0A::
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

String_98_4070_00_0B::
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

String_98_4070_00_0C::
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

String_98_4070_00_0D::
    db "<VOICE1>*: The Castle is in<LINE>"
    db "an uproar.<WAIT>"
    db "@"

String_98_4070_00_0E::
    db "<VOICE1>*: Lady Yuna used<LINE>"
    db "to be very lively.<PROMPT>"
    db "<NEXT>It makes no sense,"
    db "<NEXT>her depression.<WAIT>"
    db "@"

String_98_4070_00_0F::
    db "<VOICE1>*: In the east<LINE>"
    db "lives an old man<PROMPT>"
    db "<NEXT>who had tutored"
    db "<NEXT>Lady Yuna.<PROMPT>"
    db "<NEXT>He knows about her"
    db "<NEXT>the best.<WAIT>"
    db "@"

String_98_4070_00_10::
    db "<VOICE1>*: What happened to<LINE>"
    db "Lady Yuna?<PROMPT>"
    db "<NEXT>It's as if she is"
    db "<NEXT>a soulless puppet…<WAIT>"
    db "@"

String_98_4070_00_11::
    db "<VOICE1>*: Before, Lady<LINE>"
    db "Yuna would be up<PROMPT>"
    db "<NEXT>and out playing at"
    db "<NEXT>sunrise.<PROMPT>"
    db "<NEXT>But now, she never"
    db "<NEXT>ventures out…<WAIT>"
    db "@"

String_98_4070_00_12::
    db "<VOICE1>*: This leads to<LINE>"
    db "Lady Yuna's room.<PROMPT>"
    db "<NEXT>You may not go"
    db "<NEXT>beyond here.<WAIT>"
    db "@"

String_98_4070_00_13::
    db "<VOICE1>*: You're here to<LINE>"
    db "cheer Lady Yuna.<PROMPT>"
    db "<NEXT>Please go right"
    db "<NEXT>through.<WAIT>"
    db "@"

String_98_4070_00_14::
    db "<VOICE1>*: You're here to<LINE>"
    db "cheer Lady Yuna.<PROMPT>"
    db "<NEXT>Oh? Your monsters"
    db "<NEXT>are not healthy.<PROMPT>"
    db "<NEXT>That won't do. No,"
    db "<NEXT>not at all.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>leave, I'm afraid.<WAIT>"
    db "@"

String_98_4070_00_15::
    db "<VOICE1>*: You're here to<LINE>"
    db "cheer Lady Yuna.<PROMPT>"
    db "<NEXT>Oh? You haven't"
    db "<NEXT>three monsters?<PROMPT>"
    db "<NEXT>Your show can't be"
    db "<NEXT>very impressive.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>leave, I'm afraid.<WAIT>"
    db "@"

String_98_4070_00_16::
    db "<VOICE2>*: Enough… Enough<LINE>"
    db "of that dancing!<WAIT>"
    db "@"

String_98_4070_00_17::
    db "<VOICE1>*: I am the King.<LINE>"
    db "What is your act?<WAIT>"
    db "@"

String_98_4070_00_18::
    db "<VOICE1>King: Magnificent!<LINE>"
    db "Don't you agree?<WAIT>"
    db "@"

String_98_4070_00_19::
    db "<VOICE2>*: …………<LINE>"
    db "<WAIT>"
    db "@"

String_98_4070_00_1A::
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

String_98_4070_00_1B::
    db "<VOICE1>*: Many have tried<LINE>"
    db "to cheer Lady Yuna<PROMPT>"
    db "<NEXT>up to the way she"
    db "<NEXT>was before.<PROMPT>"
    db "<NEXT>However, none have"
    db "<NEXT>succeeded.<PROMPT>"
    db "<NEXT>Will we ever see"
    db "<NEXT>her smile again?<WAIT>"
    db "@"

String_98_4070_00_1C::
    db "<VOICE1>*: This is the<LINE>"
    db "Castle of Estria,<PROMPT>"
    db "<NEXT>the eastern"
    db "<NEXT>kingdom.<WAIT>"
    db "@"

String_98_4070_00_1D::
    db "<VOICE1>*: Queen Helen came<LINE>"
    db "by a while ago, so<PROMPT>"
    db "<NEXT>I greeted her. But"
    db "<NEXT>she said nothing<PROMPT>"
    db "<NEXT>and walked by"
    db "<NEXT>without notice.<PROMPT>"
    db "<NEXT>She used to greet"
    db "<NEXT>us warmly before…<WAIT>"
    db "@"

String_98_4070_00_1E::
    db "<VOICE2>*: The spirit's<LINE>"
    db "spring has frozen.<PROMPT>"
    db "<NEXT>The lake is full"
    db "<NEXT>of ice too.<PROMPT>"
    db "<NEXT>These are terrible"
    db "<NEXT>omens…<WAIT>"
    db "@"

String_98_4070_00_1F::
    db "<VOICE1>*: Queen Helen's<LINE>"
    db "dreams come true.<PROMPT>"
    db "<NEXT>If she hadn't"
    db "<NEXT>dreamed of this,<PROMPT>"
    db "<NEXT>we would've fared"
    db "<NEXT>much worse.<WAIT>"
    db "@"

String_98_4070_00_20::
    db "<VOICE1>*: Our Queen is a<LINE>"
    db "kind person who<PROMPT>"
    db "<NEXT>has a friendly"
    db "<NEXT>word for everyone,<PROMPT>"
    db "<NEXT>but lately she"
    db "<NEXT>looks grim…<WAIT>"
    db "@"

String_98_4070_00_21::
    db "<VOICE2>*: A teacher from<LINE>"
    db "the west lives<PROMPT>"
    db "<NEXT>over there."
    db "<NEXT>He once was a<PROMPT>"
    db "<NEXT>tutor to the west's"
    db "<NEXT>princess.<WAIT>"
    db "@"

String_98_4070_00_22::
    db "<VOICE1>*: There is a<LINE>"
    db "spring in the far<PROMPT>"
    db "<NEXT>north that is home"
    db "<NEXT>to a spirit.<PROMPT>"
    db "<NEXT>The spirit lends"
    db "<NEXT>us the power to<PROMPT>"
    db "<NEXT>survive in these"
    db "<NEXT>harsh conditions.<WAIT>"
    db "@"

String_98_4070_00_23::
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

String_98_4070_00_24::
    db "<VOICE1>*: The Queen looks<LINE>"
    db "haggard recently.<PROMPT>"
    db "<NEXT>Lack of sleep must"
    db "<NEXT>be very taxing.<PROMPT>"
    db "<NEXT>She has been"
    db "<NEXT>rather irritable.<WAIT>"
    db "@"

String_98_4070_00_25::
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

String_98_4070_00_26::
    db "<VOICE1>*: This is no place<LINE>"
    db "for a child!<WAIT>"
    db "@"

String_98_4070_00_27::
    db "<VOICE1>*: Oh? An envoy<LINE>"
    db "from the spirit!<WAIT>"
    db "@"

String_98_4070_00_28::
    db "<VOICE1>*: I beg your<LINE>"
    db "pardon, please!<WAIT>"
    db "@"

String_98_4070_00_29::
    db "<VOICE1>*: Hello! What may<LINE>"
    db "I do for you?<WAIT>"
    db "@"

String_98_4070_00_2A::
    db "<VOICE2>*: A botanist does<LINE>"
    db "live here…<PROMPT>"
    db "<NEXT>But he's been gone"
    db "<NEXT>for quite some<PROMPT>"
    db "<NEXT>time on a research"
    db "<NEXT>trip of some sort.<PROMPT>"
    db "<NEXT>Who knows where he"
    db "<NEXT>could be now.<WAIT>"
    db "@"

String_98_4070_00_2B::
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

String_98_4070_00_2C::
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

String_98_4070_00_2D::
    db "<VOICE1>*: Oh, you're rushed<LINE>"
    db "for time… Sorry…<WAIT>"
    db "@"

String_98_4070_00_2E::
    db "<VOICE1>*: I want to return<LINE>"
    db "to the north, but<PROMPT>"
    db "<NEXT>there are no ships"
    db "<NEXT>sailing.<PROMPT>"
    db "<NEXT>The mountains in"
    db "<NEXT>the north are too<PROMPT>"
    db "<NEXT>treacherous to"
    db "<NEXT>attempt crossing.<WAIT>"
    db "@"

String_98_4070_00_2F::
    db "<VOICE1>*: Queen Helen has<LINE>"
    db "been suffering<PROMPT>"
    db "<NEXT>from nightmares"
    db "<NEXT>terribly.<PROMPT>"
    db "<NEXT>They don't let her"
    db "<NEXT>sleep.<PROMPT>"
    db "<NEXT>We're concerned"
    db "<NEXT>for her health…<WAIT>"
    db "@"

String_98_4070_00_30::
    db "<VOICE2>*: …………?<WAIT>"
    db "@"

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
    db "<VOICE1>*: Wa-hey! Can you<LINE>"
    db "hear me, <BUF0>?<PROMPT>"
    db "<NEXT>Things have turned"
    db "<NEXT>serious, warooh!<PROMPT>"
    db "<NEXT>I'll bring you back"
    db "<NEXT>to GreatLog.<PROMPT>"
    db "<NEXT>Don't move!"
    db "<NEXT><WAIT>"
    db "@"

String_98_572E_00_01::
    db "<VOICE1>*: Some time ago,<LINE>"
    db "lightning struck<PROMPT>"
    db "<NEXT>the tower, causing"
    db "<NEXT>it to buckle.<PROMPT>"
    db "<NEXT>A huge bird flew"
    db "<NEXT>out of the rubble.<WAIT>"
    db "@"

String_98_572E_00_02::
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

String_98_572E_00_03::
    db "<VOICE1>*: I heard on my<LINE>"
    db "travels that the<PROMPT>"
    db "<NEXT>monster King has"
    db "<NEXT>disappeared.<PROMPT>"
    db "<NEXT>Where could he"
    db "<NEXT>have gone?<PROMPT>"
    db "<NEXT>Well, it's not a"
    db "<NEXT>bad thing.<WAIT>"
    db "@"

String_98_572E_00_04::
    db "<VOICE1>*: The monster King<LINE>"
    db "disappeared.<PROMPT>"
    db "<NEXT>He", $44, " made monsters"
    db "<NEXT>obey using magic.<WAIT>"
    db "@"

String_98_572E_00_05::
    db "<VOICE1>*: When the monster<LINE>"
    db "King disappeared,<PROMPT>"
    db "<NEXT>we all gained our"
    db "<NEXT>freedom.<PROMPT>"
    db "<NEXT>But everyone's been"
    db "<NEXT>having so much fun<PROMPT>"
    db "<NEXT>treasure hunting,"
    db "<NEXT>no one's quit!<WAIT>"
    db "@"

String_98_572E_00_06::
    db "<VOICE1>*: The Castle is<LINE>"
    db "now managed by all<PROMPT>"
    db "<NEXT>of us in the town."
    db "<NEXT><WAIT>"
    db "@"

String_98_572E_00_07::
    db "<VOICE1>*: Rumor has it<LINE>"
    db "that almost no one<PROMPT>"
    db "<NEXT>has seen the"
    db "<NEXT>monster King.<PROMPT>"
    db "<NEXT>Maybe he looked"
    db "<NEXT>weak and frail.<WAIT>"
    db "@"

String_98_572E_00_08::
    db "<VOICE1>*: Where has our<LINE>"
    db "King gone?<WAIT>"
    db "@"

String_98_572E_00_09::
    db "<VOICE1>*: There's no point<LINE>"
    db "staying in the<PROMPT>"
    db "<NEXT>army. I should go"
    db "<NEXT>back home.<WAIT>"
    db "@"

String_98_572E_00_0A::
    db "<VOICE1>*: If I had the<LINE>"
    db "LightOrb, even I<PROMPT>"
    db "<NEXT>could become the"
    db "<NEXT>King of monsters.<PROMPT>"
    db "<NEXT>Could you please"
    db "<NEXT>tell me where I<PROMPT>"
    db "<NEXT>could find the"
    db "<NEXT>LightOrb?<WAIT>"
    db "@"

String_98_572E_00_0B::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Town of Hitano"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Where treasure"
    db "<NEXT>hunters gather.", $95, "<WAIT>"
    db "@"

String_98_572E_00_0C::
    db "<VOICE1>*: The Mayor is<LINE>"
    db "beyond here.<PROMPT>"
    db "<NEXT>Please watch your"
    db "<NEXT>manners.<WAIT>"
    db "@"

String_98_572E_00_0D::
    db "<VOICE1>*: I've become the<LINE>"
    db "Mayor, but what<PROMPT>"
    db "<NEXT>exactly should I"
    db "<NEXT>be doing?<WAIT>"
    db "@"

String_98_572E_00_0E::
    db "<BUF0> released the<LINE>"
    db "grave's button.<WAIT>"
    db "@"

String_98_572E_00_0F::
    db "<VOICE1>*: The castle's lord<LINE>"
    db "summons monsters…<WAIT>"
    db "@"

String_98_572E_00_10::
    db "<VOICE1>*: A button hides<LINE>"
    db "behind a grave…<PROMPT>"
    db "<NEXT>A button that"
    db "<NEXT>opens a door…<WAIT>"
    db "@"

String_98_572E_00_11::
    db "<BUF0> checked<LINE>"
    db "behind the grave.<PROMPT>"
    db "<NEXT>There was nothing"
    db "<NEXT>of interest.<WAIT>"
    db "@"

String_98_572E_00_12::
    db "<VOICE1>*: The King's gone.<LINE>"
    db "What should I do?<PROMPT>"
    db "<NEXT>I guess there's no"
    db "<NEXT>Sirloin for me.<WAIT>"
    db "@"

String_98_572E_00_13::
    db "<VOICE1>*: South beyond the<LINE>"
    db "mountains is the<PROMPT>"
    db "<NEXT>King's castle."
    db "<NEXT>I understand that<PROMPT>"
    db "<NEXT>it's bustling with"
    db "<NEXT>treasure hunters.<WAIT>"
    db "@"

String_98_572E_00_14::
    db "<VOICE1>*: Several ancient<LINE>"
    db "ruins remain in<PROMPT>"
    db "<NEXT>the southern part"
    db "<NEXT>of the continent.<PROMPT>"
    db "<NEXT>Treasures may be"
    db "<NEXT>hidden in them.<WAIT>"
    db "@"

String_98_572E_00_15::
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

String_98_572E_00_16::
    db "<VOICE1>*: ……This way…<LINE>"
    db "…Here… …Here…<WAIT>"
    db "@"

String_98_572E_00_17::
    db "<VOICE2>*: …Where is my<LINE>"
    db "casket… Where…<PROMPT>"
    db "<NEXT>Ring the bell…"
    db "<NEXT>…Please…<WAIT>"
    db "@"

String_98_572E_00_18::
    db "<BUF0> checked the<LINE>"
    db "notice.<PROMPT>"
    db "<NEXT>'Guide the lost"
    db "<NEXT>souls…", $95, "<WAIT>"
    db "@"

String_98_572E_00_19::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Determine where"
    db "<NEXT>you will land<PROMPT>"
    db "<NEXT>before flying"
    db "<NEXT>off.", $95, "<WAIT>"
    db "@"

String_98_572E_00_1A::
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

String_98_572E_00_20::
    db "<VOICE2>*: Good! Let's get<LINE>"
    db "started!<WAIT>"
    db "@"

String_98_572E_00_21::
    db "<VOICE2>*: I'll be here for<LINE>"
    db "a while longer.<PROMPT>"
    db "<NEXT>If you change your"
    db "<NEXT>mind, come back.<WAIT>"
    db "@"

String_98_572E_00_22::
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

String_98_572E_00_23::
    db "<VOICE2>*: When you breed,<LINE>"
    db "the offspring<PROMPT>"
    db "<NEXT>inherit the"
    db "<NEXT>parents' skills<PROMPT>"
    db "<NEXT>and abilities."
    db "<NEXT>So, you're better<PROMPT>"
    db "<NEXT>off breeding"
    db "<NEXT>monsters.<WAIT>"
    db "@"

String_98_572E_00_24::
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

String_98_572E_00_25::
    db "<VOICE1>*: If you eat any<LINE>"
    db "BadMeat like me,<PROMPT>"
    db "<NEXT>you'll get"
    db "<NEXT>poisoned.<WAIT>"
    db "@"

String_98_572E_00_26::
    db "<VOICE1>*: Hm? Little one,<LINE>"
    db "are you a master?<PROMPT>"
    db "<NEXT>How would you like"
    db "<NEXT>to breed one of<PROMPT>"
    db "<NEXT>your monsters with"
    db "<NEXT>my Armorpede?<CHOICE>"
    db "@"

String_98_572E_00_27::
    db "<VOICE1>*: Good! Let's get<LINE>"
    db "this started!<WAIT>"
    db "@"

String_98_572E_00_28::
    db "<VOICE1>*: Oh, too bad.<LINE>"
    db "Another time.<PROMPT>"
    db "<NEXT>Tell me if you"
    db "<NEXT>change your mind.<WAIT>"
    db "@"

String_98_572E_00_29::
    db "<VOICE1>*: If you get an<LINE>"
    db "EvilArmor, I", $44, "<PROMPT>"
    db "<NEXT>breed it with a"
    db "<NEXT>material family<PROMPT>"
    db "<NEXT>partner. It's a"
    db "<NEXT>tough combo.<WAIT>"
    db "@"

String_98_572E_00_2A::
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

String_98_572E_00_2B::
    db "<VOICE1>*: I learned how to<LINE>"
    db "Massacre!<PROMPT>"
    db "<NEXT>But I ended up"
    db "<NEXT>clocking my mates<PROMPT>"
    db "<NEXT>pretty good too."
    db "<NEXT>Ehehe.<WAIT>"
    db "@"

String_98_572E_00_2C::
    db "<VOICE1>*: Yo! Up close,<LINE>"
    db "you look tougher<PROMPT>"
    db "<NEXT>than you first"
    db "<NEXT>appeared.<PROMPT>"
    db "<NEXT>Want to breed a"
    db "<NEXT>monster with my<PROMPT>"
    db "<NEXT>WildApe? Does"
    db "<NEXT>that sound good?<CHOICE>"
    db "@"

String_98_572E_00_2D::
    db "<VOICE1>*: I like your<LINE>"
    db "style!<PROMPT>"
    db "<NEXT>Let's get started"
    db "<NEXT>with this.<WAIT>"
    db "@"

String_98_572E_00_2E::
    db "<VOICE1>*: What? Are you<LINE>"
    db "sure about that?<WAIT>"
    db "@"

String_98_572E_00_2F::
    db "<VOICE1>*: All righty!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>We'll do this again"
    db "<NEXT>next time too!<WAIT>"
    db "@"

String_98_572E_00_30::
    db "<VOICE1>*: Arr, matey!<LINE>"
    db "I'm CaptDead!<PROMPT>"
    db "<NEXT>A dashing zombie"
    db "<NEXT>of the open seas!<PROMPT>"
    db "<NEXT>If I CallHelp, my"
    db "<NEXT>trusty crew will<PROMPT>"
    db "<NEXT>come running,"
    db "<NEXT>cutlasses ready!<WAIT>"
    db "@"

String_98_572E_00_31::
    db "<VOICE1>*: I strike with my<LINE>"
    db "eight tentacles.<PROMPT>"
    db "<NEXT>That means I hit"
    db "<NEXT>eight times!<WAIT>"
    db "@"

String_98_572E_00_32::
    db "<VOICE2>*: Welcome. I'm the<LINE>"
    db "Christener.<PROMPT>"
    db "<NEXT>I can rename your"
    db "<NEXT>monsters here.<PROMPT>"
    db "<NEXT>Do you wish to"
    db "<NEXT>rename one?@"

String_98_572E_00_33::
    db "<VOICE2>*: Welcome. I'm the<LINE>"
    db "Christener.<PROMPT>"
    db "<NEXT>Do you wish to"
    db "<NEXT>rename someone?@"

String_98_572E_00_34::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Handbook on"
    db "<NEXT>Naming…<PROMPT>"
    db "<NEXT>Using a part of"
    db "<NEXT>the species name<PROMPT>"
    db "<NEXT>enables easier"
    db "<NEXT>identification.", $95, "<WAIT>"
    db "@"

String_98_572E_00_35::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Handbook on"
    db "<NEXT>Naming…<PROMPT>"
    db "<NEXT>Borrowing from the"
    db "<NEXT>parents' names<PROMPT>"
    db "<NEXT>adds to the weight"
    db "<NEXT>of a name.", $95, "<WAIT>"
    db "@"

String_98_572E_00_36::
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

String_98_572E_00_37::
    db "<VOICE1>*: I was once a<LINE>"
    db "great master who<PROMPT>"
    db "<NEXT>traveled from"
    db "<NEXT>world to world.<PROMPT>"
    db "<NEXT>I used that key to"
    db "<NEXT>reach a world.<PROMPT>"
    db "<NEXT>You have your own"
    db "<NEXT>Magic Keys, yes?<CHOICE>"
    db "@"

String_98_572E_00_38::
    db "<VOICE1>*: Have you shown<LINE>"
    db "them to the Key<PROMPT>"
    db "<NEXT>Shop's boss?"
    db "<NEXT>He'll make it so<PROMPT>"
    db "<NEXT>you can go to"
    db "<NEXT>other worlds.<WAIT>"
    db "@"

String_98_572E_00_39::
    db "<VOICE1>*: You've not found<LINE>"
    db "any yet?<PROMPT>"
    db "<NEXT>That's a"
    db "<NEXT>rotten shame…<PROMPT>"
    db "<NEXT>Fine, look on the"
    db "<NEXT>shelf there.<PROMPT>"
    db "<NEXT>You can take one"
    db "<NEXT>of my keys.<WAIT>"
    db "@"

String_98_572E_00_3A::
    db "<VOICE1>*: That key, I used<LINE>"
    db "on my travels to<PROMPT>"
    db "<NEXT>other worlds in my"
    db "<NEXT>youth.<PROMPT>"
    db "<NEXT>It brings back"
    db "<NEXT>memories.<PROMPT>"
    db "<NEXT>No, you may not"
    db "<NEXT>have it.<WAIT>"
    db "@"

String_98_572E_00_3B::
    db "<BUF0> checked the<LINE>"
    db "shelf.<PROMPT>"
    db "<NEXT>Souvenirs from"
    db "<NEXT>other worlds<PROMPT>"
    db "<NEXT>covered the shelf"
    db "<NEXT>haphazardly.<WAIT>"
    db "@"

String_98_572E_00_3C::
    db "<BUF0> checked the<LINE>"
    db "shelf.<PROMPT>"
    db "<NEXT><BUF0> obtained a"
    db "<NEXT>Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_98_572E_00_3D::
    db "<BUF0> checked the<LINE>"
    db "shelf.<PROMPT>"
    db "<NEXT><BUF0> found a"
    db "<NEXT>Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>was full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

String_98_572E_00_3E::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was full of"
    db "<NEXT>esoteric junk.<WAIT>"
    db "@"

String_98_572E_00_3F::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Monster Arena,"
    db "<NEXT>where masters meet<PROMPT>"
    db "<NEXT>for battle!"
    db "<NEXT>Downstairs!", $95, "<WAIT>"
    db "@"

String_98_572E_00_40::
    db "<VOICE1>*: There are times<LINE>"
    db "when you have to<PROMPT>"
    db "<NEXT>take weak monsters"
    db "<NEXT>out and about.<PROMPT>"
    db "<NEXT>If you want to"
    db "<NEXT>avoid battles,<PROMPT>"
    db "<NEXT>sprinkle on some"
    db "<NEXT>Repellent.<WAIT>"
    db "@"

String_98_572E_00_41::
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

String_98_7032_00_01::
    db "A beautiful voice<LINE>"
    db "echoed…<WAIT>"
    db "@"

String_98_7032_00_02::
    db "<VOICE2>Helen: I thank you<LINE>"
    db "from the heart.<PROMPT>"
    db "<NEXT>Please give my"
    db "<NEXT>regards to the<PROMPT>"
    db "<NEXT>spirit in the"
    db "<NEXT>spring.<WAIT>"
    db "@"

String_98_7032_00_03::
    db "<VOICE1>*: Seeing the<LINE>"
    db "liveliness of<PROMPT>"
    db "<NEXT>Lady Yuna lifts"
    db "<NEXT>our spirits.<WAIT>"
    db "@"

String_98_7032_00_04::
    db "<BUF0> checked the<LINE>"
    db "tombstone.<PROMPT>"
    db "<NEXT>There appeared to"
    db "<NEXT>be nothing.<WAIT>"
    db "@"

String_98_7032_00_05::
    db "<VOICE1>*: The sea is huge<LINE>"
    db "and mysterious.<PROMPT>"
    db "<NEXT>There must be"
    db "<NEXT>totally different<PROMPT>"
    db "<NEXT>monsters in the"
    db "<NEXT>sea.<WAIT>"
    db "@"

String_98_7032_00_06::
    db "<VOICE1>*: Huh? Has the sea<LINE>"
    db "risen?<PROMPT>"
    db "<NEXT>Oh, well. I'm a"
    db "<NEXT>good swimmer.<WAIT>"
    db "@"

String_98_7032_00_07::
    db "<VOICE1>*: The water flowed<LINE>"
    db "right over the<PROMPT>"
    db "<NEXT>ground almost"
    db "<NEXT>instantly.<PROMPT>"
    db "<NEXT>Is GreatLog really"
    db "<NEXT>safe?<WAIT>"
    db "@"

String_98_7032_00_08::
    db "Look! A MadCondor!<LINE>"
    db "It has something!<PROMPT>"
    db "<NEXT>It clutched a"
    db "<NEXT>glowing ball!<WAIT>"
    db "@"

String_98_7032_00_09::
    db "<VOICE1>*: Hey, <BUF0>!<LINE>"
    db "You've befriended<PROMPT>"
    db "<NEXT>a good number of"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>You've got at"
    db "<NEXT>least 20 species!<PROMPT>"
    db "<NEXT>Keep at it, and"
    db "<NEXT>get some more!<WAIT>"
    db "@"

String_98_7032_00_0A::
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

String_98_7032_00_0B::
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

String_98_7032_00_0C::
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

String_98_7032_00_0D::
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

String_98_7032_00_0E::
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

String_98_7032_00_0F::
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

String_98_7032_00_10::
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

String_98_7032_00_11::
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

String_98_7032_00_12::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Library!<PROMPT>"
    db "<NEXT>Your monster"
    db "<NEXT>Catalog is done!<MUSIC_WAIT>", $4d, "<WAIT>"
    db "<MAP_MUSIC>@"

String_98_7032_00_13::
    db "<VOICE2>*: We need fanfare<LINE>"
    db "right about now…<PROMPT>"
    db "<NEXT>Congratulations,"
    db "<NEXT>our little hero!<PROMPT>"
    db "<NEXT>Here is your newly"
    db "<NEXT>filled Catalog!<PROMPT>"
    db "<NEXT>Which family would"
    db "<NEXT>you like to check?<WAIT>"
    db "@"

String_98_7032_00_14::
    db "<VOICE1>*: The weather has<LINE>"
    db "been mild.<PROMPT>"
    db "<NEXT>It's a good thing."
    db "<NEXT><WAIT>"
    db "@"

String_98_7032_00_15::
    db "<VOICE1>*: Lady Yuna has<LINE>"
    db "come out of her<PROMPT>"
    db "<NEXT>depression. I've"
    db "<NEXT>heard.<PROMPT>"
    db "<NEXT>When it comes to"
    db "<NEXT>rumors, good ones<PROMPT>"
    db "<NEXT>are the best, I"
    db "<NEXT>have to say.<WAIT>"
    db "@"

String_98_7032_00_16::
    db "<VOICE1>*: The Queen's lost<LINE>"
    db "her scary look!<WAIT>"
    db "@"

String_98_7032_00_17::
    db "<VOICE1>*: The kingdoms of<LINE>"
    db "the north and west<PROMPT>"
    db "<NEXT>have reconciled"
    db "<NEXT>from their ugly<PROMPT>"
    db "<NEXT>squabble over the"
    db "<NEXT>mine.<WAIT>"
    db "@"

String_98_7032_00_18::
    db "<VOICE1>*: The scholar who<LINE>"
    db "was in the tavern?<PROMPT>"
    db "<NEXT>I think he went"
    db "<NEXT>back home.<WAIT>"
    db "@"

String_98_7032_00_19::
    db "<VOICE1>Warubou: Wa-hey?<LINE>"
    db "Feel that, warooh?<PROMPT>"
    db "<NEXT>Did something"
    db "<NEXT>shake?<WAIT>"
    db "@"

String_98_7032_00_1A::
    db "<VOICE1>*: ZZZZZ… Ssss…<LINE>"
    db "ZZZZZ… Ssss…<WAIT>"
    db "@"

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
