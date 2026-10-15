; ROM bank $82: messages
; The annotated listing of this bank is build/listing/bank82.asm.

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
StringCategories_82::
; another name for the data at StringCategories_82, whose note is above (E-0381)
MessageStrings_Bank82::
    dw StringList_Bank82_0 ; id 0

; category list of StringCategories_82; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank82_0::
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
    db "<VOICE2>*: The weather is<LINE>"
    db "beautiful again.<PROMPT>"
    db "<NEXT>If you're going"
    db "<NEXT>out to play, take<PROMPT>"
    db "<NEXT>some monsters out"
    db "<NEXT>for exercise.<PROMPT>"
    db "<NEXT>They're unhappy"
    db "<NEXT>about being cooped<PROMPT>"
    db "<NEXT>up all the time."
    db "<NEXT>Be good to them!<WAIT>"
    db "@"

Message_0B_01::
    db "<VOICE1>*: You and your<LINE>"
    db "monsters saved<PROMPT>"
    db "<NEXT>GreatLog from a"
    db "<NEXT>terrible crisis.<PROMPT>"
    db "<NEXT>I'm proud of you,"
    db "<NEXT><BUF0>!<WAIT>"
    db "@"

Message_0B_02::
    db "<VOICE1>Cobi: <BUF0>, I<LINE>"
    db "envied you for<PROMPT>"
    db "<NEXT>being in other"
    db "<NEXT>worlds…<PROMPT>"
    db "<NEXT>But lately, I'm"
    db "<NEXT>finding the farm<PROMPT>"
    db "<NEXT>work to be a lot"
    db "<NEXT>of fun.<PROMPT>"
    db "<NEXT>Monsters respond"
    db "<NEXT>to your love.<PROMPT>"
    db "<NEXT>The better you"
    db "<NEXT>take care of them,<PROMPT>"
    db "<NEXT>the more they will"
    db "<NEXT>work for you.<PROMPT>"
    db "<NEXT>Anyway, what do"
    db "<NEXT>you need, sis?<WAIT>"
    db "@"

Message_0B_03::
    db "<VOICE2>Tara: <BUF0>, I was<LINE>"
    db "a little jealous<PROMPT>"
    db "<NEXT>of you at first,"
    db "<NEXT>but now I'm having<PROMPT>"
    db "<NEXT>fun working at the"
    db "<NEXT>farm.<PROMPT>"
    db "<NEXT>Treat them with"
    db "<NEXT>love and monsters<PROMPT>"
    db "<NEXT>will love you"
    db "<NEXT>back.<PROMPT>"
    db "<NEXT>Anyway, did you"
    db "<NEXT>need something?<WAIT>"
    db "@"

Message_0B_04::
    db "<VOICE1>*: I heard about a<LINE>"
    db "world of slime.<PROMPT>"
    db "<NEXT>Everywhere you go,"
    db "<NEXT>all you ever see<PROMPT>"
    db "<NEXT>are members of my"
    db "<NEXT>family!<WAIT>"
    db "@"

Message_0B_05::
    db "<VOICE1>*: This rope, it<LINE>"
    db "was not needed.<PROMPT>"
    db "<NEXT>But if I stretch"
    db "<NEXT>it more and more,<PROMPT>"
    db "<NEXT>perhaps it will"
    db "<NEXT>reach the clouds.<WAIT>"
    db "@"

Message_0B_06::
    db "<VOICE1>*: Many kinds of<LINE>"
    db "monsters result<PROMPT>"
    db "<NEXT>from breeding."
    db "<NEXT>For example, breed<PROMPT>"
    db "<NEXT>me with a beast"
    db "<NEXT>family mate, and<PROMPT>"
    db "<NEXT>you'll get a baby"
    db "<NEXT>FoxFire.<WAIT>"
    db "@"

Message_0B_07::
    db "<VOICE1>*: A world with<LINE>"
    db "lots of trees and<PROMPT>"
    db "<NEXT>water-that would"
    db "<NEXT>be the ultimate.<PROMPT>"
    db "<NEXT>If there is a"
    db "<NEXT>world like that,<PROMPT>"
    db "<NEXT>we should all move"
    db "<NEXT>there.<WAIT>"
    db "@"

Message_0B_08::
    db "<VOICE1>*: The items you<LINE>"
    db "find in other<PROMPT>"
    db "<NEXT>worlds vary from"
    db "<NEXT>world to world.<PROMPT>"
    db "<NEXT>There must be"
    db "<NEXT>worlds where I can<PROMPT>"
    db "<NEXT>find Sirloin on"
    db "<NEXT>the ground!<WAIT>"
    db "@"

Message_0B_09::
    db "<VOICE1>*: Listen, even in<LINE>"
    db "other worlds, you<PROMPT>"
    db "<NEXT>can write in your"
    db "<NEXT>Journal in safe<PROMPT>"
    db "<NEXT>locations."
    db "<NEXT>Did you know that?<WAIT>"
    db "@"

Message_0B_0A::
    db "<VOICE1>*: Bugs like me<LINE>"
    db "grow super-quick!<PROMPT>"
    db "<NEXT>But our growth"
    db "<NEXT>limit is low…<PROMPT>"
    db "<NEXT>If you breed us"
    db "<NEXT>over generations,<PROMPT>"
    db "<NEXT>we'll be able to"
    db "<NEXT>stick around more.<WAIT>"
    db "@"

Message_0B_0B::
    db "<VOICE1>*: Members of the<LINE>"
    db "dragon family,<PROMPT>"
    db "<NEXT>such as myself,"
    db "<NEXT>are slow to grow.<PROMPT>"
    db "<NEXT>On the other hand,"
    db "<NEXT>our growth limit<PROMPT>"
    db "<NEXT>happens to come"
    db "<NEXT>quite late.<PROMPT>"
    db "<NEXT>We can accompany"
    db "<NEXT>you for that much<PROMPT>"
    db "<NEXT>longer than other"
    db "<NEXT>families.<WAIT>"
    db "@"

