; ROM bank $97: string tables
; The annotated listing of this bank is build/listing/bank97.asm.

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
    db "<VOICE1>*: You have raised<LINE>"
    db "your charges well.<PROMPT>"
    db "<NEXT>Test them against"
    db "<NEXT>me!<WAIT>"
    db "@"

String_97_4095_00_01::
    db "<VOICE1>*: What? How did<LINE>"
    db "you get here?<PROMPT>"
    db "<NEXT>Arrgh, don't meddle"
    db "<NEXT>in my affairs!<WAIT>"
    db "@"

String_97_4095_00_02::
    db "<VOICE1>*: All those who<LINE>"
    db "stood before me<PROMPT>"
    db "<NEXT>I shattered with"
    db "<NEXT>these hands!<WAIT>"
    db "@"

String_97_4095_00_03::
    db "<VOICE1>*: Let me show you<LINE>"
    db "why your monsters<PROMPT>"
    db "<NEXT>can't stop shaking!"
    db "<NEXT><WAIT>"
    db "@"

String_97_4095_00_04::
    db "<VOICE1>*: We can connect<LINE>"
    db "only in battle.<PROMPT>"
    db "<NEXT>Get ready!"
    db "<NEXT><WAIT>"
    db "@"

String_97_4095_00_05::
    db "<VOICE1>*: Power is the<LINE>"
    db "basis of all!<PROMPT>"
    db "<NEXT>Your words are"
    db "<NEXT>meaningless!<WAIT>"
    db "@"

String_97_4095_00_06::
    db "<VOICE1>*: If you wish to<LINE>"
    db "pass, you'll have<PROMPT>"
    db "<NEXT>to beat me. There's"
    db "<NEXT>no other way!<WAIT>"
    db "@"

String_97_4095_00_07::
    db "<VOICE1>*: You're going to<LINE>"
    db "beat the boss?<PROMPT>"
    db "<NEXT>You have me to"
    db "<NEXT>deal with first!<WAIT>"
    db "@"

String_97_4095_00_08::
    db "<VOICE1>*: Courage alone<LINE>"
    db "won't let you win!<WAIT>"
    db "@"

String_97_4095_00_09::
    db "<VOICE1>*: So long as I<LINE>"
    db "stand, no one, but<PROMPT>"
    db "<NEXT>no one gets by"
    db "<NEXT>here!<WAIT>"
    db "@"

String_97_4095_00_0A::
    db "<VOICE1>*: Oh? There still<LINE>"
    db "was someone with<PROMPT>"
    db "<NEXT>a little spine?"
    db "<NEXT>Fwahahaha!<WAIT>"
    db "@"

String_97_4095_00_0B::
    db "<VOICE1>*: What? I'm busy!<LINE>"
    db "Make it quick!<WAIT>"
    db "@"

String_97_4095_00_0C::
    db "<VOICE1>*: Curse your luck<LINE>"
    db "for coming here!<WAIT>"
    db "@"

String_97_4095_00_0D::
    db "<VOICE1>*: You think I<LINE>"
    db "look weak! Don't<PROMPT>"
    db "<NEXT>you deny it!"
    db "<NEXT>I can tell!<WAIT>"
    db "@"

String_97_4095_00_0E::
    db "<VOICE1>*: Just how much<LINE>"
    db "are you willing to<PROMPT>"
    db "<NEXT>sacrifice before"
    db "<NEXT>you give up?<WAIT>"
    db "@"

String_97_4095_00_0F::
    db "<VOICE1>*: Hyahyahya!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>Another weakling"
    db "<NEXT>come to amuse me!<WAIT>"
    db "@"

String_97_4095_00_10::
    db "<VOICE1>*: Too late for<LINE>"
    db "regrets now.<PROMPT>"
    db "<NEXT>I'll show you my"
    db "<NEXT>true strength!<WAIT>"
    db "@"

String_97_4095_00_11::
    db "<VOICE1>*: Try to keep me<LINE>"
    db "amused at least.<WAIT>"
    db "@"

String_97_4095_00_12::
    db "<VOICE1>*: Hah! You're too<LINE>"
    db "weak to take me!<WAIT>"
    db "@"

String_97_4095_00_13::
    db "<VOICE1>*: The boss is<LINE>"
    db "beyond here.<PROMPT>"
    db "<NEXT>I can't let the"
    db "<NEXT>likes of you pass.<WAIT>"
    db "@"

String_97_4095_00_14::
    db "<VOICE1>*: I've still got<LINE>"
    db "enough power to<PROMPT>"
    db "<NEXT>brush off a green"
    db "<NEXT>master like you!<WAIT>"
    db "@"

String_97_4095_00_15::
    db "<VOICE1>*: Fufufu… There is<LINE>"
    db "only winning or<PROMPT>"
    db "<NEXT>losing in battle,"
    db "<NEXT>and nothing else.<WAIT>"
    db "@"

String_97_4095_00_16::
    db "Get a tenth off<LINE>"
    db "the shop prices.@"

String_97_4095_00_1A::
    db "Use to create a<LINE>"
    db "door shrine.@"

String_97_4095_00_1B::
    db "It is an item with<LINE>"
    db "a magical power.@"

String_97_4095_00_1C::
    db "<VOICE1>*: Hello! What can<LINE>"
    db "I do for you?<WAIT>"
    db "@"

String_97_4095_00_21::
    db "THE END…@"

String_97_4095_00_22::
    db "<VOICE2>*: You have to eat<LINE>"
    db "your vegetables!<PROMPT>"
    db "<NEXT><BUF0> was force-"
    db "<NEXT>fed an INT Seed!<WAIT>"
    db "@"

String_97_4095_00_23::
    db "<VOICE1>*: Hey, that's mine!<LINE>"
    db "<PROMPT>"
    db "<NEXT><BUF0> obtained a"
    db "<NEXT>TinyMedal.<WAIT>"
    db "@"

String_97_4095_00_24::
    db "<VOICE1>Terry: Here, just<LINE>"
    db "take this.<PROMPT>"
    db "<NEXT><BUF0> received"
    db "<NEXT>10,000G!<WAIT>"
    db "@"

