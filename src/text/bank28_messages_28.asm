; ROM bank $28: messages
; The annotated listing of this bank is build/listing/bank28.asm.

SECTION "Bank 28", ROMX[$4000], BANK[$28]
    db $28

; if wStringIndex < $DA, BeginStringDisplay with this bank's table; otherwise far-calls
; BeginStringDisplay_Bank28_Overflow (E-0353)
BeginStringDisplay_Bank28::
    ld a, [wStringIndex]
    cp $da
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank28_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank28
    call BeginStringDisplay
    ret

; message bank $28: when wStringIndex < $DA, CopyStringToBuffer with this bank's table
; MessageStrings_Bank28; otherwise far-calls CopyStringToBuffer_Bank28_Overflow (E-0080)
CopyStringToBuffer_Bank28::
    ld a, [wStringIndex]
    cp $da
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank28_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank28
    call CopyStringToBuffer
    ret

; BeginStringDisplay_Bank28 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0353)
ShowString_Bank28::
    call BeginStringDisplay_Bank28
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_28::
; data read by BeginStringDisplay_Bank28 (1 word) (E-0347)
MessageStrings_Bank28::
    dw StringList_Bank28_0 ; id 0

; category list of StringCategories_28; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank28_0::
    dw Message_00_00 ; id 0
    dw Message_00_01 ; id 1
    dw Message_00_02 ; id 2
    dw Message_00_03 ; id 3
    dw Message_00_04 ; id 4
    dw Message_00_05 ; id 5
    dw Message_00_06 ; id 6
    dw Message_00_07 ; id 7
    dw Message_00_08 ; id 8
    dw Message_00_09 ; id 9
    dw Message_00_0A ; id 10
    dw Message_00_0B ; id 11
    dw Message_00_0C ; id 12
    dw Message_00_0D ; id 13
    dw Message_00_0E ; id 14
    dw Message_00_0F ; id 15
    dw Message_00_10 ; id 16
    dw Message_00_11 ; id 17
    dw Message_00_12 ; id 18
    dw Message_00_13 ; id 19
    dw Message_00_14 ; id 20
    dw Message_00_15 ; id 21
    dw Message_00_16 ; id 22
    dw Message_00_17 ; id 23
    dw Message_00_18 ; id 24
    dw Message_00_19 ; id 25
    dw Message_00_1A ; id 26
    dw Message_00_1B ; id 27
    dw Message_00_1C ; id 28
    dw Message_00_1D ; id 29
    dw Message_00_1E ; id 30
    dw Message_00_1F ; id 31
    dw Message_00_20 ; id 32
    dw Message_00_21 ; id 33
    dw Message_00_22 ; id 34
    dw Message_00_23 ; id 35
    dw Message_00_24 ; id 36
    dw Message_00_25 ; id 37
    dw Message_00_26 ; id 38
    dw Message_00_27 ; id 39
    dw Message_00_28 ; id 40
    dw Message_00_29 ; id 41
    dw Message_00_2A ; id 42
    dw Message_00_2B ; id 43
    dw Message_00_2C ; id 44
    dw Message_00_2D ; id 45
    dw Message_00_2E ; id 46
    dw Message_00_2F ; id 47
    dw Message_00_30 ; id 48
    dw Message_00_31 ; id 49
    dw Message_00_32 ; id 50
    dw Message_00_33 ; id 51
    dw Message_00_34 ; id 52
    dw Message_00_35 ; id 53
    dw Message_00_36 ; id 54
    dw Message_00_37 ; id 55
    dw Message_00_38 ; id 56
    dw Message_00_39 ; id 57
    dw Message_00_3A ; id 58
    dw Message_00_3B ; id 59
    dw Message_00_3C ; id 60
    dw Message_00_3D ; id 61
    dw Message_00_3E ; id 62
    dw Message_00_3F ; id 63
    dw Message_00_40 ; id 64
    dw Message_00_41 ; id 65
    dw Message_00_42 ; id 66
    dw Message_00_43 ; id 67
    dw Message_00_44 ; id 68
    dw Message_00_45 ; id 69
    dw Message_00_46 ; id 70
    dw Message_00_47 ; id 71
    dw Message_00_48 ; id 72
    dw Message_00_49 ; id 73
    dw Message_00_4A ; id 74
    dw Message_00_4B ; id 75
    dw Message_00_4C ; id 76
    dw Message_00_4D ; id 77
    dw Message_00_4E ; id 78
    dw Message_00_4F ; id 79
    dw Message_00_50 ; id 80
    dw Message_00_51 ; id 81
    dw Message_00_52 ; id 82
    dw Message_00_53 ; id 83
    dw Message_00_54 ; id 84
    dw Message_00_55 ; id 85
    dw Message_00_56 ; id 86
    dw Message_00_56 ; id 87
    dw Message_00_56 ; id 88
    dw Message_00_59 ; id 89
    dw Message_00_5A ; id 90
    dw Message_00_5B ; id 91
    dw Message_00_5C ; id 92
    dw Message_00_5D ; id 93
    dw Message_00_5E ; id 94
    dw Message_00_5F ; id 95
    dw Message_00_60 ; id 96
    dw Message_00_61 ; id 97
    dw Message_00_62 ; id 98
    dw Message_00_63 ; id 99
    dw Message_00_64 ; id 100
    dw Message_00_65 ; id 101
    dw Message_00_66 ; id 102
    dw Message_00_67 ; id 103
    dw Message_00_68 ; id 104
    dw Message_00_69 ; id 105
    dw Message_00_6A ; id 106
    dw Message_00_6B ; id 107
    dw Message_00_6C ; id 108
    dw Message_00_6D ; id 109
    dw Message_00_6E ; id 110
    dw Message_00_6F ; id 111
    dw Message_00_70 ; id 112
    dw Message_00_71 ; id 113
    dw Message_00_72 ; id 114
    dw Message_00_73 ; id 115
    dw Message_00_74 ; id 116
    dw Message_00_75 ; id 117
    dw Message_00_76 ; id 118
    dw Message_00_77 ; id 119
    dw Message_00_78 ; id 120
    dw Message_00_79 ; id 121
    dw Message_00_7A ; id 122
    dw Message_00_7B ; id 123
    dw Message_00_7C ; id 124
    dw Message_00_7D ; id 125
    dw Message_00_7E ; id 126
    dw Message_00_7F ; id 127
    dw Message_00_80 ; id 128
    dw Message_00_81 ; id 129
    dw Message_00_82 ; id 130
    dw Message_00_83 ; id 131
    dw Message_00_84 ; id 132
    dw Message_00_85 ; id 133
    dw Message_00_86 ; id 134
    dw Message_00_87 ; id 135
    dw Message_00_88 ; id 136
    dw Message_00_89 ; id 137
    dw Message_00_8A ; id 138
    dw Message_00_8B ; id 139
    dw Message_00_8C ; id 140
    dw Message_00_8D ; id 141
    dw Message_00_8E ; id 142
    dw Message_00_8F ; id 143
    dw Message_00_90 ; id 144
    dw Message_00_91 ; id 145
    dw Message_00_92 ; id 146
    dw Message_00_93 ; id 147
    dw Message_00_94 ; id 148
    dw Message_00_95 ; id 149
    dw Message_00_96 ; id 150
    dw Message_00_97 ; id 151
    dw Message_00_98 ; id 152
    dw Message_00_99 ; id 153
    dw Message_00_9A ; id 154
    dw Message_00_9B ; id 155
    dw Message_00_9B ; id 156
    dw Message_00_9B ; id 157
    dw Message_00_9B ; id 158
    dw Message_00_9B ; id 159
    dw Message_00_9B ; id 160
    dw Message_00_A1 ; id 161
    dw Message_00_A2 ; id 162
    dw Message_00_A3 ; id 163
    dw Message_00_A4 ; id 164
    dw Message_00_A5 ; id 165
    dw Message_00_A6 ; id 166
    dw Message_00_A7 ; id 167
    dw Message_00_A8 ; id 168
    dw Message_00_A9 ; id 169
    dw Message_00_AA ; id 170
    dw Message_00_AB ; id 171
    dw Message_00_AC ; id 172
    dw Message_00_AC ; id 173
    dw Message_00_AC ; id 174
    dw Message_00_AC ; id 175
    dw Message_00_AC ; id 176
    dw Message_00_AC ; id 177
    dw Message_00_AC ; id 178
    dw Message_00_AC ; id 179
    dw Message_00_AC ; id 180
    dw Message_00_AC ; id 181
    dw Message_00_AC ; id 182
    dw Message_00_AC ; id 183
    dw Message_00_AC ; id 184
    dw Message_00_AC ; id 185
    dw Message_00_AC ; id 186
    dw Message_00_AC ; id 187
    dw Message_00_AC ; id 188
    dw Message_00_AC ; id 189
    dw Message_00_AC ; id 190
    dw Message_00_AC ; id 191
    dw Message_00_AC ; id 192
    dw Message_00_AC ; id 193
    dw Message_00_AC ; id 194
    dw Message_00_AC ; id 195
    dw Message_00_AC ; id 196
    dw Message_00_AC ; id 197
    dw Message_00_AC ; id 198
    dw Message_00_AC ; id 199
    dw Message_00_AC ; id 200
    dw Message_00_AC ; id 201
    dw Message_00_AC ; id 202
    dw Message_00_AC ; id 203
    dw Message_00_AC ; id 204
    dw Message_00_AC ; id 205
    dw Message_00_AC ; id 206
    dw Message_00_AC ; id 207
    dw Message_00_AC ; id 208
    dw Message_00_D1 ; id 209
    dw Message_00_D2 ; id 210
    dw Message_00_D3 ; id 211
    dw Message_00_D4 ; id 212
    dw Message_00_D5 ; id 213
    dw Message_00_D6 ; id 214
    dw Message_00_D7 ; id 215
    dw Message_00_D8 ; id 216
    dw Message_00_D9 ; id 217

