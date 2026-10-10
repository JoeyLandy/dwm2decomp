SECTION "Bank 82", ROMX[$4000], BANK[$82]
    db $82

; 3 call sites from 3 routines (e.g. GameMode0_Update_Table2_Case0B, Func_010_4AD0_Case0B, ShowMessageHL_Case0B)
; reads: wStringIndex
Func_082_4001::
    ld a, [wStringIndex]
    cp a, $90
    jr c, Jump_082_400F
    farcall Func_096_4026
    ret

Jump_082_400F::
    ld de, Data_082_4032
    call BeginStringDisplay
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
Func_082_4016:: ; heuristic: follows a terminator; C0
    ld a, [wStringIndex]
    cp a, $90
    jr c, Jump_082_4024
    farcall Func_096_4026
    ret

Jump_082_4024::
    ld de, Data_082_4032
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_082_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_082_4034

Data_082_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_082_4154
    dw Data_082_420D
    dw Data_082_426B
    dw Data_082_4375
    dw Data_082_443E
    dw Data_082_44A8
    dw Data_082_4517
    dw Data_082_45A2
    dw Data_082_462C
    dw Data_082_46B6
    dw Data_082_4724
    dw Data_082_47B5
    dw Data_082_488C
    dw Data_082_4964
    dw Data_082_49F0
    dw Data_082_4A57
    dw Data_082_4AE2
    dw Data_082_4B52
    dw Data_082_4BE2
    dw Data_082_4C6A
    dw Data_082_4CD9
    dw Data_082_4D43
    dw Data_082_4D90
    dw Data_082_4E07
    dw Data_082_4E2D
    dw Data_082_4E7C
    dw Data_082_4F09
    dw Data_082_4F75
    dw Data_082_4FE1
    dw Data_082_5074
    dw Data_082_5111
    dw Data_082_5150
    dw Data_082_51E0
    dw Data_082_5234
    dw Data_082_52A2
    dw Data_082_52DD
    dw Data_082_5300
    dw Data_082_5323
    dw Data_082_5372
    dw Data_082_53DF
    dw Data_082_5477
    dw Data_082_554D
    dw Data_082_5600
    dw Data_082_56AC
    dw Data_082_571A
    dw Data_082_57AE
    dw Data_082_586E
    dw Data_082_58FC
    dw Data_082_5968
    dw Data_082_5A47
    dw Data_082_5AD9
    dw Data_082_5B23
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5C1E
    dw Data_082_5CFB
    dw Data_082_5DD9
    dw Data_082_5E43
    dw Data_082_5EAD
    dw Data_082_5F30
    dw Data_082_5F9A
    dw Data_082_6056
    dw Data_082_616A
    dw Data_082_61DD
    dw Data_082_6295
    dw Data_082_6359
    dw Data_082_6379
    dw Data_082_63CD
    dw Data_082_64AB
    dw Data_082_64F6
    dw Data_082_659F
    dw Data_082_660E
    dw Data_082_662D
    dw Data_082_6678
    dw Data_082_676F
    dw Data_082_67E9
    dw Data_082_6828
    dw Data_082_6869
    dw Data_082_690F
    dw Data_082_698B
    dw Data_082_69AD
    dw Data_082_69F4
    dw Data_082_6A34
    dw Data_082_6B29
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6C52
    dw Data_082_6C9D
    dw Data_082_6CF6
    dw Data_082_6D66
    dw Data_082_6DFB
    dw Data_082_6E68
    dw Data_082_6E89
    dw Data_082_6EA9
    dw Data_082_6F32
    dw Data_082_6F5A
    dw Data_082_6FA5
    dw Data_082_7018
    dw Data_082_7030
    dw Data_082_7050
    dw Data_082_70E5
    dw Data_082_719B
    dw Data_082_7226
    dw Data_082_728D
    dw Data_082_72D5
    dw Data_082_72D6
    dw Data_082_7385
    dw Data_082_73E8
    dw Data_082_749F
    dw Data_082_7574
    dw Data_082_75FD
    dw Data_082_763D
    dw Data_082_76C7
    dw Data_082_7788
    dw Data_082_779E
    dw Data_082_7836
    dw Data_082_792B
    dw Data_082_79D3
    dw Data_082_7A7C
    dw Data_082_7A92
    dw Data_082_7B41
    dw Data_082_7BF1
    dw Data_082_7C07
    dw Data_082_7CB3
    dw Data_082_7D60
    dw Data_082_7D76
    dw Data_082_7E05
    dw Data_082_7E98

Data_082_4154:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The weather is", $F1
    db "beautiful again.", $FA, $F7
    db $EF, $EE, "If you're going", $EF, $EE, "out to play, take", $FA, $F7
    db $EF, $EE, "some monsters out", $EF, $EE, "for exercise.", $FA, $F7
    db $EF, $EE, "They're unhappy", $EF, $EE, "about being cooped", $FA, $F7
    db $EF, $EE, "up all the time.", $EF, $EE, "Be good to them!", $F7
    db $F0

Data_082_420D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You and your", $F1
    db "monsters saved", $FA, $F7
    db $EF, $EE, "GreatLog from a", $EF, $EE, "terrible crisis.", $FA, $F7
    db $EF, $EE, "I'm proud of you,", $EF, $EE, $F9, "0!", $F7
    db $F0

Data_082_426B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, I", $F1
    db "envied you for", $FA, $F7
    db $EF, $EE, "being in other", $EF, $EE, "worlds", $A4, $FA, $F7
    db $EF, $EE, "But lately, I'm", $EF, $EE, "finding the farm", $FA, $F7
    db $EF, $EE, "work to be a lot", $EF, $EE, "of fun.", $FA, $F7
    db $EF, $EE, "Monsters respond", $EF, $EE, "to your love.", $FA, $F7
    db $EF, $EE, "The better you", $EF, $EE, "take care of them,", $FA, $F7
    db $EF, $EE, "the more they will", $EF, $EE, "work for you.", $FA, $F7
    db $EF, $EE, "Anyway, what do", $EF, $EE, "you need, sis?", $F7
    db $F0

