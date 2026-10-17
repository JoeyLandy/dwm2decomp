; ROM bank $0E: breeding tables: species pair rules and family results; message bank $0E
; The annotated listing of this bank is build/listing/bank0e.asm.

SECTION "Bank 0E", ROMX
    db $0e

; Starts message wStringIndex of message bank $0E: below $88 from this bank's table
; MessageStrings_Bank0E (BeginStringDisplay); from $88 on it far-calls
; BeginMessageDisplay_Bank0E_Overflow in bank $96, which subtracts $88 and uses
; MessageStrings_Bank0E_Overflow. The only caller read is the message test's library 28 ($1C),
; DebugMessageTest_Update_ShowBank0E. (C1, E-0369)
BeginMessageDisplay_Bank0E:: ; configured code entry (E-0395 (BeginMessageDisplay_Bank0E: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld a, [wStringIndex]
    cp $88
    jr c, .call_begin_string_display
    farcall BeginMessageDisplay_Bank0E_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank0E
    call BeginStringDisplay
    ret

SECTION "Bank 0E CopyStringToBuffer_Bank0E", ROMX

; Copies message wStringIndex of message bank $0E to the address in wStringDestLo/wStringDestHi, its
; $F0 terminator included: below $88 through CopyStringToBuffer with the table MessageStrings_Bank0E
; of this bank (wStringBank = $0E); from $88 on it far-calls CopyStringToBuffer_Bank0E_Overflow in
; bank $96, which subtracts $88 from wStringIndex and copies from MessageStrings_Bank0E_Overflow. No
; caller was found in src/. (C2, E-0376)
; message bank $0E: when wStringIndex < $88, CopyStringToBuffer with this bank's table
; MessageStrings_Bank0E; otherwise far-calls CopyStringToBuffer_Bank0E_Overflow (E-0080)
CopyStringToBuffer_Bank0E:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wStringIndex]
    cp $88
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank0E_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank0E
    call CopyStringToBuffer
    ret

SECTION "Bank 0E ShowStringAtOnce_Bank0E", ROMX

; Calls BeginMessageDisplay_Bank0E, which starts string wStringIndex of its table, then
; RunStringDisplayToEnd, which prints the whole string at once (wTextFlags bit 1) instead of a glyph
; per frame. No traced code, jump table or pointer reaches it (E-0395: it decodes as a routine but
; is unreached in the static listing). (C1, E-0395)
ShowStringAtOnce_Bank0E:: ; configured code entry (E-0395); C0
    call BeginMessageDisplay_Bank0E
    call RunStringDisplayToEnd
    ret

SECTION "Bank 0E MessageStrings_Bank0E", ROMX

; The category table of message bank $0E: a single word, the pointer to StringList_Bank0E_0, a list
; of 136 string pointers (ids 0-$87). BeginMessageDisplay_Bank0E and CopyStringToBuffer_Bank0E pass
; it in DE to BeginStringDisplay and CopyStringToBuffer when wStringIndex is below $88; LookupString
; takes word wStringCategory of it, so only category 0 is valid. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
MessageStrings_Bank0E::
    dw StringList_Bank0E_0 ; id 0

; category list of MessageStrings_Bank0E; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank0E_0::
    dw MessageBank0E_00 ; id 0
    dw MessageBank0E_00 ; id 1
    dw MessageBank0E_00 ; id 2
    dw MessageBank0E_00 ; id 3
    dw MessageBank0E_00 ; id 4
    dw MessageBank0E_00 ; id 5
    dw MessageBank0E_00 ; id 6
    dw MessageBank0E_00 ; id 7
    dw MessageBank0E_00 ; id 8
    dw MessageBank0E_00 ; id 9
    dw MessageBank0E_00 ; id 10
    dw MessageBank0E_00 ; id 11
    dw MessageBank0E_0C ; id 12
    dw MessageBank0E_0D ; id 13
    dw MessageBank0E_0D ; id 14
    dw MessageBank0E_0D ; id 15
    dw MessageBank0E_0D ; id 16
    dw MessageBank0E_0D ; id 17
    dw MessageBank0E_0D ; id 18
    dw MessageBank0E_13 ; id 19
    dw MessageBank0E_14 ; id 20
    dw MessageBank0E_15 ; id 21
    dw MessageBank0E_16 ; id 22
    dw MessageBank0E_17 ; id 23
    dw MessageBank0E_18 ; id 24
    dw MessageBank0E_19 ; id 25
    dw MessageBank0E_1A ; id 26
    dw MessageBank0E_1B ; id 27
    dw MessageBank0E_1C ; id 28
    dw MessageBank0E_1D ; id 29
    dw MessageBank0E_1D ; id 30
    dw MessageBank0E_1D ; id 31
    dw MessageBank0E_1D ; id 32
    dw MessageBank0E_1D ; id 33
    dw MessageBank0E_1D ; id 34
    dw MessageBank0E_23 ; id 35
    dw MessageBank0E_24 ; id 36
    dw MessageBank0E_25 ; id 37
    dw MessageBank0E_26 ; id 38
    dw MessageBank0E_27 ; id 39
    dw MessageBank0E_28 ; id 40
    dw MessageBank0E_29 ; id 41
    dw MessageBank0E_2A ; id 42
    dw MessageBank0E_2B ; id 43
    dw MessageBank0E_2C ; id 44
    dw MessageBank0E_2D ; id 45
    dw MessageBank0E_2D ; id 46
    dw MessageBank0E_2D ; id 47
    dw MessageBank0E_2D ; id 48
    dw MessageBank0E_2D ; id 49
    dw MessageBank0E_2D ; id 50
    dw MessageBank0E_33 ; id 51
    dw MessageBank0E_34 ; id 52
    dw MessageBank0E_35 ; id 53
    dw MessageBank0E_36 ; id 54
    dw MessageBank0E_37 ; id 55
    dw MessageBank0E_38 ; id 56
    dw MessageBank0E_39 ; id 57
    dw MessageBank0E_3A ; id 58
    dw MessageBank0E_3B ; id 59
    dw MessageBank0E_3C ; id 60
    dw MessageBank0E_3D ; id 61
    dw MessageBank0E_3D ; id 62
    dw MessageBank0E_3D ; id 63
    dw MessageBank0E_3D ; id 64
    dw MessageBank0E_3D ; id 65
    dw MessageBank0E_3D ; id 66
    dw MessageBank0E_43 ; id 67
    dw MessageBank0E_44 ; id 68
    dw MessageBank0E_45 ; id 69
    dw MessageBank0E_46 ; id 70
    dw MessageBank0E_47 ; id 71
    dw MessageBank0E_48 ; id 72
    dw MessageBank0E_49 ; id 73
    dw MessageBank0E_4A ; id 74
    dw MessageBank0E_4B ; id 75
    dw MessageBank0E_4C ; id 76
    dw MessageBank0E_4D ; id 77
    dw MessageBank0E_4D ; id 78
    dw MessageBank0E_4D ; id 79
    dw MessageBank0E_4D ; id 80
    dw MessageBank0E_4D ; id 81
    dw MessageBank0E_4D ; id 82
    dw MessageBank0E_53 ; id 83
    dw MessageBank0E_54 ; id 84
    dw MessageBank0E_55 ; id 85
    dw MessageBank0E_56 ; id 86
    dw MessageBank0E_57 ; id 87
    dw MessageBank0E_58 ; id 88
    dw MessageBank0E_59 ; id 89
    dw MessageBank0E_5A ; id 90
    dw MessageBank0E_5B ; id 91
    dw MessageBank0E_5C ; id 92
    dw MessageBank0E_5D ; id 93
    dw MessageBank0E_5D ; id 94
    dw MessageBank0E_5D ; id 95
    dw MessageBank0E_5D ; id 96
    dw MessageBank0E_5D ; id 97
    dw MessageBank0E_5D ; id 98
    dw MessageBank0E_63 ; id 99
    dw MessageBank0E_64 ; id 100
    dw MessageBank0E_65 ; id 101
    dw MessageBank0E_66 ; id 102
    dw MessageBank0E_67 ; id 103
    dw MessageBank0E_68 ; id 104
    dw MessageBank0E_69 ; id 105
    dw MessageBank0E_6A ; id 106
    dw MessageBank0E_6B ; id 107
    dw MessageBank0E_6C ; id 108
    dw MessageBank0E_6D ; id 109
    dw MessageBank0E_6D ; id 110
    dw MessageBank0E_6D ; id 111
    dw MessageBank0E_6D ; id 112
    dw MessageBank0E_6D ; id 113
    dw MessageBank0E_6D ; id 114
    dw MessageBank0E_73 ; id 115
    dw MessageBank0E_74 ; id 116
    dw MessageBank0E_75 ; id 117
    dw MessageBank0E_76 ; id 118
    dw MessageBank0E_77 ; id 119
    dw MessageBank0E_78 ; id 120
    dw MessageBank0E_79 ; id 121
    dw MessageBank0E_7A ; id 122
    dw MessageBank0E_7B ; id 123
    dw MessageBank0E_7C ; id 124
    dw MessageBank0E_7D ; id 125
    dw MessageBank0E_7D ; id 126
    dw MessageBank0E_7D ; id 127
    dw MessageBank0E_7D ; id 128
    dw MessageBank0E_7D ; id 129
    dw MessageBank0E_7D ; id 130
    dw MessageBank0E_83 ; id 131
    dw MessageBank0E_84 ; id 132
    dw MessageBank0E_85 ; id 133
    dw MessageBank0E_86 ; id 134
    dw MessageBank0E_87 ; id 135

MessageBank0E_00::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault.<WAIT>"
    db "@"

MessageBank0E_0C::
    db "<VOICE1>*: Is it OK to save<LINE>"
    db "the results?@"

MessageBank0E_0D::
    db "<VOICE1>*: Too bad… Let's<LINE>"
    db "meet again.<WAIT>"
    db "@"

MessageBank0E_13::
    db "<VOICE1>*: Who will breed<LINE>"
    db "with my SpikyBoy?@"

MessageBank0E_14::
    db "<VOICE1>*: Would you like<LINE>"
    db "to breed a monster<PROMPT>"
    db "<NEXT>with my SpikyBoy?"
    db "<NEXT>@"

MessageBank0E_15::
    db "<VOICE1>*: This monster?@"

MessageBank0E_16::
    db "<VOICE1>*: A low-level one<LINE>"
    db "can't breed.<WAIT>"
    db "@"

MessageBank0E_17::
    db "<VOICE1>*: Your party won't<LINE>"
    db "have any monsters.<WAIT>"
    db "@"

MessageBank0E_18::
    db "<VOICE1>*: Something huge<LINE>"
    db "will result…<PROMPT>"
    db "<NEXT>Shall we begin the"
    db "<NEXT>breeding?@"

MessageBank0E_19::
    db "<VOICE1>*: Let's get this<LINE>"
    db "started!<WAIT>"
    db "@"

MessageBank0E_1A::
    db "<VOICE1>*: Breeding could<LINE>"
    db "get you unexpected<PROMPT>"
    db "<NEXT>skills. It never"
    db "<NEXT>hurts to breed.<WAIT>"
    db "@"

MessageBank0E_1B::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will result,<PROMPT>"
    db "<NEXT>I think."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Shall we begin<LINE>"
    db "breeding?@"

MessageBank0E_1C::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "now in the Vault.<WAIT>"
    db "@"

MessageBank0E_1D::
    db "<VOICE1>*: What? Well,<LINE>"
    db "that's too bad.<PROMPT>"
    db "<NEXT>Tell me if you"
    db "<NEXT>change your mind.<WAIT>"
    db "@"

MessageBank0E_23::
    db "<VOICE1>*: Which one's going<LINE>"
    db "with my ArmorPede?@"

MessageBank0E_24::
    db "<VOICE1>*: Hey, want to try<LINE>"
    db "breeding a monster<PROMPT>"
    db "<NEXT>of yours with my"
    db "<NEXT>ArmorPede?@"

MessageBank0E_25::
    db "<VOICE1>*: Is this the one<LINE>"
    db "for breeding?@"

MessageBank0E_26::
    db "<VOICE1>*: Don't stick me<LINE>"
    db "with a low-level<PROMPT>"
    db "<NEXT>monster!"
    db "<NEXT>That's not fair!<WAIT>"
    db "@"

MessageBank0E_27::
    db "<VOICE1>*: Who's going to<LINE>"
    db "stay with you?<WAIT>"
    db "@"

MessageBank0E_28::
    db "<VOICE1>*: Huh? Woohoo, I<LINE>"
    db "think this pair is<PROMPT>"
    db "<NEXT>going to make a"
    db "<NEXT>serious monster!<PROMPT>"
    db "<NEXT>All right if we"
    db "<NEXT>get this started?@"

MessageBank0E_29::
    db "<VOICE1>*: Great, let's get<LINE>"
    db "this started.<WAIT>"
    db "@"

MessageBank0E_2A::
    db "<VOICE1>*: If you get an<LINE>"
    db "EvilArmor, breed<PROMPT>"
    db "<NEXT>it with a material"
    db "<NEXT>family partner.<PROMPT>"
    db "<NEXT>Doesn't that sound"
    db "<NEXT>like a tough<PROMPT>"
    db "<NEXT>combo?"
    db "<NEXT><WAIT>"
    db "@"

MessageBank0E_2B::
    db "<VOICE1>*: <BUF0> is<LINE>"
    db "what you'll get.<PROMPT>"
    db "<NEXT>Can we get going"
    db "<NEXT>already?@"

MessageBank0E_2C::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault.<WAIT>"
    db "@"

MessageBank0E_2D::
    db "<VOICE1>*: Hm… That is<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>I hope we will"
    db "<NEXT>meet again.<WAIT>"
    db "@"

MessageBank0E_33::
    db "<VOICE1>*: Which will be my<LINE>"
    db "Gulpple's mate?@"

MessageBank0E_34::
    db "<VOICE1>*: Hello, would you<LINE>"
    db "like to breed one<PROMPT>"
    db "<NEXT>of your monsters"
    db "<NEXT>with my Gulpple?@"

MessageBank0E_35::
    db "<VOICE1>*: Is this your<LINE>"
    db "breeding choice?@"

MessageBank0E_36::
    db "<VOICE1>*: This monster is<LINE>"
    db "too low in level<PROMPT>"
    db "<NEXT>to make an attempt"
    db "<NEXT>at breeding.<WAIT>"
    db "@"

MessageBank0E_37::
    db "<VOICE1>*: You'll have no<LINE>"
    db "monsters with you.<WAIT>"
    db "@"

MessageBank0E_38::
    db "<VOICE1>*: Goodness, I<LINE>"
    db "believe this pair<PROMPT>"
    db "<NEXT>will result in one"
    db "<NEXT>tough offspring.<PROMPT>"
    db "<NEXT>Well, shall we get"
    db "<NEXT>started?@"

MessageBank0E_39::
    db "<VOICE1>*: Ready? Then<LINE>"
    db "let's begin.<WAIT>"
    db "@"

MessageBank0E_3A::
    db "<VOICE1>*: So this pairing<LINE>"
    db "results in this<PROMPT>"
    db "<NEXT>species… I", $44, " better"
    db "<NEXT>record this!<WAIT>"
    db "@"

MessageBank0E_3B::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will be the<PROMPT>"
    db "<NEXT>result.<PROMPT>"
    db "<NEXT>Is it OK to"
    db "<NEXT>proceed?@"

MessageBank0E_3C::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault.<WAIT>"
    db "@"

MessageBank0E_3D::
    db "<VOICE1>*: What? Are you<LINE>"
    db "kidding me?<WAIT>"
    db "@"

MessageBank0E_43::
    db "<VOICE1>*: Hey, matey, want<LINE>"
    db "to breed something<PROMPT>"
    db "<NEXT>with my WildApe?"
    db "<NEXT>@"

MessageBank0E_44::
    db "<VOICE1>*: What'll you put<LINE>"
    db "up for my WildApe?@"

MessageBank0E_45::
    db "<VOICE1>*: Is this one<LINE>"
    db "going to breed?@"

MessageBank0E_46::
    db "<VOICE1>*: Cut me a little<LINE>"
    db "slack here.<PROMPT>"
    db "<NEXT>Nothing too low in"
    db "<NEXT>level, hey?<WAIT>"
    db "@"

MessageBank0E_47::
    db "<VOICE1>*: You'll be all<LINE>"
    db "alone if you do.<WAIT>"
    db "@"

MessageBank0E_48::
    db "<VOICE1>*: Whoa! I can feel<LINE>"
    db "it in my bones,<PROMPT>"
    db "<NEXT>this one will be"
    db "<NEXT>something special.<PROMPT>"
    db "<NEXT>We've got to do"
    db "<NEXT>this, OK?@"

MessageBank0E_49::
    db "<VOICE1>*: Fine! Let's not<LINE>"
    db "waste any time!<WAIT>"
    db "@"

MessageBank0E_4A::
    db "<VOICE1>*: Thanks, matey!<LINE>"
    db "Much obliged!<PROMPT>"
    db "<NEXT>Hope we can do"
    db "<NEXT>this again!<WAIT>"
    db "@"

MessageBank0E_4B::
    db "<VOICE1>*: <BUF0> is<LINE>"
    db "what you'll get.<PROMPT>"
    db "<NEXT>Well, do you want"
    db "<NEXT>to do this?@"

MessageBank0E_4C::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault.<WAIT>"
    db "@"

MessageBank0E_4D::
    db "<VOICE2>*: Ohhh… That is so<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>Well, tell me if"
    db "<NEXT>you reconsider.<WAIT>"
    db "@"

MessageBank0E_53::
    db "<VOICE2>*: Which will be my<LINE>"
    db "FunkyBird's mate?@"

MessageBank0E_54::
    db "<VOICE2>*: Hi, honey! Would<LINE>"
    db "you like to breed<PROMPT>"
    db "<NEXT>a monster with my"
    db "<NEXT>darling FunkyBird?@"

MessageBank0E_55::
    db "<VOICE2>*: Is this monster<LINE>"
    db "OK with you?@"

MessageBank0E_56::
    db "<VOICE2>*: This monster is<LINE>"
    db "way too low-level.<WAIT>"
    db "@"

MessageBank0E_57::
    db "<VOICE2>*: You can't be by<LINE>"
    db "your lonesome!<WAIT>"
    db "@"

MessageBank0E_58::
    db "<VOICE2>*: Oh-oh. It looks<LINE>"
    db "like we'll be<PROMPT>"
    db "<NEXT>getting something"
    db "<NEXT>amazing from this.<PROMPT>"
    db "<NEXT>Is it all right to"
    db "<NEXT>let them breed?@"

MessageBank0E_59::
    db "<VOICE2>*: Wonderful! Let's<LINE>"
    db "begin breeding!<WAIT>"
    db "@"

MessageBank0E_5A::
    db "<VOICE2>*: We might end up<LINE>"
    db "with different<PROMPT>"
    db "<NEXT>monsters, but I"
    db "<NEXT>hope we both get<PROMPT>"
    db "<NEXT>something that'll"
    db "<NEXT>make us happy.<WAIT>"
    db "@"

MessageBank0E_5B::
    db "<VOICE2>*: <BUF0><LINE>"
    db "will be your baby.<PROMPT>"
    db "<NEXT>Should we let them"
    db "<NEXT>breed?@"

MessageBank0E_5C::
    db "<VOICE2>*: Its accessory is<LINE>"
    db "in the Vault now.<WAIT>"
    db "@"

MessageBank0E_5D::
    db "<VOICE1>*: May misfortune<LINE>"
    db "never find you.<PROMPT>"
    db "<NEXT>Come see me if you"
    db "<NEXT>decide to breed.<WAIT>"
    db "@"

MessageBank0E_63::
    db "<VOICE1>*: What will breed<LINE>"
    db "with my Copycat?@"

MessageBank0E_64::
    db "<VOICE1>*: Pardon me, but<LINE>"
    db "would you like to<PROMPT>"
    db "<NEXT>breed a monster"
    db "<NEXT>with my Copycat?@"

MessageBank0E_65::
    db "<VOICE1>*: Is that your<LINE>"
    db "breeding choice?@"

MessageBank0E_66::
    db "<VOICE1>*: A monster can't<LINE>"
    db "be too low in<PROMPT>"
    db "<NEXT>level if you want"
    db "<NEXT>it to breed.<WAIT>"
    db "@"

MessageBank0E_67::
    db "<VOICE1>*: You'll have no<LINE>"
    db "monsters with you.<WAIT>"
    db "@"

MessageBank0E_68::
    db "<VOICE1>*: Well, well, it<LINE>"
    db "looks like a truly<PROMPT>"
    db "<NEXT>spectacular baby"
    db "<NEXT>will result.<PROMPT>"
    db "<NEXT>Well, shall we go"
    db "<NEXT>through with this?@"

MessageBank0E_69::
    db "<VOICE1>*: Ready? Good,<LINE>"
    db "let's begin.<WAIT>"
    db "@"

MessageBank0E_6A::
    db "<VOICE1>*: There is an old<LINE>"
    db "saying: The more<PROMPT>"
    db "<NEXT>you have, the less"
    db "<NEXT>you need.<PROMPT>"
    db "<NEXT>Indeed, the more"
    db "<NEXT>monsters you have,<PROMPT>"
    db "<NEXT>the stronger a"
    db "<NEXT>master you are.<WAIT>"
    db "@"

MessageBank0E_6B::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will be the<PROMPT>"
    db "<NEXT>progeny.<PROMPT>"
    db "<NEXT>Well, shall we go"
    db "<NEXT>through with this?@"

MessageBank0E_6C::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault now.<WAIT>"
    db "@"

MessageBank0E_6D::
    db "<VOICE2>*: No? That makes<LINE>"
    db "me feel sad.<PROMPT>"
    db "<NEXT>If you reconsider,"
    db "<NEXT>come back.<WAIT>"
    db "@"

MessageBank0E_73::
    db "<VOICE2>*: What's going to<LINE>"
    db "be with Andreal?@"

MessageBank0E_74::
    db "<VOICE2>*: Hi! How would<LINE>"
    db "you like to breed<PROMPT>"
    db "<NEXT>a monster with my"
    db "<NEXT>Andreal?@"

MessageBank0E_75::
    db "<VOICE2>*: Is this monster<LINE>"
    db "OK with you?@"

MessageBank0E_76::
    db "<VOICE2>*: That one's too<LINE>"
    db "low-level, dear.<WAIT>"
    db "@"

MessageBank0E_77::
    db "<VOICE2>*: You can't go off<LINE>"
    db "all alone.<WAIT>"
    db "@"

MessageBank0E_78::
    db "<VOICE2>*: …You know, I<LINE>"
    db "think we're going<PROMPT>"
    db "<NEXT>to see an awesome"
    db "<NEXT>baby out of this.<PROMPT>"
    db "<NEXT>We should let this"
    db "<NEXT>pair breed.@"

MessageBank0E_79::
    db "<VOICE2>*: Good, let's get<LINE>"
    db "this started.<WAIT>"
    db "@"

MessageBank0E_7A::
    db "<VOICE2>*: People will be<LINE>"
    db "jealous when they<PROMPT>"
    db "<NEXT>find out I got to"
    db "<NEXT>breed monsters<PROMPT>"
    db "<NEXT>with a famous"
    db "<NEXT>master like you.<PROMPT>"
    db "<NEXT>Let me give you a"
    db "<NEXT>little kiss!<WAIT>"
    db "@"

MessageBank0E_7B::
    db "<VOICE2>*: <BUF0><LINE>"
    db "will be your baby.<PROMPT>"
    db "<NEXT>Is it OK to let"
    db "<NEXT>them breed?@"

MessageBank0E_7C::
    db "<VOICE2>*: Its accessory is<LINE>"
    db "now in the Vault.<WAIT>"
    db "@"

MessageBank0E_7D::
    db "<VOICE1>*: Whaaat?<LINE>"
    db "You're serious?<PROMPT>"
    db "<NEXT>Well, maybe we'll"
    db "<NEXT>meet again.<WAIT>"
    db "@"

MessageBank0E_83::
    db "<VOICE1>*: What'll you pair<LINE>"
    db "with my Skeletor?@"

MessageBank0E_84::
    db "<VOICE1>*: Hey, kid.<LINE>"
    db "Want to breed a<PROMPT>"
    db "<NEXT>monster of yours"
    db "<NEXT>with my Skeletor?@"

MessageBank0E_85::
    db "<VOICE1>*: Is that what<LINE>"
    db "you're picking?@"

MessageBank0E_86::
    db "<VOICE1>*: No, no. Nothing<LINE>"
    db "low in level.<WAIT>"
    db "@"

MessageBank0E_87::
    db "<VOICE1>*: You'll be without<LINE>"
    db "a monster.<WAIT>"
    db "@"

; Starts showing string wStringIndex of category wStringCategory from the breeding text table
; BeginStringDisplay_Bank0E_StringCategories (Text_ReadyToStartBreeding, Text_YouRefusedBreeding,
; Text_PleaseWait and the rest) by calling BeginStringDisplay with DE at that table.
; ShowString_Bank0E, the debug menu, the link breeding code (bank $37) and a bank-$F1 screen call
; it. The seven bytes after its ret are an unreachable copy of the same call shape. (C1, E-0376)
; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank0E::
    ld de, BeginStringDisplay_Bank0E_StringCategories
    call BeginStringDisplay
    ret

SECTION "Bank 0E CopyStringToBuffer_Bank0E_2", ROMX

; Loads DE = BeginStringDisplay_Bank0E_StringCategories, the string table of
; BeginStringDisplay_Bank0E, and calls CopyStringToBuffer: string wStringIndex of category
; wStringCategory is copied with its $F0 end to the address in wStringDestLo/Hi. It pairs with
; BeginStringDisplay_Bank0E like the other CopyStringToBuffer stubs of the string banks. No traced
; code, jump table or pointer reaches it (E-0395: it decodes as a routine but is unreached in the
; static listing). (C2, E-0395; probed E-0395)
CopyStringToBuffer_Bank0E_2:: ; configured code entry (E-0395); C0
    ld de, BeginStringDisplay_Bank0E_StringCategories
    call CopyStringToBuffer
    ret

SECTION "Bank 0E ShowString_Bank0E", ROMX

; Shows a breeding text at once: BeginStringDisplay_Bank0E (string wStringIndex of the table
; BeginStringDisplay_Bank0E_StringCategories), then RunStringDisplayToEnd, which runs the text
; printer until the whole string is printed. Called from the link breeding code (bank $37) and the
; bank-$F1 and $F2 screens. (C1, E-0376)
; BeginStringDisplay_Bank0E (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank0E::
    call BeginStringDisplay_Bank0E
    call RunStringDisplayToEnd
    ret

SECTION "Bank 0E BeginStringDisplay_Bank0E_StringCategories", ROMX

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank0E_StringCategories::
    dw StringList_Bank0E_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank0E_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank0E_StringCategories_0::
    dw Text_ReadyToStartBreeding ; id 0
    dw Text_ReadyToStartBreeding ; id 1
    dw Text_YouRefusedBreeding ; id 2
    dw Text_YourPalRefusedBreeding ; id 3
    dw Text_IsThisOneOK ; id 4
    dw Text_ThisOneIsToo ; id 5
    dw Text_ChooseFromTheFarms ; id 6
    dw Text_PleaseWait ; id 7
    dw Text_IdenticalGendersCantBreed ; id 8
    dw Text_ChooseTheMonsterFor ; id 9
    dw Text_TheCoupleIsIncompatible ; id 10
    dw Text_ProceedWithBreeding ; id 11
    dw Text_IsItOKTo ; id 12
    dw Text_TheMonstersLikeEach ; id 13
    dw Text_InfoOK ; id 14
    dw Text_BredInfoExit ; id 15
    dw Text_ATKDEFGLINWMextvlBas ; id 16
    dw Text_BreedingWentWrongSomehow ; id 17
    dw Text_TheGameLinkFailed ; id 18
    dw Text_YouRefusedBreeding_2 ; id 19
    dw Text_YourPalRefusedBreeding_2 ; id 20
    dw Text_ForBreedingWithTerrys ; id 21
    dw Text_AccessoriesWillBeIn ; id 22

Text_ReadyToStartBreeding::
    db "Ready to start<LINE>"
    db "breeding.<PROMPT>"
    db "@"

Text_YouRefusedBreeding::
    db "You refused<LINE>"
    db "breeding.<PROMPT>"
    db "@"

Text_YourPalRefusedBreeding::
    db "Your pal refused<LINE>"
    db "breeding.<PROMPT>"
    db "@"

Text_IsThisOneOK::
    db "Is this one OK for<LINE>"
    db "breeding?@"

Text_ThisOneIsToo::
    db "This one is too<LINE>"
    db "young to breed.<PROMPT>"
    db "<NEXT>It needs to be"
    db "<NEXT>leveled up more.<PROMPT>"
    db "@"

Text_ChooseFromTheFarms::
    db "Choose from the<LINE>"
    db "farm's roster.<PROMPT>"
    db "@"

Text_PleaseWait::
    db "Please wait.@"

Text_IdenticalGendersCantBreed::
    db "Identical genders<LINE>"
    db "can't breed.<PROMPT>"
    db "@"

Text_ChooseTheMonsterFor::
    db "Choose the monster<LINE>"
    db "for breeding.@"

Text_TheCoupleIsIncompatible::
    db "The couple is<LINE>"
    db "incompatible.<PROMPT>"
    db "@"

Text_ProceedWithBreeding::
    db "Proceed with<LINE>"
    db "breeding?@"

Text_IsItOKTo::
    db "Is it OK to record<LINE>"
    db "the results?@"

Text_TheMonstersLikeEach::
    db "The monsters like<LINE>"
    db "each other.<PROMPT>"
    db "<NEXT>Breeding will be"
    db "<NEXT>started.@"

Text_InfoOK::
    db "InfoOK@"

Text_BredInfoExit::
    db "BredInfoExit@"

Text_ATKDEFGLINWMextvlBas::
    db "ATKDEFGLINWMextvlBas        + @"

Text_BreedingWentWrongSomehow::
    db "Breeding went<LINE>"
    db "wrong somehow.<PROMPT>"
    db "<NEXT>Breeding will be"
    db "<NEXT>canceled.<WAIT>"
    db "@"

Text_TheGameLinkFailed::
    db "The Game Link<LINE>"
    db "failed.<PROMPT>"
    db "<NEXT>Breeding will be"
    db "<NEXT>canceled.<WAIT>"
    db "@"

Text_YouRefusedBreeding_2::
    db "You refused<LINE>"
    db "breeding.@"

Text_YourPalRefusedBreeding_2::
    db "Your pal refused<LINE>"
    db "breeding.@"

Text_ForBreedingWithTerrys::
    db "For breeding with<LINE>"
    db "Terry's monsters.<WAIT>"
    db "@"

Text_AccessoriesWillBeIn::
    db "<VOICE1>*: Accessories will<LINE>"
    db "be in the Vault.<WAIT>"
    db "@"

; Builds the bred child in wChildRecord (cleared first) from parents wRecordBufA and wRecordBufB;
; wArg1 = kind (0 farm breeding, 1 a townsperson, 2 link breeding). The species comes from the first
; match of: BreedSpeciesRuleTable[A species] (mate species, with $FD moving to the next result,
; $FE/$FC needing B / A plus at least the low byte and both parents of one species, $FB acting like
; $FD for kind 2 and ending the list otherwise) giving BreedSpeciesResultTable;
; BreedFamilyRuleTable[A species] (mate families) giving BreedFamilyResultTable;
; FamilyBreedRuleTable[A family] giving FamilyBreedResultTable; else FamilyPairResultTable[A
; family][B family], where $FFxx means parent A species and $FExx ends with wArg6/7 = $FFFF and
; wNameEntryState = 6. Then MON_FAMILY = FamilyForSpeciesIdArg6 OR (bit 0 of A MON_SEX) << 4;
; MON_STATE, MON_LEVEL and MON_EGG = 1; MON_MASTER_ID = wPlayerId; the parent names, master names,
; species and pluses and the player name are copied; HP, max HP, MP, max MP, ATK, DEF, AGL and INT
; become (A + B) / 4 of the max HP, max MP, ATK, DEF, AGL and INT words
; (AdjustStatForRecordBufAAndBItems first); each personality byte is the 8-bit (A + B) / 2. MON_PLUS
; = A plus (kind non-zero) or the larger plus, + 1 to 5 by the level sum (40, 60, 76, 100), capped
; at 99; MON_MAX_LEVEL = SPECIES_MAX_LEVEL + 3 * plus, capped at 99. Last it runs
; RollChildSexFromSpecies, ApplyBreedingBonusToChildStats,
; RollChildResistancesToChildRecordResistances and BuildChildRecordSkillListCandidateList, adds 1 to
; wNameEntryState and sets wArg5 = $FF; the species is left in wArg6/wArg7. (C2, E-0376)
; clears the child record wChildRecord and fills it from the two parents (wRecordBufA + $B,
; wRecordBufB + $B): species from the breeding table BreedSpeciesRuleTable, then names, skills,
; resistances and stat bonuses (E-0131) (C2 from E-0328: in BreedMenu's preview, base Gulpple
; (family 4) with a family-3 mate gives WingTree and with a family-5 mate CactiBall,
; FamilyPairResultTable[4][3] and [4][5], since neither species has a rule list; the hatched child
; is level 1 with the user's name as master)
ComputeBreedingChild::
    ld hl, wChildRecord
    ld b, $a5

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wRecordBufA + MON_SPECIES
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedSpeciesRuleTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + MON_SPECIES
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld c, $00

.next:
    inc hl
    ld a, [hl]
    cp $ff
    jr z, .skip2
    cp $fe
    jr z, .next3
    cp $fd
    jr z, .next4
    cp $fc
    jr z, .next2
    cp $fb
    jr z, .check_arg1
    dec hl
    push hl
    ld a, [hli]
    cp e
    jr nz, .restore
    ld a, [hl]
    cp d
    jr nz, .restore
    jp .restore2

.check_arg1:
    ld a, [wArg1]
    cp $02
    jr nz, .skip2
    jr .next4

.next2:
    dec hl
    push hl
    ld b, [hl]
    ld hl, wRecordBufA + MON_PLUS
    jr .skip

.next3:
    dec hl
    push hl
    ld b, [hl]
    ld hl, wRecordBufB + MON_PLUS

.skip:
    ld a, [hl]
    cp b
    jp nc, .read_record_buf_a
    jr .restore

.read_record_buf_a:
    ld a, [wRecordBufA + MON_SPECIES]
    ld l, a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld h, a
    ld a, [wRecordBufB + MON_SPECIES]
    cp l
    jr nz, .restore
    ld a, [wRecordBufB + MON_SPECIES + 1]
    cp h
    jr nz, .restore
    jr .restore2

.next4:
    dec hl
    push hl
    inc c

.restore:
    pop hl
    inc hl
    inc hl
    jr .next

.skip2:
    jp .skip3

.restore2:
    pop hl
    push bc
    ld hl, wRecordBufA + MON_SPECIES
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedSpeciesResultTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp .read_arg6

.skip3:
    ld hl, wRecordBufA + MON_SPECIES
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedFamilyRuleTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + MON_FAMILY
    ld a, [hl]
    and $0f
    ld e, a
    pop hl
    ld c, $00

.skip4:
    ld a, [hl]
    cp $ff
    jr z, .skip6
    cp $fe
    jr z, .check_arg12
    jr .skip5

.check_arg12:
    ld a, [wArg1]
    cp $02
    jr nz, .skip6
    inc hl
    inc c
    jr .skip4

.skip5:
    push hl
    ld a, [hl]
    cp e
    jr nz, .restore3
    jp .restore4

.restore3:
    pop hl
    inc hl
    inc c
    jr .skip4

.skip6:
    jp .skip7

.restore4:
    pop hl
    push bc
    ld hl, wRecordBufA + MON_SPECIES
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedFamilyResultTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp .read_arg6

.skip7:
    ld hl, wRecordBufA + MON_FAMILY
    ld a, [hl]
    and $0f
    add a
    ld hl, FamilyBreedRuleTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + MON_SPECIES
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld c, $00

.next5:
    inc hl
    ld a, [hl]
    cp $ff
    jr z, .skip8
    cp $fd
    jr z, .next6
    dec hl
    push hl
    ld a, [hli]
    cp e
    jr nz, .restore5
    ld a, [hl]
    cp d
    jr nz, .restore5
    jp .restore6

.next6:
    dec hl
    push hl
    inc c

.restore5:
    pop hl
    inc hl
    inc hl
    jr .next5

.skip8:
    jp .skip9

.restore6:
    pop hl
    push bc
    ld hl, wRecordBufA + MON_FAMILY
    ld a, [hl]
    and $0f
    add a
    ld hl, FamilyBreedResultTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp .read_arg6

.skip9:
    ld hl, wRecordBufA + MON_FAMILY
    ld a, [hl]
    and $0f
    add a
    ld hl, FamilyPairResultTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + MON_FAMILY
    ld a, [hl]
    and $0f
    pop hl
    add a
    add_a_to_hl
    inc hl
    ld a, [hl]
    cp $ff
    jr z, .set_arg6
    cp $fe
    jr z, .set_arg6_to_FF
    dec hl
    ld a, [hli]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp .read_arg6

.set_arg6_to_FF:
    ld a, $ff
    ld [wArg6], a
    ld a, $ff
    ld [wArg7], a
    ld a, $06
    ld [wNameEntryState], a
    ld a, $ff
    ld [wArg5], a
    ret

.set_arg6:
    ld hl, wRecordBufA + MON_SPECIES
    ld a, [hli]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp .read_arg6

.read_arg6:
    ld hl, wChildRecord + MON_SPECIES
    ld a, [wArg6]
    ld [hli], a
    ld a, [wArg7]
    ld [hl], a
    ld hl, wRecordBufA + MON_SEX
    ld a, [hl]
    and $01
    swap a
    ld b, a
    push bc
    call FamilyForSpeciesIdArg6
    ld a, [wArg5]
    pop bc
    or b
    ld b, a
    ld hl, wChildRecord + MON_FAMILY
    ld [hl], b
    xor a
    ld hl, wChildRecord + MON_STATUS
    ld [hl], a
    ld hl, wChildRecord + MON_ITEM
    ld [hl], a
    ld hl, wChildRecord + MON_EXP
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wPlayerId]
    ld hl, wChildRecord + MON_MASTER_ID
    ld [hl], a
    ld a, $01
    ld hl, wChildRecord + MON_LEVEL
    ld [hl], a
    ld hl, wChildRecord
    ld [hl], a
    ld hl, wChildRecord + MON_EGG
    ld [hl], a
    call CopyFourNamesByChildRecordFamilyBit4Table
    call CopyPlayerNameToChildRecordMasterName
    call CopySixBytesByChildRecordFamilyBit4Table
    ld hl, wRecordBufA
    ld de, wRecordBufB
    ld c, $00
    ld b, $08

.loop2:
    push hl
    ld a, c
    ld hl, ComputeBreedingChild_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    push hl
    add_a_to_hl
    push de
    ld a, c
    ld de, ComputeBreedingChild_Data
    add e
    ld e, a
    jr nc, .skip10
    inc d

.skip10:
    ld a, [de]
    pop de
    push de
    add e
    ld e, a
    jr nc, .skip11
    inc d

.skip11:
    push bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld e, c
    ld d, b
    pop bc
    push bc
    call AdjustStatForRecordBufAAndBItems
    add hl, de
    srl h
    rr l
    srl h
    rr l
    pop bc
    push bc
    ld de, wChildRecord + MON_HP
    ld a, c
    add a
    add e
    ld e, a
    jr nc, .skip12
    inc d

.skip12:
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    pop bc
    pop de
    pop hl
    inc c
    dec b
    jr nz, .loop2
    ld a, $6f
    add_a_to_hl
    ld a, $6f
    add e
    ld e, a
    jr nc, .skip13
    inc d

.skip13:
    ld c, $00
    ld b, $04

.loop3:
    push hl
    push de
    push bc
    ld b, [hl]
    ld a, [de]
    add b
    srl a
    ld e, a
    pop bc
    push bc
    ld hl, wChildRecord + MON_PERSONALITY
    ld a, c
    add_a_to_hl
    ld [hl], e
    pop bc
    pop de
    pop hl
    inc hl
    inc de
    inc c
    dec b
    jr nz, .loop3
    ld hl, wRecordBufA + MON_PLUS
    ld de, wRecordBufB + MON_PLUS
    ld a, [wArg1]
    and a
    jr z, .skip14
    ld a, [hl]
    jr .skip15

.skip14:
    ld b, [hl]
    ld a, [de]
    cp b
    jr nc, .skip15
    ld a, [hl]

.skip15:
    ld b, a
    push bc
    ld hl, wRecordBufA + MON_LEVEL
    ld de, wRecordBufB + MON_LEVEL
    ld b, [hl]
    ld a, [de]
    add b
    cp $64
    jr nc, .skip16
    cp $4c
    jr nc, .skip17
    cp $3c
    jr nc, .skip18
    cp $28
    jr nc, .skip19
    ld b, $01
    jr .skip20

.skip16:
    ld b, $05
    jr .skip20

.skip17:
    ld b, $04
    jr .skip20

.skip18:
    ld b, $03
    jr .skip20

.skip19:
    ld b, $02

.skip20:
    ld a, b
    pop bc
    add b
    cp $64
    jr c, .skip21
    ld a, $63

.skip21:
    ld hl, wChildRecord + MON_PLUS
    ld [hl], a
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld b, a
    push bc
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    ld c, $03
    call Multiply8
    pop bc
    ld a, b
    add_a_to_hl
    ld a, h
    and a
    jr z, .skip22
    ld a, $63
    jr .call_roll_child_sex_from_species

.skip22:
    ld a, l
    cp $64
    jr c, .call_roll_child_sex_from_species
    ld a, $63

.call_roll_child_sex_from_species:
    ld hl, wChildRecord + MON_MAX_LEVEL
    ld [hl], a
    call RollChildSexFromSpecies
    call ApplyBreedingBonusToChildStats
    call RollChildResistancesToChildRecordResistances
    call BuildChildRecordSkillListCandidateList
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    ld a, $ff
    ld [wArg5], a
    ret

SECTION "Bank 0E AdjustStatForRecordBufAAndBItems", ROMX

; C = stat index 0-7 (in the order of ComputeBreedingChild_Data), DE = parent A stat word, HL =
; parent B stat word: when the MON_ITEM of wRecordBufA is in the list
; AdjustStatForRecordBufAAndBItems_Data1[C] (items 1-2 for stats 0-1, 3-4 for 2-3, 5-6 for 4, 7, 8
; and $14 for 5, 9-$A for 6, $B-$C for 7) it subtracts AdjustStatForRecordBufAAndBItems_Data2[item]
; (30, 80, 10, 50, 5 and so on) from DE, and the same for the item of wRecordBufB and HL. A value
; with high byte 3 or more and low byte $E7 or more (999) is not reduced; the 16-bit subtraction
; does not stop at 0. C is kept. (C2, E-0376)
; when wRecordBufA + $A4 or wRecordBufB + $A4 is set and listed for stat C
; (AdjustStatForRecordBufAAndBItems_Data1), subtracts AdjustStatForRecordBufAAndBItems_Data2[value]
; from DE (unless it is at 999) (E-0130) (E-0340: the address in its name read as its RAM name; was
; AdjustStatForRecordBufAAndBItems) (E-0345: $CA2A and $CACF are the MON_ITEM of wRecordBufA and
; wRecordBufB; was AdjustStatForRecordBufAAndBItems)
AdjustStatForRecordBufAAndBItems::
    ld a, [wRecordBufA + MON_ITEM]
    and a
    jr z, .check_record_buf_b2
    ld b, a
    push hl
    ld a, c
    add a
    ld hl, AdjustStatForRecordBufAAndBItems_Data1
    add_a_to_hl
    push de
    ld e, [hl]
    inc hl
    ld d, [hl]

.skip:
    ld a, [de]
    cp $ff
    jr z, .restore
    cp b
    jr z, .restore2
    inc de
    jr .skip

.restore:
    pop de
    jr .check_record_buf_b

.restore2:
    pop de
    ld a, d
    cp $03
    jr c, .skip2
    ld a, e
    cp $e7
    jr c, .skip2
    jr .check_record_buf_b

.skip2:
    ld a, b
    ld hl, AdjustStatForRecordBufAAndBItems_Data2
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld a, e
    sub b
    ld e, a
    ld a, d
    sbc $00
    ld d, a

.check_record_buf_b:
    pop hl

.check_record_buf_b2:
    ld a, [wRecordBufB + MON_ITEM]
    and a
    ret z
    ld b, a
    push de
    ld a, c
    add a
    ld de, AdjustStatForRecordBufAAndBItems_Data1
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a

.skip4:
    ld a, [hl]
    cp $ff
    jr z, .restore3
    cp b
    jr z, .restore4
    inc hl
    jr .skip4

.restore3:
    pop hl
    jr .done

.restore4:
    pop hl
    ld a, h
    cp $03
    jr c, .skip5
    ld a, l
    cp $e7
    jr c, .skip5
    jr .done

.skip5:
    ld a, b
    ld de, AdjustStatForRecordBufAAndBItems_Data2
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [de]
    ld b, a
    ld a, l
    sub b
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.done:
    pop de
    ret

SECTION "Bank 0E AdjustStatForRecordBufAAndBItems_Data1", ROMX

; Eight word pointers, one per stat index c = 0-7 in the order of the child record stat words from
; MON_HP: HP, max HP, MP, max MP, ATK, DEF, AGL and INT. Each points at a list of MON_ITEM values
; ending in $FF (the _Entry00 to _Entry07 labels below; stats 0-1 share one list and stats 2-3 share
; another). AdjustStatForRecordBufAAndBItems searches the list of stat c for the MON_ITEM of each
; parent record. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1::
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry00
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry00
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry02
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry02
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry04
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry05
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry06
    dw AdjustStatForRecordBufAAndBItems_Data1_Entry07

; The $FF-terminated list of MON_ITEM values $01 and $02, the items that matter for stat indexes 0
; and 1 (HP and max HP). When a parent record MON_ITEM is in the list,
; AdjustStatForRecordBufAAndBItems subtracts the amount AdjustStatForRecordBufAAndBItems_Data2 gives
; for that item from the parent stat word. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1_Entry00::
    db $01, $02, $ff

; The $FF-terminated list of MON_ITEM values $03 and $04, the items that matter for stat indexes 2
; and 3 (MP and max MP). A parent MON_ITEM in the list makes AdjustStatForRecordBufAAndBItems
; subtract that item amount from AdjustStatForRecordBufAAndBItems_Data2 from the parent stat word.
; (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1_Entry02::
    db $03, $04, $ff

; The $FF-terminated list of MON_ITEM values $05 and $06, the items that matter for stat index 4
; (ATK). A parent MON_ITEM in the list makes AdjustStatForRecordBufAAndBItems subtract that item
; amount from AdjustStatForRecordBufAAndBItems_Data2 from the parent ATK word. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1_Entry04::
    db $05, $06, $ff

; The $FF-terminated list of MON_ITEM values $07, $08 and $14, the items that matter for stat index
; 5 (DEF). A parent MON_ITEM in the list makes AdjustStatForRecordBufAAndBItems subtract that item
; amount from AdjustStatForRecordBufAAndBItems_Data2 from the parent DEF word. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1_Entry05::
    db $07, $08, $14, $ff

; The $FF-terminated list of MON_ITEM values $09 and $0A, the items that matter for stat index 6
; (AGL). A parent MON_ITEM in the list makes AdjustStatForRecordBufAAndBItems subtract that item
; amount from AdjustStatForRecordBufAAndBItems_Data2 from the parent AGL word. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1_Entry06::
    db $09, $0a, $ff

; The $FF-terminated list of MON_ITEM values $0B and $0C, the items that matter for stat index 7
; (INT). A parent MON_ITEM in the list makes AdjustStatForRecordBufAAndBItems subtract that item
; amount from AdjustStatForRecordBufAAndBItems_Data2 from the parent INT word. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data1_Entry07::
    db $0b, $0c, $ff

; Twenty-two bytes indexed by a MON_ITEM value (0-$15): the amount subtracted from a parent stat
; word. Non-zero entries are item 1 = 30, 2 = 80, 3 = 30, 4 = 80, 5 = 10, 6 = 50, 7 = 10, 8 = 50, 9
; = 10, $A = 50, $B = 50, $C = 100 and $14 = 5; all others are 0. AdjustStatForRecordBufAAndBItems
; subtracts it (16-bit, no floor at 0) unless the stat is already 999 or more. (C1, E-0381)
AdjustStatForRecordBufAAndBItems_Data2::
    db $00, $1e, $50, $1e, $50, $0a, $32, $0a, $32, $0a, $32, $32, $64, $00, $00, $00
    db $00, $00, $00, $00, $05, $00

; Fills the MON_SKILLS of wChildRecord with $FF and builds its 25-byte MON_SKILL_LIST: the three
; natural skills (species bytes 8-10, LoadSpeciesBytes8To10FromHL) of the child, parent A and parent
; B species, then the eight MON_SKILLS bytes of wRecordBufA and of wRecordBufB. It maps each through
; SkillLineBaseTable (MapChildRecordSkillListEntriesThroughTable), turns zeros and repeats into $FF
; (ClearDuplicateChildSkills), moves the rest to the front (CompactChildRecordSkillListRemovingFF)
; and clears repeats again. (C2, E-0376)
; fills wChildRecord + $34 with $FF, appends species bytes 8-10 of wChildRecord + $B, wRecordBufA +
; $B and wRecordBufB + $B and eight bytes each from wRecordBufA + $34 and wRecordBufB + $34 to
; wChildRecord + $3C, maps them through SkillLineBaseTable and compacts the list (E-0124) (E-0340:
; the address in its name read as its RAM name; was BuildChildRecordSkillListCandidateList)
BuildChildRecordSkillListCandidateList::
    ld hl, wChildRecord + MON_SKILLS
    ld c, $08

.loop:
    ld a, $ff
    ld [hli], a
    dec c
    jr nz, .loop
    ld hl, wChildRecord + MON_SPECIES
    call LoadSpeciesBytes8To10FromHL
    ld hl, wChildRecord + MON_SKILL_LIST
    call StoreBCAAtHL
    push hl
    ld hl, wRecordBufA + MON_SPECIES
    call LoadSpeciesBytes8To10FromHL
    pop hl
    call StoreBCAAtHL
    push hl
    ld hl, wRecordBufB + MON_SPECIES
    call LoadSpeciesBytes8To10FromHL
    pop hl
    call StoreBCAAtHL
    ld de, wRecordBufA + MON_SKILLS
    call CopyEightBytesDEToHL
    ld de, wRecordBufB + MON_SKILLS
    call CopyEightBytesDEToHL
    call MapChildRecordSkillListEntriesThroughTable
    call ClearDuplicateChildSkills
    call CompactChildRecordSkillListRemovingFF
    call ClearDuplicateChildSkills
    ret

SECTION "Bank 0E MapChildRecordSkillListEntriesThroughTable", ROMX

; Replaces each of the 25 ($19) bytes of the MON_SKILL_LIST of wChildRecord other than $FF by
; SkillLineBaseTable[byte], the first skill of its line (1-3 become 1, 4-6 become 4). The table has
; 176 entries (skills 0-$AF); a larger byte would read past it. (C2, E-0376)
; replaces each of the $19 bytes at wChildRecord + $3C (other than $FF) by SkillLineBaseTable[byte]
; (E-0124) (E-0340: the address in its name read as its RAM name; was
; MapChildRecordSkillListEntriesThroughTable) (E-0344: the address in its name dropped or read as
; the label there; was MapChildRecordSkillListEntriesThroughTable)
MapChildRecordSkillListEntriesThroughTable::
    ld hl, wChildRecord + MON_SKILL_LIST
    ld c, $19

.loop:
    ld a, [hl]
    cp $ff
    jr z, .next
    ld de, SkillLineBaseTable
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hl], a

.next:
    inc hl
    dec c
    jr nz, .loop
    ret

SECTION "Bank 0E SkillLineBaseTable", ROMX

; MapChildRecordSkillListEntriesThroughTable replaces each of the $19 skill bytes at wChildRecord +
; $3C (other than $FF) by the byte at $5B03 + skill; the values never exceed the index and repeat
; for runs of related skills (for example 1-3 map to 1, 4-6 to 4), so the table maps a skill to the
; first of its line; 176 entries, skills 0-$AF (E-0200, C1)
; record: replacement skill numbers for skills $X0-$XF (X = id)
SkillLineBaseTable::
    db $00, $01, $01, $01, $04, $04, $04, $07, $07, $07, $0a, $0a, $0a, $0d, $0d, $0d ; id 0
    db $10, $10, $10, $13, $13, $15, $16, $16, $16, $19, $19, $1b, $1b, $1b, $1e, $1e ; id 1
    db $20, $21, $22, $23, $24, $25, $25, $27, $27, $29, $29, $2b, $2b, $2d, $2e, $2f ; id 2
    db $2f, $31, $32, $33, $34, $35, $36, $36, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f ; id 3
    db $40, $40, $40, $40, $44, $44, $44, $44, $48, $48, $4a, $4b, $4c, $4c, $4e, $4e ; id 4
    db $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f ; id 5
    db $60, $61, $62, $63, $63, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $6e, $6f ; id 6
    db $70, $71, $72, $73, $73, $75, $76, $76, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f ; id 7
    db $80, $81, $82, $83, $84, $85, $85, $85, $85, $89, $8a, $8b, $8b, $8d, $8d, $8f ; id 8
    db $90, $91, $92, $93, $94, $95, $96, $97, $97, $99, $99, $9b, $9c, $9d, $9e, $9f ; id 9
    db $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af ; id 10

; Moves the bytes other than $FF of the 25-byte MON_SKILL_LIST of wChildRecord to its front, in
; order. The places after them are not refilled, so they keep their old bytes (a moved skill can
; appear again further on); BuildChildRecordSkillListCandidateList runs ClearDuplicateChildSkills
; afterwards to clear those. (C2, E-0376)
; moves the non-$FF bytes of the $19-byte list at wChildRecord + $3C to its front (E-0124) (E-0340:
; the address in its name read as its RAM name; was CompactChildRecordSkillListRemovingFF)
CompactChildRecordSkillListRemovingFF::
    ld hl, wChildRecord + MON_SKILL_LIST
    ld de, wChildRecord + MON_SKILL_LIST
    ld c, $19

.loop:
    ld a, [hl]
    cp $ff
    jr nz, .skip
    inc hl
    dec c
    jr nz, .loop
    ret

.skip:
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, .loop
    ret

SECTION "Bank 0E ClearDuplicateChildSkills", ROMX

; Walks the 25 ($19) bytes of the child's skill list at wChildRecord + MON_SKILL_LIST: a byte of 0
; or $FF becomes $FF, and for every other byte each later byte equal to it is set to $FF, so each
; skill stays only at its first place. No inputs; clobbers A, BC, DE, HL.
; BuildChildRecordSkillListCandidateList calls it before and after
; CompactChildRecordSkillListRemovingFF. (C2, E-0372; probed E-0376)
; in the child's skill list (wChildRecord + MON_SKILL_LIST, 25 entries) turns zeros and repeated
; skills into $FF (E-0340: the address in its name read as its RAM name; was
; ClearDuplicateChildSkills)
ClearDuplicateChildSkills::
    ld hl, wChildRecord + MON_SKILL_LIST
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .skip
    cp $ff
    jr z, .skip
    jr .skip2

.skip:
    ld a, $ff
    ld [hl], a
    jr .next2

.skip2:
    ld b, a
    push hl
    ld a, c
    cp $19
    jr z, .restore
    ld e, a
    inc hl

.loop2:
    ld a, [hl]
    cp b
    jr nz, .next
    ld a, $ff
    ld [hl], a

.next:
    inc hl
    inc e
    ld a, e
    cp $19
    jr c, .loop2

.restore:
    pop hl

.next2:
    inc hl
    inc c
    ld a, c
    cp $19
    jr c, .loop
    ret

SECTION "Bank 0E CopyEightBytesDEToHL", ROMX

; Copies 8 bytes from DE to HL; DE and HL end past them, C = 0, A = the last byte.
; BuildChildRecordSkillListCandidateList uses it to append the MON_SKILLS of both parents to the
; skill list of the child. (C2, E-0376)
; copies 8 bytes from DE to HL (E-0122)
CopyEightBytesDEToHL::
    ld c, $08

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, .loop
    ret

SECTION "Bank 0E StoreBCAAtHL", ROMX

; Stores B, C and A at HL, HL + 1 and HL + 2 and leaves HL past them; A and the flags are kept.
; BuildChildRecordSkillListCandidateList stores three natural skills with it. (C2, E-0376)
; stores B, C and A at HL onward; HL += 3; AF kept (E-0114)
StoreBCAAtHL::
    push af
    ld a, b
    ld [hli], a
    ld a, c
    ld [hli], a
    pop af
    ld [hli], a
    ret

SECTION "Bank 0E LoadSpeciesBytes8To10FromHL", ROMX

; HL = address of a monster id word: sets wSpeciesIdLo/Hi from it, far-calls LoadSpeciesRecord and
; returns B, C and A = SPECIES_SKILLS bytes 0, 1 and 2 of wSpeciesRecord (the three natural skills).
; (C2, E-0376)
; monster id = the word at HL: LoadSpeciesRecord, then B = species byte 8, C = byte 9, A = byte 10
; (wSpeciesRecord + $8-wSpeciesRecord + $A) (E-0117)
LoadSpeciesBytes8To10FromHL::
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld b, a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld c, a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ret

SECTION "Bank 0E LoadSpeciesBytes8To10ToArg5", ROMX

; Monster id = wArg1 (low) / wArg2 (high): far-calls LoadSpeciesRecord and copies its three natural
; skills (SPECIES_SKILLS) to wArg5, wArg6 and wArg7. Called from the library code in bank $0C. (C2,
; E-0376)
; monster id = wArg1/wArg2: LoadSpeciesRecord, then copies species bytes 8-10 to wArg5-wArg7
; (E-0117)
LoadSpeciesBytes8To10ToArg5::
    ld a, [wArg1]
    ld [wSpeciesIdLo], a
    ld a, [wArg2]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [wArg5], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [wArg6], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [wArg7], a
    ret

SECTION "Bank 0E RefreshRecordResistancesFromSpecies", ROMX

; With SRAM enabled (bank 0), for each of the 30 records from sRecords whose MON_STATE is not 0:
; loads its species record (wSpeciesIdLo/Hi and wArg2/wArg3 = its MON_SPECIES) and writes the 27
; base resistance levels of the species (LoadSpeciesResistanceArg4, low two bits) to its
; MON_RESISTANCES. Ends with rRAMG = 0. No caller was found in src/. (C2, E-0376; probed E-0384)
; for each of the 30 SRAM records stores the 27 two-bit resistance levels of its species at record +
; $73 (E-0127)
RefreshRecordResistancesFromSpecies:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $1e

.loop:
    push hl
    push bc
    ld a, [hl]
    and a
    jr z, .restore
    push hl
    ld a, $0b
    add_a_to_hl
    ld a, [hli]
    ld [wArg2], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wArg3], a
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    pop hl
    ld a, $73
    add_a_to_hl
    ld b, $1b
    ld c, $00

.loop2:
    push hl
    push bc
    ld a, c
    ld [wArg4], a
    call LoadSpeciesResistanceArg4
    ld a, [wArg5]
    pop bc
    pop hl
    and $03
    ld [hli], a
    inc c
    dec b
    jr nz, .loop2

.restore:
    pop bc
    pop hl
    ld a, $a5
    add_a_to_hl
    dec c
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

SECTION "Bank 0E RollChildResistancesToChildRecordResistances", ROMX

; Loads the species record of the child (MON_SPECIES of wChildRecord) and, for each of the 27
; resistances, takes its base level (LoadSpeciesResistanceArg4 into wArg5). A level of 3 is kept. A
; level of 2 rolls RollResistanceGainForLevel2 when the two parent levels
; (SumRecordBufAAndBResistanceTests) add up to 5 or more; a level of 0 or 1 rolls
; RollResistanceGainForLowLevel when they add up to 3 or more. The result (low two bits of wArg5)
; goes to the MON_RESISTANCES of wChildRecord. (C2, E-0376)
; for each of the 27 resistances of species wChildRecord + $B: levels below 3 may rise by the parent
; rolls (RollResistanceGainForLowLevel or 5D77); stores the result at wChildRecord + $73 (E-0127)
; (E-0340: the address in its name read as its RAM name; was
; RollChildResistancesToChildRecordResistances)
RollChildResistancesToChildRecordResistances::
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wArg2], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wArg3], a
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld b, $1b
    ld c, $00

.loop:
    push bc
    ld a, c
    ld [wArg4], a
    call LoadSpeciesResistanceArg4
    ld a, [wArg5]
    cp $03
    jr nc, .restore
    pop bc
    push bc
    ld a, [wArg5]
    cp $02
    jr z, .call_sum_record_buf_a_and_b_resistance_tests
    ld b, $03
    call SumRecordBufAAndBResistanceTests
    ld a, b
    cp $ff
    jr z, .restore
    call RollResistanceGainForLowLevel
    jr .restore

.call_sum_record_buf_a_and_b_resistance_tests:
    ld b, $05
    call SumRecordBufAAndBResistanceTests
    ld a, b
    cp $ff
    jr z, .restore
    call RollResistanceGainForLevel2

.restore:
    pop bc
    ld de, wChildRecord + MON_RESISTANCES
    ld a, c
    add e
    ld e, a
    jr nc, .check_arg5
    inc d

.check_arg5:
    ld a, [wArg5]
    and $03
    ld [de], a
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank 0E RollResistanceGainForLowLevel", ROMX

; B = sum of the two parent levels (3 or more), wArg5 = the base level 0 or 1 of a child resistance:
; nothing when the MON_PLUS of wChildRecord is 0. Otherwise it rolls
; RollChildRecordPlusChanceOrIncArg5 with factor 1 for B = 3 and 3 for B = 4; for B = 5 factor 10
; and, only when that raised wArg5, factor 3 once more; for B of 6 or more it first adds 1 to wArg5
; and then rolls factor 5. BC is kept. (C2, E-0376)
; when wChildRecord + $6D is set rolls RollChildRecordPlusChanceOrIncArg5 with factor 1, 3 or 10
; (then 3) for B = 3, 4, 5, or 5 after counting otherwise (E-0125) (E-0340: the address in its name
; read as its RAM name; was RollResistanceGainForLowLevel) (E-0344: the address in its name dropped
; or read as the label there; was RollResistanceGainForLowLevel)
RollResistanceGainForLowLevel::
    push bc
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    and a
    jr nz, .skip
    pop bc
    ret

.skip:
    ld a, b
    cp $03
    jr z, .skip2
    cp $04
    jr z, .skip3
    cp $05
    jr z, .call_roll_child_record_plus_chance_or_inc2
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    ld a, $05

.call_roll_child_record_plus_chance_or_inc:
    call RollChildRecordPlusChanceOrIncArg5

.loop:
    pop bc
    ret

.skip2:
    ld a, $01
    jr .call_roll_child_record_plus_chance_or_inc

.skip3:
    ld a, $03
    jr .call_roll_child_record_plus_chance_or_inc

.call_roll_child_record_plus_chance_or_inc2:
    ld a, $0a
    call RollChildRecordPlusChanceOrIncArg5
    cp $ff
    jr z, .loop
    jr .skip3

SECTION "Bank 0E RollChildRecordPlusChanceOrIncArg5", ROMX

; A = factor: chance = factor * the MON_PLUS of wChildRecord. When the chance is 100 or more, or a
; random value 0-99 (the quotient of RandomModulo29 with B = $0F) is not above it, it adds 1 to
; wArg5 and returns A = 0; when the random value is above the chance it returns A = $FF and leaves
; wArg5. The earlier reading had the two outcomes swapped. (C2, E-0376)
; chance = A * wChildRecord + $6D; if below 100 and a random value is below it, A = $FF; otherwise
; wArg5 += 1 and A = 0 (E-0124) (E-0340: the address in its name read as its RAM name; was
; RollChildRecordPlusChanceOrIncArg5)
RollChildRecordPlusChanceOrIncArg5::
    ld c, a
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    call Multiply8
    ld a, h
    and a
    jr nz, .check_arg5
    ld a, l
    cp $64
    jr nc, .check_arg5
    push af
    push bc
    ld b, $0f
    call RandomModulo29
    pop bc
    pop af
    cp l
    jr nc, .check_arg5
    ld a, $ff
    ret

.check_arg5:
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    xor a
    ret

SECTION "Bank 0E RollResistanceGainForLevel2", ROMX

; B = sum of the two parent levels (5 or more), wArg5 = the base level 2 of a child resistance:
; nothing when the MON_PLUS of wChildRecord is 0. For B = 5 it draws a random value 0-199
; (RandomModulo29 with B = $1F, the quotient) and, when it is not above the plus, adds 1 to wArg5 (A
; = 0), else A = $FF; for other B it rolls RollChildRecordPlusChanceOrIncArg5 with factor 2. BC is
; kept. (C2, E-0376)
; when wChildRecord + $6D is set: B = 5 rolls a random value against wChildRecord + $6D (A = $FF on
; success), other values roll factor 2 (E-0125) (E-0340: the address in its name read as its RAM
; name; was RollResistanceGainForLevel2) (E-0344: the address in its name dropped or read as the
; label there; was RollResistanceGainForLevel2)
RollResistanceGainForLevel2::
    push bc
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    and a
    jr nz, .skip

.loop:
    pop bc
    ret

.skip:
    ld a, b
    cp $05
    jr z, .skip2
    ld a, $02
    call RollChildRecordPlusChanceOrIncArg5
    pop bc
    ret

.skip2:
    ld hl, wChildRecord + MON_PLUS
    cp $01
    jr z, .loop
    ld a, [hl]
    push af
    push bc
    ld b, $1f
    call RandomModulo29
    pop bc
    pop af
    cp l
    jr nc, .check_arg5
    ld a, $ff
    pop bc
    ret

.check_arg5:
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    xor a
    pop bc
    ret

SECTION "Bank 0E SumRecordBufAAndBResistanceTests", ROMX

; C = resistance index, B = least sum: TestResistanceEntry for the MON_RESISTANCES of wRecordBufA
; and of wRecordBufB; when neither returns $FF and their sum is at least B, returns B = A = the sum,
; otherwise B = $FF. (C2, E-0376)
; B = TestResistanceEntry(wRecordBufA + $73) + TestResistanceEntry(wRecordBufB + $73) when both are
; valid and the sum is at least B; otherwise B = $FF (E-0124) (E-0340: the address in its name read
; as its RAM name; was SumRecordBufAAndBResistanceTests) (E-0345: $C9F9 and $CA9E are the
; MON_RESISTANCES of wRecordBufA and wRecordBufB; was SumRecordBufAAndBResistanceTests)
SumRecordBufAAndBResistanceTests::
    ld hl, wRecordBufA + MON_RESISTANCES
    call TestResistanceEntry
    cp $ff
    jr z, .done
    ld e, a
    ld hl, wRecordBufB + MON_RESISTANCES
    call TestResistanceEntry
    cp $ff
    jr z, .done
    add e
    cp b
    jr c, .done
    ld b, a
    ret

.done:
    ld b, $ff
    ret

SECTION "Bank 0E TestResistanceEntry", ROMX

; HL = the MON_RESISTANCES of a parent record, C = resistance index: returns A = the level at HL +
; C, except that a level of 2 returns $FF when the record MON_ITEM (HL + $31) is 1-$1B and
; TestResistanceEntry_Data[item - 1] equals C. HL is kept. (C2, E-0376)
; (E-0345: was TestResistanceEntry) for entry C: when it is 2 and the byte $31 later is 1-$1B and
; its table byte equals C, returns $FF (E-0340: the address in its name read as its RAM name; was
; TestResistanceEntry)
TestResistanceEntry::
    push hl
    ld a, c
    add_a_to_hl
    ld a, [hl]
    cp $02
    jr z, .restore

.done:
    pop hl
    ret

.restore:
    pop hl
    push hl
    push af
    ld a, $31
    add_a_to_hl
    ld a, [hl]
    and a
    jr z, .restore2
    cp $1c
    jr nc, .restore2
    dec a
    ld hl, TestResistanceEntry_Data
    add_a_to_hl
    ld a, [hl]
    cp c
    jr nz, .restore2
    pop af
    pop hl
    ld a, $ff
    ret

.restore2:
    pop af
    jr .done

SECTION "Bank 0E TestResistanceEntry_Data", ROMX

; 27 bytes indexed by MON_ITEM - 1 (items 1 to $1B): each is a resistance index 0-$1A, and together
; they use every index once (the order starts 0-6, then $0E, $0F, 7, $10-$14, 8-$B and so on).
; TestResistanceEntry returns $FF instead of level 2 for resistance C when the record MON_ITEM is
; 1-$1B and this table byte equals C; SumRecordBufAAndBResistanceTests uses it for both parents.
; (C1, E-0381)
TestResistanceEntry_Data::
    db $00, $01, $02, $03, $04, $05, $06, $0e, $0f, $07, $10, $11, $12, $13, $14, $08
    db $09, $0a, $0b, $15, $16, $17, $18, $19, $1a, $0c, $0d

; wArg4 = resistance index: returns wArg5 = A = byte wArg4 of the resistance levels
; (SPECIES_RESISTANCES) of the species record in wSpeciesRecord; HL ends at that byte. (C2, E-0376)
; wArg5 = the byte at wSpeciesRecord + $12 + wArg4 (E-0114) (E-0340: the address in its name read as
; its RAM name; was LoadSpeciesResistanceArg4) (E-0345: reads wSpeciesRecord + $12
; (SPECIES_RESISTANCES): the resistance in arg 4; was LoadSpeciesResistanceArg4)
LoadSpeciesResistanceArg4::
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES
    ld a, [wArg4]
    add_a_to_hl
    ld a, [hl]
    ld [wArg5], a
    ret

SECTION "Bank 0E CopySixBytesByChildRecordFamilyBit4Table", ROMX

; Copies the species words and pluses of the parents into wChildRecord: with bit 4 of its MON_FAMILY
; clear, the MON_SPECIES and MON_PLUS of wRecordBufA go to MON_PARENT1_SPECIES and MON_PARENT1_PLUS
; and those of wRecordBufB to MON_PARENT2_SPECIES and MON_PARENT2_PLUS; with bit 4 set
; (ComputeBreedingChild puts bit 0 of the parent A MON_SEX there) the two parents swap. The
; addresses are byte lists in CopySixBytesByChildRecordFamilyBit4Table_Data1-3. (C2, E-0376)
; copies six bytes from the addresses in CopySixBytesByChildRecordFamilyBit4Table_Data1 (or 5E6D
; when bit 4 of wChildRecord + $D is set) to the addresses in
; CopySixBytesByChildRecordFamilyBit4Table_Data3 (E-0125) (E-0340: the address in its name read as
; its RAM name; was CopySixBytesByChildRecordFamilyBit4Table)
CopySixBytesByChildRecordFamilyBit4Table::
    ld hl, wChildRecord + MON_FAMILY
    ld a, [hl]
    and $10
    and a
    jr nz, .skip
    ld de, CopySixBytesByChildRecordFamilyBit4Table_Data1
    jr .skip2

.skip:
    ld de, CopySixBytesByChildRecordFamilyBit4Table_Data2

.skip2:
    ld c, $00
    ld b, $06

.loop:
    push de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    ld a, c
    add a
    ld hl, CopySixBytesByChildRecordFamilyBit4Table_Data3
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc de
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank 0E CopySixBytesByChildRecordFamilyBit4Table_Data1", ROMX

; Six little-endian addresses in the breeding record buffers, the sources used when bit 4 of the
; child MON_FAMILY is clear: wRecordBufA + MON_SPECIES (two bytes, $C991 and $C992), wRecordBufB +
; MON_SPECIES ($CA36, $CA37), then the MON_PLUS bytes of wRecordBufA ($C9F3) and of wRecordBufB
; ($CA98). CopySixBytesByChildRecordFamilyBit4Table copies byte i from these to the destination in
; CopySixBytesByChildRecordFamilyBit4Table_Data3. (C1, E-0381)
CopySixBytesByChildRecordFamilyBit4Table_Data1::
    db $91, $c9, $92, $c9, $36, $ca, $37, $ca, $f3, $c9, $98, $ca

; The same six source addresses as CopySixBytesByChildRecordFamilyBit4Table_Data1 with parent A and
; parent B swapped ($CA36, $CA37, $C991, $C992, then the MON_PLUS bytes $CA98 and $C9F3), used when
; bit 4 of the child MON_FAMILY is set. CopySixBytesByChildRecordFamilyBit4Table copies byte i from
; these to the destination in CopySixBytesByChildRecordFamilyBit4Table_Data3. (C1, E-0381)
CopySixBytesByChildRecordFamilyBit4Table_Data2::
    db $36, $ca, $37, $ca, $91, $c9, $92, $c9, $98, $ca, $f3, $c9

; Six little-endian destination addresses in wChildRecord: $CAEA to $CAED (MON_PARENT1_SPECIES and
; MON_PARENT2_SPECIES, two bytes each), $CB68 (MON_PARENT1_PLUS) and $CB73 (MON_PARENT2_PLUS).
; CopySixBytesByChildRecordFamilyBit4Table stores source byte i to entry i whichever source table it
; used. (C1, E-0381)
CopySixBytesByChildRecordFamilyBit4Table_Data3::
    db $ea, $ca, $eb, $ca, $ec, $ca, $ed, $ca, $68, $cb, $73, $cb

; Copies the ten bytes of wPlayerName to the MON_MASTER_NAME of wChildRecord (the player becomes the
; master of the child). (C2, E-0376)
; copies the 10-byte player name wPlayerName to wChildRecord + $F (E-0122) (E-0340: the address in
; its name read as its RAM name; was CopyPlayerNameToChildRecordMasterName)
CopyPlayerNameToChildRecordMasterName::
    ld hl, wPlayerName
    ld de, wChildRecord + MON_MASTER_NAME
    ld c, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

SECTION "Bank 0E CopyFourNamesByChildRecordFamilyBit4Table", ROMX

; Copies four 10-byte names into wChildRecord: with bit 4 of its MON_FAMILY clear, the MON_NAME and
; MON_MASTER_NAME of wRecordBufA go to MON_PARENT1_NAME and MON_PARENT1_MASTER and those of
; wRecordBufB to MON_PARENT2_NAME and MON_PARENT2_MASTER; with bit 4 set the two parents swap. The
; addresses come from CopyFourNamesByChildRecordFamilyBit4Table_Data1-3. (C2, E-0376)
; copies four 10-byte names from the addresses in CopyFourNamesByChildRecordFamilyBit4Table_Data1
; (or 5ED8 with bit 4 of wChildRecord + $D) to the addresses in
; CopyFourNamesByChildRecordFamilyBit4Table_Data3 (E-0125) (E-0340: the address in its name read as
; its RAM name; was CopyFourNamesByChildRecordFamilyBit4Table)
CopyFourNamesByChildRecordFamilyBit4Table::
    ld hl, wChildRecord + MON_FAMILY
    ld a, [hl]
    and $10
    and a
    jr nz, .skip
    ld de, CopyFourNamesByChildRecordFamilyBit4Table_Data1
    jr .skip2

.skip:
    ld de, CopyFourNamesByChildRecordFamilyBit4Table_Data2

.skip2:
    ld c, $00
    ld b, $04

.loop:
    push de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    ld hl, CopyFourNamesByChildRecordFamilyBit4Table_Data3
    ld a, c
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    push bc
    ld b, $0a

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    pop bc
    pop de
    inc de
    inc de
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank 0E CopyFourNamesByChildRecordFamilyBit4Table_Data1", ROMX

; Four little-endian source addresses used when bit 4 of the child MON_FAMILY is clear: wRecordBufA
; + MON_NAME ($C987), wRecordBufB + MON_NAME ($CA2C), wRecordBufA + MON_MASTER_NAME ($C995) and
; wRecordBufB + MON_MASTER_NAME ($CA3A). CopyFourNamesByChildRecordFamilyBit4Table copies 10 bytes
; from entry i to the destination of entry i in CopyFourNamesByChildRecordFamilyBit4Table_Data3.
; (C1, E-0381)
CopyFourNamesByChildRecordFamilyBit4Table_Data1::
    db $87, $c9, $2c, $ca, $95, $c9, $3a, $ca

; The same four source addresses as CopyFourNamesByChildRecordFamilyBit4Table_Data1 with parent A
; and B swapped ($CA2C, $C987, $CA3A, $C995), used when bit 4 of the child MON_FAMILY is set.
; CopyFourNamesByChildRecordFamilyBit4Table copies 10 bytes from entry i to the destination of entry
; i in CopyFourNamesByChildRecordFamilyBit4Table_Data3. (C1, E-0381)
CopyFourNamesByChildRecordFamilyBit4Table_Data2::
    db $2c, $ca, $87, $c9, $3a, $ca, $95, $c9

; Four little-endian destination addresses in wChildRecord: $CB5E (MON_PARENT1_NAME), $CB69
; (MON_PARENT2_NAME), $CAEE (MON_PARENT1_MASTER) and $CAF9 (MON_PARENT2_MASTER).
; CopyFourNamesByChildRecordFamilyBit4Table copies a 10-byte name from the source of entry i to
; entry i whichever source table it used. (C1, E-0381)
CopyFourNamesByChildRecordFamilyBit4Table_Data3::
    db $5e, $cb, $69, $cb, $ee, $ca, $f9, $ca

; Adds a percentage bonus to the stats of wChildRecord: 5 when PersonalityPairValueToArg5 gives 0, 5
; when both parents have MON_LEVEL equal to MON_MAX_LEVEL, 2 when both parents have MON_PLUS 5 or
; more with an even sum, 3 when wArg1 (the breeding kind) is not 0. With a total of 0 it returns;
; otherwise each of the eight words HP, max HP, MP, max MP, ATK, DEF, AGL and INT (offsets in
; ApplyBreedingBonusToChildStats_Data) gains word * total / 100 rounded up, capped at 999. (C2,
; E-0376)
; computes a bonus from personality compatibility, matching parent fields and wArg1, and adds it to
; the child stats at wChildRecord (offsets ApplyBreedingBonusToChildStats_Data) (E-0130)
ApplyBreedingBonusToChildStats::
    call PersonalityPairValueToArg5
    ld c, $00
    ld a, [wArg5]
    and a
    jr nz, .skip
    ld a, c
    add $05
    ld c, a

.skip:
    ld hl, wRecordBufA + MON_MAX_LEVEL
    ld a, [hld]
    ld b, a
    ld a, [hl]
    cp b
    jr nz, .skip2
    ld hl, wRecordBufB + MON_MAX_LEVEL
    ld a, [hld]
    ld b, a
    ld a, [hl]
    cp b
    jr nz, .skip2
    ld a, c
    add $05
    ld c, a

.skip2:
    ld hl, wRecordBufA + MON_PLUS
    ld a, [hl]
    cp $05
    jr c, .check_arg1
    ld b, a
    ld hl, wRecordBufB + MON_PLUS
    ld a, [hl]
    cp $05
    jr c, .check_arg1
    add b
    bit 0, a
    jr nz, .check_arg1
    ld a, c
    add $02
    ld c, a

.check_arg1:
    ld a, [wArg1]
    and a
    jr z, .skip3
    ld a, c
    add $03
    ld c, a

.skip3:
    ld a, c
    and a
    ret z
    ld b, $08
    ld de, ApplyBreedingBonusToChildStats_Data

.loop:
    push de
    push bc
    ld hl, wChildRecord
    ld a, [de]
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    push bc
    ld a, c
    ld c, e
    ld b, d
    call Multiply8By16
    ld a, $64
    call DivideHLByA
    and a
    jr z, .restore
    inc hl

.restore:
    pop bc
    pop de
    push de
    push bc
    ld bc, wChildRecord
    ld a, [de]
    add c
    ld c, a
    jr nc, .skip4
    inc b

.skip4:
    push bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    ld d, a
    add hl, de
    ld a, h
    cp $03
    jr c, .restore2
    jr nz, .skip5
    ld a, l
    cp $e8
    jr c, .restore2

.skip5:
    ld h, $03
    ld l, $e7

.restore2:
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    pop bc
    pop de
    inc de
    dec b
    jr nz, .loop
    ret

SECTION "Bank 0E ApplyBreedingBonusToChildStats_Data", ROMX

; Eight MON record offsets, each a stat word of wChildRecord: $5B MON_HP, $5D MON_MAX_HP, $5F
; MON_MP, $61 MON_MAX_MP, $63 MON_ATK, $65 MON_DEF, $67 MON_AGL and $69 MON_INT.
; ApplyBreedingBonusToChildStats walks the list and adds word * bonus / 100 (rounded up, capped at
; 999) to each. (C1, E-0381)
ApplyBreedingBonusToChildStats_Data::
    db $5b, $5d, $5f, $61, $63, $65, $67, $69

; wArg5 = the two-bit value of PersonalityPairMatrix for the combined personality indexes
; (CombinedPersonalityLevelIndexOfRecord) of wRecordBufA (row, 8 bytes each) and wRecordBufB
; (column: byte index / 4, bits picked by PersonalityPairValueToArg5_Data[index & 3], highest pair
; first). Returns A = the index of parent A. ApplyBreedingBonusToChildStats adds 5% when the value
; is 0; a bank-$F1 screen also calls it. (C2, E-0376)
; wArg5 = the 2-bit entry of the matrix PersonalityPairMatrix for the combined personality indexes
; of wRecordBufA and wRecordBufB (E-0128)
PersonalityPairValueToArg5::
    ld hl, wRecordBufA
    call CombinedPersonalityLevelIndexOfRecord
    push af
    ld hl, wRecordBufB
    call CombinedPersonalityLevelIndexOfRecord
    ld b, a
    ld l, a
    ld h, $00
    srl h
    rr l
    srl h
    rr l
    pop af
    push af
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, PersonalityPairMatrix
    add hl, de
    ld a, b
    and $03
    ld de, PersonalityPairValueToArg5_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    ld a, [hl]
    and c
    ld c, a
    ld a, b
    and $03
    and a
    jr z, .skip2
    cp $01
    jr z, .skip3
    cp $02
    jr z, .skip4
    ld a, c
    jr .set_arg5

.skip2:
    ld a, c
    swap a
    srl a
    srl a
    jr .set_arg5

.skip3:
    ld a, c
    swap a
    jr .set_arg5

.skip4:
    ld a, c
    srl a
    srl a

.set_arg5:
    ld [wArg5], a
    pop af
    ret

SECTION "Bank 0E CombinedPersonalityLevelIndexOfRecord", ROMX

; HL = a monster record: returns A = 9 * grade(byte $6F) + 3 * grade(byte $72) + grade(byte $70),
; each grade from GradeTemp0_Bank0E (0 for $C0 or more, 1 for $40-$BF, 2 below $40), so 0-26. Byte
; $71 is not used. Compare CombinedPersonalityLevelIndex. (C2, E-0376)
; for the record at HL returns 9 * grade(field $6F) + 3 * grade(field $72) + grade(field $70)
; (GradeTemp0_Bank0E); compare CombinedPersonalityLevelIndex (E-0121)
CombinedPersonalityLevelIndexOfRecord::
    push hl
    ld a, $6f
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    call GradeTemp0_Bank0E
    ld a, $09
    call Multiply8
    ld b, l
    pop hl
    push hl
    ld a, $72
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    call GradeTemp0_Bank0E
    ld a, c
    add a
    add c
    add b
    ld b, a
    pop hl
    ld a, $70
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    call GradeTemp0_Bank0E
    ld a, c
    add b
    ret

SECTION "Bank 0E GradeTemp0_Bank0E", ROMX

; Grades the byte in hTemp0: returns C = 0 when it is $C0 or more, 1 when it is $40-$BF and 2 below
; $40; A = the byte. A bank-$0E copy of GradeTemp0; CombinedPersonalityLevelIndexOfRecord grades
; three personality bytes with it. (C2, E-0376)
; the same 13 bytes as GradeTemp0 (GradeTemp0) (E-0353)
GradeTemp0_Bank0E::
    ldh a, [hTemp0]
    ld c, $00
    cp $c0
    ret nc
    inc c
    cp $40
    ret nc
    inc c
    ret

SECTION "Bank 0E PersonalityPairMatrix", ROMX

; PersonalityPairValueToArg5 takes CombinedPersonalityLevelIndexOfRecord of both parents (A, B),
; reads the byte at $603F + 8 * A + B / 4 and masks it with PersonalityPairValueToArg5_Data[B & 3];
; the selected two bits go to wArg5; 27 rows, one per index of parent A (E-0200, C1)
; record: two-bit values for parent B's combined personality index 0-26 (four per byte), padded with
; $FF
PersonalityPairMatrix::
    db $4d, $75, $46, $55, $65, $17, $7b, $ff ; id 0
    db $1d, $75, $56, $45, $67, $d7, $63, $ff ; id 1
    db $f9, $75, $5f, $5c, $f5, $d7, $5b, $ff ; id 2
    db $55, $55, $45, $55, $e7, $e7, $7b, $ff ; id 3
    db $55, $55, $55, $5f, $63, $c7, $bb, $ff ; id 4
    db $fd, $6f, $75, $d6, $5d, $7c, $5b, $ff ; id 5
    db $55, $78, $51, $df, $5d, $7f, $5b, $ff ; id 6
    db $55, $71, $4f, $55, $7d, $eb, $7b, $ff ; id 7
    db $55, $55, $5d, $e7, $5f, $70, $5b, $ff ; id 8
    db $14, $74, $56, $5f, $f5, $57, $5b, $ff ; id 9
    db $5d, $53, $d6, $5d, $f4, $d5, $5b, $ff ; id 10
    db $ad, $57, $6a, $a7, $55, $4f, $9b, $ff ; id 11
    db $55, $7d, $d6, $45, $57, $d5, $5b, $ff ; id 12
    db $45, $55, $96, $15, $55, $55, $53, $ff ; id 13
    db $5d, $dd, $7d, $56, $af, $d7, $1b, $ff ; id 14
    db $51, $ed, $f7, $5a, $f7, $fd, $7b, $ff ; id 15
    db $5f, $55, $7d, $5b, $75, $51, $5b, $ff ; id 16
    db $ae, $97, $7d, $5b, $e5, $d3, $5b, $ff ; id 17
    db $55, $3f, $d5, $5d, $55, $55, $4b, $ff ; id 18
    db $77, $d5, $d1, $df, $56, $55, $5b, $ff ; id 19
    db $3f, $d7, $5d, $df, $75, $5a, $bb, $ff ; id 20
    db $56, $3e, $d4, $57, $55, $55, $7b, $ff ; id 21
    db $55, $7e, $17, $57, $05, $95, $53, $ff ; id 22
    db $ff, $cf, $37, $5d, $75, $96, $5b, $ff ; id 23
    db $55, $95, $56, $51, $55, $95, $53, $ff ; id 24
    db $e7, $d7, $55, $57, $51, $f5, $53, $ff ; id 25
    db $8a, $aa, $aa, $8a, $aa, $a2, $0b, $ff ; id 26

PersonalityPairValueToArg5_Data::
    db $c0, $30, $0c, $03

; B = mask: steps the table random number (NextTableByte), sets L = wRandomLo and H = (wRandomLo
; rotated left through carry) AND B, and divides HL by $29 (41) with DivideHLByA: HL = the quotient
; and A = the remainder. With B = $0F the quotient is 0-99 and with B = $1F 0-199; the callers
; RollChildRecordPlusChanceOrIncArg5, RollResistanceGainForLevel2 and RollChildSexFromSpecies use
; the quotient in L, not the remainder. (C2, E-0376)
; NextTableByte; L = wRandomLo, H = (wRandomLo rotated left through carry) & B; returns A = HL mod
; $29 (E-0117)
RandomModulo29::
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
    ld l, a
    rl a
    and b
    ld h, a
    ld a, $29
    call DivideHLByA
    ret

SECTION "Bank 0E LoadRecordWordFieldArg5AndShowIcon", ROMX

; C = SRAM record index, wArg5 = field offset: loads that word of the record (LoadSRAMRecordWord
; into hTemp0/hTemp1; the caller enables SRAM) and falls into DrawSpeciesAndFamilyIconForTemp0,
; which takes it as a species id and loads its family icon tile into tile wArg4.
; LoadRecordWordFieldAndContinue in bank $1E calls it for the parent species fields ($1A, $1C)
; listed by DrawRecordFamilyEntries_Data1/2. (C1, E-0376)
; loads word field wArg5 of record A (LoadSRAMRecordWord) and falls into
; DrawSpeciesAndFamilyIconForTemp0 (E-0126)
LoadRecordWordFieldArg5AndShowIcon::
    ld a, c
    push af
    ld a, [wArg5]
    ld c, a
    pop af
    call LoadSRAMRecordWord

; hTemp0/hTemp1 = monster id: copies it to wArg6/wArg7, gets its family (FamilyForSpeciesIdArg6 into
; wArg5) and far-calls LoadFamilyIconTileForWorkBuf with wWorkBuf = the family (low four bits) and
; wWorkBuf + 1 = wArg4, the tile to write. Reached from LoadRecordWordFieldArg5AndShowIcon and from
; DrawSpeciesIconForRecordBufBEntry in bank $F2. (C1, E-0376)
; wArg6/7 = hTemp0/7, runs FamilyForSpeciesIdArg6, then loads the family icon tile for wArg5 & $0F
; into tile wArg4 (E-0126)
DrawSpeciesAndFamilyIconForTemp0::
    ldh a, [hTemp0]
    ld [wArg6], a
    ldh a, [hTemp1]
    ld [wArg7], a
    call FamilyForSpeciesIdArg6
    ld a, [wArg5]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    ret

SECTION "Bank 0E FamilyForSpeciesIdArg6", ROMX

; wArg6/wArg7 = monster id (low, high): sets wArg5 = its family from the id ranges: below $1B 0,
; $1B-$42 1, $43-$66 2, $67-$84 3, $85-$A7 4, $A8-$C9 5, $CA-$F0 6, $F1-$110 7, $111-$138 8,
; $139-$15B 9, from $15C 10. A high byte other than 1 is treated as 0 (only the low byte is
; compared). (C2, E-0376)
; wArg5 = the family (0-10) of species id wArg6/7 by id ranges (< $1B, $43, $67, $85, $A8, $CA, $F1,
; $111, $139, $15C, or more) (E-0128)
FamilyForSpeciesIdArg6::
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    cp $01
    jr nz, .skip
    ld a, l
    cp $11
    jr c, .skip9
    cp $39
    jr c, .skip10
    cp $5c
    jr c, .skip11
    jr .set_arg5_to_0A

.skip:
    ld a, l
    cp $1b
    jr c, .skip2
    cp $43
    jr c, .skip3
    cp $67
    jr c, .skip4
    cp $85
    jr c, .skip5
    cp $a8
    jr c, .skip6
    cp $ca
    jr c, .skip7
    cp $f1
    jr c, .skip8
    jr .skip9

.skip2:
    xor a
    jr .set_arg5

.skip3:
    ld a, $01
    jr .set_arg5

.skip4:
    ld a, $02
    jr .set_arg5

.skip5:
    ld a, $03
    jr .set_arg5

.skip6:
    ld a, $04
    jr .set_arg5

.skip7:
    ld a, $05
    jr .set_arg5

.skip8:
    ld a, $06
    jr .set_arg5

.skip9:
    ld a, $07
    jr .set_arg5

.skip10:
    ld a, $08
    jr .set_arg5

.skip11:
    ld a, $09
    jr .set_arg5

.set_arg5_to_0A:
    ld a, $0a

.set_arg5:
    ld [wArg5], a
    ret

SECTION "Bank 0E RollChildSexFromSpecies", ROMX

; Loads the species record of MON_SPECIES of wChildRecord (LoadSpeciesRecordWord0). When its
; SPECIES_SEX_RATIO byte is 0 the child is male (MON_SEX = 0); otherwise it draws a random value
; 0-99 (RandomModulo29 with B = $0F, the quotient) and sets MON_SEX = 1 (female) when it is not
; above SexChanceByClass[byte & 3] (0, 10, 50, 90), else 0. Called by ComputeBreedingChild and by
; MedalPrizeMenu_ChoosePrize_GivePrize_CreateMonster for a prize monster. (C2, E-0376)
; loads the child's species record; when species byte 1 (SPECIES_SEX_RATIO) is non-zero, sets the
; child's MON_SEX to 1 (female) when a random value is not above SexChanceByClass[byte & 3] (0, 10,
; 50, 90), else 0 (male); byte 1 = 0 gives male (E-0311)
RollChildSexFromSpecies::
    ld a, [wChildRecord + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wChildRecord + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecordWord0
    ld a, [wSpeciesRecord + SPECIES_SEX_RATIO]
    and a
    jr z, .skip
    and $03
    ld hl, SexChanceByClass
    add_a_to_hl
    ld a, [hl]
    push af
    push bc
    ld b, $0f
    call RandomModulo29
    pop bc
    pop af
    cp l
    jr c, .skip
    ld b, $01
    jr .skip2

.skip:
    ld b, $00

.skip2:
    ld a, b
    ld hl, wChildRecord + MON_SEX
    ld [hl], a
    ret

SECTION "Bank 0E SexChanceByClass", ROMX

; chance (of about 100) of a female child (RollChildSexFromSpecies sets MON_SEX to 1), per sex-ratio
; class 0-3: 0, 10, 50, 90 (E-0311)
SexChanceByClass::
    db $00, $0a, $32, $5a

ComputeBreedingChild_Data::
    db $5d, $5d, $61, $61, $63, $65, $67, $69

; ComputeBreedingChild stage 1 reads the word at $6208 + 2 * parent A's species (record +$B) and
; walks the list's words: a species equal to parent B's matches; $FDxx moves to the next result;
; $FExx / $FCxx match when parent B / parent A has + (record +$6D) of at least xx and both parents
; are the same species; $FBxx moves on only when wArg1 = 2; $FFxx ends the list; a match takes
; result [count of moves] from BreedSpeciesResultTable (E-0199, C1)
; record: list
BreedSpeciesRuleTable::
    dw BreedSpeciesRules000 ; id 0
    dw BreedSpeciesRules_DrakSlime ; id 1 DrakSlime
    dw BreedSpeciesRules_SpotSlime ; id 2 SpotSlime
    dw BreedSpeciesRules000 ; id 3 WingSlime
    dw BreedSpeciesRules000 ; id 4 TreeSlime
    dw BreedSpeciesRules000 ; id 5 Snaily
    dw BreedSpeciesRules_SlimeNite ; id 6 SlimeNite
    dw BreedSpeciesRules000 ; id 7 Babble
    dw BreedSpeciesRules000 ; id 8 BoxSlime
    dw BreedSpeciesRules000 ; id 9 PearlGel
    dw BreedSpeciesRules_Slime ; id 10 Slime
    dw BreedSpeciesRules_Healer ; id 11 Healer
    dw BreedSpeciesRules000 ; id 12 FangSlime
    dw BreedSpeciesRules_RockSlime ; id 13 RockSlime
    dw BreedSpeciesRules000 ; id 14 SlimeBorg
    dw BreedSpeciesRules000 ; id 15 Slabbit
    dw BreedSpeciesRules_KingSlime ; id 16 KingSlime
    dw BreedSpeciesRules_Metaly ; id 17 Metaly
    dw BreedSpeciesRules_Metabble ; id 18 Metabble
    dw BreedSpeciesRules_SpotKing ; id 19 SpotKing
    dw BreedSpeciesRules000 ; id 20 TropicGel
    dw BreedSpeciesRules_MimeSlime ; id 21 MimeSlime
    dw BreedSpeciesRules000 ; id 22 HaloSlime
    dw BreedSpeciesRules_MetalKing ; id 23 MetalKing
    dw BreedSpeciesRules_GoldSlime ; id 24 GoldSlime
    dw BreedSpeciesRules000 ; id 25 GranSlime
    dw BreedSpeciesRules_WonderEgg ; id 26 WonderEgg
    dw BreedSpeciesRules000 ; id 27 Butch
    dw BreedSpeciesRules000 ; id 28 ?
    dw BreedSpeciesRules000 ; id 29 ?
    dw BreedSpeciesRules000 ; id 30 ?
    dw BreedSpeciesRules000 ; id 31 ?
    dw BreedSpeciesRules000 ; id 32 ?
    dw BreedSpeciesRules000 ; id 33 ?
    dw BreedSpeciesRules000 ; id 34 ?
    dw BreedSpeciesRules000 ; id 35 ?
    dw BreedSpeciesRules_DragonKid ; id 36 DragonKid
    dw BreedSpeciesRules000 ; id 37 Tortragon
    dw BreedSpeciesRules_Pteranod ; id 38 Pteranod
    dw BreedSpeciesRules_Gasgon ; id 39 Gasgon
    dw BreedSpeciesRules000 ; id 40 FairyDrak
    dw BreedSpeciesRules_LizardMan ; id 41 LizardMan
    dw BreedSpeciesRules000 ; id 42 Poisongon
    dw BreedSpeciesRules000 ; id 43 Swordgon
    dw BreedSpeciesRules000 ; id 44 Drygon
    dw BreedSpeciesRules_Dragon ; id 45 Dragon
    dw BreedSpeciesRules000 ; id 46 MiniDrak
    dw BreedSpeciesRules_MadDragon ; id 47 MadDragon
    dw BreedSpeciesRules000 ; id 48 Rayburn
    dw BreedSpeciesRules000 ; id 49 Chamelgon
    dw BreedSpeciesRules000 ; id 50 LizardFly
    dw BreedSpeciesRules_Andreal ; id 51 Andreal
    dw BreedSpeciesRules_KingCobra ; id 52 KingCobra
    dw BreedSpeciesRules_Vampirus ; id 53 Vampirus
    dw BreedSpeciesRules000 ; id 54 SnakeBat
    dw BreedSpeciesRules000 ; id 55 Spikerous
    dw BreedSpeciesRules_GreatDrak ; id 56 GreatDrak
    dw BreedSpeciesRules_Crestpent ; id 57 Crestpent
    dw BreedSpeciesRules_WingSnake ; id 58 WingSnake
    dw BreedSpeciesRules000 ; id 59 Coatol
    dw BreedSpeciesRules000 ; id 60 Orochi
    dw BreedSpeciesRules_BattleRex ; id 61 BattleRex
    dw BreedSpeciesRules_SkyDragon ; id 62 SkyDragon
    dw BreedSpeciesRules000 ; id 63 Serpentia
    dw BreedSpeciesRules_Divinegon ; id 64 Divinegon
    dw BreedSpeciesRules000 ; id 65 Orligon
    dw BreedSpeciesRules000 ; id 66 GigaDraco
    dw BreedSpeciesRules000 ; id 67 ?
    dw BreedSpeciesRules000 ; id 68 ?
    dw BreedSpeciesRules000 ; id 69 ?
    dw BreedSpeciesRules000 ; id 70 ?
    dw BreedSpeciesRules_Tonguella ; id 71 Tonguella
    dw BreedSpeciesRules_Almiraj ; id 72 Almiraj
    dw BreedSpeciesRules_CatFly ; id 73 CatFly
    dw BreedSpeciesRules000 ; id 74 PillowRat
    dw BreedSpeciesRules000 ; id 75 Saccer
    dw BreedSpeciesRules_GulpBeast ; id 76 GulpBeast
    dw BreedSpeciesRules000 ; id 77 Skullroo
    dw BreedSpeciesRules000 ; id 78 WindBeast
    dw BreedSpeciesRules000 ; id 79 Beavern
    dw BreedSpeciesRules000 ; id 80 Antbear
    dw BreedSpeciesRules_SuperTen ; id 81 SuperTen
    dw BreedSpeciesRules_IronTurt ; id 82 IronTurt
    dw BreedSpeciesRules000 ; id 83 Mommonja
    dw BreedSpeciesRules_HammerMan ; id 84 HammerMan
    dw BreedSpeciesRules_Grizzly ; id 85 Grizzly
    dw BreedSpeciesRules_Yeti ; id 86 Yeti
    dw BreedSpeciesRules_ArrowDog ; id 87 ArrowDog
    dw BreedSpeciesRules_NoctoKing ; id 88 NoctoKing
    dw BreedSpeciesRules_BeastNite ; id 89 BeastNite
    dw BreedSpeciesRules_MadGopher ; id 90 MadGopher
    dw BreedSpeciesRules000 ; id 91 FairyRat
    dw BreedSpeciesRules_Unicorn ; id 92 Unicorn
    dw BreedSpeciesRules_Goategon ; id 93 Goategon
    dw BreedSpeciesRules_WildApe ; id 94 WildApe
    dw BreedSpeciesRules_Trumpeter ; id 95 Trumpeter
    dw BreedSpeciesRules000 ; id 96 KingLeo
    dw BreedSpeciesRules_DarkHorn ; id 97 DarkHorn
    dw BreedSpeciesRules_MadCat ; id 98 MadCat
    dw BreedSpeciesRules000 ; id 99 BigEye
    dw BreedSpeciesRules000 ; id 100 Gorago
    dw BreedSpeciesRules_CatMage ; id 101 CatMage
    dw BreedSpeciesRules_Dumbira ; id 102 Dumbira
    dw BreedSpeciesRules000 ; id 103 ?
    dw BreedSpeciesRules000 ; id 104 ?
    dw BreedSpeciesRules000 ; id 105 ?
    dw BreedSpeciesRules000 ; id 106 Picky
    dw BreedSpeciesRules000 ; id 107 Wyvern
    dw BreedSpeciesRules_BullBird ; id 108 BullBird
    dw BreedSpeciesRules000 ; id 109 Florajay
    dw BreedSpeciesRules000 ; id 110 DuckKite
    dw BreedSpeciesRules_MadPecker ; id 111 MadPecker
    dw BreedSpeciesRules000 ; id 112 MadRaven
    dw BreedSpeciesRules000 ; id 113 MistyWing
    dw BreedSpeciesRules_AquaHawk ; id 114 AquaHawk
    dw BreedSpeciesRules000 ; id 115 Dracky
    dw BreedSpeciesRules_KiteHawk ; id 116 KiteHawk
    dw BreedSpeciesRules000 ; id 117 BigRoost
    dw BreedSpeciesRules000 ; id 118 StubBird
    dw BreedSpeciesRules_LandOwl ; id 119 LandOwl
    dw BreedSpeciesRules_MadGoose ; id 120 MadGoose
    dw BreedSpeciesRules_MadCondor ; id 121 MadCondor
    dw BreedSpeciesRules000 ; id 122 Emyu
    dw BreedSpeciesRules_Blizzardy ; id 123 Blizzardy
    dw BreedSpeciesRules_Phoenix ; id 124 Phoenix
    dw BreedSpeciesRules_ZapBird ; id 125 ZapBird
    dw BreedSpeciesRules_Garudian ; id 126 Garudian
    dw BreedSpeciesRules_WhipBird ; id 127 WhipBird
    dw BreedSpeciesRules_FunkyBird ; id 128 FunkyBird
    dw BreedSpeciesRules_RainHawk ; id 129 RainHawk
    dw BreedSpeciesRules000 ; id 130 Azurile
    dw BreedSpeciesRules_Shantak ; id 131 Shantak
    dw BreedSpeciesRules_CragDevil ; id 132 CragDevil
    dw BreedSpeciesRules000 ; id 133 ?
    dw BreedSpeciesRules000 ; id 134 ?
    dw BreedSpeciesRules000 ; id 135 ?
    dw BreedSpeciesRules000 ; id 136 ?
    dw BreedSpeciesRules000 ; id 137 ?
    dw BreedSpeciesRules000 ; id 138 ?
    dw BreedSpeciesRules000 ; id 139 ?
    dw BreedSpeciesRules000 ; id 140 ?
    dw BreedSpeciesRules000 ; id 141 MadPlant
    dw BreedSpeciesRules000 ; id 142 FireWeed
    dw BreedSpeciesRules000 ; id 143 FloraMan
    dw BreedSpeciesRules000 ; id 144 WingTree
    dw BreedSpeciesRules000 ; id 145 CactiBall
    dw BreedSpeciesRules000 ; id 146 Gulpple
    dw BreedSpeciesRules000 ; id 147 Toadstool
    dw BreedSpeciesRules000 ; id 148 AmberWeed
    dw BreedSpeciesRules000 ; id 149 Slurperon
    dw BreedSpeciesRules_Stubsuck ; id 150 Stubsuck
    dw BreedSpeciesRules000 ; id 151 Oniono
    dw BreedSpeciesRules000 ; id 152 DanceVegi
    dw BreedSpeciesRules_TreeBoy ; id 153 TreeBoy
    dw BreedSpeciesRules000 ; id 154 Devipine
    dw BreedSpeciesRules000 ; id 155 FaceTree
    dw BreedSpeciesRules000 ; id 156 HerbMan
    dw BreedSpeciesRules000 ; id 157 BeanMan
    dw BreedSpeciesRules_EvilSeed ; id 158 EvilSeed
    dw BreedSpeciesRules_ManEater ; id 159 ManEater
    dw BreedSpeciesRules000 ; id 160 Snapper
    dw BreedSpeciesRules_GhosTree ; id 161 GhosTree
    dw BreedSpeciesRules_Rosevine ; id 162 Rosevine
    dw BreedSpeciesRules000 ; id 163 Egdracil
    dw BreedSpeciesRules_Warubou ; id 164 Warubou
    dw BreedSpeciesRules000 ; id 165 Watabou
    dw BreedSpeciesRules000 ; id 166 Eggplaton
    dw BreedSpeciesRules_FooHero ; id 167 FooHero
    dw BreedSpeciesRules000 ; id 168 ?
    dw BreedSpeciesRules000 ; id 169 ?
    dw BreedSpeciesRules000 ; id 170 ?
    dw BreedSpeciesRules000 ; id 171 ?
    dw BreedSpeciesRules000 ; id 172 ?
    dw BreedSpeciesRules000 ; id 173 ?
    dw BreedSpeciesRules000 ; id 174 ?
    dw BreedSpeciesRules000 ; id 175 ?
    dw BreedSpeciesRules000 ; id 176 GiantSlug
    dw BreedSpeciesRules_Catapila ; id 177 Catapila
    dw BreedSpeciesRules000 ; id 178 Gophecada
    dw BreedSpeciesRules_Butterfly ; id 179 Butterfly
    dw BreedSpeciesRules_WeedBug ; id 180 WeedBug
    dw BreedSpeciesRules000 ; id 181 GiantWorm
    dw BreedSpeciesRules_Lipsy ; id 182 Lipsy
    dw BreedSpeciesRules_StagBug ; id 183 StagBug
    dw BreedSpeciesRules000 ; id 184 Pyuro
    dw BreedSpeciesRules000 ; id 185 ArmyAnt
    dw BreedSpeciesRules000 ; id 186 GoHopper
    dw BreedSpeciesRules_TailEater ; id 187 TailEater
    dw BreedSpeciesRules000 ; id 188 ArmorPede
    dw BreedSpeciesRules_Eyeder ; id 189 Eyeder
    dw BreedSpeciesRules000 ; id 190 GiantMoth
    dw BreedSpeciesRules000 ; id 191 Droll
    dw BreedSpeciesRules_ArmyCrab ; id 192 ArmyCrab
    dw BreedSpeciesRules_MadHornet ; id 193 MadHornet
    dw BreedSpeciesRules000 ; id 194 Belzebub
    dw BreedSpeciesRules_WarMantis ; id 195 WarMantis
    dw BreedSpeciesRules_HornBeet ; id 196 HornBeet
    dw BreedSpeciesRules000 ; id 197 Sickler
    dw BreedSpeciesRules_Armorpion ; id 198 Armorpion
    dw BreedSpeciesRules000 ; id 199 Digster
    dw BreedSpeciesRules000 ; id 200 Skularach
    dw BreedSpeciesRules_MultiEyes ; id 201 MultiEyes
    dw BreedSpeciesRules000 ; id 202 ?
    dw BreedSpeciesRules000 ; id 203 ?
    dw BreedSpeciesRules000 ; id 204 ?
    dw BreedSpeciesRules000 ; id 205 ?
    dw BreedSpeciesRules000 ; id 206 ?
    dw BreedSpeciesRules000 ; id 207 ?
    dw BreedSpeciesRules000 ; id 208 ?
    dw BreedSpeciesRules000 ; id 209 ?
    dw BreedSpeciesRules000 ; id 210 ?
    dw BreedSpeciesRules000 ; id 211 Pixy
    dw BreedSpeciesRules000 ; id 212 MedusaEye
    dw BreedSpeciesRules_AgDevil ; id 213 AgDevil
    dw BreedSpeciesRules_Demonite ; id 214 Demonite
    dw BreedSpeciesRules_DarkEye ; id 215 DarkEye
    dw BreedSpeciesRules000 ; id 216 EyeBall
    dw BreedSpeciesRules000 ; id 217 SkulRider
    dw BreedSpeciesRules000 ; id 218 EvilBeast
    dw BreedSpeciesRules_Bubblemon ; id 219 Bubblemon
    dw BreedSpeciesRules_1EyeClown ; id 220 1EyeClown
    dw BreedSpeciesRules_Gremlin ; id 221 Gremlin
    dw BreedSpeciesRules_ArcDemon ; id 222 ArcDemon
    dw BreedSpeciesRules_Lionex ; id 223 Lionex
    dw BreedSpeciesRules000 ; id 224 GoatHorn
    dw BreedSpeciesRules000 ; id 225 Orc
    dw BreedSpeciesRules_Ogre ; id 226 Ogre
    dw BreedSpeciesRules000 ; id 227 GateGuard
    dw BreedSpeciesRules000 ; id 228 ChopClown
    dw BreedSpeciesRules_BossTroll ; id 229 BossTroll
    dw BreedSpeciesRules_Grendal ; id 230 Grendal
    dw BreedSpeciesRules_Akubar ; id 231 Akubar
    dw BreedSpeciesRules000 ; id 232 MadKnight
    dw BreedSpeciesRules000 ; id 233 EvilWell
    dw BreedSpeciesRules_Gigantes ; id 234 Gigantes
    dw BreedSpeciesRules_Centasaur ; id 235 Centasaur
    dw BreedSpeciesRules000 ; id 236 EvilArmor
    dw BreedSpeciesRules_Jamirus ; id 237 Jamirus
    dw BreedSpeciesRules_Durran ; id 238 Durran
    dw BreedSpeciesRules000 ; id 239 Titanis
    dw BreedSpeciesRules_LampGenie ; id 240 LampGenie
    dw BreedSpeciesRules000 ; id 241 ?
    dw BreedSpeciesRules000 ; id 242 ?
    dw BreedSpeciesRules000 ; id 243 ?
    dw BreedSpeciesRules000 ; id 244 ?
    dw BreedSpeciesRules000 ; id 245 ?
    dw BreedSpeciesRules000 ; id 246 Spooky
    dw BreedSpeciesRules_Skullgon ; id 247 Skullgon
    dw BreedSpeciesRules_PutrePup ; id 248 PutrePup
    dw BreedSpeciesRules000 ; id 249 RotRaven
    dw BreedSpeciesRules_Mummy ; id 250 Mummy
    dw BreedSpeciesRules000 ; id 251 DarkCrab
    dw BreedSpeciesRules_DeadNite ; id 252 DeadNite
    dw BreedSpeciesRules000 ; id 253 Shadow
    dw BreedSpeciesRules000 ; id 254 Skulpent
    dw BreedSpeciesRules_Hork ; id 255 Hork
    dw BreedSpeciesRules_Mudron ; id 256 Mudron
    dw BreedSpeciesRules_NiteWhip ; id 257 NiteWhip
    dw BreedSpeciesRules000 ; id 258 WindMerge
    dw BreedSpeciesRules000 ; id 259 Reaper
    dw BreedSpeciesRules000 ; id 260 Inverzon
    dw BreedSpeciesRules000 ; id 261 FoxFire
    dw BreedSpeciesRules_CaptDead ; id 262 CaptDead
    dw BreedSpeciesRules_DeadNoble ; id 263 DeadNoble
    dw BreedSpeciesRules_WhiteKing ; id 264 WhiteKing
    dw BreedSpeciesRules_BoneSlave ; id 265 BoneSlave
    dw BreedSpeciesRules_Skeletor ; id 266 Skeletor
    dw BreedSpeciesRules_Servant ; id 267 Servant
    dw BreedSpeciesRules000 ; id 268 Lazamanus
    dw BreedSpeciesRules_Copycat ; id 269 Copycat
    dw BreedSpeciesRules_MadSpirit ; id 270 MadSpirit
    dw BreedSpeciesRules000 ; id 271 PomPomBom
    dw BreedSpeciesRules_Niterich ; id 272 Niterich
    dw BreedSpeciesRules000 ; id 273 ?
    dw BreedSpeciesRules000 ; id 274 ?
    dw BreedSpeciesRules000 ; id 275 ?
    dw BreedSpeciesRules000 ; id 276 ?
    dw BreedSpeciesRules000 ; id 277 ?
    dw BreedSpeciesRules000 ; id 278 ?
    dw BreedSpeciesRules000 ; id 279 ?
    dw BreedSpeciesRules000 ; id 280 ?
    dw BreedSpeciesRules000 ; id 281 JewelBag
    dw BreedSpeciesRules_EvilWand ; id 282 EvilWand
    dw BreedSpeciesRules_MadCandle ; id 283 MadCandle
    dw BreedSpeciesRules000 ; id 284 CoilBird
    dw BreedSpeciesRules000 ; id 285 Facer
    dw BreedSpeciesRules_SpikyBoy ; id 286 SpikyBoy
    dw BreedSpeciesRules_MadMirror ; id 287 MadMirror
    dw BreedSpeciesRules000 ; id 288 RogueNite
    dw BreedSpeciesRules_Puppetor ; id 289 Puppetor
    dw BreedSpeciesRules_Goopi ; id 290 Goopi
    dw BreedSpeciesRules_Voodoll ; id 291 Voodoll
    dw BreedSpeciesRules_MetalDrak ; id 292 MetalDrak
    dw BreedSpeciesRules000 ; id 293 Balzak
    dw BreedSpeciesRules_SabreMan ; id 294 SabreMan
    dw BreedSpeciesRules_CurseLamp ; id 295 CurseLamp
    dw BreedSpeciesRules000 ; id 296 Brushead
    dw BreedSpeciesRules_Roboster ; id 297 Roboster
    dw BreedSpeciesRules_Roboster2 ; id 298 Roboster2
    dw BreedSpeciesRules_EvilPot ; id 299 EvilPot
    dw BreedSpeciesRules_Gismo ; id 300 Gismo
    dw BreedSpeciesRules_LavaMan ; id 301 LavaMan
    dw BreedSpeciesRules_IceMan ; id 302 IceMan
    dw BreedSpeciesRules_Mimic ; id 303 Mimic
    dw BreedSpeciesRules000 ; id 304 Exaucers
    dw BreedSpeciesRules_MudDoll ; id 305 MudDoll
    dw BreedSpeciesRules_Golem ; id 306 Golem
    dw BreedSpeciesRules_StoneMan ; id 307 StoneMan
    dw BreedSpeciesRules000 ; id 308 BombCrag
    dw BreedSpeciesRules_GoldGolem ; id 309 GoldGolem
    dw BreedSpeciesRules000 ; id 310 DarkMate
    dw BreedSpeciesRules000 ; id 311 ProtoMech
    dw BreedSpeciesRules000 ; id 312 CloudKing
    dw BreedSpeciesRules000 ; id 313 ?
    dw BreedSpeciesRules000 ; id 314 ?
    dw BreedSpeciesRules000 ; id 315 ?
    dw BreedSpeciesRules000 ; id 316 Petiteel
    dw BreedSpeciesRules000 ; id 317 Moray
    dw BreedSpeciesRules000 ; id 318 WalrusMan
    dw BreedSpeciesRules000 ; id 319 RayGigas
    dw BreedSpeciesRules000 ; id 320 Anemon
    dw BreedSpeciesRules_Aquarella ; id 321 Aquarella
    dw BreedSpeciesRules_Merman ; id 322 Merman
    dw BreedSpeciesRules000 ; id 323 Octokid
    dw BreedSpeciesRules000 ; id 324 PutreFish
    dw BreedSpeciesRules_Octoreach ; id 325 Octoreach
    dw BreedSpeciesRules_Angleron ; id 326 Angleron
    dw BreedSpeciesRules000 ; id 327 FishRider
    dw BreedSpeciesRules_RushFish ; id 328 RushFish
    dw BreedSpeciesRules_Gamanian ; id 329 Gamanian
    dw BreedSpeciesRules_Clawster ; id 330 Clawster
    dw BreedSpeciesRules_CancerMan ; id 331 CancerMan
    dw BreedSpeciesRules_RogueWave ; id 332 RogueWave
    dw BreedSpeciesRules000 ; id 333 Scallopa
    dw BreedSpeciesRules000 ; id 334 SeaHorse
    dw BreedSpeciesRules_HoodSquid ; id 335 HoodSquid
    dw BreedSpeciesRules_MerTiger ; id 336 MerTiger
    dw BreedSpeciesRules000 ; id 337 AxeShark
    dw BreedSpeciesRules_Octogon ; id 338 Octogon
    dw BreedSpeciesRules000 ; id 339 KingSquid
    dw BreedSpeciesRules_Digong ; id 340 Digong
    dw BreedSpeciesRules000 ; id 341 WhaleMage
    dw BreedSpeciesRules000 ; id 342 Aquadon
    dw BreedSpeciesRules000 ; id 343 Octoraid
    dw BreedSpeciesRules_Grakos ; id 344 Grakos
    dw BreedSpeciesRules000 ; id 345 Poseidon
    dw BreedSpeciesRules000 ; id 346 Pumpoise
    dw BreedSpeciesRules000 ; id 347 Starfish
    dw BreedSpeciesRules000 ; id 348 ?
    dw BreedSpeciesRules000 ; id 349 ?
    dw BreedSpeciesRules000 ; id 350 ?
    dw BreedSpeciesRules_DracoLord ; id 351 DracoLord
    dw BreedSpeciesRules_DracoLord_160 ; id 352 DracoLord
    dw BreedSpeciesRules000 ; id 353 LordDraco
    dw BreedSpeciesRules_Hargon ; id 354 Hargon
    dw BreedSpeciesRules_Sidoh ; id 355 Sidoh
    dw BreedSpeciesRules000 ; id 356 Genosidoh
    dw BreedSpeciesRules_Baramos ; id 357 Baramos
    dw BreedSpeciesRules_Zoma ; id 358 Zoma
    dw BreedSpeciesRules000 ; id 359 AsuraZoma
    dw BreedSpeciesRules_Pizzaro ; id 360 Pizzaro
    dw BreedSpeciesRules_PsychoPiz ; id 361 PsychoPiz
    dw BreedSpeciesRules_Esterk ; id 362 Esterk
    dw BreedSpeciesRules_Mirudraas ; id 363 Mirudraas
    dw BreedSpeciesRules_Mirudraas_16C ; id 364 Mirudraas
    dw BreedSpeciesRules000 ; id 365 Mudou
    dw BreedSpeciesRules_DeathMore ; id 366 DeathMore
    dw BreedSpeciesRules_DeathMore_16F ; id 367 DeathMore
    dw BreedSpeciesRules_DeathMore_170 ; id 368 DeathMore
    dw BreedSpeciesRules000 ; id 369 Darkdrium
    dw BreedSpeciesRules_Orgodemir ; id 370 Orgodemir
    dw BreedSpeciesRules000 ; id 371 Orgodemir
    dw BreedSpeciesRules000 ; id 372 Darck
    dw BreedSpeciesRules000 ; id 373 Tatsu
    dw BreedSpeciesRules000 ; id 374 Diago
    dw BreedSpeciesRules000 ; id 375 Samsi
    dw BreedSpeciesRules000 ; id 376 Bazoo
    dw BreedSpeciesRules000 ; id 377 ?
    dw BreedSpeciesRules000 ; id 378 ?
    dw BreedSpeciesRules000 ; id 379 ?
    dw BreedSpeciesRules000 ; id 380 Lamia
    dw BreedSpeciesRules000 ; id 381 Dimensaur
    dw BreedSpeciesRules000 ; id 382 Kagebou
    dw BreedSpeciesRules000 ; id 383 ?

; list for entry $00 of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules000::
    dw $ffff ; id 0 end of list

; list for entry $01 (DrakSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DrakSlime::
    dw MONSTER_SWORDGON ; id 0
    dw $ffff ; id 1 end of list

; list for entry $02 (SpotSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_SpotSlime::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $ffff ; id 2 end of list

; list for entry $06 (SlimeNite) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_SlimeNite::
    dw MONSTER_SPIKEROUS ; id 0
    dw $ffff ; id 1 end of list

; list for entry $0A (Slime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Slime::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $fdfd ; id 2 next result
    dw MONSTER_PILLOWRAT ; id 3
    dw MONSTER_MOMMONJA ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_COPYCAT ; id 6
    dw $fbfb ; id 7 next result when wArg1 = 2, else end of list
    dw MONSTER_BIGROOST ; id 8
    dw $ffff ; id 9 end of list

; list for entry $0B (Healer) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Healer::
    dw MONSTER_TREEBOY ; id 0
    dw MONSTER_1EYECLOWN ; id 1
    dw MONSTER_EVILWAND ; id 2
    dw $ffff ; id 3 end of list

; list for entry $0D (RockSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_RockSlime::
    dw MONSTER_GREATDRAK ; id 0
    dw $ffff ; id 1 end of list

; list for entry $10 (KingSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_KingSlime::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BATTLEREX ; id 1
    dw MONSTER_DIVINEGON ; id 2
    dw MONSTER_UNICORN ; id 3
    dw MONSTER_KINGLEO ; id 4
    dw MONSTER_MADCONDOR ; id 5
    dw MONSTER_ZAPBIRD ; id 6
    dw MONSTER_WHIPBIRD ; id 7
    dw MONSTER_BOSSTROLL ; id 8
    dw MONSTER_GIGANTES ; id 9
    dw MONSTER_CENTASAUR ; id 10
    dw MONSTER_DEADNOBLE ; id 11
    dw MONSTER_WHITEKING ; id 12
    dw $fdfd ; id 13 next result
    dw MONSTER_METALDRAK ; id 14
    dw $fdfd ; id 15 next result
    dw MONSTER_GOLDGOLEM ; id 16
    dw $ffff ; id 17 end of list

; list for entry $11 (Metaly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Metaly::
    dw MONSTER_METALY ; id 0
    dw MONSTER_WONDEREGG ; id 1
    dw $ffff ; id 2 end of list

; list for entry $12 (Metabble) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Metabble::
    dw MONSTER_BATTLEREX ; id 0
    dw MONSTER_SKYDRAGON ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_METABBLE ; id 3
    dw $ffff ; id 4 end of list

; list for entry $13 (SpotKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_SpotKing::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BATTLEREX ; id 1
    dw MONSTER_DIVINEGON ; id 2
    dw MONSTER_UNICORN ; id 3
    dw MONSTER_KINGLEO ; id 4
    dw MONSTER_MADCONDOR ; id 5
    dw MONSTER_ZAPBIRD ; id 6
    dw MONSTER_WHIPBIRD ; id 7
    dw MONSTER_BOSSTROLL ; id 8
    dw MONSTER_GIGANTES ; id 9
    dw MONSTER_CENTASAUR ; id 10
    dw MONSTER_DEADNOBLE ; id 11
    dw MONSTER_WHITEKING ; id 12
    dw $fdfd ; id 13 next result
    dw MONSTER_METALDRAK ; id 14
    dw $fdfd ; id 15 next result
    dw MONSTER_GOLDGOLEM ; id 16
    dw $ffff ; id 17 end of list

; list for entry $15 (MimeSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MimeSlime::
    dw MONSTER_STUBBIRD ; id 0
    dw MONSTER_PIXY ; id 1
    dw $ffff ; id 2 end of list

; list for entry $17 (MetalKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MetalKing::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BATTLEREX ; id 1
    dw MONSTER_DIVINEGON ; id 2
    dw MONSTER_UNICORN ; id 3
    dw MONSTER_KINGLEO ; id 4
    dw MONSTER_MADCONDOR ; id 5
    dw MONSTER_ZAPBIRD ; id 6
    dw MONSTER_WHIPBIRD ; id 7
    dw MONSTER_BOSSTROLL ; id 8
    dw MONSTER_GIGANTES ; id 9
    dw MONSTER_CENTASAUR ; id 10
    dw MONSTER_DEADNOBLE ; id 11
    dw MONSTER_WHITEKING ; id 12
    dw $fdfd ; id 13 next result
    dw MONSTER_METALKING ; id 14
    dw MONSTER_GOLDGOLEM ; id 15
    dw $ffff ; id 16 end of list

; list for entry $18 (GoldSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_GoldSlime::
    dw MONSTER_GOLDSLIME ; id 0
    dw MONSTER_DARKMATE ; id 1
    dw MONSTER_DEATHMORE ; id 2
    dw $ffff ; id 3 end of list

; list for entry $1A (WonderEgg) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_WonderEgg::
    dw MONSTER_METABBLE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_METALKING ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_GOLDSLIME ; id 4
    dw $ffff ; id 5 end of list

; list for entry $24 (DragonKid) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DragonKid::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $fdfd ; id 2 next result
    dw MONSTER_DRAGONKID ; id 3
    dw $ffff ; id 4 end of list

; list for entry $26 (Pteranod) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Pteranod::
    dw MONSTER_PTERANOD ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_DARKHORN ; id 2
    dw MONSTER_MADKNIGHT ; id 3
    dw MONSTER_COPYCAT ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw MONSTER_WHIPBIRD ; id 6
    dw $ffff ; id 7 end of list

; list for entry $27 (Gasgon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Gasgon::
    dw MONSTER_GOATEGON ; id 0
    dw MONSTER_TRUMPETER ; id 1
    dw MONSTER_MADCONDOR ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw MONSTER_ARCDEMON ; id 4
    dw MONSTER_LIONEX ; id 5
    dw MONSTER_GOATHORN ; id 6
    dw MONSTER_OGRE ; id 7
    dw MONSTER_AKUBAR ; id 8
    dw MONSTER_DEADNOBLE ; id 9
    dw MONSTER_GOLEM ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_DARKHORN ; id 12
    dw MONSTER_MADKNIGHT ; id 13
    dw MONSTER_COPYCAT ; id 14
    dw MONSTER_STONEMAN ; id 15
    dw MONSTER_WHIPBIRD ; id 16
    dw $ffff ; id 17 end of list

; list for entry $29 (LizardMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_LizardMan::
    dw MONSTER_WINGSLIME ; id 0
    dw MONSTER_TRUMPETER ; id 1
    dw MONSTER_MADCAT ; id 2
    dw MONSTER_FACETREE ; id 3
    dw MONSTER_LIONEX ; id 4
    dw MONSTER_GOATHORN ; id 5
    dw MONSTER_GATEGUARD ; id 6
    dw MONSTER_GIGANTES ; id 7
    dw $fdfd ; id 8 next result
    dw MONSTER_DARKHORN ; id 9
    dw MONSTER_MADKNIGHT ; id 10
    dw MONSTER_COPYCAT ; id 11
    dw MONSTER_STONEMAN ; id 12
    dw MONSTER_WHIPBIRD ; id 13
    dw $ffff ; id 14 end of list

; list for entry $2D (Dragon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Dragon::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $fbfb ; id 2 next result when wArg1 = 2, else end of list
    dw MONSTER_AQUAHAWK ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_LIONEX ; id 5
    dw $ffff ; id 6 end of list

; list for entry $2F (MadDragon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MadDragon::
    dw MONSTER_GOATEGON ; id 0
    dw MONSTER_TRUMPETER ; id 1
    dw MONSTER_MADCONDOR ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw MONSTER_ARCDEMON ; id 4
    dw MONSTER_LIONEX ; id 5
    dw MONSTER_GOATHORN ; id 6
    dw MONSTER_OGRE ; id 7
    dw MONSTER_AKUBAR ; id 8
    dw MONSTER_DEADNOBLE ; id 9
    dw MONSTER_GOLEM ; id 10
    dw $ffff ; id 11 end of list

; list for entry $33 (Andreal) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Andreal::
    dw MONSTER_MEDUSAEYE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_BOSSTROLL ; id 2
    dw MONSTER_GIGANTES ; id 3
    dw $ffff ; id 4 end of list

; list for entry $34 (KingCobra) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_KingCobra::
    dw MONSTER_DRACKY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $35 (Vampirus) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Vampirus::
    dw MONSTER_DARKHORN ; id 0
    dw MONSTER_MADKNIGHT ; id 1
    dw MONSTER_COPYCAT ; id 2
    dw MONSTER_STONEMAN ; id 3
    dw MONSTER_WHIPBIRD ; id 4
    dw $fbfb ; id 5 next result when wArg1 = 2, else end of list
    dw MONSTER_AQUAHAWK ; id 6
    dw $ffff ; id 7 end of list

; list for entry $38 (GreatDrak) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_GreatDrak::
    dw MONSTER_MEDUSAEYE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_LIONEX ; id 2
    dw MONSTER_SKELETOR ; id 3
    dw MONSTER_OCTORAID ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_BOSSTROLL ; id 6
    dw MONSTER_GIGANTES ; id 7
    dw $ffff ; id 8 end of list

; list for entry $39 (Crestpent) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Crestpent::
    dw MONSTER_CRESTPENT ; id 0
    dw $ffff ; id 1 end of list

; list for entry $3A (WingSnake) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_WingSnake::
    dw MONSTER_WINGSNAKE ; id 0
    dw $ffff ; id 1 end of list

; list for entry $3D (BattleRex) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_BattleRex::
    dw MONSTER_GOATEGON ; id 0
    dw MONSTER_TRUMPETER ; id 1
    dw MONSTER_MADCONDOR ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw MONSTER_ARCDEMON ; id 4
    dw MONSTER_LIONEX ; id 5
    dw MONSTER_GOATHORN ; id 6
    dw MONSTER_OGRE ; id 7
    dw MONSTER_AKUBAR ; id 8
    dw MONSTER_DEADNOBLE ; id 9
    dw MONSTER_GOLEM ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_DARKHORN ; id 12
    dw MONSTER_MADKNIGHT ; id 13
    dw MONSTER_COPYCAT ; id 14
    dw MONSTER_STONEMAN ; id 15
    dw MONSTER_WHIPBIRD ; id 16
    dw $fdfd ; id 17 next result
    dw MONSTER_BOSSTROLL ; id 18
    dw MONSTER_GIGANTES ; id 19
    dw $ffff ; id 20 end of list

; list for entry $3E (SkyDragon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_SkyDragon::
    dw MONSTER_GOATEGON ; id 0
    dw MONSTER_TRUMPETER ; id 1
    dw MONSTER_MADCONDOR ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw MONSTER_ARCDEMON ; id 4
    dw MONSTER_LIONEX ; id 5
    dw MONSTER_GOATHORN ; id 6
    dw MONSTER_OGRE ; id 7
    dw MONSTER_AKUBAR ; id 8
    dw MONSTER_DEADNOBLE ; id 9
    dw MONSTER_GOLEM ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_DARKHORN ; id 12
    dw MONSTER_MADKNIGHT ; id 13
    dw MONSTER_COPYCAT ; id 14
    dw MONSTER_STONEMAN ; id 15
    dw MONSTER_WHIPBIRD ; id 16
    dw $fdfd ; id 17 next result
    dw MONSTER_OROCHI ; id 18
    dw MONSTER_SERPENTIA ; id 19
    dw $fdfd ; id 20 next result
    dw MONSTER_BOSSTROLL ; id 21
    dw MONSTER_GIGANTES ; id 22
    dw $ffff ; id 23 end of list

; list for entry $40 (Divinegon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Divinegon::
    dw MONSTER_GOLDGOLEM ; id 0
    dw MONSTER_GIGADRACO ; id 1
    dw $ffff ; id 2 end of list

; list for entry $47 (Tonguella) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Tonguella::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_TREESLIME ; id 6
    dw MONSTER_FANGSLIME ; id 7
    dw MONSTER_MADDRAGON ; id 8
    dw MONSTER_FUNKYBIRD ; id 9
    dw MONSTER_MADPLANT ; id 10
    dw MONSTER_FACETREE ; id 11
    dw MONSTER_LIPSY ; id 12
    dw MONSTER_DEMONITE ; id 13
    dw MONSTER_GREMLIN ; id 14
    dw MONSTER_COPYCAT ; id 15
    dw MONSTER_JEWELBAG ; id 16
    dw MONSTER_MIMIC ; id 17
    dw $fdfd ; id 18 next result
    dw MONSTER_LANDOWL ; id 19
    dw MONSTER_MADCONDOR ; id 20
    dw MONSTER_ZAPBIRD ; id 21
    dw MONSTER_WHIPBIRD ; id 22
    dw $ffff ; id 23 end of list

; list for entry $48 (Almiraj) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Almiraj::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_HEALER ; id 1
    dw $ffff ; id 2 end of list

; list for entry $49 (CatFly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_CatFly::
    dw MONSTER_MIMESLIME ; id 0
    dw MONSTER_CATMAGE ; id 1
    dw MONSTER_TREEBOY ; id 2
    dw MONSTER_SICKLER ; id 3
    dw MONSTER_1EYECLOWN ; id 4
    dw MONSTER_REAPER ; id 5
    dw MONSTER_EVILWAND ; id 6
    dw $ffff ; id 7 end of list

; list for entry $4C (GulpBeast) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_GulpBeast::
    dw MONSTER_TREESLIME ; id 0
    dw MONSTER_FANGSLIME ; id 1
    dw MONSTER_MADDRAGON ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw MONSTER_MADPLANT ; id 4
    dw MONSTER_FACETREE ; id 5
    dw MONSTER_LIPSY ; id 6
    dw MONSTER_DEMONITE ; id 7
    dw MONSTER_GREMLIN ; id 8
    dw MONSTER_COPYCAT ; id 9
    dw MONSTER_JEWELBAG ; id 10
    dw MONSTER_MIMIC ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_LANDOWL ; id 13
    dw MONSTER_MADCONDOR ; id 14
    dw MONSTER_ZAPBIRD ; id 15
    dw MONSTER_WHIPBIRD ; id 16
    dw MONSTER_METALDRAK ; id 17
    dw MONSTER_BALZAK ; id 18
    dw MONSTER_ROBOSTER ; id 19
    dw MONSTER_LAVAMAN ; id 20
    dw MONSTER_ICEMAN ; id 21
    dw MONSTER_GOLEM ; id 22
    dw MONSTER_STONEMAN ; id 23
    dw $ffff ; id 24 end of list

; list for entry $51 (SuperTen) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_SuperTen::
    dw MONSTER_LIZARDMAN ; id 0
    dw MONSTER_BEASTNITE ; id 1
    dw MONSTER_BUBBLEMON ; id 2
    dw MONSTER_ORC ; id 3
    dw MONSTER_SABREMAN ; id 4
    dw MONSTER_WALRUSMAN ; id 5
    dw MONSTER_MERTIGER ; id 6
    dw $ffff ; id 7 end of list

; list for entry $52 (IronTurt) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_IronTurt::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ROBOSTER ; id 1
    dw MONSTER_LAVAMAN ; id 2
    dw MONSTER_ICEMAN ; id 3
    dw MONSTER_GOLEM ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_PTERANOD ; id 7
    dw MONSTER_GASGON ; id 8
    dw MONSTER_SWORDGON ; id 9
    dw MONSTER_MADDRAGON ; id 10
    dw MONSTER_BATTLEREX ; id 11
    dw MONSTER_SKYDRAGON ; id 12
    dw $ffff ; id 13 end of list

; list for entry $54 (HammerMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_HammerMan::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_LIZARDMAN ; id 1
    dw $ffff ; id 2 end of list

; list for entry $55 (Grizzly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Grizzly::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_ROBOSTER ; id 6
    dw MONSTER_LAVAMAN ; id 7
    dw MONSTER_ICEMAN ; id 8
    dw MONSTER_GOLEM ; id 9
    dw MONSTER_STONEMAN ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_LANDOWL ; id 12
    dw MONSTER_MADCONDOR ; id 13
    dw MONSTER_ZAPBIRD ; id 14
    dw MONSTER_WHIPBIRD ; id 15
    dw $ffff ; id 16 end of list

; list for entry $56 (Yeti) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Yeti::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_ROBOSTER ; id 6
    dw MONSTER_LAVAMAN ; id 7
    dw MONSTER_ICEMAN ; id 8
    dw MONSTER_GOLEM ; id 9
    dw MONSTER_STONEMAN ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_LANDOWL ; id 12
    dw MONSTER_MADCONDOR ; id 13
    dw MONSTER_ZAPBIRD ; id 14
    dw MONSTER_WHIPBIRD ; id 15
    dw $ffff ; id 16 end of list

; list for entry $57 (ArrowDog) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_ArrowDog::
    dw MONSTER_DRACKY ; id 0
    dw MONSTER_SHADOW ; id 1
    dw $fdfd ; id 2 next result
    dw $fe04 ; id 3 same species, parent B +4 or more
    dw $fc04 ; id 4 same species, parent A +4 or more
    dw $ffff ; id 5 end of list

; list for entry $58 (NoctoKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_NoctoKing::
    dw MONSTER_GIGANTES ; id 0
    dw $ffff ; id 1 end of list

; list for entry $59 (BeastNite) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_BeastNite::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_MERTIGER ; id 1
    dw $ffff ; id 2 end of list

; list for entry $5A (MadGopher) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MadGopher::
    dw MONSTER_DUMBIRA ; id 0
    dw $ffff ; id 1 end of list

; list for entry $5C (Unicorn) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Unicorn::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_ROBOSTER ; id 6
    dw MONSTER_LAVAMAN ; id 7
    dw MONSTER_ICEMAN ; id 8
    dw MONSTER_GOLEM ; id 9
    dw MONSTER_STONEMAN ; id 10
    dw $ffff ; id 11 end of list

; list for entry $5D (Goategon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Goategon::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ROBOSTER ; id 1
    dw MONSTER_LAVAMAN ; id 2
    dw MONSTER_ICEMAN ; id 3
    dw MONSTER_GOLEM ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_PTERANOD ; id 7
    dw MONSTER_GASGON ; id 8
    dw MONSTER_SWORDGON ; id 9
    dw MONSTER_MADDRAGON ; id 10
    dw MONSTER_BATTLEREX ; id 11
    dw MONSTER_SKYDRAGON ; id 12
    dw $ffff ; id 13 end of list

; list for entry $5E (WildApe) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_WildApe::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_ROBOSTER ; id 6
    dw MONSTER_LAVAMAN ; id 7
    dw MONSTER_ICEMAN ; id 8
    dw MONSTER_GOLEM ; id 9
    dw MONSTER_STONEMAN ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_PTERANOD ; id 12
    dw MONSTER_GASGON ; id 13
    dw MONSTER_SWORDGON ; id 14
    dw MONSTER_MADDRAGON ; id 15
    dw MONSTER_BATTLEREX ; id 16
    dw MONSTER_SKYDRAGON ; id 17
    dw $fdfd ; id 18 next result
    dw MONSTER_WILDAPE ; id 19
    dw $ffff ; id 20 end of list

; list for entry $5F (Trumpeter) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Trumpeter::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw MONSTER_ROBOSTER ; id 5
    dw MONSTER_LAVAMAN ; id 6
    dw MONSTER_ICEMAN ; id 7
    dw MONSTER_GOLEM ; id 8
    dw MONSTER_STONEMAN ; id 9
    dw $fdfd ; id 10 next result
    dw MONSTER_TRUMPETER ; id 11
    dw MONSTER_BOSSTROLL ; id 12
    dw MONSTER_METALDRAK ; id 13
    dw MONSTER_BALZAK ; id 14
    dw MONSTER_GOLDGOLEM ; id 15
    dw $fbfb ; id 16 next result when wArg1 = 2, else end of list
    dw MONSTER_GARUDIAN ; id 17
    dw $ffff ; id 18 end of list

; list for entry $61 (DarkHorn) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DarkHorn::
    dw MONSTER_OROCHI ; id 0
    dw $ffff ; id 1 end of list

; list for entry $62 (MadCat) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MadCat::
    dw MONSTER_PTERANOD ; id 0
    dw MONSTER_GASGON ; id 1
    dw MONSTER_SWORDGON ; id 2
    dw MONSTER_MADDRAGON ; id 3
    dw MONSTER_BATTLEREX ; id 4
    dw MONSTER_SKYDRAGON ; id 5
    dw $fbfb ; id 6 next result when wArg1 = 2, else end of list
    dw MONSTER_LAMPGENIE ; id 7
    dw $ffff ; id 8 end of list

; list for entry $65 (CatMage) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_CatMage::
    dw MONSTER_UNICORN ; id 0
    dw MONSTER_GOATEGON ; id 1
    dw $ffff ; id 2 end of list

; list for entry $66 (Dumbira) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Dumbira::
    dw MONSTER_DIGSTER ; id 0
    dw MONSTER_SKULLGON ; id 1
    dw MONSTER_DEADNOBLE ; id 2
    dw MONSTER_WHITEKING ; id 3
    dw MONSTER_SKELETOR ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_ROBOSTER ; id 6
    dw MONSTER_LAVAMAN ; id 7
    dw MONSTER_ICEMAN ; id 8
    dw MONSTER_GOLEM ; id 9
    dw MONSTER_STONEMAN ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_BLIZZARDY ; id 12
    dw $ffff ; id 13 end of list

; list for entry $6C (BullBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_BullBird::
    dw MONSTER_GRIZZLY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $6F (MadPecker) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MadPecker::
    dw MONSTER_BIGEYE ; id 0
    dw MONSTER_DARKEYE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $72 (AquaHawk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_AquaHawk::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_WINGSNAKE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $74 (KiteHawk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_KiteHawk::
    dw MONSTER_BIGROOST ; id 0
    dw $ffff ; id 1 end of list

; list for entry $77 (LandOwl) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_LandOwl::
    dw MONSTER_ROCKSLIME ; id 0
    dw MONSTER_SLIMEBORG ; id 1
    dw MONSTER_DIGSTER ; id 2
    dw MONSTER_METALDRAK ; id 3
    dw MONSTER_GOLEM ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw MONSTER_MERMAN ; id 6
    dw $ffff ; id 7 end of list

; list for entry $78 (MadGoose) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MadGoose::
    dw MONSTER_ROCKSLIME ; id 0
    dw MONSTER_SLIMEBORG ; id 1
    dw MONSTER_DIGSTER ; id 2
    dw MONSTER_METALDRAK ; id 3
    dw MONSTER_GOLEM ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw MONSTER_MERMAN ; id 6
    dw $ffff ; id 7 end of list

; list for entry $79 (MadCondor) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MadCondor::
    dw MONSTER_MADPECKER ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GISMO ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_ROCKSLIME ; id 4
    dw MONSTER_SLIMEBORG ; id 5
    dw MONSTER_DIGSTER ; id 6
    dw MONSTER_METALDRAK ; id 7
    dw MONSTER_GOLEM ; id 8
    dw MONSTER_STONEMAN ; id 9
    dw MONSTER_MERMAN ; id 10
    dw $ffff ; id 11 end of list

; list for entry $7B (Blizzardy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Blizzardy::
    dw MONSTER_LIONEX ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_ROCKSLIME ; id 2
    dw MONSTER_SLIMEBORG ; id 3
    dw MONSTER_DIGSTER ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_GOLEM ; id 6
    dw MONSTER_STONEMAN ; id 7
    dw MONSTER_MERMAN ; id 8
    dw $fdfd ; id 9 next result
    dw MONSTER_VAMPIRUS ; id 10
    dw MONSTER_PHOENIX ; id 11
    dw $ffff ; id 12 end of list

; list for entry $7C (Phoenix) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Phoenix::
    dw MONSTER_GISMO ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_LIONEX ; id 2
    dw $ffff ; id 3 end of list

; list for entry $7D (ZapBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_ZapBird::
    dw MONSTER_LIONEX ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_ROCKSLIME ; id 2
    dw MONSTER_SLIMEBORG ; id 3
    dw MONSTER_DIGSTER ; id 4
    dw MONSTER_METALDRAK ; id 5
    dw MONSTER_GOLEM ; id 6
    dw MONSTER_STONEMAN ; id 7
    dw MONSTER_MERMAN ; id 8
    dw $ffff ; id 9 end of list

; list for entry $7E (Garudian) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Garudian::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_TRUMPETER ; id 1
    dw $ffff ; id 2 end of list

; list for entry $7F (WhipBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_WhipBird::
    dw MONSTER_GISMO ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GREATDRAK ; id 2
    dw MONSTER_JAMIRUS ; id 3
    dw $ffff ; id 4 end of list

; list for entry $80 (FunkyBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_FunkyBird::
    dw MONSTER_JAMIRUS ; id 0
    dw $ffff ; id 1 end of list

; list for entry $81 (RainHawk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_RainHawk::
    dw MONSTER_GOLDGOLEM ; id 0
    dw $ffff ; id 1 end of list

; list for entry $83 (Shantak) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Shantak::
    dw MONSTER_GOLDGOLEM ; id 0
    dw $ffff ; id 1 end of list

; list for entry $84 (CragDevil) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_CragDevil::
    dw MONSTER_DUCKKITE ; id 0
    dw MONSTER_MADRAVEN ; id 1
    dw $fdfd ; id 2 next result
    dw $fe04 ; id 3 same species, parent B +4 or more
    dw $fc04 ; id 4 same species, parent A +4 or more
    dw $ffff ; id 5 end of list

; list for entry $96 (Stubsuck) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Stubsuck::
    dw MONSTER_PUPPETOR ; id 0
    dw $ffff ; id 1 end of list

; list for entry $99 (TreeBoy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_TreeBoy::
    dw MONSTER_SLIMENITE ; id 0
    dw MONSTER_HAMMERMAN ; id 1
    dw MONSTER_BEASTNITE ; id 2
    dw $ffff ; id 3 end of list

; list for entry $9E (EvilSeed) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_EvilSeed::
    dw MONSTER_SLURPERON ; id 0
    dw MONSTER_EVILSEED ; id 1
    dw $ffff ; id 2 end of list

; list for entry $9F (ManEater) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_ManEater::
    dw MONSTER_MANEATER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $A1 (GhosTree) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_GhosTree::
    dw MONSTER_GHOSTREE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SNAPPER ; id 2
    dw $ffff ; id 3 end of list

; list for entry $A2 (Rosevine) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Rosevine::
    dw MONSTER_GIGANTES ; id 0
    dw $ffff ; id 1 end of list

; list for entry $A4 (Warubou) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Warubou::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_WATABOU ; id 1
    dw $ffff ; id 2 end of list

; list for entry $A7 (FooHero) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_FooHero::
    dw MONSTER_EVILWAND ; id 0
    dw $ffff ; id 1 end of list

; list for entry $B1 (Catapila) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Catapila::
    dw MONSTER_CATAPILA ; id 0

; list for entry $B3 (Butterfly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Butterfly::
    dw MONSTER_BUTTERFLY ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_PYURO ; id 2
    dw $ffff ; id 3 end of list

; list for entry $B4 (WeedBug) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_WeedBug::
    dw MONSTER_ANEMON ; id 0
    dw $ffff ; id 1 end of list

; list for entry $B6 (Lipsy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Lipsy::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOKID ; id 1
    dw MONSTER_ANGLERON ; id 2
    dw $ffff ; id 3 end of list

; list for entry $B7 (StagBug) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_StagBug::
    dw MONSTER_STAGBUG ; id 0
    dw $ffff ; id 1 end of list

; list for entry $BB (TailEater) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_TailEater::
    dw MONSTER_TAILEATER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $BD (Eyeder) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Eyeder::
    dw MONSTER_EYEDER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C0 (ArmyCrab) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_ArmyCrab::
    dw MONSTER_CLAWSTER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C1 (MadHornet) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MadHornet::
    dw MONSTER_GOHOPPER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C3 (WarMantis) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_WarMantis::
    dw MONSTER_ROGUENITE ; id 0
    dw MONSTER_CANCERMAN ; id 1
    dw MONSTER_OCTORAID ; id 2
    dw $ffff ; id 3 end of list

; list for entry $C4 (HornBeet) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_HornBeet::
    dw MONSTER_HORNBEET ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C6 (Armorpion) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Armorpion::
    dw MONSTER_WHITEKING ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C9 (MultiEyes) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MultiEyes::
    dw MONSTER_BUTTERFLY ; id 0
    dw MONSTER_PYURO ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_ROCKSLIME ; id 3
    dw MONSTER_TORTRAGON ; id 4
    dw MONSTER_IRONTURT ; id 5
    dw $ffff ; id 6 end of list

; list for entry $D5 (AgDevil) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_AgDevil::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_SPOTKING ; id 1
    dw MONSTER_METALKING ; id 2
    dw MONSTER_ANDREAL ; id 3
    dw MONSTER_GREATDRAK ; id 4
    dw MONSTER_OROCHI ; id 5
    dw MONSTER_TRUMPETER ; id 6
    dw MONSTER_KINGLEO ; id 7
    dw MONSTER_ZAPBIRD ; id 8
    dw MONSTER_GARUDIAN ; id 9
    dw MONSTER_WHIPBIRD ; id 10
    dw MONSTER_METALDRAK ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_GULPBEAST ; id 13
    dw MONSTER_UNICORN ; id 14
    dw MONSTER_DIGSTER ; id 15
    dw MONSTER_ROBOSTER ; id 16
    dw MONSTER_WALRUSMAN ; id 17
    dw MONSTER_MERTIGER ; id 18
    dw $fdfd ; id 19 next result
    dw MONSTER_SLIMEBORG ; id 20
    dw MONSTER_SWORDGON ; id 21
    dw MONSTER_COATOL ; id 22
    dw MONSTER_MISTYWING ; id 23
    dw MONSTER_MADCONDOR ; id 24
    dw MONSTER_ROSEVINE ; id 25
    dw MONSTER_GIANTMOTH ; id 26
    dw MONSTER_SKULLGON ; id 27
    dw MONSTER_DEADNOBLE ; id 28
    dw MONSTER_WHITEKING ; id 29
    dw MONSTER_AXESHARK ; id 30
    dw $ffff ; id 31 end of list

; list for entry $D6 (Demonite) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Demonite::
    dw MONSTER_DEMONITE ; id 0
    dw $ffff ; id 1 end of list

; list for entry $D7 (DarkEye) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DarkEye::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOREACH ; id 1
    dw $ffff ; id 2 end of list

; list for entry $DB (Bubblemon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Bubblemon::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_DEADNITE ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_EVILPOT ; id 3
    dw $ffff ; id 4 end of list

; list for entry $DC (1EyeClown) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_1EyeClown::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOREACH ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_1EYECLOWN ; id 3
    dw $ffff ; id 4 end of list

; list for entry $DD (Gremlin) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Gremlin::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOREACH ; id 1
    dw $ffff ; id 2 end of list

; list for entry $DE (ArcDemon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_ArcDemon::
    dw MONSTER_GARUDIAN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GATEGUARD ; id 2
    dw $ffff ; id 3 end of list

; list for entry $DF (Lionex) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Lionex::
    dw MONSTER_MIMESLIME ; id 0
    dw $ffff ; id 1 end of list

; list for entry $E2 (Ogre) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Ogre::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BALZAK ; id 1
    dw MONSTER_STONEMAN ; id 2
    dw MONSTER_WALRUSMAN ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_LAVAMAN ; id 5
    dw $ffff ; id 6 end of list

; list for entry $E5 (BossTroll) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_BossTroll::
    dw MONSTER_ICEMAN ; id 0
    dw $fbfb ; id 1 next result when wArg1 = 2, else end of list
    dw MONSTER_CURSELAMP ; id 2
    dw $ffff ; id 3 end of list

; list for entry $E6 (Grendal) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Grendal::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_SPOTKING ; id 1
    dw MONSTER_METALKING ; id 2
    dw MONSTER_ANDREAL ; id 3
    dw MONSTER_GREATDRAK ; id 4
    dw MONSTER_OROCHI ; id 5
    dw MONSTER_TRUMPETER ; id 6
    dw MONSTER_KINGLEO ; id 7
    dw MONSTER_ZAPBIRD ; id 8
    dw MONSTER_GARUDIAN ; id 9
    dw MONSTER_WHIPBIRD ; id 10
    dw MONSTER_METALDRAK ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_GULPBEAST ; id 13
    dw MONSTER_UNICORN ; id 14
    dw MONSTER_DIGSTER ; id 15
    dw MONSTER_ROBOSTER ; id 16
    dw MONSTER_WALRUSMAN ; id 17
    dw MONSTER_MERTIGER ; id 18
    dw $fdfd ; id 19 next result
    dw MONSTER_SLIMEBORG ; id 20
    dw MONSTER_SWORDGON ; id 21
    dw MONSTER_COATOL ; id 22
    dw MONSTER_MISTYWING ; id 23
    dw MONSTER_MADCONDOR ; id 24
    dw MONSTER_ROSEVINE ; id 25
    dw MONSTER_GIANTMOTH ; id 26
    dw MONSTER_SKULLGON ; id 27
    dw MONSTER_DEADNOBLE ; id 28
    dw MONSTER_WHITEKING ; id 29
    dw MONSTER_AXESHARK ; id 30
    dw $fdfd ; id 31 next result
    dw MONSTER_GRENDAL ; id 32
    dw $fbfb ; id 33 next result when wArg1 = 2, else end of list
    dw MONSTER_SKELETOR ; id 34
    dw $ffff ; id 35 end of list

; list for entry $E7 (Akubar) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Akubar::
    dw MONSTER_RAINHAWK ; id 0
    dw $ffff ; id 1 end of list

; list for entry $EA (Gigantes) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Gigantes::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_SPOTKING ; id 1
    dw MONSTER_METALKING ; id 2
    dw MONSTER_ANDREAL ; id 3
    dw MONSTER_GREATDRAK ; id 4
    dw MONSTER_OROCHI ; id 5
    dw MONSTER_TRUMPETER ; id 6
    dw MONSTER_KINGLEO ; id 7
    dw MONSTER_ZAPBIRD ; id 8
    dw MONSTER_GARUDIAN ; id 9
    dw MONSTER_WHIPBIRD ; id 10
    dw MONSTER_METALDRAK ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_GULPBEAST ; id 13
    dw MONSTER_UNICORN ; id 14
    dw MONSTER_DIGSTER ; id 15
    dw MONSTER_ROBOSTER ; id 16
    dw MONSTER_WALRUSMAN ; id 17
    dw MONSTER_MERTIGER ; id 18
    dw $fdfd ; id 19 next result
    dw MONSTER_SLIMEBORG ; id 20
    dw MONSTER_SWORDGON ; id 21
    dw MONSTER_COATOL ; id 22
    dw MONSTER_MISTYWING ; id 23
    dw MONSTER_MADCONDOR ; id 24
    dw MONSTER_ROSEVINE ; id 25
    dw MONSTER_GIANTMOTH ; id 26
    dw MONSTER_SKULLGON ; id 27
    dw MONSTER_DEADNOBLE ; id 28
    dw MONSTER_WHITEKING ; id 29
    dw MONSTER_AXESHARK ; id 30
    dw $ffff ; id 31 end of list

; list for entry $EB (Centasaur) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Centasaur::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BALZAK ; id 1
    dw MONSTER_STONEMAN ; id 2
    dw MONSTER_WALRUSMAN ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_GOLDGOLEM ; id 5
    dw $ffff ; id 6 end of list

; list for entry $ED (Jamirus) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Jamirus::
    dw MONSTER_SERPENTIA ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_ROSEVINE ; id 2
    dw $ffff ; id 3 end of list

; list for entry $EE (Durran) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Durran::
    dw MONSTER_DARKHORN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_DIVINEGON ; id 2
    dw $ffff ; id 3 end of list

; list for entry $F0 (LampGenie) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_LampGenie::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_MADCAT ; id 1
    dw $ffff ; id 2 end of list

; list for entry $F7 (Skullgon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Skullgon::
    dw MONSTER_COPYCAT ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_KINGSLIME ; id 2
    dw $ffff ; id 3 end of list

; list for entry $F8 (PutrePup) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_PutrePup::
    dw MONSTER_MISTYWING ; id 0
    dw $ffff ; id 1 end of list

; list for entry $FA (Mummy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Mummy::
    dw MONSTER_ROCKSLIME ; id 0
    dw MONSTER_SLIMEBORG ; id 1
    dw MONSTER_LANDOWL ; id 2
    dw MONSTER_MADGOOSE ; id 3
    dw MONSTER_FLORAMAN ; id 4
    dw MONSTER_HORNBEET ; id 5
    dw MONSTER_GREMLIN ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_GULPBEAST ; id 8
    dw MONSTER_GRIZZLY ; id 9
    dw MONSTER_MADCAT ; id 10
    dw MONSTER_MADRAVEN ; id 11
    dw MONSTER_MADCONDOR ; id 12
    dw MONSTER_EVILBEAST ; id 13
    dw MONSTER_OGRE ; id 14
    dw MONSTER_GOLEM ; id 15
    dw MONSTER_STONEMAN ; id 16
    dw $ffff ; id 17 end of list

; list for entry $FC (DeadNite) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_DeadNite::
    dw MONSTER_DEADNITE ; id 0
    dw MONSTER_COPYCAT ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_ROCKSLIME ; id 3
    dw MONSTER_SLIMEBORG ; id 4
    dw MONSTER_LANDOWL ; id 5
    dw MONSTER_MADGOOSE ; id 6
    dw MONSTER_FLORAMAN ; id 7
    dw MONSTER_HORNBEET ; id 8
    dw MONSTER_GREMLIN ; id 9
    dw $fdfd ; id 10 next result
    dw MONSTER_GULPBEAST ; id 11
    dw MONSTER_GRIZZLY ; id 12
    dw MONSTER_MADCAT ; id 13
    dw MONSTER_MADRAVEN ; id 14
    dw MONSTER_MADCONDOR ; id 15
    dw MONSTER_EVILBEAST ; id 16
    dw MONSTER_OGRE ; id 17
    dw MONSTER_GOLEM ; id 18
    dw MONSTER_STONEMAN ; id 19
    dw $fbfb ; id 20 next result when wArg1 = 2, else end of list
    dw MONSTER_BUBBLEMON ; id 21
    dw $ffff ; id 22 end of list

; list for entry $FF (Hork) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Hork::
    dw MONSTER_HORK ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GULPBEAST ; id 2
    dw MONSTER_GRIZZLY ; id 3
    dw MONSTER_MADCAT ; id 4
    dw MONSTER_MADRAVEN ; id 5
    dw MONSTER_MADCONDOR ; id 6
    dw MONSTER_EVILBEAST ; id 7
    dw MONSTER_OGRE ; id 8
    dw MONSTER_GOLEM ; id 9
    dw MONSTER_STONEMAN ; id 10
    dw $ffff ; id 11 end of list

; list for entry $100 (Mudron) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Mudron::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_LIONEX ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_COPYCAT ; id 3
    dw MONSTER_METALDRAK ; id 4
    dw MONSTER_ROBOSTER ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_GULPBEAST ; id 7
    dw MONSTER_GRIZZLY ; id 8
    dw MONSTER_MADCAT ; id 9
    dw MONSTER_MADRAVEN ; id 10
    dw MONSTER_MADCONDOR ; id 11
    dw MONSTER_EVILBEAST ; id 12
    dw MONSTER_OGRE ; id 13
    dw MONSTER_GOLEM ; id 14
    dw MONSTER_STONEMAN ; id 15
    dw $ffff ; id 16 end of list

; list for entry $101 (NiteWhip) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_NiteWhip::
    dw MONSTER_MORAY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $106 (CaptDead) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_CaptDead::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_LIONEX ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_COPYCAT ; id 3
    dw MONSTER_METALDRAK ; id 4
    dw MONSTER_ROBOSTER ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_GULPBEAST ; id 7
    dw MONSTER_GRIZZLY ; id 8
    dw MONSTER_MADCAT ; id 9
    dw MONSTER_MADRAVEN ; id 10
    dw MONSTER_MADCONDOR ; id 11
    dw MONSTER_EVILBEAST ; id 12
    dw MONSTER_OGRE ; id 13
    dw MONSTER_GOLEM ; id 14
    dw MONSTER_STONEMAN ; id 15
    dw $ffff ; id 16 end of list

; list for entry $107 (DeadNoble) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DeadNoble::
    dw MONSTER_SPOTKING ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SERPENTIA ; id 2
    dw MONSTER_ROBOSTER2 ; id 3
    dw MONSTER_OCTORAID ; id 4
    dw $ffff ; id 5 end of list

; list for entry $108 (WhiteKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_WhiteKing::
    dw MONSTER_DRACOLORD ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_METALKING ; id 2
    dw $ffff ; id 3 end of list

; list for entry $109 (BoneSlave) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_BoneSlave::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_LIONEX ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_COPYCAT ; id 3
    dw MONSTER_METALDRAK ; id 4
    dw MONSTER_ROBOSTER ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_METALKING ; id 7
    dw $fdfd ; id 8 next result
    dw MONSTER_BONESLAVE ; id 9
    dw $ffff ; id 10 end of list

; list for entry $10A (Skeletor) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Skeletor::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_LIONEX ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_COPYCAT ; id 3
    dw MONSTER_METALDRAK ; id 4
    dw MONSTER_ROBOSTER ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_ANDREAL ; id 7
    dw MONSTER_GREATDRAK ; id 8
    dw MONSTER_KINGLEO ; id 9
    dw MONSTER_BLIZZARDY ; id 10
    dw MONSTER_ZAPBIRD ; id 11
    dw MONSTER_WHIPBIRD ; id 12
    dw MONSTER_GOLDGOLEM ; id 13
    dw MONSTER_WHALEMAGE ; id 14
    dw MONSTER_GRAKOS ; id 15
    dw $fdfd ; id 16 next result
    dw MONSTER_SKELETOR ; id 17
    dw $fdfd ; id 18 next result
    dw MONSTER_SERPENTIA ; id 19
    dw MONSTER_ROBOSTER2 ; id 20
    dw MONSTER_OCTORAID ; id 21
    dw $fbfb ; id 22 next result when wArg1 = 2, else end of list
    dw MONSTER_GRENDAL ; id 23
    dw $ffff ; id 24 end of list

; list for entry $10B (Servant) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Servant::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_GREATDRAK ; id 1
    dw $ffff ; id 2 end of list

; list for entry $10D (Copycat) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Copycat::
    dw MONSTER_GASGON ; id 0
    dw MONSTER_DROLL ; id 1
    dw $ffff ; id 2 end of list

; list for entry $10E (MadSpirit) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MadSpirit::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_LIONEX ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_METALDRAK ; id 3
    dw MONSTER_ROBOSTER ; id 4
    dw MONSTER_ROBOSTER2 ; id 5
    dw $ffff ; id 6 end of list

; list for entry $110 (Niterich) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Niterich::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_GREATDRAK ; id 1
    dw MONSTER_KINGLEO ; id 2
    dw MONSTER_BLIZZARDY ; id 3
    dw MONSTER_ZAPBIRD ; id 4
    dw MONSTER_WHIPBIRD ; id 5
    dw MONSTER_GOLDGOLEM ; id 6
    dw MONSTER_WHALEMAGE ; id 7
    dw MONSTER_GRAKOS ; id 8
    dw $ffff ; id 9 end of list

; list for entry $11A (EvilWand) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_EvilWand::
    dw MONSTER_LANDOWL ; id 0
    dw MONSTER_MADGOOSE ; id 1
    dw MONSTER_PHOENIX ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw $ffff ; id 4 end of list

; list for entry $11B (MadCandle) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MadCandle::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WYVERN ; id 1
    dw MONSTER_MISTYWING ; id 2
    dw MONSTER_FIREWEED ; id 3
    dw MONSTER_EVILSEED ; id 4
    dw MONSTER_ANEMON ; id 5
    dw $ffff ; id 6 end of list

; list for entry $11E (SpikyBoy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_SpikyBoy::
    dw MONSTER_SPIKYBOY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $11F (MadMirror) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MadMirror::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WYVERN ; id 1
    dw MONSTER_MISTYWING ; id 2
    dw MONSTER_FIREWEED ; id 3
    dw MONSTER_EVILSEED ; id 4
    dw MONSTER_ANEMON ; id 5
    dw $ffff ; id 6 end of list

; list for entry $121 (Puppetor) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Puppetor::
    dw MONSTER_PIXY ; id 0
    dw MONSTER_DEMONITE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $122 (Goopi) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Goopi::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WYVERN ; id 1
    dw MONSTER_MISTYWING ; id 2
    dw MONSTER_FIREWEED ; id 3
    dw MONSTER_EVILSEED ; id 4
    dw MONSTER_ANEMON ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_GOOPI ; id 7
    dw MONSTER_CANCERMAN ; id 8
    dw $ffff ; id 9 end of list

; list for entry $123 (Voodoll) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Voodoll::
    dw MONSTER_LANDOWL ; id 0
    dw MONSTER_MADGOOSE ; id 1
    dw MONSTER_PHOENIX ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw $ffff ; id 4 end of list

; list for entry $124 (MetalDrak) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MetalDrak::
    dw MONSTER_OROCHI ; id 0
    dw MONSTER_KINGLEO ; id 1
    dw MONSTER_ZAPBIRD ; id 2
    dw MONSTER_ARCDEMON ; id 3
    dw MONSTER_BOSSTROLL ; id 4
    dw MONSTER_CENTASAUR ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_SKULLGON ; id 7
    dw MONSTER_WHITEKING ; id 8
    dw $ffff ; id 9 end of list

; list for entry $126 (SabreMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_SabreMan::
    dw MONSTER_SLIMEBORG ; id 0
    dw MONSTER_GREATDRAK ; id 1
    dw MONSTER_UNICORN ; id 2
    dw MONSTER_OGRE ; id 3
    dw MONSTER_GRENDAL ; id 4
    dw MONSTER_EVILARMOR ; id 5
    dw MONSTER_DEADNOBLE ; id 6
    dw MONSTER_SKELETOR ; id 7
    dw $ffff ; id 8 end of list

; list for entry $127 (CurseLamp) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_CurseLamp::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_BOSSTROLL ; id 1
    dw $ffff ; id 2 end of list

; list for entry $129 (Roboster) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Roboster::
    dw MONSTER_METALDRAK ; id 0
    dw $fdfd ; id 1 next result
    dw $fe05 ; id 2 same species, parent B +5 or more
    dw $fc05 ; id 3 same species, parent A +5 or more
    dw $fdfd ; id 4 next result
    dw MONSTER_KINGLEO ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_RUSHFISH ; id 7
    dw $fbfb ; id 8 next result when wArg1 = 2, else end of list
    dw MONSTER_ROBOSTER ; id 9
    dw $ffff ; id 10 end of list

; list for entry $12A (Roboster2) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Roboster2::
    dw MONSTER_METALDRAK ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_KINGLEO ; id 2
    dw $ffff ; id 3 end of list

; list for entry $12B (EvilPot) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_EvilPot::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_BUBBLEMON ; id 1
    dw $ffff ; id 2 end of list

; list for entry $12C (Gismo) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Gismo::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_SPOTKING ; id 1
    dw MONSTER_SKYDRAGON ; id 2
    dw MONSTER_LAMPGENIE ; id 3
    dw MONSTER_WHITEKING ; id 4
    dw MONSTER_KINGSQUID ; id 5
    dw MONSTER_WHALEMAGE ; id 6
    dw MONSTER_DRACOLORD ; id 7
    dw $ffff ; id 8 end of list

; list for entry $12D (LavaMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_LavaMan::
    dw MONSTER_BOSSTROLL ; id 0
    dw $ffff ; id 1 end of list

; list for entry $12E (IceMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_IceMan::
    dw MONSTER_LAVAMAN ; id 0
    dw $ffff ; id 1 end of list

; list for entry $12F (Mimic) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Mimic::
    dw MONSTER_SCALLOPA ; id 0
    dw $ffff ; id 1 end of list

; list for entry $131 (MudDoll) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_MudDoll::
    dw MONSTER_MUDDOLL ; id 0
    dw $ffff ; id 1 end of list

; list for entry $132 (Golem) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Golem::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_SNAILY ; id 1
    dw MONSTER_SLIMENITE ; id 2
    dw MONSTER_ROCKSLIME ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_LANDOWL ; id 5
    dw MONSTER_MADGOOSE ; id 6
    dw MONSTER_PHOENIX ; id 7
    dw MONSTER_FUNKYBIRD ; id 8
    dw $fdfd ; id 9 next result
    dw MONSTER_GOLEM ; id 10
    dw $ffff ; id 11 end of list

; list for entry $133 (StoneMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_StoneMan::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_SNAILY ; id 1
    dw MONSTER_SLIMENITE ; id 2
    dw MONSTER_ROCKSLIME ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_ANDREAL ; id 5
    dw MONSTER_SPIKEROUS ; id 6
    dw MONSTER_GREATDRAK ; id 7
    dw $fdfd ; id 8 next result
    dw MONSTER_LANDOWL ; id 9
    dw MONSTER_MADGOOSE ; id 10
    dw MONSTER_PHOENIX ; id 11
    dw MONSTER_FUNKYBIRD ; id 12
    dw $ffff ; id 13 end of list

; list for entry $135 (GoldGolem) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_GoldGolem::
    dw MONSTER_METALKING ; id 0
    dw $ffff ; id 1 end of list

; list for entry $141 (Aquarella) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Aquarella::
    dw MONSTER_DARKEYE ; id 0
    dw MONSTER_MEDUSAEYE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $142 (Merman) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Merman::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_MADCAT ; id 1
    dw $ffff ; id 2 end of list

; list for entry $145 (Octoreach) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Octoreach::
    dw $fe05 ; id 0 same species, parent B +5 or more
    dw $fc05 ; id 1 same species, parent A +5 or more
    dw $ffff ; id 2 end of list

; list for entry $146 (Angleron) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Angleron::
    dw MONSTER_PIXY ; id 0
    dw MONSTER_DEMONITE ; id 1
    dw MONSTER_SKULRIDER ; id 2
    dw MONSTER_GREMLIN ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_GULPBEAST ; id 5
    dw MONSTER_DROLL ; id 6
    dw $ffff ; id 7 end of list

; list for entry $148 (RushFish) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_RushFish::
    dw MONSTER_SPIKEROUS ; id 0
    dw MONSTER_ROGUEWAVE ; id 1
    dw MONSTER_MADGOOSE ; id 2
    dw MONSTER_GIGANTES ; id 3
    dw MONSTER_GOLEM ; id 4
    dw $ffff ; id 5 end of list

; list for entry $149 (Gamanian) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Gamanian::
    dw MONSTER_ARMYCRAB ; id 0
    dw $ffff ; id 1 end of list

; list for entry $14A (Clawster) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Clawster::
    dw MONSTER_CLAWSTER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $14B (CancerMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_CancerMan::
    dw MONSTER_EVILWAND ; id 0
    dw MONSTER_WHALEMAGE ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_BATTLEREX ; id 3
    dw MONSTER_ARCDEMON ; id 4
    dw $ffff ; id 5 end of list

; list for entry $14C (RogueWave) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_RogueWave::
    dw MONSTER_MIMIC ; id 0
    dw $ffff ; id 1 end of list

; list for entry $14F (HoodSquid) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_HoodSquid::
    dw MONSTER_1EYECLOWN ; id 0
    dw MONSTER_REAPER ; id 1
    dw MONSTER_RUSHFISH ; id 2
    dw $ffff ; id 3 end of list

; list for entry $150 (MerTiger) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_MerTiger::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_BEASTNITE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $152 (Octogon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Octogon::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_GATEGUARD ; id 1
    dw MONSTER_CHOPCLOWN ; id 2
    dw MONSTER_EVILARMOR ; id 3
    dw $fdfd ; id 4 next result
    dw $fe05 ; id 5 same species, parent B +5 or more
    dw $fc05 ; id 6 same species, parent A +5 or more
    dw $ffff ; id 7 end of list

; list for entry $154 (Digong) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Digong::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_COATOL ; id 1
    dw MONSTER_ORLIGON ; id 2
    dw $ffff ; id 3 end of list

; list for entry $158 (Grakos) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Grakos::
    dw MONSTER_MUDOU ; id 0
    dw $ffff ; id 1 end of list

; list for entry $15F (DracoLord) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_DracoLord::
    dw MONSTER_DIVINEGON ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SIDOH ; id 2
    dw $ffff ; id 3 end of list

; list for entry $160 (DracoLord) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DracoLord_160::
    dw MONSTER_ORLIGON ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SIDOH ; id 2
    dw $ffff ; id 3 end of list

; list for entry $162 (Hargon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Hargon::
    dw MONSTER_OROCHI ; id 0
    dw $ffff ; id 1 end of list

; list for entry $163 (Sidoh) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Sidoh::
    dw MONSTER_TITANIS ; id 0
    dw $ffff ; id 1 end of list

; list for entry $165 (Baramos) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Baramos::
    dw MONSTER_DARKHORN ; id 0
    dw MONSTER_GORAGO ; id 1
    dw $ffff ; id 2 end of list

; list for entry $166 (Zoma) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Zoma::
    dw MONSTER_PSYCHOPIZ ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_AZURILE ; id 2
    dw MONSTER_MIRUDRAAS ; id 3
    dw MONSTER_MIRUDRAAS_16C ; id 4
    dw $ffff ; id 5 end of list

; list for entry $168 (Pizzaro) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Pizzaro::
    dw MONSTER_ESTERK ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_KINGLEO ; id 2
    dw MONSTER_GORAGO ; id 3
    dw $ffff ; id 4 end of list

; list for entry $169 (PsychoPiz) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_PsychoPiz::
    dw MONSTER_NITERICH ; id 0
    dw $ffff ; id 1 end of list

; list for entry $16A (Esterk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_Esterk::
    dw MONSTER_GOLDSLIME ; id 0
    dw $ffff ; id 1 end of list

; list for entry $16B (Mirudraas) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Mirudraas::
    dw MONSTER_SPIKEROUS ; id 0
    dw MONSTER_ORLIGON ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_AZURILE ; id 3
    dw $ffff ; id 4 end of list

; list for entry $16C (Mirudraas) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Mirudraas_16C::
    dw MONSTER_ZOMA ; id 0
    dw $ffff ; id 1 end of list

; list for entry $16E (DeathMore) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DeathMore::
    dw MONSTER_ARMORPION ; id 0
    dw MONSTER_TITANIS ; id 1
    dw $ffff ; id 2 end of list

; list for entry $16F (DeathMore) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules_DeathMore_16F::
    dw MONSTER_DARKMATE ; id 0
    dw MONSTER_POSEIDON ; id 1
    dw MONSTER_MUDOU ; id 2
    dw $ffff ; id 3 end of list

; list for entry $170 (DeathMore) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_DeathMore_170::
    dw MONSTER_GRANSLIME ; id 0
    dw MONSTER_WATABOU ; id 1
    dw MONSTER_ASURAZOMA ; id 2
    dw $ffff ; id 3 end of list

; list for entry $172 (Orgodemir) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules_Orgodemir::
    dw MONSTER_LORDDRACO ; id 0
    dw MONSTER_GIGADRACO ; id 1
    dw $ffff ; id 2 end of list

; stage 1 result lists, indexed like BreedSpeciesRuleTable; the matched result word becomes the
; child's species (wArg6/wArg7) (E-0199, C1)
; record: list
BreedSpeciesResultTable::
    dw BreedSpeciesResults000 ; id 0
    dw BreedSpeciesResults_DrakSlime ; id 1 DrakSlime
    dw BreedSpeciesResults_SpotSlime ; id 2 SpotSlime
    dw BreedSpeciesResults_WingSlime ; id 3 WingSlime
    dw BreedSpeciesResults_WingSlime ; id 4 TreeSlime
    dw BreedSpeciesResults_WingSlime ; id 5 Snaily
    dw BreedSpeciesResults_WingSlime ; id 6 SlimeNite
    dw BreedSpeciesResults_Babble ; id 7 Babble
    dw BreedSpeciesResults_Babble ; id 8 BoxSlime
    dw BreedSpeciesResults_Babble ; id 9 PearlGel
    dw BreedSpeciesResults_Babble ; id 10 Slime
    dw BreedSpeciesResults_Healer ; id 11 Healer
    dw BreedSpeciesResults_FangSlime ; id 12 FangSlime
    dw BreedSpeciesResults_FangSlime ; id 13 RockSlime
    dw BreedSpeciesResults_SlimeBorg ; id 14 SlimeBorg
    dw BreedSpeciesResults_SlimeBorg ; id 15 Slabbit
    dw BreedSpeciesResults_SlimeBorg ; id 16 KingSlime
    dw BreedSpeciesResults_Metaly ; id 17 Metaly
    dw BreedSpeciesResults_Metabble ; id 18 Metabble
    dw BreedSpeciesResults_SpotKing ; id 19 SpotKing
    dw BreedSpeciesResults_TropicGel ; id 20 TropicGel
    dw BreedSpeciesResults_TropicGel ; id 21 MimeSlime
    dw BreedSpeciesResults_HaloSlime ; id 22 HaloSlime
    dw BreedSpeciesResults_HaloSlime ; id 23 MetalKing
    dw BreedSpeciesResults_GoldSlime ; id 24 GoldSlime
    dw BreedSpeciesResults_GranSlime ; id 25 GranSlime
    dw BreedSpeciesResults_GranSlime ; id 26 WonderEgg
    dw BreedSpeciesResults_Butch ; id 27 Butch
    dw BreedSpeciesResults_Butch ; id 28 ?
    dw BreedSpeciesResults_Butch ; id 29 ?
    dw BreedSpeciesResults_Butch ; id 30 ?
    dw BreedSpeciesResults_Butch ; id 31 ?
    dw BreedSpeciesResults_Butch ; id 32 ?
    dw BreedSpeciesResults_Butch ; id 33 ?
    dw BreedSpeciesResults_Butch ; id 34 ?
    dw BreedSpeciesResults_Butch ; id 35 ?
    dw BreedSpeciesResults_Butch ; id 36 DragonKid
    dw BreedSpeciesResults_Tortragon ; id 37 Tortragon
    dw BreedSpeciesResults_Tortragon ; id 38 Pteranod
    dw BreedSpeciesResults_Gasgon ; id 39 Gasgon
    dw BreedSpeciesResults_FairyDrak ; id 40 FairyDrak
    dw BreedSpeciesResults_FairyDrak ; id 41 LizardMan
    dw BreedSpeciesResults_Poisongon ; id 42 Poisongon
    dw BreedSpeciesResults_Poisongon ; id 43 Swordgon
    dw BreedSpeciesResults_Poisongon ; id 44 Drygon
    dw BreedSpeciesResults_Poisongon ; id 45 Dragon
    dw BreedSpeciesResults_MiniDrak ; id 46 MiniDrak
    dw BreedSpeciesResults_MiniDrak ; id 47 MadDragon
    dw BreedSpeciesResults_Rayburn ; id 48 Rayburn
    dw BreedSpeciesResults_Rayburn ; id 49 Chamelgon
    dw BreedSpeciesResults_Rayburn ; id 50 LizardFly
    dw BreedSpeciesResults_Rayburn ; id 51 Andreal
    dw BreedSpeciesResults_KingCobra ; id 52 KingCobra
    dw BreedSpeciesResults_Vampirus ; id 53 Vampirus
    dw BreedSpeciesResults_SnakeBat ; id 54 SnakeBat
    dw BreedSpeciesResults_SnakeBat ; id 55 Spikerous
    dw BreedSpeciesResults_SnakeBat ; id 56 GreatDrak
    dw BreedSpeciesResults_Crestpent ; id 57 Crestpent
    dw BreedSpeciesResults_WingSnake ; id 58 WingSnake
    dw BreedSpeciesResults_Coatol ; id 59 Coatol
    dw BreedSpeciesResults_Coatol ; id 60 Orochi
    dw BreedSpeciesResults_Coatol ; id 61 BattleRex
    dw BreedSpeciesResults_SkyDragon ; id 62 SkyDragon
    dw BreedSpeciesResults_Serpentia ; id 63 Serpentia
    dw BreedSpeciesResults_Serpentia ; id 64 Divinegon
    dw BreedSpeciesResults_Orligon ; id 65 Orligon
    dw BreedSpeciesResults_Orligon ; id 66 GigaDraco
    dw BreedSpeciesResults_Orligon ; id 67 ?
    dw BreedSpeciesResults_Orligon ; id 68 ?
    dw BreedSpeciesResults_Orligon ; id 69 ?
    dw BreedSpeciesResults_Orligon ; id 70 ?
    dw BreedSpeciesResults_Orligon ; id 71 Tonguella
    dw BreedSpeciesResults_Almiraj ; id 72 Almiraj
    dw BreedSpeciesResults_CatFly ; id 73 CatFly
    dw BreedSpeciesResults_PillowRat ; id 74 PillowRat
    dw BreedSpeciesResults_PillowRat ; id 75 Saccer
    dw BreedSpeciesResults_PillowRat ; id 76 GulpBeast
    dw BreedSpeciesResults_Skullroo ; id 77 Skullroo
    dw BreedSpeciesResults_Skullroo ; id 78 WindBeast
    dw BreedSpeciesResults_Skullroo ; id 79 Beavern
    dw BreedSpeciesResults_Skullroo ; id 80 Antbear
    dw BreedSpeciesResults_Skullroo ; id 81 SuperTen
    dw BreedSpeciesResults_IronTurt ; id 82 IronTurt
    dw BreedSpeciesResults_Mommonja ; id 83 Mommonja
    dw BreedSpeciesResults_Mommonja ; id 84 HammerMan
    dw BreedSpeciesResults_Grizzly ; id 85 Grizzly
    dw BreedSpeciesResults_Yeti ; id 86 Yeti
    dw BreedSpeciesResults_ArrowDog ; id 87 ArrowDog
    dw BreedSpeciesResults_NoctoKing ; id 88 NoctoKing
    dw BreedSpeciesResults_BeastNite ; id 89 BeastNite
    dw BreedSpeciesResults_MadGopher ; id 90 MadGopher
    dw BreedSpeciesResults_FairyRat ; id 91 FairyRat
    dw BreedSpeciesResults_FairyRat ; id 92 Unicorn
    dw BreedSpeciesResults_Goategon ; id 93 Goategon
    dw BreedSpeciesResults_WildApe ; id 94 WildApe
    dw BreedSpeciesResults_Trumpeter ; id 95 Trumpeter
    dw BreedSpeciesResults_KingLeo ; id 96 KingLeo
    dw BreedSpeciesResults_KingLeo ; id 97 DarkHorn
    dw BreedSpeciesResults_MadCat ; id 98 MadCat
    dw BreedSpeciesResults_BigEye ; id 99 BigEye
    dw BreedSpeciesResults_BigEye ; id 100 Gorago
    dw BreedSpeciesResults_BigEye ; id 101 CatMage
    dw BreedSpeciesResults_Dumbira ; id 102 Dumbira
    dw BreedSpeciesResults067 ; id 103 ?
    dw BreedSpeciesResults067 ; id 104 ?
    dw BreedSpeciesResults067 ; id 105 ?
    dw BreedSpeciesResults067 ; id 106 Picky
    dw BreedSpeciesResults067 ; id 107 Wyvern
    dw BreedSpeciesResults067 ; id 108 BullBird
    dw BreedSpeciesResults_Florajay ; id 109 Florajay
    dw BreedSpeciesResults_Florajay ; id 110 DuckKite
    dw BreedSpeciesResults_Florajay ; id 111 MadPecker
    dw BreedSpeciesResults_MadRaven ; id 112 MadRaven
    dw BreedSpeciesResults_MadRaven ; id 113 MistyWing
    dw BreedSpeciesResults_MadRaven ; id 114 AquaHawk
    dw BreedSpeciesResults_Dracky ; id 115 Dracky
    dw BreedSpeciesResults_Dracky ; id 116 KiteHawk
    dw BreedSpeciesResults_BigRoost ; id 117 BigRoost
    dw BreedSpeciesResults_BigRoost ; id 118 StubBird
    dw BreedSpeciesResults_BigRoost ; id 119 LandOwl
    dw BreedSpeciesResults_MadGoose ; id 120 MadGoose
    dw BreedSpeciesResults_MadCondor ; id 121 MadCondor
    dw BreedSpeciesResults_Emyu ; id 122 Emyu
    dw BreedSpeciesResults_Emyu ; id 123 Blizzardy
    dw BreedSpeciesResults_Phoenix ; id 124 Phoenix
    dw BreedSpeciesResults_ZapBird ; id 125 ZapBird
    dw BreedSpeciesResults_Garudian ; id 126 Garudian
    dw BreedSpeciesResults_WhipBird ; id 127 WhipBird
    dw BreedSpeciesResults_FunkyBird ; id 128 FunkyBird
    dw BreedSpeciesResults_RainHawk ; id 129 RainHawk
    dw BreedSpeciesResults_Azurile ; id 130 Azurile
    dw BreedSpeciesResults_Azurile ; id 131 Shantak
    dw BreedSpeciesResults_CragDevil ; id 132 CragDevil
    dw BreedSpeciesResults085 ; id 133 ?
    dw BreedSpeciesResults085 ; id 134 ?
    dw BreedSpeciesResults085 ; id 135 ?
    dw BreedSpeciesResults085 ; id 136 ?
    dw BreedSpeciesResults085 ; id 137 ?
    dw BreedSpeciesResults085 ; id 138 ?
    dw BreedSpeciesResults085 ; id 139 ?
    dw BreedSpeciesResults085 ; id 140 ?
    dw BreedSpeciesResults085 ; id 141 MadPlant
    dw BreedSpeciesResults085 ; id 142 FireWeed
    dw BreedSpeciesResults085 ; id 143 FloraMan
    dw BreedSpeciesResults085 ; id 144 WingTree
    dw BreedSpeciesResults085 ; id 145 CactiBall
    dw BreedSpeciesResults085 ; id 146 Gulpple
    dw BreedSpeciesResults085 ; id 147 Toadstool
    dw BreedSpeciesResults085 ; id 148 AmberWeed
    dw BreedSpeciesResults085 ; id 149 Slurperon
    dw BreedSpeciesResults085 ; id 150 Stubsuck
    dw BreedSpeciesResults_Oniono ; id 151 Oniono
    dw BreedSpeciesResults_Oniono ; id 152 DanceVegi
    dw BreedSpeciesResults_Oniono ; id 153 TreeBoy
    dw BreedSpeciesResults_Devipine ; id 154 Devipine
    dw BreedSpeciesResults_Devipine ; id 155 FaceTree
    dw BreedSpeciesResults_Devipine ; id 156 HerbMan
    dw BreedSpeciesResults_Devipine ; id 157 BeanMan
    dw BreedSpeciesResults_Devipine ; id 158 EvilSeed
    dw BreedSpeciesResults_ManEater ; id 159 ManEater
    dw BreedSpeciesResults_Snapper ; id 160 Snapper
    dw BreedSpeciesResults_Snapper ; id 161 GhosTree
    dw BreedSpeciesResults_Rosevine ; id 162 Rosevine
    dw BreedSpeciesResults_Egdracil ; id 163 Egdracil
    dw BreedSpeciesResults_Egdracil ; id 164 Warubou
    dw BreedSpeciesResults_Watabou ; id 165 Watabou
    dw BreedSpeciesResults_Watabou ; id 166 Eggplaton
    dw BreedSpeciesResults_Watabou ; id 167 FooHero
    dw BreedSpeciesResults0A8 ; id 168 ?
    dw BreedSpeciesResults0A8 ; id 169 ?
    dw BreedSpeciesResults0A8 ; id 170 ?
    dw BreedSpeciesResults0A8 ; id 171 ?
    dw BreedSpeciesResults0A8 ; id 172 ?
    dw BreedSpeciesResults0A8 ; id 173 ?
    dw BreedSpeciesResults0A8 ; id 174 ?
    dw BreedSpeciesResults0A8 ; id 175 ?
    dw BreedSpeciesResults0A8 ; id 176 GiantSlug
    dw BreedSpeciesResults0A8 ; id 177 Catapila
    dw BreedSpeciesResults_Gophecada ; id 178 Gophecada
    dw BreedSpeciesResults_Gophecada ; id 179 Butterfly
    dw BreedSpeciesResults_WeedBug ; id 180 WeedBug
    dw BreedSpeciesResults_GiantWorm ; id 181 GiantWorm
    dw BreedSpeciesResults_GiantWorm ; id 182 Lipsy
    dw BreedSpeciesResults_StagBug ; id 183 StagBug
    dw BreedSpeciesResults_Pyuro ; id 184 Pyuro
    dw BreedSpeciesResults_Pyuro ; id 185 ArmyAnt
    dw BreedSpeciesResults_Pyuro ; id 186 GoHopper
    dw BreedSpeciesResults_Pyuro ; id 187 TailEater
    dw BreedSpeciesResults_ArmorPede ; id 188 ArmorPede
    dw BreedSpeciesResults_ArmorPede ; id 189 Eyeder
    dw BreedSpeciesResults_GiantMoth ; id 190 GiantMoth
    dw BreedSpeciesResults_GiantMoth ; id 191 Droll
    dw BreedSpeciesResults_GiantMoth ; id 192 ArmyCrab
    dw BreedSpeciesResults_MadHornet ; id 193 MadHornet
    dw BreedSpeciesResults_Belzebub ; id 194 Belzebub
    dw BreedSpeciesResults_Belzebub ; id 195 WarMantis
    dw BreedSpeciesResults_HornBeet ; id 196 HornBeet
    dw BreedSpeciesResults_Sickler ; id 197 Sickler
    dw BreedSpeciesResults_Sickler ; id 198 Armorpion
    dw BreedSpeciesResults_Digster ; id 199 Digster
    dw BreedSpeciesResults_Digster ; id 200 Skularach
    dw BreedSpeciesResults_Digster ; id 201 MultiEyes
    dw BreedSpeciesResults0CA ; id 202 ?
    dw BreedSpeciesResults0CA ; id 203 ?
    dw BreedSpeciesResults0CA ; id 204 ?
    dw BreedSpeciesResults0CA ; id 205 ?
    dw BreedSpeciesResults0CA ; id 206 ?
    dw BreedSpeciesResults0CA ; id 207 ?
    dw BreedSpeciesResults0CA ; id 208 ?
    dw BreedSpeciesResults0CA ; id 209 ?
    dw BreedSpeciesResults0CA ; id 210 ?
    dw BreedSpeciesResults0CA ; id 211 Pixy
    dw BreedSpeciesResults0CA ; id 212 MedusaEye
    dw BreedSpeciesResults0CA ; id 213 AgDevil
    dw BreedSpeciesResults_Demonite ; id 214 Demonite
    dw BreedSpeciesResults_DarkEye ; id 215 DarkEye
    dw BreedSpeciesResults_EyeBall ; id 216 EyeBall
    dw BreedSpeciesResults_EyeBall ; id 217 SkulRider
    dw BreedSpeciesResults_EyeBall ; id 218 EvilBeast
    dw BreedSpeciesResults_EyeBall ; id 219 Bubblemon
    dw BreedSpeciesResults_1EyeClown ; id 220 1EyeClown
    dw BreedSpeciesResults_Gremlin ; id 221 Gremlin
    dw BreedSpeciesResults_ArcDemon ; id 222 ArcDemon
    dw BreedSpeciesResults_Lionex ; id 223 Lionex
    dw BreedSpeciesResults_GoatHorn ; id 224 GoatHorn
    dw BreedSpeciesResults_GoatHorn ; id 225 Orc
    dw BreedSpeciesResults_GoatHorn ; id 226 Ogre
    dw BreedSpeciesResults_GateGuard ; id 227 GateGuard
    dw BreedSpeciesResults_GateGuard ; id 228 ChopClown
    dw BreedSpeciesResults_GateGuard ; id 229 BossTroll
    dw BreedSpeciesResults_Grendal ; id 230 Grendal
    dw BreedSpeciesResults_Akubar ; id 231 Akubar
    dw BreedSpeciesResults_MadKnight ; id 232 MadKnight
    dw BreedSpeciesResults_MadKnight ; id 233 EvilWell
    dw BreedSpeciesResults_MadKnight ; id 234 Gigantes
    dw BreedSpeciesResults_Centasaur ; id 235 Centasaur
    dw BreedSpeciesResults_EvilArmor ; id 236 EvilArmor
    dw BreedSpeciesResults_EvilArmor ; id 237 Jamirus
    dw BreedSpeciesResults_Durran ; id 238 Durran
    dw BreedSpeciesResults_Titanis ; id 239 Titanis
    dw BreedSpeciesResults_Titanis ; id 240 LampGenie
    dw BreedSpeciesResults0F1 ; id 241 ?
    dw BreedSpeciesResults0F1 ; id 242 ?
    dw BreedSpeciesResults0F1 ; id 243 ?
    dw BreedSpeciesResults0F1 ; id 244 ?
    dw BreedSpeciesResults0F1 ; id 245 ?
    dw BreedSpeciesResults0F1 ; id 246 Spooky
    dw BreedSpeciesResults0F1 ; id 247 Skullgon
    dw BreedSpeciesResults_PutrePup ; id 248 PutrePup
    dw BreedSpeciesResults_RotRaven ; id 249 RotRaven
    dw BreedSpeciesResults_RotRaven ; id 250 Mummy
    dw BreedSpeciesResults_DarkCrab ; id 251 DarkCrab
    dw BreedSpeciesResults_DarkCrab ; id 252 DeadNite
    dw BreedSpeciesResults_Shadow ; id 253 Shadow
    dw BreedSpeciesResults_Shadow ; id 254 Skulpent
    dw BreedSpeciesResults_Shadow ; id 255 Hork
    dw BreedSpeciesResults_Mudron ; id 256 Mudron
    dw BreedSpeciesResults_NiteWhip ; id 257 NiteWhip
    dw BreedSpeciesResults_WindMerge ; id 258 WindMerge
    dw BreedSpeciesResults_WindMerge ; id 259 Reaper
    dw BreedSpeciesResults_WindMerge ; id 260 Inverzon
    dw BreedSpeciesResults_WindMerge ; id 261 FoxFire
    dw BreedSpeciesResults_WindMerge ; id 262 CaptDead
    dw BreedSpeciesResults_DeadNoble ; id 263 DeadNoble
    dw BreedSpeciesResults_WhiteKing ; id 264 WhiteKing
    dw BreedSpeciesResults_BoneSlave ; id 265 BoneSlave
    dw BreedSpeciesResults_Skeletor ; id 266 Skeletor
    dw BreedSpeciesResults_Servant ; id 267 Servant
    dw BreedSpeciesResults_Lazamanus ; id 268 Lazamanus
    dw BreedSpeciesResults_Lazamanus ; id 269 Copycat
    dw BreedSpeciesResults_MadSpirit ; id 270 MadSpirit
    dw BreedSpeciesResults_PomPomBom ; id 271 PomPomBom
    dw BreedSpeciesResults_PomPomBom ; id 272 Niterich
    dw BreedSpeciesResults111 ; id 273 ?
    dw BreedSpeciesResults111 ; id 274 ?
    dw BreedSpeciesResults111 ; id 275 ?
    dw BreedSpeciesResults111 ; id 276 ?
    dw BreedSpeciesResults111 ; id 277 ?
    dw BreedSpeciesResults111 ; id 278 ?
    dw BreedSpeciesResults111 ; id 279 ?
    dw BreedSpeciesResults111 ; id 280 ?
    dw BreedSpeciesResults111 ; id 281 JewelBag
    dw BreedSpeciesResults111 ; id 282 EvilWand
    dw BreedSpeciesResults_MadCandle ; id 283 MadCandle
    dw BreedSpeciesResults_CoilBird ; id 284 CoilBird
    dw BreedSpeciesResults_CoilBird ; id 285 Facer
    dw BreedSpeciesResults_CoilBird ; id 286 SpikyBoy
    dw BreedSpeciesResults_MadMirror ; id 287 MadMirror
    dw BreedSpeciesResults_RogueNite ; id 288 RogueNite
    dw BreedSpeciesResults_RogueNite ; id 289 Puppetor
    dw BreedSpeciesResults_Goopi ; id 290 Goopi
    dw BreedSpeciesResults_Voodoll ; id 291 Voodoll
    dw BreedSpeciesResults_MetalDrak ; id 292 MetalDrak
    dw BreedSpeciesResults_Balzak ; id 293 Balzak
    dw BreedSpeciesResults_Balzak ; id 294 SabreMan
    dw BreedSpeciesResults_CurseLamp ; id 295 CurseLamp
    dw BreedSpeciesResults_Brushead ; id 296 Brushead
    dw BreedSpeciesResults_Brushead ; id 297 Roboster
    dw BreedSpeciesResults_Roboster2 ; id 298 Roboster2
    dw BreedSpeciesResults_EvilPot ; id 299 EvilPot
    dw BreedSpeciesResults_Gismo ; id 300 Gismo
    dw BreedSpeciesResults_LavaMan ; id 301 LavaMan
    dw BreedSpeciesResults_IceMan ; id 302 IceMan
    dw BreedSpeciesResults_Mimic ; id 303 Mimic
    dw BreedSpeciesResults_Exaucers ; id 304 Exaucers
    dw BreedSpeciesResults_Exaucers ; id 305 MudDoll
    dw BreedSpeciesResults_Golem ; id 306 Golem
    dw BreedSpeciesResults_StoneMan ; id 307 StoneMan
    dw BreedSpeciesResults_BombCrag ; id 308 BombCrag
    dw BreedSpeciesResults_BombCrag ; id 309 GoldGolem
    dw BreedSpeciesResults_DarkMate ; id 310 DarkMate
    dw BreedSpeciesResults_DarkMate ; id 311 ProtoMech
    dw BreedSpeciesResults_DarkMate ; id 312 CloudKing
    dw BreedSpeciesResults_DarkMate ; id 313 ?
    dw BreedSpeciesResults_DarkMate ; id 314 ?
    dw BreedSpeciesResults_DarkMate ; id 315 ?
    dw BreedSpeciesResults_DarkMate ; id 316 Petiteel
    dw BreedSpeciesResults_DarkMate ; id 317 Moray
    dw BreedSpeciesResults_DarkMate ; id 318 WalrusMan
    dw BreedSpeciesResults_DarkMate ; id 319 RayGigas
    dw BreedSpeciesResults_DarkMate ; id 320 Anemon
    dw BreedSpeciesResults_DarkMate ; id 321 Aquarella
    dw BreedSpeciesResults_Merman ; id 322 Merman
    dw BreedSpeciesResults_Octokid ; id 323 Octokid
    dw BreedSpeciesResults_Octokid ; id 324 PutreFish
    dw BreedSpeciesResults_Octokid ; id 325 Octoreach
    dw BreedSpeciesResults_Angleron ; id 326 Angleron
    dw BreedSpeciesResults_FishRider ; id 327 FishRider
    dw BreedSpeciesResults_FishRider ; id 328 RushFish
    dw BreedSpeciesResults_Gamanian ; id 329 Gamanian
    dw BreedSpeciesResults_Clawster ; id 330 Clawster
    dw BreedSpeciesResults_CancerMan ; id 331 CancerMan
    dw BreedSpeciesResults_RogueWave ; id 332 RogueWave
    dw BreedSpeciesResults_Scallopa ; id 333 Scallopa
    dw BreedSpeciesResults_Scallopa ; id 334 SeaHorse
    dw BreedSpeciesResults_Scallopa ; id 335 HoodSquid
    dw BreedSpeciesResults_MerTiger ; id 336 MerTiger
    dw BreedSpeciesResults_AxeShark ; id 337 AxeShark
    dw BreedSpeciesResults_AxeShark ; id 338 Octogon
    dw BreedSpeciesResults_KingSquid ; id 339 KingSquid
    dw BreedSpeciesResults_KingSquid ; id 340 Digong
    dw BreedSpeciesResults_WhaleMage ; id 341 WhaleMage
    dw BreedSpeciesResults_WhaleMage ; id 342 Aquadon
    dw BreedSpeciesResults_WhaleMage ; id 343 Octoraid
    dw BreedSpeciesResults_WhaleMage ; id 344 Grakos
    dw BreedSpeciesResults_Poseidon ; id 345 Poseidon
    dw BreedSpeciesResults_Poseidon ; id 346 Pumpoise
    dw BreedSpeciesResults_Poseidon ; id 347 Starfish
    dw BreedSpeciesResults_Poseidon ; id 348 ?
    dw BreedSpeciesResults_Poseidon ; id 349 ?
    dw BreedSpeciesResults_Poseidon ; id 350 ?
    dw BreedSpeciesResults_Poseidon ; id 351 DracoLord
    dw BreedSpeciesResults_DracoLord_160 ; id 352 DracoLord
    dw BreedSpeciesResults_LordDraco ; id 353 LordDraco
    dw BreedSpeciesResults_LordDraco ; id 354 Hargon
    dw BreedSpeciesResults_Sidoh ; id 355 Sidoh
    dw BreedSpeciesResults_Genosidoh ; id 356 Genosidoh
    dw BreedSpeciesResults_Genosidoh ; id 357 Baramos
    dw BreedSpeciesResults_Zoma ; id 358 Zoma
    dw BreedSpeciesResults_AsuraZoma ; id 359 AsuraZoma
    dw BreedSpeciesResults_AsuraZoma ; id 360 Pizzaro
    dw BreedSpeciesResults_PsychoPiz ; id 361 PsychoPiz
    dw BreedSpeciesResults_Esterk ; id 362 Esterk
    dw BreedSpeciesResults_Mirudraas ; id 363 Mirudraas
    dw BreedSpeciesResults_Mirudraas_16C ; id 364 Mirudraas
    dw BreedSpeciesResults_Mudou ; id 365 Mudou
    dw BreedSpeciesResults_Mudou ; id 366 DeathMore
    dw BreedSpeciesResults_DeathMore_16F ; id 367 DeathMore
    dw BreedSpeciesResults_DeathMore_170 ; id 368 DeathMore
    dw BreedSpeciesResults_Darkdrium ; id 369 Darkdrium
    dw BreedSpeciesResults_Darkdrium ; id 370 Orgodemir
    dw BreedFamilyRuleTable ; id 371 Orgodemir
    dw BreedFamilyRuleTable ; id 372 Darck
    dw BreedFamilyRuleTable ; id 373 Tatsu
    dw BreedFamilyRuleTable ; id 374 Diago
    dw BreedFamilyRuleTable ; id 375 Samsi
    dw BreedSpeciesResults000 ; id 376 Bazoo
    dw BreedSpeciesResults000 ; id 377 ?
    dw BreedSpeciesResults000 ; id 378 ?
    dw BreedSpeciesResults000 ; id 379 ?
    dw BreedSpeciesResults000 ; id 380 Lamia
    dw BreedSpeciesResults000 ; id 381 Dimensaur
    dw BreedSpeciesResults000 ; id 382 Kagebou
    dw BreedSpeciesResults000 ; id 383 ?

; list for entry $00 of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults000::
    dw $ffff ; id 0

; list for entry $01 (DrakSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_DrakSlime::
    dw MONSTER_SLIMEBORG ; id 0

; list for entry $02 (SpotSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_SpotSlime::
    dw MONSTER_SPOTKING ; id 0

; list for entry $03 (WingSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WingSlime::
    dw MONSTER_SLIMEBORG ; id 0

; list for entry $07 (Babble) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Babble::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_TROPICGEL ; id 1
    dw MONSTER_HALOSLIME ; id 2
    dw MONSTER_WONDEREGG ; id 3

; list for entry $0B (Healer) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Healer::
    dw MONSTER_MIMESLIME ; id 0

; list for entry $0C (FangSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_FangSlime::
    dw MONSTER_SLIMEBORG ; id 0

; list for entry $0E (SlimeBorg) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_SlimeBorg::
    dw MONSTER_SPOTKING ; id 0
    dw MONSTER_METALKING ; id 1
    dw MONSTER_GOLDSLIME ; id 2

; list for entry $11 (Metaly) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Metaly::
    dw MONSTER_METABBLE ; id 0

; list for entry $12 (Metabble) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Metabble::
    dw MONSTER_SLIMEBORG ; id 0
    dw MONSTER_METALKING ; id 1

; list for entry $13 (SpotKing) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_SpotKing::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_METALKING ; id 1
    dw MONSTER_GOLDSLIME ; id 2

; list for entry $14 (TropicGel) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_TropicGel::
    dw MONSTER_HALOSLIME ; id 0

; list for entry $16 (HaloSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_HaloSlime::
    dw MONSTER_SPOTKING ; id 0
    dw MONSTER_GOLDSLIME ; id 1

; list for entry $18 (GoldSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_GoldSlime::
    dw MONSTER_GRANSLIME ; id 0

; list for entry $19 (GranSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_GranSlime::
    dw MONSTER_METALKING ; id 0
    dw MONSTER_GOLDSLIME ; id 1
    dw MONSTER_GRANSLIME ; id 2

; list for entry $1B (Butch) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Butch::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_DRAGON ; id 1

; list for entry $25 (Tortragon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Tortragon::
    dw MONSTER_VAMPIRUS ; id 0
    dw MONSTER_COATOL ; id 1

; list for entry $27 (Gasgon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Gasgon::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_COATOL ; id 1

; list for entry $28 (FairyDrak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_FairyDrak::
    dw MONSTER_RAYBURN ; id 0
    dw MONSTER_COATOL ; id 1

; list for entry $2A (Poisongon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Poisongon::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_SKYDRAGON ; id 1
    dw MONSTER_SERPENTIA ; id 2

; list for entry $2E (MiniDrak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MiniDrak::
    dw MONSTER_ANDREAL ; id 0

; list for entry $30 (Rayburn) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Rayburn::
    dw MONSTER_OROCHI ; id 0
    dw MONSTER_GIGADRACO ; id 1

; list for entry $34 (KingCobra) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_KingCobra::
    dw MONSTER_SNAKEBAT ; id 0

; list for entry $35 (Vampirus) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Vampirus::
    dw MONSTER_COATOL ; id 0
    dw MONSTER_VAMPIRUS ; id 1

; list for entry $36 (SnakeBat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_SnakeBat::
    dw MONSTER_OROCHI ; id 0
    dw MONSTER_SERPENTIA ; id 1
    dw MONSTER_GIGADRACO ; id 2

; list for entry $39 (Crestpent) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Crestpent::
    dw MONSTER_WINGSNAKE ; id 0

; list for entry $3A (WingSnake) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WingSnake::
    dw MONSTER_COATOL ; id 0

; list for entry $3B (Coatol) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Coatol::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_COATOL ; id 1
    dw MONSTER_GIGADRACO ; id 2

; list for entry $3E (SkyDragon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_SkyDragon::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_COATOL ; id 1
    dw MONSTER_DIVINEGON ; id 2
    dw MONSTER_GIGADRACO ; id 3

; list for entry $3F (Serpentia) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Serpentia::
    dw MONSTER_ORLIGON ; id 0

; list for entry $41 (Orligon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Orligon::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_SUPERTEN ; id 1
    dw MONSTER_TRUMPETER ; id 2

; list for entry $48 (Almiraj) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Almiraj::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_UNICORN ; id 1

; list for entry $49 (CatFly) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_CatFly::
    dw MONSTER_CATMAGE ; id 0

; list for entry $4A (PillowRat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_PillowRat::
    dw MONSTER_SUPERTEN ; id 0
    dw MONSTER_TRUMPETER ; id 1

; list for entry $4D (Skullroo) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Skullroo::
    dw MONSTER_DUMBIRA ; id 0

; list for entry $52 (IronTurt) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_IronTurt::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1

; list for entry $53 (Mommonja) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Mommonja::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_DUMBIRA ; id 1

; list for entry $55 (Grizzly) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Grizzly::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_TRUMPETER ; id 1

; list for entry $56 (Yeti) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Yeti::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_TRUMPETER ; id 1

; list for entry $57 (ArrowDog) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_ArrowDog::
    dw MONSTER_NOCTOKING ; id 0
    dw MONSTER_MADCAT ; id 1

; list for entry $58 (NoctoKing) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_NoctoKing::
    dw MONSTER_DUMBIRA ; id 0

; list for entry $59 (BeastNite) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_BeastNite::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_NOCTOKING ; id 1

; list for entry $5A (MadGopher) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_MadGopher::
    dw MONSTER_BEASTNITE ; id 0

; list for entry $5B (FairyRat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_FairyRat::
    dw MONSTER_GULPBEAST ; id 0

; list for entry $5D (Goategon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Goategon::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1

; list for entry $5E (WildApe) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WildApe::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1
    dw MONSTER_TRUMPETER ; id 2

; list for entry $5F (Trumpeter) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Trumpeter::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_KINGLEO ; id 1
    dw MONSTER_GULPBEAST ; id 2

; list for entry $60 (KingLeo) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_KingLeo::
    dw MONSTER_GORAGO ; id 0

; list for entry $62 (MadCat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MadCat::
    dw MONSTER_YETI ; id 0
    dw MONSTER_DARKHORN ; id 1

; list for entry $63 (BigEye) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_BigEye::
    dw MONSTER_MADCAT ; id 0

; list for entry $66 (Dumbira) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Dumbira::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1

; list for entry $67 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults067::
    dw MONSTER_LANDOWL ; id 0

; list for entry $6D (Florajay) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Florajay::
    dw MONSTER_EMYU ; id 0

; list for entry $70 (MadRaven) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_MadRaven::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_MADCONDOR ; id 1

; list for entry $73 (Dracky) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Dracky::
    dw MONSTER_MADCONDOR ; id 0

; list for entry $75 (BigRoost) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_BigRoost::
    dw MONSTER_WHIPBIRD ; id 0

; list for entry $78 (MadGoose) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MadGoose::
    dw MONSTER_WHIPBIRD ; id 0

; list for entry $79 (MadCondor) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_MadCondor::
    dw MONSTER_EMYU ; id 0
    dw MONSTER_ZAPBIRD ; id 1
    dw MONSTER_WHIPBIRD ; id 2

; list for entry $7A (Emyu) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Emyu::
    dw MONSTER_GARUDIAN ; id 0
    dw MONSTER_WHIPBIRD ; id 1
    dw MONSTER_RAINHAWK ; id 2

; list for entry $7C (Phoenix) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Phoenix::
    dw MONSTER_ZAPBIRD ; id 0
    dw MONSTER_GARUDIAN ; id 1

; list for entry $7D (ZapBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_ZapBird::
    dw MONSTER_GARUDIAN ; id 0
    dw MONSTER_WHIPBIRD ; id 1

; list for entry $7E (Garudian) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Garudian::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_SHANTAK ; id 1

; list for entry $7F (WhipBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WhipBird::
    dw MONSTER_ZAPBIRD ; id 0
    dw MONSTER_SHANTAK ; id 1

; list for entry $80 (FunkyBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_FunkyBird::
    dw MONSTER_GARUDIAN ; id 0

; list for entry $81 (RainHawk) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_RainHawk::
    dw MONSTER_AZURILE ; id 0

; list for entry $82 (Azurile) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Azurile::
    dw MONSTER_AZURILE ; id 0

; list for entry $84 (CragDevil) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_CragDevil::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_FUNKYBIRD ; id 1

; list for entry $85 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults085::
    dw MONSTER_GHOSTREE ; id 0

; list for entry $97 (Oniono) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Oniono::
    dw MONSTER_FOOHERO ; id 0

; list for entry $9A (Devipine) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Devipine::
    dw MONSTER_MANEATER ; id 0

; list for entry $9F (ManEater) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_ManEater::
    dw MONSTER_SNAPPER ; id 0

; list for entry $A0 (Snapper) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Snapper::
    dw MONSTER_STUBSUCK ; id 0
    dw MONSTER_FACETREE ; id 1

; list for entry $A2 (Rosevine) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Rosevine::
    dw MONSTER_EGDRACIL ; id 0

; list for entry $A3 (Egdracil) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Egdracil::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WATABOU ; id 1

; list for entry $A5 (Watabou) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Watabou::
    dw MONSTER_TREEBOY ; id 0

; list for entry $A8 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0A8::
    dw MONSTER_MULTIEYES ; id 0

; list for entry $B2 (Gophecada) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Gophecada::
    dw MONSTER_DROLL ; id 0
    dw MONSTER_MADHORNET ; id 1

; list for entry $B4 (WeedBug) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WeedBug::
    dw MONSTER_TAILEATER ; id 0

; list for entry $B5 (GiantWorm) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_GiantWorm::
    dw MONSTER_DROLL ; id 0

; list for entry $B7 (StagBug) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_StagBug::
    dw MONSTER_HORNBEET ; id 0

; list for entry $B8 (Pyuro) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Pyuro::
    dw MONSTER_DROLL ; id 0

; list for entry $BC (ArmorPede) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_ArmorPede::
    dw MONSTER_DROLL ; id 0

; list for entry $BE (GiantMoth) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_GiantMoth::
    dw MONSTER_DIGSTER ; id 0

; list for entry $C1 (MadHornet) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_MadHornet::
    dw MONSTER_BELZEBUB ; id 0

; list for entry $C2 (Belzebub) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Belzebub::
    dw MONSTER_ARMORPION ; id 0

; list for entry $C4 (HornBeet) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_HornBeet::
    dw MONSTER_ARMORPION ; id 0

; list for entry $C5 (Sickler) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Sickler::
    dw MONSTER_SKULARACH ; id 0

; list for entry $C7 (Digster) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Digster::
    dw MONSTER_BELZEBUB ; id 0
    dw MONSTER_ARMORPEDE ; id 1

; list for entry $CA (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0CA::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_OGRE ; id 1
    dw MONSTER_GATEGUARD ; id 2

; list for entry $D6 (Demonite) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Demonite::
    dw MONSTER_GATEGUARD ; id 0

; list for entry $D7 (DarkEye) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_DarkEye::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $D8 (EyeBall) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_EyeBall::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_GATEGUARD ; id 1
    dw MONSTER_EVILWELL ; id 2

; list for entry $DC (1EyeClown) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_1EyeClown::
    dw MONSTER_MEDUSAEYE ; id 0
    dw MONSTER_CHOPCLOWN ; id 1

; list for entry $DD (Gremlin) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Gremlin::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $DE (ArcDemon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_ArcDemon::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_AKUBAR ; id 1

; list for entry $DF (Lionex) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Lionex::
    dw MONSTER_CHOPCLOWN ; id 0

; list for entry $E0 (GoatHorn) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_GoatHorn::
    dw MONSTER_BOSSTROLL ; id 0
    dw MONSTER_EVILWELL ; id 1

; list for entry $E3 (GateGuard) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_GateGuard::
    dw MONSTER_EVILWELL ; id 0
    dw MONSTER_LAMPGENIE ; id 1

; list for entry $E6 (Grendal) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Grendal::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_OGRE ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_AKUBAR ; id 3
    dw MONSTER_CHOPCLOWN ; id 4

; list for entry $E7 (Akubar) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Akubar::
    dw MONSTER_JAMIRUS ; id 0

; list for entry $E8 (MadKnight) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MadKnight::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_OGRE ; id 1
    dw MONSTER_GATEGUARD ; id 2

; list for entry $EB (Centasaur) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Centasaur::
    dw MONSTER_BOSSTROLL ; id 0
    dw MONSTER_DURRAN ; id 1

; list for entry $EC (EvilArmor) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_EvilArmor::
    dw MONSTER_DURRAN ; id 0
    dw MONSTER_SIDOH ; id 1

; list for entry $EE (Durran) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Durran::
    dw MONSTER_TITANIS ; id 0
    dw MONSTER_PIZZARO ; id 1

; list for entry $EF (Titanis) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Titanis::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_ARCDEMON ; id 1

; list for entry $F1 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0F1::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1

; list for entry $F8 (PutrePup) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_PutrePup::
    dw MONSTER_FOXFIRE ; id 0

; list for entry $F9 (RotRaven) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_RotRaven::
    dw MONSTER_BONESLAVE ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $FB (DarkCrab) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_DarkCrab::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_BONESLAVE ; id 1
    dw MONSTER_SKELETOR ; id 2
    dw MONSTER_CAPTDEAD ; id 3

; list for entry $FD (Shadow) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Shadow::
    dw MONSTER_INVERZON ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $100 (Mudron) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Mudron::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $101 (NiteWhip) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_NiteWhip::
    dw MONSTER_CAPTDEAD ; id 0

; list for entry $102 (WindMerge) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_WindMerge::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $107 (DeadNoble) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_DeadNoble::
    dw MONSTER_WHITEKING ; id 0
    dw MONSTER_NITERICH ; id 1

; list for entry $108 (WhiteKing) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WhiteKing::
    dw MONSTER_LAZAMANUS ; id 0
    dw MONSTER_HARGON ; id 1

; list for entry $109 (BoneSlave) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_BoneSlave::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1
    dw MONSTER_SKELETOR ; id 2

; list for entry $10A (Skeletor) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Skeletor::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1
    dw MONSTER_SERVANT ; id 2
    dw MONSTER_NITERICH ; id 3
    dw MONSTER_NITERICH ; id 4

; list for entry $10B (Servant) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Servant::
    dw MONSTER_DRACOLORD ; id 0

; list for entry $10C (Lazamanus) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Lazamanus::
    dw MONSTER_POMPOMBOM ; id 0

; list for entry $10E (MadSpirit) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_MadSpirit::
    dw MONSTER_DEADNOBLE ; id 0

; list for entry $10F (PomPomBom) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_PomPomBom::
    dw MONSTER_WHITEKING ; id 0

; list for entry $111 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults111::
    dw MONSTER_SABREMAN ; id 0

; list for entry $11B (MadCandle) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_MadCandle::
    dw MONSTER_GISMO ; id 0

; list for entry $11C (CoilBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_CoilBird::
    dw MONSTER_BOMBCRAG ; id 0

; list for entry $11F (MadMirror) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MadMirror::
    dw MONSTER_GISMO ; id 0

; list for entry $120 (RogueNite) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_RogueNite::
    dw MONSTER_BRUSHEAD ; id 0

; list for entry $122 (Goopi) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Goopi::
    dw MONSTER_GISMO ; id 0
    dw MONSTER_MUDDOLL ; id 1

; list for entry $123 (Voodoll) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Voodoll::
    dw MONSTER_SABREMAN ; id 0

; list for entry $124 (MetalDrak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MetalDrak::
    dw MONSTER_LAVAMAN ; id 0
    dw MONSTER_ICEMAN ; id 1

; list for entry $125 (Balzak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Balzak::
    dw MONSTER_ROBOSTER ; id 0

; list for entry $127 (CurseLamp) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_CurseLamp::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_BALZAK ; id 1

; list for entry $128 (Brushead) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Brushead::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ROBOSTER2 ; id 1
    dw MONSTER_ICEMAN ; id 2
    dw MONSTER_MIMIC ; id 3
    dw MONSTER_ROBOSTER2 ; id 4

; list for entry $12A (Roboster2) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Roboster2::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ICEMAN ; id 1

; list for entry $12B (EvilPot) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_EvilPot::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_BOMBCRAG ; id 1

; list for entry $12C (Gismo) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Gismo::
    dw MONSTER_CLOUDKING ; id 0

; list for entry $12D (LavaMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_LavaMan::
    dw MONSTER_GOLDGOLEM ; id 0

; list for entry $12E (IceMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_IceMan::
    dw MONSTER_GOLDGOLEM ; id 0

; list for entry $12F (Mimic) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Mimic::
    dw MONSTER_EVILPOT ; id 0

; list for entry $130 (Exaucers) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Exaucers::
    dw MONSTER_GOLEM ; id 0

; list for entry $132 (Golem) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Golem::
    dw MONSTER_VOODOLL ; id 0
    dw MONSTER_SABREMAN ; id 1
    dw MONSTER_STONEMAN ; id 2

; list for entry $133 (StoneMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_StoneMan::
    dw MONSTER_VOODOLL ; id 0
    dw MONSTER_METALDRAK ; id 1
    dw MONSTER_SABREMAN ; id 2

; list for entry $134 (BombCrag) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_BombCrag::
    dw MONSTER_DARKMATE ; id 0

; list for entry $136 (DarkMate) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_DarkMate::
    dw MONSTER_GAMANIAN ; id 0

; list for entry $142 (Merman) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Merman::
    dw MONSTER_MERTIGER ; id 0
    dw MONSTER_EVILPOT ; id 1

; list for entry $143 (Octokid) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Octokid::
    dw MONSTER_OCTOGON ; id 0

; list for entry $146 (Angleron) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Angleron::
    dw MONSTER_FISHRIDER ; id 0
    dw MONSTER_RUSHFISH ; id 1

; list for entry $147 (FishRider) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_FishRider::
    dw MONSTER_DIGONG ; id 0

; list for entry $149 (Gamanian) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Gamanian::
    dw MONSTER_CLAWSTER ; id 0

; list for entry $14A (Clawster) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Clawster::
    dw MONSTER_CANCERMAN ; id 0

; list for entry $14B (CancerMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_CancerMan::
    dw MONSTER_HOODSQUID ; id 0
    dw MONSTER_AXESHARK ; id 1

; list for entry $14C (RogueWave) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_RogueWave::
    dw MONSTER_SCALLOPA ; id 0

; list for entry $14D (Scallopa) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Scallopa::
    dw MONSTER_WHALEMAGE ; id 0

; list for entry $150 (MerTiger) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_MerTiger::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_AXESHARK ; id 1

; list for entry $151 (AxeShark) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_AxeShark::
    dw MONSTER_OCTORAID ; id 0
    dw MONSTER_KINGSQUID ; id 1

; list for entry $153 (KingSquid) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_KingSquid::
    dw MONSTER_AQUADON ; id 0

; list for entry $155 (WhaleMage) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_WhaleMage::
    dw MONSTER_POSEIDON ; id 0

; list for entry $159 (Poseidon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Poseidon::
    dw MONSTER_DRACOLORD_160 ; id 0
    dw MONSTER_ZOMA ; id 1

; list for entry $160 (DracoLord) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_DracoLord_160::
    dw MONSTER_LORDDRACO ; id 0
    dw MONSTER_ZOMA ; id 1

; list for entry $161 (LordDraco) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_LordDraco::
    dw MONSTER_BARAMOS ; id 0

; list for entry $163 (Sidoh) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Sidoh::
    dw MONSTER_GENOSIDOH ; id 0

; list for entry $164 (Genosidoh) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Genosidoh::
    dw MONSTER_MUDOU ; id 0

; list for entry $166 (Zoma) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Zoma::
    dw MONSTER_ASURAZOMA ; id 0
    dw MONSTER_DEATHMORE ; id 1

; list for entry $167 (AsuraZoma) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_AsuraZoma::
    dw MONSTER_PSYCHOPIZ ; id 0
    dw MONSTER_ESTERK ; id 1

; list for entry $169 (PsychoPiz) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_PsychoPiz::
    dw MONSTER_ORGODEMIR ; id 0

; list for entry $16A (Esterk) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_Esterk::
    dw MONSTER_MIRUDRAAS ; id 0

; list for entry $16B (Mirudraas) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Mirudraas::
    dw MONSTER_MIRUDRAAS_16C ; id 0
    dw MONSTER_DEATHMORE ; id 1

; list for entry $16C (Mirudraas) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Mirudraas_16C::
    dw MONSTER_DEATHMORE ; id 0

; list for entry $16D (Mudou) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Mudou::
    dw MONSTER_DEATHMORE_16F ; id 0

; list for entry $16F (DeathMore) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults_DeathMore_16F::
    dw MONSTER_DEATHMORE_170 ; id 0

; list for entry $170 (DeathMore) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_DeathMore_170::
    dw MONSTER_DARKDRIUM ; id 0

; list for entry $171 (Darkdrium) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults_Darkdrium::
    dw MONSTER_ORGODEMIR_173 ; id 0

; stage 2, when stage 1 finds nothing: the byte list at $734E + 2 * parent A's species holds
; families compared with parent B's family (record +$D & $0F); $FE moves on only when wArg1 = 2; $FF
; ends; a match takes result [index] from BreedFamilyResultTable (E-0199, C1)
; record: list
BreedFamilyRuleTable::
    dw BreedFamilyRules000 ; id 0
    dw BreedFamilyRules000 ; id 1 DrakSlime
    dw BreedFamilyRules000 ; id 2 SpotSlime
    dw BreedFamilyRules000 ; id 3 WingSlime
    dw BreedFamilyRules_TreeSlime ; id 4 TreeSlime
    dw BreedFamilyRules000 ; id 5 Snaily
    dw BreedFamilyRules000 ; id 6 SlimeNite
    dw BreedFamilyRules000 ; id 7 Babble
    dw BreedFamilyRules000 ; id 8 BoxSlime
    dw BreedFamilyRules000 ; id 9 PearlGel
    dw BreedFamilyRules000 ; id 10 Slime
    dw BreedFamilyRules_Healer ; id 11 Healer
    dw BreedFamilyRules000 ; id 12 FangSlime
    dw BreedFamilyRules000 ; id 13 RockSlime
    dw BreedFamilyRules000 ; id 14 SlimeBorg
    dw BreedFamilyRules000 ; id 15 Slabbit
    dw BreedFamilyRules000 ; id 16 KingSlime
    dw BreedFamilyRules000 ; id 17 Metaly
    dw BreedFamilyRules000 ; id 18 Metabble
    dw BreedFamilyRules000 ; id 19 SpotKing
    dw BreedFamilyRules000 ; id 20 TropicGel
    dw BreedFamilyRules_MimeSlime ; id 21 MimeSlime
    dw BreedFamilyRules000 ; id 22 HaloSlime
    dw BreedFamilyRules000 ; id 23 MetalKing
    dw BreedFamilyRules000 ; id 24 GoldSlime
    dw BreedFamilyRules000 ; id 25 GranSlime
    dw BreedFamilyRules_WonderEgg ; id 26 WonderEgg
    dw BreedFamilyRules000 ; id 27 Butch
    dw BreedFamilyRules000 ; id 28 ?
    dw BreedFamilyRules000 ; id 29 ?
    dw BreedFamilyRules000 ; id 30 ?
    dw BreedFamilyRules000 ; id 31 ?
    dw BreedFamilyRules000 ; id 32 ?
    dw BreedFamilyRules000 ; id 33 ?
    dw BreedFamilyRules000 ; id 34 ?
    dw BreedFamilyRules000 ; id 35 ?
    dw BreedFamilyRules000 ; id 36 DragonKid
    dw BreedFamilyRules000 ; id 37 Tortragon
    dw BreedFamilyRules000 ; id 38 Pteranod
    dw BreedFamilyRules_Gasgon ; id 39 Gasgon
    dw BreedFamilyRules000 ; id 40 FairyDrak
    dw BreedFamilyRules000 ; id 41 LizardMan
    dw BreedFamilyRules000 ; id 42 Poisongon
    dw BreedFamilyRules000 ; id 43 Swordgon
    dw BreedFamilyRules000 ; id 44 Drygon
    dw BreedFamilyRules000 ; id 45 Dragon
    dw BreedFamilyRules000 ; id 46 MiniDrak
    dw BreedFamilyRules000 ; id 47 MadDragon
    dw BreedFamilyRules000 ; id 48 Rayburn
    dw BreedFamilyRules000 ; id 49 Chamelgon
    dw BreedFamilyRules000 ; id 50 LizardFly
    dw BreedFamilyRules000 ; id 51 Andreal
    dw BreedFamilyRules000 ; id 52 KingCobra
    dw BreedFamilyRules000 ; id 53 Vampirus
    dw BreedFamilyRules000 ; id 54 SnakeBat
    dw BreedFamilyRules000 ; id 55 Spikerous
    dw BreedFamilyRules000 ; id 56 GreatDrak
    dw BreedFamilyRules000 ; id 57 Crestpent
    dw BreedFamilyRules000 ; id 58 WingSnake
    dw BreedFamilyRules000 ; id 59 Coatol
    dw BreedFamilyRules000 ; id 60 Orochi
    dw BreedFamilyRules000 ; id 61 BattleRex
    dw BreedFamilyRules000 ; id 62 SkyDragon
    dw BreedFamilyRules000 ; id 63 Serpentia
    dw BreedFamilyRules000 ; id 64 Divinegon
    dw BreedFamilyRules000 ; id 65 Orligon
    dw BreedFamilyRules000 ; id 66 GigaDraco
    dw BreedFamilyRules000 ; id 67 ?
    dw BreedFamilyRules000 ; id 68 ?
    dw BreedFamilyRules000 ; id 69 ?
    dw BreedFamilyRules000 ; id 70 ?
    dw BreedFamilyRules_Tonguella ; id 71 Tonguella
    dw BreedFamilyRules_Almiraj ; id 72 Almiraj
    dw BreedFamilyRules_CatFly ; id 73 CatFly
    dw BreedFamilyRules000 ; id 74 PillowRat
    dw BreedFamilyRules_Saccer ; id 75 Saccer
    dw BreedFamilyRules_GulpBeast ; id 76 GulpBeast
    dw BreedFamilyRules000 ; id 77 Skullroo
    dw BreedFamilyRules000 ; id 78 WindBeast
    dw BreedFamilyRules000 ; id 79 Beavern
    dw BreedFamilyRules000 ; id 80 Antbear
    dw BreedFamilyRules_SuperTen ; id 81 SuperTen
    dw BreedFamilyRules000 ; id 82 IronTurt
    dw BreedFamilyRules000 ; id 83 Mommonja
    dw BreedFamilyRules000 ; id 84 HammerMan
    dw BreedFamilyRules_Grizzly ; id 85 Grizzly
    dw BreedFamilyRules_Yeti ; id 86 Yeti
    dw BreedFamilyRules000 ; id 87 ArrowDog
    dw BreedFamilyRules000 ; id 88 NoctoKing
    dw BreedFamilyRules000 ; id 89 BeastNite
    dw BreedFamilyRules000 ; id 90 MadGopher
    dw BreedFamilyRules000 ; id 91 FairyRat
    dw BreedFamilyRules000 ; id 92 Unicorn
    dw BreedFamilyRules_Goategon ; id 93 Goategon
    dw BreedFamilyRules_WildApe ; id 94 WildApe
    dw BreedFamilyRules_Trumpeter ; id 95 Trumpeter
    dw BreedFamilyRules000 ; id 96 KingLeo
    dw BreedFamilyRules_DarkHorn ; id 97 DarkHorn
    dw BreedFamilyRules000 ; id 98 MadCat
    dw BreedFamilyRules_BigEye ; id 99 BigEye
    dw BreedFamilyRules000 ; id 100 Gorago
    dw BreedFamilyRules_CatMage ; id 101 CatMage
    dw BreedFamilyRules_Dumbira ; id 102 Dumbira
    dw BreedFamilyRules000 ; id 103 ?
    dw BreedFamilyRules000 ; id 104 ?
    dw BreedFamilyRules000 ; id 105 ?
    dw BreedFamilyRules_Picky ; id 106 Picky
    dw BreedFamilyRules_Wyvern ; id 107 Wyvern
    dw BreedFamilyRules_BullBird ; id 108 BullBird
    dw BreedFamilyRules000 ; id 109 Florajay
    dw BreedFamilyRules_DuckKite ; id 110 DuckKite
    dw BreedFamilyRules000 ; id 111 MadPecker
    dw BreedFamilyRules000 ; id 112 MadRaven
    dw BreedFamilyRules000 ; id 113 MistyWing
    dw BreedFamilyRules000 ; id 114 AquaHawk
    dw BreedFamilyRules000 ; id 115 Dracky
    dw BreedFamilyRules_KiteHawk ; id 116 KiteHawk
    dw BreedFamilyRules_BigRoost ; id 117 BigRoost
    dw BreedFamilyRules000 ; id 118 StubBird
    dw BreedFamilyRules_LandOwl ; id 119 LandOwl
    dw BreedFamilyRules_MadGoose ; id 120 MadGoose
    dw BreedFamilyRules_MadCondor ; id 121 MadCondor
    dw BreedFamilyRules_Emyu ; id 122 Emyu
    dw BreedFamilyRules000 ; id 123 Blizzardy
    dw BreedFamilyRules_Phoenix ; id 124 Phoenix
    dw BreedFamilyRules000 ; id 125 ZapBird
    dw BreedFamilyRules_Garudian ; id 126 Garudian
    dw BreedFamilyRules000 ; id 127 WhipBird
    dw BreedFamilyRules000 ; id 128 FunkyBird
    dw BreedFamilyRules_RainHawk ; id 129 RainHawk
    dw BreedFamilyRules000 ; id 130 Azurile
    dw BreedFamilyRules_Shantak ; id 131 Shantak
    dw BreedFamilyRules000 ; id 132 CragDevil
    dw BreedFamilyRules000 ; id 133 ?
    dw BreedFamilyRules000 ; id 134 ?
    dw BreedFamilyRules000 ; id 135 ?
    dw BreedFamilyRules000 ; id 136 ?
    dw BreedFamilyRules000 ; id 137 ?
    dw BreedFamilyRules000 ; id 138 ?
    dw BreedFamilyRules000 ; id 139 ?
    dw BreedFamilyRules000 ; id 140 ?
    dw BreedFamilyRules_MadPlant ; id 141 MadPlant
    dw BreedFamilyRules000 ; id 142 FireWeed
    dw BreedFamilyRules000 ; id 143 FloraMan
    dw BreedFamilyRules000 ; id 144 WingTree
    dw BreedFamilyRules000 ; id 145 CactiBall
    dw BreedFamilyRules000 ; id 146 Gulpple
    dw BreedFamilyRules000 ; id 147 Toadstool
    dw BreedFamilyRules_AmberWeed ; id 148 AmberWeed
    dw BreedFamilyRules000 ; id 149 Slurperon
    dw BreedFamilyRules_Stubsuck ; id 150 Stubsuck
    dw BreedFamilyRules000 ; id 151 Oniono
    dw BreedFamilyRules000 ; id 152 DanceVegi
    dw BreedFamilyRules000 ; id 153 TreeBoy
    dw BreedFamilyRules000 ; id 154 Devipine
    dw BreedFamilyRules000 ; id 155 FaceTree
    dw BreedFamilyRules_HerbMan ; id 156 HerbMan
    dw BreedFamilyRules000 ; id 157 BeanMan
    dw BreedFamilyRules000 ; id 158 EvilSeed
    dw BreedFamilyRules000 ; id 159 ManEater
    dw BreedFamilyRules000 ; id 160 Snapper
    dw BreedFamilyRules000 ; id 161 GhosTree
    dw BreedFamilyRules000 ; id 162 Rosevine
    dw BreedFamilyRules000 ; id 163 Egdracil
    dw BreedFamilyRules000 ; id 164 Warubou
    dw BreedFamilyRules000 ; id 165 Watabou
    dw BreedFamilyRules_Eggplaton ; id 166 Eggplaton
    dw BreedFamilyRules000 ; id 167 FooHero
    dw BreedFamilyRules000 ; id 168 ?
    dw BreedFamilyRules000 ; id 169 ?
    dw BreedFamilyRules000 ; id 170 ?
    dw BreedFamilyRules000 ; id 171 ?
    dw BreedFamilyRules000 ; id 172 ?
    dw BreedFamilyRules000 ; id 173 ?
    dw BreedFamilyRules000 ; id 174 ?
    dw BreedFamilyRules000 ; id 175 ?
    dw BreedFamilyRules_GiantSlug ; id 176 GiantSlug
    dw BreedFamilyRules000 ; id 177 Catapila
    dw BreedFamilyRules000 ; id 178 Gophecada
    dw BreedFamilyRules_Butterfly ; id 179 Butterfly
    dw BreedFamilyRules_WeedBug ; id 180 WeedBug
    dw BreedFamilyRules_GiantWorm ; id 181 GiantWorm
    dw BreedFamilyRules_Lipsy ; id 182 Lipsy
    dw BreedFamilyRules000 ; id 183 StagBug
    dw BreedFamilyRules_Pyuro ; id 184 Pyuro
    dw BreedFamilyRules000 ; id 185 ArmyAnt
    dw BreedFamilyRules000 ; id 186 GoHopper
    dw BreedFamilyRules_TailEater ; id 187 TailEater
    dw BreedFamilyRules_ArmorPede ; id 188 ArmorPede
    dw BreedFamilyRules_Eyeder ; id 189 Eyeder
    dw BreedFamilyRules000 ; id 190 GiantMoth
    dw BreedFamilyRules_Droll ; id 191 Droll
    dw BreedFamilyRules000 ; id 192 ArmyCrab
    dw BreedFamilyRules_MadHornet ; id 193 MadHornet
    dw BreedFamilyRules000 ; id 194 Belzebub
    dw BreedFamilyRules_WarMantis ; id 195 WarMantis
    dw BreedFamilyRules000 ; id 196 HornBeet
    dw BreedFamilyRules_Sickler ; id 197 Sickler
    dw BreedFamilyRules000 ; id 198 Armorpion
    dw BreedFamilyRules000 ; id 199 Digster
    dw BreedFamilyRules000 ; id 200 Skularach
    dw BreedFamilyRules000 ; id 201 MultiEyes
    dw BreedFamilyRules000 ; id 202 ?
    dw BreedFamilyRules000 ; id 203 ?
    dw BreedFamilyRules000 ; id 204 ?
    dw BreedFamilyRules000 ; id 205 ?
    dw BreedFamilyRules000 ; id 206 ?
    dw BreedFamilyRules000 ; id 207 ?
    dw BreedFamilyRules000 ; id 208 ?
    dw BreedFamilyRules000 ; id 209 ?
    dw BreedFamilyRules000 ; id 210 ?
    dw BreedFamilyRules_Pixy ; id 211 Pixy
    dw BreedFamilyRules_MedusaEye ; id 212 MedusaEye
    dw BreedFamilyRules000 ; id 213 AgDevil
    dw BreedFamilyRules_Demonite ; id 214 Demonite
    dw BreedFamilyRules_DarkEye ; id 215 DarkEye
    dw BreedFamilyRules_EyeBall ; id 216 EyeBall
    dw BreedFamilyRules_SkulRider ; id 217 SkulRider
    dw BreedFamilyRules_EvilBeast ; id 218 EvilBeast
    dw BreedFamilyRules000 ; id 219 Bubblemon
    dw BreedFamilyRules_1EyeClown ; id 220 1EyeClown
    dw BreedFamilyRules_Gremlin ; id 221 Gremlin
    dw BreedFamilyRules_ArcDemon ; id 222 ArcDemon
    dw BreedFamilyRules000 ; id 223 Lionex
    dw BreedFamilyRules_GoatHorn ; id 224 GoatHorn
    dw BreedFamilyRules000 ; id 225 Orc
    dw BreedFamilyRules_Ogre ; id 226 Ogre
    dw BreedFamilyRules_GateGuard ; id 227 GateGuard
    dw BreedFamilyRules000 ; id 228 ChopClown
    dw BreedFamilyRules_BossTroll ; id 229 BossTroll
    dw BreedFamilyRules000 ; id 230 Grendal
    dw BreedFamilyRules000 ; id 231 Akubar
    dw BreedFamilyRules000 ; id 232 MadKnight
    dw BreedFamilyRules000 ; id 233 EvilWell
    dw BreedFamilyRules000 ; id 234 Gigantes
    dw BreedFamilyRules_Centasaur ; id 235 Centasaur
    dw BreedFamilyRules000 ; id 236 EvilArmor
    dw BreedFamilyRules000 ; id 237 Jamirus
    dw BreedFamilyRules000 ; id 238 Durran
    dw BreedFamilyRules000 ; id 239 Titanis
    dw BreedFamilyRules000 ; id 240 LampGenie
    dw BreedFamilyRules000 ; id 241 ?
    dw BreedFamilyRules000 ; id 242 ?
    dw BreedFamilyRules000 ; id 243 ?
    dw BreedFamilyRules000 ; id 244 ?
    dw BreedFamilyRules000 ; id 245 ?
    dw BreedFamilyRules_Spooky ; id 246 Spooky
    dw BreedFamilyRules_Skullgon ; id 247 Skullgon
    dw BreedFamilyRules000 ; id 248 PutrePup
    dw BreedFamilyRules_RotRaven ; id 249 RotRaven
    dw BreedFamilyRules000 ; id 250 Mummy
    dw BreedFamilyRules_DarkCrab ; id 251 DarkCrab
    dw BreedFamilyRules_DeadNite ; id 252 DeadNite
    dw BreedFamilyRules000 ; id 253 Shadow
    dw BreedFamilyRules_Skulpent ; id 254 Skulpent
    dw BreedFamilyRules_Hork ; id 255 Hork
    dw BreedFamilyRules_Mudron ; id 256 Mudron
    dw BreedFamilyRules_NiteWhip ; id 257 NiteWhip
    dw BreedFamilyRules000 ; id 258 WindMerge
    dw BreedFamilyRules000 ; id 259 Reaper
    dw BreedFamilyRules000 ; id 260 Inverzon
    dw BreedFamilyRules_FoxFire ; id 261 FoxFire
    dw BreedFamilyRules000 ; id 262 CaptDead
    dw BreedFamilyRules_DeadNoble ; id 263 DeadNoble
    dw BreedFamilyRules_WhiteKing ; id 264 WhiteKing
    dw BreedFamilyRules_BoneSlave ; id 265 BoneSlave
    dw BreedFamilyRules_Skeletor ; id 266 Skeletor
    dw BreedFamilyRules000 ; id 267 Servant
    dw BreedFamilyRules000 ; id 268 Lazamanus
    dw BreedFamilyRules000 ; id 269 Copycat
    dw BreedFamilyRules_MadSpirit ; id 270 MadSpirit
    dw BreedFamilyRules_PomPomBom ; id 271 PomPomBom
    dw BreedFamilyRules000 ; id 272 Niterich
    dw BreedFamilyRules000 ; id 273 ?
    dw BreedFamilyRules000 ; id 274 ?
    dw BreedFamilyRules000 ; id 275 ?
    dw BreedFamilyRules000 ; id 276 ?
    dw BreedFamilyRules000 ; id 277 ?
    dw BreedFamilyRules000 ; id 278 ?
    dw BreedFamilyRules000 ; id 279 ?
    dw BreedFamilyRules000 ; id 280 ?
    dw BreedFamilyRules_JewelBag ; id 281 JewelBag
    dw BreedFamilyRules000 ; id 282 EvilWand
    dw BreedFamilyRules000 ; id 283 MadCandle
    dw BreedFamilyRules000 ; id 284 CoilBird
    dw BreedFamilyRules000 ; id 285 Facer
    dw BreedFamilyRules000 ; id 286 SpikyBoy
    dw BreedFamilyRules000 ; id 287 MadMirror
    dw BreedFamilyRules_RogueNite ; id 288 RogueNite
    dw BreedFamilyRules_Puppetor ; id 289 Puppetor
    dw BreedFamilyRules000 ; id 290 Goopi
    dw BreedFamilyRules000 ; id 291 Voodoll
    dw BreedFamilyRules000 ; id 292 MetalDrak
    dw BreedFamilyRules000 ; id 293 Balzak
    dw BreedFamilyRules000 ; id 294 SabreMan
    dw BreedFamilyRules000 ; id 295 CurseLamp
    dw BreedFamilyRules000 ; id 296 Brushead
    dw BreedFamilyRules_Roboster ; id 297 Roboster
    dw BreedFamilyRules_Roboster2 ; id 298 Roboster2
    dw BreedFamilyRules000 ; id 299 EvilPot
    dw BreedFamilyRules_Gismo ; id 300 Gismo
    dw BreedFamilyRules_LavaMan ; id 301 LavaMan
    dw BreedFamilyRules_IceMan ; id 302 IceMan
    dw BreedFamilyRules000 ; id 303 Mimic
    dw BreedFamilyRules000 ; id 304 Exaucers
    dw BreedFamilyRules000 ; id 305 MudDoll
    dw BreedFamilyRules000 ; id 306 Golem
    dw BreedFamilyRules000 ; id 307 StoneMan
    dw BreedFamilyRules000 ; id 308 BombCrag
    dw BreedFamilyRules000 ; id 309 GoldGolem
    dw BreedFamilyRules_DarkMate ; id 310 DarkMate
    dw BreedFamilyRules000 ; id 311 ProtoMech
    dw BreedFamilyRules000 ; id 312 CloudKing
    dw BreedFamilyRules000 ; id 313 ?
    dw BreedFamilyRules000 ; id 314 ?
    dw BreedFamilyRules000 ; id 315 ?
    dw BreedFamilyRules_Petiteel ; id 316 Petiteel
    dw BreedFamilyRules000 ; id 317 Moray
    dw BreedFamilyRules000 ; id 318 WalrusMan
    dw BreedFamilyRules000 ; id 319 RayGigas
    dw BreedFamilyRules000 ; id 320 Anemon
    dw BreedFamilyRules_Aquarella ; id 321 Aquarella
    dw BreedFamilyRules000 ; id 322 Merman
    dw BreedFamilyRules000 ; id 323 Octokid
    dw BreedFamilyRules000 ; id 324 PutreFish
    dw BreedFamilyRules_Octoreach ; id 325 Octoreach
    dw BreedFamilyRules_Angleron ; id 326 Angleron
    dw BreedFamilyRules000 ; id 327 FishRider
    dw BreedFamilyRules000 ; id 328 RushFish
    dw BreedFamilyRules_Gamanian ; id 329 Gamanian
    dw BreedFamilyRules_Clawster ; id 330 Clawster
    dw BreedFamilyRules000 ; id 331 CancerMan
    dw BreedFamilyRules_RogueWave ; id 332 RogueWave
    dw BreedFamilyRules000 ; id 333 Scallopa
    dw BreedFamilyRules000 ; id 334 SeaHorse
    dw BreedFamilyRules_HoodSquid ; id 335 HoodSquid
    dw BreedFamilyRules000 ; id 336 MerTiger
    dw BreedFamilyRules000 ; id 337 AxeShark
    dw BreedFamilyRules_Octogon ; id 338 Octogon
    dw BreedFamilyRules_KingSquid ; id 339 KingSquid
    dw BreedFamilyRules000 ; id 340 Digong
    dw BreedFamilyRules000 ; id 341 WhaleMage
    dw BreedFamilyRules000 ; id 342 Aquadon
    dw BreedFamilyRules000 ; id 343 Octoraid
    dw BreedFamilyRules000 ; id 344 Grakos
    dw BreedFamilyRules000 ; id 345 Poseidon
    dw BreedFamilyRules000 ; id 346 Pumpoise
    dw BreedFamilyRules000 ; id 347 Starfish
    dw BreedFamilyRules000 ; id 348 ?
    dw BreedFamilyRules000 ; id 349 ?
    dw BreedFamilyRules000 ; id 350 ?
    dw BreedFamilyRules000 ; id 351 DracoLord
    dw BreedFamilyRules000 ; id 352 DracoLord
    dw BreedFamilyRules000 ; id 353 LordDraco
    dw BreedFamilyRules000 ; id 354 Hargon
    dw BreedFamilyRules000 ; id 355 Sidoh
    dw BreedFamilyRules000 ; id 356 Genosidoh
    dw BreedFamilyRules000 ; id 357 Baramos
    dw BreedFamilyRules000 ; id 358 Zoma
    dw BreedFamilyRules000 ; id 359 AsuraZoma
    dw BreedFamilyRules000 ; id 360 Pizzaro
    dw BreedFamilyRules000 ; id 361 PsychoPiz
    dw BreedFamilyRules000 ; id 362 Esterk
    dw BreedFamilyRules000 ; id 363 Mirudraas
    dw BreedFamilyRules000 ; id 364 Mirudraas
    dw BreedFamilyRules000 ; id 365 Mudou
    dw BreedFamilyRules000 ; id 366 DeathMore
    dw BreedFamilyRules000 ; id 367 DeathMore
    dw BreedFamilyRules000 ; id 368 DeathMore
    dw BreedFamilyRules000 ; id 369 Darkdrium
    dw BreedFamilyRules000 ; id 370 Orgodemir
    dw BreedFamilyRules000 ; id 371 Orgodemir
    dw BreedFamilyRules000 ; id 372 Darck
    dw BreedFamilyRules000 ; id 373 Tatsu
    dw BreedFamilyRules000 ; id 374 Diago
    dw BreedFamilyRules000 ; id 375 Samsi
    dw BreedFamilyRules000 ; id 376 Bazoo
    dw BreedFamilyRules000 ; id 377 ?
    dw BreedFamilyRules000 ; id 378 ?
    dw BreedFamilyRules000 ; id 379 ?
    dw BreedFamilyRules000 ; id 380 Lamia
    dw BreedFamilyRules000 ; id 381 Dimensaur
    dw BreedFamilyRules000 ; id 382 Kagebou
    dw BreedFamilyRules000 ; id 383 ?

; list for entry $00 of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules000::
    db $ff ; id 0

; list for entry $04 (TreeSlime) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_TreeSlime::
    db $02, $ff ; id 0

; list for entry $0B (Healer) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Healer::
    db $fe, $07, $ff ; id 0

; list for entry $15 (MimeSlime) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_MimeSlime::
    db $07, $ff ; id 0

; list for entry $1A (WonderEgg) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_WonderEgg::
    db $04, $06, $03, $ff ; id 0

; list for entry $27 (Gasgon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Gasgon::
    db $02, $ff ; id 0

; list for entry $47 (Tonguella) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Tonguella::
    db $00, $ff ; id 0

; list for entry $48 (Almiraj) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Almiraj::
    db $01, $ff ; id 0

; list for entry $49 (CatFly) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_CatFly::
    db $03, $ff ; id 0

; list for entry $4B (Saccer) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Saccer::
    db $01, $ff ; id 0

; list for entry $4C (GulpBeast) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_GulpBeast::
    db $00, $ff ; id 0

; list for entry $51 (SuperTen) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_SuperTen::
    db $01, $ff ; id 0

; list for entry $55 (Grizzly) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Grizzly::
    db $01, $06, $00, $ff ; id 0

; list for entry $56 (Yeti) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Yeti::
    db $01, $00, $ff ; id 0

; list for entry $5D (Goategon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Goategon::
    db $00, $ff ; id 0

; list for entry $5E (WildApe) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_WildApe::
    db $00, $ff ; id 0

; list for entry $5F (Trumpeter) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Trumpeter::
    db $01, $00, $ff ; id 0

; list for entry $61 (DarkHorn) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_DarkHorn::
    db $0a, $ff ; id 0

; list for entry $63 (BigEye) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_BigEye::
    db $01, $ff ; id 0

; list for entry $65 (CatMage) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_CatMage::
    db $06, $ff ; id 0

; list for entry $66 (Dumbira) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Dumbira::
    db $01, $00, $ff ; id 0

; list for entry $6A (Picky) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Picky::
    db $00, $ff ; id 0

; list for entry $6B (Wyvern) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Wyvern::
    db $01, $07, $ff ; id 0

; list for entry $6C (BullBird) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_BullBird::
    db $06, $ff ; id 0

; list for entry $6E (DuckKite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_DuckKite::
    db $08, $ff ; id 0

; list for entry $74 (KiteHawk) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_KiteHawk::
    db $02, $ff ; id 0

; list for entry $75 (BigRoost) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_BigRoost::
    db $02, $ff ; id 0

; list for entry $77 (LandOwl) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_LandOwl::
    db $01, $07, $06, $ff ; id 0

; list for entry $78 (MadGoose) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_MadGoose::
    db $02, $ff ; id 0

; list for entry $79 (MadCondor) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_MadCondor::
    db $01, $07, $ff ; id 0

; list for entry $7A (Emyu) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Emyu::
    db $02, $ff ; id 0

; list for entry $7C (Phoenix) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Phoenix::
    db $01, $07, $ff ; id 0

; list for entry $7E (Garudian) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Garudian::
    db $00, $ff ; id 0

; list for entry $81 (RainHawk) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_RainHawk::
    db $0a, $ff ; id 0

; list for entry $83 (Shantak) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Shantak::
    db $0a, $ff ; id 0

; list for entry $8D (MadPlant) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_MadPlant::
    db $02, $ff ; id 0

; list for entry $94 (AmberWeed) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_AmberWeed::
    db $02, $ff ; id 0

; list for entry $96 (Stubsuck) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Stubsuck::
    db $07, $ff ; id 0

; list for entry $9C (HerbMan) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_HerbMan::
    db $01, $ff ; id 0

; list for entry $A6 (Eggplaton) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Eggplaton::
    db $06, $07, $ff ; id 0

; list for entry $B0 (GiantSlug) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_GiantSlug::
    db $00, $ff ; id 0

; list for entry $B3 (Butterfly) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Butterfly::
    db $06, $ff ; id 0

; list for entry $B4 (WeedBug) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_WeedBug::
    db $04, $ff ; id 0

; list for entry $B5 (GiantWorm) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_GiantWorm::
    db $08, $ff ; id 0

; list for entry $B6 (Lipsy) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Lipsy::
    db $00, $ff ; id 0

; list for entry $B8 (Pyuro) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Pyuro::
    db $07, $ff ; id 0

; list for entry $BB (TailEater) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_TailEater::
    db $06, $ff ; id 0

; list for entry $BC (ArmorPede) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_ArmorPede::
    db $06, $ff ; id 0

; list for entry $BD (Eyeder) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Eyeder::
    db $07, $ff ; id 0

; list for entry $BF (Droll) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Droll::
    db $01, $07, $ff ; id 0

; list for entry $C1 (MadHornet) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_MadHornet::
    db $07, $ff ; id 0

; list for entry $C3 (WarMantis) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_WarMantis::
    db $06, $00, $ff ; id 0

; list for entry $C5 (Sickler) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Sickler::
    db $06, $ff ; id 0

; list for entry $D3 (Pixy) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Pixy::
    db $00, $ff ; id 0

; list for entry $D4 (MedusaEye) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_MedusaEye::
    db $01, $02, $07, $ff ; id 0

; list for entry $D6 (Demonite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Demonite::
    db $00, $ff ; id 0

; list for entry $D7 (DarkEye) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_DarkEye::
    db $07, $ff ; id 0

; list for entry $D8 (EyeBall) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_EyeBall::
    db $00, $ff ; id 0

; list for entry $D9 (SkulRider) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_SkulRider::
    db $01, $02, $07, $ff ; id 0

; list for entry $DA (EvilBeast) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_EvilBeast::
    db $01, $02, $07, $ff ; id 0

; list for entry $DC (1EyeClown) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_1EyeClown::
    db $07, $ff ; id 0

; list for entry $DD (Gremlin) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Gremlin::
    db $01, $07, $02, $ff ; id 0

; list for entry $DE (ArcDemon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_ArcDemon::
    db $07, $02, $01, $08, $ff ; id 0

; list for entry $E0 (GoatHorn) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_GoatHorn::
    db $02, $ff ; id 0

; list for entry $E2 (Ogre) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Ogre::
    db $01, $07, $02, $08, $ff ; id 0

; list for entry $E3 (GateGuard) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_GateGuard::
    db $01, $02, $08, $ff ; id 0

; list for entry $E5 (BossTroll) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_BossTroll::
    db $02, $ff ; id 0

; list for entry $EB (Centasaur) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Centasaur::
    db $0a, $ff ; id 0

; list for entry $F6 (Spooky) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Spooky::
    db $06, $02, $ff ; id 0

; list for entry $F7 (Skullgon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Skullgon::
    db $01, $03, $ff ; id 0

; list for entry $F9 (RotRaven) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_RotRaven::
    db $03, $ff ; id 0

; list for entry $FB (DarkCrab) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_DarkCrab::
    db $06, $ff ; id 0

; list for entry $FC (DeadNite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_DeadNite::
    db $09, $03, $ff ; id 0

; list for entry $FE (Skulpent) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Skulpent::
    db $01, $06, $ff ; id 0

; list for entry $FF (Hork) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Hork::
    db $06, $ff ; id 0

; list for entry $100 (Mudron) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Mudron::
    db $03, $ff ; id 0

; list for entry $101 (NiteWhip) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_NiteWhip::
    db $02, $ff ; id 0

; list for entry $105 (FoxFire) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_FoxFire::
    db $02, $ff ; id 0

; list for entry $107 (DeadNoble) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_DeadNoble::
    db $01, $03, $ff ; id 0

; list for entry $108 (WhiteKing) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_WhiteKing::
    db $01, $06, $ff ; id 0

; list for entry $109 (BoneSlave) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_BoneSlave::
    db $01, $09, $03, $ff ; id 0

; list for entry $10A (Skeletor) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Skeletor::
    db $01, $03, $ff ; id 0

; list for entry $10E (MadSpirit) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_MadSpirit::
    db $06, $01, $ff ; id 0

; list for entry $10F (PomPomBom) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_PomPomBom::
    db $03, $ff ; id 0

; list for entry $119 (JewelBag) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_JewelBag::
    db $08, $ff ; id 0

; list for entry $120 (RogueNite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_RogueNite::
    db $06, $ff ; id 0

; list for entry $121 (Puppetor) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Puppetor::
    db $06, $ff ; id 0

; list for entry $129 (Roboster) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Roboster::
    db $00, $01, $03, $07, $05, $ff ; id 0

; list for entry $12A (Roboster2) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Roboster2::
    db $00, $01, $03, $ff ; id 0

; list for entry $12C (Gismo) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Gismo::
    db $06, $ff ; id 0

; list for entry $12D (LavaMan) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_LavaMan::
    db $06, $ff ; id 0

; list for entry $12E (IceMan) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_IceMan::
    db $06, $ff ; id 0

; list for entry $136 (DarkMate) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_DarkMate::
    db $05, $ff ; id 0

; list for entry $13C (Petiteel) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Petiteel::
    db $02, $08, $01, $06, $ff ; id 0

; list for entry $141 (Aquarella) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Aquarella::
    db $05, $ff ; id 0

; list for entry $145 (Octoreach) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Octoreach::
    db $00, $ff ; id 0

; list for entry $146 (Angleron) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_Angleron::
    db $01, $ff ; id 0

; list for entry $149 (Gamanian) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Gamanian::
    db $06, $ff ; id 0

; list for entry $14A (Clawster) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Clawster::
    db $06, $ff ; id 0

; list for entry $14C (RogueWave) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_RogueWave::
    db $06, $ff ; id 0

; list for entry $14F (HoodSquid) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules_HoodSquid::
    db $00, $ff ; id 0

; list for entry $152 (Octogon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_Octogon::
    db $00, $0a, $ff ; id 0

; list for entry $153 (KingSquid) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules_KingSquid::
    db $00, $ff ; id 0

; stage 2 result lists, indexed by parent A's species (E-0199, C1)
; record: list
BreedFamilyResultTable::
    dw BreedFamilyResults000 ; id 0
    dw BreedFamilyResults_DrakSlime ; id 1 DrakSlime
    dw BreedFamilyResults_DrakSlime ; id 2 SpotSlime
    dw BreedFamilyResults_DrakSlime ; id 3 WingSlime
    dw BreedFamilyResults_DrakSlime ; id 4 TreeSlime
    dw BreedFamilyResults_Snaily ; id 5 Snaily
    dw BreedFamilyResults_Snaily ; id 6 SlimeNite
    dw BreedFamilyResults_Snaily ; id 7 Babble
    dw BreedFamilyResults_Snaily ; id 8 BoxSlime
    dw BreedFamilyResults_Snaily ; id 9 PearlGel
    dw BreedFamilyResults_Snaily ; id 10 Slime
    dw BreedFamilyResults_Snaily ; id 11 Healer
    dw BreedFamilyResults_FangSlime ; id 12 FangSlime
    dw BreedFamilyResults_FangSlime ; id 13 RockSlime
    dw BreedFamilyResults_FangSlime ; id 14 SlimeBorg
    dw BreedFamilyResults_FangSlime ; id 15 Slabbit
    dw BreedFamilyResults_FangSlime ; id 16 KingSlime
    dw BreedFamilyResults_FangSlime ; id 17 Metaly
    dw BreedFamilyResults_FangSlime ; id 18 Metabble
    dw BreedFamilyResults_FangSlime ; id 19 SpotKing
    dw BreedFamilyResults_FangSlime ; id 20 TropicGel
    dw BreedFamilyResults_FangSlime ; id 21 MimeSlime
    dw BreedFamilyResults_HaloSlime ; id 22 HaloSlime
    dw BreedFamilyResults_HaloSlime ; id 23 MetalKing
    dw BreedFamilyResults_HaloSlime ; id 24 GoldSlime
    dw BreedFamilyResults_HaloSlime ; id 25 GranSlime
    dw BreedFamilyResults_HaloSlime ; id 26 WonderEgg
    dw BreedFamilyResults_Butch ; id 27 Butch
    dw BreedFamilyResults_Butch ; id 28 ?
    dw BreedFamilyResults_Butch ; id 29 ?
    dw BreedFamilyResults_Butch ; id 30 ?
    dw BreedFamilyResults_Butch ; id 31 ?
    dw BreedFamilyResults_Butch ; id 32 ?
    dw BreedFamilyResults_Butch ; id 33 ?
    dw BreedFamilyResults_Butch ; id 34 ?
    dw BreedFamilyResults_Butch ; id 35 ?
    dw BreedFamilyResults_Butch ; id 36 DragonKid
    dw BreedFamilyResults_Butch ; id 37 Tortragon
    dw BreedFamilyResults_Butch ; id 38 Pteranod
    dw BreedFamilyResults_Butch ; id 39 Gasgon
    dw BreedFamilyResults_FairyDrak ; id 40 FairyDrak
    dw BreedFamilyResults_FairyDrak ; id 41 LizardMan
    dw BreedFamilyResults_FairyDrak ; id 42 Poisongon
    dw BreedFamilyResults_FairyDrak ; id 43 Swordgon
    dw BreedFamilyResults_FairyDrak ; id 44 Drygon
    dw BreedFamilyResults_FairyDrak ; id 45 Dragon
    dw BreedFamilyResults_FairyDrak ; id 46 MiniDrak
    dw BreedFamilyResults_FairyDrak ; id 47 MadDragon
    dw BreedFamilyResults_FairyDrak ; id 48 Rayburn
    dw BreedFamilyResults_FairyDrak ; id 49 Chamelgon
    dw BreedFamilyResults_FairyDrak ; id 50 LizardFly
    dw BreedFamilyResults_FairyDrak ; id 51 Andreal
    dw BreedFamilyResults_FairyDrak ; id 52 KingCobra
    dw BreedFamilyResults_FairyDrak ; id 53 Vampirus
    dw BreedFamilyResults_FairyDrak ; id 54 SnakeBat
    dw BreedFamilyResults_FairyDrak ; id 55 Spikerous
    dw BreedFamilyResults_FairyDrak ; id 56 GreatDrak
    dw BreedFamilyResults_FairyDrak ; id 57 Crestpent
    dw BreedFamilyResults_FairyDrak ; id 58 WingSnake
    dw BreedFamilyResults_FairyDrak ; id 59 Coatol
    dw BreedFamilyResults_FairyDrak ; id 60 Orochi
    dw BreedFamilyResults_FairyDrak ; id 61 BattleRex
    dw BreedFamilyResults_FairyDrak ; id 62 SkyDragon
    dw BreedFamilyResults_FairyDrak ; id 63 Serpentia
    dw BreedFamilyResults_FairyDrak ; id 64 Divinegon
    dw BreedFamilyResults_FairyDrak ; id 65 Orligon
    dw BreedFamilyResults_FairyDrak ; id 66 GigaDraco
    dw BreedFamilyResults_FairyDrak ; id 67 ?
    dw BreedFamilyResults_FairyDrak ; id 68 ?
    dw BreedFamilyResults_FairyDrak ; id 69 ?
    dw BreedFamilyResults_FairyDrak ; id 70 ?
    dw BreedFamilyResults_FairyDrak ; id 71 Tonguella
    dw BreedFamilyResults_Almiraj ; id 72 Almiraj
    dw BreedFamilyResults_CatFly ; id 73 CatFly
    dw BreedFamilyResults_PillowRat ; id 74 PillowRat
    dw BreedFamilyResults_PillowRat ; id 75 Saccer
    dw BreedFamilyResults_GulpBeast ; id 76 GulpBeast
    dw BreedFamilyResults_Skullroo ; id 77 Skullroo
    dw BreedFamilyResults_Skullroo ; id 78 WindBeast
    dw BreedFamilyResults_Skullroo ; id 79 Beavern
    dw BreedFamilyResults_Skullroo ; id 80 Antbear
    dw BreedFamilyResults_Skullroo ; id 81 SuperTen
    dw BreedFamilyResults_IronTurt ; id 82 IronTurt
    dw BreedFamilyResults_IronTurt ; id 83 Mommonja
    dw BreedFamilyResults_IronTurt ; id 84 HammerMan
    dw BreedFamilyResults_IronTurt ; id 85 Grizzly
    dw BreedFamilyResults_Yeti ; id 86 Yeti
    dw BreedFamilyResults_ArrowDog ; id 87 ArrowDog
    dw BreedFamilyResults_ArrowDog ; id 88 NoctoKing
    dw BreedFamilyResults_ArrowDog ; id 89 BeastNite
    dw BreedFamilyResults_ArrowDog ; id 90 MadGopher
    dw BreedFamilyResults_ArrowDog ; id 91 FairyRat
    dw BreedFamilyResults_ArrowDog ; id 92 Unicorn
    dw BreedFamilyResults_ArrowDog ; id 93 Goategon
    dw BreedFamilyResults_WildApe ; id 94 WildApe
    dw BreedFamilyResults_Trumpeter ; id 95 Trumpeter
    dw BreedFamilyResults_KingLeo ; id 96 KingLeo
    dw BreedFamilyResults_KingLeo ; id 97 DarkHorn
    dw BreedFamilyResults_MadCat ; id 98 MadCat
    dw BreedFamilyResults_MadCat ; id 99 BigEye
    dw BreedFamilyResults_Gorago ; id 100 Gorago
    dw BreedFamilyResults_Gorago ; id 101 CatMage
    dw BreedFamilyResults_Dumbira ; id 102 Dumbira
    dw BreedFamilyResults067 ; id 103 ?
    dw BreedFamilyResults067 ; id 104 ?
    dw BreedFamilyResults067 ; id 105 ?
    dw BreedFamilyResults067 ; id 106 Picky
    dw BreedFamilyResults_Wyvern ; id 107 Wyvern
    dw BreedFamilyResults_BullBird ; id 108 BullBird
    dw BreedFamilyResults_Florajay ; id 109 Florajay
    dw BreedFamilyResults_Florajay ; id 110 DuckKite
    dw BreedFamilyResults_MadPecker ; id 111 MadPecker
    dw BreedFamilyResults_MadPecker ; id 112 MadRaven
    dw BreedFamilyResults_MadPecker ; id 113 MistyWing
    dw BreedFamilyResults_MadPecker ; id 114 AquaHawk
    dw BreedFamilyResults_MadPecker ; id 115 Dracky
    dw BreedFamilyResults_MadPecker ; id 116 KiteHawk
    dw BreedFamilyResults_BigRoost ; id 117 BigRoost
    dw BreedFamilyResults_StubBird ; id 118 StubBird
    dw BreedFamilyResults_StubBird ; id 119 LandOwl
    dw BreedFamilyResults_MadGoose ; id 120 MadGoose
    dw BreedFamilyResults_MadCondor ; id 121 MadCondor
    dw BreedFamilyResults_Emyu ; id 122 Emyu
    dw BreedFamilyResults_Blizzardy ; id 123 Blizzardy
    dw BreedFamilyResults_Blizzardy ; id 124 Phoenix
    dw BreedFamilyResults_ZapBird ; id 125 ZapBird
    dw BreedFamilyResults_ZapBird ; id 126 Garudian
    dw BreedFamilyResults_WhipBird ; id 127 WhipBird
    dw BreedFamilyResults_WhipBird ; id 128 FunkyBird
    dw BreedFamilyResults_WhipBird ; id 129 RainHawk
    dw BreedFamilyResults_Azurile ; id 130 Azurile
    dw BreedFamilyResults_Azurile ; id 131 Shantak
    dw BreedFamilyResults_CragDevil ; id 132 CragDevil
    dw BreedFamilyResults_CragDevil ; id 133 ?
    dw BreedFamilyResults_CragDevil ; id 134 ?
    dw BreedFamilyResults_CragDevil ; id 135 ?
    dw BreedFamilyResults_CragDevil ; id 136 ?
    dw BreedFamilyResults_CragDevil ; id 137 ?
    dw BreedFamilyResults_CragDevil ; id 138 ?
    dw BreedFamilyResults_CragDevil ; id 139 ?
    dw BreedFamilyResults_CragDevil ; id 140 ?
    dw BreedFamilyResults_CragDevil ; id 141 MadPlant
    dw BreedFamilyResults_FireWeed ; id 142 FireWeed
    dw BreedFamilyResults_FireWeed ; id 143 FloraMan
    dw BreedFamilyResults_FireWeed ; id 144 WingTree
    dw BreedFamilyResults_FireWeed ; id 145 CactiBall
    dw BreedFamilyResults_FireWeed ; id 146 Gulpple
    dw BreedFamilyResults_FireWeed ; id 147 Toadstool
    dw BreedFamilyResults_FireWeed ; id 148 AmberWeed
    dw BreedFamilyResults_Slurperon ; id 149 Slurperon
    dw BreedFamilyResults_Slurperon ; id 150 Stubsuck
    dw BreedFamilyResults_Oniono ; id 151 Oniono
    dw BreedFamilyResults_Oniono ; id 152 DanceVegi
    dw BreedFamilyResults_Oniono ; id 153 TreeBoy
    dw BreedFamilyResults_Oniono ; id 154 Devipine
    dw BreedFamilyResults_Oniono ; id 155 FaceTree
    dw BreedFamilyResults_Oniono ; id 156 HerbMan
    dw BreedFamilyResults_BeanMan ; id 157 BeanMan
    dw BreedFamilyResults_BeanMan ; id 158 EvilSeed
    dw BreedFamilyResults_BeanMan ; id 159 ManEater
    dw BreedFamilyResults_BeanMan ; id 160 Snapper
    dw BreedFamilyResults_BeanMan ; id 161 GhosTree
    dw BreedFamilyResults_BeanMan ; id 162 Rosevine
    dw BreedFamilyResults_BeanMan ; id 163 Egdracil
    dw BreedFamilyResults_BeanMan ; id 164 Warubou
    dw BreedFamilyResults_BeanMan ; id 165 Watabou
    dw BreedFamilyResults_BeanMan ; id 166 Eggplaton
    dw BreedFamilyResults_FooHero ; id 167 FooHero
    dw BreedFamilyResults_FooHero ; id 168 ?
    dw BreedFamilyResults_FooHero ; id 169 ?
    dw BreedFamilyResults_FooHero ; id 170 ?
    dw BreedFamilyResults_FooHero ; id 171 ?
    dw BreedFamilyResults_FooHero ; id 172 ?
    dw BreedFamilyResults_FooHero ; id 173 ?
    dw BreedFamilyResults_FooHero ; id 174 ?
    dw BreedFamilyResults_FooHero ; id 175 ?
    dw BreedFamilyResults_FooHero ; id 176 GiantSlug
    dw BreedFamilyResults_Catapila ; id 177 Catapila
    dw BreedFamilyResults_Catapila ; id 178 Gophecada
    dw BreedFamilyResults_Catapila ; id 179 Butterfly
    dw BreedFamilyResults_WeedBug ; id 180 WeedBug
    dw BreedFamilyResults_GiantWorm ; id 181 GiantWorm
    dw BreedFamilyResults_Lipsy ; id 182 Lipsy
    dw BreedFamilyResults_StagBug ; id 183 StagBug
    dw BreedFamilyResults_StagBug ; id 184 Pyuro
    dw BreedFamilyResults_ArmyAnt ; id 185 ArmyAnt
    dw BreedFamilyResults_ArmyAnt ; id 186 GoHopper
    dw BreedFamilyResults_ArmyAnt ; id 187 TailEater
    dw BreedFamilyResults_ArmorPede ; id 188 ArmorPede
    dw BreedFamilyResults_Eyeder ; id 189 Eyeder
    dw BreedFamilyResults_GiantMoth ; id 190 GiantMoth
    dw BreedFamilyResults_GiantMoth ; id 191 Droll
    dw BreedFamilyResults_ArmyCrab ; id 192 ArmyCrab
    dw BreedFamilyResults_ArmyCrab ; id 193 MadHornet
    dw BreedFamilyResults_Belzebub ; id 194 Belzebub
    dw BreedFamilyResults_Belzebub ; id 195 WarMantis
    dw BreedFamilyResults_HornBeet ; id 196 HornBeet
    dw BreedFamilyResults_HornBeet ; id 197 Sickler
    dw BreedFamilyResults_Armorpion ; id 198 Armorpion
    dw BreedFamilyResults_Armorpion ; id 199 Digster
    dw BreedFamilyResults_Armorpion ; id 200 Skularach
    dw BreedFamilyResults_Armorpion ; id 201 MultiEyes
    dw BreedFamilyResults_Armorpion ; id 202 ?
    dw BreedFamilyResults_Armorpion ; id 203 ?
    dw BreedFamilyResults_Armorpion ; id 204 ?
    dw BreedFamilyResults_Armorpion ; id 205 ?
    dw BreedFamilyResults_Armorpion ; id 206 ?
    dw BreedFamilyResults_Armorpion ; id 207 ?
    dw BreedFamilyResults_Armorpion ; id 208 ?
    dw BreedFamilyResults_Armorpion ; id 209 ?
    dw BreedFamilyResults_Armorpion ; id 210 ?
    dw BreedFamilyResults_Armorpion ; id 211 Pixy
    dw BreedFamilyResults_MedusaEye ; id 212 MedusaEye
    dw BreedFamilyResults_AgDevil ; id 213 AgDevil
    dw BreedFamilyResults_AgDevil ; id 214 Demonite
    dw BreedFamilyResults_DarkEye ; id 215 DarkEye
    dw BreedFamilyResults_EyeBall ; id 216 EyeBall
    dw BreedFamilyResults_SkulRider ; id 217 SkulRider
    dw BreedFamilyResults_EvilBeast ; id 218 EvilBeast
    dw BreedFamilyResults_Bubblemon ; id 219 Bubblemon
    dw BreedFamilyResults_Bubblemon ; id 220 1EyeClown
    dw BreedFamilyResults_Gremlin ; id 221 Gremlin
    dw BreedFamilyResults_ArcDemon ; id 222 ArcDemon
    dw BreedFamilyResults_Lionex ; id 223 Lionex
    dw BreedFamilyResults_Lionex ; id 224 GoatHorn
    dw BreedFamilyResults_Orc ; id 225 Orc
    dw BreedFamilyResults_Orc ; id 226 Ogre
    dw BreedFamilyResults_GateGuard ; id 227 GateGuard
    dw BreedFamilyResults_ChopClown ; id 228 ChopClown
    dw BreedFamilyResults_ChopClown ; id 229 BossTroll
    dw BreedFamilyResults_Grendal ; id 230 Grendal
    dw BreedFamilyResults_Grendal ; id 231 Akubar
    dw BreedFamilyResults_Grendal ; id 232 MadKnight
    dw BreedFamilyResults_Grendal ; id 233 EvilWell
    dw BreedFamilyResults_Grendal ; id 234 Gigantes
    dw BreedFamilyResults_Grendal ; id 235 Centasaur
    dw BreedFamilyResults_EvilArmor ; id 236 EvilArmor
    dw BreedFamilyResults_EvilArmor ; id 237 Jamirus
    dw BreedFamilyResults_EvilArmor ; id 238 Durran
    dw BreedFamilyResults_EvilArmor ; id 239 Titanis
    dw BreedFamilyResults_EvilArmor ; id 240 LampGenie
    dw BreedFamilyResults_EvilArmor ; id 241 ?
    dw BreedFamilyResults_EvilArmor ; id 242 ?
    dw BreedFamilyResults_EvilArmor ; id 243 ?
    dw BreedFamilyResults_EvilArmor ; id 244 ?
    dw BreedFamilyResults_EvilArmor ; id 245 ?
    dw BreedFamilyResults_EvilArmor ; id 246 Spooky
    dw BreedFamilyResults_Skullgon ; id 247 Skullgon
    dw BreedFamilyResults_PutrePup ; id 248 PutrePup
    dw BreedFamilyResults_PutrePup ; id 249 RotRaven
    dw BreedFamilyResults_Mummy ; id 250 Mummy
    dw BreedFamilyResults_Mummy ; id 251 DarkCrab
    dw BreedFamilyResults_DeadNite ; id 252 DeadNite
    dw BreedFamilyResults_Shadow ; id 253 Shadow
    dw BreedFamilyResults_Shadow ; id 254 Skulpent
    dw BreedFamilyResults_Hork ; id 255 Hork
    dw BreedFamilyResults_Mudron ; id 256 Mudron
    dw BreedFamilyResults_NiteWhip ; id 257 NiteWhip
    dw BreedFamilyResults_WindMerge ; id 258 WindMerge
    dw BreedFamilyResults_WindMerge ; id 259 Reaper
    dw BreedFamilyResults_WindMerge ; id 260 Inverzon
    dw BreedFamilyResults_WindMerge ; id 261 FoxFire
    dw BreedFamilyResults_CaptDead ; id 262 CaptDead
    dw BreedFamilyResults_CaptDead ; id 263 DeadNoble
    dw BreedFamilyResults_WhiteKing ; id 264 WhiteKing
    dw BreedFamilyResults_BoneSlave ; id 265 BoneSlave
    dw BreedFamilyResults_Skeletor ; id 266 Skeletor
    dw BreedFamilyResults_Servant ; id 267 Servant
    dw BreedFamilyResults_Servant ; id 268 Lazamanus
    dw BreedFamilyResults_Servant ; id 269 Copycat
    dw BreedFamilyResults_Servant ; id 270 MadSpirit
    dw BreedFamilyResults_PomPomBom ; id 271 PomPomBom
    dw BreedFamilyResults_Niterich ; id 272 Niterich
    dw BreedFamilyResults_Niterich ; id 273 ?
    dw BreedFamilyResults_Niterich ; id 274 ?
    dw BreedFamilyResults_Niterich ; id 275 ?
    dw BreedFamilyResults_Niterich ; id 276 ?
    dw BreedFamilyResults_Niterich ; id 277 ?
    dw BreedFamilyResults_Niterich ; id 278 ?
    dw BreedFamilyResults_Niterich ; id 279 ?
    dw BreedFamilyResults_Niterich ; id 280 ?
    dw BreedFamilyResults_Niterich ; id 281 JewelBag
    dw BreedFamilyResults_EvilWand ; id 282 EvilWand
    dw BreedFamilyResults_EvilWand ; id 283 MadCandle
    dw BreedFamilyResults_EvilWand ; id 284 CoilBird
    dw BreedFamilyResults_EvilWand ; id 285 Facer
    dw BreedFamilyResults_EvilWand ; id 286 SpikyBoy
    dw BreedFamilyResults_EvilWand ; id 287 MadMirror
    dw BreedFamilyResults_EvilWand ; id 288 RogueNite
    dw BreedFamilyResults_Puppetor ; id 289 Puppetor
    dw BreedFamilyResults_Goopi ; id 290 Goopi
    dw BreedFamilyResults_Goopi ; id 291 Voodoll
    dw BreedFamilyResults_Goopi ; id 292 MetalDrak
    dw BreedFamilyResults_Goopi ; id 293 Balzak
    dw BreedFamilyResults_Goopi ; id 294 SabreMan
    dw BreedFamilyResults_Goopi ; id 295 CurseLamp
    dw BreedFamilyResults_Goopi ; id 296 Brushead
    dw BreedFamilyResults_Goopi ; id 297 Roboster
    dw BreedFamilyResults_Roboster2 ; id 298 Roboster2
    dw BreedFamilyResults_EvilPot ; id 299 EvilPot
    dw BreedFamilyResults_EvilPot ; id 300 Gismo
    dw BreedFamilyResults_LavaMan ; id 301 LavaMan
    dw BreedFamilyResults_IceMan ; id 302 IceMan
    dw BreedFamilyResults_Mimic ; id 303 Mimic
    dw BreedFamilyResults_Mimic ; id 304 Exaucers
    dw BreedFamilyResults_Mimic ; id 305 MudDoll
    dw BreedFamilyResults_Mimic ; id 306 Golem
    dw BreedFamilyResults_Mimic ; id 307 StoneMan
    dw BreedFamilyResults_Mimic ; id 308 BombCrag
    dw BreedFamilyResults_Mimic ; id 309 GoldGolem
    dw BreedFamilyResults_Mimic ; id 310 DarkMate
    dw BreedFamilyResults_ProtoMech ; id 311 ProtoMech
    dw BreedFamilyResults_ProtoMech ; id 312 CloudKing
    dw BreedFamilyResults_ProtoMech ; id 313 ?
    dw BreedFamilyResults_ProtoMech ; id 314 ?
    dw BreedFamilyResults_ProtoMech ; id 315 ?
    dw BreedFamilyResults_ProtoMech ; id 316 Petiteel
    dw BreedFamilyResults_Moray ; id 317 Moray
    dw BreedFamilyResults_Moray ; id 318 WalrusMan
    dw BreedFamilyResults_Moray ; id 319 RayGigas
    dw BreedFamilyResults_Moray ; id 320 Anemon
    dw BreedFamilyResults_Moray ; id 321 Aquarella
    dw BreedFamilyResults_Merman ; id 322 Merman
    dw BreedFamilyResults_Merman ; id 323 Octokid
    dw BreedFamilyResults_Merman ; id 324 PutreFish
    dw BreedFamilyResults_Merman ; id 325 Octoreach
    dw BreedFamilyResults_Angleron ; id 326 Angleron
    dw BreedFamilyResults_FishRider ; id 327 FishRider
    dw BreedFamilyResults_FishRider ; id 328 RushFish
    dw BreedFamilyResults_FishRider ; id 329 Gamanian
    dw BreedFamilyResults_Clawster ; id 330 Clawster
    dw BreedFamilyResults_CancerMan ; id 331 CancerMan
    dw BreedFamilyResults_CancerMan ; id 332 RogueWave
    dw BreedFamilyResults_Scallopa ; id 333 Scallopa
    dw BreedFamilyResults_Scallopa ; id 334 SeaHorse
    dw BreedFamilyResults_Scallopa ; id 335 HoodSquid
    dw BreedFamilyResults_MerTiger ; id 336 MerTiger
    dw BreedFamilyResults_MerTiger ; id 337 AxeShark
    dw BreedFamilyResults_MerTiger ; id 338 Octogon
    dw BreedFamilyResults_KingSquid ; id 339 KingSquid
    dw FamilyBreedRuleTable ; id 340 Digong
    dw FamilyBreedRuleTable ; id 341 WhaleMage
    dw FamilyBreedRuleTable ; id 342 Aquadon
    dw FamilyBreedRuleTable ; id 343 Octoraid
    dw FamilyBreedRuleTable ; id 344 Grakos
    dw FamilyBreedRuleTable ; id 345 Poseidon
    dw FamilyBreedRuleTable ; id 346 Pumpoise
    dw FamilyBreedRuleTable ; id 347 Starfish
    dw FamilyBreedRuleTable ; id 348 ?
    dw FamilyBreedRuleTable ; id 349 ?
    dw FamilyBreedRuleTable ; id 350 ?
    dw FamilyBreedRuleTable ; id 351 DracoLord
    dw FamilyBreedRuleTable ; id 352 DracoLord
    dw FamilyBreedRuleTable ; id 353 LordDraco
    dw FamilyBreedRuleTable ; id 354 Hargon
    dw FamilyBreedRuleTable ; id 355 Sidoh
    dw FamilyBreedRuleTable ; id 356 Genosidoh
    dw FamilyBreedRuleTable ; id 357 Baramos
    dw FamilyBreedRuleTable ; id 358 Zoma
    dw FamilyBreedRuleTable ; id 359 AsuraZoma
    dw FamilyBreedRuleTable ; id 360 Pizzaro
    dw FamilyBreedRuleTable ; id 361 PsychoPiz
    dw FamilyBreedRuleTable ; id 362 Esterk
    dw FamilyBreedRuleTable ; id 363 Mirudraas
    dw FamilyBreedRuleTable ; id 364 Mirudraas
    dw FamilyBreedRuleTable ; id 365 Mudou
    dw FamilyBreedRuleTable ; id 366 DeathMore
    dw FamilyBreedRuleTable ; id 367 DeathMore
    dw FamilyBreedRuleTable ; id 368 DeathMore
    dw FamilyBreedRuleTable ; id 369 Darkdrium
    dw FamilyBreedRuleTable ; id 370 Orgodemir
    dw FamilyBreedRuleTable ; id 371 Orgodemir
    dw FamilyBreedRuleTable ; id 372 Darck
    dw FamilyBreedRuleTable ; id 373 Tatsu
    dw FamilyBreedRuleTable ; id 374 Diago
    dw FamilyBreedRuleTable ; id 375 Samsi
    dw BreedFamilyResults000 ; id 376 Bazoo
    dw BreedFamilyResults000 ; id 377 ?
    dw BreedFamilyResults000 ; id 378 ?
    dw BreedFamilyResults000 ; id 379 ?
    dw BreedFamilyResults000 ; id 380 Lamia
    dw BreedFamilyResults000 ; id 381 Dimensaur
    dw BreedFamilyResults000 ; id 382 Kagebou
    dw BreedFamilyResults000 ; id 383 ?

; list for entry $00 of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults000::
    dw $ffff ; id 0

; list for entry $01 (DrakSlime) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_DrakSlime::
    dw MONSTER_TROPICGEL ; id 0

; list for entry $05 (Snaily) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Snaily::
    dw MONSTER_HALOSLIME ; id 0

; list for entry $0C (FangSlime) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_FangSlime::
    dw MONSTER_HALOSLIME ; id 0

; list for entry $16 (HaloSlime) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_HaloSlime::
    dw MONSTER_TROPICGEL ; id 0
    dw MONSTER_MIMESLIME ; id 1
    dw MONSTER_HALOSLIME ; id 2

; list for entry $1B (Butch) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Butch::
    dw MONSTER_MADDRAGON ; id 0

; list for entry $28 (FairyDrak) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_FairyDrak::
    dw MONSTER_UNICORN ; id 0

; list for entry $48 (Almiraj) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Almiraj::
    dw MONSTER_WILDAPE ; id 0

; list for entry $49 (CatFly) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_CatFly::
    dw MONSTER_WINDBEAST ; id 0

; list for entry $4A (PillowRat) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_PillowRat::
    dw MONSTER_ANTBEAR ; id 0

; list for entry $4C (GulpBeast) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_GulpBeast::
    dw MONSTER_UNICORN ; id 0

; list for entry $4D (Skullroo) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Skullroo::
    dw MONSTER_TRUMPETER ; id 0

; list for entry $52 (IronTurt) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_IronTurt::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_GULPBEAST ; id 1
    dw MONSTER_UNICORN ; id 2

; list for entry $56 (Yeti) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Yeti::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_UNICORN ; id 1

; list for entry $57 (ArrowDog) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ArrowDog::
    dw MONSTER_UNICORN ; id 0

; list for entry $5E (WildApe) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_WildApe::
    dw MONSTER_UNICORN ; id 0

; list for entry $5F (Trumpeter) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Trumpeter::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_UNICORN ; id 1

; list for entry $60 (KingLeo) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_KingLeo::
    dw MONSTER_GORAGO ; id 0

; list for entry $62 (MadCat) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_MadCat::
    dw MONSTER_GULPBEAST ; id 0

; list for entry $64 (Gorago) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Gorago::
    dw MONSTER_BEASTNITE ; id 0

; list for entry $66 (Dumbira) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Dumbira::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_SUPERTEN ; id 1

; list for entry $67 (?) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults067::
    dw MONSTER_DRACKY ; id 0

; list for entry $6B (Wyvern) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Wyvern::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1

; list for entry $6C (BullBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_BullBird::
    dw MONSTER_LANDOWL ; id 0

; list for entry $6D (Florajay) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Florajay::
    dw MONSTER_KITEHAWK ; id 0

; list for entry $6F (MadPecker) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_MadPecker::
    dw MONSTER_EMYU ; id 0

; list for entry $75 (BigRoost) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_BigRoost::
    dw MONSTER_CRAGDEVIL ; id 0

; list for entry $76 (StubBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_StubBird::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1
    dw MONSTER_MADCONDOR ; id 2

; list for entry $78 (MadGoose) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_MadGoose::
    dw MONSTER_CRAGDEVIL ; id 0

; list for entry $79 (MadCondor) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_MadCondor::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1

; list for entry $7A (Emyu) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Emyu::
    dw MONSTER_CRAGDEVIL ; id 0

; list for entry $7B (Blizzardy) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Blizzardy::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1

; list for entry $7D (ZapBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_ZapBird::
    dw MONSTER_LANDOWL ; id 0

; list for entry $7F (WhipBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_WhipBird::
    dw MONSTER_AZURILE ; id 0

; list for entry $82 (Azurile) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Azurile::
    dw MONSTER_AZURILE ; id 0

; list for entry $84 (CragDevil) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_CragDevil::
    dw MONSTER_DANCEVEGI ; id 0

; list for entry $8E (FireWeed) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_FireWeed::
    dw MONSTER_STUBSUCK ; id 0

; list for entry $95 (Slurperon) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Slurperon::
    dw MONSTER_GHOSTREE ; id 0

; list for entry $97 (Oniono) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Oniono::
    dw MONSTER_FACETREE ; id 0

; list for entry $9D (BeanMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_BeanMan::
    dw MONSTER_BEANMAN ; id 0
    dw MONSTER_EVILSEED ; id 1

; list for entry $A7 (FooHero) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_FooHero::
    dw MONSTER_ARMYANT ; id 0

; list for entry $B1 (Catapila) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Catapila::
    dw MONSTER_GIANTMOTH ; id 0

; list for entry $B4 (WeedBug) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_WeedBug::
    dw MONSTER_TAILEATER ; id 0

; list for entry $B5 (GiantWorm) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_GiantWorm::
    dw MONSTER_ARMORPEDE ; id 0

; list for entry $B6 (Lipsy) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Lipsy::
    dw MONSTER_DROLL ; id 0

; list for entry $B7 (StagBug) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_StagBug::
    dw MONSTER_MADHORNET ; id 0

; list for entry $B9 (ArmyAnt) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ArmyAnt::
    dw MONSTER_MULTIEYES ; id 0

; list for entry $BC (ArmorPede) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ArmorPede::
    dw MONSTER_HORNBEET ; id 0

; list for entry $BD (Eyeder) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Eyeder::
    dw MONSTER_MADHORNET ; id 0

; list for entry $BE (GiantMoth) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_GiantMoth::
    dw MONSTER_ARMORPEDE ; id 0
    dw MONSTER_MADHORNET ; id 1

; list for entry $C0 (ArmyCrab) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ArmyCrab::
    dw MONSTER_BELZEBUB ; id 0

; list for entry $C2 (Belzebub) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Belzebub::
    dw MONSTER_HORNBEET ; id 0
    dw MONSTER_SICKLER ; id 1

; list for entry $C4 (HornBeet) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_HornBeet::
    dw MONSTER_WARMANTIS ; id 0

; list for entry $C6 (Armorpion) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Armorpion::
    dw MONSTER_1EYECLOWN ; id 0

; list for entry $D4 (MedusaEye) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_MedusaEye::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_GRENDAL ; id 1
    dw MONSTER_GIGANTES ; id 2

; list for entry $D5 (AgDevil) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_AgDevil::
    dw MONSTER_1EYECLOWN ; id 0

; list for entry $D7 (DarkEye) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_DarkEye::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $D8 (EyeBall) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_EyeBall::
    dw MONSTER_1EYECLOWN ; id 0

; list for entry $D9 (SkulRider) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_SkulRider::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_GRENDAL ; id 1
    dw MONSTER_GIGANTES ; id 2

; list for entry $DA (EvilBeast) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_EvilBeast::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_GRENDAL ; id 1
    dw MONSTER_GIGANTES ; id 2

; list for entry $DB (Bubblemon) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Bubblemon::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $DD (Gremlin) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Gremlin::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_MEDUSAEYE ; id 1
    dw MONSTER_GRENDAL ; id 2

; list for entry $DE (ArcDemon) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ArcDemon::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_GOATHORN ; id 1
    dw MONSTER_CENTASAUR ; id 2
    dw MONSTER_EVILARMOR ; id 3

; list for entry $DF (Lionex) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Lionex::
    dw MONSTER_BOSSTROLL ; id 0

; list for entry $E1 (Orc) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Orc::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_GATEGUARD ; id 1
    dw MONSTER_CENTASAUR ; id 2
    dw MONSTER_EVILARMOR ; id 3

; list for entry $E3 (GateGuard) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_GateGuard::
    dw MONSTER_OGRE ; id 0
    dw MONSTER_CENTASAUR ; id 1
    dw MONSTER_EVILARMOR ; id 2

; list for entry $E4 (ChopClown) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ChopClown::
    dw MONSTER_CENTASAUR ; id 0

; list for entry $E6 (Grendal) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Grendal::
    dw MONSTER_LAMPGENIE ; id 0

; list for entry $EC (EvilArmor) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_EvilArmor::
    dw MONSTER_REAPER ; id 0
    dw MONSTER_HORK ; id 1

; list for entry $F7 (Skullgon) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Skullgon::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $F8 (PutrePup) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_PutrePup::
    dw MONSTER_WINDMERGE ; id 0

; list for entry $FA (Mummy) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Mummy::
    dw MONSTER_NITEWHIP ; id 0

; list for entry $FC (DeadNite) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_DeadNite::
    dw MONSTER_SKULPENT ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $FD (Shadow) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Shadow::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_DEADNITE ; id 1

; list for entry $FF (Hork) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Hork::
    dw MONSTER_REAPER ; id 0

; list for entry $100 (Mudron) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Mudron::
    dw MONSTER_MADSPIRIT ; id 0

; list for entry $101 (NiteWhip) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_NiteWhip::
    dw MONSTER_FOXFIRE ; id 0

; list for entry $102 (WindMerge) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_WindMerge::
    dw MONSTER_POMPOMBOM ; id 0

; list for entry $106 (CaptDead) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_CaptDead::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $108 (WhiteKing) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_WhiteKing::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_SERVANT ; id 1

; list for entry $109 (BoneSlave) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_BoneSlave::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_CAPTDEAD ; id 1
    dw MONSTER_MADSPIRIT ; id 2

; list for entry $10A (Skeletor) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Skeletor::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $10B (Servant) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Servant::
    dw MONSTER_NITEWHIP ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $10F (PomPomBom) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_PomPomBom::
    dw MONSTER_MADSPIRIT ; id 0

; list for entry $110 (Niterich) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Niterich::
    dw MONSTER_GOOPI ; id 0

; list for entry $11A (EvilWand) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_EvilWand::
    dw MONSTER_PROTOMECH ; id 0

; list for entry $121 (Puppetor) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Puppetor::
    dw MONSTER_VOODOLL ; id 0

; list for entry $122 (Goopi) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Goopi::
    dw MONSTER_PROTOMECH ; id 0
    dw MONSTER_METALDRAK ; id 1
    dw MONSTER_CURSELAMP ; id 2
    dw MONSTER_MIMIC ; id 3
    dw MONSTER_BOMBCRAG ; id 4

; list for entry $12A (Roboster2) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Roboster2::
    dw MONSTER_PROTOMECH ; id 0
    dw MONSTER_METALDRAK ; id 1
    dw MONSTER_CURSELAMP ; id 2

; list for entry $12B (EvilPot) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_EvilPot::
    dw MONSTER_EVILPOT ; id 0

; list for entry $12D (LavaMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_LavaMan::
    dw MONSTER_BALZAK ; id 0

; list for entry $12E (IceMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_IceMan::
    dw MONSTER_BALZAK ; id 0

; list for entry $12F (Mimic) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Mimic::
    dw MONSTER_BOMBCRAG ; id 0

; list for entry $137 (ProtoMech) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_ProtoMech::
    dw MONSTER_OCTOREACH ; id 0
    dw MONSTER_ANGLERON ; id 1
    dw MONSTER_SEAHORSE ; id 2
    dw MONSTER_SEAHORSE ; id 3

; list for entry $13D (Moray) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Moray::
    dw MONSTER_GAMANIAN ; id 0

; list for entry $142 (Merman) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Merman::
    dw MONSTER_STARFISH ; id 0

; list for entry $146 (Angleron) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Angleron::
    dw MONSTER_RUSHFISH ; id 0

; list for entry $147 (FishRider) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_FishRider::
    dw MONSTER_CLAWSTER ; id 0

; list for entry $14A (Clawster) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_Clawster::
    dw MONSTER_CANCERMAN ; id 0

; list for entry $14B (CancerMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_CancerMan::
    dw MONSTER_SCALLOPA ; id 0

; list for entry $14D (Scallopa) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults_Scallopa::
    dw MONSTER_STARFISH ; id 0

; list for entry $150 (MerTiger) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_MerTiger::
    dw MONSTER_STARFISH ; id 0
    dw MONSTER_KINGSQUID ; id 1

; list for entry $153 (KingSquid) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults_KingSquid::
    dw MONSTER_STARFISH ; id 0

; stage 3, when stage 2 finds nothing: the word list at $7B83 + 2 * parent A's family holds partner
; species ($FDxx = next result, $FFxx = end); a match takes result [count] from
; FamilyBreedResultTable (E-0199, C1)
; record: list
FamilyBreedRuleTable::
    dw FamilyBreedRules000 ; id 0
    dw FamilyBreedRules001 ; id 1
    dw FamilyBreedRules002 ; id 2
    dw FamilyBreedRules003 ; id 3
    dw FamilyBreedRules004 ; id 4
    dw FamilyBreedRules005 ; id 5
    dw FamilyBreedRules006 ; id 6
    dw FamilyBreedRules007 ; id 7
    dw FamilyBreedRules008 ; id 8
    dw FamilyBreedRules009 ; id 9
    dw FamilyBreedRules00A ; id 10

; list for entry $00 of FamilyBreedRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
FamilyBreedRules000::
    dw MONSTER_POISONGON ; id 0
    dw MONSTER_GIANTMOTH ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_PILLOWRAT ; id 3
    dw MONSTER_FUNKYBIRD ; id 4
    dw MONSTER_MADPLANT ; id 5
    dw MONSTER_COPYCAT ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_ALMIRAJ ; id 8
    dw MONSTER_GULPBEAST ; id 9
    dw MONSTER_TRUMPETER ; id 10
    dw MONSTER_KINGLEO ; id 11
    dw MONSTER_DARKHORN ; id 12
    dw MONSTER_MADCAT ; id 13
    dw $fdfd ; id 14 next result
    dw MONSTER_DEADNITE ; id 15
    dw MONSTER_GOLEM ; id 16
    dw MONSTER_STONEMAN ; id 17
    dw MONSTER_BOMBCRAG ; id 18
    dw $fdfd ; id 19 next result
    dw MONSTER_ROBOSTER ; id 20
    dw $fdfd ; id 21 next result
    dw MONSTER_SKULLROO ; id 22
    dw $fdfd ; id 23 next result
    dw MONSTER_METALDRAK ; id 24
    dw $ffff ; id 25 end of list

; list for entry $01 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules001::
    dw MONSTER_PICKY ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GULPBEAST ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_MADCONDOR ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_VOODOLL ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_GOHOPPER ; id 8
    dw $fdfd ; id 9 next result
    dw MONSTER_GULPPLE ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_BABBLE ; id 12
    dw $fdfd ; id 13 next result
    dw MONSTER_MADGOOSE ; id 14
    dw $fdfd ; id 15 next result
    dw MONSTER_CATFLY ; id 16
    dw $fdfd ; id 17 next result
    dw MONSTER_ARMYCRAB ; id 18
    dw MONSTER_DIGSTER ; id 19
    dw $fdfd ; id 20 next result
    dw MONSTER_KINGSLIME ; id 21
    dw MONSTER_SPOTKING ; id 22
    dw MONSTER_METALKING ; id 23
    dw MONSTER_BATTLEREX ; id 24
    dw MONSTER_UNICORN ; id 25
    dw MONSTER_ZAPBIRD ; id 26
    dw MONSTER_WHIPBIRD ; id 27
    dw MONSTER_GIGANTES ; id 28
    dw MONSTER_CENTASAUR ; id 29
    dw $fdfd ; id 30 next result
    dw MONSTER_BIGROOST ; id 31
    dw $fdfd ; id 32 next result
    dw MONSTER_KINGLEO ; id 33
    dw MONSTER_LIONEX ; id 34
    dw MONSTER_OGRE ; id 35
    dw MONSTER_MADKNIGHT ; id 36
    dw MONSTER_EVILARMOR ; id 37
    dw $fdfd ; id 38 next result
    dw MONSTER_PHOENIX ; id 39
    dw $ffff ; id 40 end of list

; list for entry $02 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules002::
    dw MONSTER_MUDRON ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_TORTRAGON ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_DUCKKITE ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_STUBSUCK ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_METALDRAK ; id 8
    dw MONSTER_ROBOSTER ; id 9
    dw MONSTER_LAVAMAN ; id 10
    dw MONSTER_ICEMAN ; id 11
    dw MONSTER_GOLEM ; id 12
    dw MONSTER_STONEMAN ; id 13
    dw $fdfd ; id 14 next result
    dw MONSTER_PUTREPUP ; id 15
    dw $fdfd ; id 16 next result
    dw MONSTER_EVILARMOR ; id 17
    dw $fdfd ; id 18 next result
    dw MONSTER_SABREMAN ; id 19
    dw $fdfd ; id 20 next result
    dw MONSTER_LIZARDFLY ; id 21
    dw $fdfd ; id 22 next result
    dw MONSTER_FANGSLIME ; id 23
    dw $fdfd ; id 24 next result
    dw MONSTER_DRAKSLIME ; id 25
    dw MONSTER_LIZARDMAN ; id 26
    dw $fdfd ; id 27 next result
    dw MONSTER_MADPECKER ; id 28
    dw $fdfd ; id 29 next result
    dw MONSTER_DRAGON ; id 30
    dw $fdfd ; id 31 next result
    dw MONSTER_DRYGON ; id 32
    dw MONSTER_EYEBALL ; id 33
    dw $ffff ; id 34 end of list

; list for entry $03 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules003::
    dw MONSTER_FACER ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_ROCKSLIME ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_DROLL ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_COILBIRD ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_METALY ; id 8
    dw MONSTER_METABBLE ; id 9
    dw MONSTER_SUPERTEN ; id 10
    dw MONSTER_YETI ; id 11
    dw MONSTER_GOATEGON ; id 12
    dw MONSTER_TRUMPETER ; id 13
    dw MONSTER_SKULLGON ; id 14
    dw MONSTER_DEADNOBLE ; id 15
    dw MONSTER_WHITEKING ; id 16
    dw MONSTER_SKELETOR ; id 17
    dw MONSTER_ICEMAN ; id 18
    dw $fdfd ; id 19 next result
    dw MONSTER_DRAKSLIME ; id 20
    dw MONSTER_GULPBEAST ; id 21
    dw MONSTER_IRONTURT ; id 22
    dw MONSTER_GRIZZLY ; id 23
    dw MONSTER_ARCDEMON ; id 24
    dw MONSTER_COPYCAT ; id 25
    dw MONSTER_GISMO ; id 26
    dw MONSTER_LAVAMAN ; id 27
    dw $fdfd ; id 28 next result
    dw MONSTER_RAYBURN ; id 29
    dw MONSTER_SNAKEBAT ; id 30
    dw $fdfd ; id 31 next result
    dw MONSTER_TROPICGEL ; id 32
    dw MONSTER_DANCEVEGI ; id 33
    dw MONSTER_PYURO ; id 34
    dw MONSTER_BRUSHEAD ; id 35
    dw $ffff ; id 36 end of list

; list for entry $04 of FamilyBreedRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
FamilyBreedRules004::
    dw MONSTER_GOPHECADA ; id 0
    dw MONSTER_ANEMON ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_FACER ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_PIXY ; id 5
    dw $fdfd ; id 6 next result
    dw MONSTER_GULPPLE ; id 7
    dw $fdfd ; id 8 next result
    dw MONSTER_NITEWHIP ; id 9
    dw $fdfd ; id 10 next result
    dw MONSTER_FUNKYBIRD ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_PILLOWRAT ; id 13
    dw MONSTER_FISHRIDER ; id 14
    dw $fdfd ; id 15 next result
    dw MONSTER_ROCKSLIME ; id 16
    dw MONSTER_BIGEYE ; id 17
    dw MONSTER_DUCKKITE ; id 18
    dw MONSTER_KITEHAWK ; id 19
    dw MONSTER_BUTTERFLY ; id 20
    dw MONSTER_EYEDER ; id 21
    dw MONSTER_DARKEYE ; id 22
    dw MONSTER_EYEBALL ; id 23
    dw MONSTER_MADMIRROR ; id 24
    dw MONSTER_GAMANIAN ; id 25
    dw $fdfd ; id 26 next result
    dw MONSTER_LIPSY ; id 27
    dw MONSTER_DROLL ; id 28
    dw MONSTER_AQUARELLA ; id 29
    dw $ffff ; id 30 end of list

; list for entry $05 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules005::
    dw MONSTER_FLORAMAN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_IRONTURT ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_AMBERWEED ; id 4
    dw MONSTER_OCTOREACH ; id 5
    dw MONSTER_GAMANIAN ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_SACCER ; id 8
    dw MONSTER_RAYGIGAS ; id 9
    dw $fdfd ; id 10 next result
    dw MONSTER_SPOOKY ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_DARKCRAB ; id 13
    dw MONSTER_CANCERMAN ; id 14
    dw $fdfd ; id 15 next result
    dw MONSTER_FAIRYRAT ; id 16
    dw $fdfd ; id 17 next result
    dw MONSTER_1EYECLOWN ; id 18
    dw MONSTER_REAPER ; id 19
    dw $ffff ; id 20 end of list

; list for entry $06 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules006::
    dw MONSTER_LIZARDMAN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_DARKHORN ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_BEANMAN ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_HAMMERMAN ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_MADDRAGON ; id 8
    dw MONSTER_BEASTNITE ; id 9
    dw $fdfd ; id 10 next result
    dw MONSTER_ROGUENITE ; id 11
    dw $fdfd ; id 12 next result
    dw MONSTER_BIGEYE ; id 13
    dw $fdfd ; id 14 next result
    dw MONSTER_ARMORPEDE ; id 15
    dw $ffff ; id 16 end of list

; list for entry $07 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules007::
    dw MONSTER_SWORDGON ; id 0
    dw MONSTER_RAYBURN ; id 1
    dw MONSTER_ANDREAL ; id 2
    dw MONSTER_GREATDRAK ; id 3
    dw MONSTER_OROCHI ; id 4
    dw MONSTER_BATTLEREX ; id 5
    dw MONSTER_DIVINEGON ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_GAMANIAN ; id 8
    dw MONSTER_CLAWSTER ; id 9
    dw MONSTER_CANCERMAN ; id 10
    dw $fdfd ; id 11 next result
    dw MONSTER_BOXSLIME ; id 12
    dw MONSTER_FANGSLIME ; id 13
    dw MONSTER_TONGUELLA ; id 14
    dw MONSTER_YETI ; id 15
    dw MONSTER_FUNKYBIRD ; id 16
    dw MONSTER_MADPLANT ; id 17
    dw MONSTER_DANCEVEGI ; id 18
    dw MONSTER_GIANTSLUG ; id 19
    dw MONSTER_LIPSY ; id 20
    dw MONSTER_DROLL ; id 21
    dw $fdfd ; id 22 next result
    dw MONSTER_MISTYWING ; id 23
    dw $fdfd ; id 24 next result
    dw MONSTER_WINDBEAST ; id 25
    dw $fdfd ; id 26 next result
    dw MONSTER_WEEDBUG ; id 27
    dw $ffff ; id 28 end of list

; list for entry $08 of FamilyBreedRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
FamilyBreedRules008::
    dw MONSTER_GREMLIN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_LIPSY ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_ANDREAL ; id 4
    dw $fdfd ; id 5 next result
    dw MONSTER_GIANTWORM ; id 6
    dw $fdfd ; id 7 next result
    dw MONSTER_WINGTREE ; id 8
    dw $fdfd ; id 9 next result
    dw MONSTER_GULPBEAST ; id 10
    dw MONSTER_GRIZZLY ; id 11
    dw MONSTER_TRUMPETER ; id 12
    dw MONSTER_KINGLEO ; id 13
    dw MONSTER_SKULRIDER ; id 14
    dw $fdfd ; id 15 next result
    dw MONSTER_SNAILY ; id 16
    dw $fdfd ; id 17 next result
    dw MONSTER_BOXSLIME ; id 18
    dw $fdfd ; id 19 next result
    dw MONSTER_DRACKY ; id 20
    dw $fdfd ; id 21 next result
    dw MONSTER_HORNBEET ; id 22
    dw MONSTER_DIGSTER ; id 23
    dw $fdfd ; id 24 next result
    dw MONSTER_EVILARMOR ; id 25
    dw $ffff ; id 26 end of list

; list for entry $09 of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules009::
    dw MONSTER_JEWELBAG ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_MOMMONJA ; id 2
    dw MONSTER_DUCKKITE ; id 3
    dw MONSTER_MADPECKER ; id 4
    dw MONSTER_MADGOOSE ; id 5
    dw MONSTER_CRAGDEVIL ; id 6
    dw MONSTER_SPIKYBOY ; id 7
    dw MONSTER_BOMBCRAG ; id 8
    dw $ffff ; id 9 end of list

; list for entry $0A of FamilyBreedRuleTable; it runs to the next list (E-0199)
FamilyBreedRules00A::
    dw $ffff ; id 0 end of list

; stage 3 result lists, indexed by parent A's family (E-0199, C1)
; record: list
FamilyBreedResultTable::
    dw FamilyBreedResults000 ; id 0
    dw FamilyBreedResults001 ; id 1
    dw FamilyBreedResults002 ; id 2
    dw FamilyBreedResults003 ; id 3
    dw FamilyBreedResults004 ; id 4
    dw FamilyBreedResults005 ; id 5
    dw FamilyBreedResults006 ; id 6
    dw FamilyBreedResults007 ; id 7
    dw FamilyBreedResults008 ; id 8
    dw FamilyBreedResults009 ; id 9
    dw FamilyPairResultTable ; id 10

; list for entry $00 of FamilyBreedResultTable; it runs to the next list (E-0199)
; record: child species
FamilyBreedResults000::
    dw MONSTER_BABBLE ; id 0
    dw MONSTER_HEALER ; id 1
    dw MONSTER_FANGSLIME ; id 2
    dw MONSTER_ROCKSLIME ; id 3
    dw MONSTER_SLIMEBORG ; id 4
    dw MONSTER_SLABBIT ; id 5
    dw MONSTER_METALY ; id 6

; list for entry $01 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults001::
    dw MONSTER_MINIDRAK ; id 0
    dw MONSTER_MADDRAGON ; id 1
    dw MONSTER_RAYBURN ; id 2
    dw MONSTER_CHAMELGON ; id 3
    dw MONSTER_LIZARDFLY ; id 4
    dw MONSTER_ANDREAL ; id 5
    dw MONSTER_KINGCOBRA ; id 6
    dw MONSTER_VAMPIRUS ; id 7
    dw MONSTER_SNAKEBAT ; id 8
    dw MONSTER_SPIKEROUS ; id 9
    dw MONSTER_GREATDRAK ; id 10
    dw MONSTER_CRESTPENT ; id 11
    dw MONSTER_BATTLEREX ; id 12
    dw MONSTER_SKYDRAGON ; id 13

; list for entry $02 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults002::
    dw MONSTER_SUPERTEN ; id 0
    dw MONSTER_IRONTURT ; id 1
    dw MONSTER_MOMMONJA ; id 2
    dw MONSTER_HAMMERMAN ; id 3
    dw MONSTER_GRIZZLY ; id 4
    dw MONSTER_ARROWDOG ; id 5
    dw MONSTER_BEASTNITE ; id 6
    dw MONSTER_MADGOPHER ; id 7
    dw MONSTER_FAIRYRAT ; id 8
    dw MONSTER_UNICORN ; id 9
    dw MONSTER_GOATEGON ; id 10
    dw MONSTER_WILDAPE ; id 11
    dw MONSTER_MADCAT ; id 12
    dw MONSTER_BIGEYE ; id 13

; list for entry $03 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults003::
    dw MONSTER_KITEHAWK ; id 0
    dw MONSTER_STUBBIRD ; id 1
    dw MONSTER_MADGOOSE ; id 2
    dw MONSTER_MADCONDOR ; id 3
    dw MONSTER_BLIZZARDY ; id 4
    dw MONSTER_PHOENIX ; id 5
    dw MONSTER_WHIPBIRD ; id 6
    dw MONSTER_FUNKYBIRD ; id 7

; list for entry $04 of FamilyBreedResultTable; it runs to the next list (E-0199)
; record: child species
FamilyBreedResults004::
    dw MONSTER_ONIONO ; id 0
    dw MONSTER_DANCEVEGI ; id 1
    dw MONSTER_TREEBOY ; id 2
    dw MONSTER_DEVIPINE ; id 3
    dw MONSTER_FACETREE ; id 4
    dw MONSTER_HERBMAN ; id 5
    dw MONSTER_BEANMAN ; id 6
    dw MONSTER_EVILSEED ; id 7
    dw MONSTER_EGGPLATON ; id 8

; list for entry $05 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults005::
    dw MONSTER_TAILEATER ; id 0
    dw MONSTER_ARMORPEDE ; id 1
    dw MONSTER_EYEDER ; id 2
    dw MONSTER_GIANTMOTH ; id 3
    dw MONSTER_DROLL ; id 4
    dw MONSTER_ARMYCRAB ; id 5
    dw MONSTER_MADHORNET ; id 6
    dw MONSTER_SICKLER ; id 7

; list for entry $06 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults006::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_GOATHORN ; id 1
    dw MONSTER_ORC ; id 2
    dw MONSTER_OGRE ; id 3
    dw MONSTER_GRENDAL ; id 4
    dw MONSTER_MADKNIGHT ; id 5
    dw MONSTER_GIGANTES ; id 6
    dw MONSTER_EVILARMOR ; id 7

; list for entry $07 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults007::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_DARKCRAB ; id 1
    dw MONSTER_MUDRON ; id 2
    dw MONSTER_NITEWHIP ; id 3
    dw MONSTER_WINDMERGE ; id 4
    dw MONSTER_REAPER ; id 5

; list for entry $08 of FamilyBreedResultTable; it runs to the next list (E-0199)
; record: child species
FamilyBreedResults008::
    dw MONSTER_PUPPETOR ; id 0
    dw MONSTER_VOODOLL ; id 1
    dw MONSTER_METALDRAK ; id 2
    dw MONSTER_SABREMAN ; id 3
    dw MONSTER_CURSELAMP ; id 4
    dw MONSTER_ROBOSTER ; id 5
    dw MONSTER_EVILPOT ; id 6
    dw MONSTER_MIMIC ; id 7
    dw MONSTER_EXAUCERS ; id 8
    dw MONSTER_STONEMAN ; id 9
    dw MONSTER_PROTOMECH ; id 10

; list for entry $09 of FamilyBreedResultTable; it runs to the next list (E-0199)
FamilyBreedResults009::
    dw MONSTER_ROGUEWAVE ; id 0
    dw MONSTER_PUMPOISE ; id 1

; E-0199 (C1: stage 4, when stage 3 finds nothing: the row at $7E83 + 2 * parent A's family, word
; [parent B's family]: $FFFF = parent A's species, $FExx = no child (wNameEntryState = 6, wArg5 =
; $FF), otherwise the child's species; 11 rows of 11 words end at Script_ItsAccessoryIsIn) C2 from
; E-0328 for rows 4 (plant) x columns 3 and 5: base Gulpple with a Dracky mate gives WingTree and
; with a family-5 mate CactiBall in the game's own breeding.
; record: list
FamilyPairResultTable::
    dw FamilyPairResults000 ; id 0
    dw FamilyPairResults001 ; id 1
    dw FamilyPairResults002 ; id 2
    dw FamilyPairResults003 ; id 3
    dw FamilyPairResults004 ; id 4
    dw FamilyPairResults005 ; id 5
    dw FamilyPairResults006 ; id 6
    dw FamilyPairResults007 ; id 7
    dw FamilyPairResults008 ; id 8
    dw FamilyPairResults009 ; id 9
    dw FamilyPairResults00A ; id 10

; list for entry $00 of FamilyPairResultTable; it runs to the next list (E-0199)
; record: child species for parent-B families 0-10
FamilyPairResults000::
    dw $ffff ; id 0 parent A's species
    dw MONSTER_DRAKSLIME
    dw MONSTER_SPOTSLIME
    dw MONSTER_WINGSLIME
    dw MONSTER_TREESLIME
    dw MONSTER_SNAILY
    dw MONSTER_SLIMENITE
    dw MONSTER_BABBLE
    dw MONSTER_BOXSLIME
    dw MONSTER_PEARLGEL
    dw MONSTER_KINGSLIME

; list for entry $01 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults001::
    dw MONSTER_DRAGONKID ; id 0
    dw $ffff ; parent A's species
    dw MONSTER_TORTRAGON
    dw MONSTER_PTERANOD
    dw MONSTER_GASGON
    dw MONSTER_FAIRYDRAK
    dw MONSTER_LIZARDMAN
    dw MONSTER_POISONGON
    dw MONSTER_SWORDGON
    dw MONSTER_DRYGON
    dw MONSTER_OROCHI

; list for entry $02 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults002::
    dw MONSTER_TONGUELLA ; id 0
    dw MONSTER_ALMIRAJ
    dw $ffff ; parent A's species
    dw MONSTER_CATFLY
    dw MONSTER_PILLOWRAT
    dw MONSTER_SACCER
    dw MONSTER_GRIZZLY
    dw MONSTER_SKULLROO
    dw MONSTER_WINDBEAST
    dw MONSTER_BEAVERN
    dw MONSTER_DARKHORN

; list for entry $03 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults003::
    dw MONSTER_PICKY ; id 0
    dw MONSTER_WYVERN
    dw MONSTER_BULLBIRD
    dw $ffff ; parent A's species
    dw MONSTER_FLORAJAY
    dw MONSTER_DUCKKITE
    dw MONSTER_MADPECKER
    dw MONSTER_MADRAVEN
    dw MONSTER_MISTYWING
    dw MONSTER_AQUAHAWK
    dw MONSTER_ZAPBIRD

; list for entry $04 of FamilyPairResultTable; it runs to the next list (E-0199)
; record: child species for parent-B families 0-10
FamilyPairResults004::
    dw MONSTER_MADPLANT ; id 0
    dw MONSTER_FIREWEED
    dw MONSTER_FLORAMAN
    dw MONSTER_WINGTREE
    dw $ffff ; parent A's species
    dw MONSTER_CACTIBALL
    dw MONSTER_GULPPLE
    dw MONSTER_TOADSTOOL
    dw MONSTER_AMBERWEED
    dw MONSTER_SLURPERON
    dw MONSTER_ROSEVINE

; list for entry $05 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults005::
    dw MONSTER_GIANTSLUG ; id 0
    dw MONSTER_CATAPILA
    dw MONSTER_GOPHECADA
    dw MONSTER_BUTTERFLY
    dw MONSTER_WEEDBUG
    dw $ffff ; parent A's species
    dw MONSTER_GIANTWORM
    dw MONSTER_LIPSY
    dw MONSTER_STAGBUG
    dw MONSTER_PYURO
    dw MONSTER_DIGSTER

; list for entry $06 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults006::
    dw MONSTER_PIXY ; id 0
    dw MONSTER_MEDUSAEYE
    dw MONSTER_GREMLIN
    dw MONSTER_DEMONITE
    dw MONSTER_DARKEYE
    dw MONSTER_EYEBALL
    dw $ffff ; parent A's species
    dw MONSTER_SKULRIDER
    dw MONSTER_EVILBEAST
    dw MONSTER_BUBBLEMON
    dw MONSTER_ARCDEMON

; list for entry $07 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults007::
    dw MONSTER_SPOOKY ; id 0
    dw MONSTER_MADSPIRIT
    dw MONSTER_PUTREPUP
    dw MONSTER_ROTRAVEN
    dw MONSTER_MUMMY
    dw MONSTER_DARKCRAB
    dw MONSTER_DEADNITE
    dw $ffff ; parent A's species
    dw MONSTER_SHADOW
    dw MONSTER_SKULPENT
    dw MONSTER_WHITEKING

; list for entry $08 of FamilyPairResultTable; it runs to the next list (E-0199)
; record: child species for parent-B families 0-10
FamilyPairResults008::
    dw MONSTER_JEWELBAG ; id 0
    dw MONSTER_EVILWAND
    dw MONSTER_MADCANDLE
    dw MONSTER_COILBIRD
    dw MONSTER_FACER
    dw MONSTER_SPIKYBOY
    dw MONSTER_MADMIRROR
    dw MONSTER_ROGUENITE
    dw $ffff ; parent A's species
    dw MONSTER_BRUSHEAD
    dw MONSTER_BALZAK

; list for entry $09 of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults009::
    dw MONSTER_PETITEEL ; id 0
    dw MONSTER_MORAY
    dw MONSTER_WALRUSMAN
    dw MONSTER_RAYGIGAS
    dw MONSTER_ANEMON
    dw MONSTER_AQUARELLA
    dw MONSTER_MERMAN
    dw MONSTER_PUTREFISH
    dw MONSTER_OCTOKID
    dw $ffff ; parent A's species
    dw MONSTER_GRAKOS

; list for entry $0A of FamilyPairResultTable; it runs to the next list (E-0199)
FamilyPairResults00A::
    dw $ffff ; id 0 parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species
    dw $ffff ; parent A's species

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_ItsAccessoryIsIn::
    script_command SCRIPT_NPC_BREED
    script_message_by_screen $c003 ; screen 0: '*: Its accessory is in the'
Script_NpcBreed::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_ItsAccessoryIsIn_3, Script_ItsAccessoryIsIn_2
Script_ItsAccessoryIsIn_2::
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $8002 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_ItsAccessoryIsIn_3::
    script_message_by_screen $c005 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
Script_ChoiceJump_2::
    script_choice_jump Script_NpcBreed_2, Script_NpcBreed_3, Script_ItsAccessoryIsIn_4
Script_ItsAccessoryIsIn_4::
    script_message_by_screen $c004 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
    script_jump Script_NpcBreed
Script_NpcBreed_2::
    script_command SCRIPT_NPC_BREED
    script_jump Script_ChoiceJump_2
Script_NpcBreed_3::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_NpcBreed_4, Script_ItsAccessoryIsIn_6, Script_ItsAccessoryIsIn_5
Script_ItsAccessoryIsIn_5::
    script_message_by_screen $c006 ; screen 0: '*: Its accessory is in the'
    script_jump Script_ItsAccessoryIsIn_7
Script_ItsAccessoryIsIn_6::
    script_message_by_screen $c007 ; screen 0: '*: Its accessory is in the'
Script_ItsAccessoryIsIn_7::
    script_message_by_screen $c003 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
    script_jump Script_NpcBreed
Script_NpcBreed_4::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_ToNpcBreed_5, Script_IsItOKTo
Script_ToNpcBreed_5::
    script_jump Script_NpcBreed_5
Script_IsItOKTo::
    script_message_by_screen $c00c ; screen 0: '*: Is it OK to save'
Script_NpcBreed_5::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_ItsAccessoryIsIn_9, Script_ItsAccessoryIsIn_8
Script_ItsAccessoryIsIn_8::
    script_message_by_screen $c008 ; screen 0: '*: Its accessory is in the'
    script_jump Script_NpcBreed_6
Script_ItsAccessoryIsIn_9::
    script_message_by_screen $c00b ; screen 0: '*: Its accessory is in the'
Script_NpcBreed_6::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_ItsAccessoryIsIn_11, Script_ItsAccessoryIsIn_10
Script_ItsAccessoryIsIn_10::
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $8002 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_ItsAccessoryIsIn_11::
    script_command SCRIPT_NPC_BREED
    script_message_by_screen $c009 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $000a ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_MENU_CLOSE
    script_end
    ds $13, $00
