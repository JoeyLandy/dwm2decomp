; ROM bank $8A: string tables
; The annotated listing of this bank is build/listing/bank8a.asm.

SECTION "Bank 8A", ROMX[$4000], BANK[$8A]
    db $8a

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank8A::
    ld de, BeginStringDisplay_Bank8A_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank8A_StringCategories::
    dw StringList_Bank8A_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank8A_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank8A_StringCategories_0::
    dw String_8A_00_00 ; id 0
    dw String_8A_00_01 ; id 1
    dw String_8A_00_02 ; id 2
    dw String_8A_00_03 ; id 3
    dw String_8A_00_04 ; id 4
    dw String_8A_00_05 ; id 5
    dw String_8A_00_05 ; id 6
    dw String_8A_00_05 ; id 7
    dw String_8A_00_05 ; id 8
    dw String_8A_00_09 ; id 9
    dw String_8A_00_0A ; id 10
    dw String_8A_00_0B ; id 11
    dw String_8A_00_0B ; id 12
    dw String_8A_00_0B ; id 13
    dw String_8A_00_0B ; id 14
    dw String_8A_00_0B ; id 15
    dw String_8A_00_0B ; id 16
    dw String_8A_00_11 ; id 17
    dw String_8A_00_11 ; id 18
    dw String_8A_00_11 ; id 19
    dw String_8A_00_14 ; id 20
    dw String_8A_00_15 ; id 21
    dw String_8A_00_16 ; id 22
    dw String_8A_00_17 ; id 23
    dw String_8A_00_18 ; id 24
    dw String_8A_00_19 ; id 25
    dw String_8A_00_1A ; id 26
    dw String_8A_00_1B ; id 27
    dw String_8A_00_1C ; id 28
    dw String_8A_00_1D ; id 29
    dw String_8A_00_1E ; id 30
    dw String_8A_00_1F ; id 31
    dw String_8A_00_20 ; id 32
    dw String_8A_00_21 ; id 33
    dw String_8A_00_22 ; id 34
    dw String_8A_00_23 ; id 35
    dw String_8A_00_24 ; id 36
    dw String_8A_00_25 ; id 37
    dw String_8A_00_26 ; id 38
    dw String_8A_00_27 ; id 39
    dw String_8A_00_28 ; id 40
    dw String_8A_00_29 ; id 41
    dw String_8A_00_2A ; id 42
    dw String_8A_00_2B ; id 43
    dw String_8A_00_2B ; id 44
    dw String_8A_00_2B ; id 45
    dw String_8A_00_2B ; id 46
    dw String_8A_00_2B ; id 47
    dw String_8A_00_2B ; id 48
    dw String_8A_00_2B ; id 49
    dw String_8A_00_2B ; id 50
    dw String_8A_00_2B ; id 51
    dw String_8A_00_2B ; id 52
    dw String_8A_00_2B ; id 53
    dw String_8A_00_2B ; id 54
    dw String_8A_00_2B ; id 55
    dw String_8A_00_2B ; id 56
    dw String_8A_00_2B ; id 57
    dw String_8A_00_2B ; id 58
    dw String_8A_00_2B ; id 59
    dw String_8A_00_2B ; id 60
    dw String_8A_00_2B ; id 61
    dw String_8A_00_2B ; id 62
    dw String_8A_00_2B ; id 63
    dw String_8A_00_2B ; id 64
    dw String_8A_00_2B ; id 65
    dw String_8A_00_2B ; id 66
    dw String_8A_00_2B ; id 67
    dw String_8A_00_2B ; id 68
    dw String_8A_00_2B ; id 69
    dw String_8A_00_2B ; id 70
    dw String_8A_00_2B ; id 71
    dw String_8A_00_2B ; id 72
    dw String_8A_00_2B ; id 73
    dw String_8A_00_2B ; id 74
    dw String_8A_00_2B ; id 75
    dw String_8A_00_2B ; id 76
    dw String_8A_00_2B ; id 77
    dw String_8A_00_2B ; id 78
    dw String_8A_00_2B ; id 79
    dw String_8A_00_2B ; id 80
    dw String_8A_00_2B ; id 81
    dw String_8A_00_2B ; id 82
    dw String_8A_00_2B ; id 83
    dw String_8A_00_2B ; id 84
    dw String_8A_00_2B ; id 85
    dw String_8A_00_2B ; id 86
    dw String_8A_00_2B ; id 87
    dw String_8A_00_2B ; id 88
    dw String_8A_00_2B ; id 89
    dw String_8A_00_2B ; id 90
    dw String_8A_00_2B ; id 91
    dw String_8A_00_2B ; id 92
    dw String_8A_00_2B ; id 93
    dw String_8A_00_2B ; id 94
    dw String_8A_00_2B ; id 95
    dw String_8A_00_2B ; id 96
    dw String_8A_00_2B ; id 97
    dw String_8A_00_2B ; id 98
    dw String_8A_00_2B ; id 99
    dw String_8A_00_2B ; id 100
    dw String_8A_00_2B ; id 101
    dw String_8A_00_2B ; id 102
    dw String_8A_00_2B ; id 103
    dw String_8A_00_2B ; id 104
    dw String_8A_00_2B ; id 105
    dw String_8A_00_2B ; id 106
    dw String_8A_00_2B ; id 107
    dw String_8A_00_2B ; id 108
    dw String_8A_00_2B ; id 109
    dw String_8A_00_2B ; id 110
    dw String_8A_00_2B ; id 111
    dw String_8A_00_2B ; id 112
    dw String_8A_00_2B ; id 113
    dw String_8A_00_2B ; id 114
    dw String_8A_00_2B ; id 115
    dw String_8A_00_2B ; id 116
    dw String_8A_00_2B ; id 117
    dw String_8A_00_2B ; id 118
    dw String_8A_00_2B ; id 119
    dw String_8A_00_2B ; id 120
    dw String_8A_00_2B ; id 121
    dw String_8A_00_2B ; id 122
    dw String_8A_00_2B ; id 123
    dw String_8A_00_2B ; id 124
    dw String_8A_00_2B ; id 125
    dw String_8A_00_2B ; id 126
    dw String_8A_00_2B ; id 127
    dw String_8A_00_2B ; id 128
    dw String_8A_00_2B ; id 129
    dw String_8A_00_2B ; id 130
    dw String_8A_00_2B ; id 131
    dw String_8A_00_2B ; id 132
    dw String_8A_00_2B ; id 133
    dw String_8A_00_2B ; id 134
    dw String_8A_00_2B ; id 135
    dw String_8A_00_2B ; id 136
    dw String_8A_00_2B ; id 137
    dw String_8A_00_2B ; id 138
    dw String_8A_00_2B ; id 139
    dw String_8A_00_2B ; id 140
    dw String_8A_00_2B ; id 141
    dw String_8A_00_2B ; id 142
    dw String_8A_00_2B ; id 143
    dw String_8A_00_2B ; id 144
    dw String_8A_00_2B ; id 145
    dw String_8A_00_2B ; id 146
    dw String_8A_00_2B ; id 147
    dw String_8A_00_2B ; id 148
    dw String_8A_00_2B ; id 149
    dw String_8A_00_2B ; id 150
    dw String_8A_00_2B ; id 151
    dw String_8A_00_2B ; id 152
    dw String_8A_00_2B ; id 153
    dw String_8A_00_2B ; id 154
    dw String_8A_00_2B ; id 155
    dw String_8A_00_2B ; id 156
    dw String_8A_00_2B ; id 157
    dw String_8A_00_2B ; id 158
    dw String_8A_00_2B ; id 159
    dw String_8A_00_2B ; id 160
    dw String_8A_00_2B ; id 161
    dw String_8A_00_2B ; id 162
    dw String_8A_00_2B ; id 163
    dw String_8A_00_2B ; id 164
    dw String_8A_00_2B ; id 165
    dw String_8A_00_2B ; id 166
    dw String_8A_00_2B ; id 167
    dw String_8A_00_2B ; id 168
    dw String_8A_00_2B ; id 169
    dw String_8A_00_2B ; id 170
    dw String_8A_00_2B ; id 171
    dw String_8A_00_2B ; id 172
    dw String_8A_00_2B ; id 173
    dw String_8A_00_2B ; id 174
    dw String_8A_00_2B ; id 175
    dw String_8A_00_2B ; id 176
    dw String_8A_00_2B ; id 177
    dw String_8A_00_2B ; id 178
    dw String_8A_00_2B ; id 179
    dw String_8A_00_2B ; id 180
    dw String_8A_00_2B ; id 181
    dw String_8A_00_2B ; id 182
    dw String_8A_00_2B ; id 183
    dw String_8A_00_2B ; id 184
    dw String_8A_00_2B ; id 185
    dw String_8A_00_2B ; id 186
    dw String_8A_00_2B ; id 187
    dw String_8A_00_2B ; id 188
    dw String_8A_00_2B ; id 189
    dw String_8A_00_2B ; id 190
    dw String_8A_00_2B ; id 191
    dw String_8A_00_2B ; id 192
    dw String_8A_00_2B ; id 193
    dw String_8A_00_2B ; id 194
    dw String_8A_00_2B ; id 195
    dw String_8A_00_2B ; id 196
    dw String_8A_00_2B ; id 197
    dw String_8A_00_2B ; id 198
    dw String_8A_00_2B ; id 199
    dw String_8A_00_2B ; id 200
    dw String_8A_00_2B ; id 201
    dw String_8A_00_2B ; id 202
    dw String_8A_00_2B ; id 203
    dw String_8A_00_2B ; id 204
    dw String_8A_00_2B ; id 205
    dw String_8A_00_2B ; id 206
    dw String_8A_00_2B ; id 207
    dw String_8A_00_2B ; id 208
    dw String_8A_00_2B ; id 209
    dw String_8A_00_2B ; id 210
    dw String_8A_00_2B ; id 211
    dw String_8A_00_2B ; id 212
    dw String_8A_00_2B ; id 213
    dw String_8A_00_2B ; id 214
    dw String_8A_00_2B ; id 215
    dw String_8A_00_2B ; id 216
    dw String_8A_00_2B ; id 217
    dw String_8A_00_2B ; id 218
    dw String_8A_00_2B ; id 219
    dw String_8A_00_2B ; id 220
    dw String_8A_00_2B ; id 221
    dw String_8A_00_2B ; id 222
    dw String_8A_00_2B ; id 223
    dw String_8A_00_2B ; id 224
    dw String_8A_00_2B ; id 225
    dw String_8A_00_2B ; id 226
    dw String_8A_00_2B ; id 227
    dw String_8A_00_2B ; id 228
    dw String_8A_00_2B ; id 229
    dw String_8A_00_2B ; id 230
    dw String_8A_00_2B ; id 231
    dw String_8A_00_2B ; id 232
    dw String_8A_00_2B ; id 233
    dw String_8A_00_2B ; id 234
    dw String_8A_00_2B ; id 235
    dw String_8A_00_2B ; id 236
    dw String_8A_00_2B ; id 237
    dw String_8A_00_2B ; id 238
    dw String_8A_00_2B ; id 239
    dw String_8A_00_2B ; id 240
    dw String_8A_00_2B ; id 241
    dw String_8A_00_2B ; id 242
    dw String_8A_00_2B ; id 243
    dw String_8A_00_2B ; id 244
    dw String_8A_00_2B ; id 245
    dw String_8A_00_2B ; id 246
    dw String_8A_00_2B ; id 247
    dw String_8A_00_2B ; id 248
    dw String_8A_00_2B ; id 249
    dw String_8A_00_2B ; id 250
    dw String_8A_00_2B ; id 251
    dw String_8A_00_2B ; id 252
    dw String_8A_00_2B ; id 253
    dw String_8A_00_2B ; id 254

