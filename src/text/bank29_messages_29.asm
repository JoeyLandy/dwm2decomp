; ROM bank $29: messages
; The annotated listing of this bank is build/listing/bank29.asm.

SECTION "Bank 29", ROMX
    db $29

; Starts a message of message group 1 (strings of category 0 of bank $29, picked by wStringIndex).
; When wStringIndex is below $8E it calls BeginStringDisplay with DE = MessageStrings_Bank29; from
; $8E on it far-calls BeginStringDisplay_Bank29_Overflow in bank $97, which subtracts $8E from
; wStringIndex and uses the overflow table. BeginStringDisplay blanks the text window, points the
; text printer at the string and sets wTextFlags to 1; the text appears on the following frames.
; Reached by farcall from the message group dispatch (ShowMessageHL in bank $5F,
; StartMessageForGroup_Group01 in bank $10) and from the debug menu in bank $01. (C1, E-0378)
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

SECTION "Bank 29 CopyStringToBuffer_Bank29", ROMX

; Copies a message of message group 1 to a buffer instead of printing it: string wStringIndex of
; category wStringCategory is copied, with its $F0 terminator, to the address in
; wStringDestLo/wStringDestHi. When wStringIndex is below $8E it uses MessageStrings_Bank29 through
; CopyStringToBuffer; from $8E on it far-calls CopyStringToBuffer_Bank29_Overflow in bank $97, which
; subtracts $8E from wStringIndex first (so wStringIndex is changed). Nothing in src/ calls this
; copy by name. (C2, E-0378)
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

; One little-endian word, a pointer to StringList_Bank29_0, the list of 142 message pointers
; Message_01_00 to Message_01_8D (message group 1, bank $29). LookupString reads word
; wStringCategory of it (category 0 is the only word), then word wStringIndex of that list.
; BeginStringDisplay_Bank29 and CopyStringToBuffer_Bank29 pass it in DE for wStringIndex below $8E;
; higher ids go to their Overflow routine. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
MessageStrings_Bank29::
    dw StringList_Bank29_0 ; id 0

; category list of MessageStrings_Bank29; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank29_0::
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
    db "<VOICE2>*: Are you going<LINE>"
    db "out to play?<PROMPT>"
    db "<NEXT>Be careful you"
    db "<NEXT>don't get hurt.<WAIT>"
    db "@"

Message_01_01::
    db "<BUF0> received an<LINE>"
    db "Herb.<WAIT>"
    db "@"

Message_01_02::
    db "<VOICE2>*: It's a beautiful<LINE>"
    db "day for laundry!<PROMPT>"
    db "<NEXT>You shouldn't be"
    db "<NEXT>inside on a day<PROMPT>"
    db "<NEXT>like this!"
    db "<NEXT><WAIT>"
    db "@"

Message_01_03::
    db "<VOICE1>Cobi: <BUF0>, while<LINE>"
    db "you're gone, I'll<PROMPT>"
    db "<NEXT>stay here and tend"
    db "<NEXT>to the monsters.<PROMPT>"
    db "<NEXT>If you catch any,"
    db "<NEXT>I'll care for them.<WAIT>"
    db "@"

Message_01_04::
    db "<VOICE2>Tara: Big brother,<LINE>"
    db "while you're in<PROMPT>"
    db "<NEXT>another world,"
    db "<NEXT>I'll stay here.<PROMPT>"
    db "<NEXT>I'll look after"
    db "<NEXT>your monsters,<PROMPT>"
    db "<NEXT>so be sure to send"
    db "<NEXT>them back to me.<WAIT>"
    db "@"

Message_01_05::
    db "<VOICE1>*: Why do you have<LINE>"
    db "a monster in tow?<PROMPT>"
    db "<NEXT>Are you going to"
    db "<NEXT>become a master?<PROMPT>"
    db "<NEXT>If you are, or if"
    db "<NEXT>you're going to<PROMPT>"
    db "<NEXT>inherit this farm,"
    db "<NEXT>the key is to be<PROMPT>"
    db "<NEXT>friendly with"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>To break the ice,"
    db "<NEXT>feed them meat.<PROMPT>"
    db "<NEXT>That will make"
    db "<NEXT>them less wary.<WAIT>"
    db "@"

Message_01_06::
    db "<BUF0> received a"
    db "<NEXT>PorkChop.<WAIT>"
    db "@"

Message_01_07::
    db "<VOICE1>*: To win the trust<LINE>"
    db "of monsters, feed<PROMPT>"
    db "<NEXT>them some meat"
    db "<NEXT>right away.<PROMPT>"
    db "<NEXT>You can battle"
    db "<NEXT>them after, and<PROMPT>"
    db "<NEXT>rid them of their"
    db "<NEXT>wild nature.<WAIT>"
    db "@"

Message_01_08::
    db "<VOICE1>*: It looks like<LINE>"
    db "you've become<PROMPT>"
    db "<NEXT>friends with some"
    db "<NEXT>monsters!<PROMPT>"
    db "<NEXT>That's my <BUF0>!"
    db "<NEXT>You're talented!<WAIT>"
    db "@"

Message_01_09::
    db "<VOICE1>*: Your monsters<LINE>"
    db "are your friends<PROMPT>"
    db "<NEXT>who will serve you"
    db "<NEXT>to the end.<PROMPT>"
    db "<NEXT>Be sure to raise"
    db "<NEXT>them with love!<WAIT>"
    db "@"

Message_01_0A::
    db "<VOICE1>*: Off to another<LINE>"
    db "world!<PROMPT>"
    db "<NEXT>There are many"
    db "<NEXT>items to be found<PROMPT>"
    db "<NEXT>just lying around"
    db "<NEXT>in other worlds.<PROMPT>"
    db "<NEXT>They will help you"
    db "<NEXT>on your trek!<WAIT>"
    db "@"

Message_01_0B::
    db "<VOICE1>*: A tropical isle<LINE>"
    db "is too hot for me.<PROMPT>"
    db "<NEXT>I might melt and"
    db "<NEXT>become a Babble!<WAIT>"
    db "@"

