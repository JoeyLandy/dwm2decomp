SECTION "Bank 29", ROMX[$4000], BANK[$29]
    db $29

; message bank $29: when wStringIndex < $8E, BeginStringDisplay with this bank's table Data_029_4032; otherwise far-calls Func_097_4026 (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank29, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank29, ShowMessageHL_ToBeginStringDisplay_Bank29)
; reads: wStringIndex
BeginStringDisplay_Bank29::
Func_029_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $8E
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank29_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank29
    call BeginStringDisplay
    ret

; message bank $29: when wStringIndex < $8E, CopyStringToBuffer with this bank's table Data_029_4032; otherwise far-calls Func_097_4035 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank29:: ; heuristic: follows a terminator; C0
Func_029_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $8E
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank29_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank29
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_29_4032::
MessageStrings_Bank29:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_029_4032:: ; address name
    dw StringList_29_4034 ; id 0

; E-0217 (derived: category list of StringCategories_29_4032; one pointer per wStringIndex)
; record: string
StringList_29_4034::
Data_029_4034:: ; address name
    dw Message_01_00 ; id 0
    dw Message_01_01 ; id 1
    dw Message_01_02 ; id 2
    dw Message_01_03 ; id 3
    dw Message_01_04 ; id 4
    dw Message_01_05 ; id 5
    dw Message_01_06 ; id 6
    dw Message_01_07 ; id 7
    dw Message_01_08 ; id 8
    dw Message_01_09 ; id 9
    dw Message_01_0A ; id 10
    dw Message_01_0B ; id 11
    dw Message_01_0C ; id 12
    dw Message_01_0D ; id 13
    dw Message_01_0E ; id 14
    dw Message_01_0F ; id 15
    dw Message_01_10 ; id 16
    dw Message_01_11 ; id 17
    dw Message_01_12 ; id 18
    dw Message_01_13 ; id 19
    dw Message_01_14 ; id 20
    dw Message_01_15 ; id 21
    dw Message_01_16 ; id 22
    dw Message_01_17 ; id 23
    dw Message_01_18 ; id 24
    dw Message_01_19 ; id 25
    dw Message_01_1A ; id 26
    dw Message_01_1B ; id 27
    dw Message_01_1C ; id 28
    dw Message_01_1D ; id 29
    dw Message_01_1E ; id 30
    dw Message_01_1F ; id 31
    dw Message_01_20 ; id 32
    dw Message_01_21 ; id 33
    dw Message_01_22 ; id 34
    dw Message_01_22 ; id 35
    dw Message_01_22 ; id 36
    dw Message_01_22 ; id 37
    dw Message_01_26 ; id 38
    dw Message_01_27 ; id 39
    dw Message_01_28 ; id 40
    dw Message_01_29 ; id 41
    dw Message_01_2A ; id 42
    dw Message_01_2B ; id 43
    dw Message_01_2C ; id 44
    dw Message_01_2D ; id 45
    dw Message_01_2E ; id 46
    dw Message_01_2E ; id 47
    dw Message_01_2E ; id 48
    dw Message_01_31 ; id 49
    dw Message_01_32 ; id 50
    dw Message_01_33 ; id 51
    dw Message_01_34 ; id 52
    dw Message_01_35 ; id 53
    dw Message_01_36 ; id 54
    dw Message_01_37 ; id 55
    dw Message_01_38 ; id 56
    dw Message_01_39 ; id 57
    dw Message_01_3A ; id 58
    dw Message_01_3B ; id 59
    dw Message_01_3C ; id 60
    dw Message_01_3D ; id 61
    dw Message_01_3E ; id 62
    dw Message_01_3F ; id 63
    dw Message_01_40 ; id 64
    dw Message_01_41 ; id 65
    dw Message_01_42 ; id 66
    dw Message_01_43 ; id 67
    dw Message_01_44 ; id 68
    dw Message_01_45 ; id 69
    dw Message_01_46 ; id 70
    dw Message_01_47 ; id 71
    dw Message_01_48 ; id 72
    dw Message_01_49 ; id 73
    dw Message_01_4A ; id 74
    dw Message_01_4B ; id 75
    dw Message_01_4C ; id 76
    dw Message_01_4D ; id 77
    dw Message_01_4E ; id 78
    dw Message_01_4F ; id 79
    dw Message_01_50 ; id 80
    dw Message_01_51 ; id 81
    dw Message_01_52 ; id 82
    dw Message_01_53 ; id 83
    dw Message_01_54 ; id 84
    dw Message_01_55 ; id 85
    dw Message_01_56 ; id 86
    dw Message_01_57 ; id 87
    dw Message_01_58 ; id 88
    dw Message_01_59 ; id 89
    dw Message_01_5A ; id 90
    dw Message_01_5B ; id 91
    dw Message_01_5C ; id 92
    dw Message_01_5D ; id 93
    dw Message_01_5E ; id 94
    dw Message_01_5F ; id 95
    dw Message_01_60 ; id 96
    dw Message_01_61 ; id 97
    dw Message_01_62 ; id 98
    dw Message_01_63 ; id 99
    dw Message_01_64 ; id 100
    dw Message_01_65 ; id 101
    dw Message_01_66 ; id 102
    dw Message_01_67 ; id 103
    dw Message_01_68 ; id 104
    dw Message_01_69 ; id 105
    dw Message_01_6A ; id 106
    dw Message_01_6B ; id 107
    dw Message_01_6C ; id 108
    dw Message_01_6D ; id 109
    dw Message_01_6E ; id 110
    dw Message_01_6F ; id 111
    dw Message_01_70 ; id 112
    dw Message_01_71 ; id 113
    dw Message_01_72 ; id 114
    dw Message_01_73 ; id 115
    dw Message_01_74 ; id 116
    dw Message_01_75 ; id 117
    dw Message_01_76 ; id 118
    dw Message_01_77 ; id 119
    dw Message_01_78 ; id 120
    dw Message_01_79 ; id 121
    dw Message_01_7A ; id 122
    dw Message_01_7B ; id 123
    dw Message_01_7C ; id 124
    dw Message_01_7D ; id 125
    dw Message_01_7E ; id 126
    dw Message_01_7F ; id 127
    dw Message_01_80 ; id 128
    dw Message_01_81 ; id 129
    dw Message_01_82 ; id 130
    dw Message_01_83 ; id 131
    dw Message_01_84 ; id 132
    dw Message_01_85 ; id 133
    dw Message_01_86 ; id 134
    dw Message_01_87 ; id 135
    dw Message_01_88 ; id 136
    dw Message_01_89 ; id 137
    dw Message_01_8A ; id 138
    dw Message_01_8B ; id 139
    dw Message_01_8C ; id 140
    dw Message_01_8D ; id 141

Message_01_00:: ; heuristic: string; C0
Data_029_4150:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Are you going", $F1
    db "out to play?", $FA, $F7
    db $EF, $EE, "Be careful you", $EF, $EE, "don't get hurt.", $F7
    db $F0

Message_01_01:: ; heuristic: string; C0
Data_029_4191:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received an", $F1
    db "Herb.", $F7
    db $F0

