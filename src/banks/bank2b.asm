SECTION "Bank 2B", ROMX[$4000], BANK[$2B]
    db $2B

; message bank $2B: when wStringIndex < $8A, BeginStringDisplay with this bank's table Data_02B_4032; otherwise far-calls Func_098_4001 (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_Case05, Func_010_4AD0_Case03, ShowMessageHL_Case03)
; reads: wStringIndex
BeginStringDisplay_Bank2B::
Func_02B_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $8A
    jr c, Jump_02B_400F
    farcall BeginStringDisplay_Bank2B_Overflow
    ret

Jump_02B_400F::
    ld de, MessageStrings_Bank2B
    call BeginStringDisplay
    ret

; message bank $2B: when wStringIndex < $8A, CopyStringToBuffer with this bank's table Data_02B_4032; otherwise far-calls Func_098_4010 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank2B:: ; heuristic: follows a terminator; C0
Func_02B_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $8A
    jr c, Jump_02B_4024
    farcall CopyStringToBuffer_Bank2B_Overflow
    ret

Jump_02B_4024::
    ld de, MessageStrings_Bank2B
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_2B_4032::
MessageStrings_Bank2B:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_02B_4032:: ; address name
    dw StringList_2B_4034 ; id 0

; E-0217 (derived: category list of StringCategories_2B_4032; one pointer per wStringIndex)
; record: string
StringList_2B_4034::
Data_02B_4034:: ; address name
    dw Data_02B_4148 ; id 0
    dw Data_02B_417B ; id 1
    dw Data_02B_41DE ; id 2
    dw Data_02B_42D5 ; id 3
    dw Data_02B_433E ; id 4
    dw Data_02B_4406 ; id 5
    dw Data_02B_44AA ; id 6
    dw Data_02B_4514 ; id 7
    dw Data_02B_45F2 ; id 8
    dw Data_02B_462A ; id 9
    dw Data_02B_4798 ; id 10
    dw Data_02B_4905 ; id 11
    dw Data_02B_49DE ; id 12
    dw Data_02B_4A44 ; id 13
    dw Data_02B_4A7C ; id 14
    dw Data_02B_4B5D ; id 15
    dw Data_02B_4BC8 ; id 16
    dw Data_02B_4BF0 ; id 17
    dw Data_02B_4C33 ; id 18
    dw Data_02B_4C73 ; id 19
    dw Data_02B_4CAD ; id 20
    dw Data_02B_4CF1 ; id 21
    dw Data_02B_4D80 ; id 22
    dw Data_02B_4DB6 ; id 23
    dw Data_02B_4FA3 ; id 24
    dw Data_02B_509C ; id 25
    dw Data_02B_50D7 ; id 26
    dw Data_02B_5189 ; id 27
    dw Data_02B_5210 ; id 28
    dw Data_02B_526D ; id 29
    dw Data_02B_528F ; id 30
    dw Data_02B_52F1 ; id 31
    dw Data_02B_535E ; id 32
    dw Data_02B_53CA ; id 33
    dw Data_02B_543F ; id 34
    dw Data_02B_557B ; id 35
    dw Data_02B_55E1 ; id 36
    dw Data_02B_564E ; id 37
    dw Data_02B_566D ; id 38
    dw Data_02B_56D8 ; id 39
    dw Data_02B_571E ; id 40
    dw Data_02B_57EC ; id 41
    dw Data_02B_587B ; id 42
    dw Data_02B_58C0 ; id 43
    dw Data_02B_592B ; id 44
    dw Data_02B_598D ; id 45
    dw Data_02B_59FA ; id 46
    dw Data_02B_5A68 ; id 47
    dw Data_02B_5ADA ; id 48
    dw Data_02B_5B49 ; id 49
    dw Data_02B_5B6D ; id 50
    dw Data_02B_5B93 ; id 51
    dw Data_02B_5BB7 ; id 52
    dw Data_02B_5C87 ; id 53
    dw Data_02B_5D1C ; id 54
    dw Data_02B_5D68 ; id 55
    dw Data_02B_5E17 ; id 56
    dw Data_02B_5E80 ; id 57
    dw Data_02B_5F07 ; id 58
    dw Data_02B_5F71 ; id 59
    dw Data_02B_6065 ; id 60
    dw Data_02B_613B ; id 61
    dw Data_02B_61A8 ; id 62
    dw Data_02B_623A ; id 63
    dw Data_02B_62A8 ; id 64
    dw Data_02B_62F1 ; id 65
    dw Data_02B_6359 ; id 66
    dw Data_02B_639B ; id 67
    dw Data_02B_63DF ; id 68
    dw Data_02B_6440 ; id 69
    dw Data_02B_6463 ; id 70
    dw Data_02B_6507 ; id 71
    dw Data_02B_652C ; id 72
    dw Data_02B_654C ; id 73
    dw Data_02B_656F ; id 74
    dw Data_02B_6596 ; id 75
    dw Data_02B_6612 ; id 76
    dw Data_02B_6637 ; id 77
    dw Data_02B_6678 ; id 78
    dw Data_02B_66E1 ; id 79
    dw Data_02B_674C ; id 80
    dw Data_02B_67DF ; id 81
    dw Data_02B_688D ; id 82
    dw Data_02B_68E2 ; id 83
    dw Data_02B_6931 ; id 84
    dw Data_02B_697C ; id 85
    dw Data_02B_69E0 ; id 86
    dw Data_02B_6A1F ; id 87
    dw Data_02B_6ACA ; id 88
    dw Data_02B_6B61 ; id 89
    dw Data_02B_6C21 ; id 90
    dw Data_02B_6C8A ; id 91
    dw Data_02B_6CEB ; id 92
    dw Data_02B_6E26 ; id 93
    dw Data_02B_6EA9 ; id 94
    dw Data_02B_6F04 ; id 95
    dw Data_02B_6F5F ; id 96
    dw Data_02B_6F9D ; id 97
    dw Data_02B_6FDE ; id 98
    dw Data_02B_6FFC ; id 99
    dw Data_02B_703B ; id 100
    dw Data_02B_7078 ; id 101
    dw Data_02B_7098 ; id 102
    dw Data_02B_70D9 ; id 103
    dw Data_02B_70FB ; id 104
    dw Data_02B_711E ; id 105
    dw Data_02B_7162 ; id 106
    dw Data_02B_71AF ; id 107
    dw Data_02B_71CB ; id 108
    dw Data_02B_71EC ; id 109
    dw Data_02B_7231 ; id 110
    dw Data_02B_726A ; id 111
    dw Data_02B_72B1 ; id 112
    dw Data_02B_731C ; id 113
    dw Data_02B_7339 ; id 114
    dw Data_02B_737D ; id 115
    dw Data_02B_73BE ; id 116
    dw Data_02B_747D ; id 117
    dw Data_02B_74E9 ; id 118
    dw Data_02B_756D ; id 119
    dw Data_02B_75B6 ; id 120
    dw Data_02B_761D ; id 121
    dw Data_02B_76A9 ; id 122
    dw Data_02B_7719 ; id 123
    dw Data_02B_777E ; id 124
    dw Data_02B_77DE ; id 125
    dw Data_02B_7849 ; id 126
    dw Data_02B_788C ; id 127
    dw Data_02B_7936 ; id 128
    dw Data_02B_79C1 ; id 129
    dw Data_02B_7A2A ; id 130
    dw Data_02B_7AB6 ; id 131
    dw Data_02B_7B3F ; id 132
    dw Data_02B_7BBF ; id 133
    dw Data_02B_7C1F ; id 134
    dw Data_02B_7C81 ; id 135
    dw Data_02B_7D19 ; id 136
    dw Data_02B_7D86 ; id 137