Message_01_0C::
    db "<VOICE1>*: Oh, that's cute!<LINE>"
    db "Hahahahaha!<PROMPT>"
    db "<NEXT>We have a new"
    db "<NEXT>monster master!<WAIT>"
    db "@"

Message_01_0D::
    db "<VOICE1>Cobi: Hi, I'm<LINE>"
    db "helping Papa to<PROMPT>"
    db "<NEXT>take care of the"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>You can drop off"
    db "<NEXT>or pick up any of<PROMPT>"
    db "<NEXT>your monsters here"
    db "<NEXT>with me.<PROMPT>"
    db "<NEXT>So, what can I do"
    db "<NEXT>for you, sis?<WAIT>"
    db "@"

Message_01_0E::
    db "<VOICE1>Cobi: Hi, <BUF0>!<LINE>"
    db "What's up today?<WAIT>"
    db "@"

Message_01_0F::
    db "<VOICE2>Tara: I'm helping<LINE>"
    db "Papa take care of<PROMPT>"
    db "<NEXT>the monsters and"
    db "<NEXT>the farm.<PROMPT>"
    db "<NEXT>You can drop off"
    db "<NEXT>or pick up any of<PROMPT>"
    db "<NEXT>your monsters here"
    db "<NEXT>with me.<PROMPT>"
    db "<NEXT>Do you need me for"
    db "<NEXT>anything?<WAIT>"
    db "@"

Message_01_10::
    db "<VOICE2>Tara: Hi!<LINE>"
    db "How are you?<PROMPT>"
    db "<NEXT>Do you need me for"
    db "<NEXT>anything today?<WAIT>"
    db "@"

Message_01_11::
    db "<VOICE1>*: Want to know how<LINE>"
    db "the farm works?<CHOICE>"
    db "@"

Message_01_12::
    db "<VOICE1>*: Including the<LINE>"
    db "monsters with you,<PROMPT>"
    db "<NEXT>the farm can hold"
    db "<NEXT>up to ten.<PROMPT>"
    db "<NEXT>It's not much to"
    db "<NEXT>start, but the<PROMPT>"
    db "<NEXT>farm will hold"
    db "<NEXT>more as it grows.<PROMPT>"
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
    db "<NEXT>monsters out to"
    db "<NEXT>train them.<WAIT>"
    db "@"

Message_01_13::
    db "<VOICE1>*: Aww… You know<LINE>"
    db "already? Boring!<WAIT>"
    db "@"

Message_01_14::
    db "<VOICE2>*: I haven't seen<LINE>"
    db "Prince Kameha or<PROMPT>"
    db "<NEXT>Warubou today."
    db "<NEXT>I hope they're not<PROMPT>"
    db "<NEXT>cooking up new"
    db "<NEXT>pranks.<WAIT>"
    db "@"

Message_01_15::
    db "<VOICE1>*: I am a dealer-<LINE>"
    db "a merchant who<PROMPT>"
    db "<NEXT>buys and sells"
    db "<NEXT>useful items.<PROMPT>"
    db "<NEXT>Now, come back"
    db "<NEXT>with a grownup.<WAIT>"
    db "@"

Message_01_16::
    db "<VOICE2>*: You have such<LINE>"
    db "cute monsters!<PROMPT>"
    db "<NEXT>Are you playing"
    db "<NEXT>monster master?<WAIT>"
    db "@"

Message_01_17::
    db "<VOICE2>*: I haven't seen<LINE>"
    db "Prince Kameha or<PROMPT>"
    db "<NEXT>Warubou at all."
    db "<NEXT>Perhaps we won't<PROMPT>"
    db "<NEXT>need to post"
    db "<NEXT>lookouts anymore.<WAIT>"
    db "@"

Message_01_18::
    db "<VOICE2>*: Warubou has gone<LINE>"
    db "down the well and<PROMPT>"
    db "<NEXT>hasn't come back"
    db "<NEXT>out yet.<PROMPT>"
    db "<NEXT>It's plotting, I"
    db "<NEXT>bet.<WAIT>"
    db "@"

Message_01_19::
    db "<VOICE2>*: Monster masters<LINE>"
    db "are people who can<PROMPT>"
    db "<NEXT>open their hearts"
    db "<NEXT>to monsters.<PROMPT>"
    db "<NEXT>If you're trying to"
    db "<NEXT>become a master,<PROMPT>"
    db "<NEXT>treat monsters"
    db "<NEXT>with love.<WAIT>"
    db "@"

Message_01_1A::
    db "<VOICE1>*: Even the most<LINE>"
    db "ordinary of days<PROMPT>"
    db "<NEXT>brings small"
    db "<NEXT>changes.<PROMPT>"
    db "<NEXT>So long as there"
    db "<NEXT>is somewhere you<PROMPT>"
    db "<NEXT>can relax, life"
    db "<NEXT>isn't all that bad.<WAIT>"
    db "@"

Message_01_1B::
    db "<VOICE1>*: Hm? Are you a<LINE>"
    db "master hopeful?<PROMPT>"
    db "<NEXT>Well, aren't you a"
    db "<NEXT>cute rival!<WAIT>"
    db "@"

Message_01_1C::
    db "<VOICE1>*: Oh, hi! Good to<LINE>"
    db "see you again!<PROMPT>"
    db "<NEXT>This is the Vault."
    db "<NEXT>You can keep your<PROMPT>"
    db "<NEXT>money and items"
    db "<NEXT>safely here.<PROMPT>"
    db "<NEXT>You can take them"
    db "<NEXT>out anytime too.<PROMPT>"
    db "<NEXT>It's free, so feel"
    db "<NEXT>free to use us!<PROMPT>"
    db "<NEXT>So, how may I"
    db "<NEXT>serve you today?<WAIT>"
    db "@"

Message_01_1D::
    db "<VOICE1>*: How may the<LINE>"
    db "Vault serve you?<WAIT>"
    db "@"

Message_01_1E::
    db "<VOICE1>*: If your party is<LINE>"
    db "wiped out, half<PROMPT>"
    db "<NEXT>your money's gone,"
    db "<NEXT>just like that.<PROMPT>"
    db "<NEXT>But any money in"
    db "<NEXT>the Vault is safe.<PROMPT>"
    db "<NEXT>Better saved than"
    db "<NEXT>sorry, just like<PROMPT>"
    db "<NEXT>your Journal."
    db "<NEXT>Travel smart!<WAIT>"
    db "@"

