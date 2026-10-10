SECTION "Bank 7C", ROMX[$4000], BANK[$7C]
    db $7C

; 3 call sites from 3 routines (e.g. GameMode0_Update, Func_010_4AD0, Func_05F_69FB)
; reads: wStringIndex
Func_07C_4001::
    ld a, [wStringIndex]
    cp a, $87
    jr c, Jump_07C_400F
    farcall Func_099_404B
    ret

Jump_07C_400F::
    ld de, Data_07C_4032
    call BeginStringDisplay
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
Func_07C_4016:: ; heuristic: follows a terminator; C0
    ld a, [wStringIndex]
    cp a, $87
    jr c, Jump_07C_4024
    farcall Func_099_405A
    ret

Jump_07C_4024::
    ld de, Data_07C_4032
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_07C_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_07C_4034

Data_07C_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_07C_4142
    dw Data_07C_4186
    dw Data_07C_41C9
    dw Data_07C_427A
    dw Data_07C_42E3
    dw Data_07C_436D
    dw Data_07C_4424
    dw Data_07C_4464
    dw Data_07C_4483
    dw Data_07C_44C0
    dw Data_07C_44FE
    dw Data_07C_4542
    dw Data_07C_4586
    dw Data_07C_45DE
    dw Data_07C_46F6
    dw Data_07C_47C4
    dw Data_07C_4853
    dw Data_07C_4902
    dw Data_07C_4926
    dw Data_07C_4998
    dw Data_07C_49B2
    dw Data_07C_4A49
    dw Data_07C_4ABB
    dw Data_07C_4B68
    dw Data_07C_4B8A
    dw Data_07C_4BCA
    dw Data_07C_4BFF
    dw Data_07C_4DE4
    dw Data_07C_4E6D
    dw Data_07C_4EDB
    dw Data_07C_4F22
    dw Data_07C_4FBB
    dw Data_07C_509F
    dw Data_07C_50C1
    dw Data_07C_5168
    dw Data_07C_51FE
    dw Data_07C_5243
    dw Data_07C_52F3
    dw Data_07C_53B3
    dw Data_07C_5448
    dw Data_07C_54D6
    dw Data_07C_54D6
    dw Data_07C_5588
    dw Data_07C_5617
    dw Data_07C_56F3
    dw Data_07C_5711
    dw Data_07C_5735
    dw Data_07C_5778
    dw Data_07C_584D
    dw Data_07C_58DA
    dw Data_07C_593B
    dw Data_07C_597D
    dw Data_07C_5AB8
    dw Data_07C_5B4E
    dw Data_07C_5BE0
    dw Data_07C_5C48
    dw Data_07C_5C6A
    dw Data_07C_5CE5
    dw Data_07C_5D26
    dw Data_07C_5D44
    dw Data_07C_5DAB
    dw Data_07C_5FDC
    dw Data_07C_6155
    dw Data_07C_6177
    dw Data_07C_619C
    dw Data_07C_62FF
    dw Data_07C_6342
    dw Data_07C_6365
    dw Data_07C_63B0
    dw Data_07C_6420
    dw Data_07C_6444
    dw Data_07C_6519
    dw Data_07C_6565
    dw Data_07C_65B1
    dw Data_07C_66AD
    dw Data_07C_66D0
    dw Data_07C_6707
    dw Data_07C_672B
    dw Data_07C_6770
    dw Data_07C_6800
    dw Data_07C_68A9
    dw Data_07C_690E
    dw Data_07C_69A1
    dw Data_07C_69EA
    dw Data_07C_6AA4
    dw Data_07C_6B56
    dw Data_07C_6CE5
    dw Data_07C_6E11
    dw Data_07C_6EA6
    dw Data_07C_6F8D
    dw Data_07C_6FCF
    dw Data_07C_700E
    dw Data_07C_7053
    dw Data_07C_7090
    dw Data_07C_70AC
    dw Data_07C_7120
    dw Data_07C_718A
    dw Data_07C_71BE
    dw Data_07C_71FB
    dw Data_07C_723D
    dw Data_07C_7276
    dw Data_07C_72E8
    dw Data_07C_7327
    dw Data_07C_734C
    dw Data_07C_738C
    dw Data_07C_7434
    dw Data_07C_7496
    dw Data_07C_74BC
    dw Data_07C_7501
    dw Data_07C_7549
    dw Data_07C_7568
    dw Data_07C_7577
    dw Data_07C_76BE
    dw Data_07C_7707
    dw Data_07C_776D
    dw Data_07C_778B
    dw Data_07C_780E
    dw Data_07C_7879
    dw Data_07C_78D9
    dw Data_07C_7926
    dw Data_07C_796A
    dw Data_07C_7986
    dw Data_07C_79B9
    dw Data_07C_7A48
    dw Data_07C_7A91
    dw Data_07C_7AFB
    dw Data_07C_7B3D
    dw Data_07C_7BD2
    dw Data_07C_7C64
    dw Data_07C_7CDE
    dw Data_07C_7D25
    dw Data_07C_7D69
    dw Data_07C_7E01
    dw Data_07C_7E54
    dw Data_07C_7EAB

Data_07C_4142:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "village of Yold.", $FA, $F7
    db $EF, $EE, "We're known for", $EF, $EE, "our fresh fish.", $F7
    db $F0

