SECTION "Bank 83", ROMX[$4000], BANK[$83]
    db $83

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

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_83_4032::
MessageStrings_Bank83::
    dw StringList_83_4034 ; id 0

; category list of StringCategories_83_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_83_4034::
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
    db $ea, "*: I am the King of", $f1
    db "this Kingdom!", $fa, $f7
    db $ef, $ee, "I'm busy, as you", $ef, $ee, "can see!", $fa, $f7
    db $ef, $ee, "Begone, if you've", $ef, $ee, "no business here!", $f7
    db $f0

String_83_00_21::
    db $ea, "*: It's safe in the", $f1
    db "Castle.", $fa, $f7
    db $ef, $ee, "A priest can tend", $ef, $ee, "to your party too.", $f7
    db $f0

String_83_00_23::
    db $ea, "*: We get many", $f1
    db "visitors from", $fa, $f7
    db $ef, $ee, "other worlds.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "I can guess why", $ef, $ee, "you're here.", $f7
    db $f0

String_83_00_24::
    db $ea, "*: Your journey is", $f1
    db "a pilgrimage?", $fa, $f7
    db $ef, $ee, "That's impressive,", $ef, $ee, "my dear child!", $f7
    db $f0

String_83_00_25::
    db $ea, "*: To attract wild", $f1
    db "monsters, you must", $fa, $f7
    db $ef, $ee, "not alarm them.", $ef, $ee, "Healing your own", $fa, $f7
    db $ef, $ee, "monsters will make", $ef, $ee, "wild opponents", $fa, $f7
    db $ef, $ee, "mistrust you.", $ef, $ee, $f7
    db $f0

String_83_00_26::
    db $ea, "*: K-keep monsters", $f1
    db "away from me!", $fa, $f7
    db $ef, $ee, "They frighten me!", $ef, $ee, $f7
    db $f0

String_83_00_27::
    db $ea, "*: The people here", $f1
    db "live in peace.", $fa, $f7
    db $ef, $ee, "We don't want", $ef, $ee, "outsiders to bring", $fa, $f7
    db $ef, $ee, "in their problems.", $ef, $ee, $f7
    db $f0

String_83_00_29::
    db $ea, "*: You've some odd", $f1
    db "monsters there.", $fa, $f7
    db $ef, $ee, "Where did you get", $ef, $ee, "them? Tell me!", $f7
    db $f0

String_83_00_2A::
    db $ea, "*: Actually, if I", $f1
    db "wasn't the king,", $fa, $f7
    db $ef, $ee, "I may have left to", $ef, $ee, "travel too", $a4, $f7
    db $f0

String_83_00_2B::
    db $ea, "*: I like the", $f1
    db "atmosphere here.", $fa, $f7
    db $ef, $ee, "I", $44, " rather you", $ef, $ee, "didn't bring in", $fa, $f7
    db $ef, $ee, "any problems from", $ef, $ee, "outside.", $f7
    db $f0

String_83_00_2C::
    db $ea, "*: ", $a4, "Zzzz", $a4, $f1
    db $fa, $f7
    db $ef, $ee, $f3, "Hah? What?", $f1
    db "Excuse me!", $fa, $f7
    db $ef, $ee, "I've been so busy", $ef, $ee, "of late, you see.", $f7
    db $f0

String_83_00_2D::
    db $ea, "*: You look to be a", $f1
    db "genius at handling", $fa, $f7
    db $ef, $ee, "monsters.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "I suppose that", $ef, $ee, "makes them safe.", $f7
    db $f0

String_83_00_2E::
    db $ea, "*: If you have no", $f1
    db "meat when you see", $fa, $f7
    db $ef, $ee, "a monster you want", $ef, $ee, "to get, giving", $fa, $f7
    db $ef, $ee, "them Herbs will", $ef, $ee, "earn their trust.", $f7
    db $f0

String_83_00_2F::
    db $ea, "*: If a monster", $f1
    db "grows slowly, you", $fa, $f7
    db $ef, $ee, "ought to consider", $ef, $ee, "taking it alone.", $fa, $f7
    db $ef, $ee, "It will earn more", $ef, $ee, "EX points.", $f7
    db $f0

String_83_00_30::
    db $ea, "*: There are some", $f1
    db "items that are to", $fa, $f7
    db $ef, $ee, "be equipped by", $ef, $ee, "monsters.", $f7
    db $f0

String_83_00_31::
    db $ea, "*: Accessories for", $f1
    db "monsters are", $fa, $f7
    db $ef, $ee, "hidden in towers", $ef, $ee, "and caves.", $f7
    db $f0

String_83_00_32::
    db $ea, "*: Equip D-Scale to", $f1
    db "raise DEF.", $f7
    db $f0

String_83_00_33::
    db $ea, "*: Accessories have", $f1
    db "different effects.", $fa, $f7
    db $ef, $ee, "Some kinds provide", $ef, $ee, "better protection.", $f7
    db $f0, "  "

String_83_00_34::
    db $ea, "*: Accessories have", $f1
    db "different effects.", $fa, $f7
    db $ef, $ee, "Some kinds promote", $ef, $ee, "stat growth.", $f7
    db $f0

String_83_00_35::
    db $ea, "*: Accessories have", $f1
    db "different effects.", $fa, $f7
    db $ef, $ee, "One even restores", $ef, $ee, "HP as you walk.", $f7
    db $f0

String_83_00_36::
    db $ea, "*: Accessories have", $f1
    db "different effects.", $fa, $f7
    db $ef, $ee, "One even restores", $ef, $ee, "MP as you walk.", $f7
    db $f0

String_83_00_37::
    db $ea, "*: A monster can", $f1
    db "equip only one", $fa, $f7
    db $ef, $ee, "accessory, or so", $ef, $ee, "I've heard.", $f7
    db $f0

String_83_00_38::
    db $ea, "*: If a monster", $f1
    db "gets equipped with", $fa, $f7
    db $ef, $ee, "an accessory, the", $ef, $ee, "old one's removed.", $fa, $f7
    db $ef, $ee, "It's not destroyed,", $ef, $ee, "so don't worry.", $f7
    db $f0

