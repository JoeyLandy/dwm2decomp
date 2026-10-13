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
    db "<VOICE1>*: Make sure you<LINE>"
    db "tell the others <PROMPT>"
    db "<NEXT>that I'm No. 1,"
    db "<NEXT>do you understand?<WAIT>"
    db "@"

String_99_4070_00_01::
    db "<VOICE1>*: I'm as plain as<LINE>"
    db "a baked potato.<PROMPT>"
    db "<NEXT>Even what I say is"
    db "<NEXT>bland.<WAIT>"
    db "@"

String_99_4070_00_02::
    db "<VOICE1>*: Isn't the weather<LINE>"
    db "fabulous?<PROMPT>"
    db "<NEXT>We need to be out"
    db "<NEXT>traveling!<WAIT>"
    db "@"

String_99_4070_00_03::
    db "<VOICE1>*: Don't be so<LINE>"
    db "obstinate?<PROMPT>"
    db "<NEXT>But I'm not!"
    db "<NEXT>Huh? I'm acting it?<WAIT>"
    db "@"

String_99_4070_00_04::
    db "<VOICE1>*: Master, please<LINE>"
    db "consider saving<PROMPT>"
    db "<NEXT>your money, and"
    db "<NEXT>not wasting it.<WAIT>"
    db "@"

String_99_4070_00_05::
    db "<VOICE1>*: I plan to leave<LINE>"
    db "as I see fit.<PROMPT>"
    db "<NEXT>Leave me alone,"
    db "<NEXT>please.<WAIT>"
    db "@"

String_99_4070_00_06::
    db "<VOICE1>*: Meat, meat, give<LINE>"
    db "me meat!<PROMPT>"
    db "<NEXT>Or I won't work"
    db "<NEXT>for you. Meat!<WAIT>"
    db "@"

String_99_4070_00_07::
    db "<VOICE1>*: Know your enemy,<LINE>"
    db "know yourself,<PROMPT>"
    db "<NEXT>and you will win"
    db "<NEXT>without danger.<WAIT>"
    db "@"

String_99_4070_00_08::
    db "<VOICE1>*: Use a mate as a<LINE>"
    db "shield, escape…<PROMPT>"
    db "<NEXT>Whoops, uh… nah,"
    db "<NEXT>nothing…<WAIT>"
    db "@"

String_99_4070_00_09::
    db "<VOICE1>*: Enemies deserve<LINE>"
    db "no mercy!<PROMPT>"
    db "<NEXT>Crush them with"
    db "<NEXT>all our might!<WAIT>"
    db "@"

String_99_4070_00_0A::
    db "<VOICE1>*: I… Um… Shy…<LINE>"
    db "Sorry… I'm sorry…<WAIT>"
    db "@"

String_99_4070_00_0B::
    db "<VOICE1>*: For my partners,<LINE>"
    db "and most of all<PROMPT>"
    db "<NEXT>for you, master,"
    db "<NEXT>I'll do my best!<WAIT>"
    db "@"

String_99_4070_00_0C::
    db "<VOICE1>*: Oh, no…<LINE>"
    db "Must I go?<PROMPT>"
    db "<NEXT>Caves and dark"
    db "<NEXT>places are scary…<WAIT>"
    db "@"

String_99_4070_00_0D::
    db "<VOICE1>*: I'll clean, wash,<LINE>"
    db "whatever you wish!<PROMPT>"
    db "<NEXT>Just give me the"
    db "<NEXT>word!<WAIT>"
    db "@"

String_99_4070_00_0E::
    db "<VOICE1>*: Well, is seems<LINE>"
    db "to me, the world<PROMPT>"
    db "<NEXT>at large is pretty"
    db "<NEXT>peaceful, ayup!<WAIT>"
    db "@"

String_99_4070_00_0F::
    db "<VOICE1>*: Is there any way<LINE>"
    db "of fighting while<PROMPT>"
    db "<NEXT>you're asleep?"
    db "<NEXT>How ideal!<WAIT>"
    db "@"

String_99_4070_00_10::
    db "<VOICE1>*: The dark fire<LINE>"
    db "that spirals in my<PROMPT>"
    db "<NEXT>heart shall never"
    db "<NEXT>be extinguished!<WAIT>"
    db "@"

String_99_4070_00_11::
    db "<VOICE1>*: Seeing your joy<LINE>"
    db "adds to my own.<WAIT>"
    db "@"

String_99_4070_00_12::
    db "<VOICE1>*: I will take care<LINE>"
    db "of you totally!<WAIT>"
    db "@"

String_99_4070_00_13::
    db "<VOICE1>*: World domination<LINE>"
    db "is the ultimate<PROMPT>"
    db "<NEXT>goal in my life!"
    db "<NEXT><WAIT>"
    db "@"

String_99_4070_00_14::
    db "<VOICE1>*: However dire the<LINE>"
    db "situation, I will<PROMPT>"
    db "<NEXT>always shield you"
    db "<NEXT>from danger.<WAIT>"
    db "@"

String_99_4070_00_15::
    db "<VOICE1>*: Human! You be<LINE>"
    db "grateful that I<PROMPT>"
    db "<NEXT>have even chosen"
    db "<NEXT>to accompany you!<WAIT>"
    db "@"

String_99_4070_00_16::
    db "<VOICE1>*: Even once, I<LINE>"
    db "would have liked<PROMPT>"
    db "<NEXT>to have been a"
    db "<NEXT>hero…<WAIT>"
    db "@"

String_99_4070_00_17::
    db "<VOICE1>*: Fufufu… Perhaps<LINE>"
    db "we will be enemies<PROMPT>"
    db "<NEXT>if we meet again"
    db "<NEXT>in the future.<WAIT>"
    db "@"

String_99_4070_00_18::
    db "<VOICE1>*: For you, master,<LINE>"
    db "I will leap into<PROMPT>"
    db "<NEXT>a pool of fire, if"
    db "<NEXT>you so command me.<WAIT>"
    db "@"

String_99_4070_00_19::
    db "<VOICE1>*: Excitement,<LINE>"
    db "tension…<PROMPT>"
    db "<NEXT>They are emotions"
    db "<NEXT>without meaning.<WAIT>"
    db "@"

