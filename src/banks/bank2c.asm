SECTION "Bank 2C", ROMX[$4000], BANK[$2C]
    db $2C

; message bank $2C: when wStringIndex < $91, BeginStringDisplay with this bank's table Data_02C_4032; otherwise far-calls Func_098_4026 (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank2C, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2C, ShowMessageHL_ToBeginStringDisplay_Bank2C)
; reads: wStringIndex
BeginStringDisplay_Bank2C::
Func_02C_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $91
    jr c, Jump_02C_400F
    farcall BeginStringDisplay_Bank2C_Overflow
    ret

Jump_02C_400F::
    ld de, MessageStrings_Bank2C
    call BeginStringDisplay
    ret

; message bank $2C: when wStringIndex < $91, CopyStringToBuffer with this bank's table Data_02C_4032; otherwise far-calls Func_098_4035 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank2C:: ; heuristic: follows a terminator; C0
Func_02C_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $91
    jr c, Jump_02C_4024
    farcall CopyStringToBuffer_Bank2C_Overflow
    ret

Jump_02C_4024::
    ld de, MessageStrings_Bank2C
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_2C_4032::
MessageStrings_Bank2C:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_02C_4032:: ; address name
    dw StringList_2C_4034 ; id 0

; E-0217 (derived: category list of StringCategories_2C_4032; one pointer per wStringIndex)
; record: string
StringList_2C_4034::
Data_02C_4034:: ; address name
    dw Message_04_00 ; id 0
    dw Message_04_01 ; id 1
    dw Message_04_02 ; id 2
    dw Message_04_03 ; id 3
    dw Message_04_04 ; id 4
    dw Message_04_05 ; id 5
    dw Message_04_06 ; id 6
    dw Message_04_07 ; id 7
    dw Message_04_08 ; id 8
    dw Message_04_09 ; id 9
    dw Message_04_0A ; id 10
    dw Message_04_0B ; id 11
    dw Message_04_0C ; id 12
    dw Message_04_0D ; id 13
    dw Message_04_0E ; id 14
    dw Message_04_0F ; id 15
    dw Message_04_10 ; id 16
    dw Message_04_11 ; id 17
    dw Message_04_12 ; id 18
    dw Message_04_13 ; id 19
    dw Message_04_14 ; id 20
    dw Message_04_15 ; id 21
    dw Message_04_16 ; id 22
    dw Message_04_17 ; id 23
    dw Message_04_18 ; id 24
    dw Message_04_19 ; id 25
    dw Message_04_1A ; id 26
    dw Message_04_1B ; id 27
    dw Message_04_1C ; id 28
    dw Message_04_1D ; id 29
    dw Message_04_1E ; id 30
    dw Message_04_1F ; id 31
    dw Message_04_20 ; id 32
    dw Message_04_21 ; id 33
    dw Message_04_22 ; id 34
    dw Message_04_23 ; id 35
    dw Message_04_24 ; id 36
    dw Message_04_25 ; id 37
    dw Message_04_26 ; id 38
    dw Message_04_27 ; id 39
    dw Message_04_28 ; id 40
    dw Message_04_29 ; id 41
    dw Message_04_2A ; id 42
    dw Message_04_2B ; id 43
    dw Message_04_2C ; id 44
    dw Message_04_2D ; id 45
    dw Message_04_2E ; id 46
    dw Message_04_2F ; id 47
    dw Message_04_30 ; id 48
    dw Message_04_31 ; id 49
    dw Message_04_32 ; id 50
    dw Message_04_33 ; id 51
    dw Message_04_34 ; id 52
    dw Message_04_35 ; id 53
    dw Message_04_36 ; id 54
    dw Message_04_37 ; id 55
    dw Message_04_38 ; id 56
    dw Message_04_39 ; id 57
    dw Message_04_3A ; id 58
    dw Message_04_3B ; id 59
    dw Message_04_3C ; id 60
    dw Message_04_3D ; id 61
    dw Message_04_3E ; id 62
    dw Message_04_3F ; id 63
    dw Message_04_40 ; id 64
    dw Message_04_41 ; id 65
    dw Message_04_42 ; id 66
    dw Message_04_43 ; id 67
    dw Message_04_44 ; id 68
    dw Message_04_45 ; id 69
    dw Message_04_46 ; id 70
    dw Message_04_47 ; id 71
    dw Message_04_48 ; id 72
    dw Message_04_49 ; id 73
    dw Message_04_4A ; id 74
    dw Message_04_4B ; id 75
    dw Message_04_4C ; id 76
    dw Message_04_4D ; id 77
    dw Message_04_4E ; id 78
    dw Message_04_4F ; id 79
    dw Message_04_50 ; id 80
    dw Message_04_51 ; id 81
    dw Message_04_52 ; id 82
    dw Message_04_53 ; id 83
    dw Message_04_53 ; id 84
    dw Message_04_53 ; id 85
    dw Message_04_56 ; id 86
    dw Message_04_57 ; id 87
    dw Message_04_58 ; id 88
    dw Message_04_59 ; id 89
    dw Message_04_5A ; id 90
    dw Message_04_5B ; id 91
    dw Message_04_5C ; id 92
    dw Message_04_5D ; id 93
    dw Message_04_5E ; id 94
    dw Message_04_5F ; id 95
    dw Message_04_60 ; id 96
    dw Message_04_61 ; id 97
    dw Message_04_62 ; id 98
    dw Message_04_63 ; id 99
    dw Message_04_64 ; id 100
    dw Message_04_65 ; id 101
    dw Message_04_66 ; id 102
    dw Message_04_67 ; id 103
    dw Message_04_68 ; id 104
    dw Message_04_69 ; id 105
    dw Message_04_6A ; id 106
    dw Message_04_6B ; id 107
    dw Message_04_6C ; id 108
    dw Message_04_6D ; id 109
    dw Message_04_6E ; id 110
    dw Message_04_6F ; id 111
    dw Message_04_70 ; id 112
    dw Message_04_71 ; id 113
    dw Message_04_72 ; id 114
    dw Message_04_73 ; id 115
    dw Message_04_74 ; id 116
    dw Message_04_75 ; id 117
    dw Message_04_76 ; id 118
    dw Message_04_77 ; id 119
    dw Message_04_78 ; id 120
    dw Message_04_79 ; id 121
    dw Message_04_7A ; id 122
    dw Message_04_7B ; id 123
    dw Message_04_7C ; id 124
    dw Message_04_7D ; id 125
    dw Message_04_7E ; id 126
    dw Message_04_7F ; id 127
    dw Message_04_80 ; id 128
    dw Message_04_81 ; id 129
    dw Message_04_82 ; id 130
    dw Message_04_83 ; id 131
    dw Message_04_84 ; id 132
    dw Message_04_85 ; id 133
    dw Message_04_86 ; id 134
    dw Message_04_87 ; id 135
    dw Message_04_88 ; id 136
    dw Message_04_88 ; id 137
    dw Message_04_88 ; id 138
    dw Message_04_8B ; id 139
    dw Message_04_8C ; id 140
    dw Message_04_8D ; id 141
    dw Message_04_8E ; id 142
    dw Message_04_8F ; id 143
    dw Message_04_90 ; id 144

