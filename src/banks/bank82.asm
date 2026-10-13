SECTION "Bank 82", ROMX[$4000], BANK[$82]
    db $82

; message bank $82: when wStringIndex < $90, BeginStringDisplay with this bank's table
; MessageStrings_Bank82; otherwise far-calls BeginStringDisplay_Bank82_Overflow (E-0080)
BeginStringDisplay_Bank82::
    ld a, [wStringIndex]
    cp $90
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank82_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank82
    call BeginStringDisplay
    ret

; message bank $82: when wStringIndex < $90, CopyStringToBuffer with this bank's table
; MessageStrings_Bank82; otherwise far-calls the BeginStringDisplay overflow entry
; (BeginStringDisplay_Bank82_Overflow), not the copy entry CopyStringToBuffer_Bank82_Overflow, so
; strings $90 and up are not copied: the destination is left unchanged (executed, test
; Bank82OverflowCopyDoesNotCopy; a likely game bug) (E-0080, E-0154)
CopyStringToBuffer_Bank82::
    ld a, [wStringIndex]
    cp $90
    jr c, .call_copy_string_to_buffer
    farcall BeginStringDisplay_Bank82_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank82
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_82_4032::
MessageStrings_Bank82::
    dw StringList_82_4034 ; id 0

; category list of StringCategories_82_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_82_4034::
    dw Message_0B_00 ; id 0
    dw Message_0B_01 ; id 1
    dw Message_0B_02 ; id 2
    dw Message_0B_03 ; id 3
    dw Message_0B_04 ; id 4
    dw Message_0B_05 ; id 5
    dw Message_0B_06 ; id 6
    dw Message_0B_07 ; id 7
    dw Message_0B_08 ; id 8
    dw Message_0B_09 ; id 9
    dw Message_0B_0A ; id 10
    dw Message_0B_0B ; id 11
    dw Message_0B_0C ; id 12
    dw Message_0B_0D ; id 13
    dw Message_0B_0E ; id 14
    dw Message_0B_0F ; id 15
    dw Message_0B_10 ; id 16
    dw Message_0B_11 ; id 17
    dw Message_0B_12 ; id 18
    dw Message_0B_13 ; id 19
    dw Message_0B_14 ; id 20
    dw Message_0B_15 ; id 21
    dw Message_0B_16 ; id 22
    dw Message_0B_17 ; id 23
    dw Message_0B_18 ; id 24
    dw Message_0B_19 ; id 25
    dw Message_0B_1A ; id 26
    dw Message_0B_1B ; id 27
    dw Message_0B_1C ; id 28
    dw Message_0B_1D ; id 29
    dw Message_0B_1E ; id 30
    dw Message_0B_1F ; id 31
    dw Message_0B_20 ; id 32
    dw Message_0B_21 ; id 33
    dw Message_0B_22 ; id 34
    dw Message_0B_23 ; id 35
    dw Message_0B_24 ; id 36
    dw Message_0B_25 ; id 37
    dw Message_0B_26 ; id 38
    dw Message_0B_27 ; id 39
    dw Message_0B_28 ; id 40
    dw Message_0B_29 ; id 41
    dw Message_0B_2A ; id 42
    dw Message_0B_2B ; id 43
    dw Message_0B_2C ; id 44
    dw Message_0B_2D ; id 45
    dw Message_0B_2E ; id 46
    dw Message_0B_2F ; id 47
    dw Message_0B_30 ; id 48
    dw Message_0B_31 ; id 49
    dw Message_0B_32 ; id 50
    dw Message_0B_33 ; id 51
    dw Message_0B_34 ; id 52
    dw Message_0B_34 ; id 53
    dw Message_0B_34 ; id 54
    dw Message_0B_34 ; id 55
    dw Message_0B_34 ; id 56
    dw Message_0B_34 ; id 57
    dw Message_0B_34 ; id 58
    dw Message_0B_34 ; id 59
    dw Message_0B_34 ; id 60
    dw Message_0B_34 ; id 61
    dw Message_0B_34 ; id 62
    dw Message_0B_34 ; id 63
    dw Message_0B_34 ; id 64
    dw Message_0B_34 ; id 65
    dw Message_0B_34 ; id 66
    dw Message_0B_43 ; id 67
    dw Message_0B_44 ; id 68
    dw Message_0B_45 ; id 69
    dw Message_0B_46 ; id 70
    dw Message_0B_47 ; id 71
    dw Message_0B_48 ; id 72
    dw Message_0B_49 ; id 73
    dw Message_0B_4A ; id 74
    dw Message_0B_4B ; id 75
    dw Message_0B_4C ; id 76
    dw Message_0B_4D ; id 77
    dw Message_0B_4E ; id 78
    dw Message_0B_4F ; id 79
    dw Message_0B_50 ; id 80
    dw Message_0B_51 ; id 81
    dw Message_0B_52 ; id 82
    dw Message_0B_53 ; id 83
    dw Message_0B_54 ; id 84
    dw Message_0B_55 ; id 85
    dw Message_0B_56 ; id 86
    dw Message_0B_57 ; id 87
    dw Message_0B_58 ; id 88
    dw Message_0B_59 ; id 89
    dw Message_0B_5A ; id 90
    dw Message_0B_5B ; id 91
    dw Message_0B_5C ; id 92
    dw Message_0B_5D ; id 93
    dw Message_0B_5E ; id 94
    dw Message_0B_5F ; id 95
    dw Message_0B_60 ; id 96
    dw Message_0B_61 ; id 97
    dw Message_0B_61 ; id 98
    dw Message_0B_61 ; id 99
    dw Message_0B_61 ; id 100
    dw Message_0B_61 ; id 101
    dw Message_0B_66 ; id 102
    dw Message_0B_67 ; id 103
    dw Message_0B_68 ; id 104
    dw Message_0B_69 ; id 105
    dw Message_0B_6A ; id 106
    dw Message_0B_6B ; id 107
    dw Message_0B_6C ; id 108
    dw Message_0B_6D ; id 109
    dw Message_0B_6E ; id 110
    dw Message_0B_6F ; id 111
    dw Message_0B_70 ; id 112
    dw Message_0B_71 ; id 113
    dw Message_0B_72 ; id 114
    dw Message_0B_73 ; id 115
    dw Message_0B_74 ; id 116
    dw Message_0B_75 ; id 117
    dw Message_0B_76 ; id 118
    dw Message_0B_77 ; id 119
    dw Message_0B_78 ; id 120
    dw Message_0B_79 ; id 121
    dw Message_0B_7A ; id 122
    dw Message_0B_7B ; id 123
    dw Message_0B_7C ; id 124
    dw Message_0B_7D ; id 125
    dw Message_0B_7E ; id 126
    dw Message_0B_7F ; id 127
    dw Message_0B_80 ; id 128
    dw Message_0B_81 ; id 129
    dw Message_0B_82 ; id 130
    dw Message_0B_83 ; id 131
    dw Message_0B_84 ; id 132
    dw Message_0B_85 ; id 133
    dw Message_0B_86 ; id 134
    dw Message_0B_87 ; id 135
    dw Message_0B_88 ; id 136
    dw Message_0B_89 ; id 137
    dw Message_0B_8A ; id 138
    dw Message_0B_8B ; id 139
    dw Message_0B_8C ; id 140
    dw Message_0B_8D ; id 141
    dw Message_0B_8E ; id 142
    dw Message_0B_8F ; id 143