Data_082_4375:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0, I was", $F1
    db "a little jealous", $FA, $F7
    db $EF, $EE, "of you at first,", $EF, $EE, "but now I'm having", $FA, $F7
    db $EF, $EE, "fun working at the", $EF, $EE, "farm.", $FA, $F7
    db $EF, $EE, "Treat them with", $EF, $EE, "love and monsters", $FA, $F7
    db $EF, $EE, "will love you", $EF, $EE, "back.", $FA, $F7
    db $EF, $EE, "Anyway, did you", $EF, $EE, "need something?", $F7
    db $F0

Data_082_443E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I heard about a", $F1
    db "world of slime.", $FA, $F7
    db $EF, $EE, "Everywhere you go,", $EF, $EE, "all you ever see", $FA, $F7
    db $EF, $EE, "are members of my", $EF, $EE, "family!", $F7
    db $F0

Data_082_44A8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This rope, it", $F1
    db "was not needed.", $FA, $F7
    db $EF, $EE, "But if I stretch", $EF, $EE, "it more and more,", $FA, $F7
    db $EF, $EE, "perhaps it will", $EF, $EE, "reach the clouds.", $F7
    db $F0

Data_082_4517:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Many kinds of", $F1
    db "monsters result", $FA, $F7
    db $EF, $EE, "from breeding.", $EF, $EE, "For example, breed", $FA, $F7
    db $EF, $EE, "me with a beast", $EF, $EE, "family mate, and", $FA, $F7
    db $EF, $EE, "you'll get a baby", $EF, $EE, "FoxFire.", $F7
    db $F0

Data_082_45A2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A world with", $F1
    db "lots of trees and", $FA, $F7
    db $EF, $EE, "water-that would", $EF, $EE, "be the ultimate.", $FA, $F7
    db $EF, $EE, "If there is a", $EF, $EE, "world like that,", $FA, $F7
    db $EF, $EE, "we should all move", $EF, $EE, "there.", $F7
    db $F0

Data_082_462C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The items you", $F1
    db "find in other", $FA, $F7
    db $EF, $EE, "worlds vary from", $EF, $EE, "world to world.", $FA, $F7
    db $EF, $EE, "There must be", $EF, $EE, "worlds where I can", $FA, $F7
    db $EF, $EE, "find Sirloin on", $EF, $EE, "the ground!", $F7
    db $F0

Data_082_46B6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Listen, even in", $F1
    db "other worlds, you", $FA, $F7
    db $EF, $EE, "can write in your", $EF, $EE, "Journal in safe", $FA, $F7
    db $EF, $EE, "locations.", $EF, $EE, "Did you know that?", $F7
    db $F0

Data_082_4724:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Bugs like me", $F1
    db "grow super-quick!", $FA, $F7
    db $EF, $EE, "But our growth", $EF, $EE, "limit is low", $A4, $FA, $F7
    db $EF, $EE, "If you breed us", $EF, $EE, "over generations,", $FA, $F7
    db $EF, $EE, "we'll be able to", $EF, $EE, "stick around more.", $F7
    db $F0

Data_082_47B5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Members of the", $F1
    db "dragon family,", $FA, $F7
    db $EF, $EE, "such as myself,", $EF, $EE, "are slow to grow.", $FA, $F7
    db $EF, $EE, "On the other hand,", $EF, $EE, "our growth limit", $FA, $F7
    db $EF, $EE, "happens to come", $EF, $EE, "quite late.", $FA, $F7
    db $EF, $EE, "We can accompany", $EF, $EE, "you for that much", $FA, $F7
    db $EF, $EE, "longer than other", $EF, $EE, "families.", $F7
    db $F0

Data_082_488C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The master's", $F1
    db "battle plan alters", $FA, $F7
    db $EF, $EE, "the personalities", $EF, $EE, "of monsters.", $FA, $F7
    db $EF, $EE, "To avoid changing", $EF, $EE, "personality, order", $FA, $F7
    db $EF, $EE, "the monster to", $EF, $EE, "fight.", $FA, $F7
    db $EF, $EE, "If it's brave, it", $EF, $EE, "will behave as if", $FA, $F7
    db $EF, $EE, "it was ordered to", $EF, $EE, "Charge in battle.", $F7
    db $F0

Data_082_4964:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, GreatLog's", $F1
    db "mighty hero!", $FA, $F7
    db $EF, $EE, "Are you leaving on", $EF, $EE, "another outing?", $FA, $F7
    db $EF, $EE, "The action is", $EF, $EE, "heating up in the", $FA, $F7
    db $EF, $EE, "Arena too.", $EF, $EE, "Go take a look!", $F7
    db $F0

Data_082_49F0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm beginning to", $F1
    db "feel that people", $FA, $F7
    db $EF, $EE, "are supported by", $EF, $EE, "all sorts of", $FA, $F7
    db $EF, $EE, "things, including", $EF, $EE, "monsters.", $F7
    db $F0

Data_082_4A57:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you found", $F1
    db "another world that", $FA, $F7
    db $EF, $EE, "feels just right", $EF, $EE, "for you?", $FA, $F7
    db $EF, $EE, "There are many", $EF, $EE, "kinds of Magic", $FA, $F7
    db $EF, $EE, "Keys, so you can", $EF, $EE, "keep searching.", $F7
    db $F0

Data_082_4AE2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The rope in the", $F1
    db "farm takes you up", $FA, $F7
    db $EF, $EE, "to the highest", $EF, $EE, "part of GreatLog.", $FA, $F7
    db $EF, $EE, "It's supposed to", $EF, $EE, "be really quick.", $F7
    db $F0