Message_04_00:: ; heuristic: string; C0
Data_02C_4156:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "village of Fhunt.", $FA, $F7
    db $EF, $EE, "We have guarded", $EF, $EE, "the grave of Ugor,", $FA, $F7
    db $EF, $EE, "the Great Sage,", $EF, $EE, "for generations.", $F7
    db $F0

Message_04_01:: ; heuristic: string; C0
Data_02C_41C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Great Sage", $F1
    db "Ugor saved the", $FA, $F7
    db $EF, $EE, "world with the", $EF, $EE, "LightOrb.", $FA, $F7
    db $EF, $EE, "The LightOrb must", $EF, $EE, "have been very", $FA, $F7
    db $EF, $EE, "powerful to do", $EF, $EE, "that.", $F7
    db $F0

Message_04_02:: ; heuristic: string; C0
Data_02C_4241:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e come all", $F1
    db "this way, take the", $FA, $F7
    db $EF, $EE, "time to pay your", $EF, $EE, "respect to Ugor.", $FA, $F7
    db $EF, $EE, "His grave?", $EF, $EE, "You can't miss it!", $F7
    db $F0

Message_04_03:: ; heuristic: string; C0
Data_02C_42AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Great Sage,", $F1
    db "after saving the", $FA, $F7
    db $EF, $EE, "world, sealed the", $EF, $EE, "LightOrb away.", $FA, $F7
    db $EF, $EE, "It is sealed high", $EF, $EE, "in the tower.", $FA, $F7
    db $EF, $EE, "He feared that its", $EF, $EE, "power would be", $FA, $F7
    db $EF, $EE, "misused by those", $EF, $EE, "impure of thought", $FA, $F7
    db $EF, $EE, "to become the king", $EF, $EE, "of monsters.", $FA, $F7
    db $EF, $EE, "So, the LightOrb", $EF, $EE, "could be dangerous", $FA, $F7
    db $EF, $EE, "if it falls into", $EF, $EE, "the wrong hands.", $F7
    db $F0

Message_04_04:: ; heuristic: string; C0
Data_02C_43DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're not about", $F1
    db "to go after the", $FA, $F7
    db $EF, $EE, "LightOrb so you", $EF, $EE, "can be the king?", $FA, $F7
    db $EF, $EE, "I suggest you lose", $EF, $EE, "that thought now.", $F7
    db $F0

Message_04_05:: ; heuristic: string; C0
Data_02C_444D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some time ago,", $F1
    db "lightning struck", $FA, $F7
    db $EF, $EE, "the tower, causing", $EF, $EE, "it to buckle.", $FA, $F7
    db $EF, $EE, "Did someone do it", $EF, $EE, "deliberately?", $FA, $F7
    db $EF, $EE, "No, that can't be", $EF, $EE, "right", $A4, $FA, $F7
    db $EF, $EE, "The Orb is guarded", $EF, $EE, "by the Great Sage", $A4, $F7
    db $F0

Message_04_06:: ; heuristic: string; C0
Data_02C_4500:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Nobody can defy", $F1
    db "the Orb's bearer.", $FA, $F7
    db $EF, $EE, "It has absolute", $EF, $EE, "power over the", $FA, $F7
    db $EF, $EE, "will of monsters,", $EF, $EE, "they say.", $F7
    db $F0

Message_04_07:: ; heuristic: string; C0
Data_02C_4568:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A suspension", $F1
    db "bridge is in the", $FA, $F7
    db $EF, $EE, "south, but it's", $EF, $EE, "under guard.", $FA, $F7
    db $EF, $EE, "Nobody suspicious", $EF, $EE, "is allowed across.", $FA, $F7
    db $EF, $EE, "A human will never", $EF, $EE, "be permitted.", $F7
    db $F0

Message_04_08:: ; heuristic: string; C0
Data_02C_45F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A huge bird", $F1
    db "perches atop the", $FA, $F7
    db $EF, $EE, "tower every so", $EF, $EE, "often.", $FA, $F7
    db $EF, $EE, "I tell you, it's", $EF, $EE, "creepy.", $F7
    db $F0

Message_04_09:: ; heuristic: string; C0
Data_02C_464F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The tower's gate", $F1
    db "is tightly sealed.", $FA, $F7
    db $EF, $EE, "Anyone with any", $EF, $EE, "trace of wildness", $FA, $F7
    db $EF, $EE, "is kept out of the", $EF, $EE, "tower by magic.", $FA, $F7
    db $EF, $EE, "Are your monsters", $EF, $EE, "still wild?", $F7
    db $F0

Message_04_0A:: ; heuristic: string; C0
Data_02C_46E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The top of the", $F1
    db "tower collapsed", $FA, $F7
    db $EF, $EE, "when it was hit by", $EF, $EE, "lightning.", $FA, $F7
    db $EF, $EE, "We're trying to", $EF, $EE, "put up a ladder to", $FA, $F7
    db $EF, $EE, "see if we can't", $EF, $EE, "get a look in.", $F7
    db $F0

Message_04_0B:: ; heuristic: string; C0
Data_02C_4772:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "grave.", $FA, $F7
    db $EF, $EE, "There was an", $EF, $EE, "inscription.", $FA, $F7
    db $EF, $EE, $95, "Here lies Ugor,", $EF, $EE, "the Great Sage", $FA, $F7
    db $EF, $EE, "and the world's", $EF, $EE, "savior.", $95, $F7
    db $F0

Message_04_0C:: ; heuristic: string; C0
Data_02C_47E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who disturbs my", $F1
    db "sleep?", $FA, $F7
    db $EF, $EE, "A visitor from", $EF, $EE, "another world?", $FA, $F7
    db $EF, $EE, "This is indeed a", $EF, $EE, "rare occasion.", $FA, $F7
    db $EF, $EE, "However, no one", $EF, $EE, "must be permitted", $FA, $F7
    db $EF, $EE, "to obtain the", $EF, $EE, "LightOrb.", $FA, $F7
    db $EF, $EE, "It has been sealed", $EF, $EE, "away to sleep", $A4, $FA, $F7
    db $EF, $EE, "Yes", $A4, " In the same", $EF, $EE, "way that I do", $A4, $F7
    db $F0

Message_04_0D:: ; heuristic: string; C0
Data_02C_48D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? You again?", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "You seem to have", $EF, $EE, "come from afar,", $FA, $F7
    db $EF, $EE, "but the Orb must", $EF, $EE, "be left untouched.", $FA, $F7
    db $EF, $EE, "It will never fall", $EF, $EE, "into anyone's hands", $FA, $F7
    db $EF, $EE, "again. I assure", $EF, $EE, "you of that", $A4, $F7
    db $F0

Message_04_0E:: ; heuristic: string; C0
Data_02C_4983:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "grave.", $FA, $F7
    db $EF, $EE, "The tombstone was", $EF, $EE, "covered in moss.", $F7
    db $F0

Message_04_0F:: ; heuristic: string; C0
Data_02C_49C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "A peculiar meat", $EF, $EE, "broth was boiling.", $F7
    db $F0

Message_04_10:: ; heuristic: string; C0
Data_02C_49FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Be gone!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "If your soul can't", $EF, $EE, "overcome natural", $FA, $F7
    db $EF, $EE, "wildness within,", $EF, $EE, "you are forbidden", $FA, $F7
    db $EF, $EE, "from entering the", $EF, $EE, "tower. Leave now!", $F7
    db $F0