String_97_4095_00_25::
    db $9f, $9f, $9f, " Composing ", $9f, $9f, $9f, "<WAIT>"
    db "@"

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
    db "<VOICE1>*: Don't chase what<LINE>"
    db "runs from you.<PROMPT>"
    db "<NEXT>Lay some bait, and"
    db "<NEXT>let it come.<PROMPT>"
    db "<NEXT>That's the trick."
    db "<NEXT>Don't understand?<PROMPT>"
    db "<NEXT>The oasis is east"
    db "<NEXT>of here, beyond<PROMPT>"
    db "<NEXT>a range of craggy"
    db "<NEXT>mountains.<PROMPT>"
    db "<NEXT>Head for it, and"
    db "<NEXT>you'll see.<WAIT>"
    db "@"

String_97_474A_00_01::
    db "<VOICE1>*: We didn't help<LINE>"
    db "the thieves!<PROMPT>"
    db "<NEXT>One of their men"
    db "<NEXT>had joined the<PROMPT>"
    db "<NEXT>circus and used"
    db "<NEXT>us as a cover.<PROMPT>"
    db "<NEXT>We had no idea."
    db "<NEXT>Please, we should<PROMPT>"
    db "<NEXT>be released!"
    db "<NEXT><WAIT>"
    db "@"

String_97_474A_00_02::
    db "<VOICE1>King: The lake was<LINE>"
    db "in sight, but once<PROMPT>"
    db "<NEXT>we get this close,"
    db "<NEXT>it isn't there!<PROMPT>"
    db "<NEXT>We'll never be"
    db "<NEXT>able to find the<PROMPT>"
    db "<NEXT>hideout of the"
    db "<NEXT>thieves this way!<WAIT>"
    db "@"

String_97_474A_00_03::
    db "<VOICE1>*: We can see the<LINE>"
    db "hideout plainly,<PROMPT>"
    db "<NEXT>but where did the"
    db "<NEXT>lake disappear to?<WAIT>"
    db "@"

String_97_474A_00_04::
    db "<VOICE1>*: The prisoner in<LINE>"
    db "the dungeon said<PROMPT>"
    db "<NEXT>that he saw the"
    db "<NEXT>mirage lake.<PROMPT>"
    db "<NEXT>I wonder if he was"
    db "<NEXT>being truthful…<WAIT>"
    db "@"

String_97_474A_00_05::
    db "<VOICE1>*: How can we reach<LINE>"
    db "the hideout?<WAIT>"
    db "@"

String_97_474A_00_06::
    db "<VOICE2>*: Thieves drove us<LINE>"
    db "from our homes!<WAIT>"
    db "@"

String_97_474A_00_07::
    db "<VOICE1>*: The leader of<LINE>"
    db "the thieves is a<PROMPT>"
    db "<NEXT>terrible man!"
    db "<NEXT>He uses monsters!<WAIT>"
    db "@"

String_97_474A_00_08::
    db "<VOICE1>*: Heh, you have<LINE>"
    db "monsters in tow?<PROMPT>"
    db "<NEXT>You're not from"
    db "<NEXT>this world.<PROMPT>"
    db "<NEXT>I've come from the"
    db "<NEXT>same world as you.<PROMPT>"
    db "<NEXT>I've been wandering"
    db "<NEXT>through the other<PROMPT>"
    db "<NEXT>worlds seeking the"
    db "<NEXT>ultimate monster.<PROMPT>"
    db "<NEXT>I was promised a"
    db "<NEXT>strong monster by<PROMPT>"
    db "<NEXT>the Demon Lord of"
    db "<NEXT>Limbo in exchange<PROMPT>"
    db "<NEXT>for this world's"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>Come forth, my"
    db "<NEXT>pretty!<PROMPT>"
    db "<NEXT>Show them their"
    db "<NEXT>place!<WAIT>"
    db "@"

String_97_474A_00_09::
    db "<VOICE1>*: You again!<LINE>"
    db "You're determined!<PROMPT>"
    db "<NEXT>But it won't make"
    db "<NEXT>a difference!<WAIT>"
    db "@"

String_97_474A_00_0A::
    db "<VOICE1>*: You defeated my<LINE>"
    db "monster?<PROMPT>"
    db "<NEXT>Urggh…"
    db "<NEXT>Time to regroup!<WAIT>"
    db "@"

String_97_474A_00_0B::
    db "<VOICE1>King: You thieves!<LINE>"
    db "There's no escape!<PROMPT>"
    db "<NEXT>Repent for your"
    db "<NEXT>misdeeds, and sur…<PROMPT>"
    db "<NEXT>What? How did you"
    db "<NEXT>get… Ah, whatever!<PROMPT>"
    db "<NEXT>The thieves are in"
    db "<NEXT>there?<PROMPT>"
    db "<NEXT>You're safe now!"
    db "<NEXT>We're here!<WAIT>"
    db "@"

String_97_474A_00_0C::
    db "<VOICE1>King: Surrender<LINE>"
    db "and live!<WAIT>"
    db "@"

String_97_474A_00_0D::
    db "<VOICE1>*: Aiyeeh!<LINE>"
    db "Help me, boss!<WAIT>"
    db "@"

String_97_474A_00_0E::
    db "<VOICE1>*: Urgah! Mercy!<LINE>"
    db "I surrender!<WAIT>"
    db "@"

String_97_474A_00_0F::
    db "<VOICE1>King: Wahah! We've<LINE>"
    db "bagged the lot!<PROMPT>"
    db "<NEXT>Peace will be"
    db "<NEXT>restored among<PROMPT>"
    db "<NEXT>people and"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>You've been a great"
    db "<NEXT>help to us.<PROMPT>"
    db "<NEXT>I must reward your"
    db "<NEXT>efforts.<WAIT>"
    db "@"