Data_082_4B52:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When you're", $F1
    db "traveling, you can", $FA, $F7
    db $EF, $EE, "experience things", $EF, $EE, "that you would", $FA, $F7
    db $EF, $EE, "never see in", $EF, $EE, "everyday life.", $FA, $F7
    db $EF, $EE, "You appear to have", $EF, $EE, "experienced much.", $F7
    db $F0

Data_082_4BE2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A bard demanded", $F1
    db "to battle while", $FA, $F7
    db $EF, $EE, "I was in another", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "I beat him as", $EF, $EE, "quick exercise.", $FA, $F7
    db $EF, $EE, "He gave me some", $EF, $EE, "amazing medicine.", $F7
    db $F0

Data_082_4C6A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I just happened", $F1
    db "to come across a", $FA, $F7
    db $EF, $EE, "casino ship in", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "We tried our luck", $EF, $EE, "at slot machines.", $F7
    db $F0

Data_082_4CD9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You know how to", $F1
    db "commune with", $FA, $F7
    db $EF, $EE, "monsters, I see.", $EF, $EE, "It's obvious that", $FA, $F7
    db $EF, $EE, "you", $42, "e become a", $EF, $EE, "skilled master.", $F7
    db $F0

Data_082_4D43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When master's", $F1
    db "shop starts making", $FA, $F7
    db $EF, $EE, "money, I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to", $EF, $EE, "start my own shop.", $F7
    db $F0

Data_082_4D90:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm sorry. I was", $F1
    db "wrong about you.", $FA, $F7
    db $EF, $EE, "I hope my shop can", $EF, $EE, "serve your needs.", $FA, $F7
    db $EF, $EE, "May I please help", $EF, $EE, "you with anything?", $F7
    db $F0

Data_082_4E07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! How may I", $F1
    db "serve you today?", $F7
    db $F0

Data_082_4E2D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog's shops", $F1
    db "buy and sell items", $FA, $F7
    db $EF, $EE, "at lower sums than", $EF, $EE, "in other worlds.", $F7
    db $F0

Data_082_4E7C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Prince Kameha is", $F1
    db "in training to", $FA, $F7
    db $EF, $EE, "become a monster", $EF, $EE, "master.", $FA, $F7
    db $EF, $EE, "I think he'll get", $EF, $EE, "bored right away,", $FA, $F7
    db $EF, $EE, "and go back to his", $EF, $EE, "usual antics.", $F7
    db $F0

Data_082_4F09:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I heard that", $F1
    db "you're the hero!", $FA, $F7
    db $EF, $EE, "I can't stop crying", $EF, $EE, "because I'm so", $FA, $F7
    db $EF, $EE, "impressed by what", $EF, $EE, "you did for us.", $F7
    db $F0

Data_082_4F75:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The woman next", $F1
    db "to me cries a lot.", $FA, $F7
    db $EF, $EE, "She even cried", $EF, $EE, "when she won some", $FA, $F7
    db $EF, $EE, "trinket in a", $EF, $EE, "charity raffle.", $F7
    db $F0

Data_082_4FE1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, GreatLog's", $F1
    db "hero!", $FA, $F7
    db $EF, $EE, "Do you still go", $EF, $EE, "out on adventures?", $FA, $F7
    db $EF, $EE, "Thanks to you, my", $EF, $EE, "business remains.", $FA, $F7
    db $EF, $EE, "Anyway, what can I", $EF, $EE, "do for you today?", $F7
    db $F0

Data_082_5074:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you have a", $F1
    db "lot of money, it", $FA, $F7
    db $EF, $EE, "is easier to", $EF, $EE, "travel.", $FA, $F7
    db $EF, $EE, "But if you get", $EF, $EE, "wiped out in", $FA, $F7
    db $EF, $EE, "battle, you lose", $EF, $EE, "more too.", $FA, $F7
    db $EF, $EE, "It's something to", $EF, $EE, "think about.", $F7
    db $F0

Data_082_5111:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're GreatLog's", $F1
    db "savior!", $FA, $F7
    db $EF, $EE, "Do you need any", $EF, $EE, "keys appraised?", $F0

Data_082_5150:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My grandpa gave", $F1
    db "me a key, so I", $FA, $F7
    db $EF, $EE, "brought it here", $EF, $EE, "for appraisal.", $FA, $F7
    db $EF, $EE, "I hope it's for a", $EF, $EE, "world where I can", $FA, $F7
    db $EF, $EE, "see new monsters", $EF, $EE, "for a change.", $F7
    db $F0

Data_082_51E0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, the savior", $F1
    db "of GreatLog.", $FA, $F7
    db $EF, $EE, "I'm the Egg", $EF, $EE, "Evaluator.", $FA, $F7
    db $EF, $EE, "May I help you", $EF, $EE, "today?", $F7
    db $F0

Data_082_5234:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, hero!", $F1
    db "Let me help you!", $FA, $F7
    db $EF, $EE, "How would you like", $EF, $EE, "an egg? It's been", $FA, $F7
    db $EF, $EE, "certified by the", $EF, $EE, "Egg Evaluator."
    db $FF, $F0

Data_082_52A2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You'll take it?", $F1
    db "Excellent!", $FA, $F7
    db $EF, $EE, "I'll send it to", $EF, $EE, "the farm.", $F7
    db $F0

Data_082_52DD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? But there's", $F1
    db "no room for it.", $F7
    db $F0

Data_082_5300:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " Well, that's", $F1
    db "too bad, then.", $F7
    db $F0

Data_082_5323:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Evaluator's", $F1
    db "singing is magic.", $FA, $F7
    db $EF, $EE, "You should see how", $EF, $EE, "it affects an egg.", $F7
    db $F0

Data_082_5372:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "How are you?", $FA, $F7
    db $EF, $EE, "Still traveling in", $EF, $EE, "other worlds?", $FA, $F7
    db $EF, $EE, "You saved GreatLog", $EF, $EE, "from its crisis!", $F7
    db $F0