Message_04_11:: ; heuristic: string; C0
Data_02C_4A84:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Fine!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "You", $42, "e done well", $EF, $EE, "to quell the wild", $FA, $F7
    db $EF, $EE, "heart that beats", $EF, $EE, "inside.", $FA, $F7
    db $EF, $EE, "You", $42, "e earned the", $EF, $EE, "right to enter!", $F7
    db $F0

Message_04_12:: ; heuristic: string; C0
Data_02C_4AF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Kweeeeh!", $F1
    db $F7
    db $F0

Message_04_13:: ; heuristic: string; C0
Data_02C_4B07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "The chest was", $EF, $EE, "empty.", $FA, $F7
    db $EF, $EE, "Could the LightOrb", $EF, $EE, "have been in it?", $F7
    db $F0

Message_04_14:: ; heuristic: string; C0
Data_02C_4B68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? What?", $F1
    db "What happened?", $FA, $F7
    db $EF, $EE, "I saw a huge bird", $EF, $EE, "fly up and go into", $FA, $F7
    db $EF, $EE, "the tower and", $EF, $EE, "then it came out", $FA, $F7
    db $EF, $EE, "clutching a shiny", $EF, $EE, "object.", $FA, $F7
    db $EF, $EE, "It flew off to the", $EF, $EE, "west.", $F7
    db $F0

Message_04_15:: ; heuristic: string; C0
Data_02C_4C0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who disturbs my", $F1
    db "sleep?", $FA, $F7
    db $EF, $EE, "A visitor from", $EF, $EE, "another world?", $FA, $F7
    db $EF, $EE, "This is indeed a", $EF, $EE, "rare occasion.", $FA, $F7
    db $EF, $EE, "However, no one", $EF, $EE, "must be permitted", $FA, $F7
    db $EF, $EE, "to obtain the", $EF, $EE, "LightOrb.", $FA, $F7
    db $EF, $EE, "It has been sealed", $EF, $EE, "away to sleep", $A4, $FA, $F7
    db $EF, $EE, "Yes", $A4, " In the same", $EF, $EE, "way that I do", $A4, $FA, $F7
    db $EF, $EE, "What? The LightOrb", $EF, $EE, "was stolen?", $FA, $F7
    db $EF, $EE, "If it falls into", $EF, $EE, "the wrong hands", $A4, $FA, $F7
    db $EF, $EE, "Urrrgh", $A4, $EF, $EE, "What to do", $A4, $FA, $F7
    db $EF, $EE, "I know! Can you go", $EF, $EE, "recover it?", $FF, $F0

Message_04_16:: ; heuristic: string; C0
Data_02C_4D7F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, you'll do", $F1
    db "it? Excellent!", $FA, $F7
    db $EF, $EE, "But you, being a", $EF, $EE, "human-you stand ", $FA, $F7
    db $EF, $EE, "out too much in", $EF, $EE, "this world.", $FA, $F7
    db $EF, $EE, "Look behind my", $EF, $EE, "gravestone and", $FA, $F7
    db $EF, $EE, "take what you", $EF, $EE, "find. It's a gift.", $F7
    db $F0

Message_04_17:: ; heuristic: string; C0
Data_02C_4E2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I had thought", $F1
    db "that you could be", $FA, $F7
    db $EF, $EE, "trusted with the", $EF, $EE, "LightOrb", $A4, $F7
    db $F0

Message_04_18:: ; heuristic: string; C0
Data_02C_4E6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who disturbs my", $F1
    db "sleep?", $FA, $F7
    db $EF, $EE, "Oh, it's you again.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Sorry, but the", $EF, $EE, "LightOrb", $A4, $FA, $F7
    db $EF, $EE, "What? The LightOrb", $EF, $EE, "was stolen?", $FA, $F7
    db $EF, $EE, "If it falls into", $EF, $EE, "the wrong hands", $A4, $FA, $F7
    db $EF, $EE, "Urrrgh", $A4, $EF, $EE, "What to do", $A4, $FA, $F7
    db $EF, $EE, "I know! Can you go", $EF, $EE, "recover it?", $FF, $F0

Message_04_19:: ; heuristic: string; C0
Data_02C_4F43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well? Will you", $F1
    db "go look for the", $FA, $F7
    db $EF, $EE, "stolen LightOrb", $EF, $EE, "for me?", $FF, $F0

Message_04_1A:: ; heuristic: string; C0
Data_02C_4F82:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked", $F1
    db "behind the grave.", $FA, $F7
    db $EF, $EE, "The ChangeStaff", $EF, $EE, "was found!", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "ChangeStaff.", $F7
    db $F0

Message_04_1B:: ; heuristic: string; C0
Data_02C_4FE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked", $F1
    db "behind the grave.", $FA, $F7
    db $EF, $EE, "The ChangeStaff", $EF, $EE, "was found!", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put back the", $EF, $EE, "ChangeStaff.", $F7
    db $F0

Message_04_1C:: ; heuristic: string; C0
Data_02C_505F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? You're a", $F1
    db "stranger!", $FA, $F7
    db $EF, $EE, "You make me very", $EF, $EE, "suspicious!", $FA, $F7
    db $EF, $EE, "I won't let you go", $EF, $EE, "past me!", $F7
    db $F0

Message_04_1D:: ; heuristic: string; C0
Data_02C_50B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? You're from", $F1
    db "the village!", $FA, $F7
    db $EF, $EE, "Hurry up and go", $EF, $EE, "through!", $F7
    db $F0

Message_04_1E:: ; heuristic: string; C0
Data_02C_50F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This is the town", $F1
    db "of Pei.", $FA, $F7
    db $EF, $EE, "You'll find most", $EF, $EE, "travel items here.", $F7
    db $F0

Message_04_1F:: ; heuristic: string; C0
Data_02C_513A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Nya? Travelers?", $F1
    db "That's rare!", $F7
    db $F0

Message_04_20:: ; heuristic: string; C0
Data_02C_515A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " To the west is a", $F1
    db "mountain.", $FA, $F7
    db $EF, $EE, "A huge bird that", $EF, $EE, "likes shiny things", $FA, $F7
    db $EF, $EE, "makes its nest", $EF, $EE, "there.", $F7
    db $F0

Message_04_21:: ; heuristic: string; C0
Data_02C_51BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You should stay", $F1
    db "well clear of the", $FA, $F7
    db $EF, $EE, "mountain in the", $EF, $EE, "west.", $FA, $F7
    db $EF, $EE, "The immense bird", $EF, $EE, "that lives there", $FA, $F7
    db $EF, $EE, "will carry you off", $EF, $EE, "if you get close.", $F7
    db $F0

Message_04_22:: ; heuristic: string; C0
Data_02C_524A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I came close to", $F1
    db "being abducted by", $FA, $F7
    db $EF, $EE, "a huge bird a", $EF, $EE, "while ago.", $FA, $F7
    db $EF, $EE, "Be careful if you", $EF, $EE, "have any shiny", $FA, $F7
    db $EF, $EE, "monsters like me.", $EF, $EE, "It's dangerous!", $F7
    db $F0

