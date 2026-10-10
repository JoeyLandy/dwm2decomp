SECTION "Bank 29", ROMX[$4000], BANK[$29]
    db $29

; 3 call sites from 3 routines (e.g. GameMode0_Update_Table2_Case03, Func_010_4AD0_Case01, Func_05F_69FB_Case01)
; reads: wStringIndex
Func_029_4001::
    ld a, [wStringIndex]
    cp a, $8E
    jr c, Jump_029_400F
    farcall Func_097_4026
    ret

Jump_029_400F::
    ld de, Data_029_4032
    call BeginStringDisplay
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
Func_029_4016:: ; heuristic: follows a terminator; C0
    ld a, [wStringIndex]
    cp a, $8E
    jr c, Jump_029_4024
    farcall Func_097_4035
    ret

Jump_029_4024::
    ld de, Data_029_4032
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_029_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_029_4034

Data_029_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_029_4150
    dw Data_029_4191
    dw Data_029_41A7
    dw Data_029_4200
    dw Data_029_4273
    dw Data_029_4303
    dw Data_029_4401
    dw Data_029_441B
    dw Data_029_44A7
    dw Data_029_4507
    dw Data_029_4572
    dw Data_029_45FD
    dw Data_029_464A
    dw Data_029_468C
    dw Data_029_4735
    dw Data_029_4755
    dw Data_029_4801
    dw Data_029_4841
    dw Data_029_4866
    dw Data_029_49E8
    dw Data_029_4A0B
    dw Data_029_4A6E
    dw Data_029_4AD4
    dw Data_029_4B19
    dw Data_029_4B83
    dw Data_029_4BE0
    dw Data_029_4C70
    dw Data_029_4CFA
    dw Data_029_4D3E
    dw Data_029_4E1B
    dw Data_029_4E3C
    dw Data_029_4EF6
    dw Data_029_4F32
    dw Data_029_4F54
    dw Data_029_5020
    dw Data_029_5020
    dw Data_029_5020
    dw Data_029_5020
    dw Data_029_5065
    dw Data_029_50AD
    dw Data_029_5136
    dw Data_029_517D
    dw Data_029_51C6
    dw Data_029_5242
    dw Data_029_52F9
    dw Data_029_5444
    dw Data_029_54C5
    dw Data_029_54C5
    dw Data_029_54C5
    dw Data_029_54EA
    dw Data_029_5556
    dw Data_029_559E
    dw Data_029_560D
    dw Data_029_5671
    dw Data_029_56BB
    dw Data_029_570A
    dw Data_029_5745
    dw Data_029_57D5
    dw Data_029_583F
    dw Data_029_5865
    dw Data_029_5940
    dw Data_029_59AE
    dw Data_029_5A13
    dw Data_029_5A9F
    dw Data_029_5B4D
    dw Data_029_5B93
    dw Data_029_5C03
    dw Data_029_5CB3
    dw Data_029_5D21
    dw Data_029_5D81
    dw Data_029_5DA7
    dw Data_029_5E31
    dw Data_029_5E74
    dw Data_029_5F59
    dw Data_029_601B
    dw Data_029_6129
    dw Data_029_622E
    dw Data_029_6299
    dw Data_029_6327
    dw Data_029_638E
    dw Data_029_63CC
    dw Data_029_6437
    dw Data_029_6480
    dw Data_029_64C9
    dw Data_029_65A0
    dw Data_029_65EE
    dw Data_029_6665
    dw Data_029_668A
    dw Data_029_66D8
    dw Data_029_6722
    dw Data_029_6791
    dw Data_029_6820
    dw Data_029_685F
    dw Data_029_68A3
    dw Data_029_6955
    dw Data_029_6995
    dw Data_029_69D7
    dw Data_029_6A40
    dw Data_029_6BE2
    dw Data_029_6C4B
    dw Data_029_6C83
    dw Data_029_6CC4
    dw Data_029_6D0A
    dw Data_029_6D52
    dw Data_029_6DB5
    dw Data_029_6E41
    dw Data_029_6ED9
    dw Data_029_6F1E
    dw Data_029_6F62
    dw Data_029_7028
    dw Data_029_70C0
    dw Data_029_712A
    dw Data_029_7171
    dw Data_029_7208
    dw Data_029_7292
    dw Data_029_72FA
    dw Data_029_731D
    dw Data_029_73AC
    dw Data_029_73F5
    dw Data_029_74D9
    dw Data_029_753F
    dw Data_029_75A5
    dw Data_029_764F
    dw Data_029_769A
    dw Data_029_7700
    dw Data_029_7745
    dw Data_029_77F4
    dw Data_029_785F
    dw Data_029_78A8
    dw Data_029_7934
    dw Data_029_79E6
    dw Data_029_7A07
    dw Data_029_7A51
    dw Data_029_7AAE
    dw Data_029_7B57
    dw Data_029_7BC2
    dw Data_029_7C89
    dw Data_029_7D09
    dw Data_029_7D24
    dw Data_029_7DFE
    dw Data_029_7E18
    dw Data_029_7E31

Data_029_4150:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Are you going", $F1
    db "out to play?", $FA, $F7
    db $EF, $EE, "Be careful you", $EF, $EE, "don't get hurt.", $F7
    db $F0

Data_029_4191:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received an", $F1
    db "Herb.", $F7
    db $F0

Data_029_41A7:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's a beautiful", $F1
    db "day for laundry!", $FA, $F7
    db $EF, $EE, "You shouldn't be", $EF, $EE, "inside on a day", $FA, $F7
    db $EF, $EE, "like this!", $EF, $EE, $F7
    db $F0

