; ROM bank $80: messages
; The annotated listing of this bank is build/listing/bank80.asm.

SECTION "Bank 80", ROMX[$4000], BANK[$80]
    db $80

; message bank $80: when wStringIndex < $C8, BeginStringDisplay with this bank's table
; MessageStrings_Bank80; otherwise far-calls BeginStringDisplay_Bank80_Overflow (E-0080)
BeginStringDisplay_Bank80::
    ld a, [wStringIndex]
    cp $c8
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank80_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank80
    call BeginStringDisplay
    ret

; message bank $80: when wStringIndex < $C8, CopyStringToBuffer with this bank's table
; MessageStrings_Bank80; otherwise far-calls CopyStringToBuffer_Bank80_Overflow (E-0080)
CopyStringToBuffer_Bank80::
    ld a, [wStringIndex]
    cp $c8
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank80_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank80
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_80::
; data read by BeginStringDisplay_Bank80 (1 word)
MessageStrings_Bank80::
    dw StringList_Bank80_0 ; id 0

; category list of StringCategories_80; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank80_0::
    dw Message_09_00 ; id 0
    dw Message_09_01 ; id 1
    dw Message_09_02 ; id 2
    dw Message_09_03 ; id 3
    dw Message_09_04 ; id 4
    dw Message_09_05 ; id 5
    dw Message_09_06 ; id 6
    dw Message_09_07 ; id 7
    dw Message_09_08 ; id 8
    dw Message_09_09 ; id 9
    dw Message_09_0A ; id 10
    dw Message_09_0B ; id 11
    dw Message_09_0C ; id 12
    dw Message_09_0D ; id 13
    dw Message_09_0E ; id 14
    dw Message_09_0F ; id 15
    dw Message_09_10 ; id 16
    dw Message_09_11 ; id 17
    dw Message_09_12 ; id 18
    dw Message_09_13 ; id 19
    dw Message_09_14 ; id 20
    dw Message_09_15 ; id 21
    dw Message_09_16 ; id 22
    dw Message_09_17 ; id 23
    dw Message_09_17 ; id 24
    dw Message_09_17 ; id 25
    dw Message_09_17 ; id 26
    dw Message_09_17 ; id 27
    dw Message_09_17 ; id 28
    dw Message_09_17 ; id 29
    dw Message_09_17 ; id 30
    dw Message_09_17 ; id 31
    dw Message_09_17 ; id 32
    dw Message_09_21 ; id 33
    dw Message_09_22 ; id 34
    dw Message_09_23 ; id 35
    dw Message_09_24 ; id 36
    dw Message_09_25 ; id 37
    dw Message_09_26 ; id 38
    dw Message_09_27 ; id 39
    dw Message_09_28 ; id 40
    dw Message_09_29 ; id 41
    dw Message_09_2A ; id 42
    dw Message_09_2B ; id 43
    dw Message_09_2C ; id 44
    dw Message_09_2D ; id 45
    dw Message_09_2E ; id 46
    dw Message_09_2F ; id 47
    dw Message_09_30 ; id 48
    dw Message_09_31 ; id 49
    dw Message_09_32 ; id 50
    dw Message_09_33 ; id 51
    dw Message_09_34 ; id 52
    dw Message_09_35 ; id 53
    dw Message_09_36 ; id 54
    dw Message_09_37 ; id 55
    dw Message_09_38 ; id 56
    dw Message_09_39 ; id 57
    dw Message_09_3A ; id 58
    dw Message_09_3B ; id 59
    dw Message_09_3C ; id 60
    dw Message_09_3D ; id 61
    dw Message_09_3E ; id 62
    dw Message_09_3F ; id 63
    dw Message_09_40 ; id 64
    dw Message_09_41 ; id 65
    dw Message_09_42 ; id 66
    dw Message_09_43 ; id 67
    dw Message_09_44 ; id 68
    dw Message_09_45 ; id 69
    dw Message_09_46 ; id 70
    dw Message_09_47 ; id 71
    dw Message_09_48 ; id 72
    dw Message_09_49 ; id 73
    dw Message_09_4A ; id 74
    dw Message_09_4B ; id 75
    dw Message_09_4C ; id 76
    dw Message_09_4D ; id 77
    dw Message_09_4E ; id 78
    dw Message_09_4F ; id 79
    dw Message_09_50 ; id 80
    dw Message_09_51 ; id 81
    dw Message_09_52 ; id 82
    dw Message_09_53 ; id 83
    dw Message_09_54 ; id 84
    dw Message_09_55 ; id 85
    dw Message_09_56 ; id 86
    dw Message_09_57 ; id 87
    dw Message_09_58 ; id 88
    dw Message_09_59 ; id 89
    dw Message_09_5A ; id 90
    dw Message_09_5B ; id 91
    dw Message_09_5C ; id 92
    dw Message_09_5D ; id 93
    dw Message_09_5E ; id 94
    dw Message_09_5F ; id 95
    dw Message_09_60 ; id 96
    dw Message_09_61 ; id 97
    dw Message_09_62 ; id 98
    dw Message_09_63 ; id 99
    dw Message_09_64 ; id 100
    dw Message_09_65 ; id 101
    dw Message_09_66 ; id 102
    dw Message_09_67 ; id 103
    dw Message_09_68 ; id 104
    dw Message_09_69 ; id 105
    dw Message_09_6A ; id 106
    dw Message_09_6B ; id 107
    dw Message_09_6C ; id 108
    dw Message_09_6D ; id 109
    dw Message_09_6E ; id 110
    dw Message_09_6F ; id 111
    dw Message_09_70 ; id 112
    dw Message_09_71 ; id 113
    dw Message_09_72 ; id 114
    dw Message_09_73 ; id 115
    dw Message_09_74 ; id 116
    dw Message_09_75 ; id 117
    dw Message_09_76 ; id 118
    dw Message_09_77 ; id 119
    dw Message_09_78 ; id 120
    dw Message_09_79 ; id 121
    dw Message_09_7A ; id 122
    dw Message_09_7B ; id 123
    dw Message_09_7C ; id 124
    dw Message_09_7D ; id 125
    dw Message_09_7E ; id 126
    dw Message_09_7F ; id 127
    dw Message_09_80 ; id 128
    dw Message_09_81 ; id 129
    dw Message_09_82 ; id 130
    dw Message_09_83 ; id 131
    dw Message_09_83 ; id 132
    dw Message_09_83 ; id 133
    dw Message_09_83 ; id 134
    dw Message_09_83 ; id 135
    dw Message_09_83 ; id 136
    dw Message_09_83 ; id 137
    dw Message_09_83 ; id 138
    dw Message_09_83 ; id 139
    dw Message_09_83 ; id 140
    dw Message_09_83 ; id 141
    dw Message_09_83 ; id 142
    dw Message_09_83 ; id 143
    dw Message_09_83 ; id 144
    dw Message_09_83 ; id 145
    dw Message_09_83 ; id 146
    dw Message_09_83 ; id 147
    dw Message_09_83 ; id 148
    dw Message_09_83 ; id 149
    dw Message_09_83 ; id 150
    dw Message_09_83 ; id 151
    dw Message_09_83 ; id 152
    dw Message_09_83 ; id 153
    dw Message_09_83 ; id 154
    dw Message_09_83 ; id 155
    dw Message_09_83 ; id 156
    dw Message_09_83 ; id 157
    dw Message_09_83 ; id 158
    dw Message_09_83 ; id 159
    dw Message_09_83 ; id 160
    dw Message_09_83 ; id 161
    dw Message_09_83 ; id 162
    dw Message_09_83 ; id 163
    dw Message_09_83 ; id 164
    dw Message_09_83 ; id 165
    dw Message_09_83 ; id 166
    dw Message_09_83 ; id 167
    dw Message_09_83 ; id 168
    dw Message_09_83 ; id 169
    dw Message_09_83 ; id 170
    dw Message_09_83 ; id 171
    dw Message_09_83 ; id 172
    dw Message_09_83 ; id 173
    dw Message_09_83 ; id 174
    dw Message_09_83 ; id 175
    dw Message_09_83 ; id 176
    dw Message_09_83 ; id 177
    dw Message_09_83 ; id 178
    dw Message_09_83 ; id 179
    dw Message_09_83 ; id 180
    dw Message_09_83 ; id 181
    dw Message_09_B6 ; id 182
    dw Message_09_B7 ; id 183
    dw Message_09_B8 ; id 184
    dw Message_09_B8 ; id 185
    dw Message_09_BA ; id 186
    dw Message_09_BB ; id 187
    dw Message_09_BC ; id 188
    dw Message_09_BD ; id 189
    dw Message_09_BE ; id 190
    dw Message_09_BF ; id 191
    dw Message_09_C0 ; id 192
    dw Message_09_C1 ; id 193
    dw Message_09_C2 ; id 194
    dw Message_09_C3 ; id 195
    dw Message_09_C4 ; id 196
    dw Message_09_C5 ; id 197
    dw Message_09_C6 ; id 198
    dw Message_09_C7 ; id 199

