; ROM bank $89: messages
; The annotated listing of this bank is build/listing/bank89.asm.

SECTION "Bank 89", ROMX[$4000], BANK[$89]
    db $89

; message bank $89: when wStringIndex < $DE, BeginStringDisplay with this bank's table
; MessageStrings_Bank89; otherwise far-calls BeginStringDisplay_Bank89_Overflow (E-0080)
BeginStringDisplay_Bank89::
    ld a, [wStringIndex]
    cp $de
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank89_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank89
    call BeginStringDisplay
    ret

; message bank $89: when wStringIndex < $DE, CopyStringToBuffer with this bank's table
; MessageStrings_Bank89; otherwise far-calls CopyStringToBuffer_Bank89_Overflow (E-0080)
CopyStringToBuffer_Bank89::
    ld a, [wStringIndex]
    cp $de
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank89_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank89
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_89::
; data read by BeginStringDisplay_Bank89 (1 word) (E-0347)
MessageStrings_Bank89::
    dw StringList_Bank89_0 ; id 0

; category list of StringCategories_89; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank89_0::
    dw Message_0D_00 ; id 0
    dw Message_0D_01 ; id 1
    dw Message_0D_02 ; id 2
    dw Message_0D_03 ; id 3
    dw Message_0D_04 ; id 4
    dw Message_0D_05 ; id 5
    dw Message_0D_06 ; id 6
    dw Message_0D_07 ; id 7
    dw Message_0D_08 ; id 8
    dw Message_0D_09 ; id 9
    dw Message_0D_0A ; id 10
    dw Message_0D_0B ; id 11
    dw Message_0D_0C ; id 12
    dw Message_0D_0D ; id 13
    dw Message_0D_0E ; id 14
    dw Message_0D_0F ; id 15
    dw Message_0D_10 ; id 16
    dw Message_0D_11 ; id 17
    dw Message_0D_12 ; id 18
    dw Message_0D_13 ; id 19
    dw Message_0D_14 ; id 20
    dw Message_0D_15 ; id 21
    dw Message_0D_16 ; id 22
    dw Message_0D_17 ; id 23
    dw Message_0D_18 ; id 24
    dw Message_0D_19 ; id 25
    dw Message_0D_1A ; id 26
    dw Message_0D_1B ; id 27
    dw Message_0D_1C ; id 28
    dw Message_0D_1D ; id 29
    dw Message_0D_1E ; id 30
    dw Message_0D_1F ; id 31
    dw Message_0D_20 ; id 32
    dw Message_0D_21 ; id 33
    dw Message_0D_22 ; id 34
    dw Message_0D_23 ; id 35
    dw Message_0D_24 ; id 36
    dw Message_0D_25 ; id 37
    dw Message_0D_26 ; id 38
    dw Message_0D_27 ; id 39
    dw Message_0D_28 ; id 40
    dw Message_0D_29 ; id 41
    dw Message_0D_2A ; id 42
    dw Message_0D_2B ; id 43
    dw Message_0D_2C ; id 44
    dw Message_0D_2D ; id 45
    dw Message_0D_2E ; id 46
    dw Message_0D_2F ; id 47
    dw Message_0D_30 ; id 48
    dw Message_0D_31 ; id 49
    dw Message_0D_32 ; id 50
    dw Message_0D_33 ; id 51
    dw Message_0D_34 ; id 52
    dw Message_0D_35 ; id 53
    dw Message_0D_36 ; id 54
    dw Message_0D_37 ; id 55
    dw Message_0D_38 ; id 56
    dw Message_0D_39 ; id 57
    dw Message_0D_3A ; id 58
    dw Message_0D_3B ; id 59
    dw Message_0D_3C ; id 60
    dw Message_0D_3D ; id 61
    dw Message_0D_3E ; id 62
    dw Message_0D_3F ; id 63
    dw Message_0D_40 ; id 64
    dw Message_0D_41 ; id 65
    dw Message_0D_42 ; id 66
    dw Message_0D_43 ; id 67
    dw Message_0D_44 ; id 68
    dw Message_0D_45 ; id 69
    dw Message_0D_46 ; id 70
    dw Message_0D_47 ; id 71
    dw Message_0D_48 ; id 72
    dw Message_0D_49 ; id 73
    dw Message_0D_4A ; id 74
    dw Message_0D_4B ; id 75
    dw Message_0D_4C ; id 76
    dw Message_0D_4D ; id 77
    dw Message_0D_4E ; id 78
    dw Message_0D_4F ; id 79
    dw Message_0D_4F ; id 80
    dw Message_0D_51 ; id 81
    dw Message_0D_52 ; id 82
    dw Message_0D_53 ; id 83
    dw Message_0D_53 ; id 84
    dw Message_0D_53 ; id 85
    dw Message_0D_56 ; id 86
    dw Message_0D_57 ; id 87
    dw Message_0D_58 ; id 88
    dw Message_0D_58 ; id 89
    dw Message_0D_58 ; id 90
    dw Message_0D_58 ; id 91
    dw Message_0D_58 ; id 92
    dw Message_0D_58 ; id 93
    dw Message_0D_58 ; id 94
    dw Message_0D_58 ; id 95
    dw Message_0D_58 ; id 96
    dw Message_0D_61 ; id 97
    dw Message_0D_62 ; id 98
    dw Message_0D_63 ; id 99
    dw Message_0D_64 ; id 100
    dw Message_0D_65 ; id 101
    dw Message_0D_66 ; id 102
    dw Message_0D_67 ; id 103
    dw Message_0D_68 ; id 104
    dw Message_0D_69 ; id 105
    dw Message_0D_69 ; id 106
    dw Message_0D_69 ; id 107
    dw Message_0D_69 ; id 108
    dw Message_0D_69 ; id 109
    dw Message_0D_69 ; id 110
    dw Message_0D_69 ; id 111
    dw Message_0D_69 ; id 112
    dw Message_0D_69 ; id 113
    dw Message_0D_69 ; id 114
    dw Message_0D_69 ; id 115
    dw Message_0D_69 ; id 116
    dw Message_0D_69 ; id 117
    dw Message_0D_69 ; id 118
    dw Message_0D_69 ; id 119
    dw Message_0D_69 ; id 120
    dw Message_0D_69 ; id 121
    dw Message_0D_69 ; id 122
    dw Message_0D_69 ; id 123
    dw Message_0D_69 ; id 124
    dw Message_0D_69 ; id 125
    dw Message_0D_69 ; id 126
    dw Message_0D_69 ; id 127
    dw Message_0D_69 ; id 128
    dw Message_0D_81 ; id 129
    dw Message_0D_82 ; id 130
    dw Message_0D_83 ; id 131
    dw Message_0D_84 ; id 132
    dw Message_0D_85 ; id 133
    dw Message_0D_86 ; id 134
    dw Message_0D_87 ; id 135
    dw Message_0D_88 ; id 136
    dw Message_0D_89 ; id 137
    dw Message_0D_8A ; id 138
    dw Message_0D_8B ; id 139
    dw Message_0D_8C ; id 140
    dw Message_0D_8D ; id 141
    dw Message_0D_8E ; id 142
    dw Message_0D_8F ; id 143
    dw Message_0D_90 ; id 144
    dw Message_0D_91 ; id 145
    dw Message_0D_92 ; id 146
    dw Message_0D_93 ; id 147
    dw Message_0D_94 ; id 148
    dw Message_0D_95 ; id 149
    dw Message_0D_96 ; id 150
    dw Message_0D_96 ; id 151
    dw Message_0D_96 ; id 152
    dw Message_0D_96 ; id 153
    dw Message_0D_96 ; id 154
    dw Message_0D_96 ; id 155
    dw Message_0D_96 ; id 156
    dw Message_0D_96 ; id 157
    dw Message_0D_96 ; id 158
    dw Message_0D_96 ; id 159
    dw Message_0D_96 ; id 160
    dw Message_0D_A1 ; id 161
    dw Message_0D_A2 ; id 162
    dw Message_0D_A2 ; id 163
    dw Message_0D_A2 ; id 164
    dw Message_0D_A2 ; id 165
    dw Message_0D_A2 ; id 166
    dw Message_0D_A2 ; id 167
    dw Message_0D_A2 ; id 168
    dw Message_0D_A2 ; id 169
    dw Message_0D_A2 ; id 170
    dw Message_0D_A2 ; id 171
    dw Message_0D_A2 ; id 172
    dw Message_0D_A2 ; id 173
    dw Message_0D_A2 ; id 174
    dw Message_0D_A2 ; id 175
    dw Message_0D_A2 ; id 176
    dw Message_0D_B1 ; id 177
    dw Message_0D_B2 ; id 178
    dw Message_0D_B3 ; id 179
    dw Message_0D_B4 ; id 180
    dw Message_0D_B5 ; id 181
    dw Message_0D_B6 ; id 182
    dw Message_0D_B7 ; id 183
    dw Message_0D_B8 ; id 184
    dw Message_0D_B9 ; id 185
    dw Message_0D_BA ; id 186
    dw Message_0D_BB ; id 187
    dw Message_0D_BB ; id 188
    dw Message_0D_BB ; id 189
    dw Message_0D_BB ; id 190
    dw Message_0D_BB ; id 191
    dw Message_0D_BB ; id 192
    dw Message_0D_C1 ; id 193
    dw Message_0D_C2 ; id 194
    dw Message_0D_C3 ; id 195
    dw Message_0D_C4 ; id 196
    dw Message_0D_C5 ; id 197
    dw Message_0D_C6 ; id 198
    dw Message_0D_C7 ; id 199
    dw Message_0D_C8 ; id 200
    dw Message_0D_C9 ; id 201
    dw Message_0D_CA ; id 202
    dw Message_0D_CB ; id 203
    dw Message_0D_CC ; id 204
    dw Message_0D_CD ; id 205
    dw Message_0D_CE ; id 206
    dw Message_0D_CF ; id 207
    dw Message_0D_D0 ; id 208
    dw Message_0D_D1 ; id 209
    dw Message_0D_D2 ; id 210
    dw Message_0D_D3 ; id 211
    dw Message_0D_D4 ; id 212
    dw Message_0D_D5 ; id 213
    dw Message_0D_D6 ; id 214
    dw Message_0D_D7 ; id 215
    dw Message_0D_D8 ; id 216
    dw Message_0D_D9 ; id 217
    dw Message_0D_DA ; id 218
    dw Message_0D_DB ; id 219
    dw Message_0D_DC ; id 220
    dw Message_0D_DD ; id 221