Data_029_4200:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, while", $F1
    db "you're gone, I'll", $FA, $F7
    db $EF, $EE, "stay here and tend", $EF, $EE, "to the monsters.", $FA, $F7
    db $EF, $EE, "If you catch any,", $EF, $EE, "I'll care for them.", $F7
    db $F0

Data_029_4273:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother,", $F1
    db "while you're in", $FA, $F7
    db $EF, $EE, "another world,", $EF, $EE, "I'll stay here.", $FA, $F7
    db $EF, $EE, "I'll look after", $EF, $EE, "your monsters,", $FA, $F7
    db $EF, $EE, "so be sure to send", $EF, $EE, "them back to me.", $F7
    db $F0

Data_029_4303:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Why do you have", $F1
    db "a monster in tow?", $FA, $F7
    db $EF, $EE, "Are you going to", $EF, $EE, "become a master?", $FA, $F7
    db $EF, $EE, "If you are, or if", $EF, $EE, "you're going to", $FA, $F7
    db $EF, $EE, "inherit this farm,", $EF, $EE, "the key is to be", $FA, $F7
    db $EF, $EE, "friendly with", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "To break the ice,", $EF, $EE, "feed them meat.", $FA, $F7
    db $EF, $EE, "That will make", $EF, $EE, "them less wary.", $F7
    db $F0

Data_029_4401:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $EF, $EE, "PorkChop.", $F7
    db $F0

Data_029_441B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " To win the trust", $F1
    db "of monsters, feed", $FA, $F7
    db $EF, $EE, "them some meat", $EF, $EE, "right away.", $FA, $F7
    db $EF, $EE, "You can battle", $EF, $EE, "them after, and", $FA, $F7
    db $EF, $EE, "rid them of their", $EF, $EE, "wild nature.", $F7
    db $F0

Data_029_44A7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It looks like", $F1
    db "you", $42, "e become", $FA, $F7
    db $EF, $EE, "friends with some", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "That's my ", $F9, "0!", $EF, $EE, "You're talented!", $F7
    db $F0

Data_029_4507:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your monsters", $F1
    db "are your friends", $FA, $F7
    db $EF, $EE, "who will serve you", $EF, $EE, "to the end.", $FA, $F7
    db $EF, $EE, "Be sure to raise", $EF, $EE, "them with love!", $F7
    db $F0

Data_029_4572:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Off to another", $F1
    db "world!", $FA, $F7
    db $EF, $EE, "There are many", $EF, $EE, "items to be found", $FA, $F7
    db $EF, $EE, "just lying around", $EF, $EE, "in other worlds.", $FA, $F7
    db $EF, $EE, "They will help you", $EF, $EE, "on your trek!", $F7
    db $F0

Data_029_45FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A tropical isle", $F1
    db "is too hot for me.", $FA, $F7
    db $EF, $EE, "I might melt and", $EF, $EE, "become a Babble!", $F7
    db $F0

Data_029_464A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, that's cute!", $F1
    db "Hahahahaha!", $FA, $F7
    db $EF, $EE, "We have a new", $EF, $EE, "monster master!", $F7
    db $F0

Data_029_468C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Hi, I'm", $F1
    db "helping Papa to", $FA, $F7
    db $EF, $EE, "take care of the", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You can drop off", $EF, $EE, "or pick up any of", $FA, $F7
    db $EF, $EE, "your monsters here", $EF, $EE, "with me.", $FA, $F7
    db $EF, $EE, "So, what can I do", $EF, $EE, "for you, sis?", $F7
    db $F0

Data_029_4735:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Hi, ", $F9, "0!", $F1
    db "What's up today?", $F7
    db $F0

Data_029_4755:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " I'm helping", $F1
    db "Papa take care of", $FA, $F7
    db $EF, $EE, "the monsters and", $EF, $EE, "the farm.", $FA, $F7
    db $EF, $EE, "You can drop off", $EF, $EE, "or pick up any of", $FA, $F7
    db $EF, $EE, "your monsters here", $EF, $EE, "with me.", $FA, $F7
    db $EF, $EE, "Do you need me for", $EF, $EE, "anything?", $F7
    db $F0

Data_029_4801:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hi!", $F1
    db "How are you?", $FA, $F7
    db $EF, $EE, "Do you need me for", $EF, $EE, "anything today?", $F7
    db $F0

Data_029_4841:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Want to know how", $F1
    db "the farm works?"
    db $FF, $F0

Data_029_4866:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Including the", $F1
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

Data_029_49E8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aww", $A4, " You know", $F1
    db "already? Boring!", $F7
    db $F0

Data_029_4A0B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I haven't seen", $F1
    db "Prince Kameha or", $FA, $F7
    db $EF, $EE, "Warubou today.", $EF, $EE, "I hope they're not", $FA, $F7
    db $EF, $EE, "cooking up new", $EF, $EE, "pranks.", $F7
    db $F0

Data_029_4A6E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am a dealer-", $F1
    db "a merchant who", $FA, $F7
    db $EF, $EE, "buys and sells", $EF, $EE, "useful items.", $FA, $F7
    db $EF, $EE, "Now, come back", $EF, $EE, "with a grownup.", $F7
    db $F0

Data_029_4AD4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have such", $F1
    db "cute monsters!", $FA, $F7
    db $EF, $EE, "Are you playing", $EF, $EE, "monster master?", $F7
    db $F0

Data_029_4B19:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I haven't seen", $F1
    db "Prince Kameha or", $FA, $F7
    db $EF, $EE, "Warubou at all.", $EF, $EE, "Perhaps we won't", $FA, $F7
    db $EF, $EE, "need to post", $EF, $EE, "lookouts anymore.", $F7
    db $F0

