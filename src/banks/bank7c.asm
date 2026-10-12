SECTION "Bank 7C", ROMX[$4000], BANK[$7C]
    db $7C

; message bank $7C: when wStringIndex < $87, BeginStringDisplay with this bank's table Data_07C_4032; otherwise far-calls Func_099_404B (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_Case09, ScriptCommand09_Case01_Sub01_Case08, ShowMessageHL_Case08)
; reads: wStringIndex
BeginStringDisplay_Bank7C::
Func_07C_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $87
    jr c, Jump_07C_400F
    farcall BeginStringDisplay_Bank7C_Overflow
    ret

Jump_07C_400F::
    ld de, MessageStrings_Bank7C
    call BeginStringDisplay
    ret

; message bank $7C: when wStringIndex < $87, CopyStringToBuffer with this bank's table Data_07C_4032; otherwise far-calls Func_099_405A (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank7C:: ; heuristic: follows a terminator; C0
Func_07C_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $87
    jr c, Jump_07C_4024
    farcall CopyStringToBuffer_Bank7C_Overflow
    ret

Jump_07C_4024::
    ld de, MessageStrings_Bank7C
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_7C_4032::
MessageStrings_Bank7C:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_07C_4032:: ; address name
    dw StringList_7C_4034 ; id 0

; E-0217 (derived: category list of StringCategories_7C_4032; one pointer per wStringIndex)
; record: string
StringList_7C_4034::
Data_07C_4034:: ; address name
    dw Message_08_00 ; id 0
    dw Message_08_01 ; id 1
    dw Message_08_02 ; id 2
    dw Message_08_03 ; id 3
    dw Message_08_04 ; id 4
    dw Message_08_05 ; id 5
    dw Message_08_06 ; id 6
    dw Message_08_07 ; id 7
    dw Message_08_08 ; id 8
    dw Message_08_09 ; id 9
    dw Message_08_0A ; id 10
    dw Message_08_0B ; id 11
    dw Message_08_0C ; id 12
    dw Message_08_0D ; id 13
    dw Message_08_0E ; id 14
    dw Message_08_0F ; id 15
    dw Message_08_10 ; id 16
    dw Message_08_11 ; id 17
    dw Message_08_12 ; id 18
    dw Message_08_13 ; id 19
    dw Message_08_14 ; id 20
    dw Message_08_15 ; id 21
    dw Message_08_16 ; id 22
    dw Message_08_17 ; id 23
    dw Message_08_18 ; id 24
    dw Message_08_19 ; id 25
    dw Message_08_1A ; id 26
    dw Message_08_1B ; id 27
    dw Message_08_1C ; id 28
    dw Message_08_1D ; id 29
    dw Message_08_1E ; id 30
    dw Message_08_1F ; id 31
    dw Message_08_20 ; id 32
    dw Message_08_21 ; id 33
    dw Message_08_22 ; id 34
    dw Message_08_23 ; id 35
    dw Message_08_24 ; id 36
    dw Message_08_25 ; id 37
    dw Message_08_26 ; id 38
    dw Message_08_27 ; id 39
    dw Message_08_28 ; id 40
    dw Message_08_28 ; id 41
    dw Message_08_2A ; id 42
    dw Message_08_2B ; id 43
    dw Message_08_2C ; id 44
    dw Message_08_2D ; id 45
    dw Message_08_2E ; id 46
    dw Message_08_2F ; id 47
    dw Message_08_30 ; id 48
    dw Message_08_31 ; id 49
    dw Message_08_32 ; id 50
    dw Message_08_33 ; id 51
    dw Message_08_34 ; id 52
    dw Message_08_35 ; id 53
    dw Message_08_36 ; id 54
    dw Message_08_37 ; id 55
    dw Message_08_38 ; id 56
    dw Message_08_39 ; id 57
    dw Message_08_3A ; id 58
    dw Message_08_3B ; id 59
    dw Message_08_3C ; id 60
    dw Message_08_3D ; id 61
    dw Message_08_3E ; id 62
    dw Message_08_3F ; id 63
    dw Message_08_40 ; id 64
    dw Message_08_41 ; id 65
    dw Message_08_42 ; id 66
    dw Message_08_43 ; id 67
    dw Message_08_44 ; id 68
    dw Message_08_45 ; id 69
    dw Message_08_46 ; id 70
    dw Message_08_47 ; id 71
    dw Message_08_48 ; id 72
    dw Message_08_49 ; id 73
    dw Message_08_4A ; id 74
    dw Message_08_4B ; id 75
    dw Message_08_4C ; id 76
    dw Message_08_4D ; id 77
    dw Message_08_4E ; id 78
    dw Message_08_4F ; id 79
    dw Message_08_50 ; id 80
    dw Message_08_51 ; id 81
    dw Message_08_52 ; id 82
    dw Message_08_53 ; id 83
    dw Message_08_54 ; id 84
    dw Message_08_55 ; id 85
    dw Message_08_56 ; id 86
    dw Message_08_57 ; id 87
    dw Message_08_58 ; id 88
    dw Message_08_59 ; id 89
    dw Message_08_5A ; id 90
    dw Message_08_5B ; id 91
    dw Message_08_5C ; id 92
    dw Message_08_5D ; id 93
    dw Message_08_5E ; id 94
    dw Message_08_5F ; id 95
    dw Message_08_60 ; id 96
    dw Message_08_61 ; id 97
    dw Message_08_62 ; id 98
    dw Message_08_63 ; id 99
    dw Message_08_64 ; id 100
    dw Message_08_65 ; id 101
    dw Message_08_66 ; id 102
    dw Message_08_67 ; id 103
    dw Message_08_68 ; id 104
    dw Message_08_69 ; id 105
    dw Message_08_6A ; id 106
    dw Message_08_6B ; id 107
    dw Message_08_6C ; id 108
    dw Message_08_6D ; id 109
    dw Message_08_6E ; id 110
    dw Message_08_6F ; id 111
    dw Message_08_70 ; id 112
    dw Message_08_71 ; id 113
    dw Message_08_72 ; id 114
    dw Message_08_73 ; id 115
    dw Message_08_74 ; id 116
    dw Message_08_75 ; id 117
    dw Message_08_76 ; id 118
    dw Message_08_77 ; id 119
    dw Message_08_78 ; id 120
    dw Message_08_79 ; id 121
    dw Message_08_7A ; id 122
    dw Message_08_7B ; id 123
    dw Message_08_7C ; id 124
    dw Message_08_7D ; id 125
    dw Message_08_7E ; id 126
    dw Message_08_7F ; id 127
    dw Message_08_80 ; id 128
    dw Message_08_81 ; id 129
    dw Message_08_82 ; id 130
    dw Message_08_83 ; id 131
    dw Message_08_84 ; id 132
    dw Message_08_85 ; id 133
    dw Message_08_86 ; id 134

Message_08_00:: ; heuristic: string; C0
Data_07C_4142:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "village of Yold.", $FA, $F7
    db $EF, $EE, "We're known for", $EF, $EE, "our fresh fish.", $F7
    db $F0

Message_08_01:: ; heuristic: string; C0
Data_07C_4186:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the northwest", $F1
    db "is a village that", $FA, $F7
    db $EF, $EE, "is famous for", $EF, $EE, "mermaids.", $F7
    db $F0