String_83_00_39::
    db $ea, "*: Is there an", $f1
    db "accessory that'll", $fa, $f7
    db $ef, $ee, "let me stand up to", $ef, $ee, "my wife?", $f7
    db $f0

String_83_00_3A::
    db $ea, "*: One accessory", $f1
    db "can be equipped.", $fa, $f7
    db $ef, $ee, "You can choose to", $ef, $ee, "compensate for a", $fa, $f7
    db $ef, $ee, "weakness, or boost", $ef, $ee, "a strength.", $f7
    db $f0

String_83_00_3B::
    db $ea, "*: You don't look", $f1
    db "familiar.", $fa, $f7
    db $ef, $ee, "A traveler, are", $ef, $ee, "you?", $fa, $f7
    db $ef, $ee, "Be courteous to", $ef, $ee, "our King!", $f7
    db $f0

String_83_00_3C::
    db $ea, "*: Ssh! Be quiet in", $f1
    db "the Castle!", $f7
    db $f0

String_83_00_3D::
    db $ea, "*: Zzzz", $a4, $f1
    db $fa, $f7
    db $ef, $ee, $f3, "Huh? N-no, I", $ef, $ee, "wasn't sleeping!", $f7
    db $f0

String_83_00_3E::
    db $ea, "*: Monsters and", $f1
    db "humans co-existed", $fa, $f7
    db $ef, $ee, "peacefully in the", $ef, $ee, "past.", $fa, $f7
    db $ef, $ee, "They won't attack", $ef, $ee, "you if you don't", $fa, $f7
    db $ef, $ee, "disturb their", $ef, $ee, "nests.", $f7
    db $f0

String_83_00_3F::
    db $ea, "*: Be careful in", $f1
    db "towers and caves.", $fa, $f7
    db $ef, $ee, "Monsters in them", $ef, $ee, "are stronger.", $f7
    db $f0

String_83_00_40::
    db $ea, "*: You've got guts", $f1
    db "for a little kid!", $f7
    db $f0

String_83_00_41::
    db $ea, "*: In times of", $f1
    db "peace, we must be", $fa, $f7
    db $ef, $ee, "even more vigilant", $ef, $ee, "than usual!", $f7
    db $f0

String_83_00_42::
    db $ea, "*: A high-power", $f1
    db "attack inflicts", $fa, $f7
    db $ef, $ee, "more damage, but", $ef, $ee, "it's not accurate.", $fa, $f7
    db $ef, $ee, "SideStep is a good", $ef, $ee, "countermeasure.", $f7
    db $f0

String_83_00_43::
    db $ea, "*: There are some", $f1
    db "skills that are", $fa, $f7
    db $ef, $ee, "extra-effective on", $ef, $ee, "specific families.", $fa, $f7
    db $ef, $ee, "They're not flashy,", $ef, $ee, "but they work.", $f7
    db $f0

String_83_00_44::
    db $ea, "*: Some skills put", $f1
    db "the user at risk.", $fa, $f7
    db $ef, $ee, "I like the gamble", $ef, $ee, "that they pose!", $f7
    db $f0

String_83_00_45::
    db $ea, "*: GigaSlash is", $f1
    db "revered.", $fa, $f7
    db $ef, $ee, "This sword skill", $ef, $ee, "is learned only by", $fa, $f7
    db $ef, $ee, "those who learn", $ef, $ee, "all sword skills.", $f7
    db $f0

String_83_00_46::
    db $ea, "*: A kid with", $f1
    db "monsters in tow?", $fa, $f7
    db $ef, $ee, "You're a brave", $ef, $ee, "soul!", $f7
    db $f0

String_83_00_48::
    db $ea, "*: Some monsters do", $f1
    db "not belong to any", $fa, $f7
    db $ef, $ee, "known family.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "They are powerful,", $ef, $ee, "terrible beings.", $fa, $f7
    db $ef, $ee, "They reign as", $ef, $ee, "lords and kings", $fa, $f7
    db $ef, $ee, "among demons and", $ef, $ee, "monsters.", $f7
    db $f0

String_83_00_49::
    db $ea, "*: A visitor came", $f1
    db "here with a rare", $fa, $f7
    db $ef, $ee, "monster in his", $ef, $ee, "party.", $fa, $f7
    db $ef, $ee, "I've never seen it", $ef, $ee, "around here.", $f7
    db $f0

String_83_00_4A::
    db $ea, "*: Have you seen a", $f1
    db "casino ship?", $fa, $f7
    db $ef, $ee, "You can bet on", $ef, $ee, "slot machines.", $fa, $f7
    db $ef, $ee, "You can win some", $ef, $ee, "decent prizes too.", $f7
    db $f0

String_83_00_4B::
    db $ea, "*: Some monsters", $f1
    db "have attacks that", $fa, $f7
    db $ef, $ee, "hit and leave a", $ef, $ee, "lingering effect.", $fa, $f7
    db $ef, $ee, "Watch out for", $ef, $ee, "them.", $fa, $f7
    db $ef, $ee, "They'll be useful", $ef, $ee, "in your party.", $f7
    db $f0

String_83_00_4C::
    db $ea, "*: Your eyes are", $f1
    db "unclouded", $a4, $fa, $f7
    db $ef, $ee, "You seem to be a", $ef, $ee, "good sort.", $f7
    db $f0

String_83_00_4D::
    db $ea, "*: When I was a", $f1
    db "kid, I wanted to", $fa, $f7
    db $ef, $ee, "travel everywhere.", $ef, $ee, "But at my age,", $fa, $f7
    db $ef, $ee, "home is where I", $ef, $ee, "want to be.", $f7
    db $f0

String_83_00_4E::
    db $ea, "*: Hoo boy, it sure", $f1
    db "is quiet.", $fa, $f7
    db $ef, $ee, "Of course, it's", $ef, $ee, "better that way.", $f7
    db $f0

String_83_00_4F::
    db $ea, "*: Sigh", $a4, " All I ever", $f1
    db "do is clean up,", $fa, $f7
    db $ef, $ee, "the way the boss", $ef, $ee, "says.", $fa, $f7
    db $ef, $ee, "When am I going to", $ef, $ee, "be promoted?", $f7
    db $f0