Data_029_4B83:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Warubou has gone", $F1
    db "down the well and", $FA, $F7
    db $EF, $EE, "hasn't come back", $EF, $EE, "out yet.", $FA, $F7
    db $EF, $EE, "It's plotting, I", $EF, $EE, "bet.", $F7
    db $F0

Data_029_4BE0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monster masters", $F1
    db "are people who can", $FA, $F7
    db $EF, $EE, "open their hearts", $EF, $EE, "to monsters.", $FA, $F7
    db $EF, $EE, "If you're trying to", $EF, $EE, "become a master,", $FA, $F7
    db $EF, $EE, "treat monsters", $EF, $EE, "with love.", $F7
    db $F0

Data_029_4C70:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Even the most", $F1
    db "ordinary of days", $FA, $F7
    db $EF, $EE, "brings small", $EF, $EE, "changes.", $FA, $F7
    db $EF, $EE, "So long as there", $EF, $EE, "is somewhere you", $FA, $F7
    db $EF, $EE, "can relax, life", $EF, $EE, "isn't all that bad.", $F7
    db $F0

Data_029_4CFA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm? Are you a", $F1
    db "master hopeful?", $FA, $F7
    db $EF, $EE, "Well, aren't you a", $EF, $EE, "cute rival!", $F7
    db $F0

Data_029_4D3E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, hi! Good to", $F1
    db "see you again!", $FA, $F7
    db $EF, $EE, "This is the Vault.", $EF, $EE, "You can keep your", $FA, $F7
    db $EF, $EE, "money and items", $EF, $EE, "safely here.", $FA, $F7
    db $EF, $EE, "You can take them", $EF, $EE, "out anytime too.", $FA, $F7
    db $EF, $EE, "It's free, so feel", $EF, $EE, "free to use us!", $FA, $F7
    db $EF, $EE, "So, how may I", $EF, $EE, "serve you today?", $F7
    db $F0

Data_029_4E1B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How may the", $F1
    db "Vault serve you?", $F7
    db $F0

Data_029_4E3C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If your party is", $F1
    db "wiped out, half", $FA, $F7
    db $EF, $EE, "your money's gone,", $EF, $EE, "just like that.", $FA, $F7
    db $EF, $EE, "But any money in", $EF, $EE, "the Vault is safe.", $FA, $F7
    db $EF, $EE, "Better saved than", $EF, $EE, "sorry, just like", $FA, $F7
    db $EF, $EE, "your Journal.", $EF, $EE, "Travel smart!", $F7
    db $F0

Data_029_4EF6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You remember the", $EF, $EE, "promise you made?"
    db $FF, $F0

Data_029_4F32:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Quit", $F1
    db "dawdling, warooh!", $F7
    db $F0

Data_029_4F54:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Use a", $F1
    db "Magic Key and open", $FA, $F7
    db $EF, $EE, "the Magic Door in", $EF, $EE, "chamber ahead!", $FA, $F7
    db $EF, $EE, "Go to another", $EF, $EE, "world and find", $FA, $F7
    db $EF, $EE, "a plug for the", $EF, $EE, "Log's Navel!", $FA, $F7
    db $EF, $EE, "Use GreatLog Key", $EF, $EE, "to come back.", $FA, $F7
    db $EF, $EE, "That is all!", $EF, $EE, "Hurry, wa-hey!", $F7
    db $F0

Data_029_5020:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "You did it, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "I'll give you", $EF, $EE, "GreatLog's power!", $F7
    db $F0

Data_029_5065:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There,", $F1
    db "your party's fine!", $FA, $F7
    db $EF, $EE, "So, the new plug", $EF, $EE, "for the Navel?", $F7
    db $F0

Data_029_50AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "So, this is it?", $FA, $F7
    db $EF, $EE, "This is the", $EF, $EE, "TidalBell, warooh?", $FA, $F7
    db $EF, $EE, "It exudes an odd", $EF, $EE, "power, yes.", $FA, $F7
    db $EF, $EE, "We'll see if it", $EF, $EE, "works, warooh!", $F7
    db $F0

Data_029_5136:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "That's it!", $FA, $F7
    db $EF, $EE, "GreatLog is saved!", $EF, $EE, "Good, now", $A4, " Warooh?", $F7
    db $F0

Data_029_517D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "No good, no good!", $FA, $F7
    db $EF, $EE, "I have to plug the", $EF, $EE, "Navel again!", $F7
    db $F0

Data_029_51C6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That was no good.", $FA, $F7
    db $EF, $EE, "But TidalBell has", $EF, $EE, "magic in it.", $FA, $F7
    db $EF, $EE, "Give me your hand.", $EF, $EE, "I hold it, and", $A4, $FA, $F7
    db $EF, $EE, "Wa-hey!", $EF, $EE, $F7
    db $F0

Data_029_5242:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Stop that!", $FA, $F7
    db $EF, $EE, "Why do you look so", $EF, $EE, "nasty at me?", $FA, $F7
    db $EF, $EE, "A hero should have", $EF, $EE, "the valor to clean", $FA, $F7
    db $EF, $EE, "up after someone", $EF, $EE, "else's mess!", $FA, $F7
    db $EF, $EE, "Come on, give me a", $EF, $EE, "big smile, warooh!", $F7
    db $F0

Data_029_52F9:: ; heuristic: target of a monotone pointer table; C0
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

Data_029_5444:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Angry still with", $EF, $EE, "me, warooh?", $FA, $F7
    db $EF, $EE, "Anger is no good", $EF, $EE, "between friends!", $FA, $F7
    db $EF, $EE, "We're friends, so", $EF, $EE, "no anger, ", $F9, "0!"
    db $FF, $F0

Data_029_54C5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is Kalka,", $F1
    db "an oasis village.", $F7
    db $F0

