SECTION "Bank 28", ROMX[$4000], BANK[$28]
    db $28

; if wC529 < $DA, BeginStringDisplay with this bank's table; otherwise far-calls Func_097_4001
; 5 call sites from 4 routines (e.g. ShowString_Bank28, GameMode0_Update, Func_010_4AD0, Func_05F_69FB)
; reads: wStringIndex
BeginStringDisplay_Bank28::
Func_028_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $DA
    jr c, Jump_028_400F
    farcall Func_097_4001
    ret

Jump_028_400F::
    ld de, Data_028_4032
    call BeginStringDisplay
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
Func_028_4016:: ; heuristic: follows a terminator; C0
    ld a, [wStringIndex]
    cp a, $DA
    jr c, Jump_028_4024
    farcall Func_097_4010
    ret

Jump_028_4024::
    ld de, Data_028_4032
    call CopyStringToBuffer
    ret

; Func_028_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 1 call site from 1 routine (e.g. Func_00F_40E9)
ShowString_Bank28::
Func_028_402B:: ; address name
    call BeginStringDisplay_Bank28
    call RunStringDisplayToEnd
    ret

Data_028_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_028_4034

Data_028_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_028_41E8
    dw Data_028_42A3
    dw Data_028_42E4
    dw Data_028_4347
    dw Data_028_437B
    dw Data_028_439E
    dw Data_028_4406
    dw Data_028_4471
    dw Data_028_44A1
    dw Data_028_44DB
    dw Data_028_4516
    dw Data_028_4582
    dw Data_028_46A4
    dw Data_028_47B9
    dw Data_028_4845
    dw Data_028_4887
    dw Data_028_48C7
    dw Data_028_4906
    dw Data_028_4940
    dw Data_028_495E
    dw Data_028_4999
    dw Data_028_49DE
    dw Data_028_4A3E
    dw Data_028_4AFE
    dw Data_028_4BB0
    dw Data_028_4BF2
    dw Data_028_4C38
    dw Data_028_4C7E
    dw Data_028_4CB5
    dw Data_028_4D10
    dw Data_028_4D49
    dw Data_028_4E09
    dw Data_028_4E2B
    dw Data_028_4E8D
    dw Data_028_4EAF
    dw Data_028_4F15
    dw Data_028_4F99
    dw Data_028_4FD5
    dw Data_028_5014
    dw Data_028_5049
    dw Data_028_5083
    dw Data_028_50E5
    dw Data_028_5128
    dw Data_028_51A5
    dw Data_028_51C8
    dw Data_028_520D
    dw Data_028_5232
    dw Data_028_524F
    dw Data_028_52BE
    dw Data_028_5308
    dw Data_028_531C
    dw Data_028_5378
    dw Data_028_53E0
    dw Data_028_541E
    dw Data_028_54A2
    dw Data_028_5578
    dw Data_028_55B9
    dw Data_028_55F8
    dw Data_028_5631
    dw Data_028_56B9
    dw Data_028_5727
    dw Data_028_5791
    dw Data_028_57ED
    dw Data_028_584D
    dw Data_028_58CC
    dw Data_028_5955
    dw Data_028_59C0
    dw Data_028_59ED
    dw Data_028_5A2F
    dw Data_028_5A72
    dw Data_028_5AFF
    dw Data_028_5B3E
    dw Data_028_5B9C
    dw Data_028_5BDF
    dw Data_028_5C02
    dw Data_028_5C39
    dw Data_028_5C7E
    dw Data_028_5CA3
    dw Data_028_5CC7
    dw Data_028_5D30
    dw Data_028_5D7A
    dw Data_028_5DBB
    dw Data_028_5DFD
    dw Data_028_5E36
    dw Data_028_5E56
    dw Data_028_5E99
    dw Data_028_5EDB
    dw Data_028_5EDB
    dw Data_028_5EDB
    dw Data_028_5EFD
    dw Data_028_5F43
    dw Data_028_5F66
    dw Data_028_5F8B
    dw Data_028_5FD0
    dw Data_028_6141
    dw Data_028_6163
    dw Data_028_61EC
    dw Data_028_6233
    dw Data_028_626F
    dw Data_028_62DF
    dw Data_028_6322
    dw Data_028_63AC
    dw Data_028_6414
    dw Data_028_645A
    dw Data_028_6495
    dw Data_028_64DF
    dw Data_028_6523
    dw Data_028_6552
    dw Data_028_65FA
    dw Data_028_6620
    dw Data_028_66BB
    dw Data_028_66FC
    dw Data_028_6774
    dw Data_028_67B6
    dw Data_028_67FC
    dw Data_028_686A
    dw Data_028_691E
    dw Data_028_6968
    dw Data_028_69D4
    dw Data_028_6A56
    dw Data_028_6AF5
    dw Data_028_6B33
    dw Data_028_6B79
    dw Data_028_6C73
    dw Data_028_6D24
    dw Data_028_6D46
    dw Data_028_6D92
    dw Data_028_6E04
    dw Data_028_6EE5
    dw Data_028_716B
    dw Data_028_718B
    dw Data_028_71AF
    dw Data_028_71D4
    dw Data_028_721C
    dw Data_028_723F
    dw Data_028_735A
    dw Data_028_73A1
    dw Data_028_73E9
    dw Data_028_747B
    dw Data_028_74C0
    dw Data_028_7510
    dw Data_028_75C8
    dw Data_028_7608
    dw Data_028_7670
    dw Data_028_7696
    dw Data_028_76BC
    dw Data_028_776A
    dw Data_028_77AD
    dw Data_028_780C
    dw Data_028_78CB
    dw Data_028_7913
    dw Data_028_795B
    dw Data_028_799C
    dw Data_028_79FB
    dw Data_028_7A3C
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7AB2
    dw Data_028_7AE9
    dw Data_028_7B56
    dw Data_028_7B88
    dw Data_028_7BB9
    dw Data_028_7C21
    dw Data_028_7C55
    dw Data_028_7C88
    dw Data_028_7CF2
    dw Data_028_7D32
    dw Data_028_7D69
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DFE
    dw Data_028_7E3D
    dw Data_028_7E84
    dw Data_028_7EA3
    dw Data_028_7EE1
    dw Data_028_7F06
    dw Data_028_7F4C
    dw Data_028_7F6F
    dw Data_028_7F97