Message_01_02:: ; heuristic: string; C0
Data_029_41A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It's a beautiful", $F1
    db "day for laundry!", $FA, $F7
    db $EF, $EE, "You shouldn't be", $EF, $EE, "inside on a day", $FA, $F7
    db $EF, $EE, "like this!", $EF, $EE, $F7
    db $F0

Message_01_03:: ; heuristic: string; C0
Data_029_4200:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, while", $F1
    db "you're gone, I'll", $FA, $F7
    db $EF, $EE, "stay here and tend", $EF, $EE, "to the monsters.", $FA, $F7
    db $EF, $EE, "If you catch any,", $EF, $EE, "I'll care for them.", $F7
    db $F0

Message_01_04:: ; heuristic: string; C0
Data_029_4273:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother,", $F1
    db "while you're in", $FA, $F7
    db $EF, $EE, "another world,", $EF, $EE, "I'll stay here.", $FA, $F7
    db $EF, $EE, "I'll look after", $EF, $EE, "your monsters,", $FA, $F7
    db $EF, $EE, "so be sure to send", $EF, $EE, "them back to me.", $F7
    db $F0

Message_01_05:: ; heuristic: string; C0
Data_029_4303:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Why do you have", $F1
    db "a monster in tow?", $FA, $F7
    db $EF, $EE, "Are you going to", $EF, $EE, "become a master?", $FA, $F7
    db $EF, $EE, "If you are, or if", $EF, $EE, "you're going to", $FA, $F7
    db $EF, $EE, "inherit this farm,", $EF, $EE, "the key is to be", $FA, $F7
    db $EF, $EE, "friendly with", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "To break the ice,", $EF, $EE, "feed them meat.", $FA, $F7
    db $EF, $EE, "That will make", $EF, $EE, "them less wary.", $F7
    db $F0

Message_01_06:: ; heuristic: string; C0
Data_029_4401:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $EF, $EE, "PorkChop.", $F7
    db $F0

Message_01_07:: ; heuristic: string; C0
Data_029_441B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " To win the trust", $F1
    db "of monsters, feed", $FA, $F7
    db $EF, $EE, "them some meat", $EF, $EE, "right away.", $FA, $F7
    db $EF, $EE, "You can battle", $EF, $EE, "them after, and", $FA, $F7
    db $EF, $EE, "rid them of their", $EF, $EE, "wild nature.", $F7
    db $F0

Message_01_08:: ; heuristic: string; C0
Data_029_44A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It looks like", $F1
    db "you", $42, "e become", $FA, $F7
    db $EF, $EE, "friends with some", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "That's my ", $F9, "0!", $EF, $EE, "You're talented!", $F7
    db $F0

Message_01_09:: ; heuristic: string; C0
Data_029_4507:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your monsters", $F1
    db "are your friends", $FA, $F7
    db $EF, $EE, "who will serve you", $EF, $EE, "to the end.", $FA, $F7
    db $EF, $EE, "Be sure to raise", $EF, $EE, "them with love!", $F7
    db $F0

Message_01_0A:: ; heuristic: string; C0
Data_029_4572:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Off to another", $F1
    db "world!", $FA, $F7
    db $EF, $EE, "There are many", $EF, $EE, "items to be found", $FA, $F7
    db $EF, $EE, "just lying around", $EF, $EE, "in other worlds.", $FA, $F7
    db $EF, $EE, "They will help you", $EF, $EE, "on your trek!", $F7
    db $F0

Message_01_0B:: ; heuristic: string; C0
Data_029_45FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A tropical isle", $F1
    db "is too hot for me.", $FA, $F7
    db $EF, $EE, "I might melt and", $EF, $EE, "become a Babble!", $F7
    db $F0

Message_01_0C:: ; heuristic: string; C0
Data_029_464A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, that's cute!", $F1
    db "Hahahahaha!", $FA, $F7
    db $EF, $EE, "We have a new", $EF, $EE, "monster master!", $F7
    db $F0

Message_01_0D:: ; heuristic: string; C0
Data_029_468C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Hi, I'm", $F1
    db "helping Papa to", $FA, $F7
    db $EF, $EE, "take care of the", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You can drop off", $EF, $EE, "or pick up any of", $FA, $F7
    db $EF, $EE, "your monsters here", $EF, $EE, "with me.", $FA, $F7
    db $EF, $EE, "So, what can I do", $EF, $EE, "for you, sis?", $F7
    db $F0

Message_01_0E:: ; heuristic: string; C0
Data_029_4735:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Hi, ", $F9, "0!", $F1
    db "What's up today?", $F7
    db $F0

Message_01_0F:: ; heuristic: string; C0
Data_029_4755:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " I'm helping", $F1
    db "Papa take care of", $FA, $F7
    db $EF, $EE, "the monsters and", $EF, $EE, "the farm.", $FA, $F7
    db $EF, $EE, "You can drop off", $EF, $EE, "or pick up any of", $FA, $F7
    db $EF, $EE, "your monsters here", $EF, $EE, "with me.", $FA, $F7
    db $EF, $EE, "Do you need me for", $EF, $EE, "anything?", $F7
    db $F0

Message_01_10:: ; heuristic: string; C0
Data_029_4801:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hi!", $F1
    db "How are you?", $FA, $F7
    db $EF, $EE, "Do you need me for", $EF, $EE, "anything today?", $F7
    db $F0

Message_01_11:: ; heuristic: string; C0
Data_029_4841:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Want to know how", $F1
    db "the farm works?", $FF, $F0

Message_01_12:: ; heuristic: string; C0
Data_029_4866:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Including the", $F1
    db "monsters with you,", $FA, $F7
    db $EF, $EE, "the farm can hold", $EF, $EE, "up to ten.", $FA, $F7
    db $EF, $EE, "It's not much to", $EF, $EE, "start, but the", $FA, $F7
    db $EF, $EE, "farm will hold", $EF, $EE, "more as it grows.", $FA, $F7
    db $EF, $EE, "Monsters in the", $EF, $EE, "farm earn some", $FA, $F7
    db $EF, $EE, "EX points as you", $EF, $EE, "battle.", $FA, $F7
    db $EF, $EE, "But if you leave", $EF, $EE, "them in the farm,", $FA, $F7
    db $EF, $EE, "they will grow", $EF, $EE, "without learning", $FA, $F7
    db $EF, $EE, "skills, and they", $EF, $EE, "turn disobedient.", $FA, $F7
    db $EF, $EE, "So, you should", $EF, $EE, "take different", $FA, $F7
    db $EF, $EE, "monsters out to", $EF, $EE, "train them.", $F7
    db $F0

Message_01_13:: ; heuristic: string; C0
Data_029_49E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Aww", $A4, " You know", $F1
    db "already? Boring!", $F7
    db $F0

Message_01_14:: ; heuristic: string; C0
Data_029_4A0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I haven't seen", $F1
    db "Prince Kameha or", $FA, $F7
    db $EF, $EE, "Warubou today.", $EF, $EE, "I hope they're not", $FA, $F7
    db $EF, $EE, "cooking up new", $EF, $EE, "pranks.", $F7
    db $F0

