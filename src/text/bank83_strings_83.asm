; ROM bank $83: string tables
; The annotated listing of this bank is build/listing/bank83.asm.

SECTION "Bank 83", ROMX[$4000], BANK[$83]
    db $83

; Starts displaying string wStringIndex of category wStringCategory from message bank $83: below $C7
; it calls BeginStringDisplay with the table MessageStrings_Bank83; from $C7 up it far-calls
; BeginStringDisplay_Bank83_Overflow in bank $97, which subtracts $C7 from wStringIndex and uses its
; own overflow table. Reached by farcall from StartMessageForGroup_KeyWorld (index $20 and up of
; group 0 while in the key world) and the debug message test. (C1, E-0384)
; message bank $83: when wStringIndex < $C7, BeginStringDisplay with this bank's table
; MessageStrings_Bank83; otherwise far-calls BeginStringDisplay_Bank83_Overflow (E-0080)
BeginStringDisplay_Bank83::
    ld a, [wStringIndex]
    cp $c7
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank83_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank83
    call BeginStringDisplay
    ret

; Copies one string of message bank $83 to a buffer: when wStringIndex is below $C7 it calls
; CopyStringToBuffer with the table MessageStrings_Bank83 (string wStringIndex of category
; wStringCategory; copied with its $F0 terminator to the address in wStringDestLo/wStringDestHi);
; from $C7 up it far-calls CopyStringToBuffer_Bank83_Overflow in bank $97, which subtracts $C7 from
; wStringIndex and uses the overflow table. Nothing in src/ calls this copy: the BeginStringDisplay
; twin of this bank is the one the message code reaches. (C2, E-0384)
; message bank $83: when wStringIndex < $C7, CopyStringToBuffer with this bank's table
; MessageStrings_Bank83; otherwise far-calls CopyStringToBuffer_Bank83_Overflow (E-0080)
CopyStringToBuffer_Bank83::
    ld a, [wStringIndex]
    cp $c7
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank83_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank83
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; A table of one word: category 0 points to StringList_Bank83_0, the list of 199 string pointers
; (ids 0-$C6, String_83_00_00 to String_83_00_C6, in this bank). BeginStringDisplay_Bank83 and
; CopyStringToBuffer_Bank83 pass it in DE to BeginStringDisplay and CopyStringToBuffer when
; wStringIndex is below $C7; higher ids go to the overflow entry in bank $97. LookupString takes
; word wStringCategory of it and word wStringIndex of that list. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
MessageStrings_Bank83::
    dw StringList_Bank83_0 ; id 0

; category list of MessageStrings_Bank83; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank83_0::
    dw String_83_00_00 ; id 0
    dw String_83_00_00 ; id 1
    dw String_83_00_00 ; id 2
    dw String_83_00_00 ; id 3
    dw String_83_00_00 ; id 4
    dw String_83_00_00 ; id 5
    dw String_83_00_00 ; id 6
    dw String_83_00_00 ; id 7
    dw String_83_00_00 ; id 8
    dw String_83_00_00 ; id 9
    dw String_83_00_00 ; id 10
    dw String_83_00_00 ; id 11
    dw String_83_00_00 ; id 12
    dw String_83_00_00 ; id 13
    dw String_83_00_00 ; id 14
    dw String_83_00_00 ; id 15
    dw String_83_00_00 ; id 16
    dw String_83_00_00 ; id 17
    dw String_83_00_00 ; id 18
    dw String_83_00_00 ; id 19
    dw String_83_00_00 ; id 20
    dw String_83_00_00 ; id 21
    dw String_83_00_00 ; id 22
    dw String_83_00_00 ; id 23
    dw String_83_00_00 ; id 24
    dw String_83_00_00 ; id 25
    dw String_83_00_00 ; id 26
    dw String_83_00_00 ; id 27
    dw String_83_00_00 ; id 28
    dw String_83_00_00 ; id 29
    dw String_83_00_00 ; id 30
    dw String_83_00_00 ; id 31
    dw String_83_00_00 ; id 32
    dw String_83_00_21 ; id 33
    dw String_83_00_21 ; id 34
    dw String_83_00_23 ; id 35
    dw String_83_00_24 ; id 36
    dw String_83_00_25 ; id 37
    dw String_83_00_26 ; id 38
    dw String_83_00_27 ; id 39
    dw String_83_00_27 ; id 40
    dw String_83_00_29 ; id 41
    dw String_83_00_2A ; id 42
    dw String_83_00_2B ; id 43
    dw String_83_00_2C ; id 44
    dw String_83_00_2D ; id 45
    dw String_83_00_2E ; id 46
    dw String_83_00_2F ; id 47
    dw String_83_00_30 ; id 48
    dw String_83_00_31 ; id 49
    dw String_83_00_32 ; id 50
    dw String_83_00_33 ; id 51
    dw String_83_00_34 ; id 52
    dw String_83_00_35 ; id 53
    dw String_83_00_36 ; id 54
    dw String_83_00_37 ; id 55
    dw String_83_00_38 ; id 56
    dw String_83_00_39 ; id 57
    dw String_83_00_3A ; id 58
    dw String_83_00_3B ; id 59
    dw String_83_00_3C ; id 60
    dw String_83_00_3D ; id 61
    dw String_83_00_3E ; id 62
    dw String_83_00_3F ; id 63
    dw String_83_00_40 ; id 64
    dw String_83_00_41 ; id 65
    dw String_83_00_42 ; id 66
    dw String_83_00_43 ; id 67
    dw String_83_00_44 ; id 68
    dw String_83_00_45 ; id 69
    dw String_83_00_46 ; id 70
    dw String_83_00_46 ; id 71
    dw String_83_00_48 ; id 72
    dw String_83_00_49 ; id 73
    dw String_83_00_4A ; id 74
    dw String_83_00_4B ; id 75
    dw String_83_00_4C ; id 76
    dw String_83_00_4D ; id 77
    dw String_83_00_4E ; id 78
    dw String_83_00_4F ; id 79
    dw String_83_00_50 ; id 80
    dw String_83_00_51 ; id 81
    dw String_83_00_52 ; id 82
    dw String_83_00_53 ; id 83
    dw String_83_00_54 ; id 84
    dw String_83_00_55 ; id 85
    dw String_83_00_56 ; id 86
    dw String_83_00_57 ; id 87
    dw String_83_00_58 ; id 88
    dw String_83_00_59 ; id 89
    dw String_83_00_5A ; id 90
    dw String_83_00_5B ; id 91
    dw String_83_00_5C ; id 92
    dw String_83_00_5D ; id 93
    dw String_83_00_5E ; id 94
    dw String_83_00_5F ; id 95
    dw String_83_00_60 ; id 96
    dw String_83_00_61 ; id 97
    dw String_83_00_62 ; id 98
    dw String_83_00_63 ; id 99
    dw String_83_00_64 ; id 100
    dw String_83_00_65 ; id 101
    dw String_83_00_66 ; id 102
    dw String_83_00_67 ; id 103
    dw String_83_00_68 ; id 104
    dw String_83_00_69 ; id 105
    dw String_83_00_6A ; id 106
    dw String_83_00_6B ; id 107
    dw String_83_00_6C ; id 108
    dw String_83_00_6D ; id 109
    dw String_83_00_6E ; id 110
    dw String_83_00_6F ; id 111
    dw String_83_00_70 ; id 112
    dw String_83_00_71 ; id 113
    dw String_83_00_72 ; id 114
    dw String_83_00_73 ; id 115
    dw String_83_00_74 ; id 116
    dw String_83_00_75 ; id 117
    dw String_83_00_76 ; id 118
    dw String_83_00_77 ; id 119
    dw String_83_00_78 ; id 120
    dw String_83_00_79 ; id 121
    dw String_83_00_7A ; id 122
    dw String_83_00_7B ; id 123
    dw String_83_00_7C ; id 124
    dw String_83_00_7D ; id 125
    dw String_83_00_7E ; id 126
    dw String_83_00_7F ; id 127
    dw String_83_00_80 ; id 128
    dw String_83_00_81 ; id 129
    dw String_83_00_82 ; id 130
    dw String_83_00_83 ; id 131
    dw String_83_00_84 ; id 132
    dw String_83_00_85 ; id 133
    dw String_83_00_86 ; id 134
    dw String_83_00_87 ; id 135
    dw String_83_00_88 ; id 136
    dw String_83_00_89 ; id 137
    dw String_83_00_8A ; id 138
    dw String_83_00_8B ; id 139
    dw String_83_00_8C ; id 140
    dw String_83_00_8D ; id 141
    dw String_83_00_8E ; id 142
    dw String_83_00_8F ; id 143
    dw String_83_00_90 ; id 144
    dw String_83_00_91 ; id 145
    dw String_83_00_92 ; id 146
    dw String_83_00_93 ; id 147
    dw String_83_00_94 ; id 148
    dw String_83_00_95 ; id 149
    dw String_83_00_96 ; id 150
    dw String_83_00_97 ; id 151
    dw String_83_00_98 ; id 152
    dw String_83_00_99 ; id 153
    dw String_83_00_9A ; id 154
    dw String_83_00_9B ; id 155
    dw String_83_00_9C ; id 156
    dw String_83_00_9D ; id 157
    dw String_83_00_9E ; id 158
    dw String_83_00_9F ; id 159
    dw String_83_00_A0 ; id 160
    dw String_83_00_A1 ; id 161
    dw String_83_00_A2 ; id 162
    dw String_83_00_A3 ; id 163
    dw String_83_00_A4 ; id 164
    dw String_83_00_A5 ; id 165
    dw String_83_00_A6 ; id 166
    dw String_83_00_A7 ; id 167
    dw String_83_00_A8 ; id 168
    dw String_83_00_A9 ; id 169
    dw String_83_00_AA ; id 170
    dw String_83_00_AB ; id 171
    dw String_83_00_AC ; id 172
    dw String_83_00_AD ; id 173
    dw String_83_00_AE ; id 174
    dw String_83_00_AF ; id 175
    dw String_83_00_B0 ; id 176
    dw String_83_00_B1 ; id 177
    dw String_83_00_B2 ; id 178
    dw String_83_00_B3 ; id 179
    dw String_83_00_B4 ; id 180
    dw String_83_00_B5 ; id 181
    dw String_83_00_B6 ; id 182
    dw String_83_00_B7 ; id 183
    dw String_83_00_B8 ; id 184
    dw String_83_00_B9 ; id 185
    dw String_83_00_BA ; id 186
    dw String_83_00_BB ; id 187
    dw String_83_00_BC ; id 188
    dw String_83_00_BD ; id 189
    dw String_83_00_BE ; id 190
    dw String_83_00_BF ; id 191
    dw String_83_00_C0 ; id 192
    dw String_83_00_C1 ; id 193
    dw String_83_00_C2 ; id 194
    dw String_83_00_C3 ; id 195
    dw String_83_00_C4 ; id 196
    dw String_83_00_C5 ; id 197
    dw String_83_00_C6 ; id 198