String_97_474A_00_10::
    db "<VOICE1>King: This is the<LINE>"
    db "TidalBell.<PROMPT>"
    db "<NEXT>It's imbued with a"
    db "<NEXT>mystic power.<PROMPT>"
    db "<NEXT>What do you intend"
    db "<NEXT>to do with it?<PROMPT>"
    db "<NEXT>Hm? A plug for a"
    db "<NEXT>navel?<PROMPT>"
    db "<NEXT>Take this as my"
    db "<NEXT>thanks!<WAIT>"
    db "@"

String_97_474A_00_11::
    db "<BUF0> obtained the<LINE>"
    db "TidalBell.<WAIT>"
    db "@"

String_97_474A_00_12::
    db "<VOICE1>King: I've been a<LINE>"
    db "burden to you, but<PROMPT>"
    db "<NEXT>I'll be fine now."
    db "<NEXT>I know what to do.<PROMPT>"
    db "<NEXT>I will rule with"
    db "<NEXT>confidence.<PROMPT>"
    db "<NEXT>You will always be"
    db "<NEXT>welcome with us!<WAIT>"
    db "@"

String_97_474A_00_13::
    db "A voice echoed<LINE>"
    db "from nowhere…<WAIT>"
    db "@"

String_97_474A_00_14::
    db "<VOICE1>*: …Wa-hey!<LINE>"
    db "Can you hear me?<PROMPT>"
    db "<NEXT>I felt an odd"
    db "<NEXT>power stirring.<PROMPT>"
    db "<NEXT>You found a plug"
    db "<NEXT>for the Navel!<PROMPT>"
    db "<NEXT>I'll bring you"
    db "<NEXT>back! Don't move!<WAIT>"
    db "@"

String_97_474A_00_15::
    db "<VOICE1>*: The King caught<LINE>"
    db "the thieves!<WAIT>"
    db "@"

String_97_474A_00_16::
    db "<VOICE2>*: The last king<LINE>"
    db "was a great man.<PROMPT>"
    db "<NEXT>Our King takes"
    db "<NEXT>after him!<WAIT>"
    db "@"

String_97_474A_00_17::
    db "<VOICE1>*: We recovered<LINE>"
    db "everything that<PROMPT>"
    db "<NEXT>was taken from us."
    db "<NEXT><WAIT>"
    db "@"

String_97_474A_00_18::
    db "<VOICE2>*: The circus has<LINE>"
    db "moved onto the<PROMPT>"
    db "<NEXT>town, and they got"
    db "<NEXT>there safely.<WAIT>"
    db "@"

String_97_474A_00_19::
    db "<VOICE1>*: His Majesty's<LINE>"
    db "popularity has<PROMPT>"
    db "<NEXT>been growing like"
    db "<NEXT>wildfire.<PROMPT>"
    db "<NEXT>So much for idle"
    db "<NEXT>rumors.<WAIT>"
    db "@"

String_97_474A_00_1A::
    db "<VOICE1>*: Making a hideout<LINE>"
    db "in Mirage Lake…<PROMPT>"
    db "<NEXT>No wonder they"
    db "<NEXT>avoided detection!<WAIT>"
    db "@"

String_97_474A_00_1B::
    db "<VOICE1>*: They let us out<LINE>"
    db "when they realized<PROMPT>"
    db "<NEXT>that we were also"
    db "<NEXT>victims like them.<PROMPT>"
    db "<NEXT>Indeed, it was a"
    db "<NEXT>double whammy!<WAIT>"
    db "@"

String_97_474A_00_1C::
    db "<VOICE1>*: Come back and<LINE>"
    db "join the troupe!<PROMPT>"
    db "<NEXT>You'll become a"
    db "<NEXT>legendary tamer!<WAIT>"
    db "@"

String_97_474A_00_1D::
    db "<VOICE1>*: The troupe'll<LINE>"
    db "reform!<PROMPT>"
    db "<NEXT>We'll recruit new"
    db "<NEXT>members, watch!<WAIT>"
    db "@"

String_97_474A_00_1E::
    db "<VOICE1>*: We're more<LINE>"
    db "vigilant now!<PROMPT>"
    db "<NEXT>No thieves will"
    db "<NEXT>succeed again!<WAIT>"
    db "@"

String_97_474A_00_1F::
    db "<VOICE1>*: I will do my<LINE>"
    db "best to help make<PROMPT>"
    db "<NEXT>the Kingdom a"
    db "<NEXT>better place.<WAIT>"
    db "@"

String_97_474A_00_20::
    db "<VOICE1>*: Welcome, our<LINE>"
    db "honored guests!<PROMPT>"
    db "<NEXT>The King is eager"
    db "<NEXT>to see you!<WAIT>"
    db "@"

String_97_474A_00_21::
    db "<VOICE1>*: Mirage Lake is a<LINE>"
    db "mystical place<PROMPT>"
    db "<NEXT>that can be seen,"
    db "<NEXT>but never reached.<PROMPT>"
    db "<NEXT>It's famous as a"
    db "<NEXT>haven for Beavern.<WAIT>"
    db "@"

String_97_474A_00_22::
    db "<VOICE1>King: Ah, good of<LINE>"
    db "you to visit!<PROMPT>"
    db "<NEXT>Our people are"
    db "<NEXT>living in peace<PROMPT>"
    db "<NEXT>again, much thanks"
    db "<NEXT>to you!<WAIT>"
    db "@"

String_97_474A_00_23::
    db "<VOICE1>*: The dungeon is<LINE>"
    db "full of thieves!<WAIT>"
    db "@"

String_97_474A_00_24::
    db "<VOICE2>*: Cooh, our home<LINE>"
    db "come back to us!<WAIT>"
    db "@"

String_97_474A_00_25::
    db "<VOICE1>*: Cooh! Thieves<LINE>"
    db "are gone!<PROMPT>"
    db "<NEXT>No more worries!"
    db "<NEXT>Cooqueeh!<WAIT>"
    db "@"

String_97_474A_00_26::
    db "<VOICE1>*: Cooh! This bed<LINE>"
    db "perfect for sleep!<WAIT>"
    db "@"

String_97_474A_00_27::
    db "<VOICE2>*: Kyooh! Swimming<LINE>"
    db "in a desert…<PROMPT>"
    db "<NEXT>This is luxury!"
    db "<NEXT>No doubt!<WAIT>"
    db "@"

