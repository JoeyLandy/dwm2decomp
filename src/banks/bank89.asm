SECTION "Bank 89", ROMX[$4000], BANK[$89]
    db $89

; 3 call sites from 3 routines (e.g. Func_001_4AD4, Func_010_4AD0, Func_05F_69FB)
; reads: wC529
Func_089_4001::
    ld a, [wC529]
    cp a, $DE
    jr c, Jump_089_400F
    farcall Func_098_404B
    ret

Jump_089_400F::
    ld de, Data_089_4032
    call Func_000_25C9
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC529
Func_089_4016:: ; heuristic: follows a terminator; C0
    ld a, [wC529]
    cp a, $DE
    jr c, Jump_089_4024
    farcall Func_098_405A
    ret

Jump_089_4024::
    ld de, Data_089_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_089_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_089_4034

Data_089_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_089_41F0
    dw Data_089_4260
    dw Data_089_42AD
    dw Data_089_431C
    dw Data_089_4367
    dw Data_089_43A1
    dw Data_089_43C3
    dw Data_089_4407
    dw Data_089_44BE
    dw Data_089_4506
    dw Data_089_4569
    dw Data_089_45EE
    dw Data_089_4687
    dw Data_089_4773
    dw Data_089_4800
    dw Data_089_4865
    dw Data_089_48E9
    dw Data_089_4909
    dw Data_089_493F
    dw Data_089_4960
    dw Data_089_4A33
    dw Data_089_4ADA
    dw Data_089_4B24
    dw Data_089_4B99
    dw Data_089_4BB6
    dw Data_089_4BD4
    dw Data_089_4C0E
    dw Data_089_4C97
    dw Data_089_4E20
    dw Data_089_4E9F
    dw Data_089_4F2A
    dw Data_089_4FAA
    dw Data_089_505B
    dw Data_089_5109
    dw Data_089_519B
    dw Data_089_521F
    dw Data_089_525F
    dw Data_089_52EC
    dw Data_089_5332
    dw Data_089_5374
    dw Data_089_53CE
    dw Data_089_53EC
    dw Data_089_547E
    dw Data_089_5505
    dw Data_089_563B
    dw Data_089_5672
    dw Data_089_56A3
    dw Data_089_5707
    dw Data_089_574B
    dw Data_089_57BA
    dw Data_089_5823
    dw Data_089_5883
    dw Data_089_58CC
    dw Data_089_590B
    dw Data_089_5947
    dw Data_089_5965
    dw Data_089_59AD
    dw Data_089_59F0
    dw Data_089_5A2F
    dw Data_089_5A75
    dw Data_089_5A81
    dw Data_089_5A8B
    dw Data_089_5B12
    dw Data_089_5B4F
    dw Data_089_5BB8
    dw Data_089_5BF8
    dw Data_089_5C12
    dw Data_089_5C50
    dw Data_089_5CFE
    dw Data_089_5D42
    dw Data_089_5DAC
    dw Data_089_5E21
    dw Data_089_5E41
    dw Data_089_5EA9
    dw Data_089_5EC3
    dw Data_089_5F00
    dw Data_089_5F47
    dw Data_089_5FF4
    dw Data_089_6086
    dw Data_089_60C9
    dw Data_089_60C9
    dw Data_089_60EE
    dw Data_089_6106
    dw Data_089_6124
    dw Data_089_6124
    dw Data_089_6124
    dw Data_089_6141
    dw Data_089_615D
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_61A4
    dw Data_089_61E3
    dw Data_089_61F6
    dw Data_089_620F
    dw Data_089_622C
    dw Data_089_6247
    dw Data_089_6263
    dw Data_089_627F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_62C1
    dw Data_089_62E6
    dw Data_089_634C
    dw Data_089_636A
    dw Data_089_6420
    dw Data_089_6460
    dw Data_089_6483
    dw Data_089_64CE
    dw Data_089_6512
    dw Data_089_659A
    dw Data_089_661F
    dw Data_089_66A5
    dw Data_089_6708
    dw Data_089_6771
    dw Data_089_67D8
    dw Data_089_6820
    dw Data_089_68E0
    dw Data_089_696A
    dw Data_089_6A1F
    dw Data_089_6AAF
    dw Data_089_6B4F
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6C64
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D99
    dw Data_089_6E09
    dw Data_089_6E4B
    dw Data_089_6E8E
    dw Data_089_6ED3
    dw Data_089_6F1E
    dw Data_089_6F64
    dw Data_089_6F99
    dw Data_089_6FBE
    dw Data_089_6FDC
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_716B
    dw Data_089_72B6
    dw Data_089_7300
    dw Data_089_7368
    dw Data_089_73C4
    dw Data_089_74AB
    dw Data_089_74C9
    dw Data_089_7594
    dw Data_089_7620
    dw Data_089_76D7
    dw Data_089_7707
    dw Data_089_7834
    dw Data_089_7859
    dw Data_089_7873
    dw Data_089_7894
    dw Data_089_78B3
    dw Data_089_78F3
    dw Data_089_7928
    dw Data_089_796A
    dw Data_089_798E
    dw Data_089_7A36
    dw Data_089_7B17
    dw Data_089_7B86
    dw Data_089_7BED
    dw Data_089_7C7F
    dw Data_089_7CC8
    dw Data_089_7D7C
    dw Data_089_7E37
    dw Data_089_7F0E

Data_089_41F0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " They say you use", $F1
    db "Magic Keys to go", $FA, $F7
    db $EF, $EE, "to other worlds.", $EF, $EE, "I guess they're", $FA, $F7
    db $EF, $EE, "indispensable to", $EF, $EE, "monster masters.", $F7
    db $F0

Data_089_4260:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Then, you", $F1
    db "are excused.", $FA, $F7
    db $EF, $EE, "I'm looking", $EF, $EE, "forward to the", $FA, $F7
    db $EF, $EE, "next show.", $EF, $EE, $F7
    db $F0

Data_089_42AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You wish to", $F1
    db "see our treasures?", $FA, $F7
    db $EF, $EE, "You're quite sharp", $EF, $EE, "to have an eye out", $FA, $F7
    db $EF, $EE, "for treasures, I", $EF, $EE, "must say.", $F7
    db $F0