String_83_00_50::
    db $ea, "*: The young people", $f1
    db "these days have no", $fa, $f7
    db $ef, $ee, "sense of gumption!", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Self-pitying", $ef, $ee, "whiners, they are!", $f7
    db $f0

String_83_00_51::
    db $ea, "*: Halt!", $f1
    db "Who goes there?", $fa, $f7
    db $ef, $ee, "I look good as a", $ef, $ee, "guard, don't I?", $f7
    db $f0

String_83_00_52::
    db $ea, "*: I'm terrified of", $f1
    db "monsters!", $fa, $f7
    db $ef, $ee, "Keep them away", $ef, $ee, "from me!", $f7
    db $f0

String_83_00_53::
    db $ea, "*: A soldier has to", $f1
    db "obey orders.", $fa, $f7
    db $ef, $ee, "If soldiers don't", $ef, $ee, "obey, even a", $fa, $f7
    db $ef, $ee, "winnable battle", $ef, $ee, "will be lost.", $fa, $f7
    db $ef, $ee, "Train your party", $ef, $ee, "well so they won't", $fa, $f7
    db $ef, $ee, "rebel against you", $ef, $ee, "in battle.", $f7
    db $f0

String_83_00_54::
    db $ea, "*: Is it really", $f1
    db "possible for", $fa, $f7
    db $ef, $ee, "people to co-exist", $ef, $ee, "with monsters?", $f7
    db $f0

String_83_00_55::
    db $ea, "*: You're not from", $f1
    db "these parts.", $fa, $f7
    db $ef, $ee, "I can tell.", $ef, $ee, "You're a bumpkin.", $f7
    db $f0

String_83_00_56::
    db $ea, "*: Money attracts", $f1
    db "greedy people.", $fa, $f7
    db $ef, $ee, "Keep extra money", $ef, $ee, "in the Vault.", $fa, $f7
    db $ef, $ee, "It will be safe", $ef, $ee, "there.", $f7
    db $f0

String_83_00_57::
    db $ea, "*: I've run into", $f1
    db "dealers while I", $fa, $f7
    db $ef, $ee, "was traveling", $ef, $ee, "about.", $fa, $f7
    db $ef, $ee, "They charge crazy", $ef, $ee, "prices, though.", $f7
    db $f0

String_83_00_58::
    db $ea, "*: I've met other", $f1
    db "travelers with", $fa, $f7
    db $ef, $ee, "monsters in tow", $ef, $ee, "like you.", $fa, $f7
    db $ef, $ee, "They said they", $ef, $ee, "were training.", $f7
    db $f0

String_83_00_59::
    db $ea, "*: Some monsters", $f1
    db "grow slowly when", $fa, $f7
    db $ef, $ee, "they are young,", $ef, $ee, "but watch how they", $fa, $f7
    db $ef, $ee, "grow when they get", $ef, $ee, "older. Wow!", $f7
    db $f0

String_83_00_5A::
    db $ea, "*: Monster families", $f1
    db "have upper limits", $fa, $f7
    db $ef, $ee, "to their growth.", $ef, $ee, "But the limits can", $fa, $f7
    db $ef, $ee, "be raised by", $ef, $ee, "breeding.", $f7
    db $f0

String_83_00_5B::
    db $ea, "Seeds and nuts", $f1
    db "that raise stats", $fa, $f7
    db $ef, $ee, "are invaluable", $ef, $ee, "items.", $fa, $f7
    db $ef, $ee, "On odd occasions,", $ef, $ee, "you'll find them", $fa, $f7
    db $ef, $ee, "as gambling", $ef, $ee, "prizes.", $f7
    db $f0

String_83_00_5C::
    db $ea, "*: There are many", $f1
    db "worlds, and there", $fa, $f7
    db $ef, $ee, "are many people,", $ef, $ee, "both good and bad.", $fa, $f7
    db $ef, $ee, "That's why it's", $ef, $ee, "exciting!", $f7
    db $f0

String_83_00_5D::
    db $ea, "*: I'm only a raw", $f1
    db "recruit, but one", $fa, $f7
    db $ef, $ee, "day, I'm going to", $ef, $ee, "become a hero.", $fa, $f7
    db $ef, $ee, "When that happens,", $ef, $ee, "I'll propose to my", $fa, $f7
    db $ef, $ee, "girl. I wonder if", $ef, $ee, "she'll wait?", $f7
    db $f0

String_83_00_5E::
    db $ea, "*: You can't just", $f1
    db "work on physical", $fa, $f7
    db $ef, $ee, "might. You need to", $ef, $ee, "be sharp mentally", $fa, $f7
    db $ef, $ee, "if you want to do", $ef, $ee, "well in battle.", $f7
    db $f0

String_83_00_5F::
    db $ea, "*: Our King is", $f1
    db "named Al.", $fa, $f7
    db $ef, $ee, "Tell me, have you", $ef, $ee, "MetalKing?", $fa, $f7
    db $ef, $ee, "Whoops, you didn't", $ef, $ee, "find that funny?", $f7
    db $f0

String_83_00_60::
    db $ea, "*: There are no", $f1
    db "human settlements", $fa, $f7
    db $ef, $ee, "around these parts", $ef, $ee, "except here.", $fa, $f7
    db $ef, $ee, "You should rest up", $ef, $ee, "before you leave.", $f7
    db $f0

String_83_00_61::
    db $ea, "*: This is the only", $f1
    db "human settlement", $fa, $f7
    db $ef, $ee, "in these parts.", $ef, $ee, "You might consider", $fa, $f7
    db $ef, $ee, "resting here", $ef, $ee, "before you go.", $f7
    db $f0

String_83_00_62::
    db $ea, "*: There are a few", $f1
    db "other places where", $fa, $f7
    db $ef, $ee, "people live in", $ef, $ee, "these parts.", $fa, $f7
    db $ef, $ee, "Each has different", $ef, $ee, "facilities.", $f7
    db $f0

String_83_00_63::
    db $ea, "*: The merchandise", $f1
    db "of shops varies", $fa, $f7
    db $ef, $ee, "from place to", $ef, $ee, "place.", $f7
    db $f0

String_83_00_64::
    db $ea, "*: Welcome! Good of", $f1
    db "you to come!", $fa, $f7
    db $ef, $ee, "We don't get many", $ef, $ee, "visitors.", $f7
    db $f0