Data_02B_4148:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is Norden,", $F1
    db "the kingdom of the", $FA, $F7
    db $EF, $EE, "north.", $EF, $EE, $F7
    db $F0

Data_02B_417B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are three", $F1
    db "kingdoms situated", $FA, $F7
    db $EF, $EE, "around a lake.", $EF, $EE, "They are to the", $FA, $F7
    db $EF, $EE, "north, east and", $EF, $EE, "west.", $F7
    db $F0

Data_02B_41DE:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Travel north", $F1
    db "along the mountain", $FA, $F7
    db $EF, $EE, "range, and you'll", $EF, $EE, "find a spring.", $FA, $F7
    db $EF, $EE, "An elemental", $EF, $EE, "spirit of great", $FA, $F7
    db $EF, $EE, "beauty is said to", $EF, $EE, "live there.", $FA, $F7
    db $EF, $EE, "She is supposed to", $EF, $EE, "be a kindly spirit", $FA, $F7
    db $EF, $EE, "who watches over", $EF, $EE, "people.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to see", $EF, $EE, "her before I die", $A4, $F7
    db $F0

Data_02B_42D5:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The winter here", $F1
    db "is harsh.", $FA, $F7
    db $EF, $EE, "Stay outside and", $EF, $EE, "your eyelashes'll", $FA, $F7
    db $EF, $EE, "freeze and clamp", $EF, $EE, "your eyes shut!", $F7
    db $F0

Data_02B_433E:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Listen, did you", $F1
    db "hear?", $FA, $F7
    db $EF, $EE, "They found gold on", $EF, $EE, "the border with", $FA, $F7
    db $EF, $EE, "the kingdom in the", $EF, $EE, "west.", $FA, $F7
    db $EF, $EE, "The northern", $EF, $EE, "kingdom found it", $FA, $F7
    db $EF, $EE, "first, but the", $EF, $EE, "western kingdom is", $FA, $F7
    db $EF, $EE, "trying to hoard", $EF, $EE, "all the gold!", $F7
    db $F0

Data_02B_4406:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Urrrrrgh! The", $F1
    db "western wretches!", $FA, $F7
    db $EF, $EE, "The mine on the", $EF, $EE, "border is on a", $FA, $F7
    db $EF, $EE, "rich vein of pure", $EF, $EE, "gold!", $FA, $F7
    db $EF, $EE, "We should dig up", $EF, $EE, "the gold before", $FA, $F7
    db $EF, $EE, "the westerners", $EF, $EE, "take it!", $F7
    db $F0

Data_02B_44AA:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Everyone's been", $F1
    db "acting strangely", $FA, $F7
    db $EF, $EE, "since they found", $EF, $EE, "gold in the mine.", $FA, $F7
    db $EF, $EE, "Even the King has", $EF, $EE, "changed", $A4, $F7
    db $F0

Data_02B_4514:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The spring in", $F1
    db "the north, where", $FA, $F7
    db $EF, $EE, "the elemental", $EF, $EE, "lives, has frozen.", $FA, $F7
    db $EF, $EE, "It has never done", $EF, $EE, "that before, even", $FA, $F7
    db $EF, $EE, "in the worst cold", $EF, $EE, "spells.", $FA, $F7
    db $EF, $EE, "The spring froze", $EF, $EE, "when the gold was", $FA, $F7
    db $EF, $EE, "found. Could it be", $EF, $EE, "mere coincidence?", $F7
    db $F0

Data_02B_45F2:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you heard", $F1
    db "about the spirit", $FA, $F7
    db $EF, $EE, "in the spring?", $EF, $EE
    db $FF, $F0

Data_02B_462A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A long time ago", $F1
    db "the spirit made a", $FA, $F7
    db $EF, $EE, "shield using her", $EF, $EE, "mystical powers.", $FA, $F7
    db $EF, $EE, "The shield floated", $EF, $EE, "into the sky where", $FA, $F7
    db $EF, $EE, "it grew to an", $EF, $EE, "enormous size.", $FA, $F7
    db $EF, $EE, "The shield guarded", $EF, $EE, "people for many", $FA, $F7
    db $EF, $EE, "years from awful", $EF, $EE, "blizzards.", $FA, $F7
    db $EF, $EE, "Over time, the", $EF, $EE, "shield shrank back", $FA, $F7
    db $EF, $EE, "in size and fell", $EF, $EE, "from the sky.", $FA, $F7
    db $EF, $EE, "It was called the", $EF, $EE, "SkyShield.", $FA, $F7
    db $EF, $EE, "It is now interred", $EF, $EE, "in the spring.", $F7
    db $F0

Data_02B_4798:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Many years ago,", $F1
    db "our ancestors came", $FA, $F7
    db $EF, $EE, "to this land after", $EF, $EE, "a long journey.", $FA, $F7
    db $EF, $EE, "They were in a", $EF, $EE, "precarious state", $FA, $F7
    db $EF, $EE, "because of the", $EF, $EE, "vicious cold.", $FA, $F7
    db $EF, $EE, "The spring's", $EF, $EE, "spirit took pity", $FA, $F7
    db $EF, $EE, "on them and used", $EF, $EE, "her power to melt", $FA, $F7
    db $EF, $EE, "the ice and", $EF, $EE, "relieve the cold.", $FA, $F7
    db $EF, $EE, "Since then, the", $EF, $EE, "spirit has never", $FA, $F7
    db $EF, $EE, "appeared before", $EF, $EE, "us, but she still", $FA, $F7
    db $EF, $EE, "watches over us", $EF, $EE, "with compassion.", $F7
    db $F0

