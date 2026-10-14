; ROM bank $86: messages
; The annotated listing of this bank is build/listing/bank86.asm.

SECTION "Bank 86", ROMX[$4000], BANK[$86]
    db $86

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank86::
    ld de, BeginStringDisplay_Bank86_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank86_StringCategories::
    dw StringList_Bank86_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank86_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank86_StringCategories_0::
    dw Message_0C_00 ; id 0
    dw Message_0C_01 ; id 1
    dw Message_0C_02 ; id 2
    dw Message_0C_03 ; id 3
    dw Message_0C_04 ; id 4
    dw Message_0C_05 ; id 5
    dw Message_0C_06 ; id 6
    dw Message_0C_07 ; id 7
    dw Message_0C_08 ; id 8
    dw Message_0C_09 ; id 9
    dw Message_0C_0A ; id 10
    dw Message_0C_0B ; id 11
    dw Message_0C_0C ; id 12
    dw Message_0C_0D ; id 13
    dw Message_0C_0E ; id 14
    dw Message_0C_0F ; id 15
    dw Message_0C_10 ; id 16
    dw Message_0C_11 ; id 17
    dw Message_0C_12 ; id 18
    dw Message_0C_13 ; id 19
    dw Message_0C_14 ; id 20
    dw Message_0C_15 ; id 21
    dw Message_0C_16 ; id 22
    dw Message_0C_17 ; id 23
    dw Message_0C_18 ; id 24
    dw Message_0C_19 ; id 25
    dw Message_0C_1A ; id 26
    dw Message_0C_1B ; id 27
    dw Message_0C_1C ; id 28
    dw Message_0C_1D ; id 29
    dw Message_0C_1E ; id 30
    dw Message_0C_1F ; id 31
    dw Message_0C_20 ; id 32
    dw Message_0C_21 ; id 33
    dw Message_0C_22 ; id 34
    dw Message_0C_23 ; id 35
    dw Message_0C_24 ; id 36
    dw Message_0C_25 ; id 37
    dw Message_0C_26 ; id 38
    dw Message_0C_27 ; id 39
    dw Message_0C_28 ; id 40
    dw Message_0C_29 ; id 41
    dw Message_0C_2A ; id 42
    dw Message_0C_2B ; id 43
    dw Message_0C_2C ; id 44
    dw Message_0C_2D ; id 45
    dw Message_0C_2E ; id 46
    dw Message_0C_2F ; id 47
    dw Message_0C_30 ; id 48
    dw Message_0C_31 ; id 49
    dw Message_0C_32 ; id 50
    dw Message_0C_33 ; id 51
    dw Message_0C_34 ; id 52
    dw Message_0C_35 ; id 53
    dw Message_0C_36 ; id 54
    dw Message_0C_37 ; id 55
    dw Message_0C_38 ; id 56
    dw Message_0C_39 ; id 57
    dw Message_0C_3A ; id 58
    dw Message_0C_3B ; id 59
    dw Message_0C_3C ; id 60
    dw Message_0C_3D ; id 61
    dw Message_0C_3E ; id 62
    dw Message_0C_3F ; id 63
    dw Message_0C_40 ; id 64
    dw Message_0C_41 ; id 65
    dw Message_0C_42 ; id 66
    dw Message_0C_43 ; id 67
    dw Message_0C_44 ; id 68
    dw Message_0C_45 ; id 69
    dw Message_0C_46 ; id 70
    dw Message_0C_47 ; id 71
    dw Message_0C_48 ; id 72
    dw Message_0C_49 ; id 73
    dw Message_0C_4A ; id 74
    dw Message_0C_4B ; id 75
    dw Message_0C_4C ; id 76
    dw Message_0C_4D ; id 77
    dw Message_0C_4E ; id 78
    dw Message_0C_4F ; id 79
    dw Message_0C_50 ; id 80
    dw Message_0C_51 ; id 81
    dw Message_0C_52 ; id 82
    dw Message_0C_53 ; id 83
    dw Message_0C_54 ; id 84
    dw Message_0C_55 ; id 85
    dw Message_0C_56 ; id 86
    dw Message_0C_57 ; id 87
    dw Message_0C_58 ; id 88
    dw Message_0C_58 ; id 89
    dw Message_0C_58 ; id 90
    dw Message_0C_58 ; id 91
    dw Message_0C_58 ; id 92
    dw Message_0C_58 ; id 93
    dw Message_0C_58 ; id 94
    dw Message_0C_58 ; id 95
    dw Message_0C_58 ; id 96
    dw Message_0C_58 ; id 97
    dw Message_0C_58 ; id 98
    dw Message_0C_58 ; id 99
    dw Message_0C_58 ; id 100
    dw Message_0C_58 ; id 101
    dw Message_0C_58 ; id 102
    dw Message_0C_58 ; id 103
    dw Message_0C_58 ; id 104
    dw Message_0C_58 ; id 105
    dw Message_0C_58 ; id 106
    dw Message_0C_58 ; id 107
    dw Message_0C_58 ; id 108
    dw Message_0C_58 ; id 109
    dw Message_0C_58 ; id 110
    dw Message_0C_58 ; id 111
    dw Message_0C_58 ; id 112
    dw Message_0C_58 ; id 113
    dw Message_0C_58 ; id 114
    dw Message_0C_58 ; id 115
    dw Message_0C_58 ; id 116
    dw Message_0C_58 ; id 117
    dw Message_0C_58 ; id 118
    dw Message_0C_58 ; id 119
    dw Message_0C_58 ; id 120
    dw Message_0C_58 ; id 121
    dw Message_0C_58 ; id 122
    dw Message_0C_58 ; id 123
    dw Message_0C_58 ; id 124
    dw Message_0C_58 ; id 125
    dw Message_0C_58 ; id 126
    dw Message_0C_58 ; id 127
    dw Message_0C_58 ; id 128
    dw Message_0C_58 ; id 129
    dw Message_0C_58 ; id 130
    dw Message_0C_58 ; id 131
    dw Message_0C_58 ; id 132
    dw Message_0C_58 ; id 133
    dw Message_0C_58 ; id 134
    dw Message_0C_58 ; id 135
    dw Message_0C_58 ; id 136
    dw Message_0C_58 ; id 137
    dw Message_0C_58 ; id 138
    dw Message_0C_58 ; id 139
    dw Message_0C_58 ; id 140
    dw Message_0C_58 ; id 141
    dw Message_0C_58 ; id 142
    dw Message_0C_58 ; id 143
    dw Message_0C_58 ; id 144
    dw Message_0C_58 ; id 145
    dw Message_0C_58 ; id 146
    dw Message_0C_58 ; id 147
    dw Message_0C_58 ; id 148
    dw Message_0C_58 ; id 149
    dw Message_0C_58 ; id 150
    dw Message_0C_58 ; id 151
    dw Message_0C_58 ; id 152
    dw Message_0C_58 ; id 153
    dw Message_0C_58 ; id 154
    dw Message_0C_58 ; id 155
    dw Message_0C_58 ; id 156
    dw Message_0C_58 ; id 157
    dw Message_0C_58 ; id 158
    dw Message_0C_58 ; id 159
    dw Message_0C_58 ; id 160
    dw Message_0C_58 ; id 161
    dw Message_0C_58 ; id 162
    dw Message_0C_58 ; id 163
    dw Message_0C_58 ; id 164
    dw Message_0C_58 ; id 165
    dw Message_0C_58 ; id 166
    dw Message_0C_58 ; id 167
    dw Message_0C_58 ; id 168
    dw Message_0C_58 ; id 169
    dw Message_0C_58 ; id 170
    dw Message_0C_58 ; id 171
    dw Message_0C_58 ; id 172
    dw Message_0C_58 ; id 173
    dw Message_0C_58 ; id 174
    dw Message_0C_58 ; id 175
    dw Message_0C_58 ; id 176
    dw Message_0C_58 ; id 177
    dw Message_0C_58 ; id 178
    dw Message_0C_58 ; id 179
    dw Message_0C_58 ; id 180
    dw Message_0C_58 ; id 181
    dw Message_0C_58 ; id 182
    dw Message_0C_58 ; id 183
    dw Message_0C_58 ; id 184
    dw Message_0C_58 ; id 185
    dw Message_0C_58 ; id 186
    dw Message_0C_58 ; id 187
    dw Message_0C_58 ; id 188
    dw Message_0C_58 ; id 189
    dw Message_0C_58 ; id 190
    dw Message_0C_58 ; id 191
    dw Message_0C_58 ; id 192
    dw Message_0C_58 ; id 193
    dw Message_0C_58 ; id 194
    dw Message_0C_58 ; id 195
    dw Message_0C_58 ; id 196
    dw Message_0C_58 ; id 197
    dw Message_0C_58 ; id 198
    dw Message_0C_58 ; id 199
    dw Message_0C_58 ; id 200
    dw Message_0C_58 ; id 201
    dw Message_0C_58 ; id 202
    dw Message_0C_58 ; id 203
    dw Message_0C_58 ; id 204
    dw Message_0C_58 ; id 205
    dw Message_0C_58 ; id 206
    dw Message_0C_58 ; id 207
    dw Message_0C_58 ; id 208
    dw Message_0C_58 ; id 209
    dw Message_0C_58 ; id 210
    dw Message_0C_58 ; id 211
    dw Message_0C_58 ; id 212
    dw Message_0C_58 ; id 213
    dw Message_0C_58 ; id 214
    dw Message_0C_58 ; id 215
    dw Message_0C_58 ; id 216
    dw Message_0C_58 ; id 217
    dw Message_0C_58 ; id 218
    dw Message_0C_58 ; id 219
    dw Message_0C_58 ; id 220
    dw Message_0C_58 ; id 221
    dw Message_0C_58 ; id 222
    dw Message_0C_DF ; id 223
    dw Message_0C_E0 ; id 224
    dw Message_0C_E1 ; id 225
    dw Message_0C_E2 ; id 226
    dw Message_0C_E3 ; id 227
    dw Message_0C_E4 ; id 228
    dw Message_0C_E5 ; id 229
    dw Message_0C_E6 ; id 230
    dw Message_0C_E7 ; id 231
    dw Message_0C_E8 ; id 232
    dw Message_0C_E9 ; id 233
    dw Message_0C_EA ; id 234
    dw Message_0C_EB ; id 235
    dw Message_0C_EC ; id 236
    dw Message_0C_ED ; id 237
    dw Message_0C_EE ; id 238
    dw Message_0C_EF ; id 239
    dw Message_0C_F0 ; id 240
    dw Message_0C_F1 ; id 241
    dw Message_0C_F2 ; id 242
    dw Message_0C_F3 ; id 243
    dw Message_0C_F4 ; id 244
    dw Message_0C_F5 ; id 245
    dw Message_0C_F6 ; id 246
    dw Message_0C_F7 ; id 247
    dw Message_0C_F8 ; id 248
    dw Message_0C_F9 ; id 249
    dw Message_0C_FA ; id 250
    dw Message_0C_FB ; id 251
    dw Message_0C_FC ; id 252
    dw Message_0C_FD ; id 253
    dw Message_0C_FE ; id 254
    dw Message_0C_FF ; id 255