String_8A_00_00::
    db "<VOICE1>*: I'll tell you<LINE>"
    db "about this great<PROMPT>"
    db "<NEXT>adventure story I"
    db "<NEXT>read long ago.<PROMPT>"
    db "<NEXT>Master Hasta's"
    db "<NEXT>Adventure…<PROMPT>"
    db "<NEXT>Book 1,"
    db "<NEXT>The Name is Hasta…<PROMPT>"
    db "<NEXT>There once was a"
    db "<NEXT>boy named Hasta.<PROMPT>"
    db "<NEXT>Who dreamed of"
    db "<NEXT>becoming a master.<PROMPT>"
    db "<NEXT>One day he awoke,"
    db "<NEXT>and had a nice…<PROMPT>"
    db "<NEXT>…Wait, how", $44, " the"
    db "<NEXT>rest of it go?<WAIT>"
    db "@"

String_8A_00_01::
    db "<VOICE1>*: Hey, do you know<LINE>"
    db "this tale? Listen!<PROMPT>"
    db "<NEXT>Master Hasta's"
    db "<NEXT>Adventure…<PROMPT>"
    db "<NEXT>Book 2,"
    db "<NEXT>What Lies Beside…<PROMPT>"
    db "<NEXT>When Hasta awoke,"
    db "<NEXT>he realized that<PROMPT>"
    db "<NEXT>he wasn't alone in"
    db "<NEXT>his bed.<PROMPT>"
    db "<NEXT>Lying beside him"
    db "<NEXT>was a rotted body!<PROMPT>"
    db "<NEXT>What do you think?"
    db "<NEXT>Pretty scary, eh?<WAIT>"
    db "@"