Data_07C_4186:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the northwest", $F1
    db "is a village that", $FA, $F7
    db $EF, $EE, "is famous for", $EF, $EE, "mermaids.", $F7
    db $F0

Data_07C_41C9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Around these", $F1
    db "parts it's faster", $FA, $F7
    db $EF, $EE, "to travel by boat", $EF, $EE, "than walking,", $FA, $F7
    db $EF, $EE, "so everyone has", $EF, $EE, "their own boat.", $FA, $F7
    db $EF, $EE, "In the olden days", $EF, $EE, "it was dangerous", $FA, $F7
    db $EF, $EE, "because there were", $EF, $EE, "pirates.", $F7
    db $F0

Data_07C_427A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I saw a haunted", $F1
    db "ship in the north.", $FA, $F7
    db $EF, $EE, "It scared me so", $EF, $EE, "much, I can't get", $FA, $F7
    db $EF, $EE, "out of bed.", $EF, $EE, "Oooh, scary!", $F7
    db $F0

Data_07C_42E3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The volcanic", $F1
    db "island off the", $FA, $F7
    db $EF, $EE, "coast appears to", $EF, $EE, "be in a bad mood.", $FA, $F7
    db $EF, $EE, "There have been", $EF, $EE, "many quakes.", $FA, $F7
    db $EF, $EE, "The fish aren't", $EF, $EE, "biting at all.", $F7
    db $F0

Data_07C_436D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Mermaids lived", $F1
    db "in the sea in the", $FA, $F7
    db $EF, $EE, "northwest. Among", $EF, $EE, "their treasures", $FA, $F7
    db $EF, $EE, "was a round mirror", $EF, $EE, "called HarMirror,", $FA, $F7
    db $EF, $EE, "but it was stolen", $EF, $EE, "by pirates.", $FA, $F7
    db $EF, $EE, "Nobody knows where", $EF, $EE, "it is now.", $F7
    db $F0

Data_07C_4424:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "The birds are", $F1
    db "noisy", $A4, $FA, $F7
    db $EF, $EE, "It's a sign that a", $EF, $EE, "quake will hit.", $F7
    db $F0

Data_07C_4464:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "See? What did I", $F1
    db "just say?", $F7
    db $F0

Data_07C_4483:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hope the", $F1
    db "volcanic island", $FA, $F7
    db $EF, $EE, "off the coast", $EF, $EE, "won't erupt", $A4, $F7
    db $F0

Data_07C_44C0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't have", $F1
    db "much but", $A4, $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "see my wares?", $F7
    db $F0

Data_07C_44FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "A folded fishnet", $EF, $EE, "was tucked inside.", $F7
    db $F0

Data_07C_4542:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "colorful fruits.", $F7
    db $F0

Data_07C_4586:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to", $F1
    db "Polona.", $FA, $F7
    db $EF, $EE, "It's a tourist", $EF, $EE, "resort known for", $FA, $F7
    db $EF, $EE, "the mermaids in", $EF, $EE, "the area.", $F7
    db $F0

Data_07C_45DE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You could meet", $F1
    db "mermaids here in", $FA, $F7
    db $EF, $EE, "the past, but not", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "Not since the", $EF, $EE, "pirates raided", $FA, $F7
    db $EF, $EE, "them and took", $EF, $EE, "their treasure.", $FA, $F7
    db $EF, $EE, "After that, the", $EF, $EE, "mermaids have kept", $FA, $F7
    db $EF, $EE, "away from people", $EF, $EE, "out of fear.", $FA, $F7
    db $EF, $EE, "It's a shame.", $EF, $EE, "They were decent", $FA, $F7
    db $EF, $EE, "sorts who liked to", $EF, $EE, "dance and sing.", $F7
    db $F0

Data_07C_46F6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm from the port", $F1
    db "in the northeast.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " almost reached", $EF, $EE, "here when ArmyAnts", $FA, $F7
    db $EF, $EE, "and MadGophers", $EF, $EE, "jumped me.", $FA, $F7
    db $EF, $EE, "I managed to get", $EF, $EE, "away though.", $FA, $F7
    db $EF, $EE, "I'm glad I made it", $EF, $EE, "here safely.", $FA, $F7
    db $EF, $EE, "It's quiet and", $EF, $EE, "restful.", $F7
    db $F0

Data_07C_47C4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're not", $F1
    db "supposed to go", $FA, $F7
    db $EF, $EE, "near the cave in", $EF, $EE, "the west.", $FA, $F7
    db $EF, $EE, "It's on the cape.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water monsters", $EF, $EE, "live there.", $FA, $F7
    db $EF, $EE, "Mama said it's", $EF, $EE, "dangerous.", $F7
    db $F0

Data_07C_4853:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the past,", $F1
    db "mermaids are said", $FA, $F7
    db $EF, $EE, "to have sang and", $EF, $EE, "danced with people", $FA, $F7
    db $EF, $EE, "where we stand", $EF, $EE, "now.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "dance to remember", $FA, $F7
    db $EF, $EE, "and celebrate the", $EF, $EE, "days gone by?"
    db $FF, $F0