Data_028_41E8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In the middle of", $F1
    db "the sea in the", $FA, $F7
    db $EF, $EE, "south floats the", $EF, $EE, "island GreatLog.", $FA, $F7
    db $EF, $EE, "To this eternally", $EF, $EE, "warm and natural", $FA, $F7
    db $EF, $EE, "setting, a family", $EF, $EE, "of monster farmers", $FA, $F7
    db $EF, $EE, "was headed to", $EF, $EE, "start a new life", $A4, $F7
    db $F0

Data_028_42A3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0!", $F1
    db "Papa's calling.", $FA, $F7
    db $EF, $EE, "He's at the stern.", $EF, $EE, "Hustle, hustle!", $F7
    db $F0

Data_028_42E4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " There you", $F1
    db "are, big brother!", $FA, $F7
    db $EF, $EE, "Papa's calling at", $EF, $EE, "the stern.", $FA, $F7
    db $EF, $EE, "You"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better go", $EF, $EE, "right away!", $F7
    db $F0

Data_028_4347:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What's wrong,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Papa's calling for", $EF, $EE, "you!", $F7
    db $F0

Data_028_437B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hurry! Papa", $F1
    db "will be angry!", $F7
    db $F0

Data_028_439E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You folks run a", $F1
    db "monster farm?", $FA, $F7
    db $EF, $EE, "We", $42, "e never had", $EF, $EE, "monsters on our", $FA, $F7
    db $EF, $EE, "ship before this.", $EF, $EE, "It's amazing!", $F7
    db $F0

Data_028_4406:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's a spirit", $F1
    db "in GreatLog that's", $FA, $F7
    db $EF, $EE, "famous for getting", $EF, $EE, "into mischief.", $FA, $F7
    db $EF, $EE, "It's named", $A4, $EF, $EE, "Waru something.", $F7
    db $F0

Data_028_4471:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sailing is sure", $EF, $EE, "exhilarating. ", $FA, $F7
    db $EF, $EE, "Right?", $EF, $EE
    db $FF, $F0

Data_028_44A1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good. That's", $F1
    db "good to hear!", $FA, $F7
    db $EF, $EE, "You have got", $EF, $EE, "potential!", $F7
    db $F0

Data_028_44DB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is that so?", $F1
    db "Too bad!", $FA, $F7
    db $EF, $EE, "You'll get used to", $EF, $EE, "it someday.", $F7
    db $F0

Data_028_4516:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We'll soon be", $F1
    db "reaching GreatLog.", $FA, $F7
    db $EF, $EE, "I wonder, what", $EF, $EE, "will it be like?", $FA, $F7
    db $EF, $EE, "Isn't it exciting", $EF, $EE, "my dear child?", $F7
    db $F0

Data_028_4582:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog's King", $F1
    db "asked us to settle", $FA, $F7
    db $EF, $EE, "in the kingdom and", $EF, $EE, "run our farm.", $FA, $F7
    db $EF, $EE, "He recognizes our", $EF, $EE, "worth, wahahah!", $FA, $F7
    db $EF, $EE, "This will be our", $EF, $EE, "new life.", $FA, $F7
    db $EF, $EE, "You're a growing", $EF, $EE, "boy, so I'll need", $FA, $F7
    db $EF, $EE, "you to be reliable", $EF, $EE, "and responsible.", $FA, $F7
    db $EF, $EE, "Do we have an", $EF, $EE, "understanding?", $FA, $F7
    db $EF, $EE, "Good. Stay with", $EF, $EE, "Tara, will you?", $F7
    db $F0

Data_028_46A4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog's King", $F1
    db "asked us to settle", $FA, $F7
    db $EF, $EE, "in the kingdom and", $EF, $EE, "run our farm.", $FA, $F7
    db $EF, $EE, "He recognizes our", $EF, $EE, "worth, wahahah!", $FA, $F7
    db $EF, $EE, "This will be our", $EF, $EE, "new life.", $FA, $F7
    db $EF, $EE, "You're growing up,", $EF, $EE, "so you can't be a", $FA, $F7
    db $EF, $EE, "little baby", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "Do we have an", $EF, $EE, "understanding?", $FA, $F7
    db $EF, $EE, "Good. Play with", $EF, $EE, "Cobi, will you?", $F7
    db $F0

Data_028_47B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When our farm", $F1
    db "gets established", $FA, $F7
    db $EF, $EE, "in the new land,", $EF, $EE, "I'll make life", $FA, $F7
    db $EF, $EE, "easier for mother", $EF, $EE, "and you two.", $FA, $F7
    db $EF, $EE, "We should be in", $EF, $EE, "GreatLog soon.", $F7
    db $F0

Data_028_4845:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Worried about", $F1
    db "your monsters?", $FA, $F7
    db $EF, $EE, "Don't be! They're", $EF, $EE, "being quiet.", $F7
    db $F0

Data_028_4887:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "clean water.", $F7
    db $F0

Data_028_48C7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "Freshly caught", $EF, $EE, "fish were inside.", $F7
    db $F0

Data_028_4906:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0!", $F1
    db "They said GreatLog", $FA, $F7
    db $EF, $EE, "will be in sight", $EF, $EE, "soon.", $F7
    db $F0

Data_028_4940:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Land ho!", $F1
    db "There's GreatLog!", $F7
    db $F0

Data_028_495E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother!", $F1
    db $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog will be", $EF, $EE, "in sight soon.", $F7
    db $F0

Data_028_4999:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "This is a tale of", $F1
    db "children who came", $FA, $F7
    db $EF, $EE, "to the Kingdom of", $EF, $EE, "GreatLog", $A4, $F7
    db $F0

Data_028_49DE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $2C, $36, $37, $28, $31, $90, $3C, $32, $38, $90, $37, $3A
    db $32, $99, $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Quit your horsing", $EF, $EE, "around and go", $FA, $F7
    db $EF, $EE, "help your mother.", $EF, $EE, "Do you hear me?", $F7
    db $F0

