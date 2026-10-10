SECTION "Bank 86", ROMX[$4000], BANK[$86]
    db $86

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. GameMode0_Update_Table2_Case0C, Func_010_4AD0_Case0C, ShowMessageHL_Case0C)
BeginStringDisplay_Bank86::
Func_086_4001:: ; address name
    ld de, Data_086_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_086_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_086_4018

Data_086_4018:: ; heuristic: target of a monotone pointer table; C0
    dw Data_086_4218
    dw Data_086_42BB
    dw Data_086_4321
    dw Data_086_43AE
    dw Data_086_441E
    dw Data_086_447D
    dw Data_086_447E
    dw Data_086_447F
    dw Data_086_451E
    dw Data_086_459F
    dw Data_086_45A0
    dw Data_086_45A1
    dw Data_086_4624
    dw Data_086_4699
    dw Data_086_469A
    dw Data_086_469B
    dw Data_086_4741
    dw Data_086_4795
    dw Data_086_4796
    dw Data_086_4797
    dw Data_086_483B
    dw Data_086_4897
    dw Data_086_4898
    dw Data_086_4984
    dw Data_086_49D2
    dw Data_086_4A76
    dw Data_086_4ADC
    dw Data_086_4BB4
    dw Data_086_4C49
    dw Data_086_4C9E
    dw Data_086_4C9F
    dw Data_086_4CA0
    dw Data_086_4D41
    dw Data_086_4DAB
    dw Data_086_4DAC
    dw Data_086_4DAD
    dw Data_086_4E17
    dw Data_086_4E6E
    dw Data_086_4E6F
    dw Data_086_4E70
    dw Data_086_4F0F
    dw Data_086_4F6C
    dw Data_086_4F6D
    dw Data_086_4F6E
    dw Data_086_500E
    dw Data_086_506E
    dw Data_086_506F
    dw Data_086_516F
    dw Data_086_51BA
    dw Data_086_5285
    dw Data_086_52BF
    dw Data_086_5347
    dw Data_086_53C8
    dw Data_086_542B
    dw Data_086_542C
    dw Data_086_542D
    dw Data_086_54D3
    dw Data_086_5558
    dw Data_086_5559
    dw Data_086_555A
    dw Data_086_55FA
    dw Data_086_56A5
    dw Data_086_56A6
    dw Data_086_56A7
    dw Data_086_5758
    dw Data_086_57DE
    dw Data_086_57DF
    dw Data_086_57E0
    dw Data_086_585E
    dw Data_086_5968
    dw Data_086_59C1
    dw Data_086_5A76
    dw Data_086_5AE3
    dw Data_086_5B27
    dw Data_086_5B6D
    dw Data_086_5B92
    dw Data_086_5BB7
    dw Data_086_5BDD
    dw Data_086_5BF7
    dw Data_086_5C1F
    dw Data_086_5C41
    dw Data_086_5C5F
    dw Data_086_5C7F
    dw Data_086_5C99
    dw Data_086_5CB4
    dw Data_086_5CD2
    dw Data_086_5CF4
    dw Data_086_5D77
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5F38
    dw Data_086_5F9F
    dw Data_086_5FC1
    dw Data_086_609B
    dw Data_086_60E4
    dw Data_086_6106
    dw Data_086_6151
    dw Data_086_6190
    dw Data_086_61D3
    dw Data_086_6235
    dw Data_086_6257
    dw Data_086_62D9
    dw Data_086_631A
    dw Data_086_635F
    dw Data_086_63AC
    dw Data_086_6469
    dw Data_086_64B0
    dw Data_086_65AC
    dw Data_086_65EA
    dw Data_086_664C
    dw Data_086_66B9
    dw Data_086_672B
    dw Data_086_67D2
    dw Data_086_6840
    dw Data_086_6863
    dw Data_086_68A7
    dw Data_086_68C8
    dw Data_086_6A00
    dw Data_086_6A3E
    dw Data_086_6A73
    dw Data_086_6AB0
    dw Data_086_6AE8
    dw Data_086_6B5E

