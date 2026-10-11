SECTION "Bank 83", ROMX[$4000], BANK[$83]
    db $83

; message bank $83: when wStringIndex < $C7, BeginStringDisplay with this bank's table Data_083_4032; otherwise far-calls Func_097_4070 (E-0080)
; 2 call sites from 2 routines (e.g. DebugMessageTest_Update_Case12, Func_010_4AD0_Case0D)
; reads: wStringIndex
BeginStringDisplay_Bank83::
Func_083_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $C7
    jr c, Jump_083_400F
    farcall BeginStringDisplay_Bank83_Overflow
    ret

Jump_083_400F::
    ld de, MessageStrings_Bank83
    call BeginStringDisplay
    ret

; message bank $83: when wStringIndex < $C7, CopyStringToBuffer with this bank's table Data_083_4032; otherwise far-calls Func_097_407F (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank83:: ; heuristic: follows a terminator; C0
Func_083_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $C7
    jr c, Jump_083_4024
    farcall CopyStringToBuffer_Bank83_Overflow
    ret

Jump_083_4024::
    ld de, MessageStrings_Bank83
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_83_4032::
MessageStrings_Bank83:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_083_4032:: ; address name
    dw StringList_83_4034 ; id 0

; E-0217 (derived: category list of StringCategories_83_4032; one pointer per wStringIndex)
; record: string
StringList_83_4034::
Data_083_4034:: ; address name
    dw Data_083_41C2 ; id 0
    dw Data_083_41C2 ; id 1
    dw Data_083_41C2 ; id 2
    dw Data_083_41C2 ; id 3
    dw Data_083_41C2 ; id 4
    dw Data_083_41C2 ; id 5
    dw Data_083_41C2 ; id 6
    dw Data_083_41C2 ; id 7
    dw Data_083_41C2 ; id 8
    dw Data_083_41C2 ; id 9
    dw Data_083_41C2 ; id 10
    dw Data_083_41C2 ; id 11
    dw Data_083_41C2 ; id 12
    dw Data_083_41C2 ; id 13
    dw Data_083_41C2 ; id 14
    dw Data_083_41C2 ; id 15
    dw Data_083_41C2 ; id 16
    dw Data_083_41C2 ; id 17
    dw Data_083_41C2 ; id 18
    dw Data_083_41C2 ; id 19
    dw Data_083_41C2 ; id 20
    dw Data_083_41C2 ; id 21
    dw Data_083_41C2 ; id 22
    dw Data_083_41C2 ; id 23
    dw Data_083_41C2 ; id 24
    dw Data_083_41C2 ; id 25
    dw Data_083_41C2 ; id 26
    dw Data_083_41C2 ; id 27
    dw Data_083_41C2 ; id 28
    dw Data_083_41C2 ; id 29
    dw Data_083_41C2 ; id 30
    dw Data_083_41C2 ; id 31
    dw Data_083_41C2 ; id 32
    dw Data_083_4229 ; id 33
    dw Data_083_4229 ; id 34
    dw Data_083_426E ; id 35
    dw Data_083_42C0 ; id 36
    dw Data_083_4307 ; id 37
    dw Data_083_438C ; id 38
    dw Data_083_43C5 ; id 39
    dw Data_083_43C5 ; id 40
    dw Data_083_4424 ; id 41
    dw Data_083_446C ; id 42
    dw Data_083_44B2 ; id 43
    dw Data_083_4512 ; id 44
    dw Data_083_455F ; id 45
    dw Data_083_45BB ; id 46
    dw Data_083_462C ; id 47
    dw Data_083_4697 ; id 48
    dw Data_083_46D9 ; id 49
    dw Data_083_471A ; id 50
    dw Data_083_473A ; id 51
    dw Data_083_478E ; id 52
    dw Data_083_47DA ; id 53
    dw Data_083_4828 ; id 54
    dw Data_083_4876 ; id 55
    dw Data_083_48B7 ; id 56
    dw Data_083_4929 ; id 57
    dw Data_083_496A ; id 58
    dw Data_083_49D7 ; id 59
    dw Data_083_4A2A ; id 60
    dw Data_083_4A4B ; id 61
    dw Data_083_4A78 ; id 62
    dw Data_083_4AF5 ; id 63
    dw Data_083_4B3C ; id 64
    dw Data_083_4B61 ; id 65
    dw Data_083_4BA6 ; id 66
    dw Data_083_4C15 ; id 67
    dw Data_083_4C88 ; id 68
    dw Data_083_4CD4 ; id 69
    dw Data_083_4D3C ; id 70
    dw Data_083_4D3C ; id 71
    dw Data_083_4D74 ; id 72
    dw Data_083_4E18 ; id 73
    dw Data_083_4E79 ; id 74
    dw Data_083_4EE4 ; id 75
    dw Data_083_4F6A ; id 76
    dw Data_083_4FA7 ; id 77
    dw Data_083_500F ; id 78
    dw Data_083_5052 ; id 79
    dw Data_083_50B6 ; id 80
    dw Data_083_511B ; id 81
    dw Data_083_5159 ; id 82
    dw Data_083_5193 ; id 83
    dw Data_083_5241 ; id 84
    dw Data_083_5285 ; id 85
    dw Data_083_52C6 ; id 86
    dw Data_083_5326 ; id 87
    dw Data_083_5386 ; id 88
    dw Data_083_53E7 ; id 89
    dw Data_083_5454 ; id 90
    dw Data_083_54BE ; id 91
    dw Data_083_5538 ; id 92
    dw Data_083_55A1 ; id 93
    dw Data_083_5633 ; id 94
    dw Data_083_56A5 ; id 95
    dw Data_083_5707 ; id 96
    dw Data_083_5777 ; id 97
    dw Data_083_57E4 ; id 98
    dw Data_083_584E ; id 99
    dw Data_083_588B ; id 100
    dw Data_083_58CC ; id 101
    dw Data_083_590A ; id 102
    dw Data_083_593D ; id 103
    dw Data_083_59B2 ; id 104
    dw Data_083_5A1F ; id 105
    dw Data_083_5A6A ; id 106
    dw Data_083_5AD7 ; id 107
    dw Data_083_5B37 ; id 108
    dw Data_083_5BA1 ; id 109
    dw Data_083_5C10 ; id 110
    dw Data_083_5C81 ; id 111
    dw Data_083_5CE9 ; id 112
    dw Data_083_5D52 ; id 113
    dw Data_083_5D96 ; id 114
    dw Data_083_5DFD ; id 115
    dw Data_083_5E5C ; id 116
    dw Data_083_5EE9 ; id 117
    dw Data_083_5F6B ; id 118
    dw Data_083_5FFE ; id 119
    dw Data_083_6088 ; id 120
    dw Data_083_6108 ; id 121
    dw Data_083_61A1 ; id 122
    dw Data_083_620C ; id 123
    dw Data_083_6252 ; id 124
    dw Data_083_62D1 ; id 125
    dw Data_083_633A ; id 126
    dw Data_083_637C ; id 127
    dw Data_083_63DA ; id 128
    dw Data_083_6445 ; id 129
    dw Data_083_64B0 ; id 130
    dw Data_083_6514 ; id 131
    dw Data_083_6580 ; id 132
    dw Data_083_65E1 ; id 133
    dw Data_083_6625 ; id 134
    dw Data_083_669A ; id 135
    dw Data_083_66B7 ; id 136
    dw Data_083_66F8 ; id 137
    dw Data_083_6763 ; id 138
    dw Data_083_67A6 ; id 139
    dw Data_083_67EE ; id 140
    dw Data_083_682E ; id 141
    dw Data_083_686E ; id 142
    dw Data_083_68F1 ; id 143
    dw Data_083_6916 ; id 144
    dw Data_083_6955 ; id 145
    dw Data_083_699D ; id 146
    dw Data_083_69E2 ; id 147
    dw Data_083_6A26 ; id 148
    dw Data_083_6A85 ; id 149
    dw Data_083_6ABD ; id 150
    dw Data_083_6B6E ; id 151
    dw Data_083_6BC7 ; id 152
    dw Data_083_6C0F ; id 153
    dw Data_083_6C7E ; id 154
    dw Data_083_6CE4 ; id 155
    dw Data_083_6D4F ; id 156
    dw Data_083_6DB2 ; id 157
    dw Data_083_6DFB ; id 158
    dw Data_083_6E61 ; id 159
    dw Data_083_6EC9 ; id 160
    dw Data_083_6F30 ; id 161
    dw Data_083_6F7E ; id 162
    dw Data_083_6FEF ; id 163
    dw Data_083_7014 ; id 164
    dw Data_083_707F ; id 165
    dw Data_083_70C1 ; id 166
    dw Data_083_70F9 ; id 167
    dw Data_083_7199 ; id 168
    dw Data_083_7200 ; id 169
    dw Data_083_7262 ; id 170
    dw Data_083_72D2 ; id 171
    dw Data_083_733C ; id 172
    dw Data_083_73AE ; id 173
    dw Data_083_7448 ; id 174
    dw Data_083_74DF ; id 175
    dw Data_083_754D ; id 176
    dw Data_083_75D0 ; id 177
    dw Data_083_7649 ; id 178
    dw Data_083_76B6 ; id 179
    dw Data_083_7763 ; id 180
    dw Data_083_77CB ; id 181
    dw Data_083_7837 ; id 182
    dw Data_083_78C5 ; id 183
    dw Data_083_792E ; id 184
    dw Data_083_7999 ; id 185
    dw Data_083_7A25 ; id 186
    dw Data_083_7A8D ; id 187
    dw Data_083_7AF4 ; id 188
    dw Data_083_7B5A ; id 189
    dw Data_083_7BC1 ; id 190
    dw Data_083_7C42 ; id 191
    dw Data_083_7C65 ; id 192
    dw Data_083_7CCC ; id 193
    dw Data_083_7D36 ; id 194
    dw Data_083_7D99 ; id 195
    dw Data_083_7E29 ; id 196
    dw Data_083_7E95 ; id 197
    dw Data_083_7F14 ; id 198