Message_09_00::
    db "<VOICE1>*: Queen Helen has<LINE>"
    db "become healthy.<WAIT>"
    db "@"

Message_09_01::
    db "<BUF0> checked the<LINE>"
    db "shield.<WAIT>"
    db "@"

Message_09_02::
    db "<VOICE1>*: So it was you<LINE>"
    db "holding up plans…<PROMPT>"
    db "<NEXT>The King of Limbo"
    db "<NEXT>promised me strong<PROMPT>"
    db "<NEXT>monsters in return"
    db "<NEXT>for the Sky Shield<PROMPT>"
    db "<NEXT>being taken from"
    db "<NEXT>the elemental.<PROMPT>"
    db "<NEXT>Any more of your"
    db "<NEXT>meddling will not<PROMPT>"
    db "<NEXT>be tolerated."
    db "<NEXT>You should just<PROMPT>"
    db "<NEXT>back off now."
    db "<NEXT>Do you really<PROMPT>"
    db "<NEXT>think you can"
    db "<NEXT>challenge me?<CHOICE>"
    db "@"

Message_09_03::
    db "<VOICE1>*: Tch, obstinate<LINE>"
    db "and foolish.<PROMPT>"
    db "<NEXT>You need to be"
    db "<NEXT>taught a lesson.<PROMPT>"
    db "<NEXT>Come hither, my"
    db "<NEXT>faithful fiends!<PROMPT>"
    db "<NEXT>Crush this fool!"
    db "<NEXT><WAIT>"
    db "@"

Message_09_04::
    db "<VOICE1>*: Wha… No!<LINE>"
    db "My monsters!<PROMPT>"
    db "<NEXT>It won't be this"
    db "<NEXT>easy next time!<WAIT>"
    db "@"

Message_09_05::
    db "<VOICE2>*: I bore witness<LINE>"
    db "to it all…<PROMPT>"
    db "<NEXT>Your work has"
    db "<NEXT>lifted the dark<PROMPT>"
    db "<NEXT>shadow that lay"
    db "<NEXT>over this world.<PROMPT>"
    db "<NEXT>Peace should be"
    db "<NEXT>quick to return.<PROMPT>"
    db "<NEXT>You no longer need"
    db "<NEXT>the Crest.<PROMPT>"
    db "<NEXT>Throw it back into"
    db "<NEXT>my spring.<WAIT>"
    db "@"

Message_09_06::
    db "<VOICE2>*: Throw the Crest<LINE>"
    db "into my spring.<WAIT>"
    db "@"

Message_09_07::
    db "<VOICE2>*: The Kingdoms<LINE>"
    db "should return to<PROMPT>"
    db "<NEXT>their peaceful"
    db "<NEXT>states.<PROMPT>"
    db "<NEXT>As my thanks, take"
    db "<NEXT>the Sky Shield.<WAIT>"
    db "@"

Message_09_08::
    db "<BUF0> received<LINE>"
    db "the Sky Shield.<WAIT>"
    db "@"

Message_09_09::
    db "A voice echoed<LINE>"
    db "from nowhere…<WAIT>"
    db "@"

Message_09_0A::
    db "<VOICE1>*: …Wa-hey! <BUF0>,<LINE>"
    db "can you hear me?<PROMPT>"
    db "<NEXT>I felt an odd"
    db "<NEXT>power stirring.<PROMPT>"
    db "<NEXT>You found a plug"
    db "<NEXT>for the Navel!<PROMPT>"
    db "<NEXT>I'll bring you"
    db "<NEXT>back! Don't move!<WAIT>"
    db "@"

Message_09_0B::
    db "<VOICE2>*: The spirit's<LINE>"
    db "spring in the<PROMPT>"
    db "<NEXT>north isn't icy"
    db "<NEXT>anymore.<PROMPT>"
    db "<NEXT>However cold it"
    db "<NEXT>may be, spring<PROMPT>"
    db "<NEXT>always comes, I"
    db "<NEXT>guess.<WAIT>"
    db "@"

Message_09_0C::
    db "<VOICE1>*: The ice blocking<LINE>"
    db "the harbor finally<PROMPT>"
    db "<NEXT>broke up and"
    db "<NEXT>melted away.<PROMPT>"
    db "<NEXT>We can get back to"
    db "<NEXT>sailing again!<WAIT>"
    db "@"

Message_09_0D::
    db "<VOICE1>*: The long winter<LINE>"
    db "seems to be over.<PROMPT>"
    db "<NEXT>It feels a little"
    db "<NEXT>warmer now.<PROMPT>"
    db "<NEXT>It's the perfect"
    db "<NEXT>occasion for a<PROMPT>"
    db "<NEXT>celebration drink"
    db "<NEXT>at the tavern.<WAIT>"
    db "@"

Message_09_0E::
    db "<VOICE1>*: We were visiting<LINE>"
    db "from the east.<PROMPT>"
    db "<NEXT>We found things to"
    db "<NEXT>be good here, so<PROMPT>"
    db "<NEXT>we've decided to"
    db "<NEXT>make this home.<WAIT>"
    db "@"

Message_09_0F::
    db "<VOICE1>*: When the harbor's<LINE>"
    db "ice disappeared,<PROMPT>"
    db "<NEXT>the sailors went"
    db "<NEXT>away with it…<PROMPT>"
    db "<NEXT>The tavern's not"
    db "<NEXT>earning money.<PROMPT>"
    db "<NEXT>I'm still feeling"
    db "<NEXT>blue…<WAIT>"
    db "@"