Data_086_4218:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "Power Tower.", $FA, $F7
    db $EF, $EE, "Are you the new", $EF, $EE, "challenger?", $FA, $F7
    db $EF, $EE, "If you win, you'll", $EF, $EE, "earn many useful", $FA, $F7
    db $EF, $EE, "accessories for", $EF, $EE, "your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Data_086_42BB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you win,", $F1
    db "you'll earn many", $FA, $F7
    db $EF, $EE, "useful accessories", $EF, $EE, "for your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Data_086_4321:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Only a handful", $F1
    db "of masters have", $FA, $F7
    db $EF, $EE, "made it to the top", $EF, $EE, "of the Tower.", $FA, $F7
    db $EF, $EE, "I tried, but the", $EF, $EE, "best I could do", $FA, $F7
    db $EF, $EE, "was reach the", $EF, $EE, "fourth floor.", $F7
    db $F0

Data_086_43AE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Tower's many", $F1
    db "treasures are", $FA, $F7
    db $EF, $EE, "heavily guarded by", $EF, $EE, "monsters, slurp.", $FA, $F7
    db $EF, $EE, "They'll attack you", $EF, $EE, "all out, slurp.", $F7
    db $F0

Data_086_441E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "second floor-", $FA, $F7
    db $EF, $EE, "the Whirlwind", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Can you withstand", $EF, $EE, "our wind power?", $F7
    db $F0

Data_086_447D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_447E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_447F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Not bad, not bad", $F1
    db "at all.", $FA, $F7
    db $EF, $EE, "Fine. Take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "The Clearwater", $EF, $EE, "Chamber is next.", $FA, $F7
    db $EF, $EE, "Monsters that use", $EF, $EE, "water skills will", $FA, $F7
    db $EF, $EE, "be waiting for", $EF, $EE, "you.", $F7
    db $F0

Data_086_451E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "third floor-", $FA, $F7
    db $EF, $EE, "the Clearwater", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "If you belittle", $EF, $EE, "hydropower, you", $FA, $F7
    db $EF, $EE, "will suffer for", $EF, $EE, "your ignorance!", $F7
    db $F0

Data_086_459F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_45A0:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_45A1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're quite", $F1
    db "good.", $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "yours to take.", $FA, $F7
    db $EF, $EE, "Upstairs is the", $EF, $EE, "Blizzard Chamber.", $FA, $F7
    db $EF, $EE, "It's very cold, so", $EF, $EE, "be careful.", $F7
    db $F0

Data_086_4624:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "fourth floor-", $FA, $F7
    db $EF, $EE, "the Blizzard", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "I hope you're", $EF, $EE, "bundled up warm.", $FA, $F7
    db $EF, $EE, "We'll freeze you", $EF, $EE, "solid!", $F7
    db $F0

Data_086_4699:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_469A:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_469B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wow, aren't you", $F1
    db "good.", $FA, $F7
    db $EF, $EE, "Go ahead and take", $EF, $EE, "the treasures.", $FA, $F7
    db $EF, $EE, "The Thunder", $EF, $EE, "Chamber's next.", $FA, $F7
    db $EF, $EE, "You can always", $EF, $EE, "hear the sound of", $FA, $F7
    db $EF, $EE, "crashing thunder.", $EF, $EE, "It's annoying!", $F7
    db $F0

Data_086_4741:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "fifth floor-", $FA, $F7
    db $EF, $EE, "the Thunder", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Prepare for", $EF, $EE, "obliteration!", $F7
    db $F0

Data_086_4795:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4796:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4797:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well done.", $F1
    db "So it shall be.", $FA, $F7
    db $EF, $EE, "You have bettered", $EF, $EE, "us in power.", $FA, $F7
    db $EF, $EE, "The Tower's peak", $EF, $EE, "is next.", $FA, $F7
    db $EF, $EE, "Monsters that use", $EF, $EE, "extreme heat stand", $FA, $F7
    db $EF, $EE, "alert for your", $EF, $EE, "arrival.", $F7
    db $F0

Data_086_483B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well.", $F1
    db "How impressive.", $FA, $F7
    db $EF, $EE, "I must commend you", $EF, $EE, "for reaching me.", $FA, $F7
    db $EF, $EE, "Well.", $EF, $EE, "Shall we begin?", $F7
    db $F0