Message_00_00::
    db "In the middle of<LINE>"
    db "the sea in the<PROMPT>"
    db "<NEXT>south floats the"
    db "<NEXT>island GreatLog.<PROMPT>"
    db "<NEXT>To this eternally"
    db "<NEXT>warm and natural<PROMPT>"
    db "<NEXT>setting, a family"
    db "<NEXT>of monster farmers<PROMPT>"
    db "<NEXT>was headed to"
    db "<NEXT>start a new life…<WAIT>"
    db "@"

Message_00_01::
    db "<VOICE1>Cobi: <BUF0>!<LINE>"
    db "Papa's calling.<PROMPT>"
    db "<NEXT>He's at the stern."
    db "<NEXT>Hustle, hustle!<WAIT>"
    db "@"

Message_00_02::
    db "<VOICE2>Tara: There you<LINE>"
    db "are, big brother!<PROMPT>"
    db "<NEXT>Papa's calling at"
    db "<NEXT>the stern.<PROMPT>"
    db "<NEXT>You", $44, " better go"
    db "<NEXT>right away!<WAIT>"
    db "@"

Message_00_03::
    db "<VOICE1>Cobi: What's wrong,<LINE>"
    db "<BUF0>?<PROMPT>"
    db "<NEXT>Papa's calling for"
    db "<NEXT>you!<WAIT>"
    db "@"

Message_00_04::
    db "<VOICE2>Tara: Hurry! Papa<LINE>"
    db "will be angry!<WAIT>"
    db "@"

Message_00_05::
    db "<VOICE1>*: You folks run a<LINE>"
    db "monster farm?<PROMPT>"
    db "<NEXT>We've never had"
    db "<NEXT>monsters on our<PROMPT>"
    db "<NEXT>ship before this."
    db "<NEXT>It's amazing!<WAIT>"
    db "@"

Message_00_06::
    db "<VOICE1>*: There's a spirit<LINE>"
    db "in GreatLog that's<PROMPT>"
    db "<NEXT>famous for getting"
    db "<NEXT>into mischief.<PROMPT>"
    db "<NEXT>It's named…"
    db "<NEXT>Waru something.<WAIT>"
    db "@"

Message_00_07::
    db "<VOICE1>*: Sailing is sure"
    db "<NEXT>exhilarating. <PROMPT>"
    db "<NEXT>Right?"
    db "<NEXT><CHOICE>"
    db "@"

Message_00_08::
    db "<VOICE1>*: Good. That's<LINE>"
    db "good to hear!<PROMPT>"
    db "<NEXT>You have got"
    db "<NEXT>potential!<WAIT>"
    db "@"

Message_00_09::
    db "<VOICE1>*: Is that so?<LINE>"
    db "Too bad!<PROMPT>"
    db "<NEXT>You'll get used to"
    db "<NEXT>it someday.<WAIT>"
    db "@"

Message_00_0A::
    db "<VOICE2>*: We'll soon be<LINE>"
    db "reaching GreatLog.<PROMPT>"
    db "<NEXT>I wonder, what"
    db "<NEXT>will it be like?<PROMPT>"
    db "<NEXT>Isn't it exciting"
    db "<NEXT>my dear child?<WAIT>"
    db "@"

Message_00_0B::
    db "<VOICE1>*: GreatLog's King<LINE>"
    db "asked us to settle<PROMPT>"
    db "<NEXT>in the kingdom and"
    db "<NEXT>run our farm.<PROMPT>"
    db "<NEXT>He recognizes our"
    db "<NEXT>worth, wahahah!<PROMPT>"
    db "<NEXT>This will be our"
    db "<NEXT>new life.<PROMPT>"
    db "<NEXT>You're a growing"
    db "<NEXT>boy, so I'll need<PROMPT>"
    db "<NEXT>you to be reliable"
    db "<NEXT>and responsible.<PROMPT>"
    db "<NEXT>Do we have an"
    db "<NEXT>understanding?<PROMPT>"
    db "<NEXT>Good. Stay with"
    db "<NEXT>Tara, will you?<WAIT>"
    db "@"

Message_00_0C::
    db "<VOICE1>*: GreatLog's King<LINE>"
    db "asked us to settle<PROMPT>"
    db "<NEXT>in the kingdom and"
    db "<NEXT>run our farm.<PROMPT>"
    db "<NEXT>He recognizes our"
    db "<NEXT>worth, wahahah!<PROMPT>"
    db "<NEXT>This will be our"
    db "<NEXT>new life.<PROMPT>"
    db "<NEXT>You're growing up,"
    db "<NEXT>so you can't be a<PROMPT>"
    db "<NEXT>little baby"
    db "<NEXT>anymore.<PROMPT>"
    db "<NEXT>Do we have an"
    db "<NEXT>understanding?<PROMPT>"
    db "<NEXT>Good. Play with"
    db "<NEXT>Cobi, will you?<WAIT>"
    db "@"