Message_09_10::
    db "<VOICE2>*: Welcome! Oh?<LINE>"
    db "Hi, there!<PROMPT>"
    db "<NEXT>Well, you're a bit"
    db "<NEXT>too young, but…<PROMPT>"
    db "<NEXT>Since it's quiet,"
    db "<NEXT>you're welcome.<WAIT>"
    db "@"

Message_09_11::
    db "<VOICE1>*: The eastern<LINE>"
    db "kingdom's castle<PROMPT>"
    db "<NEXT>is across the sea"
    db "<NEXT>from here.<PROMPT>"
    db "<NEXT>Rumor has it that"
    db "<NEXT>Queen Helen has<PROMPT>"
    db "<NEXT>recovered from her"
    db "<NEXT>illness.<WAIT>"
    db "@"

Message_09_12::
    db "<VOICE1>*: The harbor has<LINE>"
    db "been busy with<PROMPT>"
    db "<NEXT>boats coming and"
    db "<NEXT>going recently.<PROMPT>"
    db "<NEXT>I wonder how all"
    db "<NEXT>the ice melted.<WAIT>"
    db "@"

Message_09_13::
    db "<VOICE1>*: The piled up ice<LINE>"
    db "floes disappeared<PROMPT>"
    db "<NEXT>from the harbor"
    db "<NEXT>just like that.<PROMPT>"
    db "<NEXT>The elemental in"
    db "<NEXT>the spring must<PROMPT>"
    db "<NEXT>have done it for"
    db "<NEXT>us.<WAIT>"
    db "@"

Message_09_14::
    db "<VOICE1>*: The warm weather<LINE>"
    db "melted the ice in<PROMPT>"
    db "<NEXT>the elemental's"
    db "<NEXT>spring.<WAIT>"
    db "@"

Message_09_15::
    db "<VOICE2>*: The scholar came<LINE>"
    db "back finally from<PROMPT>"
    db "<NEXT>his research trip."
    db "<NEXT>Who knows where he<PROMPT>"
    db "<NEXT>could have been"
    db "<NEXT>all this time!<WAIT>"
    db "@"

Message_09_16::
    db "<VOICE1>*: My maid is angry<LINE>"
    db "that I left the<PROMPT>"
    db "<NEXT>house vacant for"
    db "<NEXT>so long.<PROMPT>"
    db "<NEXT>I wasn't wandering"
    db "<NEXT>aimlessly, but…<WAIT>"
    db "@"

Message_09_17::
    db "<VOICE2>*: Father dug under<LINE>"
    db "the island, and he<PROMPT>"
    db "<NEXT>made a stable for"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>You can make them"
    db "<NEXT>sleep now.<WAIT>"
    db "@"

Message_09_21::
    db "<VOICE2>*: I was going to<LINE>"
    db "ask Cobi, but I<PROMPT>"
    db "<NEXT>think you could do"
    db "<NEXT>this, <BUF0>.<PROMPT>"
    db "<NEXT>Could you find"
    db "<NEXT>something for me?<CHOICE>"
    db "@"

Message_09_22::
    db "<VOICE2>*: The farm that<LINE>"
    db "your father always<PROMPT>"
    db "<NEXT>dreamed about is"
    db "<NEXT>finally completed.<PROMPT>"
    db "<NEXT>I want to have a"
    db "<NEXT>nice dinner to<PROMPT>"
    db "<NEXT>celebrate, so I", $44
    db "<NEXT>like some Sirloin.<PROMPT>"
    db "<NEXT>Please go buy some"
    db "<NEXT>for me.<WAIT>"
    db "@"

Message_09_23::
    db "*: Mama handed over<LINE>"
    db "1,200G.<WAIT>"
    db "@"

Message_09_24::
    db "<VOICE2>*: Oh… Then I'll<LINE>"
    db "ask Cobi.<WAIT>"
    db "@"

Message_09_25::
    db "<VOICE2>*: I was going to<LINE>"
    db "ask Tara, but you<PROMPT>"
    db "<NEXT>could do this"
    db "<NEXT>instead, <BUF0>.<PROMPT>"
    db "<NEXT>Could you find"
    db "<NEXT>something for me?<CHOICE>"
    db "@"

Message_09_26::
    db "<VOICE2>*: Oh… Then I'll<LINE>"
    db "ask Tara.<WAIT>"
    db "@"

Message_09_27::
    db "<VOICE2>*: Buy some Sirloin<LINE>"
    db "for our dinner.<WAIT>"
    db "@"

Message_09_28::
    db "<VOICE2>*: They didn't have<LINE>"
    db "any around here.<PROMPT>"
    db "<NEXT>I'm surprised you"
    db "<NEXT>found this.<WAIT>"
    db "@"

Message_09_29::
    db "<BUF0> handed over<LINE>"
    db "the Sirloin.<WAIT>"
    db "@"

Message_09_2A::
    db "<VOICE2>*: I don't have any<LINE>"
    db "errands right now.<PROMPT>"
    db "<NEXT>I'll ask if there's"
    db "<NEXT>anything, <BUF0>.<WAIT>"
    db "@"

Message_09_2B::
    db "<VOICE1>*: MadGopher helped<LINE>"
    db "me excavate.<PROMPT>"
    db "<NEXT>Look at the great"
    db "<NEXT>stable we made!<PROMPT>"
    db "<NEXT>My dream farm is"
    db "<NEXT>finally finished!<WAIT>"
    db "@"

Message_09_2C::
    db "<VOICE1>*: Whew. I'm done<LINE>"
    db "working finally.<PROMPT>"
    db "<NEXT>Can you take me"
    db "<NEXT>out somewhere?<CHOICE>"
    db "@"

Message_09_2D::
    db "<VOICE1>*: You will?<LINE>"
    db "I'll cut loose!<WAIT>"
    db "@"

Message_09_2E::
    db "<VOICE1>*: Oh, but you have<LINE>"
    db "no room for me…<WAIT>"
    db "@"

Message_09_2F::
    db "<VOICE1>*: Oh, don't be<LINE>"
    db "that way.<PROMPT>"
    db "<NEXT>I'm sure I can"
    db "<NEXT>help you.<WAIT>"
    db "@"

Message_09_30::
    db "<VOICE1>Cobi: <BUF0>, what<LINE>"
    db "was it like in the<PROMPT>"
    db "<NEXT>other worlds?"
    db "<NEXT>I", $44, " like to know.<PROMPT>"
    db "<NEXT>…You met an"
    db "<NEXT>elemental spirit?<PROMPT>"
    db "<NEXT>Wow. I wish I got"
    db "<NEXT>to meet her.<PROMPT>"
    db "<NEXT>Papa made a stable"
    db "<NEXT>under the island,<PROMPT>"
    db "<NEXT>so monsters can go"
    db "<NEXT>to sleep.<PROMPT>"
    db "<NEXT>So, what can I do"
    db "<NEXT>for you, sis?<WAIT>"
    db "@"

Message_09_31::
    db "<VOICE2>Tara: Big brother,<LINE>"
    db "tell me about what<PROMPT>"
    db "<NEXT>you've seen in the"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>An elemental in a"
    db "<NEXT>spring?<PROMPT>"
    db "<NEXT>Was she really"
    db "<NEXT>pretty?<PROMPT>"
    db "<NEXT>…Big brother, lose"
    db "<NEXT>that smirk!<PROMPT>"
    db "<NEXT>Papa made a stable"
    db "<NEXT>under the island,<PROMPT>"
    db "<NEXT>so monsters can go"
    db "<NEXT>to sleep.<PROMPT>"
    db "<NEXT>Anyway, do you"
    db "<NEXT>need any help?<WAIT>"
    db "@"