Message_0C_00::
    db "<VOICE1>*: This is the<LINE>"
    db "Power Tower.<PROMPT>"
    db "<NEXT>Are you the new"
    db "<NEXT>challenger?<PROMPT>"
    db "<NEXT>If you win, you'll"
    db "<NEXT>earn many useful<PROMPT>"
    db "<NEXT>accessories for"
    db "<NEXT>your monsters.<PROMPT>"
    db "<NEXT>Could you get them"
    db "<NEXT>all?<WAIT>"
    db "@"

Message_0C_01::
    db "<VOICE1>*: If you win,<LINE>"
    db "you'll earn many<PROMPT>"
    db "<NEXT>useful accessories"
    db "<NEXT>for your monsters.<PROMPT>"
    db "<NEXT>Could you get them"
    db "<NEXT>all?<WAIT>"
    db "@"

Message_0C_02::
    db "<VOICE1>*: Only a handful<LINE>"
    db "of masters have<PROMPT>"
    db "<NEXT>made it to the top"
    db "<NEXT>of the Tower.<PROMPT>"
    db "<NEXT>I tried, but the"
    db "<NEXT>best I could do<PROMPT>"
    db "<NEXT>was reach the"
    db "<NEXT>fourth floor.<WAIT>"
    db "@"

Message_0C_03::
    db "<VOICE1>*: The Tower's many<LINE>"
    db "treasures are<PROMPT>"
    db "<NEXT>heavily guarded by"
    db "<NEXT>monsters, slurp.<PROMPT>"
    db "<NEXT>They'll attack you"
    db "<NEXT>all out, slurp.<WAIT>"
    db "@"