String_83_00_00::
    db "<VOICE1>*: I am the King of<LINE>"
    db "this Kingdom!<PROMPT>"
    db "<NEXT>I'm busy, as you"
    db "<NEXT>can see!<PROMPT>"
    db "<NEXT>Begone, if you've"
    db "<NEXT>no business here!<WAIT>"
    db "@"

String_83_00_21::
    db "<VOICE1>*: It's safe in the<LINE>"
    db "Castle.<PROMPT>"
    db "<NEXT>A priest can tend"
    db "<NEXT>to your party too.<WAIT>"
    db "@"

String_83_00_23::
    db "<VOICE1>*: We get many<LINE>"
    db "visitors from<PROMPT>"
    db "<NEXT>other worlds."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I can guess why"
    db "<NEXT>you're here.<WAIT>"
    db "@"

String_83_00_24::
    db "<VOICE1>*: Your journey is<LINE>"
    db "a pilgrimage?<PROMPT>"
    db "<NEXT>That's impressive,"
    db "<NEXT>my dear child!<WAIT>"
    db "@"

String_83_00_25::
    db "<VOICE1>*: To attract wild<LINE>"
    db "monsters, you must<PROMPT>"
    db "<NEXT>not alarm them."
    db "<NEXT>Healing your own<PROMPT>"
    db "<NEXT>monsters will make"
    db "<NEXT>wild opponents<PROMPT>"
    db "<NEXT>mistrust you."
    db "<NEXT><WAIT>"
    db "@"

String_83_00_26::
    db "<VOICE1>*: K-keep monsters<LINE>"
    db "away from me!<PROMPT>"
    db "<NEXT>They frighten me!"
    db "<NEXT><WAIT>"
    db "@"

String_83_00_27::
    db "<VOICE1>*: The people here<LINE>"
    db "live in peace.<PROMPT>"
    db "<NEXT>We don't want"
    db "<NEXT>outsiders to bring<PROMPT>"
    db "<NEXT>in their problems."
    db "<NEXT><WAIT>"
    db "@"

String_83_00_29::
    db "<VOICE1>*: You've some odd<LINE>"
    db "monsters there.<PROMPT>"
    db "<NEXT>Where did you get"
    db "<NEXT>them? Tell me!<WAIT>"
    db "@"

String_83_00_2A::
    db "<VOICE1>*: Actually, if I<LINE>"
    db "wasn't the king,<PROMPT>"
    db "<NEXT>I may have left to"
    db "<NEXT>travel too…<WAIT>"
    db "@"

String_83_00_2B::
    db "<VOICE1>*: I like the<LINE>"
    db "atmosphere here.<PROMPT>"
    db "<NEXT>I", $44, " rather you"
    db "<NEXT>didn't bring in<PROMPT>"
    db "<NEXT>any problems from"
    db "<NEXT>outside.<WAIT>"
    db "@"

String_83_00_2C::
    db "<VOICE1>*: …Zzzz…<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>Hah? What?<LINE>"
    db "Excuse me!<PROMPT>"
    db "<NEXT>I've been so busy"
    db "<NEXT>of late, you see.<WAIT>"
    db "@"

String_83_00_2D::
    db "<VOICE1>*: You look to be a<LINE>"
    db "genius at handling<PROMPT>"
    db "<NEXT>monsters."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I suppose that"
    db "<NEXT>makes them safe.<WAIT>"
    db "@"

String_83_00_2E::
    db "<VOICE1>*: If you have no<LINE>"
    db "meat when you see<PROMPT>"
    db "<NEXT>a monster you want"
    db "<NEXT>to get, giving<PROMPT>"
    db "<NEXT>them Herbs will"
    db "<NEXT>earn their trust.<WAIT>"
    db "@"

String_83_00_2F::
    db "<VOICE1>*: If a monster<LINE>"
    db "grows slowly, you<PROMPT>"
    db "<NEXT>ought to consider"
    db "<NEXT>taking it alone.<PROMPT>"
    db "<NEXT>It will earn more"
    db "<NEXT>EX points.<WAIT>"
    db "@"

String_83_00_30::
    db "<VOICE1>*: There are some<LINE>"
    db "items that are to<PROMPT>"
    db "<NEXT>be equipped by"
    db "<NEXT>monsters.<WAIT>"
    db "@"

String_83_00_31::
    db "<VOICE1>*: Accessories for<LINE>"
    db "monsters are<PROMPT>"
    db "<NEXT>hidden in towers"
    db "<NEXT>and caves.<WAIT>"
    db "@"