Data_029_54EA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A thieving band", $F1
    db "runs amok here.", $FA, $F7
    db $EF, $EE, "It's impossible to", $EF, $EE, "get any decent", $FA, $F7
    db $EF, $EE, "sleep because of", $EF, $EE, "their threat.", $F7
    db $F0

Data_029_5556:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Pardon? A plug", $F1
    db "for a navel?", $FA, $F7
    db $EF, $EE, "Sorry, I have no", $EF, $EE, "idea what that is.", $F7
    db $F0

Data_029_559E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The oasis", $95, " water", $F1
    db "travels through an", $FA, $F7
    db $EF, $EE, "underground canal", $EF, $EE, "to Asiya.", $FA, $F7
    db $EF, $EE, "Asiya? It's a town", $EF, $EE, "that's due south.", $F7
    db $F0

Data_029_560D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The leader of", $F1
    db "the thieves is a", $FA, $F7
    db $EF, $EE, "fearsome man.", $EF, $EE, "He commands horrid", $FA, $F7
    db $EF, $EE, "monsters to rob", $EF, $EE, "people.", $F7
    db $F0

Data_029_5671:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Log's Navel?", $F1
    db "What is that?", $FA, $F7
    db $EF, $EE, "I can show you my", $EF, $EE, "navel on the sly.", $F7
    db $F0

Data_029_56BB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Log's Navel?", $F1
    db "Let me think", $A4, $FA, $F7
    db $EF, $EE, "Perhaps the King", $EF, $EE, "in Asiya will", $F7
    db $EF, $EE, "know.", $EF, $EE, $F7
    db $F0

Data_029_570A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "A sharp, spicy", $EF, $EE, "aroma wafted out.", $F7
    db $F0

Data_029_5745:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The underground", $F1
    db "canal is ahead.", $FA, $F7
    db $EF, $EE, "The last King made", $EF, $EE, "it for our people", $FA, $F7
    db $EF, $EE, "when there were", $EF, $EE, "water shortages.", $FA, $F7
    db $EF, $EE, "It was a hard,", $EF, $EE, "hard task.", $F7
    db $F0

Data_029_57D5:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King called", $F1
    db "a circus troupe to", $FA, $F7
    db $EF, $EE, "the town in the", $EF, $EE, "south.", $FA, $F7
    db $EF, $EE, "I hope they weren't", $EF, $EE, "mauled by thugs.", $F7
    db $F0

Data_029_583F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is Asiya,", $F1
    db "the desert flower.", $F7
    db $F0

Data_029_5865:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our King came", $F1
    db "into an enormous", $FA, $F7
    db $EF, $EE, "inheritance. It", $EF, $EE, "was mind-boggling.", $FA, $F7
    db $EF, $EE, "His treasury is", $EF, $EE, "overflowing with", $FA, $F7
    db $EF, $EE, "incredible gold", $EF, $EE, "and treasures.", $FA, $F7
    db $EF, $EE, "He's said to be", $EF, $EE, "particularly proud", $FA, $F7
    db $EF, $EE, "of something", $EF, $EE, "called TidalBell.", $F7
    db $F0

Data_029_5940:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I saw a lake", $F1
    db "like a mirage.", $FA, $F7
    db $EF, $EE, "In the east of the", $EF, $EE, "desert, it was.", $FA, $F7
    db $EF, $EE, "But it disappeared", $EF, $EE, "as if by magic", $A4, $F7
    db $F0

Data_029_59AE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Strong monsters", $F1
    db "are in the well.", $FA, $F7
    db $EF, $EE, "You"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better be", $EF, $EE, "prepared if you", $FA, $F7
    db $EF, $EE, "are going down in", $EF, $EE, "there.", $F7
    db $F0

Data_029_5A13:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our King has", $F1
    db "been a fan of", $FA, $F7
    db $EF, $EE, "circuses since he", $EF, $EE, "was a child.", $FA, $F7
    db $EF, $EE, "If there is a", $EF, $EE, "circus, he always", $FA, $F7
    db $EF, $EE, "summons the troupe", $EF, $EE, "to the castle.", $F7
    db $F0

Data_029_5A9F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The circus", $F1
    db "master was trying", $FA, $F7
    db $EF, $EE, "to recruit people", $EF, $EE, "at the inn.", $FA, $F7
    db $EF, $EE, "He says the troupe", $EF, $EE, "scattered when the", $FA, $F7
    db $EF, $EE, "thieves set on", $EF, $EE, "them.", $FA, $F7
    db $EF, $EE, "Traveling is much", $EF, $EE, "too risky for me!", $F7
    db $F0

Data_029_5B4D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No one enters", $F1
    db "the castle without", $FA, $F7
    db $EF, $EE, "a proper permit!", $EF, $EE, "Move along!", $F7
    db $F0

Data_029_5B93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you want to", $F1
    db "get in that badly,", $FA, $F7
    db $EF, $EE, "we could arrest", $EF, $EE, "you and toss you", $FA, $F7
    db $EF, $EE, "in the dungeon,", $EF, $EE, "how's that sound?", $F7
    db $F0

Data_029_5C03:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you want", $F1
    db "something, honey?", $FA, $F7
    db $EF, $EE, "A plug for the", $EF, $EE, "Log's Navel?", $FA, $F7
    db $EF, $EE, "Well, the King", $EF, $EE, "likes collecting", $FA, $F7
    db $EF, $EE, "all sorts of odd", $EF, $EE, "things, so he may", $FA, $F7
    db $EF, $EE, "have something", $EF, $EE, "that will work.", $F7
    db $F0

Data_029_5CB3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When we get a", $F1
    db "hot spell, I sleep", $FA, $F7
    db $EF, $EE, "in the daytime,", $EF, $EE, "and work at night.", $FA, $F7
    db $EF, $EE, "That's the only", $EF, $EE, "way of coping!", $F7
    db $F0

