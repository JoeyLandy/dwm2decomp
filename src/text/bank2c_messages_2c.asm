; ROM bank $2C: messages
; The annotated listing of this bank is build/listing/bank2c.asm.

SECTION "Bank 2C", ROMX
    db $2c

; Starts a message of message group 4 (strings of category 0 of bank $2C, picked by wStringIndex).
; When wStringIndex is below $91 it calls BeginStringDisplay with DE = MessageStrings_Bank2C; from
; $91 on it far-calls BeginStringDisplay_Bank2C_Overflow in bank $98, which subtracts $91 from
; wStringIndex and uses the overflow table. BeginStringDisplay blanks the text window, points the
; text printer at the string and sets wTextFlags to 1; the text appears on the following frames.
; Reached by farcall from the message group dispatch (ShowMessageHL in bank $5F,
; StartMessageForGroup_Group04 in bank $10) and from the debug menu in bank $01. (C1, E-0378)
; message bank $2C: when wStringIndex < $91, BeginStringDisplay with this bank's table
; MessageStrings_Bank2C; otherwise far-calls BeginStringDisplay_Bank2C_Overflow (E-0080)
BeginStringDisplay_Bank2C:: ; configured code entry (E-0395 (BeginStringDisplay_Bank2C: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld a, [wStringIndex]
    cp $91
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2C_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2C
    call BeginStringDisplay
    ret

SECTION "Bank 2C CopyStringToBuffer_Bank2C", ROMX

; Copies a message of message group 4 to a buffer instead of printing it: string wStringIndex of
; category wStringCategory is copied, with its $F0 terminator, to the address in
; wStringDestLo/wStringDestHi. When wStringIndex is below $91 it uses MessageStrings_Bank2C through
; CopyStringToBuffer; from $91 on it far-calls CopyStringToBuffer_Bank2C_Overflow in bank $98, which
; subtracts $91 from wStringIndex first (so wStringIndex is changed). Nothing in src/ calls this
; copy by name. (C2, E-0378)
; message bank $2C: when wStringIndex < $91, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2C; otherwise far-calls CopyStringToBuffer_Bank2C_Overflow (E-0080)
CopyStringToBuffer_Bank2C:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wStringIndex]
    cp $91
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2C_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2C
    call CopyStringToBuffer
    ret

SECTION "Bank 2C ShowStringAtOnce_Bank2C", ROMX

; Calls BeginStringDisplay_Bank2C, which starts string wStringIndex of its table, then
; RunStringDisplayToEnd, which prints the whole string at once (wTextFlags bit 1) instead of a glyph
; per frame. No traced code, jump table or pointer reaches it (E-0395: it decodes as a routine but
; is unreached in the static listing). (C1, E-0395)
ShowStringAtOnce_Bank2C:: ; configured code entry (E-0395); C0
    call BeginStringDisplay_Bank2C
    call RunStringDisplayToEnd
    ret

SECTION "Bank 2C MessageStrings_Bank2C", ROMX

; One little-endian word, a pointer to StringList_Bank2C_0, the list of 145 message pointers
; Message_04_00 to Message_04_90 (message group 4, bank $2C). LookupString reads word
; wStringCategory of it (category 0 is the only word), then word wStringIndex of that list.
; BeginStringDisplay_Bank2C and CopyStringToBuffer_Bank2C pass it in DE for wStringIndex below $91;
; higher ids go to their Overflow routine. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
MessageStrings_Bank2C::
    dw StringList_Bank2C_0 ; id 0

; category list of MessageStrings_Bank2C; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2C_0::
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
    db "<VOICE1>*: This is the<LINE>"
    db "village of Fhunt.<PROMPT>"
    db "<NEXT>We have guarded"
    db "<NEXT>the grave of Ugor,<PROMPT>"
    db "<NEXT>the Great Sage,"
    db "<NEXT>for generations.<WAIT>"
    db "@"

Message_04_01::
    db "<VOICE1>*: The Great Sage<LINE>"
    db "Ugor saved the<PROMPT>"
    db "<NEXT>world with the"
    db "<NEXT>LightOrb.<PROMPT>"
    db "<NEXT>The LightOrb must"
    db "<NEXT>have been very<PROMPT>"
    db "<NEXT>powerful to do"
    db "<NEXT>that.<WAIT>"
    db "@"

Message_04_02::
    db "<VOICE1>*: You've come all<LINE>"
    db "this way, take the<PROMPT>"
    db "<NEXT>time to pay your"
    db "<NEXT>respect to Ugor.<PROMPT>"
    db "<NEXT>His grave?"
    db "<NEXT>You can't miss it!<WAIT>"
    db "@"

Message_04_03::
    db "<VOICE1>*: The Great Sage,<LINE>"
    db "after saving the<PROMPT>"
    db "<NEXT>world, sealed the"
    db "<NEXT>LightOrb away.<PROMPT>"
    db "<NEXT>It is sealed high"
    db "<NEXT>in the tower.<PROMPT>"
    db "<NEXT>He feared that its"
    db "<NEXT>power would be<PROMPT>"
    db "<NEXT>misused by those"
    db "<NEXT>impure of thought<PROMPT>"
    db "<NEXT>to become the king"
    db "<NEXT>of monsters.<PROMPT>"
    db "<NEXT>So, the LightOrb"
    db "<NEXT>could be dangerous<PROMPT>"
    db "<NEXT>if it falls into"
    db "<NEXT>the wrong hands.<WAIT>"
    db "@"

Message_04_04::
    db "<VOICE1>*: You're not about<LINE>"
    db "to go after the<PROMPT>"
    db "<NEXT>LightOrb so you"
    db "<NEXT>can be the king?<PROMPT>"
    db "<NEXT>I suggest you lose"
    db "<NEXT>that thought now.<WAIT>"
    db "@"

Message_04_05::
    db "<VOICE1>*: Some time ago,<LINE>"
    db "lightning struck<PROMPT>"
    db "<NEXT>the tower, causing"
    db "<NEXT>it to buckle.<PROMPT>"
    db "<NEXT>Did someone do it"
    db "<NEXT>deliberately?<PROMPT>"
    db "<NEXT>No, that can't be"
    db "<NEXT>right…<PROMPT>"
    db "<NEXT>The Orb is guarded"
    db "<NEXT>by the Great Sage…<WAIT>"
    db "@"

Message_04_06::
    db "<VOICE1>*: Nobody can defy<LINE>"
    db "the Orb's bearer.<PROMPT>"
    db "<NEXT>It has absolute"
    db "<NEXT>power over the<PROMPT>"
    db "<NEXT>will of monsters,"
    db "<NEXT>they say.<WAIT>"
    db "@"

Message_04_07::
    db "<VOICE1>*: A suspension<LINE>"
    db "bridge is in the<PROMPT>"
    db "<NEXT>south, but it's"
    db "<NEXT>under guard.<PROMPT>"
    db "<NEXT>Nobody suspicious"
    db "<NEXT>is allowed across.<PROMPT>"
    db "<NEXT>A human will never"
    db "<NEXT>be permitted.<WAIT>"
    db "@"

Message_04_08::
    db "<VOICE1>*: A huge bird<LINE>"
    db "perches atop the<PROMPT>"
    db "<NEXT>tower every so"
    db "<NEXT>often.<PROMPT>"
    db "<NEXT>I tell you, it's"
    db "<NEXT>creepy.<WAIT>"
    db "@"

Message_04_09::
    db "<VOICE1>*: The tower's gate<LINE>"
    db "is tightly sealed.<PROMPT>"
    db "<NEXT>Anyone with any"
    db "<NEXT>trace of wildness<PROMPT>"
    db "<NEXT>is kept out of the"
    db "<NEXT>tower by magic.<PROMPT>"
    db "<NEXT>Are your monsters"
    db "<NEXT>still wild?<WAIT>"
    db "@"

Message_04_0A::
    db "<VOICE1>*: The top of the<LINE>"
    db "tower collapsed<PROMPT>"
    db "<NEXT>when it was hit by"
    db "<NEXT>lightning.<PROMPT>"
    db "<NEXT>We're trying to"
    db "<NEXT>put up a ladder to<PROMPT>"
    db "<NEXT>see if we can't"
    db "<NEXT>get a look in.<WAIT>"
    db "@"

Message_04_0B::
    db "<BUF0> checked the<LINE>"
    db "grave.<PROMPT>"
    db "<NEXT>There was an"
    db "<NEXT>inscription.<PROMPT>"
    db "<NEXT>'Here lies Ugor,"
    db "<NEXT>the Great Sage<PROMPT>"
    db "<NEXT>and the world's"
    db "<NEXT>savior.", $95, "<WAIT>"
    db "@"

Message_04_0C::
    db "<VOICE1>*: Who disturbs my<LINE>"
    db "sleep?<PROMPT>"
    db "<NEXT>A visitor from"
    db "<NEXT>another world?<PROMPT>"
    db "<NEXT>This is indeed a"
    db "<NEXT>rare occasion.<PROMPT>"
    db "<NEXT>However, no one"
    db "<NEXT>must be permitted<PROMPT>"
    db "<NEXT>to obtain the"
    db "<NEXT>LightOrb.<PROMPT>"
    db "<NEXT>It has been sealed"
    db "<NEXT>away to sleep…<PROMPT>"
    db "<NEXT>Yes… In the same"
    db "<NEXT>way that I do…<WAIT>"
    db "@"

Message_04_0D::
    db "<VOICE1>*: What? You again?<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You seem to have"
    db "<NEXT>come from afar,<PROMPT>"
    db "<NEXT>but the Orb must"
    db "<NEXT>be left untouched.<PROMPT>"
    db "<NEXT>It will never fall"
    db "<NEXT>into anyone's hands<PROMPT>"
    db "<NEXT>again. I assure"
    db "<NEXT>you of that…<WAIT>"
    db "@"

Message_04_0E::
    db "<BUF0> checked the<LINE>"
    db "grave.<PROMPT>"
    db "<NEXT>The tombstone was"
    db "<NEXT>covered in moss.<WAIT>"
    db "@"

Message_04_0F::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>A peculiar meat"
    db "<NEXT>broth was boiling.<WAIT>"
    db "@"

Message_04_10::
    db "<VOICE1>*: …Be gone!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>If your soul can't"
    db "<NEXT>overcome natural<PROMPT>"
    db "<NEXT>wildness within,"
    db "<NEXT>you are forbidden<PROMPT>"
    db "<NEXT>from entering the"
    db "<NEXT>tower. Leave now!<WAIT>"
    db "@"

Message_04_11::
    db "<VOICE1>*: …Fine!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You've done well"
    db "<NEXT>to quell the wild<PROMPT>"
    db "<NEXT>heart that beats"
    db "<NEXT>inside.<PROMPT>"
    db "<NEXT>You've earned the"
    db "<NEXT>right to enter!<WAIT>"
    db "@"

Message_04_12::
    db "<VOICE1>*: Kweeeeh!<LINE>"
    db "<WAIT>"
    db "@"

Message_04_13::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>The chest was"
    db "<NEXT>empty.<PROMPT>"
    db "<NEXT>Could the LightOrb"
    db "<NEXT>have been in it?<WAIT>"
    db "@"

Message_04_14::
    db "<VOICE1>*: What? What?<LINE>"
    db "What happened?<PROMPT>"
    db "<NEXT>I saw a huge bird"
    db "<NEXT>fly up and go into<PROMPT>"
    db "<NEXT>the tower and"
    db "<NEXT>then it came out<PROMPT>"
    db "<NEXT>clutching a shiny"
    db "<NEXT>object.<PROMPT>"
    db "<NEXT>It flew off to the"
    db "<NEXT>west.<WAIT>"
    db "@"

Message_04_15::
    db "<VOICE1>*: Who disturbs my<LINE>"
    db "sleep?<PROMPT>"
    db "<NEXT>A visitor from"
    db "<NEXT>another world?<PROMPT>"
    db "<NEXT>This is indeed a"
    db "<NEXT>rare occasion.<PROMPT>"
    db "<NEXT>However, no one"
    db "<NEXT>must be permitted<PROMPT>"
    db "<NEXT>to obtain the"
    db "<NEXT>LightOrb.<PROMPT>"
    db "<NEXT>It has been sealed"
    db "<NEXT>away to sleep…<PROMPT>"
    db "<NEXT>Yes… In the same"
    db "<NEXT>way that I do…<PROMPT>"
    db "<NEXT>What? The LightOrb"
    db "<NEXT>was stolen?<PROMPT>"
    db "<NEXT>If it falls into"
    db "<NEXT>the wrong hands…<PROMPT>"
    db "<NEXT>Urrrgh…"
    db "<NEXT>What to do…<PROMPT>"
    db "<NEXT>I know! Can you go"
    db "<NEXT>recover it?<CHOICE>"
    db "@"

Message_04_16::
    db "<VOICE1>*: Ah, you'll do<LINE>"
    db "it? Excellent!<PROMPT>"
    db "<NEXT>But you, being a"
    db "<NEXT>human-you stand <PROMPT>"
    db "<NEXT>out too much in"
    db "<NEXT>this world.<PROMPT>"
    db "<NEXT>Look behind my"
    db "<NEXT>gravestone and<PROMPT>"
    db "<NEXT>take what you"
    db "<NEXT>find. It's a gift.<WAIT>"
    db "@"

Message_04_17::
    db "<VOICE1>*: I had thought<LINE>"
    db "that you could be<PROMPT>"
    db "<NEXT>trusted with the"
    db "<NEXT>LightOrb…<WAIT>"
    db "@"

Message_04_18::
    db "<VOICE1>*: Who disturbs my<LINE>"
    db "sleep?<PROMPT>"
    db "<NEXT>Oh, it's you again."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Sorry, but the"
    db "<NEXT>LightOrb…<PROMPT>"
    db "<NEXT>What? The LightOrb"
    db "<NEXT>was stolen?<PROMPT>"
    db "<NEXT>If it falls into"
    db "<NEXT>the wrong hands…<PROMPT>"
    db "<NEXT>Urrrgh…"
    db "<NEXT>What to do…<PROMPT>"
    db "<NEXT>I know! Can you go"
    db "<NEXT>recover it?<CHOICE>"
    db "@"

Message_04_19::
    db "<VOICE1>*: Well? Will you<LINE>"
    db "go look for the<PROMPT>"
    db "<NEXT>stolen LightOrb"
    db "<NEXT>for me?<CHOICE>"
    db "@"

Message_04_1A::
    db "<BUF0> checked<LINE>"
    db "behind the grave.<PROMPT>"
    db "<NEXT>The ChangeStaff"
    db "<NEXT>was found!<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>ChangeStaff.<WAIT>"
    db "@"

Message_04_1B::
    db "<BUF0> checked<LINE>"
    db "behind the grave.<PROMPT>"
    db "<NEXT>The ChangeStaff"
    db "<NEXT>was found!<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> put back the"
    db "<NEXT>ChangeStaff.<WAIT>"
    db "@"

Message_04_1C::
    db "<VOICE1>*: Hm? You're a<LINE>"
    db "stranger!<PROMPT>"
    db "<NEXT>You make me very"
    db "<NEXT>suspicious!<PROMPT>"
    db "<NEXT>I won't let you go"
    db "<NEXT>past me!<WAIT>"
    db "@"

Message_04_1D::
    db "<VOICE1>*: Hm? You're from<LINE>"
    db "the village!<PROMPT>"
    db "<NEXT>Hurry up and go"
    db "<NEXT>through!<WAIT>"
    db "@"

Message_04_1E::
    db "<VOICE2>*: This is the town<LINE>"
    db "of Pei.<PROMPT>"
    db "<NEXT>You'll find most"
    db "<NEXT>travel items here.<WAIT>"
    db "@"

Message_04_1F::
    db "<VOICE2>*: Nya? Travelers?<LINE>"
    db "That's rare!<WAIT>"
    db "@"

Message_04_20::
    db "<VOICE1>*: To the west is a<LINE>"
    db "mountain.<PROMPT>"
    db "<NEXT>A huge bird that"
    db "<NEXT>likes shiny things<PROMPT>"
    db "<NEXT>makes its nest"
    db "<NEXT>there.<WAIT>"
    db "@"

Message_04_21::
    db "<VOICE1>*: You should stay<LINE>"
    db "well clear of the<PROMPT>"
    db "<NEXT>mountain in the"
    db "<NEXT>west.<PROMPT>"
    db "<NEXT>The immense bird"
    db "<NEXT>that lives there<PROMPT>"
    db "<NEXT>will carry you off"
    db "<NEXT>if you get close.<WAIT>"
    db "@"

Message_04_22::
    db "<VOICE1>*: I came close to<LINE>"
    db "being abducted by<PROMPT>"
    db "<NEXT>a huge bird a"
    db "<NEXT>while ago.<PROMPT>"
    db "<NEXT>Be careful if you"
    db "<NEXT>have any shiny<PROMPT>"
    db "<NEXT>monsters like me."
    db "<NEXT>It's dangerous!<WAIT>"
    db "@"

Message_04_23::
    db "<VOICE1>*: Some time ago, a<LINE>"
    db "human child was<PROMPT>"
    db "<NEXT>taken away by the"
    db "<NEXT>huge bird.<PROMPT>"
    db "<NEXT>The child hasn't"
    db "<NEXT>been seen since.<WAIT>"
    db "@"

Message_04_24::
    db "<VOICE1>*: There wasn't a<LINE>"
    db "monster king for<PROMPT>"
    db "<NEXT>a long time, but a"
    db "<NEXT>new king appeared<PROMPT>"
    db "<NEXT>recently to take"
    db "<NEXT>the vacant throne.<WAIT>"
    db "@"

Message_04_25::
    db "<VOICE1>*: The new monster<LINE>"
    db "king makes others<PROMPT>"
    db "<NEXT>obey using magical"
    db "<NEXT>powers.<PROMPT>"
    db "<NEXT>Nobody appears to"
    db "<NEXT>be rebelling.<WAIT>"
    db "@"

Message_04_26::
    db "<VOICE1>*: You… Are you a<LINE>"
    db "monster?<CHOICE>"
    db "@"

Message_04_27::
    db "<VOICE1>*: Uh-huh… You don't<LINE>"
    db "look very strong.<WAIT>"
    db "@"

Message_04_28::
    db "<VOICE1>*: Uh-huh… You look<LINE>"
    db "uh… delicious.<WAIT>"
    db "@"

Message_04_29::
    db "<VOICE1>*: Any way you want<LINE>"
    db "to look at this,<PROMPT>"
    db "<NEXT>I look stronger"
    db "<NEXT>than you.<WAIT>"
    db "@"

Message_04_2A::
    db "<VOICE1>*: This is just a<LINE>"
    db "rumor, but the new<PROMPT>"
    db "<NEXT>monster king likes"
    db "<NEXT>precious items.<PROMPT>"
    db "<NEXT>Especially those"
    db "<NEXT>imbued with magic.<WAIT>"
    db "@"

Message_04_2B::
    db "<VOICE1>*: The tunnel in<LINE>"
    db "the west will take<PROMPT>"
    db "<NEXT>you to the castle"
    db "<NEXT>of Hitano.<PROMPT>"
    db "<NEXT>Perhaps because of"
    db "<NEXT>the new monster<PROMPT>"
    db "<NEXT>king, treasure"
    db "<NEXT>hunters of all<PROMPT>"
    db "<NEXT>stripes are said"
    db "<NEXT>to be there.<WAIT>"
    db "@"

Message_04_2C::
    db "<VOICE1>*: Are you looking<LINE>"
    db "for something?<PROMPT>"
    db "<NEXT>Huh? The LightOrb?"
    db "<NEXT>What is that?<PROMPT>"
    db "<NEXT>Well, if it glows,"
    db "<NEXT>I have a suspect.<PROMPT>"
    db "<NEXT>It's a MadCondor"
    db "<NEXT>that nests atop a<PROMPT>"
    db "<NEXT>mountain in the"
    db "<NEXT>west.<WAIT>"
    db "@"

Message_04_2D::
    db "<VOICE1>*: Good day. How<LINE>"
    db "may I help you?<WAIT>"
    db "@"

Message_04_2E::
    db "<VOICE1>*: How may we serve<LINE>"
    db "your mortal souls?<WAIT>"
    db "@"

Message_04_2F::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>Water reflected"
    db "<NEXT>the cloudless sky.<WAIT>"
    db "@"

Message_04_30::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>…It appeared to be"
    db "<NEXT>merchandise…<WAIT>"
    db "@"

Message_04_31::
    db "<BUF0> tried to<LINE>"
    db "open the chest.<PROMPT>"
    db "<NEXT>But the chest was"
    db "<NEXT>locked.<WAIT>"
    db "@"

Message_04_32::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "traveler's inn.<WAIT>"
    db "@"

Message_04_33::
    db "<VOICE1>*: Kweeeeeh!<LINE>"
    db "<WAIT>"
    db "@"

Message_04_34::
    db "<VOICE1>*: When I passed<LINE>"
    db "too close to the<PROMPT>"
    db "<NEXT>mountain, I ended"
    db "<NEXT>up in a nest!<WAIT>"
    db "@"

Message_04_35::
    db "<VOICE1>*: I… I didn't take<LINE>"
    db "anything!<PROMPT>"
    db "<NEXT>There was nothing"
    db "<NEXT>here already!<PROMPT>"
    db "<NEXT>Somebody's beaten"
    db "<NEXT>us to it!<WAIT>"
    db "@"

Message_04_36::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>But it was empty."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Where has the"
    db "<NEXT>LightOrb gone…<WAIT>"
    db "@"

Message_04_37::
    db "<VOICE1>*: This is the<LINE>"
    db "Castle of Hitano.<PROMPT>"
    db "<NEXT>It bustles with"
    db "<NEXT>treasure hunters.<WAIT>"
    db "@"

Message_04_38::
    db "<VOICE1>*: A monster king<LINE>"
    db "has appeared to<PROMPT>"
    db "<NEXT>take over the"
    db "<NEXT>world, but all it<PROMPT>"
    db "<NEXT>seems to want is"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>Things haven't"
    db "<NEXT>changed much.<WAIT>"
    db "@"

Message_04_39::
    db "<VOICE1>*: I've lived here<LINE>"
    db "for 200 years now.<PROMPT>"
    db "<NEXT>Care to hear about"
    db "<NEXT>the past?<CHOICE>"
    db "@"

Message_04_3A::
    db "<VOICE1>*: This area had<LINE>"
    db "been prosperous,<PROMPT>"
    db "<NEXT>but a long war"
    db "<NEXT>laid it to waste.<PROMPT>"
    db "<NEXT>The treasures that"
    db "<NEXT>you find harken<PROMPT>"
    db "<NEXT>back to the olden"
    db "<NEXT>days.<PROMPT>"
    db "<NEXT>If the Great Sage"
    db "<NEXT>didn't quell the<PROMPT>"
    db "<NEXT>war with the"
    db "<NEXT>LightOrb, perhaps<PROMPT>"
    db "<NEXT>even this Castle"
    db "<NEXT>may not exist…<WAIT>"
    db "@"

Message_04_3B::
    db "<VOICE1>*: Oh… You won't<LINE>"
    db "humor an old man…<WAIT>"
    db "@"

Message_04_3C::
    db "<VOICE1>*: The Castle is<LINE>"
    db "under the monster<PROMPT>"
    db "<NEXT>King's rule now."
    db "<NEXT>You can earn a<PROMPT>"
    db "<NEXT>promotion by"
    db "<NEXT>finding treasures.<WAIT>"
    db "@"

Message_04_3D::
    db "<VOICE1>*: Did you see the<LINE>"
    db "monster King's<PROMPT>"
    db "<NEXT>proclamation?"
    db "<NEXT>If you find three<PROMPT>"
    db "<NEXT>treasures, you get"
    db "<NEXT>the LightOrb!<WAIT>"
    db "@"

Message_04_3E::
    db "<VOICE1>*: The cave to the<LINE>"
    db "south…<PROMPT>"
    db "<NEXT>That has treasure"
    db "<NEXT>in it for sure.<PROMPT>"
    db "<NEXT>But the entrance"
    db "<NEXT>is too small.<PROMPT>"
    db "<NEXT>There's no way I"
    db "<NEXT>can squeeze in.<WAIT>"
    db "@"

Message_04_3F::
    db "<VOICE1>*: The new monster<LINE>"
    db "King is said to<PROMPT>"
    db "<NEXT>like his treasures"
    db "<NEXT>a lot.<PROMPT>"
    db "<NEXT>If I take him some"
    db "<NEXT>precious items,<PROMPT>"
    db "<NEXT>will he let me"
    db "<NEXT>join his army?<WAIT>"
    db "@"

Message_04_40::
    db "<VOICE1>*: Hardly no one<LINE>"
    db "has seen the new<PROMPT>"
    db "<NEXT>Monster King. He"
    db "<NEXT>must be cautious<PROMPT>"
    db "<NEXT>not to leave his"
    db "<NEXT>castle very much.<WAIT>"
    db "@"

Message_04_41::
    db "<VOICE1>*: This is only for<LINE>"
    db "army personnel!<PROMPT>"
    db "<NEXT>Stay out, you"
    db "<NEXT>civilians!<WAIT>"
    db "@"

Message_04_42::
    db "<VOICE1>*: The King has<LINE>"
    db "posted a notice.<PROMPT>"
    db "<NEXT>Read the sign over"
    db "<NEXT>there.<WAIT>"
    db "@"

Message_04_43::
    db "<VOICE1>*: If you wish to<LINE>"
    db "join our army,<PROMPT>"
    db "<NEXT>then you should"
    db "<NEXT>bring items that<PROMPT>"
    db "<NEXT>would please our"
    db "<NEXT>new Majesty.<WAIT>"
    db "@"

Message_04_44::
    db "<VOICE1>*: Give away the<LINE>"
    db "LightOrb?<PROMPT>"
    db "<NEXT>But that's what"
    db "<NEXT>gives the monster<PROMPT>"
    db "<NEXT>King his power,"
    db "<NEXT>the LightOrb does.<PROMPT>"
    db "<NEXT>Our King thinks in"
    db "<NEXT>mysterious ways.<WAIT>"
    db "@"

Message_04_45::
    db "<VOICE1>*: If you have the<LINE>"
    db "LightOrb, you can<PROMPT>"
    db "<NEXT>become our King"
    db "<NEXT>with its power.<PROMPT>"
    db "<NEXT>What should I do"
    db "<NEXT>if I were king…<PROMPT>"
    db "<NEXT>As a starter, I'll"
    db "<NEXT>eat Sirloin every<PROMPT>"
    db "<NEXT>day-three square"
    db "<NEXT>meals a day!<PROMPT>"
    db "<NEXT>But I've been"
    db "<NEXT>gaining weight…<PROMPT>"
    db "<NEXT>I'm afraid I won't"
    db "<NEXT>be able to fly…<WAIT>"
    db "@"

Message_04_46::
    db "<VOICE1>*: If I had the<LINE>"
    db "LightOrb, even I<PROMPT>"
    db "<NEXT>could become the"
    db "<NEXT>king of monsters.<PROMPT>"
    db "<NEXT>Could you please"
    db "<NEXT>tell me where I<PROMPT>"
    db "<NEXT>could find some"
    db "<NEXT>treasures?<WAIT>"
    db "@"

Message_04_47::
    db "<VOICE1>*: Want to know the<LINE>"
    db "most fundamental<PROMPT>"
    db "<NEXT>point to treasure"
    db "<NEXT>hunting?<CHOICE>"
    db "@"

Message_04_48::
    db "<VOICE1>*: Walk. Learn to<LINE>"
    db "walk everywhere.<PROMPT>"
    db "<NEXT>Be careful to look"
    db "<NEXT>everywhere.<PROMPT>"
    db "<NEXT>If you can fly,"
    db "<NEXT>use that ability.<WAIT>"
    db "@"

Message_04_49::
    db "<VOICE1>*: I see. You wish<LINE>"
    db "to chart your own<PROMPT>"
    db "<NEXT>destiny, do you?"
    db "<NEXT>That is admirable.<WAIT>"
    db "@"

Message_04_4A::
    db "<VOICE1>*: Hear me out if<LINE>"
    db "you wish to fly.<PROMPT>"
    db "<NEXT>Stand at the edge"
    db "<NEXT>of the world, and<PROMPT>"
    db "<NEXT>ride upon the wind"
    db "<NEXT>to cross the sky.<WAIT>"
    db "@"

Message_04_4B::
    db "<VOICE1>*: Welcome! How may<LINE>"
    db "I serve you?<WAIT>"
    db "@"

Message_04_4C::
    db "<VOICE1>*: How may our<LINE>"
    db "church help you?<WAIT>"
    db "@"

Message_04_4D::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'The finder of"
    db "<NEXT>three treasures<PROMPT>"
    db "<NEXT>shall earn a"
    db "<NEXT>handsome reward.<PROMPT>"
    db "<NEXT>They are the"
    db "<NEXT>Heaven Sword,<PROMPT>"
    db "<NEXT>Heaven Armor and"
    db "<NEXT>Heaven Helmet.", $95, "<WAIT>"
    db "@"

Message_04_4E::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'The Heaven Sword,"
    db "<NEXT>Heaven Armor and<PROMPT>"
    db "<NEXT>the Heaven Helmet."
    db "<NEXT>Gather these, and<PROMPT>"
    db "<NEXT>the LightOrb shall"
    db "<NEXT>be your reward.<PROMPT>"
    db "<NEXT>I will await word"
    db "<NEXT>in the Castle.<PROMPT>"
    db "<NEXT>-The King", $95
    db "<NEXT><WAIT>"
    db "@"

Message_04_4F::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>Bizarre bugs were"
    db "<NEXT>on skewers.<WAIT>"
    db "@"

Message_04_50::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>A face grinned up"
    db "<NEXT>from the darkness.<PROMPT>"
    db "<NEXT>The vase actually"
    db "<NEXT>was an EvilPot.<WAIT>"
    db "@"

Message_04_51::
    db "<VOICE1>*: Welcome to our<LINE>"
    db "inn.<WAIT>"
    db "@"

Message_04_52::
    db "<VOICE1>*: The Change Staff<LINE>"
    db "will open paths.<PROMPT>"
    db "<NEXT>I am counting on"
    db "<NEXT>you to find the<PROMPT>"
    db "<NEXT>LightOrb."
    db "<NEXT>Don't fail me!<WAIT>"
    db "@"

Message_04_53::
    db "<VOICE1>*: Hey, kiddo!<LINE>"
    db "You're new here.<PROMPT>"
    db "<NEXT>Don't cause any"
    db "<NEXT>trouble in here!<WAIT>"
    db "@"

Message_04_56::
    db "<VOICE1>*: Hey, kiddo! You<LINE>"
    db "treasure hunting?<PROMPT>"
    db "<NEXT>The place is just"
    db "<NEXT>crawling with<PROMPT>"
    db "<NEXT>treasure hunters"
    db "<NEXT>and the like!<WAIT>"
    db "@"

Message_04_57::
    db "<VOICE1>*: On the island to<LINE>"
    db "the west, there is<PROMPT>"
    db "<NEXT>the Wind Tower."
    db "<NEXT>But I can't fly,<PROMPT>"
    db "<NEXT>so I can't get over"
    db "<NEXT>there.<WAIT>"
    db "@"

Message_04_58::
    db "<VOICE1>*: To the east is a<LINE>"
    db "suspension bridge.<PROMPT>"
    db "<NEXT>Beyond it is a"
    db "<NEXT>haunted castle.<PROMPT>"
    db "<NEXT>There, the undead"
    db "<NEXT>guard a treasure.<PROMPT>"
    db "<NEXT>However, if you"
    db "<NEXT>can't break the<PROMPT>"
    db "<NEXT>traps that they"
    db "<NEXT>have in place, you<PROMPT>"
    db "<NEXT>could end up"
    db "<NEXT>joining them.<WAIT>"
    db "@"

Message_04_59::
    db "<VOICE1>*: Those inside the<LINE>"
    db "haunted castle<PROMPT>"
    db "<NEXT>speak only amongst"
    db "<NEXT>themselves.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>solve the traps<PROMPT>"
    db "<NEXT>yourself-there is"
    db "<NEXT>no one to help.<WAIT>"
    db "@"

Message_04_5A::
    db "<BUF0> checked the<LINE>"
    db "small hole.<PROMPT>"
    db "<NEXT>It looked large"
    db "<NEXT>enough to enter.<WAIT>"
    db "@"

Message_04_5B::
    db "<BUF0> checked the<LINE>"
    db "small hole.<PROMPT>"
    db "<NEXT>It's too small to"
    db "<NEXT>fit some heads…<WAIT>"
    db "@"

Message_04_5C::
    db "<BUF0> checked the<LINE>"
    db "small hole.<PROMPT>"
    db "<NEXT>It's too small to"
    db "<NEXT>fit some heads…<WAIT>"
    db "@"

Message_04_5D::
    db "<VOICE1>*: You can take<LINE>"
    db "this treasure,<PROMPT>"
    db "<NEXT>but only if you"
    db "<NEXT>can beat me!<PROMPT>"
    db "<NEXT>No need to hold"
    db "<NEXT>back just because<PROMPT>"
    db "<NEXT>I happen to be"
    db "<NEXT>smaller than you!<WAIT>"
    db "@"

Message_04_5E::
    db "<VOICE1>*: I'm up for your<LINE>"
    db "challenge anytime!<WAIT>"
    db "@"

Message_04_5F::
    db "<VOICE1>*: Heh, you're not<LINE>"
    db "half bad!<PROMPT>"
    db "<NEXT>As promised, here's"
    db "<NEXT>your treasure!<WAIT>"
    db "@"

Message_04_60::
    db "<VOICE1>*: Let the power of<LINE>"
    db "justice smite the<PROMPT>"
    db "<NEXT>greedy seekers of"
    db "<NEXT>treasure…<WAIT>"
    db "@"

Message_04_61::
    db "<VOICE1>*: Step once on<LINE>"
    db "each of the two<PROMPT>"
    db "<NEXT>floor tiles on the"
    db "<NEXT>right.<WAIT>"
    db "@"

Message_04_62::
    db "<BUF0> checked the<LINE>"
    db "notice.<PROMPT>"
    db "<NEXT>'Lay the souls to"
    db "<NEXT>eternal rest.", $95, "<WAIT>"
    db "@"

Message_04_63::
    db "<BUF0> checked the<LINE>"
    db "notice.<PROMPT>"
    db "<NEXT>'Follow the eyes"
    db "<NEXT>of the undead.<PROMPT>"
    db "<NEXT>The key lies at"
    db "<NEXT>the end.", $95, "<WAIT>"
    db "@"

Message_04_64::
    db "<BUF0> checked the<LINE>"
    db "gravestone.<PROMPT>"
    db "<NEXT>There was a round"
    db "<NEXT>button. Press it?<CHOICE>"
    db "@"

Message_04_65::
    db "A door opened<LINE>"
    db "somewhere…<WAIT>"
    db "@"

Message_04_66::
    db "<VOICE1>*: You overcame the<LINE>"
    db "traps I laid…<PROMPT>"
    db "<NEXT>I'm impressed by"
    db "<NEXT>your courage, and<PROMPT>"
    db "<NEXT>moreso because of"
    db "<NEXT>your age.<PROMPT>"
    db "<NEXT>But if you want"
    db "<NEXT>the treasure,<PROMPT>"
    db "<NEXT>you'll have to"
    db "<NEXT>defeat me first!<WAIT>"
    db "@"

Message_04_67::
    db "<VOICE1>*: Wahahahah! Here<LINE>"
    db "again, are you?<PROMPT>"
    db "<NEXT>I commend you on"
    db "<NEXT>your courage!<PROMPT>"
    db "<NEXT>But if you want"
    db "<NEXT>the treasure,<PROMPT>"
    db "<NEXT>you'll have to"
    db "<NEXT>defeat me first!<WAIT>"
    db "@"

Message_04_68::
    db "<VOICE1>*: You've beaten me<LINE>"
    db "fairly…<PROMPT>"
    db "<NEXT>Take the treasure…"
    db "<NEXT>Farewell…<WAIT>"
    db "@"

Message_04_69::
    db "<VOICE1>*: What? You have<LINE>"
    db "the three items?<PROMPT>"
    db "<NEXT>…It's true…"
    db "<NEXT>They're here.<PROMPT>"
    db "<NEXT>Fine, go in!"
    db "<NEXT><WAIT>"
    db "@"

Message_04_6A::
    db "<VOICE1>*: The King's castle<LINE>"
    db "is reached by the<PROMPT>"
    db "<NEXT>traveler's gate"
    db "<NEXT>here.<WAIT>"
    db "@"

Message_04_6B::
    db "<VOICE1>*: What? You have<LINE>"
    db "the three items?<PROMPT>"
    db "<NEXT>I'm busy! Don't"
    db "<NEXT>waste my time!<WAIT>"
    db "@"

Message_04_6C::
    db "<VOICE1>*: Who would've<LINE>"
    db "thought anyone<PROMPT>"
    db "<NEXT>would collect all"
    db "<NEXT>three treasures…<WAIT>"
    db "@"

Message_04_6D::
    db "<VOICE1>*: The monster<LINE>"
    db "army's general is<PROMPT>"
    db "<NEXT>beyond here."
    db "<NEXT>You had better<PROMPT>"
    db "<NEXT>be on your best"
    db "<NEXT>behavior.<WAIT>"
    db "@"

Message_04_6E::
    db "<VOICE1>*: Our King's castle<LINE>"
    db "is an invincible<PROMPT>"
    db "<NEXT>fortress that is"
    db "<NEXT>guarded by the<PROMPT>"
    db "<NEXT>elite in the"
    db "<NEXT>monster army.<WAIT>"
    db "@"

Message_04_6F::
    db "<VOICE1>*: What? You've got<LINE>"
    db "the three items?<PROMPT>"
    db "<NEXT>That means you get"
    db "<NEXT>the LightOrb…<PROMPT>"
    db "<NEXT>That means you'll"
    db "<NEXT>be our next King!<PROMPT>"
    db "<NEXT>Well, when you do"
    db "<NEXT>become King, I do<PROMPT>"
    db "<NEXT>hope you will"
    db "<NEXT>remember me.<WAIT>"
    db "@"

Message_04_70::
    db "<VOICE1>*: Hm? How did you<LINE>"
    db "get in here?<WAIT>"
    db "@"

Message_04_71::
    db "<VOICE1>*: I'm surprised<LINE>"
    db "anyone managed to<PROMPT>"
    db "<NEXT>find all three"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>Anyway, the King"
    db "<NEXT>has left orders<PROMPT>"
    db "<NEXT>that you should"
    db "<NEXT>bring your trove<PROMPT>"
    db "<NEXT>to the meeting"
    db "<NEXT>chamber.<PROMPT>"
    db "<NEXT>To reach the King's"
    db "<NEXT>castle, take the<PROMPT>"
    db "<NEXT>traveler's gate at"
    db "<NEXT>the back.<WAIT>"
    db "@"

Message_04_72::
    db "<VOICE1>*: If you can't even<LINE>"
    db "reach the Castle's<PROMPT>"
    db "<NEXT>meeting chamber, I"
    db "<NEXT>would think that<PROMPT>"
    db "<NEXT>you don't have the"
    db "<NEXT>right to get the<PROMPT>"
    db "<NEXT>LightOrb from the"
    db "<NEXT>current King.<WAIT>"
    db "@"

Message_04_73::
    db "<VOICE1>*: You! I've never<LINE>"
    db "seen you before!<PROMPT>"
    db "<NEXT>You're not one of"
    db "<NEXT>our army!<WAIT>"
    db "@"

Message_04_74::
    db "<VOICE1>*: Hm? Are you a<LINE>"
    db "new recruit?<PROMPT>"
    db "<NEXT>What unit do you"
    db "<NEXT>belong to?<PROMPT>"
    db "<NEXT>Why aren't you"
    db "<NEXT>answering me?<PROMPT>"
    db "<NEXT>Are you a spy?"
    db "<NEXT>That must be it!<WAIT>"
    db "@"

Message_04_75::
    db "<VOICE1>*: Oh, you're the<LINE>"
    db "cooking crew.<PROMPT>"
    db "<NEXT>Do a good job with"
    db "<NEXT>our meals.<WAIT>"
    db "@"

Message_04_76::
    db "<VOICE1>*: Awaargh, I'm<LINE>"
    db "late, I'm late!<PROMPT>"
    db "<NEXT>They overwork us"
    db "<NEXT>terribly here.<WAIT>"
    db "@"

Message_04_77::
    db "<VOICE1>*: They keep piling<LINE>"
    db "on these ludicrous<PROMPT>"
    db "<NEXT>orders. If I ever"
    db "<NEXT>become important,<PROMPT>"
    db "<NEXT>they", $44, " better watch"
    db "<NEXT>out!<WAIT>"
    db "@"

Message_04_78::
    db "<VOICE1>*: Gaah! You found<LINE>"
    db "me while I was<PROMPT>"
    db "<NEXT>sluffing off from"
    db "<NEXT>work…<WAIT>"
    db "@"

Message_04_79::
    db "<VOICE1>*: Ah, so good of<LINE>"
    db "you to come!<PROMPT>"
    db "<NEXT>Well? Where are"
    db "<NEXT>the three items?<PROMPT>"
    db "<NEXT>What? You didn't"
    db "<NEXT>bring them?<PROMPT>"
    db "<NEXT>Why did you bother"
    db "<NEXT>coming here?<PROMPT>"
    db "<NEXT>Find the three"
    db "<NEXT>treasures and<PROMPT>"
    db "<NEXT>bring them to me."
    db "<NEXT>I will wait here<PROMPT>"
    db "<NEXT>for as long as it"
    db "<NEXT>takes.<WAIT>"
    db "@"

Message_04_7A::
    db "<VOICE1>*: Ah, so good of<LINE>"
    db "you to come!<PROMPT>"
    db "<NEXT>Well? Where are"
    db "<NEXT>the three items?<WAIT>"
    db "@"

Message_04_7B::
    db "<BUF0> handed over<LINE>"
    db "the Heaven Helmet.<WAIT>"
    db "@"

Message_04_7C::
    db "<BUF0> handed over<LINE>"
    db "the Heaven Armor.<WAIT>"
    db "@"

Message_04_7D::
    db "<BUF0> handed over<LINE>"
    db "the Heaven Sword.<WAIT>"
    db "@"

Message_04_7E::
    db "<VOICE1>*: Good. You have<LINE>"
    db "brought the three<PROMPT>"
    db "<NEXT>treasures that I"
    db "<NEXT>asked for.<PROMPT>"
    db "<NEXT>Well done."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>…And now, the"
    db "<NEXT>final test.<PROMPT>"
    db "<NEXT>Show me that you"
    db "<NEXT>are worthy of<PROMPT>"
    db "<NEXT>receiving the"
    db "<NEXT>LightOrb!<WAIT>"
    db "@"

Message_04_7F::
    db "<VOICE1>*: Fwahahaha! Don't<LINE>"
    db "you ever give up?<PROMPT>"
    db "<NEXT>Fine! If you want"
    db "<NEXT>the LightOrb, you<PROMPT>"
    db "<NEXT>will have to take"
    db "<NEXT>it by force!<WAIT>"
    db "@"

Message_04_80::
    db "<VOICE1>*: Gwaah! You've<LINE>"
    db "beaten me fairly!<PROMPT>"
    db "<NEXT>But I am merely a"
    db "<NEXT>gate keeper.<PROMPT>"
    db "<NEXT>I'm under the"
    db "<NEXT>LightOrb's spell,<PROMPT>"
    db "<NEXT>like everyone"
    db "<NEXT>else.<PROMPT>"
    db "<NEXT>The real King is"
    db "<NEXT>in a room beyond<PROMPT>"
    db "<NEXT>this one. If you"
    db "<NEXT>want the LightOrb,<PROMPT>"
    db "<NEXT>you'll have to"
    db "<NEXT>keep going.<WAIT>"
    db "@"

Message_04_81::
    db "<VOICE1>Kameha: So it was<LINE>"
    db "you who got the<PROMPT>"
    db "<NEXT>three treasures,"
    db "<NEXT><BUF0>…<PROMPT>"
    db "<NEXT>Surprised? I'm the"
    db "<NEXT>Monster King!<PROMPT>"
    db "<NEXT>While looking for"
    db "<NEXT>a plug for the<PROMPT>"
    db "<NEXT>Log's Navel, a"
    db "<NEXT>huge bird caught<PROMPT>"
    db "<NEXT>me, and hauled me"
    db "<NEXT>up to its nest.<PROMPT>"
    db "<NEXT>There, I found the"
    db "<NEXT>LightOrb.<PROMPT>"
    db "<NEXT>The Orb didn't work"
    db "<NEXT>as the plug.<PROMPT>"
    db "<NEXT>So, I used the"
    db "<NEXT>LightOrb's power<PROMPT>"
    db "<NEXT>to become the King"
    db "<NEXT>of the monsters.<PROMPT>"
    db "<NEXT>And then I ordered"
    db "<NEXT>my subordinates to<PROMPT>"
    db "<NEXT>look for treasures"
    db "<NEXT>that might work.<WAIT>"
    db "@"

Message_04_82::
    db "<VOICE1>Kameha: If the<LINE>"
    db "three items that<PROMPT>"
    db "<NEXT>you brought are no"
    db "<NEXT>good as plugs,<PROMPT>"
    db "<NEXT>there can't be"
    db "<NEXT>anything else<PROMPT>"
    db "<NEXT>useable in this"
    db "<NEXT>world.<PROMPT>"
    db "<NEXT>They must be"
    db "<NEXT>worried about me<PROMPT>"
    db "<NEXT>back home. I", $44
    db "<NEXT>better go home.<WAIT>"
    db "@"

Message_04_83::
    db "<VOICE1>Kameha: Wha-wha<LINE>"
    db "whaaaat?<PROMPT>"
    db "<NEXT>What just happened"
    db "<NEXT>now?<WAIT>"
    db "@"

Message_04_84::
    db "<VOICE1>Kameha: Who are<LINE>"
    db "you to disturb me?<WAIT>"
    db "@"

Message_04_85::
    db "<VOICE1>*: Greetings! I am<LINE>"
    db "Darck, the King of<PROMPT>"
    db "<NEXT>Limbo, a world"
    db "<NEXT>between worlds.<PROMPT>"
    db "<NEXT>Darck: I travel to"
    db "<NEXT>many worlds as I<PROMPT>"
    db "<NEXT>seek treasures for"
    db "<NEXT>my collection.<PROMPT>"
    db "<NEXT>I'm here to collect"
    db "<NEXT>your treasure.<WAIT>"
    db "@"

Message_04_86::
    db "<VOICE1>Kameha: What? Why<LINE>"
    db "do you do that?<WAIT>"
    db "@"

Message_04_87::
    db "<VOICE1>Darck: Well, for<LINE>"
    db "me, anything that<PROMPT>"
    db "<NEXT>evokes envy or"
    db "<NEXT>jealousy in others<PROMPT>"
    db "<NEXT>is an invaluable"
    db "<NEXT>treasure.<PROMPT>"
    db "<NEXT>For those emotions"
    db "<NEXT>give me strength.<PROMPT>"
    db "<NEXT>I am the true"
    db "<NEXT>Monster King.<PROMPT>"
    db "<NEXT>While I was away,"
    db "<NEXT>I understand my<PROMPT>"
    db "<NEXT>subordinates were"
    db "<NEXT>abused by you?<PROMPT>"
    db "<NEXT>Tch, the fools."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>One could never"
    db "<NEXT>get good help…<PROMPT>"
    db "<NEXT>Anyway, enough of"
    db "<NEXT>this idle chatter.<PROMPT>"
    db "<NEXT>In my collection,"
    db "<NEXT>I have something<PROMPT>"
    db "<NEXT>that will plug the"
    db "<NEXT>Log's Navel.<PROMPT>"
    db "<NEXT>You need it to"
    db "<NEXT>save GreatLog.<PROMPT>"
    db "<NEXT>I'm willing to"
    db "<NEXT>exchange it for<PROMPT>"
    db "<NEXT>the treasures that"
    db "<NEXT>you've collected.<PROMPT>"
    db "<NEXT>I would consider"
    db "<NEXT>that an equitable<PROMPT>"
    db "<NEXT>arrangement."
    db "<NEXT>Wouldn't you agree?<CHOICE>"
    db "@"

Message_04_88::
    db "<VOICE1>Darck: I imagine<LINE>"
    db "that you don't have<PROMPT>"
    db "<NEXT>much time left, do"
    db "<NEXT>you?<PROMPT>"
    db "<NEXT>I don't think my"
    db "<NEXT>offer is unfair.<PROMPT>"
    db "<NEXT>Wouldn't you agree?"
    db "<NEXT><CHOICE>"
    db "@"

Message_04_8B::
    db "<VOICE1>Darck: Good!<LINE>"
    db "We have a deal!<PROMPT>"
    db "<NEXT>Fine, fine!"
    db "<NEXT>Fwahahahaha!<PROMPT>"
    db "<NEXT>I will take this"
    db "<NEXT>LightOrb and the<PROMPT>"
    db "<NEXT>treasures here"
    db "<NEXT>first.<PROMPT>"
    db "<NEXT>In return, take"
    db "<NEXT>this Magic Key.<WAIT>"
    db "@"

Message_04_8C::
    db "<VOICE1>Darck: That key<LINE>"
    db "will bring you to<PROMPT>"
    db "<NEXT>my Castle."
    db "<NEXT>I will be waiting<PROMPT>"
    db "<NEXT>for you to bring"
    db "<NEXT>me more treasures.<WAIT>"
    db "@"

Message_04_8D::
    db "<BUF0> received the<LINE>"
    db "Limbo Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_04_8E::
    db "<VOICE1>Darck: I will be<LINE>"
    db "readying a proper<PROMPT>"
    db "<NEXT>welcome for you"
    db "<NEXT>when you come.<WAIT>"
    db "@"

Message_04_8F::
    db "<VOICE1>Kameha: Our<LINE>"
    db "treasures!<PROMPT>"
    db "<NEXT>He took them all"
    db "<NEXT>away from us!<PROMPT>"
    db "<NEXT>…Anyway, are you"
    db "<NEXT>sure about what<PROMPT>"
    db "<NEXT>you just did?"
    db "<NEXT>That promise…<PROMPT>"
    db "<NEXT>He even wants the"
    db "<NEXT>treasures you got<PROMPT>"
    db "<NEXT>already as plugs"
    db "<NEXT>for the Navel…<PROMPT>"
    db "<NEXT>It has to be a"
    db "<NEXT>trap!<WAIT>"
    db "@"

Message_04_90::
    db "A voice echoed<LINE>"
    db "from nowhere…<WAIT>"
    db "@"
    ds $13d, $00