String_97_474A_00_28::
    db "<VOICE1>*: Kyukyooh! You<LINE>"
    db "are good human.<PROMPT>"
    db "<NEXT>I respect you now!"
    db "<NEXT><WAIT>"
    db "@"

String_97_474A_00_29::
    db "<VOICE1>*: Cooh, I heard<LINE>"
    db "from others held<PROMPT>"
    db "<NEXT>captive by the"
    db "<NEXT>thieves.<PROMPT>"
    db "<NEXT>You beat their"
    db "<NEXT>boss!<PROMPT>"
    db "<NEXT>I see how you beat"
    db "<NEXT>me now!<PROMPT>"
    db "<NEXT>Let me join your"
    db "<NEXT>party!<CHOICE>"
    db "@"

String_97_474A_00_2A::
    db "<VOICE1>*: We are partners,<LINE>"
    db "and good ones too!<WAIT>"
    db "@"

String_97_474A_00_2B::
    db "<VOICE1>*: …But you have no<LINE>"
    db "room for me…<WAIT>"
    db "@"

String_97_474A_00_2C::
    db "<VOICE1>*: Tch, I think<LINE>"
    db "I can help you…<WAIT>"
    db "@"

String_97_474A_00_2D::
    db "<VOICE1>*: Welcome to our<LINE>"
    db "inn!<WAIT>"
    db "@"

String_97_474A_00_2E::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>Thieves have"
    db "<NEXT>emptied it…<WAIT>"
    db "@"

String_97_474A_00_2F::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was full of"
    db "<NEXT>wood chips.<WAIT>"
    db "@"

String_97_474A_00_30::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>There was a long,"
    db "<NEXT>thin cloth.<WAIT>"
    db "@"

String_97_474A_00_31::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>The prisoners", $95
    db "<NEXT>things were there.<WAIT>"
    db "@"

String_97_474A_00_32::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>But it was empty…"
    db "<NEXT><WAIT>"
    db "@"

String_97_474A_00_33::
    db "<VOICE1>*: This is a great<LINE>"
    db "spot to raise a<PROMPT>"
    db "<NEXT>monster's egg."
    db "<NEXT>Eggs are supposed<PROMPT>"
    db "<NEXT>to be hatched at"
    db "<NEXT>the Starry Shrine,<PROMPT>"
    db "<NEXT>but they won't"
    db "<NEXT>notice if we hatch<PROMPT>"
    db "<NEXT>one here."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Have you ever<LINE>"
    db "found a Dream Egg?<CHOICE>"
    db "@"

String_97_474A_00_43::
    db "<VOICE1>*: Put the Dream<LINE>"
    db "Egg on the hay.<PROMPT>"
    db "<NEXT>To raise it, give"
    db "<NEXT>it items.<PROMPT>"
    db "<NEXT>An Herb will raise"
    db "<NEXT>HP, for example.<PROMPT>"
    db "<NEXT>To make the egg"
    db "<NEXT>hatch, it needs<PROMPT>"
    db "<NEXT>you to talk to"
    db "<NEXT>many people.<PROMPT>"
    db "<NEXT>If you're lucky,"
    db "<NEXT>you may get a<PROMPT>"
    db "<NEXT>powerful monster"
    db "<NEXT>to hatch.<WAIT>"
    db "@"

String_97_474A_00_44::
    db "<VOICE1>*: This talk is too<LINE>"
    db "early for you.<WAIT>"
    db "@"

String_97_474A_00_45::
    db "<VOICE1>*: Have you ever<LINE>"
    db "found a Dream Egg?<CHOICE>"
    db "@"

String_97_474A_00_46::
    db "<VOICE1>*: You're the child<LINE>"
    db "of the farmer?<PROMPT>"
    db "<NEXT>Under his Majesty's"
    db "<NEXT>decree, there will<PROMPT>"
    db "<NEXT>be a tournament"
    db "<NEXT>for child masters.<PROMPT>"
    db "<NEXT>He wishes you to"
    db "<NEXT>take part.<PROMPT>"
    db "<NEXT>Needless to say, a"
    db "<NEXT>prize awaits the<PROMPT>"
    db "<NEXT>champion - the"
    db "<NEXT>PirateKey.<PROMPT>"
    db "<NEXT>The winner also"
    db "<NEXT>wins the right to<PROMPT>"
    db "<NEXT>use the Starry"
    db "<NEXT>Shrine and Egg<PROMPT>"
    db "<NEXT>Evaluator's"
    db "<NEXT>services.<WAIT>"
    db "@"

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
    db "<VOICE2>*: In an Arena<LINE>"
    db "battle, you can't<PROMPT>"
    db "<NEXT>command your"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>You have to leave"
    db "<NEXT>it up to them.<PROMPT>"
    db "<NEXT>What kinds of"
    db "<NEXT>personalities they<PROMPT>"
    db "<NEXT>have will decide"
    db "<NEXT>how they act.<WAIT>"
    db "@"

String_97_5BBF_00_01::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>the crowd's trash.<WAIT>"
    db "@"

String_97_5BBF_00_02::
    db "<VOICE1>*: Welcome to my<LINE>"
    db "Key Shop!<PROMPT>"
    db "<NEXT>I appraise and"
    db "<NEXT>identify keys!<PROMPT>"
    db "<NEXT>An unidentified"
    db "<NEXT>key can't be used!<PROMPT>"
    db "<NEXT>Should I appraise"
    db "<NEXT>your keys?@"

String_97_5BBF_00_03::
    db "<VOICE1>*: Welcome to my<LINE>"
    db "Key Shop!<PROMPT>"
    db "<NEXT>Should I appraise"
    db "<NEXT>your keys?@"

String_97_5BBF_00_04::
    db "<VOICE1>*: I'm apprenticing<LINE>"
    db "under the boss.<PROMPT>"
    db "<NEXT>He told me that"
    db "<NEXT>the name of a key<PROMPT>"
    db "<NEXT>hints at its"
    db "<NEXT>destination.<WAIT>"
    db "@"