Message_01_1F::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You remember the"
    db "<NEXT>promise you made?<CHOICE>"
    db "@"

Message_01_20::
    db "<VOICE1>Warubou: Quit<LINE>"
    db "dawdling, warooh!<WAIT>"
    db "@"

Message_01_21::
    db "<VOICE1>Warubou: Use a<LINE>"
    db "Magic Key and open<PROMPT>"
    db "<NEXT>the Magic Door in"
    db "<NEXT>chamber ahead!<PROMPT>"
    db "<NEXT>Go to another"
    db "<NEXT>world and find<PROMPT>"
    db "<NEXT>a plug for the"
    db "<NEXT>Log's Navel!<PROMPT>"
    db "<NEXT>Use GreatLog Key"
    db "<NEXT>to come back.<PROMPT>"
    db "<NEXT>That is all!"
    db "<NEXT>Hurry, wa-hey!<WAIT>"
    db "@"

Message_01_22::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "You did it, <BUF0>!<PROMPT>"
    db "<NEXT>I'll give you"
    db "<NEXT>GreatLog's power!<WAIT>"
    db "@"

Message_01_26::
    db "<VOICE1>Warubou: There,<LINE>"
    db "your party's fine!<PROMPT>"
    db "<NEXT>So, the new plug"
    db "<NEXT>for the Navel?<WAIT>"
    db "@"

Message_01_27::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "So, this is it?<PROMPT>"
    db "<NEXT>This is the"
    db "<NEXT>TidalBell, warooh?<PROMPT>"
    db "<NEXT>It exudes an odd"
    db "<NEXT>power, yes.<PROMPT>"
    db "<NEXT>We'll see if it"
    db "<NEXT>works, warooh!<WAIT>"
    db "@"

Message_01_28::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "That's it!<PROMPT>"
    db "<NEXT>GreatLog is saved!"
    db "<NEXT>Good, now… Warooh?<WAIT>"
    db "@"

Message_01_29::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "No good, no good!<PROMPT>"
    db "<NEXT>I have to plug the"
    db "<NEXT>Navel again!<WAIT>"
    db "@"

Message_01_2A::
    db "<VOICE1>Warubou: Wa-hey…<LINE>"
    db "That was no good.<PROMPT>"
    db "<NEXT>But TidalBell has"
    db "<NEXT>magic in it.<PROMPT>"
    db "<NEXT>Give me your hand."
    db "<NEXT>I hold it, and…<PROMPT>"
    db "<NEXT>Wa-hey!"
    db "<NEXT><WAIT>"
    db "@"

Message_01_2B::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Stop that!<PROMPT>"
    db "<NEXT>Why do you look so"
    db "<NEXT>nasty at me?<PROMPT>"
    db "<NEXT>A hero should have"
    db "<NEXT>the valor to clean<PROMPT>"
    db "<NEXT>up after someone"
    db "<NEXT>else's mess!<PROMPT>"
    db "<NEXT>Come on, give me a"
    db "<NEXT>big smile, warooh!<WAIT>"
    db "@"

Message_01_2C::
    db "<VOICE1>Warubou: Listen.<LINE>"
    db "I feel a strange<PROMPT>"
    db "<NEXT>power in another"
    db "<NEXT>world, warooh.<PROMPT>"
    db "<NEXT>It has to be a"
    db "<NEXT>plug, I know it!<PROMPT>"
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

Message_01_2D::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>?<PROMPT>"
    db "<NEXT>Angry still with"
    db "<NEXT>me, warooh?<PROMPT>"
    db "<NEXT>Anger is no good"
    db "<NEXT>between friends!<PROMPT>"
    db "<NEXT>We're friends, so"
    db "<NEXT>no anger, <BUF0>!<CHOICE>"
    db "@"

Message_01_2E::
    db "<VOICE1>*: This is Kalka,<LINE>"
    db "an oasis village.<WAIT>"
    db "@"

Message_01_31::
    db "<VOICE1>*: A thieving band<LINE>"
    db "runs amok here.<PROMPT>"
    db "<NEXT>It's impossible to"
    db "<NEXT>get any decent<PROMPT>"
    db "<NEXT>sleep because of"
    db "<NEXT>their threat.<WAIT>"
    db "@"

Message_01_32::
    db "<VOICE2>*: Pardon? A plug<LINE>"
    db "for a navel?<PROMPT>"
    db "<NEXT>Sorry, I have no"
    db "<NEXT>idea what that is.<WAIT>"
    db "@"

Message_01_33::
    db "<VOICE2>*: The oasis' water<LINE>"
    db "travels through an<PROMPT>"
    db "<NEXT>underground canal"
    db "<NEXT>to Asiya.<PROMPT>"
    db "<NEXT>Asiya? It's a town"
    db "<NEXT>that's due south.<WAIT>"
    db "@"

Message_01_34::
    db "<VOICE1>*: The leader of<LINE>"
    db "the thieves is a<PROMPT>"
    db "<NEXT>fearsome man."
    db "<NEXT>He commands horrid<PROMPT>"
    db "<NEXT>monsters to rob"
    db "<NEXT>people.<WAIT>"
    db "@"

Message_01_35::
    db "<VOICE2>*: The Log's Navel?<LINE>"
    db "What is that?<PROMPT>"
    db "<NEXT>I can show you my"
    db "<NEXT>navel on the sly.<WAIT>"
    db "@"

Message_01_36::
    db "<VOICE1>*: The Log's Navel?<LINE>"
    db "Let me think…<PROMPT>"
    db "<NEXT>Perhaps the King"
    db "<NEXT>in Asiya will<WAIT>"
    db "<NEXT>know."
    db "<NEXT><WAIT>"
    db "@"

Message_01_37::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>A sharp, spicy"
    db "<NEXT>aroma wafted out.<WAIT>"
    db "@"