Data_089_431C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That will help", $F1
    db "you for certain.", $FA, $F7
    db $EF, $EE, "Use it where you", $EF, $EE, "feel it is right.", $F7
    db $F0

Data_089_4367:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, have you", $F1
    db "found a plug for", $FA, $F7
    db $EF, $EE, "the Log's Navel?", $EF, $EE
    db $FF, $F0

Data_089_43A1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh. That's nice.", $F1
    db "Good for you.", $F7
    db $F0

Data_089_43C3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can show you", $F1
    db "my navel if you", $FA, $F7
    db $EF, $EE, "promise to keep it", $EF, $EE, "a secret.", $F7
    db $F0

Data_089_4407:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The shortage of", $F1
    db "water has been", $FA, $F7
    db $EF, $EE, "corrected, and the", $EF, $EE, "gang of thieves", $FA, $F7
    db $EF, $EE, "was finally caught", $EF, $EE, "and jailed.", $FA, $F7
    db $EF, $EE, "We won't have to", $EF, $EE, "worry about those", $FA, $F7
    db $EF, $EE, "things anymore,", $EF, $EE, "thank goodness.", $F7
    db $F0

Data_089_44BE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, it's you lot.", $F1
    db "We haven't had any", $FA, $F7
    db $EF, $EE, "problems with the", $EF, $EE, "reservoir.", $F7
    db $F0

Data_089_4506:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The well filled", $F1
    db "up with water", $FA, $F7
    db $EF, $EE, "again.", $EF, $EE, "I don't have any", $FA, $F7
    db $EF, $EE, "excuse not to do", $EF, $EE, "laundry anymore.", $F7
    db $F0

Data_089_4569:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The band of", $F1
    db "thieves made their", $FA, $F7
    db $EF, $EE, "hideout in Mirage", $EF, $EE, "Lake.", $FA, $F7
    db $EF, $EE, "Staying away from", $EF, $EE, "Mirage Lake was a", $FA, $F7
    db $EF, $EE, "smart thing in", $EF, $EE, "hindsight.", $F7
    db $F0

Data_089_45EE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King gave", $F1
    db "away his prized", $FA, $F7
    db $EF, $EE, "TidalBell to some", $EF, $EE, "traveler as a", $FA, $F7
    db $EF, $EE, "reward of some", $EF, $EE, "sort.", $FA, $F7
    db $EF, $EE, "I didn't know that", $EF, $EE, "our King could be", $FA, $F7
    db $EF, $EE, "so generous.", $EF, $EE, $F7
    db $F0

Data_089_4687:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Up ahead is the", $F1
    db "Starry Shrine, and", $FA, $F7
    db $EF, $EE, "the Egg Evaluator's", $EF, $EE, "chamber.", $FA, $F7
    db $EF, $EE, "Both of them offer", $EF, $EE, "essential services", $FA, $F7
    db $EF, $EE, "to masters, but", $EF, $EE, "they're always", $FA, $F7
    db $EF, $EE, "packed by other", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "It looks like I'll", $EF, $EE, "be waiting here", $FA, $F7
    db $EF, $EE, "for a long time", $A4, $EF, $EE, $F7
    db $F0

Data_089_4773:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " While I was on", $F1
    db "the way to the", $FA, $F7
    db $EF, $EE, "Magic Door, I saw", $EF, $EE, "Warubou stuck in a", $FA, $F7
    db $EF, $EE, "hole for some", $EF, $EE, "unknown reason.", $FA, $F7
    db $EF, $EE, "What the heck was", $EF, $EE, "it doing?", $F7
    db $F0

Data_089_4800:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're really", $F1
    db "trying to become a", $FA, $F7
    db $EF, $EE, "monster master?", $EF, $EE, "Well, go for it!", $FA, $F7
    db $EF, $EE, "I'll be cheering", $EF, $EE, "you on!", $F7
    db $F0

Data_089_4865:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm, you are", $F1
    db "quite strong", $A4, $FA, $F7
    db $EF, $EE, "I have to admit", $EF, $EE, "I'm impressed.", $FA, $F7
    db $EF, $EE, "Will you let me go", $EF, $EE, "with you?", $FA, $F7
    db $EF, $EE, "You'll find my", $EF, $EE, "dancing special!"
    db $FF, $F0

Data_089_48E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Great! Let's", $F1
    db "make this work!", $F7
    db $F0

Data_089_4909:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your party's", $F1
    db "full", $A4, $FA, $F7
    db $EF, $EE, "There isn't any", $EF, $EE, "room for me.", $F7
    db $F0

Data_089_493F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, but", $A4, " I can", $F1
    db "be so useful", $A4, $F7
    db $F0

Data_089_4960:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The lighthouse", $F1
    db "is out east.", $FA, $F7
    db $EF, $EE, "Stay away-it's", $EF, $EE, "dangerous.", $FA, $F7
    db $EF, $EE, "Even though the", $EF, $EE, "MoonRock has been", $FA, $F7
    db $EF, $EE, "recovered from", $EF, $EE, "pirates and put", $FA, $F7
    db $EF, $EE, "back where it", $EF, $EE, "belongs, monsters", $FA, $F7
    db $EF, $EE, "still roam freely", $EF, $EE, "in the lighthouse.", $F7
    db $F0

Data_089_4A33:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Another master", $F1
    db "was here with two", $FA, $F7
    db $EF, $EE, "monsters in tow a", $EF, $EE, "while back.", $FA, $F7
    db $EF, $EE, "I think his name", $EF, $EE, "was Kameha.", $FA, $F7
    db $EF, $EE, "I haven't seen him", $EF, $EE, "since then.", $FA, $F7
    db $EF, $EE, "I wonder where", $EF, $EE, "he's gone?", $F7
    db $F0

Data_089_4ADA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK! Let me dig!", $F1
    db "One-two, one-two!", $FA, $F7
    db $EF, $EE, "Huh? I just hit", $EF, $EE, "something hard.", $F7
    db $F0

Data_089_4B24:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What's wrong,", $F1
    db "MadGopher?", $FA, $F7
    db $EF, $EE, "Did you find", $EF, $EE, "something?", $FA, $F7
    db $EF, $EE, "Hey, that's a", $EF, $EE, "Magic Key!", $FA, $F7
    db $EF, $EE, "That's great work,", $EF, $EE, "MadGopher!", $F7
    db $F0

