SECTION "Bank 2A", ROMX[$4000], BANK[$2A]
    db $2A

; message bank $2A: when wStringIndex < $95, BeginStringDisplay with this bank's table Data_02A_4032; otherwise far-calls Func_097_404B (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_Case04, Func_010_4AD0_Case02, ShowMessageHL_Case02)
; reads: wStringIndex
BeginStringDisplay_Bank2A::
Func_02A_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $95
    jr c, Jump_02A_400F
    farcall BeginStringDisplay_Bank2A_Overflow
    ret

Jump_02A_400F::
    ld de, MessageStrings_Bank2A
    call BeginStringDisplay
    ret

; message bank $2A: when wStringIndex < $95, CopyStringToBuffer with this bank's table Data_02A_4032; otherwise far-calls Func_097_405A (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank2A:: ; heuristic: follows a terminator; C0
Func_02A_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $95
    jr c, Jump_02A_4024
    farcall CopyStringToBuffer_Bank2A_Overflow
    ret

Jump_02A_4024::
    ld de, MessageStrings_Bank2A
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_2A_4032::
MessageStrings_Bank2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_02A_4032:: ; address name
    dw StringList_2A_4034 ; id 0

; E-0217 (derived: category list of StringCategories_2A_4032; one pointer per wStringIndex)
; record: string
StringList_2A_4034::
Data_02A_4034:: ; address name
    dw Data_02A_415E ; id 0
    dw Data_02A_4284 ; id 1
    dw Data_02A_429B ; id 2
    dw Data_02A_42B9 ; id 3
    dw Data_02A_42FC ; id 4
    dw Data_02A_4366 ; id 5
    dw Data_02A_438C ; id 6
    dw Data_02A_44AF ; id 7
    dw Data_02A_461C ; id 8
    dw Data_02A_4735 ; id 9
    dw Data_02A_47A3 ; id 10
    dw Data_02A_4817 ; id 11
    dw Data_02A_48A8 ; id 12
    dw Data_02A_493B ; id 13
    dw Data_02A_4A15 ; id 14
    dw Data_02A_4A3D ; id 15
    dw Data_02A_4AD1 ; id 16
    dw Data_02A_4B18 ; id 17
    dw Data_02A_4BA4 ; id 18
    dw Data_02A_4BFA ; id 19
    dw Data_02A_4C19 ; id 20
    dw Data_02A_4C5F ; id 21
    dw Data_02A_4C84 ; id 22
    dw Data_02A_4D67 ; id 23
    dw Data_02A_4D67 ; id 24
    dw Data_02A_4D67 ; id 25
    dw Data_02A_4D67 ; id 26
    dw Data_02A_4D67 ; id 27
    dw Data_02A_4DAE ; id 28
    dw Data_02A_4E28 ; id 29
    dw Data_02A_4E4B ; id 30
    dw Data_02A_4E72 ; id 31
    dw Data_02A_4EFB ; id 32
    dw Data_02A_4F87 ; id 33
    dw Data_02A_5039 ; id 34
    dw Data_02A_50E8 ; id 35
    dw Data_02A_51B8 ; id 36
    dw Data_02A_5203 ; id 37
    dw Data_02A_5245 ; id 38
    dw Data_02A_5280 ; id 39
    dw Data_02A_52BE ; id 40
    dw Data_02A_53D2 ; id 41
    dw Data_02A_53F2 ; id 42
    dw Data_02A_54C6 ; id 43
    dw Data_02A_550C ; id 44
    dw Data_02A_5557 ; id 45
    dw Data_02A_55C0 ; id 46
    dw Data_02A_55E1 ; id 47
    dw Data_02A_5623 ; id 48
    dw Data_02A_5666 ; id 49
    dw Data_02A_568B ; id 50
    dw Data_02A_5762 ; id 51
    dw Data_02A_57C6 ; id 52
    dw Data_02A_583D ; id 53
    dw Data_02A_58D9 ; id 54
    dw Data_02A_5956 ; id 55
    dw Data_02A_59D6 ; id 56
    dw Data_02A_5A74 ; id 57
    dw Data_02A_5B2D ; id 58
    dw Data_02A_5C22 ; id 59
    dw Data_02A_5CEA ; id 60
    dw Data_02A_5D67 ; id 61
    dw Data_02A_5DEC ; id 62
    dw Data_02A_5E49 ; id 63
    dw Data_02A_5F03 ; id 64
    dw Data_02A_5F5E ; id 65
    dw Data_02A_5F81 ; id 66
    dw Data_02A_5FC8 ; id 67
    dw Data_02A_603C ; id 68
    dw Data_02A_60D4 ; id 69
    dw Data_02A_6116 ; id 70
    dw Data_02A_615E ; id 71
    dw Data_02A_61BC ; id 72
    dw Data_02A_61F3 ; id 73
    dw Data_02A_6289 ; id 74
    dw Data_02A_62CB ; id 75
    dw Data_02A_62CB ; id 76
    dw Data_02A_62CB ; id 77
    dw Data_02A_62CB ; id 78
    dw Data_02A_62CB ; id 79
    dw Data_02A_62CB ; id 80
    dw Data_02A_62CB ; id 81
    dw Data_02A_62CB ; id 82
    dw Data_02A_62CB ; id 83
    dw Data_02A_62CB ; id 84
    dw Data_02A_62CB ; id 85
    dw Data_02A_6428 ; id 86
    dw Data_02A_6468 ; id 87
    dw Data_02A_64AD ; id 88
    dw Data_02A_64D2 ; id 89
    dw Data_02A_6546 ; id 90
    dw Data_02A_657C ; id 91
    dw Data_02A_664E ; id 92
    dw Data_02A_6689 ; id 93
    dw Data_02A_66C3 ; id 94
    dw Data_02A_670B ; id 95
    dw Data_02A_6770 ; id 96
    dw Data_02A_678A ; id 97
    dw Data_02A_6815 ; id 98
    dw Data_02A_68AD ; id 99
    dw Data_02A_6920 ; id 100
    dw Data_02A_69A3 ; id 101
    dw Data_02A_69E6 ; id 102
    dw Data_02A_6A06 ; id 103
    dw Data_02A_6A53 ; id 104
    dw Data_02A_6ACE ; id 105
    dw Data_02A_6B07 ; id 106
    dw Data_02A_6B43 ; id 107
    dw Data_02A_6BBE ; id 108
    dw Data_02A_6CDD ; id 109
    dw Data_02A_6D44 ; id 110
    dw Data_02A_6D84 ; id 111
    dw Data_02A_6EE8 ; id 112
    dw Data_02A_7021 ; id 113
    dw Data_02A_7044 ; id 114
    dw Data_02A_7092 ; id 115
    dw Data_02A_70B0 ; id 116
    dw Data_02A_70F7 ; id 117
    dw Data_02A_7118 ; id 118
    dw Data_02A_7160 ; id 119
    dw Data_02A_71A0 ; id 120
    dw Data_02A_72CF ; id 121
    dw Data_02A_731A ; id 122
    dw Data_02A_7379 ; id 123
    dw Data_02A_73C0 ; id 124
    dw Data_02A_7432 ; id 125
    dw Data_02A_74BE ; id 126
    dw Data_02A_74E0 ; id 127
    dw Data_02A_7557 ; id 128
    dw Data_02A_75B3 ; id 129
    dw Data_02A_7613 ; id 130
    dw Data_02A_7681 ; id 131
    dw Data_02A_76A4 ; id 132
    dw Data_02A_76E8 ; id 133
    dw Data_02A_774E ; id 134
    dw Data_02A_7805 ; id 135
    dw Data_02A_784C ; id 136
    dw Data_02A_78B6 ; id 137
    dw Data_02A_78FA ; id 138
    dw Data_02A_79A8 ; id 139
    dw Data_02A_7AD7 ; id 140
    dw Data_02A_7B89 ; id 141
    dw Data_02A_7BCD ; id 142
    dw Data_02A_7C12 ; id 143
    dw Data_02A_7C9E ; id 144
    dw Data_02A_7CE9 ; id 145
    dw Data_02A_7D51 ; id 146
    dw Data_02A_7DE0 ; id 147
    dw Data_02A_7E6D ; id 148