Message_0B_00::
    db $eb, "*: The weather is", $f1
    db "beautiful again.", $fa, $f7
    db $ef, $ee, "If you're going", $ef, $ee, "out to play, take", $fa, $f7
    db $ef, $ee, "some monsters out", $ef, $ee, "for exercise.", $fa, $f7
    db $ef, $ee, "They're unhappy", $ef, $ee, "about being cooped", $fa, $f7
    db $ef, $ee, "up all the time.", $ef, $ee, "Be good to them!", $f7
    db $f0

Message_0B_01::
    db $ea, "*: You and your", $f1
    db "monsters saved", $fa, $f7
    db $ef, $ee, "GreatLog from a", $ef, $ee, "terrible crisis.", $fa, $f7
    db $ef, $ee, "I'm proud of you,", $ef, $ee, $f9, "0!", $f7
    db $f0

Message_0B_02::
    db $ea, "Cobi: ", $f9, "0, I", $f1
    db "envied you for", $fa, $f7
    db $ef, $ee, "being in other", $ef, $ee, "worlds", $a4, $fa, $f7
    db $ef, $ee, "But lately, I'm", $ef, $ee, "finding the farm", $fa, $f7
    db $ef, $ee, "work to be a lot", $ef, $ee, "of fun.", $fa, $f7
    db $ef, $ee, "Monsters respond", $ef, $ee, "to your love.", $fa, $f7
    db $ef, $ee, "The better you", $ef, $ee, "take care of them,", $fa, $f7
    db $ef, $ee, "the more they will", $ef, $ee, "work for you.", $fa, $f7
    db $ef, $ee, "Anyway, what do", $ef, $ee, "you need, sis?", $f7
    db $f0

Message_0B_03::
    db $eb, "Tara: ", $f9, "0, I was", $f1
    db "a little jealous", $fa, $f7
    db $ef, $ee, "of you at first,", $ef, $ee, "but now I'm having", $fa, $f7
    db $ef, $ee, "fun working at the", $ef, $ee, "farm.", $fa, $f7
    db $ef, $ee, "Treat them with", $ef, $ee, "love and monsters", $fa, $f7
    db $ef, $ee, "will love you", $ef, $ee, "back.", $fa, $f7
    db $ef, $ee, "Anyway, did you", $ef, $ee, "need something?", $f7
    db $f0

Message_0B_04::
    db $ea, "*: I heard about a", $f1
    db "world of slime.", $fa, $f7
    db $ef, $ee, "Everywhere you go,", $ef, $ee, "all you ever see", $fa, $f7
    db $ef, $ee, "are members of my", $ef, $ee, "family!", $f7
    db $f0

Message_0B_05::
    db $ea, "*: This rope, it", $f1
    db "was not needed.", $fa, $f7
    db $ef, $ee, "But if I stretch", $ef, $ee, "it more and more,", $fa, $f7
    db $ef, $ee, "perhaps it will", $ef, $ee, "reach the clouds.", $f7
    db $f0

Message_0B_06::
    db $ea, "*: Many kinds of", $f1
    db "monsters result", $fa, $f7
    db $ef, $ee, "from breeding.", $ef, $ee, "For example, breed", $fa, $f7
    db $ef, $ee, "me with a beast", $ef, $ee, "family mate, and", $fa, $f7
    db $ef, $ee, "you'll get a baby", $ef, $ee, "FoxFire.", $f7
    db $f0

Message_0B_07::
    db $ea, "*: A world with", $f1
    db "lots of trees and", $fa, $f7
    db $ef, $ee, "water-that would", $ef, $ee, "be the ultimate.", $fa, $f7
    db $ef, $ee, "If there is a", $ef, $ee, "world like that,", $fa, $f7
    db $ef, $ee, "we should all move", $ef, $ee, "there.", $f7
    db $f0

Message_0B_08::
    db $ea, "*: The items you", $f1
    db "find in other", $fa, $f7
    db $ef, $ee, "worlds vary from", $ef, $ee, "world to world.", $fa, $f7
    db $ef, $ee, "There must be", $ef, $ee, "worlds where I can", $fa, $f7
    db $ef, $ee, "find Sirloin on", $ef, $ee, "the ground!", $f7
    db $f0

Message_0B_09::
    db $ea, "*: Listen, even in", $f1
    db "other worlds, you", $fa, $f7
    db $ef, $ee, "can write in your", $ef, $ee, "Journal in safe", $fa, $f7
    db $ef, $ee, "locations.", $ef, $ee, "Did you know that?", $f7
    db $f0

Message_0B_0A::
    db $ea, "*: Bugs like me", $f1
    db "grow super-quick!", $fa, $f7
    db $ef, $ee, "But our growth", $ef, $ee, "limit is low", $a4, $fa, $f7
    db $ef, $ee, "If you breed us", $ef, $ee, "over generations,", $fa, $f7
    db $ef, $ee, "we'll be able to", $ef, $ee, "stick around more.", $f7
    db $f0

Message_0B_0B::
    db $ea, "*: Members of the", $f1
    db "dragon family,", $fa, $f7
    db $ef, $ee, "such as myself,", $ef, $ee, "are slow to grow.", $fa, $f7
    db $ef, $ee, "On the other hand,", $ef, $ee, "our growth limit", $fa, $f7
    db $ef, $ee, "happens to come", $ef, $ee, "quite late.", $fa, $f7
    db $ef, $ee, "We can accompany", $ef, $ee, "you for that much", $fa, $f7
    db $ef, $ee, "longer than other", $ef, $ee, "families.", $f7
    db $f0

Message_0B_0C::
    db $ea, "*: The master's", $f1
    db "battle plan alters", $fa, $f7
    db $ef, $ee, "the personalities", $ef, $ee, "of monsters.", $fa, $f7
    db $ef, $ee, "To avoid changing", $ef, $ee, "personality, order", $fa, $f7
    db $ef, $ee, "the monster to", $ef, $ee, "fight.", $fa, $f7
    db $ef, $ee, "If it's brave, it", $ef, $ee, "will behave as if", $fa, $f7
    db $ef, $ee, "it was ordered to", $ef, $ee, "Charge in battle.", $f7
    db $f0