Message_01_15:: ; heuristic: string; C0
Data_029_4A6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am a dealer-", $F1
    db "a merchant who", $FA, $F7
    db $EF, $EE, "buys and sells", $EF, $EE, "useful items.", $FA, $F7
    db $EF, $EE, "Now, come back", $EF, $EE, "with a grownup.", $F7
    db $F0

Message_01_16:: ; heuristic: string; C0
Data_029_4AD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You have such", $F1
    db "cute monsters!", $FA, $F7
    db $EF, $EE, "Are you playing", $EF, $EE, "monster master?", $F7
    db $F0

Message_01_17:: ; heuristic: string; C0
Data_029_4B19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I haven't seen", $F1
    db "Prince Kameha or", $FA, $F7
    db $EF, $EE, "Warubou at all.", $EF, $EE, "Perhaps we won't", $FA, $F7
    db $EF, $EE, "need to post", $EF, $EE, "lookouts anymore.", $F7
    db $F0

Message_01_18:: ; heuristic: string; C0
Data_029_4B83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Warubou has gone", $F1
    db "down the well and", $FA, $F7
    db $EF, $EE, "hasn't come back", $EF, $EE, "out yet.", $FA, $F7
    db $EF, $EE, "It's plotting, I", $EF, $EE, "bet.", $F7
    db $F0

Message_01_19:: ; heuristic: string; C0
Data_029_4BE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Monster masters", $F1
    db "are people who can", $FA, $F7
    db $EF, $EE, "open their hearts", $EF, $EE, "to monsters.", $FA, $F7
    db $EF, $EE, "If you're trying to", $EF, $EE, "become a master,", $FA, $F7
    db $EF, $EE, "treat monsters", $EF, $EE, "with love.", $F7
    db $F0

Message_01_1A:: ; heuristic: string; C0
Data_029_4C70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Even the most", $F1
    db "ordinary of days", $FA, $F7
    db $EF, $EE, "brings small", $EF, $EE, "changes.", $FA, $F7
    db $EF, $EE, "So long as there", $EF, $EE, "is somewhere you", $FA, $F7
    db $EF, $EE, "can relax, life", $EF, $EE, "isn't all that bad.", $F7
    db $F0

Message_01_1B:: ; heuristic: string; C0
Data_029_4CFA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? Are you a", $F1
    db "master hopeful?", $FA, $F7
    db $EF, $EE, "Well, aren't you a", $EF, $EE, "cute rival!", $F7
    db $F0

Message_01_1C:: ; heuristic: string; C0
Data_029_4D3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, hi! Good to", $F1
    db "see you again!", $FA, $F7
    db $EF, $EE, "This is the Vault.", $EF, $EE, "You can keep your", $FA, $F7
    db $EF, $EE, "money and items", $EF, $EE, "safely here.", $FA, $F7
    db $EF, $EE, "You can take them", $EF, $EE, "out anytime too.", $FA, $F7
    db $EF, $EE, "It's free, so feel", $EF, $EE, "free to use us!", $FA, $F7
    db $EF, $EE, "So, how may I", $EF, $EE, "serve you today?", $F7
    db $F0

Message_01_1D:: ; heuristic: string; C0
Data_029_4E1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How may the", $F1
    db "Vault serve you?", $F7
    db $F0

Message_01_1E:: ; heuristic: string; C0
Data_029_4E3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If your party is", $F1
    db "wiped out, half", $FA, $F7
    db $EF, $EE, "your money's gone,", $EF, $EE, "just like that.", $FA, $F7
    db $EF, $EE, "But any money in", $EF, $EE, "the Vault is safe.", $FA, $F7
    db $EF, $EE, "Better saved than", $EF, $EE, "sorry, just like", $FA, $F7
    db $EF, $EE, "your Journal.", $EF, $EE, "Travel smart!", $F7
    db $F0

Message_01_1F:: ; heuristic: string; C0
Data_029_4EF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "You remember the", $EF, $EE, "promise you made?", $FF, $F0

Message_01_20:: ; heuristic: string; C0
Data_029_4F32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Quit", $F1
    db "dawdling, warooh!", $F7
    db $F0

Message_01_21:: ; heuristic: string; C0
Data_029_4F54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Use a", $F1
    db "Magic Key and open", $FA, $F7
    db $EF, $EE, "the Magic Door in", $EF, $EE, "chamber ahead!", $FA, $F7
    db $EF, $EE, "Go to another", $EF, $EE, "world and find", $FA, $F7
    db $EF, $EE, "a plug for the", $EF, $EE, "Log's Navel!", $FA, $F7
    db $EF, $EE, "Use GreatLog Key", $EF, $EE, "to come back.", $FA, $F7
    db $EF, $EE, "That is all!", $EF, $EE, "Hurry, wa-hey!", $F7
    db $F0

Message_01_22:: ; heuristic: string; C0
Data_029_5020:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "You did it, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "I'll give you", $EF, $EE, "GreatLog's power!", $F7
    db $F0

Message_01_26:: ; heuristic: string; C0
Data_029_5065:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There,", $F1
    db "your party's fine!", $FA, $F7
    db $EF, $EE, "So, the new plug", $EF, $EE, "for the Navel?", $F7
    db $F0

Message_01_27:: ; heuristic: string; C0
Data_029_50AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "So, this is it?", $FA, $F7
    db $EF, $EE, "This is the", $EF, $EE, "TidalBell, warooh?", $FA, $F7
    db $EF, $EE, "It exudes an odd", $EF, $EE, "power, yes.", $FA, $F7
    db $EF, $EE, "We'll see if it", $EF, $EE, "works, warooh!", $F7
    db $F0

Message_01_28:: ; heuristic: string; C0
Data_029_5136:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "That's it!", $FA, $F7
    db $EF, $EE, "GreatLog is saved!", $EF, $EE, "Good, now", $A4, " Warooh?", $F7
    db $F0

Message_01_29:: ; heuristic: string; C0
Data_029_517D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "No good, no good!", $FA, $F7
    db $EF, $EE, "I have to plug the", $EF, $EE, "Navel again!", $F7
    db $F0

Message_01_2A:: ; heuristic: string; C0
Data_029_51C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That was no good.", $FA, $F7
    db $EF, $EE, "But TidalBell has", $EF, $EE, "magic in it.", $FA, $F7
    db $EF, $EE, "Give me your hand.", $EF, $EE, "I hold it, and", $A4, $FA, $F7
    db $EF, $EE, "Wa-hey!", $EF, $EE, $F7
    db $F0

Message_01_2B:: ; heuristic: string; C0
Data_029_5242:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Stop that!", $FA, $F7
    db $EF, $EE, "Why do you look so", $EF, $EE, "nasty at me?", $FA, $F7
    db $EF, $EE, "A hero should have", $EF, $EE, "the valor to clean", $FA, $F7
    db $EF, $EE, "up after someone", $EF, $EE, "else's mess!", $FA, $F7
    db $EF, $EE, "Come on, give me a", $EF, $EE, "big smile, warooh!", $F7
    db $F0