Data_086_4897:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4898:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well.", $F1
    db "How impressive.", $FA, $F7
    db $EF, $EE, "Conquering the", $EF, $EE, "Power Tower.", $FA, $F7
    db $EF, $EE, "It was built by a", $A4, $EF, $EE, "a great being.", $FA, $F7
    db $EF, $EE, "He built other", $EF, $EE, "towers like this.", $FA, $F7
    db $EF, $EE, "Do you possess all", $EF, $EE, "that is needed to", $FA, $F7
    db $EF, $EE, "conquer them all?", $EF, $EE, "Well?", $FA, $F7
    db $EF, $EE, "Take the treasures", $EF, $EE, "behind me.", $F7
    db $F0

Data_086_4984:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e conquered", $F1
    db "the Power Tower.", $FA, $F7
    db $EF, $EE, "I hope you become", $EF, $EE, "a powerful master.", $F7
    db $F0

Data_086_49D2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "Baffle Tower.", $FA, $F7
    db $EF, $EE, "Are you the new", $EF, $EE, "challenger?", $FA, $F7
    db $EF, $EE, "If you win, you'll", $EF, $EE, "earn many useful", $FA, $F7
    db $EF, $EE, "accessories for", $EF, $EE, "your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Data_086_4A76:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you win,", $F1
    db "you'll earn many", $FA, $F7
    db $EF, $EE, "useful accessories", $EF, $EE, "for your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Data_086_4ADC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In this Tower,", $F1
    db "your opponents", $FA, $F7
    db $EF, $EE, "come at you with", $EF, $EE, "support skills", $FA, $F7
    db $EF, $EE, "rather than all-", $EF, $EE, "out attacks.", $FA, $F7
    db $EF, $EE, "My party was put", $EF, $EE, "to sleep, made to", $FA, $F7
    db $EF, $EE, "dance", $A4, " All sorts", $EF, $EE, "of weird things.", $FA, $F7
    db $EF, $EE, "It was a rotten", $EF, $EE, "time, I swear!", $F7
    db $F0

Data_086_4BB4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's not that", $F1
    db "easy to win here", $FA, $F7
    db $EF, $EE, "by playing it fair", $EF, $EE, "and honorably.", $FA, $F7
    db $EF, $EE, "You have to use", $EF, $EE, "your noggin to mix", $FA, $F7
    db $EF, $EE, "and match skills", $EF, $EE, "for best effect.", $F7
    db $F0

Data_086_4C49:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "second floor-", $FA, $F7
    db $EF, $EE, "the Shackle", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "We'll disable your", $EF, $EE, "skills!", $F7
    db $F0

Data_086_4C9E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4C9F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4CA0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well played.", $F1
    db "I can't complain.", $FA, $F7
    db $EF, $EE, "Fine. Take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "The Confusion", $EF, $EE, "Chamber is next.", $FA, $F7
    db $EF, $EE, "Monsters that", $EF, $EE, "disable control", $FA, $F7
    db $EF, $EE, "will stand in your", $EF, $EE, "way.", $F7
    db $F0

Data_086_4D41:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "third floor-", $FA, $F7
    db $EF, $EE, "the Confusion", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Let us gift you", $EF, $EE, "with a time of", $FA, $F7
    db $EF, $EE, "dreaming", $A4, $EF, $EE, $F7
    db $F0

Data_086_4DAB:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4DAC:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4DAD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bravo. Take the", $F1
    db "treasures.", $FA, $F7
    db $EF, $EE, "Upstairs is the", $EF, $EE, "Fatigue Chamber.", $FA, $F7
    db $EF, $EE, "I understand it is", $EF, $EE, "very tiresome.", $F7
    db $F0

Data_086_4E17:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "fourth floor-", $FA, $F7
    db $EF, $EE, "the Fatigue", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Let us put you to", $EF, $EE, "the test!", $F7
    db $F0