String_99_4070_00_1A::
    db "<VOICE1>*: People and<LINE>"
    db "monsters should be<PROMPT>"
    db "<NEXT>punished alike for"
    db "<NEXT>sins they commit.<WAIT>"
    db "@"

String_99_4070_00_1B::
    db "<VOICE1>*: Give me the<LINE>"
    db "chance to shine.<PROMPT>"
    db "<NEXT>I will protect you"
    db "<NEXT>if you do.<WAIT>"
    db "@"

String_99_4070_00_1C::
    db "<VOICE1>*: I am the Lord of<LINE>"
    db "the monsters!<PROMPT>"
    db "<NEXT>What? Too plain?"
    db "<NEXT>You think so?<WAIT>"
    db "@"

String_99_4070_00_1D::
    db "<VOICE1>*: Are there no<LINE>"
    db "unbreakable toys <PROMPT>"
    db "<NEXT>that will keep"
    db "<NEXT>coming back?<WAIT>"
    db "@"

String_99_4070_00_1E::
    db "<VOICE1>*: Don't bother me…<LINE>"
    db "Leave me be…<WAIT>"
    db "@"

String_99_4070_00_1F::
    db "<VOICE1>*: Let me conquer a<LINE>"
    db "world for you, eh?<WAIT>"
    db "@"

String_99_4070_00_20::
    db "<VOICE1>*: To be conquered<LINE>"
    db "by me is to know<PROMPT>"
    db "<NEXT>happiness!"
    db "<NEXT>Hahahahahah!<WAIT>"
    db "@"

String_99_4070_00_21::
    db "<VOICE1>*: The world is<LINE>"
    db "mine!<PROMPT>"
    db "<NEXT>That is the way it"
    db "<NEXT>has to be!<WAIT>"
    db "@"

String_99_4070_00_22::
    db "<VOICE1>*: Everything is<LINE>"
    db "according to plan.<PROMPT>"
    db "<NEXT>Nothing unexpected"
    db "<NEXT>can happen.<WAIT>"
    db "@"

String_99_4070_00_23::
    db "<VOICE1>*: You can be the<LINE>"
    db "decoy. I'll strike<PROMPT>"
    db "<NEXT>while you're under"
    db "<NEXT>attack. How's that?<WAIT>"
    db "@"

String_99_4070_00_24::
    db "<VOICE1>*: The feelings of<LINE>"
    db "hatred and sorrow<PROMPT>"
    db "<NEXT>become my power."
    db "<NEXT><WAIT>"
    db "@"

String_99_4070_00_25::
    db "<VOICE1>*: Traveling is<LINE>"
    db "fine, but quietly<PROMPT>"
    db "<NEXT>reading is also"
    db "<NEXT>pleasant…<WAIT>"
    db "@"

String_99_4070_00_26::
    db "<VOICE1>*: All my power, I<LINE>"
    db "will use for you…<WAIT>"
    db "@"

String_99_4070_00_27::
    db "<VOICE1>*: The p-power of<LINE>"
    db "heroes is scary…<WAIT>"
    db "@"

String_99_4070_00_28::
    db "<VOICE1>*: If you would<LINE>"
    db "allow it, I wish<PROMPT>"
    db "<NEXT>to conquer this"
    db "<NEXT>world.<WAIT>"
    db "@"

String_99_4070_00_29::
    db "<VOICE1>*: Life isn't bad!<LINE>"
    db "Take it easy,<PROMPT>"
    db "<NEXT>slow down, relax"
    db "<NEXT>and enjoy!<WAIT>"
    db "@"

String_99_4070_00_2A::
    db "<VOICE1>*: I can't be<LINE>"
    db "bothered to chat…<PROMPT>"
    db "<NEXT>Be gone…"
    db "<NEXT><WAIT>"
    db "@"

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
    db "<VOICE2>*: Our daughter's<LINE>"
    db "only memento was<PROMPT>"
    db "<NEXT>taken from us by"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>I'm losing the will"
    db "<NEXT>to keep living…<WAIT>"
    db "@"

String_99_4B35_00_01::
    db "<VOICE1>*: It doesn't look<LINE>"
    db "like the monsters<PROMPT>"
    db "<NEXT>are coming from"
    db "<NEXT>anywhere close.<PROMPT>"
    db "<NEXT>You ought to pay a"
    db "<NEXT>visit to the hut<PROMPT>"
    db "<NEXT>by the spring in"
    db "<NEXT>the west.<PROMPT>"
    db "<NEXT>It's for use by"
    db "<NEXT>travelers.<PROMPT>"
    db "<NEXT>You might talk to"
    db "<NEXT>them for clues.<WAIT>"
    db "@"

String_99_4B35_00_02::
    db "<VOICE2>*: The old couple<LINE>"
    db "across the way<PROMPT>"
    db "<NEXT>were robbed of a"
    db "<NEXT>precious item.<PROMPT>"
    db "<NEXT>That's why they"
    db "<NEXT>were so sad.<WAIT>"
    db "@"

String_99_4B35_00_03::
    db "<VOICE1>*: This is the<LINE>"
    db "traveler's hut.<PROMPT>"
    db "<NEXT>Stay and rest your"
    db "<NEXT>feet a while.<WAIT>"
    db "@"

String_99_4B35_00_04::
    db "<VOICE1>*: That dealer,<LINE>"
    db "how expensive!<PROMPT>"
    db "<NEXT>Nobody can afford"
    db "<NEXT>what he sells!<PROMPT>"
    db "<NEXT>But he does have"
    db "<NEXT>super merchandise…<WAIT>"
    db "@"

String_99_4B35_00_05::
    db "<VOICE1>*: Lately, the town<LINE>"
    db "of Miagen has been<PROMPT>"
    db "<NEXT>hit by plundering"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>Did you know that?"
    db "<NEXT><CHOICE>"
    db "@"

String_99_4B35_00_06::
    db "<VOICE1>*: It's rumored that<LINE>"
    db "monsters raid the<PROMPT>"
    db "<NEXT>town by scaling"
    db "<NEXT>the mountain range<PROMPT>"
    db "<NEXT>to the north."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I think there was"
    db "<NEXT>a forest nearby.<PROMPT>"
    db "<NEXT>Perhaps they came"
    db "<NEXT>from that forest.<PROMPT>"
    db "<NEXT>The forest is east"
    db "<NEXT>from here.<WAIT>"
    db "@"