Data_02B_4905:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Around these", $F1
    db "parts, we get a", $FA, $F7
    db $EF, $EE, "lot of star spuds", $EF, $EE, "as our food.", $FA, $F7
    db $EF, $EE, "They're sort of", $EF, $EE, "like potatoes, but", $FA, $F7
    db $EF, $EE, "they grow by the", $EF, $EE, "light of stars.", $FA, $F7
    db $EF, $EE, "They're gifts from", $EF, $EE, "the spirit.", $FA, $F7
    db $EF, $EE, "Huh? Log's Navel?", $EF, $EE, "They're just spuds.", $F7
    db $F0

Data_02B_49DE:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's become much", $F1
    db "colder.", $FA, $F7
    db $EF, $EE, "We may need the", $EF, $EE, "help of the spirit", $FA, $F7
    db $EF, $EE, "again to break the", $EF, $EE, "cold spell.", $F7
    db $F0

Data_02B_4A44:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to our", $F1
    db "church.", $FA, $F7
    db $EF, $EE, "How may I be of", $EF, $EE, "service?", $F7
    db $F0

Data_02B_4A7C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " His Majesty is", $F1
    db "in talks with the", $FA, $F7
    db $EF, $EE, "western kingdom's", $EF, $EE, "representatives.", $FA, $F7
    db $EF, $EE, "He has no time to", $EF, $EE, "deal with a child.", $FA, $F7
    db $EF, $EE, "Well, there was", $EF, $EE, "another kid, but", $FA, $F7
    db $EF, $EE, "he claimed to be a", $EF, $EE, "prince somewhere.", $FA, $F7
    db $EF, $EE, "We had to let him", $EF, $EE, "through.", $F7
    db $F0

Data_02B_4B5D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The mine on the", $F1
    db "western border is", $FA, $F7
    db $EF, $EE, "closed right now.", $EF, $EE, "It will reopen", $FA, $F7
    db $EF, $EE, "when the trouble", $EF, $EE, "is solved.", $F7
    db $F0

Data_02B_4BC8:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! How may", $F1
    db "I serve you today?", $F7
    db $F0

Data_02B_4BF0:: ; heuristic: string; C0
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0 peered", $F1
    db "into the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "lumpy potatoes.", $F7
    db $F0

Data_02B_4C33:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "black rocks.", $F7
    db $F0

Data_02B_4C73:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It felt just a", $EF, $EE, "little warm.", $F7
    db $F0

Data_02B_4CAD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But the treasure", $EF, $EE, "chest was locked.", $F7
    db $F0

Data_02B_4CF1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The border is", $F1
    db "closed, so I can't", $FA, $F7
    db $EF, $EE, "get to the western", $EF, $EE, "kingdom.", $FA, $F7
    db $EF, $EE, "That's the only", $EF, $EE, "way to cross the", $FA, $F7
    db $EF, $EE, "mountains though.", $EF, $EE, "What a headache!", $F7
    db $F0

Data_02B_4D80:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shield.", $FA, $F7
    db $EF, $EE, "A beautiful voice", $EF, $EE, "echoed.", $F7
    db $F0

Data_02B_4DB6:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am surprised", $F1
    db "that you hear me.", $FA, $F7
    db $EF, $EE, "You aren't from", $EF, $EE, "this world.", $FA, $F7
    db $EF, $EE, "I am the elemental", $EF, $EE, "spirit who guards", $FA, $F7
    db $EF, $EE, "over this world.", $EF, $EE, "At least I did.", $FA, $F7
    db $EF, $EE, "I had lost my", $EF, $EE, "power, you see.", $FA, $F7
    db $EF, $EE, "I was rebuilding", $EF, $EE, "my power to make", $FA, $F7
    db $EF, $EE, "my return to the", $EF, $EE, "people, but some", $FA, $F7
    db $EF, $EE, "being cast a", $EF, $EE, "shadow over the", $FA, $F7
    db $EF, $EE, "hearts of the", $EF, $EE, "people.", $FA, $F7
    db $EF, $EE, "Even my spring", $EF, $EE, "finally froze.", $FA, $F7
    db $EF, $EE, "If peace returns", $EF, $EE, "to the souls of", $FA, $F7
    db $EF, $EE, "people, I too", $EF, $EE, "will be saved.", $FA, $F7
    db $EF, $EE, "I sense a magical", $EF, $EE, "power in you.", $FA, $F7
    db $EF, $EE, "Will you restore", $EF, $EE, "peace to people?"
    db $FF, $F0

Data_02B_4FA3:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You will?", $F1
    db "No words of thanks", $FA, $F7
    db $EF, $EE, "can ever be enough", $EF, $EE, "for what I feel.", $FA, $F7
    db $EF, $EE, "If you restore", $EF, $EE, "this world's peace,", $FA, $F7
    db $EF, $EE, "I will give you", $EF, $EE, "this Sky Shield.", $FA, $F7
    db $EF, $EE, "Take this Crest,", $EF, $EE, "child.", $FA, $F7
    db $EF, $EE, "It shows that you", $EF, $EE, "act as my envoy.", $FA, $F7
    db $EF, $EE, "It will let you", $EF, $EE, "into castles.", $F7
    db $F0

Data_02B_509C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "Crest.", $F7
    db $F0

Data_02B_50D7:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You may think", $F1
    db "terrible of me for", $FA, $F7
    db $EF, $EE, "asking you, a", $EF, $EE, "total stranger, to", $FA, $F7
    db $EF, $EE, "bear such a heavy", $EF, $EE, "burden", $A4, $FA, $F7
    db $EF, $EE, "But only you seem", $EF, $EE, "to hear my voice.", $FA, $F7
    db $EF, $EE, "Please. You are my", $EF, $EE, "only hope.", $F7
    db $F0

Data_02B_5189:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you restore", $F1
    db "this world's peace,", $FA, $F7
    db $EF, $EE, "I will give you", $EF, $EE, "this Sky Shield.", $FA, $F7
    db $EF, $EE, "My Crest will", $EF, $EE, "allow entry into", $FA, $F7
    db $EF, $EE, "castles as my", $EF, $EE, "envoy.", $F7
    db $F0

Data_02B_5210:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What is that", $F1
    db "dirty medal?", $FA, $F7
    db $EF, $EE, "The spirit's Crest!", $EF, $EE, "You're an envoy!", $FA, $F7
    db $EF, $EE, "I beg your pardon!", $EF, $EE, $F7
    db $F0

Data_02B_526D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please enter,", $F1
    db "your envoyship!", $F7
    db $F0