Message_01_38::
    db "<VOICE1>*: The underground<LINE>"
    db "canal is ahead.<PROMPT>"
    db "<NEXT>The last King made"
    db "<NEXT>it for our people<PROMPT>"
    db "<NEXT>when there were"
    db "<NEXT>water shortages.<PROMPT>"
    db "<NEXT>It was a hard,"
    db "<NEXT>hard task.<WAIT>"
    db "@"

Message_01_39::
    db "<VOICE2>*: The King called<LINE>"
    db "a circus troupe to<PROMPT>"
    db "<NEXT>the town in the"
    db "<NEXT>south.<PROMPT>"
    db "<NEXT>I hope they weren't"
    db "<NEXT>mauled by thugs.<WAIT>"
    db "@"

Message_01_3A::
    db "<VOICE1>*: This is Asiya,<LINE>"
    db "the desert flower.<WAIT>"
    db "@"

Message_01_3B::
    db "<VOICE1>*: Our King came<LINE>"
    db "into an enormous<PROMPT>"
    db "<NEXT>inheritance. It"
    db "<NEXT>was mind-boggling.<PROMPT>"
    db "<NEXT>His treasury is"
    db "<NEXT>overflowing with<PROMPT>"
    db "<NEXT>incredible gold"
    db "<NEXT>and treasures.<PROMPT>"
    db "<NEXT>He's said to be"
    db "<NEXT>particularly proud<PROMPT>"
    db "<NEXT>of something"
    db "<NEXT>called TidalBell.<WAIT>"
    db "@"

Message_01_3C::
    db "<VOICE1>*: I saw a lake<LINE>"
    db "like a mirage.<PROMPT>"
    db "<NEXT>In the east of the"
    db "<NEXT>desert, it was.<PROMPT>"
    db "<NEXT>But it disappeared"
    db "<NEXT>as if by magic…<WAIT>"
    db "@"

Message_01_3D::
    db "<VOICE2>*: Strong monsters<LINE>"
    db "are in the well.<PROMPT>"
    db "<NEXT>You", $44, " better be"
    db "<NEXT>prepared if you<PROMPT>"
    db "<NEXT>are going down in"
    db "<NEXT>there.<WAIT>"
    db "@"

Message_01_3E::
    db "<VOICE1>*: Our King has<LINE>"
    db "been a fan of<PROMPT>"
    db "<NEXT>circuses since he"
    db "<NEXT>was a child.<PROMPT>"
    db "<NEXT>If there is a"
    db "<NEXT>circus, he always<PROMPT>"
    db "<NEXT>summons the troupe"
    db "<NEXT>to the castle.<WAIT>"
    db "@"

Message_01_3F::
    db "<VOICE1>*: The circus<LINE>"
    db "master was trying<PROMPT>"
    db "<NEXT>to recruit people"
    db "<NEXT>at the inn.<PROMPT>"
    db "<NEXT>He says the troupe"
    db "<NEXT>scattered when the<PROMPT>"
    db "<NEXT>thieves set on"
    db "<NEXT>them.<PROMPT>"
    db "<NEXT>Traveling is much"
    db "<NEXT>too risky for me!<WAIT>"
    db "@"

Message_01_40::
    db "<VOICE1>*: No one enters<LINE>"
    db "the castle without<PROMPT>"
    db "<NEXT>a proper permit!"
    db "<NEXT>Move along!<WAIT>"
    db "@"

Message_01_41::
    db "<VOICE1>*: If you want to<LINE>"
    db "get in that badly,<PROMPT>"
    db "<NEXT>we could arrest"
    db "<NEXT>you and toss you<PROMPT>"
    db "<NEXT>in the dungeon,"
    db "<NEXT>how's that sound?<WAIT>"
    db "@"

Message_01_42::
    db "<VOICE2>*: Did you want<LINE>"
    db "something, honey?<PROMPT>"
    db "<NEXT>A plug for the"
    db "<NEXT>Log's Navel?<PROMPT>"
    db "<NEXT>Well, the King"
    db "<NEXT>likes collecting<PROMPT>"
    db "<NEXT>all sorts of odd"
    db "<NEXT>things, so he may<PROMPT>"
    db "<NEXT>have something"
    db "<NEXT>that will work.<WAIT>"
    db "@"

Message_01_43::
    db "<VOICE1>*: When we get a<LINE>"
    db "hot spell, I sleep<PROMPT>"
    db "<NEXT>in the daytime,"
    db "<NEXT>and work at night.<PROMPT>"
    db "<NEXT>That's the only"
    db "<NEXT>way of coping!<WAIT>"
    db "@"

Message_01_44::
    db "<VOICE1>*: Welcome to my<LINE>"
    db "item shop!<PROMPT>"
    db "<NEXT>You may buy or"
    db "<NEXT>sell items here.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you today?<WAIT>"
    db "@"

Message_01_45::
    db "<VOICE1>*: Hello! How may I<LINE>"
    db "serve you today?<WAIT>"
    db "@"

Message_01_46::
    db "<VOICE1>*: The church<LINE>"
    db "welcomes you.<PROMPT>"
    db "<NEXT>We can heal you"
    db "<NEXT>from poisoning,<PROMPT>"
    db "<NEXT>lift curses, and"
    db "<NEXT>revive the dead.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you, my child?<WAIT>"
    db "@"

Message_01_47::
    db "<VOICE1>*: I am a servant<LINE>"
    db "to the gods.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you, my child?<WAIT>"
    db "@"

Message_01_48::
    db "<VOICE1>*: I am the leader<LINE>"
    db "of a circus.<PROMPT>"
    db "<NEXT>We were invited to"
    db "<NEXT>perform before the<PROMPT>"
    db "<NEXT>King, but my group"
    db "<NEXT>has scattered like<PROMPT>"
    db "<NEXT>so many leaves in"
    db "<NEXT>a storm.<PROMPT>"
    db "<NEXT>So, I am the only"
    db "<NEXT>one in my circus.<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>join me as a star?<CHOICE>"
    db "@"