Message_0B_0D::
    db $ea, "*: Hello, GreatLog's", $f1
    db "mighty hero!", $fa, $f7
    db $ef, $ee, "Are you leaving on", $ef, $ee, "another outing?", $fa, $f7
    db $ef, $ee, "The action is", $ef, $ee, "heating up in the", $fa, $f7
    db $ef, $ee, "Arena too.", $ef, $ee, "Go take a look!", $f7
    db $f0

Message_0B_0E::
    db $eb, "*: I'm beginning to", $f1
    db "feel that people", $fa, $f7
    db $ef, $ee, "are supported by", $ef, $ee, "all sorts of", $fa, $f7
    db $ef, $ee, "things, including", $ef, $ee, "monsters.", $f7
    db $f0

Message_0B_0F::
    db $eb, "*: Have you found", $f1
    db "another world that", $fa, $f7
    db $ef, $ee, "feels just right", $ef, $ee, "for you?", $fa, $f7
    db $ef, $ee, "There are many", $ef, $ee, "kinds of Magic", $fa, $f7
    db $ef, $ee, "Keys, so you can", $ef, $ee, "keep searching.", $f7
    db $f0

Message_0B_10::
    db $ea, "*: The rope in the", $f1
    db "farm takes you up", $fa, $f7
    db $ef, $ee, "to the highest", $ef, $ee, "part of GreatLog.", $fa, $f7
    db $ef, $ee, "It's supposed to", $ef, $ee, "be really quick.", $f7
    db $f0

Message_0B_11::
    db $ea, "*: When you're", $f1
    db "traveling, you can", $fa, $f7
    db $ef, $ee, "experience things", $ef, $ee, "that you would", $fa, $f7
    db $ef, $ee, "never see in", $ef, $ee, "everyday life.", $fa, $f7
    db $ef, $ee, "You appear to have", $ef, $ee, "experienced much.", $f7
    db $f0

Message_0B_12::
    db $ea, "*: A bard demanded", $f1
    db "to battle while", $fa, $f7
    db $ef, $ee, "I was in another", $ef, $ee, "world.", $fa, $f7
    db $ef, $ee, "I beat him as", $ef, $ee, "quick exercise.", $fa, $f7
    db $ef, $ee, "He gave me some", $ef, $ee, "amazing medicine.", $f7
    db $f0

Message_0B_13::
    db $ea, "*: I just happened", $f1
    db "to come across a", $fa, $f7
    db $ef, $ee, "casino ship in", $ef, $ee, "another world.", $fa, $f7
    db $ef, $ee, "We tried our luck", $ef, $ee, "at slot machines.", $f7
    db $f0

Message_0B_14::
    db $ea, "*: You know how to", $f1
    db "commune with", $fa, $f7
    db $ef, $ee, "monsters, I see.", $ef, $ee, "It's obvious that", $fa, $f7
    db $ef, $ee, "you've become a", $ef, $ee, "skilled master.", $f7
    db $f0

Message_0B_15::
    db $ea, "*: When master's", $f1
    db "shop starts making", $fa, $f7
    db $ef, $ee, "money, I", $44, " like to", $ef, $ee, "start my own shop.", $f7
    db $f0

Message_0B_16::
    db $ea, "*: I'm sorry. I was", $f1
    db "wrong about you.", $fa, $f7
    db $ef, $ee, "I hope my shop can", $ef, $ee, "serve your needs.", $fa, $f7
    db $ef, $ee, "May I please help", $ef, $ee, "you with anything?", $f7
    db $f0

Message_0B_17::
    db $ea, "*: Hello! How may I", $f1
    db "serve you today?", $f7
    db $f0

Message_0B_18::
    db $eb, "*: GreatLog's shops", $f1
    db "buy and sell items", $fa, $f7
    db $ef, $ee, "at lower sums than", $ef, $ee, "in other worlds.", $f7
    db $f0

Message_0B_19::
    db $eb, "*: Prince Kameha is", $f1
    db "in training to", $fa, $f7
    db $ef, $ee, "become a monster", $ef, $ee, "master.", $fa, $f7
    db $ef, $ee, "I think he'll get", $ef, $ee, "bored right away,", $fa, $f7
    db $ef, $ee, "and go back to his", $ef, $ee, "usual antics.", $f7
    db $f0

Message_0B_1A::
    db $eb, "*: I heard that", $f1
    db "you're the hero!", $fa, $f7
    db $ef, $ee, "I can't stop crying", $ef, $ee, "because I'm so", $fa, $f7
    db $ef, $ee, "impressed by what", $ef, $ee, "you did for us.", $f7
    db $f0

Message_0B_1B::
    db $eb, "*: The woman next", $f1
    db "to me cries a lot.", $fa, $f7
    db $ef, $ee, "She even cried", $ef, $ee, "when she won some", $fa, $f7
    db $ef, $ee, "trinket in a", $ef, $ee, "charity raffle.", $f7
    db $f0

Message_0B_1C::
    db $ea, "*: Hello, GreatLog's", $f1
    db "hero!", $fa, $f7
    db $ef, $ee, "Do you still go", $ef, $ee, "out on adventures?", $fa, $f7
    db $ef, $ee, "Thanks to you, my", $ef, $ee, "business remains.", $fa, $f7
    db $ef, $ee, "Anyway, what can I", $ef, $ee, "do for you today?", $f7
    db $f0

Message_0B_1D::
    db $ea, "*: If you have a", $f1
    db "lot of money, it", $fa, $f7
    db $ef, $ee, "is easier to", $ef, $ee, "travel.", $fa, $f7
    db $ef, $ee, "But if you get", $ef, $ee, "wiped out in", $fa, $f7
    db $ef, $ee, "battle, you lose", $ef, $ee, "more too.", $fa, $f7
    db $ef, $ee, "It's something to", $ef, $ee, "think about.", $f7
    db $f0

Message_0B_1E::
    db $ea, "*: You're GreatLog's", $f1
    db "savior!", $fa, $f7
    db $ef, $ee, "Do you need any", $ef, $ee, "keys appraised?", $f0

Message_0B_1F::
    db $ea, "*: My grandpa gave", $f1
    db "me a key, so I", $fa, $f7
    db $ef, $ee, "brought it here", $ef, $ee, "for appraisal.", $fa, $f7
    db $ef, $ee, "I hope it's for a", $ef, $ee, "world where I can", $fa, $f7
    db $ef, $ee, "see new monsters", $ef, $ee, "for a change.", $f7
    db $f0

Message_0B_20::
    db $eb, "*: Oh, the savior", $f1
    db "of GreatLog.", $fa, $f7
    db $ef, $ee, "I'm the Egg", $ef, $ee, "Evaluator.", $fa, $f7
    db $ef, $ee, "May I help you", $ef, $ee, "today?", $f7
    db $f0

