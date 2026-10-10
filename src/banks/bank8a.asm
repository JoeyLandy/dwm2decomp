SECTION "Bank 8A", ROMX[$4000], BANK[$8A]
    db $8A

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. GameMode0_Update_Table2_Case14, Func_010_4AD0_Case0D, Func_012_6787_Case01)
BeginStringDisplay_Bank8A::
Func_08A_4001:: ; address name
    ld de, Data_08A_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_08A_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_08A_4018

Data_08A_4018:: ; heuristic: target of a monotone pointer table; C0
    dw Data_08A_4216
    dw Data_08A_432E
    dw Data_08A_4428
    dw Data_08A_4545
    dw Data_08A_4657
    dw Data_08A_4704
    dw Data_08A_4704
    dw Data_08A_4704
    dw Data_08A_4704
    dw Data_08A_486F
    dw Data_08A_49B2
    dw Data_08A_4AEE
    dw Data_08A_4AEE
    dw Data_08A_4AEE
    dw Data_08A_4AEE
    dw Data_08A_4AEE
    dw Data_08A_4AEE
    dw Data_08A_4B79
    dw Data_08A_4B79
    dw Data_08A_4B79
    dw Data_08A_4BFC
    dw Data_08A_4C75
    dw Data_08A_4CB9
    dw Data_08A_4D45
    dw Data_08A_4D7D
    dw Data_08A_4DDE
    dw Data_08A_4E71
    dw Data_08A_4EB8
    dw Data_08A_4F54
    dw Data_08A_4FBB
    dw Data_08A_5022
    dw Data_08A_505C
    dw Data_08A_50C3
    dw Data_08A_50F4
    dw Data_08A_5125
    dw Data_08A_515A
    dw Data_08A_517F
    dw Data_08A_51A1
    dw Data_08A_51C6
    dw Data_08A_51E9
    dw Data_08A_5228
    dw Data_08A_526C
    dw Data_08A_52A9
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0
    dw Data_08A_52E0

Data_08A_4216:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll tell you", $F1
    db "about this great", $FA, $F7
    db $EF, $EE, "adventure story I", $EF, $EE, "read long ago.", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 1,", $EF, $EE, "The Name is Hasta", $A4, $FA, $F7
    db $EF, $EE, "There once was a", $EF, $EE, "boy named Hasta.", $FA, $F7
    db $EF, $EE, "Who dreamed of", $EF, $EE, "becoming a master.", $FA, $F7
    db $EF, $EE, "One day he awoke,", $EF, $EE, "and had a nice", $A4, $FA, $F7
    db $EF, $EE, $A4, "Wait, how"
    db $44, $90, $37, $2B, $28, $EF, $EE, $35, $28, $36, $37, $90, $32, $29, $90, $2C
    db $37, $90, $2A, $32, $98, $F7, $F0

Data_08A_432E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, do you know", $F1
    db "this tale? Listen!", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 2,", $EF, $EE, "What Lies Beside", $A4, $FA, $F7
    db $EF, $EE, "When Hasta awoke,", $EF, $EE, "he realized that", $FA, $F7
    db $EF, $EE, "he wasn't alone in", $EF, $EE, "his bed.", $FA, $F7
    db $EF, $EE, "Lying beside him", $EF, $EE, "was a rotted body!", $FA, $F7
    db $EF, $EE, "What do you think?", $EF, $EE, "Pretty scary, eh?", $F7
    db $F0

Data_08A_4428:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Want to hear", $F1
    db "about a story I", $FA, $F7
    db $EF, $EE, "read when I was", $EF, $EE, "little?", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 3,", $EF, $EE, "Dead Man Waking", $A4, $FA, $F7
    db $EF, $EE, "Hasta found", $EF, $EE, "his courage and", $FA, $F7
    db $EF, $EE, "prodded the fetid", $EF, $EE, "corpse", $A4, $FA, $F7
    db $EF, $EE, "The putrid horror", $EF, $EE, "suddenly sat up!", $FA, $F7
    db $EF, $EE, "It was actually a", $EF, $EE, "Hork!", $FA, $F7
    db $EF, $EE, "Oooh, I thought it", $EF, $EE, "was so scary!", $F7
    db $F0