Data_086_4E6E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4E6F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4E70:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Remarkable,", $F1
    db "I must admit.", $FA, $F7
    db $EF, $EE, "You have earned", $EF, $EE, "the treasures.", $FA, $F7
    db $EF, $EE, "The Looting", $EF, $EE, "Chamber's next.", $FA, $F7
    db $EF, $EE, "Monsters that", $EF, $EE, "steal your power", $FA, $F7
    db $EF, $EE, "are what you will", $EF, $EE, "face.", $F7
    db $F0

Data_086_4F0F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "fifth floor-", $FA, $F7
    db $EF, $EE, "the Looting", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Could you battle", $EF, $EE, "without strength?", $F7
    db $F0

Data_086_4F6C:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4F6D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4F6E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're quite", $F1
    db "tough.", $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "yours to take.", $FA, $F7
    db $EF, $EE, "The Tower's peak", $EF, $EE, "is next.", $FA, $F7
    db $EF, $EE, "Monsters that use", $EF, $EE, "dangerous skills", $FA, $F7
    db $EF, $EE, "are waiting for", $EF, $EE, "the worthy.", $F7
    db $F0

Data_086_500E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you have", $F1
    db "impressed me.", $FA, $F7
    db $EF, $EE, "It's rare to see", $EF, $EE, "anyone here.", $FA, $F7
    db $EF, $EE, "Let the final", $EF, $EE, "battle begin", $A4, $F7
    db $F0

Data_086_506E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_506F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You are to be", $F1
    db "commended for", $FA, $F7
    db $EF, $EE, "conquering the", $EF, $EE, "Baffle Tower.", $FA, $F7
    db $EF, $EE, "It was built by a", $A4, $EF, $EE, "a great being.", $FA, $F7
    db $EF, $EE, "He built other", $EF, $EE, "towers like this.", $FA, $F7
    db $EF, $EE, "If you wish to be", $EF, $EE, "a true master, it", $FA, $F7
    db $EF, $EE, "is pointless to", $EF, $EE, "not conquer all", $FA, $F7
    db $EF, $EE, "the towers made by", $EF, $EE, "the great being.", $F7
    db $F0

Data_086_516F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e conquered", $F1
    db "the Baffle Tower.", $FA, $F7
    db $EF, $EE, "I hope you become", $EF, $EE, "a wise master.", $F7
    db $F0

Data_086_51BA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you", $42, "e made", $F1
    db "it to this-the", $FA, $F7
    db $EF, $EE, "Soul Tower-it", $EF, $EE, "must mean that", $FA, $F7
    db $EF, $EE, "you", $42, "e conquered", $EF, $EE, "the two other", $FA, $F7
    db $EF, $EE, "Towers of Power", $EF, $EE, "and Baffle.", $FA, $F7
    db $EF, $EE, "But even so, this", $EF, $EE, "Tower is terribly", $FA, $F7
    db $EF, $EE, "tough. I hope", $EF, $EE, "you're ready.", $F7
    db $F0

Data_086_5285:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This Tower is", $F1
    db "terribly tough.", $FA, $F7
    db $EF, $EE, "I hope you're", $EF, $EE, "ready.", $F7
    db $F0

Data_086_52BF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The monsters", $F1
    db "here are awful.", $FA, $F7
    db $EF, $EE, "I'm losing my", $EF, $EE, "confidence", $A4, $FA, $F7
    db $EF, $EE, "I heard a horrible", $EF, $EE, "racket from above.", $FA, $F7
    db $EF, $EE, "It might be that", $EF, $EE, "one skill", $A4, $F7
    db $F0

Data_086_5347:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's brutal up", $F1
    db "ahead.", $FA, $F7
    db $EF, $EE, "I wouldn't push my", $EF, $EE, "luck.", $FA, $F7
    db $EF, $EE, "Beating the second", $EF, $EE, "floor monsters was", $FA, $F7
    db $EF, $EE, "a serious ordeal,", $EF, $EE, "believe me.", $F7
    db $F0

Data_086_53C8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "second floor.", $FA, $F7
    db $EF, $EE, "This is the Life", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "I'm not powerful,", $EF, $EE, "but I am durable!", $F7
    db $F0