Message_08_02:: ; heuristic: string; C0
Data_07C_41C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Around these", $F1
    db "parts it's faster", $FA, $F7
    db $EF, $EE, "to travel by boat", $EF, $EE, "than walking,", $FA, $F7
    db $EF, $EE, "so everyone has", $EF, $EE, "their own boat.", $FA, $F7
    db $EF, $EE, "In the olden days", $EF, $EE, "it was dangerous", $FA, $F7
    db $EF, $EE, "because there were", $EF, $EE, "pirates.", $F7
    db $F0

Message_08_03:: ; heuristic: string; C0
Data_07C_427A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I saw a haunted", $F1
    db "ship in the north.", $FA, $F7
    db $EF, $EE, "It scared me so", $EF, $EE, "much, I can't get", $FA, $F7
    db $EF, $EE, "out of bed.", $EF, $EE, "Oooh, scary!", $F7
    db $F0

Message_08_04:: ; heuristic: string; C0
Data_07C_42E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The volcanic", $F1
    db "island off the", $FA, $F7
    db $EF, $EE, "coast appears to", $EF, $EE, "be in a bad mood.", $FA, $F7
    db $EF, $EE, "There have been", $EF, $EE, "many quakes.", $FA, $F7
    db $EF, $EE, "The fish aren't", $EF, $EE, "biting at all.", $F7
    db $F0

Message_08_05:: ; heuristic: string; C0
Data_07C_436D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Mermaids lived", $F1
    db "in the sea in the", $FA, $F7
    db $EF, $EE, "northwest. Among", $EF, $EE, "their treasures", $FA, $F7
    db $EF, $EE, "was a round mirror", $EF, $EE, "called HarMirror,", $FA, $F7
    db $EF, $EE, "but it was stolen", $EF, $EE, "by pirates.", $FA, $F7
    db $EF, $EE, "Nobody knows where", $EF, $EE, "it is now.", $F7
    db $F0

Message_08_06:: ; heuristic: string; C0
Data_07C_4424:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "The birds are", $F1
    db "noisy", $A4, $FA, $F7
    db $EF, $EE, "It's a sign that a", $EF, $EE, "quake will hit.", $F7
    db $F0

Message_08_07:: ; heuristic: string; C0
Data_07C_4464:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "See? What did I", $F1
    db "just say?", $F7
    db $F0

Message_08_08:: ; heuristic: string; C0
Data_07C_4483:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hope the", $F1
    db "volcanic island", $FA, $F7
    db $EF, $EE, "off the coast", $EF, $EE, "won't erupt", $A4, $F7
    db $F0

Message_08_09:: ; heuristic: string; C0
Data_07C_44C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I don't have", $F1
    db "much but", $A4, $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "see my wares?", $F7
    db $F0

Message_08_0A:: ; heuristic: string; C0
Data_07C_44FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "A folded fishnet", $EF, $EE, "was tucked inside.", $F7
    db $F0

Message_08_0B:: ; heuristic: string; C0
Data_07C_4542:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "colorful fruits.", $F7
    db $F0

Message_08_0C:: ; heuristic: string; C0
Data_07C_4586:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to", $F1
    db "Polona.", $FA, $F7
    db $EF, $EE, "It's a tourist", $EF, $EE, "resort known for", $FA, $F7
    db $EF, $EE, "the mermaids in", $EF, $EE, "the area.", $F7
    db $F0

Message_08_0D:: ; heuristic: string; C0
Data_07C_45DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You could meet", $F1
    db "mermaids here in", $FA, $F7
    db $EF, $EE, "the past, but not", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "Not since the", $EF, $EE, "pirates raided", $FA, $F7
    db $EF, $EE, "them and took", $EF, $EE, "their treasure.", $FA, $F7
    db $EF, $EE, "After that, the", $EF, $EE, "mermaids have kept", $FA, $F7
    db $EF, $EE, "away from people", $EF, $EE, "out of fear.", $FA, $F7
    db $EF, $EE, "It's a shame.", $EF, $EE, "They were decent", $FA, $F7
    db $EF, $EE, "sorts who liked to", $EF, $EE, "dance and sing.", $F7
    db $F0

Message_08_0E:: ; heuristic: string; C0
Data_07C_46F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm from the port", $F1
    db "in the northeast.", $FA, $F7
    db $EF, $EE, "I", $44, " almost reached", $EF, $EE, "here when ArmyAnts", $FA, $F7
    db $EF, $EE, "and MadGophers", $EF, $EE, "jumped me.", $FA, $F7
    db $EF, $EE, "I managed to get", $EF, $EE, "away though.", $FA, $F7
    db $EF, $EE, "I'm glad I made it", $EF, $EE, "here safely.", $FA, $F7
    db $EF, $EE, "It's quiet and", $EF, $EE, "restful.", $F7
    db $F0

Message_08_0F:: ; heuristic: string; C0
Data_07C_47C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You're not", $F1
    db "supposed to go", $FA, $F7
    db $EF, $EE, "near the cave in", $EF, $EE, "the west.", $FA, $F7
    db $EF, $EE, "It's on the cape.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Water monsters", $EF, $EE, "live there.", $FA, $F7
    db $EF, $EE, "Mama said it's", $EF, $EE, "dangerous.", $F7
    db $F0

Message_08_10:: ; heuristic: string; C0
Data_07C_4853:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In the past,", $F1
    db "mermaids are said", $FA, $F7
    db $EF, $EE, "to have sang and", $EF, $EE, "danced with people", $FA, $F7
    db $EF, $EE, "where we stand", $EF, $EE, "now.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "dance to remember", $FA, $F7
    db $EF, $EE, "and celebrate the", $EF, $EE, "days gone by?", $FF, $F0

Message_08_11:: ; heuristic: string; C0
Data_07C_4902:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Then I'll sing!", $F1
    db "Lalala", $9D, " lala la", $9D, $F7
    db $F0

Message_08_12:: ; heuristic: string; C0
Data_07C_4926:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "Please, take this", $EF, $EE, "as my thanks!", $F7
    db $F0

Message_08_13:: ; heuristic: string; C0
Data_07C_4998:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "a TinyMedal.", $F7
    db $F0

Message_08_14:: ; heuristic: string; C0
Data_07C_49B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "Please, take this", $EF, $EE, "as my thanks!", $FA, $F7
    db $EF, $EE, "Oh? You have no", $EF, $EE, "room", $A4, " Next time!", $F7
    db $F0

Message_08_15:: ; heuristic: string; C0
Data_07C_4A49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "I", $44, " love to see", $EF, $EE, "you dance again!", $F7
    db $F0

Message_08_16:: ; heuristic: string; C0
Data_07C_4ABB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Erm", $A4, " The sense", $F1
    db "of rhythm just", $FA, $F7
    db $EF, $EE, "doesn't quite come", $EF, $EE, "through.", $FA, $F7
    db $EF, $EE, "If there were a", $EF, $EE, "monster that could", $FA, $F7
    db $EF, $EE, "lead the dance", $EF, $EE, "performance", $A4, $FA, $F7
    db $EF, $EE, "Oh, pardon me!", $EF, $EE, "You are a novice", $A4, $F7
    db $F0