String_83_00_32::
    db "<VOICE1>*: Equip D-Scale to<LINE>"
    db "raise DEF.<WAIT>"
    db "@"

String_83_00_33::
    db "<VOICE1>*: Accessories have<LINE>"
    db "different effects.<PROMPT>"
    db "<NEXT>Some kinds provide"
    db "<NEXT>better protection.<WAIT>"
    db "@"
    db "  "

String_83_00_34::
    db "<VOICE1>*: Accessories have<LINE>"
    db "different effects.<PROMPT>"
    db "<NEXT>Some kinds promote"
    db "<NEXT>stat growth.<WAIT>"
    db "@"

String_83_00_35::
    db "<VOICE1>*: Accessories have<LINE>"
    db "different effects.<PROMPT>"
    db "<NEXT>One even restores"
    db "<NEXT>HP as you walk.<WAIT>"
    db "@"

String_83_00_36::
    db "<VOICE1>*: Accessories have<LINE>"
    db "different effects.<PROMPT>"
    db "<NEXT>One even restores"
    db "<NEXT>MP as you walk.<WAIT>"
    db "@"

String_83_00_37::
    db "<VOICE1>*: A monster can<LINE>"
    db "equip only one<PROMPT>"
    db "<NEXT>accessory, or so"
    db "<NEXT>I've heard.<WAIT>"
    db "@"

String_83_00_38::
    db "<VOICE1>*: If a monster<LINE>"
    db "gets equipped with<PROMPT>"
    db "<NEXT>an accessory, the"
    db "<NEXT>old one's removed.<PROMPT>"
    db "<NEXT>It's not destroyed,"
    db "<NEXT>so don't worry.<WAIT>"
    db "@"

String_83_00_39::
    db "<VOICE1>*: Is there an<LINE>"
    db "accessory that'll<PROMPT>"
    db "<NEXT>let me stand up to"
    db "<NEXT>my wife?<WAIT>"
    db "@"

String_83_00_3A::
    db "<VOICE1>*: One accessory<LINE>"
    db "can be equipped.<PROMPT>"
    db "<NEXT>You can choose to"
    db "<NEXT>compensate for a<PROMPT>"
    db "<NEXT>weakness, or boost"
    db "<NEXT>a strength.<WAIT>"
    db "@"

String_83_00_3B::
    db "<VOICE1>*: You don't look<LINE>"
    db "familiar.<PROMPT>"
    db "<NEXT>A traveler, are"
    db "<NEXT>you?<PROMPT>"
    db "<NEXT>Be courteous to"
    db "<NEXT>our King!<WAIT>"
    db "@"

String_83_00_3C::
    db "<VOICE1>*: Ssh! Be quiet in<LINE>"
    db "the Castle!<WAIT>"
    db "@"

String_83_00_3D::
    db "<VOICE1>*: Zzzz…<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>Huh? N-no, I"
    db "<NEXT>wasn't sleeping!<WAIT>"
    db "@"

String_83_00_3E::
    db "<VOICE1>*: Monsters and<LINE>"
    db "humans co-existed<PROMPT>"
    db "<NEXT>peacefully in the"
    db "<NEXT>past.<PROMPT>"
    db "<NEXT>They won't attack"
    db "<NEXT>you if you don't<PROMPT>"
    db "<NEXT>disturb their"
    db "<NEXT>nests.<WAIT>"
    db "@"

String_83_00_3F::
    db "<VOICE1>*: Be careful in<LINE>"
    db "towers and caves.<PROMPT>"
    db "<NEXT>Monsters in them"
    db "<NEXT>are stronger.<WAIT>"
    db "@"

String_83_00_40::
    db "<VOICE1>*: You've got guts<LINE>"
    db "for a little kid!<WAIT>"
    db "@"

String_83_00_41::
    db "<VOICE1>*: In times of<LINE>"
    db "peace, we must be<PROMPT>"
    db "<NEXT>even more vigilant"
    db "<NEXT>than usual!<WAIT>"
    db "@"

String_83_00_42::
    db "<VOICE1>*: A high-power<LINE>"
    db "attack inflicts<PROMPT>"
    db "<NEXT>more damage, but"
    db "<NEXT>it's not accurate.<PROMPT>"
    db "<NEXT>SideStep is a good"
    db "<NEXT>countermeasure.<WAIT>"
    db "@"

String_83_00_43::
    db "<VOICE1>*: There are some<LINE>"
    db "skills that are<PROMPT>"
    db "<NEXT>extra-effective on"
    db "<NEXT>specific families.<PROMPT>"
    db "<NEXT>They're not flashy,"
    db "<NEXT>but they work.<WAIT>"
    db "@"

String_83_00_44::
    db "<VOICE1>*: Some skills put<LINE>"
    db "the user at risk.<PROMPT>"
    db "<NEXT>I like the gamble"
    db "<NEXT>that they pose!<WAIT>"
    db "@"

String_83_00_45::
    db "<VOICE1>*: GigaSlash is<LINE>"
    db "revered.<PROMPT>"
    db "<NEXT>This sword skill"
    db "<NEXT>is learned only by<PROMPT>"
    db "<NEXT>those who learn"
    db "<NEXT>all sword skills.<WAIT>"
    db "@"

String_83_00_46::
    db "<VOICE1>*: A kid with<LINE>"
    db "monsters in tow?<PROMPT>"
    db "<NEXT>You're a brave"
    db "<NEXT>soul!<WAIT>"
    db "@"

String_83_00_48::
    db "<VOICE1>*: Some monsters do<LINE>"
    db "not belong to any<PROMPT>"
    db "<NEXT>known family."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>They are powerful,"
    db "<NEXT>terrible beings.<PROMPT>"
    db "<NEXT>They reign as"
    db "<NEXT>lords and kings<PROMPT>"
    db "<NEXT>among demons and"
    db "<NEXT>monsters.<WAIT>"
    db "@"

String_83_00_49::
    db "<VOICE1>*: A visitor came<LINE>"
    db "here with a rare<PROMPT>"
    db "<NEXT>monster in his"
    db "<NEXT>party.<PROMPT>"
    db "<NEXT>I've never seen it"
    db "<NEXT>around here.<WAIT>"
    db "@"

String_83_00_4A::
    db "<VOICE1>*: Have you seen a<LINE>"
    db "casino ship?<PROMPT>"
    db "<NEXT>You can bet on"
    db "<NEXT>slot machines.<PROMPT>"
    db "<NEXT>You can win some"
    db "<NEXT>decent prizes too.<WAIT>"
    db "@"

String_83_00_4B::
    db "<VOICE1>*: Some monsters<LINE>"
    db "have attacks that<PROMPT>"
    db "<NEXT>hit and leave a"
    db "<NEXT>lingering effect.<PROMPT>"
    db "<NEXT>Watch out for"
    db "<NEXT>them.<PROMPT>"
    db "<NEXT>They'll be useful"
    db "<NEXT>in your party.<WAIT>"
    db "@"

String_83_00_4C::
    db "<VOICE1>*: Your eyes are<LINE>"
    db "unclouded…<PROMPT>"
    db "<NEXT>You seem to be a"
    db "<NEXT>good sort.<WAIT>"
    db "@"

String_83_00_4D::
    db "<VOICE1>*: When I was a<LINE>"
    db "kid, I wanted to<PROMPT>"
    db "<NEXT>travel everywhere."
    db "<NEXT>But at my age,<PROMPT>"
    db "<NEXT>home is where I"
    db "<NEXT>want to be.<WAIT>"
    db "@"

String_83_00_4E::
    db "<VOICE1>*: Hoo boy, it sure<LINE>"
    db "is quiet.<PROMPT>"
    db "<NEXT>Of course, it's"
    db "<NEXT>better that way.<WAIT>"
    db "@"