Message_01_2C:: ; heuristic: string; C0
Data_029_52F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Listen.", $F1
    db "I feel a strange", $FA, $F7
    db $EF, $EE, "power in another", $EF, $EE, "world, warooh.", $FA, $F7
    db $EF, $EE, "It has to be a", $EF, $EE, "plug, I know it!", $FA, $F7
    db $EF, $EE, "But I", $42, "e no power", $EF, $EE, "to make a key", $A4, $FA, $F7
    db $EF, $EE, "That power is from", $EF, $EE, "GreatLog's tree.", $FA, $F7
    db $EF, $EE, "It is energy made", $EF, $EE, "by the bond tying", $FA, $F7
    db $EF, $EE, "people and their", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Help people bond", $EF, $EE, "with monsters, and", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "will be boosted.", $F7
    db $F0

Message_01_2D:: ; heuristic: string; C0
Data_029_5444:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Angry still with", $EF, $EE, "me, warooh?", $FA, $F7
    db $EF, $EE, "Anger is no good", $EF, $EE, "between friends!", $FA, $F7
    db $EF, $EE, "We're friends, so", $EF, $EE, "no anger, ", $F9, "0!", $FF, $F0

Message_01_2E:: ; heuristic: string; C0
Data_029_54C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is Kalka,", $F1
    db "an oasis village.", $F7
    db $F0

Message_01_31:: ; heuristic: string; C0
Data_029_54EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A thieving band", $F1
    db "runs amok here.", $FA, $F7
    db $EF, $EE, "It's impossible to", $EF, $EE, "get any decent", $FA, $F7
    db $EF, $EE, "sleep because of", $EF, $EE, "their threat.", $F7
    db $F0

Message_01_32:: ; heuristic: string; C0
Data_029_5556:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Pardon? A plug", $F1
    db "for a navel?", $FA, $F7
    db $EF, $EE, "Sorry, I have no", $EF, $EE, "idea what that is.", $F7
    db $F0

Message_01_33:: ; heuristic: string; C0
Data_029_559E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The oasis", $95, " water", $F1
    db "travels through an", $FA, $F7
    db $EF, $EE, "underground canal", $EF, $EE, "to Asiya.", $FA, $F7
    db $EF, $EE, "Asiya? It's a town", $EF, $EE, "that's due south.", $F7
    db $F0

Message_01_34:: ; heuristic: string; C0
Data_029_560D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The leader of", $F1
    db "the thieves is a", $FA, $F7
    db $EF, $EE, "fearsome man.", $EF, $EE, "He commands horrid", $FA, $F7
    db $EF, $EE, "monsters to rob", $EF, $EE, "people.", $F7
    db $F0

Message_01_35:: ; heuristic: string; C0
Data_029_5671:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The Log's Navel?", $F1
    db "What is that?", $FA, $F7
    db $EF, $EE, "I can show you my", $EF, $EE, "navel on the sly.", $F7
    db $F0

Message_01_36:: ; heuristic: string; C0
Data_029_56BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Log's Navel?", $F1
    db "Let me think", $A4, $FA, $F7
    db $EF, $EE, "Perhaps the King", $EF, $EE, "in Asiya will", $F7
    db $EF, $EE, "know.", $EF, $EE, $F7
    db $F0

Message_01_37:: ; heuristic: string; C0
Data_029_570A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "A sharp, spicy", $EF, $EE, "aroma wafted out.", $F7
    db $F0

Message_01_38:: ; heuristic: string; C0
Data_029_5745:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The underground", $F1
    db "canal is ahead.", $FA, $F7
    db $EF, $EE, "The last King made", $EF, $EE, "it for our people", $FA, $F7
    db $EF, $EE, "when there were", $EF, $EE, "water shortages.", $FA, $F7
    db $EF, $EE, "It was a hard,", $EF, $EE, "hard task.", $F7
    db $F0

Message_01_39:: ; heuristic: string; C0
Data_029_57D5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The King called", $F1
    db "a circus troupe to", $FA, $F7
    db $EF, $EE, "the town in the", $EF, $EE, "south.", $FA, $F7
    db $EF, $EE, "I hope they weren't", $EF, $EE, "mauled by thugs.", $F7
    db $F0

Message_01_3A:: ; heuristic: string; C0
Data_029_583F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is Asiya,", $F1
    db "the desert flower.", $F7
    db $F0

Message_01_3B:: ; heuristic: string; C0
Data_029_5865:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our King came", $F1
    db "into an enormous", $FA, $F7
    db $EF, $EE, "inheritance. It", $EF, $EE, "was mind-boggling.", $FA, $F7
    db $EF, $EE, "His treasury is", $EF, $EE, "overflowing with", $FA, $F7
    db $EF, $EE, "incredible gold", $EF, $EE, "and treasures.", $FA, $F7
    db $EF, $EE, "He's said to be", $EF, $EE, "particularly proud", $FA, $F7
    db $EF, $EE, "of something", $EF, $EE, "called TidalBell.", $F7
    db $F0

Message_01_3C:: ; heuristic: string; C0
Data_029_5940:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I saw a lake", $F1
    db "like a mirage.", $FA, $F7
    db $EF, $EE, "In the east of the", $EF, $EE, "desert, it was.", $FA, $F7
    db $EF, $EE, "But it disappeared", $EF, $EE, "as if by magic", $A4, $F7
    db $F0

Message_01_3D:: ; heuristic: string; C0
Data_029_59AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Strong monsters", $F1
    db "are in the well.", $FA, $F7
    db $EF, $EE, "You", $44, " better be", $EF, $EE, "prepared if you", $FA, $F7
    db $EF, $EE, "are going down in", $EF, $EE, "there.", $F7
    db $F0

Message_01_3E:: ; heuristic: string; C0
Data_029_5A13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our King has", $F1
    db "been a fan of", $FA, $F7
    db $EF, $EE, "circuses since he", $EF, $EE, "was a child.", $FA, $F7
    db $EF, $EE, "If there is a", $EF, $EE, "circus, he always", $FA, $F7
    db $EF, $EE, "summons the troupe", $EF, $EE, "to the castle.", $F7
    db $F0

Message_01_3F:: ; heuristic: string; C0
Data_029_5A9F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The circus", $F1
    db "master was trying", $FA, $F7
    db $EF, $EE, "to recruit people", $EF, $EE, "at the inn.", $FA, $F7
    db $EF, $EE, "He says the troupe", $EF, $EE, "scattered when the", $FA, $F7
    db $EF, $EE, "thieves set on", $EF, $EE, "them.", $FA, $F7
    db $EF, $EE, "Traveling is much", $EF, $EE, "too risky for me!", $F7
    db $F0

Message_01_40:: ; heuristic: string; C0
Data_029_5B4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No one enters", $F1
    db "the castle without", $FA, $F7
    db $EF, $EE, "a proper permit!", $EF, $EE, "Move along!", $F7
    db $F0

Message_01_41:: ; heuristic: string; C0
Data_029_5B93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you want to", $F1
    db "get in that badly,", $FA, $F7
    db $EF, $EE, "we could arrest", $EF, $EE, "you and toss you", $FA, $F7
    db $EF, $EE, "in the dungeon,", $EF, $EE, "how's that sound?", $F7
    db $F0