Message_00_0D::
    db "<VOICE1>*: When our farm<LINE>"
    db "gets established<PROMPT>"
    db "<NEXT>in the new land,"
    db "<NEXT>I'll make life<PROMPT>"
    db "<NEXT>easier for mother"
    db "<NEXT>and you two.<PROMPT>"
    db "<NEXT>We should be in"
    db "<NEXT>GreatLog soon.<WAIT>"
    db "@"

Message_00_0E::
    db "<VOICE2>*: Worried about<LINE>"
    db "your monsters?<PROMPT>"
    db "<NEXT>Don't be! They're"
    db "<NEXT>being quiet.<WAIT>"
    db "@"

Message_00_0F::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>clean water.<WAIT>"
    db "@"

Message_00_10::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>Freshly caught"
    db "<NEXT>fish were inside.<WAIT>"
    db "@"

Message_00_11::
    db "<VOICE1>Cobi: <BUF0>!<LINE>"
    db "They said GreatLog<PROMPT>"
    db "<NEXT>will be in sight"
    db "<NEXT>soon.<WAIT>"
    db "@"

Message_00_12::
    db "<VOICE1>*: Land ho!<LINE>"
    db "There's GreatLog!<WAIT>"
    db "@"

Message_00_13::
    db "<VOICE2>Tara: Big brother!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>GreatLog will be"
    db "<NEXT>in sight soon.<WAIT>"
    db "@"

Message_00_14::
    db "This is a tale of<LINE>"
    db "children who came<PROMPT>"
    db "<NEXT>to the Kingdom of"
    db "<NEXT>GreatLog…<WAIT>"
    db "@"

Message_00_15::
    db "<VOICE1>*: Listen you two!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>Quit your horsing"
    db "<NEXT>around and go<PROMPT>"
    db "<NEXT>help your mother."
    db "<NEXT>Do you hear me?<WAIT>"
    db "@"

Message_00_16::
    db "<VOICE1>*: It seems to me<LINE>"
    db "that the people<PROMPT>"
    db "<NEXT>here aren't very"
    db "<NEXT>used to seeing<PROMPT>"
    db "<NEXT>monsters. We'll"
    db "<NEXT>have to make sure<PROMPT>"
    db "<NEXT>that they don't go"
    db "<NEXT>wander off on<PROMPT>"
    db "<NEXT>their own. Anyway,"
    db "<NEXT>go help your<PROMPT>"
    db "<NEXT>mother."
    db "<NEXT><WAIT>"
    db "@"

Message_00_17::
    db "<VOICE1>*: Yo, did you<LINE>"
    db "enjoy the voyage?<PROMPT>"
    db "<NEXT>The name's Slash,"
    db "<NEXT>glad to know you!<PROMPT>"
    db "<NEXT>Slash: I guard the"
    db "<NEXT>farm here.<PROMPT>"
    db "<NEXT>You can consider"
    db "<NEXT>me the boss!<PROMPT>"
    db "<NEXT>If you need any"
    db "<NEXT>advice, I'm here!<WAIT>"
    db "@"

Message_00_18::
    db "<VOICE1>Slash: If you're<LINE>"
    db "in need of advice,<PROMPT>"
    db "<NEXT>think of me!"
    db "<NEXT>I'm the one!<WAIT>"
    db "@"

Message_00_19::
    db "<VOICE1>*: There aren't many<LINE>"
    db "friends here.<PROMPT>"
    db "<NEXT>It's lonely for an"
    db "<NEXT>ant like me…<WAIT>"
    db "@"

Message_00_1A::
    db "<VOICE1>*: I accidentally<LINE>"
    db "went outside.<PROMPT>"
    db "<NEXT>People gave me the"
    db "<NEXT>eye. Whoopsy.<WAIT>"
    db "@"

Message_00_1B::
    db "<VOICE1>*: This hay is<LINE>"
    db "pretty good.<PROMPT>"
    db "<NEXT>Maybe I can use"
    db "<NEXT>this…<WAIT>"
    db "@"

Message_00_1C::
    db "<BUF0> checked the<LINE>"
    db "pump.<PROMPT>"
    db "<NEXT>It's rusted and"
    db "<NEXT>old, but it looks<PROMPT>"
    db "<NEXT>to be in working"
    db "<NEXT>condition.<WAIT>"
    db "@"

Message_00_1D::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It is full of"
    db "<NEXT>dried hay.<WAIT>"
    db "@"

Message_00_1E::
    db "<VOICE2>*: You've come at<LINE>"
    db "the right time.<PROMPT>"
    db "<NEXT>Grandma sent her"
    db "<NEXT>homemade nut pie<PROMPT>"
    db "<NEXT>for us to enjoy at"
    db "<NEXT>our new homestead.<PROMPT>"
    db "<NEXT>I'm too busy to go"
    db "<NEXT>get it right now,<PROMPT>"
    db "<NEXT>so can the two of"
    db "<NEXT>you go instead?<WAIT>"
    db "@"

Message_00_1F::
    db "<VOICE1>Cobi: Sure, Mama!<LINE>"
    db "We'll be fine.<WAIT>"
    db "@"

Message_00_20::
    db "<VOICE2>*: Good, that's<LINE>"
    db "settled then.<PROMPT>"
    db "<NEXT>The Vault is west"
    db "<NEXT>of the Farm.<PROMPT>"
    db "<NEXT>Don't dawdle, and"
    db "<NEXT>be careful.<WAIT>"
    db "@"

Message_00_21::
    db "<VOICE2>Tara: We'll be OK!<LINE>"
    db "I'm going too.<WAIT>"
    db "@"

Message_00_22::
    db "<VOICE2>*: Go to the Vault<LINE>"
    db "and pick up the<PROMPT>"
    db "<NEXT>nut pie that"
    db "<NEXT>Grandma sent.<PROMPT>"
    db "<NEXT>The Vault is west"
    db "<NEXT>of the Farm.<WAIT>"
    db "@"

Message_00_23::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Behavior of Wild"
    db "<NEXT>Monsters…<PROMPT>"
    db "<NEXT>Wild monsters are"
    db "<NEXT>dangerous, but<PROMPT>"
    db "<NEXT>they can be tamed"
    db "<NEXT>and trained.", $95, "<WAIT>"
    db "@"

Message_00_24::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>Children's clothes"
    db "<NEXT>were inside.<WAIT>"
    db "@"

Message_00_25::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>It smelled of sun-"
    db "<NEXT>dried laundry.<WAIT>"
    db "@"

Message_00_26::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>It smelled of"
    db "<NEXT>fresh bread.<WAIT>"
    db "@"

Message_00_27::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was full of"
    db "<NEXT>clear water.<WAIT>"
    db "@"

Message_00_28::
    db "<VOICE1>*: I've heard that<LINE>"
    db "there are monster<PROMPT>"
    db "<NEXT>masters in this"
    db "<NEXT>kingdom.<PROMPT>"
    db "<NEXT>Have I told you"
    db "<NEXT>about them?<CHOICE>"
    db "@"

Message_00_29::
    db "<VOICE1>*: Oh? Well, that's<LINE>"
    db "fine then.<PROMPT>"
    db "<NEXT>Go on, run your"
    db "<NEXT>mother's errand.<WAIT>"
    db "@"