Data_028_4A3E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It seems to me", $F1
    db "that the people", $FA, $F7
    db $EF, $EE, "here aren't very", $EF, $EE, "used to seeing", $FA, $F7
    db $EF, $EE, "monsters. We'll", $EF, $EE, "have to make sure", $FA, $F7
    db $EF, $EE, "that they don't go", $EF, $EE, "wander off on", $FA, $F7
    db $EF, $EE, "their own. Anyway,", $EF, $EE, "go help your", $FA, $F7
    db $EF, $EE, "mother.", $EF, $EE, $F7
    db $F0

Data_028_4AFE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Yo, did you", $F1
    db "enjoy the voyage?", $FA, $F7
    db $EF, $EE, "The name's Slash,", $EF, $EE, "glad to know you!", $FA, $F7
    db $EF, $EE, "Slash", $A3, " I guard the", $EF, $EE, "farm here.", $FA, $F7
    db $EF, $EE, "You can consider", $EF, $EE, "me the boss!", $FA, $F7
    db $EF, $EE, "If you need any", $EF, $EE, "advice, I'm here!", $F7
    db $F0

Data_028_4BB0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " If you're", $F1
    db "in need of advice,", $FA, $F7
    db $EF, $EE, "think of me!", $EF, $EE, "I'm the one!", $F7
    db $F0

Data_028_4BF2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There aren't many", $F1
    db "friends here.", $FA, $F7
    db $EF, $EE, "It's lonely for an", $EF, $EE, "ant like me", $A4, $F7
    db $F0

Data_028_4C38:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I accidentally", $F1
    db "went outside.", $FA, $F7
    db $EF, $EE, "People gave me the", $EF, $EE, "eye. Whoopsy.", $F7
    db $F0

Data_028_4C7E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This hay is", $F1
    db "pretty good.", $FA, $F7
    db $EF, $EE, "Maybe I can use", $EF, $EE, "this", $A4, $F7
    db $F0

Data_028_4CB5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "pump.", $FA, $F7
    db $EF, $EE, "It's rusted and", $EF, $EE, "old, but it looks", $FA, $F7
    db $EF, $EE, "to be in working", $EF, $EE, "condition.", $F7
    db $F0

Data_028_4D10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It is full of", $EF, $EE, "dried hay.", $F7
    db $F0

Data_028_4D49:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e come at", $F1
    db "the right time.", $FA, $F7
    db $EF, $EE, "Grandma sent her", $EF, $EE, "homemade nut pie", $FA, $F7
    db $EF, $EE, "for us to enjoy at", $EF, $EE, "our new homestead.", $FA, $F7
    db $EF, $EE, "I'm too busy to go", $EF, $EE, "get it right now,", $FA, $F7
    db $EF, $EE, "so can the two of", $EF, $EE, "you go instead?", $F7
    db $F0

Data_028_4E09:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Sure, Mama!", $F1
    db "We'll be fine.", $F7
    db $F0

Data_028_4E2B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good, that's", $F1
    db "settled then.", $FA, $F7
    db $EF, $EE, "The Vault is west", $EF, $EE, "of the Farm.", $FA, $F7
    db $EF, $EE, "Don't dawdle, and", $EF, $EE, "be careful.", $F7
    db $F0

Data_028_4E8D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " We'll be OK!", $F1
    db "I'm going too.", $F7
    db $F0

Data_028_4EAF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Go to the Vault", $F1
    db "and pick up the", $FA, $F7
    db $EF, $EE, "nut pie that", $EF, $EE, "Grandma sent.", $FA, $F7
    db $EF, $EE, "The Vault is west", $EF, $EE, "of the Farm.", $F7
    db $F0

Data_028_4F15:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Behavior of Wild", $EF, $EE, "Monsters", $A4, $FA, $F7
    db $EF, $EE, "Wild monsters are", $EF, $EE, "dangerous, but", $FA, $F7
    db $EF, $EE, "they can be tamed", $EF, $EE, "and trained.", $95, $F7
    db $F0

Data_028_4F99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "Children's clothes", $EF, $EE, "were inside.", $F7
    db $F0

Data_028_4FD5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It smelled of sun-", $EF, $EE, "dried laundry.", $F7
    db $F0

Data_028_5014:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "It smelled of", $EF, $EE, "fresh bread.", $F7
    db $F0

Data_028_5049:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "clear water.", $F7
    db $F0

Data_028_5083:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e heard that", $F1
    db "there are monster", $FA, $F7
    db $EF, $EE, "masters in this", $EF, $EE, "kingdom.", $FA, $F7
    db $EF, $EE, "Have I told you", $EF, $EE, "about them?"
    db $FF, $F0

Data_028_50E5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? Well, that's", $F1
    db "fine then.", $FA, $F7
    db $EF, $EE, "Go on, run your", $EF, $EE, "mother's errand.", $F7
    db $F0

Data_028_5128:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monster masters", $F1
    db "are those people", $FA, $F7
    db $EF, $EE, "who tame and train", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "They commune with", $EF, $EE, "them and the", $FA, $F7
    db $EF, $EE, "monsters grow.", $EF, $EE, $F7
    db $F0

Data_028_51A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Hahah! ", $F9, "0", $F1
    db "won't last a day!", $F7
    db $F0

Data_028_51C8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I aspired to be", $F1
    db "one long ago", $A4, $FA, $F7
    db $EF, $EE, "Ahem! Go help your", $EF, $EE, "mother now.", $F7
    db $F0

Data_028_520D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother", $F1
    db "can't do it then.", $F7
    db $F0

Data_028_5232:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Go help your", $F1
    db "mother now.", $F7
    db $F0

Data_028_524F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If some monster", $F1
    db "masters keep their", $FA, $F7
    db $EF, $EE, "monsters with us,", $EF, $EE, "the Farm is sure", $FA, $F7
    db $EF, $EE, "to become busier", $EF, $EE, "and lively.", $F7
    db $F0

Data_028_52BE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Heh, so these", $F1
    db "are the newcomers?", $FA, $F7
    db $EF, $EE, "Hehehe, this is", $EF, $EE, "going to be fun", $A4, $F7
    db $F0