String_83_00_65::
    db $ea, "*: It's dangerous", $f1
    db "out there.", $fa, $f7
    db $ef, $ee, "Get some rest", $ef, $ee, "before you go.", $f7
    db $f0

String_83_00_66::
    db $ea, "*: Uh", $a4, $f1
    db "Um", $a4, $fa, $f7
    db $ef, $ee, "Aren't you afraid", $ef, $ee, "of your monsters?", $f7
    db $f0

String_83_00_67::
    db $ea, "*: If you plan on", $f1
    db "traveling far, you", $fa, $f7
    db $ef, $ee, "should prepare for", $ef, $ee, "any emergency.", $fa, $f7
    db $ef, $ee, "There's no telling", $ef, $ee, "what could happen.", $f7
    db $f0

String_83_00_68::
    db $ea, "*: A LogTwig is", $f1
    db "convenient.", $fa, $f7
    db $ef, $ee, "Leave it anywhere", $ef, $ee, "in the field, and", $fa, $f7
    db $ef, $ee, "you can get to it", $ef, $ee, "with a WarpStaff.", $f7
    db $f0

String_83_00_69::
    db $ea, "*: Teach me how to", $f1
    db "tame monsters.", $fa, $f7
    db $ef, $ee, "I could get them", $ef, $ee, "to cook and clean", $a4, $f7
    db $f0

String_83_00_6A::
    db $ea, "*: You can make", $f1
    db "monsters friendly", $fa, $f7
    db $ef, $ee, "by taking them on", $ef, $ee, "your journeys.", $fa, $f7
    db $ef, $ee, "Feeding them meat", $ef, $ee, "is too costly.", $f7
    db $f0

String_83_00_6B::
    db $ea, "*: Do you know the", $f1
    db "skill Errand?", $fa, $f7
    db $ef, $ee, "You can get a", $ef, $ee, "monster to go do", $fa, $f7
    db $ef, $ee, "some shopping for", $ef, $ee, "you.", $f7
    db $f0

String_83_00_6C::
    db $ea, "*: Have you heard", $f1
    db "of EagleEye?", $fa, $f7
    db $ef, $ee, "It's a skill for", $ef, $ee, "checking your", $fa, $f7
    db $ef, $ee, "surroundings from", $ef, $ee, "a bird's-eye view.", $f7
    db $f0

String_83_00_6D::
    db $ea, "*: Do your monsters", $f1
    db "know Informer?", $fa, $f7
    db $ef, $ee, "It's a skill that", $ef, $ee, "identifies the", $fa, $f7
    db $ef, $ee, "kinds of monsters", $ef, $ee, "in the vicinity.", $f7
    db $f0

String_83_00_6E::
    db $ea, "*: Does any monster", $f1
    db "of yours know the", $fa, $f7
    db $ef, $ee, "skill MapMagic?", $ef, $ee, "It gives you an", $fa, $f7
    db $ef, $ee, "idea about your", $ef, $ee, "surrounding area.", $f7
    db $f0

String_83_00_6F::
    db $ea, "*: You need money", $f1
    db "to buy items.", $fa, $f7
    db $ef, $ee, "But money is hard", $ef, $ee, "to find.", $fa, $f7
    db $ef, $ee, "I guess I have to", $ef, $ee, "sell extra items.", $f7
    db $f0

String_83_00_70::
    db $ea, "*: The slime family", $f1
    db "is tough against", $fa, $f7
    db $ef, $ee, "spells like", $ef, $ee, "Surround and Sap.", $fa, $f7
    db $ef, $ee, "If only they had", $ef, $ee, "higher ATK", $a4, $f7
    db $f0

String_83_00_71::
    db $ea, "*: Dragons are", $f1
    db "fire-resistant.", $fa, $f7
    db $ef, $ee, "If only they grew", $ef, $ee, "a bit faster", $a4, $f7
    db $f0

String_83_00_72::
    db $ea, "*: The beast family", $f1
    db "is very weak to", $fa, $f7
    db $ef, $ee, "attack spells.", $ef, $ee, "On the other hand,", $fa, $f7
    db $ef, $ee, "it has high ATK", $ef, $ee, "and HP.", $f7
    db $f0

String_83_00_73::
    db $ea, "*: Birds are quite", $f1
    db "resistant to such", $fa, $f7
    db $ef, $ee, "spells as Infernos", $ef, $ee, "and Zap.", $fa, $f7
    db $ef, $ee, "They also grow", $ef, $ee, "fast.", $f7
    db $f0

String_83_00_74::
    db $ea, "*: The plant family", $f1
    db "is strong against", $fa, $f7
    db $ef, $ee, "spells like Zap", $ef, $ee, "and Infernos.", $fa, $f7
    db $ef, $ee, "But it's vulnerable", $ef, $ee, "to fire.", $fa, $f7
    db $ef, $ee, "MP gain is high on", $ef, $ee, "leveling up.", $f7
    db $f0

String_83_00_75::
    db $ea, "*: The bug family", $f1
    db "is resistant to", $fa, $f7
    db $ef, $ee, "poison and", $ef, $ee, "paralysis.", $fa, $f7
    db $ef, $ee, "Bugs also grow", $ef, $ee, "fast, so they can", $fa, $f7
    db $ef, $ee, "become useful very", $ef, $ee, "quickly.", $f7
    db $f0

String_83_00_76::
    db $ea, "*: The devil family", $f1
    db "is very resistant", $fa, $f7
    db $ef, $ee, "to all kinds of", $ef, $ee, "attack spells.", $fa, $f7
    db $ef, $ee, "They", $44, " be great if", $ef, $ee, "they didn't get", $fa, $f7
    db $ef, $ee, "poisoned or fall", $ef, $ee, "asleep easily.", $f7
    db $f0

String_83_00_77::
    db $ea, "*: Zombies are", $f1
    db "virtually unharmed", $fa, $f7
    db $ef, $ee, "by death spells or", $ef, $ee, "curses.", $fa, $f7
    db $ef, $ee, "On the other hand,", $ef, $ee, "they are easily", $fa, $f7
    db $ef, $ee, "affected by fire", $ef, $ee, "and WarCry", $a4, $f7
    db $f0