Message_00_2A::
    db "<VOICE1>*: Monster masters<LINE>"
    db "are those people<PROMPT>"
    db "<NEXT>who tame and train"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>They commune with"
    db "<NEXT>them and the<PROMPT>"
    db "<NEXT>monsters grow."
    db "<NEXT><WAIT>"
    db "@"

Message_00_2B::
    db "<VOICE1>Cobi: Hahah! <BUF0><LINE>"
    db "won't last a day!<WAIT>"
    db "@"

Message_00_2C::
    db "<VOICE1>*: I aspired to be<LINE>"
    db "one long ago…<PROMPT>"
    db "<NEXT>Ahem! Go help your"
    db "<NEXT>mother now.<WAIT>"
    db "@"

Message_00_2D::
    db "<VOICE2>Tara: Big brother<LINE>"
    db "can't do it then.<WAIT>"
    db "@"

Message_00_2E::
    db "<VOICE1>*: Go help your<LINE>"
    db "mother now.<WAIT>"
    db "@"

Message_00_2F::
    db "<VOICE1>*: If some monster<LINE>"
    db "masters keep their<PROMPT>"
    db "<NEXT>monsters with us,"
    db "<NEXT>the Farm is sure<PROMPT>"
    db "<NEXT>to become busier"
    db "<NEXT>and lively.<WAIT>"
    db "@"

Message_00_30::
    db "<VOICE1>*: Heh, so these<LINE>"
    db "are the newcomers?<PROMPT>"
    db "<NEXT>Hehehe, this is"
    db "<NEXT>going to be fun…<WAIT>"
    db "@"

Message_00_31::
    db "<VOICE1>*: C'mon, Warubou!<LINE>"
    db "<WAIT>"
    db "@"

Message_00_32::
    db "<VOICE1>*: Hello, there!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You must be the"
    db "<NEXT>farm kids!<PROMPT>"
    db "<NEXT>The Vault is west,"
    db "<NEXT>then a bit north.<WAIT>"
    db "@"

Message_00_33::
    db "<VOICE2>*: Oh… It's… all<LINE>"
    db "spinning around…<PROMPT>"
    db "<NEXT>That rotten little"
    db "<NEXT>Prince and that<PROMPT>"
    db "<NEXT>elemental sidekick"
    db "<NEXT>of his!<WAIT>"
    db "@"

Message_00_34::
    db "<VOICE2>*: The horrid<LINE>"
    db "Prince and that<PROMPT>"
    db "<NEXT>elemental sidekick"
    db "<NEXT>of his!<WAIT>"
    db "@"

Message_00_35::
    db "<VOICE1>*: The King is too<LINE>"
    db "lenient on Prince<PROMPT>"
    db "<NEXT>Kameha, his only"
    db "<NEXT>son.<PROMPT>"
    db "<NEXT>That's why we can't"
    db "<NEXT>complain about all<PROMPT>"
    db "<NEXT>the trouble he"
    db "<NEXT>causes.<WAIT>"
    db "@"

Message_00_36::
    db "<VOICE1>*: There were many<LINE>"
    db "wild monsters in<PROMPT>"
    db "<NEXT>this world in the"
    db "<NEXT>past.<PROMPT>"
    db "<NEXT>The elemental"
    db "<NEXT>spirits decided to<PROMPT>"
    db "<NEXT>send the monsters"
    db "<NEXT>to other worlds<PROMPT>"
    db "<NEXT>until they were"
    db "<NEXT>sure that humans<PROMPT>"
    db "<NEXT>could live safely"
    db "<NEXT>with monsters.<WAIT>"
    db "@"

Message_00_37::
    db "<BUF0> tried to<LINE>"
    db "open the chest.<PROMPT>"
    db "<NEXT>But the chest was"
    db "<NEXT>locked tight.<WAIT>"
    db "@"

Message_00_38::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>A large, salted"
    db "<NEXT>fish was inside.<WAIT>"
    db "@"

Message_00_39::
    db "<VOICE1>*: Hey! You brats!<LINE>"
    db "Scram!<PROMPT>"
    db "<NEXT>Hands off my"
    db "<NEXT>merchandise!<WAIT>"
    db "@"

Message_00_3A::
    db "<VOICE1>*: That weird ape<LINE>"
    db "thing is Warubou,<PROMPT>"
    db "<NEXT>GreatLog's"
    db "<NEXT>elemental spirit.<PROMPT>"
    db "<NEXT>It's always up to"
    db "<NEXT>mischief with<PROMPT>"
    db "<NEXT>Prince Kameha."
    db "<NEXT>What a pair!<WAIT>"
    db "@"

Message_00_3B::
    db "<VOICE2>*: This palm tree<LINE>"
    db "is GreatLog.<PROMPT>"
    db "<NEXT>We've bored out"
    db "<NEXT>the inside of this<PROMPT>"
    db "<NEXT>enormous tree and"
    db "<NEXT>made it our home.<WAIT>"
    db "@"

Message_00_3C::
    db "<VOICE1>*: You're the kids<LINE>"
    db "from the new farm.<PROMPT>"
    db "<NEXT>I'm a monster"
    db "<NEXT>master myself.<PROMPT>"
    db "<NEXT>I'll have to use"
    db "<NEXT>your farm soon.<WAIT>"
    db "@"

Message_00_3D::
    db "<VOICE2>*: We live inside<LINE>"
    db "here.<PROMPT>"
    db "<NEXT>I'm keeping my eyes"
    db "<NEXT>out for Prince<PROMPT>"
    db "<NEXT>Kameha and his"
    db "<NEXT>sidekick.<WAIT>"
    db "@"

Message_00_3E::
    db "<VOICE1>*: GreatLog's major<LINE>"
    db "facilities are<PROMPT>"
    db "<NEXT>situated above"
    db "<NEXT>here.<PROMPT>"
    db "<NEXT>They're no place"
    db "<NEXT>for kids. Shoo!<WAIT>"
    db "@"

Message_00_3F::
    db "<VOICE2>*: Inside the well<LINE>"
    db "is the Log's Navel.<PROMPT>"
    db "<NEXT>It's said to be"
    db "<NEXT>the center of<PROMPT>"
    db "<NEXT>GreatLog."
    db "<NEXT>But it's not safe.<PROMPT>"
    db "<NEXT>Don't go in there."
    db "<NEXT><WAIT>"
    db "@"

Message_00_40::
    db "<VOICE1>*: On this island,<LINE>"
    db "every day goes by<PROMPT>"
    db "<NEXT>without anything"
    db "<NEXT>being different.<PROMPT>"
    db "<NEXT>But it's never"
    db "<NEXT>boring.<PROMPT>"
    db "<NEXT>I consider it"
    db "<NEXT>heavenly luxury!<WAIT>"
    db "@"

Message_00_41::
    db "<VOICE2>*: Warubou is the<LINE>"
    db "island's spirit.<PROMPT>"
    db "<NEXT>So we can't really"
    db "<NEXT>complain about<PROMPT>"
    db "<NEXT>all the mischief"
    db "<NEXT>it gets into…<WAIT>"
    db "@"

Message_00_42::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Danger!"
    db "<NEXT>Stay clear!", $95, "<WAIT>"
    db "@"

Message_00_43::
    db "<BUF0> checked the<LINE>"
    db "odd object.<PROMPT>"
    db "<NEXT>It appears to be"
    db "<NEXT>plugging a hole…<WAIT>"
    db "@"