Data_082_53DF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0, wiped out?", $FA, $F7
    db $EF, $EE, "That isn't good at", $EF, $EE, "all for a master!", $FA, $F7
    db $EF, $EE, "I'm big-hearted so", $EF, $EE, "I'll share some of", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "with you, warooh!", $F7
    db $F0

Data_082_5477:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "I have a favor to", $FA, $F7
    db $EF, $EE, "ask of you as a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "My kid wants to", $EF, $EE, "travel, warooh.", $FA, $F7
    db $EF, $EE, "But I can't let my", $EF, $EE, "kid go alone.", $FA, $F7
    db $EF, $EE, "Maybe my kid can", $EF, $EE, "go with you?", $FA, $F7
    db $EF, $EE, "But no, you have", $EF, $EE, "no room left.", $F7
    db $F0

Data_082_554D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "I have a favor to", $FA, $F7
    db $EF, $EE, "ask of you as a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "My kid wants to", $EF, $EE, "travel, warooh.", $FA, $F7
    db $EF, $EE, "But I can't let my", $EF, $EE, "kid go alone.", $FA, $F7
    db $EF, $EE, "Maybe my kid can", $EF, $EE, "go with you?"
    db $FF, $F0

Data_082_5600:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, good, good!", $FA, $F7
    db $EF, $EE, "I knew I could", $EF, $EE, "count on you!", $FA, $F7
    db $EF, $EE, "I knew I was right", $EF, $EE, "in picking you as", $FA, $F7
    db $EF, $EE, "a monster master,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "Wa-hey, Petibou", $EF, $EE, "come here!", $F7
    db $F0

Data_082_56AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " What?", $F1
    db "This little kid?", $FA, $F7
    db $EF, $EE, "This is really a", $EF, $EE, "monster master?", $FA, $F7
    db $EF, $EE, "But Papa said, so", $EF, $EE, "I'll go with you.", $F7
    db $F0

Data_082_571A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "my kid has a big", $FA, $F7
    db $EF, $EE, "mouth, but Petibou", $EF, $EE, "will be useful.", $FA, $F7
    db $EF, $EE, "Petibou will be at", $EF, $EE, "the farm, warooh.", $FA, $F7
    db $EF, $EE, "Look after my", $EF, $EE, "Petibou good!", $F7
    db $F0

Data_082_57AE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "the bond between", $FA, $F7
    db $EF, $EE, "human beings and", $EF, $EE, "monsters are much", $FA, $F7
    db $EF, $EE, "stronger than they", $EF, $EE, "ever were, warooh.", $FA, $F7
    db $EF, $EE, "I think you're to", $EF, $EE, "be thanked for it.", $FA, $F7
    db $EF, $EE, "GreatLog is out of", $EF, $EE, "danger too.", $F7
    db $F0

Data_082_586E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aren't you", $F1
    db "GreatLog's savior?", $FA, $F7
    db $EF, $EE, "Well, has breeding", $EF, $EE, "helped you?", $FA, $F7
    db $EF, $EE, "I hope I helped", $EF, $EE, "you in your quest.", $FA, $F7
    db $EF, $EE, "Anyway, what do", $EF, $EE, "you need of me?", $F7
    db $F0

Data_082_58FC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, GreatLog's", $F1
    db "great hero!", $FA, $F7
    db $EF, $EE, "How would you like", $EF, $EE, "to take part in", $FA, $F7
    db $EF, $EE, "tournaments for", $EF, $EE, "battling monsters?", $F7
    db $F0

Data_082_5968:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, well, it's", $F1
    db "GreatLog's savior!", $FA, $F7
    db $EF, $EE, "Masters of every", $EF, $EE, "sort gather in the", $FA, $F7
    db $EF, $EE, "Arena to test", $EF, $EE, "their mettle.", $FA, $F7
    db $EF, $EE, "You might talk to", $EF, $EE, "other masters.", $FA, $F7
    db $EF, $EE, "They could teach", $EF, $EE, "you things that", $FA, $F7
    db $EF, $EE, "you may not learn", $EF, $EE, "on your travels.", $F7
    db $F0

Data_082_5A47:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Make sure you're", $F1
    db "fully prepared for", $FA, $F7
    db $EF, $EE, "traveling in the", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "But I guess you", $EF, $EE, "know that already,", $FA, $F7
    db $EF, $EE, "being a prodigy as", $EF, $EE, "a master", $A4, $F7
    db $F0

Data_082_5AD9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you used", $F1
    db "the rope already?", $FA, $F7
    db $EF, $EE, "It's a quick climb", $EF, $EE, "to the treetop.", $F7
    db $F0

Data_082_5B23:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Papa is a famous", $F1
    db "monster master.", $FA, $F7
    db $EF, $EE, "You're famous too,", $EF, $EE, "but he'll beat you.", $FA, $F7
    db $EF, $EE, "I'm sure he will", $EF, $EE, "one day!", $F7
    db $F0

Data_082_5B8E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The girl next", $F1
    db "door?", $FA, $F7
    db $EF, $EE, "Well, we had our", $EF, $EE, "disagreements, but", $FA, $F7
    db $EF, $EE, "we discovered that", $EF, $EE, "our tastes match.", $FA, $F7
    db $EF, $EE, "So, uh, we're going", $EF, $EE, "to get married.", $F7
    db $F0

Data_082_5C1E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The way you", $F1
    db "saved GreatLog was", $FA, $F7
    db $EF, $EE, "a real inspiration", $EF, $EE, "to both of us.", $FA, $F7
    db $EF, $EE, "It brought us", $EF, $EE, "together in love.", $FA, $F7
    db $EF, $EE, "As our thanks, we", $EF, $EE, "want you to have", $FA, $F7
    db $EF, $EE, "an egg that our", $EF, $EE, "monsters laid.", $FA, $F7
    db $EF, $EE, "We'll send it to", $EF, $EE, "the farm for you.", $F7
    db $F0