String_83_00_4F::
    db "<VOICE1>*: Sigh… All I ever<LINE>"
    db "do is clean up,<PROMPT>"
    db "<NEXT>the way the boss"
    db "<NEXT>says.<PROMPT>"
    db "<NEXT>When am I going to"
    db "<NEXT>be promoted?<WAIT>"
    db "@"

String_83_00_50::
    db "<VOICE1>*: The young people<LINE>"
    db "these days have no<PROMPT>"
    db "<NEXT>sense of gumption!"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Self-pitying"
    db "<NEXT>whiners, they are!<WAIT>"
    db "@"

String_83_00_51::
    db "<VOICE1>*: Halt!<LINE>"
    db "Who goes there?<PROMPT>"
    db "<NEXT>I look good as a"
    db "<NEXT>guard, don't I?<WAIT>"
    db "@"

String_83_00_52::
    db "<VOICE1>*: I'm terrified of<LINE>"
    db "monsters!<PROMPT>"
    db "<NEXT>Keep them away"
    db "<NEXT>from me!<WAIT>"
    db "@"

String_83_00_53::
    db "<VOICE1>*: A soldier has to<LINE>"
    db "obey orders.<PROMPT>"
    db "<NEXT>If soldiers don't"
    db "<NEXT>obey, even a<PROMPT>"
    db "<NEXT>winnable battle"
    db "<NEXT>will be lost.<PROMPT>"
    db "<NEXT>Train your party"
    db "<NEXT>well so they won't<PROMPT>"
    db "<NEXT>rebel against you"
    db "<NEXT>in battle.<WAIT>"
    db "@"

String_83_00_54::
    db "<VOICE1>*: Is it really<LINE>"
    db "possible for<PROMPT>"
    db "<NEXT>people to co-exist"
    db "<NEXT>with monsters?<WAIT>"
    db "@"

String_83_00_55::
    db "<VOICE1>*: You're not from<LINE>"
    db "these parts.<PROMPT>"
    db "<NEXT>I can tell."
    db "<NEXT>You're a bumpkin.<WAIT>"
    db "@"

String_83_00_56::
    db "<VOICE1>*: Money attracts<LINE>"
    db "greedy people.<PROMPT>"
    db "<NEXT>Keep extra money"
    db "<NEXT>in the Vault.<PROMPT>"
    db "<NEXT>It will be safe"
    db "<NEXT>there.<WAIT>"
    db "@"

String_83_00_57::
    db "<VOICE1>*: I've run into<LINE>"
    db "dealers while I<PROMPT>"
    db "<NEXT>was traveling"
    db "<NEXT>about.<PROMPT>"
    db "<NEXT>They charge crazy"
    db "<NEXT>prices, though.<WAIT>"
    db "@"

String_83_00_58::
    db "<VOICE1>*: I've met other<LINE>"
    db "travelers with<PROMPT>"
    db "<NEXT>monsters in tow"
    db "<NEXT>like you.<PROMPT>"
    db "<NEXT>They said they"
    db "<NEXT>were training.<WAIT>"
    db "@"

String_83_00_59::
    db "<VOICE1>*: Some monsters<LINE>"
    db "grow slowly when<PROMPT>"
    db "<NEXT>they are young,"
    db "<NEXT>but watch how they<PROMPT>"
    db "<NEXT>grow when they get"
    db "<NEXT>older. Wow!<WAIT>"
    db "@"

String_83_00_5A::
    db "<VOICE1>*: Monster families<LINE>"
    db "have upper limits<PROMPT>"
    db "<NEXT>to their growth."
    db "<NEXT>But the limits can<PROMPT>"
    db "<NEXT>be raised by"
    db "<NEXT>breeding.<WAIT>"
    db "@"

String_83_00_5B::
    db "<VOICE1>Seeds and nuts<LINE>"
    db "that raise stats<PROMPT>"
    db "<NEXT>are invaluable"
    db "<NEXT>items.<PROMPT>"
    db "<NEXT>On odd occasions,"
    db "<NEXT>you'll find them<PROMPT>"
    db "<NEXT>as gambling"
    db "<NEXT>prizes.<WAIT>"
    db "@"

String_83_00_5C::
    db "<VOICE1>*: There are many<LINE>"
    db "worlds, and there<PROMPT>"
    db "<NEXT>are many people,"
    db "<NEXT>both good and bad.<PROMPT>"
    db "<NEXT>That's why it's"
    db "<NEXT>exciting!<WAIT>"
    db "@"

String_83_00_5D::
    db "<VOICE1>*: I'm only a raw<LINE>"
    db "recruit, but one<PROMPT>"
    db "<NEXT>day, I'm going to"
    db "<NEXT>become a hero.<PROMPT>"
    db "<NEXT>When that happens,"
    db "<NEXT>I'll propose to my<PROMPT>"
    db "<NEXT>girl. I wonder if"
    db "<NEXT>she'll wait?<WAIT>"
    db "@"

String_83_00_5E::
    db "<VOICE1>*: You can't just<LINE>"
    db "work on physical<PROMPT>"
    db "<NEXT>might. You need to"
    db "<NEXT>be sharp mentally<PROMPT>"
    db "<NEXT>if you want to do"
    db "<NEXT>well in battle.<WAIT>"
    db "@"

String_83_00_5F::
    db "<VOICE1>*: Our King is<LINE>"
    db "named Al.<PROMPT>"
    db "<NEXT>Tell me, have you"
    db "<NEXT>MetalKing?<PROMPT>"
    db "<NEXT>Whoops, you didn't"
    db "<NEXT>find that funny?<WAIT>"
    db "@"

String_83_00_60::
    db "<VOICE1>*: There are no<LINE>"
    db "human settlements<PROMPT>"
    db "<NEXT>around these parts"
    db "<NEXT>except here.<PROMPT>"
    db "<NEXT>You should rest up"
    db "<NEXT>before you leave.<WAIT>"
    db "@"

String_83_00_61::
    db "<VOICE1>*: This is the only<LINE>"
    db "human settlement<PROMPT>"
    db "<NEXT>in these parts."
    db "<NEXT>You might consider<PROMPT>"
    db "<NEXT>resting here"
    db "<NEXT>before you go.<WAIT>"
    db "@"

String_83_00_62::
    db "<VOICE1>*: There are a few<LINE>"
    db "other places where<PROMPT>"
    db "<NEXT>people live in"
    db "<NEXT>these parts.<PROMPT>"
    db "<NEXT>Each has different"
    db "<NEXT>facilities.<WAIT>"
    db "@"

String_83_00_63::
    db "<VOICE1>*: The merchandise<LINE>"
    db "of shops varies<PROMPT>"
    db "<NEXT>from place to"
    db "<NEXT>place.<WAIT>"
    db "@"

String_83_00_64::
    db "<VOICE1>*: Welcome! Good of<LINE>"
    db "you to come!<PROMPT>"
    db "<NEXT>We don't get many"
    db "<NEXT>visitors.<WAIT>"
    db "@"

String_83_00_65::
    db "<VOICE1>*: It's dangerous<LINE>"
    db "out there.<PROMPT>"
    db "<NEXT>Get some rest"
    db "<NEXT>before you go.<WAIT>"
    db "@"

String_83_00_66::
    db "<VOICE1>*: Uh…<LINE>"
    db "Um…<PROMPT>"
    db "<NEXT>Aren't you afraid"
    db "<NEXT>of your monsters?<WAIT>"
    db "@"

String_83_00_67::
    db "<VOICE1>*: If you plan on<LINE>"
    db "traveling far, you<PROMPT>"
    db "<NEXT>should prepare for"
    db "<NEXT>any emergency.<PROMPT>"
    db "<NEXT>There's no telling"
    db "<NEXT>what could happen.<WAIT>"
    db "@"