Data_083_41C2:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am the King of", $F1
    db "this Kingdom!", $FA, $F7
    db $EF, $EE, "I'm busy, as you", $EF, $EE, "can see!", $FA, $F7
    db $EF, $EE, "Begone, if you", $42, "e", $EF, $EE, "no business here!", $F7
    db $F0

Data_083_4229:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's safe in the", $F1
    db "Castle.", $FA, $F7
    db $EF, $EE, "A priest can tend", $EF, $EE, "to your party too.", $F7
    db $F0

Data_083_426E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We get many", $F1
    db "visitors from", $FA, $F7
    db $EF, $EE, "other worlds.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "I can guess why", $EF, $EE, "you're here.", $F7
    db $F0

Data_083_42C0:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your journey is", $F1
    db "a pilgrimage?", $FA, $F7
    db $EF, $EE, "That's impressive,", $EF, $EE, "my dear child!", $F7
    db $F0

Data_083_4307:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " To attract wild", $F1
    db "monsters, you must", $FA, $F7
    db $EF, $EE, "not alarm them.", $EF, $EE, "Healing your own", $FA, $F7
    db $EF, $EE, "monsters will make", $EF, $EE, "wild opponents", $FA, $F7
    db $EF, $EE, "mistrust you.", $EF, $EE, $F7
    db $F0

Data_083_438C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " K-keep monsters", $F1
    db "away from me!", $FA, $F7
    db $EF, $EE, "They frighten me!", $EF, $EE, $F7
    db $F0

Data_083_43C5:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The people here", $F1
    db "live in peace.", $FA, $F7
    db $EF, $EE, "We don't want", $EF, $EE, "outsiders to bring", $FA, $F7
    db $EF, $EE, "in their problems.", $EF, $EE, $F7
    db $F0

Data_083_4424:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e some odd", $F1
    db "monsters there.", $FA, $F7
    db $EF, $EE, "Where did you get", $EF, $EE, "them? Tell me!", $F7
    db $F0

Data_083_446C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Actually, if I", $F1
    db "wasn't the king,", $FA, $F7
    db $EF, $EE, "I may have left to", $EF, $EE, "travel too", $A4, $F7
    db $F0

Data_083_44B2:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I like the", $F1
    db "atmosphere here.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " rather you", $EF, $EE, "didn't bring in", $FA, $F7
    db $EF, $EE, "any problems from", $EF, $EE, "outside.", $F7
    db $F0

Data_083_4512:: ; heuristic: string; C0
    db $EA, $45, $90, $A4, $23, $3D, $3D, $3D, $A4, $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hah? What?", $F1
    db "Excuse me!", $FA, $F7
    db $EF, $EE, "I", $42, "e been so busy", $EF, $EE, "of late, you see.", $F7
    db $F0

Data_083_455F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You look to be a", $F1
    db "genius at handling", $FA, $F7
    db $EF, $EE, "monsters.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "I suppose that", $EF, $EE, "makes them safe.", $F7
    db $F0

Data_083_45BB:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you have no", $F1
    db "meat when you see", $FA, $F7
    db $EF, $EE, "a monster you want", $EF, $EE, "to get, giving", $FA, $F7
    db $EF, $EE, "them Herbs will", $EF, $EE, "earn their trust.", $F7
    db $F0

Data_083_462C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster", $F1
    db "grows slowly, you", $FA, $F7
    db $EF, $EE, "ought to consider", $EF, $EE, "taking it alone.", $FA, $F7
    db $EF, $EE, "It will earn more", $EF, $EE, "EX points.", $F7
    db $F0