Message_01_49::
    db "<VOICE1>*: Did you say yes?<LINE>"
    db "Yes, yes, you did!<PROMPT>"
    db "<NEXT>Your monsters will"
    db "<NEXT>make a fine act!<PROMPT>"
    db "<NEXT>You can have top"
    db "<NEXT>billing as our one<PROMPT>"
    db "<NEXT>and only fearless"
    db "<NEXT>monster master!<PROMPT>"
    db "<NEXT>Come, we must go"
    db "<NEXT>to the castle!<WAIT>"
    db "@"

Message_01_4A::
    db "<VOICE1>*: Did you say yes?<LINE>"
    db "Yes, yes, you did!<PROMPT>"
    db "<NEXT>Your monsters will"
    db "<NEXT>make a fine act!<PROMPT>"
    db "<NEXT>You can have top"
    db "<NEXT>billing as our one<PROMPT>"
    db "<NEXT>and only fearless"
    db "<NEXT>monster master!<PROMPT>"
    db "<NEXT>But a dead monster"
    db "<NEXT>is no good.<PROMPT>"
    db "<NEXT>It wouldn't look"
    db "<NEXT>good as an act.<PROMPT>"
    db "<NEXT>You must get three"
    db "<NEXT>healthy monsters.<WAIT>"
    db "@"

Message_01_4B::
    db "<VOICE1>*: Did you say yes?<LINE>"
    db "Yes, yes, you did!<PROMPT>"
    db "<NEXT>Your monsters will"
    db "<NEXT>make a fine act!<PROMPT>"
    db "<NEXT>You can have top"
    db "<NEXT>billing as our one<PROMPT>"
    db "<NEXT>and only fearless"
    db "<NEXT>monster master!<PROMPT>"
    db "<NEXT>But you need a"
    db "<NEXT>trio of monsters<PROMPT>"
    db "<NEXT>to make the act"
    db "<NEXT>work.<PROMPT>"
    db "<NEXT>You must get three"
    db "<NEXT>healthy monsters.<WAIT>"
    db "@"

Message_01_4C::
    db "<VOICE1>*: You close the<LINE>"
    db "door to stardom?<PROMPT>"
    db "<NEXT>That is most"
    db "<NEXT>unfortunate.<PROMPT>"
    db "<NEXT>If you change your"
    db "<NEXT>mind, I'll be here.<WAIT>"
    db "@"

Message_01_4D::
    db "<VOICE1>*: Ah, three<LINE>"
    db "healthy monsters!<PROMPT>"
    db "<NEXT>Very well done!"
    db "<NEXT>Bravo to you!<PROMPT>"
    db "<NEXT>You are officially"
    db "<NEXT>a circus member!<PROMPT>"
    db "<NEXT>Come, we must go"
    db "<NEXT>to the castle!<WAIT>"
    db "@"

Message_01_4E::
    db "<VOICE1>*: Oh, you need a<LINE>"
    db "trio of monsters<PROMPT>"
    db "<NEXT>to make the act"
    db "<NEXT>work.<PROMPT>"
    db "<NEXT>You must get three"
    db "<NEXT>healthy monsters.<WAIT>"
    db "@"

Message_01_4F::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>a gooey oil.<WAIT>"
    db "@"

Message_01_50::
    db "<VOICE1>*: I heard that the<LINE>"
    db "thieves disappear<PROMPT>"
    db "<NEXT>as soon as they"
    db "<NEXT>get their loot.<PROMPT>"
    db "<NEXT>No one's seen"
    db "<NEXT>their hideout.<WAIT>"
    db "@"

Message_01_51::
    db "<VOICE1>*: And that was the<LINE>"
    db "firebreather!<PROMPT>"
    db "<NEXT>Let's hear it for"
    db "<NEXT>this brave soul!<WAIT>"
    db "@"

Message_01_52::
    db "<VOICE1>*: Next, monsters"
    db "<NEXT>will perform some<PROMPT>"
    db "<NEXT>amazing, death"
    db "<NEXT>defying stunts!<WAIT>"
    db "@"

Message_01_53::
    db "<VOICE1>*: Very good show!<LINE>"
    db "That was splendid<PROMPT>"
    db "<NEXT>for your debut"
    db "<NEXT>performance!<PROMPT>"
    db "<NEXT>The audience was"
    db "<NEXT>quite pleased.<PROMPT>"
    db "<NEXT>We are to stay for"
    db "<NEXT>more shows here,<PROMPT>"
    db "<NEXT>so we have been"
    db "<NEXT>permitted to go<PROMPT>"
    db "<NEXT>into the castle by"
    db "<NEXT>the King.<WAIT>"
    db "@"

Message_01_54::
    db "<VOICE1>*: Several of our<LINE>"
    db "members came back.<PROMPT>"
    db "<NEXT>We have enough to"
    db "<NEXT>put on our shows.<WAIT>"
    db "@"

Message_01_55::
    db "<VOICE1>*: When the thieves<LINE>"
    db "raided us, we ran.<PROMPT>"
    db "<NEXT>But while we kept"
    db "<NEXT>our lives, we were<PROMPT>"
    db "<NEXT>separated from our"
    db "<NEXT>circus master.<WAIT>"
    db "@"

Message_01_56::
    db "<VOICE1>*: I wonder if the<LINE>"
    db "others are safe…<WAIT>"
    db "@"

Message_01_57::
    db "<VOICE1>*: Heh, did you see<LINE>"
    db "the looks I got<PROMPT>"
    db "<NEXT>when I blew fire?"
    db "<NEXT>Made me feel good!<WAIT>"
    db "@"

Message_01_58::
    db "<VOICE1>*: This is the<LINE>"
    db "King's treasury!<PROMPT>"
    db "<NEXT>No one, but no one"
    db "<NEXT>is allowed inside!<WAIT>"
    db "@"

Message_01_59::
    db "<VOICE1>*: What? See his<LINE>"
    db "Majesty's treasure?<PROMPT>"
    db "<NEXT>What foolishness!"
    db "<NEXT>No one gets by me<PROMPT>"
    db "<NEXT>without the King's"
    db "<NEXT>permission!<WAIT>"
    db "@"