Message_0B_0C::
    db "<VOICE1>*: The master's<LINE>"
    db "battle plan alters<PROMPT>"
    db "<NEXT>the personalities"
    db "<NEXT>of monsters.<PROMPT>"
    db "<NEXT>To avoid changing"
    db "<NEXT>personality, order<PROMPT>"
    db "<NEXT>the monster to"
    db "<NEXT>fight.<PROMPT>"
    db "<NEXT>If it's brave, it"
    db "<NEXT>will behave as if<PROMPT>"
    db "<NEXT>it was ordered to"
    db "<NEXT>Charge in battle.<WAIT>"
    db "@"

Message_0B_0D::
    db "<VOICE1>*: Hello, GreatLog's<LINE>"
    db "mighty hero!<PROMPT>"
    db "<NEXT>Are you leaving on"
    db "<NEXT>another outing?<PROMPT>"
    db "<NEXT>The action is"
    db "<NEXT>heating up in the<PROMPT>"
    db "<NEXT>Arena too."
    db "<NEXT>Go take a look!<WAIT>"
    db "@"

Message_0B_0E::
    db "<VOICE2>*: I'm beginning to<LINE>"
    db "feel that people<PROMPT>"
    db "<NEXT>are supported by"
    db "<NEXT>all sorts of<PROMPT>"
    db "<NEXT>things, including"
    db "<NEXT>monsters.<WAIT>"
    db "@"

Message_0B_0F::
    db "<VOICE2>*: Have you found<LINE>"
    db "another world that<PROMPT>"
    db "<NEXT>feels just right"
    db "<NEXT>for you?<PROMPT>"
    db "<NEXT>There are many"
    db "<NEXT>kinds of Magic<PROMPT>"
    db "<NEXT>Keys, so you can"
    db "<NEXT>keep searching.<WAIT>"
    db "@"

Message_0B_10::
    db "<VOICE1>*: The rope in the<LINE>"
    db "farm takes you up<PROMPT>"
    db "<NEXT>to the highest"
    db "<NEXT>part of GreatLog.<PROMPT>"
    db "<NEXT>It's supposed to"
    db "<NEXT>be really quick.<WAIT>"
    db "@"

Message_0B_11::
    db "<VOICE1>*: When you're<LINE>"
    db "traveling, you can<PROMPT>"
    db "<NEXT>experience things"
    db "<NEXT>that you would<PROMPT>"
    db "<NEXT>never see in"
    db "<NEXT>everyday life.<PROMPT>"
    db "<NEXT>You appear to have"
    db "<NEXT>experienced much.<WAIT>"
    db "@"

Message_0B_12::
    db "<VOICE1>*: A bard demanded<LINE>"
    db "to battle while<PROMPT>"
    db "<NEXT>I was in another"
    db "<NEXT>world.<PROMPT>"
    db "<NEXT>I beat him as"
    db "<NEXT>quick exercise.<PROMPT>"
    db "<NEXT>He gave me some"
    db "<NEXT>amazing medicine.<WAIT>"
    db "@"

Message_0B_13::
    db "<VOICE1>*: I just happened<LINE>"
    db "to come across a<PROMPT>"
    db "<NEXT>casino ship in"
    db "<NEXT>another world.<PROMPT>"
    db "<NEXT>We tried our luck"
    db "<NEXT>at slot machines.<WAIT>"
    db "@"

Message_0B_14::
    db "<VOICE1>*: You know how to<LINE>"
    db "commune with<PROMPT>"
    db "<NEXT>monsters, I see."
    db "<NEXT>It's obvious that<PROMPT>"
    db "<NEXT>you've become a"
    db "<NEXT>skilled master.<WAIT>"
    db "@"

Message_0B_15::
    db "<VOICE1>*: When master's<LINE>"
    db "shop starts making<PROMPT>"
    db "<NEXT>money, I", $44, " like to"
    db "<NEXT>start my own shop.<WAIT>"
    db "@"

Message_0B_16::
    db "<VOICE1>*: I'm sorry. I was<LINE>"
    db "wrong about you.<PROMPT>"
    db "<NEXT>I hope my shop can"
    db "<NEXT>serve your needs.<PROMPT>"
    db "<NEXT>May I please help"
    db "<NEXT>you with anything?<WAIT>"
    db "@"

Message_0B_17::
    db "<VOICE1>*: Hello! How may I<LINE>"
    db "serve you today?<WAIT>"
    db "@"

Message_0B_18::
    db "<VOICE2>*: GreatLog's shops<LINE>"
    db "buy and sell items<PROMPT>"
    db "<NEXT>at lower sums than"
    db "<NEXT>in other worlds.<WAIT>"
    db "@"

Message_0B_19::
    db "<VOICE2>*: Prince Kameha is<LINE>"
    db "in training to<PROMPT>"
    db "<NEXT>become a monster"
    db "<NEXT>master.<PROMPT>"
    db "<NEXT>I think he'll get"
    db "<NEXT>bored right away,<PROMPT>"
    db "<NEXT>and go back to his"
    db "<NEXT>usual antics.<WAIT>"
    db "@"

Message_0B_1A::
    db "<VOICE2>*: I heard that<LINE>"
    db "you're the hero!<PROMPT>"
    db "<NEXT>I can't stop crying"
    db "<NEXT>because I'm so<PROMPT>"
    db "<NEXT>impressed by what"
    db "<NEXT>you did for us.<WAIT>"
    db "@"

Message_0B_1B::
    db "<VOICE2>*: The woman next<LINE>"
    db "to me cries a lot.<PROMPT>"
    db "<NEXT>She even cried"
    db "<NEXT>when she won some<PROMPT>"
    db "<NEXT>trinket in a"
    db "<NEXT>charity raffle.<WAIT>"
    db "@"

Message_0B_1C::
    db "<VOICE1>*: Hello, GreatLog's<LINE>"
    db "hero!<PROMPT>"
    db "<NEXT>Do you still go"
    db "<NEXT>out on adventures?<PROMPT>"
    db "<NEXT>Thanks to you, my"
    db "<NEXT>business remains.<PROMPT>"
    db "<NEXT>Anyway, what can I"
    db "<NEXT>do for you today?<WAIT>"
    db "@"