Data_083_4697:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are some", $F1
    db "items that are to", $FA, $F7
    db $EF, $EE, "be equipped by", $EF, $EE, "monsters.", $F7
    db $F0

Data_083_46D9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Accessories for", $F1
    db "monsters are", $FA, $F7
    db $EF, $EE, "hidden in towers", $EF, $EE, "and caves.", $F7
    db $F0

Data_083_471A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Equip D-Scale to", $F1
    db "raise DEF.", $F7
    db $F0

Data_083_473A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "Some kinds provide", $EF, $EE, "better protection.", $F7
    db $F0, "  "

Data_083_478E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "Some kinds promote", $EF, $EE, "stat growth.", $F7
    db $F0

Data_083_47DA:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "One even restores", $EF, $EE, "HP as you walk.", $F7
    db $F0

Data_083_4828:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Accessories have", $F1
    db "different effects.", $FA, $F7
    db $EF, $EE, "One even restores", $EF, $EE, "MP as you walk.", $F7
    db $F0

Data_083_4876:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A monster can", $F1
    db "equip only one", $FA, $F7
    db $EF, $EE, "accessory, or so", $EF, $EE, "I", $42, "e heard.", $F7
    db $F0

Data_083_48B7:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster", $F1
    db "gets equipped with", $FA, $F7
    db $EF, $EE, "an accessory, the", $EF, $EE, "old one's removed.", $FA, $F7
    db $EF, $EE, "It's not destroyed,", $EF, $EE, "so don't worry.", $F7
    db $F0

Data_083_4929:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is there an", $F1
    db "accessory that'll", $FA, $F7
    db $EF, $EE, "let me stand up to", $EF, $EE, "my wife?", $F7
    db $F0

Data_083_496A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " One accessory", $F1
    db "can be equipped.", $FA, $F7
    db $EF, $EE, "You can choose to", $EF, $EE, "compensate for a", $FA, $F7
    db $EF, $EE, "weakness, or boost", $EF, $EE, "a strength.", $F7
    db $F0

Data_083_49D7:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't look", $F1
    db "familiar.", $FA, $F7
    db $EF, $EE, "A traveler, are", $EF, $EE, "you?", $FA, $F7
    db $EF, $EE, "Be courteous to", $EF, $EE, "our King!", $F7
    db $F0

Data_083_4A2A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ssh! Be quiet in", $F1
    db "the Castle!", $F7
    db $F0

Data_083_4A4B:: ; heuristic: string; C0
    db $EA, $45, $90, $23, $3D, $3D, $3D, $A4, $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Huh? N-no, I", $EF, $EE, "wasn't sleeping!", $F7
    db $F0

Data_083_4A78:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters and", $F1
    db "humans co-existed", $FA, $F7
    db $EF, $EE, "peacefully in the", $EF, $EE, "past.", $FA, $F7
    db $EF, $EE, "They won't attack", $EF, $EE, "you if you don't", $FA, $F7
    db $EF, $EE, "disturb their", $EF, $EE, "nests.", $F7
    db $F0

Data_083_4AF5:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Be careful in", $F1
    db "towers and caves.", $FA, $F7
    db $EF, $EE, "Monsters in them", $EF, $EE, "are stronger.", $F7
    db $F0

Data_083_4B3C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e got guts", $F1
    db "for a little kid!", $F7
    db $F0

Data_083_4B61:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In times of", $F1
    db "peace, we must be", $FA, $F7
    db $EF, $EE, "even more vigilant", $EF, $EE, "than usual!", $F7
    db $F0

Data_083_4BA6:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A high-power", $F1
    db "attack inflicts", $FA, $F7
    db $EF, $EE, "more damage, but", $EF, $EE, "it's not accurate.", $FA, $F7
    db $EF, $EE, "SideStep is a good", $EF, $EE, "countermeasure.", $F7
    db $F0

Data_083_4C15:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are some", $F1
    db "skills that are", $FA, $F7
    db $EF, $EE, "extra-effective on", $EF, $EE, "specific families.", $FA, $F7
    db $EF, $EE, "They're not flashy,", $EF, $EE, "but they work.", $F7
    db $F0

Data_083_4C88:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some skills put", $F1
    db "the user at risk.", $FA, $F7
    db $EF, $EE, "I like the gamble", $EF, $EE, "that they pose!", $F7
    db $F0

Data_083_4CD4:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GigaSlash is", $F1
    db "revered.", $FA, $F7
    db $EF, $EE, "This sword skill", $EF, $EE, "is learned only by", $FA, $F7
    db $EF, $EE, "those who learn", $EF, $EE, "all sword skills.", $F7
    db $F0

Data_083_4D3C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A kid with", $F1
    db "monsters in tow?", $FA, $F7
    db $EF, $EE, "You're a brave", $EF, $EE, "soul!", $F7
    db $F0

Data_083_4D74:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some monsters do", $F1
    db "not belong to any", $FA, $F7
    db $EF, $EE, "known family.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "They are powerful,", $EF, $EE, "terrible beings.", $FA, $F7
    db $EF, $EE, "They reign as", $EF, $EE, "lords and kings", $FA, $F7
    db $EF, $EE, "among demons and", $EF, $EE, "monsters.", $F7
    db $F0

Data_083_4E18:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A visitor came", $F1
    db "here with a rare", $FA, $F7
    db $EF, $EE, "monster in his", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "I", $42, "e never seen it", $EF, $EE, "around here.", $F7
    db $F0

Data_083_4E79:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you seen a", $F1
    db "casino ship?", $FA, $F7
    db $EF, $EE, "You can bet on", $EF, $EE, "slot machines.", $FA, $F7
    db $EF, $EE, "You can win some", $EF, $EE, "decent prizes too.", $F7
    db $F0

Data_083_4EE4:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some monsters", $F1
    db "have attacks that", $FA, $F7
    db $EF, $EE, "hit and leave a", $EF, $EE, "lingering effect.", $FA, $F7
    db $EF, $EE, "Watch out for", $EF, $EE, "them.", $FA, $F7
    db $EF, $EE, "They'll be useful", $EF, $EE, "in your party.", $F7
    db $F0

Data_083_4F6A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your eyes are", $F1
    db "unclouded", $A4, $FA, $F7
    db $EF, $EE, "You seem to be a", $EF, $EE, "good sort.", $F7
    db $F0

Data_083_4FA7:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When I was a", $F1
    db "kid, I wanted to", $FA, $F7
    db $EF, $EE, "travel everywhere.", $EF, $EE, "But at my age,", $FA, $F7
    db $EF, $EE, "home is where I", $EF, $EE, "want to be.", $F7
    db $F0

Data_083_500F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hoo boy, it sure", $F1
    db "is quiet.", $FA, $F7
    db $EF, $EE, "Of course, it's", $EF, $EE, "better that way.", $F7
    db $F0