Message_0B_21::
    db $ea, "*: Hello, hero!", $f1
    db "Let me help you!", $fa, $f7
    db $ef, $ee, "How would you like", $ef, $ee, "an egg? It's been", $fa, $f7
    db $ef, $ee, "certified by the", $ef, $ee, "Egg Evaluator.", $ff, $f0

Message_0B_22::
    db $ea, "*: You'll take it?", $f1
    db "Excellent!", $fa, $f7
    db $ef, $ee, "I'll send it to", $ef, $ee, "the farm.", $f7
    db $f0

Message_0B_23::
    db $ea, "*: Oh? But there's", $f1
    db "no room for it.", $f7
    db $f0

Message_0B_24::
    db $ea, "*: Oh", $a4, " Well, that's", $f1
    db "too bad, then.", $f7
    db $f0

Message_0B_25::
    db $ea, "*: The Evaluator's", $f1
    db "singing is magic.", $fa, $f7
    db $ef, $ee, "You should see how", $ef, $ee, "it affects an egg.", $f7
    db $f0

Message_0B_26::
    db $ea, "Warubou: Wa-hey!", $f1
    db "How are you?", $fa, $f7
    db $ef, $ee, "Still traveling in", $ef, $ee, "other worlds?", $fa, $f7
    db $ef, $ee, "You saved GreatLog", $ef, $ee, "from its crisis!", $f7
    db $f0

Message_0B_27::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0, wiped out?", $fa, $f7
    db $ef, $ee, "That isn't good at", $ef, $ee, "all for a master!", $fa, $f7
    db $ef, $ee, "I'm big-hearted so", $ef, $ee, "I'll share some of", $fa, $f7
    db $ef, $ee, "GreatLog's power", $ef, $ee, "with you, warooh!", $f7
    db $f0

Message_0B_28::
    db $ea, "Warubou: Wa-hey,", $f1
    db "I have a favor to", $fa, $f7
    db $ef, $ee, "ask of you as a", $ef, $ee, "monster master.", $fa, $f7
    db $ef, $ee, "My kid wants to", $ef, $ee, "travel, warooh.", $fa, $f7
    db $ef, $ee, "But I can't let my", $ef, $ee, "kid go alone.", $fa, $f7
    db $ef, $ee, "Maybe my kid can", $ef, $ee, "go with you?", $fa, $f7
    db $ef, $ee, "But no, you have", $ef, $ee, "no room left.", $f7
    db $f0

Message_0B_29::
    db $ea, "Warubou: Wa-hey,", $f1
    db "I have a favor to", $fa, $f7
    db $ef, $ee, "ask of you as a", $ef, $ee, "monster master.", $fa, $f7
    db $ef, $ee, "My kid wants to", $ef, $ee, "travel, warooh.", $fa, $f7
    db $ef, $ee, "But I can't let my", $ef, $ee, "kid go alone.", $fa, $f7
    db $ef, $ee, "Maybe my kid can", $ef, $ee, "go with you?", $ff, $f0

Message_0B_2A::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Good, good, good!", $fa, $f7
    db $ef, $ee, "I knew I could", $ef, $ee, "count on you!", $fa, $f7
    db $ef, $ee, "I knew I was right", $ef, $ee, "in picking you as", $fa, $f7
    db $ef, $ee, "a monster master,", $ef, $ee, "warooh!", $fa, $f7
    db $ef, $ee, "Wa-hey, Petibou", $ef, $ee, "come here!", $f7
    db $f0

Message_0B_2B::
    db $ea, "Petibou: What?", $f1
    db "This little kid?", $fa, $f7
    db $ef, $ee, "This is really a", $ef, $ee, "monster master?", $fa, $f7
    db $ef, $ee, "But Papa said, so", $ef, $ee, "I'll go with you.", $f7
    db $f0

Message_0B_2C::
    db $ea, "Warubou: Wa-hey,", $f1
    db "my kid has a big", $fa, $f7
    db $ef, $ee, "mouth, but Petibou", $ef, $ee, "will be useful.", $fa, $f7
    db $ef, $ee, "Petibou will be at", $ef, $ee, "the farm, warooh.", $fa, $f7
    db $ef, $ee, "Look after my", $ef, $ee, "Petibou good!", $f7
    db $f0

Message_0B_2D::
    db $ea, "Warubou: Wa-hey,", $f1
    db "the bond between", $fa, $f7
    db $ef, $ee, "human beings and", $ef, $ee, "monsters are much", $fa, $f7
    db $ef, $ee, "stronger than they", $ef, $ee, "ever were, warooh.", $fa, $f7
    db $ef, $ee, "I think you're to", $ef, $ee, "be thanked for it.", $fa, $f7
    db $ef, $ee, "GreatLog is out of", $ef, $ee, "danger too.", $f7
    db $f0

Message_0B_2E::
    db $ea, "*: Aren't you", $f1
    db "GreatLog's savior?", $fa, $f7
    db $ef, $ee, "Well, has breeding", $ef, $ee, "helped you?", $fa, $f7
    db $ef, $ee, "I hope I helped", $ef, $ee, "you in your quest.", $fa, $f7
    db $ef, $ee, "Anyway, what do", $ef, $ee, "you need of me?", $f7
    db $f0

Message_0B_2F::
    db $ea, "*: Ah, GreatLog's", $f1
    db "great hero!", $fa, $f7
    db $ef, $ee, "How would you like", $ef, $ee, "to take part in", $fa, $f7
    db $ef, $ee, "tournaments for", $ef, $ee, "battling monsters?", $f7
    db $f0

Message_0B_30::
    db $ea, "*: Well, well, it's", $f1
    db "GreatLog's savior!", $fa, $f7
    db $ef, $ee, "Masters of every", $ef, $ee, "sort gather in the", $fa, $f7
    db $ef, $ee, "Arena to test", $ef, $ee, "their mettle.", $fa, $f7
    db $ef, $ee, "You might talk to", $ef, $ee, "other masters.", $fa, $f7
    db $ef, $ee, "They could teach", $ef, $ee, "you things that", $fa, $f7
    db $ef, $ee, "you may not learn", $ef, $ee, "on your travels.", $f7
    db $f0

Message_0B_31::
    db $eb, "*: Make sure you're", $f1
    db "fully prepared for", $fa, $f7
    db $ef, $ee, "traveling in the", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "But I guess you", $ef, $ee, "know that already,", $fa, $f7
    db $ef, $ee, "being a prodigy as", $ef, $ee, "a master", $a4, $f7
    db $f0

Message_0B_32::
    db $ea, "*: Have you used", $f1
    db "the rope already?", $fa, $f7
    db $ef, $ee, "It's a quick climb", $ef, $ee, "to the treetop.", $f7
    db $f0