Data_029_5D21:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to my", $F1
    db "item shop!", $FA, $F7
    db $EF, $EE, "You may buy or", $EF, $EE, "sell items here.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

Data_029_5D81:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! How may I", $F1
    db "serve you today?", $F7
    db $F0

Data_029_5DA7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The church", $F1
    db "welcomes you.", $FA, $F7
    db $EF, $EE, "We can heal you", $EF, $EE, "from poisoning,", $FA, $F7
    db $EF, $EE, "lift curses, and", $EF, $EE, "revive the dead.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you, my child?", $F7
    db $F0

Data_029_5E31:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am a servant", $F1
    db "to the gods.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you, my child?", $F7
    db $F0

Data_029_5E74:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am the leader", $F1
    db "of a circus.", $FA, $F7
    db $EF, $EE, "We were invited to", $EF, $EE, "perform before the", $FA, $F7
    db $EF, $EE, "King, but my group", $EF, $EE, "has scattered like", $FA, $F7
    db $EF, $EE, "so many leaves in", $EF, $EE, "a storm.", $FA, $F7
    db $EF, $EE, "So, I am the only", $EF, $EE, "one in my circus.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "join me as a star?"
    db $FF, $F0

Data_029_5F59:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you say yes?", $F1
    db "Yes, yes, you did!", $FA, $F7
    db $EF, $EE, "Your monsters will", $EF, $EE, "make a fine act!", $FA, $F7
    db $EF, $EE, "You can have top", $EF, $EE, "billing as our one", $FA, $F7
    db $EF, $EE, "and only fearless", $EF, $EE, "monster master!", $FA, $F7
    db $EF, $EE, "Come, we must go", $EF, $EE, "to the castle!", $F7
    db $F0

Data_029_601B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you say yes?", $F1
    db "Yes, yes, you did!", $FA, $F7
    db $EF, $EE, "Your monsters will", $EF, $EE, "make a fine act!", $FA, $F7
    db $EF, $EE, "You can have top", $EF, $EE, "billing as our one", $FA, $F7
    db $EF, $EE, "and only fearless", $EF, $EE, "monster master!", $FA, $F7
    db $EF, $EE, "But a dead monster", $EF, $EE, "is no good.", $FA, $F7
    db $EF, $EE, "It wouldn't look", $EF, $EE, "good as an act.", $FA, $F7
    db $EF, $EE, "You must get three", $EF, $EE, "healthy monsters.", $F7
    db $F0

Data_029_6129:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Did you say yes?", $F1
    db "Yes, yes, you did!", $FA, $F7
    db $EF, $EE, "Your monsters will", $EF, $EE, "make a fine act!", $FA, $F7
    db $EF, $EE, "You can have top", $EF, $EE, "billing as our one", $FA, $F7
    db $EF, $EE, "and only fearless", $EF, $EE, "monster master!", $FA, $F7
    db $EF, $EE, "But you need a", $EF, $EE, "trio of monsters", $FA, $F7
    db $EF, $EE, "to make the act", $EF, $EE, "work.", $FA, $F7
    db $EF, $EE, "You must get three", $EF, $EE, "healthy monsters.", $F7
    db $F0

Data_029_622E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You close the", $F1
    db "door to stardom?", $FA, $F7
    db $EF, $EE, "That is most", $EF, $EE, "unfortunate.", $FA, $F7
    db $EF, $EE, "If you change your", $EF, $EE, "mind, I'll be here.", $F7
    db $F0

Data_029_6299:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, three", $F1
    db "healthy monsters!", $FA, $F7
    db $EF, $EE, "Very well done!", $EF, $EE, "Bravo to you!", $FA, $F7
    db $EF, $EE, "You are officially", $EF, $EE, "a circus member!", $FA, $F7
    db $EF, $EE, "Come, we must go", $EF, $EE, "to the castle!", $F7
    db $F0

Data_029_6327:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you need a", $F1
    db "trio of monsters", $FA, $F7
    db $EF, $EE, "to make the act", $EF, $EE, "work.", $FA, $F7
    db $EF, $EE, "You must get three", $EF, $EE, "healthy monsters.", $F7
    db $F0

Data_029_638E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "a gooey oil.", $F7
    db $F0

Data_029_63CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I heard that the", $F1
    db "thieves disappear", $FA, $F7
    db $EF, $EE, "as soon as they", $EF, $EE, "get their loot.", $FA, $F7
    db $EF, $EE, "No one's seen", $EF, $EE, "their hideout.", $F7
    db $F0

Data_029_6437:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " And that was the", $F1
    db "firebreather!", $FA, $F7
    db $EF, $EE, "Let's hear it for", $EF, $EE, "this brave soul!", $F7
    db $F0

Data_029_6480:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Next, monsters", $EF, $EE, "will perform some", $FA, $F7
    db $EF, $EE, "amazing, death", $EF, $EE, "defying stunts!", $F7
    db $F0

Data_029_64C9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Very good show!", $F1
    db "That was splendid", $FA, $F7
    db $EF, $EE, "for your debut", $EF, $EE, "performance!", $FA, $F7
    db $EF, $EE, "The audience was", $EF, $EE, "quite pleased.", $FA, $F7
    db $EF, $EE, "We are to stay for", $EF, $EE, "more shows here,", $FA, $F7
    db $EF, $EE, "so we have been", $EF, $EE, "permitted to go", $FA, $F7
    db $EF, $EE, "into the castle by", $EF, $EE, "the King.", $F7
    db $F0

Data_029_65A0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Several of our", $F1
    db "members came back.", $FA, $F7
    db $EF, $EE, "We have enough to", $EF, $EE, "put on our shows.", $F7
    db $F0