String_8A_00_02::
    db "<VOICE2>*: Want to hear<LINE>"
    db "about a story I<PROMPT>"
    db "<NEXT>read when I was"
    db "<NEXT>little?<PROMPT>"
    db "<NEXT>Master Hasta's"
    db "<NEXT>Adventure…<PROMPT>"
    db "<NEXT>Book 3,"
    db "<NEXT>Dead Man Waking…<PROMPT>"
    db "<NEXT>Hasta found"
    db "<NEXT>his courage and<PROMPT>"
    db "<NEXT>prodded the fetid"
    db "<NEXT>corpse…<PROMPT>"
    db "<NEXT>The putrid horror"
    db "<NEXT>suddenly sat up!<PROMPT>"
    db "<NEXT>It was actually a"
    db "<NEXT>Hork!<PROMPT>"
    db "<NEXT>Oooh, I thought it"
    db "<NEXT>was so scary!<WAIT>"
    db "@"

String_8A_00_03::
    db "<VOICE1>*: Let me recount<LINE>"
    db "this ancient lore…<PROMPT>"
    db "<NEXT>Master Hasta's"
    db "<NEXT>Adventure…<PROMPT>"
    db "<NEXT>Book 4,"
    db "<NEXT>Undead Calm…<PROMPT>"
    db "<NEXT>Hork stretched and"
    db "<NEXT>yawned out loud,<PROMPT>"
    db "<NEXT>'Fwaaah… I need my"
    db "<NEXT>beauty sleep.", $95, "<PROMPT>"
    db "<NEXT>And Hork went back"
    db "<NEXT>to sleep.<PROMPT>"
    db "<NEXT>I guess that must"
    db "<NEXT>be what sleeping<PROMPT>"
    db "<NEXT>like the dead is"
    db "<NEXT>all about.<WAIT>"
    db "@"