String_83_00_78::
    db $ea, "*: There are many", $f1
    db "kinds of material", $fa, $f7
    db $ef, $ee, "family monsters.", $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "It's impossible to", $ef, $ee, "describe their", $fa, $f7
    db $ef, $ee, "good points in one", $ef, $ee, "breath.", $f7
    db $f0

String_83_00_79::
    db $ea, "*: Water family", $f1
    db "monsters are very", $fa, $f7
    db $ef, $ee, "tough against fire", $ef, $ee, "and water skills.", $fa, $f7
    db $ef, $ee, "There isn't one", $ef, $ee, "that really stands", $fa, $f7
    db $ef, $ee, "out, but they can", $ef, $ee, "be quite useful.", $f7
    db $f0

String_83_00_7A::
    db $ea, "*: Have you met any", $f1
    db "Demon Lords?", $fa, $f7
    db $ef, $ee, "They make nasty", $ef, $ee, "enemies, but if", $fa, $f7
    db $ef, $ee, "you could get them", $ef, $ee, "on your side", $a4, $f7
    db $f0

String_83_00_7B::
    db $ea, "*: It's getting", $f1
    db "mean out there.", $fa, $f7
    db $ef, $ee, "Strangers may want", $ef, $ee, "to battle you.", $f7
    db $f0

String_83_00_7C::
    db $ea, "*: Skills that", $f1
    db "induce sleep or", $fa, $f7
    db $ef, $ee, "paralysis are very", $ef, $ee, "effective.", $fa, $f7
    db $ef, $ee, "But watch out,", $ef, $ee, "some monsters are", $fa, $f7
    db $ef, $ee, "impervious to", $ef, $ee, "them.", $f7
    db $f0

String_83_00_7D::
    db $ea, "*: Have you seen", $f1
    db "any metallic kinds", $fa, $f7
    db $ef, $ee, "of slime monsters?", $ef, $ee, "They're worth a", $fa, $f7
    db $ef, $ee, "huge amount of EX", $ef, $ee, "points.", $f7
    db $f0

String_83_00_7E::
    db $ea, "*: My grandpa told", $f1
    db "me that if you see", $fa, $f7
    db $ef, $ee, "a bard, you're in", $ef, $ee, "luck.", $f7
    db $f0

String_83_00_7F::
    db $ea, "*: Have you seen a", $f1
    db "Gold Pass?", $fa, $f7
    db $ef, $ee, "It's expensive,", $ef, $ee, "but it gives you", $fa, $f7
    db $ef, $ee, "discounts at any", $ef, $ee, "shop.", $f7
    db $f0

String_83_00_80::
    db $eb, "*: In the deepest", $f1
    db "part of a cave,", $fa, $f7
    db $ef, $ee, "a monster boss", $ef, $ee, "makes its throne.", $fa, $f7
    db $ef, $ee, "It reigns over", $ef, $ee, "other monsters.", $f7
    db $f0

String_83_00_81::
    db $eb, "*: At the top of a", $f1
    db "tower, you'll find", $fa, $f7
    db $ef, $ee, "a monster boss on", $ef, $ee, "its throne.", $fa, $f7
    db $ef, $ee, "It reigns over", $ef, $ee, "other monsters.", $f7
    db $f0

String_83_00_82::
    db $eb, "*: I hear that", $f1
    db "there's a monster", $fa, $f7
    db $ef, $ee, "boss in a castle", $ef, $ee, "somewhere.", $fa, $f7
    db $ef, $ee, "It reigns over", $ef, $ee, "other monsters.", $f7
    db $f0

String_83_00_83::
    db $eb, "*: Treasure chests", $f1
    db "are hidden in", $fa, $f7
    db $ef, $ee, "caves and towers,", $ef, $ee, "I've heard.", $fa, $f7
    db $ef, $ee, "They must contain", $ef, $ee, "amazing treasures!", $f7
    db $f0

String_83_00_84::
    db $eb, "*: Oh, you must be", $f1
    db "a traveler.", $fa, $f7
    db $ef, $ee, "There isn't much", $ef, $ee, "here, but it is", $fa, $f7
    db $ef, $ee, "a nice place to", $ef, $ee, "rest up.", $f7
    db $f0

String_83_00_85::
    db $eb, "*: You may find", $f1
    db "things in the", $fa, $f7
    db $ef, $ee, "oddest places.", $ef, $ee, "You have to look.", $f7
    db $f0

String_83_00_86::
    db $eb, "*: Now, where's my", $f1
    db "husband wandering?", $fa, $f7
    db $ef, $ee, "I send him out on", $ef, $ee, "a simple errand", $a4, $fa, $f7
    db $ef, $ee, "It's beyond belief,", $ef, $ee, "let me tell you!", $f7
    db $f0

String_83_00_87::
    db $eb, "*: What to make for", $f1
    db "supper", $a4, $f7
    db $f0

String_83_00_88::
    db $eb, "*: Oh my!", $f1
    db "What delicious", $a4, $fa, $f7
    db $ef, $ee, "I mean cute! Yes,", $ef, $ee, "cute, monsters!", $f7
    db $f0

String_83_00_89::
    db $eb, "*: I wish my boy", $f1
    db "was as mature as", $fa, $f7
    db $ef, $ee, "you, but he's just", $ef, $ee, "so rambunctious.", $fa, $f7
    db $ef, $ee, "I can't let him", $ef, $ee, "out of sight.", $f7
    db $f0

String_83_00_8A::
    db $eb, "*: Look at your", $f1
    db "dirty clothes!", $fa, $f7
    db $ef, $ee, "Are you washing", $ef, $ee, "them properly?", $f7
    db $f0

String_83_00_8B::
    db $eb, "*: Our children", $f1
    db "grow like weeds.", $fa, $f7
    db $ef, $ee, "You should see how", $ef, $ee, "much they eat.", $f7
    db $f0

String_83_00_8C::
    db $eb, "*: That man there", $f1
    db "keeps staring.", $fa, $f7
    db $ef, $ee, "Does he think I'm", $ef, $ee, "strange?", $f7
    db $f0