Data_082_5CFB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The way you", $F1
    db "saved GreatLog was", $FA, $F7
    db $EF, $EE, "a real inspiration", $EF, $EE, "to both of us.", $FA, $F7
    db $EF, $EE, "It brought us", $EF, $EE, "together in love.", $FA, $F7
    db $EF, $EE, "As our thanks, we", $EF, $EE, "want you to have", $FA, $F7
    db $EF, $EE, "an egg that our", $EF, $EE, "monsters laid.", $FA, $F7
    db $EF, $EE, "Oh, but your farm", $EF, $EE, "is already full", $A4, $F7
    db $F0

Data_082_5DD9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our monsters", $F1
    db "left on a journey.", $FA, $F7
    db $EF, $EE, "I hope they're", $EF, $EE, "doing well, and", $FA, $F7
    db $EF, $EE, "not squabbling", $EF, $EE, "with each other", $A4, $F7
    db $F0

Data_082_5E43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My granddaughter", $F1
    db "became a master.", $FA, $F7
    db $EF, $EE, "She's found her", $EF, $EE, "own calling.", $FA, $F7
    db $EF, $EE, "I won't have to", $EF, $EE, "worry about her.", $F7
    db $F0

Data_082_5EAD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I became a", $F1
    db "master because I", $FA, $F7
    db $EF, $EE, "wanted to be like", $EF, $EE, "you.", $FA, $F7
    db $EF, $EE, "I", $42, "e gotten pretty", $EF, $EE, "good too!", $FA, $F7
    db $EF, $EE, "Do you want battle", $EF, $EE, "to see how good?"
    db $FF, $F0

Data_082_5F30:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My master has", $F1
    db "gotten good.", $FA, $F7
    db $EF, $EE, "You'll be surprised", $EF, $EE, "how good she is if", $FA, $F7
    db $EF, $EE, "you battle her at", $EF, $EE, "the Arena.", $F7
    db $F0

Data_082_5F9A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, our young", $F1
    db "savior!", $FA, $F7
    db $EF, $EE, "Have you collected", $EF, $EE, "many monsters?", $FA, $F7
    db $EF, $EE, "I hope you'll keep", $EF, $EE, "working on your", $FA, $F7
    db $EF, $EE, "monster catalog to", $EF, $EE, "make it the best.", $FA, $F7
    db $EF, $EE, "Which family would", $EF, $EE, "you like to check?", $F7
    db $F0

Data_082_6056:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " heard that", $F1
    db "you went on a", $FA, $F7
    db $EF, $EE, "quest to save", $EF, $EE, "GreatLog.", $FA, $F7
    db $EF, $EE, "I never expected", $EF, $EE, "someone so young", $FA, $F7
    db $EF, $EE, "would have the", $EF, $EE, "gumption to do it.", $FA, $F7
    db $EF, $EE, "Yes, I'm impressed", $EF, $EE, "all right!", $FA, $F7
    db $EF, $EE, "If you bring me a", $EF, $EE, "monster that could", $FA, $F7
    db $EF, $EE, "surprise me, I'll", $EF, $EE, "give you my key.", $FA, $F7
    db $EF, $EE, "I'll be waiting", $EF, $EE, "for you.", $F7
    db $F0

Data_082_616A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Those monsters", $F1
    db "don't surprise me.", $FA, $F7
    db $EF, $EE, "Bring me something", $EF, $EE, "I", $42, "e never seen.", $FA, $F7
    db $EF, $EE, "Otherwise, I won't", $EF, $EE, "give you my key.", $F7
    db $F0

Data_082_61DD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh! Goodness!", $F1
    db "I'm surprised!", $FA, $F7
    db $EF, $EE, "I", $42, "e never seen a", $EF, $EE, "monster like that!", $FA, $F7
    db $EF, $EE, "I never knew of a", $EF, $EE, "Demon Lord like", $FA, $F7
    db $EF, $EE, "that! It's a new", $EF, $EE, "species to me!", $FA, $F7
    db $EF, $EE, "I'll have to give", $EF, $EE, "you my Magic Key!", $F7
    db $F0

Data_082_6295:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Obtain the other", $F1
    db "key that doesn't", $FA, $F7
    db $EF, $EE, "exist in this", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "Overcome the two", $EF, $EE, "tests that the two", $FA, $F7
    db $EF, $EE, "keys present to", $EF, $EE, "you.", $FA, $F7
    db $EF, $EE, "If you succeed,", $EF, $EE, "and only then,", $FA, $F7
    db $EF, $EE, "I will give you", $EF, $EE, "one more key.", $F7
    db $F0

Data_082_6359:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Brawn Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_082_6379:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found a", $F1
    db "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

Data_082_63CD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, who would", $F1
    db "have thought such", $FA, $F7
    db $EF, $EE, "a youngster would", $EF, $EE, "save GreatLog!", $FA, $F7
    db $EF, $EE, "I thought you were", $EF, $EE, "different.", $FA, $F7
    db $EF, $EE, "Now I know you're", $EF, $EE, "something special.", $FA, $F7
    db $EF, $EE, "I'll ask you to", $EF, $EE, "keep searching for", $FA, $F7
    db $EF, $EE, "more of my beloved", $EF, $EE, "TinyMedals!", $F7
    db $F0

Data_082_64AB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you find even", $F1
    db "more TinyMedals,", $FA, $F7
    db $EF, $EE, "you can trade for", $EF, $EE, "rare monsters.", $F7
    db $F0

Data_082_64F6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, the savior", $F1
    db "of GreatLog!", $FA, $F7
    db $EF, $EE, "You're always", $EF, $EE, "welcome here.", $FA, $F7
    db $EF, $EE, "Skilled masters", $EF, $EE, "gather here.", $FA, $F7
    db $EF, $EE, "They may offer to", $EF, $EE, "breed monsters.", $FA, $F7
    db $EF, $EE, "Don't miss those", $EF, $EE, "opportunities!", $F7
    db $F0