Message_04_23:: ; heuristic: string; C0
Data_02C_52D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some time ago, a", $F1
    db "human child was", $FA, $F7
    db $EF, $EE, "taken away by the", $EF, $EE, "huge bird.", $FA, $F7
    db $EF, $EE, "The child hasn't", $EF, $EE, "been seen since.", $F7
    db $F0

Message_04_24:: ; heuristic: string; C0
Data_02C_5342:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There wasn't a", $F1
    db "monster king for", $FA, $F7
    db $EF, $EE, "a long time, but a", $EF, $EE, "new king appeared", $FA, $F7
    db $EF, $EE, "recently to take", $EF, $EE, "the vacant throne.", $F7
    db $F0

Message_04_25:: ; heuristic: string; C0
Data_02C_53B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The new monster", $F1
    db "king makes others", $FA, $F7
    db $EF, $EE, "obey using magical", $EF, $EE, "powers.", $FA, $F7
    db $EF, $EE, "Nobody appears to", $EF, $EE, "be rebelling.", $F7
    db $F0

Message_04_26:: ; heuristic: string; C0
Data_02C_541F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $A4, " Are you a", $F1
    db "monster?", $FF, $F0

Message_04_27:: ; heuristic: string; C0
Data_02C_543B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Uh-huh", $A4, " You don't", $F1
    db "look very strong.", $F7
    db $F0

Message_04_28:: ; heuristic: string; C0
Data_02C_5462:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Uh-huh", $A4, " You look", $F1
    db "uh", $A4, " delicious.", $F7
    db $F0

Message_04_29:: ; heuristic: string; C0
Data_02C_5486:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Any way you want", $F1
    db "to look at this,", $FA, $F7
    db $EF, $EE, "I look stronger", $EF, $EE, "than you.", $F7
    db $F0

Message_04_2A:: ; heuristic: string; C0
Data_02C_54CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is just a", $F1
    db "rumor, but the new", $FA, $F7
    db $EF, $EE, "monster king likes", $EF, $EE, "precious items.", $FA, $F7
    db $EF, $EE, "Especially those", $EF, $EE, "imbued with magic.", $F7
    db $F0

Message_04_2B:: ; heuristic: string; C0
Data_02C_553F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The tunnel in", $F1
    db "the west will take", $FA, $F7
    db $EF, $EE, "you to the castle", $EF, $EE, "of Hitano.", $FA, $F7
    db $EF, $EE, "Perhaps because of", $EF, $EE, "the new monster", $FA, $F7
    db $EF, $EE, "king, treasure", $EF, $EE, "hunters of all", $FA, $F7
    db $EF, $EE, "stripes are said", $EF, $EE, "to be there.", $F7
    db $F0

Message_04_2C:: ; heuristic: string; C0
Data_02C_55F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Are you looking", $F1
    db "for something?", $FA, $F7
    db $EF, $EE, "Huh? The LightOrb?", $EF, $EE, "What is that?", $FA, $F7
    db $EF, $EE, "Well, if it glows,", $EF, $EE, "I have a suspect.", $FA, $F7
    db $EF, $EE, "It's a MadCondor", $EF, $EE, "that nests atop a", $FA, $F7
    db $EF, $EE, "mountain in the", $EF, $EE, "west.", $F7
    db $F0

Message_04_2D:: ; heuristic: string; C0
Data_02C_56A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good day. How", $F1
    db "may I help you?", $F7
    db $F0

Message_04_2E:: ; heuristic: string; C0
Data_02C_56C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How may we serve", $F1
    db "your mortal souls?", $F7
    db $F0

Message_04_2F:: ; heuristic: string; C0
Data_02C_56EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "Water reflected", $EF, $EE, "the cloudless sky.", $F7
    db $F0

Message_04_30:: ; heuristic: string; C0
Data_02C_572E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, $A4, "It appeared to be", $EF, $EE, "merchandise", $A4, $F7
    db $F0

Message_04_31:: ; heuristic: string; C0
Data_02C_576C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But the chest was", $EF, $EE, "locked.", $F7
    db $F0

Message_04_32:: ; heuristic: string; C0
Data_02C_57A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "traveler's inn.", $F7
    db $F0

Message_04_33:: ; heuristic: string; C0
Data_02C_57C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Kweeeeeh!", $F1
    db $F7
    db $F0

Message_04_34:: ; heuristic: string; C0
Data_02C_57D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When I passed", $F1
    db "too close to the", $FA, $F7
    db $EF, $EE, "mountain, I ended", $EF, $EE, "up in a nest!", $F7
    db $F0

Message_04_35:: ; heuristic: string; C0
Data_02C_581F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $A4, " I didn't take", $F1
    db "anything!", $FA, $F7
    db $EF, $EE, "There was nothing", $EF, $EE, "here already!", $FA, $F7
    db $EF, $EE, "Somebody's beaten", $EF, $EE, "us to it!", $F7
    db $F0

Message_04_36:: ; heuristic: string; C0
Data_02C_5880:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Where has the", $EF, $EE, "LightOrb gone", $A4, $F7
    db $F0

Message_04_37:: ; heuristic: string; C0
Data_02C_58D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "Castle of Hitano.", $FA, $F7
    db $EF, $EE, "It bustles with", $EF, $EE, "treasure hunters.", $F7
    db $F0

Message_04_38:: ; heuristic: string; C0
Data_02C_5920:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A monster king", $F1
    db "has appeared to", $FA, $F7
    db $EF, $EE, "take over the", $EF, $EE, "world, but all it", $FA, $F7
    db $EF, $EE, "seems to want is", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "Things haven't", $EF, $EE, "changed much.", $F7
    db $F0

Message_04_39:: ; heuristic: string; C0
Data_02C_59A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e lived here", $F1
    db "for 200 years now.", $FA, $F7
    db $EF, $EE, "Care to hear about", $EF, $EE, "the past?", $FF, $F0

Message_04_3A:: ; heuristic: string; C0
Data_02C_59EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This area had", $F1
    db "been prosperous,", $FA, $F7
    db $EF, $EE, "but a long war", $EF, $EE, "laid it to waste.", $FA, $F7
    db $EF, $EE, "The treasures that", $EF, $EE, "you find harken", $FA, $F7
    db $EF, $EE, "back to the olden", $EF, $EE, "days.", $FA, $F7
    db $EF, $EE, "If the Great Sage", $EF, $EE, "didn't quell the", $FA, $F7
    db $EF, $EE, "war with the", $EF, $EE, "LightOrb, perhaps", $FA, $F7
    db $EF, $EE, "even this Castle", $EF, $EE, "may not exist", $A4, $F7
    db $F0

Message_04_3B:: ; heuristic: string; C0
Data_02C_5AE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh", $A4, " You won't", $F1
    db "humor an old man", $A4, $F7
    db $F0

Message_04_3C:: ; heuristic: string; C0
Data_02C_5B09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Castle is", $F1
    db "under the monster", $FA, $F7
    db $EF, $EE, "King's rule now.", $EF, $EE, "You can earn a", $FA, $F7
    db $EF, $EE, "promotion by", $EF, $EE, "finding treasures.", $F7
    db $F0

Message_04_3D:: ; heuristic: string; C0
Data_02C_5B74:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did you see the", $F1
    db "monster King's", $FA, $F7
    db $EF, $EE, "proclamation?", $EF, $EE, "If you find three", $FA, $F7
    db $EF, $EE, "treasures, you get", $EF, $EE, "the LightOrb!", $F7
    db $F0