Data_028_5308:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $3F, $32, $31, $AB, $90, $20, $24, $35, $38, $25, $32, $38
    db $99, $F1, $F7, $F0

Data_028_531C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $AB, $90, $37, $2B, $28, $35, $28, $99
    db $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You must be the", $EF, $EE, "farm kids!", $FA, $F7
    db $EF, $EE, "The Vault is west,", $EF, $EE, "then a bit north.", $F7
    db $F0

Data_028_5378:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " It's", $A4, " all", $F1
    db "spinning around", $A4, $FA, $F7
    db $EF, $EE, "That rotten little", $EF, $EE, "Prince and that", $FA, $F7
    db $EF, $EE, "elemental sidekick", $EF, $EE, "of his!", $F7
    db $F0

Data_028_53E0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The horrid", $F1
    db "Prince and that", $FA, $F7
    db $EF, $EE, "elemental sidekick", $EF, $EE, "of his!", $F7
    db $F0

Data_028_541E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King is too", $F1
    db "lenient on Prince", $FA, $F7
    db $EF, $EE, "Kameha, his only", $EF, $EE, "son.", $FA, $F7
    db $EF, $EE, "That's why we can't", $EF, $EE, "complain about all", $FA, $F7
    db $EF, $EE, "the trouble he", $EF, $EE, "causes.", $F7
    db $F0

Data_028_54A2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There were many", $F1
    db "wild monsters in", $FA, $F7
    db $EF, $EE, "this world in the", $EF, $EE, "past.", $FA, $F7
    db $EF, $EE, "The elemental", $EF, $EE, "spirits decided to", $FA, $F7
    db $EF, $EE, "send the monsters", $EF, $EE, "to other worlds", $FA, $F7
    db $EF, $EE, "until they were", $EF, $EE, "sure that humans", $FA, $F7
    db $EF, $EE, "could live safely", $EF, $EE, "with monsters.", $F7
    db $F0

Data_028_5578:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But the chest was", $EF, $EE, "locked tight.", $F7
    db $F0

Data_028_55B9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "A large, salted", $EF, $EE, "fish was inside.", $F7
    db $F0

Data_028_55F8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey! You brats!", $F1
    db "Scram!", $FA, $F7
    db $EF, $EE, "Hands off my", $EF, $EE, "merchandise!", $F7
    db $F0

Data_028_5631:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That weird ape", $F1
    db "thing is Warubou,", $FA, $F7
    db $EF, $EE, "GreatLog's", $EF, $EE, "elemental spirit.", $FA, $F7
    db $EF, $EE, "It's always up to", $EF, $EE, "mischief with", $FA, $F7
    db $EF, $EE, "Prince Kameha.", $EF, $EE, "What a pair!", $F7
    db $F0

Data_028_56B9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This palm tree", $F1
    db "is GreatLog.", $FA, $F7
    db $EF, $EE, "We", $42, "e bored out", $EF, $EE, "the inside of this", $FA, $F7
    db $EF, $EE, "enormous tree and", $EF, $EE, "made it our home.", $F7
    db $F0

Data_028_5727:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're the kids", $F1
    db "from the new farm.", $FA, $F7
    db $EF, $EE, "I'm a monster", $EF, $EE, "master myself.", $FA, $F7
    db $EF, $EE, "I'll have to use", $EF, $EE, "your farm soon.", $F7
    db $F0

Data_028_5791:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We live inside", $F1
    db "here.", $FA, $F7
    db $EF, $EE, "I'm keeping my eyes", $EF, $EE, "out for Prince", $FA, $F7
    db $EF, $EE, "Kameha and his", $EF, $EE, "sidekick.", $F7
    db $F0

Data_028_57ED:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog's major", $F1
    db "facilities are", $FA, $F7
    db $EF, $EE, "situated above", $EF, $EE, "here.", $FA, $F7
    db $EF, $EE, "They're no place", $EF, $EE, "for kids. Shoo!", $F7
    db $F0

Data_028_584D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Inside the well", $F1
    db "is the Log's Navel.", $FA, $F7
    db $EF, $EE, "It's said to be", $EF, $EE, "the center of", $FA, $F7
    db $EF, $EE, "GreatLog.", $EF, $EE, "But it's not safe.", $FA, $F7
    db $EF, $EE, "Don't go in there.", $EF, $EE, $F7
    db $F0

Data_028_58CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " On this island,", $F1
    db "every day goes by", $FA, $F7
    db $EF, $EE, "without anything", $EF, $EE, "being different.", $FA, $F7
    db $EF, $EE, "But it's never", $EF, $EE, "boring.", $FA, $F7
    db $EF, $EE, "I consider it", $EF, $EE, "heavenly luxury!", $F7
    db $F0

Data_028_5955:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Warubou is the", $F1
    db "island's spirit.", $FA, $F7
    db $EF, $EE, "So we can't really", $EF, $EE, "complain about", $FA, $F7
    db $EF, $EE, "all the mischief", $EF, $EE, "it gets into", $A4, $F7
    db $F0

Data_028_59C0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Danger!", $EF, $EE, "Stay clear!", $95, $F7
    db $F0

Data_028_59ED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "odd object.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "plugging a hole", $A4, $F7
    db $F0

Data_028_5A2F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "peculiar door.", $FA, $F7
    db $EF, $EE, "It has an oddly", $EF, $EE, "shaped keyhole", $A4, $F7
    db $F0

Data_028_5A72:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You must be the", $F1
    db "farm kids.", $FA, $F7
    db $EF, $EE, "Your grandma sent", $EF, $EE, "a package for you.", $FA, $F7
    db $EF, $EE, "It smells really", $EF, $EE, "delicious!", $FA, $F7
    db $EF, $EE, "Here you go! Be", $EF, $EE, "careful with it!", $F7
    db $F0

Data_028_5AFF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thanks for", $F1
    db "coming by.", $FA, $F7
    db $EF, $EE, "I'll always be", $EF, $EE, "here to serve you!", $F7
    db $F0