Data_082_659F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Didn't you save", $F1
    db "GreatLog?", $FA, $F7
    db $EF, $EE, "That is so neat!", $EF, $EE, "How would you like", $FA, $F7
    db $EF, $EE, "to breed something", $EF, $EE, "with my FunkyBird?"
    db $FF, $F0

Data_082_660E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Great! Let's", $F1
    db "give it a try!", $F7
    db $F0

Data_082_662D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh. Too bad.", $F1
    db "Maybe next time.", $FA, $F7
    db $EF, $EE, "I'll be here if you", $EF, $EE, "change your mind.", $F7
    db $F0

Data_082_6678:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When you breed", $F1
    db "monsters with", $FA, $F7
    db $EF, $EE, "another master,", $EF, $EE, "your monster is", $FA, $F7
    db $EF, $EE, "designated the", $EF, $EE, "base species.", $FA, $F7
    db $EF, $EE, "So, each master is", $EF, $EE, "likely to end up", $FA, $F7
    db $EF, $EE, "with different", $EF, $EE, "kinds of babies.", $FA, $F7
    db $EF, $EE, "I hope something", $EF, $EE, "good will hatch", $FA, $F7
    db $EF, $EE, "from your egg and", $EF, $EE, "mine too!", $F7
    db $F0

Data_082_676F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you must be", $F1
    db "the little hero", $FA, $F7
    db $EF, $EE, "I keep hearing", $EF, $EE, "about?", $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "breed a monster", $FA, $F7
    db $EF, $EE, "with my Copycat?", $EF, $EE
    db $FF, $F0

Data_082_67E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " May good fortune", $F1
    db "arrive quickly.", $FA, $F7
    db $EF, $EE, "Please, may we", $EF, $EE, "begin?", $F7
    db $F0

Data_082_6828:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " May misfortune", $F1
    db "shun you.", $FA, $F7
    db $EF, $EE, "I'll await your", $EF, $EE, "reconsideration.", $F7
    db $F0

Data_082_6869:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Generations of", $F1
    db "breeding passes on", $FA, $F7
    db $EF, $EE, "skills and", $EF, $EE, "strengths.", $FA, $F7
    db $EF, $EE, "Though monsters", $EF, $EE, "may appear the", $FA, $F7
    db $EF, $EE, "same, breeding", $EF, $EE, "will alter their", $FA, $F7
    db $EF, $EE, "attributes for the", $EF, $EE, "better.", $F7
    db $F0

Data_082_690F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I didn't think", $F1
    db "GreatLog's hero", $FA, $F7
    db $EF, $EE, "could be this", $EF, $EE, "young and tiny!", $FA, $F7
    db $EF, $EE, "Do you want to", $EF, $EE, "breed something", $FA, $F7
    db $EF, $EE, "with my Andreal?", $EF, $EE
    db $FF, $F0

Data_082_698B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, no time to", $F1
    db "lose! Quick!", $F7
    db $F0

Data_082_69AD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " That's so", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "Well, come back if", $EF, $EE, "you reconsider.", $F7
    db $F0

Data_082_69F4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Put accessories", $F1
    db "on your monsters.", $FA, $F7
    db $EF, $EE, "They can really", $EF, $EE, "help!", $F7
    db $F0

Data_082_6A34:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For winning an S", $EF, $EE, "Class tournament,", $FA, $F7
    db $EF, $EE, "you're now a", $EF, $EE, "registered pro.", $FA, $F7
    db $EF, $EE, "You can choose", $EF, $EE, "Classes now.", $FA, $F7
    db $EF, $EE, "Just pay the entry", $EF, $EE, "fee and you can", $FA, $F7
    db $EF, $EE, "compete for your", $EF, $EE, "choice of prizes.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "enter a tourny?", $F7
    db $F0

Data_082_6B29:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! Are you", $F1
    db "here to battle?", $F7
    db $F0

Data_082_6B4E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " As a pro master,", $F1
    db "you can choose the", $FA, $F7
    db $EF, $EE, "Class for battle", $EF, $EE, "competition.", $FA, $F7
    db $EF, $EE, "Champs win Magic", $EF, $EE, "Keys and items.", $FA, $F7
    db $EF, $EE, "The rules are the", $EF, $EE, "same as before.", $FA, $F7
    db $EF, $EE, "You can't use any", $EF, $EE, "items in battle.", $FA, $F7
    db $EF, $EE, "And you forfeit if", $EF, $EE, "you flee.", $FA, $F7
    db $EF, $EE, "Put on good shows", $EF, $EE, "for the audience!", $F7
    db $F0

Data_082_6C52:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oops, it's not", $F1
    db "your first time!", $FA, $F7
    db $EF, $EE, "Please excuse my", $EF, $EE, "rudeness, sweetie!", $F7
    db $F0

Data_082_6C9D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Listen, this is", $F1
    db "a secret.", $FA, $F7
    db $EF, $EE, "There's a man who", $EF, $EE, "trades TinyMedals", $FA, $F7
    db $EF, $EE, "for a MeteOrb.", $EF, $EE, $F7
    db $F0

Data_082_6CF6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters that", $F1
    db "are caught at high", $FA, $F7
    db $EF, $EE, "levels tend to be", $EF, $EE, "very, very wild.", $FA, $F7
    db $EF, $EE, "Conversely, a baby", $EF, $EE, "is obedient.", $F7
    db $F0

Data_082_6D66:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When you're at", $F1
    db "the pro level, the", $FA, $F7
    db $EF, $EE, "competition is far", $EF, $EE, "tougher.", $FA, $F7
    db $EF, $EE, "You'll be wasting", $EF, $EE, "money if you don't", $FA, $F7
    db $EF, $EE, "battle within your", $EF, $EE, "party's abilities.", $F7
    db $F0

Data_082_6DFB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Are you perhaps", $F1
    db "GreatLog's savior?", $FA, $F7
    db $EF, $EE, "Hey, how about", $EF, $EE, "breeding my", $FA, $F7
    db $EF, $EE, "Skeletor with one", $EF, $EE, "of your monsters?"
    db $FF, $F0