Data_07C_4902:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $31, $90, $12, $43, $2F, $90, $36, $2C, $31, $2A
    db $99, $F1, $15, $24, $2F, $24, $2F, $24, $9D, $90, $2F, $24, $2F, $24, $90, $2F
    db $24, $9D, $F7, $F0

Data_07C_4926:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "Please, take this", $EF, $EE, "as my thanks!", $F7
    db $F0

Data_07C_4998:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "a TinyMedal.", $F7
    db $F0

Data_07C_49B2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "Please, take this", $EF, $EE, "as my thanks!", $FA, $F7
    db $EF, $EE, "Oh? You have no", $EF, $EE, "room", $A4, " Next time!", $F7
    db $F0

Data_07C_4A49:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " love to see", $EF, $EE, "you dance again!", $F7
    db $F0

Data_07C_4ABB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Erm", $A4, " The sense", $F1
    db "of rhythm just", $FA, $F7
    db $EF, $EE, "doesn't quite come", $EF, $EE, "through.", $FA, $F7
    db $EF, $EE, "If there were a", $EF, $EE, "monster that could", $FA, $F7
    db $EF, $EE, "lead the dance", $EF, $EE, "performance", $A4, $FA, $F7
    db $EF, $EE, "Oh, pardon me!", $EF, $EE, "You are a novice", $A4, $F7
    db $F0

Data_07C_4B68:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah", $A4, " Shame", $A4, $F1
    db "Please come again.", $F7
    db $F0

Data_07C_4B8A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you heard", $F1
    db "the legend about", $FA, $F7
    db $EF, $EE, "the mermaids", $95, $EF, $EE, "treasure?"
    db $FF, $F0

Data_07C_4BCA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you", $42, "e heard", $F1
    db "already.", $FA, $F7
    db $EF, $EE, "It's a tragic tale.", $EF, $EE, $F7
    db $F0

Data_07C_4BFF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Long ago, a deft", $F1
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

Data_07C_4DE4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ahh", $A4, " This is", $F1
    db "heavenly!", $FA, $F7
    db $EF, $EE, "It makes me feel", $EF, $EE, "alive again!", $FA, $F7
    db $EF, $EE, "Relaxing here, all", $EF, $EE, "my troubles seem", $FA, $F7
    db $EF, $EE, "to melt away to", $EF, $EE, "insignificance.", $F7
    db $F0

Data_07C_4E6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I came from far", $F1
    db "away to see some", $FA, $F7
    db $EF, $EE, "mermaids, but I", $EF, $EE, "hear they", $42, "e not", $FA, $F7
    db $EF, $EE, "been seen lately.", $EF, $EE, "That's a shame.", $F7
    db $F0

Data_07C_4EDB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is Port", $F1
    db "Ritz, where ships", $FA, $F7
    db $EF, $EE, "gather from all", $EF, $EE, "over the world.", $F7
    db $F0

Data_07C_4F22:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The pirates were", $F1
    db "swallowed by the", $FA, $F7
    db $EF, $EE, "sea after monsters", $EF, $EE, "overwhelmed them.", $FA, $F7
    db $EF, $EE, "But before they", $EF, $EE, "sank, they're said", $FA, $F7
    db $EF, $EE, "to have hidden", $EF, $EE, "their treasures.", $F7
    db $F0

Data_07C_4FBB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's this old", $F1
    db "sailor man in the", $FA, $F7
    db $EF, $EE, "tavern who likes", $EF, $EE, "his grog too much.", $FA, $F7
    db $EF, $EE, "Whenever he's had", $EF, $EE, "a few, he'll regale", $FA, $F7
    db $EF, $EE, "you with tales of", $EF, $EE, "the high seas.", $FA, $F7
    db $EF, $EE, "But his stories", $EF, $EE, "tend to be a bit", $FA, $F7
    db $EF, $EE, "preposterous. I", $EF, $EE, "don't trust him.", $F7
    db $F0

Data_07C_509F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How may our", $F1
    db "church serve you?", $F7
    db $F0

Data_07C_50C1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " All sorts of", $F1
    db "people come here", $FA, $F7
    db $EF, $EE, "from around the", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "But a little kid", $EF, $EE, "with monsters", $A4, $FA, $F7
    db $EF, $EE, "That's something", $EF, $EE, "you don't get to", $FA, $F7
    db $EF, $EE, "see too often, not", $EF, $EE, "even here.", $F7
    db $F0

Data_07C_5168:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I went to Polona", $F1
    db "a while back", $A4, $FA, $F7
    db $EF, $EE, "You know, it's", $EF, $EE, "southwest of here.", $FA, $F7
    db $EF, $EE, "But I never got to", $EF, $EE, "see any mermaids.", $FA, $F7
    db $EF, $EE, "I was looking", $EF, $EE, "forward to it too", $A4, $F7
    db $F0

Data_07C_51FE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I offer quality", $F1
    db "merchandise.", $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "see my wares?", $F7
    db $F0

Data_07C_5243:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There is a", $F1
    db "lighthouse to the", $FA, $F7
    db $EF, $EE, "east, but it's too", $EF, $EE, "dangerous.", $FA, $F7
    db $EF, $EE, "It's been overrun", $EF, $EE, "by monsters since", $FA, $F7
    db $EF, $EE, "the pirates stole", $EF, $EE, "the MoonRock from", $FA, $F7
    db $EF, $EE, "the top of the", $EF, $EE, "lighthouse.", $F7
    db $F0