Data_083_5052:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sigh", $A4, " All I ever", $F1
    db "do is clean up,", $FA, $F7
    db $EF, $EE, "the way the boss", $EF, $EE, "says.", $FA, $F7
    db $EF, $EE, "When am I going to", $EF, $EE, "be promoted?", $F7
    db $F0

Data_083_50B6:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The young people", $F1
    db "these days have no", $FA, $F7
    db $EF, $EE, "sense of gumption!", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3, $1C, $28, $2F, $29, $9C, $33, $2C, $37, $3C, $2C, $31, $2A, $EF, $EE, $3A
    db $2B, $2C, $31, $28, $35, $36, $AB, $90, $37, $2B, $28, $3C, $90, $24, $35, $28
    db $99, $F7, $F0

Data_083_511B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Halt!", $F1
    db "Who goes there?", $FA, $F7
    db $EF, $EE, "I look good as a", $EF, $EE, "guard, don't I?", $F7
    db $F0

Data_083_5159:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm terrified of", $F1
    db "monsters!", $FA, $F7
    db $EF, $EE, "Keep them away", $EF, $EE, "from me!", $F7
    db $F0

Data_083_5193:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A soldier has to", $F1
    db "obey orders.", $FA, $F7
    db $EF, $EE, "If soldiers don't", $EF, $EE, "obey, even a", $FA, $F7
    db $EF, $EE, "winnable battle", $EF, $EE, "will be lost.", $FA, $F7
    db $EF, $EE, "Train your party", $EF, $EE, "well so they won't", $FA, $F7
    db $EF, $EE, "rebel against you", $EF, $EE, "in battle.", $F7
    db $F0

Data_083_5241:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is it really", $F1
    db "possible for", $FA, $F7
    db $EF, $EE, "people to co-exist", $EF, $EE, "with monsters?", $F7
    db $F0

Data_083_5285:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're not from", $F1
    db "these parts.", $FA, $F7
    db $EF, $EE, "I can tell.", $EF, $EE, "You're a bumpkin.", $F7
    db $F0

Data_083_52C6:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Money attracts", $F1
    db "greedy people.", $FA, $F7
    db $EF, $EE, "Keep extra money", $EF, $EE, "in the Vault.", $FA, $F7
    db $EF, $EE, "It will be safe", $EF, $EE, "there.", $F7
    db $F0

Data_083_5326:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e run into", $F1
    db "dealers while I", $FA, $F7
    db $EF, $EE, "was traveling", $EF, $EE, "about.", $FA, $F7
    db $EF, $EE, "They charge crazy", $EF, $EE, "prices, though.", $F7
    db $F0

Data_083_5386:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e met other", $F1
    db "travelers with", $FA, $F7
    db $EF, $EE, "monsters in tow", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "They said they", $EF, $EE, "were training.", $F7
    db $F0

Data_083_53E7:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some monsters", $F1
    db "grow slowly when", $FA, $F7
    db $EF, $EE, "they are young,", $EF, $EE, "but watch how they", $FA, $F7
    db $EF, $EE, "grow when they get", $EF, $EE, "older. Wow!", $F7
    db $F0

Data_083_5454:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monster families", $F1
    db "have upper limits", $FA, $F7
    db $EF, $EE, "to their growth.", $EF, $EE, "But the limits can", $FA, $F7
    db $EF, $EE, "be raised by", $EF, $EE, "breeding.", $F7
    db $F0

Data_083_54BE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Seeds and nuts", $F1
    db "that raise stats", $FA, $F7
    db $EF, $EE, "are invaluable", $EF, $EE, "items.", $FA, $F7
    db $EF, $EE, "On odd occasions,", $EF, $EE, "you'll find them", $FA, $F7
    db $EF, $EE, "as gambling", $EF, $EE, "prizes.", $F7
    db $F0

Data_083_5538:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are many", $F1
    db "worlds, and there", $FA, $F7
    db $EF, $EE, "are many people,", $EF, $EE, "both good and bad.", $FA, $F7
    db $EF, $EE, "That's why it's", $EF, $EE, "exciting!", $F7
    db $F0

Data_083_55A1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm only a raw", $F1
    db "recruit, but one", $FA, $F7
    db $EF, $EE, "day, I'm going to", $EF, $EE, "become a hero.", $FA, $F7
    db $EF, $EE, "When that happens,", $EF, $EE, "I'll propose to my", $FA, $F7
    db $EF, $EE, "girl. I wonder if", $EF, $EE, "she'll wait?", $F7
    db $F0

Data_083_5633:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't just", $F1
    db "work on physical", $FA, $F7
    db $EF, $EE, "might. You need to", $EF, $EE, "be sharp mentally", $FA, $F7
    db $EF, $EE, "if you want to do", $EF, $EE, "well in battle.", $F7
    db $F0

Data_083_56A5:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our King is", $F1
    db "named Al.", $FA, $F7
    db $EF, $EE, "Tell me, have you", $EF, $EE, "MetalKing?", $FA, $F7
    db $EF, $EE, "Whoops, you didn't", $EF, $EE, "find that funny?", $F7
    db $F0

Data_083_5707:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are no", $F1
    db "human settlements", $FA, $F7
    db $EF, $EE, "around these parts", $EF, $EE, "except here.", $FA, $F7
    db $EF, $EE, "You should rest up", $EF, $EE, "before you leave.", $F7
    db $F0

Data_083_5777:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the only", $F1
    db "human settlement", $FA, $F7
    db $EF, $EE, "in these parts.", $EF, $EE, "You might consider", $FA, $F7
    db $EF, $EE, "resting here", $EF, $EE, "before you go.", $F7
    db $F0

Data_083_57E4:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are a few", $F1
    db "other places where", $FA, $F7
    db $EF, $EE, "people live in", $EF, $EE, "these parts.", $FA, $F7
    db $EF, $EE, "Each has different", $EF, $EE, "facilities.", $F7
    db $F0

Data_083_584E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The merchandise", $F1
    db "of shops varies", $FA, $F7
    db $EF, $EE, "from place to", $EF, $EE, "place.", $F7
    db $F0

Data_083_588B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! Good of", $F1
    db "you to come!", $FA, $F7
    db $EF, $EE, "We don't get many", $EF, $EE, "visitors.", $F7
    db $F0

Data_083_58CC:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's dangerous", $F1
    db "out there.", $FA, $F7
    db $EF, $EE, "Get some rest", $EF, $EE, "before you go.", $F7
    db $F0

Data_083_590A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Uh", $A4, $F1
    db "Um", $A4, $FA, $F7
    db $EF, $EE, "Aren't you afraid", $EF, $EE, "of your monsters?", $F7
    db $F0

Data_083_593D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you plan on", $F1
    db "traveling far, you", $FA, $F7
    db $EF, $EE, "should prepare for", $EF, $EE, "any emergency.", $FA, $F7
    db $EF, $EE, "There's no telling", $EF, $EE, "what could happen.", $F7
    db $F0