Message_0B_33::
    db $ea, "*: Papa is a famous", $f1
    db "monster master.", $fa, $f7
    db $ef, $ee, "You're famous too,", $ef, $ee, "but he'll beat you.", $fa, $f7
    db $ef, $ee, "I'm sure he will", $ef, $ee, "one day!", $f7
    db $f0

Message_0B_34::
    db $ea, "*: The girl next", $f1
    db "door?", $fa, $f7
    db $ef, $ee, "Well, we had our", $ef, $ee, "disagreements, but", $fa, $f7
    db $ef, $ee, "we discovered that", $ef, $ee, "our tastes match.", $fa, $f7
    db $ef, $ee, "So, uh, we're going", $ef, $ee, "to get married.", $f7
    db $f0

Message_0B_43::
    db $eb, "*: The way you", $f1
    db "saved GreatLog was", $fa, $f7
    db $ef, $ee, "a real inspiration", $ef, $ee, "to both of us.", $fa, $f7
    db $ef, $ee, "It brought us", $ef, $ee, "together in love.", $fa, $f7
    db $ef, $ee, "As our thanks, we", $ef, $ee, "want you to have", $fa, $f7
    db $ef, $ee, "an egg that our", $ef, $ee, "monsters laid.", $fa, $f7
    db $ef, $ee, "We'll send it to", $ef, $ee, "the farm for you.", $f7
    db $f0

Message_0B_44::
    db $eb, "*: The way you", $f1
    db "saved GreatLog was", $fa, $f7
    db $ef, $ee, "a real inspiration", $ef, $ee, "to both of us.", $fa, $f7
    db $ef, $ee, "It brought us", $ef, $ee, "together in love.", $fa, $f7
    db $ef, $ee, "As our thanks, we", $ef, $ee, "want you to have", $fa, $f7
    db $ef, $ee, "an egg that our", $ef, $ee, "monsters laid.", $fa, $f7
    db $ef, $ee, "Oh, but your farm", $ef, $ee, "is already full", $a4, $f7
    db $f0

Message_0B_45::
    db $eb, "*: Our monsters", $f1
    db "left on a journey.", $fa, $f7
    db $ef, $ee, "I hope they're", $ef, $ee, "doing well, and", $fa, $f7
    db $ef, $ee, "not squabbling", $ef, $ee, "with each other", $a4, $f7
    db $f0

Message_0B_46::
    db $ea, "*: My granddaughter", $f1
    db "became a master.", $fa, $f7
    db $ef, $ee, "She's found her", $ef, $ee, "own calling.", $fa, $f7
    db $ef, $ee, "I won't have to", $ef, $ee, "worry about her.", $f7
    db $f0

Message_0B_47::
    db $eb, "*: I became a", $f1
    db "master because I", $fa, $f7
    db $ef, $ee, "wanted to be like", $ef, $ee, "you.", $fa, $f7
    db $ef, $ee, "I've gotten pretty", $ef, $ee, "good too!", $fa, $f7
    db $ef, $ee, "Do you want battle", $ef, $ee, "to see how good?", $ff, $f0

Message_0B_48::
    db $ea, "*: My master has", $f1
    db "gotten good.", $fa, $f7
    db $ef, $ee, "You'll be surprised", $ef, $ee, "how good she is if", $fa, $f7
    db $ef, $ee, "you battle her at", $ef, $ee, "the Arena.", $f7
    db $f0

Message_0B_49::
    db $eb, "*: Hello, our young", $f1
    db "savior!", $fa, $f7
    db $ef, $ee, "Have you collected", $ef, $ee, "many monsters?", $fa, $f7
    db $ef, $ee, "I hope you'll keep", $ef, $ee, "working on your", $fa, $f7
    db $ef, $ee, "monster catalog to", $ef, $ee, "make it the best.", $fa, $f7
    db $ef, $ee, "Which family would", $ef, $ee, "you like to check?", $f7
    db $f0

Message_0B_4A::
    db $ea, "*: I", $44, " heard that", $f1
    db "you went on a", $fa, $f7
    db $ef, $ee, "quest to save", $ef, $ee, "GreatLog.", $fa, $f7
    db $ef, $ee, "I never expected", $ef, $ee, "someone so young", $fa, $f7
    db $ef, $ee, "would have the", $ef, $ee, "gumption to do it.", $fa, $f7
    db $ef, $ee, "Yes, I'm impressed", $ef, $ee, "all right!", $fa, $f7
    db $ef, $ee, "If you bring me a", $ef, $ee, "monster that could", $fa, $f7
    db $ef, $ee, "surprise me, I'll", $ef, $ee, "give you my key.", $fa, $f7
    db $ef, $ee, "I'll be waiting", $ef, $ee, "for you.", $f7
    db $f0

Message_0B_4B::
    db $ea, "*: Those monsters", $f1
    db "don't surprise me.", $fa, $f7
    db $ef, $ee, "Bring me something", $ef, $ee, "I've never seen.", $fa, $f7
    db $ef, $ee, "Otherwise, I won't", $ef, $ee, "give you my key.", $f7
    db $f0

Message_0B_4C::
    db $ea, "*: Oh! Goodness!", $f1
    db "I'm surprised!", $fa, $f7
    db $ef, $ee, "I've never seen a", $ef, $ee, "monster like that!", $fa, $f7
    db $ef, $ee, "I never knew of a", $ef, $ee, "Demon Lord like", $fa, $f7
    db $ef, $ee, "that! It's a new", $ef, $ee, "species to me!", $fa, $f7
    db $ef, $ee, "I'll have to give", $ef, $ee, "you my Magic Key!", $f7
    db $f0

Message_0B_4D::
    db $ea, "*: Obtain the other", $f1
    db "key that doesn't", $fa, $f7
    db $ef, $ee, "exist in this", $ef, $ee, "world.", $fa, $f7
    db $ef, $ee, "Overcome the two", $ef, $ee, "tests that the two", $fa, $f7
    db $ef, $ee, "keys present to", $ef, $ee, "you.", $fa, $f7
    db $ef, $ee, "If you succeed,", $ef, $ee, "and only then,", $fa, $f7
    db $ef, $ee, "I will give you", $ef, $ee, "one more key.", $f7
    db $f0

Message_0B_4E::
    db $f9, "0 obtained the", $f1
    db "Brawn Key.", $e5, $58, $f7
    db $e9, $ff, $f0

Message_0B_4F::
    db $f9, "0 found a", $f1
    db "Magic Key.", $fa, $f7
    db $ef, $ee, "But the key ring", $ef, $ee, "is full.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "Magic Key back.", $f7
    db $f0