Message_04_3E:: ; heuristic: string; C0
Data_02C_5BDF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The cave to the", $F1
    db "south", $A4, $FA, $F7
    db $EF, $EE, "That has treasure", $EF, $EE, "in it for sure.", $FA, $F7
    db $EF, $EE, "But the entrance", $EF, $EE, "is too small.", $FA, $F7
    db $EF, $EE, "There's no way I", $EF, $EE, "can squeeze in.", $F7
    db $F0

Message_04_3F:: ; heuristic: string; C0
Data_02C_5C67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The new monster", $F1
    db "King is said to", $FA, $F7
    db $EF, $EE, "like his treasures", $EF, $EE, "a lot.", $FA, $F7
    db $EF, $EE, "If I take him some", $EF, $EE, "precious items,", $FA, $F7
    db $EF, $EE, "will he let me", $EF, $EE, "join his army?", $F7
    db $F0

Message_04_40:: ; heuristic: string; C0
Data_02C_5CF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hardly no one", $F1
    db "has seen the new", $FA, $F7
    db $EF, $EE, "Monster King. He", $EF, $EE, "must be cautious", $FA, $F7
    db $EF, $EE, "not to leave his", $EF, $EE, "castle very much.", $F7
    db $F0

Message_04_41:: ; heuristic: string; C0
Data_02C_5D62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is only for", $F1
    db "army personnel!", $FA, $F7
    db $EF, $EE, "Stay out, you", $EF, $EE, "civilians!", $F7
    db $F0

Message_04_42:: ; heuristic: string; C0
Data_02C_5DA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King has", $F1
    db "posted a notice.", $FA, $F7
    db $EF, $EE, "Read the sign over", $EF, $EE, "there.", $F7
    db $F0

Message_04_43:: ; heuristic: string; C0
Data_02C_5DE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you wish to", $F1
    db "join our army,", $FA, $F7
    db $EF, $EE, "then you should", $EF, $EE, "bring items that", $FA, $F7
    db $EF, $EE, "would please our", $EF, $EE, "new Majesty.", $F7
    db $F0

Message_04_44:: ; heuristic: string; C0
Data_02C_5E4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Give away the", $F1
    db "LightOrb?", $FA, $F7
    db $EF, $EE, "But that's what", $EF, $EE, "gives the monster", $FA, $F7
    db $EF, $EE, "King his power,", $EF, $EE, "the LightOrb does.", $FA, $F7
    db $EF, $EE, "Our King thinks in", $EF, $EE, "mysterious ways.", $F7
    db $F0

Message_04_45:: ; heuristic: string; C0
Data_02C_5EDD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you have the", $F1
    db "LightOrb, you can", $FA, $F7
    db $EF, $EE, "become our King", $EF, $EE, "with its power.", $FA, $F7
    db $EF, $EE, "What should I do", $EF, $EE, "if I were king", $A4, $FA, $F7
    db $EF, $EE, "As a starter, I'll", $EF, $EE, "eat Sirloin every", $FA, $F7
    db $EF, $EE, "day-three square", $EF, $EE, "meals a day!", $FA, $F7
    db $EF, $EE, "But I", $42, "e been", $EF, $EE, "gaining weight", $A4, $FA, $F7
    db $EF, $EE, "I'm afraid I won't", $EF, $EE, "be able to fly", $A4, $F7
    db $F0

Message_04_46:: ; heuristic: string; C0
Data_02C_5FDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If I had the", $F1
    db "LightOrb, even I", $FA, $F7
    db $EF, $EE, "could become the", $EF, $EE, "king of monsters.", $FA, $F7
    db $EF, $EE, "Could you please", $EF, $EE, "tell me where I", $FA, $F7
    db $EF, $EE, "could find some", $EF, $EE, "treasures?", $F7
    db $F0

Message_04_47:: ; heuristic: string; C0
Data_02C_6069:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Want to know the", $F1
    db "most fundamental", $FA, $F7
    db $EF, $EE, "point to treasure", $EF, $EE, "hunting?", $FF, $F0

Message_04_48:: ; heuristic: string; C0
Data_02C_60AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Walk. Learn to", $F1
    db "walk everywhere.", $FA, $F7
    db $EF, $EE, "Be careful to look", $EF, $EE, "everywhere.", $FA, $F7
    db $EF, $EE, "If you can fly,", $EF, $EE, "use that ability.", $F7
    db $F0

Message_04_49:: ; heuristic: string; C0
Data_02C_611B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I see. You wish", $F1
    db "to chart your own", $FA, $F7
    db $EF, $EE, "destiny, do you?", $EF, $EE, "That is admirable.", $F7
    db $F0

Message_04_4A:: ; heuristic: string; C0
Data_02C_6169:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hear me out if", $F1
    db "you wish to fly.", $FA, $F7
    db $EF, $EE, "Stand at the edge", $EF, $EE, "of the world, and", $FA, $F7
    db $EF, $EE, "ride upon the wind", $EF, $EE, "to cross the sky.", $F7
    db $F0

Message_04_4B:: ; heuristic: string; C0
Data_02C_61DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome! How may", $F1
    db "I serve you?", $F7
    db $F0

Message_04_4C:: ; heuristic: string; C0
Data_02C_6200:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How may our", $F1
    db "church help you?", $F7
    db $F0

Message_04_4D:: ; heuristic: string; C0
Data_02C_6221:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "The finder of", $EF, $EE, "three treasures", $FA, $F7
    db $EF, $EE, "shall earn a", $EF, $EE, "handsome reward.", $FA, $F7
    db $EF, $EE, "They are the", $EF, $EE, "Heaven Sword,", $FA, $F7
    db $EF, $EE, "Heaven Armor and", $EF, $EE, "Heaven Helmet.", $95, $F7
    db $F0

Message_04_4E:: ; heuristic: string; C0
Data_02C_62BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "The Heaven Sword,", $EF, $EE, "Heaven Armor and", $FA, $F7
    db $EF, $EE, "the Heaven Helmet.", $EF, $EE, "Gather these, and", $FA, $F7
    db $EF, $EE, "the LightOrb shall", $EF, $EE, "be your reward.", $FA, $F7
    db $EF, $EE, "I will await word", $EF, $EE, "in the Castle.", $FA, $F7
    db $EF, $EE, "-The King", $95, $EF, $EE, $F7
    db $F0

Message_04_4F:: ; heuristic: string; C0
Data_02C_637D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "Bizarre bugs were", $EF, $EE, "on skewers.", $F7
    db $F0

Message_04_50:: ; heuristic: string; C0
Data_02C_63B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "A face grinned up", $EF, $EE, "from the darkness.", $FA, $F7
    db $EF, $EE, "The vase actually", $EF, $EE, "was an EvilPot.", $F7
    db $F0

Message_04_51:: ; heuristic: string; C0
Data_02C_641E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to our", $F1
    db "inn.", $F7
    db $F0

Message_04_52:: ; heuristic: string; C0
Data_02C_6436:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Change Staff", $F1
    db "will open paths.", $FA, $F7
    db $EF, $EE, "I am counting on", $EF, $EE, "you to find the", $FA, $F7
    db $EF, $EE, "LightOrb.", $EF, $EE, "Don't fail me!", $F7
    db $F0