Message_00_44::
    db "<BUF0> checked the<LINE>"
    db "peculiar door.<PROMPT>"
    db "<NEXT>It has an oddly"
    db "<NEXT>shaped keyhole…<WAIT>"
    db "@"

Message_00_45::
    db "<VOICE1>*: You must be the<LINE>"
    db "farm kids.<PROMPT>"
    db "<NEXT>Your grandma sent"
    db "<NEXT>a package for you.<PROMPT>"
    db "<NEXT>It smells really"
    db "<NEXT>delicious!<PROMPT>"
    db "<NEXT>Here you go! Be"
    db "<NEXT>careful with it!<WAIT>"
    db "@"

Message_00_46::
    db "<VOICE1>*: Thanks for<LINE>"
    db "coming by.<PROMPT>"
    db "<NEXT>I'll always be"
    db "<NEXT>here to serve you!<WAIT>"
    db "@"

Message_00_47::
    db "<BUF0> read the<LINE>"
    db "notice.<PROMPT>"
    db "<NEXT>'We guarantee the"
    db "<NEXT>safekeeping of<PROMPT>"
    db "<NEXT>your precious"
    db "<NEXT>items and money!", $95, "<WAIT>"
    db "@"

Message_00_48::
    db "<VOICE1>*: I'm Prince Kameha"
    db "<NEXT>of GreatLog!<PROMPT>"
    db "<NEXT>You may not pass,"
    db "<NEXT>peasants!<WAIT>"
    db "@"

Message_00_49::
    db "<VOICE1>Kameha: Wahahah!<LINE>"
    db "No going by me!<WAIT>"
    db "@"

Message_00_4A::
    db "<VOICE1>*: I'm Warubou,<LINE>"
    db "GreatLog's spirit!<PROMPT>"
    db "<NEXT>Warooh, wa-hey!"
    db "<NEXT><WAIT>"
    db "@"

Message_00_4B::
    db "<VOICE1>Warubou: It's a<LINE>"
    db "dead end, warooh!<PROMPT>"
    db "<NEXT>Look for another"
    db "<NEXT>way, wa-hey!<WAIT>"
    db "@"

Message_00_4C::
    db "<VOICE1>*: Have you heard<LINE>"
    db "about Magic Keys?<CHOICE>"
    db "@"

Message_00_4D::
    db "<VOICE1>*: Wow, you kids<LINE>"
    db "sure learn quick!<WAIT>"
    db "@"

Message_00_4E::
    db "<VOICE1>*: You need Magic<LINE>"
    db "Keys to open the<PROMPT>"
    db "<NEXT>magical door to"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>That's where I get"
    db "<NEXT>my monsters.<WAIT>"
    db "@"

Message_00_4F::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Give me something!<PROMPT>"
    db "<NEXT>Then, I'll let you"
    db "<NEXT>pass, warooh!<WAIT>"
    db "@"

Message_00_50::
    db "<VOICE1>Warubou: Wha…?<LINE>"
    db "I smell something!<PROMPT>"
    db "<NEXT>I smell something"
    db "<NEXT>tasty.<WAIT>"
    db "@"

Message_00_51::
    db "<VOICE1>Warubou: What is<LINE>"
    db "this? Food?<PROMPT>"
    db "<NEXT>Perfect! I was"
    db "<NEXT>hungry, wa-hey!<WAIT>"
    db "@"

Message_00_52::
    db "<VOICE2>*: Oh my, the well<LINE>"
    db "isn't safe!<PROMPT>"
    db "<NEXT>Don't be like"
    db "<NEXT>Warubou!<WAIT>"
    db "@"

Message_00_53::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "I'm starving!<WAIT>"
    db "@"

Message_00_54::
    db "<VOICE1>Kameha: Gimme it!<LINE>"
    db "You just ate!<PROMPT>"
    db "<NEXT>You grubby little"
    db "<NEXT>elemental!<WAIT>"
    db "@"

Message_00_55::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Some prince!<PROMPT>"
    db "<NEXT>Dirty mouth!"
    db "<NEXT>Come on, warooh!<WAIT>"
    db "@"

Message_00_56::
    db "<VOICE1>Cobi: That's ours!<LINE>"
    db "Give it back!<WAIT>"
    db "@"

Message_00_59::
    db "<VOICE1>Warubou: Wa-wa-wa-<LINE>"
    db "wa-wa-hey!<PROMPT>"
    db "<NEXT>The Log's Navel's"
    db "<NEXT>breached, warooh!<WAIT>"
    db "@"

Message_00_5A::
    db "<VOICE1>Kameha: I… It…<LINE>"
    db "It's not my fault!<WAIT>"
    db "@"

Message_00_5B::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "It's the only way!<WAIT>"
    db "@"

Message_00_5C::
    db "<VOICE1>Warubou: Warooh!<LINE>"
    db "Will it hold?<PROMPT>"
    db "<NEXT>You two, come here"
    db "<NEXT>now, warooh!<WAIT>"
    db "@"

Message_00_5D::
    db "<VOICE1>Warubou: Calm down<LINE>"
    db "and listen!<PROMPT>"
    db "<NEXT>What came out of"
    db "<NEXT>the hole now, that<PROMPT>"
    db "<NEXT>was the life force"
    db "<NEXT>of GreatLog's tree.<PROMPT>"
    db "<NEXT>GreatLog is an"
    db "<NEXT>island kept afloat<PROMPT>"
    db "<NEXT>by the palm tree,"
    db "<NEXT>do you see?<PROMPT>"
    db "<NEXT>If the palm tree"
    db "<NEXT>dies, the island<PROMPT>"
    db "<NEXT>sinks into the"
    db "<NEXT>deep, deep ocean.<PROMPT>"
    db "<NEXT>A plug! That is"
    db "<NEXT>what we need!<PROMPT>"
    db "<NEXT>A plug to plug the"
    db "<NEXT>Log's Navel!<PROMPT>"
    db "<NEXT>Hurry, go fetch a"
    db "<NEXT>monster master!<WAIT>"
    db "@"

Message_00_5E::
    db "<VOICE2>Tara: That's ours!<LINE>"
    db "Give it back!<WAIT>"
    db "@"

Message_00_5F::
    db "<VOICE1>Warubou: A new<LINE>"
    db "plug for the<PROMPT>"
    db "<NEXT>Log's Navel needs"
    db "<NEXT>a monster master<PROMPT>"
    db "<NEXT>to find, yes it"
    db "<NEXT>does, warooh!<PROMPT>"
    db "<NEXT>Quick, fetch a"
    db "<NEXT>monster master!<WAIT>"
    db "@"

Message_00_60::
    db "<VOICE1>*: Hah? The island's<LINE>"
    db "going to sink?<PROMPT>"
    db "<NEXT>You shouldn't lie"
    db "<NEXT>like that <BUF0>.<WAIT>"
    db "@"

Message_00_61::
    db "<VOICE1>Cobi: Why won't you<LINE>"
    db "believe us?<PROMPT>"
    db "<NEXT>You stubborn old"
    db "<NEXT>goat!<WAIT>"
    db "@"

Message_00_62::
    db "<VOICE1>*: Look, an island<LINE>"
    db "just doesn't sink.<PROMPT>"
    db "<NEXT>Listen to yourself"
    db "<NEXT>for a moment.<PROMPT>"
    db "<NEXT>Anyway, did you"
    db "<NEXT>run Mom's errand?<WAIT>"
    db "@"