String_83_00_68::
    db "<VOICE1>*: A LogTwig is<LINE>"
    db "convenient.<PROMPT>"
    db "<NEXT>Leave it anywhere"
    db "<NEXT>in the field, and<PROMPT>"
    db "<NEXT>you can get to it"
    db "<NEXT>with a WarpStaff.<WAIT>"
    db "@"

String_83_00_69::
    db "<VOICE1>*: Teach me how to<LINE>"
    db "tame monsters.<PROMPT>"
    db "<NEXT>I could get them"
    db "<NEXT>to cook and clean…<WAIT>"
    db "@"

String_83_00_6A::
    db "<VOICE1>*: You can make<LINE>"
    db "monsters friendly<PROMPT>"
    db "<NEXT>by taking them on"
    db "<NEXT>your journeys.<PROMPT>"
    db "<NEXT>Feeding them meat"
    db "<NEXT>is too costly.<WAIT>"
    db "@"

String_83_00_6B::
    db "<VOICE1>*: Do you know the<LINE>"
    db "skill Errand?<PROMPT>"
    db "<NEXT>You can get a"
    db "<NEXT>monster to go do<PROMPT>"
    db "<NEXT>some shopping for"
    db "<NEXT>you.<WAIT>"
    db "@"

String_83_00_6C::
    db "<VOICE1>*: Have you heard<LINE>"
    db "of EagleEye?<PROMPT>"
    db "<NEXT>It's a skill for"
    db "<NEXT>checking your<PROMPT>"
    db "<NEXT>surroundings from"
    db "<NEXT>a bird's-eye view.<WAIT>"
    db "@"

String_83_00_6D::
    db "<VOICE1>*: Do your monsters<LINE>"
    db "know Informer?<PROMPT>"
    db "<NEXT>It's a skill that"
    db "<NEXT>identifies the<PROMPT>"
    db "<NEXT>kinds of monsters"
    db "<NEXT>in the vicinity.<WAIT>"
    db "@"

String_83_00_6E::
    db "<VOICE1>*: Does any monster<LINE>"
    db "of yours know the<PROMPT>"
    db "<NEXT>skill MapMagic?"
    db "<NEXT>It gives you an<PROMPT>"
    db "<NEXT>idea about your"
    db "<NEXT>surrounding area.<WAIT>"
    db "@"

String_83_00_6F::
    db "<VOICE1>*: You need money<LINE>"
    db "to buy items.<PROMPT>"
    db "<NEXT>But money is hard"
    db "<NEXT>to find.<PROMPT>"
    db "<NEXT>I guess I have to"
    db "<NEXT>sell extra items.<WAIT>"
    db "@"

String_83_00_70::
    db "<VOICE1>*: The slime family<LINE>"
    db "is tough against<PROMPT>"
    db "<NEXT>spells like"
    db "<NEXT>Surround and Sap.<PROMPT>"
    db "<NEXT>If only they had"
    db "<NEXT>higher ATK…<WAIT>"
    db "@"

String_83_00_71::
    db "<VOICE1>*: Dragons are<LINE>"
    db "fire-resistant.<PROMPT>"
    db "<NEXT>If only they grew"
    db "<NEXT>a bit faster…<WAIT>"
    db "@"

String_83_00_72::
    db "<VOICE1>*: The beast family<LINE>"
    db "is very weak to<PROMPT>"
    db "<NEXT>attack spells."
    db "<NEXT>On the other hand,<PROMPT>"
    db "<NEXT>it has high ATK"
    db "<NEXT>and HP.<WAIT>"
    db "@"

String_83_00_73::
    db "<VOICE1>*: Birds are quite<LINE>"
    db "resistant to such<PROMPT>"
    db "<NEXT>spells as Infernos"
    db "<NEXT>and Zap.<PROMPT>"
    db "<NEXT>They also grow"
    db "<NEXT>fast.<WAIT>"
    db "@"

String_83_00_74::
    db "<VOICE1>*: The plant family<LINE>"
    db "is strong against<PROMPT>"
    db "<NEXT>spells like Zap"
    db "<NEXT>and Infernos.<PROMPT>"
    db "<NEXT>But it's vulnerable"
    db "<NEXT>to fire.<PROMPT>"
    db "<NEXT>MP gain is high on"
    db "<NEXT>leveling up.<WAIT>"
    db "@"

String_83_00_75::
    db "<VOICE1>*: The bug family<LINE>"
    db "is resistant to<PROMPT>"
    db "<NEXT>poison and"
    db "<NEXT>paralysis.<PROMPT>"
    db "<NEXT>Bugs also grow"
    db "<NEXT>fast, so they can<PROMPT>"
    db "<NEXT>become useful very"
    db "<NEXT>quickly.<WAIT>"
    db "@"

String_83_00_76::
    db "<VOICE1>*: The devil family<LINE>"
    db "is very resistant<PROMPT>"
    db "<NEXT>to all kinds of"
    db "<NEXT>attack spells.<PROMPT>"
    db "<NEXT>They", $44, " be great if"
    db "<NEXT>they didn't get<PROMPT>"
    db "<NEXT>poisoned or fall"
    db "<NEXT>asleep easily.<WAIT>"
    db "@"

String_83_00_77::
    db "<VOICE1>*: Zombies are<LINE>"
    db "virtually unharmed<PROMPT>"
    db "<NEXT>by death spells or"
    db "<NEXT>curses.<PROMPT>"
    db "<NEXT>On the other hand,"
    db "<NEXT>they are easily<PROMPT>"
    db "<NEXT>affected by fire"
    db "<NEXT>and WarCry…<WAIT>"
    db "@"

String_83_00_78::
    db "<VOICE1>*: There are many<LINE>"
    db "kinds of material<PROMPT>"
    db "<NEXT>family monsters."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>It's impossible to"
    db "<NEXT>describe their<PROMPT>"
    db "<NEXT>good points in one"
    db "<NEXT>breath.<WAIT>"
    db "@"

String_83_00_79::
    db "<VOICE1>*: Water family<LINE>"
    db "monsters are very<PROMPT>"
    db "<NEXT>tough against fire"
    db "<NEXT>and water skills.<PROMPT>"
    db "<NEXT>There isn't one"
    db "<NEXT>that really stands<PROMPT>"
    db "<NEXT>out, but they can"
    db "<NEXT>be quite useful.<WAIT>"
    db "@"

String_83_00_7A::
    db "<VOICE1>*: Have you met any<LINE>"
    db "Demon Lords?<PROMPT>"
    db "<NEXT>They make nasty"
    db "<NEXT>enemies, but if<PROMPT>"
    db "<NEXT>you could get them"
    db "<NEXT>on your side…<WAIT>"
    db "@"

String_83_00_7B::
    db "<VOICE1>*: It's getting<LINE>"
    db "mean out there.<PROMPT>"
    db "<NEXT>Strangers may want"
    db "<NEXT>to battle you.<WAIT>"
    db "@"

String_83_00_7C::
    db "<VOICE1>*: Skills that<LINE>"
    db "induce sleep or<PROMPT>"
    db "<NEXT>paralysis are very"
    db "<NEXT>effective.<PROMPT>"
    db "<NEXT>But watch out,"
    db "<NEXT>some monsters are<PROMPT>"
    db "<NEXT>impervious to"
    db "<NEXT>them.<WAIT>"
    db "@"

String_83_00_7D::
    db "<VOICE1>*: Have you seen<LINE>"
    db "any metallic kinds<PROMPT>"
    db "<NEXT>of slime monsters?"
    db "<NEXT>They're worth a<PROMPT>"
    db "<NEXT>huge amount of EX"
    db "<NEXT>points.<WAIT>"
    db "@"

String_83_00_7E::
    db "<VOICE1>*: My grandpa told<LINE>"
    db "me that if you see<PROMPT>"
    db "<NEXT>a bard, you're in"
    db "<NEXT>luck.<WAIT>"
    db "@"