Message_0B_1D::
    db "<VOICE1>*: If you have a<LINE>"
    db "lot of money, it<PROMPT>"
    db "<NEXT>is easier to"
    db "<NEXT>travel.<PROMPT>"
    db "<NEXT>But if you get"
    db "<NEXT>wiped out in<PROMPT>"
    db "<NEXT>battle, you lose"
    db "<NEXT>more too.<PROMPT>"
    db "<NEXT>It's something to"
    db "<NEXT>think about.<WAIT>"
    db "@"

Message_0B_1E::
    db "<VOICE1>*: You're GreatLog's<LINE>"
    db "savior!<PROMPT>"
    db "<NEXT>Do you need any"
    db "<NEXT>keys appraised?@"

Message_0B_1F::
    db "<VOICE1>*: My grandpa gave<LINE>"
    db "me a key, so I<PROMPT>"
    db "<NEXT>brought it here"
    db "<NEXT>for appraisal.<PROMPT>"
    db "<NEXT>I hope it's for a"
    db "<NEXT>world where I can<PROMPT>"
    db "<NEXT>see new monsters"
    db "<NEXT>for a change.<WAIT>"
    db "@"

Message_0B_20::
    db "<VOICE2>*: Oh, the savior<LINE>"
    db "of GreatLog.<PROMPT>"
    db "<NEXT>I'm the Egg"
    db "<NEXT>Evaluator.<PROMPT>"
    db "<NEXT>May I help you"
    db "<NEXT>today?<WAIT>"
    db "@"

Message_0B_21::
    db "<VOICE1>*: Hello, hero!<LINE>"
    db "Let me help you!<PROMPT>"
    db "<NEXT>How would you like"
    db "<NEXT>an egg? It's been<PROMPT>"
    db "<NEXT>certified by the"
    db "<NEXT>Egg Evaluator.<CHOICE>"
    db "@"

Message_0B_22::
    db "<VOICE1>*: You'll take it?<LINE>"
    db "Excellent!<PROMPT>"
    db "<NEXT>I'll send it to"
    db "<NEXT>the farm.<WAIT>"
    db "@"

Message_0B_23::
    db "<VOICE1>*: Oh? But there's<LINE>"
    db "no room for it.<WAIT>"
    db "@"

Message_0B_24::
    db "<VOICE1>*: Oh… Well, that's<LINE>"
    db "too bad, then.<WAIT>"
    db "@"

Message_0B_25::
    db "<VOICE1>*: The Evaluator's<LINE>"
    db "singing is magic.<PROMPT>"
    db "<NEXT>You should see how"
    db "<NEXT>it affects an egg.<WAIT>"
    db "@"

Message_0B_26::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "How are you?<PROMPT>"
    db "<NEXT>Still traveling in"
    db "<NEXT>other worlds?<PROMPT>"
    db "<NEXT>You saved GreatLog"
    db "<NEXT>from its crisis!<WAIT>"
    db "@"

Message_0B_27::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>, wiped out?<PROMPT>"
    db "<NEXT>That isn't good at"
    db "<NEXT>all for a master!<PROMPT>"
    db "<NEXT>I'm big-hearted so"
    db "<NEXT>I'll share some of<PROMPT>"
    db "<NEXT>GreatLog's power"
    db "<NEXT>with you, warooh!<WAIT>"
    db "@"

Message_0B_28::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "I have a favor to<PROMPT>"
    db "<NEXT>ask of you as a"
    db "<NEXT>monster master.<PROMPT>"
    db "<NEXT>My kid wants to"
    db "<NEXT>travel, warooh.<PROMPT>"
    db "<NEXT>But I can't let my"
    db "<NEXT>kid go alone.<PROMPT>"
    db "<NEXT>Maybe my kid can"
    db "<NEXT>go with you?<PROMPT>"
    db "<NEXT>But no, you have"
    db "<NEXT>no room left.<WAIT>"
    db "@"

Message_0B_29::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "I have a favor to<PROMPT>"
    db "<NEXT>ask of you as a"
    db "<NEXT>monster master.<PROMPT>"
    db "<NEXT>My kid wants to"
    db "<NEXT>travel, warooh.<PROMPT>"
    db "<NEXT>But I can't let my"
    db "<NEXT>kid go alone.<PROMPT>"
    db "<NEXT>Maybe my kid can"
    db "<NEXT>go with you?<CHOICE>"
    db "@"

Message_0B_2A::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Good, good, good!<PROMPT>"
    db "<NEXT>I knew I could"
    db "<NEXT>count on you!<PROMPT>"
    db "<NEXT>I knew I was right"
    db "<NEXT>in picking you as<PROMPT>"
    db "<NEXT>a monster master,"
    db "<NEXT>warooh!<PROMPT>"
    db "<NEXT>Wa-hey, Petibou"
    db "<NEXT>come here!<WAIT>"
    db "@"

Message_0B_2B::
    db "<VOICE1>Petibou: What?<LINE>"
    db "This little kid?<PROMPT>"
    db "<NEXT>This is really a"
    db "<NEXT>monster master?<PROMPT>"
    db "<NEXT>But Papa said, so"
    db "<NEXT>I'll go with you.<WAIT>"
    db "@"

Message_0B_2C::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "my kid has a big<PROMPT>"
    db "<NEXT>mouth, but Petibou"
    db "<NEXT>will be useful.<PROMPT>"
    db "<NEXT>Petibou will be at"
    db "<NEXT>the farm, warooh.<PROMPT>"
    db "<NEXT>Look after my"
    db "<NEXT>Petibou good!<WAIT>"
    db "@"

Message_0B_2D::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "the bond between<PROMPT>"
    db "<NEXT>human beings and"
    db "<NEXT>monsters are much<PROMPT>"
    db "<NEXT>stronger than they"
    db "<NEXT>ever were, warooh.<PROMPT>"
    db "<NEXT>I think you're to"
    db "<NEXT>be thanked for it.<PROMPT>"
    db "<NEXT>GreatLog is out of"
    db "<NEXT>danger too.<WAIT>"
    db "@"