Data_089_4B99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here, ", $F9, "0!", $F1
    db "You need this!", $F7
    db $F0

Data_089_4BB6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Ice Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_089_4BD4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Be careful when", $F1
    db "you're traveling", $FA, $F7
    db $EF, $EE, "in other worlds.", $EF, $EE, $F7
    db $F0

Data_089_4C0E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "find another Magic", $FA, $F7
    db $EF, $EE, "Key in GreatLog", $EF, $EE, "and off you go to", $FA, $F7
    db $EF, $EE, "another world,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "The Ice Key is", $EF, $EE, "what you want.", $F7
    db $F0

Data_089_4C97:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0! Too slow!", $FA, $F7
    db $EF, $EE, "Kameha went to", $EF, $EE, "another world", $FA, $F7
    db $EF, $EE, "before you again,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "But then it doesn't", $EF, $EE, "matter who gets", $FA, $F7
    db $EF, $EE, "the job done, you", $EF, $EE, "or Kameha", $A4, $FA, $F7
    db $EF, $EE, "But after last", $EF, $EE, "time, you can be", $FA, $F7
    db $EF, $EE, "trusted more than", $EF, $EE, "Kameha, I think.", $FA, $F7
    db $EF, $EE, "This time, you'll", $EF, $EE, "find a plug, yes?", $FA, $F7
    db $EF, $EE, "Oh, and don't", $EF, $EE, "forget, you have", $FA, $F7
    db $EF, $EE, "new abilities for", $EF, $EE, "crossing water and", $FA, $F7
    db $EF, $EE, "smashing boulders.", $EF, $EE, "Don't forget!", $F7
    db $F0

Data_089_4E20:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King of the", $F1
    db "north was a fake,", $FA, $F7
    db $EF, $EE, "or so I", $42, "e heard.", $EF, $EE, "Why though?", $FA, $F7
    db $EF, $EE, "Why would a", $EF, $EE, "monster want to", $FA, $F7
    db $EF, $EE, "impersonate a", $EF, $EE, "king?", $F7
    db $F0

Data_089_4E9F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you go south,", $F1
    db "you'll eventually", $FA, $F7
    db $EF, $EE, "reach the town of", $EF, $EE, "Weston.", $FA, $F7
    db $EF, $EE, "From there, go up", $EF, $EE, "a river and travel", $FA, $F7
    db $EF, $EE, "west to reach the", $EF, $EE, "castle.", $F7
    db $F0

Data_089_4F2A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " Lady Yuna", $A4, $F1
    db "I miss you so", $A4, $FA, $F7
    db $EF, $EE, "I should find", $EF, $EE, "my courage and", $FA, $F7
    db $EF, $EE, "climb the vines to", $EF, $EE, "her window", $A4, $FA, $F7
    db $EF, $EE, "No, I mustn't do", $EF, $EE, "that", $A4, $F7
    db $F0

Data_089_4FAA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How can we help", $F1
    db "Queen Helen?", $FA, $F7
    db $EF, $EE, "If there was a", $EF, $EE, "good medicine", $A4, $FA, $F7
    db $EF, $EE, "Perhaps we should", $EF, $EE, "ask the scholar", $A4, $FA, $F7
    db $EF, $EE, "But the scholar", $EF, $EE, "has gone off to", $FA, $F7
    db $EF, $EE, "Nofor", $A4, " What to do,", $EF, $EE, "what to do", $A4, $F7
    db $F0

Data_089_505B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh! That blue", $F1
    db "flower!", $FA, $F7
    db $EF, $EE, "It's unmistakably", $EF, $EE, "the SleepHerb!", $FA, $F7
    db $EF, $EE, "All you need to do", $EF, $EE, "is eat its leaves.", $FA, $F7
    db $EF, $EE, "As soon as you do,", $EF, $EE, "you drop off to a", $FA, $F7
    db $EF, $EE, "deep and relaxing", $EF, $EE, "sleep.", $F7
    db $F0

Data_089_5109:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Star spuds grow", $F1
    db "plentifully around", $FA, $F7
    db $EF, $EE, "these parts. They", $EF, $EE, "are spuds that", $FA, $F7
    db $EF, $EE, "grow by the light", $EF, $EE, "of the stars.", $FA, $F7
    db $EF, $EE, "They're gifts from", $EF, $EE, "the spirit.", $F7
    db $F0

Data_089_519B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Out at the", $F1
    db "western castle,", $FA, $F7
    db $EF, $EE, "I heard that no", $EF, $EE, "one managed to", $FA, $F7
    db $EF, $EE, "cheer up Lady Yuna", $EF, $EE, "in the end.", $FA, $F7
    db $EF, $EE, "So, nobody got the", $EF, $EE, "reward.", $F7
    db $F0

Data_089_521F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I just heard a", $F1
    db "rumor", $A4, $FA, $F7
    db $EF, $EE, "The girl's ghost", $EF, $EE, "seems to be gone.", $F7
    db $F0

Data_089_525F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Now that I think", $F1
    db "about it, I'm not", $FA, $F7
    db $EF, $EE, "sure what I saw", $EF, $EE, "was a ghost.", $FA, $F7
    db $EF, $EE, "I may have been", $EF, $EE, "mistaken, even.", $FA, $F7
    db $EF, $EE, "In fact, I'm sure", $EF, $EE, "I was wrong!", $F7
    db $F0

Data_089_52EC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ArmyAnt's help", $F1
    db "means I can open", $FA, $F7
    db $EF, $EE, "my shop just as I", $EF, $EE, "had planned.", $F7
    db $F0

Data_089_5332:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hup, hup, hup!", $F1
    db "Heh, this stuff is", $FA, $F7
    db $EF, $EE, "nothing to move", $EF, $EE, "around!", $F7
    db $F0

Data_089_5374:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "The Crest was", $EF, $EE, "found.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it", $A4, $F7
    db $F0

Data_089_53CE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Sky Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_089_53EC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Kameha made", $F1
    db "off with the Key's", $FA, $F7
    db $EF, $EE, "duplicate from the", $EF, $EE, "Castle.", $FA, $F7
    db $EF, $EE, "I can imagine him", $EF, $EE, "being a nuisance,", $FA, $F7
    db $EF, $EE, "but I'm counting", $EF, $EE, "on your support.", $F7
    db $F0