Message_01_5A::
    db "<VOICE1>*: His Majesty is<LINE>"
    db "honest and most<PROMPT>"
    db "<NEXT>certainly not evil"
    db "<NEXT>in any way.<PROMPT>"
    db "<NEXT>But, he is rather"
    db "<NEXT>impetuous.<PROMPT>"
    db "<NEXT>I wish he wouldn't"
    db "<NEXT>order us on whim…<WAIT>"
    db "@"

Message_01_5B::
    db "<VOICE1>*: We frown upon<LINE>"
    db "strangers who<PROMPT>"
    db "<NEXT>wander through our"
    db "<NEXT>castle!<WAIT>"
    db "@"

Message_01_5C::
    db "<VOICE1>*: Why are you<LINE>"
    db "snooping around?<PROMPT>"
    db "<NEXT>Are you looking"
    db "<NEXT>for something?<CHOICE>"
    db "@"

Message_01_5D::
    db "<VOICE1>*: A new plug for<LINE>"
    db "the Log's Navel?<PROMPT>"
    db "<NEXT>It has to have a"
    db "<NEXT>magic power?<PROMPT>"
    db "<NEXT>Well, then there's"
    db "<NEXT>only the King's<PROMPT>"
    db "<NEXT>TidalBell among"
    db "<NEXT>his treasures.<PROMPT>"
    db "<NEXT>It can be used to"
    db "<NEXT>cross the sea.<WAIT>"
    db "@"

Message_01_5E::
    db "<VOICE1>*: Oh, it looked<LINE>"
    db "like you were on<PROMPT>"
    db "<NEXT>the prowl for"
    db "<NEXT>something.<WAIT>"
    db "@"

Message_01_5F::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>There were neatly"
    db "<NEXT>folded silk robes.<WAIT>"
    db "@"

Message_01_60::
    db "<VOICE1>King: Ah, you're<LINE>"
    db "the monster tamer<PROMPT>"
    db "<NEXT>from the circus."
    db "<NEXT>Good show!<PROMPT>"
    db "<NEXT>So, do you wish"
    db "<NEXT>something of me?<CHOICE>"
    db "@"

Message_01_61::
    db "<VOICE1>King: I see. This<LINE>"
    db "is what we'll do.<PROMPT>"
    db "<NEXT>I'll help you, if"
    db "<NEXT>you help me.<PROMPT>"
    db "<NEXT>I inherited the"
    db "<NEXT>throne from my<PROMPT>"
    db "<NEXT>father, who was a"
    db "<NEXT>great king.<PROMPT>"
    db "<NEXT>But my rule has"
    db "<NEXT>been beset by one<PROMPT>"
    db "<NEXT>disaster after"
    db "<NEXT>another.<PROMPT>"
    db "<NEXT>No one listens to"
    db "<NEXT>my orders now…<PROMPT>"
    db "<NEXT>Will you go find"
    db "<NEXT>out what concerns<PROMPT>"
    db "<NEXT>my people may"
    db "<NEXT>have?<PROMPT>"
    db "<NEXT>If I solved their"
    db "<NEXT>problems, I should<PROMPT>"
    db "<NEXT>regain their trust"
    db "<NEXT>and respect.<PROMPT>"
    db "<NEXT>Well? Will you do"
    db "<NEXT>this for me?<CHOICE>"
    db "@"

Message_01_62::
    db "<VOICE1>King: Then make<LINE>"
    db "way to the town.<PROMPT>"
    db "<NEXT>If you succeed,"
    db "<NEXT>you can have the<PROMPT>"
    db "<NEXT>TidalBell from my"
    db "<NEXT>treasures.<WAIT>"
    db "@"

Message_01_63::
    db "<VOICE1>King: Oh…<LINE>"
    db "You won't?<PROMPT>"
    db "<NEXT>Then, I can't help"
    db "<NEXT>you either.<WAIT>"
    db "@"

Message_01_64::
    db "<VOICE1>King: Investigate<LINE>"
    db "what concerns my<PROMPT>"
    db "<NEXT>people may have."
    db "<NEXT>Hurry!<WAIT>"
    db "@"

Message_01_65::
    db "<VOICE1>King: So? Have you<LINE>"
    db "decided to see<PROMPT>"
    db "<NEXT>what concerns my"
    db "<NEXT>people have?<CHOICE>"
    db "@"

Message_01_66::
    db "<VOICE1>*: That fool is a<LINE>"
    db "terrible swindler.<PROMPT>"
    db "<NEXT>I wouldn't lend an"
    db "<NEXT>ear to him!<WAIT>"
    db "@"

Message_01_67::
    db "<VOICE1>*: Humph! A mirage<LINE>"
    db "lake, he says!<PROMPT>"
    db "<NEXT>No one's seen such"
    db "<NEXT>a thing.<PROMPT>"
    db "<NEXT>Everything he says"
    db "<NEXT>is a lie!<WAIT>"
    db "@"

Message_01_68::
    db "<VOICE2>*: Do I have any<LINE>"
    db "concerns?<PROMPT>"
    db "<NEXT>You'll tell the"
    db "<NEXT>King for me?<PROMPT>"
    db "<NEXT>Then listen. The"
    db "<NEXT>well's almost dry.<PROMPT>"
    db "<NEXT>Could the King do"
    db "<NEXT>anything about it?<WAIT>"
    db "@"

Message_01_69::
    db "<VOICE2>*: We're worried<LINE>"
    db "about the well.<PROMPT>"
    db "<NEXT>The water level is"
    db "<NEXT>dropping sharply.<PROMPT>"
    db "<NEXT>We don't have any"
    db "<NEXT>confidence in the<PROMPT>"
    db "<NEXT>King, so we're not"
    db "<NEXT>sure what to do.<WAIT>"
    db "@"

Message_01_6A::
    db "<VOICE1>*: The King has<LINE>"
    db "given permission<PROMPT>"
    db "<NEXT>for you to come"
    db "<NEXT>and go freely.<WAIT>"
    db "@"

Message_01_6B::
    db "<VOICE1>*: The King is so<LINE>"
    db "frivolous.<PROMPT>"
    db "<NEXT>A circus makes him"
    db "<NEXT>happy? Please!<WAIT>"
    db "@"