Message_09_32::
    db "<VOICE1>*: There are powers<LINE>"
    db "that let you cross<PROMPT>"
    db "<NEXT>the sea or fly up"
    db "<NEXT>in the sky.<PROMPT>"
    db "<NEXT>If you get such"
    db "<NEXT>powers, face the<PROMPT>"
    db "<NEXT>sea or sky and"
    db "<NEXT>push a button!<WAIT>"
    db "@"

Message_09_33::
    db "<VOICE1>*: Have you been to<LINE>"
    db "the Starry Shrine?<PROMPT>"
    db "<NEXT>Breeding toughens"
    db "<NEXT>up monsters.<PROMPT>"
    db "<NEXT>The offspring"
    db "<NEXT>inherits the<PROMPT>"
    db "<NEXT>stats, attributes"
    db "<NEXT>and skills of<PROMPT>"
    db "<NEXT>parents."
    db "<NEXT><WAIT>"
    db "@"

Message_09_34::
    db "<VOICE1>*: Uheheheh, did<LINE>"
    db "you know this?<PROMPT>"
    db "<NEXT>Zombies like me"
    db "<NEXT>aren't bothered by<PROMPT>"
    db "<NEXT>death spells or"
    db "<NEXT>curses.<PROMPT>"
    db "<NEXT>We're specialists"
    db "<NEXT>in that area.<WAIT>"
    db "@"

Message_09_35::
    db "<VOICE1>*: I'm a bug, so<LINE>"
    db "I'm not badly<PROMPT>"
    db "<NEXT>affected by poison"
    db "<NEXT>or paralysis.<WAIT>"
    db "@"

Message_09_36::
    db "<VOICE1>*: Prince Kameha<LINE>"
    db "has been missing<PROMPT>"
    db "<NEXT>from the castle a"
    db "<NEXT>long time…<PROMPT>"
    db "<NEXT>The King thought"
    db "<NEXT>it was another of<PROMPT>"
    db "<NEXT>the Prince's silly"
    db "<NEXT>pranks at first,<PROMPT>"
    db "<NEXT>but he's worried"
    db "<NEXT>and appears unable<PROMPT>"
    db "<NEXT>to concentrate on"
    db "<NEXT>work now.<PROMPT>"
    db "<NEXT>Have you seen"
    db "<NEXT>Prince Kameha?<CHOICE>"
    db "@"

Message_09_37::
    db "<VOICE1>*: What's that?<LINE>"
    db "You saw Prince<PROMPT>"
    db "<NEXT>Kameha in another"
    db "<NEXT>world?<PROMPT>"
    db "<NEXT>Come with me to"
    db "<NEXT>see his Majesty!<WAIT>"
    db "@"

Message_09_38::
    db "<VOICE1>*: You", $44, " better be<LINE>"
    db "telling the truth.<PROMPT>"
    db "<NEXT>If you see the"
    db "<NEXT>Prince, you let us<PROMPT>"
    db "<NEXT>know right away,"
    db "<NEXT>get it?<WAIT>"
    db "@"

Message_09_39::
    db "<VOICE2>*: The man here has<LINE>"
    db "rare keys.<PROMPT>"
    db "<NEXT>Doesn't it intrigue"
    db "<NEXT>you what sort of<PROMPT>"
    db "<NEXT>worlds his keys"
    db "<NEXT>lead to?<WAIT>"
    db "@"

Message_09_3A::
    db "<VOICE1>*: Sire, this child<LINE>"
    db "claims to know<PROMPT>"
    db "<NEXT>Prince Kameha's"
    db "<NEXT>whereabouts.<WAIT>"
    db "@"

Message_09_3B::
    db "<VOICE1>King: What's that?<LINE>"
    db "Is that so?<PROMPT>"
    db "<NEXT>Where has Kameha"
    db "<NEXT>gotten to?<PROMPT>"
    db "<NEXT>What?"
    db "<NEXT>Another world?<PROMPT>"
    db "<NEXT>So the rumors were"
    db "<NEXT>true…<PROMPT>"
    db "<NEXT>No wonder he could"
    db "<NEXT>not be found.<PROMPT>"
    db "<NEXT>Well, so long as"
    db "<NEXT>he is safe, it's<PROMPT>"
    db "<NEXT>fine. It is quiet"
    db "<NEXT>when he's absent.<PROMPT>"
    db "<NEXT>If you see Kameha"
    db "<NEXT>again, I'll ask<PROMPT>"
    db "<NEXT>that you let me"
    db "<NEXT>know.<PROMPT>"
    db "<NEXT>Ah, I should also"
    db "<NEXT>give you this.<PROMPT>"
    db "<NEXT>It's a Magic Key"
    db "<NEXT>named Sky Key.<WAIT>"
    db "@"

Message_09_3C::
    db "<VOICE1>King: If you see<LINE>"
    db "Kameha again, I'll<PROMPT>"
    db "<NEXT>ask that you let"
    db "<NEXT>me know.<PROMPT>"
    db "<NEXT>I realize that he"
    db "<NEXT>is a mischievous<PROMPT>"
    db "<NEXT>handful, but I"
    db "<NEXT>need your help.<WAIT>"
    db "@"

Message_09_3D::
    db "<VOICE1>*: Prince Kameha<LINE>"
    db "wandered off like<PROMPT>"
    db "<NEXT>a kite without its"
    db "<NEXT>string…<PROMPT>"
    db "<NEXT>Who did he take"
    db "<NEXT>after…<PROMPT>"
    db "<NEXT>…Uh, never mind,"
    db "<NEXT>ignore that!<WAIT>"
    db "@"

Message_09_3E::
    db "<VOICE1>*: You're free to<LINE>"
    db "go anywhere in the<PROMPT>"
    db "<NEXT>Castle as you see"
    db "<NEXT>fit.<PROMPT>"
    db "<NEXT>You can visit the"
    db "<NEXT>Christener on the<PROMPT>"
    db "<NEXT>third level to"
    db "<NEXT>rename monsters.<PROMPT>"
    db "<NEXT>Or drop into the"
    db "<NEXT>tavern on four.<PROMPT>"
    db "<NEXT>But don't expect"
    db "<NEXT>to be served!<WAIT>"
    db "@"

Message_09_3F::
    db "<VOICE1>*: The King and<LINE>"
    db "Prince's chamber<PROMPT>"
    db "<NEXT>is beyond here."
    db "<NEXT>If I let you go<PROMPT>"
    db "<NEXT>through, I'll catch"
    db "<NEXT>royal heck.<WAIT>"
    db "@"

Message_09_40::
    db "<VOICE1>*: Please enter.<LINE>"
    db "The King awaits<PROMPT>"
    db "<NEXT>you in the"
    db "<NEXT>reception hall.<WAIT>"
    db "@"

Message_09_41::
    db "<VOICE1>*: This is GreatLog<LINE>"
    db "Castle.<PROMPT>"
    db "<NEXT>The reception hall"
    db "<NEXT>is beyond here.<PROMPT>"
    db "<NEXT>The stairs will"
    db "<NEXT>take you to the<PROMPT>"
    db "<NEXT>top of GreatLog's"
    db "<NEXT>tree.<WAIT>"
    db "@"