Data_02A_415E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You", $42, "e been going", $F1
    db "out a lot lately.", $FA, $F7
    db $EF, $EE, "Where do you go", $EF, $EE, "out to play?", $FA, $F7
    db $EF, $EE, "Oh? You're trying", $EF, $EE, "to save GreatLog?", $FA, $F7
    db $EF, $EE, "Well, my hero, how", $EF, $EE, "about an errand?", $FA, $F7
    db $EF, $EE, "Could you go buy", $EF, $EE, "LoveWater?", $FA, $F7
    db $EF, $EE, "DrakSlime is badly", $EF, $EE, "sunburned, so I", $FA, $F7
    db $EF, $EE, "need to treat its", $EF, $EE, "condition.", $FA, $F7
    db $EF, $EE, "Here's some money.", $EF, $EE, "Keep the change!", $F7
    db $F0

Data_02A_4284:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mom handed over", $F1
    db "200G.", $F7
    db $F0

Data_02A_429B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Buy LoveWater", $F1
    db "for me, OK?", $F7
    db $F0

Data_02A_42B9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I was taking a", $F1
    db "nap in the sun", $A4, $FA, $F7
    db $EF, $EE, "I'm all sunburned!", $EF, $EE, "It hurts!", $F7
    db $F0

Data_02A_42FC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A bridge to the", $F1
    db "island there will", $FA, $F7
    db $EF, $EE, "increase the farm's", $EF, $EE, "space.", $FA, $F7
    db $EF, $EE, "Beavern's helping", $EF, $EE, "with the bridge.", $F7
    db $F0

Data_02A_4366:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I don't need any", $F1
    db "help today, dear.", $F7
    db $F0

Data_02A_438C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're the child", $F1
    db "of the farmer?", $FA, $F7
    db $EF, $EE, "Under his Majesty's", $EF, $EE, "decree, there will", $FA, $F7
    db $EF, $EE, "be a tournament", $EF, $EE, "for child masters.", $FA, $F7
    db $EF, $EE, "He wishes you to", $EF, $EE, "take part.", $FA, $F7
    db $EF, $EE, "Needless to say, a", $EF, $EE, "prize awaits the", $FA, $F7
    db $EF, $EE, "champion-the", $EF, $EE, "PirateKey.", $FA, $F7
    db $EF, $EE, "I'm not good with", $EF, $EE, "this sort of work,", $FA, $F7
    db $EF, $EE, "so I'll just ask", $EF, $EE, "that you come!", $F7
    db $F0

Data_02A_44AF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, what", $F1
    db "was it like in the", $FA, $F7
    db $EF, $EE, "other worlds?", $EF, $EE, "I", $44, " like to know.", $FA, $F7
    db $EF, $EE, $A4, "Oh", $A4, " The TidalBell", $EF, $EE, "wasn't the right", $FA, $F7
    db $EF, $EE, "size to fit the", $EF, $EE, "Log's Navel?", $FA, $F7
    db $EF, $EE, "Are you sure you", $EF, $EE, "can do it, ", $F9, "0?", $FA, $F7
    db $EF, $EE, "Well, yes, I guess", $EF, $EE, "I did leave it up", $FA, $F7
    db $EF, $EE, "to you, ", $F9, "0.", $EF, $EE, "I believe in you.", $FA, $F7
    db $EF, $EE, "Papa expanded the", $EF, $EE, "farm, so we can", $FA, $F7
    db $EF, $EE, "look after more of", $EF, $EE, "your monsters.", $FA, $F7
    db $EF, $EE, "So, what can I do", $EF, $EE, "for you, sis?", $F7
    db $F0

Data_02A_461C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother,", $F1
    db "have you found a", $FA, $F7
    db $EF, $EE, "new plug for the", $EF, $EE, "Log's Navel?", $FA, $F7
    db $EF, $EE, $A4, "Oh", $A4, " The TidalBell", $EF, $EE, "didn't fit", $A4, $FA, $F7
    db $EF, $EE, "But I'm sure that", $EF, $EE, "you can do it.", $FA, $F7
    db $EF, $EE, "Don't give up, big", $EF, $EE, "brother!", $FA, $F7
    db $EF, $EE, "Papa made the farm", $EF, $EE, "a little bigger,", $FA, $F7
    db $EF, $EE, "so you can leave", $EF, $EE, "more monsters.", $FA, $F7
    db $EF, $EE, "Do you need me for", $EF, $EE, "anything?", $F7
    db $F0