Data_086_542B:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_542C:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_542D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're quite", $F1
    db "good at this.", $FA, $F7
    db $EF, $EE, "Sure, take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "Upstairs is the", $EF, $EE, "Pain Chamber.", $FA, $F7
    db $EF, $EE, "I don't like being", $EF, $EE, "hurt, so I really", $FA, $F7
    db $EF, $EE, "hate going up", $EF, $EE, "there, yikes!", $F7
    db $F0

Data_086_54D3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "third floor.", $FA, $F7
    db $EF, $EE, "It's the Pain", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "I'll tell you right", $EF, $EE, "now, it really", $FA, $F7
    db $EF, $EE, "does hurt a lot in", $EF, $EE, "here! Here goes!", $F7
    db $F0

Data_086_5558:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_5559:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_555A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e shown me", $F1
    db "your worth.", $FA, $F7
    db $EF, $EE, "Go on, take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "The Healing", $EF, $EE, "Chamber is next.", $FA, $F7
    db $EF, $EE, "Monsters skilled", $EF, $EE, "at healing are", $FA, $F7
    db $EF, $EE, "eagerly waiting", $EF, $EE, "for you.", $F7
    db $F0

Data_086_55FA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "fourth floor.", $FA, $F7
    db $EF, $EE, "The Healing", $EF, $EE, "Chamber it is!", $FA, $F7
    db $EF, $EE, "The first thing", $EF, $EE, "you should know", $FA, $F7
    db $EF, $EE, "is that attacking", $EF, $EE, "us is a waste.", $FA, $F7
    db $EF, $EE, "Without further", $EF, $EE, "ado, let's begin.", $F7
    db $F0

Data_086_56A5:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_56A6:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_56A7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fine, we will", $F1
    db "confer all the", $FA, $F7
    db $EF, $EE, "treasures to you", $EF, $EE, "for your victory.", $FA, $F7
    db $EF, $EE, "Up next is the", $EF, $EE, "Chaos Chamber.", $FA, $F7
    db $EF, $EE, "The greatest of", $EF, $EE, "the destroyers", $FA, $F7
    db $EF, $EE, "stand guard over", $EF, $EE, "the treasures.", $F7
    db $F0

Data_086_5758:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "fifth floor.", $FA, $F7
    db $EF, $EE, "Welcome to the", $EF, $EE, "Chaos Chamber.", $FA, $F7
    db $EF, $EE, "Have you said your", $EF, $EE, "prayers?", $FA, $F7
    db $EF, $EE, "We will come out", $EF, $EE, "at maximum power!", $F7
    db $F0

Data_086_57DE:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_57DF:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_57E0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " All right.", $F1
    db "Good enough.", $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "yours to take.", $FA, $F7
    db $EF, $EE, "The Tower's peak", $EF, $EE, "is next.", $FA, $F7
    db $EF, $EE, "The great being", $EF, $EE, "awaits you.", $F7
    db $F0

Data_086_585E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? Well, well,", $F1
    db "you're the first", $FA, $F7
    db $EF, $EE, "master to visit me", $EF, $EE, "in a long time.", $FA, $F7
    db $EF, $EE, "But look at you!", $EF, $EE, "You're a child!", $FA, $F7
    db $EF, $EE, "I'm the Grand", $EF, $EE, "Master.", $FA, $F7
    db $EF, $EE, "I built this", $EF, $EE, "Tower.", $FA, $F7
    db $EF, $EE, "I", $42, "e been waiting", $EF, $EE, "for strong masters", $FA, $F7
    db $EF, $EE, "to come ever since", $EF, $EE, "then.", $FA, $F7
    db $EF, $EE, "Please, show me", $EF, $EE, "what you can do!", $F7
    db $F0

Data_086_5968:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! You", $42, "e", $F1
    db "come back!", $FA, $F7
    db $EF, $EE, "Are you feeling", $EF, $EE, "lucky?", $FA, $F7
    db $EF, $EE, "Then, let's start!", $EF, $EE, "Here we go!", $F7
    db $F0

Data_086_59C1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You are good!", $F1
    db "I like you!", $FA, $F7
    db $EF, $EE, "You", $42, "e conquered", $EF, $EE, "all three Towers-", $FA, $F7
    db $EF, $EE, "Power, Baffle and", $EF, $EE, "this, Soul Tower.", $FA, $F7
    db $EF, $EE, "You're certain to", $EF, $EE, "get even better.", $FA, $F7
    db $EF, $EE, "I want you to have", $EF, $EE, "some gifts!", $F7
    db $F0