String_99_4B35_00_07::
    db "<VOICE1>*: You didn't know?<LINE>"
    db "Well, listen up.<PROMPT>"
    db "<NEXT>Go to the town of"
    db "<NEXT>Miagen.<PROMPT>"
    db "<NEXT>The townspeople"
    db "<NEXT>are in an uproar.<WAIT>"
    db "@"

String_99_4B35_00_08::
    db "<VOICE2>*: That dealer's<LINE>"
    db "wares…<PROMPT>"
    db "<NEXT>Could he sell any"
    db "<NEXT>at those prices?<PROMPT>"
    db "<NEXT>I", $44, " like to make"
    db "<NEXT>money like that…<WAIT>"
    db "@"

String_99_4B35_00_09::
    db "<VOICE1>*: How does this<LINE>"
    db "ornament look?<PROMPT>"
    db "<NEXT>Take it home for"
    db "<NEXT>just 12,000G.<PROMPT>"
    db "<NEXT>You say that's too"
    db "<NEXT>much?<PROMPT>"
    db "<NEXT>Heh, scram if you"
    db "<NEXT>have no money.<WAIT>"
    db "@"

String_99_4B35_00_0A::
    db "<VOICE1>*: How does this<LINE>"
    db "jewelry look?<PROMPT>"
    db "<NEXT>It's yours for a"
    db "<NEXT>mere 18,000G.<PROMPT>"
    db "<NEXT>You say that's too"
    db "<NEXT>much?<PROMPT>"
    db "<NEXT>Heh, scram if you"
    db "<NEXT>have no money.<WAIT>"
    db "@"

String_99_4B35_00_0B::
    db "<VOICE1>*: How does this<LINE>"
    db "grand vase look?<PROMPT>"
    db "<NEXT>A bargain at"
    db "<NEXT>23,000G!<PROMPT>"
    db "<NEXT>You say that's too"
    db "<NEXT>much?<PROMPT>"
    db "<NEXT>Heh, scram if you"
    db "<NEXT>have no money.<WAIT>"
    db "@"

String_99_4B35_00_0C::
    db "<VOICE1>*: I've no use for<LINE>"
    db "the poor.<PROMPT>"
    db "<NEXT>Come back if you"
    db "<NEXT>make some money.<WAIT>"
    db "@"

String_99_4B35_00_0D::
    db "<VOICE1>*: How does this<LINE>"
    db "ornament look?<PROMPT>"
    db "<NEXT>Take it home for"
    db "<NEXT>just 12,000G.<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Get lost if you're"
    db "<NEXT>not buying!<WAIT>"
    db "@"

String_99_4B35_00_0E::
    db "<VOICE1>*: How does this<LINE>"
    db "jewelry look?<PROMPT>"
    db "<NEXT>It's yours for a"
    db "<NEXT>mere 18,000G.<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I don't have time"
    db "<NEXT>to play games!<WAIT>"
    db "@"

String_99_4B35_00_0F::
    db "<VOICE1>*: How does this<LINE>"
    db "grand vase look?<PROMPT>"
    db "<NEXT>A bargain at"
    db "<NEXT>23,000G!<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>If you're not a"
    db "<NEXT>customer, beat it!<WAIT>"
    db "@"

String_99_4B35_00_10::
    db "<VOICE1>*: This pendant is<LINE>"
    db "yours for 38,000G…<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I don't know a"
    db "<NEXT>thing about that!<PROMPT>"
    db "<NEXT>You're bad for"
    db "<NEXT>business, vamoose!<WAIT>"
    db "@"

String_99_4B35_00_11::
    db "The tower's entry<LINE>"
    db "is sealed tight.<WAIT>"
    db "@"

String_99_4B35_00_12::
    db "<VOICE1>*: Who are you?<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You shouldn't be"
    db "<NEXT>meddling here!<WAIT>"
    db "@"

String_99_4B35_00_13::
    db "<VOICE1>*: You're going to<LINE>"
    db "regret seeing us.<PROMPT>"
    db "<NEXT>We can't let you"
    db "<NEXT>go blab. Gwaaaaah!<WAIT>"
    db "@"

String_99_4B35_00_14::
    db "<VOICE1>*: What, not you<LINE>"
    db "again!<WAIT>"
    db "@"

String_99_4B35_00_15::
    db "<VOICE1>*: We'll smash you<LINE>"
    db "as often as it<PROMPT>"
    db "<NEXT>takes to make you"
    db "<NEXT>stop meddling!<WAIT>"
    db "@"

String_99_4B35_00_16::
    db "<VOICE1>*: Please! Mercy!<LINE>"
    db "Spare us!<PROMPT>"
    db "<NEXT>Take back every-"
    db "<NEXT>thing we took!<WAIT>"
    db "@"

String_99_4B35_00_17::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>Pretty Ring.<WAIT>"
    db "@"

String_99_4B35_00_18::
    db "<BUF0> found the<LINE>"
    db "Pretty Ring.<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Pretty Ring back.<WAIT>"
    db "@"

String_99_4B35_00_1A::
    db "<VOICE1>*: I dug deep in my<LINE>"
    db "purse to buy from<PROMPT>"
    db "<NEXT>that dealer, but"
    db "<NEXT>it feel very odd.<PROMPT>"
    db "<NEXT>What I buy look"
    db "<NEXT>very familiar.<PROMPT>"
    db "<NEXT>I don't know why."
    db "<NEXT>I will remember.<WAIT>"
    db "@"

String_99_4B35_00_1B::
    db "<VOICE1>*: What? Monsters<LINE>"
    db "attacked you in<PROMPT>"
    db "<NEXT>the northern"
    db "<NEXT>forest?<PROMPT>"
    db "<NEXT>I'm surprised to"
    db "<NEXT>see you alive.<PROMPT>"
    db "<NEXT>Um… Are you maybe"
    db "<NEXT>really tough?<WAIT>"
    db "@"

String_99_4B35_00_1C::
    db "<VOICE2>*: That dealer is a<LINE>"
    db "greedy hound!<PROMPT>"
    db "<NEXT>He won't tell me"
    db "<NEXT>where he gets his<PROMPT>"
    db "<NEXT>merchandise, the"
    db "<NEXT>cheapskate!<WAIT>"
    db "@"