String_83_00_8D::
    db $eb, "*: Oh, aren't you", $f1
    db "cute!", $fa, $f7
    db $ef, $ee, "And your monsters", $ef, $ee, "are adorable too!", $f7
    db $f0

String_83_00_8E::
    db $eb, "*: It would be so", $f1
    db "nice to be able to", $fa, $f7
    db $ef, $ee, "cross the sea or", $ef, $ee, "fly.", $fa, $f7
    db $ef, $ee, "If I could, I", $ef, $ee, "would go see my", $fa, $f7
    db $ef, $ee, "boyfriend whenever", $ef, $ee, "I wanted.", $f7
    db $f0

String_83_00_8F::
    db $eb, "*: I wish I had a", $f1
    db "sibling like you.", $f7
    db $f0

String_83_00_90::
    db $eb, "*: My boy is a", $f1
    db "dirt magnet!", $fa, $f7
    db $ef, $ee, "I can't keep up", $ef, $ee, "with the wash!", $f7
    db $f0

String_83_00_91::
    db $eb, "*: ", $a4, "Sigh", $a4, " When will", $f1
    db "he come back?", $fa, $f7
    db $ef, $ee, "He hasn't written", $ef, $ee, "once, the clod!", $f7
    db $f0

String_83_00_92::
    db $eb, "*: Is it safe alone", $f1
    db "like that?", $fa, $f7
    db $ef, $ee, "Don't break your", $ef, $ee, "parents' hearts!", $f7
    db $f0

String_83_00_93::
    db $eb, "*: Monsters have", $f1
    db "personalities that", $fa, $f7
    db $ef, $ee, "determine how they", $ef, $ee, "behave.", $f7
    db $f0

String_83_00_94::
    db $eb, "*: I thought", $f1
    db "monsters were", $fa, $f7
    db $ef, $ee, "frightful things,", $ef, $ee, "but the ones you", $fa, $f7
    db $ef, $ee, "have all look", $ef, $ee, "cheerful.", $f7
    db $f0

String_83_00_95::
    db $eb, "*: You're on a", $f1
    db "journey with", $fa, $f7
    db $ef, $ee, "monsters?", $ef, $ee, "I'm impressed.", $f7
    db $f0

String_83_00_96::
    db $eb, "*: I pack lightly", $f1
    db "for a journey.", $fa, $f7
    db $ef, $ee, "A WarpWing and a", $ef, $ee, "Bookmark-", $fa, $f7
    db $ef, $ee, "those are basic.", $ef, $ee, "After these two,", $fa, $f7
    db $ef, $ee, "I take the bare", $ef, $ee, "minimum, so I can", $fa, $f7
    db $ef, $ee, "pick up more items", $ef, $ee, "that I find.", $f7
    db $f0

String_83_00_97::
    db $eb, "*: I love squishy", $f1
    db "monsters!", $fa, $f7
    db $ef, $ee, "They look so", $ef, $ee, "appetizing!", $fa, $f7
    db $ef, $ee, "I'm joking!", $ef, $ee, "Don't be scared!", $f7
    db $f0

String_83_00_98::
    db $eb, "*: How do monsters", $f1
    db "live in the wild?", $fa, $f7
    db $ef, $ee, "We don't know much", $ef, $ee, "about them.", $f7
    db $f0

String_83_00_99::
    db $eb, "*: The FriendStaff", $f1
    db "works exactly like", $fa, $f7
    db $ef, $ee, "the spell TwinHits", $ef, $ee, "in battle.", $fa, $f7
    db $ef, $ee, "It will definitely", $ef, $ee, "come in handy.", $f7
    db $f0

String_83_00_9A::
    db $eb, "*: The MistStaff", $f1
    db "does the same work", $fa, $f7
    db $ef, $ee, "as the spell", $ef, $ee, "StopSpell.", $fa, $f7
    db $ef, $ee, "Use it to silence", $ef, $ee, "spell-casters.", $f7
    db $f0

String_83_00_9B::
    db $eb, "*: You can attack", $f1
    db "monsters using", $fa, $f7
    db $ef, $ee, "the powers of", $ef, $ee, "certain staves.", $fa, $f7
    db $ef, $ee, "But monsters won't", $ef, $ee, "like you for it.", $f7
    db $f0

String_83_00_9C::
    db $eb, "*: BadMeat acts", $f1
    db "like poison.", $fa, $f7
    db $ef, $ee, "Don't feed it to", $ef, $ee, "your monsters,", $fa, $f7
    db $ef, $ee, "but it works on", $ef, $ee, "enemies well.", $f7
    db $f0

String_83_00_9D::
    db $eb, "*: Repellent keeps", $f1
    db "monsters away.", $fa, $f7
    db $ef, $ee, "The Shiny Harp", $ef, $ee, "does the opposite.", $f7
    db $f0

String_83_00_9E::
    db $eb, "*: How adorable!", $f1
    db "How would you like", $fa, $f7
    db $ef, $ee, "a nice powderpuff", $ef, $ee, "massage?", $fa, $f7
    db $ef, $ee, "Oh? Not you.", $ef, $ee, "I love monsters!", $f7
    db $f0

String_83_00_9F::
    db $eb, "*: Have you heard", $f1
    db "about the great", $fa, $f7
    db $ef, $ee, "master tamer?", $ef, $ee, "He's amazing.", $fa, $f7
    db $ef, $ee, "He's named Terry.", $ef, $ee, "He's still young!", $f7
    db $f0

String_83_00_A0::
    db $ea, "*: Magic Keys are", $f1
    db "indeed magical.", $fa, $f7
    db $ef, $ee, "It's magical how", $ef, $ee, "they lead to", $fa, $f7
    db $ef, $ee, "different worlds", $ef, $ee, "we don't know.", $f7
    db $f0

String_83_00_A1::
    db $ea, "*: If something is", $f1
    db "rare or valuable", $a4, $fa, $f7
    db $ef, $ee, "You", $44, " never leave", $ef, $ee, "it in plain sight.", $f7
    db $f0

String_83_00_A2::
    db $ea, "*: Caves and towers", $f1
    db "teem with danger!", $fa, $f7
    db $ef, $ee, "Going in is only", $ef, $ee, "half the job.", $fa, $f7
    db $ef, $ee, "You have to get", $ef, $ee, "yourself back out!", $f7
    db $f0