Data_02B_528F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " His Majesty has", $F1
    db "been cranky", $A4, $FA, $F7
    db $EF, $EE, "Is the trouble at", $EF, $EE, "the mine weighing", $FA, $F7
    db $EF, $EE, "heavily on his", $EF, $EE, "mind?", $F7
    db $F0

Data_02B_52F1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " After the gold", $F1
    db "discovery, our", $FA, $F7
    db $EF, $EE, "relationship with", $EF, $EE, "the west soured.", $FA, $F7
    db $EF, $EE, "It might lead to", $EF, $EE, "war", $A4, " ", $A4, "Shudder", $A4, $F7
    db $F0

Data_02B_535E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I remember the", $F1
    db "King to be placid,", $FA, $F7
    db $EF, $EE, "but he has been", $EF, $EE, "working hard as if", $FA, $F7
    db $EF, $EE, "he were possessed", $EF, $EE, "of late.", $F7
    db $F0

Data_02B_53CA:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you are the", $F1
    db "spirit's envoy.", $FA, $F7
    db $EF, $EE, "His Majesty is", $EF, $EE, "beyond here.", $FA, $F7
    db $EF, $EE, "I ask that you be", $EF, $EE, "on your best", $FA, $F7
    db $EF, $EE, "behavior.", $EF, $EE, $F7
    db $F0

Data_02B_543F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're the envoy?", $F1
    db $A4, "Well, no matter!", $FA, $F7
    db $EF, $EE, "We had started", $EF, $EE, "mining the", $FA, $F7
    db $EF, $EE, "mountains on the", $EF, $EE, "border first.", $FA, $F7
    db $EF, $EE, "The west comes", $EF, $EE, "along later and", $FA, $F7
    db $EF, $EE, "demands mining", $EF, $EE, "rights?", $FA, $F7
    db $EF, $EE, "Pah! The brazen", $EF, $EE, "nerve of them!", $FA, $F7
    db $EF, $EE, "This problem is", $EF, $EE, "solved by the west", $FA, $F7
    db $EF, $EE, "abandoning their", $EF, $EE, "frivolous claim.", $FA, $F7
    db $EF, $EE, "Until then, the", $EF, $EE, "border is closed!", $F7
    db $F0

Data_02B_557B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " His Majesty is", $F1
    db "furious over the", $FA, $F7
    db $EF, $EE, "western kingdom's", $EF, $EE, "conduct.", $FA, $F7
    db $EF, $EE, "He isn't open to", $EF, $EE, "reason anymore.", $F7
    db $F0

Data_02B_55E1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This tunnel goes", $F1
    db "to a port.", $FA, $F7
    db $EF, $EE, "The lake is frozen", $EF, $EE, "around it though,", $FA, $F7
    db $EF, $EE, "so now it can't", $EF, $EE, "serve as a port.", $F7
    db $F0

Data_02B_564E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the port", $F1
    db "of Nofor.", $F7
    db $F0

Data_02B_566D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's useless!", $F1
    db "Beyond useless!", $FA, $F7
    db $EF, $EE, "The ice has the", $EF, $EE, "port clogged.", $FA, $F7
    db $EF, $EE, "No ships can sail.", $EF, $EE, "I'll go bankrupt!", $F7
    db $F0

Data_02B_56D8:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In all my years,", $F1
    db "I", $42, "e never seen", $FA, $F7
    db $EF, $EE, "the port frozen in", $EF, $EE, "like that.", $F7
    db $F0

Data_02B_571E:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Three kingdoms", $F1
    db "ring this lake.", $FA, $F7
    db $EF, $EE, "They are in the", $EF, $EE, "north, west and", $FA, $F7
    db $EF, $EE, "east of the", $EF, $EE, "inland sea.", $FA, $F7
    db $EF, $EE, "The east is ruled", $EF, $EE, "by Queen Helen.", $FA, $F7
    db $EF, $EE, "She foresees the", $EF, $EE, "future in her", $FA, $F7
    db $EF, $EE, "dreams with", $EF, $EE, "amazing accuracy.", $F7
    db $F0

Data_02B_57EC:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The border?", $F1
    db "It's not here.", $FA, $F7
    db $EF, $EE, "The border is at", $EF, $EE, "the gold mine.", $FA, $F7
    db $EF, $EE, "Go back up through", $EF, $EE, "the tunnel, and go", $FA, $F7
    db $EF, $EE, "southwest along", $EF, $EE, "the mountains.", $F7
    db $F0

Data_02B_587B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Mama said to", $F1
    db "stay off the ice.", $FA, $F7
    db $EF, $EE, "It can break if", $EF, $EE, "it's too thin.", $F7
    db $F0

Data_02B_58C0:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We were passing", $F1
    db "through from the", $FA, $F7
    db $EF, $EE, "east, but the ice", $EF, $EE, "sealed us in.", $FA, $F7
    db $EF, $EE, "We", $42, "e been stuck", $EF, $EE, "here a month.", $F7
    db $F0

Data_02B_592B:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " They discovered", $F1
    db "gold at the mine", $FA, $F7
    db $EF, $EE, "on the western", $EF, $EE, "border!", $FA, $F7
    db $EF, $EE, "I wish someone"
    db $44, $EF, $EE, $2A, $2C, $39, $28, $90, $30, $28, $90, $36, $32, $30, $28, $B5
    db $F7, $F0

Data_02B_598D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hear the west", $F1
    db "and the north are", $FA, $F7
    db $EF, $EE, "locking horns over", $EF, $EE, "the gold mine.", $FA, $F7
    db $EF, $EE, "I can feel trouble", $EF, $EE, "stirring", $A4, $F7
    db $F0

Data_02B_59FA:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you know Lady", $F1
    db "Yuna of the west?", $FA, $F7
    db $EF, $EE, "I heard that she's", $EF, $EE, "really lively.", $FA, $F7
    db $EF, $EE, "I like cheerfully", $EF, $EE, "loud girls.", $F7
    db $F0

Data_02B_5A68:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The scholar in", $F1
    db "the tavern said he", $FA, $F7
    db $EF, $EE, "came from the", $EF, $EE, "eastern kingdom.", $FA, $F7
    db $EF, $EE, "He knows of every", $EF, $EE, "plant in the area.", $F7
    db $F0

Data_02B_5ADA:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't you think", $F1
    db "it's too expensive?", $FA, $F7
    db $EF, $EE, "If I had a Gold", $EF, $EE, "Pass, I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " get a", $FA, $F7
    db $EF, $EE, "bit of a discount,", $EF, $EE, "but even then", $A4, $F7
    db $F0

Data_02B_5B49:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! What", $F1
    db "can I do for you?", $F7
    db $F0