Message_0D_00::
    db "<VOICE1>*: They say you use<LINE>"
    db "Magic Keys to go<PROMPT>"
    db "<NEXT>to other worlds."
    db "<NEXT>I guess they're<PROMPT>"
    db "<NEXT>indispensable to"
    db "<NEXT>monster masters.<WAIT>"
    db "@"

Message_0D_01::
    db "<VOICE1>King: Then, you<LINE>"
    db "are excused.<PROMPT>"
    db "<NEXT>I'm looking"
    db "<NEXT>forward to the<PROMPT>"
    db "<NEXT>next show."
    db "<NEXT><WAIT>"
    db "@"

Message_0D_02::
    db "<VOICE1>King: You wish to<LINE>"
    db "see our treasures?<PROMPT>"
    db "<NEXT>You're quite sharp"
    db "<NEXT>to have an eye out<PROMPT>"
    db "<NEXT>for treasures, I"
    db "<NEXT>must say.<WAIT>"
    db "@"

Message_0D_03::
    db "<VOICE1>*: That will help<LINE>"
    db "you for certain.<PROMPT>"
    db "<NEXT>Use it where you"
    db "<NEXT>feel it is right.<WAIT>"
    db "@"

Message_0D_04::
    db "<VOICE2>*: Hello, have you<LINE>"
    db "found a plug for<PROMPT>"
    db "<NEXT>the Log's Navel?"
    db "<NEXT><CHOICE>"
    db "@"

Message_0D_05::
    db "<VOICE2>*: Oh. That's nice.<LINE>"
    db "Good for you.<WAIT>"
    db "@"

Message_0D_06::
    db "<VOICE2>*: I can show you<LINE>"
    db "my navel if you<PROMPT>"
    db "<NEXT>promise to keep it"
    db "<NEXT>a secret.<WAIT>"
    db "@"

Message_0D_07::
    db "<VOICE1>*: The shortage of<LINE>"
    db "water has been<PROMPT>"
    db "<NEXT>corrected, and the"
    db "<NEXT>gang of thieves<PROMPT>"
    db "<NEXT>was finally caught"
    db "<NEXT>and jailed.<PROMPT>"
    db "<NEXT>We won't have to"
    db "<NEXT>worry about those<PROMPT>"
    db "<NEXT>things anymore,"
    db "<NEXT>thank goodness.<WAIT>"
    db "@"

Message_0D_08::
    db "<VOICE1>*: Oh, it's you lot.<LINE>"
    db "We haven't had any<PROMPT>"
    db "<NEXT>problems with the"
    db "<NEXT>reservoir.<WAIT>"
    db "@"

Message_0D_09::
    db "<VOICE2>*: The well filled<LINE>"
    db "up with water<PROMPT>"
    db "<NEXT>again."
    db "<NEXT>I don't have any<PROMPT>"
    db "<NEXT>excuse not to do"
    db "<NEXT>laundry anymore.<WAIT>"
    db "@"

Message_0D_0A::
    db "<VOICE1>*: The band of<LINE>"
    db "thieves made their<PROMPT>"
    db "<NEXT>hideout in Mirage"
    db "<NEXT>Lake.<PROMPT>"
    db "<NEXT>Staying away from"
    db "<NEXT>Mirage Lake was a<PROMPT>"
    db "<NEXT>smart thing in"
    db "<NEXT>hindsight.<WAIT>"
    db "@"

Message_0D_0B::
    db "<VOICE1>*: The King gave<LINE>"
    db "away his prized<PROMPT>"
    db "<NEXT>TidalBell to some"
    db "<NEXT>traveler as a<PROMPT>"
    db "<NEXT>reward of some"
    db "<NEXT>sort.<PROMPT>"
    db "<NEXT>I didn't know that"
    db "<NEXT>our King could be<PROMPT>"
    db "<NEXT>so generous."
    db "<NEXT><WAIT>"
    db "@"

Message_0D_0C::
    db "<VOICE1>*: Up ahead is the<LINE>"
    db "Starry Shrine, and<PROMPT>"
    db "<NEXT>the Egg Evaluator's"
    db "<NEXT>chamber.<PROMPT>"
    db "<NEXT>Both of them offer"
    db "<NEXT>essential services<PROMPT>"
    db "<NEXT>to masters, but"
    db "<NEXT>they're always<PROMPT>"
    db "<NEXT>packed by other"
    db "<NEXT>masters.<PROMPT>"
    db "<NEXT>It looks like I'll"
    db "<NEXT>be waiting here<PROMPT>"
    db "<NEXT>for a long time…"
    db "<NEXT><WAIT>"
    db "@"

Message_0D_0D::
    db "<VOICE1>*: While I was on<LINE>"
    db "the way to the<PROMPT>"
    db "<NEXT>Magic Door, I saw"
    db "<NEXT>Warubou stuck in a<PROMPT>"
    db "<NEXT>hole for some"
    db "<NEXT>unknown reason.<PROMPT>"
    db "<NEXT>What the heck was"
    db "<NEXT>it doing?<WAIT>"
    db "@"