Data_028_5B3E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "notice.", $FA, $F7
    db $EF, $EE, $95, "We guarantee the", $EF, $EE, "safekeeping of", $FA, $F7
    db $EF, $EE, "your precious", $EF, $EE, "items and money!", $95, $F7
    db $F0

Data_028_5B9C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm Prince Kameha", $EF, $EE, "of GreatLog!", $FA, $F7
    db $EF, $EE, "You may not pass,", $EF, $EE, "peasants!", $F7
    db $F0

Data_028_5BDF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wahahah!", $F1
    db "No going by me!", $F7
    db $F0

Data_028_5C02:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm Warubou,", $F1
    db "GreatLog's spirit!", $FA, $F7
    db $EF, $EE, "Warooh, wa-hey!", $EF, $EE, $F7
    db $F0

Data_028_5C39:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " It's a", $F1
    db "dead end, warooh!", $FA, $F7
    db $EF, $EE, "Look for another", $EF, $EE, "way, wa-hey!", $F7
    db $F0

Data_028_5C7E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you heard", $F1
    db "about Magic Keys?"
    db $FF, $F0

Data_028_5CA3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wow, you kids", $F1
    db "sure learn quick!", $F7
    db $F0

Data_028_5CC7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You need Magic", $F1
    db "Keys to open the", $FA, $F7
    db $EF, $EE, "magical door to", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "That's where I get", $EF, $EE, "my monsters.", $F7
    db $F0

Data_028_5D30:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Give me something!", $FA, $F7
    db $EF, $EE, "Then, I'll let you", $EF, $EE, "pass, warooh!", $F7
    db $F0

Data_028_5D7A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wha", $A4, "?", $F1
    db "I smell something!", $FA, $F7
    db $EF, $EE, "I smell something", $EF, $EE, "tasty.", $F7
    db $F0

Data_028_5DBB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " What is", $F1
    db "this? Food?", $FA, $F7
    db $EF, $EE, "Perfect! I was", $EF, $EE, "hungry, wa-hey!", $F7
    db $F0

Data_028_5DFD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh my, the well", $F1
    db "isn't safe!", $FA, $F7
    db $EF, $EE, "Don't be like", $EF, $EE, "Warubou!", $F7
    db $F0

Data_028_5E36:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I'm starving!", $F7
    db $F0

Data_028_5E56:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Gimme it!", $F1
    db "You just ate!", $FA, $F7
    db $EF, $EE, "You grubby little", $EF, $EE, "elemental!", $F7
    db $F0

Data_028_5E99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Some prince!", $FA, $F7
    db $EF, $EE, "Dirty mouth!", $EF, $EE, "Come on, warooh!", $F7
    db $F0

Data_028_5EDB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's ours!", $F1
    db "Give it back!", $F7
    db $F0

Data_028_5EFD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-wa-wa-", $F1
    db "wa-wa-hey!", $FA, $F7
    db $EF, $EE, "The Log's Navel's", $EF, $EE, "breached, warooh!", $F7
    db $F0

Data_028_5F43:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I", $A4, " It", $A4, $F1
    db "It's not my fault!", $F7
    db $F0

Data_028_5F66:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "It's the only way!", $F7
    db $F0

Data_028_5F8B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Warooh!", $F1
    db "Will it hold?", $FA, $F7
    db $EF, $EE, "You two, come here", $EF, $EE, "now, warooh!", $F7
    db $F0

Data_028_5FD0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Calm down", $F1
    db "and listen!", $FA, $F7
    db $EF, $EE, "What came out of", $EF, $EE, "the hole now, that", $FA, $F7
    db $EF, $EE, "was the life force", $EF, $EE, "of GreatLog's tree.", $FA, $F7
    db $EF, $EE, "GreatLog is an", $EF, $EE, "island kept afloat", $FA, $F7
    db $EF, $EE, "by the palm tree,", $EF, $EE, "do you see?", $FA, $F7
    db $EF, $EE, "If the palm tree", $EF, $EE, "dies, the island", $FA, $F7
    db $EF, $EE, "sinks into the", $EF, $EE, "deep, deep ocean.", $FA, $F7
    db $EF, $EE, "A plug! That is", $EF, $EE, "what we need!", $FA, $F7
    db $EF, $EE, "A plug to plug the", $EF, $EE, "Log's Navel!", $FA, $F7
    db $EF, $EE, "Hurry, go fetch a", $EF, $EE, "monster master!", $F7
    db $F0

Data_028_6141:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " That's ours!", $F1
    db "Give it back!", $F7
    db $F0

Data_028_6163:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " A new", $F1
    db "plug for the", $FA, $F7
    db $EF, $EE, "Log's Navel needs", $EF, $EE, "a monster master", $FA, $F7
    db $EF, $EE, "to find, yes it", $EF, $EE, "does, warooh!", $FA, $F7
    db $EF, $EE, "Quick, fetch a", $EF, $EE, "monster master!", $F7
    db $F0

Data_028_61EC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hah? The island's", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "You shouldn't lie", $EF, $EE, "like that ", $F9, "0.", $F7
    db $F0

Data_028_6233:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Why won't you", $F1
    db "believe us?", $FA, $F7
    db $EF, $EE, "You stubborn old", $EF, $EE, "goat!", $F7
    db $F0

Data_028_626F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Look, an island", $F1
    db "just doesn't sink.", $FA, $F7
    db $EF, $EE, "Listen to yourself", $EF, $EE, "for a moment.", $FA, $F7
    db $EF, $EE, "Anyway, did you", $EF, $EE, "run Mom's errand?", $F7
    db $F0

Data_028_62DF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Why aren't", $F1
    db "you listening?", $FA, $F7
    db $EF, $EE, "Papa, you're such", $EF, $EE, "a blockhead!", $F7
    db $F0

Data_028_6322:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island's", $F1
    db "sinking, right.", $FA, $F7
    db $EF, $EE, "Not you too.", $EF, $EE, "Look, I'm busy.", $FA, $F7
    db $EF, $EE, "Warubou and the", $EF, $EE, "Prince are just", $FA, $F7
    db $EF, $EE, "pulling your legs,", $EF, $EE, "I'm sure of it.", $F7
    db $F0