Data_02B_5B6D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Greetings! How", $F1
    db "shall I serve you?", $F7
    db $F0

Data_02B_5B93:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! Have a", $F1
    db "look at my wares!", $F7
    db $F0

Data_02B_5BB7:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We", $42, "e been full", $F1
    db "up with sailors", $FA, $F7
    db $EF, $EE, "who", $42, "e been stuck", $EF, $EE, "in port.", $FA, $F7
    db $EF, $EE, "We're doing brisk", $EF, $EE, "business, but the", $FA, $F7
    db $EF, $EE, "atmosphere-it's", $EF, $EE, "like a funeral.", $FA, $F7
    db $EF, $EE, "I can understand", $EF, $EE, "why a landlocked", $FA, $F7
    db $EF, $EE, "sailor would be", $EF, $EE, "down, but", $A4, $F7
    db $F0

Data_02B_5C87:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Urrrp! Hoo,", $F1
    db "listen to this!", $FA, $F7
    db $EF, $EE, "My ship, she froze", $EF, $EE, "solid in ice, hey?", $FA, $F7
    db $EF, $EE, "We left her and", $EF, $EE, "managed to make it", $FA, $F7
    db $EF, $EE, "ashore barely.", $EF, $EE, "Our cursed luck!", $F7
    db $F0

Data_02B_5D1C:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Sigh", $A4, " Isn't that", $F1
    db "scholar appealing?", $FA, $F7
    db $EF, $EE, "The intellect in", $EF, $EE, "his eyes", $A4, " Ooh", $A4, $F7
    db $F0

Data_02B_5D68:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I came from the", $F1
    db "eastern kingdom.", $FA, $F7
    db $EF, $EE, "I'm a scholar of", $EF, $EE, "plants.", $FA, $F7
    db $EF, $EE, "My studies have", $EF, $EE, "taken me afar.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to go", $EF, $EE, "back home though.", $FA, $F7
    db $EF, $EE, "I wonder when the", $EF, $EE, "ships will sail?", $F7
    db $F0

Data_02B_5E17:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King of the", $F1
    db "west is said to", $FA, $F7
    db $EF, $EE, "dote on his only", $EF, $EE, "daughter.", $FA, $F7
    db $EF, $EE, "She's supposed to", $EF, $EE, "be a lively kid.", $F7
    db $F0

Data_02B_5E80:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "border we share", $FA, $F7
    db $EF, $EE, "with the western", $EF, $EE, "kingdom.", $FA, $F7
    db $EF, $EE, "The cave you see", $EF, $EE, "there is the mine", $FA, $F7
    db $EF, $EE, "in which gold was", $EF, $EE, "discovered.", $F7
    db $F0

Data_02B_5F07:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The border has", $F1
    db "been sealed by the", $FA, $F7
    db $EF, $EE, "King's orders", $EF, $EE, "until the west", $FA, $F7
    db $EF, $EE, "recognizes the", $EF, $EE, "mine to be ours.", $F7
    db $F0

Data_02B_5F71:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A traveler, are", $F1
    db "you?", $FA, $F7
    db $EF, $EE, "Sorry, but I can't", $EF, $EE, "allow you to pass.", $FA, $F7
    db $EF, $EE, "The west is beyond", $EF, $EE, "here, but they", $42, "e", $FA, $F7
    db $EF, $EE, "also been digging", $EF, $EE, "from their side.", $FA, $F7
    db $EF, $EE, "So our hole and", $EF, $EE, "their hole ended", $FA, $F7
    db $EF, $EE, "up linking in the", $EF, $EE, "mountain.", $FA, $F7
    db $EF, $EE, "It's a sticky", $EF, $EE, "little mess.", $F7
    db $F0

Data_02B_6065:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our tunneling", $F1
    db "found gold, but we", $FA, $F7
    db $EF, $EE, "also ran into the", $EF, $EE, "tunnel the west", $FA, $F7
    db $EF, $EE, "was boring from", $EF, $EE, "their side.", $FA, $F7
    db $EF, $EE, "Both sides have", $EF, $EE, "laid claim to the", $FA, $F7
    db $EF, $EE, "gold and refuse", $EF, $EE, "to concede.", $FA, $F7
    db $EF, $EE, "That's why we have", $EF, $EE, "this standoff.", $F7
    db $F0

Data_02B_613B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This side is the", $F1
    db "western kingdom!", $FA, $F7
    db $EF, $EE, "You", $42, "e come from", $EF, $EE, "the other side!", $FA, $F7
    db $EF, $EE, "You're from the", $EF, $EE, "north! Be gone!", $F7
    db $F0

Data_02B_61A8:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The northerners", $EF, $EE, "want our gold!", $FA, $F7
    db $EF, $EE, "There's no trusting", $EF, $EE, "the greedy scum!", $FA, $F7
    db $EF, $EE, "They must be", $EF, $EE, "conspiring to take", $FA, $F7
    db $EF, $EE, "our land too, I", $EF, $EE, "just know it!", $F7
    db $F0

Data_02B_623A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The northerners", $F1
    db "muscled in on the", $FA, $F7
    db $EF, $EE, "gold mine that we", $EF, $EE, "discovered.", $FA, $F7
    db $EF, $EE, "Can you understand", $EF, $EE, "the arrogance?", $F7
    db $F0

Data_02B_62A8:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Heh, you", $42, "e come", $F1
    db "way down deep.", $FA, $F7
    db $EF, $EE, "The monsters are", $EF, $EE, "tough down here!", $F7
    db $F0

Data_02B_62F1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There is a", $F1
    db "boulder blocking", $FA, $F7
    db $EF, $EE, "the way a little", $EF, $EE, "further ahead.", $FA, $F7
    db $EF, $EE, "If there was a way", $EF, $EE, "to break it", $A4, $F7
    db $F0

Data_02B_6359:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hurry! We have", $F1
    db "to beat the swine", $FA, $F7
    db $EF, $EE, "of the west to the", $EF, $EE, "mine!", $F7
    db $F0

Data_02B_639B:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The vein of gold", $F1
    db "is just ahead!", $FA, $F7
    db $EF, $EE, "Hurry! It's winner", $EF, $EE, "take all!", $F7
    db $F0

Data_02B_63DF:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The gold is", $F1
    db "ours! The west", $FA, $F7
    db $EF, $EE, "must not get their", $EF, $EE, "hands on it!", $FA, $F7
    db $EF, $EE, "Hurry, we're almost", $EF, $EE, "there!", $F7
    db $F0

Data_02B_6440:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Kid, you have", $F1
    db "guts to be here.", $F7
    db $F0