Message_01_42:: ; heuristic: string; C0
Data_029_5C03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Did you want", $F1
    db "something, honey?", $FA, $F7
    db $EF, $EE, "A plug for the", $EF, $EE, "Log's Navel?", $FA, $F7
    db $EF, $EE, "Well, the King", $EF, $EE, "likes collecting", $FA, $F7
    db $EF, $EE, "all sorts of odd", $EF, $EE, "things, so he may", $FA, $F7
    db $EF, $EE, "have something", $EF, $EE, "that will work.", $F7
    db $F0

Message_01_43:: ; heuristic: string; C0
Data_029_5CB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When we get a", $F1
    db "hot spell, I sleep", $FA, $F7
    db $EF, $EE, "in the daytime,", $EF, $EE, "and work at night.", $FA, $F7
    db $EF, $EE, "That's the only", $EF, $EE, "way of coping!", $F7
    db $F0

Message_01_44:: ; heuristic: string; C0
Data_029_5D21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to my", $F1
    db "item shop!", $FA, $F7
    db $EF, $EE, "You may buy or", $EF, $EE, "sell items here.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

Message_01_45:: ; heuristic: string; C0
Data_029_5D81:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! How may I", $F1
    db "serve you today?", $F7
    db $F0

Message_01_46:: ; heuristic: string; C0
Data_029_5DA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The church", $F1
    db "welcomes you.", $FA, $F7
    db $EF, $EE, "We can heal you", $EF, $EE, "from poisoning,", $FA, $F7
    db $EF, $EE, "lift curses, and", $EF, $EE, "revive the dead.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you, my child?", $F7
    db $F0

Message_01_47:: ; heuristic: string; C0
Data_029_5E31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am a servant", $F1
    db "to the gods.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you, my child?", $F7
    db $F0

Message_01_48:: ; heuristic: string; C0
Data_029_5E74:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am the leader", $F1
    db "of a circus.", $FA, $F7
    db $EF, $EE, "We were invited to", $EF, $EE, "perform before the", $FA, $F7
    db $EF, $EE, "King, but my group", $EF, $EE, "has scattered like", $FA, $F7
    db $EF, $EE, "so many leaves in", $EF, $EE, "a storm.", $FA, $F7
    db $EF, $EE, "So, I am the only", $EF, $EE, "one in my circus.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "join me as a star?", $FF, $F0

Message_01_49:: ; heuristic: string; C0
Data_029_5F59:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did you say yes?", $F1
    db "Yes, yes, you did!", $FA, $F7
    db $EF, $EE, "Your monsters will", $EF, $EE, "make a fine act!", $FA, $F7
    db $EF, $EE, "You can have top", $EF, $EE, "billing as our one", $FA, $F7
    db $EF, $EE, "and only fearless", $EF, $EE, "monster master!", $FA, $F7
    db $EF, $EE, "Come, we must go", $EF, $EE, "to the castle!", $F7
    db $F0

Message_01_4A:: ; heuristic: string; C0
Data_029_601B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did you say yes?", $F1
    db "Yes, yes, you did!", $FA, $F7
    db $EF, $EE, "Your monsters will", $EF, $EE, "make a fine act!", $FA, $F7
    db $EF, $EE, "You can have top", $EF, $EE, "billing as our one", $FA, $F7
    db $EF, $EE, "and only fearless", $EF, $EE, "monster master!", $FA, $F7
    db $EF, $EE, "But a dead monster", $EF, $EE, "is no good.", $FA, $F7
    db $EF, $EE, "It wouldn't look", $EF, $EE, "good as an act.", $FA, $F7
    db $EF, $EE, "You must get three", $EF, $EE, "healthy monsters.", $F7
    db $F0

Message_01_4B:: ; heuristic: string; C0
Data_029_6129:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Did you say yes?", $F1
    db "Yes, yes, you did!", $FA, $F7
    db $EF, $EE, "Your monsters will", $EF, $EE, "make a fine act!", $FA, $F7
    db $EF, $EE, "You can have top", $EF, $EE, "billing as our one", $FA, $F7
    db $EF, $EE, "and only fearless", $EF, $EE, "monster master!", $FA, $F7
    db $EF, $EE, "But you need a", $EF, $EE, "trio of monsters", $FA, $F7
    db $EF, $EE, "to make the act", $EF, $EE, "work.", $FA, $F7
    db $EF, $EE, "You must get three", $EF, $EE, "healthy monsters.", $F7
    db $F0

Message_01_4C:: ; heuristic: string; C0
Data_029_622E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You close the", $F1
    db "door to stardom?", $FA, $F7
    db $EF, $EE, "That is most", $EF, $EE, "unfortunate.", $FA, $F7
    db $EF, $EE, "If you change your", $EF, $EE, "mind, I'll be here.", $F7
    db $F0

Message_01_4D:: ; heuristic: string; C0
Data_029_6299:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, three", $F1
    db "healthy monsters!", $FA, $F7
    db $EF, $EE, "Very well done!", $EF, $EE, "Bravo to you!", $FA, $F7
    db $EF, $EE, "You are officially", $EF, $EE, "a circus member!", $FA, $F7
    db $EF, $EE, "Come, we must go", $EF, $EE, "to the castle!", $F7
    db $F0

Message_01_4E:: ; heuristic: string; C0
Data_029_6327:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, you need a", $F1
    db "trio of monsters", $FA, $F7
    db $EF, $EE, "to make the act", $EF, $EE, "work.", $FA, $F7
    db $EF, $EE, "You must get three", $EF, $EE, "healthy monsters.", $F7
    db $F0

Message_01_4F:: ; heuristic: string; C0
Data_029_638E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "a gooey oil.", $F7
    db $F0

Message_01_50:: ; heuristic: string; C0
Data_029_63CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I heard that the", $F1
    db "thieves disappear", $FA, $F7
    db $EF, $EE, "as soon as they", $EF, $EE, "get their loot.", $FA, $F7
    db $EF, $EE, "No one's seen", $EF, $EE, "their hideout.", $F7
    db $F0

Message_01_51:: ; heuristic: string; C0
Data_029_6437:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " And that was the", $F1
    db "firebreather!", $FA, $F7
    db $EF, $EE, "Let's hear it for", $EF, $EE, "this brave soul!", $F7
    db $F0

Message_01_52:: ; heuristic: string; C0
Data_029_6480:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Next, monsters", $EF, $EE, "will perform some", $FA, $F7
    db $EF, $EE, "amazing, death", $EF, $EE, "defying stunts!", $F7
    db $F0

Message_01_53:: ; heuristic: string; C0
Data_029_64C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Very good show!", $F1
    db "That was splendid", $FA, $F7
    db $EF, $EE, "for your debut", $EF, $EE, "performance!", $FA, $F7
    db $EF, $EE, "The audience was", $EF, $EE, "quite pleased.", $FA, $F7
    db $EF, $EE, "We are to stay for", $EF, $EE, "more shows here,", $FA, $F7
    db $EF, $EE, "so we have been", $EF, $EE, "permitted to go", $FA, $F7
    db $EF, $EE, "into the castle by", $EF, $EE, "the King.", $F7
    db $F0