Data_02A_4735:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did you know?", $F1
    db "You can record in", $FA, $F7
    db $EF, $EE, "your Journal only", $EF, $EE, "in a castle, town", $FA, $F7
    db $EF, $EE, "or a village in", $EF, $EE, "other worlds.", $F7
    db $F0

Data_02A_47A3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm chopping some", $F1
    db "trees down to make", $FA, $F7
    db $EF, $EE, "the farm larger.", $EF, $EE, "Stay well clear.", $FA, $F7
    db $EF, $EE, "Falling timber is", $EF, $EE, "very hazardous!", $F7
    db $F0

Data_02A_4817:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Take the ladder", $F1
    db "up ahead to the", $FA, $F7
    db $EF, $EE, "Library on the", $EF, $EE, "second level.", $FA, $F7
    db $EF, $EE, "They have many", $EF, $EE, "reference books.", $FA, $F7
    db $EF, $EE, "You should go take", $EF, $EE, "a look sometime.", $F7
    db $F0

Data_02A_48A8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The castle is in", $F1
    db "an uproar because", $FA, $F7
    db $EF, $EE, "Prince Kameha has", $EF, $EE, "disappeared.", $FA, $F7
    db $EF, $EE, "I bet he's hiding", $EF, $EE, "because one of his", $FA, $F7
    db $EF, $EE, "silly pranks was", $EF, $EE, "discovered.", $F7
    db $F0

Data_02A_493B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're too young", $F1
    db "to be shopping.", $FA, $F7
    db $EF, $EE, "Next time, bring", $EF, $EE, "an adult, OK?", $FA, $F7
    db $EF, $EE, $A4, "Oh? An errand for", $EF, $EE, "your mother?", $FA, $F7
    db $EF, $EE, "For a youngster,", $EF, $EE, "you're obviously", $FA, $F7
    db $EF, $EE, "quite responsible.", $EF, $EE, "Sorry about that!", $FA, $F7
    db $EF, $EE, "What can I do for", $EF, $EE, "you today?", $F7
    db $F0

Data_02A_4A15:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome! How may", $F1
    db "I serve you today?", $F7
    db $F0

Data_02A_4A3D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " There are some", $F1
    db "items that can be", $FA, $F7
    db $EF, $EE, "equipped by your", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "D-Scale, which is", $EF, $EE, "sold here, is one.", $FA, $F7
    db $EF, $EE, "But it's just one", $EF, $EE, "item per monster.", $F7
    db $F0

Data_02A_4AD1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, my", $A4, " Where", $F1
    db "did the shop go?", $FA, $F7
    db $EF, $EE, "Just when I needed", $EF, $EE, "to shop too.", $F7
    db $F0

Data_02A_4B18:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I hear rumors", $F1
    db "that Prince Kameha", $FA, $F7
    db $EF, $EE, "was seen near the", $EF, $EE, "Magic Door.", $FA, $F7
    db $EF, $EE, "Is that Prince", $EF, $EE, "going to spread", $FA, $F7
    db $EF, $EE, "his mischief to", $EF, $EE, "other worlds?", $F7
    db $F0

Data_02A_4BA4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh? You bought", $F1
    db "the LoveWater!", $FA, $F7
    db $EF, $EE, "This will heal", $EF, $EE, "DrakSlime!", $FA, $F7
    db $EF, $EE, "Thank you, dear!", $EF, $EE, $F7
    db $F0

Data_02A_4BFA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the LoveWater.", $F7
    db $F0

Data_02A_4C19:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'll get you to", $F1
    db "run more errands.", $FA, $F7
    db $EF, $EE, "Oh, don't look so", $EF, $EE, "glum, dear!", $F7
    db $F0

Data_02A_4C5F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Aooh, LoveWater", $F1
    db "soothes sunburn", $A4, $F7
    db $F0

Data_02A_4C84:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Play it safe", $F1
    db "against Skullroo.", $FA, $F7
    db $EF, $EE, "It's in the final", $EF, $EE, "of the Kids Class.", $FA, $F7
    db $EF, $EE, "Your monsters had", $EF, $EE, "better take cover", $FA, $F7
    db $EF, $EE, "if it starts", $EF, $EE, "charging power.", $FA, $F7
    db $EF, $EE, "Change your Plan", $EF, $EE, "to ", $95, "Defense", $95, " and", $FA, $F7
    db $EF, $EE, "your monsters may", $EF, $EE, "defend themselves.", $F7
    db $F0

Data_02A_4D67:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This leads to", $F1
    db "GreatLog Castle!", $FA, $F7
    db $EF, $EE, "No one enters", $EF, $EE, "without a permit!", $F7
    db $F0

Data_02A_4DAE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Monsters hate", $F1
    db "being away from", $FA, $F7
    db $EF, $EE, "their master.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "They can turn", $EF, $EE, "rebellious out of", $FA, $F7
    db $EF, $EE, "sadness. Try to", $EF, $EE, "understand.", $F7
    db $F0

Data_02A_4E28:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Take this slide", $F1
    db "as a shortcut!", $F7
    db $F0

Data_02A_4E4B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's easy to get", $F1
    db "down, but up? Ugh.", $F7
    db $F0

Data_02A_4E72:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you know", $F1
    db "about LogTwig?", $FA, $F7
    db $EF, $EE, "It's an item that", $EF, $EE, "lets you move a", $FA, $F7
    db $EF, $EE, "Magic Door Shrine", $EF, $EE, "as you wish.", $FA, $F7
    db $EF, $EE, "It used to be sold", $EF, $EE, "here, but", $A4, $F7
    db $F0

Data_02A_4EFB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In other worlds,", $F1
    db "you'll meet other", $FA, $F7
    db $EF, $EE, "travelers like", $EF, $EE, "yourself.", $FA, $F7
    db $EF, $EE, "They're not all", $EF, $EE, "bad people, but", $FA, $F7
    db $EF, $EE, "there are some you", $EF, $EE, "need to watch.", $F7
    db $F0

Data_02A_4F87:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello there,", $F1
    db "youngster!", $FA, $F7
    db $EF, $EE, "Take these stairs", $EF, $EE, "to the Arena.", $FA, $F7
    db $EF, $EE, "Masters pit their", $EF, $EE, "trained monsters", $FA, $F7
    db $EF, $EE, "against each other", $EF, $EE, "down there.", $FA, $F7
    db $EF, $EE, "It's worth a look", $EF, $EE, "if you're a master.", $F7
    db $F0