String_83_00_A3::
    db $ea, "*: A treasure chest", $f1
    db "holds one item.", $f7
    db $f0

String_83_00_A4::
    db $ea, "*: Ah, I can't", $f1
    db "recall seeing a", $fa, $f7
    db $ef, $ee, "cuter visitor than", $ef, $ee, "you, dear child.", $fa, $f7
    db $ef, $ee, "Do take the time", $ef, $ee, "to relax here.", $f7
    db $f0

String_83_00_A5::
    db $ea, "*: If you're ever", $f1
    db "in need of help,", $fa, $f7
    db $ef, $ee, "be sure to come", $ef, $ee, "back here.", $f7
    db $f0

String_83_00_A6::
    db $ea, "*: Other worlds,", $f1
    db "you say?", $fa, $f7
    db $ef, $ee, "I", $44, " like to go", $ef, $ee, "somewhere", $a4, $f7
    db $f0

String_83_00_A7::
    db $ea, "*: So good of you", $f1
    db "to visit us at", $fa, $f7
    db $ef, $ee, "this distant and", $ef, $ee, "forgotten outpost.", $fa, $f7
    db $ef, $ee, "There is nothing", $ef, $ee, "here at all.", $fa, $f7
    db $ef, $ee, "But feel free to", $ef, $ee, "stay as long as", $fa, $f7
    db $ef, $ee, "you wish.", $ef, $ee, $f7
    db $f0

String_83_00_A8::
    db $ea, "*: Ah, you're such", $f1
    db "a cute cherub!", $fa, $f7
    db $ef, $ee, "You look exactly", $ef, $ee, "as my son did.", $fa, $f7
    db $ef, $ee, "Wait! Are you my", $ef, $ee, "grandchild?", $f7
    db $f0

String_83_00_A9::
    db $ea, "*: Hah? You have", $f1
    db "tamed monsters?", $fa, $f7
    db $ef, $ee, "You're to be", $ef, $ee, "commended!", $fa, $f7
    db $ef, $ee, "I did the same", $ef, $ee, "when I was young", $a4, $f7
    db $f0

String_83_00_AA::
    db $ea, "*: If something", $f1
    db "comes easily,", $fa, $f7
    db $ef, $ee, "one is apt to not", $ef, $ee, "realize its worth.", $fa, $f7
    db $ef, $ee, "When you do, it's", $ef, $ee, "usually been lost", $a4, $f7
    db $f0

String_83_00_AB::
    db $ea, "*: If you wish to", $f1
    db "meet travelers", $fa, $f7
    db $ef, $ee, "like yourself, you", $ef, $ee, "must walk.", $fa, $f7
    db $ef, $ee, "You'll get to see", $ef, $ee, "them, by and by.", $f7
    db $f0

String_83_00_AC::
    db $ea, "*: When I was your", $f1
    db "age, I admit I was", $fa, $f7
    db $ef, $ee, "a mischievous lad,", $ef, $ee, "if I may say so.", $fa, $f7
    db $ef, $ee, "I remember those", $ef, $ee, "days clearly", $a4, $f7
    db $f0

String_83_00_AD::
    db $ea, "*: I take my walk", $f1
    db "on the same route", $fa, $f7
    db $ef, $ee, "every day. I never", $ef, $ee, "go anywhere else.", $fa, $f7
    db $ef, $ee, "But, like the way", $ef, $ee, "I met you today,", $fa, $f7
    db $ef, $ee, "there is always a", $ef, $ee, "new discovery.", $f7
    db $f0

String_83_00_AE::
    db $ea, "*: My eyesight isn't", $f1
    db "what it once was.", $fa, $f7
    db $ef, $ee, "But my nose works", $ef, $ee, "quite fine.", $fa, $f7
    db $ef, $ee, "The friends behind", $ef, $ee, "you desperately", $fa, $f7
    db $ef, $ee, "need a bath, I can", $ef, $ee, "tell that much.", $f7
    db $f0

String_83_00_AF::
    db $ea, "*: Ah-ha, you're", $f1
    db "such a cute child!", $fa, $f7
    db $ef, $ee, "About a tenth of", $ef, $ee, "the cuteness of my", $fa, $f7
    db $ef, $ee, "grandchildren, I", $ef, $ee, "would think.", $f7
    db $f0

String_83_00_B0::
    db $ea, "*: I was a fine-", $f1
    db "looking fellow", $fa, $f7
    db $ef, $ee, "with many lady", $ef, $ee, "friends.", $fa, $f7
    db $ef, $ee, "Not that you could", $ef, $ee, "tell from this", $fa, $f7
    db $ef, $ee, "wrinkled old sack", $ef, $ee, "of bones!", $f7
    db $f0

String_83_00_B1::
    db $ea, "*: A monster can", $f1
    db "equip a single", $fa, $f7
    db $ef, $ee, "accessory, and no", $ef, $ee, "more.", $fa, $f7
    db $ef, $ee, "If you equip", $ef, $ee, "another one, the", $fa, $f7
    db $ef, $ee, "old one is taken", $ef, $ee, "off.", $f7
    db $f0

String_83_00_B2::
    db $ea, "*: If someone asks", $f1
    db "you to mate some", $fa, $f7
    db $ef, $ee, "monsters, be quick", $ef, $ee, "to accept.", $fa, $f7
    db $ef, $ee, "Traveling masters", $ef, $ee, "don't stay long.", $f7
    db $f0

String_83_00_B3::
    db $ea, "*: Hm, when I was", $f1
    db "young, I must say", $fa, $f7
    db $ef, $ee, "that I was foolish", $ef, $ee, "and reckless.", $fa, $f7
    db $ef, $ee, "To see someone as", $ef, $ee, "young as you", $fa, $f7
    db $ef, $ee, "traveling with", $ef, $ee, "monsters", $a4, $fa, $f7
    db $ef, $ee, "You're nothing if", $ef, $ee, "not reckless!", $f7
    db $f0

String_83_00_B4::
    db $ea, "*: If you see a", $f1
    db "fellow traveler,", $fa, $f7
    db $ef, $ee, "talk to him or her", $ef, $ee, "right away.", $fa, $f7
    db $ef, $ee, "They'll wander off", $ef, $ee, "if you don't.", $f7
    db $f0