Message_01_54:: ; heuristic: string; C0
Data_029_65A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Several of our", $F1
    db "members came back.", $FA, $F7
    db $EF, $EE, "We have enough to", $EF, $EE, "put on our shows.", $F7
    db $F0

Message_01_55:: ; heuristic: string; C0
Data_029_65EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When the thieves", $F1
    db "raided us, we ran.", $FA, $F7
    db $EF, $EE, "But while we kept", $EF, $EE, "our lives, we were", $FA, $F7
    db $EF, $EE, "separated from our", $EF, $EE, "circus master.", $F7
    db $F0

Message_01_56:: ; heuristic: string; C0
Data_029_6665:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I wonder if the", $F1
    db "others are safe", $A4, $F7
    db $F0

Message_01_57:: ; heuristic: string; C0
Data_029_668A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, did you see", $F1
    db "the looks I got", $FA, $F7
    db $EF, $EE, "when I blew fire?", $EF, $EE, "Made me feel good!", $F7
    db $F0

Message_01_58:: ; heuristic: string; C0
Data_029_66D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "King's treasury!", $FA, $F7
    db $EF, $EE, "No one, but no one", $EF, $EE, "is allowed inside!", $F7
    db $F0

Message_01_59:: ; heuristic: string; C0
Data_029_6722:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? See his", $F1
    db "Majesty's treasure?", $FA, $F7
    db $EF, $EE, "What foolishness!", $EF, $EE, "No one gets by me", $FA, $F7
    db $EF, $EE, "without the King's", $EF, $EE, "permission!", $F7
    db $F0

Message_01_5A:: ; heuristic: string; C0
Data_029_6791:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " His Majesty is", $F1
    db "honest and most", $FA, $F7
    db $EF, $EE, "certainly not evil", $EF, $EE, "in any way.", $FA, $F7
    db $EF, $EE, "But, he is rather", $EF, $EE, "impetuous.", $FA, $F7
    db $EF, $EE, "I wish he wouldn't", $EF, $EE, "order us on whim", $A4, $F7
    db $F0

Message_01_5B:: ; heuristic: string; C0
Data_029_6820:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We frown upon", $F1
    db "strangers who", $FA, $F7
    db $EF, $EE, "wander through our", $EF, $EE, "castle!", $F7
    db $F0

Message_01_5C:: ; heuristic: string; C0
Data_029_685F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Why are you", $F1
    db "snooping around?", $FA, $F7
    db $EF, $EE, "Are you looking", $EF, $EE, "for something?", $FF, $F0

Message_01_5D:: ; heuristic: string; C0
Data_029_68A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A new plug for", $F1
    db "the Log's Navel?", $FA, $F7
    db $EF, $EE, "It has to have a", $EF, $EE, "magic power?", $FA, $F7
    db $EF, $EE, "Well, then there's", $EF, $EE, "only the King's", $FA, $F7
    db $EF, $EE, "TidalBell among", $EF, $EE, "his treasures.", $FA, $F7
    db $EF, $EE, "It can be used to", $EF, $EE, "cross the sea.", $F7
    db $F0

Message_01_5E:: ; heuristic: string; C0
Data_029_6955:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, it looked", $F1
    db "like you were on", $FA, $F7
    db $EF, $EE, "the prowl for", $EF, $EE, "something.", $F7
    db $F0

Message_01_5F:: ; heuristic: string; C0
Data_029_6995:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "There were neatly", $EF, $EE, "folded silk robes.", $F7
    db $F0

Message_01_60:: ; heuristic: string; C0
Data_029_69D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Ah, you're", $F1
    db "the monster tamer", $FA, $F7
    db $EF, $EE, "from the circus.", $EF, $EE, "Good show!", $FA, $F7
    db $EF, $EE, "So, do you wish", $EF, $EE, "something of me?", $FF, $F0

Message_01_61:: ; heuristic: string; C0
Data_029_6A40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I see. This", $F1
    db "is what we'll do.", $FA, $F7
    db $EF, $EE, "I'll help you, if", $EF, $EE, "you help me.", $FA, $F7
    db $EF, $EE, "I inherited the", $EF, $EE, "throne from my", $FA, $F7
    db $EF, $EE, "father, who was a", $EF, $EE, "great king.", $FA, $F7
    db $EF, $EE, "But my rule has", $EF, $EE, "been beset by one", $FA, $F7
    db $EF, $EE, "disaster after", $EF, $EE, "another.", $FA, $F7
    db $EF, $EE, "No one listens to", $EF, $EE, "my orders now", $A4, $FA, $F7
    db $EF, $EE, "Will you go find", $EF, $EE, "out what concerns", $FA, $F7
    db $EF, $EE, "my people may", $EF, $EE, "have?", $FA, $F7
    db $EF, $EE, "If I solved their", $EF, $EE, "problems, I should", $FA, $F7
    db $EF, $EE, "regain their trust", $EF, $EE, "and respect.", $FA, $F7
    db $EF, $EE, "Well? Will you do", $EF, $EE, "this for me?", $FF, $F0

Message_01_62:: ; heuristic: string; C0
Data_029_6BE2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Then make", $F1
    db "way to the town.", $FA, $F7
    db $EF, $EE, "If you succeed,", $EF, $EE, "you can have the", $FA, $F7
    db $EF, $EE, "TidalBell from my", $EF, $EE, "treasures.", $F7
    db $F0

Message_01_63:: ; heuristic: string; C0
Data_029_6C4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Oh", $A4, $F1
    db "You won't?", $FA, $F7
    db $EF, $EE, "Then, I can't help", $EF, $EE, "you either.", $F7
    db $F0

Message_01_64:: ; heuristic: string; C0
Data_029_6C83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Investigate", $F1
    db "what concerns my", $FA, $F7
    db $EF, $EE, "people may have.", $EF, $EE, "Hurry!", $F7
    db $F0

Message_01_65:: ; heuristic: string; C0
Data_029_6CC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " So? Have you", $F1
    db "decided to see", $FA, $F7
    db $EF, $EE, "what concerns my", $EF, $EE, "people have?", $FF, $F0

Message_01_66:: ; heuristic: string; C0
Data_029_6D0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That fool is a", $F1
    db "terrible swindler.", $FA, $F7
    db $EF, $EE, "I wouldn't lend an", $EF, $EE, "ear to him!", $F7
    db $F0

Message_01_67:: ; heuristic: string; C0
Data_029_6D52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Humph! A mirage", $F1
    db "lake, he says!", $FA, $F7
    db $EF, $EE, "No one's seen such", $EF, $EE, "a thing.", $FA, $F7
    db $EF, $EE, "Everything he says", $EF, $EE, "is a lie!", $F7
    db $F0