Message_0B_2E::
    db "<VOICE1>*: Aren't you<LINE>"
    db "GreatLog's savior?<PROMPT>"
    db "<NEXT>Well, has breeding"
    db "<NEXT>helped you?<PROMPT>"
    db "<NEXT>I hope I helped"
    db "<NEXT>you in your quest.<PROMPT>"
    db "<NEXT>Anyway, what do"
    db "<NEXT>you need of me?<WAIT>"
    db "@"

Message_0B_2F::
    db "<VOICE1>*: Ah, GreatLog's<LINE>"
    db "great hero!<PROMPT>"
    db "<NEXT>How would you like"
    db "<NEXT>to take part in<PROMPT>"
    db "<NEXT>tournaments for"
    db "<NEXT>battling monsters?<WAIT>"
    db "@"

Message_0B_30::
    db "<VOICE1>*: Well, well, it's<LINE>"
    db "GreatLog's savior!<PROMPT>"
    db "<NEXT>Masters of every"
    db "<NEXT>sort gather in the<PROMPT>"
    db "<NEXT>Arena to test"
    db "<NEXT>their mettle.<PROMPT>"
    db "<NEXT>You might talk to"
    db "<NEXT>other masters.<PROMPT>"
    db "<NEXT>They could teach"
    db "<NEXT>you things that<PROMPT>"
    db "<NEXT>you may not learn"
    db "<NEXT>on your travels.<WAIT>"
    db "@"

Message_0B_31::
    db "<VOICE2>*: Make sure you're<LINE>"
    db "fully prepared for<PROMPT>"
    db "<NEXT>traveling in the"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>But I guess you"
    db "<NEXT>know that already,<PROMPT>"
    db "<NEXT>being a prodigy as"
    db "<NEXT>a master…<WAIT>"
    db "@"

Message_0B_32::
    db "<VOICE1>*: Have you used<LINE>"
    db "the rope already?<PROMPT>"
    db "<NEXT>It's a quick climb"
    db "<NEXT>to the treetop.<WAIT>"
    db "@"

Message_0B_33::
    db "<VOICE1>*: Papa is a famous<LINE>"
    db "monster master.<PROMPT>"
    db "<NEXT>You're famous too,"
    db "<NEXT>but he'll beat you.<PROMPT>"
    db "<NEXT>I'm sure he will"
    db "<NEXT>one day!<WAIT>"
    db "@"

Message_0B_34::
    db "<VOICE1>*: The girl next<LINE>"
    db "door?<PROMPT>"
    db "<NEXT>Well, we had our"
    db "<NEXT>disagreements, but<PROMPT>"
    db "<NEXT>we discovered that"
    db "<NEXT>our tastes match.<PROMPT>"
    db "<NEXT>So, uh, we're going"
    db "<NEXT>to get married.<WAIT>"
    db "@"

Message_0B_43::
    db "<VOICE2>*: The way you<LINE>"
    db "saved GreatLog was<PROMPT>"
    db "<NEXT>a real inspiration"
    db "<NEXT>to both of us.<PROMPT>"
    db "<NEXT>It brought us"
    db "<NEXT>together in love.<PROMPT>"
    db "<NEXT>As our thanks, we"
    db "<NEXT>want you to have<PROMPT>"
    db "<NEXT>an egg that our"
    db "<NEXT>monsters laid.<PROMPT>"
    db "<NEXT>We'll send it to"
    db "<NEXT>the farm for you.<WAIT>"
    db "@"

Message_0B_44::
    db "<VOICE2>*: The way you<LINE>"
    db "saved GreatLog was<PROMPT>"
    db "<NEXT>a real inspiration"
    db "<NEXT>to both of us.<PROMPT>"
    db "<NEXT>It brought us"
    db "<NEXT>together in love.<PROMPT>"
    db "<NEXT>As our thanks, we"
    db "<NEXT>want you to have<PROMPT>"
    db "<NEXT>an egg that our"
    db "<NEXT>monsters laid.<PROMPT>"
    db "<NEXT>Oh, but your farm"
    db "<NEXT>is already full…<WAIT>"
    db "@"

Message_0B_45::
    db "<VOICE2>*: Our monsters<LINE>"
    db "left on a journey.<PROMPT>"
    db "<NEXT>I hope they're"
    db "<NEXT>doing well, and<PROMPT>"
    db "<NEXT>not squabbling"
    db "<NEXT>with each other…<WAIT>"
    db "@"

Message_0B_46::
    db "<VOICE1>*: My granddaughter<LINE>"
    db "became a master.<PROMPT>"
    db "<NEXT>She's found her"
    db "<NEXT>own calling.<PROMPT>"
    db "<NEXT>I won't have to"
    db "<NEXT>worry about her.<WAIT>"
    db "@"

Message_0B_47::
    db "<VOICE2>*: I became a<LINE>"
    db "master because I<PROMPT>"
    db "<NEXT>wanted to be like"
    db "<NEXT>you.<PROMPT>"
    db "<NEXT>I've gotten pretty"
    db "<NEXT>good too!<PROMPT>"
    db "<NEXT>Do you want battle"
    db "<NEXT>to see how good?<CHOICE>"
    db "@"

Message_0B_48::
    db "<VOICE1>*: My master has<LINE>"
    db "gotten good.<PROMPT>"
    db "<NEXT>You'll be surprised"
    db "<NEXT>how good she is if<PROMPT>"
    db "<NEXT>you battle her at"
    db "<NEXT>the Arena.<WAIT>"
    db "@"

Message_0B_49::
    db "<VOICE2>*: Hello, our young<LINE>"
    db "savior!<PROMPT>"
    db "<NEXT>Have you collected"
    db "<NEXT>many monsters?<PROMPT>"
    db "<NEXT>I hope you'll keep"
    db "<NEXT>working on your<PROMPT>"
    db "<NEXT>monster catalog to"
    db "<NEXT>make it the best.<PROMPT>"
    db "<NEXT>Which family would"
    db "<NEXT>you like to check?<WAIT>"
    db "@"