Message_0D_0E::
    db "<VOICE2>*: You're really<LINE>"
    db "trying to become a<PROMPT>"
    db "<NEXT>monster master?"
    db "<NEXT>Well, go for it!<PROMPT>"
    db "<NEXT>I'll be cheering"
    db "<NEXT>you on!<WAIT>"
    db "@"

Message_0D_0F::
    db "<VOICE1>*: Hm, you are<LINE>"
    db "quite strong…<PROMPT>"
    db "<NEXT>I have to admit"
    db "<NEXT>I'm impressed.<PROMPT>"
    db "<NEXT>Will you let me go"
    db "<NEXT>with you?<PROMPT>"
    db "<NEXT>You'll find my"
    db "<NEXT>dancing special!<CHOICE>"
    db "@"

Message_0D_10::
    db "<VOICE1>*: Great! Let's<LINE>"
    db "make this work!<WAIT>"
    db "@"

Message_0D_11::
    db "<VOICE1>*: Your party's<LINE>"
    db "full…<PROMPT>"
    db "<NEXT>There isn't any"
    db "<NEXT>room for me.<WAIT>"
    db "@"

Message_0D_12::
    db "<VOICE1>*: Oh, but… I can<LINE>"
    db "be so useful…<WAIT>"
    db "@"

Message_0D_13::
    db "<VOICE1>*: The lighthouse<LINE>"
    db "is out east.<PROMPT>"
    db "<NEXT>Stay away-it's"
    db "<NEXT>dangerous.<PROMPT>"
    db "<NEXT>Even though the"
    db "<NEXT>MoonRock has been<PROMPT>"
    db "<NEXT>recovered from"
    db "<NEXT>pirates and put<PROMPT>"
    db "<NEXT>back where it"
    db "<NEXT>belongs, monsters<PROMPT>"
    db "<NEXT>still roam freely"
    db "<NEXT>in the lighthouse.<WAIT>"
    db "@"

Message_0D_14::
    db "<VOICE1>*: Another master<LINE>"
    db "was here with two<PROMPT>"
    db "<NEXT>monsters in tow a"
    db "<NEXT>while back.<PROMPT>"
    db "<NEXT>I think his name"
    db "<NEXT>was Kameha.<PROMPT>"
    db "<NEXT>I haven't seen him"
    db "<NEXT>since then.<PROMPT>"
    db "<NEXT>I wonder where"
    db "<NEXT>he's gone?<WAIT>"
    db "@"

Message_0D_15::
    db "<VOICE1>*: OK! Let me dig!<LINE>"
    db "One-two, one-two!<PROMPT>"
    db "<NEXT>Huh? I just hit"
    db "<NEXT>something hard.<WAIT>"
    db "@"

Message_0D_16::
    db "<VOICE1>*: What's wrong,<LINE>"
    db "MadGopher?<PROMPT>"
    db "<NEXT>Did you find"
    db "<NEXT>something?<PROMPT>"
    db "<NEXT>Hey, that's a"
    db "<NEXT>Magic Key!<PROMPT>"
    db "<NEXT>That's great work,"
    db "<NEXT>MadGopher!<WAIT>"
    db "@"

Message_0D_17::
    db "<VOICE1>*: Here, <BUF0>!<LINE>"
    db "You need this!<WAIT>"
    db "@"

Message_0D_18::
    db "<BUF0> received the<LINE>"
    db "Ice Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_0D_19::
    db "<VOICE1>*: Be careful when<LINE>"
    db "you're traveling<PROMPT>"
    db "<NEXT>in other worlds."
    db "<NEXT><WAIT>"
    db "@"

Message_0D_1A::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "find another Magic<PROMPT>"
    db "<NEXT>Key in GreatLog"
    db "<NEXT>and off you go to<PROMPT>"
    db "<NEXT>another world,"
    db "<NEXT>warooh.<PROMPT>"
    db "<NEXT>The Ice Key is"
    db "<NEXT>what you want.<WAIT>"
    db "@"

Message_0D_1B::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>! Too slow!<PROMPT>"
    db "<NEXT>Kameha went to"
    db "<NEXT>another world<PROMPT>"
    db "<NEXT>before you again,"
    db "<NEXT>warooh!<PROMPT>"
    db "<NEXT>But then it doesn't"
    db "<NEXT>matter who gets<PROMPT>"
    db "<NEXT>the job done, you"
    db "<NEXT>or Kameha…<PROMPT>"
    db "<NEXT>But after last"
    db "<NEXT>time, you can be<PROMPT>"
    db "<NEXT>trusted more than"
    db "<NEXT>Kameha, I think.<PROMPT>"
    db "<NEXT>This time, you'll"
    db "<NEXT>find a plug, yes?<PROMPT>"
    db "<NEXT>Oh, and don't"
    db "<NEXT>forget, you have<PROMPT>"
    db "<NEXT>new abilities for"
    db "<NEXT>crossing water and<PROMPT>"
    db "<NEXT>smashing boulders."
    db "<NEXT>Don't forget!<WAIT>"
    db "@"

Message_0D_1C::
    db "<VOICE1>*: The King of the<LINE>"
    db "north was a fake,<PROMPT>"
    db "<NEXT>or so I've heard."
    db "<NEXT>Why though?<PROMPT>"
    db "<NEXT>Why would a"
    db "<NEXT>monster want to<PROMPT>"
    db "<NEXT>impersonate a"
    db "<NEXT>king?<WAIT>"
    db "@"

Message_0D_1D::
    db "<VOICE1>*: If you go south,<LINE>"
    db "you'll eventually<PROMPT>"
    db "<NEXT>reach the town of"
    db "<NEXT>Weston.<PROMPT>"
    db "<NEXT>From there, go up"
    db "<NEXT>a river and travel<PROMPT>"
    db "<NEXT>west to reach the"
    db "<NEXT>castle.<WAIT>"
    db "@"

Message_0D_1E::
    db "<VOICE1>*: Oh… Lady Yuna…<LINE>"
    db "I miss you so…<PROMPT>"
    db "<NEXT>I should find"
    db "<NEXT>my courage and<PROMPT>"
    db "<NEXT>climb the vines to"
    db "<NEXT>her window…<PROMPT>"
    db "<NEXT>No, I mustn't do"
    db "<NEXT>that…<WAIT>"
    db "@"

Message_0D_1F::
    db "<VOICE1>*: How can we help<LINE>"
    db "Queen Helen?<PROMPT>"
    db "<NEXT>If there was a"
    db "<NEXT>good medicine…<PROMPT>"
    db "<NEXT>Perhaps we should"
    db "<NEXT>ask the scholar…<PROMPT>"
    db "<NEXT>But the scholar"
    db "<NEXT>has gone off to<PROMPT>"
    db "<NEXT>Nofor… What to do,"
    db "<NEXT>what to do…<WAIT>"
    db "@"

Message_0D_20::
    db "<VOICE1>*: Oh! That blue<LINE>"
    db "flower!<PROMPT>"
    db "<NEXT>It's unmistakably"
    db "<NEXT>the SleepHerb!<PROMPT>"
    db "<NEXT>All you need to do"
    db "<NEXT>is eat its leaves.<PROMPT>"
    db "<NEXT>As soon as you do,"
    db "<NEXT>you drop off to a<PROMPT>"
    db "<NEXT>deep and relaxing"
    db "<NEXT>sleep.<WAIT>"
    db "@"

Message_0D_21::
    db "<VOICE2>*: Star spuds grow<LINE>"
    db "plentifully around<PROMPT>"
    db "<NEXT>these parts. They"
    db "<NEXT>are spuds that<PROMPT>"
    db "<NEXT>grow by the light"
    db "<NEXT>of the stars.<PROMPT>"
    db "<NEXT>They're gifts from"
    db "<NEXT>the spirit.<WAIT>"
    db "@"