Data_02A_5039:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, a little", $F1
    db "bitty master! Hi!", $FA, $F7
    db $EF, $EE, "You'll see a good", $EF, $EE, "crowd of skilled", $FA, $F7
    db $EF, $EE, "masters today in", $EF, $EE, "the Arena.", $FA, $F7
    db $EF, $EE, "It's a good chance", $EF, $EE, "to learn a few", $FA, $F7
    db $EF, $EE, "things about some", $EF, $EE, "monsters.", $F7
    db $F0

Data_02A_50E8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, you're a", $F1
    db "mighty lively kid.", $FA, $F7
    db $EF, $EE, "Let me tell you", $EF, $EE, "something.", $FA, $F7
    db $EF, $EE, "Do you know about", $EF, $EE, "TinyMedals?", $FA, $F7
    db $EF, $EE, "They can't be sold,", $EF, $EE, "but they can be", $FA, $F7
    db $EF, $EE, "traded to a", $EF, $EE, "collector.", $FA, $F7
    db $EF, $EE, "You should store", $EF, $EE, "them in the Vault.", $F7
    db $F0

Data_02A_51B8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Take care to", $F1
    db "find Tiny Medals.", $FA, $F7
    db $EF, $EE, "Look in vases and", $EF, $EE, "barrels for them.", $F7
    db $F0

Data_02A_5203:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "There was a plant", $EF, $EE, "sprouting inside.", $F7
    db $F0

Data_02A_5245:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There was also a", $F1
    db "letter.", $FA, $F7
    db $EF, $EE, $95, "This is a gift.", $EF, $EE, "Fwohohoho!", $95, $F7
    db $F0

Data_02A_5280:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pedestal.", $FA, $F7
    db $EF, $EE, "It's the Library", $EF, $EE, "Guide. Read it?", $FF, $F0

Data_02A_52BE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $95, "You may check", $F1
    db "your Catalog of", $FA, $F7
    db $EF, $EE, "monsters in the", $EF, $EE, "Library.", $FA, $F7
    db $EF, $EE, "The monsters you", $EF, $EE, "befriend or breed", $FA, $F7
    db $EF, $EE, "are cataloged by", $EF, $EE, "family, in which", $FA, $F7
    db $EF, $EE, "individual species", $EF, $EE, "are listed.", $FA, $F7
    db $EF, $EE, "To examine your", $EF, $EE, "Catalog, please", $FA, $F7
    db $EF, $EE, "speak to the", $EF, $EE, "receptionist.", $95, $FA, $F7
    db $EF, $EE, $F9, "0 put back the", $EF, $EE, "Library Guide.", $F7
    db $F0

Data_02A_53D2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 put back the", $F1
    db "Library Guide.", $F7
    db $F0

Data_02A_53F2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to the", $F1
    db "Library.", $FA, $F7
    db $EF, $EE, "You may check your", $EF, $EE, "Catalog here.", $FA, $F7
    db $EF, $EE, "The Catalog is", $EF, $EE, "personalized, so", $FA, $F7
    db $EF, $EE, "it won't contain", $EF, $EE, "data on monsters", $FA, $F7
    db $EF, $EE, "that you don't", $EF, $EE, "know. Anyway", $A4, $FA, $F7
    db $EF, $EE, "Which family would", $EF, $EE, "you like to check?", $F7
    db $F0

Data_02A_54C6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to the", $F1
    db "Library.", $FA, $F7
    db $EF, $EE, "Which family would", $EF, $EE, "you like to check?", $F7
    db $F0

Data_02A_550C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are books", $F1
    db "that change your", $FA, $F7
    db $EF, $EE, "personality just", $EF, $EE, "by reading them.", $F7
    db $F0

Data_02A_5557:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " WarpWing returns", $F1
    db "you instantly to", $FA, $F7
    db $EF, $EE, "GreatLog, so I", $EF, $EE, "take one with me", $FA, $F7
    db $EF, $EE, "when I visit other", $EF, $EE, "worlds.", $F7
    db $F0

Data_02A_55C0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Snivel", $A4, " This", $F1
    db "book is so sad", $A4, $F7
    db $F0

Data_02A_55E1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Even I can cast", $F1
    db "spells if I have", $FA, $F7
    db $EF, $EE, "the right kind of", $EF, $EE, "staff.", $F7
    db $F0

Data_02A_5623:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do you have any", $F1
    db "idea about this", $FA, $F7
    db $EF, $EE, "monster families", $EF, $EE, "business?", $FF, $F0

Data_02A_5666:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " You", $42, "e read", $F1
    db "this book before.", $F7
    db $F0

Data_02A_568B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Monsters can be", $F1
    db "categorized in ten", $FA, $F7
    db $EF, $EE, "groups according", $EF, $EE, "to their features.", $FA, $F7
    db $EF, $EE, "Slime, dragon,", $EF, $EE, "beast, bird,", $FA, $F7
    db $EF, $EE, "plant, bug, devil,", $EF, $EE, "material, water", $A4, $FA, $F7
    db $EF, $EE, "and", $A4, " Ah-choo!", $EF, $EE, "Excuse me!", $FA, $F7
    db $EF, $EE, "Those ten groups", $EF, $EE, "are families.", $F7
    db $F0

Data_02A_5762:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Monster Skills", $A4, $EF, $EE, "Every species of", $FA, $F7
    db $EF, $EE, "monsters learns", $EF, $EE, "three skills.", $95, $F7
    db $F0

Data_02A_57C6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Monster Growth", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "By experiencing", $F1
    db "battle, monsters", $FA, $F7
    db $EF, $EE, "will gain power", $EF, $EE, "and skills.", $95, $F7
    db $F0

Data_02A_583D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Personalities of", $EF, $EE, "Monsters", $A4, $FA, $F7
    db $EF, $EE, "Personalities are", $EF, $EE, "changed by the", $FA, $F7
    db $EF, $EE, "master's battle", $EF, $EE, "plan.", $FA, $F7
    db $EF, $EE, "Personality", $EF, $EE, "affects behavior.", $95, $F7
    db $F0

Data_02A_58D9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Nuts and Seeds", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "ATKseed and", $EF, $EE, "MysticNut are rare", $FA, $F7
    db $EF, $EE, "items that enhance", $EF, $EE, "stats slightly.", $95, $F7
    db $F0