Data_029_65EE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When the thieves", $F1
    db "raided us, we ran.", $FA, $F7
    db $EF, $EE, "But while we kept", $EF, $EE, "our lives, we were", $FA, $F7
    db $EF, $EE, "separated from our", $EF, $EE, "circus master.", $F7
    db $F0

Data_029_6665:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wonder if the", $F1
    db "others are safe", $A4, $F7
    db $F0

Data_029_668A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Heh, did you see", $F1
    db "the looks I got", $FA, $F7
    db $EF, $EE, "when I blew fire?", $EF, $EE, "Made me feel good!", $F7
    db $F0

Data_029_66D8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "King's treasury!", $FA, $F7
    db $EF, $EE, "No one, but no one", $EF, $EE, "is allowed inside!", $F7
    db $F0

Data_029_6722:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? See his", $F1
    db "Majesty's treasure?", $FA, $F7
    db $EF, $EE, "What foolishness!", $EF, $EE, "No one gets by me", $FA, $F7
    db $EF, $EE, "without the King's", $EF, $EE, "permission!", $F7
    db $F0

Data_029_6791:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " His Majesty is", $F1
    db "honest and most", $FA, $F7
    db $EF, $EE, "certainly not evil", $EF, $EE, "in any way.", $FA, $F7
    db $EF, $EE, "But, he is rather", $EF, $EE, "impetuous.", $FA, $F7
    db $EF, $EE, "I wish he wouldn't", $EF, $EE, "order us on whim", $A4, $F7
    db $F0

Data_029_6820:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We frown upon", $F1
    db "strangers who", $FA, $F7
    db $EF, $EE, "wander through our", $EF, $EE, "castle!", $F7
    db $F0

Data_029_685F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Why are you", $F1
    db "snooping around?", $FA, $F7
    db $EF, $EE, "Are you looking", $EF, $EE, "for something?"
    db $FF, $F0

Data_029_68A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A new plug for", $F1
    db "the Log's Navel?", $FA, $F7
    db $EF, $EE, "It has to have a", $EF, $EE, "magic power?", $FA, $F7
    db $EF, $EE, "Well, then there's", $EF, $EE, "only the King's", $FA, $F7
    db $EF, $EE, "TidalBell among", $EF, $EE, "his treasures.", $FA, $F7
    db $EF, $EE, "It can be used to", $EF, $EE, "cross the sea.", $F7
    db $F0

Data_029_6955:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, it looked", $F1
    db "like you were on", $FA, $F7
    db $EF, $EE, "the prowl for", $EF, $EE, "something.", $F7
    db $F0

Data_029_6995:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "There were neatly", $EF, $EE, "folded silk robes.", $F7
    db $F0

Data_029_69D7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Ah, you're", $F1
    db "the monster tamer", $FA, $F7
    db $EF, $EE, "from the circus.", $EF, $EE, "Good show!", $FA, $F7
    db $EF, $EE, "So, do you wish", $EF, $EE, "something of me?"
    db $FF, $F0

Data_029_6A40:: ; heuristic: target of a monotone pointer table; C0
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
    db $EF, $EE, "Well? Will you do", $EF, $EE, "this for me?"
    db $FF, $F0

Data_029_6BE2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Then make", $F1
    db "way to the town.", $FA, $F7
    db $EF, $EE, "If you succeed,", $EF, $EE, "you can have the", $FA, $F7
    db $EF, $EE, "TidalBell from my", $EF, $EE, "treasures.", $F7
    db $F0

Data_029_6C4B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Oh", $A4, $F1
    db "You won't?", $FA, $F7
    db $EF, $EE, "Then, I can't help", $EF, $EE, "you either.", $F7
    db $F0

Data_029_6C83:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Investigate", $F1
    db "what concerns my", $FA, $F7
    db $EF, $EE, "people may have.", $EF, $EE, "Hurry!", $F7
    db $F0

Data_029_6CC4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " So? Have you", $F1
    db "decided to see", $FA, $F7
    db $EF, $EE, "what concerns my", $EF, $EE, "people have?"
    db $FF, $F0

Data_029_6D0A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That fool is a", $F1
    db "terrible swindler.", $FA, $F7
    db $EF, $EE, "I wouldn't lend an", $EF, $EE, "ear to him!", $F7
    db $F0

Data_029_6D52:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Humph! A mirage", $F1
    db "lake, he says!", $FA, $F7
    db $EF, $EE, "No one's seen such", $EF, $EE, "a thing.", $FA, $F7
    db $EF, $EE, "Everything he says", $EF, $EE, "is a lie!", $F7
    db $F0

Data_029_6DB5:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do I have any", $F1
    db "concerns?", $FA, $F7
    db $EF, $EE, "You'll tell the", $EF, $EE, "King for me?", $FA, $F7
    db $EF, $EE, "Then listen. The", $EF, $EE, "well's almost dry.", $FA, $F7
    db $EF, $EE, "Could the King do", $EF, $EE, "anything about it?", $F7
    db $F0

Data_029_6E41:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We're worried", $F1
    db "about the well.", $FA, $F7
    db $EF, $EE, "The water level is", $EF, $EE, "dropping sharply.", $FA, $F7
    db $EF, $EE, "We don't have any", $EF, $EE, "confidence in the", $FA, $F7
    db $EF, $EE, "King, so we're not", $EF, $EE, "sure what to do.", $F7
    db $F0

Data_029_6ED9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King has", $F1
    db "given permission", $FA, $F7
    db $EF, $EE, "for you to come", $EF, $EE, "and go freely.", $F7
    db $F0

Data_029_6F1E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King is so", $F1
    db "frivolous.", $FA, $F7
    db $EF, $EE, "A circus makes him", $EF, $EE, "happy? Please!", $F7
    db $F0