String_99_4B35_00_1D::
    db "<VOICE1>*: For 47,000G this<LINE>"
    db "earring… What?<PROMPT>"
    db "<NEXT>You went to the"
    db "<NEXT>northern forest?<PROMPT>"
    db "<NEXT>Monsters didn't"
    db "<NEXT>attack you?<WAIT>"
    db "@"

String_99_4B35_00_1E::
    db "<VOICE1>*: You defeated the<LINE>"
    db "monsters?<PROMPT>"
    db "<NEXT>You're not joking,"
    db "<NEXT>are you?<WAIT>"
    db "@"

String_99_4B35_00_1F::
    db "<VOICE1>*: You defeated the<LINE>"
    db "monsters…<PROMPT>"
    db "<NEXT>…You're not joking,"
    db "<NEXT>are you?<WAIT>"
    db "@"

String_99_4B35_00_20::
    db "<VOICE2>*: Are you Milayou's<LINE>"
    db "friend?<PROMPT>"
    db "<NEXT>The little monster"
    db "<NEXT>master?<PROMPT>"
    db "<NEXT>You're after the"
    db "<NEXT>bad monsters aren't<PROMPT>"
    db "<NEXT>you? That is just"
    db "<NEXT>so neat!<WAIT>"
    db "@"

String_99_4B35_00_21::
    db "<VOICE1>*: If a monster<LINE>"
    db "could be good or<PROMPT>"
    db "<NEXT>bad, does that"
    db "<NEXT>mean there are<PROMPT>"
    db "<NEXT>both good masters"
    db "<NEXT>and bad ones?<WAIT>"
    db "@"

String_99_4B35_00_22::
    db "<VOICE1>*: Don't you think<LINE>"
    db "it's odd that the<PROMPT>"
    db "<NEXT>monsters are after"
    db "<NEXT>treasures?<PROMPT>"
    db "<NEXT>I can understand"
    db "<NEXT>if they went for<PROMPT>"
    db "<NEXT>food, but…"
    db "<NEXT><WAIT>"
    db "@"

String_99_4B35_00_23::
    db "<VOICE2>*: Arrrgh! This is<LINE>"
    db "so infuriating!<PROMPT>"
    db "<NEXT>The monsters took"
    db "<NEXT>my lingerie again!<PROMPT>"
    db "<NEXT>What exactly would"
    db "<NEXT>they want with my<PROMPT>"
    db "<NEXT>underwear anyway?"
    db "<NEXT>It makes no sense!<WAIT>"
    db "@"

String_99_4B35_00_24::
    db "<BUF0> showed the<LINE>"
    db "Pretty Ring.<WAIT>"
    db "@"

String_99_4B35_00_25::
    db "<VOICE1>*: Ah… That ring…<LINE>"
    db "Is… Is it…<PROMPT>"
    db "<NEXT>That's my daughter's"
    db "<NEXT>ring!<WAIT>"
    db "@"

String_99_4B35_00_26::
    db "<BUF0> handed over<LINE>"
    db "the Pretty Ring.<WAIT>"
    db "@"

String_99_4B35_00_27::
    db "<VOICE1>*: Thank you for<LINE>"
    db "getting the ring<PROMPT>"
    db "<NEXT>back for me."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>But things haven't"
    db "<NEXT>been good for us.<PROMPT>"
    db "<NEXT>First, there was a"
    db "<NEXT>traveling dealer<PROMPT>"
    db "<NEXT>who was terribly"
    db "<NEXT>pushy and rude.<PROMPT>"
    db "<NEXT>He also stared at"
    db "<NEXT>our belongings.<PROMPT>"
    db "<NEXT>We had to throw"
    db "<NEXT>him out.<WAIT>"
    db "@"

String_99_4B35_00_28::
    db "<VOICE1>*: Things haven't<LINE>"
    db "been good for us.<PROMPT>"
    db "<NEXT>There was a"
    db "<NEXT>traveling dealer<PROMPT>"
    db "<NEXT>who was terribly"
    db "<NEXT>pushy and rude.<PROMPT>"
    db "<NEXT>He also stared at"
    db "<NEXT>our belongings.<PROMPT>"
    db "<NEXT>We had to throw"
    db "<NEXT>him out.<WAIT>"
    db "@"

String_99_4B35_00_29::
    db "<VOICE2>*: Thank you for<LINE>"
    db "recovering our<PROMPT>"
    db "<NEXT>daughter's ring."
    db "<NEXT>As a show of our<PROMPT>"
    db "<NEXT>thanks, would you"
    db "<NEXT>accept this?<WAIT>"
    db "@"

String_99_4B35_00_2A::
    db "<BUF0> received a<LINE>"
    db "SageRock.<WAIT>"
    db "@"

String_99_4B35_00_2B::
    db "<BUF0> received a<LINE>"
    db "SageRock.<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> gave back"
    db "<NEXT>the SageRock.<WAIT>"
    db "@"

String_99_4B35_00_2C::
    db "<VOICE2>*: We are grateful<LINE>"
    db "that you recovered<PROMPT>"
    db "<NEXT>our daughter's"
    db "<NEXT>ring. As a show of<PROMPT>"
    db "<NEXT>our thanks, would"
    db "<NEXT>you accept this?<WAIT>"
    db "@"

String_99_4B35_00_2D::
    db "<VOICE2>*: We are grateful<LINE>"
    db "that you recovered<PROMPT>"
    db "<NEXT>our daughter's"
    db "<NEXT>ring.<WAIT>"
    db "@"

String_99_4B35_00_2E::
    db "<VOICE1>*: The old couple<LINE>"
    db "look happy after<PROMPT>"
    db "<NEXT>they got their"
    db "<NEXT>treasure back.<WAIT>"
    db "@"

String_99_4B35_00_2F::
    db "<VOICE2>*: I'm so glad the<LINE>"
    db "people across the<PROMPT>"
    db "<NEXT>way got back their"
    db "<NEXT>stolen treasure.<WAIT>"
    db "@"

String_99_4B35_00_30::
    db "<VOICE1>*: What do those<LINE>"
    db "monsters do with<PROMPT>"
    db "<NEXT>the things that"
    db "<NEXT>they steal?<PROMPT>"
    db "<NEXT>If it were me, I", $44
    db "<NEXT>act as a fence and<PROMPT>"
    db "<NEXT>sell them on the"
    db "<NEXT>sly for big money…<PROMPT>"
    db "<NEXT>I'm only joking!"
    db "<NEXT>Just a joke!<WAIT>"
    db "@"