Message_01_6C::
    db "<VOICE1>*: So, have you<LINE>"
    db "discovered what<PROMPT>"
    db "<NEXT>concerns my people"
    db "<NEXT>may have?<PROMPT>"
    db "<NEXT>What? The well is"
    db "<NEXT>running dry?<PROMPT>"
    db "<NEXT>I will order my"
    db "<NEXT>men to raise the<PROMPT>"
    db "<NEXT>flow of water into"
    db "<NEXT>the canal.<PROMPT>"
    db "<NEXT>Guards! Duke!"
    db "<NEXT>Anyone?<WAIT>"
    db "@"

Message_01_6D::
    db "<VOICE1>King: The canal is<LINE>"
    db "managed by the<PROMPT>"
    db "<NEXT>village of Kalka,"
    db "<NEXT>isn't that right?<PROMPT>"
    db "<NEXT>Send someone to"
    db "<NEXT>Kalka and have the<PROMPT>"
    db "<NEXT>manager open the"
    db "<NEXT>Canal Gate more!<WAIT>"
    db "@"

Message_01_6E::
    db "<VOICE1>*: Your Majesty, I<LINE>"
    db "must remind you…<PROMPT>"
    db "<NEXT>If that was done,"
    db "<NEXT>the oasis will<PROMPT>"
    db "<NEXT>become drained"
    db "<NEXT>immediately.<WAIT>"
    db "@"

Message_01_6F::
    db "<VOICE1>King: What?<LINE>"
    db "Never mind, then!<PROMPT>"
    db "<NEXT>I'll go to Kalka,"
    db "<NEXT>and check myself!<WAIT>"
    db "@"

Message_01_70::
    db "<VOICE1>*: I feel badly for"
    db "<NEXT>his Majesty, but<PROMPT>"
    db "<NEXT>he must think"
    db "<NEXT>things through.<PROMPT>"
    db "<NEXT>Rash actions with"
    db "<NEXT>no thought of the<PROMPT>"
    db "<NEXT>consequences won't"
    db "<NEXT>do for a ruler.<WAIT>"
    db "@"

Message_01_71::
    db "<VOICE1>*: What? Open the<LINE>"
    db "Canal Gate more?<PROMPT>"
    db "<NEXT>The oasis will run"
    db "<NEXT>dry if we did!<PROMPT>"
    db "<NEXT>That's an order I"
    db "<NEXT>simply cannot<PROMPT>"
    db "<NEXT>accept, King or no"
    db "<NEXT>King.<WAIT>"
    db "@"

Message_01_72::
    db "<VOICE1>King: Arrgh!<LINE>"
    db "I know that!<PROMPT>"
    db "<NEXT>I want to know why"
    db "<NEXT>the water is gone!<PROMPT>"
    db "<NEXT>Fine, I'll go find"
    db "<NEXT>out myself!<WAIT>"
    db "@"

Message_01_73::
    db "<VOICE1>*: …My, our King<LINE>"
    db "has no patience…<WAIT>"
    db "@"

Message_01_74::
    db "<VOICE1>*: I discovered why<LINE>"
    db "the water is low.<PROMPT>"
    db "<NEXT>This beast's dam"
    db "<NEXT>is at fault.<PROMPT>"
    db "<NEXT>I've been trying to"
    db "<NEXT>get it to destroy<PROMPT>"
    db "<NEXT>the dam, but to no"
    db "<NEXT>avail.<WAIT>"
    db "@"

Message_01_75::
    db "<VOICE1>*: I'm making a new<LINE>"
    db "home for my clan!<PROMPT>"
    db "<NEXT>Leave us be, or"
    db "<NEXT>pay the price!<WAIT>"
    db "@"

Message_01_76::
    db "<VOICE1>*: Gaah! You're too<LINE>"
    db "strong! You win!<PROMPT>"
    db "<NEXT>I didn't mean to"
    db "<NEXT>cause any trouble.<PROMPT>"
    db "<NEXT>We used to live in"
    db "<NEXT>Mirage Lake, but<PROMPT>"
    db "<NEXT>we were kicked out"
    db "<NEXT>by a band of thugs<PROMPT>"
    db "<NEXT>who made it their"
    db "<NEXT>hideout!<PROMPT>"
    db "<NEXT>I was looking for"
    db "<NEXT>a place to live…<WAIT>"
    db "@"

Message_01_77::
    db "<VOICE1>King: What? So<LINE>"
    db "that's the truth?<PROMPT>"
    db "<NEXT>Those wretched"
    db "<NEXT>scoundrels!<PROMPT>"
    db "<NEXT>I promise, I will"
    db "<NEXT>imprison them!<WAIT>"
    db "@"

Message_01_78::
    db "<VOICE1>*: You will?<LINE>"
    db "So we can go back<PROMPT>"
    db "<NEXT>to Mirage Lake and"
    db "<NEXT>live peacefully?<PROMPT>"
    db "<NEXT>Please catch the"
    db "<NEXT>thieves!<WAIT>"
    db "@"

Message_01_79::
    db "<VOICE1>King: This should<LINE>"
    db "solve the water<PROMPT>"
    db "<NEXT>shortage in the"
    db "<NEXT>town.<PROMPT>"
    db "<NEXT>I humbly thank you"
    db "<NEXT>for your help!<PROMPT>"
    db "<NEXT>Come see me in the"
    db "<NEXT>Castle.<PROMPT>"
    db "<NEXT>I will have the"
    db "<NEXT>TidalBell for you.<WAIT>"
    db "@"

Message_01_7A::
    db "<VOICE1>*: Oh? You say that<LINE>"
    db "a monster had been<PROMPT>"
    db "<NEXT>blocking the canal"
    db "<NEXT>with a dam?<WAIT>"
    db "@"

Message_01_7B::
    db "<VOICE2>*: The well has<LINE>"
    db "ample water again.<PROMPT>"
    db "<NEXT>Our King managed"
    db "<NEXT>to do it!<PROMPT>"
    db "<NEXT>Maybe he isn't a"
    db "<NEXT>total buffoon…<WAIT>"
    db "@"

Message_01_7C::
    db "<VOICE1>*: We have heard<LINE>"
    db "from his Majesty.<PROMPT>"
    db "<NEXT>Please, do go"
    db "<NEXT>right through.<WAIT>"
    db "@"