Message_08_17:: ; heuristic: string; C0
Data_07C_4B68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah", $A4, " Shame", $A4, $F1
    db "Please come again.", $F7
    db $F0

Message_08_18:: ; heuristic: string; C0
Data_07C_4B8A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you heard", $F1
    db "the legend about", $FA, $F7
    db $EF, $EE, "the mermaids", $95, $EF, $EE, "treasure?", $FF, $F0

Message_08_19:: ; heuristic: string; C0
Data_07C_4BCA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, you", $42, "e heard", $F1
    db "already.", $FA, $F7
    db $EF, $EE, "It's a tragic tale.", $EF, $EE, $F7
    db $F0

Message_08_1A:: ; heuristic: string; C0
Data_07C_4BFF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Long ago, a deft", $F1
    db "craftsman made a", $FA, $F7
    db $EF, $EE, "mirror with the", $EF, $EE, "power of darkness.", $FA, $F7
    db $EF, $EE, "It brought ruin to", $EF, $EE, "whatever its cold", $FA, $F7
    db $EF, $EE, "face reflected.", $EF, $EE, "Learning of this", $FA, $F7
    db $EF, $EE, "mirror, the people", $EF, $EE, "grew frightened.", $FA, $F7
    db $EF, $EE, "They took the", $EF, $EE, "mirror from the", $FA, $F7
    db $EF, $EE, "craftsman.", $EF, $EE, "It was hurled", $FA, $F7
    db $EF, $EE, "into the sea.", $EF, $EE, "The craftsman, out", $FA, $F7
    db $EF, $EE, "of sorrow, leapt", $EF, $EE, "after the mirror", $FA, $F7
    db $EF, $EE, "into the sea.", $EF, $EE, "The mirror drifted", $FA, $F7
    db $EF, $EE, "to the lair of", $EF, $EE, "mermaids where it", $FA, $F7
    db $EF, $EE, "was kept under", $EF, $EE, "secure seal as the", $FA, $F7
    db $EF, $EE, "HarMirror.", $EF, $EE, "And that's the", $FA, $F7
    db $EF, $EE, "tale.", $EF, $EE, $F7
    db $F0

Message_08_1B:: ; heuristic: string; C0
Data_07C_4DE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Ahh", $A4, " This is", $F1
    db "heavenly!", $FA, $F7
    db $EF, $EE, "It makes me feel", $EF, $EE, "alive again!", $FA, $F7
    db $EF, $EE, "Relaxing here, all", $EF, $EE, "my troubles seem", $FA, $F7
    db $EF, $EE, "to melt away to", $EF, $EE, "insignificance.", $F7
    db $F0

Message_08_1C:: ; heuristic: string; C0
Data_07C_4E6D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I came from far", $F1
    db "away to see some", $FA, $F7
    db $EF, $EE, "mermaids, but I", $EF, $EE, "hear they", $42, "e not", $FA, $F7
    db $EF, $EE, "been seen lately.", $EF, $EE, "That's a shame.", $F7
    db $F0

Message_08_1D:: ; heuristic: string; C0
Data_07C_4EDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This is Port", $F1
    db "Ritz, where ships", $FA, $F7
    db $EF, $EE, "gather from all", $EF, $EE, "over the world.", $F7
    db $F0

Message_08_1E:: ; heuristic: string; C0
Data_07C_4F22:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The pirates were", $F1
    db "swallowed by the", $FA, $F7
    db $EF, $EE, "sea after monsters", $EF, $EE, "overwhelmed them.", $FA, $F7
    db $EF, $EE, "But before they", $EF, $EE, "sank, they're said", $FA, $F7
    db $EF, $EE, "to have hidden", $EF, $EE, "their treasures.", $F7
    db $F0

Message_08_1F:: ; heuristic: string; C0
Data_07C_4FBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There's this old", $F1
    db "sailor man in the", $FA, $F7
    db $EF, $EE, "tavern who likes", $EF, $EE, "his grog too much.", $FA, $F7
    db $EF, $EE, "Whenever he's had", $EF, $EE, "a few, he'll regale", $FA, $F7
    db $EF, $EE, "you with tales of", $EF, $EE, "the high seas.", $FA, $F7
    db $EF, $EE, "But his stories", $EF, $EE, "tend to be a bit", $FA, $F7
    db $EF, $EE, "preposterous. I", $EF, $EE, "don't trust him.", $F7
    db $F0

Message_08_20:: ; heuristic: string; C0
Data_07C_509F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How may our", $F1
    db "church serve you?", $F7
    db $F0

Message_08_21:: ; heuristic: string; C0
Data_07C_50C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All sorts of", $F1
    db "people come here", $FA, $F7
    db $EF, $EE, "from around the", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "But a little kid", $EF, $EE, "with monsters", $A4, $FA, $F7
    db $EF, $EE, "That's something", $EF, $EE, "you don't get to", $FA, $F7
    db $EF, $EE, "see too often, not", $EF, $EE, "even here.", $F7
    db $F0

Message_08_22:: ; heuristic: string; C0
Data_07C_5168:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I went to Polona", $F1
    db "a while back", $A4, $FA, $F7
    db $EF, $EE, "You know, it's", $EF, $EE, "southwest of here.", $FA, $F7
    db $EF, $EE, "But I never got to", $EF, $EE, "see any mermaids.", $FA, $F7
    db $EF, $EE, "I was looking", $EF, $EE, "forward to it too", $A4, $F7
    db $F0

Message_08_23:: ; heuristic: string; C0
Data_07C_51FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I offer quality", $F1
    db "merchandise.", $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "see my wares?", $F7
    db $F0

Message_08_24:: ; heuristic: string; C0
Data_07C_5243:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There is a", $F1
    db "lighthouse to the", $FA, $F7
    db $EF, $EE, "east, but it's too", $EF, $EE, "dangerous.", $FA, $F7
    db $EF, $EE, "It's been overrun", $EF, $EE, "by monsters since", $FA, $F7
    db $EF, $EE, "the pirates stole", $EF, $EE, "the MoonRock from", $FA, $F7
    db $EF, $EE, "the top of the", $EF, $EE, "lighthouse.", $F7
    db $F0

Message_08_25:: ; heuristic: string; C0
Data_07C_52F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My ship sank in", $F1
    db "the eastern sea.", $FA, $F7
    db $EF, $EE, "We were sailing", $EF, $EE, "near a whirlpool", $FA, $F7
    db $EF, $EE, "when huge suction-", $EF, $EE, "cupped tentacles", $FA, $F7
    db $EF, $EE, "reached out and", $EF, $EE, "grabbed the ship.", $FA, $F7
    db $EF, $EE, "It's terrifying to", $EF, $EE, "even recall that!", $F7
    db $F0

Message_08_26:: ; heuristic: string; C0
Data_07C_53B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The old man in", $F1
    db "the tavern's neat!", $FA, $F7
    db $EF, $EE, "He tells me all", $EF, $EE, "sorts of things.", $FA, $F7
    db $EF, $EE, "I wish I would get", $EF, $EE, "kidnapped by some", $FA, $F7
    db $EF, $EE, "pirates one day.", $EF, $EE, "It", $44, " be neat!", $F7
    db $F0