String_83_00_7F::
    db "<VOICE1>*: Have you seen a<LINE>"
    db "Gold Pass?<PROMPT>"
    db "<NEXT>It's expensive,"
    db "<NEXT>but it gives you<PROMPT>"
    db "<NEXT>discounts at any"
    db "<NEXT>shop.<WAIT>"
    db "@"

String_83_00_80::
    db "<VOICE2>*: In the deepest<LINE>"
    db "part of a cave,<PROMPT>"
    db "<NEXT>a monster boss"
    db "<NEXT>makes its throne.<PROMPT>"
    db "<NEXT>It reigns over"
    db "<NEXT>other monsters.<WAIT>"
    db "@"

String_83_00_81::
    db "<VOICE2>*: At the top of a<LINE>"
    db "tower, you'll find<PROMPT>"
    db "<NEXT>a monster boss on"
    db "<NEXT>its throne.<PROMPT>"
    db "<NEXT>It reigns over"
    db "<NEXT>other monsters.<WAIT>"
    db "@"

String_83_00_82::
    db "<VOICE2>*: I hear that<LINE>"
    db "there's a monster<PROMPT>"
    db "<NEXT>boss in a castle"
    db "<NEXT>somewhere.<PROMPT>"
    db "<NEXT>It reigns over"
    db "<NEXT>other monsters.<WAIT>"
    db "@"

String_83_00_83::
    db "<VOICE2>*: Treasure chests<LINE>"
    db "are hidden in<PROMPT>"
    db "<NEXT>caves and towers,"
    db "<NEXT>I've heard.<PROMPT>"
    db "<NEXT>They must contain"
    db "<NEXT>amazing treasures!<WAIT>"
    db "@"

String_83_00_84::
    db "<VOICE2>*: Oh, you must be<LINE>"
    db "a traveler.<PROMPT>"
    db "<NEXT>There isn't much"
    db "<NEXT>here, but it is<PROMPT>"
    db "<NEXT>a nice place to"
    db "<NEXT>rest up.<WAIT>"
    db "@"

String_83_00_85::
    db "<VOICE2>*: You may find<LINE>"
    db "things in the<PROMPT>"
    db "<NEXT>oddest places."
    db "<NEXT>You have to look.<WAIT>"
    db "@"

String_83_00_86::
    db "<VOICE2>*: Now, where's my<LINE>"
    db "husband wandering?<PROMPT>"
    db "<NEXT>I send him out on"
    db "<NEXT>a simple errand…<PROMPT>"
    db "<NEXT>It's beyond belief,"
    db "<NEXT>let me tell you!<WAIT>"
    db "@"

String_83_00_87::
    db "<VOICE2>*: What to make for<LINE>"
    db "supper…<WAIT>"
    db "@"

String_83_00_88::
    db "<VOICE2>*: Oh my!<LINE>"
    db "What delicious…<PROMPT>"
    db "<NEXT>I mean cute! Yes,"
    db "<NEXT>cute, monsters!<WAIT>"
    db "@"

String_83_00_89::
    db "<VOICE2>*: I wish my boy<LINE>"
    db "was as mature as<PROMPT>"
    db "<NEXT>you, but he's just"
    db "<NEXT>so rambunctious.<PROMPT>"
    db "<NEXT>I can't let him"
    db "<NEXT>out of sight.<WAIT>"
    db "@"

String_83_00_8A::
    db "<VOICE2>*: Look at your<LINE>"
    db "dirty clothes!<PROMPT>"
    db "<NEXT>Are you washing"
    db "<NEXT>them properly?<WAIT>"
    db "@"

String_83_00_8B::
    db "<VOICE2>*: Our children<LINE>"
    db "grow like weeds.<PROMPT>"
    db "<NEXT>You should see how"
    db "<NEXT>much they eat.<WAIT>"
    db "@"

String_83_00_8C::
    db "<VOICE2>*: That man there<LINE>"
    db "keeps staring.<PROMPT>"
    db "<NEXT>Does he think I'm"
    db "<NEXT>strange?<WAIT>"
    db "@"

String_83_00_8D::
    db "<VOICE2>*: Oh, aren't you<LINE>"
    db "cute!<PROMPT>"
    db "<NEXT>And your monsters"
    db "<NEXT>are adorable too!<WAIT>"
    db "@"

String_83_00_8E::
    db "<VOICE2>*: It would be so<LINE>"
    db "nice to be able to<PROMPT>"
    db "<NEXT>cross the sea or"
    db "<NEXT>fly.<PROMPT>"
    db "<NEXT>If I could, I"
    db "<NEXT>would go see my<PROMPT>"
    db "<NEXT>boyfriend whenever"
    db "<NEXT>I wanted.<WAIT>"
    db "@"

String_83_00_8F::
    db "<VOICE2>*: I wish I had a<LINE>"
    db "sibling like you.<WAIT>"
    db "@"

String_83_00_90::
    db "<VOICE2>*: My boy is a<LINE>"
    db "dirt magnet!<PROMPT>"
    db "<NEXT>I can't keep up"
    db "<NEXT>with the wash!<WAIT>"
    db "@"

String_83_00_91::
    db "<VOICE2>*: …Sigh… When will<LINE>"
    db "he come back?<PROMPT>"
    db "<NEXT>He hasn't written"
    db "<NEXT>once, the clod!<WAIT>"
    db "@"

String_83_00_92::
    db "<VOICE2>*: Is it safe alone<LINE>"
    db "like that?<PROMPT>"
    db "<NEXT>Don't break your"
    db "<NEXT>parents' hearts!<WAIT>"
    db "@"

String_83_00_93::
    db "<VOICE2>*: Monsters have<LINE>"
    db "personalities that<PROMPT>"
    db "<NEXT>determine how they"
    db "<NEXT>behave.<WAIT>"
    db "@"

String_83_00_94::
    db "<VOICE2>*: I thought<LINE>"
    db "monsters were<PROMPT>"
    db "<NEXT>frightful things,"
    db "<NEXT>but the ones you<PROMPT>"
    db "<NEXT>have all look"
    db "<NEXT>cheerful.<WAIT>"
    db "@"

String_83_00_95::
    db "<VOICE2>*: You're on a<LINE>"
    db "journey with<PROMPT>"
    db "<NEXT>monsters?"
    db "<NEXT>I'm impressed.<WAIT>"
    db "@"

String_83_00_96::
    db "<VOICE2>*: I pack lightly<LINE>"
    db "for a journey.<PROMPT>"
    db "<NEXT>A WarpWing and a"
    db "<NEXT>Bookmark-<PROMPT>"
    db "<NEXT>those are basic."
    db "<NEXT>After these two,<PROMPT>"
    db "<NEXT>I take the bare"
    db "<NEXT>minimum, so I can<PROMPT>"
    db "<NEXT>pick up more items"
    db "<NEXT>that I find.<WAIT>"
    db "@"

String_83_00_97::
    db "<VOICE2>*: I love squishy<LINE>"
    db "monsters!<PROMPT>"
    db "<NEXT>They look so"
    db "<NEXT>appetizing!<PROMPT>"
    db "<NEXT>I'm joking!"
    db "<NEXT>Don't be scared!<WAIT>"
    db "@"

String_83_00_98::
    db "<VOICE2>*: How do monsters<LINE>"
    db "live in the wild?<PROMPT>"
    db "<NEXT>We don't know much"
    db "<NEXT>about them.<WAIT>"
    db "@"

String_83_00_99::
    db "<VOICE2>*: The FriendStaff<LINE>"
    db "works exactly like<PROMPT>"
    db "<NEXT>the spell TwinHits"
    db "<NEXT>in battle.<PROMPT>"
    db "<NEXT>It will definitely"
    db "<NEXT>come in handy.<WAIT>"
    db "@"