String_97_5BBF_00_05::
    db "<VOICE1>*: Day after day,<LINE>"
    db "I examine keys.<PROMPT>"
    db "<NEXT>But I'm nothing"
    db "<NEXT>compared to the<PROMPT>"
    db "<NEXT>boss yet."
    db "<NEXT><WAIT>"
    db "@"

String_97_5BBF_00_06::
    db "<VOICE1>*: I found a key in<LINE>"
    db "another world, so<PROMPT>"
    db "<NEXT>I'm having it"
    db "<NEXT>appraised.<PROMPT>"
    db "<NEXT>I hope it leads to"
    db "<NEXT>a world with some<PROMPT>"
    db "<NEXT>monsters I've not"
    db "<NEXT>yet seen.<WAIT>"
    db "@"

String_97_5BBF_00_07::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>It greedily sucked"
    db "<NEXT>air into its fire.<WAIT>"
    db "@"

String_97_5BBF_00_08::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was full of"
    db "<NEXT>jet-black coal.<WAIT>"
    db "@"

String_97_5BBF_00_09::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "This time, you'll<PROMPT>"
    db "<NEXT>have to find the"
    db "<NEXT>key first, warooh.<PROMPT>"
    db "<NEXT>The key, it should"
    db "<NEXT>be in GreatLog.<PROMPT>"
    db "<NEXT>I think it is the"
    db "<NEXT>PirateKey.<PROMPT>"
    db "<NEXT>Don't you forget"
    db "<NEXT>it, warooh.<WAIT>"
    db "@"

String_97_5BBF_00_0A::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "hurry.<PROMPT>"
    db "<NEXT>You need to gather"
    db "<NEXT>more energy.<WAIT>"
    db "@"

String_97_5BBF_00_0B::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "you've gathered<PROMPT>"
    db "<NEXT>enough energy for"
    db "<NEXT>just one person.<PROMPT>"
    db "<NEXT>I need more energy"
    db "<NEXT>still, hurry!<WAIT>"
    db "@"

String_97_5BBF_00_0C::
    db "<VOICE1>Warubou: Wa-hey, I<LINE>"
    db "have enough energy<PROMPT>"
    db "<NEXT>for two people."
    db "<NEXT>But I need more.<PROMPT>"
    db "<NEXT>Just a bit more,"
    db "<NEXT>and I'll be ready.<WAIT>"
    db "@"

String_97_5BBF_00_0D::
    db "<VOICE1>Warubou: Wa-hey.<LINE>"
    db "I need you to go<PROMPT>"
    db "<NEXT>to another world"
    db "<NEXT>to find a plug.<PROMPT>"
    db "<NEXT>But I've no power"
    db "<NEXT>to make a key…<PROMPT>"
    db "<NEXT>That power is from"
    db "<NEXT>GreatLog's tree.<PROMPT>"
    db "<NEXT>It is energy made"
    db "<NEXT>by the bond tying<PROMPT>"
    db "<NEXT>people and their"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>Help people bond"
    db "<NEXT>with monsters, and<PROMPT>"
    db "<NEXT>GreatLog's power"
    db "<NEXT>will be boosted.<WAIT>"
    db "@"

String_97_5BBF_00_0E::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>There is enough"
    db "<NEXT>power for me to<PROMPT>"
    db "<NEXT>make a Magic Key,"
    db "<NEXT>yes, warooh!<PROMPT>"
    db "<NEXT>Good job, <BUF0>!"
    db "<NEXT>Just wait now!<PROMPT>"
    db "<NEXT>I'll make the key"
    db "<NEXT>right away.<WAIT>"
    db "@"

String_97_5BBF_00_0F::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0> you're slow!<PROMPT>"
    db "<NEXT>Kameha already"
    db "<NEXT>came by today with<PROMPT>"
    db "<NEXT>the PirateKey,"
    db "<NEXT>warooh.<PROMPT>"
    db "<NEXT>He got it from the"
    db "<NEXT>King by whining.<PROMPT>"
    db "<NEXT>You", $44, " better follow"
    db "<NEXT>him to the other<PROMPT>"
    db "<NEXT>world right away."
    db "<NEXT>Don't be late!<PROMPT>"
    db "<NEXT>Also, Kameha isn't"
    db "<NEXT>a bad guy, warooh.<PROMPT>"
    db "<NEXT>If you see him"
    db "<NEXT>over there, help<PROMPT>"
    db "<NEXT>him if he needs"
    db "<NEXT>it.<PROMPT>"
    db "<NEXT>And, don't forget."
    db "<NEXT>You can cross<PROMPT>"
    db "<NEXT>water by using the"
    db "<NEXT>TidalBell.<PROMPT>"
    db "<NEXT>Bring me back some"
    db "<NEXT>good news, warooh!<WAIT>"
    db "@"

String_97_5BBF_00_10::
    db "<BUF0> received the<LINE>"
    db "PirateKey.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_97_5BBF_00_11::
    db "<VOICE1>*: Putting up a<LINE>"
    db "bridge is easy!<WAIT>"
    db "@"

String_97_5BBF_00_12::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "You did it, <BUF0>!<PROMPT>"
    db "<NEXT>GreatLog's power"
    db "<NEXT>will heal you!<WAIT>"
    db "@"

String_97_5BBF_00_13::
    db "<VOICE1>Warubou: There,<LINE>"
    db "your party's fine!<PROMPT>"
    db "<NEXT>So, the new plug"
    db "<NEXT>for Log's Navel?<WAIT>"
    db "@"

String_97_5BBF_00_14::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "So, this is it?<PROMPT>"
    db "<NEXT>This is the"
    db "<NEXT>HarMirror, warooh?<PROMPT>"
    db "<NEXT>I can feel an odd"
    db "<NEXT>power from it!<WAIT>"
    db "@"

String_97_5BBF_00_15::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "That's it!<PROMPT>"
    db "<NEXT>GreatLog is saved!"
    db "<NEXT>Good, now… Warooh?<WAIT>"
    db "@"