Message_0C_04::
    db "<VOICE1>*: This is the<LINE>"
    db "second floor-<PROMPT>"
    db "<NEXT>the Whirlwind"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>Can you withstand"
    db "<NEXT>our wind power?<WAIT>"
    db "@"

Message_0C_05::
    db $f0

Message_0C_06::
    db $f0

Message_0C_07::
    db "<VOICE1>*: Not bad, not bad<LINE>"
    db "at all.<PROMPT>"
    db "<NEXT>Fine. Take the"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>The Clearwater"
    db "<NEXT>Chamber is next.<PROMPT>"
    db "<NEXT>Monsters that use"
    db "<NEXT>water skills will<PROMPT>"
    db "<NEXT>be waiting for"
    db "<NEXT>you.<WAIT>"
    db "@"

Message_0C_08::
    db "<VOICE1>*: This is the<LINE>"
    db "third floor-<PROMPT>"
    db "<NEXT>the Clearwater"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>If you belittle"
    db "<NEXT>hydropower, you<PROMPT>"
    db "<NEXT>will suffer for"
    db "<NEXT>your ignorance!<WAIT>"
    db "@"

Message_0C_09::
    db $f0

Message_0C_0A::
    db $f0

Message_0C_0B::
    db "<VOICE1>*: You're quite<LINE>"
    db "good.<PROMPT>"
    db "<NEXT>The treasures are"
    db "<NEXT>yours to take.<PROMPT>"
    db "<NEXT>Upstairs is the"
    db "<NEXT>Blizzard Chamber.<PROMPT>"
    db "<NEXT>It's very cold, so"
    db "<NEXT>be careful.<WAIT>"
    db "@"

Message_0C_0C::
    db "<VOICE1>*: This is the<LINE>"
    db "fourth floor-<PROMPT>"
    db "<NEXT>the Blizzard"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>I hope you're"
    db "<NEXT>bundled up warm.<PROMPT>"
    db "<NEXT>We'll freeze you"
    db "<NEXT>solid!<WAIT>"
    db "@"

Message_0C_0D::
    db $f0

Message_0C_0E::
    db $f0

Message_0C_0F::
    db "<VOICE1>*: Wow, aren't you<LINE>"
    db "good.<PROMPT>"
    db "<NEXT>Go ahead and take"
    db "<NEXT>the treasures.<PROMPT>"
    db "<NEXT>The Thunder"
    db "<NEXT>Chamber's next.<PROMPT>"
    db "<NEXT>You can always"
    db "<NEXT>hear the sound of<PROMPT>"
    db "<NEXT>crashing thunder."
    db "<NEXT>It's annoying!<WAIT>"
    db "@"

Message_0C_10::
    db "<VOICE1>*: This is the<LINE>"
    db "fifth floor-<PROMPT>"
    db "<NEXT>the Thunder"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>Prepare for"
    db "<NEXT>obliteration!<WAIT>"
    db "@"

Message_0C_11::
    db $f0

Message_0C_12::
    db $f0

Message_0C_13::
    db "<VOICE1>*: Well done.<LINE>"
    db "So it shall be.<PROMPT>"
    db "<NEXT>You have bettered"
    db "<NEXT>us in power.<PROMPT>"
    db "<NEXT>The Tower's peak"
    db "<NEXT>is next.<PROMPT>"
    db "<NEXT>Monsters that use"
    db "<NEXT>extreme heat stand<PROMPT>"
    db "<NEXT>alert for your"
    db "<NEXT>arrival.<WAIT>"
    db "@"

Message_0C_14::
    db "<VOICE1>*: Well.<LINE>"
    db "How impressive.<PROMPT>"
    db "<NEXT>I must commend you"
    db "<NEXT>for reaching me.<PROMPT>"
    db "<NEXT>Well."
    db "<NEXT>Shall we begin?<WAIT>"
    db "@"

Message_0C_15::
    db $f0