Data_089_547E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "find another Magic", $FA, $F7
    db $EF, $EE, "Key in GreatLog", $EF, $EE, "and you go off to", $FA, $F7
    db $EF, $EE, "another world,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "The Sky Key, I", $EF, $EE, "think it is.", $F7
    db $F0

Data_089_5505:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0!", $FA, $F7
    db $EF, $EE, "You have the Sky", $EF, $EE, "Key, warooh.", $FA, $F7
    db $EF, $EE, "Kameha took off", $EF, $EE, "before you again.", $FA, $F7
    db $EF, $EE, "I'm beginning to", $EF, $EE, "suffer from this", $A4, $FA, $F7
    db $EF, $EE, "This time, you'll", $EF, $EE, "find a plug, yes?", $FA, $F7
    db $EF, $EE, "Oh, and now, you", $EF, $EE, "have the ability", $FA, $F7
    db $EF, $EE, "to summon a cloud", $EF, $EE, "and fly.", $FA, $F7
    db $EF, $EE, "Sky Shield gave", $EF, $EE, "you that ability.", $FA, $F7
    db $EF, $EE, "Keep that in mind,", $EF, $EE, "warooh!", $F7
    db $F0

Data_089_563B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That giant bird", $F1
    db "hasn't flown over", $FA, $F7
    db $EF, $EE, "for a while.", $EF, $EE, $F7
    db $F0

Data_089_5672:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Was that bird", $F1
    db "going after the", $FA, $F7
    db $EF, $EE, "LightOrb?", $EF, $EE, $F7
    db $F0

Data_089_56A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " They say the", $F1
    db "giant bird has", $FA, $F7
    db $EF, $EE, "disappeared.", $EF, $EE, "I wonder if it's", $FA, $F7
    db $EF, $EE, "safe for me to go", $EF, $EE, "outside now", $A4, $F7
    db $F0

Data_089_5707:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The giant bird", $F1
    db "took off with a", $FA, $F7
    db $EF, $EE, "human child", $A4, $EF, $EE, "Is he safe now?", $F7
    db $F0

Data_089_574B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What if the", $F1
    db "island sinks, and", $FA, $F7
    db $EF, $EE, "you return from", $EF, $EE, "another world?", $FA, $F7
    db $EF, $EE, "Would you suddenly", $EF, $EE, "appear underwater?", $F7
    db $F0

Data_089_57BA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " For the sake of", $F1
    db "my grandchild, it", $FA, $F7
    db $EF, $EE, "may be best that", $EF, $EE, "we leave.", $FA, $F7
    db $EF, $EE, "She may make", $EF, $EE, "friends elsewhere.", $F7
    db $F0

Data_089_5823:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do we have to", $F1
    db "leave GreatLog?", $FA, $F7
    db $EF, $EE, "It doesn't matter,", $EF, $EE, "though.", $FA, $F7
    db $EF, $EE, "There's nothing", $EF, $EE, "here for me.", $F7
    db $F0

Data_089_5883:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You saved us all", $F1
    db "by yourself.", $FA, $F7
    db $EF, $EE, "Your future is so", $EF, $EE, "full of promise!", $F7
    db $F0

Data_089_58CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please, eat up,", $F1
    db "eat up!", $FA, $F7
    db $EF, $EE, "Don't worry about", $EF, $EE, "your manners!", $F7
    db $F0

Data_089_590B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm? I saw your", $F1
    db "family.", $FA, $F7
    db $EF, $EE, "They were up on", $EF, $EE, "the treetop.", $F7
    db $F0

Data_089_5947:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Kingdom is", $F1
    db "rejoicing!", $F7
    db $F0

Data_089_5965:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Instead of", $F1
    db "standing around,", $FA, $F7
    db $EF, $EE, "you should go and", $EF, $EE, "enjoy yourselves.", $F7
    db $F0

Data_089_59AD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Just imagine if", $F1
    db "you weren't here.", $FA, $F7
    db $EF, $EE, "That's a sobering", $EF, $EE, "thought.", $F7
    db $F0

Data_089_59F0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, GreatLog's", $F1
    db "mighty hero!", $FA, $F7
    db $EF, $EE, "I hope you're", $EF, $EE, "enjoying this!", $F7
    db $F0

Data_089_5A2F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " To be honest, I", $F1
    db "was getting ready", $FA, $F7
    db $EF, $EE, "to clear out.", $EF, $EE, "You saved us!", $F7
    db $F0

Data_089_5A75:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $31, $31, $3C, $99, $F7, $F0

Data_089_5A81:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $99, $F7, $F0

Data_089_5A8B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " They say Lady", $F1
    db "Yuna is back to", $FA, $F7
    db $EF, $EE, "her usual cheerful", $EF, $EE, "self.", $FA, $F7
    db $EF, $EE, "Perhaps she's still", $EF, $EE, "too young to mope", $FA, $F7
    db $EF, $EE, "over matters of", $EF, $EE, "the heart", $A4, $F7
    db $F0

Data_089_5B12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Huh? There is", $F1
    db "something here.", $FA, $F7
    db $EF, $EE, "Under the", $EF, $EE, "merchandise.", $F7
    db $F0

Data_089_5B4F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What's that?", $F1
    db "Hey, a TinyMedal!", $FA, $F7
    db $EF, $EE, "That took good,", $EF, $EE, "compound eyes to", $FA, $F7
    db $EF, $EE, "spot on the ground", $EF, $EE, "like that!", $F7
    db $F0

Data_089_5BB8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like you to", $F1
    db "have this.", $FA, $F7
    db $EF, $EE, "Sort of a thanks", $EF, $EE, "for ArmyAnt.", $F7
    db $F0

Data_089_5BF8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "TinyMedal!", $F7
    db $F0

Data_089_5C12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll pray for", $F1
    db "your safety.", $FA, $F7
    db $EF, $EE, "Take good care of", $EF, $EE, "yourself.", $F7
    db $F0

Data_089_5C50:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like you to", $F1
    db "have this.", $FA, $F7
    db $EF, $EE, "Sort of a thanks", $EF, $EE, "for ArmyAnt.", $FA, $F7
    db $EF, $EE, "Oh, wait. There's", $EF, $EE, "no room for this.", $FA, $F7
    db $EF, $EE, "I'll leave it with", $EF, $EE, "my ArmyAnt, so be", $FA, $F7
    db $EF, $EE, "sure to come get", $EF, $EE, "it later.", $F7
    db $F0