Message_08_27:: ; heuristic: string; C0
Data_07C_5448:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This port used", $F1
    db "to be lively in", $FA, $F7
    db $EF, $EE, "the past, but it's", $EF, $EE, "become run down", $A4, $FA, $F7
    db $EF, $EE, "The pirates have", $EF, $EE, "all gone, but the", $FA, $F7
    db $EF, $EE, "port's still fading", $EF, $EE, "away", $A4, $F7
    db $F0

Message_08_28:: ; heuristic: string; C0
Data_07C_54D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The lighthouse", $F1
    db "had the MoonRock", $FA, $F7
    db $EF, $EE, "installed at its", $EF, $EE, "pinnacle.", $FA, $F7
    db $EF, $EE, "It would glow at", $EF, $EE, "night to light the", $FA, $F7
    db $EF, $EE, "way for mariners", $EF, $EE, "at sea.", $FA, $F7
    db $EF, $EE, "It was a gift from", $EF, $EE, "mermaids, you see.", $F7
    db $F0

Message_08_2A:: ; heuristic: string; C0
Data_07C_5588:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The sea's level", $F1
    db "has gone down.", $FA, $F7
    db $EF, $EE, "Many shoals have", $EF, $EE, "appeared.", $FA, $F7
    db $EF, $EE, "And that's resulted", $EF, $EE, "in countless ships", $FA, $F7
    db $EF, $EE, "running aground in", $EF, $EE, "these parts.", $F7
    db $F0

Message_08_2B:: ; heuristic: string; C0
Data_07C_5617:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Listen, did you", $F1
    db "know?", $FA, $F7
    db $EF, $EE, "Mermaids appear to", $EF, $EE, "love dancing.", $FA, $F7
    db $EF, $EE, "By the way, there's", $EF, $EE, "a cave west of", $FA, $F7
    db $EF, $EE, "Polona. A giant", $EF, $EE, "squid lives there.", $FA, $F7
    db $EF, $EE, "That squid is said", $EF, $EE, "to love to dance.", $FA, $F7
    db $EF, $EE, "I don't know if I", $EF, $EE, "want to see that", $A4, $F7
    db $F0

Message_08_2C:: ; heuristic: string; C0
Data_07C_56F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "check the chest.", $F7
    db $F0

Message_08_2D:: ; heuristic: string; C0
Data_07C_5711:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whoa! Hands off", $F1
    db "my merchandise!", $F7
    db $F0

Message_08_2E:: ; heuristic: string; C0
Data_07C_5735:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "gigantic beans.", $F7
    db $F0

Message_08_2F:: ; heuristic: string; C0
Data_07C_5778:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This area was a", $F1
    db "lot more lively in", $FA, $F7
    db $EF, $EE, "the old days, but", $EF, $EE, "now it's just a", $FA, $F7
    db $EF, $EE, "deathtrap for any", $EF, $EE, "kind of boat.", $FA, $F7
    db $EF, $EE, "We're ringed by", $EF, $EE, "shoals!", $FA, $F7
    db $EF, $EE, "Not many captains", $EF, $EE, "will risk their", $FA, $F7
    db $EF, $EE, "boat to bother", $EF, $EE, "dealing with us.", $F7
    db $F0

Message_08_30:: ; heuristic: string; C0
Data_07C_584D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When you're out", $F1
    db "at sea, you get to", $FA, $F7
    db $EF, $EE, "see some peculiar", $EF, $EE, "sights.", $FA, $F7
    db $EF, $EE, "But when I saw a", $EF, $EE, "ghost ship loom", $FA, $F7
    db $EF, $EE, "out of thick fog", $A4, $EF, $EE, "Hair-raising!", $F7
    db $F0

Message_08_31:: ; heuristic: string; C0
Data_07C_58DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, that old", $F1
    db "man, he was too", $FA, $F7
    db $EF, $EE, "grogged to make", $EF, $EE, "any sense", $A4, $FA, $F7
    db $EF, $EE, "Captain, sir,", $EF, $EE, "what'll we do?", $F7
    db $F0

Message_08_32:: ; heuristic: string; C0
Data_07C_593B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, made me", $F1
    db "waste my time", $A4, $FA, $F7
    db $EF, $EE, "We'll come back", $EF, $EE, "later for him.", $F7
    db $F0

Message_08_33:: ; heuristic: string; C0
Data_07C_597D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Hey! You're", $F1
    db $F9, "0, the farmer!", $FA, $F7
    db $EF, $EE, "Don't tell me", $EF, $EE, "you're looking", $FA, $F7
    db $EF, $EE, "for something to", $EF, $EE, "plug the Navel?", $FA, $F7
    db $EF, $EE, "So, Warubou asked", $EF, $EE, "you too, huh?", $FA, $F7
    db $EF, $EE, "But those monsters", $EF, $EE, "you're with", $A4, $FA, $F7
    db $EF, $EE, "Don't they look", $EF, $EE, "frail and wimpy?", $FA, $F7
    db $EF, $EE, "Look, I", $42, "e already", $EF, $EE, "got two sidekicks!", $FA, $F7
    db $EF, $EE, "I'll find the plug", $EF, $EE, "before you!", $FA, $F7
    db $EF, $EE, "Come on, team,", $EF, $EE, "let's go!", $F7
    db $F0

Message_08_34:: ; heuristic: string; C0
Data_07C_5AB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When that old", $F1
    db "man gets grogged", $A4, $FA, $F7
    db $EF, $EE, "You can't move him", $EF, $EE, "with a crowbar.", $FA, $F7
    db $EF, $EE, "It's like he casts", $EF, $EE, "Ironize on", $FA, $F7
    db $EF, $EE, "himself.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "What can we do", $F1
    db "about it?", $F7
    db $F0

Message_08_35:: ; heuristic: string; C0
Data_07C_5B4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The old fellow", $F1
    db "there, the instant", $FA, $F7
    db $EF, $EE, "he smells a sea", $EF, $EE, "monster, he wakes", $FA, $F7
    db $EF, $EE, "up, even if he's", $EF, $EE, "tanked on grog.", $FA, $F7
    db $EF, $EE, "That's a real sea", $EF, $EE, "dog, I", $44, " say!", $F7
    db $F0

Message_08_36:: ; heuristic: string; C0
Data_07C_5BE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The volcanic", $F1
    db "island off the", $FA, $F7
    db $EF, $EE, "coast is vicious", $EF, $EE, "to ships.", $FA, $F7
    db $EF, $EE, "Its ring of shoals", $EF, $EE, "keeps boats away.", $F7
    db $F0

Message_08_37:: ; heuristic: string; C0
Data_07C_5C48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hnnnr", $A4, " Hic", $A4, " Gnn", $A4, $F1
    db "Zzz", $A4, " Gfffff", $A4, $F7
    db $F0

Message_08_38:: ; heuristic: string; C0
Data_07C_5C6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who are you?", $F1
    db "This is our surf!", $FA, $F7
    db $EF, $EE, $A4, "I mean turf!", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "You show me some", $EF, $EE, "respect on our su", $A4, $FA, $F7
    db $EF, $EE, "Turf! That's it,", $EF, $EE, "I'm mad!", $F7
    db $F0