String_97_5BBF_00_16::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "No good, no good!<PROMPT>"
    db "<NEXT>I have to plug the"
    db "<NEXT>Navel again!<WAIT>"
    db "@"

String_97_5BBF_00_17::
    db "<VOICE1>Warubou: Wa-hey…<LINE>"
    db "That was no good.<PROMPT>"
    db "<NEXT>But HarMirror does"
    db "<NEXT>have magic in it.<PROMPT>"
    db "<NEXT>Give me your hand,"
    db "<NEXT><BUF0>. Wa-hey!<WAIT>"
    db "@"

String_97_5BBF_00_18::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Stop that!<PROMPT>"
    db "<NEXT>Why do you look so"
    db "<NEXT>unhappy at me?<PROMPT>"
    db "<NEXT>A hero doesn't walk"
    db "<NEXT>from someone in<PROMPT>"
    db "<NEXT>trouble, you ought"
    db "<NEXT>to know that!<PROMPT>"
    db "<NEXT>Come on, give me a"
    db "<NEXT>big smile, warooh!<CHOICE>"
    db "@"

String_97_5BBF_00_19::
    db "<VOICE1>Warubou: Listen.<LINE>"
    db "I feel a strange<PROMPT>"
    db "<NEXT>power in another"
    db "<NEXT>world, warooh.<PROMPT>"
    db "<NEXT>It has to be a"
    db "<NEXT>plug, I can tell!<PROMPT>"
    db "<NEXT>Wa-hey, gather"
    db "<NEXT>more of the energy<PROMPT>"
    db "<NEXT>from GreatLog's"
    db "<NEXT>tree, I need it.<WAIT>"
    db "@"

String_97_5BBF_00_1A::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>?<PROMPT>"
    db "<NEXT>Angry still with"
    db "<NEXT>me, warooh?<PROMPT>"
    db "<NEXT>Wasted energy,"
    db "<NEXT>that is!<PROMPT>"
    db "<NEXT>Come on, cheer up"
    db "<NEXT>and smile, wa-hey!<CHOICE>"
    db "@"

String_97_5BBF_00_1B::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It was full of"
    db "<NEXT>junk.<WAIT>"
    db "@"

String_97_5BBF_00_1C::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>It was still warm"
    db "<NEXT>from cooking.<WAIT>"
    db "@"

String_97_5BBF_00_1D::
    db "<VOICE2>*: Come back if you<LINE>"
    db "need to check up<PROMPT>"
    db "<NEXT>on your monster"
    db "<NEXT>Catalog.<WAIT>"
    db "@"

String_97_5BBF_00_1E::
    db "<VOICE1>*: GreatLog's<LINE>"
    db "Starry Shrine<PROMPT>"
    db "<NEXT>wasn't in use for"
    db "<NEXT>a long time.<PROMPT>"
    db "<NEXT>But research into"
    db "<NEXT>breeding shed new<PROMPT>"
    db "<NEXT>light on its great"
    db "<NEXT>potential.<PROMPT>"
    db "<NEXT>Now, the Shrine is"
    db "<NEXT>considered to be<PROMPT>"
    db "<NEXT>an indispensable"
    db "<NEXT>place for masters.<WAIT>"
    db "@"

String_97_5BBF_00_48::
    db "<VOICE1>*: Parents pass on<LINE>"
    db "abilities to their<PROMPT>"
    db "<NEXT>children, who in"
    db "<NEXT>turn pass on their<PROMPT>"
    db "<NEXT>abilities to their"
    db "<NEXT>own offspring.<PROMPT>"
    db "<NEXT>Saying goodbye is"
    db "<NEXT>never easy, but<PROMPT>"
    db "<NEXT>that is the cycle"
    db "<NEXT>of life.<WAIT>"
    db "@"

String_97_5BBF_00_49::
    db "<BUF0> received the<LINE>"
    db "IceKey.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_97_5BBF_00_52::
    db "<VOICE1>Warubou: Wa-hey?<LINE>"
    db "So, this is it?<PROMPT>"
    db "<NEXT>This is the"
    db "<NEXT>SkyShield, warooh?<PROMPT>"
    db "<NEXT>It gives off more"
    db "<NEXT>magical power than<PROMPT>"
    db "<NEXT>the other things"
    db "<NEXT>you've brought me.<PROMPT>"
    db "<NEXT>We'll see if it"
    db "<NEXT>works, warooh!<WAIT>"
    db "@"

String_97_5BBF_00_55::
    db "<VOICE1>Warubou: Wa-hey…<LINE>"
    db "That was no good.<PROMPT>"
    db "<NEXT>But this too has"
    db "<NEXT>magic in it.<PROMPT>"
    db "<NEXT>Give me your hand,"
    db "<NEXT><BUF0>. Wa-hey!<WAIT>"
    db "@"

String_97_5BBF_00_58::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Stop that!<PROMPT>"
    db "<NEXT>Why do you look so"
    db "<NEXT>disgusted with me?<PROMPT>"
    db "<NEXT>People can do"
    db "<NEXT>anything if they<PROMPT>"
    db "<NEXT>buckle down and"
    db "<NEXT>work, warooh!<PROMPT>"
    db "<NEXT>Come on, give me a"
    db "<NEXT>big smile, <BUF0>!<CHOICE>"
    db "@"

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
    db "<VOICE1>*: The skills that<LINE>"
    db "are learned by<PROMPT>"
    db "<NEXT>monsters depends"
    db "<NEXT>on their families.<PROMPT>"
    db "<NEXT>Through breeding,"
    db "<NEXT>monsters will<PROMPT>"
    db "<NEXT>learn a greater"
    db "<NEXT>variety of skills.<WAIT>"
    db "@"

String_97_6DC1_00_01::
    db "<VOICE1>*: How quickly the<LINE>"
    db "different stats<PROMPT>"
    db "<NEXT>rise varies by the"
    db "<NEXT>monster family.<PROMPT>"
    db "<NEXT>I bet you didn't"
    db "<NEXT>know that.<WAIT>"
    db "@"