Data_089_5CFE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here it is-the", $F1
    db "TinyMedal.", $FA, $F7
    db $EF, $EE, "My master had me", $EF, $EE, "hold it for you.", $F7
    db $F0

Data_089_5D42:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here it is-the", $F1
    db "TinyMedal.", $FA, $F7
    db $EF, $EE, "My master had me", $EF, $EE, "hold it for you.", $FA, $F7
    db $EF, $EE, $A4, "You still don't", $EF, $EE, "have room for it", $A4, $F7
    db $F0

Data_089_5DAC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What's wrong,", $F1
    db "MadGopher?", $FA, $F7
    db $EF, $EE, "Did you dig", $EF, $EE, "something up?", $FA, $F7
    db $EF, $EE, "Oh, hey!", $EF, $EE, "That's a TinyMedal!", $FA, $F7
    db $EF, $EE, "Good going,", $EF, $EE, "MadGopher!", $F7
    db $F0

Data_089_5E21:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here, ", $F9, "0!", $F1
    db "You hold onto it.", $F7
    db $F0

Data_089_5E41:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here, ", $F9, "0!", $F1
    db "You hold onto it.", $FA, $F7
    db $EF, $EE, "Oh, but look, you", $EF, $EE, "have no room.", $FA, $F7
    db $EF, $EE, "MadGopher will", $EF, $EE, "hold it for you.", $F7
    db $F0

Data_089_5EA9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here's that", $F1
    db "TinyMedal.", $F7
    db $F0

Data_089_5EC3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here's that", $F1
    db "TinyMedal.", $FA, $F7
    db $EF, $EE, $A4, "Wait, you still", $EF, $EE, "have no room.", $F7
    db $F0

Data_089_5F00:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What's that?", $F1
    db "Hey, a Magic Key!", $FA, $F7
    db $EF, $EE, "How did you manage", $EF, $EE, "to find that?", $F7
    db $F0

Data_089_5F47:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, $A4, $A4, "?", $F1
    db "You startled me", $A4, $FA, $F7
    db $EF, $EE, "I don't remember", $EF, $EE, "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "But you don't seem", $EF, $EE, "to know who I am", $A4, $F7
    db $F0

Data_089_5FF4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't remember", $F1
    db "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "But you don't seem", $EF, $EE, "to know who I am", $A4, $F7
    db $F0

Data_089_6086:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm digging here", $F1
    db "because I think", $FA, $F7
    db $EF, $EE, "this hole leads", $EF, $EE, "somewhere", $A4, $F7
    db $F0

Data_089_60C9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pick the monster", $F1
    db "to go to the farm.", $F7
    db $F0

Data_089_60EE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N joined", $F1
    db "the party."
    db $E5, $D6, $F7, $F0

Data_089_6106:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N headed off", $F1
    db "to the farm."
    db $E5, $D6, $F7, $F0

Data_089_6124:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Wait, the farm", $F1
    db "is full", $A4, $F7
    db $F0

Data_089_6141:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me join your", $F1
    db "party?"
    db $FF, $F0

Data_089_615D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "The farm has no", $F1
    db "room left for me", $A4, $F7
    db $F0

Data_089_6184:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What will you give", $F1
    db "to the Egg?", $F7
    db $F0

Data_089_61A4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "Y has been", $F1
    db "given to the Egg.", $FA, $F7
    db $EF, $EE, "What will you give", $EF, $EE, "it next?", $F7
    db $F0

Data_089_61E3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The farm is full.", $F7
    db $F0

Data_089_61F6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lamia entered", $F1
    db "the farm.", $F7
    db $F0

Data_089_620F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dimensaur entered", $F1
    db "the farm.", $F7
    db $F0

Data_089_622C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kagebou entered", $F1
    db "the farm.", $F7
    db $F0

Data_089_6247:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cataloged", $F1
    db "100 monsters.", $F7
    db $F0

Data_089_6263:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cataloged", $F1
    db "200 monsters.", $F7
    db $F0

Data_089_627F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cataloged", $F1
    db "all the monsters.", $F7
    db $F0

Data_089_629F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Really? Let's go", $F1
    db "to the Arena!", $F7
    db $F0

Data_089_62C1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aww", $A4, " How boring", $A4, $F1
    db "Visit us again!", $F7
    db $F0

Data_089_62E6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aww", $A4, " I lose.", $F1
    db "You are good!", $FA, $F7
    db $EF, $EE, "I wasn't trying", $EF, $EE, "very hard", $A4, $FA, $F7
    db $EF, $EE, "Eheheh, actually,", $EF, $EE, "I did want to win.", $F7
    db $F0

Data_089_634C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Yay! I won!", $F1
    db "Am I awesome?", $F7
    db $F0

Data_089_636A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some monsters", $F1
    db "may be tough, but", $FA, $F7
    db $EF, $EE, "they could have", $EF, $EE, "surprising weak", $FA, $F7
    db $EF, $EE, "spots that can be", $EF, $EE, "exploited.", $FA, $F7
    db $EF, $EE, "Skills and dances", $EF, $EE, "that cause status", $FA, $F7
    db $EF, $EE, "problems can come", $EF, $EE, "in very handy.", $F7
    db $F0

Data_089_6420:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A master who can", $F1
    db "satisfy me", $A4, $FA, $F7
    db $EF, $EE, "Does such a", $EF, $EE, "battler exist?", $F7
    db $F0

Data_089_6460:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! Do you", $F1
    db "wish to battle?", $F0

Data_089_6483:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog is a", $F1
    db "floating island?", $FA, $F7
    db $EF, $EE, "If I dig any more,", $EF, $EE, "the bottom'll go.", $F7
    db $F0

Data_089_64CE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I teased you as", $F1
    db "a cute rival", $A4, $FA, $F7
    db $EF, $EE, "But you", $42, "e gone", $EF, $EE, "far beyond me.", $F7
    db $F0

Data_089_6512:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, well!", $F1
    db "If it isn't the", $FA, $F7
    db $EF, $EE, "little hero who", $EF, $EE, "saved GreatLog?", $FA, $F7
    db $EF, $EE, "Make yourself at", $EF, $EE, "home and shop!", $FA, $F7
    db $EF, $EE, "What can I do for", $EF, $EE, "you today?", $F7
    db $F0