Message_0C_16::
    db "<VOICE1>*: Well.<LINE>"
    db "How impressive.<PROMPT>"
    db "<NEXT>Conquering the"
    db "<NEXT>Power Tower.<PROMPT>"
    db "<NEXT>It was built by a…"
    db "<NEXT>a great being.<PROMPT>"
    db "<NEXT>He built other"
    db "<NEXT>towers like this.<PROMPT>"
    db "<NEXT>Do you possess all"
    db "<NEXT>that is needed to<PROMPT>"
    db "<NEXT>conquer them all?"
    db "<NEXT>Well?<PROMPT>"
    db "<NEXT>Take the treasures"
    db "<NEXT>behind me.<WAIT>"
    db "@"

Message_0C_17::
    db "<VOICE1>*: You've conquered<LINE>"
    db "the Power Tower.<PROMPT>"
    db "<NEXT>I hope you become"
    db "<NEXT>a powerful master.<WAIT>"
    db "@"

Message_0C_18::
    db "<VOICE1>*: This is the<LINE>"
    db "Baffle Tower.<PROMPT>"
    db "<NEXT>Are you the new"
    db "<NEXT>challenger?<PROMPT>"
    db "<NEXT>If you win, you'll"
    db "<NEXT>earn many useful<PROMPT>"
    db "<NEXT>accessories for"
    db "<NEXT>your monsters.<PROMPT>"
    db "<NEXT>Could you get them"
    db "<NEXT>all?<WAIT>"
    db "@"

Message_0C_19::
    db "<VOICE1>*: If you win,<LINE>"
    db "you'll earn many<PROMPT>"
    db "<NEXT>useful accessories"
    db "<NEXT>for your monsters.<PROMPT>"
    db "<NEXT>Could you get them"
    db "<NEXT>all?<WAIT>"
    db "@"

Message_0C_1A::
    db "<VOICE2>*: In this Tower,<LINE>"
    db "your opponents<PROMPT>"
    db "<NEXT>come at you with"
    db "<NEXT>support skills<PROMPT>"
    db "<NEXT>rather than all-"
    db "<NEXT>out attacks.<PROMPT>"
    db "<NEXT>My party was put"
    db "<NEXT>to sleep, made to<PROMPT>"
    db "<NEXT>dance… All sorts"
    db "<NEXT>of weird things.<PROMPT>"
    db "<NEXT>It was a rotten"
    db "<NEXT>time, I swear!<WAIT>"
    db "@"

Message_0C_1B::
    db "<VOICE1>*: It's not that<LINE>"
    db "easy to win here<PROMPT>"
    db "<NEXT>by playing it fair"
    db "<NEXT>and honorably.<PROMPT>"
    db "<NEXT>You have to use"
    db "<NEXT>your noggin to mix<PROMPT>"
    db "<NEXT>and match skills"
    db "<NEXT>for best effect.<WAIT>"
    db "@"

Message_0C_1C::
    db "<VOICE1>*: This is the<LINE>"
    db "second floor-<PROMPT>"
    db "<NEXT>the Shackle"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>We'll disable your"
    db "<NEXT>skills!<WAIT>"
    db "@"

Message_0C_1D::
    db $f0

Message_0C_1E::
    db $f0

Message_0C_1F::
    db "<VOICE1>*: Well played.<LINE>"
    db "I can't complain.<PROMPT>"
    db "<NEXT>Fine. Take the"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>The Confusion"
    db "<NEXT>Chamber is next.<PROMPT>"
    db "<NEXT>Monsters that"
    db "<NEXT>disable control<PROMPT>"
    db "<NEXT>will stand in your"
    db "<NEXT>way.<WAIT>"
    db "@"

Message_0C_20::
    db "<VOICE1>*: This is the<LINE>"
    db "third floor-<PROMPT>"
    db "<NEXT>the Confusion"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>Let us gift you"
    db "<NEXT>with a time of<PROMPT>"
    db "<NEXT>dreaming…"
    db "<NEXT><WAIT>"
    db "@"

Message_0C_21::
    db $f0

Message_0C_22::
    db $f0

Message_0C_23::
    db "<VOICE1>*: Bravo. Take the<LINE>"
    db "treasures.<PROMPT>"
    db "<NEXT>Upstairs is the"
    db "<NEXT>Fatigue Chamber.<PROMPT>"
    db "<NEXT>I understand it is"
    db "<NEXT>very tiresome.<WAIT>"
    db "@"

Message_0C_24::
    db "<VOICE1>*: This is the<LINE>"
    db "fourth floor-<PROMPT>"
    db "<NEXT>the Fatigue"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>Let us put you to"
    db "<NEXT>the test!<WAIT>"
    db "@"

Message_0C_25::
    db $f0

Message_0C_26::
    db $f0

Message_0C_27::
    db "<VOICE1>*: Remarkable,<LINE>"
    db "I must admit.<PROMPT>"
    db "<NEXT>You have earned"
    db "<NEXT>the treasures.<PROMPT>"
    db "<NEXT>The Looting"
    db "<NEXT>Chamber's next.<PROMPT>"
    db "<NEXT>Monsters that"
    db "<NEXT>steal your power<PROMPT>"
    db "<NEXT>are what you will"
    db "<NEXT>face.<WAIT>"
    db "@"

Message_0C_28::
    db "<VOICE1>*: This is the<LINE>"
    db "fifth floor-<PROMPT>"
    db "<NEXT>the Looting"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>Could you battle"
    db "<NEXT>without strength?<WAIT>"
    db "@"

Message_0C_29::
    db $f0

Message_0C_2A::
    db $f0

Message_0C_2B::
    db "<VOICE1>*: You're quite<LINE>"
    db "tough.<PROMPT>"
    db "<NEXT>The treasures are"
    db "<NEXT>yours to take.<PROMPT>"
    db "<NEXT>The Tower's peak"
    db "<NEXT>is next.<PROMPT>"
    db "<NEXT>Monsters that use"
    db "<NEXT>dangerous skills<PROMPT>"
    db "<NEXT>are waiting for"
    db "<NEXT>the worthy.<WAIT>"
    db "@"