Data_02A_5956:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "WorldLeaf", $A4, $EF, $EE, "An indispensable", $FA, $F7
    db $EF, $EE, "and mystic item", $EF, $EE, "that summons the", $FA, $F7
    db $EF, $EE, "soul of any dead", $EF, $EE, "monster.", $95, $F7
    db $F0

Data_02A_59D6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Magic Key Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Every Magic Key is", $EF, $EE, "an original that", $FA, $F7
    db $EF, $EE, "opens the door to", $EF, $EE, "another world that", $FA, $F7
    db $EF, $EE, "is unlike any", $EF, $EE, "other.", $95, $F7
    db $F0

Data_02A_5A74:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Magic Key Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Unnamed Magic Keys", $EF, $EE, "cannot be used", $FA, $F7
    db $EF, $EE, "until they are", $EF, $EE, "appraised.", $FA, $F7
    db $EF, $EE, "Otherwise, it's", $EF, $EE, "impossible to", $FA, $F7
    db $EF, $EE, "figure out its", $EF, $EE, "destination.", $95, $F7
    db $F0

Data_02A_5B2D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Starry Shrine", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "A sacred place", $EF, $EE, "that draws the", $FA, $F7
    db $EF, $EE, "Tree's life force", $EF, $EE, "from its roots to", $FA, $F7
    db $EF, $EE, "breed and hatch", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "From eggs come", $EF, $EE, "offspring that", $FA, $F7
    db $EF, $EE, "inherit the", $EF, $EE, "attributes and", $FA, $F7
    db $EF, $EE, "skills of its", $EF, $EE, "parents.", $95, $F7
    db $F0

Data_02A_5C22:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Egg Evaluators", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Those with the", $EF, $EE, "special ability to", $FA, $F7
    db $EF, $EE, "determine what", $EF, $EE, "hides in an Egg.", $FA, $F7
    db $EF, $EE, "They are also able", $EF, $EE, "to alter the", $FA, $F7
    db $EF, $EE, "gender of the Egg", $EF, $EE, "through singing.", $95, $F7
    db $F0

Data_02A_5CEA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Accessory Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "A monster can wear", $EF, $EE, "one accessory.", $FA, $F7
    db $EF, $EE, "Accessories have", $EF, $EE, "many effects.", $95, $F7
    db $F0

Data_02A_5D67:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Hidden Abilities", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Monsters remain", $EF, $EE, "mysterious in many", $FA, $F7
    db $EF, $EE, "ways.They may have", $EF, $EE, "hidden abilities", $A4, $95, $F7
    db $F0

Data_02A_5DEC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $EF, $EE, "notice.", $FA, $F7
    db $EF, $EE, $95, "Please return", $EF, $EE, "books to their ", $FA, $F7
    db $EF, $EE, "proper places!", $EF, $EE, "-The Librarian.", $95, $F7
    db $F0

Data_02A_5E49:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I was on my way", $F1
    db "to the Magic Door", $FA, $F7
    db $EF, $EE, "so I could go to", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "Warubou stopped me", $EF, $EE, "and demanded help.", $FA, $F7
    db $EF, $EE, "But, I", $42, "e been", $EF, $EE, "conned enough by", $FA, $F7
    db $EF, $EE, "that prankster.", $EF, $EE, "Not this time!", $F7
    db $F0

Data_02A_5F03:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Pack properly if", $F1
    db "you're going off", $FA, $F7
    db $EF, $EE, "to another world.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Some have never", $EF, $EE, "returned", $A4, $F7
    db $F0

Data_02A_5F5E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Try the slide!", $F1
    db "It's a shortcut!", $F7
    db $F0

Data_02A_5F81:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My dad's a famous", $F1
    db "monster master.", $FA, $F7
    db $EF, $EE, "I'm going to be", $EF, $EE, "just like him!", $F7
    db $F0

Data_02A_5FC8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Bookmark", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Place inside the", $EF, $EE, "Journal to record", $FA, $F7
    db $EF, $EE, "your quest in any", $EF, $EE, "location.", $95, $F7
    db $F0

Data_02A_603C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Journal", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "A book that keeps", $EF, $EE, "record of your", $FA, $F7
    db $EF, $EE, "adventure.", $EF, $EE, "Can only be used", $FA, $F7
    db $EF, $EE, "in safe locations", $EF, $EE, "in other worlds.", $95, $F7
    db $F0

Data_02A_60D4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "colorful fruits.", $F7
    db $F0

Data_02A_6116:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, let me ask", $F1
    db "you something.", $FA, $F7
    db $EF, $EE, "Did you see the", $EF, $EE, "woman next door?", $FF, $F0

Data_02A_615E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did she say", $F1
    db "anything to you?", $FA, $F7
    db $EF, $EE, "She's a nasty", $EF, $EE, "piece of work.", $FA, $F7
    db $EF, $EE, "How can she yap so", $EF, $EE, "much?", $F7
    db $F0

Data_02A_61BC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good, you're", $F1
    db "lucky!", $FA, $F7
    db $EF, $EE, "Stay away, that's", $EF, $EE, "the thing.", $F7
    db $F0

Data_02A_61F3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Diary", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "A girl with pretty", $EF, $EE, "eyes moved in next", $FA, $F7
    db $EF, $EE, "door. I thought I", $EF, $EE, "lucked out.", $FA, $F7
    db $EF, $EE, "But she had a", $EF, $EE, "sharp tongue", $A4, $95, $F7
    db $F0

Data_02A_6289:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "plush doll.", $FA, $F7
    db $EF, $EE, "It was fluffy and", $EF, $EE, "too big to hug.", $F7
    db $F0

Data_02A_62CB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The farm grew a", $F1
    db "lot bigger.", $FA, $F7
    db $EF, $EE, "Including the", $EF, $EE, "monsters with you,", $FA, $F7
    db $EF, $EE, "the farm can hold", $EF, $EE, "up to 20 now.", $FA, $F7
    db $EF, $EE, "Monsters in the", $EF, $EE, "farm earn some", $FA, $F7
    db $EF, $EE, "EX points as you", $EF, $EE, "battle.", $FA, $F7
    db $EF, $EE, "But if you leave", $EF, $EE, "them in the farm,", $FA, $F7
    db $EF, $EE, "they will grow", $EF, $EE, "without learning", $FA, $F7
    db $EF, $EE, "skills, and they", $EF, $EE, "turn disobedient.", $FA, $F7
    db $EF, $EE, "So, you should", $EF, $EE, "take different", $FA, $F7
    db $EF, $EE, "monsters out to", $EF, $EE, "train them.", $F7
    db $F0