String_83_00_9A::
    db "<VOICE2>*: The MistStaff<LINE>"
    db "does the same work<PROMPT>"
    db "<NEXT>as the spell"
    db "<NEXT>StopSpell.<PROMPT>"
    db "<NEXT>Use it to silence"
    db "<NEXT>spell-casters.<WAIT>"
    db "@"

String_83_00_9B::
    db "<VOICE2>*: You can attack<LINE>"
    db "monsters using<PROMPT>"
    db "<NEXT>the powers of"
    db "<NEXT>certain staves.<PROMPT>"
    db "<NEXT>But monsters won't"
    db "<NEXT>like you for it.<WAIT>"
    db "@"

String_83_00_9C::
    db "<VOICE2>*: BadMeat acts<LINE>"
    db "like poison.<PROMPT>"
    db "<NEXT>Don't feed it to"
    db "<NEXT>your monsters,<PROMPT>"
    db "<NEXT>but it works on"
    db "<NEXT>enemies well.<WAIT>"
    db "@"

String_83_00_9D::
    db "<VOICE2>*: Repellent keeps<LINE>"
    db "monsters away.<PROMPT>"
    db "<NEXT>The Shiny Harp"
    db "<NEXT>does the opposite.<WAIT>"
    db "@"

String_83_00_9E::
    db "<VOICE2>*: How adorable!<LINE>"
    db "How would you like<PROMPT>"
    db "<NEXT>a nice powderpuff"
    db "<NEXT>massage?<PROMPT>"
    db "<NEXT>Oh? Not you."
    db "<NEXT>I love monsters!<WAIT>"
    db "@"

String_83_00_9F::
    db "<VOICE2>*: Have you heard<LINE>"
    db "about the great<PROMPT>"
    db "<NEXT>master tamer?"
    db "<NEXT>He's amazing.<PROMPT>"
    db "<NEXT>He's named Terry."
    db "<NEXT>He's still young!<WAIT>"
    db "@"

String_83_00_A0::
    db "<VOICE1>*: Magic Keys are<LINE>"
    db "indeed magical.<PROMPT>"
    db "<NEXT>It's magical how"
    db "<NEXT>they lead to<PROMPT>"
    db "<NEXT>different worlds"
    db "<NEXT>we don't know.<WAIT>"
    db "@"

String_83_00_A1::
    db "<VOICE1>*: If something is<LINE>"
    db "rare or valuable…<PROMPT>"
    db "<NEXT>You", $44, " never leave"
    db "<NEXT>it in plain sight.<WAIT>"
    db "@"

String_83_00_A2::
    db "<VOICE1>*: Caves and towers<LINE>"
    db "teem with danger!<PROMPT>"
    db "<NEXT>Going in is only"
    db "<NEXT>half the job.<PROMPT>"
    db "<NEXT>You have to get"
    db "<NEXT>yourself back out!<WAIT>"
    db "@"

String_83_00_A3::
    db "<VOICE1>*: A treasure chest<LINE>"
    db "holds one item.<WAIT>"
    db "@"

String_83_00_A4::
    db "<VOICE1>*: Ah, I can't<LINE>"
    db "recall seeing a<PROMPT>"
    db "<NEXT>cuter visitor than"
    db "<NEXT>you, dear child.<PROMPT>"
    db "<NEXT>Do take the time"
    db "<NEXT>to relax here.<WAIT>"
    db "@"

String_83_00_A5::
    db "<VOICE1>*: If you're ever<LINE>"
    db "in need of help,<PROMPT>"
    db "<NEXT>be sure to come"
    db "<NEXT>back here.<WAIT>"
    db "@"

String_83_00_A6::
    db "<VOICE1>*: Other worlds,<LINE>"
    db "you say?<PROMPT>"
    db "<NEXT>I", $44, " like to go"
    db "<NEXT>somewhere…<WAIT>"
    db "@"

String_83_00_A7::
    db "<VOICE1>*: So good of you<LINE>"
    db "to visit us at<PROMPT>"
    db "<NEXT>this distant and"
    db "<NEXT>forgotten outpost.<PROMPT>"
    db "<NEXT>There is nothing"
    db "<NEXT>here at all.<PROMPT>"
    db "<NEXT>But feel free to"
    db "<NEXT>stay as long as<PROMPT>"
    db "<NEXT>you wish."
    db "<NEXT><WAIT>"
    db "@"

String_83_00_A8::
    db "<VOICE1>*: Ah, you're such<LINE>"
    db "a cute cherub!<PROMPT>"
    db "<NEXT>You look exactly"
    db "<NEXT>as my son did.<PROMPT>"
    db "<NEXT>Wait! Are you my"
    db "<NEXT>grandchild?<WAIT>"
    db "@"

String_83_00_A9::
    db "<VOICE1>*: Hah? You have<LINE>"
    db "tamed monsters?<PROMPT>"
    db "<NEXT>You're to be"
    db "<NEXT>commended!<PROMPT>"
    db "<NEXT>I did the same"
    db "<NEXT>when I was young…<WAIT>"
    db "@"

String_83_00_AA::
    db "<VOICE1>*: If something<LINE>"
    db "comes easily,<PROMPT>"
    db "<NEXT>one is apt to not"
    db "<NEXT>realize its worth.<PROMPT>"
    db "<NEXT>When you do, it's"
    db "<NEXT>usually been lost…<WAIT>"
    db "@"

String_83_00_AB::
    db "<VOICE1>*: If you wish to<LINE>"
    db "meet travelers<PROMPT>"
    db "<NEXT>like yourself, you"
    db "<NEXT>must walk.<PROMPT>"
    db "<NEXT>You'll get to see"
    db "<NEXT>them, by and by.<WAIT>"
    db "@"

String_83_00_AC::
    db "<VOICE1>*: When I was your<LINE>"
    db "age, I admit I was<PROMPT>"
    db "<NEXT>a mischievous lad,"
    db "<NEXT>if I may say so.<PROMPT>"
    db "<NEXT>I remember those"
    db "<NEXT>days clearly…<WAIT>"
    db "@"

String_83_00_AD::
    db "<VOICE1>*: I take my walk<LINE>"
    db "on the same route<PROMPT>"
    db "<NEXT>every day. I never"
    db "<NEXT>go anywhere else.<PROMPT>"
    db "<NEXT>But, like the way"
    db "<NEXT>I met you today,<PROMPT>"
    db "<NEXT>there is always a"
    db "<NEXT>new discovery.<WAIT>"
    db "@"

String_83_00_AE::
    db "<VOICE1>*: My eyesight isn't<LINE>"
    db "what it once was.<PROMPT>"
    db "<NEXT>But my nose works"
    db "<NEXT>quite fine.<PROMPT>"
    db "<NEXT>The friends behind"
    db "<NEXT>you desperately<PROMPT>"
    db "<NEXT>need a bath, I can"
    db "<NEXT>tell that much.<WAIT>"
    db "@"

String_83_00_AF::
    db "<VOICE1>*: Ah-ha, you're<LINE>"
    db "such a cute child!<PROMPT>"
    db "<NEXT>About a tenth of"
    db "<NEXT>the cuteness of my<PROMPT>"
    db "<NEXT>grandchildren, I"
    db "<NEXT>would think.<WAIT>"
    db "@"

String_83_00_B0::
    db "<VOICE1>*: I was a fine-<LINE>"
    db "looking fellow<PROMPT>"
    db "<NEXT>with many lady"
    db "<NEXT>friends.<PROMPT>"
    db "<NEXT>Not that you could"
    db "<NEXT>tell from this<PROMPT>"
    db "<NEXT>wrinkled old sack"
    db "<NEXT>of bones!<WAIT>"
    db "@"