Message_08_39:: ; heuristic: string; C0
Data_07C_5CE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can keep", $F1
    db "trying, but you're", $FA, $F7
    db $EF, $EE, "never going to", $EF, $EE, "win, punk!", $F7
    db $F0

Message_08_3A:: ; heuristic: string; C0
Data_07C_5D26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzz", $A4, " Zzz", $A4, $F1
    db "Huh! Watch out!", $F7
    db $F0

Message_08_3B:: ; heuristic: string; C0
Data_07C_5D44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What! Why are", $F1
    db "you with monsters?", $FA, $F7
    db $EF, $EE, "You're an odd", $EF, $EE, "little child.", $FA, $F7
    db $EF, $EE, "Did you want to", $EF, $EE, "hear my tales?", $FF, $F0

Message_08_3C:: ; heuristic: string; C0
Data_07C_5DAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It was in my", $F1
    db "callow youth", $A4, $FA, $F7
    db $EF, $EE, "The ship I was on", $EF, $EE, "was captured by", $FA, $F7
    db $EF, $EE, "pirates who kept", $EF, $EE, "us as slaves.", $FA, $F7
    db $EF, $EE, "We toiled for", $EF, $EE, "months that way.", $FA, $F7
    db $EF, $EE, "But one day, I", $EF, $EE, "overheard them", $FA, $F7
    db $EF, $EE, "talking about the", $EF, $EE, "MoonRock.", $FA, $F7
    db $EF, $EE, "If it were taken", $EF, $EE, "from the top of", $FA, $F7
    db $EF, $EE, "the lighthouse,", $EF, $EE, "the sea would ebb.", $FA, $F7
    db $EF, $EE, "And that would", $EF, $EE, "make it impossible", $FA, $F7
    db $EF, $EE, "to approach the", $EF, $EE, "volcanic island", $FA, $F7
    db $EF, $EE, "where they hid", $EF, $EE, "their loot.", $FA, $F7
    db $EF, $EE, "Unfortunately,", $EF, $EE, "they saw me.", $FA, $F7
    db $EF, $EE, "They would never", $EF, $EE, "allow someone to", $FA, $F7
    db $EF, $EE, "live knowing their", $EF, $EE, "secret.", $FA, $F7
    db $EF, $EE, "So I ran and leapt", $EF, $EE, "into the sea.", $FA, $F7
    db $EF, $EE, "I was rescued by a", $EF, $EE, "passing ship.", $F7
    db $F0

Message_08_3D:: ; heuristic: string; C0
Data_07C_5FDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The pirates", $95, $F1
    db "loot is probably", $FA, $F7
    db $EF, $EE, "still on the", $EF, $EE, "volcanic island.", $FA, $F7
    db $EF, $EE, "But, there is no", $EF, $EE, "way of getting", $FA, $F7
    db $EF, $EE, "close to the", $EF, $EE, "island.", $FA, $F7
    db $EF, $EE, "It should be", $EF, $EE, "possible to go to", $FA, $F7
    db $EF, $EE, "the island if the", $EF, $EE, "MoonRock were to", $FA, $F7
    db $EF, $EE, "be returned to the", $EF, $EE, "lighthouse.", $FA, $F7
    db $EF, $EE, "But the MoonRock", $EF, $EE, "sank with the", $FA, $F7
    db $EF, $EE, "pirates and their", $EF, $EE, "ship.", $FA, $F7
    db $EF, $EE, "Maybe if mermaids", $EF, $EE, "could help", $A4, $FA, $F7
    db $EF, $EE, "Can mermaids still", $EF, $EE, "be seen in Polona?", $F7
    db $F0

Message_08_3E:: ; heuristic: string; C0
Data_07C_6155:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's a tale of", $F1
    db "high adventure", $A4, $F7
    db $F0

Message_08_3F:: ; heuristic: string; C0
Data_07C_6177:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Are you", $F1
    db "here for my tales?", $FF, $F0

Message_08_40:: ; heuristic: string; C0
Data_07C_619C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The pirates", $F1
    db "stole the MoonRock", $FA, $F7
    db $EF, $EE, "from its mount in", $EF, $EE, "the lighthouse.", $FA, $F7
    db $EF, $EE, "That made it", $EF, $EE, "impossible for", $FA, $F7
    db $EF, $EE, "ships to go near", $EF, $EE, "the volcanic isle", $FA, $F7
    db $EF, $EE, "where they hid", $EF, $EE, "their loot.", $FA, $F7
    db $EF, $EE, "If the MoonRock", $EF, $EE, "was returned to", $FA, $F7
    db $EF, $EE, "lighthouse, the", $EF, $EE, "island will become", $FA, $F7
    db $EF, $EE, "accessible by sea", $EF, $EE, "again.", $FA, $F7
    db $EF, $EE, "Maybe if mermaids", $EF, $EE, "could help", $A4, $FA, $F7
    db $EF, $EE, "Can mermaids still", $EF, $EE, "be seen in Polona?", $F7
    db $F0

Message_08_41:: ; heuristic: string; C0
Data_07C_62FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's a chance to", $F1
    db "hear an intriguing", $FA, $F7
    db $EF, $EE, "tale of mystery", $A4, $EF, $EE, "Shame", $A4, $F7
    db $F0

Message_08_42:: ; heuristic: string; C0
Data_07C_6342:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm tired of the", $F1
    db "geezer's tales.", $F7
    db $F0

Message_08_43:: ; heuristic: string; C0
Data_07C_6365:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I saw a child", $F1
    db "cross the sea on a", $FA, $F7
    db $EF, $EE, "giant clam. No, no", $EF, $EE, "lie! I saw it!", $F7
    db $F0

Message_08_44:: ; heuristic: string; C0
Data_07C_63B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Watch me dance,", $F1
    db "and you'll want to", $FA, $F7
    db $EF, $EE, "dance too. I can", $EF, $EE, "see that you do!", $FA, $F7
    db $EF, $EE, "I'm mimicking an", $EF, $EE, "Octokid's moves.", $F7
    db $F0

Message_08_45:: ; heuristic: string; C0
Data_07C_6420:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What", $A4, " What are", $F1
    db "you doing? Stop!", $F7
    db $F0

Message_08_46:: ; heuristic: string; C0
Data_07C_6444:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Gahahah!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "Looks like we made", $EF, $EE, "it here first!", $FA, $F7
    db $EF, $EE, "All we have to do", $EF, $EE, "now is get the", $FA, $F7
    db $EF, $EE, "MoonRock from the", $EF, $EE, "mermaids, and the", $FA, $F7
    db $EF, $EE, "pirate's loot will", $EF, $EE, "be all mine!", $FA, $F7
    db $EF, $EE, "Sit back and watch", $EF, $EE, "our soaring dance!", $F7
    db $F0

Message_08_47:: ; heuristic: string; C0
Data_07C_6519:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "So where", $F1
    db "are the mermaids?", $FA, $F7
    db $EF, $EE, "That geezer was", $EF, $EE, "pulling our legs!", $F7
    db $F0