Message_09_42::
    db "<VOICE1>*: The tavern just<LINE>"
    db "outside the Castle<PROMPT>"
    db "<NEXT>is frequented by"
    db "<NEXT>masters.<PROMPT>"
    db "<NEXT>They'll offer to"
    db "<NEXT>breed monsters,<PROMPT>"
    db "<NEXT>and they'll give"
    db "<NEXT>you some tips.<WAIT>"
    db "@"

Message_09_43::
    db "<VOICE1>*: Hey, welcome!<LINE>"
    db "All masters are<PROMPT>"
    db "<NEXT>welcome here, even"
    db "<NEXT>little kids.<PROMPT>"
    db "<NEXT>Skilled masters"
    db "<NEXT>congregate here.<PROMPT>"
    db "<NEXT>You might get the"
    db "<NEXT>chance to breed<PROMPT>"
    db "<NEXT>some monsters."
    db "<NEXT>Don't miss out.<PROMPT>"
    db "<NEXT>Raising monsters"
    db "<NEXT>alone is tough, so<PROMPT>"
    db "<NEXT>don't waste any"
    db "<NEXT>chance to breed.<WAIT>"
    db "@"

Message_09_44::
    db "<VOICE1>*: When you breed,<LINE>"
    db "notice a number<PROMPT>"
    db "<NEXT>after a plus sign"
    db "<NEXT>in the name?<PROMPT>"
    db "<NEXT>The higher that"
    db "<NEXT>number, the more<PROMPT>"
    db "<NEXT>the monster can"
    db "<NEXT>grow.<PROMPT>"
    db "<NEXT>So you can level"
    db "<NEXT>it up more!<WAIT>"
    db "@"

Message_09_45::
    db "<VOICE1>*: If you want to<LINE>"
    db "make a certain<PROMPT>"
    db "<NEXT>species stronger,"
    db "<NEXT>just breed it with<PROMPT>"
    db "<NEXT>a monster of the"
    db "<NEXT>same family.<PROMPT>"
    db "<NEXT>Even though the"
    db "<NEXT>species remains<PROMPT>"
    db "<NEXT>unchanged, the"
    db "<NEXT>monster will have<PROMPT>"
    db "<NEXT>inherited the"
    db "<NEXT>partner's powers.<WAIT>"
    db "@"

Message_09_46::
    db "<VOICE1>*: I'm a traveling<LINE>"
    db "merchant.<PROMPT>"
    db "<NEXT>I'm also a master"
    db "<NEXT>as a hobby.<PROMPT>"
    db "<NEXT>Listen, would you"
    db "<NEXT>like to breed<PROMPT>"
    db "<NEXT>something with my"
    db "<NEXT>SpikyBoy?<PROMPT>"
    db "<NEXT>If possible, I", $44
    db "<NEXT>like to breed mine<PROMPT>"
    db "<NEXT>with another"
    db "<NEXT>SpikyBoy. Well?<CHOICE>"
    db "@"

Message_09_47::
    db "<VOICE1>*: Then let's breed<LINE>"
    db "them!<WAIT>"
    db "@"

Message_09_48::
    db "<VOICE1>*: Oh, too bad.<LINE>"
    db "Another time.<WAIT>"
    db "@"

Message_09_49::
    db "<VOICE1>*: Breeding could<LINE>"
    db "result in monsters<PROMPT>"
    db "<NEXT>with skills you"
    db "<NEXT>wouldn't expect.<PROMPT>"
    db "<NEXT>It's an added perk"
    db "<NEXT>of breeding.<WAIT>"
    db "@"

Message_09_4A::
    db "<VOICE1>*: From up here<LINE>"
    db "people look like<PROMPT>"
    db "<NEXT>ants scurrying"
    db "<NEXT>about, but they're<PROMPT>"
    db "<NEXT>not as big as"
    db "<NEXT>ArmyAnts.<WAIT>"
    db "@"

Message_09_4B::
    db "<VOICE2>*: On the horizon,<LINE>"
    db "you can see an<PROMPT>"
    db "<NEXT>enormous tree like"
    db "<NEXT>this one.<PROMPT>"
    db "<NEXT>It's the Kingdom"
    db "<NEXT>of GreatTree.<PROMPT>"
    db "<NEXT>It's GreatLog's"
    db "<NEXT>rival kingdom.<WAIT>"
    db "@"

Message_09_4C::
    db "<VOICE1>*: GreatLog Castle<LINE>"
    db "was made by<PROMPT>"
    db "<NEXT>hollowing out"
    db "<NEXT>giant coconuts.<PROMPT>"
    db "<NEXT>GreatLog should"
    db "<NEXT>have four in all.<PROMPT>"
    db "<NEXT>That means there"
    db "<NEXT>must be two more<PROMPT>"
    db "<NEXT>coconuts below"
    db "<NEXT>this level.<WAIT>"
    db "@"

Message_09_4D::
    db "<VOICE1>*: The island used<LINE>"
    db "to be lush with<PROMPT>"
    db "<NEXT>plants, but they"
    db "<NEXT>are dying slowly…<PROMPT>"
    db "<NEXT>Will GreatLog"
    db "<NEXT>suffer that way?<PROMPT>"
    db "<NEXT>People don't appear"
    db "<NEXT>to be concerned,<PROMPT>"
    db "<NEXT>but something is"
    db "<NEXT>going to happen…<WAIT>"
    db "@"

Message_09_4E::
    db "<VOICE1>*: Hello, <BUF0>,<LINE>"
    db "welcome!<PROMPT>"
    db "<NEXT>This is the stable"
    db "<NEXT>where you can keep<PROMPT>"
    db "<NEXT>monsters stored,"
    db "<NEXT>but hibernating.<PROMPT>"
    db "<NEXT>A monster won't"
    db "<NEXT>gain any EX points<PROMPT>"
    db "<NEXT>while hibernating,"
    db "<NEXT>but it also won't<PROMPT>"
    db "<NEXT>return to its wild"
    db "<NEXT>state.<PROMPT>"
    db "<NEXT>Do you want to"
    db "<NEXT>have a monster<PROMPT>"
    db "<NEXT>hibernate in the"
    db "<NEXT>stable?<WAIT>"
    db "@"

Message_09_4F::
    db "<VOICE1>*: Hello, <BUF0>,<LINE>"
    db "welcome!<PROMPT>"
    db "<NEXT>Want to use the"
    db "<NEXT>stable?<WAIT>"
    db "@"

Message_09_50::
    db "<VOICE1>*: Zzzz… Yawn…<LINE>"
    db "Huh?<PROMPT>"
    db "<NEXT>Is it morning"
    db "<NEXT>already?<WAIT>"
    db "@"

Message_09_51::
    db "<VOICE1>*: When a ★ appears<LINE>"
    db "by a monster's<PROMPT>"
    db "<NEXT>level number, it"
    db "<NEXT>stops growing.<PROMPT>"
    db "<NEXT>It won't learn any"
    db "<NEXT>more skills too.<PROMPT>"
    db "<NEXT>In other words, it"
    db "<NEXT>indicates that the<PROMPT>"
    db "<NEXT>monster has grown"
    db "<NEXT>as much as it can.<WAIT>"
    db "@"

Message_09_52::
    db "<VOICE1>*: Our kind always<LINE>"
    db "stays near water.<PROMPT>"
    db "<NEXT>Go traveling on"
    db "<NEXT>water if you want<PROMPT>"
    db "<NEXT>to see others like"
    db "<NEXT>me.<WAIT>"
    db "@"