Message_0C_2C::
    db "<VOICE1>*: Ah, you have<LINE>"
    db "impressed me.<PROMPT>"
    db "<NEXT>It's rare to see"
    db "<NEXT>anyone here.<PROMPT>"
    db "<NEXT>Let the final"
    db "<NEXT>battle begin…<WAIT>"
    db "@"

Message_0C_2D::
    db $f0

Message_0C_2E::
    db "<VOICE1>*: You are to be<LINE>"
    db "commended for<PROMPT>"
    db "<NEXT>conquering the"
    db "<NEXT>Baffle Tower.<PROMPT>"
    db "<NEXT>It was built by a…"
    db "<NEXT>a great being.<PROMPT>"
    db "<NEXT>He built other"
    db "<NEXT>towers like this.<PROMPT>"
    db "<NEXT>If you wish to be"
    db "<NEXT>a true master, it<PROMPT>"
    db "<NEXT>is pointless to"
    db "<NEXT>not conquer all<PROMPT>"
    db "<NEXT>the towers made by"
    db "<NEXT>the great being.<WAIT>"
    db "@"

Message_0C_2F::
    db "<VOICE1>*: You've conquered<LINE>"
    db "the Baffle Tower.<PROMPT>"
    db "<NEXT>I hope you become"
    db "<NEXT>a wise master.<WAIT>"
    db "@"

Message_0C_30::
    db "<VOICE1>*: If you've made<LINE>"
    db "it to this-the<PROMPT>"
    db "<NEXT>Soul Tower-it"
    db "<NEXT>must mean that<PROMPT>"
    db "<NEXT>you've conquered"
    db "<NEXT>the two other<PROMPT>"
    db "<NEXT>Towers of Power"
    db "<NEXT>and Baffle.<PROMPT>"
    db "<NEXT>But even so, this"
    db "<NEXT>Tower is terribly<PROMPT>"
    db "<NEXT>tough. I hope"
    db "<NEXT>you're ready.<WAIT>"
    db "@"

Message_0C_31::
    db "<VOICE1>*: This Tower is<LINE>"
    db "terribly tough.<PROMPT>"
    db "<NEXT>I hope you're"
    db "<NEXT>ready.<WAIT>"
    db "@"

Message_0C_32::
    db "<VOICE1>*: The monsters<LINE>"
    db "here are awful.<PROMPT>"
    db "<NEXT>I'm losing my"
    db "<NEXT>confidence…<PROMPT>"
    db "<NEXT>I heard a horrible"
    db "<NEXT>racket from above.<PROMPT>"
    db "<NEXT>It might be that"
    db "<NEXT>one skill…<WAIT>"
    db "@"

Message_0C_33::
    db "<VOICE1>*: It's brutal up<LINE>"
    db "ahead.<PROMPT>"
    db "<NEXT>I wouldn't push my"
    db "<NEXT>luck.<PROMPT>"
    db "<NEXT>Beating the second"
    db "<NEXT>floor monsters was<PROMPT>"
    db "<NEXT>a serious ordeal,"
    db "<NEXT>believe me.<WAIT>"
    db "@"

Message_0C_34::
    db "<VOICE1>*: This is the<LINE>"
    db "second floor.<PROMPT>"
    db "<NEXT>This is the Life"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>I'm not powerful,"
    db "<NEXT>but I am durable!<WAIT>"
    db "@"

Message_0C_35::
    db $f0

Message_0C_36::
    db $f0

Message_0C_37::
    db "<VOICE1>*: You're quite<LINE>"
    db "good at this.<PROMPT>"
    db "<NEXT>Sure, take the"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>Upstairs is the"
    db "<NEXT>Pain Chamber.<PROMPT>"
    db "<NEXT>I don't like being"
    db "<NEXT>hurt, so I really<PROMPT>"
    db "<NEXT>hate going up"
    db "<NEXT>there, yikes!<WAIT>"
    db "@"

Message_0C_38::
    db "<VOICE1>*: This is the<LINE>"
    db "third floor.<PROMPT>"
    db "<NEXT>It's the Pain"
    db "<NEXT>Chamber.<PROMPT>"
    db "<NEXT>I'll tell you right"
    db "<NEXT>now, it really<PROMPT>"
    db "<NEXT>does hurt a lot in"
    db "<NEXT>here! Here goes!<WAIT>"
    db "@"

Message_0C_39::
    db $f0

Message_0C_3A::
    db $f0

Message_0C_3B::
    db "<VOICE1>*: You've shown me<LINE>"
    db "your worth.<PROMPT>"
    db "<NEXT>Go on, take the"
    db "<NEXT>treasures.<PROMPT>"
    db "<NEXT>The Healing"
    db "<NEXT>Chamber is next.<PROMPT>"
    db "<NEXT>Monsters skilled"
    db "<NEXT>at healing are<PROMPT>"
    db "<NEXT>eagerly waiting"
    db "<NEXT>for you.<WAIT>"
    db "@"

Message_0C_3C::
    db "<VOICE1>*: This is the<LINE>"
    db "fourth floor.<PROMPT>"
    db "<NEXT>The Healing"
    db "<NEXT>Chamber it is!<PROMPT>"
    db "<NEXT>The first thing"
    db "<NEXT>you should know<PROMPT>"
    db "<NEXT>is that attacking"
    db "<NEXT>us is a waste.<PROMPT>"
    db "<NEXT>Without further"
    db "<NEXT>ado, let's begin.<WAIT>"
    db "@"

Message_0C_3D::
    db $f0

Message_0C_3E::
    db $f0