Data_07C_52F3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My ship sank in", $F1
    db "the eastern sea.", $FA, $F7
    db $EF, $EE, "We were sailing", $EF, $EE, "near a whirlpool", $FA, $F7
    db $EF, $EE, "when huge suction-", $EF, $EE, "cupped tentacles", $FA, $F7
    db $EF, $EE, "reached out and", $EF, $EE, "grabbed the ship.", $FA, $F7
    db $EF, $EE, "It's terrifying to", $EF, $EE, "even recall that!", $F7
    db $F0

Data_07C_53B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The old man in", $F1
    db "the tavern's neat!", $FA, $F7
    db $EF, $EE, "He tells me all", $EF, $EE, "sorts of things.", $FA, $F7
    db $EF, $EE, "I wish I would get", $EF, $EE, "kidnapped by some", $FA, $F7
    db $EF, $EE, "pirates one day.", $EF, $EE, "It"
    db $44, $90, $25, $28, $90, $31, $28, $24, $37, $99, $F7, $F0

Data_07C_5448:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This port used", $F1
    db "to be lively in", $FA, $F7
    db $EF, $EE, "the past, but it's", $EF, $EE, "become run down", $A4, $FA, $F7
    db $EF, $EE, "The pirates have", $EF, $EE, "all gone, but the", $FA, $F7
    db $EF, $EE, "port's still fading", $EF, $EE, "away", $A4, $F7
    db $F0

Data_07C_54D6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The lighthouse", $F1
    db "had the MoonRock", $FA, $F7
    db $EF, $EE, "installed at its", $EF, $EE, "pinnacle.", $FA, $F7
    db $EF, $EE, "It would glow at", $EF, $EE, "night to light the", $FA, $F7
    db $EF, $EE, "way for mariners", $EF, $EE, "at sea.", $FA, $F7
    db $EF, $EE, "It was a gift from", $EF, $EE, "mermaids, you see.", $F7
    db $F0

Data_07C_5588:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The sea's level", $F1
    db "has gone down.", $FA, $F7
    db $EF, $EE, "Many shoals have", $EF, $EE, "appeared.", $FA, $F7
    db $EF, $EE, "And that's resulted", $EF, $EE, "in countless ships", $FA, $F7
    db $EF, $EE, "running aground in", $EF, $EE, "these parts.", $F7
    db $F0

Data_07C_5617:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Listen, did you", $F1
    db "know?", $FA, $F7
    db $EF, $EE, "Mermaids appear to", $EF, $EE, "love dancing.", $FA, $F7
    db $EF, $EE, "By the way, there's", $EF, $EE, "a cave west of", $FA, $F7
    db $EF, $EE, "Polona. A giant", $EF, $EE, "squid lives there.", $FA, $F7
    db $EF, $EE, "That squid is said", $EF, $EE, "to love to dance.", $FA, $F7
    db $EF, $EE, "I don't know if I", $EF, $EE, "want to see that", $A4, $F7
    db $F0

Data_07C_56F3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "check the chest.", $F7
    db $F0

Data_07C_5711:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Whoa! Hands off", $F1
    db "my merchandise!", $F7
    db $F0

Data_07C_5735:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "gigantic beans.", $F7
    db $F0

Data_07C_5778:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This area was a", $F1
    db "lot more lively in", $FA, $F7
    db $EF, $EE, "the old days, but", $EF, $EE, "now it's just a", $FA, $F7
    db $EF, $EE, "deathtrap for any", $EF, $EE, "kind of boat.", $FA, $F7
    db $EF, $EE, "We're ringed by", $EF, $EE, "shoals!", $FA, $F7
    db $EF, $EE, "Not many captains", $EF, $EE, "will risk their", $FA, $F7
    db $EF, $EE, "boat to bother", $EF, $EE, "dealing with us.", $F7
    db $F0

Data_07C_584D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When you're out", $F1
    db "at sea, you get to", $FA, $F7
    db $EF, $EE, "see some peculiar", $EF, $EE, "sights.", $FA, $F7
    db $EF, $EE, "But when I saw a", $EF, $EE, "ghost ship loom", $FA, $F7
    db $EF, $EE, "out of thick fog", $A4, $EF, $EE, "Hair-raising!", $F7
    db $F0

Data_07C_58DA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Heh, that old", $F1
    db "man, he was too", $FA, $F7
    db $EF, $EE, "grogged to make", $EF, $EE, "any sense", $A4, $FA, $F7
    db $EF, $EE, "Captain, sir,", $EF, $EE, "what'll we do?", $F7
    db $F0

Data_07C_593B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Tch, made me", $F1
    db "waste my time", $A4, $FA, $F7
    db $EF, $EE, "We'll come back", $EF, $EE, "later for him.", $F7
    db $F0

Data_07C_597D:: ; heuristic: target of a monotone pointer table; C0
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

Data_07C_5AB8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When that old", $F1
    db "man gets grogged", $A4, $FA, $F7
    db $EF, $EE, "You can't move him", $EF, $EE, "with a crowbar.", $FA, $F7
    db $EF, $EE, "It's like he casts", $EF, $EE, "Ironize on", $FA, $F7
    db $EF, $EE, "himself.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What can we do", $F1
    db "about it?", $F7
    db $F0