Data_02B_6463:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't you touch", $F1
    db "that.", $FA, $F7
    db $EF, $EE, "If you had only", $EF, $EE, "dreamt of the gold", $FA, $F7
    db $EF, $EE, "like the fools", $EF, $EE, "outside", $A4, $FA, $F7
    db $EF, $EE, "Your sneaking", $EF, $EE, "around isn't good", $FA, $F7
    db $EF, $EE, "for our plans.", $EF, $EE, "You'll have to go.", $F7
    db $F0

Data_02B_6507:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You again? I'll", $F1
    db "have to get ugly.", $F7
    db $F0

Data_02B_652C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Darn! Take this!", $F1
    db "SACRIFICE!", $F7
    db $F0

Data_02B_654C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? What was", $F1
    db "that explosion?", $F7
    db $F0

Data_02B_656F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That dust there", $A4, $F1
    db "Is that the gold?", $F7
    db $F0

Data_02B_6596:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? That's all", $F1
    db "that there was?", $FA, $F7
    db $EF, $EE, "You mean to tell", $EF, $EE, "me that we", $42, "e been", $FA, $F7
    db $EF, $EE, "acting like", $EF, $EE, "loggerheads over", $FA, $F7
    db $EF, $EE, "just that?", $EF, $EE, $F7
    db $F0

Data_02B_6612:: ; heuristic: string; C0
    db $EA, $45, $90, $20, $28, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better get", $F1
    db "word to the King!", $F7
    db $F0

Data_02B_6637:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That's true", $A4, $F1
    db "I", $42, "e got to", $A4, $FA, $F7
    db $EF, $EE, "I have to tell my", $EF, $EE, "King the news!", $F7
    db $F0

Data_02B_6678:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We almost went", $F1
    db "to war with the", $FA, $F7
    db $EF, $EE, "west over a tiny", $EF, $EE, "amount of gold.", $FA, $F7
    db $EF, $EE, "We must have been", $EF, $EE, "possessed.", $F7
    db $F0

Data_02B_66E1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King has", $F1
    db "sealed the border.", $FA, $F7
    db $EF, $EE, "He suspects that", $EF, $EE, "the whole incident", $FA, $F7
    db $EF, $EE, "was concocted by", $EF, $EE, "the west.", $F7
    db $F0

Data_02B_674C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We're still under", $F1
    db "orders to keep the", $FA, $F7
    db $EF, $EE, "border with the", $EF, $EE, "west sealed.", $FA, $F7
    db $EF, $EE, "This, despite the", $EF, $EE, "absence of gold.", $FA, $F7
    db $EF, $EE, "What's gotten into", $EF, $EE, "his Majesty?", $F7
    db $F0

Data_02B_67DF:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Was that really", $F1
    db "all the gold?", $FA, $F7
    db $EF, $EE, "To find out, we", $42, "e", $EF, $EE, "started excavating", $FA, $F7
    db $EF, $EE, "together with the", $EF, $EE, "westerners.", $FA, $F7
    db $EF, $EE, "Once you get to", $EF, $EE, "know them, they're", $FA, $F7
    db $EF, $EE, "not bad people at", $EF, $EE, "all.", $F7
    db $F0

Data_02B_688D:: ; heuristic: string; C0
    db $EA, $45, $90, $12, $42, $28, $90, $2B, $28, $24, $35, $27, $A4, $F1, $FA, $F7
    db $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There was almost", $EF, $EE, "no gold at all.", $FA, $F7
    db $EF, $EE, "What purpose did", $EF, $EE, "we serve?", $F7
    db $F0

Data_02B_68E2:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The north's King", $F1
    db "still suspects us.", $FA, $F7
    db $EF, $EE, "I'm sorry, but we", $EF, $EE, "can't let you pass.", $F7
    db $F0

Data_02B_6931:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We're not certain", $F1
    db "about what we'll", $FA, $F7
    db $EF, $EE, "find, but we'll", $EF, $EE, "keep picking away.", $F7
    db $F0

Data_02B_697C:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e heard about", $F1
    db "the mine.", $FA, $F7
    db $EF, $EE, "Isn't it horrible?", $EF, $EE, "Squabbling over", $FA, $F7
    db $EF, $EE, "gold that wasn't", $EF, $EE, "even there", $A4, $F7
    db $F0

Data_02B_69E0:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's just no", $F1
    db "telling what greed", $FA, $F7
    db $EF, $EE, "will make people", $EF, $EE, "do", $A4, $F7
    db $F0

Data_02B_6A1F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you know?", $F1
    db "There is a tunnel", $FA, $F7
    db $EF, $EE, "on the way to the", $EF, $EE, "border.", $FA, $F7
    db $EF, $EE, "It leads to a", $EF, $EE, "little port.", $FA, $F7
    db $EF, $EE, "If you're going to", $EF, $EE, "the west, it might", $FA, $F7
    db $EF, $EE, "be worth your time", $EF, $EE, "to visit.", $F7
    db $F0

Data_02B_6ACA:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e heard from", $F1
    db "friends who came", $FA, $F7
    db $EF, $EE, "back from the mine", $EF, $EE, "that there's no", $FA, $F7
    db $EF, $EE, "gold to be found", $EF, $EE, "there at all.", $FA, $F7
    db $EF, $EE, "But the King still", $EF, $EE, "suspects the west", $A4, $F7
    db $F0

Data_02B_6B61:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We reported to", $F1
    db "the King that the", $FA, $F7
    db $EF, $EE, "mine had no gold", $EF, $EE, "to start with,", $FA, $F7
    db $EF, $EE, "but he refuses to", $EF, $EE, "believe us and", $FA, $F7
    db $EF, $EE, "blames the west", $EF, $EE, "for stealing the", $FA, $F7
    db $EF, $EE, "gold.", $EF, $EE, "Perhaps you can", $FA, $F7
    db $EF, $EE, "speak to him?", $EF, $EE, $F7
    db $F0

Data_02B_6C21:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What is it, you", $F1
    db "whelp!?", $FA, $F7
    db $EF, $EE, "You claim that the", $EF, $EE, "mine has no gold?", $FA, $F7
    db $EF, $EE, "You dare question", $EF, $EE, "my authority?", $F7
    db $F0

Data_02B_6C8A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're no envoy", $F1
    db "of the spirit!", $FA, $F7
    db $EF, $EE, "You must be a", $EF, $EE, "western spy!", $FA, $F7
    db $EF, $EE, "You can rot in the", $EF, $EE, "dungeon!", $F7
    db $F0