Data_028_63AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " The island's", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "That's a genuine", $EF, $EE, "crisis!", $FA, $F7
    db $EF, $EE, "I'm right here if", $EF, $EE, "you need any help!", $F7
    db $F0

Data_028_6414:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This island is", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "I", $A4, " The tide seems", $EF, $EE, "to be higher!", $F7
    db $F0

Data_028_645A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We're going to", $F1
    db "sink?", $FA, $F7
    db $EF, $EE, "I can't swim!", $EF, $EE, "What should I do?", $F7
    db $F0

Data_028_6495:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Huh? The island", $F1
    db "is going to sink?", $FA, $F7
    db $EF, $EE, "Are you in Prince", $EF, $EE, "Kameha's gang?", $F7
    db $F0

Data_028_64DF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Prince Kameha", $F1
    db "was saying the", $FA, $F7
    db $EF, $EE, "same thing a", $EF, $EE, "little while ago.", $F7
    db $F0

Data_028_6523:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you get", $F1
    db "the package", $FA, $F7
    db $EF, $EE, "from grandma?", $EF, $EE, $F7
    db $F0

Data_028_6552:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh goodness,", $F1
    db "you're filthy!", $FA, $F7
    db $EF, $EE, "What happened to", $EF, $EE, "you two?", $FA, $F7
    db $EF, $EE, $A4, "Giggle", $A4, " You were", $EF, $EE, "tricked by that", $FA, $F7
    db $EF, $EE, "silly Warubou.", $EF, $EE, "Don't worry.", $FA, $F7
    db $EF, $EE, "The island won't", $EF, $EE, "sink that easily.", $F7
    db $F0

Data_028_65FA:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can go out,", $F1
    db "but not too late!", $F7
    db $F0

Data_028_6620:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island's", $EF, $EE, "going to sink?", $FA, $F7
    db $EF, $EE, "I know, you were", $EF, $EE, "fooled by Warubou.", $FA, $F7
    db $EF, $EE, "Last time he was", $EF, $EE, "yelling about the", $FA, $F7
    db $EF, $EE, "great King of", $EF, $EE, "Terror from the", $FA, $F7
    db $EF, $EE, "sky", $A4, $EF, $EE, $F7
    db $F0

Data_028_66BB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island is", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "Prince Kameha put", $EF, $EE, "you up to this.", $F7
    db $F0

Data_028_66FC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $3C, $32, $38, $90, $2E, $2C, $27, $36, $99
    db $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You shouldn't be", $EF, $EE, "in the well.", $FA, $F7
    db $EF, $EE, "What? The Log's", $EF, $EE, "Navel is broken?", $FA, $F7
    db $EF, $EE, "But why is that", $EF, $EE, "important?", $F7
    db $F0

Data_028_6774:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island isn't", $F1
    db "sinking.", $FA, $F7
    db $EF, $EE, "If you lie, your", $EF, $EE, "nose will grow!", $F7
    db $F0

Data_028_67B6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Looking for a", $F1
    db "monster master?", $FA, $F7
    db $EF, $EE, "I have no time for", $EF, $EE, "child's play!", $F7
    db $F0

Data_028_67FC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This island is", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "If that's true,", $EF, $EE, "it's a disaster", $A4, $FA, $F7
    db $EF, $EE, "But I haven't", $EF, $EE, "heard anything", $FA, $F7
    db $EF, $EE, "about it!", $EF, $EE, $F7
    db $F0

Data_028_686A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm? Warubou", $F1
    db "wants you to find", $FA, $F7
    db $EF, $EE, "a monster master", $EF, $EE, "for him?", $FA, $F7
    db $EF, $EE, "Well I am one but", $EF, $EE, "I don't want to", $FA, $F7
    db $EF, $EE, "have anything to", $EF, $EE, "do with Warubou.", $FA, $F7
    db $EF, $EE, "Sorry, but can you", $EF, $EE, "try someone else?", $F7
    db $F0

Data_028_691E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're after a", $F1
    db "monster master?", $FA, $F7
    db $EF, $EE, "I saw one lolling", $EF, $EE, "around the Vault.", $F7
    db $F0

Data_028_6968:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island's", $F1
    db "going to sink?", $FA, $F7
    db $EF, $EE, "Don't spread silly", $EF, $EE, "rumors like that.", $FA, $F7
    db $EF, $EE, "What if it scares", $EF, $EE, "off customers?", $F7
    db $F0

Data_028_69D4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island is", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "Hahah, no worries!", $EF, $EE, "We can all escape", $FA, $F7
    db $EF, $EE, "to another world.", $EF, $EE, "Wait a sec", $A4, " How", $FA, $F7
    db $EF, $EE, "would we get", $EF, $EE, "there?", $F7
    db $F0

Data_028_6A56:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island's", $F1
    db "sinking?", $FA, $F7
    db $EF, $EE, "That's hard to", $EF, $EE, "believe, but", $A4, $FA, $F7
    db $EF, $EE, "You don't look like", $EF, $EE, "a liar", $A4, $FA, $F7
    db $EF, $EE, "I was going to", $EF, $EE, "open a shop here,", $FA, $F7
    db $EF, $EE, "but I guess I'll", $EF, $EE, "hit the road.", $F7
    db $F0

Data_028_6AF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's pointless", $F1
    db "if you're dead.", $FA, $F7
    db $EF, $EE, "I'm going to leave", $EF, $EE, "again.", $F7
    db $F0

Data_028_6B33:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You say the", $F1
    db "island will sink?", $FA, $F7
    db $EF, $EE, "Sorry, but I can't", $EF, $EE, "believe that.", $F7
    db $F0

Data_028_6B79:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, you're back.", $FA, $F7
    db $EF, $EE, "You told everyone", $EF, $EE, "GreatLog'll sink?", $FA, $F7
    db $EF, $EE, "So, where is the", $EF, $EE, "monster master?", $FA, $F7
    db $EF, $EE, $A4, "What? Nobody", $EF, $EE, "believed you?", $FA, $F7
    db $EF, $EE, "Warooh, they are", $EF, $EE, "so complacent!", $FA, $F7
    db $EF, $EE, "Wa-hey, it can't", $EF, $EE, "be helped now.", $FA, $F7
    db $EF, $EE, "You go instead.", $EF, $EE, "No other way!", $F7
    db $F0