String_83_00_B5::
    db $ea, "*: I see something", $f1
    db "in your eyes", $a4, $fa, $f7
    db $ef, $ee, "I get the feeling", $ef, $ee, "that you're going", $fa, $f7
    db $ef, $ee, "to do something", $ef, $ee, "extraordinary.", $f7
    db $f0

String_83_00_B6::
    db $ea, "*: The personality", $f1
    db "of a monster gets", $fa, $f7
    db $ef, $ee, "changed by your", $ef, $ee, "battle plans.", $fa, $f7
    db $ef, $ee, "If you don't train", $ef, $ee, "it properly, it", $fa, $f7
    db $ef, $ee, "may not battle", $ef, $ee, "effectively.", $f7
    db $f0

String_83_00_B7::
    db $ea, "*: If a monster is", $f1
    db "made to 'Charge", $95, $fa, $f7
    db $ef, $ee, "all the time, it", $ef, $ee, "will become more", $fa, $f7
    db $ef, $ee, "brave, but less", $ef, $ee, "sensible.", $f7
    db $f0

String_83_00_B8::
    db $ea, "*: If a monster is", $f1
    db "given a 'Mixed", $95, $fa, $f7
    db $ef, $ee, "plan, it becomes", $ef, $ee, "more sensible.", $fa, $f7
    db $ef, $ee, "But it also turns", $ef, $ee, "less kindly.", $f7
    db $f0

String_83_00_B9::
    db $ea, "*: If a monster is", $f1
    db "ordered to use", $fa, $f7
    db $ef, $ee, "'Defense' in", $ef, $ee, "battle, it will", $fa, $f7
    db $ef, $ee, "turn increasingly", $ef, $ee, "compassionate.", $fa, $f7
    db $ef, $ee, "But, it also turns", $ef, $ee, "less brave.", $f7
    db $f0

String_83_00_BA::
    db $ea, "*: If a monster's", $f1
    db "personality is", $fa, $f7
    db $ef, $ee, "'Coward' or 'EZ", $ef, $ee, "going', it's not", $fa, $f7
    db $ef, $ee, "really suitable", $ef, $ee, "for attacking.", $f7
    db $f0

String_83_00_BB::
    db $ea, "*: If a monster's", $f1
    db "personality is", $fa, $f7
    db $ef, $ee, "'Daredevil' or", $ef, $ee, "'Carefree', it's", $fa, $f7
    db $ef, $ee, "not good in a", $ef, $ee, "supporting role.", $f7
    db $f0

String_83_00_BC::
    db $ea, "*: If a monster's", $f1
    db "personality is", $fa, $f7
    db $ef, $ee, "'Snobby' or", $ef, $ee, "'Spoiled', don't", $fa, $f7
    db $ef, $ee, "expect it to make", $ef, $ee, "a good healer.", $f7
    db $f0

String_83_00_BD::
    db $ea, "*: A monster's", $f1
    db "personality is an", $fa, $f7
    db $ef, $ee, "important factor", $ef, $ee, "in battle.", $fa, $f7
    db $ef, $ee, "Be sure to check", $ef, $ee, "them in advance.", $f7
    db $f0

String_83_00_BE::
    db $ea, "*: I see a dark", $f1
    db "shadow casting its", $fa, $f7
    db $ef, $ee, "pall over your", $ef, $ee, "monsters", $a4, $fa, $f7
    db $ef, $ee, "It appears to be", $ef, $ee, "an evil sign.", $fa, $f7
    db $ef, $ee, "Don't push them", $ef, $ee, "too hard.", $f7
    db $f0

String_83_00_BF::
    db $ea, "*: Just pushing me", $f1
    db "won't budge me!", $f7
    db $f0

String_83_00_C0::
    db $ea, "*: The personality", $f1
    db "of a monster", $fa, $f7
    db $ef, $ee, "changes depending", $ef, $ee, "on battle plans.", $fa, $f7
    db $ef, $ee, "I bet you didn't", $ef, $ee, "know that.", $f7
    db $f0

String_83_00_C1::
    db $ea, "*: Seeds and nuts", $f1
    db "can raise monster", $fa, $f7
    db $ef, $ee, "stats even if they", $ef, $ee, "can't level up.", $fa, $f7
    db $ef, $ee, "I bet you didn't", $ef, $ee, "know that.", $f7
    db $f0

String_83_00_C2::
    db $ea, "*: How quickly", $f1
    db "monsters level up", $fa, $f7
    db $ef, $ee, "varies from family", $ef, $ee, "to family.", $fa, $f7
    db $ef, $ee, "I bet you didn't", $ef, $ee, "know that.", $f7
    db $f0

String_83_00_C3::
    db $ea, "*: Monster families", $f1
    db "have different", $fa, $f7
    db $ef, $ee, "resistance levels", $ef, $ee, "to spell types.", $fa, $f7
    db $ef, $ee, "Some are tough", $ef, $ee, "against fire, and", $fa, $f7
    db $ef, $ee, "weak to water, for", $ef, $ee, "instance.", $f7
    db $f0

String_83_00_C4::
    db $ea, "*: A monster marked", $f1
    db "with a ", $ac, " won't grow", $fa, $f7
    db $ef, $ee, "anymore. Its level", $ef, $ee, "is maxed out.", $fa, $f7
    db $ef, $ee, "I bet you didn't", $ef, $ee, "know that.", $f7
    db $f0

String_83_00_C5::
    db $ea, "*: You've seen your", $f1
    db "monsters score", $fa, $f7
    db $ef, $ee, "critical hits,", $ef, $ee, "right?", $fa, $f7
    db $ef, $ee, "There's a family", $ef, $ee, "that gets more", $fa, $f7
    db $ef, $ee, "critical hits than", $ef, $ee, "others.", $f7
    db $f0

String_83_00_C6::
    db $ea, "*: Y-your monsters", $f1
    db "are staring at me", $a4, $fa, $f7
    db $ef, $ee, "And", $a4, " And they're", $ef, $ee, "drooling!", $f7
    db $f0
    ds $a7, $00