Data_07C_5B4E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The old fellow", $F1
    db "there, the instant", $FA, $F7
    db $EF, $EE, "he smells a sea", $EF, $EE, "monster, he wakes", $FA, $F7
    db $EF, $EE, "up, even if he's", $EF, $EE, "tanked on grog.", $FA, $F7
    db $EF, $EE, "That's a real sea", $EF, $EE, "dog, I"
    db $44, $90, $36, $24, $3C, $99, $F7, $F0

Data_07C_5BE0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The volcanic", $F1
    db "island off the", $FA, $F7
    db $EF, $EE, "coast is vicious", $EF, $EE, "to ships.", $FA, $F7
    db $EF, $EE, "Its ring of shoals", $EF, $EE, "keeps boats away.", $F7
    db $F0

Data_07C_5C48:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hnnnr", $A4, " Hic", $A4, " Gnn", $A4, $F1
    db "Zzz", $A4, " Gfffff", $A4, $F7
    db $F0

Data_07C_5C6A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who are you?", $F1
    db "This is our surf!", $FA, $F7
    db $EF, $EE, $A4, "I mean turf!", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You show me some", $EF, $EE, "respect on our su", $A4, $FA, $F7
    db $EF, $EE, "Turf! That's it,", $EF, $EE, "I'm mad!", $F7
    db $F0

Data_07C_5CE5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can keep", $F1
    db "trying, but you're", $FA, $F7
    db $EF, $EE, "never going to", $EF, $EE, "win, punk!", $F7
    db $F0

Data_07C_5D26:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zzz", $A4, " Zzz", $A4, $F1
    db "Huh! Watch out!", $F7
    db $F0

Data_07C_5D44:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What! Why are", $F1
    db "you with monsters?", $FA, $F7
    db $EF, $EE, "You're an odd", $EF, $EE, "little child.", $FA, $F7
    db $EF, $EE, "Did you want to", $EF, $EE, "hear my tales?"
    db $FF, $F0

Data_07C_5DAB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It was in my", $F1
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

Data_07C_5FDC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The pirates", $95, $F1
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

Data_07C_6155:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's a tale of", $F1
    db "high adventure", $A4, $F7
    db $F0

Data_07C_6177:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? Are you", $F1
    db "here for my tales?"
    db $FF, $F0

Data_07C_619C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The pirates", $F1
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

Data_07C_62FF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's a chance to", $F1
    db "hear an intriguing", $FA, $F7
    db $EF, $EE, "tale of mystery", $A4, $EF, $EE, "Shame", $A4, $F7
    db $F0

Data_07C_6342:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm tired of the", $F1
    db "geezer's tales.", $F7
    db $F0

Data_07C_6365:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I saw a child", $F1
    db "cross the sea on a", $FA, $F7
    db $EF, $EE, "giant clam. No, no", $EF, $EE, "lie! I saw it!", $F7
    db $F0

Data_07C_63B0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Watch me dance,", $F1
    db "and you'll want to", $FA, $F7
    db $EF, $EE, "dance too. I can", $EF, $EE, "see that you do!", $FA, $F7
    db $EF, $EE, "I'm mimicking an", $EF, $EE, "Octokid's moves.", $F7
    db $F0

Data_07C_6420:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What", $A4, " What are", $F1
    db "you doing? Stop!", $F7
    db $F0

Data_07C_6444:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Gahahah!", $F1
    db $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Looks like we made", $EF, $EE, "it here first!", $FA, $F7
    db $EF, $EE, "All we have to do", $EF, $EE, "now is get the", $FA, $F7
    db $EF, $EE, "MoonRock from the", $EF, $EE, "mermaids, and the", $FA, $F7
    db $EF, $EE, "pirate's loot will", $EF, $EE, "be all mine!", $FA, $F7
    db $EF, $EE, "Sit back and watch", $EF, $EE, "our soaring dance!", $F7
    db $F0

Data_07C_6519:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "So where", $F1
    db "are the mermaids?", $FA, $F7
    db $EF, $EE, "That geezer was", $EF, $EE, "pulling our legs!", $F7
    db $F0

Data_07C_6565:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, my", $A4, " Who were", $F1
    db "those barbarians?", $FA, $F7
    db $EF, $EE, "How perfectly", $EF, $EE, "shocking and rude!", $F7
    db $F0

Data_07C_65B1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bravo, bravo!", $F1
    db "You were fabulous!", $FA, $F7
    db $EF, $EE, "You have a certain", $EF, $EE, "flair for genius!", $FA, $F7
    db $EF, $EE, "Oh? You say you", $EF, $EE, "want the MoonRock?", $FA, $F7
    db $EF, $EE, "Well", $A4, " All right.", $EF, $EE, "Your monsters say", $FA, $F7
    db $EF, $EE, "that you're a good", $EF, $EE, "human.", $FA, $F7
    db $EF, $EE, "I'll take you to", $EF, $EE, "our Queen.", $FA, $F7
    db $EF, $EE, "Close your eyes a", $EF, $EE, "little while.", $F7
    db $F0

Data_07C_66AD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm astonished.", $F1
    db "Mermaids exist.", $F7
    db $F0