Message_00_63::
    db "<VOICE2>Tara: Why aren't<LINE>"
    db "you listening?<PROMPT>"
    db "<NEXT>Papa, you're such"
    db "<NEXT>a blockhead!<WAIT>"
    db "@"

Message_00_64::
    db "<VOICE1>*: The island's<LINE>"
    db "sinking, right.<PROMPT>"
    db "<NEXT>Not you too."
    db "<NEXT>Look, I'm busy.<PROMPT>"
    db "<NEXT>Warubou and the"
    db "<NEXT>Prince are just<PROMPT>"
    db "<NEXT>pulling your legs,"
    db "<NEXT>I'm sure of it.<WAIT>"
    db "@"

Message_00_65::
    db "<VOICE1>Slash: The island's<LINE>"
    db "going to sink?<PROMPT>"
    db "<NEXT>That's a genuine"
    db "<NEXT>crisis!<PROMPT>"
    db "<NEXT>I'm right here if"
    db "<NEXT>you need any help!<WAIT>"
    db "@"

Message_00_66::
    db "<VOICE1>*: This island is<LINE>"
    db "going to sink?<PROMPT>"
    db "<NEXT>I… The tide seems"
    db "<NEXT>to be higher!<WAIT>"
    db "@"

Message_00_67::
    db "<VOICE1>*: We're going to<LINE>"
    db "sink?<PROMPT>"
    db "<NEXT>I can't swim!"
    db "<NEXT>What should I do?<WAIT>"
    db "@"

Message_00_68::
    db "<VOICE1>*: Huh? The island<LINE>"
    db "is going to sink?<PROMPT>"
    db "<NEXT>Are you in Prince"
    db "<NEXT>Kameha's gang?<WAIT>"
    db "@"

Message_00_69::
    db "<VOICE1>*: Prince Kameha<LINE>"
    db "was saying the<PROMPT>"
    db "<NEXT>same thing a"
    db "<NEXT>little while ago.<WAIT>"
    db "@"

Message_00_6A::
    db "<VOICE2>*: Did you get<LINE>"
    db "the package<PROMPT>"
    db "<NEXT>from grandma?"
    db "<NEXT><WAIT>"
    db "@"

Message_00_6B::
    db "<VOICE2>*: Oh goodness,<LINE>"
    db "you're filthy!<PROMPT>"
    db "<NEXT>What happened to"
    db "<NEXT>you two?<PROMPT>"
    db "<NEXT>…Giggle… You were"
    db "<NEXT>tricked by that<PROMPT>"
    db "<NEXT>silly Warubou."
    db "<NEXT>Don't worry.<PROMPT>"
    db "<NEXT>The island won't"
    db "<NEXT>sink that easily.<WAIT>"
    db "@"

Message_00_6C::
    db "<VOICE2>*: You can go out,<LINE>"
    db "but not too late!<WAIT>"
    db "@"

Message_00_6D::
    db "<VOICE2>*: The island's"
    db "<NEXT>going to sink?<PROMPT>"
    db "<NEXT>I know, you were"
    db "<NEXT>fooled by Warubou.<PROMPT>"
    db "<NEXT>Last time he was"
    db "<NEXT>yelling about the<PROMPT>"
    db "<NEXT>great King of"
    db "<NEXT>Terror from the<PROMPT>"
    db "<NEXT>sky…"
    db "<NEXT><WAIT>"
    db "@"

Message_00_6E::
    db "<VOICE2>*: The island is<LINE>"
    db "sinking?<PROMPT>"
    db "<NEXT>Prince Kameha put"
    db "<NEXT>you up to this.<WAIT>"
    db "@"

Message_00_6F::
    db "<VOICE2>*: Oh, you kids!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You shouldn't be"
    db "<NEXT>in the well.<PROMPT>"
    db "<NEXT>What? The Log's"
    db "<NEXT>Navel is broken?<PROMPT>"
    db "<NEXT>But why is that"
    db "<NEXT>important?<WAIT>"
    db "@"

Message_00_70::
    db "<VOICE2>*: The island isn't<LINE>"
    db "sinking.<PROMPT>"
    db "<NEXT>If you lie, your"
    db "<NEXT>nose will grow!<WAIT>"
    db "@"

Message_00_71::
    db "<VOICE1>*: Looking for a<LINE>"
    db "monster master?<PROMPT>"
    db "<NEXT>I have no time for"
    db "<NEXT>child's play!<WAIT>"
    db "@"

Message_00_72::
    db "<VOICE1>*: This island is<LINE>"
    db "sinking?<PROMPT>"
    db "<NEXT>If that's true,"
    db "<NEXT>it's a disaster…<PROMPT>"
    db "<NEXT>But I haven't"
    db "<NEXT>heard anything<PROMPT>"
    db "<NEXT>about it!"
    db "<NEXT><WAIT>"
    db "@"

Message_00_73::
    db "<VOICE1>*: Hm? Warubou<LINE>"
    db "wants you to find<PROMPT>"
    db "<NEXT>a monster master"
    db "<NEXT>for him?<PROMPT>"
    db "<NEXT>Well I am one but"
    db "<NEXT>I don't want to<PROMPT>"
    db "<NEXT>have anything to"
    db "<NEXT>do with Warubou.<PROMPT>"
    db "<NEXT>Sorry, but can you"
    db "<NEXT>try someone else?<WAIT>"
    db "@"

Message_00_74::
    db "<VOICE2>*: You're after a<LINE>"
    db "monster master?<PROMPT>"
    db "<NEXT>I saw one lolling"
    db "<NEXT>around the Vault.<WAIT>"
    db "@"

Message_00_75::
    db "<VOICE1>*: The island's<LINE>"
    db "going to sink?<PROMPT>"
    db "<NEXT>Don't spread silly"
    db "<NEXT>rumors like that.<PROMPT>"
    db "<NEXT>What if it scares"
    db "<NEXT>off customers?<WAIT>"
    db "@"

Message_00_76::
    db "<VOICE1>*: The island is<LINE>"
    db "sinking?<PROMPT>"
    db "<NEXT>Hahah, no worries!"
    db "<NEXT>We can all escape<PROMPT>"
    db "<NEXT>to another world."
    db "<NEXT>Wait a sec… How<PROMPT>"
    db "<NEXT>would we get"
    db "<NEXT>there?<WAIT>"
    db "@"

Message_00_77::
    db "<VOICE1>*: The island's<LINE>"
    db "sinking?<PROMPT>"
    db "<NEXT>That's hard to"
    db "<NEXT>believe, but…<PROMPT>"
    db "<NEXT>You don't look like"
    db "<NEXT>a liar…<PROMPT>"
    db "<NEXT>I was going to"
    db "<NEXT>open a shop here,<PROMPT>"
    db "<NEXT>but I guess I'll"
    db "<NEXT>hit the road.<WAIT>"
    db "@"

Message_00_78::
    db "<VOICE1>*: It's pointless<LINE>"
    db "if you're dead.<PROMPT>"
    db "<NEXT>I'm going to leave"
    db "<NEXT>again.<WAIT>"
    db "@"

Message_00_79::
    db "<VOICE1>*: You say the<LINE>"
    db "island will sink?<PROMPT>"
    db "<NEXT>Sorry, but I can't"
    db "<NEXT>believe that.<WAIT>"
    db "@"