String_8A_00_04::
    db "<VOICE1>*: Long ago, there<LINE>"
    db "were books titled<PROMPT>"
    db "<NEXT>Master Hasta's"
    db "<NEXT>Adventure.<PROMPT>"
    db "<NEXT>But the author"
    db "<NEXT>gave up after just<PROMPT>"
    db "<NEXT>four slim books, I"
    db "<NEXT>hear.<PROMPT>"
    db "<NEXT>I wonder if anyone"
    db "<NEXT>remembers them?<WAIT>"
    db "@"

String_8A_00_05::
    db "<VOICE1>*: Hey, did you<LINE>"
    db "know?<PROMPT>"
    db "<NEXT>In any world that"
    db "<NEXT>you visit using an<PROMPT>"
    db "<NEXT>appraised Magic"
    db "<NEXT>Key, you'll come<PROMPT>"
    db "<NEXT>across bosses of"
    db "<NEXT>certain areas.<PROMPT>"
    db "<NEXT>Until those bosses"
    db "<NEXT>are defeated, no<PROMPT>"
    db "<NEXT>monster will join"
    db "<NEXT>your party.<PROMPT>"
    db "<NEXT>They may want to,"
    db "<NEXT>but they can't<PROMPT>"
    db "<NEXT>with the bosses"
    db "<NEXT>watching them.<PROMPT>"
    db "<NEXT>So, if you want to"
    db "<NEXT>befriend monsters,<PROMPT>"
    db "<NEXT>you need to defeat"
    db "<NEXT>the area bosses.<WAIT>"
    db "@"