Data_028_6C73:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " No time", $F1
    db "to waste, warooh!", $FA, $F7
    db $EF, $EE, "If you don't go,", $EF, $EE, "GreatLog goes to", $FA, $F7
    db $EF, $EE, "the bottom of the", $EF, $EE, "sea soon enough!", $FA, $F7
    db $EF, $EE, "You will go find a", $EF, $EE, "new plug for the", $FA, $F7
    db $EF, $EE, "Log's Navel,", $EF, $EE, "wa-hey?"
    db $FF, $F0

Data_028_6D24:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " No?", $F1
    db "Then find someone!", $F7
    db $F0

Data_028_6D46:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "No one believed!", $FA, $F7
    db $EF, $EE, "You have to go, no", $EF, $EE, "choice about it!", $F7
    db $F0

Data_028_6D92:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "No more dawdling!", $FA, $F7
    db $EF, $EE, "GreatLog will sink", $EF, $EE, "into the sea!", $FA, $F7
    db $EF, $EE, "You have to go, no", $EF, $EE, "choice about it!"
    db $FF, $F0

Data_028_6E04:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, good, good!", $FA, $F7
    db $EF, $EE, "In you, I saw the", $EF, $EE, "potential, warooh!", $FA, $F7
    db $EF, $EE, "A good idea I have", $EF, $EE, "for plugging up", $FA, $F7
    db $EF, $EE, "the Log's Navel,", $EF, $EE, "yes I do, warooh.", $FA, $F7
    db $EF, $EE, "I'm an elemental", $EF, $EE, "so I know such!", $FA, $F7
    db $EF, $EE, "Here, take this,", $EF, $EE, "you, warooh.", $F7
    db $F0

Data_028_6EE5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " This here", $F1
    db "is a Magic Key.", $FA, $F7
    db $EF, $EE, "It opens the door", $EF, $EE, "to other worlds.", $FA, $F7
    db $EF, $EE, "Specially made it", $EF, $EE, "is, by elemental", $FA, $F7
    db $EF, $EE, "power, making it", $EF, $EE, "magic, warooh.", $FA, $F7
    db $EF, $EE, "Use to open the", $EF, $EE, "magic door ahead.", $FA, $F7
    db $EF, $EE, "It takes you to", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "Another world, it", $EF, $EE, "might be, warooh,", $FA, $F7
    db $EF, $EE, "but it is not much", $EF, $EE, "different.", $FA, $F7
    db $EF, $EE, "Only difference is", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Monsters live in", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "But a monster", $EF, $EE, "master needs to", $FA, $F7
    db $EF, $EE, "fear not a thing,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "I see you have", $EF, $EE, "great potential.", $FA, $F7
    db $EF, $EE, "You go to other", $EF, $EE, "worlds, and bring", $FA, $F7
    db $EF, $EE, "back a plug for", $EF, $EE, "the Log's Navel.", $FA, $F7
    db $EF, $EE, "That something, I", $EF, $EE, "don't know what.", $FA, $F7
    db $EF, $EE, "But you will know", $EF, $EE, "when you find it!", $FA, $F7
    db $EF, $EE, "Now, warooh, take", $EF, $EE, "this!", $F7
    db $F0

Data_028_716B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Oasis Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_028_718B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I trust you! Go!", $F7
    db $F0

Data_028_71AF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Forgot something!", $F7
    db $F0

Data_028_71D4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " This you", $F1
    db "use to come back", $FA, $F7
    db $EF, $EE, "to GreatLog from", $EF, $EE, "other worlds.", $F7
    db $F0

Data_028_721C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "GreatLog Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_028_723F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Dangerous", $F1
    db "are other worlds!", $FA, $F7
    db $EF, $EE, "So you take", $EF, $EE, "monsters, warooh.", $FA, $F7
    db $EF, $EE, "Wa-hey, I'm", $EF, $EE, "GreatLog's spirit.", $FA, $F7
    db $EF, $EE, "One with the", $EF, $EE, "island I am.", $FA, $F7
    db $EF, $EE, "If you can't stop", $EF, $EE, "the island from", $FA, $F7
    db $EF, $EE, "sinking, so ends", $EF, $EE, "my life, warooh.", $FA, $F7
    db $EF, $EE, "Not just me, but", $EF, $EE, "everyone here.", $FA, $F7
    db $EF, $EE, "So, you must!", $EF, $EE, "Must find a plug!", $F7
    db $F0

Data_028_735A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " This is bad.", $F1
    db "What'll we do?", $FA, $F7
    db $EF, $EE, "Let's go home and", $EF, $EE, "talk about it.", $F7
    db $F0

Data_028_73A1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Oh, wow.", $F1
    db "This is terrible.", $FA, $F7
    db $EF, $EE, "We should talk", $EF, $EE, "about it at home.", $F7
    db $F0

Data_028_73E9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " If we don't", $F1
    db "find a plug for", $FA, $F7
    db $EF, $EE, "the Log's Navel,", $EF, $EE, "the island sinks.", $FA, $F7
    db $EF, $EE, "Our house and the", $EF, $EE, "farm too.", $FA, $F7
    db $EF, $EE, "We have to go look", $EF, $EE, "ourselves, right?", $F7
    db $F0

Data_028_747B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " But if we", $F1
    db "both go to other", $FA, $F7
    db $EF, $EE, "worlds, Mama will", $EF, $EE, "be worried.", $F7
    db $F0

Data_028_74C0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's true", $A4, $F1
    db "If we both went to", $FA, $F7
    db $EF, $EE, "other worlds, Mama", $EF, $EE, "would be worried.", $F7
    db $F0

Data_028_7510:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " Hey, why", $F1
    db "the long faces?", $FA, $F7
    db $EF, $EE, "I couldn't help", $EF, $EE, "overhearing you.", $FA, $F7
    db $EF, $EE, "I'll go with you", $EF, $EE, "to other worlds.", $FA, $F7
    db $EF, $EE, "That way, one of", $EF, $EE, "you can stay here.", $FA, $F7
    db $EF, $EE, "That solves your", $EF, $EE, "little problem!", $F7
    db $F0