String_99_4B35_00_31::
    db "<VOICE2>Milayou: I've been<LINE>"
    db "checking around,<PROMPT>"
    db "<NEXT>and I think the"
    db "<NEXT>evidence is clear.<PROMPT>"
    db "<NEXT>Somebody is behind"
    db "<NEXT>the monsters.<PROMPT>"
    db "<NEXT>It's the work of a"
    db "<NEXT>dark master.<PROMPT>"
    db "<NEXT>I don't know who"
    db "<NEXT>it is, though.<PROMPT>"
    db "<NEXT>Do you have any"
    db "<NEXT>idea who?<WAIT>"
    db "@"

String_99_4B35_00_32::
    db "<VOICE1>*: I dug deep in my<LINE>"
    db "purse to buy from<PROMPT>"
    db "<NEXT>that dealer, but"
    db "<NEXT>that ornament, it<PROMPT>"
    db "<NEXT>was the one stolen"
    db "<NEXT>from my neighbor.<PROMPT>"
    db "<NEXT>What sort of"
    db "<NEXT>nonsense is this?<WAIT>"
    db "@"

String_99_4B35_00_33::
    db "<VOICE1>*: The thieving<LINE>"
    db "monsters had a<PROMPT>"
    db "<NEXT>boss, didn't they?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>He must be a sly"
    db "<NEXT>scoundrel to let<PROMPT>"
    db "<NEXT>his underlings do"
    db "<NEXT>his dirty deeds.<WAIT>"
    db "@"

String_99_4B35_00_34::
    db "<VOICE1>*: What? Where", $44, " I<LINE>"
    db "get my wares?<PROMPT>"
    db "<NEXT>Uh… Erm… Whoops!"
    db "<NEXT>Look at the time!<PROMPT>"
    db "<NEXT>Out of the way,"
    db "<NEXT>I'm late!<WAIT>"
    db "@"

String_99_4B35_00_35::
    db "<VOICE2>*: That greedhound<LINE>"
    db "dealer scuttled<PROMPT>"
    db "<NEXT>off in an awful"
    db "<NEXT>hurry.<WAIT>"
    db "@"

String_99_4B35_00_36::
    db "<VOICE2>Milayou: I thought<LINE>"
    db "this forest looked<PROMPT>"
    db "<NEXT>suspicious, so I"
    db "<NEXT>was investigating…<PROMPT>"
    db "<NEXT>I was jumped from"
    db "<NEXT>behind and my<PROMPT>"
    db "<NEXT>party was crushed"
    db "<NEXT>just like that.<PROMPT>"
    db "<NEXT>A man, he looked"
    db "<NEXT>like a dealer, was<PROMPT>"
    db "<NEXT>commanding the"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>He must have been"
    db "<NEXT>the mastermind.<PROMPT>"
    db "<NEXT>The dark master"
    db "<NEXT>went into the<PROMPT>"
    db "<NEXT>tower. Please go"
    db "<NEXT>after him for me!<WAIT>"
    db "@"

String_99_4B35_00_37::
    db "<VOICE2>Milayou: Please<LINE>"
    db "defeat the dark<PROMPT>"
    db "<NEXT>master and bring"
    db "<NEXT>him to justice!<WAIT>"
    db "@"

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
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained"
    db "<NEXT>the MoonRock.<WAIT>"
    db "@"

String_99_6366_00_01::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>There was the"
    db "<NEXT>MoonRock inside.<PROMPT>"
    db "<NEXT>But there was no"
    db "<NEXT>room for it.<WAIT>"
    db "@"

String_99_6366_00_02::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>It smelled of"
    db "<NEXT>grilled fish.<WAIT>"
    db "@"

String_99_6366_00_03::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>merchandise.<WAIT>"
    db "@"

String_99_6366_00_04::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Welcome to the"
    db "<NEXT>Port of Polona!<PROMPT>"
    db "<NEXT>Frolic with"
    db "<NEXT>mermaids…", $95, "<WAIT>"
    db "@"

String_99_6366_00_05::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>There were tourist"
    db "<NEXT>pamphlets inside.<PROMPT>"
    db "<NEXT>'Infinitely clear"
    db "<NEXT>blue waters and<PROMPT>"
    db "<NEXT>playful mermaids"
    db "<NEXT>await you!", $95, "<WAIT>"
    db "@"

String_99_6366_00_06::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>Two shiny pots"
    db "<NEXT>were inside.<WAIT>"
    db "@"

String_99_6366_00_07::
    db "<VOICE2>*: This is the<LINE>"
    db "mermaid kingdom.<PROMPT>"
    db "<NEXT>Did you want to go"
    db "<NEXT>home?<CHOICE>"
    db "@"

String_99_6366_00_08::
    db "<VOICE2>*: Close your eyes<LINE>"
    db "for a little bit…<WAIT>"
    db "@"

String_99_6366_00_09::
    db "<VOICE2>*: Oh. Tell me if<LINE>"
    db "you want to go.<WAIT>"
    db "@"

String_99_6366_00_0A::
    db "<VOICE1>Kameha: Aiyeeeeeh…<LINE>"
    db "<WAIT>"
    db "@"

String_99_6366_00_0B::
    db "<VOICE1>*: …Your monsters<LINE>"
    db "appear dispirited…<PROMPT>"
    db "<NEXT>It's unfortunate,"
    db "<NEXT>but next time.<WAIT>"
    db "@"

String_99_6366_00_0C::
    db "Thick, suction-<LINE>"
    db "cupped tentacles<PROMPT>"
    db "<NEXT>snaked out of the"
    db "<NEXT>whirlpool!<WAIT>"
    db "@"

String_99_6366_00_0D::
    db "The raging sea<LINE>"
    db "calmed, and the<PROMPT>"
    db "<NEXT>whirlpool smoothed"
    db "<NEXT>to nothing.<WAIT>"
    db "@"

String_99_6366_00_0E::
    db "<VOICE2>*: Father put up a<LINE>"
    db "bridge across to<PROMPT>"
    db "<NEXT>that tiny island."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>We have more room"
    db "<NEXT>for monsters now.<WAIT>"
    db "@"