Data_08A_4545:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me recount", $F1
    db "this ancient lore", $A4, $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 4,", $EF, $EE, "Undead Calm", $A4, $FA, $F7
    db $EF, $EE, "Hork stretched and", $EF, $EE, "yawned out loud,", $FA, $F7
    db $EF, $EE, $95, "Fwaaah", $A4, " I need my", $EF, $EE, "beauty sleep.", $95, $FA, $F7
    db $EF, $EE, "And Hork went back", $EF, $EE, "to sleep.", $FA, $F7
    db $EF, $EE, "I guess that must", $EF, $EE, "be what sleeping", $FA, $F7
    db $EF, $EE, "like the dead is", $EF, $EE, "all about.", $F7
    db $F0

Data_08A_4657:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Long ago, there", $F1
    db "were books titled", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure.", $FA, $F7
    db $EF, $EE, "But the author", $EF, $EE, "gave up after just", $FA, $F7
    db $EF, $EE, "four slim books, I", $EF, $EE, "hear.", $FA, $F7
    db $EF, $EE, "I wonder if anyone", $EF, $EE, "remembers them?", $F7
    db $F0

Data_08A_4704:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, did you", $F1
    db "know?", $FA, $F7
    db $EF, $EE, "In any world that", $EF, $EE, "you visit using an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key, you'll come", $FA, $F7
    db $EF, $EE, "across bosses of", $EF, $EE, "certain areas.", $FA, $F7
    db $EF, $EE, "Until those bosses", $EF, $EE, "are defeated, no", $FA, $F7
    db $EF, $EE, "monster will join", $EF, $EE, "your party.", $FA, $F7
    db $EF, $EE, "They may want to,", $EF, $EE, "but they can't", $FA, $F7
    db $EF, $EE, "with the bosses", $EF, $EE, "watching them.", $FA, $F7
    db $EF, $EE, "So, if you want to", $EF, $EE, "befriend monsters,", $FA, $F7
    db $EF, $EE, "you need to defeat", $EF, $EE, "the area bosses.", $F7
    db $F0

Data_08A_486F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you visit any", $F1
    db "world using an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key, there will", $FA, $F7
    db $EF, $EE, "always be bosses", $EF, $EE, "of certain areas.", $FA, $F7
    db $EF, $EE, "If you don't beat", $EF, $EE, "those bosses, no", $FA, $F7
    db $EF, $EE, "monster will join", $EF, $EE, "your party.", $FA, $F7
    db $EF, $EE, "They're too scared", $EF, $EE, "of their bosses to", $FA, $F7
    db $EF, $EE, "even consider", $EF, $EE, "rebelling.", $FA, $F7
    db $EF, $EE, "So, if you want", $EF, $EE, "monsters to join", $FA, $F7
    db $EF, $EE, "you, defeat the", $EF, $EE, "area bosses.", $F7
    db $F0

Data_08A_49B2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In every world", $F1
    db "visited using an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key, you will see", $FA, $F7
    db $EF, $EE, "monster bosses", $EF, $EE, "exerting rule.", $FA, $F7
    db $EF, $EE, "Unless they are", $EF, $EE, "defeated, no", $FA, $F7
    db $EF, $EE, "monster will dare", $EF, $EE, "to join you.", $FA, $F7
    db $EF, $EE, "Fear of their", $EF, $EE, "bosses keeps them", $FA, $F7
    db $EF, $EE, "from acting on", $EF, $EE, "their own.", $FA, $F7
    db $EF, $EE, "That's why you", $EF, $EE, "must defeat bosses", $FA, $F7
    db $EF, $EE, "first to befriend", $EF, $EE, "wild monsters.", $F7
    db $F0

Data_08A_4AEE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There should be", $F1
    db "a castle in which", $FA, $F7
    db $EF, $EE, "the monster boss", $EF, $EE, "resides.", $FA, $F7
    db $EF, $EE, "Wild monsters are", $EF, $EE, "dominated by the", $FA, $F7
    db $EF, $EE, "boss, and won't", $EF, $EE, "become tame", $A4, $F7
    db $F0

Data_08A_4B79:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters you", $F1
    db "beat in battle", $FA, $F7
    db $EF, $EE, "could join your", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "A strong monster", $EF, $EE, "makes a powerful", $FA, $F7
    db $EF, $EE, "companion-if you", $EF, $EE, "can get one.", $F7
    db $F0

Data_08A_4BFC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters you", $F1
    db "beat in battle", $FA, $F7
    db $EF, $EE, "could join your", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "But their boss", $EF, $EE, "must be beaten", $FA, $F7
    db $EF, $EE, "before that can", $EF, $EE, "happen.", $F7
    db $F0