Message_0C_3F::
    db "<VOICE1>*: Fine, we will<LINE>"
    db "confer all the<PROMPT>"
    db "<NEXT>treasures to you"
    db "<NEXT>for your victory.<PROMPT>"
    db "<NEXT>Up next is the"
    db "<NEXT>Chaos Chamber.<PROMPT>"
    db "<NEXT>The greatest of"
    db "<NEXT>the destroyers<PROMPT>"
    db "<NEXT>stand guard over"
    db "<NEXT>the treasures.<WAIT>"
    db "@"

Message_0C_40::
    db "<VOICE1>*: This is the<LINE>"
    db "fifth floor.<PROMPT>"
    db "<NEXT>Welcome to the"
    db "<NEXT>Chaos Chamber.<PROMPT>"
    db "<NEXT>Have you said your"
    db "<NEXT>prayers?<PROMPT>"
    db "<NEXT>We will come out"
    db "<NEXT>at maximum power!<WAIT>"
    db "@"

Message_0C_41::
    db $f0

Message_0C_42::
    db $f0

Message_0C_43::
    db "<VOICE1>*: All right.<LINE>"
    db "Good enough.<PROMPT>"
    db "<NEXT>The treasures are"
    db "<NEXT>yours to take.<PROMPT>"
    db "<NEXT>The Tower's peak"
    db "<NEXT>is next.<PROMPT>"
    db "<NEXT>The great being"
    db "<NEXT>awaits you.<WAIT>"
    db "@"

Message_0C_44::
    db "<VOICE1>*: Oh? Well, well,<LINE>"
    db "you're the first<PROMPT>"
    db "<NEXT>master to visit me"
    db "<NEXT>in a long time.<PROMPT>"
    db "<NEXT>But look at you!"
    db "<NEXT>You're a child!<PROMPT>"
    db "<NEXT>I'm the Grand"
    db "<NEXT>Master.<PROMPT>"
    db "<NEXT>I built this"
    db "<NEXT>Tower.<PROMPT>"
    db "<NEXT>I've been waiting"
    db "<NEXT>for strong masters<PROMPT>"
    db "<NEXT>to come ever since"
    db "<NEXT>then.<PROMPT>"
    db "<NEXT>Please, show me"
    db "<NEXT>what you can do!<WAIT>"
    db "@"

Message_0C_45::
    db "<VOICE1>*: Hello! You've<LINE>"
    db "come back!<PROMPT>"
    db "<NEXT>Are you feeling"
    db "<NEXT>lucky?<PROMPT>"
    db "<NEXT>Then, let's start!"
    db "<NEXT>Here we go!<WAIT>"
    db "@"

Message_0C_46::
    db "<VOICE1>*: You are good!<LINE>"
    db "I like you!<PROMPT>"
    db "<NEXT>You've conquered"
    db "<NEXT>all three Towers-<PROMPT>"
    db "<NEXT>Power, Baffle and"
    db "<NEXT>this, Soul Tower.<PROMPT>"
    db "<NEXT>You're certain to"
    db "<NEXT>get even better.<PROMPT>"
    db "<NEXT>I want you to have"
    db "<NEXT>some gifts!<WAIT>"
    db "@"

Message_0C_47::
    db "<VOICE1>*: You've conquered<LINE>"
    db "the Soul Tower.<PROMPT>"
    db "<NEXT>I hope you'll keep"
    db "<NEXT>working towards<PROMPT>"
    db "<NEXT>becoming the best"
    db "<NEXT>master ever.<WAIT>"
    db "@"

Message_0C_48::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>The treasure chest"
    db "<NEXT>was a Mimic!<WAIT>"
    db "@"

Message_0C_49::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>It was a Mimic!"
    db "<NEXT>It began to talk.<WAIT>"
    db "@"

Message_0C_4A::
    db "<VOICE1>*: Lightning when<LINE>"
    db "wet is dangerous!<WAIT>"
    db "@"

Message_0C_4B::
    db "<VOICE1>*: When it's cold,<LINE>"
    db "fire's the answer!<WAIT>"
    db "@"

Message_0C_4C::
    db "<VOICE1>*: Electric jolts<LINE>"
    db "are good at times.<WAIT>"
    db "@"

Message_0C_4D::
    db "<VOICE1>*: Hot! Hot!<LINE>"
    db "Burning up!<WAIT>"
    db "@"

Message_0C_4E::
    db "<VOICE1>*: What to do if we<LINE>"
    db "are all in danger…<WAIT>"
    db "@"

Message_0C_4F::
    db "<VOICE1>*: Sweets are good<LINE>"
    db "cheap energy!<WAIT>"
    db "@"

Message_0C_50::
    db "<VOICE1>*: Overconfidence<LINE>"
    db "is a trap.<WAIT>"
    db "@"

Message_0C_51::
    db "<VOICE1>*: I'm scared…<LINE>"
    db "Terrified, even…<WAIT>"
    db "@"

Message_0C_52::
    db "<VOICE1>*: If it hurts,<LINE>"
    db "heal it.<WAIT>"
    db "@"

Message_0C_53::
    db "<VOICE1>*: Good health<LINE>"
    db "above all.<WAIT>"
    db "@"

Message_0C_54::
    db "<VOICE1>*: Pow! Ka-pow!<LINE>"
    db "Big trouble!<WAIT>"
    db "@"

Message_0C_55::
    db "<VOICE1>*: Young master…<LINE>"
    db "The final test…<WAIT>"
    db "@"

Message_0C_56::
    db "<VOICE2>*: Really! Wow!<LINE>"
    db "You're the first<PROMPT>"
    db "<NEXT>human that I've"
    db "<NEXT>ever met!<PROMPT>"
    db "<NEXT>Wow, a human is"
    db "<NEXT>pretty cute!<PROMPT>"
    db "<NEXT>Don't you think so,"
    db "<NEXT>big brother?<WAIT>"
    db "@"