Data_089_659A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My ArmyAnt,", $F1
    db "which I got from a", $FA, $F7
    db $EF, $EE, "monster master,", $EF, $EE, "made it possible", $FA, $F7
    db $EF, $EE, "for me to open", $EF, $EE, "this shop.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

Data_089_661F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You might know", $F1
    db "this already, but", $FA, $F7
    db $EF, $EE, "this is a good", $EF, $EE, "breeding pair,", $FA, $F7
    db $EF, $EE, "LizardMan and", $EF, $EE, "WingSlime.", $FA, $F7
    db $EF, $EE, "That will make you", $EF, $EE, "a Rayburn.", $F7
    db $F0

Data_089_66A5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wata, wata.", $F1
    db "Terry battled in", $FA, $F7
    db $EF, $EE, "the Starry Night", $EF, $EE, "Tournament as", $FA, $F7
    db $EF, $EE, "GreatTree's master,", $EF, $EE, "wataah.", $F7
    db $F0

Data_089_6708:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fwahahahaha!", $F1
    db "How amusing!", $FA, $F7
    db $EF, $EE, "Even I fell before", $EF, $EE, "Terry's might!", $FA, $F7
    db $EF, $EE, "How you fare shall", $EF, $EE, "be intriguing.", $F7
    db $F0

Data_089_6771:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " heard of a", $F1
    db "little hero", $A4, $FA, $F7
    db $EF, $EE, "But, it seems to", $EF, $EE, "be a bogus lead.", $FA, $F7
    db $EF, $EE, "I'll continue with", $EF, $EE, "my travels", $A4, $F7
    db $F0

Data_089_67D8:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What a scruffy", $F1
    db "lot of masters", $A4, $FA, $F7
    db $EF, $EE, "I shouldn't believe", $EF, $EE, "vague rumors", $A4, $F7
    db $F0

Data_089_6820:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Humph", $A4, $F1
    db "I'm Terry.", $FA, $F7
    db $EF, $EE, "Terry", $A3, " I'm a master", $EF, $EE, "from GreatTree.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " heard about", $EF, $EE, "GreatLog's heroic", $FA, $F7
    db $EF, $EE, "master, so I came", $EF, $EE, "to look.", $FA, $F7
    db $EF, $EE, "But you can't be", $EF, $EE, "that master, you", $FA, $F7
    db $EF, $EE, "don't have a full", $EF, $EE, "party.", $F7
    db $F0

Data_089_68E0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0, you were", $F1
    db "so busy saving", $FA, $F7
    db $EF, $EE, "GreatLog that you", $EF, $EE, "forgot all about", $FA, $F7
    db $EF, $EE, "my errand, didn't", $EF, $EE, "you?", $FA, $F7
    db $EF, $EE, "I went and got the", $EF, $EE, "LoveWater myself.", $F7
    db $F0

Data_089_696A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I think I", $F1
    db "have the natural", $FA, $F7
    db $EF, $EE, "talent to be a", $EF, $EE, "master.", $FA, $F7
    db $EF, $EE, $A4, "Don't give me", $EF, $EE, "that look!", $FA, $F7
    db $EF, $EE, "You don't believe", $EF, $EE, "me at all.", $FA, $F7
    db $EF, $EE, "Just you watch,", $EF, $EE, $F9, "0.", $FA, $F7
    db $EF, $EE, "I'll surpass you", $EF, $EE, "in no time!", $F7
    db $F0

Data_089_6A1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We", $42, "e had reports", $F1
    db "of rogue masters", $FA, $F7
    db $EF, $EE, "who terrorize", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "We're investigating", $EF, $EE, "these reports, but", $FA, $F7
    db $EF, $EE, "it's serious if", $EF, $EE, "they're true!", $F7
    db $F0

Data_089_6AAF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2B, $AB, $90, $25, $2F, $28, $36, $36, $90, $3C, $32, $38
    db $99, $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "As GreatLog's hero,", $F1
    db "you set a shining", $FA, $F7
    db $EF, $EE, "example to other", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "Thanks to you, our", $EF, $EE, "Kingdom's honor", $FA, $F7
    db $EF, $EE, "has been kept", $EF, $EE, "untarnished!", $F7
    db $F0

Data_089_6B4F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That's cold of you.", $FA, $F7
    db $EF, $EE, "After all we", $42, "e", $EF, $EE, "been through", $A4, $FA, $F7
    db $EF, $EE, "Yet you refuse me,", $EF, $EE, "warooh?", $F7
    db $F0

Data_089_6BB5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our church is", $F1
    db "impoverished, so", $FA, $F7
    db $EF, $EE, "I was sent out to", $EF, $EE, "this village.", $FA, $F7
    db $EF, $EE, "I can heal you of", $EF, $EE, "poison, nullify", $FA, $F7
    db $EF, $EE, "curses, and raise", $EF, $EE, "those knocked out.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you?", $F7
    db $F0

Data_089_6C64:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our church is", $F1
    db "impoverished, so", $FA, $F7
    db $EF, $EE, "I was sent out to", $EF, $EE, "this village.", $FA, $F7
    db $EF, $EE, "The slow pace of", $EF, $EE, "life here makes", $FA, $F7
    db $EF, $EE, "one lose sight of", $EF, $EE, "the flowing time.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you?", $F7
    db $F0

Data_089_6D11:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I was the plug in", $FA, $F7
    db $EF, $EE, "the Log's Navel for", $EF, $EE, "a long time!", $FA, $F7
    db $EF, $EE, "The pie is my", $EF, $EE, "reward, warooh!", $FA, $F7
    db $EF, $EE, "I get to eat lots", $EF, $EE, "of it!", $F7
    db $F0

Data_089_6D99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I went and", $F1
    db "faced danger in", $FA, $F7
    db $EF, $EE, "other worlds for", $EF, $EE, "GreatLog's sake!", $FA, $F7
    db $EF, $EE, "All you did was", $EF, $EE, "loaf around here!", $F7
    db $F0

Data_089_6E09:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " WA-HEY!", $F1
    db "Some Prince!", $FA, $F7
    db $EF, $EE, "Always a dirty", $EF, $EE, "mouth, warooh!", $F7
    db $F0