String_97_6DC1_00_02::
    db "<VOICE1>*: I wish I could<LINE>"
    db "play outside…<PROMPT>"
    db "<NEXT>But Mom won't let"
    db "<NEXT>me go anywhere…<WAIT>"
    db "@"

String_97_6DC1_00_03::
    db "<VOICE1>*: Aren't you lonely<LINE>"
    db "traveling alone?<PROMPT>"
    db "<NEXT>Oh, but then you're"
    db "<NEXT>with monsters.<WAIT>"
    db "@"

String_97_6DC1_00_04::
    db "<VOICE1>*: I wish I had<LINE>"
    db "monster friends.<PROMPT>"
    db "<NEXT>They could help me"
    db "<NEXT>with my homework.<WAIT>"
    db "@"

String_97_6DC1_00_05::
    db "<VOICE1>*: Why are you<LINE>"
    db "consorting with<PROMPT>"
    db "<NEXT>monsters?"
    db "<NEXT>I don't trust you!<WAIT>"
    db "@"

String_97_6DC1_00_06::
    db "<VOICE1>*: When I grow up,<LINE>"
    db "I'm going to take<PROMPT>"
    db "<NEXT>over my dad's job"
    db "<NEXT>as a dealer.<PROMPT>"
    db "<NEXT>He travels from"
    db "<NEXT>town to town!<WAIT>"
    db "@"

String_97_6DC1_00_07::
    db "<VOICE1>*: D-don't t-try to<LINE>"
    db "scare me.<PROMPT>"
    db "<NEXT>I… I'm not scared"
    db "<NEXT>of monsters!<WAIT>"
    db "@"

String_97_6DC1_00_08::
    db "<VOICE1>*: If we could fly<LINE>"
    db "like birds…<PROMPT>"
    db "<NEXT>We", $44, " be able to go"
    db "<NEXT>anywhere.<PROMPT>"
    db "<NEXT>Now that's freedom."
    db "<NEXT>Don't you think?<WAIT>"
    db "@"

String_97_6DC1_00_09::
    db "<VOICE1>*: Would you be my<LINE>"
    db "friend?<WAIT>"
    db "@"

String_97_6DC1_00_0A::
    db "<VOICE1>*: Don't goof off!<LINE>"
    db "Do your homework!<PROMPT>"
    db "<NEXT>My mom says that"
    db "<NEXT>all the time.<WAIT>"
    db "@"

String_97_6DC1_00_0B::
    db "<VOICE1>*: Mom's going to<LINE>"
    db "have a baby soon.<PROMPT>"
    db "<NEXT>I wonder if it"
    db "<NEXT>will be a boy or<PROMPT>"
    db "<NEXT>girl. It doesn't"
    db "<NEXT>matter, though!<WAIT>"
    db "@"

String_97_6DC1_00_0C::
    db "<VOICE1>*: A bard, that's<LINE>"
    db "what I'm gonna be.<PROMPT>"
    db "<NEXT>Gonna travel and"
    db "<NEXT>sing about it.<PROMPT>"
    db "<NEXT>I practice!"
    db "<NEXT>La~ lalala~.<WAIT>"
    db "@"

String_97_6DC1_00_0D::
    db "<VOICE1>*: I", $44, " love to ride<LINE>"
    db "through forests on<PROMPT>"
    db "<NEXT>a Unicorn."
    db "<NEXT>That's my dream.<PROMPT>"
    db "<NEXT>If it comes true,"
    db "<NEXT>I'll let you ride!<WAIT>"
    db "@"

String_97_6DC1_00_0E::
    db "<VOICE1>*: I hate carrots!<LINE>"
    db "It tastes blecch!<PROMPT>"
    db "<NEXT>I bet a DanceVegi"
    db "<NEXT>tastes awful too!<WAIT>"
    db "@"

String_97_6DC1_00_0F::
    db "<VOICE1>*: Lipsy always<LINE>"
    db "wants to kiss.<PROMPT>"
    db "<NEXT>Mommy's like that"
    db "<NEXT>after some cider.<WAIT>"
    db "@"

String_97_6DC1_00_10::
    db "<VOICE1>*: I'm going to be<LINE>"
    db "like my dad and<PROMPT>"
    db "<NEXT>become a soldier."
    db "<NEXT>I'll get to wear<PROMPT>"
    db "<NEXT>the awesome armor"
    db "<NEXT>they have.<WAIT>"
    db "@"

String_97_6DC1_00_11::
    db "<VOICE1>*: Do you think it's<LINE>"
    db "impressive to have<PROMPT>"
    db "<NEXT>monsters around?"
    db "<NEXT>I'm not jealous.<PROMPT>"
    db "<NEXT>No, really, I'm"
    db "<NEXT>not envious!<WAIT>"
    db "@"

String_97_6DC1_00_12::
    db "<VOICE1>*: I'm your master<LINE>"
    db "from now on!<PROMPT>"
    db "<NEXT>Your first order"
    db "<NEXT>is…<PROMPT>"
    db "<NEXT>Wait! Listen!"
    db "<NEXT>Will you listen?<WAIT>"
    db "@"

String_97_6DC1_00_13::
    db "<VOICE1>*: You act big for<LINE>"
    db "an outsider!<PROMPT>"
    db "<NEXT>Don't think you"
    db "<NEXT>scare me with your<PROMPT>"
    db "<NEXT>monsters. I… I'm"
    db "<NEXT>not scared a bit!<WAIT>"
    db "@"

String_97_6DC1_00_14::
    db "<VOICE1>*: Monsters get<LINE>"
    db "discouraged if you<PROMPT>"
    db "<NEXT>order them around"
    db "<NEXT>all the time.<PROMPT>"
    db "<NEXT>You should assign"
    db "<NEXT>them a plan, and<PROMPT>"
    db "<NEXT>let them do what"
    db "<NEXT>they want.<WAIT>"
    db "@"

String_97_6DC1_00_15::
    db "<VOICE1>*: A bred monster<LINE>"
    db "learns the skills<PROMPT>"
    db "<NEXT>that its parents"
    db "<NEXT>knew.<PROMPT>"
    db "<NEXT>So, it will learn"
    db "<NEXT>many skills.<WAIT>"
    db "@"