Message_08_48:: ; heuristic: string; C0
Data_07C_6565:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, my", $A4, " Who were", $F1
    db "those barbarians?", $FA, $F7
    db $EF, $EE, "How perfectly", $EF, $EE, "shocking and rude!", $F7
    db $F0

Message_08_49:: ; heuristic: string; C0
Data_07C_65B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "Oh? You say you", $EF, $EE, "want the MoonRock?", $FA, $F7
    db $EF, $EE, "Well", $A4, " All right.", $EF, $EE, "Your monsters say", $FA, $F7
    db $EF, $EE, "that you're a good", $EF, $EE, "human.", $FA, $F7
    db $EF, $EE, "I'll take you to", $EF, $EE, "our Queen.", $FA, $F7
    db $EF, $EE, "Close your eyes a", $EF, $EE, "little while.", $F7
    db $F0

Message_08_4A:: ; heuristic: string; C0
Data_07C_66AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm astonished.", $F1
    db "Mermaids exist.", $F7
    db $F0

Message_08_4B:: ; heuristic: string; C0
Data_07C_66D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do you want to", $F1
    db "go to the kingdom", $FA, $F7
    db $EF, $EE, "of mermaids?", $EF, $EE, $FF, $F0

Message_08_4C:: ; heuristic: string; C0
Data_07C_6707:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Close your eyes", $F1
    db "a little while.", $F7
    db $F0

Message_08_4D:: ; heuristic: string; C0
Data_07C_672B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Come back for a", $F1
    db "visit anytime!", $FA, $F7
    db $EF, $EE, "You'll always be", $EF, $EE, "welcome here!", $F7
    db $F0

Message_08_4E:: ; heuristic: string; C0
Data_07C_6770:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This is the", $F1
    db "mermaid kingdom.", $FA, $F7
    db $EF, $EE, "It is built on the", $EF, $EE, "ocean floor.", $FA, $F7
    db $EF, $EE, "It's very rare to", $EF, $EE, "see a human here.", $FA, $F7
    db $EF, $EE, "Tell me if you", $EF, $EE, "want to go home.", $F7
    db $F0

Message_08_4F:: ; heuristic: string; C0
Data_07C_6800:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I know not all", $F1
    db "humans are bad", $A4, $FA, $F7
    db $EF, $EE, "But the pirates", $EF, $EE, "who stole our", $FA, $F7
    db $EF, $EE, "treasure were", $EF, $EE, "humans too.", $FA, $F7
    db $EF, $EE, "I hope HarMirror", $EF, $EE, "is not being used", $FA, $F7
    db $EF, $EE, "for their wicked", $EF, $EE, "misdeeds", $A4, $F7
    db $F0

Message_08_50:: ; heuristic: string; C0
Data_07C_68A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The pirates", $F1
    db "caught us in nets", $FA, $F7
    db $EF, $EE, "and blackmailed", $EF, $EE, "our Queen into", $FA, $F7
    db $EF, $EE, "handing over our", $EF, $EE, "treasures", $A4, $F7
    db $F0

Message_08_51:: ; heuristic: string; C0
Data_07C_690E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The HarMirror", $F1
    db "was exquisite.", $FA, $F7
    db $EF, $EE, "It was so flawless", $EF, $EE, "that it made real", $FA, $F7
    db $EF, $EE, "its reflection", $EF, $EE, "while the original", $FA, $F7
    db $EF, $EE, "ceased to exist in", $EF, $EE, "this world.", $F7
    db $F0

Message_08_52:: ; heuristic: string; C0
Data_07C_69A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The MoonRock", $F1
    db "fell from the sky.", $FA, $F7
    db $EF, $EE, "It glows like the", $EF, $EE, "Moon at night.", $F7
    db $F0

Message_08_53:: ; heuristic: string; C0
Data_07C_69EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The pirates sank", $F1
    db "with their ship.", $FA, $F7
    db $EF, $EE, "However, their", $EF, $EE, "greed for treasure", $FA, $F7
    db $EF, $EE, "would not allow", $EF, $EE, "them to rest easy.", $FA, $F7
    db $EF, $EE, "They now drift the", $EF, $EE, "sea as the ghostly", $FA, $F7
    db $EF, $EE, "crew of a spectral", $EF, $EE, "ship.", $F7
    db $F0

Message_08_54:: ; heuristic: string; C0
Data_07C_6AA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We mermaids are", $F1
    db "peaceful beings.", $FA, $F7
    db $EF, $EE, "We shy away from", $EF, $EE, "violence.", $FA, $F7
    db $EF, $EE, "The thought of a", $EF, $EE, "haunted ship", $FA, $F7
    db $EF, $EE, "roaming the sea", $EF, $EE, "makes us uneasy.", $FA, $F7
    db $EF, $EE, "It will make our", $EF, $EE, "scales go coarse.", $F7
    db $F0

Message_08_55:: ; heuristic: string; C0
Data_07C_6B56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome, young", $F1
    db "human.", $FA, $F7
    db $EF, $EE, "I heard that you", $EF, $EE, "seek the MoonRock", $FA, $F7
    db $EF, $EE, "to land on the", $EF, $EE, "volcanic island.", $FA, $F7
    db $EF, $EE, "The MoonRock is no", $EF, $EE, "longer here.", $FA, $F7
    db $EF, $EE, "But I can tell you", $EF, $EE, "where it is.", $FA, $F7
    db $EF, $EE, "It remains on the", $EF, $EE, "ghost ship.", $FA, $F7
    db $EF, $EE, "It is a spectral", $EF, $EE, "ship manned by the", $FA, $F7
    db $EF, $EE, "spirits of pirates", $EF, $EE, "who died at sea.", $FA, $F7
    db $EF, $EE, "Driven by greed", $EF, $EE, "for treasures, the", $FA, $F7
    db $EF, $EE, "ship still wanders", $EF, $EE, "upon the waves.", $FA, $F7
    db $EF, $EE, "Look north from", $EF, $EE, "Yold for her.", $F7
    db $F0

Message_08_56:: ; heuristic: string; C0
Data_07C_6CE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Ah, your will", $F1
    db "appears strong.", $FA, $F7
    db $EF, $EE, "You deserve to", $EF, $EE, "hear the truth.", $FA, $F7
    db $EF, $EE, "The MoonRock is on", $EF, $EE, "the ghost ship.", $FA, $F7
    db $EF, $EE, "It is a spectral", $EF, $EE, "ship manned by the", $FA, $F7
    db $EF, $EE, "spirits of pirates", $EF, $EE, "who died at sea.", $FA, $F7
    db $EF, $EE, "Driven by greed", $EF, $EE, "for treasures, the", $FA, $F7
    db $EF, $EE, "ship still wanders", $EF, $EE, "upon the waves.", $FA, $F7
    db $EF, $EE, "Look north from", $EF, $EE, "Yold for her.", $F7
    db $F0

Message_08_57:: ; heuristic: string; C0
Data_07C_6E11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I see", $A4, " It can't", $F1
    db "be helped, then.", $FA, $F7
    db $EF, $EE, "However, if your", $EF, $EE, "destination is the", $FA, $F7
    db $EF, $EE, "volcanic island,", $EF, $EE, "you cannot help", $FA, $F7
    db $EF, $EE, "but come across", $EF, $EE, "the ghost ship.", $F7
    db $F0

