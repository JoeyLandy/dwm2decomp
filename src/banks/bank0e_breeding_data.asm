; ROM bank $0E: breeding tables: species pair rules and family results; message bank $0E
; The annotated listing of this bank is build/listing/bank0e.asm.

SECTION "Bank 0E", ROMX[$4000], BANK[$0E]
    db $0e

DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay_Sub01::
    ld a, [wStringIndex]
    cp $88
    jr c, .call_begin_string_display
    farcall DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank0E
    call BeginStringDisplay
    ret

; message bank $0E: when wStringIndex < $88, CopyStringToBuffer with this bank's table
; MessageStrings_Bank0E; otherwise far-calls CopyStringToBuffer_Bank0E_Overflow (E-0080)
CopyStringToBuffer_Bank0E::
    ld a, [wStringIndex]
    cp $88
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank0E_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank0E
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_0E_4032::
MessageStrings_Bank0E::
    dw StringList_0E_4034 ; id 0

; category list of StringCategories_0E_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_0E_4034::
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

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank0E::
    ld de, StringCategories_0E_5385
    call BeginStringDisplay
    ret
    db $11, $85, $53, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank0E (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank0E::
    call BeginStringDisplay_Bank0E
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_0E_5385::
    dw StringList_0E_5387 ; id 0

; category list of StringCategories_0E_5385; one pointer per wStringIndex (E-0217)
; record: string
StringList_0E_5387::
    dw String_0E_5385_00_00 ; id 0
    dw String_0E_5385_00_00 ; id 1
    dw String_0E_5385_00_02 ; id 2
    dw String_0E_5385_00_03 ; id 3
    dw String_0E_5385_00_04 ; id 4
    dw String_0E_5385_00_05 ; id 5
    dw String_0E_5385_00_06 ; id 6
    dw String_0E_5385_00_07 ; id 7
    dw String_0E_5385_00_08 ; id 8
    dw String_0E_5385_00_09 ; id 9
    dw String_0E_5385_00_0A ; id 10
    dw String_0E_5385_00_0B ; id 11
    dw String_0E_5385_00_0C ; id 12
    dw String_0E_5385_00_0D ; id 13
    dw String_0E_5385_00_0E ; id 14
    dw String_0E_5385_00_0F ; id 15
    dw String_0E_5385_00_10 ; id 16
    dw String_0E_5385_00_11 ; id 17
    dw String_0E_5385_00_12 ; id 18
    dw String_0E_5385_00_13 ; id 19
    dw String_0E_5385_00_14 ; id 20
    dw String_0E_5385_00_15 ; id 21
    dw String_0E_5385_00_16 ; id 22

String_0E_5385_00_00::
    db "Ready to start<LINE>"
    db "breeding.<PROMPT>"
    db "@"

String_0E_5385_00_02::
    db "You refused<LINE>"
    db "breeding.<PROMPT>"
    db "@"

String_0E_5385_00_03::
    db "Your pal refused<LINE>"
    db "breeding.<PROMPT>"
    db "@"

String_0E_5385_00_04::
    db "Is this one OK for<LINE>"
    db "breeding?@"

String_0E_5385_00_05::
    db "This one is too<LINE>"
    db "young to breed.<PROMPT>"
    db "<NEXT>It needs to be"
    db "<NEXT>leveled up more.<PROMPT>"
    db "@"

String_0E_5385_00_06::
    db "Choose from the<LINE>"
    db "farm's roster.<PROMPT>"
    db "@"

String_0E_5385_00_07::
    db "Please wait.@"

String_0E_5385_00_08::
    db "Identical genders<LINE>"
    db "can't breed.<PROMPT>"
    db "@"

String_0E_5385_00_09::
    db "Choose the monster<LINE>"
    db "for breeding.@"

String_0E_5385_00_0A::
    db "The couple is<LINE>"
    db "incompatible.<PROMPT>"
    db "@"

String_0E_5385_00_0B::
    db "Proceed with<LINE>"
    db "breeding?@"

String_0E_5385_00_0C::
    db "Is it OK to record<LINE>"
    db "the results?@"

String_0E_5385_00_0D::
    db "The monsters like<LINE>"
    db "each other.<PROMPT>"
    db "<NEXT>Breeding will be"
    db "<NEXT>started.@"

String_0E_5385_00_0E::
    db "InfoOK@"

String_0E_5385_00_0F::
    db "BredInfoExit@"

String_0E_5385_00_10::
    db "ATKDEFGLINWMextvlBas        + @"

String_0E_5385_00_11::
    db "Breeding went<LINE>"
    db "wrong somehow.<PROMPT>"
    db "<NEXT>Breeding will be"
    db "<NEXT>canceled.<WAIT>"
    db "@"

String_0E_5385_00_12::
    db "The Game Link<LINE>"
    db "failed.<PROMPT>"
    db "<NEXT>Breeding will be"
    db "<NEXT>canceled.<WAIT>"
    db "@"

String_0E_5385_00_13::
    db "You refused<LINE>"
    db "breeding.@"

String_0E_5385_00_14::
    db "Your pal refused<LINE>"
    db "breeding.@"

String_0E_5385_00_15::
    db "For breeding with<LINE>"
    db "Terry's monsters.<WAIT>"
    db "@"

String_0E_5385_00_16::
    db "<VOICE1>*: Accessories will<LINE>"
    db "be in the Vault.<WAIT>"
    db "@"

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
    call CopyFourNamesByWCADDBit4Table
    call CopyPlayerNameToWCADF
    call CopySixBytesByWCADDBit4Table
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
    call AdjustStatForWCA2AAndWCACF
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
    call RollChildResistancesToWCB43
    call BuildWCB0CCandidateList
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    ld a, $ff
    ld [wArg5], a
    ret

; when wRecordBufA + $A4 or wRecordBufB + $A4 is set and listed for stat C
; (AdjustStatForWCA2AAndWCACF_Data_5A6B), subtracts AdjustStatForWCA2AAndWCACF_Data_5A8E[value] from
; DE (unless it is at 999) (E-0130)
AdjustStatForWCA2AAndWCACF::
    ld a, [wRecordBufA + MON_ITEM]
    and a
    jr z, .check_record_buf_b2
    ld b, a
    push hl
    ld a, c
    add a
    ld hl, AdjustStatForWCA2AAndWCACF_Data_5A6B
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
    ld hl, AdjustStatForWCA2AAndWCACF_Data_5A8E
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
    ld de, AdjustStatForWCA2AAndWCACF_Data_5A6B
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
    ld de, AdjustStatForWCA2AAndWCACF_Data_5A8E
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

AdjustStatForWCA2AAndWCACF_Data_5A6B::
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry00
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry00
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry02
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry02
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry04
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry05
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry06
    dw AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry07

AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry00::
    db $01, $02, $ff

AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry02::
    db $03, $04, $ff

AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry04::
    db $05, $06, $ff

AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry05::
    db $07, $08, $14, $ff

AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry06::
    db $09, $0a, $ff

AdjustStatForWCA2AAndWCACF_Data_5A6B_Entry07::
    db $0b, $0c, $ff

AdjustStatForWCA2AAndWCACF_Data_5A8E::
    db $00, $1e, $50, $1e, $50, $0a, $32, $0a, $32, $0a, $32, $32, $64, $00, $00, $00
    db $00, $00, $00, $00, $05, $00

; fills wChildRecord + $34 with $FF, appends species bytes 8-10 of wChildRecord + $B, wRecordBufA +
; $B and wRecordBufB + $B and eight bytes each from wRecordBufA + $34 and wRecordBufB + $34 to
; wChildRecord + $3C, maps them through SkillLineBaseTable and compacts the list (E-0124)
BuildWCB0CCandidateList::
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
    call MapWCB0CEntriesThroughTable5B03
    call BuildWCB0CCandidateList_RemoveDuplicateSkills
    call CompactWCB0CRemovingFF
    call BuildWCB0CCandidateList_RemoveDuplicateSkills
    ret

; replaces each of the $19 bytes at wChildRecord + $3C (other than $FF) by SkillLineBaseTable[byte]
; (E-0124)
MapWCB0CEntriesThroughTable5B03::
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

; MapWCB0CEntriesThroughTable5B03 replaces each of the $19 skill bytes at wChildRecord + $3C (other
; than $FF) by the byte at $5B03 + skill; the values never exceed the index and repeat for runs of
; related skills (for example 1-3 map to 1, 4-6 to 4), so the table maps a skill to the first of its
; line; 176 entries, skills 0-$AF (E-0200, C1)
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

; moves the non-$FF bytes of the $19-byte list at wChildRecord + $3C to its front (E-0124)
CompactWCB0CRemovingFF::
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

; in the child's skill list (wChildRecord + MON_SKILL_LIST, 25 entries) turns zeros and repeated
; skills into $FF
BuildWCB0CCandidateList_RemoveDuplicateSkills::
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

; for each of the 30 SRAM records stores the 27 two-bit resistance levels of its species at record +
; $73 (E-0127)
RefreshRecordResistancesFromSpecies::
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
    call LoadWD01AByteArg4
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

; for each of the 27 resistances of species wChildRecord + $B: levels below 3 may rise by the parent
; rolls (RollWCB3DForCaseB_5D16 or 5D77); stores the result at wChildRecord + $73 (E-0127)
RollChildResistancesToWCB43::
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
    call LoadWD01AByteArg4
    ld a, [wArg5]
    cp $03
    jr nc, .restore
    pop bc
    push bc
    ld a, [wArg5]
    cp $02
    jr z, .call_sum_func5_dcd_of_wc9_f9_and_wca9_e
    ld b, $03
    call SumFunc5DCDOfWC9F9AndWCA9E
    ld a, b
    cp $ff
    jr z, .restore
    call RollWCB3DForCaseB_5D16
    jr .restore

.call_sum_func5_dcd_of_wc9_f9_and_wca9_e:
    ld b, $05
    call SumFunc5DCDOfWC9F9AndWCA9E
    ld a, b
    cp $ff
    jr z, .restore
    call RollWCB3DForCaseB_5D77

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

; when wChildRecord + $6D is set rolls RollWCB3DChanceOrIncArg5 with factor 1, 3 or 10 (then 3) for
; B = 3, 4, 5, or 5 after counting otherwise (E-0125)
RollWCB3DForCaseB_5D16::
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
    jr z, .call_roll_wcb3_d_chance_or_inc_arg52
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    ld a, $05

.call_roll_wcb3_d_chance_or_inc_arg5:
    call RollWCB3DChanceOrIncArg5

.loop:
    pop bc
    ret

.skip2:
    ld a, $01
    jr .call_roll_wcb3_d_chance_or_inc_arg5

.skip3:
    ld a, $03
    jr .call_roll_wcb3_d_chance_or_inc_arg5

.call_roll_wcb3_d_chance_or_inc_arg52:
    ld a, $0a
    call RollWCB3DChanceOrIncArg5
    cp $ff
    jr z, .loop
    jr .skip3

; chance = A * wChildRecord + $6D; if below 100 and a random value is below it, A = $FF; otherwise
; wArg5 += 1 and A = 0 (E-0124)
RollWCB3DChanceOrIncArg5::
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

; when wChildRecord + $6D is set: B = 5 rolls a random value against wChildRecord + $6D (A = $FF on
; success), other values roll factor 2 (E-0125)
RollWCB3DForCaseB_5D77::
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
    call RollWCB3DChanceOrIncArg5
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

; B = SumFunc5DCDOfWC9F9AndWCA9E_TestEntry(wRecordBufA + $73) +
; SumFunc5DCDOfWC9F9AndWCA9E_TestEntry(wRecordBufB + $73) when both are valid and the sum is at
; least B; otherwise B = $FF (E-0124)
SumFunc5DCDOfWC9F9AndWCA9E::
    ld hl, wRecordBufA + MON_RESISTANCES
    call SumFunc5DCDOfWC9F9AndWCA9E_TestEntry
    cp $ff
    jr z, .done
    ld e, a
    ld hl, wRecordBufB + MON_RESISTANCES
    call SumFunc5DCDOfWC9F9AndWCA9E_TestEntry
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

; for entry C: when it is 2 and the byte $31 later is 1-$1B and its table byte equals C, returns $FF
SumFunc5DCDOfWC9F9AndWCA9E_TestEntry::
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
    ld hl, SumFunc5DCDOfWC9F9AndWCA9E_TestEntry_Data
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

SumFunc5DCDOfWC9F9AndWCA9E_TestEntry_Data::
    db $00, $01, $02, $03, $04, $05, $06, $0e, $0f, $07, $10, $11, $12, $13, $14, $08
    db $09, $0a, $0b, $15, $16, $17, $18, $19, $1a, $0c, $0d

; wArg5 = the byte at wSpeciesRecord + $12 + wArg4 (E-0114)
LoadWD01AByteArg4::
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES
    ld a, [wArg4]
    add_a_to_hl
    ld a, [hl]
    ld [wArg5], a
    ret

; copies six bytes from the addresses in CopySixBytesByWCADDBit4Table_Data_5E61 (or 5E6D when bit 4
; of wChildRecord + $D is set) to the addresses in CopySixBytesByWCADDBit4Table_Data_5E79 (E-0125)
CopySixBytesByWCADDBit4Table::
    ld hl, wChildRecord + MON_FAMILY
    ld a, [hl]
    and $10
    and a
    jr nz, .skip
    ld de, CopySixBytesByWCADDBit4Table_Data_5E61
    jr .skip2

.skip:
    ld de, CopySixBytesByWCADDBit4Table_Data_5E6D

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
    ld hl, CopySixBytesByWCADDBit4Table_Data_5E79
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

CopySixBytesByWCADDBit4Table_Data_5E61::
    db $91, $c9, $92, $c9, $36, $ca, $37, $ca, $f3, $c9, $98, $ca

CopySixBytesByWCADDBit4Table_Data_5E6D::
    db $36, $ca, $37, $ca, $91, $c9, $92, $c9, $98, $ca, $f3, $c9

CopySixBytesByWCADDBit4Table_Data_5E79::
    db $ea, $ca, $eb, $ca, $ec, $ca, $ed, $ca, $68, $cb, $73, $cb

; copies the 10-byte player name wPlayerName to wChildRecord + $F (E-0122)
CopyPlayerNameToWCADF::
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

; copies four 10-byte names from the addresses in CopyFourNamesByWCADDBit4Table_Data_5ED0 (or 5ED8
; with bit 4 of wChildRecord + $D) to the addresses in CopyFourNamesByWCADDBit4Table_Data_5EE0
; (E-0125)
CopyFourNamesByWCADDBit4Table::
    ld hl, wChildRecord + MON_FAMILY
    ld a, [hl]
    and $10
    and a
    jr nz, .skip
    ld de, CopyFourNamesByWCADDBit4Table_Data_5ED0
    jr .skip2

.skip:
    ld de, CopyFourNamesByWCADDBit4Table_Data_5ED8

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
    ld hl, CopyFourNamesByWCADDBit4Table_Data_5EE0
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

CopyFourNamesByWCADDBit4Table_Data_5ED0::
    db $87, $c9, $2c, $ca, $95, $c9, $3a, $ca

CopyFourNamesByWCADDBit4Table_Data_5ED8::
    db $2c, $ca, $87, $c9, $3a, $ca, $95, $c9

CopyFourNamesByWCADDBit4Table_Data_5EE0::
    db $5e, $cb, $69, $cb, $ee, $ca, $f9, $ca

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

ApplyBreedingBonusToChildStats_Data::
    db $5b, $5d, $5f, $61, $63, $65, $67, $69

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

; for the record at HL returns 9 * grade(field $6F) + 3 * grade(field $72) + grade(field $70)
; (GradeHFFC6_Bank0E); compare CombinedPersonalityLevelIndex (E-0121)
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

; the same 13 bytes as GradeTemp0 (GradeTemp0)
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

; loads word field wArg5 of record A (LoadSRAMRecordWord) and falls into
; DrawSpeciesAndFamilyIconForTemp0 (E-0126)
LoadRecordWordFieldArg5AndShowIcon::
    ld a, c
    push af
    ld a, [wArg5]
    ld c, a
    pop af
    call LoadSRAMRecordWord

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
    dw BreedSpeciesRules001 ; id 1 DrakSlime
    dw BreedSpeciesRules002 ; id 2 SpotSlime
    dw BreedSpeciesRules000 ; id 3 WingSlime
    dw BreedSpeciesRules000 ; id 4 TreeSlime
    dw BreedSpeciesRules000 ; id 5 Snaily
    dw BreedSpeciesRules006 ; id 6 SlimeNite
    dw BreedSpeciesRules000 ; id 7 Babble
    dw BreedSpeciesRules000 ; id 8 BoxSlime
    dw BreedSpeciesRules000 ; id 9 PearlGel
    dw BreedSpeciesRules00A ; id 10 Slime
    dw BreedSpeciesRules00B ; id 11 Healer
    dw BreedSpeciesRules000 ; id 12 FangSlime
    dw BreedSpeciesRules00D ; id 13 RockSlime
    dw BreedSpeciesRules000 ; id 14 SlimeBorg
    dw BreedSpeciesRules000 ; id 15 Slabbit
    dw BreedSpeciesRules010 ; id 16 KingSlime
    dw BreedSpeciesRules011 ; id 17 Metaly
    dw BreedSpeciesRules012 ; id 18 Metabble
    dw BreedSpeciesRules013 ; id 19 SpotKing
    dw BreedSpeciesRules000 ; id 20 TropicGel
    dw BreedSpeciesRules015 ; id 21 MimeSlime
    dw BreedSpeciesRules000 ; id 22 HaloSlime
    dw BreedSpeciesRules017 ; id 23 MetalKing
    dw BreedSpeciesRules018 ; id 24 GoldSlime
    dw BreedSpeciesRules000 ; id 25 GranSlime
    dw BreedSpeciesRules01A ; id 26 WonderEgg
    dw BreedSpeciesRules000 ; id 27 Butch
    dw BreedSpeciesRules000 ; id 28 ?
    dw BreedSpeciesRules000 ; id 29 ?
    dw BreedSpeciesRules000 ; id 30 ?
    dw BreedSpeciesRules000 ; id 31 ?
    dw BreedSpeciesRules000 ; id 32 ?
    dw BreedSpeciesRules000 ; id 33 ?
    dw BreedSpeciesRules000 ; id 34 ?
    dw BreedSpeciesRules000 ; id 35 ?
    dw BreedSpeciesRules024 ; id 36 DragonKid
    dw BreedSpeciesRules000 ; id 37 Tortragon
    dw BreedSpeciesRules026 ; id 38 Pteranod
    dw BreedSpeciesRules027 ; id 39 Gasgon
    dw BreedSpeciesRules000 ; id 40 FairyDrak
    dw BreedSpeciesRules029 ; id 41 LizardMan
    dw BreedSpeciesRules000 ; id 42 Poisongon
    dw BreedSpeciesRules000 ; id 43 Swordgon
    dw BreedSpeciesRules000 ; id 44 Drygon
    dw BreedSpeciesRules02D ; id 45 Dragon
    dw BreedSpeciesRules000 ; id 46 MiniDrak
    dw BreedSpeciesRules02F ; id 47 MadDragon
    dw BreedSpeciesRules000 ; id 48 Rayburn
    dw BreedSpeciesRules000 ; id 49 Chamelgon
    dw BreedSpeciesRules000 ; id 50 LizardFly
    dw BreedSpeciesRules033 ; id 51 Andreal
    dw BreedSpeciesRules034 ; id 52 KingCobra
    dw BreedSpeciesRules035 ; id 53 Vampirus
    dw BreedSpeciesRules000 ; id 54 SnakeBat
    dw BreedSpeciesRules000 ; id 55 Spikerous
    dw BreedSpeciesRules038 ; id 56 GreatDrak
    dw BreedSpeciesRules039 ; id 57 Crestpent
    dw BreedSpeciesRules03A ; id 58 WingSnake
    dw BreedSpeciesRules000 ; id 59 Coatol
    dw BreedSpeciesRules000 ; id 60 Orochi
    dw BreedSpeciesRules03D ; id 61 BattleRex
    dw BreedSpeciesRules03E ; id 62 SkyDragon
    dw BreedSpeciesRules000 ; id 63 Serpentia
    dw BreedSpeciesRules040 ; id 64 Divinegon
    dw BreedSpeciesRules000 ; id 65 Orligon
    dw BreedSpeciesRules000 ; id 66 GigaDraco
    dw BreedSpeciesRules000 ; id 67 ?
    dw BreedSpeciesRules000 ; id 68 ?
    dw BreedSpeciesRules000 ; id 69 ?
    dw BreedSpeciesRules000 ; id 70 ?
    dw BreedSpeciesRules047 ; id 71 Tonguella
    dw BreedSpeciesRules048 ; id 72 Almiraj
    dw BreedSpeciesRules049 ; id 73 CatFly
    dw BreedSpeciesRules000 ; id 74 PillowRat
    dw BreedSpeciesRules000 ; id 75 Saccer
    dw BreedSpeciesRules04C ; id 76 GulpBeast
    dw BreedSpeciesRules000 ; id 77 Skullroo
    dw BreedSpeciesRules000 ; id 78 WindBeast
    dw BreedSpeciesRules000 ; id 79 Beavern
    dw BreedSpeciesRules000 ; id 80 Antbear
    dw BreedSpeciesRules051 ; id 81 SuperTen
    dw BreedSpeciesRules052 ; id 82 IronTurt
    dw BreedSpeciesRules000 ; id 83 Mommonja
    dw BreedSpeciesRules054 ; id 84 HammerMan
    dw BreedSpeciesRules055 ; id 85 Grizzly
    dw BreedSpeciesRules056 ; id 86 Yeti
    dw BreedSpeciesRules057 ; id 87 ArrowDog
    dw BreedSpeciesRules058 ; id 88 NoctoKing
    dw BreedSpeciesRules059 ; id 89 BeastNite
    dw BreedSpeciesRules05A ; id 90 MadGopher
    dw BreedSpeciesRules000 ; id 91 FairyRat
    dw BreedSpeciesRules05C ; id 92 Unicorn
    dw BreedSpeciesRules05D ; id 93 Goategon
    dw BreedSpeciesRules05E ; id 94 WildApe
    dw BreedSpeciesRules05F ; id 95 Trumpeter
    dw BreedSpeciesRules000 ; id 96 KingLeo
    dw BreedSpeciesRules061 ; id 97 DarkHorn
    dw BreedSpeciesRules062 ; id 98 MadCat
    dw BreedSpeciesRules000 ; id 99 BigEye
    dw BreedSpeciesRules000 ; id 100 Gorago
    dw BreedSpeciesRules065 ; id 101 CatMage
    dw BreedSpeciesRules066 ; id 102 Dumbira
    dw BreedSpeciesRules000 ; id 103 ?
    dw BreedSpeciesRules000 ; id 104 ?
    dw BreedSpeciesRules000 ; id 105 ?
    dw BreedSpeciesRules000 ; id 106 Picky
    dw BreedSpeciesRules000 ; id 107 Wyvern
    dw BreedSpeciesRules06C ; id 108 BullBird
    dw BreedSpeciesRules000 ; id 109 Florajay
    dw BreedSpeciesRules000 ; id 110 DuckKite
    dw BreedSpeciesRules06F ; id 111 MadPecker
    dw BreedSpeciesRules000 ; id 112 MadRaven
    dw BreedSpeciesRules000 ; id 113 MistyWing
    dw BreedSpeciesRules072 ; id 114 AquaHawk
    dw BreedSpeciesRules000 ; id 115 Dracky
    dw BreedSpeciesRules074 ; id 116 KiteHawk
    dw BreedSpeciesRules000 ; id 117 BigRoost
    dw BreedSpeciesRules000 ; id 118 StubBird
    dw BreedSpeciesRules077 ; id 119 LandOwl
    dw BreedSpeciesRules078 ; id 120 MadGoose
    dw BreedSpeciesRules079 ; id 121 MadCondor
    dw BreedSpeciesRules000 ; id 122 Emyu
    dw BreedSpeciesRules07B ; id 123 Blizzardy
    dw BreedSpeciesRules07C ; id 124 Phoenix
    dw BreedSpeciesRules07D ; id 125 ZapBird
    dw BreedSpeciesRules07E ; id 126 Garudian
    dw BreedSpeciesRules07F ; id 127 WhipBird
    dw BreedSpeciesRules080 ; id 128 FunkyBird
    dw BreedSpeciesRules081 ; id 129 RainHawk
    dw BreedSpeciesRules000 ; id 130 Azurile
    dw BreedSpeciesRules083 ; id 131 Shantak
    dw BreedSpeciesRules084 ; id 132 CragDevil
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
    dw BreedSpeciesRules096 ; id 150 Stubsuck
    dw BreedSpeciesRules000 ; id 151 Oniono
    dw BreedSpeciesRules000 ; id 152 DanceVegi
    dw BreedSpeciesRules099 ; id 153 TreeBoy
    dw BreedSpeciesRules000 ; id 154 Devipine
    dw BreedSpeciesRules000 ; id 155 FaceTree
    dw BreedSpeciesRules000 ; id 156 HerbMan
    dw BreedSpeciesRules000 ; id 157 BeanMan
    dw BreedSpeciesRules09E ; id 158 EvilSeed
    dw BreedSpeciesRules09F ; id 159 ManEater
    dw BreedSpeciesRules000 ; id 160 Snapper
    dw BreedSpeciesRules0A1 ; id 161 GhosTree
    dw BreedSpeciesRules0A2 ; id 162 Rosevine
    dw BreedSpeciesRules000 ; id 163 Egdracil
    dw BreedSpeciesRules0A4 ; id 164 Warubou
    dw BreedSpeciesRules000 ; id 165 Watabou
    dw BreedSpeciesRules000 ; id 166 Eggplaton
    dw BreedSpeciesRules0A7 ; id 167 FooHero
    dw BreedSpeciesRules000 ; id 168 ?
    dw BreedSpeciesRules000 ; id 169 ?
    dw BreedSpeciesRules000 ; id 170 ?
    dw BreedSpeciesRules000 ; id 171 ?
    dw BreedSpeciesRules000 ; id 172 ?
    dw BreedSpeciesRules000 ; id 173 ?
    dw BreedSpeciesRules000 ; id 174 ?
    dw BreedSpeciesRules000 ; id 175 ?
    dw BreedSpeciesRules000 ; id 176 GiantSlug
    dw BreedSpeciesRules0B1 ; id 177 Catapila
    dw BreedSpeciesRules000 ; id 178 Gophecada
    dw BreedSpeciesRules0B3 ; id 179 Butterfly
    dw BreedSpeciesRules0B4 ; id 180 WeedBug
    dw BreedSpeciesRules000 ; id 181 GiantWorm
    dw BreedSpeciesRules0B6 ; id 182 Lipsy
    dw BreedSpeciesRules0B7 ; id 183 StagBug
    dw BreedSpeciesRules000 ; id 184 Pyuro
    dw BreedSpeciesRules000 ; id 185 ArmyAnt
    dw BreedSpeciesRules000 ; id 186 GoHopper
    dw BreedSpeciesRules0BB ; id 187 TailEater
    dw BreedSpeciesRules000 ; id 188 ArmorPede
    dw BreedSpeciesRules0BD ; id 189 Eyeder
    dw BreedSpeciesRules000 ; id 190 GiantMoth
    dw BreedSpeciesRules000 ; id 191 Droll
    dw BreedSpeciesRules0C0 ; id 192 ArmyCrab
    dw BreedSpeciesRules0C1 ; id 193 MadHornet
    dw BreedSpeciesRules000 ; id 194 Belzebub
    dw BreedSpeciesRules0C3 ; id 195 WarMantis
    dw BreedSpeciesRules0C4 ; id 196 HornBeet
    dw BreedSpeciesRules000 ; id 197 Sickler
    dw BreedSpeciesRules0C6 ; id 198 Armorpion
    dw BreedSpeciesRules000 ; id 199 Digster
    dw BreedSpeciesRules000 ; id 200 Skularach
    dw BreedSpeciesRules0C9 ; id 201 MultiEyes
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
    dw BreedSpeciesRules0D5 ; id 213 AgDevil
    dw BreedSpeciesRules0D6 ; id 214 Demonite
    dw BreedSpeciesRules0D7 ; id 215 DarkEye
    dw BreedSpeciesRules000 ; id 216 EyeBall
    dw BreedSpeciesRules000 ; id 217 SkulRider
    dw BreedSpeciesRules000 ; id 218 EvilBeast
    dw BreedSpeciesRules0DB ; id 219 Bubblemon
    dw BreedSpeciesRules0DC ; id 220 1EyeClown
    dw BreedSpeciesRules0DD ; id 221 Gremlin
    dw BreedSpeciesRules0DE ; id 222 ArcDemon
    dw BreedSpeciesRules0DF ; id 223 Lionex
    dw BreedSpeciesRules000 ; id 224 GoatHorn
    dw BreedSpeciesRules000 ; id 225 Orc
    dw BreedSpeciesRules0E2 ; id 226 Ogre
    dw BreedSpeciesRules000 ; id 227 GateGuard
    dw BreedSpeciesRules000 ; id 228 ChopClown
    dw BreedSpeciesRules0E5 ; id 229 BossTroll
    dw BreedSpeciesRules0E6 ; id 230 Grendal
    dw BreedSpeciesRules0E7 ; id 231 Akubar
    dw BreedSpeciesRules000 ; id 232 MadKnight
    dw BreedSpeciesRules000 ; id 233 EvilWell
    dw BreedSpeciesRules0EA ; id 234 Gigantes
    dw BreedSpeciesRules0EB ; id 235 Centasaur
    dw BreedSpeciesRules000 ; id 236 EvilArmor
    dw BreedSpeciesRules0ED ; id 237 Jamirus
    dw BreedSpeciesRules0EE ; id 238 Durran
    dw BreedSpeciesRules000 ; id 239 Titanis
    dw BreedSpeciesRules0F0 ; id 240 LampGenie
    dw BreedSpeciesRules000 ; id 241 ?
    dw BreedSpeciesRules000 ; id 242 ?
    dw BreedSpeciesRules000 ; id 243 ?
    dw BreedSpeciesRules000 ; id 244 ?
    dw BreedSpeciesRules000 ; id 245 ?
    dw BreedSpeciesRules000 ; id 246 Spooky
    dw BreedSpeciesRules0F7 ; id 247 Skullgon
    dw BreedSpeciesRules0F8 ; id 248 PutrePup
    dw BreedSpeciesRules000 ; id 249 RotRaven
    dw BreedSpeciesRules0FA ; id 250 Mummy
    dw BreedSpeciesRules000 ; id 251 DarkCrab
    dw BreedSpeciesRules0FC ; id 252 DeadNite
    dw BreedSpeciesRules000 ; id 253 Shadow
    dw BreedSpeciesRules000 ; id 254 Skulpent
    dw BreedSpeciesRules0FF ; id 255 Hork
    dw BreedSpeciesRules100 ; id 256 Mudron
    dw BreedSpeciesRules101 ; id 257 NiteWhip
    dw BreedSpeciesRules000 ; id 258 WindMerge
    dw BreedSpeciesRules000 ; id 259 Reaper
    dw BreedSpeciesRules000 ; id 260 Inverzon
    dw BreedSpeciesRules000 ; id 261 FoxFire
    dw BreedSpeciesRules106 ; id 262 CaptDead
    dw BreedSpeciesRules107 ; id 263 DeadNoble
    dw BreedSpeciesRules108 ; id 264 WhiteKing
    dw BreedSpeciesRules109 ; id 265 BoneSlave
    dw BreedSpeciesRules10A ; id 266 Skeletor
    dw BreedSpeciesRules10B ; id 267 Servant
    dw BreedSpeciesRules000 ; id 268 Lazamanus
    dw BreedSpeciesRules10D ; id 269 Copycat
    dw BreedSpeciesRules10E ; id 270 MadSpirit
    dw BreedSpeciesRules000 ; id 271 PomPomBom
    dw BreedSpeciesRules110 ; id 272 Niterich
    dw BreedSpeciesRules000 ; id 273 ?
    dw BreedSpeciesRules000 ; id 274 ?
    dw BreedSpeciesRules000 ; id 275 ?
    dw BreedSpeciesRules000 ; id 276 ?
    dw BreedSpeciesRules000 ; id 277 ?
    dw BreedSpeciesRules000 ; id 278 ?
    dw BreedSpeciesRules000 ; id 279 ?
    dw BreedSpeciesRules000 ; id 280 ?
    dw BreedSpeciesRules000 ; id 281 JewelBag
    dw BreedSpeciesRules11A ; id 282 EvilWand
    dw BreedSpeciesRules11B ; id 283 MadCandle
    dw BreedSpeciesRules000 ; id 284 CoilBird
    dw BreedSpeciesRules000 ; id 285 Facer
    dw BreedSpeciesRules11E ; id 286 SpikyBoy
    dw BreedSpeciesRules11F ; id 287 MadMirror
    dw BreedSpeciesRules000 ; id 288 RogueNite
    dw BreedSpeciesRules121 ; id 289 Puppetor
    dw BreedSpeciesRules122 ; id 290 Goopi
    dw BreedSpeciesRules123 ; id 291 Voodoll
    dw BreedSpeciesRules124 ; id 292 MetalDrak
    dw BreedSpeciesRules000 ; id 293 Balzak
    dw BreedSpeciesRules126 ; id 294 SabreMan
    dw BreedSpeciesRules127 ; id 295 CurseLamp
    dw BreedSpeciesRules000 ; id 296 Brushead
    dw BreedSpeciesRules129 ; id 297 Roboster
    dw BreedSpeciesRules12A ; id 298 Roboster2
    dw BreedSpeciesRules12B ; id 299 EvilPot
    dw BreedSpeciesRules12C ; id 300 Gismo
    dw BreedSpeciesRules12D ; id 301 LavaMan
    dw BreedSpeciesRules12E ; id 302 IceMan
    dw BreedSpeciesRules12F ; id 303 Mimic
    dw BreedSpeciesRules000 ; id 304 Exaucers
    dw BreedSpeciesRules131 ; id 305 MudDoll
    dw BreedSpeciesRules132 ; id 306 Golem
    dw BreedSpeciesRules133 ; id 307 StoneMan
    dw BreedSpeciesRules000 ; id 308 BombCrag
    dw BreedSpeciesRules135 ; id 309 GoldGolem
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
    dw BreedSpeciesRules141 ; id 321 Aquarella
    dw BreedSpeciesRules142 ; id 322 Merman
    dw BreedSpeciesRules000 ; id 323 Octokid
    dw BreedSpeciesRules000 ; id 324 PutreFish
    dw BreedSpeciesRules145 ; id 325 Octoreach
    dw BreedSpeciesRules146 ; id 326 Angleron
    dw BreedSpeciesRules000 ; id 327 FishRider
    dw BreedSpeciesRules148 ; id 328 RushFish
    dw BreedSpeciesRules149 ; id 329 Gamanian
    dw BreedSpeciesRules14A ; id 330 Clawster
    dw BreedSpeciesRules14B ; id 331 CancerMan
    dw BreedSpeciesRules14C ; id 332 RogueWave
    dw BreedSpeciesRules000 ; id 333 Scallopa
    dw BreedSpeciesRules000 ; id 334 SeaHorse
    dw BreedSpeciesRules14F ; id 335 HoodSquid
    dw BreedSpeciesRules150 ; id 336 MerTiger
    dw BreedSpeciesRules000 ; id 337 AxeShark
    dw BreedSpeciesRules152 ; id 338 Octogon
    dw BreedSpeciesRules000 ; id 339 KingSquid
    dw BreedSpeciesRules154 ; id 340 Digong
    dw BreedSpeciesRules000 ; id 341 WhaleMage
    dw BreedSpeciesRules000 ; id 342 Aquadon
    dw BreedSpeciesRules000 ; id 343 Octoraid
    dw BreedSpeciesRules158 ; id 344 Grakos
    dw BreedSpeciesRules000 ; id 345 Poseidon
    dw BreedSpeciesRules000 ; id 346 Pumpoise
    dw BreedSpeciesRules000 ; id 347 Starfish
    dw BreedSpeciesRules000 ; id 348 ?
    dw BreedSpeciesRules000 ; id 349 ?
    dw BreedSpeciesRules000 ; id 350 ?
    dw BreedSpeciesRules15F ; id 351 DracoLord
    dw BreedSpeciesRules160 ; id 352 DracoLord
    dw BreedSpeciesRules000 ; id 353 LordDraco
    dw BreedSpeciesRules162 ; id 354 Hargon
    dw BreedSpeciesRules163 ; id 355 Sidoh
    dw BreedSpeciesRules000 ; id 356 Genosidoh
    dw BreedSpeciesRules165 ; id 357 Baramos
    dw BreedSpeciesRules166 ; id 358 Zoma
    dw BreedSpeciesRules000 ; id 359 AsuraZoma
    dw BreedSpeciesRules168 ; id 360 Pizzaro
    dw BreedSpeciesRules169 ; id 361 PsychoPiz
    dw BreedSpeciesRules16A ; id 362 Esterk
    dw BreedSpeciesRules16B ; id 363 Mirudraas
    dw BreedSpeciesRules16C ; id 364 Mirudraas
    dw BreedSpeciesRules000 ; id 365 Mudou
    dw BreedSpeciesRules16E ; id 366 DeathMore
    dw BreedSpeciesRules16F ; id 367 DeathMore
    dw BreedSpeciesRules170 ; id 368 DeathMore
    dw BreedSpeciesRules000 ; id 369 Darkdrium
    dw BreedSpeciesRules172 ; id 370 Orgodemir
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
BreedSpeciesRules001::
    dw MONSTER_SWORDGON ; id 0
    dw $ffff ; id 1 end of list

; list for entry $02 (SpotSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules002::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $ffff ; id 2 end of list

; list for entry $06 (SlimeNite) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules006::
    dw MONSTER_SPIKEROUS ; id 0
    dw $ffff ; id 1 end of list

; list for entry $0A (Slime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules00A::
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
BreedSpeciesRules00B::
    dw MONSTER_TREEBOY ; id 0
    dw MONSTER_1EYECLOWN ; id 1
    dw MONSTER_EVILWAND ; id 2
    dw $ffff ; id 3 end of list

; list for entry $0D (RockSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules00D::
    dw MONSTER_GREATDRAK ; id 0
    dw $ffff ; id 1 end of list

; list for entry $10 (KingSlime) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules010::
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
BreedSpeciesRules011::
    dw MONSTER_METALY ; id 0
    dw MONSTER_WONDEREGG ; id 1
    dw $ffff ; id 2 end of list

; list for entry $12 (Metabble) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules012::
    dw MONSTER_BATTLEREX ; id 0
    dw MONSTER_SKYDRAGON ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_METABBLE ; id 3
    dw $ffff ; id 4 end of list

; list for entry $13 (SpotKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules013::
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
BreedSpeciesRules015::
    dw MONSTER_STUBBIRD ; id 0
    dw MONSTER_PIXY ; id 1
    dw $ffff ; id 2 end of list

; list for entry $17 (MetalKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules017::
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
BreedSpeciesRules018::
    dw MONSTER_GOLDSLIME ; id 0
    dw MONSTER_DARKMATE ; id 1
    dw MONSTER_DEATHMORE ; id 2
    dw $ffff ; id 3 end of list

; list for entry $1A (WonderEgg) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules01A::
    dw MONSTER_METABBLE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_METALKING ; id 2
    dw $fdfd ; id 3 next result
    dw MONSTER_GOLDSLIME ; id 4
    dw $ffff ; id 5 end of list

; list for entry $24 (DragonKid) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules024::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $fdfd ; id 2 next result
    dw MONSTER_DRAGONKID ; id 3
    dw $ffff ; id 4 end of list

; list for entry $26 (Pteranod) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules026::
    dw MONSTER_PTERANOD ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_DARKHORN ; id 2
    dw MONSTER_MADKNIGHT ; id 3
    dw MONSTER_COPYCAT ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw MONSTER_WHIPBIRD ; id 6
    dw $ffff ; id 7 end of list

; list for entry $27 (Gasgon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules027::
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
BreedSpeciesRules029::
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
BreedSpeciesRules02D::
    dw $fe04 ; id 0 same species, parent B +4 or more
    dw $fc04 ; id 1 same species, parent A +4 or more
    dw $fbfb ; id 2 next result when wArg1 = 2, else end of list
    dw MONSTER_AQUAHAWK ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_LIONEX ; id 5
    dw $ffff ; id 6 end of list

; list for entry $2F (MadDragon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules02F::
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
BreedSpeciesRules033::
    dw MONSTER_MEDUSAEYE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_BOSSTROLL ; id 2
    dw MONSTER_GIGANTES ; id 3
    dw $ffff ; id 4 end of list

; list for entry $34 (KingCobra) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules034::
    dw MONSTER_DRACKY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $35 (Vampirus) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules035::
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
BreedSpeciesRules038::
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
BreedSpeciesRules039::
    dw MONSTER_CRESTPENT ; id 0
    dw $ffff ; id 1 end of list

; list for entry $3A (WingSnake) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules03A::
    dw MONSTER_WINGSNAKE ; id 0
    dw $ffff ; id 1 end of list

; list for entry $3D (BattleRex) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules03D::
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
BreedSpeciesRules03E::
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
BreedSpeciesRules040::
    dw MONSTER_GOLDGOLEM ; id 0
    dw MONSTER_GIGADRACO ; id 1
    dw $ffff ; id 2 end of list

; list for entry $47 (Tonguella) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules047::
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
BreedSpeciesRules048::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_HEALER ; id 1
    dw $ffff ; id 2 end of list

; list for entry $49 (CatFly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules049::
    dw MONSTER_MIMESLIME ; id 0
    dw MONSTER_CATMAGE ; id 1
    dw MONSTER_TREEBOY ; id 2
    dw MONSTER_SICKLER ; id 3
    dw MONSTER_1EYECLOWN ; id 4
    dw MONSTER_REAPER ; id 5
    dw MONSTER_EVILWAND ; id 6
    dw $ffff ; id 7 end of list

; list for entry $4C (GulpBeast) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules04C::
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
BreedSpeciesRules051::
    dw MONSTER_LIZARDMAN ; id 0
    dw MONSTER_BEASTNITE ; id 1
    dw MONSTER_BUBBLEMON ; id 2
    dw MONSTER_ORC ; id 3
    dw MONSTER_SABREMAN ; id 4
    dw MONSTER_WALRUSMAN ; id 5
    dw MONSTER_MERTIGER ; id 6
    dw $ffff ; id 7 end of list

; list for entry $52 (IronTurt) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules052::
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
BreedSpeciesRules054::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_LIZARDMAN ; id 1
    dw $ffff ; id 2 end of list

; list for entry $55 (Grizzly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules055::
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
BreedSpeciesRules056::
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
BreedSpeciesRules057::
    dw MONSTER_DRACKY ; id 0
    dw MONSTER_SHADOW ; id 1
    dw $fdfd ; id 2 next result
    dw $fe04 ; id 3 same species, parent B +4 or more
    dw $fc04 ; id 4 same species, parent A +4 or more
    dw $ffff ; id 5 end of list

; list for entry $58 (NoctoKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules058::
    dw MONSTER_GIGANTES ; id 0
    dw $ffff ; id 1 end of list

; list for entry $59 (BeastNite) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules059::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_MERTIGER ; id 1
    dw $ffff ; id 2 end of list

; list for entry $5A (MadGopher) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules05A::
    dw MONSTER_DUMBIRA ; id 0
    dw $ffff ; id 1 end of list

; list for entry $5C (Unicorn) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules05C::
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
BreedSpeciesRules05D::
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
BreedSpeciesRules05E::
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
BreedSpeciesRules05F::
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
BreedSpeciesRules061::
    dw MONSTER_OROCHI ; id 0
    dw $ffff ; id 1 end of list

; list for entry $62 (MadCat) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules062::
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
BreedSpeciesRules065::
    dw MONSTER_UNICORN ; id 0
    dw MONSTER_GOATEGON ; id 1
    dw $ffff ; id 2 end of list

; list for entry $66 (Dumbira) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules066::
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
BreedSpeciesRules06C::
    dw MONSTER_GRIZZLY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $6F (MadPecker) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules06F::
    dw MONSTER_BIGEYE ; id 0
    dw MONSTER_DARKEYE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $72 (AquaHawk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules072::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_WINGSNAKE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $74 (KiteHawk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules074::
    dw MONSTER_BIGROOST ; id 0
    dw $ffff ; id 1 end of list

; list for entry $77 (LandOwl) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules077::
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
BreedSpeciesRules078::
    dw MONSTER_ROCKSLIME ; id 0
    dw MONSTER_SLIMEBORG ; id 1
    dw MONSTER_DIGSTER ; id 2
    dw MONSTER_METALDRAK ; id 3
    dw MONSTER_GOLEM ; id 4
    dw MONSTER_STONEMAN ; id 5
    dw MONSTER_MERMAN ; id 6
    dw $ffff ; id 7 end of list

; list for entry $79 (MadCondor) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules079::
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
BreedSpeciesRules07B::
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
BreedSpeciesRules07C::
    dw MONSTER_GISMO ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_LIONEX ; id 2
    dw $ffff ; id 3 end of list

; list for entry $7D (ZapBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules07D::
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
BreedSpeciesRules07E::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_TRUMPETER ; id 1
    dw $ffff ; id 2 end of list

; list for entry $7F (WhipBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules07F::
    dw MONSTER_GISMO ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GREATDRAK ; id 2
    dw MONSTER_JAMIRUS ; id 3
    dw $ffff ; id 4 end of list

; list for entry $80 (FunkyBird) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules080::
    dw MONSTER_JAMIRUS ; id 0
    dw $ffff ; id 1 end of list

; list for entry $81 (RainHawk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules081::
    dw MONSTER_GOLDGOLEM ; id 0
    dw $ffff ; id 1 end of list

; list for entry $83 (Shantak) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules083::
    dw MONSTER_GOLDGOLEM ; id 0
    dw $ffff ; id 1 end of list

; list for entry $84 (CragDevil) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules084::
    dw MONSTER_DUCKKITE ; id 0
    dw MONSTER_MADRAVEN ; id 1
    dw $fdfd ; id 2 next result
    dw $fe04 ; id 3 same species, parent B +4 or more
    dw $fc04 ; id 4 same species, parent A +4 or more
    dw $ffff ; id 5 end of list

; list for entry $96 (Stubsuck) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules096::
    dw MONSTER_PUPPETOR ; id 0
    dw $ffff ; id 1 end of list

; list for entry $99 (TreeBoy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules099::
    dw MONSTER_SLIMENITE ; id 0
    dw MONSTER_HAMMERMAN ; id 1
    dw MONSTER_BEASTNITE ; id 2
    dw $ffff ; id 3 end of list

; list for entry $9E (EvilSeed) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules09E::
    dw MONSTER_SLURPERON ; id 0
    dw MONSTER_EVILSEED ; id 1
    dw $ffff ; id 2 end of list

; list for entry $9F (ManEater) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules09F::
    dw MONSTER_MANEATER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $A1 (GhosTree) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0A1::
    dw MONSTER_GHOSTREE ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SNAPPER ; id 2
    dw $ffff ; id 3 end of list

; list for entry $A2 (Rosevine) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0A2::
    dw MONSTER_GIGANTES ; id 0
    dw $ffff ; id 1 end of list

; list for entry $A4 (Warubou) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0A4::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_WATABOU ; id 1
    dw $ffff ; id 2 end of list

; list for entry $A7 (FooHero) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0A7::
    dw MONSTER_EVILWAND ; id 0
    dw $ffff ; id 1 end of list

; list for entry $B1 (Catapila) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0B1::
    dw MONSTER_CATAPILA ; id 0

; list for entry $B3 (Butterfly) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0B3::
    dw MONSTER_BUTTERFLY ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_PYURO ; id 2
    dw $ffff ; id 3 end of list

; list for entry $B4 (WeedBug) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0B4::
    dw MONSTER_ANEMON ; id 0
    dw $ffff ; id 1 end of list

; list for entry $B6 (Lipsy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0B6::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOKID ; id 1
    dw MONSTER_ANGLERON ; id 2
    dw $ffff ; id 3 end of list

; list for entry $B7 (StagBug) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0B7::
    dw MONSTER_STAGBUG ; id 0
    dw $ffff ; id 1 end of list

; list for entry $BB (TailEater) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0BB::
    dw MONSTER_TAILEATER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $BD (Eyeder) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0BD::
    dw MONSTER_EYEDER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C0 (ArmyCrab) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0C0::
    dw MONSTER_CLAWSTER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C1 (MadHornet) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0C1::
    dw MONSTER_GOHOPPER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C3 (WarMantis) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0C3::
    dw MONSTER_ROGUENITE ; id 0
    dw MONSTER_CANCERMAN ; id 1
    dw MONSTER_OCTORAID ; id 2
    dw $ffff ; id 3 end of list

; list for entry $C4 (HornBeet) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0C4::
    dw MONSTER_HORNBEET ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C6 (Armorpion) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0C6::
    dw MONSTER_WHITEKING ; id 0
    dw $ffff ; id 1 end of list

; list for entry $C9 (MultiEyes) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0C9::
    dw MONSTER_BUTTERFLY ; id 0
    dw MONSTER_PYURO ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_ROCKSLIME ; id 3
    dw MONSTER_TORTRAGON ; id 4
    dw MONSTER_IRONTURT ; id 5
    dw $ffff ; id 6 end of list

; list for entry $D5 (AgDevil) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0D5::
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
BreedSpeciesRules0D6::
    dw MONSTER_DEMONITE ; id 0
    dw $ffff ; id 1 end of list

; list for entry $D7 (DarkEye) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0D7::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOREACH ; id 1
    dw $ffff ; id 2 end of list

; list for entry $DB (Bubblemon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0DB::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_DEADNITE ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_EVILPOT ; id 3
    dw $ffff ; id 4 end of list

; list for entry $DC (1EyeClown) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0DC::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOREACH ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_1EYECLOWN ; id 3
    dw $ffff ; id 4 end of list

; list for entry $DD (Gremlin) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0DD::
    dw MONSTER_AQUARELLA ; id 0
    dw MONSTER_OCTOREACH ; id 1
    dw $ffff ; id 2 end of list

; list for entry $DE (ArcDemon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0DE::
    dw MONSTER_GARUDIAN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_GATEGUARD ; id 2
    dw $ffff ; id 3 end of list

; list for entry $DF (Lionex) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0DF::
    dw MONSTER_MIMESLIME ; id 0
    dw $ffff ; id 1 end of list

; list for entry $E2 (Ogre) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0E2::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BALZAK ; id 1
    dw MONSTER_STONEMAN ; id 2
    dw MONSTER_WALRUSMAN ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_LAVAMAN ; id 5
    dw $ffff ; id 6 end of list

; list for entry $E5 (BossTroll) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0E5::
    dw MONSTER_ICEMAN ; id 0
    dw $fbfb ; id 1 next result when wArg1 = 2, else end of list
    dw MONSTER_CURSELAMP ; id 2
    dw $ffff ; id 3 end of list

; list for entry $E6 (Grendal) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0E6::
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
BreedSpeciesRules0E7::
    dw MONSTER_RAINHAWK ; id 0
    dw $ffff ; id 1 end of list

; list for entry $EA (Gigantes) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0EA::
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
BreedSpeciesRules0EB::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BALZAK ; id 1
    dw MONSTER_STONEMAN ; id 2
    dw MONSTER_WALRUSMAN ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_GOLDGOLEM ; id 5
    dw $ffff ; id 6 end of list

; list for entry $ED (Jamirus) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0ED::
    dw MONSTER_SERPENTIA ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_ROSEVINE ; id 2
    dw $ffff ; id 3 end of list

; list for entry $EE (Durran) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0EE::
    dw MONSTER_DARKHORN ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_DIVINEGON ; id 2
    dw $ffff ; id 3 end of list

; list for entry $F0 (LampGenie) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules0F0::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_MADCAT ; id 1
    dw $ffff ; id 2 end of list

; list for entry $F7 (Skullgon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0F7::
    dw MONSTER_COPYCAT ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_KINGSLIME ; id 2
    dw $ffff ; id 3 end of list

; list for entry $F8 (PutrePup) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0F8::
    dw MONSTER_MISTYWING ; id 0
    dw $ffff ; id 1 end of list

; list for entry $FA (Mummy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules0FA::
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
BreedSpeciesRules0FC::
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
BreedSpeciesRules0FF::
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
BreedSpeciesRules100::
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
BreedSpeciesRules101::
    dw MONSTER_MORAY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $106 (CaptDead) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules106::
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
BreedSpeciesRules107::
    dw MONSTER_SPOTKING ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SERPENTIA ; id 2
    dw MONSTER_ROBOSTER2 ; id 3
    dw MONSTER_OCTORAID ; id 4
    dw $ffff ; id 5 end of list

; list for entry $108 (WhiteKing) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules108::
    dw MONSTER_DRACOLORD ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_METALKING ; id 2
    dw $ffff ; id 3 end of list

; list for entry $109 (BoneSlave) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules109::
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
BreedSpeciesRules10A::
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
BreedSpeciesRules10B::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_GREATDRAK ; id 1
    dw $ffff ; id 2 end of list

; list for entry $10D (Copycat) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules10D::
    dw MONSTER_GASGON ; id 0
    dw MONSTER_DROLL ; id 1
    dw $ffff ; id 2 end of list

; list for entry $10E (MadSpirit) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules10E::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_LIONEX ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_METALDRAK ; id 3
    dw MONSTER_ROBOSTER ; id 4
    dw MONSTER_ROBOSTER2 ; id 5
    dw $ffff ; id 6 end of list

; list for entry $110 (Niterich) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules110::
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
BreedSpeciesRules11A::
    dw MONSTER_LANDOWL ; id 0
    dw MONSTER_MADGOOSE ; id 1
    dw MONSTER_PHOENIX ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw $ffff ; id 4 end of list

; list for entry $11B (MadCandle) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules11B::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WYVERN ; id 1
    dw MONSTER_MISTYWING ; id 2
    dw MONSTER_FIREWEED ; id 3
    dw MONSTER_EVILSEED ; id 4
    dw MONSTER_ANEMON ; id 5
    dw $ffff ; id 6 end of list

; list for entry $11E (SpikyBoy) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules11E::
    dw MONSTER_SPIKYBOY ; id 0
    dw $ffff ; id 1 end of list

; list for entry $11F (MadMirror) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules11F::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WYVERN ; id 1
    dw MONSTER_MISTYWING ; id 2
    dw MONSTER_FIREWEED ; id 3
    dw MONSTER_EVILSEED ; id 4
    dw MONSTER_ANEMON ; id 5
    dw $ffff ; id 6 end of list

; list for entry $121 (Puppetor) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules121::
    dw MONSTER_PIXY ; id 0
    dw MONSTER_DEMONITE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $122 (Goopi) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules122::
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
BreedSpeciesRules123::
    dw MONSTER_LANDOWL ; id 0
    dw MONSTER_MADGOOSE ; id 1
    dw MONSTER_PHOENIX ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw $ffff ; id 4 end of list

; list for entry $124 (MetalDrak) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules124::
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
BreedSpeciesRules126::
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
BreedSpeciesRules127::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_BOSSTROLL ; id 1
    dw $ffff ; id 2 end of list

; list for entry $129 (Roboster) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules129::
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
BreedSpeciesRules12A::
    dw MONSTER_METALDRAK ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_KINGLEO ; id 2
    dw $ffff ; id 3 end of list

; list for entry $12B (EvilPot) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules12B::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_BUBBLEMON ; id 1
    dw $ffff ; id 2 end of list

; list for entry $12C (Gismo) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules12C::
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
BreedSpeciesRules12D::
    dw MONSTER_BOSSTROLL ; id 0
    dw $ffff ; id 1 end of list

; list for entry $12E (IceMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules12E::
    dw MONSTER_LAVAMAN ; id 0
    dw $ffff ; id 1 end of list

; list for entry $12F (Mimic) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules12F::
    dw MONSTER_SCALLOPA ; id 0
    dw $ffff ; id 1 end of list

; list for entry $131 (MudDoll) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules131::
    dw MONSTER_MUDDOLL ; id 0
    dw $ffff ; id 1 end of list

; list for entry $132 (Golem) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules132::
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
BreedSpeciesRules133::
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
BreedSpeciesRules135::
    dw MONSTER_METALKING ; id 0
    dw $ffff ; id 1 end of list

; list for entry $141 (Aquarella) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules141::
    dw MONSTER_DARKEYE ; id 0
    dw MONSTER_MEDUSAEYE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $142 (Merman) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules142::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_MADCAT ; id 1
    dw $ffff ; id 2 end of list

; list for entry $145 (Octoreach) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules145::
    dw $fe05 ; id 0 same species, parent B +5 or more
    dw $fc05 ; id 1 same species, parent A +5 or more
    dw $ffff ; id 2 end of list

; list for entry $146 (Angleron) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules146::
    dw MONSTER_PIXY ; id 0
    dw MONSTER_DEMONITE ; id 1
    dw MONSTER_SKULRIDER ; id 2
    dw MONSTER_GREMLIN ; id 3
    dw $fdfd ; id 4 next result
    dw MONSTER_GULPBEAST ; id 5
    dw MONSTER_DROLL ; id 6
    dw $ffff ; id 7 end of list

; list for entry $148 (RushFish) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules148::
    dw MONSTER_SPIKEROUS ; id 0
    dw MONSTER_ROGUEWAVE ; id 1
    dw MONSTER_MADGOOSE ; id 2
    dw MONSTER_GIGANTES ; id 3
    dw MONSTER_GOLEM ; id 4
    dw $ffff ; id 5 end of list

; list for entry $149 (Gamanian) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules149::
    dw MONSTER_ARMYCRAB ; id 0
    dw $ffff ; id 1 end of list

; list for entry $14A (Clawster) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules14A::
    dw MONSTER_CLAWSTER ; id 0
    dw $ffff ; id 1 end of list

; list for entry $14B (CancerMan) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules14B::
    dw MONSTER_EVILWAND ; id 0
    dw MONSTER_WHALEMAGE ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_BATTLEREX ; id 3
    dw MONSTER_ARCDEMON ; id 4
    dw $ffff ; id 5 end of list

; list for entry $14C (RogueWave) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules14C::
    dw MONSTER_MIMIC ; id 0
    dw $ffff ; id 1 end of list

; list for entry $14F (HoodSquid) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules14F::
    dw MONSTER_1EYECLOWN ; id 0
    dw MONSTER_REAPER ; id 1
    dw MONSTER_RUSHFISH ; id 2
    dw $ffff ; id 3 end of list

; list for entry $150 (MerTiger) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules150::
    dw $fbfb ; id 0 next result when wArg1 = 2, else end of list
    dw MONSTER_BEASTNITE ; id 1
    dw $ffff ; id 2 end of list

; list for entry $152 (Octogon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules152::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_GATEGUARD ; id 1
    dw MONSTER_CHOPCLOWN ; id 2
    dw MONSTER_EVILARMOR ; id 3
    dw $fdfd ; id 4 next result
    dw $fe05 ; id 5 same species, parent B +5 or more
    dw $fc05 ; id 6 same species, parent A +5 or more
    dw $ffff ; id 7 end of list

; list for entry $154 (Digong) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules154::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_COATOL ; id 1
    dw MONSTER_ORLIGON ; id 2
    dw $ffff ; id 3 end of list

; list for entry $158 (Grakos) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules158::
    dw MONSTER_MUDOU ; id 0
    dw $ffff ; id 1 end of list

; list for entry $15F (DracoLord) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules15F::
    dw MONSTER_DIVINEGON ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SIDOH ; id 2
    dw $ffff ; id 3 end of list

; list for entry $160 (DracoLord) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules160::
    dw MONSTER_ORLIGON ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_SIDOH ; id 2
    dw $ffff ; id 3 end of list

; list for entry $162 (Hargon) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules162::
    dw MONSTER_OROCHI ; id 0
    dw $ffff ; id 1 end of list

; list for entry $163 (Sidoh) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules163::
    dw MONSTER_TITANIS ; id 0
    dw $ffff ; id 1 end of list

; list for entry $165 (Baramos) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules165::
    dw MONSTER_DARKHORN ; id 0
    dw MONSTER_GORAGO ; id 1
    dw $ffff ; id 2 end of list

; list for entry $166 (Zoma) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules166::
    dw MONSTER_PSYCHOPIZ ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_AZURILE ; id 2
    dw MONSTER_MIRUDRAAS ; id 3
    dw MONSTER_MIRUDRAAS_16C ; id 4
    dw $ffff ; id 5 end of list

; list for entry $168 (Pizzaro) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules168::
    dw MONSTER_ESTERK ; id 0
    dw $fdfd ; id 1 next result
    dw MONSTER_KINGLEO ; id 2
    dw MONSTER_GORAGO ; id 3
    dw $ffff ; id 4 end of list

; list for entry $169 (PsychoPiz) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules169::
    dw MONSTER_NITERICH ; id 0
    dw $ffff ; id 1 end of list

; list for entry $16A (Esterk) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules16A::
    dw MONSTER_GOLDSLIME ; id 0
    dw $ffff ; id 1 end of list

; list for entry $16B (Mirudraas) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules16B::
    dw MONSTER_SPIKEROUS ; id 0
    dw MONSTER_ORLIGON ; id 1
    dw $fdfd ; id 2 next result
    dw MONSTER_AZURILE ; id 3
    dw $ffff ; id 4 end of list

; list for entry $16C (Mirudraas) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules16C::
    dw MONSTER_ZOMA ; id 0
    dw $ffff ; id 1 end of list

; list for entry $16E (DeathMore) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules16E::
    dw MONSTER_ARMORPION ; id 0
    dw MONSTER_TITANIS ; id 1
    dw $ffff ; id 2 end of list

; list for entry $16F (DeathMore) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
; record: partner species or rule code
BreedSpeciesRules16F::
    dw MONSTER_DARKMATE ; id 0
    dw MONSTER_POSEIDON ; id 1
    dw MONSTER_MUDOU ; id 2
    dw $ffff ; id 3 end of list

; list for entry $170 (DeathMore) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules170::
    dw MONSTER_GRANSLIME ; id 0
    dw MONSTER_WATABOU ; id 1
    dw MONSTER_ASURAZOMA ; id 2
    dw $ffff ; id 3 end of list

; list for entry $172 (Orgodemir) of BreedSpeciesRuleTable; it runs to the next list (E-0199)
BreedSpeciesRules172::
    dw MONSTER_LORDDRACO ; id 0
    dw MONSTER_GIGADRACO ; id 1
    dw $ffff ; id 2 end of list

; stage 1 result lists, indexed like BreedSpeciesRuleTable; the matched result word becomes the
; child's species (wArg6/wArg7) (E-0199, C1)
; record: list
BreedSpeciesResultTable::
    dw BreedSpeciesResults000 ; id 0
    dw BreedSpeciesResults001 ; id 1 DrakSlime
    dw BreedSpeciesResults002 ; id 2 SpotSlime
    dw BreedSpeciesResults003 ; id 3 WingSlime
    dw BreedSpeciesResults003 ; id 4 TreeSlime
    dw BreedSpeciesResults003 ; id 5 Snaily
    dw BreedSpeciesResults003 ; id 6 SlimeNite
    dw BreedSpeciesResults007 ; id 7 Babble
    dw BreedSpeciesResults007 ; id 8 BoxSlime
    dw BreedSpeciesResults007 ; id 9 PearlGel
    dw BreedSpeciesResults007 ; id 10 Slime
    dw BreedSpeciesResults00B ; id 11 Healer
    dw BreedSpeciesResults00C ; id 12 FangSlime
    dw BreedSpeciesResults00C ; id 13 RockSlime
    dw BreedSpeciesResults00E ; id 14 SlimeBorg
    dw BreedSpeciesResults00E ; id 15 Slabbit
    dw BreedSpeciesResults00E ; id 16 KingSlime
    dw BreedSpeciesResults011 ; id 17 Metaly
    dw BreedSpeciesResults012 ; id 18 Metabble
    dw BreedSpeciesResults013 ; id 19 SpotKing
    dw BreedSpeciesResults014 ; id 20 TropicGel
    dw BreedSpeciesResults014 ; id 21 MimeSlime
    dw BreedSpeciesResults016 ; id 22 HaloSlime
    dw BreedSpeciesResults016 ; id 23 MetalKing
    dw BreedSpeciesResults018 ; id 24 GoldSlime
    dw BreedSpeciesResults019 ; id 25 GranSlime
    dw BreedSpeciesResults019 ; id 26 WonderEgg
    dw BreedSpeciesResults01B ; id 27 Butch
    dw BreedSpeciesResults01B ; id 28 ?
    dw BreedSpeciesResults01B ; id 29 ?
    dw BreedSpeciesResults01B ; id 30 ?
    dw BreedSpeciesResults01B ; id 31 ?
    dw BreedSpeciesResults01B ; id 32 ?
    dw BreedSpeciesResults01B ; id 33 ?
    dw BreedSpeciesResults01B ; id 34 ?
    dw BreedSpeciesResults01B ; id 35 ?
    dw BreedSpeciesResults01B ; id 36 DragonKid
    dw BreedSpeciesResults025 ; id 37 Tortragon
    dw BreedSpeciesResults025 ; id 38 Pteranod
    dw BreedSpeciesResults027 ; id 39 Gasgon
    dw BreedSpeciesResults028 ; id 40 FairyDrak
    dw BreedSpeciesResults028 ; id 41 LizardMan
    dw BreedSpeciesResults02A ; id 42 Poisongon
    dw BreedSpeciesResults02A ; id 43 Swordgon
    dw BreedSpeciesResults02A ; id 44 Drygon
    dw BreedSpeciesResults02A ; id 45 Dragon
    dw BreedSpeciesResults02E ; id 46 MiniDrak
    dw BreedSpeciesResults02E ; id 47 MadDragon
    dw BreedSpeciesResults030 ; id 48 Rayburn
    dw BreedSpeciesResults030 ; id 49 Chamelgon
    dw BreedSpeciesResults030 ; id 50 LizardFly
    dw BreedSpeciesResults030 ; id 51 Andreal
    dw BreedSpeciesResults034 ; id 52 KingCobra
    dw BreedSpeciesResults035 ; id 53 Vampirus
    dw BreedSpeciesResults036 ; id 54 SnakeBat
    dw BreedSpeciesResults036 ; id 55 Spikerous
    dw BreedSpeciesResults036 ; id 56 GreatDrak
    dw BreedSpeciesResults039 ; id 57 Crestpent
    dw BreedSpeciesResults03A ; id 58 WingSnake
    dw BreedSpeciesResults03B ; id 59 Coatol
    dw BreedSpeciesResults03B ; id 60 Orochi
    dw BreedSpeciesResults03B ; id 61 BattleRex
    dw BreedSpeciesResults03E ; id 62 SkyDragon
    dw BreedSpeciesResults03F ; id 63 Serpentia
    dw BreedSpeciesResults03F ; id 64 Divinegon
    dw BreedSpeciesResults041 ; id 65 Orligon
    dw BreedSpeciesResults041 ; id 66 GigaDraco
    dw BreedSpeciesResults041 ; id 67 ?
    dw BreedSpeciesResults041 ; id 68 ?
    dw BreedSpeciesResults041 ; id 69 ?
    dw BreedSpeciesResults041 ; id 70 ?
    dw BreedSpeciesResults041 ; id 71 Tonguella
    dw BreedSpeciesResults048 ; id 72 Almiraj
    dw BreedSpeciesResults049 ; id 73 CatFly
    dw BreedSpeciesResults04A ; id 74 PillowRat
    dw BreedSpeciesResults04A ; id 75 Saccer
    dw BreedSpeciesResults04A ; id 76 GulpBeast
    dw BreedSpeciesResults04D ; id 77 Skullroo
    dw BreedSpeciesResults04D ; id 78 WindBeast
    dw BreedSpeciesResults04D ; id 79 Beavern
    dw BreedSpeciesResults04D ; id 80 Antbear
    dw BreedSpeciesResults04D ; id 81 SuperTen
    dw BreedSpeciesResults052 ; id 82 IronTurt
    dw BreedSpeciesResults053 ; id 83 Mommonja
    dw BreedSpeciesResults053 ; id 84 HammerMan
    dw BreedSpeciesResults055 ; id 85 Grizzly
    dw BreedSpeciesResults056 ; id 86 Yeti
    dw BreedSpeciesResults057 ; id 87 ArrowDog
    dw BreedSpeciesResults058 ; id 88 NoctoKing
    dw BreedSpeciesResults059 ; id 89 BeastNite
    dw BreedSpeciesResults05A ; id 90 MadGopher
    dw BreedSpeciesResults05B ; id 91 FairyRat
    dw BreedSpeciesResults05B ; id 92 Unicorn
    dw BreedSpeciesResults05D ; id 93 Goategon
    dw BreedSpeciesResults05E ; id 94 WildApe
    dw BreedSpeciesResults05F ; id 95 Trumpeter
    dw BreedSpeciesResults060 ; id 96 KingLeo
    dw BreedSpeciesResults060 ; id 97 DarkHorn
    dw BreedSpeciesResults062 ; id 98 MadCat
    dw BreedSpeciesResults063 ; id 99 BigEye
    dw BreedSpeciesResults063 ; id 100 Gorago
    dw BreedSpeciesResults063 ; id 101 CatMage
    dw BreedSpeciesResults066 ; id 102 Dumbira
    dw BreedSpeciesResults067 ; id 103 ?
    dw BreedSpeciesResults067 ; id 104 ?
    dw BreedSpeciesResults067 ; id 105 ?
    dw BreedSpeciesResults067 ; id 106 Picky
    dw BreedSpeciesResults067 ; id 107 Wyvern
    dw BreedSpeciesResults067 ; id 108 BullBird
    dw BreedSpeciesResults06D ; id 109 Florajay
    dw BreedSpeciesResults06D ; id 110 DuckKite
    dw BreedSpeciesResults06D ; id 111 MadPecker
    dw BreedSpeciesResults070 ; id 112 MadRaven
    dw BreedSpeciesResults070 ; id 113 MistyWing
    dw BreedSpeciesResults070 ; id 114 AquaHawk
    dw BreedSpeciesResults073 ; id 115 Dracky
    dw BreedSpeciesResults073 ; id 116 KiteHawk
    dw BreedSpeciesResults075 ; id 117 BigRoost
    dw BreedSpeciesResults075 ; id 118 StubBird
    dw BreedSpeciesResults075 ; id 119 LandOwl
    dw BreedSpeciesResults078 ; id 120 MadGoose
    dw BreedSpeciesResults079 ; id 121 MadCondor
    dw BreedSpeciesResults07A ; id 122 Emyu
    dw BreedSpeciesResults07A ; id 123 Blizzardy
    dw BreedSpeciesResults07C ; id 124 Phoenix
    dw BreedSpeciesResults07D ; id 125 ZapBird
    dw BreedSpeciesResults07E ; id 126 Garudian
    dw BreedSpeciesResults07F ; id 127 WhipBird
    dw BreedSpeciesResults080 ; id 128 FunkyBird
    dw BreedSpeciesResults081 ; id 129 RainHawk
    dw BreedSpeciesResults082 ; id 130 Azurile
    dw BreedSpeciesResults082 ; id 131 Shantak
    dw BreedSpeciesResults084 ; id 132 CragDevil
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
    dw BreedSpeciesResults097 ; id 151 Oniono
    dw BreedSpeciesResults097 ; id 152 DanceVegi
    dw BreedSpeciesResults097 ; id 153 TreeBoy
    dw BreedSpeciesResults09A ; id 154 Devipine
    dw BreedSpeciesResults09A ; id 155 FaceTree
    dw BreedSpeciesResults09A ; id 156 HerbMan
    dw BreedSpeciesResults09A ; id 157 BeanMan
    dw BreedSpeciesResults09A ; id 158 EvilSeed
    dw BreedSpeciesResults09F ; id 159 ManEater
    dw BreedSpeciesResults0A0 ; id 160 Snapper
    dw BreedSpeciesResults0A0 ; id 161 GhosTree
    dw BreedSpeciesResults0A2 ; id 162 Rosevine
    dw BreedSpeciesResults0A3 ; id 163 Egdracil
    dw BreedSpeciesResults0A3 ; id 164 Warubou
    dw BreedSpeciesResults0A5 ; id 165 Watabou
    dw BreedSpeciesResults0A5 ; id 166 Eggplaton
    dw BreedSpeciesResults0A5 ; id 167 FooHero
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
    dw BreedSpeciesResults0B2 ; id 178 Gophecada
    dw BreedSpeciesResults0B2 ; id 179 Butterfly
    dw BreedSpeciesResults0B4 ; id 180 WeedBug
    dw BreedSpeciesResults0B5 ; id 181 GiantWorm
    dw BreedSpeciesResults0B5 ; id 182 Lipsy
    dw BreedSpeciesResults0B7 ; id 183 StagBug
    dw BreedSpeciesResults0B8 ; id 184 Pyuro
    dw BreedSpeciesResults0B8 ; id 185 ArmyAnt
    dw BreedSpeciesResults0B8 ; id 186 GoHopper
    dw BreedSpeciesResults0B8 ; id 187 TailEater
    dw BreedSpeciesResults0BC ; id 188 ArmorPede
    dw BreedSpeciesResults0BC ; id 189 Eyeder
    dw BreedSpeciesResults0BE ; id 190 GiantMoth
    dw BreedSpeciesResults0BE ; id 191 Droll
    dw BreedSpeciesResults0BE ; id 192 ArmyCrab
    dw BreedSpeciesResults0C1 ; id 193 MadHornet
    dw BreedSpeciesResults0C2 ; id 194 Belzebub
    dw BreedSpeciesResults0C2 ; id 195 WarMantis
    dw BreedSpeciesResults0C4 ; id 196 HornBeet
    dw BreedSpeciesResults0C5 ; id 197 Sickler
    dw BreedSpeciesResults0C5 ; id 198 Armorpion
    dw BreedSpeciesResults0C7 ; id 199 Digster
    dw BreedSpeciesResults0C7 ; id 200 Skularach
    dw BreedSpeciesResults0C7 ; id 201 MultiEyes
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
    dw BreedSpeciesResults0D6 ; id 214 Demonite
    dw BreedSpeciesResults0D7 ; id 215 DarkEye
    dw BreedSpeciesResults0D8 ; id 216 EyeBall
    dw BreedSpeciesResults0D8 ; id 217 SkulRider
    dw BreedSpeciesResults0D8 ; id 218 EvilBeast
    dw BreedSpeciesResults0D8 ; id 219 Bubblemon
    dw BreedSpeciesResults0DC ; id 220 1EyeClown
    dw BreedSpeciesResults0DD ; id 221 Gremlin
    dw BreedSpeciesResults0DE ; id 222 ArcDemon
    dw BreedSpeciesResults0DF ; id 223 Lionex
    dw BreedSpeciesResults0E0 ; id 224 GoatHorn
    dw BreedSpeciesResults0E0 ; id 225 Orc
    dw BreedSpeciesResults0E0 ; id 226 Ogre
    dw BreedSpeciesResults0E3 ; id 227 GateGuard
    dw BreedSpeciesResults0E3 ; id 228 ChopClown
    dw BreedSpeciesResults0E3 ; id 229 BossTroll
    dw BreedSpeciesResults0E6 ; id 230 Grendal
    dw BreedSpeciesResults0E7 ; id 231 Akubar
    dw BreedSpeciesResults0E8 ; id 232 MadKnight
    dw BreedSpeciesResults0E8 ; id 233 EvilWell
    dw BreedSpeciesResults0E8 ; id 234 Gigantes
    dw BreedSpeciesResults0EB ; id 235 Centasaur
    dw BreedSpeciesResults0EC ; id 236 EvilArmor
    dw BreedSpeciesResults0EC ; id 237 Jamirus
    dw BreedSpeciesResults0EE ; id 238 Durran
    dw BreedSpeciesResults0EF ; id 239 Titanis
    dw BreedSpeciesResults0EF ; id 240 LampGenie
    dw BreedSpeciesResults0F1 ; id 241 ?
    dw BreedSpeciesResults0F1 ; id 242 ?
    dw BreedSpeciesResults0F1 ; id 243 ?
    dw BreedSpeciesResults0F1 ; id 244 ?
    dw BreedSpeciesResults0F1 ; id 245 ?
    dw BreedSpeciesResults0F1 ; id 246 Spooky
    dw BreedSpeciesResults0F1 ; id 247 Skullgon
    dw BreedSpeciesResults0F8 ; id 248 PutrePup
    dw BreedSpeciesResults0F9 ; id 249 RotRaven
    dw BreedSpeciesResults0F9 ; id 250 Mummy
    dw BreedSpeciesResults0FB ; id 251 DarkCrab
    dw BreedSpeciesResults0FB ; id 252 DeadNite
    dw BreedSpeciesResults0FD ; id 253 Shadow
    dw BreedSpeciesResults0FD ; id 254 Skulpent
    dw BreedSpeciesResults0FD ; id 255 Hork
    dw BreedSpeciesResults100 ; id 256 Mudron
    dw BreedSpeciesResults101 ; id 257 NiteWhip
    dw BreedSpeciesResults102 ; id 258 WindMerge
    dw BreedSpeciesResults102 ; id 259 Reaper
    dw BreedSpeciesResults102 ; id 260 Inverzon
    dw BreedSpeciesResults102 ; id 261 FoxFire
    dw BreedSpeciesResults102 ; id 262 CaptDead
    dw BreedSpeciesResults107 ; id 263 DeadNoble
    dw BreedSpeciesResults108 ; id 264 WhiteKing
    dw BreedSpeciesResults109 ; id 265 BoneSlave
    dw BreedSpeciesResults10A ; id 266 Skeletor
    dw BreedSpeciesResults10B ; id 267 Servant
    dw BreedSpeciesResults10C ; id 268 Lazamanus
    dw BreedSpeciesResults10C ; id 269 Copycat
    dw BreedSpeciesResults10E ; id 270 MadSpirit
    dw BreedSpeciesResults10F ; id 271 PomPomBom
    dw BreedSpeciesResults10F ; id 272 Niterich
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
    dw BreedSpeciesResults11B ; id 283 MadCandle
    dw BreedSpeciesResults11C ; id 284 CoilBird
    dw BreedSpeciesResults11C ; id 285 Facer
    dw BreedSpeciesResults11C ; id 286 SpikyBoy
    dw BreedSpeciesResults11F ; id 287 MadMirror
    dw BreedSpeciesResults120 ; id 288 RogueNite
    dw BreedSpeciesResults120 ; id 289 Puppetor
    dw BreedSpeciesResults122 ; id 290 Goopi
    dw BreedSpeciesResults123 ; id 291 Voodoll
    dw BreedSpeciesResults124 ; id 292 MetalDrak
    dw BreedSpeciesResults125 ; id 293 Balzak
    dw BreedSpeciesResults125 ; id 294 SabreMan
    dw BreedSpeciesResults127 ; id 295 CurseLamp
    dw BreedSpeciesResults128 ; id 296 Brushead
    dw BreedSpeciesResults128 ; id 297 Roboster
    dw BreedSpeciesResults12A ; id 298 Roboster2
    dw BreedSpeciesResults12B ; id 299 EvilPot
    dw BreedSpeciesResults12C ; id 300 Gismo
    dw BreedSpeciesResults12D ; id 301 LavaMan
    dw BreedSpeciesResults12E ; id 302 IceMan
    dw BreedSpeciesResults12F ; id 303 Mimic
    dw BreedSpeciesResults130 ; id 304 Exaucers
    dw BreedSpeciesResults130 ; id 305 MudDoll
    dw BreedSpeciesResults132 ; id 306 Golem
    dw BreedSpeciesResults133 ; id 307 StoneMan
    dw BreedSpeciesResults134 ; id 308 BombCrag
    dw BreedSpeciesResults134 ; id 309 GoldGolem
    dw BreedSpeciesResults136 ; id 310 DarkMate
    dw BreedSpeciesResults136 ; id 311 ProtoMech
    dw BreedSpeciesResults136 ; id 312 CloudKing
    dw BreedSpeciesResults136 ; id 313 ?
    dw BreedSpeciesResults136 ; id 314 ?
    dw BreedSpeciesResults136 ; id 315 ?
    dw BreedSpeciesResults136 ; id 316 Petiteel
    dw BreedSpeciesResults136 ; id 317 Moray
    dw BreedSpeciesResults136 ; id 318 WalrusMan
    dw BreedSpeciesResults136 ; id 319 RayGigas
    dw BreedSpeciesResults136 ; id 320 Anemon
    dw BreedSpeciesResults136 ; id 321 Aquarella
    dw BreedSpeciesResults142 ; id 322 Merman
    dw BreedSpeciesResults143 ; id 323 Octokid
    dw BreedSpeciesResults143 ; id 324 PutreFish
    dw BreedSpeciesResults143 ; id 325 Octoreach
    dw BreedSpeciesResults146 ; id 326 Angleron
    dw BreedSpeciesResults147 ; id 327 FishRider
    dw BreedSpeciesResults147 ; id 328 RushFish
    dw BreedSpeciesResults149 ; id 329 Gamanian
    dw BreedSpeciesResults14A ; id 330 Clawster
    dw BreedSpeciesResults14B ; id 331 CancerMan
    dw BreedSpeciesResults14C ; id 332 RogueWave
    dw BreedSpeciesResults14D ; id 333 Scallopa
    dw BreedSpeciesResults14D ; id 334 SeaHorse
    dw BreedSpeciesResults14D ; id 335 HoodSquid
    dw BreedSpeciesResults150 ; id 336 MerTiger
    dw BreedSpeciesResults151 ; id 337 AxeShark
    dw BreedSpeciesResults151 ; id 338 Octogon
    dw BreedSpeciesResults153 ; id 339 KingSquid
    dw BreedSpeciesResults153 ; id 340 Digong
    dw BreedSpeciesResults155 ; id 341 WhaleMage
    dw BreedSpeciesResults155 ; id 342 Aquadon
    dw BreedSpeciesResults155 ; id 343 Octoraid
    dw BreedSpeciesResults155 ; id 344 Grakos
    dw BreedSpeciesResults159 ; id 345 Poseidon
    dw BreedSpeciesResults159 ; id 346 Pumpoise
    dw BreedSpeciesResults159 ; id 347 Starfish
    dw BreedSpeciesResults159 ; id 348 ?
    dw BreedSpeciesResults159 ; id 349 ?
    dw BreedSpeciesResults159 ; id 350 ?
    dw BreedSpeciesResults159 ; id 351 DracoLord
    dw BreedSpeciesResults160 ; id 352 DracoLord
    dw BreedSpeciesResults161 ; id 353 LordDraco
    dw BreedSpeciesResults161 ; id 354 Hargon
    dw BreedSpeciesResults163 ; id 355 Sidoh
    dw BreedSpeciesResults164 ; id 356 Genosidoh
    dw BreedSpeciesResults164 ; id 357 Baramos
    dw BreedSpeciesResults166 ; id 358 Zoma
    dw BreedSpeciesResults167 ; id 359 AsuraZoma
    dw BreedSpeciesResults167 ; id 360 Pizzaro
    dw BreedSpeciesResults169 ; id 361 PsychoPiz
    dw BreedSpeciesResults16A ; id 362 Esterk
    dw BreedSpeciesResults16B ; id 363 Mirudraas
    dw BreedSpeciesResults16C ; id 364 Mirudraas
    dw BreedSpeciesResults16D ; id 365 Mudou
    dw BreedSpeciesResults16D ; id 366 DeathMore
    dw BreedSpeciesResults16F ; id 367 DeathMore
    dw BreedSpeciesResults170 ; id 368 DeathMore
    dw BreedSpeciesResults171 ; id 369 Darkdrium
    dw BreedSpeciesResults171 ; id 370 Orgodemir
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
BreedSpeciesResults001::
    dw MONSTER_SLIMEBORG ; id 0

; list for entry $02 (SpotSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults002::
    dw MONSTER_SPOTKING ; id 0

; list for entry $03 (WingSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults003::
    dw MONSTER_SLIMEBORG ; id 0

; list for entry $07 (Babble) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults007::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_TROPICGEL ; id 1
    dw MONSTER_HALOSLIME ; id 2
    dw MONSTER_WONDEREGG ; id 3

; list for entry $0B (Healer) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults00B::
    dw MONSTER_MIMESLIME ; id 0

; list for entry $0C (FangSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults00C::
    dw MONSTER_SLIMEBORG ; id 0

; list for entry $0E (SlimeBorg) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults00E::
    dw MONSTER_SPOTKING ; id 0
    dw MONSTER_METALKING ; id 1
    dw MONSTER_GOLDSLIME ; id 2

; list for entry $11 (Metaly) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults011::
    dw MONSTER_METABBLE ; id 0

; list for entry $12 (Metabble) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults012::
    dw MONSTER_SLIMEBORG ; id 0
    dw MONSTER_METALKING ; id 1

; list for entry $13 (SpotKing) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults013::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_METALKING ; id 1
    dw MONSTER_GOLDSLIME ; id 2

; list for entry $14 (TropicGel) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults014::
    dw MONSTER_HALOSLIME ; id 0

; list for entry $16 (HaloSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults016::
    dw MONSTER_SPOTKING ; id 0
    dw MONSTER_GOLDSLIME ; id 1

; list for entry $18 (GoldSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults018::
    dw MONSTER_GRANSLIME ; id 0

; list for entry $19 (GranSlime) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults019::
    dw MONSTER_METALKING ; id 0
    dw MONSTER_GOLDSLIME ; id 1
    dw MONSTER_GRANSLIME ; id 2

; list for entry $1B (Butch) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults01B::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_DRAGON ; id 1

; list for entry $25 (Tortragon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults025::
    dw MONSTER_VAMPIRUS ; id 0
    dw MONSTER_COATOL ; id 1

; list for entry $27 (Gasgon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults027::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_COATOL ; id 1

; list for entry $28 (FairyDrak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults028::
    dw MONSTER_RAYBURN ; id 0
    dw MONSTER_COATOL ; id 1

; list for entry $2A (Poisongon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults02A::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_SKYDRAGON ; id 1
    dw MONSTER_SERPENTIA ; id 2

; list for entry $2E (MiniDrak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults02E::
    dw MONSTER_ANDREAL ; id 0

; list for entry $30 (Rayburn) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults030::
    dw MONSTER_OROCHI ; id 0
    dw MONSTER_GIGADRACO ; id 1

; list for entry $34 (KingCobra) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults034::
    dw MONSTER_SNAKEBAT ; id 0

; list for entry $35 (Vampirus) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults035::
    dw MONSTER_COATOL ; id 0
    dw MONSTER_VAMPIRUS ; id 1

; list for entry $36 (SnakeBat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults036::
    dw MONSTER_OROCHI ; id 0
    dw MONSTER_SERPENTIA ; id 1
    dw MONSTER_GIGADRACO ; id 2

; list for entry $39 (Crestpent) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults039::
    dw MONSTER_WINGSNAKE ; id 0

; list for entry $3A (WingSnake) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults03A::
    dw MONSTER_COATOL ; id 0

; list for entry $3B (Coatol) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults03B::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_COATOL ; id 1
    dw MONSTER_GIGADRACO ; id 2

; list for entry $3E (SkyDragon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults03E::
    dw MONSTER_ANDREAL ; id 0
    dw MONSTER_COATOL ; id 1
    dw MONSTER_DIVINEGON ; id 2
    dw MONSTER_GIGADRACO ; id 3

; list for entry $3F (Serpentia) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults03F::
    dw MONSTER_ORLIGON ; id 0

; list for entry $41 (Orligon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults041::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_SUPERTEN ; id 1
    dw MONSTER_TRUMPETER ; id 2

; list for entry $48 (Almiraj) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults048::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_UNICORN ; id 1

; list for entry $49 (CatFly) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults049::
    dw MONSTER_CATMAGE ; id 0

; list for entry $4A (PillowRat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults04A::
    dw MONSTER_SUPERTEN ; id 0
    dw MONSTER_TRUMPETER ; id 1

; list for entry $4D (Skullroo) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults04D::
    dw MONSTER_DUMBIRA ; id 0

; list for entry $52 (IronTurt) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults052::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1

; list for entry $53 (Mommonja) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults053::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_DUMBIRA ; id 1

; list for entry $55 (Grizzly) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults055::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_TRUMPETER ; id 1

; list for entry $56 (Yeti) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults056::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_TRUMPETER ; id 1

; list for entry $57 (ArrowDog) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults057::
    dw MONSTER_NOCTOKING ; id 0
    dw MONSTER_MADCAT ; id 1

; list for entry $58 (NoctoKing) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults058::
    dw MONSTER_DUMBIRA ; id 0

; list for entry $59 (BeastNite) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults059::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_NOCTOKING ; id 1

; list for entry $5A (MadGopher) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults05A::
    dw MONSTER_BEASTNITE ; id 0

; list for entry $5B (FairyRat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults05B::
    dw MONSTER_GULPBEAST ; id 0

; list for entry $5D (Goategon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults05D::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1

; list for entry $5E (WildApe) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults05E::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1
    dw MONSTER_TRUMPETER ; id 2

; list for entry $5F (Trumpeter) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults05F::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_KINGLEO ; id 1
    dw MONSTER_GULPBEAST ; id 2

; list for entry $60 (KingLeo) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults060::
    dw MONSTER_GORAGO ; id 0

; list for entry $62 (MadCat) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults062::
    dw MONSTER_YETI ; id 0
    dw MONSTER_DARKHORN ; id 1

; list for entry $63 (BigEye) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults063::
    dw MONSTER_MADCAT ; id 0

; list for entry $66 (Dumbira) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults066::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_YETI ; id 1

; list for entry $67 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults067::
    dw MONSTER_LANDOWL ; id 0

; list for entry $6D (Florajay) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults06D::
    dw MONSTER_EMYU ; id 0

; list for entry $70 (MadRaven) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults070::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_MADCONDOR ; id 1

; list for entry $73 (Dracky) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults073::
    dw MONSTER_MADCONDOR ; id 0

; list for entry $75 (BigRoost) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults075::
    dw MONSTER_WHIPBIRD ; id 0

; list for entry $78 (MadGoose) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults078::
    dw MONSTER_WHIPBIRD ; id 0

; list for entry $79 (MadCondor) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults079::
    dw MONSTER_EMYU ; id 0
    dw MONSTER_ZAPBIRD ; id 1
    dw MONSTER_WHIPBIRD ; id 2

; list for entry $7A (Emyu) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults07A::
    dw MONSTER_GARUDIAN ; id 0
    dw MONSTER_WHIPBIRD ; id 1
    dw MONSTER_RAINHAWK ; id 2

; list for entry $7C (Phoenix) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults07C::
    dw MONSTER_ZAPBIRD ; id 0
    dw MONSTER_GARUDIAN ; id 1

; list for entry $7D (ZapBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults07D::
    dw MONSTER_GARUDIAN ; id 0
    dw MONSTER_WHIPBIRD ; id 1

; list for entry $7E (Garudian) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults07E::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_SHANTAK ; id 1

; list for entry $7F (WhipBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults07F::
    dw MONSTER_ZAPBIRD ; id 0
    dw MONSTER_SHANTAK ; id 1

; list for entry $80 (FunkyBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults080::
    dw MONSTER_GARUDIAN ; id 0

; list for entry $81 (RainHawk) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults081::
    dw MONSTER_AZURILE ; id 0

; list for entry $82 (Azurile) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults082::
    dw MONSTER_AZURILE ; id 0

; list for entry $84 (CragDevil) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults084::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_FUNKYBIRD ; id 1

; list for entry $85 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults085::
    dw MONSTER_GHOSTREE ; id 0

; list for entry $97 (Oniono) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults097::
    dw MONSTER_FOOHERO ; id 0

; list for entry $9A (Devipine) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults09A::
    dw MONSTER_MANEATER ; id 0

; list for entry $9F (ManEater) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults09F::
    dw MONSTER_SNAPPER ; id 0

; list for entry $A0 (Snapper) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0A0::
    dw MONSTER_STUBSUCK ; id 0
    dw MONSTER_FACETREE ; id 1

; list for entry $A2 (Rosevine) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0A2::
    dw MONSTER_EGDRACIL ; id 0

; list for entry $A3 (Egdracil) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0A3::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_WATABOU ; id 1

; list for entry $A5 (Watabou) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0A5::
    dw MONSTER_TREEBOY ; id 0

; list for entry $A8 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0A8::
    dw MONSTER_MULTIEYES ; id 0

; list for entry $B2 (Gophecada) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0B2::
    dw MONSTER_DROLL ; id 0
    dw MONSTER_MADHORNET ; id 1

; list for entry $B4 (WeedBug) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0B4::
    dw MONSTER_TAILEATER ; id 0

; list for entry $B5 (GiantWorm) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0B5::
    dw MONSTER_DROLL ; id 0

; list for entry $B7 (StagBug) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0B7::
    dw MONSTER_HORNBEET ; id 0

; list for entry $B8 (Pyuro) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0B8::
    dw MONSTER_DROLL ; id 0

; list for entry $BC (ArmorPede) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0BC::
    dw MONSTER_DROLL ; id 0

; list for entry $BE (GiantMoth) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0BE::
    dw MONSTER_DIGSTER ; id 0

; list for entry $C1 (MadHornet) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0C1::
    dw MONSTER_BELZEBUB ; id 0

; list for entry $C2 (Belzebub) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0C2::
    dw MONSTER_ARMORPION ; id 0

; list for entry $C4 (HornBeet) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0C4::
    dw MONSTER_ARMORPION ; id 0

; list for entry $C5 (Sickler) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0C5::
    dw MONSTER_SKULARACH ; id 0

; list for entry $C7 (Digster) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0C7::
    dw MONSTER_BELZEBUB ; id 0
    dw MONSTER_ARMORPEDE ; id 1

; list for entry $CA (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0CA::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_OGRE ; id 1
    dw MONSTER_GATEGUARD ; id 2

; list for entry $D6 (Demonite) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0D6::
    dw MONSTER_GATEGUARD ; id 0

; list for entry $D7 (DarkEye) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0D7::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $D8 (EyeBall) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0D8::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_GATEGUARD ; id 1
    dw MONSTER_EVILWELL ; id 2

; list for entry $DC (1EyeClown) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0DC::
    dw MONSTER_MEDUSAEYE ; id 0
    dw MONSTER_CHOPCLOWN ; id 1

; list for entry $DD (Gremlin) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0DD::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $DE (ArcDemon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0DE::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_AKUBAR ; id 1

; list for entry $DF (Lionex) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0DF::
    dw MONSTER_CHOPCLOWN ; id 0

; list for entry $E0 (GoatHorn) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0E0::
    dw MONSTER_BOSSTROLL ; id 0
    dw MONSTER_EVILWELL ; id 1

; list for entry $E3 (GateGuard) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0E3::
    dw MONSTER_EVILWELL ; id 0
    dw MONSTER_LAMPGENIE ; id 1

; list for entry $E6 (Grendal) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0E6::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_OGRE ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_AKUBAR ; id 3
    dw MONSTER_CHOPCLOWN ; id 4

; list for entry $E7 (Akubar) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0E7::
    dw MONSTER_JAMIRUS ; id 0

; list for entry $E8 (MadKnight) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0E8::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_OGRE ; id 1
    dw MONSTER_GATEGUARD ; id 2

; list for entry $EB (Centasaur) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0EB::
    dw MONSTER_BOSSTROLL ; id 0
    dw MONSTER_DURRAN ; id 1

; list for entry $EC (EvilArmor) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0EC::
    dw MONSTER_DURRAN ; id 0
    dw MONSTER_SIDOH ; id 1

; list for entry $EE (Durran) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0EE::
    dw MONSTER_TITANIS ; id 0
    dw MONSTER_PIZZARO ; id 1

; list for entry $EF (Titanis) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0EF::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_ARCDEMON ; id 1

; list for entry $F1 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0F1::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1

; list for entry $F8 (PutrePup) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0F8::
    dw MONSTER_FOXFIRE ; id 0

; list for entry $F9 (RotRaven) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0F9::
    dw MONSTER_BONESLAVE ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $FB (DarkCrab) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults0FB::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_BONESLAVE ; id 1
    dw MONSTER_SKELETOR ; id 2
    dw MONSTER_CAPTDEAD ; id 3

; list for entry $FD (Shadow) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults0FD::
    dw MONSTER_INVERZON ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $100 (Mudron) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults100::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $101 (NiteWhip) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults101::
    dw MONSTER_CAPTDEAD ; id 0

; list for entry $102 (WindMerge) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults102::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $107 (DeadNoble) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults107::
    dw MONSTER_WHITEKING ; id 0
    dw MONSTER_NITERICH ; id 1

; list for entry $108 (WhiteKing) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults108::
    dw MONSTER_LAZAMANUS ; id 0
    dw MONSTER_HARGON ; id 1

; list for entry $109 (BoneSlave) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults109::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1
    dw MONSTER_SKELETOR ; id 2

; list for entry $10A (Skeletor) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults10A::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1
    dw MONSTER_SERVANT ; id 2
    dw MONSTER_NITERICH ; id 3
    dw MONSTER_NITERICH ; id 4

; list for entry $10B (Servant) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults10B::
    dw MONSTER_DRACOLORD ; id 0

; list for entry $10C (Lazamanus) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults10C::
    dw MONSTER_POMPOMBOM ; id 0

; list for entry $10E (MadSpirit) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults10E::
    dw MONSTER_DEADNOBLE ; id 0

; list for entry $10F (PomPomBom) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults10F::
    dw MONSTER_WHITEKING ; id 0

; list for entry $111 (?) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults111::
    dw MONSTER_SABREMAN ; id 0

; list for entry $11B (MadCandle) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults11B::
    dw MONSTER_GISMO ; id 0

; list for entry $11C (CoilBird) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults11C::
    dw MONSTER_BOMBCRAG ; id 0

; list for entry $11F (MadMirror) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults11F::
    dw MONSTER_GISMO ; id 0

; list for entry $120 (RogueNite) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults120::
    dw MONSTER_BRUSHEAD ; id 0

; list for entry $122 (Goopi) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults122::
    dw MONSTER_GISMO ; id 0
    dw MONSTER_MUDDOLL ; id 1

; list for entry $123 (Voodoll) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults123::
    dw MONSTER_SABREMAN ; id 0

; list for entry $124 (MetalDrak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults124::
    dw MONSTER_LAVAMAN ; id 0
    dw MONSTER_ICEMAN ; id 1

; list for entry $125 (Balzak) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults125::
    dw MONSTER_ROBOSTER ; id 0

; list for entry $127 (CurseLamp) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults127::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_BALZAK ; id 1

; list for entry $128 (Brushead) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults128::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ROBOSTER2 ; id 1
    dw MONSTER_ICEMAN ; id 2
    dw MONSTER_MIMIC ; id 3
    dw MONSTER_ROBOSTER2 ; id 4

; list for entry $12A (Roboster2) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults12A::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ICEMAN ; id 1

; list for entry $12B (EvilPot) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults12B::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_BOMBCRAG ; id 1

; list for entry $12C (Gismo) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults12C::
    dw MONSTER_CLOUDKING ; id 0

; list for entry $12D (LavaMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults12D::
    dw MONSTER_GOLDGOLEM ; id 0

; list for entry $12E (IceMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults12E::
    dw MONSTER_GOLDGOLEM ; id 0

; list for entry $12F (Mimic) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults12F::
    dw MONSTER_EVILPOT ; id 0

; list for entry $130 (Exaucers) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults130::
    dw MONSTER_GOLEM ; id 0

; list for entry $132 (Golem) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults132::
    dw MONSTER_VOODOLL ; id 0
    dw MONSTER_SABREMAN ; id 1
    dw MONSTER_STONEMAN ; id 2

; list for entry $133 (StoneMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults133::
    dw MONSTER_VOODOLL ; id 0
    dw MONSTER_METALDRAK ; id 1
    dw MONSTER_SABREMAN ; id 2

; list for entry $134 (BombCrag) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults134::
    dw MONSTER_DARKMATE ; id 0

; list for entry $136 (DarkMate) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults136::
    dw MONSTER_GAMANIAN ; id 0

; list for entry $142 (Merman) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults142::
    dw MONSTER_MERTIGER ; id 0
    dw MONSTER_EVILPOT ; id 1

; list for entry $143 (Octokid) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults143::
    dw MONSTER_OCTOGON ; id 0

; list for entry $146 (Angleron) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults146::
    dw MONSTER_FISHRIDER ; id 0
    dw MONSTER_RUSHFISH ; id 1

; list for entry $147 (FishRider) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults147::
    dw MONSTER_DIGONG ; id 0

; list for entry $149 (Gamanian) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults149::
    dw MONSTER_CLAWSTER ; id 0

; list for entry $14A (Clawster) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults14A::
    dw MONSTER_CANCERMAN ; id 0

; list for entry $14B (CancerMan) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults14B::
    dw MONSTER_HOODSQUID ; id 0
    dw MONSTER_AXESHARK ; id 1

; list for entry $14C (RogueWave) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults14C::
    dw MONSTER_SCALLOPA ; id 0

; list for entry $14D (Scallopa) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults14D::
    dw MONSTER_WHALEMAGE ; id 0

; list for entry $150 (MerTiger) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults150::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_AXESHARK ; id 1

; list for entry $151 (AxeShark) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults151::
    dw MONSTER_OCTORAID ; id 0
    dw MONSTER_KINGSQUID ; id 1

; list for entry $153 (KingSquid) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults153::
    dw MONSTER_AQUADON ; id 0

; list for entry $155 (WhaleMage) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults155::
    dw MONSTER_POSEIDON ; id 0

; list for entry $159 (Poseidon) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults159::
    dw MONSTER_DRACOLORD_160 ; id 0
    dw MONSTER_ZOMA ; id 1

; list for entry $160 (DracoLord) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults160::
    dw MONSTER_LORDDRACO ; id 0
    dw MONSTER_ZOMA ; id 1

; list for entry $161 (LordDraco) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults161::
    dw MONSTER_BARAMOS ; id 0

; list for entry $163 (Sidoh) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults163::
    dw MONSTER_GENOSIDOH ; id 0

; list for entry $164 (Genosidoh) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults164::
    dw MONSTER_MUDOU ; id 0

; list for entry $166 (Zoma) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults166::
    dw MONSTER_ASURAZOMA ; id 0
    dw MONSTER_DEATHMORE ; id 1

; list for entry $167 (AsuraZoma) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults167::
    dw MONSTER_PSYCHOPIZ ; id 0
    dw MONSTER_ESTERK ; id 1

; list for entry $169 (PsychoPiz) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults169::
    dw MONSTER_ORGODEMIR ; id 0

; list for entry $16A (Esterk) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults16A::
    dw MONSTER_MIRUDRAAS ; id 0

; list for entry $16B (Mirudraas) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults16B::
    dw MONSTER_MIRUDRAAS_16C ; id 0
    dw MONSTER_DEATHMORE ; id 1

; list for entry $16C (Mirudraas) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults16C::
    dw MONSTER_DEATHMORE ; id 0

; list for entry $16D (Mudou) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults16D::
    dw MONSTER_DEATHMORE_16F ; id 0

; list for entry $16F (DeathMore) of BreedSpeciesResultTable; it runs to the next list (E-0199)
; record: child species
BreedSpeciesResults16F::
    dw MONSTER_DEATHMORE_170 ; id 0

; list for entry $170 (DeathMore) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults170::
    dw MONSTER_DARKDRIUM ; id 0

; list for entry $171 (Darkdrium) of BreedSpeciesResultTable; it runs to the next list (E-0199)
BreedSpeciesResults171::
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
    dw BreedFamilyRules004 ; id 4 TreeSlime
    dw BreedFamilyRules000 ; id 5 Snaily
    dw BreedFamilyRules000 ; id 6 SlimeNite
    dw BreedFamilyRules000 ; id 7 Babble
    dw BreedFamilyRules000 ; id 8 BoxSlime
    dw BreedFamilyRules000 ; id 9 PearlGel
    dw BreedFamilyRules000 ; id 10 Slime
    dw BreedFamilyRules00B ; id 11 Healer
    dw BreedFamilyRules000 ; id 12 FangSlime
    dw BreedFamilyRules000 ; id 13 RockSlime
    dw BreedFamilyRules000 ; id 14 SlimeBorg
    dw BreedFamilyRules000 ; id 15 Slabbit
    dw BreedFamilyRules000 ; id 16 KingSlime
    dw BreedFamilyRules000 ; id 17 Metaly
    dw BreedFamilyRules000 ; id 18 Metabble
    dw BreedFamilyRules000 ; id 19 SpotKing
    dw BreedFamilyRules000 ; id 20 TropicGel
    dw BreedFamilyRules015 ; id 21 MimeSlime
    dw BreedFamilyRules000 ; id 22 HaloSlime
    dw BreedFamilyRules000 ; id 23 MetalKing
    dw BreedFamilyRules000 ; id 24 GoldSlime
    dw BreedFamilyRules000 ; id 25 GranSlime
    dw BreedFamilyRules01A ; id 26 WonderEgg
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
    dw BreedFamilyRules027 ; id 39 Gasgon
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
    dw BreedFamilyRules047 ; id 71 Tonguella
    dw BreedFamilyRules048 ; id 72 Almiraj
    dw BreedFamilyRules049 ; id 73 CatFly
    dw BreedFamilyRules000 ; id 74 PillowRat
    dw BreedFamilyRules04B ; id 75 Saccer
    dw BreedFamilyRules04C ; id 76 GulpBeast
    dw BreedFamilyRules000 ; id 77 Skullroo
    dw BreedFamilyRules000 ; id 78 WindBeast
    dw BreedFamilyRules000 ; id 79 Beavern
    dw BreedFamilyRules000 ; id 80 Antbear
    dw BreedFamilyRules051 ; id 81 SuperTen
    dw BreedFamilyRules000 ; id 82 IronTurt
    dw BreedFamilyRules000 ; id 83 Mommonja
    dw BreedFamilyRules000 ; id 84 HammerMan
    dw BreedFamilyRules055 ; id 85 Grizzly
    dw BreedFamilyRules056 ; id 86 Yeti
    dw BreedFamilyRules000 ; id 87 ArrowDog
    dw BreedFamilyRules000 ; id 88 NoctoKing
    dw BreedFamilyRules000 ; id 89 BeastNite
    dw BreedFamilyRules000 ; id 90 MadGopher
    dw BreedFamilyRules000 ; id 91 FairyRat
    dw BreedFamilyRules000 ; id 92 Unicorn
    dw BreedFamilyRules05D ; id 93 Goategon
    dw BreedFamilyRules05E ; id 94 WildApe
    dw BreedFamilyRules05F ; id 95 Trumpeter
    dw BreedFamilyRules000 ; id 96 KingLeo
    dw BreedFamilyRules061 ; id 97 DarkHorn
    dw BreedFamilyRules000 ; id 98 MadCat
    dw BreedFamilyRules063 ; id 99 BigEye
    dw BreedFamilyRules000 ; id 100 Gorago
    dw BreedFamilyRules065 ; id 101 CatMage
    dw BreedFamilyRules066 ; id 102 Dumbira
    dw BreedFamilyRules000 ; id 103 ?
    dw BreedFamilyRules000 ; id 104 ?
    dw BreedFamilyRules000 ; id 105 ?
    dw BreedFamilyRules06A ; id 106 Picky
    dw BreedFamilyRules06B ; id 107 Wyvern
    dw BreedFamilyRules06C ; id 108 BullBird
    dw BreedFamilyRules000 ; id 109 Florajay
    dw BreedFamilyRules06E ; id 110 DuckKite
    dw BreedFamilyRules000 ; id 111 MadPecker
    dw BreedFamilyRules000 ; id 112 MadRaven
    dw BreedFamilyRules000 ; id 113 MistyWing
    dw BreedFamilyRules000 ; id 114 AquaHawk
    dw BreedFamilyRules000 ; id 115 Dracky
    dw BreedFamilyRules074 ; id 116 KiteHawk
    dw BreedFamilyRules075 ; id 117 BigRoost
    dw BreedFamilyRules000 ; id 118 StubBird
    dw BreedFamilyRules077 ; id 119 LandOwl
    dw BreedFamilyRules078 ; id 120 MadGoose
    dw BreedFamilyRules079 ; id 121 MadCondor
    dw BreedFamilyRules07A ; id 122 Emyu
    dw BreedFamilyRules000 ; id 123 Blizzardy
    dw BreedFamilyRules07C ; id 124 Phoenix
    dw BreedFamilyRules000 ; id 125 ZapBird
    dw BreedFamilyRules07E ; id 126 Garudian
    dw BreedFamilyRules000 ; id 127 WhipBird
    dw BreedFamilyRules000 ; id 128 FunkyBird
    dw BreedFamilyRules081 ; id 129 RainHawk
    dw BreedFamilyRules000 ; id 130 Azurile
    dw BreedFamilyRules083 ; id 131 Shantak
    dw BreedFamilyRules000 ; id 132 CragDevil
    dw BreedFamilyRules000 ; id 133 ?
    dw BreedFamilyRules000 ; id 134 ?
    dw BreedFamilyRules000 ; id 135 ?
    dw BreedFamilyRules000 ; id 136 ?
    dw BreedFamilyRules000 ; id 137 ?
    dw BreedFamilyRules000 ; id 138 ?
    dw BreedFamilyRules000 ; id 139 ?
    dw BreedFamilyRules000 ; id 140 ?
    dw BreedFamilyRules08D ; id 141 MadPlant
    dw BreedFamilyRules000 ; id 142 FireWeed
    dw BreedFamilyRules000 ; id 143 FloraMan
    dw BreedFamilyRules000 ; id 144 WingTree
    dw BreedFamilyRules000 ; id 145 CactiBall
    dw BreedFamilyRules000 ; id 146 Gulpple
    dw BreedFamilyRules000 ; id 147 Toadstool
    dw BreedFamilyRules094 ; id 148 AmberWeed
    dw BreedFamilyRules000 ; id 149 Slurperon
    dw BreedFamilyRules096 ; id 150 Stubsuck
    dw BreedFamilyRules000 ; id 151 Oniono
    dw BreedFamilyRules000 ; id 152 DanceVegi
    dw BreedFamilyRules000 ; id 153 TreeBoy
    dw BreedFamilyRules000 ; id 154 Devipine
    dw BreedFamilyRules000 ; id 155 FaceTree
    dw BreedFamilyRules09C ; id 156 HerbMan
    dw BreedFamilyRules000 ; id 157 BeanMan
    dw BreedFamilyRules000 ; id 158 EvilSeed
    dw BreedFamilyRules000 ; id 159 ManEater
    dw BreedFamilyRules000 ; id 160 Snapper
    dw BreedFamilyRules000 ; id 161 GhosTree
    dw BreedFamilyRules000 ; id 162 Rosevine
    dw BreedFamilyRules000 ; id 163 Egdracil
    dw BreedFamilyRules000 ; id 164 Warubou
    dw BreedFamilyRules000 ; id 165 Watabou
    dw BreedFamilyRules0A6 ; id 166 Eggplaton
    dw BreedFamilyRules000 ; id 167 FooHero
    dw BreedFamilyRules000 ; id 168 ?
    dw BreedFamilyRules000 ; id 169 ?
    dw BreedFamilyRules000 ; id 170 ?
    dw BreedFamilyRules000 ; id 171 ?
    dw BreedFamilyRules000 ; id 172 ?
    dw BreedFamilyRules000 ; id 173 ?
    dw BreedFamilyRules000 ; id 174 ?
    dw BreedFamilyRules000 ; id 175 ?
    dw BreedFamilyRules0B0 ; id 176 GiantSlug
    dw BreedFamilyRules000 ; id 177 Catapila
    dw BreedFamilyRules000 ; id 178 Gophecada
    dw BreedFamilyRules0B3 ; id 179 Butterfly
    dw BreedFamilyRules0B4 ; id 180 WeedBug
    dw BreedFamilyRules0B5 ; id 181 GiantWorm
    dw BreedFamilyRules0B6 ; id 182 Lipsy
    dw BreedFamilyRules000 ; id 183 StagBug
    dw BreedFamilyRules0B8 ; id 184 Pyuro
    dw BreedFamilyRules000 ; id 185 ArmyAnt
    dw BreedFamilyRules000 ; id 186 GoHopper
    dw BreedFamilyRules0BB ; id 187 TailEater
    dw BreedFamilyRules0BC ; id 188 ArmorPede
    dw BreedFamilyRules0BD ; id 189 Eyeder
    dw BreedFamilyRules000 ; id 190 GiantMoth
    dw BreedFamilyRules0BF ; id 191 Droll
    dw BreedFamilyRules000 ; id 192 ArmyCrab
    dw BreedFamilyRules0C1 ; id 193 MadHornet
    dw BreedFamilyRules000 ; id 194 Belzebub
    dw BreedFamilyRules0C3 ; id 195 WarMantis
    dw BreedFamilyRules000 ; id 196 HornBeet
    dw BreedFamilyRules0C5 ; id 197 Sickler
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
    dw BreedFamilyRules0D3 ; id 211 Pixy
    dw BreedFamilyRules0D4 ; id 212 MedusaEye
    dw BreedFamilyRules000 ; id 213 AgDevil
    dw BreedFamilyRules0D6 ; id 214 Demonite
    dw BreedFamilyRules0D7 ; id 215 DarkEye
    dw BreedFamilyRules0D8 ; id 216 EyeBall
    dw BreedFamilyRules0D9 ; id 217 SkulRider
    dw BreedFamilyRules0DA ; id 218 EvilBeast
    dw BreedFamilyRules000 ; id 219 Bubblemon
    dw BreedFamilyRules0DC ; id 220 1EyeClown
    dw BreedFamilyRules0DD ; id 221 Gremlin
    dw BreedFamilyRules0DE ; id 222 ArcDemon
    dw BreedFamilyRules000 ; id 223 Lionex
    dw BreedFamilyRules0E0 ; id 224 GoatHorn
    dw BreedFamilyRules000 ; id 225 Orc
    dw BreedFamilyRules0E2 ; id 226 Ogre
    dw BreedFamilyRules0E3 ; id 227 GateGuard
    dw BreedFamilyRules000 ; id 228 ChopClown
    dw BreedFamilyRules0E5 ; id 229 BossTroll
    dw BreedFamilyRules000 ; id 230 Grendal
    dw BreedFamilyRules000 ; id 231 Akubar
    dw BreedFamilyRules000 ; id 232 MadKnight
    dw BreedFamilyRules000 ; id 233 EvilWell
    dw BreedFamilyRules000 ; id 234 Gigantes
    dw BreedFamilyRules0EB ; id 235 Centasaur
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
    dw BreedFamilyRules0F6 ; id 246 Spooky
    dw BreedFamilyRules0F7 ; id 247 Skullgon
    dw BreedFamilyRules000 ; id 248 PutrePup
    dw BreedFamilyRules0F9 ; id 249 RotRaven
    dw BreedFamilyRules000 ; id 250 Mummy
    dw BreedFamilyRules0FB ; id 251 DarkCrab
    dw BreedFamilyRules0FC ; id 252 DeadNite
    dw BreedFamilyRules000 ; id 253 Shadow
    dw BreedFamilyRules0FE ; id 254 Skulpent
    dw BreedFamilyRules0FF ; id 255 Hork
    dw BreedFamilyRules100 ; id 256 Mudron
    dw BreedFamilyRules101 ; id 257 NiteWhip
    dw BreedFamilyRules000 ; id 258 WindMerge
    dw BreedFamilyRules000 ; id 259 Reaper
    dw BreedFamilyRules000 ; id 260 Inverzon
    dw BreedFamilyRules105 ; id 261 FoxFire
    dw BreedFamilyRules000 ; id 262 CaptDead
    dw BreedFamilyRules107 ; id 263 DeadNoble
    dw BreedFamilyRules108 ; id 264 WhiteKing
    dw BreedFamilyRules109 ; id 265 BoneSlave
    dw BreedFamilyRules10A ; id 266 Skeletor
    dw BreedFamilyRules000 ; id 267 Servant
    dw BreedFamilyRules000 ; id 268 Lazamanus
    dw BreedFamilyRules000 ; id 269 Copycat
    dw BreedFamilyRules10E ; id 270 MadSpirit
    dw BreedFamilyRules10F ; id 271 PomPomBom
    dw BreedFamilyRules000 ; id 272 Niterich
    dw BreedFamilyRules000 ; id 273 ?
    dw BreedFamilyRules000 ; id 274 ?
    dw BreedFamilyRules000 ; id 275 ?
    dw BreedFamilyRules000 ; id 276 ?
    dw BreedFamilyRules000 ; id 277 ?
    dw BreedFamilyRules000 ; id 278 ?
    dw BreedFamilyRules000 ; id 279 ?
    dw BreedFamilyRules000 ; id 280 ?
    dw BreedFamilyRules119 ; id 281 JewelBag
    dw BreedFamilyRules000 ; id 282 EvilWand
    dw BreedFamilyRules000 ; id 283 MadCandle
    dw BreedFamilyRules000 ; id 284 CoilBird
    dw BreedFamilyRules000 ; id 285 Facer
    dw BreedFamilyRules000 ; id 286 SpikyBoy
    dw BreedFamilyRules000 ; id 287 MadMirror
    dw BreedFamilyRules120 ; id 288 RogueNite
    dw BreedFamilyRules121 ; id 289 Puppetor
    dw BreedFamilyRules000 ; id 290 Goopi
    dw BreedFamilyRules000 ; id 291 Voodoll
    dw BreedFamilyRules000 ; id 292 MetalDrak
    dw BreedFamilyRules000 ; id 293 Balzak
    dw BreedFamilyRules000 ; id 294 SabreMan
    dw BreedFamilyRules000 ; id 295 CurseLamp
    dw BreedFamilyRules000 ; id 296 Brushead
    dw BreedFamilyRules129 ; id 297 Roboster
    dw BreedFamilyRules12A ; id 298 Roboster2
    dw BreedFamilyRules000 ; id 299 EvilPot
    dw BreedFamilyRules12C ; id 300 Gismo
    dw BreedFamilyRules12D ; id 301 LavaMan
    dw BreedFamilyRules12E ; id 302 IceMan
    dw BreedFamilyRules000 ; id 303 Mimic
    dw BreedFamilyRules000 ; id 304 Exaucers
    dw BreedFamilyRules000 ; id 305 MudDoll
    dw BreedFamilyRules000 ; id 306 Golem
    dw BreedFamilyRules000 ; id 307 StoneMan
    dw BreedFamilyRules000 ; id 308 BombCrag
    dw BreedFamilyRules000 ; id 309 GoldGolem
    dw BreedFamilyRules136 ; id 310 DarkMate
    dw BreedFamilyRules000 ; id 311 ProtoMech
    dw BreedFamilyRules000 ; id 312 CloudKing
    dw BreedFamilyRules000 ; id 313 ?
    dw BreedFamilyRules000 ; id 314 ?
    dw BreedFamilyRules000 ; id 315 ?
    dw BreedFamilyRules13C ; id 316 Petiteel
    dw BreedFamilyRules000 ; id 317 Moray
    dw BreedFamilyRules000 ; id 318 WalrusMan
    dw BreedFamilyRules000 ; id 319 RayGigas
    dw BreedFamilyRules000 ; id 320 Anemon
    dw BreedFamilyRules141 ; id 321 Aquarella
    dw BreedFamilyRules000 ; id 322 Merman
    dw BreedFamilyRules000 ; id 323 Octokid
    dw BreedFamilyRules000 ; id 324 PutreFish
    dw BreedFamilyRules145 ; id 325 Octoreach
    dw BreedFamilyRules146 ; id 326 Angleron
    dw BreedFamilyRules000 ; id 327 FishRider
    dw BreedFamilyRules000 ; id 328 RushFish
    dw BreedFamilyRules149 ; id 329 Gamanian
    dw BreedFamilyRules14A ; id 330 Clawster
    dw BreedFamilyRules000 ; id 331 CancerMan
    dw BreedFamilyRules14C ; id 332 RogueWave
    dw BreedFamilyRules000 ; id 333 Scallopa
    dw BreedFamilyRules000 ; id 334 SeaHorse
    dw BreedFamilyRules14F ; id 335 HoodSquid
    dw BreedFamilyRules000 ; id 336 MerTiger
    dw BreedFamilyRules000 ; id 337 AxeShark
    dw BreedFamilyRules152 ; id 338 Octogon
    dw BreedFamilyRules153 ; id 339 KingSquid
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
BreedFamilyRules004::
    db $02, $ff ; id 0

; list for entry $0B (Healer) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules00B::
    db $fe, $07, $ff ; id 0

; list for entry $15 (MimeSlime) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules015::
    db $07, $ff ; id 0

; list for entry $1A (WonderEgg) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules01A::
    db $04, $06, $03, $ff ; id 0

; list for entry $27 (Gasgon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules027::
    db $02, $ff ; id 0

; list for entry $47 (Tonguella) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules047::
    db $00, $ff ; id 0

; list for entry $48 (Almiraj) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules048::
    db $01, $ff ; id 0

; list for entry $49 (CatFly) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules049::
    db $03, $ff ; id 0

; list for entry $4B (Saccer) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules04B::
    db $01, $ff ; id 0

; list for entry $4C (GulpBeast) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules04C::
    db $00, $ff ; id 0

; list for entry $51 (SuperTen) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules051::
    db $01, $ff ; id 0

; list for entry $55 (Grizzly) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules055::
    db $01, $06, $00, $ff ; id 0

; list for entry $56 (Yeti) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules056::
    db $01, $00, $ff ; id 0

; list for entry $5D (Goategon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules05D::
    db $00, $ff ; id 0

; list for entry $5E (WildApe) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules05E::
    db $00, $ff ; id 0

; list for entry $5F (Trumpeter) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules05F::
    db $01, $00, $ff ; id 0

; list for entry $61 (DarkHorn) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules061::
    db $0a, $ff ; id 0

; list for entry $63 (BigEye) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules063::
    db $01, $ff ; id 0

; list for entry $65 (CatMage) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules065::
    db $06, $ff ; id 0

; list for entry $66 (Dumbira) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules066::
    db $01, $00, $ff ; id 0

; list for entry $6A (Picky) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules06A::
    db $00, $ff ; id 0

; list for entry $6B (Wyvern) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules06B::
    db $01, $07, $ff ; id 0

; list for entry $6C (BullBird) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules06C::
    db $06, $ff ; id 0

; list for entry $6E (DuckKite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules06E::
    db $08, $ff ; id 0

; list for entry $74 (KiteHawk) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules074::
    db $02, $ff ; id 0

; list for entry $75 (BigRoost) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules075::
    db $02, $ff ; id 0

; list for entry $77 (LandOwl) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules077::
    db $01, $07, $06, $ff ; id 0

; list for entry $78 (MadGoose) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules078::
    db $02, $ff ; id 0

; list for entry $79 (MadCondor) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules079::
    db $01, $07, $ff ; id 0

; list for entry $7A (Emyu) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules07A::
    db $02, $ff ; id 0

; list for entry $7C (Phoenix) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules07C::
    db $01, $07, $ff ; id 0

; list for entry $7E (Garudian) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules07E::
    db $00, $ff ; id 0

; list for entry $81 (RainHawk) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules081::
    db $0a, $ff ; id 0

; list for entry $83 (Shantak) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules083::
    db $0a, $ff ; id 0

; list for entry $8D (MadPlant) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules08D::
    db $02, $ff ; id 0

; list for entry $94 (AmberWeed) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules094::
    db $02, $ff ; id 0

; list for entry $96 (Stubsuck) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules096::
    db $07, $ff ; id 0

; list for entry $9C (HerbMan) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules09C::
    db $01, $ff ; id 0

; list for entry $A6 (Eggplaton) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0A6::
    db $06, $07, $ff ; id 0

; list for entry $B0 (GiantSlug) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0B0::
    db $00, $ff ; id 0

; list for entry $B3 (Butterfly) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0B3::
    db $06, $ff ; id 0

; list for entry $B4 (WeedBug) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0B4::
    db $04, $ff ; id 0

; list for entry $B5 (GiantWorm) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0B5::
    db $08, $ff ; id 0

; list for entry $B6 (Lipsy) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0B6::
    db $00, $ff ; id 0

; list for entry $B8 (Pyuro) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0B8::
    db $07, $ff ; id 0

; list for entry $BB (TailEater) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0BB::
    db $06, $ff ; id 0

; list for entry $BC (ArmorPede) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0BC::
    db $06, $ff ; id 0

; list for entry $BD (Eyeder) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0BD::
    db $07, $ff ; id 0

; list for entry $BF (Droll) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0BF::
    db $01, $07, $ff ; id 0

; list for entry $C1 (MadHornet) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0C1::
    db $07, $ff ; id 0

; list for entry $C3 (WarMantis) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0C3::
    db $06, $00, $ff ; id 0

; list for entry $C5 (Sickler) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0C5::
    db $06, $ff ; id 0

; list for entry $D3 (Pixy) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0D3::
    db $00, $ff ; id 0

; list for entry $D4 (MedusaEye) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0D4::
    db $01, $02, $07, $ff ; id 0

; list for entry $D6 (Demonite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0D6::
    db $00, $ff ; id 0

; list for entry $D7 (DarkEye) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0D7::
    db $07, $ff ; id 0

; list for entry $D8 (EyeBall) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0D8::
    db $00, $ff ; id 0

; list for entry $D9 (SkulRider) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0D9::
    db $01, $02, $07, $ff ; id 0

; list for entry $DA (EvilBeast) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0DA::
    db $01, $02, $07, $ff ; id 0

; list for entry $DC (1EyeClown) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0DC::
    db $07, $ff ; id 0

; list for entry $DD (Gremlin) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0DD::
    db $01, $07, $02, $ff ; id 0

; list for entry $DE (ArcDemon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0DE::
    db $07, $02, $01, $08, $ff ; id 0

; list for entry $E0 (GoatHorn) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0E0::
    db $02, $ff ; id 0

; list for entry $E2 (Ogre) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0E2::
    db $01, $07, $02, $08, $ff ; id 0

; list for entry $E3 (GateGuard) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0E3::
    db $01, $02, $08, $ff ; id 0

; list for entry $E5 (BossTroll) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0E5::
    db $02, $ff ; id 0

; list for entry $EB (Centasaur) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0EB::
    db $0a, $ff ; id 0

; list for entry $F6 (Spooky) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0F6::
    db $06, $02, $ff ; id 0

; list for entry $F7 (Skullgon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0F7::
    db $01, $03, $ff ; id 0

; list for entry $F9 (RotRaven) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0F9::
    db $03, $ff ; id 0

; list for entry $FB (DarkCrab) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0FB::
    db $06, $ff ; id 0

; list for entry $FC (DeadNite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules0FC::
    db $09, $03, $ff ; id 0

; list for entry $FE (Skulpent) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0FE::
    db $01, $06, $ff ; id 0

; list for entry $FF (Hork) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules0FF::
    db $06, $ff ; id 0

; list for entry $100 (Mudron) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules100::
    db $03, $ff ; id 0

; list for entry $101 (NiteWhip) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules101::
    db $02, $ff ; id 0

; list for entry $105 (FoxFire) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules105::
    db $02, $ff ; id 0

; list for entry $107 (DeadNoble) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules107::
    db $01, $03, $ff ; id 0

; list for entry $108 (WhiteKing) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules108::
    db $01, $06, $ff ; id 0

; list for entry $109 (BoneSlave) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules109::
    db $01, $09, $03, $ff ; id 0

; list for entry $10A (Skeletor) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules10A::
    db $01, $03, $ff ; id 0

; list for entry $10E (MadSpirit) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules10E::
    db $06, $01, $ff ; id 0

; list for entry $10F (PomPomBom) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules10F::
    db $03, $ff ; id 0

; list for entry $119 (JewelBag) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules119::
    db $08, $ff ; id 0

; list for entry $120 (RogueNite) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules120::
    db $06, $ff ; id 0

; list for entry $121 (Puppetor) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules121::
    db $06, $ff ; id 0

; list for entry $129 (Roboster) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules129::
    db $00, $01, $03, $07, $05, $ff ; id 0

; list for entry $12A (Roboster2) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules12A::
    db $00, $01, $03, $ff ; id 0

; list for entry $12C (Gismo) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules12C::
    db $06, $ff ; id 0

; list for entry $12D (LavaMan) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules12D::
    db $06, $ff ; id 0

; list for entry $12E (IceMan) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules12E::
    db $06, $ff ; id 0

; list for entry $136 (DarkMate) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules136::
    db $05, $ff ; id 0

; list for entry $13C (Petiteel) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules13C::
    db $02, $08, $01, $06, $ff ; id 0

; list for entry $141 (Aquarella) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules141::
    db $05, $ff ; id 0

; list for entry $145 (Octoreach) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules145::
    db $00, $ff ; id 0

; list for entry $146 (Angleron) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules146::
    db $01, $ff ; id 0

; list for entry $149 (Gamanian) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules149::
    db $06, $ff ; id 0

; list for entry $14A (Clawster) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules14A::
    db $06, $ff ; id 0

; list for entry $14C (RogueWave) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules14C::
    db $06, $ff ; id 0

; list for entry $14F (HoodSquid) of BreedFamilyRuleTable; it runs to the next list (E-0199)
; record: partner families, then $FF
BreedFamilyRules14F::
    db $00, $ff ; id 0

; list for entry $152 (Octogon) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules152::
    db $00, $0a, $ff ; id 0

; list for entry $153 (KingSquid) of BreedFamilyRuleTable; it runs to the next list (E-0199)
BreedFamilyRules153::
    db $00, $ff ; id 0

; stage 2 result lists, indexed by parent A's species (E-0199, C1)
; record: list
BreedFamilyResultTable::
    dw BreedFamilyResults000 ; id 0
    dw BreedFamilyResults001 ; id 1 DrakSlime
    dw BreedFamilyResults001 ; id 2 SpotSlime
    dw BreedFamilyResults001 ; id 3 WingSlime
    dw BreedFamilyResults001 ; id 4 TreeSlime
    dw BreedFamilyResults005 ; id 5 Snaily
    dw BreedFamilyResults005 ; id 6 SlimeNite
    dw BreedFamilyResults005 ; id 7 Babble
    dw BreedFamilyResults005 ; id 8 BoxSlime
    dw BreedFamilyResults005 ; id 9 PearlGel
    dw BreedFamilyResults005 ; id 10 Slime
    dw BreedFamilyResults005 ; id 11 Healer
    dw BreedFamilyResults00C ; id 12 FangSlime
    dw BreedFamilyResults00C ; id 13 RockSlime
    dw BreedFamilyResults00C ; id 14 SlimeBorg
    dw BreedFamilyResults00C ; id 15 Slabbit
    dw BreedFamilyResults00C ; id 16 KingSlime
    dw BreedFamilyResults00C ; id 17 Metaly
    dw BreedFamilyResults00C ; id 18 Metabble
    dw BreedFamilyResults00C ; id 19 SpotKing
    dw BreedFamilyResults00C ; id 20 TropicGel
    dw BreedFamilyResults00C ; id 21 MimeSlime
    dw BreedFamilyResults016 ; id 22 HaloSlime
    dw BreedFamilyResults016 ; id 23 MetalKing
    dw BreedFamilyResults016 ; id 24 GoldSlime
    dw BreedFamilyResults016 ; id 25 GranSlime
    dw BreedFamilyResults016 ; id 26 WonderEgg
    dw BreedFamilyResults01B ; id 27 Butch
    dw BreedFamilyResults01B ; id 28 ?
    dw BreedFamilyResults01B ; id 29 ?
    dw BreedFamilyResults01B ; id 30 ?
    dw BreedFamilyResults01B ; id 31 ?
    dw BreedFamilyResults01B ; id 32 ?
    dw BreedFamilyResults01B ; id 33 ?
    dw BreedFamilyResults01B ; id 34 ?
    dw BreedFamilyResults01B ; id 35 ?
    dw BreedFamilyResults01B ; id 36 DragonKid
    dw BreedFamilyResults01B ; id 37 Tortragon
    dw BreedFamilyResults01B ; id 38 Pteranod
    dw BreedFamilyResults01B ; id 39 Gasgon
    dw BreedFamilyResults028 ; id 40 FairyDrak
    dw BreedFamilyResults028 ; id 41 LizardMan
    dw BreedFamilyResults028 ; id 42 Poisongon
    dw BreedFamilyResults028 ; id 43 Swordgon
    dw BreedFamilyResults028 ; id 44 Drygon
    dw BreedFamilyResults028 ; id 45 Dragon
    dw BreedFamilyResults028 ; id 46 MiniDrak
    dw BreedFamilyResults028 ; id 47 MadDragon
    dw BreedFamilyResults028 ; id 48 Rayburn
    dw BreedFamilyResults028 ; id 49 Chamelgon
    dw BreedFamilyResults028 ; id 50 LizardFly
    dw BreedFamilyResults028 ; id 51 Andreal
    dw BreedFamilyResults028 ; id 52 KingCobra
    dw BreedFamilyResults028 ; id 53 Vampirus
    dw BreedFamilyResults028 ; id 54 SnakeBat
    dw BreedFamilyResults028 ; id 55 Spikerous
    dw BreedFamilyResults028 ; id 56 GreatDrak
    dw BreedFamilyResults028 ; id 57 Crestpent
    dw BreedFamilyResults028 ; id 58 WingSnake
    dw BreedFamilyResults028 ; id 59 Coatol
    dw BreedFamilyResults028 ; id 60 Orochi
    dw BreedFamilyResults028 ; id 61 BattleRex
    dw BreedFamilyResults028 ; id 62 SkyDragon
    dw BreedFamilyResults028 ; id 63 Serpentia
    dw BreedFamilyResults028 ; id 64 Divinegon
    dw BreedFamilyResults028 ; id 65 Orligon
    dw BreedFamilyResults028 ; id 66 GigaDraco
    dw BreedFamilyResults028 ; id 67 ?
    dw BreedFamilyResults028 ; id 68 ?
    dw BreedFamilyResults028 ; id 69 ?
    dw BreedFamilyResults028 ; id 70 ?
    dw BreedFamilyResults028 ; id 71 Tonguella
    dw BreedFamilyResults048 ; id 72 Almiraj
    dw BreedFamilyResults049 ; id 73 CatFly
    dw BreedFamilyResults04A ; id 74 PillowRat
    dw BreedFamilyResults04A ; id 75 Saccer
    dw BreedFamilyResults04C ; id 76 GulpBeast
    dw BreedFamilyResults04D ; id 77 Skullroo
    dw BreedFamilyResults04D ; id 78 WindBeast
    dw BreedFamilyResults04D ; id 79 Beavern
    dw BreedFamilyResults04D ; id 80 Antbear
    dw BreedFamilyResults04D ; id 81 SuperTen
    dw BreedFamilyResults052 ; id 82 IronTurt
    dw BreedFamilyResults052 ; id 83 Mommonja
    dw BreedFamilyResults052 ; id 84 HammerMan
    dw BreedFamilyResults052 ; id 85 Grizzly
    dw BreedFamilyResults056 ; id 86 Yeti
    dw BreedFamilyResults057 ; id 87 ArrowDog
    dw BreedFamilyResults057 ; id 88 NoctoKing
    dw BreedFamilyResults057 ; id 89 BeastNite
    dw BreedFamilyResults057 ; id 90 MadGopher
    dw BreedFamilyResults057 ; id 91 FairyRat
    dw BreedFamilyResults057 ; id 92 Unicorn
    dw BreedFamilyResults057 ; id 93 Goategon
    dw BreedFamilyResults05E ; id 94 WildApe
    dw BreedFamilyResults05F ; id 95 Trumpeter
    dw BreedFamilyResults060 ; id 96 KingLeo
    dw BreedFamilyResults060 ; id 97 DarkHorn
    dw BreedFamilyResults062 ; id 98 MadCat
    dw BreedFamilyResults062 ; id 99 BigEye
    dw BreedFamilyResults064 ; id 100 Gorago
    dw BreedFamilyResults064 ; id 101 CatMage
    dw BreedFamilyResults066 ; id 102 Dumbira
    dw BreedFamilyResults067 ; id 103 ?
    dw BreedFamilyResults067 ; id 104 ?
    dw BreedFamilyResults067 ; id 105 ?
    dw BreedFamilyResults067 ; id 106 Picky
    dw BreedFamilyResults06B ; id 107 Wyvern
    dw BreedFamilyResults06C ; id 108 BullBird
    dw BreedFamilyResults06D ; id 109 Florajay
    dw BreedFamilyResults06D ; id 110 DuckKite
    dw BreedFamilyResults06F ; id 111 MadPecker
    dw BreedFamilyResults06F ; id 112 MadRaven
    dw BreedFamilyResults06F ; id 113 MistyWing
    dw BreedFamilyResults06F ; id 114 AquaHawk
    dw BreedFamilyResults06F ; id 115 Dracky
    dw BreedFamilyResults06F ; id 116 KiteHawk
    dw BreedFamilyResults075 ; id 117 BigRoost
    dw BreedFamilyResults076 ; id 118 StubBird
    dw BreedFamilyResults076 ; id 119 LandOwl
    dw BreedFamilyResults078 ; id 120 MadGoose
    dw BreedFamilyResults079 ; id 121 MadCondor
    dw BreedFamilyResults07A ; id 122 Emyu
    dw BreedFamilyResults07B ; id 123 Blizzardy
    dw BreedFamilyResults07B ; id 124 Phoenix
    dw BreedFamilyResults07D ; id 125 ZapBird
    dw BreedFamilyResults07D ; id 126 Garudian
    dw BreedFamilyResults07F ; id 127 WhipBird
    dw BreedFamilyResults07F ; id 128 FunkyBird
    dw BreedFamilyResults07F ; id 129 RainHawk
    dw BreedFamilyResults082 ; id 130 Azurile
    dw BreedFamilyResults082 ; id 131 Shantak
    dw BreedFamilyResults084 ; id 132 CragDevil
    dw BreedFamilyResults084 ; id 133 ?
    dw BreedFamilyResults084 ; id 134 ?
    dw BreedFamilyResults084 ; id 135 ?
    dw BreedFamilyResults084 ; id 136 ?
    dw BreedFamilyResults084 ; id 137 ?
    dw BreedFamilyResults084 ; id 138 ?
    dw BreedFamilyResults084 ; id 139 ?
    dw BreedFamilyResults084 ; id 140 ?
    dw BreedFamilyResults084 ; id 141 MadPlant
    dw BreedFamilyResults08E ; id 142 FireWeed
    dw BreedFamilyResults08E ; id 143 FloraMan
    dw BreedFamilyResults08E ; id 144 WingTree
    dw BreedFamilyResults08E ; id 145 CactiBall
    dw BreedFamilyResults08E ; id 146 Gulpple
    dw BreedFamilyResults08E ; id 147 Toadstool
    dw BreedFamilyResults08E ; id 148 AmberWeed
    dw BreedFamilyResults095 ; id 149 Slurperon
    dw BreedFamilyResults095 ; id 150 Stubsuck
    dw BreedFamilyResults097 ; id 151 Oniono
    dw BreedFamilyResults097 ; id 152 DanceVegi
    dw BreedFamilyResults097 ; id 153 TreeBoy
    dw BreedFamilyResults097 ; id 154 Devipine
    dw BreedFamilyResults097 ; id 155 FaceTree
    dw BreedFamilyResults097 ; id 156 HerbMan
    dw BreedFamilyResults09D ; id 157 BeanMan
    dw BreedFamilyResults09D ; id 158 EvilSeed
    dw BreedFamilyResults09D ; id 159 ManEater
    dw BreedFamilyResults09D ; id 160 Snapper
    dw BreedFamilyResults09D ; id 161 GhosTree
    dw BreedFamilyResults09D ; id 162 Rosevine
    dw BreedFamilyResults09D ; id 163 Egdracil
    dw BreedFamilyResults09D ; id 164 Warubou
    dw BreedFamilyResults09D ; id 165 Watabou
    dw BreedFamilyResults09D ; id 166 Eggplaton
    dw BreedFamilyResults0A7 ; id 167 FooHero
    dw BreedFamilyResults0A7 ; id 168 ?
    dw BreedFamilyResults0A7 ; id 169 ?
    dw BreedFamilyResults0A7 ; id 170 ?
    dw BreedFamilyResults0A7 ; id 171 ?
    dw BreedFamilyResults0A7 ; id 172 ?
    dw BreedFamilyResults0A7 ; id 173 ?
    dw BreedFamilyResults0A7 ; id 174 ?
    dw BreedFamilyResults0A7 ; id 175 ?
    dw BreedFamilyResults0A7 ; id 176 GiantSlug
    dw BreedFamilyResults0B1 ; id 177 Catapila
    dw BreedFamilyResults0B1 ; id 178 Gophecada
    dw BreedFamilyResults0B1 ; id 179 Butterfly
    dw BreedFamilyResults0B4 ; id 180 WeedBug
    dw BreedFamilyResults0B5 ; id 181 GiantWorm
    dw BreedFamilyResults0B6 ; id 182 Lipsy
    dw BreedFamilyResults0B7 ; id 183 StagBug
    dw BreedFamilyResults0B7 ; id 184 Pyuro
    dw BreedFamilyResults0B9 ; id 185 ArmyAnt
    dw BreedFamilyResults0B9 ; id 186 GoHopper
    dw BreedFamilyResults0B9 ; id 187 TailEater
    dw BreedFamilyResults0BC ; id 188 ArmorPede
    dw BreedFamilyResults0BD ; id 189 Eyeder
    dw BreedFamilyResults0BE ; id 190 GiantMoth
    dw BreedFamilyResults0BE ; id 191 Droll
    dw BreedFamilyResults0C0 ; id 192 ArmyCrab
    dw BreedFamilyResults0C0 ; id 193 MadHornet
    dw BreedFamilyResults0C2 ; id 194 Belzebub
    dw BreedFamilyResults0C2 ; id 195 WarMantis
    dw BreedFamilyResults0C4 ; id 196 HornBeet
    dw BreedFamilyResults0C4 ; id 197 Sickler
    dw BreedFamilyResults0C6 ; id 198 Armorpion
    dw BreedFamilyResults0C6 ; id 199 Digster
    dw BreedFamilyResults0C6 ; id 200 Skularach
    dw BreedFamilyResults0C6 ; id 201 MultiEyes
    dw BreedFamilyResults0C6 ; id 202 ?
    dw BreedFamilyResults0C6 ; id 203 ?
    dw BreedFamilyResults0C6 ; id 204 ?
    dw BreedFamilyResults0C6 ; id 205 ?
    dw BreedFamilyResults0C6 ; id 206 ?
    dw BreedFamilyResults0C6 ; id 207 ?
    dw BreedFamilyResults0C6 ; id 208 ?
    dw BreedFamilyResults0C6 ; id 209 ?
    dw BreedFamilyResults0C6 ; id 210 ?
    dw BreedFamilyResults0C6 ; id 211 Pixy
    dw BreedFamilyResults0D4 ; id 212 MedusaEye
    dw BreedFamilyResults0D5 ; id 213 AgDevil
    dw BreedFamilyResults0D5 ; id 214 Demonite
    dw BreedFamilyResults0D7 ; id 215 DarkEye
    dw BreedFamilyResults0D8 ; id 216 EyeBall
    dw BreedFamilyResults0D9 ; id 217 SkulRider
    dw BreedFamilyResults0DA ; id 218 EvilBeast
    dw BreedFamilyResults0DB ; id 219 Bubblemon
    dw BreedFamilyResults0DB ; id 220 1EyeClown
    dw BreedFamilyResults0DD ; id 221 Gremlin
    dw BreedFamilyResults0DE ; id 222 ArcDemon
    dw BreedFamilyResults0DF ; id 223 Lionex
    dw BreedFamilyResults0DF ; id 224 GoatHorn
    dw BreedFamilyResults0E1 ; id 225 Orc
    dw BreedFamilyResults0E1 ; id 226 Ogre
    dw BreedFamilyResults0E3 ; id 227 GateGuard
    dw BreedFamilyResults0E4 ; id 228 ChopClown
    dw BreedFamilyResults0E4 ; id 229 BossTroll
    dw BreedFamilyResults0E6 ; id 230 Grendal
    dw BreedFamilyResults0E6 ; id 231 Akubar
    dw BreedFamilyResults0E6 ; id 232 MadKnight
    dw BreedFamilyResults0E6 ; id 233 EvilWell
    dw BreedFamilyResults0E6 ; id 234 Gigantes
    dw BreedFamilyResults0E6 ; id 235 Centasaur
    dw BreedFamilyResults0EC ; id 236 EvilArmor
    dw BreedFamilyResults0EC ; id 237 Jamirus
    dw BreedFamilyResults0EC ; id 238 Durran
    dw BreedFamilyResults0EC ; id 239 Titanis
    dw BreedFamilyResults0EC ; id 240 LampGenie
    dw BreedFamilyResults0EC ; id 241 ?
    dw BreedFamilyResults0EC ; id 242 ?
    dw BreedFamilyResults0EC ; id 243 ?
    dw BreedFamilyResults0EC ; id 244 ?
    dw BreedFamilyResults0EC ; id 245 ?
    dw BreedFamilyResults0EC ; id 246 Spooky
    dw BreedFamilyResults0F7 ; id 247 Skullgon
    dw BreedFamilyResults0F8 ; id 248 PutrePup
    dw BreedFamilyResults0F8 ; id 249 RotRaven
    dw BreedFamilyResults0FA ; id 250 Mummy
    dw BreedFamilyResults0FA ; id 251 DarkCrab
    dw BreedFamilyResults0FC ; id 252 DeadNite
    dw BreedFamilyResults0FD ; id 253 Shadow
    dw BreedFamilyResults0FD ; id 254 Skulpent
    dw BreedFamilyResults0FF ; id 255 Hork
    dw BreedFamilyResults100 ; id 256 Mudron
    dw BreedFamilyResults101 ; id 257 NiteWhip
    dw BreedFamilyResults102 ; id 258 WindMerge
    dw BreedFamilyResults102 ; id 259 Reaper
    dw BreedFamilyResults102 ; id 260 Inverzon
    dw BreedFamilyResults102 ; id 261 FoxFire
    dw BreedFamilyResults106 ; id 262 CaptDead
    dw BreedFamilyResults106 ; id 263 DeadNoble
    dw BreedFamilyResults108 ; id 264 WhiteKing
    dw BreedFamilyResults109 ; id 265 BoneSlave
    dw BreedFamilyResults10A ; id 266 Skeletor
    dw BreedFamilyResults10B ; id 267 Servant
    dw BreedFamilyResults10B ; id 268 Lazamanus
    dw BreedFamilyResults10B ; id 269 Copycat
    dw BreedFamilyResults10B ; id 270 MadSpirit
    dw BreedFamilyResults10F ; id 271 PomPomBom
    dw BreedFamilyResults110 ; id 272 Niterich
    dw BreedFamilyResults110 ; id 273 ?
    dw BreedFamilyResults110 ; id 274 ?
    dw BreedFamilyResults110 ; id 275 ?
    dw BreedFamilyResults110 ; id 276 ?
    dw BreedFamilyResults110 ; id 277 ?
    dw BreedFamilyResults110 ; id 278 ?
    dw BreedFamilyResults110 ; id 279 ?
    dw BreedFamilyResults110 ; id 280 ?
    dw BreedFamilyResults110 ; id 281 JewelBag
    dw BreedFamilyResults11A ; id 282 EvilWand
    dw BreedFamilyResults11A ; id 283 MadCandle
    dw BreedFamilyResults11A ; id 284 CoilBird
    dw BreedFamilyResults11A ; id 285 Facer
    dw BreedFamilyResults11A ; id 286 SpikyBoy
    dw BreedFamilyResults11A ; id 287 MadMirror
    dw BreedFamilyResults11A ; id 288 RogueNite
    dw BreedFamilyResults121 ; id 289 Puppetor
    dw BreedFamilyResults122 ; id 290 Goopi
    dw BreedFamilyResults122 ; id 291 Voodoll
    dw BreedFamilyResults122 ; id 292 MetalDrak
    dw BreedFamilyResults122 ; id 293 Balzak
    dw BreedFamilyResults122 ; id 294 SabreMan
    dw BreedFamilyResults122 ; id 295 CurseLamp
    dw BreedFamilyResults122 ; id 296 Brushead
    dw BreedFamilyResults122 ; id 297 Roboster
    dw BreedFamilyResults12A ; id 298 Roboster2
    dw BreedFamilyResults12B ; id 299 EvilPot
    dw BreedFamilyResults12B ; id 300 Gismo
    dw BreedFamilyResults12D ; id 301 LavaMan
    dw BreedFamilyResults12E ; id 302 IceMan
    dw BreedFamilyResults12F ; id 303 Mimic
    dw BreedFamilyResults12F ; id 304 Exaucers
    dw BreedFamilyResults12F ; id 305 MudDoll
    dw BreedFamilyResults12F ; id 306 Golem
    dw BreedFamilyResults12F ; id 307 StoneMan
    dw BreedFamilyResults12F ; id 308 BombCrag
    dw BreedFamilyResults12F ; id 309 GoldGolem
    dw BreedFamilyResults12F ; id 310 DarkMate
    dw BreedFamilyResults137 ; id 311 ProtoMech
    dw BreedFamilyResults137 ; id 312 CloudKing
    dw BreedFamilyResults137 ; id 313 ?
    dw BreedFamilyResults137 ; id 314 ?
    dw BreedFamilyResults137 ; id 315 ?
    dw BreedFamilyResults137 ; id 316 Petiteel
    dw BreedFamilyResults13D ; id 317 Moray
    dw BreedFamilyResults13D ; id 318 WalrusMan
    dw BreedFamilyResults13D ; id 319 RayGigas
    dw BreedFamilyResults13D ; id 320 Anemon
    dw BreedFamilyResults13D ; id 321 Aquarella
    dw BreedFamilyResults142 ; id 322 Merman
    dw BreedFamilyResults142 ; id 323 Octokid
    dw BreedFamilyResults142 ; id 324 PutreFish
    dw BreedFamilyResults142 ; id 325 Octoreach
    dw BreedFamilyResults146 ; id 326 Angleron
    dw BreedFamilyResults147 ; id 327 FishRider
    dw BreedFamilyResults147 ; id 328 RushFish
    dw BreedFamilyResults147 ; id 329 Gamanian
    dw BreedFamilyResults14A ; id 330 Clawster
    dw BreedFamilyResults14B ; id 331 CancerMan
    dw BreedFamilyResults14B ; id 332 RogueWave
    dw BreedFamilyResults14D ; id 333 Scallopa
    dw BreedFamilyResults14D ; id 334 SeaHorse
    dw BreedFamilyResults14D ; id 335 HoodSquid
    dw BreedFamilyResults150 ; id 336 MerTiger
    dw BreedFamilyResults150 ; id 337 AxeShark
    dw BreedFamilyResults150 ; id 338 Octogon
    dw BreedFamilyResults153 ; id 339 KingSquid
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
BreedFamilyResults001::
    dw MONSTER_TROPICGEL ; id 0

; list for entry $05 (Snaily) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults005::
    dw MONSTER_HALOSLIME ; id 0

; list for entry $0C (FangSlime) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults00C::
    dw MONSTER_HALOSLIME ; id 0

; list for entry $16 (HaloSlime) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults016::
    dw MONSTER_TROPICGEL ; id 0
    dw MONSTER_MIMESLIME ; id 1
    dw MONSTER_HALOSLIME ; id 2

; list for entry $1B (Butch) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults01B::
    dw MONSTER_MADDRAGON ; id 0

; list for entry $28 (FairyDrak) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults028::
    dw MONSTER_UNICORN ; id 0

; list for entry $48 (Almiraj) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults048::
    dw MONSTER_WILDAPE ; id 0

; list for entry $49 (CatFly) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults049::
    dw MONSTER_WINDBEAST ; id 0

; list for entry $4A (PillowRat) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults04A::
    dw MONSTER_ANTBEAR ; id 0

; list for entry $4C (GulpBeast) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults04C::
    dw MONSTER_UNICORN ; id 0

; list for entry $4D (Skullroo) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults04D::
    dw MONSTER_TRUMPETER ; id 0

; list for entry $52 (IronTurt) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults052::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_GULPBEAST ; id 1
    dw MONSTER_UNICORN ; id 2

; list for entry $56 (Yeti) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults056::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_UNICORN ; id 1

; list for entry $57 (ArrowDog) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults057::
    dw MONSTER_UNICORN ; id 0

; list for entry $5E (WildApe) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults05E::
    dw MONSTER_UNICORN ; id 0

; list for entry $5F (Trumpeter) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults05F::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_UNICORN ; id 1

; list for entry $60 (KingLeo) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults060::
    dw MONSTER_GORAGO ; id 0

; list for entry $62 (MadCat) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults062::
    dw MONSTER_GULPBEAST ; id 0

; list for entry $64 (Gorago) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults064::
    dw MONSTER_BEASTNITE ; id 0

; list for entry $66 (Dumbira) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults066::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_SUPERTEN ; id 1

; list for entry $67 (?) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults067::
    dw MONSTER_DRACKY ; id 0

; list for entry $6B (Wyvern) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults06B::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1

; list for entry $6C (BullBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults06C::
    dw MONSTER_LANDOWL ; id 0

; list for entry $6D (Florajay) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults06D::
    dw MONSTER_KITEHAWK ; id 0

; list for entry $6F (MadPecker) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults06F::
    dw MONSTER_EMYU ; id 0

; list for entry $75 (BigRoost) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults075::
    dw MONSTER_CRAGDEVIL ; id 0

; list for entry $76 (StubBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults076::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1
    dw MONSTER_MADCONDOR ; id 2

; list for entry $78 (MadGoose) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults078::
    dw MONSTER_CRAGDEVIL ; id 0

; list for entry $79 (MadCondor) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults079::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1

; list for entry $7A (Emyu) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults07A::
    dw MONSTER_CRAGDEVIL ; id 0

; list for entry $7B (Blizzardy) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults07B::
    dw MONSTER_MADGOOSE ; id 0
    dw MONSTER_MADGOOSE ; id 1

; list for entry $7D (ZapBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults07D::
    dw MONSTER_LANDOWL ; id 0

; list for entry $7F (WhipBird) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults07F::
    dw MONSTER_AZURILE ; id 0

; list for entry $82 (Azurile) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults082::
    dw MONSTER_AZURILE ; id 0

; list for entry $84 (CragDevil) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults084::
    dw MONSTER_DANCEVEGI ; id 0

; list for entry $8E (FireWeed) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults08E::
    dw MONSTER_STUBSUCK ; id 0

; list for entry $95 (Slurperon) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults095::
    dw MONSTER_GHOSTREE ; id 0

; list for entry $97 (Oniono) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults097::
    dw MONSTER_FACETREE ; id 0

; list for entry $9D (BeanMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults09D::
    dw MONSTER_BEANMAN ; id 0
    dw MONSTER_EVILSEED ; id 1

; list for entry $A7 (FooHero) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0A7::
    dw MONSTER_ARMYANT ; id 0

; list for entry $B1 (Catapila) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0B1::
    dw MONSTER_GIANTMOTH ; id 0

; list for entry $B4 (WeedBug) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0B4::
    dw MONSTER_TAILEATER ; id 0

; list for entry $B5 (GiantWorm) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0B5::
    dw MONSTER_ARMORPEDE ; id 0

; list for entry $B6 (Lipsy) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0B6::
    dw MONSTER_DROLL ; id 0

; list for entry $B7 (StagBug) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0B7::
    dw MONSTER_MADHORNET ; id 0

; list for entry $B9 (ArmyAnt) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0B9::
    dw MONSTER_MULTIEYES ; id 0

; list for entry $BC (ArmorPede) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0BC::
    dw MONSTER_HORNBEET ; id 0

; list for entry $BD (Eyeder) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0BD::
    dw MONSTER_MADHORNET ; id 0

; list for entry $BE (GiantMoth) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0BE::
    dw MONSTER_ARMORPEDE ; id 0
    dw MONSTER_MADHORNET ; id 1

; list for entry $C0 (ArmyCrab) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0C0::
    dw MONSTER_BELZEBUB ; id 0

; list for entry $C2 (Belzebub) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0C2::
    dw MONSTER_HORNBEET ; id 0
    dw MONSTER_SICKLER ; id 1

; list for entry $C4 (HornBeet) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0C4::
    dw MONSTER_WARMANTIS ; id 0

; list for entry $C6 (Armorpion) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0C6::
    dw MONSTER_1EYECLOWN ; id 0

; list for entry $D4 (MedusaEye) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0D4::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_GRENDAL ; id 1
    dw MONSTER_GIGANTES ; id 2

; list for entry $D5 (AgDevil) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0D5::
    dw MONSTER_1EYECLOWN ; id 0

; list for entry $D7 (DarkEye) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0D7::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $D8 (EyeBall) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0D8::
    dw MONSTER_1EYECLOWN ; id 0

; list for entry $D9 (SkulRider) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0D9::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_GRENDAL ; id 1
    dw MONSTER_GIGANTES ; id 2

; list for entry $DA (EvilBeast) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0DA::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_GRENDAL ; id 1
    dw MONSTER_GIGANTES ; id 2

; list for entry $DB (Bubblemon) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0DB::
    dw MONSTER_MEDUSAEYE ; id 0

; list for entry $DD (Gremlin) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0DD::
    dw MONSTER_AGDEVIL ; id 0
    dw MONSTER_MEDUSAEYE ; id 1
    dw MONSTER_GRENDAL ; id 2

; list for entry $DE (ArcDemon) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0DE::
    dw MONSTER_LIONEX ; id 0
    dw MONSTER_GOATHORN ; id 1
    dw MONSTER_CENTASAUR ; id 2
    dw MONSTER_EVILARMOR ; id 3

; list for entry $DF (Lionex) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0DF::
    dw MONSTER_BOSSTROLL ; id 0

; list for entry $E1 (Orc) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0E1::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_GATEGUARD ; id 1
    dw MONSTER_CENTASAUR ; id 2
    dw MONSTER_EVILARMOR ; id 3

; list for entry $E3 (GateGuard) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0E3::
    dw MONSTER_OGRE ; id 0
    dw MONSTER_CENTASAUR ; id 1
    dw MONSTER_EVILARMOR ; id 2

; list for entry $E4 (ChopClown) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0E4::
    dw MONSTER_CENTASAUR ; id 0

; list for entry $E6 (Grendal) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0E6::
    dw MONSTER_LAMPGENIE ; id 0

; list for entry $EC (EvilArmor) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0EC::
    dw MONSTER_REAPER ; id 0
    dw MONSTER_HORK ; id 1

; list for entry $F7 (Skullgon) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0F7::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $F8 (PutrePup) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0F8::
    dw MONSTER_WINDMERGE ; id 0

; list for entry $FA (Mummy) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0FA::
    dw MONSTER_NITEWHIP ; id 0

; list for entry $FC (DeadNite) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults0FC::
    dw MONSTER_SKULPENT ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $FD (Shadow) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0FD::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_DEADNITE ; id 1

; list for entry $FF (Hork) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults0FF::
    dw MONSTER_REAPER ; id 0

; list for entry $100 (Mudron) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults100::
    dw MONSTER_MADSPIRIT ; id 0

; list for entry $101 (NiteWhip) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults101::
    dw MONSTER_FOXFIRE ; id 0

; list for entry $102 (WindMerge) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults102::
    dw MONSTER_POMPOMBOM ; id 0

; list for entry $106 (CaptDead) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults106::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $108 (WhiteKing) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults108::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_SERVANT ; id 1

; list for entry $109 (BoneSlave) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults109::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_CAPTDEAD ; id 1
    dw MONSTER_MADSPIRIT ; id 2

; list for entry $10A (Skeletor) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults10A::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_MADSPIRIT ; id 1

; list for entry $10B (Servant) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults10B::
    dw MONSTER_NITEWHIP ; id 0
    dw MONSTER_SKELETOR ; id 1

; list for entry $10F (PomPomBom) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults10F::
    dw MONSTER_MADSPIRIT ; id 0

; list for entry $110 (Niterich) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults110::
    dw MONSTER_GOOPI ; id 0

; list for entry $11A (EvilWand) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults11A::
    dw MONSTER_PROTOMECH ; id 0

; list for entry $121 (Puppetor) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults121::
    dw MONSTER_VOODOLL ; id 0

; list for entry $122 (Goopi) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults122::
    dw MONSTER_PROTOMECH ; id 0
    dw MONSTER_METALDRAK ; id 1
    dw MONSTER_CURSELAMP ; id 2
    dw MONSTER_MIMIC ; id 3
    dw MONSTER_BOMBCRAG ; id 4

; list for entry $12A (Roboster2) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults12A::
    dw MONSTER_PROTOMECH ; id 0
    dw MONSTER_METALDRAK ; id 1
    dw MONSTER_CURSELAMP ; id 2

; list for entry $12B (EvilPot) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults12B::
    dw MONSTER_EVILPOT ; id 0

; list for entry $12D (LavaMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults12D::
    dw MONSTER_BALZAK ; id 0

; list for entry $12E (IceMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults12E::
    dw MONSTER_BALZAK ; id 0

; list for entry $12F (Mimic) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults12F::
    dw MONSTER_BOMBCRAG ; id 0

; list for entry $137 (ProtoMech) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults137::
    dw MONSTER_OCTOREACH ; id 0
    dw MONSTER_ANGLERON ; id 1
    dw MONSTER_SEAHORSE ; id 2
    dw MONSTER_SEAHORSE ; id 3

; list for entry $13D (Moray) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults13D::
    dw MONSTER_GAMANIAN ; id 0

; list for entry $142 (Merman) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults142::
    dw MONSTER_STARFISH ; id 0

; list for entry $146 (Angleron) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults146::
    dw MONSTER_RUSHFISH ; id 0

; list for entry $147 (FishRider) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults147::
    dw MONSTER_CLAWSTER ; id 0

; list for entry $14A (Clawster) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults14A::
    dw MONSTER_CANCERMAN ; id 0

; list for entry $14B (CancerMan) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults14B::
    dw MONSTER_SCALLOPA ; id 0

; list for entry $14D (Scallopa) of BreedFamilyResultTable; it runs to the next list (E-0199)
; record: child species
BreedFamilyResults14D::
    dw MONSTER_STARFISH ; id 0

; list for entry $150 (MerTiger) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults150::
    dw MONSTER_STARFISH ; id 0
    dw MONSTER_KINGSQUID ; id 1

; list for entry $153 (KingSquid) of BreedFamilyResultTable; it runs to the next list (E-0199)
BreedFamilyResults153::
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
; $FF), otherwise the child's species; 11 rows of 11 words end at Script_0E_7F8B) C2 from E-0328 for
; rows 4 (plant) x columns 3 and 5: base Gulpple with a Dracky mate gives WingTree and with a
; family-5 mate CactiBall in the game's own breeding.
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
Script_0E_7F8B::
    script_command SCRIPT_NPC_BREED
    script_message_by_screen $c003 ; screen 0: '*: Its accessory is in the'
Script_0E_7F8F::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7F99, Script_0E_7F93
Script_0E_7F93::
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $8002 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0E_7F99::
    script_message_by_screen $c005 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
Script_0E_7F9D::
    script_choice_jump Script_0E_7FA8, Script_0E_7FAC, Script_0E_7FA1
Script_0E_7FA1::
    script_message_by_screen $c004 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
    script_jump Script_0E_7F8F
Script_0E_7FA8::
    script_command SCRIPT_NPC_BREED
    script_jump Script_0E_7F9D
Script_0E_7FAC::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FC1, Script_0E_7FB7, Script_0E_7FB1
Script_0E_7FB1::
    script_message_by_screen $c006 ; screen 0: '*: Its accessory is in the'
    script_jump Script_0E_7FBA
Script_0E_7FB7::
    script_message_by_screen $c007 ; screen 0: '*: Its accessory is in the'
Script_0E_7FBA::
    script_message_by_screen $c003 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
    script_jump Script_0E_7F8F
Script_0E_7FC1::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FC5, Script_0E_7FC8
Script_0E_7FC5::
    script_jump Script_0E_7FCB
Script_0E_7FC8::
    script_message_by_screen $c00c ; screen 0: '*: Is it OK to save'
Script_0E_7FCB::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FD5, Script_0E_7FCF
Script_0E_7FCF::
    script_message_by_screen $c008 ; screen 0: '*: Its accessory is in the'
    script_jump Script_0E_7FD8
Script_0E_7FD5::
    script_message_by_screen $c00b ; screen 0: '*: Its accessory is in the'
Script_0E_7FD8::
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FE2, Script_0E_7FDC
Script_0E_7FDC::
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $8002 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0E_7FE2::
    script_command SCRIPT_NPC_BREED
    script_message_by_screen $c009 ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_NPC_BREED
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $000a ; screen 0: '*: Its accessory is in the'
    script_command SCRIPT_MENU_CLOSE
    script_end
    ds $13, $00