Message_0B_50::
    db $ea, "*: Well, who would", $f1
    db "have thought such", $fa, $f7
    db $ef, $ee, "a youngster would", $ef, $ee, "save GreatLog!", $fa, $f7
    db $ef, $ee, "I thought you were", $ef, $ee, "different.", $fa, $f7
    db $ef, $ee, "Now I know you're", $ef, $ee, "something special.", $fa, $f7
    db $ef, $ee, "I'll ask you to", $ef, $ee, "keep searching for", $fa, $f7
    db $ef, $ee, "more of my beloved", $ef, $ee, "TinyMedals!", $f7
    db $f0

Message_0B_51::
    db $ea, "*: If you find even", $f1
    db "more TinyMedals,", $fa, $f7
    db $ef, $ee, "you can trade for", $ef, $ee, "rare monsters.", $f7
    db $f0

Message_0B_52::
    db $ea, "*: Ah, the savior", $f1
    db "of GreatLog!", $fa, $f7
    db $ef, $ee, "You're always", $ef, $ee, "welcome here.", $fa, $f7
    db $ef, $ee, "Skilled masters", $ef, $ee, "gather here.", $fa, $f7
    db $ef, $ee, "They may offer to", $ef, $ee, "breed monsters.", $fa, $f7
    db $ef, $ee, "Don't miss those", $ef, $ee, "opportunities!", $f7
    db $f0

Message_0B_53::
    db $eb, "*: Didn't you save", $f1
    db "GreatLog?", $fa, $f7
    db $ef, $ee, "That is so neat!", $ef, $ee, "How would you like", $fa, $f7
    db $ef, $ee, "to breed something", $ef, $ee, "with my FunkyBird?", $ff, $f0

Message_0B_54::
    db $eb, "*: Great! Let's", $f1
    db "give it a try!", $f7
    db $f0

Message_0B_55::
    db $eb, "*: Oh. Too bad.", $f1
    db "Maybe next time.", $fa, $f7
    db $ef, $ee, "I'll be here if you", $ef, $ee, "change your mind.", $f7
    db $f0

Message_0B_56::
    db $eb, "*: When you breed", $f1
    db "monsters with", $fa, $f7
    db $ef, $ee, "another master,", $ef, $ee, "your monster is", $fa, $f7
    db $ef, $ee, "designated the", $ef, $ee, "base species.", $fa, $f7
    db $ef, $ee, "So, each master is", $ef, $ee, "likely to end up", $fa, $f7
    db $ef, $ee, "with different", $ef, $ee, "kinds of babies.", $fa, $f7
    db $ef, $ee, "I hope something", $ef, $ee, "good will hatch", $fa, $f7
    db $ef, $ee, "from your egg and", $ef, $ee, "mine too!", $f7
    db $f0

Message_0B_57::
    db $ea, "*: Ah, you must be", $f1
    db "the little hero", $fa, $f7
    db $ef, $ee, "I keep hearing", $ef, $ee, "about?", $fa, $f7
    db $ef, $ee, "Would you care to", $ef, $ee, "breed a monster", $fa, $f7
    db $ef, $ee, "with my Copycat?", $ef, $ee, $ff, $f0

Message_0B_58::
    db $ea, "*: May good fortune", $f1
    db "arrive quickly.", $fa, $f7
    db $ef, $ee, "Please, may we", $ef, $ee, "begin?", $f7
    db $f0

Message_0B_59::
    db $ea, "*: May misfortune", $f1
    db "shun you.", $fa, $f7
    db $ef, $ee, "I'll await your", $ef, $ee, "reconsideration.", $f7
    db $f0

Message_0B_5A::
    db $ea, "*: Generations of", $f1
    db "breeding passes on", $fa, $f7
    db $ef, $ee, "skills and", $ef, $ee, "strengths.", $fa, $f7
    db $ef, $ee, "Though monsters", $ef, $ee, "may appear the", $fa, $f7
    db $ef, $ee, "same, breeding", $ef, $ee, "will alter their", $fa, $f7
    db $ef, $ee, "attributes for the", $ef, $ee, "better.", $f7
    db $f0

Message_0B_5B::
    db $eb, "*: I didn't think", $f1
    db "GreatLog's hero", $fa, $f7
    db $ef, $ee, "could be this", $ef, $ee, "young and tiny!", $fa, $f7
    db $ef, $ee, "Do you want to", $ef, $ee, "breed something", $fa, $f7
    db $ef, $ee, "with my Andreal?", $ef, $ee, $ff, $f0

Message_0B_5C::
    db $eb, "*: Well, no time to", $f1
    db "lose! Quick!", $f7
    db $f0

Message_0B_5D::
    db $eb, "*: Oh", $a4, " That's so", $f1
    db "disappointing.", $fa, $f7
    db $ef, $ee, "Well, come back if", $ef, $ee, "you reconsider.", $f7
    db $f0

Message_0B_5E::
    db $eb, "*: Put accessories", $f1
    db "on your monsters.", $fa, $f7
    db $ef, $ee, "They can really", $ef, $ee, "help!", $f7
    db $f0

Message_0B_5F::
    db $eb, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "For winning an S", $ef, $ee, "Class tournament,", $fa, $f7
    db $ef, $ee, "you're now a", $ef, $ee, "registered pro.", $fa, $f7
    db $ef, $ee, "You can choose", $ef, $ee, "Classes now.", $fa, $f7
    db $ef, $ee, "Just pay the entry", $ef, $ee, "fee and you can", $fa, $f7
    db $ef, $ee, "compete for your", $ef, $ee, "choice of prizes.", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "enter a tourny?", $f7
    db $f0

Message_0B_60::
    db $eb, "*: Welcome! Are you", $f1
    db "here to battle?", $f7
    db $f0

Message_0B_61::
    db $eb, "*: As a pro master,", $f1
    db "you can choose the", $fa, $f7
    db $ef, $ee, "Class for battle", $ef, $ee, "competition.", $fa, $f7
    db $ef, $ee, "Champs win Magic", $ef, $ee, "Keys and items.", $fa, $f7
    db $ef, $ee, "The rules are the", $ef, $ee, "same as before.", $fa, $f7
    db $ef, $ee, "You can't use any", $ef, $ee, "items in battle.", $fa, $f7
    db $ef, $ee, "And you forfeit if", $ef, $ee, "you flee.", $fa, $f7
    db $ef, $ee, "Put on good shows", $ef, $ee, "for the audience!", $f7
    db $f0

Message_0B_66::
    db $eb, "*: Oops, it's not", $f1
    db "your first time!", $fa, $f7
    db $ef, $ee, "Please excuse my", $ef, $ee, "rudeness, sweetie!", $f7
    db $f0

Message_0B_67::
    db $ea, "*: Listen, this is", $f1
    db "a secret.", $fa, $f7
    db $ef, $ee, "There's a man who", $ef, $ee, "trades TinyMedals", $fa, $f7
    db $ef, $ee, "for a MeteOrb.", $ef, $ee, $f7
    db $f0

