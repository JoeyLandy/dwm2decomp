; ROM bank $2E: messages
; The annotated listing of this bank is build/listing/bank2e.asm.

SECTION "Bank 2E", ROMX
    db $2e

; Starts a message of message groups 6 and 7 (strings of category 0 of bank $2E, picked by
; wStringIndex). When wStringIndex is below $A6 it calls BeginStringDisplay with DE =
; MessageStrings_Bank2E; from $A6 on it far-calls BeginStringDisplay_Bank2E_Overflow in bank $99,
; which subtracts $A6 from wStringIndex and uses the overflow table. BeginStringDisplay blanks the
; text window, points the text printer at the string and sets wTextFlags to 1; the text appears on
; the following frames. Reached by farcall from the message group dispatch (ShowMessageHL in bank
; $5F, StartMessageForGroup_Groups06And07 in bank $10) and from the debug menu in bank $01. (C1,
; E-0378)
; message bank $2E: when wStringIndex < $A6, BeginStringDisplay with this bank's table
; MessageStrings_Bank2E; otherwise far-calls BeginStringDisplay_Bank2E_Overflow (E-0080)
BeginStringDisplay_Bank2E:: ; configured code entry (E-0395 (BeginStringDisplay_Bank2E: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld a, [wStringIndex]
    cp $a6
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2E_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2E
    call BeginStringDisplay
    ret

SECTION "Bank 2E CopyStringToBuffer_Bank2E", ROMX

; Copies a message of message groups 6 and 7 to a buffer instead of printing it: string wStringIndex
; of category wStringCategory is copied, with its $F0 terminator, to the address in
; wStringDestLo/wStringDestHi. When wStringIndex is below $A6 it uses MessageStrings_Bank2E through
; CopyStringToBuffer; from $A6 on it far-calls CopyStringToBuffer_Bank2E_Overflow in bank $99, which
; subtracts $A6 from wStringIndex first (so wStringIndex is changed). Nothing in src/ calls this
; copy by name. (C2, E-0378)
; message bank $2E: when wStringIndex < $A6, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2E; otherwise far-calls CopyStringToBuffer_Bank2E_Overflow (E-0080)
CopyStringToBuffer_Bank2E:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wStringIndex]
    cp $a6
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2E_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2E
    call CopyStringToBuffer
    ret

SECTION "Bank 2E ShowStringAtOnce_Bank2E", ROMX

; Calls BeginStringDisplay_Bank2E, which starts string wStringIndex of its table, then
; RunStringDisplayToEnd, which prints the whole string at once (wTextFlags bit 1) instead of a glyph
; per frame. No traced code, jump table or pointer reaches it (E-0395: it decodes as a routine but
; is unreached in the static listing). (C1, E-0395)
ShowStringAtOnce_Bank2E:: ; configured code entry (E-0395); C0
    call BeginStringDisplay_Bank2E
    call RunStringDisplayToEnd
    ret

SECTION "Bank 2E MessageStrings_Bank2E", ROMX

; One little-endian word, a pointer to StringList_Bank2E_0, the list of 166 message pointers
; Message_06_00 to Message_06_A5 (message group 6, bank $2E). LookupString reads word
; wStringCategory of it (category 0 is the only word), then word wStringIndex of that list.
; BeginStringDisplay_Bank2E and CopyStringToBuffer_Bank2E pass it in DE for wStringIndex below $A6;
; higher ids go to their Overflow routine. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
MessageStrings_Bank2E::
    dw StringList_Bank2E_0 ; id 0

; category list of MessageStrings_Bank2E; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2E_0::
    dw Message_06_00 ; id 0
    dw Message_06_01 ; id 1
    dw Message_06_02 ; id 2
    dw Message_06_03 ; id 3
    dw Message_06_04 ; id 4
    dw Message_06_05 ; id 5
    dw Message_06_06 ; id 6
    dw Message_06_07 ; id 7
    dw Message_06_08 ; id 8
    dw Message_06_09 ; id 9
    dw Message_06_0A ; id 10
    dw Message_06_0B ; id 11
    dw Message_06_0C ; id 12
    dw Message_06_0D ; id 13
    dw Message_06_0E ; id 14
    dw Message_06_0F ; id 15
    dw Message_06_10 ; id 16
    dw Message_06_11 ; id 17
    dw Message_06_12 ; id 18
    dw Message_06_13 ; id 19
    dw Message_06_14 ; id 20
    dw Message_06_15 ; id 21
    dw Message_06_16 ; id 22
    dw Message_06_17 ; id 23
    dw Message_06_18 ; id 24
    dw Message_06_19 ; id 25
    dw Message_06_19 ; id 26
    dw Message_06_1B ; id 27
    dw Message_06_1C ; id 28
    dw Message_06_1D ; id 29
    dw Message_06_1E ; id 30
    dw Message_06_1F ; id 31
    dw Message_06_20 ; id 32
    dw Message_06_21 ; id 33
    dw Message_06_22 ; id 34
    dw Message_06_23 ; id 35
    dw Message_06_24 ; id 36
    dw Message_06_25 ; id 37
    dw Message_06_26 ; id 38
    dw Message_06_27 ; id 39
    dw Message_06_28 ; id 40
    dw Message_06_29 ; id 41
    dw Message_06_2A ; id 42
    dw Message_06_2B ; id 43
    dw Message_06_2C ; id 44
    dw Message_06_2D ; id 45
    dw Message_06_2E ; id 46
    dw Message_06_2F ; id 47
    dw Message_06_30 ; id 48
    dw Message_06_31 ; id 49
    dw Message_06_32 ; id 50
    dw Message_06_33 ; id 51
    dw Message_06_34 ; id 52
    dw Message_06_35 ; id 53
    dw Message_06_36 ; id 54
    dw Message_06_37 ; id 55
    dw Message_06_38 ; id 56
    dw Message_06_39 ; id 57
    dw Message_06_3A ; id 58
    dw Message_06_3B ; id 59
    dw Message_06_3C ; id 60
    dw Message_06_3D ; id 61
    dw Message_06_3E ; id 62
    dw Message_06_3F ; id 63
    dw Message_06_40 ; id 64
    dw Message_06_41 ; id 65
    dw Message_06_42 ; id 66
    dw Message_06_43 ; id 67
    dw Message_06_44 ; id 68
    dw Message_06_45 ; id 69
    dw Message_06_45 ; id 70
    dw Message_06_47 ; id 71
    dw Message_06_48 ; id 72
    dw Message_06_49 ; id 73
    dw Message_06_4A ; id 74
    dw Message_06_4B ; id 75
    dw Message_06_4C ; id 76
    dw Message_06_4D ; id 77
    dw Message_06_4E ; id 78
    dw Message_06_4F ; id 79
    dw Message_06_50 ; id 80
    dw Message_06_51 ; id 81
    dw Message_06_52 ; id 82
    dw Message_06_53 ; id 83
    dw Message_06_54 ; id 84
    dw Message_06_55 ; id 85
    dw Message_06_56 ; id 86
    dw Message_06_57 ; id 87
    dw Message_06_58 ; id 88
    dw Message_06_59 ; id 89
    dw Message_06_5A ; id 90
    dw Message_06_5B ; id 91
    dw Message_06_5C ; id 92
    dw Message_06_5D ; id 93
    dw Message_06_5E ; id 94
    dw Message_06_5F ; id 95
    dw Message_06_60 ; id 96
    dw Message_06_61 ; id 97
    dw Message_06_62 ; id 98
    dw Message_06_63 ; id 99
    dw Message_06_64 ; id 100
    dw Message_06_65 ; id 101
    dw Message_06_66 ; id 102
    dw Message_06_67 ; id 103
    dw Message_06_68 ; id 104
    dw Message_06_69 ; id 105
    dw Message_06_6A ; id 106
    dw Message_06_6B ; id 107
    dw Message_06_6C ; id 108
    dw Message_06_6D ; id 109
    dw Message_06_6E ; id 110
    dw Message_06_6F ; id 111
    dw Message_06_70 ; id 112
    dw Message_06_71 ; id 113
    dw Message_06_72 ; id 114
    dw Message_06_73 ; id 115
    dw Message_06_74 ; id 116
    dw Message_06_75 ; id 117
    dw Message_06_76 ; id 118
    dw Message_06_77 ; id 119
    dw Message_06_78 ; id 120
    dw Message_06_79 ; id 121
    dw Message_06_7A ; id 122
    dw Message_06_7B ; id 123
    dw Message_06_7C ; id 124
    dw Message_06_7D ; id 125
    dw Message_06_7E ; id 126
    dw Message_06_7F ; id 127
    dw Message_06_80 ; id 128
    dw Message_06_81 ; id 129
    dw Message_06_82 ; id 130
    dw Message_06_83 ; id 131
    dw Message_06_83 ; id 132
    dw Message_06_83 ; id 133
    dw Message_06_83 ; id 134
    dw Message_06_87 ; id 135
    dw Message_06_88 ; id 136
    dw Message_06_89 ; id 137
    dw Message_06_8A ; id 138
    dw Message_06_8B ; id 139
    dw Message_06_8C ; id 140
    dw Message_06_8D ; id 141
    dw Message_06_8E ; id 142
    dw Message_06_8F ; id 143
    dw Message_06_90 ; id 144
    dw Message_06_91 ; id 145
    dw Message_06_92 ; id 146
    dw Message_06_93 ; id 147
    dw Message_06_94 ; id 148
    dw Message_06_95 ; id 149
    dw Message_06_96 ; id 150
    dw Message_06_97 ; id 151
    dw Message_06_98 ; id 152
    dw Message_06_99 ; id 153
    dw Message_06_9A ; id 154
    dw Message_06_9B ; id 155
    dw Message_06_9C ; id 156
    dw Message_06_9D ; id 157
    dw Message_06_9E ; id 158
    dw Message_06_9F ; id 159
    dw Message_06_A0 ; id 160
    dw Message_06_A1 ; id 161
    dw Message_06_A2 ; id 162
    dw Message_06_A3 ; id 163
    dw Message_06_A4 ; id 164
    dw Message_06_A5 ; id 165

Message_06_00::
    db "<VOICE2>*: Oh!<WAIT>"
    db "@"

Message_06_01::
    db "<VOICE1>*: You're a human.<LINE>"
    db "How did you get in<PROMPT>"
    db "<NEXT>here? This world"
    db "<NEXT>is only for elves.<PROMPT>"
    db "<NEXT>Get out of our"
    db "<NEXT>world!<WAIT>"
    db "@"

Message_06_02::
    db "<VOICE1>*: Even worse, you<LINE>"
    db "have monsters.<PROMPT>"
    db "<NEXT>Get out of our"
    db "<NEXT>world!<WAIT>"
    db "@"

Message_06_03::
    db "<VOICE2>*: Are you maybe a<LINE>"
    db "human?<CHOICE>"
    db "@"

Message_06_04::
    db "<VOICE1>*: So Cyal took a<LINE>"
    db "shine to you?<PROMPT>"
    db "<NEXT>That means you're"
    db "<NEXT>not evil.<PROMPT>"
    db "<NEXT>Well, fine. This"
    db "<NEXT>is what we'll do.<PROMPT>"
    db "<NEXT>You be my sister"
    db "<NEXT>Cyal's friend.<PROMPT>"
    db "<NEXT>If you", $44, " do that,"
    db "<NEXT>I'll tell you where<PROMPT>"
    db "<NEXT>the Elven village"
    db "<NEXT>is located.<PROMPT>"
    db "<NEXT>I'm Rolt, and I"
    db "<NEXT>guard the forest.<WAIT>"
    db "@"

Message_06_05::
    db "<VOICE2>Cyal: Yay, you'll<LINE>"
    db "be my friend?<PROMPT>"
    db "<NEXT>What's your name?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>…<BUF0>? We'll be"
    db "<NEXT>good pals, <BUF0>.<WAIT>"
    db "@"

Message_06_06::
    db "<VOICE1>Rolt: Go south in<LINE>"
    db "the plains, and<PROMPT>"
    db "<NEXT>you'll reach our"
    db "<NEXT>village.<PROMPT>"
    db "<NEXT><BUF0>, you really"
    db "<NEXT>should go.<WAIT>"
    db "@"

Message_06_07::
    db "<VOICE2>Cyal: We're going<LINE>"
    db "back home now.<PROMPT>"
    db "<NEXT>Maybe we can meet"
    db "<NEXT>in the village.<WAIT>"
    db "@"

Message_06_08::
    db "<VOICE1>*: Hello, munchkin.<LINE>"
    db "Enjoy your stay!<WAIT>"
    db "@"

Message_06_09::
    db "<VOICE2>*: A human here?<LINE>"
    db "It's been several<PROMPT>"
    db "<NEXT>centuries since"
    db "<NEXT>one last visited.<WAIT>"
    db "@"

Message_06_0A::
    db "<VOICE1>*: You're not like<LINE>"
    db "us. You scare me…<WAIT>"
    db "@"

Message_06_0B::
    db "<VOICE1>*: Hey there! I'm<LINE>"
    db "a talking horse.<PROMPT>"
    db "<NEXT>Glad to meet you,"
    db "<NEXT>I'm sure.<PROMPT>"
    db "<NEXT>The monsters near"
    db "<NEXT>the village are<PROMPT>"
    db "<NEXT>quite docile and"
    db "<NEXT>harmless, but<PROMPT>"
    db "<NEXT>vicious monsters"
    db "<NEXT>live farther away.<PROMPT>"
    db "<NEXT>It's dangerous, so"
    db "<NEXT>I", $44, " stick close to<PROMPT>"
    db "<NEXT>the village if I"
    db "<NEXT>were you.<WAIT>"
    db "@"

Message_06_0C::
    db "<VOICE2>*: This horse was<LINE>"
    db "here before us.<WAIT>"
    db "@"

Message_06_0D::
    db "<VOICE1>*: This is Elven<LINE>"
    db "village.<PROMPT>"
    db "<NEXT>You're a human,"
    db "<NEXT>aren't you?<WAIT>"
    db "@"

Message_06_0E::
    db "<VOICE1>*: Welcome! How may<LINE>"
    db "I help you today?<WAIT>"
    db "@"

Message_06_0F::
    db "<VOICE1>*: Well, well… It<LINE>"
    db "is a rare sight<PROMPT>"
    db "<NEXT>indeed to see a"
    db "<NEXT>human here.<PROMPT>"
    db "<NEXT>I'm the Village"
    db "<NEXT>Elder.<PROMPT>"
    db "<NEXT>By the way, have"
    db "<NEXT>you seen two young<PROMPT>"
    db "<NEXT>elves? They are"
    db "<NEXT>brother and sister<PROMPT>"
    db "<NEXT>and have yet to"
    db "<NEXT>return from the<PROMPT>"
    db "<NEXT>forest in the"
    db "<NEXT>north.<WAIT>"
    db "@"

Message_06_10::
    db "<VOICE1>*: Well, well, a<LINE>"
    db "human here is a<PROMPT>"
    db "<NEXT>rare sight to see"
    db "<NEXT>indeed.<PROMPT>"
    db "<NEXT>What's that? You"
    db "<NEXT>say Rolt told you<PROMPT>"
    db "<NEXT>how to find this"
    db "<NEXT>village?<PROMPT>"
    db "<NEXT>I see. Welcome."
    db "<NEXT>You're our guests.<WAIT>"
    db "@"

Message_06_11::
    db "<VOICE1>Rolt: That was<LINE>"
    db "fast, <BUF0>.<PROMPT>"
    db "<NEXT>I was worried that"
    db "<NEXT>you might be lost.<WAIT>"
    db "@"

Message_06_12::
    db "<VOICE2>Cyal: <BUF0>, let's<LINE>"
    db "play!<PROMPT>"
    db "<NEXT>I want to play"
    db "<NEXT>hide and seek!<PROMPT>"
    db "<NEXT>I'll be waiting"
    db "<NEXT>outside for you!<WAIT>"
    db "@"

Message_06_13::
    db "<VOICE1>*: I'm the village's<LINE>"
    db "elder.<PROMPT>"
    db "<NEXT>What's that? You"
    db "<NEXT>say Rolt told you<PROMPT>"
    db "<NEXT>how to find this"
    db "<NEXT>village?<PROMPT>"
    db "<NEXT>I see. Welcome."
    db "<NEXT>You're our guests.<WAIT>"
    db "@"

Message_06_14::
    db "<VOICE1>*: Tamed monsters,<LINE>"
    db "have you?<PROMPT>"
    db "<NEXT>That's impressive"
    db "<NEXT>for a youngster.<WAIT>"
    db "@"

Message_06_15::
    db "<VOICE1>Rolt: <BUF0>, I can<LINE>"
    db "see that Cyal has<PROMPT>"
    db "<NEXT>taken a real"
    db "<NEXT>liking to you.<PROMPT>"
    db "<NEXT>She", $44, " always looked"
    db "<NEXT>forward to meeting<PROMPT>"
    db "<NEXT>a human, and she"
    db "<NEXT>got her wish.<PROMPT>"
    db "<NEXT>Could you be a"
    db "<NEXT>friend to her even<PROMPT>"
    db "<NEXT>if it's only for a"
    db "<NEXT>short while?<WAIT>"
    db "@"

Message_06_16::
    db "<VOICE2>Cyal: Listen,<LINE>"
    db "<BUF0>. We should<PROMPT>"
    db "<NEXT>go to the Elven"
    db "<NEXT>forest.<PROMPT>"
    db "<NEXT>We can play in the"
    db "<NEXT>big clearing!<PROMPT>"
    db "<NEXT>Do you remember?"
    db "<NEXT>It's where we met.<PROMPT>"
    db "<NEXT>I'll go ahead, but"
    db "<NEXT>don't make me wait!<WAIT>"
    db "@"

Message_06_17::
    db "<VOICE1>*: Cyal grew up as<LINE>"
    db "an orphan.<PROMPT>"
    db "<NEXT>Her parents were"
    db "<NEXT>killed by monsters<PROMPT>"
    db "<NEXT>while she was"
    db "<NEXT>still a baby.<PROMPT>"
    db "<NEXT>Rolt tries very"
    db "<NEXT>hard to make sure<PROMPT>"
    db "<NEXT>Cyal doesn't get"
    db "<NEXT>lonesome.<PROMPT>"
    db "<NEXT>That's why he"
    db "<NEXT>pampers her.<WAIT>"
    db "@"

Message_06_18::
    db "<VOICE2>*: Cyal and Rolt<LINE>"
    db "have no family<PROMPT>"
    db "<NEXT>except each other."
    db "<NEXT>If you have any<PROMPT>"
    db "<NEXT>siblings, treat"
    db "<NEXT>them with love.<WAIT>"
    db "@"

Message_06_19::
    db "<VOICE1>*: Cyal's parents<LINE>"
    db "were attacked by<PROMPT>"
    db "<NEXT>horrible monsters."
    db "<NEXT>They come and raid<PROMPT>"
    db "<NEXT>our village every"
    db "<NEXT>so often.<PROMPT>"
    db "<NEXT>That's why we post"
    db "<NEXT>lookouts around<PROMPT>"
    db "<NEXT>the village."
    db "<NEXT>Rolt says he will<PROMPT>"
    db "<NEXT>get his revenge"
    db "<NEXT>one day.<WAIT>"
    db "@"

Message_06_1B::
    db "<VOICE1>*: I think Cyal's<LINE>"
    db "looking forward to<PROMPT>"
    db "<NEXT>playing with you"
    db "<NEXT>a lot.<WAIT>"
    db "@"

Message_06_1C::
    db "<VOICE2>*: Humans can't be<LINE>"
    db "trusted, but…<PROMPT>"
    db "<NEXT>Please watch over"
    db "<NEXT>Cyal.<WAIT>"
    db "@"

Message_06_1D::
    db "<VOICE2>Cyal: Oh! <BUF0>!<LINE>"
    db "I'm over here!<PROMPT>"
    db "<NEXT>Let's play hide-"
    db "<NEXT>and-seek!<PROMPT>"
    db "<NEXT>I'll hide, so you"
    db "<NEXT>count to ten, and<PROMPT>"
    db "<NEXT>then come look for"
    db "<NEXT>me, OK? <PROMPT>"
    db "<NEXT>Ready? Start!"
    db "<NEXT><WAIT>"
    db "@"

Message_06_1E::
    db "<BUF0> counted off…<LINE>"
    db "<WAIT>"
    db "@"

Message_06_1F::
    db "<VOICE2>Cyal: Eeek, <BUF0>!<LINE>"
    db "Help me!<WAIT>"
    db "@"

Message_06_20::
    db "<VOICE1>*: Master AgDevil,<LINE>"
    db "a human, ruff!<WAIT>"
    db "@"

Message_06_21::
    db "<VOICE1>*: What shall we<LINE>"
    db "do, ruff?<WAIT>"
    db "@"

Message_06_22::
    db "<VOICE1>*: Human? They<LINE>"
    db "taste horrible…<PROMPT>"
    db "<NEXT>You lot can have"
    db "<NEXT>it, enjoy, kiki!<PROMPT>"
    db "<NEXT>I'll take this"
    db "<NEXT>appetizing one and<PROMPT>"
    db "<NEXT>savor it slowly,"
    db "<NEXT>kikiki!<WAIT>"
    db "@"

Message_06_23::
    db "<VOICE1>*: Tch, we have to<LINE>"
    db "eat the lousy food<PROMPT>"
    db "<NEXT>like we always do,"
    db "<NEXT>ruff!<WAIT>"
    db "@"

Message_06_24::
    db "<VOICE1>*: That's what we'll<LINE>"
    db "do, kid.<PROMPT>"
    db "<NEXT>You're our dinner"
    db "<NEXT>today, ruff!<WAIT>"
    db "@"

Message_06_25::
    db "<VOICE1>*: Tch, I can't<LINE>"
    db "enjoy my meal like<PROMPT>"
    db "<NEXT>this. I'll have my"
    db "<NEXT>meal back home,<PROMPT>"
    db "<NEXT>kiki! Bye, you"
    db "<NEXT>horrible tasting<PROMPT>"
    db "<NEXT>human!"
    db "<NEXT><WAIT>"
    db "@"

Message_06_26::
    db "<VOICE1>*: Huh? It's here<LINE>"
    db "again, ruff!<PROMPT>"
    db "<NEXT>It's persistent,"
    db "<NEXT>ruff!<PROMPT>"
    db "<NEXT>This time, we'll"
    db "<NEXT>show no mercy!<PROMPT>"
    db "<NEXT>Say your prayers,"
    db "<NEXT>ruff!<WAIT>"
    db "@"

Message_06_27::
    db "<VOICE1>*: You've come back<LINE>"
    db "again, ruff?<PROMPT>"
    db "<NEXT>You're stupid but"
    db "<NEXT>brave, ruff!<WAIT>"
    db "@"

Message_06_28::
    db "<VOICE1>Rolt: What? Cyal<LINE>"
    db "was abducted?<PROMPT>"
    db "<NEXT>Who did it?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>What? An AgDevil"
    db "<NEXT>took my sister?<PROMPT>"
    db "<NEXT>That fiend!"
    db "<NEXT>Arrrrgh!<WAIT>"
    db "@"

Message_06_29::
    db "<VOICE1>*: Rolt, wait!<LINE>"
    db "…Gone already…<WAIT>"
    db "@"

Message_06_2A::
    db "<VOICE1>*: AgDevil killed<LINE>"
    db "Rolt's parents.<PROMPT>"
    db "<NEXT>Rolt must have"
    db "<NEXT>gone to save Cyal…<PROMPT>"
    db "<NEXT>But no one seems"
    db "<NEXT>to know exactly<PROMPT>"
    db "<NEXT>where the monsters"
    db "<NEXT>come from.<PROMPT>"
    db "<NEXT>Perhaps someone in"
    db "<NEXT>the lookout post<PROMPT>"
    db "<NEXT>would have a"
    db "<NEXT>better idea…<WAIT>"
    db "@"

Message_06_2B::
    db "<VOICE1>*: AgDevil appears<LINE>"
    db "to come from deep<PROMPT>"
    db "<NEXT>in the mountains."
    db "<NEXT>Perhaps someone in<PROMPT>"
    db "<NEXT>the lookout post"
    db "<NEXT>would know more.<WAIT>"
    db "@"

Message_06_2C::
    db "<VOICE1>*: AgDevil is a<LINE>"
    db "total terror.<PROMPT>"
    db "<NEXT>We built a lookout"
    db "<NEXT>post so we can<PROMPT>"
    db "<NEXT>keep an eye out"
    db "<NEXT>for him.<PROMPT>"
    db "<NEXT>It's in the middle"
    db "<NEXT>of the plains to<PROMPT>"
    db "<NEXT>the east where few"
    db "<NEXT>trees grow.<PROMPT>"
    db "<NEXT>Someone in the"
    db "<NEXT>lookout post may<PROMPT>"
    db "<NEXT>have an idea where"
    db "<NEXT>the monsters live.<WAIT>"
    db "@"

Message_06_2D::
    db "<VOICE1>*: Cyal was taken<LINE>"
    db "away by monsters?<PROMPT>"
    db "<NEXT>That… That's just"
    db "<NEXT>terrible!<PROMPT>"
    db "<NEXT>What were the"
    db "<NEXT>lookouts doing?<PROMPT>"
    db "<NEXT>Where is the"
    db "<NEXT>lookout post?<PROMPT>"
    db "<NEXT>It's out in the"
    db "<NEXT>east.<WAIT>"
    db "@"

Message_06_2E::
    db "<VOICE2>*: Didn't I ask you<LINE>"
    db "to protect Cyal?<WAIT>"
    db "@"

Message_06_2F::
    db "<VOICE1>*: This is Elven's<LINE>"
    db "lookout post.<PROMPT>"
    db "<NEXT>We stand guard to"
    db "<NEXT>prevent monsters<PROMPT>"
    db "<NEXT>from attacking the"
    db "<NEXT>village.<PROMPT>"
    db "<NEXT>Your monsters won't"
    db "<NEXT>do anything bad?<WAIT>"
    db "@"

Message_06_30::
    db "<VOICE2>*: Horrid monsters<LINE>"
    db "that attack elves<PROMPT>"
    db "<NEXT>appear often in"
    db "<NEXT>these parts.<PROMPT>"
    db "<NEXT>You can avoid"
    db "<NEXT>monsters in this<PROMPT>"
    db "<NEXT>lookout, and Elven"
    db "<NEXT>village.<PROMPT>"
    db "<NEXT>Those are about"
    db "<NEXT>the only havens.<WAIT>"
    db "@"

Message_06_31::
    db "<VOICE1>*: This is the<LINE>"
    db "lookout post.<PROMPT>"
    db "<NEXT>Rolt came by a"
    db "<NEXT>while ago asking<PROMPT>"
    db "<NEXT>about the hideouts"
    db "<NEXT>of monsters.<PROMPT>"
    db "<NEXT>What? Cyal was"
    db "<NEXT>abducted?<PROMPT>"
    db "<NEXT>…That AgDevil, it's"
    db "<NEXT>from the mountains<PROMPT>"
    db "<NEXT>in the north, I"
    db "<NEXT>think.<PROMPT>"
    db "<NEXT>Go east, then turn"
    db "<NEXT>north up into the<PROMPT>"
    db "<NEXT>mountains. It's"
    db "<NEXT>around there.<WAIT>"
    db "@"

Message_06_32::
    db "<VOICE1>*: That AgDevil is"
    db "<NEXT>from the mountains<PROMPT>"
    db "<NEXT>in the north, I"
    db "<NEXT>think.<PROMPT>"
    db "<NEXT>Go east, then turn"
    db "<NEXT>north up into the<PROMPT>"
    db "<NEXT>mountains. It's"
    db "<NEXT>around there.<WAIT>"
    db "@"

Message_06_33::
    db "<VOICE2>*: You're not going<LINE>"
    db "to the northern<PROMPT>"
    db "<NEXT>mountains where"
    db "<NEXT>the monsters live?<PROMPT>"
    db "<NEXT>Don't do it!"
    db "<NEXT>They have no pity,<PROMPT>"
    db "<NEXT>not even for small"
    db "<NEXT>children!<WAIT>"
    db "@"

Message_06_34::
    db "<VOICE1>Rolt: I've found<LINE>"
    db "you at last!<PROMPT>"
    db "<NEXT>Everything you've"
    db "<NEXT>taken from us, I'm<PROMPT>"
    db "<NEXT>going to take back"
    db "<NEXT>from you now!<WAIT>"
    db "@"

Message_06_35::
    db "<VOICE1>*: Kikiki, what<LINE>"
    db "just you?<PROMPT>"
    db "<NEXT>That's utterly"
    db "<NEXT>laughable!<WAIT>"
    db "@"

Message_06_36::
    db "<VOICE1>Rolt: Shut up!<LINE>"
    db "Give back Cyal!<WAIT>"
    db "@"

Message_06_37::
    db "<VOICE1>*: Humph…<LINE>"
    db "How boring…<WAIT>"
    db "@"

Message_06_38::
    db "<VOICE1>Rolt: Urrrgh…<LINE>"
    db "<BUF0>… Please…<PROMPT>"
    db "<NEXT>Please save Cyal!"
    db "<NEXT><WAIT>"
    db "@"

Message_06_39::
    db "<VOICE1>*: The human in the<LINE>"
    db "forest again?<PROMPT>"
    db "<NEXT>You think you can"
    db "<NEXT>defy me?<PROMPT>"
    db "<NEXT>Such a rude child!"
    db "<NEXT>I'll crush you!<WAIT>"
    db "@"

Message_06_3A::
    db "<VOICE1>*: What, you again?<LINE>"
    db "Rude, rude, rude!<WAIT>"
    db "@"

Message_06_3B::
    db "<VOICE1>*: Wh-what? I…<LINE>"
    db "Lost to a child?<WAIT>"
    db "@"

Message_06_3C::
    db "<VOICE1>Rolt: Wow… <BUF0>,<LINE>"
    db "you're tough.<PROMPT>"
    db "<NEXT>Oh! Cyal!"
    db "<NEXT>Where's Cyal?<WAIT>"
    db "@"

Message_06_3D::
    db "<VOICE1>Rolt: Cyal! Are<LINE>"
    db "you OK? Cyal!<WAIT>"
    db "@"

Message_06_3E::
    db "<VOICE2>Cyal: Big brother!<LINE>"
    db "I was so scared!<WAIT>"
    db "@"

Message_06_3F::
    db "<VOICE1>Rolt: You're safe<LINE>"
    db "now. <BUF0> did it.<WAIT>"
    db "@"

Message_06_40::
    db "<VOICE1>Rolt: <BUF0>, I'm<LINE>"
    db "sorry we put you<PROMPT>"
    db "<NEXT>through so much"
    db "<NEXT>trouble.<PROMPT>"
    db "<NEXT>It was my fault"
    db "<NEXT>for putting you<PROMPT>"
    db "<NEXT>into danger."
    db "<NEXT>I'm sorry.<PROMPT>"
    db "<NEXT>I have to thank"
    db "<NEXT>you somehow.<PROMPT>"
    db "<NEXT>But, let's go back"
    db "<NEXT>to the village.<WAIT>"
    db "@"

Message_06_41::
    db "<VOICE1>*: I'm glad that<LINE>"
    db "Cyal and Rolt are<PROMPT>"
    db "<NEXT>safe. <BUF0>, we"
    db "<NEXT>owe it all to you.<WAIT>"
    db "@"

Message_06_42::
    db "<VOICE2>Cyal: <BUF0>, thank<LINE>"
    db "you…<WAIT>"
    db "@"

Message_06_43::
    db "<VOICE1>Rolt: Cyal must be<LINE>"
    db "a bit overwhelmed.<PROMPT>"
    db "<NEXT>She's happy you"
    db "<NEXT>saved her, <BUF0>.<WAIT>"
    db "@"

Message_06_44::
    db "<VOICE1>*: Our gratitude is<LINE>"
    db "as plentiful as<PROMPT>"
    db "<NEXT>there are stars in"
    db "<NEXT>the sky!<WAIT>"
    db "@"

Message_06_45::
    db "<VOICE1>Rolt: I'm going to<LINE>"
    db "get strong like<PROMPT>"
    db "<NEXT><BUF0>, and I'll"
    db "<NEXT>protect Cyal!<WAIT>"
    db "@"

Message_06_47::
    db "<VOICE2>Cyal: I hope you'll<LINE>"
    db "stay my friend.<PROMPT>"
    db "<NEXT>Please come visit"
    db "<NEXT>again.<WAIT>"
    db "@"

Message_06_48::
    db "<VOICE2>Cyal: I ought to<LINE>"
    db "become a master<PROMPT>"
    db "<NEXT>like you, <BUF0>."
    db "<NEXT>It's so dashing!<WAIT>"
    db "@"

Message_06_49::
    db "<VOICE1>*: We owe you a big<LINE>"
    db "thanks.<PROMPT>"
    db "<NEXT>I couldn't do a"
    db "<NEXT>thing…<PROMPT>"
    db "<NEXT>I have to become"
    db "<NEXT>much stronger.<PROMPT>"
    db "<NEXT>I can't embarrass"
    db "<NEXT>myself as a guard<PROMPT>"
    db "<NEXT>of the forest,"
    db "<NEXT>after all.<WAIT>"
    db "@"

Message_06_4A::
    db "<VOICE2>*: Thanks to you,<LINE>"
    db "we can live in<PROMPT>"
    db "<NEXT>peace, free of"
    db "<NEXT>fear. Thank you!<WAIT>"
    db "@"

Message_06_4B::
    db "<VOICE1>*: You look kind<LINE>"
    db "and caring.<PROMPT>"
    db "<NEXT>I'm sorry I said I"
    db "<NEXT>was scared of you.<WAIT>"
    db "@"

Message_06_4C::
    db "<VOICE1>*: Brave human,<LINE>"
    db "hear this.<PROMPT>"
    db "<NEXT>The King of Plants"
    db "<NEXT>rises from a rose<PROMPT>"
    db "<NEXT>and a giant."
    db "<NEXT>Do you understand?<WAIT>"
    db "@"

Message_06_4D::
    db "<VOICE2>*: The talking<LINE>"
    db "horse came from<PROMPT>"
    db "<NEXT>somewhere outside"
    db "<NEXT>this world.<PROMPT>"
    db "<NEXT>It's a mystery"
    db "<NEXT>that's beyond me.<WAIT>"
    db "@"

Message_06_4E::
    db "<VOICE1>*: You put down<LINE>"
    db "that fiend?<PROMPT>"
    db "<NEXT>You're tough!"
    db "<NEXT>Unlike your looks.<WAIT>"
    db "@"

Message_06_4F::
    db "<VOICE2>*: You… You're a<LINE>"
    db "savage but I must<PROMPT>"
    db "<NEXT>thank you as a"
    db "<NEXT>courtesy.<WAIT>"
    db "@"

Message_06_50::
    db "<VOICE1>*: This is Elven's<LINE>"
    db "lookout post.<PROMPT>"
    db "<NEXT>We stand guard"
    db "<NEXT>against monsters.<PROMPT>"
    db "<NEXT>But ever since you"
    db "<NEXT>defeated AgDevil,<PROMPT>"
    db "<NEXT>it's been quiet."
    db "<NEXT>Thank you, really!<WAIT>"
    db "@"

Message_06_51::
    db "<VOICE2>*: Beating AgDevil…<LINE>"
    db "That's incredible!<PROMPT>"
    db "<NEXT>But now that it's"
    db "<NEXT>become quiet, some<PROMPT>"
    db "<NEXT>lookouts have been"
    db "<NEXT>slacking off…<WAIT>"
    db "@"

Message_06_52::
    db "<VOICE2>*: I've heard that<LINE>"
    db "humans are wild<PROMPT>"
    db "<NEXT>savages. Don't get"
    db "<NEXT>too close to me!<WAIT>"
    db "@"

Message_06_53::
    db "<VOICE1>I'm the Village<LINE>"
    db "Elder.<PROMPT>"
    db "<NEXT>By the way, have"
    db "<NEXT>you seen two young<PROMPT>"
    db "<NEXT>elves? They are"
    db "<NEXT>brother and<PROMPT>"
    db "<NEXT>sister. They have"
    db "<NEXT>yet to return<PROMPT>"
    db "<NEXT>from the forest in"
    db "<NEXT>the north.<WAIT>"
    db "@"

Message_06_54::
    db "<VOICE1>*: …Too strong…<LINE>"
    db "Arroooh!<WAIT>"
    db "@"

Message_06_55::
    db "<VOICE1>*: Not only their<LINE>"
    db "parents, but Cyal<PROMPT>"
    db "<NEXT>was taken too?"
    db "<NEXT>Poor Rolt…<PROMPT>"
    db "<NEXT>You're Cyal's"
    db "<NEXT>friend, aren't you?<PROMPT>"
    db "<NEXT>Can't you help her?"
    db "<NEXT><WAIT>"
    db "@"

Message_06_56::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>Herbs for sale.<WAIT>"
    db "@"

Message_06_57::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>A sharp aroma of"
    db "<NEXT>medicine wafted…<WAIT>"
    db "@"

Message_06_58::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>Stew simmered and"
    db "<NEXT>bubbled in a pot.<WAIT>"
    db "@"

Message_06_59::
    db "<VOICE1>*: Hoh? Ah, excuse<LINE>"
    db "my incivility.<PROMPT>"
    db "<NEXT>It's not often we"
    db "<NEXT>get visitors here.<PROMPT>"
    db "<NEXT>Hm, what manner of"
    db "<NEXT>person are you?<PROMPT>"
    db "<NEXT>Having monsters as"
    db "<NEXT>your chaperones.<PROMPT>"
    db "<NEXT>Ah, you are what,"
    db "<NEXT>a monster master?<PROMPT>"
    db "<NEXT>Ah, I am Professor"
    db "<NEXT>Kiral, by the way.<PROMPT>"
    db "<NEXT>Kiral: I conduct"
    db "<NEXT>research here.<PROMPT>"
    db "<NEXT>I am in need of an"
    db "<NEXT>assistant now…<PROMPT>"
    db "<NEXT>How would you like"
    db "<NEXT>to work for me?<PROMPT>"
    db "<NEXT>Not for free, of"
    db "<NEXT>course. Well?<CHOICE>"
    db "@"

Message_06_5A::
    db "<VOICE1>*: Pii… Ggzz…<LINE>"
    db "Piiiiii…<WAIT>"
    db "@"

Message_06_5B::
    db "<VOICE1>Kiral: Hohoh!<LINE>"
    db "Grand, grand!<PROMPT>"
    db "<NEXT>Go fetch the"
    db "<NEXT>treasure I've<PROMPT>"
    db "<NEXT>stored. It's"
    db "<NEXT>inside a barrel in<PROMPT>"
    db "<NEXT>the basement room."
    db "<NEXT>Monsters have<PROMPT>"
    db "<NEXT>infested the lower"
    db "<NEXT>levels, hence it<PROMPT>"
    db "<NEXT>is impossible for"
    db "<NEXT>me to set foot<PROMPT>"
    db "<NEXT>down there.<WAIT>"
    db "@"

Message_06_5C::
    db "<VOICE1>Kiral: Oh! Foolish<LINE>"
    db "of me, I almost<PROMPT>"
    db "<NEXT>forgot to mention"
    db "<NEXT>that there is a<PROMPT>"
    db "<NEXT>guard in the room"
    db "<NEXT>of barrels.<PROMPT>"
    db "<NEXT>It may appear"
    db "<NEXT>intimidating,<PROMPT>"
    db "<NEXT>but when it sees"
    db "<NEXT>that you are in my<PROMPT>"
    db "<NEXT>employ, it should"
    db "<NEXT>become compliant.<PROMPT>"
    db "<NEXT>I'm counting on"
    db "<NEXT>you. Hohoh!<WAIT>"
    db "@"

Message_06_5D::
    db "<VOICE1>Kiral: No? <LINE>"
    db "How disappointing.<PROMPT>"
    db "<NEXT>Your efforts would"
    db "<NEXT>be rewarded.<WAIT>"
    db "@"

Message_06_5E::
    db "<VOICE1>Kiral: I need help<LINE>"
    db "with my studies.<PROMPT>"
    db "<NEXT>Will you help me?"
    db "<NEXT><CHOICE>"
    db "@"

Message_06_5F::
    db "<VOICE1>Kiral: Fetch me my<LINE>"
    db "treasure from the<PROMPT>"
    db "<NEXT>barrel room in the"
    db "<NEXT>basement.<PROMPT>"
    db "<NEXT>There is a guard"
    db "<NEXT>there, but it will<PROMPT>"
    db "<NEXT>become docile once"
    db "<NEXT>it realizes you<PROMPT>"
    db "<NEXT>are working on my"
    db "<NEXT>behalf.<WAIT>"
    db "@"

Message_06_60::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>A recent diary was"
    db "<NEXT>found.<PROMPT>"
    db "<NEXT>'Monsters appeared"
    db "<NEXT>in the basement.<PROMPT>"
    db "<NEXT>The cause remains"
    db "<NEXT>unknown.<PROMPT>"
    db "<NEXT>The lower levels"
    db "<NEXT>can't be entered.", $95, "<WAIT>"
    db "@"

Message_06_61::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>A very old diary"
    db "<NEXT>was found.<PROMPT>"
    db "<NEXT>'The treasure must"
    db "<NEXT>be protected.<PROMPT>"
    db "<NEXT>Rob-N will be"
    db "<NEXT>ideal.<PROMPT>"
    db "<NEXT>He can be trusted"
    db "<NEXT>with the job.", $95, "<WAIT>"
    db "@"

Message_06_62::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>Rolled blueprints"
    db "<NEXT>were in a bundle.<WAIT>"
    db "@"

Message_06_63::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It faintly smelled"
    db "<NEXT>of mold…<WAIT>"
    db "@"

Message_06_64::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There were things"
    db "<NEXT>squirming inside.<WAIT>"
    db "@"

Message_06_65::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There was a note"
    db "<NEXT>at the bottom.<PROMPT>"
    db "<NEXT>'The blue stone"
    db "<NEXT>gives life.", $95, "<WAIT>"
    db "@"

Message_06_66::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>A quite old diary"
    db "<NEXT>was found.<PROMPT>"
    db "<NEXT>'A Roboster with"
    db "<NEXT>outstanding specs<PROMPT>"
    db "<NEXT>was born. I gave"
    db "<NEXT>it the name Rob-N.<PROMPT>"
    db "<NEXT>It is loyal, and"
    db "<NEXT>obeys me without<PROMPT>"
    db "<NEXT>question or a hint"
    db "<NEXT>of complaint.<PROMPT>"
    db "<NEXT>In fact it is too"
    db "<NEXT>loyal…", $95, "<WAIT>"
    db "@"

Message_06_67::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>A monster had been"
    db "<NEXT>lurking inside.<PROMPT>"
    db "<NEXT>The monster reared"
    db "<NEXT>up and lunged!<WAIT>"
    db "@"

Message_06_68::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There was nothing"
    db "<NEXT>inside.<WAIT>"
    db "@"

Message_06_69::
    db "<VOICE1>*: PROFESSOR… SAY<LINE>"
    db "GUARD… TREASURE…<PROMPT>"
    db "<NEXT>NEVER… SURRENDER"
    db "<NEXT>IT… NEGATIVE…<WAIT>"
    db "@"

Message_06_6A::
    db "Roboster is acting<LINE>"
    db "strangely.<PROMPT>"
    db "<NEXT>It appears to be"
    db "<NEXT>damaged somewhere.<WAIT>"
    db "@"

Message_06_6B::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There was a blue"
    db "<NEXT>shining stone.<PROMPT>"
    db "<NEXT><BUF0> reached for"
    db "<NEXT>the stone.<PROMPT>"
    db "<NEXT>Roboster sprang"
    db "<NEXT>into action!<WAIT>"
    db "@"

Message_06_6C::
    db "<VOICE1>*: PROFESSOR… SAY<LINE>"
    db "GUARD TREASURE…<WAIT>"
    db "@"

Message_06_6D::
    db "<VOICE1>*: PRO… SOR… AY…<LINE>"
    db "GGGGUARD… TREZZZT…<WAIT>"
    db "@"

Message_06_6E::
    db "Its damage appears<LINE>"
    db "to have worsened.<WAIT>"
    db "@"

Message_06_6F::
    db "<VOICE1>*: PRO… SOR… AY…<LINE>"
    db "GGGGUARD… TREZZZT…<WAIT>"
    db "@"

Message_06_70::
    db "<VOICE1>*: PIPIPI…<LINE>"
    db "GGGGGGAGAGAGA…<WAIT>"
    db "@"

Message_06_71::
    db "Roboster is acting<LINE>"
    db "bizarrely.<PROMPT>"
    db "<NEXT>It appears to be"
    db "<NEXT>seriously damaged.<WAIT>"
    db "@"

Message_06_72::
    db "<VOICE1>*: PIPIPI…<LINE>"
    db "GGGGGGAGAGAGA…<WAIT>"
    db "@"

Message_06_73::
    db "<VOICE1>*: PI… PI…<WAIT>"
    db "@"

Message_06_74::
    db "Roboster is acting<LINE>"
    db "as if demented.<PROMPT>"
    db "<NEXT>It appears to be"
    db "<NEXT>totally haywire.<WAIT>"
    db "@"

Message_06_75::
    db "<VOICE1>*: PI… PI…<WAIT>"
    db "@"

Message_06_76::
    db "<VOICE1>Kiral: Ah! Back!<LINE>"
    db "The treasure?<PROMPT>"
    db "<NEXT>What? A Roboster?"
    db "<NEXT>Gone haywire? Ah…<PROMPT>"
    db "<NEXT>He… He's broken but"
    db "<NEXT>he guarded the<PROMPT>"
    db "<NEXT>treasure all this"
    db "<NEXT>time…<PROMPT>"
    db "<NEXT>The monsters down"
    db "<NEXT>there, he probably<PROMPT>"
    db "<NEXT>summoned to keep"
    db "<NEXT>intruders away…<PROMPT>"
    db "<NEXT>All for following"
    db "<NEXT>my orders…<WAIT>"
    db "@"

Message_06_77::
    db "<VOICE1>Kiral: Please…<LINE>"
    db "Go stop him.<PROMPT>"
    db "<NEXT>He will never know"
    db "<NEXT>rest, otherwise.<PROMPT>"
    db "<NEXT>You can get the"
    db "<NEXT>treasure later.<WAIT>"
    db "@"

Message_06_78::
    db "<VOICE1>Kiral: Please…<LINE>"
    db "Go stop him.<PROMPT>"
    db "<NEXT>You can get the"
    db "<NEXT>treasure later.<WAIT>"
    db "@"

Message_06_79::
    db "<VOICE1>*: PROFE… SOR…<LINE>"
    db "ORDER… MUST… OBEY…<WAIT>"
    db "@"

Message_06_7A::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There was a blue"
    db "<NEXT>shining stone.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>WizStone.<WAIT>"
    db "@"

Message_06_7B::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There was a blue"
    db "<NEXT>shining stone.<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it…<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>stone back.<WAIT>"
    db "@"

Message_06_7C::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There was nothing"
    db "<NEXT>inside.<WAIT>"
    db "@"

Message_06_7D::
    db "<VOICE1>Kiral: Ah! Back!<LINE>"
    db "Is… Rob-N…<PROMPT>"
    db "<NEXT>Did you stop him?"
    db "<NEXT>…You did…<PROMPT>"
    db "<NEXT>He served as a"
    db "<NEXT>guard so well…<PROMPT>"
    db "<NEXT>I'll fix him soon."
    db "<NEXT>And the treasure?<WAIT>"
    db "@"

Message_06_7E::
    db "<BUF0> handed over<LINE>"
    db "the blue stone.<WAIT>"
    db "@"

Message_06_7F::
    db "<VOICE1>Kiral: This stone,<LINE>"
    db "the WizStone, it<PROMPT>"
    db "<NEXT>is Roboster's fuel."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>The new type will"
    db "<NEXT>become functional!<WAIT>"
    db "@"

Message_06_80::
    db "Professor Kiral<LINE>"
    db "used the WizStone<PROMPT>"
    db "<NEXT>on a new robot."
    db "<NEXT>It began to move!<WAIT>"
    db "@"

Message_06_81::
    db "<VOICE1>Kiral: Yes! Yes!<LINE>"
    db "Success!<PROMPT>"
    db "<NEXT>I owe this success"
    db "<NEXT>to you!<PROMPT>"
    db "<NEXT>Take this. It's my"
    db "<NEXT>thanks to you.<WAIT>"
    db "@"

Message_06_82::
    db "<BUF0> received the<LINE>"
    db "SmartBook.<WAIT>"
    db "@"

Message_06_83::
    db "<VOICE1>Kiral: You've been<LINE>"
    db "a great help.<PROMPT>"
    db "<NEXT>I'll study how the"
    db "<NEXT>new type breeds.<PROMPT>"
    db "<NEXT>I'll tell you if I"
    db "<NEXT>discover how.<PROMPT>"
    db "<NEXT>Visit me when you"
    db "<NEXT>have the time.<WAIT>"
    db "@"

Message_06_87::
    db "<VOICE1>Kiral: Visit me<LINE>"
    db "when you're free.<WAIT>"
    db "@"

Message_06_88::
    db "<VOICE1>*: I AM THE LATEST<LINE>"
    db "ROBOSTER.<PROMPT>"
    db "<NEXT>ROBOSTER2 IS MY"
    db "<NEXT>OFFICIAL NAME.<PROMPT>"
    db "<NEXT>BUT THE PROFESSOR"
    db "<NEXT>WILL GIVE ME A NEW<PROMPT>"
    db "<NEXT>NAME. IT FILLS ME"
    db "<NEXT>WITH ANTICIPATION.<WAIT>"
    db "@"

Message_06_89::
    db "<VOICE1>Kiral: Hohoh! I've<LINE>"
    db "got good news!<PROMPT>"
    db "<NEXT>Breed two Roboster"
    db "<NEXT>units, and you may<PROMPT>"
    db "<NEXT>end up with a"
    db "<NEXT>Roboster2.<PROMPT>"
    db "<NEXT>However, the two"
    db "<NEXT>Robosters have to<PROMPT>"
    db "<NEXT>be modified to a"
    db "<NEXT>certain degree.<PROMPT>"
    db "<NEXT>Otherwise, the"
    db "<NEXT>breeding process<PROMPT>"
    db "<NEXT>ends prematurely"
    db "<NEXT>with no recourse.<WAIT>"
    db "@"

Message_06_8A::
    db "<VOICE1>Kiral: Roboster2's<LINE>"
    db "skills are simply<PROMPT>"
    db "<NEXT>exceptional."
    db "<NEXT>It can learn the<PROMPT>"
    db "<NEXT>ultimate sword"
    db "<NEXT>attack.<PROMPT>"
    db "<NEXT>It was called…"
    db "<NEXT>Giga-something.<WAIT>"
    db "@"

Message_06_8B::
    db "<VOICE1>*: MY NAME IS LEO.<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>THE PROFESSOR GAVE"
    db "<NEXT>ME THAT NAME.<PROMPT>"
    db "<NEXT>IT SOUNDS STRONG."
    db "<NEXT>I LIKE IT.<WAIT>"
    db "@"

Message_06_8C::
    db "<VOICE1>*: WELCOME.<LINE>"
    db "I AM ROB-N.<PROMPT>"
    db "<NEXT>I SERVE AS THE"
    db "<NEXT>PROFESSOR'S AIDE.<WAIT>"
    db "@"

Message_06_8D::
    db "…Roboster stopped<LINE>"
    db "moving…<WAIT>"
    db "@"

Message_06_8E::
    db "Roboster stopped<LINE>"
    db "moving entirely…<WAIT>"
    db "@"

Message_06_8F::
    db "<VOICE1>*: This is the town<LINE>"
    db "of Miagen.<PROMPT>"
    db "<NEXT>It's quite an"
    db "<NEXT>affluent place.<PROMPT>"
    db "<NEXT>But it's been a bit"
    db "<NEXT>rough these days…<WAIT>"
    db "@"

Message_06_90::
    db "<VOICE2>*: Are you friends<LINE>"
    db "with monsters?<PROMPT>"
    db "<NEXT>You're just like"
    db "<NEXT>this girl Milayou.<PROMPT>"
    db "<NEXT>Do you know who"
    db "<NEXT>she is?<WAIT>"
    db "@"

Message_06_91::
    db "<VOICE1>*: Wow! You have<LINE>"
    db "monsters! Neat!<PROMPT>"
    db "<NEXT>Are they strong?"
    db "<NEXT>Can they beat up<PROMPT>"
    db "<NEXT>bad people and"
    db "<NEXT>monsters?<WAIT>"
    db "@"

Message_06_92::
    db "<VOICE2>*: Are your<LINE>"
    db "monsters good?<PROMPT>"
    db "<NEXT>I don't like bad"
    db "<NEXT>monsters!<WAIT>"
    db "@"

Message_06_93::
    db "<VOICE1>*: Monsters can be<LINE>"
    db "good or bad.<PROMPT>"
    db "<NEXT>Your monsters"
    db "<NEXT>appear to be good.<PROMPT>"
    db "<NEXT>That's really"
    db "<NEXT>reassuring!<WAIT>"
    db "@"

Message_06_94::
    db "<VOICE2>*: You appear to<LINE>"
    db "have the power to<PROMPT>"
    db "<NEXT>control monsters."
    db "<NEXT>You're just like<PROMPT>"
    db "<NEXT>Milayou who's over"
    db "<NEXT>at the inn.<PROMPT>"
    db "<NEXT>You two are"
    db "<NEXT>something else.<PROMPT>"
    db "<NEXT>Maybe I should"
    db "<NEXT>copy what you do.<WAIT>"
    db "@"

Message_06_95::
    db "<VOICE1>*: Sigh…<WAIT>"
    db "@"

Message_06_96::
    db "The old man's sigh<LINE>"
    db "sounded sad…<WAIT>"
    db "@"

Message_06_97::
    db "<VOICE2>*: Sigh…<WAIT>"
    db "@"

Message_06_98::
    db "The old woman's<LINE>"
    db "sigh was desolate…<WAIT>"
    db "@"

Message_06_99::
    db "<VOICE1>*: Monsters raided<LINE>"
    db "this house within<PROMPT>"
    db "<NEXT>the last while."
    db "<NEXT>They apparently<PROMPT>"
    db "<NEXT>stole something of"
    db "<NEXT>great importance.<WAIT>"
    db "@"

Message_06_9A::
    db "<VOICE2>*: The old people<LINE>"
    db "across the way<PROMPT>"
    db "<NEXT>look very sad"
    db "<NEXT>recently.<WAIT>"
    db "@"

Message_06_9B::
    db "<VOICE1>*: Monsters have<LINE>"
    db "taken to attacking<PROMPT>"
    db "<NEXT>the town recently."
    db "<NEXT>But rather than<PROMPT>"
    db "<NEXT>people, they go"
    db "<NEXT>after treasures.<WAIT>"
    db "@"

Message_06_9C::
    db "<VOICE2>*: Grrrr!<LINE>"
    db "I'm so angry!<PROMPT>"
    db "<NEXT>Monsters stole my"
    db "<NEXT>lingerie!<PROMPT>"
    db "<NEXT>I've never seen"
    db "<NEXT>such sauciness!<WAIT>"
    db "@"

Message_06_9D::
    db "<VOICE1>*: Hello! What may<LINE>"
    db "I do for you?<WAIT>"
    db "@"

Message_06_9E::
    db "<VOICE1>*: Welcome to our<LINE>"
    db "traveler's inn.<WAIT>"
    db "@"

Message_06_9F::
    db "<VOICE1>*: If you travel<LINE>"
    db "west along the<PROMPT>"
    db "<NEXT>plains, there is"
    db "<NEXT>a hut.<PROMPT>"
    db "<NEXT>It should be by a"
    db "<NEXT>small spring.<PROMPT>"
    db "<NEXT>The hut is for"
    db "<NEXT>travelers and<PROMPT>"
    db "<NEXT>merchants to rest"
    db "<NEXT>while on the road.<WAIT>"
    db "@"

Message_06_A0::
    db "<VOICE2>*: Excuse me, are<LINE>"
    db "you a master?<PROMPT>"
    db "<NEXT>The town has been"
    db "<NEXT>having a terrible<PROMPT>"
    db "<NEXT>time with monsters"
    db "<NEXT>attacking and<PROMPT>"
    db "<NEXT>stealing treasures"
    db "<NEXT>from homes.<PROMPT>"
    db "<NEXT>I want to help the"
    db "<NEXT>people here.<PROMPT>"
    db "<NEXT>Could I ask for"
    db "<NEXT>your help too?<PROMPT>"
    db "<NEXT>I", $44, " like you to"
    db "<NEXT>battle and punish<PROMPT>"
    db "<NEXT>the bad monsters."
    db "<NEXT>Well? Could you?<CHOICE>"
    db "@"

Message_06_A1::
    db "<VOICE2>*: Thank you! I<LINE>"
    db "knew you", $44, " agree!<PROMPT>"
    db "<NEXT>My name's Milayou."
    db "<NEXT>I'm a master too.<PROMPT>"
    db "<NEXT>Milayou: First,"
    db "<NEXT>you should speak<PROMPT>"
    db "<NEXT>with the victims"
    db "<NEXT>and see how you<PROMPT>"
    db "<NEXT>could help them"
    db "<NEXT>over the crisis.<PROMPT>"
    db "<NEXT>I'll investigate"
    db "<NEXT>where the monsters<PROMPT>"
    db "<NEXT>are coming from."
    db "<NEXT>Let's meet up<PROMPT>"
    db "<NEXT>again later on"
    db "<NEXT>back here.<WAIT>"
    db "@"

Message_06_A2::
    db "<VOICE2>*: I can't count on<LINE>"
    db "your support?<PROMPT>"
    db "<NEXT>That's really too"
    db "<NEXT>bad…<WAIT>"
    db "@"

Message_06_A3::
    db "<VOICE2>*: Have you changed<LINE>"
    db "your mind?<PROMPT>"
    db "<NEXT>You will help the"
    db "<NEXT>people in town?<CHOICE>"
    db "@"

Message_06_A4::
    db "<VOICE1>*: Could you humor<LINE>"
    db "this old man and<PROMPT>"
    db "<NEXT>hear his tale of"
    db "<NEXT>woe?<PROMPT>"
    db "<NEXT>My daughter wedded"
    db "<NEXT>a man from far<PROMPT>"
    db "<NEXT>away and left"
    db "<NEXT>with him.<PROMPT>"
    db "<NEXT>A ring was the"
    db "<NEXT>only memento I had<PROMPT>"
    db "<NEXT>of hers. Monsters"
    db "<NEXT>stole it from me…<WAIT>"
    db "@"

Message_06_A5::
    db "<VOICE1>*: My daughter<LINE>"
    db "wedded a man from<PROMPT>"
    db "<NEXT>far away and left"
    db "<NEXT>with him.<PROMPT>"
    db "<NEXT>A ring was the"
    db "<NEXT>only memento I had<PROMPT>"
    db "<NEXT>of hers. Monsters"
    db "<NEXT>stole it from us…<WAIT>"
    db "@"
    ds $cf, $00