Message_09_53::
    db "<VOICE1>*: Zzz… Zzz…<LINE>"
    db "Zzz… Whoops!<PROMPT>"
    db "<NEXT>Was I breathing"
    db "<NEXT>fire there?<WAIT>"
    db "@"

Message_09_54::
    db "<VOICE1>*: Do you want to<LINE>"
    db "know how much your<PROMPT>"
    db "<NEXT>companions can"
    db "<NEXT>grow?<CHOICE>"
    db "@"

Message_09_55::
    db "<VOICE1><BUF>", $17, "'s growth<LINE>"
    db "limit is Lv <BUF>", $4e, ".<WAIT>"
    db "@"

Message_09_56::
    db "<VOICE1><BUF>", $17, " has reached<LINE>"
    db "its growth limit.<WAIT>"
    db "@"

Message_09_57::
    db "<VOICE1>Once a monster<LINE>"
    db "reaches its growth<PROMPT>"
    db "<NEXT>limit, it won't"
    db "<NEXT>level up anymore.<WAIT>"
    db "@"

Message_09_58::
    db "<VOICE1>*: Everyone has a<LINE>"
    db "growth limit.<PROMPT>"
    db "<NEXT>Whether you accept"
    db "<NEXT>this or not, you<PROMPT>"
    db "<NEXT>can't defy the"
    db "<NEXT>march of time.<WAIT>"
    db "@"

Message_09_59::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Ssh… Monsters are"
    db "<NEXT>sleeping.<PROMPT>"
    db "<NEXT>Please be quiet in"
    db "<NEXT>the stable.", $95, "<WAIT>"
    db "@"

Message_09_5A::
    db "<BUF0> checked the<LINE>"
    db "casket.<WAIT>"
    db "@"

Message_09_5B::
    db "<VOICE1>*: Zzz… Use the<LINE>"
    db "plan 'Charge' in<PROMPT>"
    db "<NEXT>battle to boost"
    db "<NEXT>monster courage.", $95, "<WAIT>"
    db "@"

Message_09_5C::
    db "<VOICE1>*: Zzz…<LINE>"
    db "Hnnnnnrgh… Huh?<PROMPT>"
    db "<NEXT>Being 'Cautious", $95
    db "<NEXT>in battle makes<PROMPT>"
    db "<NEXT>monsters more"
    db "<NEXT>compassionate.<WAIT>"
    db "@"

Message_09_5D::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Watch your step!"
    db "<NEXT>Monster at sleep!", $95, "<WAIT>"
    db "@"

Message_09_5E::
    db "<BUF0> peered into<LINE>"
    db "the hole.<WAIT>"
    db "@"

Message_09_5F::
    db "<VOICE1>*: Zzz… Zzz…<LINE>"
    db "Some skills are<PROMPT>"
    db "<NEXT>developed from"
    db "<NEXT>skills that have<PROMPT>"
    db "<NEXT>been learned"
    db "<NEXT>already.<WAIT>"
    db "@"

Message_09_60::
    db "<VOICE2>*: Oh, you're the<LINE>"
    db "Kids Class Champ!<PROMPT>"
    db "<NEXT>Want to hear"
    db "<NEXT>something good?<CHOICE>"
    db "@"

Message_09_61::
    db "<VOICE2>*: In the C Class<LINE>"
    db "final, you'll be<PROMPT>"
    db "<NEXT>facing HammerMan"
    db "<NEXT>and Stubsuck.<PROMPT>"
    db "<NEXT>HammerMan uses"
    db "<NEXT>EvilSlash.<PROMPT>"
    db "<NEXT>It's one tough"
    db "<NEXT>customer!<WAIT>"
    db "@"

Message_09_62::
    db "<VOICE2>*: Oh, you're the<LINE>"
    db "C Class Champ!<PROMPT>"
    db "<NEXT>Want to hear"
    db "<NEXT>something good?<CHOICE>"
    db "@"

Message_09_63::
    db "<VOICE2>*: In the B Class<LINE>"
    db "final, you'll face<PROMPT>"
    db "<NEXT>three monsters-"
    db "<NEXT>HerbMan, DanceVegi<PROMPT>"
    db "<NEXT>and MudDoll. Watch"
    db "<NEXT>out for Hustle!<WAIT>"
    db "@"

Message_09_64::
    db "<VOICE2>*: Oh, you're the<LINE>"
    db "B Class Champ!<PROMPT>"
    db "<NEXT>Want to hear"
    db "<NEXT>something good?<CHOICE>"
    db "@"

Message_09_65::
    db "<VOICE2>*: In the A Class<LINE>"
    db "final, you'll face<PROMPT>"
    db "<NEXT>MistyWing, Copycat"
    db "<NEXT>and NiteWhip.<PROMPT>"
    db "<NEXT>Watch out for the"
    db "<NEXT>skill Imitate!<WAIT>"
    db "@"

Message_09_66::
    db "<VOICE2>*: Oh, you're the<LINE>"
    db "A Class Champ!<PROMPT>"
    db "<NEXT>The S Class is"
    db "<NEXT>next.<PROMPT>"
    db "<NEXT>It's the final"
    db "<NEXT>battle class.<PROMPT>"
    db "<NEXT>It's nothing like"
    db "<NEXT>what you've seen.<PROMPT>"
    db "<NEXT>Want to hear"
    db "<NEXT>something good?<CHOICE>"
    db "@"

Message_09_67::
    db "<VOICE2>*: In the S Class<LINE>"
    db "final, you'll face<PROMPT>"
    db "<NEXT>Serpentia, Orochi"
    db "<NEXT>and GigaDraco.<PROMPT>"
    db "<NEXT>They're horribly"
    db "<NEXT>strong.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>stop their attacks<PROMPT>"
    db "<NEXT>to get a chance at"
    db "<NEXT>winning.<WAIT>"
    db "@"

Message_09_68::
    db "<VOICE2>*: My Emyu is very<LINE>"
    db "timid.<PROMPT>"
    db "<NEXT>I've taken it down"
    db "<NEXT>to the Coliseum,<PROMPT>"
    db "<NEXT>but all it does is"
    db "<NEXT>take cover…<WAIT>"
    db "@"

Message_09_69::
    db "<VOICE2>*: Wow, you've got<LINE>"
    db "a brave monster!<PROMPT>"
    db "<NEXT>Look, Emyu!"
    db "<NEXT>Do you see that?<PROMPT>"
    db "<NEXT>That's how I want"
    db "<NEXT>you to be!<WAIT>"
    db "@"

Message_09_6A::
    db "<VOICE2>*: Has my Emyu<LINE>"
    db "learned to be more<PROMPT>"
    db "<NEXT>brave? I really"
    db "<NEXT>wonder about that…<WAIT>"
    db "@"

Message_09_6B::
    db "<VOICE1>*: Monsters look so<LINE>"
    db "frightening…<PROMPT>"
    db "<NEXT>Yes, I know, I'm"
    db "<NEXT>one too, but…<PROMPT>"
    db "<NEXT>But when one"
    db "<NEXT>glares at me…<PROMPT>"
    db "<NEXT>Just the thought"
    db "<NEXT>is scary!<WAIT>"
    db "@"