Data_07C_66D0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you want to", $F1
    db "go to the kingdom", $FA, $F7
    db $EF, $EE, "of mermaids?", $EF, $EE
    db $FF, $F0

Data_07C_6707:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Close your eyes", $F1
    db "a little while.", $F7
    db $F0

Data_07C_672B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Come back for a", $F1
    db "visit anytime!", $FA, $F7
    db $EF, $EE, "You'll always be", $EF, $EE, "welcome here!", $F7
    db $F0

Data_07C_6770:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "mermaid kingdom.", $FA, $F7
    db $EF, $EE, "It is built on the", $EF, $EE, "ocean floor.", $FA, $F7
    db $EF, $EE, "It's very rare to", $EF, $EE, "see a human here.", $FA, $F7
    db $EF, $EE, "Tell me if you", $EF, $EE, "want to go home.", $F7
    db $F0

Data_07C_6800:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I know not all", $F1
    db "humans are bad", $A4, $FA, $F7
    db $EF, $EE, "But the pirates", $EF, $EE, "who stole our", $FA, $F7
    db $EF, $EE, "treasure were", $EF, $EE, "humans too.", $FA, $F7
    db $EF, $EE, "I hope HarMirror", $EF, $EE, "is not being used", $FA, $F7
    db $EF, $EE, "for their wicked", $EF, $EE, "misdeeds", $A4, $F7
    db $F0

Data_07C_68A9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The pirates", $F1
    db "caught us in nets", $FA, $F7
    db $EF, $EE, "and blackmailed", $EF, $EE, "our Queen into", $FA, $F7
    db $EF, $EE, "handing over our", $EF, $EE, "treasures", $A4, $F7
    db $F0

Data_07C_690E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The HarMirror", $F1
    db "was exquisite.", $FA, $F7
    db $EF, $EE, "It was so flawless", $EF, $EE, "that it made real", $FA, $F7
    db $EF, $EE, "its reflection", $EF, $EE, "while the original", $FA, $F7
    db $EF, $EE, "ceased to exist in", $EF, $EE, "this world.", $F7
    db $F0

Data_07C_69A1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The MoonRock", $F1
    db "fell from the sky.", $FA, $F7
    db $EF, $EE, "It glows like the", $EF, $EE, "Moon at night.", $F7
    db $F0

Data_07C_69EA:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The pirates sank", $F1
    db "with their ship.", $FA, $F7
    db $EF, $EE, "However, their", $EF, $EE, "greed for treasure", $FA, $F7
    db $EF, $EE, "would not allow", $EF, $EE, "them to rest easy.", $FA, $F7
    db $EF, $EE, "They now drift the", $EF, $EE, "sea as the ghostly", $FA, $F7
    db $EF, $EE, "crew of a spectral", $EF, $EE, "ship.", $F7
    db $F0

Data_07C_6AA4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We mermaids are", $F1
    db "peaceful beings.", $FA, $F7
    db $EF, $EE, "We shy away from", $EF, $EE, "violence.", $FA, $F7
    db $EF, $EE, "The thought of a", $EF, $EE, "haunted ship", $FA, $F7
    db $EF, $EE, "roaming the sea", $EF, $EE, "makes us uneasy.", $FA, $F7
    db $EF, $EE, "It will make our", $EF, $EE, "scales go coarse.", $F7
    db $F0

Data_07C_6B56:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome, young", $F1
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

Data_07C_6CE5:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, your will", $F1
    db "appears strong.", $FA, $F7
    db $EF, $EE, "You deserve to", $EF, $EE, "hear the truth.", $FA, $F7
    db $EF, $EE, "The MoonRock is on", $EF, $EE, "the ghost ship.", $FA, $F7
    db $EF, $EE, "It is a spectral", $EF, $EE, "ship manned by the", $FA, $F7
    db $EF, $EE, "spirits of pirates", $EF, $EE, "who died at sea.", $FA, $F7
    db $EF, $EE, "Driven by greed", $EF, $EE, "for treasures, the", $FA, $F7
    db $EF, $EE, "ship still wanders", $EF, $EE, "upon the waves.", $FA, $F7
    db $EF, $EE, "Look north from", $EF, $EE, "Yold for her.", $F7
    db $F0

Data_07C_6E11:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I see", $A4, " It can't", $F1
    db "be helped, then.", $FA, $F7
    db $EF, $EE, "However, if your", $EF, $EE, "destination is the", $FA, $F7
    db $EF, $EE, "volcanic island,", $EF, $EE, "you cannot help", $FA, $F7
    db $EF, $EE, "but come across", $EF, $EE, "the ghost ship.", $F7
    db $F0

Data_07C_6EA6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The MoonRock is", $F1
    db "on the ghost ship.", $FA, $F7
    db $EF, $EE, "It is a spectral", $EF, $EE, "ship manned by the", $FA, $F7
    db $EF, $EE, "spirits of pirates", $EF, $EE, "who died at sea.", $FA, $F7
    db $EF, $EE, "Driven by greed", $EF, $EE, "for treasures, the", $FA, $F7
    db $EF, $EE, "ship still wanders", $EF, $EE, "upon the waves.", $FA, $F7
    db $EF, $EE, "Look north from", $EF, $EE, "Yold for her.", $F7
    db $F0