Data_029_6F62:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So, have you", $F1
    db "discovered what", $FA, $F7
    db $EF, $EE, "concerns my people", $EF, $EE, "may have?", $FA, $F7
    db $EF, $EE, "What? The well is", $EF, $EE, "running dry?", $FA, $F7
    db $EF, $EE, "I will order my", $EF, $EE, "men to raise the", $FA, $F7
    db $EF, $EE, "flow of water into", $EF, $EE, "the canal.", $FA, $F7
    db $EF, $EE, "Guards! Duke!", $EF, $EE, "Anyone?", $F7
    db $F0

Data_029_7028:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The canal is", $F1
    db "managed by the", $FA, $F7
    db $EF, $EE, "village of Kalka,", $EF, $EE, "isn't that right?", $FA, $F7
    db $EF, $EE, "Send someone to", $EF, $EE, "Kalka and have the", $FA, $F7
    db $EF, $EE, "manager open the", $EF, $EE, "Canal Gate more!", $F7
    db $F0

Data_029_70C0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your Majesty, I", $F1
    db "must remind you", $A4, $FA, $F7
    db $EF, $EE, "If that was done,", $EF, $EE, "the oasis will", $FA, $F7
    db $EF, $EE, "become drained", $EF, $EE, "immediately.", $F7
    db $F0

Data_029_712A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What?", $F1
    db "Never mind, then!", $FA, $F7
    db $EF, $EE, "I'll go to Kalka,", $EF, $EE, "and check myself!", $F7
    db $F0

Data_029_7171:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I feel badly for", $EF, $EE, "his Majesty, but", $FA, $F7
    db $EF, $EE, "he must think", $EF, $EE, "things through.", $FA, $F7
    db $EF, $EE, "Rash actions with", $EF, $EE, "no thought of the", $FA, $F7
    db $EF, $EE, "consequences won't", $EF, $EE, "do for a ruler.", $F7
    db $F0

Data_029_7208:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? Open the", $F1
    db "Canal Gate more?", $FA, $F7
    db $EF, $EE, "The oasis will run", $EF, $EE, "dry if we did!", $FA, $F7
    db $EF, $EE, "That's an order I", $EF, $EE, "simply cannot", $FA, $F7
    db $EF, $EE, "accept, King or no", $EF, $EE, "King.", $F7
    db $F0

Data_029_7292:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Arrgh!", $F1
    db "I know that!", $FA, $F7
    db $EF, $EE, "I want to know why", $EF, $EE, "the water is gone!", $FA, $F7
    db $EF, $EE, "Fine, I'll go find", $EF, $EE, "out myself!", $F7
    db $F0

Data_029_72FA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "My, our King", $F1
    db "has no patience", $A4, $F7
    db $F0

Data_029_731D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I discovered why", $F1
    db "the water is low.", $FA, $F7
    db $EF, $EE, "This beast's dam", $EF, $EE, "is at fault.", $FA, $F7
    db $EF, $EE, "I", $42, "e been trying to", $EF, $EE, "get it to destroy", $FA, $F7
    db $EF, $EE, "the dam, but to no", $EF, $EE, "avail.", $F7
    db $F0

Data_029_73AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm making a new", $F1
    db "home for my clan!", $FA, $F7
    db $EF, $EE, "Leave us be, or", $EF, $EE, "pay the price!", $F7
    db $F0

Data_029_73F5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Gaah! You're too", $F1
    db "strong! You win!", $FA, $F7
    db $EF, $EE, "I didn't mean to", $EF, $EE, "cause any trouble.", $FA, $F7
    db $EF, $EE, "We used to live in", $EF, $EE, "Mirage Lake, but", $FA, $F7
    db $EF, $EE, "we were kicked out", $EF, $EE, "by a band of thugs", $FA, $F7
    db $EF, $EE, "who made it their", $EF, $EE, "hideout!", $FA, $F7
    db $EF, $EE, "I was looking for", $EF, $EE, "a place to live", $A4, $F7
    db $F0

Data_029_74D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What? So", $F1
    db "that's the truth?", $FA, $F7
    db $EF, $EE, "Those wretched", $EF, $EE, "scoundrels!", $FA, $F7
    db $EF, $EE, "I promise, I will", $EF, $EE, "imprison them!", $F7
    db $F0

Data_029_753F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You will?", $F1
    db "So we can go back", $FA, $F7
    db $EF, $EE, "to Mirage Lake and", $EF, $EE, "live peacefully?", $FA, $F7
    db $EF, $EE, "Please catch the", $EF, $EE, "thieves!", $F7
    db $F0

Data_029_75A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " This should", $F1
    db "solve the water", $FA, $F7
    db $EF, $EE, "shortage in the", $EF, $EE, "town.", $FA, $F7
    db $EF, $EE, "I humbly thank you", $EF, $EE, "for your help!", $FA, $F7
    db $EF, $EE, "Come see me in the", $EF, $EE, "Castle.", $FA, $F7
    db $EF, $EE, "I will have the", $EF, $EE, "TidalBell for you.", $F7
    db $F0

Data_029_764F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? You say that", $F1
    db "a monster had been", $FA, $F7
    db $EF, $EE, "blocking the canal", $EF, $EE, "with a dam?", $F7
    db $F0

Data_029_769A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The well has", $F1
    db "ample water again.", $FA, $F7
    db $EF, $EE, "Our King managed", $EF, $EE, "to do it!", $FA, $F7
    db $EF, $EE, "Maybe he isn't a", $EF, $EE, "total buffoon", $A4, $F7
    db $F0

