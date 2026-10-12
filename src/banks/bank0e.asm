SECTION "Bank 0E", ROMX[$4000], BANK[$0E]
    db $0E

; only called from DebugMessageTest_Update_Case1C (E-0047)
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_Case1C)
; reads: wStringIndex
DebugMessageTest_Update_Case1C_Sub01::
Func_00E_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $88
    jr c, Jump_00E_400F
    farcall DebugMessageTest_Update_Case1C_Sub01_Sub01
    ret

Jump_00E_400F::
    ld de, MessageStrings_Bank0E
    call BeginStringDisplay
    ret

; message bank $0E: when wStringIndex < $88, CopyStringToBuffer with this bank's table Data_00E_4032; otherwise far-calls Func_096_7020 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank0E:: ; heuristic: follows a terminator; C0
Func_00E_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $88
    jr c, Jump_00E_4024
    farcall CopyStringToBuffer_Bank0E_Overflow
    ret

Jump_00E_4024::
    ld de, MessageStrings_Bank0E
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_0E_4032::
MessageStrings_Bank0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00E_4032:: ; address name
    dw StringList_0E_4034 ; id 0

; E-0217 (derived: category list of StringCategories_0E_4032; one pointer per wStringIndex)
; record: string
StringList_0E_4034::
Data_00E_4034:: ; address name
    dw Data_00E_4144 ; id 0
    dw Data_00E_4144 ; id 1
    dw Data_00E_4144 ; id 2
    dw Data_00E_4144 ; id 3
    dw Data_00E_4144 ; id 4
    dw Data_00E_4144 ; id 5
    dw Data_00E_4144 ; id 6
    dw Data_00E_4144 ; id 7
    dw Data_00E_4144 ; id 8
    dw Data_00E_4144 ; id 9
    dw Data_00E_4144 ; id 10
    dw Data_00E_4144 ; id 11
    dw Data_00E_4167 ; id 12
    dw Data_00E_4188 ; id 13
    dw Data_00E_4188 ; id 14
    dw Data_00E_4188 ; id 15
    dw Data_00E_4188 ; id 16
    dw Data_00E_4188 ; id 17
    dw Data_00E_4188 ; id 18
    dw Data_00E_41A6 ; id 19
    dw Data_00E_41CA ; id 20
    dw Data_00E_4206 ; id 21
    dw Data_00E_4217 ; id 22
    dw Data_00E_4237 ; id 23
    dw Data_00E_425E ; id 24
    dw Data_00E_429E ; id 25
    dw Data_00E_42B9 ; id 26
    dw Data_00E_4304 ; id 27
    dw Data_00E_4342 ; id 28
    dw Data_00E_4369 ; id 29
    dw Data_00E_4369 ; id 30
    dw Data_00E_4369 ; id 31
    dw Data_00E_4369 ; id 32
    dw Data_00E_4369 ; id 33
    dw Data_00E_4369 ; id 34
    dw Data_00E_43AD ; id 35
    dw Data_00E_43D4 ; id 36
    dw Data_00E_441B ; id 37
    dw Data_00E_443C ; id 38
    dw Data_00E_447C ; id 39
    dw Data_00E_449D ; id 40
    dw Data_00E_450D ; id 41
    dw Data_00E_452F ; id 42
    dw Data_00E_45A8 ; id 43
    dw Data_00E_45DF ; id 44
    dw Data_00E_4602 ; id 45
    dw Data_00E_4602 ; id 46
    dw Data_00E_4602 ; id 47
    dw Data_00E_4602 ; id 48
    dw Data_00E_4602 ; id 49
    dw Data_00E_4602 ; id 50
    dw Data_00E_4640 ; id 51
    dw Data_00E_4663 ; id 52
    dw Data_00E_46AF ; id 53
    dw Data_00E_46D0 ; id 54
    dw Data_00E_4719 ; id 55
    dw Data_00E_473E ; id 56
    dw Data_00E_47A7 ; id 57
    dw Data_00E_47C3 ; id 58
    dw Data_00E_480B ; id 59
    dw Data_00E_4841 ; id 60
    dw Data_00E_4864 ; id 61
    dw Data_00E_4864 ; id 62
    dw Data_00E_4864 ; id 63
    dw Data_00E_4864 ; id 64
    dw Data_00E_4864 ; id 65
    dw Data_00E_4864 ; id 66
    dw Data_00E_4882 ; id 67
    dw Data_00E_48BF ; id 68
    dw Data_00E_48E4 ; id 69
    dw Data_00E_4903 ; id 70
    dw Data_00E_4946 ; id 71
    dw Data_00E_4968 ; id 72
    dw Data_00E_49D1 ; id 73
    dw Data_00E_49F4 ; id 74
    dw Data_00E_4A34 ; id 75
    dw Data_00E_4A6F ; id 76
    dw Data_00E_4A92 ; id 77
    dw Data_00E_4A92 ; id 78
    dw Data_00E_4A92 ; id 79
    dw Data_00E_4A92 ; id 80
    dw Data_00E_4A92 ; id 81
    dw Data_00E_4A92 ; id 82
    dw Data_00E_4ADB ; id 83
    dw Data_00E_4B00 ; id 84
    dw Data_00E_4B4F ; id 85
    dw Data_00E_4B6F ; id 86
    dw Data_00E_4B96 ; id 87
    dw Data_00E_4BB8 ; id 88
    dw Data_00E_4C28 ; id 89
    dw Data_00E_4C4C ; id 90
    dw Data_00E_4CB8 ; id 91
    dw Data_00E_4CEF ; id 92
    dw Data_00E_4D16 ; id 93
    dw Data_00E_4D16 ; id 94
    dw Data_00E_4D16 ; id 95
    dw Data_00E_4D16 ; id 96
    dw Data_00E_4D16 ; id 97
    dw Data_00E_4D16 ; id 98
    dw Data_00E_4D61 ; id 99
    dw Data_00E_4D85 ; id 100
    dw Data_00E_4DCE ; id 101
    dw Data_00E_4DEF ; id 102
    dw Data_00E_4E33 ; id 103
    dw Data_00E_4E58 ; id 104
    dw Data_00E_4EC8 ; id 105
    dw Data_00E_4EE5 ; id 106
    dw Data_00E_4F76 ; id 107
    dw Data_00E_4FBD ; id 108
    dw Data_00E_4FE4 ; id 109
    dw Data_00E_4FE4 ; id 110
    dw Data_00E_4FE4 ; id 111
    dw Data_00E_4FE4 ; id 112
    dw Data_00E_4FE4 ; id 113
    dw Data_00E_4FE4 ; id 114
    dw Data_00E_5026 ; id 115
    dw Data_00E_5049 ; id 116
    dw Data_00E_508B ; id 117
    dw Data_00E_50AB ; id 118
    dw Data_00E_50CE ; id 119
    dw Data_00E_50ED ; id 120
    dw Data_00E_5159 ; id 121
    dw Data_00E_517A ; id 122
    dw Data_00E_520A ; id 123
    dw Data_00E_5243 ; id 124
    dw Data_00E_526A ; id 125
    dw Data_00E_526A ; id 126
    dw Data_00E_526A ; id 127
    dw Data_00E_526A ; id 128
    dw Data_00E_526A ; id 129
    dw Data_00E_526A ; id 130
    dw Data_00E_52A6 ; id 131
    dw Data_00E_52CB ; id 132
    dw Data_00E_530F ; id 133
    dw Data_00E_532E ; id 134
    dw Data_00E_5350 ; id 135

Data_00E_4144:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault.", $F7
    db $F0

Data_00E_4167:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is it OK to save", $F1
    db "the results?", $F0

Data_00E_4188:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Too bad", $A4, " Let's", $F1
    db "meet again.", $F7
    db $F0

Data_00E_41A6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who will breed", $F1
    db "with my SpikyBoy?", $F0

Data_00E_41CA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Would you like", $F1
    db "to breed a monster", $FA, $F7
    db $EF, $EE, "with my SpikyBoy?", $EF, $EE, $F0

Data_00E_4206:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This monster?", $F0

Data_00E_4217:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A low-level one", $F1
    db "can't breed.", $F7
    db $F0

Data_00E_4237:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your party won't", $F1
    db "have any monsters.", $F7
    db $F0

Data_00E_425E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Something huge", $F1
    db "will result", $A4, $FA, $F7
    db $EF, $EE, "Shall we begin the", $EF, $EE, "breeding?", $F0

Data_00E_429E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let's get this", $F1
    db "started!", $F7
    db $F0

Data_00E_42B9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Breeding could", $F1
    db "get you unexpected", $FA, $F7
    db $EF, $EE, "skills. It never", $EF, $EE, "hurts to breed.", $F7
    db $F0

Data_00E_4304:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $F1
    db "will result,", $FA, $F7
    db $EF, $EE, "I think.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Shall we begin", $F1
    db "breeding?", $F0

Data_00E_4342:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "now in the Vault.", $F7
    db $F0

Data_00E_4369:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Well,", $F1
    db "that's too bad.", $FA, $F7
    db $EF, $EE, "Tell me if you", $EF, $EE, "change your mind.", $F7
    db $F0

Data_00E_43AD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which one's going", $F1
    db "with my ArmorPede?", $F0

Data_00E_43D4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, want to try", $F1
    db "breeding a monster", $FA, $F7
    db $EF, $EE, "of yours with my", $EF, $EE, "ArmorPede?", $F0

Data_00E_441B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is this the one", $F1
    db "for breeding?", $F0

Data_00E_443C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't stick me", $F1
    db "with a low-level", $FA, $F7
    db $EF, $EE, "monster!", $EF, $EE, "That's not fair!", $F7
    db $F0

Data_00E_447C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who's going to", $F1
    db "stay with you?", $F7
    db $F0

Data_00E_449D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? Woohoo, I", $F1
    db "think this pair is", $FA, $F7
    db $EF, $EE, "going to make a", $EF, $EE, "serious monster!", $FA, $F7
    db $EF, $EE, "All right if we", $EF, $EE, "get this started?", $F0

Data_00E_450D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Great, let's get", $F1
    db "this started.", $F7
    db $F0

Data_00E_452F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you get an", $F1
    db "EvilArmor, breed", $FA, $F7
    db $EF, $EE, "it with a material", $EF, $EE, "family partner.", $FA, $F7
    db $EF, $EE, "Doesn't that sound", $EF, $EE, "like a tough", $FA, $F7
    db $EF, $EE, "combo?", $EF, $EE, $F7
    db $F0

Data_00E_45A8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0 is", $F1
    db "what you'll get.", $FA, $F7
    db $EF, $EE, "Can we get going", $EF, $EE, "already?", $F0

Data_00E_45DF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault.", $F7
    db $F0

Data_00E_4602:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm", $A4, " That is", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I hope we will", $EF, $EE, "meet again.", $F7
    db $F0

Data_00E_4640:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which will be my", $F1
    db "Gulpple's mate?", $F0

Data_00E_4663:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello, would you", $F1
    db "like to breed one", $FA, $F7
    db $EF, $EE, "of your monsters", $EF, $EE, "with my Gulpple?", $F0

Data_00E_46AF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is this your", $F1
    db "breeding choice?", $F0

Data_00E_46D0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This monster is", $F1
    db "too low in level", $FA, $F7
    db $EF, $EE, "to make an attempt", $EF, $EE, "at breeding.", $F7
    db $F0

Data_00E_4719:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll have no", $F1
    db "monsters with you.", $F7
    db $F0

Data_00E_473E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Goodness, I", $F1
    db "believe this pair", $FA, $F7
    db $EF, $EE, "will result in one", $EF, $EE, "tough offspring.", $FA, $F7
    db $EF, $EE, "Well, shall we get", $EF, $EE, "started?", $F0

Data_00E_47A7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ready? Then", $F1
    db "let's begin.", $F7
    db $F0

Data_00E_47C3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So this pairing", $F1
    db "results in this", $FA, $F7
    db $EF, $EE, "species", $A4, " I", $44, " better", $EF, $EE, "record this!", $F7
    db $F0

Data_00E_480B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $F1
    db "will be the", $FA, $F7
    db $EF, $EE, "result.", $FA, $F7
    db $EF, $EE, "Is it OK to", $EF, $EE, "proceed?", $F0

Data_00E_4841:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault.", $F7
    db $F0

Data_00E_4864:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Are you", $F1
    db "kidding me?", $F7
    db $F0

Data_00E_4882:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, matey, want", $F1
    db "to breed something", $FA, $F7
    db $EF, $EE, "with my WildApe?", $EF, $EE, $F0

Data_00E_48BF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What'll you put", $F1
    db "up for my WildApe?", $F0

Data_00E_48E4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is this one", $F1
    db "going to breed?", $F0

Data_00E_4903:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cut me a little", $F1
    db "slack here.", $FA, $F7
    db $EF, $EE, "Nothing too low in", $EF, $EE, "level, hey?", $F7
    db $F0

Data_00E_4946:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll be all", $F1
    db "alone if you do.", $F7
    db $F0

Data_00E_4968:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whoa! I can feel", $F1
    db "it in my bones,", $FA, $F7
    db $EF, $EE, "this one will be", $EF, $EE, "something special.", $FA, $F7
    db $EF, $EE, "We", $42, "e got to do", $EF, $EE, "this, OK?", $F0

Data_00E_49D1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine! Let's not", $F1
    db "waste any time!", $F7
    db $F0

Data_00E_49F4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Thanks, matey!", $F1
    db "Much obliged!", $FA, $F7
    db $EF, $EE, "Hope we can do", $EF, $EE, "this again!", $F7
    db $F0

Data_00E_4A34:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0 is", $F1
    db "what you'll get.", $FA, $F7
    db $EF, $EE, "Well, do you want", $EF, $EE, "to do this?", $F0

Data_00E_4A6F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault.", $F7
    db $F0

Data_00E_4A92:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Ohhh", $A4, " That is so", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "Well, tell me if", $EF, $EE, "you reconsider.", $F7
    db $F0

Data_00E_4ADB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Which will be my", $F1
    db "FunkyBird's mate?", $F0

Data_00E_4B00:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hi, honey! Would", $F1
    db "you like to breed", $FA, $F7
    db $EF, $EE, "a monster with my", $EF, $EE, "darling FunkyBird?", $F0

Data_00E_4B4F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Is this monster", $F1
    db "OK with you?", $F0

Data_00E_4B6F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This monster is", $F1
    db "way too low-level.", $F7
    db $F0

Data_00E_4B96:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You can't be by", $F1
    db "your lonesome!", $F7
    db $F0

Data_00E_4BB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh-oh. It looks", $F1
    db "like we'll be", $FA, $F7
    db $EF, $EE, "getting something", $EF, $EE, "amazing from this.", $FA, $F7
    db $EF, $EE, "Is it all right to", $EF, $EE, "let them breed?", $F0

Data_00E_4C28:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Wonderful! Let's", $F1
    db "begin breeding!", $F7
    db $F0

Data_00E_4C4C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We might end up", $F1
    db "with different", $FA, $F7
    db $EF, $EE, "monsters, but I", $EF, $EE, "hope we both get", $FA, $F7
    db $EF, $EE, "something that'll", $EF, $EE, "make us happy.", $F7
    db $F0

Data_00E_4CB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $F9, "0", $F1
    db "will be your baby.", $FA, $F7
    db $EF, $EE, "Should we let them", $EF, $EE, "breed?", $F0

Data_00E_4CEF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Its accessory is", $F1
    db "in the Vault now.", $F7
    db $F0

Data_00E_4D16:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " May misfortune", $F1
    db "never find you.", $FA, $F7
    db $EF, $EE, "Come see me if you", $EF, $EE, "decide to breed.", $F7
    db $F0

Data_00E_4D61:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What will breed", $F1
    db "with my Copycat?", $F0

Data_00E_4D85:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Pardon me, but", $F1
    db "would you like to", $FA, $F7
    db $EF, $EE, "breed a monster", $EF, $EE, "with my Copycat?", $F0

Data_00E_4DCE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is that your", $F1
    db "breeding choice?", $F0

Data_00E_4DEF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A monster can't", $F1
    db "be too low in", $FA, $F7
    db $EF, $EE, "level if you want", $EF, $EE, "it to breed.", $F7
    db $F0

Data_00E_4E33:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll have no", $F1
    db "monsters with you.", $F7
    db $F0

Data_00E_4E58:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, well, it", $F1
    db "looks like a truly", $FA, $F7
    db $EF, $EE, "spectacular baby", $EF, $EE, "will result.", $FA, $F7
    db $EF, $EE, "Well, shall we go", $EF, $EE, "through with this?", $F0

Data_00E_4EC8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ready? Good,", $F1
    db "let's begin.", $F7
    db $F0

Data_00E_4EE5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There is an old", $F1
    db "saying", $A3, " The more", $FA, $F7
    db $EF, $EE, "you have, the less", $EF, $EE, "you need.", $FA, $F7
    db $EF, $EE, "Indeed, the more", $EF, $EE, "monsters you have,", $FA, $F7
    db $EF, $EE, "the stronger a", $EF, $EE, "master you are.", $F7
    db $F0

Data_00E_4F76:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $F1
    db "will be the", $FA, $F7
    db $EF, $EE, "progeny.", $FA, $F7
    db $EF, $EE, "Well, shall we go", $EF, $EE, "through with this?", $F0

Data_00E_4FBD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault now.", $F7
    db $F0

Data_00E_4FE4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " No? That makes", $F1
    db "me feel sad.", $FA, $F7
    db $EF, $EE, "If you reconsider,", $EF, $EE, "come back.", $F7
    db $F0

Data_00E_5026:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " What's going to", $F1
    db "be with Andreal?", $F0

Data_00E_5049:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hi! How would", $F1
    db "you like to breed", $FA, $F7
    db $EF, $EE, "a monster with my", $EF, $EE, "Andreal?", $F0

Data_00E_508B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Is this monster", $F1
    db "OK with you?", $F0

Data_00E_50AB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That one's too", $F1
    db "low-level, dear.", $F7
    db $F0

Data_00E_50CE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You can't go off", $F1
    db "all alone.", $F7
    db $F0

Data_00E_50ED:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, "You know, I", $F1
    db "think we're going", $FA, $F7
    db $EF, $EE, "to see an awesome", $EF, $EE, "baby out of this.", $FA, $F7
    db $EF, $EE, "We should let this", $EF, $EE, "pair breed.", $F0

Data_00E_5159:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Good, let's get", $F1
    db "this started.", $F7
    db $F0

Data_00E_517A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " People will be", $F1
    db "jealous when they", $FA, $F7
    db $EF, $EE, "find out I got to", $EF, $EE, "breed monsters", $FA, $F7
    db $EF, $EE, "with a famous", $EF, $EE, "master like you.", $FA, $F7
    db $EF, $EE, "Let me give you a", $EF, $EE, "little kiss!", $F7
    db $F0

Data_00E_520A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $F9, "0", $F1
    db "will be your baby.", $FA, $F7
    db $EF, $EE, "Is it OK to let", $EF, $EE, "them breed?", $F0

Data_00E_5243:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Its accessory is", $F1
    db "now in the Vault.", $F7
    db $F0

Data_00E_526A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whaaat?", $F1
    db "You're serious?", $FA, $F7
    db $EF, $EE, "Well, maybe we'll", $EF, $EE, "meet again.", $F7
    db $F0

Data_00E_52A6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What'll you pair", $F1
    db "with my Skeletor?", $F0

Data_00E_52CB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, kid.", $F1
    db "Want to breed a", $FA, $F7
    db $EF, $EE, "monster of yours", $EF, $EE, "with my Skeletor?", $F0

Data_00E_530F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is that what", $F1
    db "you're picking?", $F0

Data_00E_532E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No, no. Nothing", $F1
    db "low in level.", $F7
    db $F0

Data_00E_5350:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll be without", $F1
    db "a monster.", $F7
    db $F0

; ld de, this bank's string table / BeginStringDisplay
; 4 call sites from 4 routines (e.g. ShowString_Bank0E, DebugMessageTest_Update_Case1D, ShowStringIndexA_Bank37, BeginString_Bank0E_Cat0)
BeginStringDisplay_Bank0E::
Func_00E_5370:: ; address name
    ld de, StringCategories_0E_5385
    call BeginStringDisplay
    ret
    db $11, $85, $53, $CD, $FE, $25, $C9

; Func_00E_5370 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 6 call sites from 6 routines (e.g. Func_037_4AFD_Case04_Case16, Func_037_4AFD_Case0E_Case08, RunScreenStateWhenNotFading_F1_Case04_Case16, RunScreenStateWhenNotFading_F1_Case0E_Case08, ...)
ShowString_Bank0E::
Func_00E_537E:: ; address name
    call BeginStringDisplay_Bank0E
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_0E_5385::
Data_00E_5385:: ; address name
    dw StringList_0E_5387 ; id 0

; E-0217 (derived: category list of StringCategories_0E_5385; one pointer per wStringIndex)
; record: string
StringList_0E_5387::
Data_00E_5387:: ; address name
    dw Data_00E_53B5 ; id 0
    dw Data_00E_53B5 ; id 1
    dw Data_00E_53D0 ; id 2
    dw Data_00E_53E8 ; id 3
    dw Data_00E_5405 ; id 4
    dw Data_00E_5422 ; id 5
    dw Data_00E_5468 ; id 6
    dw Data_00E_5488 ; id 7
    dw Data_00E_5495 ; id 8
    dw Data_00E_54B5 ; id 9
    dw Data_00E_54D6 ; id 10
    dw Data_00E_54F4 ; id 11
    dw Data_00E_550B ; id 12
    dw Data_00E_552B ; id 13
    dw Data_00E_5567 ; id 14
    dw Data_00E_556E ; id 15
    dw Data_00E_557B ; id 16
    dw Data_00E_559A ; id 17
    dw Data_00E_55D7 ; id 18
    dw Data_00E_560D ; id 19
    dw Data_00E_5623 ; id 20
    dw Data_00E_563E ; id 21
    dw Data_00E_5662 ; id 22

Data_00E_53B5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ready to start", $F1
    db "breeding.", $FA, $F7
    db $F0

Data_00E_53D0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused", $F1
    db "breeding.", $FA, $F7
    db $F0

Data_00E_53E8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "breeding.", $FA, $F7
    db $F0

Data_00E_5405:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is this one OK for", $F1
    db "breeding?", $F0

Data_00E_5422:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "This one is too", $F1
    db "young to breed.", $FA, $F7
    db $EF, $EE, "It needs to be", $EF, $EE, "leveled up more.", $FA, $F7
    db $F0

Data_00E_5468:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose from the", $F1
    db "farm's roster.", $FA, $F7
    db $F0

Data_00E_5488:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

Data_00E_5495:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Identical genders", $F1
    db "can't breed.", $FA, $F7
    db $F0

Data_00E_54B5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose the monster", $F1
    db "for breeding.", $F0

Data_00E_54D6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The couple is", $F1
    db "incompatible.", $FA, $F7
    db $F0

Data_00E_54F4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Proceed with", $F1
    db "breeding?", $F0

Data_00E_550B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to record", $F1
    db "the results?", $F0

Data_00E_552B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The monsters like", $F1
    db "each other.", $FA, $F7
    db $EF, $EE, "Breeding will be", $EF, $EE, "started.", $F0

Data_00E_5567:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOK", $F0

Data_00E_556E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BredInfoExit", $F0

Data_00E_557B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ATKDEFGLINWMextvlBas        ", $A2, " ", $F0

Data_00E_559A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breeding went", $F1
    db "wrong somehow.", $FA, $F7
    db $EF, $EE, "Breeding will be", $EF, $EE, "canceled.", $F7
    db $F0

Data_00E_55D7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Game Link", $F1
    db "failed.", $FA, $F7
    db $EF, $EE, "Breeding will be", $EF, $EE, "canceled.", $F7
    db $F0

Data_00E_560D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused", $F1
    db "breeding.", $F0

Data_00E_5623:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "breeding.", $F0

Data_00E_563E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "For breeding with", $F1
    db "Terry's monsters.", $F7
    db $F0

Data_00E_5662:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Accessories will", $F1
    db "be in the Vault.", $F7
    db $F0

; clears the child record wCAD0 and fills it from the two parents (wC991, wCA36): species from the breeding table Data_00E_6208, then names, skills, resistances and stat bonuses (E-0131)
; 6 call sites from 6 routines (e.g. DebugResultsDisplay_Update_Sub02_Sub01, RunLinkScreenState_6C12_Case08_Case04_Sub01, NpcBreedMenu_Case04_Case14, BreedMenu_Case04_Case1C, ...)
; reads: wArg6, wArg7, wArg5, wSaveByte16, wArg1, wSpeciesRecord, wNameEntryState
; writes: wArg6, wArg7, wSpeciesIdLo, wSpeciesIdHi, wNameEntryState, wArg5
; points at: wChildRecord, wRecordBufA, wRecordBufB
ComputeBreedingChild::
Func_00E_5688:: ; address name
    ld hl, wChildRecord
    ld b, $A5

Jump_00E_568D::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00E_568D
    ld hl, wRecordBufA + $B
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedSpeciesRuleTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + $B
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld c, $00

Jump_00E_56AE::
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_570D
    cp a, $FE
    jr z, Jump_00E_56E2
    cp a, $FD
    jr z, Jump_00E_5705
    cp a, $FC
    jr z, Jump_00E_56DA
    cp a, $FB
    jr z, Jump_00E_56D1
    dec hl
    push hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_00E_5708
    ld a, [hl]
    cp a, d
    jr nz, Jump_00E_5708
    jp Jump_00E_5710

Jump_00E_56D1::
    ld a, [wArg1]
    cp a, $02
    jr nz, Jump_00E_570D
    jr Jump_00E_5705

Jump_00E_56DA::
    dec hl
    push hl
    ld b, [hl]
    ld hl, wRecordBufA + $6D
    jr Jump_00E_56E8

Jump_00E_56E2::
    dec hl
    push hl
    ld b, [hl]
    ld hl, wRecordBufB + $6D

Jump_00E_56E8::
    ld a, [hl]
    cp a, b
    jp nc, Jump_00E_56EF
    jr Jump_00E_5708

Jump_00E_56EF::
    ld a, [wRecordBufA + $B]
    ld l, a
    ld a, [wRecordBufA + $C]
    ld h, a
    ld a, [wRecordBufB + $B]
    cp a, l
    jr nz, Jump_00E_5708
    ld a, [wRecordBufB + $C]
    cp a, h
    jr nz, Jump_00E_5708
    jr Jump_00E_5710

Jump_00E_5705::
    dec hl
    push hl
    inc c

Jump_00E_5708::
    pop hl
    inc hl
    inc hl
    jr Jump_00E_56AE

Jump_00E_570D::
    jp Jump_00E_5737

Jump_00E_5710::
    pop hl
    push bc
    ld hl, wRecordBufA + $B
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedSpeciesResultTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp Jump_00E_5862

Jump_00E_5737::
    ld hl, wRecordBufA + $B
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedFamilyRuleTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + $D
    ld a, [hl]
    and a, $0F
    ld e, a
    pop hl
    ld c, $00

Jump_00E_5754::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5777
    cp a, $FE
    jr z, Jump_00E_575F
    jr Jump_00E_576A

Jump_00E_575F::
    ld a, [wArg1]
    cp a, $02
    jr nz, Jump_00E_5777
    inc hl
    inc c
    jr Jump_00E_5754

Jump_00E_576A::
    push hl
    ld a, [hl]
    cp a, e
    jr nz, Jump_00E_5772
    jp Jump_00E_577A

Jump_00E_5772::
    pop hl
    inc hl
    inc c
    jr Jump_00E_5754

Jump_00E_5777::
    jp Jump_00E_57A1

Jump_00E_577A::
    pop hl
    push bc
    ld hl, wRecordBufA + $B
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, BreedFamilyResultTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp Jump_00E_5862

Jump_00E_57A1::
    ld hl, wRecordBufA + $D
    ld a, [hl]
    and a, $0F
    add a, a
    ld hl, FamilyBreedRuleTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + $B
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld c, $00

Jump_00E_57BE::
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_57DD
    cp a, $FD
    jr z, Jump_00E_57D5
    dec hl
    push hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_00E_57D8
    ld a, [hl]
    cp a, d
    jr nz, Jump_00E_57D8
    jp Jump_00E_57E0

Jump_00E_57D5::
    dec hl
    push hl
    inc c

Jump_00E_57D8::
    pop hl
    inc hl
    inc hl
    jr Jump_00E_57BE

Jump_00E_57DD::
    jp Jump_00E_5808

Jump_00E_57E0::
    pop hl
    push bc
    ld hl, wRecordBufA + $D
    ld a, [hl]
    and a, $0F
    add a, a
    ld hl, FamilyBreedResultTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp Jump_00E_5862

Jump_00E_5808::
    ld hl, wRecordBufA + $D
    ld a, [hl]
    and a, $0F
    add a, a
    ld hl, FamilyPairResultTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, wRecordBufB + $D
    ld a, [hl]
    and a, $0F
    pop hl
    add a, a
    add_a_to_hl
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5854
    cp a, $FE
    jr z, Jump_00E_583F
    dec hl
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp Jump_00E_5862

Jump_00E_583F::
    ld a, $FF
    ld [wArg6], a
    ld a, $FF
    ld [wArg7], a
    ld a, $06
    ld [wNameEntryState], a
    ld a, $FF
    ld [wArg5], a
    ret

Jump_00E_5854::
    ld hl, wRecordBufA + $B
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    jp Jump_00E_5862

Jump_00E_5862::
    ld hl, wChildRecord + $B
    ld a, [wArg6]
    ld [hl+], a
    ld a, [wArg7]
    ld [hl], a
    ld hl, wRecordBufA + $E
    ld a, [hl]
    and a, $01
    swap a
    ld b, a
    push bc
    call FamilyForSpeciesIdArg6
    ld a, [wArg5]
    pop bc
    or a, b
    ld b, a
    ld hl, wChildRecord + $D
    ld [hl], b
    xor a, a
    ld hl, wChildRecord + $55
    ld [hl], a
    ld hl, wChildRecord + $A4
    ld [hl], a
    ld hl, wChildRecord + $58
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wSaveByte16]
    ld hl, wChildRecord + $19
    ld [hl], a
    ld a, $01
    ld hl, wChildRecord + $56
    ld [hl], a
    ld hl, wChildRecord
    ld [hl], a
    ld hl, wChildRecord + $6E
    ld [hl], a
    call CopyFourNamesByWCADDBit4Table
    call CopyPlayerNameToWCADF
    call CopySixBytesByWCADDBit4Table
    ld hl, wRecordBufA
    ld de, wRecordBufB
    ld c, $00
    ld b, $08

Jump_00E_58BB::
    push hl
    ld a, c
    ld hl, Data_00E_6200
    add_a_to_hl
    ld a, [hl]
    pop hl
    push hl
    add_a_to_hl
    push de
    ld a, c
    ld de, Data_00E_6200
    add a, e
    ld e, a
    jr nc, Jump_00E_58D7
    inc d

Jump_00E_58D7::
    ld a, [de]
    pop de
    push de
    add a, e
    ld e, a
    jr nc, Jump_00E_58DF
    inc d

Jump_00E_58DF::
    push bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld e, c
    ld d, b
    pop bc
    push bc
    call AdjustStatForWCA2AAndWCACF
    add hl, de
    srl h
    rr l
    srl h
    rr l
    pop bc
    push bc
    ld de, wChildRecord + $5B
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_00E_5904
    inc d

Jump_00E_5904::
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    pop bc
    pop de
    pop hl
    inc c
    dec b
    jr nz, Jump_00E_58BB
    ld a, $6F
    add_a_to_hl
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_00E_591E
    inc d

Jump_00E_591E::
    ld c, $00
    ld b, $04

Jump_00E_5922::
    push hl
    push de
    push bc
    ld b, [hl]
    ld a, [de]
    add a, b
    srl a
    ld e, a
    pop bc
    push bc
    ld hl, wChildRecord + $6F
    ld a, c
    add_a_to_hl
    ld [hl], e
    pop bc
    pop de
    pop hl
    inc hl
    inc de
    inc c
    dec b
    jr nz, Jump_00E_5922
    ld hl, wRecordBufA + $6D
    ld de, wRecordBufB + $6D
    ld a, [wArg1]
    and a, a
    jr z, Jump_00E_594F
    ld a, [hl]
    jr Jump_00E_5955

Jump_00E_594F::
    ld b, [hl]
    ld a, [de]
    cp a, b
    jr nc, Jump_00E_5955
    ld a, [hl]

Jump_00E_5955::
    ld b, a
    push bc
    ld hl, wRecordBufA + $56
    ld de, wRecordBufB + $56
    ld b, [hl]
    ld a, [de]
    add a, b
    cp a, $64
    jr nc, Jump_00E_5974
    cp a, $4C
    jr nc, Jump_00E_5978
    cp a, $3C
    jr nc, Jump_00E_597C
    cp a, $28
    jr nc, Jump_00E_5980
    ld b, $01
    jr Jump_00E_5982

Jump_00E_5974::
    ld b, $05
    jr Jump_00E_5982

Jump_00E_5978::
    ld b, $04
    jr Jump_00E_5982

Jump_00E_597C::
    ld b, $03
    jr Jump_00E_5982

Jump_00E_5980::
    ld b, $02

Jump_00E_5982::
    ld a, b
    pop bc
    add a, b
    cp a, $64
    jr c, Jump_00E_598B
    ld a, $63

Jump_00E_598B::
    ld hl, wChildRecord + $6D
    ld [hl], a
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $6]
    ld b, a
    push bc
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ld c, $03
    call Multiply8
    pop bc
    ld a, b
    add_a_to_hl
    ld a, h
    and a, a
    jr z, Jump_00E_59BD
    ld a, $63
    jr Jump_00E_59C4

Jump_00E_59BD::
    ld a, l
    cp a, $64
    jr c, Jump_00E_59C4
    ld a, $63

Jump_00E_59C4::
    ld hl, wChildRecord + $57
    ld [hl], a
    call RollWCADEFromSpeciesFlag
    call ApplyBreedingBonusToChildStats
    call RollChildResistancesToWCB43
    call BuildWCB0CCandidateList
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    ld a, $FF
    ld [wArg5], a
    ret

; when wCA2A or wCACF is set and listed for stat C (Data_00E_5A6B), subtracts Data_00E_5A8E[value] from DE (unless it is at 999) (E-0130)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
; reads: wRecordBufA, wRecordBufB
AdjustStatForWCA2AAndWCACF::
Func_00E_59E1:: ; address name
    ld a, [wRecordBufA + $A4]
    and a, a
    jr z, Jump_00E_5A25
    ld b, a
    push hl
    ld a, c
    add a, a
    ld hl, Data_00E_5A6B
    add_a_to_hl
    push de
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_00E_59F7::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00E_5A02
    cp a, b
    jr z, Jump_00E_5A05
    inc de
    jr Jump_00E_59F7

Jump_00E_5A02::
    pop de
    jr Jump_00E_5A24

Jump_00E_5A05::
    pop de
    ld a, d
    cp a, $03
    jr c, Jump_00E_5A12
    ld a, e
    cp a, $E7
    jr c, Jump_00E_5A12
    jr Jump_00E_5A24

Jump_00E_5A12::
    ld a, b
    ld hl, Data_00E_5A8E
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld a, e
    sub a, b
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a

Jump_00E_5A24::
    pop hl

Jump_00E_5A25::
    ld a, [wRecordBufB + $A4]
    and a, a
    ret z
    ld b, a
    push de
    ld a, c
    add a, a
    ld de, Data_00E_5A6B
    add a, e
    ld e, a
    jr nc, Jump_00E_5A36
    inc d

Jump_00E_5A36::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a

Jump_00E_5A3C::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5A47
    cp a, b
    jr z, Jump_00E_5A4A
    inc hl
    jr Jump_00E_5A3C

Jump_00E_5A47::
    pop hl
    jr Jump_00E_5A69

Jump_00E_5A4A::
    pop hl
    ld a, h
    cp a, $03
    jr c, Jump_00E_5A57
    ld a, l
    cp a, $E7
    jr c, Jump_00E_5A57
    jr Jump_00E_5A69

Jump_00E_5A57::
    ld a, b
    ld de, Data_00E_5A8E
    add a, e
    ld e, a
    jr nc, Jump_00E_5A60
    inc d

Jump_00E_5A60::
    ld a, [de]
    ld b, a
    ld a, l
    sub a, b
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_00E_5A69::
    pop de
    ret

; address loaded by AdjustStatForWCA2AAndWCACF
Data_00E_5A6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_5A7B
    dw Data_00E_5A7B
    dw Data_00E_5A7E
    dw Data_00E_5A7E
    dw Data_00E_5A81
    dw Data_00E_5A84
    dw Data_00E_5A88
    dw Data_00E_5A8B

Data_00E_5A7B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $FF

Data_00E_5A7E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $04, $FF

Data_00E_5A81:: ; heuristic: target of a monotone pointer table; C0
    db $05, $06, $FF

Data_00E_5A84:: ; heuristic: target of a monotone pointer table; C0
    db $07, $08, $14, $FF

Data_00E_5A88:: ; heuristic: target of a monotone pointer table; C0
    db $09, $0A, $FF

Data_00E_5A8B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $0C, $FF

; address loaded by AdjustStatForWCA2AAndWCACF
Data_00E_5A8E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $1E, $50, $1E, $50, $0A, $32, $0A, $32, $0A, $32, $32, $64, $00, $00, $00
    db $00, $00, $00, $00, $05, $00

; fills wCB04 with $FF, appends species bytes 8-10 of wCADB, wC991 and wCA36 and eight bytes each from wC9BA and wCA5F to wCB0C, maps them through Data_00E_5B03 and compacts the list (E-0124)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
BuildWCB0CCandidateList::
Func_00E_5AA4:: ; address name
    ld hl, wChildRecord + $34
    ld c, $08

Jump_00E_5AA9::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_00E_5AA9
    ld hl, wChildRecord + $B
    call LoadSpeciesBytes8To10FromHL
    ld hl, wChildRecord + $3C
    call StoreBCAAtHL
    push hl
    ld hl, wRecordBufA + $B
    call LoadSpeciesBytes8To10FromHL
    pop hl
    call StoreBCAAtHL
    push hl
    ld hl, wRecordBufB + $B
    call LoadSpeciesBytes8To10FromHL
    pop hl
    call StoreBCAAtHL
    ld de, wRecordBufA + $34
    call CopyEightBytesDEToHL
    ld de, wRecordBufB + $34
    call CopyEightBytesDEToHL
    call MapWCB0CEntriesThroughTable5B03
    call BuildWCB0CCandidateList_Sub01
    call CompactWCB0CRemovingFF
    call BuildWCB0CCandidateList_Sub01
    ret

; replaces each of the $19 bytes at wCB0C (other than $FF) by Data_00E_5B03[byte] (E-0124)
; 1 call site from 1 routine (e.g. BuildWCB0CCandidateList)
MapWCB0CEntriesThroughTable5B03::
Func_00E_5AEA:: ; address name
    ld hl, wChildRecord + $3C
    ld c, $19

Jump_00E_5AEF::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5AFE
    ld de, SkillLineBaseTable
    add a, e
    ld e, a
    jr nc, Jump_00E_5AFC
    inc d

Jump_00E_5AFC::
    ld a, [de]
    ld [hl], a

Jump_00E_5AFE::
    inc hl
    dec c
    jr nz, Jump_00E_5AEF
    ret