Data_07C_6F8D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How could we die", $F1
    db "before enjoying", $FA, $F7
    db $EF, $EE, "all the loot we", $EF, $EE, "amassed", $A4, $F7
    db $F0

Data_07C_6FCF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The treasures", $F1
    db "are ours", $A4, $FA, $F7
    db $EF, $EE, "No one will take", $EF, $EE, "them from us", $A4, $F7
    db $F0

Data_07C_700E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is what", $F1
    db "became of us", $A4, $FA, $F7
    db $EF, $EE, "The pirates who", $EF, $EE, "savaged the seas", $A4, $F7
    db $F0

Data_07C_7053:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It nags and nags", $F1
    db "that we left our", $FA, $F7
    db $EF, $EE, "treasures behind", $A4, $EF, $EE, $F7
    db $F0

Data_07C_7090:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Check the wooden", $F1
    db "crate", $A4, $F7
    db $F0

Data_07C_70AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who disturbs us", $F1
    db "in our sleep", $A4, $FA, $F7
    db $EF, $EE, "Oh? There are", $EF, $EE, "still fools", $FA, $F7
    db $EF, $EE, "chasing our", $EF, $EE, "treasures after", $FA, $F7
    db $EF, $EE, "all this time?", $EF, $EE, $F7
    db $F0

Data_07C_7120:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "You seem to not", $F1
    db "understand", $A4, $FA, $F7
    db $EF, $EE, "The treasures", $EF, $EE, "belong to us.", $FA, $F7
    db $EF, $EE, "You shall see how", $EF, $EE, "powerless you are", $A4, $F7
    db $F0

Data_07C_718A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Child", $A4, $F1
    db "We have lost", $A4, $FA, $F7
    db $EF, $EE, "Finally, we can", $EF, $EE, "sleep", $A4, $F7
    db $F0

Data_07C_71BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "A mummified fish", $EF, $EE, "lay inside.", $F7
    db $F0

Data_07C_71FB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "There were dry,", $EF, $EE, "shriveled fruits.", $F7
    db $F0

Data_07C_723D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "crate.", $FA, $F7
    db $EF, $EE, "There was a hidden", $EF, $EE, "staircase.", $F7
    db $F0

Data_07C_7276:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "ledger.", $FA, $F7
    db $EF, $EE, $95, "Voyage Log", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sunrise obscured", $EF, $EE, "by deep fog", $A4, $FA, $F7
    db $EF, $EE, "Lookout reports", $A4, $EF, $EE, "there is some", $A4, $95, $F7
    db $F0

Data_07C_72E8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pedestal.", $FA, $F7
    db $EF, $EE, "It has a hole to", $EF, $EE, "accept an item.", $F7
    db $F0

Data_07C_7327:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The MoonRock fit", $F1
    db "snugly into place.", $F7
    db $F0

Data_07C_734C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pedestal.", $FA, $F7
    db $EF, $EE, "The MoonRock sat", $EF, $EE, "on the pedestal.", $F7
    db $F0

Data_07C_738C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wahahahah!", $F1
    db $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thanks for guiding", $EF, $EE, "me here!", $FA, $F7
    db $EF, $EE, "I figured that you", $EF, $EE, "would figure out", $FA, $F7
    db $EF, $EE, "where the loot was", $EF, $EE, "so I tailed you!", $FA, $F7
    db $EF, $EE, "I'll take the", $EF, $EE, "treasures home!", $F7
    db $F0

Data_07C_7434:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Urk! How"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F1
    db "you catch up?", $FA, $F7
    db $EF, $EE, "You're faster than", $EF, $EE, "you look", $A4, $FA, $F7
    db $EF, $EE, "Come on, mateys!", $EF, $EE, "Follow me!", $F7
    db $F0

Data_07C_7496:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Aye, aye, sir!", $F1
    db "Right behind you!", $F7
    db $F0

Data_07C_74BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Arrrrh,", $F1
    db "clear the way!", $FA, $F7
    db $EF, $EE, "I'm grabbing the", $EF, $EE, "treasure first!", $F7
    db $F0

Data_07C_7501:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "Gasp", $A4, $F1
    db $A4, "Hack", $A4, " I did it", $A4, $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "mine! All mine!", $F7
    db $F0

Data_07C_7549:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?!", $F1
    db "What is this?", $F7
    db $F0

Data_07C_7568:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $24, $2B, $24, $2B, $24, $2B, $24, $A4, $F1, $F7, $F0

Data_07C_7577:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is what it", $F1
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

Data_07C_76BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Urrrggh", $A4, $F1
    db "You tricked me!", $FA, $F7
    db $EF, $EE, "You're not getting", $EF, $EE, "away with this!", $F7
    db $F0

Data_07C_7707:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I was", $F1
    db "stupid to trust", $FA, $F7
    db $EF, $EE, "and believe in", $EF, $EE, "those monsters", $A4, $FA, $F7
    db $EF, $EE, "You take the loot", $EF, $EE, "back", $A4, " Later!", $F7
    db $F0

Data_07C_776D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Data_07C_778B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Wa-hey!", $F1
    db $F9, "0, hear me?", $FA, $F7
    db $EF, $EE, "I felt an odd", $EF, $EE, "power stirring.", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back! Don't move!", $F7
    db $F0