Message_0D_22::
    db "<VOICE1>*: Out at the<LINE>"
    db "western castle,<PROMPT>"
    db "<NEXT>I heard that no"
    db "<NEXT>one managed to<PROMPT>"
    db "<NEXT>cheer up Lady Yuna"
    db "<NEXT>in the end.<PROMPT>"
    db "<NEXT>So, nobody got the"
    db "<NEXT>reward.<WAIT>"
    db "@"

Message_0D_23::
    db "<VOICE1>*: I just heard a<LINE>"
    db "rumor…<PROMPT>"
    db "<NEXT>The girl's ghost"
    db "<NEXT>seems to be gone.<WAIT>"
    db "@"

Message_0D_24::
    db "<VOICE1>*: Now that I think<LINE>"
    db "about it, I'm not<PROMPT>"
    db "<NEXT>sure what I saw"
    db "<NEXT>was a ghost.<PROMPT>"
    db "<NEXT>I may have been"
    db "<NEXT>mistaken, even.<PROMPT>"
    db "<NEXT>In fact, I'm sure"
    db "<NEXT>I was wrong!<WAIT>"
    db "@"

Message_0D_25::
    db "<VOICE1>*: ArmyAnt's help<LINE>"
    db "means I can open<PROMPT>"
    db "<NEXT>my shop just as I"
    db "<NEXT>had planned.<WAIT>"
    db "@"

Message_0D_26::
    db "<VOICE1>*: Hup, hup, hup!<LINE>"
    db "Heh, this stuff is<PROMPT>"
    db "<NEXT>nothing to move"
    db "<NEXT>around!<WAIT>"
    db "@"

Message_0D_27::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>The Crest was"
    db "<NEXT>found.<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it…<WAIT>"
    db "@"

Message_0D_28::
    db "<BUF0> obtained the<LINE>"
    db "Sky Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_0D_29::
    db "<VOICE1>King: Kameha made<LINE>"
    db "off with the Key's<PROMPT>"
    db "<NEXT>duplicate from the"
    db "<NEXT>Castle.<PROMPT>"
    db "<NEXT>I can imagine him"
    db "<NEXT>being a nuisance,<PROMPT>"
    db "<NEXT>but I'm counting"
    db "<NEXT>on your support.<WAIT>"
    db "@"

Message_0D_2A::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "find another Magic<PROMPT>"
    db "<NEXT>Key in GreatLog"
    db "<NEXT>and you go off to<PROMPT>"
    db "<NEXT>another world,"
    db "<NEXT>warooh.<PROMPT>"
    db "<NEXT>The Sky Key, I"
    db "<NEXT>think it is.<WAIT>"
    db "@"

Message_0D_2B::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>!<PROMPT>"
    db "<NEXT>You have the Sky"
    db "<NEXT>Key, warooh.<PROMPT>"
    db "<NEXT>Kameha took off"
    db "<NEXT>before you again.<PROMPT>"
    db "<NEXT>I'm beginning to"
    db "<NEXT>suffer from this…<PROMPT>"
    db "<NEXT>This time, you'll"
    db "<NEXT>find a plug, yes?<PROMPT>"
    db "<NEXT>Oh, and now, you"
    db "<NEXT>have the ability<PROMPT>"
    db "<NEXT>to summon a cloud"
    db "<NEXT>and fly.<PROMPT>"
    db "<NEXT>Sky Shield gave"
    db "<NEXT>you that ability.<PROMPT>"
    db "<NEXT>Keep that in mind,"
    db "<NEXT>warooh!<WAIT>"
    db "@"

Message_0D_2C::
    db "<VOICE1>*: That giant bird<LINE>"
    db "hasn't flown over<PROMPT>"
    db "<NEXT>for a while."
    db "<NEXT><WAIT>"
    db "@"

Message_0D_2D::
    db "<VOICE1>*: Was that bird<LINE>"
    db "going after the<PROMPT>"
    db "<NEXT>LightOrb?"
    db "<NEXT><WAIT>"
    db "@"

Message_0D_2E::
    db "<VOICE1>*: They say the<LINE>"
    db "giant bird has<PROMPT>"
    db "<NEXT>disappeared."
    db "<NEXT>I wonder if it's<PROMPT>"
    db "<NEXT>safe for me to go"
    db "<NEXT>outside now…<WAIT>"
    db "@"

Message_0D_2F::
    db "<VOICE1>*: The giant bird<LINE>"
    db "took off with a<PROMPT>"
    db "<NEXT>human child…"
    db "<NEXT>Is he safe now?<WAIT>"
    db "@"

Message_0D_30::
    db "<VOICE1>*: What if the<LINE>"
    db "island sinks, and<PROMPT>"
    db "<NEXT>you return from"
    db "<NEXT>another world?<PROMPT>"
    db "<NEXT>Would you suddenly"
    db "<NEXT>appear underwater?<WAIT>"
    db "@"

Message_0D_31::
    db "<VOICE1>*: For the sake of<LINE>"
    db "my grandchild, it<PROMPT>"
    db "<NEXT>may be best that"
    db "<NEXT>we leave.<PROMPT>"
    db "<NEXT>She may make"
    db "<NEXT>friends elsewhere.<WAIT>"
    db "@"

Message_0D_32::
    db "<VOICE2>*: Do we have to<LINE>"
    db "leave GreatLog?<PROMPT>"
    db "<NEXT>It doesn't matter,"
    db "<NEXT>though.<PROMPT>"
    db "<NEXT>There's nothing"
    db "<NEXT>here for me.<WAIT>"
    db "@"

Message_0D_33::
    db "<VOICE1>*: You saved us all<LINE>"
    db "by yourself.<PROMPT>"
    db "<NEXT>Your future is so"
    db "<NEXT>full of promise!<WAIT>"
    db "@"

Message_0D_34::
    db "<VOICE1>*: Please, eat up,<LINE>"
    db "eat up!<PROMPT>"
    db "<NEXT>Don't worry about"
    db "<NEXT>your manners!<WAIT>"
    db "@"

Message_0D_35::
    db "<VOICE1>*: Hm? I saw your<LINE>"
    db "family.<PROMPT>"
    db "<NEXT>They were up on"
    db "<NEXT>the treetop.<WAIT>"
    db "@"

Message_0D_36::
    db "<VOICE1>*: The Kingdom is<LINE>"
    db "rejoicing!<WAIT>"
    db "@"

Message_0D_37::
    db "<VOICE1>*: Instead of<LINE>"
    db "standing around,<PROMPT>"
    db "<NEXT>you should go and"
    db "<NEXT>enjoy yourselves.<WAIT>"
    db "@"

Message_0D_38::
    db "<VOICE1>*: Just imagine if<LINE>"
    db "you weren't here.<PROMPT>"
    db "<NEXT>That's a sobering"
    db "<NEXT>thought.<WAIT>"
    db "@"

Message_0D_39::
    db "<VOICE1>*: Ah, GreatLog's<LINE>"
    db "mighty hero!<PROMPT>"
    db "<NEXT>I hope you're"
    db "<NEXT>enjoying this!<WAIT>"
    db "@"

Message_0D_3A::
    db "<VOICE1>*: To be honest, I<LINE>"
    db "was getting ready<PROMPT>"
    db "<NEXT>to clear out."
    db "<NEXT>You saved us!<WAIT>"
    db "@"

Message_0D_3B::
    db "<VOICE1>*: Whinny!<WAIT>"
    db "@"

Message_0D_3C::
    db "<VOICE2>*: …………!<WAIT>"
    db "@"