Message_09_6C::
    db "<VOICE1>*: I should be more<LINE>"
    db "assertive.<PROMPT>"
    db "<NEXT>It's not as if I'm"
    db "<NEXT>going to die.<WAIT>"
    db "@"

Message_09_6D::
    db "<VOICE1>*: You can call me<LINE>"
    db "the Medal Master.<PROMPT>"
    db "<NEXT>I am a collector"
    db "<NEXT>of TinyMedals.<PROMPT>"
    db "<NEXT>I only recently"
    db "<NEXT>moved to GreatLog.<PROMPT>"
    db "<NEXT>TinyMedals are all"
    db "<NEXT>over the world.<PROMPT>"
    db "<NEXT>If you find any,"
    db "<NEXT>can you bring them<PROMPT>"
    db "<NEXT>to me? I'll trade"
    db "<NEXT>gifts for them.<WAIT>"
    db "@"

Message_09_6E::
    db "<VOICE1>*: You can call me<LINE>"
    db "the Medal Master.<PROMPT>"
    db "<NEXT>I am a collector"
    db "<NEXT>of TinyMedals.<WAIT>"
    db "@"

Message_09_6F::
    db "<VOICE2>*: My husband loves<LINE>"
    db "to collect things<PROMPT>"
    db "<NEXT>that are of no"
    db "<NEXT>value to others.<PROMPT>"
    db "<NEXT>TinyMedals are"
    db "<NEXT>what he's after<PROMPT>"
    db "<NEXT>right now."
    db "<NEXT>It's a passion!<WAIT>"
    db "@"

Message_09_70::
    db "<VOICE1>*: I like making<LINE>"
    db "the Medal Master<PROMPT>"
    db "<NEXT>happy."
    db "<NEXT><PROMPT>"
    db "If you have any"
    db "<NEXT>TinyMedals can I<PROMPT>"
    db "<NEXT>have them?<CHOICE>"
    db "@"

Message_09_71::
    db "<VOICE1>*: Yippee! Thanks a<LINE>"
    db "whole bunch!<PROMPT>"
    db "<NEXT>This will make the"
    db "<NEXT>Medal Master <PROMPT>"
    db "<NEXT>happy!"
    db "<NEXT><WAIT>"
    db "@"

Message_09_72::
    db "<VOICE1>*: Yippee! Thanks a<LINE>"
    db "whole bunch!<PROMPT>"
    db "<NEXT>This will make the"
    db "<NEXT>Medal Master<PROMPT>"
    db "<NEXT>happy! "
    db "<NEXT><PROMPT>"
    db "Oh? You don't have"
    db "<NEXT>any TinyMedals…<WAIT>"
    db "@"

Message_09_73::
    db "<VOICE1>*: Aww… That's so<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>I wanted to please"
    db "<NEXT>the Medal Master…<WAIT>"
    db "@"

Message_09_74::
    db "<VOICE1>*: The Medal Master<LINE>"
    db "was famous as a<PROMPT>"
    db "<NEXT>monster master"
    db "<NEXT>when he was young.<PROMPT>"
    db "<NEXT>The dresser is"
    db "<NEXT>full of treasures<PROMPT>"
    db "<NEXT>that he collected"
    db "<NEXT>back then.<WAIT>"
    db "@"

Message_09_75::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>It overflowed with"
    db "<NEXT>treasures.<WAIT>"
    db "@"

Message_09_76::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>It overflowed with"
    db "<NEXT>TinyMedals.<PROMPT>"
    db "<NEXT>The Medal Master"
    db "<NEXT>glanced sharply,<PROMPT>"
    db "<NEXT>prompting <BUF0> to"
    db "<NEXT>close the dresser.<WAIT>"
    db "@"

Message_09_77::
    db "<BUF0> checked the<LINE>"
    db "oven.<PROMPT>"
    db "<NEXT>There was an old,"
    db "<NEXT>polished pot.<WAIT>"
    db "@"

Message_09_78::
    db "<VOICE1>Warubou: Wa-hey, I<LINE>"
    db "feel an odd power<PROMPT>"
    db "<NEXT>stirring again in"
    db "<NEXT>another world.<PROMPT>"
    db "<NEXT>It must be the"
    db "<NEXT>LightOrb, which is<PROMPT>"
    db "<NEXT>sealed away safely"
    db "<NEXT>somewhere, warooh.<PROMPT>"
    db "<NEXT>Take this Sky Key"
    db "<NEXT>and find it!<WAIT>"
    db "@"

Message_09_79::
    db "<BUF0> received the<LINE>"
    db "Sky Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_09_7A::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "<BUF0> and Kameha!<PROMPT>"
    db "<NEXT>I share GreatLog's"
    db "<NEXT>power with you!<WAIT>"
    db "@"

Message_09_7B::
    db "<VOICE1>Warubou: There!<LINE>"
    db "All healed now!<PROMPT>"
    db "<NEXT>There is something"
    db "<NEXT>strange, warooh.<PROMPT>"
    db "<NEXT>I feel an odd sort"
    db "<NEXT>of power coming<PROMPT>"
    db "<NEXT>from Limbo, but I"
    db "<NEXT>can't tell if it's<PROMPT>"
    db "<NEXT>from anything that"
    db "<NEXT>could be a plug.<PROMPT>"
    db "<NEXT>But no choice is"
    db "<NEXT>what we have.<PROMPT>"
    db "<NEXT>You have to do the"
    db "<NEXT>King's bidding.<PROMPT>"
    db "<NEXT>GreatLog's life"
    db "<NEXT>force is almost<PROMPT>"
    db "<NEXT>all used up…"
    db "<NEXT>Huh?<WAIT>"
    db "@"

Message_09_7C::
    db "<VOICE1>Kameha: I… I have<LINE>"
    db "to go back to the<PROMPT>"
    db "<NEXT>Castle for a"
    db "<NEXT>while! Later!<WAIT>"
    db "@"

Message_09_7D::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "there is little<PROMPT>"
    db "<NEXT>time left to us"
    db "<NEXT>now.<PROMPT>"
    db "<NEXT><BUF0>, this is our"
    db "<NEXT>last chance.<PROMPT>"
    db "<NEXT>If we don't find a"
    db "<NEXT>proper plug this<PROMPT>"
    db "<NEXT>time, GreatLog is"
    db "<NEXT>finished, warooh!<WAIT>"
    db "@"

Message_09_7E::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "we don't have the<PROMPT>"
    db "<NEXT>time to be in"
    db "<NEXT>shock, warooh.<PROMPT>"
    db "<NEXT>I have here the"
    db "<NEXT>treasures that<PROMPT>"
    db "<NEXT>didn't work as the"
    db "<NEXT>Navel's plug.<PROMPT>"
    db "<NEXT>Come get them when"
    db "<NEXT>you are ready to<PROMPT>"
    db "<NEXT>leave to the world"
    db "<NEXT>of Limbo, warooh.<WAIT>"
    db "@"

Message_09_7F::
    db "<VOICE2>*: In the C Class<LINE>"
    db "final, you'll be<PROMPT>"
    db "<NEXT>facing HammerMan"
    db "<NEXT>and Stubsuck.<PROMPT>"
    db "<NEXT>HammerMan uses"
    db "<NEXT>Heal, so you<PROMPT>"
    db "<NEXT>should knock it"
    db "<NEXT>out first.<WAIT>"
    db "@"