; E-0200 (C1: MapWCB0CEntriesThroughTable5B03 replaces each of the $19 skill bytes at wChildRecord + $3C (other than $FF) by the byte at $5B03 + skill; the values never exceed the index and repeat for runs of related skills (for example 1-3 map to 1, 4-6 to 4), so the table maps a skill to the first of its line; 176 entries, skills 0-$AF).
; record: replacement skill numbers for skills $X0-$XF (X = id)
SkillLineBaseTable::
Data_00E_5B03:: ; address name
    db $00, $01, $01, $01, $04, $04, $04, $07, $07, $07, $0A, $0A, $0A, $0D, $0D, $0D ; id 0
    db $10, $10, $10, $13, $13, $15, $16, $16, $16, $19, $19, $1B, $1B, $1B, $1E, $1E ; id 1
    db $20, $21, $22, $23, $24, $25, $25, $27, $27, $29, $29, $2B, $2B, $2D, $2E, $2F ; id 2
    db $2F, $31, $32, $33, $34, $35, $36, $36, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F ; id 3
    db $40, $40, $40, $40, $44, $44, $44, $44, $48, $48, $4A, $4B, $4C, $4C, $4E, $4E ; id 4
    db $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F ; id 5
    db $60, $61, $62, $63, $63, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F ; id 6
    db $70, $71, $72, $73, $73, $75, $76, $76, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F ; id 7
    db $80, $81, $82, $83, $84, $85, $85, $85, $85, $89, $8A, $8B, $8B, $8D, $8D, $8F ; id 8
    db $90, $91, $92, $93, $94, $95, $96, $97, $97, $99, $99, $9B, $9C, $9D, $9E, $9F ; id 9
    db $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF ; id 10

; moves the non-$FF bytes of the $19-byte list at wCB0C to its front (E-0124)
; 1 call site from 1 routine (e.g. BuildWCB0CCandidateList)
CompactWCB0CRemovingFF::
Func_00E_5BB3:: ; address name
    ld hl, wChildRecord + $3C
    ld de, wChildRecord + $3C
    ld c, $19

Jump_00E_5BBB::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_00E_5BC5
    inc hl
    dec c
    jr nz, Jump_00E_5BBB
    ret

Jump_00E_5BC5::
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, Jump_00E_5BBB
    ret

; only called from BuildWCB0CCandidateList (E-0047)
; 2 call sites from 1 routine (e.g. BuildWCB0CCandidateList)
BuildWCB0CCandidateList_Sub01::
Func_00E_5BCC:: ; address name
    ld hl, wChildRecord + $3C
    ld c, $00

Jump_00E_5BD1::
    ld a, [hl]
    and a, a
    jr z, Jump_00E_5BDB
    cp a, $FF
    jr z, Jump_00E_5BDB
    jr Jump_00E_5BE0

Jump_00E_5BDB::
    ld a, $FF
    ld [hl], a
    jr Jump_00E_5BF8

Jump_00E_5BE0::
    ld b, a
    push hl
    ld a, c
    cp a, $19
    jr z, Jump_00E_5BF7
    ld e, a
    inc hl

Jump_00E_5BE9::
    ld a, [hl]
    cp a, b
    jr nz, Jump_00E_5BF0
    ld a, $FF
    ld [hl], a

Jump_00E_5BF0::
    inc hl
    inc e
    ld a, e
    cp a, $19
    jr c, Jump_00E_5BE9

Jump_00E_5BF7::
    pop hl

Jump_00E_5BF8::
    inc hl
    inc c
    ld a, c
    cp a, $19
    jr c, Jump_00E_5BD1
    ret

; copies 8 bytes from DE to HL (E-0122)
; 2 call sites from 1 routine (e.g. BuildWCB0CCandidateList)
CopyEightBytesDEToHL::
Func_00E_5C00:: ; address name
    ld c, $08

Jump_00E_5C02::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_00E_5C02
    ret

; stores B, C and A at HL onward; HL += 3; AF kept (E-0114)
; 3 call sites from 1 routine (e.g. BuildWCB0CCandidateList)
StoreBCAAtHL::
Func_00E_5C09:: ; address name
    push af
    ld a, b
    ld [hl+], a
    ld a, c
    ld [hl+], a
    pop af
    ld [hl+], a
    ret

; monster id = the word at HL: LoadSpeciesRecord, then B = species byte 8, C = byte 9, A = byte 10 (wD010-wD012) (E-0117)
; 3 call sites from 1 routine (e.g. BuildWCB0CCandidateList)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
LoadSpeciesBytes8To10FromHL::
Func_00E_5C11:: ; address name
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $8]
    ld b, a
    ld a, [wSpeciesRecord + $9]
    ld c, a
    ld a, [wSpeciesRecord + $A]
    ret

; monster id = wD7F1/wD7F2: LoadSpeciesRecord, then copies species bytes 8-10 to wD7F5-wD7F7 (E-0117)
; 1 call site from 1 routine (e.g. LibraryMenu_Case10_Case04)
; reads: wArg1, wArg2, wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi, wArg5, wArg6, wArg7
LoadSpeciesBytes8To10ToArg5::
Func_00E_5C2B:: ; address name
    ld a, [wArg1]
    ld [wSpeciesIdLo], a
    ld a, [wArg2]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $8]
    ld [wArg5], a
    ld a, [wSpeciesRecord + $9]
    ld [wArg6], a
    ld a, [wSpeciesRecord + $A]
    ld [wArg7], a
    ret

; for each of the 30 SRAM records stores the 27 two-bit resistance levels of its species at record + $73 (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
; writes: rRAMG2, rRAMB, wArg2, wSpeciesIdLo, wArg3, wSpeciesIdHi, wArg4, rRAMG
; points at: sRecords
RefreshRecordResistancesFromSpecies:: ; heuristic: follows a terminator; C0
Func_00E_5C50:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $1E

Jump_00E_5C5E::
    push hl
    push bc
    ld a, [hl]
    and a, a
    jr z, Jump_00E_5CA1
    push hl
    ld a, $0B
    add_a_to_hl
    ld a, [hl+]
    ld [wArg2], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wArg3], a
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    pop hl
    ld a, $73
    add_a_to_hl
    ld b, $1B
    ld c, $00

Jump_00E_5C8C::
    push hl
    push bc
    ld a, c
    ld [wArg4], a
    call LoadWD01AByteArg4
    ld a, [wArg5]
    pop bc
    pop hl
    and a, $03
    ld [hl+], a
    inc c
    dec b
    jr nz, Jump_00E_5C8C

Jump_00E_5CA1::
    pop bc
    pop hl
    ld a, $A5
    add_a_to_hl
    dec c
    jr nz, Jump_00E_5C5E
    xor a, a
    ld [rRAMG], a
    ret

; for each of the 27 resistances of species wCADB: levels below 3 may rise by the parent rolls (RollWCB3DForCaseB_5D16 or 5D77); stores the result at wCB43 (E-0127)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
; reads: wArg5
; writes: wArg2, wSpeciesIdLo, wArg3, wSpeciesIdHi, wArg4
RollChildResistancesToWCB43::
Func_00E_5CB2:: ; address name
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wArg2], a
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wArg3], a
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld b, $1B
    ld c, $00

Jump_00E_5CCD::
    push bc
    ld a, c
    ld [wArg4], a
    call LoadWD01AByteArg4
    ld a, [wArg5]
    cp a, $03
    jr nc, Jump_00E_5D01
    pop bc
    push bc
    ld a, [wArg5]
    cp a, $02
    jr z, Jump_00E_5CF4
    ld b, $03
    call SumFunc5DCDOfWC9F9AndWCA9E
    ld a, b
    cp a, $FF
    jr z, Jump_00E_5D01
    call RollWCB3DForCaseB_5D16
    jr Jump_00E_5D01

Jump_00E_5CF4::
    ld b, $05
    call SumFunc5DCDOfWC9F9AndWCA9E
    ld a, b
    cp a, $FF
    jr z, Jump_00E_5D01
    call RollWCB3DForCaseB_5D77

Jump_00E_5D01::
    pop bc
    ld de, wChildRecord + $73
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00E_5D0B
    inc d

Jump_00E_5D0B::
    ld a, [wArg5]
    and a, $03
    ld [de], a
    inc c
    dec b
    jr nz, Jump_00E_5CCD
    ret

; when wCB3D is set rolls RollWCB3DChanceOrIncArg5 with factor 1, 3 or 10 (then 3) for B = 3, 4, 5, or 5 after counting otherwise (E-0125)
; 1 call site from 1 routine (e.g. RollChildResistancesToWCB43)
; reads: wArg5
; writes: wArg5
RollWCB3DForCaseB_5D16::
Func_00E_5D16:: ; address name
    push bc
    ld hl, wChildRecord + $6D
    ld a, [hl]
    and a, a
    jr nz, Jump_00E_5D20
    pop bc
    ret

Jump_00E_5D20::
    ld a, b
    cp a, $03
    jr z, Jump_00E_5D3B
    cp a, $04
    jr z, Jump_00E_5D3F
    cp a, $05
    jr z, Jump_00E_5D43
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    ld a, $05

Jump_00E_5D36::
    call RollWCB3DChanceOrIncArg5

Jump_00E_5D39::
    pop bc
    ret

Jump_00E_5D3B::
    ld a, $01
    jr Jump_00E_5D36

Jump_00E_5D3F::
    ld a, $03
    jr Jump_00E_5D36

Jump_00E_5D43::
    ld a, $0A
    call RollWCB3DChanceOrIncArg5
    cp a, $FF
    jr z, Jump_00E_5D39
    jr Jump_00E_5D3F

; chance = A * wCB3D; if below 100 and a random value is below it, A = $FF; otherwise wD7F5 += 1 and A = 0 (E-0124)
; 3 call sites from 2 routines (e.g. RollWCB3DForCaseB_5D16, RollWCB3DForCaseB_5D77)
; reads: wArg5
; writes: wArg5
RollWCB3DChanceOrIncArg5::
Func_00E_5D4E:: ; address name
    ld c, a
    ld hl, wChildRecord + $6D
    ld a, [hl]
    call Multiply8
    ld a, h
    and a, a
    jr nz, Jump_00E_5D6E
    ld a, l
    cp a, $64
    jr nc, Jump_00E_5D6E
    push af
    push bc
    ld b, $0F
    call RandomModulo29
    pop bc
    pop af
    cp a, l
    jr nc, Jump_00E_5D6E
    ld a, $FF
    ret

Jump_00E_5D6E::
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    xor a, a
    ret

; when wCB3D is set: B = 5 rolls a random value against wCB3D (A = $FF on success), other values roll factor 2 (E-0125)
; 1 call site from 1 routine (e.g. RollChildResistancesToWCB43)
; reads: wArg5
; writes: wArg5
RollWCB3DForCaseB_5D77::
Func_00E_5D77:: ; address name
    push bc
    ld hl, wChildRecord + $6D
    ld a, [hl]
    and a, a
    jr nz, Jump_00E_5D81

Jump_00E_5D7F::
    pop bc
    ret

Jump_00E_5D81::
    ld a, b
    cp a, $05
    jr z, Jump_00E_5D8D
    ld a, $02
    call RollWCB3DChanceOrIncArg5
    pop bc
    ret

Jump_00E_5D8D::
    ld hl, wChildRecord + $6D
    cp a, $01
    jr z, Jump_00E_5D7F
    ld a, [hl]
    push af
    push bc
    ld b, $1F
    call RandomModulo29
    pop bc
    pop af
    cp a, l
    jr nc, Jump_00E_5DA5
    ld a, $FF
    pop bc
    ret

Jump_00E_5DA5::
    ld a, [wArg5]
    inc a
    ld [wArg5], a
    xor a, a
    pop bc
    ret

; B = Func_00E_5DCD(wC9F9) + Func_00E_5DCD(wCA9E) when both are valid and the sum is at least B; otherwise B = $FF (E-0124)
; 2 call sites from 1 routine (e.g. RollChildResistancesToWCB43)
SumFunc5DCDOfWC9F9AndWCA9E::
Func_00E_5DAF:: ; address name
    ld hl, wRecordBufA + $73
    call SumFunc5DCDOfWC9F9AndWCA9E_Sub01
    cp a, $FF
    jr z, Jump_00E_5DCA
    ld e, a
    ld hl, wRecordBufB + $73
    call SumFunc5DCDOfWC9F9AndWCA9E_Sub01
    cp a, $FF
    jr z, Jump_00E_5DCA
    add a, e
    cp a, b
    jr c, Jump_00E_5DCA
    ld b, a
    ret

Jump_00E_5DCA::
    ld b, $FF
    ret

; only called from SumFunc5DCDOfWC9F9AndWCA9E (E-0047)
; 2 call sites from 1 routine (e.g. SumFunc5DCDOfWC9F9AndWCA9E)
SumFunc5DCDOfWC9F9AndWCA9E_Sub01::
Func_00E_5DCD:: ; address name
    push hl
    ld a, c
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr z, Jump_00E_5DDB

Jump_00E_5DD9::
    pop hl
    ret

Jump_00E_5DDB::
    pop hl
    push hl
    push af
    ld a, $31
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_00E_5DFF
    cp a, $1C
    jr nc, Jump_00E_5DFF
    dec a
    ld hl, Data_00E_5E02
    add_a_to_hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_00E_5DFF
    pop af
    pop hl
    ld a, $FF
    ret

Jump_00E_5DFF::
    pop af
    jr Jump_00E_5DD9

; address loaded by SumFunc5DCDOfWC9F9AndWCA9E_Sub01
Data_00E_5E02:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $0E, $0F, $07, $10, $11, $12, $13, $14, $08
    db $09, $0A, $0B, $15, $16, $17, $18, $19, $1A, $0C, $0D

; wD7F5 = the byte at wD01A + wD7F4 (E-0114)
; 3 call sites from 3 routines (e.g. RollChildResistancesToWCB43, RefreshRecordResistancesFromSpecies, CopyWD01ABytesFromIndexCToDE)
; reads: wArg4
; writes: wArg5
LoadWD01AByteArg4::
Func_00E_5E1D:: ; address name
    ld hl, wSpeciesRecord + $12
    ld a, [wArg4]
    add_a_to_hl
    ld a, [hl]
    ld [wArg5], a
    ret

; copies six bytes from the addresses in Data_00E_5E61 (or 5E6D when bit 4 of wCADD is set) to the addresses in Data_00E_5E79 (E-0125)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
CopySixBytesByWCADDBit4Table::
Func_00E_5E2D:: ; address name
    ld hl, wChildRecord + $D
    ld a, [hl]
    and a, $10
    and a, a
    jr nz, Jump_00E_5E3B
    ld de, Data_00E_5E61
    jr Jump_00E_5E3E

Jump_00E_5E3B::
    ld de, Data_00E_5E6D

Jump_00E_5E3E::
    ld c, $00
    ld b, $06

Jump_00E_5E42::
    push de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    ld a, c
    add a, a
    ld hl, Data_00E_5E79
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc de
    inc c
    dec b
    jr nz, Jump_00E_5E42
    ret

; address loaded by CopySixBytesByWCADDBit4Table
Data_00E_5E61:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $91, $C9, $92, $C9, $36, $CA, $37, $CA, $F3, $C9, $98, $CA

; address loaded by CopySixBytesByWCADDBit4Table
Data_00E_5E6D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $36, $CA, $37, $CA, $91, $C9, $92, $C9, $98, $CA, $F3, $C9

; address loaded by CopySixBytesByWCADDBit4Table
Data_00E_5E79:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EA, $CA, $EB, $CA, $EC, $CA, $ED, $CA, $68, $CB, $73, $CB

; copies the 10-byte player name wC60C to wCADF (E-0122)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
; points at: wPlayerName
CopyPlayerNameToWCADF::
Func_00E_5E85:: ; address name
    ld hl, wPlayerName
    ld de, wChildRecord + $F
    ld c, $0A

Jump_00E_5E8D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_00E_5E8D
    ret

; copies four 10-byte names from the addresses in Data_00E_5ED0 (or 5ED8 with bit 4 of wCADD) to the addresses in Data_00E_5EE0 (E-0125)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
CopyFourNamesByWCADDBit4Table::
Func_00E_5E94:: ; address name
    ld hl, wChildRecord + $D
    ld a, [hl]
    and a, $10
    and a, a
    jr nz, Jump_00E_5EA2
    ld de, Data_00E_5ED0
    jr Jump_00E_5EA5

Jump_00E_5EA2::
    ld de, Data_00E_5ED8

Jump_00E_5EA5::
    ld c, $00
    ld b, $04

Jump_00E_5EA9::
    push de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    ld hl, Data_00E_5EE0
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    push bc
    ld b, $0A

Jump_00E_5EC1::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00E_5EC1
    pop bc
    pop de
    inc de
    inc de
    inc c
    dec b
    jr nz, Jump_00E_5EA9
    ret

; address loaded by CopyFourNamesByWCADDBit4Table
Data_00E_5ED0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $87, $C9, $2C, $CA, $95, $C9, $3A, $CA

; address loaded by CopyFourNamesByWCADDBit4Table
Data_00E_5ED8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2C, $CA, $87, $C9, $3A, $CA, $95, $C9

; address loaded by CopyFourNamesByWCADDBit4Table
Data_00E_5EE0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5E, $CB, $69, $CB, $EE, $CA, $F9, $CA

; computes a bonus from personality compatibility, matching parent fields and wD7F1, and adds it to the child stats at wCAD0 (offsets Data_00E_5F89) (E-0130)
; 1 call site from 1 routine (e.g. ComputeBreedingChild)
; reads: wArg5, wArg1
; points at: wChildRecord
ApplyBreedingBonusToChildStats::
Func_00E_5EE8:: ; address name
    call PersonalityPairValueToArg5
    ld c, $00
    ld a, [wArg5]
    and a, a
    jr nz, Jump_00E_5EF7
    ld a, c
    add a, $05
    ld c, a

Jump_00E_5EF7::
    ld hl, wRecordBufA + $57
    ld a, [hl-]
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_00E_5F0D
    ld hl, wRecordBufB + $57
    ld a, [hl-]
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_00E_5F0D
    ld a, c
    add a, $05
    ld c, a

Jump_00E_5F0D::
    ld hl, wRecordBufA + $6D
    ld a, [hl]
    cp a, $05
    jr c, Jump_00E_5F27
    ld b, a
    ld hl, wRecordBufB + $6D
    ld a, [hl]
    cp a, $05
    jr c, Jump_00E_5F27
    add a, b
    bit 0, a
    jr nz, Jump_00E_5F27
    ld a, c
    add a, $02
    ld c, a

Jump_00E_5F27::
    ld a, [wArg1]
    and a, a
    jr z, Jump_00E_5F31
    ld a, c
    add a, $03
    ld c, a

Jump_00E_5F31::
    ld a, c
    and a, a
    ret z
    ld b, $08
    ld de, Data_00E_5F89

Jump_00E_5F39::
    push de
    push bc
    ld hl, wChildRecord
    ld a, [de]
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    push bc
    ld a, c
    ld c, e
    ld b, d
    call Multiply8By16
    ld a, $64
    call DivideHLByA
    and a, a
    jr z, Jump_00E_5F58
    inc hl

Jump_00E_5F58::
    pop bc
    pop de
    push de
    push bc
    ld bc, wChildRecord
    ld a, [de]
    add a, c
    ld c, a
    jr nc, Jump_00E_5F65
    inc b

Jump_00E_5F65::
    push bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    ld d, a
    add hl, de
    ld a, h
    cp a, $03
    jr c, Jump_00E_5F7C
    jr nz, Jump_00E_5F78
    ld a, l
    cp a, $E8
    jr c, Jump_00E_5F7C

Jump_00E_5F78::
    ld h, $03
    ld l, $E7

Jump_00E_5F7C::
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    pop bc
    pop de
    inc de
    dec b
    jr nz, Jump_00E_5F39
    ret

; address loaded by ApplyBreedingBonusToChildStats
Data_00E_5F89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61, $63, $65, $67, $69

; wD7F5 = the 2-bit entry of the matrix Data_00E_603F for the combined personality indexes of wC986 and wCA2B (E-0128)
; 2 call sites from 2 routines (e.g. ApplyBreedingBonusToChildStats, RunScreenStateWhenNotFading_F1_Case04_Case16)
; writes: wArg5
; points at: wRecordBufA, wRecordBufB
PersonalityPairValueToArg5::
Func_00E_5F91:: ; address name
    ld hl, wRecordBufA
    call CombinedPersonalityLevelIndexOfRecord
    push af
    ld hl, wRecordBufB
    call CombinedPersonalityLevelIndexOfRecord
    ld b, a
    ld l, a
    ld h, $00
    srl h
    rr l
    srl h
    rr l
    pop af
    push af
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, PersonalityPairMatrix
    add hl, de
    ld a, b
    and a, $03
    ld de, Data_00E_6117
    add a, e
    ld e, a
    jr nc, Jump_00E_5FCB
    inc d

Jump_00E_5FCB::
    ld a, [de]
    ld c, a
    ld a, [hl]
    and a, c
    ld c, a
    ld a, b
    and a, $03
    and a, a
    jr z, Jump_00E_5FE1
    cp a, $01
    jr z, Jump_00E_5FEA
    cp a, $02
    jr z, Jump_00E_5FEF
    ld a, c
    jr Jump_00E_5FF4

Jump_00E_5FE1::
    ld a, c
    swap a
    srl a
    srl a
    jr Jump_00E_5FF4

Jump_00E_5FEA::
    ld a, c
    swap a
    jr Jump_00E_5FF4

Jump_00E_5FEF::
    ld a, c
    srl a
    srl a

Jump_00E_5FF4::
    ld [wArg5], a
    pop af
    ret

; for the record at HL returns 9 * grade(field $6F) + 3 * grade(field $72) + grade(field $70) (GradeHFFC6_Bank0E); compare CombinedPersonalityLevelIndex (E-0121)
; 2 call sites from 1 routine (e.g. PersonalityPairValueToArg5)
; writes: hTemp0
CombinedPersonalityLevelIndexOfRecord::
Func_00E_5FF9:: ; address name
    push hl
    ld a, $6F
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    call GradeTemp0_Bank0E
    ld a, $09
    call Multiply8
    ld b, l
    pop hl
    push hl
    ld a, $72
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    call GradeTemp0_Bank0E
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    pop hl
    ld a, $70
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    call GradeTemp0_Bank0E
    ld a, c
    add a, b
    ret

; the same 13 bytes as GradeTemp0 (00:23BD)
; 3 call sites from 1 routine (e.g. CombinedPersonalityLevelIndexOfRecord)
; reads: hTemp0
GradeTemp0_Bank0E::
Func_00E_6032:: ; address name
    ldh a, [hTemp0]
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

; E-0200 (C1: PersonalityPairValueToArg5 takes CombinedPersonalityLevelIndexOfRecord of both parents (A, B), reads the byte at $603F + 8 * A + B / 4 and masks it with Data_00E_6117[B & 3]; the selected two bits go to wArg5; 27 rows, one per index of parent A).
; record: two-bit values for parent B's combined personality index 0-26 (four per byte), padded with $FF
PersonalityPairMatrix::
Data_00E_603F:: ; address name
    db $4D, $75, $46, $55, $65, $17, $7B, $FF ; id 0
    db $1D, $75, $56, $45, $67, $D7, $63, $FF ; id 1
    db $F9, $75, $5F, $5C, $F5, $D7, $5B, $FF ; id 2
    db $55, $55, $45, $55, $E7, $E7, $7B, $FF ; id 3
    db $55, $55, $55, $5F, $63, $C7, $BB, $FF ; id 4
    db $FD, $6F, $75, $D6, $5D, $7C, $5B, $FF ; id 5
    db $55, $78, $51, $DF, $5D, $7F, $5B, $FF ; id 6
    db $55, $71, $4F, $55, $7D, $EB, $7B, $FF ; id 7
    db $55, $55, $5D, $E7, $5F, $70, $5B, $FF ; id 8
    db $14, $74, $56, $5F, $F5, $57, $5B, $FF ; id 9
    db $5D, $53, $D6, $5D, $F4, $D5, $5B, $FF ; id 10
    db $AD, $57, $6A, $A7, $55, $4F, $9B, $FF ; id 11
    db $55, $7D, $D6, $45, $57, $D5, $5B, $FF ; id 12
    db $45, $55, $96, $15, $55, $55, $53, $FF ; id 13
    db $5D, $DD, $7D, $56, $AF, $D7, $1B, $FF ; id 14
    db $51, $ED, $F7, $5A, $F7, $FD, $7B, $FF ; id 15
    db $5F, $55, $7D, $5B, $75, $51, $5B, $FF ; id 16
    db $AE, $97, $7D, $5B, $E5, $D3, $5B, $FF ; id 17
    db $55, $3F, $D5, $5D, $55, $55, $4B, $FF ; id 18
    db $77, $D5, $D1, $DF, $56, $55, $5B, $FF ; id 19
    db $3F, $D7, $5D, $DF, $75, $5A, $BB, $FF ; id 20
    db $56, $3E, $D4, $57, $55, $55, $7B, $FF ; id 21
    db $55, $7E, $17, $57, $05, $95, $53, $FF ; id 22
    db $FF, $CF, $37, $5D, $75, $96, $5B, $FF ; id 23
    db $55, $95, $56, $51, $55, $95, $53, $FF ; id 24
    db $E7, $D7, $55, $57, $51, $F5, $53, $FF ; id 25
    db $8A, $AA, $AA, $8A, $AA, $A2, $0B, $FF ; id 26

; address loaded by PersonalityPairValueToArg5
Data_00E_6117:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $30, $0C, $03

; NextTableByte; L = wC5E7, H = (wC5E7 rotated left through carry) & B; returns A = HL mod $29 (E-0117)
; 3 call sites from 3 routines (e.g. RollWCB3DChanceOrIncArg5, RollWCB3DForCaseB_5D77, RollWCADEFromSpeciesFlag)
; reads: wRandomLo
RandomModulo29::
Func_00E_611B:: ; address name
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $29
    call DivideHLByA
    ret

; loads word field wD7F5 of record A (LoadSRAMRecordWord) and falls into DrawSpeciesAndFamilyIconForTemp0 (E-0126)
; 1 call site from 1 routine (e.g. LoadRecordWordFieldAndContinue710A)
; reads: wArg5, hTemp0, hTemp1, wArg4
; writes: wArg6, wArg7, wWorkBuf
LoadRecordWordFieldArg5AndShowIcon::
Func_00E_612E:: ; address name
    ld a, c
    push af
    ld a, [wArg5]
    ld c, a
    pop af
    call LoadSRAMRecordWord

; wD7F6/7 = hFFC6/7, runs Func_00E_615A, then loads the family icon tile for wD7F5 & $0F into tile wD7F4 (E-0126)
; 1 call site from 1 routine (e.g. DrawSpeciesIconForRecordBufBEntry)
; reads: hTemp0, hTemp1, wArg5, wArg4
; writes: wArg6, wArg7, wWorkBuf
DrawSpeciesAndFamilyIconForTemp0::
Func_00E_6138:: ; address name
    ldh a, [hTemp0]
    ld [wArg6], a
    ldh a, [hTemp1]
    ld [wArg7], a
    call FamilyForSpeciesIdArg6
    ld a, [wArg5]
    and a, $0F
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    ret

; wD7F5 = the family (0-10) of species id wD7F6/7 by id ranges (< $1B, $43, $67, $85, $A8, $CA, $F1, $111, $139, $15C, or more) (E-0128)
; 5 call sites from 4 routines (e.g. ComputeBreedingChild, DrawSpeciesAndFamilyIconForTemp0, DebugToggleArg1Marker, LibraryMenu_Case10_Case06_Sub02)
; reads: wArg6, wArg7
; writes: wArg5
FamilyForSpeciesIdArg6::
Func_00E_615A:: ; address name
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    cp a, $01
    jr nz, Jump_00E_6175
    ld a, l
    cp a, $11
    jr c, Jump_00E_61AF
    cp a, $39
    jr c, Jump_00E_61B3
    cp a, $5C
    jr c, Jump_00E_61B7
    jr Jump_00E_61BB

Jump_00E_6175::
    ld a, l
    cp a, $1B
    jr c, Jump_00E_6194
    cp a, $43
    jr c, Jump_00E_6197
    cp a, $67
    jr c, Jump_00E_619B
    cp a, $85
    jr c, Jump_00E_619F
    cp a, $A8
    jr c, Jump_00E_61A3
    cp a, $CA
    jr c, Jump_00E_61A7
    cp a, $F1
    jr c, Jump_00E_61AB
    jr Jump_00E_61AF

Jump_00E_6194::
    xor a, a
    jr Jump_00E_61BD

Jump_00E_6197::
    ld a, $01
    jr Jump_00E_61BD

Jump_00E_619B::
    ld a, $02
    jr Jump_00E_61BD

Jump_00E_619F::
    ld a, $03
    jr Jump_00E_61BD

Jump_00E_61A3::
    ld a, $04
    jr Jump_00E_61BD

Jump_00E_61A7::
    ld a, $05
    jr Jump_00E_61BD

Jump_00E_61AB::
    ld a, $06
    jr Jump_00E_61BD

Jump_00E_61AF::
    ld a, $07
    jr Jump_00E_61BD

Jump_00E_61B3::
    ld a, $08
    jr Jump_00E_61BD

Jump_00E_61B7::
    ld a, $09
    jr Jump_00E_61BD

Jump_00E_61BB::
    ld a, $0A

Jump_00E_61BD::
    ld [wArg5], a
    ret

; loads species wCADB; when its byte wD009 is non-zero, rolls against Data_00E_61FC[byte & 3] and stores 1 in wCADE on success, else 0 (E-0124)
; 2 call sites from 2 routines (e.g. ComputeBreedingChild, MedalPrizeMenu_Case05_Case0E_Sub01)
; reads: wChildRecord, wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
RollWCADEFromSpeciesFlag::
Func_00E_61C1:: ; address name
    ld a, [wChildRecord + $B]
    ld [wSpeciesIdLo], a
    ld a, [wChildRecord + $C]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecordWord0
    ld a, [wSpeciesRecord + $1]
    and a, a
    jr z, Jump_00E_61F4
    and a, $03
    ld hl, Data_00E_61FC
    add_a_to_hl
    ld a, [hl]
    push af
    push bc
    ld b, $0F
    call RandomModulo29
    pop bc
    pop af
    cp a, l
    jr c, Jump_00E_61F4
    ld b, $01
    jr Jump_00E_61F6

Jump_00E_61F4::
    ld b, $00

Jump_00E_61F6::
    ld a, b
    ld hl, wChildRecord + $E
    ld [hl], a
    ret

; address loaded by RollWCADEFromSpeciesFlag
Data_00E_61FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0A, $32, $5A

; address loaded by ComputeBreedingChild
Data_00E_6200:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $5D, $61, $61, $63, $65, $67, $69