Data_083_59B2:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A LogTwig is", $F1
    db "convenient.", $FA, $F7
    db $EF, $EE, "Leave it anywhere", $EF, $EE, "in the field, and", $FA, $F7
    db $EF, $EE, "you can get to it", $EF, $EE, "with a WarpStaff.", $F7
    db $F0

Data_083_5A1F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Teach me how to", $F1
    db "tame monsters.", $FA, $F7
    db $EF, $EE, "I could get them", $EF, $EE, "to cook and clean", $A4, $F7
    db $F0

Data_083_5A6A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can make", $F1
    db "monsters friendly", $FA, $F7
    db $EF, $EE, "by taking them on", $EF, $EE, "your journeys.", $FA, $F7
    db $EF, $EE, "Feeding them meat", $EF, $EE, "is too costly.", $F7
    db $F0

Data_083_5AD7:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you know the", $F1
    db "skill Errand?", $FA, $F7
    db $EF, $EE, "You can get a", $EF, $EE, "monster to go do", $FA, $F7
    db $EF, $EE, "some shopping for", $EF, $EE, "you.", $F7
    db $F0

Data_083_5B37:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you heard", $F1
    db "of EagleEye?", $FA, $F7
    db $EF, $EE, "It's a skill for", $EF, $EE, "checking your", $FA, $F7
    db $EF, $EE, "surroundings from", $EF, $EE, "a bird's-eye view.", $F7
    db $F0

Data_083_5BA1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do your monsters", $F1
    db "know Informer?", $FA, $F7
    db $EF, $EE, "It's a skill that", $EF, $EE, "identifies the", $FA, $F7
    db $EF, $EE, "kinds of monsters", $EF, $EE, "in the vicinity.", $F7
    db $F0

Data_083_5C10:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Does any monster", $F1
    db "of yours know the", $FA, $F7
    db $EF, $EE, "skill MapMagic?", $EF, $EE, "It gives you an", $FA, $F7
    db $EF, $EE, "idea about your", $EF, $EE, "surrounding area.", $F7
    db $F0

Data_083_5C81:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You need money", $F1
    db "to buy items.", $FA, $F7
    db $EF, $EE, "But money is hard", $EF, $EE, "to find.", $FA, $F7
    db $EF, $EE, "I guess I have to", $EF, $EE, "sell extra items.", $F7
    db $F0

Data_083_5CE9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The slime family", $F1
    db "is tough against", $FA, $F7
    db $EF, $EE, "spells like", $EF, $EE, "Surround and Sap.", $FA, $F7
    db $EF, $EE, "If only they had", $EF, $EE, "higher ATK", $A4, $F7
    db $F0

Data_083_5D52:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Dragons are", $F1
    db "fire-resistant.", $FA, $F7
    db $EF, $EE, "If only they grew", $EF, $EE, "a bit faster", $A4, $F7
    db $F0

Data_083_5D96:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The beast family", $F1
    db "is very weak to", $FA, $F7
    db $EF, $EE, "attack spells.", $EF, $EE, "On the other hand,", $FA, $F7
    db $EF, $EE, "it has high ATK", $EF, $EE, "and HP.", $F7
    db $F0

Data_083_5DFD:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Birds are quite", $F1
    db "resistant to such", $FA, $F7
    db $EF, $EE, "spells as Infernos", $EF, $EE, "and Zap.", $FA, $F7
    db $EF, $EE, "They also grow", $EF, $EE, "fast.", $F7
    db $F0

Data_083_5E5C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The plant family", $F1
    db "is strong against", $FA, $F7
    db $EF, $EE, "spells like Zap", $EF, $EE, "and Infernos.", $FA, $F7
    db $EF, $EE, "But it's vulnerable", $EF, $EE, "to fire.", $FA, $F7
    db $EF, $EE, "MP gain is high on", $EF, $EE, "leveling up.", $F7
    db $F0

Data_083_5EE9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The bug family", $F1
    db "is resistant to", $FA, $F7
    db $EF, $EE, "poison and", $EF, $EE, "paralysis.", $FA, $F7
    db $EF, $EE, "Bugs also grow", $EF, $EE, "fast, so they can", $FA, $F7
    db $EF, $EE, "become useful very", $EF, $EE, "quickly.", $F7
    db $F0

Data_083_5F6B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The devil family", $F1
    db "is very resistant", $FA, $F7
    db $EF, $EE, "to all kinds of", $EF, $EE, "attack spells.", $FA, $F7
    db $EF, $EE, "They"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " be great if", $EF, $EE, "they didn't get", $FA, $F7
    db $EF, $EE, "poisoned or fall", $EF, $EE, "asleep easily.", $F7
    db $F0

Data_083_5FFE:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zombies are", $F1
    db "virtually unharmed", $FA, $F7
    db $EF, $EE, "by death spells or", $EF, $EE, "curses.", $FA, $F7
    db $EF, $EE, "On the other hand,", $EF, $EE, "they are easily", $FA, $F7
    db $EF, $EE, "affected by fire", $EF, $EE, "and WarCry", $A4, $F7
    db $F0

Data_083_6088:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are many", $F1
    db "kinds of material", $FA, $F7
    db $EF, $EE, "family monsters.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It's impossible to", $EF, $EE, "describe their", $FA, $F7
    db $EF, $EE, "good points in one", $EF, $EE, "breath.", $F7
    db $F0

Data_083_6108:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Water family", $F1
    db "monsters are very", $FA, $F7
    db $EF, $EE, "tough against fire", $EF, $EE, "and water skills.", $FA, $F7
    db $EF, $EE, "There isn't one", $EF, $EE, "that really stands", $FA, $F7
    db $EF, $EE, "out, but they can", $EF, $EE, "be quite useful.", $F7
    db $F0

Data_083_61A1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you met any", $F1
    db "Demon Lords?", $FA, $F7
    db $EF, $EE, "They make nasty", $EF, $EE, "enemies, but if", $FA, $F7
    db $EF, $EE, "you could get them", $EF, $EE, "on your side", $A4, $F7
    db $F0

Data_083_620C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's getting", $F1
    db "mean out there.", $FA, $F7
    db $EF, $EE, "Strangers may want", $EF, $EE, "to battle you.", $F7
    db $F0

Data_083_6252:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Skills that", $F1
    db "induce sleep or", $FA, $F7
    db $EF, $EE, "paralysis are very", $EF, $EE, "effective.", $FA, $F7
    db $EF, $EE, "But watch out,", $EF, $EE, "some monsters are", $FA, $F7
    db $EF, $EE, "impervious to", $EF, $EE, "them.", $F7
    db $F0

Data_083_62D1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you seen", $F1
    db "any metallic kinds", $FA, $F7
    db $EF, $EE, "of slime monsters?", $EF, $EE, "They're worth a", $FA, $F7
    db $EF, $EE, "huge amount of EX", $EF, $EE, "points.", $F7
    db $F0