Message_01_68:: ; heuristic: string; C0
Data_029_6DB5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do I have any", $F1
    db "concerns?", $FA, $F7
    db $EF, $EE, "You'll tell the", $EF, $EE, "King for me?", $FA, $F7
    db $EF, $EE, "Then listen. The", $EF, $EE, "well's almost dry.", $FA, $F7
    db $EF, $EE, "Could the King do", $EF, $EE, "anything about it?", $F7
    db $F0

Message_01_69:: ; heuristic: string; C0
Data_029_6E41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We're worried", $F1
    db "about the well.", $FA, $F7
    db $EF, $EE, "The water level is", $EF, $EE, "dropping sharply.", $FA, $F7
    db $EF, $EE, "We don't have any", $EF, $EE, "confidence in the", $FA, $F7
    db $EF, $EE, "King, so we're not", $EF, $EE, "sure what to do.", $F7
    db $F0

Message_01_6A:: ; heuristic: string; C0
Data_029_6ED9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King has", $F1
    db "given permission", $FA, $F7
    db $EF, $EE, "for you to come", $EF, $EE, "and go freely.", $F7
    db $F0

Message_01_6B:: ; heuristic: string; C0
Data_029_6F1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King is so", $F1
    db "frivolous.", $FA, $F7
    db $EF, $EE, "A circus makes him", $EF, $EE, "happy? Please!", $F7
    db $F0

Message_01_6C:: ; heuristic: string; C0
Data_029_6F62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So, have you", $F1
    db "discovered what", $FA, $F7
    db $EF, $EE, "concerns my people", $EF, $EE, "may have?", $FA, $F7
    db $EF, $EE, "What? The well is", $EF, $EE, "running dry?", $FA, $F7
    db $EF, $EE, "I will order my", $EF, $EE, "men to raise the", $FA, $F7
    db $EF, $EE, "flow of water into", $EF, $EE, "the canal.", $FA, $F7
    db $EF, $EE, "Guards! Duke!", $EF, $EE, "Anyone?", $F7
    db $F0

Message_01_6D:: ; heuristic: string; C0
Data_029_7028:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The canal is", $F1
    db "managed by the", $FA, $F7
    db $EF, $EE, "village of Kalka,", $EF, $EE, "isn't that right?", $FA, $F7
    db $EF, $EE, "Send someone to", $EF, $EE, "Kalka and have the", $FA, $F7
    db $EF, $EE, "manager open the", $EF, $EE, "Canal Gate more!", $F7
    db $F0

Message_01_6E:: ; heuristic: string; C0
Data_029_70C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your Majesty, I", $F1
    db "must remind you", $A4, $FA, $F7
    db $EF, $EE, "If that was done,", $EF, $EE, "the oasis will", $FA, $F7
    db $EF, $EE, "become drained", $EF, $EE, "immediately.", $F7
    db $F0

Message_01_6F:: ; heuristic: string; C0
Data_029_712A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What?", $F1
    db "Never mind, then!", $FA, $F7
    db $EF, $EE, "I'll go to Kalka,", $EF, $EE, "and check myself!", $F7
    db $F0

Message_01_70:: ; heuristic: string; C0
Data_029_7171:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I feel badly for", $EF, $EE, "his Majesty, but", $FA, $F7
    db $EF, $EE, "he must think", $EF, $EE, "things through.", $FA, $F7
    db $EF, $EE, "Rash actions with", $EF, $EE, "no thought of the", $FA, $F7
    db $EF, $EE, "consequences won't", $EF, $EE, "do for a ruler.", $F7
    db $F0

Message_01_71:: ; heuristic: string; C0
Data_029_7208:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Open the", $F1
    db "Canal Gate more?", $FA, $F7
    db $EF, $EE, "The oasis will run", $EF, $EE, "dry if we did!", $FA, $F7
    db $EF, $EE, "That's an order I", $EF, $EE, "simply cannot", $FA, $F7
    db $EF, $EE, "accept, King or no", $EF, $EE, "King.", $F7
    db $F0

Message_01_72:: ; heuristic: string; C0
Data_029_7292:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Arrgh!", $F1
    db "I know that!", $FA, $F7
    db $EF, $EE, "I want to know why", $EF, $EE, "the water is gone!", $FA, $F7
    db $EF, $EE, "Fine, I'll go find", $EF, $EE, "out myself!", $F7
    db $F0

Message_01_73:: ; heuristic: string; C0
Data_029_72FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "My, our King", $F1
    db "has no patience", $A4, $F7
    db $F0

Message_01_74:: ; heuristic: string; C0
Data_029_731D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I discovered why", $F1
    db "the water is low.", $FA, $F7
    db $EF, $EE, "This beast's dam", $EF, $EE, "is at fault.", $FA, $F7
    db $EF, $EE, "I", $42, "e been trying to", $EF, $EE, "get it to destroy", $FA, $F7
    db $EF, $EE, "the dam, but to no", $EF, $EE, "avail.", $F7
    db $F0

Message_01_75:: ; heuristic: string; C0
Data_029_73AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm making a new", $F1
    db "home for my clan!", $FA, $F7
    db $EF, $EE, "Leave us be, or", $EF, $EE, "pay the price!", $F7
    db $F0

Message_01_76:: ; heuristic: string; C0
Data_029_73F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Gaah! You're too", $F1
    db "strong! You win!", $FA, $F7
    db $EF, $EE, "I didn't mean to", $EF, $EE, "cause any trouble.", $FA, $F7
    db $EF, $EE, "We used to live in", $EF, $EE, "Mirage Lake, but", $FA, $F7
    db $EF, $EE, "we were kicked out", $EF, $EE, "by a band of thugs", $FA, $F7
    db $EF, $EE, "who made it their", $EF, $EE, "hideout!", $FA, $F7
    db $EF, $EE, "I was looking for", $EF, $EE, "a place to live", $A4, $F7
    db $F0

Message_01_77:: ; heuristic: string; C0
Data_029_74D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What? So", $F1
    db "that's the truth?", $FA, $F7
    db $EF, $EE, "Those wretched", $EF, $EE, "scoundrels!", $FA, $F7
    db $EF, $EE, "I promise, I will", $EF, $EE, "imprison them!", $F7
    db $F0

Message_01_78:: ; heuristic: string; C0
Data_029_753F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You will?", $F1
    db "So we can go back", $FA, $F7
    db $EF, $EE, "to Mirage Lake and", $EF, $EE, "live peacefully?", $FA, $F7
    db $EF, $EE, "Please catch the", $EF, $EE, "thieves!", $F7
    db $F0

Message_01_79:: ; heuristic: string; C0
Data_029_75A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " This should", $F1
    db "solve the water", $FA, $F7
    db $EF, $EE, "shortage in the", $EF, $EE, "town.", $FA, $F7
    db $EF, $EE, "I humbly thank you", $EF, $EE, "for your help!", $FA, $F7
    db $EF, $EE, "Come see me in the", $EF, $EE, "Castle.", $FA, $F7
    db $EF, $EE, "I will have the", $EF, $EE, "TidalBell for you.", $F7
    db $F0

Message_01_7A:: ; heuristic: string; C0
Data_029_764F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? You say that", $F1
    db "a monster had been", $FA, $F7
    db $EF, $EE, "blocking the canal", $EF, $EE, "with a dam?", $F7
    db $F0