Message_0C_57::
    db "<VOICE2>*: Oh, don't lie!<LINE>"
    db "You don't look<PROMPT>"
    db "<NEXT>like an elf or a"
    db "<NEXT>monster at all!<PROMPT>"
    db "<NEXT>You really are a"
    db "<NEXT>human, aren't you?<CHOICE>"
    db "@"

Message_0C_58::
    db "<VOICE1>*: What is it, you<LINE>"
    db "little brat?<PROMPT>"
    db "<NEXT>Did you come to"
    db "<NEXT>get creamed too?<PROMPT>"
    db "<NEXT>That town is full"
    db "<NEXT>of the idle rich.<PROMPT>"
    db "<NEXT>Their treasures"
    db "<NEXT>are there for the<PROMPT>"
    db "<NEXT>taking, so I took"
    db "<NEXT>them.<PROMPT>"
    db "<NEXT>I was going to"
    db "<NEXT>sell it off and<PROMPT>"
    db "<NEXT>make some serious"
    db "<NEXT>money.<PROMPT>"
    db "<NEXT>But a brat like"
    db "<NEXT>you comes along!<PROMPT>"
    db "<NEXT>I can still make"
    db "<NEXT>this work…<PROMPT>"
    db "<NEXT>If I don't let you"
    db "<NEXT>go alive!<WAIT>"
    db "@"

Message_0C_DF::
    db "<VOICE1>*: What is it, you<LINE>"
    db "little brat?<PROMPT>"
    db "<NEXT>Back to get"
    db "<NEXT>creamed again?<PROMPT>"
    db "<NEXT>I won't let you go"
    db "<NEXT>alive this time!<WAIT>"
    db "@"

Message_0C_E0::
    db "<VOICE1>*: But… No! I lost<LINE>"
    db "to this brat?<WAIT>"
    db "@"

Message_0C_E1::
    db "<VOICE2>Milayou: You are<LINE>"
    db "really special.<PROMPT>"
    db "<NEXT>I couldn't do a"
    db "<NEXT>thing against him…<PROMPT>"
    db "<NEXT>I'll have to train"
    db "<NEXT>that much harder…<PROMPT>"
    db "<NEXT>I'll be no match"
    db "<NEXT>for my kid brother<PROMPT>"
    db "<NEXT>if  I don't apply"
    db "<NEXT>myself better.<PROMPT>"
    db "<NEXT>I'll wait for you"
    db "<NEXT>in town!<WAIT>"
    db "@"

Message_0C_E2::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "town of Miagen.<PROMPT>"
    db "<NEXT>We're proud of our"
    db "<NEXT>affluence here!<WAIT>"
    db "@"

Message_0C_E3::
    db "<VOICE2>*: So you defeated<LINE>"
    db "the evildoer?<WAIT>"
    db "@"

Message_0C_E4::
    db "<VOICE1>*: Wow, you have<LINE>"
    db "monsters! Wicked!<PROMPT>"
    db "<NEXT>They beat the bad"
    db "<NEXT>guy, didn't they?<WAIT>"
    db "@"

Message_0C_E5::
    db "<VOICE2>*: Your monsters<LINE>"
    db "are good, it's<PROMPT>"
    db "<NEXT>plain to see."
    db "<NEXT>I like them!<WAIT>"
    db "@"

Message_0C_E6::
    db "<VOICE1>*: So there are<LINE>"
    db "evil masters…<PROMPT>"
    db "<NEXT>Oh, but you're not"
    db "<NEXT>one of those.<WAIT>"
    db "@"

Message_0C_E7::
    db "<VOICE2>*: Controlling<LINE>"
    db "monsters is no<PROMPT>"
    db "<NEXT>easy feat, is it?"
    db "<NEXT>I'm so in awe!<PROMPT>"
    db "<NEXT>You've brought"
    db "<NEXT>peace to us!<WAIT>"
    db "@"

Message_0C_E8::
    db "<VOICE1>*: I thank you in<LINE>"
    db "all sincerity!<WAIT>"
    db "@"

Message_0C_E9::
    db "<VOICE2>*: The atmosphere<LINE>"
    db "has cheered up,<PROMPT>"
    db "<NEXT>thanks to your"
    db "<NEXT>crime busting.<PROMPT>"
    db "<NEXT>It gives me hope"
    db "<NEXT>to live another<PROMPT>"
    db "<NEXT>one hundred years!"
    db "<NEXT><WAIT>"
    db "@"

Message_0C_EA::
    db "<VOICE1>*: I long to have a<LINE>"
    db "family of my own.<PROMPT>"
    db "<NEXT>I wish I was"
    db "<NEXT>married…<WAIT>"
    db "@"

Message_0C_EB::
    db "<VOICE2>*: Old people say<LINE>"
    db "that a cheerful<PROMPT>"
    db "<NEXT>town is a good"
    db "<NEXT>town. I agree!<WAIT>"
    db "@"

Message_0C_EC::
    db "<VOICE1>*: Monsters can be<LINE>"
    db "good or evil on<PROMPT>"
    db "<NEXT>the whims of their"
    db "<NEXT>masters, I guess.<WAIT>"
    db "@"

Message_0C_ED::
    db "<VOICE2>*: The thief was<LINE>"
    db "selling what he<PROMPT>"
    db "<NEXT>stole from us for"
    db "<NEXT>a lot of gold.<PROMPT>"
    db "<NEXT>But why would he"
    db "<NEXT>steal my clothes?<PROMPT>"
    db "<NEXT>Were they valuable"
    db "<NEXT>because they were<PROMPT>"
    db "<NEXT>mine? I'm not sure"
    db "<NEXT>I want to know…<WAIT>"
    db "@"