Message_04_53:: ; heuristic: string; C0
Data_02C_649D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, kiddo!", $F1
    db "You're new here.", $FA, $F7
    db $EF, $EE, "Don't cause any", $EF, $EE, "trouble in here!", $F7
    db $F0

Message_04_56:: ; heuristic: string; C0
Data_02C_64E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, kiddo! You", $F1
    db "treasure hunting?", $FA, $F7
    db $EF, $EE, "The place is just", $EF, $EE, "crawling with", $FA, $F7
    db $EF, $EE, "treasure hunters", $EF, $EE, "and the like!", $F7
    db $F0

Message_04_57:: ; heuristic: string; C0
Data_02C_654E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " On the island to", $F1
    db "the west, there is", $FA, $F7
    db $EF, $EE, "the Wind Tower.", $EF, $EE, "But I can't fly,", $FA, $F7
    db $EF, $EE, "so I can't get over", $EF, $EE, "there.", $F7
    db $F0

Message_04_58:: ; heuristic: string; C0
Data_02C_65B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " To the east is a", $F1
    db "suspension bridge.", $FA, $F7
    db $EF, $EE, "Beyond it is a", $EF, $EE, "haunted castle.", $FA, $F7
    db $EF, $EE, "There, the undead", $EF, $EE, "guard a treasure.", $FA, $F7
    db $EF, $EE, "However, if you", $EF, $EE, "can't break the", $FA, $F7
    db $EF, $EE, "traps that they", $EF, $EE, "have in place, you", $FA, $F7
    db $EF, $EE, "could end up", $EF, $EE, "joining them.", $F7
    db $F0

Message_04_59:: ; heuristic: string; C0
Data_02C_6694:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Those inside the", $F1
    db "haunted castle", $FA, $F7
    db $EF, $EE, "speak only amongst", $EF, $EE, "themselves.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "solve the traps", $FA, $F7
    db $EF, $EE, "yourself-there is", $EF, $EE, "no one to help.", $F7
    db $F0

Message_04_5A:: ; heuristic: string; C0
Data_02C_6723:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "small hole.", $FA, $F7
    db $EF, $EE, "It looked large", $EF, $EE, "enough to enter.", $F7
    db $F0

Message_04_5B:: ; heuristic: string; C0
Data_02C_6764:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "small hole.", $FA, $F7
    db $EF, $EE, "It's too small to", $EF, $EE, "fit some heads", $A4, $F7
    db $F0

Message_04_5C:: ; heuristic: string; C0
Data_02C_67A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "small hole.", $FA, $F7
    db $EF, $EE, "It's too small to", $EF, $EE, "fit some heads", $A4, $F7
    db $F0

Message_04_5D:: ; heuristic: string; C0
Data_02C_67E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can take", $F1
    db "this treasure,", $FA, $F7
    db $EF, $EE, "but only if you", $EF, $EE, "can beat me!", $FA, $F7
    db $EF, $EE, "No need to hold", $EF, $EE, "back just because", $FA, $F7
    db $EF, $EE, "I happen to be", $EF, $EE, "smaller than you!", $F7
    db $F0

Message_04_5E:: ; heuristic: string; C0
Data_02C_6872:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm up for your", $F1
    db "challenge anytime!", $F7
    db $F0

Message_04_5F:: ; heuristic: string; C0
Data_02C_6898:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, you're not", $F1
    db "half bad!", $FA, $F7
    db $EF, $EE, "As promised, here's", $EF, $EE, "your treasure!", $F7
    db $F0

Message_04_60:: ; heuristic: string; C0
Data_02C_68DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let the power of", $F1
    db "justice smite the", $FA, $F7
    db $EF, $EE, "greedy seekers of", $EF, $EE, "treasure", $A4, $F7
    db $F0

Message_04_61:: ; heuristic: string; C0
Data_02C_6922:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Step once on", $F1
    db "each of the two", $FA, $F7
    db $EF, $EE, "floor tiles on the", $EF, $EE, "right.", $F7
    db $F0

Message_04_62:: ; heuristic: string; C0
Data_02C_6961:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "notice.", $FA, $F7
    db $EF, $EE, $95, "Lay the souls to", $EF, $EE, "eternal rest.", $95, $F7
    db $F0

Message_04_63:: ; heuristic: string; C0
Data_02C_699E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "notice.", $FA, $F7
    db $EF, $EE, $95, "Follow the eyes", $EF, $EE, "of the undead.", $FA, $F7
    db $EF, $EE, "The key lies at", $EF, $EE, "the end.", $95, $F7
    db $F0

Message_04_64:: ; heuristic: string; C0
Data_02C_69F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "gravestone.", $FA, $F7
    db $EF, $EE, "There was a round", $EF, $EE, "button. Press it?", $FF, $F0

Message_04_65:: ; heuristic: string; C0
Data_02C_6A3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A door opened", $F1
    db "somewhere", $A4, $F7
    db $F0

Message_04_66:: ; heuristic: string; C0
Data_02C_6A56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You overcame the", $F1
    db "traps I laid", $A4, $FA, $F7
    db $EF, $EE, "I'm impressed by", $EF, $EE, "your courage, and", $FA, $F7
    db $EF, $EE, "moreso because of", $EF, $EE, "your age.", $FA, $F7
    db $EF, $EE, "But if you want", $EF, $EE, "the treasure,", $FA, $F7
    db $EF, $EE, "you'll have to", $EF, $EE, "defeat me first!", $F7
    db $F0

Message_04_67:: ; heuristic: string; C0
Data_02C_6B04:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wahahahah! Here", $F1
    db "again, are you?", $FA, $F7
    db $EF, $EE, "I commend you on", $EF, $EE, "your courage!", $FA, $F7
    db $EF, $EE, "But if you want", $EF, $EE, "the treasure,", $FA, $F7
    db $EF, $EE, "you'll have to", $EF, $EE, "defeat me first!", $F7
    db $F0

Message_04_68:: ; heuristic: string; C0
Data_02C_6B90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e beaten me", $F1
    db "fairly", $A4, $FA, $F7
    db $EF, $EE, "Take the treasure", $A4, $EF, $EE, "Farewell", $A4, $F7
    db $F0

Message_04_69:: ; heuristic: string; C0
Data_02C_6BCD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? You have", $F1
    db "the three items?", $FA, $F7
    db $EF, $EE, $A4, "It's true", $A4, $EF, $EE, "They're here.", $FA, $F7
    db $EF, $EE, "Fine, go in!", $EF, $EE, $F7
    db $F0

Message_04_6A:: ; heuristic: string; C0
Data_02C_6C1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King's castle", $F1
    db "is reached by the", $FA, $F7
    db $EF, $EE, "traveler's gate", $EF, $EE, "here.", $F7
    db $F0

Message_04_6B:: ; heuristic: string; C0
Data_02C_6C5F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? You have", $F1
    db "the three items?", $FA, $F7
    db $EF, $EE, "I'm busy! Don't", $EF, $EE, "waste my time!", $F7
    db $F0

Message_04_6C:: ; heuristic: string; C0
Data_02C_6CA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who would", $42, "e", $F1
    db "thought anyone", $FA, $F7
    db $EF, $EE, "would collect all", $EF, $EE, "three treasures", $A4, $F7
    db $F0