Data_086_5A76:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e conquered", $F1
    db "the Soul Tower.", $FA, $F7
    db $EF, $EE, "I hope you'll keep", $EF, $EE, "working towards", $FA, $F7
    db $EF, $EE, "becoming the best", $EF, $EE, "master ever.", $F7
    db $F0

Data_086_5AE3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "The treasure chest", $EF, $EE, "was a Mimic!", $F7
    db $F0

Data_086_5B27:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "It was a Mimic!", $EF, $EE, "It began to talk.", $F7
    db $F0

Data_086_5B6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lightning when", $F1
    db "wet is dangerous!", $F7
    db $F0

Data_086_5B92:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When it's cold,", $F1
    db "fire's the answer!", $F7
    db $F0

Data_086_5BB7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Electric jolts", $F1
    db "are good at times.", $F7
    db $F0

Data_086_5BDD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hot! Hot!", $F1
    db "Burning up!", $F7
    db $F0

Data_086_5BF7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What to do if we", $F1
    db "are all in danger", $A4, $F7
    db $F0

Data_086_5C1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sweets are good", $F1
    db "cheap energy!", $F7
    db $F0

Data_086_5C41:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Overconfidence", $F1
    db "is a trap.", $F7
    db $F0

Data_086_5C5F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm scared", $A4, $F1
    db "Terrified, even", $A4, $F7
    db $F0

Data_086_5C7F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If it hurts,", $F1
    db "heal it.", $F7
    db $F0

Data_086_5C99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good health", $F1
    db "above all.", $F7
    db $F0

Data_086_5CB4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Pow! Ka-pow!", $F1
    db "Big trouble!", $F7
    db $F0

Data_086_5CD2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Young master", $A4, $F1
    db "The final test", $A4, $F7
    db $F0

Data_086_5CF4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Really! Wow!", $F1
    db "You're the first", $FA, $F7
    db $EF, $EE, "human that I", $42, "e", $EF, $EE, "ever met!", $FA, $F7
    db $EF, $EE, "Wow, a human is", $EF, $EE, "pretty cute!", $FA, $F7
    db $EF, $EE, "Don't you think so,", $EF, $EE, "big brother?", $F7
    db $F0

Data_086_5D77:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, don't lie!", $F1
    db "You don't look", $FA, $F7
    db $EF, $EE, "like an elf or a", $EF, $EE, "monster at all!", $FA, $F7
    db $EF, $EE, "You really are a", $EF, $EE, "human, aren't you?"
    db $FF, $F0

Data_086_5DE3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What is it, you", $F1
    db "little brat?", $FA, $F7
    db $EF, $EE, "Did you come to", $EF, $EE, "get creamed too?", $FA, $F7
    db $EF, $EE, "That town is full", $EF, $EE, "of the idle rich.", $FA, $F7
    db $EF, $EE, "Their treasures", $EF, $EE, "are there for the", $FA, $F7
    db $EF, $EE, "taking, so I took", $EF, $EE, "them.", $FA, $F7
    db $EF, $EE, "I was going to", $EF, $EE, "sell it off and", $FA, $F7
    db $EF, $EE, "make some serious", $EF, $EE, "money.", $FA, $F7
    db $EF, $EE, "But a brat like", $EF, $EE, "you comes along!", $FA, $F7
    db $EF, $EE, "I can still make", $EF, $EE, "this work", $A4, $FA, $F7
    db $EF, $EE, "If I don't let you", $EF, $EE, "go alive!", $F7
    db $F0

Data_086_5F38:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What is it, you", $F1
    db "little brat?", $FA, $F7
    db $EF, $EE, "Back to get", $EF, $EE, "creamed again?", $FA, $F7
    db $EF, $EE, "I won't let you go", $EF, $EE, "alive this time!", $F7
    db $F0

Data_086_5F9F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " But", $A4, " No! I lost", $F1
    db "to this brat?", $F7
    db $F0