Message_0D_3D::
    db "<VOICE1>*: They say Lady<LINE>"
    db "Yuna is back to<PROMPT>"
    db "<NEXT>her usual cheerful"
    db "<NEXT>self.<PROMPT>"
    db "<NEXT>Perhaps she's still"
    db "<NEXT>too young to mope<PROMPT>"
    db "<NEXT>over matters of"
    db "<NEXT>the heart…<WAIT>"
    db "@"

Message_0D_3E::
    db "<VOICE1>*: Huh? There is<LINE>"
    db "something here.<PROMPT>"
    db "<NEXT>Under the"
    db "<NEXT>merchandise.<WAIT>"
    db "@"

Message_0D_3F::
    db "<VOICE1>*: What's that?<LINE>"
    db "Hey, a TinyMedal!<PROMPT>"
    db "<NEXT>That took good,"
    db "<NEXT>compound eyes to<PROMPT>"
    db "<NEXT>spot on the ground"
    db "<NEXT>like that!<WAIT>"
    db "@"

Message_0D_40::
    db "<VOICE1>*: I", $44, " like you to<LINE>"
    db "have this.<PROMPT>"
    db "<NEXT>Sort of a thanks"
    db "<NEXT>for ArmyAnt.<WAIT>"
    db "@"

Message_0D_41::
    db "<BUF0> received a<LINE>"
    db "TinyMedal!<WAIT>"
    db "@"

Message_0D_42::
    db "<VOICE1>*: I'll pray for<LINE>"
    db "your safety.<PROMPT>"
    db "<NEXT>Take good care of"
    db "<NEXT>yourself.<WAIT>"
    db "@"

Message_0D_43::
    db "<VOICE1>*: I", $44, " like you to<LINE>"
    db "have this.<PROMPT>"
    db "<NEXT>Sort of a thanks"
    db "<NEXT>for ArmyAnt.<PROMPT>"
    db "<NEXT>Oh, wait. There's"
    db "<NEXT>no room for this.<PROMPT>"
    db "<NEXT>I'll leave it with"
    db "<NEXT>my ArmyAnt, so be<PROMPT>"
    db "<NEXT>sure to come get"
    db "<NEXT>it later.<WAIT>"
    db "@"

Message_0D_44::
    db "<VOICE1>*: Here it is-the<LINE>"
    db "TinyMedal.<PROMPT>"
    db "<NEXT>My master had me"
    db "<NEXT>hold it for you.<WAIT>"
    db "@"

Message_0D_45::
    db "<VOICE1>*: Here it is-the<LINE>"
    db "TinyMedal.<PROMPT>"
    db "<NEXT>My master had me"
    db "<NEXT>hold it for you.<PROMPT>"
    db "<NEXT>…You still don't"
    db "<NEXT>have room for it…<WAIT>"
    db "@"

Message_0D_46::
    db "<VOICE1>*: What's wrong,<LINE>"
    db "MadGopher?<PROMPT>"
    db "<NEXT>Did you dig"
    db "<NEXT>something up?<PROMPT>"
    db "<NEXT>Oh, hey!"
    db "<NEXT>That's a TinyMedal!<PROMPT>"
    db "<NEXT>Good going,"
    db "<NEXT>MadGopher!<WAIT>"
    db "@"

Message_0D_47::
    db "<VOICE1>*: Here, <BUF0>!<LINE>"
    db "You hold onto it.<WAIT>"
    db "@"

Message_0D_48::
    db "<VOICE1>*: Here, <BUF0>!<LINE>"
    db "You hold onto it.<PROMPT>"
    db "<NEXT>Oh, but look, you"
    db "<NEXT>have no room.<PROMPT>"
    db "<NEXT>MadGopher will"
    db "<NEXT>hold it for you.<WAIT>"
    db "@"

Message_0D_49::
    db "<VOICE1>*: Here's that<LINE>"
    db "TinyMedal.<WAIT>"
    db "@"

Message_0D_4A::
    db "<VOICE1>*: Here's that<LINE>"
    db "TinyMedal.<PROMPT>"
    db "<NEXT>…Wait, you still"
    db "<NEXT>have no room.<WAIT>"
    db "@"

Message_0D_4B::
    db "<VOICE1>*: What's that?<LINE>"
    db "Hey, a Magic Key!<PROMPT>"
    db "<NEXT>How did you manage"
    db "<NEXT>to find that?<WAIT>"
    db "@"

Message_0D_4C::
    db "<VOICE2>*: …………?<LINE>"
    db "You startled me…<PROMPT>"
    db "<NEXT>I don't remember"
    db "<NEXT>who I am, what I'm<PROMPT>"
    db "<NEXT>doing here, or"
    db "<NEXT>anything else…<PROMPT>"
    db "<NEXT>I just know that I"
    db "<NEXT>need help…<PROMPT>"
    db "<NEXT>But you don't seem"
    db "<NEXT>to know who I am…<WAIT>"
    db "@"

Message_0D_4D::
    db "<VOICE2>*: I don't remember<LINE>"
    db "who I am, what I'm<PROMPT>"
    db "<NEXT>doing here, or"
    db "<NEXT>anything else…<PROMPT>"
    db "<NEXT>I just know that I"
    db "<NEXT>need help…<PROMPT>"
    db "<NEXT>But you don't seem"
    db "<NEXT>to know who I am…<WAIT>"
    db "@"

Message_0D_4E::
    db "<VOICE1>*: I'm digging here<LINE>"
    db "because I think<PROMPT>"
    db "<NEXT>this hole leads"
    db "<NEXT>somewhere…<WAIT>"
    db "@"

Message_0D_4F::
    db "Pick the monster<LINE>"
    db "to go to the farm.<WAIT>"
    db "@"

Message_0D_51::
    db "<BUF>", $17, " joined<LINE>"
    db "the party.<MUSIC_WAIT>", $d6, "<WAIT>"
    db "@"

Message_0D_52::
    db "<BUF>", $17, " headed off<LINE>"
    db "to the farm.<MUSIC_WAIT>", $d6, "<WAIT>"
    db "@"

Message_0D_53::
    db "<VOICE1>*: …Wait, the farm<LINE>"
    db "is full…<WAIT>"
    db "@"

Message_0D_56::
    db "<VOICE1>*: Let me join your<LINE>"
    db "party?<CHOICE>"
    db "@"

Message_0D_57::
    db "<VOICE1>*: …The farm has no<LINE>"
    db "room left for me…<WAIT>"
    db "@"

Message_0D_58::
    db "What will you give<LINE>"
    db "to the Egg?<WAIT>"
    db "@"

Message_0D_61::
    db "<BUF>", $22, " has been<LINE>"
    db "given to the Egg.<PROMPT>"
    db "<NEXT>What will you give"
    db "<NEXT>it next?<WAIT>"
    db "@"

Message_0D_62::
    db "The farm is full.<WAIT>"
    db "@"

Message_0D_63::
    db "Lamia entered<LINE>"
    db "the farm.<WAIT>"
    db "@"

Message_0D_64::
    db "Dimensaur entered<LINE>"
    db "the farm.<WAIT>"
    db "@"

Message_0D_65::
    db "Kagebou entered<LINE>"
    db "the farm.<WAIT>"
    db "@"

Message_0D_66::
    db "<BUF0> cataloged<LINE>"
    db "100 monsters.<WAIT>"
    db "@"

Message_0D_67::
    db "<BUF0> cataloged<LINE>"
    db "200 monsters.<WAIT>"
    db "@"

Message_0D_68::
    db "<BUF0> cataloged<LINE>"
    db "all the monsters.<WAIT>"
    db "@"

Message_0D_69::
    db "<VOICE2>*: Really? Let's go<LINE>"
    db "to the Arena!<WAIT>"
    db "@"