Data_082_6E68:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK! Let the", $F1
    db "breeding happen!", $F7
    db $F0

Data_082_6E89:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No? Well, if we", $F1
    db "meet again", $A4, $F7
    db $F0

Data_082_6EA9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Breeding fire", $F1
    db "and ice together", $FA, $F7
    db $EF, $EE, "makes one tough", $EF, $EE, "monster.", $FA, $F7
    db $EF, $EE, "But, it's hard to", $EF, $EE, "get even one,", $FA, $F7
    db $EF, $EE, "never mind getting", $EF, $EE, "the other one.", $F7
    db $F0

Data_082_6F32:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My frigid breath", $F1
    db "chills even souls.", $F7
    db $F0

Data_082_6F5A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " As I level up,", $F1
    db "my FrigidAir turns", $FA, $F7
    db $EF, $EE, "into the wickedly", $EF, $EE, "cold WhiteAir.", $F7
    db $F0

Data_082_6FA5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey! You're still", $F1
    db "at it, youngster?", $FA, $F7
    db $EF, $EE, "My StoneMan needs", $EF, $EE, "a monster as a", $FA, $F7
    db $EF, $EE, "breeding partner.", $EF, $EE, "Do you have one?"
    db $FF, $F0

Data_082_7018:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $35, $28, $24, $37, $99, $F1, $10, $32, $32, $27, $90, $24
    db $31, $36, $3A, $28, $35, $99, $F7, $F0

Data_082_7030:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That's too bad.", $F1
    db "It's a waste", $A4, $F7
    db $F0

Data_082_7050:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Through breeding", $F1
    db "the number beside", $FA, $F7
    db $EF, $EE, "the species name", $EF, $EE, "goes up.", $FA, $F7
    db $EF, $EE, "That number will", $EF, $EE, "rise faster if you", $FA, $F7
    db $EF, $EE, "breed high level", $EF, $EE, "monsters together.", $F7
    db $F0

Data_082_70E5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some monsters", $F1
    db "may be tough, but", $FA, $F7
    db $EF, $EE, "they could have", $EF, $EE, "surprising weak", $FA, $F7
    db $EF, $EE, "spots that can be", $EF, $EE, "exploited.", $FA, $F7
    db $EF, $EE, "Skills and dances", $EF, $EE, "that cause status", $FA, $F7
    db $EF, $EE, "problems can come", $EF, $EE, "in very handy.", $F7
    db $F0

Data_082_719B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e learned how", $F1
    db "to tell what my", $FA, $F7
    db $EF, $EE, "monsters are", $EF, $EE, "thinking.", $FA, $F7
    db $EF, $EE, $A4, "Oh! No, Grizo!", $EF, $EE, "That's not food!", $FA, $F7
    db $EF, $EE, "This is my friend!", $EF, $EE, "Not food, Grizo!", $F7
    db $F0

Data_082_7226:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you become", $F1
    db "a pro master?", $FA, $F7
    db $EF, $EE, "You're more likely", $EF, $EE, "to win great", $FA, $F7
    db $EF, $EE, "prizes in the", $EF, $EE, "higher classes.", $F7
    db $F0

Data_082_728D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My Mama gets so", $F1
    db "ahead of herself", $A4, $FA, $F7
    db $EF, $EE, "I", $42, "e only won the", $EF, $EE, "Kids", $95, " Class", $A4, $F7
    db $F0

Data_082_72D5:: ; heuristic: target of a monotone pointer table; C0
    db $EB

Data_082_72D6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have to pay", $F1
    db "an entry fee to", $FA, $F7
    db $EF, $EE, "compete in any pro", $EF, $EE, "tournament.", $FA, $F7
    db $EF, $EE, "It costs more for", $EF, $EE, "higher Classes.", $FA, $F7
    db $EF, $EE, "But you also win", $EF, $EE, "better prizes in", $FA, $F7
    db $EF, $EE, "the higher Classes", $EF, $EE, "too.", $F7
    db $F0

Data_082_7385:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e never heard", $F1
    db "of a single master", $FA, $F7
    db $EF, $EE, "who struck it", $EF, $EE, "rich.", $FA, $F7
    db $EF, $EE, "Adventures cost a", $EF, $EE, "lot, I guess.", $F7
    db $F0

Data_082_73E8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Oh? It's our", $F1
    db "savior ", $F9, "0!", $FA, $F7
    db $EF, $EE, "Kameha has been in", $EF, $EE, "training to become", $FA, $F7
    db $EF, $EE, "a better master,", $EF, $EE, "he says.", $FA, $F7
    db $EF, $EE, "So he's been taking", $EF, $EE, "long journeys, and", $FA, $F7
    db $EF, $EE, "hardly ever comes", $EF, $EE, "home, the brat.", $F7
    db $F0

Data_082_749F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Oh? It's our", $F1
    db "savior ", $F9, "0!", $FA, $F7
    db $EF, $EE, "What timing!", $EF, $EE, "I needed a favor.", $FA, $F7
    db $EF, $EE, "I heard of an evil", $EF, $EE, "master who uses", $FA, $F7
    db $EF, $EE, "monsters to carry", $EF, $EE, "out misdeeds.", $FA, $F7
    db $EF, $EE, "If you spot him in", $EF, $EE, "another world,", $FA, $F7
    db $EF, $EE, "could you capture", $EF, $EE, "him for us?"
    db $FF, $F0

Data_082_7574:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You will?", $F1
    db "I knew I could", $FA, $F7
    db $EF, $EE, "count on the great", $EF, $EE, "hero of GreatLog!", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "merchant.", $FA, $F7
    db $EF, $EE, "He's greedy too.", $EF, $EE, "Be careful!", $F7
    db $F0

Data_082_75FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You refuse", $F1
    db "my request?", $FA, $F7
    db $EF, $EE, "After all we", $42, "e", $EF, $EE, "been through?", $F7
    db $F0