Data_02A_6428:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It was jammed with", $EF, $EE, "fancy clothing.", $F7
    db $F0

Data_02A_6468:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Did you know", $F1
    db "that there's a", $FA, $F7
    db $EF, $EE, "place for changing", $EF, $EE, "monster names?", $FF, $F0

Data_02A_64AD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Monsters should", $F1
    db "have cute names.", $F7
    db $F0

Data_02A_64D2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Go visit the", $F1
    db "Christener.", $FA, $F7
    db $EF, $EE, "She's a lovely", $EF, $EE, "lady.", $FA, $F7
    db $EF, $EE, "She's not anything", $EF, $EE, "like that creep", $FA, $F7
    db $EF, $EE, "who lives next", $EF, $EE, "door!", $F7
    db $F0

Data_02A_6546:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It was tidily", $EF, $EE, "organized.", $F7
    db $F0

Data_02A_657C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "This is the first", $EF, $EE, "day for me alone.", $FA, $F7
    db $EF, $EE, "While moving in,", $EF, $EE, "I noticed a good", $FA, $F7
    db $EF, $EE, "looking man living", $EF, $EE, "next door.", $FA, $F7
    db $EF, $EE, "But he stared and", $EF, $EE, "whistled at me!", $FA, $F7
    db $EF, $EE, "How rude and so", $EF, $EE, "ungallant!", $95, $F7
    db $F0

Data_02A_664E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the mirror.", $FA, $F7
    db $EF, $EE, "A little girl", $EF, $EE, "peered back.", $F7
    db $F0

Data_02A_6689:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the mirror.", $FA, $F7
    db $EF, $EE, "A little boy", $EF, $EE, "stared back.", $F7
    db $F0

Data_02A_66C3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My granddaughter", $F1
    db "is painfully shy.", $FA, $F7
    db $EF, $EE, "She seems so sad", $EF, $EE, "by herself", $A4, $F7
    db $F0

Data_02A_670B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e never seen", $F1
    db "my granddaughter", $FA, $F7
    db $EF, $EE, "so happy and full", $EF, $EE, "of life.", $FA, $F7
    db $EF, $EE, "Let me thank you", $EF, $EE, "with a gift.", $F7
    db $F0

Data_02A_6770:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "a LifeAcorn.", $F7
    db $F0

Data_02A_678A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e never seen", $F1
    db "my granddaughter", $FA, $F7
    db $EF, $EE, "so happy and full", $EF, $EE, "of life.", $FA, $F7
    db $EF, $EE, "Let me thank you", $EF, $EE, "with a gift.", $FA, $F7
    db $EF, $EE, $A4, "Oh, but you have", $EF, $EE, "no room for it.", $F7
    db $F0

Data_02A_6815:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My granddaughter", $F1
    db "now insists that", $FA, $F7
    db $EF, $EE, "she will become a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "Well, whatever the", $EF, $EE, "case, I'm delighted", $FA, $F7
    db $EF, $EE, "that she is happy", $EF, $EE, "and lively.", $F7
    db $F0

Data_02A_68AD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " You're so", $F1
    db "lucky to have some", $FA, $F7
    db $EF, $EE, "friends like that.", $EF, $EE, "I wish I had one.", $FA, $F7
    db $EF, $EE, "A SpotSlime would", $EF, $EE, "be so adorable", $A4, $F7
    db $F0

Data_02A_6920:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " You're so", $F1
    db "lucky to have", $FA, $F7
    db $EF, $EE, "friends like that.", $EF, $EE, "I wish I had one.", $FA, $F7
    db $EF, $EE, "Your SpotSlime is", $EF, $EE, "so adorable", $A4, $FA, $F7
    db $EF, $EE, "Um", $A4, " Can I have it?", $EF, $EE, $FF, $F0

Data_02A_69A3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " R", $A4, " Really?", $F1
    db "Wow! Thank you!", $FA, $F7
    db $EF, $EE, "I promise, I'll", $EF, $EE, "take care of it!", $F7
    db $F0

Data_02A_69E6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " Sorry", $A4, $F1
    db "It's your friend", $A4, $F7
    db $F0

Data_02A_6A06:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " What should I do", $EF, $EE, "with Butch today", $A4, $FA, $F7
    db $EF, $EE, "That's what I named", $EF, $EE, "my SpotSlime.", $F7
    db $F0

Data_02A_6A53:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Yep, she's taking", $F1
    db "good care of me.", $FA, $F7
    db $EF, $EE, "But I need to get", $EF, $EE, "more exercise.", $FA, $F7
    db $EF, $EE, "I might bloat up", $EF, $EE, "to become a", $FA, $F7
    db $EF, $EE, "SpotKing!", $EF, $EE, $F7
    db $F0

Data_02A_6ACE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "Girls", $95, " clothes", $EF, $EE, "were inside.", $F7
    db $F0

Data_02A_6B07:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "plush doll.", $FA, $F7
    db $EF, $EE, "It had patches all", $EF, $EE, "over it.", $F7
    db $F0

Data_02A_6B43:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "Masters pit their", $EF, $EE, "teams in battle", $FA, $F7
    db $EF, $EE, "to test their", $EF, $EE, "power.", $FA, $F7
    db $EF, $EE, "Will you enter", $EF, $EE, "your monsters?", $FF, $F0

Data_02A_6BBE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You're young, so", $F1
    db "you have to start", $FA, $F7
    db $EF, $EE, "in the Kids Class.", $EF, $EE, "But don't scoff!", $FA, $F7
    db $EF, $EE, "You'll lose if", $EF, $EE, "you're complacent.", $FA, $F7
    db $EF, $EE, "Here are the", $EF, $EE, "Arena rules.", $FA, $F7
    db $EF, $EE, "You can't use any", $EF, $EE, "items in battle.", $FA, $F7
    db $EF, $EE, "And you forfeit if", $EF, $EE, "you flee.", $FA, $F7
    db $EF, $EE, "Win three battles", $EF, $EE, "to take the title.", $FA, $F7
    db $EF, $EE, "The PirateKey is", $EF, $EE, "the prize.", $F7
    db $F0