String_99_6366_00_1A::
    db "<VOICE2>*: Oh? You'll run<LINE>"
    db "another errand?<CHOICE>"
    db "@"

String_99_6366_00_1B::
    db "<VOICE2>*: My, what has<LINE>"
    db "gotten into you?<PROMPT>"
    db "<NEXT>Will miracles"
    db "<NEXT>never cease?<PROMPT>"
    db "<NEXT>Could you go buy a"
    db "<NEXT>Potion for me?<PROMPT>"
    db "<NEXT>Father's run down"
    db "<NEXT>from overwork.<WAIT>"
    db "@"

String_99_6366_00_1C::
    db "Mama handed over<LINE>"
    db "400G.<WAIT>"
    db "@"

String_99_6366_00_1D::
    db "<VOICE2>*: No miracles<LINE>"
    db "today! Oh, well.<PROMPT>"
    db "<NEXT>Of course, off you"
    db "<NEXT>go and play!<WAIT>"
    db "@"

String_99_6366_00_1E::
    db "<VOICE2>*: I need you to<LINE>"
    db "get me a Potion.<WAIT>"
    db "@"

String_99_6366_00_1F::
    db "<VOICE2>*: Oh… You've found<LINE>"
    db "what I wanted.<PROMPT>"
    db "<NEXT>I knew I could"
    db "<NEXT>count on you!<WAIT>"
    db "@"

String_99_6366_00_20::
    db "<BUF0> handed over<LINE>"
    db "the Potion.<WAIT>"
    db "@"

String_99_6366_00_21::
    db "<VOICE2>*: Well, could you<LINE>"
    db "go buy a Rib?<PROMPT>"
    db "<NEXT>It'll be a change"
    db "<NEXT>from fish.<WAIT>"
    db "@"

String_99_6366_00_22::
    db "Mama handed over<LINE>"
    db "600G.<WAIT>"
    db "@"

String_99_6366_00_23::
    db "<VOICE2>*: I want you to<LINE>"
    db "buy me a Rib.<WAIT>"
    db "@"

String_99_6366_00_24::
    db "<BUF0> handed over<LINE>"
    db "the Rib.<WAIT>"
    db "@"

String_99_6366_00_26::
    db "<VOICE2>*: Thanks, <BUF0>!<LINE>"
    db "You're great help!<WAIT>"
    db "@"

String_99_6366_00_27::
    db "<VOICE1>*: My father was a<LINE>"
    db "Slime and Mama was<PROMPT>"
    db "<NEXT>a MiniDrak, and"
    db "<NEXT>I'm neither.<PROMPT>"
    db "<NEXT>When the parents"
    db "<NEXT>are different, the<PROMPT>"
    db "<NEXT>offspring are"
    db "<NEXT>different too.<WAIT>"
    db "@"

String_99_6366_00_28::
    db "<VOICE1>*: Beavern helped<LINE>"
    db "put up the bridge.<PROMPT>"
    db "<NEXT>It's a solid piece"
    db "<NEXT>of work, this!<PROMPT>"
    db "<NEXT>An underground"
    db "<NEXT>stable is next,<PROMPT>"
    db "<NEXT>or at least if I"
    db "<NEXT>can get help.<PROMPT>"
    db "<NEXT>Have you seen any"
    db "<NEXT>MadGophers?<CHOICE>"
    db "@"

String_99_6366_00_29::
    db "<VOICE1>*: I", $44, " like to get<LINE>"
    db "help for digging.<PROMPT>"
    db "<NEXT>Could you befriend"
    db "<NEXT>a MadGopher?<WAIT>"
    db "@"

String_99_6366_00_2A::
    db "<VOICE1>*: If one joins<LINE>"
    db "you, could you<PROMPT>"
    db "<NEXT>bring it home to"
    db "<NEXT>meet me?<WAIT>"
    db "@"

String_99_6366_00_2B::
    db "<VOICE1>*: A MadGopher<LINE>"
    db "joined you?<PROMPT>"
    db "<NEXT>Could you pass it"
    db "<NEXT>over to me?<PROMPT>"
    db "<NEXT>…But that will"
    db "<NEXT>leave you alone…<WAIT>"
    db "@"

String_99_6366_00_2C::
    db "<VOICE1>*: A MadGopher<LINE>"
    db "joined you?<PROMPT>"
    db "<NEXT>Could you pass it"
    db "<NEXT>over to me?<CHOICE>"
    db "@"

String_99_6366_00_2D::
    db "<VOICE1>*: Great, <BUF0>!<LINE>"
    db "Thanks a lot!<PROMPT>"
    db "<NEXT>This will make the"
    db "<NEXT>farm more useful!<WAIT>"
    db "@"

String_99_6366_00_2E::
    db "<VOICE1>*: <BUF0>, I need<LINE>"
    db "your help.<PROMPT>"
    db "<NEXT>Please get me a"
    db "<NEXT>MadGopher.<WAIT>"
    db "@"

String_99_6366_00_2F::
    db "<VOICE1>*: MadGopher's been<LINE>"
    db "a great help.<PROMPT>"
    db "<NEXT>The excavation"
    db "<NEXT>should go quickly.<WAIT>"
    db "@"

String_99_6366_00_30::
    db "<VOICE1>*: I've finished<LINE>"
    db "working.<PROMPT>"
    db "<NEXT>Can I go with you"
    db "<NEXT>again?<CHOICE>"
    db "@"

String_99_6366_00_31::
    db "<VOICE1>*: I'm counting on<LINE>"
    db "you!<WAIT>"
    db "@"

String_99_6366_00_32::
    db "<VOICE1>*: …But you have no<LINE>"
    db "room for me…<WAIT>"
    db "@"

String_99_6366_00_33::
    db "<VOICE1>*: Tch, I thought I<LINE>"
    db "could help you…<WAIT>"
    db "@"

String_99_6366_00_34::
    db "<VOICE1>*: You have to tamp<LINE>"
    db "the ground firmly<PROMPT>"
    db "<NEXT>around where you"
    db "<NEXT>do your digging.<WAIT>"
    db "@"