Data_082_763D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " There is an", $F1
    db "evil master who", $FA, $F7
    db $EF, $EE, "uses monsters for", $EF, $EE, "nefarious deeds.", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "merchant.", $FA, $F7
    db $EF, $EE, "He's greedy too.", $EF, $EE, "Be careful!", $F7
    db $F0

Data_082_76C7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Ah, you", $42, "e", $F1
    db "finally caught the", $FA, $F7
    db $EF, $EE, "evil wretch of a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "I knew I could", $EF, $EE, "count on the great", $FA, $F7
    db $EF, $EE, "hero of GreatLog!", $EF, $EE, "As sharp as ever!", $FA, $F7
    db $EF, $EE, "It's not much, but", $EF, $EE, "here's your reward.", $F7
    db $F0

Data_082_7788:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "10,000G.", $F7
    db $F0

Data_082_779E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I was right", $F1
    db "to trust the great", $FA, $F7
    db $EF, $EE, "hero of GreatLog!", $EF, $EE, "As sharp as ever!", $FA, $F7
    db $EF, $EE, "If other criminal", $EF, $EE, "masters appear,", $FA, $F7
    db $EF, $EE, "I'll be sure to", $EF, $EE, "seek your help!", $F7
    db $F0

Data_082_7836:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Oh? It's our", $F1
    db "savior ", $F9, "0!", $FA, $F7
    db $EF, $EE, "What fortuitous", $EF, $EE, "timing!", $FA, $F7
    db $EF, $EE, "I needed to ask", $EF, $EE, "for another favor.", $FA, $F7
    db $EF, $EE, "I heard of an evil", $EF, $EE, "master who uses", $FA, $F7
    db $EF, $EE, "monsters to carry", $EF, $EE, "out misdeeds.", $FA, $F7
    db $EF, $EE, "If you spot him in", $EF, $EE, "another world,", $FA, $F7
    db $EF, $EE, "could you capture", $EF, $EE, "him for us?"
    db $FF, $F0

Data_082_792B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You will?", $F1
    db "I knew I could", $FA, $F7
    db $EF, $EE, "count on the great", $EF, $EE, "hero of GreatLog!", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "priest.", $FA, $F7
    db $EF, $EE, "He only targets", $EF, $EE, "the injured in", $FA, $F7
    db $EF, $EE, "battle.", $EF, $EE, "Be very cautious!", $F7
    db $F0

Data_082_79D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " There is an", $F1
    db "evil master who", $FA, $F7
    db $EF, $EE, "uses monsters for", $EF, $EE, "nefarious deeds.", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "priest.", $FA, $F7
    db $EF, $EE, "He only targets", $EF, $EE, "the injured in", $FA, $F7
    db $EF, $EE, "battle.", $EF, $EE, "Be very cautious!", $F7
    db $F0

Data_082_7A7C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "20,000G.", $F7
    db $F0

Data_082_7A92:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You will?", $F1
    db "I knew I could", $FA, $F7
    db $EF, $EE, "count on the great", $EF, $EE, "hero of GreatLog!", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "mage.", $FA, $F7
    db $EF, $EE, "He targets those", $EF, $EE, "lacking magical", $FA, $F7
    db $EF, $EE, "power in battle.", $EF, $EE, "Beware of that!", $F7
    db $F0

Data_082_7B41:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " There is an", $F1
    db "evil master who", $FA, $F7
    db $EF, $EE, "uses monsters for", $EF, $EE, "nefarious deeds.", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "mage.", $FA, $F7
    db $EF, $EE, "He targets those", $EF, $EE, "lacking magical", $FA, $F7
    db $EF, $EE, "power in battle.", $EF, $EE, "Beware of that!", $F7
    db $F0

Data_082_7BF1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "30,000G.", $F7
    db $F0

Data_082_7C07:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You will?", $F1
    db "I knew I could", $FA, $F7
    db $EF, $EE, "count on the great", $EF, $EE, "hero of GreatLog!", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "warrior.", $FA, $F7
    db $EF, $EE, "He targets only", $EF, $EE, "low level monsters", $FA, $F7
    db $EF, $EE, "in battle.", $EF, $EE, "Be very wary!", $F7
    db $F0

Data_082_7CB3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " There is an", $F1
    db "evil master who", $FA, $F7
    db $EF, $EE, "uses monsters for", $EF, $EE, "nefarious deeds.", $FA, $F7
    db $EF, $EE, "He's dressed as a", $EF, $EE, "warrior.", $FA, $F7
    db $EF, $EE, "He targets only", $EF, $EE, "low level monsters", $FA, $F7
    db $EF, $EE, "in battle.", $EF, $EE, "Be very wary!", $F7
    db $F0

Data_082_7D60:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "40,000G.", $F7
    db $F0

Data_082_7D76:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I was right", $F1
    db "to trust the great", $FA, $F7
    db $EF, $EE, "hero of GreatLog!", $EF, $EE, "As sharp as ever!", $FA, $F7
    db $EF, $EE, "I can sleep well", $EF, $EE, "at night knowing", $FA, $F7
    db $EF, $EE, "that you are with", $EF, $EE, "us!", $F7
    db $F0

Data_082_7E05:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It would be our", $F1
    db "Kingdom's shame if", $FA, $F7
    db $EF, $EE, "GreatLog's masters", $EF, $EE, "are criminally", $FA, $F7
    db $EF, $EE, "misbehaving in", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "Please bring them", $EF, $EE, "to justice here!", $F7
    db $F0

Data_082_7E98:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I", $42, "e gone", $F1
    db "to other worlds", $FA, $F7
    db $EF, $EE, "and trained as a", $EF, $EE, "master.", $FA, $F7
    db $EF, $EE, $F9, "0, I", $42, "e gone", $EF, $EE, "far beyond you!", $FA, $F7
    db $EF, $EE, "Want to battle me", $EF, $EE, "and see?"
    db $FF, $F0, $F0
    ds $E7, $00