Message_08_58:: ; heuristic: string; C0
Data_07C_6EA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The MoonRock is", $F1
    db "on the ghost ship.", $FA, $F7
    db $EF, $EE, "It is a spectral", $EF, $EE, "ship manned by the", $FA, $F7
    db $EF, $EE, "spirits of pirates", $EF, $EE, "who died at sea.", $FA, $F7
    db $EF, $EE, "Driven by greed", $EF, $EE, "for treasures, the", $FA, $F7
    db $EF, $EE, "ship still wanders", $EF, $EE, "upon the waves.", $FA, $F7
    db $EF, $EE, "Look north from", $EF, $EE, "Yold for her.", $F7
    db $F0

Message_08_59:: ; heuristic: string; C0
Data_07C_6F8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How could we die", $F1
    db "before enjoying", $FA, $F7
    db $EF, $EE, "all the loot we", $EF, $EE, "amassed", $A4, $F7
    db $F0

Message_08_5A:: ; heuristic: string; C0
Data_07C_6FCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The treasures", $F1
    db "are ours", $A4, $FA, $F7
    db $EF, $EE, "No one will take", $EF, $EE, "them from us", $A4, $F7
    db $F0

Message_08_5B:: ; heuristic: string; C0
Data_07C_700E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is what", $F1
    db "became of us", $A4, $FA, $F7
    db $EF, $EE, "The pirates who", $EF, $EE, "savaged the seas", $A4, $F7
    db $F0

Message_08_5C:: ; heuristic: string; C0
Data_07C_7053:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It nags and nags", $F1
    db "that we left our", $FA, $F7
    db $EF, $EE, "treasures behind", $A4, $EF, $EE, $F7
    db $F0

Message_08_5D:: ; heuristic: string; C0
Data_07C_7090:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Check the wooden", $F1
    db "crate", $A4, $F7
    db $F0

Message_08_5E:: ; heuristic: string; C0
Data_07C_70AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who disturbs us", $F1
    db "in our sleep", $A4, $FA, $F7
    db $EF, $EE, "Oh? There are", $EF, $EE, "still fools", $FA, $F7
    db $EF, $EE, "chasing our", $EF, $EE, "treasures after", $FA, $F7
    db $EF, $EE, "all this time?", $EF, $EE, $F7
    db $F0

Message_08_5F:: ; heuristic: string; C0
Data_07C_7120:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "You seem to not", $F1
    db "understand", $A4, $FA, $F7
    db $EF, $EE, "The treasures", $EF, $EE, "belong to us.", $FA, $F7
    db $EF, $EE, "You shall see how", $EF, $EE, "powerless you are", $A4, $F7
    db $F0

Message_08_60:: ; heuristic: string; C0
Data_07C_718A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Child", $A4, $F1
    db "We have lost", $A4, $FA, $F7
    db $EF, $EE, "Finally, we can", $EF, $EE, "sleep", $A4, $F7
    db $F0

Message_08_61:: ; heuristic: string; C0
Data_07C_71BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "A mummified fish", $EF, $EE, "lay inside.", $F7
    db $F0

Message_08_62:: ; heuristic: string; C0
Data_07C_71FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There were dry,", $EF, $EE, "shriveled fruits.", $F7
    db $F0

Message_08_63:: ; heuristic: string; C0
Data_07C_723D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "crate.", $FA, $F7
    db $EF, $EE, "There was a hidden", $EF, $EE, "staircase.", $F7
    db $F0

Message_08_64:: ; heuristic: string; C0
Data_07C_7276:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "ledger.", $FA, $F7
    db $EF, $EE, $95, "Voyage Log", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Sunrise obscured", $EF, $EE, "by deep fog", $A4, $FA, $F7
    db $EF, $EE, "Lookout reports", $A4, $EF, $EE, "there is some", $A4, $95, $F7
    db $F0

Message_08_65:: ; heuristic: string; C0
Data_07C_72E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pedestal.", $FA, $F7
    db $EF, $EE, "It has a hole to", $EF, $EE, "accept an item.", $F7
    db $F0

Message_08_66:: ; heuristic: string; C0
Data_07C_7327:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The MoonRock fit", $F1
    db "snugly into place.", $F7
    db $F0

Message_08_67:: ; heuristic: string; C0
Data_07C_734C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pedestal.", $FA, $F7
    db $EF, $EE, "The MoonRock sat", $EF, $EE, "on the pedestal.", $F7
    db $F0

Message_08_68:: ; heuristic: string; C0
Data_07C_738C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wahahahah!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "Thanks for guiding", $EF, $EE, "me here!", $FA, $F7
    db $EF, $EE, "I figured that you", $EF, $EE, "would figure out", $FA, $F7
    db $EF, $EE, "where the loot was", $EF, $EE, "so I tailed you!", $FA, $F7
    db $EF, $EE, "I'll take the", $EF, $EE, "treasures home!", $F7
    db $F0

Message_08_69:: ; heuristic: string; C0
Data_07C_7434:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Urk! How", $44, $F1
    db "you catch up?", $FA, $F7
    db $EF, $EE, "You're faster than", $EF, $EE, "you look", $A4, $FA, $F7
    db $EF, $EE, "Come on, mateys!", $EF, $EE, "Follow me!", $F7
    db $F0

Message_08_6A:: ; heuristic: string; C0
Data_07C_7496:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Aye, aye, sir!", $F1
    db "Right behind you!", $F7
    db $F0

Message_08_6B:: ; heuristic: string; C0
Data_07C_74BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Arrrrh,", $F1
    db "clear the way!", $FA, $F7
    db $EF, $EE, "I'm grabbing the", $EF, $EE, "treasure first!", $F7
    db $F0

Message_08_6C:: ; heuristic: string; C0
Data_07C_7501:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "Gasp", $A4, $F1
    db $A4, "Hack", $A4, " I did it", $A4, $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "mine! All mine!", $F7
    db $F0

Message_08_6D:: ; heuristic: string; C0
Data_07C_7549:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?!", $F1
    db "What is this?", $F7
    db $F0

Message_08_6E:: ; heuristic: string; C0
Data_07C_7568:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Kahahaha", $A4, $F1
    db $F7
    db $F0

Message_08_6F:: ; heuristic: string; C0
Data_07C_7577:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is what it", $F1
    db "means, nincompoop!", $FA, $F7
    db $EF, $EE, "You put us through", $EF, $EE, "all this trouble", $A4, $FA, $F7
    db $EF, $EE, "Saying how we", $EF, $EE, "needed your help", $FA, $F7
    db $EF, $EE, "to find the", $EF, $EE, "treasure", $A4, $FA, $F7
    db $EF, $EE, "That you wouldn't", $EF, $EE, "cooperate unless", $FA, $F7
    db $EF, $EE, "we became your", $EF, $EE, "sidekicks, pah!", $FA, $F7
    db $EF, $EE, "For all that talk,", $EF, $EE, "you were useless!", $FA, $F7
    db $EF, $EE, "We'll take the loot", $EF, $EE, "for our King!", $FA, $F7
    db $EF, $EE, "You're not worthy", $EF, $EE, "of it anyway!", $F7
    db $F0