Message_0D_81::
    db "<VOICE2>*: Aww… How boring…<LINE>"
    db "Visit us again!<WAIT>"
    db "@"

Message_0D_82::
    db "<VOICE2>*: Aww… I lose.<LINE>"
    db "You are good!<PROMPT>"
    db "<NEXT>I wasn't trying"
    db "<NEXT>very hard…<PROMPT>"
    db "<NEXT>Eheheh, actually,"
    db "<NEXT>I did want to win.<WAIT>"
    db "@"

Message_0D_83::
    db "<VOICE2>*: Yay! I won!<LINE>"
    db "Am I awesome?<WAIT>"
    db "@"

Message_0D_84::
    db "<VOICE1>*: Some monsters<LINE>"
    db "may be tough, but<PROMPT>"
    db "<NEXT>they could have"
    db "<NEXT>surprising weak<PROMPT>"
    db "<NEXT>spots that can be"
    db "<NEXT>exploited.<PROMPT>"
    db "<NEXT>Skills and dances"
    db "<NEXT>that cause status<PROMPT>"
    db "<NEXT>problems can come"
    db "<NEXT>in very handy.<WAIT>"
    db "@"

Message_0D_85::
    db "<VOICE1>*: A master who can<LINE>"
    db "satisfy me…<PROMPT>"
    db "<NEXT>Does such a"
    db "<NEXT>battler exist?<WAIT>"
    db "@"

Message_0D_86::
    db "<VOICE2>*: Welcome! Do you<LINE>"
    db "wish to battle?@"

Message_0D_87::
    db "<VOICE1>*: GreatLog is a<LINE>"
    db "floating island?<PROMPT>"
    db "<NEXT>If I dig any more,"
    db "<NEXT>the bottom'll go.<WAIT>"
    db "@"

Message_0D_88::
    db "<VOICE1>*: I teased you as<LINE>"
    db "a cute rival…<PROMPT>"
    db "<NEXT>But you've gone"
    db "<NEXT>far beyond me.<WAIT>"
    db "@"

Message_0D_89::
    db "<VOICE1>*: Well, well!<LINE>"
    db "If it isn't the<PROMPT>"
    db "<NEXT>little hero who"
    db "<NEXT>saved GreatLog?<PROMPT>"
    db "<NEXT>Make yourself at"
    db "<NEXT>home and shop!<PROMPT>"
    db "<NEXT>What can I do for"
    db "<NEXT>you today?<WAIT>"
    db "@"

Message_0D_8A::
    db "<VOICE1>*: My ArmyAnt,<LINE>"
    db "which I got from a<PROMPT>"
    db "<NEXT>monster master,"
    db "<NEXT>made it possible<PROMPT>"
    db "<NEXT>for me to open"
    db "<NEXT>this shop.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you today?<WAIT>"
    db "@"

Message_0D_8B::
    db "<VOICE1>*: You might know<LINE>"
    db "this already, but<PROMPT>"
    db "<NEXT>this is a good"
    db "<NEXT>breeding pair,<PROMPT>"
    db "<NEXT>LizardMan and"
    db "<NEXT>WingSlime.<PROMPT>"
    db "<NEXT>That will make you"
    db "<NEXT>a Rayburn.<WAIT>"
    db "@"

Message_0D_8C::
    db "<VOICE1>*: Wata, wata.<LINE>"
    db "Terry battled in<PROMPT>"
    db "<NEXT>the Starry Night"
    db "<NEXT>Tournament as<PROMPT>"
    db "<NEXT>GreatTree's master,"
    db "<NEXT>wataah.<WAIT>"
    db "@"

Message_0D_8D::
    db "<VOICE1>*: Fwahahahaha!<LINE>"
    db "How amusing!<PROMPT>"
    db "<NEXT>Even I fell before"
    db "<NEXT>Terry's might!<PROMPT>"
    db "<NEXT>How you fare shall"
    db "<NEXT>be intriguing.<WAIT>"
    db "@"

Message_0D_8E::
    db "<VOICE1>*: I", $44, " heard of a<LINE>"
    db "little hero…<PROMPT>"
    db "<NEXT>But, it seems to"
    db "<NEXT>be a bogus lead.<PROMPT>"
    db "<NEXT>I'll continue with"
    db "<NEXT>my travels…<WAIT>"
    db "@"

Message_0D_8F::
    db "<VOICE2>*: What a scruffy<LINE>"
    db "lot of masters…<PROMPT>"
    db "<NEXT>I shouldn't believe"
    db "<NEXT>vague rumors…<WAIT>"
    db "@"

Message_0D_90::
    db "<VOICE1>*: Humph…<LINE>"
    db "I'm Terry.<PROMPT>"
    db "<NEXT>Terry: I'm a master"
    db "<NEXT>from GreatTree.<PROMPT>"
    db "<NEXT>I", $44, " heard about"
    db "<NEXT>GreatLog's heroic<PROMPT>"
    db "<NEXT>master, so I came"
    db "<NEXT>to look.<PROMPT>"
    db "<NEXT>But you can't be"
    db "<NEXT>that master, you<PROMPT>"
    db "<NEXT>don't have a full"
    db "<NEXT>party.<WAIT>"
    db "@"

Message_0D_91::
    db "<VOICE2>*: <BUF0>, you were<LINE>"
    db "so busy saving<PROMPT>"
    db "<NEXT>GreatLog that you"
    db "<NEXT>forgot all about<PROMPT>"
    db "<NEXT>my errand, didn't"
    db "<NEXT>you?<PROMPT>"
    db "<NEXT>I went and got the"
    db "<NEXT>LoveWater myself.<WAIT>"
    db "@"

Message_0D_92::
    db "<VOICE1>Kameha: I think I<LINE>"
    db "have the natural<PROMPT>"
    db "<NEXT>talent to be a"
    db "<NEXT>master.<PROMPT>"
    db "<NEXT>…Don't give me"
    db "<NEXT>that look!<PROMPT>"
    db "<NEXT>You don't believe"
    db "<NEXT>me at all.<PROMPT>"
    db "<NEXT>Just you watch,"
    db "<NEXT><BUF0>.<PROMPT>"
    db "<NEXT>I'll surpass you"
    db "<NEXT>in no time!<WAIT>"
    db "@"

Message_0D_93::
    db "<VOICE1>*: We've had reports<LINE>"
    db "of rogue masters<PROMPT>"
    db "<NEXT>who terrorize"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>We're investigating"
    db "<NEXT>these reports, but<PROMPT>"
    db "<NEXT>it's serious if"
    db "<NEXT>they're true!<WAIT>"
    db "@"

Message_0D_94::
    db "<VOICE1>*: Ah, bless you!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>As GreatLog's hero,<LINE>"
    db "you set a shining<PROMPT>"
    db "<NEXT>example to other"
    db "<NEXT>masters.<PROMPT>"
    db "<NEXT>Thanks to you, our"
    db "<NEXT>Kingdom's honor<PROMPT>"
    db "<NEXT>has been kept"
    db "<NEXT>untarnished!<WAIT>"
    db "@"

Message_0D_95::
    db "<VOICE1>Warubou: Wa-hey…<LINE>"
    db "That's cold of you.<PROMPT>"
    db "<NEXT>After all we've"
    db "<NEXT>been through…<PROMPT>"
    db "<NEXT>Yet you refuse me,"
    db "<NEXT>warooh?<WAIT>"
    db "@"

Message_0D_96::
    db "<VOICE1>*: Our church is<LINE>"
    db "impoverished, so<PROMPT>"
    db "<NEXT>I was sent out to"
    db "<NEXT>this village.<PROMPT>"
    db "<NEXT>I can heal you of"
    db "<NEXT>poison, nullify<PROMPT>"
    db "<NEXT>curses, and raise"
    db "<NEXT>those knocked out.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you?<WAIT>"
    db "@"