Message_0B_4A::
    db "<VOICE1>*: I", $44, " heard that<LINE>"
    db "you went on a<PROMPT>"
    db "<NEXT>quest to save"
    db "<NEXT>GreatLog.<PROMPT>"
    db "<NEXT>I never expected"
    db "<NEXT>someone so young<PROMPT>"
    db "<NEXT>would have the"
    db "<NEXT>gumption to do it.<PROMPT>"
    db "<NEXT>Yes, I'm impressed"
    db "<NEXT>all right!<PROMPT>"
    db "<NEXT>If you bring me a"
    db "<NEXT>monster that could<PROMPT>"
    db "<NEXT>surprise me, I'll"
    db "<NEXT>give you my key.<PROMPT>"
    db "<NEXT>I'll be waiting"
    db "<NEXT>for you.<WAIT>"
    db "@"

Message_0B_4B::
    db "<VOICE1>*: Those monsters<LINE>"
    db "don't surprise me.<PROMPT>"
    db "<NEXT>Bring me something"
    db "<NEXT>I've never seen.<PROMPT>"
    db "<NEXT>Otherwise, I won't"
    db "<NEXT>give you my key.<WAIT>"
    db "@"

Message_0B_4C::
    db "<VOICE1>*: Oh! Goodness!<LINE>"
    db "I'm surprised!<PROMPT>"
    db "<NEXT>I've never seen a"
    db "<NEXT>monster like that!<PROMPT>"
    db "<NEXT>I never knew of a"
    db "<NEXT>Demon Lord like<PROMPT>"
    db "<NEXT>that! It's a new"
    db "<NEXT>species to me!<PROMPT>"
    db "<NEXT>I'll have to give"
    db "<NEXT>you my Magic Key!<WAIT>"
    db "@"

Message_0B_4D::
    db "<VOICE1>*: Obtain the other<LINE>"
    db "key that doesn't<PROMPT>"
    db "<NEXT>exist in this"
    db "<NEXT>world.<PROMPT>"
    db "<NEXT>Overcome the two"
    db "<NEXT>tests that the two<PROMPT>"
    db "<NEXT>keys present to"
    db "<NEXT>you.<PROMPT>"
    db "<NEXT>If you succeed,"
    db "<NEXT>and only then,<PROMPT>"
    db "<NEXT>I will give you"
    db "<NEXT>one more key.<WAIT>"
    db "@"

Message_0B_4E::
    db "<BUF0> obtained the<LINE>"
    db "Brawn Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_0B_4F::
    db "<BUF0> found a<LINE>"
    db "Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>is full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

Message_0B_50::
    db "<VOICE1>*: Well, who would<LINE>"
    db "have thought such<PROMPT>"
    db "<NEXT>a youngster would"
    db "<NEXT>save GreatLog!<PROMPT>"
    db "<NEXT>I thought you were"
    db "<NEXT>different.<PROMPT>"
    db "<NEXT>Now I know you're"
    db "<NEXT>something special.<PROMPT>"
    db "<NEXT>I'll ask you to"
    db "<NEXT>keep searching for<PROMPT>"
    db "<NEXT>more of my beloved"
    db "<NEXT>TinyMedals!<WAIT>"
    db "@"

Message_0B_51::
    db "<VOICE1>*: If you find even<LINE>"
    db "more TinyMedals,<PROMPT>"
    db "<NEXT>you can trade for"
    db "<NEXT>rare monsters.<WAIT>"
    db "@"

Message_0B_52::
    db "<VOICE1>*: Ah, the savior<LINE>"
    db "of GreatLog!<PROMPT>"
    db "<NEXT>You're always"
    db "<NEXT>welcome here.<PROMPT>"
    db "<NEXT>Skilled masters"
    db "<NEXT>gather here.<PROMPT>"
    db "<NEXT>They may offer to"
    db "<NEXT>breed monsters.<PROMPT>"
    db "<NEXT>Don't miss those"
    db "<NEXT>opportunities!<WAIT>"
    db "@"

Message_0B_53::
    db "<VOICE2>*: Didn't you save<LINE>"
    db "GreatLog?<PROMPT>"
    db "<NEXT>That is so neat!"
    db "<NEXT>How would you like<PROMPT>"
    db "<NEXT>to breed something"
    db "<NEXT>with my FunkyBird?<CHOICE>"
    db "@"

Message_0B_54::
    db "<VOICE2>*: Great! Let's<LINE>"
    db "give it a try!<WAIT>"
    db "@"

Message_0B_55::
    db "<VOICE2>*: Oh. Too bad.<LINE>"
    db "Maybe next time.<PROMPT>"
    db "<NEXT>I'll be here if you"
    db "<NEXT>change your mind.<WAIT>"
    db "@"

Message_0B_56::
    db "<VOICE2>*: When you breed<LINE>"
    db "monsters with<PROMPT>"
    db "<NEXT>another master,"
    db "<NEXT>your monster is<PROMPT>"
    db "<NEXT>designated the"
    db "<NEXT>base species.<PROMPT>"
    db "<NEXT>So, each master is"
    db "<NEXT>likely to end up<PROMPT>"
    db "<NEXT>with different"
    db "<NEXT>kinds of babies.<PROMPT>"
    db "<NEXT>I hope something"
    db "<NEXT>good will hatch<PROMPT>"
    db "<NEXT>from your egg and"
    db "<NEXT>mine too!<WAIT>"
    db "@"

Message_0B_57::
    db "<VOICE1>*: Ah, you must be<LINE>"
    db "the little hero<PROMPT>"
    db "<NEXT>I keep hearing"
    db "<NEXT>about?<PROMPT>"
    db "<NEXT>Would you care to"
    db "<NEXT>breed a monster<PROMPT>"
    db "<NEXT>with my Copycat?"
    db "<NEXT><CHOICE>"
    db "@"