Message_08_70:: ; heuristic: string; C0
Data_07C_76BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Urrrggh", $A4, $F1
    db "You tricked me!", $FA, $F7
    db $EF, $EE, "You're not getting", $EF, $EE, "away with this!", $F7
    db $F0

Message_08_71:: ; heuristic: string; C0
Data_07C_7707:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I was", $F1
    db "stupid to trust", $FA, $F7
    db $EF, $EE, "and believe in", $EF, $EE, "those monsters", $A4, $FA, $F7
    db $EF, $EE, "You take the loot", $EF, $EE, "back", $A4, " Later!", $F7
    db $F0

Message_08_72:: ; heuristic: string; C0
Data_07C_776D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Message_08_73:: ; heuristic: string; C0
Data_07C_778B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Wa-hey!", $F1
    db $F9, "0, hear me?", $FA, $F7
    db $EF, $EE, "I felt an odd", $EF, $EE, "power stirring.", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back! Don't move!", $F7
    db $F0

Message_08_74:: ; heuristic: string; C0
Data_07C_780E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I haven't seen", $F1
    db "the ghost ship in", $FA, $F7
    db $EF, $EE, "some time now, but", $EF, $EE, "I'm still afraid", $FA, $F7
    db $EF, $EE, "to get out of bed", $EF, $EE, "at night", $A4, $F7
    db $F0

Message_08_75:: ; heuristic: string; C0
Data_07C_7879:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The volcanic", $F1
    db "island appears to", $FA, $F7
    db $EF, $EE, "have calmed down", $EF, $EE, "again.", $FA, $F7
    db $EF, $EE, "Perhaps it took a", $EF, $EE, "sacrifice", $A4, $F7
    db $F0

Message_08_76:: ; heuristic: string; C0
Data_07C_78D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Sigh", $A4, " Will the", $F1
    db "HarMirror make me", $FA, $F7
    db $EF, $EE, "appear beautiful", $EF, $EE, "on the other side", $A4, $F7
    db $F0

Message_08_77:: ; heuristic: string; C0
Data_07C_7926:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My grandson just", $F1
    db "shivers now", $A4, $FA, $F7
    db $EF, $EE, "He's been wetting", $EF, $EE, "the bed too", $A4, $F7
    db $F0

Message_08_78:: ; heuristic: string; C0
Data_07C_796A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The mermaids", $F1
    db "came back.", $F7
    db $F0

Message_08_79:: ; heuristic: string; C0
Data_07C_7986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e seen", $F1
    db "mermaids too.", $FA, $F7
    db $EF, $EE, "I think I'm in", $EF, $EE, "love!", $F7
    db $F0

Message_08_7A:: ; heuristic: string; C0
Data_07C_79B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The pirates hid", $F1
    db "their loot on the", $FA, $F7
    db $EF, $EE, "volcanic island,", $EF, $EE, "I heard!", $FA, $F7
    db $EF, $EE, "All these years", $EF, $EE, "searching, and it", $FA, $F7
    db $EF, $EE, "was always right", $EF, $EE, "before my eyes!", $F7
    db $F0

Message_08_7B:: ; heuristic: string; C0
Data_07C_7A48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The sea around", $F1
    db "here is safe now.", $FA, $F7
    db $EF, $EE, "The town should be", $EF, $EE, "revitalized.", $F7
    db $F0

Message_08_7C:: ; heuristic: string; C0
Data_07C_7A91:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The MoonRock", $F1
    db "glows at night", $FA, $F7
    db $EF, $EE, "from atop the", $EF, $EE, "lighthouse again.", $FA, $F7
    db $EF, $EE, "Someone restored", $EF, $EE, "it to its place.", $F7
    db $F0

Message_08_7D:: ; heuristic: string; C0
Data_07C_7AFB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The sea's level", $F1
    db "has risen.", $FA, $F7
    db $EF, $EE, "No ships have", $EF, $EE, "foundered lately.", $F7
    db $F0

Message_08_7E:: ; heuristic: string; C0
Data_07C_7B3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " For some reason,", $F1
    db "the shoals sank", $FA, $F7
    db $EF, $EE, "almost instantly.", $EF, $EE, "It's a good thing.", $FA, $F7
    db $EF, $EE, "Ships should come", $EF, $EE, "back to restore", $FA, $F7
    db $EF, $EE, "the town to its", $EF, $EE, "former glory.", $F7
    db $F0

Message_08_7F:: ; heuristic: string; C0
Data_07C_7BD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did you hear?", $F1
    db "Pirates hid their", $FA, $F7
    db $EF, $EE, "treasure on the", $EF, $EE, "volcanic island.", $FA, $F7
    db $EF, $EE, "I should have", $EF, $EE, "listened to the", $FA, $F7
    db $EF, $EE, "geezer and gone to", $EF, $EE, "see for myself", $A4, $F7
    db $F0

Message_08_80:: ; heuristic: string; C0
Data_07C_7C64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What?", $F1
    db "You again?", $FA, $F7
    db $EF, $EE, "Back to hear more", $EF, $EE, "of my tales?", $FA, $F7
    db $EF, $EE, "Hah? No, no!", $EF, $EE, "The treasure on", $FA, $F7
    db $EF, $EE, "the sunken ship is", $EF, $EE, "a secret!", $F7
    db $F0

Message_08_81:: ; heuristic: string; C0
Data_07C_7CDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Our words of", $F1
    db "thanks could never", $FA, $F7
    db $EF, $EE, "do justice to the", $EF, $EE, "way we feel.", $F7
    db $F0

Message_08_82:: ; heuristic: string; C0
Data_07C_7D25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Mermaids and", $F1
    db "humans can live", $FA, $F7
    db $EF, $EE, "side by side in", $EF, $EE, "harmony again!", $F7
    db $F0

Message_08_83:: ; heuristic: string; C0
Data_07C_7D69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Thanks to you,", $F1
    db "the spectral ship", $FA, $F7
    db $EF, $EE, "sank again, this", $EF, $EE, "time for good.", $FA, $F7
    db $EF, $EE, "The cravings of", $EF, $EE, "the ghostly crew", $FA, $F7
    db $EF, $EE, "for treasures must", $EF, $EE, "have been quelled.", $F7
    db $F0

Message_08_84:: ; heuristic: string; C0
Data_07C_7E01:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That wandering", $F1
    db "ghost ship's gone!", $FA, $F7
    db $EF, $EE, "My scales will", $EF, $EE, "be glossy once", $FA, $F7
    db $EF, $EE, "again!", $EF, $EE, $F7
    db $F0

Message_08_85:: ; heuristic: string; C0
Data_07C_7E54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome, young", $F1
    db "hero!", $FA, $F7
    db $EF, $EE, "No words could", $EF, $EE, "ever adequately", $FA, $F7
    db $EF, $EE, "express our", $EF, $EE, "gratitude!", $F7
    db $F0

Message_08_86:: ; heuristic: string; C0
Data_07C_7EAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N's", $F1
    db "dancing lured", $FA, $F7
    db $EF, $EE, "a mermaid to the", $EF, $EE, "surface.", $F7
    db $F0
    ds $124, $00