String_8A_00_09::
    db "<VOICE2>*: If you visit any<LINE>"
    db "world using an<PROMPT>"
    db "<NEXT>appraised Magic"
    db "<NEXT>Key, there will<PROMPT>"
    db "<NEXT>always be bosses"
    db "<NEXT>of certain areas.<PROMPT>"
    db "<NEXT>If you don't beat"
    db "<NEXT>those bosses, no<PROMPT>"
    db "<NEXT>monster will join"
    db "<NEXT>your party.<PROMPT>"
    db "<NEXT>They're too scared"
    db "<NEXT>of their bosses to<PROMPT>"
    db "<NEXT>even consider"
    db "<NEXT>rebelling.<PROMPT>"
    db "<NEXT>So, if you want"
    db "<NEXT>monsters to join<PROMPT>"
    db "<NEXT>you, defeat the"
    db "<NEXT>area bosses.<WAIT>"
    db "@"

String_8A_00_0A::
    db "<VOICE1>*: In every world<LINE>"
    db "visited using an<PROMPT>"
    db "<NEXT>appraised Magic"
    db "<NEXT>Key, you will see<PROMPT>"
    db "<NEXT>monster bosses"
    db "<NEXT>exerting rule.<PROMPT>"
    db "<NEXT>Unless they are"
    db "<NEXT>defeated, no<PROMPT>"
    db "<NEXT>monster will dare"
    db "<NEXT>to join you.<PROMPT>"
    db "<NEXT>Fear of their"
    db "<NEXT>bosses keeps them<PROMPT>"
    db "<NEXT>from acting on"
    db "<NEXT>their own.<PROMPT>"
    db "<NEXT>That's why you"
    db "<NEXT>must defeat bosses<PROMPT>"
    db "<NEXT>first to befriend"
    db "<NEXT>wild monsters.<WAIT>"
    db "@"

String_8A_00_0B::
    db "<VOICE1>*: There should be<LINE>"
    db "a castle in which<PROMPT>"
    db "<NEXT>the monster boss"
    db "<NEXT>resides.<PROMPT>"
    db "<NEXT>Wild monsters are"
    db "<NEXT>dominated by the<PROMPT>"
    db "<NEXT>boss, and won't"
    db "<NEXT>become tame…<WAIT>"
    db "@"

String_8A_00_11::
    db "<VOICE1>*: Monsters you<LINE>"
    db "beat in battle<PROMPT>"
    db "<NEXT>could join your"
    db "<NEXT>party.<PROMPT>"
    db "<NEXT>A strong monster"
    db "<NEXT>makes a powerful<PROMPT>"
    db "<NEXT>companion-if you"
    db "<NEXT>can get one.<WAIT>"
    db "@"

String_8A_00_14::
    db "<VOICE1>*: Monsters you<LINE>"
    db "beat in battle<PROMPT>"
    db "<NEXT>could join your"
    db "<NEXT>party.<PROMPT>"
    db "<NEXT>But their boss"
    db "<NEXT>must be beaten<PROMPT>"
    db "<NEXT>before that can"
    db "<NEXT>happen.<WAIT>"
    db "@"

String_8A_00_15::
    db "<VOICE1>*: Traveling with<LINE>"
    db "monsters?<PROMPT>"
    db "<NEXT>That takes a good"
    db "<NEXT>deal of courage.<WAIT>"
    db "@"

String_8A_00_16::
    db "<VOICE1>*: You're so young<LINE>"
    db "and small, but<PROMPT>"
    db "<NEXT>here you are, on a"
    db "<NEXT>perilous journey…<PROMPT>"
    db "<NEXT>Our soldiers can"
    db "<NEXT>stand to learn a<PROMPT>"
    db "<NEXT>thing or two from"
    db "<NEXT>you!<WAIT>"
    db "@"

String_8A_00_17::
    db "<VOICE1>*: The Castle is<LINE>"
    db "safe.<PROMPT>"
    db "<NEXT>Relax, and enjoy"
    db "<NEXT>your stay.<WAIT>"
    db "@"

String_8A_00_18::
    db "<VOICE1>*: Do you know of<LINE>"
    db "the MeteOrb?<PROMPT>"
    db "<NEXT>It's a rare item"
    db "<NEXT>that does away<PROMPT>"
    db "<NEXT>with a monster's"
    db "<NEXT>mistrust.<WAIT>"
    db "@"