Message_0B_58::
    db "<VOICE1>*: May good fortune<LINE>"
    db "arrive quickly.<PROMPT>"
    db "<NEXT>Please, may we"
    db "<NEXT>begin?<WAIT>"
    db "@"

Message_0B_59::
    db "<VOICE1>*: May misfortune<LINE>"
    db "shun you.<PROMPT>"
    db "<NEXT>I'll await your"
    db "<NEXT>reconsideration.<WAIT>"
    db "@"

Message_0B_5A::
    db "<VOICE1>*: Generations of<LINE>"
    db "breeding passes on<PROMPT>"
    db "<NEXT>skills and"
    db "<NEXT>strengths.<PROMPT>"
    db "<NEXT>Though monsters"
    db "<NEXT>may appear the<PROMPT>"
    db "<NEXT>same, breeding"
    db "<NEXT>will alter their<PROMPT>"
    db "<NEXT>attributes for the"
    db "<NEXT>better.<WAIT>"
    db "@"

Message_0B_5B::
    db "<VOICE2>*: I didn't think<LINE>"
    db "GreatLog's hero<PROMPT>"
    db "<NEXT>could be this"
    db "<NEXT>young and tiny!<PROMPT>"
    db "<NEXT>Do you want to"
    db "<NEXT>breed something<PROMPT>"
    db "<NEXT>with my Andreal?"
    db "<NEXT><CHOICE>"
    db "@"

Message_0B_5C::
    db "<VOICE2>*: Well, no time to<LINE>"
    db "lose! Quick!<WAIT>"
    db "@"

Message_0B_5D::
    db "<VOICE2>*: Oh… That's so<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>Well, come back if"
    db "<NEXT>you reconsider.<WAIT>"
    db "@"

Message_0B_5E::
    db "<VOICE2>*: Put accessories<LINE>"
    db "on your monsters.<PROMPT>"
    db "<NEXT>They can really"
    db "<NEXT>help!<WAIT>"
    db "@"

Message_0B_5F::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>For winning an S"
    db "<NEXT>Class tournament,<PROMPT>"
    db "<NEXT>you're now a"
    db "<NEXT>registered pro.<PROMPT>"
    db "<NEXT>You can choose"
    db "<NEXT>Classes now.<PROMPT>"
    db "<NEXT>Just pay the entry"
    db "<NEXT>fee and you can<PROMPT>"
    db "<NEXT>compete for your"
    db "<NEXT>choice of prizes.<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>enter a tourny?<WAIT>"
    db "@"

Message_0B_60::
    db "<VOICE2>*: Welcome! Are you<LINE>"
    db "here to battle?<WAIT>"
    db "@"

Message_0B_61::
    db "<VOICE2>*: As a pro master,<LINE>"
    db "you can choose the<PROMPT>"
    db "<NEXT>Class for battle"
    db "<NEXT>competition.<PROMPT>"
    db "<NEXT>Champs win Magic"
    db "<NEXT>Keys and items.<PROMPT>"
    db "<NEXT>The rules are the"
    db "<NEXT>same as before.<PROMPT>"
    db "<NEXT>You can't use any"
    db "<NEXT>items in battle.<PROMPT>"
    db "<NEXT>And you forfeit if"
    db "<NEXT>you flee.<PROMPT>"
    db "<NEXT>Put on good shows"
    db "<NEXT>for the audience!<WAIT>"
    db "@"

Message_0B_66::
    db "<VOICE2>*: Oops, it's not<LINE>"
    db "your first time!<PROMPT>"
    db "<NEXT>Please excuse my"
    db "<NEXT>rudeness, sweetie!<WAIT>"
    db "@"

Message_0B_67::
    db "<VOICE1>*: Listen, this is<LINE>"
    db "a secret.<PROMPT>"
    db "<NEXT>There's a man who"
    db "<NEXT>trades TinyMedals<PROMPT>"
    db "<NEXT>for a MeteOrb."
    db "<NEXT><WAIT>"
    db "@"

Message_0B_68::
    db "<VOICE2>*: Monsters that<LINE>"
    db "are caught at high<PROMPT>"
    db "<NEXT>levels tend to be"
    db "<NEXT>very, very wild.<PROMPT>"
    db "<NEXT>Conversely, a baby"
    db "<NEXT>is obedient.<WAIT>"
    db "@"

Message_0B_69::
    db "<VOICE1>*: When you're at<LINE>"
    db "the pro level, the<PROMPT>"
    db "<NEXT>competition is far"
    db "<NEXT>tougher.<PROMPT>"
    db "<NEXT>You'll be wasting"
    db "<NEXT>money if you don't<PROMPT>"
    db "<NEXT>battle within your"
    db "<NEXT>party's abilities.<WAIT>"
    db "@"

Message_0B_6A::
    db "<VOICE1>*: Are you perhaps<LINE>"
    db "GreatLog's savior?<PROMPT>"
    db "<NEXT>Hey, how about"
    db "<NEXT>breeding my<PROMPT>"
    db "<NEXT>Skeletor with one"
    db "<NEXT>of your monsters?<CHOICE>"
    db "@"

Message_0B_6B::
    db "<VOICE1>*: OK! Let the<LINE>"
    db "breeding happen!<WAIT>"
    db "@"

Message_0B_6C::
    db "<VOICE1>*: No? Well, if we<LINE>"
    db "meet again…<WAIT>"
    db "@"

Message_0B_6D::
    db "<VOICE1>*: Breeding fire<LINE>"
    db "and ice together<PROMPT>"
    db "<NEXT>makes one tough"
    db "<NEXT>monster.<PROMPT>"
    db "<NEXT>But, it's hard to"
    db "<NEXT>get even one,<PROMPT>"
    db "<NEXT>never mind getting"
    db "<NEXT>the other one.<WAIT>"
    db "@"

Message_0B_6E::
    db "<VOICE1>*: My frigid breath<LINE>"
    db "chills even souls.<WAIT>"
    db "@"