Message_04_6D:: ; heuristic: string; C0
Data_02C_6CEA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The monster", $F1
    db "army's general is", $FA, $F7
    db $EF, $EE, "beyond here.", $EF, $EE, "You had better", $FA, $F7
    db $EF, $EE, "be on your best", $EF, $EE, "behavior.", $F7
    db $F0

Message_04_6E:: ; heuristic: string; C0
Data_02C_6D49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our King's castle", $F1
    db "is an invincible", $FA, $F7
    db $EF, $EE, "fortress that is", $EF, $EE, "guarded by the", $FA, $F7
    db $EF, $EE, "elite in the", $EF, $EE, "monster army.", $F7
    db $F0

Message_04_6F:: ; heuristic: string; C0
Data_02C_6DB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? You", $42, "e got", $F1
    db "the three items?", $FA, $F7
    db $EF, $EE, "That means you get", $EF, $EE, "the LightOrb", $A4, $FA, $F7
    db $EF, $EE, "That means you'll", $EF, $EE, "be our next King!", $FA, $F7
    db $EF, $EE, "Well, when you do", $EF, $EE, "become King, I do", $FA, $F7
    db $EF, $EE, "hope you will", $EF, $EE, "remember me.", $F7
    db $F0

Message_04_70:: ; heuristic: string; C0
Data_02C_6E6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? How did you", $F1
    db "get in here?", $F7
    db $F0

Message_04_71:: ; heuristic: string; C0
Data_02C_6E8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm surprised", $F1
    db "anyone managed to", $FA, $F7
    db $EF, $EE, "find all three", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "Anyway, the King", $EF, $EE, "has left orders", $FA, $F7
    db $EF, $EE, "that you should", $EF, $EE, "bring your trove", $FA, $F7
    db $EF, $EE, "to the meeting", $EF, $EE, "chamber.", $FA, $F7
    db $EF, $EE, "To reach the King's", $EF, $EE, "castle, take the", $FA, $F7
    db $EF, $EE, "traveler's gate at", $EF, $EE, "the back.", $F7
    db $F0

Message_04_72:: ; heuristic: string; C0
Data_02C_6F7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you can't even", $F1
    db "reach the Castle's", $FA, $F7
    db $EF, $EE, "meeting chamber, I", $EF, $EE, "would think that", $FA, $F7
    db $EF, $EE, "you don't have the", $EF, $EE, "right to get the", $FA, $F7
    db $EF, $EE, "LightOrb from the", $EF, $EE, "current King.", $F7
    db $F0

Message_04_73:: ; heuristic: string; C0
Data_02C_7014:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You! I", $42, "e never", $F1
    db "seen you before!", $FA, $F7
    db $EF, $EE, "You're not one of", $EF, $EE, "our army!", $F7
    db $F0

Message_04_74:: ; heuristic: string; C0
Data_02C_7057:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? Are you a", $F1
    db "new recruit?", $FA, $F7
    db $EF, $EE, "What unit do you", $EF, $EE, "belong to?", $FA, $F7
    db $EF, $EE, "Why aren't you", $EF, $EE, "answering me?", $FA, $F7
    db $EF, $EE, "Are you a spy?", $EF, $EE, "That must be it!", $F7
    db $F0

Message_04_75:: ; heuristic: string; C0
Data_02C_70DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, you're the", $F1
    db "cooking crew.", $FA, $F7
    db $EF, $EE, "Do a good job with", $EF, $EE, "our meals.", $F7
    db $F0

Message_04_76:: ; heuristic: string; C0
Data_02C_711C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Awaargh, I'm", $F1
    db "late, I'm late!", $FA, $F7
    db $EF, $EE, "They overwork us", $EF, $EE, "terribly here.", $F7
    db $F0

Message_04_77:: ; heuristic: string; C0
Data_02C_715F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " They keep piling", $F1
    db "on these ludicrous", $FA, $F7
    db $EF, $EE, "orders. If I ever", $EF, $EE, "become important,", $FA, $F7
    db $EF, $EE, "they", $44, " better watch", $EF, $EE, "out!", $F7
    db $F0

Message_04_78:: ; heuristic: string; C0
Data_02C_71CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Gaah! You found", $F1
    db "me while I was", $FA, $F7
    db $EF, $EE, "sluffing off from", $EF, $EE, "work", $A4, $F7
    db $F0

Message_04_79:: ; heuristic: string; C0
Data_02C_720A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, so good of", $F1
    db "you to come!", $FA, $F7
    db $EF, $EE, "Well? Where are", $EF, $EE, "the three items?", $FA, $F7
    db $EF, $EE, "What? You didn't", $EF, $EE, "bring them?", $FA, $F7
    db $EF, $EE, "Why did you bother", $EF, $EE, "coming here?", $FA, $F7
    db $EF, $EE, "Find the three", $EF, $EE, "treasures and", $FA, $F7
    db $EF, $EE, "bring them to me.", $EF, $EE, "I will wait here", $FA, $F7
    db $EF, $EE, "for as long as it", $EF, $EE, "takes.", $F7
    db $F0

Message_04_7A:: ; heuristic: string; C0
Data_02C_72F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, so good of", $F1
    db "you to come!", $FA, $F7
    db $EF, $EE, "Well? Where are", $EF, $EE, "the three items?", $F7
    db $F0

Message_04_7B:: ; heuristic: string; C0
Data_02C_733D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Heaven Helmet.", $F7
    db $F0

Message_04_7C:: ; heuristic: string; C0
Data_02C_7360:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Heaven Armor.", $F7
    db $F0

Message_04_7D:: ; heuristic: string; C0
Data_02C_7382:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Heaven Sword.", $F7
    db $F0

Message_04_7E:: ; heuristic: string; C0
Data_02C_73A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good. You have", $F1
    db "brought the three", $FA, $F7
    db $EF, $EE, "treasures that I", $EF, $EE, "asked for.", $FA, $F7
    db $EF, $EE, "Well done.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, $A4, "And now, the", $EF, $EE, "final test.", $FA, $F7
    db $EF, $EE, "Show me that you", $EF, $EE, "are worthy of", $FA, $F7
    db $EF, $EE, "receiving the", $EF, $EE, "LightOrb!", $F7
    db $F0

Message_04_7F:: ; heuristic: string; C0
Data_02C_7457:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fwahahaha! Don't", $F1
    db "you ever give up?", $FA, $F7
    db $EF, $EE, "Fine! If you want", $EF, $EE, "the LightOrb, you", $FA, $F7
    db $EF, $EE, "will have to take", $EF, $EE, "it by force!", $F7
    db $F0

Message_04_80:: ; heuristic: string; C0
Data_02C_74C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Gwaah! You", $42, "e", $F1
    db "beaten me fairly!", $FA, $F7
    db $EF, $EE, "But I am merely a", $EF, $EE, "gate keeper.", $FA, $F7
    db $EF, $EE, "I'm under the", $EF, $EE, "LightOrb's spell,", $FA, $F7
    db $EF, $EE, "like everyone", $EF, $EE, "else.", $FA, $F7
    db $EF, $EE, "The real King is", $EF, $EE, "in a room beyond", $FA, $F7
    db $EF, $EE, "this one. If you", $EF, $EE, "want the LightOrb,", $FA, $F7
    db $EF, $EE, "you'll have to", $EF, $EE, "keep going.", $F7
    db $F0