Data_083_633A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My grandpa told", $F1
    db "me that if you see", $FA, $F7
    db $EF, $EE, "a bard, you're in", $EF, $EE, "luck.", $F7
    db $F0

Data_083_637C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you seen a", $F1
    db "Gold Pass?", $FA, $F7
    db $EF, $EE, "It's expensive,", $EF, $EE, "but it gives you", $FA, $F7
    db $EF, $EE, "discounts at any", $EF, $EE, "shop.", $F7
    db $F0

Data_083_63DA:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the deepest", $F1
    db "part of a cave,", $FA, $F7
    db $EF, $EE, "a monster boss", $EF, $EE, "makes its throne.", $FA, $F7
    db $EF, $EE, "It reigns over", $EF, $EE, "other monsters.", $F7
    db $F0

Data_083_6445:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " At the top of a", $F1
    db "tower, you'll find", $FA, $F7
    db $EF, $EE, "a monster boss on", $EF, $EE, "its throne.", $FA, $F7
    db $EF, $EE, "It reigns over", $EF, $EE, "other monsters.", $F7
    db $F0

Data_083_64B0:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hear that", $F1
    db "there's a monster", $FA, $F7
    db $EF, $EE, "boss in a castle", $EF, $EE, "somewhere.", $FA, $F7
    db $EF, $EE, "It reigns over", $EF, $EE, "other monsters.", $F7
    db $F0

Data_083_6514:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Treasure chests", $F1
    db "are hidden in", $FA, $F7
    db $EF, $EE, "caves and towers,", $EF, $EE, "I", $42, "e heard.", $FA, $F7
    db $EF, $EE, "They must contain", $EF, $EE, "amazing treasures!", $F7
    db $F0

Data_083_6580:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you must be", $F1
    db "a traveler.", $FA, $F7
    db $EF, $EE, "There isn't much", $EF, $EE, "here, but it is", $FA, $F7
    db $EF, $EE, "a nice place to", $EF, $EE, "rest up.", $F7
    db $F0

Data_083_65E1:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You may find", $F1
    db "things in the", $FA, $F7
    db $EF, $EE, "oddest places.", $EF, $EE, "You have to look.", $F7
    db $F0

Data_083_6625:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Now, where's my", $F1
    db "husband wandering?", $FA, $F7
    db $EF, $EE, "I send him out on", $EF, $EE, "a simple errand", $A4, $FA, $F7
    db $EF, $EE, "It's beyond belief,", $EF, $EE, "let me tell you!", $F7
    db $F0

Data_083_669A:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What to make for", $F1
    db "supper", $A4, $F7
    db $F0

Data_083_66B7:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh my!", $F1
    db "What delicious", $A4, $FA, $F7
    db $EF, $EE, "I mean cute! Yes,", $EF, $EE, "cute, monsters!", $F7
    db $F0

Data_083_66F8:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wish my boy", $F1
    db "was as mature as", $FA, $F7
    db $EF, $EE, "you, but he's just", $EF, $EE, "so rambunctious.", $FA, $F7
    db $EF, $EE, "I can't let him", $EF, $EE, "out of sight.", $F7
    db $F0

Data_083_6763:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Look at your", $F1
    db "dirty clothes!", $FA, $F7
    db $EF, $EE, "Are you washing", $EF, $EE, "them properly?", $F7
    db $F0

Data_083_67A6:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our children", $F1
    db "grow like weeds.", $FA, $F7
    db $EF, $EE, "You should see how", $EF, $EE, "much they eat.", $F7
    db $F0

Data_083_67EE:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That man there", $F1
    db "keeps staring.", $FA, $F7
    db $EF, $EE, "Does he think I'm", $EF, $EE, "strange?", $F7
    db $F0

Data_083_682E:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, aren't you", $F1
    db "cute!", $FA, $F7
    db $EF, $EE, "And your monsters", $EF, $EE, "are adorable too!", $F7
    db $F0

Data_083_686E:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It would be so", $F1
    db "nice to be able to", $FA, $F7
    db $EF, $EE, "cross the sea or", $EF, $EE, "fly.", $FA, $F7
    db $EF, $EE, "If I could, I", $EF, $EE, "would go see my", $FA, $F7
    db $EF, $EE, "boyfriend whenever", $EF, $EE, "I wanted.", $F7
    db $F0

Data_083_68F1:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wish I had a", $F1
    db "sibling like you.", $F7
    db $F0

Data_083_6916:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My boy is a", $F1
    db "dirt magnet!", $FA, $F7
    db $EF, $EE, "I can't keep up", $EF, $EE, "with the wash!", $F7
    db $F0

Data_083_6955:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Sigh", $A4, " When will", $F1
    db "he come back?", $FA, $F7
    db $EF, $EE, "He hasn't written", $EF, $EE, "once, the clod!", $F7
    db $F0

Data_083_699D:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is it safe alone", $F1
    db "like that?", $FA, $F7
    db $EF, $EE, "Don't break your", $EF, $EE, "parents", $95, " hearts!", $F7
    db $F0

Data_083_69E2:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters have", $F1
    db "personalities that", $FA, $F7
    db $EF, $EE, "determine how they", $EF, $EE, "behave.", $F7
    db $F0

Data_083_6A26:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I thought", $F1
    db "monsters were", $FA, $F7
    db $EF, $EE, "frightful things,", $EF, $EE, "but the ones you", $FA, $F7
    db $EF, $EE, "have all look", $EF, $EE, "cheerful.", $F7
    db $F0

Data_083_6A85:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're on a", $F1
    db "journey with", $FA, $F7
    db $EF, $EE, "monsters?", $EF, $EE, "I'm impressed.", $F7
    db $F0

Data_083_6ABD:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I pack lightly", $F1
    db "for a journey.", $FA, $F7
    db $EF, $EE, "A WarpWing and a", $EF, $EE, "Bookmark-", $FA, $F7
    db $EF, $EE, "those are basic.", $EF, $EE, "After these two,", $FA, $F7
    db $EF, $EE, "I take the bare", $EF, $EE, "minimum, so I can", $FA, $F7
    db $EF, $EE, "pick up more items", $EF, $EE, "that I find.", $F7
    db $F0

Data_083_6B6E:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I love squishy", $F1
    db "monsters!", $FA, $F7
    db $EF, $EE, "They look so", $EF, $EE, "appetizing!", $FA, $F7
    db $EF, $EE, "I'm joking!", $EF, $EE, "Don't be scared!", $F7
    db $F0

Data_083_6BC7:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How do monsters", $F1
    db "live in the wild?", $FA, $F7
    db $EF, $EE, "We don't know much", $EF, $EE, "about them.", $F7
    db $F0