String_99_6366_00_35::
    db "<VOICE1>Cobi: <BUF0>, what<LINE>"
    db "was it like in the<PROMPT>"
    db "<NEXT>other worlds?"
    db "<NEXT>I", $44, " like to know.<PROMPT>"
    db "<NEXT>…Oh… Kameha's out"
    db "<NEXT>there too.<PROMPT>"
    db "<NEXT>No wonder he hasn't"
    db "<NEXT>been around.<PROMPT>"
    db "<NEXT>There's a bridge"
    db "<NEXT>over to the next<PROMPT>"
    db "<NEXT>island, so the"
    db "<NEXT>farm grew a bit<PROMPT>"
    db "<NEXT>bigger."
    db "<NEXT>So, what can I do<PROMPT>"
    db "<NEXT>for you, sis?"
    db "<NEXT><WAIT>"
    db "@"

String_99_6366_00_36::
    db "<VOICE2>Tara: Big brother,<LINE>"
    db "tell me about your<PROMPT>"
    db "<NEXT>adventures in"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>…Oh… The Prince is"
    db "<NEXT>searching too.<PROMPT>"
    db "<NEXT>Papa put a bridge"
    db "<NEXT>over to that tiny<PROMPT>"
    db "<NEXT>island, so the"
    db "<NEXT>farm is bigger.<PROMPT>"
    db "<NEXT>You can leave more"
    db "<NEXT>monsters now.<PROMPT>"
    db "<NEXT>Do you need me for"
    db "<NEXT>anything?<WAIT>"
    db "@"

String_99_6366_00_37::
    db "<VOICE1>*: Including the<LINE>"
    db "monsters with you,<PROMPT>"
    db "<NEXT>the farm can hold"
    db "<NEXT>up to 30 now.<PROMPT>"
    db "<NEXT>Expansion added to"
    db "<NEXT>capacity.<PROMPT>"
    db "<NEXT>Monsters in the"
    db "<NEXT>farm earn some<PROMPT>"
    db "<NEXT>EX points as you"
    db "<NEXT>battle.<PROMPT>"
    db "<NEXT>But if you leave"
    db "<NEXT>them in the farm,<PROMPT>"
    db "<NEXT>they will grow"
    db "<NEXT>without learning<PROMPT>"
    db "<NEXT>skills, and they"
    db "<NEXT>turn disobedient.<PROMPT>"
    db "<NEXT>So, you should"
    db "<NEXT>take different<PROMPT>"
    db "<NEXT>monsters out for"
    db "<NEXT>training.<WAIT>"
    db "@"

String_99_6366_00_38::
    db "<VOICE1>*: Master only<LINE>"
    db "makes me charge.<PROMPT>"
    db "<NEXT>It made me more"
    db "<NEXT>courageous!<WAIT>"
    db "@"

String_99_6366_00_39::
    db "<VOICE1>*: We get more and<LINE>"
    db "more stubborn as<PROMPT>"
    db "<NEXT>we grow to higher"
    db "<NEXT>levels.<PROMPT>"
    db "<NEXT>Our personalities"
    db "<NEXT>don't change much,<PROMPT>"
    db "<NEXT>once we get old."
    db "<NEXT>Fwohohoho!<WAIT>"
    db "@"

String_99_6366_00_3A::
    db "<VOICE1>*: Hey! You're the<LINE>"
    db "kid who said the<PROMPT>"
    db "<NEXT>island was going"
    db "<NEXT>to sink!<PROMPT>"
    db "<NEXT>I believed you and"
    db "<NEXT>sailed off, but<PROMPT>"
    db "<NEXT>the island's still"
    db "<NEXT>here!<PROMPT>"
    db "<NEXT>You rotten little"
    db "<NEXT>lie master!<WAIT>"
    db "@"

String_99_6366_00_3B::
    db "<VOICE1>*: I have nothing<LINE>"
    db "for a liar!<WAIT>"
    db "@"

String_99_6366_00_3C::
    db "<VOICE2>*: To take off an<LINE>"
    db "accessory, just<PROMPT>"
    db "<NEXT>put a different"
    db "<NEXT>accessory on.<PROMPT>"
    db "<NEXT>Try equipping a"
    db "<NEXT>D-Scale, that will<PROMPT>"
    db "<NEXT>remove whatever is"
    db "<NEXT>equipped.<PROMPT>"
    db "<NEXT>It's common"
    db "<NEXT>knowledge!<WAIT>"
    db "@"

String_99_6366_00_3D::
    db "<VOICE2>*: The woman next<LINE>"
    db "to me, she repeats<PROMPT>"
    db "<NEXT>whatever she hears"
    db "<NEXT>from other people<PROMPT>"
    db "<NEXT>and acts smart."
    db "<NEXT>What a Copycat…<WAIT>"
    db "@"

String_99_6366_00_3E::
    db "<VOICE1>*: I want to open<LINE>"
    db "up a shop here,<PROMPT>"
    db "<NEXT>but I need help"
    db "<NEXT>unloading my ship.<PROMPT>"
    db "<NEXT>I heard an ArmyAnt"
    db "<NEXT>can carry things<PROMPT>"
    db "<NEXT>much bigger than"
    db "<NEXT>itself.<PROMPT>"
    db "<NEXT>Yep, an ArmyAnt"
    db "<NEXT>would be helpful…<WAIT>"
    db "@"

String_99_6366_00_3F::
    db "<VOICE1>*: Wait! Could I<LINE>"
    db "get you to leave<PROMPT>"
    db "<NEXT>your Army Ant with"
    db "<NEXT>me?<PROMPT>"
    db "<NEXT>Oh… But that would"
    db "<NEXT>leave you alone…<WAIT>"
    db "@"

String_99_6366_00_41::
    db "<VOICE1>*: Wait! Could I<LINE>"
    db "get you to leave<PROMPT>"
    db "<NEXT>your Army Ant with"
    db "<NEXT>me?<CHOICE>"
    db "@"

String_99_6366_00_42::
    db "<VOICE1>*: Fantastic! I can<LINE>"
    db "open my shop now!<WAIT>"
    db "@"

String_99_6366_00_43::
    db "<VOICE1>*: Oh… That's very<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>I could have my"
    db "<NEXT>shop quickly too…<WAIT>"
    db "@"

String_99_6366_00_44::
    db "<VOICE1>*: ArmyAnt helped<LINE>"
    db "me get my shop up.<PROMPT>"
    db "<NEXT>Would you care to"
    db "<NEXT>see my wares?<WAIT>"
    db "@"