Data_02A_6CDD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, then you", $F1
    db "must be here to", $FA, $F7
    db $EF, $EE, "see how other", $EF, $EE, "masters battle.", $FA, $F7
    db $EF, $EE, "Take the corridor", $EF, $EE, "on the right.", $F7
    db $F0

Data_02A_6D44:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You lost?", $F1
    db "That's too bad.", $FA, $F7
    db $EF, $EE, "Train some more", $EF, $EE, "and try again!", $F7
    db $F0

Data_02A_6D84:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db "You're the champ!", $FA, $F7
    db $EF, $EE, "For winning the", $EF, $EE, "Kids Class, you", $42, "e", $FA, $F7
    db $EF, $EE, "earned the King's", $EF, $EE, "recognition as an", $FA, $F7
    db $EF, $EE, "official monster", $EF, $EE, "master.", $FA, $F7
    db $EF, $EE, "You can now use", $EF, $EE, "the Starry Shrine", $FA, $F7
    db $EF, $EE, "and the Egg", $EF, $EE, "Evaluator.", $FA, $F7
    db $EF, $EE, "From now on, you", $EF, $EE, "will face adults", $FA, $F7
    db $EF, $EE, "in the Arena", $94, $EF, $EE, "so be sure to", $FA, $F7
    db $EF, $EE, "continue raising", $EF, $EE, "stronger monsters.", $FA, $F7
    db $EF, $EE, "Here's your prize,", $EF, $EE, "the PirateKey!", $F7
    db $F0

Data_02A_6EE8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "The rules are", $A4, $EF, $EE, "Well, you know.", $FA, $F7
    db $EF, $EE, "You'll be facing", $EF, $EE, "grownups too now.", $FA, $F7
    db $EF, $EE, "There are four", $EF, $EE, "classes in all.", $FA, $F7
    db $EF, $EE, "By becoming the", $EF, $EE, "champ of a class,", $FA, $F7
    db $EF, $EE, "you will earn a", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, "If you win the", $EF, $EE, "S Class title,", $FA, $F7
    db $EF, $EE, "you will face even", $EF, $EE, "tougher masters.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F7
    db $F0

Data_02A_7021:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hello, which", $F1
    db "Class will it be?", $F7
    db $F0

Data_02A_7044:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db "You're the champ!", $FA, $F7
    db $EF, $EE, "The D Class Champ", $EF, $EE, "wins a Magic Key!", $F7
    db $F0

Data_02A_7092:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "a Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Data_02A_70B0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh? But your key", $F1
    db "ring is full.", $FA, $F7
    db $EF, $EE, "Make room, and", $EF, $EE, "return for this!", $F7
    db $F0

Data_02A_70F7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Here's the Magic", $F1
    db "Key you won!", $F7
    db $F0

Data_02A_7118:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " If you want to", $F1
    db "enter, please", $FA, $F7
    db $EF, $EE, "register with the", $EF, $EE, "girl next to me.", $F7
    db $F0

Data_02A_7160:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "hear the rules?", $FF, $F0

Data_02A_71A0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Your party may", $F1
    db "enter in battles", $FA, $F7
    db $EF, $EE, "ranging from the", $EF, $EE, "C to S Class, but", $FA, $F7
    db $EF, $EE, "there is an entry", $EF, $EE, "fee per Class.", $FA, $F7
    db $EF, $EE, "Win three battles", $EF, $EE, "to take the title.", $FA, $F7
    db $EF, $EE, "A Magic Key is the", $EF, $EE, "champ's prize.", $FA, $F7
    db $EF, $EE, "You can't use any", $EF, $EE, "items in battle.", $FA, $F7
    db $EF, $EE, "And you forfeit if", $EF, $EE, "you flee.", $FA, $F7
    db $EF, $EE, "Shoot for glory as", $EF, $EE, "the S Class champ!", $F7
    db $F0

Data_02A_72CF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oops, it's not", $F1
    db "your first time!", $FA, $F7
    db $EF, $EE, "Please excuse my", $EF, $EE, "rudeness, sweetie!", $F7
    db $F0

Data_02A_731A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Listen, this is", $F1
    db "a secret.", $FA, $F7
    db $EF, $EE, "There's a man who", $EF, $EE, "trades TinyMedals", $FA, $F7
    db $EF, $EE, "for impressive", $EF, $EE, "gifts.", $F7
    db $F0

Data_02A_7379:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Which to take?", $F1
    db "Monsters you", $42, "e", $FA, $F7
    db $EF, $EE, "raised, or those", $EF, $EE, "you befriended?", $F7
    db $F0

Data_02A_73C0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You need luck on", $F1
    db "your side to win", $FA, $F7
    db $EF, $EE, "at the Arena.", $EF, $EE, "Put another way,", $FA, $F7
    db $EF, $EE, "you could win just", $EF, $EE, "by getting lucky.", $F7
    db $F0

Data_02A_7432:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " What do you", $F1
    db "suppose monsters", $FA, $F7
    db $EF, $EE, "are thinking?", $EF, $EE, "I can never tell.", $FA, $F7
    db $EF, $EE, "It bothers me when", $EF, $EE, "they stare.", $FA, $F7
    db $EF, $EE, "Do they consider", $EF, $EE, "me to be food?", $F7
    db $F0

Data_02A_74BE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GRAH, HUNGRY.", $F1
    db "LOOK DELICIOUS", $A4, $F7
    db $F0

Data_02A_74E0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It's not easy to", $F1
    db "win right away.", $FA, $F7
    db $EF, $EE, "Take note of your", $EF, $EE, "opponents, and put", $FA, $F7
    db $EF, $EE, "together a winning", $EF, $EE, "team and strategy!", $F7
    db $F0

Data_02A_7557:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Mama is a big", $F1
    db "worrier", $A4, $FA, $F7
    db $EF, $EE, "But she wants me", $EF, $EE, "to be a master", $A4, $FA, $F7
    db $EF, $EE, "How selfish can", $EF, $EE, "she be?", $F7
    db $F0

Data_02A_75B3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, a cute", $F1
    db "little master!", $FA, $F7
    db $EF, $EE, "Are you going to", $EF, $EE, "compete?", $FA, $F7
    db $EF, $EE, $A4, "Want to hear", $EF, $EE, "something useful?", $FF, $F0