Message_04_81:: ; heuristic: string; C0
Data_02C_75B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " So it was", $F1
    db "you who got the", $FA, $F7
    db $EF, $EE, "three treasures,", $EF, $EE, $F9, "0", $A4, $FA, $F7
    db $EF, $EE, "Surprised? I'm the", $EF, $EE, "Monster King!", $FA, $F7
    db $EF, $EE, "While looking for", $EF, $EE, "a plug for the", $FA, $F7
    db $EF, $EE, "Log's Navel, a", $EF, $EE, "huge bird caught", $FA, $F7
    db $EF, $EE, "me, and hauled me", $EF, $EE, "up to its nest.", $FA, $F7
    db $EF, $EE, "There, I found the", $EF, $EE, "LightOrb.", $FA, $F7
    db $EF, $EE, "The Orb didn't work", $EF, $EE, "as the plug.", $FA, $F7
    db $EF, $EE, "So, I used the", $EF, $EE, "LightOrb's power", $FA, $F7
    db $EF, $EE, "to become the King", $EF, $EE, "of the monsters.", $FA, $F7
    db $EF, $EE, "And then I ordered", $EF, $EE, "my subordinates to", $FA, $F7
    db $EF, $EE, "look for treasures", $EF, $EE, "that might work.", $F7
    db $F0

Message_04_82:: ; heuristic: string; C0
Data_02C_7765:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " If the", $F1
    db "three items that", $FA, $F7
    db $EF, $EE, "you brought are no", $EF, $EE, "good as plugs,", $FA, $F7
    db $EF, $EE, "there can't be", $EF, $EE, "anything else", $FA, $F7
    db $EF, $EE, "useable in this", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "They must be", $EF, $EE, "worried about me", $FA, $F7
    db $EF, $EE, "back home. I", $44, $EF, $EE, "better go home.", $F7
    db $F0

Message_04_83:: ; heuristic: string; C0
Data_02C_782C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wha-wha", $F1
    db "whaaaat?", $FA, $F7
    db $EF, $EE, "What just happened", $EF, $EE, "now?", $F7
    db $F0

Message_04_84:: ; heuristic: string; C0
Data_02C_7863:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Who are", $F1
    db "you to disturb me?", $F7
    db $F0

Message_04_85:: ; heuristic: string; C0
Data_02C_7888:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Greetings! I am", $F1
    db "Darck, the King of", $FA, $F7
    db $EF, $EE, "Limbo, a world", $EF, $EE, "between worlds.", $FA, $F7
    db $EF, $EE, "Darck", $A3, " I travel to", $EF, $EE, "many worlds as I", $FA, $F7
    db $EF, $EE, "seek treasures for", $EF, $EE, "my collection.", $FA, $F7
    db $EF, $EE, "I'm here to collect", $EF, $EE, "your treasure.", $F7
    db $F0

Message_04_86:: ; heuristic: string; C0
Data_02C_7946:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What? Why", $F1
    db "do you do that?", $F7
    db $F0

Message_04_87:: ; heuristic: string; C0
Data_02C_796A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " Well, for", $F1
    db "me, anything that", $FA, $F7
    db $EF, $EE, "evokes envy or", $EF, $EE, "jealousy in others", $FA, $F7
    db $EF, $EE, "is an invaluable", $EF, $EE, "treasure.", $FA, $F7
    db $EF, $EE, "For those emotions", $EF, $EE, "give me strength.", $FA, $F7
    db $EF, $EE, "I am the true", $EF, $EE, "Monster King.", $FA, $F7
    db $EF, $EE, "While I was away,", $EF, $EE, "I understand my", $FA, $F7
    db $EF, $EE, "subordinates were", $EF, $EE, "abused by you?", $FA, $F7
    db $EF, $EE, "Tch, the fools.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "One could never", $EF, $EE, "get good help", $A4, $FA, $F7
    db $EF, $EE, "Anyway, enough of", $EF, $EE, "this idle chatter.", $FA, $F7
    db $EF, $EE, "In my collection,", $EF, $EE, "I have something", $FA, $F7
    db $EF, $EE, "that will plug the", $EF, $EE, "Log's Navel.", $FA, $F7
    db $EF, $EE, "You need it to", $EF, $EE, "save GreatLog.", $FA, $F7
    db $EF, $EE, "I'm willing to", $EF, $EE, "exchange it for", $FA, $F7
    db $EF, $EE, "the treasures that", $EF, $EE, "you", $42, "e collected.", $FA, $F7
    db $EF, $EE, "I would consider", $EF, $EE, "that an equitable", $FA, $F7
    db $EF, $EE, "arrangement.", $EF, $EE, "Wouldn't you agree?", $FF, $F0

Message_04_88:: ; heuristic: string; C0
Data_02C_7BCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " I imagine", $F1
    db "that you don't have", $FA, $F7
    db $EF, $EE, "much time left, do", $EF, $EE, "you?", $FA, $F7
    db $EF, $EE, "I don't think my", $EF, $EE, "offer is unfair.", $FA, $F7
    db $EF, $EE, "Wouldn't you agree?", $EF, $EE, $FF, $F0

Message_04_8B:: ; heuristic: string; C0
Data_02C_7C4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " Good!", $F1
    db "We have a deal!", $FA, $F7
    db $EF, $EE, "Fine, fine!", $EF, $EE, "Fwahahahaha!", $FA, $F7
    db $EF, $EE, "I will take this", $EF, $EE, "LightOrb and the", $FA, $F7
    db $EF, $EE, "treasures here", $EF, $EE, "first.", $FA, $F7
    db $EF, $EE, "In return, take", $EF, $EE, "this Magic Key.", $F7
    db $F0

Message_04_8C:: ; heuristic: string; C0
Data_02C_7CEA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " That key", $F1
    db "will bring you to", $FA, $F7
    db $EF, $EE, "my Castle.", $EF, $EE, "I will be waiting", $FA, $F7
    db $EF, $EE, "for you to bring", $EF, $EE, "me more treasures.", $F7
    db $F0

Message_04_8D:: ; heuristic: string; C0
Data_02C_7D57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Limbo Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Message_04_8E:: ; heuristic: string; C0
Data_02C_7D77:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " I will be", $F1
    db "readying a proper", $FA, $F7
    db $EF, $EE, "welcome for you", $EF, $EE, "when you come.", $F7
    db $F0

Message_04_8F:: ; heuristic: string; C0
Data_02C_7DBF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Our", $F1
    db "treasures!", $FA, $F7
    db $EF, $EE, "He took them all", $EF, $EE, "away from us!", $FA, $F7
    db $EF, $EE, $A4, "Anyway, are you", $EF, $EE, "sure about what", $FA, $F7
    db $EF, $EE, "you just did?", $EF, $EE, "That promise", $A4, $FA, $F7
    db $EF, $EE, "He even wants the", $EF, $EE, "treasures you got", $FA, $F7
    db $EF, $EE, "already as plugs", $EF, $EE, "for the Navel", $A4, $FA, $F7
    db $EF, $EE, "It has to be a", $EF, $EE, "trap!", $F7
    db $F0

Message_04_90:: ; heuristic: string; C0
Data_02C_7EA5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0
    ds $13D, $00