Data_089_6E4B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " You're a", $F1
    db "glutton!", $FA, $F7
    db $EF, $EE, "You haven't changed", $EF, $EE, "at all, glutton!", $F7
    db $F0

Data_089_6E8E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Pot-kettle-", $F1
    db "black, you two.", $FA, $F7
    db $EF, $EE, "You both need to", $EF, $EE, "smarten up.", $F7
    db $F0

Data_089_6ED3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You two went", $F1
    db "through all that,", $FA, $F7
    db $EF, $EE, "but you haven't", $EF, $EE, "wised up at all?", $F7
    db $F0

Data_089_6F1E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Now look, warooh!", $FA, $F7
    db $EF, $EE, "It's your fault", $EF, $EE, "they find us!", $F7
    db $F0

Data_089_6F64:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " No one's", $F1
    db "taking this pie", $FA, $F7
    db $EF, $EE, "away from me!", $EF, $EE, $F7
    db $F0

Data_089_6F99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "I have seen this", $A4, $F7
    db $F0

Data_089_6FBE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " That's enough", $F1
    db "already.", $F7
    db $F0

Data_089_6FDC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "What if you break", $EF, $EE, "the plug again?", $F7
    db $F0

Data_089_7001:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "the ability to", $FA, $F7
    db $EF, $EE, "cross the sea is", $EF, $EE, "in you, warooh!", $FA, $F7
    db $EF, $EE, "Talk to the sea,", $EF, $EE, "and it will reply.", $FA, $F7
    db $EF, $EE, "Wa-hey? I felt an", $EF, $EE, "odd power!", $FA, $F7
    db $EF, $EE, "It's the sea!", $EF, $EE, "It's calling!", $FA, $F7
    db $EF, $EE, "A dilapidated", $EF, $EE, "pirate ship is", $FA, $F7
    db $EF, $EE, "what I see on the", $EF, $EE, "sea, warooh.", $FA, $F7
    db $EF, $EE, "But this time, you", $EF, $EE, "must find the key.", $FA, $F7
    db $EF, $EE, "It's right here in", $EF, $EE, "GreatLog, I think.", $FA, $F7
    db $EF, $EE, "The Pirate Key is", $EF, $EE, "what you want.", $F7
    db $F0

Data_089_716B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you can now crush", $FA, $F7
    db $EF, $EE, "huge boulders,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "You try in front", $EF, $EE, "of a boulder or a", $FA, $F7
    db $EF, $EE, "tree that's in the", $EF, $EE, "way. Anyway", $A4, $FA, $F7
    db $EF, $EE, $F9, "0, you will go", $EF, $EE, "look again?", $FA, $F7
    db $EF, $EE, "Wa-hey? I felt an", $EF, $EE, "odd power!", $FA, $F7
    db $EF, $EE, "It's cold!", $EF, $EE, "It's in ice!", $FA, $F7
    db $EF, $EE, "You know what I'm", $EF, $EE, "going to say", $A4, $FA, $F7
    db $EF, $EE, "I don't have the", $EF, $EE, "key, warooh.", $FA, $F7
    db $EF, $EE, "The Ice Key is", $EF, $EE, "what you want.", $F7
    db $F0

Data_089_72B6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's exciting to", $F1
    db "think where an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key will take you.", $F7
    db $F0

Data_089_7300:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The shoals that", $F1
    db "ringed the volcano", $FA, $F7
    db $EF, $EE, "have suddenly", $EF, $EE, "disappeared.", $FA, $F7
    db $EF, $EE, "The sea can be so", $EF, $EE, "mysterious.", $F7
    db $F0

Data_089_7368:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What is it?", $F1
    db "Ah, it's you.", $FA, $F7
    db $EF, $EE, "What's that?", $EF, $EE, "The MoonRock?", $FA, $F7
    db $EF, $EE, "Ah, the mermaids", $EF, $EE, "helped you!", $F7
    db $F0

Data_089_73C4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome, my", $F1
    db "young hero!", $FA, $F7
    db $EF, $EE, "No words could", $EF, $EE, "ever do justice", $FA, $F7
    db $EF, $EE, "for the gratitude", $EF, $EE, "I feel for you.", $FA, $F7
    db $EF, $EE, "Instead, take this", $EF, $EE, "ring.", $FA, $F7
    db $EF, $EE, "I found it inside", $EF, $EE, "a sunken ship.", $FA, $F7
    db $EF, $EE, "It is best that it", $EF, $EE, "be returned to a", $FA, $F7
    db $EF, $EE, "human, namely you.", $EF, $EE, $F7
    db $F0

Data_089_74AB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Sailor Ring.", $F7
    db $F0

Data_089_74C9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome, my", $F1
    db "young hero!", $FA, $F7
    db $EF, $EE, "No words could", $EF, $EE, "ever do justice", $FA, $F7
    db $EF, $EE, "for the gratitude", $EF, $EE, "I feel for you.", $FA, $F7
    db $EF, $EE, "Instead, take this", $EF, $EE, "ring.", $FA, $F7
    db $EF, $EE, "Ah, but you have", $EF, $EE, "no room for it.", $FA, $F7
    db $EF, $EE, "I'll keep it till", $EF, $EE, "you make room.", $F7
    db $F0

Data_089_7594:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna has", $F1
    db "always been highly", $FA, $F7
    db $EF, $EE, "energetic and", $EF, $EE, "rambunctious.", $FA, $F7
    db $EF, $EE, "We had a dickens", $EF, $EE, "of a time because", $FA, $F7
    db $EF, $EE, "she would always", $EF, $EE, "sneak off.", $F7
    db $F0

Data_089_7620:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How can we save", $F1
    db "Queen Helen?", $FA, $F7
    db $EF, $EE, "According to some", $EF, $EE, "medical books,", $FA, $F7
    db $EF, $EE, "there is something", $EF, $EE, "called SleepHerb.", $FA, $F7
    db $EF, $EE, "The scholar may", $EF, $EE, "know, but he has", $FA, $F7
    db $EF, $EE, "gone on a study", $EF, $EE, "trip to Nofor.", $F7
    db $F0

Data_089_76D7:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me show you", $F1
    db "my resurrected", $FA, $F7
    db $EF, $EE, "powers", $A4, $EF, $EE, $F7
    db $F0