; E-0199 (C1: ComputeBreedingChild stage 1 reads the word at $6208 + 2 * parent A's species (record +$B) and walks the list's words: a species equal to parent B's matches; $FDxx moves to the next result; $FExx / $FCxx match when parent B / parent A has + (record +$6D) of at least xx and both parents are the same species; $FBxx moves on only when wArg1 = 2; $FFxx ends the list; a match takes result [count of moves] from BreedSpeciesResultTable)
; record: list
BreedSpeciesRuleTable::
Data_00E_6208:: ; address name
    dw BreedSpeciesRules000 ; id 0
    dw BreedSpeciesRules001 ; id 1 DrakSlime
    dw BreedSpeciesRules002 ; id 2 SpotSlime
    dw BreedSpeciesRules000 ; id 3 WingSlime
    dw BreedSpeciesRules000 ; id 4 TreeSlime
    dw BreedSpeciesRules000 ; id 5 Snaily
    dw BreedSpeciesRules006 ; id 6 SlimeNite
    dw BreedSpeciesRules000 ; id 7 Babble
    dw BreedSpeciesRules000 ; id 8 BoxSlime
    dw BreedSpeciesRules000 ; id 9 PearlGel
    dw BreedSpeciesRules00A ; id 10 Slime
    dw BreedSpeciesRules00B ; id 11 Healer
    dw BreedSpeciesRules000 ; id 12 FangSlime
    dw BreedSpeciesRules00D ; id 13 RockSlime
    dw BreedSpeciesRules000 ; id 14 SlimeBorg
    dw BreedSpeciesRules000 ; id 15 Slabbit
    dw BreedSpeciesRules010 ; id 16 KingSlime
    dw BreedSpeciesRules011 ; id 17 Metaly
    dw BreedSpeciesRules012 ; id 18 Metabble
    dw BreedSpeciesRules013 ; id 19 SpotKing
    dw BreedSpeciesRules000 ; id 20 TropicGel
    dw BreedSpeciesRules015 ; id 21 MimeSlime
    dw BreedSpeciesRules000 ; id 22 HaloSlime
    dw BreedSpeciesRules017 ; id 23 MetalKing
    dw BreedSpeciesRules018 ; id 24 GoldSlime
    dw BreedSpeciesRules000 ; id 25 GranSlime
    dw BreedSpeciesRules01A ; id 26 WonderEgg
    dw BreedSpeciesRules000 ; id 27 Butch
    dw BreedSpeciesRules000 ; id 28 ?
    dw BreedSpeciesRules000 ; id 29 ?
    dw BreedSpeciesRules000 ; id 30 ?
    dw BreedSpeciesRules000 ; id 31 ?
    dw BreedSpeciesRules000 ; id 32 ?
    dw BreedSpeciesRules000 ; id 33 ?
    dw BreedSpeciesRules000 ; id 34 ?
    dw BreedSpeciesRules000 ; id 35 ?
    dw BreedSpeciesRules024 ; id 36 DragonKid
    dw BreedSpeciesRules000 ; id 37 Tortragon
    dw BreedSpeciesRules026 ; id 38 Pteranod
    dw BreedSpeciesRules027 ; id 39 Gasgon
    dw BreedSpeciesRules000 ; id 40 FairyDrak
    dw BreedSpeciesRules029 ; id 41 LizardMan
    dw BreedSpeciesRules000 ; id 42 Poisongon
    dw BreedSpeciesRules000 ; id 43 Swordgon
    dw BreedSpeciesRules000 ; id 44 Drygon
    dw BreedSpeciesRules02D ; id 45 Dragon
    dw BreedSpeciesRules000 ; id 46 MiniDrak
    dw BreedSpeciesRules02F ; id 47 MadDragon
    dw BreedSpeciesRules000 ; id 48 Rayburn
    dw BreedSpeciesRules000 ; id 49 Chamelgon
    dw BreedSpeciesRules000 ; id 50 LizardFly
    dw BreedSpeciesRules033 ; id 51 Andreal
    dw BreedSpeciesRules034 ; id 52 KingCobra
    dw BreedSpeciesRules035 ; id 53 Vampirus
    dw BreedSpeciesRules000 ; id 54 SnakeBat
    dw BreedSpeciesRules000 ; id 55 Spikerous
    dw BreedSpeciesRules038 ; id 56 GreatDrak
    dw BreedSpeciesRules039 ; id 57 Crestpent
    dw BreedSpeciesRules03A ; id 58 WingSnake
    dw BreedSpeciesRules000 ; id 59 Coatol
    dw BreedSpeciesRules000 ; id 60 Orochi
    dw BreedSpeciesRules03D ; id 61 BattleRex
    dw BreedSpeciesRules03E ; id 62 SkyDragon
    dw BreedSpeciesRules000 ; id 63 Serpentia
    dw BreedSpeciesRules040 ; id 64 Divinegon
    dw BreedSpeciesRules000 ; id 65 Orligon
    dw BreedSpeciesRules000 ; id 66 GigaDraco
    dw BreedSpeciesRules000 ; id 67 ?
    dw BreedSpeciesRules000 ; id 68 ?
    dw BreedSpeciesRules000 ; id 69 ?
    dw BreedSpeciesRules000 ; id 70 ?
    dw BreedSpeciesRules047 ; id 71 Tonguella
    dw BreedSpeciesRules048 ; id 72 Almiraj
    dw BreedSpeciesRules049 ; id 73 CatFly
    dw BreedSpeciesRules000 ; id 74 PillowRat
    dw BreedSpeciesRules000 ; id 75 Saccer
    dw BreedSpeciesRules04C ; id 76 GulpBeast
    dw BreedSpeciesRules000 ; id 77 Skullroo
    dw BreedSpeciesRules000 ; id 78 WindBeast
    dw BreedSpeciesRules000 ; id 79 Beavern
    dw BreedSpeciesRules000 ; id 80 Antbear
    dw BreedSpeciesRules051 ; id 81 SuperTen
    dw BreedSpeciesRules052 ; id 82 IronTurt
    dw BreedSpeciesRules000 ; id 83 Mommonja
    dw BreedSpeciesRules054 ; id 84 HammerMan
    dw BreedSpeciesRules055 ; id 85 Grizzly
    dw BreedSpeciesRules056 ; id 86 Yeti
    dw BreedSpeciesRules057 ; id 87 ArrowDog
    dw BreedSpeciesRules058 ; id 88 NoctoKing
    dw BreedSpeciesRules059 ; id 89 BeastNite
    dw BreedSpeciesRules05A ; id 90 MadGopher
    dw BreedSpeciesRules000 ; id 91 FairyRat
    dw BreedSpeciesRules05C ; id 92 Unicorn
    dw BreedSpeciesRules05D ; id 93 Goategon
    dw BreedSpeciesRules05E ; id 94 WildApe
    dw BreedSpeciesRules05F ; id 95 Trumpeter
    dw BreedSpeciesRules000 ; id 96 KingLeo
    dw BreedSpeciesRules061 ; id 97 DarkHorn
    dw BreedSpeciesRules062 ; id 98 MadCat
    dw BreedSpeciesRules000 ; id 99 BigEye
    dw BreedSpeciesRules000 ; id 100 Gorago
    dw BreedSpeciesRules065 ; id 101 CatMage
    dw BreedSpeciesRules066 ; id 102 Dumbira
    dw BreedSpeciesRules000 ; id 103 ?
    dw BreedSpeciesRules000 ; id 104 ?
    dw BreedSpeciesRules000 ; id 105 ?
    dw BreedSpeciesRules000 ; id 106 Picky
    dw BreedSpeciesRules000 ; id 107 Wyvern
    dw BreedSpeciesRules06C ; id 108 BullBird
    dw BreedSpeciesRules000 ; id 109 Florajay
    dw BreedSpeciesRules000 ; id 110 DuckKite
    dw BreedSpeciesRules06F ; id 111 MadPecker
    dw BreedSpeciesRules000 ; id 112 MadRaven
    dw BreedSpeciesRules000 ; id 113 MistyWing
    dw BreedSpeciesRules072 ; id 114 AquaHawk
    dw BreedSpeciesRules000 ; id 115 Dracky
    dw BreedSpeciesRules074 ; id 116 KiteHawk
    dw BreedSpeciesRules000 ; id 117 BigRoost
    dw BreedSpeciesRules000 ; id 118 StubBird
    dw BreedSpeciesRules077 ; id 119 LandOwl
    dw BreedSpeciesRules078 ; id 120 MadGoose
    dw BreedSpeciesRules079 ; id 121 MadCondor
    dw BreedSpeciesRules000 ; id 122 Emyu
    dw BreedSpeciesRules07B ; id 123 Blizzardy
    dw BreedSpeciesRules07C ; id 124 Phoenix
    dw BreedSpeciesRules07D ; id 125 ZapBird
    dw BreedSpeciesRules07E ; id 126 Garudian
    dw BreedSpeciesRules07F ; id 127 WhipBird
    dw BreedSpeciesRules080 ; id 128 FunkyBird
    dw BreedSpeciesRules081 ; id 129 RainHawk
    dw BreedSpeciesRules000 ; id 130 Azurile
    dw BreedSpeciesRules083 ; id 131 Shantak
    dw BreedSpeciesRules084 ; id 132 CragDevil
    dw BreedSpeciesRules000 ; id 133 ?
    dw BreedSpeciesRules000 ; id 134 ?
    dw BreedSpeciesRules000 ; id 135 ?
    dw BreedSpeciesRules000 ; id 136 ?
    dw BreedSpeciesRules000 ; id 137 ?
    dw BreedSpeciesRules000 ; id 138 ?
    dw BreedSpeciesRules000 ; id 139 ?
    dw BreedSpeciesRules000 ; id 140 ?
    dw BreedSpeciesRules000 ; id 141 MadPlant
    dw BreedSpeciesRules000 ; id 142 FireWeed
    dw BreedSpeciesRules000 ; id 143 FloraMan
    dw BreedSpeciesRules000 ; id 144 WingTree
    dw BreedSpeciesRules000 ; id 145 CactiBall
    dw BreedSpeciesRules000 ; id 146 Gulpple
    dw BreedSpeciesRules000 ; id 147 Toadstool
    dw BreedSpeciesRules000 ; id 148 AmberWeed
    dw BreedSpeciesRules000 ; id 149 Slurperon
    dw BreedSpeciesRules096 ; id 150 Stubsuck
    dw BreedSpeciesRules000 ; id 151 Oniono
    dw BreedSpeciesRules000 ; id 152 DanceVegi
    dw BreedSpeciesRules099 ; id 153 TreeBoy
    dw BreedSpeciesRules000 ; id 154 Devipine
    dw BreedSpeciesRules000 ; id 155 FaceTree
    dw BreedSpeciesRules000 ; id 156 HerbMan
    dw BreedSpeciesRules000 ; id 157 BeanMan
    dw BreedSpeciesRules09E ; id 158 EvilSeed
    dw BreedSpeciesRules09F ; id 159 ManEater
    dw BreedSpeciesRules000 ; id 160 Snapper
    dw BreedSpeciesRules0A1 ; id 161 GhosTree
    dw BreedSpeciesRules0A2 ; id 162 Rosevine
    dw BreedSpeciesRules000 ; id 163 Egdracil
    dw BreedSpeciesRules0A4 ; id 164 Warubou
    dw BreedSpeciesRules000 ; id 165 Watabou
    dw BreedSpeciesRules000 ; id 166 Eggplaton
    dw BreedSpeciesRules0A7 ; id 167 FooHero
    dw BreedSpeciesRules000 ; id 168 ?
    dw BreedSpeciesRules000 ; id 169 ?
    dw BreedSpeciesRules000 ; id 170 ?
    dw BreedSpeciesRules000 ; id 171 ?
    dw BreedSpeciesRules000 ; id 172 ?
    dw BreedSpeciesRules000 ; id 173 ?
    dw BreedSpeciesRules000 ; id 174 ?
    dw BreedSpeciesRules000 ; id 175 ?
    dw BreedSpeciesRules000 ; id 176 GiantSlug
    dw BreedSpeciesRules0B1 ; id 177 Catapila
    dw BreedSpeciesRules000 ; id 178 Gophecada
    dw BreedSpeciesRules0B3 ; id 179 Butterfly
    dw BreedSpeciesRules0B4 ; id 180 WeedBug
    dw BreedSpeciesRules000 ; id 181 GiantWorm
    dw BreedSpeciesRules0B6 ; id 182 Lipsy
    dw BreedSpeciesRules0B7 ; id 183 StagBug
    dw BreedSpeciesRules000 ; id 184 Pyuro
    dw BreedSpeciesRules000 ; id 185 ArmyAnt
    dw BreedSpeciesRules000 ; id 186 GoHopper
    dw BreedSpeciesRules0BB ; id 187 TailEater
    dw BreedSpeciesRules000 ; id 188 ArmorPede
    dw BreedSpeciesRules0BD ; id 189 Eyeder
    dw BreedSpeciesRules000 ; id 190 GiantMoth
    dw BreedSpeciesRules000 ; id 191 Droll
    dw BreedSpeciesRules0C0 ; id 192 ArmyCrab
    dw BreedSpeciesRules0C1 ; id 193 MadHornet
    dw BreedSpeciesRules000 ; id 194 Belzebub
    dw BreedSpeciesRules0C3 ; id 195 WarMantis
    dw BreedSpeciesRules0C4 ; id 196 HornBeet
    dw BreedSpeciesRules000 ; id 197 Sickler
    dw BreedSpeciesRules0C6 ; id 198 Armorpion
    dw BreedSpeciesRules000 ; id 199 Digster
    dw BreedSpeciesRules000 ; id 200 Skularach
    dw BreedSpeciesRules0C9 ; id 201 MultiEyes
    dw BreedSpeciesRules000 ; id 202 ?
    dw BreedSpeciesRules000 ; id 203 ?
    dw BreedSpeciesRules000 ; id 204 ?
    dw BreedSpeciesRules000 ; id 205 ?
    dw BreedSpeciesRules000 ; id 206 ?
    dw BreedSpeciesRules000 ; id 207 ?
    dw BreedSpeciesRules000 ; id 208 ?
    dw BreedSpeciesRules000 ; id 209 ?
    dw BreedSpeciesRules000 ; id 210 ?
    dw BreedSpeciesRules000 ; id 211 Pixy
    dw BreedSpeciesRules000 ; id 212 MedusaEye
    dw BreedSpeciesRules0D5 ; id 213 AgDevil
    dw BreedSpeciesRules0D6 ; id 214 Demonite
    dw BreedSpeciesRules0D7 ; id 215 DarkEye
    dw BreedSpeciesRules000 ; id 216 EyeBall
    dw BreedSpeciesRules000 ; id 217 SkulRider
    dw BreedSpeciesRules000 ; id 218 EvilBeast
    dw BreedSpeciesRules0DB ; id 219 Bubblemon
    dw BreedSpeciesRules0DC ; id 220 1EyeClown
    dw BreedSpeciesRules0DD ; id 221 Gremlin
    dw BreedSpeciesRules0DE ; id 222 ArcDemon
    dw BreedSpeciesRules0DF ; id 223 Lionex
    dw BreedSpeciesRules000 ; id 224 GoatHorn
    dw BreedSpeciesRules000 ; id 225 Orc
    dw BreedSpeciesRules0E2 ; id 226 Ogre
    dw BreedSpeciesRules000 ; id 227 GateGuard
    dw BreedSpeciesRules000 ; id 228 ChopClown
    dw BreedSpeciesRules0E5 ; id 229 BossTroll
    dw BreedSpeciesRules0E6 ; id 230 Grendal
    dw BreedSpeciesRules0E7 ; id 231 Akubar
    dw BreedSpeciesRules000 ; id 232 MadKnight
    dw BreedSpeciesRules000 ; id 233 EvilWell
    dw BreedSpeciesRules0EA ; id 234 Gigantes
    dw BreedSpeciesRules0EB ; id 235 Centasaur
    dw BreedSpeciesRules000 ; id 236 EvilArmor
    dw BreedSpeciesRules0ED ; id 237 Jamirus
    dw BreedSpeciesRules0EE ; id 238 Durran
    dw BreedSpeciesRules000 ; id 239 Titanis
    dw BreedSpeciesRules0F0 ; id 240 LampGenie
    dw BreedSpeciesRules000 ; id 241 ?
    dw BreedSpeciesRules000 ; id 242 ?
    dw BreedSpeciesRules000 ; id 243 ?
    dw BreedSpeciesRules000 ; id 244 ?
    dw BreedSpeciesRules000 ; id 245 ?
    dw BreedSpeciesRules000 ; id 246 Spooky
    dw BreedSpeciesRules0F7 ; id 247 Skullgon
    dw BreedSpeciesRules0F8 ; id 248 PutrePup
    dw BreedSpeciesRules000 ; id 249 RotRaven
    dw BreedSpeciesRules0FA ; id 250 Mummy
    dw BreedSpeciesRules000 ; id 251 DarkCrab
    dw BreedSpeciesRules0FC ; id 252 DeadNite
    dw BreedSpeciesRules000 ; id 253 Shadow
    dw BreedSpeciesRules000 ; id 254 Skulpent
    dw BreedSpeciesRules0FF ; id 255 Hork
    dw BreedSpeciesRules100 ; id 256 Mudron
    dw BreedSpeciesRules101 ; id 257 NiteWhip
    dw BreedSpeciesRules000 ; id 258 WindMerge
    dw BreedSpeciesRules000 ; id 259 Reaper
    dw BreedSpeciesRules000 ; id 260 Inverzon
    dw BreedSpeciesRules000 ; id 261 FoxFire
    dw BreedSpeciesRules106 ; id 262 CaptDead
    dw BreedSpeciesRules107 ; id 263 DeadNoble
    dw BreedSpeciesRules108 ; id 264 WhiteKing
    dw BreedSpeciesRules109 ; id 265 BoneSlave
    dw BreedSpeciesRules10A ; id 266 Skeletor
    dw BreedSpeciesRules10B ; id 267 Servant
    dw BreedSpeciesRules000 ; id 268 Lazamanus
    dw BreedSpeciesRules10D ; id 269 Copycat
    dw BreedSpeciesRules10E ; id 270 MadSpirit
    dw BreedSpeciesRules000 ; id 271 PomPomBom
    dw BreedSpeciesRules110 ; id 272 Niterich
    dw BreedSpeciesRules000 ; id 273 ?
    dw BreedSpeciesRules000 ; id 274 ?
    dw BreedSpeciesRules000 ; id 275 ?
    dw BreedSpeciesRules000 ; id 276 ?
    dw BreedSpeciesRules000 ; id 277 ?
    dw BreedSpeciesRules000 ; id 278 ?
    dw BreedSpeciesRules000 ; id 279 ?
    dw BreedSpeciesRules000 ; id 280 ?
    dw BreedSpeciesRules000 ; id 281 JewelBag
    dw BreedSpeciesRules11A ; id 282 EvilWand
    dw BreedSpeciesRules11B ; id 283 MadCandle
    dw BreedSpeciesRules000 ; id 284 CoilBird
    dw BreedSpeciesRules000 ; id 285 Facer
    dw BreedSpeciesRules11E ; id 286 SpikyBoy
    dw BreedSpeciesRules11F ; id 287 MadMirror
    dw BreedSpeciesRules000 ; id 288 RogueNite
    dw BreedSpeciesRules121 ; id 289 Puppetor
    dw BreedSpeciesRules122 ; id 290 Goopi
    dw BreedSpeciesRules123 ; id 291 Voodoll
    dw BreedSpeciesRules124 ; id 292 MetalDrak
    dw BreedSpeciesRules000 ; id 293 Balzak
    dw BreedSpeciesRules126 ; id 294 SabreMan
    dw BreedSpeciesRules127 ; id 295 CurseLamp
    dw BreedSpeciesRules000 ; id 296 Brushead
    dw BreedSpeciesRules129 ; id 297 Roboster
    dw BreedSpeciesRules12A ; id 298 Roboster2
    dw BreedSpeciesRules12B ; id 299 EvilPot
    dw BreedSpeciesRules12C ; id 300 Gismo
    dw BreedSpeciesRules12D ; id 301 LavaMan
    dw BreedSpeciesRules12E ; id 302 IceMan
    dw BreedSpeciesRules12F ; id 303 Mimic
    dw BreedSpeciesRules000 ; id 304 Exaucers
    dw BreedSpeciesRules131 ; id 305 MudDoll
    dw BreedSpeciesRules132 ; id 306 Golem
    dw BreedSpeciesRules133 ; id 307 StoneMan
    dw BreedSpeciesRules000 ; id 308 BombCrag
    dw BreedSpeciesRules135 ; id 309 GoldGolem
    dw BreedSpeciesRules000 ; id 310 DarkMate
    dw BreedSpeciesRules000 ; id 311 ProtoMech
    dw BreedSpeciesRules000 ; id 312 CloudKing
    dw BreedSpeciesRules000 ; id 313 ?
    dw BreedSpeciesRules000 ; id 314 ?
    dw BreedSpeciesRules000 ; id 315 ?
    dw BreedSpeciesRules000 ; id 316 Petiteel
    dw BreedSpeciesRules000 ; id 317 Moray
    dw BreedSpeciesRules000 ; id 318 WalrusMan
    dw BreedSpeciesRules000 ; id 319 RayGigas
    dw BreedSpeciesRules000 ; id 320 Anemon
    dw BreedSpeciesRules141 ; id 321 Aquarella
    dw BreedSpeciesRules142 ; id 322 Merman
    dw BreedSpeciesRules000 ; id 323 Octokid
    dw BreedSpeciesRules000 ; id 324 PutreFish
    dw BreedSpeciesRules145 ; id 325 Octoreach
    dw BreedSpeciesRules146 ; id 326 Angleron
    dw BreedSpeciesRules000 ; id 327 FishRider
    dw BreedSpeciesRules148 ; id 328 RushFish
    dw BreedSpeciesRules149 ; id 329 Gamanian
    dw BreedSpeciesRules14A ; id 330 Clawster
    dw BreedSpeciesRules14B ; id 331 CancerMan
    dw BreedSpeciesRules14C ; id 332 RogueWave
    dw BreedSpeciesRules000 ; id 333 Scallopa
    dw BreedSpeciesRules000 ; id 334 SeaHorse
    dw BreedSpeciesRules14F ; id 335 HoodSquid
    dw BreedSpeciesRules150 ; id 336 MerTiger
    dw BreedSpeciesRules000 ; id 337 AxeShark
    dw BreedSpeciesRules152 ; id 338 Octogon
    dw BreedSpeciesRules000 ; id 339 KingSquid
    dw BreedSpeciesRules154 ; id 340 Digong
    dw BreedSpeciesRules000 ; id 341 WhaleMage
    dw BreedSpeciesRules000 ; id 342 Aquadon
    dw BreedSpeciesRules000 ; id 343 Octoraid
    dw BreedSpeciesRules158 ; id 344 Grakos
    dw BreedSpeciesRules000 ; id 345 Poseidon
    dw BreedSpeciesRules000 ; id 346 Pumpoise
    dw BreedSpeciesRules000 ; id 347 Starfish
    dw BreedSpeciesRules000 ; id 348 ?
    dw BreedSpeciesRules000 ; id 349 ?
    dw BreedSpeciesRules000 ; id 350 ?
    dw BreedSpeciesRules15F ; id 351 DracoLord
    dw BreedSpeciesRules160 ; id 352 DracoLord
    dw BreedSpeciesRules000 ; id 353 LordDraco
    dw BreedSpeciesRules162 ; id 354 Hargon
    dw BreedSpeciesRules163 ; id 355 Sidoh
    dw BreedSpeciesRules000 ; id 356 Genosidoh
    dw BreedSpeciesRules165 ; id 357 Baramos
    dw BreedSpeciesRules166 ; id 358 Zoma
    dw BreedSpeciesRules000 ; id 359 AsuraZoma
    dw BreedSpeciesRules168 ; id 360 Pizzaro
    dw BreedSpeciesRules169 ; id 361 PsychoPiz
    dw BreedSpeciesRules16A ; id 362 Esterk
    dw BreedSpeciesRules16B ; id 363 Mirudraas
    dw BreedSpeciesRules16C ; id 364 Mirudraas
    dw BreedSpeciesRules000 ; id 365 Mudou
    dw BreedSpeciesRules16E ; id 366 DeathMore
    dw BreedSpeciesRules16F ; id 367 DeathMore
    dw BreedSpeciesRules170 ; id 368 DeathMore
    dw BreedSpeciesRules000 ; id 369 Darkdrium
    dw BreedSpeciesRules172 ; id 370 Orgodemir
    dw BreedSpeciesRules000 ; id 371 Orgodemir
    dw BreedSpeciesRules000 ; id 372 Darck
    dw BreedSpeciesRules000 ; id 373 Tatsu
    dw BreedSpeciesRules000 ; id 374 Diago
    dw BreedSpeciesRules000 ; id 375 Samsi
    dw BreedSpeciesRules000 ; id 376 Bazoo
    dw BreedSpeciesRules000 ; id 377 ?
    dw BreedSpeciesRules000 ; id 378 ?
    dw BreedSpeciesRules000 ; id 379 ?
    dw BreedSpeciesRules000 ; id 380 Lamia
    dw BreedSpeciesRules000 ; id 381 Dimensaur
    dw BreedSpeciesRules000 ; id 382 Kagebou
    dw BreedSpeciesRules000 ; id 383 ?

; E-0199 (derived: list for entry $00 of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules000::
Data_00E_6508:: ; address name
    dw $FFFF ; id 0 end of list

; E-0199 (derived: list for entry $01 (DrakSlime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules001::
Data_00E_650A:: ; address name
    dw $002B ; id 0 Swordgon
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $02 (SpotSlime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules002::
Data_00E_650E:: ; address name
    dw $FE04 ; id 0 same species, parent B +4 or more
    dw $FC04 ; id 1 same species, parent A +4 or more
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $06 (SlimeNite) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules006::
Data_00E_6514:: ; address name
    dw $0037 ; id 0 Spikerous
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $0A (Slime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules00A::
Data_00E_6518:: ; address name
    dw $FE04 ; id 0 same species, parent B +4 or more
    dw $FC04 ; id 1 same species, parent A +4 or more
    dw $FDFD ; id 2 next result
    dw $004A ; id 3 PillowRat
    dw $0053 ; id 4 Mommonja
    dw $FDFD ; id 5 next result
    dw $010D ; id 6 Copycat
    dw $FBFB ; id 7 next result when wArg1 = 2, else end of list
    dw $0075 ; id 8 BigRoost
    dw $FFFF ; id 9 end of list

; E-0199 (derived: list for entry $0B (Healer) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules00B::
Data_00E_652C:: ; address name
    dw $0099 ; id 0 TreeBoy
    dw $00DC ; id 1 1EyeClown
    dw $011A ; id 2 EvilWand
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $0D (RockSlime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules00D::
Data_00E_6534:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $10 (KingSlime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules010::
Data_00E_6538:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $003D ; id 1 BattleRex
    dw $0040 ; id 2 Divinegon
    dw $005C ; id 3 Unicorn
    dw $0060 ; id 4 KingLeo
    dw $0079 ; id 5 MadCondor
    dw $007D ; id 6 ZapBird
    dw $007F ; id 7 WhipBird
    dw $00E5 ; id 8 BossTroll
    dw $00EA ; id 9 Gigantes
    dw $00EB ; id 10 Centasaur
    dw $0107 ; id 11 DeadNoble
    dw $0108 ; id 12 WhiteKing
    dw $FDFD ; id 13 next result
    dw $0124 ; id 14 MetalDrak
    dw $FDFD ; id 15 next result
    dw $0135 ; id 16 GoldGolem
    dw $FFFF ; id 17 end of list

; E-0199 (derived: list for entry $11 (Metaly) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules011::
Data_00E_655C:: ; address name
    dw $0011 ; id 0 Metaly
    dw $001A ; id 1 WonderEgg
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $12 (Metabble) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules012::
Data_00E_6562:: ; address name
    dw $003D ; id 0 BattleRex
    dw $003E ; id 1 SkyDragon
    dw $FDFD ; id 2 next result
    dw $0012 ; id 3 Metabble
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $13 (SpotKing) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules013::
Data_00E_656C:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $003D ; id 1 BattleRex
    dw $0040 ; id 2 Divinegon
    dw $005C ; id 3 Unicorn
    dw $0060 ; id 4 KingLeo
    dw $0079 ; id 5 MadCondor
    dw $007D ; id 6 ZapBird
    dw $007F ; id 7 WhipBird
    dw $00E5 ; id 8 BossTroll
    dw $00EA ; id 9 Gigantes
    dw $00EB ; id 10 Centasaur
    dw $0107 ; id 11 DeadNoble
    dw $0108 ; id 12 WhiteKing
    dw $FDFD ; id 13 next result
    dw $0124 ; id 14 MetalDrak
    dw $FDFD ; id 15 next result
    dw $0135 ; id 16 GoldGolem
    dw $FFFF ; id 17 end of list

; E-0199 (derived: list for entry $15 (MimeSlime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules015::
Data_00E_6590:: ; address name
    dw $0076 ; id 0 StubBird
    dw $00D3 ; id 1 Pixy
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $17 (MetalKing) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules017::
Data_00E_6596:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $003D ; id 1 BattleRex
    dw $0040 ; id 2 Divinegon
    dw $005C ; id 3 Unicorn
    dw $0060 ; id 4 KingLeo
    dw $0079 ; id 5 MadCondor
    dw $007D ; id 6 ZapBird
    dw $007F ; id 7 WhipBird
    dw $00E5 ; id 8 BossTroll
    dw $00EA ; id 9 Gigantes
    dw $00EB ; id 10 Centasaur
    dw $0107 ; id 11 DeadNoble
    dw $0108 ; id 12 WhiteKing
    dw $FDFD ; id 13 next result
    dw $0017 ; id 14 MetalKing
    dw $0135 ; id 15 GoldGolem
    dw $FFFF ; id 16 end of list

; E-0199 (derived: list for entry $18 (GoldSlime) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules018::
Data_00E_65B8:: ; address name
    dw $0018 ; id 0 GoldSlime
    dw $0136 ; id 1 DarkMate
    dw $016E ; id 2 DeathMore
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $1A (WonderEgg) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules01A::
Data_00E_65C0:: ; address name
    dw $0012 ; id 0 Metabble
    dw $FDFD ; id 1 next result
    dw $0017 ; id 2 MetalKing
    dw $FDFD ; id 3 next result
    dw $0018 ; id 4 GoldSlime
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $24 (DragonKid) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules024::
Data_00E_65CC:: ; address name
    dw $FE04 ; id 0 same species, parent B +4 or more
    dw $FC04 ; id 1 same species, parent A +4 or more
    dw $FDFD ; id 2 next result
    dw $0024 ; id 3 DragonKid
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $26 (Pteranod) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules026::
Data_00E_65D6:: ; address name
    dw $0026 ; id 0 Pteranod
    dw $FDFD ; id 1 next result
    dw $0061 ; id 2 DarkHorn
    dw $00E8 ; id 3 MadKnight
    dw $010D ; id 4 Copycat
    dw $0133 ; id 5 StoneMan
    dw $007F ; id 6 WhipBird
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $27 (Gasgon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules027::
Data_00E_65E6:: ; address name
    dw $005D ; id 0 Goategon
    dw $005F ; id 1 Trumpeter
    dw $0079 ; id 2 MadCondor
    dw $0080 ; id 3 FunkyBird
    dw $00DE ; id 4 ArcDemon
    dw $00DF ; id 5 Lionex
    dw $00E0 ; id 6 GoatHorn
    dw $00E2 ; id 7 Ogre
    dw $00E7 ; id 8 Akubar
    dw $0107 ; id 9 DeadNoble
    dw $0132 ; id 10 Golem
    dw $FDFD ; id 11 next result
    dw $0061 ; id 12 DarkHorn
    dw $00E8 ; id 13 MadKnight
    dw $010D ; id 14 Copycat
    dw $0133 ; id 15 StoneMan
    dw $007F ; id 16 WhipBird
    dw $FFFF ; id 17 end of list

; E-0199 (derived: list for entry $29 (LizardMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules029::
Data_00E_660A:: ; address name
    dw $0003 ; id 0 WingSlime
    dw $005F ; id 1 Trumpeter
    dw $0062 ; id 2 MadCat
    dw $009B ; id 3 FaceTree
    dw $00DF ; id 4 Lionex
    dw $00E0 ; id 5 GoatHorn
    dw $00E3 ; id 6 GateGuard
    dw $00EA ; id 7 Gigantes
    dw $FDFD ; id 8 next result
    dw $0061 ; id 9 DarkHorn
    dw $00E8 ; id 10 MadKnight
    dw $010D ; id 11 Copycat
    dw $0133 ; id 12 StoneMan
    dw $007F ; id 13 WhipBird
    dw $FFFF ; id 14 end of list

; E-0199 (derived: list for entry $2D (Dragon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules02D::
Data_00E_6628:: ; address name
    dw $FE04 ; id 0 same species, parent B +4 or more
    dw $FC04 ; id 1 same species, parent A +4 or more
    dw $FBFB ; id 2 next result when wArg1 = 2, else end of list
    dw $0072 ; id 3 AquaHawk
    dw $FDFD ; id 4 next result
    dw $00DF ; id 5 Lionex
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $2F (MadDragon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules02F::
Data_00E_6636:: ; address name
    dw $005D ; id 0 Goategon
    dw $005F ; id 1 Trumpeter
    dw $0079 ; id 2 MadCondor
    dw $0080 ; id 3 FunkyBird
    dw $00DE ; id 4 ArcDemon
    dw $00DF ; id 5 Lionex
    dw $00E0 ; id 6 GoatHorn
    dw $00E2 ; id 7 Ogre
    dw $00E7 ; id 8 Akubar
    dw $0107 ; id 9 DeadNoble
    dw $0132 ; id 10 Golem
    dw $FFFF ; id 11 end of list

; E-0199 (derived: list for entry $33 (Andreal) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules033::
Data_00E_664E:: ; address name
    dw $00D4 ; id 0 MedusaEye
    dw $FDFD ; id 1 next result
    dw $00E5 ; id 2 BossTroll
    dw $00EA ; id 3 Gigantes
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $34 (KingCobra) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules034::
Data_00E_6658:: ; address name
    dw $0073 ; id 0 Dracky
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $35 (Vampirus) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules035::
Data_00E_665C:: ; address name
    dw $0061 ; id 0 DarkHorn
    dw $00E8 ; id 1 MadKnight
    dw $010D ; id 2 Copycat
    dw $0133 ; id 3 StoneMan
    dw $007F ; id 4 WhipBird
    dw $FBFB ; id 5 next result when wArg1 = 2, else end of list
    dw $0072 ; id 6 AquaHawk
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $38 (GreatDrak) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules038::
Data_00E_666C:: ; address name
    dw $00D4 ; id 0 MedusaEye
    dw $FDFD ; id 1 next result
    dw $00DF ; id 2 Lionex
    dw $010A ; id 3 Skeletor
    dw $0157 ; id 4 Octoraid
    dw $FDFD ; id 5 next result
    dw $00E5 ; id 6 BossTroll
    dw $00EA ; id 7 Gigantes
    dw $FFFF ; id 8 end of list

; E-0199 (derived: list for entry $39 (Crestpent) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules039::
Data_00E_667E:: ; address name
    dw $0039 ; id 0 Crestpent
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $3A (WingSnake) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules03A::
Data_00E_6682:: ; address name
    dw $003A ; id 0 WingSnake
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $3D (BattleRex) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules03D::
Data_00E_6686:: ; address name
    dw $005D ; id 0 Goategon
    dw $005F ; id 1 Trumpeter
    dw $0079 ; id 2 MadCondor
    dw $0080 ; id 3 FunkyBird
    dw $00DE ; id 4 ArcDemon
    dw $00DF ; id 5 Lionex
    dw $00E0 ; id 6 GoatHorn
    dw $00E2 ; id 7 Ogre
    dw $00E7 ; id 8 Akubar
    dw $0107 ; id 9 DeadNoble
    dw $0132 ; id 10 Golem
    dw $FDFD ; id 11 next result
    dw $0061 ; id 12 DarkHorn
    dw $00E8 ; id 13 MadKnight
    dw $010D ; id 14 Copycat
    dw $0133 ; id 15 StoneMan
    dw $007F ; id 16 WhipBird
    dw $FDFD ; id 17 next result
    dw $00E5 ; id 18 BossTroll
    dw $00EA ; id 19 Gigantes
    dw $FFFF ; id 20 end of list

; E-0199 (derived: list for entry $3E (SkyDragon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules03E::
Data_00E_66B0:: ; address name
    dw $005D ; id 0 Goategon
    dw $005F ; id 1 Trumpeter
    dw $0079 ; id 2 MadCondor
    dw $0080 ; id 3 FunkyBird
    dw $00DE ; id 4 ArcDemon
    dw $00DF ; id 5 Lionex
    dw $00E0 ; id 6 GoatHorn
    dw $00E2 ; id 7 Ogre
    dw $00E7 ; id 8 Akubar
    dw $0107 ; id 9 DeadNoble
    dw $0132 ; id 10 Golem
    dw $FDFD ; id 11 next result
    dw $0061 ; id 12 DarkHorn
    dw $00E8 ; id 13 MadKnight
    dw $010D ; id 14 Copycat
    dw $0133 ; id 15 StoneMan
    dw $007F ; id 16 WhipBird
    dw $FDFD ; id 17 next result
    dw $003C ; id 18 Orochi
    dw $003F ; id 19 Serpentia
    dw $FDFD ; id 20 next result
    dw $00E5 ; id 21 BossTroll
    dw $00EA ; id 22 Gigantes
    dw $FFFF ; id 23 end of list

; E-0199 (derived: list for entry $40 (Divinegon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules040::
Data_00E_66E0:: ; address name
    dw $0135 ; id 0 GoldGolem
    dw $0042 ; id 1 GigaDraco
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $47 (Tonguella) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules047::
Data_00E_66E6:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $FDFD ; id 5 next result
    dw $0004 ; id 6 TreeSlime
    dw $000C ; id 7 FangSlime
    dw $002F ; id 8 MadDragon
    dw $0080 ; id 9 FunkyBird
    dw $008D ; id 10 MadPlant
    dw $009B ; id 11 FaceTree
    dw $00B6 ; id 12 Lipsy
    dw $00D6 ; id 13 Demonite
    dw $00DD ; id 14 Gremlin
    dw $010D ; id 15 Copycat
    dw $0119 ; id 16 JewelBag
    dw $012F ; id 17 Mimic
    dw $FDFD ; id 18 next result
    dw $0077 ; id 19 LandOwl
    dw $0079 ; id 20 MadCondor
    dw $007D ; id 21 ZapBird
    dw $007F ; id 22 WhipBird
    dw $FFFF ; id 23 end of list

; E-0199 (derived: list for entry $48 (Almiraj) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules048::
Data_00E_6716:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $000B ; id 1 Healer
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $49 (CatFly) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules049::
Data_00E_671C:: ; address name
    dw $0015 ; id 0 MimeSlime
    dw $0065 ; id 1 CatMage
    dw $0099 ; id 2 TreeBoy
    dw $00C5 ; id 3 Sickler
    dw $00DC ; id 4 1EyeClown
    dw $0103 ; id 5 Reaper
    dw $011A ; id 6 EvilWand
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $4C (GulpBeast) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules04C::
Data_00E_672C:: ; address name
    dw $0004 ; id 0 TreeSlime
    dw $000C ; id 1 FangSlime
    dw $002F ; id 2 MadDragon
    dw $0080 ; id 3 FunkyBird
    dw $008D ; id 4 MadPlant
    dw $009B ; id 5 FaceTree
    dw $00B6 ; id 6 Lipsy
    dw $00D6 ; id 7 Demonite
    dw $00DD ; id 8 Gremlin
    dw $010D ; id 9 Copycat
    dw $0119 ; id 10 JewelBag
    dw $012F ; id 11 Mimic
    dw $FDFD ; id 12 next result
    dw $0077 ; id 13 LandOwl
    dw $0079 ; id 14 MadCondor
    dw $007D ; id 15 ZapBird
    dw $007F ; id 16 WhipBird
    dw $0124 ; id 17 MetalDrak
    dw $0125 ; id 18 Balzak
    dw $0129 ; id 19 Roboster
    dw $012D ; id 20 LavaMan
    dw $012E ; id 21 IceMan
    dw $0132 ; id 22 Golem
    dw $0133 ; id 23 StoneMan
    dw $FFFF ; id 24 end of list

; E-0199 (derived: list for entry $51 (SuperTen) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules051::
Data_00E_675E:: ; address name
    dw $0029 ; id 0 LizardMan
    dw $0059 ; id 1 BeastNite
    dw $00DB ; id 2 Bubblemon
    dw $00E1 ; id 3 Orc
    dw $0126 ; id 4 SabreMan
    dw $013E ; id 5 WalrusMan
    dw $0150 ; id 6 MerTiger
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $52 (IronTurt) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules052::
Data_00E_676E:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $0129 ; id 1 Roboster
    dw $012D ; id 2 LavaMan
    dw $012E ; id 3 IceMan
    dw $0132 ; id 4 Golem
    dw $0133 ; id 5 StoneMan
    dw $FDFD ; id 6 next result
    dw $0026 ; id 7 Pteranod
    dw $0027 ; id 8 Gasgon
    dw $002B ; id 9 Swordgon
    dw $002F ; id 10 MadDragon
    dw $003D ; id 11 BattleRex
    dw $003E ; id 12 SkyDragon
    dw $FFFF ; id 13 end of list

; E-0199 (derived: list for entry $54 (HammerMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules054::
Data_00E_678A:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $0029 ; id 1 LizardMan
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $55 (Grizzly) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules055::
Data_00E_6790:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $0124 ; id 5 MetalDrak
    dw $0129 ; id 6 Roboster
    dw $012D ; id 7 LavaMan
    dw $012E ; id 8 IceMan
    dw $0132 ; id 9 Golem
    dw $0133 ; id 10 StoneMan
    dw $FDFD ; id 11 next result
    dw $0077 ; id 12 LandOwl
    dw $0079 ; id 13 MadCondor
    dw $007D ; id 14 ZapBird
    dw $007F ; id 15 WhipBird
    dw $FFFF ; id 16 end of list

; E-0199 (derived: list for entry $56 (Yeti) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules056::
Data_00E_67B2:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $0124 ; id 5 MetalDrak
    dw $0129 ; id 6 Roboster
    dw $012D ; id 7 LavaMan
    dw $012E ; id 8 IceMan
    dw $0132 ; id 9 Golem
    dw $0133 ; id 10 StoneMan
    dw $FDFD ; id 11 next result
    dw $0077 ; id 12 LandOwl
    dw $0079 ; id 13 MadCondor
    dw $007D ; id 14 ZapBird
    dw $007F ; id 15 WhipBird
    dw $FFFF ; id 16 end of list

; E-0199 (derived: list for entry $57 (ArrowDog) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules057::
Data_00E_67D4:: ; address name
    dw $0073 ; id 0 Dracky
    dw $00FD ; id 1 Shadow
    dw $FDFD ; id 2 next result
    dw $FE04 ; id 3 same species, parent B +4 or more
    dw $FC04 ; id 4 same species, parent A +4 or more
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $58 (NoctoKing) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules058::
Data_00E_67E0:: ; address name
    dw $00EA ; id 0 Gigantes
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $59 (BeastNite) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules059::
Data_00E_67E4:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $0150 ; id 1 MerTiger
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $5A (MadGopher) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules05A::
Data_00E_67EA:: ; address name
    dw $0066 ; id 0 Dumbira
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $5C (Unicorn) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules05C::
Data_00E_67EE:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $0124 ; id 5 MetalDrak
    dw $0129 ; id 6 Roboster
    dw $012D ; id 7 LavaMan
    dw $012E ; id 8 IceMan
    dw $0132 ; id 9 Golem
    dw $0133 ; id 10 StoneMan
    dw $FFFF ; id 11 end of list

; E-0199 (derived: list for entry $5D (Goategon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules05D::
Data_00E_6806:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $0129 ; id 1 Roboster
    dw $012D ; id 2 LavaMan
    dw $012E ; id 3 IceMan
    dw $0132 ; id 4 Golem
    dw $0133 ; id 5 StoneMan
    dw $FDFD ; id 6 next result
    dw $0026 ; id 7 Pteranod
    dw $0027 ; id 8 Gasgon
    dw $002B ; id 9 Swordgon
    dw $002F ; id 10 MadDragon
    dw $003D ; id 11 BattleRex
    dw $003E ; id 12 SkyDragon
    dw $FFFF ; id 13 end of list

; E-0199 (derived: list for entry $5E (WildApe) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules05E::
Data_00E_6822:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $0124 ; id 5 MetalDrak
    dw $0129 ; id 6 Roboster
    dw $012D ; id 7 LavaMan
    dw $012E ; id 8 IceMan
    dw $0132 ; id 9 Golem
    dw $0133 ; id 10 StoneMan
    dw $FDFD ; id 11 next result
    dw $0026 ; id 12 Pteranod
    dw $0027 ; id 13 Gasgon
    dw $002B ; id 14 Swordgon
    dw $002F ; id 15 MadDragon
    dw $003D ; id 16 BattleRex
    dw $003E ; id 17 SkyDragon
    dw $FDFD ; id 18 next result
    dw $005E ; id 19 WildApe
    dw $FFFF ; id 20 end of list

; E-0199 (derived: list for entry $5F (Trumpeter) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules05F::
Data_00E_684C:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $0129 ; id 5 Roboster
    dw $012D ; id 6 LavaMan
    dw $012E ; id 7 IceMan
    dw $0132 ; id 8 Golem
    dw $0133 ; id 9 StoneMan
    dw $FDFD ; id 10 next result
    dw $005F ; id 11 Trumpeter
    dw $00E5 ; id 12 BossTroll
    dw $0124 ; id 13 MetalDrak
    dw $0125 ; id 14 Balzak
    dw $0135 ; id 15 GoldGolem
    dw $FBFB ; id 16 next result when wArg1 = 2, else end of list
    dw $007E ; id 17 Garudian
    dw $FFFF ; id 18 end of list

; E-0199 (derived: list for entry $61 (DarkHorn) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules061::
Data_00E_6872:: ; address name
    dw $003C ; id 0 Orochi
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $62 (MadCat) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules062::
Data_00E_6876:: ; address name
    dw $0026 ; id 0 Pteranod
    dw $0027 ; id 1 Gasgon
    dw $002B ; id 2 Swordgon
    dw $002F ; id 3 MadDragon
    dw $003D ; id 4 BattleRex
    dw $003E ; id 5 SkyDragon
    dw $FBFB ; id 6 next result when wArg1 = 2, else end of list
    dw $00F0 ; id 7 LampGenie
    dw $FFFF ; id 8 end of list

; E-0199 (derived: list for entry $65 (CatMage) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules065::
Data_00E_6888:: ; address name
    dw $005C ; id 0 Unicorn
    dw $005D ; id 1 Goategon
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $66 (Dumbira) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules066::
Data_00E_688E:: ; address name
    dw $00C7 ; id 0 Digster
    dw $00F7 ; id 1 Skullgon
    dw $0107 ; id 2 DeadNoble
    dw $0108 ; id 3 WhiteKing
    dw $010A ; id 4 Skeletor
    dw $0124 ; id 5 MetalDrak
    dw $0129 ; id 6 Roboster
    dw $012D ; id 7 LavaMan
    dw $012E ; id 8 IceMan
    dw $0132 ; id 9 Golem
    dw $0133 ; id 10 StoneMan
    dw $FDFD ; id 11 next result
    dw $007B ; id 12 Blizzardy
    dw $FFFF ; id 13 end of list

; E-0199 (derived: list for entry $6C (BullBird) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules06C::
Data_00E_68AA:: ; address name
    dw $0055 ; id 0 Grizzly
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $6F (MadPecker) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules06F::
Data_00E_68AE:: ; address name
    dw $0063 ; id 0 BigEye
    dw $00D7 ; id 1 DarkEye
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $72 (AquaHawk) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules072::
Data_00E_68B4:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $003A ; id 1 WingSnake
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $74 (KiteHawk) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules074::
Data_00E_68BA:: ; address name
    dw $0075 ; id 0 BigRoost
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $77 (LandOwl) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules077::
Data_00E_68BE:: ; address name
    dw $000D ; id 0 RockSlime
    dw $000E ; id 1 SlimeBorg
    dw $00C7 ; id 2 Digster
    dw $0124 ; id 3 MetalDrak
    dw $0132 ; id 4 Golem
    dw $0133 ; id 5 StoneMan
    dw $0142 ; id 6 Merman
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $78 (MadGoose) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules078::
Data_00E_68CE:: ; address name
    dw $000D ; id 0 RockSlime
    dw $000E ; id 1 SlimeBorg
    dw $00C7 ; id 2 Digster
    dw $0124 ; id 3 MetalDrak
    dw $0132 ; id 4 Golem
    dw $0133 ; id 5 StoneMan
    dw $0142 ; id 6 Merman
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $79 (MadCondor) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules079::
Data_00E_68DE:: ; address name
    dw $006F ; id 0 MadPecker
    dw $FDFD ; id 1 next result
    dw $012C ; id 2 Gismo
    dw $FDFD ; id 3 next result
    dw $000D ; id 4 RockSlime
    dw $000E ; id 5 SlimeBorg
    dw $00C7 ; id 6 Digster
    dw $0124 ; id 7 MetalDrak
    dw $0132 ; id 8 Golem
    dw $0133 ; id 9 StoneMan
    dw $0142 ; id 10 Merman
    dw $FFFF ; id 11 end of list

; E-0199 (derived: list for entry $7B (Blizzardy) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules07B::
Data_00E_68F6:: ; address name
    dw $00DF ; id 0 Lionex
    dw $FDFD ; id 1 next result
    dw $000D ; id 2 RockSlime
    dw $000E ; id 3 SlimeBorg
    dw $00C7 ; id 4 Digster
    dw $0124 ; id 5 MetalDrak
    dw $0132 ; id 6 Golem
    dw $0133 ; id 7 StoneMan
    dw $0142 ; id 8 Merman
    dw $FDFD ; id 9 next result
    dw $0035 ; id 10 Vampirus
    dw $007C ; id 11 Phoenix
    dw $FFFF ; id 12 end of list

; E-0199 (derived: list for entry $7C (Phoenix) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules07C::
Data_00E_6910:: ; address name
    dw $012C ; id 0 Gismo
    dw $FDFD ; id 1 next result
    dw $00DF ; id 2 Lionex
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $7D (ZapBird) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules07D::
Data_00E_6918:: ; address name
    dw $00DF ; id 0 Lionex
    dw $FDFD ; id 1 next result
    dw $000D ; id 2 RockSlime
    dw $000E ; id 3 SlimeBorg
    dw $00C7 ; id 4 Digster
    dw $0124 ; id 5 MetalDrak
    dw $0132 ; id 6 Golem
    dw $0133 ; id 7 StoneMan
    dw $0142 ; id 8 Merman
    dw $FFFF ; id 9 end of list

; E-0199 (derived: list for entry $7E (Garudian) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules07E::
Data_00E_692C:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $005F ; id 1 Trumpeter
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $7F (WhipBird) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules07F::
Data_00E_6932:: ; address name
    dw $012C ; id 0 Gismo
    dw $FDFD ; id 1 next result
    dw $0038 ; id 2 GreatDrak
    dw $00ED ; id 3 Jamirus
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $80 (FunkyBird) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules080::
Data_00E_693C:: ; address name
    dw $00ED ; id 0 Jamirus
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $81 (RainHawk) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules081::
Data_00E_6940:: ; address name
    dw $0135 ; id 0 GoldGolem
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $83 (Shantak) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules083::
Data_00E_6944:: ; address name
    dw $0135 ; id 0 GoldGolem
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $84 (CragDevil) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules084::
Data_00E_6948:: ; address name
    dw $006E ; id 0 DuckKite
    dw $0070 ; id 1 MadRaven
    dw $FDFD ; id 2 next result
    dw $FE04 ; id 3 same species, parent B +4 or more
    dw $FC04 ; id 4 same species, parent A +4 or more
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $96 (Stubsuck) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules096::
Data_00E_6954:: ; address name
    dw $0121 ; id 0 Puppetor
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $99 (TreeBoy) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules099::
Data_00E_6958:: ; address name
    dw $0006 ; id 0 SlimeNite
    dw $0054 ; id 1 HammerMan
    dw $0059 ; id 2 BeastNite
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $9E (EvilSeed) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules09E::
Data_00E_6960:: ; address name
    dw $0095 ; id 0 Slurperon
    dw $009E ; id 1 EvilSeed
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $9F (ManEater) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules09F::
Data_00E_6966:: ; address name
    dw $009F ; id 0 ManEater
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $A1 (GhosTree) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0A1::
Data_00E_696A:: ; address name
    dw $00A1 ; id 0 GhosTree
    dw $FDFD ; id 1 next result
    dw $00A0 ; id 2 Snapper
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $A2 (Rosevine) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0A2::
Data_00E_6972:: ; address name
    dw $00EA ; id 0 Gigantes
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $A4 (Warubou) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0A4::
Data_00E_6976:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $00A5 ; id 1 Watabou
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $A7 (FooHero) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0A7::
Data_00E_697C:: ; address name
    dw $011A ; id 0 EvilWand
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $B1 (Catapila) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0B1::
Data_00E_6980:: ; address name
    dw $00B1 ; id 0 Catapila

; E-0199 (derived: list for entry $B3 (Butterfly) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0B3::
Data_00E_6982:: ; address name
    dw $00B3 ; id 0 Butterfly
    dw $FDFD ; id 1 next result
    dw $00B8 ; id 2 Pyuro
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $B4 (WeedBug) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0B4::
Data_00E_698A:: ; address name
    dw $0140 ; id 0 Anemon
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $B6 (Lipsy) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0B6::
Data_00E_698E:: ; address name
    dw $0141 ; id 0 Aquarella
    dw $0143 ; id 1 Octokid
    dw $0146 ; id 2 Angleron
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $B7 (StagBug) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0B7::
Data_00E_6996:: ; address name
    dw $00B7 ; id 0 StagBug
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $BB (TailEater) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0BB::
Data_00E_699A:: ; address name
    dw $00BB ; id 0 TailEater
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $BD (Eyeder) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0BD::
Data_00E_699E:: ; address name
    dw $00BD ; id 0 Eyeder
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $C0 (ArmyCrab) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0C0::
Data_00E_69A2:: ; address name
    dw $014A ; id 0 Clawster
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $C1 (MadHornet) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0C1::
Data_00E_69A6:: ; address name
    dw $00BA ; id 0 GoHopper
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $C3 (WarMantis) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0C3::
Data_00E_69AA:: ; address name
    dw $0120 ; id 0 RogueNite
    dw $014B ; id 1 CancerMan
    dw $0157 ; id 2 Octoraid
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $C4 (HornBeet) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0C4::
Data_00E_69B2:: ; address name
    dw $00C4 ; id 0 HornBeet
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $C6 (Armorpion) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0C6::
Data_00E_69B6:: ; address name
    dw $0108 ; id 0 WhiteKing
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $C9 (MultiEyes) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0C9::
Data_00E_69BA:: ; address name
    dw $00B3 ; id 0 Butterfly
    dw $00B8 ; id 1 Pyuro
    dw $FDFD ; id 2 next result
    dw $000D ; id 3 RockSlime
    dw $0025 ; id 4 Tortragon
    dw $0052 ; id 5 IronTurt
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $D5 (AgDevil) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0D5::
Data_00E_69C8:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0013 ; id 1 SpotKing
    dw $0017 ; id 2 MetalKing
    dw $0033 ; id 3 Andreal
    dw $0038 ; id 4 GreatDrak
    dw $003C ; id 5 Orochi
    dw $005F ; id 6 Trumpeter
    dw $0060 ; id 7 KingLeo
    dw $007D ; id 8 ZapBird
    dw $007E ; id 9 Garudian
    dw $007F ; id 10 WhipBird
    dw $0124 ; id 11 MetalDrak
    dw $FDFD ; id 12 next result
    dw $004C ; id 13 GulpBeast
    dw $005C ; id 14 Unicorn
    dw $00C7 ; id 15 Digster
    dw $0129 ; id 16 Roboster
    dw $013E ; id 17 WalrusMan
    dw $0150 ; id 18 MerTiger
    dw $FDFD ; id 19 next result
    dw $000E ; id 20 SlimeBorg
    dw $002B ; id 21 Swordgon
    dw $003B ; id 22 Coatol
    dw $0071 ; id 23 MistyWing
    dw $0079 ; id 24 MadCondor
    dw $00A2 ; id 25 Rosevine
    dw $00BE ; id 26 GiantMoth
    dw $00F7 ; id 27 Skullgon
    dw $0107 ; id 28 DeadNoble
    dw $0108 ; id 29 WhiteKing
    dw $0151 ; id 30 AxeShark
    dw $FFFF ; id 31 end of list

; E-0199 (derived: list for entry $D6 (Demonite) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0D6::
Data_00E_6A08:: ; address name
    dw $00D6 ; id 0 Demonite
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $D7 (DarkEye) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0D7::
Data_00E_6A0C:: ; address name
    dw $0141 ; id 0 Aquarella
    dw $0145 ; id 1 Octoreach
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $DB (Bubblemon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0DB::
Data_00E_6A12:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $00FC ; id 1 DeadNite
    dw $FDFD ; id 2 next result
    dw $012B ; id 3 EvilPot
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $DC (1EyeClown) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0DC::
Data_00E_6A1C:: ; address name
    dw $0141 ; id 0 Aquarella
    dw $0145 ; id 1 Octoreach
    dw $FDFD ; id 2 next result
    dw $00DC ; id 3 1EyeClown
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $DD (Gremlin) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0DD::
Data_00E_6A26:: ; address name
    dw $0141 ; id 0 Aquarella
    dw $0145 ; id 1 Octoreach
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $DE (ArcDemon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0DE::
Data_00E_6A2C:: ; address name
    dw $007E ; id 0 Garudian
    dw $FDFD ; id 1 next result
    dw $00E3 ; id 2 GateGuard
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $DF (Lionex) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0DF::
Data_00E_6A34:: ; address name
    dw $0015 ; id 0 MimeSlime
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $E2 (Ogre) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0E2::
Data_00E_6A38:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $0125 ; id 1 Balzak
    dw $0133 ; id 2 StoneMan
    dw $013E ; id 3 WalrusMan
    dw $FDFD ; id 4 next result
    dw $012D ; id 5 LavaMan
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $E5 (BossTroll) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0E5::
Data_00E_6A46:: ; address name
    dw $012E ; id 0 IceMan
    dw $FBFB ; id 1 next result when wArg1 = 2, else end of list
    dw $0127 ; id 2 CurseLamp
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $E6 (Grendal) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0E6::
Data_00E_6A4E:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0013 ; id 1 SpotKing
    dw $0017 ; id 2 MetalKing
    dw $0033 ; id 3 Andreal
    dw $0038 ; id 4 GreatDrak
    dw $003C ; id 5 Orochi
    dw $005F ; id 6 Trumpeter
    dw $0060 ; id 7 KingLeo
    dw $007D ; id 8 ZapBird
    dw $007E ; id 9 Garudian
    dw $007F ; id 10 WhipBird
    dw $0124 ; id 11 MetalDrak
    dw $FDFD ; id 12 next result
    dw $004C ; id 13 GulpBeast
    dw $005C ; id 14 Unicorn
    dw $00C7 ; id 15 Digster
    dw $0129 ; id 16 Roboster
    dw $013E ; id 17 WalrusMan
    dw $0150 ; id 18 MerTiger
    dw $FDFD ; id 19 next result
    dw $000E ; id 20 SlimeBorg
    dw $002B ; id 21 Swordgon
    dw $003B ; id 22 Coatol
    dw $0071 ; id 23 MistyWing
    dw $0079 ; id 24 MadCondor
    dw $00A2 ; id 25 Rosevine
    dw $00BE ; id 26 GiantMoth
    dw $00F7 ; id 27 Skullgon
    dw $0107 ; id 28 DeadNoble
    dw $0108 ; id 29 WhiteKing
    dw $0151 ; id 30 AxeShark
    dw $FDFD ; id 31 next result
    dw $00E6 ; id 32 Grendal
    dw $FBFB ; id 33 next result when wArg1 = 2, else end of list
    dw $010A ; id 34 Skeletor
    dw $FFFF ; id 35 end of list

; E-0199 (derived: list for entry $E7 (Akubar) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0E7::
Data_00E_6A96:: ; address name
    dw $0081 ; id 0 RainHawk
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $EA (Gigantes) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0EA::
Data_00E_6A9A:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0013 ; id 1 SpotKing
    dw $0017 ; id 2 MetalKing
    dw $0033 ; id 3 Andreal
    dw $0038 ; id 4 GreatDrak
    dw $003C ; id 5 Orochi
    dw $005F ; id 6 Trumpeter
    dw $0060 ; id 7 KingLeo
    dw $007D ; id 8 ZapBird
    dw $007E ; id 9 Garudian
    dw $007F ; id 10 WhipBird
    dw $0124 ; id 11 MetalDrak
    dw $FDFD ; id 12 next result
    dw $004C ; id 13 GulpBeast
    dw $005C ; id 14 Unicorn
    dw $00C7 ; id 15 Digster
    dw $0129 ; id 16 Roboster
    dw $013E ; id 17 WalrusMan
    dw $0150 ; id 18 MerTiger
    dw $FDFD ; id 19 next result
    dw $000E ; id 20 SlimeBorg
    dw $002B ; id 21 Swordgon
    dw $003B ; id 22 Coatol
    dw $0071 ; id 23 MistyWing
    dw $0079 ; id 24 MadCondor
    dw $00A2 ; id 25 Rosevine
    dw $00BE ; id 26 GiantMoth
    dw $00F7 ; id 27 Skullgon
    dw $0107 ; id 28 DeadNoble
    dw $0108 ; id 29 WhiteKing
    dw $0151 ; id 30 AxeShark
    dw $FFFF ; id 31 end of list

; E-0199 (derived: list for entry $EB (Centasaur) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0EB::
Data_00E_6ADA:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $0125 ; id 1 Balzak
    dw $0133 ; id 2 StoneMan
    dw $013E ; id 3 WalrusMan
    dw $FDFD ; id 4 next result
    dw $0135 ; id 5 GoldGolem
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $ED (Jamirus) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0ED::
Data_00E_6AE8:: ; address name
    dw $003F ; id 0 Serpentia
    dw $FDFD ; id 1 next result
    dw $00A2 ; id 2 Rosevine
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $EE (Durran) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0EE::
Data_00E_6AF0:: ; address name
    dw $0061 ; id 0 DarkHorn
    dw $FDFD ; id 1 next result
    dw $0040 ; id 2 Divinegon
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $F0 (LampGenie) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0F0::
Data_00E_6AF8:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $0062 ; id 1 MadCat
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $F7 (Skullgon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0F7::
Data_00E_6AFE:: ; address name
    dw $010D ; id 0 Copycat
    dw $FDFD ; id 1 next result
    dw $0010 ; id 2 KingSlime
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $F8 (PutrePup) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0F8::
Data_00E_6B06:: ; address name
    dw $0071 ; id 0 MistyWing
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $FA (Mummy) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0FA::
Data_00E_6B0A:: ; address name
    dw $000D ; id 0 RockSlime
    dw $000E ; id 1 SlimeBorg
    dw $0077 ; id 2 LandOwl
    dw $0078 ; id 3 MadGoose
    dw $008F ; id 4 FloraMan
    dw $00C4 ; id 5 HornBeet
    dw $00DD ; id 6 Gremlin
    dw $FDFD ; id 7 next result
    dw $004C ; id 8 GulpBeast
    dw $0055 ; id 9 Grizzly
    dw $0062 ; id 10 MadCat
    dw $0070 ; id 11 MadRaven
    dw $0079 ; id 12 MadCondor
    dw $00DA ; id 13 EvilBeast
    dw $00E2 ; id 14 Ogre
    dw $0132 ; id 15 Golem
    dw $0133 ; id 16 StoneMan
    dw $FFFF ; id 17 end of list

; E-0199 (derived: list for entry $FC (DeadNite) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0FC::
Data_00E_6B2E:: ; address name
    dw $00FC ; id 0 DeadNite
    dw $010D ; id 1 Copycat
    dw $FDFD ; id 2 next result
    dw $000D ; id 3 RockSlime
    dw $000E ; id 4 SlimeBorg
    dw $0077 ; id 5 LandOwl
    dw $0078 ; id 6 MadGoose
    dw $008F ; id 7 FloraMan
    dw $00C4 ; id 8 HornBeet
    dw $00DD ; id 9 Gremlin
    dw $FDFD ; id 10 next result
    dw $004C ; id 11 GulpBeast
    dw $0055 ; id 12 Grizzly
    dw $0062 ; id 13 MadCat
    dw $0070 ; id 14 MadRaven
    dw $0079 ; id 15 MadCondor
    dw $00DA ; id 16 EvilBeast
    dw $00E2 ; id 17 Ogre
    dw $0132 ; id 18 Golem
    dw $0133 ; id 19 StoneMan
    dw $FBFB ; id 20 next result when wArg1 = 2, else end of list
    dw $00DB ; id 21 Bubblemon
    dw $FFFF ; id 22 end of list

; E-0199 (derived: list for entry $FF (Hork) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules0FF::
Data_00E_6B5C:: ; address name
    dw $00FF ; id 0 Hork
    dw $FDFD ; id 1 next result
    dw $004C ; id 2 GulpBeast
    dw $0055 ; id 3 Grizzly
    dw $0062 ; id 4 MadCat
    dw $0070 ; id 5 MadRaven
    dw $0079 ; id 6 MadCondor
    dw $00DA ; id 7 EvilBeast
    dw $00E2 ; id 8 Ogre
    dw $0132 ; id 9 Golem
    dw $0133 ; id 10 StoneMan
    dw $FFFF ; id 11 end of list

; E-0199 (derived: list for entry $100 (Mudron) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules100::
Data_00E_6B74:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00DF ; id 1 Lionex
    dw $00E3 ; id 2 GateGuard
    dw $010D ; id 3 Copycat
    dw $0124 ; id 4 MetalDrak
    dw $0129 ; id 5 Roboster
    dw $FDFD ; id 6 next result
    dw $004C ; id 7 GulpBeast
    dw $0055 ; id 8 Grizzly
    dw $0062 ; id 9 MadCat
    dw $0070 ; id 10 MadRaven
    dw $0079 ; id 11 MadCondor
    dw $00DA ; id 12 EvilBeast
    dw $00E2 ; id 13 Ogre
    dw $0132 ; id 14 Golem
    dw $0133 ; id 15 StoneMan
    dw $FFFF ; id 16 end of list

; E-0199 (derived: list for entry $101 (NiteWhip) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules101::
Data_00E_6B96:: ; address name
    dw $013D ; id 0 Moray
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $106 (CaptDead) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules106::
Data_00E_6B9A:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00DF ; id 1 Lionex
    dw $00E3 ; id 2 GateGuard
    dw $010D ; id 3 Copycat
    dw $0124 ; id 4 MetalDrak
    dw $0129 ; id 5 Roboster
    dw $FDFD ; id 6 next result
    dw $004C ; id 7 GulpBeast
    dw $0055 ; id 8 Grizzly
    dw $0062 ; id 9 MadCat
    dw $0070 ; id 10 MadRaven
    dw $0079 ; id 11 MadCondor
    dw $00DA ; id 12 EvilBeast
    dw $00E2 ; id 13 Ogre
    dw $0132 ; id 14 Golem
    dw $0133 ; id 15 StoneMan
    dw $FFFF ; id 16 end of list

; E-0199 (derived: list for entry $107 (DeadNoble) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules107::
Data_00E_6BBC:: ; address name
    dw $0013 ; id 0 SpotKing
    dw $FDFD ; id 1 next result
    dw $003F ; id 2 Serpentia
    dw $012A ; id 3 Roboster2
    dw $0157 ; id 4 Octoraid
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $108 (WhiteKing) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules108::
Data_00E_6BC8:: ; address name
    dw $015F ; id 0 DracoLord
    dw $FDFD ; id 1 next result
    dw $0017 ; id 2 MetalKing
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $109 (BoneSlave) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules109::
Data_00E_6BD0:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00DF ; id 1 Lionex
    dw $00E3 ; id 2 GateGuard
    dw $010D ; id 3 Copycat
    dw $0124 ; id 4 MetalDrak
    dw $0129 ; id 5 Roboster
    dw $FDFD ; id 6 next result
    dw $0017 ; id 7 MetalKing
    dw $FDFD ; id 8 next result
    dw $0109 ; id 9 BoneSlave
    dw $FFFF ; id 10 end of list

; E-0199 (derived: list for entry $10A (Skeletor) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules10A::
Data_00E_6BE6:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00DF ; id 1 Lionex
    dw $00E3 ; id 2 GateGuard
    dw $010D ; id 3 Copycat
    dw $0124 ; id 4 MetalDrak
    dw $0129 ; id 5 Roboster
    dw $FDFD ; id 6 next result
    dw $0033 ; id 7 Andreal
    dw $0038 ; id 8 GreatDrak
    dw $0060 ; id 9 KingLeo
    dw $007B ; id 10 Blizzardy
    dw $007D ; id 11 ZapBird
    dw $007F ; id 12 WhipBird
    dw $0135 ; id 13 GoldGolem
    dw $0155 ; id 14 WhaleMage
    dw $0158 ; id 15 Grakos
    dw $FDFD ; id 16 next result
    dw $010A ; id 17 Skeletor
    dw $FDFD ; id 18 next result
    dw $003F ; id 19 Serpentia
    dw $012A ; id 20 Roboster2
    dw $0157 ; id 21 Octoraid
    dw $FBFB ; id 22 next result when wArg1 = 2, else end of list
    dw $00E6 ; id 23 Grendal
    dw $FFFF ; id 24 end of list

; E-0199 (derived: list for entry $10B (Servant) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules10B::
Data_00E_6C18:: ; address name
    dw $0033 ; id 0 Andreal
    dw $0038 ; id 1 GreatDrak
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $10D (Copycat) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules10D::
Data_00E_6C1E:: ; address name
    dw $0027 ; id 0 Gasgon
    dw $00BF ; id 1 Droll
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $10E (MadSpirit) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules10E::
Data_00E_6C24:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00DF ; id 1 Lionex
    dw $00E3 ; id 2 GateGuard
    dw $0124 ; id 3 MetalDrak
    dw $0129 ; id 4 Roboster
    dw $012A ; id 5 Roboster2
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $110 (Niterich) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules110::
Data_00E_6C32:: ; address name
    dw $0033 ; id 0 Andreal
    dw $0038 ; id 1 GreatDrak
    dw $0060 ; id 2 KingLeo
    dw $007B ; id 3 Blizzardy
    dw $007D ; id 4 ZapBird
    dw $007F ; id 5 WhipBird
    dw $0135 ; id 6 GoldGolem
    dw $0155 ; id 7 WhaleMage
    dw $0158 ; id 8 Grakos
    dw $FFFF ; id 9 end of list

; E-0199 (derived: list for entry $11A (EvilWand) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules11A::
Data_00E_6C46:: ; address name
    dw $0077 ; id 0 LandOwl
    dw $0078 ; id 1 MadGoose
    dw $007C ; id 2 Phoenix
    dw $0080 ; id 3 FunkyBird
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $11B (MadCandle) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules11B::
Data_00E_6C50:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $006B ; id 1 Wyvern
    dw $0071 ; id 2 MistyWing
    dw $008E ; id 3 FireWeed
    dw $009E ; id 4 EvilSeed
    dw $0140 ; id 5 Anemon
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $11E (SpikyBoy) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules11E::
Data_00E_6C5E:: ; address name
    dw $011E ; id 0 SpikyBoy
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $11F (MadMirror) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules11F::
Data_00E_6C62:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $006B ; id 1 Wyvern
    dw $0071 ; id 2 MistyWing
    dw $008E ; id 3 FireWeed
    dw $009E ; id 4 EvilSeed
    dw $0140 ; id 5 Anemon
    dw $FFFF ; id 6 end of list

; E-0199 (derived: list for entry $121 (Puppetor) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules121::
Data_00E_6C70:: ; address name
    dw $00D3 ; id 0 Pixy
    dw $00D6 ; id 1 Demonite
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $122 (Goopi) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules122::
Data_00E_6C76:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $006B ; id 1 Wyvern
    dw $0071 ; id 2 MistyWing
    dw $008E ; id 3 FireWeed
    dw $009E ; id 4 EvilSeed
    dw $0140 ; id 5 Anemon
    dw $FDFD ; id 6 next result
    dw $0122 ; id 7 Goopi
    dw $014B ; id 8 CancerMan
    dw $FFFF ; id 9 end of list

; E-0199 (derived: list for entry $123 (Voodoll) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules123::
Data_00E_6C8A:: ; address name
    dw $0077 ; id 0 LandOwl
    dw $0078 ; id 1 MadGoose
    dw $007C ; id 2 Phoenix
    dw $0080 ; id 3 FunkyBird
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $124 (MetalDrak) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules124::
Data_00E_6C94:: ; address name
    dw $003C ; id 0 Orochi
    dw $0060 ; id 1 KingLeo
    dw $007D ; id 2 ZapBird
    dw $00DE ; id 3 ArcDemon
    dw $00E5 ; id 4 BossTroll
    dw $00EB ; id 5 Centasaur
    dw $FDFD ; id 6 next result
    dw $00F7 ; id 7 Skullgon
    dw $0108 ; id 8 WhiteKing
    dw $FFFF ; id 9 end of list

; E-0199 (derived: list for entry $126 (SabreMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules126::
Data_00E_6CA8:: ; address name
    dw $000E ; id 0 SlimeBorg
    dw $0038 ; id 1 GreatDrak
    dw $005C ; id 2 Unicorn
    dw $00E2 ; id 3 Ogre
    dw $00E6 ; id 4 Grendal
    dw $00EC ; id 5 EvilArmor
    dw $0107 ; id 6 DeadNoble
    dw $010A ; id 7 Skeletor
    dw $FFFF ; id 8 end of list

; E-0199 (derived: list for entry $127 (CurseLamp) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules127::
Data_00E_6CBA:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $00E5 ; id 1 BossTroll
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $129 (Roboster) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules129::
Data_00E_6CC0:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $FDFD ; id 1 next result
    dw $FE05 ; id 2 same species, parent B +5 or more
    dw $FC05 ; id 3 same species, parent A +5 or more
    dw $FDFD ; id 4 next result
    dw $0060 ; id 5 KingLeo
    dw $FDFD ; id 6 next result
    dw $0148 ; id 7 RushFish
    dw $FBFB ; id 8 next result when wArg1 = 2, else end of list
    dw $0129 ; id 9 Roboster
    dw $FFFF ; id 10 end of list

; E-0199 (derived: list for entry $12A (Roboster2) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules12A::
Data_00E_6CD6:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $FDFD ; id 1 next result
    dw $0060 ; id 2 KingLeo
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $12B (EvilPot) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules12B::
Data_00E_6CDE:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $00DB ; id 1 Bubblemon
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $12C (Gismo) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules12C::
Data_00E_6CE4:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0013 ; id 1 SpotKing
    dw $003E ; id 2 SkyDragon
    dw $00F0 ; id 3 LampGenie
    dw $0108 ; id 4 WhiteKing
    dw $0153 ; id 5 KingSquid
    dw $0155 ; id 6 WhaleMage
    dw $015F ; id 7 DracoLord
    dw $FFFF ; id 8 end of list

; E-0199 (derived: list for entry $12D (LavaMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules12D::
Data_00E_6CF6:: ; address name
    dw $00E5 ; id 0 BossTroll
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $12E (IceMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules12E::
Data_00E_6CFA:: ; address name
    dw $012D ; id 0 LavaMan
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $12F (Mimic) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules12F::
Data_00E_6CFE:: ; address name
    dw $014D ; id 0 Scallopa
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $131 (MudDoll) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules131::
Data_00E_6D02:: ; address name
    dw $0131 ; id 0 MudDoll
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $132 (Golem) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules132::
Data_00E_6D06:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0005 ; id 1 Snaily
    dw $0006 ; id 2 SlimeNite
    dw $000D ; id 3 RockSlime
    dw $FDFD ; id 4 next result
    dw $0077 ; id 5 LandOwl
    dw $0078 ; id 6 MadGoose
    dw $007C ; id 7 Phoenix
    dw $0080 ; id 8 FunkyBird
    dw $FDFD ; id 9 next result
    dw $0132 ; id 10 Golem
    dw $FFFF ; id 11 end of list

; E-0199 (derived: list for entry $133 (StoneMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules133::
Data_00E_6D1E:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0005 ; id 1 Snaily
    dw $0006 ; id 2 SlimeNite
    dw $000D ; id 3 RockSlime
    dw $FDFD ; id 4 next result
    dw $0033 ; id 5 Andreal
    dw $0037 ; id 6 Spikerous
    dw $0038 ; id 7 GreatDrak
    dw $FDFD ; id 8 next result
    dw $0077 ; id 9 LandOwl
    dw $0078 ; id 10 MadGoose
    dw $007C ; id 11 Phoenix
    dw $0080 ; id 12 FunkyBird
    dw $FFFF ; id 13 end of list

; E-0199 (derived: list for entry $135 (GoldGolem) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules135::
Data_00E_6D3A:: ; address name
    dw $0017 ; id 0 MetalKing
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $141 (Aquarella) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules141::
Data_00E_6D3E:: ; address name
    dw $00D7 ; id 0 DarkEye
    dw $00D4 ; id 1 MedusaEye
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $142 (Merman) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules142::
Data_00E_6D44:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0062 ; id 1 MadCat
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $145 (Octoreach) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules145::
Data_00E_6D4A:: ; address name
    dw $FE05 ; id 0 same species, parent B +5 or more
    dw $FC05 ; id 1 same species, parent A +5 or more
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $146 (Angleron) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules146::
Data_00E_6D50:: ; address name
    dw $00D3 ; id 0 Pixy
    dw $00D6 ; id 1 Demonite
    dw $00D9 ; id 2 SkulRider
    dw $00DD ; id 3 Gremlin
    dw $FDFD ; id 4 next result
    dw $004C ; id 5 GulpBeast
    dw $00BF ; id 6 Droll
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $148 (RushFish) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules148::
Data_00E_6D60:: ; address name
    dw $0037 ; id 0 Spikerous
    dw $014C ; id 1 RogueWave
    dw $0078 ; id 2 MadGoose
    dw $00EA ; id 3 Gigantes
    dw $0132 ; id 4 Golem
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $149 (Gamanian) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules149::
Data_00E_6D6C:: ; address name
    dw $00C0 ; id 0 ArmyCrab
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $14A (Clawster) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules14A::
Data_00E_6D70:: ; address name
    dw $014A ; id 0 Clawster
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $14B (CancerMan) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules14B::
Data_00E_6D74:: ; address name
    dw $011A ; id 0 EvilWand
    dw $0155 ; id 1 WhaleMage
    dw $FDFD ; id 2 next result
    dw $003D ; id 3 BattleRex
    dw $00DE ; id 4 ArcDemon
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $14C (RogueWave) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules14C::
Data_00E_6D80:: ; address name
    dw $012F ; id 0 Mimic
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $14F (HoodSquid) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules14F::
Data_00E_6D84:: ; address name
    dw $00DC ; id 0 1EyeClown
    dw $0103 ; id 1 Reaper
    dw $0148 ; id 2 RushFish
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $150 (MerTiger) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules150::
Data_00E_6D8C:: ; address name
    dw $FBFB ; id 0 next result when wArg1 = 2, else end of list
    dw $0059 ; id 1 BeastNite
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $152 (Octogon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules152::
Data_00E_6D92:: ; address name
    dw $00DF ; id 0 Lionex
    dw $00E3 ; id 1 GateGuard
    dw $00E4 ; id 2 ChopClown
    dw $00EC ; id 3 EvilArmor
    dw $FDFD ; id 4 next result
    dw $FE05 ; id 5 same species, parent B +5 or more
    dw $FC05 ; id 6 same species, parent A +5 or more
    dw $FFFF ; id 7 end of list

; E-0199 (derived: list for entry $154 (Digong) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules154::
Data_00E_6DA2:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $003B ; id 1 Coatol
    dw $0041 ; id 2 Orligon
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $158 (Grakos) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules158::
Data_00E_6DAA:: ; address name
    dw $016D ; id 0 Mudou
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $15F (DracoLord) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules15F::
Data_00E_6DAE:: ; address name
    dw $0040 ; id 0 Divinegon
    dw $FDFD ; id 1 next result
    dw $0163 ; id 2 Sidoh
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $160 (DracoLord) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules160::
Data_00E_6DB6:: ; address name
    dw $0041 ; id 0 Orligon
    dw $FDFD ; id 1 next result
    dw $0163 ; id 2 Sidoh
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $162 (Hargon) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules162::
Data_00E_6DBE:: ; address name
    dw $003C ; id 0 Orochi
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $163 (Sidoh) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules163::
Data_00E_6DC2:: ; address name
    dw $00EF ; id 0 Titanis
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $165 (Baramos) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules165::
Data_00E_6DC6:: ; address name
    dw $0061 ; id 0 DarkHorn
    dw $0064 ; id 1 Gorago
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $166 (Zoma) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules166::
Data_00E_6DCC:: ; address name
    dw $0169 ; id 0 PsychoPiz
    dw $FDFD ; id 1 next result
    dw $0082 ; id 2 Azurile
    dw $016B ; id 3 Mirudraas
    dw $016C ; id 4 Mirudraas
    dw $FFFF ; id 5 end of list

; E-0199 (derived: list for entry $168 (Pizzaro) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules168::
Data_00E_6DD8:: ; address name
    dw $016A ; id 0 Esterk
    dw $FDFD ; id 1 next result
    dw $0060 ; id 2 KingLeo
    dw $0064 ; id 3 Gorago
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $169 (PsychoPiz) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules169::
Data_00E_6DE2:: ; address name
    dw $0110 ; id 0 Niterich
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $16A (Esterk) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules16A::
Data_00E_6DE6:: ; address name
    dw $0018 ; id 0 GoldSlime
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $16B (Mirudraas) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules16B::
Data_00E_6DEA:: ; address name
    dw $0037 ; id 0 Spikerous
    dw $0041 ; id 1 Orligon
    dw $FDFD ; id 2 next result
    dw $0082 ; id 3 Azurile
    dw $FFFF ; id 4 end of list

; E-0199 (derived: list for entry $16C (Mirudraas) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules16C::
Data_00E_6DF4:: ; address name
    dw $0166 ; id 0 Zoma
    dw $FFFF ; id 1 end of list

; E-0199 (derived: list for entry $16E (DeathMore) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules16E::
Data_00E_6DF8:: ; address name
    dw $00C6 ; id 0 Armorpion
    dw $00EF ; id 1 Titanis
    dw $FFFF ; id 2 end of list

; E-0199 (derived: list for entry $16F (DeathMore) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules16F::
Data_00E_6DFE:: ; address name
    dw $0136 ; id 0 DarkMate
    dw $0159 ; id 1 Poseidon
    dw $016D ; id 2 Mudou
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $170 (DeathMore) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules170::
Data_00E_6E06:: ; address name
    dw $0019 ; id 0 GranSlime
    dw $00A5 ; id 1 Watabou
    dw $0167 ; id 2 AsuraZoma
    dw $FFFF ; id 3 end of list

; E-0199 (derived: list for entry $172 (Orgodemir) of BreedSpeciesRuleTable; it runs to the next list)
; record: partner species or rule code
BreedSpeciesRules172::
Data_00E_6E0E:: ; address name
    dw $0161 ; id 0 LordDraco
    dw $0042 ; id 1 GigaDraco
    dw $FFFF ; id 2 end of list

; E-0199 (C1: stage 1 result lists, indexed like BreedSpeciesRuleTable; the matched result word becomes the child's species (wArg6/wArg7))
; record: list
BreedSpeciesResultTable::
Data_00E_6E14:: ; address name
    dw BreedSpeciesResults000 ; id 0
    dw BreedSpeciesResults001 ; id 1 DrakSlime
    dw BreedSpeciesResults002 ; id 2 SpotSlime
    dw BreedSpeciesResults003 ; id 3 WingSlime
    dw BreedSpeciesResults003 ; id 4 TreeSlime
    dw BreedSpeciesResults003 ; id 5 Snaily
    dw BreedSpeciesResults003 ; id 6 SlimeNite
    dw BreedSpeciesResults007 ; id 7 Babble
    dw BreedSpeciesResults007 ; id 8 BoxSlime
    dw BreedSpeciesResults007 ; id 9 PearlGel
    dw BreedSpeciesResults007 ; id 10 Slime
    dw BreedSpeciesResults00B ; id 11 Healer
    dw BreedSpeciesResults00C ; id 12 FangSlime
    dw BreedSpeciesResults00C ; id 13 RockSlime
    dw BreedSpeciesResults00E ; id 14 SlimeBorg
    dw BreedSpeciesResults00E ; id 15 Slabbit
    dw BreedSpeciesResults00E ; id 16 KingSlime
    dw BreedSpeciesResults011 ; id 17 Metaly
    dw BreedSpeciesResults012 ; id 18 Metabble
    dw BreedSpeciesResults013 ; id 19 SpotKing
    dw BreedSpeciesResults014 ; id 20 TropicGel
    dw BreedSpeciesResults014 ; id 21 MimeSlime
    dw BreedSpeciesResults016 ; id 22 HaloSlime
    dw BreedSpeciesResults016 ; id 23 MetalKing
    dw BreedSpeciesResults018 ; id 24 GoldSlime
    dw BreedSpeciesResults019 ; id 25 GranSlime
    dw BreedSpeciesResults019 ; id 26 WonderEgg
    dw BreedSpeciesResults01B ; id 27 Butch
    dw BreedSpeciesResults01B ; id 28 ?
    dw BreedSpeciesResults01B ; id 29 ?
    dw BreedSpeciesResults01B ; id 30 ?
    dw BreedSpeciesResults01B ; id 31 ?
    dw BreedSpeciesResults01B ; id 32 ?
    dw BreedSpeciesResults01B ; id 33 ?
    dw BreedSpeciesResults01B ; id 34 ?
    dw BreedSpeciesResults01B ; id 35 ?
    dw BreedSpeciesResults01B ; id 36 DragonKid
    dw BreedSpeciesResults025 ; id 37 Tortragon
    dw BreedSpeciesResults025 ; id 38 Pteranod
    dw BreedSpeciesResults027 ; id 39 Gasgon
    dw BreedSpeciesResults028 ; id 40 FairyDrak
    dw BreedSpeciesResults028 ; id 41 LizardMan
    dw BreedSpeciesResults02A ; id 42 Poisongon
    dw BreedSpeciesResults02A ; id 43 Swordgon
    dw BreedSpeciesResults02A ; id 44 Drygon
    dw BreedSpeciesResults02A ; id 45 Dragon
    dw BreedSpeciesResults02E ; id 46 MiniDrak
    dw BreedSpeciesResults02E ; id 47 MadDragon
    dw BreedSpeciesResults030 ; id 48 Rayburn
    dw BreedSpeciesResults030 ; id 49 Chamelgon
    dw BreedSpeciesResults030 ; id 50 LizardFly
    dw BreedSpeciesResults030 ; id 51 Andreal
    dw BreedSpeciesResults034 ; id 52 KingCobra
    dw BreedSpeciesResults035 ; id 53 Vampirus
    dw BreedSpeciesResults036 ; id 54 SnakeBat
    dw BreedSpeciesResults036 ; id 55 Spikerous
    dw BreedSpeciesResults036 ; id 56 GreatDrak
    dw BreedSpeciesResults039 ; id 57 Crestpent
    dw BreedSpeciesResults03A ; id 58 WingSnake
    dw BreedSpeciesResults03B ; id 59 Coatol
    dw BreedSpeciesResults03B ; id 60 Orochi
    dw BreedSpeciesResults03B ; id 61 BattleRex
    dw BreedSpeciesResults03E ; id 62 SkyDragon
    dw BreedSpeciesResults03F ; id 63 Serpentia
    dw BreedSpeciesResults03F ; id 64 Divinegon
    dw BreedSpeciesResults041 ; id 65 Orligon
    dw BreedSpeciesResults041 ; id 66 GigaDraco
    dw BreedSpeciesResults041 ; id 67 ?
    dw BreedSpeciesResults041 ; id 68 ?
    dw BreedSpeciesResults041 ; id 69 ?
    dw BreedSpeciesResults041 ; id 70 ?
    dw BreedSpeciesResults041 ; id 71 Tonguella
    dw BreedSpeciesResults048 ; id 72 Almiraj
    dw BreedSpeciesResults049 ; id 73 CatFly
    dw BreedSpeciesResults04A ; id 74 PillowRat
    dw BreedSpeciesResults04A ; id 75 Saccer
    dw BreedSpeciesResults04A ; id 76 GulpBeast
    dw BreedSpeciesResults04D ; id 77 Skullroo
    dw BreedSpeciesResults04D ; id 78 WindBeast
    dw BreedSpeciesResults04D ; id 79 Beavern
    dw BreedSpeciesResults04D ; id 80 Antbear
    dw BreedSpeciesResults04D ; id 81 SuperTen
    dw BreedSpeciesResults052 ; id 82 IronTurt
    dw BreedSpeciesResults053 ; id 83 Mommonja
    dw BreedSpeciesResults053 ; id 84 HammerMan
    dw BreedSpeciesResults055 ; id 85 Grizzly
    dw BreedSpeciesResults056 ; id 86 Yeti
    dw BreedSpeciesResults057 ; id 87 ArrowDog
    dw BreedSpeciesResults058 ; id 88 NoctoKing
    dw BreedSpeciesResults059 ; id 89 BeastNite
    dw BreedSpeciesResults05A ; id 90 MadGopher
    dw BreedSpeciesResults05B ; id 91 FairyRat
    dw BreedSpeciesResults05B ; id 92 Unicorn
    dw BreedSpeciesResults05D ; id 93 Goategon
    dw BreedSpeciesResults05E ; id 94 WildApe
    dw BreedSpeciesResults05F ; id 95 Trumpeter
    dw BreedSpeciesResults060 ; id 96 KingLeo
    dw BreedSpeciesResults060 ; id 97 DarkHorn
    dw BreedSpeciesResults062 ; id 98 MadCat
    dw BreedSpeciesResults063 ; id 99 BigEye
    dw BreedSpeciesResults063 ; id 100 Gorago
    dw BreedSpeciesResults063 ; id 101 CatMage
    dw BreedSpeciesResults066 ; id 102 Dumbira
    dw BreedSpeciesResults067 ; id 103 ?
    dw BreedSpeciesResults067 ; id 104 ?
    dw BreedSpeciesResults067 ; id 105 ?
    dw BreedSpeciesResults067 ; id 106 Picky
    dw BreedSpeciesResults067 ; id 107 Wyvern
    dw BreedSpeciesResults067 ; id 108 BullBird
    dw BreedSpeciesResults06D ; id 109 Florajay
    dw BreedSpeciesResults06D ; id 110 DuckKite
    dw BreedSpeciesResults06D ; id 111 MadPecker
    dw BreedSpeciesResults070 ; id 112 MadRaven
    dw BreedSpeciesResults070 ; id 113 MistyWing
    dw BreedSpeciesResults070 ; id 114 AquaHawk
    dw BreedSpeciesResults073 ; id 115 Dracky
    dw BreedSpeciesResults073 ; id 116 KiteHawk
    dw BreedSpeciesResults075 ; id 117 BigRoost
    dw BreedSpeciesResults075 ; id 118 StubBird
    dw BreedSpeciesResults075 ; id 119 LandOwl
    dw BreedSpeciesResults078 ; id 120 MadGoose
    dw BreedSpeciesResults079 ; id 121 MadCondor
    dw BreedSpeciesResults07A ; id 122 Emyu
    dw BreedSpeciesResults07A ; id 123 Blizzardy
    dw BreedSpeciesResults07C ; id 124 Phoenix
    dw BreedSpeciesResults07D ; id 125 ZapBird
    dw BreedSpeciesResults07E ; id 126 Garudian
    dw BreedSpeciesResults07F ; id 127 WhipBird
    dw BreedSpeciesResults080 ; id 128 FunkyBird
    dw BreedSpeciesResults081 ; id 129 RainHawk
    dw BreedSpeciesResults082 ; id 130 Azurile
    dw BreedSpeciesResults082 ; id 131 Shantak
    dw BreedSpeciesResults084 ; id 132 CragDevil
    dw BreedSpeciesResults085 ; id 133 ?
    dw BreedSpeciesResults085 ; id 134 ?
    dw BreedSpeciesResults085 ; id 135 ?
    dw BreedSpeciesResults085 ; id 136 ?
    dw BreedSpeciesResults085 ; id 137 ?
    dw BreedSpeciesResults085 ; id 138 ?
    dw BreedSpeciesResults085 ; id 139 ?
    dw BreedSpeciesResults085 ; id 140 ?
    dw BreedSpeciesResults085 ; id 141 MadPlant
    dw BreedSpeciesResults085 ; id 142 FireWeed
    dw BreedSpeciesResults085 ; id 143 FloraMan
    dw BreedSpeciesResults085 ; id 144 WingTree
    dw BreedSpeciesResults085 ; id 145 CactiBall
    dw BreedSpeciesResults085 ; id 146 Gulpple
    dw BreedSpeciesResults085 ; id 147 Toadstool
    dw BreedSpeciesResults085 ; id 148 AmberWeed
    dw BreedSpeciesResults085 ; id 149 Slurperon
    dw BreedSpeciesResults085 ; id 150 Stubsuck
    dw BreedSpeciesResults097 ; id 151 Oniono
    dw BreedSpeciesResults097 ; id 152 DanceVegi
    dw BreedSpeciesResults097 ; id 153 TreeBoy
    dw BreedSpeciesResults09A ; id 154 Devipine
    dw BreedSpeciesResults09A ; id 155 FaceTree
    dw BreedSpeciesResults09A ; id 156 HerbMan
    dw BreedSpeciesResults09A ; id 157 BeanMan
    dw BreedSpeciesResults09A ; id 158 EvilSeed
    dw BreedSpeciesResults09F ; id 159 ManEater
    dw BreedSpeciesResults0A0 ; id 160 Snapper
    dw BreedSpeciesResults0A0 ; id 161 GhosTree
    dw BreedSpeciesResults0A2 ; id 162 Rosevine
    dw BreedSpeciesResults0A3 ; id 163 Egdracil
    dw BreedSpeciesResults0A3 ; id 164 Warubou
    dw BreedSpeciesResults0A5 ; id 165 Watabou
    dw BreedSpeciesResults0A5 ; id 166 Eggplaton
    dw BreedSpeciesResults0A5 ; id 167 FooHero
    dw BreedSpeciesResults0A8 ; id 168 ?
    dw BreedSpeciesResults0A8 ; id 169 ?
    dw BreedSpeciesResults0A8 ; id 170 ?
    dw BreedSpeciesResults0A8 ; id 171 ?
    dw BreedSpeciesResults0A8 ; id 172 ?
    dw BreedSpeciesResults0A8 ; id 173 ?
    dw BreedSpeciesResults0A8 ; id 174 ?
    dw BreedSpeciesResults0A8 ; id 175 ?
    dw BreedSpeciesResults0A8 ; id 176 GiantSlug
    dw BreedSpeciesResults0A8 ; id 177 Catapila
    dw BreedSpeciesResults0B2 ; id 178 Gophecada
    dw BreedSpeciesResults0B2 ; id 179 Butterfly
    dw BreedSpeciesResults0B4 ; id 180 WeedBug
    dw BreedSpeciesResults0B5 ; id 181 GiantWorm
    dw BreedSpeciesResults0B5 ; id 182 Lipsy
    dw BreedSpeciesResults0B7 ; id 183 StagBug
    dw BreedSpeciesResults0B8 ; id 184 Pyuro
    dw BreedSpeciesResults0B8 ; id 185 ArmyAnt
    dw BreedSpeciesResults0B8 ; id 186 GoHopper
    dw BreedSpeciesResults0B8 ; id 187 TailEater
    dw BreedSpeciesResults0BC ; id 188 ArmorPede
    dw BreedSpeciesResults0BC ; id 189 Eyeder
    dw BreedSpeciesResults0BE ; id 190 GiantMoth
    dw BreedSpeciesResults0BE ; id 191 Droll
    dw BreedSpeciesResults0BE ; id 192 ArmyCrab
    dw BreedSpeciesResults0C1 ; id 193 MadHornet
    dw BreedSpeciesResults0C2 ; id 194 Belzebub
    dw BreedSpeciesResults0C2 ; id 195 WarMantis
    dw BreedSpeciesResults0C4 ; id 196 HornBeet
    dw BreedSpeciesResults0C5 ; id 197 Sickler
    dw BreedSpeciesResults0C5 ; id 198 Armorpion
    dw BreedSpeciesResults0C7 ; id 199 Digster
    dw BreedSpeciesResults0C7 ; id 200 Skularach
    dw BreedSpeciesResults0C7 ; id 201 MultiEyes
    dw BreedSpeciesResults0CA ; id 202 ?
    dw BreedSpeciesResults0CA ; id 203 ?
    dw BreedSpeciesResults0CA ; id 204 ?
    dw BreedSpeciesResults0CA ; id 205 ?
    dw BreedSpeciesResults0CA ; id 206 ?
    dw BreedSpeciesResults0CA ; id 207 ?
    dw BreedSpeciesResults0CA ; id 208 ?
    dw BreedSpeciesResults0CA ; id 209 ?
    dw BreedSpeciesResults0CA ; id 210 ?
    dw BreedSpeciesResults0CA ; id 211 Pixy
    dw BreedSpeciesResults0CA ; id 212 MedusaEye
    dw BreedSpeciesResults0CA ; id 213 AgDevil
    dw BreedSpeciesResults0D6 ; id 214 Demonite
    dw BreedSpeciesResults0D7 ; id 215 DarkEye
    dw BreedSpeciesResults0D8 ; id 216 EyeBall
    dw BreedSpeciesResults0D8 ; id 217 SkulRider
    dw BreedSpeciesResults0D8 ; id 218 EvilBeast
    dw BreedSpeciesResults0D8 ; id 219 Bubblemon
    dw BreedSpeciesResults0DC ; id 220 1EyeClown
    dw BreedSpeciesResults0DD ; id 221 Gremlin
    dw BreedSpeciesResults0DE ; id 222 ArcDemon
    dw BreedSpeciesResults0DF ; id 223 Lionex
    dw BreedSpeciesResults0E0 ; id 224 GoatHorn
    dw BreedSpeciesResults0E0 ; id 225 Orc
    dw BreedSpeciesResults0E0 ; id 226 Ogre
    dw BreedSpeciesResults0E3 ; id 227 GateGuard
    dw BreedSpeciesResults0E3 ; id 228 ChopClown
    dw BreedSpeciesResults0E3 ; id 229 BossTroll
    dw BreedSpeciesResults0E6 ; id 230 Grendal
    dw BreedSpeciesResults0E7 ; id 231 Akubar
    dw BreedSpeciesResults0E8 ; id 232 MadKnight
    dw BreedSpeciesResults0E8 ; id 233 EvilWell
    dw BreedSpeciesResults0E8 ; id 234 Gigantes
    dw BreedSpeciesResults0EB ; id 235 Centasaur
    dw BreedSpeciesResults0EC ; id 236 EvilArmor
    dw BreedSpeciesResults0EC ; id 237 Jamirus
    dw BreedSpeciesResults0EE ; id 238 Durran
    dw BreedSpeciesResults0EF ; id 239 Titanis
    dw BreedSpeciesResults0EF ; id 240 LampGenie
    dw BreedSpeciesResults0F1 ; id 241 ?
    dw BreedSpeciesResults0F1 ; id 242 ?
    dw BreedSpeciesResults0F1 ; id 243 ?
    dw BreedSpeciesResults0F1 ; id 244 ?
    dw BreedSpeciesResults0F1 ; id 245 ?
    dw BreedSpeciesResults0F1 ; id 246 Spooky
    dw BreedSpeciesResults0F1 ; id 247 Skullgon
    dw BreedSpeciesResults0F8 ; id 248 PutrePup
    dw BreedSpeciesResults0F9 ; id 249 RotRaven
    dw BreedSpeciesResults0F9 ; id 250 Mummy
    dw BreedSpeciesResults0FB ; id 251 DarkCrab
    dw BreedSpeciesResults0FB ; id 252 DeadNite
    dw BreedSpeciesResults0FD ; id 253 Shadow
    dw BreedSpeciesResults0FD ; id 254 Skulpent
    dw BreedSpeciesResults0FD ; id 255 Hork
    dw BreedSpeciesResults100 ; id 256 Mudron
    dw BreedSpeciesResults101 ; id 257 NiteWhip
    dw BreedSpeciesResults102 ; id 258 WindMerge
    dw BreedSpeciesResults102 ; id 259 Reaper
    dw BreedSpeciesResults102 ; id 260 Inverzon
    dw BreedSpeciesResults102 ; id 261 FoxFire
    dw BreedSpeciesResults102 ; id 262 CaptDead
    dw BreedSpeciesResults107 ; id 263 DeadNoble
    dw BreedSpeciesResults108 ; id 264 WhiteKing
    dw BreedSpeciesResults109 ; id 265 BoneSlave
    dw BreedSpeciesResults10A ; id 266 Skeletor
    dw BreedSpeciesResults10B ; id 267 Servant
    dw BreedSpeciesResults10C ; id 268 Lazamanus
    dw BreedSpeciesResults10C ; id 269 Copycat
    dw BreedSpeciesResults10E ; id 270 MadSpirit
    dw BreedSpeciesResults10F ; id 271 PomPomBom
    dw BreedSpeciesResults10F ; id 272 Niterich
    dw BreedSpeciesResults111 ; id 273 ?
    dw BreedSpeciesResults111 ; id 274 ?
    dw BreedSpeciesResults111 ; id 275 ?
    dw BreedSpeciesResults111 ; id 276 ?
    dw BreedSpeciesResults111 ; id 277 ?
    dw BreedSpeciesResults111 ; id 278 ?
    dw BreedSpeciesResults111 ; id 279 ?
    dw BreedSpeciesResults111 ; id 280 ?
    dw BreedSpeciesResults111 ; id 281 JewelBag
    dw BreedSpeciesResults111 ; id 282 EvilWand
    dw BreedSpeciesResults11B ; id 283 MadCandle
    dw BreedSpeciesResults11C ; id 284 CoilBird
    dw BreedSpeciesResults11C ; id 285 Facer
    dw BreedSpeciesResults11C ; id 286 SpikyBoy
    dw BreedSpeciesResults11F ; id 287 MadMirror
    dw BreedSpeciesResults120 ; id 288 RogueNite
    dw BreedSpeciesResults120 ; id 289 Puppetor
    dw BreedSpeciesResults122 ; id 290 Goopi
    dw BreedSpeciesResults123 ; id 291 Voodoll
    dw BreedSpeciesResults124 ; id 292 MetalDrak
    dw BreedSpeciesResults125 ; id 293 Balzak
    dw BreedSpeciesResults125 ; id 294 SabreMan
    dw BreedSpeciesResults127 ; id 295 CurseLamp
    dw BreedSpeciesResults128 ; id 296 Brushead
    dw BreedSpeciesResults128 ; id 297 Roboster
    dw BreedSpeciesResults12A ; id 298 Roboster2
    dw BreedSpeciesResults12B ; id 299 EvilPot
    dw BreedSpeciesResults12C ; id 300 Gismo
    dw BreedSpeciesResults12D ; id 301 LavaMan
    dw BreedSpeciesResults12E ; id 302 IceMan
    dw BreedSpeciesResults12F ; id 303 Mimic
    dw BreedSpeciesResults130 ; id 304 Exaucers
    dw BreedSpeciesResults130 ; id 305 MudDoll
    dw BreedSpeciesResults132 ; id 306 Golem
    dw BreedSpeciesResults133 ; id 307 StoneMan
    dw BreedSpeciesResults134 ; id 308 BombCrag
    dw BreedSpeciesResults134 ; id 309 GoldGolem
    dw BreedSpeciesResults136 ; id 310 DarkMate
    dw BreedSpeciesResults136 ; id 311 ProtoMech
    dw BreedSpeciesResults136 ; id 312 CloudKing
    dw BreedSpeciesResults136 ; id 313 ?
    dw BreedSpeciesResults136 ; id 314 ?
    dw BreedSpeciesResults136 ; id 315 ?
    dw BreedSpeciesResults136 ; id 316 Petiteel
    dw BreedSpeciesResults136 ; id 317 Moray
    dw BreedSpeciesResults136 ; id 318 WalrusMan
    dw BreedSpeciesResults136 ; id 319 RayGigas
    dw BreedSpeciesResults136 ; id 320 Anemon
    dw BreedSpeciesResults136 ; id 321 Aquarella
    dw BreedSpeciesResults142 ; id 322 Merman
    dw BreedSpeciesResults143 ; id 323 Octokid
    dw BreedSpeciesResults143 ; id 324 PutreFish
    dw BreedSpeciesResults143 ; id 325 Octoreach
    dw BreedSpeciesResults146 ; id 326 Angleron
    dw BreedSpeciesResults147 ; id 327 FishRider
    dw BreedSpeciesResults147 ; id 328 RushFish
    dw BreedSpeciesResults149 ; id 329 Gamanian
    dw BreedSpeciesResults14A ; id 330 Clawster
    dw BreedSpeciesResults14B ; id 331 CancerMan
    dw BreedSpeciesResults14C ; id 332 RogueWave
    dw BreedSpeciesResults14D ; id 333 Scallopa
    dw BreedSpeciesResults14D ; id 334 SeaHorse
    dw BreedSpeciesResults14D ; id 335 HoodSquid
    dw BreedSpeciesResults150 ; id 336 MerTiger
    dw BreedSpeciesResults151 ; id 337 AxeShark
    dw BreedSpeciesResults151 ; id 338 Octogon
    dw BreedSpeciesResults153 ; id 339 KingSquid
    dw BreedSpeciesResults153 ; id 340 Digong
    dw BreedSpeciesResults155 ; id 341 WhaleMage
    dw BreedSpeciesResults155 ; id 342 Aquadon
    dw BreedSpeciesResults155 ; id 343 Octoraid
    dw BreedSpeciesResults155 ; id 344 Grakos
    dw BreedSpeciesResults159 ; id 345 Poseidon
    dw BreedSpeciesResults159 ; id 346 Pumpoise
    dw BreedSpeciesResults159 ; id 347 Starfish
    dw BreedSpeciesResults159 ; id 348 ?
    dw BreedSpeciesResults159 ; id 349 ?
    dw BreedSpeciesResults159 ; id 350 ?
    dw BreedSpeciesResults159 ; id 351 DracoLord
    dw BreedSpeciesResults160 ; id 352 DracoLord
    dw BreedSpeciesResults161 ; id 353 LordDraco
    dw BreedSpeciesResults161 ; id 354 Hargon
    dw BreedSpeciesResults163 ; id 355 Sidoh
    dw BreedSpeciesResults164 ; id 356 Genosidoh
    dw BreedSpeciesResults164 ; id 357 Baramos
    dw BreedSpeciesResults166 ; id 358 Zoma
    dw BreedSpeciesResults167 ; id 359 AsuraZoma
    dw BreedSpeciesResults167 ; id 360 Pizzaro
    dw BreedSpeciesResults169 ; id 361 PsychoPiz
    dw BreedSpeciesResults16A ; id 362 Esterk
    dw BreedSpeciesResults16B ; id 363 Mirudraas
    dw BreedSpeciesResults16C ; id 364 Mirudraas
    dw BreedSpeciesResults16D ; id 365 Mudou
    dw BreedSpeciesResults16D ; id 366 DeathMore
    dw BreedSpeciesResults16F ; id 367 DeathMore
    dw BreedSpeciesResults170 ; id 368 DeathMore
    dw BreedSpeciesResults171 ; id 369 Darkdrium
    dw BreedSpeciesResults171 ; id 370 Orgodemir
    dw BreedFamilyRuleTable ; id 371 Orgodemir
    dw BreedFamilyRuleTable ; id 372 Darck
    dw BreedFamilyRuleTable ; id 373 Tatsu
    dw BreedFamilyRuleTable ; id 374 Diago
    dw BreedFamilyRuleTable ; id 375 Samsi
    dw BreedSpeciesResults000 ; id 376 Bazoo
    dw BreedSpeciesResults000 ; id 377 ?
    dw BreedSpeciesResults000 ; id 378 ?
    dw BreedSpeciesResults000 ; id 379 ?
    dw BreedSpeciesResults000 ; id 380 Lamia
    dw BreedSpeciesResults000 ; id 381 Dimensaur
    dw BreedSpeciesResults000 ; id 382 Kagebou
    dw BreedSpeciesResults000 ; id 383 ?

; E-0199 (derived: list for entry $00 of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults000::
Data_00E_7114:: ; address name
    dw $FFFF ; id 0

; E-0199 (derived: list for entry $01 (DrakSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults001::
Data_00E_7116:: ; address name
    dw $000E ; id 0 SlimeBorg

; E-0199 (derived: list for entry $02 (SpotSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults002::
Data_00E_7118:: ; address name
    dw $0013 ; id 0 SpotKing

; E-0199 (derived: list for entry $03 (WingSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults003::
Data_00E_711A:: ; address name
    dw $000E ; id 0 SlimeBorg

; E-0199 (derived: list for entry $07 (Babble) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults007::
Data_00E_711C:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0014 ; id 1 TropicGel
    dw $0016 ; id 2 HaloSlime
    dw $001A ; id 3 WonderEgg

; E-0199 (derived: list for entry $0B (Healer) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults00B::
Data_00E_7124:: ; address name
    dw $0015 ; id 0 MimeSlime

; E-0199 (derived: list for entry $0C (FangSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults00C::
Data_00E_7126:: ; address name
    dw $000E ; id 0 SlimeBorg

; E-0199 (derived: list for entry $0E (SlimeBorg) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults00E::
Data_00E_7128:: ; address name
    dw $0013 ; id 0 SpotKing
    dw $0017 ; id 1 MetalKing
    dw $0018 ; id 2 GoldSlime

; E-0199 (derived: list for entry $11 (Metaly) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults011::
Data_00E_712E:: ; address name
    dw $0012 ; id 0 Metabble

; E-0199 (derived: list for entry $12 (Metabble) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults012::
Data_00E_7130:: ; address name
    dw $000E ; id 0 SlimeBorg
    dw $0017 ; id 1 MetalKing

; E-0199 (derived: list for entry $13 (SpotKing) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults013::
Data_00E_7134:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0017 ; id 1 MetalKing
    dw $0018 ; id 2 GoldSlime

; E-0199 (derived: list for entry $14 (TropicGel) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults014::
Data_00E_713A:: ; address name
    dw $0016 ; id 0 HaloSlime

; E-0199 (derived: list for entry $16 (HaloSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults016::
Data_00E_713C:: ; address name
    dw $0013 ; id 0 SpotKing
    dw $0018 ; id 1 GoldSlime

; E-0199 (derived: list for entry $18 (GoldSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults018::
Data_00E_7140:: ; address name
    dw $0019 ; id 0 GranSlime

; E-0199 (derived: list for entry $19 (GranSlime) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults019::
Data_00E_7142:: ; address name
    dw $0017 ; id 0 MetalKing
    dw $0018 ; id 1 GoldSlime
    dw $0019 ; id 2 GranSlime

; E-0199 (derived: list for entry $1B (Butch) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults01B::
Data_00E_7148:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $002D ; id 1 Dragon

; E-0199 (derived: list for entry $25 (Tortragon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults025::
Data_00E_714C:: ; address name
    dw $0035 ; id 0 Vampirus
    dw $003B ; id 1 Coatol

; E-0199 (derived: list for entry $27 (Gasgon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults027::
Data_00E_7150:: ; address name
    dw $0033 ; id 0 Andreal
    dw $003B ; id 1 Coatol

; E-0199 (derived: list for entry $28 (FairyDrak) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults028::
Data_00E_7154:: ; address name
    dw $0030 ; id 0 Rayburn
    dw $003B ; id 1 Coatol

; E-0199 (derived: list for entry $2A (Poisongon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults02A::
Data_00E_7158:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $003E ; id 1 SkyDragon
    dw $003F ; id 2 Serpentia

; E-0199 (derived: list for entry $2E (MiniDrak) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults02E::
Data_00E_715E:: ; address name
    dw $0033 ; id 0 Andreal

; E-0199 (derived: list for entry $30 (Rayburn) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults030::
Data_00E_7160:: ; address name
    dw $003C ; id 0 Orochi
    dw $0042 ; id 1 GigaDraco

; E-0199 (derived: list for entry $34 (KingCobra) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults034::
Data_00E_7164:: ; address name
    dw $0036 ; id 0 SnakeBat

; E-0199 (derived: list for entry $35 (Vampirus) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults035::
Data_00E_7166:: ; address name
    dw $003B ; id 0 Coatol
    dw $0035 ; id 1 Vampirus

; E-0199 (derived: list for entry $36 (SnakeBat) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults036::
Data_00E_716A:: ; address name
    dw $003C ; id 0 Orochi
    dw $003F ; id 1 Serpentia
    dw $0042 ; id 2 GigaDraco

; E-0199 (derived: list for entry $39 (Crestpent) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults039::
Data_00E_7170:: ; address name
    dw $003A ; id 0 WingSnake

; E-0199 (derived: list for entry $3A (WingSnake) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults03A::
Data_00E_7172:: ; address name
    dw $003B ; id 0 Coatol

; E-0199 (derived: list for entry $3B (Coatol) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults03B::
Data_00E_7174:: ; address name
    dw $0033 ; id 0 Andreal
    dw $003B ; id 1 Coatol
    dw $0042 ; id 2 GigaDraco

; E-0199 (derived: list for entry $3E (SkyDragon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults03E::
Data_00E_717A:: ; address name
    dw $0033 ; id 0 Andreal
    dw $003B ; id 1 Coatol
    dw $0040 ; id 2 Divinegon
    dw $0042 ; id 3 GigaDraco

; E-0199 (derived: list for entry $3F (Serpentia) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults03F::
Data_00E_7182:: ; address name
    dw $0041 ; id 0 Orligon

; E-0199 (derived: list for entry $41 (Orligon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults041::
Data_00E_7184:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0051 ; id 1 SuperTen
    dw $005F ; id 2 Trumpeter

; E-0199 (derived: list for entry $48 (Almiraj) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults048::
Data_00E_718A:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $005C ; id 1 Unicorn

; E-0199 (derived: list for entry $49 (CatFly) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults049::
Data_00E_718E:: ; address name
    dw $0065 ; id 0 CatMage

; E-0199 (derived: list for entry $4A (PillowRat) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults04A::
Data_00E_7190:: ; address name
    dw $0051 ; id 0 SuperTen
    dw $005F ; id 1 Trumpeter

; E-0199 (derived: list for entry $4D (Skullroo) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults04D::
Data_00E_7194:: ; address name
    dw $0066 ; id 0 Dumbira

; E-0199 (derived: list for entry $52 (IronTurt) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults052::
Data_00E_7196:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0056 ; id 1 Yeti

; E-0199 (derived: list for entry $53 (Mommonja) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults053::
Data_00E_719A:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0066 ; id 1 Dumbira

; E-0199 (derived: list for entry $55 (Grizzly) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults055::
Data_00E_719E:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $005F ; id 1 Trumpeter

; E-0199 (derived: list for entry $56 (Yeti) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults056::
Data_00E_71A2:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $005F ; id 1 Trumpeter

; E-0199 (derived: list for entry $57 (ArrowDog) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults057::
Data_00E_71A6:: ; address name
    dw $0058 ; id 0 NoctoKing
    dw $0062 ; id 1 MadCat

; E-0199 (derived: list for entry $58 (NoctoKing) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults058::
Data_00E_71AA:: ; address name
    dw $0066 ; id 0 Dumbira

; E-0199 (derived: list for entry $59 (BeastNite) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults059::
Data_00E_71AC:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0058 ; id 1 NoctoKing

; E-0199 (derived: list for entry $5A (MadGopher) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults05A::
Data_00E_71B0:: ; address name
    dw $0059 ; id 0 BeastNite

; E-0199 (derived: list for entry $5B (FairyRat) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults05B::
Data_00E_71B2:: ; address name
    dw $004C ; id 0 GulpBeast

; E-0199 (derived: list for entry $5D (Goategon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults05D::
Data_00E_71B4:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0056 ; id 1 Yeti

; E-0199 (derived: list for entry $5E (WildApe) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults05E::
Data_00E_71B8:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0056 ; id 1 Yeti
    dw $005F ; id 2 Trumpeter

; E-0199 (derived: list for entry $5F (Trumpeter) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults05F::
Data_00E_71BE:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0060 ; id 1 KingLeo
    dw $004C ; id 2 GulpBeast

; E-0199 (derived: list for entry $60 (KingLeo) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults060::
Data_00E_71C4:: ; address name
    dw $0064 ; id 0 Gorago

; E-0199 (derived: list for entry $62 (MadCat) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults062::
Data_00E_71C6:: ; address name
    dw $0056 ; id 0 Yeti
    dw $0061 ; id 1 DarkHorn

; E-0199 (derived: list for entry $63 (BigEye) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults063::
Data_00E_71CA:: ; address name
    dw $0062 ; id 0 MadCat

; E-0199 (derived: list for entry $66 (Dumbira) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults066::
Data_00E_71CC:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0056 ; id 1 Yeti

; E-0199 (derived: list for entry $67 (?) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults067::
Data_00E_71D0:: ; address name
    dw $0077 ; id 0 LandOwl

; E-0199 (derived: list for entry $6D (Florajay) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults06D::
Data_00E_71D2:: ; address name
    dw $007A ; id 0 Emyu

; E-0199 (derived: list for entry $70 (MadRaven) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults070::
Data_00E_71D4:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0079 ; id 1 MadCondor

; E-0199 (derived: list for entry $73 (Dracky) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults073::
Data_00E_71D8:: ; address name
    dw $0079 ; id 0 MadCondor

; E-0199 (derived: list for entry $75 (BigRoost) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults075::
Data_00E_71DA:: ; address name
    dw $007F ; id 0 WhipBird

; E-0199 (derived: list for entry $78 (MadGoose) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults078::
Data_00E_71DC:: ; address name
    dw $007F ; id 0 WhipBird

; E-0199 (derived: list for entry $79 (MadCondor) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults079::
Data_00E_71DE:: ; address name
    dw $007A ; id 0 Emyu
    dw $007D ; id 1 ZapBird
    dw $007F ; id 2 WhipBird

; E-0199 (derived: list for entry $7A (Emyu) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults07A::
Data_00E_71E4:: ; address name
    dw $007E ; id 0 Garudian
    dw $007F ; id 1 WhipBird
    dw $0081 ; id 2 RainHawk

; E-0199 (derived: list for entry $7C (Phoenix) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults07C::
Data_00E_71EA:: ; address name
    dw $007D ; id 0 ZapBird
    dw $007E ; id 1 Garudian

; E-0199 (derived: list for entry $7D (ZapBird) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults07D::
Data_00E_71EE:: ; address name
    dw $007E ; id 0 Garudian
    dw $007F ; id 1 WhipBird

; E-0199 (derived: list for entry $7E (Garudian) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults07E::
Data_00E_71F2:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0083 ; id 1 Shantak

; E-0199 (derived: list for entry $7F (WhipBird) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults07F::
Data_00E_71F6:: ; address name
    dw $007D ; id 0 ZapBird
    dw $0083 ; id 1 Shantak

; E-0199 (derived: list for entry $80 (FunkyBird) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults080::
Data_00E_71FA:: ; address name
    dw $007E ; id 0 Garudian

; E-0199 (derived: list for entry $81 (RainHawk) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults081::
Data_00E_71FC:: ; address name
    dw $0082 ; id 0 Azurile

; E-0199 (derived: list for entry $82 (Azurile) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults082::
Data_00E_71FE:: ; address name
    dw $0082 ; id 0 Azurile

; E-0199 (derived: list for entry $84 (CragDevil) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults084::
Data_00E_7200:: ; address name
    dw $0078 ; id 0 MadGoose
    dw $0080 ; id 1 FunkyBird

; E-0199 (derived: list for entry $85 (?) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults085::
Data_00E_7204:: ; address name
    dw $00A1 ; id 0 GhosTree

; E-0199 (derived: list for entry $97 (Oniono) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults097::
Data_00E_7206:: ; address name
    dw $00A7 ; id 0 FooHero

; E-0199 (derived: list for entry $9A (Devipine) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults09A::
Data_00E_7208:: ; address name
    dw $009F ; id 0 ManEater

; E-0199 (derived: list for entry $9F (ManEater) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults09F::
Data_00E_720A:: ; address name
    dw $00A0 ; id 0 Snapper

; E-0199 (derived: list for entry $A0 (Snapper) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0A0::
Data_00E_720C:: ; address name
    dw $0096 ; id 0 Stubsuck
    dw $009B ; id 1 FaceTree

; E-0199 (derived: list for entry $A2 (Rosevine) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0A2::
Data_00E_7210:: ; address name
    dw $00A3 ; id 0 Egdracil

; E-0199 (derived: list for entry $A3 (Egdracil) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0A3::
Data_00E_7212:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $00A5 ; id 1 Watabou

; E-0199 (derived: list for entry $A5 (Watabou) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0A5::
Data_00E_7216:: ; address name
    dw $0099 ; id 0 TreeBoy

; E-0199 (derived: list for entry $A8 (?) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0A8::
Data_00E_7218:: ; address name
    dw $00C9 ; id 0 MultiEyes

; E-0199 (derived: list for entry $B2 (Gophecada) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0B2::
Data_00E_721A:: ; address name
    dw $00BF ; id 0 Droll
    dw $00C1 ; id 1 MadHornet

; E-0199 (derived: list for entry $B4 (WeedBug) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0B4::
Data_00E_721E:: ; address name
    dw $00BB ; id 0 TailEater

; E-0199 (derived: list for entry $B5 (GiantWorm) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0B5::
Data_00E_7220:: ; address name
    dw $00BF ; id 0 Droll

; E-0199 (derived: list for entry $B7 (StagBug) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0B7::
Data_00E_7222:: ; address name
    dw $00C4 ; id 0 HornBeet

; E-0199 (derived: list for entry $B8 (Pyuro) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0B8::
Data_00E_7224:: ; address name
    dw $00BF ; id 0 Droll

; E-0199 (derived: list for entry $BC (ArmorPede) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0BC::
Data_00E_7226:: ; address name
    dw $00BF ; id 0 Droll

; E-0199 (derived: list for entry $BE (GiantMoth) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0BE::
Data_00E_7228:: ; address name
    dw $00C7 ; id 0 Digster

; E-0199 (derived: list for entry $C1 (MadHornet) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0C1::
Data_00E_722A:: ; address name
    dw $00C2 ; id 0 Belzebub

; E-0199 (derived: list for entry $C2 (Belzebub) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0C2::
Data_00E_722C:: ; address name
    dw $00C6 ; id 0 Armorpion

; E-0199 (derived: list for entry $C4 (HornBeet) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0C4::
Data_00E_722E:: ; address name
    dw $00C6 ; id 0 Armorpion

; E-0199 (derived: list for entry $C5 (Sickler) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0C5::
Data_00E_7230:: ; address name
    dw $00C8 ; id 0 Skularach

; E-0199 (derived: list for entry $C7 (Digster) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0C7::
Data_00E_7232:: ; address name
    dw $00C2 ; id 0 Belzebub
    dw $00BC ; id 1 ArmorPede

; E-0199 (derived: list for entry $CA (?) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0CA::
Data_00E_7236:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00E2 ; id 1 Ogre
    dw $00E3 ; id 2 GateGuard

; E-0199 (derived: list for entry $D6 (Demonite) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0D6::
Data_00E_723C:: ; address name
    dw $00E3 ; id 0 GateGuard

; E-0199 (derived: list for entry $D7 (DarkEye) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0D7::
Data_00E_723E:: ; address name
    dw $00D4 ; id 0 MedusaEye

; E-0199 (derived: list for entry $D8 (EyeBall) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0D8::
Data_00E_7240:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $00E3 ; id 1 GateGuard
    dw $00E9 ; id 2 EvilWell

; E-0199 (derived: list for entry $DC (1EyeClown) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0DC::
Data_00E_7246:: ; address name
    dw $00D4 ; id 0 MedusaEye
    dw $00E4 ; id 1 ChopClown

; E-0199 (derived: list for entry $DD (Gremlin) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0DD::
Data_00E_724A:: ; address name
    dw $00D4 ; id 0 MedusaEye

; E-0199 (derived: list for entry $DE (ArcDemon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0DE::
Data_00E_724C:: ; address name
    dw $00DF ; id 0 Lionex
    dw $00E7 ; id 1 Akubar

; E-0199 (derived: list for entry $DF (Lionex) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0DF::
Data_00E_7250:: ; address name
    dw $00E4 ; id 0 ChopClown

; E-0199 (derived: list for entry $E0 (GoatHorn) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0E0::
Data_00E_7252:: ; address name
    dw $00E5 ; id 0 BossTroll
    dw $00E9 ; id 1 EvilWell

; E-0199 (derived: list for entry $E3 (GateGuard) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0E3::
Data_00E_7256:: ; address name
    dw $00E9 ; id 0 EvilWell
    dw $00F0 ; id 1 LampGenie

; E-0199 (derived: list for entry $E6 (Grendal) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0E6::
Data_00E_725A:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00E2 ; id 1 Ogre
    dw $00E3 ; id 2 GateGuard
    dw $00E7 ; id 3 Akubar
    dw $00E4 ; id 4 ChopClown

; E-0199 (derived: list for entry $E7 (Akubar) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0E7::
Data_00E_7264:: ; address name
    dw $00ED ; id 0 Jamirus

; E-0199 (derived: list for entry $E8 (MadKnight) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0E8::
Data_00E_7266:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00E2 ; id 1 Ogre
    dw $00E3 ; id 2 GateGuard

; E-0199 (derived: list for entry $EB (Centasaur) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0EB::
Data_00E_726C:: ; address name
    dw $00E5 ; id 0 BossTroll
    dw $00EE ; id 1 Durran

; E-0199 (derived: list for entry $EC (EvilArmor) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0EC::
Data_00E_7270:: ; address name
    dw $00EE ; id 0 Durran
    dw $0163 ; id 1 Sidoh

; E-0199 (derived: list for entry $EE (Durran) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0EE::
Data_00E_7274:: ; address name
    dw $00EF ; id 0 Titanis
    dw $0168 ; id 1 Pizzaro

; E-0199 (derived: list for entry $EF (Titanis) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0EF::
Data_00E_7278:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $00DE ; id 1 ArcDemon

; E-0199 (derived: list for entry $F1 (?) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0F1::
Data_00E_727C:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $0108 ; id 1 WhiteKing

; E-0199 (derived: list for entry $F8 (PutrePup) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0F8::
Data_00E_7280:: ; address name
    dw $0105 ; id 0 FoxFire

; E-0199 (derived: list for entry $F9 (RotRaven) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0F9::
Data_00E_7282:: ; address name
    dw $0109 ; id 0 BoneSlave
    dw $010A ; id 1 Skeletor

; E-0199 (derived: list for entry $FB (DarkCrab) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0FB::
Data_00E_7286:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $0109 ; id 1 BoneSlave
    dw $010A ; id 2 Skeletor
    dw $0106 ; id 3 CaptDead

; E-0199 (derived: list for entry $FD (Shadow) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults0FD::
Data_00E_728E:: ; address name
    dw $0104 ; id 0 Inverzon
    dw $010A ; id 1 Skeletor

; E-0199 (derived: list for entry $100 (Mudron) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults100::
Data_00E_7292:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $010A ; id 1 Skeletor

; E-0199 (derived: list for entry $101 (NiteWhip) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults101::
Data_00E_7296:: ; address name
    dw $0106 ; id 0 CaptDead

; E-0199 (derived: list for entry $102 (WindMerge) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults102::
Data_00E_7298:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $010A ; id 1 Skeletor

; E-0199 (derived: list for entry $107 (DeadNoble) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults107::
Data_00E_729C:: ; address name
    dw $0108 ; id 0 WhiteKing
    dw $0110 ; id 1 Niterich

; E-0199 (derived: list for entry $108 (WhiteKing) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults108::
Data_00E_72A0:: ; address name
    dw $010C ; id 0 Lazamanus
    dw $0162 ; id 1 Hargon

; E-0199 (derived: list for entry $109 (BoneSlave) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults109::
Data_00E_72A4:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $0108 ; id 1 WhiteKing
    dw $010A ; id 2 Skeletor

; E-0199 (derived: list for entry $10A (Skeletor) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults10A::
Data_00E_72AA:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $0108 ; id 1 WhiteKing
    dw $010B ; id 2 Servant
    dw $0110 ; id 3 Niterich
    dw $0110 ; id 4 Niterich

; E-0199 (derived: list for entry $10B (Servant) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults10B::
Data_00E_72B4:: ; address name
    dw $015F ; id 0 DracoLord

; E-0199 (derived: list for entry $10C (Lazamanus) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults10C::
Data_00E_72B6:: ; address name
    dw $010F ; id 0 PomPomBom

; E-0199 (derived: list for entry $10E (MadSpirit) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults10E::
Data_00E_72B8:: ; address name
    dw $0107 ; id 0 DeadNoble

; E-0199 (derived: list for entry $10F (PomPomBom) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults10F::
Data_00E_72BA:: ; address name
    dw $0108 ; id 0 WhiteKing

; E-0199 (derived: list for entry $111 (?) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults111::
Data_00E_72BC:: ; address name
    dw $0126 ; id 0 SabreMan

; E-0199 (derived: list for entry $11B (MadCandle) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults11B::
Data_00E_72BE:: ; address name
    dw $012C ; id 0 Gismo

; E-0199 (derived: list for entry $11C (CoilBird) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults11C::
Data_00E_72C0:: ; address name
    dw $0134 ; id 0 BombCrag

; E-0199 (derived: list for entry $11F (MadMirror) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults11F::
Data_00E_72C2:: ; address name
    dw $012C ; id 0 Gismo

; E-0199 (derived: list for entry $120 (RogueNite) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults120::
Data_00E_72C4:: ; address name
    dw $0128 ; id 0 Brushead

; E-0199 (derived: list for entry $122 (Goopi) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults122::
Data_00E_72C6:: ; address name
    dw $012C ; id 0 Gismo
    dw $0131 ; id 1 MudDoll

; E-0199 (derived: list for entry $123 (Voodoll) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults123::
Data_00E_72CA:: ; address name
    dw $0126 ; id 0 SabreMan

; E-0199 (derived: list for entry $124 (MetalDrak) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults124::
Data_00E_72CC:: ; address name
    dw $012D ; id 0 LavaMan
    dw $012E ; id 1 IceMan

; E-0199 (derived: list for entry $125 (Balzak) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults125::
Data_00E_72D0:: ; address name
    dw $0129 ; id 0 Roboster

; E-0199 (derived: list for entry $127 (CurseLamp) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults127::
Data_00E_72D2:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0125 ; id 1 Balzak

; E-0199 (derived: list for entry $128 (Brushead) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults128::
Data_00E_72D6:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $012A ; id 1 Roboster2
    dw $012E ; id 2 IceMan
    dw $012F ; id 3 Mimic
    dw $012A ; id 4 Roboster2

; E-0199 (derived: list for entry $12A (Roboster2) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults12A::
Data_00E_72E0:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $012E ; id 1 IceMan

; E-0199 (derived: list for entry $12B (EvilPot) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults12B::
Data_00E_72E4:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0134 ; id 1 BombCrag

; E-0199 (derived: list for entry $12C (Gismo) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults12C::
Data_00E_72E8:: ; address name
    dw $0138 ; id 0 CloudKing

; E-0199 (derived: list for entry $12D (LavaMan) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults12D::
Data_00E_72EA:: ; address name
    dw $0135 ; id 0 GoldGolem

; E-0199 (derived: list for entry $12E (IceMan) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults12E::
Data_00E_72EC:: ; address name
    dw $0135 ; id 0 GoldGolem

; E-0199 (derived: list for entry $12F (Mimic) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults12F::
Data_00E_72EE:: ; address name
    dw $012B ; id 0 EvilPot

; E-0199 (derived: list for entry $130 (Exaucers) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults130::
Data_00E_72F0:: ; address name
    dw $0132 ; id 0 Golem

; E-0199 (derived: list for entry $132 (Golem) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults132::
Data_00E_72F2:: ; address name
    dw $0123 ; id 0 Voodoll
    dw $0126 ; id 1 SabreMan
    dw $0133 ; id 2 StoneMan

; E-0199 (derived: list for entry $133 (StoneMan) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults133::
Data_00E_72F8:: ; address name
    dw $0123 ; id 0 Voodoll
    dw $0124 ; id 1 MetalDrak
    dw $0126 ; id 2 SabreMan

; E-0199 (derived: list for entry $134 (BombCrag) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults134::
Data_00E_72FE:: ; address name
    dw $0136 ; id 0 DarkMate

; E-0199 (derived: list for entry $136 (DarkMate) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults136::
Data_00E_7300:: ; address name
    dw $0149 ; id 0 Gamanian

; E-0199 (derived: list for entry $142 (Merman) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults142::
Data_00E_7302:: ; address name
    dw $0150 ; id 0 MerTiger
    dw $012B ; id 1 EvilPot

; E-0199 (derived: list for entry $143 (Octokid) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults143::
Data_00E_7306:: ; address name
    dw $0152 ; id 0 Octogon

; E-0199 (derived: list for entry $146 (Angleron) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults146::
Data_00E_7308:: ; address name
    dw $0147 ; id 0 FishRider
    dw $0148 ; id 1 RushFish

; E-0199 (derived: list for entry $147 (FishRider) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults147::
Data_00E_730C:: ; address name
    dw $0154 ; id 0 Digong

; E-0199 (derived: list for entry $149 (Gamanian) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults149::
Data_00E_730E:: ; address name
    dw $014A ; id 0 Clawster

; E-0199 (derived: list for entry $14A (Clawster) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults14A::
Data_00E_7310:: ; address name
    dw $014B ; id 0 CancerMan

; E-0199 (derived: list for entry $14B (CancerMan) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults14B::
Data_00E_7312:: ; address name
    dw $014F ; id 0 HoodSquid
    dw $0151 ; id 1 AxeShark

; E-0199 (derived: list for entry $14C (RogueWave) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults14C::
Data_00E_7316:: ; address name
    dw $014D ; id 0 Scallopa

; E-0199 (derived: list for entry $14D (Scallopa) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults14D::
Data_00E_7318:: ; address name
    dw $0155 ; id 0 WhaleMage

; E-0199 (derived: list for entry $150 (MerTiger) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults150::
Data_00E_731A:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0151 ; id 1 AxeShark

; E-0199 (derived: list for entry $151 (AxeShark) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults151::
Data_00E_731E:: ; address name
    dw $0157 ; id 0 Octoraid
    dw $0153 ; id 1 KingSquid

; E-0199 (derived: list for entry $153 (KingSquid) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults153::
Data_00E_7322:: ; address name
    dw $0156 ; id 0 Aquadon

; E-0199 (derived: list for entry $155 (WhaleMage) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults155::
Data_00E_7324:: ; address name
    dw $0159 ; id 0 Poseidon

; E-0199 (derived: list for entry $159 (Poseidon) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults159::
Data_00E_7326:: ; address name
    dw $0160 ; id 0 DracoLord
    dw $0166 ; id 1 Zoma

; E-0199 (derived: list for entry $160 (DracoLord) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults160::
Data_00E_732A:: ; address name
    dw $0161 ; id 0 LordDraco
    dw $0166 ; id 1 Zoma

; E-0199 (derived: list for entry $161 (LordDraco) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults161::
Data_00E_732E:: ; address name
    dw $0165 ; id 0 Baramos

; E-0199 (derived: list for entry $163 (Sidoh) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults163::
Data_00E_7330:: ; address name
    dw $0164 ; id 0 Genosidoh

; E-0199 (derived: list for entry $164 (Genosidoh) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults164::
Data_00E_7332:: ; address name
    dw $016D ; id 0 Mudou

; E-0199 (derived: list for entry $166 (Zoma) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults166::
Data_00E_7334:: ; address name
    dw $0167 ; id 0 AsuraZoma
    dw $016E ; id 1 DeathMore

; E-0199 (derived: list for entry $167 (AsuraZoma) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults167::
Data_00E_7338:: ; address name
    dw $0169 ; id 0 PsychoPiz
    dw $016A ; id 1 Esterk

; E-0199 (derived: list for entry $169 (PsychoPiz) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults169::
Data_00E_733C:: ; address name
    dw $0172 ; id 0 Orgodemir

; E-0199 (derived: list for entry $16A (Esterk) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults16A::
Data_00E_733E:: ; address name
    dw $016B ; id 0 Mirudraas

; E-0199 (derived: list for entry $16B (Mirudraas) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults16B::
Data_00E_7340:: ; address name
    dw $016C ; id 0 Mirudraas
    dw $016E ; id 1 DeathMore

; E-0199 (derived: list for entry $16C (Mirudraas) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults16C::
Data_00E_7344:: ; address name
    dw $016E ; id 0 DeathMore

; E-0199 (derived: list for entry $16D (Mudou) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults16D::
Data_00E_7346:: ; address name
    dw $016F ; id 0 DeathMore

; E-0199 (derived: list for entry $16F (DeathMore) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults16F::
Data_00E_7348:: ; address name
    dw $0170 ; id 0 DeathMore

; E-0199 (derived: list for entry $170 (DeathMore) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults170::
Data_00E_734A:: ; address name
    dw $0171 ; id 0 Darkdrium

; E-0199 (derived: list for entry $171 (Darkdrium) of BreedSpeciesResultTable; it runs to the next list)
; record: child species
BreedSpeciesResults171::
Data_00E_734C:: ; address name
    dw $0173 ; id 0 Orgodemir

; E-0199 (C1: stage 2, when stage 1 finds nothing: the byte list at $734E + 2 * parent A's species holds families compared with parent B's family (record +$D & $0F); $FE moves on only when wArg1 = 2; $FF ends; a match takes result [index] from BreedFamilyResultTable)
; record: list
BreedFamilyRuleTable::
Data_00E_734E:: ; address name
    dw BreedFamilyRules000 ; id 0
    dw BreedFamilyRules000 ; id 1 DrakSlime
    dw BreedFamilyRules000 ; id 2 SpotSlime
    dw BreedFamilyRules000 ; id 3 WingSlime
    dw BreedFamilyRules004 ; id 4 TreeSlime
    dw BreedFamilyRules000 ; id 5 Snaily
    dw BreedFamilyRules000 ; id 6 SlimeNite
    dw BreedFamilyRules000 ; id 7 Babble
    dw BreedFamilyRules000 ; id 8 BoxSlime
    dw BreedFamilyRules000 ; id 9 PearlGel
    dw BreedFamilyRules000 ; id 10 Slime
    dw BreedFamilyRules00B ; id 11 Healer
    dw BreedFamilyRules000 ; id 12 FangSlime
    dw BreedFamilyRules000 ; id 13 RockSlime
    dw BreedFamilyRules000 ; id 14 SlimeBorg
    dw BreedFamilyRules000 ; id 15 Slabbit
    dw BreedFamilyRules000 ; id 16 KingSlime
    dw BreedFamilyRules000 ; id 17 Metaly
    dw BreedFamilyRules000 ; id 18 Metabble
    dw BreedFamilyRules000 ; id 19 SpotKing
    dw BreedFamilyRules000 ; id 20 TropicGel
    dw BreedFamilyRules015 ; id 21 MimeSlime
    dw BreedFamilyRules000 ; id 22 HaloSlime
    dw BreedFamilyRules000 ; id 23 MetalKing
    dw BreedFamilyRules000 ; id 24 GoldSlime
    dw BreedFamilyRules000 ; id 25 GranSlime
    dw BreedFamilyRules01A ; id 26 WonderEgg
    dw BreedFamilyRules000 ; id 27 Butch
    dw BreedFamilyRules000 ; id 28 ?
    dw BreedFamilyRules000 ; id 29 ?
    dw BreedFamilyRules000 ; id 30 ?
    dw BreedFamilyRules000 ; id 31 ?
    dw BreedFamilyRules000 ; id 32 ?
    dw BreedFamilyRules000 ; id 33 ?
    dw BreedFamilyRules000 ; id 34 ?
    dw BreedFamilyRules000 ; id 35 ?
    dw BreedFamilyRules000 ; id 36 DragonKid
    dw BreedFamilyRules000 ; id 37 Tortragon
    dw BreedFamilyRules000 ; id 38 Pteranod
    dw BreedFamilyRules027 ; id 39 Gasgon
    dw BreedFamilyRules000 ; id 40 FairyDrak
    dw BreedFamilyRules000 ; id 41 LizardMan
    dw BreedFamilyRules000 ; id 42 Poisongon
    dw BreedFamilyRules000 ; id 43 Swordgon
    dw BreedFamilyRules000 ; id 44 Drygon
    dw BreedFamilyRules000 ; id 45 Dragon
    dw BreedFamilyRules000 ; id 46 MiniDrak
    dw BreedFamilyRules000 ; id 47 MadDragon
    dw BreedFamilyRules000 ; id 48 Rayburn
    dw BreedFamilyRules000 ; id 49 Chamelgon
    dw BreedFamilyRules000 ; id 50 LizardFly
    dw BreedFamilyRules000 ; id 51 Andreal
    dw BreedFamilyRules000 ; id 52 KingCobra
    dw BreedFamilyRules000 ; id 53 Vampirus
    dw BreedFamilyRules000 ; id 54 SnakeBat
    dw BreedFamilyRules000 ; id 55 Spikerous
    dw BreedFamilyRules000 ; id 56 GreatDrak
    dw BreedFamilyRules000 ; id 57 Crestpent
    dw BreedFamilyRules000 ; id 58 WingSnake
    dw BreedFamilyRules000 ; id 59 Coatol
    dw BreedFamilyRules000 ; id 60 Orochi
    dw BreedFamilyRules000 ; id 61 BattleRex
    dw BreedFamilyRules000 ; id 62 SkyDragon
    dw BreedFamilyRules000 ; id 63 Serpentia
    dw BreedFamilyRules000 ; id 64 Divinegon
    dw BreedFamilyRules000 ; id 65 Orligon
    dw BreedFamilyRules000 ; id 66 GigaDraco
    dw BreedFamilyRules000 ; id 67 ?
    dw BreedFamilyRules000 ; id 68 ?
    dw BreedFamilyRules000 ; id 69 ?
    dw BreedFamilyRules000 ; id 70 ?
    dw BreedFamilyRules047 ; id 71 Tonguella
    dw BreedFamilyRules048 ; id 72 Almiraj
    dw BreedFamilyRules049 ; id 73 CatFly
    dw BreedFamilyRules000 ; id 74 PillowRat
    dw BreedFamilyRules04B ; id 75 Saccer
    dw BreedFamilyRules04C ; id 76 GulpBeast
    dw BreedFamilyRules000 ; id 77 Skullroo
    dw BreedFamilyRules000 ; id 78 WindBeast
    dw BreedFamilyRules000 ; id 79 Beavern
    dw BreedFamilyRules000 ; id 80 Antbear
    dw BreedFamilyRules051 ; id 81 SuperTen
    dw BreedFamilyRules000 ; id 82 IronTurt
    dw BreedFamilyRules000 ; id 83 Mommonja
    dw BreedFamilyRules000 ; id 84 HammerMan
    dw BreedFamilyRules055 ; id 85 Grizzly
    dw BreedFamilyRules056 ; id 86 Yeti
    dw BreedFamilyRules000 ; id 87 ArrowDog
    dw BreedFamilyRules000 ; id 88 NoctoKing
    dw BreedFamilyRules000 ; id 89 BeastNite
    dw BreedFamilyRules000 ; id 90 MadGopher
    dw BreedFamilyRules000 ; id 91 FairyRat
    dw BreedFamilyRules000 ; id 92 Unicorn
    dw BreedFamilyRules05D ; id 93 Goategon
    dw BreedFamilyRules05E ; id 94 WildApe
    dw BreedFamilyRules05F ; id 95 Trumpeter
    dw BreedFamilyRules000 ; id 96 KingLeo
    dw BreedFamilyRules061 ; id 97 DarkHorn
    dw BreedFamilyRules000 ; id 98 MadCat
    dw BreedFamilyRules063 ; id 99 BigEye
    dw BreedFamilyRules000 ; id 100 Gorago
    dw BreedFamilyRules065 ; id 101 CatMage
    dw BreedFamilyRules066 ; id 102 Dumbira
    dw BreedFamilyRules000 ; id 103 ?
    dw BreedFamilyRules000 ; id 104 ?
    dw BreedFamilyRules000 ; id 105 ?
    dw BreedFamilyRules06A ; id 106 Picky
    dw BreedFamilyRules06B ; id 107 Wyvern
    dw BreedFamilyRules06C ; id 108 BullBird
    dw BreedFamilyRules000 ; id 109 Florajay
    dw BreedFamilyRules06E ; id 110 DuckKite
    dw BreedFamilyRules000 ; id 111 MadPecker
    dw BreedFamilyRules000 ; id 112 MadRaven
    dw BreedFamilyRules000 ; id 113 MistyWing
    dw BreedFamilyRules000 ; id 114 AquaHawk
    dw BreedFamilyRules000 ; id 115 Dracky
    dw BreedFamilyRules074 ; id 116 KiteHawk
    dw BreedFamilyRules075 ; id 117 BigRoost
    dw BreedFamilyRules000 ; id 118 StubBird
    dw BreedFamilyRules077 ; id 119 LandOwl
    dw BreedFamilyRules078 ; id 120 MadGoose
    dw BreedFamilyRules079 ; id 121 MadCondor
    dw BreedFamilyRules07A ; id 122 Emyu
    dw BreedFamilyRules000 ; id 123 Blizzardy
    dw BreedFamilyRules07C ; id 124 Phoenix
    dw BreedFamilyRules000 ; id 125 ZapBird
    dw BreedFamilyRules07E ; id 126 Garudian
    dw BreedFamilyRules000 ; id 127 WhipBird
    dw BreedFamilyRules000 ; id 128 FunkyBird
    dw BreedFamilyRules081 ; id 129 RainHawk
    dw BreedFamilyRules000 ; id 130 Azurile
    dw BreedFamilyRules083 ; id 131 Shantak
    dw BreedFamilyRules000 ; id 132 CragDevil
    dw BreedFamilyRules000 ; id 133 ?
    dw BreedFamilyRules000 ; id 134 ?
    dw BreedFamilyRules000 ; id 135 ?
    dw BreedFamilyRules000 ; id 136 ?
    dw BreedFamilyRules000 ; id 137 ?
    dw BreedFamilyRules000 ; id 138 ?
    dw BreedFamilyRules000 ; id 139 ?
    dw BreedFamilyRules000 ; id 140 ?
    dw BreedFamilyRules08D ; id 141 MadPlant
    dw BreedFamilyRules000 ; id 142 FireWeed
    dw BreedFamilyRules000 ; id 143 FloraMan
    dw BreedFamilyRules000 ; id 144 WingTree
    dw BreedFamilyRules000 ; id 145 CactiBall
    dw BreedFamilyRules000 ; id 146 Gulpple
    dw BreedFamilyRules000 ; id 147 Toadstool
    dw BreedFamilyRules094 ; id 148 AmberWeed
    dw BreedFamilyRules000 ; id 149 Slurperon
    dw BreedFamilyRules096 ; id 150 Stubsuck
    dw BreedFamilyRules000 ; id 151 Oniono
    dw BreedFamilyRules000 ; id 152 DanceVegi
    dw BreedFamilyRules000 ; id 153 TreeBoy
    dw BreedFamilyRules000 ; id 154 Devipine
    dw BreedFamilyRules000 ; id 155 FaceTree
    dw BreedFamilyRules09C ; id 156 HerbMan
    dw BreedFamilyRules000 ; id 157 BeanMan
    dw BreedFamilyRules000 ; id 158 EvilSeed
    dw BreedFamilyRules000 ; id 159 ManEater
    dw BreedFamilyRules000 ; id 160 Snapper
    dw BreedFamilyRules000 ; id 161 GhosTree
    dw BreedFamilyRules000 ; id 162 Rosevine
    dw BreedFamilyRules000 ; id 163 Egdracil
    dw BreedFamilyRules000 ; id 164 Warubou
    dw BreedFamilyRules000 ; id 165 Watabou
    dw BreedFamilyRules0A6 ; id 166 Eggplaton
    dw BreedFamilyRules000 ; id 167 FooHero
    dw BreedFamilyRules000 ; id 168 ?
    dw BreedFamilyRules000 ; id 169 ?
    dw BreedFamilyRules000 ; id 170 ?
    dw BreedFamilyRules000 ; id 171 ?
    dw BreedFamilyRules000 ; id 172 ?
    dw BreedFamilyRules000 ; id 173 ?
    dw BreedFamilyRules000 ; id 174 ?
    dw BreedFamilyRules000 ; id 175 ?
    dw BreedFamilyRules0B0 ; id 176 GiantSlug
    dw BreedFamilyRules000 ; id 177 Catapila
    dw BreedFamilyRules000 ; id 178 Gophecada
    dw BreedFamilyRules0B3 ; id 179 Butterfly
    dw BreedFamilyRules0B4 ; id 180 WeedBug
    dw BreedFamilyRules0B5 ; id 181 GiantWorm
    dw BreedFamilyRules0B6 ; id 182 Lipsy
    dw BreedFamilyRules000 ; id 183 StagBug
    dw BreedFamilyRules0B8 ; id 184 Pyuro
    dw BreedFamilyRules000 ; id 185 ArmyAnt
    dw BreedFamilyRules000 ; id 186 GoHopper
    dw BreedFamilyRules0BB ; id 187 TailEater
    dw BreedFamilyRules0BC ; id 188 ArmorPede
    dw BreedFamilyRules0BD ; id 189 Eyeder
    dw BreedFamilyRules000 ; id 190 GiantMoth
    dw BreedFamilyRules0BF ; id 191 Droll
    dw BreedFamilyRules000 ; id 192 ArmyCrab
    dw BreedFamilyRules0C1 ; id 193 MadHornet
    dw BreedFamilyRules000 ; id 194 Belzebub
    dw BreedFamilyRules0C3 ; id 195 WarMantis
    dw BreedFamilyRules000 ; id 196 HornBeet
    dw BreedFamilyRules0C5 ; id 197 Sickler
    dw BreedFamilyRules000 ; id 198 Armorpion
    dw BreedFamilyRules000 ; id 199 Digster
    dw BreedFamilyRules000 ; id 200 Skularach
    dw BreedFamilyRules000 ; id 201 MultiEyes
    dw BreedFamilyRules000 ; id 202 ?
    dw BreedFamilyRules000 ; id 203 ?
    dw BreedFamilyRules000 ; id 204 ?
    dw BreedFamilyRules000 ; id 205 ?
    dw BreedFamilyRules000 ; id 206 ?
    dw BreedFamilyRules000 ; id 207 ?
    dw BreedFamilyRules000 ; id 208 ?
    dw BreedFamilyRules000 ; id 209 ?
    dw BreedFamilyRules000 ; id 210 ?
    dw BreedFamilyRules0D3 ; id 211 Pixy
    dw BreedFamilyRules0D4 ; id 212 MedusaEye
    dw BreedFamilyRules000 ; id 213 AgDevil
    dw BreedFamilyRules0D6 ; id 214 Demonite
    dw BreedFamilyRules0D7 ; id 215 DarkEye
    dw BreedFamilyRules0D8 ; id 216 EyeBall
    dw BreedFamilyRules0D9 ; id 217 SkulRider
    dw BreedFamilyRules0DA ; id 218 EvilBeast
    dw BreedFamilyRules000 ; id 219 Bubblemon
    dw BreedFamilyRules0DC ; id 220 1EyeClown
    dw BreedFamilyRules0DD ; id 221 Gremlin
    dw BreedFamilyRules0DE ; id 222 ArcDemon
    dw BreedFamilyRules000 ; id 223 Lionex
    dw BreedFamilyRules0E0 ; id 224 GoatHorn
    dw BreedFamilyRules000 ; id 225 Orc
    dw BreedFamilyRules0E2 ; id 226 Ogre
    dw BreedFamilyRules0E3 ; id 227 GateGuard
    dw BreedFamilyRules000 ; id 228 ChopClown
    dw BreedFamilyRules0E5 ; id 229 BossTroll
    dw BreedFamilyRules000 ; id 230 Grendal
    dw BreedFamilyRules000 ; id 231 Akubar
    dw BreedFamilyRules000 ; id 232 MadKnight
    dw BreedFamilyRules000 ; id 233 EvilWell
    dw BreedFamilyRules000 ; id 234 Gigantes
    dw BreedFamilyRules0EB ; id 235 Centasaur
    dw BreedFamilyRules000 ; id 236 EvilArmor
    dw BreedFamilyRules000 ; id 237 Jamirus
    dw BreedFamilyRules000 ; id 238 Durran
    dw BreedFamilyRules000 ; id 239 Titanis
    dw BreedFamilyRules000 ; id 240 LampGenie
    dw BreedFamilyRules000 ; id 241 ?
    dw BreedFamilyRules000 ; id 242 ?
    dw BreedFamilyRules000 ; id 243 ?
    dw BreedFamilyRules000 ; id 244 ?
    dw BreedFamilyRules000 ; id 245 ?
    dw BreedFamilyRules0F6 ; id 246 Spooky
    dw BreedFamilyRules0F7 ; id 247 Skullgon
    dw BreedFamilyRules000 ; id 248 PutrePup
    dw BreedFamilyRules0F9 ; id 249 RotRaven
    dw BreedFamilyRules000 ; id 250 Mummy
    dw BreedFamilyRules0FB ; id 251 DarkCrab
    dw BreedFamilyRules0FC ; id 252 DeadNite
    dw BreedFamilyRules000 ; id 253 Shadow
    dw BreedFamilyRules0FE ; id 254 Skulpent
    dw BreedFamilyRules0FF ; id 255 Hork
    dw BreedFamilyRules100 ; id 256 Mudron
    dw BreedFamilyRules101 ; id 257 NiteWhip
    dw BreedFamilyRules000 ; id 258 WindMerge
    dw BreedFamilyRules000 ; id 259 Reaper
    dw BreedFamilyRules000 ; id 260 Inverzon
    dw BreedFamilyRules105 ; id 261 FoxFire
    dw BreedFamilyRules000 ; id 262 CaptDead
    dw BreedFamilyRules107 ; id 263 DeadNoble
    dw BreedFamilyRules108 ; id 264 WhiteKing
    dw BreedFamilyRules109 ; id 265 BoneSlave
    dw BreedFamilyRules10A ; id 266 Skeletor
    dw BreedFamilyRules000 ; id 267 Servant
    dw BreedFamilyRules000 ; id 268 Lazamanus
    dw BreedFamilyRules000 ; id 269 Copycat
    dw BreedFamilyRules10E ; id 270 MadSpirit
    dw BreedFamilyRules10F ; id 271 PomPomBom
    dw BreedFamilyRules000 ; id 272 Niterich
    dw BreedFamilyRules000 ; id 273 ?
    dw BreedFamilyRules000 ; id 274 ?
    dw BreedFamilyRules000 ; id 275 ?
    dw BreedFamilyRules000 ; id 276 ?
    dw BreedFamilyRules000 ; id 277 ?
    dw BreedFamilyRules000 ; id 278 ?
    dw BreedFamilyRules000 ; id 279 ?
    dw BreedFamilyRules000 ; id 280 ?
    dw BreedFamilyRules119 ; id 281 JewelBag
    dw BreedFamilyRules000 ; id 282 EvilWand
    dw BreedFamilyRules000 ; id 283 MadCandle
    dw BreedFamilyRules000 ; id 284 CoilBird
    dw BreedFamilyRules000 ; id 285 Facer
    dw BreedFamilyRules000 ; id 286 SpikyBoy
    dw BreedFamilyRules000 ; id 287 MadMirror
    dw BreedFamilyRules120 ; id 288 RogueNite
    dw BreedFamilyRules121 ; id 289 Puppetor
    dw BreedFamilyRules000 ; id 290 Goopi
    dw BreedFamilyRules000 ; id 291 Voodoll
    dw BreedFamilyRules000 ; id 292 MetalDrak
    dw BreedFamilyRules000 ; id 293 Balzak
    dw BreedFamilyRules000 ; id 294 SabreMan
    dw BreedFamilyRules000 ; id 295 CurseLamp
    dw BreedFamilyRules000 ; id 296 Brushead
    dw BreedFamilyRules129 ; id 297 Roboster
    dw BreedFamilyRules12A ; id 298 Roboster2
    dw BreedFamilyRules000 ; id 299 EvilPot
    dw BreedFamilyRules12C ; id 300 Gismo
    dw BreedFamilyRules12D ; id 301 LavaMan
    dw BreedFamilyRules12E ; id 302 IceMan
    dw BreedFamilyRules000 ; id 303 Mimic
    dw BreedFamilyRules000 ; id 304 Exaucers
    dw BreedFamilyRules000 ; id 305 MudDoll
    dw BreedFamilyRules000 ; id 306 Golem
    dw BreedFamilyRules000 ; id 307 StoneMan
    dw BreedFamilyRules000 ; id 308 BombCrag
    dw BreedFamilyRules000 ; id 309 GoldGolem
    dw BreedFamilyRules136 ; id 310 DarkMate
    dw BreedFamilyRules000 ; id 311 ProtoMech
    dw BreedFamilyRules000 ; id 312 CloudKing
    dw BreedFamilyRules000 ; id 313 ?
    dw BreedFamilyRules000 ; id 314 ?
    dw BreedFamilyRules000 ; id 315 ?
    dw BreedFamilyRules13C ; id 316 Petiteel
    dw BreedFamilyRules000 ; id 317 Moray
    dw BreedFamilyRules000 ; id 318 WalrusMan
    dw BreedFamilyRules000 ; id 319 RayGigas
    dw BreedFamilyRules000 ; id 320 Anemon
    dw BreedFamilyRules141 ; id 321 Aquarella
    dw BreedFamilyRules000 ; id 322 Merman
    dw BreedFamilyRules000 ; id 323 Octokid
    dw BreedFamilyRules000 ; id 324 PutreFish
    dw BreedFamilyRules145 ; id 325 Octoreach
    dw BreedFamilyRules146 ; id 326 Angleron
    dw BreedFamilyRules000 ; id 327 FishRider
    dw BreedFamilyRules000 ; id 328 RushFish
    dw BreedFamilyRules149 ; id 329 Gamanian
    dw BreedFamilyRules14A ; id 330 Clawster
    dw BreedFamilyRules000 ; id 331 CancerMan
    dw BreedFamilyRules14C ; id 332 RogueWave
    dw BreedFamilyRules000 ; id 333 Scallopa
    dw BreedFamilyRules000 ; id 334 SeaHorse
    dw BreedFamilyRules14F ; id 335 HoodSquid
    dw BreedFamilyRules000 ; id 336 MerTiger
    dw BreedFamilyRules000 ; id 337 AxeShark
    dw BreedFamilyRules152 ; id 338 Octogon
    dw BreedFamilyRules153 ; id 339 KingSquid
    dw BreedFamilyRules000 ; id 340 Digong
    dw BreedFamilyRules000 ; id 341 WhaleMage
    dw BreedFamilyRules000 ; id 342 Aquadon
    dw BreedFamilyRules000 ; id 343 Octoraid
    dw BreedFamilyRules000 ; id 344 Grakos
    dw BreedFamilyRules000 ; id 345 Poseidon
    dw BreedFamilyRules000 ; id 346 Pumpoise
    dw BreedFamilyRules000 ; id 347 Starfish
    dw BreedFamilyRules000 ; id 348 ?
    dw BreedFamilyRules000 ; id 349 ?
    dw BreedFamilyRules000 ; id 350 ?
    dw BreedFamilyRules000 ; id 351 DracoLord
    dw BreedFamilyRules000 ; id 352 DracoLord
    dw BreedFamilyRules000 ; id 353 LordDraco
    dw BreedFamilyRules000 ; id 354 Hargon
    dw BreedFamilyRules000 ; id 355 Sidoh
    dw BreedFamilyRules000 ; id 356 Genosidoh
    dw BreedFamilyRules000 ; id 357 Baramos
    dw BreedFamilyRules000 ; id 358 Zoma
    dw BreedFamilyRules000 ; id 359 AsuraZoma
    dw BreedFamilyRules000 ; id 360 Pizzaro
    dw BreedFamilyRules000 ; id 361 PsychoPiz
    dw BreedFamilyRules000 ; id 362 Esterk
    dw BreedFamilyRules000 ; id 363 Mirudraas
    dw BreedFamilyRules000 ; id 364 Mirudraas
    dw BreedFamilyRules000 ; id 365 Mudou
    dw BreedFamilyRules000 ; id 366 DeathMore
    dw BreedFamilyRules000 ; id 367 DeathMore
    dw BreedFamilyRules000 ; id 368 DeathMore
    dw BreedFamilyRules000 ; id 369 Darkdrium
    dw BreedFamilyRules000 ; id 370 Orgodemir
    dw BreedFamilyRules000 ; id 371 Orgodemir
    dw BreedFamilyRules000 ; id 372 Darck
    dw BreedFamilyRules000 ; id 373 Tatsu
    dw BreedFamilyRules000 ; id 374 Diago
    dw BreedFamilyRules000 ; id 375 Samsi
    dw BreedFamilyRules000 ; id 376 Bazoo
    dw BreedFamilyRules000 ; id 377 ?
    dw BreedFamilyRules000 ; id 378 ?
    dw BreedFamilyRules000 ; id 379 ?
    dw BreedFamilyRules000 ; id 380 Lamia
    dw BreedFamilyRules000 ; id 381 Dimensaur
    dw BreedFamilyRules000 ; id 382 Kagebou
    dw BreedFamilyRules000 ; id 383 ?

; E-0199 (derived: list for entry $00 of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules000::
Data_00E_764E:: ; address name
    db $FF ; id 0

; E-0199 (derived: list for entry $04 (TreeSlime) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules004::
Data_00E_764F:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $0B (Healer) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules00B::
Data_00E_7651:: ; address name
    db $FE, $07, $FF ; id 0

; E-0199 (derived: list for entry $15 (MimeSlime) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules015::
Data_00E_7654:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $1A (WonderEgg) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules01A::
Data_00E_7656:: ; address name
    db $04, $06, $03, $FF ; id 0

; E-0199 (derived: list for entry $27 (Gasgon) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules027::
Data_00E_765A:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $47 (Tonguella) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules047::
Data_00E_765C:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $48 (Almiraj) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules048::
Data_00E_765E:: ; address name
    db $01, $FF ; id 0

; E-0199 (derived: list for entry $49 (CatFly) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules049::
Data_00E_7660:: ; address name
    db $03, $FF ; id 0

; E-0199 (derived: list for entry $4B (Saccer) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules04B::
Data_00E_7662:: ; address name
    db $01, $FF ; id 0

; E-0199 (derived: list for entry $4C (GulpBeast) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules04C::
Data_00E_7664:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $51 (SuperTen) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules051::
Data_00E_7666:: ; address name
    db $01, $FF ; id 0

; E-0199 (derived: list for entry $55 (Grizzly) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules055::
Data_00E_7668:: ; address name
    db $01, $06, $00, $FF ; id 0

; E-0199 (derived: list for entry $56 (Yeti) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules056::
Data_00E_766C:: ; address name
    db $01, $00, $FF ; id 0

; E-0199 (derived: list for entry $5D (Goategon) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules05D::
Data_00E_766F:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $5E (WildApe) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules05E::
Data_00E_7671:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $5F (Trumpeter) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules05F::
Data_00E_7673:: ; address name
    db $01, $00, $FF ; id 0

; E-0199 (derived: list for entry $61 (DarkHorn) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules061::
Data_00E_7676:: ; address name
    db $0A, $FF ; id 0

; E-0199 (derived: list for entry $63 (BigEye) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules063::
Data_00E_7678:: ; address name
    db $01, $FF ; id 0

; E-0199 (derived: list for entry $65 (CatMage) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules065::
Data_00E_767A:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $66 (Dumbira) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules066::
Data_00E_767C:: ; address name
    db $01, $00, $FF ; id 0

; E-0199 (derived: list for entry $6A (Picky) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules06A::
Data_00E_767F:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $6B (Wyvern) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules06B::
Data_00E_7681:: ; address name
    db $01, $07, $FF ; id 0

; E-0199 (derived: list for entry $6C (BullBird) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules06C::
Data_00E_7684:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $6E (DuckKite) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules06E::
Data_00E_7686:: ; address name
    db $08, $FF ; id 0

; E-0199 (derived: list for entry $74 (KiteHawk) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules074::
Data_00E_7688:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $75 (BigRoost) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules075::
Data_00E_768A:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $77 (LandOwl) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules077::
Data_00E_768C:: ; address name
    db $01, $07, $06, $FF ; id 0

; E-0199 (derived: list for entry $78 (MadGoose) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules078::
Data_00E_7690:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $79 (MadCondor) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules079::
Data_00E_7692:: ; address name
    db $01, $07, $FF ; id 0

; E-0199 (derived: list for entry $7A (Emyu) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules07A::
Data_00E_7695:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $7C (Phoenix) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules07C::
Data_00E_7697:: ; address name
    db $01, $07, $FF ; id 0

; E-0199 (derived: list for entry $7E (Garudian) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules07E::
Data_00E_769A:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $81 (RainHawk) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules081::
Data_00E_769C:: ; address name
    db $0A, $FF ; id 0

; E-0199 (derived: list for entry $83 (Shantak) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules083::
Data_00E_769E:: ; address name
    db $0A, $FF ; id 0

; E-0199 (derived: list for entry $8D (MadPlant) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules08D::
Data_00E_76A0:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $94 (AmberWeed) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules094::
Data_00E_76A2:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $96 (Stubsuck) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules096::
Data_00E_76A4:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $9C (HerbMan) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules09C::
Data_00E_76A6:: ; address name
    db $01, $FF ; id 0

; E-0199 (derived: list for entry $A6 (Eggplaton) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0A6::
Data_00E_76A8:: ; address name
    db $06, $07, $FF ; id 0

; E-0199 (derived: list for entry $B0 (GiantSlug) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0B0::
Data_00E_76AB:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $B3 (Butterfly) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0B3::
Data_00E_76AD:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $B4 (WeedBug) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0B4::
Data_00E_76AF:: ; address name
    db $04, $FF ; id 0

; E-0199 (derived: list for entry $B5 (GiantWorm) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0B5::
Data_00E_76B1:: ; address name
    db $08, $FF ; id 0

; E-0199 (derived: list for entry $B6 (Lipsy) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0B6::
Data_00E_76B3:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $B8 (Pyuro) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0B8::
Data_00E_76B5:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $BB (TailEater) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0BB::
Data_00E_76B7:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $BC (ArmorPede) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0BC::
Data_00E_76B9:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $BD (Eyeder) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0BD::
Data_00E_76BB:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $BF (Droll) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0BF::
Data_00E_76BD:: ; address name
    db $01, $07, $FF ; id 0

; E-0199 (derived: list for entry $C1 (MadHornet) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0C1::
Data_00E_76C0:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $C3 (WarMantis) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0C3::
Data_00E_76C2:: ; address name
    db $06, $00, $FF ; id 0

; E-0199 (derived: list for entry $C5 (Sickler) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0C5::
Data_00E_76C5:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $D3 (Pixy) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0D3::
Data_00E_76C7:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $D4 (MedusaEye) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0D4::
Data_00E_76C9:: ; address name
    db $01, $02, $07, $FF ; id 0

; E-0199 (derived: list for entry $D6 (Demonite) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0D6::
Data_00E_76CD:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $D7 (DarkEye) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0D7::
Data_00E_76CF:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $D8 (EyeBall) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0D8::
Data_00E_76D1:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $D9 (SkulRider) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0D9::
Data_00E_76D3:: ; address name
    db $01, $02, $07, $FF ; id 0

; E-0199 (derived: list for entry $DA (EvilBeast) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0DA::
Data_00E_76D7:: ; address name
    db $01, $02, $07, $FF ; id 0

; E-0199 (derived: list for entry $DC (1EyeClown) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0DC::
Data_00E_76DB:: ; address name
    db $07, $FF ; id 0

; E-0199 (derived: list for entry $DD (Gremlin) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0DD::
Data_00E_76DD:: ; address name
    db $01, $07, $02, $FF ; id 0

; E-0199 (derived: list for entry $DE (ArcDemon) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0DE::
Data_00E_76E1:: ; address name
    db $07, $02, $01, $08, $FF ; id 0

; E-0199 (derived: list for entry $E0 (GoatHorn) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0E0::
Data_00E_76E6:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $E2 (Ogre) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0E2::
Data_00E_76E8:: ; address name
    db $01, $07, $02, $08, $FF ; id 0

; E-0199 (derived: list for entry $E3 (GateGuard) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0E3::
Data_00E_76ED:: ; address name
    db $01, $02, $08, $FF ; id 0

; E-0199 (derived: list for entry $E5 (BossTroll) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0E5::
Data_00E_76F1:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $EB (Centasaur) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0EB::
Data_00E_76F3:: ; address name
    db $0A, $FF ; id 0

; E-0199 (derived: list for entry $F6 (Spooky) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0F6::
Data_00E_76F5:: ; address name
    db $06, $02, $FF ; id 0

; E-0199 (derived: list for entry $F7 (Skullgon) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0F7::
Data_00E_76F8:: ; address name
    db $01, $03, $FF ; id 0

; E-0199 (derived: list for entry $F9 (RotRaven) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0F9::
Data_00E_76FB:: ; address name
    db $03, $FF ; id 0

; E-0199 (derived: list for entry $FB (DarkCrab) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0FB::
Data_00E_76FD:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $FC (DeadNite) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0FC::
Data_00E_76FF:: ; address name
    db $09, $03, $FF ; id 0

; E-0199 (derived: list for entry $FE (Skulpent) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0FE::
Data_00E_7702:: ; address name
    db $01, $06, $FF ; id 0

; E-0199 (derived: list for entry $FF (Hork) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules0FF::
Data_00E_7705:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $100 (Mudron) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules100::
Data_00E_7707:: ; address name
    db $03, $FF ; id 0

; E-0199 (derived: list for entry $101 (NiteWhip) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules101::
Data_00E_7709:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $105 (FoxFire) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules105::
Data_00E_770B:: ; address name
    db $02, $FF ; id 0

; E-0199 (derived: list for entry $107 (DeadNoble) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules107::
Data_00E_770D:: ; address name
    db $01, $03, $FF ; id 0

; E-0199 (derived: list for entry $108 (WhiteKing) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules108::
Data_00E_7710:: ; address name
    db $01, $06, $FF ; id 0

; E-0199 (derived: list for entry $109 (BoneSlave) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules109::
Data_00E_7713:: ; address name
    db $01, $09, $03, $FF ; id 0

; E-0199 (derived: list for entry $10A (Skeletor) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules10A::
Data_00E_7717:: ; address name
    db $01, $03, $FF ; id 0

; E-0199 (derived: list for entry $10E (MadSpirit) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules10E::
Data_00E_771A:: ; address name
    db $06, $01, $FF ; id 0

; E-0199 (derived: list for entry $10F (PomPomBom) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules10F::
Data_00E_771D:: ; address name
    db $03, $FF ; id 0

; E-0199 (derived: list for entry $119 (JewelBag) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules119::
Data_00E_771F:: ; address name
    db $08, $FF ; id 0

; E-0199 (derived: list for entry $120 (RogueNite) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules120::
Data_00E_7721:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $121 (Puppetor) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules121::
Data_00E_7723:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $129 (Roboster) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules129::
Data_00E_7725:: ; address name
    db $00, $01, $03, $07, $05, $FF ; id 0

; E-0199 (derived: list for entry $12A (Roboster2) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules12A::
Data_00E_772B:: ; address name
    db $00, $01, $03, $FF ; id 0

; E-0199 (derived: list for entry $12C (Gismo) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules12C::
Data_00E_772F:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $12D (LavaMan) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules12D::
Data_00E_7731:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $12E (IceMan) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules12E::
Data_00E_7733:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $136 (DarkMate) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules136::
Data_00E_7735:: ; address name
    db $05, $FF ; id 0

; E-0199 (derived: list for entry $13C (Petiteel) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules13C::
Data_00E_7737:: ; address name
    db $02, $08, $01, $06, $FF ; id 0

; E-0199 (derived: list for entry $141 (Aquarella) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules141::
Data_00E_773C:: ; address name
    db $05, $FF ; id 0

; E-0199 (derived: list for entry $145 (Octoreach) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules145::
Data_00E_773E:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $146 (Angleron) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules146::
Data_00E_7740:: ; address name
    db $01, $FF ; id 0

; E-0199 (derived: list for entry $149 (Gamanian) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules149::
Data_00E_7742:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $14A (Clawster) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules14A::
Data_00E_7744:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $14C (RogueWave) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules14C::
Data_00E_7746:: ; address name
    db $06, $FF ; id 0

; E-0199 (derived: list for entry $14F (HoodSquid) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules14F::
Data_00E_7748:: ; address name
    db $00, $FF ; id 0

; E-0199 (derived: list for entry $152 (Octogon) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules152::
Data_00E_774A:: ; address name
    db $00, $0A, $FF ; id 0

; E-0199 (derived: list for entry $153 (KingSquid) of BreedFamilyRuleTable; it runs to the next list)
; record: partner families, then $FF
BreedFamilyRules153::
Data_00E_774D:: ; address name
    db $00, $FF ; id 0

; E-0199 (C1: stage 2 result lists, indexed by parent A's species)
; record: list
BreedFamilyResultTable::
Data_00E_774F:: ; address name
    dw BreedFamilyResults000 ; id 0
    dw BreedFamilyResults001 ; id 1 DrakSlime
    dw BreedFamilyResults001 ; id 2 SpotSlime
    dw BreedFamilyResults001 ; id 3 WingSlime
    dw BreedFamilyResults001 ; id 4 TreeSlime
    dw BreedFamilyResults005 ; id 5 Snaily
    dw BreedFamilyResults005 ; id 6 SlimeNite
    dw BreedFamilyResults005 ; id 7 Babble
    dw BreedFamilyResults005 ; id 8 BoxSlime
    dw BreedFamilyResults005 ; id 9 PearlGel
    dw BreedFamilyResults005 ; id 10 Slime
    dw BreedFamilyResults005 ; id 11 Healer
    dw BreedFamilyResults00C ; id 12 FangSlime
    dw BreedFamilyResults00C ; id 13 RockSlime
    dw BreedFamilyResults00C ; id 14 SlimeBorg
    dw BreedFamilyResults00C ; id 15 Slabbit
    dw BreedFamilyResults00C ; id 16 KingSlime
    dw BreedFamilyResults00C ; id 17 Metaly
    dw BreedFamilyResults00C ; id 18 Metabble
    dw BreedFamilyResults00C ; id 19 SpotKing
    dw BreedFamilyResults00C ; id 20 TropicGel
    dw BreedFamilyResults00C ; id 21 MimeSlime
    dw BreedFamilyResults016 ; id 22 HaloSlime
    dw BreedFamilyResults016 ; id 23 MetalKing
    dw BreedFamilyResults016 ; id 24 GoldSlime
    dw BreedFamilyResults016 ; id 25 GranSlime
    dw BreedFamilyResults016 ; id 26 WonderEgg
    dw BreedFamilyResults01B ; id 27 Butch
    dw BreedFamilyResults01B ; id 28 ?
    dw BreedFamilyResults01B ; id 29 ?
    dw BreedFamilyResults01B ; id 30 ?
    dw BreedFamilyResults01B ; id 31 ?
    dw BreedFamilyResults01B ; id 32 ?
    dw BreedFamilyResults01B ; id 33 ?
    dw BreedFamilyResults01B ; id 34 ?
    dw BreedFamilyResults01B ; id 35 ?
    dw BreedFamilyResults01B ; id 36 DragonKid
    dw BreedFamilyResults01B ; id 37 Tortragon
    dw BreedFamilyResults01B ; id 38 Pteranod
    dw BreedFamilyResults01B ; id 39 Gasgon
    dw BreedFamilyResults028 ; id 40 FairyDrak
    dw BreedFamilyResults028 ; id 41 LizardMan
    dw BreedFamilyResults028 ; id 42 Poisongon
    dw BreedFamilyResults028 ; id 43 Swordgon
    dw BreedFamilyResults028 ; id 44 Drygon
    dw BreedFamilyResults028 ; id 45 Dragon
    dw BreedFamilyResults028 ; id 46 MiniDrak
    dw BreedFamilyResults028 ; id 47 MadDragon
    dw BreedFamilyResults028 ; id 48 Rayburn
    dw BreedFamilyResults028 ; id 49 Chamelgon
    dw BreedFamilyResults028 ; id 50 LizardFly
    dw BreedFamilyResults028 ; id 51 Andreal
    dw BreedFamilyResults028 ; id 52 KingCobra
    dw BreedFamilyResults028 ; id 53 Vampirus
    dw BreedFamilyResults028 ; id 54 SnakeBat
    dw BreedFamilyResults028 ; id 55 Spikerous
    dw BreedFamilyResults028 ; id 56 GreatDrak
    dw BreedFamilyResults028 ; id 57 Crestpent
    dw BreedFamilyResults028 ; id 58 WingSnake
    dw BreedFamilyResults028 ; id 59 Coatol
    dw BreedFamilyResults028 ; id 60 Orochi
    dw BreedFamilyResults028 ; id 61 BattleRex
    dw BreedFamilyResults028 ; id 62 SkyDragon
    dw BreedFamilyResults028 ; id 63 Serpentia
    dw BreedFamilyResults028 ; id 64 Divinegon
    dw BreedFamilyResults028 ; id 65 Orligon
    dw BreedFamilyResults028 ; id 66 GigaDraco
    dw BreedFamilyResults028 ; id 67 ?
    dw BreedFamilyResults028 ; id 68 ?
    dw BreedFamilyResults028 ; id 69 ?
    dw BreedFamilyResults028 ; id 70 ?
    dw BreedFamilyResults028 ; id 71 Tonguella
    dw BreedFamilyResults048 ; id 72 Almiraj
    dw BreedFamilyResults049 ; id 73 CatFly
    dw BreedFamilyResults04A ; id 74 PillowRat
    dw BreedFamilyResults04A ; id 75 Saccer
    dw BreedFamilyResults04C ; id 76 GulpBeast
    dw BreedFamilyResults04D ; id 77 Skullroo
    dw BreedFamilyResults04D ; id 78 WindBeast
    dw BreedFamilyResults04D ; id 79 Beavern
    dw BreedFamilyResults04D ; id 80 Antbear
    dw BreedFamilyResults04D ; id 81 SuperTen
    dw BreedFamilyResults052 ; id 82 IronTurt
    dw BreedFamilyResults052 ; id 83 Mommonja
    dw BreedFamilyResults052 ; id 84 HammerMan
    dw BreedFamilyResults052 ; id 85 Grizzly
    dw BreedFamilyResults056 ; id 86 Yeti
    dw BreedFamilyResults057 ; id 87 ArrowDog
    dw BreedFamilyResults057 ; id 88 NoctoKing
    dw BreedFamilyResults057 ; id 89 BeastNite
    dw BreedFamilyResults057 ; id 90 MadGopher
    dw BreedFamilyResults057 ; id 91 FairyRat
    dw BreedFamilyResults057 ; id 92 Unicorn
    dw BreedFamilyResults057 ; id 93 Goategon
    dw BreedFamilyResults05E ; id 94 WildApe
    dw BreedFamilyResults05F ; id 95 Trumpeter
    dw BreedFamilyResults060 ; id 96 KingLeo
    dw BreedFamilyResults060 ; id 97 DarkHorn
    dw BreedFamilyResults062 ; id 98 MadCat
    dw BreedFamilyResults062 ; id 99 BigEye
    dw BreedFamilyResults064 ; id 100 Gorago
    dw BreedFamilyResults064 ; id 101 CatMage
    dw BreedFamilyResults066 ; id 102 Dumbira
    dw BreedFamilyResults067 ; id 103 ?
    dw BreedFamilyResults067 ; id 104 ?
    dw BreedFamilyResults067 ; id 105 ?
    dw BreedFamilyResults067 ; id 106 Picky
    dw BreedFamilyResults06B ; id 107 Wyvern
    dw BreedFamilyResults06C ; id 108 BullBird
    dw BreedFamilyResults06D ; id 109 Florajay
    dw BreedFamilyResults06D ; id 110 DuckKite
    dw BreedFamilyResults06F ; id 111 MadPecker
    dw BreedFamilyResults06F ; id 112 MadRaven
    dw BreedFamilyResults06F ; id 113 MistyWing
    dw BreedFamilyResults06F ; id 114 AquaHawk
    dw BreedFamilyResults06F ; id 115 Dracky
    dw BreedFamilyResults06F ; id 116 KiteHawk
    dw BreedFamilyResults075 ; id 117 BigRoost
    dw BreedFamilyResults076 ; id 118 StubBird
    dw BreedFamilyResults076 ; id 119 LandOwl
    dw BreedFamilyResults078 ; id 120 MadGoose
    dw BreedFamilyResults079 ; id 121 MadCondor
    dw BreedFamilyResults07A ; id 122 Emyu
    dw BreedFamilyResults07B ; id 123 Blizzardy
    dw BreedFamilyResults07B ; id 124 Phoenix
    dw BreedFamilyResults07D ; id 125 ZapBird
    dw BreedFamilyResults07D ; id 126 Garudian
    dw BreedFamilyResults07F ; id 127 WhipBird
    dw BreedFamilyResults07F ; id 128 FunkyBird
    dw BreedFamilyResults07F ; id 129 RainHawk
    dw BreedFamilyResults082 ; id 130 Azurile
    dw BreedFamilyResults082 ; id 131 Shantak
    dw BreedFamilyResults084 ; id 132 CragDevil
    dw BreedFamilyResults084 ; id 133 ?
    dw BreedFamilyResults084 ; id 134 ?
    dw BreedFamilyResults084 ; id 135 ?
    dw BreedFamilyResults084 ; id 136 ?
    dw BreedFamilyResults084 ; id 137 ?
    dw BreedFamilyResults084 ; id 138 ?
    dw BreedFamilyResults084 ; id 139 ?
    dw BreedFamilyResults084 ; id 140 ?
    dw BreedFamilyResults084 ; id 141 MadPlant
    dw BreedFamilyResults08E ; id 142 FireWeed
    dw BreedFamilyResults08E ; id 143 FloraMan
    dw BreedFamilyResults08E ; id 144 WingTree
    dw BreedFamilyResults08E ; id 145 CactiBall
    dw BreedFamilyResults08E ; id 146 Gulpple
    dw BreedFamilyResults08E ; id 147 Toadstool
    dw BreedFamilyResults08E ; id 148 AmberWeed
    dw BreedFamilyResults095 ; id 149 Slurperon
    dw BreedFamilyResults095 ; id 150 Stubsuck
    dw BreedFamilyResults097 ; id 151 Oniono
    dw BreedFamilyResults097 ; id 152 DanceVegi
    dw BreedFamilyResults097 ; id 153 TreeBoy
    dw BreedFamilyResults097 ; id 154 Devipine
    dw BreedFamilyResults097 ; id 155 FaceTree
    dw BreedFamilyResults097 ; id 156 HerbMan
    dw BreedFamilyResults09D ; id 157 BeanMan
    dw BreedFamilyResults09D ; id 158 EvilSeed
    dw BreedFamilyResults09D ; id 159 ManEater
    dw BreedFamilyResults09D ; id 160 Snapper
    dw BreedFamilyResults09D ; id 161 GhosTree
    dw BreedFamilyResults09D ; id 162 Rosevine
    dw BreedFamilyResults09D ; id 163 Egdracil
    dw BreedFamilyResults09D ; id 164 Warubou
    dw BreedFamilyResults09D ; id 165 Watabou
    dw BreedFamilyResults09D ; id 166 Eggplaton
    dw BreedFamilyResults0A7 ; id 167 FooHero
    dw BreedFamilyResults0A7 ; id 168 ?
    dw BreedFamilyResults0A7 ; id 169 ?
    dw BreedFamilyResults0A7 ; id 170 ?
    dw BreedFamilyResults0A7 ; id 171 ?
    dw BreedFamilyResults0A7 ; id 172 ?
    dw BreedFamilyResults0A7 ; id 173 ?
    dw BreedFamilyResults0A7 ; id 174 ?
    dw BreedFamilyResults0A7 ; id 175 ?
    dw BreedFamilyResults0A7 ; id 176 GiantSlug
    dw BreedFamilyResults0B1 ; id 177 Catapila
    dw BreedFamilyResults0B1 ; id 178 Gophecada
    dw BreedFamilyResults0B1 ; id 179 Butterfly
    dw BreedFamilyResults0B4 ; id 180 WeedBug
    dw BreedFamilyResults0B5 ; id 181 GiantWorm
    dw BreedFamilyResults0B6 ; id 182 Lipsy
    dw BreedFamilyResults0B7 ; id 183 StagBug
    dw BreedFamilyResults0B7 ; id 184 Pyuro
    dw BreedFamilyResults0B9 ; id 185 ArmyAnt
    dw BreedFamilyResults0B9 ; id 186 GoHopper
    dw BreedFamilyResults0B9 ; id 187 TailEater
    dw BreedFamilyResults0BC ; id 188 ArmorPede
    dw BreedFamilyResults0BD ; id 189 Eyeder
    dw BreedFamilyResults0BE ; id 190 GiantMoth
    dw BreedFamilyResults0BE ; id 191 Droll
    dw BreedFamilyResults0C0 ; id 192 ArmyCrab
    dw BreedFamilyResults0C0 ; id 193 MadHornet
    dw BreedFamilyResults0C2 ; id 194 Belzebub
    dw BreedFamilyResults0C2 ; id 195 WarMantis
    dw BreedFamilyResults0C4 ; id 196 HornBeet
    dw BreedFamilyResults0C4 ; id 197 Sickler
    dw BreedFamilyResults0C6 ; id 198 Armorpion
    dw BreedFamilyResults0C6 ; id 199 Digster
    dw BreedFamilyResults0C6 ; id 200 Skularach
    dw BreedFamilyResults0C6 ; id 201 MultiEyes
    dw BreedFamilyResults0C6 ; id 202 ?
    dw BreedFamilyResults0C6 ; id 203 ?
    dw BreedFamilyResults0C6 ; id 204 ?
    dw BreedFamilyResults0C6 ; id 205 ?
    dw BreedFamilyResults0C6 ; id 206 ?
    dw BreedFamilyResults0C6 ; id 207 ?
    dw BreedFamilyResults0C6 ; id 208 ?
    dw BreedFamilyResults0C6 ; id 209 ?
    dw BreedFamilyResults0C6 ; id 210 ?
    dw BreedFamilyResults0C6 ; id 211 Pixy
    dw BreedFamilyResults0D4 ; id 212 MedusaEye
    dw BreedFamilyResults0D5 ; id 213 AgDevil
    dw BreedFamilyResults0D5 ; id 214 Demonite
    dw BreedFamilyResults0D7 ; id 215 DarkEye
    dw BreedFamilyResults0D8 ; id 216 EyeBall
    dw BreedFamilyResults0D9 ; id 217 SkulRider
    dw BreedFamilyResults0DA ; id 218 EvilBeast
    dw BreedFamilyResults0DB ; id 219 Bubblemon
    dw BreedFamilyResults0DB ; id 220 1EyeClown
    dw BreedFamilyResults0DD ; id 221 Gremlin
    dw BreedFamilyResults0DE ; id 222 ArcDemon
    dw BreedFamilyResults0DF ; id 223 Lionex
    dw BreedFamilyResults0DF ; id 224 GoatHorn
    dw BreedFamilyResults0E1 ; id 225 Orc
    dw BreedFamilyResults0E1 ; id 226 Ogre
    dw BreedFamilyResults0E3 ; id 227 GateGuard
    dw BreedFamilyResults0E4 ; id 228 ChopClown
    dw BreedFamilyResults0E4 ; id 229 BossTroll
    dw BreedFamilyResults0E6 ; id 230 Grendal
    dw BreedFamilyResults0E6 ; id 231 Akubar
    dw BreedFamilyResults0E6 ; id 232 MadKnight
    dw BreedFamilyResults0E6 ; id 233 EvilWell
    dw BreedFamilyResults0E6 ; id 234 Gigantes
    dw BreedFamilyResults0E6 ; id 235 Centasaur
    dw BreedFamilyResults0EC ; id 236 EvilArmor
    dw BreedFamilyResults0EC ; id 237 Jamirus
    dw BreedFamilyResults0EC ; id 238 Durran
    dw BreedFamilyResults0EC ; id 239 Titanis
    dw BreedFamilyResults0EC ; id 240 LampGenie
    dw BreedFamilyResults0EC ; id 241 ?
    dw BreedFamilyResults0EC ; id 242 ?
    dw BreedFamilyResults0EC ; id 243 ?
    dw BreedFamilyResults0EC ; id 244 ?
    dw BreedFamilyResults0EC ; id 245 ?
    dw BreedFamilyResults0EC ; id 246 Spooky
    dw BreedFamilyResults0F7 ; id 247 Skullgon
    dw BreedFamilyResults0F8 ; id 248 PutrePup
    dw BreedFamilyResults0F8 ; id 249 RotRaven
    dw BreedFamilyResults0FA ; id 250 Mummy
    dw BreedFamilyResults0FA ; id 251 DarkCrab
    dw BreedFamilyResults0FC ; id 252 DeadNite
    dw BreedFamilyResults0FD ; id 253 Shadow
    dw BreedFamilyResults0FD ; id 254 Skulpent
    dw BreedFamilyResults0FF ; id 255 Hork
    dw BreedFamilyResults100 ; id 256 Mudron
    dw BreedFamilyResults101 ; id 257 NiteWhip
    dw BreedFamilyResults102 ; id 258 WindMerge
    dw BreedFamilyResults102 ; id 259 Reaper
    dw BreedFamilyResults102 ; id 260 Inverzon
    dw BreedFamilyResults102 ; id 261 FoxFire
    dw BreedFamilyResults106 ; id 262 CaptDead
    dw BreedFamilyResults106 ; id 263 DeadNoble
    dw BreedFamilyResults108 ; id 264 WhiteKing
    dw BreedFamilyResults109 ; id 265 BoneSlave
    dw BreedFamilyResults10A ; id 266 Skeletor
    dw BreedFamilyResults10B ; id 267 Servant
    dw BreedFamilyResults10B ; id 268 Lazamanus
    dw BreedFamilyResults10B ; id 269 Copycat
    dw BreedFamilyResults10B ; id 270 MadSpirit
    dw BreedFamilyResults10F ; id 271 PomPomBom
    dw BreedFamilyResults110 ; id 272 Niterich
    dw BreedFamilyResults110 ; id 273 ?
    dw BreedFamilyResults110 ; id 274 ?
    dw BreedFamilyResults110 ; id 275 ?
    dw BreedFamilyResults110 ; id 276 ?
    dw BreedFamilyResults110 ; id 277 ?
    dw BreedFamilyResults110 ; id 278 ?
    dw BreedFamilyResults110 ; id 279 ?
    dw BreedFamilyResults110 ; id 280 ?
    dw BreedFamilyResults110 ; id 281 JewelBag
    dw BreedFamilyResults11A ; id 282 EvilWand
    dw BreedFamilyResults11A ; id 283 MadCandle
    dw BreedFamilyResults11A ; id 284 CoilBird
    dw BreedFamilyResults11A ; id 285 Facer
    dw BreedFamilyResults11A ; id 286 SpikyBoy
    dw BreedFamilyResults11A ; id 287 MadMirror
    dw BreedFamilyResults11A ; id 288 RogueNite
    dw BreedFamilyResults121 ; id 289 Puppetor
    dw BreedFamilyResults122 ; id 290 Goopi
    dw BreedFamilyResults122 ; id 291 Voodoll
    dw BreedFamilyResults122 ; id 292 MetalDrak
    dw BreedFamilyResults122 ; id 293 Balzak
    dw BreedFamilyResults122 ; id 294 SabreMan
    dw BreedFamilyResults122 ; id 295 CurseLamp
    dw BreedFamilyResults122 ; id 296 Brushead
    dw BreedFamilyResults122 ; id 297 Roboster
    dw BreedFamilyResults12A ; id 298 Roboster2
    dw BreedFamilyResults12B ; id 299 EvilPot
    dw BreedFamilyResults12B ; id 300 Gismo
    dw BreedFamilyResults12D ; id 301 LavaMan
    dw BreedFamilyResults12E ; id 302 IceMan
    dw BreedFamilyResults12F ; id 303 Mimic
    dw BreedFamilyResults12F ; id 304 Exaucers
    dw BreedFamilyResults12F ; id 305 MudDoll
    dw BreedFamilyResults12F ; id 306 Golem
    dw BreedFamilyResults12F ; id 307 StoneMan
    dw BreedFamilyResults12F ; id 308 BombCrag
    dw BreedFamilyResults12F ; id 309 GoldGolem
    dw BreedFamilyResults12F ; id 310 DarkMate
    dw BreedFamilyResults137 ; id 311 ProtoMech
    dw BreedFamilyResults137 ; id 312 CloudKing
    dw BreedFamilyResults137 ; id 313 ?
    dw BreedFamilyResults137 ; id 314 ?
    dw BreedFamilyResults137 ; id 315 ?
    dw BreedFamilyResults137 ; id 316 Petiteel
    dw BreedFamilyResults13D ; id 317 Moray
    dw BreedFamilyResults13D ; id 318 WalrusMan
    dw BreedFamilyResults13D ; id 319 RayGigas
    dw BreedFamilyResults13D ; id 320 Anemon
    dw BreedFamilyResults13D ; id 321 Aquarella
    dw BreedFamilyResults142 ; id 322 Merman
    dw BreedFamilyResults142 ; id 323 Octokid
    dw BreedFamilyResults142 ; id 324 PutreFish
    dw BreedFamilyResults142 ; id 325 Octoreach
    dw BreedFamilyResults146 ; id 326 Angleron
    dw BreedFamilyResults147 ; id 327 FishRider
    dw BreedFamilyResults147 ; id 328 RushFish
    dw BreedFamilyResults147 ; id 329 Gamanian
    dw BreedFamilyResults14A ; id 330 Clawster
    dw BreedFamilyResults14B ; id 331 CancerMan
    dw BreedFamilyResults14B ; id 332 RogueWave
    dw BreedFamilyResults14D ; id 333 Scallopa
    dw BreedFamilyResults14D ; id 334 SeaHorse
    dw BreedFamilyResults14D ; id 335 HoodSquid
    dw BreedFamilyResults150 ; id 336 MerTiger
    dw BreedFamilyResults150 ; id 337 AxeShark
    dw BreedFamilyResults150 ; id 338 Octogon
    dw BreedFamilyResults153 ; id 339 KingSquid
    dw FamilyBreedRuleTable ; id 340 Digong
    dw FamilyBreedRuleTable ; id 341 WhaleMage
    dw FamilyBreedRuleTable ; id 342 Aquadon
    dw FamilyBreedRuleTable ; id 343 Octoraid
    dw FamilyBreedRuleTable ; id 344 Grakos
    dw FamilyBreedRuleTable ; id 345 Poseidon
    dw FamilyBreedRuleTable ; id 346 Pumpoise
    dw FamilyBreedRuleTable ; id 347 Starfish
    dw FamilyBreedRuleTable ; id 348 ?
    dw FamilyBreedRuleTable ; id 349 ?
    dw FamilyBreedRuleTable ; id 350 ?
    dw FamilyBreedRuleTable ; id 351 DracoLord
    dw FamilyBreedRuleTable ; id 352 DracoLord
    dw FamilyBreedRuleTable ; id 353 LordDraco
    dw FamilyBreedRuleTable ; id 354 Hargon
    dw FamilyBreedRuleTable ; id 355 Sidoh
    dw FamilyBreedRuleTable ; id 356 Genosidoh
    dw FamilyBreedRuleTable ; id 357 Baramos
    dw FamilyBreedRuleTable ; id 358 Zoma
    dw FamilyBreedRuleTable ; id 359 AsuraZoma
    dw FamilyBreedRuleTable ; id 360 Pizzaro
    dw FamilyBreedRuleTable ; id 361 PsychoPiz
    dw FamilyBreedRuleTable ; id 362 Esterk
    dw FamilyBreedRuleTable ; id 363 Mirudraas
    dw FamilyBreedRuleTable ; id 364 Mirudraas
    dw FamilyBreedRuleTable ; id 365 Mudou
    dw FamilyBreedRuleTable ; id 366 DeathMore
    dw FamilyBreedRuleTable ; id 367 DeathMore
    dw FamilyBreedRuleTable ; id 368 DeathMore
    dw FamilyBreedRuleTable ; id 369 Darkdrium
    dw FamilyBreedRuleTable ; id 370 Orgodemir
    dw FamilyBreedRuleTable ; id 371 Orgodemir
    dw FamilyBreedRuleTable ; id 372 Darck
    dw FamilyBreedRuleTable ; id 373 Tatsu
    dw FamilyBreedRuleTable ; id 374 Diago
    dw FamilyBreedRuleTable ; id 375 Samsi
    dw BreedFamilyResults000 ; id 376 Bazoo
    dw BreedFamilyResults000 ; id 377 ?
    dw BreedFamilyResults000 ; id 378 ?
    dw BreedFamilyResults000 ; id 379 ?
    dw BreedFamilyResults000 ; id 380 Lamia
    dw BreedFamilyResults000 ; id 381 Dimensaur
    dw BreedFamilyResults000 ; id 382 Kagebou
    dw BreedFamilyResults000 ; id 383 ?

; E-0199 (derived: list for entry $00 of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults000::
Data_00E_7A4F:: ; address name
    dw $FFFF ; id 0

; E-0199 (derived: list for entry $01 (DrakSlime) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults001::
Data_00E_7A51:: ; address name
    dw $0014 ; id 0 TropicGel

; E-0199 (derived: list for entry $05 (Snaily) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults005::
Data_00E_7A53:: ; address name
    dw $0016 ; id 0 HaloSlime

; E-0199 (derived: list for entry $0C (FangSlime) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults00C::
Data_00E_7A55:: ; address name
    dw $0016 ; id 0 HaloSlime

; E-0199 (derived: list for entry $16 (HaloSlime) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults016::
Data_00E_7A57:: ; address name
    dw $0014 ; id 0 TropicGel
    dw $0015 ; id 1 MimeSlime
    dw $0016 ; id 2 HaloSlime

; E-0199 (derived: list for entry $1B (Butch) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults01B::
Data_00E_7A5D:: ; address name
    dw $002F ; id 0 MadDragon

; E-0199 (derived: list for entry $28 (FairyDrak) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults028::
Data_00E_7A5F:: ; address name
    dw $005C ; id 0 Unicorn

; E-0199 (derived: list for entry $48 (Almiraj) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults048::
Data_00E_7A61:: ; address name
    dw $005E ; id 0 WildApe

; E-0199 (derived: list for entry $49 (CatFly) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults049::
Data_00E_7A63:: ; address name
    dw $004E ; id 0 WindBeast

; E-0199 (derived: list for entry $4A (PillowRat) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults04A::
Data_00E_7A65:: ; address name
    dw $0050 ; id 0 Antbear

; E-0199 (derived: list for entry $4C (GulpBeast) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults04C::
Data_00E_7A67:: ; address name
    dw $005C ; id 0 Unicorn

; E-0199 (derived: list for entry $4D (Skullroo) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults04D::
Data_00E_7A69:: ; address name
    dw $005F ; id 0 Trumpeter

; E-0199 (derived: list for entry $52 (IronTurt) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults052::
Data_00E_7A6B:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $004C ; id 1 GulpBeast
    dw $005C ; id 2 Unicorn

; E-0199 (derived: list for entry $56 (Yeti) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults056::
Data_00E_7A71:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $005C ; id 1 Unicorn

; E-0199 (derived: list for entry $57 (ArrowDog) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults057::
Data_00E_7A75:: ; address name
    dw $005C ; id 0 Unicorn

; E-0199 (derived: list for entry $5E (WildApe) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults05E::
Data_00E_7A77:: ; address name
    dw $005C ; id 0 Unicorn

; E-0199 (derived: list for entry $5F (Trumpeter) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults05F::
Data_00E_7A79:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $005C ; id 1 Unicorn

; E-0199 (derived: list for entry $60 (KingLeo) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults060::
Data_00E_7A7D:: ; address name
    dw $0064 ; id 0 Gorago

; E-0199 (derived: list for entry $62 (MadCat) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults062::
Data_00E_7A7F:: ; address name
    dw $004C ; id 0 GulpBeast

; E-0199 (derived: list for entry $64 (Gorago) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults064::
Data_00E_7A81:: ; address name
    dw $0059 ; id 0 BeastNite

; E-0199 (derived: list for entry $66 (Dumbira) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults066::
Data_00E_7A83:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $0051 ; id 1 SuperTen

; E-0199 (derived: list for entry $67 (?) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults067::
Data_00E_7A87:: ; address name
    dw $0073 ; id 0 Dracky

; E-0199 (derived: list for entry $6B (Wyvern) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults06B::
Data_00E_7A89:: ; address name
    dw $0078 ; id 0 MadGoose
    dw $0078 ; id 1 MadGoose

; E-0199 (derived: list for entry $6C (BullBird) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults06C::
Data_00E_7A8D:: ; address name
    dw $0077 ; id 0 LandOwl

; E-0199 (derived: list for entry $6D (Florajay) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults06D::
Data_00E_7A8F:: ; address name
    dw $0074 ; id 0 KiteHawk

; E-0199 (derived: list for entry $6F (MadPecker) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults06F::
Data_00E_7A91:: ; address name
    dw $007A ; id 0 Emyu

; E-0199 (derived: list for entry $75 (BigRoost) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults075::
Data_00E_7A93:: ; address name
    dw $0084 ; id 0 CragDevil

; E-0199 (derived: list for entry $76 (StubBird) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults076::
Data_00E_7A95:: ; address name
    dw $0078 ; id 0 MadGoose
    dw $0078 ; id 1 MadGoose
    dw $0079 ; id 2 MadCondor

; E-0199 (derived: list for entry $78 (MadGoose) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults078::
Data_00E_7A9B:: ; address name
    dw $0084 ; id 0 CragDevil

; E-0199 (derived: list for entry $79 (MadCondor) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults079::
Data_00E_7A9D:: ; address name
    dw $0078 ; id 0 MadGoose
    dw $0078 ; id 1 MadGoose

; E-0199 (derived: list for entry $7A (Emyu) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults07A::
Data_00E_7AA1:: ; address name
    dw $0084 ; id 0 CragDevil

; E-0199 (derived: list for entry $7B (Blizzardy) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults07B::
Data_00E_7AA3:: ; address name
    dw $0078 ; id 0 MadGoose
    dw $0078 ; id 1 MadGoose

; E-0199 (derived: list for entry $7D (ZapBird) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults07D::
Data_00E_7AA7:: ; address name
    dw $0077 ; id 0 LandOwl

; E-0199 (derived: list for entry $7F (WhipBird) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults07F::
Data_00E_7AA9:: ; address name
    dw $0082 ; id 0 Azurile

; E-0199 (derived: list for entry $82 (Azurile) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults082::
Data_00E_7AAB:: ; address name
    dw $0082 ; id 0 Azurile

; E-0199 (derived: list for entry $84 (CragDevil) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults084::
Data_00E_7AAD:: ; address name
    dw $0098 ; id 0 DanceVegi

; E-0199 (derived: list for entry $8E (FireWeed) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults08E::
Data_00E_7AAF:: ; address name
    dw $0096 ; id 0 Stubsuck

; E-0199 (derived: list for entry $95 (Slurperon) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults095::
Data_00E_7AB1:: ; address name
    dw $00A1 ; id 0 GhosTree

; E-0199 (derived: list for entry $97 (Oniono) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults097::
Data_00E_7AB3:: ; address name
    dw $009B ; id 0 FaceTree

; E-0199 (derived: list for entry $9D (BeanMan) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults09D::
Data_00E_7AB5:: ; address name
    dw $009D ; id 0 BeanMan
    dw $009E ; id 1 EvilSeed

; E-0199 (derived: list for entry $A7 (FooHero) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0A7::
Data_00E_7AB9:: ; address name
    dw $00B9 ; id 0 ArmyAnt

; E-0199 (derived: list for entry $B1 (Catapila) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0B1::
Data_00E_7ABB:: ; address name
    dw $00BE ; id 0 GiantMoth

; E-0199 (derived: list for entry $B4 (WeedBug) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0B4::
Data_00E_7ABD:: ; address name
    dw $00BB ; id 0 TailEater

; E-0199 (derived: list for entry $B5 (GiantWorm) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0B5::
Data_00E_7ABF:: ; address name
    dw $00BC ; id 0 ArmorPede

; E-0199 (derived: list for entry $B6 (Lipsy) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0B6::
Data_00E_7AC1:: ; address name
    dw $00BF ; id 0 Droll

; E-0199 (derived: list for entry $B7 (StagBug) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0B7::
Data_00E_7AC3:: ; address name
    dw $00C1 ; id 0 MadHornet

; E-0199 (derived: list for entry $B9 (ArmyAnt) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0B9::
Data_00E_7AC5:: ; address name
    dw $00C9 ; id 0 MultiEyes

; E-0199 (derived: list for entry $BC (ArmorPede) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0BC::
Data_00E_7AC7:: ; address name
    dw $00C4 ; id 0 HornBeet

; E-0199 (derived: list for entry $BD (Eyeder) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0BD::
Data_00E_7AC9:: ; address name
    dw $00C1 ; id 0 MadHornet

; E-0199 (derived: list for entry $BE (GiantMoth) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0BE::
Data_00E_7ACB:: ; address name
    dw $00BC ; id 0 ArmorPede
    dw $00C1 ; id 1 MadHornet

; E-0199 (derived: list for entry $C0 (ArmyCrab) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0C0::
Data_00E_7ACF:: ; address name
    dw $00C2 ; id 0 Belzebub

; E-0199 (derived: list for entry $C2 (Belzebub) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0C2::
Data_00E_7AD1:: ; address name
    dw $00C4 ; id 0 HornBeet
    dw $00C5 ; id 1 Sickler

; E-0199 (derived: list for entry $C4 (HornBeet) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0C4::
Data_00E_7AD5:: ; address name
    dw $00C3 ; id 0 WarMantis

; E-0199 (derived: list for entry $C6 (Armorpion) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0C6::
Data_00E_7AD7:: ; address name
    dw $00DC ; id 0 1EyeClown

; E-0199 (derived: list for entry $D4 (MedusaEye) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0D4::
Data_00E_7AD9:: ; address name
    dw $00D5 ; id 0 AgDevil
    dw $00E6 ; id 1 Grendal
    dw $00EA ; id 2 Gigantes

; E-0199 (derived: list for entry $D5 (AgDevil) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0D5::
Data_00E_7ADF:: ; address name
    dw $00DC ; id 0 1EyeClown

; E-0199 (derived: list for entry $D7 (DarkEye) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0D7::
Data_00E_7AE1:: ; address name
    dw $00D4 ; id 0 MedusaEye

; E-0199 (derived: list for entry $D8 (EyeBall) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0D8::
Data_00E_7AE3:: ; address name
    dw $00DC ; id 0 1EyeClown

; E-0199 (derived: list for entry $D9 (SkulRider) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0D9::
Data_00E_7AE5:: ; address name
    dw $00D5 ; id 0 AgDevil
    dw $00E6 ; id 1 Grendal
    dw $00EA ; id 2 Gigantes

; E-0199 (derived: list for entry $DA (EvilBeast) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0DA::
Data_00E_7AEB:: ; address name
    dw $00D5 ; id 0 AgDevil
    dw $00E6 ; id 1 Grendal
    dw $00EA ; id 2 Gigantes

; E-0199 (derived: list for entry $DB (Bubblemon) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0DB::
Data_00E_7AF1:: ; address name
    dw $00D4 ; id 0 MedusaEye

; E-0199 (derived: list for entry $DD (Gremlin) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0DD::
Data_00E_7AF3:: ; address name
    dw $00D5 ; id 0 AgDevil
    dw $00D4 ; id 1 MedusaEye
    dw $00E6 ; id 2 Grendal

; E-0199 (derived: list for entry $DE (ArcDemon) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0DE::
Data_00E_7AF9:: ; address name
    dw $00DF ; id 0 Lionex
    dw $00E0 ; id 1 GoatHorn
    dw $00EB ; id 2 Centasaur
    dw $00EC ; id 3 EvilArmor

; E-0199 (derived: list for entry $DF (Lionex) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0DF::
Data_00E_7B01:: ; address name
    dw $00E5 ; id 0 BossTroll

; E-0199 (derived: list for entry $E1 (Orc) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0E1::
Data_00E_7B03:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00E3 ; id 1 GateGuard
    dw $00EB ; id 2 Centasaur
    dw $00EC ; id 3 EvilArmor

; E-0199 (derived: list for entry $E3 (GateGuard) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0E3::
Data_00E_7B0B:: ; address name
    dw $00E2 ; id 0 Ogre
    dw $00EB ; id 1 Centasaur
    dw $00EC ; id 2 EvilArmor

; E-0199 (derived: list for entry $E4 (ChopClown) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0E4::
Data_00E_7B11:: ; address name
    dw $00EB ; id 0 Centasaur

; E-0199 (derived: list for entry $E6 (Grendal) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0E6::
Data_00E_7B13:: ; address name
    dw $00F0 ; id 0 LampGenie

; E-0199 (derived: list for entry $EC (EvilArmor) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0EC::
Data_00E_7B15:: ; address name
    dw $0103 ; id 0 Reaper
    dw $00FF ; id 1 Hork

; E-0199 (derived: list for entry $F7 (Skullgon) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0F7::
Data_00E_7B19:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $010E ; id 1 MadSpirit

; E-0199 (derived: list for entry $F8 (PutrePup) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0F8::
Data_00E_7B1D:: ; address name
    dw $0102 ; id 0 WindMerge

; E-0199 (derived: list for entry $FA (Mummy) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0FA::
Data_00E_7B1F:: ; address name
    dw $0101 ; id 0 NiteWhip

; E-0199 (derived: list for entry $FC (DeadNite) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0FC::
Data_00E_7B21:: ; address name
    dw $00FE ; id 0 Skulpent
    dw $010E ; id 1 MadSpirit

; E-0199 (derived: list for entry $FD (Shadow) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0FD::
Data_00E_7B25:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $00FC ; id 1 DeadNite

; E-0199 (derived: list for entry $FF (Hork) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults0FF::
Data_00E_7B29:: ; address name
    dw $0103 ; id 0 Reaper

; E-0199 (derived: list for entry $100 (Mudron) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults100::
Data_00E_7B2B:: ; address name
    dw $010E ; id 0 MadSpirit

; E-0199 (derived: list for entry $101 (NiteWhip) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults101::
Data_00E_7B2D:: ; address name
    dw $0105 ; id 0 FoxFire

; E-0199 (derived: list for entry $102 (WindMerge) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults102::
Data_00E_7B2F:: ; address name
    dw $010F ; id 0 PomPomBom

; E-0199 (derived: list for entry $106 (CaptDead) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults106::
Data_00E_7B31:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $010E ; id 1 MadSpirit

; E-0199 (derived: list for entry $108 (WhiteKing) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults108::
Data_00E_7B35:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $010B ; id 1 Servant

; E-0199 (derived: list for entry $109 (BoneSlave) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults109::
Data_00E_7B39:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $0106 ; id 1 CaptDead
    dw $010E ; id 2 MadSpirit

; E-0199 (derived: list for entry $10A (Skeletor) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults10A::
Data_00E_7B3F:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $010E ; id 1 MadSpirit

; E-0199 (derived: list for entry $10B (Servant) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults10B::
Data_00E_7B43:: ; address name
    dw $0101 ; id 0 NiteWhip
    dw $010A ; id 1 Skeletor

; E-0199 (derived: list for entry $10F (PomPomBom) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults10F::
Data_00E_7B47:: ; address name
    dw $010E ; id 0 MadSpirit

; E-0199 (derived: list for entry $110 (Niterich) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults110::
Data_00E_7B49:: ; address name
    dw $0122 ; id 0 Goopi

; E-0199 (derived: list for entry $11A (EvilWand) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults11A::
Data_00E_7B4B:: ; address name
    dw $0137 ; id 0 ProtoMech

; E-0199 (derived: list for entry $121 (Puppetor) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults121::
Data_00E_7B4D:: ; address name
    dw $0123 ; id 0 Voodoll

; E-0199 (derived: list for entry $122 (Goopi) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults122::
Data_00E_7B4F:: ; address name
    dw $0137 ; id 0 ProtoMech
    dw $0124 ; id 1 MetalDrak
    dw $0127 ; id 2 CurseLamp
    dw $012F ; id 3 Mimic
    dw $0134 ; id 4 BombCrag

; E-0199 (derived: list for entry $12A (Roboster2) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults12A::
Data_00E_7B59:: ; address name
    dw $0137 ; id 0 ProtoMech
    dw $0124 ; id 1 MetalDrak
    dw $0127 ; id 2 CurseLamp

; E-0199 (derived: list for entry $12B (EvilPot) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults12B::
Data_00E_7B5F:: ; address name
    dw $012B ; id 0 EvilPot

; E-0199 (derived: list for entry $12D (LavaMan) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults12D::
Data_00E_7B61:: ; address name
    dw $0125 ; id 0 Balzak

; E-0199 (derived: list for entry $12E (IceMan) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults12E::
Data_00E_7B63:: ; address name
    dw $0125 ; id 0 Balzak

; E-0199 (derived: list for entry $12F (Mimic) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults12F::
Data_00E_7B65:: ; address name
    dw $0134 ; id 0 BombCrag

; E-0199 (derived: list for entry $137 (ProtoMech) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults137::
Data_00E_7B67:: ; address name
    dw $0145 ; id 0 Octoreach
    dw $0146 ; id 1 Angleron
    dw $014E ; id 2 SeaHorse
    dw $014E ; id 3 SeaHorse

; E-0199 (derived: list for entry $13D (Moray) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults13D::
Data_00E_7B6F:: ; address name
    dw $0149 ; id 0 Gamanian

; E-0199 (derived: list for entry $142 (Merman) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults142::
Data_00E_7B71:: ; address name
    dw $015B ; id 0 Starfish

; E-0199 (derived: list for entry $146 (Angleron) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults146::
Data_00E_7B73:: ; address name
    dw $0148 ; id 0 RushFish

; E-0199 (derived: list for entry $147 (FishRider) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults147::
Data_00E_7B75:: ; address name
    dw $014A ; id 0 Clawster

; E-0199 (derived: list for entry $14A (Clawster) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults14A::
Data_00E_7B77:: ; address name
    dw $014B ; id 0 CancerMan

; E-0199 (derived: list for entry $14B (CancerMan) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults14B::
Data_00E_7B79:: ; address name
    dw $014D ; id 0 Scallopa

; E-0199 (derived: list for entry $14D (Scallopa) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults14D::
Data_00E_7B7B:: ; address name
    dw $015B ; id 0 Starfish

; E-0199 (derived: list for entry $150 (MerTiger) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults150::
Data_00E_7B7D:: ; address name
    dw $015B ; id 0 Starfish
    dw $0153 ; id 1 KingSquid

; E-0199 (derived: list for entry $153 (KingSquid) of BreedFamilyResultTable; it runs to the next list)
; record: child species
BreedFamilyResults153::
Data_00E_7B81:: ; address name
    dw $015B ; id 0 Starfish

; E-0199 (C1: stage 3, when stage 2 finds nothing: the word list at $7B83 + 2 * parent A's family holds partner species ($FDxx = next result, $FFxx = end); a match takes result [count] from FamilyBreedResultTable)
; record: list
FamilyBreedRuleTable::
Data_00E_7B83:: ; address name
    dw FamilyBreedRules000 ; id 0
    dw FamilyBreedRules001 ; id 1
    dw FamilyBreedRules002 ; id 2
    dw FamilyBreedRules003 ; id 3
    dw FamilyBreedRules004 ; id 4
    dw FamilyBreedRules005 ; id 5
    dw FamilyBreedRules006 ; id 6
    dw FamilyBreedRules007 ; id 7
    dw FamilyBreedRules008 ; id 8
    dw FamilyBreedRules009 ; id 9
    dw FamilyBreedRules00A ; id 10

; E-0199 (derived: list for entry $00 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules000::
Data_00E_7B99:: ; address name
    dw $002A ; id 0 Poisongon
    dw $00BE ; id 1 GiantMoth
    dw $FDFD ; id 2 next result
    dw $004A ; id 3 PillowRat
    dw $0080 ; id 4 FunkyBird
    dw $008D ; id 5 MadPlant
    dw $010D ; id 6 Copycat
    dw $FDFD ; id 7 next result
    dw $0048 ; id 8 Almiraj
    dw $004C ; id 9 GulpBeast
    dw $005F ; id 10 Trumpeter
    dw $0060 ; id 11 KingLeo
    dw $0061 ; id 12 DarkHorn
    dw $0062 ; id 13 MadCat
    dw $FDFD ; id 14 next result
    dw $00FC ; id 15 DeadNite
    dw $0132 ; id 16 Golem
    dw $0133 ; id 17 StoneMan
    dw $0134 ; id 18 BombCrag
    dw $FDFD ; id 19 next result
    dw $0129 ; id 20 Roboster
    dw $FDFD ; id 21 next result
    dw $004D ; id 22 Skullroo
    dw $FDFD ; id 23 next result
    dw $0124 ; id 24 MetalDrak
    dw $FFFF ; id 25 end of list

; E-0199 (derived: list for entry $01 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules001::
Data_00E_7BCD:: ; address name
    dw $006A ; id 0 Picky
    dw $FDFD ; id 1 next result
    dw $004C ; id 2 GulpBeast
    dw $FDFD ; id 3 next result
    dw $0079 ; id 4 MadCondor
    dw $FDFD ; id 5 next result
    dw $0123 ; id 6 Voodoll
    dw $FDFD ; id 7 next result
    dw $00BA ; id 8 GoHopper
    dw $FDFD ; id 9 next result
    dw $0092 ; id 10 Gulpple
    dw $FDFD ; id 11 next result
    dw $0007 ; id 12 Babble
    dw $FDFD ; id 13 next result
    dw $0078 ; id 14 MadGoose
    dw $FDFD ; id 15 next result
    dw $0049 ; id 16 CatFly
    dw $FDFD ; id 17 next result
    dw $00C0 ; id 18 ArmyCrab
    dw $00C7 ; id 19 Digster
    dw $FDFD ; id 20 next result
    dw $0010 ; id 21 KingSlime
    dw $0013 ; id 22 SpotKing
    dw $0017 ; id 23 MetalKing
    dw $003D ; id 24 BattleRex
    dw $005C ; id 25 Unicorn
    dw $007D ; id 26 ZapBird
    dw $007F ; id 27 WhipBird
    dw $00EA ; id 28 Gigantes
    dw $00EB ; id 29 Centasaur
    dw $FDFD ; id 30 next result
    dw $0075 ; id 31 BigRoost
    dw $FDFD ; id 32 next result
    dw $0060 ; id 33 KingLeo
    dw $00DF ; id 34 Lionex
    dw $00E2 ; id 35 Ogre
    dw $00E8 ; id 36 MadKnight
    dw $00EC ; id 37 EvilArmor
    dw $FDFD ; id 38 next result
    dw $007C ; id 39 Phoenix
    dw $FFFF ; id 40 end of list

; E-0199 (derived: list for entry $02 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules002::
Data_00E_7C1F:: ; address name
    dw $0100 ; id 0 Mudron
    dw $FDFD ; id 1 next result
    dw $0025 ; id 2 Tortragon
    dw $FDFD ; id 3 next result
    dw $006E ; id 4 DuckKite
    dw $FDFD ; id 5 next result
    dw $0096 ; id 6 Stubsuck
    dw $FDFD ; id 7 next result
    dw $0124 ; id 8 MetalDrak
    dw $0129 ; id 9 Roboster
    dw $012D ; id 10 LavaMan
    dw $012E ; id 11 IceMan
    dw $0132 ; id 12 Golem
    dw $0133 ; id 13 StoneMan
    dw $FDFD ; id 14 next result
    dw $00F8 ; id 15 PutrePup
    dw $FDFD ; id 16 next result
    dw $00EC ; id 17 EvilArmor
    dw $FDFD ; id 18 next result
    dw $0126 ; id 19 SabreMan
    dw $FDFD ; id 20 next result
    dw $0032 ; id 21 LizardFly
    dw $FDFD ; id 22 next result
    dw $000C ; id 23 FangSlime
    dw $FDFD ; id 24 next result
    dw $0001 ; id 25 DrakSlime
    dw $0029 ; id 26 LizardMan
    dw $FDFD ; id 27 next result
    dw $006F ; id 28 MadPecker
    dw $FDFD ; id 29 next result
    dw $002D ; id 30 Dragon
    dw $FDFD ; id 31 next result
    dw $002C ; id 32 Drygon
    dw $00D8 ; id 33 EyeBall
    dw $FFFF ; id 34 end of list

; E-0199 (derived: list for entry $03 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules003::
Data_00E_7C65:: ; address name
    dw $011D ; id 0 Facer
    dw $FDFD ; id 1 next result
    dw $000D ; id 2 RockSlime
    dw $FDFD ; id 3 next result
    dw $00BF ; id 4 Droll
    dw $FDFD ; id 5 next result
    dw $011C ; id 6 CoilBird
    dw $FDFD ; id 7 next result
    dw $0011 ; id 8 Metaly
    dw $0012 ; id 9 Metabble
    dw $0051 ; id 10 SuperTen
    dw $0056 ; id 11 Yeti
    dw $005D ; id 12 Goategon
    dw $005F ; id 13 Trumpeter
    dw $00F7 ; id 14 Skullgon
    dw $0107 ; id 15 DeadNoble
    dw $0108 ; id 16 WhiteKing
    dw $010A ; id 17 Skeletor
    dw $012E ; id 18 IceMan
    dw $FDFD ; id 19 next result
    dw $0001 ; id 20 DrakSlime
    dw $004C ; id 21 GulpBeast
    dw $0052 ; id 22 IronTurt
    dw $0055 ; id 23 Grizzly
    dw $00DE ; id 24 ArcDemon
    dw $010D ; id 25 Copycat
    dw $012C ; id 26 Gismo
    dw $012D ; id 27 LavaMan
    dw $FDFD ; id 28 next result
    dw $0030 ; id 29 Rayburn
    dw $0036 ; id 30 SnakeBat
    dw $FDFD ; id 31 next result
    dw $0014 ; id 32 TropicGel
    dw $0098 ; id 33 DanceVegi
    dw $00B8 ; id 34 Pyuro
    dw $0128 ; id 35 Brushead
    dw $FFFF ; id 36 end of list

; E-0199 (derived: list for entry $04 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules004::
Data_00E_7CAF:: ; address name
    dw $00B2 ; id 0 Gophecada
    dw $0140 ; id 1 Anemon
    dw $FDFD ; id 2 next result
    dw $011D ; id 3 Facer
    dw $FDFD ; id 4 next result
    dw $00D3 ; id 5 Pixy
    dw $FDFD ; id 6 next result
    dw $0092 ; id 7 Gulpple
    dw $FDFD ; id 8 next result
    dw $0101 ; id 9 NiteWhip
    dw $FDFD ; id 10 next result
    dw $0080 ; id 11 FunkyBird
    dw $FDFD ; id 12 next result
    dw $004A ; id 13 PillowRat
    dw $0147 ; id 14 FishRider
    dw $FDFD ; id 15 next result
    dw $000D ; id 16 RockSlime
    dw $0063 ; id 17 BigEye
    dw $006E ; id 18 DuckKite
    dw $0074 ; id 19 KiteHawk
    dw $00B3 ; id 20 Butterfly
    dw $00BD ; id 21 Eyeder
    dw $00D7 ; id 22 DarkEye
    dw $00D8 ; id 23 EyeBall
    dw $011F ; id 24 MadMirror
    dw $0149 ; id 25 Gamanian
    dw $FDFD ; id 26 next result
    dw $00B6 ; id 27 Lipsy
    dw $00BF ; id 28 Droll
    dw $0141 ; id 29 Aquarella
    dw $FFFF ; id 30 end of list

; E-0199 (derived: list for entry $05 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules005::
Data_00E_7CED:: ; address name
    dw $008F ; id 0 FloraMan
    dw $FDFD ; id 1 next result
    dw $0052 ; id 2 IronTurt
    dw $FDFD ; id 3 next result
    dw $0094 ; id 4 AmberWeed
    dw $0145 ; id 5 Octoreach
    dw $0149 ; id 6 Gamanian
    dw $FDFD ; id 7 next result
    dw $004B ; id 8 Saccer
    dw $013F ; id 9 RayGigas
    dw $FDFD ; id 10 next result
    dw $00F6 ; id 11 Spooky
    dw $FDFD ; id 12 next result
    dw $00FB ; id 13 DarkCrab
    dw $014B ; id 14 CancerMan
    dw $FDFD ; id 15 next result
    dw $005B ; id 16 FairyRat
    dw $FDFD ; id 17 next result
    dw $00DC ; id 18 1EyeClown
    dw $0103 ; id 19 Reaper
    dw $FFFF ; id 20 end of list

; E-0199 (derived: list for entry $06 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules006::
Data_00E_7D17:: ; address name
    dw $0029 ; id 0 LizardMan
    dw $FDFD ; id 1 next result
    dw $0061 ; id 2 DarkHorn
    dw $FDFD ; id 3 next result
    dw $009D ; id 4 BeanMan
    dw $FDFD ; id 5 next result
    dw $0054 ; id 6 HammerMan
    dw $FDFD ; id 7 next result
    dw $002F ; id 8 MadDragon
    dw $0059 ; id 9 BeastNite
    dw $FDFD ; id 10 next result
    dw $0120 ; id 11 RogueNite
    dw $FDFD ; id 12 next result
    dw $0063 ; id 13 BigEye
    dw $FDFD ; id 14 next result
    dw $00BC ; id 15 ArmorPede
    dw $FFFF ; id 16 end of list

; E-0199 (derived: list for entry $07 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules007::
Data_00E_7D39:: ; address name
    dw $002B ; id 0 Swordgon
    dw $0030 ; id 1 Rayburn
    dw $0033 ; id 2 Andreal
    dw $0038 ; id 3 GreatDrak
    dw $003C ; id 4 Orochi
    dw $003D ; id 5 BattleRex
    dw $0040 ; id 6 Divinegon
    dw $FDFD ; id 7 next result
    dw $0149 ; id 8 Gamanian
    dw $014A ; id 9 Clawster
    dw $014B ; id 10 CancerMan
    dw $FDFD ; id 11 next result
    dw $0008 ; id 12 BoxSlime
    dw $000C ; id 13 FangSlime
    dw $0047 ; id 14 Tonguella
    dw $0056 ; id 15 Yeti
    dw $0080 ; id 16 FunkyBird
    dw $008D ; id 17 MadPlant
    dw $0098 ; id 18 DanceVegi
    dw $00B0 ; id 19 GiantSlug
    dw $00B6 ; id 20 Lipsy
    dw $00BF ; id 21 Droll
    dw $FDFD ; id 22 next result
    dw $0071 ; id 23 MistyWing
    dw $FDFD ; id 24 next result
    dw $004E ; id 25 WindBeast
    dw $FDFD ; id 26 next result
    dw $00B4 ; id 27 WeedBug
    dw $FFFF ; id 28 end of list

; E-0199 (derived: list for entry $08 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules008::
Data_00E_7D73:: ; address name
    dw $00DD ; id 0 Gremlin
    dw $FDFD ; id 1 next result
    dw $00B6 ; id 2 Lipsy
    dw $FDFD ; id 3 next result
    dw $0033 ; id 4 Andreal
    dw $FDFD ; id 5 next result
    dw $00B5 ; id 6 GiantWorm
    dw $FDFD ; id 7 next result
    dw $0090 ; id 8 WingTree
    dw $FDFD ; id 9 next result
    dw $004C ; id 10 GulpBeast
    dw $0055 ; id 11 Grizzly
    dw $005F ; id 12 Trumpeter
    dw $0060 ; id 13 KingLeo
    dw $00D9 ; id 14 SkulRider
    dw $FDFD ; id 15 next result
    dw $0005 ; id 16 Snaily
    dw $FDFD ; id 17 next result
    dw $0008 ; id 18 BoxSlime
    dw $FDFD ; id 19 next result
    dw $0073 ; id 20 Dracky
    dw $FDFD ; id 21 next result
    dw $00C4 ; id 22 HornBeet
    dw $00C7 ; id 23 Digster
    dw $FDFD ; id 24 next result
    dw $00EC ; id 25 EvilArmor
    dw $FFFF ; id 26 end of list

; E-0199 (derived: list for entry $09 of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules009::
Data_00E_7DA9:: ; address name
    dw $0119 ; id 0 JewelBag
    dw $FDFD ; id 1 next result
    dw $0053 ; id 2 Mommonja
    dw $006E ; id 3 DuckKite
    dw $006F ; id 4 MadPecker
    dw $0078 ; id 5 MadGoose
    dw $0084 ; id 6 CragDevil
    dw $011E ; id 7 SpikyBoy
    dw $0134 ; id 8 BombCrag
    dw $FFFF ; id 9 end of list

; E-0199 (derived: list for entry $0A of FamilyBreedRuleTable; it runs to the next list)
; record: partner species or rule code
FamilyBreedRules00A::
Data_00E_7DBD:: ; address name
    dw $FFFF ; id 0 end of list

; E-0199 (C1: stage 3 result lists, indexed by parent A's family)
; record: list
FamilyBreedResultTable::
Data_00E_7DBF:: ; address name
    dw FamilyBreedResults000 ; id 0
    dw FamilyBreedResults001 ; id 1
    dw FamilyBreedResults002 ; id 2
    dw FamilyBreedResults003 ; id 3
    dw FamilyBreedResults004 ; id 4
    dw FamilyBreedResults005 ; id 5
    dw FamilyBreedResults006 ; id 6
    dw FamilyBreedResults007 ; id 7
    dw FamilyBreedResults008 ; id 8
    dw FamilyBreedResults009 ; id 9
    dw FamilyPairResultTable ; id 10

; E-0199 (derived: list for entry $00 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults000::
Data_00E_7DD5:: ; address name
    dw $0007 ; id 0 Babble
    dw $000B ; id 1 Healer
    dw $000C ; id 2 FangSlime
    dw $000D ; id 3 RockSlime
    dw $000E ; id 4 SlimeBorg
    dw $000F ; id 5 Slabbit
    dw $0011 ; id 6 Metaly

; E-0199 (derived: list for entry $01 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults001::
Data_00E_7DE3:: ; address name
    dw $002E ; id 0 MiniDrak
    dw $002F ; id 1 MadDragon
    dw $0030 ; id 2 Rayburn
    dw $0031 ; id 3 Chamelgon
    dw $0032 ; id 4 LizardFly
    dw $0033 ; id 5 Andreal
    dw $0034 ; id 6 KingCobra
    dw $0035 ; id 7 Vampirus
    dw $0036 ; id 8 SnakeBat
    dw $0037 ; id 9 Spikerous
    dw $0038 ; id 10 GreatDrak
    dw $0039 ; id 11 Crestpent
    dw $003D ; id 12 BattleRex
    dw $003E ; id 13 SkyDragon

; E-0199 (derived: list for entry $02 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults002::
Data_00E_7DFF:: ; address name
    dw $0051 ; id 0 SuperTen
    dw $0052 ; id 1 IronTurt
    dw $0053 ; id 2 Mommonja
    dw $0054 ; id 3 HammerMan
    dw $0055 ; id 4 Grizzly
    dw $0057 ; id 5 ArrowDog
    dw $0059 ; id 6 BeastNite
    dw $005A ; id 7 MadGopher
    dw $005B ; id 8 FairyRat
    dw $005C ; id 9 Unicorn
    dw $005D ; id 10 Goategon
    dw $005E ; id 11 WildApe
    dw $0062 ; id 12 MadCat
    dw $0063 ; id 13 BigEye

; E-0199 (derived: list for entry $03 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults003::
Data_00E_7E1B:: ; address name
    dw $0074 ; id 0 KiteHawk
    dw $0076 ; id 1 StubBird
    dw $0078 ; id 2 MadGoose
    dw $0079 ; id 3 MadCondor
    dw $007B ; id 4 Blizzardy
    dw $007C ; id 5 Phoenix
    dw $007F ; id 6 WhipBird
    dw $0080 ; id 7 FunkyBird

; E-0199 (derived: list for entry $04 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults004::
Data_00E_7E2B:: ; address name
    dw $0097 ; id 0 Oniono
    dw $0098 ; id 1 DanceVegi
    dw $0099 ; id 2 TreeBoy
    dw $009A ; id 3 Devipine
    dw $009B ; id 4 FaceTree
    dw $009C ; id 5 HerbMan
    dw $009D ; id 6 BeanMan
    dw $009E ; id 7 EvilSeed
    dw $00A6 ; id 8 Eggplaton

; E-0199 (derived: list for entry $05 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults005::
Data_00E_7E3D:: ; address name
    dw $00BB ; id 0 TailEater
    dw $00BC ; id 1 ArmorPede
    dw $00BD ; id 2 Eyeder
    dw $00BE ; id 3 GiantMoth
    dw $00BF ; id 4 Droll
    dw $00C0 ; id 5 ArmyCrab
    dw $00C1 ; id 6 MadHornet
    dw $00C5 ; id 7 Sickler

; E-0199 (derived: list for entry $06 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults006::
Data_00E_7E4D:: ; address name
    dw $00DF ; id 0 Lionex
    dw $00E0 ; id 1 GoatHorn
    dw $00E1 ; id 2 Orc
    dw $00E2 ; id 3 Ogre
    dw $00E6 ; id 4 Grendal
    dw $00E8 ; id 5 MadKnight
    dw $00EA ; id 6 Gigantes
    dw $00EC ; id 7 EvilArmor

; E-0199 (derived: list for entry $07 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults007::
Data_00E_7E5D:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $00FB ; id 1 DarkCrab
    dw $0100 ; id 2 Mudron
    dw $0101 ; id 3 NiteWhip
    dw $0102 ; id 4 WindMerge
    dw $0103 ; id 5 Reaper

; E-0199 (derived: list for entry $08 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults008::
Data_00E_7E69:: ; address name
    dw $0121 ; id 0 Puppetor
    dw $0123 ; id 1 Voodoll
    dw $0124 ; id 2 MetalDrak
    dw $0126 ; id 3 SabreMan
    dw $0127 ; id 4 CurseLamp
    dw $0129 ; id 5 Roboster
    dw $012B ; id 6 EvilPot
    dw $012F ; id 7 Mimic
    dw $0130 ; id 8 Exaucers
    dw $0133 ; id 9 StoneMan
    dw $0137 ; id 10 ProtoMech

; E-0199 (derived: list for entry $09 of FamilyBreedResultTable; it runs to the next list)
; record: child species
FamilyBreedResults009::
Data_00E_7E7F:: ; address name
    dw $014C ; id 0 RogueWave
    dw $015A ; id 1 Pumpoise

; E-0199 (C1: stage 4, when stage 3 finds nothing: the row at $7E83 + 2 * parent A's family, word [parent B's family]: $FFFF = parent A's species, $FExx = no child (wNameEntryState = 6, wArg5 = $FF), otherwise the child's species; 11 rows of 11 words end at Script_0E_7F8B)
; record: list
FamilyPairResultTable::
Data_00E_7E83:: ; address name
    dw FamilyPairResults000 ; id 0
    dw FamilyPairResults001 ; id 1
    dw FamilyPairResults002 ; id 2
    dw FamilyPairResults003 ; id 3
    dw FamilyPairResults004 ; id 4
    dw FamilyPairResults005 ; id 5
    dw FamilyPairResults006 ; id 6
    dw FamilyPairResults007 ; id 7
    dw FamilyPairResults008 ; id 8
    dw FamilyPairResults009 ; id 9
    dw FamilyPairResults00A ; id 10

; E-0199 (derived: list for entry $00 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults000::
Data_00E_7E99:: ; address name
    dw $FFFF ; id 0 parent A's species
    dw $0001 ; DrakSlime
    dw $0002 ; SpotSlime
    dw $0003 ; WingSlime
    dw $0004 ; TreeSlime
    dw $0005 ; Snaily
    dw $0006 ; SlimeNite
    dw $0007 ; Babble
    dw $0008 ; BoxSlime
    dw $0009 ; PearlGel
    dw $0010 ; KingSlime

; E-0199 (derived: list for entry $01 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults001::
Data_00E_7EAF:: ; address name
    dw $0024 ; id 0 DragonKid
    dw $FFFF ; parent A's species
    dw $0025 ; Tortragon
    dw $0026 ; Pteranod
    dw $0027 ; Gasgon
    dw $0028 ; FairyDrak
    dw $0029 ; LizardMan
    dw $002A ; Poisongon
    dw $002B ; Swordgon
    dw $002C ; Drygon
    dw $003C ; Orochi

; E-0199 (derived: list for entry $02 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults002::
Data_00E_7EC5:: ; address name
    dw $0047 ; id 0 Tonguella
    dw $0048 ; Almiraj
    dw $FFFF ; parent A's species
    dw $0049 ; CatFly
    dw $004A ; PillowRat
    dw $004B ; Saccer
    dw $0055 ; Grizzly
    dw $004D ; Skullroo
    dw $004E ; WindBeast
    dw $004F ; Beavern
    dw $0061 ; DarkHorn

; E-0199 (derived: list for entry $03 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults003::
Data_00E_7EDB:: ; address name
    dw $006A ; id 0 Picky
    dw $006B ; Wyvern
    dw $006C ; BullBird
    dw $FFFF ; parent A's species
    dw $006D ; Florajay
    dw $006E ; DuckKite
    dw $006F ; MadPecker
    dw $0070 ; MadRaven
    dw $0071 ; MistyWing
    dw $0072 ; AquaHawk
    dw $007D ; ZapBird

; E-0199 (derived: list for entry $04 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults004::
Data_00E_7EF1:: ; address name
    dw $008D ; id 0 MadPlant
    dw $008E ; FireWeed
    dw $008F ; FloraMan
    dw $0090 ; WingTree
    dw $FFFF ; parent A's species
    dw $0091 ; CactiBall
    dw $0092 ; Gulpple
    dw $0093 ; Toadstool
    dw $0094 ; AmberWeed
    dw $0095 ; Slurperon
    dw $00A2 ; Rosevine

; E-0199 (derived: list for entry $05 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults005::
Data_00E_7F07:: ; address name
    dw $00B0 ; id 0 GiantSlug
    dw $00B1 ; Catapila
    dw $00B2 ; Gophecada
    dw $00B3 ; Butterfly
    dw $00B4 ; WeedBug
    dw $FFFF ; parent A's species
    dw $00B5 ; GiantWorm
    dw $00B6 ; Lipsy
    dw $00B7 ; StagBug
    dw $00B8 ; Pyuro
    dw $00C7 ; Digster

; E-0199 (derived: list for entry $06 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults006::
Data_00E_7F1D:: ; address name
    dw $00D3 ; id 0 Pixy
    dw $00D4 ; MedusaEye
    dw $00DD ; Gremlin
    dw $00D6 ; Demonite
    dw $00D7 ; DarkEye
    dw $00D8 ; EyeBall
    dw $FFFF ; parent A's species
    dw $00D9 ; SkulRider
    dw $00DA ; EvilBeast
    dw $00DB ; Bubblemon
    dw $00DE ; ArcDemon

; E-0199 (derived: list for entry $07 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults007::
Data_00E_7F33:: ; address name
    dw $00F6 ; id 0 Spooky
    dw $010E ; MadSpirit
    dw $00F8 ; PutrePup
    dw $00F9 ; RotRaven
    dw $00FA ; Mummy
    dw $00FB ; DarkCrab
    dw $00FC ; DeadNite
    dw $FFFF ; parent A's species
    dw $00FD ; Shadow
    dw $00FE ; Skulpent
    dw $0108 ; WhiteKing

; E-0199 (derived: list for entry $08 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults008::
Data_00E_7F49:: ; address name
    dw $0119 ; id 0 JewelBag
    dw $011A ; EvilWand
    dw $011B ; MadCandle
    dw $011C ; CoilBird
    dw $011D ; Facer
    dw $011E ; SpikyBoy
    dw $011F ; MadMirror
    dw $0120 ; RogueNite
    dw $FFFF ; parent A's species
    dw $0128 ; Brushead
    dw $0125 ; Balzak

; E-0199 (derived: list for entry $09 of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults009::
Data_00E_7F5F:: ; address name
    dw $013C ; id 0 Petiteel
    dw $013D ; Moray
    dw $013E ; WalrusMan
    dw $013F ; RayGigas
    dw $0140 ; Anemon
    dw $0141 ; Aquarella
    dw $0142 ; Merman
    dw $0144 ; PutreFish
    dw $0143 ; Octokid
    dw $FFFF ; parent A's species
    dw $0158 ; Grakos

; E-0199 (derived: list for entry $0A of FamilyPairResultTable; it runs to the next list)
; record: child species for parent-B families 0-10
FamilyPairResults00A::
Data_00E_7F75:: ; address name
    dw $FFFF ; id 0 parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species
    dw $FFFF ; parent A's species

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_0E_7F8B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_message_by_screen $C003 ; screen 0: 'Its accessory is in the Vault.'
Script_0E_7F8F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7F99, Script_0E_7F93
Script_0E_7F93:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $8002 ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0E_7F99:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C005 ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_NPC_BREED
Script_0E_7F9D:: ; heuristic: event script entry or jump target; C0
    script_choice_jump Script_0E_7FA8, Script_0E_7FAC, Script_0E_7FA1
Script_0E_7FA1:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C004 ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_NPC_BREED
    script_jump Script_0E_7F8F
Script_0E_7FA8:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_jump Script_0E_7F9D
Script_0E_7FAC:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FC1, Script_0E_7FB7, Script_0E_7FB1
Script_0E_7FB1:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C006 ; screen 0: 'Its accessory is in the Vault.'
    script_jump Script_0E_7FBA
Script_0E_7FB7:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C007 ; screen 0: 'Its accessory is in the Vault.'
Script_0E_7FBA:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C003 ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_NPC_BREED
    script_jump Script_0E_7F8F
Script_0E_7FC1:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FC5, Script_0E_7FC8
Script_0E_7FC5:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0E_7FCB
Script_0E_7FC8:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C00C ; screen 0: 'Is it OK to save the'
Script_0E_7FCB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FD5, Script_0E_7FCF
Script_0E_7FCF:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C008 ; screen 0: 'Its accessory is in the Vault.'
    script_jump Script_0E_7FD8
Script_0E_7FD5:: ; heuristic: event script entry or jump target; C0
    script_message_by_screen $C00B ; screen 0: 'Its accessory is in the Vault.'
Script_0E_7FD8:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_choice_jump Script_0E_7FE2, Script_0E_7FDC
Script_0E_7FDC:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $8002 ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0E_7FE2:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED
    script_message_by_screen $C009 ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_NPC_BREED
    script_command SCRIPT_MENU_CLOSE
    script_message_by_screen $000A ; screen 0: 'Its accessory is in the Vault.'
    script_command SCRIPT_MENU_CLOSE
    script_end
    ds $13, $00