Message_00_7A::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Good, you're back.<PROMPT>"
    db "<NEXT>You told everyone"
    db "<NEXT>GreatLog'll sink?<PROMPT>"
    db "<NEXT>So, where is the"
    db "<NEXT>monster master?<PROMPT>"
    db "<NEXT>…What? Nobody"
    db "<NEXT>believed you?<PROMPT>"
    db "<NEXT>Warooh, they are"
    db "<NEXT>so complacent!<PROMPT>"
    db "<NEXT>Wa-hey, it can't"
    db "<NEXT>be helped now.<PROMPT>"
    db "<NEXT>You go instead."
    db "<NEXT>No other way!<WAIT>"
    db "@"

Message_00_7B::
    db "<VOICE1>Warubou: No time<LINE>"
    db "to waste, warooh!<PROMPT>"
    db "<NEXT>If you don't go,"
    db "<NEXT>GreatLog goes to<PROMPT>"
    db "<NEXT>the bottom of the"
    db "<NEXT>sea soon enough!<PROMPT>"
    db "<NEXT>You will go find a"
    db "<NEXT>new plug for the<PROMPT>"
    db "<NEXT>Log's Navel,"
    db "<NEXT>wa-hey?<CHOICE>"
    db "@"

Message_00_7C::
    db "<VOICE1>Warubou: No?<LINE>"
    db "Then find someone!<WAIT>"
    db "@"

Message_00_7D::
    db "<VOICE1>Warubou: Wa-hey?<LINE>"
    db "No one believed!<PROMPT>"
    db "<NEXT>You have to go, no"
    db "<NEXT>choice about it!<WAIT>"
    db "@"

Message_00_7E::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "No more dawdling!<PROMPT>"
    db "<NEXT>GreatLog will sink"
    db "<NEXT>into the sea!<PROMPT>"
    db "<NEXT>You have to go, no"
    db "<NEXT>choice about it!<CHOICE>"
    db "@"

Message_00_7F::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Good, good, good!<PROMPT>"
    db "<NEXT>In you, I saw the"
    db "<NEXT>potential, warooh!<PROMPT>"
    db "<NEXT>A good idea I have"
    db "<NEXT>for plugging up<PROMPT>"
    db "<NEXT>the Log's Navel,"
    db "<NEXT>yes I do, warooh.<PROMPT>"
    db "<NEXT>I'm an elemental"
    db "<NEXT>so I know such!<PROMPT>"
    db "<NEXT>Here, take this,"
    db "<NEXT>you, warooh.<WAIT>"
    db "@"

Message_00_80::
    db "<VOICE1>Warubou: This here<LINE>"
    db "is a Magic Key.<PROMPT>"
    db "<NEXT>It opens the door"
    db "<NEXT>to other worlds.<PROMPT>"
    db "<NEXT>Specially made it"
    db "<NEXT>is, by elemental<PROMPT>"
    db "<NEXT>power, making it"
    db "<NEXT>magic, warooh.<PROMPT>"
    db "<NEXT>Use to open the"
    db "<NEXT>magic door ahead.<PROMPT>"
    db "<NEXT>It takes you to"
    db "<NEXT>another world.<PROMPT>"
    db "<NEXT>Another world, it"
    db "<NEXT>might be, warooh,<PROMPT>"
    db "<NEXT>but it is not much"
    db "<NEXT>different.<PROMPT>"
    db "<NEXT>Only difference is"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>Monsters live in"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>But a monster"
    db "<NEXT>master needs to<PROMPT>"
    db "<NEXT>fear not a thing,"
    db "<NEXT>warooh.<PROMPT>"
    db "<NEXT>I see you have"
    db "<NEXT>great potential.<PROMPT>"
    db "<NEXT>You go to other"
    db "<NEXT>worlds, and bring<PROMPT>"
    db "<NEXT>back a plug for"
    db "<NEXT>the Log's Navel.<PROMPT>"
    db "<NEXT>That something, I"
    db "<NEXT>don't know what.<PROMPT>"
    db "<NEXT>But you will know"
    db "<NEXT>when you find it!<PROMPT>"
    db "<NEXT>Now, warooh, take"
    db "<NEXT>this!<WAIT>"
    db "@"

Message_00_81::
    db "<BUF0> received the<LINE>"
    db "Oasis Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_00_82::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "I trust you! Go!<WAIT>"
    db "@"

Message_00_83::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Forgot something!<WAIT>"
    db "@"

Message_00_84::
    db "<VOICE1>Warubou: This you<LINE>"
    db "use to come back<PROMPT>"
    db "<NEXT>to GreatLog from"
    db "<NEXT>other worlds.<WAIT>"
    db "@"

Message_00_85::
    db "<BUF0> received the<LINE>"
    db "GreatLog Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_00_86::
    db "<VOICE1>Warubou: Dangerous<LINE>"
    db "are other worlds!<PROMPT>"
    db "<NEXT>So you take"
    db "<NEXT>monsters, warooh.<PROMPT>"
    db "<NEXT>Wa-hey, I'm"
    db "<NEXT>GreatLog's spirit.<PROMPT>"
    db "<NEXT>One with the"
    db "<NEXT>island I am.<PROMPT>"
    db "<NEXT>If you can't stop"
    db "<NEXT>the island from<PROMPT>"
    db "<NEXT>sinking, so ends"
    db "<NEXT>my life, warooh.<PROMPT>"
    db "<NEXT>Not just me, but"
    db "<NEXT>everyone here.<PROMPT>"
    db "<NEXT>So, you must!"
    db "<NEXT>Must find a plug!<WAIT>"
    db "@"

Message_00_87::
    db "<VOICE1>Cobi: This is bad.<LINE>"
    db "What'll we do?<PROMPT>"
    db "<NEXT>Let's go home and"
    db "<NEXT>talk about it.<WAIT>"
    db "@"

Message_00_88::
    db "<VOICE2>Tara: Oh, wow.<LINE>"
    db "This is terrible.<PROMPT>"
    db "<NEXT>We should talk"
    db "<NEXT>about it at home.<WAIT>"
    db "@"

Message_00_89::
    db "<VOICE1>Cobi: If we don't<LINE>"
    db "find a plug for<PROMPT>"
    db "<NEXT>the Log's Navel,"
    db "<NEXT>the island sinks.<PROMPT>"
    db "<NEXT>Our house and the"
    db "<NEXT>farm too.<PROMPT>"
    db "<NEXT>We have to go look"
    db "<NEXT>ourselves, right?<WAIT>"
    db "@"

Message_00_8A::
    db "<VOICE1>Cobi: But if we<LINE>"
    db "both go to other<PROMPT>"
    db "<NEXT>worlds, Mama will"
    db "<NEXT>be worried.<WAIT>"
    db "@"

Message_00_8B::
    db "<VOICE1>Cobi: That's true…<LINE>"
    db "If we both went to<PROMPT>"
    db "<NEXT>other worlds, Mama"
    db "<NEXT>would be worried.<WAIT>"
    db "@"

Message_00_8C::
    db "<VOICE1>Slash: Hey, why<LINE>"
    db "the long faces?<PROMPT>"
    db "<NEXT>I couldn't help"
    db "<NEXT>overhearing you.<PROMPT>"
    db "<NEXT>I'll go with you"
    db "<NEXT>to other worlds.<PROMPT>"
    db "<NEXT>That way, one of"
    db "<NEXT>you can stay here.<PROMPT>"
    db "<NEXT>That solves your"
    db "<NEXT>little problem!<WAIT>"
    db "@"