Message_0C_EE::
    db "<VOICE1>*: It sure was a<LINE>"
    db "thrilling time<PROMPT>"
    db "<NEXT>when the thief was"
    db "<NEXT>roving around.<WAIT>"
    db "@"

Message_0C_EF::
    db "<VOICE2>Milayou: I asked<LINE>"
    db "for your support<PROMPT>"
    db "<NEXT>to capture that"
    db "<NEXT>thief…<PROMPT>"
    db "<NEXT>But you ended up"
    db "<NEXT>doing it all.<PROMPT>"
    db "<NEXT>I'm sorry, and"
    db "<NEXT>thank you.<PROMPT>"
    db "<NEXT>Oh? You're from"
    db "<NEXT>GreatLog?<PROMPT>"
    db "<NEXT>And you've won"
    db "<NEXT>tournaments.<PROMPT>"
    db "<NEXT>Well, no wonder"
    db "<NEXT>you're strong.<PROMPT>"
    db "<NEXT>How is Kameha,"
    db "<NEXT>by the way?<WAIT>"
    db "@"

Message_0C_F0::
    db "<VOICE2>Milayou: How do I<LINE>"
    db "know about him?<PROMPT>"
    db "<NEXT>Well…"
    db "<NEXT>That's a secret!<WAIT>"
    db "@"

Message_0C_F1::
    db "<VOICE2>Milayou: You've<LINE>"
    db "inspired me to try<PROMPT>"
    db "<NEXT>harder in my"
    db "<NEXT>training.<PROMPT>"
    db "<NEXT>I hope we can"
    db "<NEXT>battle some day!<WAIT>"
    db "@"

Message_0C_F2::
    db "<VOICE1>*: That merchant,<LINE>"
    db "he was a thief.<PROMPT>"
    db "<NEXT>In one way he has"
    db "<NEXT>my admiration.<PROMPT>"
    db "<NEXT>His bad deeds"
    db "<NEXT>escaped my notice!<WAIT>"
    db "@"

Message_0C_F3::
    db "<VOICE1>*: People say you<LINE>"
    db "can't judge people<PROMPT>"
    db "<NEXT>by appearances…"
    db "<NEXT>But that thieving<PROMPT>"
    db "<NEXT>merchant… He had"
    db "<NEXT>the bad guy look!<WAIT>"
    db "@"

Message_0C_F4::
    db "<VOICE2>*: That greedy<LINE>"
    db "hound of a dealer<PROMPT>"
    db "<NEXT>was behind those"
    db "<NEXT>monsters…<PROMPT>"
    db "<NEXT>But to be caught"
    db "<NEXT>out by selling<PROMPT>"
    db "<NEXT>what he stole…"
    db "<NEXT>He's not what I<PROMPT>"
    db "<NEXT>call a criminal"
    db "<NEXT>mastermind.<WAIT>"
    db "@"

Message_0C_F5::
    db "<VOICE2>Milayou: I knew<LINE>"
    db "you", $44, " come back!<PROMPT>"
    db "<NEXT>I've trained hard"
    db "<NEXT>since we last met.<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>spar with me?<CHOICE>"
    db "@"

Message_0C_F6::
    db "<VOICE2>Milayou: Great!<LINE>"
    db "No holding back!<WAIT>"
    db "@"

Message_0C_F7::
    db "<VOICE2>Milayou: Oh…<LINE>"
    db "I'm disappointed…<PROMPT>"
    db "<NEXT>Come again if you"
    db "<NEXT>want to spar.<WAIT>"
    db "@"

Message_0C_F8::
    db "<VOICE2>Milayou: Want to<LINE>"
    db "spar with me?<CHOICE>"
    db "@"

Message_0C_F9::
    db "<VOICE2>Milayou: I lost…<LINE>"
    db "But, good battle!<PROMPT>"
    db "<NEXT>Oh, I need to tell"
    db "<NEXT>you this.<PROMPT>"
    db "<NEXT>If you meet a boy"
    db "<NEXT>named Terry,<PROMPT>"
    db "<NEXT>please crush him"
    db "<NEXT>in battle.<PROMPT>"
    db "<NEXT>He's not anyone"
    db "<NEXT>special, so you<PROMPT>"
    db "<NEXT>can just destroy"
    db "<NEXT>him. Promise!<PROMPT>"
    db "<NEXT>I really should"
    db "<NEXT>get going myself.<PROMPT>"
    db "<NEXT>I hope we can meet"
    db "<NEXT>again somewhere,<PROMPT>"
    db "<NEXT>sometime. OK!"
    db "<NEXT>Bye-bye!<WAIT>"
    db "@"

Message_0C_FA::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>A tantalizing"
    db "<NEXT>aroma wafted out…<WAIT>"
    db "@"

Message_0C_FB::
    db "<BUF0> tried to<LINE>"
    db "open the chest.<PROMPT>"
    db "<NEXT>But it was locked."
    db "<NEXT><WAIT>"
    db "@"

Message_0C_FC::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>Cold water lapped"
    db "<NEXT>and rippled.<WAIT>"
    db "@"

Message_0C_FD::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>Meat sizzled on a"
    db "<NEXT>skewer.<WAIT>"
    db "@"

Message_0C_FE::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>It was crammed"
    db "<NEXT>with treasures.<PROMPT>"
    db "<NEXT>It appears to be"
    db "<NEXT>loot taken from<PROMPT>"
    db "<NEXT>the town."
    db "<NEXT><WAIT>"
    db "@"

Message_0C_FF::
    db $f0
    ds $14a1, $00