Message_0B_6F::
    db "<VOICE1>*: As I level up,<LINE>"
    db "my FrigidAir turns<PROMPT>"
    db "<NEXT>into the wickedly"
    db "<NEXT>cold WhiteAir.<WAIT>"
    db "@"

Message_0B_70::
    db "<VOICE1>*: Hey! You're still<LINE>"
    db "at it, youngster?<PROMPT>"
    db "<NEXT>My StoneMan needs"
    db "<NEXT>a monster as a<PROMPT>"
    db "<NEXT>breeding partner."
    db "<NEXT>Do you have one?<CHOICE>"
    db "@"

Message_0B_71::
    db "<VOICE1>*: Great!<LINE>"
    db "Good answer!<WAIT>"
    db "@"

Message_0B_72::
    db "<VOICE1>*: That's too bad.<LINE>"
    db "It's a waste…<WAIT>"
    db "@"

Message_0B_73::
    db "<VOICE1>*: Through breeding<LINE>"
    db "the number beside<PROMPT>"
    db "<NEXT>the species name"
    db "<NEXT>goes up.<PROMPT>"
    db "<NEXT>That number will"
    db "<NEXT>rise faster if you<PROMPT>"
    db "<NEXT>breed high level"
    db "<NEXT>monsters together.<WAIT>"
    db "@"

Message_0B_74::
    db "<VOICE1>*: Some monsters<LINE>"
    db "may be tough, but<PROMPT>"
    db "<NEXT>they could have"
    db "<NEXT>surprising weak<PROMPT>"
    db "<NEXT>spots that can be"
    db "<NEXT>exploited.<PROMPT>"
    db "<NEXT>Skills and dances"
    db "<NEXT>that cause status<PROMPT>"
    db "<NEXT>problems can come"
    db "<NEXT>in very handy.<WAIT>"
    db "@"

Message_0B_75::
    db "<VOICE2>*: I've learned how<LINE>"
    db "to tell what my<PROMPT>"
    db "<NEXT>monsters are"
    db "<NEXT>thinking.<PROMPT>"
    db "<NEXT>…Oh! No, Grizo!"
    db "<NEXT>That's not food!<PROMPT>"
    db "<NEXT>This is my friend!"
    db "<NEXT>Not food, Grizo!<WAIT>"
    db "@"

Message_0B_76::
    db "<VOICE2>*: Have you become<LINE>"
    db "a pro master?<PROMPT>"
    db "<NEXT>You're more likely"
    db "<NEXT>to win great<PROMPT>"
    db "<NEXT>prizes in the"
    db "<NEXT>higher classes.<WAIT>"
    db "@"

Message_0B_77::
    db "<VOICE2>*: My Mama gets so<LINE>"
    db "ahead of herself…<PROMPT>"
    db "<NEXT>I've only won the"
    db "<NEXT>Kids' Class…<WAIT>"
    db "@"

Message_0B_78::
    db $eb

Message_0B_79::
    db "<VOICE1>*: You have to pay<LINE>"
    db "an entry fee to<PROMPT>"
    db "<NEXT>compete in any pro"
    db "<NEXT>tournament.<PROMPT>"
    db "<NEXT>It costs more for"
    db "<NEXT>higher Classes.<PROMPT>"
    db "<NEXT>But you also win"
    db "<NEXT>better prizes in<PROMPT>"
    db "<NEXT>the higher Classes"
    db "<NEXT>too.<WAIT>"
    db "@"

Message_0B_7A::
    db "<VOICE1>*: I've never heard<LINE>"
    db "of a single master<PROMPT>"
    db "<NEXT>who struck it"
    db "<NEXT>rich.<PROMPT>"
    db "<NEXT>Adventures cost a"
    db "<NEXT>lot, I guess.<WAIT>"
    db "@"

Message_0B_7B::
    db "<VOICE1>King: Oh? It's our<LINE>"
    db "savior <BUF0>!<PROMPT>"
    db "<NEXT>Kameha has been in"
    db "<NEXT>training to become<PROMPT>"
    db "<NEXT>a better master,"
    db "<NEXT>he says.<PROMPT>"
    db "<NEXT>So he's been taking"
    db "<NEXT>long journeys, and<PROMPT>"
    db "<NEXT>hardly ever comes"
    db "<NEXT>home, the brat.<WAIT>"
    db "@"

Message_0B_7C::
    db "<VOICE1>King: Oh? It's our<LINE>"
    db "savior <BUF0>!<PROMPT>"
    db "<NEXT>What timing!"
    db "<NEXT>I needed a favor.<PROMPT>"
    db "<NEXT>I heard of an evil"
    db "<NEXT>master who uses<PROMPT>"
    db "<NEXT>monsters to carry"
    db "<NEXT>out misdeeds.<PROMPT>"
    db "<NEXT>If you spot him in"
    db "<NEXT>another world,<PROMPT>"
    db "<NEXT>could you capture"
    db "<NEXT>him for us?<CHOICE>"
    db "@"

Message_0B_7D::
    db "<VOICE1>King: You will?<LINE>"
    db "I knew I could<PROMPT>"
    db "<NEXT>count on the great"
    db "<NEXT>hero of GreatLog!<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>merchant.<PROMPT>"
    db "<NEXT>He's greedy too."
    db "<NEXT>Be careful!<WAIT>"
    db "@"

Message_0B_7E::
    db "<VOICE1>King: You refuse<LINE>"
    db "my request?<PROMPT>"
    db "<NEXT>After all we've"
    db "<NEXT>been through?<WAIT>"
    db "@"

Message_0B_7F::
    db "<VOICE1>King: There is an<LINE>"
    db "evil master who<PROMPT>"
    db "<NEXT>uses monsters for"
    db "<NEXT>nefarious deeds.<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>merchant.<PROMPT>"
    db "<NEXT>He's greedy too."
    db "<NEXT>Be careful!<WAIT>"
    db "@"