Data_083_6C0F:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The FriendStaff", $F1
    db "works exactly like", $FA, $F7
    db $EF, $EE, "the spell TwinHits", $EF, $EE, "in battle.", $FA, $F7
    db $EF, $EE, "It will definitely", $EF, $EE, "come in handy.", $F7
    db $F0

Data_083_6C7E:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The MistStaff", $F1
    db "does the same work", $FA, $F7
    db $EF, $EE, "as the spell", $EF, $EE, "StopSpell.", $FA, $F7
    db $EF, $EE, "Use it to silence", $EF, $EE, "spell-casters.", $F7
    db $F0

Data_083_6CE4:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can attack", $F1
    db "monsters using", $FA, $F7
    db $EF, $EE, "the powers of", $EF, $EE, "certain staves.", $FA, $F7
    db $EF, $EE, "But monsters won't", $EF, $EE, "like you for it.", $F7
    db $F0

Data_083_6D4F:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " BadMeat acts", $F1
    db "like poison.", $FA, $F7
    db $EF, $EE, "Don't feed it to", $EF, $EE, "your monsters,", $FA, $F7
    db $EF, $EE, "but it works on", $EF, $EE, "enemies well.", $F7
    db $F0

Data_083_6DB2:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Repellent keeps", $F1
    db "monsters away.", $FA, $F7
    db $EF, $EE, "The Shiny Harp", $EF, $EE, "does the opposite.", $F7
    db $F0

Data_083_6DFB:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How adorable!", $F1
    db "How would you like", $FA, $F7
    db $EF, $EE, "a nice powderpuff", $EF, $EE, "massage?", $FA, $F7
    db $EF, $EE, "Oh? Not you.", $EF, $EE, "I love monsters!", $F7
    db $F0

Data_083_6E61:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you heard", $F1
    db "about the great", $FA, $F7
    db $EF, $EE, "master tamer?", $EF, $EE, "He's amazing.", $FA, $F7
    db $EF, $EE, "He's named Terry.", $EF, $EE, "He's still young!", $F7
    db $F0

Data_083_6EC9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Magic Keys are", $F1
    db "indeed magical.", $FA, $F7
    db $EF, $EE, "It's magical how", $EF, $EE, "they lead to", $FA, $F7
    db $EF, $EE, "different worlds", $EF, $EE, "we don't know.", $F7
    db $F0

Data_083_6F30:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If something is", $F1
    db "rare or valuable", $A4, $FA, $F7
    db $EF, $EE, "You"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " never leave", $EF, $EE, "it in plain sight.", $F7
    db $F0

Data_083_6F7E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Caves and towers", $F1
    db "teem with danger!", $FA, $F7
    db $EF, $EE, "Going in is only", $EF, $EE, "half the job.", $FA, $F7
    db $EF, $EE, "You have to get", $EF, $EE, "yourself back out!", $F7
    db $F0

Data_083_6FEF:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A treasure chest", $F1
    db "holds one item.", $F7
    db $F0

Data_083_7014:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, I can't", $F1
    db "recall seeing a", $FA, $F7
    db $EF, $EE, "cuter visitor than", $EF, $EE, "you, dear child.", $FA, $F7
    db $EF, $EE, "Do take the time", $EF, $EE, "to relax here.", $F7
    db $F0

Data_083_707F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you're ever", $F1
    db "in need of help,", $FA, $F7
    db $EF, $EE, "be sure to come", $EF, $EE, "back here.", $F7
    db $F0

Data_083_70C1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Other worlds,", $F1
    db "you say?", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to go", $EF, $EE, "somewhere", $A4, $F7
    db $F0

Data_083_70F9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So good of you", $F1
    db "to visit us at", $FA, $F7
    db $EF, $EE, "this distant and", $EF, $EE, "forgotten outpost.", $FA, $F7
    db $EF, $EE, "There is nothing", $EF, $EE, "here at all.", $FA, $F7
    db $EF, $EE, "But feel free to", $EF, $EE, "stay as long as", $FA, $F7
    db $EF, $EE, "you wish.", $EF, $EE, $F7
    db $F0

Data_083_7199:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you're such", $F1
    db "a cute cherub!", $FA, $F7
    db $EF, $EE, "You look exactly", $EF, $EE, "as my son did.", $FA, $F7
    db $EF, $EE, "Wait! Are you my", $EF, $EE, "grandchild?", $F7
    db $F0

Data_083_7200:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hah? You have", $F1
    db "tamed monsters?", $FA, $F7
    db $EF, $EE, "You're to be", $EF, $EE, "commended!", $FA, $F7
    db $EF, $EE, "I did the same", $EF, $EE, "when I was young", $A4, $F7
    db $F0

Data_083_7262:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If something", $F1
    db "comes easily,", $FA, $F7
    db $EF, $EE, "one is apt to not", $EF, $EE, "realize its worth.", $FA, $F7
    db $EF, $EE, "When you do, it's", $EF, $EE, "usually been lost", $A4, $F7
    db $F0

Data_083_72D2:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you wish to", $F1
    db "meet travelers", $FA, $F7
    db $EF, $EE, "like yourself, you", $EF, $EE, "must walk.", $FA, $F7
    db $EF, $EE, "You'll get to see", $EF, $EE, "them, by and by.", $F7
    db $F0

Data_083_733C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When I was your", $F1
    db "age, I admit I was", $FA, $F7
    db $EF, $EE, "a mischievous lad,", $EF, $EE, "if I may say so.", $FA, $F7
    db $EF, $EE, "I remember those", $EF, $EE, "days clearly", $A4, $F7
    db $F0

Data_083_73AE:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I take my walk", $F1
    db "on the same route", $FA, $F7
    db $EF, $EE, "every day. I never", $EF, $EE, "go anywhere else.", $FA, $F7
    db $EF, $EE, "But, like the way", $EF, $EE, "I met you today,", $FA, $F7
    db $EF, $EE, "there is always a", $EF, $EE, "new discovery.", $F7
    db $F0

Data_083_7448:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My eyesight isn't", $F1
    db "what it once was.", $FA, $F7
    db $EF, $EE, "But my nose works", $EF, $EE, "quite fine.", $FA, $F7
    db $EF, $EE, "The friends behind", $EF, $EE, "you desperately", $FA, $F7
    db $EF, $EE, "need a bath, I can", $EF, $EE, "tell that much.", $F7
    db $F0

Data_083_74DF:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah-ha, you're", $F1
    db "such a cute child!", $FA, $F7
    db $EF, $EE, "About a tenth of", $EF, $EE, "the cuteness of my", $FA, $F7
    db $EF, $EE, "grandchildren, I", $EF, $EE, "would think.", $F7
    db $F0