Message_0D_A1::
    db "<VOICE1>*: Our church is<LINE>"
    db "impoverished, so<PROMPT>"
    db "<NEXT>I was sent out to"
    db "<NEXT>this village.<PROMPT>"
    db "<NEXT>The slow pace of"
    db "<NEXT>life here makes<PROMPT>"
    db "<NEXT>one lose sight of"
    db "<NEXT>the flowing time.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you?<WAIT>"
    db "@"

Message_0D_A2::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "I was the plug in<PROMPT>"
    db "<NEXT>the Log's Navel for"
    db "<NEXT>a long time!<PROMPT>"
    db "<NEXT>The pie is my"
    db "<NEXT>reward, warooh!<PROMPT>"
    db "<NEXT>I get to eat lots"
    db "<NEXT>of it!<WAIT>"
    db "@"

Message_0D_B1::
    db "<VOICE1>Kameha: I went and<LINE>"
    db "faced danger in<PROMPT>"
    db "<NEXT>other worlds for"
    db "<NEXT>GreatLog's sake!<PROMPT>"
    db "<NEXT>All you did was"
    db "<NEXT>loaf around here!<WAIT>"
    db "@"

Message_0D_B2::
    db "<VOICE1>Warubou: WA-HEY!<LINE>"
    db "Some Prince!<PROMPT>"
    db "<NEXT>Always a dirty"
    db "<NEXT>mouth, warooh!<WAIT>"
    db "@"

Message_0D_B3::
    db "<VOICE1>Kameha: You're a<LINE>"
    db "glutton!<PROMPT>"
    db "<NEXT>You haven't changed"
    db "<NEXT>at all, glutton!<WAIT>"
    db "@"

Message_0D_B4::
    db "<VOICE1>Cobi: Pot-kettle-<LINE>"
    db "black, you two.<PROMPT>"
    db "<NEXT>You both need to"
    db "<NEXT>smarten up.<WAIT>"
    db "@"

Message_0D_B5::
    db "<VOICE2>Tara: You two went<LINE>"
    db "through all that,<PROMPT>"
    db "<NEXT>but you haven't"
    db "<NEXT>wised up at all?<WAIT>"
    db "@"

Message_0D_B6::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Now look, warooh!<PROMPT>"
    db "<NEXT>It's your fault"
    db "<NEXT>they find us!<WAIT>"
    db "@"

Message_0D_B7::
    db "<VOICE1>Kameha: No one's<LINE>"
    db "taking this pie<PROMPT>"
    db "<NEXT>away from me!"
    db "<NEXT><WAIT>"
    db "@"

Message_0D_B8::
    db "<VOICE1>Warubou: Wa-hey…<LINE>"
    db "I have seen this…<WAIT>"
    db "@"

Message_0D_B9::
    db "<VOICE1>Cobi: That's enough<LINE>"
    db "already.<WAIT>"
    db "@"

Message_0D_BA::
    db "<VOICE2>What if you break"
    db "<NEXT>the plug again?<WAIT>"
    db "@"

Message_0D_BB::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "the ability to<PROMPT>"
    db "<NEXT>cross the sea is"
    db "<NEXT>in you, warooh!<PROMPT>"
    db "<NEXT>Talk to the sea,"
    db "<NEXT>and it will reply.<PROMPT>"
    db "<NEXT>Wa-hey? I felt an"
    db "<NEXT>odd power!<PROMPT>"
    db "<NEXT>It's the sea!"
    db "<NEXT>It's calling!<PROMPT>"
    db "<NEXT>A dilapidated"
    db "<NEXT>pirate ship is<PROMPT>"
    db "<NEXT>what I see on the"
    db "<NEXT>sea, warooh.<PROMPT>"
    db "<NEXT>But this time, you"
    db "<NEXT>must find the key.<PROMPT>"
    db "<NEXT>It's right here in"
    db "<NEXT>GreatLog, I think.<PROMPT>"
    db "<NEXT>The Pirate Key is"
    db "<NEXT>what you want.<WAIT>"
    db "@"

Message_0D_C1::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "you can now crush<PROMPT>"
    db "<NEXT>huge boulders,"
    db "<NEXT>warooh!<PROMPT>"
    db "<NEXT>You try in front"
    db "<NEXT>of a boulder or a<PROMPT>"
    db "<NEXT>tree that's in the"
    db "<NEXT>way. Anyway…<PROMPT>"
    db "<NEXT><BUF0>, you will go"
    db "<NEXT>look again?<PROMPT>"
    db "<NEXT>Wa-hey? I felt an"
    db "<NEXT>odd power!<PROMPT>"
    db "<NEXT>It's cold!"
    db "<NEXT>It's in ice!<PROMPT>"
    db "<NEXT>You know what I'm"
    db "<NEXT>going to say…<PROMPT>"
    db "<NEXT>I don't have the"
    db "<NEXT>key, warooh.<PROMPT>"
    db "<NEXT>The Ice Key is"
    db "<NEXT>what you want.<WAIT>"
    db "@"

Message_0D_C2::
    db "<VOICE1>*: It's exciting to<LINE>"
    db "think where an<PROMPT>"
    db "<NEXT>appraised Magic"
    db "<NEXT>Key will take you.<WAIT>"
    db "@"

Message_0D_C3::
    db "<VOICE1>*: The shoals that<LINE>"
    db "ringed the volcano<PROMPT>"
    db "<NEXT>have suddenly"
    db "<NEXT>disappeared.<PROMPT>"
    db "<NEXT>The sea can be so"
    db "<NEXT>mysterious.<WAIT>"
    db "@"

Message_0D_C4::
    db "<VOICE1>*: What is it?<LINE>"
    db "Ah, it's you.<PROMPT>"
    db "<NEXT>What's that?"
    db "<NEXT>The MoonRock?<PROMPT>"
    db "<NEXT>Ah, the mermaids"
    db "<NEXT>helped you!<WAIT>"
    db "@"

Message_0D_C5::
    db "<VOICE2>*: Welcome, my<LINE>"
    db "young hero!<PROMPT>"
    db "<NEXT>No words could"
    db "<NEXT>ever do justice<PROMPT>"
    db "<NEXT>for the gratitude"
    db "<NEXT>I feel for you.<PROMPT>"
    db "<NEXT>Instead, take this"
    db "<NEXT>ring.<PROMPT>"
    db "<NEXT>I found it inside"
    db "<NEXT>a sunken ship.<PROMPT>"
    db "<NEXT>It is best that it"
    db "<NEXT>be returned to a<PROMPT>"
    db "<NEXT>human, namely you."
    db "<NEXT><WAIT>"
    db "@"

Message_0D_C6::
    db "<BUF0> received the<LINE>"
    db "Sailor Ring.<WAIT>"
    db "@"

Message_0D_C7::
    db "<VOICE2>*: Welcome, my<LINE>"
    db "young hero!<PROMPT>"
    db "<NEXT>No words could"
    db "<NEXT>ever do justice<PROMPT>"
    db "<NEXT>for the gratitude"
    db "<NEXT>I feel for you.<PROMPT>"
    db "<NEXT>Instead, take this"
    db "<NEXT>ring.<PROMPT>"
    db "<NEXT>Ah, but you have"
    db "<NEXT>no room for it.<PROMPT>"
    db "<NEXT>I'll keep it till"
    db "<NEXT>you make room.<WAIT>"
    db "@"

Message_0D_C8::
    db "<VOICE1>*: Lady Yuna has<LINE>"
    db "always been highly<PROMPT>"
    db "<NEXT>energetic and"
    db "<NEXT>rambunctious.<PROMPT>"
    db "<NEXT>We had a dickens"
    db "<NEXT>of a time because<PROMPT>"
    db "<NEXT>she would always"
    db "<NEXT>sneak off.<WAIT>"
    db "@"