Message_0B_80::
    db "<VOICE1>King: Ah, you've<LINE>"
    db "finally caught the<PROMPT>"
    db "<NEXT>evil wretch of a"
    db "<NEXT>monster master.<PROMPT>"
    db "<NEXT>I knew I could"
    db "<NEXT>count on the great<PROMPT>"
    db "<NEXT>hero of GreatLog!"
    db "<NEXT>As sharp as ever!<PROMPT>"
    db "<NEXT>It's not much, but"
    db "<NEXT>here's your reward.<WAIT>"
    db "@"

Message_0B_81::
    db "<BUF0> received<LINE>"
    db "10,000G.<WAIT>"
    db "@"

Message_0B_82::
    db "<VOICE1>King: I was right<LINE>"
    db "to trust the great<PROMPT>"
    db "<NEXT>hero of GreatLog!"
    db "<NEXT>As sharp as ever!<PROMPT>"
    db "<NEXT>If other criminal"
    db "<NEXT>masters appear,<PROMPT>"
    db "<NEXT>I'll be sure to"
    db "<NEXT>seek your help!<WAIT>"
    db "@"

Message_0B_83::
    db "<VOICE1>King: Oh? It's our<LINE>"
    db "savior <BUF0>!<PROMPT>"
    db "<NEXT>What fortuitous"
    db "<NEXT>timing!<PROMPT>"
    db "<NEXT>I needed to ask"
    db "<NEXT>for another favor.<PROMPT>"
    db "<NEXT>I heard of an evil"
    db "<NEXT>master who uses<PROMPT>"
    db "<NEXT>monsters to carry"
    db "<NEXT>out misdeeds.<PROMPT>"
    db "<NEXT>If you spot him in"
    db "<NEXT>another world,<PROMPT>"
    db "<NEXT>could you capture"
    db "<NEXT>him for us?<CHOICE>"
    db "@"

Message_0B_84::
    db "<VOICE1>King: You will?<LINE>"
    db "I knew I could<PROMPT>"
    db "<NEXT>count on the great"
    db "<NEXT>hero of GreatLog!<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>priest.<PROMPT>"
    db "<NEXT>He only targets"
    db "<NEXT>the injured in<PROMPT>"
    db "<NEXT>battle."
    db "<NEXT>Be very cautious!<WAIT>"
    db "@"

Message_0B_85::
    db "<VOICE1>King: There is an<LINE>"
    db "evil master who<PROMPT>"
    db "<NEXT>uses monsters for"
    db "<NEXT>nefarious deeds.<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>priest.<PROMPT>"
    db "<NEXT>He only targets"
    db "<NEXT>the injured in<PROMPT>"
    db "<NEXT>battle."
    db "<NEXT>Be very cautious!<WAIT>"
    db "@"

Message_0B_86::
    db "<BUF0> received<LINE>"
    db "20,000G.<WAIT>"
    db "@"

Message_0B_87::
    db "<VOICE1>King: You will?<LINE>"
    db "I knew I could<PROMPT>"
    db "<NEXT>count on the great"
    db "<NEXT>hero of GreatLog!<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>mage.<PROMPT>"
    db "<NEXT>He targets those"
    db "<NEXT>lacking magical<PROMPT>"
    db "<NEXT>power in battle."
    db "<NEXT>Beware of that!<WAIT>"
    db "@"

Message_0B_88::
    db "<VOICE1>King: There is an<LINE>"
    db "evil master who<PROMPT>"
    db "<NEXT>uses monsters for"
    db "<NEXT>nefarious deeds.<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>mage.<PROMPT>"
    db "<NEXT>He targets those"
    db "<NEXT>lacking magical<PROMPT>"
    db "<NEXT>power in battle."
    db "<NEXT>Beware of that!<WAIT>"
    db "@"

Message_0B_89::
    db "<BUF0> received<LINE>"
    db "30,000G.<WAIT>"
    db "@"

Message_0B_8A::
    db "<VOICE1>King: You will?<LINE>"
    db "I knew I could<PROMPT>"
    db "<NEXT>count on the great"
    db "<NEXT>hero of GreatLog!<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>warrior.<PROMPT>"
    db "<NEXT>He targets only"
    db "<NEXT>low level monsters<PROMPT>"
    db "<NEXT>in battle."
    db "<NEXT>Be very wary!<WAIT>"
    db "@"

Message_0B_8B::
    db "<VOICE1>King: There is an<LINE>"
    db "evil master who<PROMPT>"
    db "<NEXT>uses monsters for"
    db "<NEXT>nefarious deeds.<PROMPT>"
    db "<NEXT>He's dressed as a"
    db "<NEXT>warrior.<PROMPT>"
    db "<NEXT>He targets only"
    db "<NEXT>low level monsters<PROMPT>"
    db "<NEXT>in battle."
    db "<NEXT>Be very wary!<WAIT>"
    db "@"

Message_0B_8C::
    db "<BUF0> received<LINE>"
    db "40,000G.<WAIT>"
    db "@"

Message_0B_8D::
    db "<VOICE1>King: I was right<LINE>"
    db "to trust the great<PROMPT>"
    db "<NEXT>hero of GreatLog!"
    db "<NEXT>As sharp as ever!<PROMPT>"
    db "<NEXT>I can sleep well"
    db "<NEXT>at night knowing<PROMPT>"
    db "<NEXT>that you are with"
    db "<NEXT>us!<WAIT>"
    db "@"

Message_0B_8E::
    db "<VOICE1>*: It would be our<LINE>"
    db "Kingdom's shame if<PROMPT>"
    db "<NEXT>GreatLog's masters"
    db "<NEXT>are criminally<PROMPT>"
    db "<NEXT>misbehaving in"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>Please bring them"
    db "<NEXT>to justice here!<WAIT>"
    db "@"

Message_0B_8F::
    db "<VOICE1>Kameha: I've gone<LINE>"
    db "to other worlds<PROMPT>"
    db "<NEXT>and trained as a"
    db "<NEXT>master.<PROMPT>"
    db "<NEXT><BUF0>, I've gone"
    db "<NEXT>far beyond you!<PROMPT>"
    db "<NEXT>Want to battle me"
    db "<NEXT>and see?<CHOICE>"
    db "@"
    db $f0
    ds $e7, $00