String_97_6DC1_00_16::
    db "<VOICE1>*: Skills come in<LINE>"
    db "the three groups<PROMPT>"
    db "<NEXT>of attack, support"
    db "<NEXT>and defense.<WAIT>"
    db "@"

String_97_6DC1_00_17::
    db "<VOICE1>*: You'll find it<LINE>"
    db "easier to raise<PROMPT>"
    db "<NEXT>monsters if you"
    db "<NEXT>assign them roles.<PROMPT>"
    db "<NEXT>On the other hand,"
    db "<NEXT>you could raise<PROMPT>"
    db "<NEXT>one like a hero-"
    db "<NEXT>useful all around.<WAIT>"
    db "@"

String_97_6DC1_00_18::
    db "<VOICE1>*: I've never met<LINE>"
    db "anyone like you.<PROMPT>"
    db "<NEXT>Your quiet way is"
    db "<NEXT>just so cool!<WAIT>"
    db "@"

String_97_6DC1_00_19::
    db "<VOICE1>*: You came from<LINE>"
    db "GreatLog?<PROMPT>"
    db "<NEXT>I've never heard"
    db "<NEXT>of it, sorry.<WAIT>"
    db "@"

String_97_6DC1_00_1A::
    db "<VOICE1>*: Ah, you're a<LINE>"
    db "traveler?<PROMPT>"
    db "<NEXT>From GreatLog, you"
    db "<NEXT>say.<PROMPT>"
    db "<NEXT>I've been to"
    db "<NEXT>GreatTree, myself.<WAIT>"
    db "@"

String_97_6DC1_00_1B::
    db "<VOICE1>*: I've heard tales<LINE>"
    db "that GreatLog is a<PROMPT>"
    db "<NEXT>hollowed out palm"
    db "<NEXT>tree.<WAIT>"
    db "@"

String_97_6DC1_00_1C::
    db "<VOICE1>*: You're from<LINE>"
    db "GreatLog?<WAIT>"
    db "@"
    db "Isn't that where<LINE>"
    db "the prince is a<PROMPT>"
    db "<NEXT>little terror?"
    db "<NEXT>Kameha, right?<PROMPT>"
    db "<NEXT>Royalty can be so"
    db "<NEXT>selfish.<WAIT>"
    db "@"

String_97_6DC1_00_1D::
    db "<VOICE1>*: I understand<LINE>"
    db "monster masters<PROMPT>"
    db "<NEXT>flock to the"
    db "<NEXT>kingdom of<PROMPT>"
    db "<NEXT>GreatLog."
    db "<NEXT><PROMPT>"
    db "<NEXT>Oh? You're from"
    db "<NEXT>GreatLog, you say?<WAIT>"
    db "@"

String_97_6DC1_00_1E::
    db "<VOICE2>*: I wander the<LINE>"
    db "other worlds…<PROMPT>"
    db "<NEXT>I'm sure we will"
    db "<NEXT>meet again.<WAIT>"
    db "@"

String_97_6DC1_00_1F::
    db "<VOICE2>*: I wander the<LINE>"
    db "other worlds…<PROMPT>"
    db "<NEXT>I chronicle what"
    db "<NEXT>I've experienced.<WAIT>"
    db "@"

String_97_6DC1_00_20::
    db "<VOICE2>*: I wander the<LINE>"
    db "other worlds…<PROMPT>"
    db "<NEXT>I'll see more, as"
    db "<NEXT>I've done today.<WAIT>"
    db "@"

String_97_6DC1_00_21::
    db "<VOICE2>*: I wander the<LINE>"
    db "other worlds…<PROMPT>"
    db "<NEXT>I'll soon leave"
    db "<NEXT>for another world.<WAIT>"
    db "@"

String_97_6DC1_00_22::
    db "<VOICE2>*: I wander the<LINE>"
    db "other worlds…<PROMPT>"
    db "<NEXT>We may have"
    db "<NEXT>crossed paths…<WAIT>"
    db "@"

String_97_6DC1_00_23::
    db "<VOICE1>*: I study monsters<LINE>"
    db "in other worlds.<PROMPT>"
    db "<NEXT>I'm intrigued by"
    db "<NEXT>your monsters.<WAIT>"
    db "@"

String_97_6DC1_00_24::
    db "<VOICE1>*: I study monsters<LINE>"
    db "in other worlds.<PROMPT>"
    db "<NEXT>I think I'm done"
    db "<NEXT>with this area.<WAIT>"
    db "@"

String_97_6DC1_00_25::
    db "<VOICE1>*: I study monsters<LINE>"
    db "in other worlds.<PROMPT>"
    db "<NEXT>What monsters"
    db "<NEXT>await me next?<WAIT>"
    db "@"

String_97_6DC1_00_26::
    db "<VOICE1>*: I study monsters<LINE>"
    db "in other worlds.<PROMPT>"
    db "<NEXT>Haven't I seen you"
    db "<NEXT>elsewhere before?<WAIT>"
    db "@"

String_97_6DC1_00_27::
    db "<VOICE1>*: Humph…<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>That's my Terry"
    db "<NEXT>impression. So?<WAIT>"
    db "@"

String_97_6DC1_00_28::
    db "<VOICE1>*: I met this girl<LINE>"
    db "named Milayou.<PROMPT>"
    db "<NEXT>Hoo boy, she was"
    db "<NEXT>some kind of cute.<PROMPT>"
    db "<NEXT>She'll become"
    db "<NEXT>stunning for sure!<WAIT>"
    db "@"

String_97_6DC1_00_29::
    db "<VOICE1>*: I wish Terry", $44, "<LINE>"
    db "visit again.<PROMPT>"
    db "<NEXT>The girls come out"
    db "<NEXT>to see him.<WAIT>"
    db "@"

String_97_6DC1_00_2A::
    db "<VOICE1>*: I'm going to<LINE>"
    db "marry Milayou.<PROMPT>"
    db "<NEXT>You bet I will!"
    db "<NEXT>I said so!<WAIT>"
    db "@"

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