Message_09_80::
    db "<VOICE2>*: In the B Class<LINE>"
    db "final, you'll face<PROMPT>"
    db "<NEXT>three monsters-"
    db "<NEXT>HerbMan, DanceVegi<PROMPT>"
    db "<NEXT>and MudDoll. Watch"
    db "<NEXT>out for Hustle!<WAIT>"
    db "@"

Message_09_81::
    db "<VOICE2>*: In the A Class<LINE>"
    db "final, you'll face<PROMPT>"
    db "<NEXT>MistyWing, Copycat"
    db "<NEXT>and NiteWhip.<PROMPT>"
    db "<NEXT>Watch out for the"
    db "<NEXT>skill Imitate!<WAIT>"
    db "@"

Message_09_82::
    db "<VOICE2>*: In the S Class<LINE>"
    db "final, you'll be<PROMPT>"
    db "<NEXT>facing DrakSlime,"
    db "<NEXT>MetalKing and<PROMPT>"
    db "<NEXT>MimeSlime."
    db "<NEXT>That's the team.<PROMPT>"
    db "<NEXT>Don't be fooled by"
    db "<NEXT>the way they look.<PROMPT>"
    db "<NEXT>You won't even"
    db "<NEXT>scratch them if<PROMPT>"
    db "<NEXT>you don't attack"
    db "<NEXT>them hard.<WAIT>"
    db "@"

Message_09_83::
    db "<VOICE2>*: …………?<LINE>"
    db "You startled me…<PROMPT>"
    db "<NEXT>I don't remember"
    db "<NEXT>who I am, what I'm<PROMPT>"
    db "<NEXT>doing here, or"
    db "<NEXT>anything else…<PROMPT>"
    db "<NEXT>I just know that I"
    db "<NEXT>need help…<PROMPT>"
    db "<NEXT>Oh? Do you know"
    db "<NEXT>who I am?<PROMPT>"
    db "<NEXT>Could I get you to"
    db "<NEXT>take me back home?<CHOICE>"
    db "@"

Message_09_B6::
    db "<VOICE2>*: You will?<LINE>"
    db "Thank you!<PROMPT>"
    db "<NEXT>Let me hide among"
    db "<NEXT>your items.<WAIT>"
    db "@"

Message_09_B7::
    db "<BUF0> obtained<LINE>"
    db "YunaSoul.<WAIT>"
    db "@"

Message_09_B8::
    db "<VOICE1>*: If you've come<LINE>"
    db "to entertain Lady<PROMPT>"
    db "<NEXT>Yuna, you", $44, " better"
    db "<NEXT>hurry in.<PROMPT>"
    db "<NEXT>Someone else could"
    db "<NEXT>win the reward!<WAIT>"
    db "@"

Message_09_BA::
    db "<VOICE1>*: Am I dreaming?<LINE>"
    db "Two Kings?<WAIT>"
    db "@"

Message_09_BB::
    db "<VOICE1>*: What? Why are<LINE>"
    db "there two Kings?<WAIT>"
    db "@"

Message_09_BC::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>It felt just a"
    db "<NEXT>little warm.<WAIT>"
    db "@"

Message_09_BD::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'History of the"
    db "<NEXT>Lake Kingdoms…<PROMPT>"
    db "<NEXT>The three Kingdoms"
    db "<NEXT>surrounding the<PROMPT>"
    db "<NEXT>lake were once a"
    db "<NEXT>single kingdom.<PROMPT>"
    db "<NEXT>The three Kingdoms"
    db "<NEXT>were formed when<PROMPT>"
    db "<NEXT>three princes were"
    db "<NEXT>allowed to divide<PROMPT>"
    db "<NEXT>the kingdom among"
    db "<NEXT>themselves.", $95, "<WAIT>"
    db "@"

Message_09_BE::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'History of the"
    db "<NEXT>Lake Kingdoms…<PROMPT>"
    db "<NEXT>The elemental"
    db "<NEXT>spirit in the<PROMPT>"
    db "<NEXT>spring is a kind-"
    db "<NEXT>hearted being who<PROMPT>"
    db "<NEXT>has watched over"
    db "<NEXT>human settlers<PROMPT>"
    db "<NEXT>since their"
    db "<NEXT>earliest days.", $95, "<WAIT>"
    db "@"

Message_09_BF::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>a noxious fluid.<WAIT>"
    db "@"

Message_09_C0::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'History of the"
    db "<NEXT>Lake Kingdoms…<PROMPT>"
    db "<NEXT>In the middle of"
    db "<NEXT>the lake is a<PROMPT>"
    db "<NEXT>tower made by a"
    db "<NEXT>wizard.<PROMPT>"
    db "<NEXT>It is said to have"
    db "<NEXT>been built in the<PROMPT>"
    db "<NEXT>distant past to"
    db "<NEXT>guard treasures.", $95, "<WAIT>"
    db "@"

Message_09_C1::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'History of the"
    db "<NEXT>Lake Kingdoms…<PROMPT>"
    db "<NEXT>Ringed by the"
    db "<NEXT>three Kingdoms,<PROMPT>"
    db "<NEXT>the lake serves as"
    db "<NEXT>their reservoir.<PROMPT>"
    db "<NEXT>It also acts as a"
    db "<NEXT>road that is never<PROMPT>"
    db "<NEXT>blocked by snow or"
    db "<NEXT>ice.", $95, "<WAIT>"
    db "@"

Message_09_C2::
    db "<VOICE1>King: The spirit<LINE>"
    db "made it possible<PROMPT>"
    db "<NEXT>for us to survive"
    db "<NEXT>the harsh cold.<PROMPT>"
    db "<NEXT>Could I ask you to"
    db "<NEXT>thank her on<PROMPT>"
    db "<NEXT>behalf of all of"
    db "<NEXT>us?<WAIT>"
    db "@"

Message_09_C3::
    db "<VOICE1>*: This tunnel<LINE>"
    db "leads to a port.<WAIT>"
    db "@"

Message_09_C4::
    db "<VOICE1>*: The ice melted<LINE>"
    db "away!<PROMPT>"
    db "<NEXT>The port can be"
    db "<NEXT>used again.<WAIT>"
    db "@"

Message_09_C5::
    db "<VOICE2>Yuna: I heard that<LINE>"
    db "you saved Queen<PROMPT>"
    db "<NEXT>Helen, isn't that"
    db "<NEXT>right?<PROMPT>"
    db "<NEXT>That means I can"
    db "<NEXT>sneak out of the<PROMPT>"
    db "<NEXT>Castle without"
    db "<NEXT>worry again!<WAIT>"
    db "@"

Message_09_C6::
    db "<VOICE1>*: Queen Helen came<LINE>"
    db "by the other day,<PROMPT>"
    db "<NEXT>so I found my"
    db "<NEXT>courage and said,<PROMPT>"
    db "<NEXT>", $aa, "Hello,", $aa, " to her."
    db "<NEXT>Do you know what?<PROMPT>"
    db "<NEXT>She gave me a"
    db "<NEXT>really nice smile<PROMPT>"
    db "<NEXT>and said, ", $aa, "Hello,", $aa
    db "<NEXT>right back!<WAIT>"
    db "@"

Message_09_C7::
    db "<VOICE1>*: Queen Helen's<LINE>"
    db "dreams come true<PROMPT>"
    db "<NEXT>more often than"
    db "<NEXT>not.<WAIT>"
    db "@"
    ds $45, $00