String_83_00_B1::
    db "<VOICE1>*: A monster can<LINE>"
    db "equip a single<PROMPT>"
    db "<NEXT>accessory, and no"
    db "<NEXT>more.<PROMPT>"
    db "<NEXT>If you equip"
    db "<NEXT>another one, the<PROMPT>"
    db "<NEXT>old one is taken"
    db "<NEXT>off.<WAIT>"
    db "@"

String_83_00_B2::
    db "<VOICE1>*: If someone asks<LINE>"
    db "you to mate some<PROMPT>"
    db "<NEXT>monsters, be quick"
    db "<NEXT>to accept.<PROMPT>"
    db "<NEXT>Traveling masters"
    db "<NEXT>don't stay long.<WAIT>"
    db "@"

String_83_00_B3::
    db "<VOICE1>*: Hm, when I was<LINE>"
    db "young, I must say<PROMPT>"
    db "<NEXT>that I was foolish"
    db "<NEXT>and reckless.<PROMPT>"
    db "<NEXT>To see someone as"
    db "<NEXT>young as you<PROMPT>"
    db "<NEXT>traveling with"
    db "<NEXT>monsters…<PROMPT>"
    db "<NEXT>You're nothing if"
    db "<NEXT>not reckless!<WAIT>"
    db "@"

String_83_00_B4::
    db "<VOICE1>*: If you see a<LINE>"
    db "fellow traveler,<PROMPT>"
    db "<NEXT>talk to him or her"
    db "<NEXT>right away.<PROMPT>"
    db "<NEXT>They'll wander off"
    db "<NEXT>if you don't.<WAIT>"
    db "@"

String_83_00_B5::
    db "<VOICE1>*: I see something<LINE>"
    db "in your eyes…<PROMPT>"
    db "<NEXT>I get the feeling"
    db "<NEXT>that you're going<PROMPT>"
    db "<NEXT>to do something"
    db "<NEXT>extraordinary.<WAIT>"
    db "@"

String_83_00_B6::
    db "<VOICE1>*: The personality<LINE>"
    db "of a monster gets<PROMPT>"
    db "<NEXT>changed by your"
    db "<NEXT>battle plans.<PROMPT>"
    db "<NEXT>If you don't train"
    db "<NEXT>it properly, it<PROMPT>"
    db "<NEXT>may not battle"
    db "<NEXT>effectively.<WAIT>"
    db "@"

String_83_00_B7::
    db "<VOICE1>*: If a monster is<LINE>"
    db "made to 'Charge", $95, "<PROMPT>"
    db "<NEXT>all the time, it"
    db "<NEXT>will become more<PROMPT>"
    db "<NEXT>brave, but less"
    db "<NEXT>sensible.<WAIT>"
    db "@"

String_83_00_B8::
    db "<VOICE1>*: If a monster is<LINE>"
    db "given a 'Mixed", $95, "<PROMPT>"
    db "<NEXT>plan, it becomes"
    db "<NEXT>more sensible.<PROMPT>"
    db "<NEXT>But it also turns"
    db "<NEXT>less kindly.<WAIT>"
    db "@"

String_83_00_B9::
    db "<VOICE1>*: If a monster is<LINE>"
    db "ordered to use<PROMPT>"
    db "<NEXT>'Defense' in"
    db "<NEXT>battle, it will<PROMPT>"
    db "<NEXT>turn increasingly"
    db "<NEXT>compassionate.<PROMPT>"
    db "<NEXT>But, it also turns"
    db "<NEXT>less brave.<WAIT>"
    db "@"

String_83_00_BA::
    db "<VOICE1>*: If a monster's<LINE>"
    db "personality is<PROMPT>"
    db "<NEXT>'Coward' or 'EZ"
    db "<NEXT>going', it's not<PROMPT>"
    db "<NEXT>really suitable"
    db "<NEXT>for attacking.<WAIT>"
    db "@"

String_83_00_BB::
    db "<VOICE1>*: If a monster's<LINE>"
    db "personality is<PROMPT>"
    db "<NEXT>'Daredevil' or"
    db "<NEXT>'Carefree', it's<PROMPT>"
    db "<NEXT>not good in a"
    db "<NEXT>supporting role.<WAIT>"
    db "@"

String_83_00_BC::
    db "<VOICE1>*: If a monster's<LINE>"
    db "personality is<PROMPT>"
    db "<NEXT>'Snobby' or"
    db "<NEXT>'Spoiled', don't<PROMPT>"
    db "<NEXT>expect it to make"
    db "<NEXT>a good healer.<WAIT>"
    db "@"

String_83_00_BD::
    db "<VOICE1>*: A monster's<LINE>"
    db "personality is an<PROMPT>"
    db "<NEXT>important factor"
    db "<NEXT>in battle.<PROMPT>"
    db "<NEXT>Be sure to check"
    db "<NEXT>them in advance.<WAIT>"
    db "@"

String_83_00_BE::
    db "<VOICE1>*: I see a dark<LINE>"
    db "shadow casting its<PROMPT>"
    db "<NEXT>pall over your"
    db "<NEXT>monsters…<PROMPT>"
    db "<NEXT>It appears to be"
    db "<NEXT>an evil sign.<PROMPT>"
    db "<NEXT>Don't push them"
    db "<NEXT>too hard.<WAIT>"
    db "@"

String_83_00_BF::
    db "<VOICE1>*: Just pushing me<LINE>"
    db "won't budge me!<WAIT>"
    db "@"

String_83_00_C0::
    db "<VOICE1>*: The personality<LINE>"
    db "of a monster<PROMPT>"
    db "<NEXT>changes depending"
    db "<NEXT>on battle plans.<PROMPT>"
    db "<NEXT>I bet you didn't"
    db "<NEXT>know that.<WAIT>"
    db "@"

String_83_00_C1::
    db "<VOICE1>*: Seeds and nuts<LINE>"
    db "can raise monster<PROMPT>"
    db "<NEXT>stats even if they"
    db "<NEXT>can't level up.<PROMPT>"
    db "<NEXT>I bet you didn't"
    db "<NEXT>know that.<WAIT>"
    db "@"

String_83_00_C2::
    db "<VOICE1>*: How quickly<LINE>"
    db "monsters level up<PROMPT>"
    db "<NEXT>varies from family"
    db "<NEXT>to family.<PROMPT>"
    db "<NEXT>I bet you didn't"
    db "<NEXT>know that.<WAIT>"
    db "@"

String_83_00_C3::
    db "<VOICE1>*: Monster families<LINE>"
    db "have different<PROMPT>"
    db "<NEXT>resistance levels"
    db "<NEXT>to spell types.<PROMPT>"
    db "<NEXT>Some are tough"
    db "<NEXT>against fire, and<PROMPT>"
    db "<NEXT>weak to water, for"
    db "<NEXT>instance.<WAIT>"
    db "@"

String_83_00_C4::
    db "<VOICE1>*: A monster marked<LINE>"
    db "with a ★ won't grow<PROMPT>"
    db "<NEXT>anymore. Its level"
    db "<NEXT>is maxed out.<PROMPT>"
    db "<NEXT>I bet you didn't"
    db "<NEXT>know that.<WAIT>"
    db "@"

String_83_00_C5::
    db "<VOICE1>*: You've seen your<LINE>"
    db "monsters score<PROMPT>"
    db "<NEXT>critical hits,"
    db "<NEXT>right?<PROMPT>"
    db "<NEXT>There's a family"
    db "<NEXT>that gets more<PROMPT>"
    db "<NEXT>critical hits than"
    db "<NEXT>others.<WAIT>"
    db "@"

String_83_00_C6::
    db "<VOICE1>*: Y-your monsters<LINE>"
    db "are staring at me…<PROMPT>"
    db "<NEXT>And… And they're"
    db "<NEXT>drooling!<WAIT>"
    db "@"
    ds $a7, $00
