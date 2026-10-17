; ROM bank $2D: messages
; The annotated listing of this bank is build/listing/bank2d.asm.

SECTION "Bank 2D", ROMX
    db $2d

; Starts a message of message group 5 (strings of category 0 of bank $2D, picked by wStringIndex).
; When wStringIndex is below $D5 it calls BeginStringDisplay with DE = MessageStrings_Bank2D; from
; $D5 on it far-calls BeginStringDisplay_Bank2D_Overflow in bank $99, which subtracts $D5 from
; wStringIndex and uses the overflow table. BeginStringDisplay blanks the text window, points the
; text printer at the string and sets wTextFlags to 1; the text appears on the following frames.
; Reached by farcall from the message group dispatch (ShowMessageHL in bank $5F,
; StartMessageForGroup_Group05 in bank $10) and from the debug menu in bank $01. (C1, E-0378)
; message bank $2D: when wStringIndex < $D5, BeginStringDisplay with this bank's table
; MessageStrings_Bank2D; otherwise far-calls BeginStringDisplay_Bank2D_Overflow (E-0080)
BeginStringDisplay_Bank2D:: ; configured code entry (E-0395 (BeginStringDisplay_Bank2D: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld a, [wStringIndex]
    cp $d5
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2D_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2D
    call BeginStringDisplay
    ret

SECTION "Bank 2D CopyStringToBuffer_Bank2D", ROMX

; Copies a message of message group 5 to a buffer instead of printing it: string wStringIndex of
; category wStringCategory is copied, with its $F0 terminator, to the address in
; wStringDestLo/wStringDestHi. When wStringIndex is below $D5 it uses MessageStrings_Bank2D through
; CopyStringToBuffer; from $D5 on it far-calls CopyStringToBuffer_Bank2D_Overflow in bank $99, which
; subtracts $D5 from wStringIndex first (so wStringIndex is changed). Nothing in src/ calls this
; copy by name. (C2, E-0378)
; message bank $2D: when wStringIndex < $D5, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2D; otherwise far-calls CopyStringToBuffer_Bank2D_Overflow (E-0080)
CopyStringToBuffer_Bank2D:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wStringIndex]
    cp $d5
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2D_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2D
    call CopyStringToBuffer
    ret

SECTION "Bank 2D ShowStringAtOnce_Bank2D", ROMX

; Calls BeginStringDisplay_Bank2D, which starts string wStringIndex of its table, then
; RunStringDisplayToEnd, which prints the whole string at once (wTextFlags bit 1) instead of a glyph
; per frame. No traced code, jump table or pointer reaches it (E-0395: it decodes as a routine but
; is unreached in the static listing). (C1, E-0395)
ShowStringAtOnce_Bank2D:: ; configured code entry (E-0395); C0
    call BeginStringDisplay_Bank2D
    call RunStringDisplayToEnd
    ret

SECTION "Bank 2D MessageStrings_Bank2D", ROMX

; One little-endian word, a pointer to StringList_Bank2D_0, the list of 213 message pointers
; Message_05_00 to Message_05_D4 (message group 5, bank $2D). LookupString reads word
; wStringCategory of it (category 0 is the only word), then word wStringIndex of that list.
; BeginStringDisplay_Bank2D and CopyStringToBuffer_Bank2D pass it in DE for wStringIndex below $D5;
; higher ids go to their Overflow routine. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
MessageStrings_Bank2D::
    dw StringList_Bank2D_0 ; id 0

; category list of MessageStrings_Bank2D; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2D_0::
    dw Message_05_00 ; id 0
    dw Message_05_01 ; id 1
    dw Message_05_02 ; id 2
    dw Message_05_03 ; id 3
    dw Message_05_04 ; id 4
    dw Message_05_05 ; id 5
    dw Message_05_06 ; id 6
    dw Message_05_07 ; id 7
    dw Message_05_08 ; id 8
    dw Message_05_09 ; id 9
    dw Message_05_0A ; id 10
    dw Message_05_0B ; id 11
    dw Message_05_0C ; id 12
    dw Message_05_0D ; id 13
    dw Message_05_0E ; id 14
    dw Message_05_0F ; id 15
    dw Message_05_10 ; id 16
    dw Message_05_11 ; id 17
    dw Message_05_12 ; id 18
    dw Message_05_13 ; id 19
    dw Message_05_14 ; id 20
    dw Message_05_15 ; id 21
    dw Message_05_16 ; id 22
    dw Message_05_17 ; id 23
    dw Message_05_18 ; id 24
    dw Message_05_19 ; id 25
    dw Message_05_1A ; id 26
    dw Message_05_1B ; id 27
    dw Message_05_1C ; id 28
    dw Message_05_1D ; id 29
    dw Message_05_1E ; id 30
    dw Message_05_1F ; id 31
    dw Message_05_20 ; id 32
    dw Message_05_21 ; id 33
    dw Message_05_22 ; id 34
    dw Message_05_23 ; id 35
    dw Message_05_24 ; id 36
    dw Message_05_25 ; id 37
    dw Message_05_26 ; id 38
    dw Message_05_27 ; id 39
    dw Message_05_28 ; id 40
    dw Message_05_29 ; id 41
    dw Message_05_2A ; id 42
    dw Message_05_2B ; id 43
    dw Message_05_2C ; id 44
    dw Message_05_2D ; id 45
    dw Message_05_2E ; id 46
    dw Message_05_2F ; id 47
    dw Message_05_30 ; id 48
    dw Message_05_31 ; id 49
    dw Message_05_32 ; id 50
    dw Message_05_33 ; id 51
    dw Message_05_34 ; id 52
    dw Message_05_35 ; id 53
    dw Message_05_36 ; id 54
    dw Message_05_37 ; id 55
    dw Message_05_38 ; id 56
    dw Message_05_39 ; id 57
    dw Message_05_3A ; id 58
    dw Message_05_3B ; id 59
    dw Message_05_3C ; id 60
    dw Message_05_3D ; id 61
    dw Message_05_3E ; id 62
    dw Message_05_3F ; id 63
    dw Message_05_40 ; id 64
    dw Message_05_41 ; id 65
    dw Message_05_42 ; id 66
    dw Message_05_43 ; id 67
    dw Message_05_44 ; id 68
    dw Message_05_45 ; id 69
    dw Message_05_46 ; id 70
    dw Message_05_47 ; id 71
    dw Message_05_48 ; id 72
    dw Message_05_49 ; id 73
    dw Message_05_4A ; id 74
    dw Message_05_4B ; id 75
    dw Message_05_4B ; id 76
    dw Message_05_4B ; id 77
    dw Message_05_4B ; id 78
    dw Message_05_4B ; id 79
    dw Message_05_4B ; id 80
    dw Message_05_51 ; id 81
    dw Message_05_52 ; id 82
    dw Message_05_53 ; id 83
    dw Message_05_54 ; id 84
    dw Message_05_55 ; id 85
    dw Message_05_56 ; id 86
    dw Message_05_57 ; id 87
    dw Message_05_58 ; id 88
    dw Message_05_59 ; id 89
    dw Message_05_5A ; id 90
    dw Message_05_5B ; id 91
    dw Message_05_5C ; id 92
    dw Message_05_5D ; id 93
    dw Message_05_5E ; id 94
    dw Message_05_5F ; id 95
    dw Message_05_60 ; id 96
    dw Message_05_60 ; id 97
    dw Message_05_60 ; id 98
    dw Message_05_60 ; id 99
    dw Message_05_60 ; id 100
    dw Message_05_60 ; id 101
    dw Message_05_60 ; id 102
    dw Message_05_60 ; id 103
    dw Message_05_60 ; id 104
    dw Message_05_60 ; id 105
    dw Message_05_60 ; id 106
    dw Message_05_60 ; id 107
    dw Message_05_60 ; id 108
    dw Message_05_60 ; id 109
    dw Message_05_60 ; id 110
    dw Message_05_60 ; id 111
    dw Message_05_60 ; id 112
    dw Message_05_60 ; id 113
    dw Message_05_60 ; id 114
    dw Message_05_60 ; id 115
    dw Message_05_60 ; id 116
    dw Message_05_60 ; id 117
    dw Message_05_60 ; id 118
    dw Message_05_60 ; id 119
    dw Message_05_60 ; id 120
    dw Message_05_60 ; id 121
    dw Message_05_60 ; id 122
    dw Message_05_60 ; id 123
    dw Message_05_60 ; id 124
    dw Message_05_60 ; id 125
    dw Message_05_60 ; id 126
    dw Message_05_60 ; id 127
    dw Message_05_60 ; id 128
    dw Message_05_60 ; id 129
    dw Message_05_60 ; id 130
    dw Message_05_60 ; id 131
    dw Message_05_60 ; id 132
    dw Message_05_60 ; id 133
    dw Message_05_60 ; id 134
    dw Message_05_60 ; id 135
    dw Message_05_60 ; id 136
    dw Message_05_60 ; id 137
    dw Message_05_60 ; id 138
    dw Message_05_60 ; id 139
    dw Message_05_60 ; id 140
    dw Message_05_60 ; id 141
    dw Message_05_60 ; id 142
    dw Message_05_60 ; id 143
    dw Message_05_60 ; id 144
    dw Message_05_60 ; id 145
    dw Message_05_60 ; id 146
    dw Message_05_60 ; id 147
    dw Message_05_60 ; id 148
    dw Message_05_95 ; id 149
    dw Message_05_96 ; id 150
    dw Message_05_97 ; id 151
    dw Message_05_98 ; id 152
    dw Message_05_99 ; id 153
    dw Message_05_9A ; id 154
    dw Message_05_9B ; id 155
    dw Message_05_9C ; id 156
    dw Message_05_9D ; id 157
    dw Message_05_9E ; id 158
    dw Message_05_9F ; id 159
    dw Message_05_A0 ; id 160
    dw Message_05_A1 ; id 161
    dw Message_05_A2 ; id 162
    dw Message_05_A3 ; id 163
    dw Message_05_A4 ; id 164
    dw Message_05_A5 ; id 165
    dw Message_05_A6 ; id 166
    dw Message_05_A7 ; id 167
    dw Message_05_A8 ; id 168
    dw Message_05_A9 ; id 169
    dw Message_05_AA ; id 170
    dw Message_05_AB ; id 171
    dw Message_05_AC ; id 172
    dw Message_05_AD ; id 173
    dw Message_05_AE ; id 174
    dw Message_05_AF ; id 175
    dw Message_05_B0 ; id 176
    dw Message_05_B1 ; id 177
    dw Message_05_B2 ; id 178
    dw Message_05_B3 ; id 179
    dw Message_05_B4 ; id 180
    dw Message_05_B5 ; id 181
    dw Message_05_B6 ; id 182
    dw Message_05_B7 ; id 183
    dw Message_05_B8 ; id 184
    dw Message_05_B9 ; id 185
    dw Message_05_BA ; id 186
    dw Message_05_BB ; id 187
    dw Message_05_BC ; id 188
    dw Message_05_BD ; id 189
    dw Message_05_BE ; id 190
    dw Message_05_BF ; id 191
    dw Message_05_C0 ; id 192
    dw Message_05_C1 ; id 193
    dw Message_05_C2 ; id 194
    dw Message_05_C3 ; id 195
    dw Message_05_C4 ; id 196
    dw Message_05_C5 ; id 197
    dw Message_05_C6 ; id 198
    dw Message_05_C7 ; id 199
    dw Message_05_C8 ; id 200
    dw Message_05_C9 ; id 201
    dw Message_05_CA ; id 202
    dw Message_05_CB ; id 203
    dw Message_05_CC ; id 204
    dw Message_05_CD ; id 205
    dw Message_05_CE ; id 206
    dw Message_05_CF ; id 207
    dw Message_05_D0 ; id 208
    dw Message_05_D1 ; id 209
    dw Message_05_D2 ; id 210
    dw Message_05_D3 ; id 211
    dw Message_05_D4 ; id 212

Message_05_00::
    db "<VOICE2>*: <BUF0>… There<LINE>"
    db "have been frequent<PROMPT>"
    db "<NEXT>earthquakes on the"
    db "<NEXT>island.<PROMPT>"
    db "<NEXT>Is it a sign of"
    db "<NEXT>coming trouble?<PROMPT>"
    db "<NEXT>I don't want you"
    db "<NEXT>wandering off…<WAIT>"
    db "@"

Message_05_01::
    db "<VOICE1>*: People have been<LINE>"
    db "whispering that<PROMPT>"
    db "<NEXT>GreatLog will sink"
    db "<NEXT>into the sea.<PROMPT>"
    db "<NEXT>It's in times like"
    db "<NEXT>this that one has<PROMPT>"
    db "<NEXT>to be cool, calm"
    db "<NEXT>and collected.<WAIT>"
    db "@"

Message_05_02::
    db "<VOICE1>Cobi: <BUF0>, tell<LINE>"
    db "me about what<PROMPT>"
    db "<NEXT>you've been seeing"
    db "<NEXT>in other worlds.<PROMPT>"
    db "<NEXT>…A monster king"
    db "<NEXT>and a collector…<PROMPT>"
    db "<NEXT>That's a weird"
    db "<NEXT>combination.<PROMPT>"
    db "<NEXT>Over here, there've"
    db "<NEXT>been earthquakes.<PROMPT>"
    db "<NEXT>People think it's"
    db "<NEXT>a bad omen.<PROMPT>"
    db "<NEXT>Anyway, what do"
    db "<NEXT>you need today?<WAIT>"
    db "@"

Message_05_03::
    db "<VOICE2>Tara: Big brother,<LINE>"
    db "tell me about what<PROMPT>"
    db "<NEXT>you've seen in the"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>A collector king?"
    db "<NEXT>And a monster?<PROMPT>"
    db "<NEXT>Wow, that's a very"
    db "<NEXT>odd combination.<PROMPT>"
    db "<NEXT>There have been"
    db "<NEXT>earthquakes every<PROMPT>"
    db "<NEXT>day here. Everyone"
    db "<NEXT>has been saying<PROMPT>"
    db "<NEXT>GreatLog will sink"
    db "<NEXT>into the sea.<PROMPT>"
    db "<NEXT>Anyway, do you"
    db "<NEXT>need any help?<WAIT>"
    db "@"

Message_05_04::
    db "<VOICE1>*: If the island<LINE>"
    db "sink, is no worry,<PROMPT>"
    db "<NEXT>my friend! This"
    db "<NEXT>rope save you!<PROMPT>"
    db "<NEXT>It climb up and up"
    db "<NEXT>into the clouds!<PROMPT>"
    db "<NEXT>Is free to try"
    db "<NEXT>now. You try!<WAIT>"
    db "@"

Message_05_05::
    db "<VOICE1>*: People have been<LINE>"
    db "saying that they<PROMPT>"
    db "<NEXT>may be able to"
    db "<NEXT>survive at the top<PROMPT>"
    db "<NEXT>of the tree if the"
    db "<NEXT>island sinks.<WAIT>"
    db "@"

Message_05_06::
    db "<VOICE1>*: Hey! You're the<LINE>"
    db "kid who said the<PROMPT>"
    db "<NEXT>island was going"
    db "<NEXT>to sink!<PROMPT>"
    db "<NEXT>There've been many"
    db "<NEXT>earthquakes…<PROMPT>"
    db "<NEXT>Were you telling"
    db "<NEXT>the truth?<PROMPT>"
    db "<NEXT>No, it can't be…"
    db "<NEXT>But then again…<WAIT>"
    db "@"

Message_05_07::
    db "<VOICE2>*: Prince Kameha<LINE>"
    db "came back!<PROMPT>"
    db "<NEXT>What with the"
    db "<NEXT>earthquakes and<PROMPT>"
    db "<NEXT>all, bad luck does"
    db "<NEXT>come in bunches…<WAIT>"
    db "@"

Message_05_08::
    db "<VOICE2>*: Hi! Have you<LINE>"
    db "heard?<PROMPT>"
    db "<NEXT>GreatLog is going"
    db "<NEXT>to sink!<PROMPT>"
    db "<NEXT>I'll have to buy"
    db "<NEXT>supplies and get<PROMPT>"
    db "<NEXT>ready for the"
    db "<NEXT>disaster!<WAIT>"
    db "@"

Message_05_09::
    db "<VOICE2>*: My neighbor is<LINE>"
    db "buying all sorts<PROMPT>"
    db "<NEXT>of things in a"
    db "<NEXT>panic, but…<PROMPT>"
    db "<NEXT>What good will"
    db "<NEXT>clothes or monster<PROMPT>"
    db "<NEXT>accessories do her"
    db "<NEXT>now?<WAIT>"
    db "@"

Message_05_0A::
    db "<VOICE1>*: When things are<LINE>"
    db "tough, you can't<PROMPT>"
    db "<NEXT>afford to panic."
    db "<NEXT>Try to stay calm.<WAIT>"
    db "@"

Message_05_0B::
    db "<VOICE1>*: You, <BUF0>,<LINE>"
    db "come with me!<PROMPT>"
    db "<NEXT>Prince Kameha", $44
    db "<NEXT>finally returned<PROMPT>"
    db "<NEXT>from who knows"
    db "<NEXT>where.<PROMPT>"
    db "<NEXT>It turns out that"
    db "<NEXT>you dragged him<PROMPT>"
    db "<NEXT>back from another"
    db "<NEXT>world.<PROMPT>"
    db "<NEXT>His Majesty wishes"
    db "<NEXT>to see you.<PROMPT>"
    db "<NEXT>Come with me to"
    db "<NEXT>the Castle!<WAIT>"
    db "@"

Message_05_0C::
    db "<VOICE1>*: My beloved<LINE>"
    db "island is sinking…<PROMPT>"
    db "<NEXT>But I can't do a"
    db "<NEXT>thing but watch…<WAIT>"
    db "@"

Message_05_0D::
    db "<VOICE1>King: Ah, thanks<LINE>"
    db "for coming!<PROMPT>"
    db "<NEXT>I've heard from"
    db "<NEXT>Kameha, it was<PROMPT>"
    db "<NEXT>you who brought"
    db "<NEXT>him back.<PROMPT>"
    db "<NEXT>It's no wonder why"
    db "<NEXT>he couldn't be<PROMPT>"
    db "<NEXT>found anywhere on"
    db "<NEXT>the island.<PROMPT>"
    db "<NEXT>I'm glad that he"
    db "<NEXT>was found.<PROMPT>"
    db "<NEXT>Take the contents"
    db "<NEXT>of the chests in<PROMPT>"
    db "<NEXT>my chamber as my"
    db "<NEXT>thanks.<PROMPT>"
    db "<NEXT>I hope you will"
    db "<NEXT>remain a friend to<PROMPT>"
    db "<NEXT>Kameha. He can be"
    db "<NEXT>mischievous, and<PROMPT>"
    db "<NEXT>get into trouble,"
    db "<NEXT>but I hope you<PROMPT>"
    db "<NEXT>will stand by him"
    db "<NEXT>as a friend.<WAIT>"
    db "@"

Message_05_0E::
    db "<VOICE1>King: Kameha came<LINE>"
    db "back safely from<PROMPT>"
    db "<NEXT>another world."
    db "<NEXT>I owe it all to<PROMPT>"
    db "<NEXT>you, so I must"
    db "<NEXT>thank you somehow.<PROMPT>"
    db "<NEXT>You may take the"
    db "<NEXT>contents of the<PROMPT>"
    db "<NEXT>treasure chests in"
    db "<NEXT>my chamber.<PROMPT>"
    db "<NEXT>I hope you will"
    db "<NEXT>remain a friend to<PROMPT>"
    db "<NEXT>Kameha. He has few"
    db "<NEXT>friends his age.<PROMPT>"
    db "<NEXT>I'm sure that he"
    db "<NEXT>is lonely.<WAIT>"
    db "@"

Message_05_0F::
    db "<VOICE1>King: There have<LINE>"
    db "been many quakes.<PROMPT>"
    db "<NEXT>I hope nothing"
    db "<NEXT>will come of them.<PROMPT>"
    db "<NEXT>Our people can't"
    db "<NEXT>live in security<PROMPT>"
    db "<NEXT>with that weighing"
    db "<NEXT>on their minds.<WAIT>"
    db "@"

Message_05_10::
    db "<VOICE1>*: The frequent<LINE>"
    db "quakes have raised<PROMPT>"
    db "<NEXT>grave concerns"
    db "<NEXT>among the people.<PROMPT>"
    db "<NEXT>Our investigations"
    db "<NEXT>have so far failed<PROMPT>"
    db "<NEXT>to identify what"
    db "<NEXT>is causing them.<WAIT>"
    db "@"

Message_05_11::
    db "<VOICE1>*: Beyond here is<LINE>"
    db "his Majesty and<PROMPT>"
    db "<NEXT>Prince Kameha's"
    db "<NEXT>chamber.<PROMPT>"
    db "<NEXT>I've received word"
    db "<NEXT>to let you pass.<WAIT>"
    db "@"

Message_05_12::
    db "<VOICE1>Kameha: Yo, <BUF0>.<LINE>"
    db "Thanks for coming.<PROMPT>"
    db "<NEXT>Pop's got his eye"
    db "<NEXT>on me, so I<PROMPT>"
    db "<NEXT>can't get out of"
    db "<NEXT>here now, but I'll<PROMPT>"
    db "<NEXT>get out to other"
    db "<NEXT>worlds again!<PROMPT>"
    db "<NEXT>That's a promise."
    db "<NEXT>You just wait!<WAIT>"
    db "@"

Message_05_13::
    db "<VOICE1>*: I'm a scientist.<LINE>"
    db "I've been studying<PROMPT>"
    db "<NEXT>the results of"
    db "<NEXT>breeding monsters.<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>try breeding a<PROMPT>"
    db "<NEXT>monster with my"
    db "<NEXT>Gulpple?<CHOICE>"
    db "@"

Message_05_14::
    db "<VOICE1>*: Well, let's see<LINE>"
    db "about breeding!<WAIT>"
    db "@"

Message_05_15::
    db "<VOICE1>*: Oh… Perhaps on<LINE>"
    db "another occasion.<WAIT>"
    db "@"

Message_05_16::
    db "<VOICE1>*: Hm… So that<LINE>"
    db "combination of<PROMPT>"
    db "<NEXT>parents results in"
    db "<NEXT>this species…<PROMPT>"
    db "<NEXT>I", $44, " better get home"
    db "<NEXT>quickly and make a<PROMPT>"
    db "<NEXT>record of this"
    db "<NEXT>finding.<WAIT>"
    db "@"

Message_05_17::
    db "<VOICE1>*: GreatLog is<LINE>"
    db "sinking I heard,<PROMPT>"
    db "<NEXT>but I don't want"
    db "<NEXT>to leave here.<PROMPT>"
    db "<NEXT>So I came up here"
    db "<NEXT>for now.<WAIT>"
    db "@"

Message_05_18::
    db "<VOICE1>*: I've never once<LINE>"
    db "left the island.<PROMPT>"
    db "<NEXT>I can't imagine"
    db "<NEXT>living elsewhere.<WAIT>"
    db "@"

Message_05_19::
    db "<VOICE2>*: This is a time<LINE>"
    db "we need Warubou's<PROMPT>"
    db "<NEXT>help the most."
    db "<NEXT>But I've heard it's<PROMPT>"
    db "<NEXT>stuck itself in a"
    db "<NEXT>hole and is<PROMPT>"
    db "<NEXT>playing.<WAIT>"
    db "@"

Message_05_1A::
    db "<VOICE2>*: I didn't want to<LINE>"
    db "believe GreatLog<PROMPT>"
    db "<NEXT>is sinking, but"
    db "<NEXT>seeing the changes<PROMPT>"
    db "<NEXT>that have been"
    db "<NEXT>taking place…<PROMPT>"
    db "<NEXT>I have no choice"
    db "<NEXT>but to believe.<WAIT>"
    db "@"

Message_05_1B::
    db "<VOICE1>*: I won't believe<LINE>"
    db "that GreatLog is<PROMPT>"
    db "<NEXT>sinking. That just"
    db "<NEXT>can't happen!<PROMPT>"
    db "<NEXT>It has to be one"
    db "<NEXT>of Warubou's usual<PROMPT>"
    db "<NEXT>pranks."
    db "<NEXT>I'm convinced.<WAIT>"
    db "@"

Message_05_1C::
    db "<VOICE1>*: The King said<LINE>"
    db "that GreatLog will<PROMPT>"
    db "<NEXT>not sink, but if"
    db "<NEXT>not, what's causing<PROMPT>"
    db "<NEXT>all the changes on"
    db "<NEXT>the island?<WAIT>"
    db "@"

Message_05_1D::
    db "<VOICE1>*: Everyone, please<LINE>"
    db "remain calm.<PROMPT>"
    db "<NEXT>Even if GreatLog"
    db "<NEXT>were to sink, we<PROMPT>"
    db "<NEXT>have enough ships"
    db "<NEXT>to evacuate the<PROMPT>"
    db "<NEXT>entire population"
    db "<NEXT>easily.<WAIT>"
    db "@"

Message_05_1E::
    db "<VOICE2>*: The GreatLog<LINE>"
    db "tree appeared to<PROMPT>"
    db "<NEXT>be healthy… Could"
    db "<NEXT>it be at the end<PROMPT>"
    db "<NEXT>of its natural"
    db "<NEXT>lifespan?<WAIT>"
    db "@"

Message_05_1F::
    db "<VOICE1>*: Right now, we<LINE>"
    db "are investigating<PROMPT>"
    db "<NEXT>what is causing"
    db "<NEXT>the earthquakes.<PROMPT>"
    db "<NEXT>Please don't panic,"
    db "<NEXT>and stay home.<WAIT>"
    db "@"

Message_05_20::
    db "<VOICE1>*: I've studied<LINE>"
    db "GreatLog over a<PROMPT>"
    db "<NEXT>long time."
    db "<NEXT>I've never seen<PROMPT>"
    db "<NEXT>changes this"
    db "<NEXT>profound, however.<WAIT>"
    db "@"

Message_05_21::
    db "<VOICE1>*: The Arena is<LINE>"
    db "closed under the<PROMPT>"
    db "<NEXT>King's decree."
    db "<NEXT>The whole island<PROMPT>"
    db "<NEXT>is too jumpy over"
    db "<NEXT>the earthquakes.<WAIT>"
    db "@"

Message_05_22::
    db "<VOICE1>*: It's been decided<LINE>"
    db "to shut down the<PROMPT>"
    db "<NEXT>Arena for a"
    db "<NEXT>while.<PROMPT>"
    db "<NEXT>The rumors about"
    db "<NEXT>the island sinking<PROMPT>"
    db "<NEXT>kept people away"
    db "<NEXT>anyway.<WAIT>"
    db "@"

Message_05_23::
    db "<VOICE1>*: Don't be fooled<LINE>"
    db "by those rumors<PROMPT>"
    db "<NEXT>about GreatLog"
    db "<NEXT>sinking.<PROMPT>"
    db "<NEXT>We must be most"
    db "<NEXT>vigilant against<PROMPT>"
    db "<NEXT>the horrifying"
    db "<NEXT>prospect of panic.<WAIT>"
    db "@"

Message_05_24::
    db "<VOICE2>*: He can talk<LINE>"
    db "tough now, but…<PROMPT>"
    db "<NEXT>What will we do if"
    db "<NEXT>GreatLog sinks?<WAIT>"
    db "@"

Message_05_25::
    db "<VOICE2>*: Everyone's saying<LINE>"
    db "GreatLog'll sink!<WAIT>"
    db "@"

Message_05_26::
    db "<VOICE1>*: If GreatLog were<LINE>"
    db "to sink, we will<PROMPT>"
    db "<NEXT>keep its memory"
    db "<NEXT>alive forever.<WAIT>"
    db "@"

Message_05_27::
    db "<VOICE1>*: I'm an adult so I<LINE>"
    db "can live anywhere.<PROMPT>"
    db "<NEXT>But I feel bad for"
    db "<NEXT>my granddaughter<PROMPT>"
    db "<NEXT>who'll have to"
    db "<NEXT>leave her friends.<WAIT>"
    db "@"

Message_05_28::
    db "<VOICE2>*: I don't want to<LINE>"
    db "leave GreatLog!<PROMPT>"
    db "<NEXT>I'm not leaving my"
    db "<NEXT>friends behind!<PROMPT>"
    db "<NEXT>If I can't take"
    db "<NEXT>Butch, I'm staying!<WAIT>"
    db "@"

Message_05_29::
    db "<VOICE1>*: Grandpa and the<LINE>"
    db "others are going<PROMPT>"
    db "<NEXT>to evacuate from"
    db "<NEXT>GreatLog…<PROMPT>"
    db "<NEXT>But there are too"
    db "<NEXT>many people…<PROMPT>"
    db "<NEXT>They have no room"
    db "<NEXT>to take me…<WAIT>"
    db "@"

Message_05_2A::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Are you ready?<PROMPT>"
    db "<NEXT>Ready for Limbo?"
    db "<NEXT>Warooh!<CHOICE>"
    db "@"

Message_05_2B::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Take the treasures<PROMPT>"
    db "<NEXT>that didn't work"
    db "<NEXT>as the plug.<PROMPT>"
    db "<NEXT>Heheh, I repaired"
    db "<NEXT>them and hung onto<PROMPT>"
    db "<NEXT>them, warooh!"
    db "<NEXT>Take them now!<WAIT>"
    db "@"

Message_05_2C::
    db "<BUF0> received the<LINE>"
    db "TidalBell.<WAIT>"
    db "@"

Message_05_2D::
    db "<BUF0> received the<LINE>"
    db "HarMirror.<WAIT>"
    db "@"

Message_05_2E::
    db "<BUF0> received the<LINE>"
    db "SkyShield.<WAIT>"
    db "@"

Message_05_2F::
    db "<VOICE1>Warubou: Limbo is<LINE>"
    db "the King's domain!<PROMPT>"
    db "<NEXT>You be careful,"
    db "<NEXT>warooh!<WAIT>"
    db "@"

Message_05_30::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Take the treasures<PROMPT>"
    db "<NEXT>that didn't work"
    db "<NEXT>as the plug.<PROMPT>"
    db "<NEXT>…Oh? You don't have"
    db "<NEXT>enough room.<WAIT>"
    db "@"

Message_05_31::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "well, hurry it up!<PROMPT>"
    db "<NEXT>When you're ready,"
    db "<NEXT>I'll give you the<PROMPT>"
    db "<NEXT>three treasures"
    db "<NEXT>then, warooh!<WAIT>"
    db "@"

Message_05_32::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "you have to find<PROMPT>"
    db "<NEXT>a plug this time"
    db "<NEXT>for sure, warooh!<PROMPT>"
    db "<NEXT>GreatLog has no"
    db "<NEXT>life force left…<WAIT>"
    db "@"

Message_05_33::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "you did it, <BUF0>!<PROMPT>"
    db "<NEXT>I'll share some of"
    db "<NEXT>GreatLog's energy.<WAIT>"
    db "@"

Message_05_34::
    db "<VOICE1>Warubou: There!<LINE>"
    db "All healthy now!<PROMPT>"
    db "<NEXT>Let me see,"
    db "<NEXT>warooh!<WAIT>"
    db "@"

Message_05_35::
    db "<VOICE1>Warubou: So this<LINE>"
    db "is the MagicPlug…<PROMPT>"
    db "<NEXT>Wa-hey, <BUF0>,"
    db "<NEXT>I believed in you!<PROMPT>"
    db "<NEXT>Let's see if it"
    db "<NEXT>will work, warooh!<WAIT>"
    db "@"

Message_05_36::
    db "<VOICE1>Warubou: There!<LINE>"
    db "It's a perfect fit!<PROMPT>"
    db "<NEXT>You finally did"
    db "<NEXT>it, <BUF0>, warooh!<WAIT>"
    db "@"

Message_05_37::
    db "<VOICE1>Warubou:<LINE>"
    db "Wa-wa-hey! We were<PROMPT>"
    db "<NEXT>too late! The"
    db "<NEXT>Navel's closed, but<PROMPT>"
    db "<NEXT>not enough life"
    db "<NEXT>force was left to<PROMPT>"
    db "<NEXT>support the"
    db "<NEXT>island!<WAIT>"
    db "@"

Message_05_38::
    db "<VOICE1>Warubou: Wa-hey…<LINE>"
    db "That's it, then.<PROMPT>"
    db "<NEXT>There's nothing we"
    db "<NEXT>can do now,<PROMPT>"
    db "<NEXT>warooh… You did"
    db "<NEXT>well, but maybe<PROMPT>"
    db "<NEXT>this is fate."
    db "<NEXT>Tell everyone to<PROMPT>"
    db "<NEXT>leave the island."
    db "<NEXT>I'll try to buy a<PROMPT>"
    db "<NEXT>little more time…"
    db "<NEXT>This is goodbye.<PROMPT>"
    db "<NEXT>Take care, <BUF0>."
    db "<NEXT><WAIT>"
    db "@"

Message_05_39::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Get going!<WAIT>"
    db "@"

Message_05_3A::
    db "<VOICE1>Warubou: Wa-hey?<LINE>"
    db "GreatLog's life<PROMPT>"
    db "<NEXT>force is coming"
    db "<NEXT>back! And with<PROMPT>"
    db "<NEXT>such fervor! The"
    db "<NEXT>Navel is sealed!<WAIT>"
    db "@"

Message_05_3B::
    db "<VOICE1>King: I thank you<LINE>"
    db "all for coming!<PROMPT>"
    db "<NEXT>Let me introduce"
    db "<NEXT>you to the hero,<PROMPT>"
    db "<NEXT><BUF0>, the savior"
    db "<NEXT>of GreatLog!<WAIT>"
    db "@"

Message_05_3C::
    db "<VOICE1>King: Even though<LINE>"
    db "the island's crisis<PROMPT>"
    db "<NEXT>was caused by"
    db "<NEXT>Kameha, I'm unhappy<PROMPT>"
    db "<NEXT>that no one paid"
    db "<NEXT>any heed to your<PROMPT>"
    db "<NEXT>dire warnings."
    db "<NEXT>Quite shameful.<PROMPT>"
    db "<NEXT>But your actions"
    db "<NEXT>moved the hearts<PROMPT>"
    db "<NEXT>and souls of all"
    db "<NEXT>of us.<PROMPT>"
    db "<NEXT><BUF0>, words could"
    db "<NEXT>never express our<PROMPT>"
    db "<NEXT>feelings of thanks"
    db "<NEXT>to you!<PROMPT>"
    db "<NEXT>Come, let us all"
    db "<NEXT>celebrate!<WAIT>"
    db "@"

Message_05_3D::
    db "<VOICE1>King: GreatLog's<LINE>"
    db "crisis has passed.<PROMPT>"
    db "<NEXT>We have nothing to"
    db "<NEXT>fear now!<PROMPT>"
    db "<NEXT>The Log's Navel"
    db "<NEXT>has been plugged!<WAIT>"
    db "@"

Message_05_3E::
    db "<VOICE1>Kameha: I couldn't<LINE>"
    db "do anything, so<PROMPT>"
    db "<NEXT>you win, but just"
    db "<NEXT>this time.<PROMPT>"
    db "<NEXT>But I'll take you"
    db "<NEXT>on as a master<PROMPT>"
    db "<NEXT>next time. You be"
    db "<NEXT>ready for me!<WAIT>"
    db "@"

Message_05_3F::
    db "<VOICE1>*: I don't think I<LINE>"
    db "was anywhere near<PROMPT>"
    db "<NEXT>as resourceful"
    db "<NEXT>when I was a kid…<WAIT>"
    db "@"

Message_05_40::
    db "<VOICE2>*: Oh, wow! You're<LINE>"
    db "really famous!<WAIT>"
    db "@"

Message_05_41::
    db "<VOICE1>*: I hate myself<LINE>"
    db "for not doing<PROMPT>"
    db "<NEXT>anything to help"
    db "<NEXT>during the crisis.<WAIT>"
    db "@"

Message_05_42::
    db "<VOICE2>*: I'm sorry for<LINE>"
    db "doubting you.<PROMPT>"
    db "<NEXT>I'll believe you"
    db "<NEXT>next time!<PROMPT>"
    db "<NEXT>But, I hope there"
    db "<NEXT>isn't a next time!<WAIT>"
    db "@"

Message_05_43::
    db "<VOICE1>*: I", $44, " like my<LINE>"
    db "grandchildren to<PROMPT>"
    db "<NEXT>learn something"
    db "<NEXT>from you!<WAIT>"
    db "@"

Message_05_44::
    db "<VOICE1>*: ……I can't eat<LINE>"
    db "another… Zzz…<WAIT>"
    db "@"

Message_05_45::
    db "<VOICE1>*: You're today's<LINE>"
    db "guest of honor!<PROMPT>"
    db "<NEXT>You can't be"
    db "<NEXT>wandering here!<WAIT>"
    db "@"

Message_05_46::
    db "<VOICE1>Cobi: <BUF0>,<LINE>"
    db "congratulations!<PROMPT>"
    db "<NEXT>I thought we were"
    db "<NEXT>in deep trouble<PROMPT>"
    db "<NEXT>when the first"
    db "<NEXT>Navel plug broke…<PROMPT>"
    db "<NEXT>But you saved the"
    db "<NEXT>island by teaming<PROMPT>"
    db "<NEXT>up with monsters!"
    db "<NEXT>Good going!<PROMPT>"
    db "<NEXT>Wait… Why are you"
    db "<NEXT>so glum?<PROMPT>"
    db "<NEXT>Oh, I know, you've"
    db "<NEXT>gotten to like<PROMPT>"
    db "<NEXT>traveling to other"
    db "<NEXT>worlds and meeting<PROMPT>"
    db "<NEXT>people with your"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>You're going to"
    db "<NEXT>miss it, right?<WAIT>"
    db "@"

Message_05_47::
    db "<VOICE1>*: Hehehe, no need<LINE>"
    db "to worry there!<WAIT>"
    db "@"

Message_05_48::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Instead of a quest<PROMPT>"
    db "<NEXT>for a replacement"
    db "<NEXT>plug, you can go<PROMPT>"
    db "<NEXT>on a journey for"
    db "<NEXT>yourself, warooh!<WAIT>"
    db "@"

Message_05_49::
    db "<VOICE1>Warubou: No one<LINE>"
    db "knows how many<PROMPT>"
    db "<NEXT>other worlds exist"
    db "<NEXT>out there.<PROMPT>"
    db "<NEXT>You'll never ever"
    db "<NEXT>run out of other<PROMPT>"
    db "<NEXT>worlds to explore,"
    db "<NEXT>warooh!<WAIT>"
    db "@"

Message_05_4A::
    db "<VOICE2>Tara: <BUF0>,<LINE>"
    db "congratulations!<PROMPT>"
    db "<NEXT>I was sad that no"
    db "<NEXT>one would believe<PROMPT>"
    db "<NEXT>us, but you saved"
    db "<NEXT>GreatLog with your<PROMPT>"
    db "<NEXT>monster friends."
    db "<NEXT>That's great!<PROMPT>"
    db "<NEXT>Oh? You look sort"
    db "<NEXT>of sad, somehow.<PROMPT>"
    db "<NEXT>Oh, wait, you've"
    db "<NEXT>gotten to enjoy<PROMPT>"
    db "<NEXT>going to other"
    db "<NEXT>worlds and meeting<PROMPT>"
    db "<NEXT>people with your"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>You must be sad"
    db "<NEXT>that it's over.<WAIT>"
    db "@"

Message_05_4B::
    db "<VOICE1>*: I", $44, " heard from<LINE>"
    db "Lord Darck, but it<PROMPT>"
    db "<NEXT>really was you…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Did you bring the"
    db "<NEXT>treasures?<CHOICE>"
    db "@"

Message_05_51::
    db "<VOICE1>*: Surprisingly<LINE>"
    db "obedient, are you?<PROMPT>"
    db "<NEXT>Hand over the"
    db "<NEXT>treasures!<WAIT>"
    db "@"

Message_05_52::
    db "<BUF0> handed over<LINE>"
    db "the TidalBell.<PROMPT>"
    db "<NEXT><BUF0> handed over"
    db "<NEXT>the HarMirror.<PROMPT>"
    db "<NEXT><BUF0> handed over"
    db "<NEXT>the SkyShield.<WAIT>"
    db "@"

Message_05_53::
    db "<VOICE1>*: Take these to<LINE>"
    db "Lord Darck now.<WAIT>"
    db "@"

Message_05_54::
    db "<VOICE1>*: My work is done…<LINE>"
    db "I am now free to<PROMPT>"
    db "<NEXT>fight you without"
    db "<NEXT>restraint!<WAIT>"
    db "@"

Message_05_55::
    db "<VOICE1>*: You seem to<LINE>"
    db "still not realize<PROMPT>"
    db "<NEXT>how puny and weak"
    db "<NEXT>you are.<PROMPT>"
    db "<NEXT>Well, I will"
    db "<NEXT>shatter your<PROMPT>"
    db "<NEXT>misplaced courage"
    db "<NEXT>once and for all!<WAIT>"
    db "@"

Message_05_56::
    db "<VOICE1>*: N… No… How could<LINE>"
    db "my monsters lose…<PROMPT>"
    db "<NEXT>I did just as Lord"
    db "<NEXT>Darck bade me…<PROMPT>"
    db "<NEXT>And obtained the"
    db "<NEXT>treasures of the<PROMPT>"
    db "<NEXT>other worlds…"
    db "<NEXT>I did…<PROMPT>"
    db "<NEXT>In return, he was"
    db "<NEXT>supposed to give<PROMPT>"
    db "<NEXT>me the strongest"
    db "<NEXT>monsters… Why…<PROMPT>"
    db "<NEXT>Why can't I beat"
    db "<NEXT>your monsters?<WAIT>"
    db "@"

Message_05_57::
    db "<VOICE1>Darck: Fawahahah!<LINE>"
    db "You chased your<PROMPT>"
    db "<NEXT>treasures here,"
    db "<NEXT>did you?<PROMPT>"
    db "<NEXT>Fantastic! You're"
    db "<NEXT>a true collector!<PROMPT>"
    db "<NEXT>You see, I believe"
    db "<NEXT>that there are two<PROMPT>"
    db "<NEXT>varieties of"
    db "<NEXT>collectors.<PROMPT>"
    db "<NEXT>There are those"
    db "<NEXT>who collect things<PROMPT>"
    db "<NEXT>of value only to"
    db "<NEXT>themselves.<PROMPT>"
    db "<NEXT>And then there are"
    db "<NEXT>collectors of what<PROMPT>"
    db "<NEXT>evokes desire and"
    db "<NEXT>envy in others.<PROMPT>"
    db "<NEXT>Even though the"
    db "<NEXT>act of collecting<PROMPT>"
    db "<NEXT>is the same, the"
    db "<NEXT>motivation is<PROMPT>"
    db "<NEXT>entirely different"
    db "<NEXT>for the two types.<PROMPT>"
    db "<NEXT>The vanity and the"
    db "<NEXT>greed that lurk<PROMPT>"
    db "<NEXT>deep in hearts,"
    db "<NEXT>when they are<PROMPT>"
    db "<NEXT>unleashed, they"
    db "<NEXT>give me power.<PROMPT>"
    db "<NEXT>If you defeat me,"
    db "<NEXT>the MagicPlug<PROMPT>"
    db "<NEXT>shall be yours."
    db "<NEXT>But, you won't.<PROMPT>"
    db "<NEXT>For this is where"
    db "<NEXT>you die.<PROMPT>"
    db "<NEXT>Your despair, your"
    db "<NEXT>anger, they will<PROMPT>"
    db "<NEXT>all make me even"
    db "<NEXT>more powerful.<PROMPT>"
    db "<NEXT>Fwahahahahahah!"
    db "<NEXT><WAIT>"
    db "@"

Message_05_58::
    db "<VOICE1>Darck: Fwahahahah!<LINE>"
    db "Bravo! Splendid!<PROMPT>"
    db "<NEXT>You've come back"
    db "<NEXT>again for me!<PROMPT>"
    db "<NEXT>You are a great"
    db "<NEXT>collector!<PROMPT>"
    db "<NEXT>Defeat me and the"
    db "<NEXT>treasure is yours!<PROMPT>"
    db "<NEXT>Come at me with"
    db "<NEXT>everything!<WAIT>"
    db "@"

Message_05_59::
    db "<VOICE1>Darck: …Wha… What?<LINE>"
    db "How could I…<PROMPT>"
    db "<NEXT>I see… It was I"
    db "<NEXT>who was mistaken…<PROMPT>"
    db "<NEXT>You collected not"
    db "<NEXT>out of vanity or<PROMPT>"
    db "<NEXT>greed. No, it was"
    db "<NEXT>something else…<PROMPT>"
    db "<NEXT>It was a different"
    db "<NEXT>motive altogether…<PROMPT>"
    db "<NEXT>One that I could"
    db "<NEXT>not understand…<PROMPT>"
    db "<NEXT>And one that did"
    db "<NEXT>not give me power…<PROMPT>"
    db "<NEXT>You are the worst"
    db "<NEXT>kind of collector…<PROMPT>"
    db "<NEXT>But you've managed"
    db "<NEXT>to collect the<PROMPT>"
    db "<NEXT>best partners for"
    db "<NEXT>yourself…<PROMPT>"
    db "<NEXT>Urrgh… You win…"
    db "<NEXT>Open that chest…<WAIT>"
    db "@"

Message_05_5A::
    db "A voice echoed<LINE>"
    db "from nowhere…<WAIT>"
    db "@"

Message_05_5B::
    db "<VOICE1>*: Wa-hey! can you<LINE>"
    db "hear me, <BUF0>?<PROMPT>"
    db "<NEXT>You found a plug"
    db "<NEXT>for the Navel!<PROMPT>"
    db "<NEXT>I'll bring you"
    db "<NEXT>back to GreatLog!<PROMPT>"
    db "<NEXT>Stand still,"
    db "<NEXT>warooh!<WAIT>"
    db "@"

Message_05_5C::
    db "<VOICE1>*: How dare you<LINE>"
    db "come without the<PROMPT>"
    db "<NEXT>treasures… You"
    db "<NEXT>have some nerve!<PROMPT>"
    db "<NEXT>You're not getting"
    db "<NEXT>past me without<PROMPT>"
    db "<NEXT>showing me the"
    db "<NEXT>treasures.<WAIT>"
    db "@"

Message_05_5D::
    db "<VOICE1>*: You didn't bring<LINE>"
    db "the treasures?<PROMPT>"
    db "<NEXT>Well, hurry up and"
    db "<NEXT>bring them!<PROMPT>"
    db "<NEXT>You have only a"
    db "<NEXT>little time left!<WAIT>"
    db "@"

Message_05_5E::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Magic Keys…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>The last keys lead"
    db "<NEXT>to worlds that are<PROMPT>"
    db "<NEXT>inhabited by rare"
    db "<NEXT>monsters.", $95, "<WAIT>"
    db "@"

Message_05_5F::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Magic Keys…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Keys that feature"
    db "<NEXT>a family name,<PROMPT>"
    db "<NEXT>like FirstSlime"
    db "<NEXT>Key, go to a world<PROMPT>"
    db "<NEXT>that is inhabited"
    db "<NEXT>by that family.", $95, "<WAIT>"
    db "@"

Message_05_60::
    db "<VOICE1>*: Awooh! I'm hot!<LINE>"
    db "Let's go already!<WAIT>"
    db "@"

Message_05_95::
    db "<VOICE1>*: I'm going to work<LINE>"
    db "hard and earn<PROMPT>"
    db "<NEXT>myself <BUF0>'s"
    db "<NEXT>praise.<WAIT>"
    db "@"

Message_05_96::
    db "<VOICE1>*: I'm plenty good<LINE>"
    db "enough by myself.<PROMPT>"
    db "<NEXT>There is no need"
    db "<NEXT>for others.<WAIT>"
    db "@"

Message_05_97::
    db "<VOICE1>*: <BUF0>, I will<LINE>"
    db "fight with my life<PROMPT>"
    db "<NEXT>for your honor and"
    db "<NEXT>glory.<WAIT>"
    db "@"

Message_05_98::
    db "<VOICE1>*: I'll take the<LINE>"
    db "point in battle!<PROMPT>"
    db "<NEXT>Let me take charge"
    db "<NEXT>of the situation!<WAIT>"
    db "@"

Message_05_99::
    db "<VOICE1>*: I", $44, " like to see<LINE>"
    db "how well you can<PROMPT>"
    db "<NEXT>command us in"
    db "<NEXT>battle.<WAIT>"
    db "@"

Message_05_9A::
    db "<VOICE1>*: <BUF0>, how about<LINE>"
    db "you battle next?<WAIT>"
    db "@"

Message_05_9B::
    db "<VOICE1>*: I don't need any<LINE>"
    db "backup.<PROMPT>"
    db "<NEXT>I'll just muscle"
    db "<NEXT>through!<WAIT>"
    db "@"

Message_05_9C::
    db "<VOICE1>*: No need for<LINE>"
    db "defense!<PROMPT>"
    db "<NEXT>Offense is what's"
    db "<NEXT>important.<WAIT>"
    db "@"

Message_05_9D::
    db "<VOICE1>*: Watch what your<LINE>"
    db "opponent has…<PROMPT>"
    db "<NEXT>Running away is a"
    db "<NEXT>viable option…<WAIT>"
    db "@"

Message_05_9E::
    db "<VOICE1>*: If I don't get<LINE>"
    db "an order, I won't<PROMPT>"
    db "<NEXT>even bother to do"
    db "<NEXT>any eating!<WAIT>"
    db "@"

Message_05_9F::
    db "<VOICE1>*: Make sure you<LINE>"
    db "heal me first if<PROMPT>"
    db "<NEXT>I'm hurt."
    db "<NEXT>Don't forget that!<WAIT>"
    db "@"

Message_05_A0::
    db "<VOICE1>*: I", $44, " rather be<LINE>"
    db "tending flowers<PROMPT>"
    db "<NEXT>than going out"
    db "<NEXT>into battle…<WAIT>"
    db "@"

Message_05_A1::
    db "<VOICE1>*: I'm going to get<LINE>"
    db "strong and impress<PROMPT>"
    db "<NEXT><BUF0>. Yes, I"
    db "<NEXT>will!<WAIT>"
    db "@"

Message_05_A2::
    db "<VOICE1>*: It's OK… I really<LINE>"
    db "didn't want any<PROMPT>"
    db "<NEXT>meat anyway,"
    db "<NEXT>humph!<WAIT>"
    db "@"

Message_05_A3::
    db "<VOICE1>*: Do you have your<LINE>"
    db "hankie and tissue?<PROMPT>"
    db "<NEXT>Oh, your buttons"
    db "<NEXT>are crooked.<WAIT>"
    db "@"

Message_05_A4::
    db "<VOICE1>*: I'll do as I see<LINE>"
    db "fit, thank you.<PROMPT>"
    db "<NEXT>I don't need you to"
    db "<NEXT>order me around.<WAIT>"
    db "@"

Message_05_A5::
    db "<VOICE1>*: Give me meat!<LINE>"
    db "Or I won't obey!<WAIT>"
    db "@"

Message_05_A6::
    db "<VOICE1>*: In general, I am<LINE>"
    db "of the opinion<PROMPT>"
    db "<NEXT>that fighting is"
    db "<NEXT>meaningless.<WAIT>"
    db "@"

Message_05_A7::
    db "<VOICE1>*: If worse comes<LINE>"
    db "to worst, I'll use<PROMPT>"
    db "<NEXT>a mate as a shield"
    db "<NEXT>to survive.<WAIT>"
    db "@"

Message_05_A8::
    db "<VOICE1>*: There isn't any<LINE>"
    db "point begging for<PROMPT>"
    db "<NEXT>mercy. I have no"
    db "<NEXT>pity for losers.<WAIT>"
    db "@"

Message_05_A9::
    db "<VOICE1>*: Um… Uh… Er…<LINE>"
    db "It's nothing…<WAIT>"
    db "@"

Message_05_AA::
    db "<VOICE1>*: Fighting isn't<LINE>"
    db "my idea of fun…<WAIT>"
    db "@"

Message_05_AB::
    db "<VOICE1>*: Awah!<LINE>"
    db "You startled me!<PROMPT>"
    db "<NEXT>Please don't sneak"
    db "<NEXT>up on me.<WAIT>"
    db "@"

Message_05_AC::
    db "<VOICE1>*: Please don't kill<LINE>"
    db "even enemies.<WAIT>"
    db "@"

Message_05_AD::
    db "<VOICE1>*: Yay! Woohoo!<LINE>"
    db "We're going out!<WAIT>"
    db "@"

Message_05_AE::
    db "<VOICE1>*: Aww… Must we go?<LINE>"
    db "That's like work!<WAIT>"
    db "@"

Message_05_AF::
    db "<VOICE1>*: OK! Come on!<LINE>"
    db "<BUF0> too, hustle!<WAIT>"
    db "@"

Message_05_B0::
    db "<VOICE1>*: Every day, we<LINE>"
    db "must strive to<PROMPT>"
    db "<NEXT>better ourselves!"
    db "<NEXT>It is relentless!<WAIT>"
    db "@"

Message_05_B1::
    db "<VOICE1>*: As long as I'm<LINE>"
    db "around, you'll have<PROMPT>"
    db "<NEXT>nothing to fear"
    db "<NEXT>from any monster!<WAIT>"
    db "@"

Message_05_B2::
    db "<VOICE1>*: Together, we<LINE>"
    db "shall form the<PROMPT>"
    db "<NEXT>world's greatest"
    db "<NEXT>team!<WAIT>"
    db "@"

Message_05_B3::
    db "<VOICE1>*: If you dawdle,<LINE>"
    db "I'm leaving you.<WAIT>"
    db "@"

Message_05_B4::
    db "<VOICE1>*: Normally, you<LINE>"
    db "don't deserve me.<PROMPT>"
    db "<NEXT>Don't you dare"
    db "<NEXT>forget that.<WAIT>"
    db "@"

Message_05_B5::
    db "<VOICE1>*: If in the right<LINE>"
    db "mind for it, I can<PROMPT>"
    db "<NEXT>flip the world"
    db "<NEXT>over on its axis!<WAIT>"
    db "@"

Message_05_B6::
    db "<VOICE1>*: I make my own<LINE>"
    db "roads!<WAIT>"
    db "@"

Message_05_B7::
    db "<VOICE1>*: Charge, charge,<LINE>"
    db "charge!<PROMPT>"
    db "<NEXT>There's no turning"
    db "<NEXT>back, ever!<WAIT>"
    db "@"

Message_05_B8::
    db "<VOICE1>*: I'm looking<LINE>"
    db "forward to going<PROMPT>"
    db "<NEXT>on a journey with"
    db "<NEXT>you.<WAIT>"
    db "@"

Message_05_B9::
    db "<VOICE1>*: We have to stick<LINE>"
    db "to a schedule!<WAIT>"
    db "@"

Message_05_BA::
    db "<VOICE1>*: I need to do<LINE>"
    db "things at my pace.<PROMPT>"
    db "<NEXT>My rhythm gets so"
    db "<NEXT>thrown off…<WAIT>"
    db "@"

Message_05_BB::
    db "<VOICE1>*: Three meals and<LINE>"
    db "adequate sleep.<PROMPT>"
    db "<NEXT>That's all I need"
    db "<NEXT>to be satisfied.<WAIT>"
    db "@"

Message_05_BC::
    db "<VOICE1>*: This adventure<LINE>"
    db "is exciting!<PROMPT>"
    db "<NEXT>Because I get to"
    db "<NEXT>go with <BUF0>!<WAIT>"
    db "@"

Message_05_BD::
    db "<VOICE1>*: Don't pay any<LINE>"
    db "heed to me.<PROMPT>"
    db "<NEXT>I'll do whatever I"
    db "<NEXT>must for myself.<WAIT>"
    db "@"

Message_05_BE::
    db "<VOICE1>*: <BUF0>… I must<LINE>"
    db "say this…<PROMPT>"
    db "<NEXT>Your clothes are"
    db "<NEXT>out of fashion.<WAIT>"
    db "@"

Message_05_BF::
    db "<VOICE1>*: I'm not good<LINE>"
    db "with combos…<WAIT>"
    db "@"

Message_05_C0::
    db "<VOICE1>*: If I don't want<LINE>"
    db "to do something,<PROMPT>"
    db "<NEXT>you'll never get"
    db "<NEXT>me to do it…<WAIT>"
    db "@"

Message_05_C1::
    db "<VOICE1>*: I'll think up<LINE>"
    db "new plans!<PROMPT>"
    db "<NEXT>I'll teach them to"
    db "<NEXT>you, <BUF0>!<WAIT>"
    db "@"

Message_05_C2::
    db "<VOICE1>*: 'Dirty' is just<LINE>"
    db "another way of<PROMPT>"
    db "<NEXT>saying 'shockingly"
    db "<NEXT>effective,' pal.<WAIT>"
    db "@"

Message_05_C3::
    db "<VOICE1>*: If you pull your<LINE>"
    db "punches, you'll be<PROMPT>"
    db "<NEXT>sure to regret it"
    db "<NEXT>later.<WAIT>"
    db "@"

Message_05_C4::
    db "<VOICE1>*: Don't talk to me…<LINE>"
    db "I don't like it…<WAIT>"
    db "@"

Message_05_C5::
    db "<VOICE1>*: <BUF0>, you sure<LINE>"
    db "work hard!<PROMPT>"
    db "<NEXT>You're just a"
    db "<NEXT>little kid too!<WAIT>"
    db "@"

Message_05_C6::
    db "<VOICE1>*: Let's stay away<LINE>"
    db "from danger.<WAIT>"
    db "@"

Message_05_C7::
    db "<VOICE1>*: Wouldn't it be<LINE>"
    db "nice if everyone,<PROMPT>"
    db "<NEXT>even our enemies,"
    db "<NEXT>could be friends?<WAIT>"
    db "@"

Message_05_C8::
    db "<VOICE1>*: Oh, the weather<LINE>"
    db "is so gorgeous!<PROMPT>"
    db "<NEXT>We should go for a"
    db "<NEXT>picnic!<WAIT>"
    db "@"

Message_05_C9::
    db "<VOICE1>*: I don't want to<LINE>"
    db "chat. Leave me be.<WAIT>"
    db "@"

Message_05_CA::
    db "<VOICE1>*: <BUF0>! Let's get<LINE>"
    db "moving quick!<PROMPT>"
    db "<NEXT>I relish this"
    db "<NEXT>challenge!<WAIT>"
    db "@"

Message_05_CB::
    db "<VOICE1>*: For tomorrow's<LINE>"
    db "victories,<PROMPT>"
    db "<NEXT>I'll spare no"
    db "<NEXT>effort today!<WAIT>"
    db "@"

Message_05_CC::
    db "<VOICE1>*: Check out this<LINE>"
    db "physique!<PROMPT>"
    db "<NEXT>Now this is what"
    db "<NEXT>you call refined!<WAIT>"
    db "@"

Message_05_CD::
    db "<VOICE1>*: In battle, every<LINE>"
    db "second is a drama!<WAIT>"
    db "@"

Message_05_CE::
    db "<VOICE1>*: Gahahahahahah!<LINE>"
    db "Chaaaaaaaaaarge!<PROMPT>"
    db "<NEXT>Just hammer'em,"
    db "<NEXT>I say. Hammer!<WAIT>"
    db "@"

Message_05_CF::
    db "<VOICE1>*: Oh? This human<LINE>"
    db "presumes to order<PROMPT>"
    db "<NEXT>me around?"
    db "<NEXT>How absurd.<WAIT>"
    db "@"

Message_05_D0::
    db "<VOICE1>*: No mercy needed<LINE>"
    db "for enemies!<PROMPT>"
    db "<NEXT>Smash'em all!"
    db "<NEXT><WAIT>"
    db "@"

Message_05_D1::
    db "<VOICE1>*: No guts,<LINE>"
    db "no glory!<WAIT>"
    db "@"

Message_05_D2::
    db "<VOICE1>*: Even if there<LINE>"
    db "were a hundred<PROMPT>"
    db "<NEXT>enemies, I will"
    db "<NEXT>keep marching on!<WAIT>"
    db "@"

Message_05_D3::
    db "<VOICE1>*: If I can get<LINE>"
    db "luck on my side,<PROMPT>"
    db "<NEXT>I can win them"
    db "<NEXT>all.<WAIT>"
    db "@"

Message_05_D4::
    db "<VOICE1>*: Master, there<LINE>"
    db "should be rules<PROMPT>"
    db "<NEXT>within our party"
    db "<NEXT>to keep order!<WAIT>"
    db "@"
    ds $8e, $00