Data_08A_4C75:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Traveling with", $F1
    db "monsters?", $FA, $F7
    db $EF, $EE, "That takes a good", $EF, $EE, "deal of courage.", $F7
    db $F0

Data_08A_4CB9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're so young", $F1
    db "and small, but", $FA, $F7
    db $EF, $EE, "here you are, on a", $EF, $EE, "perilous journey", $A4, $FA, $F7
    db $EF, $EE, "Our soldiers can", $EF, $EE, "stand to learn a", $FA, $F7
    db $EF, $EE, "thing or two from", $EF, $EE, "you!", $F7
    db $F0

Data_08A_4D45:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Castle is", $F1
    db "safe.", $FA, $F7
    db $EF, $EE, "Relax, and enjoy", $EF, $EE, "your stay.", $F7
    db $F0

Data_08A_4D7D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you know of", $F1
    db "the MeteOrb?", $FA, $F7
    db $EF, $EE, "It's a rare item", $EF, $EE, "that does away", $FA, $F7
    db $EF, $EE, "with a monster's", $EF, $EE, "mistrust.", $F7
    db $F0

Data_08A_4DDE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The last monster", $F1
    db "you beat in battle", $FA, $F7
    db $EF, $EE, "has a chance of", $EF, $EE, "joining you.", $FA, $F7
    db $EF, $EE, "If you're after a", $EF, $EE, "specific species,", $FA, $F7
    db $EF, $EE, "you might consider", $EF, $EE, "healing it.", $F7
    db $F0

Data_08A_4E71:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's a monster", $F1
    db "that's skilled at", $FA, $F7
    db $EF, $EE, "attracting the", $EF, $EE, "opposite sex.", $F7
    db $F0

Data_08A_4EB8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you want to", $F1
    db "befriend monsters,", $FA, $F7
    db $EF, $EE, "give them meat,", $EF, $EE, "and don't be cheap.", $FA, $F7
    db $EF, $EE, "The more expensive", $EF, $EE, "it is, the better", $FA, $F7
    db $EF, $EE, "the quality of the", $EF, $EE, "meat, you see.", $F7
    db $F0

Data_08A_4F54:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I met a traveler", $F1
    db "who had monsters", $FA, $F7
    db $EF, $EE, "with him, just", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "Those monsters", $EF, $EE, "looked fearsome!", $F7
    db $F0

Data_08A_4FBB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I met a traveler", $F1
    db "who had monsters", $FA, $F7
    db $EF, $EE, "with him, just", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "They used skills", $EF, $EE, "I"
    db $44, $90, $31, $28, $39, $28, $35, $90, $36, $28, $28, $31, $B5, $F7, $F0

Data_08A_5022:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you ignore", $F1
    db "them, monsters", $FA, $F7
    db $EF, $EE, "will ignore you", $EF, $EE, "too.", $F7
    db $F0

Data_08A_505C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " While we do get", $F1
    db "travelers here,", $FA, $F7
    db $EF, $EE, "I", $42, "e only seen one", $EF, $EE, "other kid.", $FA, $F7
    db $EF, $EE, "It was a boy", $A4, $EF, $EE, "Terry, I think.", $F7
    db $F0

Data_08A_50C3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Data_08A_50F4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Data_08A_5125:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But it was locked.", $EF, $EE, $F7
    db $F0

Data_08A_515A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! How may I", $F1
    db "help you today?", $F7
    db $F0

Data_08A_517F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "traveler's inn!", $F7
    db $F0

Data_08A_51A1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me see what", $F1
    db "you are made of!", $F7
    db $F0

Data_08A_51C6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You'll have to", $F1
    db "beat me to pass!", $F7
    db $F0

Data_08A_51E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am a servant", $F1
    db "of the Gods.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

Data_08A_5228:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "traveler's inn!", $FA, $F7
    db $EF, $EE, "The view here is", $EF, $EE, "magnificent!", $F7
    db $F0

Data_08A_526C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The evil force", $F1
    db "enshrouding the", $FA, $F7
    db $EF, $EE, "entire world faded", $EF, $EE, "away!", $F7
    db $F0

Data_08A_52A9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The evil force", $F1
    db "covering the", $FA, $F7
    db $EF, $EE, "continent faded", $EF, $EE, "away!", $F7
    db $F0

Data_08A_52E0:: ; heuristic: target of a monotone pointer table; C0
    db $F0
    ds $2D1F, $00