Data_086_5FC1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " You are", $F1
    db "really special.", $FA, $F7
    db $EF, $EE, "I couldn't do a", $EF, $EE, "thing against him", $A4, $FA, $F7
    db $EF, $EE, "I'll have to train", $EF, $EE, "that much harder", $A4, $FA, $F7
    db $EF, $EE, "I'll be no match", $EF, $EE, "for my kid brother", $FA, $F7
    db $EF, $EE, "if  I don't apply", $EF, $EE, "myself better.", $FA, $F7
    db $EF, $EE, "I'll wait for you", $EF, $EE, "in town!", $F7
    db $F0

Data_086_609B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "town of Miagen.", $FA, $F7
    db $EF, $EE, "We're proud of our", $EF, $EE, "affluence here!", $F7
    db $F0

Data_086_60E4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So you defeated", $F1
    db "the evildoer?", $F7
    db $F0

Data_086_6106:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wow, you have", $F1
    db "monsters! Wicked!", $FA, $F7
    db $EF, $EE, "They beat the bad", $EF, $EE, "guy, didn't they?", $F7
    db $F0

Data_086_6151:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your monsters", $F1
    db "are good, it's", $FA, $F7
    db $EF, $EE, "plain to see.", $EF, $EE, "I like them!", $F7
    db $F0

Data_086_6190:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So there are", $F1
    db "evil masters", $A4, $FA, $F7
    db $EF, $EE, "Oh, but you're not", $EF, $EE, "one of those.", $F7
    db $F0

Data_086_61D3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Controlling", $F1
    db "monsters is no", $FA, $F7
    db $EF, $EE, "easy feat, is it?", $EF, $EE, "I'm so in awe!", $FA, $F7
    db $EF, $EE, "You", $42, "e brought", $EF, $EE, "peace to us!", $F7
    db $F0

Data_086_6235:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I thank you in", $F1
    db "all sincerity!", $F7
    db $F0

Data_086_6257:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The atmosphere", $F1
    db "has cheered up,", $FA, $F7
    db $EF, $EE, "thanks to your", $EF, $EE, "crime busting.", $FA, $F7
    db $EF, $EE, "It gives me hope", $EF, $EE, "to live another", $FA, $F7
    db $EF, $EE, "one hundred years!", $EF, $EE, $F7
    db $F0

Data_086_62D9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I long to have a", $F1
    db "family of my own.", $FA, $F7
    db $EF, $EE, "I wish I was", $EF, $EE, "married", $A4, $F7
    db $F0

Data_086_631A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Old people say", $F1
    db "that a cheerful", $FA, $F7
    db $EF, $EE, "town is a good", $EF, $EE, "town. I agree!", $F7
    db $F0

Data_086_635F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters can be", $F1
    db "good or evil on", $FA, $F7
    db $EF, $EE, "the whims of their", $EF, $EE, "masters, I guess.", $F7
    db $F0

Data_086_63AC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The thief was", $F1
    db "selling what he", $FA, $F7
    db $EF, $EE, "stole from us for", $EF, $EE, "a lot of gold.", $FA, $F7
    db $EF, $EE, "But why would he", $EF, $EE, "steal my clothes?", $FA, $F7
    db $EF, $EE, "Were they valuable", $EF, $EE, "because they were", $FA, $F7
    db $EF, $EE, "mine? I'm not sure", $EF, $EE, "I want to know", $A4, $F7
    db $F0

Data_086_6469:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It sure was a", $F1
    db "thrilling time", $FA, $F7
    db $EF, $EE, "when the thief was", $EF, $EE, "roving around.", $F7
    db $F0

Data_086_64B0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I asked", $F1
    db "for your support", $FA, $F7
    db $EF, $EE, "to capture that", $EF, $EE, "thief", $A4, $FA, $F7
    db $EF, $EE, "But you ended up", $EF, $EE, "doing it all.", $FA, $F7
    db $EF, $EE, "I'm sorry, and", $EF, $EE, "thank you.", $FA, $F7
    db $EF, $EE, "Oh? You're from", $EF, $EE, "GreatLog?", $FA, $F7
    db $EF, $EE, "And you", $42, "e won", $EF, $EE, "tournaments.", $FA, $F7
    db $EF, $EE, "Well, no wonder", $EF, $EE, "you're strong.", $FA, $F7
    db $EF, $EE, "How is Kameha,", $EF, $EE, "by the way?", $F7
    db $F0