String_8A_00_19::
    db "<VOICE1>*: The last monster<LINE>"
    db "you beat in battle<PROMPT>"
    db "<NEXT>has a chance of"
    db "<NEXT>joining you.<PROMPT>"
    db "<NEXT>If you're after a"
    db "<NEXT>specific species,<PROMPT>"
    db "<NEXT>you might consider"
    db "<NEXT>healing it.<WAIT>"
    db "@"

String_8A_00_1A::
    db "<VOICE1>*: There's a monster<LINE>"
    db "that's skilled at<PROMPT>"
    db "<NEXT>attracting the"
    db "<NEXT>opposite sex.<WAIT>"
    db "@"

String_8A_00_1B::
    db "<VOICE1>*: If you want to<LINE>"
    db "befriend monsters,<PROMPT>"
    db "<NEXT>give them meat,"
    db "<NEXT>and don't be cheap.<PROMPT>"
    db "<NEXT>The more expensive"
    db "<NEXT>it is, the better<PROMPT>"
    db "<NEXT>the quality of the"
    db "<NEXT>meat, you see.<WAIT>"
    db "@"

String_8A_00_1C::
    db "<VOICE1>*: I met a traveler<LINE>"
    db "who had monsters<PROMPT>"
    db "<NEXT>with him, just"
    db "<NEXT>like you.<PROMPT>"
    db "<NEXT>Those monsters"
    db "<NEXT>looked fearsome!<WAIT>"
    db "@"

String_8A_00_1D::
    db "<VOICE1>*: I met a traveler<LINE>"
    db "who had monsters<PROMPT>"
    db "<NEXT>with him, just"
    db "<NEXT>like you.<PROMPT>"
    db "<NEXT>They used skills"
    db "<NEXT>I", $44, " never seen.<WAIT>"
    db "@"

String_8A_00_1E::
    db "<VOICE1>*: If you ignore<LINE>"
    db "them, monsters<PROMPT>"
    db "<NEXT>will ignore you"
    db "<NEXT>too.<WAIT>"
    db "@"

String_8A_00_1F::
    db "<VOICE1>*: While we do get<LINE>"
    db "travelers here,<PROMPT>"
    db "<NEXT>I've only seen one"
    db "<NEXT>other kid.<PROMPT>"
    db "<NEXT>It was a boy…"
    db "<NEXT>Terry, I think.<WAIT>"
    db "@"

String_8A_00_20::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>But it was empty."
    db "<NEXT><WAIT>"
    db "@"

String_8A_00_21::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>But it was empty."
    db "<NEXT><WAIT>"
    db "@"

String_8A_00_22::
    db "<BUF0> tried to<LINE>"
    db "open the chest.<PROMPT>"
    db "<NEXT>But it was locked."
    db "<NEXT><WAIT>"
    db "@"

String_8A_00_23::
    db "<VOICE1>*: Hello! How may I<LINE>"
    db "help you today?<WAIT>"
    db "@"

String_8A_00_24::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "traveler's inn!<WAIT>"
    db "@"

String_8A_00_25::
    db "<VOICE1>*: Let me see what<LINE>"
    db "you are made of!<WAIT>"
    db "@"

String_8A_00_26::
    db "<VOICE1>*: You'll have to<LINE>"
    db "beat me to pass!<WAIT>"
    db "@"

String_8A_00_27::
    db "<VOICE1>*: I am a servant<LINE>"
    db "of the Gods.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you today?<WAIT>"
    db "@"

String_8A_00_28::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "traveler's inn!<PROMPT>"
    db "<NEXT>The view here is"
    db "<NEXT>magnificent!<WAIT>"
    db "@"

String_8A_00_29::
    db "The evil force<LINE>"
    db "enshrouding the<PROMPT>"
    db "<NEXT>entire world faded"
    db "<NEXT>away!<WAIT>"
    db "@"

String_8A_00_2A::
    db "The evil force<LINE>"
    db "covering the<PROMPT>"
    db "<NEXT>continent faded"
    db "<NEXT>away!<WAIT>"
    db "@"

String_8A_00_2B::
    db $f0
    ds $2d1f, $00