Data_02B_6CEB:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, saved at", $F1
    db "last!", $FA, $F7
    db $EF, $EE, "The two of us were", $EF, $EE, "trapped alone.", $FA, $F7
    db $EF, $EE, "I'm the real King.", $EF, $EE, "The one on my", $FA, $F7
    db $EF, $EE, "throne is a vile", $EF, $EE, "impostor!", $FA, $F7
    db $EF, $EE, "I was abducted in", $EF, $EE, "my sleep and held", $FA, $F7
    db $EF, $EE, "captive down here.", $EF, $EE, "I tried to escape", $FA, $F7
    db $EF, $EE, "but the exit has", $EF, $EE, "been sealed.", $FA, $F7
    db $EF, $EE, "It was closed up", $EF, $EE, "recently, but I", $FA, $F7
    db $EF, $EE, "have no idea where", $EF, $EE, "to find it.", $F7
    db $F0

Data_02B_6E26:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I want to get", $F1
    db "out, but the exit", $FA, $F7
    db $EF, $EE, "has been sealed.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It was closed up", $EF, $EE, "recently, but I", $FA, $F7
    db $EF, $EE, "have no idea where", $EF, $EE, "to find it.", $F7
    db $F0

Data_02B_6EA9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Where's", $F1
    db "the exit?", $FA, $F7
    db $EF, $EE, "We'll starve down", $EF, $EE, "here if we don't", $FA, $F7
    db $EF, $EE, "find the way out", $EF, $EE, "soon!", $F7
    db $F0

Data_02B_6F04:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Where's", $F1
    db "the exit?", $FA, $F7
    db $EF, $EE, "We'll starve down", $EF, $EE, "here if we don't", $FA, $F7
    db $EF, $EE, "find the way out", $EF, $EE, "soon!", $F7
    db $F0

Data_02B_6F5F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tapped on", $F1
    db "the wall.", $FA, $F7
    db $EF, $EE, "The wall sounded", $EF, $EE, "heavy and solid.", $F7
    db $F0

Data_02B_6F9D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " So that's", $F1
    db "where the exit is!", $FA, $F7
    db $EF, $EE, $F9, "0, here, stand", $EF, $EE, "aside!", $F7
    db $F0

Data_02B_6FDE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, $F9, "0", $A4, $F1
    db "That wasn't it", $A4, $F7
    db $F0

Data_02B_6FFC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tapped on", $F1
    db "the wall.", $FA, $F7
    db $EF, $EE, "Sound echoed as if", $EF, $EE, "it were hollow.", $F7
    db $F0

Data_02B_703B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " That's it!", $F1
    db "That's the exit!", $FA, $F7
    db $EF, $EE, $F9, "0, I'll go on", $EF, $EE, "ahead!", $F7
    db $F0

Data_02B_7078:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm the real", $F1
    db "King, you fake!", $F7
    db $F0

Data_02B_7098:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? How dare", $F1
    db "you, impostor!", $FA, $F7
    db $EF, $EE, "I'm the real King!", $EF, $EE, "Not you!", $F7
    db $F0

Data_02B_70D9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm real! Don't", $F1
    db "you believe me?", $F7
    db $F0

Data_02B_70FB:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Look in my eyes!", $F1
    db "I'm not lying!", $F7
    db $F0

Data_02B_711E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you can't see", $F1
    db "the truth, you'll", $FA, $F7
    db $EF, $EE, "never become a", $EF, $EE, "great hero!", $F7
    db $F0

Data_02B_7162:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Didn't we work", $F1
    db "together to escape", $FA, $F7
    db $EF, $EE, "from the dungeon?", $EF, $EE, "I'm the real King!", $F7
    db $F0

Data_02B_71AF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The mirror shows", $F1
    db "the King.", $F7
    db $F0

Data_02B_71CB:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am real!", $F1
    db "Don't believe him!", $F7
    db $F0

Data_02B_71EC:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My regal bearing", $F1
    db "should be evidence", $FA, $F7
    db $EF, $EE, "that I am the real", $EF, $EE, "King!", $F7
    db $F0

Data_02B_7231:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Look at him!", $F1
    db "He's grimy!", $FA, $F7
    db $EF, $EE, "He's no comparison", $EF, $EE, "to me!", $F7
    db $F0

Data_02B_726A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You suspect me", $F1
    db "still? Kiki!", $FA, $F7
    db $EF, $EE, "Gaaah! A slip of", $EF, $EE, "the tongue, kiki!", $F7
    db $F0

Data_02B_72B1:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Arrgh, you", $42, "e", $F1
    db "ruined my plan to", $FA, $F7
    db $EF, $EE, "cause conflict by", $EF, $EE, "impersonating the", $FA, $F7
    db $EF, $EE, "King, kikiki!", $EF, $EE, "You will pay!", $F7
    db $F0

Data_02B_731C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The mirror shows a", $F1
    db "monster.", $F7
    db $F0

Data_02B_7339:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It almost worked", $F1
    db "to perfection!", $FA, $F7
    db $EF, $EE, "It's all your", $EF, $EE, "fault, kikiki!", $F7
    db $F0

Data_02B_737D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Awaaargh!", $F1
    db "A m-m-monster!", $FA, $F7
    db $EF, $EE, "A monster was", $EF, $EE, "impersonating me!", $F7
    db $F0

Data_02B_73BE:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bravo!", $F1
    db "We're saved!", $FA, $F7
    db $EF, $EE, "Thank you for", $EF, $EE, "seeing that I am", $FA, $F7
    db $EF, $EE, "the true King of", $EF, $EE, "Norden!", $FA, $F7
    db $EF, $EE, "I will put a stop", $EF, $EE, "to the squabbling", $FA, $F7
    db $EF, $EE, "with the western", $EF, $EE, "kingdom.", $FA, $F7
    db $EF, $EE, "I'll have the", $EF, $EE, "border reopened.", $F7
    db $F0

Data_02B_747D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I'll have", $F1
    db "the border opened.", $FA, $F7
    db $EF, $EE, "It is a long way", $EF, $EE, "to the western", $FA, $F7
    db $EF, $EE, "kingdom, however.", $EF, $EE, "Do take care.", $F7
    db $F0

Data_02B_74E9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who would", $42, "e", $F1
    db "thought that a", $FA, $F7
    db $EF, $EE, "monster would pose", $EF, $EE, "as the King?", $FA, $F7
    db $EF, $EE, "Nobody realized", $EF, $EE, "what happened.", $FA, $F7
    db $EF, $EE, "The King must be", $EF, $EE, "furious", $A4, $F7
    db $F0

Data_02B_756D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, we managed", $F1
    db "to avoid war with", $FA, $F7
    db $EF, $EE, "the west. That's a", $EF, $EE, "good thing.", $F7
    db $F0