Message_00_8D::
    db "<VOICE1>Cobi: That's true.<LINE>"
    db "What to do…<PROMPT>"
    db "<NEXT>Huh? <BUF0>?"
    db "<NEXT>Do you want to go?<CHOICE>"
    db "@"

Message_00_8E::
    db "<VOICE1>Cobi: Don't waste<LINE>"
    db "your time lying.<PROMPT>"
    db "<NEXT>I can see it in"
    db "<NEXT>your eyes.<PROMPT>"
    db "<NEXT>You really want to"
    db "<NEXT>go, don't you?<CHOICE>"
    db "@"

Message_00_8F::
    db "<VOICE1>Cobi: Fine. But<LINE>"
    db "<BUF0>, by<PROMPT>"
    db "<NEXT>yourself…<WAIT>"
    db "@"

Message_00_90::
    db "<VOICE1>Slash: Don't worry!<LINE>"
    db "I'm riding along!<WAIT>"
    db "@"

Message_00_91::
    db "<VOICE1>Slash: And <BUF0><LINE>"
    db "has potential,<PROMPT>"
    db "<NEXT>I think, to be a"
    db "<NEXT>monster master.<PROMPT>"
    db "<NEXT>We'll need the"
    db "<NEXT>help of monsters<PROMPT>"
    db "<NEXT>when we go to"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>So that potential"
    db "<NEXT>will help a lot!<WAIT>"
    db "@"

Message_00_92::
    db "<VOICE1>Cobi: Fine, <BUF0>.<LINE>"
    db "It's up to you.<PROMPT>"
    db "<NEXT>You do your best"
    db "<NEXT>and save us!<WAIT>"
    db "@"

Message_00_93::
    db "<VOICE1>Slash: That's<LINE>"
    db "settled, then!<PROMPT>"
    db "<NEXT>We'll leave"
    db "<NEXT>tomorrow morning.<PROMPT>"
    db "<NEXT>Get plenty of rest"
    db "<NEXT>tonight!<WAIT>"
    db "@"

Message_00_94::
    db "<VOICE2>Tara: If we don't<LINE>"
    db "go find something<PROMPT>"
    db "<NEXT>to put in the Log's"
    db "<NEXT>Navel, this house,<PROMPT>"
    db "<NEXT>the farm and"
    db "<NEXT>everything else<PROMPT>"
    db "<NEXT>will sink with the"
    db "<NEXT>island.<PROMPT>"
    db "<NEXT>So we have to go"
    db "<NEXT>to other worlds,<PROMPT>"
    db "<NEXT>right?<CHOICE>"
    db "@"

Message_00_95::
    db "<VOICE2>Tara: But if we<LINE>"
    db "both went, Mama<PROMPT>"
    db "<NEXT>would be really"
    db "<NEXT>worried about us.<WAIT>"
    db "@"

Message_00_96::
    db "<VOICE2>Tara: Oh… If we<LINE>"
    db "both went, Mama<PROMPT>"
    db "<NEXT>would be really"
    db "<NEXT>worried about us.<WAIT>"
    db "@"

Message_00_97::
    db "<VOICE2>Tara: <BUF0>, you<LINE>"
    db "want to go.<PROMPT>"
    db "<NEXT><BUF0>, do you want"
    db "<NEXT>me to stay home?<CHOICE>"
    db "@"

Message_00_98::
    db "<VOICE2>Tara: You don't<LINE>"
    db "have to lie.<PROMPT>"
    db "<NEXT>We'll be all right"
    db "<NEXT>here.<PROMPT>"
    db "<NEXT>You do really want"
    db "<NEXT>to go, right?<CHOICE>"
    db "@"

Message_00_99::
    db "<VOICE2>Tara: But <BUF0>,<LINE>"
    db "what about your<PROMPT>"
    db "<NEXT>terrible sense of"
    db "<NEXT>direction?<WAIT>"
    db "@"

Message_00_9A::
    db "<VOICE2>Tara: Then it's<LINE>"
    db "your job, <BUF0>!<PROMPT>"
    db "<NEXT>Make me proud, big"
    db "<NEXT>brother!<WAIT>"
    db "@"

Message_00_9B::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT><BUF>", $22, ".<WAIT>"
    db "@"

Message_00_A1::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>But it was empty…"
    db "<NEXT><WAIT>"
    db "@"

Message_00_A2::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> found the"
    db "<NEXT><BUF>", $22, ".<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT><BUF>", $22, " back.<WAIT>"
    db "@"

Message_00_A3::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT><BUF>", $22, ".<WAIT>"
    db "@"

Message_00_A4::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>But it was empty."
    db "<NEXT><WAIT>"
    db "@"

Message_00_A5::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT><BUF0> found the"
    db "<NEXT><BUF>", $22, ".<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT><BUF>", $22, " back.<WAIT>"
    db "@"

Message_00_A6::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT><BUF>", $22, ".<WAIT>"
    db "@"

Message_00_A7::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>But it was empty."
    db "<NEXT><WAIT>"
    db "@"

Message_00_A8::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT><BUF0> found the"
    db "<NEXT><BUF>", $22, ".<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT><BUF>", $22, " back.<WAIT>"
    db "@"

Message_00_A9::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained a"
    db "<NEXT>Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_00_AA::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>But it was empty…"
    db "<NEXT><WAIT>"
    db "@"

Message_00_AB::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> found a"
    db "<NEXT>Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>is full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

Message_00_AC::
    db "<VOICE1>*: Let's see how<LINE>"
    db "good you are!<WAIT>"
    db "@"

Message_00_D1::
    db "<VOICE1>*: You think you<LINE>"
    db "could win?<PROMPT>"
    db "<NEXT>Dream on, you"
    db "<NEXT>insolent fools!<WAIT>"
    db "@"

Message_00_D2::
    db "<VOICE1>*: Well, I", $44, " never<LINE>"
    db "expected you here.<PROMPT>"
    db "<NEXT>But this shall be"
    db "<NEXT>your tomb!<WAIT>"
    db "@"

Message_00_D3::
    db "<VOICE1>*: Prepare to be<LINE>"
    db "overwhelmed!<WAIT>"
    db "@"

Message_00_D4::
    db "<VOICE1>*: Those monsters<LINE>"
    db "are my foes?<PROMPT>"
    db "<NEXT>Fwahahaha!"
    db "<NEXT>How ludicrous!<WAIT>"
    db "@"

Message_00_D5::
    db "<VOICE1>*: If you win, you<LINE>"
    db "can be the boss!<WAIT>"
    db "@"

Message_00_D6::
    db "<VOICE1>*: I'll show you how<LINE>"
    db "small you are in<PROMPT>"
    db "<NEXT>the grand scheme"
    db "<NEXT>of things!<WAIT>"
    db "@"

Message_00_D7::
    db "<VOICE1>*: Hm? My rival is<LINE>"
    db "here? Come on!<WAIT>"
    db "@"

Message_00_D8::
    db "<VOICE1>*: Finally, someone<LINE>"
    db "to ignite my soul!<WAIT>"
    db "@"

Message_00_D9::
    db "<VOICE1>*: I feel your<LINE>"
    db "strength…<PROMPT>"
    db "<NEXT>This will be a"
    db "<NEXT>long battle.<WAIT>"
    db "@"
    ds $2f, $00