Data_089_7707:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you can now fly", $FA, $F7
    db $EF, $EE, "across the sky on", $EF, $EE, "a cloud, warooh!", $FA, $F7
    db $EF, $EE, "You try at the", $EF, $EE, "edge of land and", $FA, $F7
    db $EF, $EE, "the open sky.", $EF, $EE, "Anyway", $A4, $FA, $F7
    db $EF, $EE, $F9, "0, you will go", $EF, $EE, "look again?", $FA, $F7
    db $EF, $EE, "Wa-hey? I felt an", $EF, $EE, "odd power!", $FA, $F7
    db $EF, $EE, "I see it! A land", $EF, $EE, "floating way up", $FA, $F7
    db $EF, $EE, "high in the sky,", $EF, $EE, "warooh!", $FA, $F7
    db $EF, $EE, "The Sky Key is", $EF, $EE, "what you want.", $F7
    db $F0

Data_089_7834:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " YOUR LIFE ENDS", $F1
    db "HERE! GIVE IT UP!", $F7
    db $F0

Data_089_7859:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " KAHAHAHA!", $F1
    db "THEN LEAVE!", $F7
    db $F0

Data_089_7873:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I see", $A4, " But I", $F1
    db "will crush you!", $F7
    db $F0

Data_089_7894:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I see", $A4, " Then", $F1
    db "leave at once.", $F7
    db $F0

Data_089_78B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Impetuous fool!", $F1
    db "I'll show you!", $FA, $F7
    db $EF, $EE, "Come hither, my", $EF, $EE, "servants!", $F7
    db $F0

Data_089_78F3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm, fine, I'll", $F1
    db "ignore it.", $FA, $F7
    db $EF, $EE, "But just this", $EF, $EE, "time!", $F7
    db $F0

Data_089_7928:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The princess did", $F1
    db "not reply.", $FA, $F7
    db $EF, $EE, "But a malevolent", $EF, $EE, "voice spoke up", $A4, $F7
    db $F0

Data_089_796A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $95, "Inn downstairs.", $F1
    db "Rooms available.", $95, $F7
    db $F0

Data_089_798E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you breed,", $F1
    db "the parents go", $FA, $F7
    db $EF, $EE, "away somewhere,", $EF, $EE, "and their baby", $FA, $F7
    db $EF, $EE, "hatches at just", $EF, $EE, "level 1.", $FA, $F7
    db $EF, $EE, "But the baby will", $EF, $EE, "grow to surpass", $FA, $F7
    db $EF, $EE, "its parents if you", $EF, $EE, "raise it.", $F7
    db $F0

Data_089_7A36:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monster skills", $F1
    db "are passed on from", $FA, $F7
    db $EF, $EE, "parents to their", $EF, $EE, "offspring.", $FA, $F7
    db $EF, $EE, "Retain the skills", $EF, $EE, "you like on your", $FA, $F7
    db $EF, $EE, "monsters, and keep", $EF, $EE, "breeding them.", $FA, $F7
    db $EF, $EE, "Eventually, you'll", $EF, $EE, "have monsters that", $FA, $F7
    db $EF, $EE, "possess the moves", $EF, $EE, "you like best.", $F7
    db $F0

Data_089_7B17:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Nightmares so", $F1
    db "horrible that they", $FA, $F7
    db $EF, $EE, "keep Queen Helen", $EF, $EE, "from sleeping", $A4, $FA, $F7
    db $EF, $EE, "What is happening", $EF, $EE, "to the kingdom?", $F7
    db $F0

Data_089_7B86:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our hearts are", $F1
    db "like the skies", $FA, $F7
    db $EF, $EE, "above-heavy and", $EF, $EE, "clouded", $A4, $FA, $F7
    db $EF, $EE, "We're all starved", $EF, $EE, "for cheerful news.", $F7
    db $F0

Data_089_7BED:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen is", $F1
    db "wracked by awful", $FA, $F7
    db $EF, $EE, "nightmares night", $EF, $EE, "after night", $A4, $FA, $F7
    db $EF, $EE, "She's managed only", $EF, $EE, "snatches of sleep", $A4, $FA, $F7
    db $EF, $EE, "It's left her in a", $EF, $EE, "cranky mood", $A4, $F7
    db $F0

Data_089_7C7F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The reception", $F1
    db "hall is beyond", $FA, $F7
    db $EF, $EE, "here. Our Queen is", $EF, $EE, "waiting for you.", $F7
    db $F0

Data_089_7CC8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our Queen Helen's", $F1
    db "premonition made", $FA, $F7
    db $EF, $EE, "it possible for us", $EF, $EE, "to overcome the", $FA, $F7
    db $EF, $EE, "terrible cold", $EF, $EE, "spell for now", $A4, $FA, $F7
    db $EF, $EE, "But if the cold", $EF, $EE, "weather persists,", $FA, $F7
    db $EF, $EE, "who knows what", $EF, $EE, "will happen?", $F7
    db $F0

Data_089_7D7C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What is it?", $F1
    db "Leave at once!", $FA, $F7
    db $EF, $EE, "This is no place", $EF, $EE, "for a child!", $FA, $F7
    db $EF, $EE, "What? Lady Yuna of", $EF, $EE, "the west?", $FA, $F7
    db $EF, $EE, "She's behaving in", $EF, $EE, "a peculiar manner?", $FA, $F7
    db $EF, $EE, "What rot!", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That is of no", $EF, $EE, "concern to me!", $F7
    db $F0

Data_089_7E37:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This happened", $F1
    db "when I was deep in", $FA, $F7
    db $EF, $EE, "the forest far to", $EF, $EE, "the west.", $FA, $F7
    db $EF, $EE, "A young girl just", $EF, $EE, "appeared and she", $FA, $F7
    db $EF, $EE, "sort of glided", $EF, $EE, "over to me without", $FA, $F7
    db $EF, $EE, "moving her feet", $EF, $EE, "one bit.", $FA, $F7
    db $EF, $EE, "I turned and ran,", $EF, $EE, "but she followed!", $F7
    db $F0

Data_089_7F0E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My father is so", $F1
    db "cowardly, getting", $FA, $F7
    db $EF, $EE, "all spooked by a", $EF, $EE, "ghost.", $FA, $F7
    db $EF, $EE, "Your monsters", $EF, $EE, "frighten me more.", $F7
    db $F0
    ds $8C, $00