String_99_6366_00_45::
    db "<VOICE1>*: Welcome! How may<LINE>"
    db "I serve you?<WAIT>"
    db "@"

String_99_6366_00_46::
    db "<BUF0> checked the<LINE>"
    db "door.<PROMPT>"
    db "<NEXT>The door won't open"
    db "<NEXT>with any key.<WAIT>"
    db "@"

String_99_6366_00_47::
    db "<VOICE1>*: Many trees have<LINE>"
    db "submerged…<PROMPT>"
    db "<NEXT>The island seems"
    db "<NEXT>to be undergoing<PROMPT>"
    db "<NEXT>an unwelcome"
    db "<NEXT>change…<WAIT>"
    db "@"

String_99_6366_00_48::
    db "<VOICE2>*: Um… I'm the Egg<LINE>"
    db "Evaluator.<PROMPT>"
    db "<NEXT>You don't know who"
    db "<NEXT>I am… Right?<PROMPT>"
    db "<NEXT>Um… All monsters"
    db "<NEXT>hatch from eggs.<PROMPT>"
    db "<NEXT>I check your eggs"
    db "<NEXT>to determine the<PROMPT>"
    db "<NEXT>gender of the"
    db "<NEXT>monster inside.<PROMPT>"
    db "<NEXT>I can also sing a"
    db "<NEXT>song to change the<PROMPT>"
    db "<NEXT>gender of the"
    db "<NEXT>monster in an egg.<PROMPT>"
    db "<NEXT>May I help you in"
    db "<NEXT>any way today?<WAIT>"
    db "@"

String_99_6366_00_49::
    db "<VOICE2>*: I'm the Egg<LINE>"
    db "Evaluator.<PROMPT>"
    db "<NEXT>May I help you in"
    db "<NEXT>any way today?<WAIT>"
    db "@"

String_99_6366_00_4A::
    db "<VOICE1>*: The Evaluator<LINE>"
    db "said I had an<PROMPT>"
    db "<NEXT>amazing egg."
    db "<NEXT>But I stumbled on<PROMPT>"
    db "<NEXT>the stairs and"
    db "<NEXT>almost broke it.<WAIT>"
    db "@"

String_99_6366_00_4B::
    db "<VOICE2>*: Go down these<LINE>"
    db "stairs to the<PROMPT>"
    db "<NEXT>Starry Shrine."
    db "<NEXT><WAIT>"
    db "@"

String_99_6366_00_4C::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Starry Shrine.<PROMPT>"
    db "<NEXT>I'm Professor"
    db "<NEXT>Monster.<PROMPT>"
    db "<NEXT>I have the run of"
    db "<NEXT>the place while I<PROMPT>"
    db "<NEXT>study monsters and"
    db "<NEXT>their breeding.<PROMPT>"
    db "<NEXT>I can help you"
    db "<NEXT>breed monsters<PROMPT>"
    db "<NEXT>and hatch the eggs"
    db "<NEXT>that result.<PROMPT>"
    db "<NEXT>So, what do you"
    db "<NEXT>need of me today?<WAIT>"
    db "@"

String_99_6366_00_4D::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Starry Shrine.<PROMPT>"
    db "<NEXT>What do you need"
    db "<NEXT>of me today?<WAIT>"
    db "@"

String_99_6366_00_4E::
    db "<VOICE1>*: I'm the Prof's<LINE>"
    db "assistant.<PROMPT>"
    db "<NEXT>Do you want to"
    db "<NEXT>hear about the<PROMPT>"
    db "<NEXT>Starry Shrine?"
    db "<NEXT><CHOICE>"
    db "@"

String_99_6366_00_4F::
    db "<VOICE1>*: You can breed<LINE>"
    db "monsters and hatch<PROMPT>"
    db "<NEXT>their eggs here at"
    db "<NEXT>the Starry Shrine.<PROMPT>"
    db "<NEXT>Breeding happens"
    db "<NEXT>when two monsters<PROMPT>"
    db "<NEXT>get married to"
    db "<NEXT>each other.<PROMPT>"
    db "<NEXT>Their egg contains"
    db "<NEXT>a monster that<PROMPT>"
    db "<NEXT>has the abilities"
    db "<NEXT>of the parents.<PROMPT>"
    db "<NEXT>We can hatch that"
    db "<NEXT>egg for you too.<PROMPT>"
    db "<NEXT>The parents will"
    db "<NEXT>go away somewhere,<PROMPT>"
    db "<NEXT>but you won't lose"
    db "<NEXT>accessories.<PROMPT>"
    db "<NEXT>Those get sent to"
    db "<NEXT>the Vault.<WAIT>"
    db "@"

String_99_6366_00_50::
    db "<VOICE1>*: Talk to the Prof<LINE>"
    db "if you need help.<WAIT>"
    db "@"

String_99_6366_00_51::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Breeding Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>In breeding, the"
    db "<NEXT>monster chosen as<PROMPT>"
    db "<NEXT>the base sets the"
    db "<NEXT>baby's family.<PROMPT>"
    db "<NEXT>If a Slime family"
    db "<NEXT>monster is chosen<PROMPT>"
    db "<NEXT>as the base, the"
    db "<NEXT>baby will also be<PROMPT>"
    db "<NEXT>of the Slime"
    db "<NEXT>family.<PROMPT>"
    db "<NEXT>And if a Dragon"
    db "<NEXT>family monster is<PROMPT>"
    db "<NEXT>the base monster,"
    db "<NEXT>the baby will also<PROMPT>"
    db "<NEXT>be of the Dragon"
    db "<NEXT>family.", $95, "<WAIT>"
    db "@"

String_99_6366_00_52::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Breeding Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>In breeding, the"
    db "<NEXT>families and the<PROMPT>"
    db "<NEXT>species of the"
    db "<NEXT>parents determine<PROMPT>"
    db "<NEXT>the species of the"
    db "<NEXT>baby.<PROMPT>"
    db "<NEXT>Changing the mix"
    db "<NEXT>of families and<PROMPT>"
    db "<NEXT>species results in"
    db "<NEXT>different babies.", $95, "<WAIT>"
    db "@"

String_99_6366_00_53::
    db $ea

String_99_6366_00_63::
    db $f0
    ds $112, $00