Message_0D_C9::
    db "<VOICE1>*: How can we save<LINE>"
    db "Queen Helen?<PROMPT>"
    db "<NEXT>According to some"
    db "<NEXT>medical books,<PROMPT>"
    db "<NEXT>there is something"
    db "<NEXT>called SleepHerb.<PROMPT>"
    db "<NEXT>The scholar may"
    db "<NEXT>know, but he has<PROMPT>"
    db "<NEXT>gone on a study"
    db "<NEXT>trip to Nofor.<WAIT>"
    db "@"

Message_0D_CA::
    db "<VOICE2>*: Let me show you<LINE>"
    db "my resurrected<PROMPT>"
    db "<NEXT>powers…"
    db "<NEXT><WAIT>"
    db "@"

Message_0D_CB::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "you can now fly<PROMPT>"
    db "<NEXT>across the sky on"
    db "<NEXT>a cloud, warooh!<PROMPT>"
    db "<NEXT>You try at the"
    db "<NEXT>edge of land and<PROMPT>"
    db "<NEXT>the open sky."
    db "<NEXT>Anyway…<PROMPT>"
    db "<NEXT><BUF0>, you will go"
    db "<NEXT>look again?<PROMPT>"
    db "<NEXT>Wa-hey? I felt an"
    db "<NEXT>odd power!<PROMPT>"
    db "<NEXT>I see it! A land"
    db "<NEXT>floating way up<PROMPT>"
    db "<NEXT>high in the sky,"
    db "<NEXT>warooh!<PROMPT>"
    db "<NEXT>The Sky Key is"
    db "<NEXT>what you want.<WAIT>"
    db "@"

Message_0D_CC::
    db "<VOICE1>*: YOUR LIFE ENDS<LINE>"
    db "HERE! GIVE IT UP!<WAIT>"
    db "@"

Message_0D_CD::
    db "<VOICE1>*: KAHAHAHA!<LINE>"
    db "THEN LEAVE!<WAIT>"
    db "@"

Message_0D_CE::
    db "<VOICE1>*: I see… But I<LINE>"
    db "will crush you!<WAIT>"
    db "@"

Message_0D_CF::
    db "<VOICE1>*: I see… Then<LINE>"
    db "leave at once.<WAIT>"
    db "@"

Message_0D_D0::
    db "<VOICE1>*: Impetuous fool!<LINE>"
    db "I'll show you!<PROMPT>"
    db "<NEXT>Come hither, my"
    db "<NEXT>servants!<WAIT>"
    db "@"

Message_0D_D1::
    db "<VOICE1>*: Hm, fine, I'll<LINE>"
    db "ignore it.<PROMPT>"
    db "<NEXT>But just this"
    db "<NEXT>time!<WAIT>"
    db "@"

Message_0D_D2::
    db "The princess did<LINE>"
    db "not reply.<PROMPT>"
    db "<NEXT>But a malevolent"
    db "<NEXT>voice spoke up…<WAIT>"
    db "@"

Message_0D_D3::
    db "'Inn downstairs.<LINE>"
    db "Rooms available.", $95, "<WAIT>"
    db "@"

Message_0D_D4::
    db "<VOICE1>*: If you breed,<LINE>"
    db "the parents go<PROMPT>"
    db "<NEXT>away somewhere,"
    db "<NEXT>and their baby<PROMPT>"
    db "<NEXT>hatches at just"
    db "<NEXT>level 1.<PROMPT>"
    db "<NEXT>But the baby will"
    db "<NEXT>grow to surpass<PROMPT>"
    db "<NEXT>its parents if you"
    db "<NEXT>raise it.<WAIT>"
    db "@"

Message_0D_D5::
    db "<VOICE2>*: Monster skills<LINE>"
    db "are passed on from<PROMPT>"
    db "<NEXT>parents to their"
    db "<NEXT>offspring.<PROMPT>"
    db "<NEXT>Retain the skills"
    db "<NEXT>you like on your<PROMPT>"
    db "<NEXT>monsters, and keep"
    db "<NEXT>breeding them.<PROMPT>"
    db "<NEXT>Eventually, you'll"
    db "<NEXT>have monsters that<PROMPT>"
    db "<NEXT>possess the moves"
    db "<NEXT>you like best.<WAIT>"
    db "@"

Message_0D_D6::
    db "<VOICE1>*: Nightmares so<LINE>"
    db "horrible that they<PROMPT>"
    db "<NEXT>keep Queen Helen"
    db "<NEXT>from sleeping…<PROMPT>"
    db "<NEXT>What is happening"
    db "<NEXT>to the kingdom?<WAIT>"
    db "@"

Message_0D_D7::
    db "<VOICE1>*: Our hearts are<LINE>"
    db "like the skies<PROMPT>"
    db "<NEXT>above-heavy and"
    db "<NEXT>clouded…<PROMPT>"
    db "<NEXT>We're all starved"
    db "<NEXT>for cheerful news.<WAIT>"
    db "@"

Message_0D_D8::
    db "<VOICE2>*: Queen Helen is<LINE>"
    db "wracked by awful<PROMPT>"
    db "<NEXT>nightmares night"
    db "<NEXT>after night…<PROMPT>"
    db "<NEXT>She's managed only"
    db "<NEXT>snatches of sleep…<PROMPT>"
    db "<NEXT>It's left her in a"
    db "<NEXT>cranky mood…<WAIT>"
    db "@"

Message_0D_D9::
    db "<VOICE1>*: The reception<LINE>"
    db "hall is beyond<PROMPT>"
    db "<NEXT>here. Our Queen is"
    db "<NEXT>waiting for you.<WAIT>"
    db "@"

Message_0D_DA::
    db "<VOICE1>*: Our Queen Helen's<LINE>"
    db "premonition made<PROMPT>"
    db "<NEXT>it possible for us"
    db "<NEXT>to overcome the<PROMPT>"
    db "<NEXT>terrible cold"
    db "<NEXT>spell for now…<PROMPT>"
    db "<NEXT>But if the cold"
    db "<NEXT>weather persists,<PROMPT>"
    db "<NEXT>who knows what"
    db "<NEXT>will happen?<WAIT>"
    db "@"

Message_0D_DB::
    db "<VOICE2>*: What is it?<LINE>"
    db "Leave at once!<PROMPT>"
    db "<NEXT>This is no place"
    db "<NEXT>for a child!<PROMPT>"
    db "<NEXT>What? Lady Yuna of"
    db "<NEXT>the west?<PROMPT>"
    db "<NEXT>She's behaving in"
    db "<NEXT>a peculiar manner?<PROMPT>"
    db "<NEXT>What rot!"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>That is of no"
    db "<NEXT>concern to me!<WAIT>"
    db "@"

Message_0D_DC::
    db "<VOICE1>*: This happened<LINE>"
    db "when I was deep in<PROMPT>"
    db "<NEXT>the forest far to"
    db "<NEXT>the west.<PROMPT>"
    db "<NEXT>A young girl just"
    db "<NEXT>appeared and she<PROMPT>"
    db "<NEXT>sort of glided"
    db "<NEXT>over to me without<PROMPT>"
    db "<NEXT>moving her feet"
    db "<NEXT>one bit.<PROMPT>"
    db "<NEXT>I turned and ran,"
    db "<NEXT>but she followed!<WAIT>"
    db "@"

Message_0D_DD::
    db "<VOICE2>*: My father is so<LINE>"
    db "cowardly, getting<PROMPT>"
    db "<NEXT>all spooked by a"
    db "<NEXT>ghost.<PROMPT>"
    db "<NEXT>Your monsters"
    db "<NEXT>frighten me more.<WAIT>"
    db "@"
    ds $8c, $00