Data_029_7700:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We have heard", $F1
    db "from his Majesty.", $FA, $F7
    db $EF, $EE, "Please, do go", $EF, $EE, "right through.", $F7
    db $F0

Data_029_7745:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hi! Did you hear", $F1
    db "the news?", $FA, $F7
    db $EF, $EE, "Our King is quite", $EF, $EE, "the brave man.", $FA, $F7
    db $EF, $EE, "With just one", $EF, $EE, "underling, he", $FA, $F7
    db $EF, $EE, "defeated monsters", $EF, $EE, "in the canal, and", $FA, $F7
    db $EF, $EE, "saved the town", $EF, $EE, "from a drought!", $F7
    db $F0

Data_029_77F4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King solved", $F1
    db "our water shortage", $FA, $F7
    db $EF, $EE, "all by himself,", $EF, $EE, "I", $42, "e heard.", $FA, $F7
    db $EF, $EE, "Perhaps we were", $EF, $EE, "wrong about him.", $F7
    db $F0

Data_029_785F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our King worked", $F1
    db "to save all of us", $A4, $FA, $F7
    db $EF, $EE, "I'm ashamed", $A4, " What", $EF, $EE, "have I done?", $F7
    db $F0

Data_029_78A8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King appears", $F1
    db "to have turned a", $FA, $F7
    db $EF, $EE, "new leaf as a", $EF, $EE, "great ruler.", $FA, $F7
    db $EF, $EE, "I can finally say", $EF, $EE, "I", $42, "e fulfilled my", $FA, $F7
    db $EF, $EE, "promise to his", $EF, $EE, "late father", $A4, $F7
    db $F0

Data_029_7934:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The town's", $F1
    db "water shortage", $FA, $F7
    db $EF, $EE, "seems to be no", $EF, $EE, "longer a concern.", $FA, $F7
    db $EF, $EE, "I thank you again", $EF, $EE, "for your work.", $FA, $F7
    db $EF, $EE, "Your reward is the", $EF, $EE, "TidalBell.", $FA, $F7
    db $EF, $EE, "Come, follow me to", $EF, $EE, "the treasury.", $F7
    db $F0

Data_029_79E6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Wha-what?", $F1
    db "What happened?", $F7
    db $F0

Data_029_7A07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "We", $A4, " We were", $F1
    db "jumped by thieves", $A4, $FA, $F7
    db $EF, $EE, "They", $A4, " made off", $EF, $EE, "with the treasure", $A4, $F7
    db $F0

Data_029_7A51:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What?", $F1
    db "Arrrrgh!", $FA, $F7
    db $EF, $EE, "Round up all the", $EF, $EE, "men at once!", $FA, $F7
    db $EF, $EE, "Have them report", $EF, $EE, "to my chamber!", $F7
    db $F0

Data_029_7AAE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The hideout", $F1
    db "of the thieves is", $FA, $F7
    db $EF, $EE, "said to be in", $EF, $EE, "Mirage Lake!", $FA, $F7
    db $EF, $EE, "They must be", $EF, $EE, "caught!", $FA, $F7
    db $EF, $EE, "I will lead the", $EF, $EE, "expedition myself!", $FA, $F7
    db $EF, $EE, "Who will join me", $EF, $EE, "in this quest?", $F7
    db $F0

Data_029_7B57:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Good! Your", $F1
    db "valor be praised!", $FA, $F7
    db $EF, $EE, "We must capture", $EF, $EE, "the thieves, at", $FA, $F7
    db $EF, $EE, "all costs.", $EF, $EE, "This is a mission!", $F7
    db $F0

Data_029_7BC2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I apologize,", $F1
    db "but my treasures", $FA, $F7
    db $EF, $EE, "were taken by the", $EF, $EE, "thieves.", $FA, $F7
    db $EF, $EE, "I will head to", $EF, $EE, "Mirage Lake and", $FA, $F7
    db $EF, $EE, "bring them to", $EF, $EE, "justice.", $FA, $F7
    db $EF, $EE, "If we return", $EF, $EE, "safely, you shall", $FA, $F7
    db $EF, $EE, "have the promised", $EF, $EE, "TidalBell.", $F7
    db $F0

Data_029_7C89:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wh-where is", $F1
    db "everybody?", $FA, $F7
    db $EF, $EE, "I haven't been fed", $EF, $EE, "at all", $A4, $FA, $F7
    db $EF, $EE, "Listen, I'll let", $EF, $EE, "you in on a secret", $FA, $F7
    db $EF, $EE, "if you have any", $EF, $EE, "food. Well?"
    db $FF, $F0

Data_029_7D09:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "some food.", $F7
    db $F0

Data_029_7D24:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Munch, munch", $A4, $F1
    db "Chew, gulp", $A4, $FA, $F7
    db $EF, $EE, "Fwoaar, that hits", $EF, $EE, "the spot! Thanks!", $FA, $F7
    db $EF, $EE, "Well, here's the", $EF, $EE, "secret I promised.", $FA, $F7
    db $EF, $EE, "Don't chase what", $EF, $EE, "runs from you.", $FA, $F7
    db $EF, $EE, "Lay some bait, and", $EF, $EE, "let it come.", $FA, $F7
    db $EF, $EE, "That's the trick.", $EF, $EE, "Here, take this.", $F7
    db $F0

Data_029_7DFE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "WaterCall.", $F7
    db $F0

Data_029_7E18:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 had no food", $F1
    db "to give", $A4, $F7
    db $F0

Data_029_7E31:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Tch, what good", $F1
    db "are you?", $FA, $F7
    db $EF, $EE, "I'm starving here.", $EF, $EE, "Anything'll do.", $FA, $F7
    db $EF, $EE, "Even food for", $EF, $EE, "monsters is good!", $F7
    db $F0
    ds $16A, $00