Message_01_7B:: ; heuristic: string; C0
Data_029_769A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The well has", $F1
    db "ample water again.", $FA, $F7
    db $EF, $EE, "Our King managed", $EF, $EE, "to do it!", $FA, $F7
    db $EF, $EE, "Maybe he isn't a", $EF, $EE, "total buffoon", $A4, $F7
    db $F0

Message_01_7C:: ; heuristic: string; C0
Data_029_7700:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We have heard", $F1
    db "from his Majesty.", $FA, $F7
    db $EF, $EE, "Please, do go", $EF, $EE, "right through.", $F7
    db $F0

Message_01_7D:: ; heuristic: string; C0
Data_029_7745:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hi! Did you hear", $F1
    db "the news?", $FA, $F7
    db $EF, $EE, "Our King is quite", $EF, $EE, "the brave man.", $FA, $F7
    db $EF, $EE, "With just one", $EF, $EE, "underling, he", $FA, $F7
    db $EF, $EE, "defeated monsters", $EF, $EE, "in the canal, and", $FA, $F7
    db $EF, $EE, "saved the town", $EF, $EE, "from a drought!", $F7
    db $F0

Message_01_7E:: ; heuristic: string; C0
Data_029_77F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King solved", $F1
    db "our water shortage", $FA, $F7
    db $EF, $EE, "all by himself,", $EF, $EE, "I", $42, "e heard.", $FA, $F7
    db $EF, $EE, "Perhaps we were", $EF, $EE, "wrong about him.", $F7
    db $F0

Message_01_7F:: ; heuristic: string; C0
Data_029_785F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our King worked", $F1
    db "to save all of us", $A4, $FA, $F7
    db $EF, $EE, "I'm ashamed", $A4, " What", $EF, $EE, "have I done?", $F7
    db $F0

Message_01_80:: ; heuristic: string; C0
Data_029_78A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King appears", $F1
    db "to have turned a", $FA, $F7
    db $EF, $EE, "new leaf as a", $EF, $EE, "great ruler.", $FA, $F7
    db $EF, $EE, "I can finally say", $EF, $EE, "I", $42, "e fulfilled my", $FA, $F7
    db $EF, $EE, "promise to his", $EF, $EE, "late father", $A4, $F7
    db $F0

Message_01_81:: ; heuristic: string; C0
Data_029_7934:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The town's", $F1
    db "water shortage", $FA, $F7
    db $EF, $EE, "seems to be no", $EF, $EE, "longer a concern.", $FA, $F7
    db $EF, $EE, "I thank you again", $EF, $EE, "for your work.", $FA, $F7
    db $EF, $EE, "Your reward is the", $EF, $EE, "TidalBell.", $FA, $F7
    db $EF, $EE, "Come, follow me to", $EF, $EE, "the treasury.", $F7
    db $F0

Message_01_82:: ; heuristic: string; C0
Data_029_79E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Wha-what?", $F1
    db "What happened?", $F7
    db $F0

Message_01_83:: ; heuristic: string; C0
Data_029_7A07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "We", $A4, " We were", $F1
    db "jumped by thieves", $A4, $FA, $F7
    db $EF, $EE, "They", $A4, " made off", $EF, $EE, "with the treasure", $A4, $F7
    db $F0

Message_01_84:: ; heuristic: string; C0
Data_029_7A51:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What?", $F1
    db "Arrrrgh!", $FA, $F7
    db $EF, $EE, "Round up all the", $EF, $EE, "men at once!", $FA, $F7
    db $EF, $EE, "Have them report", $EF, $EE, "to my chamber!", $F7
    db $F0

Message_01_85:: ; heuristic: string; C0
Data_029_7AAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The hideout", $F1
    db "of the thieves is", $FA, $F7
    db $EF, $EE, "said to be in", $EF, $EE, "Mirage Lake!", $FA, $F7
    db $EF, $EE, "They must be", $EF, $EE, "caught!", $FA, $F7
    db $EF, $EE, "I will lead the", $EF, $EE, "expedition myself!", $FA, $F7
    db $EF, $EE, "Who will join me", $EF, $EE, "in this quest?", $F7
    db $F0

Message_01_86:: ; heuristic: string; C0
Data_029_7B57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Good! Your", $F1
    db "valor be praised!", $FA, $F7
    db $EF, $EE, "We must capture", $EF, $EE, "the thieves, at", $FA, $F7
    db $EF, $EE, "all costs.", $EF, $EE, "This is a mission!", $F7
    db $F0

Message_01_87:: ; heuristic: string; C0
Data_029_7BC2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I apologize,", $F1
    db "but my treasures", $FA, $F7
    db $EF, $EE, "were taken by the", $EF, $EE, "thieves.", $FA, $F7
    db $EF, $EE, "I will head to", $EF, $EE, "Mirage Lake and", $FA, $F7
    db $EF, $EE, "bring them to", $EF, $EE, "justice.", $FA, $F7
    db $EF, $EE, "If we return", $EF, $EE, "safely, you shall", $FA, $F7
    db $EF, $EE, "have the promised", $EF, $EE, "TidalBell.", $F7
    db $F0

Message_01_88:: ; heuristic: string; C0
Data_029_7C89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wh-where is", $F1
    db "everybody?", $FA, $F7
    db $EF, $EE, "I haven't been fed", $EF, $EE, "at all", $A4, $FA, $F7
    db $EF, $EE, "Listen, I'll let", $EF, $EE, "you in on a secret", $FA, $F7
    db $EF, $EE, "if you have any", $EF, $EE, "food. Well?", $FF, $F0

Message_01_89:: ; heuristic: string; C0
Data_029_7D09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "some food.", $F7
    db $F0

Message_01_8A:: ; heuristic: string; C0
Data_029_7D24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Munch, munch", $A4, $F1
    db "Chew, gulp", $A4, $FA, $F7
    db $EF, $EE, "Fwoaar, that hits", $EF, $EE, "the spot! Thanks!", $FA, $F7
    db $EF, $EE, "Well, here's the", $EF, $EE, "secret I promised.", $FA, $F7
    db $EF, $EE, "Don't chase what", $EF, $EE, "runs from you.", $FA, $F7
    db $EF, $EE, "Lay some bait, and", $EF, $EE, "let it come.", $FA, $F7
    db $EF, $EE, "That's the trick.", $EF, $EE, "Here, take this.", $F7
    db $F0

Message_01_8B:: ; heuristic: string; C0
Data_029_7DFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "WaterCall.", $F7
    db $F0

Message_01_8C:: ; heuristic: string; C0
Data_029_7E18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 had no food", $F1
    db "to give", $A4, $F7
    db $F0

Message_01_8D:: ; heuristic: string; C0
Data_029_7E31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, what good", $F1
    db "are you?", $FA, $F7
    db $EF, $EE, "I'm starving here.", $EF, $EE, "Anything'll do.", $FA, $F7
    db $EF, $EE, "Even food for", $EF, $EE, "monsters is good!", $F7
    db $F0
    ds $16A, $00