Data_028_75C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's true.", $F1
    db "What to do", $A4, $FA, $F7
    db $EF, $EE, "Huh? ", $F9, "0?", $EF, $EE, "Do you want to go?"
    db $FF, $F0

Data_028_7608:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Don't waste", $F1
    db "your time lying.", $FA, $F7
    db $EF, $EE, "I can see it in", $EF, $EE, "your eyes.", $FA, $F7
    db $EF, $EE, "You really want to", $EF, $EE, "go, don't you?"
    db $FF, $F0

Data_028_7670:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Fine. But", $F1
    db $F9, "0, by", $FA, $F7
    db $EF, $EE, "yourself", $A4, $F7
    db $F0

Data_028_7696:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " Don't worry!", $F1
    db "I'm riding along!", $F7
    db $F0

Data_028_76BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " And ", $F9, "0", $F1
    db "has potential,", $FA, $F7
    db $EF, $EE, "I think, to be a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "We'll need the", $EF, $EE, "help of monsters", $FA, $F7
    db $EF, $EE, "when we go to", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "So that potential", $EF, $EE, "will help a lot!", $F7
    db $F0

Data_028_776A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Fine, ", $F9, "0.", $F1
    db "It's up to you.", $FA, $F7
    db $EF, $EE, "You do your best", $EF, $EE, "and save us!", $F7
    db $F0

Data_028_77AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Slash", $A3, " That's", $F1
    db "settled, then!", $FA, $F7
    db $EF, $EE, "We'll leave", $EF, $EE, "tomorrow morning.", $FA, $F7
    db $EF, $EE, "Get plenty of rest", $EF, $EE, "tonight!", $F7
    db $F0

Data_028_780C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " If we don't", $F1
    db "go find something", $FA, $F7
    db $EF, $EE, "to put in the Log's", $EF, $EE, "Navel, this house,", $FA, $F7
    db $EF, $EE, "the farm and", $EF, $EE, "everything else", $FA, $F7
    db $EF, $EE, "will sink with the", $EF, $EE, "island.", $FA, $F7
    db $EF, $EE, "So we have to go", $EF, $EE, "to other worlds,", $FA, $F7
    db $EF, $EE, "right?"
    db $FF, $F0

Data_028_78CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " But if we", $F1
    db "both went, Mama", $FA, $F7
    db $EF, $EE, "would be really", $EF, $EE, "worried about us.", $F7
    db $F0

Data_028_7913:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Oh", $A4, " If we", $F1
    db "both went, Mama", $FA, $F7
    db $EF, $EE, "would be really", $EF, $EE, "worried about us.", $F7
    db $F0

Data_028_795B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0, you", $F1
    db "want to go.", $FA, $F7
    db $EF, $EE, $F9, "0, do you want", $EF, $EE, "me to stay home?"
    db $FF, $F0

Data_028_799C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You don't", $F1
    db "have to lie.", $FA, $F7
    db $EF, $EE, "We'll be all right", $EF, $EE, "here.", $FA, $F7
    db $EF, $EE, "You do really want", $EF, $EE, "to go, right?"
    db $FF, $F0

Data_028_79FB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " But ", $F9, "0,", $F1
    db "what about your", $FA, $F7
    db $EF, $EE, "terrible sense of", $EF, $EE, "direction?", $F7
    db $F0

Data_028_7A3C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Then it's", $F1
    db "your job, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "Make me proud, big", $EF, $EE, "brother!", $F7
    db $F0

Data_028_7A7B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, $F9, "Y.", $F7
    db $F0

Data_028_7AB2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty", $A4, $EF, $EE, $F7
    db $F0

Data_028_7AE9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 found the", $EF, $EE, $F9, "Y.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, $F9, "Y back.", $F7
    db $F0

Data_028_7B56:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, $F9, "Y.", $F7
    db $F0

Data_028_7B88:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Data_028_7BB9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, $F9, "0 found the", $EF, $EE, $F9, "Y.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, $F9, "Y back.", $F7
    db $F0

Data_028_7C21:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, $F9, "Y.", $F7
    db $F0

Data_028_7C55:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Data_028_7C88:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, $F9, "0 found the", $EF, $EE, $F9, "Y.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, $F9, "Y back.", $F7
    db $F0

Data_028_7CF2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained a", $EF, $EE, "Magic Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_028_7D32:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty", $A4, $EF, $EE, $F7
    db $F0

Data_028_7D69:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 found a", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

Data_028_7DDF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let's see how", $F1
    db "good you are!", $F7
    db $F0

Data_028_7DFE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You think you", $F1
    db "could win?", $FA, $F7
    db $EF, $EE, "Dream on, you", $EF, $EE, "insolent fools!", $F7
    db $F0

Data_028_7E3D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $2F, $AB, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " never", $F1
    db "expected you here.", $FA, $F7
    db $EF, $EE, "But this shall be", $EF, $EE, "your tomb!", $F7
    db $F0

Data_028_7E84:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Prepare to be", $F1
    db "overwhelmed!", $F7
    db $F0

Data_028_7EA3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Those monsters", $F1
    db "are my foes?", $FA, $F7
    db $EF, $EE, "Fwahahaha!", $EF, $EE, "How ludicrous!", $F7
    db $F0

Data_028_7EE1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you win, you", $F1
    db "can be the boss!", $F7
    db $F0

Data_028_7F06:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll show you how", $F1
    db "small you are in", $FA, $F7
    db $EF, $EE, "the grand scheme", $EF, $EE, "of things!", $F7
    db $F0

Data_028_7F4C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm? My rival is", $F1
    db "here? Come on!", $F7
    db $F0

Data_028_7F6F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Finally, someone", $F1
    db "to ignite my soul!", $F7
    db $F0

Data_028_7F97:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I feel your", $F1
    db "strength", $A4, $FA, $F7
    db $EF, $EE, "This will be a", $EF, $EE, "long battle.", $F7
    db $F0
    ds $2F, $00