Data_086_65AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " How do I", $F1
    db "know about him?", $FA, $F7
    db $EF, $EE, "Well", $A4, $EF, $EE, "That's a secret!", $F7
    db $F0

Data_086_65EA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " You", $42, "e", $F1
    db "inspired me to try", $FA, $F7
    db $EF, $EE, "harder in my", $EF, $EE, "training.", $FA, $F7
    db $EF, $EE, "I hope we can", $EF, $EE, "battle some day!", $F7
    db $F0

Data_086_664C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That merchant,", $F1
    db "he was a thief.", $FA, $F7
    db $EF, $EE, "In one way he has", $EF, $EE, "my admiration.", $FA, $F7
    db $EF, $EE, "His bad deeds", $EF, $EE, "escaped my notice!", $F7
    db $F0

Data_086_66B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " People say you", $F1
    db "can't judge people", $FA, $F7
    db $EF, $EE, "by appearances", $A4, $EF, $EE, "But that thieving", $FA, $F7
    db $EF, $EE, "merchant", $A4, " He had", $EF, $EE, "the bad guy look!", $F7
    db $F0

Data_086_672B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That greedy", $F1
    db "hound of a dealer", $FA, $F7
    db $EF, $EE, "was behind those", $EF, $EE, "monsters", $A4, $FA, $F7
    db $EF, $EE, "But to be caught", $EF, $EE, "out by selling", $FA, $F7
    db $EF, $EE, "what he stole", $A4, $EF, $EE, "He's not what I", $FA, $F7
    db $EF, $EE, "call a criminal", $EF, $EE, "mastermind.", $F7
    db $F0

Data_086_67D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I knew", $F1
    db "you"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " come back!", $FA, $F7
    db $EF, $EE, "I", $42, "e trained hard", $EF, $EE, "since we last met.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "spar with me?"
    db $FF, $F0

Data_086_6840:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Great!", $F1
    db "No holding back!", $F7
    db $F0

Data_086_6863:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Oh", $A4, $F1
    db "I'm disappointed", $A4, $FA, $F7
    db $EF, $EE, "Come again if you", $EF, $EE, "want to spar.", $F7
    db $F0

Data_086_68A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Want to", $F1
    db "spar with me?"
    db $FF, $F0

Data_086_68C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I lost", $A4, $F1
    db "But, good battle!", $FA, $F7
    db $EF, $EE, "Oh, I need to tell", $EF, $EE, "you this.", $FA, $F7
    db $EF, $EE, "If you meet a boy", $EF, $EE, "named Terry,", $FA, $F7
    db $EF, $EE, "please crush him", $EF, $EE, "in battle.", $FA, $F7
    db $EF, $EE, "He's not anyone", $EF, $EE, "special, so you", $FA, $F7
    db $EF, $EE, "can just destroy", $EF, $EE, "him. Promise!", $FA, $F7
    db $EF, $EE, "I really should", $EF, $EE, "get going myself.", $FA, $F7
    db $EF, $EE, "I hope we can meet", $EF, $EE, "again somewhere,", $FA, $F7
    db $EF, $EE, "sometime. OK!", $EF, $EE, "Bye-bye!", $F7
    db $F0

Data_086_6A00:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "A tantalizing", $EF, $EE, "aroma wafted out", $A4, $F7
    db $F0

Data_086_6A3E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But it was locked.", $EF, $EE, $F7
    db $F0

Data_086_6A73:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "Cold water lapped", $EF, $EE, "and rippled.", $F7
    db $F0

Data_086_6AB0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "Meat sizzled on a", $EF, $EE, "skewer.", $F7
    db $F0

Data_086_6AE8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "It was crammed", $EF, $EE, "with treasures.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "loot taken from", $FA, $F7
    db $EF, $EE, "the town.", $EF, $EE, $F7
    db $F0

Data_086_6B5E:: ; heuristic: target of a monotone pointer table; C0
    db $F0
    ds $14A1, $00