Message_0B_68::
    db $eb, "*: Monsters that", $f1
    db "are caught at high", $fa, $f7
    db $ef, $ee, "levels tend to be", $ef, $ee, "very, very wild.", $fa, $f7
    db $ef, $ee, "Conversely, a baby", $ef, $ee, "is obedient.", $f7
    db $f0

Message_0B_69::
    db $ea, "*: When you're at", $f1
    db "the pro level, the", $fa, $f7
    db $ef, $ee, "competition is far", $ef, $ee, "tougher.", $fa, $f7
    db $ef, $ee, "You'll be wasting", $ef, $ee, "money if you don't", $fa, $f7
    db $ef, $ee, "battle within your", $ef, $ee, "party's abilities.", $f7
    db $f0

Message_0B_6A::
    db $ea, "*: Are you perhaps", $f1
    db "GreatLog's savior?", $fa, $f7
    db $ef, $ee, "Hey, how about", $ef, $ee, "breeding my", $fa, $f7
    db $ef, $ee, "Skeletor with one", $ef, $ee, "of your monsters?", $ff, $f0

Message_0B_6B::
    db $ea, "*: OK! Let the", $f1
    db "breeding happen!", $f7
    db $f0

Message_0B_6C::
    db $ea, "*: No? Well, if we", $f1
    db "meet again", $a4, $f7
    db $f0

Message_0B_6D::
    db $ea, "*: Breeding fire", $f1
    db "and ice together", $fa, $f7
    db $ef, $ee, "makes one tough", $ef, $ee, "monster.", $fa, $f7
    db $ef, $ee, "But, it's hard to", $ef, $ee, "get even one,", $fa, $f7
    db $ef, $ee, "never mind getting", $ef, $ee, "the other one.", $f7
    db $f0

Message_0B_6E::
    db $ea, "*: My frigid breath", $f1
    db "chills even souls.", $f7
    db $f0

Message_0B_6F::
    db $ea, "*: As I level up,", $f1
    db "my FrigidAir turns", $fa, $f7
    db $ef, $ee, "into the wickedly", $ef, $ee, "cold WhiteAir.", $f7
    db $f0

Message_0B_70::
    db $ea, "*: Hey! You're still", $f1
    db "at it, youngster?", $fa, $f7
    db $ef, $ee, "My StoneMan needs", $ef, $ee, "a monster as a", $fa, $f7
    db $ef, $ee, "breeding partner.", $ef, $ee, "Do you have one?", $ff, $f0

Message_0B_71::
    db $ea, "*: Great!", $f1
    db "Good answer!", $f7
    db $f0

Message_0B_72::
    db $ea, "*: That's too bad.", $f1
    db "It's a waste", $a4, $f7
    db $f0

Message_0B_73::
    db $ea, "*: Through breeding", $f1
    db "the number beside", $fa, $f7
    db $ef, $ee, "the species name", $ef, $ee, "goes up.", $fa, $f7
    db $ef, $ee, "That number will", $ef, $ee, "rise faster if you", $fa, $f7
    db $ef, $ee, "breed high level", $ef, $ee, "monsters together.", $f7
    db $f0

Message_0B_74::
    db $ea, "*: Some monsters", $f1
    db "may be tough, but", $fa, $f7
    db $ef, $ee, "they could have", $ef, $ee, "surprising weak", $fa, $f7
    db $ef, $ee, "spots that can be", $ef, $ee, "exploited.", $fa, $f7
    db $ef, $ee, "Skills and dances", $ef, $ee, "that cause status", $fa, $f7
    db $ef, $ee, "problems can come", $ef, $ee, "in very handy.", $f7
    db $f0

Message_0B_75::
    db $eb, "*: I've learned how", $f1
    db "to tell what my", $fa, $f7
    db $ef, $ee, "monsters are", $ef, $ee, "thinking.", $fa, $f7
    db $ef, $ee, $a4, "Oh! No, Grizo!", $ef, $ee, "That's not food!", $fa, $f7
    db $ef, $ee, "This is my friend!", $ef, $ee, "Not food, Grizo!", $f7
    db $f0

Message_0B_76::
    db $eb, "*: Have you become", $f1
    db "a pro master?", $fa, $f7
    db $ef, $ee, "You're more likely", $ef, $ee, "to win great", $fa, $f7
    db $ef, $ee, "prizes in the", $ef, $ee, "higher classes.", $f7
    db $f0

Message_0B_77::
    db $eb, "*: My Mama gets so", $f1
    db "ahead of herself", $a4, $fa, $f7
    db $ef, $ee, "I've only won the", $ef, $ee, "Kids' Class", $a4, $f7
    db $f0

Message_0B_78::
    db $eb

Message_0B_79::
    db $ea, "*: You have to pay", $f1
    db "an entry fee to", $fa, $f7
    db $ef, $ee, "compete in any pro", $ef, $ee, "tournament.", $fa, $f7
    db $ef, $ee, "It costs more for", $ef, $ee, "higher Classes.", $fa, $f7
    db $ef, $ee, "But you also win", $ef, $ee, "better prizes in", $fa, $f7
    db $ef, $ee, "the higher Classes", $ef, $ee, "too.", $f7
    db $f0

Message_0B_7A::
    db $ea, "*: I've never heard", $f1
    db "of a single master", $fa, $f7
    db $ef, $ee, "who struck it", $ef, $ee, "rich.", $fa, $f7
    db $ef, $ee, "Adventures cost a", $ef, $ee, "lot, I guess.", $f7
    db $f0

Message_0B_7B::
    db $ea, "King: Oh? It's our", $f1
    db "savior ", $f9, "0!", $fa, $f7
    db $ef, $ee, "Kameha has been in", $ef, $ee, "training to become", $fa, $f7
    db $ef, $ee, "a better master,", $ef, $ee, "he says.", $fa, $f7
    db $ef, $ee, "So he's been taking", $ef, $ee, "long journeys, and", $fa, $f7
    db $ef, $ee, "hardly ever comes", $ef, $ee, "home, the brat.", $f7
    db $f0

Message_0B_7C::
    db $ea, "King: Oh? It's our", $f1
    db "savior ", $f9, "0!", $fa, $f7
    db $ef, $ee, "What timing!", $ef, $ee, "I needed a favor.", $fa, $f7
    db $ef, $ee, "I heard of an evil", $ef, $ee, "master who uses", $fa, $f7
    db $ef, $ee, "monsters to carry", $ef, $ee, "out misdeeds.", $fa, $f7
    db $ef, $ee, "If you spot him in", $ef, $ee, "another world,", $fa, $f7
    db $ef, $ee, "could you capture", $ef, $ee, "him for us?", $ff, $f0