Data_083_754D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I was a fine-", $F1
    db "looking fellow", $FA, $F7
    db $EF, $EE, "with many lady", $EF, $EE, "friends.", $FA, $F7
    db $EF, $EE, "Not that you could", $EF, $EE, "tell from this", $FA, $F7
    db $EF, $EE, "wrinkled old sack", $EF, $EE, "of bones!", $F7
    db $F0

Data_083_75D0:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A monster can", $F1
    db "equip a single", $FA, $F7
    db $EF, $EE, "accessory, and no", $EF, $EE, "more.", $FA, $F7
    db $EF, $EE, "If you equip", $EF, $EE, "another one, the", $FA, $F7
    db $EF, $EE, "old one is taken", $EF, $EE, "off.", $F7
    db $F0

Data_083_7649:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If someone asks", $F1
    db "you to mate some", $FA, $F7
    db $EF, $EE, "monsters, be quick", $EF, $EE, "to accept.", $FA, $F7
    db $EF, $EE, "Traveling masters", $EF, $EE, "don't stay long.", $F7
    db $F0

Data_083_76B6:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm, when I was", $F1
    db "young, I must say", $FA, $F7
    db $EF, $EE, "that I was foolish", $EF, $EE, "and reckless.", $FA, $F7
    db $EF, $EE, "To see someone as", $EF, $EE, "young as you", $FA, $F7
    db $EF, $EE, "traveling with", $EF, $EE, "monsters", $A4, $FA, $F7
    db $EF, $EE, "You're nothing if", $EF, $EE, "not reckless!", $F7
    db $F0

Data_083_7763:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you see a", $F1
    db "fellow traveler,", $FA, $F7
    db $EF, $EE, "talk to him or her", $EF, $EE, "right away.", $FA, $F7
    db $EF, $EE, "They'll wander off", $EF, $EE, "if you don't.", $F7
    db $F0

Data_083_77CB:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I see something", $F1
    db "in your eyes", $A4, $FA, $F7
    db $EF, $EE, "I get the feeling", $EF, $EE, "that you're going", $FA, $F7
    db $EF, $EE, "to do something", $EF, $EE, "extraordinary.", $F7
    db $F0

Data_083_7837:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The personality", $F1
    db "of a monster gets", $FA, $F7
    db $EF, $EE, "changed by your", $EF, $EE, "battle plans.", $FA, $F7
    db $EF, $EE, "If you don't train", $EF, $EE, "it properly, it", $FA, $F7
    db $EF, $EE, "may not battle", $EF, $EE, "effectively.", $F7
    db $F0

Data_083_78C5:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster is", $F1
    db "made to ", $95, "Charge", $95, $FA, $F7
    db $EF, $EE, "all the time, it", $EF, $EE, "will become more", $FA, $F7
    db $EF, $EE, "brave, but less", $EF, $EE, "sensible.", $F7
    db $F0

Data_083_792E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster is", $F1
    db "given a ", $95, "Mixed", $95, $FA, $F7
    db $EF, $EE, "plan, it becomes", $EF, $EE, "more sensible.", $FA, $F7
    db $EF, $EE, "But it also turns", $EF, $EE, "less kindly.", $F7
    db $F0

Data_083_7999:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster is", $F1
    db "ordered to use", $FA, $F7
    db $EF, $EE, $95, "Defense", $95, " in", $EF, $EE, "battle, it will", $FA, $F7
    db $EF, $EE, "turn increasingly", $EF, $EE, "compassionate.", $FA, $F7
    db $EF, $EE, "But, it also turns", $EF, $EE, "less brave.", $F7
    db $F0

Data_083_7A25:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster's", $F1
    db "personality is", $FA, $F7
    db $EF, $EE, $95, "Coward", $95, " or ", $95, "EZ", $EF, $EE, "going", $95, ", it's not", $FA, $F7
    db $EF, $EE, "really suitable", $EF, $EE, "for attacking.", $F7
    db $F0

Data_083_7A8D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster's", $F1
    db "personality is", $FA, $F7
    db $EF, $EE, $95, "Daredevil", $95, " or", $EF, $EE, $95, "Carefree", $95, ", it's", $FA, $F7
    db $EF, $EE, "not good in a", $EF, $EE, "supporting role.", $F7
    db $F0

Data_083_7AF4:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster's", $F1
    db "personality is", $FA, $F7
    db $EF, $EE, $95, "Snobby", $95, " or", $EF, $EE, $95, "Spoiled", $95, ", don't", $FA, $F7
    db $EF, $EE, "expect it to make", $EF, $EE, "a good healer.", $F7
    db $F0

Data_083_7B5A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A monster's", $F1
    db "personality is an", $FA, $F7
    db $EF, $EE, "important factor", $EF, $EE, "in battle.", $FA, $F7
    db $EF, $EE, "Be sure to check", $EF, $EE, "them in advance.", $F7
    db $F0

Data_083_7BC1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I see a dark", $F1
    db "shadow casting its", $FA, $F7
    db $EF, $EE, "pall over your", $EF, $EE, "monsters", $A4, $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "an evil sign.", $FA, $F7
    db $EF, $EE, "Don't push them", $EF, $EE, "too hard.", $F7
    db $F0

Data_083_7C42:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Just pushing me", $F1
    db "won't budge me!", $F7
    db $F0

Data_083_7C65:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The personality", $F1
    db "of a monster", $FA, $F7
    db $EF, $EE, "changes depending", $EF, $EE, "on battle plans.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

Data_083_7CCC:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Seeds and nuts", $F1
    db "can raise monster", $FA, $F7
    db $EF, $EE, "stats even if they", $EF, $EE, "can't level up.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

Data_083_7D36:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How quickly", $F1
    db "monsters level up", $FA, $F7
    db $EF, $EE, "varies from family", $EF, $EE, "to family.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

Data_083_7D99:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monster families", $F1
    db "have different", $FA, $F7
    db $EF, $EE, "resistance levels", $EF, $EE, "to spell types.", $FA, $F7
    db $EF, $EE, "Some are tough", $EF, $EE, "against fire, and", $FA, $F7
    db $EF, $EE, "weak to water, for", $EF, $EE, "instance.", $F7
    db $F0

Data_083_7E29:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A monster marked", $F1
    db "with a "
    db $AC
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " won't grow", $FA, $F7
    db $EF, $EE, "anymore. Its level", $EF, $EE, "is maxed out.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

Data_083_7E95:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e seen your", $F1
    db "monsters score", $FA, $F7
    db $EF, $EE, "critical hits,", $EF, $EE, "right?", $FA, $F7
    db $EF, $EE, "There's a family", $EF, $EE, "that gets more", $FA, $F7
    db $EF, $EE, "critical hits than", $EF, $EE, "others.", $F7
    db $F0

Data_083_7F14:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Y-your monsters", $F1
    db "are staring at me", $A4, $FA, $F7
    db $EF, $EE, "And", $A4, " And they're", $EF, $EE, "drooling!", $F7
    db $F0
    ds $A7, $00