Data_02B_75B6:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is just", $F1
    db "between you and", $FA, $F7
    db $EF, $EE, "me, but the fake", $EF, $EE, "King was a harder", $FA, $F7
    db $EF, $EE, "worker than the", $EF, $EE, "real King.", $F7
    db $F0

Data_02B_761D:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who was that boy", $F1
    db "who came out of", $FA, $F7
    db $EF, $EE, "the dungeon with", $EF, $EE, "the King?", $FA, $F7
    db $EF, $EE, "He can't be the", $EF, $EE, "King's son, but he", $FA, $F7
    db $EF, $EE, "was dressed in a", $EF, $EE, "regal manner", $A4, $F7
    db $F0

Data_02B_76A9:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The border with", $F1
    db "the west is open!", $FA, $F7
    db $EF, $EE, "But the western", $EF, $EE, "kingdom is far", $FA, $F7
    db $EF, $EE, "away, you should", $EF, $EE, "be very cautious.", $F7
    db $F0

Data_02B_7719:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The discovery of", $F1
    db "gold was a bust", $A4, $FA, $F7
    db $EF, $EE, "It's disappointing,", $EF, $EE, "it really is", $A4, $FA, $F7
    db $EF, $EE, "My rings", $A4, $EF, $EE, "My bangles", $A4, $F7
    db $F0

Data_02B_777E:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King gave", $F1
    db "word to lift the", $FA, $F7
    db $EF, $EE, "blockade of the", $EF, $EE, "border.", $FA, $F7
    db $EF, $EE, "The trouble is", $EF, $EE, "finally over.", $F7
    db $F0

Data_02B_77DE:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A monster was", $F1
    db "playing the part", $FA, $F7
    db $EF, $EE, "of our King", $A4, $EF, $EE, "It's no wonder we", $FA, $F7
    db $EF, $EE, "were getting such", $EF, $EE, "bizarre orders.", $F7
    db $F0

Data_02B_7849:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the town", $F1
    db "of Weston.", $FA, $F7
    db $EF, $EE, "It's the western", $EF, $EE, "kingdom's port.", $F7
    db $F0

Data_02B_788C:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The west's castle", $F1
    db "has seen a steady", $FA, $F7
    db $EF, $EE, "stream of visitors", $EF, $EE, "and gifts.", $FA, $F7
    db $EF, $EE, "They're offering a", $EF, $EE, "reward if you can", $FA, $F7
    db $EF, $EE, "cheer Lady Yuna", $EF, $EE, "up.", $FA, $F7
    db $EF, $EE, "I'm thinking of", $EF, $EE, "going myself.", $F7
    db $F0

Data_02B_7936:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Across from us", $F1
    db "on the lake is the", $FA, $F7
    db $EF, $EE, "eastern kingdom.", $EF, $EE, "It's ruled by", $FA, $F7
    db $EF, $EE, "Queen Helen, I", $EF, $EE, "think.", $FA, $F7
    db $EF, $EE, "Will our Lady Yuna", $EF, $EE, "become our queen?", $F7
    db $F0

Data_02B_79C1:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I saw Lady Yuna", $F1
    db "riding towards the", $FA, $F7
    db $EF, $EE, "forest in the", $EF, $EE, "southeast.", $FA, $F7
    db $EF, $EE, "She looked dashing", $EF, $EE, "on her steed.", $F7
    db $F0

Data_02B_7A2A:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna has", $F1
    db "been a lively girl", $FA, $F7
    db $EF, $EE, "for as long as I", $EF, $EE, "can remember.", $FA, $F7
    db $EF, $EE, "Her habit of", $EF, $EE, "sneaking out of", $FA, $F7
    db $EF, $EE, "the Castle vexed", $EF, $EE, "us to no end.", $F7
    db $F0

Data_02B_7AB6:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I haven't been", $F1
    db "seeing too many", $FA, $F7
    db $EF, $EE, "ships coming into", $EF, $EE, "our harbor.", $FA, $F7
    db $EF, $EE, "I wonder why that", $EF, $EE, "could be.", $FA, $F7
    db $EF, $EE, "Ships make great", $EF, $EE, "transportation.", $F7
    db $F0

Data_02B_7B3F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna is", $F1
    db "said to be quiet", $FA, $F7
    db $EF, $EE, "and withdrawn", $EF, $EE, "these days.", $FA, $F7
    db $EF, $EE, "Perhaps she is", $EF, $EE, "trying to cope", $FA, $F7
    db $EF, $EE, "with adolescent", $EF, $EE, "concerns", $A4, $F7
    db $F0

Data_02B_7BBF:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e heard rumors", $F1
    db "that something is", $FA, $F7
    db $EF, $EE, "wrong with Lady", $EF, $EE, "Yuna.", $FA, $F7
    db $EF, $EE, "I wonder what it", $EF, $EE, "could be?", $F7
    db $F0

Data_02B_7C1F:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King dotes", $F1
    db "over Lady Yuna.", $FA, $F7
    db $EF, $EE, "He"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " gladly give", $EF, $EE, "up his own life", $FA, $F7
    db $EF, $EE, "for her sake, I'm", $EF, $EE, "sure.", $F7
    db $F0

Data_02B_7C81:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The road to the", $F1
    db "eastern kingdom is", $FA, $F7
    db $EF, $EE, "teeming with tough", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "If you're thinking", $EF, $EE, "of going, it may", $FA, $F7
    db $EF, $EE, "be less dangerous", $EF, $EE, "to cross the lake.", $F7
    db $F0

Data_02B_7D19:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna locks", $F1
    db "herself in her", $FA, $F7
    db $EF, $EE, "room all day long", $EF, $EE, "and won't come out.", $FA, $F7
    db $EF, $EE, "The King is at his", $EF, $EE, "wit's end.", $F7
    db $F0

Data_02B_7D86:: ; heuristic: string; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you can cheer", $F1
    db "up the princess,", $FA, $F7
    db $EF, $EE, "you can earn a", $EF, $EE, "reward, I hear.", $FA, $F7
    db $EF, $EE, "A whole lot of", $EF, $EE, "challengers have", $FA, $F7
    db $EF, $EE, "already gone to", $EF, $EE, "the Castle.", $FA, $F7
    db $EF, $EE, "Maybe I ought to", $EF, $EE, "try too", $A4, $FA, $F7
    db $EF, $EE, "The Castle is to", $EF, $EE, "the west. Just go", $FA, $F7
    db $EF, $EE, "along the river", $EF, $EE, "and you're there!", $F7
    db $F0
    ds $183, $00