Message_0B_7D::
    db $ea, "King: You will?", $f1
    db "I knew I could", $fa, $f7
    db $ef, $ee, "count on the great", $ef, $ee, "hero of GreatLog!", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "merchant.", $fa, $f7
    db $ef, $ee, "He's greedy too.", $ef, $ee, "Be careful!", $f7
    db $f0

Message_0B_7E::
    db $ea, "King: You refuse", $f1
    db "my request?", $fa, $f7
    db $ef, $ee, "After all we've", $ef, $ee, "been through?", $f7
    db $f0

Message_0B_7F::
    db $ea, "King: There is an", $f1
    db "evil master who", $fa, $f7
    db $ef, $ee, "uses monsters for", $ef, $ee, "nefarious deeds.", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "merchant.", $fa, $f7
    db $ef, $ee, "He's greedy too.", $ef, $ee, "Be careful!", $f7
    db $f0

Message_0B_80::
    db $ea, "King: Ah, you've", $f1
    db "finally caught the", $fa, $f7
    db $ef, $ee, "evil wretch of a", $ef, $ee, "monster master.", $fa, $f7
    db $ef, $ee, "I knew I could", $ef, $ee, "count on the great", $fa, $f7
    db $ef, $ee, "hero of GreatLog!", $ef, $ee, "As sharp as ever!", $fa, $f7
    db $ef, $ee, "It's not much, but", $ef, $ee, "here's your reward.", $f7
    db $f0

Message_0B_81::
    db $f9, "0 received", $f1
    db "10,000G.", $f7
    db $f0

Message_0B_82::
    db $ea, "King: I was right", $f1
    db "to trust the great", $fa, $f7
    db $ef, $ee, "hero of GreatLog!", $ef, $ee, "As sharp as ever!", $fa, $f7
    db $ef, $ee, "If other criminal", $ef, $ee, "masters appear,", $fa, $f7
    db $ef, $ee, "I'll be sure to", $ef, $ee, "seek your help!", $f7
    db $f0

Message_0B_83::
    db $ea, "King: Oh? It's our", $f1
    db "savior ", $f9, "0!", $fa, $f7
    db $ef, $ee, "What fortuitous", $ef, $ee, "timing!", $fa, $f7
    db $ef, $ee, "I needed to ask", $ef, $ee, "for another favor.", $fa, $f7
    db $ef, $ee, "I heard of an evil", $ef, $ee, "master who uses", $fa, $f7
    db $ef, $ee, "monsters to carry", $ef, $ee, "out misdeeds.", $fa, $f7
    db $ef, $ee, "If you spot him in", $ef, $ee, "another world,", $fa, $f7
    db $ef, $ee, "could you capture", $ef, $ee, "him for us?", $ff, $f0

Message_0B_84::
    db $ea, "King: You will?", $f1
    db "I knew I could", $fa, $f7
    db $ef, $ee, "count on the great", $ef, $ee, "hero of GreatLog!", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "priest.", $fa, $f7
    db $ef, $ee, "He only targets", $ef, $ee, "the injured in", $fa, $f7
    db $ef, $ee, "battle.", $ef, $ee, "Be very cautious!", $f7
    db $f0

Message_0B_85::
    db $ea, "King: There is an", $f1
    db "evil master who", $fa, $f7
    db $ef, $ee, "uses monsters for", $ef, $ee, "nefarious deeds.", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "priest.", $fa, $f7
    db $ef, $ee, "He only targets", $ef, $ee, "the injured in", $fa, $f7
    db $ef, $ee, "battle.", $ef, $ee, "Be very cautious!", $f7
    db $f0

Message_0B_86::
    db $f9, "0 received", $f1
    db "20,000G.", $f7
    db $f0

Message_0B_87::
    db $ea, "King: You will?", $f1
    db "I knew I could", $fa, $f7
    db $ef, $ee, "count on the great", $ef, $ee, "hero of GreatLog!", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "mage.", $fa, $f7
    db $ef, $ee, "He targets those", $ef, $ee, "lacking magical", $fa, $f7
    db $ef, $ee, "power in battle.", $ef, $ee, "Beware of that!", $f7
    db $f0

Message_0B_88::
    db $ea, "King: There is an", $f1
    db "evil master who", $fa, $f7
    db $ef, $ee, "uses monsters for", $ef, $ee, "nefarious deeds.", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "mage.", $fa, $f7
    db $ef, $ee, "He targets those", $ef, $ee, "lacking magical", $fa, $f7
    db $ef, $ee, "power in battle.", $ef, $ee, "Beware of that!", $f7
    db $f0

Message_0B_89::
    db $f9, "0 received", $f1
    db "30,000G.", $f7
    db $f0

Message_0B_8A::
    db $ea, "King: You will?", $f1
    db "I knew I could", $fa, $f7
    db $ef, $ee, "count on the great", $ef, $ee, "hero of GreatLog!", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "warrior.", $fa, $f7
    db $ef, $ee, "He targets only", $ef, $ee, "low level monsters", $fa, $f7
    db $ef, $ee, "in battle.", $ef, $ee, "Be very wary!", $f7
    db $f0

Message_0B_8B::
    db $ea, "King: There is an", $f1
    db "evil master who", $fa, $f7
    db $ef, $ee, "uses monsters for", $ef, $ee, "nefarious deeds.", $fa, $f7
    db $ef, $ee, "He's dressed as a", $ef, $ee, "warrior.", $fa, $f7
    db $ef, $ee, "He targets only", $ef, $ee, "low level monsters", $fa, $f7
    db $ef, $ee, "in battle.", $ef, $ee, "Be very wary!", $f7
    db $f0

Message_0B_8C::
    db $f9, "0 received", $f1
    db "40,000G.", $f7
    db $f0

Message_0B_8D::
    db $ea, "King: I was right", $f1
    db "to trust the great", $fa, $f7
    db $ef, $ee, "hero of GreatLog!", $ef, $ee, "As sharp as ever!", $fa, $f7
    db $ef, $ee, "I can sleep well", $ef, $ee, "at night knowing", $fa, $f7
    db $ef, $ee, "that you are with", $ef, $ee, "us!", $f7
    db $f0

Message_0B_8E::
    db $ea, "*: It would be our", $f1
    db "Kingdom's shame if", $fa, $f7
    db $ef, $ee, "GreatLog's masters", $ef, $ee, "are criminally", $fa, $f7
    db $ef, $ee, "misbehaving in", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "Please bring them", $ef, $ee, "to justice here!", $f7
    db $f0

Message_0B_8F::
    db $ea, "Kameha: I've gone", $f1
    db "to other worlds", $fa, $f7
    db $ef, $ee, "and trained as a", $ef, $ee, "master.", $fa, $f7
    db $ef, $ee, $f9, "0, I've gone", $ef, $ee, "far beyond you!", $fa, $f7
    db $ef, $ee, "Want to battle me", $ef, $ee, "and see?", $ff, $f0
    db $f0
    ds $e7, $00