Data_07C_780E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I haven't seen", $F1
    db "the ghost ship in", $FA, $F7
    db $EF, $EE, "some time now, but", $EF, $EE, "I'm still afraid", $FA, $F7
    db $EF, $EE, "to get out of bed", $EF, $EE, "at night", $A4, $F7
    db $F0

Data_07C_7879:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The volcanic", $F1
    db "island appears to", $FA, $F7
    db $EF, $EE, "have calmed down", $EF, $EE, "again.", $FA, $F7
    db $EF, $EE, "Perhaps it took a", $EF, $EE, "sacrifice", $A4, $F7
    db $F0

Data_07C_78D9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sigh", $A4, " Will the", $F1
    db "HarMirror make me", $FA, $F7
    db $EF, $EE, "appear beautiful", $EF, $EE, "on the other side", $A4, $F7
    db $F0

Data_07C_7926:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My grandson just", $F1
    db "shivers now", $A4, $FA, $F7
    db $EF, $EE, "He's been wetting", $EF, $EE, "the bed too", $A4, $F7
    db $F0

Data_07C_796A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The mermaids", $F1
    db "came back.", $F7
    db $F0

Data_07C_7986:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e seen", $F1
    db "mermaids too.", $FA, $F7
    db $EF, $EE, "I think I'm in", $EF, $EE, "love!", $F7
    db $F0

Data_07C_79B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The pirates hid", $F1
    db "their loot on the", $FA, $F7
    db $EF, $EE, "volcanic island,", $EF, $EE, "I heard!", $FA, $F7
    db $EF, $EE, "All these years", $EF, $EE, "searching, and it", $FA, $F7
    db $EF, $EE, "was always right", $EF, $EE, "before my eyes!", $F7
    db $F0

Data_07C_7A48:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The sea around", $F1
    db "here is safe now.", $FA, $F7
    db $EF, $EE, "The town should be", $EF, $EE, "revitalized.", $F7
    db $F0

Data_07C_7A91:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The MoonRock", $F1
    db "glows at night", $FA, $F7
    db $EF, $EE, "from atop the", $EF, $EE, "lighthouse again.", $FA, $F7
    db $EF, $EE, "Someone restored", $EF, $EE, "it to its place.", $F7
    db $F0

Data_07C_7AFB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The sea's level", $F1
    db "has risen.", $FA, $F7
    db $EF, $EE, "No ships have", $EF, $EE, "foundered lately.", $F7
    db $F0

Data_07C_7B3D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " For some reason,", $F1
    db "the shoals sank", $FA, $F7
    db $EF, $EE, "almost instantly.", $EF, $EE, "It's a good thing.", $FA, $F7
    db $EF, $EE, "Ships should come", $EF, $EE, "back to restore", $FA, $F7
    db $EF, $EE, "the town to its", $EF, $EE, "former glory.", $F7
    db $F0

Data_07C_7BD2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you hear?", $F1
    db "Pirates hid their", $FA, $F7
    db $EF, $EE, "treasure on the", $EF, $EE, "volcanic island.", $FA, $F7
    db $EF, $EE, "I should have", $EF, $EE, "listened to the", $FA, $F7
    db $EF, $EE, "geezer and gone to", $EF, $EE, "see for myself", $A4, $F7
    db $F0

Data_07C_7C64:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What?", $F1
    db "You again?", $FA, $F7
    db $EF, $EE, "Back to hear more", $EF, $EE, "of my tales?", $FA, $F7
    db $EF, $EE, "Hah? No, no!", $EF, $EE, "The treasure on", $FA, $F7
    db $EF, $EE, "the sunken ship is", $EF, $EE, "a secret!", $F7
    db $F0

Data_07C_7CDE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our words of", $F1
    db "thanks could never", $FA, $F7
    db $EF, $EE, "do justice to the", $EF, $EE, "way we feel.", $F7
    db $F0

Data_07C_7D25:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Mermaids and", $F1
    db "humans can live", $FA, $F7
    db $EF, $EE, "side by side in", $EF, $EE, "harmony again!", $F7
    db $F0

Data_07C_7D69:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thanks to you,", $F1
    db "the spectral ship", $FA, $F7
    db $EF, $EE, "sank again, this", $EF, $EE, "time for good.", $FA, $F7
    db $EF, $EE, "The cravings of", $EF, $EE, "the ghostly crew", $FA, $F7
    db $EF, $EE, "for treasures must", $EF, $EE, "have been quelled.", $F7
    db $F0

Data_07C_7E01:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That wandering", $F1
    db "ghost ship's gone!", $FA, $F7
    db $EF, $EE, "My scales will", $EF, $EE, "be glossy once", $FA, $F7
    db $EF, $EE, "again!", $EF, $EE, $F7
    db $F0

Data_07C_7E54:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome, young", $F1
    db "hero!", $FA, $F7
    db $EF, $EE, "No words could", $EF, $EE, "ever adequately", $FA, $F7
    db $EF, $EE, "express our", $EF, $EE, "gratitude!", $F7
    db $F0

Data_07C_7EAB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N's", $F1
    db "dancing lured", $FA, $F7
    db $EF, $EE, "a mermaid to the", $EF, $EE, "surface.", $F7
    db $F0
    ds $124, $00