Data_02A_7613:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the Kids", $F1
    db "Class final, watch", $FA, $F7
    db $EF, $EE, "out for KiteHawk.", $EF, $EE, "Monsters need to", $FA, $F7
    db $EF, $EE, "take guard if it", $EF, $EE, "charges power.", $F7
    db $F0

Data_02A_7681:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh. Well, I'll", $F1
    db "be here for you.", $F7
    db $F0

Data_02A_76A4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I come to watch", $F1
    db "every day.", $FA, $F7
    db $EF, $EE, "The masters are", $EF, $EE, "getting tougher!", $F7
    db $F0

Data_02A_76E8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Monsters mirror", $F1
    db "their masters.", $FA, $F7
    db $EF, $EE, "The plans you give", $EF, $EE, "in battle", $FA, $F7
    db $EF, $EE, "gradually change", $EF, $EE, "personality.", $F7
    db $F0

Data_02A_774E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Arena is", $F1
    db "where masters can", $FA, $F7
    db $EF, $EE, "test their mettle", $EF, $EE, "against others.", $FA, $F7
    db $EF, $EE, "Battles between", $EF, $EE, "tough masters are", $FA, $F7
    db $EF, $EE, "intense to see,", $EF, $EE, "let me tell you.", $FA, $F7
    db $EF, $EE, "The S Class is", $EF, $EE, "especially hot!", $F7
    db $F0

Data_02A_7805:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters can", $F1
    db "grow only so much.", $FA, $F7
    db $EF, $EE, "They won't level", $EF, $EE, "up after that.", $F7
    db $F0

Data_02A_784C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " My husband is a", $F1
    db "master still.", $FA, $F7
    db $EF, $EE, "He may be old, but", $EF, $EE, "he has knowledge", $FA, $F7
    db $EF, $EE, "that the young", $EF, $EE, "people don't.", $F7
    db $F0

Data_02A_78B6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello there.", $F1
    db "Do you know about", $FA, $F7
    db $EF, $EE, "the Starry Night", $EF, $EE, "Tournament?", $FF, $F0

Data_02A_78FA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The strongest", $F1
    db "master I", $42, "e ever", $FA, $F7
    db $EF, $EE, "seen, that had to", $EF, $EE, "be GreatLog's rep", $FA, $F7
    db $EF, $EE, "in the last Starry", $EF, $EE, "Night Tournament.", $FA, $F7
    db $EF, $EE, "Her name was", $EF, $EE, "Milayou.", $FA, $F7
    db $EF, $EE, "She came so close", $EF, $EE, "to winning!", $F7
    db $F0

Data_02A_79A8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You don't know?", $F1
    db "Sorry about that.", $FA, $F7
    db $EF, $EE, "The Starry Night", $EF, $EE, "Tournament is held", $FA, $F7
    db $EF, $EE, "on the night of a", $EF, $EE, "meteor shower that", $FA, $F7
    db $EF, $EE, "arrives on every", $EF, $EE, "47th full moon.", $FA, $F7
    db $EF, $EE, "On that night,", $EF, $EE, "masters gather", $FA, $F7
    db $EF, $EE, "from all over the", $EF, $EE, "world to battle.", $FA, $F7
    db $EF, $EE, "The winner is said", $EF, $EE, "to bring great", $FA, $F7
    db $EF, $EE, "happiness to their", $EF, $EE, "home kingdom.", $F7
    db $F0

Data_02A_7AD7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Listen, to win", $F1
    db "you need balance.", $FA, $F7
    db $EF, $EE, "Attack, support", $EF, $EE, "and heal-these", $FA, $F7
    db $EF, $EE, "roles should be", $EF, $EE, "assigned to your", $FA, $F7
    db $EF, $EE, "monsters in a", $EF, $EE, "balanced manner.", $FA, $F7
    db $EF, $EE, "That's the recipe", $EF, $EE, "for victory.", $F7
    db $F0

Data_02A_7B89:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's not all", $F1
    db "about winning.", $FA, $F7
    db $EF, $EE, "We should, like,", $EF, $EE, "take it easier.", $F7
    db $F0

Data_02A_7BCD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Arrrrroooh!", $F1
    db "My blood burns!", $FA, $F7
    db $EF, $EE, "I can taste the", $EF, $EE, "glory of battle!", $F7
    db $F0

Data_02A_7C12:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you come", $F1
    db "across a monster", $FA, $F7
    db $EF, $EE, "that you want,", $EF, $EE, "don't be stingy.", $FA, $F7
    db $EF, $EE, "Give it lots of", $EF, $EE, "tasty meat.", $FA, $F7
    db $EF, $EE, "That will make it", $EF, $EE, "want to join you.", $F7
    db $F0

Data_02A_7C9E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Sirloin is the", $F1
    db "tops, harrumph!", $FA, $F7
    db $EF, $EE, "It just seems to", $EF, $EE, "melt in the mouth!", $F7
    db $F0

Data_02A_7CE9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $A4, " I didn't fall", $F1
    db "for any meat.", $FA, $F7
    db $EF, $EE, "I was impressed by", $EF, $EE, "my master", $A4, $FA, $F7
    db $EF, $EE, "Hey! Don't look", $EF, $EE, "skeptical at me!", $F7
    db $F0

Data_02A_7D51:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " They take entry", $F1
    db "fees from masters", $FA, $F7
    db $EF, $EE, "for competing in", $EF, $EE, "the Arena.", $FA, $F7
    db $EF, $EE, "The fee goes up", $EF, $EE, "with the Class.", $FA, $F7
    db $EF, $EE, "The Kids Class is", $EF, $EE, "free to enter.", $F7
    db $F0

Data_02A_7DE0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you win in", $F1
    db "the S Class, you", $FA, $F7
    db $EF, $EE, "can enter in more", $EF, $EE, "battles to earn", $FA, $F7
    db $EF, $EE, "Magic Keys and", $EF, $EE, "special items.", $FA, $F7
    db $EF, $EE, "I should become a", $EF, $EE, "master too.", $F7
    db $F0

Data_02A_7E6D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " If you win an", $F1
    db "Arena tourney,", $FA, $F7
    db $EF, $EE, "your prize is a", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, "But you have to", $EF, $EE, "get it appraised", $FA, $F7
    db $EF, $EE, "at the Key Shop to", $EF, $EE, "use it.", $F7
    db $F0
    ds $10F, $00