Message_01_7D::
    db "<VOICE2>*: Hi! Did you hear<LINE>"
    db "the news?<PROMPT>"
    db "<NEXT>Our King is quite"
    db "<NEXT>the brave man.<PROMPT>"
    db "<NEXT>With just one"
    db "<NEXT>underling, he<PROMPT>"
    db "<NEXT>defeated monsters"
    db "<NEXT>in the canal, and<PROMPT>"
    db "<NEXT>saved the town"
    db "<NEXT>from a drought!<WAIT>"
    db "@"

Message_01_7E::
    db "<VOICE1>*: The King solved<LINE>"
    db "our water shortage<PROMPT>"
    db "<NEXT>all by himself,"
    db "<NEXT>I've heard.<PROMPT>"
    db "<NEXT>Perhaps we were"
    db "<NEXT>wrong about him.<WAIT>"
    db "@"

Message_01_7F::
    db "<VOICE1>*: Our King worked<LINE>"
    db "to save all of us…<PROMPT>"
    db "<NEXT>I'm ashamed… What"
    db "<NEXT>have I done?<WAIT>"
    db "@"

Message_01_80::
    db "<VOICE1>*: The King appears<LINE>"
    db "to have turned a<PROMPT>"
    db "<NEXT>new leaf as a"
    db "<NEXT>great ruler.<PROMPT>"
    db "<NEXT>I can finally say"
    db "<NEXT>I've fulfilled my<PROMPT>"
    db "<NEXT>promise to his"
    db "<NEXT>late father…<WAIT>"
    db "@"

Message_01_81::
    db "<VOICE1>King: The town's<LINE>"
    db "water shortage<PROMPT>"
    db "<NEXT>seems to be no"
    db "<NEXT>longer a concern.<PROMPT>"
    db "<NEXT>I thank you again"
    db "<NEXT>for your work.<PROMPT>"
    db "<NEXT>Your reward is the"
    db "<NEXT>TidalBell.<PROMPT>"
    db "<NEXT>Come, follow me to"
    db "<NEXT>the treasury.<WAIT>"
    db "@"

Message_01_82::
    db "<VOICE1>King: Wha-what?<LINE>"
    db "What happened?<WAIT>"
    db "@"

Message_01_83::
    db "<VOICE1>*: …We… We were<LINE>"
    db "jumped by thieves…<PROMPT>"
    db "<NEXT>They… made off"
    db "<NEXT>with the treasure…<WAIT>"
    db "@"

Message_01_84::
    db "<VOICE1>King: What?<LINE>"
    db "Arrrrgh!<PROMPT>"
    db "<NEXT>Round up all the"
    db "<NEXT>men at once!<PROMPT>"
    db "<NEXT>Have them report"
    db "<NEXT>to my chamber!<WAIT>"
    db "@"

Message_01_85::
    db "<VOICE1>King: The hideout<LINE>"
    db "of the thieves is<PROMPT>"
    db "<NEXT>said to be in"
    db "<NEXT>Mirage Lake!<PROMPT>"
    db "<NEXT>They must be"
    db "<NEXT>caught!<PROMPT>"
    db "<NEXT>I will lead the"
    db "<NEXT>expedition myself!<PROMPT>"
    db "<NEXT>Who will join me"
    db "<NEXT>in this quest?<WAIT>"
    db "@"

Message_01_86::
    db "<VOICE1>King: Good! Your<LINE>"
    db "valor be praised!<PROMPT>"
    db "<NEXT>We must capture"
    db "<NEXT>the thieves, at<PROMPT>"
    db "<NEXT>all costs."
    db "<NEXT>This is a mission!<WAIT>"
    db "@"

Message_01_87::
    db "<VOICE1>King: I apologize,<LINE>"
    db "but my treasures<PROMPT>"
    db "<NEXT>were taken by the"
    db "<NEXT>thieves.<PROMPT>"
    db "<NEXT>I will head to"
    db "<NEXT>Mirage Lake and<PROMPT>"
    db "<NEXT>bring them to"
    db "<NEXT>justice.<PROMPT>"
    db "<NEXT>If we return"
    db "<NEXT>safely, you shall<PROMPT>"
    db "<NEXT>have the promised"
    db "<NEXT>TidalBell.<WAIT>"
    db "@"

Message_01_88::
    db "<VOICE1>*: Wh-where is<LINE>"
    db "everybody?<PROMPT>"
    db "<NEXT>I haven't been fed"
    db "<NEXT>at all…<PROMPT>"
    db "<NEXT>Listen, I'll let"
    db "<NEXT>you in on a secret<PROMPT>"
    db "<NEXT>if you have any"
    db "<NEXT>food. Well?<CHOICE>"
    db "@"

Message_01_89::
    db "<BUF0> handed over<LINE>"
    db "some food.<WAIT>"
    db "@"

Message_01_8A::
    db "<VOICE1>*: Munch, munch…<LINE>"
    db "Chew, gulp…<PROMPT>"
    db "<NEXT>Fwoaar, that hits"
    db "<NEXT>the spot! Thanks!<PROMPT>"
    db "<NEXT>Well, here's the"
    db "<NEXT>secret I promised.<PROMPT>"
    db "<NEXT>Don't chase what"
    db "<NEXT>runs from you.<PROMPT>"
    db "<NEXT>Lay some bait, and"
    db "<NEXT>let it come.<PROMPT>"
    db "<NEXT>That's the trick."
    db "<NEXT>Here, take this.<WAIT>"
    db "@"

Message_01_8B::
    db "<BUF0> received a<LINE>"
    db "WaterCall.<WAIT>"
    db "@"

Message_01_8C::
    db "<BUF0> had no food<LINE>"
    db "to give…<WAIT>"
    db "@"

Message_01_8D::
    db "<VOICE1>*: Tch, what good<LINE>"
    db "are you?<PROMPT>"
    db "<NEXT>I'm starving here."
    db "<NEXT>Anything'll do.<PROMPT>"
    db "<NEXT>Even food for"
    db "<NEXT>monsters is good!<WAIT>"
    db "@"
    ds $16a, $00
